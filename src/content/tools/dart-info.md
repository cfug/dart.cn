---
# title: dart info
title: dart info 命令
# description: Command-line tool for outputting Dart tooling diagnostic information.
description: 用于输出 Dart 工具诊断信息的命令行工具。
showToc: false
ai-translated: true
---

The `dart info` command
outputs diagnostic information about installed `dart` tooling,
running Dart processes,
and project information if in a directory with a `pubspec.yaml`.
The output information can be used for debugging tooling issues
or reporting a bug.

`dart info` 命令会输出已安装 `dart` 工具和正在运行的 Dart 进程的诊断信息。
如果当前目录含有 `pubspec.yaml`，还会输出项目信息。
这些输出可用于排查工具问题，或用于报告 bug。

{% render 'tools/dart-tool-note.md' %}

:::warning
If you are including the `dart info` output in a bug report,
please review the output to ensure it only
contains details you're comfortable posting publicly.

如果要在 bug 报告中附上 `dart info` 的输出，
请先检查内容，确认其中只包含你可以公开的信息。
:::

To output general information related to your system
and your Dart installation, including running Dart processes,
run `dart info` from any directory:

要输出与系统以及 Dart 安装相关的一般信息
（包括正在运行的 Dart 进程），
可以在任意目录运行 `dart info`：

```console
$ dart info
```

For example, on macOS, 
the output looks similar to the following:

例如在 macOS 上，输出大致如下：

```markdown
#### General info

- Dart 2.19.2 (stable) (Tue Feb 7 18:37:17 2023 +0000) on "macos_arm64"
- on macos / Version 13.1 (Build 22C65)
- locale is en-US

#### Process info

| Memory |   CPU | Elapsed time | Command line                      |
| -----: | ----: | -----------: | ----------------------------------|
| 253 MB | 49.7% |        00:00 | analysis_server.dart.snapshot ... |
|  69 MB | 18.7% |        00:00 | dart analyze                      |   
```

To include project information in the output,
run `dart info` in a directory with a `pubspec.yaml` file.
The resulting output includes an additional **Project info** section:

要在输出中包含项目信息，
请在含有 `pubspec.yaml` 的目录中运行 `dart info`。
结果会多出一个 **Project info** 部分：

```plaintext
#### Project info

- sdk constraint: '>=2.19.2 <3.0.0'
- dependencies: path
- dev_dependencies: lints, test
```

To include file paths and path dependencies in
the displayed project and process info,
add the `--no-remove-file-paths` option:

要在显示的项目信息和进程信息中包含文件路径与路径依赖，
请加上 `--no-remove-file-paths` 选项：

```console
$ dart info --no-remove-file-paths
```
