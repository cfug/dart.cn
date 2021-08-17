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

{{site.alert.note}}

  The Flutter SDK includes the full Dart SDK.

  Flutter SDK 包含完整的 Dart SDK。

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

<img src="{% asset dartpad-hello.png @path %}" alt="DartPad Hello World" width="200px" align="right" /> 
[DartPad](/tools/dartpad) 是一个用于学习 Dart 语法以及
体验 Dart 语言功能的在线工具。
它支持 Dart 的核心库，但不支持类似 dart:io 这样的 VM 库。

### IDEs and editors

### IDE 和编辑器

Dart plugins exist for these commonly used IDEs.

这些常用的 IDE 都带有 Dart 插件。

<ul class="col2">
<li>
<img src="{% asset tools/android_studio.svg @path %}"
     width="48" alt="Android Studio logo">
<a href="/tools/jetbrains-plugin"><b>Android Studio</b></a>
</li>
<li>
<img src="{% asset tools/intellij-idea.svg @path %}"
     width="48" alt="IntelliJ logo">
<a href="/tools/jetbrains-plugin"><b>IntelliJ IDEA<br>
(以及其它的 JetBrains IDE)</b></a>
</li>
<li>
<img src="{% asset tools/vscode.svg @path %}"
     width="48" alt="Visual Studio Code logo">
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
<img src="{% asset tools/eclipse-logo.png @path %}" alt="Eclipse logo">
<a class="no-automatic-external" href="https://github.com/eclipse/dartboard"><b>Eclipse</b></a>
</li>
</ul>

A [Language Server Protocol implementation][LSP] is also available for
[LSP-capable editors][] that don't have specific Dart extensions.

[语言服务器协议实现][LSP] 同样适用于没有特定的 Dart 扩展但
[支持 LSP 的编辑器][LSP-capable editors] 。

[LSP]: https://github.com/dart-lang/sdk/blob/master/pkg/analysis_server/tool/lsp_spec/README.md
[LSP-capable editors]: https://microsoft.github.io/language-server-protocol/implementors/tools/

### Command-line tools {#cli}

### 命令行工具 {#cli}

The Dart SDK includes the following general-purpose tools:

Dart SDK 中包含下面的通用工具：

[`dart`](/tools/dart-tool)
: A command-line interface (CLI) for creating, formatting, analyzing,
  testing, compiling, and running Dart code,
  as well as working with the [pub package manager](/guides/packages).

[`dart`](/tools/dart-tool)
<br>用于创建、格式化、分析、测试、编译和运行 Dart 代码的命令行工具 (CLI)，
同时包含 [pub package 管理器](/guides/packages)。

[`dartdoc`](/tools/dartdoc)
: A documentation generator.
  For examples of dartdoc's output, see the API reference documentation
  published at [api.dart.dev]({{site.dart_api}}) and pub.dev
  (for example, the [`path` API reference]({{site.pub-api}}/path)).

[`dartdoc` 命令](/tools/dartdoc)
<br>生成 API 参考文档。
  dartdoc 的实例可以查看 [api.dart.cn]({{site.dart_api}}) 和 pub.dev
  （例如，[`path` 的 API 文档]({{site.pub-api}}/path)）。

### Debugging

### 调试工具

[Dart DevTools](/tools/dart-devtools)
: A suite of debugging and performance tools.

[Dart 开发者工具](/tools/dart-devtools) 
<br> 一个工具套装帮助调试和性能测试。

## Tools for developing web apps {#web}

## 开发 Web 应用的工具 {#web}

The following tools support developing web apps:

下面工具主要针对 Web 应用开发：

[`webdev`](/tools/webdev)
: A CLI for Dart web app development,
  including building and serving web apps.

[`webdev` 命令](/tools/webdev)
<br>用于构建和提供 Dart Web 应用开发的命令行接口（CLI）。

[`dart2js`](/tools/dart2js)
: The original Dart-to-JavaScript compiler, with tree shaking.
  IDEs and the `webdev` CLI use `dart2js` when building web apps for deployment.

[`dart2js` 命令](/tools/dart2js)
<br> 支持 Tree-shaking 的原始的 Dart-to-JavaScript 编译器。
在构建用于部署的 Web 应用时，IDE 和 `webdev` CLI 使用 dart2js。

[`dartdevc`](/tools/dartdevc)
: The Dart dev compiler, a modular Dart-to-JavaScript compiler.
  IDEs and the `webdev` CLI use `dartdevc` when running a development server.

[`dartdevc` 命令](/tools/dartdevc)
<br> Dart dev 编译器，一个模块化的 Dart-to-Javascript 编译器。
IDE 和 `webdev` CLI 在运行开发服务器时会使用 `dartdevc`。

## Tools for developing command-line apps and servers {#server}

## 开发命令行应用和服务器的工具 {#server}

The following tools support developing or running
command-line apps and servers:

下面的工具对开发或运行命令行应用和服务器有特别的支持：

[`dart run`](/tools/dart-run)
: Use the `dart run` command to run uncompiled Dart command-line apps
  and some kinds of snapshots.

[`dart`](/tools/dart-vm)
<br> 通过 [`dart run`](/tools/dart-run) 命令来运行未编译的 Dart 命令行应用和一些其他的快照。

[`dartaotruntime`](/tools/dartaotruntime)
: Use this Dart runtime to run AOT snapshots.

[`dartaotruntime` 命令](/tools/dartaotruntime)
<br> Dart 运行时环境，可以运行 AOT 快照。
