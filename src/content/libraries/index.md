---
# title: Dart's core libraries
title: Dart 核心库
# shortTitle: Core libraries
shortTitle: 核心库
# description: Learn about Dart's core libraries and APIs.
description: 了解 Dart 的核心库和 API。
nextpage:
  url: /libraries/dart-core
# title: dart:core
  title: dart:core
ai-translated: true
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
[commonly used packages](/resources/useful-packages).

Dart 拥有丰富的核心库，为许多日常编程任务提供基础能力，例如
处理对象集合（`dart:collection`）、
进行计算（`dart:math`），
以及编码和解码数据（`dart:convert`）。
更多 API 见
[常用 package](/resources/useful-packages)。

## Library tour

## 库导览

The following guides cover how to use major features of Dart's core libraries.
They provide just an overview, and are by no means comprehensive.
Whenever you need more details about a library or its members,
consult the [Dart API reference.][Dart API]

下面的指南介绍如何使用 Dart 核心库的主要功能。
它们只是概览，并非面面俱到。
需要了解某个库或其成员的更多细节时，
请查阅 [Dart API 参考][Dart API]。

[dart:core](/libraries/dart-core)
: Built-in types, collections, and other core functionality.
  This library is automatically imported into every Dart program.

  内置类型、集合和其他核心功能。
  该库会自动导入到每个 Dart 程序中。

[dart:async](/libraries/dart-async)
: Support for asynchronous programming, with classes such as Future and Stream.

  对异步编程的支持，包含 Future 和 Stream 等类。

[dart:math](/libraries/dart-math)
: Mathematical constants and functions, plus a random number generator.

  数学常量和函数，以及随机数生成器。

[dart:convert](/libraries/dart-convert)
: Encoders and decoders for converting between different data representations,
  including JSON and UTF-8.

  用于在不同数据表示之间转换的编码器和解码器，
  包括 JSON 和 UTF-8。

[dart:io](/libraries/dart-io)
: I/O for programs that can use the Dart VM,
  including Flutter apps, servers, and command-line scripts.

  可供使用 Dart VM 的程序进行 I/O，
  包括 Flutter 应用、服务器和命令行脚本。

[dart:js_interop](/interop/js-interop)
: APIs for interop with the web platform.
  Along with `package:web`, `dart:js_interop` replaces `dart:html`.

  与 Web 平台互操作的 API。
  `dart:js_interop` 与 `package:web` 一起取代 `dart:html`。


As mentioned, these pages are just an overview;
they cover only a few dart:* libraries
and no third-party libraries.

如前所述，这些页面只是概览；
它们只涵盖少数 dart:* 库，
不包含第三方库。

