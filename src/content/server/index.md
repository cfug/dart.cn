---
# title: Command-line and server apps
title: 命令行和服务端应用
# short-title: CLI & server apps
short-title: 命令行和服务端应用
# description: All things relating to command-line and server apps.
description: 与命令行和服务端应用有关的内容。
toc: false
---

This page points to tools and documentation
that can help you develop command-line and server apps.

本文向你展示可以帮助你开发命令行式和服务器应用的相关工具和文档。

<p class="text-center">
  <a href="/tutorials/server/get-started" class="btn btn-primary btn-lg">开始使用</a>
</p>


## Tools

## 工具

[DartPad](/tools/dartpad)
<br> Handy for both beginners and experts,
  DartPad lets you try out language features and dart:* APIs.

[DartPad](/tools/dartpad)：
<br> 不管是对新手还是专家来说都易于使用的工具，
  DartPad 可以让你尝试语言相关功能和 dart:* 的 API。

  :::note

  DartPad does **not** support using VM libraries, such as `dart:io`,
  or importing libraries from packages
  besides the [currently supported packages][].

  DartPad 尚且 **不支持** 使用 VM 库，比如 `dart:io`，
  也不支持从导入其他 package，除了
  目前已经支持了导入 `bloc`、`characters`、`collection` 等 package，
  除了 [列举出的这些支持的 package][currently supported packages] 之外，
  DartPad 尚且 **不支持** 导入其他 package。
    
  :::

[currently supported packages]: https://github.com/dart-lang/dart-pad/wiki/Package-and-plugin-support#currently-supported-packages

[Dart SDK](/tools/sdk)
<br> [Install the Dart SDK](/get-dart) to get the core Dart
  libraries and [tools](/tools).

[Dart SDK](/tools/sdk)：
<br> [安装 Dart SDK](/get-dart) 以获取 Dart 的核心库和 [工具](/tools)。

## Frameworks

## 框架

Server-side frameworks written in Dart include:

使用 Dart 编写的服务器端框架包括:

[Serverpod](https://serverpod.dev)
<br> A scalable app server that supports code generation,
  authentication, real-time communication, databases, and caching.

[Serverpod](https://serverpod.dev)
<br> 支持代码生成的可扩展应用服务器，包含身份验证、实时通信、数据库和缓存。

[Dart Frog](https://dartfrog.vgv.dev/)
<br> A fast, minimalistic backend framework for Dart.

[Dart Frog](https://dartfrog.vgv.dev/)
<br> 一个快速、简约的 Dart 后端框架。

More tools
<br> The [Tools](/tools) page links to generally useful tools,
  such as Dart plugins for your favorite IDE or editor.

更多工具：
<br> [工具](/tools) 界面链接了一些有用的工具，比如你喜欢的 IDE 或编辑器的 Dart 插件。

For additional options, see [#server packages on pub.dev]({{site.pub}}/packages?q=topic%3Aserver).

关于其他方案，请浏览 [#server packages on pub.dev]({{site.pub}}/packages?q=topic%3Aserver).

## Tutorials

## 教程

You might find the following tutorials helpful.

你可能会发现以下的教程会比较有用。

[Get started](/tutorials/server/get-started)
<br> Learn how to use the Dart SDK to develop command-line and server apps.

[开始](/tutorials/server/get-started)：
<br> 学习如何使用 Dart SDK 开发命令行或服务器应用。

[gRPC Quickstart](https://grpc.io/docs/languages/dart/quickstart/)
<br> Walks you through running and modifying a client-server example that uses the gRPC framework.

[gRPC 快速上手](https://grpc.io/docs/quickstart/dart.html)：
<br> 手把手教你使用 gRPC 框架运行和修改一个客户端-服务器示例。

[Write command-line apps](/tutorials/server/cmdline)
<br> Introduces dart:io and the args package.

[开发 command-line 应用](/tutorials/server/cmdline)：
<br> dart:io 和 args package 的介绍。

[Write HTTP servers](/tutorials/server/httpserver)
<br> Features dart:io and the http_server package.

[开发 HTTP 客户端和服务端](/tutorials/server/httpserver)：
<br> dart:io 和 http_server 包的相关功能。

## More resources

## 更多资源

[Dart API]({{site.dart-api}}/{{site.sdkInfo.channel}})
<br> API reference for dart:* libraries.

[Dart API]({{site.dart-api}}/{{site.sdkInfo.channel}})：
<br> dart:* 库的 API 参考。

[dart:io documentation](/libraries/dart-io)
<br> Shows how to use the major features of the dart:io library.
  You can use the dart:io library in command-line scripts, servers, and
  non-web [Flutter apps.]({{site.flutter}})

[dart:io 文档](/libraries/dart-io)：
<br> 向你展示如何使用 dart:io 库的主要功能。
你可以在命令行脚本、服务器应用以及不包含 Web 平台的
[Flutter 移动应用]({{site.flutter}}) 中使用 dart:io 库。
