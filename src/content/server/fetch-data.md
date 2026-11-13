---
# title: Fetch data from the internet
title: 从互联网获取数据
# shortTitle: Fetch data
shortTitle: 获取数据
# description: Fetch data over the internet using the http package.
description: 使用 http package 通过互联网获取数据。
ai-translated: true
---

<?code-excerpt path-base="fetch_data"?>

:::secondary 你将学到什么
<!-- :::secondary What you'll learn -->
* The basics of what HTTP requests and URIs are and what they are used for.

  HTTP 请求和 URI 是什么，以及它们的用途。

* Making HTTP requests using `package:http`.

  使用 `package:http` 发起 HTTP 请求。

* Decoding JSON strings into Dart objects with `dart:convert`.

  用 `dart:convert` 把 JSON 字符串解码为 Dart 对象。

* Converting JSON objects into class-based structures.

  把 JSON 对象转换为基于类的结构。
:::

Most applications require some form of communication or
data retrieval from the internet.
Many apps do so through HTTP requests,
which are sent from a client to a server
to perform a specific action for a resource
identified through a [URI][] (Uniform Resource Identifier).

大多数应用都需要某种形式的通信，
或从互联网获取数据。
许多应用通过 HTTP 请求来完成，
请求从客户端发到服务器，
对由 [URI][URI]（统一资源标识符）标识的资源
执行特定操作。

Data communicated over HTTP can technically be in any form,
but using [JSON][] (JavaScript Object Notation)
is a popular choice due to its human-readability
and language independent nature.
The Dart SDK and ecosystem also have extensive support for JSON
with multiple options to best meet your app's requirements.

通过 HTTP 传输的数据理论上可以是任何形式，
但 [JSON][JSON]（JavaScript Object Notation）
因为便于人阅读、且与语言无关，成为常见选择。
Dart SDK 和生态对 JSON 也有充分支持，
并提供多种方式来满足应用的需求。

In this tutorial,
you will learn more about HTTP requests, URIs, and JSON.
Then you will learn how to use [`package:http`][http-pub]
as well as Dart's JSON support in the [`dart:convert`][convert-docs] library
to fetch, decode, then use JSON-formatted data
retrieved from an HTTP server.

在本教程中，
你将进一步了解 HTTP 请求、URI 和 JSON。
然后学习如何使用 [`package:http`][http-pub]，
以及 [`dart:convert`][convert-docs] 库中 Dart 对 JSON 的支持，
来获取、解码并使用从 HTTP 服务器取回的 JSON 格式数据。

[JSON]: https://www.json.org/

## Background concepts

## 背景概念

The following sections provide some extra background and information
around the technologies and concepts used in the tutorial
to facilitate fetching data from the server.
To skip directly to the tutorial content,
see [Retrieve the necessary dependencies][].

以下各节补充本教程所用技术和概念的背景，
以便从服务器获取数据。
若要直接跳到教程正文，
请参阅 [获取所需依赖][Retrieve the necessary dependencies]。

[Retrieve the necessary dependencies]: #retrieve-the-necessary-dependencies

### JSON

### JSON 格式

JSON (JavaScript Object Notation) is a data-interchange format
that has become ubiquitous across
application development and client-server communication.
It is lightweight but also easy for
humans to read and write due to being text based.
With JSON, various data types and simple data structures
such as lists and maps can be serialized and represented by strings.

JSON（JavaScript Object Notation）是一种数据交换格式，
在应用开发以及客户端与服务器通信中已经无处不在。
它很轻量，又因为基于文本，便于人读写。
借助 JSON，列表和映射等数据类型和简单数据结构
可以被序列化并用字符串表示。

Most languages have many implementations and
parsers have become extremely fast,
so you don't need to worry about interoperability or performance.
For more information about the JSON format, see [Introducing JSON][].
To learn more about working with JSON in Dart,
see the [Using JSON][] guide.

