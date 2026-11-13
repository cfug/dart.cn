---
# title: "Announcing Dart 3.4"
title: "宣布 Dart 3.4"
# description: "Dart 3.4 is out today! This release showcases the joint efforts of Dart and Flutter together in the Flutter 3.22 / Dart 3.4 / IO24 post, so…"
description: "Dart 3.4 今天发布！这个版本在 Flutter 3.22 / Dart 3.4 / IO24 联合文章中展示……"
ai-translated: true
publishDate: 2024-05-14
author: mit-mit
image: images/0hAcsCFLU0Ze7pej6.webp
category: releases
layout: blog
---


Dart 3.4 is out today! This release showcases the joint efforts of Dart and Flutter together in the [Flutter 3.22 / Dart 3.4 / IO24]({{site.flutter-blog}}/landing-flutter-3-22-and-dart-3-4-at-google-i-o-2024) post, so make sure to get the full scoop there. This post introduces our support for WebAssembly, and then details one of the major roadmap items for the Dart language this year: *macros.*

Dart 3.4 今天发布！这个版本在 [Flutter 3.22 / Dart 3.4 / IO24]({{site.flutter-blog}}/landing-flutter-3-22-and-dart-3-4-at-google-i-o-2024) 联合文章中展示了 Dart 和 Flutter 的共同努力，务必去那里了解全貌。本文先介绍我们的 WebAssembly 支持，然后详细讲述今年 Dart 语言路线图的一个重大项目：*宏（macros）。*

<DashImage src="images/0hAcsCFLU0Ze7pej6.webp" alt="Dart 3.4 release banner with the Dart logo and a bullseye icon." />


## WebAssembly updates

## WebAssembly 进展

