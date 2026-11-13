---
# title: "New in Dart 3.3: Extension Types, JavaScript Interop, and More"
title: "Dart 3.3 新特性：extension type、JavaScript 互操作等"
# description: "Dart 3.3 has landed, and it’s a game-changer for performance and cross-platform development! Get ready to supercharge your apps with…"
description: "Dart 3.3 来了，性能和跨平台开发的重大变革！准备用……为你的应用提速"
ai-translated: true
publishDate: 2024-02-15
author: kevmoo
image: images/1p4TBp0I66rJTq0LvnSuE7g.webp
category: releases
layout: blog
---


<DashImage src="images/1p4TBp0I66rJTq0LvnSuE7g.webp" alt="Dart 3.3 release banner with the Dart logo and a bullseye icon." />


**Dart 3.3 has landed, and it’s a game-changer for performance and cross-platform development!** Get ready to supercharge your apps with **Extension Types**, revolutionizing performance optimization and how you interact with native code. Plus, our revamped **JavaScript interop** model introduces robust type safety and a developer-friendly way to tap into the power of the web platform. All this paves the way for **WebAssembly** support. Oh, and **Google AI in your Dart apps**? Yes, please! It’s all here in Dart 3.3. Let’s dive in!

**Dart 3.3 来了，这是性能和跨平台开发的重大变革！**准备好用 **extension type** 为你的应用提速，它彻底改变了性能优化和与原生代码交互的方式。此外，全面改进的 **JavaScript 互操作**模型带来了健全的类型安全，以及开发者友好的方式来发挥 Web 平台的力量。这一切都为 **WebAssembly** 支持铺平了道路。哦，还有**在你的 Dart 应用中使用 Google AI**？当然要来！这一切都在 Dart 3.3 中。我们开始吧！

## Introducing Extension Types

## 介绍 extension type

Extension types introduce zero-cost wrappers for types. Use them to optimize performance-sensitive code, especially when interoperating with host platforms. Extension types provide the convenience of custom types with specific members while eliminating the typical wrapper allocation overhead.

extension type 为类型引入零成本包装。用它优化性能敏感的代码，尤其是与宿主平台互操作时。extension type 提供带特定成员的自定义类型的便利，同时消除典型包装类型的分配开销。

```dart
extension type Wrapper(int i) {
  void showValue() {
    print('my value is $i');
  }
}

void main() {
  final wrapper = Wrapper(42);
  wrapper.showValue(); // Prints 'my value is 42'
}
```


