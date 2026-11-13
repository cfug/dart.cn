---
# title: "Introducing Realm for Dart & Flutter"
title: "Realm for Dart & Flutter 登场"
# description: "A case study in using Dart platform primitives to build a rich multi-platform library for Dart and Flutter apps."
description: "一个案例研究：用 Dart 平台原语为 Dart 和 Flutter 应用构建丰富的多平台库。"
ai-translated: true
publishDate: 2023-02-09
author: mit-mit
image: images/1cAi4WO4IfN5Sp6WE6Ex8Ig.webp
category: announcements
layout: blog
---


We’re excited to see MongoDB announce the general availability (GA) of Realm for Dart and Flutter today! Realm is a reactive, object-oriented, cross-platform database, popular among app developers. In other words, perfect for Dart and Flutter. So, over the past year we’ve collaborated with MongoDB to bring Realm to Dart and Flutter. Checkout the [blog post](https://www.mongodb.com/developer/products/realm/announcing-realm-flutter-sdk/) by MongoDB for details on what Realm offers, how it’s improved from their earlier previews, and what they have planned for the future. We think Realm will be a great match for Dart & Flutter developers.

我们很高兴看到 MongoDB 今天宣布 Realm for Dart and
Flutter 正式发布（GA）！Realm 是一个响应式、面向对象、
跨平台的数据库，深受应用开发者欢迎。
换句话说，非常适合 Dart 和 Flutter。
过去一年里我们与 MongoDB 合作，把 Realm 带到 Dart 和
Flutter。Realm 提供什么、相比早期预览有何改进、
未来有什么计划，详情请看 MongoDB 的
[博客文章](https://www.mongodb.com/developer/products/realm/announcing-realm-flutter-sdk/)。
我们认为 Realm 会是 Dart 和 Flutter 开发者的绝佳搭档。

<DashImage src="images/1cAi4WO4IfN5Sp6WE6Ex8Ig.webp" alt="Code snippet demonstrating how to write books to a Realm data store using Dart." caption="Writing books to a Realm data store using Dart" />


In this companion post, we’ll take a peek behind the scenes to learn how Realm for Dart & Flutter is built, as a practical example of how to build new Dart-based developer SDKs.

在这篇配套文章中，我们将窥探幕后，
了解 Realm for Dart & Flutter 是如何构建的，
作为构建基于 Dart 的新开发者 SDK 的实战示例。

## Realm example

## Realm 示例

Before we dig into the implementation of the Realm SDK, let’s start with a quick tour of how to use the SDK as a developer working on a Dart [terminal app](https://dart.dev/tutorials/server/cmdline) (*note*: the steps for a Flutter app are slightly different; see [the documentation](https://www.mongodb.com/docs/realm/sdk/flutter/install/) for details).

在深入 Realm SDK 的实现之前，先快速浏览一下
作为 Dart [终端应用](https://dart.dev/tutorials/server/cmdline)
开发者该如何使用这个 SDK（*注意*：Flutter 应用的步骤
略有不同；详见[文档](https://www.mongodb.com/docs/realm/sdk/flutter/install/)）。

First, you define a data model. This is done using regular Dart classes with some added Realm annotations. Here’s a sample data class for a book:

首先，定义数据模型。用普通 Dart 类加上一些 Realm
注解即可完成。下面是一个图书数据类示例：


With the model defined, and the data model fully generated (see below), you can go ahead and write some books to a Realm data store:

定义好模型、完整生成数据模型（见下文）之后，
你就可以往 Realm 数据存储中写入一些图书了：



## How Realm for Dart and Flutter was built

## Realm for Dart and Flutter 是如何构建的

Now that we’ve covered the basics, let’s see how the MongoDB team built Realm for Dart and Flutter utilizing a number of Dart libraries and tools. We’ll take a look at what happens when the Realm SDK is initialized, how the Realm SDK is built on top of a shared native C++ library, how the Realm terminal tool was built, and how Realm models are generated.

基础介绍完毕，来看看 MongoDB 团队如何利用一系列
Dart 库和工具构建 Realm for Dart and Flutter。
我们会看看 Realm SDK 初始化时发生了什么、
SDK 如何构建在共享的原生 C++ 库之上、
Realm 终端工具如何构建，以及 Realm 模型如何生成。

## Initializing the Realm SDK

## 初始化 Realm SDK

Dart and Flutter developers will start by adding Realm to their existing app, and then running the installer:

Dart 和 Flutter 开发者首先把 Realm 加入既有应用，
然后运行安装器：

```shell
dart pub add realm_dart
dart run realm_dart install
```


The first step simply adds the Realm SDK to `pubspec.yaml` to [register it as a dependency](https://dart.dev/tools/pub/dependencies) of the app. The second step runs the Realm terminal tool, asking it to install the SDK. If we look inside the [source code for the install command](https://github.com/realm/realm-dart/blob/main/lib/src/cli/install/install_command.dart), we can see `install` determines what operating system we are developing on, and then downloads the Realm SDK binaries for that operating system.

第一步只是把 Realm SDK 加进 `pubspec.yaml`，
把它[注册为应用的依赖](https://dart.dev/tools/pub/dependencies)。
第二步运行 Realm 终端工具，让它安装 SDK。
看看 [install 命令的源代码](https://github.com/realm/realm-dart/blob/main/lib/src/cli/install/install_command.dart)
就会发现，`install` 先判断我们在什么操作系统上开发，
然后下载该操作系统的 Realm SDK 二进制文件。

But why is the install command downloading a binary? The Realm SDK is a very comprehensive offering, available across a large range of operating systems and developer frameworks. To avoid having to build a large number of instantiations of the Realm SDK, the Realm team decided to implement the core Realm SDK as a shared [realm-core C++ library](https://github.com/realm/realm-core). So, what the install command really does is download compiled versions of this core library for all platforms the app supports.

但为什么 install 命令要下载二进制文件？
Realm SDK 是一个非常全面的产品，
覆盖大量操作系统和开发框架。
为了避免构建大量 Realm SDK 实例，Realm 团队决定
把核心 SDK 实现为共享的
[realm-core C++ 库](https://github.com/realm/realm-core)。
所以 install 命令真正做的，是为应用支持的所有平台
下载这个核心库的编译版本。

## Calling into the realm-core SDK

## 调用 realm-core SDK

Users of the Realm SDK writing Dart or Flutter apps get nice, strongly typed Dart APIs, as illustrated in the beginning of this post. How do those APIs correspond to the [`realm-core`](https://github.com/realm/realm-core) C++ library?

用 Realm SDK 编写 Dart 或 Flutter 应用的用户
得到的是友好的强类型 Dart API，正如本文开头所示。
这些 API 如何对应
[`realm-core`](https://github.com/realm/realm-core) C++ 库？

If we peek inside the `lib` directory of the Realm SDK we find [`realm_bindings.dart`](https://github.com/realm/realm-dart/blob/main/lib/src/native/realm_bindings.dart), which starts with:

窥探 Realm SDK 的 `lib` 目录，我们会找到
[`realm_bindings.dart`](https://github.com/realm/realm-dart/blob/main/lib/src/native/realm_bindings.dart)，
它的开头是：


Mystery solved: The Realm SDK uses Dart’s support for interoperability with native APIs via the `dart:ffi` library to call into realm-core. To avoid having to write FFI bindings manually for the very large set of available Realm APIs, the bindings are auto generated using Dart’s [`ffigen`](https://pub.dev/packages/ffigen)tool. This is a pattern we’re seeing rapid growth of across the Dart team.

谜底揭晓：Realm SDK 利用 Dart 通过 `dart:ffi` 库
与原生 API 互操作的支持来调用 realm-core。
为了避免为数量庞大的 Realm API 手写 FFI 绑定，
这些绑定用 Dart 的
[`ffigen`](https://pub.dev/packages/ffigen) 工具自动生成。
这种模式在整个 Dart 团队中正快速增长。

## The Realm terminal tool

## Realm 终端工具

Let’s turn to the Realm terminal tool itself. Above, we ran the install command, but we can also run the tool without specifying a command:

再来看 Realm 终端工具本身。上面我们运行了 install 命令，
但也可以不指定命令直接运行这个工具：

```shell
$ dart run realm_dart
Realm commands for working with Realm Flutter & Dart SDKs.

Usage: dart run realm|realm_dart <command> [arguments]

Global options:
-h, --help    Print this usage information.

Available commands:
  generate   Generate Realm objects from data model classes
  install    Download & install Realm native binaries into a Flutter or Dart project
  metrics    Report anonymized builder metrics to Realm

Run "dart run realm|realm_dart help <command>" for more information about a command.
```


You may notice that this output looks a lot like the output from the core dart and flutter tool. This is no coincidence; all three tools are built using the same Dart foundation libraries for terminal tools from [`package:args`](https://pub.dev/packages/args):

你可能注意到这个输出很像 dart 和 flutter 核心工具的输出。
这不是巧合；这三个工具都使用来自
[`package:args`](https://pub.dev/packages/args)
的同一套 Dart 终端工具基础库构建：

* The [`args`](https://pub.dev/documentation/args/latest/args/args-library.html) library has rich support for parsing raw command line arguments into options and flags

  [`args`](https://pub.dev/documentation/args/latest/args/args-library.html)
  库对把原始命令行参数解析为选项和标志有丰富支持

* The [`command_runner`](https://pub.dev/documentation/args/latest/command_runner/command_runner-library.html) library provides a structure for commands supported by the tool (e.g. install)

  [`command_runner`](https://pub.dev/documentation/args/latest/command_runner/command_runner-library.html)
  库为工具支持的命令（如 install）提供结构

## Generating the Realm model

## 生成 Realm 模型

The `generate` command is especially interesting because it generates the full Realm model from the annotated Dart model classes that we defined in the “Realm example” section:

`generate` 命令尤其有趣，因为它从我们在
“Realm 示例”一节定义的带注解 Dart 模型类
生成完整的 Realm 模型：

```shell
dart run realm_dart generate
```


How does the generate command work? It relies on the Realm [generator](https://github.com/realm/realm-dart/blob/main/generator/README.md), which is built on top of Dart’s [`build_runner`](https://pub.dev/packages/build_runner), a framework for generators that takes a set of input files and then creates new output files. Typically — as in the Realm case — the inputs are Dart source code files with annotations, and the output files are additional generated Dart source code.

generate 命令如何工作？它依赖 Realm
[生成器](https://github.com/realm/realm-dart/blob/main/generator/README.md)，
后者构建在 Dart 的
[`build_runner`](https://pub.dev/packages/build_runner) 之上——
一个接收一组输入文件并创建新输出文件的生成器框架。
通常——正如 Realm 的情况——输入是带注解的
Dart 源代码文件，输出是额外生成的 Dart 源代码。

## Closing thoughts

## 结语

We hope you enjoyed this peek behind the curtain of how a large developer framework can be built from a set of reusable Dart libraries. If you are a framework developer, hopefully this can give you some inspiration for your next Dart-based framework.

希望你喜欢这次幕后窥探：一个大型开发者框架
如何由一组可复用的 Dart 库构建而成。
如果你是框架开发者，希望这能为你下一个
基于 Dart 的框架带来一些灵感。

For Dart and Flutter app developers, Realm is a great new offering from the MongoDB team. We invite you to check out the [Realm SDK documentation](https://www.mongodb.com/docs/realm/sdk/flutter/), and today’s [Realm blog post](https://www.mongodb.com/developer/products/realm/announcing-realm-flutter-sdk/).

对 Dart 和 Flutter 应用开发者来说，
Realm 是 MongoDB 团队带来的出色新产品。
我们邀请你查看
[Realm SDK 文档](https://www.mongodb.com/docs/realm/sdk/flutter/)
和今天的
[Realm 博客文章](https://www.mongodb.com/developer/products/realm/announcing-realm-flutter-sdk/)。