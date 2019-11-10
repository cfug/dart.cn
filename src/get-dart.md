---
title: Get the Dart SDK
title: 获取 Dart SDK
description: Get the libraries and command-line tools that you need to develop Dart web, command-line, and server apps.
description: 获得 Dart 命令行工具和库，用以编写 Dart web，命令行以及服务端应用。
js:
- url: /tools/sdk/archive/assets/install.js
  defer: true
---

The Dart SDK has the libraries and command-line tools that you need to develop
Dart web, command-line, and server apps.
If you're developing only mobile apps,
then you don't need the Dart SDK; just [install Flutter.][flutter]

Dart SDK 包含开发 Web、命令行和服务端应用所需要的库和命令行工具。如果你只是想开发移动应用，则不需要使用 Dart SDK，只需 [安装 Flutter][flutter] 即可

To learn about other tools you can use for Dart development, see
the [Dart tools]({{site.dartlang}}/tools) page.

要了解在 Dart 开发中你可以使用的其它工具，请查阅 [Dart 工具]({{site.dartlang}}/tools)。

To learn about what's in the SDK, see [Dart SDK overview](/tools/sdk).

要了解 SDK 中的内容，请参阅 [Dart SDK 概述](/tools/sdk)。

<aside class="alert alert-info" markdown="1">
  **Note:** This site's documentation and examples use
  {% if site.data.pkg-vers.SDK.channel == 'dev' %} the **dev channel** {% endif -%}
  version [{{site.data.pkg-vers.SDK.vers}}][site SDK version]{:.no-automatic-external}
  of the **Dart SDK**.

  **注意：**本网站的文档和示例使用的是 _Dart SDK_ 的 {% if site.data.pkg-vers.SDK.channel == 'dev' %} _dev channel_ {% endif -%} 版本 [{{site.data.pkg-vers.SDK.vers}}][site SDK version]{:.no-automatic-external}
</aside>


To learn about what's in the SDK, see [Dart SDK overview](/tools/sdk).

请查阅 [Dart SDK 概览](/tools/sdk) 获取更多关于 SDK 中包含哪些内容的信息。

## Install the Dart SDK {#install}

## 安装 Dart SDK {#install}

As the following instructions show,
you can use a package manager
to easily install and update the Dart SDK.
Alternatively, you can
[build the SDK from source][] or
[download the SDK as a zip file]({{site.dartlang}}/tools/sdk/archive).

如下所述，你可以使用包管理轻松地安装和更新 Dart SDK。你也可以 [下载 SDK 的 zip 压缩文件]({{site.dartlang}}/tools/sdk/archive) 并以 [编译 SDK 源码][build the SDK from source] 的形式安装或更新 SDK。

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

## 关于发行渠道和版本字符串

The Dart SDK has two release channels:

Dart SDK 有两个发行渠道：

* **stable** channel: **stable releases**,
  updated no more frequently than every 6 weeks;
  currently `[calculating]`{:.editor-build-rev-stable}.

  **稳定版**渠道：**稳定发行版**，每六周更新一次；当前版本 `[calculating]`{:.editor-build-rev-stable}.

* **dev** channel: **pre-releases**, usually updated 1/week;
  currently `[calculating]`{:.editor-build-rev-dev}.

  **开发版**渠道：**预览发行版**，通常每周更新一次；当前版本 `[calculating]`{:.editor-build-rev-dev}.

<aside class="alert alert-warning" markdown="1">
  **Warning:**

  **警告：**

  To give you early access to new features and fixes,
  dev channel releases are not as heavily tested as the stable release.

  为了能让你及早地了解到新的功能以及 BUG 修复，dev channel 版本并不会像稳定版那样经过很多的测试。
</aside>


**Stable** channel releases of the Dart SDK have version strings like `1.24.3` and `2.1.0`.
They consist of dot-separated integers, with no hyphens or letters.

**稳定版**的 Dart SDK 版本号类似 `1.24.3` 或 `2.1.0`。其由点分隔开的整数组成，并不会包含其它字符。

**Dev** channel releases of the Dart SDK (prereleases)
have additional characters, starting with a hyphen (`-`).
For example, Dart 2 prereleases have version numbers starting with
`2.0.0-dev` such as `2.0.0-dev.69.5`.

**开发版**的 Dart SDK（正式预览版）版本号中包含以连接符开始的其他字符。例如：Dart 2 预览发行版的版本号 `2.0.0-dev.69.5` 是以 `2.0.0-dev` 开始，并附加数字版本。

You can get stable and dev channel releases using
the [instructions above](#install), or you can
[download the SDK as a zip file](/tools/sdk/archive).

你可以通过 [instructions above](#install) 获得 stable 和 dev 渠道，
或者你也可以直接[下载 SDK 的压缩包](/tools/sdk/archive)。

For more information, see the [Dart 2 page.][Dart 2]

你可以查阅 [Dart 2 相关页面][Dart 2] 获取更多信息。

[SDK constraints]: /tools/pub/pubspec#sdk-constraints
[Dart 2]: /dart-2
[build the SDK from source]: https://github.com/dart-lang/sdk/wiki/Building
[Dart libraries]: /guides/libraries/library-tour
[flutter]: https://flutter.dev/docs/get-started/install
[site SDK version]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/{{site.data.pkg-vers.SDK.vers}}/index.html
