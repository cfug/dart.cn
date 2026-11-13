---
# title: dartaotruntime
title: dartaotruntime 命令
# description: Command-line tool for running AOT-compiled snapshots of Dart code.
description: 用于运行 Dart 代码 AOT 编译快照的命令行工具。
showToc: false
ai-translated: true
---

With Dart, you can create pre-compiled Dart applications called *AOT snapshots*.

借助 Dart，你可以创建预编译的 Dart 应用，称为 **AOT 快照**。

## Create AOT snapshot app

## 创建 AOT 快照应用

To produce AOT snapshots, use the `aot-snapshot` subcommand of the
[`dart compile` command][dart compile].

要生成 AOT 快照，请使用
[`dart compile` 命令][dart compile] 的 `aot-snapshot` 子命令。

## Run AOT snapshot app

## 运行 AOT 快照应用

To run AOT programs, use the `dartaotruntime` command.
This tool supports Windows, macOS, and Linux.

要运行 AOT 程序，请使用 `dartaotruntime` 命令。
该工具支持 Windows、macOS 和 Linux。

:::note
To run use the `dartaotruntime` command,
add the path to your Dart `bin` directory to your `PATH` environment variable.

要运行 `dartaotruntime` 命令，
请把 Dart 的 `bin` 目录加入 `PATH` 环境变量。
:::

[dart compile]: /tools/dart-compile

## Review an example

## 查看示例

Here's an example of creating and running an AOT snapshot:

下面是创建并运行 AOT 快照的示例：

```console
$ dart compile aot-snapshot bin/myapp.dart
```

```console
Generated: /Users/me/simpleapp/bin/myapp.aot
```

```console
$ dartaotruntime bin/simpleapp.aot
```

## Learn more options

## 了解更多选项

To learn more about command-line options, use the `--help` flag:

要了解更多命令行选项，请使用 `--help` 参数：

```console
$ dartaotruntime --help
```
