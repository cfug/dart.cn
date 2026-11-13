---
# title: Configuring apps with compilation environment declarations
title: 用编译环境声明配置应用
# description: >-
#   Learn about using compilation environment declarations 
#   to customize application behavior.
description: 了解如何使用编译环境声明来定制应用行为。
showBreadcrumbs: false
lastVerified: 2023-02-23
ai-translated: true
---

You can specify compilation environment declarations
when building or running a Dart application.
Compilation environment declarations specify
configuration options as key-value pairs
that are accessed and evaluated at compile time.

构建或运行 Dart 应用时，可以指定编译环境声明。
编译环境声明以键值对的形式给出配置选项，
这些选项在编译时读取并求值。

:::note
This page uses "environment" to refer
to the Dart compilation environment. 
The common use of the term instead refers
to the operating system environment.

本页中的「environment」指的是 Dart 编译环境。
这个词更常见的含义是操作系统环境。
:::

Your app can use the values of environment declarations
to change its functionality or behavior.
Dart compilers can eliminate the code made unreachable
due to control flow using the environment declaration values.

应用可以使用环境声明的值来改变功能或行为。
Dart 编译器可以根据这些值，
消除因控制流而变得不可达的代码。

You might define and use environment declarations to:

你可以定义并使用环境声明来：

* Add functionality during debugging, such as enabling logging.

  在调试期间增加功能，例如启用日志。

* Create separate flavors of your application.

  为应用创建不同的 flavor。

* Configure application behavior, such as the port of an HTTP server.

  配置应用行为，例如 HTTP 服务器的端口。

* Enable an experimental mode of your application for testing.

  为测试启用应用的实验模式。

* Switch between testing and production backends.

  在测试后端和生产后端之间切换。

To specify an environment declaration
when running or compiling a Dart application,
use the `--define` option or its abbreviation, `-D`.
Specify the declaration key-value pair
using a `<NAME>=<VALUE>` format:

运行或编译 Dart 应用时，
用 `--define` 选项或其缩写 `-D` 指定环境声明。
键值对使用 `<NAME>=<VALUE>` 格式：

```console
$ dart run --define=DEBUG=true -DFLAVOR=free
```

To learn how to set these declarations with other tools, 
check out the [specifying environment declarations][] section in this guide.
That section explains the declaration syntax and
how to specify them on the command line and in IDEs and editors.

要了解如何用其他工具设置这些声明，
请阅读本指南中的 [指定环境声明][specifying environment declarations] 一节。
该节说明声明的语法，
以及如何在命令行、IDE 和编辑器中指定它们。

[`dart run`]: /tools/dart-run
[`dart compile`]: /tools/dart-compile
[specifying environment declarations]: #specifying-environment-declarations

## Accessing environment declarations

## 访问环境声明

To access specified environment declaration values,
use one of the `fromEnvironment` constructors
with `const` or within a constant context.
Use [`bool.fromEnvironment`][bool-from] for `true` or `false` values,
[`int.fromEnvironment`][int-from] for integer values,
and [`String.fromEnvironment`][string-from] for anything else.

要访问已指定的环境声明值，
请在 `const` 或常量上下文中使用某个 `fromEnvironment` 构造函数。
`true` 或 `false` 用 [`bool.fromEnvironment`][bool-from]，
整数值用 [`int.fromEnvironment`][int-from]，
其他值用 [`String.fromEnvironment`][string-from]。

:::note
The environment declaration constructors are only guaranteed
to work when invoked as `const`.
Most compilers must be able to evaluate their value at compile time.

只有以 `const` 方式调用时，
环境声明构造函数才保证可用。
大多数编译器必须能在编译时求出它们的值。
:::

Each of the `fromEnvironment` constructors require the
name or key of the environment declaration.
They also accept an optional `defaultValue` named argument
to override the default fallback value.
The default fallback value is used when a declaration isn't defined
or the specified value cannot be parsed as the expected type.

每个 `fromEnvironment` 构造函数都需要环境声明的名称或键。
它们还接受可选的命名参数 `defaultValue`，
用来覆盖默认的回退值。
当声明未定义，或指定的值无法解析为期望类型时，
会使用默认回退值。

For example, if you want to print log messages
only when the environment declaration `DEBUG` is set to `true`:

例如，只在环境声明 `DEBUG` 设为 `true` 时打印日志：

<?code-excerpt "misc/lib/development/environment_declarations.dart (debug-log)"?>
```dart
void log(String message) {
  // Log the debug message if the environment declaration 'DEBUG' is `true`.
  // If there was no value specified, do not log.
  if (const bool.fromEnvironment('DEBUG', defaultValue: false)) {
    print('Debug: $message');
  }
}
```

In this snippet, if `DEBUG` is set to `false`
during compilation, or not specified at all,
production compilers can completely remove the condition and its body.

