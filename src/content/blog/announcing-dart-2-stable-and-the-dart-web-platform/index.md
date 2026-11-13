---
# title: "Announcing Dart 2 Stable and the Dart Web Platform"
title: "宣布 Dart 2 稳定版与 Dart Web 平台"
# description: "Signals the rebirth of Dart as a mainstream programming language for mobile and web development"
description: "标志着 Dart 作为面向移动和 Web 开发的主流编程语言的重生"
ai-translated: true
publishDate: 2018-08-07
author: kevmoo
image: images/0YX3CcH4He_IIEhzx.webp
category: releases
layout: blog
---


Today, we’re announcing the immediate availability of the stable release of Dart 2, including a rewrite of the Dart web platform that offers a unique combination of productivity, performance and scalability.

今天我们宣布 Dart 2 稳定版即刻可用，其中包括重写的 Dart Web 平台，提供生产力、性能和可扩展性的独特组合。

<DashImage src="images/1xV5sN0ycM2OxY5BbGDhdmg.webp" alt="The Dart logo." />


Flutter developers are already enjoying many of the benefits of Dart 2, since Flutter has been bundling prerelease versions of the Dart 2 SDK for several months. However, the stable release of Dart 2 is another important milestone towards the stable release of Flutter, due to the tight coupling between framework and language. If you haven’t already installed Flutter, [start here](https://flutter.io/get-started/install/).

Flutter 开发者已经在享受 Dart 2 的诸多好处，因为 Flutter 几个月来一直捆绑 Dart 2 SDK 的预发布版本。不过，由于框架和语言紧密耦合，Dart 2 稳定版的发布是 Flutter 稳定版道路上的又一个重要里程碑。如果你还没安装 Flutter，[从这里开始](https://flutter.io/get-started/install/)。

With the release of Dart 2, web developers can now leverage the same language, libraries and tools along with a number of web-specific enhancements. Web developers should start at the [Get Started](https://webdev.dartlang.org/guides/get-started) page for instructions on installing tools and building a first application.

随着 Dart 2 的发布，Web 开发者现在可以使用同样的语言、库和工具，外加一系列 Web 专属增强。Web 开发者应从 [Get Started](https://webdev.dartlang.org/guides/get-started) 页面开始，了解安装工具和构建第一个应用的说明。

## Dart: Growing Excitement

## Dart：日益高涨的热情

Dart 2 marks the rebirth of Dart as a mainstream programming language focused on enabling a fast development and great user experiences for mobile and web applications. We want to enable developers building client applications to be productive, with a language, framework and components that reduce boilerplate and let them concentrate on the business logic, along with tooling that identifies errors early, enables powerful debugging and delivers small, fast runtime code.

Dart 2 标志着 Dart 作为主流编程语言的重生，专注于为移动和 Web 应用带来快速开发和出色用户体验。我们希望让构建客户端应用的开发者高效工作：语言、框架和组件减少样板代码，让他们专注于业务逻辑；工具尽早发现错误、支持强大调试，并产出小巧、快速的运行时码。

Over the last year, Dart has seen dramatic growth. Our own analytics suggest a ten-fold growth in external usage. In the last quarter, Dart was [one of the fastest growing languages on GitHub](https://madnight.github.io/githut/#/pull_requests/2018/2), as measured by pull requests; the growth of [StackOverflow questions](http://sotagtrends.com/?tags=[dart,perl,haskell,rust]&relative=false) also provides a vivid demonstration of Dart’s momentum:

过去一年，Dart 经历了显著增长。我们自己的分析显示外部使用量增长了十倍。上个季度，按 pull request 数量衡量，Dart 是 [GitHub 上增长最快的语言之一](https://madnight.github.io/githut/#/pull_requests/2018/2)；[StackOverflow 问题](http://sotagtrends.com/?tags=[dart,perl,haskell,rust]&relative=false)的增长也生动展示了 Dart 的势头：

<DashImage src="images/0s3bqLPad7xh_nFH-.webp" alt="Graph of Dart-related Stack Overflow questions over time." />


Internally, Dart is one of a handful of languages Google uses for web application development, with millions of lines of code from dozens of different projects including Google Ads, Google Shopping and our own internal infrastructure teams.

在内部，Dart 是 Google 用于 Web 应用开发的少数几种语言之一，来自 Google Ads、Google Shopping 和我们内部基础设施团队等数十个不同项目的代码达数百万行。

In fact, you might already be using Dart without realizing it: the popular [Sass stylesheet preprocessor](https://sass-lang.com/) was recently [rewritten in Dart](http://sass.logdown.com/posts/7045860-dart-sass-100-is-released) to make it faster, more portable, and easier to write. Sass is now distributed as a standalone executable on Homebrew and Chocolatey, and compiled to pure JavaScript on npm. Dart makes it easy to install applications anywhere without external dependencies, and to slot into the workflows of both people who use Dart and people who don’t.

事实上，你可能已经在不知不觉中使用 Dart 了：流行的 [Sass 样式表预处理器](https://sass-lang.com/)最近[用 Dart 重写](http://sass.logdown.com/posts/7045860-dart-sass-100-is-released)，变得更快、更可移植、更易于编写。Sass 现在在 Homebrew 和 Chocolatey 上以独立可执行文件分发，在 npm 上则编译为纯 JavaScript。Dart 让应用无需外部依赖就能安装到任何地方，并无缝融入使用 Dart 和不使用 Dart 的人的工作流。

<DashImage src="images/0YX3CcH4He_IIEhzx.webp" alt="Dart highlights a client-optimized language, rich frameworks, and flexible tooling for building native experiences across screens." />


Dart 2 is focused on three areas: strengthening and tightening the language, developing our support for web and mobile frameworks, and bringing some of the tooling and components that support Google’s usage of Dart to the outside world. The rest of this post will explore these themes.

Dart 2 聚焦三个方向：强化并收紧语言、发展对 Web 和移动框架的支持，以及把支撑 Google 内部 Dart 使用的部分工具和组件带给外部世界。本文余下部分将探讨这些主题。

## Dart 2: A Client-Optimized Language

## Dart 2：为客户端优化的语言

As we [highlighted in February](/blog/announcing-dart-2-optimized-for-client-side-development), the [Dart type system](https://www.dartlang.org/guides/language/sound-dart) is *sound*. This means that a large class of issues is found before your users run your application — during analysis and compilation. As we scaled Dart to extremely large apps within Google, the type system caught more errors early in the development cycle, leading to higher quality production code.

正如我们[二月份强调的](/blog/announcing-dart-2-optimized-for-client-side-development)，[Dart 类型系统](https://www.dartlang.org/guides/language/sound-dart)是*健全的*。这意味着一大类问题会在用户运行应用之前——在分析和编译期间——就被发现。当我们把 Dart 扩展到 Google 内部超大型应用时，类型系统在开发周期早期捕获了更多错误，带来了更高质量的生产代码。

With Dart 2, you can’t get into a state where an expression evaluates to a value that doesn’t match the expression’s static type. This means that you can scale your codebase to millions of lines, tackle large refactoring projects, and deploy your code with confidence.

在 Dart 2 中，不可能出现表达式求值结果与其静态类型不匹配的状态。这意味着你可以把代码库扩展到数百万行、开展大型重构项目，并充满信心地部署代码。

Don’t worry: soundness doesn’t mean mountains of boilerplate. The type system includes advanced inference — even for generic type arguments.

别担心：健全性并不意味着堆积如山的样板代码。类型系统包含先进的推断——甚至对泛型类型实参也是如此。

```
final _field = [3.14, 6.28];

void main() {
  // No type parameter is provided, but <int> is inferred
  print([1, 2, 3].runtimeType); // List<int>

  // If types are unmatched, their common base type is used
  // int (1) and double (3.14) are both `num`
  print([1, 3.14].runtimeType); // List<num>

  // Inference goes beyond variables.
  // You can omit types on fields, too.
  print(_field.runtimeType); // List<double>
}
```


To learn more about the Dart 2 type system, check out [this page](https://www.dartlang.org/guides/language/sound-dart).

要进一步了解 Dart 2 类型系统，请查看[这个页面](https://www.dartlang.org/guides/language/sound-dart)。

As mentioned in previous blog posts, Dart 2 also reduces the language ceremony in a few key areas: for example, the `new` keyword is now optional, and the `const` keyword is optional within a constant context.

正如之前的博客所述，Dart 2 还在几个关键方面减少了语言仪式：例如 `new` 关键字现在是可选的，常量上下文中的 `const` 关键字也是可选的。

Lastly, we’ve done lots of work behind the scenes to unify various supporting tools, with a common front-end that now supports our compilers and runtimes. This ensures consistency for our users now and promises to improve the velocity and quality of new features as Dart continues to evolve.

最后，我们在幕后做了大量工作来统一各种配套工具，用一个公共前端支撑我们的编译器和运行时。这既为用户保证了当下的一致性，也有望随着 Dart 的持续演进提升新特性的开发速度和质量。

## Dart on the Web: A Rich, Powerful Framework

## Web 上的 Dart：丰富而强大的框架

Web applications have been central to Dart’s mission from the start. In fact, most Dart development at Google is for web applications. One of the biggest is Google Ads, which powers billions of dollars of the web economy. In the process of migrating their code to Dart, they reduced the size of their UI codebase by 40% while improving developer productivity and application quality.

Web 应用从一开始就是 Dart 使命的核心。事实上，Google 内部大多数 Dart 开发都是 Web 应用。最大的一个是 Google Ads，它支撑着数十亿美元的 Web 经济。在把代码迁移到 Dart 的过程中，他们把 UI 代码库规模缩减了 40%，同时提升了开发者生产力和应用质量。

While the core Dart SDK provides libraries to access modern browser APIs, we also support a robust Angular-inspired framework for building complex web applications. [AngularDart 5](https://webdev.dartlang.org/angular), shipped as part of Dart 2, takes advantage of Dart’s sound type system and the [new build system](https://github.com/dart-lang/build) (described below) to offer fast incremental builds during development and smaller compiled JavaScript when you’re ready to deploy.

Dart 核心 SDK 提供了访问现代浏览器 API 的库，我们还支持一个受 Angular 启发、用于构建复杂 Web 应用的健壮框架。作为 Dart 2 一部分发布的 [AngularDart 5](https://webdev.dartlang.org/angular) 利用 Dart 的健全类型系统和[新构建系统](https://github.com/dart-lang/build)（下文详述），在开发期间提供快速增量构建，在部署时产出更小的编译 JavaScript。

One major area of focus for this release has been improving the amount of code that is processed on page load, significantly reducing the ‘time to interactivity’ for web pages. Many apps have seen code size reduced by more than half compared to AngularDart 4.

这个版本的一个重点是减少页面加载时需要处理的代码量，显著缩短网页的“可交互时间”。与 AngularDart 4 相比，许多应用的代码体积缩减了一半以上。

To showcase the improvements in Dart’s web platform, we built out a [Dart-based client implementation for the HackerNews site](https://hnpwa.dartlang.org/) as a Progressive Web App; this is published along with other sample implementations at the popular [HNPWA site](https://hnpwa.com/). Using best practices for building Dart web apps, we were able to ship a full-featured experience that is fully interactive in one second on modern devices and under five seconds on a modest mobile device on a slow 3G network. This is competitive even with lightweight web frameworks that are optimized for smaller apps.

为了展示 Dart Web 平台的改进，我们用 Dart 实现了 [HackerNews 站点的客户端](https://hnpwa.dartlang.org/)，做成渐进式 Web 应用；它与其他示例实现一起发布在热门的 [HNPWA 站点](https://hnpwa.com/)上。运用构建 Dart Web 应用的最佳实践，我们交付了功能完整的体验：在现代设备上 1 秒内完全可交互，在慢速 3G 网络下的普通移动设备上也不到 5 秒。即使与针对小型应用优化的轻量级 Web 框架相比，这也有竞争力。

<DashImage src="images/1Zf8U7ODhydytCsOn6_pQcw.webp" alt="Hacker News clone built with Dart." caption="[hnpwa.dartlang.org](https://hnpwa.dartlang.org/)" />


Our framework investments extend to our [core components](https://pub.dartlang.org/packages/angular_components), which we’ve also updated. You now have access to 100 new classes, including a number of date, time, and menu [Material components](https://material.io/). You can explore all of our components in the [component gallery](https://dart-lang.github.io/angular_components_example/).

我们的框架投入还延伸到[核心组件](https://pub.dartlang.org/packages/angular_components)，它们也得到了更新。你现在可以使用 100 个新类，包括多个日期、时间和菜单 [Material 组件](https://material.io/)。你可以在[组件库](https://dart-lang.github.io/angular_components_example/)中浏览所有组件。

<DashImage src="images/0drInYm1m0XD2vGZS.webp" alt="Animation demonstrating the Material Date Picker component." caption="*Material Date Picker — one of the rich components available for your web application*" />


## Flexible Tooling for Dart 2

## Dart 2 的灵活工具链

With Dart 2, Dart becomes a first-class compiled-to-JavaScript language, with a dev cycle that web developers expect and excellent runtime performance characteristics. This is done while providing benefits most JS-targeted languages don’t provide: a sound type system and excellent support for native mobile apps.

有了 Dart 2，Dart 成为一流的编译到 JavaScript 的语言，具备 Web 开发者期望的开发周期和出色的运行时性能。同时还提供了大多数以 JS 为目标的语言所没有的优势：健全的类型系统和对原生移动应用的出色支持。

With Dart 2, our web tools embrace a 100% JavaScript development model with two complementary JavaScript compilers. The development compiler, [dartdevc](https://webdev.dartlang.org/tools/dartdevc), provides fast incremental compilation while generating JavaScript that is easy to read and debug. This allows our production compiler, [dart2js](https://webdev.dartlang.org/tools/dart2js), to focus on producing highly optimized JavaScript for progressive web apps for mobile and complex enterprise experiences for the desktop. Both compilers leverage Dart’s sound type system to optimize their output.

在 Dart 2 中，我们的 Web 工具拥抱 100% JavaScript 开发模型，配备两个互补的 JavaScript 编译器。开发编译器 [dartdevc](https://webdev.dartlang.org/tools/dartdevc) 提供快速增量编译，生成易读易调试的 JavaScript。这让我们的生产编译器 [dart2js](https://webdev.dartlang.org/tools/dart2js) 专注于为移动端渐进式 Web 应用和桌面端复杂企业应用产出高度优化的 JavaScript。两个编译器都利用 Dart 的健全类型系统来优化输出。

Our web tools are based on a [new build system](https://github.com/dart-lang/build), designed to be fast, debuggable, and extensible. Now tasks like generating serialization code, compiling Sass to CSS and compiling Dart to JavaScript happen in one toolchain that supports fast, incremental updates as you change parts of your application. The build system is also designed to support uses beyond the web. An example: it’s being used by Flutter developers, to generate [JSON serialization code](https://flutter.io/json/#serializing-json-using-code-generation-libraries).

我们的 Web 工具基于[新构建系统](https://github.com/dart-lang/build)，设计目标是快速、可调试、可扩展。现在，生成序列化代码、把 Sass 编译成 CSS、把 Dart 编译成 JavaScript 等任务都在同一条工具链中完成，修改应用的任何部分都能获得快速的增量更新。这个构建系统还支持 Web 之外的用途。例如：Flutter 开发者正用它生成 [JSON 序列化代码](https://flutter.io/json/#serializing-json-using-code-generation-libraries)。

With Dart 2, we also have an expanded set of developer tools. In addition to support for [Android Studio](https://developer.android.com/studio/) and the JetBrains suite of tools, including [IntelliJ IDEA](https://www.jetbrains.com/idea/) and [WebStorm](https://www.jetbrains.com/webstorm/), we also support [Visual Studio Code](https://code.visualstudio.com/) with the [Dart Code extension](https://dartcode.org/). And we also have a great scratchpad for experimenting: [DartPad](https://dartpad.dartlang.org/), which has been fully updated for Dart 2.

Dart 2 还带来了更丰富的开发者工具。除了支持 [Android Studio](https://developer.android.com/studio/) 和 JetBrains 系列工具（包括 [IntelliJ IDEA](https://www.jetbrains.com/idea/) 和 [WebStorm](https://www.jetbrains.com/webstorm/)），我们还通过 [Dart Code 扩展](https://dartcode.org/)支持 [Visual Studio Code](https://code.visualstudio.com/)。我们还有一个很棒的实验草稿板：[DartPad](https://dartpad.dartlang.org/)，它已为 Dart 2 全面更新。

Finally, the Dart SDK comes with a suite of other useful tools: a package manager that works with our [package site](https://pub.dartlang.org/), a [static analyzer](https://www.dartlang.org/tools/analyzer), a linter that you can consume from the command line or as a package, and tooling for [web documentation](https://pub.dartlang.org/packages/dartdoc) and [code formatting](https://pub.dartlang.org/packages/dart_style) that conforms with the [Dart style guide](https://www.dartlang.org/guides/language/effective-dart/style).

最后，Dart SDK 还附带一套其他实用工具：与我们的 [package 站点](https://pub.dartlang.org/)配合的包管理器、[静态分析器](https://www.dartlang.org/tools/analyzer)、可从命令行或作为 package 使用的 linter，以及符合 [Dart 风格指南](https://www.dartlang.org/guides/language/effective-dart/style)的 [Web 文档](https://pub.dartlang.org/packages/dartdoc)和[代码格式化](https://pub.dartlang.org/packages/dart_style)工具。

## Learn more

## 了解更多

Check out the instructions for getting started with [Flutter](https://flutter.io/get-started/install/) and the [Dart web toolset](https://webdev.dartlang.org/guides/get-started).

查看 [Flutter](https://flutter.io/get-started/install/) 和 [Dart Web 工具集](https://webdev.dartlang.org/guides/get-started)的入门说明。

The [release](https://groups.google.com/a/dartlang.org/forum/#!topic/announce/IUWWXwL7QB4) notes provide a detailed technical breakdown of the numerous other smaller improvements made since Dart 1, some of which are breaking changes for older Dart code. If you run into problems that a Google search can’t solve, we recommend starting at [StackOverflow](https://stackoverflow.com/questions/tagged/dart). Subscribe to the [Dart Announcements](https://groups.google.com/a/dartlang.org/forum/#!forum/announce) mailing list and [follow us on Twitter](https://twitter.com/dart_lang) to get updates. We’d also love to see you in our communities, for example the [Gitter](https://gitter.im/dart-lang/home) chat room and [r/dartlang subreddit](https://www.reddit.com/r/dartlang/).

[发布说明](https://groups.google.com/a/dartlang.org/forum/#!topic/announce/IUWWXwL7QB4)详细拆解了自 Dart 1 以来的众多较小改进，其中一些对旧 Dart 代码是破坏性变更。如果遇到 Google 搜索解决不了的问题，我们建议先去 [StackOverflow](https://stackoverflow.com/questions/tagged/dart)。订阅 [Dart Announcements](https://groups.google.com/a/dartlang.org/forum/#!forum/announce) 邮件列表并[在 Twitter 上关注我们](https://twitter.com/dart_lang)以获取更新。我们也希望在社区里见到你，例如 [Gitter](https://gitter.im/dart-lang/home) 聊天室和 [r/dartlang subreddit](https://www.reddit.com/r/dartlang/)。

## Thank you

## 致谢

Dart has become a general purpose language that is optimized for web and mobile development. We’ve been working on Dart 2 for several years, during which time it has touched every aspect of our ecosystem and required migrating millions of lines of code and hundreds of packages.

Dart 已成为一门为 Web 和移动开发优化的通用语言。我们为 Dart 2 工作了好几年，期间它触及了生态的方方面面，需要迁移数百万行代码和数百个 package。

We are grateful to the [Dart](https://www.dartlang.org/) and [Flutter](https://flutter.io/) communities and well as the hundreds of Google engineers who have helped us on this journey. We couldn’t have done it without you!

我们感谢 [Dart](https://www.dartlang.org/) 和 [Flutter](https://flutter.io/) 社区，以及在这段旅程中帮助我们的数百位 Google 工程师。没有你们，我们不可能做到！
