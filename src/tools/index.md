---
title: Tools
title: Dart 的开发工具
description: The tools that support the Dart language.
description: 支持 Dart 语言的开发工具。
---

When you're ready to create an app,
get the SDK and tools for your app type.
If you aren't sure which tools you need, **get the Flutter SDK.**

当你准备好创建一个应用时，请根据你要创建的应用类型获取相应的 SDK 和工具。

<div class="table-wrapper" markdown="1">
|------------+-----------------------------------+--------------------------|
| App type   | Get started instructions          | Tool information         |
|   应用类型 |             入门说明              |          工具信息        |
|------------|-----------------------------------|--------------------------|
| Flutter (mobile and more) | [Install Flutter]({{site.flutter}}/setup) | [Flutter tools]({{site.flutter}}/using-ide) |
| Flutter (移动应用和其他平台) | [安装 Flutter]({{site.flutter}}/setup) | [Flutter tools]({{site.flutter}}/using-ide) |
| Web app (non-Flutter) | [Install the Dart SDK](/tools/sdk) | [General-purpose tools][] and [web tools](#web) |
| Web 应用 (非 Flutter) | [安装 Dart SDK](/tools/sdk) | [通用工具][General-purpose tools] and [Web 工具](#web) |
| Server or command line | [Install the Dart SDK](/tools/sdk) | [General-purpose tools][] and [specialized tools](#server) |
| 服务器或命令行应用 | [安装 Dart SDK](/tools/sdk) | [通用工具][General-purpose tools] 和 [专业工具](#server) |
{:.table .table-striped}
</div>

[General-purpose tools]: #general-purpose-tools

{{site.alert.version-note}}

  As of Flutter 1.21, the Flutter SDK includes the Dart SDK.
  
  从 Flutter 1.21 版本开始，[Flutter SDK][flutter] 同时包含了 Dart SDK。
  
{{site.alert.end}}


## General-purpose tools

## 通用工具

The following tools support the Dart language on all platforms.

下述工具支持使用 Dart 语言的全部平台。

* [DartPad](#dartpad)
* [IDEs and editors](#ides-and-editors)

  [IDE 和编辑器](#ides-and-editors)

* [Command-line tools](#cli)

  [命令行工具](#cli)

### DartPad

<img src="{% asset dartpad-hello.png @path %}" alt="DartPad Hello World"
 width="200px" align="right" />
[DartPad](/tools/dartpad) is
a great, no-download-required way to learn Dart syntax
and to experiment with Dart language features.
It supports Dart's core libraries,
except for VM libraries such as dart:io.

<img src="{% asset dartpad-hello.png @path %}" alt="DartPad Hello World" width="200px" align="right" /> [DartPad](/tools/dartpad) 是一个用于学习 Dart 语法以及体验 Dart  语言功能的在线工具。它支持 Dart 的核心库，但不支持类似 dart:io 这样的 VM 库。

### IDEs and editors

### IDE 和编辑器

Dart plugins exist for these commonly used IDEs.

这些常用的 IDE 都带有 Dart 插件。

<ul class="col2">
<li>
<img src="{% asset tools/android_studio.png @path %}"
     width="48" alt="Android Studio logo">
<a href="/tools/jetbrains-plugin"><b>Android Studio</b></a>
</li>
<li>
<img src="{% asset tools/intellij-idea.svg @path %}"
     width="48" alt="IntelliJ logo">
<a href="/tools/jetbrains-plugin"><b>IntelliJ IDEA<br>
(and other JetBrains IDEs)</b></a>
</li>
<li>
<img src="{% asset tools/vscode.svg @path %}"
     width="48" alt="Visual Studio Code logo">
<a href="/tools/vs-code"><b>Visual Studio Code</b></a>
</li>
</ul>

<ul class="col2">
<li>
<img src="{% asset tools/android_studio.png @path %}"
     width="48" alt="Android Studio logo">
<a href="/tools/jetbrains-plugin"><b>Android Studio</b></a>
</li>
<li>
<img src="{% asset tools/intellij-idea.svg @path %}"
     width="48" alt="IntelliJ logo">
<a href="/tools/jetbrains-plugin"><b>IntelliJ IDEA<br> (以及其它的 JetBrains IDE)</b></a>
</li>
<li>
<img src="{% asset tools/vscode.svg @path %}" alt="Visual Studio Code logo">
<a href="/tools/vs-code"><b>Visual Studio Code</b></a>
</li>
</ul>

The following Dart plugins are also available,
thanks to the Dart community.

下面的 Dart 插件也是可用的，感谢 Dart 社区。

<ul class="col2">
<li>
<img src="{% asset tools/emacs.png @path %}" alt="Emacs logo">
<a class="no-automatic-external" href="https://github.com/nex3/dart-mode"><b>Emacs</b></a>
</li>
<li>
<img src="{% asset tools/vim.png @path %}" alt="Vim logo">
<a class="no-automatic-external" href="https://github.com/dart-lang/dart-vim-plugin"><b>Vim</b></a>
</li>
<li>
<img src="{% asset tools/atom-logo.png @path %}" alt="Atom logo">
<a class="no-automatic-external" href="https://github.com/dart-atom/dart"><b>Atom</b></a>
</li>
<li>
<img src="{% asset tools/eclipse-logo.png @path %}" alt="Eclipse logo">
<a class="no-automatic-external" href="https://github.com/eclipse/dartboard"><b>Eclipse</b></a>
</li>
</ul>

A [Language Server Protocol implementation][LSP] is also available for
[LSP-capable editors][] that don't have specific Dart extensions.

[语言服务器协议实现][LSP] 同样适用于没有特定的 Dart 扩展但 [支持 LSP 的编辑器][LSP-capable editors] 。

[LSP]: https://github.com/dart-lang/sdk/blob/master/pkg/analysis_server/tool/lsp_spec/README.md
[LSP-capable editors]: https://microsoft.github.io/language-server-protocol/implementors/tools/

### Command-line tools {#cli}

### 命令行工具 {#cli}

The Dart SDK includes the following general-purpose tools:

Dart SDK 中包含下面的通用工具：

[`dartanalyzer`](/tools/dartanalyzer)
<br> A static analyzer that evaluates and reports any errors or warnings in your code.
  The Dart plugin for your IDE should make use of Dart's analysis engine,
  but you can also run the analyzer from the command line.

[`dartanalyzer` 命令](/tools/dartanalyzer)：用于分析和报告你的代码错误或警告的静态分析器。
相关 IDE 的 Dart 插件应该使用 Dart 的分析引擎，不过你依然可以从命令行运行分析器。

[`dartdoc`](/tools/dartdoc)
<br> A documentation generator.
  For examples of dartdoc's output, see the API reference documentation
  published at [api.dart.dev]({{site.dart_api}}) and pub.dev
  (for example, the [`path` API reference]({{site.pub-api}}/path)).

[`dartdoc` 命令](/tools/dartdoc)
<br>生成 API 参考文档。

[`dartfmt`](/tools/dartfmt)
<br> An opinionated code formatter that follows the recommendations of the
  [Dart style guide](/guides/language/effective-dart/style).
  IDEs that support Dart generally allow you to format the code within
  the IDE. Or you can run the formatter from the command line.

[`dartfmt` 命令](/tools/dartfmt)
<br>根据 [Dart 代码风格指南](/guides/language/effective-dart/style) 格式化你的代码。支持 Dart 的 IDE 允许你使用它们来格式化 Dart 代码。或者你可以直接从命令行运行格式化器。

[`pub`](/tools/pub/cmd)
<br> A package manager that
  makes it easy for you to install, use, and share Dart libraries,
  command-line tools, and other assets.
  Some Dart technologies, such as Flutter, may not support
  all of the pub commands.
  IDEs that support Dart generally have special support for pub,
  but you can also use it from the command line.

[`pub` 命令](/tools/pub/cmd)<br>
用于管理 Dart Package 以及分享 Dart 库和命令行工具以及其它资源的工具。
一些 Dart 相关的技术，比如 Flutter，可能不支持所有的 Pub 命令。
支持 Dart 的 IDE 可能对 Pub 有特殊的支持方式，不过你也可以直接通过命令行使用它。

Some additional tools are available in [packages](/guides/packages).
To install these tools, use the `pub` command, as described in each tool's
installation instructions.
Here are the general-purpose tools you might want to install:

一些额外的工具由 [Package](/guides/packages) 提供。你可以通过查阅每个工具的安装介绍使用 `pub` 命令来安装这些工具。下面是一些你可能想要安装的通用工具：

[`build_runner`][build_runner]
<br> A build package that's used behind-the-scenes by the `webdev` command.

[`build_runner` 命令][build_runner]
<br>代码生成器。

[`dartfix`][dartfix]
<br> A tool for migrating Dart source code and fixing common issues.

[`dartfix` 命令][dartfix]：用于迁移 Dart 源代码和修复常见问题的工具。

### Debugging

### 调试工具

[Dart DevTools](/tools/dart-devtools)
: A suite of debugging and performance tools.

[Dart 开发者工具](/tools/dart-devtools) 
: 一个工具套装帮助调试和性能测试。

## Tools for developing web apps {#web}

## 开发 Web 应用的工具 {#web}

The following tools support developing web apps:

下面工具主要针对 Web 应用开发：

[`dart2js`](/tools/dart2js)
<br> The original Dart-to-JavaScript compiler, with tree shaking.
  IDEs and the webdev CLI use dart2js when building web apps for deployment.
  
[`dart2js` 命令](/tools/dart2js)
<br> 支持 Tree-shaking 的原始的 Dart-to-JavaScript 编译器。在构建用于部署的 Web 应用时，IDE 和 webdev CLI 使用 dart2js。

[`dartdevc`](/tools/dartdevc)
<br> The Dart dev compiler, a modular Dart-to-JavaScript compiler.
  IDEs and the webdev CLI use dartdevc when running a development server.
  
[`dartdevc` 命令](/tools/dartdevc)
<br> Dart dev 编译器，一个模块化的 Dart-to-Javascript 编译器。IDE 和 Webdev CLI 在运行开发服务器时会使用 dartdevc。

[`webdev`](/tools/webdev)
<br> A command-line interface (CLI) for Dart web app development,
  including building and serving web apps.

[`webdev` 命令](/tools/webdev)：用于构建和提供 Dart Web 应用开发的命令行接口（CLI）。

## Tools for developing command-line apps and servers {#server}

## 开发命令行应用和服务器的工具 {#server}

The following tools support developing or running
command-line apps and servers:

下面的工具对开发或运行命令行应用和服务器有特别的支持：

[`dart`](/tools/dart-vm)
<br> The standalone Dart VM, which you can use to execute Dart code.
  IDEs that support Dart,
  and some of the pub commands, use this
  command behind-the-scenes to execute Dart scripts.
  Note that you must configure your IDE with the location of
  the `dart` binary.
  
[`dart` 命令](/tools/dart-vm)
<br> 独立的 Dart 虚拟机，用于执行 Dart 代码。
  一些支持 Dart 的 IDE 和 `pub` 命令使用该命令来执行 Dart 脚本。
  注意你必须在你的 IDE 配置中设置你的 `dart` 安装目录。

[`dart2native`](/tools/dart2native)
<br> An ahead-of-time (AOT) compiler that compiles
  Dart code to native x64 machine code.
  The output is either a standalone executable (the default)
  or an AOT snapshot.
  
[`dart2native` 命令](/tools/dart2native)
<br> AOT 编译器，可将 Dart 代码编译为原生 64 位机器代码。
  输出独立可执行文件（默认）或 AOT 快照。

[`dartaotruntime`](/tools/dartaotruntime)
<br> A Dart runtime that you can use to run AOT snapshots.

[`dartaotruntime` 命令](/tools/dartaotruntime)
<br> Dart 运行时环境，可以运行 AOT 快照。


[build_runner]: /tools/build_runner
[dart_style]: {{site.pub-pkg}}/dart_style
[dartfix]: {{site.pub-pkg}}/dartfix
