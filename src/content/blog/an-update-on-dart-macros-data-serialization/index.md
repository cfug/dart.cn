---
# title: "An update on Dart macros & data serialization"
title: "关于 Dart 宏与数据序列化的最新进展"
# description: "We have invested significant time and resources to prototype macros over the past couple years. Unfortunately, each time we solved a major…"
description: "过去几年我们投入了大量时间和资源来打造宏的原型。遗憾的是，每当我们解决一个重大技术障碍……"
ai-translated: true
publishDate: 2025-01-29
author: vijaysmenon
category: other
layout: blog
---


We have invested significant time and resources to prototype [macros](https://dart.dev/language/macros) over the past couple years. Unfortunately, each time we solved a major technical hurdle, we saw new ones pop up. At this point, we are not seeing macros converging anytime soon toward a feature we are comfortable shipping, with the quality and developer-time performance we want.

过去几年，我们投入了大量时间和资源来打造[宏](https://dart.dev/language/macros)的原型。遗憾的是，每当我们解决一个重大技术障碍，就会看到新的障碍冒出来。目前来看，宏短期内无法收敛成一个我们愿意以期望的质量和开发期性能发布的特性。

After considering the opportunity cost — in particular, the features we could be shipping to the community instead — we’ve made the difficult decision to stop our work on macros.

在考虑了机会成本——尤其是我们本可以交付给社区的其他特性——之后，我们做出了一个艰难的决定：停止宏的开发工作。

## Background

## 背景

We believe that Dart offers a unique combination of strengths: (1) the ahead-of-time compilation and performance typical of static languages, and (2) the fast development cycle (e.g., stateful hot reload) typical of dynamic languages. As we’ve evolved Dart, we’ve been careful to evaluate language changes against both of these rubrics.

我们相信 Dart 提供了独特的优势组合：（1）静态语言典型的提前编译和性能；（2）动态语言典型的快速开发周期（例如有状态热重载）。在演进 Dart 的过程中，我们始终谨慎地用这两条标准来评估语言变更。

Powerful metaprogramming — built on rich introspection — has always been a challenge in this context. Runtime introspection (e.g., reflection) makes it difficult to perform the tree-shaking optimizations that allow us to generate smaller binaries. Static introspection (e.g., macros) can take a couple forms. Most languages take a syntactic approach, with limited static reflection on the syntax of programs. We did not believe this was sufficient to achieve our goals. Instead, we aimed to build a macro system which supported deep semantic introspection on the program at compile time. Semantic introspection, unfortunately, turned out to introduce large compile-time costs which made it difficult to keep stateful hot reload *hot*.

在这个背景下，建立在丰富内省能力之上的强大元编程一直是个挑战。运行时内省（例如反射）让 tree-shaking 优化难以进行，而这种优化正是我们生成更小二进制文件的关键。静态内省（例如宏）有几种形式。大多数语言采用语法层面的方法，只对程序语法做有限的静态反射。我们认为这不足以实现我们的目标。相反，我们的目标是构建一个在编译期支持对程序进行深度语义内省的宏系统。遗憾的是，语义内省会带来巨大的编译期开销，使有状态热重载难以保持*“热”*。

We’ve concluded we’re simply too far away from shipping macros with the developer-time performance we require. Our current implementation regresses both editing (e.g., static analysis and code completion) and incremental compilation (the first step of a hot reload). We are not confident we can adequately solve these problems in a reasonable timeframe.

我们的结论是：距离以我们要求的开发期性能发布宏实在太过遥远。当前的实现让编辑体验（例如静态分析和代码补全）和增量编译（热重载的第一步）都出现了倒退。我们没有信心在合理的时间内妥善解决这些问题。

## Moving Forward

## 下一步

We’ve decided to focus on other features we’re more confident about shipping.

我们决定把精力集中在其他更有把握发布的特性上。

One area we’ll be investing in is better support for data in Dart. This is the [most requested issue](https://github.com/dart-lang/language/issues/314) across the Dart & Flutter issue trackers. In fact, our primary motivation for macros was to provide better data handling, serialization, and deserialization. We will still pursue better data, but we intend to do so with more bespoke language features.

我们将投入的一个方向是在 Dart 中更好地支持数据。这是 Dart 和 Flutter issue 跟踪器中[呼声最高的 issue](https://github.com/dart-lang/language/issues/314)。事实上，我们做宏的首要动机就是提供更好的数据处理、序列化和反序列化。我们仍会追求更好的数据支持，但打算用更具针对性的语言特性来实现。

Another area we’ll be investing in is improving build times and the overall code generation experience. We’ve already identified [improvements for build_runner](https://github.com/dart-lang/build/issues/3800). We also plan to ship [augmentations](https://github.com/dart-lang/language/blob/main/working/augmentation-libraries/feature-specification.md), a feature we prototyped as part of macros. We believe this language feature stands on its own and will improve existing code generation. We still aim to [ship this feature](https://github.com/dart-lang/language/issues/4154) independently.

另一个投入方向是改进构建时间和整体代码生成体验。我们已经确定了 [build_runner 的改进项](https://github.com/dart-lang/build/issues/3800)。我们还计划发布[增强（augmentations）](https://github.com/dart-lang/language/blob/main/working/augmentation-libraries/feature-specification.md)，这是我们在宏工作中做过原型的一个特性。我们相信这个语言特性可以独立成立，并能改进现有的代码生成。我们仍计划[独立发布这个特性](https://github.com/dart-lang/language/issues/4154)。

We understand this news will be disappointing to many of you. We remain interested in [exploring general metaprogramming](https://github.com/dart-lang/language/issues/1482) in the long term as it has a number of potential use cases beyond data. Nevertheless, we also want to be clear with our community that we will not be shipping macros in the foreseeable future.

我们理解这个消息会让很多人失望。长远来看，我们仍有兴趣[探索通用元编程](https://github.com/dart-lang/language/issues/1482)，因为除了数据之外它还有许多潜在用例。不过，我们也想向社区明确：在可预见的未来，我们不会发布宏。

We’d like to thank everyone who tried macros, provided feedback, and contributed directly via PRs. That input and energy will feed into the work we do next. We’re excited about the improvements we can offer this year.

我们要感谢所有试用过宏、提供反馈以及直接通过 PR 做出贡献的人。这些投入和热情将注入我们接下来的工作。我们对今年能带来的改进充满期待。