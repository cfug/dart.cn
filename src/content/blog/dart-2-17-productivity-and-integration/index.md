---
# title: "Dart 2.17: Productivity and integration"
title: "Dart 2.17：生产力与集成"
# description: "Language features. Productivity tools. Deeper & broader platform integration."
description: "语言特性。生产力工具。更深入、更广泛的平台集成。"
ai-translated: true
publishDate: 2022-05-11
author: mit-mit
image: images/1eJKM-4rFprGXyxNd5w2m-Q.webp
category: releases
layout: blog
---


Today at [Google I/O](https://io.google/2022/products/flutter/), we announced a new Dart SDK, version 2.17. This release builds on our core themes of leading productivity and platform portability. It offers new language features: enums with member support, improved parameter forwarding to super classes, and more flexibility for named parameters. We have improved tools with a new major version of `package:lints` — our tool support for checking Dart code against our best practices — and a broad update of core library API documentation with rich code samples. For improved platform integration we have new templates for using `dart:ffi` (native C interop) in Flutter plugins, experimental support for RISC-V processors, and support for signing macOS and Windows executables.

今天在 [Google I/O](https://io.google/2022/products/flutter/) 上，我们宣布了新的 Dart SDK 2.17 版本。这个版本延续我们领先生产力和平台可移植性的核心主题。它带来新的语言特性：支持成员的枚举、改进的向超类转发参数，以及更灵活的命名参数。工具方面，我们发布了 `package:lints` 的新主版本——这是我们按最佳实践检查 Dart 代码的工具支持——并全面更新了核心库 API 文档，加入丰富的代码示例。平台集成方面，我们提供了在 Flutter 插件中使用 `dart:ffi`（原生 C 互操作）的新模板、对 RISC-V 处理器的实验性支持，以及 macOS 和 Windows 可执行文件签名支持。

<DashImage src="images/1eJKM-4rFprGXyxNd5w2m-Q.webp" alt="A stylized graphic with the text 'Dart 2.17', representing the new release." />


## New language features for improved productivity

## 提升生产力的新语言特性

We constantly evolve the Dart language to make you more productive — both by adding new features and by making improvements to existing features. Dart 2.17 adds major new support for members on enums, refines how you can use named arguments in constructors, and makes code for forwarding parameters to superclasses much less verbose and repetitive.

我们持续演进 Dart 语言来提升你的生产力——既添加新特性，也改进现有特性。Dart 2.17 为枚举成员添加了重要的新支持，细化了构造函数中命名实参的使用方式，并让向超类转发参数的代码大大减少冗长和重复。

### Enhanced enums with members

### 带成员的增强枚举

Enums are great for representing a discrete set of states. For example, we might model water as `enum Water { frozen, lukewarm, boiling }`. But what if we want to add some methods on the `enum` — for example, to convert each of the states to a temperature, and support converting the `enum` to a `String`? We could perhaps use extension methods to add a `waterToTemp()` method, but we’d have to be careful to keep that in sync with the `enum`. For the `String` conversion we’d prefer to override `toString()`, but that hasn’t been supported.

枚举很适合表示一组离散的状态。例如，我们可以把水建模为 `enum Water { frozen, lukewarm, boiling }`。但如果我们想给 `enum` 加一些方法呢——例如把每个状态转换成温度，并支持把 `enum` 转换成 `String`？也许可以用 extension 方法添加一个 `waterToTemp()` 方法，但必须小心让它与 `enum` 保持同步。对于 `String` 转换，我们更想重写 `toString()`，但此前并不支持。

With Dart 2.17 we now have general support for members on enums. That means we can add fields holding state, constructors that set that state, methods with functionality, and even override existing members. Many of you have been requesting this capability; it was our [third highest voted issue](https://github.com/dart-lang/language/issues?q=is%3Aissue+sort%3Areactions-%2B1-desc+) in the language tracker.

Dart 2.17 现在全面支持枚举成员。这意味着我们可以添加保存状态的字段、设置状态的构造函数、实现功能的方法，甚至重写现有成员。很多人一直在请求这个能力；它是语言跟踪器中[得票第三高的 issue](https://github.com/dart-lang/language/issues?q=is%3Aissue+sort%3Areactions-%2B1-desc+)。

For our water example, we can add an `int` field holding the temperature and a default constructor that takes an `int`:

对于水的例子，我们可以添加一个保存温度的 `int` 字段和一个接收 `int` 的默认构造函数：

```
enum Water {
…
  final int tempInFahrenheit;
  const Water(this.tempInFahrenheit);
}
```


To ensure the constructor is called when the `enum` is created, we need to invoke it for each `enum` value:

为确保创建 `enum` 时调用构造函数，需要为每个 `enum` 值调用它：

```
enum Water {
  frozen(32),
  lukewarm(100),
  boiling(212);
…
}
```


To support the conversion to `String`, we simply override `toString`, which `enums` inherit from `Object`:

要支持转换为 `String`，只需重写 `enums` 从 `Object` 继承的 `toString`：

```
[@override](http://twitter.com/override)
String toString() => "The $name water is $tempInFahrenheit F.";
```


And with that, you have a complete `enum` that can be easily instantiated and you can invoke methods on:

这样你就有了一个完整的 `enum`，可以轻松实例化并调用其方法：

```
void main() {
  print(Water.frozen); // Prints “The frozen water is 32 F.”
}
```


A complete example of these two approaches is illustrated below; we find the new Dart 2.17 version much easier to read and maintain.

下面展示了这两种方法的完整示例；我们认为新的 Dart 2.17 版本更易读、更易维护。

<DashImage src="images/0hGKUdu4DT9v2IZGj.webp" alt="Code snippets comparing enums before and after Dart 2.17, showing improved readability." />


### Super initializers

### 超类初始化器

When you have a class inheritance hierarchy, a common pattern is to pass some constructor parameters to the constructor of the superclass. To do that, the sub-class needs to 1) list each parameter in its own constructor, and 2) invoke the super constructor with those parameters. That leads to boilerplate code: lots of repetition, making the code harder to read and more bothersome to maintain.

在有类继承层次时，一个常见模式是把一些构造函数参数传给超类的构造函数。为此，子类需要 1) 在自己的构造函数中列出每个参数，2) 用这些参数调用超类构造函数。这带来了样板代码：大量重复，让代码更难读、维护更麻烦。

