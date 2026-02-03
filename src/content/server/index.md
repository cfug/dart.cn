---
# title: Command-line and server apps
title: 命令行和服务端应用
# shortTitle: CLI & server apps
shortTitle: 命令行和服务端应用
# description: All things relating to command-line and server apps.
description: 与命令行和服务端应用有关的内容。
showToc: false
---

This page points to tools and documentation
that can help you develop command-line and server apps.

本文向你展示可以帮助你开发命令行式和服务器应用的相关工具和文档。

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

[currently supported packages]: {{site.repo.dart.org}}/dart-pad/wiki/Package-and-plugin-support#currently-supported-packages

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

[Dart Frog](https://dart-frog.dev/)
<br> A fast, minimalistic backend framework for Dart.

[Dart Frog](https://dart-frog.dev/)
<br> 一个快速、简约的 Dart 后端框架。

More tools
<br> The [Tools](/tools) page links to generally useful tools,
  such as Dart plugins for your favorite IDE or editor.

更多工具：
<br> [工具](/tools) 界面链接了一些有用的工具，比如你喜欢的 IDE 或编辑器的 Dart 插件。

For additional options, see [#server packages on pub.dev][server-pkgs].

关于其他方案，请浏览 [#server packages on pub.dev][server-pkgs].

[server-pkgs]: {{site.pub-pkg}}?q=topic%3Aserver

## Samples

## 样例

[A simple Dart HTTP server][simple-sample]

[一个基础的 Dart HTTP 服务器][simple-sample]

  * Uses the [`shelf`][] package.

    使用 [`shelf`][] package。

  * Also uses the [`shelf_router`][] and [`shelf_static`][] packages.

    还使用了 [`shelf_router`][] 和 [`shelf_static`][] package。

  * Is deployable on Cloud Run.

    可在 Cloud Run 上部署。

[A Dart HTTP server that uses Cloud Firestore][cloud-sample]

[一个基于 Cloud Firestore 的 Dart HTTP 服务器][cloud-sample]

  * Uses the Cloud Firestore features in the [`googleapis`][] package.

    使用 [`googleapis`][] package 中的 Cloud Firestore 功能。

  * Also uses the [`googleapis_auth`][], [`shelf`][], and
    [`shelf_router`][] packages.

    还使用了 [`googleapis_auth`][]、[`shelf`][] 和 [`shelf_router`][] package。

  * Is deployable on Cloud Run.

    可在 Cloud Run 上部署。

[simple-sample]: {{site.repo.dart.samples}}/tree/main/server/simple
[cloud-sample]: {{site.repo.dart.samples}}/tree/main/server/google_apis
[`googleapis`]: {{site.pub-pkg}}/googleapis
[`googleapis_auth`]: {{site.pub-pkg}}/googleapis_auth
[`shelf`]: {{site.pub-pkg}}/shelf
[`shelf_router`]: {{site.pub-pkg}}/shelf_router
[`shelf_static`]: {{site.pub-pkg}}/shelf_static

## More resources

## 更多资源

[Dart API]({{site.dart-api}})
<br> API reference for dart:* libraries.

[Dart API]({{site.dart-api}})：
<br> dart:* 库的 API 参考。

[`dart:io` documentation](/libraries/dart-io)
<br> Shows how to use the major features of the dart:io library.
  You can use the dart:io library in command-line scripts, servers, and
  non-web [Flutter apps.]({{site.flutter}})

[`dart:io` 文档](/libraries/dart-io)：
<br> 向你展示如何使用 dart:io 库的主要功能。
你可以在命令行脚本、服务器应用以及不包含 Web 平台的
[Flutter 移动应用]({{site.flutter}}) 中使用 dart:io 库。

[Using Google Cloud][]
<br> Guides and documentation on Google Cloud products
  that Dart servers can use, such as Cloud Run.

[使用 Google Cloud][Using Google Cloud]
<br> Dart 服务器可使用的 Google Cloud 产品的指南和文档，例如 Cloud Run。

[Using Google APIs][]
<br> Resources to help you use Firebase and Google client APIs from a Dart app.

[使用 Google API][Using Google APIs]
<br> 帮助你在 Dart 应用中使用 Firebase 和 Google 客户端 API 的资源。

[Using Google Cloud]: /server/google-cloud
[Using Google APIs]: /resources/google-apis
