---
# title: "Announcing Dart null safety beta"
title: "宣布 Dart 空安全进入 beta 阶段"
# description: "Beginning the journey to migrate packages to a sound, safer state"
description: "开启将 package 迁移到健全、更安全状态的旅程"
ai-translated: true
publishDate: 2020-11-19
author: mit-mit
image: images/1kr-aQjGvnhY0JDCx1CGzRg.webp
category: announcements
layout: blog
---


*Cross-posted here and on the [Flutter blog]({{site.flutter-blog}}).*

*本文同时发布于这里和 [Flutter 博客]({{site.flutter-blog}})。*

Today we’re announcing that **sound null safety is available in beta** for Dart and Flutter. Null safety is our latest major productivity feature, intended to [help you avoid null errors](https://dart.dev/null-safety), a class of bugs that are often hard to spot. If you’re looking for a quick summary of why we’re excited about null safety, check out this new video:

今天我们宣布，Dart 和 Flutter 的**健全空安全（sound null safety）已进入
beta 阶段**。空安全（null safety）是我们最新的重大生产力特性，
旨在[帮助你避免 null 错误](https://dart.dev/null-safety)——
这类 bug 往往很难被发现。如果你想快速了解我们为何对空安全如此兴奋，
请看看这个新视频：

<YoutubeEmbed id="iYhOU9AuaFs" title="Null safety in Dart - Introduction" fullwidth="true"/>


With null safety graduating to beta, **it’s time to start community migration** of the thousands of packages available on [pub.dev](https://pub.dev/). We’ve migrated the Dart core libraries, the Flutter framework, and [more than 40](https://pub.dev/packages?q=&prerelease-null-safe=1) Dart and Flutter packages. With that we hope to see the community embrace null safety by migrating their packages.

随着空安全进入 beta 阶段，**是时候开始社区迁移了**——
[pub.dev](https://pub.dev/) 上有数千个 package 可供迁移。
我们已经迁移了 Dart 核心库、Flutter 框架，以及
[40 多个](https://pub.dev/packages?q=&prerelease-null-safe=1)
Dart 和 Flutter package。我们希望借此看到社区通过迁移各自的
package 来拥抱空安全。

<DashImage src="images/1kr-aQjGvnhY0JDCx1CGzRg.webp" alt="Dart sound null safety timeline showing technical previews in June and October 2020, beta in November 2020, and stable planned for early 2021." />


With beta, we’re also starting the home stretch before shipping a stable version of the null safety feature. We hope that you’ll use the feature and let us know if parts of it can be improved, if UI messages can be made easier to understand, or if documentation can be made clearer. We’re **really looking forward to [your feedback](https://github.com/dart-lang/sdk/issues/new?title=Null%20safety%20feedback:%20[issue%20summary]&labels=NNBD&body=Describe%20the%20issue%20or%20potential%20improvement%20in%20detail%20here)**.

进入 beta 阶段，也意味着我们开始了空安全特性发布稳定版前的最后冲刺。
我们希望你使用这一特性，并告诉我们哪些部分可以改进、
UI 提示信息能否更容易理解、文档能否更清晰。
我们**非常期待[你的反馈](https://github.com/dart-lang/sdk/issues/new?title=Null%20safety%20feedback:%20[issue%20summary]&labels=NNBD&body=Describe%20the%20issue%20or%20potential%20improvement%20in%20detail%20here)**。

## Opting in to null safety

## 选择启用空安全

Before we discuss null safety migration, it’s important to repeat that (as stated in our [null safety principles](https://dart.dev/null-safety#null-safety-principles)) you’re in control of when to begin null safety adoption. Apps and packages will only run with null safety if their minimum [Dart SDK constraint](https://dart.dev/null-safety#enable-null-safety) is at least a Dart 2.12 prerelease:

在讨论空安全迁移之前，有必要重申（正如我们的
[空安全原则](https://dart.dev/null-safety#null-safety-principles)所述）：
何时开始采用空安全由你掌控。只有当应用和 package 的最低
[Dart SDK 约束](https://dart.dev/null-safety#enable-null-safety)
至少为 Dart 2.12 预发布版本时，它们才会以空安全方式运行：

```
environment:
  sdk: "**>=2.12.0-0** <3.0.0"
```


To experience this, try to create a small null-safe hello app (for example, using `dart create`) containing code like shown below. You can then try to run the app both before and after changing the SDK constraint and running `dart pub get`, and experience how the program behavior changes. (Make sure to use an SDK that reports 2.12 in `dart --version`.)

想体验这一点，可以创建一个小的空安全 hello 应用
（例如使用 `dart create`），包含如下所示的代码。
然后分别在修改 SDK 约束并运行 `dart pub get` 的前后运行该应用，
体验程序行为的变化。（请确保使用的 SDK 在 `dart --version`
中报告的版本是 2.12。）

```
***bin/hello.dart:***
...
void main() {
  var hello = 'Hello Dart developers';
  if (someCondition) {
    hello = null;
  }
  print(hello);
}

Before changing the SDK constraint:
$ dart run

null

After changing the SDK constraint (and running dart pub get):
$ dart run

bin/hello.dart:6:13: Error: Null can't be assigned to a variable of type 'String' because 'String' is not nullable.

    hello = null;
            ^
```


## Migrating to null safety

## 迁移到空安全

To migrate a package (or simple app) to null safety, follow these five steps, which are fully documented in the [migration guide](https://dart.dev/null-safety/migration-guide) on dart.dev.

要将 package（或简单应用）迁移到空安全，请遵循以下五个步骤，
dart.dev 上的[迁移指南](https://dart.dev/null-safety/migration-guide)
有完整说明。

### Step 1: Check if your dependencies are ready

### 第 1 步：检查依赖是否就绪

We strongly recommend migrating code in order, with the leaves of the dependency graph being migrated first. For example, if C depends on B which depends on A, migrate A to null safety first, then B, then C. This order applies whether A, B, and C are libraries, packages, or apps.

我们强烈建议按顺序迁移代码，先迁移依赖图中的叶子节点。
例如，若 C 依赖 B，B 依赖 A，则先把 A 迁移到空安全，然后是 B，
最后是 C。无论 A、B、C 是库、package 还是应用，都适用这一顺序。

<DashImage src="images/0fM8TG0L56zVeJVlG.webp" alt="A dependency graph showing the order of migrating packages to null safety from the bottom up." />


Why is the order important? Although you can make some progress migrating code before your dependencies migrate, you risk having to do a second migration pass if your dependencies change their APIs during their migration. If a few of your dependencies aren’t null safe, consider reaching out to the package publishers using the contact details listed for each package on pub.dev.

为什么顺序很重要？虽然在依赖迁移之前你也能推进一部分代码迁移，
但如果依赖在迁移过程中更改了 API，你可能不得不进行第二轮迁移。
如果有少数依赖还不是空安全的，可以考虑通过 pub.dev 上
各 package 列出的联系方式，联系 package 发布者。

### *Verifying that dependencies are ready*

### *验证依赖是否就绪*

To verify whether your app or package is ready to begin migration, you can use `dart pub outdated` in null-safety mode. The example below shows that this app is ready to migrate if it upgrades its dependencies to the prerelease versions of `path`, `process`, and `pedantic` as listed in the **Resolvable** column.

要验证你的应用或 package 是否可以开始迁移，
可以在空安全模式下使用 `dart pub outdated`。
下面的示例表明：只要把依赖升级到 **Resolvable** 列中列出的
`path`、`process` 和 `pedantic` 的预发布版本，
这个应用就可以开始迁移了。

<DashImage src="images/0zrUdYSzsjWZGr7Or.webp" alt="Terminal output of the dart pub outdated command showing null safety migration status." />


If null safety support is available in minor new versions, you’ll see those in the **Upgradable** column. Often null safety support will be available in major new versions; in that case you’ll see the versions listed under **Resolvable** in the outdated output. To upgrade to those, edit your `pubspec.yaml` file to allow those major versions. For example, you might change
`process: ^3.0.13` to `process: ^4.0.0-nullsafety`.

如果空安全支持出现在次版本号升级的新版本中，
你会在 **Upgradable** 列看到它们。空安全支持通常出现在
主版本号升级的新版本中；这种情况下，这些版本会列在
outdated 输出的 **Resolvable** 下。要升级到这些版本，
请编辑 `pubspec.yaml` 文件以允许这些主版本。
例如，你可以把 `process: ^3.0.13` 改为 `process: ^4.0.0-nullsafety`。

You can also find packages with null safety support on pub.dev using the new **Null safety** tags on package pages (for example [collection 1.15](https://pub.dev/packages/collection/versions/1.15.0-nullsafety.5)) and a new **Advanced** **search** [null safety search option](https://pub.dev/packages?q=&prerelease-null-safe=1).

你还可以在 pub.dev 上通过 package 页面新增的 **Null safety** 标签
（例如 [collection 1.15](https://pub.dev/packages/collection/versions/1.15.0-nullsafety.5)），
以及 **Advanced** **search** 中新增的
[空安全搜索选项](https://pub.dev/packages?q=&prerelease-null-safe=1)，
找到支持空安全的 package。

<DashImage src="images/1P2ufPitLRaJRAD__KUfbvg.webp" alt="pub.dev search interface with the null safety filter checked under advanced search options." />


### Step 2: Migrate using the migration tool

### 第 2 步：使用迁移工具进行迁移

If your dependencies are ready, you can proceed to migrating your app or package using the migration tool, `dart migrate`.

如果依赖已经就绪，你就可以使用迁移工具 `dart migrate`
来迁移你的应用或 package。

The migration tool is interactive, so you can review the nullability properties that the tool has inferred. If you disagree with any of the tool’s conclusions, you can add nullability hints to change the inference. Adding a few migration hints can have a huge impact on migration quality.

迁移工具是交互式的，你可以审查工具推断出的可空性属性。
如果你不同意工具的某些结论，可以添加可空性提示来改变推断结果。
添加少量迁移提示就能对迁移质量产生巨大影响。

<DashImage src="images/0dPlSded52Mt6P5tY.webp" alt="The interactive dart migrate tool interface showing proposed code changes." />


We’ve had a small number of Dart package authors test-drive migration using early preview builds of null safety, and their feedback has been encouraging. The migration guide has additional tips on how to use the migration tool.

我们已经邀请少量 Dart package 作者使用空安全的早期预览构建
试用了迁移，他们的反馈令人鼓舞。
迁移指南中还有更多关于如何使用迁移工具的技巧。

### Step 3: Statically analyze your migrated code

### 第 3 步：对迁移后的代码做静态分析

Update your packages using `pub get` in your IDE or on the command line. Then use your IDE or the command line to perform static analysis on your Dart code:

在 IDE 或命令行中使用 `pub get` 更新你的 package。
然后在 IDE 或命令行中对 Dart 代码执行静态分析：

```
$ dart pub get
$ dart analyze
```


Or on your Flutter code:

或者对你的 Flutter 代码：

```
$ flutter pub get
$ flutter analyze
```


### Step 4: Ensure tests pass

### 第 4 步：确保测试通过

Run your tests and make sure that they pass. You might need to update tests that expect null values, in case you changed your package code to no longer allow nulls.

运行测试并确保它们通过。如果你修改了 package 代码、
不再允许 null，可能需要更新那些期望 null 值的测试。

### Step 5: Publish your null-safe package

### 第 5 步：发布你的空安全 package

When the migration is complete and tests are passing, you can publish your package as a prerelease. Here’s a brief summary of best practices:

迁移完成且测试通过后，你可以把 package 作为预发布版本发布。
以下是最佳实践的简要总结：

* Increment your version number to the next major version (for example, `2.3.x` to `3.0.0`). This best practice ensures that users of your package don’t upgrade to it before they’re ready to use null safety themselves, and it gives you the freedom to refactor your APIs to best leverage null safety.

  把版本号提升到下一个主版本（例如从 `2.3.x` 到 `3.0.0`）。
  这一最佳实践确保 package 的用户不会在自己准备好使用空安全之前
  就升级上来，也让你能自由重构 API，以充分利用空安全。

* Version and publish your package as a [prerelease version on pub.dev](https://dart.dev/tools/pub/publishing#publishing-prereleases). (For example, use `3.0.0-nullsafety.0`, not `3.0.0`.)

  将 package 作为
  [pub.dev 上的预发布版本](https://dart.dev/tools/pub/publishing#publishing-prereleases)
  定版并发布。（例如使用 `3.0.0-nullsafety.0`，而不是 `3.0.0`。）

For full details on migration and versioning, see the [migration guide](https://dart.dev/null-safety/migration-guide).

关于迁移和版本管理的完整细节，
请参阅[迁移指南](https://dart.dev/null-safety/migration-guide)。

## The benefits of sound null safety

## 健全空安全的好处

Our previous blog posts for the technical previews of null safety [in Dart](/blog/announcing-sound-null-safety) and [in Flutter]({{site.flutter-blog}}/dart-sound-null-safety-technical-preview-2) have discussed the benefits of null safety via a number of examples. Now that null safety is nearing completion, we’re seeing several real-world examples of this benefit.

我们之前关于空安全技术预览的博客文章——
[Dart 版](/blog/announcing-sound-null-safety)和
[Flutter 版]({{site.flutter-blog}}/dart-sound-null-safety-technical-preview-2)——
已通过多个例子讨论了空安全的好处。如今空安全接近完成，
我们看到了几个体现这些好处的真实案例。

### Safer code

### 更安全的代码

Just recently, we [discovered a bug](https://github.com/flutter/flutter/issues/69863) in the Flutter master channel where various `flutter` tool commands would crash on certain machine configurations with a null error: `The method '&gt;=' was called on null`. The underlying issue was a recent pull request to add support for detecting Android Studio 4.1. That PR added code like this:

就在最近，我们在 Flutter master 渠道
[发现了一个 bug](https://github.com/flutter/flutter/issues/69863)：
在某些机器配置上，多个 `flutter` 工具命令会因 null 错误而崩溃：
`The method '&gt;=' was called on null`。根源是最近一个
添加 Android Studio 4.1 检测支持的 pull request。
该 PR 加入了这样的代码：

```
final int major = version?.major;
final int minor = version?.minor;
if (globals.platform.isMacOS) {
  /// plugin path of Android Studio changed after version 4.1.
  if (major >= 4 && minor >= 1) {
    ...
```


Can you spot the error? Because the version may be null, both major and minor may be null also. This bug may seem easy to spot here in isolation, but in practice code like this slips through all the time, even with a rigorous code review process like the one used in the Flutter repo. With null safety, static analysis [catches this issue immediately](https://dartpad.dev/0e9797be7488d8ec6c3fca92b7f2740f):

你能发现这个错误吗？由于 version 可能为 null，
major 和 minor 也都可能为 null。孤立地看，这个 bug 似乎很容易发现，
但在实践中，这样的代码总是会被漏掉——即便有 Flutter 仓库那样
严格的代码审查流程。有了空安全，静态分析能
[立即捕获这个问题](https://dartpad.dev/0e9797be7488d8ec6c3fca92b7f2740f)：

<DashImage src="images/0AwqXx58arqVt6PhL.webp" alt="An editor interface showing a compile error because a nullable variable is used without a null check." />


That was a pretty simple error. During our early use of null safety in code internally at Google, we’ve seen much more intricate errors be caught and then resolved via null safety. Here are a few examples:

那是个相当简单的错误。在 Google 内部代码中早期使用空安全时，
我们见过复杂得多的错误被空安全捕获并解决。下面是几个例子：

* An internal team found that they were often checking for null values in code that null safety knew could never be null. This problem was most frequently seen in code using [protobuf](https://developers.google.com/protocol-buffers), where optional fields return a default value when unset, and never null. This caused code to incorrectly check for the default condition, by confusing default values and null values.

  一个内部团队发现，他们经常在空安全确定绝不可能为 null 的代码中
  检查 null 值。这个问题最常见于使用
  [protobuf](https://developers.google.com/protocol-buffers) 的代码：
  可选字段未设置时返回默认值，而绝不会是 null。
  这导致代码混淆了默认值和 null 值，错误地检查默认条件。

* The Google Pay team found bugs in their Flutter code where they would fail when trying to access Flutter `State` objects outside of the context of a `Widget`. Before null safety, those would return null and mask the error; with null safety, the sound analysis determined that those properties could never be null, and threw an analysis error.

  Google Pay 团队在他们的 Flutter 代码中发现了 bug：
  在 `Widget` 上下文之外访问 Flutter `State` 对象时会失败。
  在空安全之前，这些访问会返回 null 并掩盖错误；
  有了空安全，健全的分析确定这些属性绝不可能为 null，
  并抛出分析错误。

* The Flutter team found a bug where the Flutter engine could potentially crash if null was passed to the `scene` parameter in `Window.render()`. During null safety migration, they added a hint to [mark Scene as non-nullable](https://github.com/cbracken/engine/blob/bad869e229a8a02cad6e63d12e80807b33b5c12f/lib/ui/window.dart#L1069), and were then able to easily prevent potential app crashes that null would have triggered if passed.

  Flutter 团队发现了一个 bug：如果向 `Window.render()` 的
  `scene` 参数传入 null，Flutter 引擎可能会崩溃。
  在空安全迁移期间，他们添加了一个提示，
  [将 Scene 标记为非空](https://github.com/cbracken/engine/blob/bad869e229a8a02cad6e63d12e80807b33b5c12f/lib/ui/window.dart#L1069)，
  从而轻松避免了传入 null 可能引发的应用崩溃。

### Leveraging sound null safety during compilation

### 在编译期间利用健全空安全

The soundness of Dart’s null safety has another welcome implication: it means the Dart compilers can leverage the nullability information. This can potentially make your programs smaller and faster. We don’t have a lot of real-world apps fully migrated to sound null safety yet (as we’re just now kicking off the ecosystem migration of packages that these apps depend on for soundness), but we’re seeing very encouraging results from the core framework.

Dart 空安全的健全性还有一个令人欣喜的意义：
Dart 编译器可以利用可空性信息。这有可能让你的程序更小、更快。
目前完全迁移到健全空安全的真实应用还不多
（我们刚刚启动这些应用为保证健全性所依赖的 package 的生态迁移），
但我们已经从核心框架看到了非常鼓舞人心的结果。

We recently did a test recompilation of the [hello_world](https://github.com/flutter/flutter/blob/master/examples/hello_world/lib/main.dart) sample to measure the impact of null safety on app size.This is a minimal example that simply displays “hello world”. In [comparing ](https://gist.github.com/mit-mit/64e160f9dc3bf6c69c7ef2f81384594a)the overall size of the compiled code, the uncompressed (installed on device) code size shrank by 3.5% without doing anything but recompiling with sound null safety. This was possible, despite this app being just 10 lines of code, because the code size of all included libraries shrank; for example the Flutter framework itself (`package:flutter`) shrank by 3.9%.

我们最近对
[hello_world](https://github.com/flutter/flutter/blob/master/examples/hello_world/lib/main.dart)
示例做了一次测试性重新编译，以衡量空安全对应用体积的影响。
这是一个只显示“hello world”的最小示例。
在[比较](https://gist.github.com/mit-mit/64e160f9dc3bf6c69c7ef2f81384594a)
编译后代码的总体积时，除了用健全空安全重新编译之外什么都没做，
未压缩（安装到设备上）的代码体积就缩小了 3.5%。
尽管这个应用只有 10 行代码，这仍然是可能的，
因为所有引入库的代码体积都缩小了；
例如 Flutter 框架本身（`package:flutter`）就缩小了 3.9%。

As for code speed, having to enforce a sound type system potentially adds overhead. However, having fewer null checks also potentially makes the code faster. Our initial analysis of benchmarks shows that performance is on par with previous releases, and that the new additional type information creates the potential for us to do new kinds of performance improvements in the future. We plan on writing more about our performance work in future blog posts.

至于代码运行速度，强制执行健全的类型系统可能会增加开销。
不过，更少的 null 检查也可能让代码更快。
我们对基准测试的初步分析表明，性能与之前的版本持平，
而新增的类型信息为我们未来进行新型性能优化创造了可能。
我们计划在今后的博客文章中更多地介绍性能方面的工作。

In some cases we’ve already seen null safety lead to performance gains, typically when migration to null safety has uncovered a flaw in the code logic. For example, we found an issue in the Flutter web text layout cache. This cache was using a key that was nullable, and then some logic to use `TextAlign.start` when null. This logic caused a flaw in the cache where elements would look like they had changed even though they still had a default value. As a result, there were frequent cache misses. Adding a non-nullable `textAlign` getter helped fix the caching flaw, resulting in a **14x increase** of text rendering performance in cases where the text is cached.

在某些情况下，我们已经看到空安全带来了性能提升，
通常发生在空安全迁移揭示了代码逻辑缺陷的时候。
例如，我们在 Flutter web 的文本布局缓存中发现了一个问题。
该缓存使用了一个可空的键，并配有一些逻辑：
键为 null 时改用 `TextAlign.start`。
这一逻辑导致缓存出现缺陷：即使元素仍是默认值，
看起来也像是发生了变化。结果就是频繁出现缓存未命中。
添加一个非空的 `textAlign` getter 帮助修复了这一缓存缺陷，
使文本命中缓存时的渲染性能**提升了 14 倍**。

## Get started today!

## 今天就开始！

Beta versions of Dart and Flutter that contain null safety are ready today. If you develop with Flutter, you can switch to beta with `flutter channel beta` followed by `flutter upgrade`. Otherwise, you can get the standalone Dart SDK from the [Dart SDK archive](https://dart.dev/tools/sdk/archive#beta-channel).

包含空安全的 Dart 和 Flutter beta 版本今天已经就绪。
如果你使用 Flutter 开发，可以先运行 `flutter channel beta`
再运行 `flutter upgrade` 切换到 beta 渠道。
否则，你可以从
[Dart SDK 存档](https://dart.dev/tools/sdk/archive#beta-channel)
获取独立的 Dart SDK。

If you develop packages, we encourage you to read our [migration guide](https://dart.dev/null-safety/migration-guide) and plan your migration. Please [let us know](https://github.com/dart-lang/sdk/issues/new?title=Null%20safety%20feedback:%20[issue%20summary]&labels=NNBD&body=Describe%20the%20issue%20or%20potential%20improvement%20in%20detail%20here) about any issues or suggestions you have.

如果你开发 package，我们鼓励你阅读
[迁移指南](https://dart.dev/null-safety/migration-guide)并规划你的迁移。
如有任何问题或建议，请[告诉我们](https://github.com/dart-lang/sdk/issues/new?title=Null%20safety%20feedback:%20[issue%20summary]&labels=NNBD&body=Describe%20the%20issue%20or%20potential%20improvement%20in%20detail%20here)。

If you’re an app developer, you may prefer to delay migration until the feature is in our stable channels. We plan on addressing the feedback from beta quickly, fixing any remaining issues. It’s hard to state a concrete timeline for when null safety will be in a stable release, but we’re thinking early next year.

如果你是应用开发者，你可能更愿意等到该特性进入稳定渠道后再迁移。
我们计划快速处理 beta 阶段的反馈，修复所有遗留问题。
很难给出空安全进入稳定版本的具体时间表，但我们预计是明年年初。

Thanks for your support and feedback as we work to make Dart a more robust language, and Flutter a stronger framework!

感谢你的支持与反馈，让我们能把 Dart 打造成更健壮的语言、
把 Flutter 打造成更强大的框架！
