---
title: Understanding null safety
title: 深入理解空安全
description: A deep dive into Dart language and library changes related to null safety.
description: 深入了解 Dart 语言及其依赖在空安全方面的改动。
---

_July 2020, Written by Bob Nystrom_

_文/ Bob Nystrom, Google Dart 团队工程师_

Null safety is the largest change we've made to Dart since we replaced the
original unsound optional type system with [a sound static type system][strong]
in Dart 2.0. When Dart first launched, compile-time null safety was a rare
feature needing a long introduction. Today, Kotlin, Swift, Rust, and other
languages all have their own answers to what has become a very [familiar
problem.][billion] Here is an example:

自 Dart 2.0 替换了静态可选类型系统为 [健全的静态类型系统][strong] 后，
空安全是我们对 Dart 作出最大的改变。
在 Dart 初始之际，编译时的空安全是一项少有且需要大量时间推进的功能。
时至今日，Kotlin、Swift、Rust 及众多语言都拥有他们自己的解决方案，
空安全已经成为 [屡见不鲜的话题][billion]。让我们来看下面这个例子：

[strong]: /guides/language/type-system
[billion]: https://www.infoq.com/presentations/Null-References-The-Billion-Dollar-Mistake-Tony-Hoare/

```dart
// Without null safety:
bool isEmpty(String string) => string.length == 0;

main() {
  isEmpty(null);
}
```

If you run this Dart program without null safety, it throws a
`NoSuchMethodError` exception on the call to `.length`. The `null` value is an
instance of the `Null` class, and `Null` has no "length" getter. Runtime
failures suck. This is especially true in a language like Dart that is designed
to run on an end-user's device. If a server application fails, you can often
restart it before anyone notices. But when a Flutter app crashes on a user's
phone, they are not happy. When your users aren't happy, you aren't happy.

如果您在运行这个 Dart 程序时并未使用空安全，
它将在调用 `.length` 时抛出 `NoSuchMethodError` 异常。
`null` 值是 `Null` 类的一个实例，而 `Null` 没有 "length" getter。
运行时才出现的错误十分恼人，在本就是为终端打造的 Dart 语言上尤其如此。
如果一个服务端应用出现了异常，您可以快速对它进行重启，而不被用户察觉。
但当一个 Flutter 应用在用户的手机上崩溃了，他们的体验就会大打折扣。
用户不开心，想必开发者也不会开心。

Developers like statically-typed languages like Dart because they enable the
type checker to find mistakes in code at compile time, usually right in the IDE.
The sooner you find a bug, the sooner you can fix it. When language designers
talk about "fixing null reference errors", they mean enriching the static type
checker so that the language can detect mistakes like the above attempt to call
`.length` on a value that might be `null`.

开发者偏爱像 Dart 这样的静态类型语言，
因为它通常可以让使用 IDE 的开发者通过类型检查发现错误。
Bug 越早被发现，就能越早处理。
当语言设计者在谈论“修复空引用错误”时，他们指的是加强静态类型检查器，
使得诸如在可能为 `null` 的值上调用 `.length` 这样的错误能被检测到。

There is no one true solution to this problem. Rust and Kotlin both have their
own approach that makes sense in the context of those languages. This doc walks
through all the details of our answer for Dart. It includes changes to the
static type system and a suite of other modifications and new language features
to let you not only write null-safe code but hopefully to *enjoy* doing so.

针对这个问题，从来没有一个标准答案。
Rust 和 Kotlin 在其语言内都各自拥有合理的解决方案。
这篇文档将带您了解 Dart 的解决方案。
它包含了对静态类型系统及诸多方面的修改，以及新的语言特性，
让您在编写代码时不仅能写出空安全的代码，同时也能非常**享受**。

This document is long. If you want something shorter that covers just what you
need to know to get up and running, start with the [overview][]. When you are
ready for a deeper understanding and have the time, come back here so you can
understand *how* the language handles `null`, *why* we designed it that way, and
how to write idiomatic, modern, null-safe Dart. (Spoiler alert: it ends up
surprisingly close to how you write Dart today.)

这篇文档很长。如果您只需要一份如何开始并运行的简短的文档，请从 [概览][overview] 开始。
当您认为您有充足的时间，且已经准备好深入理解它时，再回到这里，
彼时您可以了解到语言是**如何**处理 `null`、**为什么**我们会这样设计，
以及您如何写出符合现代习惯的空安全 Dart 代码。
（剧透一下：实际上它和您当前写 Dart 代码的方式相差无几。）

[overview]: /null-safety

The various ways a language can tackle null reference errors each have their
pros and cons. These principles guided the choices we made:

处理空引用错误的方法各有利弊。我们基于以下的原则做出选择：

*   **Code should be safe by default.** If you write new Dart code and don't use
    any explicitly unsafe features, it never throws a null reference error at
    runtime. All possible null reference errors are caught statically. If you
    want to defer some of that checking to runtime to get greater flexibility,
    you can, but you have to choose that by using some feature that is textually
    visible in the code.

    **代码在默认情况下是安全的。**
    如果您写的新代码中没有显式使用不安全的特性，运行时将不会有空引用错误抛出。
    所有潜在的空引用错误都将被静态捕获。
    如果您想为了灵活度而将某些检查放到运行时进行，当然不成问题，
    但您必须在代码中显式使用一些功能来达成您的目的。

    In other words, we aren't giving you a life jacket and leaving it up to you
    to remember to put it on every time you go out on the water. Instead, we
    give you a boat that doesn't sink. You stay dry unless you jump overboard.

    换句话说，我们并不是在您每次出海前给您一件救生衣，提醒您记得穿戴。
    相反，我们提供给您一艘不会沉的小船，只要您不跳下水里，就无事发生。

*   **Null safe code should be easy to write.** Most existing Dart code is
    dynamically correct and does not throw null reference errors. You like your
    Dart program the way it looks now, and we want you to be able to keep
    writing code that way. Safety shouldn't require sacrificing usability,
    paying penance to the type checker, or having to significantly change the
    way you think.

    **空安全的代码应可以轻松编写。**
    现有的大多数 Dart 代码都是动态正确的，并且不会抛出空引用错误。
    想必您非常喜欢现在您编写 Dart 代码的方式，
    我们也希望您可以继续使用这样的方式编写代码。
    安全性不应该要求易用性作出妥协、不应花更多时间耗费在类型检查器上，
    也不应使您显著改变您的思维方式。

*   **The resulting null safe code should be fully sound.** "Soundness" in the
    context of static checking means different things to different people. For
    us, in the context of null safety, that means that if an expression has a
    static type that does not permit `null`, then no possible execution of that
    expression can ever evaluate to `null`. The language provides this guarantee
    mostly through static checks, but there can be some runtime checks involved
    too. (Though, note the first principle: any place where those runtime checks
    happen will be your choice.)

    **产出的空安全代码应该是非常健全的。**
    对于静态检查而言，“健全”有着多层含义。
    而对我们来说，在空安全的上下文里，“健全”意味着如果一个表达式声明了一个
    不允许值为 `null` 的静态类型，那么这个表达式的任何执行结果都不可能为 `null`。
    Dart 语言主要通过静态检查来保证这项特性，但在运行时也有一些检查参与其中。
    （不过，根据第一条原则，在运行时何时何地进行检查，完全由您自己掌握。）

    Soundness is important for user confidence. A boat that *mostly* stays
    afloat is not one you're enthused to brave the open seas on. But it's also
    important for our intrepid compiler hackers. When the language makes hard
    guarantees about semantic properties of a program, it means that the
    compiler can perform optimizations that assume those properties are true.
    When it comes to `null`, it means we can generate smaller code that
    eliminates unneeded `null` checks, and faster code that doesn't need to
    verify a receiver is non-`null` before calling methods on it.

    代码的健全性极大程度地决定了开发者对于自己的代码是否有自信。
    一艘**大部分时间**都在飘忽不定的小船，
    是不足以让您鼓起勇气，驶往公海进行冒险的。
    这对于我们无畏的“黑客”编译器而言，同样十分重要。
    当语言对程序中语义化的属性做出硬性保证时，
    说明编译器能真正意义上为这些属性作出优化。
    当它涉及到 `null` 时，意味着可以消除不必要的 `null` 检查，提供更精悍的代码，
    并且在对其调用方法前，不需要再校验是否其为空调用。

    One caveat: We only guarantee soundness in Dart programs that are fully null
    safe. Dart supports programs that contain a mixture of newer null safe code
    and older legacy code. In these mixed-version programs, null reference errors
    may still occur. In a mixed-version program, you get all of the *static* safety
    benefits in the portions that are null safe, but you don't get full runtime
    soundness until the entire application is null safe.

    需要注意一点：目前我们只能完全保证使用了空安全的代码的健全性。
    Dart 程序支持新的空安全代码和旧的传统代码混合。
    在这些使用混合空安全的程序版本中，空引用的错误仍有可能出现。
    这类程序里让您可以在使用了空安全的部分，享受到所有**静态部分的**空安全福利。
    但在整个程序都使用了空安全之前，代码在运行时仍然不能保证是空安全的。

Note that *eliminating* `null` is not a goal. There's nothing wrong with `null`.
On the contrary, it's really useful to be able to represent the *absence* of a
value. Building support for a special "absent" value directly into the language
makes working with absence flexible and usable. It underpins optional
parameters, the handy `?.` null-aware operator, and default initialization. It
is not `null` that is bad, it is having `null` go *where you don't expect it*
that causes problems.

值得注意的是，我们的目标并不是**消除** `null`。`null` 没有任何错。
相反，可以表示一个**空缺**的值是十分有用的。
在语言中提供对空缺的值的支持，让处理空缺更为灵活和高效。
它为可选参数、`?.` 空调用语法糖和默认值初始化提供了基础。
`null` 并不糟糕，糟糕的是**它在您意想不到的地方出现**，最终引发问题。

Thus with null safety, our goal is to give you *control* and *insight* into
where `null` can flow through your program and certainty that it can't flow
somewhere that would cause a crash.

因此，对于空安全而言，我们的目标是让您对代码中的 `null` 可见且可控，
并且确保它不会传递至某些位置从而引发崩溃。

## Nullability in the type system

## 类型系统中的可空性

Null safety begins in the static type system because everything else rests upon
that. Your Dart program has a whole universe of types in it: primitive types
like `int` and `String`, collection types like `List`, and all of the classes
and types you and the packages you use define. Before null safety, the static
type system allowed the value `null` to flow into expressions of any of those
types.

因为一切均建立于静态类型系统上，所以空安全也始于此处。
您的 Dart 程序中包含了整个类型世界：基本类型（如 `int` 和 `String`）、
集合类型（如 `List`）以及您和您所使用的依赖所定义的类和类型。
在空安全推出之前，静态类型系统允许所有类型的表达式中的每一处都可以有 `null`。

In type theory lingo, the `Null` type was treated as a subtype of all types:

从类型理论的角度来说，`Null` 类型被看作是所有类型的子类；

<img src="understanding-null-safety/hierarchy-before.png" width="335">

The set of operations&mdash;getters, setters, methods, and
operators&mdash;allowed on some expression are defined by its type. If the type
is `List`, you can call `.add()` or `[]` on it. If it's `int`, you can call `+`.
But the `null` value doesn't define any of those methods. Allowing `null` to
flow into an expression of some other type means any of those operations can
fail. This is really the crux of null reference errors&mdash;every failure comes
from trying to look up a method or property on `null` that it doesn't have.

