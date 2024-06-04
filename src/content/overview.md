---
# title: Dart overview
title: Dart 概览
# description: A short introduction to Dart.
description: Dart 的简单介绍
js: [{url: '/assets/js/inject_dartpad.js', defer: true}]
---

<img 
  style="padding: 30px; float: right; width: 300px" 
  src="/assets/img/logo_lockup_dart_horizontal.png" 
  alt="Dart product logo">

Dart is a client-optimized language for developing fast apps on any platform.
Its goal is to offer the most productive programming language for
multi-platform development, paired with a
[flexible execution runtime platform](#platform) for app frameworks.

Dart 是一种针对客户端优化的语言，可在任何平台上开发快速的应用程序。
其目标是为多平台开发提供最高效的编程语言，
并为应用程序框架搭配了
[灵活的运行时执行平台](#platform)。

Languages are defined by their _technical envelope_—the 
choices made during development that
shape the capabilities and strengths of a language.
Dart is designed for a technical envelope that is
particularly suited to client development,
prioritizing both development (sub-second stateful hot reload) and
high-quality production experiences across
a wide variety of compilation targets (web, mobile, and desktop).

通常来说，编程语言会包含一些 **技术壁垒**，即语言在设计中的抉择决定了其功能和优势。
Dart 的语言设计针对客户端开发，它优先考虑多平台 (Web，移动端和桌面端) 上的开发 (亚秒级的状态热重载) 和高质量生产环境体验。

Dart also forms the foundation of [Flutter]({{site.flutter}}).
Dart provides the language and runtimes that power Flutter apps,
but Dart also supports many core developer tasks like
formatting, analyzing, and testing code.

Dart 也是 [Flutter]({{site.flutter}}) 的基础。
Dart 作为 Flutter 应用程序的编程语言，为驱动应用运行提供了环境，
同时 Dart 还支持许多核心的开发任务，例如格式化，分析和代码测试。

## Dart: The language {:#language}

## Dart 语言

The Dart language is type safe;
it uses static type checking to ensure that
a variable's value _always_ matches the variable's static type.
Sometimes, this is referred to as sound typing.
Although types are mandatory,
type annotations are optional because of type inference.
The Dart typing system is also flexible,
allowing the use of a `dynamic` type combined with runtime checks,
which can be useful during experimentation or
for code that needs to be especially dynamic.

Dart 语言是类型安全的；
它使用静态类型检查来确保变量的值 **始终** 与变量的静态类型相匹配。
这也叫健全类型。
尽管类型是强制性的，但由于 Dart 支持类型推断，类型注释仍是可选的。
Dart 的类型系统也很灵活，允许结合使用 dynamic 类型与运行时检查，
在测试开发期间，或是遇到需要特别指定为动态类型的代码时，这项特性很有帮助。

Dart has built-in [sound null safety](/null-safety).
This means values can't be null unless you say they can be.
With sound null safety, Dart can protect you from
null exceptions at runtime through static code analysis.
Unlike many other null-safe languages,
when Dart determines that a variable is non-nullable,
that variable can never be null.
If you inspect your running code in the debugger,
you see that non-nullability is retained at runtime; hence _sound_ null safety.

Dart 内置了 [健全的空值安全](/null-safety)，
这意味着只有你声明值可以为空的情况下，值才可以为空；
当 Dart 确定变量不可为空时，
该变量 **永远** 不可为空。
凭借健全的空值安全，Dart 可以通过静态代码分析在运行时保护你免受空值异常的影响。
如果你在调试器中审查正在运行的代码，你会看到不可为空性仍在运行时被保留，所以是完全的空安全。

The following code sample showcases several Dart language features,
including libraries, async calls, nullable and non-nullable types,
arrow syntax, generators, streams, and getters.
To learn more about the language, 
check out the [Dart language tour](/language).

以下代码示例展示了 Dart 语言的一些特性，
包括库、异步调用、可空和不可空的类型、箭头语法、生成器、流 (stream) 和 getter。
要了解有关 Dart 语言的更多信息，
请参阅 [Dart 简介](/language)。

<?code-excerpt "misc/lib/overview_pi.dart"?>
```dartpad
import 'dart:math' show Random;

void main() async {
  print('Compute π using the Monte Carlo method.');
  await for (final estimate in computePi().take(100)) {
    print('π ≅ $estimate');
  }
}

/// Generates a stream of increasingly accurate estimates of π.
Stream<double> computePi({int batch = 100000}) async* {
  var total = 0; // Inferred to be of type int
  var count = 0;
  while (true) {
    final points = generateRandom().take(batch);
    final inside = points.where((p) => p.isInsideUnitCircle);

    total += batch;
    count += inside.length;
    final ratio = count / total;

    // Area of a circle is A = π⋅r², therefore π = A/r².
    // So, when given random points with x ∈ <0,1>,
    // y ∈ <0,1>, the ratio of those inside a unit circle
    // should approach π / 4. Therefore, the value of π
    // should be:
    yield ratio * 4;
  }
}

Iterable<Point> generateRandom([int? seed]) sync* {
  final random = Random(seed);
  while (true) {
    yield Point(random.nextDouble(), random.nextDouble());
  }
}

class Point {
  final double x;
  final double y;

  const Point(this.x, this.y);

  bool get isInsideUnitCircle => x * x + y * y <= 1;
}
```

:::note

This example is running in an embedded [DartPad](/tools/dartpad).
You can also
<a href="{{site.dartpad}}/?id=bc63d212c3252e44058ff76f34ef5730"
target="_blank" rel="noopener">open this example in its own window</a>.

此示例在嵌入式 [DartPad](/tools/dartpad) 中运行。你也可以
<a href="{{site.dartpad}}/?id=bc63d212c3252e44058ff76f34ef5730"
target="_blank" rel="noopener">在此示例自己的窗口中打开它</a>。

:::

## Dart: The libraries {:#libraries}

## Dart 库

Dart has [a rich set of core libraries](/libraries),
providing essentials for many everyday programming tasks:

Dart 拥有 [丰富的核心库](/libraries)，为许多日常编程任务提供了必要工具：

* Built-in types, collections, and other core functionality for
  every Dart program
  (`dart:core`)

  为每个 Dart 程序提供的内置类型，集合与其他核心功能
  (`dart:core`)

* Richer collection types such as queues, linked lists, hashmaps, and
  binary trees
  (`dart:collection`)

  更丰富的集合类型，诸如队列、链接列表、哈希图和二叉树
  (`dart:collection`)

* Encoders and decoders for converting between different data representations,
  including JSON and UTF-8
  (`dart:convert`)

  用于在不同的数据表示形式之间进行转换编码器和解码器，
  包括 JSON 和 UTF-8
  (`dart:convert`)

* Mathematical constants and functions, and random number generation
  (`dart:math`)

  数学常数和函数，以及随机数生成
  (`dart:math`)

* Support for asynchronous programming,
  with classes such as `Future` and `Stream`
  (`dart:async`)

  异步编程支持，比如 `Future` 和 `Stream` 类
  (`dart:async`)

* Lists that efficiently handle fixed-sized data
  (for example, unsigned 8-byte integers) and SIMD numeric types
  (`dart:typed_data`)

  能够有效处理固定大小的数据（例如，无符号的 8 字节整数）
  和 SIMD 数字类型的列表
  (`dart:typed_data`)

* File, socket, HTTP, and other I/O support for non-web applications
  (`dart:io`)

  为非 Web 应用程序提供的文件、套接字、HTTP 和其他 I/O 支持
  (`dart:io`)

* Foreign function interfaces for interoperability with
  other code that presents a C-style interface
  (`dart:ffi`)

  用于提供 C 语言风格代码互通性支持的外部函数接口
  (`dart:ffi`)

* Concurrent programming using _isolates_—independent workers
  that are similar to threads but
  don't share memory, communicating only through messages
  (`dart:isolate`)

  使用 **isolates** 的并发编程 —
  这些独立的工作程序与线程相似但它们不共享内存并仅通过消息进行通信
  (`dart:isolate`)

* HTML elements and other resources for web-based applications that need to
  interact with the browser and the Document Object Model (DOM)
  (`dart:html`)

  基于 Web 的应用程序中需要与浏览器和文档对象模型
  (DOM) 交互的 HTML 元素和其他资源
  (`dart:html`)

Beyond the core libraries, many APIs are provided through
a comprehensive set of packages.
The Dart team publishes many useful supplementary packages,
such as these:

除核心库外，Dart 还通过一整套软件包提供了许多 API。
Dart 团队发布了许多有用的补充包，
例如：

* [characters]({{site.pub-pkg}}/characters)

  [characters (字符)]({{site.pub-pkg}}/characters)

* [intl]({{site.pub-pkg}}/intl) 

  [intl (国际化)]({{site.pub-pkg}}/intl) 

* [http]({{site.pub-pkg}}/http)

  [http (http 请求)]({{site.pub-pkg}}/http)

* [crypto]({{site.pub-pkg}}/crypto)

  [crypto (哈希加密)]({{site.pub-pkg}}/crypto)

* [markdown]({{site.pub-pkg}}/markdown)

Additionally, third-party publishers and the broader community
publish thousands of packages, with support for features like these:

此外，第三方发布者和更广泛的社区也
发布了上千个软件包，支持诸如此类功能：

* [XML]({{site.pub-pkg}}/xml) 

* [Windows integration]({{site.pub-pkg}}/win32)

  [Windows integration (Windows API 调用) ]({{site.pub-pkg}}/win32)

* [SQLite]({{site.pub-pkg}}/sqflite_common)

* [compression]({{site.pub-pkg}}/archive)

  [compression (压缩)]({{site.pub-pkg}}/archive)

To see a series of working examples featuring the Dart core libraries,
read the [core library documentation](/libraries).
To find additional APIs, check out the
[commonly used packages page](/resources/useful-packages).

你可以访问 [核心库文档](/libraries)，查看关于 Dart 核心库的一系列示例。
如果你想要查找其他 API，请参见 [常用的 package 页面](/resources/useful-packages)。

## Dart: The platforms {:#platform}

## Dart 平台

Dart's compiler technology lets you run code in different ways:

Dart 的编译器技术可让你以不同的方式运行代码：

* **Native platform**: For apps targeting mobile and desktop devices,
  Dart includes both a Dart VM with just-in-time (JIT) compilation and
  an ahead-of-time (AOT) compiler for producing machine code.

  **原生平台**：针对面向移动和桌面设备的应用程序，
  Dart 拥有具有实时 (JIT) 编译功能的 Dart VM 和用于生成机器代码的提前 (AOT) 编译器。

* **Web platform**: For apps targeting the web, Dart can compile for
  development or production purposes. Its web compilers translate Dart
  into JavaScript or WebAssembly.

  **Web 平台**：Dart 可用于编译开发和生产阶段的面向 Web 的应用，
  它的 Web 编译器可以将 Dart 转换为 JavaScript 或 WebAssembly。

<img 
  src="/assets/img/Dart-platforms.svg" 
  width="800" 
  alt="An illustration of the targets supported by Dart">

The [Flutter framework]({{site.flutter}}) is a popular,
multi-platform UI toolkit that's powered by the Dart platform,
and that provides tooling and UI libraries to build UI experiences that run
on iOS, Android, macOS, Windows, Linux, and the web.

[Flutter 框架]({{site.flutter}}) 是一款流行的多平台 UI 工具包，由 Dart 语言强力驱动，
提供一套工具和 UI 库，帮助开发者们在 iOS、Android、macOS、Windows、Linux 和 Web 平台
构建优秀的 UI 体验。

#### Dart Native (machine code JIT and AOT) {:#native-platform}

#### 原生平台的 Dart (JIT 和 AOT 机器码)

During development, a fast developer cycle is critical for iteration.
The Dart VM offers a just-in-time compiler (JIT) with
incremental recompilation (enabling hot reload), live metrics collections
(powering [DevTools](/tools/dart-devtools)), and rich debugging support.

在开发过程中，快速的开发周期对于迭代至关重要。
Dart VM 提供了一个实时编译器 (JIT)，编译器拥有增量重编译功能 (支持热重载)、
运行数据收集（用于驱动 [DevTools](/tools/dart-devtools)）
以及丰富的开发调试支持。

When apps are ready to be deployed to production—whether you're
publishing to an app store or deploying to a production backend—the 
Dart ahead-of-time (AOT) compiler can compile to native ARM or x64
machine code. Your AOT-compiled app launches with consistent, short
startup time.

当应用程序可以部署到生产环境时 (无论是发布到应用商店还是部署到生产后端)，
Dart AOT 编译器可以编译成原生的 ARM 或 x64 的机器码。
经过 AOT 编译的应用程序将稳定快速地启动。

The AOT-compiled code runs inside an efficient Dart runtime that
enforces the sound Dart type system and
manages memory using fast object allocation and a
[generational garbage collector](https://medium.com/flutter-io/flutter-dont-fear-the-garbage-collector-d69b3ff1ca30).

经过 AOT 编译的代码会在高效的 Dart 运行环境中运行，该运行环境拥有健全的 Dart 类型系统，
并使用快速对象分配和
[分代垃圾收集器](https://medium.com/flutter-io/flutter-dont-fear-the-garbage-collector-d69b3ff1ca30) 来管理内存。

More information:

更多相关信息：

* [Get started: Command-line and server apps](/tutorials/server/get-started)

  [快速上手：命令行与服务器应用](/tutorials/server/get-started)

* [`dart` tool for running with JIT or AOT compiling to machine code](/tools/dart-tool)

  [用于 JIT 运行或 AOT 编译为机器码的 `dart` 工具](/tools/dart-tool)

* [Write command-line apps](/tutorials/server/cmdline)

  [编写命令行应用应用程序](/tutorials/server/cmdline)

* [Write HTTP servers](/tutorials/server/httpserver)

  [编写 HTTP 服务器](/tutorials/server/httpserver)

#### Dart Web (JavaScript dev & prod and WebAssembly) {:#web-platform}

#### Web 平台的 Dart（JavaScript 的开发与部署以及 WebAssembly）

Dart Web enables running Dart code on web platforms powered by
JavaScript. With Dart Web, you compile Dart code to JavaScript code, which in
turn runs in a browser—for example, [V8](https://v8.dev/) inside
[Chrome](https://www.google.com/chrome/).
Alternatively, Dart code can be compiled to WebAssembly.

Dart 的 Web 支持让你可以在 JavaScript 驱动的网页平台上运行 Dart 代码。
使用 Web 环境下的 Dart 时，你可以将 Dart 编译为在浏览器中运行的 JavaScript 代码，
例如: [Chrome](https://www.google.cn/chrome/) 中的 [V8](https://v8.dev/)。
或者，也可以将 Dart 代码编译成 WebAssembly。

Dart web contains three compilation modes:

Dart Web 包含三种编译模式：

* An incremental JavaScript development compiler enabling a fast developer 
  cycle.

  一种为快速开发提供帮助的增量 JavaScript 编译器。

* An optimizing JavaScript production compiler which compiles Dart code to fast,
  compact, deployable JavaScript. These efficiencies come from techniques such
  as dead-code elimination.

  一种为生产环境优化的 JavaScript 编译器，
  可以将 Dart 代码编译成快速、紧凑、可部署的 JavaScript。
  它的高效之处在于使用了类似消除无用代码的优化。

* An optimizing WebAssembly (WasmGC) production compiler which compiles Dart
  code to super-fast, deployable WebAssembly GC code.

  一种为生产环境优化的 WebAssembly (WasmGC) 编译器，
  可以将 Dart 代码编译成超快、可部署的 WebAssembly GC 代码。

More information:

更多相关信息：

* [Build a web app with Dart](/web/get-started)

  [使用 Dart 构建 web 应用](/web/get-started)

* [`dart compile js`](/tools/dart-compile#js)
* [`webdev` tool](/tools/webdev)

  [`webdev` 工具](/tools/webdev)

* [Web deployment tips](/web/deployment)
* [WebAssembly compilation](/web/wasm)

  [网页部署提示](/web/deployment)

#### The Dart runtime {:#runtime}

#### Dart 运行时环境

Regardless of which platform you use or how you compile your code,
executing the code requires a Dart runtime.
This runtime is responsible for the following critical tasks:

不论你在哪个平台上使用、选择如何构建你的代码，
执行代码时都需要一个 Dart 运行时环境。
这个运行时环境负责下面的关键任务：

* Managing memory:
  Dart uses a managed memory model,
  where unused memory is reclaimed by a garbage collector (GC). 

  内存管理：
  Dart 使用一个受管理的内存模型，
  未被使用的内存会由垃圾收集器 (GC) 回收。

* Enforcing the Dart type system:
  Although most type checks in Dart are static (compile-time),
  some type checks are dynamic (runtime).
  For example, the Dart runtime enforces dynamic checks by
  [type check and cast operators](/language/operators#type-test-operators).

  执行 Dart 语言的类型体系：
  Dart 语言里大多数类型检查都是静态的（编译时），但仍有部分检查是动态的（运行时）。
  比如，Dart 运行时环境会在遇到
  [类型判断运算符](/language/operators#type-test-operators)
  时执行动态检查。

* Managing [isolates](/language/concurrency):
  The Dart runtime controls the main isolate (where code normally runs)
  and any other isolates that the app creates.

  管理 [isolates](/language/concurrency)：
  Dart 运行时环境会负责控制主 isolate（代码通常在这里运行）
  以及其他应用创建的 isolate。

On native platforms, the Dart runtime is automatically
included inside self-contained executables, 
and is part of the Dart VM provided by
the [`dart run`](/tools/dart-run) command.

在原生平台上，Dart 运行时环境被自动包含在独立的可执行文件中，
是 [`dart run`](/tools/dart-run) 命令提供的 Dart VM 的一部分。

## Learning Dart {:#learning-dart}

## 学习 Dart

You have many choices for learning Dart. Here are a few that we recommend:

学习 Dart 有很多选择。以下是我们推荐的一些方法：

* [Explore Dart in the browser]({{site.dartpad}}/) through DartPad,
  a web-based execution environment for Dart code.

  [在浏览器中探索 Dart]({{site.dartpad}}/) - DartPad 是一个基于网页的 Dart 代码执行环境。

* [Take a tour of the Dart language](/language),
  which shows you how to use each major Dart feature.

  [Dart 开发语言概览](/language)，
  它展示了如何使用 Dart 的主要特性。

* [Complete a Dart tutorial](/tutorials/server/cmdline) that 
  covers the basics of using Dart to build for the command line.

  [完成 Dart 教程](/tutorials/server/cmdline) 它涵盖了通过命令行构建使用 Dart 的基础知识。

* [Work through extensive online training][udemy]
  from Dart experts.

  来自 Dart 专家的 [在线课程][udemy]。

* [Explore the API documentation]({{site.dart-api}}) that
  describes the Dart core libraries.

  [探索 API 文档]({{site.dart-api}}) - 描述了 Dart 核心库。

* [Read a book about Dart programming](/resources/books).

  [阅读关于 Dart 编程的书籍](/resources/books)。

[udemy]: https://www.udemy.com/course/complete-dart-guide/?couponCode=NOV-20
