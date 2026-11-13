---
# title: "Introducing a brand new pub.dev"
title: "全新的 pub.dev 登场"
# description: "Redesigned for high-quality, multiplatform packages"
description: "为高质量、多平台 package 重新设计"
ai-translated: true
publishDate: 2020-07-15
author: mit-mit
image: images/0efALL34OP6a4tcxh.webp
category: announcements
layout: blog
---


Today we’re launching a brand new [pub.dev](https://pub.dev) site. It features new scoring metrics to give you a better understanding of potentially useful packages, and to provide package publishers with more actionable feedback on how to improve package quality. To help you find packages that support all the platforms you’re interested in, we’ve added support for identifying and searching for multiplatform packages. And overall we’ve redesigned the UI, aiming for a delightful and elegant experience that’s consistent with our [dart.dev](https://dart.dev) and [dartpad.dev](https://dartpad.dev) sites.

今天我们上线了全新的 [pub.dev](https://pub.dev) 网站。它引入了新的评分指标，帮你更好地了解哪些 package 可能有用，也为 package 发布者提供更具可操作性的反馈，指导如何提升 package 质量。为了帮你找到支持你关心的所有平台的 package，我们新增了对多平台 package 的识别和搜索支持。整体上我们还重新设计了 UI，力求带来愉悦而优雅的体验，并与我们的 [dart.dev](https://dart.dev) 和 [dartpad.dev](https://dartpad.dev) 网站保持一致。

<DashImage src="images/0efALL34OP6a4tcxh.webp" alt="Newly redesigned pub.dev homepage." caption="The new pub.dev site" />


## Finding the best packages for your needs

## 找到最符合你需求的 package

With **nearly 7,000 new packages published over the past year, you have no shortage of options when looking for packages to extend the functionality of your apps. But with so many packages to choose from, naturally you want the most liked, highest quality, and most popular packages to bubble to the surface. To support better package search results, we’ve redesigned the scoring system in pub.dev around three dimensions:

**过去一年发布了近 7,000 个新 package**，在寻找扩展应用功能的 package 时，你从来不缺选择。但面对如此多的 package，你自然希望点赞最多、质量最高、最流行的 package 能浮到最前面。为了带来更好的 package 搜索结果，我们围绕三个维度重新设计了 pub.dev 的评分系统：

<DashImage src="images/0OmvIh_FRHtJDrSIk.webp" alt="Three scoring dimensions for a pub package: likes, pub points, and popularity." caption="*The three scoring dimensions for a pub package*" />


1. **Likes**: A measure of how many developers have liked a package. This provides a raw measure of the overall sentiment toward a package.

  **点赞（Likes）**：衡量有多少开发者为一个 package 点了赞。它提供了对 package 整体口碑的原始度量。

1. **Pub points**: A new measure of quality. This includes several dimensions of quality such as code style, platform support, and maintainability. More about this below.

  **Pub points**：一种新的质量度量。它涵盖代码风格、平台支持、可维护性等多个质量维度。下文会详细介绍。

1. **Popularity**: A measure of how many developers use a package. This reflects the number of apps that depend on the package over the past sixty days. The normalized scale ranges from 100% (the most used package) to 0% (the least used package), but we’re investigating whether we can provide absolute usage counts in a future version.

  **流行度（Popularity）**：衡量有多少开发者在使用一个 package。它反映过去六十天内依赖该 package 的应用数量。归一化后的取值范围从 100%（使用最多的 package）到 0%（使用最少的 package），不过我们正在研究能否在未来版本中提供绝对使用数量。

We hope that these new dimensions help both package consumers who are looking for packages to depend on, and package publishers working on shipping a high quality packages.

我们希望这些新维度既能帮助寻找依赖的 package 使用者，也能帮助致力于打造高质量 package 的发布者。

## Measuring quality with pub points

## 用 pub points 衡量质量

With likes and popularity providing community-sourced, subjective measures, the goal of pub points is to provide a close approximation of measurable, objective quality. This isn’t easy; developers perceive quality in a variety of ways, but we still believe that most developers look for core traits that we can measure. The previous pub.dev scoring model was based on subtracting points for issues. The new scoring model reverses this approach, instead awarding points based on traits in five categories:

点赞和流行度提供的是来自社区的主观度量，而 pub points 的目标是尽可能贴近可度量的客观质量。这并不容易：开发者对质量的理解各不相同，但我们仍然相信，大多数开发者看重的核心特质是可以度量的。之前的 pub.dev 评分模型基于对问题扣分。新的评分模型反转了这种做法，改为根据五个类别的特质加分：

<DashImage src="images/0RWVQoe0INHUfS_Ax.webp" alt="Overview of the pub points system showing categories, checks, and awarded points." caption="*Pub points overview with categories and checks, as well as points awarded*" />


1. *Follow Dart file conventions*: Follow best practices around pubspec, readme, and changelog files

  *遵循 Dart 文件规范*：遵循关于 pubspec、readme 和 changelog 文件的最佳实践

1. *Provide documentation*: Provide API documentation and an illustrative example

  *提供文档*：提供 API 文档和说明性示例

1. *Support multiple platforms*: Support as many Dart and Flutter platforms as possible

  *支持多平台*：支持尽可能多的 Dart 和 Flutter 平台

1. *Pass static analysis*: Provide code that is free from errors, warnings, and lints

  *通过静态分析*：提供没有错误、警告和 lint 问题的代码

1. *Support up-to-date dependencies*: Have dependency constraints that support the latest Dart & Flutter SDKs, and the latest package dependencies

  *支持最新依赖*：依赖约束支持最新的 Dart 与 Flutter SDK，以及最新的 package 依赖

We expect to add more checks and categories for pub points over time, raising the ceiling for how many points a package can have. For example, we plan to add a score for supporting [null safety](/blog/announcing-sound-null-safety) when that feature launches. And we’re investigating how to measure maintainability (issue and pull request responsiveness), testability (automated test coverage), and community friendliness (number of contributors, maintainers, etc.). If you have an idea for a great measure, we’d love to [hear from you](https://github.com/dart-lang/pub-dev/issues)!

我们预计会随时间为 pub points 增加更多检查项和类别，提高 package 可得积分的上限。例如，我们计划在[空安全](/blog/announcing-sound-null-safety)特性发布时，为支持它的 package 加分。我们还在研究如何度量可维护性（issue 和 pull request 的响应速度）、可测试性（自动化测试覆盖率）和社区友好度（贡献者、维护者数量等）。如果你有好的度量点子，我们非常期待[听到你的声音](https://github.com/dart-lang/pub-dev/issues)！

## Supporting multiplatform apps

## 支持多平台应用

Both Dart and Flutter excel at creating apps that target multiple platforms. On pub.dev we’ve provide clear platform tags for mobile (iOS and Android) and web platforms, as well as search filters for these platforms:

Dart 和 Flutter 都擅长构建面向多个平台的应用。在 pub.dev 上，我们为移动端（iOS 和 Android）及 Web 平台提供了清晰的平台标签，以及针对这些平台的搜索筛选器：

<DashImage src="images/0aTIl5H_AbGmOJBKO.webp" alt="Screenshot showing platform filters like Android, iOS, and web available in pub.dev search." caption="Platform filters in search" />


To make sure that your package is tagged with the correct platform support, follow the guidance on the pub.dev [scoring help page](https://pub.dev/help/scoring).

要确保你的 package 被打上正确的平台支持标签，请遵循 pub.dev [评分帮助页面](https://pub.dev/help/scoring)上的指引。

We’ll be adding similar support for desktop platforms (macOS, Windows, and Linux) when that advances to a more final state. For now you can find filters for those platforms inside the **Advanced** search options:

等桌面平台（macOS、Windows 和 Linux）的支持进入更成熟的阶段后，我们会添加类似的支持。目前你可以在 **Advanced** 搜索选项中找到这些平台的筛选器：

<DashImage src="images/0LpResE7zZv_5x3xB.webp" alt="Advanced pub.dev search options showing filters for desktop platforms." caption="*Desktop platforms in advanced filters*" />


## An elegant and delightful design

## 优雅而愉悦的设计

The Dart pub.dev team collaborated with Google Developer Studio, our internal creative team, with Jeremy Sie as the main designer. Alongside functional updates, the team took a considered look at the visual design, sharing their thoughts on the project. With an eye to providing a coherent, accessible, and user-focused experience, we made a range of refinements rooted in Google’s [Material Design system](https://material.io/design/). Our aim was to create a lightweight and streamlined interface, allowing for clear and concise workflows for both package publishers and consumers.

Dart pub.dev 团队与我们的内部创意团队 Google Developer Studio 合作，由 Jeremy Sie 担任主设计师。在功能更新之外，团队还认真审视了视觉设计，并分享了他们对这个项目的思考。为了提供连贯、无障碍、以用户为中心的体验，我们基于 Google 的 [Material Design 设计系统](https://material.io/design/)做了一系列打磨。我们的目标是打造轻量而流畅的界面，让 package 发布者和使用者都能拥有清晰简洁的工作流。

The updated design features [Material components](https://material.io/components) such as cards and chips that clearly display package details and allow greater transparency into how individual packages function. We updated the typographic system and improved the [type scale](https://material.io/design/typography/the-type-system.html#type-scale) across the site, bringing greater clarity to search results and improving the way package information is displayed. Components such as package scores have been redesigned to be clearer and structured in a way that makes the scoring process more transparent and easier to understand.

更新后的设计采用了卡片、chips 等 [Material 组件](https://material.io/components)，清晰展示 package 详情，让你更透明地了解各个 package 的运作方式。我们更新了排版系统，改进了全站的[字号体系](https://material.io/design/typography/the-type-system.html#type-scale)，让搜索结果更清晰，也改善了 package 信息的展示方式。package 评分等组件也经过重新设计，更加清晰，其结构让评分过程更透明、更易懂。

<DashImage src="images/06UWz21c0wZuisozR.webp" alt="Pub.dev search results for gps filtered to Flutter, Android, and iOS, showing likes, pub points, and popularity scores." caption="*Search showing all three pub.dev scores*" />


We also made changes to the homepage. We knew the ability to quickly search for packages was a core part of the site, but we wanted to improve the experience by surfacing the most useful tools and libraries. We added sections such as **Flutter favorites** and **Most popular packages** up front, helping you to quickly explore some of the best packages available. We took a close look at the color palette and art direction, incorporating illustrations and making components such as code examples visually consistent with [dart.dev](https://dart.dev/) and [dartpad.dev](https://dartpad.dev/).

我们还改动了首页。我们知道快速搜索 package 的能力是网站的核心，但我们希望通过把最有用的工具和库呈现出来，进一步提升体验。我们在首页前面加入了 **Flutter favorites** 和 **Most popular packages** 等版块，帮你快速探索现有的一些最佳 package。我们仔细审视了配色方案和艺术方向，加入插画，并让代码示例等组件在视觉上与 [dart.dev](https://dart.dev/) 和 [dartpad.dev](https://dartpad.dev/) 保持一致。

## Try pub.dev today

## 今天就来试试 pub.dev

We invite you to try the new [pub.dev](http://pub.dev) browse and search experience today, and to use the new scoring dimensions and pub points report.

邀请你今天就体验全新的 [pub.dev](http://pub.dev) 浏览和搜索，并使用新的评分维度和 pub points 报告。

If you’re a package developer, we encourage you to view the pub points for your packages, looking for opportunities to improve your packages. For further details on how the scoring system works, see the [pub.dev scoring help](https://pub.dev/help/scoring).

如果你是 package 开发者，我们建议你查看自己 package 的 pub points，寻找改进 package 的机会。要进一步了解评分系统的工作原理，请参阅 [pub.dev 评分帮助](https://pub.dev/help/scoring)。

As always, we love feedback. Please leave comments below, or file issues in the [pub.dev issue tracker](https://github.com/dart-lang/pub-dev/issues).

一如既往，我们欢迎反馈。请在下方留言，或在 [pub.dev issue 跟踪器](https://github.com/dart-lang/pub-dev/issues)中提交 issue。

*By: Michael Thomsen (Product Manager, Dart) & 
Jeremy Sie (Visual Designer, Google Developer Studio)*

*作者：Michael Thomsen（Dart 产品经理）与
Jeremy Sie（Google Developer Studio 视觉设计师）*
