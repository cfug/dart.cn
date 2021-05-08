---
title: Core libraries
title: Dart 语言核心库
description: Learn about Dart's core libraries and APIs.
description: 学习使用 Dart 的核心库和 API。
---

Dart has a rich set of core libraries that provide essentials for many everyday
programming tasks such as working on collections of objects
(`dart:collection`), making calculations (`dart:math`), and encoding/decoding
data (`dart:convert`). Additional APIs are available in
[community contributed packages](/guides/libraries/useful-libraries).

Dart 拥有非常丰富的核心库用以为诸如处理对象集合（`dart:collection`）、
进行数学运算（`dart:math`）以及编/解码数据（`dart:convert`）
等常用编程操作提供支持。除此之外，
[由社区贡献的 packages](/guides/libraries/useful-libraries) 中也提供了许多其它
的 API 便于开发者使用。

<style>
  th:first-child {
    width: 80%;
  }
</style>

## Multi-platform libraries

## 全平台库列表

The following table lists the Dart core libraries that work on all
[Dart platforms](/overview#platform).

下面提供的一些库可以应用于所有 [Dart 可运行的平台](/overview#platform)。

<div class="table-wrapper" markdown="1">
|-----------------------------------------------+-------------------------------|
| Library                                       | Notes                         |
|-----------------------------------------------|-------------------------------|
| 库名称                                        | 备忘                         |
| [`dart:async`][dart-async]              <br> Support for asynchronous programming, with classes such as Future and Stream. | |
| [`dart:async`][dart-async]              <br> 支持通过使用 Future 和 Stream 这样的类实现异步编程。 | |
| [`dart:collection`][dart-collection]    <br> Classes and utilities that supplement the collection support in `dart:core`. | |
| [`dart:collection`][dart-collection]    <br> 提供 `dart:core` 库中不支持的额外的集合操作工具类。| |
| [`dart:convert`][dart-convert]          <br> Encoders and decoders for converting between different data representations, including JSON and UTF-8. | |
| [`dart:convert`][dart-convert]          <br> 用于提供转换不同数据的编码器和解码器，包括 JSON 和 UTF-8。 | |
| [`dart:core`][dart-core]                <br> Built-in types, collections, and other core functionality for every Dart program. | |
| [`dart:core`][dart-core]                <br> 每一个 Dart 程序都可能会使用到的内置类型、集合以及其它的一些核心功能。| |
| [`dart:developer`][dart-developer]      <br> Interaction with developer tools such as the debugger and inspector. | JIT and dartdevc only |
| [`dart:developer`][dart-developer]      <br> 类似调试器和分析器这样的与开发者交互配合的工具。| 只支持 JIT 和 dartdevc |
| [`dart:math`][dart-math]                <br> Mathematical constants and functions, plus a random number generator. | |
| [`dart:math`][dart-math]                <br> 包含算术相关函数和常量，还有随机数生成器。| |
| [`dart:typed_data`][dart-typed_data]    <br> Lists that efficiently handle fixed sized data (for example, unsigned 8-byte integers) and SIMD numeric types. | |
| [`dart:typed_data`][dart-typed_data]    <br> 高效处理固定大小数据（例如无符号的 8 位整型）和 SIMD 数字类型的列表。| |
{:.table .table-striped}
</div>

## Native platform libraries

## 原生平台库

The following table lists the Dart core libraries that work on the
[Dart native platform](/overview#platform) (AOT- and JIT-compiled code).

下面列出的核心库适用于 [Dart 原生平台](/overview#platform)（AOT 和 JIT 编译运行）。

<div class="table-wrapper" markdown="1">
|-----------------------------------------------+-------------------------------|
| Library                                       | Notes                         |
|-----------------------------------------------|-------------------------------|
| 库名称                                        | 备忘                         |
| [`dart:io`][dart-io]                    <br> File, socket, HTTP, and other I/O support for non-web applications. | |
| [`dart:io`][dart-io]                    <br> 用于支持非 Web 应用的文件、Socket、HTTP 和其它 I/O 操作。| |
| [`dart:isolate`][dart-isolate]          <br> Concurrent programming using isolates: independent workers similar to threads. | |
| [`dart:isolate`][dart-isolate]          <br> 使用 Isolate 实现并发编程：类似于线程的独立的 Worker。| |
| [`dart:mirrors`][dart-mirrors]          <br> Basic reflection with support for introspection and dynamic invocation. | Experimental<br>JIT only (_not_&nbsp;Flutter) |
| [`dart:mirrors`][dart-mirrors]          <br> 支持检查和动态调用的基本反射功能。| 实验性<br>只在 JIT 中有效 (**Flutter 中无效**) |
{:.table .table-striped}
</div>

## Web platform libraries

## Web 平台库

The following table lists the Dart core libraries that work on the
[Dart web platform](/overview#platform) (code compiled to JavaScript).

下面列出的核心库适用于 [Dart Web 平台](/overview#platform)（代码编译成 JS 来运行）。

<div class="table-wrapper" markdown="1">
|-----------------------------------------------+-------------------------------|
| Library                                       | Notes                         |
|-----------------------------------------------|-------------------------------|
| 库名称                                        | 备忘                         |
| [`dart:html`][dart-html]                <br> HTML elements and other resources for web-based applications. | |
| [`dart:html`][dart-html]                <br> 为 Web 应用开发所提供的 HTML 元素和其它资源。| |
| [`dart:indexed_db`][dart-indexed_db]    <br> Client-side key-value store with support for indexes. | |
| [`dart:indexed_db`][dart-indexed_db]    <br> 客户端上使用的可以索引的键值对存储。| |
| [`dart:web_audio`][dart-web_audio]      <br> High-fidelity audio programming in the browser. | |
| [`dart:web_audio`][dart-web_audio]      <br> 用于浏览器的高保真音频编程。| |
| [`dart:web_gl`][dart-web_gl]            <br> 3D programming in the browser. | |
| [`dart:web_gl`][dart-web_gl]            <br> 用于浏览器的 3D 编程。| |
| [`dart:js`][dart-js]                    <br> _Don't use._ Instead, use the `js` package, as described in [JavaScript interoperability][]. | *DEPRECATED* |
| [`dart:js`][dart-js]                    <br> **不要使用该库**，请使用 `js` 这个 Package 替代，就像我们在 [JavaScript 互相调用][JavaScript interoperability] 中说的那样。| **已弃用** |
| [`dart:js_util`][dart-js_util]          <br> APIs to supplement missing functionality in `dart:html` or the `js` package. | |
| [`dart:js_util`][dart-js_util]          <br> 补充 `dart:html` 或 `js` 包中缺少的功能性 API。 | |
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
[JavaScript interoperability]: /web/js-interop
