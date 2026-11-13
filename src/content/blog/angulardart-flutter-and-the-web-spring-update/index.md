---
# title: "AngularDart, Flutter, and the web: Spring update"
title: "AngularDart、Flutter 与 Web：春季更新"
# description: "Adjusting our investment for Dart’s open source web frameworks"
description: "调整我们对 Dart 开源 Web 框架的投入"
ai-translated: true
publishDate: 2021-05-12
author: timsneath
image: images/1TnLjhbuMnphc4ZlsuSdtog.webp
category: other
layout: blog
---


Two months ago, we delivered our [first stable release of web support]({{site.flutter-blog}}/flutter-web-support-hits-the-stable-milestone) for Flutter. This was a major milestone for client development as a whole, combining Flutter’s established UI framework, Dart’s industrial-strength JavaScript toolchain, and the underlying power of the web platform to deliver consistency across mobile devices and browsers.

两个月前，我们交付了 Flutter [Web 支持的首个稳定版本]({{site.flutter-blog}}/flutter-web-support-hits-the-stable-milestone)。这是整个客户端开发的重要里程碑，它把 Flutter 成熟的 UI 框架、Dart 工业级的 JavaScript 工具链和 Web 平台的底层能力结合起来，在移动设备和浏览器之间提供一致的体验。

