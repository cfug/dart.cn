---
# title: "Announcing Dart 2.14"
title: "宣布 Dart 2.14"
# description: "Apple Silicon support, and improved productivity with default lints, better tools, and new language features"
description: "支持 Apple Silicon，并通过默认 lint、更好的工具和新语言特性提升生产力"
ai-translated: true
publishDate: 2021-09-08
author: mit-mit
image: images/1qlsMfajTUkBw1APUpjcCZg.webp
category: releases
layout: blog
---


Today we’re releasing version 2.14 of the Dart SDK, the next release in our ongoing journey to make the best platform for building apps through a unique combination of portability, productivity, and robustness. This time around we have better support for Apple Silicon, and a number of productivity enhancements such as standard lints for catching errors as you write your code through code style analysis, a faster pub tool, better formatting of code with cascades, and a few small language features.

今天我们发布 Dart SDK 2.14 版本。在我们持续打造
以可移植性、生产力和稳健性的独特组合为核心的最佳应用构建平台
的旅程中，这是又一次发布。这次我们带来了更好的 Apple Silicon 支持，
以及多项生产力增强：通过代码风格分析在你编写代码时捕获错误的
标准 lint、更快的 pub 工具、更好的级联代码格式化，
还有几个小的语言特性。

<DashImage src="images/1qlsMfajTUkBw1APUpjcCZg.webp" alt="Dart 2.14 release banner highlighting Apple Silicon, shared lints, better tools, and language updates." />


## Apple Silicon support in the Dart SDK

## Dart SDK 对 Apple Silicon 的支持

