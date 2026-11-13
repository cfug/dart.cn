---
# title: "Dart 2: Legacy of the `void`"
title: "Dart 2：`void` 的遗产"
# description: "One of the questions I see the most asked on StackOverflow, Gitter, and even Google-internal support channels is the difference between the…"
description: "我在 StackOverflow、Gitter 甚至 Google 内部支持渠道上看到最常问的问题之一，就是以下几个内置类型之间的区别……"
ai-translated: true
publishDate: 2018-08-30
author: matanlurey
image: images/1qGU6soDvCW0RFfDX8vpUow.webp
category: deep-dive
layout: blog
---


<DashImage src="images/1qGU6soDvCW0RFfDX8vpUow.webp" alt="Map of cosmic superclusters and voids, with the Boötes Void and other voids circled." caption="A semi-accurate depiction of the [universe](https://en.wikipedia.org/wiki/Bo%C3%B6tes_void) of void-like types in Dart 2" />


One of the questions I see the most asked on StackOverflow, Gitter, and even Google-internal support channels is the difference between the following built-in types in Dart 2: `Object`, `dynamic`, `void`, and `Null`.

我在 StackOverflow、Gitter 甚至 Google 内部支持渠道上
看到最常问的问题之一，就是 Dart 2 中以下几个内置类型的区别：
`Object`、`dynamic`、`void` 和 `Null`。

