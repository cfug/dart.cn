---
# title: "Dart extension method fundamentals"
title: "Dart 扩展方法基础"
# description: "Read about the design considerations behind extension methods, a new feature landing in a future Dart SDK release"
description: "了解扩展方法背后的设计考量，这是即将在未来 Dart SDK 版本中登场的新特性"
ai-translated: true
publishDate: 2019-11-05
author: lrhn
image: images/1D57vLbx-SwCUSnLXA9zHRQ.webp
category: other
layout: blog
---


## Dart Extension Methods Fundamentals

## Dart 扩展方法基础

<DashImage src="images/1D57vLbx-SwCUSnLXA9zHRQ.webp" alt="Code snippet with extension method names and stack trace comments next to the Dart logo." />


In a future release, the Dart language is adding a new feature, *extension methods*, which allows you to (pretend to) add new members to existing types. An extension method can be invoked just like a normal method, `o.extensionMethod(42)`, even though it really is just a static function.

在未来的版本中，Dart 语言将加入一个新特性：*扩展方法（extension methods）*，
它允许你（假装）为已有类型添加新成员。扩展方法可以像普通方法一样调用，
比如 `o.extensionMethod(42)`，尽管它实际上只是一个静态函数。

Why are we adding extension methods? What are they good for? How do you use them? And why do I call them “extension *methods*” when you can add other members too? (The last one is easy: I personally think of them as extension *members*, but “extension methods” was the working title, and it’s what the similar feature is called in other languages, so in good Dart tradition, we went for the familiar and unsurprising name. I won’t be needing extension getters, setters or operators here, but you can totally add a `%` operator to `String` if you want to, no matter what we call the feature.)

我们为什么要加入扩展方法？它们有什么用？怎么使用？
以及既然还能添加其他成员，为什么我管它们叫“扩展*方法*”？
（最后一个问题很好回答：我个人把它们视为扩展*成员*，
但“扩展方法”是这个特性的工作标题，也是其他语言中类似特性的叫法，
所以秉承 Dart 的一贯传统，我们选了大家熟悉、不出意料的名字。
本文用不到扩展 getter、setter 或运算符，但只要你想，
完全可以给 `String` 加个 `%` 运算符，不管我们把这个特性叫什么。）

Since I’m one of the people who designed the feature, I’ll opportunistically answer all these questions before anyone else has a chance. (And, because I released this article before we finished the feature, I’ve even gotten to edit out the things that are no longer true!)

既然我是设计这个特性的人之一，我就趁机抢在别人前面把这些问题都回答了。
（而且，因为我在特性完成之前就发布了这篇文章，
我甚至还能把已经不再成立的内容删改掉！）

But first, a detour!

不过，先绕个弯！

## What I Would Have Done Before Extension Methods

## 没有扩展方法之前我会怎么做

