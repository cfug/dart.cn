---
# title: "The road to Dart 3: A fully sound, null safe language"
title: "Dart 3 之路：一门完全健全的空安全语言"
# description: "Preparing for the next major release, where Dart only supports sound null safety"
description: "为下一个主要版本做准备：届时 Dart 将只支持健全空安全"
ai-translated: true
publishDate: 2022-12-08
author: mit-mit
image: images/05XfWLgEBx4iJvuqA.webp
category: other
layout: blog
---


Over the last four years, we’ve evolved Dart into a fast, portable, and modern language. Our next release, Dart 3, completes the journey to a **fully sound null safe language**. As the last step of that journey, we’re removing several historical Dart language and SDK artifacts, including **removing support for running without sound null safety**. This makes Dart easier to learn, and enables us to evolve the Dart SDK to support new features with greater speed. To learn about the main changes in Dart 3 and how to best prepare your apps and packages, keep reading!

过去四年里，我们把 Dart 演进成了一门快速、可移植的现代语言。
下一个版本 Dart 3 将完成通往**完全健全的空安全语言**的旅程。
作为这段旅程的最后一步，我们将移除若干 Dart 语言和 SDK 中的
历史遗留产物，包括**移除对不带健全空安全运行的支持**。
这让 Dart 更易学习，也让我们能更快地演进 Dart SDK 以支持新特性。
想了解 Dart 3 的主要变化，以及如何为你的应用和 package
做好最佳准备，请继续阅读！

<DashImage src="images/05XfWLgEBx4iJvuqA.webp" alt="A winding road representing the road to Dart 3." caption="The road to Dart 3. *(Photo by [Niklas Ohlrogge](https://unsplash.com/@ohlrogge?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) on [Unsplash](https://unsplash.com/s/photos/road-denmark?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText))*" />


## Why sound null safety?

## 为什么要健全空安全？

