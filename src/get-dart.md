---
title: Get the Dart SDK
title: 获取 Dart SDK
description: Get the libraries and command-line tools that you need to develop Dart web, command-line, and server apps.
description: 获得 Dart 命令行工具和库，用以编写 Dart web，命令行以及服务端应用。
js:
- url: /tools/sdk/archive/assets/install.js
  defer: true
---

This page describes how to download the Dart SDK.
The Dart SDK has the libraries and command-line tools that you need to develop
Dart command-line, server, and non-Flutter web apps.
For details, see the [Dart SDK overview](/tools/sdk).

本页面指引你如何下载 Dart SDK。
Dart SDK 包含开发 Web、命令行和服务端应用所需要的库和命令行工具。
更多详细内容，请参考 [Dart SDK 概览](/tools/sdk) 文档。

**As of Flutter 1.21, the [Flutter SDK][flutter] includes the full Dart SDK.**
So if you have Flutter installed,
you might not need to explicitly download the Dart SDK.
Consider downloading the Dart SDK if
any of the following are true:

**从 Flutter 1.21 版本开始，[Flutter SDK][flutter] 会同时包含完整的 Dart SDK**
因此如果你已经安装了 Flutter，可能就无需再特别下载 Dart SDK 了。
如果你有下述的需求，请考虑下载 Dart SDK：

* You don't use Flutter.

  不需要使用 Flutter；
  
* You use a pre-1.21 version of Flutter.

  使用 Flutter 1.21 之前的版本；
  
* You want to reduce disk space requirements or download time,
  and your use case doesn't require Flutter.
  For example, you might have a continuous integration (CI)
  setup that requires Dart but not Flutter.

  希望降低电脑存储空间的使用，此次用例并不需要 Flutter，比如：
  设置 CI 时，需要 Dart 并不需要 Flutter。

## Installing the Dart SDK {#install}

## 安装 Dart SDK {#install}

