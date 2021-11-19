---
title: dart format
title: dart format 命令（用于格式化 Dart 代码的命令）
description: Command-line tool for formatting Dart source code.
description: 用于格式化 Dart 源代码的命令行工具。
toc: false
---

Use the `dart format` command to replace the whitespace in your program
with formatting that follows
[Dart guidelines](/guides/language/effective-dart/style#formatting).
This is the same formatting that you can get
when using an IDE or editor that has Dart support.

使用 `dart format` 命令可以根据
[Dart 指南](/guides/language/effective-dart/style#formatting)
将你程序中多余的空格替换掉。
这与你使用支持 Dart 的 IDE 或者编辑器格式化代码的效果相同。

Provide a list of files or directories to the `dart format` command.
For example, here's how to format all the Dart files
in or under the current directory:

`dart format` 命令接收一系列文件或目录作为参数。
例如，下面是如何格式化当前目录下所有 Dart 文件的示例：

```terminal
$ dart format .
```

To specify multiple files or directories,
use a space-delimited list.
The following command formats all Dart files under the `lib` directory,
plus one Dart file under the `bin` directory:

要指定多个文件或目录，请使用以空格符号分割的列表。
下面的命令将会对 `lib` 目录中的所有 Dart 文件，
以及一个 `bin` 目录下的 Dart 文件进行格式整理。

```terminal
$ dart format lib bin/updater.dart 
```

{{site.alert.warn}}
  By default, `dart format` **overwrites** the Dart files.
{{site.alert.end}}

If you don't want to overwrite the files,
add the `--output` or `-o` flag.
Use `-o show` or `-o json` to get the contents of the formatted files,
or `-o none` to see only which files would change.

如果你不想覆盖文件，请去掉 `-w` 选项。源代码格式化后的结果将作为标准输出显示出来。

```terminal
$ dart format -o show bin/my_app.dart
```

To make the command have an exit code of `1`
if any formatting changes occur,
add the `--set-exit-if-changed` flag.
This exit code is often used with continuous integration (CI)
to indicate that a check should fail.

```terminal
$ dart format -o none --set-exit-if-changed
```

For information on additional command-line options,
use the `dart help` command or see the documentation for the
[dart_style package.]({{site.pub-pkg}}/dart_style)

使用 `--help` 命令行参数或者查阅 [dart_style Package]({{site.pub-pkg}}/dart_style) 文档可以查看更多命令行选项。

```terminal
$ dart help format
```

The `dart format` command replaces `dartfmt`.

{% comment %}
[PENDING: Add info on commonly used options.]

[PENDING: Advocate using this! Perhaps steal the first paragraph from
dart_style's readme:

The dart_style package defines an automatic, opinionated formatter
for Dart code. It replaces the whitespace in your program with what
it deems to be the best formatting for it. Resulting code should
follow the Dart style guide and, more importantly, should look nice
to most human readers, most of the time.]
{% endcomment %}
