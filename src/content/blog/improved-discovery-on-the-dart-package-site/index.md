---
# title: "Improved discovery on the Dart package site"
title: "Dart package 站点的内容发现改进"
# description: "Back in July we talked about our changes to the Dart package site (http://pub.dartlang.org), which included better support for analyzing…"
description: "七月份我们介绍了 Dart package 站点（http://pub.dartlang.org）的改动，包括更好地分析……"
ai-translated: true
publishDate: 2018-09-24
author: mit-mit
image: images/1wh9C-VJUKEYz4l2zpUkg4A.webp
category: announcements
layout: blog
---


Back in July we talked about [our changes](/blog/getting-ready-for-dart-2-and-making-your-packages-look-great-on-the-pub-site) to the Dart package site ([http://pub.dartlang.org](http://pub.dartlang.org)), which included better support for analyzing packages for potential issues. Since then we’ve focused on further improvements to discovering content on the package site.

七月份我们介绍了 Dart package 站点（[http://pub.dartlang.org](http://pub.dartlang.org)）的[改动](/blog/getting-ready-for-dart-2-and-making-your-packages-look-great-on-the-pub-site)，包括更好地分析 package 潜在问题的能力。此后我们把重点放在进一步改进 package 站点的内容发现上。

## Dart 2 incompatibility

## Dart 2 不兼容

The vast majority of recent & popular packages have been [migrated to support Dart 2](https://www.dartlang.org/dart-2#migration), so they are ready for [Flutter](https://flutter.io/) and [AngularDart](https://webdev.dartlang.org/angular) 5 apps. However some packages — mostly older ones not being maintained — still don’t support Dart 2. To make sure you can easily spot these, we now add Dart 2 incompatibility tags to the overview and package detail pages.

绝大多数近期和热门的 package 已经[迁移到支持 Dart 2](https://www.dartlang.org/dart-2#migration)，可以用于 [Flutter](https://flutter.io/) 和 [AngularDart](https://webdev.dartlang.org/angular) 5 应用。但有些 package——主要是无人维护的老 package——仍然不支持 Dart 2。为了让你能轻松识别它们，我们现在在概览页和 package 详情页添加了 Dart 2 不兼容标签。

<DashImage src="images/1wh9C-VJUKEYz4l2zpUkg4A.webp" alt="Packages incompatible with Dart 2 are clearly marked 'Dart 2 incompatible'." caption="Packages incompatible with Dart 2 are clearly marked ‘Dart 2 incompatible’" />


Also, we anticipate that we will be archiving/discontinuing these incompatible packages in a future version of the package site, so if you are an author of a package marked 'Dart 2 incompatible', please consider migrating it soon!

另外，我们预计会在 package 站点的未来版本中归档/停止这些不兼容的 package，所以如果你是被标记为 ‘Dart 2 incompatible’ 的 package 作者，请考虑尽快迁移！

## Support for core libraries

## 核心库支持

Dart comes with a rich set of core (standard) libraries. Developers have told us that it can be hard to remember if a particular utility function is in a core library or in a package. To help you find the API you need, searches on pub.dartlang.org now include not just published packages, but also core libraries. Search results from core libraries have **sdk** in the score circle, and the annotation **Dart core library**. If you click the entry, you go directly to the library API documentation.

Dart 自带丰富的核心（标准）库。开发者告诉我们，很难记住某个工具函数到底在核心库里还是在某个 package 里。为了帮你找到需要的 API，pub.dartlang.org 的搜索现在不仅包含已发布的 package，还包含核心库。来自核心库的搜索结果在评分圆圈中显示 **sdk**，并带有 **Dart core library** 标注。点击条目会直接进入该库的 API 文档。

<DashImage src="images/1Q9oEytibPnPy23qiSliyyQ.webp" alt="Pub search results for json showing dart:convert above package results and marked with an sdk score badge." caption="Search hits in SDK core libraries are included among the results" />


## Package update feed

## Package 更新订阅源

Pub has provided an Atom feed for a while; to make this more discoverable we’ve added a direct link in the site footer.

Pub 提供 Atom 订阅源已有一段时间；为了让它更容易被发现，我们在站点页脚加了直接链接。

<DashImage src="images/01rSptJGr3iaTKqvb.webp" alt="The footer of the pub.dev website showing links to 'Dart language', 'Terms', 'Privacy', 'Help', and an RSS icon." />


## Scoring changes

## 评分调整

We’ve made a number of simplifications and adjustments to the scoring model for health and maintenance. For an overview of the current model, please see the [pana README](https://github.com/dart-lang/pana/blob/master/README.md) (pana is the tool that provides the scoring).

我们对健康度和维护度的评分模型做了多处简化和调整。当前模型的概览请参阅 [pana README](https://github.com/dart-lang/pana/blob/master/README.md)（pana 是提供评分的工具）。

In the future, we plan to improve transparency by showing how much each reported issue reduced the overall score directly on the package analysis page.

未来我们计划提升透明度，直接在 package 分析页上展示每个报告的问题让总分降低了多少。

## Feedback welcome

## 欢迎反馈

Found an issue? Have a cool idea or suggestion? Please tell us by [opening an issue](https://github.com/dart-lang/pub-dartlang-dart/issues/new?body=URL%3A+https%3A%2F%2Fpub.dartlang.org%2F%0A%0A%3CDescribe+your+issue+or+suggestion+here%3E&title=%3CSummarize+your+issues+here%3E&labels=Area%3A+site+feedback) in our tracker. Also note that even the package site itself is crafted as open-source in the [pub-dartlang-dart repo](https://github.com/dart-lang/pub-dartlang-dart), and contributions and ideas are most welcome!

发现了问题？有很棒的想法或建议？请在我们的跟踪器中[提交 issue](https://github.com/dart-lang/pub-dartlang-dart/issues/new?body=URL%3A+https%3A%2F%2Fpub.dartlang.org%2F%0A%0A%3CDescribe+your+issue+or+suggestion+here%3E&title=%3CSummarize+your+issues+here%3E&labels=Area%3A+site+feedback) 告诉我们。另外，package 站点本身也是在 [pub-dartlang-dart 仓库](https://github.com/dart-lang/pub-dartlang-dart)中开源打造的，非常欢迎贡献和想法！