类型会定义一些操作对象，包括 getters、setters、方法和操作符，在表达式中使用。
如果是 `List` 类型，您可以对其调用 `.add()` 或 `[]`。
如果是 `int` 类型，您可以对其调用 `+`。 
但是 `null` 值并没有它们定义的任何一个方法。
所以当 `null` 传递至其他类型的表达式时，任何操作都有可能失败。
这就是空引用的症结所在&mdash;&mdash;所有错误都来源于尝试在 `null` 上查找一个不存在的方法或属性。

### Non-nullable and nullable types

### 非空和可空类型

Null safety eliminates that problem at the root by changing the type hierarchy.
The `Null` type still exists, but it's no longer a subtype of all types.
Instead, the type hierarchy looks like this:

空安全通过修改了类型的层级结构，从根源上解决了这个问题。
`Null` 类型仍然存在，但它不再是所有类型的子类。
现在的类型层级看起来是这样的：

<img src="understanding-null-safety/hierarchy-after.png" width="344">

Since `Null` is no longer a subtype, no type except the special `Null` class
permits the value `null`. We've made all types *non-nullable by default*. If you
have a variable of type `String`, it will always contain *a string*. There,
we've fixed all null reference errors.

既然 `Null` 已不再被看作所有类型的子类，
那么除了特殊的 `Null` 类型允许传递 `null` 值，其他类型均不允许。
我们已经将所有的类型设置为**默认不可空**的类型。
如果您的变量是 `String` 类型，它必须包含**一个字符串**。
这样一来，我们就修复了所有的空引用错误。

If we didn't think `null` was useful at all, we could stop here. But `null` is
useful, so we still need a way to handle it. Optional parameters are a good
illustrative case. Consider this null safe Dart code:

如果 `null` 对我们来说没有什么意义的话，那大可不必再研究下去了。
但实际上 `null` 十分有用，所以我们仍然需要合理地处理它。
可选参数就是非常好的例子。让我们来看下这段空安全的代码：

```dart
// Using null safety:
makeCoffee(String coffee, [String? dairy]) {
  if (dairy != null) {
    print('$coffee with $dairy');
  } else {
    print('Black $coffee');
  }
}
```

Here, we want to allow the `dairy` parameter to accept any string, or the value
`null`, but nothing else. To express that, we give `dairy` a *nullable type* by
slapping `?` at the end of the underlying base type `String`. Under the hood,
this is essentially defining a [union][] of the underlying type and the `Null`
type. So `String?` would be a shorthand for `String|Null` if Dart had
full-featured union types.

此处我们希望 `dairy` 参数能传入任意字符串，或者一个 `null` 值。
为了表达我们的想法，我们在原有类型 `String` 的尾部加上 `?` 使得 `dairy` 成为可空的类型。
本质上，这和定义了一个原有类型加 `Null` 的 [组合类型][union] 没有什么区别。
所以如果 Dart 包含完整的组合类型定义，那么 `String?` 就是 `String|Null` 的缩写。

[union]: https://en.wikipedia.org/wiki/Union_type

### Using nullable types

### 使用可空类型

If you have an expression with a nullable type, what can you do with the result?
Since our principle is safe by default, the answer is not much. We can't let you
call methods of the underlying type on it because those might fail if the value
is `null`:

如果您的表达式可能返回空值，您会如何处理它呢？
由于安全是我们的原则之一，答案其实所剩无几。
因为您在其值为 `null` 的时候调用方法将会失败，所以我们不会允许您这样做。

```dart
// Hypothetical unsound null safety:
bad(String? maybeString) {
  print(maybeString.length);
}

main() {
  bad(null);
}
```

This would crash if we let you run it. The only methods and properties we can
safely let you access are ones defined by both the underlying type and the
`Null` class. That's just `toString()`, `==`, and `hashCode`. So you can use
nullable types as map keys, store them in sets, compare them to other values,
and use them in string interpolation, but that's about it.

如果我们允许这样的代码运行，那么它将毫无疑问地崩溃。
我们只允许您访问同时在原有类型及 `Null` 类下同时定义的方法和属性。
所以只有 `toString()`、`==` 和 `hashCode` 可以访问。
因此，您可以将可空类型用于 Map 的键值、存储于集合中或者与其他值进行比较，仅此而已。

How do they interact with non-nullable types? It's always safe to pass a
*non*-nullable type to something expecting a nullable type. If a function
accepts `String?` then passing a `String` is allowed because it won't cause any
problems. We model this by making every nullable type a supertype of its
underlying type. You can also safely pass `null` to something expecting a nullable type, so
`Null` is also a subtype of every nullable type:

那么原有类型是如何与可空类型交互的呢？
我们知道，将一个**非**空类型的值传递给可空类型是一定安全的。
如果一个函数接受 `String?`，那么向其传递 `String` 是允许的，不会有任何问题。
在此次改动中，我们将所有的可空类型作为基础类型的子类。
您也可以将 `null` 传递给一个可空的类型，即 `Null` 也是任何可空类型的子类：

<img src="understanding-null-safety/nullable-hierarchy.png" width="235">

But going the other direction and passing a nullable type to something expecting
the underlying non-nullable type is unsafe. Code that expects a `String` may
call `String` methods on the value. If you pass a `String?` to it, `null` could
flow in and that could fail:

但将一个可空类型传递给非空的基础类型，是不安全的。
声明为 `String` 的变量可能会在您传递的值上调用 `String` 的方法。
如果您传递了 `String?`，传入的 `null` 将可能产生错误：

```dart
// Hypothetical unsound null safety:
requireStringNotNull(String definitelyString) {
  print(definitelyString.length);
}

main() {
  String? maybeString = null; // Or not!
  requireStringNotNull(maybeString);
}
```

This program is not safe and we shouldn't allow it. However, Dart has always had
this thing called *implicit downcasts*. If you, for example, pass a value of
type `Object` to a function expecting an `String`, the type checker allows it:

我们不会允许这样不安全的程序出现。
然而，**隐式转换**在 Dart 中一直存在。
假设您将类型为 `Object` 的实例传递给了需要 `String` 的函数，
类型检查器会允许您这样做：

```dart
// Without null safety:
requireStringNotObject(String definitelyString) {
  print(definitelyString.length);
}

main() {
  Object maybeString = 'it is';
  requireStringNotObject(maybeString);
}
```

To maintain soundness, the compiler silently inserts an `as String` cast on the
argument to `requireStringNotObject()`. That cast could fail and throw an
exception at runtime, but at compile time, Dart says this is OK. Since
non-nullable types are modeled as subtypes of nullable types, implicit downcasts
would let you pass a `String?` to something expecting a `String`. Allowing that
would violate our goal of being safe by default. So with null safety we are
removing implicit downcasts entirely.

为了保持健全性，编译器为 `requireStringNotObject()` 的参数
静默添加了 `as String` 强制转换。
在运行时进行转换可能会抛出异常，但在编译时，Dart 允许这样的操作。
在可空类型已经变为非空类型的子类的前提下，
隐式转换允许您给需要 `String` 的内容传递 `String?`。
这项来自隐式转换的允诺与我们的安全性目标不符。
所以在空安全推出之际，我们完全移除了隐式转换。

This makes the call to `requireStringNotNull()` produce a compile error, which
is what you want. But it also means *all* implicit downcasts become compile
errors, including the call to `requireStringNotObject()`. You'll have to add the
explicit downcast yourself:

这会让 `requireStringNotNull()` 的调用产生您预料中的编译错误。
同时也意味着，类似 `requireStringNotObject()` 这样的
**所有**隐式转换调用都变成了编译错误。
您需要自己添加显式类型转换：

```dart
// Using null safety:
requireStringNotObject(String definitelyString) {
  print(definitelyString.length);
}

main() {
  Object maybeString = 'it is';
  requireStringNotObject(maybeString as String);
}
```

We think this is an overall good change. Our impression is that most users never
liked implicit downcasts. In particular, you may have been burned by this
before:

总的来说，我们认为这是项非常好的改动。
在我们的印象中，大部分用户非常厌恶隐式转换。
您可能已经遭受过它的摧残：

```dart
// Without null safety:
List<int> filterEvens(List<int> ints) {
  return ints.where((n) => n.isEven);
}
```

Spot the bug? The `.where()` method is lazy, so it returns an `Iterable`, not a
`List`. This program compiles but then throws an exception at runtime when it
tries to cast that `Iterable` to the `List` type that `filterEvens` declares it
returns. With the removal of implicit downcasts, this becomes a compile error.

看出问题了吗？`.where()` 方法是懒加载的，所以它返回了一个 `Iterable` 而非 `List`。
这段代码会正常编译，但会在运行时抛出一个异常，提示您在对 `Iterable` 进行
转换为 `filterEvens` 声明的返回类型 `List` 时遇到了错误。
在隐式转换移除后，这就变成了一个编译错误。

Where were we? Right, OK, so it's as if we've taken the universe of types in
your program and split them into two halves:

（我是谁我在哪？刚刚说到哪了？）
所以正如我们在类型世界中将所有类型拆分成两半一样：

<img src="understanding-null-safety/bifurcate.png" width="668">

There is a region of non-nullable types. Those types let you access all of the
interesting methods, but can never ever contain `null`. And then there is a
parallel family of all of the corresponding nullable types. Those permit `null`,
but you can't do much with them. We let values flow from the non-nullable side
to the nullable side because doing so is safe, but not the other direction.

此处有一个非空类型的区域划分。该区域中的类型能访问到您想要的所有方法，但不能包含 `null`。
接着有一个对应并行的可空类型家族。它们允许出现 `null`，但您并没有太多操作空间。
让值从非空的一侧走向可空的一侧是安全的，但反之则不是。

That seems like nullable types are basically useless. They have no methods and
you can't get away from them. Don't worry, we have a whole suite of features to
help you move values from the nullable half over to the other side that we will
get to soon.

这么看来，可空类型基本宣告毫无作用了。
它们不包含任何方法，但是您又无法摆脱它们。
别担心，接下来我们有一整套的方法来帮助您把值从可空的一半转移到另一半。

### Top and bottom

### 顶层及底层

This section is a little esoteric. You can mostly skip it, except for two
bullets at the very end, unless you're into type system stuff. Imagine all the
types in your program with edges between ones that are subtypes and supertypes
of each other. If you were to draw it, like the diagrams in this doc, it would
form a huge directed graph with supertypes like `Object` near the top and leaf
classes like your own types near the bottom.

这一节会略微深奥。
除非您对类型系统非常感兴趣，否则您可以直接跳过这一节，并且在本文最后部分，还有两项有趣的内容。
想象一下，在您的程序里，所有的类型都互为子类或超类。
如果将它们的关系用画图表示出来，就像文中的那些图一样，那将会是一幅巨大的有向图，
诸如 `Object` 的超类会在顶层，子类在底层。

If that directed graph comes to a point at the top where there is a single type
that is the supertype (directly or indirectly), that type is called the *top
type*. Likewise, if there is a weird type at that bottom that is a subtype of
every type, you have a *bottom type*. (In this case, your directed graph is a
[lattice.][lattice])

如果这张有向图的顶部有是一个单一的超类（直接或间接），那么这个类型称为**顶层类型**。
类似的，如果有一个在底部有一个奇怪的类型，是所有类型的子类，这个类型就被称为**底层类型**。
（在这个情况下，您的有向图是一种 [偏序集合 (lattice)][lattice]）

[lattice]: https://en.wikipedia.org/wiki/Lattice_(order)

It's convenient if your type system has a top and bottom type, because it means
that type-level operations like least upper bound (which type inference uses to
figure out the type of a conditional expression based on the types of its two
branches) can always produce a type. Before null safety, `Object` was Dart's top
type and `Null` was its bottom type.

如果类型系统中有顶层和底层类型，将给我们带来一定程度的便利，
因为它意味着像最小上界这样类型层面的操作
（类型推理常根据一个条件表达式的两个分支推导出一个类型）
一定能推导出一个类型。
在空安全引入以前，Dart 中的顶层类型是 `Object`，底层类型是 `Null`。

