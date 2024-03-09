---
# title: dart run
title: dart run 命令
# description: Command-line tool for running a Dart program.
description: 运行Dart程序的命令行工具。
---

The `dart run` command supports running 
a Dart program—located in a file, in the current package, 
or in one of the dependencies of the current package—from the command line.
This command provides functionality that was previously in `pub run`
and the Dart VM tool.
To run a program from an arbitrary location,
use the [pub global](/tools/pub/cmd/pub-global) command.

`dart run` 命令支持运行文件、当前 package
或者当前 package 的依赖中运行Dart程序。
该命令提供了以前在 `pub run` 和 Dart VM 工具里提供的功能。
如果想从任意位置运行程序，可以使用 [pub global](/tools/pub/cmd/pub-global) 命令。

```plaintext
dart run [options] [<DART_FILE> | <PACKAGE_TARGET>] [args]
```

Here's an example of creating a new app and running it:

下面的例子演示了如何创建并且运行一个 Dart 程序：

```console
$ dart create myapp
$ cd myapp
$ dart run
```

{% include 'tools/dart-tool-note.md' %}

## Running a Dart file

## 运行 Dart 文件

You can run a Dart file by passing its relative path:

可以通过传入 Dart 文件的相对路径来运行一个 Dart 程序：

```console
$ dart run tool/debug.dart
```

## Running a program that's in a package

## 运行 package 中的 Dart 程序

The instructions in this section assume that
you're executing the `dart run` command
from the directory that's at the top of a Dart package
(the _current package_).
For information on the directory structure of Dart packages, see
[package layout conventions](/guides/libraries/create-packages).

本节说明的前提是你在 package 的根目录执行 `dart run` 命令。
更多关于 package 目录结构的介绍，请查阅
[package 结构约定](/guides/libraries/create-packages)。

### In a depended-on package

### 运行依赖 package 中的 Dart 程序

You can run programs that are
distributed in the `bin` directory of any package
that the current package depends on.
To run such a program,
specify the depended-on package name and the program name.
You can omit the program name if it's the same as the package name.

你可以运行当前 package 所依赖的任何 package 的 Dart 程序，只要它在 `bin` 目录下。
运行时请指定依赖的 package 名和程序名。
如果程序名与 package 名相同，则可以省略。

For example, say you're in the top directory of a package
that depends on the `bar` package.
To run the main program that's in the `bar` package (`bin/bar.dart`),
you can use this command:

例如，在 package 的根目录，
想运行一个名为 `bar` 的依赖 package 中的 main 程序（`bin/bar.dart`），
使用如下命令：

```console
$ dart run bar
```

If the program name doesn't match the package name,
use the form `<package name>:<program name>`. For example,
to run the program `bin/baz.dart` that's in the `bar` package,
use this command:

如果程序名和 package 名不同，
则需要使用 `<package 名>:<程序名>` 的形式来运行程序。
比如 `bin/baz.dart` 程序在名为 `bar` 的 package 中, 我们就可以这样运行:

```console
$ dart run bar:baz
```

The `bin` directory is the only place with visible programs.
All other directories in the depended-on package are private.

放在 `bin` 目录下的 Dart 文件是可以被 Dart 命令行工具直接访问的，
依赖 package 中的其他目录都是私有的。

### In the current package

### 在当前 package 中运行 Dart 程序

When the current directory matches the package name
(that is, you're in the directory that matches
the `name` property in the pubspec),
then you can omit the package name.
If the program name matches the package name
(that is, it's the main program),
then you can also omit the program name.

当当前的路径与 package 名匹配时（即文件夹名称与 pubspec 中的 `name` 属性相同），
可以省略 package 名。
如果程序名与 package 名匹配（也就是它是 main 程序），
也可以省略程序名。

Here's the shortest form of `dart run`,
which runs the main program for the current package.
For example, if you're in the top directory of the `foo` package,
this command runs `bin/foo.dart`:

`dart run` 是运行 Dart 程序最短的形式，
它会运行当前 package 的主程序。
例如，如果你在名为 `foo` 的 package 根目录执行下面命令，
实际上会运行 `bin/foo.dart` 文件：

```console
$ dart run
```

If the program name doesn't match the package name,
then add a colon and the program name.
For example, this command runs `bin/baz.dart` in the current package:

如果程序名和 package 名不同，需要使用 `:<程序名>` 的形式来运行程序，
比如运行当前 package 中的 `bin/baz.dart` 文件:

```console
$ dart run :baz
```

To run a program that's in the current package but not in the `bin` directory,
pass a relative path (as shown before):

要运行在当前 package 但不在 `bin` 目录的程序时，通过传递相对路径运行（如前文所示）：

```console
$ dart run tool/debug.dart
```

## Supplying arguments to main()

## 给 main() 传递参数

To supply [arguments to the `main()` function][args],
put them at the end of the command:

若你需要 [给 `main()` 函数传递参数][args]，在命令行后面添加参数即可：

```console
$ dart run tool/debug.dart arg1 arg2
```

When you're running the main program for the current package,
add the package name.
Here's an example of running `bin/foo.dart` with arguments
while you're in the top directory of the `foo` package:

在当前 package 中运行 `main` 程序需要添加 package 名，
比如要传递参数并运行位于 `foo` package 根目录中的 `bin/foo.dart` 程序：

```console
$ dart run foo arg1 arg2
```

[args]: /language/functions#the-main-function

## Debugging

## 调试

To enable debugging, 
add one or more of these common debugging options
to your `dart run` command:

若要启用调试功能，
将下面的调试选项加入到 `dart run` 命令中:

- To enable [`assert` statements][assert],
  add the `--enable-asserts` flag:

  要启用 [`assert` 断言][assert]，
  加入 `--enable-asserts` 命令行参数:

  ```console
  $ dart run --enable-asserts tool/debug.dart
  ```

- To enable debugging and performance analysis
  through [Dart DevTools](/tools/dart-devtools),
  add the `--observe` flag:

  若要使用 [Dart 开发者工具](/tools/dart-devtools) 
  来调试和做性能分析，加入 `--observe` 命令行参数:

  ```console
  $ dart run --observe tool/debug.dart
  ```
  
  To learn more about debugging with Dart DevTools,
  see [Using DevTools with a command-line app][].

  了解更多使用 Dart 开发者工具进行调试的信息，
  请查阅文档: [在 Dart 命令行中使用开发者工具][Using DevTools with a command-line app]。

To learn more about other debugging options, run `dart run --help`.

运行 `dart run --help` 获取更多信息。

[assert]: /language/error-handling#assert
[Using DevTools with a command-line app]: /tools/dart-devtools#using-devtools-with-a-command-line-app

## Enabling experimental features

## 开启实验性功能

To enable new features and enhancements that are currently in development,
use [experiment flags](/tools/experiment-flags).

如果在开发中想尝试实验性功能，可以使用 [实验性功能开关](/tools/experiment-flags)。