大多数语言都有许多实现，
解析器也已经非常快，
因此你不必担心互操作性或性能。
关于 JSON 格式的更多信息，见 [JSON 简介][Introducing JSON]。
要进一步了解如何在 Dart 中使用 JSON，
请参阅 [使用 JSON][Using JSON] 指南。

:::secondary
Two other packages exist with platform-specific implementations for mobile.

另外还有两个 package，为移动端提供特定平台的实现。

* [cronet_http]({{site.pub-pkg}}/cronet_http)
  provides access to the Android [Cronet][] HTTP client.

  [cronet_http]({{site.pub-pkg}}/cronet_http)
  提供对 Android [Cronet][] HTTP 客户端的访问。

* [cupertino_http]({{site.pub-pkg}}/cupertino_http)
  provides access to Apple's [Foundation URL Loading System][furl].

  [cupertino_http]({{site.pub-pkg}}/cupertino_http)
  提供对 Apple [Foundation URL Loading System][furl] 的访问。

To learn more about their capabilities,
consult the package documentation.

要进一步了解它们的能力，
请查阅 package 文档。
:::

[Cronet]: {{site.android-dev}}/develop/connectivity/cronet
[furl]: {{site.apple-dev}}/documentation/foundation/url_loading_system
[Introducing JSON]: https://www.json.org/

### HTTP requests

### HTTP 请求

HTTP (Hypertext Transfer Protocol) is a stateless protocol
designed for transmitting documents,
originally between web clients and web servers.
You interacted with the protocol to load this page,
as your browser uses an HTTP `GET` request
to retrieve the contents of a page from a web server.
Since its introduction, use of the HTTP protocol and its various versions
have expanded to applications outside the web as well,
essentially wherever communication from a client to a server is needed.

HTTP（超文本传输协议）是一种无状态协议，
设计用于传输文档，
最初用于 Web 客户端和 Web 服务器之间。
你加载本页时就使用了该协议，
因为浏览器会用 HTTP `GET` 请求
从 Web 服务器获取页面内容。
自推出以来，HTTP 协议及其各个版本的使用
也扩展到了 Web 之外的应用，
基本上只要需要客户端与服务器通信就会用到。

HTTP requests sent from the client to communicate with the server
are composed of multiple components.
HTTP libraries, such as `package:http`, allow you
to specify the following kinds of communication:

从客户端发往服务器的 HTTP 请求
由多个部分组成。
`package:http` 等 HTTP 库让你可以
指定下面几类通信内容：

* An HTTP method defining the desired action,
  such as `GET` to retrieve data or `POST` to submit new data.

  HTTP 方法，定义期望的操作，
  例如用 `GET` 获取数据，或用 `POST` 提交新数据。

* The location of the resource through a URI.

  通过 URI 指定资源的位置。

* The version of HTTP being used.

  所使用的 HTTP 版本。

* Headers that provide extra information to the server.

  向服务器提供额外信息的标头。

* An optional body, so the request can send data to the server,
  not just retrieve it.

  可选的正文，这样请求不仅可以取回数据，
  还可以向服务器发送数据。

To learn more about the HTTP protocol,
check out [An overview of HTTP][] on the mdn web docs.

要进一步了解 HTTP 协议，
请查阅 mdn web docs 上的 [HTTP 概览][An overview of HTTP]。

[An overview of HTTP]: https://developer.mozilla.org/docs/Web/HTTP/Overview

### URIs and URLs

### URI 与 URL

To make an HTTP request,
you need to provide a [URI][] (Uniform Resource Identifier) to the resource.
A URI is a character string that uniquely identifies a resource.
A URL (Uniform Resource Locator) is a specific kind of URI
that also provides the location of the resource.
URLs for resources on the web contain three pieces of information.
For this current page, the URL is composed of:

要发起 HTTP 请求，
你需要提供指向该资源的 [URI][URI]（统一资源标识符）。
URI 是唯一标识资源的字符串。
URL（统一资源定位符）是一种特殊的 URI，
同时还提供资源的位置。
Web 上资源的 URL 包含三部分信息。
就当前这个页面而言，URL 由以下部分组成：

