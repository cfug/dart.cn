---
# title: webdev
title: webdev 命令
# description: Command-line tools for Dart web development.
description: Dart Web 应用开发命令行工具。
ai-translated: true
---

This page explains how to use `webdev` to compile your app and
`build_runner` to test your app.

本页说明如何使用 `webdev` 编译应用，
以及如何使用 `build_runner` 测试应用。

## Setup

## 准备工作

Follow these instructions to get started using `webdev`.

请按下列说明开始使用 `webdev`。

Before you can use `webdev`, Add dependencies to the [build_runner][] 
and [build_web_compilers][] packages to your app. The `build_runner`
package adds scripting capabilities to `webdev`.

使用 `webdev` 之前，请把 [build_runner][] 
和 [build_web_compilers][] package 加到应用的依赖中。
`build_runner` package 为 `webdev` 增加脚本能力。

```console
$ dart pub add build_runner build_web_compilers --dev
```

### Installing and updating webdev

### 安装和更新 webdev

Use `dart install` to install `webdev` globally.

使用 `dart install` 全局安装 `webdev`。

```console
$ dart install webdev
```

Use the same command to update `webdev`. 
Update `webdev` when you update your Dart SDK,
or when `webdev` commands fail in a way you can't explain.

用同一条命令更新 `webdev`。
更新 Dart SDK 时请更新 `webdev`，
或者当 `webdev` 命令以你无法解释的方式失败时也要更新。

### Depending on build_* packages

### 依赖 build_* package

To use `webdev`, you must be in the root directory of a package that
depends on the **build_runner** and **build_web_compilers** packages.
If you're testing the app, it must also depend on **build_test**.

要使用 `webdev`，必须位于依赖 **build_runner** 和 **build_web_compilers**
package 的 package 根目录。
如果要测试应用，它还必须依赖 **build_test**。

To depend on these packages, add the following [dev_dependencies][] to
your app's `pubspec.yaml` file:

要依赖这些 package，请把下列 [dev_dependencies][]
加到应用的 `pubspec.yaml` 文件：

```yaml
  dev_dependencies:
    # ···
    build_runner: ^2.15.1
    build_test: ^3.5.16
    build_web_compilers: ^4.8.5
```

As usual after `pubspec.yaml` changes, run `dart pub get` or 
`dart pub upgrade`:

和往常一样，修改 `pubspec.yaml` 之后，请运行 `dart pub get` 或 
`dart pub upgrade`：

```console
$ dart pub get
```

## Using commands from Dart packages to compile and test

## 使用 Dart package 中的命令来编译和测试

This tool can compile in two ways: one that makes debugging easier
(`serve`) and one that makes for small, fast code (`build`).

这个工具可以用两种方式编译：一种便于调试（`serve`），
一种生成小而快的代码（`build`）。