Since `Object` is non-nullable now, it is no longer a top type. `Null` is not a
subtype of it. Dart has no *named* top type. If you need a top type, you want
`Object?`. Likewise, `Null` is no longer the bottom type. If it was, everything
would still be nullable. Instead, we've added a new bottom type named `Never`:

由于现在 `Object` 不再可空，所以它不再是一个顶层类型了。`Null` 也不再是它的子类。
Dart 中没有**令人熟知的**顶层类型。如果您需要一个顶层类型，可以用 `Object?`。
同样的，`Null` 也不再是底层类型，否则所有类型都仍将是可空。
取而代之是一个全新的底层类型 `Never`：

<img src="understanding-null-safety/top-and-bottom.png" width="360">

In practice, this means:

依据实际开发中的经验，这意味着：

*   If you want to indicate that you allow a value of any type, use `Object?`
    instead of `Object`. In fact, it becomes pretty unusual to use `Object`
    since that type means "could be any possible value except this one weirdly
    prohibited value `null`".

    如果您想表明让一个值可以接受任意类型，请用 `Object?` 而不是 `Object`。
    使用 `Object` 后会使得代码的行为变得非常诡异，
    因为它意味着能够是“除了 `null` 以外的任何实例”。

*   On the rare occasion that you need a bottom type, use `Never` instead of
    `Null`. If you don't know if you need a bottom type, you probably don't.

    在极少数需要底层类型的情况下，请使用 `Never` 代替 `Null`。
    如果您不了解是否需要一个底层类型，那么您基本上不会需要它。

## Ensuring correctness

## 确保正确性

We divided the universe of types into nullable and non-nullable halves. In order
to maintain soundness and our principle that you can never get a null reference
error at runtime unless you ask for it, we need to guarantee that `null` never
appears in any type on the non-nullable side.

我们将类型世界划分为了非空和可空的两半。
为了保持代码的健全和我们的原则：“除非您需要，否则您永远不会在运行时遇到空引用错误”，
我们需要保证 `null` 不会出现在非空一侧的任何类型里。

Getting rid of implicit downcasts and removing `Null` as a bottom type covers
all of the main places that types flow through a program across assigments and
from arguments into parameters on function calls. The main remaining places
where `null` can sneak in are when a variable first comes into being and when
you leave a function. So there are some additional compile errors:

通过取代了隐式转换，并且不再将 `Null` 作为底层类型，
我们覆盖了程序中声明、函数参数和函数调用等所有的主要位置。
现在只有当变量首次出现和您跳出函数的时候，`null` 可以悄悄潜入。
所以我们还会看到一些附加的编译错误：

### Invalid returns

### 无效的返回值

If a function has a non-nullable return type, then every path through the
function must reach a `return` statement that returns a value. Before null
safety, Dart was pretty lax about missing returns. For example:

如果一个函数的返回类型非空，那么函数内最终一定要调用 `return` 返回一个值。
在空安全引入以前，Dart 在限制未返回内容的函数时非常松懈。举个例子：

```dart
// Without null safety:
String missingReturn() {
  // No return.
}
```

If you analyzed this, you got a gentle *hint* that *maybe* you forgot a return,
but if not, no big deal. That's because if execution reaches the end of a
function body then Dart implicitly returns `null`. Since every type is nullable,
*technically* this function is safe, even though it's probably not what you
want.

如果分析器检查了这个函数，您会看到一个轻微的**提示**，提醒您**可能**忘记返回值，
但不返回也无关紧要。
这是因为代码执行到最后时，Dart 会隐式返回一个 `null`。
因为所有的类型都是可空的，所以**从代码层面而言**，这个函数是安全的，尽管它并不一定与您预期相符。

With sound non-nullable types, this program is flat out wrong and unsafe. Under
null safety, you get a compile error if a function with a non-nullable return
type doesn't reliably return a value. By "reliably", I mean that the language
analyzes all of the control flow paths through the function. As long as they all
return something, it is satisfied. The analysis is pretty smart, so even this
function is OK:

有了确定的非空类型，这段程序就是错误且不安全的。
在空安全下，如果一个返回值为非空类型的函数，没有可靠地返回一个值，您就会看到编译错误。
这里所提到的“可靠”，指的是分析器会分析函数中所有的控制流。
只要它们都返回了内容，就满足了条件。
分析器相当聪明，聪明到下面的代码也能应付：

```dart
// Using null safety:
String alwaysReturns(int n) {
  if (n == 0) {
    return 'zero';
  } else if (n < 0) {
    throw ArgumentError('Negative values not allowed.');
  } else {
    if (n > 1000) {
      return 'big';
    } else {
      return n.toString();
    }
  }
}
```

We'll dive more deeply into the new flow analysis in the next section.

下个章节我们会更加深入地了解新的流程分析。

### Uninitialized variables

### 未初始化的变量

When you declare a variable, if you don't give it an explicit initializer, Dart
default initializes the variable with `null`. That's convenient, but obviously
totally unsafe if the variable's type is non-nullable. So we have to tighten
things up for non-nullable variables:

当您在声明变量时，如果没有传递一个显式的初始化内容，Dart 默认会将变量初始化为 `null`。
这的确非常方便，但在变量可空的情况下，明显非常不安全。
所以，我们需要加强对非空变量的处理：

*   **Top level variable and static field declarations must have an
    initializer.** Since these can be accessed and assigned from anywhere in the
    program, it's impossible for the compiler to guarantee that the variable has
    been given a value before it gets used. The only safe option is to require
    the declaration itself to have an initializing expression that produces a
    value of the right type:

    **顶层变量和静态字段必须包含一个初始化方法。**
    由于它们能在程序里的任何位置被访问到，编译器无法保证它们在被使用前已被赋值。
    唯一保险的选项是要求其本身包含初始化表达式，以确保产生匹配的类型的值。

    ```dart
    // Using null safety:
    int topLevel = 0;

    class SomeClass {
      static int staticField = 0;
    }
    ```

*   **Instance fields must either have an initializer at the declaration, use an
    initializing formal, or be initialized in the constructor's initialization
    list.** That's a lot of jargon. Here are the examples:

    **实例的字段也必须在声明时包含初始化方法，
    可以为常见初始化形式，也可以在实例的构造方法中进行初始化。**
    这类初始化非常常见。举个例子：

    ```dart
    // Using null safety:
    class SomeClass {
      int atDeclaration = 0;
      int initializingFormal;
      int initializationList;

      SomeClass(this.initializingFormal)
          : initializationList = 0;
    }
    ```

    In other words, as long as the field has a value before you reach the
    constructor body, you're good.

    换句话说，字段在构造体执行前被赋值即可。

*   Local variables are the most flexible case. A non-nullable local variable
    *doesn't* need to have an initializer. This is perfectly fine:

    局部变量的灵活度最高。一个非空的变量**不一定需要**一个初始化方法。
    这里有个很好的例子：

    ```dart
    // Using null safety:
    int tracingFibonacci(int n) {
      int result;
      if (n < 2) {
        result = n;
      } else {
        result = tracingFibonacci(n - 2) + tracingFibonacci(n - 1);
      }

      print(result);
      return result;
    }
    ```

    The rule is only that **a local variable must be *definitely assigned*
    before it is used.** We get to rely on the new flow analysis I alluded to
    for this as well. As long as every path to a variable's use initializes it
    first, the use is OK.

    此处遵循的规则是**局部变量必须*确保在使用前被赋值*。**
    我们也可以依赖于之前所提到的全新的流程分析来实现。
    只要所有使用变量的路径，在使用前都先初始化，就可以正常调用。

*   **Optional parameters must have a default value.** If you don't pass an
    argument for an optional positional or named parameter, then the language
    fills it in with the default value. If you don't specify a default value,
    the _default_ default value is `null`, and that doesn't fly if the parameter's
    type is non-nullable.

    **可选参数必须具有默认值。**
    如果一个可选位置参数或可选命名参数没有传递内容，Dart 会自动使用默认值进行填充。
    在未指定默认值的情况下，默认值为 `null`，
    如此一来，非空类型的参数就要出事了。

    So, if you want a parameter to be optional, you need to either make it
    nullable or specify a valid non-`null` default value.

    所以，如果您需要一个可选参数，要么它是可空的，要么它的默认值不为 `null`。

These restrictions sound onerous, but they aren't too bad in practice. They are
very similar to the existing restrictions around `final` variables and you've
likely been working with those for years without even really noticing. Also,
remember that these only apply to *non-nullable* variables. You can always make
the type nullable and then get the default initialization to `null`.

这些限制听起来非常繁琐，但在实际操作中并不难。
它们与目前 `final` 有关的限制非常相似，您可能没有特别关注过，但它们伴随您已久。
另外，请记住，这些限制仅适用于**非空**变量。
在您使用可空的类型时，`null` 仍然可以作为初始化的默认值。

Even so, the rules do cause friction. Fortunately, we have a suite of new
language features to lubricate the most common patterns where these new
limitations slow you down. First, though, it's time to talk about flow analysis.

即便如此，这些规则也会让您的适配之路有些小磕碰。
幸运的是，我们有一整套新的语言特性，来帮助您平稳渡过一些常见的颠簸。
不过，首先，我们是时候来聊一聊流程分析了。

## Flow analysis

## 流程分析

[Control flow analysis][] has been around in compilers for years. It's mostly
hidden from users and used during compiler optimization, but some newer
languages have started to use the same techniques for visible language features.
Dart already has a dash of flow analysis in the form of *type promotion*:

[控制流程分析][Control flow analysis] 已经在众多编译器中存在多年了。
通常它对于使用者而言是不可见的，只在编译优化流程中使用，
但是，部分较新的语言，已经开始在可以看见的语言特性中使用同样的技术了。
Dart 已经以**类型提升**的方式实现了一些流程分析：

```dart
// With (or without) null safety:
bool isEmptyList(Object object) {
  if (object is List) {
    return object.isEmpty; // <-- OK!
  } else {
    return false;
  }
}
```

[control flow analysis]: https://en.wikipedia.org/wiki/Control_flow_analysis

Note how on the marked line, we can call `isEmpty` on `object`. That method is
defined on `List`, not `Object`. This works because the type checker looks at
all of the `is` expressions and the control flow paths in the program. If the
body of some control flow construct only executes when a certain `is` expression
on a variable is true, then inside that body the variable's type is "promoted"
to the tested type.

请留意我们是如何在标记的代码行上对 `object` 调用 `isEmpty` 的。
该方法是在 `List` 中定义的，而不是 `Object`。
因为类型检查器检查了代码中所有的 `is` 表达式，以及控制流的路径，所以这段代码是有效的。
如果部分控制流的代码主体只在变量的某个 `is` 表达式为真时才执行，
那么这个代码块中的变量，将会是经过推导得出的类型。

In the example here, the then branch of the `if` statement only runs when
`object` actually contains a list. Therefore, Dart promotes `object` to type
`List` instead of its declared type `Object`. This is a handy feature, but it's
pretty limited. Prior to null safety, the following functionally identical
program did not work:

在这个例子中，`if` 语句的 then 分支仅会在 `object` 是列表的时候执行。
因此，在这里 Dart 将 `object` 的类型从它声明的 `Object` 提升到了 `List`。
这项功能非常方便，但它有着诸多限制。
在空安全引入以前，下面的程序无法运行：

```dart
// Without null safety:
bool isEmptyList(Object object) {
  if (object is! List) return false;
  return object.isEmpty; // <-- Error!
}
```

Again, you can only reach the `.isEmpty` call when `object` contains a list, so
this program is dynamically correct. But the type promotion rules were not smart
enough to see that the `return` statement means the second statement can only be
reached when `object` is a list.

