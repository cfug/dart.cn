---
# title: "Announcing Dart 2.5: Super-charged development"
title: "宣布 Dart 2.5：为开发注入强劲动力"
# description: "Today we’re announcing the stable release of the Dart 2.5 SDK, which includes technical previews of two major new developer features: ML…"
description: "今天我们宣布 Dart 2.5 SDK 稳定版发布，包含两项重大新开发者特性的技术预览：ML Complete（机器学习驱动的代码补全）和 dart:ffi（直接从 Dart 调用 C 代码的外部函数接口）"
ai-translated: true
publishDate: 2019-09-10
author: mit-mit
image: images/0EzNuk5GmPG3-yjT4.webp
category: releases
layout: blog
---


Today we’re announcing the stable release of the Dart 2.5 SDK, which includes technical previews of two major new developer features: *ML Complete —* code completion powered by machine learning (ML) — and the `dart:ffi` foreign function interface for calling C code directly from Dart. Dart 2.5 also has improved support for [constant expressions](https://dart.dev/guides/language/language-tour#final-and-const).

今天我们宣布 Dart 2.5 SDK 稳定版正式发布，其中包含两项重大新开发者
特性的技术预览：*ML Complete*——由机器学习（ML）驱动的代码补全，
以及用于直接从 Dart 调用 C 代码的 `dart:ffi` 外部函数接口。
Dart 2.5 还改进了对
[常量表达式](https://dart.dev/guides/language/language-tour#final-and-const)的支持。

This release is another step toward our vision of the best client-optimized language for creating fast apps for any platform. ML Complete is a powerful addition to our existing suite of productivity tools like [hot reload](https://flutter.dev/docs/development/tools/hot-reload), [customizable static analysis](https://dart.dev/guides/language/analysis-options), and [Dart DevTools](https://flutter.dev/docs/development/tools/devtools/overview). The second preview feature, `dart:ffi`, enables you to leverage existing native APIs on the many operating systems where Dart code runs, as well as existing cross-platform native libraries written in C.

这个版本是我们迈向愿景的又一步：打造最好的、面向客户端优化的语言，
为任何平台创建快速应用。ML Complete 是对我们现有生产力工具套件
（如[热重载](https://flutter.dev/docs/development/tools/hot-reload)、
[可定制的静态分析](https://dart.dev/guides/language/analysis-options)
和 [Dart DevTools](https://flutter.dev/docs/development/tools/devtools/overview)）
的有力补充。第二个预览特性 `dart:ffi` 让你能够利用 Dart 代码所运行的
众多操作系统上的现有原生 API，以及用 C 编写的现有跨平台原生库。

Speaking of our ambition to create the best client-optimized language, it was great to see the new [IEEE Spectrum Top Programming Language](https://spectrum.ieee.org/computing/software/the-top-programming-languages-2019) 2019 ratings come out this past week with Dart now included. Dart enters the IEEE Spectrum programming language ratings as #16. It’s also #10 under trending, and #6 when filtering to languages for mobile (behind Java, C, C++, C#, and Swift).

说到我们打造最好的客户端优化语言的雄心，很高兴看到上周发布的
[IEEE Spectrum 2019 顶级编程语言](https://spectrum.ieee.org/computing/software/the-top-programming-languages-2019)
排行榜首次纳入了 Dart。Dart 在 IEEE Spectrum 编程语言排行榜中位列第 16，
在趋势榜上排名第 10，在筛选移动开发语言时排名第 6
（仅次于 Java、C、C++、C# 和 Swift）。

<DashImage src="images/0EzNuk5GmPG3-yjT4.webp" alt="Dart ranks #16 in IEEE Spectrum's top programming languages for 2019." />


## Preview: ML Complete, code completions ranked by machine learning

## 预览：ML Complete，由机器学习排序的代码补全

One of the core advantages of typed programming languages is that additional information captured in the types enables the IDE/editor to aid developers by offering completions as they type their code. With code completions, developers can both avoid misspellings and explore APIs by typing the beginning of expected symbols and choosing from the offered completions.

类型化编程语言的核心优势之一，是类型中捕获的额外信息
让 IDE/编辑器能够在开发者输入代码时提供补全建议，从而助其一臂之力。
有了代码补全，开发者既能避免拼写错误，
又能通过输入预期符号的开头并从补全建议中选择来探索 API。

As APIs grow, exploration becomes difficult, as the list of possible completions gets too long to browse through alphabetically. We’ve been working hard over the past year to apply machine learning to the problem. Simplified, this works by training a model of likely member occurrences based on a given context by analyzing a [large corpus of GitHub](https://console.cloud.google.com/marketplace/details/github/github-repos) open-source Dart code. This model — powered by [TensorFlow Lite](https://www.tensorflow.org/lite) — can then be used to predict the likely next symbol as the developer is editing. We’re calling this new feature *ML Complete*. Here’s an example of developing a new `MyHome` widget using the [Flutter](https://flutter.dev) framework:

随着 API 不断增长，探索变得困难，
因为可能的补全列表太长，无法按字母顺序逐一浏览。
过去一年我们一直在努力把机器学习应用到这个问题上。简单来说，
就是通过分析 [GitHub 上的大量](https://console.cloud.google.com/marketplace/details/github/github-repos)
开源 Dart 代码，基于给定上下文训练一个预测成员出现可能性的模型。
这个由 [TensorFlow Lite](https://www.tensorflow.org/lite) 驱动的模型，
可以在开发者编辑时预测下一个可能用到的符号。
我们把这个新特性称为 *ML Complete*。下面是使用
[Flutter](https://flutter.dev) 框架开发一个新 `MyHome` widget 的例子：

<DashImage src="images/0a3q1D4T6uoftk8SJ.webp" alt="A developer creates a Flutter widget using ML Complete." caption="Sample developer experience creating a Flutter widget using ML Complete" />


Let’s take a deeper look at how this works. Imagine that you’re writing a small program to calculate the time that’s one day from the current time. Using ML Complete you get the experience on the left, below. First, notice how it’s able to offer a completion to `DateTime.now()` based on the variable having the name now. Next, notice how we get a completion on the variable name tomorrow, and finally `add(…)` is the second offered completion on now. In the non-ML Complete experience on the right, we have to manually start typing `DateTime`, we get no completions on the `tomorrow` variable name, and the `add(…)` method is much further down the list.

让我们更深入地看看它是如何工作的。想象你正在写一个小程序，
计算当前时间一天之后的时间。使用 ML Complete，
你会得到下面左侧的体验。首先，注意它如何根据变量名 now
提供 `DateTime.now()` 的补全。接着，注意我们在变量名 tomorrow 上
得到了补全，最后 `add(…)` 是 now 上提供的第二个补全。
而在右侧没有 ML Complete 的体验中，我们必须手动开始输入 `DateTime`，
在 `tomorrow` 变量名上得不到任何补全，
`add(…)` 方法也排在列表更靠后的位置。

<DashImage src="images/1rA4mVfedEzJCN_ayVymm1A.webp" alt="A developer calculates the time one day from the current time using ML Complete." />


<DashImage src="images/1cmHliNwHDwjNV-fdMScWMA.webp" alt="Code completion experience with ML Complete on the left and without on the right." caption="Code completion experience with ML Complete (left) and without (right)" />


## How to try out ML Complete

## 如何试用 ML Complete

ML Complete is launching in preview today. It’s built directly into the Dart analyzer, so it’s available across all Dart-enabled editors, including Android Studio, IntelliJ, and VS Code. See [this wiki page](https://github.com/dart-lang/sdk/wiki/Previewing-Dart-code-completions-powered-by-machine-learning) for details on how to opt in to this preview feature, and for details on how to provide feedback and report issues.

ML Complete 今天以预览形式发布。它直接内置在 Dart analyzer 中，
因此在所有支持 Dart 的编辑器中都可用，
包括 Android Studio、IntelliJ 和 VS Code。
关于如何选择启用这个预览特性，以及如何提供反馈和报告问题，
请参阅[这个 wiki 页面](https://github.com/dart-lang/sdk/wiki/Previewing-Dart-code-completions-powered-by-machine-learning)。

Because the feature is still in preview, the version in the current Flutter and Dart stable releases does not include the performance and polish work that we expect to have in later builds. We therefore recommend that you temporarily use the Flutter [dev channel](https://github.com/flutter/flutter/wiki/Flutter-build-release-channels) or a Dart [dev channel](https://dart.dev/tools/sdk/archive#dev-channel) when previewing this feature.

由于该特性仍处于预览阶段，当前 Flutter 和 Dart 稳定版中的版本
尚未包含我们预计在后续构建中完成的性能优化和打磨工作。
因此我们建议你在预览该特性时，暂时使用 Flutter
[dev 渠道](https://github.com/flutter/flutter/wiki/Flutter-build-release-channels)
或 Dart [dev 渠道](https://dart.dev/tools/sdk/archive#dev-channel)。

## Preview: `dart:ffi` foreign function interface for Dart-C interop

## 预览：用于 Dart-C 互操作的 `dart:ffi` 外部函数接口

Many developers have asked us for better support for calling C code from Dart. One very clear signal is the Flutter issue tracker, where C interop is the single [highest rated open feature request](https://github.com/flutter/flutter/issues?q=is%3Aissue+is%3Aopen+sort%3Areactions-%2B1-desc) with more than 600 👍 votes. Many interesting use cases are behind these requests, ranging from calling low-level platform APIs like [stdlib.h](https://pubs.opengroup.org/onlinepubs/009695399/basedefs/stdlib.h.html) or [Win32](https://en.wikipedia.org/wiki/Windows_API) to leveraging existing cross-platform libraries and utilities written in C like TensorFlow, Realm, and SQLite.

许多开发者要求我们更好地支持从 Dart 调用 C 代码。
一个非常明显的信号是 Flutter issue 跟踪器：C 互操作是
[评分最高的未关闭特性请求](https://github.com/flutter/flutter/issues?q=is%3Aissue+is%3Aopen+sort%3Areactions-%2B1-desc)，
获得了超过 600 个 👍。这些请求背后有许多有趣的用例，
从调用 [stdlib.h](https://pubs.opengroup.org/onlinepubs/009695399/basedefs/stdlib.h.html)
或 [Win32](https://en.wikipedia.org/wiki/Windows_API) 这样的底层平台 API，
到利用 TensorFlow、Realm 和 SQLite 等用 C 编写的现有跨平台库和工具。

Currently, support for calling C directly from Dart is limited to deep integration into the Dart VM using [native extensions](https://dart.dev/server/c-interop-native-extensions). Alternatively Flutter apps can use C indirectly by calling the host using [platform channels](https://flutter.dev/docs/development/platform-integration/platform-channels) and calling onwards to C from there; this is an undesirable double indirection. We aspire to offer a new mechanism that offers great performance, is easy to approach, and works across the many supported Dart [platforms and compilers](https://dart.dev/platforms).

目前，直接从 Dart 调用 C 的支持仅限于使用
[native extensions](https://dart.dev/server/c-interop-native-extensions)
深度集成到 Dart VM 中。或者，Flutter 应用可以通过
[platform channels](https://flutter.dev/docs/development/platform-integration/platform-channels)
调用宿主来间接使用 C，再从那里继续调用 C；
这是一种不理想的双重间接。我们希望提供一种新机制，
它性能出色、易于上手，并且能在 Dart 支持的众多
[平台和编译器](https://dart.dev/platforms)上工作。

Dart-C interop enables two main scenarios:

Dart-C 互操作支持两大主要场景：

* Calling into a C-based system API on the host operating system (OS)

  调用宿主操作系统（OS）上基于 C 的系统 API

* Calling into a C-based library, either for a single OS or cross-platform

  调用基于 C 的库，可以是单一操作系统的，也可以是跨平台的

## Calling C-based operating system APIs

## 调用基于 C 的操作系统 API

Let’s take a concrete look at the first category. We’ll call the Linux command [`system`](https://man.openbsd.org/system.3). This command enables executing any system command; the argument you pass to it is essentially passed to the shell/terminal and run there. Here’s the C header for this command:

让我们具体看看第一类场景。我们将调用 Linux 命令
[`system`](https://man.openbsd.org/system.3)。这个命令可以执行任意系统命令；
你传给它的参数本质上会被交给 shell/终端并在那里运行。
下面是这个命令的 C 头文件声明：

```dart
// C header: int system(const char *command) in stdlib.h
```

The core challenge of any interop mechanism is dealing with the differences in semantics across two languages. For `dart:ffi`, the Dart code needs to represent two things:

任何互操作机制的核心挑战，都是处理两种语言之间的语义差异。
对于 `dart:ffi`，Dart 代码需要表达两样东西：

1. The C function and the types of its arguments and return type

  C 函数及其参数类型和返回类型

1. The corresponding Dart function, and its types

  对应的 Dart 函数及其类型

We do that by defining two typedefs:

我们通过定义两个 typedef 来做到：

```dart
// C header typedef:
typedef SystemC = ffi.Int32 Function(ffi.Pointer<Utf8> command);

// Dart header typedef:
typedef SystemDart = int Function(ffi.Pointer<Utf8> command);
```

Next we need to load the library and look up the function we’re going to call. How to do this depends on the operating system; in this example we’re using macOS. (We have [complete examples](https://github.com/dart-lang/samples/tree/master/ffi/system-command) for macOS, Windows, and Linux.)

接下来我们需要加载库并查找要调用的函数。具体做法取决于操作系统；
本例中我们使用 macOS。（我们提供了 macOS、Windows 和 Linux 的
[完整示例](https://github.com/dart-lang/samples/tree/master/ffi/system-command)。）

```dart
// Load `stdlib`. On MacOS this is in libSystem.dylib.
final dylib = ffi.DynamicLibrary.open('/usr/lib/libSystem.dylib');

// Look up the system function.
final systemP = dylib.lookupFunction<SystemC, SystemDart>('system');
```

Next, we encode the string argument using the encoding relevant for the particular operating system, invoke the function, and free the argument memory again:

接下来，我们用特定操作系统对应的编码方式对字符串参数进行编码，
调用函数，然后释放参数内存：

```dart
// Allocate a pointer to a Utf8 array containing our command.
final cmdP = Utf8.toUtf8('open http://dart.dev');

// Invoke the command.
systemP(cmdP);

// Free the pointer.
cmdP.free();
```

This code executes the system command, causing the system-default browser to open dart.dev:

这段代码执行了 system 命令，让系统默认浏览器打开 dart.dev：

<DashImage src="images/0-S9fZutz89QcrwEw.webp" alt="A developer executes a system command via dart:ffi to open the default browser." caption="*Executing the system command via dart:ffi to open the default browser*" />


## Calling C-based frameworks and components

## 调用基于 C 的框架和组件

A second core use of `dart:ffi` is to invoke C-based frameworks and components. The ML-based code completion discussed in the beginning of this post is a concrete example of this! It uses [TensorFlow Lite](https://www.tensorflow.org/lite), which is a [C-based API](https://www.tensorflow.org/lite/api_docs/cc). Using `dart:ffi` allows us to run TensorFlow across all the operating systems where we need to offer code completions, with the high performance of the native TensorFlow implementation. If you want to take a peek at the code for the Dart TensorFlow integration, look at [this repo](https://github.com/dart-lang/tflite_native).

`dart:ffi` 的第二个核心用途是调用基于 C 的框架和组件。
本文开头讨论的基于机器学习的代码补全就是一个具体例子！
它使用 [TensorFlow Lite](https://www.tensorflow.org/lite)，
这是一个[基于 C 的 API](https://www.tensorflow.org/lite/api_docs/cc)。
使用 `dart:ffi` 让我们能够在所有需要提供代码补全的操作系统上
运行 TensorFlow，并获得原生 TensorFlow 实现的高性能。
如果你想看看 Dart TensorFlow 集成的代码，
请查看[这个仓库](https://github.com/dart-lang/tflite_native)。

We also expect that the ability to call C-based libraries will be of great use to Flutter apps. You can imagine calling native libraries such as [Realm](https://github.com/realm/realm-core) or [SQLite](https://www.sqlite.org/c3ref/intro.html), and we think `dart:ffi` will be valuable for enabling plugins for [Flutter desktop](https://github.com/flutter/flutter/wiki/Desktop-shells).

我们也预期调用基于 C 的库的能力将对 Flutter 应用大有用处。
你可以想象调用 [Realm](https://github.com/realm/realm-core)
或 [SQLite](https://www.sqlite.org/c3ref/intro.html) 这样的原生库，
我们认为 `dart:ffi` 对于为
[Flutter 桌面](https://github.com/flutter/flutter/wiki/Desktop-shells)
启用插件将非常有价值。

## Wrapping APIs and code generation

## 包装 API 与代码生成

As you may have noticed, there’s a bit of programming overhead in describing the functions and looking up their symbols. A lot of this boilerplate code could be generated from the C header files. We’re currently focused on providing the underlying primitives, but would love to collaborate with anyone who’s interested in working on a generator.

你可能已经注意到，描述函数和查找它们的符号有一些编程开销。
这些样板代码很多都可以从 C 头文件生成。
我们目前专注于提供底层原语，
但非常乐意与任何有兴趣开发生成器的人合作。

## How to try dart:ffi

## 如何试用 dart:ffi

The `dart:ffi` library is launching in preview today. Because it’s still in preview, we recommend that you use the Flutter [master channel](https://github.com/flutter/flutter/wiki/Flutter-build-release-channels) or a Dart [dev channel](https://dart.dev/tools/sdk/archive#dev-channel) to get quick access to our changes and improvements as they’re made. Note that the API is likely to have breaking changes between now and its completion, as we add polish and broaden support for common patterns. You can get a detailed view into what [we currently have planned](https://github.com/dart-lang/sdk/projects/13) for our first release. Here are a few limitations you should know about:

`dart:ffi` 库今天以预览形式发布。由于仍处于预览阶段，
我们建议你使用 Flutter
[master 渠道](https://github.com/flutter/flutter/wiki/Flutter-build-release-channels)
或 Dart [dev 渠道](https://dart.dev/tools/sdk/archive#dev-channel)，
以便第一时间获取我们的改动和改进。请注意，在我们打磨并扩展
对常见模式的支持期间，从现在到最终完成，API 很可能会有破坏性变更。
你可以详细了解我们为首个版本
[目前规划的内容](https://github.com/dart-lang/sdk/projects/13)。
以下是你应该知道的一些限制：

* The library doesn’t support nested structs, inline arrays, packed data, or platform-dependent primitive types.

  该库不支持嵌套结构体、内联数组、紧凑数据（packed data）或依赖平台的基本类型。

* Performance of pointer operations is lacking (but can be worked around using [Pointer.asExternalTypedData](https://github.com/dart-lang/sdk/blob/master/sdk/lib/ffi/ffi.dart#L132)).

  指针操作的性能欠佳（但可以用
  [Pointer.asExternalTypedData](https://github.com/dart-lang/sdk/blob/master/sdk/lib/ffi/ffi.dart#L132)
  变通解决）。

* The library has no support for finalizers (callbacks invoked when an object is about to be garbage collected).

  该库不支持 finalizer（在对象即将被垃圾回收时调用的回调）。

The [C interop documentation](https://dart.dev/guides/libraries/c-interop) and [`dart:ffi` API reference](https://api.dart.dev/dev/) document the core concepts and point to examples that you can review. If you experience any issues or have questions, we invite you to post on the [Dart FFI discussion group](https://groups.google.com/forum/#!forum/dart-ffi), or [file an issue](https://github.com/dart-lang/sdk/issues/new?labels=area-vm,library-ffi).

[C 互操作文档](https://dart.dev/guides/libraries/c-interop)
和 [`dart:ffi` API 参考](https://api.dart.dev/dev/)
介绍了核心概念，并指向可供你查阅的示例。
如果你遇到任何问题或有疑问，欢迎在
[Dart FFI 讨论组](https://groups.google.com/forum/#!forum/dart-ffi)发帖，
或[提交 issue](https://github.com/dart-lang/sdk/issues/new?labels=area-vm,library-ffi)。

## Improved constant expressions

## 改进的常量表达式

Dart has long supported creating [const variables and values](https://dart.dev/guides/language/language-tour#final-and-const); these are guaranteed to be compile-time constant, and thus have very good performance characteristics. In previous releases, constant expressions were a bit limited. As of Dart 2.5, we support many more ways to define constant expressions, including the ability to use casts and the new control flow and collection spread features shipped in [Dart 2.3](/blog/announcing-dart-2-3-optimized-for-building-user-interfaces):

Dart 长期以来一直支持创建
[const 变量和值](https://dart.dev/guides/language/language-tour#final-and-const)；
它们保证是编译时常量，因此具有非常好的性能特征。
在之前的版本中，常量表达式有些受限。从 Dart 2.5 开始，
我们支持更多定义常量表达式的方式，包括使用类型转换，
以及 [Dart 2.3](/blog/announcing-dart-2-3-optimized-for-building-user-interfaces)
中发布的新控制流和集合展开特性：

```dart
// Example: these are now valid compile-time constants.
const Object i = 3;
const list = [i as int];
const set = {if (list is List<int>) ...list};
const map = {if (i is int) i: "int"};
```

## Closing thoughts

## 结语

We’ve got an exciting next few quarters lined up ahead of us, with work well underway for [extension methods](https://github.com/dart-lang/language/issues/41), enforcing that references are [non-nullable](/blog/dart-nullability-syntax-decision-a-b-or-a-b), and some early planning for [the language beyond that](https://github.com/dart-lang/language/projects/1). We’re also investigating improved concurrency support — for example the ability to better use multi-core processors on modern mobile phones.

接下来几个季度我们安排了令人兴奋的工作：
[扩展方法](https://github.com/dart-lang/language/issues/41)的开发正在顺利推进，
强制引用[不可空](/blog/dart-nullability-syntax-decision-a-b-or-a-b)的工作也是如此，
还有对[更远的语言未来](https://github.com/dart-lang/language/projects/1)的一些早期规划。
我们也在研究改进并发支持——例如更好地利用现代手机上的多核处理器。

We’re especially enthusiastic about non-nullable by default. We’ve lined up a [pretty ambitious plan](https://github.com/dart-lang/language/blob/master/accepted/future-releases/nnbd/roadmap.md) for this feature, and have [a lot of work](https://github.com/dart-lang/language/issues?utf8=%E2%9C%93&q=is%3Aissue++label%3Annbd+) underway. A few more recent languages were designed with support for non-nullable from the beginning, while most existing languages that added non-nullable support in a later version settled for a fairly limited approach limited to additional static analysis. One main differentiator of our approach is that we’re aiming for full [sound non-nullable](https://github.com/dart-lang/language/blob/master/accepted/future-releases/nnbd/roadmap.md#soundness) support. Briefly explained, this means that our understanding of non-nullability will extend to the core of the type system, and once our type system knows that something is non-nullable, we can fully trust that information, and our backend compiler is free to optimize the code. This soundness has large advantages, both in terms of offering a consistent “no-exceptions experience” and in terms of code size and runtime performance.

我们对默认不可空（non-nullable by default）尤其充满热情。
我们为这个特性制定了
[相当雄心勃勃的计划](https://github.com/dart-lang/language/blob/master/accepted/future-releases/nnbd/roadmap.md)，
并且[大量工作](https://github.com/dart-lang/language/issues?utf8=%E2%9C%93&q=is%3Aissue++label%3Annbd+)正在进行中。
一些较新的语言从一开始就设计了不可空支持，
而大多数在后续版本中加入不可空支持的现有语言，
则选择了相当有限的方案，仅限于额外的静态分析。
我们方案的一个主要差异在于，我们的目标是完整的
[健全不可空](https://github.com/dart-lang/language/blob/master/accepted/future-releases/nnbd/roadmap.md#soundness)支持。
简单解释一下，这意味着我们对不可空性的理解将延伸到类型系统的核心：
一旦类型系统知道某个东西不可空，我们就可以完全信任这一信息，
后端编译器也可以放手优化代码。这种健全性有巨大优势，
既能提供一致的“无异常体验”，也有利于代码体积和运行时性能。

We’re always aware of the burden it places on our ecosystem whenever we change the language. Thus, we’re also [investing a lot](https://github.com/dart-lang/language/blob/master/accepted/future-releases/nnbd/roadmap.md#migration-path) in providing rich migration tooling for existing code. We hope this tooling will offset the majority of the migration cost. We’re also adding a few dedicated language and tool features enabling stepwise migration, and will make an effort to get both our own code and shared code on [https://pub.dev](https://pub.dev) migrated.

我们时刻意识到，每次改变语言都会给生态带来负担。因此，我们也
[投入大量精力](https://github.com/dart-lang/language/blob/master/accepted/future-releases/nnbd/roadmap.md#migration-path)
为现有代码提供丰富的迁移工具。我们希望这些工具能抵消大部分迁移成本。
我们还在添加一些专门的语言和工具特性来支持逐步迁移，
并会努力把我们自己的代码和 [https://pub.dev](https://pub.dev)
上的共享代码都迁移过来。

We look forward to sharing more news later this year!

期待在今年晚些时候与你分享更多消息！
