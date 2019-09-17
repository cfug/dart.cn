---
title: dartfmt
title: dartfmt 命令（用于格式化 Dart 代码的命令）
description: Command-line tool for formatting Dart source code.
description: 用于格式化 Dart 源代码的命令行工具。
toc: false
---

Use the `dartfmt` command to replace the whitespace in your program
with formatting that follows
[Dart guidelines](/guides/language/effective-dart/style#formatting).
This is the same formatting that you can get
when using an IDE or editor that has Dart support.

使用 `dartfmt` 命令可以根据 [Dart 指南](/guides/language/effective-dart/style#formatting) 将你程序中多余的空格替换掉。这与你使用支持 Dart 的 IDE 或者编辑器格式化代码的效果相同。

Provide a list of files or directories to the `dartfmt` command.
For example, here's how to format all the Dart files
under the current directory's `bin`, `lib`, and `test` directories:

`dartfmt` 命令接收一系列文件或目录作为参数。例如，下面是如何格式化当前目录下 `bin`、`lib` 和 `test` 目录下的所有 Dart 文件示例：

```terminal
$ dartfmt -w bin lib test
```

If you don't want to overwrite the files,
omit the `-w` option.
The resulting source code is displayed to standard output.

如果你不想覆盖文件，请去掉 `-w` 选项。源代码格式化后的结果将作为标准输出显示出来。

```terminal
$ dartfmt bin/main.dart
import 'package:my_app/my_app.dart' as my_app;

main(List<String> arguments) {
  print('Hello world: ${my_app.calculate()}!');
}
$
```

For information on additional command-line options,
use the `--help` flag or see the documentation for the
[dart_style package.]({{site.pub-pkg}}/dart_style)

使用 `--help` 命令行参数或者查阅 [dart_style Package]({{site.pub-pkg}}/dart_style) 文档可以查看更多命令行选项。

```terminal
$ dartfmt --help
```

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
