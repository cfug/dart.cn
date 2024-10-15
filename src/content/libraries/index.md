---
title: Dart's core libraries
description: Learn about Dart's core libraries and APIs.
short-title: Core libraries
nextpage:
  url: /libraries/dart-core
  title: dart:core
---

<style>
  th:first-child {
    width: 80%;
  }
</style>

Dart 拥有丰富的核心库集，为许多日常编程任务提供了基本要素，例如处理对象集合（`dart:collection`）、进行计算（`dart:math`）以及编码/解码数据（`dart:convert`）。在[常用的包](/resources/useful-packages)中可以使用其他 API。

## 库导览

以下指南介绍了如何使用 Dart 核心库的主要功能。它们仅提供概述，并不全面。每当您需要有关库或其成员的更多详细信息时，请查阅 [Dart API 参考][Dart API]。

[dart:core](/libraries/dart-core)
: 内置类型、集合和其他核心功能。这个库会自动导入到每个 Dart 程序中。

[dart:async](/libraries/dart-async)
: 支持异步编程，有诸如 Future 和 Stream 之类的类。

[dart:math](/libraries/dart-math)
: 它包含数学常量、数学函数以及一个随机数生成器。

[dart:convert](/libraries/dart-convert)
: 用于在不同数据表示形式之间进行转换的编码器和解码器，包括 JSON 和 UTF-8。

[dart:io](/libraries/dart-io)
: 可以使用 Dart 虚拟机的程序提供输入 / 输出（I/O）功能，其中包括 Flutter 应用程序、服务器以及命令行脚本。

[dart:html](/libraries/dart-html)
: 浏览器应用程序的 DOM 和其他 API。我们现在推荐使用 `package:web` 而不是 `dart:html`。

如前所述，这些页面只是一个概述；它们仅涵盖了一些 dart：\* 库，不包括任何第三方库。

