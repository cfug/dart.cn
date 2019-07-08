---
title: Commonly used packages
title: 常用 package 介绍
description: Some of the most useful and popular packages, and where you can learn more.
description: 一些常用的 package 的列表。
---

This page lists some of the most popular and useful
[packages](/guides/packages) that Dart developers have published.
To find more packages —
and search [core libraries](/guides/libraries), as well —
use the [Pub site.]({{site.pub}})

本章列出了一些 Dart 开发者发布的非常流行的有用的 [包](/guides/packages)。
到 [Pub 网站]({{site.pub}}) 发现更多包及 [核心库](/guides/libraries)。

Commonly used packages fall into three groups:

常用包分为以下三组：

* [General-purpose packages](#general-purpose-packages)

  [通用包](#general-purpose-packages)

* [Packages that expand on Dart core libraries](#packages-that-correspond-to-sdk-libraries)
  
  [在 Dart 核心库上的扩展包](#packages-that-correspond-to-sdk-libraries)

* [Specialized packages](#specialized-packages)
  
  [专业包](#specialized-packages)

## General-purpose packages

## 通用包

The following packages are useful for a wide range of projects.

以下包被广泛的应用于项目中。

| **Package** | **Description** | **Commonly used APIs** |
| [archive]({{site.pub-pkg}}/archive) | Encodes and decodes various archive and compression formats. | Archive, ArchiveFile, TarEncoder, TarDecoder, ZipEncoder, ZipDecoder |
| [http]({{site.pub-pkg}}/http) | A set of high-level functions and classes that make it easy to consume HTTP resources. | delete(), get(), post(), read() |
| [intl]({{site.pub-pkg}}/intl) | Internationalization and localization facilities, with support for plurals and genders, date and number formatting and parsing, and bidirectional text. | Bidi, DateFormat, MicroMoney, TextDirection |
| [json_serializable]({{site.pub-pkg}}/json_serializable) | An easy-to-use code generation package. For more information, see [JSON Support](/guides/json). | @JsonSerializable |
| [logging]({{site.pub-pkg}}/logging) | A configurable mechanism for adding message logging to your application. | LoggerHandler, Level, LogRecord |
| [mockito]({{site.pub-pkg}}/mockito) | A popular framework for mocking objects in tests. Especially useful if you are writing tests for dependency injection. Used with the [test]({{site.pub-pkg}}/test) package. | Answering, Expectation, Verification |
| [path]({{site.pub-pkg}}/path) | Common operations for manipulating different types of paths. For more information, see [Unboxing Packages: path.]({{site.news}}/2016/06/unboxing-packages-path.html) | absolute(), basename(), extension(), join(), normalize(), relative(), split() |
| [quiver]({{site.pub-pkg}}/quiver) | Utilities that make using core Dart libraries more convenient. Some of the libraries where Quiver provides additional support include async, cache, collection, core, iterables, patterns, and testing. | CountdownTimer (quiver.async); MapCache (quiver.cache); MultiMap, TreeSet (quiver.collection); EnumerateIterable (quiver.iterables); center(), compareIgnoreCase(), isWhiteSpace() (quiver.strings)  |
| [shelf]({{site.pub-pkg}}/shelf) | Web server middleware for Dart. Shelf makes it easy to create and compose web servers, and parts of web servers. | Cascade, Pipeline, Request, Response, Server |
| [stack_trace]({{site.pub-pkg}}/stack_trace) | Methods for parsing, inspecting, and manipulating stack traces produced by the underlying Dart implementation. Also provides functions to produce string representations of stack traces in a more readable format than the native StackTrace implementation. For more information, see [Unboxing Packages: stack_trace.]({{site.news}}/2016/01/unboxing-packages-stacktrace.html) | Trace.current(), Trace.format(), Trace.from() |
| [stagehand]({{site.pub-pkg}}/stagehand) | A Dart project generator. WebStorm and IntelliJ use Stagehand templates when you create a new application, but you can also use the templates from the command line. | Generally used through an IDE or the `stagehand` command. |
| [test]({{site.pub-pkg}}/test) | A standard way of writing and running tests in Dart. | expect(), group(), test() |
| [yaml]({{site.pub-pkg}}/yaml) | A parser for YAML. | loadYaml(), loadYamlStream() |
{:.table .table-striped .nowrap}


## Packages that expand on Dart core libraries {#packages-that-correspond-to-sdk-libraries}

## 在 Dart 核心库上的扩展包 {#packages-that-correspond-to-sdk-libraries}

Each of the following packages builds upon a [core library](/guides/libraries),
adding functionality and filling in missing features:

以下包基于 [核心库](/guides/libraries) 构建，
添加功能，并补全缺少的功能：

| **Package** | **Description** | **Commonly used APIs** |
| [async]({{site.pub-pkg}}/async) | Expands on dart:async, adding utility classes to work with asynchronous computations. For more information, see [Unboxing Packages: async part 1]({{site.news}}/2016/03/unboxing-packages-async-part-1.html), [part 2]({{site.news}}/2016/03/unboxing-packages-async-part-2.html), and [part 3.]({{site.news}}/2016/04/unboxing-packages-async-part-3.html) | AsyncMemoizer, CancelableOperation, FutureGroup, LazyStream, Result, StreamCompleter, StreamGroup, StreamSplitter |
| [collection]({{site.pub-pkg}}/collection) | Expands on dart:collection, adding utility functions and classes to make working with collections easier. For more information, see [Unboxing Packages: collection.]({{site.news}}/2016/01/unboxing-packages-collection.html) | Equality, CanonicalizedMap, MapKeySet, MapValueSet, PriorityQueue, QueueList |
|[convert]({{site.pub-pkg}}/convert) | Expands on dart:convert, adding encoders and decoders for converting between different data representations. One of the data representations is _percent encoding_, also known as _URL encoding_. | HexDecoder, PercentDecoder |
|[io]({{site.pub-pkg}}/io) | Contains two libraries, ansi and io, to simplify working with files, standard streams, and processes. Use the ansi library to customize terminal output. The io library has APIs for dealing with processes, stdin, and file duplication. |  copyPath(), isExecutable(), ExitCode, ProcessManager, sharedStdIn |
{:.table .table-striped .nowrap}


## Specialized packages

## 专业包

Here are some tips for finding packages that are more specialized,
such as packages for mobile (Flutter) and web development.

以下是一些查找更专业软件包的技巧，例如用于移动开发（Flutter）和 Web 开发的包。


### Flutter packages

### Flutter 包

See [Using packages]({{site.flutter}}/docs/development/packages-and-plugins/using-packages)
on the Flutter site.
Or use the Pub site to [search for Flutter packages.]({{site.pub}}/flutter)

在 Flutter 网站，查看 [包的使用]({{site.flutter}}/docs/development/packages-and-plugins/using-packages)。
或者使用 Pub 网站 [查找 Flutter 包]({{site.pub}}/flutter)。

### Web packages

### Web 包

See [Web libraries and packages](/web/libraries).
Or use the Pub site to [search for web packages.]({{site.pub}}/web)

查看 [Web 库和包](/web/libraries)。
或者使用 Pub 网站 [查找用于 Web 的包]({{site.pub}}/web)。

### Command-line and server packages

### 命令行和服务器包

See [Command-line and server libraries and packages](/server/libraries).
Or use the Pub site to [search for other packages.]({{site.pub}})

查看 [命令行和服务器的库和包](/server/libraries)。
或者使用 Pub 网站 [查找用于其它应用的包]({{site.pub}})。
