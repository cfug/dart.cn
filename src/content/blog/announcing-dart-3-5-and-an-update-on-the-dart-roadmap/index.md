---
# title: "Announcing Dart 3.5, and an update on the Dart roadmap"
title: "宣布 Dart 3.5，以及 Dart 路线图更新"
# description: "It’s time for another of our quarterly Dart SDK releases. We have improvements in interoperability, new features in our pub.dev package…"
description: "又到了季度 Dart SDK 发布时间。我们改进了互操作、pub.dev 包管理器新特性……"
ai-translated: true
publishDate: 2024-08-06
author: mit-mit
image: images/1PVj9TIzP50I00tavJqAg_Q.webp
category: releases
layout: blog
---


It’s time for another of our quarterly Dart SDK releases. We have improvements in interoperability, new features in our pub.dev package manager, and we’ve graduated our new web integration APIs to stable and version 1.0.

又到了我们季度 Dart SDK 发布的时间。我们改进了互操作、为 pub.dev 包管理器带来新特性，并让新的 Web 集成 API 进入稳定版 1.0。

A large portion of our time has been dedicated to larger, multi-quarter efforts, so with that we also have an update on our Dart roadmap, with details on what we hope to make progress on in the coming quarters.

我们的大部分时间都投入在更大的、跨季度的工作上，因此我们也带来了 Dart 路线图的更新，详细介绍未来几个季度希望推进的内容。

<DashImage src="images/1PVj9TIzP50I00tavJqAg_Q.webp" alt="Dart 3.5 release banner with the Dart logo and a bullseye icon." caption="Dart 3.5 release image." />


## New capabilities in Dart 3.5

## Dart 3.5 的新能力

