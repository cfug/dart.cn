---
# title: "Google Summer of Code 2021 results"
title: "Google Summer of Code 2021 成果"
# description: "The Dart team received 92 GSoC project proposals from students around the world. Here are the results of the 3 projects we accepted."
description: "Dart 团队收到了来自世界各地学生的 92 份 GSoC 项目提案。以下是我们接收的 3 个项目的成果。"
ai-translated: true
publishDate: 2021-10-14
author: jonasfj
image: images/1QswESHAF6CO9UNYCcRVKXA.webp
category: other
layout: blog
---


[Google Summer of Code](https://summerofcode.withgoogle.com/) (GSoC) is a global program focused on bringing student developers into open source software development. Students are sponsored by Google to work with a mentoring open source organization on a 10-week programming project during the summer. Over the past 16 years more than 16,000 students have participated in Google Summer of Code.

[Google Summer of Code](https://summerofcode.withgoogle.com/)（GSoC）是一项全球性计划，致力于把学生开发者带入开源软件开发。Google 资助学生在暑期与一个担任指导的开源组织合作，完成一个为期 10 周的编程项目。过去 16 年里，已有超过 16,000 名学生参加过 Google Summer of Code。

2021 is the second time that the Dart organization participated in Google Summer of Code as a mentoring organization. Following our [call for student proposals in March](/blog/dart-in-google-summer-of-code-2021) we received 92 project proposals from students around the world, out of which we were thrilled to accept 3 projects. Today, we are excited to share our results, as described by the students who worked on these projects.

2021 年是 Dart 组织第二次作为指导组织参加 Google Summer of Code。在[三月份发出学生提案征集](/blog/dart-in-google-summer-of-code-2021)之后，我们收到了来自世界各地学生的 92 份项目提案，并从中欣喜地接收了 3 个项目。今天，我们很高兴由参与这些项目的学生亲自讲述他们的成果。

## Cronet-based HTTP client for Dart

## 基于 Cronet 的 Dart HTTP 客户端

*By Soumyadip Mondal*

*作者：Soumyadip Mondal*

The [cronet](https://pub.dev/packages/cronet) package is an HTTP package for Dart Native platforms, backed by [Chromium’s network engine](https://chromium.googlesource.com/chromium/src/+/refs/heads/main/components/cronet).

[cronet](https://pub.dev/packages/cronet) package 是面向 Dart 原生平台的 HTTP package，底层由 [Chromium 的网络引擎](https://chromium.googlesource.com/chromium/src/+/refs/heads/main/components/cronet)提供支持。

You might ask “why add an HTTP package?” when Dart already has HTTP support in `dart:io`. One reason is that `package:cronet` can use the QUIC/HTTP3 protocol, which is [a highly requested](https://github.com/dart-lang/sdk/issues/38595) community feature. Besides that, `package:cronet` is [faster than `d](https://github.com/google/cronet.dart/blob/main/dart_io_comparison.md#performance-comparison)art:io` in many scenarios.

你可能会问：Dart 已经在 `dart:io` 中支持 HTTP 了，“为什么还要加一个 HTTP package？”一个原因是 `package:cronet` 可以使用 QUIC/HTTP3 协议，这是社区[呼声很高](https://github.com/dart-lang/sdk/issues/38595)的特性。此外，`package:cronet` 在许多场景下[比 `dart:io` 更快](https://github.com/google/cronet.dart/blob/main/dart_io_comparison.md#performance-comparison)。

A Dart binding of Cronet gives us easy access to its [features](https://www.chromium.org/developers/design-documents/network-stack#TOC-Connection-Management), such as: reusability of sockets, powerful caching and compression algorithms, request prioritization, and [more reliable](https://www.youtube.com/watch?v=YWiRef3wOYY) network connections. Various Google products — including YouTube, Chrome, Google Maps, Google Photos, and the Google App — already depend on the Cronet library for their networking needs. With `package:cronet`, you get access to the Cronet library using an API [similar](https://github.com/google/cronet.dart/blob/main/dart_io_comparison.md#api-comparison) to `dart:io`, with little to no code changes in your existing Dart/Flutter app.

Cronet 的 Dart 绑定让我们可以轻松使用它的[各种特性](https://www.chromium.org/developers/design-documents/network-stack#TOC-Connection-Management)，例如：套接字复用、强大的缓存与压缩算法、请求优先级，以及[更可靠](https://www.youtube.com/watch?v=YWiRef3wOYY)的网络连接。多个 Google 产品——包括 YouTube、Chrome、Google Maps、Google Photos 和 Google App——的网络需求都已依赖 Cronet 库。通过 `package:cronet`，你可以用[类似](https://github.com/google/cronet.dart/blob/main/dart_io_comparison.md#api-comparison) `dart:io` 的 API 访问 Cronet 库，现有 Dart/Flutter 应用几乎不需要改动代码。

Check out [github.com/google/cronet.dart](https://github.com/google/cronet.dart) for [benchmarks](https://github.com/google/cronet.dart/blob/main/dart_io_comparison.md#performance-comparison), [examples](https://github.com/google/cronet.dart/tree/main/example), and [comparisons with `d](https://github.com/google/cronet.dart/blob/main/dart_io_comparison.md)art:io`. Also check [this blog post](https://unsuitable001.medium.com/package-cronet-an-http-dart-flutter-package-with-dart-ffi-84f9b69c8a24) about `package:cronet` for a technical overview and discussion of the challenges we faced.

请访问 [github.com/google/cronet.dart](https://github.com/google/cronet.dart) 查看[基准测试](https://github.com/google/cronet.dart/blob/main/dart_io_comparison.md#performance-comparison)、[示例](https://github.com/google/cronet.dart/tree/main/example)以及[与 `dart:io` 的对比](https://github.com/google/cronet.dart/blob/main/dart_io_comparison.md)。也欢迎阅读关于 `package:cronet` 的[这篇博客](https://unsuitable001.medium.com/package-cronet-an-http-dart-flutter-package-with-dart-ffi-84f9b69c8a24)，其中有技术概览以及对我们遇到的挑战的讨论。

## Flutter desktop tool

## Flutter 桌面工具

*By Abdullah Deshmukh*

*作者：Abdullah Deshmukh*

After the beta release of desktop support in Flutter 2, we needed a sample app to demonstrate how to write a Flutter app that can run on Windows, macOS, and Linux. I worked on that sample, in the form of a [Flutter linting tool that ](https://github.com/flutter/samples/tree/master/experimental/linting_tool)helps you manage lint rules for your Flutter projects. The app’s source code shows how you might implement basic desktop app techniques like reading and writing files, implementing a responsive layout, using persistent storage, and even how to work with YAML files. Also the sample might be used to test the distribution of Flutter apps to the various desktop app stores.

Flutter 2 的桌面支持发布 beta 之后，我们需要一个示例应用来演示如何编写能在 Windows、macOS 和 Linux 上运行的 Flutter 应用。我负责了这个示例，它是一个 [Flutter lint 工具](https://github.com/flutter/samples/tree/master/experimental/linting_tool)，帮助你管理 Flutter 项目的 lint 规则。这个应用的源码展示了如何实现桌面应用的基本技术，比如读写文件、实现响应式布局、使用持久化存储，甚至如何处理 YAML 文件。这个示例也可以用来测试把 Flutter 应用分发到各个桌面应用商店。

For more details, visit [GSoC ’21: Creating a desktop sample for Flutter]({{site.flutter-blog}}/gsoc-21-creating-a-desktop-sample-for-flutter).

更多细节请访问 [GSoC ’21: Creating a desktop sample for Flutter]({{site.flutter-blog}}/gsoc-21-creating-a-desktop-sample-for-flutter)。

<DashImage src="images/1QswESHAF6CO9UNYCcRVKXA.webp" alt="The Flutter linting tool shows various lint rules and their descriptions." caption="Flutter linting tool" />


## License detection for pub.dev

## pub.dev 的许可证检测

*By Bharat Biradar*

*作者：Bharat Biradar*

A package published on [pub.dev](https://pub.dev/) is evaluated on various metrics such as whether it follows Dart file conventions, has a CHANGELOG file, etc. This analysis is done by [pana](https://github.com/dart-lang/pana) (Package ANAlysis for Dart). Pana is also responsible for detecting the license identifier under which the package is published.

发布到 [pub.dev](https://pub.dev/) 的 package 会按多项指标进行评估，例如是否遵循 Dart 文件约定、是否有 CHANGELOG 文件等。这项分析由 [pana](https://github.com/dart-lang/pana)（Package ANAlysis for Dart）完成。pana 还负责检测 package 发布时使用的许可证标识。

Until now the license names displayed on pub.dev were determined through simple regular expression heuristics, and they only supported detection of a few licenses with poor accuracy. The task of this project was to create a license detector for pana to detect [SPDX licenses](https://spdx.org/licenses), in line with the [SPDX matching guidelines](https://spdx.dev/license-list/matching-guidelines/).

在此之前，pub.dev 上显示的许可证名称是通过简单的正则表达式启发式规则确定的，只能检测少数几种许可证，而且准确率很低。这个项目的任务是为 pana 创建一个许可证检测器，按照 [SPDX 匹配指南](https://spdx.dev/license-list/matching-guidelines/)检测 [SPDX 许可证](https://spdx.org/licenses)。

The license detector built for pana uses the same approach as [v2_licenseclassifier](https://github.com/google/licenseclassifier), with modifications made to suit our requirements better.

为 pana 构建的许可证检测器采用了与 [v2_licenseclassifier](https://github.com/google/licenseclassifier) 相同的方法，并做了修改以更好地满足我们的需求。

Given the LICENSE file from a package, pana uses three steps to detect the SPDX license identifiers:

给定 package 的 LICENSE 文件，pana 通过三个步骤检测 SPDX 许可证标识：

1. **Eliminate obvious mismatches from SPDX corpus:** Split the text into tokens (basically words), check whether the LICENSE file has a sufficient number of tokens (at least 50%) as compared to a known license, and eliminate all known licenses that do not satisfy the criteria. This step allows pana to quickly rule out a lot of licenses, allowing for more expensive computations in step 2.

  **从 SPDX 语料库中排除明显不匹配的许可证：**把文本切分成 token（基本就是单词），检查 LICENSE 文件与已知许可证相比是否有足够数量的 token（至少 50%），并排除所有不满足条件的已知许可证。这一步让 pana 能快速排除大量许可证，从而在第 2 步进行开销更大的计算。

1. **Find matching substrings in the unknown license and remaining SPDX licenses:** For the remaining known licenses, find the substrings in the unknown text that match a known license text. We look for substrings, because the unknown text might contain multiple licenses. When identifying matching substrings, we ignore sequences with fewer tokens than `threshold * number_of_tokens_in_known_license`, because such sequences do not have sufficient token density to constitute a match. If no substrings with sufficient token densities are found for a given known license, then we know it isn’t a match.

  **在未知许可证与剩余 SPDX 许可证中查找匹配子串：**对剩余的已知许可证，在未知文本中查找与已知许可证文本匹配的子串。之所以查找子串，是因为未知文本可能包含多个许可证。识别匹配子串时，我们会忽略 token 数少于 `threshold * number_of_tokens_in_known_license` 的序列，因为这类序列的 token 密度不足以构成匹配。如果对某个已知许可证找不到具有足够 token 密度的子串，就可以确定它不匹配。

1. **Determine confidence scores:** This step ****estimates a confidence score (between [0,1] ) to the substrings found. First the substring is diffed, using [levenshtain word diff](https://github.com/google/diff-match-patch/wiki/Line-or-Word-Diffs#word-mode), against the SPDX corpus license in which it was detected. Then license is considered a match if the confidence calculated as follows is above the set threshold:

  **计算置信度分数：**这一步为找到的子串估算一个置信度分数（在 [0,1] 之间）。首先使用 [Levenshtein 单词级 diff](https://github.com/google/diff-match-patch/wiki/Line-or-Word-Diffs#word-mode) 把子串与检测到它的 SPDX 语料库许可证做差异比较。如果按下面的公式计算出的置信度高于设定阈值，就认为许可证匹配：

<DashImage src="images/1wB7F9CgvSn7yt2Rgoj75pw.webp" alt="A formula for calculating the confidence score of a license match." />


We hope this gives you some idea of the license detection process. If you want to play with the license detector, you can find it in the [pana repository](https://github.com/dart-lang/pana/tree/master/bin).

希望这能让你对许可证检测过程有所了解。如果你想动手试试这个许可证检测器，可以在 [pana 仓库](https://github.com/dart-lang/pana/tree/master/bin)中找到它。

*Huge thanks to everyone who applied for Google Summer of Code 2021 with Dart, to the students who completed projects this year, and to the mentors who helped make this an awesome summer of code. If you’re interested in hearing more about Dart in Google Summer of Code, check out [our 2020 post](/blog/google-summer-of-code-2020-results).*

*衷心感谢所有申请 Dart Google Summer of Code 2021 的同学、今年完成项目的学生，以及帮助打造这个精彩编程之夏的导师们。如果你想了解更多 Dart 参加 Google Summer of Code 的情况，欢迎阅读[我们 2020 年的文章](/blog/google-summer-of-code-2020-results)。*
