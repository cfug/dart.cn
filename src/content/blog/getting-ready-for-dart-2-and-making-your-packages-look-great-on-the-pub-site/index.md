---
# title: "Getting ready for Dart 2, and making your packages look great on the Pub site!"
title: "为 Dart 2 做好准备，让你的 package 在 Pub 站点上光彩夺目！"
# description: "We have a new release of Pub, the package repository for Dart! This time around we focused on preparing for the Dart 2 stable release."
description: "Dart 的 package 仓库 Pub 发布了新版本！这次我们聚焦于为 Dart 2 稳定版做准备。"
ai-translated: true
publishDate: 2018-07-20
author: mit-mit
image: images/0Fq4FHYc9N5aHmYBK.webp
category: other
layout: blog
---


<DashImage src="images/1zpVgP0W04QFmqqaJO9fzhg.webp" alt="The Dart logo alongside 'Dart Packages'." />


## Migrating your packages to Dart 2

## 把你的 package 迁移到 Dart 2

We expect the Dart 2 release to graduate to stable in the immediate future! Thus, it’s critical that you [migrate your code](https://www.dartlang.org/dart-2#migration) — especially any packages you have published — to be Dart 2 compatible. There are three main aspects to this:

我们预计 Dart 2 很快就会晋级稳定版！
因此，[迁移你的代码](https://www.dartlang.org/dart-2#migration)——
尤其是已发布的 package——使其兼容 Dart 2 至关重要。
主要有三个方面：

* Make sure your code passes Dart 2 analysis ([details](https://www.dartlang.org/dart-2#general-process)). We recommend you also pay attention to hints — for example, to prepare for deprecations.

  确保代码通过 Dart 2 分析
  （[详情](https://www.dartlang.org/dart-2#general-process)）。
  我们也建议你关注 hints——例如为废弃做准备。

* Run tests to make sure your code passes Dart 2 runtime checks ([details](https://www.dartlang.org/guides/language/sound-problems#runtime-errors)).

  运行测试，确保代码通过 Dart 2 运行时检查
  （[详情](https://www.dartlang.org/guides/language/sound-problems#runtime-errors)）。

* Update the upper bound of the SDK constraint of your packages to `&lt;3.0.0` ([details](https://www.dartlang.org/dart-2#upper-constraints-on-the-sdk-version)).

  把 package 的 SDK 约束上界更新为 `&lt;3.0.0`
  （[详情](https://www.dartlang.org/dart-2#upper-constraints-on-the-sdk-version)）。

We strongly encourage all package authors to do this work, and we will be pushing hard ourselves on the packages we own over the next few days.

我们强烈鼓励所有 package 作者做这项工作，
未来几天我们自己也会全力推进名下的 package。

## Improved analysis UI on the Pub site

## Pub 站点改进的分析界面

To help with this migration we have updated the analysis tab of the Pub site to make the results of code analysis easier to read. First, at the top of the analysis page we added progress bars allowing you to quickly see the status of the package:

为帮助迁移，我们更新了 Pub 站点的分析标签页，
让代码分析结果更易读。首先，在分析页顶部
我们加入了进度条，让你快速看到 package 的状态：

<DashImage src="images/0LatYAFujtrM2yebc.webp" alt="Pub site package scores represented by progress bars." caption="Package scores shown on the Pub site" />


Below the progress bars are detailed analysis results, grouped by severity: errors (red icon), warnings (yellow icon), and suggested issues (blue icon), as shown in the following screenshot:

进度条下面是按严重程度分组的详细分析结果：
错误（红色图标）、警告（黄色图标）和建议问题（蓝色图标），
如下面的截图所示：

<DashImage src="images/0Fq4FHYc9N5aHmYBK.webp" alt="Pub site analysis issues grouped by severity." caption="Analysis issues shown on the Pub site" />


## Updated analysis scores

## 更新的分析评分

We also made some tweaks to the analysis score. We now lower the score of a package if any of the following are true:

我们还对分析评分做了一些调整。
现在只要满足以下任一条件，就会降低 package 的分数：

* The package doesn’t pass Dart 2 analysis.

  package 未通过 Dart 2 分析。

* The upper SDK constraint isn’t at least `&lt;3.0.0`.

  SDK 约束上界没有至少达到 `&lt;3.0.0`。

* API reference generation ([dartdoc](https://www.dartlang.org/guides/language/effective-dart/documentation)) fails.

  API 参考生成
  （[dartdoc](https://www.dartlang.org/guides/language/effective-dart/documentation)）
  失败。

For our next Pub site release we expect to work on some further refinement of the scores, and to add some documentation for how the scores are calculated.

下一次 Pub 站点发布，我们预计进一步细化评分，
并添加评分计算方式的文档。

## Searching the API surface of a package

## 搜索 package 的 API 表面

Searching is — not too surprisingly — the most popular feature of the Pub site. We have made a number of improvements in this area over the past few quarters, focused on adding platform filters and better ranking. The new release extends search with support for searching the API surface of a package. In addition to the current search indexing of the package’s description and `README.md` content, search now covers all the public API members of the package, plus the API documentation for those members! This is great when you want to locate something that isn’t mentioned in the descriptions and `README.md` files.

不出所料，搜索是 Pub 站点最受欢迎的功能。
过去几个季度我们在这方面做了多项改进，
聚焦于添加平台过滤器和更好的排名。
新版本扩展了搜索，支持搜索 package 的 API 表面。
除了目前对 package 描述和 `README.md` 内容的搜索索引，
搜索现在覆盖 package 的所有公共 API 成员，
以及这些成员的 API 文档！当你想找的东西
没在描述和 `README.md` 中提到时，这非常有用。

For example, let’s say you’re looking for a package that can format strings using the [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217) currency format. A search in description and README.md files gives you [a single result](https://pub.dartlang.org/packages?q=4217&api=0), but a search that includes API documentation gives you [several results](https://pub.dartlang.org/packages?q=4217):

例如，假设你在找能按
[ISO 4217](https://en.wikipedia.org/wiki/ISO_4217)
货币格式格式化字符串的 package。
只搜描述和 README.md 文件得到
[一个结果](https://pub.dartlang.org/packages?q=4217&api=0)，
而包含 API 文档的搜索给你
[多个结果](https://pub.dartlang.org/packages?q=4217)：

```
10 results for 4217

intl

Contains code to deal with internationalized/localized messages, date and number formatting and parsing, bi-directional text, and other internationalization issues.

v 0.15.2 • Updated: Oct 19, 2017 FLUTTER WEB OTHER

API results:

intl/NumberFormat-class.html

flutter_billing

A flutter plugin to communicate with billing on iOS and Android.

v 0.1.2 • Updated: Feb 10, 2018 FLUTTER

API results:

flutter_billing/BillingProduct-class.html
```


## In summary…

## 总结……

The Dart 2 stable channel release is happening very soon, and we’ve made a bunch of Pub site improvements related to Dart 2, ranking, and searching.

Dart 2 稳定渠道发布在即，我们围绕 Dart 2、
排名和搜索做了一系列 Pub 站点改进。

If you’ve published packages, *now* is the time to update them for Dart 2:

如果你发布过 package，*现在*就是为 Dart 2 更新它们的时候：

1. Make sure your packages pass Dart 2 analysis.

    确保你的 package 通过 Dart 2 分析。

1. Update the upper bound of the SDK constraint to `<3.0.0` in your `pubspec.yaml`.

    在 `pubspec.yaml` 中把 SDK 约束上界更新为 `<3.0.0`。

1. Republish your updated packages.

    重新发布更新后的 package。

Then go to your package’s analysis page on [pub.dartlang.org](https://pub.dartlang.org/), and see what else you can do to improve your ranking!

然后去 [pub.dartlang.org](https://pub.dartlang.org/)
上你 package 的分析页面，
看看还能做些什么来提升排名！