Dart 3.5 features a number of new capabilities discussed below. There are also a smaller number of changes to core library APIs, and about 10 very minor breaking changes, covered in the [changelog](https://github.com/dart-lang/sdk/blob/master/CHANGELOG.md#350).

Dart 3.5 带来了下文讨论的多项新能力。还有少量核心库 API 变更和约 10 个非常小的破坏性变更，详见[更新日志](https://github.com/dart-lang/sdk/blob/master/CHANGELOG.md#350)。

## Web platform and JS interoperability

## Web 平台与 JS 互操作

In Dart 3.4 and Flutter 3.22 we introduced support for [compiling Flutter Web apps to WebAssembly](https://docs.flutter.dev/platform-integration/web/wasm). Compilation to WebAssembly requires using our new [Dart to JS interop model](https://dart.dev/interop/js-interop), which previously was in preview. As of Dart 3.5 it is now considered stable and complete, and we’ve updated the browser API bindings in [package:web](https://pub.dev/packages/web) (which replaces the older `dart:html` library) to version 1.0.

在 Dart 3.4 和 Flutter 3.22 中，我们引入了[把 Flutter Web 应用编译到 WebAssembly](https://docs.flutter.dev/platform-integration/web/wasm) 的支持。编译到 WebAssembly 需要使用我们新的 [Dart 到 JS 互操作模型](https://dart.dev/interop/js-interop)，它此前处于预览状态。从 Dart 3.5 起它已被视为稳定且完整，我们也把 [package:web](https://pub.dev/packages/web)（取代旧的 `dart:html` 库）中的浏览器 API 绑定更新到了 1.0 版本。

We’d like to encourage all web package authors to [migrate to package:web](https://dart.dev/interop/js-interop/package-web). We plan on deprecating the old interop APIs (dart:html, dart:js, package:js, etc.) in our next Dart release, and fully discontinuing them later next year. We invite you to offer feedback on this plan in [the tracking issue](https://github.com/dart-lang/sdk/issues/56358). We also plan on updating the [scoring](https://pub.dev/help/scoring) on the pub.dev package manager to award points for web packages that support the new interop model.

我们鼓励所有 Web package 作者[迁移到 package:web](https://dart.dev/interop/js-interop/package-web)。我们计划在下一个 Dart 版本中弃用旧的互操作 API（dart:html、dart:js、package:js 等），并在明年晚些时候完全停用它们。欢迎在[跟踪 issue](https://github.com/dart-lang/sdk/issues/56358) 中对这一计划提供反馈。我们还计划更新 pub.dev 包管理器的[评分](https://pub.dev/help/scoring)，为支持新互操作模型的 Web package 加分。

We’ve also added [a new lint](https://dart.dev/tools/linter-rules/invalid_runtime_check_with_js_interop_types), which validates that your code uses the new JS interop types correctly. We recommend that you add this lint to your `analysis_options.yaml` file as part of migrating your web packages.

我们还添加了[一个新 lint](https://dart.dev/tools/linter-rules/invalid_runtime_check_with_js_interop_types)，验证你的代码正确使用了新的 JS 互操作类型。建议在迁移 Web package 时把这个 lint 加入你的 `analysis_options.yaml` 文件。

## Dart native interoperability

## Dart 原生互操作

We’ve also made a range of improvements to our native interoperability, which supports calling directly from Dart into C, Java, Kotlin, Objective-C, and Swift.

我们还对原生互操作做了一系列改进，它支持从 Dart 直接调用 C、Java、Kotlin、Objective-C 和 Swift。

C interop is enabled by our [FFI](https://dart.dev/interop/c-interop) (Foreign Function Interface) library, which we’ve supported for several years. In Dart 3.5, we’ve made incremental improvements to support passing a pointer from Dart `TypedData` objects directly to FFI, avoiding having to first copy the memory from Dart to Native ([details](https://github.com/dart-lang/sdk/issues/44589)).

C 互操作由我们的 [FFI](https://dart.dev/interop/c-interop)（外部函数接口）库实现，已支持多年。在 Dart 3.5 中，我们做了渐进式改进，支持把 Dart `TypedData` 对象的指针直接传给 FFI，避免先把内存从 Dart 复制到原生（[详情](https://github.com/dart-lang/sdk/issues/44589)）。

Java & Kotlin interop is enabled by the [JNIgen](https://pub.dev/packages/jnigen) generator (currently in preview), which automates the creation of the bindings code to call from Dart into Java & Kotlin via the Java Native Interface ([JNI](https://developer.android.com/training/articles/perf-jni)). We’ve improved performance and added support for Java exceptions and Kotlin top-level functions. We’ve also discontinued the former [C-based bindings](https://github.com/dart-lang/native/issues/660), as the alternate Dart-only bindings now have comparable performance and features, and are much easier to use, For details, see the [changelog](https://pub.dev/packages/jnigen/changelog).

Java 和 Kotlin 互操作由 [JNIgen](https://pub.dev/packages/jnigen) 生成器（目前处于预览）实现，它自动创建通过 Java 原生接口（[JNI](https://developer.android.com/training/articles/perf-jni)）从 Dart 调用 Java 和 Kotlin 的绑定代码。我们改进了性能，添加了对 Java 异常和 Kotlin 顶层函数的支持。我们还停用了以前[基于 C 的绑定](https://github.com/dart-lang/native/issues/660)，因为替代的纯 Dart 绑定现在具有相当的性能和特性，而且易用得多。详情见[更新日志](https://pub.dev/packages/jnigen/changelog)。

Objective-C interop builds on top of FFI and our [FFIgen](https://pub.dev/packages/ffigen) generator (currently in preview). We’ve added support for Objective-C protocols, and common types such as `NSString`. For a large example of a package built with FFIgen, see [cupertino_http](https://github.com/dart-lang/http/tree/master/pkgs/cupertino_http) which interoperates with Apple’s URL Loading System networking library.

Objective-C 互操作建立在 FFI 和我们的 [FFIgen](https://pub.dev/packages/ffigen) 生成器（目前处于预览）之上。我们添加了对 Objective-C 协议和 `NSString` 等常见类型的支持。用 FFIgen 构建 package 的大型示例见 [cupertino_http](https://github.com/dart-lang/http/tree/master/pkgs/cupertino_http)，它与 Apple 的 URL Loading System 网络库互操作。

We’ll continue to invest in further interoperability — both in terms of completing the above mentioned libraries, and in terms of supporting Swift — over the coming releases. See the roadmap section below for details.

在接下来的版本中，我们会继续投入更多互操作——既完善上述库，也支持 Swift。详情见下文路线图部分。

## Pub.dev package repository

## Pub.dev package 仓库

Pub.dev is our package repository where the community can share and find packages with a wealth of functionality. We’ve made a number of improvements here. First we’ve refined the support for [**topics**](https://dart.dev/tools/pub/pubspec#topics): the mechanism by which package authors can tag their packages with the category that they belong to (such as widget). We now [consolidate](https://github.com/dart-lang/pub-dev/blob/master/doc/topics.yaml) common topics that cover the same category but use slight variations in their phrasing (for example widgets vs widget).

Pub.dev 是我们的 package 仓库，社区可以在这里分享和发现功能丰富的 package。我们在这里做了多处改进。首先完善了 [**topics**](https://dart.dev/tools/pub/pubspec#topics) 支持：package 作者用它给 package 打上所属类别的标签（例如 widget）。我们现在会[合并](https://github.com/dart-lang/pub-dev/blob/master/doc/topics.yaml)覆盖同一类别但措辞略有差异的常见 topic（例如 widgets 与 widget）。

Second, we’ve added a new `pub unpack` command. This offers a quick and easy way to download a package to your file system. This can be used, for example, if you want to run the example program of a package on your local machine:

其次，我们添加了新的 `pub unpack` 命令。它提供了把 package 下载到文件系统的快捷方式。例如，你想在本机运行某个 package 的示例程序时就可以用它：

```bash
$ dart pub unpack path
Downloading path 1.9.0 to `./path-1.9.0`...

$ cd path-1.9.0/example/

$ dart run example.dart
Current path style: posix
Current process path: /Users/mit/tmp/path-1.9.0/example
```


Third, we’ve added a new `pub downgrade --tighten` command. This can be used to check all the version constraints in a package’s dependencies. When run, it updates the lower constraint to the lowest version for which pub was able to do a resolution.

第三，我们添加了新的 `pub downgrade --tighten` 命令。它可以用来检查 package 依赖中的所有版本约束。运行时，它会把下限约束更新为 pub 能够完成解析的最低版本。

## Dart roadmap update

## Dart 路线图更新

In addition to the completed features above, we’ve also done work across a large number of areas to make progress on our long-term roadmap.

除了上述已完成的特性，我们还在大量领域开展工作，推进长期路线图。

## IDE and analyzer performance for large monorepos

## 大型 monorepo 的 IDE 与分析器性能

A ‘monorepo’ is a common way of structuring the source code for a set of related packages and apps in a single repository, for example as in Flutter’s [packages repo](https://github.com/flutter/packages/tree/main). A monorepo isn’t just about the convenience of having all the source code “close together”, but can also be a critical tool to ensure that the individual packages & apps in the repo are mutually compatible.

“monorepo”是把一组相关 package 和应用的源码组织在单一仓库中的常见方式，例如 Flutter 的 [packages 仓库](https://github.com/flutter/packages/tree/main)。monorepo 不只是让所有源码“靠在一起”的便利，也是确保仓库中各 package 和应用相互兼容的关键工具。

We’ve heard consistent feedback from developers that work in large monorepos, that the performance of our tools, and specifically the analyzer, can be lacking. Our analysis of these issues suggests that the root issue is that we end up loading multiple overlapping analysis contexts for each package and ALL of its dependencies, leading to several copies of the analysis of each package in the monorepo in memory at the same time. We believe the fundamental solution is to create a single, shared resolution of the versions of each dependency in such repos, and are working on such a capability via a new pub feature called [workspaces](https://github.com/dart-lang/sdk/issues/53875). We’ll have much more to share about this in our next Dart release, but for now you can go ahead and see how this was [recently applied](https://github.com/flutter/engine/pull/54157/files) to the Flutter engine repo.

我们持续收到在大型 monorepo 中工作的开发者的反馈：我们的工具、尤其是分析器的性能可能不足。我们对这些问题的分析表明，根源在于我们为每个 package 及其*所有*依赖加载了多个重叠的分析上下文，导致 monorepo 中每个 package 的分析在内存中同时存在多份副本。我们认为根本解决方案是在这类仓库中对每个依赖的版本建立单一、共享的解析，并正在通过名为 [workspaces](https://github.com/dart-lang/sdk/issues/53875) 的新 pub 特性开发这种能力。下个 Dart 版本会有更多分享，现在你可以先看看它[最近如何应用](https://github.com/flutter/engine/pull/54157/files)到 Flutter engine 仓库。

## Pub.dev package repository

## Pub.dev package 仓库

Users of the pub.dev package repository have long requested improved metrics for [how used/downloaded](https://github.com/dart-lang/pub-dev/issues/2714) each package is. This can be helpful both for package authors as a signal of how many users are deriving benefit from their work, and for package consumers as a signal of what packages other developers are consuming. We’re happy to share that we’re making good progress on this capability, and hope to have it in preview by end of year.

pub.dev package 仓库的用户长期要求改进[每个 package 使用/下载量](https://github.com/dart-lang/pub-dev/issues/2714)的指标。这对 package 作者是有多少用户从其工作中受益的信号，对 package 使用者是其他开发者在用什么 package 的信号。我们很高兴分享这项能力进展良好，希望年底前提供预览。

## Dart native interop

## Dart 原生互操作

For the Java and Kotlin interop with JNIgen, we expect to wrap up the core support and graduate from experimental to a stable version 1.0 over the next two quarters. For details, see the [JNIgen tracker](https://github.com/orgs/dart-lang/projects/69/). For ObjectiveC interop, we have a similar goal; see the [Objective-C tracker](https://github.com/orgs/dart-lang/projects/87).

对于用 JNIgen 的 Java 和 Kotlin 互操作，我们预计在未来两个季度完成核心支持，从实验阶段进入稳定版 1.0。详情见 [JNIgen 跟踪器](https://github.com/orgs/dart-lang/projects/69/)。Objective-C 互操作有类似目标；见 [Objective-C 跟踪器](https://github.com/orgs/dart-lang/projects/87)。

Next up we’re investigating direct interop with Swift code. The initial experimentation looks promising, and we hope to have experimental support added early next year.

接下来我们正在研究与 Swift 代码的直接互操作。初步实验看起来很有希望，希望明年初加入实验性支持。

## Native interop and bundling of native source code

## 原生互操作与原生源码打包

In many cases direct interop is used to call into APIs that are present in the operating system, which means the APIs are always available on those host platforms. However, in some cases the code that Dart is interoperating with is native *source code* not included directly on the host, which presents a practical challenge for package authors who use such interop: How do you get that native source code bundled and built without having to push a bunch of manual steps onto the consumers of the package? To support this, we’re exploring a [native assets system](https://github.com/dart-lang/sdk/issues/50565), which could support publishing Dart packages that contain native source code, along with a standardized protocol for enabling the `dart` and `flutter` CLI tools to automate the building and bundling of that source code. We envision that this will enable a new set of interoperability use cases, while at the same time offering an uncomplicated user experience for developers who use packages that rely on native source code.

很多情况下，直接互操作用于调用操作系统中存在的 API，这意味着这些 API 在宿主平台上总是可用。但有些情况下，Dart 互操作的对象是宿主上没有直接包含的原生*源码*，这给使用这类互操作的 package 作者带来实际挑战：如何打包并构建这些原生源码，而不把一堆手动步骤推给 package 的使用者？为支持这一点，我们正在探索 [native assets 系统](https://github.com/dart-lang/sdk/issues/50565)，它可以支持发布包含原生源码的 Dart package，并提供标准化协议，让 `dart` 和 `flutter` CLI 工具自动构建和打包这些源码。我们设想这将带来一批新的互操作用例，同时为使用依赖原生源码的 package 的开发者提供简单的用户体验。

## Dart language & macros

## Dart 语言与宏

Most of our time in the Dart language and compiler teams is currently spent on making progress on the very large language feature macros, which we introduced in the [Dart 3.4 blog post](/blog/announcing-dart-3-4). As we said at the time, this is a huge undertaking, with the potential to cause regressions in some of our core use cases such as hot reload, so we’re taking a thorough approach, and will likely need several quarters of further work before we can share details of the next step.

Dart 语言和编译器团队目前的大部分时间都花在推进宏这个非常大的语言特性上，我们在 [Dart 3.4 博客](/blog/announcing-dart-3-4)中介绍过它。正如当时所说，这是一项巨大工程，有可能让热重载等核心用例出现倒退，因此我们采取审慎的方法，很可能还需要几个季度的工作才能分享下一步的细节。

In addition to macros, we’re also concurrently exploring a number of other smaller language features, as documented in the [Dart language funnel](https://github.com/orgs/dart-lang/projects/90/views/1).

除宏之外，我们也在同时探索其他一些较小的语言特性，详见 [Dart 语言漏斗](https://github.com/orgs/dart-lang/projects/90/views/1)。

Since last fall, we have been rewriting the Dart formatter. The old design worked well for many years, but with the success of Flutter, we want to move to [a new style](https://github.com/dart-lang/dart_style/issues/1253) that better works for the kind of declarative code that Flutter users often write. The old formatter wasn’t able to produce that kind of output. The rewrite is close to being done and will ship soon. If you’d like to try it out, pass the experiment flag `tall-style` ([flag instructions](https://dart.dev/tools/experiment-flags)). We welcome [feedback](https://github.com/dart-lang/dart_style/issues) if you see weird output.

从去年秋天起，我们一直在重写 Dart 格式化器。旧设计多年来运行良好，但随着 Flutter 的成功，我们想转向[新风格](https://github.com/dart-lang/dart_style/issues/1253)，更适合 Flutter 用户常写的声明式代码。旧格式化器无法产出那种输出。重写已接近完成，很快就会发布。想试用的话，传入实验标志 `tall-style`（[标志说明](https://dart.dev/tools/experiment-flags)）。如果看到奇怪的输出，欢迎[反馈](https://github.com/dart-lang/dart_style/issues)。

## Closing

## 结语

That’s all we have for today. We welcome your feedback, both on the roadmap items discussed, and on the new features in Dart 3.5, available from [Dart.dev](https://dart.dev/get-dart) or bundled in today’s [Flutter 3.24 release]({{site.flutter-blog}}/whats-new-in-flutter-3-24).

今天就到这里。欢迎对讨论的路线图项目和 Dart 3.5 的新特性提供反馈。Dart 3.5 可从 [Dart.dev](https://dart.dev/get-dart) 获取，或包含在今天发布的 [Flutter 3.24]({{site.flutter-blog}}/whats-new-in-flutter-3-24) 中。
