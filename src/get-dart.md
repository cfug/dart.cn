---
title: Get the Dart SDK
title: 获取 Dart SDK
description: Get the Dart SDK
description: 获取 Dart SDK
js:
- url: /tools/sdk/archive/assets/install.js
  defer: true
---

The Dart SDK has the libraries and command-line tools that you need to develop
Dart web, command-line, and server apps.
If you're developing only mobile apps,
then you don't need the Dart SDK; just [install Flutter.][flutter]

Dart SDK 包含开发 Web ，命令行，服务端应用所需要的库和命令行工具，
如果仅需要开发移动端应用，只要[安装 Flutter][flutter] 即可，不需要 Dart SDK 。

To learn about other tools you can use for Dart development, see
the [Dart tools]({{site.dartlang}}/tools) page.

要了解 Dart 开发中的其他可用工具，请参阅 [Dart 工具]({{site.dartlang}}/tools) 。

To learn about what's in the SDK, see [Dart SDK overview](/tools/sdk).

要了解 SDK 中的内容，请参阅[Dart SDK 概述](/tools/sdk)。

<aside class="alert alert-info" markdown="1">
  **Note:** This site's documentation and examples use
  {% if site.data.pkg-vers.SDK.channel == 'dev' %} the **dev channel** {% endif -%}
  version [{{site.data.pkg-vers.SDK.vers}}][site SDK version]{:.no-automatic-external}
  of the **Dart SDK**.

  **Note:** 
  注意：本网站的文档和示例基于
  {% if site.data.pkg-vers.SDK.channel == 'dev' %} **开发版** 的{% endif -%}
  **Dart SDK**[{{site.data.pkg-vers.SDK.vers}}][site SDK version]{:.no-automatic-external} 版本。
</aside>

## Install the Dart SDK {#install}

## 安装 Dart SDK {#install}

As the following instructions show,
you can use a package manager
to easily install and update the Dart SDK.
Alternatively, you can
[build the SDK from source][] or
[download the SDK as a zip file]({{site.dartlang}}/tools/sdk/archive).

如下介绍，可以使用包管理器轻松的安装更新 Dart SDK。也可以，从源代码 [构建 SDK ][build the SDK from source] 或者 [下载 SDK zip 包文件]({{site.dartlang}}/tools/sdk/archive)。

{% comment %}
NOTE to editors: Keep the zip file link as the last thing in the paragraph,
so it's easy to find (but not more tempting than package managers).
{% endcomment %}

<aside class="alert alert-warning" markdown="1">
  {% include_relative tools/sdk/archive/_sdk-terms.md %}
</aside>

<ul class="tabs__top-bar">
  <li class="tab-link current" data-tab="tab-sdk-install-windows">Windows</li>
  <li class="tab-link" data-tab="tab-sdk-install-linux">Linux</li>
  <li class="tab-link" data-tab="tab-sdk-install-mac">Mac</li>
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

## About release channels and version strings

## 关于发布渠道和版本号

The Dart SDK has two release channels:

Dart SDK 有两个发布渠道：

* **stable** channel: **stable releases**,
  updated no more frequently than every 6 weeks;
  currently `[calculating]`{:.editor-build-rev-stable}.

  **稳定版** 渠道： **稳定发行版**，每六周更新一次；
  当前版本 `[calculating]`{:.editor-build-rev-stable}.

* **dev** channel: **pre-releases**, usually updated 1/week;
  currently `[calculating]`{:.editor-build-rev-dev}.

  **开发版** 渠道： **预览发行版**，通常每周更新一次；
  当前版本 `[calculating]`{:.editor-build-rev-dev}.

<aside class="alert alert-warning" markdown="1">
  **Warning:**

  **警告：**

  To give you early access to new features and fixes,
  dev channel releases are not as heavily tested as the stable release.

  为了让开发者能够及早了解新功能和修复程序，发行的开发版并未经过像稳定版那样的严格测试。
</aside>


**Stable** channel releases of the Dart SDK have version strings like `1.24.3` and `2.1.0`.
They consist of dot-separated integers, with no hyphens or letters.

**稳定版** 通道发行的 Dart SDK 版本具有 `1.24.3` 或 `2.1.0` 的版本号描述。
版本号是由点分隔的整数组成，不会包含连接符或字符。

**Dev** channel releases of the Dart SDK (pre-releases)
have additional characters, starting with a hyphen (`-`).
For example, Dart 2 pre-releases have version numbers starting with
`2.0.0-dev` such as `2.0.0-dev.69.5`.

**开发版** 通道发行的 Dart SDK 版本（预览发行版）版本号中包含以连接符开始的其他字符。
例如：Dart 2 预览发行版的版本号 `2.0.0-dev.69.5` 是以 `2.0.0-dev` 开始，并附加数字版本。

For more information, see the [Dart 2 page.][Dart 2]

更多内容, 参见[ Dart 2 章节][Dart 2]。

[SDK constraints]: /tools/pub/pubspec#sdk-constraints
[semantic versioning]: http://semver.org/
[Dart 2]: {{site.dartlang}}/dart-2
[build the SDK from source]: https://github.com/dart-lang/sdk/wiki/Building
[Dart libraries]: {{site.dartlang}}/guides/libraries/library-tour
[flutter]: https://flutter.dev/docs/get-started/install
[site SDK version]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/{{site.data.pkg-vers.SDK.vers}}/index.html
