---
# title: "Announcing sound null safety"
title: "宣布健全空安全"
# description: "Make your apps more stable and performant with Dart’s null safety"
description: "用 Dart 的空安全让你的应用更稳定、性能更好"
ai-translated: true
publishDate: 2020-06-10
author: filiph
image: images/1HKl1Jf0uBNP-gReYYcgC_g.webp
category: announcements
layout: blog
---


*By: [Filip Hracek](https://medium.com/@filiph) & [Michael Thomsen](https://medium.com/@mit.mit)*

*作者：[Filip Hracek](https://medium.com/@filiph) 与 [Michael Thomsen](https://medium.com/@mit.mit)*

Today is a major milestone for the Dart team with the tech preview of our null safety work. Null safety helps you avoid a class of bugs that are often hard to spot, and as an added bonus enables a range of performance improvements. We’re now releasing an early tech preview, and we’re looking forward to your feedback.

今天，随着空安全（null safety）工作技术预览版的发布，
Dart 团队迎来了一个重要里程碑。空安全帮助你避免一类往往难以发现的
bug，还额外带来一系列性能改进。我们现在发布早期技术预览版，
期待你的反馈。

This post describes the Dart team’s plans for rolling out null safety. It also explains what we mean by *sound* null safety and **why that’s different from approaches that many other languages take.

本文介绍 Dart 团队推出空安全的计划，
也解释我们所说的*健全*（sound）空安全是什么意思，
以及**它与许多其他语言的做法有何不同。

## Why null safety?

## 为什么需要空安全？

Dart is a type-safe language. This means that when you get a variable of some type, the compiler can *guarantee* that it is of that type. But type safety by itself doesn’t guarantee that the variable is not `null`.

Dart 是一门类型安全的语言。这意味着当你拿到某个类型的变量时，
编译器可以*保证*它就是那个类型。但类型安全本身并不保证变量不是 `null`。

Null errors are very common. A search on GitHub leads to [thousands of issues](https://github.com/search?l=Dart&q=%22called+on+null%22&type=Issues) caused by nulls in Dart code, and even more [thousands of commits](https://github.com/search?l=Dart&q=%22called+on+null%22&type=Commits) trying to fix those issues.

null 错误非常常见。在 GitHub 上搜索，可以找到 Dart 代码中由 null
引起的[数千个 issue](https://github.com/search?l=Dart&q=%22called+on+null%22&type=Issues)，
以及更多试图修复这些问题的
[数千次提交](https://github.com/search?l=Dart&q=%22called+on+null%22&type=Commits)。

Try to see if you can spot the nullability problems in the following example code:

试试看你能否找出下面示例代码中的可空性问题：

```
void printLengths(List<File> files) {
  for (var file in files) {
    print(file.lengthSync());
  }
}
```


This function will certainly fail if called with `null`, but there’s a second case to consider:

如果用 `null` 调用这个函数，它肯定会失败，
但还有第二种情况需要考虑：

```
void main() {
  // Error case 1: passing a null to files.
  printLengths(null);

  // Error case 2: passing list of files, containing a null item.
  printLengths([File('filename1'), File('filename2'), null]);
}
```


The null safety feature makes this problem go away:

空安全特性让这个问题不复存在：

<DashImage src="images/1HKl1Jf0uBNP-gReYYcgC_g.webp" alt="DartPad with null safety showing errors for passing null to a list of files and including a null item in the list." />


With null safety, you can reason about your code with more confidence. No more pesky runtime null dereferencing errors. Instead, you get static errors as you code.

有了空安全，你可以更有信心地推敲自己的代码。
不再有烦人的运行时 null 解引用错误，取而代之的是编码时的静态错误。

## Sound null safety

## 健全空安全

Dart’s null safety is *sound*. This means that Dart is 100% sure that the `files` list, and the elements in it, cannot be `null` in the above example. When Dart analyzes your code and determines that a variable is non-nullable, that variable is *always* non-nullable: if you inspect your running code in the debugger, you’ll see that non-nullability is retained at runtime. By contrast, some other implementations are unsound, and in many cases still need to perform runtime null checks. Dart shares sound null safety with Swift, but not very many other programming languages.

Dart 的空安全是*健全*的。这意味着在上面的例子中，
Dart 百分之百确定 `files` 列表及其中的元素都不可能是 `null`。
当 Dart 分析你的代码并确定某个变量是非空（non-nullable）时，
该变量就*永远*是非空的：如果你在调试器中检查运行中的代码，
会看到非空性在运行时依然保持。相比之下，其他一些实现是不健全的，
在许多情况下仍需执行运行时 null 检查。
与 Dart 一样拥有健全空安全的还有 Swift，但其他编程语言就不多了。

The soundness of Dart’s null safety has another welcome implication: it means your programs can be smaller and faster. Because Dart is *really* sure that `files` is never `null`, Dart can optimize. For example, the Dart ahead-of-time (AOT) compiler can produce smaller and faster native code, because it doesn’t need to add checks for nulls when it *knows* that a variable isn’t `null`.

Dart 空安全的健全性还有一个令人欣喜的意义：
你的程序可以更小、更快。因为 Dart *真正*确定 `files` 绝不为 `null`，
Dart 就可以进行优化。例如，Dart 的预编译（AOT）编译器
可以生成更小、更快的原生代码，因为当它*知道*某个变量不是 `null` 时，
就不需要添加 null 检查。

We’ve seen some very promising preliminary results. For example, we saw a [19% performance improvement](https://gist.github.com/a-siva/07e8a5bfa8548a3041d44d5d1c6f3a40) in a microbenchmark that emulates typical Flutter framework rendering patterns.

我们已经看到一些非常有前景的初步结果。例如，
在一个模拟典型 Flutter 框架渲染模式的微基准测试中，
我们看到了 [19% 的性能提升](https://gist.github.com/a-siva/07e8a5bfa8548a3041d44d5d1c6f3a40)。

## Design principles

## 设计原则

Before starting the detailed design for null safety, the Dart team defined the following three core principles:

在开始空安全的详细设计之前，Dart 团队定义了以下三条核心原则：

* **Non-nullable by default.** Unless you explicitly tell Dart that a variable can be `null`, it will consider it non-nullable. We chose this as the default because we found that non-null was by far the most common choice in APIs.

  **默认非空。**除非你明确告诉 Dart 某个变量可以是 `null`，
  否则 Dart 会认为它是非空的。我们选择它作为默认值，
  因为我们发现非空是 API 中最常见的选择，没有之一。

* **Incrementally adoptable.** There’s a lot of Dart code out there. It must be possible to migrate to null safety incrementally, part by part. It should be possible to have null-safe and non-null-safe code in the same project. We’ll also provide tools to help you with the migration.

  **可增量采用。**现存大量 Dart 代码。必须能够一部分一部分地
  增量迁移到空安全。同一个项目中应该可以同时存在空安全和非空安全的
  代码。我们还会提供工具来帮助你迁移。

* **Fully sound.** As mentioned above, Dart’s null safety is sound. Once you migrate your whole project and your dependencies to null safety, you reap the full benefits of soundness.

  **完全健全。**如上所述，Dart 的空安全是健全的。
  一旦你的整个项目及其依赖都迁移到空安全，
  你就能收获健全性的全部好处。

## Declaring variables with null safety

## 用空安全声明变量

The core syntax is simple enough. Here are some non-nullable variables, declared in different ways. Remember, non-nullable is the default, so these declarations look like they do today, but their meaning changes.

核心语法足够简单。下面是一些以不同方式声明的非空变量。
记住，非空是默认值，所以这些声明看起来和今天一样，但含义变了。

```
// In null-safe Dart, none of these can ever be null.
var i = 42;
final b = Foo();
String m = '';
```


Dart will make sure that you never assign `null` to any of the above variables. If you try to do `i = null` a thousand lines later, you’ll get a static analysis error and red squiggly lines, and your program will refuse to compile.

Dart 会确保你永远不会把 `null` 赋给上述任何变量。
如果你在一千行之后尝试 `i = null`，你会得到静态分析错误
和红色波浪线，你的程序将拒绝编译。

If you want your variable to be nullable, you can use `?`, like this:

如果你想让变量可空（nullable），可以使用 `?`，像这样：

```
// These are all nullable variables.
int? j = 1;  // Can be null later.
final Foo? c = getFoo();  // Maybe the function returns null.
String? n;  // Is null at first. Can be null at any later time, too.
```


The above variables behave the same way that all variables do today.

上面这些变量的行为与今天所有变量的行为相同。

You can use the `?` syntax in other places, too:

你也可以在其他地方使用 `?` 语法：

```
// In function parameters.
void boogie(int? count) {
  // It's possible that count is null.
}

// In function return values.
Foo? getFoo() {
  // Can return null instead of Foo.
}

// Also: generics, typedefs, type checks, etc.
// And any combination of the above.
```


But, once again, the dream is that you’ll almost never have to use `?`. The vast majority of your types will be non-nullable.

不过，再说一次，我们的理想是你几乎永远不需要使用 `?`。
你的绝大多数类型都将是非空的。

## Making null safety easier to use

## 让空安全更易用

The Dart team is trying hard to make null safety as easy to use as possible. For example, look at this code, which uses `if` to check for a null value:

Dart 团队正努力让空安全尽可能易用。
例如，看看这段用 `if` 检查 null 值的代码：

```
void honk(int? loudness) {
  if (loudness == null) {
    // No loudness specified, notify the developer
    // with maximum loudness.
    _playSound('error.wav', volume: 11);
    return;
  }

  // Loudness is non-null, let's just clamp it to acceptable levels.
  _playSound('honk.wav', volume: loudness.clamp(0, 11));
}
```


Note how Dart is smart enough to realize that by the time we pass that `if` statement, the `loudness` variable *cannot* be `null`. And so Dart lets us call the `clamp()` method without jumping through hoops. This convenience is enabled by something called *flow analysis*: the Dart analyzer goes through your code as if it was executing it, figuring out additional information about your code automatically.

注意 Dart 有多聪明：它意识到当我们通过那条 `if` 语句后，
`loudness` 变量*不可能*是 `null`。于是 Dart 让我们无需大费周章
就能调用 `clamp()` 方法。这一便利来自所谓的*流分析*（flow analysis）：
Dart 分析器像执行代码一样遍历你的代码，
自动推断出关于代码的额外信息。

Here’s another example, which shows a case where Dart can be sure that a variable is non-null because we always assign a non-null value to it:

再来看一个例子：由于我们总是给变量赋非空值，
Dart 可以确定该变量非空：

```
int sign(int x) {
  // The result is non-nullable.
  int result;

  if (x >= 0) {
    result = 1;
  } else {
    result = -1;
  }

  // By this point, Dart knows the result cannot be null.
  return result;
}
```


If you remove any of the assignments above (for example, by deleting the `result = -1;` line), Dart cannot guarantee that `result` will be non-null: you’ll get a static error and your code won’t compile.

如果你删掉上面任何一处赋值（例如删除 `result = -1;` 这一行），
Dart 就无法保证 `result` 非空：你会得到静态错误，代码无法编译。

Flow analysis only works inside functions. If you have a global variable or a class field, then Dart can’t guarantee when it will be assigned what value. Dart can’t model the flow of your whole application. For that reason, you can use the new `late` keyword when you ***know*** that a variable will be non-null before you first read it, but you can’t initialize it immediately.

流分析只在函数内部起作用。对于全局变量或类字段，
Dart 无法保证它何时会被赋什么值。Dart 无法对整个应用的执行流建模。
因此，当你***知道***某个变量在首次读取前一定非空、
但又无法立即初始化它时，可以使用新的 `late` 关键字。

```
class Goo {
  late Viscosity v;

  Goo(Material m) {
    v = m.computeViscosity();
  }
}
```


Note that `v` is non-null, although it starts uninitialized. Dart trusts you that you won’t try to read `v` before it’s assigned a non-null value, and your code compiles without errors.

注意 `v` 是非空的，尽管它一开始未初始化。
Dart 相信你不会在 `v` 被赋非空值之前尝试读取它，
你的代码可以无错误地编译。

## Null safety is backwards compatible

## 空安全向后兼容

The Dart team has been working for more than a year to get null safety to tech preview. It’s the largest addition to the Dart language since we introduced Dart 2. Yet, it’s not a breaking change. Existing code can call into code that uses null safety, and vice versa. Even after null safety is available, it will be an optional feature that you can adopt when you’re ready. **Your existing code will continue to run without change**.

Dart 团队为把空安全推进到技术预览版已工作了一年多。
这是自 Dart 2 以来 Dart 语言最大的一次扩充。然而，它不是破坏性变更。
现有代码可以调用使用空安全的代码，反之亦然。
即使空安全可用之后，它仍是一个可选特性，你可以在准备好时再采用。
**你的现有代码将无需改动、继续运行**。

We recently migrated the Dart [core libraries to fully use null safety](https://api.dart.dev/dev/2.9.0-13.0.dev/index.html). As an example of null safety’s backwards compatibility, we replaced the existing core libraries without any breakage in existing tests and test apps running in the Dart and Flutter test environments. We even rolled the new core libraries to our many internal Google customers, directly into their production code bases, without a hitch. We plan on migrating all of our packages and apps to use null safety when the feature launches, and we hope you’ll do the same. But you’ll be able to do it on your timeline, package by package, app by app.

我们最近把 Dart
[核心库迁移到了完全使用空安全](https://api.dart.dev/dev/2.9.0-13.0.dev/index.html)。
作为空安全向后兼容的一个例子，我们替换了现有核心库，
而运行在 Dart 和 Flutter 测试环境中的现有测试和测试应用
没有出现任何破坏。我们甚至把新核心库推送给了 Google 内部众多用户，
直接进入他们的生产代码库，一路顺畅。
我们计划在该特性发布时把所有 package 和应用都迁移到空安全，
也希望你这么做。但你可以按自己的时间表，逐个 package、
逐个应用地完成。

## The null safety roadmap

## 空安全路线图

We plan to roll out null safety gradually, in three steps:

我们计划分三步逐步推出空安全：

1. **Tech preview.** This is ***launching today***, and is available in Dart’s [dev channel](https://dart.dev/get-dart#release-channels). See the “Try it now” section below for details. Things are still subject to change, so **don’t use null safety in production code** just yet. Do test things out and [give us feedback](https://github.com/dart-lang/sdk/issues/new?title=Null%20safety%20feedback:%20[issue%20summary]&labels=NNBD&body=Describe%20the%20issue%20or%20potential%20improvement%20in%20detail%20here), though!

    **技术预览。**它***今天发布***，可在 Dart 的
    [dev 渠道](https://dart.dev/get-dart#release-channels)获取。
    详情见下文“立即尝试”一节。一切都还可能变化，
    所以**暂时不要在生产代码中使用空安全**。
    不过请务必测试并[给我们反馈](https://github.com/dart-lang/sdk/issues/new?title=Null%20safety%20feedback:%20[issue%20summary]&labels=NNBD&body=Describe%20the%20issue%20or%20potential%20improvement%20in%20detail%20here)！

1. **Beta release.** Null safety will be available in Dart’s beta channel, and no longer behind an [experimental flag](https://github.com/dart-lang/sdk/blob/master/docs/process/experimental-flags.md). The feature will be very close to the expected final version. If you own a [pub.dev](https://pub.dev/) package or plugin, this is when you can begin migrating, but you shouldn’t publish it as a stable version just yet.

    **Beta 发布。**空安全将进入 Dart 的 beta 渠道，
    不再需要[实验标志](https://github.com/dart-lang/sdk/blob/master/docs/process/experimental-flags.md)。
    该特性将非常接近预期的最终版本。
    如果你拥有 [pub.dev](https://pub.dev/) 上的 package 或插件，
    这时就可以开始迁移，但还不应该把它发布为稳定版本。

1. **Stable release.** Everyone will have null safety, and you’ll be encouraged to publish your migrated packages and plugins as stable versions. You should also migrate your production apps.

    **稳定发布。**所有人都将拥有空安全，
    我们鼓励你把迁移后的 package 和插件发布为稳定版本。
    你也应该迁移你的生产应用。

If all goes well, we plan to release null safety as a stable feature before the end of the year. Between now and then, we’ll add tooling to help you make your code null safe, including:

如果一切顺利，我们计划在年底前把空安全作为稳定特性发布。
在此期间，我们会添加工具来帮助你把代码变为空安全，包括：

* A migration tool to support you in automating many of the steps for upgrading existing packages and apps

  一个迁移工具，帮你自动完成升级现有 package 和应用的许多步骤

* Tags on [pub.dev](https://pub.dev), so you can tell if a package supports null safety or not

  [pub.dev](https://pub.dev) 上的标签，让你分辨 package 是否支持空安全

* An extension to the [`pub outdated`](https://dart.dev/tools/pub/cmd/pub-outdated) command, with support for finding the latest versions of your dependencies that support null safety

  对 [`pub outdated`](https://dart.dev/tools/pub/cmd/pub-outdated) 命令的扩展，
  支持查找你的依赖中支持空安全的最新版本

## Try it now

## 立即尝试

The quickest way to try null safety today is through [nullsafety.dartpad.dev](https://nullsafety.dartpad.dev/3d9c1769de7912c654bc5d132aff60ac), a version of DartPad with null safety enabled. Open the **Learn with Snippets** drop-down to find a series of learning exercises that walk through the new syntax and basics of null safety.

今天尝试空安全最快的方式是通过
[nullsafety.dartpad.dev](https://nullsafety.dartpad.dev/3d9c1769de7912c654bc5d132aff60ac)——
启用了空安全的 DartPad 版本。打开 **Learn with Snippets** 下拉菜单，
可以看到一系列学习练习，带你了解空安全的新语法和基础知识。

<DashImage src="images/07alHbKGJ1FoeNqII.webp" alt="DartPad with the null safety experiment enabled and interactive code snippets." />


You can also try null safety in small command-line apps. (We haven’t migrated larger frameworks like Flutter yet.) Start by downloading a copy of the [dev-channel Dart SDK](https://github.com/dart-lang/samples/blob/master/null_safety/calculate_lix/README.md#dart-preview-sdk-installation), and then get a copy of [this sample Dart CLI app](https://github.com/dart-lang/samples/tree/master/null_safety/calculate_lix) ([GitHub repo](https://github.com/dart-lang/samples), [zip archive](https://github.com/dart-lang/samples/archive/master.zip)). The sample app’s [README file](https://github.com/dart-lang/samples/blob/master/null_safety/calculate_lix/README.md) has instructions for running the app with the null safety experiment flag. Other files in the sample provide launch configurations that enable debugging in VS Code and Android Studio.

你也可以在小型命令行应用中尝试空安全。
（我们还没有迁移 Flutter 这样的大型框架。）
首先下载一份
[dev 渠道的 Dart SDK](https://github.com/dart-lang/samples/blob/master/null_safety/calculate_lix/README.md#dart-preview-sdk-installation)，
然后获取[这个示例 Dart CLI 应用](https://github.com/dart-lang/samples/tree/master/null_safety/calculate_lix)
（[GitHub 仓库](https://github.com/dart-lang/samples)、
[zip 压缩包](https://github.com/dart-lang/samples/archive/master.zip)）。
示例应用的 [README 文件](https://github.com/dart-lang/samples/blob/master/null_safety/calculate_lix/README.md)
说明了如何带空安全实验标志运行该应用。
示例中的其他文件提供了可在 VS Code 和 Android Studio
中调试的启动配置。

We also have documentation, with plans to produce more:

我们也有文档，并计划编写更多：

* [Null safety guide](https://dart.dev/null-safety)

  [空安全指南](https://dart.dev/null-safety)

* [API reference for core libraries with null safety](https://api.dart.dev/dev/2.9.0-13.0.dev/index.html)

  [支持空安全的核心库 API 参考](https://api.dart.dev/dev/2.9.0-13.0.dev/index.html)

We’re very happy to bring null safety to Dart. Sound null safety is a distinctive feature of Dart that helps you write less error-prone code and get better performance. We hope you’ll experiment with the feature in tech preview, and [give us feedback](https://github.com/dart-lang/sdk/issues/new?title=Null%20safety%20feedback:%20[issue%20summary]&labels=NNBD&body=Describe%20the%20issue%20or%20potential%20improvement%20in%20detail%20here) through our issue tracker. Happy coding!

我们非常高兴把空安全带给 Dart。健全空安全是 Dart 的一项独特特性，
帮助你写出更不易出错的代码并获得更好的性能。
希望你在技术预览版中试用这一特性，并通过 issue 跟踪器
[给我们反馈](https://github.com/dart-lang/sdk/issues/new?title=Null%20safety%20feedback:%20[issue%20summary]&labels=NNBD&body=Describe%20the%20issue%20or%20potential%20improvement%20in%20detail%20here)。
祝编码愉快！
