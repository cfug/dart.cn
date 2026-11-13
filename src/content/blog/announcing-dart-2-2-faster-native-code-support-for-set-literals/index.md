---
# title: "Announcing Dart 2.2: Faster native code, support for set literals"
title: "宣布 Dart 2.2：更快的原生代码，支持 set 字面量"
# description: "Today, we’re announcing the stable release of the Dart 2.2 SDK, an incremental update to Dart 2 that offers improved performance of…"
description: "今天我们宣布 Dart 2.2 SDK 稳定版发布，这是 Dart 2 的一次增量更新，改进了提前编译（AOT）原生代码的性能，并带来新的 set 字面量语言特性"
ai-translated: true
publishDate: 2019-02-26
author: mit-mit
image: images/1saXdrIB-SjU2EL7gLGPUsA.webp
category: releases
layout: blog
---


Today, we’re announcing the stable release of the Dart 2.2 SDK, an incremental update to Dart 2 that offers improved performance of [ahead-of-time (AOT) compiled](https://en.wikipedia.org/wiki/Ahead-of-time_compilation) native code and a new set literal language feature.

今天我们宣布 Dart 2.2 SDK 稳定版正式发布。这是 Dart 2 的一次增量更新，
改进了[提前编译（AOT）](https://en.wikipedia.org/wiki/Ahead-of-time_compilation)
原生代码的性能，并带来新的 set 字面量语言特性。

<DashImage src="images/1saXdrIB-SjU2EL7gLGPUsA.webp" alt="Dart 2.2 release banner highlighting improved AOT performance and set literal language support." />


## Dart performance improvements for Flutter developers

## Dart 为 Flutter 开发者带来的性能改进

We continue our work to make [AOT-compiled code](https://hackernoon.com/why-flutter-uses-dart-dd635a054ebf), such as Flutter apps, even faster. In Dart 2.1, [we reduced overhead of type checks](/blog/announcing-dart-2-1-improved-performance-usability), greatly reducing the cost of the type checks for both AOT-compiled code and for code run in the VM with JIT (just-in-time) compilation.

我们继续努力让 [AOT 编译的代码](https://hackernoon.com/why-flutter-uses-dart-dd635a054ebf)
（例如 Flutter 应用）跑得更快。在 Dart 2.1 中，
我们[降低了类型检查的开销](/blog/announcing-dart-2-1-improved-performance-usability)，
大幅减少了 AOT 编译代码以及在 VM 中以 JIT（即时编译）方式运行的代码
的类型检查成本。

In Dart 2.2, we have focused specifically on performance of AOT-compiled code, improving AOT performance by [11–16% on microbenchmarks](https://github.com/flutter/flutter/pull/27789#issuecomment-464234710) (at the cost of a ~1% increase in code size). This improvement is the result of several quarters’ work to reduce the overhead of static calls. Our optimized AOT code is now able to call the destination directly using a PC-relative call (that is, using the [program counter](https://en.wikipedia.org/wiki/Program_counter)); before we had to make several lookups to an object pool to determine the destination address. These optimizations are especially useful when code contains lots of constructor and static method calls, such as Flutter user interface code that creates lots of widgets.

在 Dart 2.2 中，我们专门聚焦于 AOT 编译代码的性能，
在[微基准测试中将 AOT 性能提升了 11–16%](https://github.com/flutter/flutter/pull/27789#issuecomment-464234710)
（代价是代码体积增加约 1%）。这一改进是我们连续几个季度
致力于降低静态调用开销的成果。我们优化后的 AOT 代码现在能够
使用 PC 相对调用（也就是利用[程序计数器](https://en.wikipedia.org/wiki/Program_counter)）
直接调用目标；此前我们必须多次查询对象池才能确定目标地址。
当代码包含大量构造函数和静态方法调用时，这些优化尤其有用，
例如创建大量 widget 的 Flutter 用户界面代码。

## Dart 2.2 set literal language feature

## Dart 2.2 的 set 字面量语言特性

Dart’s core library (`dart:core`) contains a number of collection classes for modelling [Maps](https://api.dartlang.org/stable/dart-core/Map-class.html), [Lists](https://api.dartlang.org/stable/dart-core/List-class.html), and [Sets](https://api.dartlang.org/stable/dart-core/Set-class.html) of objects. Maps are collections of key-value pairs. Lists are ordered sequences of values, where each value may be accessed by an index, and may occur more than once. Sets are unordered collections of values, where each value can occur only once, and where you can efficiently check whether a value is in the set.

Dart 的核心库（`dart:core`）包含许多集合类，
用于建模对象的 [Map](https://api.dartlang.org/stable/dart-core/Map-class.html)、
[List](https://api.dartlang.org/stable/dart-core/List-class.html)
和 [Set](https://api.dartlang.org/stable/dart-core/Set-class.html)。
Map 是键值对的集合。List 是有序的值序列，
每个值可以通过索引访问，且可以出现多次。
Set 是无序的值集合，每个值只能出现一次，
并且你可以高效地检查某个值是否在集合中。

Dart collections are commonly initialized with compile-time constants, so Dart has a convenient literal syntax for expressing this initialization. In Dart, a List can be initialized with:

Dart 集合通常用编译时常量来初始化，
因此 Dart 提供了便捷的字面量语法来表达这种初始化。
在 Dart 中，List 可以这样初始化：

```dart
const List<String> releases = ['Dart 2.0', 'Dart 2.1', 'Dart 2.2'];
```

Previously, Dart supported the literal syntax only for Lists and Maps, so initialization of Sets was cumbersome as we had to initialize via a list:

此前，Dart 的字面量语法只支持 List 和 Map，
所以初始化 Set 很繁琐，必须通过一个 list 来初始化：

```dart
Set<String> currencies = Set.of(['EUR', 'USD', 'JPY']);
```

This code is not just inconvenient and inefficient; the lack of literal support prevents making currencies a compile-time constant. With Dart 2.2’s extension of literals to support sets, we can initialize a set and make it const using a convenient new syntax:

这段代码不仅不方便，而且低效；缺少字面量支持
使得 currencies 无法成为编译时常量。Dart 2.2 把字面量扩展到了 set，
我们可以用便捷的新语法初始化一个 set 并将其声明为 const：

```dart
const Set<String> currencies = {'EUR', 'USD', 'JPY'};
```

For real-world examples of how the Flutter team is starting to apply set literals, see [PR #27811](https://github.com/flutter/flutter/pull/27811). For more general details on how to use set literals, see the [updated Dart 2.2 language tour](https://www.dartlang.org/guides/language/language-tour#sets).

想了解 Flutter 团队开始应用 set 字面量的真实例子，
请参阅 [PR #27811](https://github.com/flutter/flutter/pull/27811)。
关于如何使用 set 字面量的更多通用细节，
请参阅[更新后的 Dart 2.2 语言之旅](https://www.dartlang.org/guides/language/language-tour#sets)。

## Building new language features with the Dart 2 Common Front-End (CFE)

## 用 Dart 2 通用前端（CFE）构建新语言特性

The Dart language implementations — the Dart VM used by Flutter, the dart2js compiler, and the Dart dev compiler (dartdevc) — share a common front end. The Dart Common Front End, or CFE, parses Dart code, performs type inference, and translates Dart into a lower-level intermediate language that back-end implementations accept as input.

Dart 的各个语言实现——Flutter 使用的 Dart VM、dart2js 编译器
和 Dart dev 编译器（dartdevc）——共享一个通用前端。
Dart 通用前端（Common Front End，简称 CFE）负责解析 Dart 代码、
执行类型推断，并把 Dart 翻译成一种更底层的中间语言，
供各后端实现作为输入接受。

The set literals feature is an example of a language construct that we were able to develop rapidly because of the CFE. The code for parsing set literals and performing type inference was implemented once in the CFE for all Dart back ends. In addition, we built a front-end-only transitional implementation that could be used by the back ends initially. In the transitional implementation, the non-const version of the currencies set literal above was translated during compilation into the equivalent of:

set 字面量就是一个得益于 CFE 而得以快速开发的语言构造的例子。
解析 set 字面量和执行类型推断的代码只在 CFE 中实现了一次，
就供所有 Dart 后端使用。此外，我们还构建了一个仅前端的过渡实现，
供各后端在初期使用。在这个过渡实现中，
上面 currencies set 字面量的非 const 版本会在编译时被翻译成等价于：

```dart
Set<String> currencies = Set<String>()..add('EUR')..add('USD')..add('JPY');
```

The transitional implementation of const set literals is different because const sets cannot be built up incrementally in pieces. Instead, we implemented this in terms of a private unmodifiable set class that wraps a const map, where the set elements are the keys of the map:

const set 字面量的过渡实现有所不同，
因为 const set 无法逐块增量构建。取而代之，
我们用一个私有的不可修改 set 类来实现，它包装了一个 const map，
set 的元素就是 map 的键：

```dart
const Set<String> currencies =
   _UnmodifiableSet<String>({'EUR': null, 'USD': null, 'JPY': null});
```

The unmodifiable set class implements the methods in the Set interface in terms of the wrapped map.

这个不可修改的 set 类基于被包装的 map 实现了 Set 接口中的方法。

Overall, we were able to implement set literals initially as a CFE-only feature. The back ends could use the CFE implementation initially, and later develop their own native support independently of the initial launch of the feature. This allowed backends to postpone their native support until the performance aspects of this feature were better understood.

总的来说，我们最先把 set 字面量实现为一个仅 CFE 的特性。
各后端可以先使用 CFE 的实现，之后再独立开发自己的原生支持，
而不影响该特性的首次发布。这让后端可以把原生支持推迟到
对该特性的性能方面有了更好理解之后再做。

## Dart 2.2 language specification

## Dart 2.2 语言规范

Dart 2 was such a [substantial upgrade](/blog/announcing-dart-2-stable-and-the-dart-web-platform) to Dart that it’s taken us a while to get the formal [Dart language specification](https://www.dartlang.org/guides/language/spec) updated to match all the changes we made. We have finally completed that work, and the spec is up-to-date as of Dart 2.2. We’ve also moved the language specification source to the new [language repository](https://github.com/dart-lang/language/tree/master/specification), and added continuous integration to ensure a rolling draft specification is generated in PDF format as we evolve the specification for future versions of the Dart language. Both the 2.2 and rolling Dart 2.x specifications are available from the [Dart specification page](https://www.dartlang.org/guides/language/spec).

Dart 2 对 Dart 来说是一次[重大升级](/blog/announcing-dart-2-stable-and-the-dart-web-platform)，
以至于我们花了一段时间才把正式的
[Dart 语言规范](https://www.dartlang.org/guides/language/spec)
更新到与我们所做的全部改动一致。我们终于完成了这项工作，
规范已更新至 Dart 2.2。我们还把语言规范的源码迁移到了新的
[language 仓库](https://github.com/dart-lang/language/tree/master/specification)，
并加入了持续集成，确保随着我们为 Dart 语言的未来版本演进规范，
会持续生成 PDF 格式的滚动草案规范。2.2 版和滚动更新的 Dart 2.x 规范
都可以在 [Dart 规范页面](https://www.dartlang.org/guides/language/spec)获取。

## Getting Dart 2.2

## 获取 Dart 2.2

[Dart SDK 2.2](https://www.dartlang.org/tools/sdk/archive) is available from the Dart homepage today. If you’re a Flutter developer, Dart 2.2 is already included. (*Note*: the current Flutter master and dev channels will report Dart 2.2. [Today’s Flutter 1.2](https://developers.googleblog.com/2019/02/launching-flutter-12-at-mobile-world.html) stable release will report Dart 2.1.2; this has the same features as Dart 2.2).

[Dart SDK 2.2](https://www.dartlang.org/tools/sdk/archive)
今天已可从 Dart 主页获取。如果你是 Flutter 开发者，Dart 2.2 已经包含在内。
（*注意*：当前的 Flutter master 和 dev 渠道会报告 Dart 2.2。
[今天发布的 Flutter 1.2](https://developers.googleblog.com/2019/02/launching-flutter-12-at-mobile-world.html)
稳定版会报告 Dart 2.1.2；它与 Dart 2.2 具有相同的特性。）

That’s it for now. We hope you enjoy Dart 2.2!

这次就到这里。希望你喜欢 Dart 2.2！
