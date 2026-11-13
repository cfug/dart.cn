---
# title: "Announcing Dart 2.6 with dart2native: Compile Dart to self-contained, native executables"
title: "宣布 Dart 2.6 与 dart2native：把 Dart 编译为自包含的原生可执行文件"
# description: "Announcing Dart 2.6, featuring dart2native for compiling Dart apps to self-contained, native executables for Windows, macOS, and Linux"
description: "宣布 Dart 2.6，带来 dart2native，可将 Dart 应用编译为面向 Windows、macOS 和 Linux 的自包含原生可执行文件"
ai-translated: true
publishDate: 2019-11-05
author: mit-mit
image: images/0lY0iF-neazyL0aE-.webp
category: releases
layout: blog
---


Dart already offers [an extensive set of compilers](https://dart.dev/platforms) for building production-optimized code for mobile devices and the web. These flexible compilers enable our framework partners to target a wide range of form factors: Flutter apps on [Android & iOS](https://flutter.dev/docs), Flutter apps on the [web](https://flutter.dev/web) & [desktop](https://flutter.dev/desktop), AngularDart apps on the [web](https://angulardart.dev/), and Google Assistant on [embedded devices](https://developers.googleblog.com/2019/05/Flutter-io19.html).

Dart 已经提供了[一套丰富的编译器](https://dart.dev/platforms)，
用于为移动设备和 Web 构建生产级优化的代码。这些灵活的编译器
让我们的框架合作伙伴能够面向各种形态的设备：
[Android 和 iOS](https://flutter.dev/docs) 上的 Flutter 应用、
[Web](https://flutter.dev/web) 和[桌面](https://flutter.dev/desktop)上的 Flutter 应用、
[Web](https://angulardart.dev/) 上的 AngularDart 应用，
以及[嵌入式设备](https://developers.googleblog.com/2019/05/Flutter-io19.html)上的 Google Assistant。

Today we’re announcing **`dart2native`**, an extension of our existing compiler set, with the ability to compile Dart programs to self-contained executables containing ahead-of-time-compiled machine code. With dart2native, you can create tools for the command line on **macOS, Windows, or Linux** using Dart. This feature’s announcement picture [was implemented](https://gist.github.com/mit-mit/faec2bfc1d1cef7cd09df917e531c5c0) using the feature itself :-)

今天我们宣布 **`dart2native`**，它是我们现有编译器套件的扩展，
能够把 Dart 程序编译为包含提前编译机器码的自包含可执行文件。
借助 dart2native，你可以用 Dart 为 **macOS、Windows 或 Linux**
创建命令行工具。这个特性的发布配图[就是用该特性本身实现的](https://gist.github.com/mit-mit/faec2bfc1d1cef7cd09df917e531c5c0) :-)

<DashImage src="images/0lY0iF-neazyL0aE-.webp" alt="An animation of a bash terminal showing the command line interface." />


## Dart Native and the dart2native compiler

## Dart Native 与 dart2native 编译器

Dart has supported AOT (ahead-of-time) compilation to native machine code for several years, and [Dart Native](https://dart.dev/platforms) is thus fairly mature technology. However, in the past we only exposed this capability on iOS and Android mobile devices, via [Flutter](http://flutter.dev).

Dart 支持 AOT（提前编译）为原生机器码已有数年，
因此 [Dart Native](https://dart.dev/platforms) 是一项相当成熟的技术。
不过，过去我们只通过 [Flutter](http://flutter.dev)
在 iOS 和 Android 移动设备上暴露这一能力。

With `dart2native`, we’re extending our native compilation support to support traditional desktop operating systems running macOS, Windows, and Linux. Because the executables created with `dart2native` are self-contained, they can run on machines that don’t have the Dart SDK installed. And because they’re compiled with Dart’s AOT compiler, the executables start running in just a few milliseconds. As with other Dart compilers and runtimes, the same set of rich and consistent [core libraries](https://dart.dev/guides/libraries) are available in Dart when compiling to native code.

借助 `dart2native`，我们把原生编译支持扩展到运行 macOS、Windows
和 Linux 的传统桌面操作系统。由于用 `dart2native` 创建的可执行文件
是自包含的，它们可以在没有安装 Dart SDK 的机器上运行。
而且由于它们是用 Dart 的 AOT 编译器编译的，
这些可执行文件只需几毫秒就能开始运行。与其他 Dart 编译器和运行时一样，
在编译为原生代码时，Dart 中同样可以使用那套丰富而一致的
[核心库](https://dart.dev/guides/libraries)。

We’ve heard many customers ask for AOT compilation for desktop operating systems — the [sixth highest-rated issue](https://github.com/dart-lang/sdk/issues/36915) in our issue tracker — so we’re delighted to be able to make this feature available.

我们听到许多客户要求为桌面操作系统提供 AOT 编译——这是我们 issue
跟踪器中[评分第六高的 issue](https://github.com/dart-lang/sdk/issues/36915)——
所以我们很高兴能够提供这个特性。

> If you used dart2aot before, then as of 2.6 you’ll use dart2native. It provides a superset of dart2aot’s functionality.

> 如果你以前用过 dart2aot，那么从 2.6 开始你将改用 dart2native。它提供了 dart2aot 功能的超集。

## Building command line apps with dart2native

## 用 dart2native 构建命令行应用

The `dart2native` compiler is a great choice for building and deploying [Dart-based apps for the command line](https://dart.dev/tutorials/server/cmdline). These apps often use libraries such as [`dart:io`](https://api.dart.dev/stable/dart-io/dart-io-library.html) (basic I/O), `package:[http](https://pub.dev/packages/http)` (networking), and `package:[args](https://pub.dev/packages/args)` (argument parsing). Let’s review the basics of compiling a “hello, world” app to an executable:

`dart2native` 编译器是构建和部署
[基于 Dart 的命令行应用](https://dart.dev/tutorials/server/cmdline)的绝佳选择。
这些应用经常使用 [`dart:io`](https://api.dart.dev/stable/dart-io/dart-io-library.html)（基本 I/O）、
`package:[http](https://pub.dev/packages/http)`（网络）
和 `package:[args](https://pub.dev/packages/args)`（参数解析）等库。
我们来回顾一下把一个“hello, world”应用编译为可执行文件的基本步骤：

The source code `hello.dart`:

源代码 `hello.dart`：

```
main() {
  print(‘Hello Dart developers’);
}
```


Compile `hello.dart` to a `hello` executable:

把 `hello.dart` 编译为 `hello` 可执行文件：

```
$ dart2native src/hello.dart -o hello
Generated: /Users/mit/hello
```


Run `hello` measuring execution time:

运行 `hello` 并测量执行时间：

```
$ time ./hello
Hello Dart developers

real 0m0.049s
user 0m0.018s
sys 0m0.020s
```


Notice how the command starts, prints to stdout, and exits in a combined time of just 49 milliseconds!

注意这个命令从启动、向 stdout 打印到退出，总共只用了 49 毫秒！

We’ve seen a few Dart developers already experiment with `dart2native` for command-line tools:

我们已经看到一些 Dart 开发者尝试用 `dart2native` 构建命令行工具：

* Natalie from the [SASS](https://sass-lang.com/) (a popular CSS extension tool) team [reports](https://github.com/dart-lang/sdk/issues/32894#issuecomment-513975562) that after switching their Dart-based SASS implementation to compile with dart2native, it is now competitive in performance with LibSass, a C++ based implementation.

  [SASS](https://sass-lang.com/)（一个流行的 CSS 扩展工具）团队的 Natalie
  [报告](https://github.com/dart-lang/sdk/issues/32894#issuecomment-513975562)说，
  把他们基于 Dart 的 SASS 实现改用 dart2native 编译后，
  其性能现在已能与基于 C++ 的实现 LibSass 相媲美。

* Filip from the Dart DevRel team recompiled his [linkchecker](https://github.com/filiph/linkcheck/) tool with dart2native, and saw a [27x speedup](https://github.com/filiph/linkcheck/issues/7#issuecomment-496308288) when checking small sites.

  Dart DevRel 团队的 Filip 用 dart2native 重新编译了他的
  [linkchecker](https://github.com/filiph/linkcheck/) 工具，
  在检查小型网站时看到了 [27 倍的提速](https://github.com/filiph/linkcheck/issues/7#issuecomment-496308288)。

## Interoperability with C code via dart:ffi

## 通过 dart:ffi 与 C 代码互操作

Native apps often need to access native functionality from the surrounding operating system. These system APIs are typically exposed in native C-based libraries, and Dart supports interoperability with these libraries via `dart:ffi`, our new mechanism for [C interop](https://dart.dev/guides/libraries/c-interop), which we launched in preview in [Dart 2.5](/blog/announcing-dart-2-5-super-charged-development). The `dart2native` compiler is compatible with `dart:ffi`, so you can create and compile natively Dart apps that use it.

原生应用经常需要访问周边操作系统的原生功能。这些系统 API
通常以基于 C 的原生库形式暴露，Dart 通过 `dart:ffi` 支持与这些库互操作，
这是我们新的 [C 互操作](https://dart.dev/guides/libraries/c-interop)机制，
已在 [Dart 2.5](/blog/announcing-dart-2-5-super-charged-development) 中以预览形式发布。
`dart2native` 编译器与 `dart:ffi` 兼容，
所以你可以创建并原生编译使用它的 Dart 应用。

One team member recently used `dart:ffi` to create a [`dart_console`](https://pub.dev/packages/dart_console) library for console app development, which has functionality like getting window dimensions, reading and setting the cursor location, managing colors, and reading keys and control sequences. The ability to use `dart:ffi` makes Dart a very powerful language for console apps.

最近一位团队成员用 `dart:ffi` 创建了一个用于控制台应用开发的
[`dart_console`](https://pub.dev/packages/dart_console) 库，
它提供获取窗口尺寸、读取和设置光标位置、管理颜色、
读取按键和控制序列等功能。能够使用 `dart:ffi`
让 Dart 成为一门非常适合控制台应用的语言。

## kilo: a 7MB code editor written in less than 500 lines of Dart code

## kilo：用不到 500 行 Dart 代码写成的 7MB 代码编辑器

Using Dart core libraries, `dart:ffi`, and the dart_console library, we can create pretty interesting console apps. The dart_console package includes a full demo of *kilo*, a console text editor written in just ~[500 lines of Dart code](https://github.com/timsneath/dart_console/blob/master/example/kilo.dart). The name kilo comes from its origin, [`kilo.c`](https://github.com/antirez/kilo/blob/master/kilo.c), which was a C implementation in roughly 1000 lines of code.

利用 Dart 核心库、`dart:ffi` 和 dart_console 库，
我们可以创建相当有趣的控制台应用。dart_console package 包含一个
完整的 *kilo* 演示，这是一个仅用约
[500 行 Dart 代码](https://github.com/timsneath/dart_console/blob/master/example/kilo.dart)
写成的控制台文本编辑器。kilo 这个名字来自它的起源
[`kilo.c`](https://github.com/antirez/kilo/blob/master/kilo.c)，
那是一个大约 1000 行代码的 C 实现。

With the new `dart2native` compiler we can easily package this, and we end up with a 7MB self-contained code editor. Here’s a demo of compiling the editor, and then using the compiled editor to edit its own source code to fix a bug:

借助新的 `dart2native` 编译器，我们可以轻松打包它，
最终得到一个 7MB 的自包含代码编辑器。下面是一个演示：
先编译这个编辑器，然后用编译好的编辑器编辑它自己的源代码来修复一个 bug：

<DashImage src="images/0f5pvUnbesO4mGZmW.webp" alt="The kilo editor written in Dart and compiled to an executable with dart2native editing its own source code." caption="The kilo editor written in Dart and compiled to an executable with dart2native editing it’s own source code" />


## Building services with dart2native

## 用 dart2native 构建服务

Another potential use of the dart2native compiler is for small services — for example, a backend supporting a frontend app written using Flutter. In recent years, a growing trend has been the use of services running on [serverless computing](https://en.wikipedia.org/wiki/Serverless_computing). These are fully managed services that automatically scale, including scaling up from and down to zero (not running), providing the potential to greatly lower cost because they are billed only when actually running. Google Cloud makes serverless computing available via [Cloud Run](https://cloud.google.com/run/).

dart2native 编译器的另一个潜在用途是小型服务——例如，
为用 Flutter 编写的前端应用提供支撑的后端。近年来，
一个日益增长的趋势是使用运行在
[serverless 计算](https://en.wikipedia.org/wiki/Serverless_computing)上的服务。
这些是完全托管、自动伸缩的服务，包括从零（不运行）扩容和缩容到零，
由于只在实际运行时计费，因此有潜力大幅降低成本。
Google Cloud 通过 [Cloud Run](https://cloud.google.com/run/) 提供 serverless 计算。

For serverless backends it’s critical that the service starts quickly. Traditionally, Dart-based services have run with our JIT (just-in-time) compiler, but JIT-based execution has a high latency when starting as the code needs to be compiled and warmed up before it can start executing. By compiling your service’s code ahead-of-time to native code, you can avoid this latency and begin running right away. In addition, with native code you can create Dart services that have a small disk footprint and are self-contained, greatly reducing the size of the container in which the Dart service runs. Dart developer Paul Mundt recently [documented his experiences](https://itnext.io/experiments-with-dart-microservices-fa117aa408c7) with using the dart2native compiler; he was able to reduce the size of his Docker image by 91% from 220MB using JIT-compiled code down to just 20MB by using native code! See our documentation for more details about [server-side apps](https://dart.dev/tutorials/server/httpserver) and [packages](https://dart.dev/server/libraries#server-packages).

对 serverless 后端来说，服务快速启动至关重要。传统上，
基于 Dart 的服务使用我们的 JIT（即时编译）编译器运行，
但基于 JIT 的执行在启动时延迟很高，因为代码需要先编译并预热才能开始执行。
通过把服务代码提前编译为原生代码，你可以避免这种延迟，立即开始运行。
此外，借助原生代码，你可以创建磁盘占用小且自包含的 Dart 服务，
大幅缩小运行 Dart 服务的容器体积。Dart 开发者 Paul Mundt 最近
[记录了他使用 dart2native 编译器的经验](https://itnext.io/experiments-with-dart-microservices-fa117aa408c7)；
他把 Docker 镜像的体积从使用 JIT 编译代码的 220MB
缩减到使用原生代码的仅 20MB，减少了 91%！
关于[服务端应用](https://dart.dev/tutorials/server/httpserver)
和 [package](https://dart.dev/server/libraries#server-packages) 的更多细节，请参阅我们的文档。

## Availability

## 可用性

The `dart2native` compiler is available in the Dart SDK starting with version 2.6, which is available starting today from [dart.dev/get-dart](https://dart.dev/get-dart). Once you’ve installed the SDK, you should see the new compiler inside the bin/ directory and in your `PATH`. Dart.dev has [more documentation](https://dart.dev/tools/dart2native).

`dart2native` 编译器从 Dart SDK 2.6 版本开始提供，
今天起可从 [dart.dev/get-dart](https://dart.dev/get-dart) 获取。
安装 SDK 后，你应该能在 bin/ 目录和 `PATH` 中看到新的编译器。
Dart.dev 上有[更多文档](https://dart.dev/tools/dart2native)。

If you’re getting the Dart SDK via Flutter, note that current Flutter builds have incomplete dart2native support. We recommend you install the Dart 2.6 SDK from [dart.dev/get-dart](https://dart.dev/get-dart).

如果你通过 Flutter 获取 Dart SDK，请注意当前的 Flutter 构建
对 dart2native 的支持尚不完整。我们建议你从
[dart.dev/get-dart](https://dart.dev/get-dart) 安装 Dart 2.6 SDK。

## Known limitations

## 已知限制

This initial version of the `dart2native` compiler has a few known limitations, listed below. You can let us know which issues are important to you by adding a “thumbs up” to the issue in our GitHub issue tracker.

`dart2native` 编译器的这个初始版本有一些已知限制，列在下面。
你可以在我们的 GitHub issue 跟踪器中为相应 issue 点一个“赞”，
让我们知道哪些 issue 对你很重要。

* No cross-compilation support ([issue 28617](https://github.com/dart-lang/sdk/issues/28617)): The dart2native compiler supports creating machine code only for the operating system it’s running on. Thus, you’ll need to run the compiler three times — on macOS, Windows, and Linux — if you want to create executables for all three. One way of doing this is by using a CI (Continuous Integration) provider that supports all three operating systems.

  不支持交叉编译（[issue 28617](https://github.com/dart-lang/sdk/issues/28617)）：
  dart2native 编译器只支持为它所运行的操作系统生成机器码。因此，
  如果你想为三个平台都创建可执行文件，就需要运行编译器三次——
  分别在 macOS、Windows 和 Linux 上。一种做法是使用
  同时支持这三种操作系统的 CI（持续集成）服务商。

* No signing support ([issue 39106](https://github.com/dart-lang/sdk/issues/39106)): The executables produced use a format that isn’t compatible with standard signing tools such as `codesign` and `signtool`.

  不支持签名（[issue 39106](https://github.com/dart-lang/sdk/issues/39106)）：
  生成的可执行文件使用的格式与 `codesign` 和 `signtool`
  等标准签名工具不兼容。

* No support for `dart:mirrors` and `dart:developer` (see [Dart core libraries](https://dart.dev/guides/libraries)).

  不支持 `dart:mirrors` 和 `dart:developer`
  （参见 [Dart 核心库](https://dart.dev/guides/libraries)）。

## Other changes in Dart 2.6

## Dart 2.6 中的其他变化

Version 2.6 of the Dart SDK also has a few other changes.

Dart SDK 2.6 版本还有一些其他变化。

We launched a preview of `dart:ffi`, our new mechanism for [C interop](https://dart.dev/guides/libraries/c-interop), in [Dart 2.5](/blog/announcing-dart-2-5-super-charged-development). Dart 2.6 has a new version of `dart:ffi`. This new version has a number of breaking API changes to make our APIs easier to use, provide more type safety, and to provide convenient access to memory. For additional details, see the [Dart 2.6 changelog](https://github.com/dart-lang/sdk/blob/master/CHANGELOG.md#foreign-function-interface-dartffi). With these changes `dart:ffi` graduates to the beta, and we expect API changes to be much less frequent going forward, and general stability is expected to be high. Please continue to give us feedback via the [issue tracker](https://github.com/dart-lang/sdk/issues).

我们在 [Dart 2.5](/blog/announcing-dart-2-5-super-charged-development) 中
以预览形式发布了 `dart:ffi`，这是我们新的
[C 互操作](https://dart.dev/guides/libraries/c-interop)机制。Dart 2.6 带来了新版本的 `dart:ffi`。
这个新版本有一些破坏性 API 变更，目的是让 API 更易用、
提供更多类型安全，并方便地访问内存。更多细节请参阅
[Dart 2.6 变更日志](https://github.com/dart-lang/sdk/blob/master/CHANGELOG.md#foreign-function-interface-dartffi)。
随着这些变更，`dart:ffi` 毕业进入 beta 阶段，
我们预计今后 API 变更的频率会大幅降低，整体稳定性会很高。
请继续通过 [issue 跟踪器](https://github.com/dart-lang/sdk/issues)向我们提供反馈。

Dart 2.6 also contains a preview of an exciting new language feature, [extension methods](https://github.com/dart-lang/language/issues/41). We still have a bit of polish and tools work left to complete this feature, but we hope to formally launch it in our next Dart SDK version. We’ll have much more to say about extension methods then; for now you can read about the [design considerations behind the feature](/blog/dart-extension-method-fundamentals).

Dart 2.6 还包含一个令人兴奋的新语言特性的预览：
[扩展方法](https://github.com/dart-lang/language/issues/41)。
要完成这个特性，我们还有一些打磨和工具工作要做，
但我们希望在下一个 Dart SDK 版本中正式发布它。
届时我们会有更多关于扩展方法的内容要分享；
现在你可以先阅读[该特性背后的设计考量](/blog/dart-extension-method-fundamentals)。

## Next steps

## 下一步

Download the Dart 2.6 SDK ([dart.dev/get-dart](https://dart.dev/get-dart)), build something cool with dart2native, and then tell us about it. If you’re willing to share the details, please leave a response at the bottom of this article. We’re excited to see what you build!

下载 Dart 2.6 SDK（[dart.dev/get-dart](https://dart.dev/get-dart)），
用 dart2native 构建一些很酷的东西，然后告诉我们。
如果你愿意分享细节，请在本文底部留言。我们迫不及待想看到你的作品！