Many modern programming languages support null safety (also known as [void safety](https://en.wikipedia.org/wiki/Void_safety)). This avoids null dereferencing issues, which Tony Hoare coined a billion-dollar mistake: *“This has led to innumerable errors, vulnerabilities, and system crashes, which have probably caused a billion dollars of pain and damage in the last forty years”* ([*Hoare 2009*](https://web.archive.org/web/20090119110704/http://qconlondon.com/london-2009/presentation/Null+References%3A+The+Billion+Dollar+Mistake)). To resolve this, languages like Swift, C#, and Kotlin support a type system where you can declare variables to either be *non-null* (can *never* hold a null value), or *nullable* (can hold a value or null). This type system can be combined with static analysis to detect any assignment of null to non-nullable variables. The null safety support in the Dart language uses a similar model, making variables non-nullable by default, and only allowing nulls when explicitly declared.

许多现代编程语言都支持空安全（null safety，也称
[void safety](https://en.wikipedia.org/wiki/Void_safety)）。
这避免了 null 解引用问题——Tony Hoare 称之为“十亿美元的错误”：
*“它导致了无数的错误、漏洞和系统崩溃，在过去四十年里
大概造成了十亿美元的痛苦和损失”*
（[*Hoare 2009*](https://web.archive.org/web/20090119110704/http://qconlondon.com/london-2009/presentation/Null+References%3A+The+Billion+Dollar+Mistake)）。
为解决这一问题，Swift、C#、Kotlin 等语言支持这样一种类型系统：
你可以把变量声明为*非空*（*永远*不能持有 null 值），
或*可空*（可以持有一个值或 null）。
这种类型系统可以结合静态分析，检测任何把 null
赋给非空变量的操作。Dart 语言的空安全支持采用类似模型：
变量默认非空（non-nullable），只有显式声明时才允许 null。

Taking it one step further, **Dart introduces *sound null safety* in an existing language**. A sound system guarantees that a non-nullable variable *never* contains a null value. During the early planning of Dart null safety, [we explored](https://github.com/dart-lang/language/blob/master/accepted/2.12/nnbd/roadmap.md) this topic, and the tradeoffs other languages had taken. The Swift design included soundness from the beginning. TypeScript is inherently unsound, as its underlying type system allows for viewing any object as any static type. As you can see in [this TypeScript example](https://www.typescriptlang.org/play?#code/MYGwhgzhAECyCeAVeAHApgHkQPmgbwChpoA3MEAVzWgC5pEBuI6YAewDsIAXAJwuC6seACgD6ZStTqIAlPi4ALAJYQAdBKrQAvNHHkqDAL4FjBAGYV2ApR2hgAJvYCC7eIqXsA5hgCi2YWA8PGDwdE5BIb7YADTQaCBoALZo7Fx0PnKExMSBwfCqKBQQCsLxSSlcMkymZDykAIx0CMjoGOwUiQBGaHUAPtDtICC4OuxoAO5wSKhowgAsAExVBLWkC9oNTGycrAmqIKyewgAGAMSNDdAq0AAkeCT16vpohrEk69d370+ShscyBAISjM0GEDx+mgAhKMKENMswAPQI6AAETQoEC1AAHnYYOwOABaQbgToJWKdChcaDjajAMDsaDcJRDXEQJSeBnE6CCK5pZjfDTUGFDJjEVY4ujtLo9DbgwUMYjMbYQXZofaHE6nBaSwlcnEqOh3LF-AGmJHQJzQEAqKmsEH49hE2EgaAASVSahWgWgiXgABkbWEIvA2h1ujwRtAANr1WILWKLAC6TAI5qcjjsA2dqgt7HsmYdTulPBzAAUeB4qYpqDw0BBYVxVAQHM5XO4vMJfQHuLFicsWy43MovBgAPKdABW6K4-i7NtiACJEMoYNd8VS0CQUgWwz0F8tlar1UcF6cAMx0a3cK4QGgL2Jz7jLIA), we can assign a null value to a non-null variable. For both ergonomic reasons and to avoid migration of all existing code, C# has several [exceptions](https://devblogs.microsoft.com/dotnet/nullable-reference-types-in-csharp/#avoiding-dereferencing-of-nulls) to their null checks. Kotlin has several unsound [exceptions](https://kotlinlang.org/docs/null-safety.html#nullable-types-and-non-null-types), in part due to its goal to interoperate with Java. As you can see in this Kotlin example, [generic types](https://play.kotlinlang.org/embed?short=yOc5EY5E8&theme=darcula) can trigger cases where null values can flow into a list declared as holding non-null elements.

更进一步，**Dart 在一门既有语言中引入了*健全空安全*（sound null safety）**。
健全的系统保证非空变量*绝不*包含 null 值。
在 Dart 空安全的早期规划中，我们[探讨过](https://github.com/dart-lang/language/blob/master/accepted/2.12/nnbd/roadmap.md)
这一话题以及其他语言所做的取舍。Swift 的设计从一开始就包含健全性。
TypeScript 天生不健全，因为其底层类型系统允许把任何对象
视为任何静态类型。正如你在
[这个 TypeScript 示例](https://www.typescriptlang.org/play?#code/MYGwhgzhAECyCeAVeAHApgHkQPmgbwChpoA3MEAVzWgC5pEBuI6YAewDsIAXAJwuC6seACgD6ZStTqIAlPi4ALAJYQAdBKrQAvNHHkqDAL4FjBAGYV2ApR2hgAJvYCC7eIqXsA5hgCi2YWA8PGDwdE5BIb7YADTQaCBoALZo7Fx0PnKExMSBwfCqKBQQCsLxSSlcMkymZDykAIx0CMjoGOwUiQBGaHUAPtDtICC4OuxoAO5wSKhowgAsAExVBLWkC9oNTGycrAmqIKyewgAGAMSNDdAq0AAkeCT16vpohrEk69d370+ShscyBAISjM0GEDx+mgAhKMKENMswAPQI6AAETQoEC1AAHnYYOwOABaQbgToJWKdChcaDjajAMDsaDcJRDXEQJSeBnE6CCK5pZjfDTUGFDJjEVY4ujtLo9DbgwUMYjMbYQXZofaHE6nBaSwlcnEqOh3LF-AGmJHQJzQEAqKmsEH49hE2EgaAASVSahWgWgiXgABkbWEIvA2h1ujwRtAANr1WILWKLAC6TAI5qcjjsA2dqgt7HsmYdTulPBzAAUeB4qYpqDw0BBYVxVAQHM5XO4vMJfQHuLFicsWy43MovBgAPKdABW6K4-i7NtiACJEMoYNd8VS0CQUgWwz0F8tlar1UcF6cAMx0a3cK4QGgL2Jz7jLIA)
中看到的，我们可以把 null 值赋给非空变量。
出于易用性考虑，也为避免迁移所有现有代码，
C# 的 null 检查存在若干[例外](https://devblogs.microsoft.com/dotnet/nullable-reference-types-in-csharp/#avoiding-dereferencing-of-nulls)。
Kotlin 也有若干不健全的[例外](https://kotlinlang.org/docs/null-safety.html#nullable-types-and-non-null-types)，
部分原因在于它要与 Java 互操作的目标。正如这个 Kotlin 示例所示，
[泛型类型](https://play.kotlinlang.org/embed?short=yOc5EY5E8&theme=darcula)
可能触发这样的情况：null 值流入一个声明为持有非空元素的列表。

For Dart, we chose the path of sound null safety. This involved a tradeoff. In a few cases, this made migrating to null safety a bit more expensive but results in a sound type system with complete trust in the non-null type annotations. We can make implementation [optimizations](/blog/dart-and-the-performance-benefits-of-sound-types) in our compilers and runtimes based on the nullability aspect of the type system. We *know* exactly when a variable isn’t null. We think these were the right set of tradeoffs for Dart.

对 Dart，我们选择了健全空安全这条路。这涉及一种取舍：
在少数情况下，这让迁移到空安全的成本略高，
但换来的是一个可以完全信任非空类型注解的健全类型系统。
我们可以基于类型系统的可空性，在编译器和运行时中
进行实现层面的[优化](/blog/dart-and-the-performance-benefits-of-sound-types)。
我们*确切知道*变量何时不为 null。我们认为这是对 Dart
而言正确的一组取舍。

## In Dart 3, all Dart code will use sound null safety

## 在 Dart 3 中，所有 Dart 代码都将使用健全空安全

*Tracking issue: [SDK #49530](https://github.com/dart-lang/sdk/issues/49530).*

*跟踪 issue：[SDK #49530](https://github.com/dart-lang/sdk/issues/49530)。*

It’s been three years since we introduced null safety to the Dart language in [Dart 2.12](https://dart.dev/guides/language/evolution#dart-212). As mentioned in the previous section, we recognize the impact needed to migrate existing Dart packages and apps. To help migration, Dart has supported running your app code in three ways. It can run without null safety, in a mixed mode with partial null safety, or with full sound null safety. Full sound null safety occurs when 100% of the code, including all dependencies, has been migrated. This gave Dart developers time to migrate existing code one step at a time. However, having support for several modes added overhead and complexity.

自我们在 [Dart 2.12](https://dart.dev/guides/language/evolution#dart-212)
中为 Dart 语言引入空安全以来，已经过去了三年。
如上一节所述，我们清楚迁移现有 Dart package 和应用所需的投入。
为帮助迁移，Dart 支持以三种方式运行你的应用代码：
不带空安全运行、部分空安全的混合模式运行，
或以完全健全的空安全运行。当 100% 的代码（包括所有依赖）
都完成迁移时，就是完全健全的空安全。
这给了 Dart 开发者逐步迁移现有代码的时间。
然而，支持多种模式增加了开销和复杂性。

First, Dart developers need to be aware of all three modes. Whenever you read a piece of Dart code, you must check the [language version](https://dart.dev/language/versioning) to see if types are non-null by default, nullable by default, or some combination thereof.

首先，Dart 开发者需要了解全部三种模式。每当你阅读一段 Dart 代码，
都必须检查[语言版本](https://dart.dev/language/versioning)，
才能知道类型是默认非空、默认可空（nullable），还是两者的某种组合。

Second, supporting all three modes in our compilers and runtimes slows down evolving the Dart SDK. This support increases the cost and complexity of adding new features.

其次，在编译器和运行时中支持全部三种模式，
拖慢了 Dart SDK 的演进。这种支持增加了添加新特性的成本和复杂性。

In Dart 3, sound null safety will be, as [mentioned](/blog/dart-2-18-objective-c-swift-interop) and [announced](https://groups.google.com/a/dartlang.org/g/announce/c/P3UygvbXPgY) earlier, the [only supported mode](https://github.com/dart-lang/sdk/issues/49530). Pubspec files with an SDK constraint having a lower bound of less than 2.12 will **stop resolving** in Dart 3 and later. Any source code containing language markers, will fail when you set the constraint to less than 2.12 (e.g. `// @dart=2.9`).

在 Dart 3 中，正如之前[提到](/blog/dart-2-18-objective-c-swift-interop)
和[宣布](https://groups.google.com/a/dartlang.org/g/announce/c/P3UygvbXPgY)的那样，
健全空安全将成为[唯一受支持的模式](https://github.com/dart-lang/sdk/issues/49530)。
SDK 约束下界低于 2.12 的 pubspec 文件，在 Dart 3 及以后
将**无法再解析**。任何包含语言标记的源代码，
在你把约束设为低于 2.12 时都会失败（例如 `// @dart=2.9`）。

From our telemetry, we believe that around 85% of all executions of flutter run use sound null safety at this time. If you have apps or packages in the remaining 15%, please [migrate](https://dart.dev/null-safety/migration-guide) before Dart 3 ships, which we expect around mid-2023.

根据我们的遥测数据，目前约 85% 的 flutter run 执行
使用了健全空安全。如果你的应用或 package 属于剩下的 15%，
请在 Dart 3 发布前完成[迁移](https://dart.dev/null-safety/migration-guide)，
我们预计发布时间在 2023 年年中左右。

We understand that migrations of large codebases can take some time. We believe you will find the migration worth the effort. BMW recently migrated their main MyBMW app, [a very large app](https://www.press.bmwgroup.com/global/article/detail/T0328610EN/the-my-bmw-app:-new-features-and-tech-insights-for-march-2021?language=en) created by a team of around 300 developers:

我们理解大型代码库的迁移可能需要一些时间。
我们相信你会发现这份努力物有所值。BMW 最近迁移了他们的
主力 MyBMW 应用——一个由约 300 名开发者打造的
[超大型应用](https://www.press.bmwgroup.com/global/article/detail/T0328610EN/the-my-bmw-app:-new-features-and-tech-insights-for-march-2021?language=en)：

*“While the migration to null-safety was certainly not easy for a large-scale codebase like the MyBMW app, Google’s tools gave us great assistance in the migration process. After having the migration completed we enjoy having a less error-prone codebase.”, Christian Schmid, BMW AG*

*“对 MyBMW 应用这样的大规模代码库来说，迁移到空安全当然不容易，
但 Google 的工具在迁移过程中给了我们很大帮助。迁移完成后，
我们拥有了一个更不易出错的代码库，这让我们受益匪浅。”
——Christian Schmid，BMW AG*

To learn more about migration, see the following video, or check out the [migration guide](https://dart.dev/null-safety/migration-guide).

要进一步了解迁移，请观看下面的视频，
或查阅[迁移指南](https://dart.dev/null-safety/migration-guide)。

<YoutubeEmbed id="eBr5tlumwlg" title="How to migrate Dart packages to null safety" fullwidth="true"/>


## Breaking language and API changes

## 语言与 API 的破坏性变更

Alongside the null safety change, we’re making a few other changes to remove historical artifacts in the Dart language and core library APIs. These changes include removing discontinued core library APIs ([#49529](https://github.com/dart-lang/sdk/issues/49529)), removing a historical syntax for default parameter values ([#2357](https://github.com/dart-lang/language/issues/2357)), and requiring tear-offs to be explicit ([#2399](https://github.com/dart-lang/language/issues/2399)).

除了空安全的变化，我们还在做另外几项改动，
以移除 Dart 语言和核心库 API 中的历史遗留产物。
这些改动包括：移除已停止支持的核心库 API
（[#49529](https://github.com/dart-lang/sdk/issues/49529)）、
移除默认参数值的历史语法
（[#2357](https://github.com/dart-lang/language/issues/2357)），
以及要求 tear-off 必须显式书写
（[#2399](https://github.com/dart-lang/language/issues/2399)）。

We believe these changes to have low impact on code migrated to use null safety. When we release the first Dart 3 alpha build, you will be able to quickly test if any of these smaller breaking changes apply to your packages or apps.

我们认为这些改动对已迁移到空安全的代码影响很小。
当我们发布第一个 Dart 3 alpha 构建时，
你就能快速测试这些较小的破坏性变更是否影响你的 package 或应用。

## New Dart 3 features and capabilities

## Dart 3 的新特性与新能力

Dart 3 is also expected to contain a number of new capabilities, including improved interoperability with other programming languages and new language features. We’ll talk much more about this topic at our next major event, [Flutter Forward](https://flutter.dev/events/flutter-forward) on January 25, 2023.

Dart 3 预计还将包含许多新能力，包括与其他编程语言
更好的互操作性以及新的语言特性。我们会在下一场大型活动——
2023 年 1 月 25 日的 [Flutter Forward](https://flutter.dev/events/flutter-forward)
上更多地讨论这一话题。

Let’s take a sneak preview at one language feature, called ***patterns***. Patterns make the Dart language much more expressive, add support for more structured data, and enable a more functional style with algebraic data types.

让我们先睹为快一项名为***模式***（patterns）的语言特性。
模式让 Dart 语言的表达力大大增强，增加了对更多结构化数据的支持，
并借助代数数据类型支持更函数式的风格。

The following code shows an example of using multiple return values on a function, paired with the ability to *destructure* these into individual variables:

下面的代码展示了一个例子：函数使用多个返回值，
并可以把它们*解构*（destructure）为独立的变量：

```dart
// A function which returns a record -- in this case a pair of two doubles:
(double x, double y) getLocation(String name) {
  if (name == 'Aarhus') {
    return (56.1629, 10.2039);
  } else {
    ...
  }
}

// Deconstructing the returned record back into individual variables:
void main(List<String> arguments) {
  final (lat, long) = getLocation('Aarhus');
  print('Current location: $lat, $long');
}

// You can also define a hierarchy of classes, and then pattern match on those:
sealed class Shape {
  double calculateArea();
}

class Square implements Shape {
  final double length;
  Square(this.length);
  double calculateArea() => length * length;
}

class Circle implements Shape {
  final double radius;
  ...
}

double calculateArea(Shape shape) => switch (shape) {
  Square(length: var l) => l * l,
  Circle(radius: var r) => math.pi * r * r
};

```

We’ll share many more details about this new feature early next year. To see a sneak preview, you can check out the [language specification](https://github.com/dart-lang/language/blob/master/accepted/future-releases/0546-patterns/feature-specification.md)

我们将在明年年初分享这一新特性的更多细节。想先睹为快，
可以查看[语言规范](https://github.com/dart-lang/language/blob/master/accepted/future-releases/0546-patterns/feature-specification.md)

## Beyond Dart 3

## Dart 3 之后

We work on a multitude of potential new features in parallel, moving from ideation to experimentation to potential launch. As a consequence, some current work will be completed after Dart 3.

我们并行推进众多潜在的新特性，从构思到实验再到可能的发布。
因此，当前的一些工作将在 Dart 3 之后完成。

First, as we [mentioned last year](/blog/experimenting-with-dart-and-wasm), we’re working on support for compiling Dart code to WebAssembly (**Wasm**). Wasm enables Flutter Web apps to run as full native code in browsers. This is a large undertaking, requires work, beyond updating the Dart compilers. It requires collaborating with the W3C and browser vendors on adding support for garbage collected languages in Wasm via the [WasmGC](https://github.com/WebAssembly/gc/blob/master/proposals/gc/Charter.md) extension.

首先，正如我们[去年提到](/blog/experimenting-with-dart-and-wasm)的，
我们正在支持把 Dart 代码编译为 WebAssembly（**Wasm**）。
Wasm 让 Flutter Web 应用能以完全原生代码的形式在浏览器中运行。
这是一项庞大的工程，需要的工作不止更新 Dart 编译器：
还需要与 W3C 和浏览器厂商合作，通过
[WasmGC](https://github.com/WebAssembly/gc/blob/master/proposals/gc/Charter.md)
扩展在 Wasm 中添加对带垃圾回收语言的支持。

Second, we’re working on **macros**. These enable [static metaprogramming](https://github.com/dart-lang/language/blob/master/working/macros/feature-specification.md). This powerful mechanism allows a piece of code (a macro) to modify and extend the source code of a program during compilation of the program. For example, this can reduce the boilerplate needed to deserialize JSON or to create data classes.

其次，我们正在开发**宏**（macros）。它支持
[静态元编程](https://github.com/dart-lang/language/blob/master/working/macros/feature-specification.md)。
这一强大机制允许一段代码（一个宏）在程序编译期间
修改和扩展程序的源代码。例如，这可以减少反序列化 JSON
或创建数据类所需的样板代码。

You should expect these features, and other exciting ones, after Dart 3.

这些特性以及其他令人兴奋的特性，预计都会在 Dart 3 之后到来。

## The road to Dart 3

## Dart 3 之路

As mentioned in previous sections, if you haven’t migrated to sound null safety, that is the first step. We recommend that you do so now!

如前几节所述，如果你还没有迁移到健全空安全，这就是第一步。
我们建议你现在就行动！

Next, Dart 3 will be rolled out in a series of milestones. Our current expectations revolve around these dates:

接下来，Dart 3 将通过一系列里程碑逐步推出。
我们目前的预期围绕以下日期：

* **Around January/February 2023**: Dart 3 alpha released. It focuses on enabling early Dart 3 compatibility testing. We expect that you’ll be able to run static analysis (`dart analyze` / `flutter analyze`). It’s our goal that any app or package which passes static analysis with Dart 3 alpha should support Dart 3 stable.

  **2023 年 1/2 月左右**：发布 Dart 3 alpha。
  它侧重于支持尽早进行 Dart 3 兼容性测试。
  我们预计你将能运行静态分析（`dart analyze` / `flutter analyze`）。
  我们的目标是：任何通过 Dart 3 alpha 静态分析的应用或 package，
  都应该能支持 Dart 3 稳定版。

* **Around March/April 2023**: Dart 3 beta released. This release previews the new features in Dart 3. You can use this to experiment with the new features and give feedback on issues or suggestions for improvements.

  **2023 年 3/4 月左右**：发布 Dart 3 beta。
  该版本预览 Dart 3 的新特性。你可以用它试验新特性，
  并就问题或改进建议给出反馈。

* **Around mid 2023**: Dart 3 stable released. Sound null safety becomes the only supported mode.

  **2023 年年中左右**：发布 Dart 3 稳定版。
  健全空安全成为唯一受支持的模式。

## Summary

## 总结

The Dart 3 release is scheduled for launch around mid 2023. It will contain several breaking changes, primarily the discontinuation of running without sound null safety. We hope to have a Dart 3 alpha build ready around January or February 2023, which you can use for Dart 3 compatibility testing.

Dart 3 计划于 2023 年年中左右发布。它将包含若干破坏性变更，
主要是停止支持不带健全空安全的运行方式。
我们希望在 2023 年 1 月或 2 月左右准备好 Dart 3 alpha 构建，
供你进行 Dart 3 兼容性测试。

To prepare your apps:

为你的应用做好准备：

* Complete any outstanding [null safety migrations](https://dart.dev/null-safety/migration-guide)

  完成所有尚未完成的[空安全迁移](https://dart.dev/null-safety/migration-guide)

* Verify that your code doesn’t use any deprecated APIs

  确认你的代码没有使用任何已弃用的 API

* Run [`dart fix`](https://dart.dev/tools/dart-fix).

  运行 [`dart fix`](https://dart.dev/tools/dart-fix)。

Dart 3 will also contain several new powerful features, such as patterns. We hope to have a Dart 3 beta release in the spring which demonstrates all the new functionality.

Dart 3 还将包含若干强大的新特性，例如模式。
我们希望在春季发布 Dart 3 beta，展示所有新功能。