* The scheme used for determining the protocol used: `https`

  用于确定所用协议的方案：`https`

* The authority or hostname of the server: `dart.dev`

  服务器的权威部分或主机名：`dart.dev`

* The path to the resource: `/server/fetch-data.html`

  资源的路径：`/server/fetch-data.html`

There are other optional parameters as well
that aren't used by the current page:

还有其他可选参数，
当前页面没有使用：

* Parameters to customize extra behavior: `?key1=value1&key2=value2`

  用于定制额外行为的参数：`?key1=value1&key2=value2`

* An anchor, that isn't sent to the server,
  which points to a specific location in the resource: `#uris`

  锚点，不会发送给服务器，
  指向资源中的特定位置：`#uris`

To learn more about URLs,
see [What is a URL?][] on the mdn web docs.

要进一步了解 URL，
请参阅 mdn web docs 上的 [什么是 URL？][What is a URL?]。

[What is a URL?]: https://developer.mozilla.org/docs/Learn/Common_questions/What_is_a_URL

## Retrieve the necessary dependencies

## 获取所需依赖

The `package:http` library provides a cross-platform solution
for making composable HTTP requests,
with optional fine-grained control.

`package:http` 库提供了跨平台方案，
用于发起可组合的 HTTP 请求，
并可选地做细粒度控制。

:::note
Avoid directly using `dart:io` or `dart:html` to make HTTP requests.
Those libraries are platform-dependent and tied to a single implementation.

避免直接使用 `dart:io` 或 `dart:html` 发起 HTTP 请求。
这些库依赖特定平台，并且绑定到单一实现。
:::

To add a dependency on `package:http`,
run the following [`dart pub add`][] command
from the top of your repo:

要添加对 `package:http` 的依赖，
请在仓库顶层运行下面的 [`dart pub add`][] 命令：

```console
$ dart pub add http
```

To use `package:http` in your code,
import it and optionally [specify a library prefix][]:

要在代码中使用 `package:http`，
请导入它，并可选地 [指定库前缀][specify a library prefix]：

<?code-excerpt "lib/fetch_data.dart (http-import)"?>
```dart
import 'package:http/http.dart' as http;
```

To learn more specifics about `package:http`,
see its [page on the pub.dev site][http-pub]
and its [API documentation][http-docs].

要进一步了解 `package:http` 的细节，
请参阅它在 [pub.dev 上的页面][http-pub]
以及 [API 文档][http-docs]。

[`dart pub add`]: /tools/pub/cmd/pub-add
[specify a library prefix]: /language/libraries#specifying-a-library-prefix

## Build a URL

## 构建 URL

As previously mentioned,
to make an HTTP request,
you first need a URL that identifies
the resource being requested
or endpoint being accessed.

如前所述，
要发起 HTTP 请求，
首先需要一个 URL，用来标识
所请求的资源或所访问的端点。

In Dart, URLs are represented through [`Uri`][] objects.
There are many ways to build an `Uri`,
but due to its flexibility,
parsing a string with `Uri.parse` to
create one is a common solution.

在 Dart 中，URL 由 [`Uri`][] 对象表示。
构建 `Uri` 的方式很多，
但由于灵活性，
用 `Uri.parse` 解析字符串来创建
是一种常见做法。

The following snippet shows two ways
to create a `Uri` object
pointing to mock JSON-formatted information
about `package:http` hosted on this site:

下面的代码片段展示了两种方式，
用来创建一个 `Uri` 对象，
指向本站托管的、关于 `package:http` 的
模拟 JSON 格式信息：

<?code-excerpt "lib/fetch_data.dart (build-uris)"?>
```dart
// Parse the entire URI, including the scheme
Uri.parse('https://dart.dev/f/packages/http.json');

// Specifically create a URI with the https scheme
Uri.https('dart.dev', '/f/packages/http.json');
```

