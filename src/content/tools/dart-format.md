---
# title: dart format
title: dart format 命令（用于格式化 Dart 代码的命令）
# description: Command-line tool for formatting Dart source code.
description: 用于格式化 Dart 源代码的命令行工具。
---

To update your code to follow the
[Dart formatting guidelines][dart-guidelines],
use the `dart format` command.
This formatting follows what you get
when using an IDE or editor with Dart support.

使用 `dart format` 命令可以根据
[Dart 格式化指南][dart-guidelines]
将你程序中多余的空格替换掉。
这与你使用支持 Dart 的 IDE 或者编辑器格式化代码的效果相同。

{% render 'tools/dart-tool-note.md' %}

## Specify files to format

## 指定要格式化的文件

To reformat one or more Dart files,
provide a list of paths to the desired files or directories.

请提供文件或目录的路径列表，
来重新格式化一个或多个 Dart 文件。

### Specify one path

### 指定一个路径

Provide the path to one file or directory.
If you specify a directory, `dart format` affects only the files in the
immediate directory; it doesn't recurse through subdirectories.

提供一个文件或目录的路径。
如果指定一个目录，`dart format` 只影响当前目录中的文件，
而不会遍历子目录。

**Example:** To format all the Dart files in or under the current directory:

**示例：**格式化当前目录下的所有 Dart 文件：

```console
$ dart format .
```

### Specify multiple paths

### 指定多个路径

To specify multiple files or directories, use a space-delimited list.

要指定多个文件或目录，请使用以空格符号分割的列表。

**Example:** To format all Dart files under the `lib` directory,
plus one Dart file under the `bin` directory:

**示例：**下面的命令将会对 `lib` 目录中的所有 Dart 文件，
以及一个 `bin` 目录下的 Dart 文件进行格式化。

```console
$ dart format lib bin/updater.dart 
```

### Prevent overwriting Dart files

### 防止 Dart 文件被覆写

By default, `dart format` **overwrites** the Dart files.

默认情况下，`dart format` 会 **覆写** Dart 文件。

* To not overwrite the files, add the `--output` or `-o` flag.

  不想覆写文件，请加上 `--output` 或 `-o` 参数。

* To get the contents of the formatted files, add `-o show` or `-o json`.

  要获取格式化文件的内容，请加上 `-o show` 或 `-o json`。

* To see only which files _would_ change, add `-o none`.

  只是查看哪些文件**会**被更改，请加上 `-o none`。


```console
$ dart format -o show bin/my_app.dart
```

## Notify when changes occur

## 发生更改时发出通知

To make `dart format` return an exit code when formatting changes occur,
add the `--set-exit-if-changed` flag.

要让 `dart format` 在格式化发生更改时返回退出代码，
请加上 `--set-exit-if-changed` 参数。

* If changes occur, the `dart format` command returns an exit code of `1`.

  如果发生更改，`dart format` 命令返回的退出代码为 `1`。

* If changes don't occur, the `dart format` command returns an exit code of `0`.

  如果没有发生更改，`dart format` 命令返回的退出代码为 `0`。

Use exit codes with continuous integration (CI) systems
so they can trigger another action in response to the exit code.

与持续集成 (CI) 系统一起使用退出代码，
这样它们就可用根据退出代码来触发另一项操作。

```console
$ dart format -o none --set-exit-if-changed bin/my_app.dart
```

## Use trailing commas

## 在结尾使用逗号

Use optional trailing commas for better automatic formatting.
Add a trailing comma at the end of parameter lists in functions, methods,
and constructors.
This helps the formatter insert the appropriate amount of line breaks for
Dart-style code.

为了更好地自动格式化，你可以在结尾使用逗号（可选）。
在函数、方法以及构造函数的参数列表末尾添加逗号。
这有助于格式化工具为 Dart 风格代码插入适当数量的换行符。

## Affects whitespace only

## 只对留白产生影响

To avoid making changes that might be unsafe,
`dart format` only affects whitespace.

为了避免发生不妥当的更改，
`dart format` 只会影响留白的部分。

There's a lot more to writing readable and
consistent code than just whitespace, though.
To learn more about best practices for writing and styling Dart code,
check out the [Dart style guide][].

要想编写易读且一致的代码，
除了留白之外，还有许多其他的方法。
想要了解更多关于编写 Dart 风格代码的最佳实践，
请查阅 [Dart 语言风格指南][Dart style guide]

## Learn more

## 了解更多

To learn about additional command-line options,
use the `dart help` command or see the documentation for the
[dart_style package][dart_style]

请使用 `dart help` 命令，
或查看 [dart_style package][dart_style] 的文档，
来了解其他命令行选项。

```console
$ dart help format
```

[Dart style guide]: /effective-dart/style
[dart_style]: {{site.pub-pkg}}/dart_style
[dart-guidelines]: /effective-dart/style#formatting
