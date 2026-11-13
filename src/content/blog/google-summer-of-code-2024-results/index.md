---
# title: "Google Summer of Code 2024 Results"
title: "Google Summer of Code 2024 成果"
# description: "Results from Dart contributors in Google Summer of Code 2024."
description: "Dart 贡献者在 Google Summer of Code 2024 中的成果。"
ai-translated: true
publishDate: 2024-10-14
author: jonasfj
image: images/0vm7AfKyip_pXJGCd.webp
category: other
layout: blog
---


The [Google Summer of Code](https://summerofcode.withgoogle.com/) (GSoC) program focuses on engaging new developers worldwide with open source software development. Google sponsors contributors to work with a mentoring open source organization on a 12-week programming project during the summer. Over the past 19 years, more than 20,000 contributors have participated in Google Summer of Code.

[Google Summer of Code](https://summerofcode.withgoogle.com/)（GSoC）计划致力于让世界各地的新开发者参与开源软件开发。Google 资助贡献者在暑期与一个担任指导的开源组织合作，完成一个为期 12 周的编程项目。过去 19 年里，已有超过 20,000 名贡献者参加过 Google Summer of Code。

<DashImage src="images/0vm7AfKyip_pXJGCd.webp" alt="The logos for Google Summer of Code and Dart side-by-side." />


In 2024, Dart participated as a mentoring organization in Google Summer of Code for a fifth consecutive year. This year we received 50 project proposals from prospective participants around the world. Today, we spotlight some of the projects we mentored this summer. The contributors describe their projects in this post.

2024 年，Dart 连续第五年作为指导组织参加 Google Summer of Code。今年我们收到了来自世界各地意向参与者的 50 份项目提案。今天，我们来重点介绍今年夏天指导的部分项目，由贡献者们在本文中亲自讲述。

## HTTP client using JNI bindings from OkHttp

## 基于 OkHttp JNI 绑定的 HTTP 客户端

*By Anikate De*

*作者：Anikate De*

Existing Dart HTTP clients couldn’t interact with native Android APIs, limiting support for KeyStore PrivateKeys, System Proxy, and User-Installed Certificates (all highly requested features by Dart users).

现有的 Dart HTTP 客户端无法与 Android 原生 API 交互，因此对 KeyStore 私钥、系统代理和用户安装的证书（这些都是 Dart 用户呼声很高的特性）支持有限。

The open-source project, [`OkHttp`](https://square.github.io/okhttp/), a popular choice for network-intensive applications on Android, possesses APIs that can seamlessly implement the above functionalities. Hence, `OkHttp` was chosen as a starting point for this project. Using the GSoC 2022 project, [`package:jnigen`](https://pub.dev/packages/jnigen), JNI Bindings for Dart were generated for several `OkHttp` APIs. The `OkHttpClient` is fully conformant with the existing HTTP Clients. allowing for a hassle-free transition to using `OkHttpClient` from any alternatives.

开源项目 [`OkHttp`](https://square.github.io/okhttp/) 是 Android 上网络密集型应用的热门选择，它的 API 可以无缝实现上述功能。因此，`OkHttp` 被选为这个项目的起点。借助 GSoC 2022 的项目 [`package:jnigen`](https://pub.dev/packages/jnigen)，我们为多个 `OkHttp` API 生成了 Dart 的 JNI 绑定。`OkHttpClient` 与现有 HTTP 客户端完全兼容，可以从任何替代方案毫无障碍地迁移到 `OkHttpClient`。

Besides asynchronous HTTP requests, [`package:ok_http`](https://pub.dev/packages/ok_http) also supports WebSockets, which requires passing all tests in `package:web_socket_conformance_test`. This allows a smooth transition from any WebSocket alternative. Flutter applications using the `package:ok_http` benchmark report the smallest APK size out of all the other HTTP clients Dart offers.

除了异步 HTTP 请求，[`package:ok_http`](https://pub.dev/packages/ok_http) 还支持 WebSocket，这要求通过 `package:web_socket_conformance_test` 中的所有测试，因此可以从任何 WebSocket 替代方案平滑迁移。基准测试显示，使用 `package:ok_http` 的 Flutter 应用在 Dart 提供的所有 HTTP 客户端中 APK 体积最小。

Leveraging the benefits of the `OkHttpClient` in your Flutter projects is as simple as importing it, and editing your current `Client` object!

要在你的 Flutter 项目中享受 `OkHttpClient` 的优势，只需导入它并修改现有的 `Client` 对象即可！

Read more about the details of the project in the [GSoC contributor’s report.](https://github.com/Anikate-De/gsoc-2024-project-report)

项目详情请阅读 [GSoC 贡献者报告](https://github.com/Anikate-De/gsoc-2024-project-report)。

## Swift2ObjC: ObjC wrappers generator

## Swift2ObjC：ObjC 包装器生成器

*By Mohammad Eid*

*作者：Mohammad Eid*

Dart can (indirectly) communicate with Swift code. This is done “through” ObjC, as Dart can communicate with C-based languages (like ObjC) using the [`ffi`](https://dart.dev/interop/c-interop) package. Swift APIs can be annotated with `@objc`to request that the compiler generate ObjC headers for them. Generating the `ffi` bindings for Dart is done automatically with [ffigen](https://pub.dev/packages/ffigen). For Swift, you’ll manually annotate the APIs that you want to communicate with..

Dart 可以（间接）与 Swift 代码通信。这是“经由”ObjC 完成的，因为 Dart 可以用 [`ffi`](https://dart.dev/interop/c-interop) package 与基于 C 的语言（如 ObjC）通信。Swift API 可以用 `@objc` 注解，请求编译器为其生成 ObjC 头文件。Dart 的 `ffi` 绑定由 [ffigen](https://pub.dev/packages/ffigen) 自动生成。而对于 Swift，你需要手动注解想要通信的 API。

Annotating Swift APIs might be more involved than adding an `@objc`annotation. What if you don’t own the module? If you can’t edit it, you must make a custom wrapper that mirrors the APIs so that you can annotate the methods. Also, since Swift is a modern language, and ObjC isn’t, you will likely encounter APIs that are not representable in ObjC out of the box, so you must work around these cases, too.

注解 Swift API 可能不只是加一个 `@objc` 注解那么简单。如果模块不是你维护的呢？如果你无法编辑它，就必须做一个镜像这些 API 的自定义包装器，才能注解其中的方法。另外，Swift 是现代语言而 ObjC 不是，你很可能遇到无法直接用 ObjC 表示的 API，这些情况也得想办法绕过。

Swift2ObjC handles these things for you: It generates wrappers for Swift modules and annotates them with `@objc`, while ensuring that all the APIs are representable in ObjC — the Swift module won’t compile, otherwise. I explain the implementation details in this [article](https://medium.com/@mohammad.mossad.eid/swift2objc-more-convenient-swift-dart-interoperability-b152dd5bed13) on Medium (which you can reference if you’re considering contributing to the tool as it’s still in active development). You can also dive into the source code in the [swift2obj](https://github.com/dart-lang/native/tree/cf13658c3bc92e62893ec15659dc1370a7d07e8a/pkgs/swift2objc) repo on GitHub.

Swift2ObjC 替你处理这些事情：它为 Swift 模块生成包装器并用 `@objc` 注解，同时确保所有 API 都能用 ObjC 表示——否则 Swift 模块根本无法编译。我在 Medium 上的这篇[文章](https://medium.com/@mohammad.mossad.eid/swift2objc-more-convenient-swift-dart-interoperability-b152dd5bed13)中解释了实现细节（如果你考虑为这个仍在活跃开发的工具做贡献，可以参考它）。你也可以深入 GitHub 上 [swift2objc](https://github.com/dart-lang/native/tree/cf13658c3bc92e62893ec15659dc1370a7d07e8a/pkgs/swift2objc) 仓库的源码。

## Testing documentation comments with `dartdoc_test`

## 用 `dartdoc_test` 测试文档注释

*By Takuma Ichikawa*

*作者：Takuma Ichikawa*

Dart allows code samples to be embedded within documentation comments. This is a beneficial practice, because it’s also published as API documentation and shows how to use the package in a way that is easy to understand for both package users and developers. However, code samples in documentation comments are not analyzed or tested, making it difficult to find errors and making them less maintainable. As projects and documentation grow, this issue becomes more significant.

Dart 允许在文档注释中嵌入代码示例。这是一种有益的做法，因为文档注释会作为 API 文档发布，以对 package 用户和开发者都易于理解的方式展示 package 的用法。然而，文档注释中的代码示例不会被分析或测试，导致错误难以发现、可维护性差。随着项目和文档规模增长，这个问题会越来越突出。

Therefore for GSOC, I have developed the [`dartdoc_test`](https://pub.dev/packages/dartdoc_test) package to solve such problems. The `dartdoc_test` tool can extract and analyze code samples in documentation comments to find potential errors. By adding the package to your project and running it from the command line, you can find errors in all code samples. You can also perform static analysis of code samples when running the `dart test` command, by adding the `dartdoc_test` test file.

因此我在 GSoC 中开发了 [`dartdoc_test`](https://pub.dev/packages/dartdoc_test) package 来解决这类问题。`dartdoc_test` 工具可以提取并分析文档注释中的代码示例，找出潜在错误。把这个 package 加入你的项目并在命令行运行，就能发现所有代码示例中的错误。你还可以添加 `dartdoc_test` 测试文件，在运行 `dart test` 命令时对代码示例做静态分析。

It’s easy to try `dartdoc_test`on your Dart project by running the following two commands.

只需运行下面两条命令，就能在你的 Dart 项目中轻松试用 `dartdoc_test`。

```shell
dart pub add dev:dartdoc_test
dart run dartdoc_test
```


To learn more, check out [`dartdoc_test`](https://pub.dev/packages/dartdoc_test) on pub.dev.

要了解更多，请查看 pub.dev 上的 [`dartdoc_test`](https://pub.dev/packages/dartdoc_test)。

## Generate dart:ffi bindings on the web using WASM with FFIgenPad

## 用 FFIgenPad 在 Web 上通过 WASM 生成 dart:ffi 绑定

*By TheComputerM*

*作者：TheComputerM*

Dart, as a language that can be compiled to various targets, includes capabilities that facilitate communication with native binaries. You can use packages like [`dart:ffi`](https://dart.dev/interop/c-interop) to interact with C APIs and [`package:jni`](https://pub.dev/packages/jni) to interact with Java code. You merely write some glue code to specify the type signature of the native function you are calling.

Dart 是一门可以编译到多种目标的语言，具备与原生二进制通信的能力。你可以用 [`dart:ffi`](https://dart.dev/interop/c-interop) 与 C API 交互，用 [`package:jni`](https://pub.dev/packages/jni) 与 Java 代码交互。你只需写一些胶水代码，指定所调用原生函数的类型签名。

The problem arises when you use a library that has many exports, too many to write by hand. This problem is solved with [`ffigen`](https://pub.dev/packages/ffigen) (a previous GSoC project), a tool that generates the bindings using just the library’s header files. To do that you would have to install `ffigen`, set up all the proper dependencies and requirements, then (likely) iterate again and again. This isn’t exactly the definition of seamless and easy. So FFIgenPad came into being.

问题在于：当你使用的库有大量导出、多到无法手写时怎么办。这个问题可以用 [`ffigen`](https://pub.dev/packages/ffigen)（此前的一个 GSoC 项目）解决，这个工具只用库的头文件就能生成绑定。但为此你得安装 `ffigen`、配置好所有依赖和前置条件，然后（很可能）反复迭代。这可算不上无缝和简单。于是 FFIgenPad 应运而生。

<DashImage src="images/0sB2hJW3ZkMCeF9Mp.webp" alt="The FFIgenPad web interface showing C code translated into Dart FFI bindings." />


Another goal of the project was to test out the `dart2wasm` compiler (you can find my experiments in [this blogpost](https://thecomputerm.hashnode.dev/dirty-deeds-done-dart-cheap-experiments-with-dart2wasm)). Sure, we could have run `ffigen` on a server and stuck a UI on it. Instead, I made sure that FFIgenPad runs fully on the browser by compiling both `libclang` and `ffigen` to WebAssembly (why use a server for computation when you can use the client’s system).

这个项目的另一个目标是试验 `dart2wasm` 编译器（我的实验见[这篇博客](https://thecomputerm.hashnode.dev/dirty-deeds-done-dart-cheap-experiments-with-dart2wasm)）。当然，我们本可以在服务器上运行 `ffigen` 再套个 UI。但我选择把 `libclang` 和 `ffigen` 都编译到 WebAssembly，让 FFIgenPad 完全在浏览器中运行（既然能用客户端的算力，何必用服务器呢）。

Check out the demo at [`https://ffigenpad.surge.sh/`](https://ffigenpad.surge.sh/) and the source code in [my fork](https://github.com/TheComputerM/dart-native/tree/ffigenpad) on GitHub. I would like to thank my mentors [Prerak Mann](https://github.com/mannprerak2), [Daco Harkes](https://github.com/dcharkes), and [Jackson Gardner](https://github.com/eyebrowsoffire) for chiming in whenever I asked for help.

请访问 [`https://ffigenpad.surge.sh/`](https://ffigenpad.surge.sh/) 体验演示，源码在 GitHub 上[我的 fork](https://github.com/TheComputerM/dart-native/tree/ffigenpad) 中。感谢我的导师 [Prerak Mann](https://github.com/mannprerak2)、[Daco Harkes](https://github.com/dcharkes) 和 [Jackson Gardner](https://github.com/eyebrowsoffire)，每当我求助时他们总会及时相助。