To learn about other ways of building and interacting with URIs,
see the [`URI` documentation][].

关于构建 URI 以及与之交互的其他方式，
请参阅 [`URI` 文档][`URI` documentation]。

[`Uri`]: {{site.dart-api}}/dart-core/Uri-class.html
[`URI` documentation]: /libraries/dart-core#uris

## Make a network request

## 发起网络请求

If you just need to quickly fetch a string representation
of a requested resource,
you can use the top-level [`read`][http-read]
function found in `package:http`
that returns a `Future<String>` or throws
a [`ClientException`][http-client-exc] if the request wasn't successful.
The following example uses `read` to
retrieve the mock JSON-formatted information
about `package:http` as a string,
then prints it out:

如果只需要快速获取所请求资源的字符串表示，
可以使用 `package:http` 中的顶层 [`read`][http-read] 函数。
它返回 `Future<String>`；如果请求没有成功，
则抛出 [`ClientException`][http-client-exc]。
下面的示例用 `read` 以字符串形式
取回关于 `package:http` 的模拟 JSON 信息，
然后打印出来：

:::note
Many functions in `package:http`, including `read`,
access the network and perform potentially time-consuming operations,
therefore they do so asynchronously and return a [`Future`][].
If you haven't encountered futures yet,
you can learn about them—as well as the `async` and `await` keywords—in the
[asynchronous programming tutorial](/libraries/async/async-await).

`package:http` 中的许多函数，包括 `read`，
都会访问网络并执行可能耗时的操作，
因此它们以异步方式进行并返回 [`Future`][]。
如果你还没接触过 future，
可以在 [异步编程教程](/libraries/async/async-await) 中
了解它们，以及 `async` 和 `await` 关键字。
:::

<?code-excerpt "lib/fetch_data.dart (http-read)" replace="/readMain/main/g; /(http\.read)/[!$1!]/g"?>
```dart
void main() async {
  final httpPackageUrl = Uri.https('dart.dev', '/f/packages/http.json');
  final httpPackageInfo = await [!http.read!](httpPackageUrl);
  print(httpPackageInfo);
}
```

This results in the following JSON-formatted output,
which can also be seen in your browser at
[`/f/packages/http.json`][mock-http-json].

这会得到下面的 JSON 格式输出，
你也可以在浏览器中打开
[`/f/packages/http.json`][mock-http-json] 查看。

```json
{
  "name": "http",
  "latestVersion": "1.1.2",
  "description": "A composable, multi-platform, Future-based API for HTTP requests.",
  "publisher": "dart.dev",
  "repository": "https://github.com/dart-lang/http"
}
```  

Note the structure of the data
(in this case a map),
as you will need it when decoding the JSON later on.

注意数据的结构
（这里是一个映射），
稍后解码 JSON 时会用到。

If you need other information from the response,
such as the [status code][] or the [headers][],
you can instead use the top-level [`get`][http-get] function
that returns a `Future` with a [`Response`][http-response].

如果还需要响应中的其他信息，
例如 [状态码][status code] 或 [标头][headers]，
可以改用顶层 [`get`][http-get] 函数，
它返回带有 [`Response`][http-response] 的 `Future`。

The following snippet uses `get` to get the whole response
in order to exit early if the request was not successful,
which is indicated with a status code of **200**:

下面的代码片段用 `get` 获取完整响应，
以便在请求未成功时提前退出。
成功由状态码 **200** 表示：

<?code-excerpt "lib/fetch_data.dart (http-get)" replace="/getMain/main/g"?>
```dart
void main() async {
  final httpPackageUrl = Uri.https('dart.dev', '/f/packages/http.json');
  final httpPackageResponse = await http.get(httpPackageUrl);
  if (httpPackageResponse.statusCode != 200) {
    print('Failed to retrieve the http package!');
    return;
  }
  print(httpPackageResponse.body);
}
```

There are many other status codes besides **200**
and your app might want to handle them differently.
To learn more about what different status codes mean,
see [HTTP response status codes][] on the mdn web docs.

