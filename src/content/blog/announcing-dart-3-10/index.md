---
# title: "Announcing Dart 3.10"
title: "宣布 Dart 3.10"
# description: "Today, we’re excited to announce the release of Dart 3.10!"
description: "今天，我们很高兴宣布 Dart 3.10 发布！"
ai-translated: true
publishDate: 2025-11-12
author: antfitch
image: images/1AyAyohCAvBT-ta-nJPrkEg.webp
category: releases
layout: blog
---


<DashImage src="images/1AyAyohCAvBT-ta-nJPrkEg.webp" alt="Dart 3.10 release banner with the Dart logo and a bullseye icon." caption="Announcing Dart 3.10" />


This release continues our focus on improving the core developer experience. The new **dot shorthands** (**`.`**) feature will help you write more readable and less verbose code. We’re also introducing a powerful new **analyzer plugin system** that allows you to create custom static analysis rules that integrate directly into your IDE. And we’re excited to announce that **build hooks** are now stable!

这个版本继续专注于改进核心开发体验。新的**点简写**
（**dot shorthands**，**`.`**）特性能帮你写出更可读、
更不啰嗦的代码。我们还引入了强大的新**分析器插件系统**，
让你能创建直接集成进 IDE 的自定义静态分析规则。
同时我们很高兴宣布：**build hooks** 现在稳定了！

This release also brings several improvements to pub.dev and package management. You’ll find new search capabilities in the **“Likes” tab** in your profile, and package authors can now **disable manual publishing** for improved security. Finally, we’ve added a suite of new, more specific **deprecation annotations** to give you finer-grained control over your API’s evolution.

这个版本还为 pub.dev 和 package 管理带来多项改进。
你会在个人资料的 **“Likes” 标签页**中发现新的搜索能力，
package 作者现在可以**禁用手动发布**以提升安全性。
最后，我们加入了一组新的、更具体的**废弃注解**，
让你对 API 的演进有更细粒度的控制。

Read on to learn more about these and the other improvements in Dart 3.10.

继续阅读，了解这些以及 Dart 3.10 中的其他改进。

## Language updates

## 语言更新

### Dot shorthands 🆕

### 点简写（Dot shorthands）🆕