For an overview of all libraries that Dart supports on different platforms,
check out the [Multi-platform libraries](#multi-platform-libraries),
[Native platform libraries](#native-platform-libraries), and
[Web platform libraries](#web-platform-libraries) lists below.

要概览 Dart 在不同平台上支持的全部库，
请查看下方的 [多平台库](#multi-platform-libraries)、
[原生平台库](#native-platform-libraries) 和
[Web 平台库](#web-platform-libraries) 列表。

Other places to find library information are the
[pub.dev site]({{site.pub}}) and the
[Dart web developer library guide][webdev libraries].
You can find API documentation for all dart:* libraries in the
[Dart API reference][Dart API] or, if you're using Flutter,
the [Flutter API reference][api-flutter].

还可以在 [pub.dev 网站]({{site.pub}}) 和
[Dart Web 开发者库指南][webdev libraries] 查找库的信息。
所有 dart:* 库的 API 文档见
[Dart API 参考][Dart API]；如果使用 Flutter，
见 [Flutter API 参考][api-flutter]。

To learn more about the Dart language,
check out the [language documentation and samples](/language).

要进一步了解 Dart 语言，
请查阅 [语言文档和示例](/language)。

[Dart API]: {{site.dart-api}}
[webdev libraries]: /web/libraries
[api-flutter]: {{site.flutter-api}}

## Multi-platform libraries

## 多平台库

The following table lists the Dart core libraries that work on all
[Dart platforms](/overview#platform).

下表列出可在所有
[Dart 平台](/overview#platform) 上使用的 Dart 核心库。

| <t>Library</t><t>库</t>                                       | <t>Notes</t><t>说明</t>                         |
|-----------------------------------------------|-------------------------------|
| [`dart:core`][dart-core]<br>Built-in types, collections, and other core functionality for every Dart program. | |
| [`dart:core`][dart-core]<br>每个 Dart 程序的内置类型、集合和其他核心功能。 | |
| [`dart:async`][dart-async], [`package:async`][package-async]<br>Support for asynchronous programming, with classes such as `Future` and `Stream`.<br>`package:async` provides additional utilities around the `Future` and `Stream` types. | |
| [`dart:async`][dart-async]、[`package:async`][package-async]<br>对异步编程的支持，包含 `Future` 和 `Stream` 等类。<br>`package:async` 提供围绕 `Future` 和 `Stream` 类型的更多实用工具。 | |
| [`dart:collection`][dart-collection], [`package:collection`][package-collection]<br>Classes and utilities that supplement the collection support in `dart:core`.<br>`package:collection` provides further collection implementations and functions for working on and with collections. | |
| [`dart:collection`][dart-collection]、[`package:collection`][package-collection]<br>补充 `dart:core` 中集合支持的类和实用工具。<br>`package:collection` 提供更多集合实现，以及用于处理集合的函数。 | |
| [`dart:convert`][dart-convert], [`package:convert`][package-convert]<br>Encoders and decoders for converting between different data representations, including JSON and UTF-8.<br>`package:convert` provides additional encoders and decoders. ||
| [`dart:convert`][dart-convert]、[`package:convert`][package-convert]<br>用于在不同数据表示之间转换的编码器和解码器，包括 JSON 和 UTF-8。<br>`package:convert` 提供更多编码器和解码器。 ||
| [`dart:developer`][dart-developer]<br>Interaction with developer tools such as the debugger and inspector. | [Native JIT][jit] and the [development JavaScript compiler][] only |
| [`dart:developer`][dart-developer]<br>与调试器、检查器等开发者工具交互。 | 仅 [原生 JIT][jit] 和 [开发用 JavaScript 编译器][development JavaScript compiler] |
| [`dart:math`][dart-math]<br>Mathematical constants and functions, plus a random number generator. | |
| [`dart:math`][dart-math]<br>数学常量和函数，以及随机数生成器。 | |
| [`dart:typed_data`][dart-typed_data], [`package:typed_data`][package-typed_data]<br>Lists that efficiently handle fixed sized data (for example, unsigned 8-byte integers) and SIMD numeric types.<br>`package:typed_data` provides further classes and functions working on typed data. | |
| [`dart:typed_data`][dart-typed_data]、[`package:typed_data`][package-typed_data]<br>高效处理固定大小数据（例如无符号 8 字节整数）和 SIMD 数值类型的列表。<br>`package:typed_data` 提供更多用于处理类型化数据的类和函数。 | |

{:.table .table-striped}

## Native platform libraries

## 原生平台库

The following table lists the Dart core libraries that work on the
[Dart native platform](/overview#native-platform) (AOT- and JIT-compiled code).

下表列出可在
[Dart 原生平台](/overview#native-platform)（AOT 与 JIT 编译的代码）上使用的 Dart 核心库。

| <t>Library</t><t>库</t>                                       | <t>Notes</t><t>说明</t>                         |
|-----------------------------------------------|-------------------------------|
| [`dart:ffi`][dart-ffi], [`package:ffi`][package-ffi]<br>A foreign function interface that lets Dart code use native C APIs.<br>`package:ffi` contains utilities incl. support for converting Dart strings and C strings. | |
| [`dart:ffi`][dart-ffi]、[`package:ffi`][package-ffi]<br>外部函数接口，让 Dart 代码可以使用原生 C API。<br>`package:ffi` 包含实用工具，其中包括 Dart 字符串与 C 字符串的转换支持。 | |
| [`dart:io`][dart-io], [`package:io`][package-io]<br>File, socket, HTTP, and other I/O support for non-web applications.<br>`package:io` provides functionality including support for ANSI colors, file copying, and standard exit codes. | |
| [`dart:io`][dart-io]、[`package:io`][package-io]<br>面向非 Web 应用的文件、套接字、HTTP 和其他 I/O 支持。<br>`package:io` 提供的功能包括 ANSI 颜色、文件复制和标准退出码。 | |
| [`dart:isolate`][dart-isolate]<br> Concurrent programming using isolates: independent workers similar to threads. | |
| [`dart:isolate`][dart-isolate]<br>使用 isolate 进行并发编程：类似于线程的独立工作单元。 | |
| [`dart:mirrors`][dart-mirrors]<br> Basic reflection with support for introspection and dynamic invocation. | Experimental<br>[Native JIT][jit] only (_not_&nbsp;Flutter) |
| [`dart:mirrors`][dart-mirrors]<br>支持自省和动态调用的基本反射。 | 实验性<br>仅 [原生 JIT][jit]（**不**&nbsp;适用于 Flutter） |

{:.table .table-striped}

## Web platform libraries

## Web 平台库

The following table lists the Dart core libraries that work on the
[Dart web platform](/overview#web-platform) (code compiled to JavaScript).
The latest, recommended tools are **bolded**, and legacy tools are *italicized*
(visit [Javascript interoperability][] for more information).

下表列出可在
[Dart Web 平台](/overview#web-platform)（编译为 JavaScript 的代码）上使用的 Dart 核心库。
最新推荐的工具以 **粗体** 标出，旧版工具以 **斜体** 标出
（更多信息请访问 [JavaScript 互操作][Javascript interoperability]）。

| <t>Library</t><t>库</t>                                       | <t>Notes</t><t>说明</t>                         |
|-----------------------------------------------|-------------------------------|
| [**`package:web`**][pkg-web] <br>Lightweight browser API bindings built around JS interop | Replaces all `dart:*` web libraries. Read the [migration guide][html-web]. |
| [**`package:web`**][pkg-web] <br>围绕 JS 互操作构建的轻量浏览器 API 绑定 | 取代所有 `dart:*` Web 库。请阅读 [迁移指南][html-web]。 |
| [**`dart:js_interop`**][js-interop] <br>Interop with JavaScript and browser APIs. | Replaces `package:js`. |
| [**`dart:js_interop`**][js-interop] <br>与 JavaScript 和浏览器 API 互操作。 | 取代 `package:js`。 |
| [**`dart:js_interop_unsafe`**][js-interop-unsafe] <br>Utility methods to manipulate JavaScript objects dynamically. | Replaces `dart:js_util`. |
| [**`dart:js_interop_unsafe`**][js-interop-unsafe] <br>用于动态操作 JavaScript 对象的实用方法。 | 取代 `dart:js_util`。 |
| [*`dart:html`*][dart-html] *(legacy)* <br>HTML elements and other resources for web-based applications. | Use `package:web` instead. |
| [**`dart:html`**][dart-html] **旧版** <br>基于 Web 的应用所用的 HTML 元素和其他资源。 | 请改用 `package:web`。 |
| [*`dart:indexed_db`*][dart-indexed_db] *(legacy)* <br>Client-side key-value store with support for indexes.  | Use `package:web` instead. |
| [**`dart:indexed_db`**][dart-indexed_db] **旧版** <br>支持索引的客户端键值存储。 | 请改用 `package:web`。 |
| [*`dart:js`*][dart-js], [*`dart:js_util`*][dart-js_util], [*`package:js`*][package-js] *(legacy)* <br>Low-level primitives and higher-level annotations for JS interop. | Use `dart:js_interop` or `dart:js_interop_unsafe` instead. |
| [**`dart:js`**][dart-js]、[**`dart:js_util`**][dart-js_util]、[**`package:js`**][package-js] **旧版** <br>用于 JS 互操作的底层原语和更高层的注解。 | 请改用 `dart:js_interop` 或 `dart:js_interop_unsafe`。 |
| [*`dart:svg`*][dart-svg] *(legacy)* <br>Scalable Vector Graphics.  | Use `package:web` instead. |
| [**`dart:svg`**][dart-svg] **旧版** <br>可缩放矢量图形。 | 请改用 `package:web`。 |
| [*`dart:web_audio`*][dart-web_audio] *(legacy)* <br>High-fidelity audio programming in the browser. | Use `package:web` instead. |
| [**`dart:web_audio`**][dart-web_audio] **旧版** <br>在浏览器中进行高保真音频编程。 | 请改用 `package:web`。 |
| [*`dart:web_gl`*][dart-web_gl] *(legacy)* <br>3D programming in the browser. | Use `package:web` instead. |
| [**`dart:web_gl`**][dart-web_gl] **旧版** <br>在浏览器中进行 3D 编程。 | 请改用 `package:web`。 |

{:.table .table-striped}


<!---
Multi-platform libraries
-->
[dart-core]: {{site.dart-api}}/dart-core/dart-core-library.html
[dart-async]: {{site.dart-api}}/dart-async/dart-async-library.html
[package-async]: {{site.pub-pkg}}/async
[dart-collection]: {{site.dart-api}}/dart-collection/dart-collection-library.html
[package-collection]: {{site.pub-pkg}}/collection
[dart-convert]: {{site.dart-api}}/dart-convert/dart-convert-library.html
[package-convert]: {{site.pub-pkg}}/convert
[dart-developer]: {{site.dart-api}}/dart-developer/dart-developer-library.html
[dart-math]: {{site.dart-api}}/dart-math/dart-math-library.html
[dart-typed_data]: {{site.dart-api}}/dart-typed_data/dart-typed_data-library.html
[package-typed_data]: {{site.pub-pkg}}/typed_data

<!---
Native platform libraries
-->
[dart-ffi]: {{site.dart-api}}/dart-ffi/dart-ffi-library.html
[package-ffi]: {{site.pub-pkg}}/ffi
[dart-io]: {{site.dart-api}}/dart-io/dart-io-library.html
[package-io]: {{site.pub-pkg}}/io
[dart-isolate]: {{site.dart-api}}/dart-isolate/dart-isolate-library.html
[dart-mirrors]: {{site.dart-api}}/dart-mirrors/dart-mirrors-library.html

<!---
Web platform libraries
-->
[pkg-web]: {{site.pub-pkg}}/web
[js-interop]: {{site.dart-api}}/dart-js_interop/dart-js_interop-library.html
[js-interop-unsafe]: {{site.dart-api}}/dart-js_interop_unsafe/dart-js_interop_unsafe-library.html
[dart-html]: {{site.dart-api}}/dart-html/dart-html-library.html
[dart-indexed_db]: {{site.dart-api}}/dart-indexed_db/dart-indexed_db-library.html
[dart-js]: {{site.dart-api}}/dart-js/dart-js-library.html
[package-js]: {{site.pub-pkg}}/js
[dart-js_util]: {{site.dart-api}}/dart-js_util/dart-js_util-library.html
[dart-svg]: {{site.dart-api}}/dart-svg/dart-svg-library.html
[dart-web_audio]: {{site.dart-api}}/dart-web_audio/dart-web_audio-library.html
[dart-web_gl]: {{site.dart-api}}/dart-web_gl/dart-web_gl-library.html

<!---
Misc
-->
[development JavaScript compiler]: /tools/webdev#serve
[jit]: /overview#native-platform
[JavaScript interoperability]: /interop/js-interop
[html-web]: /interop/js-interop/package-web