与之前一样，您只能在 `object` 是列表的时候调用 `.isEmpty`，
所以实际上这段代码是正确的。
但是类型提升规则并不那么智能，
它无法预测到 `return` 让下面代码只能在 `object` 为列表时才能访问到。

For null safety, we've taken this limited analysis and made it [much more
powerful in several ways.][flow analysis]

在空安全中，我们 [从不同的维度增强了][flow analysis] 这项能力，
让它不再只能进行有限的分析。

[flow analysis]: https://github.com/dart-lang/language/blob/master/resources/type-system/flow-analysis.md

### Reachability analysis

### 可达性分析

First off, we fixed the [long-standing complaint][18921] that type promotion
isn't smart about early returns and other unreachable code paths. When analyzing
a function, it now takes into account `return`, `break`, `throw`, and any other
way execution might terminate early in a function. Under null safety, this function:

首先，长期以来类型提升在处理提前返回和无法到达的代码路径时 [不够智能的问题][18921]，
已经被我们修复。
当我们在分析一个函数时，`return`、`break`、`throw` 以及任何可能提早结束函数的方式，
都将被考虑进来。
在空安全下，下面的这个函数：

[18921]: https://github.com/dart-lang/sdk/issues/18921

```dart
// Using null safety:
bool isEmptyList(Object object) {
  if (object is! List) return false;
  return object.isEmpty;
}
```

Is now perfectly valid. Since the `if` statement will exit the function when
`object` is *not* a `List`, Dart promotes `object` to be `List` on the second
statement. This is a really nice improvement that helps a lot of Dart code, even
stuff not related to nullability.

现在是完全有效的。
由于 `if` 语句会在 `object` **不是** `List` 时退出这个函数，
因此 Dart 将下一句的 `object` 类型提升至了 `List`。
对于众多 Dart 代码来说，这是一项非常棒的改进，就算对于一些与空安全无关的代码来说也是。

### Never for unreachable code

### 为不可达的代码准备的 Never

You can also *program* this reachability analysis. The new bottom type `Never`
has no values. (What kind of value is simultaneously a `String`, `bool`, and
`int`?) So what does it mean for an expression to have type `Never`? It means
that expression can never successfully finish evaluating. It must throw an
exception, abort, or otherwise ensure that the surrounding code expecting the
result of the expression never runs.

您可以自己**码出**这项可达性分析。
新的底层类型 `Never` 是没有任何值的。（什么值能同时是 `String`、`bool` 和 `int` 呢？）
那么一个类型为 `Never` 的表达式有什么含义呢？
它意味着这个表达式永远无法成功的推导和执行。
它必须要抛出一个异常、中断或者确保调用它的代码永远不会执行。

In fact, according to the language, the static type of a `throw` expression is
`Never`. The type `Never` is declared in the core libraries and you can use it
as a type annotation. Maybe you have a helper function to make it easier to
throw a certain kind of exception:

事实上，根据语言的细则，`throw` 表达式的静态类型就是 `Never`。
该类型已在核心库中定义，您可以将它用于变量声明。
也许您会写一个辅助函数，用于简单方便地抛出一个固定的异常：

```dart
// Using null safety:
Never wrongType(String type, Object value) {
  throw ArgumentError('Expected $type, but was ${value.runtimeType}.');
}
```

You might use it like so:

您也可以这样用：

```dart
// Using null safety:
class Point {
  final double x, y;

  bool operator ==(Object other) {
    if (other is! Point) wrongType('Point', other);
    return x == other.x && y == other.y;
  }

  // Constructor and hashCode...
}
```

This program analyzes without error. Notice that the last line of the `==`
method accesses `.x` and `.y` on `other`. It has been promoted to `Point` even
though the function doesn't have any `return` or `throw`. The control flow
analysis knows that the declared type of `wrongType()` is `Never` which means
the then branch of the `if` statement *must* abort somehow. Since the second
statement can only be reached when `other` is a `Point`, Dart promotes it.

这段代码不会分析出错误。
请注意 `==` 方法的最后一行，在 `other` 上调用 `.x` 和 `.y`。
尽管在第一行并没有包含 `return` 或 `throw`，它的类型仍然提升为了 `Point`。
控制流程分析意识到 `wrongType()` 声明的类型是 `Never`，
代表着 `if` 语句的 then 分支**一定会**由于某些原因被中断。
由于下一句的代码仅能在 `other` 是 `Point` 时运行，所以 Dart 提升了它的类型。

In other words, using `Never` in your own APIs lets you extend Dart's
reachability analysis.

换句话说，在您的代码中使用 `Never` 让您可以扩展 Dart 的可达性分析。

### Definite assignment analysis

### 绝对的赋值分析

I mentioned this one briefly with local variables. Dart needs to ensure a
non-nullable local variable is always initialized before it is read. We use
*definite assignment analysis* to be as flexible about that as possible. The
language analyzes each function body and tracks the assignments to local
variables and parameters through all control flow paths. As long as the variable
is assigned on every path that reaches some use of a variable, the variable is
considered initialized. This lets you declare a variable with no initializer and
then initialize it afterwards using complex control flow, even when the variable
has a non-nullable type.

前文已经在提到局部变量时简单提到了这个分析。
Dart 需要确保一个非空的局部变量在它被读取前一定完成了初始化。
我们使用了**绝对的赋值分析**，从而保证尽可能灵活地处理变量的初始化。
Dart 语言会逐个分析函数的主体，并且追踪所有控制流路径的局部变量和参数的赋值。
只要变量在每个使用路径中都已经被赋值，这个变量就被视为已初始化。
这项分析可以让你不再一开始就对变量初始化，而是在后面复杂的控制流中进行赋值，
甚至非空类型变量也可以这样做。

We also use definite assignment analysis to make *final* variables more
flexible. Before null safety, it can be difficult to use `final` for local
variables if you need to initialize them in any sort of interesting way:

同时我们也通过绝对赋值分析使得声明为 **final** 的变量更灵活。
在空安全引入以前，当你需要声明一个 `final` 变量时，
一些有意思的初始化方式是无法使用的：

```dart
// Using null safety:
int tracingFibonacci(int n) {
  final int result;
  if (n < 2) {
    result = n;
  } else {
    result = tracingFibonacci(n - 2) + tracingFibonacci(n - 1);
  }

  print(result);
  return result;
}
```

This would be an error since the `result` variable is `final` but has no
initializer. With the smarter flow analysis under null safety, this program is
fine. The analysis can tell that `result` is definitely initialized exactly once
on every control flow path, so the constraints for marking a variable `final`
are satisfied.

鉴于 `result` 被声明为 `final`，又不包含初始化内容，这段代码将返回一个错误。
而对于更智能的空安全流程分析来说，这段代码是正确的。
通过分析可以知道，`result` 在所有的控制流路径上都已经被初始化，
所以对于标记的 `final` 变量而言，约束得以满足。

### Type promotion on null checks

### 空检查的类型提升

The smarter flow analysis helps lots of Dart code, even code not related to
nullability. But it's not a coincidence that we're making these changes now. We
have partitioned types into nullable and non-nullable sets. If you have a value
of a nullable type, you can't really *do* anything useful with it. In cases
where the value *is* `null`, that restriction is good. It's preventing you from
crashing.

更智能的流程分析对于众多 Dart 代码而言帮助极大，甚至对于一些与是否可空无关的代码也是如此。
但是我们在现在做出这些改动并非巧合。
我们已经将类型划分成了可空和非空的集合，
如果一个变量是一个可空的类型，您无法对它**做**任何有用的事情。
所以在**值为** `null` 的情况下，这项限制是很有效的，
它可以避免您的程序崩溃。

But if the value isn't `null`, it would be good to be able to move it over to
the non-nullable side so you can call methods on it. Flow analysis is one of the
primary ways to do this for local variables and parameters. We've extended type
promotion to also look at `== null` and `!= null` expressions.

而如果值不为 `null`，最好是直接将它移到非空的一侧，如此一来您就可以调用它的方法了。
流程分析是对变量和局部变量进行处理的主要方法之一。
我们在分析 `== null` 和 `!= null` 表达式时也进行了类型提升的扩展。

If you check a variable with nullable type to see if it is not `null`, Dart then
promotes the variable to the underlying non-nullable type:

如果您判断了一个可空的变量是否不为 `null`，进行到下一步后
Dart 就会将这个变量的类型提升至非空的对应类型：

```dart
// Using null safety:
String makeCommand(String executable, [List<String>? arguments]) {
  var result = executable;
  if (arguments != null) {
    result += ' ' + arguments.join(' ');
  }
}
```

Here, `arguments` has a nullable type. Normally, that prohibits you from calling
`.join()` on it. But because we have guarded that call in an `if` statement that
checks to ensure the value is not `null`, Dart promotes it from `List<String>?`
to `List<String>` and lets you call methods on it or pass it to functions that
expect non-nullable lists.

此处，`arguments` 是可空的类型。
通常来说，对其调用 `.join()` 是禁止的。
但是，由于 `if` 语句中的判断已经足以确认值不为 `null`，
Dart 将它的类型从 `List<String>?` 提升到了 `List<String>`，
从而让您能够调用它的方法，或将它传递给一个需要非空列表的函数。

This sounds like a fairly minor thing, but this flow-based promotion on null
checks is what makes most existing Dart code work under null safety. Most Dart
code *is* dynamically correct and does avoid throwing null reference errors by
checking for `null` before calling methods. The new flow analysis on null checks
turns that *dynamic* correctness into provable *static* correctness.

这听起来是件小事，但这种基于流程的空检查提升，是大部分 Dart 代码能运行在空安全下的保障。
大部分的 Dart 代码**是**动态正确的，并且在调用前通过判断 `null` 来避免抛出空调用错误。
新的空安全流程分析将**动态**正确变成了更有保障的**静态**正确。

It also, of course, works with the smarter analysis we do for reachability. The
above function can be written just as well as:

当然，它也同时和更智能的分析一起进行检查工作。
上面的函数也可以像下面这样编写：

```dart
// Using null safety:
String makeCommand(String executable, [List<String>? arguments]) {
  var result = executable;
  if (arguments == null) return result;
  return result + ' ' + arguments.join(' ');
}
```

The language is also smarter about what kinds of expressions cause promotion. An
explicit `== null` or `!= null` of course works. But explicit casts using `as`,
or assignments, or the postfix `!` operator we'll get to soon also cause
promotion. The general goal is that if the code is dynamically correct and it's
reasonable to figure that out statically, the analysis should be clever enough
to do so.

Dart 语言也对什么表达式需要提升变量判断地更智能了。
除了显式的 `== null` 和 `!= null` 以外，显式使用 `as` 或赋值，
以及我们马上就要提到的后置操作符 `!` 也会进行类型提升。
总体来说的目标是：如果代码是动态正确的，而静态分析时又是合理的，
那么分析结果也足够聪明，会对其进行类型提升。

### Unnecessary code warnings

### 无用代码的警告

Having smarter reachability analysis and knowing where `null` can flow through
your program helps ensure that you *add* code to handle `null`. But we can also
use that same analysis to detect code that you *don't* need. Before null safety,
if you wrote something like:

在您的程序中，一个可以准确知晓 `null` 去向的可达性分析，
能确保您已经**增加**了对 `null` 的处理。
不过我们也可以用同样的分析来检测您是否有**不用**的代码。
在空安全以前，如果您编写了如下的代码：

```dart
// Using null safety:
String checkList(List list) {
  if (list?.isEmpty) {
    return 'Got nothing';
  }
  return 'Got something';
}
```