Since that release, we’ve been excited to see developers start to use Flutter on the web. Even at this early stage, more than 10% of `flutter build` commands target the web, demonstrating that web apps are already being deployed using Flutter. Inside Google, a number of teams are starting to rely on Flutter’s web support. And we use it heavily ourselves for Flutter development, both for [DartPad](https://dartpad.dev/e0a2e942e85fde2cd39b2741ff0c49e5?null_safety=true) and for [DevTools](https://flutter.dev/docs/development/tools/devtools/overview), our suite of performance and debugging tools.

自那以后，我们很高兴看到开发者开始在 Web 上使用 Flutter。即使在这个早期阶段，已有超过 10% 的 `flutter build` 命令以 Web 为目标，说明已经有人在用 Flutter 部署 Web 应用。在 Google 内部，多个团队开始依赖 Flutter 的 Web 支持。我们自己在 Flutter 开发中也大量使用它，包括 [DartPad](https://dartpad.dev/e0a2e942e85fde2cd39b2741ff0c49e5?null_safety=true) 和我们的性能与调试工具套件 [DevTools](https://flutter.dev/docs/development/tools/devtools/overview)。

When we first started adding web support to Flutter a couple of years ago, we were hopeful that it would lead to good results, but it still felt like a moonshot. While much work remains, we’re confident that Flutter’s web support has the potential to fill an important niche with a high-quality solution. So, we’re adjusting our investments for Dart’s open source web tooling to focus on Flutter.

几年前我们刚开始为 Flutter 添加 Web 支持时，虽然期望它能带来好结果，但仍感觉像一次登月式的豪赌。尽管还有很多工作要做，我们相信 Flutter 的 Web 支持有潜力以高质量的方案填补一个重要空缺。因此，我们正在调整对 Dart 开源 Web 工具的投入，聚焦于 Flutter。

In changing our focus, we’re also scaling back our external work on AngularDart, a separate web framework that evolved out of the original Angular project. Six months ago, [we announced a roadmap for AngularDart](https://groups.google.com/a/dartlang.org/g/announce/c/Kz84KNBcf3U) that included publishing a long-term stable update ([AngularDart 6](https://pub.dev/packages/angular/changelog)) and supporting null safety, but prioritized AngularDart engineering work on major internal customers, including [Google Ads](https://ads.google.com/) and [Google Play Console](https://play.google.com/console). Although the AngularDart framework itself is relatively easy to open source, Google’s build and release systems are [uniquely specialized](https://sre.google/sre-book/release-engineering/#continuous-build-and-deployment-Yms8u8), resulting in significant divergence that makes it nontrivial to synchronize internal and external releases.

在调整重心的同时，我们也在缩减 AngularDart 的外部工作。AngularDart 是从最初的 Angular 项目演化而来的独立 Web 框架。六个月前，[我们公布了 AngularDart 的路线图](https://groups.google.com/a/dartlang.org/g/announce/c/Kz84KNBcf3U)，包括发布长期稳定更新（[AngularDart 6](https://pub.dev/packages/angular/changelog)）和支持空安全，但把 AngularDart 的工程工作优先服务于主要内部客户，包括 [Google Ads](https://ads.google.com/) 和 [Google Play Console](https://play.google.com/console)。虽然 AngularDart 框架本身相对容易开源，但 Google 的构建和发布系统[高度特化](https://sre.google/sre-book/release-engineering/#continuous-build-and-deployment-Yms8u8)，造成了显著分化，使内外部版本的同步并非易事。

Focusing on the majority of AngularDart users helps us make the most of our talented engineering resources, and we hope everyone benefits as a result. For projects like Ads and Play Console, we can more directly address their needs without worrying about external implications; for external users, we can put all our energy into giving you a high-quality Flutter product that works across web, desktop, mobile, and embedded scenarios.

聚焦于大多数 AngularDart 用户能让我们充分利用优秀的工程资源，我们希望所有人都能因此受益。对于 Ads 和 Play Console 这样的项目，我们可以更直接地满足它们的需求，而不必顾虑外部影响；对于外部用户，我们可以把全部精力投入到为你打造一个横跨 Web、桌面、移动和嵌入式场景的高质量 Flutter 产品上。
> # We can put all our energy into giving you a high-quality Flutter product that works across web, desktop, mobile, and embedded scenarios.

> # 我们可以把全部精力投入到为你打造一个横跨 Web、桌面、移动和嵌入式场景的高质量 Flutter 产品上。

Over the past few months, we’ve been talking with the largest external users of AngularDart to help them with their own roadmaps. For some, Flutter’s web support is a perfect choice; others are happy with the stability and maturity of AngularDart as it stands; yet others are using this opportunity to transition to [Angular](https://angular.io/), Google’s popular TypeScript-based web framework.

过去几个月，我们一直在与 AngularDart 最大的外部用户沟通，帮助他们制定各自的路线图。对一些用户来说，Flutter 的 Web 支持是完美选择；另一些用户对 AngularDart 现状的稳定性和成熟度很满意；还有一些用户则借此机会迁移到 [Angular](https://angular.io/)——Google 广受欢迎的基于 TypeScript 的 Web 框架。

Angular itself continues to grow quickly. In the last year, [weekly downloads have grown by over 60%](https://www.npmjs.com/package/@angular/core) and nearly [two million public GitHub repositories depend on it](https://github.com/angular/angular/network/dependents?package_id=UGFja2FnZS00NTE2NDYyMzQ%3D). Its syntax will be familiar to those who are using AngularDart today, and it’s a logical choice for developers looking for a modern web framework.

Angular 本身仍在快速增长。过去一年里，[周下载量增长了 60% 以上](https://www.npmjs.com/package/@angular/core)，近[两百万个公开 GitHub 仓库依赖它](https://github.com/angular/angular/network/dependents?package_id=UGFja2FnZS00NTE2NDYyMzQ%3D)。今天使用 AngularDart 的人会对它的语法感到熟悉，对于寻找现代 Web 框架的开发者来说，它是一个合乎逻辑的选择。

For developers who want to use Dart, we think Flutter’s web support will be an exciting choice. As an early example, [PropOps](https://propops.com/en/) — a tech startup in the real estate space—has had great success building a line-of-business app with Flutter, as the screenshots below demonstrate:

对于想使用 Dart 的开发者，我们认为 Flutter 的 Web 支持会是一个令人兴奋的选择。一个早期例子是 [PropOps](https://propops.com/en/)——一家房地产领域的科技初创公司——他们用 Flutter 构建业务应用取得了巨大成功，下面的截图就是证明：

<DashImage src="images/1TnLjhbuMnphc4ZlsuSdtog.webp" alt="Screenshots of PropOps, a cloud-based property management tool built with Flutter's web support." caption="PropOps: a cloud-based property management tool, built with Flutter’s web support." />


In the next few weeks, we’ll deliver a stable external release of AngularDart with null safety; at that point, it will shift into maintenance mode. If a committed consortium or community group wants to take over leadership of the project and continue to evolve it, we’re interested in hearing from them.

接下来几周，我们会发布支持空安全的 AngularDart 外部稳定版本；届时它将转入维护模式。如果有尽责的联盟或社区团体愿意接管项目的领导权并继续演进它，我们很乐意与他们交流。

We’re moving full steam ahead on Flutter’s web support as well as on Angular itself: stay tuned for more on that at next week’s [Google I/O event](https://events.google.com/io/)!

我们正在全速推进 Flutter 的 Web 支持以及 Angular 本身：请关注下周 [Google I/O 活动](https://events.google.com/io/)上的更多消息！
