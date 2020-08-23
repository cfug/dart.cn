---
title: IntelliJ & Android Studio
title: 使用 IntelliJ 和 Android Studio 开发 Dart 应用
description: Use Dart with a variety of IDEs and editors from JetBrains.
description: 使用由 JetBrains 开发的各种 IDE 和编辑器开发 Dart 应用。
---

The Dart plugin adds Dart support to JetBrains IDEs such as
IntelliJ IDEA and Android Studio.
IntelliJ IDEA is an intelligent Java IDE
with support for many other languages and frameworks.
Android Studio is an IDE based on IntelliJ IDEA
that's used for Android and Flutter development.

Dart 插件为类似 IntelliJ IDEA 和 Android Studio
这样 JetBrains 的 IDE 提供了 Dart 支持。
IntelliJ IDEA 是一款优秀的 Java IDE，
除此之外它还支持许多其它的语言和框架。
Android Studio 是一款基于 IntelliJ IDEA 的 IDE，
其常用作开发 Android 和 Flutter。

Whichever JetBrains IDE you choose for Dart development,
this page has resources to help you get started quickly
and find more information when you need it.

不管你选择哪一款 JetBrains 的 IDE 用于 Dart 开发，
本文所包含的资源都可以帮助你快速入门并在你需要时给你提供更多的信息。

