---
# title: "Announcing Dart 3.6"
title: "宣布 Dart 3.6"
# description: "Welcome to Dart 3.6! Today is our last release of the year, alongside Flutter 3.27. We’re excited to share a new feature in the language…"
description: "欢迎使用 Dart 3.6！今天是我们今年的最后一个版本，与 Flutter 3.27 一同发布。我们很高兴分享语言新特性……"
ai-translated: true
publishDate: 2024-12-11
author: mbelanger
image: images/0pojZOcfCeFztkEzK.webp
category: releases
layout: blog
---


Welcome to Dart 3.6! Today is our last release of the year, alongside [Flutter 3.27]({{site.flutter-blog}}/whats-new-in-flutter-3-27). We’re excited to share a new feature in the language, *digit separators*. We also have several new features in the pub ecosystem: *pub download counts*, and the highly anticipated *pub workspaces*!

欢迎使用 Dart 3.6！今天是我们今年的最后一个版本，
与 [Flutter 3.27]({{site.flutter-blog}}/whats-new-in-flutter-3-27)
一同发布。我们很高兴分享一项语言新特性：*数字分隔符*
（digit separators）。pub 生态也有几项新特性：
*pub 下载计数*，以及备受期待的 *pub 工作区*（workspaces）！

<DashImage src="images/0pojZOcfCeFztkEzK.webp" alt="Dart 3.6 release banner with the Dart logo, a bullseye icon, and blue vertical bars." caption="Dart 3.6" />


## Pub workspaces

## Pub 工作区

Pub now supports shared resolution between packages in a monorepo, or workspace. A workspace is a tightly related group of packages developed, resolved, and released together.

Pub 现在支持 monorepo（即工作区）中各 package 之间的
共享依赖解析。工作区是一组紧密相关、一起开发、
一起解析依赖并一起发布的 package。

The pub workspaces feature ensures that packages in a monorepo share a consistent set of dependencies. This forces you to resolve dependency conflicts between your grouped packages *as they arise,* rather than facing confusion when you start using the packages..

pub 工作区特性确保 monorepo 中的 package 共享一组一致的依赖。
这迫使你在依赖冲突*出现时*就解决同组 package 之间的冲突，
而不是等到开始使用这些 package 时才面对混乱。

The Flutter analyzer processes all of the packages in a pub workspace in a single analysis context, as opposed to the previous behavior of a separate context for each package. For large repositories, this can significantly reduce the amount of memory the Dart language server consumes, improving IDE performance.

Flutter 分析器会在单个分析上下文中处理 pub 工作区里的
所有 package，而不是像以前那样为每个 package 单独建上下文。
对大型仓库来说，这能显著减少 Dart 语言服务器占用的内存，
提升 IDE 性能。

To define a pub workspace, add the workspace field in the root `pubspec.yaml` file and list the related packages, as shown in the following example:

要定义 pub 工作区，请在根目录的 `pubspec.yaml` 文件中
添加 workspace 字段并列出相关 package，如下例所示：

```yaml
name: _
publish_to: none
environment:
  sdk: ^3.6.0
workspace:
  - packages/helper
  - packages/client_package
  - packages/server_package
```


Then run `pub get` anywhere in the repository to complete the mapping and remaining file management.

然后在仓库的任意位置运行 `pub get`，
完成映射和其余文件管理。

To use pub workspaces, all workspace packages (but not dependencies) must have an SDK version constraint of `^3.6.0` or greater.

要使用 pub 工作区，所有工作区 package（但不包括依赖）
的 SDK 版本约束必须是 `^3.6.0` 或更高。

For more information including fully detailed instructions and edge cases coverage, check out the [Pub workspaces (monorepo support)](https://dart.dev/go/pub-workspaces) page.

更多信息，包括完整详细的说明和边界情况，
请查看 [Pub 工作区（monorepo 支持）](https://dart.dev/go/pub-workspaces)页面。

## Pub download counts

## Pub 下载计数

We listened to [your requests](https://github.com/dart-lang/pub-dev/issues/2714) for more precise metrics on pub.dev, and now download counts are here! The download count replaces the previous “popularity score” on individual package pages. Along with the new metric, you will also find a sparkline chart on each page, showing weekly downloads over time.

我们听取了[你的请求](https://github.com/dart-lang/pub-dev/issues/2714)，
为 pub.dev 提供更精确的指标——现在下载计数来了！
下载计数取代了各个 package 页面上原来的“流行度分数”。
除了这项新指标，你还会在每个页面看到一张迷你趋势图，
展示随时间变化的每周下载量。

<DashImage src="images/0KJoC5ioNl7lXms0P.webp" alt="The new download count and sparkline graph displayed on pub.dev." caption="A screenshot highlighting the new download count and sparkline graph on pub.dev" />


You can learn more about download counts in the [pub.dev scoring documentation](https://pub.dev/help/scoring).

你可以在 [pub.dev 评分文档](https://pub.dev/help/scoring)中
进一步了解下载计数。

## Digit separators

## 数字分隔符

The Dart language now allows underscores (_) as digit separators, which help make long number literals more readable. Multiple consecutive underscores indicate higher level grouping. Here are some examples of valid digit separator uses in Dart:

Dart 语言现在允许用下划线（_）作为数字分隔符，
让长数字字面量更易读。多个连续下划线表示更高层级的分组。
下面是在 Dart 中合法使用数字分隔符的一些例子：

```
1__000_000__000_000__000_000
0x4000_0000_0000_0000
0.000_000_000_01
0x00_14_22_01_23_45
```


Remember, digit separators are valid only *between* digits, so literals like `100_`, `0._000_1`, or `1.2e_3` aren’t allowed. It’s also important to use digit separators consistently, so make sure digit groups are the same size between every level of groups.

记住，数字分隔符只在数字*之间*有效，
所以 `100_`、`0._000_1` 或 `1.2e_3` 这样的字面量是不允许的。
一致地使用数字分隔符也很重要，
请确保每一层级分组内的数字组大小相同。

To use digit separators, you’ll need to bump the minimum SDK in your package to `3.6.0` or greater.

要使用数字分隔符，你需要把 package 的最低 SDK 版本
提升到 `3.6.0` 或更高。

## Closing

## 结语

That’s all for today. For the full story of what the Dart team has been up to this quarter, check out the [Changelog for 3.6.0](https://github.com/dart-lang/sdk/blob/main/CHANGELOG.md#360). And don’t forget to visit the [Flutter 3.27 release blog]({{site.flutter-blog}}/whats-new-in-flutter-3-27) post for even more updates. See you next year!

今天就到这里。想了解 Dart 团队这个季度都做了什么的完整故事，
请查看 [3.6.0 更新日志](https://github.com/dart-lang/sdk/blob/main/CHANGELOG.md#360)。
也别忘了访问
[Flutter 3.27 发布博客]({{site.flutter-blog}}/whats-new-in-flutter-3-27)
获取更多更新。明年见！
