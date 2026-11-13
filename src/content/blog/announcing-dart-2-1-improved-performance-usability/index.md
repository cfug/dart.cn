---
# title: "Announcing Dart 2.1: Improved performance & usability"
title: "宣布 Dart 2.1：性能与易用性改进"
# description: "Today, we’re announcing the stable release of Dart 2.1, an update to Dart 2 that new language features and performance improvements"
description: "今天，我们宣布 Dart 2.1 稳定版发布，这是 Dart 2 的一次更新，带来新语言特性和性能改进"
ai-translated: true
publishDate: 2018-11-15
author: mit-mit
image: images/1xZHP-8eEl6qJCCTKXyQZ8w.webp
category: releases
layout: blog
---


Today, we’re announcing the stable release of Dart 2.1, an update to Dart 2 that offers smaller code size, faster type checks, better usability for type errors, and new language features to improve productivity when building user experiences.

今天，我们宣布 Dart 2.1 稳定版正式发布。这是 Dart 2 的一次更新，
带来更小的代码体积、更快的类型检查、更友好的类型错误提示，
以及提升构建用户体验时生产力的新语言特性。

<DashImage src="images/1xZHP-8eEl6qJCCTKXyQZ8w.webp" alt="Dart 2.1 release banner listing faster tools, smaller output, compile-time type checking, int-to-double inference, and new mixin syntax." />


## Landing Dart 2

## Dart 2 落地

Dart 2 was a huge upgrade to the Dart platform. It completed the transformation from our early web roots to a mainstream programming language suitable for fast development of rich user experiences across mobile and web. Dart is somewhat unique as a language in offering both a virtual machine (VM) and compilation to both native machine code and JavaScript. This supports the differing needs of the various platforms, for both development and production.

Dart 2 是 Dart 平台的一次巨大升级。它完成了从早期 Web 根基
到主流编程语言的蜕变，适合在移动端和 Web 上快速开发丰富的用户体验。
Dart 作为一门语言有些独特：它既提供虚拟机（VM），
又能编译为原生机器码和 JavaScript。
这满足了各个平台在开发和生产环境中的不同需求。

