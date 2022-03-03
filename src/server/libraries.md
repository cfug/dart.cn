---
title: Command-line and server libraries and packages
title: 命令行和服务器的库和 Package
short-title: CLI & server libraries
short-title: CLI 和 服务器库
description: Libraries and packages that can help you write Dart command-line & server apps.
description: 库和 Package 可以帮助你开发命令行和服务器应用。
---

The [Dart SDK][] contains [dart:io][] and other libraries
that provide low-level command-line & server APIs.

[Dart SDK][] 包含 [dart:io][] 和其它提供底层命令行和服务器 API 的库。

[Dart SDK]: /tools/sdk
[dart:io]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-io/dart-io-library.html

## SDK libraries

## SDK 库

The Dart SDK contains dart:io and other libraries
that provide low-level web APIs.

Dart SDK 包含 dart:io 和其它提供底层 web API 的库。

[The dart:io section](/guides/libraries/library-tour#dartio) of the library tour
<br> An example-driven tour of using the dart:io library.
  Topics include working with files & directories, and making & handling
  HTTP requests.

库概览的 [dart:io 小节](/guides/libraries/library-tour#dartio)：
<br> 一个使用 dart:io 库的示例驱动概览。主要包括如何使用文件和目录以及发起和处理 HTTP 请求。

[dart:io API reference][dart:io]
<br> Complete reference documentation for the dart:io library.

[dart:io API 参考][dart:io]：
<br> 完整的 dart:io 库参考文档。


## Community packages

## 社区贡献的一些三方 package

The [pub.dev site]({{site.pub}}) allows you to search for packages
that support command-line and server apps
by specifying the platforms your app needs to support.
You can also search for words that describe the functionality you need.

[pub.dev 网站]({{site.pub}}) 可以通过选择「命令行」或「服务器端」来检索和过滤平台支持，
你也可以搜索描述所需功能的关键字。

### Command-line packages

### 命令行相关的 package

Command-line apps often use the following packages,
in addition to [general-purpose packages][] such as `archive`, `intl`, and `yaml`:

命令行应用常常使用下述列表中列出的 package，
除此之外还有像 `archive`、`intl` 和 `yaml` 这样的 [通用 package][general-purpose packages]：

| **Package**                   | **Description** |

| **包名**                   | **描述** |

| [args]({{site.pub-pkg}}/args) | Parses raw command-line arguments into a set of options and values. |

| [args]({{site.pub-pkg}}/args) | 将原始命令行参数解析为一组选项和值。|

| [cli_util]({{site.pub-pkg}}/cli_util) | Provides utilities for building command-line apps. |

| [cli_util]({{site.pub-pkg}}/cli_util) | 提供用于构建命令行应用程序的工具。|

| [completion]({{site.pub-pkg}}/completion) | Adds command-line completion to apps that use the `args` package. |

| [completion]({{site.pub-pkg}}/completion) | 向使用 `args` 包的应用中添加命令行完成功能。|

| [path]({{site.pub-pkg}}/path) | Provides comprehensive, cross-platform operations for manipulating paths. |

| [path]({{site.pub-pkg}}/path) | 为操作路径提供全面的跨平台操作。|

| [usage]({{site.pub-pkg}}/usage) | Wraps Google Analytics. |

| [usage]({{site.pub-pkg}}/usage) | 添加 Google 分析。|
{:.table .table-striped .nowrap}

### Server packages

### 服务器相关的 package

Server apps can choose from many packages, in addition to
the packages listed in the previous table
and [general-purpose packages][] such as `logging`:

服务器应用可选择使用的 package 更多一些，
除了上面上面表格中列出的外还支持比如 `logging` 这样的 [通用 package][general-purpose packages]：

| **Package**                   | **Description** |
| [crypto]({{site.pub-pkg}}/crypto) | Implements cryptographic hashing functions for algorithms such as SHA-1, SHA-256, MD5, and HMAC. |
| [crypto]({{site.pub-pkg}}/crypto) | 为 SHA-1、SHA-256、MD5 和 HMAC 等算法实现加密哈希散列函数。|
| [grpc]({{site.pub-pkg}}/grpc) | Implements [gRPC][] a high performance, open source, general RPC framework that puts mobile and HTTP/2 first. |
| [grpc]({{site.pub-pkg}}/grpc) | 实现 [gRPC][]，将移动和 HTTP/2 放在首位的高性能开源通用的 RPC 框架。|
| [shelf]({{site.pub-pkg}}/shelf) | Provides a model for web server middleware that encourages composition and easy reuse. |
| [shelf]({{site.pub-pkg}}/shelf) | 为 Web 服务器中间件提供一个模型，该模型促成组合和易于重用。|
{:.table .table-striped .nowrap}

[general-purpose packages]: /guides/libraries/useful-libraries#general-purpose-packages
[gRPC]: https://grpc.io/
