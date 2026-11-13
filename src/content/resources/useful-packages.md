---
# title: Commonly used packages
title: 常用 package
# shortTitle: Common packages
shortTitle: 常用 package
# description: >-
#   Some of the most useful and popular packages, and where you can learn more.
description: >-
  一些最实用、最流行的 package，以及可以进一步了解它们的地方。
ai-translated: true
---

{% assign pub = site.pub %}
{% assign pubpkg = site.pub-pkg %}

This page lists some of the most popular and useful
[packages](/tools/pub/packages) that Dart developers have published.
To find more packages—and search [core libraries](/libraries)
as well—use the [pub.dev site.]({{pub}})

本页列出 Dart 开发者发布的一些最流行、最实用的
[package](/tools/pub/packages)。
要查找更多 package，并同时搜索 [核心库](/libraries)，
请使用 [pub.dev 网站]({{pub}})。

Commonly used packages fall into three groups:

常用 package 分为三类：

* [General-purpose packages](#general-purpose-packages)

  [通用 package](#general-purpose-packages)

* [Packages that expand on Dart core libraries](#packages-that-correspond-to-sdk-libraries)

  [扩展 Dart 核心库的 package](#packages-that-correspond-to-sdk-libraries)

* [Specialized packages](#specialized-packages)

  [专用 package](#specialized-packages)

## General-purpose packages

## 通用 package

Use these packages for a wide range of projects.

这些 package 适用于很多类型的项目。

| <t>Package</t><t>Package</t> | <t>Description</t><t>说明</t> | <t>Commonly used APIs</t><t>常用 API</t> |
|----|----|----|
| [archive][] | Encodes and decodes various archive and compression formats. | Archive, ArchiveFile, TarEncoder, TarDecoder, ZipEncoder, ZipDecoder |
| [archive][] | 编码和解码多种归档与压缩格式。 | Archive、ArchiveFile、TarEncoder、TarDecoder、ZipEncoder、ZipDecoder |
| [characters][] | Manipulates strings for user-perceived characters (Unicode grapheme clusters). | String.characters, Characters, CharacterRange |
| [characters][] | 按用户感知的字符（Unicode 字素簇）处理字符串。 | String.characters、Characters、CharacterRange |
| [cronet_http][] | Provides access to the Android [Cronet][cronet] HTTP client using the same interface as `package:http`. | |
| [cronet_http][] | 通过与 `package:http` 相同的接口，访问 Android 的 [Cronet][cronet] HTTP 客户端。 | |
| [cupertino_http][] | Provides access to Apple's [Foundation URL Loading System][furl] using the same interface as `package:http`. | |
| [cupertino_http][] | 通过与 `package:http` 相同的接口，访问 Apple 的 [Foundation URL Loading System][furl]。 | |
| [http][] | Provides set of high-level functions and classes to simplify consuming HTTP resources. | delete(), get(), post(), read() |
| [http][] | 提供一组高层函数和类，简化 HTTP 资源的使用。 | delete()、get()、post()、read() |
| [intl][] | Internationalization and localization facilities, with support for plurals and genders, date and number formatting and parsing, and bidirectional text. | Bidi, DateFormat, MicroMoney, TextDirection |
| [intl][] | 提供国际化与本地化能力，支持复数和性别、日期与数字的格式化和解析，以及双向文本。 | Bidi、DateFormat、MicroMoney、TextDirection |
| [json_serializable][] | Generates JSON manipulation code. To learn more, consult [JSON Support](/libraries/serialization/json). | @JsonSerializable |
| [json_serializable][] | 生成处理 JSON 的代码。详情请查阅 [JSON 支持](/libraries/serialization/json)。 | @JsonSerializable |
| [logging][] | Adds message logging to your application. | LoggerHandler, Level, LogRecord |
| [logging][] | 为应用添加消息日志。 | LoggerHandler、Level、LogRecord |
| [mockito][] | Mocks objects in tests. Helps when you write tests for dependency injection. Use with the [test][] package. | Answering, Expectation, Verification |
| [mockito][] | 在测试中模拟对象。编写依赖注入测试时会用到。请与 [test][] package 一起使用。 | Answering、Expectation、Verification |
| [path][] | Manipulates different types of paths. To learn more, consult [Unboxing Packages: path.]({{site.news}}/2016/06/unboxing-packages-path.html) | absolute(), basename(), extension(), join(), normalize(), relative(), split() |
| [path][] | 处理不同类型的路径。详情请查阅 [拆箱 package：path]({{site.news}}/2016/06/unboxing-packages-path.html)。 | absolute()、basename()、extension()、join()、normalize()、relative()、split() |
| [shelf][] | Provides web server middleware for Dart. Shelf makes it easy to create and compose web servers, and parts of web servers. | Cascade, Pipeline, Request, Response, Server |
| [shelf][] | 为 Dart 提供 Web 服务器中间件。Shelf 让创建和组合 Web 服务器及其组成部分变得容易。 | Cascade、Pipeline、Request、Response、Server |
| [stack_trace][] | Parses, inspects, and manipulates stack traces that Dart produces. Also transforms stack traces into a more readable format than the native StackTrace implementation. To learn more, consult [Unboxing Packages: stack_trace.]({{site.news}}/2016/01/unboxing-packages-stacktrace.html) | Trace.current(), Trace.format(), Trace.from() |
| [stack_trace][] | 解析、检查和处理 Dart 产生的堆栈跟踪。也能把堆栈跟踪转换成比原生 StackTrace 实现更易读的格式。详情请查阅 [拆箱 package：stack_trace]({{site.news}}/2016/01/unboxing-packages-stacktrace.html)。 | Trace.current()、Trace.format()、Trace.from() |
| [test][] | Standardizes writing and running tests in Dart. | expect(), group(), test() |
| [test][] | 统一 Dart 中测试的编写和运行方式。 | expect()、group()、test() |
| [yaml][] | Parses YAML markup. | loadYaml(), loadYamlStream() |
| [yaml][] | 解析 YAML 标记。 | loadYaml()、loadYamlStream() |

{:.table .table-striped .nowrap}

[archive]: {{pubpkg}}/archive
[characters]: {{pubpkg}}/characters
[cronet_http]: {{pubpkg}}/cronet_http
[cupertino_http]: {{pubpkg}}/cupertino_http
[http]: {{pubpkg}}/http
[intl]: {{pubpkg}}/intl
[json_serializable]: {{pubpkg}}/json_serializable
[logging]: {{pubpkg}}/logging
[mockito]: {{pubpkg}}/mockito
[path]: {{pubpkg}}/path
[shelf]: {{pubpkg}}/shelf
[stack_trace]: {{pubpkg}}/stack_trace
[test]: {{pubpkg}}/test
[yaml]: {{pubpkg}}/yaml
[Cronet]: {{site.android-dev}}/develop/connectivity/cronet
[furl]: {{site.apple-dev}}/documentation/foundation/url_loading_system

## Packages that expand on Dart core libraries {:#packages-that-correspond-to-sdk-libraries}

## 扩展 Dart 核心库的 package

Each of the following packages builds upon a [core library](/libraries),
adding functionality and filling in missing features:

下面每个 package 都在某个 [核心库](/libraries) 之上扩展，
补充功能并补上缺失的特性：

| <t>Package</t><t>Package</t> | <t>Description</t><t>说明</t> | <t>Commonly used APIs</t><t>常用 API</t> |
|----|----|----|
| [async][] | Expands on dart:async, adding utility classes to work with asynchronous computations. To learn more, consult [Unboxing Packages: async part 1][async-1], [part 2][async-2], and [part 3][async-3]. | AsyncMemoizer, CancelableOperation, FutureGroup, LazyStream, Result, StreamCompleter, StreamGroup, StreamSplitter |
| [async][] | 扩展 dart:async，增加处理异步计算的工具类。详情请查阅 [拆箱 package：async 第 1 部分][async-1]、[第 2 部分][async-2] 和 [第 3 部分][async-3]。 | AsyncMemoizer、CancelableOperation、FutureGroup、LazyStream、Result、StreamCompleter、StreamGroup、StreamSplitter |
| [collection][] | Expands on dart:collection, adding utility functions and classes to make working with collections easier. To learn more, consult [Unboxing Packages: collection][collect]. | Equality, CanonicalizedMap, MapKeySet, MapValueSet, PriorityQueue, QueueList |
| [collection][] | 扩展 dart:collection，增加让集合更容易使用的工具函数和类。详情请查阅 [拆箱 package：collection][collect]。 | Equality、CanonicalizedMap、MapKeySet、MapValueSet、PriorityQueue、QueueList |
| [convert][] | Expands on dart:convert, adding encoders and decoders for converting between different data representations. One of the data representations is _percent encoding_, also known as _URL encoding_. | HexDecoder, PercentDecoder |
| [convert][] | 扩展 dart:convert，增加在不同数据表示之间转换的编码器和解码器。其中一种数据表示是 **百分号编码**，也称为 **URL 编码**。 | HexDecoder、PercentDecoder |
| [io][] | Contains two libraries, ansi and io, to simplify working with files, standard streams, and processes. Use the ansi library to customize terminal output. The io library has APIs for dealing with processes, stdin, and file duplication. |  copyPath(), isExecutable(), ExitCode, ProcessManager, sharedStdIn |
| [io][] | 包含 ansi 和 io 两个库，用来简化文件、标准流和进程的处理。用 ansi 库自定义终端输出。io 库提供处理进程、stdin 和文件复制的 API。 | copyPath()、isExecutable()、ExitCode、ProcessManager、sharedStdIn |

{:.table .table-striped .nowrap}

[async]: {{pubpkg}}/async
[collection]: {{pubpkg}}/collection
[convert]: {{pubpkg}}/convert
[io]: {{pubpkg}}/io
[async-1]: {{site.news}}/2016/03/unboxing-packages-async-part-1.html
[async-2]: {{site.news}}/2016/03/unboxing-packages-async-part-2.html
[async-3]: {{site.news}}/2016/04/unboxing-packages-async-part-3.html
[collect]: {{site.news}}/2016/01/unboxing-packages-collection.html

## Specialized packages

## 专用 package

To find specialized packages such as packages for Flutter and web development,
consult the following sections.

要查找专用 package，例如 Flutter 和 Web 开发用的 package，
请查阅下面各节。

### Flutter packages

### Flutter package

To learn more about Flutter packages,
consult [Using packages][flutterpkg] in the Flutter documentation
or search the pub.dev site for [Flutter packages][fluttersearch].

想进一步了解 Flutter package，
请查阅 Flutter 文档中的 [使用 package][flutterpkg]，
或在 pub.dev 上搜索 [Flutter package][fluttersearch]。

[flutterpkg]: {{site.flutter-docs}}/development/packages-and-plugins/using-packages
[fluttersearch]: {{pub}}/flutter

### Web packages

### Web package

To learn more about web packages,
consult [Web libraries and packages][webpkg]
or search the pub.dev site for [web packages][pkgsearch].

想进一步了解 Web package，
请查阅 [Web 库和 package][webpkg]，
或在 pub.dev 上搜索 [Web package][pkgsearch]。

[webpkg]: /web/libraries
[pkgsearch]: {{pub}}/web

### Command-line and server packages

### 命令行与服务端 package

To learn more about CLI or server packages,
See [Command-line and server libraries and packages](/server/libraries).
Or use the pub.dev site to [search for other packages.]({{pub}})

想进一步了解命令行或服务端 package，
请看 [命令行与服务端库和 package](/server/libraries)。
也可以使用 pub.dev 网站 [搜索其他 package]({{pub}})。
