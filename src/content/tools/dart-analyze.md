---
# title: dart analyze
title: dart analyze 命令
# description: Command-line tool for static analysis
description: 用于静态分析的命令行工具
showToc: false
ai-translated: true
---

The `dart analyze` command
performs the same [static analysis][]
that you get when you use an IDE or editor that has Dart support.

`dart analyze` 命令执行的 [静态分析][static analysis]，
与支持 Dart 的 IDE 或编辑器中的静态分析相同。

{% render 'tools/dart-tool-note.md' %}

Here's an example of performing static analysis over all the Dart files
under the current directory:

下面的例子会对当前目录下的所有 Dart 文件做静态分析：

```console
$ dart analyze
```

You can customize how the analyzer treats warnings and info-level issues.
Normally the analyzer reports failure when it finds any errors or warnings,
but not when it finds info-level issues.
You can customize this behavior using the
`--fatal-infos` and `--no-fatal-warnings` flags.
For example, to make the analyzer fail when any issue is 
the `--fatal-infos` flag:

你可以自定义分析器如何对待警告和 info 级别的问题。
通常，分析器发现任何错误或警告时会报告失败，
但发现 info 级别的问题时不会。
可以使用 `--fatal-infos` 和 `--no-fatal-warnings` 参数自定义这一行为。
例如，要让分析器在出现任何问题时失败，请使用 `--fatal-infos` 参数：

```console
$ dart analyze --fatal-infos
```

You can add a directory or a single file argument:

可以额外传入一个目录或单个文件参数：

```console
$ dart analyze [<DIRECTORY> | <DART_FILE>]
```

For example, here's the command to analyze the `bin` directory:

例如，下面的命令会分析 `bin` 目录：

```console
$ dart analyze bin
```

:::version-note
Before Dart 2.13, `dart analyze` supported only directory arguments.

在 Dart 2.13 之前，`dart analyze` 只支持目录参数。
:::

To customize the analysis, use an analysis options file
or special comments in Dart source code,
as described in [Customizing static analysis][static analysis].

要自定义分析，可以使用分析选项文件，
或在 Dart 源代码中使用特殊注释。
详见 [自定义静态分析][static analysis]。

For information on command-line options, use the `--help` flag:

要了解命令行选项，请使用 `--help` 参数：

```console
$ dart analyze --help
```

[static analysis]: /tools/analysis

{% comment %}
```
Usage: dart analyze [arguments] [<directory>]
-h, --help                   Print this usage information.
    --fatal-infos            Treat info level issues as fatal.
    --[no-]fatal-warnings    Treat warning level issues as fatal.
                             (defaults to on)
```
{% endcomment %}