Assume, purely hypothetically, that I think the [`catchError`](https://api.dartlang.org/stable/2.5.0/dart-async/Future/catchError.html) function on [`Future`](https://api.dartlang.org/stable/2.5.0/dart-async/Future-class.html) is awful and should be replaced by something newer, shinier and better. Say, because it takes a[`Function`](https://api.dartlang.org/stable/2.5.0/dart-core/Function-class.html) as argument instead of a proper function type, which it does for perfectly reasonable *historical* reasons, and that means you won’t get any static type checking. That is bad, and the method should feel bad.

纯粹假设一下：我认为 [`Future`](https://api.dartlang.org/stable/2.5.0/dart-async/Future-class.html)
上的 [`catchError`](https://api.dartlang.org/stable/2.5.0/dart-async/Future/catchError.html)
函数很糟糕，应该换成更新、更闪亮、更好的东西。比如说，
因为它接受的是 [`Function`](https://api.dartlang.org/stable/2.5.0/dart-core/Function-class.html)
而不是真正的函数类型作为参数——这是出于完全合理的*历史*原因——
这意味着你得不到任何静态类型检查。这很糟糕，这个方法应该感到羞愧。

Obviously I can’t remove the function, that would break, like, every serious Dart program *ever*.

显然我不能删掉这个函数，那样会搞坏几乎*每一个*正经的 Dart 程序。

Then I’d want to at least add a new method to `Future&lt;T&gt;` so that users can use that one instead, say one like:

那我至少想给 `Future&lt;T&gt;` 加一个新方法，让用户改用它，比如这样：

```dart
abstract class Future<T> {
  ...
  /// Catches any [error] of type [E].
  Future<T> onError<E>(FutureOr<T> handleError(E error, StackTrace stack)) =>
      this.catchError(...something clever...);
}
```

which you can call as:

你可以这样调用它：

```dart
Future<int> eventualInteger = ...;
eventualInteger.onError((FormatException e, s) => ...).then(...);
```

Sadly, I can’t just add that to the `Future` class. If I do that, I also add it to the `Future` interface, and any other class implementing that interface will then be incomplete and will no longer compile. At some point we counted 76 classes implementing `Future`. That was a while ago, and we’ve stopped counting. We still can't break everybody, so that option is also not on the table.

遗憾的是，我不能就这么把它加进 `Future` 类。如果这么做，
我也把它加进了 `Future` 接口，那么实现该接口的其他所有类都会变得不完整，
无法再编译。我们曾数过有 76 个类实现了 `Future`。那是一段时间以前的事了，
后来我们就不数了。我们仍然不能把所有人都搞坏，所以这个选项也不在考虑之列。

Well, then I’ll use a static helper function:

好吧，那我用一个静态辅助函数：

```dart
Future<T> onFutureError<T, E>(Future<T> source, 
    FutureOr<T> handleError(E error, StackTrace stack)) =>
  source.catchError(...something clever...);
```

which you can call as:

你可以这样调用它：

```dart
Future<int> eventualInteger = ...;
onFutureError(eventualInteger, 
    (FormatException e, s) => ...).then(...);
```

Almost as sadly, that simply doesn’t read well. We *like* using `.`-based method chaining because it allows us to read from left to right: “Do this, then do that, then do something more”. Using the static helper function forces us to read it as: “Do that to the following: Do this. After that, do something more” … say what? It just doesn't have the same *flow*, the same *schwung*. It's darn nigh unreadable in practice.

同样遗憾的是，这样读起来实在不顺。我们*喜欢*基于 `.` 的方法链式调用，
因为它让我们可以从左往右读：“做这个，然后做那个，再做点别的”。
使用静态辅助函数则迫使我们这样读：“对下面这个东西做那件事：先做这个。
之后再做点别的”……啥？它没有同样的*流畅感*、同样的*气势*。
实践中它简直没法读。

OK then, I’m undeterred in my quest, so instead of improving the `Future` class, I'll introduce a new and improved interface and give users a way to wrap the old interface:

好吧，我在这条探索之路上不为所动。既然不改 `Future` 类，
我就引入一个全新的改进版接口，并给用户一种包装旧接口的方式：

```dart
class MyFuture<T> {
  Future<T> _wrappee;
  MyFuture(Future<T> future) : _wrappee = future;
  Future<T> onError<E>(
      FutureOr<T> handleError(E error, StackTrace stack)) =>
    _wrappee.catchError(...something clever...);
}
```

which you can use as:

你可以这样使用它：

```dart
Future<int> eventualInteger = ...;
MyFuture(eventualInteger).onError(
    (FormatException e, s) => ...).then(...);
```

I’d probably even let `MyFuture` implement `Future` and forward all the `Future` members to the `_wrappee` future, and then also let all the methods return a `MyFuture` wrapper again, so I can keep going.

我可能还会让 `MyFuture` 实现 `Future`，把所有 `Future` 成员
转发给被包装的 `_wrappee` future，再让所有方法都重新返回 `MyFuture` 包装器，
这样就可以一直链式调用下去。

```dart
class MyFuture<T> {
  Future<T> _wrappee;
  MyFuture(Future<T> future) : _wrappee = future;
  MyFuture<R> then<R>(...) => MyFuture(_wrappee.then<R>(...));
  /// Forward other `Future` methods too.
  MyFuture<T> onError<E>(
      FutureOr<T> handleError(E error, StackTrace stack)) =>
    MyFuture(_wrappee.catchError(...something clever...));
}
```

Nice and smooth, if I do say so myself!

漂亮又流畅，容我自夸一下！

This was pretty much as good as it got, back before extension methods … which meant manually adding the wrapper and taking the performance hit from the extra wrapper objects and intermediate forwarding functions.

在扩展方法出现之前，这基本就是能做到的极限了……
这意味着要手动加上包装器，还要承受额外包装对象和中间转发函数带来的性能损耗。

## What I Will Do With Extension Methods

## 有了扩展方法之后我会怎么做

Once we’re out of the dark no-extension ages, I can use extension methods to get what I really, really want. I’ll write:

一旦走出没有扩展方法的黑暗时代，我就能用扩展方法得到我真正、真正想要的东西。
我会这样写：

```dart
extension MyFuture<T> on Future<T> {
  Future<T> onError<E>(
      FutureOr<T> handleError(E error, StackTrace stack)) =>
    this.catchError(...something clever...);
}
```

and then you can call it as:

然后你就可以这样调用：

```dart
Future<int> eventualInteger = ...;
eventualInteger.onError((FormatException e, s) => ...).then(...);
```

and that is all. Mission accomplished in five lines!

就这些。五行代码完成任务！

“But how does it *work*?”, you might ask. It works very well, thank you.

“可它是怎么*工作*的？”你可能会问。它工作得非常好，谢谢关心。

In truth, *it behaves almost exactly the same way as the wrapper class*, even though it really is just a static helper function. You can even write `MyFuture(eventualInteger).onError(...)` explicitly, as if the extension was a wrapper class. It isn't, but it looks and acts *almost* as if it was. And you can omit the explicit wrapping and have it *implicitly* applied when the types are right.

实际上，*它的行为几乎和包装类一模一样*，尽管它真的只是一个静态辅助函数。
你甚至可以显式地写 `MyFuture(eventualInteger).onError(...)`，
就好像扩展是个包装类一样。它并不是，但看起来、用起来*几乎*就是。
而且当类型合适时，你可以省略显式包装，让它*隐式*生效。

## It’s (not) a Wrapper Class

## 它（不）是包装类

The design of the `extension` declaration is deliberately made so that it looks like a `class` or `mixin` declaration, and it acts just as if it was a wrapper class with a hidden `_wrappee`. You can even have static members in the declaration, and they work just like static members on a `class` or `mixin` declaration.

`extension` 声明的设计刻意让它看起来像 `class` 或 `mixin` 声明，
行为也就像一个藏着 `_wrappee` 的包装类。你甚至可以在声明里定义静态成员，
它们的用法和 `class` 或 `mixin` 声明中的静态成员完全一样。

There is one *improvement* over the wrapper class: You can write `this` inside instance members to refer to the `_wrappee` instead of the wrapper object.

相比包装类有一处*改进*：你可以在实例成员内部写 `this`，
它指向 `_wrappee` 而不是包装对象。

Changing the meaning of `this` was not just an improvement. These are *static* extension methods, and as I said earlier, they are really just a more convenient way to call static functions. That means that there is no wrapper *object*. It never existed, we just pretended that it did, but that means that we can't let `this` refer to the non-existing object.

改变 `this` 的含义不仅仅是一处改进。这些是*静态*扩展方法，
正如我前面所说，它们实际上只是调用静态函数的一种更方便的方式。
这意味着不存在包装*对象*。它从未存在过，我们只是假装有，
但这也意味着我们不能让 `this` 指向一个不存在的对象。

We also can't allow you to use `MyFuture(eventualInteger)` as a value, so if you try to do `var myFuture = MyFuture(eventualInteger)`, we won't allow it. The only way to use `MyFuture(eventualInteger)` is as the target of an extension member invocation.

我们也不能允许你把 `MyFuture(eventualInteger)` 当作值来用，
所以如果你尝试 `var myFuture = MyFuture(eventualInteger)`，我们不会允许。
`MyFuture(eventualInteger)` 唯一的用法是作为扩展成员调用的目标。

```
MyFuture(eventualInteger).onError(...); // GOOD: Use to call method.
var x = MyFuture(eventualInteger); // BAD: Use as stand-alone value.
```


It’s the same as how you can use `super` to call methods, but not for its value. Or just like a library prefix. All you can do is access a member; you cannot treat it as a value because it has no value, and there is no value for it to have.

这就像你可以用 `super` 调用方法，却不能取它的值一样。
或者就像库前缀（library prefix）。你只能访问成员；
不能把它当作值，因为它没有值，也不存在可供它拥有的值。

Because there is no object, you can’t declare *instance fields* in an `extension` declaration. You *can* declare getters and setters though, and perhaps even back them by an [`Expando`](https://api.dartlang.org/stable/2.5.1/dart-core/Expando-class.html). An extension also cannot declare any constructors since nothing is being constructed; it just pretends to have a constructor taking the wrappee object.

因为没有对象，你不能在 `extension` 声明中声明*实例字段*。
但你*可以*声明 getter 和 setter，甚至可以用
[`Expando`](https://api.dartlang.org/stable/2.5.1/dart-core/Expando-class.html)
为它们提供存储。扩展也不能声明任何构造函数，因为没有任何东西被构造；
它只是假装有一个接受被包装对象的构造函数。

## It Does (not) Extend the Type

## 它（没有）扩展类型

If you had to write the `MyFuture(...)` wrapping every time you used an extension member, then it wouldn't be much of an improvement. We could probably just write the wrapper classes directly and spend some compiler engineer hours ensuring that we optimize away the intermediate object.

如果每次使用扩展成员都得写一遍 `MyFuture(...)` 包装，
那就谈不上多大改进了。我们大概不如直接写包装类，
再花些编译器工程师的工时确保把中间对象优化掉。

I said above that you can write `eventualInteger.onError(...)`. This works because we *implicitly wrap* expressions based on their static type and the name of the member they call. We automatically wrap `expr.method()` as `Ext(expr).method()` when all of the following are true:

我上面说过你可以写 `eventualInteger.onError(...)`。
这之所以可行，是因为我们根据表达式的静态类型和它调用的成员名
来*隐式包装*表达式。当以下条件全部满足时，
我们会自动把 `expr.method()` 包装成 `Ext(expr).method()`：

* The static type of `expr` does not have a member with (base-)name `method` (the interface always wins).

  `expr` 的静态类型没有（基）名为 `method` 的成员（接口永远优先）。

* The extension `Ext` is imported or declared in the current library scope (the extension is *accessible*).

  扩展 `Ext` 已导入或在当前库作用域中声明（扩展是*可访问的*）。

* The extension declares a member with base-name `method`, *and* the static type of `expr` is a subtype of the `on` type of the `Ext` declaration (the extension is *applicable*).

  扩展声明了基名为 `method` 的成员，*并且* `expr` 的静态类型是
  `Ext` 声明的 `on` 类型的子类型（扩展是*可应用的*）。

If there is more than one accessible and applicable extension for a member invocation, there are rules about which one will win the conflict. In some cases, there’s no way to pick a winner, and then it’s just a compile-time error. These rules depend only on the extension declaration’s `on` type, not on member declaration. (Dart does not have “overloading” — multiple methods with the same name and different signatures, which you choose between based on the argument structure or types — and extension methods do not provide a back-door to get overloading.)

如果一次成员调用有多个可访问且可应用的扩展，
有规则决定谁赢得冲突。某些情况下无法选出胜者，那就直接是编译时错误。
这些规则只取决于扩展声明的 `on` 类型，与成员声明无关。
（Dart 没有“重载”——即同名但签名不同、根据参数结构或类型来选择的多个方法——
扩展方法也没有提供获得重载的后门。）

## It Is All Static

## 一切都是静态的

I said “s*tatic* extension methods” above, and I did so for a reason!

我上面说的是“*静态*扩展方法”，这可是有原因的！

Dart is statically typed. The compiler knows the type of every expression at compile-time, so if you write `target.member(42)`, and `member` is an extension member, then the compiler needs to figure out *which* extension to implicitly wrap `target` with, in order to find the type of the entire member invocation.

Dart 是静态类型的。编译器在编译时就知道每个表达式的类型，
所以如果你写 `target.member(42)`，而 `member` 是扩展成员，
编译器就需要弄清楚该用*哪个*扩展来隐式包装 `target`，
才能确定整个成员调用的类型。

If implicit extension wrapping has to happen *between* finding the type of the target expression *and* finding the type of the member invocation, it seems obvious that “extension inference” has to happen during the increasingly more inaccurately named “type inference” phase. That’s the phase which is mostly known for filling in missing generics.

既然隐式扩展包装必须发生在确定目标表达式类型*与*
确定成员调用类型*之间*，那么显然“扩展推断”必须发生在
名字越来越名不副实的“类型推断”阶段。这个阶段最出名的工作是补全缺失的泛型。

I did write `eventualInteger.onError((FormatException e, s) {...})`, even though both the `MyFuture` extension and the `onError` method are generic. While doing type inference, the Dart compiler both selects the extension and infers missing type arguments. Here it first decides to use the `MyFuture` extension, then inserts the implicit wrapper, and finally performs type inference for the extension application `MyFuture(eventualInteger).onError((FormatException e, s) {...})` in *exactly the same way* as it would for a corresponding wrapper class:

我确实写了 `eventualInteger.onError((FormatException e, s) {...})`，
尽管 `MyFuture` 扩展和 `onError` 方法都是泛型的。在做类型推断时，
Dart 编译器既选择扩展，也推断缺失的类型实参。这里它先决定使用 `MyFuture` 扩展，
然后插入隐式包装器，最后对扩展应用
`MyFuture(eventualInteger).onError((FormatException e, s) {...})`
执行类型推断，方式与对应的包装类*完全相同*：

```dart
class MyFuture<T> {
  Future<T> _wrappee;
  MyFuture(Future<T> future) : _wrappee = future;
  MyFuture<T> onError<E>(
      FutureOr<T> handleError(E error, StackTrace stack)) =>
    _wrappee.catchError(...something clever...);
}
```

In this case, the type inference would infer the following extension application and complete types for the invocation:

在这个例子中，类型推断会推断出下面的扩展应用，并补全调用的完整类型：

```dart
MyFuture<int>(eventualInteger).onError<FormatException>(
    (FormatException e, StackTrace s) {...});
```

This means that *the type arguments to the extension are based on the static type of the wrapped expression*. If you have a `Future&lt;num&gt; fut = Future&lt;int&gt;.value(42);` then `fut.onError(...)` will bind the `T` type parameter of `MyFuture` to `num` at compile-time, not to `int`. It's all static, just as for any other inferred type arguments.

这意味着*扩展的类型实参基于被包装表达式的静态类型*。
如果你有 `Future&lt;num&gt; fut = Future&lt;int&gt;.value(42);`，
那么 `fut.onError(...)` 会在编译时把 `MyFuture` 的 `T` 类型参数
绑定到 `num`，而不是 `int`。一切都是静态的，与其他推断出的类型实参一样。

That also means that you will never be able to call an extension member on a target typed as `dynamic`.

这也意味着你永远无法在类型为 `dynamic` 的目标上调用扩展成员。

## Conflict Resolution

## 冲突解决

As stated above, there are rules about which extension wins when there is more than one in scope which applies. Basically, the winner is the extension with an `on` type closest to the actual type of the expression you are calling a member on, with some caveats and tie-breakers. It usually “just works” for extensions which are written together. Instead of going into those details, I'll tell you what to do when it *doesn't* just work.

如上所述，当作用域中有多个可应用的扩展时，有规则决定哪个扩展获胜。
基本上，胜者是 `on` 类型与你调用成员的表达式的实际类型最接近的那个扩展，
另外还有一些注意事项和平局裁决规则。对于一起编写的扩展，
它通常“就是能用”。我不去展开那些细节，而是告诉你在它*不能*直接工作时该怎么办。

You might have a problem when two different authors have written conflicting extensions for the same type and member name. Say the extensions `Ext1` and `Ext2` both define a `bubbleSort` method that applies to your `List` object, and either there is no clear winner of the conflict, or the one which wins is not the one you actually want to call (say `Ext2` wins and you want to call `Ext1.bubbleSort`). Then you have to do *something*.

当两位不同的作者为同一类型和成员名编写了冲突的扩展时，你可能就会遇到问题。
假设扩展 `Ext1` 和 `Ext2` 都定义了适用于你的 `List` 对象的 `bubbleSort` 方法，
要么冲突没有明确的胜者，要么获胜的不是你真正想调用的那个
（比如 `Ext2` 赢了而你想调用 `Ext1.bubbleSort`）。那你就得做*点什么*。

The easiest solution is to use an explicit extension application: `Ext1(list).bubbleSort()`. This avoids the automatic resolution and just picks the one that you want. If you only have a few conflicts, then that's both easy and readable.

最简单的办法是使用显式扩展应用：`Ext1(list).bubbleSort()`。
这绕过了自动解析，直接选中你想要的那个。如果只有几处冲突，这既简单又可读。

However, if you have three hundred conflicts in the same file, then you might want to avoid the extra typing. It’s hard to change whether an extension is *applicable* to an invocation, but you can change whether it’s *accessible*.

不过，如果同一个文件里有三百处冲突，你可能就想少打点字了。
很难改变一个扩展对某次调用是否*可应用*，但你可以改变它是否*可访问*。

You do that by *hiding* the conflicting extension (or extension*s,* if you are really unlucky) where you import it: `import "ext2lib.dart" hide Ext2;`. Doing so will prevent the `Ext2` extension from being imported into the current library scope, which makes it not accessible. Obviously, so will not importing `ext2lib.dart` at all, but unless the extension is the only thing you use from that library, that’s not practical.

做法是在导入时*隐藏*冲突的扩展（如果你实在倒霉，可能是多个扩展）：
`import "ext2lib.dart" hide Ext2;`。这样 `Ext2` 扩展就不会被导入
当前库作用域，也就不可访问了。显然，完全不导入 `ext2lib.dart` 也有同样效果，
但除非那个库里你只用这一个扩展，否则不现实。

(Edited Dec. 11th) Here I used to say that you could import one of the conflicting extensions with a *prefix* and that then it would not be available for implicit use. Turns out that some people declare extension methods in the same library as the class they extend, and it is really annoying if that library doesn’t work when imported with a prefix. So we fixed that. Extensions imported with a prefix *do* work implicitly as well. If you really need to use two conflicting extension in the same library, you will have to use explicit extension application everywhere there is a conflict. We may consider adding a different way to disable implicit extensions in the future, at least if conflicting extensions turn out to be a recurring issue.

（12 月 11 日编辑）我以前在这里说，你可以用*前缀*导入冲突扩展之一，
这样它就不能隐式使用了。后来发现有些人把扩展方法声明在
被扩展类所在的同一个库里，如果那个库带前缀导入后就不能用，实在很烦人。
所以我们修复了这一点。带前缀导入的扩展*同样*可以隐式使用。
如果你真的需要在同一个库里使用两个冲突的扩展，
就只能在每处冲突都使用显式扩展应用。我们将来可能会考虑
添加其他方式来禁用隐式扩展，至少如果扩展冲突成为反复出现的问题的话。

## Summary

## 总结

Dart will get *extension methods* in an upcoming release *—* a pretty way to call static functions.

Dart 将在即将发布的版本中获得*扩展方法*——一种调用静态函数的优雅方式。

You can define extension members for **instance methods**, **operators**, **setters** and **getters**, but **not fields**.

你可以为**实例方法**、**运算符**、**setter** 和 **getter**
定义扩展成员，但**不能定义字段**。

You can invoke extension methods either explicitly or — when there’s no conflict with an interface member or another extension — implicitly:

你可以显式调用扩展方法，也可以在没有与接口成员或其他扩展冲突时隐式调用：

```
Ext1(list).bubbleSort() // Explicit, like it's a wrapper class.
list.bubbleSort()       // Implicitly, like it extends the type.
```


Implicit invocations work the same as explicit invocations, but they first *infer* which extension is being applied. If extension inference fails due to conflicting extensions, then you can do any one of the following:

隐式调用与显式调用的工作方式相同，只是它会先*推断*应用的是哪个扩展。
如果扩展推断因扩展冲突而失败，你可以任选以下做法：

* Apply the extension explicitly.

  显式应用扩展。

* Don’t import the conflicting extension at all (remove the import or hide the extension).

  干脆不导入冲突的扩展（移除导入或隐藏该扩展）。

* (Edited Dec 11th): And that is it (for now).

  （12 月 11 日编辑）：就这些了（暂时）。

Extensions are *static*. Everything about them is decided based on static types.

扩展是*静态*的。关于它们的一切都由静态类型决定。

Enjoy responsibly!

请理性享用！
