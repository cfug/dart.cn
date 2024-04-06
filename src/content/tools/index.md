---
# title: Tools
title: Dart 的开发工具
# description: The tools that support the Dart language.
description: 支持 Dart 语言的开发工具。
---

When you're ready to create an app, get the SDK and tools for your app
type. If you aren't sure which tools you need, **get the Flutter SDK.**

当你准备好创建一个应用时，请根据你要创建的应用类型获取相应的 SDK 和工具。

<div class="table-wrapper">

| <t>App type</t><t>应用类型</t> | <t>Get started instructions</t><t>入门说明</t> | <t>Tool information</t><t>工具信息</t> |
|-------------------------------|------------------------------------------------|---------------------------------------|
| Flutter (mobile and more) | [Install Flutter]({{site.flutter-docs}}/get-started/install) | [Flutter tools]({{site.flutter-docs}}/using-ide) |
| Flutter (移动应用和其他平台) | [安装 Flutter]({{site.flutter-docs}}/get-started/install) | [Flutter tools]({{site.flutter-docs}}/using-ide) |
| Web app (non-Flutter) | [Install the Dart SDK](/tools/sdk) | [General-purpose tools][] and [web tools](#web) |
| Web 应用 (非 Flutter) | [安装 Dart SDK](/tools/sdk) | [通用工具][General-purpose tools] and [Web 工具](#web) |
| Server or command line | [Install the Dart SDK](/tools/sdk) | [General-purpose tools][] and [specialized tools](#server) |
| 服务器或命令行应用 | [安装 Dart SDK](/tools/sdk) | [通用工具][General-purpose tools] 和 [专业工具](#server) |

{:.table .table-striped}
</div>

[General-purpose tools]: #general-purpose-tools

:::note

  The Flutter SDK includes the full Dart SDK.

  Flutter SDK 包含完整的 Dart SDK。

:::

## General-purpose tools

## 通用工具

The following tools support the Dart language on all platforms.

下述工具支持使用 Dart 语言的全部平台。

* [DartPad](#dartpad)
* [IDEs and editors](#editors)

  [IDE 和编辑器](#editors)

* [Command-line tools](#cli)

  [命令行工具](#cli)

### DartPad

<img src="/assets/img/dartpad-hello.png" alt="DartPad Hello World" width="200px" align="right" />

[DartPad](/tools/dartpad) is
a great, no-download-required way to learn Dart syntax
and to experiment with Dart language features.
It supports Dart's core libraries,
except for VM libraries such as `dart:io`.

<img src="/assets/img/dartpad-hello.png" alt="DartPad Hello World" width="200px" align="right" />
[DartPad](/tools/dartpad) 是一个用于学习 Dart 语法以及
体验 Dart 语言功能的在线工具。
它支持 Dart 的核心库，但不支持类似 dart:io 这样的 VM 库。

<a id="ides-and-editors"></a>
### IDEs and editors {:#editors}

### IDE 和编辑器

Dart plugins exist for these commonly used IDEs.

这些常用的 IDE 都带有 Dart 插件。

<ul class="col2">
<li>
<img src="/assets/img/tools/android_studio.svg" width="48" alt="Android Studio logo">
<a href="/tools/jetbrains-plugin"><b>Android Studio</b></a>
</li>
<li>
<img src="/assets/img/tools/intellij-idea.svg" width="48" alt="IntelliJ logo">
<a href="/tools/jetbrains-plugin"><b>IntelliJ IDEA<br>
(以及其它的 JetBrains IDE)</b></a>
</li>
<li>
<img src="/assets/img/tools/vscode.svg"
     width="48" alt="Visual Studio Code logo">
<a href="/tools/vs-code"><b>Visual Studio Code</b></a>
</li>
</ul>

The following Dart plugins are also available,
thanks to the Dart community.

下面的 Dart 插件也是可用的，感谢 Dart 社区。

<ul class="col2">
<li>
<img src="/assets/img/tools/emacs.png" alt="Emacs logo">
<a href="https://github.com/nex3/dart-mode"><b>Emacs</b></a>
</li>
<li>
<img src="/assets/img/tools/vim.png" alt="Vim logo">
<a href="{{site.repo.dart.org}}/dart-vim-plugin"><b>Vim</b></a>
</li>
<li>
<img src="/assets/img/tools/eclipse-logo.png" alt="Eclipse logo">
<a href="https://github.com/eclipse/dartboard"><b>Eclipse</b></a>
</li>
</ul>

A [Language Server Protocol implementation][LSP] is also available for
[LSP-capable editors][] that don't have specific Dart extensions.

[语言服务器协议实现][LSP] 同样适用于没有特定的 Dart 扩展但
[支持 LSP 的编辑器][LSP-capable editors] 。

[LSP]: {{site.repo.dart.sdk}}/blob/main/pkg/analysis_server/tool/lsp_spec/README.md
[LSP-capable editors]: https://microsoft.github.io/language-server-protocol/implementors/tools/

### Command-line tools {:#cli}

### 命令行工具 {:#命令行工具}

The Dart SDK includes the following general-purpose `dart` tool:

Dart SDK 中包含下面的 `dart` 工具：

[`dart`](/tools/dart-tool)
<br> A command-line interface (CLI) for creating, formatting, analyzing,
  testing, documenting, compiling, and running Dart code,
  as well as working with the [pub package manager](/guides/packages).

[`dart`](/tools/dart-tool)
<br> 用于创建、格式化、分析、测试、编译和运行 Dart 代码的命令行工具 (CLI)，
  同时包含 [pub package 管理器](/guides/packages)。


### Debugging

### 调试工具

[Dart DevTools](/tools/dart-devtools)
<br>A suite of debugging and performance tools.

[Dart 开发者工具](/tools/dart-devtools) 
<br> 一个工具套装帮助调试和性能测试。

## Tool for developing web apps {:#web}

## 开发 Web 应用的工具 {:#开发 Web 应用的工具}

The following tool supports developing web apps:

下面工具主要针对 Web 应用开发：

[`webdev`](/tools/webdev)
<br> A CLI to build and serve Dart web apps.

[`webdev`](/tools/webdev)
<br> 用于构建和提供 Dart Web 应用开发的命令行接口 (CLI) 。

## Tools for developing command-line apps and servers {:#server}

## 开发命令行应用和服务器的工具 {:#开发命令行应用和服务器的工具}

The following tools support developing or running
command-line apps and servers:

下面的工具对开发或运行命令行应用和服务器有特别的支持：

[`dart run`](/tools/dart-run)
<br> Use the `dart run` command to run uncompiled Dart command-line apps
  and some kinds of snapshots.

[`dart`](/tools/dart-vm)
<br> 通过 [`dart run`](/tools/dart-run) 命令来运行未编译的 Dart 命令行应用和一些其他的快照。

[`dartaotruntime`](/tools/dartaotruntime)
<br> Use this Dart runtime to run AOT snapshots.

[`dartaotruntime` 命令](/tools/dartaotruntime)
<br> Dart 运行时环境，可以运行 AOT 快照。
