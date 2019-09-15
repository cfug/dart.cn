---
title: Core libraries
title: Dart 语言核心库
description: Learn about Dart's core libraries and APIs.
description: 学习使用 Dart 的核心库和 API。
toc: false
---

Dart has a rich set of core libraries that provide essentials for many everyday
programming tasks such as working on collections of objects
(`dart:collection`), making calculations (`dart:math`), and encoding/decoding
data (`dart:convert`). Additional APIs are available in
[community contributed packages](/guides/libraries/useful-libraries).

Dart 拥有非常丰富的核心库用以为诸如处理对象集合（`dart:collection`）、进行数学运算（`dart:math`）以及编/解码数据（`dart:convert`）等常用编程操作提供支持。除此之外，[社区贡献的包](/guides/libraries/useful-libraries) 中也提供了许多其它的 API 便于开发者使用。

The following table lists all of the Dart core libraries.
Each library works on at least one [platform](/platforms).

下表列出了所有 Dart 核心库。每个库至少可以工作在其中一个 [平台](/platforms)上。

<div class="table-wrapper" markdown="1">
|-----------------------------------------------+-------------------------------|
| Library                                       | Supported platforms   |

| 库                                            |        支持的平台       |

|-----------------------------------------------|-------------------------------|
| [`dart:async`][dart-async]              <br> Support for asynchronous programming, with classes such as Future and Stream. | All |

| [`dart:async`][dart-async]              <br> 使用 Future 和 Stream 这样的类实现异步编程。                                       | 所有平台 |

| [`dart:collection`][dart-collection]    <br> Classes and utilities that supplement the collection support in `dart:core`. | All |

| [`dart:collection`][dart-collection]    <br> 提供 `dart:core` 库中不支持的额外的集合操作工具类。                                  | 所有平台 |

| [`dart:convert`][dart-convert]          <br> Encoders and decoders for converting between different data representations, including JSON and UTF-8. | All |

| [`dart:convert`][dart-convert]          <br> 用于提供转换不同数据的编码器和解码器，包括 JSON 和 UTF-8。                            | 所有平台 |

| [`dart:core`][dart-core]                <br> Built-in types, collections, and other core functionality for every Dart program. | All |

| [`dart:core`][dart-core]                <br> 每一个 Dart 程序都可能会使用到的内置类型、集合以及其它的一些核心功能。                   | 所有平台 |

| [`dart:developer`][dart-developer]      <br> Interaction with developer tools such as the debugger and inspector. | JIT<br>Web (experimental, dartdevc&nbsp;only) |

| [`dart:developer`][dart-developer]      <br> 类似调试器和分析器这样的与开发者交互配合的工具。                                      | JIT<br>Web (实验性的, 只支持 dartdevc&nbsp) |

| [`dart:html`][dart-html]                <br> HTML elements and other resources for web-based applications. | Web |

| [`dart:html`][dart-html]                <br> 为 Web 应用开发所提供的 HTML 元素和其它资源。                                       | Web |

| [`dart:indexed_db`][dart-indexed_db]    <br> Client-side key-value store with support for indexes. | Web |

| [`dart:indexed_db`][dart-indexed_db]    <br> 客户端上使用的可以索引的键值对存储。                                                | Web |

| [`dart:io`][dart-io]                    <br> File, socket, HTTP, and other I/O support for non-web applications. | JIT<br>AOT |

| [`dart:io`][dart-io]                    <br> 用于支持非 Web 应用的文件、Socket、HTTP 和其它 I/O 操作。                           | JIT<br>AOT |

| [`dart:isolate`][dart-isolate]          <br> Concurrent programming using isolates: independent workers similar to threads. | JIT<br>AOT |

| [`dart:isolate`][dart-isolate]          <br> 使用 Isolate 实现并发编程：类似于线程的独立的 Worker。                              | JIT<br>AOT |

| [`dart:js`][dart-js]                    <br> _Don't use._ Instead, use the `js` package, as described in [JavaScript interoperability][]. | Web |

| [`dart:js`][dart-js]                    <br> _不要使用该库。_ 而是使用 `js` 这个 Package 替代，就像我们在 [JavaScript 互相调用][JavaScript interoperability] 中说的那样。| Web |

| [`dart:js_util`][dart-js_util]                    <br> _Don't use._ Instead, use the `js` package, as described in [JavaScript interoperability][]. | Web |

| [`dart:js_util`][dart-js_util]          <br> _不要使用该库。_ 而是使用 `js` 这个 Package 替代，就像我们在 [JavaScript 互相调用][JavaScript interoperability] 中说的那样。| Web |

| [`dart:math`][dart-math]                <br> Mathematical constants and functions, plus a random number generator. | All

| [`dart:math`][dart-math]                <br> 包含算术相关函数和常量，还有随机数生成器。                                          | 所有平台 |

| [`dart:mirrors`][dart-mirrors]          <br> Basic reflection with support for introspection and dynamic invocation. | JIT (experimental, _not_&nbsp;Flutter) |

| [`dart:mirrors`][dart-mirrors]          <br> 支持检查和动态调用的基本反射功能。                                                | JIT (实验性的, _不支持_&nbsp Flutter) |

| [`dart:typed_data`][dart-typed_data]    <br> Lists that efficiently handle fixed sized data (for example, unsigned 8-byte integers) and SIMD numeric types. | All |

| [`dart:typed_data`][dart-typed_data]    <br> 高效处理固定大小数据（例如无符号的 8 位整型）和 SIMD 数字类型的列表。                 | 所有平台 |

| [`dart:web_audio`][dart-web_audio]      <br> High-fidelity audio programming in the browser. | Web |

| [`dart:web_audio`][dart-web_audio]      <br> 用于浏览器的高保真音频编程。                                                    | Web |

| [`dart:web_gl`][dart-web_gl]            <br> 3D programming in the browser. | Web

| [`dart:web_gl`][dart-web_gl]            <br> 用于浏览器的 3D 编程。                                                        | Web |

| [`dart:web_sql`][dart-web_sql]          <br> API for storing data in the browser that can be queried with SQL. | Web (obsolete) |

| [`dart:web_sql`][dart-web_sql]          <br> 用于在浏览器中存储数据的 API，存储的数据可以通过 SQL 查询。                         | Web（已弃用） |
{:.table .table-striped}
</div>

[dart-async]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-async/dart-async-library.html
[dart-collection]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-collection/dart-collection-library.html
[dart-convert]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-convert/dart-convert-library.html
[dart-core]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/dart-core-library.html
[dart-developer]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-developer/dart-developer-library.html
[dart-math]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-math/dart-math-library.html
[dart-collection]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-collection/dart-collection-library.html
[dart-typed_data]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-typed_data/dart-typed_data-library.html
[dart-cli]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-cli/dart-cli-library.html
[dart-io]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-io/dart-io-library.html
[dart-isolate]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-isolate/dart-isolate-library.html
[dart-mirrors]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-mirrors/dart-mirrors-library.html
[dart-html]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-html/dart-html-library.html
[dart-indexed_db]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-indexed_db/dart-indexed_db-library.html
[dart-js]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-js/dart-js-library.html
[dart-js_util]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-js_util/dart-js_util-library.html
[dart-svg]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-svg/dart-svg-library.html
[dart-web_audio]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-web_audio/dart-web_audio-library.html
[dart-web_gl]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-web_gl/dart-web_gl-library.html
[dart-web_sql]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-web_sql/dart-web_sql-library.html
[JavaScript interoperability]: /web/js-interop
