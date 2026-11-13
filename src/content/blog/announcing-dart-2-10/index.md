---
# title: "Announcing Dart 2.10"
title: "宣布 Dart 2.10"
# description: "A new, unified dart tool for all core tasks. Also, an update on null safety timelines and migration principles."
description: "一个全新的统一 dart 工具，覆盖所有核心任务。另有空安全时间表和迁移原则的最新进展。"
ai-translated: true
publishDate: 2020-10-01
author: mit-mit
image: images/19wrenixSu1viOYLF1nWhAw.webp
category: releases
layout: blog
---


*By: [Michael Thomsen](https://medium.com/@mit.mit) & [Kevin Moore](https://twitter.com/kevmoo)*

*作者：[Michael Thomsen](https://medium.com/@mit.mit) 与
[Kevin Moore](https://twitter.com/kevmoo)*

Today we’re announcing a new release of Dart, version 2.10 (*two-dot-ten*). This release features a new, unified Dart developer tool: a single tool for all your developer needs like creating projects, analyzing and formatting code, running tests, and compiling apps. We also have an update on the null safety roadmap and timelines, and a discussion of the principles for migrating existing code to null safety.

今天我们宣布 Dart 新版本 2.10（*two-dot-ten*，读作“二点十”）发布。
这个版本带来一个全新的统一 Dart 开发者工具：
一个工具满足你所有的开发需求，比如创建项目、分析和格式化代码、
运行测试以及编译应用。我们还带来空安全路线图和时间表的最新进展，
并讨论把现有代码迁移到空安全的原则。

<DashImage src="images/19wrenixSu1viOYLF1nWhAw.webp" alt="Dart 2.10 release banner highlighting the unified Dart tool and null safety update." />


## A new, unified Dart developer tool

## 全新的统一 Dart 开发者工具

Dart forms the foundation of the Flutter SDK: it not only provides the language and runtimes that power Flutter apps, but also supports many core developer tasks like formatting, analyzing, and testing code. However, while Flutter has a single, general-purpose developer tool (the `flutter` command), Dart has historically had many smaller developer tools (for example, `dartfmt` and `dartanalyzer`). Dart 2.10 has a new, unified `dart` developer tool that’s very similar to the `flutter` tool. This new tool supports all common tasks, such as creating new projects and packages; analyzing and formatting code; and running, compiling, and testing projects. To use the tool, simply run the `dart` command:

Dart 是 Flutter SDK 的基础：它不仅提供驱动 Flutter 应用的语言和运行时，
还支持格式化、分析、测试代码等许多核心开发任务。
然而，Flutter 有一个单一的通用开发者工具（`flutter` 命令），
Dart 历来却有许多较小的开发者工具（例如 `dartfmt` 和 `dartanalyzer`）。
Dart 2.10 带来一个全新的统一 `dart` 开发者工具，与 `flutter` 工具非常相似。
这个新工具支持所有常见任务，比如创建新项目和 package；
分析和格式化代码；以及运行、编译和测试项目。
要使用这个工具，只需运行 `dart` 命令：

<DashImage src="images/1y-udLgjneGgP-y8UATZrlw.webp" alt="Terminal help output for the Dart 2.10 dart tool." caption="Learn about the 2.10 dart tool by running dart help." />


Flutter includes this new Dart tool in the Flutter SDK. Starting with today’s [Flutter 1.22 SDK]({{site.flutter-blog}}/announcing-flutter-1-22), the `&lt;flutter-sdk&gt;/bin` directory (which you likely have in `PATH`) contains both `flutter` and `dart` commands. If you do both Flutter and general-purpose Dart development, you get both developer experiences from a single Flutter SDK, without needing to install anything else.

Flutter 在 Flutter SDK 中包含了这个新的 Dart 工具。
从今天发布的
[Flutter 1.22 SDK]({{site.flutter-blog}}/announcing-flutter-1-22) 开始，
`&lt;flutter-sdk&gt;/bin` 目录（你很可能已把它加入 `PATH`）
同时包含 `flutter` 和 `dart` 命令。
如果你既做 Flutter 开发又做通用 Dart 开发，
一个 Flutter SDK 就能提供两种开发体验，无需再安装其他东西。
> **Note:** If you want to download and install a second Dart SDK (perhaps because you require a different version), make sure the SDK of the `dart` tool you wish to default to is at the beginning of your `PATH` environment variable.

> **注意：**如果你想下载并安装第二个 Dart SDK
> （也许因为你需要不同的版本），请确保你想默认使用的 `dart` 工具
> 所在的 SDK 位于 `PATH` 环境变量的最前面。

Over the coming stable releases, we plan to add more to this `dart` tool and gradually deprecate the smaller tools (`dartdoc`, `dartfmt`, `dartanalyzer`, etc.). Next year we expect to ship Dart SDKs that contain only the single `dart` tool. We recommend that you switch over to the new tool when running Dart commands now, whether manually in the terminal or in continuous integration (*CI*) scripts, and [give us feedback](https://github.com/dart-lang/sdk/issues/new?labels=area-dart-cli) if anything is missing or not working as intended.

在接下来的稳定版本中，我们计划为这个 `dart` 工具添加更多功能，
并逐步弃用那些较小的工具（`dartdoc`、`dartfmt`、`dartanalyzer` 等）。
明年我们预计发布的 Dart SDK 将只包含单一的 `dart` 工具。
我们建议你现在运行 Dart 命令时就切换到新工具，
无论是在终端手动执行还是在持续集成（*CI*）脚本中；
如果有任何缺失或不符合预期的地方，请
[给我们反馈](https://github.com/dart-lang/sdk/issues/new?labels=area-dart-cli)。

## Looking forward to null safety

## 期待空安全

We’ve experienced a strong interest in null safety since we launched our [first technical preview](/blog/announcing-sound-null-safety) a few months back. We’re all looking forward to null safety as a tool for avoiding hard-to-spot null errors, and as an added bonus the performance improvements that we expect to see with sound null safety. If you’re keen to learn more, we recommend our new [Understanding null safety](https://dart.dev/null-safety/understanding-null-safety) page. If you prefer a short video, check out [the null safety video](https://www.youtube.com/watch?v=ZxSyZHq8gUg&feature=youtu.be&list=PLjxrf2q8roU1rBlI9vz01K2324nzIhYgp&t=322) from the [Flutter Day event](https://events.withgoogle.com/flutter-day/#content) a few months ago.

自几个月前发布
[首个技术预览](/blog/announcing-sound-null-safety)以来，
我们感受到了大家对空安全的浓厚兴趣。
我们都期待空安全成为避免难以察觉的 null 错误的工具，
额外的好处还有可靠空安全预期带来的性能提升。
如果你想深入了解，推荐我们新的
[理解空安全](https://dart.dev/null-safety/understanding-null-safety)页面。
如果你更喜欢短视频，可以看看几个月前
[Flutter Day 活动](https://events.withgoogle.com/flutter-day/#content)上的
[空安全视频](https://www.youtube.com/watch?v=ZxSyZHq8gUg&feature=youtu.be&list=PLjxrf2q8roU1rBlI9vz01K2324nzIhYgp&t=322)。

When might null safety be ready to use? Here is the current timeline:

空安全什么时候能投入使用？以下是当前的时间表：

1. **Flutter experimentation with *technical preview 2***: We’ve successfully migrated most parts of Flutter. Soon — likely within the next month — we expect to have the complete Flutter framework migrated, and thus be ready to enable experimental use with Flutter. You’ll be able to try null safety in a Flutter sample, and to do trial migration of your Flutter apps and packages. You’ll need to pass an [experiment flag](https://dart.dev/tools/experiment-flags), shouldn’t use it in production, and shouldn’t publish any migrated packages.

  **用*技术预览 2* 在 Flutter 中实验**：我们已成功迁移了 Flutter 的大部分。
  很快——很可能在下个月内——我们预计完成整个 Flutter 框架的迁移，
  从而准备好在 Flutter 中开启实验性使用。
  你将能在 Flutter 示例中尝试空安全，并对你的 Flutter 应用和 package
  做迁移试验。你需要传入一个
  [实验标志](https://dart.dev/tools/experiment-flags)，
  不应在生产环境中使用，也不应发布任何已迁移的 package。

1. **Early package migration with *beta***: Later this year, we’ll complete performance tuning and have sufficient test coverage to give us confidence that the feature works as intended, and that backwards compatibility is solid. At that time we’ll publish a beta version of the feature, and you won’t need to pass the experiment flag. We hope to see package owners begin migration of their packages to null safety, with that one last round of validation that the feature is ready for a stable release.

  **用 *beta* 版尽早迁移 package**：今年晚些时候，
  我们将完成性能调优，并具备足够的测试覆盖，
  让我们确信该特性按预期工作、向后兼容足够稳固。
  届时我们会发布该特性的 beta 版本，你不再需要传入实验标志。
  我们希望看到 package 作者开始把 package 迁移到空安全，
  为该特性进入稳定版做最后一轮验证。

1. **Production use with *stable***: Depending on the feedback from the beta launch, we’ll fix any remaining issues and then publish to stable. It’s hard to state a concrete timeline for this, but we’re thinking early next year. Once the feature is stable, we hope to see lots of adoption of null safety, with null-safe apps published to stores, and many null-safe packages published to pub.dev in stable versions.

  **用*稳定版*投入生产**：根据 beta 发布的反馈，
  我们会修复所有剩余问题，然后发布到稳定版。
  很难给出确切的时间表，但我们预计是明年年初。
  特性稳定后，我们希望看到空安全被大量采用：
  空安全的应用上架各商店，许多空安全的 package
  以稳定版本发布到 pub.dev。

## Principles for migrating to null safety

## 迁移到空安全的原则

We’d like to share our guiding principles for null safety migration.

我们想分享空安全迁移的指导原则。

### Adopt when you’re ready

### 准备好再采用

Null safety is a fundamental change to the Dart typing system. It changes the basics of variable declarations because [we decided](/blog/announcing-sound-null-safety) to make variables non-nullable by default:

空安全是 Dart 类型系统的一项根本性变化。
它改变了变量声明的基础，因为
[我们决定](/blog/announcing-sound-null-safety)让变量默认不可空：

```
**Without null safety**                 W**ith null safety**

String s; // A String or null.      String s; // A String, not null.
```


Such a fundamental change would be extremely disruptive if we insisted on forced adoption. We want to let *you* decide when the time is right, so null safety is an opt-in feature: you’ll be able to use the latest Dart and Flutter releases without being forced to enable null safety before you’re ready to do so. You can even depend on packages that have already enabled null safety from an app or package that hasn’t yet.

如果我们坚持强制采用，如此根本性的变化将带来极大的破坏。
我们想让*你*来决定何时是合适的时机，所以空安全是一个可选启用的特性：
你可以使用最新的 Dart 和 Flutter 版本，
而不会被迫在准备好之前启用空安全。
你甚至可以在尚未启用空安全的应用或 package 中，
依赖已经启用空安全的 package。

### Adopt incrementally, in order

### 按顺序渐进采用

We strongly recommend migrating code in order, with the leaves of the dependency graph being migrated first. For example, if C depends on B which depends on A, migrate A to null safety first, then B, then C. This order applies whether A, B, and C are libraries, packages, or apps.

我们强烈建议按顺序迁移代码，先迁移依赖图中的叶子节点。
例如，如果 C 依赖 B、B 依赖 A，就先把 A 迁移到空安全，然后是 B，再是 C。
无论 A、B、C 是库、package 还是应用，都适用这个顺序。

Why is the order important? Although you can make some progress migrating code before your dependencies migrate, you risk having to do a second migration pass if your dependencies change their APIs during their migration. We will provide tools to help you find out which of your dependencies have migrated. If you’re a package author, then to avoid the risk of breaking your APIs, wait until all of your dependencies have migrated before you publish a null-safe version.

为什么顺序很重要？虽然在依赖迁移之前你也能取得一些迁移进展，
但如果依赖在迁移过程中改变了 API，你就有再做一轮迁移的风险。
我们会提供工具，帮你查明哪些依赖已经迁移。
如果你是 package 作者，为避免破坏 API 的风险，
请等到所有依赖都完成迁移后，再发布空安全版本。

### Use automated tools to reduce migration cost

### 用自动化工具降低迁移成本

When your dependencies are ready and you choose to do the migration, you can use our migration tool. The tool works by analyzing all of your existing code, looking for which declarations can be non-nullable (left unchanged), and which must be nullable (need a `?` nullability marker on the declaration).

当依赖准备就绪、你决定开始迁移时，可以使用我们的迁移工具。
这个工具会分析你所有的现有代码，找出哪些声明可以不可空（保持不变），
哪些必须可空（需要在声明上加 `?` 可空性标记）。

The migration tool is interactive, so you can review the nullability properties that the tool has inferred. If you disagree with any of the tool’s conclusions, you can add nullability hints to change the inference. For example, if you want to make an API non-nullable even though some refactoring will be needed, you can tell the tool and rerun the migration analysis. Adding a few migration hints can have a huge impact on migration quality.

迁移工具是交互式的，你可以审查工具推断出的可空性属性。
如果你不同意工具的某个结论，可以添加可空性提示来改变推断。
例如，即使需要一些重构，你也想让某个 API 不可空，
就可以告诉工具并重新运行迁移分析。
添加少量迁移提示就能对迁移质量产生巨大影响。

<DashImage src="images/0wqrweNI-0SK9DB0z.webp" alt="The interactive dart migrate tool interface showing proposed code changes." />


### Get full benefit with full use

### 全面使用，获得全部收益

Once *all* of your code — and the packages it depends on — is migrated, your code can be executed with *sound* null safety. Before that, your code will continue to run and compile as it does today, but fully sound null safety enables full runtime verification and compiler optimization. Running tests with sound null safety helps you avoid issues with runtime null assertions, and compiling your applications with sound null safety ensures that you get current and future optimizations, such as smaller compiled output and faster execution.

一旦你的*所有*代码——以及它依赖的 package——都完成迁移，
你的代码就能以*可靠*空安全执行。
在此之前，你的代码仍会像今天一样运行和编译，
但完全可靠的空安全能带来完整的运行时校验和编译器优化。
用可靠空安全运行测试有助于避免运行时 null 断言的问题，
用可靠空安全编译应用则确保你获得当前和未来的优化，
比如更小的编译产物和更快的执行速度。

## Next steps

## 下一步

The new `dart` developer tool is available today in the Dart 2.10 SDK and in the Flutter 1.22 SDK. If you already have a Flutter SDK, you can get a Dart SDK with a `dart` command simply by running `flutter upgrade`; this will give you the Flutter 1.22 SDK, which has Dart 2.10 embedded. We recommend that you switch over to the new `dart` tool immediately, and that you [give us feedback](https://github.com/dart-lang/sdk/issues/new?labels=area-dart-cli) if anything is missing or not working as intended.

新的 `dart` 开发者工具今天已在 Dart 2.10 SDK 和 Flutter 1.22 SDK 中提供。
如果你已有 Flutter SDK，只需运行 `flutter upgrade`
就能获得带 `dart` 命令的 Dart SDK；这会给你 Flutter 1.22 SDK，
其中内嵌了 Dart 2.10。我们建议你立即切换到新的 `dart` 工具，
如果有任何缺失或不符合预期的地方，请
[给我们反馈](https://github.com/dart-lang/sdk/issues/new?labels=area-dart-cli)。

We’ll have more news about null safety soon — very likely within the next month, when we expect our friends in the Flutter team to have a null-safety-enabled Flutter framework ready for experimentation. Keep an eye on the [Flutter blog]({{site.flutter-blog}}) for an update. In the meantime you can experiment with null-safe Dart code using [DartPad with Null Safety](https://nullsafety.dartpad.dev/3d9c1769de7912c654bc5d132aff60ac), and learn more about the feature design by reading our [null safety documentation](https://dart.dev/null-safety).

我们很快会带来更多关于空安全的消息——很可能在下个月内，
届时我们预计 Flutter 团队的朋友们会准备好
支持空安全的 Flutter 框架供大家实验。
请关注 [Flutter 博客]({{site.flutter-blog}})获取更新。
与此同时，你可以用
[支持空安全的 DartPad](https://nullsafety.dartpad.dev/3d9c1769de7912c654bc5d132aff60ac)
实验空安全 Dart 代码，并阅读我们的
[空安全文档](https://dart.dev/null-safety)进一步了解特性设计。