As part of the transition to Dart 2, we added a [sound type system](https://www.dartlang.org/guides/language/sound-dart) to support large teams building complex apps, new compiler support for generating native code optimized for mobile devices, and completely reworked [web platform tools](https://webdev.dartlang.org/tools). Dart powers [Flutter](https://flutter.io), our fast-growing toolkit for building beautiful native experiences for iOS and Android from a single code base; it is also the language used by some of the largest projects at Google, such as Google Ads.

作为向 Dart 2 过渡的一部分，我们添加了
[健全类型系统](https://www.dartlang.org/guides/language/sound-dart)
来支持大型团队构建复杂应用，新增了生成针对移动设备优化的原生代码的
编译器支持，并彻底重构了 [Web 平台工具](https://webdev.dartlang.org/tools)。
Dart 驱动着 [Flutter](https://flutter.io)——我们快速成长的工具包，
用于从单一代码库为 iOS 和 Android 构建精美的原生体验；
它也是 Google 一些最大项目（如 Google Ads）所使用的语言。

Since the [launch of Dart 2](/blog/announcing-dart-2-stable-and-the-dart-web-platform) back in August, we’ve worked on getting the whole ecosystem onto Dart 2. We switched our [dartlang.org](https://www.dartlang.org/) website over to use Dart 2 examples everywhere, and we offered [tools and documentation for migrating](/blog/getting-ready-for-dart-2-and-making-your-packages-look-great-on-the-pub-site) Dart 1.x packages. We understand that the large changes in Dart 2 involved migration work for existing Dart developers, and we’re very thankful to those who have helped us build a new foundation for the future. Our focus now shifts to taking advantage of these investments to deliver improvements to performance and productivity.

自 8 月 [Dart 2 发布](/blog/announcing-dart-2-stable-and-the-dart-web-platform)
以来，我们一直努力让整个生态迁移到 Dart 2。我们把
[dartlang.org](https://www.dartlang.org/) 网站上的示例全部换成了 Dart 2，
并提供了[迁移 Dart 1.x package 的工具和文档](/blog/getting-ready-for-dart-2-and-making-your-packages-look-great-on-the-pub-site)。
我们明白 Dart 2 的巨大变化意味着现有 Dart 开发者需要做迁移工作，
非常感谢那些帮助我们为未来打下新基础的人。
现在我们的重心转向利用这些投入，带来性能和生产力上的改进。

## Dart 2.1 language support for int-to-double conversion

## Dart 2.1 对 int 到 double 转换的语言支持

New Flutter developers are often tripped up by analysis errors like these when specifying padding, setting font sizes, etc.:

Flutter 新手在指定 padding、设置字体大小等场景时，
常常被这样的分析错误绊住：

<DashImage src="images/19hItMsF9iM2BHzbuJkHNbg.webp" alt="Code showing integer values passed to EdgeInsets.symmetric, with analysis errors because the API expects doubles." />


From a system point of view, these errors make sense: The API expects one type (a double), and the developer specifies a value of a different type (an int). However, from a usability point of view it seems a bit foolish: There is a trivial conversion from int to double, so why not just do that? Dart 2.1 now [infers where an int can be silently evaluated as a double](https://github.com/dart-lang/language/issues/4):

从系统的角度看，这些错误是合理的：API 期望一种类型（double），
而开发者给出了另一种类型（int）的值。但从易用性的角度看，
这显得有点傻：int 到 double 的转换微不足道，为什么不直接做呢？
Dart 2.1 现在会[推断哪些 int 可以被静默地当作 double 求值](https://github.com/dart-lang/language/issues/4)：

<DashImage src="images/1bJV4DQzBey1fc64nerTprg.webp" alt="Code showing EdgeInsets.symmetric with integer values accepted for horizontal and vertical padding." />


## Dart 2.1 language support for mixins

## Dart 2.1 对 mixin 的语言支持

We also [improved Dart’s support for mixins](https://github.com/dart-lang/language/issues/7). If you haven’t encountered Dart mixins before, it’s worth reading this great [introduction to Dart mixins](https://medium.com/flutter-community/dart-what-are-mixins-3a72344011f3) by Romain Rastel. Dart 2.1 introduces a new syntax for mixins, featuring a new `mixin` keyword that you can use to define classes that can only be used as mixins. We’ve also added support so that mixins can extend other classes (previously they could only extend `Object`) and can invoke methods in their superclass.

我们还[改进了 Dart 对 mixin 的支持](https://github.com/dart-lang/language/issues/7)。
如果你以前没接触过 Dart mixin，值得一读 Romain Rastel 写的这篇精彩的
[Dart mixin 入门](https://medium.com/flutter-community/dart-what-are-mixins-3a72344011f3)。
Dart 2.1 为 mixin 引入了新语法，新增 `mixin` 关键字，
你可以用它定义只能作为 mixin 使用的类。我们还新增了支持，
让 mixin 可以继承其他类（此前只能继承 `Object`），
并能调用超类中的方法。

One example of extending non-Object classes is from Flutter’s [animation APIs](https://flutter.io/tutorials/animation/#rendering-animations), where the `SingleTickerProviderStateMixin` — a framework class that provides a ticker for advancing an animation by a single frame — [declares a mixin](https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/widgets/ticker_provider.dart#L66) that implements the general TickerProvider interface. Animations are only applicable to stateful widgets (as the position in the animation is considered state). The new mixin support allows us to express this by declaring that only classes that extend the Flutter State class can use the mixin:

继承非 Object 类的一个例子来自 Flutter 的
[动画 API](https://flutter.io/tutorials/animation/#rendering-animations)：
`SingleTickerProviderStateMixin`——一个提供 ticker、
让动画逐帧推进的框架类——[声明了一个 mixin](https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/widgets/ticker_provider.dart#L66)，
实现通用的 TickerProvider 接口。动画只适用于有状态 widget
（因为动画中的位置被视为状态）。新的 mixin 支持让我们可以这样表达：
声明只有继承 Flutter State 类的类才能使用该 mixin：

<DashImage src="images/0uUIuZJgNCevxAkZQ.webp" alt="Code declaring SingleTickerProviderStateMixin as a mixin on State that implements TickerProvider." />


## Dart 2.1 compile-time type checks

## Dart 2.1 的编译时类型检查

Dart 2’s sound type system protects you during development, telling you when you violate the contract specified by the types. For example, let’s say you’re creating a state class for Flutter. This class is expected to extend the framework `State` class. A `State` class expects to be passed the `StatefulWidget` that it contains the state for.

Dart 2 的健全类型系统在开发期间保护你，
在你违反类型所指定的契约时给出提示。例如，
假设你正在为 Flutter 创建一个 state 类。这个类应当继承框架的 `State` 类。
`State` 类期望传入它所承载状态的 `StatefulWidget`。

<DashImage src="images/1Y_8yHDINe7LtvmyFmCqWzw.webp" alt="Code snippet showing a Flutter state class extending the framework State class." />


Now, should you make a programming mistake and — say — pass it a descendant of `StatelessWidget` instead of `StatefulWidget`, the type information enables the tools to catch the mistake and show you a warning immediately:

现在，如果你犯了编程错误——比如说——传入了 `StatelessWidget`
而不是 `StatefulWidget` 的子类，类型信息能让工具立即捕获这个错误
并向你显示警告：

<DashImage src="images/1Ym0nqsHWlTscD140Urk0xw.webp" alt="IDE screenshot showing an error because MyHomePage doesn't extend StatefulWidget." />


These *edit-time* type checks were added in Dart 2.0 (powered by the [Dart Analyzer](https://www.dartlang.org/tools/analyzer)). However, there is another place where you might expect these type checks, namely at *compile time*, when you do a Flutter release build. These checks were incomplete in Dart 2.0, which could lead to usability issues where bad source code could compile without producing any errors. In Dart 2.1, these checks are complete, and the Analyzer and Dart compiler contain the same checks.

这些*编辑时*类型检查是在 Dart 2.0 中加入的
（由 [Dart Analyzer](https://www.dartlang.org/tools/analyzer) 提供支持）。
不过，还有一个你可能期望进行这些类型检查的地方，那就是*编译时*，
也就是做 Flutter release 构建的时候。这些检查在 Dart 2.0 中并不完整，
可能导致易用性问题：有问题的源代码也能编译通过而不报任何错误。
在 Dart 2.1 中，这些检查已经完整，
Analyzer 和 Dart 编译器包含相同的检查。

## Dart 2.1 performance improvements for Flutter developers

## Dart 2.1 为 Flutter 开发者带来的性能改进

Dart 2 was generally faster than Dart 1.x for [AOT-compiled code](https://hackernoon.com/why-flutter-uses-dart-dd635a054ebf) running on our VM, such as Flutter apps. In a few edge cases, though, the comprehensive checks added by the [new type system](https://www.dartlang.org/guides/language/sound-dart) caused an undesirable overhead of 20–40%. In Dart 2.1 we’ve greatly reduced the cost of the type checks, both for AOT-compiled code and for code run in the VM with JIT (just-in-time) compilation.

对于在我们 VM 上运行的
[AOT（提前编译）代码](https://hackernoon.com/why-flutter-uses-dart-dd635a054ebf)
（例如 Flutter 应用），Dart 2 总体上比 Dart 1.x 更快。
不过在少数边缘情况下，[新类型系统](https://www.dartlang.org/guides/language/sound-dart)
引入的全面检查造成了 20–40% 的不必要开销。在 Dart 2.1 中，
我们大幅降低了类型检查的成本，无论是 AOT 编译的代码，
还是在 VM 中以 JIT（即时编译）方式运行的代码。

One concrete case that benefits from this is our developer tools (which run using the VM). For example, performing code analysis of one large benchmark app (based on multiple concatenated copies of the Flutter Gallery) used to take ~41 seconds; now it takes ~25 seconds.

一个受益的具体例子是我们的开发者工具（它们运行在 VM 上）。
例如，对一个大型基准应用（基于多份拼接的 Flutter Gallery 副本）
进行代码分析，过去需要约 41 秒，现在只需约 25 秒。

## Dart 2.1 performance improvements for web developers

## Dart 2.1 为 Web 开发者带来的性能改进

We also improved the code size and compile time for Dart code running on the web. We focused on the output size of [dart2js](https://webdev.dartlang.org/tools/dart2js) and are seeing good results, such as a [17% reduction in minified output size and 15% improvement in compilation time](https://twitter.com/kevmoo/status/1055292888626515968) for one of our samples.

我们还改进了在 Web 上运行的 Dart 代码的体积和编译时间。
我们重点关注 [dart2js](https://webdev.dartlang.org/tools/dart2js)
的输出体积，并看到了不错的成果，例如我们的一个示例
[压缩后输出体积减少 17%，编译时间缩短 15%](https://twitter.com/kevmoo/status/1055292888626515968)。

## Changes beyond the core SDK

## 核心 SDK 之外的变化

In addition to the above-mentioned changes in the Dart SDK, we’ve made some exciting changes outside of the core SDK.

除了上述 Dart SDK 中的变化，
我们还在核心 SDK 之外做了一些令人兴奋的改动。

Protocol buffers (or *protobuf* for short) are a platform-neutral mechanism for serializing structured data. They’re used extensively inside of Google and are also seeing strong adoption outside of Google — for example as part of [gRPC](https://grpc.io/). Dart is now an officially supported protobuf language, and we have added detailed documentation on the [core protocol buffers website](https://developers.google.com/protocol-buffers/) with both a [tutorial](https://developers.google.com/protocol-buffers/docs/darttutorial) and [reference](https://developers.google.com/protocol-buffers/docs/reference/overview) documentation.

Protocol buffers（简称 *protobuf*）是一种平台中立的结构化数据
序列化机制。它在 Google 内部被广泛使用，在 Google 之外也获得了大量采用
——例如作为 [gRPC](https://grpc.io/) 的一部分。
Dart 现在是官方支持的 protobuf 语言，我们在
[protocol buffers 核心网站](https://developers.google.com/protocol-buffers/)
上添加了详细文档，包括[教程](https://developers.google.com/protocol-buffers/docs/darttutorial)
和[参考](https://developers.google.com/protocol-buffers/docs/reference/overview)文档。

You may have heard about [knative](https://cloud.google.com/knative/) — a platform based on [Kubernetes](https://kubernetes.io/) — to support building, deploying, and managing serverless workloads. We recently investigated support for serving Dart code on knative, and [created a small sample](https://github.com/knative/docs/tree/master/serving/samples/helloworld-dart). This is likely too low-level for most Dart app developers, but we find it very exciting from a platform perspective, and anticipate this will be a critical building block to get better support for serving Dart code in the Google Cloud — for example to create backends for Flutter apps.

你可能听说过 [knative](https://cloud.google.com/knative/)——一个基于
[Kubernetes](https://kubernetes.io/) 的平台，
用于支持构建、部署和管理 serverless 工作负载。
我们最近研究了在 knative 上运行 Dart 代码的支持，
并[创建了一个小示例](https://github.com/knative/docs/tree/master/serving/samples/helloworld-dart)。
对大多数 Dart 应用开发者来说，这可能过于底层，
但从平台的角度看我们觉得非常令人兴奋，
并预计这将成为在 Google Cloud 中更好地支持运行 Dart 代码的
关键构建块——例如为 Flutter 应用创建后端。

## Getting Dart 2.1

## 获取 Dart 2.1

[Dart SDK 2.1](https://www.dartlang.org/tools/sdk/archive) is available from the Dart homepage. If you’re a Flutter developer, Dart 2.1 is included as part of the upcoming Flutter 1.0 release.

[Dart SDK 2.1](https://www.dartlang.org/tools/sdk/archive)
可以从 Dart 主页获取。如果你是 Flutter 开发者，
Dart 2.1 已包含在即将发布的 Flutter 1.0 中。

We’ve also updated [DartPad](https://dartpad.dartlang.org/) to run Dart 2.1, and have added samples for [int-to-double](https://dartpad.dartlang.org/e93b969fed77325db0b848a85f1cf78e) and [mixins](https://dartpad.dartlang.org/b60dc2fc7ea49acecb1fd2b57bf9be57).

我们还更新了 [DartPad](https://dartpad.dartlang.org/) 以运行 Dart 2.1，
并添加了 [int 到 double](https://dartpad.dartlang.org/e93b969fed77325db0b848a85f1cf78e)
和 [mixin](https://dartpad.dartlang.org/b60dc2fc7ea49acecb1fd2b57bf9be57) 的示例。

## What’s next

## 下一步

We expect to ship several 2.x releases that take advantage of the Dart 2 platform foundation. We’ll base these on the needs of our framework partners and app developers. In 2019 we expect to investigate the following areas:

我们预计会发布多个 2.x 版本，充分利用 Dart 2 平台基础。
我们会根据框架合作伙伴和应用开发者的需求来安排这些版本。
2019 年我们计划研究以下领域：

* Continued evolution of the Dart language: For Dart 2.2, we’re investigating a number of changes, such as refinements to [const expressions](https://github.com/dart-lang/language/issues/61) and support for a new [Set literal](https://github.com/dart-lang/language/issues/37). Beyond 2.2 we’re looking into our support for Unicode strings, and are investigating whether we can offer better null safety.

  Dart 语言的持续演进：对于 Dart 2.2，我们正在研究多项改动，
  例如改进 [const 表达式](https://github.com/dart-lang/language/issues/61)、
  支持新的 [Set 字面量](https://github.com/dart-lang/language/issues/37)。
  2.2 之后我们会研究对 Unicode 字符串的支持，
  并探索能否提供更好的空安全（null safety）。

* Further improvements to optimize Dart as a language for creating user interfaces: Dart 2 began this journey with its new type system and optional new, Dart 2.1 added int to double value inference, and we are currently investigating a number of potential improvements such as support for [conditionals in widget lists](https://github.com/dart-lang/language/issues/78), [expanding collections of objects](https://github.com/dart-lang/language/issues/47) into other collections, and even potentially [removing the need to terminate statements](https://github.com/dart-lang/language/issues/72) with semicolons.

  进一步优化 Dart 作为构建用户界面的语言：Dart 2 凭借新类型系统
  和可选的 new 关键字开启了这段旅程，Dart 2.1 加入了 int 到 double
  的值推断，我们目前正在研究多项潜在改进，例如支持
  [widget 列表中的条件表达式](https://github.com/dart-lang/language/issues/78)、
  把[对象集合展开](https://github.com/dart-lang/language/issues/47)到其他集合中，
  甚至可能[去掉语句末尾的分号](https://github.com/dart-lang/language/issues/72)。

* Even better performance: We’ll continue to reduce the size and performance of compiled Dart code, including better support for using multi-core processors, further reduction of code size to improve download and startup time, and potentially more control for whether size or runtime performance is most critical.

  更出色的性能：我们会继续减小 Dart 编译代码的体积并提升其性能，
  包括更好地支持利用多核处理器、进一步缩小代码体积
  以改善下载和启动时间，以及可能提供更多控制，
  让你决定体积和运行时性能哪个最关键。

For more about both Dart and Flutter, we’d love you to join us at [Flutter Live](https://developers.google.com/events/flutter-live/), an online event taking place on December 4th that will be streamed live on the web. We’re excited to share more about the roadmap with you then.

想了解更多 Dart 和 Flutter 的内容，欢迎参加
[Flutter Live](https://developers.google.com/events/flutter-live/)——12 月 4 日举行、
在 Web 上直播的在线活动。我们很期待届时与你分享更多路线图内容。

That’s it for now. We hope you enjoy Dart 2.1!

这次就到这里。希望你喜欢 Dart 2.1！