Today, we’re delighted to announce complete support for WebAssembly (Wasm) is available for [Flutter Web apps](https://docs.flutter.dev/platform-integration/web/wasm) with the latest Flutter 3.22 stable release!

今天，我们很高兴地宣布，最新的 Flutter 3.22 稳定版为 [Flutter Web 应用](https://docs.flutter.dev/platform-integration/web/wasm)提供了完整的 WebAssembly（Wasm）支持！

This has been a multi-year investment across Dart & Flutter. If you’ve been following the developments, you’ve seen our incremental developments:

这是 Dart 和 Flutter 多年投入的成果。如果你一直关注进展，你应该看到了我们的渐进式发展：

* Standardizing the [WasmGC](https://developer.chrome.com/blog/wasmgc/) proposal,

  标准化 [WasmGC](https://developer.chrome.com/blog/wasmgc/) 提案，

* Adding a brand new Dart compiler backend to generate WasmGC code, and

  添加全新的 Dart 编译器后端来生成 WasmGC 代码，以及

* [Revamping](https://dart.dev/interop/js-interop) our web and JavaScript interop offerings to best support Wasm.

  [全面改进](https://dart.dev/interop/js-interop)我们的 Web 和 JavaScript 互操作方案以最好地支持 Wasm。

We’ll continue to invest in WebAssembly. Our next effort will enable full support for Wasm in pure Dart apps, and completing a few missing features (e.g. deferred loading). The end-to-end tooling for Wasm compilation in Dart is still under development, but you can [try the preview](http://dart.dev/web/wasm) in stable now with some temporary steps. Later, we also hope to support Wasm in Dart [outside of JS-environments](https://github.com/dart-lang/sdk/issues/53884), such as standard Wasm run-times like wasmtime and wasmer.

我们会继续投入 WebAssembly。下一步是为纯 Dart 应用提供完整的 Wasm 支持，并补齐一些缺失特性（例如延迟加载）。Dart 中 Wasm 编译的端到端工具仍在开发中，但你现在可以通过一些临时步骤在稳定版中[试用预览](http://dart.dev/web/wasm)。之后，我们还希望支持 Dart 在 [JS 环境之外](https://github.com/dart-lang/sdk/issues/53884)使用 Wasm，例如 wasmtime 和 wasmer 等标准 Wasm 运行时。

## Dart macros: Raising the development abstraction level

## Dart 宏：提升开发抽象层级

We’ve invested many years into designing the Dart macros system. To improve the development experience in Dart, macros provide a metaprogramming solution, like code generation. This solution is built into the Dart language to give developers maximum performance, efficiency, and productivity. Now, we’re ready to offer a preview of this experience!

我们为设计 Dart 宏系统投入了多年。为了改善 Dart 的开发体验，宏提供了类似代码生成的元编程方案。这个方案内置于 Dart 语言，为开发者带来最大的性能、效率和生产力。现在，我们准备好提供这种体验的预览了！

A long standing pain point for Dart developers has been the trivial yet tedious pattern of serializing and deserializing JSON data. Crafting a reusable, sufficiently powerful solution is a challenge in Dart, as it doesn’t support runtime reflection for performance reasons. As an alternative, we’ve relied on code generation solutions like [`JsonSerializable`](https://docs.flutter.dev/data-and-backend/serialization/json#serializing-json-using-code-generation-libraries). These depend on external tools that run before the code itself, complicating the developer experience.

Dart 开发者长期以来的一个痛点是序列化与反序列化 JSON 数据这种简单却繁琐的模式。在 Dart 中打造可复用、足够强大的方案是个挑战，因为出于性能考虑 Dart 不支持运行时反射。作为替代，我们依赖 [`JsonSerializable`](https://docs.flutter.dev/data-and-backend/serialization/json#serializing-json-using-code-generation-libraries) 这类代码生成方案。它们依赖在代码运行之前执行的外部工具，让开发体验变得复杂。

Today, we’re announcing a preview of a radical new approach for JSON serialization and deserialization: the [`JsonCodable`](https://dart.dev/go/json-codable) macro.

今天，我们宣布 JSON 序列化和反序列化全新方法的预览：[`JsonCodable`](https://dart.dev/go/json-codable) 宏。

A macro is a type of code that generates *more* code through introspecting *other* code at compile time. For example, here’s a Dart class Vehicle with the new JsonCodable macro applied:

宏是一种在编译期通过内省*其他*代码来生成*更多*代码的代码。例如，下面是应用了新 JsonCodable 宏的 Dart 类 Vehicle：

```dart
@JsonCodable()
class Vehicle {
  final String description;
  final int wheels;
  Vehicle(this.description, this.wheels);
}
void main() {
  final jsonString = Vehicle('bicycle', 2).toJson();
  print('Vehicle serialized: $jsonString');
}
```


So, how does it work? Where did the `toJson()` method (and the companion `fromJson()` constructor) come from? This is an experimental implementation of our new macro system designed to simplify developer experience. When the Dart compiler sees the `@JsonCodable()` annotation, it immediately locates the definition of the JsonCodable macro in real time and starts executing it. This causes the macro to:

那么它是怎么工作的？`toJson()` 方法（以及配套的 `fromJson()` 构造函数）从哪里来？这是我们为简化开发体验而设计的新宏系统的实验性实现。当 Dart 编译器看到 `@JsonCodable()` 注解时，会立即实时定位 JsonCodable 宏的定义并开始执行它。这让宏执行以下步骤：

1. Create a new “[augmentation class](https://github.com/dart-lang/language/blob/main/working/augmentation-libraries/feature-specification.md)”; a new language construct which enables adding new declarations to existing classes.

  创建一个新的“[增强类](https://github.com/dart-lang/language/blob/main/working/augmentation-libraries/feature-specification.md)”；这是一种新的语言构造，允许向现有类添加新声明。

1. Read the developer’s definition of the `Vehicle` class to determine it has two fields, `description` and `wheels`.

  读取开发者定义的 `Vehicle` 类，确定它有两个字段：`description` 和 `wheels`。

1. Add a new `toJson` method signature to the augmentation class.

  向增强类添加新的 `toJson` 方法签名。

1. Fill in the body of the `toJson` method to handle the serialization of the description and wheels fields.

  填充 `toJson` 方法体，处理 description 和 wheels 字段的序列化。

All this happens without delay. The integrated experience supports our existing developer workflows, such as hot reload, as this screencast illustrates:

这一切都毫无延迟地发生。这种集成体验支持我们现有的开发工作流，例如热重载，正如这段录屏所示：

<DashImage src="images/0aOAKYwKdjXURuZN9.webp" alt="Using the JsonCodable macro in Dart to auto-generate code completion for a toJson method." caption="Screencast showing the experience of using a macro: Initially no toJson code completion exists, but after adding [@JsonCodable](http://twitter.com/JsonCodable) to the class, the toJson code completion shows up immediately." />


## Long term macro goals

## 宏的长期目标

The eventual goal is to enable the community to create their own macros. This raises the abstraction level of Dart programming. Take data classes, for example, the [highest voted](https://github.com/dart-lang/language/issues?q=is%3Aissue+is%3Aopen+sort%3Areactions-%2B1-desc) Dart language feature. We looked at adding built-in support for data classes in Dart, but learned that the opinions varied significantly on what such a construct should support to set a standard ourselves. Should the fields be `immutable`? Should it support equals? What about `hashCode`? Maybe `toString` too? We concluded that supporting a macro system would be the better approach. The community can create their own kinds of abstractions, allowing for more scalable experimentation and variety.

最终目标是让社区能创建自己的宏。这提升了 Dart 编程的抽象层级。以数据类为例，这是[得票最高](https://github.com/dart-lang/language/issues?q=is%3Aissue+is%3Aopen+sort%3Areactions-%2B1-desc)的 Dart 语言特性。我们考虑过在 Dart 中内置数据类支持，但发现对于这种构造应该支持什么，大家的意见分歧很大，难以由我们自己定标准。字段应该是 `immutable` 的吗？应该支持 equals 吗？`hashCode` 呢？也许还要 `toString`？我们的结论是支持宏系统是更好的方法。社区可以创建自己的抽象种类，实现更可扩展的实验和多样性。

Designing and implementing such a powerful macro system is a substantial undertaking. We’re determined to do it in a way that doesn’t have a detrimental performance impact on core Dart developer use cases, such as code assistance and completions, code analysis, and hot reload. With that in mind, we’re taking a staged approach:

设计和实现如此强大的宏系统是一项重大工程。我们决心以对核心 Dart 开发用例（如代码辅助与补全、代码分析和热重载）没有不利性能影响的方式来做。为此，我们采取分阶段的方法：

* In today’s release, we’re making a preview of a single macro, `JsonCodable`, available so users can start familiarizing themselves with the developer experience of using a macro.

  在今天的版本中，我们提供单个宏 `JsonCodable` 的预览，让用户开始熟悉使用宏的开发体验。

* If the roll-out of this macro goes well, then we hope to graduate the JSON macro to stable in a later release.

  如果这个宏的推出顺利，我们希望在后续版本中让 JSON 宏进入稳定版。

* Concurrently, we’re working on completing the design and implementation of the underlying macro system. Once we feel confident in its performance and stability, the eventual goal will be to enable the Dart developer community to define their own macros.

  同时，我们正在完成底层宏系统的设计和实现。一旦我们对其性能和稳定性有信心，最终目标就是让 Dart 开发者社区能定义自己的宏。

A lot of work remains to complete these stages. In the meantime, you can read the documentation to learn more about [the Dart macro system](https://dart.dev/go/macros), and try out a preview of [the JsonCodable macro](https://dart.dev/go/json-codable) today.

完成这些阶段还有大量工作。与此同时，你可以阅读文档进一步了解 [Dart 宏系统](https://dart.dev/go/macros)，并在今天试用 [JsonCodable 宏](https://dart.dev/go/json-codable)的预览。

## Other improvements

## 其他改进

As always, this release contains all of the continuous developments that go into providing the best version of Dart possible. In this release, we made the following improvements:

一如既往，这个版本包含为提供最好的 Dart 而持续进行的各项开发。本版本我们做了以下改进：

* Resolved over 50% of analyzer code completion bugs. (Please keep filing [issues](https://github.com/dart-lang/sdk/labels/analyzer-completion-correctness)!)

  解决了超过 50% 的分析器代码补全 bug。（请继续[提 issue](https://github.com/dart-lang/sdk/labels/analyzer-completion-correctness)！）

* Improved the alignment of the type analysis of conditional expressions, if-null expressions, and switch expressions with the language spec ([changelog](https://github.com/dart-lang/sdk/blob/main/CHANGELOG.md#language-1)).

  改进了条件表达式、if-null 表达式和 switch 表达式的类型分析与语言规范的一致性（[更新日志](https://github.com/dart-lang/sdk/blob/main/CHANGELOG.md#language-1)）。

* Removed incomplete and inconsistent tooling from the dart:cli library to pay down technical debt in the Dart VM.

  从 dart:cli 库中移除了不完整、不一致的工具，偿还 Dart VM 的技术债。

* Addressed a handful of inadequacies to improve the new *`*dart:js_interop` library.

  解决了若干不足，改进新的 `dart:js_interop` 库。

Check out the [Changelog](https://github.com/dart-lang/sdk/blob/main/CHANGELOG.md#340) for the full story! Don’t forget to read the joint [Dart and Flutter blog post]({{site.flutter-blog}}/landing-flutter-3-22-and-dart-3-4-at-google-i-o-2024) for this release for the full story of our joint efforts!

完整内容请查看[更新日志](https://github.com/dart-lang/sdk/blob/main/CHANGELOG.md#340)！别忘了阅读本次发布的 [Dart 和 Flutter 联合博客]({{site.flutter-blog}}/landing-flutter-3-22-and-dart-3-4-at-google-i-o-2024)，了解我们共同努力的全貌！
