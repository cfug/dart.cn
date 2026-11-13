---
# title: Dart SDK overview
title: Dart SDK 概览
# shortTitle: SDK overview
shortTitle: SDK 概览
# breadcrumb: SDK
breadcrumb: SDK
# description: Dart libraries and command-line tools.
description: Dart 库与命令行工具。
ai-translated: true
---

The Dart SDK has the libraries and command-line tools that you need to develop
Dart web, command-line, and server apps.
To install the Dart SDK, see [Get Dart](/get-dart).
If you're developing Flutter apps, [install the Flutter SDK][flutter].
The Flutter SDK includes the Dart SDK.

Dart SDK 提供开发 Dart Web、命令行和服务器应用所需的库与命令行工具。
安装 Dart SDK 请参阅 [获取 Dart](/get-dart)。
如果正在开发 Flutter 应用，请 [安装 Flutter SDK][flutter]。
Flutter SDK 已包含 Dart SDK。

To learn about other tools you can use for Dart development,
check out the [Dart tools](/tools) page.

要了解还可用于 Dart 开发的其他工具，
请查看 [Dart 工具](/tools) 页面。

:::version-note
Unless stated otherwise,
this site's documentation and examples assume
version `{{site.sdkVersion}}` of the **Dart SDK**.

除非另有说明，
本站文档和示例均假定使用
**Dart SDK** `{{site.sdkVersion}}` 版本。
:::

{% comment %}
  IMPORTANT: After each release, EDIT src/_data/pkg-vers.json
  to update the SDK version number.
  More info: https://github.com/dart-lang/site-www/wiki/Updating-to-new-SDK-releases
{% endcomment %}

## What's in the Dart SDK

## Dart SDK 包含的内容

The Dart SDK includes two directories:

Dart SDK 包含两个目录：

* `lib` contains the [Dart libraries][].

  `lib` 包含 [Dart 库][Dart libraries]。

* `bin` contains the following command-line tools.

  `bin` 包含下列命令行工具。

[`dart`](/tools/dart-tool)
: The command-line interface to create, format, analyze, test,
  document, compile, and run Dart code.

  用于创建、格式化、分析、测试、编写文档、编译并运行 Dart 代码的命令行界面。

[`dartaotruntime`](/tools/dartaotruntime)
: A Dart runtime for AOT-compiled snapshots.

  用于运行 AOT 编译快照的 Dart 运行时。

To learn more about the SDK, check out its [README file][sdk-readme].

要进一步了解 SDK，请查看它的 [README 文件][sdk-readme]。

:::note
The Dart language expects Dart code to be encoded using [UTF-8][utf8].

Dart 语言要求 Dart 代码使用 [UTF-8][utf8] 编码。
:::

[sdk-readme]: {{site.repo.dart.sdk}}/blob/main/README.dart-sdk
[utf8]: https://www.utf8.com/

## Support policy

## 支持政策

The Dart team supports only the latest, stable version of the Dart SDK.
When a new major or minor version is released,
older versions are no longer supported.
For example, if `3.7.x` is the latest release,
it is supported until `3.8.0` or `4.0.0` is released,
whichever comes first.

Dart 团队只支持最新的稳定版 Dart SDK。
新的主版本或次版本发布后，
更早的版本不再获得支持。
例如，如果最新版本是 `3.7.x`，
它会一直得到支持，直到 `3.8.0` 或 `4.0.0` 发布
（以先到者为准）。

The Dart team provides fixes to critical issues and security problems as needed
through patch releases but only for the currently supported version.
For example, if `3.7.0` is the latest stable release,
a fix to a vulnerability might be issued in a `3.7.1` patch release.

Dart 团队会按需通过补丁版本修复严重问题和安全问题，
但只针对当前受支持的版本。
例如，如果最新稳定版是 `3.7.0`，
某个漏洞的修复可能会出现在 `3.7.1` 补丁版本中。

On average, the Dart team ships a new stable release every 3 months.
Patch releases to the currently supported version are shipped as needed.

平均而言，Dart 团队每 3 个月发布一个新的稳定版。
当前受支持版本的补丁会按需发布。

This policy helps ensure Dart developers have access to
a stable and reliable platform that continues to
evolve with new features and improvements.

这项政策是为了让 Dart 开发者能够使用
稳定可靠、并随新功能和改进持续演进的平台。

{% comment %}
TODO(parlough): Add a section discussing the breaking change policy
and link out to the breaking change index.
{% endcomment %}

## Filing bugs and feature requests

## 提交 bug 和功能请求

To see existing issues or create a new one,
go to [the SDK issue tracker][sdk-issues].

要查看已有 issue 或新建一个，
请前往 [SDK issue 跟踪器][sdk-issues]。

[Dart libraries]: /libraries
[flutter]: {{site.flutter-docs}}/get-started/install
[sdk-issues]: {{site.repo.dart.sdk}}/issues