除了 **200**，还有许多其他状态码，
应用可能希望以不同方式处理它们。
要了解不同状态码的含义，
请参阅 mdn web docs 上的 [HTTP 响应状态码][HTTP response status codes]。

Some server requests require more information,
such as authentication or user-agent information;
in this case you might need to include [HTTP headers][headers].
You can specify headers by passing in a `Map<String, String>`
of the key-value pairs as the `headers` optional named parameter:

有些服务器请求需要更多信息，
例如身份验证或 user-agent 信息；
这时你可能需要包含 [HTTP 标头][headers]。
可以把键值对的 `Map<String, String>`
作为可选命名参数 `headers` 传入：

<?code-excerpt "lib/fetch_data.dart (http-headers)"?>
```dart
await http.get(
  Uri.https('dart.dev', '/f/packages/http.json'),
  headers: {'User-Agent': '<product name>/<product-version>'},
);
```

[http-read]: {{site.pub-api}}/http/latest/http/read.html
[http-client-exc]: {{site.pub-api}}/http/latest/http/ClientException-class.html
[mock-http-json]: /f/packages/http.json
[`Future`]: {{site.dart-api}}/dart-async/Future-class.html
[status code]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
[headers]: https://developer.mozilla.org/docs/Web/HTTP/Headers
[http-get]: {{site.pub-api}}/http/latest/http/get.html
[http-response]: {{site.pub-api}}/http/latest/http/Response-class.html
[HTTP response status codes]: https://developer.mozilla.org/docs/Web/HTTP/Status

### Make multiple requests

### 发起多个请求

If you're making multiple requests to the same server,
you can instead keep a persistent connection
through a [`Client`][http-client],
which has similar methods to the top-level ones.
Just make sure to clean up with
the [`close`][http-close] method when done:

如果要向同一台服务器发起多个请求，
可以改用 [`Client`][http-client] 保持持久连接，
它的方法与顶层函数类似。
完成后请务必用 [`close`][http-close] 方法清理：

<?code-excerpt "lib/fetch_data.dart (http-client)" replace="/clientMain/main/g; /(http\.Cl.*?\))/[!$1!]/g; /(client\.c.*?\))/[!$1!]/g"?>
```dart
void main() async {
  final httpPackageUrl = Uri.https('dart.dev', '/f/packages/http.json');
  final client = [!http.Client()!];
  try {
    final httpPackageInfo = await client.read(httpPackageUrl);
    print(httpPackageInfo);
  } finally {
    [!client.close()!];
  }
}
```

To enable the client to retry failed requests,
import `package:http/retry.dart` and
wrap your created `Client` in a [`RetryClient`][http-retry-client]:

要让客户端重试失败的请求，
请导入 `package:http/retry.dart`，
并把创建的 `Client` 包装在 [`RetryClient`][http-retry-client] 中：

<?code-excerpt "lib/fetch_data.dart (http-retry)" plaster="none" replace="/retryMain/main/g; /(i.*?retry.*)/[!$1!]/g; /(Retry.*?\)\))/[!$1!]/g"?>
```dart
import 'package:http/http.dart' as http;
[!import 'package:http/retry.dart';!]

void main() async {
  final httpPackageUrl = Uri.https('dart.dev', '/f/packages/http.json');
  final client = [!RetryClient(http.Client())!];
  try {
    final httpPackageInfo = await client.read(httpPackageUrl);
    print(httpPackageInfo);
  } finally {
    client.close();
  }
}
```

The `RetryClient` has a default behavior for how many
times to retry and how long to wait between each request,
but its behavior can be modified through parameters
to the [`RetryClient()`][http-retry-client-cons]
or [`RetryClient.withDelays()`][http-retry-client-delay] constructors.

`RetryClient` 对重试次数以及每次请求之间的等待时间
有默认行为，
但可以通过 [`RetryClient()`][http-retry-client-cons]
或 [`RetryClient.withDelays()`][http-retry-client-delay]
构造函数的参数修改该行为。

