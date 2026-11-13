---
# title: dart test
title: dart test 命令
# description: Command-line tool for testing Dart projects.
description: 用于测试 Dart 项目的命令行工具。
showToc: false
ai-translated: true
---

The `dart test` command runs tests that
rely on the [`test` package][] and
are under the `test` directory of the current Dart project.
For information on writing tests, see the 
[testing documentation][].
If you're working on Flutter code, then use the `flutter test` command instead,
as described in [Testing Flutter apps][].

`dart test` 命令会运行当前 Dart 项目 `test` 目录下、
依赖 [`test` package][] 的测试。
编写测试的说明见 [测试文档][testing documentation]。
如果正在开发 Flutter 代码，请改用 `flutter test` 命令，
详见 [测试 Flutter 应用][Testing Flutter apps]。

[testing documentation]: /tools/testing
[`test` package]: {{site.pub-pkg}}/test
[Testing Flutter apps]: {{site.flutter-docs}}/testing

{% render 'tools/dart-tool-note.md' %}

Here's an example of using `dart test` to run all tests
that are under the current project's `test` directory:

下面的例子用 `dart test` 运行当前项目 `test` 目录下的全部测试：

```console
$ cd my_app
$ dart test
```

To control which tests run, you can add the paths to
directories or files under the `test` directory:

要控制运行哪些测试，可以加上 `test` 目录下
目录或文件的路径：

{% comment %}
  I ran these commands in site-www/misc
{% endcomment %}

```console
$ dart test test/library_tour/io_test.dart
00:00 +0: readAsString, readAsLines
00:00 +1: readAsBytes
...
```

Another way to run a subset of tests is to use the `--name` (`-n`),
`--tags` (`-t`), or `--exclude-tags` (`-x`) flag,
adding part or all of the string to match:

另一种只运行一部分测试的方式，是使用 `--name`（`-n`）、
`--tags`（`-t`）或 `--exclude-tags`（`-x`）参数，
并附上要匹配的全部或部分字符串：

```console
$ dart test --name String
00:00 +0: test/library_tour/io_test.dart: readAsString, readAsLines
00:00 +1: test/library_tour/core_test.dart: print: print(nonString)
00:00 +2: test/library_tour/core_test.dart: print: print(String)
00:00 +3: test/library_tour/core_test.dart: numbers: toString()
...
```

When you use these flags more than once in the same command line,
only the tests that match _all_ the conditions run:

在同一条命令中多次使用这些参数时，
只有同时满足 **全部** 条件的测试才会运行：

```console
$ dart test --name String --name print
00:00 +0: test/library_tour/core_test.dart: print: print(nonString)
00:00 +1: test/library_tour/core_test.dart: print: print(String)
00:00 +2: All tests passed!
```

The `dart test` command has many more flags to control
which tests run,
how they run (for example, concurrency and timeout), and
where and how the output appears.
For further information on command-line options,
see the [`test` package][] or
use the `--help` flag:

`dart test` 命令还有很多参数，用来控制
运行哪些测试、如何运行（例如并发和超时），
以及输出出现的位置和形式。
要进一步了解命令行选项，
请参阅 [`test` package][]，
或使用 `--help` 参数：

```console
$ dart test --help
```