As the following instructions show,
you can use a package manager
to easily install and update a stable channel Dart SDK.
Alternatively, you can
[build the SDK from source][] or install from
[any release channel](#release-channels) by
[downloading the SDK as a zip file][].

如下所述，你可以使用包管理轻松地安装和更新 Dart SDK。
你也可以 以 [编译 SDK 源码][build the SDK from source] 的形式安装，
也可以在我们的 [各个发布渠道里](#release-channels) 
[下载 SDK 的 zip 压缩文件][downloading the SDK as a zip file] 。

{% comment %}
NOTE to editors: Keep the zip file link as the last thing in the paragraph,
so it's easy to find (but not more tempting than package managers).
{% endcomment %}

{{site.alert.warn}}
  {% include_relative tools/sdk/archive/_sdk-terms.md %}
{{site.alert.end}}

<ul class="tabs__top-bar">
  <li class="tab-link current" data-tab="tab-sdk-install-windows">Windows</li>
  <li class="tab-link" data-tab="tab-sdk-install-linux">Linux</li>
  <li class="tab-link" data-tab="tab-sdk-install-mac">macOS</li>
</ul>
<div id="tab-sdk-install-windows" class="tabs__content current" markdown="1">
{% include_relative tools/sdk/_windows.md %}
</div>
<div id="tab-sdk-install-linux" class="tabs__content" markdown="1">
{% include_relative tools/sdk/_linux.md %}
</div>
<div id="tab-sdk-install-mac" class="tabs__content" markdown="1">
{% include_relative tools/sdk/_mac.md %}
</div>

## System requirements

## 系统要求

The Dart SDK is supported on Windows, Linux, and macOS.

Dart SDK 支持 Windows、Linux 和 macOS。

### Windows

* **Supported versions:** Windows 10.

  **支持的版本：**Windows 10。

* **Supported architectures:** x64, ia32.

  **支持的架构：**x64、ia32。

### Linux

* **Supported versions:** Recent Linux versions, but only Ubuntu 16.04 is tested.

  **支持的版本：**最新的 Linux 版本，仅在 Ubuntu 16.04 上进行了测试。

* **Supported architectures:** x64, ia32, arm, arm64.

  **支持的架构：**x64、ia32、arm、arm64。

{{ site.alert.note }}

  The arm support requires glibc 2.23 or newer due to a
  [dynamic linker bug](https://sourceware.org/bugzilla/show_bug.cgi?id=14341).

  由于 [动态链接的缺陷](https://sourceware.org/bugzilla/show_bug.cgi?id=14341)，
  Arm 的支持需要使用 glibc 2.23 或更新的版本。

{{ site.alert.end }}

### macOS

* **Supported versions:** Latest three major versions.
  As of April 2021, the following versions are supported:
  - macOS 10.14 (Mojave)
  - macOS 10.15 (Catalina)
  - macOS 11 (Big Sur)

  **支持的版本：**最新的三个主要版本。
  截止 2021 年 4 月，支持以下版本：
  - macOS 10.14 (Mojave)
  - macOS 10.15 (Catalina)
  - macOS 11 (Big Sur)

* **Supported architectures:** x64.
  Support for arm64 is [in progress](https://github.com/dart-lang/sdk/issues/42773).

  **支持的架构：**x64。
  针对 arm64 的支持正在
  [进行中](https://github.com/dart-lang/sdk/issues/42773)。

## About release channels and version strings {#release-channels}

## 关于发行渠道和版本字符串

The Dart SDK has three release channels:

Dart SDK 有三个发布渠道：

* **Stable** channel: **stable releases**, updated roughly every three months;
  currently `[calculating]`{:.editor-build-rev-stable}.

  稳定版 (Stable)渠道：**稳定发行版**，每 **三个月** 更新一次；
  当前版本 `[calculating]`{:.editor-build-rev-stable}.
  
  Stable releases are suitable for production use.
  
  稳定版可适用于生产环节。
  
* **Beta** channel: **preview releases**, usually updated every month;
  currently `[calculating]`{:.editor-build-rev-beta}.

  测试版 (Beta) 渠道：也称 **发行预览版**，通常 **每月** 更新一次；
  当前版本 `[calculating]`{:.editor-build-rev-dev}.
  
  Beta channel builds are preview builds for the stable channel. We recommend
  testing, but not releasing, your apps against beta to preview new features or
  test compatibility with future releases.
  
  测试版渠道的构建是稳定版渠道的“预览版构建”。我们推荐您使用这个渠道的 SDK、
  进行测试，但是不建议您的应用发布，您可以用这个渠道的构建
  预览新功能或测试与未来版本的兼容性。
  
* **Dev** channel: **prereleases**, usually updated twice a week;
  currently `[calculating]`{:.editor-build-rev-dev}.

  开发版 (Dev)渠道：也称 **预发行版**，通常每 **双周** 更新一次；
  当前版本 `[calculating]`{:.editor-build-rev-dev}.
  
  Dev channel releases are the most current with latest changes, may be broken,
  are unsupported, and may contain unvetted breaking changes.
  
  开发版渠道的构建包含最新的更新，也可能本身就是不完善的，这个版本我们不受支持，
  并且可能会包含未经审核的重大更改 (breaking changes)。

**Stable** channel releases of the Dart SDK have `x.y.z` version strings like
`1.24.3` and `2.1.0`. They consist of dot-separated integers, with no hyphens or
letters, where `x` is the major version, `y` is the minor version, and `z` is
the patch version.

Dart SDK **稳定版** 构建渠道的版本号设定为 `x.y.z`，比如 `1.24.3` 和 `2.1.0`。
它们由点分隔的整数组成，没有连字符或字母，
其中 `x` 是主版本，`y` 是次要版本，而 `z` 是补丁版本。

**Beta** and **dev** channel releases of the Dart SDK (non-stable releases) have
`x.y.z-a.b.<beta|dev>` versions like `2.8.0-20.11.beta`. The part before the
hyphen follows the stable version scheme, `a` and `b` after the hyphen are the
prerelease and prerelease patch versions, and `beta` or `dev` is the channel.

Dart SDK 的非稳定版 (**测试版 (Beta)** 和 **开发版 (Dev)**) 构建渠道
的版本号设定为：`x.y.z-a.b.<beta|dev>`，比如：`2.8.0-20.11.beta`。
连字符前的部分 (`x.y.z`) 遵循稳定版本方案，
连字符后的 `a` 和 `b` 分别是预发行版和预发行补丁版本，
而 `beta` 或 `dev` 是构建渠道通道标示。

You can get stable channel releases using
the [instructions above](#install), or you can
get stable, beta, or dev channel releases
using [a package manager][]
or by [downloading the SDK as a zip file][].

你可以通过 [instructions above](#install) 获得 stable 和 dev 渠道，
或者你也可以直接[下载 SDK 的压缩包](/tools/sdk/archive)。

For more information, see the [Dart 2 page.][Dart 2]

你可以查阅 [Dart 2 相关页面][Dart 2] 获取更多信息。

[SDK constraints]: /tools/pub/pubspec#sdk-constraints
[Dart 2]: /dart-2
[build the SDK from source]: https://github.com/dart-lang/sdk/wiki/Building
[Dart libraries]: /guides/libraries/library-tour
[downloading the SDK as a zip file]: /tools/sdk/archive
[flutter]: https://flutter.cn/docs/get-started/install
[site SDK version]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/{{site.data.pkg-vers.SDK.vers}}/index.html
[a package manager]: https://github.com/dart-lang/sdk/wiki/Installing-beta-and-dev-releases-with-brew,-choco,-and-apt-get
