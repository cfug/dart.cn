---
# title: dart format
title: dart format 命令（用于格式化 Dart 代码的命令）
# description: Command-line tool for formatting Dart source code.
description: 用于格式化 Dart 源代码的命令行工具。
ai-translated: true
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
If you pass a directory path,
`dart format` recurses into its subdirectories as well.

提供一个文件或目录的路径。
如果指定一个目录，`dart format` 也会遍历其子目录。

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

## Format on save

## 保存时格式化

Many editors with Dart support can automatically 
format your code when you save a file.

许多支持 Dart 的编辑器可以在你保存文件时自动格式化代码。

### VS Code

### VS Code 编辑器

To enable formatting on save in [VS Code](/tools/vs-code),
add the following entry to your `settings.json` file:

要在 [VS Code](/tools/vs-code) 中启用保存时格式化，
请在你的 `settings.json` 文件中添加以下条目：

```json
{
  "[dart]": {
    "editor.formatOnSave": true
  }
}
```

### IntelliJ and Android Studio

### IntelliJ 和 Android Studio

To enable formatting on save in [JetBrains IDEs](/tools/jetbrains-plugin),
including IntelliJ IDEA and Android Studio,
follow their instructions on how to
[Automatically reformat code on save][ij-on-save].

要在 [JetBrains IDE](/tools/jetbrains-plugin)（包括 IntelliJ IDEA 和
Android Studio）中启用保存时格式化，
请按照它们的说明操作：[保存时自动重新格式化代码][ij-on-save]。

[ij-on-save]: https://www.jetbrains.com/help/idea/reformat-and-rearrange-code.html#reformat-on-save

## What changes?

## 会有哪些改变？

`dart format` makes the following formatting changes:

`dart format` 会做出以下格式化更改：

* Removes whitespace.
* Wraps every line to 80 characters long or shorter.
* Adds trailing commas to any argument or parameter list
that splits across multiple lines, and removes them from ones that don't.
* Might move comments before or after a comma.

  移除空白字符。
  把每一行换行到 80 个字符或更短。
  为跨多行拆分的实参或形参列表添加尾随逗号，
  并从不跨行的列表中移除尾随逗号。
  可能把注释移到逗号之前或之后。

To learn more about best practices for writing and styling Dart code,
check out the [Dart style guide][].

要了解更多关于编写和设置 Dart 代码风格的最佳实践，
请参阅 [Dart 风格指南][Dart style guide]。

### Configure the formatter

### 配置格式化器

When you run `dart format`, the formatter defaults to
80 character line length or shorter. 
Configure the formatter's behavior by adding a top-level
`formatter` section to the [`analysis_options.yaml`][] file.

运行 `dart format` 时，格式化器默认使用 80 个字符或更短的行长度。
你可以通过在 [`analysis_options.yaml`][] 文件中添加顶层的 `formatter` 部分，
来配置格式化器的行为。

#### Page width

#### 页面宽度

Configure the line length for your project:

为你的项目配置行长度：

```yaml title="analysis_options.yaml"
formatter:
  page_width: 123
```

With the analysis options file typically at the root,
the configured line length will apply to everything in the package.

分析选项文件通常位于根目录，
配置的行长度会应用于 package 中的所有内容。

#### Preserve trailing commas

#### 保留尾随逗号

By default, `dart format` adds or removes trailing commas
based on whether the construct splits across multiple lines.
To force a construct to split even when it fits on one line,
configure the formatter to preserve trailing commas:

默认情况下，`dart format` 会根据结构是否跨多行拆分，
来添加或移除尾随逗号。
要强制某个结构拆分（即使它能放在一行内），
请把格式化器配置为保留尾随逗号：

```yaml title="analysis_options.yaml"
formatter:
  trailing_commas: preserve
```

When enabled, adding a trailing comma to an argument list,
parameter list, or other constructs, forces the formatter to split 
it across multiple lines, even if it fits on one line. This provides 
manual control over line breaks for specific constructs.
This gives you manual control over line breaks for specific constructs.

启用后，在实参列表、形参列表或其他结构中添加尾随逗号，
会强制格式化器把它拆分成多行，即使它能放在一行内。
这让你能手动控制特定结构的换行。

Configure an individual file's line length,
overriding the analysis options, by adding 
a marker comment at the top of the file, before any other code:

要为单个文件配置行长度（覆盖分析选项），
请在文件顶部、任何其他代码之前添加一条标记注释：

```dart
// dart format width=123
```

:::version-note
Configurable formatter options require
a [language version][] of at least 3.7.
The `trailing_commas` option requires at least 3.8.

可配置的格式化器选项需要至少 3.7 的 [语言版本][language version]。
`trailing_commas` 选项需要至少 3.8。
:::

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

Check out the [formatter FAQ][] for more context behind formatting decisions.

如果想要了解格式化决策背后的更多信息，请查看 [格式化常见问题][formatter FAQ]。

[Dart style guide]: /effective-dart/style
[dart_style]: {{site.pub-pkg}}/dart_style
[dart-guidelines]: /effective-dart/style#formatting
[`analysis_options.yaml`]: /tools/analysis
[language version]: /language/versioning
[formatter FAQ]: {{site.repo.dart.org}}/dart_style/wiki/FAQ