<aside class="alert alert-info" markdown="1">

  **Note:**
  [WebStorm,](https://www.jetbrains.com/webstorm/)
  a JetBrains IDE for client-side development,
  comes with the Dart plugin pre-installed.

  **注意：** JetBrains 专门针对客户端开发的另一款 IDE
  [WebStorm](https://www.jetbrains.com/webstorm/) 则已经预装了 Dart 插件。
</aside>

## Getting started

## 入门

If you don't already have the IDE and the Dart SDK, get them.
Then install the Dart plugin and tell it where to find the Dart SDK.

如果你还没有 IDE 和 Dart SDK，请先下载。然后安装相应的 Dart 插件并配置 Dart SDK 的路径。

### Downloading the IDE

### 下载 IDE

Install a JetBrains IDE if you don't already have one.

如果你还没有一款 JetBrains 的 IDE，请先安装。

* <a href="https://www.jetbrains.com/idea/download/"
  target="_blank" rel="noopener">Download IntelliJ IDEA</a> or,
  to try out the latest Dart language features,
  [install IntelliJ IDEA EAP.](https://confluence.jetbrains.com/display/IDEADEV/EAP)

  <a href="https://www.jetbrains.com/idea/download/" target="_blank" rel="noopener">下载 IntelliJ IDEA</a>
  或尝试试用最新的 Dart 语言特性，
  [请安装 IntelliJ IDEA EAP](https://confluence.jetbrains.com/display/IDEADEV/EAP)。

* Or <a href="https://www.jetbrains.com/products.html"
  target="_blank" rel="noopener">find another JetBrains product.</a>

  或者 <a href="https://www.jetbrains.com/products.html" target="_blank" rel="noopener">查找其它的 JetBrains 产品。</a>

<aside class="alert alert-info" markdown="1">

  **Note:**
  The Community Edition of IntelliJ IDEA has limited functionality.
  For example, it doesn't directly support debugging web apps.
  It also has very little support for JavaScript, HTML, CSS, and YAML.

  **注意：**
  IntelliJ IDEA 的社区版有功能限制。例如，它不直接支持调试 Web 应用。它对 JavaScript、HTML、CSS 和 YAML 的支持也很少。
</aside>


### Downloading the Dart SDK

### 下载 Dart SDK

If you don't already have the Dart SDK,
install it.
You can get it either by itself or by downloading the Flutter SDK,
which (as of Flutter 1.21) includes the Dart SDK.

如果你还没有安装 Dart SDK，安装一下。
你可以选择下载 Dart SDK 或者下载安装 Flutter SDK，
在 Flutter 1.21 和之后的版本，Flutter SDK 已经包含了完整的 Dart SDK 。

Choose one:

选一个吧：

* [Download the Dart SDK](/get-dart)
 
  [下载 Dart SDK](/get-dart)

* [Download the Flutter SDK]({{site.flutter}}/docs/get-started/install)

  [下载 Dart SDK](/get-dart)


### Configuring Dart support

### 配置以支持 Dart 开发

Here's one way to configure Dart support:

下面是配置以支持 Dart 开发的一种方式：

<ol>
<li>
  <p>
    Start the IDE, and install the <b>Dart</b> plugin.
    To find the Dart plugin, from the Welcome screen
    choose <b>Configure > Plugins</b>,
    then click <b>Install JetBrains plugin</b>,
    and then search or scroll down until you find <b>Dart</b>.
    Once you've installed the Dart plugin, restart the IDE.

    启动 IDE 并安装 <b>Dart</b> 插件。你可以从欢迎界面窗口的 
    <b>Configure > Plugins</b> 菜单进入到插件设置界面，
    然后点击 <b>Install JetBrains plugin</b> 并搜索或拖动滚动条
    直到你找到 <b>Dart</b>。
    安装好 Dart 插件后记得重启 IDE。
  </p>
</li>

<li>
  <p>
    Create a new Dart project:

    创建新的 Dart 项目：
  </p>

  <ol type="a">
    <li> From the Welcome screen, click <b>Create New Project</b>. </li>

    <li> 在欢迎窗口界面点击 <b>Create New Project</b>。 </li>

    <li> In the next dialog, click <b>Dart</b>.</li>

    <li> 在接下来的对话框中点击 <b>Dart</b>。</li>
  </ol>
</li>
<br>

<li>
  <p>
    If you don't see a value for the <b>Dart SDK</b> path,
    enter it.

    如果 <b>Dart SDK</b> 路径为空请先设置。
  </p>

  <p>
    For example, the SDK path might be
    <code><em>&lt;dart installation directory></em>/dart/dart-sdk</code>.

    例如，SDK 的路径可能是 <code><em>&lt;Dart 安装目录></em>/dart/dart-sdk</code>.
  </p>

<aside class="alert alert-info" markdown="1">
  <b>Note:</b>
  The <b>Dart SDK</b> path specifies the directory that
  contains the SDK's `bin` and `lib` directories;
  the `bin` directory contains tools such as `dart` and `dartfmt`.
  The IDE ensures that the path is valid.

  <b>注意：</b>
  <b>Dart SDK</b> 路径为包含了 `bin` 和 `lib` 目录的路径；
  `bin` 目录中包含了类似 `dart` 和 `dartfmt` 的工具。
  需要确保 IDE 路径有效。
</aside>
</li>
</ol>

An alternative to Step 2 is to open an existing Dart project,
and then open its `pubspec.yaml` file or any of its Dart files.

如果你已经创建过 Dart 项目，则可以在第二步的时候选择打开该项目，
然后选择打开 `pubspec.yaml` 或其它 Dart 文件。

{% comment %}

NOTE TO EDITORS OF THIS FILE:
[PENDING: put instructions here on how to reset to the initial
IntelliJ experience.
It probably involves deleting the IDE settings
by removing a directory.

{% endcomment %}


## Reporting issues

## 上报问题

{% include tools/jetbrains-reporting-issues.html %}


## More information

## 更多信息

See the JetBrains website for more information.

你可以查看 JetBrains 网站获取更多的信息。

* [IntelliJ IDEA](https://www.jetbrains.com/idea/)
  * [Dart PhpStorm Help](https://www.jetbrains.com/help/phpstorm/dart.html)

    [Dart PhpStorm 帮助](https://www.jetbrains.com/help/phpstorm/dart.html)

  * [Features](https://www.jetbrains.com/idea/features/)

    [特点](https://www.jetbrains.com/idea/features/)

  * [Quick start](https://www.jetbrains.com/help/idea/meet-intellij-idea.html)

    [快速开始](https://www.jetbrains.com/help/idea/meet-intellij-idea.html)

* [Dart Plugin by JetBrains](https://plugins.jetbrains.com/plugin/6351)

  [JetBrains 出品的 Dart 插件](https://plugins.jetbrains.com/plugin/6351)

* [Eclipse to IntelliJ migration guide](https://www.jetbrains.com/help/idea/eclipse.html)

  [从 Eclipse 迁移至 IntelliJ 的指南](https://www.jetbrains.com/help/idea/eclipse.html)
