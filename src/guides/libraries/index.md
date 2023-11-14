---
title: Core libraries
title: Dart 语言核心库
description: Learn about Dart's core libraries and APIs.
description: 学习使用 Dart 的核心库和 API。
---

<style>
  th:first-child {
    width: 80%;
  }
</style>

Dart has a rich set of core libraries that provide essentials for many everyday
programming tasks such as 
working on collections of objects (`dart:collection`), 
making calculations (`dart:math`), 
and encoding/decoding data (`dart:convert`). 
Additional APIs are available in
[commonly used packages](/guides/libraries/useful-libraries).

Dart 拥有非常丰富的核心库用以为诸如处理对象集合（`dart:collection`）、
进行数学运算（`dart:math`）以及编/解码数据（`dart:convert`）
等常用编程操作提供支持。除此之外，
[由社区贡献的 packages](/guides/libraries/useful-libraries) 中也提供了许多其它
的 API 便于开发者使用。

## Multi-platform libraries

## 全平台库列表

The following table lists the Dart core libraries that work on all
[Dart platforms](/overview#platform).

下面提供的一些库可以应用于所有 [Dart 可运行的平台](/overview#platform)。

|-----------------------------------------------+-------------------------------|
| Library                                       | Notes                         |
|-----------------------------------------------|-------------------------------|
| 库名称                                         | 备注                           |
| [`dart:core`][dart-core]              <br>Built-in types, collections, and other core functionality for every Dart program. | |
| [`dart:core`][dart-core]              <br> 每一个 Dart 程序都可能会使用到的内置类型、集合以及其它的一些核心功能。| |
| [`dart:async`][dart-async], [`package:async`][package-async]<br>Support for asynchronous programming, with classes such as `Future` and `Stream`.<br>`package:async` provides additional utilities around the `Future` and `Stream` types. | |
| [`dart:async`][dart-async], [`package:async`][package-async]<br>支持通过使用 `Future` 和 `Stream` 这样的类实现异步编程。<br>`package:async` 提供了更多围绕 `Future` 和 `Stream` 构建的实用工具 | |
| [`dart:collection`][dart-collection], [`package:collection`][package-collection]<br>Classes and utilities that supplement the collection support in `dart:core`.<br>`package:collection` provides further collection implementations and functions for working on and with collections. | |
| [`dart:collection`][dart-collection], [`package:collection`][package-collection]<br>提供 `dart:core` 库中不支持的额外的集合实用工具类。<br>`package:collection` 则提供了更进一步的、用于处理和使用集合的函数和实现 | |
| [`dart:convert`][dart-convert], [`package:convert`][package-convert]<br>Encoders and decoders for converting between different data representations, including JSON and UTF-8.<br>`package:convert` provides additional encoders and decoders. ||
| [`dart:convert`][dart-convert], [`package:convert`][package-convert]<br>用于提供转换不同数据的编码器和解码器，包括 JSON 和 UTF-8。<br>`package:convert` 则提供了更多编解码器。 |
| [`dart:developer`][dart-developer]<br>Interaction with developer tools such as the debugger and inspector. | [Native JIT][jit] and the [development JavaScript compiler][] only |
| [`dart:developer`][dart-developer]<br>类似调试器和分析器这样的与开发者交互配合的工具。| 仅支持 [Native JIT][jit] 和 [webdev][development JavaScript compiler] |
| [`dart:math`][dart-math]<br>Mathematical constants and functions, plus a random number generator. | |
| [`dart:math`][dart-math]<br>包含算术相关函数和常量，还有随机数生成器。 | |
| [`dart:typed_data`][dart-typed_data], [`package:typed_data`][package-typed_data]<br>Lists that efficiently handle fixed sized data (for example, unsigned 8-byte integers) and SIMD numeric types.<br>`package:typed_data` provides further classes and functions working on typed data. | |
| [`dart:typed_data`][dart-typed_data], [`package:typed_data`][package-typed_data]<br>高效处理固定大小数据（例如无符号的 8 位整型）和 SIMD 数字类型的列表。<br>`package:typed_data` 提供了更进一步的类和方法用于处理结构化的数据。 | |
{:.table .table-striped}

## Native platform libraries

## 原生平台库

The following table lists the Dart core libraries that work on the
[Dart native platform](/overview#native-platform) (AOT- and JIT-compiled code).

下面列出的核心库适用于 [Dart 原生平台](/overview#platform)（AOT 和 JIT 编译运行）。

|-----------------------------------------------+-------------------------------|
| Library                                       | Notes                         |
|-----------------------------------------------|-------------------------------|
| 库名称                                         | 备注                           |
| [`dart:ffi`][dart-ffi], [`package:ffi`][package-ffi]<br>A foreign function interface that lets Dart code use native C APIs.<br>`package:ffi` contains utilities incl. support for converting Dart strings and C strings. | |
| [`dart:ffi`][dart-ffi], [`package:ffi`][package-ffi]<br>Dart 代码可以通过这个外部函数接口使用原生的 C 语言 API。<br>`package:ffi` 提供的实用工具包括：支持转换 Dart 字符串和 C 字符串。 | |
| [`dart:io`][dart-io], [`package:io`][package-io]<br>File, socket, HTTP, and other I/O support for non-web applications.<br>`package:io` provides functionality including support for ANSI colors, file copying, and standard exit codes. | |
| [`dart:io`][dart-io], [`package:io`][package-io]<br>用于支持非 Web 应用的文件、Socket、HTTP 和其它 I/O 操作。<br>`package:io` 提供的功能包括 ANSI 颜色、文件复制和标准化的退出代码。 | |
| [`dart:isolate`][dart-isolate]<br> Concurrent programming using isolates: independent workers similar to threads. | |
| [`dart:isolate`][dart-isolate]<br> 使用 Isolate 实现并发编程：类似于线程的独立的 Worker。 | |
| [`dart:mirrors`][dart-mirrors]<br> Basic reflection with support for introspection and dynamic invocation. | Experimental<br>[Native JIT][jit] only (_not_&nbsp;Flutter) |
| [`dart:mirrors`][dart-mirrors]<br> 支持检查和动态调用的基本反射功能。 | 实验性<br>只在 JIT 中有效 (**Flutter 中无效**) |
{:.table .table-striped}

## Web platform libraries

## Web 平台库

The following table lists the Dart core libraries that work on the
[Dart web platform](/overview#web-platform) (code compiled to JavaScript).

下面列出的核心库适用于 [Dart Web 平台](/overview#platform)（代码编译成 JS 来运行）。

|-----------------------------------------------+-------------------------------|
| Library                                       | Notes                         |
|-----------------------------------------------|-------------------------------|
| 库名称                                         | 备注                           |
| [`dart:html`][dart-html]<br>HTML elements and other resources for web-based applications. | |
| [`dart:html`][dart-html]<br>为 Web 应用开发所提供的 HTML 元素和其它资源。 | |
| [`dart:indexed_db`][dart-indexed_db]<br>Client-side key-value store with support for indexes. | |
| [`dart:indexed_db`][dart-indexed_db]<br>客户端上使用的可以索引的键值对存储。 | |
| [`dart:js`][dart-js], [`dart:js_util`][dart-js_util], [`package:js`][package-js]<br>`dart:js_util` provides low-level primitives for interoperability; typically the higher-level annotations in `package:js` are recommended, as they help express interoperability more succinctly. For more details see [JavaScript interoperability][].<br>_Don't use `dart:js` directly; direct use of those legacy APIs is deprecated_. | |
| [`dart:js`][dart-js], [`dart:js_util`][dart-js_util], [`package:js`][package-js]<br>`dart:js_util` 为互操作提供了低级原语 (Low-Level Primitives)，通常情况下我们更推荐使用 `package:js` 中提供的更高阶的注解内容，因为它们更有助于更简洁地表达和体现互操作性。<br> **请不要直接使用 `dart:js` 了，那些 API 已被标记为已废弃** | |
| [`dart:svg`][dart-svg]<br>Scalable Vector Graphics. | |
| [`dart:svg`][dart-svg]<br>用于可缩放的矢量图形 (SVG)。 | |
| [`dart:web_audio`][dart-web_audio]<br>High-fidelity audio programming in the browser. | |
| [`dart:web_audio`][dart-web_audio]<br>用于浏览器的高保真音频编程。 | |
| [`dart:web_gl`][dart-web_gl]<br>3D programming in the browser. | |
| [`dart:web_gl`][dart-web_gl]<br>用于浏览器的 3D 编程。 | |
{:.table .table-striped}

<!---
Multi-platform libraries
-->
[dart-core]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/dart-core-library.html
[dart-async]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-async/dart-async-library.html
[package-async]: {{site.pub-pkg}}/async
[dart-collection]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-collection/dart-collection-library.html
[package-collection]: {{site.pub-pkg}}/collection
[dart-convert]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-convert/dart-convert-library.html
[package-convert]: {{site.pub-pkg}}/convert
[dart-developer]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-developer/dart-developer-library.html
[dart-math]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-math/dart-math-library.html
[dart-typed_data]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-typed_data/dart-typed_data-library.html
[package-typed_data]: {{site.pub-pkg}}/typed_data

<!---
Native platform libraries
-->
[dart-ffi]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-ffi/dart-ffi-library.html
[package-ffi]: {{site.pub-pkg}}/ffi
[dart-cli]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-cli/dart-cli-library.html
[dart-io]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-io/dart-io-library.html
[package-io]: {{site.pub-pkg}}/io
[dart-isolate]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-isolate/dart-isolate-library.html
[package-isolate]: {{site.pub-pkg}}/isolate
[dart-mirrors]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-mirrors/dart-mirrors-library.html

<!---
Web platform libraries
-->
[dart-html]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-html/dart-html-library.html
[dart-indexed_db]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-indexed_db/dart-indexed_db-library.html
[dart-js]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-js/dart-js-library.html
[package-js]: {{site.pub-pkg}}/js
[dart-js_util]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-js_util/dart-js_util-library.html
[dart-svg]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-svg/dart-svg-library.html
[dart-web_audio]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-web_audio/dart-web_audio-library.html
[dart-web_gl]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-web_gl/dart-web_gl-library.html

<!---
Misc
-->
[development JavaScript compiler]: /tools/webdev#serve
[jit]: /overview#native-platform
[JavaScript interoperability]: /web/js-interop