Since Apple announced their new [Apple Silicon](https://support.apple.com/en-us/HT211814) processors in late 2020, we’ve worked on updating the Dart SDK to add support for native execution on the new processors. The needed changes have been available in the dev channel for a while, in the beta channel for the past month, and as of Dart 2.14.1 are now available in the Dart stable channel. When you [download](https://dart.dev/get-dart) a macOS SDK, make sure to pick the ARM64 option. Note that the Dart SDK bundled in the Flutter SDK doesn’t have these improvements yet.

自 Apple 在 2020 年底宣布新的
[Apple Silicon](https://support.apple.com/en-us/HT211814) 处理器以来，
我们一直在更新 Dart SDK，以支持在新处理器上原生运行。
所需改动已在 dev 渠道提供了一段时间，过去一个月在 beta 渠道可用，
从 Dart 2.14.1 起现已进入 Dart 稳定渠道。
[下载](https://dart.dev/get-dart) macOS SDK 时，
请务必选择 ARM64 选项。注意 Flutter SDK 中捆绑的 Dart SDK
尚未包含这些改进。

The support includes both running the SDK/Dart VM itself on Apple Silicon, and support for compiling executables (with [`dart compile`](https://dart.dev/tools/dart-compile#exe)) that run on Apple Silicon. The Dart command-line tools start much faster now that they are using native Apple Silicon support.

这项支持既包括在 Apple Silicon 上运行 SDK/Dart VM 本身，
也包括（用 [`dart compile`](https://dart.dev/tools/dart-compile#exe)）
编译能在 Apple Silicon 上运行的可执行文件。
得益于原生的 Apple Silicon 支持，
Dart 命令行工具的启动速度快了很多。

## Standard lints shared for Dart and Flutter

## Dart 与 Flutter 共享的标准 lint

Developers often prefer their code to follow a certain style. Many of these rules aren’t just stylistic preferences (like the well-known tabs vs. spaces discussion), but cover coding styles that are likely to lead to mistakes or introduce bugs. As an example, the Dart style guide requires using curly braces for all control flow structures, such as if-else statements. This prevents the classic [dangling else](https://en.wikipedia.org/wiki/Dangling_else) problem, where there is ambiguity over how to interpret several nested if-else statements. Another example is type inference. While it’s fine to use type inference when declaring variables with initial values, it’s important to specify the type when [declaring uninitialized variables](https://dart-lang.github.io/linter/lints/prefer_typing_uninitialized_variables.html), to ensure type safety.

开发者往往希望自己的代码遵循某种风格。许多这类规则
不只是风格偏好（比如著名的 tab 与空格之争），
还涵盖了容易导致失误或引入 bug 的编码风格。
例如，Dart 风格指南要求所有控制流结构（如 if-else 语句）
都使用花括号。这避免了经典的
[悬空 else](https://en.wikipedia.org/wiki/Dangling_else) 问题
——多个嵌套 if-else 语句的解释方式存在歧义。
另一个例子是类型推断。声明带初始值的变量时使用类型推断没问题，
但[声明未初始化的变量](https://dart-lang.github.io/linter/lints/prefer_typing_uninitialized_variables.html)时
务必指定类型，以确保类型安全。

One option for enforcing good code style is to have some form of human enforcement, often via a code review. However it’s often much more effective to enforce rules via static analysis that runs as you write your code.

强制良好代码风格的一种方式是某种形式的人工把关，
通常通过代码审查。但通过在你编写代码时运行的静态分析
来强制执行规则，往往有效得多。

In Dart, this static analysis is highly [configurable](https://dart.dev/guides/language/analysis-options), and we have [hundreds of style rules](https://dart.dev/tools/linter-rules) (also known as *lints*). With this wealth of options, it can be a bit overwhelming to choose which rules to enable. The Dart team maintains a [Dart style guide](https://dart.dev/guides/language/effective-dart/style), which describes what we believe is the best way of writing and styling Dart code, but historically we haven’t had an official set of linter rules that correspond to the style guide.

在 Dart 中，这种静态分析高度
[可配置](https://dart.dev/guides/language/analysis-options)，
我们有[数百条风格规则](https://dart.dev/tools/linter-rules)
（也称为 *lint*）。选项如此丰富，要决定启用哪些规则
可能有点让人不知所措。Dart 团队维护着一份
[Dart 风格指南](https://dart.dev/guides/language/effective-dart/style)，
描述了我们认为编写 Dart 代码及其风格的最佳方式，
但历史上我们一直没有一套与风格指南对应的官方 linter 规则集。

Many developers — and the pub.dev site [scoring](https://pub.dev/help/scoring) engine — have used the [pedantic](https://github.com/google/pedantic) set of lint rules. Pedantic, however, has its origins in the Google-internal style guide for Dart, which for historical reasons differs from the general Dart style guide. Additionally, the Flutter framework never used the pedantic set of rules, and instead had its own set of canonical rules.

许多开发者——以及 pub.dev 网站的
[评分](https://pub.dev/help/scoring)引擎——一直在使用
[pedantic](https://github.com/google/pedantic) lint 规则集。
然而 pedantic 源于 Google 内部的 Dart 风格指南，
由于历史原因，它与通用的 Dart 风格指南并不一致。
此外，Flutter 框架从未使用 pedantic 规则集，
而是有自己的一套规范规则。

This might sound a bit messy, and indeed it was. But with today’s releases we’re happy to announce that we now have a brand new set of lint collections that implement the style guide, and that the Dart and Flutter SDKs have been updated to use these rule sets by default for new projects. The rule sets are:

这听起来可能有点乱，事实上也确实如此。但借着今天的发布，
我们很高兴地宣布：现在有了实现风格指南的全新 lint 集合，
而且 Dart 和 Flutter SDK 已更新为在新项目中默认使用这些规则集。
这些规则集是：

* [`package:lints/core.yaml`:](https://github.com/dart-lang/lints/blob/main/lib/core.yaml) ****The main rules from the Dart style guide that we believe all Dart code should follow. The pub.dev scoring engine has been updated to use these instead of pedantic.

  [`package:lints/core.yaml`](https://github.com/dart-lang/lints/blob/main/lib/core.yaml)：
  Dart 风格指南中的主要规则，我们认为所有 Dart 代码都应遵循。
  pub.dev 评分引擎已更新为使用它们替代 pedantic。

* [`package:lints/recommended.yaml`](https://github.com/dart-lang/lints/blob/main/lib/recommended.yaml)**:** The core rules, plus additional recommended rules. This set is recommended for all general Dart code.

  [`package:lints/recommended.yaml`](https://github.com/dart-lang/lints/blob/main/lib/recommended.yaml)：
  核心规则，加上额外的推荐规则。推荐所有通用 Dart 代码使用这套规则。

* [`package:flutter_lints/flutter.yaml`](https://github.com/flutter/packages/blob/master/packages/flutter_lints/lib/flutter.yaml): The core and recommended rules, plus additional Flutter-specific recommended rules. This set is recommended for all Flutter code.

  [`package:flutter_lints/flutter.yaml`](https://github.com/flutter/packages/blob/master/packages/flutter_lints/lib/flutter.yaml)：
  核心规则和推荐规则，加上额外的 Flutter 专属推荐规则。
  推荐所有 Flutter 代码使用这套规则。

If you have existing projects, we strongly recommend that you upgrade to these new sets of rules. Upgrading from pedantic takes [just a few steps](https://github.com/dart-lang/lints#migrating-from-packagepedantic).

如果你有现存项目，我们强烈建议升级到这些新规则集。
从 pedantic 升级[只需几步](https://github.com/dart-lang/lints#migrating-from-packagepedantic)。

## Dart formatter and cascades

## Dart 格式化器与级联

We made several optimizations to how the Dart formatter formats code with [cascades](https://dart.dev/guides/language/language-tour#cascade-notation). Before, the formatter would in some cases produce confusing formatting. For example, what is `doIt()` called on in this example?

我们对 Dart 格式化器格式化
[级联（cascades）](https://dart.dev/guides/language/language-tour#cascade-notation)
代码的方式做了多项优化。此前，格式化器在某些情况下
会产生令人困惑的格式。例如，这个例子中的 `doIt()`
是在什么对象上调用的？

```
var result = errorState ? foo : bad..doIt();
```


It might look like it’s always called on `bad`, but actually the cascade applies to the entire `?` expression, so the cascade is called on the result of that expression, and not just on the false clause. The new formatter makes this clear:

看起来它似乎总是在 `bad` 上调用，但实际上级联作用于
整个 `?` 表达式，所以级联是在该表达式的结果上调用的，
而不只是 false 分支。新的格式化器把这一点表达得很清楚：

```
var result = errorState ? foo : bad
  ..doIt();
```


Other changes relate to how lines with multiple cascades are formatted, and how far cascades generally are indented. We also greatly increased the speed of formatting code containing cascades; in Dart code generated for [protocol buffers](https://developers.google.com/protocol-buffers/docs/reference/dart-generated), we’re seeing up to a 10x improvement in formatting speed.

其他变更涉及含多个级联的行的格式化方式，
以及级联通常的缩进量。我们还大幅提升了格式化含级联代码的速度；
在为 [protocol buffers](https://developers.google.com/protocol-buffers/docs/reference/dart-generated)
生成的 Dart 代码中，我们看到格式化速度最高提升 10 倍。

For all the details, see the [tracking issue](https://github.com/dart-lang/dart_style/pull/1033).

全部细节参见
[跟踪 issue](https://github.com/dart-lang/dart_style/pull/1033)。

## Pub support for ignoring files

## Pub 支持忽略文件

Currently when you [publish](https://dart.dev/tools/pub/publishing) a package to the [pub.dev](https://pub.dev) community repository, pub grabs all the files in that folder with a few exceptions, skipping hidden files (those that begin with a dot: `.`) and files listed in `.gitignore`. Several developers have requested the ability to control which files are ignored outside of the list in `.gitignore`. For example, you might have some internal development tools in a `tool/` folder that you use for *maintaining* your package, but that aren’t relevant to people who *use* your package.

目前，当你把 package [发布](https://dart.dev/tools/pub/publishing)到
[pub.dev](https://pub.dev) 社区仓库时，pub 会抓取该文件夹中的
所有文件，只有少数例外：跳过隐藏文件（以点 `.` 开头的文件）
和 `.gitignore` 中列出的文件。多位开发者请求能在 `.gitignore`
列表之外控制忽略哪些文件。例如，你可能在 `tool/` 文件夹中
有一些内部开发工具，用于*维护*你的 package，
但对*使用*你的 package 的人并无意义。

The updated pub command in Dart 2.14 supports a new `.pubignore` file, where you can list the files that you don’t want to upload to pub.dev. This file uses the same format as `.gitignore` files. For details, see the [package publishing documentation](https://dart.dev/tools/pub/publishing#what-files-are-published).

Dart 2.14 中更新后的 pub 命令支持新的 `.pubignore` 文件，
你可以在其中列出不想上传到 pub.dev 的文件。
该文件使用与 `.gitignore` 相同的格式。详情参见
[package 发布文档](https://dart.dev/tools/pub/publishing#what-files-are-published)。

## Pub and `dart test` performance

## Pub 与 `dart test` 的性能

While pub is perhaps most used for managing code dependencies, it also has a second important utility: powering tools. One such example is the Dart test tool, exposed via the `dart test` command. This command is really just a wrapper around the `command pub run test:test`, which runs the `test` entrypoint in [`package:test`](https://github.com/dart-lang/test/blob/master/pkgs/test/bin/test.dart). Before invoking that entrypoint, pub first compiles it to native code that can be run faster.

pub 也许最常用于管理代码依赖，但它还有第二个重要用途：
为工具提供动力。一个例子是 Dart 测试工具，
通过 `dart test` 命令暴露。这个命令实际上只是
`command pub run test:test` 的包装，后者运行
[`package:test`](https://github.com/dart-lang/test/blob/master/pkgs/test/bin/test.dart)
中的 `test` 入口点。在调用该入口点之前，
pub 会先把它编译为运行更快的原生代码。

Before Dart 2.14, any change to the pubspec (including ones unrelated to `package:test`) would invalidate this build of test, and you’d see a bunch of output like this containing “Precompiling executable”:

在 Dart 2.14 之前，对 pubspec 的任何改动
（包括与 `package:test` 无关的改动）都会使 test 的这次构建失效，
你会看到一堆包含 “Precompiling executable” 的输出：

```
$ dart test
Precompiling executable... (11.6s)
Precompiled test:test.
00:01 +1: All tests passed!
```


In Dart 2.14, pub is much smarter about when to invalidate the build step, so the build happens only when the version changes. Further, we improved how we perform that build step using parallelization, so the step itself completes much faster. We’ve seen it take half the time on some packages that we’ve tested.

在 Dart 2.14 中，pub 对何时使构建步骤失效聪明得多，
只有版本变化时才会重新构建。此外，我们用并行化改进了
构建步骤的执行方式，让该步骤本身完成得快得多。
在我们测试的一些 package 上，耗时缩短了一半。

## New language features

## 新语言特性

Dart 2.14 also contains a number of small language features. This time we focused on more specific improvements that are perhaps of more narrow utility, but enable more specialized use cases that weren’t previously supported.

Dart 2.14 还包含一些小的语言特性。这次我们专注于
更具体的改进，用途也许更窄，但支持了此前不支持的
更专门化的用例。

First, we added a new [triple shift](https://github.com/dart-lang/language/issues/120) operator (`&gt;&gt;&gt;`). This is similar to the existing shift operator (`&gt;&gt;`), but where `&gt;&gt;` performs an arithmetic shift, `&gt;&gt;&gt;` performs a logical, or unsigned, shift where zero-bits are shifted into the most significant bit regardless of whether the number being shifted is positive or negative.

首先，我们添加了新的[三重移位](https://github.com/dart-lang/language/issues/120)
运算符（`&gt;&gt;&gt;`）。它类似于现有的移位运算符（`&gt;&gt;`），
但 `&gt;&gt;` 执行算术移位，而 `&gt;&gt;&gt;` 执行逻辑移位
（即无符号移位）：无论被移位的数是正是负，
移入最高位的都是零。

We’ve also removed an old restriction on type arguments, which disallowed using generic function types as a type argument. All of the following were invalid before 2.14, but are now allowed:

我们还移除了对类型实参的一条旧限制：
此前不允许把泛型函数类型用作类型实参。
下面的写法在 2.14 之前全都非法，现在都允许了：

```
late List<T Function<T>(T)> idFunctions;
var callback = [<T>(T value) => value];
late S Function<S extends T Function<T>(T)>(S) f;
```


And finally, we’ve made a small adjustment to annotation types. (Annotations such as [`@Deprecated`](https://api.dart.dev/stable/2.13.4/dart-core/Deprecated-class.html) are commonly used in Dart code to capture metadata.) Previously annotations couldn’t be passed type arguments, so code like `@TypeHelper&lt;int&gt;(42, "The meaning")` wasn’t allowed. This restriction has now been removed.

最后，我们对注解类型做了一个小调整。
（[`@Deprecated`](https://api.dart.dev/stable/2.13.4/dart-core/Deprecated-class.html)
等注解在 Dart 代码中常用于承载元数据。）
此前注解不能传入类型实参，所以
`@TypeHelper&lt;int&gt;(42, "The meaning")` 这样的代码不被允许。
这条限制现已移除。

## Package and core library changes

## Package 与核心库变更

We’ve made a number of enhancements to core Dart packages and libraries, including:

我们对 Dart 核心 package 和库做了多项增强，包括：

* `dart:core`: Added static methods `hash`, `hashAll`, and `hashAllUnordered` to the `Object` class. These can be used to combine the hash codes of multiple objects in a consistent way ([hashAll example](https://api.dart.dev/stable/2.14.0/dart-core/Object/hashAll.html)).

  `dart:core`：为 `Object` 类添加了静态方法 `hash`、`hashAll`
  和 `hashAllUnordered`。它们能以一致的方式组合多个对象的哈希码
  （[hashAll 示例](https://api.dart.dev/stable/2.14.0/dart-core/Object/hashAll.html)）。

* `dart:core`: The native `DateTime` class now better handles local time around daylight saving time changes that aren’t precisely one hour — for example Lord Howe Island, Australia, which uses a 30-minute shift.

  `dart:core`：原生 `DateTime` 类现在能更好地处理
  夏令时切换不恰好是一小时的本地时间——例如澳大利亚的
  豪勋爵岛（Lord Howe Island），它使用 30 分钟的偏移。

* [`package:ffi`](https://pub.dev/packages/ffi): Added support for managing memory using an [arena](https://pub.dev/documentation/ffi/latest/ffi/Arena-class.html) allocator ([example](https://github.com/dart-lang/sdk/blob/master/samples/ffi/resource_management/arena_sample.dart)). Arenas are a form of [region-based memory management](https://en.wikipedia.org/wiki/Region-based_memory_management), where resources are automatically freed once the arena/region is exited.

  [`package:ffi`](https://pub.dev/packages/ffi)：新增用
  [arena](https://pub.dev/documentation/ffi/latest/ffi/Arena-class.html)
  分配器管理内存的支持
  （[示例](https://github.com/dart-lang/sdk/blob/master/samples/ffi/resource_management/arena_sample.dart)）。
  arena 是一种[基于区域的内存管理](https://en.wikipedia.org/wiki/Region-based_memory_management)，
  一旦退出 arena/区域，资源就会被自动释放。

* [`package:ffigen`](https://pub.dev/packages/ffigen): Now supports generating Dart typedefs from C typedefs.

  [`package:ffigen`](https://pub.dev/packages/ffigen)：
  现在支持从 C typedef 生成 Dart typedef。

## Breaking changes

## 破坏性变更

Dart 2.14 also contains a number of smaller, [previously announced](https://github.com/dart-lang/sdk/blob/master/docs/process/breaking-changes.md) breaking changes. These changes are expected to impact just a few specialized use cases.

Dart 2.14 还包含一些较小的、
[此前已宣布](https://github.com/dart-lang/sdk/blob/master/docs/process/breaking-changes.md)
的破坏性变更。这些变更预计只影响少数专门化的用例。

### [#46545](https://github.com/dart-lang/sdk/issues/46545): Removal of support for ECMAScript5

### [#46545](https://github.com/dart-lang/sdk/issues/46545)：移除对 ECMAScript5 的支持

[All modern browsers](https://caniuse.com/es6) support recent ECMAScript versions, so two years ago we [announced](https://groups.google.com/a/dartlang.org/g/announce/c/x7eDinVT6fM/m/ZSFl2a9tEAAJ?pli=1) a plan to deprecate support for ECMAScript 5 (ES5). This enables us to leverage improvements in the latest ECMAScript and generate smaller output. In Dart 2.14 this work is complete, and the Dart web compilers no longer support ES5. As a result, older browsers — such as IE11 — are no longer supported.

[所有现代浏览器](https://caniuse.com/es6)都支持较新的
ECMAScript 版本，所以两年前我们
[宣布](https://groups.google.com/a/dartlang.org/g/announce/c/x7eDinVT6fM/m/ZSFl2a9tEAAJ?pli=1)
了弃用 ECMAScript 5（ES5）支持的计划。这让我们能利用
最新 ECMAScript 的改进并生成更小的输出。在 Dart 2.14 中
这项工作已完成，Dart Web 编译器不再支持 ES5。
因此，较老的浏览器——例如 IE11——不再受支持。

### [#46100](https://github.com/dart-lang/sdk/issues/46100): Deprecation of stagehand, dartfmt, and dart2native

### [#46100](https://github.com/dart-lang/sdk/issues/46100)：弃用 stagehand、dartfmt 和 dart2native

In the October 2020 [Dart 2.10 blog post](/blog/announcing-dart-2-10), we announced our work to combine all the Dart CLI developer tools into a single, combined `dart` tool (similar to the `flutter` tool). As part of that evolution, Dart 2.14 deprecated the former `dartfmt` and `dart2native` commands, and discontinued `stagehand`. These tools all have equivalent replacements in the [unified `dart` tool](https://dart.dev/tools/dart-tool).

在 2020 年 10 月的 [Dart 2.10 博客文章](/blog/announcing-dart-2-10)中，
我们宣布了把所有 Dart CLI 开发工具合并为单一 `dart` 工具的工作
（类似 `flutter` 工具）。作为这一演进的一部分，Dart 2.14
弃用了原来的 `dartfmt` 和 `dart2native` 命令，
并停止了 `stagehand`。这些工具在
[统一的 `dart` 工具](https://dart.dev/tools/dart-tool)中都有等价替代。

### [#45451](https://github.com/dart-lang/sdk/issues/45451): Deprecation of VM Native Extensions

### [#45451](https://github.com/dart-lang/sdk/issues/45451)：弃用 VM 原生扩展

We’ve deprecated the Dart VM’s Native Extensions, our older mechanism for calling native code from Dart code. Dart [FFI](https://dart.dev/guides/libraries/c-interop) (foreign function interface) is our current mechanism for this use case, and we’re actively [evolving](/blog/announcing-dart-2-13) that to be even more powerful and easy to use.

我们已弃用 Dart VM 的原生扩展（Native Extensions）
——从 Dart 代码调用原生代码的旧机制。Dart
[FFI](https://dart.dev/guides/libraries/c-interop)（外部函数接口）
是我们目前用于该场景的机制，我们正在积极
[演进](/blog/announcing-dart-2-13)它，让它更强大、更易用。

## Null safety update

## 空安全进展

We launched sound null safety in March in the [Dart 2.12](/blog/announcing-dart-2-12) release. Null safety is Dart’s latest major productivity feature, intended to help you avoid null errors — a class of bugs that are often hard to spot.

我们在三月的 [Dart 2.12](/blog/announcing-dart-2-12) 版本中
发布了健全空安全。空安全是 Dart 最新的重大生产力特性，
旨在帮助你避免 null 错误——这类 bug 往往很难被发现。

Since our last update, we’ve seen great progress on migrations of existing packages and apps to enable the sound checking benefits of null safety. For packages on pub.dev, 100% of the top-250 packages now support null safety, and 94% of the top-1000 support it. This means that more developers can run their apps with full [sound null safety](https://dart.dev/null-safety/unsound-null-safety#sound-and-unsound-null-safety). Analytics show that 56% of `flutter run` sessions execute with full soundness. Thanks to all developers in the ecosystem for your migration work!

自上次更新以来，我们看到现有 package 和应用在迁移、
以获得空安全的健全检查收益方面取得了巨大进展。
对 pub.dev 上的 package，前 250 个 package 现在 100% 支持空安全，
前 1000 个中 94% 支持。这意味着更多开发者可以以完全的
[健全空安全](https://dart.dev/null-safety/unsound-null-safety#sound-and-unsound-null-safety)
运行应用。分析数据显示，56% 的 `flutter run` 会话
以完全健全的方式执行。感谢生态中所有开发者的迁移工作！

## 2.14 availability and continued momentum

## 2.14 的可用性与持续的势头

The enhanced Dart SDK containing the above changes is available today in the Dart 2.14.1 and [Flutter 2.5]({{site.flutter-blog}}/whats-new-in-flutter-2-5) SDKs. We hope you’ll enjoy the new enhancements and features.

包含上述变更的增强版 Dart SDK，今天已可在 Dart 2.14.1 和
[Flutter 2.5]({{site.flutter-blog}}/whats-new-in-flutter-2-5) SDK 中获取。
希望你喜欢这些新的增强和特性。

Also, we want to take the opportunity to extend our thanks to the awesome Dart community. As witnessed through a number of recent updates to programming language surveys, the Dart momentum is strong. The well-respected [RedMonk ranking](https://redmonk.com/sogrady/2021/08/05/language-rankings-6-21/) mentions *“Dart’s remarkable ascent”* and places Dart in the top 20 for the first time. StackOverflow’s comprehensive [2021 Developer Survey](https://insights.stackoverflow.com/survey/2021#technology-most-loved-dreaded-and-wanted) was equally delightful to read: Dart was reported to be the 7th most Loved programming language by developers. We’re truly delighted to see the Dart platform have continued growth and momentum.

另外，我们想借此机会向出色的 Dart 社区致谢。
从最近多项编程语言调查的更新可以看出，Dart 的势头强劲。
备受尊敬的 [RedMonk 排名](https://redmonk.com/sogrady/2021/08/05/language-rankings-6-21/)
提到了*“Dart 的显著上升”*，并首次把 Dart 排进前 20。
StackOverflow 全面的
[2021 开发者调查](https://insights.stackoverflow.com/survey/2021#technology-most-loved-dreaded-and-wanted)
读来同样令人欣喜：Dart 被开发者评为第 7 受喜爱（Loved）的编程语言。
我们由衷高兴看到 Dart 平台持续增长、势头不减。