`package:http` has much more functionality and customization,
so make sure to check out its [page on the pub.dev site][http-pub]
and its [API documentation][http-docs].

`package:http` 还有更多功能和定制方式，
请务必查看它在 [pub.dev 上的页面][http-pub]
以及 [API 文档][http-docs]。

[http-client]: {{site.pub-api}}/http/latest/http/Client-class.html
[http-close]: {{site.pub-api}}/http/latest/http/Client/close.html
[http-retry-client]: {{site.pub-api}}/http/latest/retry/RetryClient-class.html
[http-retry-client-cons]: {{site.pub-api}}/http/latest/retry/RetryClient/RetryClient.html
[http-retry-client-delay]: {{site.pub-api}}/http/latest/retry/RetryClient/RetryClient.withDelays.html

## Decode the retrieved data

## 解码取回的数据

While you now have made a network request
and retrieved the returned data as string,
accessing specific portions of information
from a string can be a challenge.

虽然你已经发起了网络请求，
并以字符串形式取回了数据，
但从字符串中访问特定信息可能并不容易。

Since the data is already in a JSON format,
you can use Dart's built-in [`json.decode`][decode-docs] function
in the `dart:convert` library
to convert the raw string into
a JSON representation using Dart objects.
In this case, the JSON data is represented in a map structure
and, in JSON, map keys are always strings,
so you can cast the result of `json.decode` to a `Map<String, dynamic>`:

由于数据已经是 JSON 格式，
你可以使用 `dart:convert` 库中
Dart 内置的 [`json.decode`][decode-docs] 函数，
把原始字符串转换为使用 Dart 对象的 JSON 表示。
这里的 JSON 数据用映射结构表示，
而在 JSON 中映射的键始终是字符串，
因此可以把 `json.decode` 的结果转换为 `Map<String, dynamic>`：

<?code-excerpt "lib/fetch_data.dart (json-decode)" plaster="none" replace="/decodeMain/main/g; /(import 'd.*?;)/[!$1!]/g; /(json\.de.*?)\;/[!$1!];/g"?>
```dart
[!import 'dart:convert';!]

import 'package:http/http.dart' as http;

void main() async {
  final httpPackageUrl = Uri.https('dart.dev', '/f/packages/http.json');
  final httpPackageInfo = await http.read(httpPackageUrl);
  final httpPackageJson = [!json.decode(httpPackageInfo) as Map<String, dynamic>!];
  print(httpPackageJson);
}
```

[decode-docs]: {{site.dart-api}}/dart-convert/JsonCodec/decode.html

### Create a structured class to store the data

### 创建结构化的类来存储数据

To provide the decoded JSON with more structure,
making it easier to work with,
create a class that can store the
retrieved data using specific types depending
on the schema of your data.

为了解码后的 JSON 提供更多结构、使其更好用，
请创建一个类，根据数据的模式
用具体类型存储取回的数据。

The following snippet shows a class-based representation
that can store the package information returned
from the mock JSON file you requested.
This structure assumes all fields except the `repository`
are required and provided every time.

下面的代码片段展示了一种基于类的表示，
可以存储你所请求的模拟 JSON 文件返回的 package 信息。
该结构假定除 `repository` 之外的所有字段
都是必需的，并且每次都会提供。

<?code-excerpt "bin/fetch_http_package.dart (package-info)" plaster="none"?>
```dart
class PackageInfo {
  final String name;
  final String latestVersion;
  final String description;
  final String publisher;
  final Uri? repository;

  PackageInfo({
    required this.name,
    required this.latestVersion,
    required this.description,
    required this.publisher,
    this.repository,
  });
}
```

### Encode the data into your class

### 把数据编码进你的类

Now that you have a class to store your data in,
you need to add a mechanism to convert
the decoded JSON into a `PackageInfo` object.

既然已经有了存储数据的类，
就需要增加一种机制，
把解码后的 JSON 转换为 `PackageInfo` 对象。