有关 Dart 在不同平台上支持的所有库的概述，请查看下面的[“多平台库”](#multi-platform-libraries)[“原生平台库”](#native-platform-libraries)和[“Web 平台库”](#web-platform-libraries)列表。

其他可以找到库信息的地方是 [pub.dev]({{site.pub}}) 网站和 [Dart 网络开发者库指南][webdev libraries]。你可以在 Dart API 参考中找到所有 dart: \*库的 [API][Dart API] 文档，如果你正在使用 Flutter，则可以在 [Flutter API 参考][api-flutter]中找到。

要了解有关 Dart 语言的更多信息，请查看[语言文档和示例](/language)。

[Dart API]: {{site.dart-api}}/{{site.sdkInfo.channel}}
[webdev libraries]: /web/libraries
[api-flutter]: {{site.flutter-api}}

## 多平台库

以下表格列出了在所有 [Dart 平台](/overview#platform)上都能工作的 Dart 核心库。

| Library                                                                                                                                                                                                                             | Notes                                                              |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------ |
| [`dart:core`][dart-core]<br>每个 Dart 程序的内置类型、集合和其他核心功能。                                                                                                                                                          |                                                                    |
| [`dart:async`][dart-async], [`package:async`][package-async]<br>对异步编程的支持，包含诸如 `Future` 和 `Stream` 这样的类。`package:async` 围绕 `Future` 和 `Stream` 类型提供了额外的工具。                                          |                                                                    |
| [`dart:collection`][dart-collection], [`package:collection`][package-collection]<br>类与工具，用于补充 `dart:core` 中的集合支持。`package:collection` 为集合的处理与使用提供更多的集合实现方式和函数。                              |                                                                    |
| [`dart:convert`][dart-convert], [`package:convert`][package-convert]<br>用于在不同数据表示形式之间进行转换的编码器和解码器，其中包括 JSON 和 UTF-8。`convert`包提供了额外的编码器和解码器。                                         |                                                                    |
| [`dart:developer`][dart-developer]<br> 与开发工具（如调试器和检查器）进行交互。                                                                                                                                                     | [Native JIT][jit] and the [development JavaScript compiler][] only |
| [`dart:math`][dart-math]<br>它包含数学常量、数学函数以及一个随机数生成器。                                                                                                                                                          |                                                                    |
| [`dart:typed_data`][dart-typed_data], [`package:typed_data`][package-typed_data]<br>列表可以高效地处理固定大小的数据（例如，无符号 8 字节整数）和 SIMD 数值类型。<br>`package:typed_data`提供了更多的类和函数，用于处理类型化数据。 |                                                                    |

{:.table .table-striped}

## 原生平台

下面的表格列出了在[Dart 原生平台](/overview#native-platform)上工作的 Dart 核心库（包括 AOT 和 JIT 编译的代码）。

| Library                                                                                                                                                                                                              | Notes                                           |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------- |
| [`dart:ffi`][dart-ffi], [`package:ffi`][package-ffi]<br>一个外部函数接口，允许 Dart 代码使用原生 C API。.<br>`package:ffi` 是一个包含了多种实用工具的包，其中包括了支持将 Dart 字符串和 C 字符串之间进行转换的功能。 |                                                 |
| [`dart:io`][dart-io], [`package:io`][package-io]<br>文件、套接字、HTTP 以及其他非网页应用程序的 I/O 支持<br>`package:io` 提供的功能包括 ANSI 颜色支持、文件复制和标准退出代码。                                      |                                                 |
| [`dart:isolate`][dart-isolate]<br> 使用隔离区进行并发编程：类似于线程的独立工作者。                                                                                                                                  |                                                 |
| [`dart:mirrors`][dart-mirrors]<br> 基础反射功能，支持自省和动态调用。                                                                                                                                                | 仅实验性<br>[Native JIT][jit] (非&nbsp;Flutter) |

{:.table .table-striped}

## Web 平台库

下面的表格列出了在[Dart Web 平台](/overview#web-platform)（代码编译成 JavaScript）上工作的 Dart 核心库。最新且推荐的工具已加粗，而遗留工具则斜体显示（更多信息请访问[JavaScript 互操作性]()）。

| Library                                                                                                                               | Notes                                                                                 |
| ------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- |
| [**`package:web`**][pkg-web] <br>轻量级的浏览器 API 绑定，围绕 JavaScript 互操作性构建                                                | 替换了所有的 `dart:\* web` 库。了解如何迁移到新的库，你需要阅读[迁移指南][html-web]。 |
| [**`dart:js_interop`**][js-interop] <br>与 JS 以及浏览器 API 的互操作性                                                               | 替换 `package:js`.                                                                    |
| [**`dart:js_interop_unsafe`**][js-interop-unsafe] <br>用于动态操作 JS 对象的实用方法。                                                | 替换 `dart:js_util`.                                                                  |
| [_`dart:html`_][dart-html] _(legacy)_ <br>HTML 元素和其他资源是用于基于 Web 的应用程序的。                                            | 改用 `package:web`.                                                                   |
| [_`dart:indexed_db`_][dart-indexed_db] _(legacy)_ <br>具有索引支持的客户端键值存储。                                                  | 改用 `package:web` .                                                                  |
| [_`dart:js`_][dart-js], [_`dart:js_util`_][dart-js_util], [_`package:js`_][package-js] _(legacy)_ <br>JS 互操作的低级原语和高级注释。 | 改用 `dart:js_interop` or `dart:js_interop_unsafe` .                                  |
| [_`dart:svg`_][dart-svg] _(legacy)_ <br>可缩放矢量图形。                                                                              | 改用 `package:web` .                                                                  |
| [_`dart:web_audio`_][dart-web_audio] _(legacy)_ <br>在浏览器中进行高保真音频编程。                                                    | 改用 `package:web` .                                                                  |
| [_`dart:web_gl`_][dart-web_gl] _(legacy)_ <br>浏览器中的 3D 编程。                                                                    | `package:web` .                                                                       |

{:.table .table-striped}

<!---
Multi-platform libraries
-->

[dart-core]: {{site.dart-api}}/{{site.sdkInfo.channel}}/dart-core/dart-core-library.html
[dart-async]: {{site.dart-api}}/{{site.sdkInfo.channel}}/dart-async/dart-async-library.html
[package-async]: {{site.pub-pkg}}/async
[dart-collection]: {{site.dart-api}}/{{site.sdkInfo.channel}}/dart-collection/dart-collection-library.html
[package-collection]: {{site.pub-pkg}}/collection
[dart-convert]: {{site.dart-api}}/{{site.sdkInfo.channel}}/dart-convert/dart-convert-library.html
[package-convert]: {{site.pub-pkg}}/convert
[dart-developer]: {{site.dart-api}}/{{site.sdkInfo.channel}}/dart-developer/dart-developer-library.html
[dart-math]: {{site.dart-api}}/{{site.sdkInfo.channel}}/dart-math/dart-math-library.html
[dart-typed_data]: {{site.dart-api}}/{{site.sdkInfo.channel}}/dart-typed_data/dart-typed_data-library.html
[package-typed_data]: {{site.pub-pkg}}/typed_data

<!---
Native platform libraries
-->

[dart-ffi]: {{site.dart-api}}/{{site.sdkInfo.channel}}/dart-ffi/dart-ffi-library.html
[package-ffi]: {{site.pub-pkg}}/ffi
[dart-io]: {{site.dart-api}}/{{site.sdkInfo.channel}}/dart-io/dart-io-library.html
[package-io]: {{site.pub-pkg}}/io
[dart-isolate]: {{site.dart-api}}/{{site.sdkInfo.channel}}/dart-isolate/dart-isolate-library.html
[dart-mirrors]: {{site.dart-api}}/{{site.sdkInfo.channel}}/dart-mirrors/dart-mirrors-library.html

<!---
Web platform libraries
-->

[pkg-web]: {{site.pub-pkg}}/web
[js-interop]: {{site.dart-api}}/{{site.sdkInfo.channel}}/dart-js_interop/dart-js_interop-library.html
[js-interop-unsafe]: {{site.dart-api}}/{{site.sdkInfo.channel}}/dart-js_interop_unsafe/dart-js_interop_unsafe-library.html
[dart-html]: {{site.dart-api}}/{{site.sdkInfo.channel}}/dart-html/dart-html-library.html
[dart-indexed_db]: {{site.dart-api}}/{{site.sdkInfo.channel}}/dart-indexed_db/dart-indexed_db-library.html
[dart-js]: {{site.dart-api}}/{{site.sdkInfo.channel}}/dart-js/dart-js-library.html
[package-js]: {{site.pub-pkg}}/js
[dart-js_util]: {{site.dart-api}}/{{site.sdkInfo.channel}}/dart-js_util/dart-js_util-library.html
[dart-svg]: {{site.dart-api}}/{{site.sdkInfo.channel}}/dart-svg/dart-svg-library.html
[dart-web_audio]: {{site.dart-api}}/{{site.sdkInfo.channel}}/dart-web_audio/dart-web_audio-library.html
[dart-web_gl]: {{site.dart-api}}/{{site.sdkInfo.channel}}/dart-web_gl/dart-web_gl-library.html

<!---
Misc
-->

[development JavaScript compiler]: /tools/webdev#serve
[jit]: /overview#native-platform
[JavaScript interoperability]: /interop/js-interop
[html-web]: /interop/js-interop/package-web
