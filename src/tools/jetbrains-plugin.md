---
title: IntelliJ & Android Studio
title: 使用 IntelliJ 和 Android Studio 开发 Dart 应用
description: Use Dart with a variety of IDEs and editors from JetBrains.
description: 使用由 JetBrains 开发的各种 IDE 和编辑器开发 Dart 应用。
---

The [Dart plugin][] adds Dart support to JetBrains IDEs such as
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

{{site.alert.note}}

  [WebStorm,](https://www.jetbrains.com/webstorm/)
  a JetBrains IDE for client-side development,
  comes with the Dart plugin pre-installed.
  
   **注意：** JetBrains 专门针对客户端开发的另一款 IDE
  [WebStorm](https://www.jetbrains.com/webstorm/) 则已经预装了 Dart 插件。
  
{{site.alert.end}}

## Getting started

## 入门

If you don't already have the IDE and the Dart SDK, get them.
Then install the Dart plugin and tell it where to find the Dart SDK.

如果你还没有 IDE 和 Dart SDK，请先下载。然后安装相应的 Dart 插件并配置 Dart SDK 的路径。

### Downloading the IDE

### 下载 IDE

Install a JetBrains IDE if you don't already have one. Choose one:

如果你还没有一款 JetBrains 的 IDE，请选择一款：

* [IntelliJ IDEA][IDEA]{:target="_blank" rel="noopener"}

  [下载 IntelliJ IDEA][IDEA]{:target="_blank" rel="noopener"}
  
* [IntelliJ IDEA EAP][IDEA EAP]{:target="_blank" rel="noopener"}
  (for early access to the latest Dart language features and IntelliJ functionality)

  [下载 IntelliJ IDEA EAP][IDEA EAP]{:target="_blank" rel="noopener"}
  早期产品试用，尝试使用最新的 Dart 语言特性，

* [Another JetBrains product][Other]{:target="_blank" rel="noopener"}

  [查找其它的 JetBrains 产品][Other]{:target="_blank" rel="noopener"}

[IDEA]: https://www.jetbrains.com/idea/download/
[IDEA EAP]: https://www.jetbrains.com/idea/nextversion/
[Other]: https://www.jetbrains.com/products.html

{{site.alert.note}}
  
  The Community Edition of IntelliJ IDEA has limited functionality.
  For example, it doesn't directly support debugging web apps.
  It also has very little support for JavaScript, HTML, CSS, and YAML.
  
  IntelliJ IDEA 的社区版有功能限制。例如，它不直接支持调试 Web 应用。
  它对 JavaScript、HTML、CSS 和 YAML 的支持也很少。
  
{{site.alert.end}}


### Downloading the Dart SDK

### 下载 Dart SDK

If you don't already have the Dart SDK,
install it.
You can get it either by itself or by downloading the Flutter SDK,
which includes the full Dart SDK.

如果你还没有安装 Dart SDK，安装一下。
你可以选择下载 Dart SDK 或者下载安装 Flutter SDK，
Flutter SDK 已经包含了完整的 Dart SDK 。

Choose one:

选一个吧：

* [Download the Dart SDK](/get-dart)

  [下载 Dart SDK](/get-dart)

* [Download the Flutter SDK]({{site.flutter-docs}}/get-started/install)

  [下载 Flutter SDK]({{site.flutter_docs}}/get-started/install)


### Configuring Dart support

### 配置以支持 Dart 开发

Here's one way to configure Dart support:

下面是配置以支持 Dart 开发的一种方式：

<ol>
<li>
  <p>
    Start the IDE, and install the <b>Dart</b> plugin.
  </p>
  <p>
    启动 IDE 并安装 <b>Dart</b> 插件。
  </p>

  <ol type="a">
    <li>From the Welcome screen, choose <b>Plugins</b>.
    
    在欢迎界面窗口，选择 <b>Plugins</b>/
    </li>
    <li>Search for <b>Dart</b>.
    
    搜索 <b>Dart</b> 关键字。
    </li>
    <li>Once you've installed the Dart plugin, restart the IDE.
    
    安装好 Dart 插件后，记得重启 IDE。
    </li>
  </ol>
</li>
<br>

<li>
  <p>
    Create a new Dart project:
  </p>
  <p>
    创建新的 Dart 项目：
  </p>

  <ol type="a">
    <li>
    From the Welcome screen, click <b>New Project</b>.
    
    在欢迎窗口界面，点击 <b>New Project</b>。
    </li>
    <li>
    In the next dialog, click <b>Dart</b>.
    
    在接下来的对话框中点击 <b>Dart</b>。
    </li>
  </ol>
</li>
<br>

<li>
  <p>
    If you don't see a value for the <b>Dart SDK</b> path,
    enter it.
  </p>
  <p>
    如果 <b>Dart SDK</b> 路径为空请先设置。
  </p>

  <p>
    For example, the SDK path might be
    <code><em>&lt;dart installation directory></em>/dart/dart-sdk</code>.
  </p>
  <p>
    例如，SDK 的路径可能是 <code><em>&lt;Dart 安装目录></em>/dart/dart-sdk</code>.
  </p>

  {{site.alert.note}}
  
    The **Dart SDK** specifies the directory that
    contains the SDK's `bin` and `lib` directories;
    the `bin` directory contains tools such as `dart` and `dartaotruntime`.
    The IDE ensures that the path is valid.
    
    **Dart SDK** 路径为包含了 `bin` 和 `lib` 目录的路径；
    `bin` 目录中包含了类似 `dart` 和 `dartfmt` 的工具。
    IDE 需要确保路径有效。
  
  {{site.alert.end}}
</li>

<li>
  <p>
    Choose a starting template.
  </p>
  <p>
    选择一个起步模版 (starting template)。
  </p>

  <ol type="a">
    <li>To enable starting templates, click <b>Generate sample content</b>.
    
    为了启用起步模版，点击 <b>Generate sample content</b>。
    </li>
    <li>Pick your desired template.
    
    选择你希望使用的模版。
    </li>
  </ol>

  {{site.alert.info}}
    
    The provided templates are supplied and created
    by [`dart create`](/tools/dart-create).
    
    模版由 [`dart create`](/tools/dart-create) 命令提供和创建。
    
  {{site.alert.end}}
</li>

<li>
  <p>Click <b>Next</b> and continue project setup.</p>
  <p>点击 <b>Next</b> 继续进行工程设置</p>
</li>
</ol>

An alternative to Step 2 is to open an existing Dart project,
and then open its `pubspec.yaml` file or any of its Dart files.

如果你已经创建过 Dart 项目，则可以在第二步的时候选择打开该项目，
然后选择打开 `pubspec.yaml` 或其它 Dart 文件。

## Reporting issues

## 上报问题

Please report issues and feedback via the official
[JetBrains issue tracker for Dart.][]

请通过 [JetBrains 关于 Dart 的问题追踪器][JetBrains issue tracker for Dart.]
来报告错误或者提供反馈。

Include details of the expected behavior, the actual behavior,
and screenshots if appropriate.

错误报告包括预期行为、实际行为的细节。
如果合适的话，建议提供合适的屏幕截图。

[JetBrains issue tracker for Dart.]: https://youtrack.jetbrains.com/issues/WEB?q=Subsystem:%20Dart

## More information

## 更多信息

See the JetBrains website for more information.

你可以查看 JetBrains 网站获取更多的信息。

* [IntelliJ IDEA](https://www.jetbrains.com/idea/)
  * [Dart WebStorm Help](https://www.jetbrains.com/help/webstorm/dart.html)
  * [Features](https://www.jetbrains.com/idea/features/)
  * [Quick start](https://www.jetbrains.com/help/idea/getting-started.html)
* [Dart Plugin by JetBrains][Dart plugin]
* [Eclipse to IntelliJ migration guide](https://www.jetbrains.com/help/idea/migrating-from-eclipse-to-intellij-idea.html)

[Dart plugin]: https://plugins.jetbrains.com/plugin/6351-dart/