Dart had no way of knowing if that null-aware `?.` operator is useful or not.
For all it knows, you could pass `null` to the function. But in null safe Dart,
if you have annotated that function with the now non-nullable `List` type, then
it knows `list` will never be `null`. That implies the `?.` will never do
anything useful and you can and should just use `.`.

Dart 无法得知避空运算符 `?.` 是否有用。它只知道您可以将 `null` 传递进方法内。
但是在有空安全的 Dart 里，如果您将函数声明为现有的非空 `List` 类型，
它就知道 `list` 永远不会为空。
实际上就暗示了 `?.` 是不必要的，您完全可以直接使用 `.`。

To help you simplify your code, we've added warnings for unnecessary code like
this now that the static analysis is precise enough to detect it. Using a
null-aware operator or even a check like `== null` or `!= null` on a
non-nullable type gets reported as a warning.

为了帮助您简化代码，我们为一些不必要的代码增加了一些警告，静态分析可以精确地检测到它。
在一个非空类型上使用避空运算符、用 `== null` 或 `!= null` 判断，都会出现一个警告。

And, of course, this plays with non-nullable type promotion too. Once a
variable has been promoted to a non-nullable type, you get a warning if you
redundantly check it again for `null`:

同时，在非空类型提升的情况中也会看到类似的提示。
当一个变量已经被提升至非空类型，你会在不必要的 `null` 检查时看到一个警告：

```dart
// Using null safety:
checkList(List? list) {
  if (list == null) return 'No list';
  if (list?.isEmpty) {
    return 'Empty list';
  }
  return 'Got something';
}
```

You get a warning on the `?.` here because at the point that it executes, we
already know `list` cannot be `null`. The goal with these warnings is not just
to clean up pointless code. By removing *unneeded* checks for `null`, we ensure
that the remaining meaningful checks stand out. We want you to be able to look
at your code and *see* where `null` can flow.

此处由于代码执行后，`list` 不能为 `null`，所以您会在 `?.` 的调用处看到一个警告。
这些警告不仅仅是为了减少无意义的代码，
通过移除**不必要**的 `null` 判断，我们得以确保其他有意义的判断能够脱颖而出。
我们期望您能**看到**您代码中的 `null` 会向何处传递。

## Working with nullable types

## 与可空类型共舞

We've now corralled `null` into the set of nullable types. With flow analysis,
we can safely let some non-`null` values hop over the fence to the non-nullable
side where we can use them. That's a big step, but if we stop here, the
resulting system is still painfully restrictive. Flow analysis only helps with
locals and parameters.

现在，我们已经将 `null` 归到了可空类型的集合中。
有了流程分析，我们可以让一些非 `null` 值安全地越过栅栏，到达非空的那一侧，供我们使用。
这是相当大的一步，但如果我们就此止步不前，产出的系统仍然饱含痛苦的限制，
而流程分析也仅对局部变量和参数起作用。

To try to regain as much of the flexibility that Dart had before null
safety&mdash;and to go beyond it on some places&mdash;we have a handful of other
new features.

为了尽可能地保持 Dart 在拥有空安全之前的灵活度，并且在一定程度上超越它，
我们带来了一些其他的实用新特性。

### Smarter null-aware methods

### 更智能的空判断方法

Dart's null aware operator `?.` is much older than null safety. The runtime
semantics state that if the receiver is `null` then the property access on the
right-hand side is skipped and the expression evaluates to `null`:

Dart 的避空运算符 `?.` 相对空安全而言俨然是一位老生。
根据运行时的语义化规定，如果接收者是 `null`，那么右侧的属性访问就会被跳过，
表达式将被作为 `null` 看待。

```dart
// Without null safety:
String notAString = null;
print(notAString?.length);
```

Instead of throwing an exception, this prints "null". The null-aware operator is
a nice tool for making nullable types usable in Dart. While we can't let you
call methods on nullable types, we can and do let you use null-aware operators
on them. The post-null safety version of the program is:

这段代码将打印 “null”，而不是抛出一个异常。
避空运算符是一个不错的工具，让可空类型在 Dart 中变得可用。
尽管我们不能让您在可空类型上调用方法，但我们可以让您使用避空运算符调用它们。
空安全版本的程序是这样的：

```dart
// Using null safety:
String? notAString = null;
print(notAString?.length);
```

It works just like the previous one.

与之前一样，它可以正常运行。

However, if you've ever used null-aware operators in Dart, you've probably
encountered an annoyance when using them in method chains. Let's say you want to
see if the length of a potentially absent string is an even number (not a
particularly realistic problem, I know, but work with me here):

然而，如果您曾经在 Dart 中使用过避空运算符，您可能经历过链式方法调用的恼人操作。
假设您需要判断一个可能为空的字符串的长度是否为偶数
（这可能不是个贴合实际的问题，但请继续往下看）：

```dart
// Using null safety:
String? notAString = null;
print(notAString?.length.isEven);
```

Even though this program uses `?.`, it still throws an exception at runtime. The
problem is that the receiver of the `.isEven` expression is the result of the
entire `notAString?.length` expression to its left. That expression evaluates to
`null`, so we get a null reference error trying to call `.isEven`. If you've
ever used `?.` in Dart, you probably learned the hard way that you have to apply
the null-aware operator to *every* property or method in a chain after you use
it once:

就算这个程序使用了 `?.`，它仍然会在运行时抛出异常。
这里的问题在于，`.isEven` 的接收器是左侧整个 `notAString?.length` 表达式的结果。
这个表达式被认为是 `null`，所以我们在尝试调用 `.isEven` 的时候出现了空引用的错误。
如果您在 Dart 中使用过 `?.`，您可能已经学会了一个非常繁琐的方法，
那就是在使用了一次避空运算符后，其**每一处**属性或方法的链式调用处都加上它。

```dart
String? notAString = null;
print(notAString?.length?.isEven);
```

This is annoying, but, worse, it obscures important information. Consider:

这非常烦人，但更致命的是，它会扰乱重要信息的获取。看看下面这个：

```dart
// Using null safety:
showGizmo(Thing? thing) {
  print(thing?.doohickey?.gizmo);
}
```

Here's a question for you: Can the `doohickey` getter on `Thing` return `null`?
It looks like it *could* because you're using `?.` on the result. But it may
just be that the second `?.` is only there to handle cases where `thing` is
`null`, not the result of `doohickey`. You can't tell.

这里我们想问您一个问题：`Thing` 中获取 `doohickey` 是否会返回 `null`？
看上去它**会**返回 `null`，因为您在调用后使用了 `?.`。
但也有可能第二个 `?.` 仅仅是为了处理 `thing` 为 `null` 的情况，
而不是 `doohickey` 的结果。您无法直接得出结论。

To address this, we borrowed a smart idea from C#'s design of the same feature.
When you use a null-aware operator in a method chain, if the receiver evaluates
to `null`, then *the entire rest of the method chain is short-circuited and
skipped*. This means if `doohickey` has a non-nullable return type, then you
can and should write:

为了解决这类问题，我们从 C# 相同功能的设计中借鉴了一个聪明的处理方法。
当您在链式方法调用中使用避空运算符时，如果接收器被判断为 `null`，
那么**整个链式调用的剩余部分都会被截断并跳过**。
这意味着如果 `doohickey` 的返回值是一个可空的类型，您应该这样写：

```dart
// Using null safety:
showGizmo(Thing? thing) {
  print(thing?.doohickey.gizmo);
}
```

In fact, you'll get an unnecessary code warning on the second `?.` if you
don't. If you see code like:

实际上，如果您不去掉第二个 `?.`，您会看到一个警告，提示这段代码是不必要的。
所以如果您看到了这样的代码：

```dart
// Using null safety:
showGizmo(Thing? thing) {
  print(thing?.doohickey?.gizmo);
}
```

Then you know for certain it means that `doohickey` itself has a nullable return
type. Each `?.` corresponds to a *unique* path that can cause `null` to flow
into the method chain. This makes null-aware operators in method chains both
more terse and more precise.

您立刻就会知道 `doohickey` 本身的返回类型就是可空的。
每一个 `?.` 对应一个**独一无二的**代码路径，能够让 `null` 随着链式调用传递。
这就让链式方法调用中的避空运算符更为简洁和精确。

While we were at it, we added a couple of other null-aware operators:

同时，我们也在这里加入了一些其他的避空运算符：

```dart
// Using null safety:

// Null-aware cascade:
receiver?..method();

// Null-aware index operator:
receiver?[index];
```

There isn't a null-aware function call operator, but you can write:

目前还没有空判断函数调用操作符，但是您可以这样写：

```dart
// Allowed with or without null safety:
function?.call(arg1, arg2);
```

### Null assertion operator

### 空值断言操作符

The great thing about using flow analysis to move a nullable variable to the
non-nullable side of the world is that doing so is provably safe. You get to
call methods on the previously-nullable variable without giving up any of the
safety or performance of non-nullable types.

利用流程分析，将可空的变量转移到非空的一侧，是安全可靠的。
您可以在先前可空的变量上调用方法，同时还能享受到非空类型的安全和性能优势。

But many valid uses of nullable types can't be *proven* to be safe in a way that
pleases static analysis. For example:

但是，很多有效的可空类型使用方法，不能向静态分析**证明**它们的安全性。例如：

```dart
// Using null safety, incorrectly:
class HttpResponse {
  final int code;
  final String? error;

  HttpResponse.ok() : code = 200;
  HttpResponse.notFound()
      : code = 404,
        error = 'Not found';

  String toString() {
    if (code == 200) return 'OK';
    return 'ERROR $code ${error.toUpperCase()}';
  }
}
```

If you try to run this, you get a compile error on the call to `toUpperCase()`.
The `error` field is nullable because it won't have a value in a successful
response. We can see by inspecting the class that we never access the `error`
message when it is `null`. But that requires understanding the relationship
between the value of `code` and the nullability of `error`. The type checker
can't see that connection.

如果您尝试运行这段代码，您会看到一个指向 `toUpperCase()` 调用的编译错误。
`error` 属性是可空的，在返回结果成功时，它不会有值。
我们通过仔细观察类可以看出，当消息为空时，我们永远不会访问 `error`。
但为了知晓这个行为，必须要理解 `code` 的值与 `error` 的可空性之间的联系。
类型检查器看不出这种联系。

In other words, we human maintainers of the code *know* that error won't be
`null` at the point that we use it and we need a way to assert that. Normally,
you assert types using an `as` cast, and you can do the same thing here:

换句话说，作为代码的人类维护者，我们知道在使用 error 时，
它的值不会是 `null`，并且我们需要对其进行断言。
通常您可以通过使用 `as` 转换来断言类型，这里您也可以这样做：

```dart
// Using null safety:
String toString() {
  if (code == 200) return 'OK';
  return 'ERROR $code ${(error as String).toUpperCase()}';
}
```

Casting `error` to the non-nullable `String` type will throw a runtime exception
if the cast fails. Otherwise, it gives us a non-nullable string that we can then
call methods on.

如果在运行时，将 `error` 转换为非空的 `String` 类型出现了无法转换的错误，会抛出一个异常。
若转换成功，一个非空的字符串就会回到我们的手上，让我们可以进行方法调用。

"Casting away nullability" comes up often enough that we have a new shorthand
syntax. A postfix exclamation mark (`!`) takes the expression on the left and
casts it to its underlying non-nullable type. So the above function is
equivalent to:

“排除可空性的转换”的场景频繁出现，这促使了我们带来了新的短小精悍的语法。
一个作为后缀的感叹号标记 (`!`) 会让左侧的表达式转换成其对应的非空类型。
所以上面的函数等效于：

```dart
// Using null safety:
String toString() {
  if (code == 200) return 'OK';
  return 'ERROR $code ${error!.toUpperCase()}';
}
```

