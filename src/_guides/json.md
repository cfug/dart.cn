---
title: Using JSON
title: 在 Dart 里使用 JSON
description: Dart solutions for reading and writing JSON.
description: Dart 里读写 JSON。
---

Most mobile and web apps use JSON for tasks such as
exchanging data with a web server.
This page discusses Dart support for JSON _serialization_ and _deserialization_:
converting Dart objects to and from JSON.

许多移动或网页应用都使用 JSON 来处理类似与服务器交换数据的任务。本文将讨论如果使用 Dart 对 JSON 数据进行**序列化**和**反序列化**：即 Dart 对象与 JSON 数据之间的相互转换。

## Libraries

## 需要用到的库

The following libraries and packages are useful across Dart platforms:

下述的库和包可以用作于所有的 Dart 平台：

* [dart:convert](/guides/libraries/library-tour#dartconvert---decoding-and-encoding-json-utf-8-and-more)<br>
  Converters for both JSON and UTF-8
  (the character encoding that JSON requires).

  [dart:convert](/guides/libraries/library-tour#dartconvert---decoding-and-encoding-json-utf-8-and-more)<br>
  包含 JSON 数据和 UTF-8（JSON 数据需要的字符编码）的转换器。

* [package:json_serializable]({{site.pub-pkg}}/json_serializable)<br>
  An easy-to-use code generation package.
  When you add some metadata annotations
  and use the builder provided by this package,
  the Dart build system generates serialization and deserialization code for you.

  [package:json_serializable]({{site.pub}}/packages/json_serializable)<br>
  一个易于使用的代码生成包。当你添加一些元注解以及使用该包提供的构建器时，
  Dart 编译器可以为你生成序列化和反序列化的代码。

* [package:built_value]({{site.pub-pkg}}/built_value)<br>
  A powerful, opinionated alternative to json_serializable.

  [package:built_value]({{site.pub}}/packages/built_value)<br>
  一个强大的，可以作为 json_serializable 替代的 package。

## Flutter resources

## 相关的 Flutter 资源

## 相关的 Flutter 资源

[JSON and serialization]({{site.flutter_docs}}/development/data-and-backend/json)
<br> Shows how Flutter apps can serialize and deserialize both
  with dart:convert and with json_serializable.

[JSON 和序列化]({{site.flutter_docs}}/development/data-and-backend/json)
<br> 向你展示 Flutter 应用是如何使用 dart:convert 和
  json_serializable 进行序列化和反序列化的。

## Web app resources

## 相关的 Web 应用资源

[Using HTTP resources with HttpRequest](/guides/libraries/library-tour#using-http-resources-with-httprequest)
<br> Demonstrates how to use HttpRequest to exchange data with a web server.
  Part of the [dart:html library tour.](/guides/libraries/library-tour#darthtml)

[通过 HttpRequest 使用 HTTP 资源](/guides/libraries/library-tour#using-http-resources-with-httprequest)
<br> 向你演示如何使用 HttpRequest 与服务器交换数据。
  该资源是 [dart:html 库概览](/guides/libraries/library-tour#darthtml) 的一部分。

{% comment %}
## VM resources

## 相关的 VM 资源

[Write HTTP servers](/tutorials/server/httpserver)
<br> Walks through how to implement command-line clients and servers
  that exchange JSON data.

[开发 HTTP 服务端](/tutorials/server/httpserver)
<br> 手把手教你如何实现一个命令行式的客户端和服务端并使用 JSON 交换数据。

## Other tools and resources
{% endcomment %}
