---
# title: "Dart 2.16: Improved tooling and platform handling"
title: "Dart 2.16：改进的工具与平台支持"
# description: "Supporting Flutter for Windows with package platform tagging and a new search experience for pub.dev"
description: "通过 package 平台标签支持 Windows 版 Flutter，以及 pub.dev 的全新搜索体验"
ai-translated: true
publishDate: 2022-02-03
author: mit-mit
image: images/0PJwhbfaIwRq3sSJi.webp
category: releases
layout: blog
---


Today the Dart SDK version 2.16 is available. It has no new language features, but a bunch of bug fixes (including a fix for a security vulnerability), improved support for specifying the platforms that Dart packages support, and a brand new search experience for [pub.dev](https://pub.dev/).

Dart SDK 2.16 版本今天发布。它没有新的语言特性，但有一批 bug 修复（包括一个安全漏洞的修复）、对指定 Dart package 支持平台的改进支持，以及 [pub.dev](https://pub.dev/) 的全新搜索体验。

## Dart 2.16

## Dart 2.16

The Dart 2.16 SDK, which launches today alongside [Flutter 2.10]({{site.flutter-blog}}/whats-new-in-flutter-2-10), continues the transition from legacy Dart CLI tools (`dartfmt`, `dartdoc`, etc.) to the new combined [`dart`](https://dart.dev/tools/dart-tool) developer tool. The newly deprecated tools are `dartdoc` (use `dart doc`) and `dartanalyzer` (use `dart analyze`). In Dart 2.17 we plan on fully removing the `dartdoc`, `dartanalyzer`, and `pub` commands (deprecated in Dart 2.15; use `dart pub` or `flutter pub`). For details, see [issue #46100](https://github.com/dart-lang/sdk/issues/46100).

今天与 [Flutter 2.10]({{site.flutter-blog}}/whats-new-in-flutter-2-10) 一同发布的 Dart 2.16 SDK，继续推进从旧版 Dart CLI 工具（`dartfmt`、`dartdoc` 等）向新的统一 [`dart`](https://dart.dev/tools/dart-tool) 开发者工具的过渡。新弃用的工具是 `dartdoc`（改用 `dart doc`）和 `dartanalyzer`（改用 `dart analyze`）。我们计划在 Dart 2.17 中完全移除 `dartdoc`、`dartanalyzer` 和 `pub` 命令（在 Dart 2.15 中已弃用；改用 `dart pub` 或 `flutter pub`）。详情见 [issue #46100](https://github.com/dart-lang/sdk/issues/46100)。

The 2.16 release also includes a fix for one security vulnerability and two small breaking changes:

2.16 版本还包含一个安全漏洞的修复和两个小的破坏性变更：

* The [`HttpClient`](https://github.com/dart-lang/sdk/security/advisories/GHSA-c8mh-jj22-xg5h#:~:text=https%3A//api.dart.dev/dart%2Dio/HttpClient%2Dclass.html) API in `dart:io` allows you to set optional headers for `authorization`, `www-authenticate`, `cookie`, and `cookie2`. The implementation of redirection logic in SDKs before Dart 2.16 has a vulnerability where these headers — which can contain sensitive information — are passed on when a cross-origin redirect happens. In Dart 2.16 these headers are dropped. For details, see [CVE-2022–0451](https://github.com/dart-lang/sdk/security/advisories/GHSA-c8mh-jj22-xg5h).

  `dart:io` 中的 [`HttpClient`](https://github.com/dart-lang/sdk/security/advisories/GHSA-c8mh-jj22-xg5h#:~:text=https%3A//api.dart.dev/dart%2Dio/HttpClient%2Dclass.html) API 允许你设置可选的 `authorization`、`www-authenticate`、`cookie` 和 `cookie2` 头。Dart 2.16 之前 SDK 的重定向逻辑实现存在漏洞：发生跨源重定向时，这些可能包含敏感信息的头会被继续传递。在 Dart 2.16 中这些头会被丢弃。详情见 [CVE-2022–0451](https://github.com/dart-lang/sdk/security/advisories/GHSA-c8mh-jj22-xg5h)。

* The `Directory.rename` API in `dart:io` has changed behavior on Windows: it no longer deletes an existing directory matching the target name (issue [#47653](https://github.com/dart-lang/sdk/issues/47653)).

  `dart:io` 中的 `Directory.rename` API 在 Windows 上行为有变：不再删除与目标名称相同的现有目录（issue [#47653](https://github.com/dart-lang/sdk/issues/47653)）。

* The `Platform.packageRoot` and `Isolate.packageRoot` APIs — which are left over from Dart 1.x and nonfunctional in Dart 2.x — have been removed (issue [#47769](https://github.com/dart-lang/sdk/issues/47769)).

  `Platform.packageRoot` 和 `Isolate.packageRoot` API——Dart 1.x 遗留、在 Dart 2.x 中已无功能的接口——已被移除（issue [#47769](https://github.com/dart-lang/sdk/issues/47769)）。

To find further details about changes in Dart 2.16, see the [changelog](https://github.com/dart-lang/sdk/blob/master/CHANGELOG.md#2160).

要了解 Dart 2.16 变更的更多细节，请查看[更新日志](https://github.com/dart-lang/sdk/blob/master/CHANGELOG.md#2160)。

## New support for declaring platform support for pub.dev packages

## 为 pub.dev package 声明平台支持的新方式

Dart is designed for portability, and we strive to enable code that runs on the largest selection of platforms. However, occasionally you might create and share packages on pub.dev that have been designed for just one, or a few, platforms. You might have a package that relies on an API that’s available only on a particular operating system, or a package that uses a library like `dart:ffi` that’s supported only on native platforms and not on the web.

Dart 为可移植性而设计，我们努力让代码能运行在尽可能多的平台上。不过，有时你在 pub.dev 上创建和分享的 package 可能只为一个或少数几个平台设计。你的 package 可能依赖只在特定操作系统上可用的 API，或者使用 `dart:ffi` 这类只在原生平台（而非 Web）受支持的库。

With Dart 2.16 you can now declare the set of supported platforms manually in the pubspec of the package. For example, if your package supports only Windows and macOS, its `pubspec.yaml` file might look like this:

在 Dart 2.16 中，你现在可以在 package 的 pubspec 中手动声明支持的平台集合。例如，如果你的 package 只支持 Windows 和 macOS，它的 `pubspec.yaml` 文件可能长这样：

```
name: mypackage
version: 1.0.0

platforms:
  windows:
  macos:

dependencies:
```


The new `platforms` tag is intended for cases where you are developing a Dart package, and you want to declare support for a different set of platforms from what pub.dev automatically detects. If you’re developing and sharing a Flutter plugin containing host-specific code (for example, Kotlin or Swift), the [Flutter plugin tag](https://docs.flutter.dev/development/packages-and-plugins/developing-packages#plugin-platforms) typically specifies the supported platforms.

新的 `platforms` 标签适用于这样的场景：你在开发 Dart package，想声明与 pub.dev 自动检测不同的平台支持集合。如果你在开发并分享包含宿主特定代码（例如 Kotlin 或 Swift）的 Flutter 插件，通常由 [Flutter 插件标签](https://docs.flutter.dev/development/packages-and-plugins/developing-packages#plugin-platforms)指定支持的平台。

## New pub.dev search UI

## 全新的 pub.dev 搜索界面

Responding to developer requests, we’ve created better support for searching for packages on pub.dev. The main goal for the changes launching today is to help you identify, and search for, the set of supported platforms. Here’s a view of the new search experience:

响应开发者的请求，我们为 pub.dev 上的 package 搜索提供了更好的支持。今天上线的改动的主要目标是帮助你识别和搜索支持的平台集合。下面是新搜索体验的样子：

<DashImage src="images/0PJwhbfaIwRq3sSJi.webp" alt="pub.dev search interface with sidebar filters for platforms, SDKs, and advanced search." caption="Pub.dev search interface with sidebar containing Platforms, SDKs, and Advanced search filters" />


The new search UI has a search filter sidebar on the left, which you can use to constrain your package search:

新搜索界面左侧有一个搜索过滤侧边栏，可以用来限定 package 搜索：

* **Platforms**: Select one or more platforms to narrow the search results to only packages that support all those platforms selected.

  **Platforms**：选择一个或多个平台，把搜索结果缩小到支持所有选中平台的 package。

* **SDKs**: Select Dart or Flutter to limit the results to packages that support the Dart SDK or Flutter SDK, respectively.

  **SDKs**：选择 Dart 或 Flutter，把结果分别限定为支持 Dart SDK 或 Flutter SDK 的 package。

* **Advanced**: Additional search options such as filtering to Flutter Favorite packages.

  **Advanced**：更多搜索选项，例如筛选 Flutter Favorite package。

## Null safety update

## 空安全进展

It’s been a few releases since we last talked about null safety, the major language addition that launched a year ago in [Dart 2.12](/blog/announcing-dart-2-12). We’ve been astonished by the speed at which the Dart ecosystem has migrated packages to support null safety: As of today, 100% of the top 250 packages — and 96% of the top 1000 — support null safety! Thanks to all package authors who’ve contributed to this great achievement.

距离我们上次谈论空安全已经过了几个版本——这项重大语言新增在一年前随 [Dart 2.12](/blog/announcing-dart-2-12) 发布。Dart 生态迁移 package 支持空安全的速度令我们惊叹：截至今天，前 250 个 package 的 100%——以及前 1000 个的 96%——都已支持空安全！感谢为这一伟大成就做出贡献的所有 package 作者。

We’ve also seen good progress on apps migrating to sound null safety (the state where the app code and all package dependencies have migrated). From our analytics, 71% of all run sessions in the Flutter tool now have fully sound null safety. If you’re an app developer and still haven’t migrated, now is a great time.

应用迁移到健全空安全（应用代码和所有 package 依赖都已迁移的状态）也有良好进展。根据我们的分析，Flutter 工具中 71% 的运行会话现在已是完全健全的空安全。如果你是应用开发者且还没迁移，现在正是好时机。

## Closing comments

## 结语

We hope you find the new pub.dev search UI useful, and we welcome [any feedback](https://github.com/dart-lang/pub-dev/issues/) you might have. Stay tuned for the next Dart SDK release, which is scheduled for the second quarter of 2022. We’re working on several [exciting language features](https://github.com/dart-lang/language/projects/1) that we hope to release later this year.

希望你觉得新的 pub.dev 搜索界面有用，欢迎[任何反馈](https://github.com/dart-lang/pub-dev/issues/)。敬请期待下一个 Dart SDK 版本，计划于 2022 年第二季度发布。我们正在开发几个[令人兴奋的语言特性](https://github.com/dart-lang/language/projects/1)，希望能在今年晚些时候发布。