This one-character "bang operator" is particularly handy when the underlying
type is verbose. It would be really annoying to have to write `as
Map<TransactionProviderFactory, List<Set<ResponseFilter>>>` just to cast away a
single `?` from some type.

当原有的类型非常繁琐的时候，这个只有一个字符的“重点操作符”就会非常上手。
如果仅仅是为了将一个类型转换为非空，就需要写出类似于
`as Map<TransactionProviderFactory, List<Set<ResponseFilter>>>`
这样的代码，会让这个过程变得非常烦人。

Of course, like any cast, using `!` comes with a loss of static safety. The cast
must be checked at runtime to preserve soundness and it may fail and throw an
exception. But you have control over where these casts are inserted, and you can
always see them by looking through your code.

当然，与其他所有转换一样，使用 `!` 将会失去部分静态的安全性。
这些转换必须在运行时进行，从而确保代码健全，并且有可能失败并抛出异常。
但您可以完全控制这些转换的使用位置，并且能从代码中直接看到它们。

### Late variables

### 懒加载的变量

The most common place where the type checker cannot prove the safety of code is
around top-level variables and fields. Here is an example:

对于顶层变量和字段而言，类型检查器常常无法证明其是否安全。这里有一个例子：

```dart
// Using null safety, incorrectly:
class Coffee {
  String _temperature;

  void heat() { _temperature = 'hot'; }
  void chill() { _temperature = 'iced'; }

  String serve() => _temperature + ' coffee';
}

main() {
  var coffee = Coffee();
  coffee.heat();
  coffee.serve();
}
```

Here, the `heat()` method is called before `serve()`. That means `_temperature`
will be initialized to a non-null value before it is used. But it's not feasible
for a static analysis to determine that. (It might be possible for a trivial
example like this one, but the general case of trying to track the state of each
instance of a class is intractable.)

在这里，`heat()` 方法在 `serve()` 之前就被调用了。
这意味着 `_temperature` 会在它被使用前初始化为一个非空的值。
但对于静态分析而言，这样是不可行的。
（实际上在与例子类似的情况下，代码可能是可行的，但是在一般情况下，我们难以跟踪每一个实例的状态。）

Because the type checker can't analyze uses of fields and top-level variables,
it has a conservative rule that non-nullable fields have to be initialized
either at their declaration (or in the constructor initialization list for
instance fields). So Dart reports a compile error on this class.

由于类型检查器无法分析字段和顶层变量的用途，因此它遵循一个相对保守的规则，
即不可空的字段必须在声明时初始化（或是在构造函数的初始化字段列表中）。
所以在这里，Dart 会在这个类上提示一个编译错误。

You can fix the error by making the field nullable and then using null assertion
operators on the uses:

为了解决这个问题，您可以将它声明为可空，接着使用空断言操作符：

```dart
// Using null safety:
class Coffee {
  String? _temperature;

  void heat() { _temperature = 'hot'; }
  void chill() { _temperature = 'iced'; }

  String serve() => _temperature! + ' coffee';
}
```

This works fine. But it sends a confusing signal to the maintainer of the class.
By marking `_temperature` nullable, you imply that `null` is a useful,
meaningful value for that field. But that's not the intent. The `_temperature`
field should never be *observed* in its `null` state.

这样一来，代码确实可以正常工作了。但是它让这个类的维护人员感到困惑。
将 `_temperature` 变为可空，暗示着 `null` 对于字段来说是有用的值。
但实际上其与您的企图背道而驰。
`_temperature` 字段永远不会在为 `null` 的情况下被观测到。

To handle the common pattern of state with delayed initialization, we've added a
new modifier, `late`. You can use it like this:

为了处理类似延迟初始化这样常见的行为，我们新增了一个修饰符：`late`。您可以这样使用：

```dart
// Using null safety:
class Coffee {
  late String _temperature;

  void heat() { _temperature = 'hot'; }
  void chill() { _temperature = 'iced'; }

  String serve() => _temperature + ' coffee';
}
```

Note that the `_temperature` field has a non-nullable type, but is not
initialized. Also, there's no explicit null assertion when it's used. There are
a few models you can apply to the semantics of `late`, but I think of it like
this: The `late` modifier means "enforce this variable's constraints at runtime
instead of at compile time". It's almost like the word "late" describes *when*
it enforces the variable's guarantees.

此处我们注意到，`_temperature` 字段是一个非空的类型，但是并没有进行初始化。
同时，在使用时也没有明确的空断言。
虽然 `late` 应用的语义有几种解释，但在这里应该是：
`late` 修饰符是“在运行时而非编译时对变量进行约束”。
这就让 `late` 这个词语约等于**何时**执行对变量的强制约束。

In this case, since the field is not definitely initialized, every time the
field is read, a runtime check is inserted to make sure it has been assigned a
value. If it hasn't, an exception is thrown. Giving the variable the type
`String` means "you should never see me with a value other than a string" and
the `late` modifier means "verify that at runtime".

当前场景里，字段并不一定已经被初始化，
每次它被读取时，都会插入一个运行时的检查，以确保它已经被赋值。
如果并未赋值，就会抛出一个异常。
给一个变量加上 `String` 类型就是在说：“我的值绝对是字符串”，
而加上 `late` 修饰符意味着：“每次运行都要检查检查是不是真的”。

In some ways, the `late` modifier is more "magical" than using `?` because any
use of the field could fail, and there isn't anything textually visible at the
use site. But you *do* have to write `late` at the declaration to get this
behavior, and our belief is that seeing the modifier there is explicit enough
for this to be maintainable.

在某些方面，`late` 修饰符比 `?` 更为神奇，因为对这个字段的任何调用都有可能失败，
且在失败的事故现场不会有任何的文字说明。

In return, you get better static safety than using a nullable type. Because the
field's type is non-nullable now, it is a *compile* error to try to assign
`null` or a nullable `String` to the field. The `late` modifier lets you *defer*
initialization, but still prohibits you from treating it like a nullable
variable.

作为回报，它在静态安全方面比可空类型更靠谱。
因为这个字段现在是非空的了，在**编译时**为它赋予 `null` 或可空的 `String` 就会出错。
虽然 `late` 修饰符让您延迟了初始化，但它仍然禁止您将变量作为可空的类型进行处理。

### Lazy initialization

### 延迟初始化

The `late` modifier has some other special powers too. It may seem paradoxical,
but you can use `late` on a field that has an initializer:

`late` 修饰符也有一些特殊的能力。
虽然听起来起来有一些自相矛盾，但是您可以在一个包含初始化内容的字段上使用 `late`：

```dart
// Using null safety:
class Weather {
  late int _temperature = _readThermometer();
}
```

When you do this, the initializer becomes *lazy*. Instead of running it as soon
as the instance is constructed, it is deferred and run lazily the first time the
field is accessed. In other words, it works exactly like an initializer on a
top-level variable or static field. This can be handy when the initialization
expression is costly and may not be needed.

当您这么声明时，会让初始化**延迟**执行。
实例的构造将会延迟到字段首次被访问时执行，而不是在实例构造时就初始化。
换句话说，它让字段的初始化方式变得与顶层变量和静态字段完全一致。
当初始化表达式比较消耗性能，并且有可能不需要时，这会变得非常有用。

Running the initializer lazily gives you an extra bonus when you use `late` on
an instance field. Usually instance field initializers cannot access `this`
because you don't have access to the new object until all field initializers
have completed. But with a `late` field, that's no longer true, so you *can*
access `this`, call methods, or access fields on the instance.

当您在实例字段上使用 `late` 时，延迟初始化会给您带来更多的便利。
通常实例字段的初始化内容无法访问到 `this`，
因为在所有的初始化方法完成前，您无法访问到新的实例对象。
但是，使用了 `late` 让这个条件不再为真，
所以您**可以**访问到 `this`、调用方法以及访问实例的字段。

### Late final variables

### 延迟的终值

You can also combine `late` with `final`:

您也可以将 `late` 与 `final` 结合使用：

```dart
// Using null safety:
class Coffee {
  late final String _temperature;

  void heat() { _temperature = 'hot'; }
  void chill() { _temperature = 'iced'; }

  String serve() => _temperature + ' coffee';
}
```

Unlike normal `final` fields, you do not have to initialize the field in its
declaration or in the constructor initialization list. You can assign to it
later at runtime. But you can only assign to it *once*, and that fact is checked
at runtime. If you try to assign to it more than once&mdash;like calling both
`heat()` and `chill()` here&mdash;the second assignment throws an exception.
This is a great way to model state that gets initialized eventually and is
immutable afterwards.

与普通的 `final` 字段不同，您不需要在声明或构造时就将其初始化。
您可以稍后在运行中的某个地方加载它。
但是您只能对其进行**一次**赋值，并且它在运行时会进行校验。
如果您尝试对它进行多次赋值，比如 `heat()` 和 `chill()` 都调用，
那么第二次的赋值会抛出异常。
这是确定字段状态的好方法，它最终会被初始化，并且在初始化后是无法改变的。

In other words, the new `late` modifier in combination with Dart's other
variable modifiers covers most of the feature space of `lateinit` in Kotlin and
`lazy` in Swift. You can even use it on local variables if you want a little
local lazy evaluation.

换句话说，新的 `late` 修饰符与 Dart 的其他变量修饰符结合后，
已经实现了 Kotlin 中的 `lateinit` 和 Swift 中的 `lazy` 的大量特性。
如果您需要给局部变量加上一些延迟初始化，您也可以在局部变量上使用它。

### Required named parameters

### 必需的命名参数

To guarantee that you never see a `null` parameter with a non-nullable type, the
type checker requires all optional parameters to either have a nullable type or
a default value. What if you want to have a named parameter with a nullable type
and no default value? That would imply that you want to require the caller to
*always* pass it. In other words, you want a parameter that is *named* but not
optional.

为了保证您永远不会看到一个非空类型的参数值为 `null`，
类型检查器给所有的可选参数提出了要求，要么是一个可空的类型，要么包含一个默认值。
如果您需要一个可空的命名参数，同时又不包含默认值，该怎么办呢？
这就意味着您要求调用者**每次**都为其传递内容。
换句话说，您需要的是一个非可选的**命名**参数。

I visualize the various kinds of Dart parameters with this table:

这个表格直观地展示了 Dart 的各种参数：

```
                必需的        可选的
            +------------+------------+
位置参数     | f(int x)   | f([int x]) |
            +------------+------------+
命名参数     | ???        | f({int x}) |
            +------------+------------+
```

For unclear reasons, Dart has long supported three corners of this table but
left the combination of named+mandatory empty. With null safety, we filled that
in. You declare a required named parameter by placing `required` before the
parameter:

Dart 为何长期以来只支持三种参数类型，而不支持 命名+必需 组合的参数，仍然是未解之谜。
随着空安全的引入，我们将这个空缺的参数类型补充上了。
现在您只需要将 `required` 放在参数前，就可以声明一个必需的命名参数：

```dart
// Using null safety:
function({int? a, required int? b, int? c, required int? d}) {}
```

Here, all the parameters must be passed by name. The parameters `a` and `c` are
optional and can be omitted. The parameters `b` and `d` are required and must
be passed. Note that required-ness is independent of nullability. You can have
required named parameters of nullable types, and optional named parameters of
non-nullable types (if they have a default value).

这里的所有参数都必须通过命名来传递。
参数 `a` 和 `c` 是可选的，可以省略。
参数 `b` 和 `d` 是必需的，调用时必须传递。
在这里请注意，是否必需和是否可空无关。
您可以写出可空类型的必需命名参数，以及非空类型的可选命名参数（如果它们包含了默认值）。

This is another one of those features that I think makes Dart better regardless
of null safety. It simply makes the language feel more complete to me.

