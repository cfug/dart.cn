---
title: pub run
title: pub run
description: Use pub run to run a Dart script in your package.
description: 使用 pub run 命令运行你 Package 中的 Dart 脚本。
---

_Run_ is one of the commands of the [pub tool](/tools/pub/cmd).

_Run_ 命令是 [Pub 工具](/tools/pub/cmd) 中的一个命令。

{% prettify nocode %}
$ pub run [--enable-asserts] <executable> [args...]
{% endprettify %}

Use this command to run a Dart script in your package,
or in one of its dependencies, from the command line.

使用该命令可以从命令行运行一个位于你 Package 中或 Package 依赖项中的脚本。

To run an executable when you are not currently inside a package,
use the [pub global](/tools/pub/cmd/pub-global) command.

可以使用 [pub global](/tools/pub/cmd/pub-global) 命令来运行一个不存在于当前 Package 中的可执行对象。

## Running a script in your package's bin directory

## 运行位于你 Package bin 目录下的脚本

This is the simplest use case.

这是一个最简单的使用示例。

From the root of a package that contains `foo.dart`
in the `bin` directory, run the app using the following command:

假设一个 Package 根目录下包含 `bin` 目录，且该目录中包含有 `foo.dart` 文件，则你可以使用下述命令运行该应用：

```terminal
$ pub run foo arg1 arg2
```

This command looks in your package's `bin` directory for the
specified script and invokes it, passing in any arguments.

该命令会查找位于你 Package `bin` 目录下的指定脚本并以指定参数运行它。

## Running a script in another directory in your package

## 运行位于你 Package 其它目录下的脚本

To run a script inside a directory other than the top-level
bin directory (but within the package), prepend the path
to the name of the script.
For example, to run `foo.dart` in the `example/sub` directory:

如果你想运行位于 Package 其它目录中的脚本，只需要在脚本前加上对应的目录地址即可。例如，运行位于 `example/sub` 目录下的 `foo.dart`：

```terminal
$ pub run example/sub/foo arg1 arg2
```

## Running a script in a dependency

## 运行位于依赖项中的脚本

To run a script from the `bin` directory of a package that you depend on
in the pubspec, specify the package name.
For example, to run `bar.dart` in the foo package:

如果你想执行的脚本不在当前 Package 中而是在当前 Package 所依赖的其它 Package 的 `bin` 目录中，那么你需要在运行该脚本时指定 Package 的名称。例如运行名为 foo 的 Package 中的 `bar.dart` 脚本：

```terminal
$ pub run foo:bar arg
```

You can only run scripts out of another package's `bin` directory.
All other directories are private.

你只能运行位于其它 Package `bin` 目录下的脚本。而所有其它的目录则都是私有的。

## Options

## 选项

For options that apply to all pub commands, see
[Global options](/tools/pub/cmd#global-options).

你可以查阅 [全局选项](/tools/pub/cmd#global-options) 获取 Pub 命令所支持的命令选项。

<aside class="alert alert-info" markdown="1">
  *Problems?* See [Troubleshooting Pub](/tools/pub/troubleshoot).

  *有疑问？* 请查阅 [Pub 疑难协助](/tools/pub/troubleshoot)。
</aside>
