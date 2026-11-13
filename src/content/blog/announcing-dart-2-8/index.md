---
# title: "Announcing Dart 2.8"
title: "宣布 Dart 2.8"
# description: "Faster package tools, new tool for ensuring dependencies never go stale"
description: "更快的 package 工具，以及确保依赖永不过时的新工具"
ai-translated: true
publishDate: 2020-05-06
author: mit-mit
image: images/1JrrSSD8LCLMkAUIV8RJlkw.webp
category: releases
layout: blog
---


Today we’re announcing a new release of the Dart SDK, version 2.8. We’re continuing to see amazing growth in the Dart community; we now have [millions of Flutter developers]({{site.flutter-blog}}/flutter-spring-2020-update) using Dart as their client-optimized language for building fast apps on any platform. While we’re still working hard on completing our [upcoming null safety](/blog/announcing-dart-2-7-a-safer-more-expressive-dart) feature to make Dart an even more optimized language for building fast and stable user interfaces, we have a few exciting new features focused on making developers even more productive when managing dependencies.

今天我们宣布 Dart SDK 的新版本 2.8 发布。
Dart 社区持续呈现惊人的增长：如今已有
[数百万 Flutter 开发者]({{site.flutter-blog}}/flutter-spring-2020-update)
把 Dart 作为在任何平台构建快速应用的客户端优化语言。
我们仍在努力完成即将推出的
[空安全](/blog/announcing-dart-2-7-a-safer-more-expressive-dart)特性，
让 Dart 成为构建快速、稳定用户界面的更优化语言；
与此同时，这个版本还有几个令人兴奋的新特性，
专注于让开发者管理依赖时更加高效。