无论是否为空安全，这都是另一个让 Dart 变得更好的特性之一。
它让这门语言看起来更为完整。

### Working with nullable fields

### 与可空字段共舞

These new features cover many common patterns and make working with `null`
pretty painless most of the time. But even so, our experience is that nullable
fields can still be difficult. In cases where you can make the field `late` and
non-nullable, you're golden. But in many cases you need to *check* to see if the
field has a value, and that requires making it nullable so you can observe the
`null`.

新引入的特性处理了非常多常见的行为模式，并且让大部分处理 `null` 的工作不再那么痛苦。
即便如此，根据我们的经验之谈，处理可空的字段仍然是较为困难的。
在您能使用 `late` 和非空类型的情况下，已经相当稳妥。
但在很多场景里，您仍然需要**检查**字段是否有值，
这些情况下，字段会是可空的，您也能观测到 `null` 的存在。

You might expect this to work:

以下这段代码，您可能会认为可以这么写：

```dart
// Using null safety, incorrectly:
class Coffee {
  String? _temperature;

  void heat() { _temperature = 'hot'; }
  void chill() { _temperature = 'iced'; }

  void checkTemp() {
    if (_temperature != null) {
      print('Ready to serve ' + _temperature + '!');
    }
  }

  String serve() => _temperature! + ' coffee';
}
```

Inside `checkTemp()`, we check to see if `_temperature` is `null`. If not, we
access it and end up calling `+` on it. Unfortunately, this is not allowed.
Flow-based type promotion does not apply to fields because the static analysis
cannot *prove* that the field's value doesn't change between the point that you
check for `null` and the point that you use it. (Consider that in pathological
cases, the field itself could be overridden by a getter in a subclass that
returns `null` the second time it is called.)

在 `checkTemp()` 中，我们检查了 `_temperature` 是否为 `null`。
如果不为空，我们会访问并对它调用 `+`。
很遗憾，这样做是不被允许的。
基于流程分析的类型提升并不适用于字段，
因为静态分析不能**证明**这个字段的值在您判断后和使用前没有发生变化。
（某些极端场景中，字段本身可能会被子类的 getter 重写，从而在第二次调用时返回 `null`。）

So, since we care about soundness, fields don't promote and the above method
does not compile. This is annoying. In simple cases like here, your best bet is
to slap a `!` on the use of the field. It seems redundant, but that's more or
less how Dart behaves today.

因为代码的健全性也是我们在乎的指标，所以字段的类型不会被提升，且上面的方法也无法编译。
这其实不太舒服。在这样的简单例子中，最好的办法是在使用字段时加上 `!`。
它看起来是多余的，但是目前的 Dart 需要这样的操作。

Another pattern that helps is to copy the field to a local variable first and
then use that instead:

还有一种可以解决这类情况的方法，就是先将字段拷贝为一个局部变量，然后再使用它：

```dart
// Using null safety:
void checkTemp() {
  var temperature = _temperature;
  if (temperature != null) {
    print('Ready to serve ' + temperature + '!');
  }
}
```

Since the type promotion does apply to locals, this now works fine. If you need
to *change* the value, just remember to store back to the field and not just the
local.

对于局部变量而言，类型提升是有效的，所以它会正常运行。
如果您需要**更改**它的值，记得要存储回原有的字段，不要只更新了您的局部变量。

### Nullability and generics

### 可空性和泛型

Like most modern statically-typed languages, Dart has generic classes and
generic methods. They interact with nullability in a few ways that seem
counter-intuitive but make sense once you think through the implications. First
is that "is this type nullable?" is no longer a simple yes or no question.
Consider:

与现今主流的静态类型语言一样，Dart 也有泛型类和泛型方法。
它们在与可空性的交互上，会有一些反直觉的地方，
可一旦您想清楚了其中隐含的设计意图，就会理解它们的合理性。
首先，“这个类型是否是可空？”已经不再是一个简单的是非问题。
让我们来考虑以下的情况：

```dart
// Using null safety:
class Box<T> {
  final T object;
  Box(this.object);
}

main() {
  Box<String>('a string');
  Box<int?>(null);
}
```

In the definition of `Box`, is `T` a nullable type or a non-nullable type? As
you can see, it can be instantiated with either kind. The answer is that `T` is a
*potentially nullable type*. Inside the body of a generic class or method, a
potentially nullable type has all of the restrictions of both nullable types
*and* non-nullable types.

在 `Box` 的定义中，`T` 是可空还是非空的类型？
正如您所看到的那样，它可以通过任意一种类型来进行实例化。
答案是：`T` 是一个**潜在的可空类型**。
在泛型类或泛型方法的主体中，一个潜在的可空类型包含了可空类型**以及**非空类型的所有限制。

The former means you can't call any methods on it except the handful defined on
Object. The latter means that you must initialize any fields or variables of
that type before they're used. This can make type parameters pretty hard to work with.

前者意味着除了在 Object 上定义的少数方法以外，不能调用其他的任何方法。
后者意味着这个类型的任何字段或变量都需要在使用前被初始化。
这就会让类型参数非常难处理。

In practice, a few patterns show up. In collection-like classes where the type
parameter can be instantiated with any type at all, you just have to deal with
the restrictions. In most cases, like the example here, it means ensuring you do
have access to a value of the type argument's type whenever you need to work
with one. Fortunately, collection-like classes rarely call methods on their
elements.

实际上，有一些模式已经在这么处理了。
比如一个类似集合的类在实例化时，类型参数可以使用任何类型。
您只需要在使用实例时，用合适的方式处理类型相关的约束即可。
而在像此处的例子一样的大部分场景中，这样做意味着每当您需要使用类型参数的类型的值时，
都可以确保您能访问这个值。
幸运的是，类似集合的类很少直接在其元素上调用方法。

In places where you don't have access to a value, you can make the use of the
type parameter nullable:

在您不需要访问值的时候，您可以将类型参数变为可空：

```dart
// Using null safety:
class Box<T> {
  T? object;
  Box.empty();
  Box.full(this.object);
}
```

Note the `?` on the declaration of `object`. Now the field has an explicitly
nullable type, so it is fine to leave it uninitialized.

注意此处对于 `object` 声明的 `?`。
现在这个字段是一个显式的可空类型，所以它可以是未被初始化的。

When you make a type parameter type nullable like `T?` here, you may need to
cast the nullability away. The correct way to do that is using an explicit `as
T` cast, *not* the `!` operator:

当您将类型参数像此处一样变为可空类型时，您可能需要强制将它转换为非空类型。
正确的做法是显式地使用 `as T` 进行转换，**而不是**使用 `!` 操作符。

```dart
// Using null safety:
class Box<T> {
  final T? object;
  Box.empty();
  Box.full(this.object);

  T unbox() => object as T;
}
```

The `!` operator *always* throws if the value is `null`. But if the type
parameter has been instantiated with a nullable type, then `null` is a perfectly
valid value for `T`:

如果值为 `null`，使用 `!` 操作符**一定**会抛出异常。
但是如果类型参数已被声明为一个可空的类型，那么 `null` 对于 `T` 就是一个完全有效的值：

```dart
// Using null safety:
main() {
  var box = Box<int?>.full(null);
  print(box.unbox());
}
```

This program should run without error. Using `as T` accomplishes that. Using
`!` would throw an exception.

这段代码可以正常运行，完全归功于使用了 `as T`，而如果使用 `!` 就会抛出异常。

Other generic types have some bound that restricts the kinds of type arguments
that can be applied:

其他的泛型也存在一些限制可用类型参数类别的类型约束：

```dart
// Using null safety:
class Interval<T extends num> {
  T min, max;

  Interval(this.min, this.max);

  bool get isEmpty => max <= min;
}
```

If the bound is non-nullable, then the type parameter is also non-nullable. This
means you have the restrictions of non-nullable types&mdash;you can't leave
fields and variables uninitialized. The example class here must have a
constructor that initializes the fields.

如果类型的约束是非空的，那么类型参数也是非空的。
这就意味着您会受到非空类型的一些限制，即必须要初始化字段和变量。
示例中的类必须要有构造函数来对字段进行初始化。

In return for that restriction, you can call any methods on values of the type
parameter type that are declared on its bound. Having a non-nullable bound does,
however, prevent *users* of your generic class from instantiating it with a
nullable type argument. That's probably a reasonable limitation for most
classes.

这些限制同时也带来了一些好处，您可以调用类型参数继承自其类型约束的任何方法。
当然，非空的类型约束会阻止**使用者**用可空的类型参数对泛型进行实例化。
对于大部分类来说，这也是合理的限制。

You can also use a nullable *bound*:

您也可以使用可空的**类型约束**：

```dart
// Using null safety:
class Interval<T extends num?> {
  T min, max;

  bool get isEmpty {
    var localMin = min;
    var localMax = max;

    // No min or max means an open-ended interval.
    if (localMin == null || localMax == null) return false;
    return localMax <= localMin;
  }
}
```

This means that in the body of the class you get the flexibility of treating the
type parameter as nullable. Note we have no constructor this time, and that's
OK. The fields will be implicitly initialized to `null`. You can declare
uninitialized variables of the type parameter's type.

这意味着在类的主体中，您拥有了将类型参数作为可空类型来处理的灵活性。
请注意，这一次我们没有构造函数，但这也是没问题的。
字段将会被隐式初始化为 `null`。
您可以将未初始化的变量声明为类型参数的类型。

But you also have the limitations of nullability&mdash;you can't call anything
on a variable of that type unless you deal with the nullability first. In the
example here, we copy the fields in local variables and check those locals for
`null` so that flow analysis promotes them to non-nullable types before we use
`<=`.

但您也受到了可空性的限制，除非您先处理了可空状态，否则您无法调用变量的任何方法。
在此处的例子中，我们将字段拷贝至局部变量，并且检查了它们是否为 `null`，
所以在我们调用 `<=` 前，流程分析将它们提升成了非空类型。

