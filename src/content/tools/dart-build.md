---
# title: dart build
title: dart build 命令
# description: Command-line tool for building Dart applications.
description: 用于构建 Dart 应用的命令行工具。
ai-translated: true
---

:::version-note
Support for `dart build` was introduced in Dart 3.10.

`dart build` 的支持从 Dart 3.10 开始引入。
:::

Use the `dart build` command to build a Dart application.
This command automatically runs [build hooks](/tools/hooks) 
from your project and its dependencies to compile or download 
code assets and bundle them with your application.

使用 `dart build` 命令构建 Dart 应用。
该命令会自动运行项目及其依赖中的 [构建钩子](/tools/hooks)，
编译或下载代码资源，并把它们打包进应用。


## Build a CLI application 

## 构建 CLI 应用

The `dart build cli` command
builds a Dart application with a command-line interface (CLI)
including any code assets.

`dart build cli` 命令会构建带命令行界面（CLI）的 Dart 应用，
并包含所有代码资源。

The resulting app bundle is structured as follows:

生成的应用包结构如下：

<FileTree>

- bundle/
  - bin/
    - <compiled_executable> 
  - lib/
    - <dynamic_libraries>

</FileTree>

## Options for `dart build cli`

## `dart build cli` 的选项

The following options can be used for the `dart build cli` command. 

`dart build cli` 命令可以使用下列选项。

### `-h`, `--help`

### `-h`、`--help` 参数

Use the `-h` or `--help` option to get help for the `cli` subcommand.

使用 `-h` 或 `--help` 选项查看 `cli` 子命令的帮助。

```console
$ dart build cli --help
```

```console
$ dart build cli -h
```


### `-o`, `--output`

### `-o`、`--output` 参数

Use `-o` or `--output` to specify where `dart build` saves 
the generated files. The output is placed in a `bundle/` directory 
within the given path, which can be absolute or relative. 
If omitted, the default path is `build/cli/_/`.

使用 `-o` 或 `--output` 指定 `dart build` 保存生成文件的位置。
输出会放在给定路径下的 `bundle/` 目录中，路径可以是绝对路径或相对路径。
如果省略，默认路径是 `build/cli/_/`。

```console
$ dart build cli --output=<path>
```

```console
$ dart build cli -o=<path>
```

For example, to set the output directory to `./my_custom_output`:

例如，把输出目录设为 `./my_custom_output`：

```console
$ dart build cli --output=./my_custom_output
```


### `-t`, `--target`

### `-t`、`--target` 参数

Use the `-t` or `--target` option to specify the main entry-point 
file of the command-line application.

使用 `-t` 或 `--target` 选项指定命令行应用的主入口文件。

This must be a Dart file in the `bin/` directory. 
If the option is omitted and there is a single 
Dart file in `bin/`, then that is used instead.

该文件必须是 `bin/` 目录中的 Dart 文件。
如果省略该选项，且 `bin/` 中只有一个 Dart 文件，
就会使用那个文件。

```console
$ dart build cli --target=<path>
```

```console
$ dart build cli -t=<path>
```

For example, to set the entrypoint to the `bin/my_command.dart` file:

例如，把入口点设为 `bin/my_command.dart`：

```console
$ dart build cli --target=bin/my_command.dart
```

### `--verbosity`

### `--verbosity` 参数

Use the `--verbosity` option to set the verbosity level of the compilation.
The level can be `error`, `warning`, `info`, or `all`.

使用 `--verbosity` 选项设置编译输出的详细程度。
级别可以是 `error`、`warning`、`info` 或 `all`。

```console
$ dart build cli --verbosity=<level>
```

For example, to show only error messages:

例如，只显示错误消息：

```console
$ dart build cli --verbosity=error
```


[Global options]: /tools/pub/cmd#global-options