Convert the decoded JSON
by manually writing a `fromJson` method
matching the earlier JSON format,
casting types as necessary
and handling the optional `repository` field:

通过手写与前面 JSON 格式匹配的 `fromJson` 方法
来转换解码后的 JSON，
按需转换类型，
并处理可选的 `repository` 字段：

<?code-excerpt "bin/fetch_http_package.dart (from-json)"?>
```dart
class PackageInfo {
  // ···

  factory PackageInfo.fromJson(Map<String, dynamic> json) {
    final repository = json['repository'] as String?;

    return PackageInfo(
      name: json['name'] as String,
      latestVersion: json['latestVersion'] as String,
      description: json['description'] as String,
      publisher: json['publisher'] as String,
      repository: repository != null ? Uri.tryParse(repository) : null,
    );
  }
}
```

A handwritten method, such as in the previous example,
is often sufficient for relatively simple JSON structures,
but there are more flexible options as well.
To learn more about JSON serialization and deserialization,
including automatic generation of the conversion logic,
see the [Using JSON][] guide.

像上一个示例这样的手写方法，
对相对简单的 JSON 结构通常已经够用，
但也有更灵活的选择。
要进一步了解 JSON 序列化与反序列化，
包括自动生成转换逻辑，
请参阅 [使用 JSON][Using JSON] 指南。

### Convert the response to an object of your structured class

### 把响应转换为结构化类的对象

Now you have a class to store your data
and a way to convert the decoded JSON object
into an object of that type.
Next, you can write a function that
pulls everything together:

现在你有了存储数据的类，
也有了把解码后的 JSON 对象
转换为该类型对象的方法。
接下来可以写一个函数把这些步骤串起来：

1. Create your `URI` based off a passed-in package name.

   根据传入的 package 名称创建 `URI`。

2. Use `http.get` to retrieve the data for that package.

   用 `http.get` 取回该 package 的数据。

3. If the request didn't succeed, throw an `Exception`
   or preferably your own custom `Exception` subclass.

   如果请求没有成功，抛出 `Exception`，
   或者更好的是抛出你自己的 `Exception` 子类。

4. If the request succeeded, use `json.decode` to
   decode the response body into a JSON string.

   如果请求成功，用 `json.decode`
   把响应正文解码为 JSON 字符串。

5. Converted the decoded JSON string into a `PackageInfo` object
   using the `PackageInfo.fromJson` factory constructor you created.

   使用你创建的 `PackageInfo.fromJson` 工厂构造函数，
   把解码后的 JSON 字符串转换为 `PackageInfo` 对象。

<?code-excerpt "bin/fetch_http_package.dart (get-package)" plaster="none"?>
```dart
Future<PackageInfo> getPackage(String packageName) async {
  final packageUrl = Uri.https('dart.dev', '/f/packages/$packageName.json');
  final packageResponse = await http.get(packageUrl);

  // If the request didn't succeed, throw an exception
  if (packageResponse.statusCode != 200) {
    throw PackageRetrievalException(
      packageName: packageName,
      statusCode: packageResponse.statusCode,
    );
  }

  final packageJson = json.decode(packageResponse.body) as Map<String, dynamic>;

  return PackageInfo.fromJson(packageJson);
}

class PackageRetrievalException implements Exception {
  final String packageName;
  final int? statusCode;

  PackageRetrievalException({required this.packageName, this.statusCode});
}
```

## Utilize the converted data

## 使用转换后的数据

Now that you've retrieved data and
converted it to a more easily accessible format,
you can use it however you'd like.
Some possibilities include
outputting information to a CLI, or
displaying it in a [web][] or [Flutter][] app.

既然已经取回数据，
并把它转换成更容易使用的格式，
就可以按你的需要使用它。
例如把信息输出到命令行，
或在 [Web][web] 或 [Flutter][] 应用中显示。

Here is complete, runnable example
that requests, decodes, then displays
the mock information about the `http` and `path` packages:

下面是一个完整、可运行的示例，
它请求、解码并显示
关于 `http` 和 `path` 这两个 package 的模拟信息：

<?code-excerpt "bin/fetch_http_package.dart"?>
```dartpad
import 'dart:convert';

import 'package:http/http.dart' as http;

void main() async {
  await printPackageInformation('http');
  print('');
  await printPackageInformation('path');
}

Future<void> printPackageInformation(String packageName) async {
  final PackageInfo packageInfo;

  try {
    packageInfo = await getPackage(packageName);
  } on PackageRetrievalException catch (e) {
    print(e);
    return;
  }

  print('Information about the $packageName package:');
  print('Latest version: ${packageInfo.latestVersion}');
  print('Description: ${packageInfo.description}');
  print('Publisher: ${packageInfo.publisher}');

  final repository = packageInfo.repository;
  if (repository != null) {
    print('Repository: $repository');
  }
}

Future<PackageInfo> getPackage(String packageName) async {
  final packageUrl = Uri.https('dart.dev', '/f/packages/$packageName.json');
  final packageResponse = await http.get(packageUrl);

  // If the request didn't succeed, throw an exception
  if (packageResponse.statusCode != 200) {
    throw PackageRetrievalException(
      packageName: packageName,
      statusCode: packageResponse.statusCode,
    );
  }

  final packageJson = json.decode(packageResponse.body) as Map<String, dynamic>;

  return PackageInfo.fromJson(packageJson);
}

class PackageInfo {
  final String name;
  final String latestVersion;
  final String description;
  final String publisher;
  final Uri? repository;

  PackageInfo({
    required this.name,
    required this.latestVersion,
    required this.description,
    required this.publisher,
    this.repository,
  });

  factory PackageInfo.fromJson(Map<String, dynamic> json) {
    final repository = json['repository'] as String?;

    return PackageInfo(
      name: json['name'] as String,
      latestVersion: json['latestVersion'] as String,
      description: json['description'] as String,
      publisher: json['publisher'] as String,
      repository: repository != null ? Uri.tryParse(repository) : null,
    );
  }
}

class PackageRetrievalException implements Exception {
  final String packageName;
  final int? statusCode;

  PackageRetrievalException({required this.packageName, this.statusCode});

  @override
  String toString() {
    final buf = StringBuffer();
    buf.write('Failed to retrieve package:$packageName information');

    if (statusCode != null) {
      buf.write(' with a status code of $statusCode');
    }

    buf.write('!');
    return buf.toString();
  }

}
```

:::flutter-note
For another example that covers fetching then displaying data in Flutter,
see the [Fetching data from the internet][] Flutter recipe.

另一个在 Flutter 中获取并显示数据的示例，
见 Flutter 实用教程 [从互联网获取数据][Fetching data from the internet]。
:::

[web]: /web
[Flutter]: {{site.flutter}}
[Fetching data from the internet]: {{site.flutter-docs}}/cookbook/networking/fetch-data

## What next?

## 接下来做什么？

Now that you have retrieved, parsed, and used
data from the internet,
consider learning more about [Concurrency in Dart][].
If your data is large and complex,
you can move retrieval and decoding
to another [isolate][] as a background worker
to prevent your interface from becoming unresponsive.

既然你已经从互联网取回、解析并使用了数据，
可以进一步了解 [Dart 中的并发][Concurrency in Dart]。
如果数据又大又复杂，
可以把获取和解码移到另一个 [isolate][] 中作为后台工作，
以免界面失去响应。

[Concurrency in Dart]: /language/concurrency
[isolate]: /language/concurrency#isolates

[URI]: https://wikipedia.org/wiki/Uniform_Resource_Identifier
[Using JSON]: /libraries/serialization/json
[convert-docs]: {{site.dart-api}}/dart-convert/dart-convert-library.html
[http-pub]: {{site.pub-pkg}}/http
[http-docs]: {{site.pub-api}}/http
