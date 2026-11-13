---
# title: Command-line and server libraries and packages
title: 命令行与服务端库和 package
# shortTitle: CLI & server libraries
shortTitle: 命令行与服务端库
# description: >-
#   Libraries and packages that can help you
#   write Dart command-line & server apps.
description: 帮助你编写 Dart 命令行与服务端应用的库和 package。
ai-translated: true
---

The [Dart SDK][] contains [dart:io][] and other libraries
that provide low-level command-line and server APIs.

[Dart SDK][] 包含 [dart:io][] 以及其他库，
提供底层的命令行和服务端 API。

[Dart SDK]: /tools/sdk
[dart:io]: {{site.dart-api}}/dart-io/dart-io-library.html

## SDK libraries

## SDK 库

The Dart SDK contains dart:io and other libraries
that provide low-level web APIs.

Dart SDK 包含 dart:io 以及其他库，
提供底层 Web API。

[The dart:io documentation](/libraries/dart-io)
: An example-driven tour of using the dart:io library.
  Topics include working with files & directories, and making & handling 
  HTTP requests.

[`dart:io` 文档](/libraries/dart-io)
: 以示例为主，介绍 dart:io 库的用法。
  主题包括处理文件与目录，以及发起和处理 HTTP 请求。

[dart:io API reference][dart:io]
: Complete reference documentation for the dart:io library.

[dart:io API 参考][dart:io]
: dart:io 库的完整参考文档。


## Community packages

## 社区 package

The [pub.dev site]({{site.pub}}) allows you to search for packages
that support command-line and server apps
by specifying the platforms your app needs to support.
You can also search for words that describe the functionality you need.

[pub.dev 网站]({{site.pub}}) 让你可以搜索
支持命令行和服务端应用的 package，
只需指定应用需要支持的平台。
你也可以搜索描述所需功能的关键词。

### Command-line packages

### 命令行 package

Command-line apps often use the following packages,
in addition to [general-purpose packages][] such as `archive`, `intl`, and `yaml`:

命令行应用除了 [通用 package][general-purpose packages]
（例如 `archive`、`intl` 和 `yaml`）之外，
还经常使用以下 package：


| <t>**Package**</t><t>**Package**</t> | <t>**Description**</t><t>**说明**</t> |
|-------------------------------------------|---------------------------------------------------------------------------|
| [args]({{site.pub-pkg}}/args)             | Parses raw command-line arguments into a set of options and values.       |
| [args]({{site.pub-pkg}}/args)             | 将原始命令行参数解析为一组选项和值。 |
| [cli_util]({{site.pub-pkg}}/cli_util)     | Provides utilities for building command-line apps.                        |
| [cli_util]({{site.pub-pkg}}/cli_util)     | 提供构建命令行应用的实用工具。 |
| [completion]({{site.pub-pkg}}/completion) | Adds command-line completion to apps that use the `args` package.         |
| [completion]({{site.pub-pkg}}/completion) | 为使用 `args` package 的应用添加命令行补全。 |
| [path]({{site.pub-pkg}}/path)             | Provides comprehensive, cross-platform operations for manipulating paths. |
| [path]({{site.pub-pkg}}/path)             | 提供全面的跨平台路径操作。 |
| [usage]({{site.pub-pkg}}/usage)           | Wraps Google Analytics.                                                   |
| [usage]({{site.pub-pkg}}/usage)           | 封装 Google Analytics。 |

{:.table .table-striped .nowrap}

### Server packages

### 服务端 package

Server apps can choose from many packages, in addition to
the packages listed in the previous table
and [general-purpose packages][] such as `logging`:

服务端应用除了上一张表中的 package，
以及 `logging` 等 [通用 package][general-purpose packages] 之外，
还可以从许多 package 中选择：

| <t>**Package**</t><t>**Package**</t> | <t>**Description**</t><t>**说明**</t> |
|-----------------------------------------|-----------------------------------------------------------------------------------------------------------------------|
| [crypto]({{site.pub-pkg}}/crypto)       | Implements cryptographic hashing functions for algorithms such as SHA-1, SHA-256, MD5, and HMAC.                      |
| [crypto]({{site.pub-pkg}}/crypto)       | 实现 SHA-1、SHA-256、MD5 和 HMAC 等算法的加密散列函数。 |
| [grpc]({{site.pub-pkg}}/grpc)           | Implements [gRPC][], a high performance, open source, general RPC framework that puts mobile and HTTP/2 first.        |
| [grpc]({{site.pub-pkg}}/grpc)           | 实现 [gRPC][]，一个高性能、开源的通用 RPC 框架，优先面向移动端和 HTTP/2。 |
| [shelf]({{site.pub-pkg}}/shelf)         | Provides a model for web server middleware that encourages composition and easy reuse.                                |
| [shelf]({{site.pub-pkg}}/shelf)         | 提供 Web 服务器中间件模型，便于组合和复用。 |
| [dart_frog]({{site.pub-pkg}}/dart_frog) | A fast, minimalistic backend framework for Dart built on top of Shelf.                                                |
| [dart_frog]({{site.pub-pkg}}/dart_frog) | 基于 Shelf 构建的快速、极简 Dart 后端框架。 |
| [serverpod]({{site.pub-pkg}}/serverpod) | A scalable app server that supports code generation, authentication, real-time communication, databases, and caching. |
| [serverpod]({{site.pub-pkg}}/serverpod) | 可扩展的应用服务器，支持代码生成、身份验证、实时通信、数据库和缓存。 |

{:.table .table-striped .nowrap}

[general-purpose packages]: /resources/useful-packages#general-purpose-packages
[gRPC]: https://grpc.io/
