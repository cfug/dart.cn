---
title: Dart SDK archive
title: Dart SDK 归档
short-title: Archive
short-title: 归档
description: Download specific stable, beta, dev, and main channel versions of the Dart SDK and the Dart API documentation.
description: 下载特定的稳定版、测试版、开发版和主分支开发版的 Dart SDK 和 Dart API 文档。
js:
- url: /get-dart/archive/out/web/download_archive.dart_cn.js
  defer: true
- url: /get-dart/archive/assets/install.js
  defer: true
---

Use this archive to download
[specific versions](/get-dart#release-channels) of the
[Dart SDK](/tools/sdk)
and the [Dart API documentation.]({{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}})

你可以在此页面下载 [特定版本](/get-dart#release-channels)
的 [Dart SDK](/tools/sdk) 和
[Dart API 文档](({{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}))。

Want to install Dart with your OS's package manager?
[Get Dart.](/get-dart)

希望通过系统的包管理安装 Dart？请查看如何 [获取 Dart SDK](/get-dart)。

{{site.alert.warn}}
  {% include_relative _sdk-terms.md %}
{{site.alert.end}}

## Stable channel

## 稳定版渠道

Stable channel builds are tested and approved for production use.

**稳定版渠道的构建是经过测试且可用于生产环境的。**

{% include_relative _archives_table.html channel="stable" %}

## Beta channel

## 测试版渠道

Beta channel builds are preview builds for the stable channel.
We recommend testing, but not releasing, your apps against beta
to preview new features or test compatibility with future releases.
Beta channel builds are not suitable for production use.

测试版渠道的构建是稳定版的前置预览。我们推荐你使用该渠道对你的应用进行测试，
包括新特性和对未来发布内容的兼容性，但不要用于发布。
**测试版渠道的构建不适合在生产环境使用。**

{% include_relative _archives_table.html channel="beta" %}

## Dev channel

## 开发版渠道

Dev channel builds can provide early access
to new features but might contain bugs.
Dev channel builds are not suitable for production use.

开发版渠道的构建提供了早期的新特性预览，但它们可能包含一些 BUG。
**开发版渠道的构建不适合在生产环境使用。**

{% include_relative _archives_table.html channel="dev" %}

## Main channel

## 主分支开发版渠道

Main channel builds are the latest, raw builds from
the `main` branch of the Dart SDK repository.
These are the freshest builds available,
and they're likely to contain bugs.
Main channel builds are suitable only for
experimental development use, not for production use.

主分支开发版的构建是最新且最原始的，是来自
Dart SDK 仓库的主分支 (`master`) 的构建。
这些构建是永远是最新的，所以它们有可能包含多个 BUG。
**主分支开发版的构建只适用于更专业的开发，而不是生产用途的开发**。

{{site.alert.note}}

  Main channel builds are unsigned.

  主分支开发版渠道的构建是未经签名的。

{{site.alert.end}}

To download a main channel build, use a
[main channel URL](#main-channel-url-scheme).

若你想下载主分支开发版渠道的构建，请使用
[主分支开发版渠道的链接](#main-channel-url-scheme)。

## Download URLs

## 下载链接

You can download zip files for any channel.

你可以下载任意渠道的 zip 文件。

### Stable, beta, and dev channel URL scheme

### 稳定版、测试版和开发版的链接格式

Stable, beta, and dev channel releases
are available at URLs like the following:

稳定版、测试版和开发版渠道的发布构建，
可以使用以下格式的链接进行下载：

{% prettify none tag=pre+code %}
https://storage.flutter-io.cn/dart-archive/channels/<[!stable|beta|dev!]>/release/<[!version!]>/sdk/dartsdk-<[!platform!]>-<[!architecture!]>-release.zip
{% endprettify %}

Examples:

示例：

{% prettify none tag=pre+code %}
https://storage.flutter-io.cn/dart-archive/channels/stable/release/2.7.2/sdk/dartsdk-windows-ia32-release.zip
https://storage.flutter-io.cn/dart-archive/channels/stable/release/2.1.1/sdk/dartsdk-macos-x64-release.zip
https://storage.flutter-io.cn/dart-archive/channels/beta/release/2.8.0-20.11.beta/sdk/dartsdk-linux-x64-release.zip
https://storage.flutter-io.cn/dart-archive/channels/dev/release/2.9.0-1.0.dev/sdk/dartsdk-linux-x64-release.zip
{% endprettify %}

### Main channel URL scheme

### 主分支开发版的链接格式

The latest main channel build
is available at URLs like the following:

最新的主分支开发版渠道的构建，
可以使用以下格式的链接进行下载：

{% prettify none tag=pre+code %}
https://storage.flutter-io.cn/dart-archive/channels/be/raw/latest/sdk/dartsdk-<[!platform!]>-<[!architecture!]>-release.zip
{% endprettify %}

Example:

示例：

{% prettify none tag=pre+code %}
https://storage.flutter-io.cn/dart-archive/channels/be/raw/latest/sdk/dartsdk-windows-x64-release.zip
{% endprettify %}

{{site.alert.note}}

  Main channel builds are unsigned.

  主分支开发版渠道的构建是未经签名的。

{{site.alert.end}}