The development compiler supports incremental updates and produces
[Asynchronous Module Definition (AMD) modules][amd-modules].
With [`webdev serve`](#serve), you can edit your Dart files, refresh in
Chrome, and see your edits in short order. This speed comes from
compiling updated modules, not all the packages that your app requires.

开发编译器支持增量更新，并生成
[异步模块定义（AMD）模块][amd-modules]。
使用 [`webdev serve`](#serve)，可以编辑 Dart 文件、在 Chrome 中刷新，
并很快看到修改。这种速度来自只编译更新过的模块，
而不是应用所需的全部 package。

The first compilation takes the longest as it compiles the entire app.
While [`serve`](#serve) command runs, successive builds should compile faster.

第一次编译最久，因为它要编译整个应用。
在 [`serve`](#serve) 命令运行期间，后续构建应该会编译得更快。

The production compiler generates a single, minified JavaScript file.

生产编译器会生成单个压缩后的 JavaScript 文件。

This section describes how to use the following commands:

本节说明如何使用下列命令：

[webdev serve](#serve)
: Runs a development server that continuously builds a JavaScript app.

  运行开发服务器，持续构建 JavaScript 应用。

[webdev build](#build)
: Builds a deployable version of a JavaScript app.

  构建可部署的 JavaScript 应用版本。

[build_runner test](#test)
: Runs tests.

  运行测试。

You can customize your build using build configuration files. 
To learn more about build configuration files, see the 
[build_web_compilers][] package.

可以使用构建配置文件自定义构建。
要进一步了解构建配置文件，请参阅
[build_web_compilers][] package。

[amd-modules]: https://github.com/amdjs/amdjs-api/blob/master/AMD.md#amd

### webdev serve {:#serve}

### webdev serve 命令

To serve a development version of your web app, run the following
command.

要提供 Web 应用的开发版本，请运行下面的命令。

```plaintext
$ webdev serve [--debug | --release] [ [<directory>[:<port>]] ... ]
```

This command launches a development server that serves your app and
watches for source code changes. By default, this command serves the
 app at [localhost:8080](localhost:8080):

该命令会启动开发服务器来提供应用，并监视源代码变化。
默认情况下，该命令在 [localhost:8080](localhost:8080) 提供应用：

```console
$ webdev serve
```

The first `webdev serve` compiles slow. After the first compile, it caches
assets on disk. This makes later builds compile faster.

第一次 `webdev serve` 编译较慢。第一次编译之后，它会把资源缓存到磁盘上。
这会让后续构建编译得更快。

:::note
The development compiler supports **only Chrome.**
To view your app in another browser,
use the production compiler.
The production compiler supports the latest two versions of Chrome,
Edge, Firefox, and Safari.

开发编译器 **只支持 Chrome**。
要在其他浏览器中查看应用，请使用生产编译器。
生产编译器支持 Chrome、Edge、Firefox 和 Safari 最新的两个版本。
:::

To enable [Dart DevTools][], add the `--debug` flag:

要启用 [Dart DevTools][]，请加上 `--debug` 参数：

```console
$ webdev serve --debug  # enables Dart DevTools
```

To use production compiler instead of development compiler, add the `--release` flag:

要使用生产编译器而不是开发编译器，请加上 `--release` 参数：

```console
$ webdev serve --release  # uses production compiler
```

You can specify different directory-port configurations. 

可以指定不同的目录与端口配置。

For example, the following command changes the test port from the
default (8081) to 8083:

例如，下面的命令把测试端口从默认的 8081 改为 8083：

```console
$ webdev serve web test:8083 # App: 8080; tests: 8083
```

### webdev build {:#build}

### webdev build 命令

Use the following command to build your app:

使用下面的命令构建应用：

```plaintext
$ webdev build [--no-release] --output [<dirname>:]<dirname>
```

By default, the `build` command uses the production JavaScript compiler to create a production version of your app. Add `--no-release` to compile with the development JavaScript compiler. Use the `--output` option to control where Dart compiles top-level project folders and writes its output.

默认情况下，`build` 命令使用生产 JavaScript 编译器创建应用的生产版本。加上 `--no-release` 可以用开发 JavaScript 编译器编译。使用 `--output` 选项控制 Dart 编译顶层项目文件夹以及写入输出的位置。

The following command shows how to compile the project's top-level
`web` folder into the `build` directory. This command uses the
production JavaScript compiler by default.

下面的命令把项目顶层的 `web` 文件夹编译到 `build` 目录。
该命令默认使用生产 JavaScript 编译器。

```console
$ webdev build --output web:build
```


### build_runner test {:#test}

### build_runner test 命令

Use the `build_runner test` command to run your app's component tests:

使用 `build_runner test` 命令运行应用的组件测试：

```console
$ dart run build_runner test [build_runner options] -- -p <platform> [test options]
```

:::tip
If the command fails to load the test file,
make sure that your app's `pubspec` has a `dev_dependency` on `build_test`.

如果命令无法加载测试文件，
请确认应用的 `pubspec` 中有对 `build_test` 的 `dev_dependency`。
:::

For example, here's how to run all Chrome platform tests:

例如，下面是运行全部 Chrome 平台测试的方法：

```console
$ dart run build_runner test -- -p chrome
```

To see all available build_runner options, use the `--help` or `-h` option:

要查看全部可用的 build_runner 选项，请使用 `--help` 或 `-h` 选项：

```console
$ dart run build_runner test -h
```

Dart passes arguments after the empty `--` argument directly to the
[test package][] runner. To see all command-line options for the
test package runner, use this command:

Dart 会把空的 `--` 参数之后的参数直接传给
[test package][] 的运行器。要查看 test package 运行器的全部命令行选项，
请使用这条命令：

```console
$ dart test -h
```

## More information

## 更多信息

For a complete list of `webdev` options, run `webdev --help` or see the
[webdev package][webdev].

要查看 `webdev` 选项的完整列表，请运行 `webdev --help`，或参阅
[webdev package][webdev]。

Also see the following pages:

另见下列页面：

* [build_runner:][build_runner]
  Introduces build_runner and its built-in commands,
  and points to more information.

  [build_runner][build_runner]
  介绍 build_runner 及其内置命令，并指向更多信息。

* [build_web_compilers:][build_web_compilers]
  Has information on configuring builds,
  with an example of using `dart2js_args` to specify
  [compiler options](/tools/dart-compile#js).

  [build_web_compilers][build_web_compilers]
  包含配置构建的信息，
  并有使用 `dart2js_args` 指定
  [编译器选项](/tools/dart-compile#js) 的例子。

[build_runner]: /tools/build_runner
[build_web_compilers]: {{site.pub-pkg}}/build_web_compilers
[Dart DevTools]: /tools/dart-devtools
[dev_dependencies]: /tools/pub/dependencies#dev-dependencies
[test package]: {{site.pub-pkg}}/test
[webdev]: {{site.pub-pkg}}/webdev
