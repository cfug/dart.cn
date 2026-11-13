---
# title: "Introducing Dart 3 alpha"
title: "Dart 3 alpha 登场"
# description: "Preview the most productive, portable, and approachable version of Dart yet. Now available for early testing and experimentation."
description: "预览迄今最有生产力、最可移植、最易上手的 Dart 版本。现已开放早期测试与实验。"
ai-translated: true
publishDate: 2023-01-25
author: mit-mit
image: images/0evGHZJd_7cahb08X.webp
category: announcements
layout: blog
---


In December, we gave a glimpse into the future with our first blog post discussing Dart 3. Today — live from the [Flutter Forward](https://flutter.dev/events/flutter-forward) developer event in Nairobi, Kenya — we’re sharing the broader vision for Dart’s next major release, and our first preview build, **Dart 3 alpha**.

去年 12 月，我们通过第一篇讨论 Dart 3 的博客文章
让大家窥见了未来。今天——在肯尼亚内罗毕的
[Flutter Forward](https://flutter.dev/events/flutter-forward)
开发者活动现场——我们分享 Dart 下一个主版本的更大愿景，
以及首个预览构建：**Dart 3 alpha**。

<DashImage src="images/0evGHZJd_7cahb08X.webp" alt="Dart 3 alpha release banner with the Dart logo." />


Our mission for Dart is to create the best programming language for building high-quality apps across any app platform. Dart is **approachable**, easy to learn, avoids unnecessary complexity, and is internally consistent. Dart is **productive;** app developers are under constant pressure to deliver apps with ever changing requirements, in less time, yet with uncompromised quality and finish. So, we built Dart with a deep focus on enabling fast development, rapid iteration, and high quality. And Dart is **portable**, spanning the widest set of platforms, to enable you to deploy apps to the devices of today and tomorrow.

Dart 的使命是打造在任何应用平台上构建高质量应用的
最佳编程语言。Dart **易上手**：易学、避免不必要的复杂性、
内部一致。Dart **有生产力**：应用开发者时刻面临压力，
要在更短时间内交付需求不断变化的应用，
同时质量与完成度不打折扣。所以我们构建 Dart 时
深度聚焦于快速开发、快速迭代和高质量。
Dart 还**可移植**：覆盖最广泛的平台，
让你能把应用部署到今天和明天的设备上。

We’ve worked on establishing these qualities over many years. With Dart 3, we intend to take another big step, refining and expanding on approachability, productivity, and portability in significant ways.

多年来我们一直在打磨这些品质。借助 Dart 3，
我们打算再迈出一大步，
在易上手、生产力和可移植性上大幅精进和扩展。

Dart 3 is a new *major* release. Partly to signify the large step forward in new functionality, and partly because it’s a *breaking release* in terms of semantic versioning: We’re changing the type system to *only* support **sound null safety** (in Dart 2.12 and later this was *opt-in*), and have made the corresponding breaking changes in Dart’s core libraries. Let’s dive into the details!

Dart 3 是一个新的*主*版本。一方面标志着新功能上的一大步，
另一方面按语义化版本来说它是个*破坏性版本*：
我们把类型系统改为*只*支持**健全空安全**
（在 Dart 2.12 及之后是*可选启用*的），
并在 Dart 核心库中做了相应的破坏性变更。来看细节！

## Dart 3 productivity enhancements

## Dart 3 生产力增强

### A more expressive Dart language: Records, patterns, and access controls

### 更具表现力的 Dart 语言：Records、patterns 与访问控制

We’ve evolved the Dart language at a rapid pace the past few years, [adding 23 new features](https://dart.dev/guides/language/evolution) since 2.0. In Dart 3 we expect to add two new major features, records and patterns, with the goal of making working with structured data more productive.

过去几年 Dart 语言快速演进，自 2.0 以来
[新增了 23 项特性](https://dart.dev/guides/language/evolution)。
在 Dart 3 中我们预计加入两项重要新特性：records 和 patterns，
目标是让处理结构化数据更有生产力。

Records allow you to efficiently and concisely create anonymous composite values from any existing data, without the conceptual overhead of needing to declare a class to hold the values. With records, you can easily build new data structures that combine existing data. For example, to return a pair of values:

Records 让你高效、简洁地从任何既有数据创建匿名复合值，
无需承担声明一个类来容纳这些值的概念开销。
有了 records，你可以轻松构建组合既有数据的新数据结构。
例如，返回一对值：

```dart
(double x, double y) geoLocation(String name) {
  if (name == 'Nairobi') {
    return (-1.2921, 36.8219);
  } else {
    ...
  }
}
```

Where records allow you to combine data, patterns can destructure composite data into its constituents. For example, to destructure the return value of `geoLocation` above (a record consisting of a pair of ints) into two individual `int` variables, `lat` and `long`, you can use a pattern declaration like this:

records 让你组合数据，patterns 则能把复合数据
解构为其组成部分。例如，要把上面 `geoLocation` 的返回值
（由一对 int 组成的 record）解构为两个独立的 `int` 变量
`lat` 和 `long`，可以这样使用 pattern 声明：

```dart
void main(List<String> arguments) {
  final (lat, long) = geoLocation('Nairobi');
  print('Current location: $lat, $long');
}
```

Patterns are fully type safe, and checked during development.

Patterns 完全类型安全，并在开发期间接受检查。

You can also pattern match on the type of values, for example from a hierarchy of classes. A `switch` can use patterns that match on the type, and the individual fields of each type, as in the body of `calculateArea` here:

你还可以对值的类型进行模式匹配，比如来自类层次结构的值。
`switch` 可以使用匹配类型及每种类型各个字段的 pattern，
就像这里 `calculateArea` 的函数体：

```dart
sealed class Shape {
}

class Square implements Shape {
  final double length;
  Square(this.length);
  
}

class Circle implements Shape {
  final double radius;
  Circle(this.radius);
}

double calculateArea(Shape shape) => switch (shape) {
  Square(length: var l) => l * l,
  Circle(radius: var r) => math.pi * r * r
};
```

Overall, we’re adding a large selection of patterns that, when combined, make Dart much more expressive for structured data.

总的来说，我们加入了大量 pattern，
组合起来让 Dart 对结构化数据的表达力强得多。

In conjunction with patterns, we’re also adding [capability controls](https://github.com/dart-lang/language/blob/master/accepted/future-releases/class-modifiers/feature-specification.md) to classes, via several new modifiers:

配合 patterns，我们还通过几个新修饰符为类加入
[能力控制](https://github.com/dart-lang/language/blob/master/accepted/future-releases/class-modifiers/feature-specification.md)：

* **`interface class`**: Cannot be extended.

  **`interface class`**：不能被继承（extend）。

* **`base class`**: Disables the implicit interface, so cannot be implemented.

  **`base class`**：禁用隐式接口，因此不能被实现（implement）。

* **`final class`**: Cannot extend, implement, or mix in the class (outside the current library).

  **`final class`**：（在当前库之外）不能继承、实现
  或混入该类。

* **`sealed class`**: Same as abstract + final + the type is considered the root of a sealed type family for exhaustiveness checking. As an example, take the `Shape` class hierarchy above. In switch statements on the `Shape` type (like the `calculateArea` function), the analyzer will trigger errors if the switch statement does not handle all possible subtypes of the sealed type.

  **`sealed class`**：相当于 abstract + final，
  并且该类型被视为密封类型族的根，用于穷尽性检查。
  以上面的 `Shape` 类层次为例：在对 `Shape` 类型的
  switch 语句中（如 `calculateArea` 函数），
  如果 switch 没有处理密封类型的所有可能子类型，
  分析器就会报错。

* **`mixin class`:** A class which may be used as a mixin.

  **`mixin class`：**可以用作 mixin 的类。

Every new feature adds complexity to the language. To ensure Dart remains approachable, classes default to be fully permissive just like today, with the small exception that classes intended to be used as mixins must now use the `mixin` keyword.

每项新特性都会给语言增加复杂性。为确保 Dart 保持易上手，
类默认和今天一样完全开放，只有一个小例外：
打算用作 mixin 的类现在必须使用 `mixin` 关键字。

### Productive platform integration via direct platform library interop

### 通过直接平台库互操作实现高效的平台集成

We’re working on expanding Dart language interoperability for **calling platform libraries directly from Dart**. On Apple platforms, we’re building on our work on [FFI for C interoperability](https://dart.dev/guides/libraries/c-interop), which supports calling any C module that follows the C calling convention from Dart. This has so far supported languages such as C, Go, and Rust. Now, we’re adding support for Swift and Objective-C on [iOS/macOS](https://dart.dev/guides/libraries/objective-c-interop). On Android, you can call into Jetpack libraries written in Kotlin and Android libraries written in Java by leveraging FFI and Android’s Java Native Interface (JNI).

我们正在扩展 Dart 的语言互操作能力，
实现**从 Dart 直接调用平台库**。在 Apple 平台上，
我们基于 [C 互操作 FFI](https://dart.dev/guides/libraries/c-interop)
的工作继续构建——它支持从 Dart 调用任何遵循 C
调用约定的 C 模块，迄今已支持 C、Go 和 Rust 等语言。
现在，我们在
[iOS/macOS](https://dart.dev/guides/libraries/objective-c-interop)
上加入对 Swift 和 Objective-C 的支持。在 Android 上，
你可以借助 FFI 和 Android 的 Java 原生接口（JNI），
调用 Kotlin 编写的 Jetpack 库和 Java 编写的 Android 库。

Powered by new tools, Dart can automatically create bindings that have a Dart interface and behind those cross-language interop code based on the header/interface files of the original C/ObjC/Swift/Java/Kotlin code. For a demonstration of using this to call into Apple’s [Core Motion API](https://developer.apple.com/documentation/coremotion) and Android’s [HealthConnect API](https://developer.android.com/guide/health-and-fitness/health-connect), checkout [the sample app](https://github.com/flutter/samples/blob/main/experimental/pedometer/README.md).

在新工具的加持下，Dart 可以根据原始
C/ObjC/Swift/Java/Kotlin 代码的头文件/接口文件，
自动创建带 Dart 接口、背后是跨语言互操作代码的绑定。
想看用它调用 Apple 的
[Core Motion API](https://developer.apple.com/documentation/coremotion)
和 Android 的
[HealthConnect API](https://developer.android.com/guide/health-and-fitness/health-connect)
的演示，请查看
[示例应用](https://github.com/flutter/samples/blob/main/experimental/pedometer/README.md)。

These new interop mechanisms are currently experimental, but we hope that they will reach at least beta quality in Dart 3.0 stable. Feedback is appreciated in the issue trackers for [Java/Kotlin](https://github.com/dart-lang/jnigen), or [C/ObjectiveC/Swift](https://github.com/dart-lang/ffigen). Finally, we’re also working on improved Dart to JavaScript interop; we’ll have more news about that in a future blog post.

这些新互操作机制目前是实验性的，
但我们希望它们在 Dart 3.0 稳定版中至少达到 beta 质量。
欢迎在 [Java/Kotlin](https://github.com/dart-lang/jnigen) 或
[C/ObjectiveC/Swift](https://github.com/dart-lang/ffigen)
的 issue 跟踪器中反馈。最后，我们也在改进 Dart 到
JavaScript 的互操作；未来的博客文章会有更多消息。

## Portability advancements

## 可移植性进展

Dart already supports a wide range of target platforms with our native and web compilers. On the Web, we currently compile to JavaScript. On native devices, we currently support the Intel 32-bit and 64-bit, and ARM 32-bit and 64-bit architectures. There are a number of emerging devices and standards we’re working on adding support for, to ensure Dart is ready for the devices of the future.

借助原生和 Web 编译器，Dart 已支持广泛的目标平台。
在 Web 上，我们目前编译到 JavaScript。
在原生设备上，我们目前支持 Intel 32 位和 64 位、
ARM 32 位和 64 位架构。我们正在为一批新兴设备和标准
添加支持，确保 Dart 为未来的设备做好准备。

For the web, we’re working on support for [WebAssembly](https://webassembly.org/) (Wasm), which has been growing in maturity as a platform-neutral binary instruction format across [all modern browsers](https://caniuse.com/wasm). It’s our hope Wasm can enable Dart web apps to start as fast as apps on native devices.

Web 方面，我们正在支持
[WebAssembly](https://webassembly.org/)（Wasm）——
一种在[所有现代浏览器](https://caniuse.com/wasm)中
日趋成熟的平台中立二进制指令格式。
我们希望 Wasm 能让 Dart Web 应用的启动速度
媲美原生设备上的应用。

Another platform architecture growing in interest is [RISC-V](https://en.wikipedia.org/wiki/RISC-V), an open standard instruction set architecture (ISA) designed for broad usage. The Android team recently gave a talk on [their work to support RISC-V](https://www.youtube.com/watch?v=70O_RmTWP58), and we think it will have broad applicability for embedded devices, too. Support for RISC-V is available to preview in Dart 3 alpha.

另一个关注度不断上升的平台架构是
[RISC-V](https://en.wikipedia.org/wiki/RISC-V)，
一种为广泛使用而设计的开放标准指令集架构（ISA）。
Android 团队最近做了关于
[他们支持 RISC-V 的工作](https://www.youtube.com/watch?v=70O_RmTWP58)
的演讲，我们认为它在嵌入式设备上也有广泛的适用性。
RISC-V 支持已在 Dart 3 alpha 中开放预览。

Finally, we’re working on expanding our current support for ARM devices to also encompass ARM64 support on Windows.

最后，我们正在扩展现有的 ARM 设备支持，
把 Windows 上的 ARM64 支持也纳入进来。

## Dart 3 breaking changes

## Dart 3 破坏性变更

With the new Dart 3 capabilities covered, let’s turn to the breaking changes we’re making in the spirit of a more consistent and approachable Dart.

介绍完 Dart 3 的新能力，再来看我们为了让 Dart
更一致、更易上手而做的破坏性变更。

### Dart 3 type system: 100% sound null safety

### Dart 3 类型系统：100% 健全空安全

We introduced sound null safety in [Dart 2.12](/blog/announcing-dart-2-12) in 2021. In a sound typing system, you can trust the types, meaning a variable is *never* null when the types state that it isn’t. This raises productivity by catching issues during development rather than in production, and enables the Dart compilers to produce [smaller and more optimized code](/blog/dart-and-the-performance-benefits-of-sound-types). As we [discussed in December](/blog/the-road-to-dart-3-a-fully-sound-null-safe-language), Dart is unique in introducing 100% sound null safety to an existing language.

我们在 2021 年的 [Dart 2.12](/blog/announcing-dart-2-12)
中引入了健全空安全。在健全的类型系统中，你可以信任类型：
类型说一个变量不是 null，它就*永远*不会是 null。
这在开发期间而非生产环境中捕获问题，提升了生产力，
也让 Dart 编译器能生成
[更小、更优化的代码](/blog/dart-and-the-performance-benefits-of-sound-types)。
正如我们
[去年 12 月讨论的](/blog/the-road-to-dart-3-a-fully-sound-null-safe-language)，
Dart 是唯一在既有语言上引入 100% 健全空安全的语言。

Since Dart 2.12, null safety has been a configuration option that could either be *on* or *off*. **In Dart 3, all code runs with sound null safety *on***. It is no longer possible to run apps without null safety or in a mixed mode with partial null safety.

自 Dart 2.12 起，空安全是一个可*开*可*关*的配置选项。
**在 Dart 3 中，所有代码都在健全空安全*开启*的状态下运行**。
不再可能在没有空安全或部分空安全的混合模式下运行应用。

We realize that discontinuing support for running without null safety can pose issues for existing apps and packages. However, we feel now is the right time to move forward with this change. Having a single type system, where null safety is always on, reduces overhead and complexity. Whenever developers read a piece of Dart 3 code, they can rest assured that all variables are non-null by default. On the implementation side, Dart’s compilers and runtimes can focus on supporting a single way of running Dart code, which lowers the cost and complexity of adding new features.

我们意识到，停止支持无空安全运行可能给既有应用和
package 带来问题。但我们认为现在是推进这项变更的正确时机。
拥有空安全永远开启的单一类型系统，能减少开销和复杂性。
开发者阅读任何一段 Dart 3 代码时，
都可以放心所有变量默认非 null。在实现侧，
Dart 的编译器和运行时可以专注于支持单一的代码运行方式，
降低添加新特性的成本和复杂性。

The Dart ecosystem has demonstrated a strong dedication and willingness to migrate existing code to null safety. As of today,

Dart 生态展现了把既有代码迁移到空安全的
坚定投入和意愿。截至今天：

* 100% of the top-250 packages on pub.dev support null safety

  pub.dev 上排名前 250 的 package 100% 支持空安全

* 98% of the top-1000 packages on pub.dev support null safety

  pub.dev 上排名前 1000 的 package 98% 支持空安全

* Only 14% of flutter run sessions still run without null safety

  只有 14% 的 flutter run 会话仍在无空安全模式下运行

Thank you to the ecosystem for the migration effort!

感谢整个生态为迁移付出的努力！

### Cleanup of Dart 3 core libraries and language

### Dart 3 核心库与语言清理

As the Dart language and type system have evolved, several of the APIs in our core libraries have become redundant or suboptimal. To ensure Dart remains approachable, we’ve made a number of breaking changes to clean up unnecessary APIs. For details, see the GitHub issues, [#34233](https://github.com/dart-lang/sdk/issues/34233) and [#49529](https://github.com/dart-lang/sdk/issues/49529). We’ve also removed a historical syntax for default parameter values ([#2357](https://github.com/dart-lang/language/issues/2357)).

随着 Dart 语言和类型系统的演进，
核心库中的一些 API 变得冗余或次优。
为确保 Dart 保持易上手，我们做了一些破坏性变更
来清理不必要的 API。详情请见 GitHub issue
[#34233](https://github.com/dart-lang/sdk/issues/34233) 和
[#49529](https://github.com/dart-lang/sdk/issues/49529)。
我们还移除了一种历史遗留的默认参数值语法
（[#2357](https://github.com/dart-lang/language/issues/2357)）。

With Dart 3 alpha done, our attention has now turned to Dart 3 beta. There, we hope to further refine the Dart core libraries by adding a number of new APIs. You can offer input on this in the [feedback issue](https://github.com/dart-lang/sdk/issues/49928).

Dart 3 alpha 完成后，我们的注意力已转向 Dart 3 beta。
在那里，我们希望通过添加一批新 API 进一步打磨 Dart 核心库。
你可以在[反馈 issue](https://github.com/dart-lang/sdk/issues/49928)
中提出意见。

### Preparing your code for Dart 3 stable

### 为你的代码做好 Dart 3 稳定版准备

Generally, we believe most code that has already migrated to use null safety, using Dart 2.12 or later, will work with Dart 3. However, some small subset of packages and apps may be impacted by the breaking changes discussed above. So, to give you time to prepare for the Dart 3 stable release later this year, we have not planned any further breaking changes to the Dart language and core libraries after Dart 3 alpha.

总体而言，我们相信大多数已用 Dart 2.12 或更高版本
迁移到空安全的代码都能在 Dart 3 上运行。
但一小部分 package 和应用可能受上述破坏性变更影响。
所以，为了给你时间准备今年晚些时候的 Dart 3 稳定版，
我们没有计划在 Dart 3 alpha 之后对 Dart 语言和核心库
做进一步的破坏性变更。

To leverage code that has already migrated to use null safety, we’ve implemented backwards compatibility in Dart 3 that will allow migrated packages to resolve with `pub get` in Dart 3 despite having a SDK version constraint like `&gt;=2.12 &lt;3.0.0`, as long as they don’t depend on other discontinued core library APIs or language features. For more details, including how to test with a locally installed [Dart 3 alpha SDK](https://dart.dev/get-dart/archive#dart-3-alpha), see our [Dart 3 null safety documentation](https://dart.dev/null-safety#dart-3-and-null-safety).

为了利用已迁移到空安全的代码，我们在 Dart 3 中
实现了向后兼容：已迁移的 package 即使 SDK 版本约束是
`&gt;=2.12 &lt;3.0.0` 这样的形式，也能在 Dart 3 中
用 `pub get` 解析，只要它们不依赖其他已停止支持的
核心库 API 或语言特性。更多细节，
包括如何用本地安装的
[Dart 3 alpha SDK](https://dart.dev/get-dart/archive#dart-3-alpha)
测试，请参见我们的
[Dart 3 空安全文档](https://dart.dev/null-safety#dart-3-and-null-safety)。

For packages published on the [pub.dev](https://pub.dev/) repository, we’ve run analysis with Dart 3 alpha, and tagged packages that pass with a **“Dart 3 ready”** tag. This signifies that the package is likely to work with Dart 3 when it launches to stable later this year.

对于发布在 [pub.dev](https://pub.dev/) 仓库上的 package，
我们已用 Dart 3 alpha 运行分析，
并给通过的 package 打上 **“Dart 3 ready”** 标签。
这表示该 package 很可能在今年晚些时候 Dart 3
发布稳定版时正常工作。

<DashImage src="images/0dB-NsWj2y3JljZZh.webp" alt="A Dart 3 ready badge displayed on a package page." />


### Dart 3 tools cleanup

### Dart 3 工具清理

Leading up to Dart 3, we made [a number of changes](https://github.com/dart-lang/sdk/issues/46100) to move all our terminal developer tools into a unified dart developer tool, which made Dart a lot more approachable for new developers. We’re planning on making [additional tools changes](https://github.com/dart-lang/sdk/issues/50707) over the coming months to further cleanup. Hopefully these changes won’t be too disruptive, but some minor breakage should be expected for tooling in Dart 3 beta.

在 Dart 3 之前，我们做了
[一系列变更](https://github.com/dart-lang/sdk/issues/46100)，
把所有终端开发者工具整合进统一的 dart 开发者工具，
让 Dart 对新开发者友好得多。我们计划在未来几个月做
[更多工具变更](https://github.com/dart-lang/sdk/issues/50707)
进一步清理。希望这些变更不会太具破坏性，
但 Dart 3 beta 的工具应该会有一些小的破坏。

## Next steps

## 下一步

Dart 3 alpha [is available today](https://dart.dev/get-dart/archive#dart-3-alpha) in the Dart dev channel and in the Flutter master channel. We invite you to try it out, whether it’s to experiment with the new language features like records & patterns, try our new direct access platform interop, or test your apps & packages for [Dart 3 compatibility](https://dart.dev/null-safety#dart-3-and-null-safety).

Dart 3 alpha [今天即可获取](https://dart.dev/get-dart/archive#dart-3-alpha)，
位于 Dart dev 渠道和 Flutter master 渠道。
我们邀请你试用：无论是实验 records 和 patterns
等新语言特性、尝试新的直接平台互操作，
还是测试你的应用和 package 的
[Dart 3 兼容性](https://dart.dev/null-safety#dart-3-and-null-safety)。

We’ll continue to refine Dart 3 over the coming months, and hope to have a complete Dart 3 stable release later this year. Note that most of the features are still undergoing development, and therefore subject to change until the stable release. Until then, have fun with your Dart code!

未来几个月我们会继续打磨 Dart 3，
希望今年晚些时候发布完整的 Dart 3 稳定版。
注意大多数特性仍在开发中，因此在稳定版发布前可能变化。
在那之前，祝你的 Dart 代码写得开心！