The previous example defines **`Wrapper`** as an extension type, but uses it like a trivial Dart type. You can instantiate it and invoke functions. The key difference that Dart compiles it as a normal Dart **`int`**. Extension types allow the convenience of creating a type with unique members without the indirection cost of allocating a typical wrapper type. So, while the [extension members](https://dart.dev/language/extension-methods) feature (available in Dart since 2.7) allows adding functions and properties to an existing type, the extension type feature can do the same, *and also* allows defining a new API that hides the underlying representation.

上面的例子把 **`Wrapper`** 定义为 extension type，但用起来和普通 Dart 类型一样。你可以实例化它并调用函数。关键区别在于 Dart 把它编译为普通的 Dart **`int`**。extension type 让你能方便地创建带独特成员的类型，却没有分配典型包装类型的间接成本。因此，[extension 成员](https://dart.dev/language/extension-methods)特性（Dart 2.7 起可用）允许为现有类型添加函数和属性，而 extension type 特性能做同样的事，*并且*还允许定义隐藏底层表示的新 API。

This is particularly useful for interoperability with host platforms. Native types can be used directly without the cost of creating wrappers and the associated indirection while still providing a clean, production Dart API. Learn more in the [new documentation on extension types](http://dart.dev/language/extension-types).

这对与宿主平台的互操作尤其有用。原生类型可以直接使用，无需创建包装及其间接成本，同时仍提供干净、可用于生产的 Dart API。更多内容见 [extension type 的新文档](http://dart.dev/language/extension-types)。

## Evolving JavaScript Interop

## 演进的 JavaScript 互操作

Dart 3.3 introduces a new model for interoperating with JavaScript libraries and the web. It starts with a new set of APIs for interacting with JavaScript: the [dart:js_interop](https://api.dart.dev/dart-js_interop/dart-js_interop-library.html) library. Now Dart developers have access to a typed API for interacting with JavaScript. This API clearly defines the boundary between the two languages with static enforcement. This eliminates an entire class of issues *before* compile time. In addition to new APIs to access JavaScript code, Dart now includes a new model for representing JavaScript types in Dart using extension types.

Dart 3.3 引入了与 JavaScript 库和 Web 互操作的新模型。它始于一组与 JavaScript 交互的新 API：[dart:js_interop](https://api.dart.dev/dart-js_interop/dart-js_interop-library.html) 库。现在 Dart 开发者可以用带类型的 API 与 JavaScript 交互。这个 API 以静态强制的方式清晰定义了两门语言之间的边界，在编译*之前*就消除了一整类问题。除了访问 JavaScript 代码的新 API，Dart 现在还包含用 extension type 在 Dart 中表示 JavaScript 类型的新模型。

```dart
import 'dart:js_interop';

/// Represents the `console` browser API.
extension type MyConsole(JSObject _) implements JSObject {
  external void log(JSAny? value);
  external void debug(JSAny? value);
  external void info(JSAny? value);
  external void warn(JSAny? value);
}
```


The syntax, based on extension types, allows for more expression and soundness than extension members. This simplifies leveraging JavaScript APIs from Dart. Learn more in the [new documentation on JS interop](https://dart.dev/interop/js-interop).

基于 extension type 的语法比 extension 成员更具表达力和健全性。这简化了在 Dart 中使用 JavaScript API。更多内容见 [JS 互操作的新文档](https://dart.dev/interop/js-interop)。

## Improving browser libraries

## 改进浏览器库

Since version 1.0, the Dart SDK has included a comprehensive set of browser libraries. These include the core [dart:html](https://api.dart.dev/dart-html/dart-html-library.html) library along with libraries for SVG, WebGL, and others.

自 1.0 版本起，Dart SDK 就包含一套全面的浏览器库，包括核心的 [dart:html](https://api.dart.dev/dart-html/dart-html-library.html) 库以及 SVG、WebGL 等库。

The improved JavaScript interop model offered the chance to reimagine these libraries. Going forward, our browser library support will focus on [package:web](https://pub.dev/packages/web). This simplifies versioning, accelerates updates, and aligns with [MDN](https://developer.mozilla.org/) resources.

改进的 JavaScript 互操作模型提供了重新构想这些库的机会。今后，我们的浏览器库支持将聚焦于 [package:web](https://pub.dev/packages/web)。这简化了版本管理、加速了更新，并与 [MDN](https://developer.mozilla.org/) 资源保持一致。

This chain of improvements leads to the next big thing: compiling Dart to [WebAssembly](https://webassembly.org/).

这一系列改进通向下一件大事：把 Dart 编译到 [WebAssembly](https://webassembly.org/)。

## Start today to enable a WebAssembly future

## 今天就开始，迎接 WebAssembly 的未来

With Dart 3.3, package and application authors can lay the groundwork for web applications compiled to [WebAssembly](https://webassembly.org/). While WebAssembly support in Flutter Web remains experimental, the team is working hard to stabilize the implementation. To run Flutter applications on the web using WebAssembly, you need to migrate all code — from the application and all dependencies — to use the new JavaScript Interop mechanism and the [package:web](https://pub.dev/packages/web). The legacy JavaScript and browser libraries remain unchanged and supported for compiling to JavaScript code. However, compiling to WebAssembly requires a migration.

有了 Dart 3.3，package 和应用作者可以为编译到 [WebAssembly](https://webassembly.org/) 的 Web 应用打基础。虽然 Flutter Web 的 WebAssembly 支持仍是实验性的，团队正在努力稳定实现。要用 WebAssembly 在 Web 上运行 Flutter 应用，你需要把所有代码——应用及全部依赖——迁移到新的 JavaScript 互操作机制和 [package:web](https://pub.dev/packages/web)。旧的 JavaScript 和浏览器库保持不变，仍支持编译到 JavaScript 代码。但编译到 WebAssembly 需要迁移。

We’ve created a[ migration guide](https://dart.dev/go/package-web) to help authors start including Wasm. We hope that the most popular packages support Wasm by the time we include it in a stable release.

我们编写了[迁移指南](https://dart.dev/go/package-web)帮助作者开始支持 Wasm。希望在我们把 Wasm 纳入稳定版时，最热门的 package 都已支持它。

## One more thing: Introducing the Google AI Dart SDK

## 还有一件事：介绍 Google AI Dart SDK

Google has released the Google AI Dart SDK to beta. You can build generative AI features into your Dart or Flutter app. These apps use Gemini, Google’s latest family of AI models. Take a look at the [package:google_generative_ai](https://pub.dev/packages/google_generative_ai). Learn how to build with the Google AI Dart SDK in [this blog post]({{site.flutter-blog}}/harness-the-gemini-api-in-your-dart-and-flutter-apps) or jump straight into the [quickstart](https://ai.google.dev/tutorials/dart_quickstart).

Google 已发布 Google AI Dart SDK 的 beta 版。你可以在 Dart 或 Flutter 应用中构建生成式 AI 功能。这些应用使用 Gemini——Google 最新的 AI 模型家族。看看 [package:google_generative_ai](https://pub.dev/packages/google_generative_ai)。在[这篇博客]({{site.flutter-blog}}/harness-the-gemini-api-in-your-dart-and-flutter-apps)中学习如何用 Google AI Dart SDK 构建应用，或直接进入[快速入门](https://ai.google.dev/tutorials/dart_quickstart)。

<DashImage src="images/00DiCLVhk_ipZIHKd.webp" alt="Build with Gemini wordmark on a black background." />