在这段代码中，如果编译时 `DEBUG` 设为 `false`，
或者根本没有指定，
生产环境编译器可以完全移除该条件及其代码体。

The `fromEnvironment` constructors fallback to 
a default value when the declaration isn't specified or
the specified value cannot be parsed.
Therefore, to specifically check whether
an environment declaration has been specified,
use the [`bool.hasEnvironment`][bool-has] constructor:

当声明未指定，或指定的值无法解析时，
`fromEnvironment` 构造函数会回退到默认值。
因此，要专门检查某个环境声明是否已经指定，
请使用 [`bool.hasEnvironment`][bool-has] 构造函数：

<?code-excerpt "misc/lib/development/environment_declarations.dart (has-debug)"?>
```dart
if (const bool.hasEnvironment('DEBUG')) {
  print('Debug behavior was configured!');
}
```

[string-from]: {{site.dart-api}}/dart-core/String/String.fromEnvironment.html
[int-from]: {{site.dart-api}}/dart-core/int/int.fromEnvironment.html
[bool-from]: {{site.dart-api}}/dart-core/bool/bool.fromEnvironment.html
[bool-has]: {{site.dart-api}}/dart-core/bool/bool.hasEnvironment.html

## Specifying environment declarations

## 指定环境声明

:::warning
Dart tools and compilers currently do not
consistently handle environment declarations
with comma-separated values.
To track standardization of this handling,
reference [SDK issue 44995][].

Dart 工具和编译器目前对包含逗号分隔值的环境声明
处理并不一致。
该行为的标准化进展见 [SDK issue 44995][]。
:::

[SDK issue 44995]: {{site.repo.dart.sdk}}/issues/44995

### Dart CLI

### Dart 命令行

Both `dart run` and the `dart compile` subcommands accept
any number of the `-D` or `--define` options
to specify environment declaration values.

`dart run` 和 `dart compile` 的各个子命令
都接受任意数量的 `-D` 或 `--define` 选项，
用来指定环境声明的值。

```console
$ dart run --define=DEBUG=true -DFLAVOR=free main.dart
$ dart compile exe --define=DEBUG=true -DFLAVOR=free main.dart
$ dart compile js --define=DEBUG=true -DFLAVOR=free main.dart
$ dart compile aot-snapshot --define=DEBUG=true -DFLAVOR=free main.dart
$ dart compile jit-snapshot --define=DEBUG=true -DFLAVOR=free main.dart
$ dart compile kernel --define=DEBUG=true -DFLAVOR=free main.dart
```

#### `webdev`

#### `webdev` 配置

To learn about configuring `webdev` to pass environment declarations
to both the development and production web compilers,
check out [the `webdev` configuration documentation][webdev-config].

要了解如何配置 `webdev`，
把环境声明传给开发和生产环境的 Web 编译器，
请参阅 [`webdev` 配置文档][webdev-config]。

[webdev-config]: {{site.pub-pkg}}/build_web_compilers#configuring--d-environment-variables

### Visual Studio Code

### Visual Studio Code 配置

In your launch configuration (`launch.json`) under `configurations`,
add a new `toolArgs` key containing your desired environment declarations:

在启动配置（`launch.json`）的 `configurations` 下，
新增 `toolArgs` 键，写入需要的环境声明：

```json
"configurations": [
    {
        "name": "Dart",
        "request": "launch",
        "type": "dart",
        "toolArgs": [
          "--define=DEBUG=true"
        ]
    }
]
```

To learn more, check out the documentation for
[VS Code launch configurations.][VSC instructions]

更多内容请参阅
[VS Code 启动配置][VSC instructions] 文档。

[VSC instructions]: https://code.visualstudio.com/docs/editor/debugging#_launch-configurations

### JetBrains IDEs

### JetBrains IDE

In the **Run/Debug Configurations** for your project,
add your desired environment declarations to **VM options**:

在项目的 **Run/Debug Configurations** 中，
把需要的环境声明加到 **VM options**：

![Adding define option to Jetbrains IDE](/assets/img/env-decl-jetbrains.png){:width="500"}

To learn more, check out JetBrains' documentation for
[Dart Run/Debug Configurations][jetbrains-run-debug].

更多内容请参阅 JetBrains 关于
[Dart Run/Debug Configurations][jetbrains-run-debug] 的文档。

[jetbrains-run-debug]: https://www.jetbrains.com/help/webstorm/run-debug-configuration-dart-command-line-application.html

### Flutter

### Flutter 工具

To specify environment declarations to the Flutter tool,
use the `--dart-define` option instead:

向 Flutter 工具指定环境声明时，
请改用 `--dart-define` 选项：

```console
$ flutter run --dart-define=DEBUG=true
```

{%- comment %}
  TODO: Once Flutter adds `--dart-define` documentation:
  To learn more, check out Flutter's documentation on `--dart-define`.
{% endcomment -%}
