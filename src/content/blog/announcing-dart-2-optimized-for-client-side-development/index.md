---
# title: "Announcing Dart 2: Optimized for Client-Side Development"
title: "宣布 Dart 2：为客户端开发而优化"
# description: "Today, we’re announcing Dart 2, a reboot of the language to be uniquely optimized for client-side development for web and mobile."
description: "今天，我们宣布 Dart 2——这门语言的一次重启，专为 Web 和移动端的客户端开发而独特优化。"
ai-translated: true
publishDate: 2018-02-22
author: asandholm
image: images/1E9T7YsI_ZU8gk4CewQg_QA.webp
category: releases
layout: blog
---


<DashImage src="images/1E9T7YsI_ZU8gk4CewQg_QA.webp" alt="A plush version of Dash, the blue mascot of Dart and Flutter. She has a long, brown beak and a tag attached that says 'Dart'." />


Today, we’re announcing [Dart 2](http://dartlang.org), a reboot of the language to embrace our vision of Dart: as a language uniquely optimized for client-side development for web and mobile.

今天，我们宣布 [Dart 2](http://dartlang.org)——这门语言的一次重启，
以实现我们对 Dart 的愿景：一门专为 Web 和移动端客户端开发
而独特优化的语言。

With Dart 2, we’ve dramatically strengthened and streamlined the type system, cleaned up the syntax, and rebuilt much of the developer tool chain from the ground up to make mobile and web development more enjoyable and productive. Dart 2 also incorporates lessons learned from early adopters of the language including [Flutter](http://flutter.io), [AdWords](https://news.dartlang.org/2016/03/the-new-adwords-ui-uses-dart-we-asked.html), and [AdSense](https://news.dartlang.org/2016/10/google-adsense-angular-dart.html), as well as thousands of improvements big and small in response to customer feedback.

在 Dart 2 中，我们大幅强化并精简了类型系统，清理了语法，
并从零重建了大部分开发者工具链，让移动和 Web 开发更愉悦、更高效。
Dart 2 还吸收了这门语言早期采用者的经验，包括
[Flutter](http://flutter.io)、
[AdWords](https://news.dartlang.org/2016/03/the-new-adwords-ui-uses-dart-we-asked.html)
和 [AdSense](https://news.dartlang.org/2016/10/google-adsense-angular-dart.html)，
并根据用户反馈做了数以千计、大大小小的改进。

## Dart’s Core Tenets

## Dart 的核心理念

Before we talk more about the advances in Dart 2, it’s worth identifying why we believe Dart is well positioned for the needs of client-side developers.

在深入介绍 Dart 2 的进步之前，值得先说明为什么我们相信
Dart 能很好地满足客户端开发者的需求。

In addition to the attributes necessary for a modern, general purpose language, client-side development benefits from a language that is:

除了现代通用语言必备的特质之外，客户端开发还能从这样的语言中获益：

* **Productive.** Syntax must be clear and concise, tooling simple, and dev cycles near-instant and on-device.

  **高效（Productive）。**语法必须清晰简洁，工具必须简单，
  开发周期近乎即时且直接在设备上进行。

* **Fast.** Runtime performance and startup must be great and predictable even on small mobile devices.

  **快速（Fast）。**即使在小屏移动设备上，
  运行时性能和启动速度也必须出色且可预测。

* **Portable.** Client developers have to think about three platforms today: iOS, Android, and Web. The language needs to work well on all of them.

  **可移植（Portable）。**客户端开发者今天要面对三个平台：
  iOS、Android 和 Web。语言需要在所有平台上都表现良好。

* **Approachable.** The language can’t stray too far from the familiar if it wishes to be relevant for millions of developers.

  **易上手（Approachable）。**语言如果想对数百万开发者保持吸引力，
  就不能偏离大家熟悉的东西太远。

* **Reactive.** A reactive style of programming should be supported by the language.

  **响应式（Reactive）。**语言应当支持响应式编程风格。

Dart has been used to ship many high-quality, mission-critical applications on the web, iOS, and Android at Google and elsewhere and is a great fit for mobile and web development:

在 Google 内外，Dart 已被用于在 Web、iOS 和 Android 上
交付许多高质量、任务关键型的应用，非常适合移动和 Web 开发：

* Dart increases developer velocity because it has a clear, succinct syntax and is able to run on a VM with a JIT compiler. The latter allows for [stateful hot reload](https://flutter.io/hot-reload/) during mobile development, resulting in super fast dev cycles, where you can edit code, compile and replace in the running app on the device.

  Dart 能提升开发速度，因为它语法清晰简练，
  并且能运行在带 JIT 编译器的 VM 上。
  后者让移动开发期间可以进行
  [有状态热重载](https://flutter.io/hot-reload/)，
  带来超快的开发周期：你可以编辑代码、编译，
  并在设备上运行中的应用里即时替换。

* With its ability to efficiently compile to native code ahead of time, Dart provides predictable, high performance and fast startup on mobile devices.

  凭借高效地提前编译为原生代码的能力，
  Dart 在移动设备上提供可预测的高性能和快速启动。

* Dart supports compilation to native code (ARM, x86, etc.) for fast mobile performance as well as transpilation to efficient JavaScript for the web.

  Dart 既支持编译为原生代码（ARM、x86 等）以获得快速的移动端性能，
  也支持转译为高效的 JavaScript 以用于 Web。

* Dart is approachable to many existing developers, thanks to its unsurprising object-oriented aspects and syntax that — according to our users— allows any C++, C#, Objective-C, or Java developer to be productive in a matter of days.

  Dart 对许多现有开发者来说很容易上手，
  这要归功于它不令人意外的面向对象特性和语法——
  据我们的用户反馈，任何 C++、C#、Objective-C 或 Java 开发者
  都能在几天内高效产出。

* Dart works well for reactive programming with its battle-hardened core libraries, including streams and futures; it also has great support for managing short-lived objects through its fast generational garbage collector.

  Dart 很适合响应式编程，拥有久经考验的核心库，
  包括 stream 和 future；它还通过快速的分代垃圾回收器，
  为管理短生命周期对象提供了出色支持。

## Dart 2: Better Client-Side Development

## Dart 2：更好的客户端开发

In Dart 2, we’ve taken further steps to solidify Dart as a great language for client-side development. In particular, we’ve added several new features including strong typing and improving how UI is defined as code.

在 Dart 2 中，我们进一步采取措施，
巩固 Dart 作为客户端开发优秀语言的地位。
特别是，我们加入了几个新特性，包括强类型，
并改进了以代码定义 UI 的方式。

### Strong, Sound Typing

### 强大、可靠的类型系统

The teams behind AdWords and AdSense have built some of Google’s largest and most advanced web apps with Dart to manage the ads that are bringing in a large share of Google’s revenue. From working closely with these teams, we identified a big opportunity to strengthen Dart’s type system. This helps Dart developers catch bugs earlier in the development process, better scale to apps built by large teams, and increase overall code quality.

AdWords 和 AdSense 团队用 Dart 构建了 Google 一些最大、
最先进的 Web 应用，管理着为 Google 带来大部分收入的广告。
在与这些团队的紧密合作中，我们发现了一个强化 Dart 类型系统的重大机会。
这能帮助 Dart 开发者在开发过程更早阶段捕捉 bug，
更好地支撑大团队构建的应用，并提升整体代码质量。

This isn’t unique, of course. In the broader web ecosystem, there’s also a growing trend towards adding type annotations to JavaScript. For example, [TypeScript](https://www.typescriptlang.org/) and [Flow](https://flow.org/) both extend JavaScript with type annotations and inference to improve the ability to analyze code.

当然，这并非孤例。在更广泛的 Web 生态中，
为 JavaScript 添加类型标注的趋势也日益增长。
例如，[TypeScript](https://www.typescriptlang.org/) 和
[Flow](https://flow.org/) 都用类型标注和推断扩展了 JavaScript，
以提升代码分析能力。

In the small example below, Dart 2’s type inference helps uncover a somewhat subtle error and as result, helps improve overall code quality.

在下面的小例子中，Dart 2 的类型推断帮助揭示了一个相当隐蔽的错误，
从而帮助提升整体代码质量。

```dart
void main() {
  List<int> prices = ['99', '27', '10000', '20000000'];
  
  // Sort in place from smallest to largest
  prices.sort();
  
  print('Lowest price is ${prices[0]}!');
}
```

What does this code do? You could reasonably expect that it would print ‘27’. But without Dart 2’s sound type system enabled it prints ‘10000’, because that happens to be the least element in the list of strings when ordered lexicographically. With Dart 2, however, this code will give a type error.

这段代码会做什么？你可能有理由期待它打印 ‘27’。
但在未启用 Dart 2 可靠类型系统的情况下，它打印的是 ‘10000’，
因为按字典序排序时，那恰好是字符串列表中最小的元素。
而有了 Dart 2，这段代码会给出类型错误。

### UI as Code

### 以代码定义 UI

When creating UI, having to switch between a separate UI markup language and the programming language that you’re writing your app in often leads to frustration. We’re striving to make the definition of UI as code a delightful experience to dramatically reduce the need for this context switching. Dart 2 introduces optional `new` and `const`. This much-requested feature is very valuable on its own, and also sets the direction for [other things to come](https://github.com/dart-lang/sdk/issues/27678). For example, with optional `new` and `const` we can clean up the definition of a UI widget so that it doesn’t use a single keyword.

创建 UI 时，不得不在独立的 UI 标记语言和编写应用所用的编程语言
之间来回切换，常常令人沮丧。
我们正努力让以代码定义 UI 成为愉悦的体验，
大幅减少这种上下文切换的需要。
Dart 2 引入了可选的 `new` 和 `const`。
这个呼声很高的特性本身就很有价值，
也为[后续的其他改进](https://github.com/dart-lang/sdk/issues/27678)指明了方向。
例如，有了可选的 `new` 和 `const`，
我们可以清理 UI widget 的定义，让它一个关键字都不用。

```dart
// Before Dart 2
Widget build(BuildContext context) {
  return new Container(
    height: 56.0,
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    decoration: new BoxDecoration(color: Colors.blue[500]),
    child: new Row(
      ...
    ),
  );
}

// After Dart 2
Widget build(BuildContext context) =>
  Container(
    height: 56.0,
    padding: EdgeInsets.symmetric(horizontal: 8.0),
    decoration: BoxDecoration(color: Colors.blue[500]),
    child: Row(
      ...
    ),
  );
```

## Client-Side Uses of Dart

## Dart 在客户端的应用

### Mobile

### 移动端

One of the most significant uses of Dart is for [Flutter](http://flutter.io), Google’s new mobile UI framework to craft high-quality native interfaces for iOS and Android. The [official app](https://developers.googleblog.com/2017/08/hamilton-app-takes-stage.html) for the hugely popular show [Hamilton: The Musical](https://hamiltonmusical.com) is an example of what Flutter is enabling developers to build in record time. Flutter uses a reactive programming style and controls the entire UI pixel by pixel. For Flutter, Dart fits the bill in terms of ease of learning, reactive programming, great developer velocity, and a high-performance runtime system with a fast garbage collector.

Dart 最重要的用途之一是 [Flutter](http://flutter.io)——
Google 新的移动 UI 框架，用于为 iOS 和 Android
打造高质量的原生界面。大热剧目
[Hamilton: The Musical](https://hamiltonmusical.com) 的
[官方应用](https://developers.googleblog.com/2017/08/hamilton-app-takes-stage.html)
就是一个例子，展示了 Flutter 如何让开发者以创纪录的速度构建应用。
Flutter 采用响应式编程风格，逐像素掌控整个 UI。
对 Flutter 而言，Dart 在易学性、响应式编程、出色的开发速度，
以及带快速垃圾回收器的高性能运行时系统方面，都恰到好处。

### Web

### Web

Dart is a proven platform for mission-critical web applications. It has web-specific libraries like `dart:html` along with a full Dart-based [web framework](https://webdev.dartlang.org/). Teams using Dart for web development have been thrilled with the improvements in developer velocity. As Manish Gupta, VP of Engineering for Google AdWords, explains:

Dart 是任务关键型 Web 应用的成熟平台。
它拥有 `dart:html` 等 Web 专用库，
以及一个完全基于 Dart 的 [Web 框架](https://webdev.dartlang.org/)。
使用 Dart 进行 Web 开发的团队对开发速度的提升欣喜不已。
正如 Google AdWords 工程副总裁 Manish Gupta 所说：
> The AdWords front-end is large and complex, and is **critical to the majority of Google’s revenue.**
> We picked Dart because of the great combination of **perf and predictability, ease of learning, a sound type system, and web and mobile support.**
> Our engineers are **two to three times more productive** than before, and we’re delighted we switched.

> AdWords 前端庞大而复杂，**对 Google 的大部分收入至关重要。**
> 我们选择 Dart，是因为它出色地兼具**性能与可预测性、易学性、
> 可靠的类型系统，以及 Web 和移动端支持。**
> 我们的工程师效率是以前的**两到三倍**，我们很高兴做出了这个转变。

## Moving Forward

## 展望未来

With Flutter and Dart, developers finally have the opportunity to write production-quality apps for Android, iOS, and the web with no compromises, using a shared codebase. As a result, team members can fluidly move between platforms and help each other with, e.g., code reviews. So far, we have seen teams like [AdWords Express](https://www.youtube.com/watch?v=PLHln7wHgPE) and [AppTree](https://www.youtube.com/watch?v=GpLb2XvKv20) share between 50% and 70% of their code across mobile and web.

有了 Flutter 和 Dart，开发者终于有机会用共享的代码库，
毫不妥协地为 Android、iOS 和 Web 编写生产级应用。
因此，团队成员可以在平台之间灵活流动，
在代码评审等事务上互相帮助。
到目前为止，我们已经看到
[AdWords Express](https://www.youtube.com/watch?v=PLHln7wHgPE) 和
[AppTree](https://www.youtube.com/watch?v=GpLb2XvKv20) 等团队
在移动端和 Web 之间共享了 50% 到 70% 的代码。

Dart is an [open source project](https://github.com/dart-lang) and an open [ECMA standard](https://www.ecma-international.org/publications/standards/Ecma-408.htm). We welcome contributions to both the [Dart core project](http://github.org/dart-lang/sdk/) and the ever growing ecosystem of [packages for Dart](http://pub.dartlang.org).

Dart 是一个[开源项目](https://github.com/dart-lang)，
也是一项开放的
[ECMA 标准](https://www.ecma-international.org/publications/standards/Ecma-408.htm)。
我们欢迎对 [Dart 核心项目](http://github.org/dart-lang/sdk/)
和不断壮大的 [Dart package](http://pub.dartlang.org) 生态做出贡献。

You can try out Dart 2 in [Flutter](https://github.com/flutter/flutter/wiki/Trying-the-preview-of-Dart-2-in-Flutter) and the [Dart SDK](http://dartlang.org/install) from the command line. For the Dart SDK, get the latest Dart 2 pre-release from the dev channel and make sure to run your code with the `--preview-dart-2` flag. We also invite you to join our community on [gitter](https://gitter.im/dart-lang/home).

你可以在 [Flutter](https://github.com/flutter/flutter/wiki/Trying-the-preview-of-Dart-2-in-Flutter)
和命令行下的 [Dart SDK](http://dartlang.org/install) 中试用 Dart 2。
对于 Dart SDK，请从 dev 渠道获取最新的 Dart 2 预发布版本，
并确保用 `--preview-dart-2` 标志运行你的代码。
我们也邀请你加入我们在 [gitter](https://gitter.im/dart-lang/home)
上的社区。

With the improvements announced today, Dart 2 is a productive, clean, battle-tested language that addresses the challenges of modern app development. It’s already loved by some of the most demanding developers on the planet, and we hope you’ll love it too.

随着今天宣布的这些改进，Dart 2 成为一门高效、简洁、
久经考验的语言，直面现代应用开发的挑战。
它已经赢得了这个星球上一些最苛刻的开发者的喜爱，
我们希望你也会喜欢它。