The Dart platform comes with built-in support for package management via the [pub client tool](https://dart.dev/tools/pub/cmd) and the [pub.dev](https://pub.dev/) package repository, which has grown 200% over the past year and now is home to nearly 10,000 packages. As part of our ongoing work to improve the Dart ecosystem, the Dart 2.8 SDK brings two improvements to the pub client tool: much better performance in `pub get`, and a new tool for ensuring your package dependencies are kept up-to-date.

Dart 平台通过 [pub 客户端工具](https://dart.dev/tools/pub/cmd)和
[pub.dev](https://pub.dev/) package 仓库内置了 package 管理支持。
pub.dev 过去一年增长了 200%，如今已有近 10,000 个 package。
作为持续改进 Dart 生态的一部分，Dart 2.8 SDK 为 pub 客户端工具
带来两项改进：`pub get` 性能大幅提升，
以及一个确保 package 依赖保持最新的新工具。

Dart 2.8 also brings a set of small breaking changes in the Dart language and libraries. These changes lay the groundwork for our first version of the null safety feature.

Dart 2.8 还在 Dart 语言和库中带来了一组小的破坏性变更。
这些变更为空安全特性的第一个版本奠定了基础。

<DashImage src="images/1JrrSSD8LCLMkAUIV8RJlkw.webp" alt="Dart 2.8 release banner highlighting the pub outdated tool and pub tool performance." caption="Announcing Dart 2.8: Faster package tools, new tool for ensuring dependencies never go stale" />


## Breaking changes paving the way for null safety

## 为空安全铺路的破坏性变更

A common source of app crashes is code that attempts to use a variable that happens to be `null`. Sir Tony Hoare, who introduced null references in the ALGOL programming language in 1965, famously called them his *“billion-dollar mistake”* in a [QCon talk in 2009](https://www.infoq.com/presentations/Null-References-The-Billion-Dollar-Mistake-Tony-Hoare/). In some cases null values are useful; the challenge is separating those from the cases where they aren’t. For the past year we’ve been busy building support for [sound null safety](https://github.com/dart-lang/language/issues/110) in Dart. This support will extend the type system to express variables that are always non-nullable, but in addition the type system will be fully sound: the Dart compilers and runtimes will be able to trust those types, and be able to produce optimized code when the type system guarantees that a variable isn’t null.

应用崩溃的一个常见来源，是代码试图使用一个恰好为 `null` 的变量。
1965 年在 ALGOL 编程语言中引入 null 引用的 Tony Hoare 爵士，
在 [2009 年的 QCon 演讲](https://www.infoq.com/presentations/Null-References-The-Billion-Dollar-Mistake-Tony-Hoare/)
中把它称为自己的*“十亿美元错误”*，广为人知。
某些情况下 null 值是有用的，难点在于把它们与无用的情况区分开。
过去一年我们一直在为 Dart 构建
[可靠空安全](https://github.com/dart-lang/language/issues/110)支持。
这项支持将扩展类型系统，以表达永远不可空的变量；
而且类型系统将是完全可靠的：Dart 编译器和运行时可以信任这些类型，
并在类型系统保证变量不为 null 时生成优化后的代码。

As you can imagine, this is a large undertaking with a lot of moving parts. To ensure that we can build null safety with clean semantics, we’ve decided to make some small breaking changes in the Dart language and libraries. These breaking changes make minor adjustments to corner cases of the Dart type system and to a few Dart core libraries to ensure great nullability-related usability and performance. We expect the actual impact of these breaking changes — which were [pre-announced](https://groups.google.com/a/dartlang.org/g/announce/c/JwPWiC0jTiU) on the Dart announcement list — to be minimal for regular app code. If you experience any issues with Dart 2.8, we encourage you to review [the breaking changes](https://github.com/dart-lang/sdk/issues/40686) and their descriptions and mitigation steps. If that doesn’t resolve the issue, please file an issue in [our issue tracker](https://github.com/dart-lang/sdk/issues). For a preview of the null safety experience, try the [null safety playground](https://nullsafety.dartpad.dev/53257b6da4cb128dc1e069df64748ed1).

可以想象，这是一项涉及许多环节的大工程。
为了确保能以干净的语义构建空安全，
我们决定在 Dart 语言和库中做一些小的破坏性变更。
这些变更对 Dart 类型系统的边角情况和少数核心库做了微调，
以确保与可空性相关的出色可用性和性能。
这些破坏性变更已提前在 Dart 公告邮件列表中
[预告](https://groups.google.com/a/dartlang.org/g/announce/c/JwPWiC0jTiU)，
我们预计它们对常规应用代码的实际影响很小。
如果你在使用 Dart 2.8 时遇到任何问题，建议查阅
[破坏性变更清单](https://github.com/dart-lang/sdk/issues/40686)
及其说明和缓解步骤。如果仍无法解决，请在
[我们的 issue 跟踪器](https://github.com/dart-lang/sdk/issues)中提交 issue。
想预览空安全体验，可以试试
[空安全演练场](https://nullsafety.dartpad.dev/53257b6da4cb128dc1e069df64748ed1)。

## A higher quality package ecosystem

## 更高质量的 package 生态

The pub package manager and [pub.dev](https://pub.dev) site power an ever-growing ecosystem for Dart and Flutter. Nearly 10,000 packages are available at pub.dev, and we’re continually amazed by the many interesting packages being shared. It’s been our core mission to help package authors create high-quality packages and to help app developers find those packages — for example, we’ve added [improved pub.dev discovery](/blog/improved-discovery-on-the-dart-package-site), [verified publishers](/blog/announcing-verified-publishers-on-pub-dev), and [Flutter Favorites](https://flutter.dev/docs/development/packages-and-plugins/favorites).

pub package 管理器和 [pub.dev](https://pub.dev) 网站
支撑着不断壮大的 Dart 和 Flutter 生态。
pub.dev 上已有近 10,000 个 package，
不断涌现的有趣 package 让我们持续惊叹。
帮助 package 作者创建高质量 package、帮助应用开发者找到这些 package，
一直是我们的核心使命——例如，我们加入了
[改进的 pub.dev 发现机制](/blog/improved-discovery-on-the-dart-package-site)、
[认证发布者](/blog/announcing-verified-publishers-on-pub-dev)和
[Flutter Favorites](https://flutter.dev/docs/development/packages-and-plugins/favorites)。

Today we’re announcing much faster performance when retrieving packages from the [pub.dev](https://pub.dev) repository, and a new tool to help you keep all your package dependencies updated. With the complexity of modern apps, your app likely depends on dozens of packages. But how do you keep them all updated to the latest version, to ensure you are getting the most recent dependencies with all the bug fixes and performance improvements available? As of Dart 2.8, you can use `pub outdated`, a new tool for automatically determining which of your dependencies need to be updated to the latest and greatest versions.

今天我们宣布：从 [pub.dev](https://pub.dev) 仓库获取 package 的性能大幅提升，
并推出一个帮助你保持所有 package 依赖最新的新工具。
现代应用如此复杂，你的应用很可能依赖几十个 package。
但如何把它们全部更新到最新版本，确保获得包含所有 bug 修复
和性能改进的最新依赖呢？从 Dart 2.8 起，你可以使用 `pub outdated`，
这个新工具能自动判断哪些依赖需要升级到最新的优秀版本。

## Dart 2.8 pub tool performance improvements

## Dart 2.8 pub 工具性能改进

We optimized the performance of the pub tool by adding support for parallel fetching of packages when running `pub get`, and by deferring `pub run` precompilation.

我们通过两项措施优化了 pub 工具的性能：
运行 `pub get` 时支持并行获取 package，以及推迟 `pub run` 的预编译。

In an informal benchmark of running `flutter pub get` on a new project created with `flutter create`, the total execution time decreased from about 6.5 seconds in Flutter 1.12 (which uses Dart 2.7) to just 2.5 seconds with Flutter 1.17 (Dart 2.8). In a larger app like the [Flutter gallery](https://github.com/flutter/gallery), the time drops from about 15 seconds to about 3 seconds!

在一个非正式基准测试中，对 `flutter create` 创建的新项目运行
`flutter pub get`，总执行时间从 Flutter 1.12（使用 Dart 2.7）的
约 6.5 秒降到 Flutter 1.17（Dart 2.8）的仅 2.5 秒。
而在 [Flutter gallery](https://github.com/flutter/gallery)
这样更大的应用中，时间从约 15 秒降到约 3 秒！

## Managing dependencies with `pub outdated`

## 用 `pub outdated` 管理依赖

<DashImage src="images/1av2bRfpUdU2Fk4s8xRPnhA.webp" alt="A terminal animation recording showing the output of the pub outdated command." />


Dependencies in Dart code are captured in the [pubspec](https://kw-staging-dartlang-2.firebaseapp.com/tools/pub/pubspec) file. When you retrieve packages from [pub.dev](https://pub.dev/) by running the `pub get` command, the pub version solver (which uses the [PubGrub](https://medium.com/@nex3/pubgrub-2fb6470504f) algorithm) runs a process to determine the latest possible set of versions of all your dependencies that satisfies the constraints listed in your pubspec. Note that pub uses a single-version scheme where each package is included in a single-version-only in your app; this is an important optimization to ensure that your app size is as small as possible.

Dart 代码中的依赖记录在
[pubspec](https://kw-staging-dartlang-2.firebaseapp.com/tools/pub/pubspec) 文件中。
当你运行 `pub get` 命令从 [pub.dev](https://pub.dev/) 获取 package 时，
pub 版本求解器（使用
[PubGrub](https://medium.com/@nex3/pubgrub-2fb6470504f) 算法）
会运行一个求解过程，找出满足 pubspec 中所列约束的、
所有依赖尽可能新的一组版本。
注意，pub 采用单版本方案，每个 package 在你的应用中只包含一个版本；
这是一项重要优化，确保应用体积尽可能小。

It’s [a best practice](http://dart.dev/tools/pub/dependencies#best-practices) to always use the latest stable package versions, but doing so can be laborious. Dart has support for upgrading to the latest versions that are [semantically compatible](https://dart.dev/tools/pub/dependencies#version-constraints) using [`pub upgrade`](https://dart.dev/tools/pub/cmd/pub-upgrade), but you can’t include new major versions of packages without updating the pubspec. The `pub outdated` command helps you understand when both minor and major versions are available by comparing currently used versions against the latest versions available on pub.dev.

始终使用最新的稳定 package 版本是
[最佳实践](http://dart.dev/tools/pub/dependencies#best-practices)，
但做起来可能很费力。Dart 支持用
[`pub upgrade`](https://dart.dev/tools/pub/cmd/pub-upgrade)
升级到[语义兼容](https://dart.dev/tools/pub/dependencies#version-constraints)的最新版本，
但不更新 pubspec 就无法引入 package 的新主版本。
`pub outdated` 命令把当前使用的版本与 pub.dev 上的最新可用版本对比，
帮你了解何时有新的次版本和主版本可用。

Let’s consider a concrete example. Imagine you’re building an app, and its `pubspec.yaml` contains the following:

来看一个具体例子。假设你正在构建一个应用，
它的 `pubspec.yaml` 包含以下内容：

```
dependencies:
  foo: ^1.3.0
  bar: ^2.0.0
```


You run `pub get`, and the tool creates a `pubspec.lock` file with the following versions:

你运行 `pub get`，工具会创建一个包含以下版本的 `pubspec.lock` 文件：

```
packages:
  foo:
    version: "1.3.0"
  bar:
    version: "2.0.1"
```


A few months pass, and pub.dev now has new versions of `foo` (1.3.1) and `bar` (2.1.0 and 3.0.3). How do you discover that these new versions are available? For the minor version upgrades (`foo` 1.4.0 and `bar` 2.1.0) you could run pub upgrade, but that wouldn’t give you `bar` 3.0.0. To discover that new version you’d have to visit each package on pub.dev and look at its latest version. Alternatively, you could use a community solution like Paulina Szklarska’s [version checker](https://plugins.jetbrains.com/plugin/12400-flutter-pub-version-checker) or Jeroen Meijer’s [pubspec assist](https://marketplace.visualstudio.com/items?itemName=jeroen-meijer.pubspec-assist).

几个月过去了，pub.dev 上现在有了 `foo`（1.3.1）和
`bar`（2.1.0 和 3.0.3）的新版本。你怎么发现这些新版本呢？
对于次版本升级（`foo` 1.4.0 和 `bar` 2.1.0），你可以运行 pub upgrade，
但那不会给你 `bar` 3.0.0。要发现那个新版本，
你得逐个访问 pub.dev 上的 package 并查看其最新版本。
或者，你也可以使用社区方案，比如 Paulina Szklarska 的
[version checker](https://plugins.jetbrains.com/plugin/12400-flutter-pub-version-checker)
或 Jeroen Meijer 的
[pubspec assist](https://marketplace.visualstudio.com/items?itemName=jeroen-meijer.pubspec-assist)。

With `pub outdated`, the Dart SDK now supports version discovery. If you’re using an IDE with Dart or Flutter support, use the **Pub outdated** action that’s shown when the `pubspec.yaml` file is open. Or you can run `pub outdated` (or `flutter pub outdated`) from the terminal:

有了 `pub outdated`，Dart SDK 现在支持版本发现了。
如果你使用支持 Dart 或 Flutter 的 IDE，
可以在打开 `pubspec.yaml` 文件时使用显示的 **Pub outdated** 操作。
也可以在终端运行 `pub outdated`（或 `flutter pub outdated`）：

```
**$** pub outdated

Dependencies            Current  Upgradable  Resolvable  Latest
foo                     1.3.0    1.3.1       1.3.1       1.3.1
bar                     2.0.1    2.1.0       3.0.3       3.0.3

1 upgradable dependency is locked (in pubspec.lock) to an older version.

To update it, use `pub upgrade`.

1 dependency is constrained to a version that is older than a resolvable version.
```


This output tells us that we can automatically upgrade to `foo` 1.3.1 with `pub upgrade`, which will put us on the latest version available of `foo`. But it also tells us that while we could upgrade automatically to `bar` 2.1.0, a version 3.0.3 is available. Because the upgrade to `bar` 3.0.3 is a major version upgrade, we need to opt into that upgrade by editing our `pubspec.yaml` file:

这个输出告诉我们：可以用 `pub upgrade` 自动升级到 `foo` 1.3.1，
这会让 `foo` 达到最新可用版本。
但它也告诉我们，虽然可以自动升级到 `bar` 2.1.0，
却还有 3.0.3 版本可用。由于升级到 `bar` 3.0.3 是主版本升级，
我们需要编辑 `pubspec.yaml` 文件来主动选择这次升级：

```
dependencies:
  foo: ^1.3.0
  bar: ^3.0.3
```


After we make that edit and run `pub upgrade`, `pub outdated` now reports that all dependencies are up-to-date:

做完这个修改并运行 `pub upgrade` 后，
`pub outdated` 现在报告所有依赖都已是最新：

```
**$** pub outdated

Dependencies            Current   Upgradable  Resolvable  Latest

all up-to-date
```


Success, we’re up-to-date! Because we just picked up new versions, including a new major version, we should review any potential breaking changes in those versions, and run all tests to make sure that our app still works as expected.

成功，全部最新！由于我们刚引入了新版本（包括一个新主版本），
应当检查这些版本中潜在的破坏性变更，并运行所有测试，
确保应用仍按预期工作。

## Next steps

## 下一步

The performance improvements, [breaking changes](https://github.com/dart-lang/sdk/issues/40686), and new `pub outdated` command are available today in the stable [Dart 2.8 SDK](https://dart.dev/get-dart) and in the stable [Flutter 1.17 SDK](https://flutter.dev/docs/get-started/install). We recommend that you [run `pub outdated` today](https://dart.dev/tools/pub/cmd/pub-outdated) to see the health of your dependencies!

性能改进、
[破坏性变更](https://github.com/dart-lang/sdk/issues/40686)
和新的 `pub outdated` 命令今天已在稳定版
[Dart 2.8 SDK](https://dart.dev/get-dart) 和稳定版
[Flutter 1.17 SDK](https://flutter.dev/docs/get-started/install) 中提供。
我们建议你[今天就运行 `pub outdated`](https://dart.dev/tools/pub/cmd/pub-outdated)，
看看依赖的健康状况！

Should you find any issues, please report them in the [pub issue tracker](https://github.com/dart-lang/pub/issues), or in the [SDK issue tracker](https://github.com/dart-lang/sdk/issues) for general issues. We’d love to hear about your experience with `pub outdated`. Leave a comment below or send a tweet to [@dart_lang](https://twitter.com/dart_lang).

如果发现任何问题，请在
[pub issue 跟踪器](https://github.com/dart-lang/pub/issues)中报告；
一般性问题请在
[SDK issue 跟踪器](https://github.com/dart-lang/sdk/issues)中报告。
我们很想听听你使用 `pub outdated` 的体验。
欢迎在下方留言，或发推给
[@dart_lang](https://twitter.com/dart_lang)。