Long-story short, `Null` ([or `Bottom` in other languages](https://en.wikipedia.org/wiki/Bottom_type), i.e. “Nothing”) shouldn’t be used in most real user-code, and I suspect we’ll see more articles and lints in the near future to gently discourage usage.

长话短说，`Null`
（[其他语言中叫 `Bottom`](https://en.wikipedia.org/wiki/Bottom_type)，
即“空无”）不应该出现在大多数真实的用户代码里，
我猜不久的将来会看到更多文章和 lint 来温和地劝阻这种用法。

The rest of the three are not as clear, because something in Dart 2 anything can be `dynamic`, `Object`or `void`at runtime, varying only by the *static* type signature. So let’s look at a few practical examples of *when* you should use which type signature.

剩下三个就没那么清楚了，因为在 Dart 2 中，
任何东西在运行时都既可以是 `dynamic`，也可以是 `Object` 或 `void`，
区别只在于*静态*类型签名。
所以让我们看几个实际例子，看看*什么时候*该用哪种类型签名。

## Object

## Object 类型

[`Object`](https://api.dartlang.org/stable/2.0.0/dart-core/Object-class.html)is the root class of the Dart class hierarchy, and every other class in Dart is a sub-class of `Object` — including “primitive” types like `int`, `double`, or `bool`. It guarantees a few things: a [`hashCode`property](https://api.dartlang.org/stable/2.0.0/dart-core/Object/hashCode.html), an [`==`operator](https://api.dartlang.org/stable/2.0.0/dart-core/Object/operator_equals.html), a [`toString`method](https://api.dartlang.org/stable/2.0.0/dart-core/Object/toString.html).

[`Object`](https://api.dartlang.org/stable/2.0.0/dart-core/Object-class.html)
是 Dart 类层次结构的根类，Dart 中其他所有类都是 `Object` 的子类——
包括 `int`、`double`、`bool` 这样的“原始”类型。
它保证了几样东西：
[`hashCode` 属性](https://api.dartlang.org/stable/2.0.0/dart-core/Object/hashCode.html)、
[`==` 运算符](https://api.dartlang.org/stable/2.0.0/dart-core/Object/operator_equals.html)、
[`toString` 方法](https://api.dartlang.org/stable/2.0.0/dart-core/Object/toString.html)。

Practically speaking, I use `Object`like a poor man’s union type — expecting users to use the `is`operator to determine the real type of something before using it. **I don’t use `dynamic`**, because, as outlined in the next section, it disables important static analysis and more easily allows you to get into an invalid state.

实际上，我把 `Object` 当作穷人版的联合类型（union type）来用——
期望使用者先用 `is` 运算符确定某个东西的真实类型再使用它。
**我不用 `dynamic`**，因为正如下一节所述，
它会禁用重要的静态分析，让你更容易进入无效状态。

```
Object readProperty(String name) { ... }

void main() {
  var age = readProperty('name');
  if (age is int) {
    print('I am $age years old');
  } else if (age is String) {
    print(age);
  }
}
```


Another option is to use `Object` to declare you *don’t care* what the inner type of a data structure is, for example `List&lt;Object&gt;` might mean “a list of anything”. This comes in handy when, for example, writing a function that combines the `hashCode` of every element in a `List`:

另一种选择是用 `Object` 声明你*不在乎*数据结构的内部类型，
例如 `List&lt;Object&gt;` 可以表示“装任何东西的列表”。
这在某些场合很方便，比如写一个组合 `List` 中
每个元素的 `hashCode` 的函数：

```
int hashList(List<Object> elements) { ... }
```


A nice property of `Object`(compared with `dynamic`) is that you will get immediate analysis and compiler feedback if you try to call a method on it that doesn’t reliably exist. For example, the following produces a *static error*:

`Object`（相比 `dynamic`）的一个好处是，
如果你试图调用它上面并不确定存在的方法，
会立即得到分析和编译器的反馈。
例如，下面这段会产生一个*静态错误*：

```
void main() {
  Object a = 5;
  a.aMethodThatDoesNotExist();
}
```


In practice though, `Object` is fairly(and intentionally) limited. My hope is that [Dart will get support for method overloads](https://github.com/dart-lang/sdk/issues/26488) and that will allow me to dramatically decrease my usage of the `Object` type in real code.

不过在实践中，`Object` 相当（而且是有意地）受限。
我希望 [Dart 能支持方法重载](https://github.com/dart-lang/sdk/issues/26488)，
那将让我在真实代码中大幅减少 `Object` 类型的使用。

## dynamic

## dynamic 类型

I personally **never** use the `dynamic` type in Dart 2. From my perspective, it is sort of a union of `Object`and a special instruction that tells tools and compilers to *disable static analysis checks*. That is, the following is legal, and will only present an error at runtime (not statically!):

我个人在 Dart 2 中**从不**使用 `dynamic` 类型。
在我看来，它有点像 `Object` 加上一条特殊指令的结合体，
这条指令告诉工具和编译器*禁用静态分析检查*。
也就是说，下面是合法的，只会在运行时报错（而不是静态报错！）：

```
void main() {
  dynamic x = 5;
  x.aMethodThatDoesNotExist();
}
```


In Dart 1, `dynamic` was everywhere, and any other static type was for IDE and static analysis support — but the compiler (and runtime) treated everything as `dynamic`. There are still some unfortunate “gotchas” in Dart 2 that can *accidentally* create a `dynamic`-typed variable, though:

在 Dart 1 中，`dynamic` 无处不在，
其他任何静态类型都只是为 IDE 和静态分析服务——
但编译器（和运行时）把一切都当作 `dynamic`。
不过 Dart 2 中仍有一些不幸的“坑”，
会*意外*创建出 `dynamic` 类型的变量：

```
computeAge() => 5; // Return type is dynamic

void main() {
  var name; // Static type is dynamic
  var animals = []; // Static and runtime type is List<dynamic>
}
```


Worse yet, `dynamic` calls lose type information that is vital in Dart 2:

更糟的是，`dynamic` 调用会丢失在 Dart 2 中至关重要的类型信息：

```
class User {
  String name;
}

void main() {
  var users = []; // Implicitly List<dynamic>, remember?
  users.add(new User()..name = 'Matan');

  // Runtime error: List<dynamic> is not a Iterable<String>
  Iterable<String> names = users.map((u) => u.name);
}
```


The reason for this error is because the actual call here is:

这个错误的原因是，这里实际的调用是：

```
users.map((dynamic u) => u.name);
```


… which does not have enough static type information to produce a `Iterable&lt;String&gt;`. By fixing `users` to have the proper type (and avoiding dynamic calls), everything works:

……它没有足够的静态类型信息来产生 `Iterable&lt;String&gt;`。
把 `users` 修正为正确的类型（并避免动态调用）后，一切正常：

```
void main() {
  // We also could have written `var users = <User>[
  var users = [new User()..name = 'Matan'];

  // OK!
  Iterable<String> names = users.map((u) => u.name);
}
```


## void

## void 类型

Lastly, we have `void`, the newest type in Dart 2. In Dart 1 `void` was only usable as the return type of a function (such as `void main()`), but in Dart 2 it has been *generalized,* and is usable elsewhere, for example `Future&lt;void&gt;`.

最后是 `void`，Dart 2 中最新的类型。
在 Dart 1 中 `void` 只能用作函数的返回类型（比如 `void main()`），
但在 Dart 2 中它被*泛化*了，可以用在其他地方，
例如 `Future&lt;void&gt;`。

A `void` type is semantically similar to `Object`(it could be anything), except with additional restrictions — a `void` type cannot be used for anything (even `==` or `hashCode`), and it is invalid to assign something to a `void` type:

`void` 类型在语义上与 `Object` 类似（它可以是任何东西），
只是有额外的限制——`void` 类型的值不能用于任何操作
（连 `==` 或 `hashCode` 都不行），
而且把某个东西赋给 `void` 类型是无效的：

```
void foo() {}

void main() {
  var bar = foo(); // Invalid
}
```


In *practice,* I use `void` to mean “anything and I don’t care about the elements” or, more commonly, to mean “omitted”, such as in `Future&lt;void&gt;` or `Stream&lt;void&gt;`:

在*实践中*，我用 `void` 表示“任何东西，我不在乎其中的元素”，
或者更常见地表示“省略”，
比如 `Future&lt;void&gt;` 或 `Stream&lt;void&gt;`：

```
/// Clear the cache.
Future<void> purgeCache() { ... }
```


In the above code snippet, I don’t want users to try and use the return value of the provided `Future`, as it is not relevant. I’ve seen examples of using `Future&lt;Null&gt;`for this purpose, and that was actually a workaround *before* `Future&lt;void&gt;`was possible.

在上面的代码片段中，我不希望使用者去用这个 `Future` 的返回值，
因为它无关紧要。我见过用 `Future&lt;Null&gt;` 达到这个目的的例子，
那其实是在 `Future&lt;void&gt;` 可用*之前*的一种变通办法。

For example, this is statically OK, but at runtime is invalid in Dart 2:

例如，下面这段静态上没问题，但在 Dart 2 的运行时是无效的：

```
import 'dart:async';

Future<String> _doAThing() async => 'Test';
Future<Null> doAThing() async => _doAThing();

void main() async {
  // Future<String> is not a subtype of type FutureOr<Null>
  await doAThing();
}
```


… where as using `Future&lt;void&gt;`for `doAThing()`is valid and correct.

……而给 `doAThing()` 使用 `Future&lt;void&gt;` 则有效且正确。

Another example might be a `Stream` that fires without any event data:

另一个例子可能是一个不带任何事件数据就触发的 `Stream`：

```
/// Fires an event when a user signs-out of the system.
Stream<void> get onLogOut { ... }
```


Another more practical use is implementing a class with generic type arguments you won’t be using. For example, implementing the popular [`Visitor` pattern](https://en.wikipedia.org/wiki/Visitor_pattern), we can ignore the `C`(context) type argument when it isn’t used by passing `void`:

另一个更实际的用途是实现一个带有你不会用到的泛型类型参数的类。
例如，实现流行的 [`Visitor` 模式](https://en.wikipedia.org/wiki/Visitor_pattern)时，
如果 `C`（上下文）类型参数用不到，
可以传入 `void` 来忽略它：

```
abstract class Visitor<N, C> {
  N visitNode(N node, [C context]);
}

class IdentityVisitor<N> extends Visitor<N, void> {
  @override
  N visitNode(N node, [_]) => node;
}
```


I hope this brief article helps you with API decisions around using `Object`, `dynamic`, `void`. Leave comments if you have any other questions or ideas!

希望这篇短文能帮你在使用 `Object`、`dynamic`、`void` 时
做出 API 决策。如果你还有其他问题或想法，欢迎留言！
