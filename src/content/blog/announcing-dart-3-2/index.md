---
# title: "Announcing Dart 3.2"
title: "宣布 Dart 3.2"
# description: "Improved language & developer experience, and an update on web apps & Wasm"
description: "改进的语言与开发者体验，以及 Web 应用与 Wasm 的进展"
ai-translated: true
publishDate: 2023-11-15
author: mit-mit
image: images/1u5YRn1uMmXf94b2aPbcLRQ.webp
category: releases
layout: blog
---


By: [Kevin Moore](https://twitter.com/kevmoo) & [Michael Thomsen](https://medium.com/@mit.mit)

作者：[Kevin Moore](https://twitter.com/kevmoo) 和 [Michael Thomsen](https://medium.com/@mit.mit)

Today we’re announcing Dart 3.2, featuring a new language feature for non-null promotion of private final fields, improved developer experience with new interop capabilities, support for extensions in DevTools, and an update on our web roadmap including support for Wasm (aka WebAssembly).

今天我们宣布 Dart 3.2，带来私有 final 字段非空提升的新语言特性、新互操作能力带来的开发者体验改进、DevTools 扩展支持，以及包括 Wasm（即 WebAssembly）支持在内的 Web 路线图进展。

<DashImage src="images/1u5YRn1uMmXf94b2aPbcLRQ.webp" alt="Dart 3.2 release banner highlighting language updates, developer experience, and the web roadmap." />


## Non-null promotion for private final fields

## 私有 final 字段的非空提升

It’s been a few years since we introduced [sound null safety](/blog/announcing-dart-2-12) in Dart 2.12. With null safety, you can declare which types are nullable (may contain a value, or `null`) and which are non-nullable (always contain a value). Null safety combined with [flow analysis](https://dart.dev/null-safety/understanding-null-safety#flow-analysis) detects when nullable variables can be “promoted” to their safer, non-null types:

距离我们在 Dart 2.12 中引入[健全空安全](/blog/announcing-dart-2-12)已经几年了。有了空安全，你可以声明哪些类型可空（可能包含值或 `null`）、哪些不可空（总是包含值）。空安全结合[流分析](https://dart.dev/null-safety/understanding-null-safety#flow-analysis)能检测可空变量何时可以“提升”为更安全的非空类型：

```dart
int definitelyInt(int? aNullableInt) {
  if (aNullableInt == null) {
    return 0;
  }
  // If flow analysis reaches this point, 
  // aNullableInt can safely promote to a non-null int.
  return aNullableInt; 
}
```


Type promotion has been a core part of null safety since Dart 2.12, but was limited to local variables. Fields or top-level variables couldn’t be promoted, such as in a case like this:

自 Dart 2.12 起，类型提升一直是空安全的核心部分，但仅限于局部变量。字段或顶层变量无法提升，例如下面这种情况：

```dart
class Container {
  final int? _fillLevel;
  Container(this._fillLevel);
  check() {
    if (_fillLevel != null) {
      int i = _fillLevel; // Prior to Dart 3.2, causes an error.
    }
  }
}
```


This limitation was due to several complex cases where flow analysis could not safely determine when or how a field might change. In the case of field promotion on a class, for example, it could be an issue if a subclass overrides a field with a getter, which sometimes returns null.

这个限制源于几种复杂情况：流分析无法安全地确定字段何时、如何变化。例如对类的字段提升，如果子类用有时返回 null 的 getter 重写了字段，就会出问题。

In Dart 3.2, we’ve improved our flow analysis engine and are now able to type promote **private final fields**. Now, the code snippet above passes without errors. This leverages the understanding that for a private & final field, the value never changes after the initial assignment, so checking it just once is considered safe. Private final field promotion is available starting with Dart 3.2, and will be applied to projects that have a Dart SDK [lower bound](https://dart.dev/language/versioning) of 3.2 or higher.

在 Dart 3.2 中，我们改进了流分析引擎，现在能够对**私有 final 字段**做类型提升。上面的代码片段现在可以无错误通过。这利用了这样一个事实：对于私有且 final 的字段，初始赋值后值永不改变，因此只检查一次就被认为是安全的。私有 final 字段提升从 Dart 3.2 开始可用，并应用于 Dart SDK [下限](https://dart.dev/language/versioning)为 3.2 或更高的项目。

## New code analysis options in package:lints 3.0

## package:lints 3.0 的新代码分析选项

Speaking of code analysis, we’ve also made a number of improvements to our standard code analysis rules in [package:lints](https://pub.dev/packages/lints). This package contains the default & recommended set of static analysis rules that comes with any new project created by `dart create` or `flutter create` (via [package:flutter_lints](https://pub.dev/packages/flutter_lints) — an extension of package:lints).

说到代码分析，我们还对 [package:lints](https://pub.dev/packages/lints) 中的标准代码分析规则做了多处改进。这个 package 包含 `dart create` 或 `flutter create` 创建的每个新项目自带的默认和推荐静态分析规则集（通过 [package:flutter_lints](https://pub.dev/packages/flutter_lints)——package:lints 的扩展）。

A new major version of this lint set, version 3.0, is now available. This revision added six lints to the core set and two lints to the recommended set. It features lints for validating pubspec URLs, validating that collection methods are invoked with the correct arguments, and more. For the full list of changes, check out the [changelog](https://github.com/dart-lang/lints/blob/main/CHANGELOG.md#300). Version 3.0 will be the default for new projects in the coming release. For existing projects, you can [upgrade now](https://github.com/dart-lang/lints#upgrading-to-the-latest-lints).

这套 lint 的新主版本 3.0 现已可用。这个修订为核心集添加了六个 lint，为推荐集添加了两个 lint，包括验证 pubspec URL、验证集合方法调用实参正确等 lint。完整变更列表见[更新日志](https://github.com/dart-lang/lints/blob/main/CHANGELOG.md#300)。3.0 版本将在下个版本中成为新项目的默认。现有项目可以[立即升级](https://github.com/dart-lang/lints#upgrading-to-the-latest-lints)。

## Dart interoperability update

## Dart 互操作进展

Multi-platform support across a [wide range of platforms](https://dart.dev/overview#platform) has always been a core principle of Dart. But even though a line of Dart code can run unchanged across all those platforms, large apps still often have a need to interop with existing code. That could mean code from older projects, or APIs available in other libraries or system APIs. We’ve made a number of investments in this area, starting with FFI for [interop with native C APIs](https://dart.dev/guides/libraries/c-interop). We’re currently working on expanding this to support interop with [Java and Kotlin](https://dart.dev/guides/libraries/java-interop) and [Objective C and Swift](https://dart.dev/guides/libraries/objective-c-interop). For exciting updates on JS interop, check out the Dart web section further down.

跨[广泛平台](https://dart.dev/overview#platform)的多平台支持一直是 Dart 的核心原则。但即使一行 Dart 代码能在所有这些平台上原样运行，大型应用仍然经常需要与现有代码互操作。这可能是旧项目的代码，或其他库或系统 API 中的接口。我们在这个领域做了多项投入，从[与原生 C API 互操作](https://dart.dev/guides/libraries/c-interop)的 FFI 开始。我们目前正在扩展支持[与 Java 和 Kotlin](https://dart.dev/guides/libraries/java-interop) 以及 [Objective C 和 Swift](https://dart.dev/guides/libraries/objective-c-interop) 的互操作。JS 互操作的激动人心的进展见下文的 Dart Web 部分。

As of Dart 3.2, we’ve made a number of improvements to native interop:

在 Dart 3.2 中，我们对原生互操作做了多处改进：

* We’ve introduced the [`NativeCallable.isolateLocal`](https://api.dart.dev/stable/dart-ffi/NativeCallable/NativeCallable.isolateLocal.html) constructor for C FFI, which creates a C function pointer from an arbitrary Dart function. This is an extension of functionality provided by [`Pointer.fromFunction`](https://api.dart.dev/stable/dart-ffi/Pointer/fromFunction.html), which can only create function pointers from top-level functions.

  我们为 C FFI 引入了 [`NativeCallable.isolateLocal`](https://api.dart.dev/stable/dart-ffi/NativeCallable/NativeCallable.isolateLocal.html) 构造函数，可以从任意 Dart 函数创建 C 函数指针。这是对 [`Pointer.fromFunction`](https://api.dart.dev/stable/dart-ffi/Pointer/fromFunction.html) 功能的扩展，后者只能从顶层函数创建函数指针。

* We’ve updated the Objective-C bindings generator to make use of [`NativeCallable.listener`](https://api.dart.dev/stable/dart-ffi/NativeCallable/NativeCallable.listener.html), which we added in Dart 3.1. The generator can now automatically handle APIs which contain asynchronous callbacks, like [Core Motion](https://developer.apple.com/documentation/coremotion), for example. Such APIs previously required writing some of the bindings code by hand.

  我们更新了 Objective-C 绑定生成器，使用 Dart 3.1 中添加的 [`NativeCallable.listener`](https://api.dart.dev/stable/dart-ffi/NativeCallable/NativeCallable.listener.html)。生成器现在可以自动处理包含异步回调的 API，例如 [Core Motion](https://developer.apple.com/documentation/coremotion)。这类 API 以前需要手写部分绑定代码。

* We’ve continued to improve [package:jnigen](https://dart.dev/guides/libraries/java-interop) for Java and Kotlin interop. This allowed us to migrate [package:cronet_http](https://pub.dev/packages/cronet_http) — a wrapper around Android’s Cronet HTTP client — away from handwritten bindings code to an automatically [generated](https://github.com/dart-lang/http/blob/master/pkgs/cronet_http/jnigen.yaml) wrapper.

  我们继续改进用于 Java 和 Kotlin 互操作的 [package:jnigen](https://dart.dev/guides/libraries/java-interop)。这让我们把 [package:cronet_http](https://pub.dev/packages/cronet_http)——Android Cronet HTTP 客户端的包装——从手写绑定代码迁移到自动[生成](https://github.com/dart-lang/http/blob/master/pkgs/cronet_http/jnigen.yaml)的包装。

* We’ve made significant progress on the [Native Assets](https://github.com/dart-lang/sdk/issues/50565) feature, which aims to resolve a number of issues associated with the distribution of Dart packages that depend on native code. It does so by providing uniform hooks for integrating with various build systems involved in building Flutter and standalone Dart applications. For a preview, check out the [documentation](http://dart.dev/guides/libraries/c-interop#native-assets).

  我们在 [Native Assets](https://github.com/dart-lang/sdk/issues/50565) 特性上取得了重大进展，它旨在解决依赖原生代码的 Dart package 分发的诸多问题。它为构建 Flutter 和独立 Dart 应用涉及的各种构建系统提供统一的集成钩子。预览请查看[文档](http://dart.dev/guides/libraries/c-interop#native-assets)。

## DevTools extensions for Dart packages

## Dart package 的 DevTools 扩展

Dart [DevTools](https://dart.dev/tools/dart-devtools) is a suite of debugging and performance tools that supports both pure-Dart and Flutter apps. In Dart 3.2 & Flutter 3.16 [we’re announcing](https://medium.com/p/c8bc1aaf8e5f/) a new [extensions framework](https://pub.dev/packages/devtools_extensions) which enables package authors to build custom tooling for their package, surfaced directly in DevTools. This allows pub.dev packages that contain frameworks to offer custom tools specific to their use cases. For example, the authors of [Serverpod](https://pub.dev/packages/serverpod) have been hard at work building developer tools for their package and are excited to be shipping a DevTools extension in their upcoming [1.2 release](https://github.com/orgs/serverpod/projects/4).

Dart [DevTools](https://dart.dev/tools/dart-devtools) 是一套同时支持纯 Dart 和 Flutter 应用的调试与性能工具。在 Dart 3.2 和 Flutter 3.16 中，[我们宣布](https://medium.com/p/c8bc1aaf8e5f/)新的[扩展框架](https://pub.dev/packages/devtools_extensions)，让 package 作者能为自己的 package 构建自定义工具，并直接呈现在 DevTools 中。这让包含框架的 pub.dev package 能提供针对其用例的定制工具。例如，[Serverpod](https://pub.dev/packages/serverpod) 的作者一直在努力为其 package 构建开发者工具，并很高兴将在即将发布的 [1.2 版本](https://github.com/orgs/serverpod/projects/4)中交付 DevTools 扩展。

<DashImage src="images/0N6ZSt1McXO_opQU7.webp" alt="A DevTools extension planned for the upcoming ServerPod 1.2 release." caption="*A DevTools extension planned for the upcoming ServerPod 1.2 release*" />


## Dart web and Wasm update

## Dart Web 与 Wasm 进展

Wasm (also known as [WebAssembly](https://webassembly.org/)) is an exciting new instruction format for web browsers, which provides a portable, platform-neutral, binary code format for execution in modern browsers. High-level managed languages like Dart use garbage collection, which is being added to the Wasm standard. As of Chrome 119, [garbage collection support for Wasm](https://developer.chrome.com/blog/wasmgc/) (known as Wasm-GC) is enabled by default. Wasm-GC support is also coming in Firefox 120, their next stable release. So what’s the status with Dart, Flutter, and Wasm-GC?

Wasm（即 [WebAssembly](https://webassembly.org/)）是令人兴奋的浏览器新指令格式，为现代浏览器提供可移植、平台中立的二进制代码执行格式。Dart 这类高级托管语言使用垃圾回收，而垃圾回收正在被加入 Wasm 标准。从 Chrome 119 起，[Wasm 的垃圾回收支持](https://developer.chrome.com/blog/wasmgc/)（即 Wasm-GC）默认启用。Firefox 的下一个稳定版 120 也将支持 Wasm-GC。那么 Dart、Flutter 和 Wasm-GC 的现状如何？

The Dart-to-Wasm compiler is almost feature complete. The team is very happy with performance and compatibility. Our focus now is on edge cases to make sure our output is fast across a broad range of scenarios.

Dart 到 Wasm 的编译器已接近功能完备。团队对性能和兼容性非常满意。我们现在的重点是边缘情况，确保输出在广泛场景下都足够快。

For Flutter web, we’ve completed a new “Skwasm” rendering engine. To maximize performance, Swasm connects the compiled application code directly to a custom [CanvasKit Wasm module](https://skia.org/docs/user/modules/canvaskit/) with a wasm-to-wasm binding. It’s also the first iteration of multi-threaded rendering support for Flutter web, which further improves frame times.

对于 Flutter Web，我们完成了新的 “Skwasm” 渲染引擎。为了最大化性能，Skwasm 通过 wasm 到 wasm 的绑定，把编译后的应用代码直接连接到定制的 [CanvasKit Wasm 模块](https://skia.org/docs/user/modules/canvaskit/)。这也是 Flutter Web 多线程渲染支持的第一次迭代，进一步改善了帧时间。

There are still a few things left before Flutter web with Wasm is ready to graduate out of its current experimental status:

在带 Wasm 的 Flutter Web 从当前实验状态毕业之前，还有几件事要做：

* **Dual compile**: Generating both Wasm and JavaScript outputs and enabling feature detection at runtime to support browsers with and without Wasm-GC support.

  **双编译**：同时生成 Wasm 和 JavaScript 输出，并在运行时做特性检测，以支持有和没有 Wasm-GC 支持的浏览器。

* **Modern JavaScript-interoperability**: A new JS interop mechanism based on [extension types](https://github.com/dart-lang/language/issues/2727) to enable concise, type-safe calling between Dart code, browser APIs, and JS libraries, when targeting JavaScript and Wasm.

  **现代 JavaScript 互操作**：基于 [extension type](https://github.com/dart-lang/language/issues/2727) 的新 JS 互操作机制，在以 JavaScript 和 Wasm 为目标时，实现 Dart 代码、浏览器 API 和 JS 库之间简洁、类型安全的调用。

* **Browser APIs with Wasm support**: A new package:web, replacing dart:html (and related libraries), based on the modern JS interop mechanism. This will provide easy access to browser APIs with support on both JS and Wasm targets.

  **支持 Wasm 的浏览器 API**：基于现代 JS 互操作机制的新 package:web，取代 dart:html（及相关库）。它将提供对浏览器 API 的便捷访问，同时支持 JS 和 Wasm 目标。

We are starting to migrate a number of internal projects to package:web and the new JS interop mechanism, and expect to have more updates in the next stable release. In the meantime, you can get the latest details at our [Support for WebAssembly](https://flutter.dev/wasm) page.

我们已开始把多个内部项目迁移到 package:web 和新的 JS 互操作机制，预计下个稳定版会有更多进展。与此同时，你可以在[支持 WebAssembly](https://flutter.dev/wasm) 页面获取最新细节。

## Closing

## 结语

That’s all we have for today. Dart 3.2 is available now from [dart.dev](https://dart.dev/get-dart), or as part of today’s [Flutter 3.16]({{site.flutter-blog}}/whats-new-in-flutter-3-16) release. Until next time, have fun with Dart!

今天就到这里。Dart 3.2 现在可从 [dart.dev](https://dart.dev/get-dart) 获取，或作为今天发布的 [Flutter 3.16]({{site.flutter-blog}}/whats-new-in-flutter-3-16) 的一部分。下次再见，祝你玩得开心！
