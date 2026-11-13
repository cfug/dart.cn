---
# title: "Announcing Dart 2.12"
title: "宣布 Dart 2.12"
# description: "Sound null safety and Dart FFI ship to the stable channel."
description: "健全空安全与 Dart FFI 进入稳定渠道。"
ai-translated: true
publishDate: 2021-03-03
author: mit-mit
image: images/0Inj4APQIAA4gVCxK.webp
category: releases
layout: blog
---


Today we’re announcing Dart 2.12, featuring stable versions of [sound null safety](https://dart.dev/null-safety) and [Dart FFI](https://dart.dev/guides/libraries/c-interop). Null safety is our latest major productivity feature, intended to help you avoid null errors, a class of bugs that are often hard to spot, as detailed in [this video introduction](https://www.youtube.com/watch?v=iYhOU9AuaFs&feature=emb_logo). FFI is an interoperability mechanism that lets you invoke existing code written in the C programming language, such as calling Windows [Win32 APIs](https://pub.dev/packages/win32). Dart 2.12 is available today.

今天我们宣布 Dart 2.12 发布，带来稳定版的
[健全空安全（sound null safety）](https://dart.dev/null-safety)和
[Dart FFI](https://dart.dev/guides/libraries/c-interop)。
空安全（null safety）是我们最新的重大生产力特性，
旨在帮助你避免 null 错误——这类 bug 往往很难被发现，
[这个介绍视频](https://www.youtube.com/watch?v=iYhOU9AuaFs&feature=emb_logo)
中有详细说明。FFI（外部函数接口）是一种互操作机制，
让你能调用 C 语言编写的现有代码，
例如调用 Windows 的 [Win32 API](https://pub.dev/packages/win32)。
Dart 2.12 今天即可使用。

<DashImage src="images/0Inj4APQIAA4gVCxK.webp" alt="Dart 2.12 release banner highlighting sound null safety and Dart FFI." />


## The Dart platform’s unique capabilities

## Dart 平台的独特能力

Before we look at sound null safety and FFI in detail, let’s discuss how they fit into our goals with the Dart platform. Programming languages tend to share a lot of capabilities. For example, many languages support object-oriented programming or running on the web. What really sets languages apart is their unique combination of capabilities.

在详细介绍健全空安全和 FFI 之前，
先聊聊它们如何契合我们对 Dart 平台的目标。
编程语言往往共享很多能力。例如，许多语言都支持面向对象编程
或在 Web 上运行。真正让语言彼此区分开来的，
是它们独特的能力组合。

<DashImage src="images/0msUXfhSNTNzP4wkf.webp" alt="A graphic showing three key pillars of the Dart platform: Portable, Productive, and Robust." />


Dart’s unique capabilities span three dimensions:

Dart 的独特能力涵盖三个维度：

* **Portable**: Efficient compilers generate x86 and ARM machine code for devices, and optimized JavaScript for the web. A [wide range of targets](https://dart.dev/overview#platform) are supported — mobile devices, desktop PCs, app backends, and more. An extensive set of libraries and packages provide consistent APIs that work across all platforms, further lowering the cost of creating true multi-platform apps.

  **可移植（Portable）**：高效的编译器为设备生成 x86 和 ARM 机器码，
  为 Web 生成优化后的 JavaScript。支持[广泛的目标平台](https://dart.dev/overview#platform)
  ——移动设备、桌面 PC、应用后端等等。
  丰富的库和 package 提供在所有平台上一致的 API，
  进一步降低了构建真正多平台应用的成本。

* **Productive**: The Dart platform supports hot reload, enabling fast, iterative development for both native devices and the web. And Dart offers rich constructs like isolates and async/await for handling common concurrent and event-driven app patterns.

  **高效（Productive）**：Dart 平台支持热重载（hot reload），
  让原生设备和 Web 都能快速迭代开发。
  Dart 还提供 isolate 和 async/await 等丰富构造，
  用于处理常见的并发和事件驱动应用模式。

* **Robust**: Dart’s sound, null-safe type system catches errors during development. And the overall platform is highly scalable and dependable, with production usage for more than a decade by a large range of apps, including business-critical apps such as Google Ads and Google Assistant.

  **稳健（Robust）**：Dart 健全的空安全类型系统在开发期间捕获错误。
  整个平台高度可扩展且可靠，十多年来被大量应用用于生产环境，
  包括 Google Ads 和 Google Assistant 这样的关键业务应用。

Sound null safety makes the type system even more robust, and enables better performance. Dart FFI lets you use existing C libraries for better portability, and gives you the option of using highly tuned C code for performance-critical tasks.

健全空安全让类型系统更加稳健，并带来更好的性能。
Dart FFI 让你能使用现有 C 库以获得更好的可移植性，
还可以在性能关键的任务中使用高度调优的 C 代码。

## Sound null safety

## 健全空安全

Sound null safety is the largest addition to the Dart language since the introduction of the sound type system in [Dart 2.0](/blog/announcing-dart-2-optimized-for-client-side-development). Null safety further strengthens the type system, enabling you to catch null errors, which are a common cause of app crashes. By opting into null safety, you can catch null errors during development, preventing crashes in production.

健全空安全是自 [Dart 2.0](/blog/announcing-dart-2-optimized-for-client-side-development)
引入健全类型系统以来，Dart 语言最大的一次增补。
空安全进一步强化了类型系统，让你能捕获 null 错误
——应用崩溃的常见原因。通过选择启用空安全，
你可以在开发期间捕获 null 错误，防止生产环境中的崩溃。

Sound null safety was designed around [a few core principles](https://dart.dev/null-safety#null-safety-principles). Let’s revisit how these principles impact you as a developer.

健全空安全围绕[几条核心原则](https://dart.dev/null-safety#null-safety-principles)设计。
我们来回顾一下这些原则对你作为开发者的影响。

## Non-nullable by default: A fundamental change to the type system

## 默认非空：类型系统的根本性变化

The core challenge prior to null safety was that you couldn’t tell the difference between code that anticipated being passed null and code that didn’t work with nulls. A few months ago we discovered a bug in the Flutter master channel where various flutter tool commands would crash on certain machine configurations with a null error: `The method '&gt;=' was called on null`. The underlying issue was code like this:

空安全之前的核心难题是：你无法区分预期会收到 null 的代码
和不能处理 null 的代码。几个月前，我们在 Flutter master 渠道
发现了一个 bug：某些机器配置下，多个 flutter 工具命令
会因 null 错误而崩溃：`The method '&gt;=' was called on null`。
根本原因是这样的代码：

```
final int major = version?.major;
final int minor = version?.minor;
if (globals.platform.isMacOS) {
  // plugin path of Android Studio changed after version 4.1.
  if (major >= 4 && minor >= 1) {
  ...
```


Can you spot the error? Because `version` can be null, both `major` and `minor` can be null also. This bug might seem easy to spot here in isolation, but in practice code like this slips through all the time, even with a rigorous code review process like the one used in the Flutter repo. With null safety, static analysis catches this issue immediately. ([Try it live in DartPad](https://dartpad.dev/0e9797be7488d8ec6c3fca92b7f2740f?null_safety=true).)

你能找出错误吗？因为 `version` 可能为 null，
`major` 和 `minor` 也都可能为 null。
这个 bug 单独看似乎很容易发现，但在实践中，
这样的代码总是能溜过去——即使有 Flutter 仓库那样
严格的代码审查流程。有了空安全，静态分析会立即捕获这个问题。
（[在 DartPad 中在线试试](https://dartpad.dev/0e9797be7488d8ec6c3fca92b7f2740f?null_safety=true)。）

<DashImage src="images/0jl-o2KmcMjj777Iu.webp" alt="IDE analysis output for Dart null safety issues." caption="Screenshot of analysis output in an IDE" />


That was a pretty simple error. During our early use of null safety in code internally at Google, we’ve seen much more intricate errors be caught. Some of these were bugs that were known for years, but where the teams hadn’t been able to find the cause without the additional static checks from null safety. Here are a few examples:

这是个相当简单的错误。在 Google 内部早期使用空安全的过程中，
我们捕获过复杂得多的错误。其中一些 bug 已存在多年，
但如果没有空安全提供的额外静态检查，
团队一直无法找到原因。下面是几个例子：

* An internal team found that they were often checking for null values of expressions that could never be null. This problem was most frequently seen in code using [protobuf](https://developers.google.com/protocol-buffers), where optional fields return a default value when unset, and never null. As a result, code incorrectly checked for the default condition, by confusing default values and null values.

  一个内部团队发现，他们经常对绝不可能为 null 的表达式
  做 null 检查。这个问题最常出现在使用
  [protobuf](https://developers.google.com/protocol-buffers) 的代码中：
  可选字段未设置时返回默认值，而绝不会是 null。
  结果代码混淆了默认值和 null 值，错误地检查了默认条件。

* The Google Pay team found bugs in their Flutter code where they would fail when trying to access Flutter `State` objects outside of the context of a `Widget`. Before null safety, those objects would return null and mask the error; with null safety, the sound analysis determined that those properties could never be null, and threw an analysis error.

  Google Pay 团队在他们的 Flutter 代码中发现了 bug：
  在 `Widget` 上下文之外访问 Flutter `State` 对象时会失败。
  空安全之前，这些对象会返回 null 并掩盖错误；
  有了空安全，健全的分析判定这些属性绝不可能为 null，
  并抛出分析错误。

* The Flutter team found a bug where the Flutter engine could crash if `null` was passed to the `scene` parameter in `Window.render()`. During null safety migration, they added a hint to [mark Scene as non-nullable](https://github.com/cbracken/engine/blob/bad869e229a8a02cad6e63d12e80807b33b5c12f/lib/ui/window.dart#L1069), and were then able to easily prevent potential app crashes that null would have triggered.

  Flutter 团队发现了一个 bug：如果把 `null` 传给
  `Window.render()` 的 `scene` 参数，Flutter 引擎可能崩溃。
  在空安全迁移期间，他们添加了提示，
  [把 Scene 标记为非空](https://github.com/cbracken/engine/blob/bad869e229a8a02cad6e63d12e80807b33b5c12f/lib/ui/window.dart#L1069)，
  从而轻松避免了 null 可能引发的应用崩溃。

## Working with non-nullable by default

## 使用默认非空的类型

Once you [enable null safety](https://dart.dev/null-safety#enable-null-safety), the basics of variable declarations change because the default types are non-nullable:

一旦你[启用空安全](https://dart.dev/null-safety#enable-null-safety)，
变量声明的基本方式就会改变，因为默认类型是非空的：

```
// In null-safe Dart, none of these can ever be null.
var i = 42; // Inferred to be an int.
String name = getFileName();
final b = Foo();
```


If you want to create a variable that can contain either a value or null, you need to make that explicit in the variable declaration by adding a `?` suffix to the type:

如果你想创建一个既可以存值也可以存 null 的变量，
需要在变量声明中显式说明：给类型加上 `?` 后缀：

```
// aNullableInt can hold either an integer or null.
int? aNullableInt = null;
```


The implementation of null safety is robust, with rich static flow analysis making it easier to work with nullable types. For example, after checking for null, Dart promotes the type of a local variable from nullable to non-nullable:

空安全的实现是稳健的，丰富的静态流分析
让可空类型更容易使用。例如，在检查 null 之后，
Dart 会把局部变量的类型从可空提升为非空：

```
int definitelyInt(int? aNullableInt) {
  if (aNullableInt == null) {
    return 0;
  }
  // aNullableInt has now promoted to a non-null int.
  return aNullableInt; 
}
```


We’ve also added a new keyword, `required`. When a named parameter is marked as `required` (which happens a lot in Flutter widget APIs) and the caller forgets to provide the argument, then an analysis error occurs:

我们还添加了新关键字 `required`。当命名参数被标记为
`required`（这在 Flutter widget API 中很常见），
而调用方忘记提供实参时，就会产生分析错误：

<DashImage src="images/0U_WEQJAarjskU1k2.webp" alt="DartPad analysis error for a missing required parameter." />


## Incremental migration to null safety

## 增量迁移到空安全

Because null safety is such a fundamental change to our typing system, it would be extremely disruptive if we insisted on forced adoption. So that *you* decide when the time is right, null safety is an opt-in feature: you can use Dart 2.12 without being forced to enable null safety. You can even depend on packages that have already enabled null safety, whether or not your app or package has enabled null safety.

因为空安全是类型系统的根本性变化，强制采用会造成极大的干扰。
为了让你自己决定何时合适，空安全是可选启用的特性：
你可以使用 Dart 2.12 而不被迫启用空安全。
你甚至可以依赖已经启用空安全的 package，
无论你的应用或 package 是否启用了空安全。

To help you migrate existing code to null safety, we’re providing a migration tool and a [migration guide](https://dart.dev/null-safety/migration-guide). The tool starts by analyzing all of your existing code. Then you can interactively review the nullability properties that the tool has inferred. If you disagree with any of the tool’s conclusions, you can add nullability hints to change the inference. Adding a few migration hints can have a huge impact on migration quality.

为帮助你把现有代码迁移到空安全，我们提供了迁移工具和
[迁移指南](https://dart.dev/null-safety/migration-guide)。
工具会先分析你所有的现有代码，然后你可以交互式地审查
工具推断出的可空性属性。如果你不同意工具的某个结论，
可以添加可空性提示来改变推断。
添加几个迁移提示就能对迁移质量产生巨大影响。

<DashImage src="images/0srLwqVUDeF49J_B9.webp" alt="Interactive dart migrate tool showing proposed null safety changes." />


For now, new packages and apps created with [`dart create`](https://dart.dev/tools/dart-tool) and [`flutter create`](https://flutter.dev/docs/reference/flutter-cli) don’t enable sound null safety. We expect to change that in a future stable release, when we see that most of the ecosystem has migrated. You can easily [enable null safety](https://dart.dev/null-safety#create) in a newly created package or app using `dart migrate`.

目前，用 [`dart create`](https://dart.dev/tools/dart-tool) 和
[`flutter create`](https://flutter.dev/docs/reference/flutter-cli)
创建的新 package 和应用还不会启用健全空安全。
我们预计在未来某个稳定版本中改变这一点，
届时生态的大部分应该已完成迁移。你可以在新创建的 package 或应用中
用 `dart migrate` 轻松[启用空安全](https://dart.dev/null-safety#create)。

## Status of null safety migration of the Dart ecosystem

## Dart 生态的空安全迁移现状

Over the past year we’ve offered several preview and beta builds of sound null safety, with the goal of seeding the ecosystem with packages that support null safety. This preparation is important, as we recommend [migrating to sound null safety in order](https://dart.dev/null-safety/migration-guide#step1-wait) — you shouldn’t migrate a package or app before all its dependencies have already migrated.

过去一年，我们发布了多个健全空安全的预览版和 beta 版，
目标是让生态中先有一批支持空安全的 package。
这种准备很重要，因为我们建议
[按顺序迁移到健全空安全](https://dart.dev/null-safety/migration-guide#step1-wait)
——不要在其所有依赖完成迁移之前迁移某个 package 或应用。

We’ve published null-safe versions of hundreds of packages offered by the [Dart](https://pub.dev/packages?q=publisher%3Adart.dev&sort=popularity&null-safe=1), [Flutter](https://pub.dev/packages?q=publisher%3Aflutter.dev&sort=popularity&null-safe=1), [Firebase](https://pub.dev/packages?q=publisher%3Afirebase.google.com&sort=popularity&null-safe=1), and [Material](https://pub.dev/packages?q=publisher%3Amaterial.io&sort=popularity&null-safe=1) teams. And we’ve seen great support from the amazing Dart and Flutter ecosystems, so that pub.dev now has more than a thousand packages supporting null safety. Importantly, the most popular packages have migrated first, so that 98% of the top-100 most popular packages, 78% of the top-250, and 57% of the top-500 already support null safety in time for today’s launch. We look forward to seeing yet more packages with null safety on pub.dev in the coming weeks. [Our analysis](https://github.com/dart-lang/sdk/wiki/Null-safety-migration-status) shows that the vast majority of packages on pub.dev are already unblocked and can [start migration](https://dart.dev/null-safety/migration-guide).

我们已发布了 [Dart](https://pub.dev/packages?q=publisher%3Adart.dev&sort=popularity&null-safe=1)、
[Flutter](https://pub.dev/packages?q=publisher%3Aflutter.dev&sort=popularity&null-safe=1)、
[Firebase](https://pub.dev/packages?q=publisher%3Afirebase.google.com&sort=popularity&null-safe=1)
和 [Material](https://pub.dev/packages?q=publisher%3Amaterial.io&sort=popularity&null-safe=1)
团队提供的数百个 package 的空安全版本。
我们也看到了出色的 Dart 和 Flutter 生态的大力支持，
pub.dev 上如今已有超过一千个支持空安全的 package。
重要的是，最流行的 package 率先完成了迁移：
在最流行的前 100 个 package 中，98% 已支持空安全，
前 250 个中为 78%，前 500 个中为 57%，赶上了今天的发布。
我们期待未来几周在 pub.dev 上看到更多支持空安全的 package。
[我们的分析](https://github.com/dart-lang/sdk/wiki/Null-safety-migration-status)
显示，pub.dev 上绝大多数 package 已不再被阻塞，
可以[开始迁移](https://dart.dev/null-safety/migration-guide)。

## The benefits of fully sound null safety

## 完全健全空安全的好处

Once you’ve fully migrated, Dart’s null safety is sound. This means that Dart is 100% sure that expressions that have a non-nullable type cannot be null. When Dart analyzes your code and determines that a variable is non-nullable, that variable is *always* non-nullable. Dart shares sound null safety with Swift, but not very many other programming languages.

一旦完成全部迁移，Dart 的空安全就是健全的（sound）。
这意味着 Dart 百分之百确定：非空类型的表达式不可能为 null。
当 Dart 分析你的代码并判定某个变量非空时，
该变量就*永远*非空。在这一点上，Dart 与 Swift 一样
拥有健全空安全，而其他编程语言中做到的并不多。

The soundness of Dart’s null safety has another welcome implication: it means your programs can be smaller and faster. Because Dart is sure that non-nullable variables are never null, [Dart can optimize](/blog/dart-and-the-performance-benefits-of-sound-types). For example, the Dart ahead-of-time (AOT) compiler can produce smaller and faster native code, because it doesn’t need to add checks for nulls when it knows that a variable isn’t null.

Dart 空安全的健全性还有一个令人欣喜的推论：
你的程序可以更小、更快。因为 Dart 确定非空变量绝不为 null，
[Dart 可以做优化](/blog/dart-and-the-performance-benefits-of-sound-types)。
例如，Dart 的提前编译（AOT）编译器能生成更小更快的原生代码，
因为它在知道变量不为 null 时，无需再添加 null 检查。

## Dart FFI for integrating Dart with C libraries

## 用 Dart FFI 集成 Dart 与 C 库

Dart FFI enables you to leverage existing code in C libraries, both for better portability and for integrating with highly tuned C code for performance critical tasks. As of Dart 2.12, [Dart FFI](https://dart.dev/guides/libraries/c-interop) is out of the *beta* stage and is now considered stable and ready for production use. We’ve also added some new features, including nested structs and passing structs by value.

Dart FFI 让你能利用 C 库中的现有代码，
既获得更好的可移植性，也能集成高度调优的 C 代码
来处理性能关键的任务。从 Dart 2.12 起，
[Dart FFI](https://dart.dev/guides/libraries/c-interop) 走出 *beta* 阶段，
正式稳定，可用于生产环境。我们还添加了一些新特性，
包括嵌套结构体和按值传递结构体。

## Passing structs by value

## 按值传递结构体

Structs can be passed both by reference and by value in C code. FFI previously only supported passing by reference, but as of Dart 2.12, you can pass structs by value. Here’s a small example of two C functions that pass both by reference and by value:

在 C 代码中，结构体（struct）既可以按引用传递，也可以按值传递。
FFI 此前只支持按引用传递，但从 Dart 2.12 起，
你可以按值传递结构体。下面是两个 C 函数的小例子，
分别按引用和按值传递：

```
struct Link {
  double value;
  Link* next;
};

void MoveByReference(Link* link) {
  link->value = link->value + 10.0;
}

Coord MoveByValue(Link link) {
  link.value = link.value + 10.0;
  return link;
}
```


## Nested structs

## 嵌套结构体

C APIs often use nested structs — structs that themselves contain structs, such as this example:

C API 经常使用嵌套结构体——本身包含结构体的结构体，
例如下面这个例子：

```
struct Wheel {
  int spokes;
};

struct Bike {
  struct Wheel front;
  struct Wheel rear;
  int buildYear;
};
```


As of Dart 2.12, nested structs are supported in FFI.

从 Dart 2.12 起，FFI 支持嵌套结构体。

## API changes

## API 变更

As part of declaring FFI stable, and in support of the features above, we’ve made a few smaller API changes.

作为宣布 FFI 稳定的一部分，也为支持上述特性，
我们做了一些较小的 API 变更。

Creating empty structs is now disallowed (breaking change [#44622](https://github.com/dart-lang/sdk/issues/44622)) and produces a deprecation warning. You can use a new type, `Opaque`, to represent empty structs. The `dart:ffi` functions `sizeOf`, `elementAt`, and `ref` now require compile-time type arguments (breaking change [#44621](https://github.com/dart-lang/sdk/issues/44621)). Because new convenience functions in `package:ffi` have been added, no additional boilerplate around allocating and freeing memory is required for common cases:

现在不允许创建空结构体（破坏性变更
[#44622](https://github.com/dart-lang/sdk/issues/44622)），
并会产生弃用警告。你可以用新类型 `Opaque` 表示空结构体。
`dart:ffi` 的函数 `sizeOf`、`elementAt` 和 `ref`
现在要求编译期类型实参（破坏性变更
[#44621](https://github.com/dart-lang/sdk/issues/44621)）。
由于 `package:ffi` 新增了便捷函数，
常见场景下不再需要围绕内存分配和释放编写额外的样板代码：

```
// Allocate a pointer to an Utf8 array, fill it from a Dart string,
// pass it to a C function, convert the result, and free the arg.
//
// Before API change:
final pointer = allocate<Int8>(count: 10);
free(pointer);
final arg = Utf8.toUtf8('Michael');
var result = helloWorldInC(arg);
print(Utf8.fromUtf8(result);
free(arg);

// After API change:
final pointer = calloc<Int8>(10);
calloc.free(pointer);
final arg = 'Michael'.toNativeUtf8();
var result = helloWorldInC(arg);
print(result.toDartString);
calloc.free(arg);
```


## Automatically generating FFI bindings

## 自动生成 FFI 绑定

For large API surfaces it can be very time consuming to write the Dart bindings that integrate with the C code. To reduce this burden, we’ve built a binding generator for automatically creating FFI wrappers from C header files. We invite you to try it out: [`package:ffigen`](https://pub.dev/packages/ffigen).

对于大型 API 面，手写与 C 代码集成的 Dart 绑定非常耗时。
为减轻这一负担，我们构建了一个绑定生成器，
能从 C 头文件自动创建 FFI 包装。欢迎试用：
[`package:ffigen`](https://pub.dev/packages/ffigen)。

## FFI roadmap

## FFI 路线图

With the core FFI platform completed, we’re turning our focus to extending the FFI feature set with features that layer on top of the core platform. Some of the features we’re investigating include:

随着 FFI 核心平台的完成，我们把重心转向在核心平台之上
扩展 FFI 的特性集。我们正在研究的一些特性包括：

* ABI-specific data types like int, long, size_t ([#36140](https://github.com/dart-lang/sdk/issues/36140))

  ABI 相关的数据类型，如 int、long、size_t
  （[#36140](https://github.com/dart-lang/sdk/issues/36140)）

* Inline arrays in structs ([#35763](https://github.com/dart-lang/sdk/issues/35763))

  结构体中的内联数组
  （[#35763](https://github.com/dart-lang/sdk/issues/35763)）

* Packed structs ([#38158](https://github.com/dart-lang/sdk/issues/38158))

  紧凑结构体（packed structs）
  （[#38158](https://github.com/dart-lang/sdk/issues/38158)）

* Union types ([#38491](https://github.com/dart-lang/sdk/issues/38491))

  联合类型（union types）
  （[#38491](https://github.com/dart-lang/sdk/issues/38491)）

* Exposing finalizers to Dart ([#35770](https://github.com/dart-lang/sdk/issues/35770); however note that you can already [use finalizers from C](https://github.com/dart-lang/sdk/issues/35770))

  向 Dart 暴露 finalizer
  （[#35770](https://github.com/dart-lang/sdk/issues/35770)；
  不过请注意，你已经可以[从 C 使用 finalizer](https://github.com/dart-lang/sdk/issues/35770)）

## Sample uses of FFI

## FFI 使用示例

We’ve seen many creative uses of Dart FFI to integrate with a range of C-based APIs. Here are a few examples:

我们看到了许多用 Dart FFI 集成各类 C API 的创意用法。
下面是几个例子：

* [open_file](https://pub.dev/packages/open_file) is a single API for opening files across multiple platforms. It uses FFI to invoke native operating system APIs on Windows, macOS, and Linux.

  [open_file](https://pub.dev/packages/open_file) 提供跨多个平台
  打开文件的统一 API。它用 FFI 调用 Windows、macOS 和 Linux 上
  原生操作系统的 API。

* [win32](https://pub.dev/packages/win32) wraps most common Win32 APIs, making it possible to call a wide range of Windows APIs directly from Dart.

  [win32](https://pub.dev/packages/win32) 封装了大多数常用 Win32 API，
  让你能直接从 Dart 调用各种 Windows API。

* [objectbox](https://pub.dev/packages/objectbox) is a fast database backed by a C-based implementation.

  [objectbox](https://pub.dev/packages/objectbox) 是一个快速数据库，
  底层由 C 实现支撑。

* [tflite_flutter](https://pub.dev/packages/tflite_flutter) uses FFI to wrap the TensorFlow Lite API.

  [tflite_flutter](https://pub.dev/packages/tflite_flutter) 用 FFI
  封装了 TensorFlow Lite API。

## What’s next for the Dart language?

## Dart 语言的下一步是什么？

Sound null safety is the largest change we’ve made to the Dart language in several years. Next we’re going to look at making more incremental changes to the language and platform, building on our strong foundation. Here’s a quick view into some of the things we’re experimenting with in our [language design funnel](https://github.com/dart-lang/language/projects/1):

健全空安全是我们几年来对 Dart 语言最大的一次改动。
接下来，我们会在坚实的基础之上，对语言和平台做更多增量式的改动。
下面快速预览一下我们在
[语言设计漏斗](https://github.com/dart-lang/language/projects/1)
中试验的一些内容：

**Type aliases** ([#65](https://github.com/dart-lang/language/issues/65)): The ability to create type aliases to non-function types. For example you could create a typedef and use it as a variable type:

**类型别名（type aliases）**
（[#65](https://github.com/dart-lang/language/issues/65)）：
为非函数类型创建类型别名的能力。例如，你可以创建一个 typedef
并把它用作变量类型：

```
typedef IntList = List<int>;
IntList il = [1,2,3];
```


**Triple-shift operator** ([#120](https://github.com/dart-lang/language/issues/120)): Adding a new, fully overridable `&gt;&gt;&gt;` operator for doing unsigned bit-shift on integers.

**三重移位运算符**
（[#120](https://github.com/dart-lang/language/issues/120)）：
新增一个可完全重写的 `&gt;&gt;&gt;` 运算符，
用于对整数做无符号位移。

**Generic metadata annotations** ([#1297](https://github.com/dart-lang/language/issues/1297)): Extending metadata annotations to also support annotations that contain type arguments.

**泛型元数据注解**
（[#1297](https://github.com/dart-lang/language/issues/1297)）：
扩展元数据注解，使其也支持带类型实参的注解。

**Static meta-programming** ([#1482](https://github.com/dart-lang/language/issues/1482)): Support for static meta-programming — Dart programs that produce new Dart source code during compilation, similar to Rust [macros](https://doc.rust-lang.org/book/ch19-06-macros.html) and Swift [function builders](https://github.com/apple/swift-evolution/blob/9992cf3c11c2d5e0ea20bee98657d93902d5b174/proposals/XXXX-function-builders.md). This feature is still in an early exploration phase, but we think it may enable use cases that today rely on code generation.

**静态元编程**
（[#1482](https://github.com/dart-lang/language/issues/1482)）：
支持静态元编程——Dart 程序在编译期间生成新的 Dart 源代码，
类似 Rust 的[宏](https://doc.rust-lang.org/book/ch19-06-macros.html)
和 Swift 的[函数构建器](https://github.com/apple/swift-evolution/blob/9992cf3c11c2d5e0ea20bee98657d93902d5b174/proposals/XXXX-function-builders.md)。
该特性仍处于早期探索阶段，但我们认为它可能支持
如今依赖代码生成的一些用例。

## Dart 2.12 is available now

## Dart 2.12 现已可用

Dart 2.12, with sound null safety and stable FFI, is available today in the [Dart 2.12](https://dart.dev/get-dart) and [Flutter 2.0](https://flutter.dev/docs/get-started/) SDKs. Please take a moment to review the known null safety issues [for Dart](https://dart.dev/null-safety#known-issues) and [for Flutter](https://flutter.dev/docs/null-safety#known-issues). If you find any other issues, please report them in the [Dart issue tracker](https://github.com/dart-lang/sdk/issues).

带健全空安全和稳定 FFI 的 Dart 2.12，今天已可在
[Dart 2.12](https://dart.dev/get-dart) 和
[Flutter 2.0](https://flutter.dev/docs/get-started/) SDK 中获取。
请花点时间查看已知的空安全问题：
[Dart 的](https://dart.dev/null-safety#known-issues)和
[Flutter 的](https://flutter.dev/docs/null-safety#known-issues)。
如果你发现其他问题，请在
[Dart issue 跟踪器](https://github.com/dart-lang/sdk/issues)中报告。

If you’ve developed packages published on [pub.dev](https://pub.dev), please review the [migration guide](https://dart.dev/null-safety/migration-guide) today, and learn how to migrate to sound null safety. Migrating your package is likely to help unblock other packages and apps that depend on it. We’d also like to extend a big thanks to those that migrated already!

如果你开发了发布在 [pub.dev](https://pub.dev) 上的 package，
请今天就查看[迁移指南](https://dart.dev/null-safety/migration-guide)，
了解如何迁移到健全空安全。迁移你的 package
很可能帮助依赖它的其他 package 和应用解除阻塞。
我们也要向已经完成迁移的开发者致以衷心的感谢！

We’d love to hear about your experience with both sound null safety and FFI. Leave a comment below or tweet us [@dart_lang](https://twitter.com/dart_lang).

我们很想听听你使用健全空安全和 FFI 的体验。
欢迎在下方留言，或在推特上联系我们
[@dart_lang](https://twitter.com/dart_lang)。