Dart 3.10 introduces [**dot shorthands**](https://dart.dev/language/dot-shorthands) (`.`). This new feature lets you omit redundant class or enum names when the compiler can infer the type from the context.

Dart 3.10 引入了
[**点简写**](https://dart.dev/language/dot-shorthands)（`.`）。
当编译器能从上下文推断出类型时，
这个新特性让你可以省略冗余的类名或枚举名。

Let’s look at a common scenario: logging. Before, you might have written:

来看一个常见场景：日志。以前你可能会这样写：

```dart
enum LogLevel { info, warning, error, debug }

void logMessage(String message, {LogLevel level = LogLevel.info}) {
  // ... implementation
}

// Somewhere else in your app
logMessage('Failed to connect to database', level: LogLevel.error);
```


Since the `level` parameter already expects a `LogLevel`, repeating the enum name is unnecessary. With dot shorthands, you can now write:

既然 `level` 参数已经期望一个 `LogLevel`，
重复枚举名就没有必要了。有了点简写，你现在可以这样写：

```dart
enum LogLevel { info, warning, error, debug }

void logMessage(String message, {LogLevel level = .info}) {
  // ... implementation
}

// Somewhere else in your app
logMessage('Failed to connect to database', level: .error);
```


The code now focuses on the *value* (`.error`) rather than the *type* (`LogLevel`).

代码现在聚焦于*值*（`.error`），而不是*类型*（`LogLevel`）。

Dot shorthands aren’t just for enums. You can also use them with constructors, static methods, and static fields. To learn more, read our [Dot shorthands](https://dart.dev/language/dot-shorthands) guide.

点简写不只用于枚举。你还可以把它用在构造函数、
静态方法和静态字段上。了解更多请阅读我们的
[点简写](https://dart.dev/language/dot-shorthands)指南。

## Tools updates

## 工具更新

### Analyzer plugins 🆕

### 分析器插件 🆕

Have you ever been reviewing code and thought, “Shouldn’t the analyzer be able to catch that?”. Now it can.

你有没有在 review 代码时想过：“分析器难道不该能抓住这个问题吗？”
现在它可以了。

Dart 3.10 introduces a powerful new plugin system for the Dart analyzer. This allows you to write and use your own static analysis rules that integrate directly into IDEs and command-line tools like `dart analyze` and `flutter analyze`. You can use [analyzer plugins](https://dart.dev/tools/analyzer-plugins) to:

Dart 3.10 为 Dart 分析器引入了强大的新插件系统。
它让你能编写和使用自己的静态分析规则，
直接集成进 IDE 以及 `dart analyze`、`flutter analyze`
等命令行工具。你可以用
[分析器插件](https://dart.dev/tools/analyzer-plugins)来：

* Enforce project-specific rules, such as bespoke lints and warnings to maintain conventions in your team’s codebase.

  强制执行项目特定规则，比如定制 lint 和警告，
  维护团队代码库中的约定。

* Avoid common pitfalls and best practices specific to your domain.

  规避你所在领域特有的常见陷阱，落实最佳实践。

* Automate code changes by providing quick fixes and assists to help automatically correct issues or migrate to new APIs.

  通过提供快速修复和辅助操作来自动化代码变更，
  帮助自动纠正问题或迁移到新 API。

This new system is the result of a significant architectural effort to enable a rich ecosystem of community-driven tools, and we’d like to extend a special thanks to community contributor [Felipe Morschel](https://github.com/FMorschel) for his valuable fixes and features for the analyzer in general.

这个新系统是一次重大架构工作的成果，
旨在促成丰富的社区驱动工具生态。我们要特别感谢社区贡献者
[Felipe Morschel](https://github.com/FMorschel)，
他为分析器整体贡献了宝贵的修复和特性。

To use an analyzer plugin, simply add it to your [analysis_options.yaml](https://dart.dev/tools/analysis#the-analysis-options-file) file:

要使用分析器插件，只需把它加进你的
[analysis_options.yaml](https://dart.dev/tools/analysis#the-analysis-options-file)
文件：

```yaml
analyzer:
  plugins:
    - some_plugin
    - another_plugin
```


To learn more about creating your own custom rules, see the documentation for [writing an analyzer plugin](https://dart.dev/tools/analyzer-plugins).

想了解更多创建自定义规则的内容，请参阅
[编写分析器插件](https://dart.dev/tools/analyzer-plugins)的文档。

### Build hooks 🚀

### Build hooks 🚀

Integrating native code (like C++, Rust, or Swift) into a Dart package has often required managing complex, platform-specific build files like CMake or Gradle. With Dart 3.10, this process is now dramatically simpler.

把原生代码（如 C++、Rust 或 Swift）集成进 Dart package，
往往需要管理 CMake 或 Gradle 等复杂的平台特定构建文件。
有了 Dart 3.10，这个过程现在大大简化了。

We’re excited to announce that **build hooks** (formerly known as native assets) are now stable. You can use these hooks to compile native code or download native assets (like dynamic libraries) and bundle them directly with your Dart package. This powerful capability lets you reuse existing native code or libraries from within your package and eliminates the need to write separate build files such as SPM, Gradle, or CMake for different operating systems.

我们很高兴宣布：**build hooks**（以前称为 native assets）
现在稳定了。你可以用这些 hook 编译原生代码，
或下载原生资产（如动态库），并直接把它们与 Dart package
打包在一起。这项强大的能力让你在 package 内复用既有的
原生代码或库，并且不再需要为不同操作系统编写
SPM、Gradle 或 CMake 等单独的构建文件。

To learn more, see the documentation for [writing a build hook](https://dart.dev/tools/hooks), or watch the [Flutter Build show episode](https://www.youtube.com/watch?v=AxNF5dj8HWQ) on build hooks.

了解更多请参阅[编写 build hook](https://dart.dev/tools/hooks)
的文档，或观看关于 build hooks 的
[Flutter Build show 节目](https://www.youtube.com/watch?v=AxNF5dj8HWQ)。

### Remove Deprecations lint 🆕

### 移除废弃项 lint 🆕

When you release a new major version of a package (like 1.0.0 or 0.2.0), it’s a best practice to remove any APIs you previously marked as deprecated. This keeps your package clean and prevents developers from using outdated code. However, it’s easy to forget this step during the release process.

当你发布 package 的新主版本（如 1.0.0 或 0.2.0）时，
最佳实践是移除之前标记为废弃的所有 API。
这能让 package 保持整洁，防止开发者使用过时的代码。
但在发布过程中很容易忘记这一步。

To help, we’ve introduced a new lint: [**`remove_deprecations_in_breaking_versions`**](https://dart.dev/tools/linter-rules/remove_deprecations_in_breaking_versions/). This lint detects leftover deprecated elements when a package’s version is updated to a new major breaking version. By flagging these cases, the lint helps ensure that your package’s API remains modern and easy for your users to understand.

为此，我们引入了一个新 lint：
[**`remove_deprecations_in_breaking_versions`**](https://dart.dev/tools/linter-rules/remove_deprecations_in_breaking_versions/)。
当 package 版本更新到新的破坏性主版本时，
这个 lint 会检测残留的废弃元素。通过标记这些情况，
它帮助确保你的 package API 保持现代、易于用户理解。

<DashImage src="images/1keU2TVVnlbe0e0UFtj3mwA.webp" alt="Example for the remove deprecations in breaking versions lint." caption="**`remove_deprecations_in_breaking_versions lint example`**" />


### @Deprecated annotation ⬆️

### @Deprecated 注解 ⬆️

The existing **@Deprecated** annotation is a blunt instrument. It informs developers that an API is no longer recommended, but it doesn’t allow for nuance. For example, how do you signal that a class should no longer be extended, but can still be instantiated?

现有的 **@Deprecated** 注解是个粗粒度工具。
它告诉开发者某个 API 不再推荐使用，但无法表达细微差别。
例如，你怎么表示一个类不应再被继承（extend），
但仍然可以被实例化？

To give package authors more precise control over their API’s evolution, Dart 3.10 introduces a suite of new, more specific deprecation annotations.

为了让 package 作者对 API 演进有更精确的控制，
Dart 3.10 引入了一组新的、更具体的废弃注解。

You can now deprecate specific use cases for classes and mixins:

你现在可以废弃类和 mixin 的特定用法：

* [@Deprecated.extend()](https://api.dart.dev/dev/latest/dart-core/Deprecated/Deprecated.extend.html): The ability to extend a class is deprecated.

  [@Deprecated.extend()](https://api.dart.dev/dev/latest/dart-core/Deprecated/Deprecated.extend.html)：
  继承（extend）某个类的能力被废弃。

* [@Deprecated.implement()](https://api.dart.dev/dev/latest/dart-core/Deprecated/Deprecated.implement.html): The ability to implement a class or mixin is deprecated.

  [@Deprecated.implement()](https://api.dart.dev/dev/latest/dart-core/Deprecated/Deprecated.implement.html)：
  实现（implement）某个类或 mixin 的能力被废弃。

* [@Deprecated.subclass()](https://api.dart.dev/dev/latest/dart-core/Deprecated/Deprecated.subclass.html): The ability to subclass (extend or implement) a class or mixin is deprecated.

  [@Deprecated.subclass()](https://api.dart.dev/dev/latest/dart-core/Deprecated/Deprecated.subclass.html)：
  派生子类（extend 或 implement）某个类或 mixin 的能力被废弃。

* [@Deprecated.mixin()](https://api.dart.dev/dev/latest/dart-core/Deprecated/Deprecated.mixin.html): The ability to mix in a class is deprecated.

  [@Deprecated.mixin()](https://api.dart.dev/dev/latest/dart-core/Deprecated/Deprecated.mixin.html)：
  混入（mix in）某个类的能力被废弃。

* [@Deprecated.instantiate()](https://api.dart.dev/dev/latest/dart-core/Deprecated/Deprecated.instantiate.html): The ability to instantiate a class is deprecated.

  [@Deprecated.instantiate()](https://api.dart.dev/dev/latest/dart-core/Deprecated/Deprecated.instantiate.html)：
  实例化某个类的能力被废弃。

Additionally, you can now signal that an optional parameter will become required in a future version using [@Deprecated.optional()](https://api.dart.dev/dev/latest/dart-core/Deprecated/Deprecated.optional.html).

此外，你现在可以用
[@Deprecated.optional()](https://api.dart.dev/dev/latest/dart-core/Deprecated/Deprecated.optional.html)
表示某个可选参数将在未来版本中变为必需。

## Pub updates

## Pub 更新

### Search, sort, and unlike support for your favorite packages 🆕

### 收藏 package 的搜索、排序与取消点赞支持 🆕

Managing your favorite packages on pub.dev just got a major upgrade. You can do this through the Search feature or the [Likes tab](https://pub.dev/my-liked-packages) on your profile, where you can now search, sort, and filter your liked packages with the same familiar controls you use for regular searches. This includes sorting by likes, pub points, and popularity. We’ve also improved the UI for unliking packages, making it easier than ever to keep your list of liked packages tidy and up-to-date.

在 pub.dev 上管理你收藏的 package 迎来重大升级。
你可以通过搜索功能或个人资料中的
[Likes 标签页](https://pub.dev/my-liked-packages)来管理，
现在可以用与普通搜索相同的熟悉控件，
对点赞过的 package 进行搜索、排序和筛选，
包括按点赞数、pub 分数和流行度排序。
我们还改进了取消点赞的 UI，
让你比以往更容易保持点赞列表整洁、最新。

<DashImage src="images/1cOONo9VV-HsJPA0WMv1COQ.webp" alt="Pub.dev Likes tab with search, sort, and unlike support." caption="Search, sort, and unlike support for your favorite packages in your Likes tab" />


If you choose to search for your liked packages with the Search feature, simply add `is:liked-by-me` to your query.

如果你选择用搜索功能查找点赞过的 package，
只需在查询中加上 `is:liked-by-me`。

<DashImage src="images/1cO5K265sp2QbF-vNgcpFzQ.webp" alt="Pub.dev search page filtered to packages you liked." caption="Search, but only include packages you like" />


### Enable or disable manual publishing 🆕

### 启用或禁用手动发布 🆕

To enhance security and prevent accidental publications, you can now disable manual publishing (pub publish) for your packages. This is ideal for packages that have an automated publishing workflow or are no longer being actively published.

为了增强安全性、防止意外发布，
你现在可以为 package 禁用手动发布（pub publish）。
这非常适合已有自动化发布流程、
或不再积极发布的 package。

By disabling manual publishing, you prevent package updates using personal credentials, reducing the risk of an unauthorized or accidental release.

禁用手动发布后，就无法用个人凭据更新 package，
降低了未经授权或意外发布的风险。

You can control this feature in your package’s **Admin** tab using the “Enable manual publishing” checkbox.

你可以在 package 的 **Admin** 标签页中，
用 “Enable manual publishing” 复选框控制这个特性。

<DashImage src="images/1qBE5Jhe138ktNrcBIy5L1w.webp" alt="Enable or disable manual publishing in the Admin tab." caption="Enable or disable manual publishing in the Admin tab" />


## Wrap up

## 总结

The Dart 3.10 release brings a host of improvements focused on developer productivity, tooling, and the overall health of the package ecosystem. From language features like dot shorthands that make your code more concise, to powerful new tooling capabilities like analyzer plugins and stable build hooks, we hope this release empowers you to build even better apps.

Dart 3.10 版本带来大量改进，聚焦开发者生产力、
工具以及 package 生态的整体健康。从让代码更简洁的
点简写等语言特性，到分析器插件和稳定的 build hooks
等强大的新工具能力，我们希望这个版本能助你构建更好的应用。

We’re incredibly grateful for the many engineers and teams who contributed to this release, including a special thanks to our community contributors who help make Dart better for everyone.

我们非常感谢为这个版本做出贡献的众多工程师和团队，
特别感谢让 Dart 对每个人都更好的社区贡献者们。

We’re excited to see what you build with Dart 3.10. To get started, you can get the Dart 3.10 SDK today. For a complete list of all the new and updated features, check out the [Dart SDK changelog](https://github.com/dart-lang/sdk/blob/main/CHANGELOG.md).

我们期待看到你用 Dart 3.10 构建的作品。现在就可以获取
Dart 3.10 SDK 开始上手。所有新增和更新特性的完整列表，
请查看 [Dart SDK 更新日志](https://github.com/dart-lang/sdk/blob/main/CHANGELOG.md)。
