---
# title: 'Java interop using package:jnigen'
title: '使用 package:jnigen 进行 Java 互操作'
# shortTitle: Java interop
shortTitle: Java 互操作
# breadcrumb: Java
breadcrumb: Java
# description: >-
#   To use Java in your Dart program, use package:jnigen.
description: 在 Dart 程序中使用 package:jnigen 调用 Java。
ai-translated: true
example: 'https://github.com/HosseinYousefi/jnigen_example/tree/main'
---

Dart mobile, command-line, and server apps
running on the [Dart Native platform](/overview#platform), on
Android, Windows, macOS, and Linux can use [`package:jni`][jni-pkg]
and [`package:jnigen`][jnigen-pkg]
to call Java and Kotlin APIs.

运行在 [Dart 原生平台](/overview#platform) 上的
Dart 移动端、命令行和服务端应用，
在 Android、Windows、macOS 和 Linux 上可以使用
[`package:jni`][jni-pkg] 和 [`package:jnigen`][jnigen-pkg]
调用 Java 和 Kotlin API。

:::note
This interop feature is **experimental**,
and [in active development]({{site.repo.dart.sdk}}/issues/49674).

此互操作功能仍处于 **实验** 阶段，
并且 [正在积极开发中]({{site.repo.dart.sdk}}/issues/49674)。
:::

`package:jni` allows Dart code to interact
with Java through [JNI][jnidoc].
However, doing so involves a lot of boilerplate code,
so you can use `package:jnigen` to automatically generate
the Dart bindings for a given Java API.

`package:jni` 让 Dart 代码可以通过 [JNI][jnidoc] 与 Java 交互。
不过，手写这些调用需要大量样板代码，
因此你可以使用 `package:jnigen`
为指定的 Java API 自动生成 Dart 绑定。

You can compile Kotlin to Java bytecode, allowing `package:jnigen`
to generate bindings for Kotlin as well.

你可以将 Kotlin 编译为 Java 字节码，
这样 `package:jnigen` 也能为 Kotlin 生成绑定。

[jni-pkg]: {{site.pub-pkg}}/jni
[jnigen-pkg]: {{site.pub-pkg}}/jnigen
[jnidoc]: https://docs.oracle.com/en/java/javase/17/docs/specs/jni/index.html

## Simple Java example

## 简单的 Java 示例

This guide walks you through [an example]({{page.example}})
that uses `package:jnigen` to generate bindings for a simple class.

本指南带你完成 [一个示例]({{page.example}})，
使用 `package:jnigen` 为一个简单的类生成绑定。

### Prerequisites

### 前提条件

- JDK

  需要安装 JDK。

### Configure `jnigen`

### 配置 `jnigen`

First, add `package:jni` as a dependency and
`package:jnigen` as a [dev dependency][].

首先，将 `package:jni` 添加为依赖，
并将 `package:jnigen` 添加为 [开发依赖][dev dependency]。

```console
$ dart pub add jni dev:jnigen
```

Next, create a top-level file called `jnigen.yaml`. 
This file contains the configuration for generating the bindings.

接下来，在顶层创建一个名为 `jnigen.yaml` 的文件。
该文件包含生成绑定所需的配置。

```yaml
output:
  dart:
    path: lib/example.dart
    structure: single_file

source_path:
  - 'java/'
classes:
  - 'dev.dart.Example'
```

`path` specifies the path for the generated `dart` bindings.

`path` 指定生成的 `dart` 绑定的路径。

`source_path` specifies the path of the Java source file that
you want to generate bindings for, 
and `classes` specifies the Java class.

`source_path` 指定要为其生成绑定的 Java 源文件路径，
`classes` 指定 Java 类。

`java/dev/dart/Example.java` contains a very simple class, which
has a public static method called `sum`:

`java/dev/dart/Example.java` 包含一个非常简单的类，
其中有一个名为 `sum` 的公开静态方法：

```java
package dev.dart;

public class Example {
  public static int sum(int a, int b) {
    return a + b;
  }
}
```

### Generate the Dart bindings

### 生成 Dart 绑定

To generate the Dart bindings, run `jnigen` and
specify the config file using the `--config` option:

要生成 Dart 绑定，请运行 `jnigen`，
并用 `--config` 选项指定配置文件：

```console
$ dart run jnigen --config jnigen.yaml
```

In this example, this generates
[`lib/example.dart`]({{page.example}}/lib/example.dart), just
as you specified in `jnigen.yaml`.

在本示例中，这会生成
[`lib/example.dart`]({{page.example}}/lib/example.dart)，
与你在 `jnigen.yaml` 中指定的一致。

This file contains a class called `Example`, 
which has a static method called `sum`, 
just like the Java file.

该文件包含一个名为 `Example` 的类，
其中有一个名为 `sum` 的静态方法，
与 Java 文件一致。

### Use the bindings

### 使用绑定

Now you're ready to load and interact with the generated library.
The example app, [`bin/sum.dart`]({{page.example}}/bin/sum.dart), gets 
two numbers as arguments and prints their sum. 
Using the `Example.sum` method is identical to Java.

现在可以加载生成的库并与之交互。
示例应用 [`bin/sum.dart`]({{page.example}}/bin/sum.dart)
接收两个数字作为参数，并打印它们的和。
调用 `Example.sum` 方法的方式与 Java 相同。

```dart
// a and b are integer arguments
print(Example.sum(a, b));
```

### Run the example

### 运行示例

Before running the example, 
you must build the dynamic library for `jni`.
The Java sources also must be compiled. To do so, run:

运行示例之前，
你必须为 `jni` 构建动态库。
Java 源文件也必须编译。为此，请运行：

```console
$ dart run jni:setup
$ javac java/dev/dart/Example.java
```

Now you can run the example:

现在可以运行示例：

```console
$ dart run jnigen_example:sum 17 25
```

Which outputs `42`!

输出为 `42`！

## More examples

## 更多示例

The following are some more comprehensive examples of using `package:jnigen`:

下面是一些更完整的 `package:jnigen` 使用示例：

| <t>**Example**</t><t>**示例**</t> | <t>**Description**</t><t>**说明**</t> |
|-------------------------|-------------------------------------------------------------------------------------------------|
| [in_app_java][]         | Demonstrates how to include custom Java code in a Flutter application and call it use `jnigen`. |
| [in_app_java][]         | 演示如何在 Flutter 应用中加入自定义 Java 代码，并用 `jnigen` 调用它。 |
| [pdfbox_plugin][]       | Example of a Flutter plugin that provides bindings to the [Apache PDFBox][] library.            |
| [pdfbox_plugin][]       | 一个 Flutter 插件示例，为 [Apache PDFBox][] 库提供绑定。 |
| [notification_plugin][] | Example of a reusable Flutter plugin with custom Java code that uses Android libraries.         |
| [notification_plugin][] | 一个可复用的 Flutter 插件示例，包含使用 Android 库的自定义 Java 代码。 |

{:.table}

[dev dependency]: /tools/pub/dependencies#dev-dependencies
[in_app_java]: {{site.repo.dart.org}}/native/tree/main/pkgs/jnigen/example/in_app_java
[notification_plugin]: {{site.repo.dart.org}}/native/tree/main/pkgs/jnigen/example/notification_plugin
[pdfbox_plugin]: {{site.repo.dart.org}}/native/tree/main/pkgs/jnigen/example/pdfbox_plugin
[Apache PDFBox]: https://pdfbox.apache.org/
