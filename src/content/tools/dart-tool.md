---
# title: "dart: The Dart command-line tool"
title: "dart：Dart 命令行工具"
# shortTitle: Dart CLI
shortTitle: Dart 命令行
# description: >-
#   Learn about the 'dart' CLI and its available subcommands.
description: 了解 dart CLI 及其可用的子命令。
ai-translated: true
---

The `dart` tool is the command-line interface to the [Dart SDK][].
The tool is available no matter how you get the Dart SDK—whether
you download the Dart SDK explicitly
or download only the [Flutter SDK][].

`dart` 工具是 [Dart SDK][] 的命令行界面。
无论你如何获取 Dart SDK，都可以使用这个工具：
可以单独下载 Dart SDK，
也可以只下载包含它的 [Flutter SDK][]。

[Dart SDK]: /tools/sdk
[Flutter SDK]: {{site.flutter}}

## Usage example

## 使用示例

Here's how you might use the `dart` tool
to create, analyze, test, and run an app:

下面是用 `dart` 工具创建、分析、测试并运行应用的例子：

```console
$ dart create -t console my_app
$ cd my_app
$ dart analyze
$ dart test
$ dart run bin/my_app.dart
```

You can also run [`pub` commands][pub] using the `dart` tool:

也可以通过 `dart` 工具运行 [`pub` 命令][pub]：

```console
$ dart pub get
$ dart pub outdated
$ dart pub upgrade
```

## Available commands

## 可用命令

The following table shows which commands you can use with the `dart` tool.

下表列出可以配合 `dart` 工具使用的命令。

| <t>Command</t><t>命令</t>    | <t>Format of command</t><t>命令格式</t>                                      | <t>More information</t><t>更多信息</t>                                                                                         |
|------------|--------------------------------------------------------|----------------------------------------------------------------------------------------------------------|
| `analyze`  | <code>dart analyze [<DIRECTORY&#124;DART_FILE>]</code> | Analyzes the project's Dart source code.<br>[Learn more.][analyze]                                       |
| `analyze`  | <code>dart analyze [<DIRECTORY&#124;DART_FILE>]</code> | 分析项目的 Dart 源代码。<br>[了解详情。][analyze] |
| `build`    | `dart build <APP_TYPE>`                                | Builds a Dart app including [code assets][].<br>[Learn more.][build]               |
| `build`    | `dart build <APP_TYPE>`                                | 构建 Dart 应用，并包含 [代码资源][code assets]。<br>[了解详情。][build] |
| `compile`  | `dart compile <FORMAT>`                                | Compiles Dart to various formats (native executable, JavaScript, WebAssembly).<br>[Learn more.][compile] |
| `compile`  | `dart compile <FORMAT>`                                | 将 Dart 编译为多种格式（原生可执行文件、JavaScript、WebAssembly）。<br>[了解详情。][compile] |
| `create`   | `dart create <DIRECTORY>`                              | Creates a new project.<br>[Learn more.][create]                                                          |
| `create`   | `dart create <DIRECTORY>`                              | 创建新项目。<br>[了解详情。][create] |
| `devtools` | `dart devtools`                                        | Opens Dart DevTools, a suite of debugging and performance tools for Dart.<br>[Learn more.][devtools]     |
| `devtools` | `dart devtools`                                        | 打开 Dart DevTools，一套用于 Dart 的调试和性能工具。<br>[了解详情。][devtools] |
| `doc`      | `dart doc <DIRECTORY>`                                 | Generates API reference documentation.<br>[Learn more.][doc]                                             |
| `doc`      | `dart doc <DIRECTORY>`                                 | 生成 API 参考文档。<br>[了解详情。][doc] |
| `fix`      | <code>dart fix <DIRECTORY&#124;DART_FILE></code>       | Applies automated fixes to Dart source code.<br>[Learn more.][fix]                                       |
| `fix`      | <code>dart fix <DIRECTORY&#124;DART_FILE></code>       | 对 Dart 源代码应用自动修复。<br>[了解详情。][fix] |
| `format`   | <code>dart format <DIRECTORY&#124;DART_FILE></code>    | Formats Dart source code.<br>[Learn more.][format]                                                       |
| `format`   | <code>dart format <DIRECTORY&#124;DART_FILE></code>    | 格式化 Dart 源代码。<br>[了解详情。][format] |
| `info`     | `dart info`                                            | Outputs Dart tooling diagnostic information.<br>[Learn more.][info]                                      |
| `info`     | `dart info`                                            | 输出 Dart 工具的诊断信息。<br>[了解详情。][info] |
| `pub`      | `dart pub <PUB_COMMAND>`                               | Works with packages.<br>Replaces `pub`.<br>[Learn more.][pub]                                            |
| `pub`      | `dart pub <PUB_COMMAND>`                               | 用于处理 package。<br>取代 `pub`。<br>[了解详情。][pub] |
| `run`      | `dart run <DART_FILE>`                                 | Runs a Dart program.<br>[Learn more.][run]                                                               |
| `run`      | `dart run <DART_FILE>`                                 | 运行 Dart 程序。<br>[了解详情。][run] |
| `test`     | <code>dart test <DIRECTORY&#124;DART_FILE></code>      | Runs tests in this package.<br>[Learn more.][test]                                                       |
| `test`     | <code>dart test <DIRECTORY&#124;DART_FILE></code>      | 运行此 package 中的测试。<br>[了解详情。][test] |
| _(none)_   | `dart <DART_FILE>`                                     | Runs a Dart program.<br>Prefer [`dart run`][run].                                                        |
| **（无）** | `dart <DART_FILE>`                                     | 运行 Dart 程序。<br>更推荐使用 [`dart run`][run]。 |

{:.table .table-striped .nowrap}

[code assets]: /tools/hooks#assets

[analyze]: /tools/dart-analyze
[build]: /tools/dart-build
[compile]: /tools/dart-compile
[create]: /tools/dart-create
[devtools]: /tools/dart-devtools
[doc]: /tools/dart-doc
[fix]: /tools/dart-fix
[format]: /tools/dart-format
[info]: /tools/dart-info
[pub]: /tools/pub/cmd
[run]: /tools/dart-run
[test]: /tools/dart-test

## Learn more

## 了解更多

To get help with any of the commands, run `dart help <command>`.
You can also get details on `pub` commands.

要查看任一命令的帮助，请运行 `dart help <command>`。
也可以查看 `pub` 命令的详细说明。

```console
$ dart help pub outdated
```
