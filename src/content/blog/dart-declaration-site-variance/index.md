---
# title: "Dart declaration-site variance"
title: "Dart 声明处型变"
# description: "A deep dive into an experimental feature"
description: "深入了解一个实验性特性"
ai-translated: true
publishDate: 2019-12-19
author: kallentu
image: images/0XcEdm2vmIBW8Wovr.webp
category: deep-dive
layout: blog
---


<DashImage src="images/0XcEdm2vmIBW8Wovr.webp" alt="Graphic showing Dart declaration-site variance." />


Declaration-site variance was my internship project on the Dart team, and I’ve documented my personal experience on the team in the article [Life as a Dart intern](/blog/life-as-a-dart-intern). As the primary implementer of the [declaration-site variance feature](https://github.com/dart-lang/language/issues/524), I want to share the usages and benefits of sound variance.

声明处型变（declaration-site variance）是我在 Dart 团队实习时的项目，
我已经在 [Dart 实习生生活](/blog/life-as-a-dart-intern) 一文中
记录了我在团队中的个人经历。作为
[声明处型变特性](https://github.com/dart-lang/language/issues/524)的主要实现者，
我想分享可靠型变（sound variance）的用法和好处。

We’ll discuss how to use variance, why we want to use the modifiers, how the feature can build on top of classes that don’t use the modifiers, and what benefits this feature provides us.

我们将讨论如何使用型变、为什么要使用这些修饰符、
该特性如何构建在不使用修饰符的类之上，以及它能给我们带来哪些好处。

***Note:** The implementation of variance isn’t finished yet. Although you can play with it by enabling the experiment (instructions below), the feature might change before it’s finalized.*

***注意：**型变的实现尚未完成。虽然你可以通过启用实验来试用它
（说明见下文），但该特性在最终定稿前仍可能发生变化。*

Before diving into Dart’s declaration-site variance feature, we’ll take a quick detour to discuss what variance means and how it’s used.

在深入 Dart 的声明处型变特性之前，我们先绕个弯，
快速讨论一下型变的含义和用法。

## **What is variance?**

## **什么是型变？**

To briefly introduce variance, we can look at this example:

简单介绍一下型变，我们可以看这个例子：

```dart
main() {
  Iterable<Object> objectIterable = <int>[1, 2, 3];
}
```

From this, an `Iterable` of integers can be substituted as an `Iterable` of `Object`s because an integer *is* an `Object` and can be used in an `Iterable` in every place an `Object` would be. The language allows this by saying that two instantiations of the same generic type (like `Iterable&lt;int&gt;` and `Iterable&lt;Object&gt;` here) are considered subtypes if their type arguments (`int` and `Object`) are. This subtyping relation is considered **covariance**.

由此可见，整数的 `Iterable` 可以替换为 `Object` 的 `Iterable`，
因为整数*就是* `Object`，在任何需要 `Object` 的 `Iterable` 的地方
都可以使用整数。语言允许这样做，是因为它规定：同一泛型类型的两个实例化
（比如这里的 `Iterable&lt;int&gt;` 和 `Iterable&lt;Object&gt;`），
只要它们的类型实参（`int` 和 `Object`）之间是子类型关系，
它们就被视为子类型。这种子类型关系就是**协变（covariance）**。

This is convenient and logical. It makes sense, that is, until you take a look at the variance of the parameters of a method. Say you want to make a `objectWriter` in Dart:

这既方便又合乎逻辑。看起来合情合理——直到你考察方法参数的型变。
假设你想在 Dart 中创建一个 `objectWriter`：

```dart
class Writer<T> {
  void write(T x) => print(x);
}

main() {
  Writer<Object> objectWriter = Writer<int>();
  objectWriter.write(2);
}
```

Then you eagerly have your `objectWriter` write a `String` to discover that it produces a runtime error. The compiler allows this code, but when you run it, it throws an exception.

然后你兴冲冲地让 `objectWriter` 写入一个 `String`，
却发现它产生了运行时错误。编译器允许这段代码，但运行时它会抛出异常。

```dart
main() {
  // ...
  // Runtime error!
  // Unhandled exception: type 'String' is not a subtype of type 'int' of 'x'
  objectWriter.write("Hello world!");
}
```

Why is this? With **contravariance,** the subtyping relation is reversed compared to covariance. We need to be able to *write* any `Object` to the `objectWriter`, but from earlier we know that the `objectWriter` is actually a disguised writer of integers.

为什么会这样？对于**逆变（contravariance）**，
子类型关系与协变正好相反。我们需要能向 `objectWriter` *写入*任何 `Object`，
但前面我们已经知道，`objectWriter` 实际上是一个伪装的整数 writer。

The final variant type you will need to know about is **invariance**. Invariant subtyping relation means no subtype relation between two invariant types unless they are the *exact same* type.

你需要了解的最后一种型变是**不变（invariance）**。
不变的子类型关系意味着：两个不变类型之间不存在子类型关系，
除非它们是*完全相同*的类型。

```dart
class ReaderWriter<T> {
  void write(T x) => print(x);
  T read() => null;
}

main() {
  ReaderWriter<int> intRW = ReaderWriter<Object>();
  
  // Any object can be returned, not just integers. This is unsafe.
  intRW.read(); 

  ReaderWriter<Object> anotherObjectRW = ReaderWriter<int>();
  
  // We actually have an integer ReaderWriter. Error!
  anotherObjectRW.write(“Hello world!”); 
}
```

## **What is the variance feature in Dart?**

## **Dart 中的型变特性是什么？**

Since the Dart team proposed to add explicit variance modifiers to the language, we’ll preview some of the changes to expect.

既然 Dart 团队提议为语言添加显式型变修饰符，
我们就来预览一下可以期待的变化。

Dart will have variance modifiers that can be applied to type parameters in classes and mixins. The syntax is similar to variance modifiers in C#.

Dart 将提供可应用于类和 mixin 的类型参数的型变修饰符。
其语法与 C# 中的型变修饰符类似。

You can use the keywords `out`, `in`*,* and `inout`to declare a covariant, contravariant, and invariant type parameter respectively. This is used with generic types as such:

你可以使用关键字 `out`、`in` 和 `inout`
分别声明协变、逆变和不变的类型参数。在泛型类型中的用法如下：

```dart
class MyContravariantClass<in T> {}
mixin MyInvariantMixin<inout T> {}
```

## **Why define explicit variance for generic types? Why do we want this feature?**

## **为什么要为泛型类型定义显式型变？为什么我们需要这个特性？**

Dart’s static type system currently treats all type parameters as covariant. That’s correct and convenient for generics where the type is used in a safely covariant place like a return type. But it’s wrong when the type argument should be contravariant or invariant:

Dart 的静态类型系统目前把所有类型参数都视为协变。
对于类型用在安全协变位置（比如返回类型）的泛型来说，
这是正确且方便的。但当类型实参应该是逆变或不变时，这就错了：

```dart
class Writer<T> {
  void write(T x) => print(x);
}

main() {
  Writer<Object> objectWriter = Writer<int>();
  objectWriter.write(“I’m a string!”);
}
```

When you use `objectWriter`, you *expect* to be able to write any `Object`. Unfortunately, the `objectWriter` only writes integers. The compiler doesn’t know any better and when you run the code, you receive the dreaded runtime error. To avoid unsoundness, Dart throws an error at runtime if you use a type argument in an unsafe way.

使用 `objectWriter` 时，你*期望*能写入任何 `Object`。
遗憾的是，`objectWriter` 只能写入整数。编译器对此一无所知，
运行代码时你就会收到可怕的运行时错误。为了避免不健全（unsound）的情况，
如果你以不安全的方式使用类型实参，Dart 会在运行时抛出错误。

Fortunately, adding a variance modifier turns this incorrect use from a runtime error into a compile-time error.

幸运的是，加上型变修饰符后，
这种错误用法就从运行时错误变成了编译时错误。

```dart
// Add a contravariant variance modifier
class Writer<in T> {  
  void write(T x) => print(x);
}

main() {
  // Compile-time error: The constructor returns type 'Writer<int>'
  // that isn't of expected type 'Writer<Object>'.
  Writer<Object> objectWriter = Writer<int>();
}
```

This is much better. Long before you write `objectWriter.write("I'm a string!")`, the compiler will notify you that there’s something wrong.

这样好多了。远在你写出 `objectWriter.write("I'm a string!")` 之前，
编译器就会通知你有问题。

Now, let’s take a look at what adding safely typed parameters using a variance modifier provides you.

现在，我们来看看使用型变修饰符添加类型安全的参数能带来什么。

## **Type parameters in members**

## **成员中的类型参数**

If you mark a generic type parameter with `out`, the compiler emits a static error if you use that type in a method or field in a place that isn’t safely covariant like a return type. Likewise, a type parameter marked `in` can only be used in a place that is safely contravariant like a method parameter type. Type parameters marked `inout` can be used anywhere.

如果你把泛型类型参数标记为 `out`，当你在方法或字段中把该类型
用在非安全协变的位置（返回类型才是安全协变的位置）时，
编译器会报静态错误。同样，标记为 `in` 的类型参数只能用在
安全逆变的位置，比如方法参数类型。标记为 `inout` 的类型参数可以用在任何位置。

Here are some method variance position errors and correct usages that you may find helpful. The same error checking also occurs for mixins.

下面这些方法型变位置的错误和正确用法也许对你有帮助。
同样的错误检查也适用于 mixin。

```dart
class Reader<out T> {
  // Compile-time error: Can't use 'out' type variable 'T' in an 'in' position.
  void write(T x) => print(x);

  // OK
  T read() => null;
}

class Writer<in T> {
  // Compile-time error: Can't use 'in' type variable 'T' in an 'out' position
  // in the return type.
  T read() => null;

  // OK
  void write(T x) => print(x); 
}

class ReaderWriter<inout T> {
  // Both OK
  void write(T value) => print(x);
  T read() => null;
}
```

Errors can be emitted in fields as well.

字段也可能报错。

```dart
class Reader<out T> {
  // Compile-time error: Can't use 'out' type variable 'T' in an 'in' position.
  T readableWritableValue;
  
  // OK
  final T readableValue; 
}

class Writer<in T> {
  // Compile-time error: Can't use 'in' type variable 'T' in an 'out' position.
  T readableWritableValue;
  
  // Compile-time error: Can't use 'in' type variable 'T' in an 'out' position.
  final T readableValue;
}

class ReaderWriter<inout T> {
  // Both OK
  T readableWritableValue;
  final T readableValue; 
}
```

## **Assignment and subtyping**

## **赋值与子类型**

The errors the compiler reports for misusing type parameters help the generic class author **write** correct code. The other half is the set of errors that help others **use** the class correctly. One of the changes that come with sound variance modifiers is the subtyping change that we can see through assignment.

编译器针对类型参数误用报出的错误，帮助泛型类的作者**编写**正确的代码。
另一半则是帮助其他人正确**使用**这个类的错误。
可靠型变修饰符带来的变化之一，就是可以通过赋值观察到的子类型关系变化。

If a generic type parameter is covariant, then you can assign it when its type argument is a subtype of the expected type’s type argument. For example, you can assign a `Reader&lt;int&gt;` to something that expects a `Reader&lt;Object&gt;`.

如果泛型类型参数是协变的，那么当它的类型实参是
期望类型的类型实参的子类型时，就可以赋值。例如，你可以把
`Reader&lt;int&gt;` 赋给期望 `Reader&lt;Object&gt;` 的地方。

```dart
class Reader<out T> { /* ... */ }
main() {
  Reader<Object> objectReader = Reader<int>();
}
```

Likewise, if a generic type parameter is contravariant, assignment is allowed when its type argument is a supertype of the expected type’s type argument. You can assign a `Writer&lt;Object&gt;` to something that expects a `Writer&lt;int&gt;`, as such:

同样，如果泛型类型参数是逆变的，那么当它的类型实参是
期望类型的类型实参的超类型时，允许赋值。你可以把
`Writer&lt;Object&gt;` 赋给期望 `Writer&lt;int&gt;` 的地方，如下所示：

```dart
class Writer<in T> { /* ... */ }
main() {
  Writer<int> intWriter = Writer<Object>();
}
```

For invariant parameters, the type argument must be the same type.

对于不变参数，类型实参必须是同一个类型。

```dart
class ReaderWriter<inout T> { /* ... */ }
main() {
  ReaderWriter<int> intReader = ReaderWriter<int>();
}
```

## **Interface inheritance**

## **接口继承**

So you might be asking, “*Can we opt into stronger compile time checking with variance even when extending older classes?”* The good news is that you can; however, there are a few restrictions.

你可能会问：“*即使继承的是旧类，我们也能借助型变
获得更强的编译时检查吗？*”好消息是：可以；不过有一些限制。

`out` parameters can only extend parameter positions that are covariant or have default Dart type variance.

`out` 参数只能继承协变的或具有 Dart 默认型变的参数位置。

Keep in mind that any methods inherited from legacy classes could still be unsoundly variant, and hence may still cause runtime errors. Otherwise, all new methods in a subclass with type parameters that have variance modifiers will emit errors if the types are in unsound positions.

请记住，从旧类继承的任何方法仍可能是不健全型变的，
因此仍可能导致运行时错误。除此之外，带有型变修饰符类型参数的子类中，
所有新方法只要类型处于不健全的位置，就会报错。

```dart
class LegacyReader<T> {}
class NewReader<out T> extends LegacyReader<T> {} // OK

class Reader<out T> {}
class IntegerReader<out T> extends Reader<T> {} // OK
```

`in` parameters can only extend parameter positions that are contravariant.

`in` 参数只能继承逆变的参数位置。

```dart
class Writer<in T> {}
class StringWriter<in T> extends Writer<T> {} // OK
```

`inout` parameters can extend all parameter positions. However, a parameter that is defined as `inout` can only be inherited by other invariant positions.

`inout` 参数可以继承所有参数位置。不过，定义为 `inout` 的参数
只能被其他不变位置继承。

```dart
class ReaderWriter<inout T> {}
class NewReaderWriter<inout T> extends LegacyReader<T> {} // OK
class IntegerReaderWriter<inout T> extends Reader<T> {} // OK
class StringReaderWriter<inout T> extends Writer<T> {} // OK
```

## How can I give feedback on the variance feature?

## 如何反馈型变特性的意见？

We recommend trying the variance feature using the [latest dev channel](https://dart.dev/get-dart#about-release-channels-and-version-strings). Play around with this example to get a grasp on how variance works and what it can do for you.

我们建议使用[最新的 dev 渠道](https://dart.dev/get-dart#about-release-channels-and-version-strings)
来尝试型变特性。玩玩这个例子，体会型变如何工作、能为你做什么。

```dart
class Writer<in T> {
  void write(T value) => print(value);
}

class Reader<out T> {
  final T value;
  Reader(this.value);
  T read() => value;
}

main() {
  Writer<int> intWriter = Writer<Object>();
  intWriter.write(2);

  Reader<Object> objectReader =
    Reader<String>("Wow, this is soundly variant!");
  print(objectReader.value);
}
```

Because the variance feature is still being implemented, you need to set an experimental flag to enable it:

由于型变特性仍在实现中，你需要设置实验标志来启用它：

```
dart --enable-experiment=variance variance_example.dart
```


We appreciate any and all feedback! You can let us know what you think in [this GitHub issue](https://github.com/dart-lang/language/issues/524).

我们欢迎任何反馈！你可以在
[这个 GitHub issue](https://github.com/dart-lang/language/issues/524)
中告诉我们你的想法。

## **Summary**

## **总结**

Existing Dart generics are covariant by default, which makes it easy to start writing new classes and to get started. This means, however, that more errors appear at runtime rather than at compile time. The user is also paying for the cost of additional runtime checks. The main idea behind variance is to provide users with more informative error checking at compile time.

现有的 Dart 泛型默认是协变的，这让编写新类和上手都很容易。
但这也意味着更多错误出现在运行时而不是编译时，
用户还要为额外的运行时检查付出代价。型变背后的主要思想，
是在编译时为用户提供信息更丰富的错误检查。

Variance is defined only for the parameters of generic classes and mixins. Users can use the variance feature by adding one of the `in`, `out` or `inout` keywords before a type parameter.

型变只为泛型类和 mixin 的参数定义。用户可以在类型参数前
添加 `in`、`out` 或 `inout` 关键字之一来使用型变特性。

Additionally, new generic interfaces with these modifiers can extend legacy interfaces with no variance modifiers.

此外，带有这些修饰符的新泛型接口可以继承没有型变修饰符的旧接口。

Declaration-site variance allows you to reap a bunch of new benefits, including:

声明处型变让你收获一系列新好处，包括：

* Compile-time variant position checking within members of the interface

  在接口成员内进行编译时型变位置检查

* Removal of pesky runtime errors that occur with down and up casting

  消除向下和向上转型带来的恼人运行时错误

* Additional subtyping changes based on the variance declared

  基于声明的型变带来额外的子类型关系变化

* More informative and accessible error checking

  信息更丰富、更易理解的错误检查

Now you won’t have to worry if that `objectWriter` is *truly* a writer of any object. You *know* it is.

现在你不用再担心那个 `objectWriter` 是否*真的*能写入任何对象。
你*知道*它可以。
