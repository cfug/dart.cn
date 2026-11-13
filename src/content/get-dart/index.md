---
# title: Get the Dart SDK
title: 获取 Dart SDK
# shortTitle: Get Dart
shortTitle: 获取 Dart
# description: >-
#   Get the libraries and command-line tools that you need to develop
#   Dart web, command-line, and server apps.
description: >-
  获取开发 Dart Web、命令行和服务端应用所需的库和命令行工具。
channelList: [Stable, Beta, Dev]
ai-translated: true
---

This page describes how to download the Dart SDK.
The Dart SDK includes the libraries and command-line tools that
you need to develop Dart command-line, server, and web apps.

本页说明如何下载 Dart SDK。
Dart SDK 包含开发 Dart 命令行、服务端和 Web 应用
所需的库和命令行工具。

The Dart team supports only the latest stable release of the SDK.
For full details on the SDK release lifecycle and supported versions,
check out the [SDK support policy](/tools/sdk#support-policy).

Dart 团队只支持 SDK 的最新稳定版。
关于 SDK 发布周期和支持版本的完整说明，
请查阅 [SDK 支持政策](/tools/sdk#support-policy)。

To learn more about the Dart SDK, consult the [Dart SDK overview](/tools/sdk).

想进一步了解 Dart SDK，请查阅 [Dart SDK 概览](/tools/sdk)。

:::tip
If you've installed or plan to [install the Flutter SDK][install-flutter], it
includes the full Dart SDK. You don't need to install Dart separately and can skip this guide.

如果已经安装或打算 [安装 Flutter SDK][install-flutter]，
其中已经包含完整的 Dart SDK。你不必单独安装 Dart，可以跳过本指南。
:::

## System requirements

## 系统要求

Dart supports the following hardware architectures and platform versions
to develop and run Dart code.

Dart 支持下面这些硬件架构和平台版本，
用来开发和运行 Dart 代码。

{% assign yes = '<span class="material-symbols system-support" style="color: #158477" aria-label="Supported" title="Supported">verified</span>' %}
{% assign no = '<span class="material-symbols system-support" style="color: #D43324" aria-label="Not supported" title="Not supported">dangerous</span>' %}
{% assign dep = '<span class="material-symbols system-support" style="color: #EF6C00" aria-label="Deprecated" title="Deprecated">error</span>' %}
{% assign rem = '<span class="material-symbols system-support" style="color: #E25012" aria-label="Final deprecation" title="Final deprecation">report</span>' %}
{% assign na = '<span class="material-symbols system-support" style="color: #DADCE0" aria-label="Does not exist" title="Does not exist">do_not_disturb_on</span>' %}

| <t>Platform</t><t>平台</t> |   x64   | IA32 (x86) |  Arm32  |  Arm64  | RISC-V (RV64GC) | <t>OS Versions</t><t>操作系统版本</t> |
|----------|:-------:|:----------:|:-------:|:-------:|:---------------:|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Windows  | {{yes}} |   {{no}}   | {{no}}  | {{yes}} |     {{na}}      | [Windows 11][], [Windows 10][]                                                                                                                                                                               |
| Linux    | {{yes}} |   {{no}}   | {{yes}} | {{yes}} |     {{yes}}     | [Debian stable][],<br>[Ubuntu LTS][] under standard support                                                                                                                                                  |
| Linux    | {{yes}} |   {{no}}   | {{yes}} | {{yes}} |     {{yes}}     | [Debian 稳定版][Debian stable]，<br>处于标准支持期的 [Ubuntu LTS][]                                                                                                                                          |
| macOS    | {{yes}} |   {{no}}   | {{na}}  | {{yes}} |     {{na}}      | Latest three versions of macOS:<br>{% for version in supportedMacosVersions limit:3 %}[{{version.codename}}]({{version.link}}) ({{version.cycle}}){%- unless forloop.last -%}, {% endunless -%} {% endfor %} |
| macOS    | {{yes}} |   {{no}}   | {{na}}  | {{yes}} |     {{na}}      | 最近三个 macOS 版本：<br>{% for version in supportedMacosVersions limit:3 %}[{{version.codename}}]({{version.link}}) ({{version.cycle}}){%- unless forloop.last -%}, {% endunless -%} {% endfor %} |

{:.table .table-striped}

{{yes}} Supported on all channels.<br>
{{yes}} 所有渠道均支持。<br>
{{dep}} Support is deprecated and might be dropped in a future Dart release.<br>
{{dep}} 支持已弃用，可能会在未来的 Dart 版本中移除。<br>
{{rem}} Support is deprecated and will likely be removed in the next stable release.<br>
{{rem}} 支持已弃用，很可能会在下一个稳定版中移除。<br>
{{no}} Unsupported on all channels.<br>
{{no}} 所有渠道均不支持。<br>
{{na}} Unsupported by the operating system.<br>
{{na}} 操作系统不支持。<br>

[Windows 10]: https://www.microsoft.com/en-us/software-download/windows10
[Windows 11]: https://www.microsoft.com/en-us/software-download/windows11
[Debian stable]: https://www.debian.org/releases
[Ubuntu LTS]: https://wiki.ubuntu.com/Releases

## Choose an installation option

## 选择一种安装方式

To install and update the Dart SDK from the stable channel,
choose one of the following options:

要从稳定版渠道安装和更新 Dart SDK，
请选择下面的一种方式：

1. [Use a package manager](#install) (Recommended).

   [使用包管理器](#install)（推荐）。

1. Use a [Dart Docker image][dart-docker].

   使用 [Dart Docker 镜像][dart-docker]。

1. [Install Flutter][install-flutter].  
   If you've installed or plan to [install the Flutter SDK][install-flutter],
   it includes the full Dart SDK. The Flutter SDK includes the
   [`dart`](/tools/dart-tool) CLI tool in Flutter's `bin` folder.

   [安装 Flutter][install-flutter]。
   如果已经安装或打算 [安装 Flutter SDK][install-flutter]，
   其中已经包含完整的 Dart SDK。Flutter SDK 在 Flutter 的 `bin` 目录中
   包含 [`dart`](/tools/dart-tool) 命令行工具。

1. Download a ZIP archive from the [SDK Archive](/get-dart/archive).

   从 [SDK 归档](/get-dart/archive) 下载 ZIP 压缩包。

1. [Build the SDK from source][build-source].

   [从源代码构建 SDK][build-source]。

:::warning Notice
{% render 'install/sdk-terms.md' %}

:::warning 公告
:::

{% comment %}
NOTE to editors: Keep the zip file link as the last thing in the paragraph,
so it's easy to find (but not more tempting than package managers).
{% endcomment %}

## Install the Dart SDK {:#install}

## 安装 Dart SDK

To install the Dart SDK,
use the appropriate package manager for your development platform.

要安装 Dart SDK，
请使用适合你的开发平台的包管理器。

To upgrade the Dart SDK,
run the same command to install the Dart SDK from your package manager.

要升级 Dart SDK，
请用包管理器再运行一次安装 Dart SDK 的命令。

<Tabs key="dev-os" wrapped="true">
  <Tab name="Windows">

  {% render 'install/windows.md', site: site %}

  </Tab>
  <Tab name="Linux">

  {% render 'install/linux.md', site: site %}

  </Tab>
  <Tab name="macOS">

  {% render 'install/macos.md', site: site %}

  </Tab>
</Tabs>

## Release channel reference {:#release-channels}

## 发布渠道参考

{% for channel in page.channelList %}
{% assign chnl = channel | downcase -%}
{% assign current="`[calculating]`{:.build-rev-" | append: chnl | append: "}" %}
{% case chnl %}
{% when 'stable' %}
{% assign verstring = "`x.y.z`" %}
{% assign examples = "`1.24.3` and `2.1.0`" %}
{% assign schedule = "every three months" %}
{% assign schedule_zh = "每三个月一次" %}
{% assign version-use = "building and deploying production apps" %}
{% assign version_use_zh = "构建并部署生产应用" %}
{% assign channel_zh = "稳定版" %}
{% when 'beta' %}
{% assign verstring = "`x.y.z-a.b.beta`" %}
{% assign examples = "`2.8.0-20.11.beta` and `3.3.0-205.1.beta`" %}
{% assign verdesc = "pre-release" %}
{% assign verdesc_zh = "预发布" %}
{% assign schedule = "once a month" %}
{% assign schedule_zh = "每月一次" %}
{% assign version-use = "testing your app's compatibility with future stable versions" %}
{% assign version_use_zh = "测试应用与未来稳定版的兼容性" %}
{% assign channel_zh = "测试版" %}
{% when 'dev' %}
{% assign verstring = "`x.y.z-a.b.dev`" %}
{% assign examples = "`2.8.0-20.11.dev` and `3.2.12-15.33.dev`" %}
{% assign verdesc = "development" %}
{% assign verdesc_zh = "开发" %}
{% assign schedule = "twice a week" %}
{% assign schedule_zh = "每周两次" %}
{% assign version-use = "testing recent fixes and experimental features" %}
{% assign version_use_zh = "测试近期修复和实验性功能" %}
{% assign channel_zh = "开发版" %}
{% endcase %}

### {{channel}} channel

### {{channel_zh}}渠道

Dart publishes a new release to the *{{chnl}}* channel about {{schedule}}.
The current {{chnl}} version is {{current}}.

Dart 大约{{schedule_zh}}会向 **{{chnl}}** 渠道发布一个新版本。
当前 {{chnl}} 版本是 {{current}}。

Use **{{chnl}}** channel releases for {{version-use}}.

**{{chnl}}** 渠道的版本用于{{version_use_zh}}。

**{{channel}}** channel release version strings follow a {{verstring}} format:

**{{channel_zh}}**渠道的版本号字符串采用 {{verstring}} 格式：

* `x` : major version

  `x`：主版本号

* `y` : minor version

  `y`：次版本号

* `z` : patch version

  `z`：补丁版本号
{%- if chnl != 'stable' %}
* `a` : {{verdesc}} version

  `a`：{{verdesc_zh}}版本号

* `b` : {{verdesc}} patch version

  `b`：{{verdesc_zh}}补丁版本号
{% endif %}

Examples of {{chnl}} channel version strings include {{examples}}.

{{chnl}} 渠道版本号字符串的例子包括 {{examples}}。

To install a {{chnl}} channel release,
{%- if chnl != 'stable' %}
download the [SDK as a zip file][dl-sdk].
{%- else %}
follow the [instructions on this page](#install).
{% endif %}

要安装 {{chnl}} 渠道的版本，
{%- if chnl != 'stable' %}
请下载 [zip 格式的 SDK][dl-sdk]。
{%- else %}
请按照 [本页的说明](#install) 操作。
{% endif %}

{% endfor -%}

[build-source]: {{site.repo.dart.sdk}}/wiki/Building
[dart-docker]: https://hub.docker.com/_/dart
[dl-sdk]: /get-dart/archive
[install-flutter]: {{site.flutter-docs}}/get-started/install
