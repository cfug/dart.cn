---
# title: build_runner
title: build_runner 命令
# description: A tool for building, testing, and running Dart code.
description: 编译、测试和运行 Dart 代码的工具。
---

The [build_runner][] package provides general-purpose commands for
generating files, including testing the generated files
or serving both source and generated files.
This page explains how to use `build_runner`.
To learn how to use build_runner with a specific package,
see the documentation for that package.

[build_runner][] 这个 Package 提供了一些用于生成文件的通用命令，
这些命令中有的可以用于测试生成的文件，
有的可以用于对外提供这些生成的文件以及它们的源代码。
通过本文以及本文结尾处更多信息中的相关链接，
你可以对 build_runner 以及如何使用它有一个大概的了解。
至于如何针对某个特定 Package 使用 build_runner，
你可以参考该 Package 的相关文档。

:::note

**If you're a web developer**, use the [`webdev` tool][webdev] to
build and serve web apps.

**如果你是一名 Web 开发者：**，
你可以使用 [`webdev` 工具][webdev] 构建和启动 Web 应用。

:::

The build_runner commands work with _builders_—packages
that use the [Dart build system][build]
to generate output files from input files.
For example, the [json_serializable][] and [built_value_generator][]
packages define builders that generate Dart code.

build_runner 的命令需要与使用 [Dart 编译系统][build] 
从输入文件生成输出文件的生成器 Package 配合使用。
例如，[json_serializable][] 与 [built_value_generator][] 
这两个 Package 共同定义了生成 Dart 代码的生成器。

Although the Dart build system is a good alternative to
reflection (which has performance issues) and
macros (which Dart's compilers don't support),
it can do more than just read and write Dart code.
For example, the [sass_builder][] package implements a builder that
generates `.css` files from `.scss` and `.sass` files.

Dart 的编译系统是反射（目前还有些性能问题）
和宏指令（Dart 编译器还不支持）的替代方案，
它可以做的不仅仅是用于读写 Dart 代码。
例如，[sass_builder][] 这个 Package
实现了用于从 `.scss` 和 `.sass` 文件生成
`.css` 文件的生成器。

## Setting up build_runner

## build_runner 设置

To use build_runner, add a [dev dependency][] on **build_runner**
to your app's pubspec:

在你应用 pubspec 文件的 [dev dependency][] 层添加
**build_runner** 依赖以开启使用 build_runner：

<?code-excerpt "build_runner_usage/pubspec.yaml" from="dev_dependencies" to="build_test" replace="/args.*/# ···/g"?>
```yaml
dev_dependencies:
  # ···
  build_runner: ^2.4.8
  build_test: ^2.2.2
```

Depending on **build_test** is optional; do it if you'll be testing your code.

依赖项 **build_test** 是可选的；但是它可以让你测试你的代码。

As usual after `pubspec.yaml` changes, run `dart pub get` or `dart pub upgrade`:

像往常一样在你修改了 `pubspec.yaml` 文件后，
记得运行 `dart pub get` 或 `dart pub upgrade` 命令以令修改生效：

```console
$ dart pub get
```

## Using built-in commands

## 使用内置命令

The following is an example of using the build_runner **build** command:

下面是使用 build_runner 中 **build** 命令的示例：

```console
$ # From a directory that contains a pubspec.yaml file:
$ dart run build_runner build
```

The build_runner package includes the following commands:

build_runner 中包含下述几个命令：

`build`
<br> Performs a one-time build.

`build` 命令：
<br> 处理一次性构建。

`serve`
<br> Runs a development server.
  Instead of directly using this command,
  you can use [`webdev serve`,][webdev serve]
  which has convenient default behavior.

`serve` 命令：运行一个用于开发的服务器。
你可以使用 [`webdev serve`][webdev serve] 替代该命令，
它会包含一些方便的默认功能。

`test`
<br> Runs [tests.][tests]

`test` 命令
<br>用于运行 [测试][tests]。

`watch`
<br> Launches a build server that watches for edits to input files.
  Responds to changes by performing incremental rebuilds.

`watch` 命令
<br> 启动一个构建服务器用于监听输入文件的编辑。通过处理增量重建来响应代码的修改。

## More information

## 更多信息

If you're working on web-specific code,
see the [webdev page.][webdev]

如果你编写的代码针对的是 Web 应用，请查阅 [webdev 页面][webdev]。

For details on using build_runner, see the following:

你也可以通过下述链接查阅更多有关如何使用 build_runner 相关命令的信息：

- Documentation for packages that require you to use build_runner.
  These packages generally have a dependency
  [on build][] or [on build_runner.][]

  如果某个 Package 需要使用 build_runner，请认真阅读该 Package 的文档。
  这些 Package 通常都需要依赖
  [build][on build] 或 [build_runner][on build_runner.]。

- Build_runner documentation:

  build_runner 的相关文档：

  - [Getting started with build_runner][]

    [开始使用 build_runner][Getting started with build_runner]

  - [Build FAQ][]

    [构建常见问题][Build FAQ]

[build]: {{site.repo.dart.org}}/build
[Build FAQ]: {{site.repo.dart.org}}/build/blob/master/docs/faq.md
[build_runner]: {{site.pub-pkg}}/build_runner
[built_value_generator]: {{site.pub-pkg}}/built_value_generator
[dev dependency]: /tools/pub/dependencies#dev-dependencies
[Getting started with build_runner]: {{site.repo.dart.org}}/build/blob/master/docs/getting_started.md
[json_serializable]: {{site.pub-pkg}}/json_serializable
[on build]: {{site.pub-pkg}}?q=dependency%3Abuild
[on build_runner.]: {{site.pub-pkg}}?q=dependency%3Abuild_runner
[sass_builder]: {{site.pub-pkg}}/sass_builder
[tests]: /guides/testing
[webdev]: /tools/webdev
[webdev serve]: /tools/webdev#serve