Several Dart community members helped make this happen. GitHub user @roy-sianez filed a [language issue](https://github.com/dart-lang/language/issues/1855) regarding this about half a year ago; suggesting something similar to what GitHub user [@apps](http://twitter.com/apps)-transround had [suggested earlier](https://github.com/dart-lang/language/issues/493#issuecomment-879624528): that we could perhaps resolve this by introducing a new construct to express that a parameter was specified in the super class. We thought that was a great idea, so this has been added to Dart 2.17. As you can see from the following example, this is especially relevant for Flutter widget code. In fact, when we applied the new feature to the Flutter framework, we saw a total reduction of [nearly two thousand lines of code](https://github.com/flutter/flutter/pull/100905/files)!

几位 Dart 社区成员帮助促成了这个特性。GitHub 用户 @roy-sianez 大约半年前提了一个[语言 issue](https://github.com/dart-lang/language/issues/1855)，建议的方案与 GitHub 用户 [@apps](http://twitter.com/apps)-transround [更早的建议](https://github.com/dart-lang/language/issues/493#issuecomment-879624528)类似：也许可以引入一种新构造来表达参数在超类中指定。我们觉得这是个很棒的想法，于是把它加入了 Dart 2.17。从下面的例子可以看到，这对 Flutter widget 代码尤其相关。事实上，当我们把新特性应用到 Flutter 框架时，总共减少了[近两千行代码](https://github.com/flutter/flutter/pull/100905/files)！

<DashImage src="images/0ypTj-6zzDBoqnpRL.webp" alt="A code comparison demonstrating the new super constructor parameter syntax in Dart 2.17." />


### Named args everywhere

### 命名实参无处不在

Lastly, we’ve refined how named arguments work when you invoke a method. Previously, these had to appear last in the list of arguments to the method. This was annoying in cases where you’d prefer to place a positional argument last to make the code more readable. For example, see the following invocation of the `List&lt;T&gt;.generate` constructor — before, the growable argument had to be placed last, making it easy to miss below the large positional argument containing the generator itself. Now you can order them as you prefer, allowing you to place the small named arguments first and the generator last.

最后，我们细化了调用方法时命名实参的工作方式。以前，它们必须出现在方法实参列表的最后。当你想把位置实参放在最后让代码更易读时，这就很烦人。例如下面对 `List&lt;T&gt;.generate` 构造函数的调用——以前 growable 实参必须放最后，很容易被淹没在包含生成器本身的大块位置实参下面。现在你可以随意排序，把小的命名实参放前面、生成器放最后。

<DashImage src="images/0gMf1J56vEgV96z1l.webp" alt="A code snippet showing named arguments placed anywhere in the argument list in Dart 2.17." />


For further examples of these three features in actions, see our updated samples for [enums](https://github.com/dart-lang/samples/blob/master/enhanced_enums/lib/members.dart), [super initializers](https://github.com/dart-lang/samples/blob/master/parameters/lib/super_initalizer.dart), and [named parameters](https://github.com/dart-lang/samples/blob/master/parameters/lib/named_parameters.dart).

这三个特性的更多实战示例，见我们更新的[枚举](https://github.com/dart-lang/samples/blob/master/enhanced_enums/lib/members.dart)、[超类初始化器](https://github.com/dart-lang/samples/blob/master/parameters/lib/super_initalizer.dart)和[命名参数](https://github.com/dart-lang/samples/blob/master/parameters/lib/named_parameters.dart)示例。

## Productivity tools

## 生产力工具

Continuing the productivity theme, we have several improvements in our core tools.

延续生产力主题，我们的核心工具也有多处改进。

In Dart 2.14 we introduced `package:lints`, which works with the Dart analyzer to help you write Dart code that prevents errors and uses a canonical style enabling more effective code reviews. Since then a number of new lints have been made available in the analyzer, which we’ve carefully triaged and from that selected [ten new lints](https://github.com/dart-lang/lints/blob/main/CHANGELOG.md#200) for all Dart code, and [two new lints](https://github.com/flutter/packages/blob/master/packages/flutter_lints/CHANGELOG.md#200) specifically for Flutter code. These include lints for ensuring your imports are included in your pubspec file, preventing the misuse of null checks on type parameters, and ensuring a consistent style for child properties. You can upgrade to the new lints with a simple command:

我们在 Dart 2.14 中引入了 `package:lints`，它与 Dart 分析器配合，帮助你写出预防错误、采用规范风格从而让代码评审更有效的 Dart 代码。此后分析器新增了不少 lint，我们仔细筛选后为所有 Dart 代码选出了[十个新 lint](https://github.com/dart-lang/lints/blob/main/CHANGELOG.md#200)，为 Flutter 代码专门选出了[两个新 lint](https://github.com/flutter/packages/blob/master/packages/flutter_lints/CHANGELOG.md#200)。其中包括确保 import 的 package 已列入 pubspec 文件、防止对类型参数误用空检查，以及确保 child 属性风格一致的 lint。用一条简单命令即可升级到新 lint：

* For Dart packages:
`dart pub upgrade —-major-versions lints`

  对于 Dart package：`dart pub upgrade —-major-versions lints`

* For Flutter packages: 
`flutter pub upgrade —-major-versions flutter_lints`

  对于 Flutter package：`flutter pub upgrade —-major-versions flutter_lints`

SecureSockets are commonly used to enable TCP sockets secured with TLS and SSL. Before Dart 2.17, debugging these sockets during development was tricky, as there was no way to inspect the secure data traffic. We’ve now added support for specifying a `keyLog` file. When specified, a line of text in the [NSS Key Log Format](https://developer.mozilla.org/en-US/docs/Mozilla/Projects/NSS/Key_Log_Format) is appended to the file when new TLS keys are exchanged with the server. This enables network traffic analyzer tools (such as [Wireshark](https://gitlab.com/wireshark/wireshark/-/wikis/TLS#tls-decryption)) to decrypt the content sent through the socket. For details, see the API docs for [`SecureSocket.connect()`](https://api.dart.dev/stable/2.17.0/dart-io/SecureSocket/connect.html).

SecureSocket 常用于启用受 TLS 和 SSL 保护的 TCP 套接字。在 Dart 2.17 之前，开发期间调试这些套接字很棘手，因为没有办法检查加密的数据流量。我们现在添加了指定 `keyLog` 文件的支持。指定后，每当与服务器交换新的 TLS 密钥时，就会向该文件追加一行 [NSS Key Log 格式](https://developer.mozilla.org/en-US/docs/Mozilla/Projects/NSS/Key_Log_Format)的文本。这让网络流量分析工具（如 [Wireshark](https://gitlab.com/wireshark/wireshark/-/wikis/TLS#tls-decryption)）能解密通过套接字发送的内容。详情见 [`SecureSocket.connect()`](https://api.dart.dev/stable/2.17.0/dart-io/SecureSocket/connect.html) 的 API 文档。

API documentation generated by the `dart doc` tool is a critical asset to most Dart developers learning new APIs. While our [core library APIs](https://dart.dev/guides/libraries) have long had rich textual descriptions, many developers have told us they prefer to learn APIs by reading sample code that uses the API. With Dart 2.17, we’ve completely overhauled all major core libraries, adding sample code to the top 200 most viewed pages, so they now have comprehensive sample code. As an example, compare the documentation for dart:convert in [Dart 2.16](https://api.dart.dev/stable/2.16.2/dart-convert/dart-convert-library.html) with the updated page for [Dart 2.17](https://api.dart.dev/stable/2.17.0/dart-convert/dart-convert-library.html); hopefully this makes the documentation much easier to consume.

`dart doc` 工具生成的 API 文档是大多数 Dart 开发者学习新 API 的关键资源。虽然我们的[核心库 API](https://dart.dev/guides/libraries) 一直有丰富的文字描述，但许多开发者告诉我们，他们更喜欢通过阅读使用 API 的示例代码来学习。在 Dart 2.17 中，我们全面翻新了所有主要核心库，为浏览量最高的 200 个页面添加了示例代码，使它们现在拥有全面的示例。例如，可以对比 dart:convert 在 [Dart 2.16](https://api.dart.dev/stable/2.16.2/dart-convert/dart-convert-library.html) 的文档和 [Dart 2.17](https://api.dart.dev/stable/2.17.0/dart-convert/dart-convert-library.html) 的更新页面；希望这让文档更容易消化。

Productivity gains come not only when we add new features to our platform, but also when we clean up our stack and remove features that are no longer used. This helps keep our surface area small, which is critical especially to new developers. Towards this, we’ve removed [231 lines of deprecated code](https://dart-review.googlesource.com/c/sdk/+/236840) from the `dart:io` library — if you are still using these deprecated APIs, you can upgrade to their replacements with [`dart fix`](https://dart.dev/tools/dart-fix). We’ve also continued our effort to remove [deprecated Dart CLI tools](https://github.com/dart-lang/sdk/issues/46100), this time removing the `dartdoc` tool (use `dart doc` instead), and `pub` tool (use `dart pub` or `flutter pub`).

生产力的提升不仅来自为平台添加新特性，也来自清理技术栈、移除不再使用的特性。这有助于保持较小的 API 表面，对新开发者尤其重要。为此，我们从 `dart:io` 库中移除了 [231 行已弃用的代码](https://dart-review.googlesource.com/c/sdk/+/236840)——如果你还在使用这些已弃用的 API，可以用 [`dart fix`](https://dart.dev/tools/dart-fix) 升级到替代接口。我们还继续推进移除[已弃用的 Dart CLI 工具](https://github.com/dart-lang/sdk/issues/46100)，这次移除了 `dartdoc` 工具（改用 `dart doc`）和 `pub` 工具（改用 `dart pub` 或 `flutter pub`）。

## Broadening our platform integration and support

## 拓宽平台集成与支持

A second core theme is platform integration and support. Dart is a true multi-platform language. While we already support a [wide range of platforms](https://dart.dev/overview#platform), we’re constantly evolving to ensure that you can deeply integrate with each supported platform, and also to support emerging platforms.

第二个核心主题是平台集成与支持。Dart 是真正的多平台语言。虽然我们已经支持[广泛的平台](https://dart.dev/overview#platform)，但仍在不断演进，确保你能与每个受支持的平台深度集成，并支持新兴平台。

Dart FFI — our core mechanism for [interop with C/native code](https://dart.dev/guides/libraries/c-interop) — is a popular way of integrating Dart code with existing native platform code. On Flutter, this can be a great way to build [plugins](https://docs.flutter.dev/development/packages-and-plugins/developing-packages) that use native APIs from the host platform (such as Windows win32 APIs). In Dart 2.17 and Flutter 3, we’ve added templates to the `flutter` tool so you can now easily create FFI Plugins that have a Dart API backed by `dart:ffi` calls into native code. For details, see the updated [developing packages and plugins](https://docs.flutter.dev/development/packages-and-plugins/developing-packages#dart-only-platform-implementations) page on flutter.dev.

Dart FFI——我们[与 C/原生代码互操作](https://dart.dev/guides/libraries/c-interop)的核心机制——是把 Dart 代码与现有原生平台代码集成的流行方式。在 Flutter 上，这是构建使用宿主平台原生 API（如 Windows win32 API）的[插件](https://docs.flutter.dev/development/packages-and-plugins/developing-packages)的好方法。在 Dart 2.17 和 Flutter 3 中，我们为 `flutter` 工具添加了模板，你现在可以轻松创建 FFI 插件：Dart API 底层由调用原生代码的 `dart:ffi` 支撑。详情见 flutter.dev 上更新的[开发 package 和插件](https://docs.flutter.dev/development/packages-and-plugins/developing-packages#dart-only-platform-implementations)页面。

To enable use of FFI on platforms that have types specific to their ABI ([application binary interface](https://en.wikipedia.org/wiki/Application_binary_interface)), FFI now supports ABI-specific types. For example, you can now use [`Long`](https://api.dart.dev/stable/2.17.0/dart-ffi/Long-class.html) (`long` in C) to correctly represent a long integer with an ABI-specific size, which might be 32-bit or 64-bit depending on the CPU architecture. For the full list of supported types, see the list of “Implementers’’ in the [`AbiSpecificInteger`](https://api.dart.dev/stable/2.17.0/dart-ffi/AbiSpecificInteger-class.html) API page.

为了在拥有 ABI（[应用二进制接口](https://en.wikipedia.org/wiki/Application_binary_interface)）特定类型的平台上使用 FFI，FFI 现在支持 ABI 特定类型。例如，你现在可以用 [`Long`](https://api.dart.dev/stable/2.17.0/dart-ffi/Long-class.html)（C 中的 `long`）正确表示大小依 ABI 而定的长整数，根据 CPU 架构可能是 32 位或 64 位。完整的受支持类型列表见 [`AbiSpecificInteger`](https://api.dart.dev/stable/2.17.0/dart-ffi/AbiSpecificInteger-class.html) API 页面的 “Implementers” 列表。

When deeply integrating with native platforms using Dart FFI, you sometimes need to align the cleanup of memory or other resources (ports, files, and so on) allocated by Dart and the native code. This has historically been very tricky, as Dart is a garbage collected language that automatically handles cleanup. Dart 2.17 solves this by introducing the concept of a Finalizer, which includes a `Finalizable` marker interface for “tagging” objects that shouldn’t be finalized or discarded too early, and a `NativeFinalizer` class that can be attached to a Dart object to provide a call-back run when the object is about to be garbage collected. Together these allow for running cleanup code in both native and Dart code. For details, see the description and example in the API documentation for [`NativeFinalizer`](https://api.dart.dev/stable/2.17.0/dart-ffi/NativeFinalizer-class.html), or the documentation for [`WeakReferences`](https://api.dart.dev/stable/2.17.0/dart-core/WeakReference-class.html) and [`Finalizer`](https://api.dart.dev/stable/2.17.0/dart-core/Finalizer-class.html) for similar support in regular Dart code.

用 Dart FFI 与原生平台深度集成时，有时需要对齐 Dart 和原生代码分配的内存或其他资源（端口、文件等）的清理。这历来非常棘手，因为 Dart 是自动处理清理的垃圾回收语言。Dart 2.17 通过引入 Finalizer 概念解决了这个问题：包括用于“标记”不应过早终结或丢弃的对象的 `Finalizable` 标记接口，以及可附加到 Dart 对象上、在对象即将被垃圾回收时运行回调的 `NativeFinalizer` 类。两者结合，让原生和 Dart 代码都能运行清理代码。详情见 [`NativeFinalizer`](https://api.dart.dev/stable/2.17.0/dart-ffi/NativeFinalizer-class.html) API 文档中的描述和示例；常规 Dart 代码的类似支持见 [`WeakReferences`](https://api.dart.dev/stable/2.17.0/dart-core/WeakReference-class.html) 和 [`Finalizer`](https://api.dart.dev/stable/2.17.0/dart-core/Finalizer-class.html) 的文档。

Our support for compiling Dart to native code is a core enabler of making Flutter apps have great startup performance and fast rendering. A second use case is the ability to compile Dart to executables with [`dart compile`](https://dart.dev/tools/dart-compile). These executables can run standalone on any machine without needing the Dart SDK to be installed. Another new capability in Dart 2.17 is support for [signing of executables](https://dart.dev/tools/dart-compile#exe), which enables deployment on Windows and macOS where signing is often required.

我们对把 Dart 编译为原生代码的支持，是 Flutter 应用获得出色启动性能和快速渲染的核心保障。第二个用例是用 [`dart compile`](https://dart.dev/tools/dart-compile) 把 Dart 编译为可执行文件。这些可执行文件可以在任何机器上独立运行，无需安装 Dart SDK。Dart 2.17 的另一项新能力是支持[可执行文件签名](https://dart.dev/tools/dart-compile#exe)，让应用能部署到通常要求签名的 Windows 和 macOS。

We’re also continuing to broaden our set of supported platforms by staying at the forefront of new emerging platforms. [RISC-V](https://riscv.org/about/) is a new innovative instruction set for processors. RISC-V International, a global non-profit organization, owns the RISC-V specification, making the instruction set free and open. This is still an emerging platform, but we’re excited about its potential, so our `2.17.0–266.1.beta` Linux release (or later from our [beta channel)](https://dart.dev/get-dart/archive#beta-channel) includes experimental support for it. We’d love to hear your feedback, so please [file an issue](https://github.com/dart-lang/sdk/issues) or [post](https://groups.google.com/a/dartlang.org/g/misc) about your experience!

我们还在持续拓宽受支持平台的范围，紧跟新兴平台的前沿。[RISC-V](https://riscv.org/about/) 是一种创新的处理器指令集。全球非营利组织 RISC-V International 拥有 RISC-V 规范，使该指令集自由开放。这仍是一个新兴平台，但我们对其潜力感到兴奋，因此我们的 `2.17.0–266.1.beta` Linux 版本（或 [beta 渠道](https://dart.dev/get-dart/archive#beta-channel)的更新版本）包含了实验性支持。我们很想听到你的反馈，请[提交 issue](https://github.com/dart-lang/sdk/issues) 或[发帖](https://groups.google.com/a/dartlang.org/g/misc)分享你的体验！

## Get started with Dart 2.17!

## 开始使用 Dart 2.17！

We hope that today’s Dart 2.17 release excites you, improves your productivity, and enables even more platform integration for your apps. To get started, you can directly download the Dart[ 2.17](https://dart.dev/get-dart) release, or get it embedded as part of today’s [Flutter 3](https://docs.flutter.dev/get-started/install) SDK release.

希望今天发布的 Dart 2.17 让你兴奋、提升你的生产力，并为你的应用带来更多平台集成。开始使用时，可以直接下载 Dart [2.17](https://dart.dev/get-dart) 版本，或获取今天发布的 [Flutter 3](https://docs.flutter.dev/get-started/install) SDK 中内嵌的它。

We also invite you to check out [the new content](https://io.google/2022/products/flutter/) we’ve made available for Google I/O!

也欢迎你查看我们为 Google I/O 准备的[新内容](https://io.google/2022/products/flutter/)！