Note that a nullable bound does not prevent users from instantiating the class
with non-nullable types. A nullable bound means that the type argument *can* be
nullable, not that it *must*. (In fact, the default bound on type parameters if
you don't write an `extends` clause is the nullable bound `Object?`.) There is
no way to *require* a nullable type argument. If you want uses of the type
parameter to reliably be nullable, you can use `T?` inside the body of the
class.

请注意，可空的类型约束并不会阻止用户使用非空类型对类进行实例化。
一个可空的类型约束意味着类型参数**可以**为空，而不是**必须**为空。
（实际上，如果您没有写上 `extends` 语句，类型参数的默认类型约束是可空的 `Object?`。）
您没有办法声明一个**必需的**可空类型参数。
如果您希望确保类型参数一定是可空的，您可以在类的主体中使用 `T?`。

## Core library changes

## 核心库的改动

There are a couple of other tweaks here and there in the language, but they are
minor. Things like the default type of a `catch` with no `on` clause is now
`Object` instead of `dynamic`. Fallthrough analysis in switch statements uses
the new flow analysis.

我们在语言上还有一些其他微小的细节调整。
例如没有使用 `on` 的 `catch` 现在返回的默认类型是 `Object` 而不是 `dynamic`。
同时，switch 语句中的条件贯穿分析也使用了新的流程分析。

The remaining changes that really matter to you are in the core libraries.
Before we embarked on the Grand Null Safety Adventure, we worried that it would
turn out there was no way to make our core libraries null safe without massively
breaking the world. It turned out not so dire. There *are* a few significant
changes, but for the most part, the migration went smoothly. Most core libraries
either did not accept `null` and naturally move to non-nullable types, or do and
gracefully accept it with a nullable type.

剩余的重要改动，都存在于核心库中。
在我们开始这次的空安全大冒险之前，我们曾经担心过，
为了让核心库用上空安全，也许我们要对现有的语言系统做出大规模的破坏性改动。
而结果并没有想象中的那么可怕。
尽管确实**有**一些重大的变化，但在大部分情况下，迁移进行得十分顺利。
大多数的核心库要么不接受 `null` ，从而自然地使用了非空的类型，
要么接受了 `null`，并且优雅地处理了可空类型。

There are a few important corners, though:

不过，这里还有一些比较重要的变动细节：

### The Map index operator is nullable

### Map 的索引操作符是可空的

This isn't really a change, but more a thing to know. The index `[]` operator on
the Map class returns `null` if the key isn't present. This implies that the
return type of that operator must be nullable: `V?` instead of `V`.

这其实算不上一个改动，但您应该了解一下。
Map 类的 `[]` 操作符会在键值不存在时返回 `null`。
这就暗示了操作符的返回类型必须是可空的 `V?` 而不是 `V`。

We could have changed that method to throw an exception when the key isn't
present and then given it an easier-to-use non-nullable return type. But code
that uses the index operator and checks for `null` to see if the key is absent
is very common, around half of all uses based on our analysis. Breaking all of
that code would have set the Dart ecosystem aflame.

我们本可以在键值不存在时抛出异常，并且将返回类型改为更易使用的非空类型。
但是，通过索引操作符判断 `null` 来确认键值是否存在，是一个非常常见的操作，
经过我们的分析，大约有一半的操作是这样的用途。
如果破坏了这些代码，会直接摧毁 Dart 的生态系统。

Instead, the runtime behavior is the same and thus the return type is obliged
to be nullable. This means you generally cannot immediately use the result of
a map lookup:

实际上，运行时的行为还是一样的，因此返回类型必须是可空的。
这意味着您无法在 Map 查询时立马使用查询的结果：

```dart
// Using null safety, incorrectly:
var map = {'key': 'value'};
print(map['key'].length); // Error.
```

This gives you a compile error on the attempt to call `.length` on a nullable
string. In cases where you *know* the key is present you can teach the type
checker by using `!`:

这段代码会在 `.length` 的调用处抛出一个编译异常，因为您尝试调用可空的字符串。
在您已经**确定**键值存在的情况下，您可以给类型检查器上一个 `!`：

```dart
// Using null safety:
var map = {'key': 'value'};
print(map['key']!.length); // OK.
```

We considered adding another method to Map that would do this for you: look up
the key, throw if not found, or return a non-nullable value otherwise. But what
to call it? No name would be shorter than the single-character `!`, and no
method name would be clearer than seeing a `!` with its built-in semantics right
there at the call site. So the idiomatic way to access a known-present element
in a map is to use `[]!`. You get used to it.

我们曾经考虑过为 Map 增加另一个方法，帮助您办到这件事：
查找键值，如果没找到则抛出异常，否则返回一个非空值。
但是我们应该怎么称呼它？
任何名字都不如一个 `!` 来的简短，也没有任何一个方法的名字会比一个 `!` 的调用语义更清晰。
所以，在 Map 查找一个已知存在的元素的方法是 `[]!`。
相信您会慢慢习惯的。

### No unnamed List constructor

### 去除 List 的非命名构造

The unnamed constructor on `List` creates a new list with the given size but
does not initialize any of the elements. This would poke a very large hole in
the soundness guarantees if you created a list of a non-nullable type and then
accessed an element.

`List` 的非命名构造函数会创建一个给定大小的列表，但是并没有为任何元素进行初始化。
如果您创建了一个非空类型的列表，接着访问了其中一个元素，这将会是巨大的漏洞。

To avoid that, we have removed the constructor entirely. It is an error to call
`List()` in null safe code, even with a nullable type. That sounds scary, but
in practice most code creates lists using list literals, `List.filled()`,
`List.generate()`, or as a result of transforming some other collection. For
the edge case where you want to create an empty list of some type, we added a
new `List.empty()` constructor.

为了避免这样的情况发生，我们将这个构造函数完全移除了。
在空安全的代码中，就算是一个可空的类型，调用 `List()` 都会抛出错误。
听起来有点吓人，但在实际开发中，大部分的代码都通过
字面量、`List.filled()`、`List.generate()` 或是通过其他集合转换来创建列表。
为了一些极端情况，比如您需要创建某个类型的一个空的列表，我们新增了 `List.empty()` 构造。

The pattern of creating a completely uninitialized list has always felt out of
place in Dart, and now it is even more so. If you have code broken by this,
you can always fix it by using one of the many other ways to produce a list.

在 Dart 中，创建一个完全未初始化的列表，总是感觉不太对劲，以前是，现在更是。
如果您的代码因为这项改动而被影响了，您随时可以通过其他方法来生成一个列表。

### Cannot set a larger length on non-nullable lists

### 不能对非空的列表设置更大的长度

This is little known, but the `length` getter on `List` also has a corresponding
*setter*. You can set the length to a shorter value to truncate the list. And
you can also set it to a *longer* length to pad the list with uninitialized
elements.

`List` 的 `length` getter 也有一个对应的 setter，这一点鲜为人知。
您可以对列表设置一个较短的长度，从而截断它。
您也可以对列表设置一个**更长的**长度，从而使用未初始化的元素填充它。

If you were to do that with a list of a non-nullable type, you'd violate
soundness when you later accessed those unwritten elements. To prevent that, the
`length` setter will throw a runtime exception if (and only if) the list has a
non-nullable element type *and* you set it to a *longer* length. It is still
fine to truncate lists of all types, and you can grow lists of nullable types.

如果您对一个非空的列表做了这样的操作，在访问未初始化的元素时，就与空安全的健全性发生了冲突。
为了防止意外发生，现在对一个非空类型的数组调用调用 `length` setter，
**并且**准备设置一个**更长的**长度时，会在运行时抛出一个异常。
您仍然可以对任何类型的列表进行截断，也可以对一个可空类型的列表进行填充。

There is an important consequence of this if you define your own list types that
extend `ListBase` or apply `ListMixin`. Both of those types provide an
implementation of `insert()` that previously made room for the inserted element
by setting the length. That would fail with null safety, so instead we changed
the implementation of `insert()` in `ListMixin` (which `ListBase` shares) to
call `add()` instead. Your custom list class should provide a definition of
`add()` if you want to be able to use that inherited `insert()` method.

如果您自定义了列表的类型，例如继承了 `ListBase` 或者混入了 `ListMixin`，
那么这项改动可能会造成较大的影响。
以上的两种类型都提供了 `insert()` 的实现，通过设置长度，为插入的元素提供空间。
在空安全中这样做可能会出现错误，所以我们将它们的 `insert()` 实现改为了 `add()`。
现在您自定义的列表应该继承 `add()` 方法。

### Cannot access Iterator.current before or after iteration

### 在迭代前后不能访问 Iterator.current

The `Iterator` class is the mutable "cursor" class used to traverse the elements
of a type that implements `Iterable`. You are expected to call `moveNext()`
before accessing any elements to advance to the first element. When that method
returns `false`, you have reached the end and there are no more elements.

`Iterable` 是一个可变的“游标”类，用于遍历 `Iterable` 类型的元素。
在访问任何元素之前，您都需要调用 `moveNext()` 来跳到第一个元素。
当方法返回了 `false` 时，意味着您到达了终点，已经没有更多元素了。

It used to be that `current` returned `null` if you called it either before
calling `moveNext()` the first time or after iteration finished. With null
safety, that would require the return type of `current` to be `E?` and not `E`.
That in turn means every element access would require a runtime `null` check.

在以前，在首次调用 `moveNext()` 前，或者在迭代结束后，调用 `current` 会返回 `null`。
有了空安全，就要求 `current` 的返回类型是 `E?` 而不是 `E`。
这样的返回类型意味着在运行时，所有元素的访问前都需要检查是否为 `null`。

Those checks would be useless given that almost no one ever accesses the current
element in that erroneous way. Instead, we have made the type of `current` be
`E`. Since there *may* be a value of that type available before or after
iterating, we've left the iterator's behavior undefined if you call it when you
aren't supposed to. Most implementations of `Iterator` throw a `StateError`.

鉴于目前几乎没有人会以这种错误的方式访问当前元素，这些检查其实毫无用处。
所以我们将 `current` 的返回类型确定为 `E`。
由于迭代前后**有可能**会有一个对应类型的值出现，
当您在不应该调用它的时候调用迭代器时，我们让迭代器的行为保持为未定义。
对于 `Iterator` 的大部分实现都将抛出 `StateError` 异常。

## Summary

## 总结

That is a very detailed tour through all of the language and library changes
around null safety. It's a lot of stuff, but this is a pretty big language
change. More importantly, we wanted to get to a point where Dart still feels
cohesive and usable. That requires changing not just the type system, but a
number of other usability features around it. We didn't want it to feel like
null safety was bolted on.

这是一场非常详尽的空安全旅途，途中走遍了所有语言和库的变更。
这其中的内容真的很多，但是这也是一项非常大的语言变更。
更重要的是，我们希望 Dart 仍然让您感到好用且具备一致性。
所以不仅类型系统需要作出变动，一些可用性的特性也同时围绕着一起改变。
我们不希望空安全仅仅是拿螺栓固定的糟糕特性。

The core points to take away are:

您需要掌握的核心要点有：

*   Types are non-nullable by default and made nullable by adding `?`.

    类型默认是非空的，可以添加 `?` 变为可空的。

*   Optional parameters must be nullable or have a default value. You can use
    `required` to make named parameters non-optional. Non-nullable top-level
    variables and static fields must have initializers. Non-nullable instance
    fields must be initialized before the constructor body begins.

    可选参数必须是可空的或者包含默认值的。
    您可以使用 `required` 来构建一个非可选命名参数。
    非空的全局变量和静态字段必须在声明时被初始化。
    实例的非空字段必须在构造体开始执行前被初始化。

*   Method chains after null-aware operators short circuit if the receiver is
    `null`. There are new null-aware cascade (`?..`) and index (`?[]`)
    operators. The postfix null assertion "bang" operator (`!`) casts its
    nullable operand to the underlying non-nullable type.

    如果接收者为 `null`，那么在其避空运算符之后的链式方法调用都会被截断。
    我们引入了新的空判断级联操作符 (`?..`) 及索引操作符 (`?[]`)。
    后缀空断言“重点”操作符 (`!`) 可以将可空的操作对象转换为对应的非空类型。

*   Flow analysis lets you safely turn nullable local variables and parameters
    into usable non-nullable ones. The new flow analysis also has smarter rules
    for type promotion, missing returns, unreachable code, and variable
    initialization.

    新的流程分析，让您更安全地将可空的局部变量和参数，转变为可用的非空类型。
    它同时还对类型提升、遗漏的返回、不可达的代码以及变量的初始化，有着更为智能的规则。

*   The `late` modifier lets you use non-nullable types and `final` in places
    you otherwise might not be able to, at the expense of runtime checking. It
    also gives you lazy-initialized fields.

    `late` 修饰符以在运行时每次都进行检查的高昂代价，
    让您在一些原本无法使用的地方，能够使用非空类型和 `final`。
    它同时提供了对字段延迟初始化的支持。

*   The `List` class is changed to prevent uninitialized elements.

    `List` 类现在不再允许包含未初始化的元素。

Finally, once you absorb all of that and get your code into the world of null
safety, you get a sound program that the compilers can optimize and where every
place a runtime error can occur is visible in your code. We hope you feel that's
worth the effort to get there.

最后，当您吸收了这篇文章的所有内容，并且将您的代码真正带到空安全的世界中时，
您会得到一个健全的、编译器可以进行优化的程序，
并且在您的代码中，您可以看到每一个运行时可能出错的地方。
希望您的一切努力都是值得的。
