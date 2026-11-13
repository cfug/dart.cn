---
# title: What's new
title: "新内容"
# description: A list of what's new on dart.dev and related sites.
description: "dart.dev 及相关网站的新内容列表。"
ai-translated: true
lastVerified: 2026-08-12
---

This page describes what's new on the Dart website and blog.
To see what's new in Flutter, visit the
[Flutter what's new page.][flutter-whats-new]

本页介绍 Dart 网站和博客的新内容。
想了解 Flutter 的新内容，请访问
[Flutter 的新内容页面][flutter-whats-new]。

For a list of Dart language changes in each Dart SDK, see the
[Dart changelog][dart-changelog].
To stay on top of announcements, including breaking changes,
join the [Dart announcements Google group][dart-announce]
and follow the [Dart blog][].

要查看每个 Dart SDK 中的 Dart 语言变更列表，请参阅
[Dart 更新日志][dart-changelog]。
想第一时间了解包括破坏性变更在内的公告，
请加入 [Dart 公告 Google 群组][dart-announce]
并关注 [Dart 博客][Dart blog]。

[flutter-whats-new]: {{site.flutter-docs}}/whats-new
[dart-changelog]: /changelog
[dart-announce]: https://groups.google.com/a/dartlang.org/d/forum/announce
[Dart blog]: /blog

## 3.13 release

## 3.13 版本发布

_Released on: August 12, 2026_

_发布日期：2026 年 8 月 12 日_

This section lists notable changes made from May 18, 2026,
through August 12, 2026 to [dart.dev](https://dart.dev/docs).
For details about the 3.13 release of Dart,
check out the [3.13 announcement][] and the
[3.13 SDK changelog][3-13-changelog].

本节列出 2026 年 5 月 18 日至 2026 年 8 月 12 日期间
[dart.dev](https://dart.dev/docs) 的重要变更。
有关 Dart 3.13 版本的详细信息，
请查看 [3.13 发布公告][3.13 announcement]和
[3.13 SDK 更新日志][3-13-changelog]。

[3.13 announcement]: /blog/announcing-dart-3-13
[3-13-changelog]: {{site.repo.dart.sdk}}/blob/main/CHANGELOG.md#3130

### Documentation updates {:.no_toc}

### 文档更新 {:.no_toc}

* Expanded documentation for the new [primary constructors][] language feature,
  including sections on enums and constant constructors.

  - 扩充了新语言特性[主构造函数][primary constructors]的文档，
    新增枚举和常量构造函数相关小节。
* Added a new troubleshooting guide on
  [reasons why a variable can't be promoted][non-promotion reasons]
  to help diagnose type promotion failures.

  - 新增一份故障排查指南，介绍
    [变量无法提升的原因][non-promotion reasons]，
    帮助诊断类型提升失败的问题。
* Recommended declaring constructors inside classes using the new
  [concise constructor syntax][concise constructor syntax] in Effective Dart.

  - 在 Effective Dart 中建议使用新的
    [简洁构造函数语法][concise constructor syntax]在类内部声明构造函数。
* Expanded documentation for native build hooks to cover
  [configuring user-defines][user-defines] in `pubspec.yaml` and using
  [link hooks][link hooks] with recorded usage for native code tree-shaking.

  - 扩充原生构建钩子文档，涵盖在 `pubspec.yaml` 中
    [配置 user-defines][user-defines]，以及结合使用记录
    通过[链接钩子][link hooks]对原生代码进行 tree-shaking。
* Detailed WebAssembly runtime type check behavior and added Zone-binding
  examples to the [JavaScript and Web interop][js interop] documentation.

  - 在 [JavaScript 与 Web 互操作][js interop]文档中
    详细说明了 WebAssembly 运行时类型检查行为，
    并新增 Zone 绑定示例。
* Documented experimental
  [deferred loading support for WebAssembly][wasm deferred loading].

  - 记录了实验性的
    [WebAssembly 延迟加载支持][wasm deferred loading]。
* Unified Dart command-line distribution documentation
  around [`dart install`][dart install].

  - 围绕 [`dart install`][dart install]
    统一了 Dart 命令行分发文档。
* Clarified the distinction between `Error` and `Exception` instances
  in the [error handling tutorial][error handling tutorial].

  - 在[错误处理教程][error handling tutorial]中
    澄清了 `Error` 与 `Exception` 实例的区别。
* Added beginner-friendly links and quick tips
  to the [documentation overview page][overview].
  (Thank you, [Syed Muhammad Mobasil][Mobasil-Git].)

  - 在[文档概览页面][overview]新增适合新手的链接和快速提示。
    （感谢 [Syed Muhammad Mobasil][Mobasil-Git]。）
* Updated guidelines on [naming methods and functions][naming methods]
  in Effective Dart.
  (Thank you, [Polina Cherkasova][polina-c].)

  - 更新了 Effective Dart 中关于
    [方法和函数命名][naming methods]的指南。
    （感谢 [Polina Cherkasova][polina-c]。）
* Added [Publy][] to the list of hosted
  [Dart package repository services][package repositories].
  (Thank you, [Timophei Lemeshchenko][Another1dd].)

  - 将 [Publy][Publy] 添加到托管
    [Dart package 仓库服务][package repositories]列表中。
    （感谢 [Timophei Lemeshchenko][Another1dd]。）
* Expanded the [Glossary][] with new language and web terms
  including "[dot shorthand][]", "[extension type][]",
  "[primary constructor][]", "[private named parameter][]",
  "[potentially constant][]", and "[WebAssembly (Wasm)][]".

  - 扩充[术语表][Glossary]，新增语言和 Web 术语，
    包括“[点简写][dot shorthand]”、“[扩展类型][extension type]”、
    “[主构造函数][primary constructor]”、“[私有命名参数][private named parameter]”、
    “[潜在常量][potentially constant]”和“[WebAssembly (Wasm)][WebAssembly (Wasm)]”。

[primary constructors]: /language/primary-constructors
[non-promotion reasons]: /tools/non-promotion-reasons
[concise constructor syntax]: /effective-dart/usage#prefer-using-concise-constructor-syntax
[user-defines]: /tools/hooks#hook-configuration
[link hooks]: /tools/hooks#create-link-hook
[js interop]: /interop/js-interop/js-types
[wasm deferred loading]: /web/wasm#webassembly-support
[dart install]: /tools/dart-install
[error handling tutorial]: /learn/tutorial/error-handling
[overview]: /overview
[naming methods]: /effective-dart/design#avoid-starting-a-method-name-with-get
[Publy]: https://publy.dev
[package repositories]: /tools/pub/custom-package-repositories
[Glossary]: /resources/glossary
[dot shorthand]: /resources/glossary#dot-shorthand
[extension type]: /resources/glossary#extension-type
[primary constructor]: /resources/glossary#primary-constructor
[private named parameter]: /resources/glossary#private-named-parameter
[potentially constant]: /resources/glossary#potentially-constant
[WebAssembly (Wasm)]: /resources/glossary#webassembly-wasm

[Mobasil-Git]: https://github.com/Mobasil-Git
[polina-c]: https://github.com/polina-c
[Another1dd]: https://github.com/Another1dd

## 3.12 release

## 3.12 版本发布

_Released on: May 18, 2026_

_发布日期：2026 年 5 月 18 日_

This section lists notable changes made from February 12, 2026,
through May 18, 2026 to [dart.dev](https://dart.dev/docs).
For details about the 3.12 release of Dart,
check out the [3.12 announcement][] and the
[3.12 SDK changelog][3-12-changelog].

本节列出 2026 年 2 月 12 日至 2026 年 5 月 18 日期间
[dart.dev](https://dart.dev/docs) 的重要变更。
有关 Dart 3.12 版本的详细信息，
请查看 [3.12 发布公告][3.12 announcement]和
[3.12 SDK 更新日志][3-12-changelog]。

[3.12 announcement]: /blog/announcing-dart-3-12
[3-12-changelog]: {{site.repo.dart.sdk}}/blob/main/CHANGELOG.md#3120

### Documentation updates {:.no_toc}

### 文档更新 {:.no_toc}

* Added documentation for the new [private named parameters][] language feature.

  - 为新语言特性[私有命名参数][private named parameters]添加了文档。
* Added documentation for the experimental [primary constructors][] language
  feature.

  - 为实验性语言特性[主构造函数][primary constructors]
    添加了文档。
* Created a dedicated [language versioning][] page and updated links across
  the site.

  - 创建了专门的[语言版本][language versioning]页面，
    并更新了全站的链接。
* Documented Dart support for [Firebase Functions][] and the Admin SDK.

  - 记录了 Dart 对 [Firebase Functions][Firebase Functions] 和 Admin SDK 的支持。
* Documented that [pub workspaces][] can be nested.
  (Thank you, [Soufian El-Fouzari][SoufianElfouzari].)

  - 记录了 [pub 工作区][pub workspaces]可以嵌套。
    （感谢 [Soufian El-Fouzari][SoufianElfouzari]。）
* Documented the [`--no-example`][] option of pub commands.

  - 记录了 pub 命令的 [`--no-example`][`--no-example`] 选项。
* Centralized documentation for pub [package descriptors][].

  - 集中整理了 pub [package 描述符][package descriptors]的文档。
* Added documentation for constraints on [code asset dylib names][] for build
  hooks.

  - 新增构建钩子中
    [代码资源 dylib 名称][code asset dylib names]约束的文档。
* Updated the [object-oriented programming lesson][] of the tutorial and
  enhanced its formatting.

  - 更新了教程中的[面向对象编程课程][object-oriented programming lesson]，
    并改进了排版。
* Expanded the [Glossary][] with new terms including "top type", "null safety",
  "sound", "reified generics", and "uninitialized".
  (Thank you, [IldySilva][].)

  - 扩充[术语表][Glossary]，新增术语，包括“顶层类型”（top type）、
    “空安全”（null safety）、“健全”（sound）、
    “具化泛型”（reified generics）和“未初始化”（uninitialized）。
    （感谢 [IldySilva][IldySilva]。）
* Added more [community interop solutions][] to the documentation.
  (Thank you, [ANUSHREE BONDIA][Anushreebasics].)

  - 在文档中添加了更多[社区互操作方案][community interop solutions]。
    （感谢 [ANUSHREE BONDIA][Anushreebasics]。）
* Removed and archived the legacy [null safety migration][] documentation.

  - 移除并归档了旧的[空安全迁移][null safety migration]文档。

### Site improvements {:.no_toc}

### 网站改进 {:.no_toc}

* Added a dedicated space for the [Dart blog][Dart blog space] at `/blog`,
  migrating all historical posts from Medium.

  - 在 `/blog` 为 [Dart 博客][Dart blog space]设立了专属空间，
    并从 Medium 迁移了所有历史文章。
* Implemented page prefetching and prerendering for faster navigation across
  the site.

  - 实现了页面预取和预渲染，让全站导航更快。

[primary constructors]: /language/primary-constructors
[private named parameters]: /language/constructors#private-named-parameters
[language versioning]: /language/versioning
[Firebase Functions]: /server/google-cloud#cloud-functions-for-firebase
[pub workspaces]: /tools/pub/workspaces#nested-workspaces
[`--no-example`]: /tools/pub/cmd/pub-get#no-example
[package descriptors]: /tools/pub/dependencies#package-descriptors
[code asset dylib names]: /tools/hooks#create-hook
[object-oriented programming lesson]: /learn/tutorial/object-oriented
[Glossary]: /resources/glossary
[top type]: /resources/glossary#top-type
[null safety]: /resources/glossary#null-safety
[sound]: /resources/glossary#sound
[reified generics]: /resources/glossary#reified-generics
[uninitialized]: /resources/glossary#uninitialized
[community interop solutions]: /interop#community-interop
[null safety migration]: https://github.com/dart-community/migrate-to-null-safety
[Dart blog space]: /blog

[SoufianElfouzari]: https://github.com/SoufianElfouzari
[IldySilva]: https://github.com/IldySilva
[Anushreebasics]: https://github.com/Anushreebasics

## 3.11 release

## 3.11 版本发布

_Released on: February 11, 2026_

_发布日期：2026 年 2 月 11 日_

This section lists notable changes made from November 13, 2025,
through February 11, 2026 to [dart.dev](https://dart.dev/docs).
For details about the 3.11 release of Dart,
check out the [3.11 announcement][] and the
[3.11 SDK changelog][3-11-changelog].

本节列出 2025 年 11 月 13 日至 2026 年 2 月 11 日期间
[dart.dev](https://dart.dev/docs) 的重要变更。
有关 Dart 3.11 版本的详细信息，
请查看 [3.11 发布公告][3.11 announcement]和
[3.11 SDK 更新日志][3-11-changelog]。

[3.11 announcement]: /blog/announcing-dart-3-11
[3-11-changelog]: {{site.repo.dart.sdk}}/blob/main/CHANGELOG.md#3110

### Documentation updates {:.no_toc}

### 文档更新 {:.no_toc}

*   Launched a new [getting started experience][learn] for learning Dart.

  - 推出了学习 Dart 的全新[入门体验][learn]。
*   Updated the [IntelliJ & Android Studio page][] following the transition
    of the Dart plugin to the Dart team.

  - 在 Dart 插件转由 Dart 团队维护后，
    更新了 [IntelliJ 与 Android Studio 页面][IntelliJ & Android Studio page]。
*   Added documentation about the environment variables available
    to Dart's [build hooks][].

  - 新增文档，介绍 Dart [构建钩子][build hooks]
    可用的环境变量。
*   Included "Format on save" setup instructions for IDEs
    on the [dart format][] page.
    (Thank you, [Anushree Bondia](https://github.com/Anushreebasics).)

  - 在 [dart format][dart format] 页面加入了
    IDE“保存时格式化”的设置说明。
    （感谢 [Anushree Bondia](https://github.com/Anushreebasics)。）
*   Expanded the [Glossary][] with new terms including "dependency graph",
    "AOT", "JIT", "interop", and "scope".
    (Thank you, [IldySilva](https://github.com/IldySilva)
    and [Anushree Bondia](https://github.com/Anushreebasics).)

  - 扩充[术语表][Glossary]，新增术语，包括“依赖图”（dependency graph）、
    “AOT”、“JIT”、“互操作”（interop）和“作用域”（scope）。
    （感谢 [IldySilva](https://github.com/IldySilva)
    和 [Anushree Bondia](https://github.com/Anushreebasics)。）

[learn]: /learn
[Glossary]: /resources/glossary
[IntelliJ & Android Studio page]: /tools/jetbrains-plugin
[build hooks]: /tools/hooks
[dart format]: /tools/dart-format

## 3.10 release

## 3.10 版本发布

_Released on: November 12, 2025_

_发布日期：2025 年 11 月 12 日_

This section lists notable changes made from August 14, 2025,
through November 12, 2025 to [dart.dev](https://dart.dev/docs).
For details about the 3.10 release of Dart,
check out the [3.10 announcement][] and the
[3.10 SDK changelog][3-10-changelog].

本节列出 2025 年 8 月 14 日至 2025 年 11 月 12 日期间
[dart.dev](https://dart.dev/docs) 的重要变更。
有关 Dart 3.10 版本的详细信息，
请查看 [3.10 发布公告][3.10 announcement]和
[3.10 SDK 更新日志][3-10-changelog]。

[3.10 announcement]: /blog/announcing-dart-3-10
[3-10-changelog]: {{site.repo.dart.sdk}}/blob/main/CHANGELOG.md#3100

### Documentation updates {:.no_toc}

### 文档更新 {:.no_toc}

*   Added a guide for the new [dot shorthands][] language feature.

  - 为新语言特性[点简写][dot shorthands]添加了指南。
*   Added a guide for the new [analyzer plugin][] support.

  - 为新的[分析器插件][analyzer plugin]支持添加了指南。
*   Added a reference for the [`dart build`][] tool.

  - 添加了 [`dart build`][`dart build`] 工具的参考文档。
*   Added a reference for the [`dart install`][] tool.

  - 添加了 [`dart install`][`dart install`] 工具的参考文档。
*   Documented the new [`@Deprecated` annotation][] varieties.

  - 记录了新的 [`@Deprecated` 注解][`@Deprecated` annotation]变体。
*   Expanded the [Glossary][] with new terms including "obviously typed",
    "closurization", "callback", "tree shaking", and "native asset".
    (Thank you, [IldySilva](https://github.com/IldySilva))

  - 扩充[术语表][Glossary]，新增术语，包括“显类型”（obviously typed）、
    “闭包化”（closurization）、“回调”（callback）、
    “tree shaking”和“原生资源”（native asset）。
    （感谢 [IldySilva](https://github.com/IldySilva)）

[dot shorthands]: /language/dot-shorthands
[analyzer plugin]: /tools/analyzer-plugins
[`dart build`]: /tools/dart-build
[`dart install`]: /tools/dart-install
[`@Deprecated` annotation]: /language/metadata
[Glossary]: /resources/glossary

### Site improvements {:.no_toc}

### 网站改进 {:.no_toc}

*   Migrated core site infrastructure to the [Jaspr framework][Jaspr migration]
    for an improved contributor experience.

  - 将网站核心基础设施迁移到 [Jaspr 框架][Jaspr migration]，
    改善贡献者体验。
*   Enhanced the Glossary with new [filtering by label][Glossary filtering]
    and [tooltips][Glossary tooltips].

  - 为术语表新增[按标签筛选][Glossary filtering]
    和[工具提示][Glossary tooltips]功能。
*   Redesigned the [Community page][Community page redesign] with a modern
    card-based layout.

  - 用现代化的卡片式布局
    重新设计了[社区页面][Community page redesign]。
*   Started compiling client-side Dart code to [Wasm][Wasm compilation].

  - 开始将客户端 Dart 代码编译为 [Wasm][Wasm compilation]。

[Jaspr migration]: https://jaspr.site
[Table of Contents extension]: {{site.repo.this}}/pull/6886
[Glossary filtering]: {{site.repo.this}}/pull/6945
[Glossary tooltips]: {{site.repo.this}}/pull/6969
[Community page redesign]: {{site.repo.this}}/pull/6900
[Wasm compilation]: {{site.repo.this}}/pull/6953

### Articles added to the Dart blog {:.no_toc}

### Dart 博客新增文章 {:.no_toc}

We published the following articles on the Dart blog:

我们在 Dart 博客上发布了以下文章：

* [Google Summer of Code 2025 Results][blog-10-21-25]

  - [Google Summer of Code 2025 成果][blog-10-21-25]

[blog-10-21-25]: /blog/google-summer-of-code-2025-results

## 3.9 release

## 3.9 版本发布

_Released on: August 13, 2025_

_发布日期：2025 年 8 月 13 日_

This section lists notable changes made from May 20, 2025,
through August 13, 2025 to [dart.dev](https://dart.dev/docs).
For details about the 3.9 release of Dart,
check out the [3.9 announcement][] and the
[3.9 SDK changelog][3-8-changelog].

本节列出 2025 年 5 月 20 日至 2025 年 8 月 13 日期间
[dart.dev](https://dart.dev/docs) 的重要变更。
有关 Dart 3.9 版本的详细信息，
请查看 [3.9 发布公告][3.9 announcement]和
[3.9 SDK 更新日志][3-8-changelog]。

### Docs updated or added to dart.dev {:.no_toc}

### dart.dev 文档更新与新增 {:.no_toc}

In addition to bug fixes and incremental improvements,
we made the following changes to docs on this site:

除 bug 修复和渐进式改进外，
我们还对本站文档做了以下变更：

* [Enabled breadcrumbs by default][] across the site.

  - 在全站[默认启用面包屑导航][Enabled breadcrumbs by default]。
* Updated [`dart compile` documentation][] for cross-compiling to ARM and
  RISC-V64.

  - 更新了 [`dart compile` 文档][`dart compile` documentation]，
    涵盖交叉编译到 ARM 和 RISC-V64。
* Overhauled [metadata and annotations documentation][].

  - 全面改写了[元数据与注解文档][metadata and annotations documentation]。
* Restructured the [`dart create` page][] to better explain templates.

  - 重组了 [`dart create` 页面][`dart create` page]，更好地解释模板。
* Added a comprehensive [Dart MCP Server guide][].

  - 添加了全面的 [Dart MCP Server 指南][Dart MCP Server guide]。
* Expanded the [glossary][] with "combinator", "bottom type", "context type",
  "shadowing", "immutable", "wildcard", "late", "zone", and
  "type alias". (Thank you, [IldySilva](https://github.com/IldySilva))

  - 扩充[术语表][glossary]，新增“组合器”（combinator）、
    “底类型”（bottom type）、“上下文类型”（context type）、
    “遮蔽”（shadowing）、“不可变”（immutable）、“通配符”（wildcard）、
    “late”、“zone”和“类型别名”（type alias）。
    （感谢 [IldySilva](https://github.com/IldySilva)）
* Updated [JNIGen documentation][] to remove an outdated Maven reference.

  - 更新了 [JNIGen 文档][JNIGen documentation]，移除过时的 Maven 引用。

[JNIGen documentation]: /interop/java-interop
[`dart compile` documentation]: /tools/dart-compile
[Dart MCP Server guide]: {{site.flutter-docs}}/ai/mcp-server
[`dart create` page]: /tools/dart-create
[metadata and annotations documentation]: /language/metadata
["external resource type"]: {{site.repo.this}}/pull/6762
[Enabled breadcrumbs by default]: {{site.repo.this}}/pull/6767
[glossary]: /resources/glossary

[3.9 announcement]: /blog/announcing-dart-3-9
[3-9-changelog]: {{site.repo.dart.sdk}}/blob/main/CHANGELOG.md#390

## 3.8 release

## 3.8 版本发布

_Released on: May 20, 2025_

_发布日期：2025 年 5 月 20 日_

This section lists notable changes made from February 13, 2025,
through May 20, 2025 to [dart.dev](https://dart.dev/docs).
For details about the 3.8 release of Dart,
check out the [3.8 announcement][] and the
[3.8 SDK changelog][3-8-changelog].

本节列出 2025 年 2 月 13 日至 2025 年 5 月 20 日期间
[dart.dev](https://dart.dev/docs) 的重要变更。
有关 Dart 3.8 版本的详细信息，
请查看 [3.8 发布公告][3.8 announcement]和
[3.8 SDK 更新日志][3-8-changelog]。

### Docs updated or added to dart.dev {:.no_toc}

### dart.dev 文档更新与新增 {:.no_toc}

In addition to bug fixes and incremental improvements,
we made the following changes to docs on this site:

除 bug 修复和渐进式改进外，
我们还对本站文档做了以下变更：

* Added [Collection elements][3-8-c-elements] docs,
  which includes the various types of collection elements,
  including expression elements, map entry elements,
  spread elements, null-aware spread elements, if elements,
  for elements. The new docs also explain how to nest
  elements.

  - 新增[集合元素][3-8-c-elements]文档，涵盖各种类型的集合元素，
    包括表达式元素、map 条目元素、展开元素、空感知展开元素、
    if 元素和 for 元素。新文档还解释了如何嵌套元素。

* Added [Doc imports][] docs, which explains how to use the
  `@docImport` documentation tag to reference external
  elements in documentation comments.

  - 新增[文档导入][Doc imports]文档，解释如何使用 `@docImport`
    文档标签在文档注释中引用外部元素。

* Added [Cross-compilation][] docs for the `dart compile`
  command. Cross-compilation to Linux x64 and ARM64 is now
  supported on the following 64-bit host operating systems:
  macOS, Windows, and Linux.

  - 为 `dart compile` 命令新增[交叉编译][Cross-compilation]文档。
    现在支持在以下 64 位宿主操作系统上交叉编译到 Linux x64 和 ARM64：
    macOS、Windows 和 Linux。

* Added [Null-aware elements][3-8-null-aware] docs, which
  explain how to use the null-aware element.

  - 新增[空感知元素][3-8-null-aware]文档，
    解释如何使用空感知元素。

* Added [Labels][] docs for loops. This addition shows how
  to use labels with `break` and `continue`
  control flow statements.

  - 为循环新增[标签][Labels]文档，展示如何将标签与
    `break` 和 `continue` 控制流语句配合使用。

* Added documentation for the [`pubspec_overrides.yaml`][]
  file. This file lets you override certain aspects of
  the `pubspec.yaml` file without changing the
  `pubspec.yaml` file.

  - 新增 [`pubspec_overrides.yaml`][`pubspec_overrides.yaml`] 文件的文档。
    该文件让你无需修改 `pubspec.yaml` 文件
    即可覆盖它的某些内容。

* Added [Inference using bounds][] docs for the
  type system.

  - 为类型系统新增[基于边界的推断][Inference using bounds]文档。

* Added [Records as simple data structures][] docs for
  record types.

  - 为记录类型新增
    [把记录用作简单数据结构][Records as simple data structures]文档。

* Added [Self-referential type parameter restrictions (F-bounds)][]
  docs for generic types.

  - 为泛型新增
    [自引用类型参数约束（F-bounds）][Self-referential type parameter restrictions (F-bounds)]文档。

* Added [Implicit downcast from `dynamic`][] docs which
  explain how to implicitly cast expressions with a static
  type of `dynamic` to a more specific type.

  - 新增[从 `dynamic` 隐式向下转型][Implicit downcast from `dynamic`]文档，
    解释如何把静态类型为 `dynamic` 的表达式
    隐式转换为更具体的类型。

* Added a [support policy][] for the Dart SDK.

  - 为 Dart SDK 添加了[支持政策][support policy]。

* Updated the guidance for when and when not to use
  class modifiers in the [Effective Dart Design][] guide.

  - 更新了 [Effective Dart 设计][Effective Dart Design]指南中
    关于何时使用、何时不使用类修饰符的建议。

* Updated the guidance to prefer a noun phrase or
  non-imperative verb phrase for a function or method in the
  [Effective Dart Documentation][] guide. Also included
  several small changes to existing documentation guidance.
  For more information, see [PR 6522][].

  - 更新了 [Effective Dart 文档][Effective Dart Documentation]指南中的建议：
    函数或方法优先使用名词短语或非祈使语气的动词短语。
    还对现有文档指南做了若干小改动。
    更多信息见 [PR 6522][PR 6522]。

* Changed the guidance to prefer a noun phrase or
  non-imperative verb phrase for a function or method in the
  [Effective Dart Documentation][] guide.

  - 修改了 [Effective Dart 文档][Effective Dart Documentation]指南中的建议：
    函数或方法优先使用名词短语或非祈使语气的动词短语。

### Site changes for dart.dev {:.no_toc}

### dart.dev 网站变更 {:.no_toc}

In addition to bug fixes and incremental improvements,
we made the following structural changes to this site:

除 bug 修复和渐进式改进外，
我们还对本站做了以下结构性变更：

* Added a new card-based design and the ability to search
  for entries in the [glossary][].

  - 为[术语表][glossary]新增卡片式设计和条目搜索功能。

  <img src="/assets/img/whats-new/3-8-glossary.png" alt="Glossary" style="width:50%">

* New previous and next page buttons for the docs site.

  - 文档网站新增上一页和下一页按钮。

  <img src="/assets/img/whats-new/3-8-prev-next-buttons-new.png" alt="New page buttons" style="width:80%">

* Added individual pages for some [diagnostic messages][].
  To see an individual page for a diagnostic message, select
  its **Learn more** button.

  - 为部分[诊断消息][diagnostic messages]添加了独立页面。
    要查看某条诊断消息的独立页面，
    请点击其 **Learn more** 按钮。

  <img src="/assets/img/whats-new/3-8-diagnostic-docs.png" alt="Learn more button" style="width:50%">

[3.8 announcement]: /blog/announcing-dart-3-8
[3-8-changelog]: {{site.repo.dart.sdk}}/blob/main/CHANGELOG.md#380
[3-8-c-elements]: /language/collections#collection-elements
[3-8-null-aware]: /language/collections#null-aware-element
[glossary]: /resources/glossary
[Records as simple data structures]: /language/records#records-as-simple-data-structures
[Self-referential type parameter restrictions (F-bounds)]: /language/generics#f-bounds
[Inference using bounds]: /language/type-system#inference-using-bounds
[Effective Dart Design]: /effective-dart/design#do-use-class-modifiers-to-control-if-your-class-can-be-extended
[Effective Dart Documentation]: /effective-dart/documentation#prefer-a-noun-phrase-or-non-imperative-verb-phrase-for-a-function-or-method-if-returning-a-value-is-its-primary-purpose
[Labels]: /language/loops#labels
[`pubspec_overrides.yaml`]: /tools/pub/dependencies#pubspec-overrides
[support policy]: /tools/sdk#support-policy
[Implicit downcast from `dynamic`]: /language/type-system#implicit-downcasts-from-dynamic
[PR 6522]: {{site.repo.this}}/pull/6522
[Doc imports]: /tools/doc-comments/references#doc-imports
[Cross-compilation]: /tools/dart-compile
[diagnostic messages]: /tools/diagnostics

## 3.7 release

## 3.7 版本发布

_Released on: February 12, 2025_

_发布日期：2025 年 2 月 12 日_

This section lists notable changes made from December 12, 2024,
through February 12, 2025.
For details about the 3.7 release of Dart,
check out the [3.7 announcement][] and the [SDK changelog][3-7-changelog].

本节列出 2024 年 12 月 12 日至 2025 年 2 月 12 日期间的重要变更。
有关 Dart 3.7 版本的详细信息，
请查看 [3.7 发布公告][3.7 announcement]和
[SDK 更新日志][3-7-changelog]。

[3.7 announcement]: /blog/announcing-dart-3-7
[3-7-changelog]: {{site.repo.dart.sdk}}/blob/main/CHANGELOG.md#370

### Docs updated or added to dart.dev {:.no_toc}

### dart.dev 文档更新与新增 {:.no_toc}

In addition to bug fixes and incremental improvements,
we made the following changes to this site:

除 bug 修复和渐进式改进外，
我们还对本站做了以下变更：

* Introduced the new type system algorithm, [inference using bounds][].

  - 引入新的类型系统算法：[基于边界的推断][inference using bounds]。
* Added links to our new [Bluesky][] account.

  - 添加了我们新 [Bluesky][Bluesky] 账号的链接。
* Updated the [`dart format`][] page to reflect the new formatter style,
  including the new [configurable line length][] feature.

  - 更新了 [`dart format`][`dart format`] 页面以反映新的格式化器风格，
    包括新的[可配置行长度][configurable line length]特性。
* Documented the new [shared analysis options][] feature.

  - 记录了新的[共享分析选项][shared analysis options]特性。
* Changed the Effective Dart entry about [line length][] due to the new
  formatter style.

  - 因新的格式化器风格，
    修改了 Effective Dart 中关于[行长度][line length]的条目。
* Introduced details of [stray files][] to the Workspaces page.

  - 在工作区页面介绍了[散落文件][stray files]的详细信息。
* Added the new language feature [wildcard variables][] to the Variables page.

  - 在变量页面添加了新语言特性[通配符变量][wildcard variables]。
* Moved [covariant explanation][] to the better-suited Type system page.

  - 将 [covariant 的解释][covariant explanation]移到更合适的类型系统页面。
* Changed references to the [legacy JS interop][]
  libraries to be explicitly "deprecated".

  - 将对[旧版 JS 互操作][legacy JS interop]库的引用
    明确标记为“已弃用”。
* Removed the experimental macros page, since the team
  [indefinitely paused][] work on the feature.

  - 移除了实验性的宏页面，
    因为团队已[无限期暂停][indefinitely paused]该特性的工作。
* Added a [warning][map-warn] that destructuring a Map pattern by
  a non-existent key will throw a `StateError`.

  - 添加了[警告][map-warn]：用不存在的键解构 Map 模式
    会抛出 `StateError`。
* Revamped the [linter rules][] page with new cards, search format, and
  color-coded icons on the individual lint pages ([for example][]).

  - 改版了 [linter 规则][linter rules]页面，采用新卡片和搜索形式，
    并在各 lint 规则页面使用彩色图标（[示例][for example]）。
* Redesigned the layout implementation and sidenav for efficiency.

  - 重新设计了布局实现和侧边导航以提升效率。
* Removed the officially-deprecated `dart:html` library page.

  - 移除了已正式弃用的 `dart:html` 库页面。

[inference using bounds]: /language/type-system/#type-argument-inference
[for example]: /tools/linter-rules/annotate_overrides
[Bluesky]: https://bsky.app/profile/dart.dev
[configurable line length]: /tools/dart-format#page-width
[shared analysis options]: /tools/analysis#including-shared-options
[line length]: /effective-dart/style#prefer-lines-80-characters-or-fewer
[stray files]: /tools/pub/workspaces#stray-files
[wildcard variables]: /language/variables#wildcard-variables
[covariant explanation]: /language/type-system#covariant-keyword
[legacy JS interop]: /interop/js-interop/past-js-interop
[indefinitely paused]: /blog/an-update-on-dart-macros-data-serialization
[map-warn]: /language/pattern-types#map

## 3.6 release

## 3.6 版本发布

_Released on: December 11, 2024_

_发布日期：2024 年 12 月 11 日_

This section lists notable changes made from August 7, 2024,
through December 11, 2024.
For details about the 3.6 release of Dart,
check out the [3.6 announcement][] and the [SDK changelog][3-6-changelog].

本节列出 2024 年 8 月 7 日至 2024 年 12 月 11 日期间的重要变更。
有关 Dart 3.6 版本的详细信息，
请查看 [3.6 发布公告][3.6 announcement]和
[SDK 更新日志][3-6-changelog]。

[3.6 announcement]: /blog/announcing-dart-3-6
[3-6-changelog]: {{site.repo.dart.sdk}}/blob/main/CHANGELOG.md#360

### Docs updated or added to dart.dev {:.no_toc}

### dart.dev 文档更新与新增 {:.no_toc}

In addition to bug fixes and incremental improvements,
we made the following changes to this site:

除 bug 修复和渐进式改进外，
我们还对本站做了以下变更：

* Documented the new [pub workspaces][] feature.

  - 记录了新的 [pub 工作区][pub workspaces]特性。
* Explained the new `pub get` flag [`--enforce-lockfile`][].

  - 解释了新的 `pub get` 标志 [`--enforce-lockfile`][`--enforce-lockfile`]。
* Introduced guidance around [synchronous communication][] between too many isolates
  on the Concurrency page.

  - 在并发页面介绍了过多 isolate 之间
    [同步通信][synchronous communication]的相关指导。
* Added new language feature [digit separators][] to the Built-in types page.

  - 在内置类型页面添加了新语言特性[数字分隔符][digit separators]。
* Defined [variance and variance positions][] on the glossary page.

  - 在术语表页面定义了[型变与型变位置][variance and variance positions]。
* Created a new page for the new [documentation comment references][] feature.

  - 为新的[文档注释引用][documentation comment references]特性创建了新页面。
* Updated and improved the [Dart platforms graphic][] to include newly available
  support compiling to RISC-V and WASM.

  - 更新并改进了 [Dart 平台示意图][Dart platforms graphic]，
    加入新支持的 RISC-V 和 WASM 编译。
* Defined [function types][]. 

  - 定义了[函数类型][function types]。
* Added glossary definitions for the different kinds of code fixes available
  from the analyzer ([assists][], [refactors][], and [quick fixes][]).

  - 在术语表中定义了分析器提供的各类代码修复
    （[辅助][assists]、[重构][refactors]和[快速修复][quick fixes]）。
* Created a [page][bump-page] for the new `pub bump` command.

  - 为新的 `pub bump` 命令创建了[页面][bump-page]。
* Updated the [example for generative constructors][] to reflect the use of
  optional positional parameters with default values.

  - 更新了[生成构造函数示例][example for generative constructors]，
    展示带默认值的可选位置参数的用法。
* Improved conditional [import/export documentation][] on the package creation page.

  - 改进了创建 package 页面上的条件
    [导入/导出文档][import/export documentation]。
* Included `@override` annotations in [mixin code examples][] to correctly showcase
  how to work with mixed-in functions.

  - 在 [mixin 代码示例][mixin code examples]中加入 `@override` 注解，
    正确展示如何使用混入的函数。
* Provided an alternative to SSH for accessing private repo dependencies on
  the [pub dependencies page][]. 

  - 在 [pub 依赖页面][pub dependencies page]提供了
    访问私有仓库依赖时 SSH 之外的替代方案。
* Added a new `pub publish` warning about clean `git status` validation to the
  [publishing task list][].

  - 在[发布任务清单][publishing task list]中新增 `pub publish`
    关于 `git status` 干净状态校验的警告。
* Deprecated the Language and Library tour pages (contents are now on individual
  pages under [Language][lang-sidenav] and [Core libraries][lib-sidenav]
  in the left side-nav panel).

  - 弃用了语言导览和库导览页面（内容现在位于左侧导航面板
    [语言][lang-sidenav]和[核心库][lib-sidenav]下的各个独立页面）。

[pub workspaces]: /tools/pub/workspaces
[`--enforce-lockfile`]: /tools/pub/packages#get-dependencies-for-production
[synchronous communication]: /language/concurrency#synchronous-blocking-communication-between-isolates
[digit separators]: /language/built-in-types#digit-separators
[variance and variance positions]: /resources/glossary#variance
[documentation comment references]: /tools/doc-comments/references
[Dart platforms graphic]: /overview#platform
[function types]: /language/functions#function-types
[assists]: /resources/glossary#assist
[refactors]: /resources/glossary#refactor
[quick fixes]: /resources/glossary#quick-fix
[bump-page]: /tools/pub/cmd/pub-bump
[example for generative constructors]: /language/constructors#generative-constructors
[import/export documentation]: /tools/pub/create-packages#conditionally-importing-and-exporting-library-files
[mixin code examples]: /language/mixins
[pub dependencies page]: /tools/pub/dependencies#git-packages
[publishing task list]: /tools/pub/publishing#publish-to-pub-dev
[lib-sidenav]: /libraries
[lang-sidenav]: /language

## 3.5 release

## 3.5 版本发布

_Released on: August 6, 2024_

_发布日期：2024 年 8 月 6 日_

This section lists notable changes made from May 15, 2024,
through August 6, 2024.
For details about the 3.5 release of Dart,
check out the [3.5 announcement][] and the [SDK changelog][3-5-changelog].

本节列出 2024 年 5 月 15 日至 2024 年 8 月 6 日期间的重要变更。
有关 Dart 3.5 版本的详细信息，
请查看 [3.5 发布公告][3.5 announcement]和
[SDK 更新日志][3-5-changelog]。

[3.5 announcement]: /blog/announcing-dart-3-5-and-an-update-on-the-dart-roadmap
[3-5-changelog]: {{site.repo.dart.sdk}}/blob/main/CHANGELOG.md#350---2024-08-06

### Docs updated or added to dart.dev {:.no_toc}

### dart.dev 文档更新与新增 {:.no_toc}

In addition to bug fixes and incremental improvements,
we made the following changes to this site:

除 bug 修复和渐进式改进外，
我们还对本站做了以下变更：

* Clarified the status and intended uses of both the
  new and legacy [web platform libraries][].

  - 澄清新旧 [Web 平台库][web platform libraries]
    的状态和预期用途。
* Expanded the documentation on [publishing prerelease versions][]
  of packages to the pub.dev site.

  - 扩充了向 pub.dev 网站
    [发布预发布版本][publishing prerelease versions] package 的文档。
* Added a page covering the new [`dart pub unpack` command][].

  - 新增介绍 [`dart pub unpack` 命令][`dart pub unpack` command]的页面。
* Documented the new [`--skip-validation` flag][] for `dart pub publish` and
  the [`--tighten` flag][] for `dart pub downgrade`.

  - 记录了 `dart pub publish` 的新
    [`--skip-validation` 标志][`--skip-validation` flag]和 `dart pub downgrade` 的
    [`--tighten` 标志][`--tighten` flag]。
* Provided best practice guidance for package authors to
  [test their package with downgraded dependencies][].

  - 为 package 作者提供了
    [用降级依赖测试 package][test their package with downgraded dependencies]
    的最佳实践指导。
* Improved the [Fixing type promotion failures][] guide and added
  code highlighting to better indicate relevant code.

  - 改进了[修复类型提升失败][Fixing type promotion failures]指南，
    并添加代码高亮以更好地标示相关代码。
* Supplemented the [Dart installation documentation][] with
  uninstall and cleanup instructions.

  - 为 [Dart 安装文档][Dart installation documentation]
    补充了卸载和清理说明。
* Introduced new docs and code samples covering
  [function][func-tear] and [constructor][cons-tear] tear-offs.

  - 引入涵盖[函数][func-tear]和[构造函数][cons-tear]
    tear-off 的新文档和代码示例。
* Explained how to [export Dart functions and objects to be used from JS][].

  - 解释了如何[导出 Dart 函数和对象供 JS 使用][export Dart functions and objects to be used from JS]。
* Added glossary entries for [subclass][] and [subtype][]
  explaining the terms in the context of Dart.

  - 新增[子类][subclass]和[子类型][subtype]的术语表条目，
    在 Dart 语境下解释这些术语。

[web platform libraries]: /libraries#web-platform-libraries
[publishing prerelease versions]: /tools/pub/publishing#publishing-prereleases
[`dart pub unpack` command]: /tools/pub/cmd/pub-unpack
[`--skip-validation` flag]: /tools/pub/cmd/pub-lish#skip-validation
[`--tighten` flag]: /tools/pub/cmd/pub-downgrade#tighten
[test their package with downgraded dependencies]: /tools/pub/dependencies#test-with-downgraded-dependencies
[Fixing type promotion failures]: /tools/non-promotion-reasons
[Dart installation documentation]: /get-dart
[func-tear]: /language/functions#tear-offs
[cons-tear]: /language/constructors#constructor-tear-offs
[export Dart functions and objects to be used from JS]: /interop/js-interop/usage#export
[subclass]: /resources/glossary#subclass
[subtype]: /resources/glossary#subtype

## 3.4 release

## 3.4 版本发布

_Released on: May 14, 2024_

_发布日期：2024 年 5 月 14 日_

This section lists notable changes made from February 16, 2024,
through May 14, 2024.
For details about the 3.4 release,
check out [3.4 blog post][] and the [SDK changelog][3-4-changelog].

本节列出 2024 年 2 月 16 日至 2024 年 5 月 14 日期间的重要变更。
有关 3.4 版本的详细信息，
请查看 [3.4 博客文章][3.4 blog post]和
[SDK 更新日志][3-4-changelog]。

[3.4 blog post]: /blog/announcing-dart-3-4
[3-4-changelog]: {{site.repo.dart.sdk}}/blob/main/CHANGELOG.md#340---2024-05-14

### Docs updated or added to dart.dev {:.no_toc}

### dart.dev 文档更新与新增 {:.no_toc}

In addition to bug fixes and incremental improvements,
we made the following changes to this site:

除 bug 修复和渐进式改进外，
我们还对本站做了以下变更：

* Added a page documenting the experimental [Macros][] language feature.

  - 新增页面，记录实验性的[宏][Macros]语言特性。
* Added a page to track [Wasm][] developments for Dart.

  - 新增页面，跟踪 Dart 的 [Wasm][Wasm] 进展。
* Refactored the [Constructors][] page.

  - 重构了[构造函数][Constructors]页面。
* Clarified the instructions in the [Renames][] section of the `package:web`
  migration page.

  - 澄清了 `package:web` 迁移页面
    [重命名][Renames]小节中的说明。
* Adjusted the Effective Dart entry on [enabling type promotion][] to recommend
  the null-check pattern before other idioms.

  - 调整了 Effective Dart 中关于[启用类型提升][enabling type promotion]的条目，
    建议优先使用 null 检查模式而非其他惯用法。
* Revised the [Web libraries and packages][] list to better represent the
  recommended solutions.

  - 修订了 [Web 库与 package][Web libraries and packages] 列表，
    更好地呈现推荐方案。
* Explained how to destructure named fields on the [Records][] and [Patterns][]
  pages.

  - 在[记录][Records]和[模式][Patterns]页面
    解释了如何解构命名字段。
* Included a [before-and-after table][] of web solutions on the JS interop page.

  - 在 JS 互操作页面加入了 Web 方案的[新旧对照表][before-and-after table]。
* Added a section explaining [spread operators][] to the Operators page.

  - 在运算符页面新增解释[展开运算符][spread operators]的小节。
* Clarified ordering of [parenthetical patterns][] on the Pattern types page.

  - 在模式类型页面澄清了[括号模式][parenthetical patterns]的优先级顺序。
* Added docs for [`ExternalDartReference`][] to the JS types page.

  - 在 JS 类型页面添加了 [`ExternalDartReference`][`ExternalDartReference`] 的文档。
* Updated the site for new [linter rules][] and [diagnostic messages][],
  for example adding docs for the new [`@mustBeConst`][] annotation diagnostic.

  - 针对新的 [linter 规则][linter rules]和[诊断消息][diagnostic messages]更新网站，
    例如为新 [`@mustBeConst`][`@mustBeConst`] 注解诊断添加文档。

[Macros]: /blog/an-update-on-dart-macros-data-serialization
[Wasm]: /web/wasm
[Constructors]: /language/constructors/
[Renames]: /interop/js-interop/package-web/#renames
[enabling type promotion]: /effective-dart/usage/#consider-type-promotion-or-null-check-patterns-for-using-nullable-types
[linter rules]: /tools/linter-rules/
[diagnostic messages]: /tools/diagnostic-messages/
[`@mustBeConst`]: /tools/diagnostic-messages/#non_const_argument_for_const_parameter
[Web libraries and packages]: /web/libraries/
[Records]: /language/records/#multiple-returns
[Patterns]: /language/patterns/#destructuring-multiple-returns
[before-and-after table]: /interop/js-interop/past-js-interop#next-generation-js-interop
[spread operators]: /language/operators/#spread-operators
[parenthetical patterns]: /language/pattern-types/#parenthesized
[`ExternalDartReference`]: /interop/js-interop/js-types/#jsboxeddartobject-vs-externaldartreference

### Articles added to the Dart blog {:.no_toc}

### Dart 博客新增文章 {:.no_toc}

We published the following articles on the Dart blog:

我们在 Dart 博客上发布了以下文章：

* [History of JS interop in Dart][blog-3-28-24]

  - [Dart 中 JS 互操作的历史][blog-3-28-24]
* [Dart in Google Summer of Code 2024][blog-3-5-24]

  - [Dart 参加 Google Summer of Code 2024][blog-3-5-24]

[blog-3-28-24]: /blog/history-of-js-interop-in-dart
[blog-3-5-24]: /blog/dart-in-google-summer-of-code-2024

## 3.3 release

## 3.3 版本发布

_Released on: February 15, 2024_

_发布日期：2024 年 2 月 15 日_

This section lists notable changes made from November 16, 2023,
through February 15, 2024.
For details about the 3.3 release,
check out [3.3 blog post][] and the [SDK changelog][3-3-changelog].

本节列出 2023 年 11 月 16 日至 2024 年 2 月 15 日期间的重要变更。
有关 3.3 版本的详细信息，
请查看 [3.3 博客文章][3.3 blog post]和
[SDK 更新日志][3-3-changelog]。

[3.3 blog post]: /blog/new-in-dart-3-3-extension-types-javascript-interop-and-more
[3-3-changelog]: {{site.repo.dart.sdk}}/blob/main/CHANGELOG.md#330

### Docs updated or added to dart.dev {:.no_toc}

### dart.dev 文档更新与新增 {:.no_toc}

In addition to bug fixes and incremental improvements,
we made the following changes to this site:

除 bug 修复和渐进式改进外，
我们还对本站做了以下变更：

* Changed the site infrastructure to [run on 11ty][] instead of Jekyll.

  - 将网站基础设施改为[基于 11ty 运行][run on 11ty]，不再使用 Jekyll。
* Added a page covering the new language feature [extension types][].

  - 新增页面，介绍新语言特性[扩展类型][extension types]。
* Added a new documentation set on [JavaScript interop][]:
  * [Usage][]
  * [JS types][]
  * [Tutorials][], the first of which is on [Mocks][]
  * [Past JS interop][]

  - 新增一套 [JavaScript 互操作][JavaScript interop]文档：
    - [用法][Usage]
    - [JS 类型][JS types]
    - [教程][Tutorials]，第一篇关于 [Mock][Mocks]
    - [旧版 JS 互操作][Past JS interop]
* Updated [Concurrency][] overview, plus a new practical page on using [Isolates][].

  - 更新了[并发][Concurrency]概览，并新增使用 [isolate][Isolates] 的实战页面。
* Added a section about [`external`][] to the [Functions][] page.

  - 在[函数][Functions]页面新增关于 [`external`][`external`] 的小节。
* Removed embedded DartPad from a few pages to accommodate
  the new version of [DartPad][].

  - 从若干页面移除了内嵌 DartPad，
    以适配新版 [DartPad][DartPad]。
* Included a definition for "Function" in the [Glossary][].

  - 在[术语表][Glossary]中加入“函数”（Function）的定义。
* Deconstructed the [Library tour][] into individual pages for each library.

  - 将[库导览][Library tour]拆分为每个库一个独立页面。
* Updated the [Breaking changes][] page for 3.3.

  - 针对 3.3 更新了[破坏性变更][Breaking changes]页面。
* Updated a few outdated entries on the FAQ page. _(Now removed)_

  - 更新了 FAQ 页面上几个过时的条目。_（现已移除）_
* Expanded documentation on [`dart doc`][].

  - 扩充了 [`dart doc`][`dart doc`] 的文档。
* Updated and simplified [supported platforms][] content.

  - 更新并简化了[支持的平台][supported platforms]内容。
* Consolidated multiples of [`dart format`][] content.

  - 合并了多处 [`dart format`][`dart format`] 内容。
* Updated various locations to suggest [`package:web`][] instead of `dart:html`.

  - 更新了多处内容，建议改用 [`package:web`][`package:web`] 而非 `dart:html`。
* Moved away from recommending [`dart:html`][] and [`dart:io`][]
  for making HTTP requests, in favor of `package:http`.

  - 不再推荐用 [`dart:html`][`dart:html`] 和 [`dart:io`][`dart:io`]
    发起 HTTP 请求，改用 `package:http`。
* Documented [suppressing diagnostics in a pubspec file][].

  - 记录了[在 pubspec 文件中抑制诊断][suppressing diagnostics in a pubspec file]。
* Added content on [creating][] and [ignoring][] security advisories in a pubspec file.

  - 新增在 pubspec 文件中[创建][creating]和[忽略][ignoring]安全公告的内容。
* Documented [how to migrate away from a retracted package version][retract].

  - 记录了[如何从被撤回的 package 版本迁移][retract]。

[run on 11ty]: {{site.repo.this}}/pull/5483
[Extension types]: /language/extension-types
[JavaScript interop]: /interop/js-interop
[Usage]: /interop/js-interop/usage
[JS types]: /interop/js-interop/js-types
[Tutorials]: /interop/js-interop/tutorials
[Mocks]: /interop/js-interop/mock
[Past JS interop]: /interop/js-interop/past-js-interop
[Concurrency]: /language/concurrency
[Isolates]: /language/isolates
[`external`]: /language/functions#external
[Functions]: /language/functions
[DartPad]: {{site.dartpad}}
[Glossary]: /resources/glossary#function
[Library tour]: /libraries
[Breaking changes]: /resources/breaking-changes#3-3-0
[FAQ]: {{site.repo.this}}/pull/5479
[`dart doc`]: /tools/dart-doc
[supported platforms]: /get-dart
[`dart format`]: /tools/dart-format
[`package:web`]: /interop/js-interop/package-web
[`dart:html`]: /libraries/dart-html#using-http-resources-with-httprequest
[`dart:io`]: /libraries/dart-io#http-client
[suppressing diagnostics in a pubspec file]: /tools/analysis#suppressing-diagnostics-in-a-pubspec-file
[ignoring]: /tools/pub/pubspec#ignored_advisories
[creating]: /tools/pub/security-advisories
[retract]: /tools/pub/publishing#how-to-migrate-away-from-a-retracted-package-version


## 3.2 release

## 3.2 版本发布

_Released on: November 15, 2023_

_发布日期：2023 年 11 月 15 日_

This section lists notable changes made from August 17, 2023,
through November 15, 2023.
For details about the 3.2 release,
check out [3.2 blog post][] and the [SDK changelog][3-2-changelog].

本节列出 2023 年 8 月 17 日至 2023 年 11 月 15 日期间的重要变更。
有关 3.2 版本的详细信息，
请查看 [3.2 博客文章][3.2 blog post]和
[SDK 更新日志][3-2-changelog]。

[3.2 blog post]: /blog/announcing-dart-3-2
[3-2-changelog]: {{site.repo.dart.sdk}}/blob/main/CHANGELOG.md#320---2023-11-15

### Docs updated or added to dart.dev {:.no_toc}

### dart.dev 文档更新与新增 {:.no_toc}

In addition to bug fixes and incremental improvements,
we made the following changes to this site:

除 bug 修复和渐进式改进外，
我们还对本站做了以下变更：

* Updated the [Fixing type promotion failures][no-promo] page
  for a new type promotion feature: private final field promotion.

  - 更新了[修复类型提升失败][no-promo]页面，
    介绍新的类型提升特性：私有 final 字段提升。
  * Made minor related adjustments to the Effective Dart entry on
    [type promotion][], the [Understanding Null Safety][] page, and other various
    places across the site.

    - 对 Effective Dart 的[类型提升][type promotion]条目、
      [理解空安全][Understanding Null Safety]页面
      以及全站其他多处内容做了相关的小调整。
* Introduced documentation on the experimental native assets feature
  to the [C interop][] page.

  - 在 [C 互操作][C interop]页面
    引入实验性原生资源特性的文档。
* Created a new page dedicated to documenting [Breaking changes][].

  - 创建了专门记录[破坏性变更][Breaking changes]的新页面。
* Accounted for new and updated [lints][] and [diagnostics][] in their
  respective doc pages.

  - 在各自的文档页面中纳入了
    新增和更新的 [lint 规则][lints]与[诊断消息][diagnostics]。
* Added documentation for the new `--tighten ` flag to the [`pub upgrade`] page.

  - 在 [`pub upgrade`][`pub upgrade`] 页面添加了新 `--tighten` 标志的文档。
* Removed the cheatsheet in favor of the [Language overview][] page.

  - 移除了速查表，改用[语言概览][Language overview]页面。
* Clarified the relationship between [guard clauses and patterns][].

  - 澄清了[守卫子句与模式][guard clauses and patterns]之间的关系。
* Adjusted the [Constructors][] page to better represent best practices.

  - 调整了[构造函数][Constructors]页面，更好地体现最佳实践。
* Improved contents of the [Package dependencies][] page to be more actionable
  and easier to follow.

  - 改进了 [package 依赖][Package dependencies]页面的内容，
    更具可操作性、更易于跟随。
* Elaborated on static members in the [Extension methods][] page.

  - 在[扩展方法][Extension methods]页面详细阐述了静态成员。
* Changed the [Objective-C][] multithreading limitations content to account
  for the new `NativeCallable` API.

  - 修改了 [Objective-C][Objective-C] 多线程限制的内容，
    纳入新的 `NativeCallable` API。
* Added new annotations and mentioned deprecations on the [Metadata][] page.

  - 在[元数据][Metadata]页面添加了新注解并说明了弃用情况。
* Improved contrast by adjusting text colors and highlighting across
  in code samples across the site.

  - 调整了全站代码示例的文本颜色和突出显示，
    改善对比度。
* Reorganized and simplified site infrastructure across the board, in preparation
  to [move away from using Jekyll][].

  - 全面重组并简化了网站基础设施，
    为[不再使用 Jekyll][move away from using Jekyll]做准备。

[type promotion]: /effective-dart/usage#consider-type-promotion-or-null-check-patterns-for-using-nullable-types
[Understanding Null Safety]: /null-safety/understanding-null-safety
[C interop]: /interop/c-interop#native-assets
[Breaking changes]: /resources/breaking-changes
[lints]: /tools/linter-rules
[diagnostics]: /tools/diagnostic-messages
[`pub upgrade`]: /tools/pub/cmd/pub-upgrade#tighten
[Language overview]: /language
[guard clauses and patterns]: /language/patterns#switch-statements-and-expressions
[Constructors]: /language/constructors
[Package dependencies]: /tools/pub/dependencies
[Extension methods]: /language/extension-methods
[Objective-C]: /interop/objective-c-interop#callbacks-and-multithreading-limitations
[Metadata]: /language/metadata
[move away from using Jekyll]: {{site.repo.this}}/issues/5177

## 3.1 release

## 3.1 版本发布

_Released on: August 16, 2023_

_发布日期：2023 年 8 月 16 日_

This section lists notable changes made from May 11, 2023,
through August 16, 2023.
For details about the 3.1 release,
check out 
[Dart 3.1 & a retrospective on functional style programming in Dart 3][]
and the [SDK changelog][3-1-changelog].

本节列出 2023 年 5 月 11 日至 2023 年 8 月 16 日期间的重要变更。
有关 3.1 版本的详细信息，请查看
[Dart 3.1 与 Dart 3 函数式风格编程回顾][Dart 3.1 & a retrospective on functional style programming in Dart 3]
和[SDK 更新日志][3-1-changelog]。

[Dart 3.1 & a retrospective on functional style programming in Dart 3]: /blog/dart-3-1-a-retrospective-on-functional-style-programming-in-dart-3
[3-1-changelog]: {{site.repo.dart.sdk}}/blob/main/CHANGELOG.md#310---2023-08-16

### Docs updated or added to dart.dev {:.no_toc}

### dart.dev 文档更新与新增 {:.no_toc}

In addition to bug fixes and incremental improvements,
we made the following changes to this site:

除 bug 修复和渐进式改进外，
我们还对本站做了以下变更：

* Overhauled the linter rule documentation to replace the old linter site:

  - 全面改版了 linter 规则文档，取代旧的 linter 网站：
  * Moved each linter rule's documentation to its own page.
    For example: [`avoid_dynamic_calls`][].

    - 将每条 linter 规则的文档移到独立页面。
      例如：[`avoid_dynamic_calls`][`avoid_dynamic_calls`]。
  * Added an example `analysis_options.yaml` that enables
    [all linter rules][] available in the latest Dart release.

    - 添加了示例 `analysis_options.yaml`，
      启用最新 Dart 版本中[所有可用的 linter 规则][all linter rules]。
  * Updated the [index of all available linter rules][]
    to enable easier lint discovery.

    - 更新了[所有可用 linter 规则的索引][index of all available linter rules]，
      便于发现 lint 规则。
* Augmented the [class modifiers][] documentation by adding a
  [Class modifiers reference][] to outline how they interact with each other.

  - 扩充了[类修饰符][class modifiers]文档，
    新增[类修饰符参考][Class modifiers reference]，概述它们之间的相互作用。
* Introduced a [Class modifiers for API maintainers][] guide to help
  developers best use class modifiers.

  - 引入[面向 API 维护者的类修饰符][Class modifiers for API maintainers]指南，
    帮助开发者用好类修饰符。
* Rewrote the [switch expression][] documentation
  to better account for its differences to switch statements.

  - 重写了 [switch 表达式][switch expression]文档，
    更好地说明它与 switch 语句的区别。
* Documented support for specifying [topics][] in your pubspec file
  to categorize your package on the pub.dev site.

  - 记录了在 pubspec 文件中指定[主题][topics]的支持，
    用于在 pub.dev 网站上为你的 package 分类。
* Clarified that [package screenshots][] are meant to
  showcase package functionality, not the logo or icon of the package.

  - 澄清了 [package 截图][package screenshots]用于展示 package 功能，
    而不是 package 的 logo 或图标。
* Added previous and next buttons to Dart's
  [language documentation][] to enable a guided learning experience.

  - 为 Dart 的[语言文档][language documentation]添加了上一页和下一页按钮，
    提供引导式学习体验。
* Continued expanding the new site-wide [glossary][].

  - 继续扩充新的全站[术语表][glossary]。
* Added a migration note about how the
  [pub cache move][] on Windows was finalized in Dart 3.

  - 添加了迁移说明，介绍 Windows 上的 [pub 缓存迁移][pub cache move]
    如何在 Dart 3 中最终完成。
* Simplified and updated older docs now that
  Dart's type system is always [null safe][].

  - 既然 Dart 的类型系统始终[空安全][null safe]，
    简化并更新了旧文档。

[class modifiers]: /language/class-modifiers
[Class modifiers reference]: /language/modifier-reference
[Class modifiers for API maintainers]: /language/class-modifiers-for-apis
[`avoid_dynamic_calls`]: /tools/linter-rules/avoid_dynamic_calls
[all linter rules]: /tools/linter-rules/all
[index of all available linter rules]: /tools/linter-rules#rules
[switch expression]: /language/branches#switch-expressions
[topics]: /tools/pub/pubspec#topics
[language documentation]: /language
[package screenshots]: /tools/pub/pubspec#screenshots
[glossary]: /resources/glossary
[pub cache move]: /resources/dart-3-migration#other-tools-changes
[null safe]: /null-safety

### Articles added to the Dart blog {:.no_toc}

### Dart 博客新增文章 {:.no_toc}

We published the following article on the Dart blog:

我们在 Dart 博客上发布了以下文章：

* [Dart DevTools: Analyzing application performance with the CPU Profiler][blog-6-12-23]

  - [Dart DevTools：用 CPU Profiler 分析应用性能][blog-6-12-23]

[blog-6-12-23]: /blog/dart-devtools-analyzing-application-performance-with-the-cpu-profiler

## 3.0 release

## 3.0 版本发布

_Released on: May 10, 2023_

_发布日期：2023 年 5 月 10 日_

This section lists notable changes made from January 26, 2023,
through May 10, 2023.
For details about the major 3.0 release,
check out [Announcing Dart 3][],
and the [SDK changelog][3-0-changelog].

本节列出 2023 年 1 月 26 日至 2023 年 5 月 10 日期间的重要变更。
有关重大的 3.0 版本的详细信息，
请查看[宣布 Dart 3][Announcing Dart 3]
和[SDK 更新日志][3-0-changelog]。

[Announcing Dart 3]: /blog/announcing-dart-3
[3-0-changelog]: {{site.repo.dart.sdk}}/blob/main/CHANGELOG.md#300---2023-05-10

### Docs updated or added to dart.dev {:.no_toc}

### dart.dev 文档更新与新增 {:.no_toc}

In preparation for Dart 3, we split up and reorganized the
Language Tour into new conceptual categories.
You can access the restructured language documentation
under **Language** in the side navigation menu, or by
visiting the updated [Introduction to Dart][].

为迎接 Dart 3，我们把语言导览拆分并重组为
新的概念类别。你可以通过侧边导航菜单中的
**Language** 访问重组后的语言文档，
或者访问更新后的 [Dart 简介][Introduction to Dart]。

Taking advantage of this new structure,
we added documentation for each of Dart 3's major features:

借助这一新结构，
我们为 Dart 3 的每个主要特性添加了文档：

- [Pattern matching][] and the different [types of patterns][].

  - [模式匹配][Pattern matching]及各种[模式类型][types of patterns]。
- [Switch expressions][] with support for
  patterns and [exhaustiveness checking][].

  - [Switch 表达式][Switch expressions]，
    支持模式和[穷尽性检查][exhaustiveness checking]。
- [If statements with case clauses][] to support pattern matching.

  - [带 case 子句的 if 语句][If statements with case clauses]，支持模式匹配。
- [Records][], a new anonymous, immutable, and aggregate type
  that enables [multiple returns][].

  - [记录][Records]，一种新的匿名、不可变的聚合类型，
    支持[多返回值][multiple returns]。
- [Class modifiers][] that give libraries more control over exported types.

  - [类修饰符][Class modifiers]，让库对导出的类型有更多控制。

To help you transition to Dart 3's enforcement of [sound null safety][]
and other changes, we also prepared the following updates:

为帮助你过渡到 Dart 3 强制执行的[健全空安全][sound null safety]
及其他变更，我们还准备了以下更新：

- Created a comprehensive [Dart 3 migration guide][].

  - 创建了全面的 [Dart 3 迁移指南][Dart 3 migration guide]。
- Migrated all documentation and code examples
  to Dart 3, the latest tool releases, and the latest dependencies.

  - 将所有文档和代码示例迁移到 Dart 3、
    最新的工具版本和最新的依赖。
- Clarified that Dart's type system is now always null-safe in Dart 3.

  - 澄清了 Dart 3 中 Dart 的类型系统现在始终是空安全的。
- Updated and reorganized the [Language evolution][] page
  and its [language versioning][] discussion.

  - 更新并重组了[语言演进][Language evolution]页面
    及其[语言版本][language versioning]讨论。
- Removed remnants of Dart 1 and early Dart 2 docs, notes, and resources.

  - 移除了 Dart 1 和早期 Dart 2 遗留的文档、说明和资源。

In addition to the new Dart 3 content and 
corresponding updates across the site,
we made the following changes:

除了新的 Dart 3 内容和全站的相应更新，
我们还做了以下变更：

- Added a guide on configuring [compilation environment declarations][].

  - 添加了配置[编译环境声明][compilation environment declarations]的指南。
- Continued Dart's native interoperability work
  by adding a guide on experimental support for [Java interop][].

  - 继续推进 Dart 的原生互操作工作，
    添加了[Java 互操作][Java interop]实验性支持的指南。
- Clarified the usage and limitations of [unnamed extensions][].

  - 澄清了[未命名扩展][unnamed extensions]的用法和限制。
- Added a page for the new [`dart info`][] command 
  that helps with tooling diagnostics.

  - 为新的 [`dart info`][`dart info`] 命令添加了页面，
    帮助进行工具诊断。
- Overhauled the [`dart pub add`][] documentation
  to cover its new [package descriptor][] syntax.

  - 全面改版了 [`dart pub add`][`dart pub add`] 文档，
    涵盖其新的 [package 描述符][package descriptor]语法。
- Surfaced preview Linux RISC-V (RV64GC) builds on the
  beta channel in the [SDK archive][].

  - 在 [SDK 归档][SDK archive]的 beta 渠道
    提供 Linux RISC-V（RV64GC）预览构建。
- Began a new site-wide [glossary][] to contain 
  common terms used throughout the site.

  - 开始建设新的全站[术语表][glossary]，
    收录全站常用术语。
- Highlighted experimental work on Dart's [JS static interop support][].

  - 重点介绍了 Dart [JS 静态互操作支持][JS static interop support]的实验性工作。
- Documented the existence and current limitations of [analyzer plugins][].

  - 记录了[分析器插件][analyzer plugins]的存在及当前限制。

[Introduction to Dart]: /language
[Pattern matching]: /language/patterns
[types of patterns]: /language/pattern-types
[If statements with case clauses]: /language/branches#if-case
[Switch expressions]: /language/branches#switch-expressions
[exhaustiveness checking]: /language/branches#exhaustiveness-checking
[Records]: /language/records
[multiple returns]: /language/records#multiple-returns
[Class modifiers]: /language/class-modifiers
[class-modifier-reference]: /language/modifier-reference
[sound null safety]: /null-safety
[Dart 3 migration guide]: /resources/dart-3-migration
[language evolution]: /resources/language/evolution
[language versioning]: /language/versioning
[compilation environment declarations]: /libraries/core/environment-declarations
[Java interop]: /interop/java-interop
[unnamed extensions]: /language/extension-methods#unnamed-extensions
[`dart info`]: /tools/dart-info
[`dart pub add`]: /tools/pub/cmd/pub-add
[package descriptor]: /tools/pub/dependencies#package-descriptors
[SDK archive]: /get-dart/archive
[glossary]: /resources/glossary
[JS static interop support]: /interop/js-interop
[analyzer plugins]: /tools/analysis#plugins

### Articles added to the Dart blog {:.no_toc}

### Dart 博客新增文章 {:.no_toc}

We published the following article on the Dart blog:

我们在 Dart 博客上发布了以下文章：

* [Introducing Realm for Dart & Flutter][blog-2-09-23]

  - [Realm for Dart & Flutter 登场][blog-2-09-23]

[blog-2-09-23]: /blog/introducing-realm-for-dart-flutter

### Videos released by the Dart team {:.no_toc}

### Dart 团队发布的视频 {:.no_toc}

During Google I/O 2023, we released the following videos:

在 Google I/O 2023 期间，我们发布了以下视频：

* [What's new in Dart and Flutter][] ([American Sign Language version][])

  - [Dart 和 Flutter 的新内容][What's new in Dart and Flutter]（[美国手语版本][American Sign Language version]）
* [Rethinking Dart interoperability with Android][]

  - [重新思考 Dart 与 Android 的互操作][Rethinking Dart interoperability with Android]
* [How to build a package in Dart][]

  - [如何用 Dart 构建 package][How to build a package in Dart]

[What's new in Dart and Flutter]: {{site.yt.watch}}?v=yRlwOdCK7Ho
[American Sign Language version]: {{site.yt.watch}}?v=QbMgjVB0XMI
[Rethinking Dart interoperability with Android]: {{site.yt.watch}}?v=ZWp2FJ2TuJs
[How to build a package in Dart]: {{site.yt.watch}}?v=8V_TLiWszK0

## 2.19 + 3.0 alpha releases

## 2.19 + 3.0 alpha 版本发布

_Released on: January 25, 2023_

_发布日期：2023 年 1 月 25 日_

This section lists notable changes made from August 31, 2022,
through January 25, 2023.
For details about the 2.19 + 3.0 alpha releases,
see [Introducing Dart 3 alpha][],
and the [SDK changelog][2-19-changelog].

本节列出 2022 年 8 月 31 日至 2023 年 1 月 25 日期间的重要变更。
有关 2.19 + 3.0 alpha 版本的详细信息，
请参阅[介绍 Dart 3 alpha][Introducing Dart 3 alpha]
和[SDK 更新日志][2-19-changelog]。

[Introducing Dart 3 alpha]: /blog/introducing-dart-3-alpha
[2-19-changelog]: {{site.repo.dart.sdk}}/blob/main/CHANGELOG.md#2190---2023-01-24

### Docs updated or added to dart.dev {:.no_toc}

### dart.dev 文档更新与新增 {:.no_toc}

In addition to bug fixes and incremental improvements,
we made the following changes to this site:

除 bug 修复和渐进式改进外，
我们还对本站做了以下变更：

* Introduced the [Fetch data from the internet][] tutorial about using `package:http`.

  - 引入使用 `package:http` 的[从互联网获取数据][Fetch data from the internet]教程。
* Added a page on [Automated publishing of packages to pub.dev][].

  - 新增[自动化发布 package 到 pub.dev][Automated publishing of packages to pub.dev] 的页面。
* Included links to two new site translations in our [community resources][] section:
  * [Korean version of this site (한국어)](https://dart-ko.dev/)
  * [Traditional Chinese version of this site (正體中文版)](https://dart.tw.gh.miniasp.com/)

  - 在[社区资源][community resources]部分加入了两个新的网站翻译版本链接：
    - [本站韩语版（한국어）](https://dart-ko.dev/)
    - [本站繁体中文版（正體中文版）](https://dart.tw.gh.miniasp.com/)
* Updated null safety content in preparation of Dart 3:

  - 为迎接 Dart 3 更新了空安全内容：
  * Changed the version constraints in the migration guide for Dart 3 compatibility.

    - 修改了迁移指南中的版本约束以兼容 Dart 3。
  * Added Dart 3 full sound null safety overview to the [Sound null safety][] page.

    - 在[健全空安全][Sound null safety]页面添加了 Dart 3 完全健全空安全的概述。
  * Emphasized Dart 3's incompatibility with unsound null safety in a note.

    - 在注意事项中强调了 Dart 3 与非健全空安全不兼容。
* Introduced the new Learning Dart as a Swift developer guide. _(Now removed)_

  - 引入新的《Swift 开发者学习 Dart》指南。_（现已移除）_
* Replaced an Effective Dart section with more general guidance on [booleans and equality operators][]. 

  - 用关于[布尔值与相等运算符][booleans and equality operators]的更通用指导替换了一个 Effective Dart 小节。
* Documented [content-hashing][] across the pub docs.

  - 在 pub 文档中记录了[内容哈希][content-hashing]。
* Began effort to overhaul the [Zones][] page by
  changing examples to use `runZonedGuarded` instead of `onError`.

  - 开始全面改版 [Zone][Zones] 页面，
    将示例改为使用 `runZonedGuarded` 而非 `onError`。
* Updated content on libraries to cover new no-name declarations development:

  - 更新了库相关内容，涵盖新的无名声明进展：
  * Effective Dart: [Documentation][], [Style][], and [Usage][]

    - Effective Dart：[文档][Documentation]、[风格][Style]和[用法][Usage]
  * New library directive section in [The language tour][]

    - [语言导览][The language tour]中新增 library 指令小节
* Improved clarity surrounding Dart's single-threaded or multi-threaded status:

  - 更清楚地说明了 Dart 的单线程或多线程状况：
  * Removed the outdated `dart:io` page.

    - 移除了过时的 `dart:io` 页面。
  * Expanded on [Dart's web concurrency capabilities][].

    - 扩充了 [Dart 的 Web 并发能力][Dart's web concurrency capabilities]。
* Rearranged and clarified [discussion][] of default values for optional and positional parameters.

  - 重新组织并澄清了关于可选参数和位置参数默认值的[讨论][discussion]。
* Updated [Concurrency in Dart][] to default to new `Isolate.run()` function.

  - 更新了 [Dart 并发][Concurrency in Dart]，默认使用新的 `Isolate.run()` 函数。
* Documented specifying a file path when activating a package on the [`pub global` page][].

  - 在 [`pub global` 页面][`pub global` page]记录了激活 package 时指定文件路径的用法。
* Rewrote Learning Dart as a JavaScript developer _(Now removed)_

  - 重写了《JavaScript 开发者学习 Dart》。_（现已移除）_
* Added a brief overview of Dart DevTools to [`dart run` page][].

  - 在 [`dart run` 页面][`dart run` page]添加了 Dart DevTools 的简要概述。
* Provided more clarity around [operator precedence and associativity][] in the Language tour.

  - 在语言导览中更清楚地讲解了[运算符优先级与结合性][operator precedence and associativity]。
* Expanded Library tour section on [Building URIs][] with URI http and factory constructor info.

  - 扩充了库导览中[构建 URI][Building URIs] 小节，加入 URI http 和工厂构造函数的信息。
* Accounted for [pub's transition to pub.dev][] from pub.dartlang.org.

  - 记录了 [pub 从 pub.dartlang.org 迁移到 pub.dev][pub's transition to pub.dev]。
* Added documentation on [package screenshots][].

  - 添加了 [package 截图][package screenshots]的文档。
* Improved the [explicit downcast section][] of The Dart type system page.

  - 改进了 Dart 类型系统页面的[显式向下转型小节][explicit downcast section]。
* Increased [analyzer][] and [lint][] coverage:

  - 扩大了[分析器][analyzer]和 [lint][lint] 的覆盖范围：
  * Included SDK version support info for linter rules.

    - 加入了 linter 规则的 SDK 版本支持信息。
  * Added diagnostic and lint messages for 2.19 changes.

    - 为 2.19 的变更添加了诊断和 lint 消息。
 
[Fetch data from the internet]: /server/fetch-data
[Automated publishing of packages to pub.dev]: /tools/pub/automated-publishing
[community resources]: /community
[booleans and equality operators]: /effective-dart/usage#dont-use-true-or-false-in-equality-operations
[content-hashing]: /resources/glossary#pub-content-hash
[Zones]: /libraries/async/zones
[Documentation]: /effective-dart/documentation#consider-writing-a-library-level-doc-comment
[Style]: /effective-dart/style#dont-explicitly-name-libraries
[Usage]: /effective-dart/usage#do-use-strings-in-part-of-directives
[The language tour]: /language/libraries#library-directive
[Dart's web concurrency capabilities]: /language/concurrency#concurrency-on-the-web
[discussion]: /language/functions#parameters
[Concurrency in Dart]: /language/concurrency
[`pub global` page]: /tools/pub/cmd/pub-global
[`dart run` page]: /tools/dart-run#debugging
[operator precedence and associativity]: /language/operators
[Building URIs]: /libraries/dart-core#building-uris
[pub's transition to pub.dev]: /tools/pub/troubleshoot#pub-get-socket-error
[package screenshots]: /tools/pub/pubspec#screenshots
[explicit downcast section]: /language/type-system#generic-type-assignment
[analyzer]: /tools/diagnostic-messages
[lint]: /tools/linter-rules

### Articles added to the Dart blog {:.no_toc}

### Dart 博客新增文章 {:.no_toc}

We published the following articles on the Dart blog:

我们在 Dart 博客上发布了以下文章：

* [Better isolate management with Isolate.run()][blog-1-24-23]

  - [用 Isolate.run() 更好地管理隔离][blog-1-24-23]
* [Screenshots and automated publishing for pub.dev][blog-1-18-23]

  - [pub.dev 的截图与自动化发布][blog-1-18-23]
* [The road to Dart 3: A fully sound, null safe language][blog-12-8-22]

  - [Dart 3 之路：一门完全健全的空安全语言][blog-12-8-22]
* [Google Summer of Code 2022 Results][blog-11-3-22]

  - [Google Summer of Code 2022 成果][blog-11-3-22]
* [Partnering with GitHub on supply chain security for Dart packages][blog-10-6-22]

  - [与 GitHub 合作保障 Dart package 的供应链安全][blog-10-6-22]

[blog-1-24-23]: /blog/better-isolate-management-with-isolate-run
[blog-1-18-23]: /blog/screenshots-and-automated-publishing-for-pub-dev
[blog-12-8-22]: /blog/the-road-to-dart-3-a-fully-sound-null-safe-language
[blog-11-3-22]: /blog/google-summer-of-code-2022-results
[blog-10-6-22]: /blog/partnering-with-github-on-supply-chain-security-for-dart-packages


## 2.18 release

## 2.18 版本发布

_Released on: August 30, 2022_

_发布日期：2022 年 8 月 30 日_

This section lists notable changes made from May 12, 2022,
through August 30, 2022.
For details about the 2.18 release,
see [Dart 2.18: Objective-C & Swift interop][],
and the [SDK changelog][2-18-changelog].

本节列出 2022 年 5 月 12 日至 2022 年 8 月 30 日期间的重要变更。
有关 2.18 版本的详细信息，
请参阅 [Dart 2.18：Objective-C 与 Swift 互操作][Dart 2.18: Objective-C & Swift interop]
和[SDK 更新日志][2-18-changelog]。

[Dart 2.18: Objective-C & Swift interop]: /blog/dart-2-18-objective-c-swift-interop
[2-18-changelog]: {{site.repo.dart.sdk}}/blob/main/CHANGELOG.md#2180---2022-08-30

In addition to bug fixes and incremental improvements,
we made the following changes to this site:

除 bug 修复和渐进式改进外，
我们还对本站做了以下变更：

* Introduced the [Objective-C and Swift interop][] page,
  which explains how to use Dart packages to call APIs from those languages.

  - 引入 [Objective-C 与 Swift 互操作][Objective-C and Swift interop]页面，
    解释如何使用 Dart package 调用这两种语言的 API。
* Added a workaround to Fixing common type problems,
  for the rare case where type inference might incorrectly infer an argument type is null.

  - 在“修复常见类型问题”中添加了一种变通方法，
    应对类型推断可能错误地推断参数类型为 null 的罕见情况。
* Removed all mention of discontinued `.packages` files from [What not to commit][].
  If you still need to generate a `.packages` file due to third-party legacy dependencies,
  see [`dart pub get` Options][].

  - 从[不应提交的文件][What not to commit]中移除了所有关于
    已停用的 `.packages` 文件的内容。如果由于第三方遗留依赖
    仍需要生成 `.packages` 文件，
    请参阅 [`dart pub get` 选项][`dart pub get` Options]。
* Removed dedicated pages and any other mention of discontinued `dart2js`
  and `dartdevc` command line tools.

  - 移除了已停用的 `dart2js` 和 `dartdevc`
    命令行工具的专属页面及其他相关内容。
  * Added command line options and known issues previously associated with
  `dart2js` to the [`dart compile`][] page.

    - 将原先属于 `dart2js` 的命令行选项和已知问题
      添加到 [`dart compile`][`dart compile`] 页面。
  * Added information on debugging production code to [Debugging Dart web apps][].

    - 在[调试 Dart Web 应用][Debugging Dart web apps]中添加了调试生产代码的信息。
* Added support for downloading experimental Windows ARM builds
  to the [Dart SDK archive][].

  - 在 [Dart SDK 归档][Dart SDK archive]中
    添加了下载实验性 Windows ARM 构建的支持。
* Updated the [Library tour][] to include information on weak references and finalizers.

  - 更新了[库导览][Library tour]，加入弱引用和 finalizer 的信息。
* Added a section on customizing [`dart fix`][].

  - 新增自定义 [`dart fix`][`dart fix`] 的小节。

[Objective-C and Swift interop]: /interop/objective-c-interop
[What not to commit]: /tools/pub/private-files
[`dart pub get` Options]: /tools/pub/cmd/pub-get#options
[`dart compile`]: /tools/dart-compile
[Debugging Dart web apps]: /web/debugging
[Dart SDK archive]: /get-dart/archive
[Library tour]: /libraries/dart-core#weak-references-and-finalizers
[`dart fix`]: /tools/dart-fix#customize

## 2.17 release

## 2.17 版本发布

_Released on: May 11, 2022_

_发布日期：2022 年 5 月 11 日_

This section lists notable changes made from February 4, 2022,
through May 11, 2022.
For details about the 2.17 release,
see [Dart 2.17: Productivity and integration][].

本节列出 2022 年 2 月 4 日至 2022 年 5 月 11 日期间的重要变更。
有关 2.17 版本的详细信息，
请参阅 [Dart 2.17：生产力与集成][Dart 2.17: Productivity and integration]。

[Dart 2.17: Productivity and integration]: /blog/dart-2-17-productivity-and-integration

### Docs updated or added to dart.dev {:.no_toc}

### dart.dev 文档更新与新增 {:.no_toc}

In addition to bug fixes and incremental improvements,
we made the following changes to this site:

除 bug 修复和渐进式改进外，
我们还对本站做了以下变更：

* Introduced the Learning Dart as a JavaScript developer guide,
  which aims to leverage your JavaScript programming knowledge
  when learning Dart. _(Now removed)_

  - 引入《JavaScript 开发者学习 Dart》指南，
    帮助你在学习 Dart 时利用已有的 JavaScript 编程知识。
    _（现已移除）_
* Documented the features and changes introduced in Dart 2.17:

  - 记录了 Dart 2.17 引入的特性和变更：
  * Updated the [Named parameters][] section of the language tour
    to reflect support for specifying named arguments anywhere.

    - 更新了语言导览的[命名参数][Named parameters]小节，
      反映可在任意位置指定命名实参的支持。
  * Added documentation for [super-initializer parameters][].

    - 添加了 [super 初始化参数][super-initializer parameters]的文档。
  * Expanded the [Enumerated types][] section of the language tour
    and documented [enhanced enums][].

    - 扩充了语言导览的[枚举类型][Enumerated types]小节，
      并记录了[增强型枚举][enhanced enums]。
  * Documented support for [signing][] macOS and Windows executables
    compiled with `dart compile exe`.

    - 记录了对 `dart compile exe` 编译的 macOS 和 Windows
      可执行文件进行[签名][signing]的支持。
  * Updated the templates supported by [`dart create`][]
    to their new, standardized names.

    - 将 [`dart create`][`dart create`] 支持的模板
      更新为新的标准化名称。
* Accounted for changes to the [pub.dev site][] and the [pub tool][].

  - 记录了 [pub.dev 网站][pub.dev site]和 [pub 工具][pub tool]的变更。
  * Listed vendors offering [Dart package repositories as a service][].

    - 列出了提供 [Dart package 仓库即服务][Dart package repositories as a service]的供应商。
  * Removed documentation for the now discontinued `dart pub uploader` command.

    - 移除了现已停用的 `dart pub uploader` 命令的文档。
  * Expanded the documentation for managing pub project [uploaders][].

    - 扩充了管理 pub 项目[上传者][uploaders]的文档。
  * Removed most mentions to the deprecated `.packages` file,
    pointing instead to its `.dart_tool/package_config.json` replacement.

    - 移除了对已弃用的 `.packages` 文件的大部分提及，
      改为指向其替代文件 `.dart_tool/package_config.json`。
* Updated the documentation for updating and installing Dart:

  - 更新了关于更新和安装 Dart 的文档：
  * Documented how to switch between Dart versions
    with Homebrew within the macOS [install instructions][get-dart-install].

    - 在 macOS [安装说明][get-dart-install]中
      记录了如何用 Homebrew 切换 Dart 版本。
  * Updated the Linux [installation instructions][get-dart-install]
    to use [SecureApt][] and follow the latest best practices.

    - 更新了 Linux [安装说明][get-dart-install]，
      改用 [SecureApt][SecureApt] 并遵循最新最佳实践。
  * Added support for downloading experimental, Linux RISC-V (RV64GC) builds
    from the [Dart SDK archive][].

    - 添加了从 [Dart SDK 归档][Dart SDK archive]
      下载实验性 Linux RISC-V（RV64GC）构建的支持。
* Continued work to improve and update documentation
  of the [unified `dart` tool][dart-tool]:

  - 继续改进和更新[统一 `dart` 工具][dart-tool]的文档：
  * Expanded documentation about the functionality of the [`dart fix`][] tool.

    - 扩充了 [`dart fix`][`dart fix`] 工具功能的文档。
  * Adjusted the guidelines and documentation for the [`dart doc`][] tool
    to match its functionality and underlying behavior.

    - 调整了 [`dart doc`][`dart doc`] 工具的指南和文档，
      与其功能和底层行为保持一致。
  * Added further documentation and samples of [`dart compile js`][].

    - 添加了更多 [`dart compile js`][`dart compile js`] 的文档和示例。
  * Removed mentions of removed standalone tools.

    - 移除了对已删除的独立工具的提及。
* Updated the documentation and usage of the analyzer and linter:

  - 更新了分析器和 linter 的文档与用法：
  * Documented the analyzer's new [strict language modes][].

    - 记录了分析器新的[严格语言模式][strict language modes]。
  * Incorporated changes to the 
    [diagnostic messages][] and [linter rules][] pages.

    - 纳入了[诊断消息][diagnostic messages]
      和 [linter 规则][linter rules]页面的变更。
  * Updated documentation and samples
    to use the `2.0.0` release of the `lints` package.

    - 更新了文档和示例，
      改用 `lints` package 的 `2.0.0` 版本。
* Began an overhaul of the documentation for web compilation:

  - 开始全面改版 Web 编译文档：
  * Documented for the deprecation and planned removal
    of the `dart2js` and `dartdevc` standalone tools.

    - 记录了 `dart2js` 和 `dartdevc` 独立工具的
      弃用及计划移除。
  * Consolidated and clarified the documentation
    of `dart2js` and `dartdevc`
    as the underlying compilers of tools like
    [`dart compile js`][] and [`webdev`][].

    - 合并并澄清了 `dart2js` 和 `dartdevc` 的文档，
      将它们定位为 [`dart compile js`][`dart compile js`]
      和 [`webdev`][`webdev`] 等工具的底层编译器。
* Increased documentation coverage of null safety:

  - 扩大了空安全的文档覆盖：
  * Documented the not-null assertion operator (`!`) as part of
    the [Other operators][] section of the language tour.

    - 在语言导览的[其他运算符][Other operators]小节中
      记录了非空断言运算符（`!`）。
  * Migrated the [Low-level HTML tutorials][] to support null safety
    and discuss how to interact with web APIs while using it.

    - 将[底层 HTML 教程][Low-level HTML tutorials]迁移为支持空安全，
      并讨论使用空安全时如何与 Web API 交互。
* Made miscellaneous other updates:

  - 做了其他杂项更新：
  * Documented the [native types][] provided by `dart:ffi`
    for use in C interop.

    - 记录了 `dart:ffi` 提供的、
      用于 C 互操作的[原生类型][native types]。
  * Introduced a new section to the language tour documenting
    [initializing formal parameters][].

    - 在语言导览中新增小节，
      记录[初始化形参][initializing formal parameters]。
  * Documented DartPad's [support for packages][].

    - 记录了 DartPad [对 package 的支持][support for packages]。
  * Fixed formatting in the [asynchronous programming tutorial][]
    and elaborated on [why asynchronous code matters][].

    - 修复了[异步编程教程][asynchronous programming tutorial]的排版，
      并详细阐述了[异步代码为什么重要][why asynchronous code matters]。
  * Updated the [security][] page to match our current security practices.

    - 更新了[安全][security]页面，与我们当前的安全实践保持一致。
  * Added a key binding (`/`) to automatically focus the search bar.

    - 添加了自动聚焦搜索栏的快捷键（`/`）。

[Named parameters]: /language/functions#named-parameters
[Enumerated types]: /language/enums
[enhanced enums]: /language/enums#declaring-enhanced-enums
[super-initializer parameters]: /language/constructors#super-parameters
[signing]: /tools/dart-compile#signing
[`dart create`]: /tools/dart-create

[pub.dev site]: {{site.pub}}
[pub tool]: /tools/pub/cmd
[Dart package repositories as a service]: /tools/pub/custom-package-repositories#dart-package-repositories-as-a-service
[uploaders]: /tools/pub/publishing#uploaders

[get-dart-install]: /get-dart#install
[SecureApt]: https://wiki.debian.org/SecureApt
[Dart SDK archive]: /get-dart/archive

[dart-tool]: /tools/dart-tool
[`dart fix`]: /tools/dart-fix
[`dart doc`]: /tools/dart-doc
[`dart compile js`]: /tools/dart-compile#js

[strict language modes]: /tools/analysis#enabling-additional-type-checks
[diagnostic messages]: /tools/diagnostic-messages
[linter rules]: /tools/linter-rules

[`webdev`]: /tools/webdev

[Other operators]: /language/operators#other-operators
[Low-level HTML tutorials]: /web/get-started

[native types]: /interop/c-interop#interface-with-native-types
[initializing formal parameters]: /language/constructors#use-initializing-formal-parameters
[support for packages]: /tools/dartpad#library-support
[asynchronous programming tutorial]: /libraries/async/async-await
[why asynchronous code matters]: /libraries/async/async-await#why-asynchronous-code-matters
[security]: /security


### Articles added to the Dart blog {:.no_toc}

### Dart 博客新增文章 {:.no_toc}

We published the following articles on the Dart blog:

我们在 Dart 博客上发布了以下文章：

* [Bulk application of fixes][blog-5-5-22]

  - [批量应用修复][blog-5-5-22]
* [Dart asynchronous programming: Streams][blog-4-14-22]

  - [Dart 异步编程：Stream][blog-4-14-22]
* [Contributors for Google Summer of Code 2022][blog-4-7-22]

  - [Google Summer of Code 2022 贡献者招募][blog-4-7-22]
* [Gradual null safety migration for large Dart projects][blog-3-31-22]

  - [大型 Dart 项目的渐进式空安全迁移][blog-3-31-22]
* [Hosting a private Dart package repository][blog-3-16-22]

  - [托管私有 Dart package 仓库][blog-3-16-22]
* [Quick fixes for analysis issues][blog-3-4-22]

  - [分析问题的快速修复][blog-3-4-22]

[blog-5-5-22]: /blog/bulk-application-of-fixes
[blog-4-14-22]: /blog/dart-asynchronous-programming-streams
[blog-4-7-22]: /blog/contributors-for-google-summer-of-code-2022
[blog-3-31-22]: /blog/gradual-null-safety-migration-for-large-dart-projects
[blog-3-16-22]: /blog/hosting-a-private-dart-package-repository
[blog-3-4-22]: /blog/quick-fixes-for-analysis-issues

## 2.16 release

## 2.16 版本发布

_Released on: February 3, 2022_

_发布日期：2022 年 2 月 3 日_

This section lists notable changes made from December 8, 2021,
through February 3, 2022.
For details about the 2.16 release, 
see [Dart 2.16: Improved tooling and platform handling][].

本节列出 2021 年 12 月 8 日至 2022 年 2 月 3 日期间的重要变更。
有关 2.16 版本的详细信息，
请参阅 [Dart 2.16：改进的工具与平台支持][Dart 2.16: Improved tooling and platform handling]。

[Dart 2.16: Improved tooling and platform handling]: /blog/dart-2-16-improved-tooling-and-platform-handling

### Docs updated or added to dart.dev {:.no_toc}

### dart.dev 文档更新与新增 {:.no_toc}

We [updated the website infrastructure][] to a Docker-based setup
to enable [easier contributions][] and more closely align with
the setup for [docs.flutter.dev]({{site.flutter-docs}}).

我们[更新了网站基础设施][updated the website infrastructure]，
改用基于 Docker 的方案，以便[更容易贡献][easier contributions]，
并与 [docs.flutter.dev]({{site.flutter-docs}}) 的配置更紧密地保持一致。

In addition to other bug fixes and incremental improvements,
we made the following changes to this site:

除其他 bug 修复和渐进式改进外，
我们还对本站做了以下变更：

* Switched to documenting the new [`dart doc`][] tool 
  which replaces `dartdoc`.

  - 转而记录取代 `dartdoc` 的
    新 [`dart doc`][`dart doc`] 工具。
* Documented the new [`platform` entry][] to specify supported platforms
  within a package's `pubspec.yaml`.

  - 记录了新的 [`platform` 条目][`platform` entry]，
    用于在 package 的 `pubspec.yaml` 中指定支持的平台。
* Updated the [diagnostic messages][] and [linter rules][] pages.

  - 更新了[诊断消息][diagnostic messages]和 [linter 规则][linter rules]页面。
* Documented how to [ignore all linter rules][] in a file.

  - 记录了如何在文件中[忽略所有 linter 规则][ignore all linter rules]。
* Removed mentions of the old standalone tools from the [Dart SDK overview][].

  - 从 [Dart SDK 概览][Dart SDK overview]中移除了对旧独立工具的提及。
* Update remaining mentions of the old standalone tools
  to their [`dart`] tool equivalents.

  - 将旧独立工具的剩余提及
    更新为对应的 [`dart`][`dart`] 工具。
* Added clarifications to the
  [PREFER using interpolation to compose strings and values][]
  Effective Dart guideline.

  - 为 Effective Dart 的
    [**推荐**使用插值的形式来组合字符串和值][PREFER using interpolation to compose strings and values]
    指南添加了澄清说明。

[updated the website infrastructure]: {{site.repo.this}}/pull/3765
[easier contributions]: {{site.repo.this}}#getting-started
[`dart doc`]: /tools/dart-doc
[`platform` entry]: /tools/pub/pubspec#platforms
[ignore all linter rules]: /tools/analysis#suppressing-rules-for-a-file
[diagnostic messages]: /tools/diagnostic-messages
[linter rules]: /tools/linter-rules
[Dart SDK overview]: /tools/sdk
[PREFER using interpolation to compose strings and values]: /effective-dart/usage#prefer-using-interpolation-to-compose-strings-and-values
[`dart`]: /tools/dart-tool


## 2.15 release

## 2.15 版本发布

_Released on: December 8, 2021_

_发布日期：2021 年 12 月 8 日_

This section lists notable changes made from September 9, 2021,
through December 8, 2021.
For details about the 2.15 release, see [Announcing Dart 2.15][].

本节列出 2021 年 9 月 9 日至 2021 年 12 月 8 日期间的重要变更。
有关 2.15 版本的详细信息，请参阅[宣布 Dart 2.15][Announcing Dart 2.15]。

[Announcing Dart 2.15]: /blog/announcing-dart-2-15

### Docs updated or added to dart.dev {:.no_toc}

### dart.dev 文档更新与新增 {:.no_toc}

In addition to bug fixes and incremental improvements,
we made the following changes to this site:

除 bug 修复和渐进式改进外，
我们还对本站做了以下变更：

* Added [Concurrency in Dart][], which discusses features such as
  isolates that enable parallel execution of Dart code.

  - 新增 [Dart 并发][Concurrency in Dart]，讨论 isolate 等
    让 Dart 代码并行执行的特性。
* Documented pub features added or improved in 2.15:

  - 记录了 2.15 中新增或改进的 pub 特性：
  * Added a page for a new pub subcommand, [dart pub token][],
    and a page about [custom package repositories][]

    - 为新的 pub 子命令 [dart pub token][dart pub token] 添加了页面，
      并新增关于[自定义 package 仓库][custom package repositories]的页面
  * Added information about [package retraction][]

    - 添加了关于[撤回 package][package retraction] 的信息
  * Added the [false_secrets][] field to the pubspec page

    - 在 pubspec 页面添加了 [false_secrets][false_secrets] 字段
  * Updated the syntax for [hosted dependencies][]

    - 更新了[托管依赖][hosted dependencies]的语法
* Removed all entries for Dart 1 [books][]

  - 移除了所有 Dart 1 [书籍][books]条目
* Expanded on [DartPad troubleshooting tips][]

  - 扩充了 [DartPad 故障排查提示][DartPad troubleshooting tips]
* Updated the [diagnostic messages][] page

  - 更新了[诊断消息][diagnostic messages]页面
* Updated the [linter rules][] page;
  removed references to deprecated rule sets such as
  `effective_dart`

  - 更新了 [linter 规则][linter rules]页面；
    移除了对 `effective_dart` 等已弃用规则集的引用
* Updated the instructions for installing and using
  [Dart DevTools][]

  - 更新了安装和使用 [Dart DevTools][Dart DevTools] 的说明
* Added information about what the [Dart runtime][] provides,
  and clarified [compilation formats][]

  - 添加了关于 [Dart 运行时][Dart runtime]提供哪些能力的信息，
    并澄清了[编译格式][compilation formats]

[books]: /resources/books
[compilation formats]: /tools/dart-compile
[Concurrency in Dart]: /language/concurrency
[custom package repositories]: /tools/pub/custom-package-repositories
[Dart DevTools]: /tools/dart-devtools
[dart pub token]: /tools/pub/cmd/pub-token
[Dart runtime]: /overview#runtime
[DartPad troubleshooting tips]: /tools/dartpad/troubleshoot
[diagnostic messages]: /tools/diagnostic-messages
[false_secrets]: /tools/pub/pubspec#false_secrets
[hosted dependencies]: /tools/pub/dependencies#hosted-packages
[linter rules]: /tools/linter-rules
[package retraction]: /tools/pub/publishing#retract


## 2.14 release

## 2.14 版本发布

_Released on: September 8, 2021_

_发布日期：2021 年 9 月 8 日_

This section lists notable changes made from May 20, 2021,
through September 8, 2021.
For details about the 2.14 release, see [Announcing Dart 2.14][].

本节列出 2021 年 5 月 20 日至 2021 年 9 月 8 日期间的重要变更。
有关 2.14 版本的详细信息，请参阅[宣布 Dart 2.14][Announcing Dart 2.14]。

[Announcing Dart 2.14]: /blog/announcing-dart-2-14

### Docs updated or added to dart.dev {:.no_toc}

### dart.dev 文档更新与新增 {:.no_toc}

In addition to bug fixes and incremental improvements,
we made the following changes to this site:

除 bug 修复和渐进式改进外，
我们还对本站做了以下变更：

* Fleshed out the page on [fixing type promotion failures][no-promo].

  - 充实了[修复类型提升失败][no-promo]页面。
* Documented how to use the [`.pubignore` file][],
  a feature that was introduced in Dart 2.14.

  - 记录了如何使用 [`.pubignore` 文件][`.pubignore` file]，
    这是 Dart 2.14 引入的特性。
* Added coverage of the [unsigned shift operator][] (`>>>`),
  which was introduced in Dart 2.14.

  - 添加了对[无符号右移运算符][unsigned shift operator]（`>>>`）的介绍，
    它在 Dart 2.14 中引入。
* Built out the [linter rule page][];
  updated Effective Dart to link to it.

  - 完善了 [linter 规则页面][linter rule page]；
    更新了 Effective Dart 使其链接到该页面。
* Added pages for the
  [`dart create`][] and [`dart test`][] commands.

  - 为 [`dart create`][`dart create`] 和 [`dart test`][`dart test`] 命令
    添加了页面。
* Finished converting examples from using old command-line tools
  (for example, `dartfmt`) to using the [unified `dart` tool][dart-tool]
  (for example, `dart format`).

  - 完成了示例从旧命令行工具（例如 `dartfmt`）
    到[统一 `dart` 工具][dart-tool]（例如 `dart format`）的转换。
* Updated site code to use the [recommended linter rules][],
  instead of pedantic.

  - 更新了网站代码，改用[推荐的 linter 规则][recommended linter rules]，
    不再使用 pedantic。
* Updated the lists of [core libraries][] and [commonly used packages][].

  - 更新了[核心库][core libraries]和[常用 package][commonly used packages] 列表。
* Added a redirect from [dart.dev/jobs][] to flutter.dev/jobs,
  to make it easier to find open positions on
  the Dart and Flutter teams.

  - 添加了从 [dart.dev/jobs][dart.dev/jobs] 到 flutter.dev/jobs 的重定向，
    便于查找 Dart 和 Flutter 团队的在招职位。
* Finished migrating all analyzed or tested code to null safety,
  updating text to match.
  Found more site code that hadn't been analyzed; fixed that.

  - 完成了所有被分析或测试的代码向空安全的迁移，
    并同步更新了文字。
    还发现了更多未被分析的网站代码，一并修复。

[unsigned shift operator]: /language/operators#bitwise-and-shift-operators
[`.pubignore` file]: /tools/pub/publishing#what-files-are-published
[linter rule page]: /tools/linter-rules
[dart-tool]: /tools/dart-tool
[recommended linter rules]: /tools/analysis#lints
[core libraries]: /libraries
[commonly used packages]: /resources/useful-packages
[dart.dev/jobs]: /jobs
[no-promo]: /tools/non-promotion-reasons
[`dart create`]: /tools/dart-create
[`dart test`]: /tools/dart-test

### Articles added to the Dart blog {:.no_toc}

### Dart 博客新增文章 {:.no_toc}

We published the following articles on the Dart blog:

我们在 Dart 博客上发布了以下文章：

* [Experimenting with Dart and Wasm][blog-7-27-21]

  - [Dart 与 Wasm 的实验][blog-7-27-21]
* [How Dart's null safety helped me augment my projects][blog-6-23-21]

  - [Dart 空安全如何帮我改进项目][blog-6-23-21]
* [Implementing structs by value in Dart FFI][blog-6/8-21]

  - [在 Dart FFI 中实现结构体按值传递][blog-6/8-21]

[blog-7-27-21]: /blog/experimenting-with-dart-and-wasm
[blog-6-23-21]: /blog/how-darts-null-safety-helped-me-augment-my-projects
[blog-6/8-21]: /blog/implementing-structs-by-value-in-dart-ffi


## 2.13 release

## 2.13 版本发布

_Released on: May 19, 2021_

_发布日期：2021 年 5 月 19 日_

This section lists notable changes made from March 4, 2021,
through May 19, 2021.
For details about the 2.13 release, see [Announcing Dart 2.13][].

本节列出 2021 年 3 月 4 日至 2021 年 5 月 19 日期间的重要变更。
有关 2.13 版本的详细信息，请参阅[宣布 Dart 2.13][Announcing Dart 2.13]。

[Announcing Dart 2.13]: /blog/announcing-dart-2-13

### Docs updated or added to dart.dev {:.no_toc}

### dart.dev 文档更新与新增 {:.no_toc}

In addition to bug fixes and incremental improvements,
we made the following changes to this site:

除 bug 修复和渐进式改进外，
我们还对本站做了以下变更：

* Updated the [typedef section][] of the language tour to reflect
  non-function type aliases,
  which were introduced in Dart 2.13.

  - 更新了语言导览的 [typedef 小节][typedef section]，
    反映 Dart 2.13 引入的非函数类型别名。
* Published or updated documentation related to the command line and servers:

  - 发布或更新了与命令行和服务器相关的文档：
  * [Using Google Cloud][] describes Google Cloud products that
    Dart servers can use,
    often with the help of pre-packaged Docker images.

    - [使用 Google Cloud][Using Google Cloud] 介绍了 Dart 服务器
      可以使用的 Google Cloud 产品，
      通常借助预打包的 Docker 镜像。
  * The HTTP server tutorial,
    which featured the discontinued `http_server` package,
    has been temporarily replaced by
    an "under construction" page that
    links to helpful documentation and samples. _(Now removed)_

    - 使用已停用的 `http_server` package 的 HTTP 服务器教程
      被临时替换为一个“建设中”页面，
      其中链接了有用的文档和示例。_（现已移除）_
  * The command-line tutorial has been completely updated. _(Now removed)_

    - 命令行教程已全面更新。_（现已移除）_
* Published some other new pages:

  - 发布了其他一些新页面：
  * Null safety codelab that teaches you about Dart's null-safe type system,
    which was introduced in Dart 2.12.

    - 空安全 codelab，教你了解 Dart 2.12 引入的
      空安全类型系统。
  * [Numbers in Dart][] has
    details about differences between native and web number implementations.

    - [Dart 中的数字][Numbers in Dart]详细介绍了
      原生与 Web 数字实现之间的差异。
  * [Using Google APIs][] points to resources to
    help you use Firebase and Google client APIs from a Dart app.

    - [使用 Google API][Using Google APIs] 提供了相关资源，
      帮助你在 Dart 应用中使用 Firebase 和 Google 客户端 API。
  * [Writing package pages][] gives tips for
    writing a package README that works well on pub.dev.

    - [编写 package 页面][Writing package pages]提供了
      编写在 pub.dev 上表现良好的 package README 的技巧。
  * [Fixing type promotion failures][]
    has information to help you understand
    why type promotion failures occur, and gives tips on how to fix them.

    - [修复类型提升失败][Fixing type promotion failures]
      帮助你理解类型提升失败的原因，
      并给出修复技巧。
  * The new [`dart run` page][]
    describes how to run a Dart program from the command line.

    - 新的 [`dart run` 页面][`dart run` page]
      介绍如何从命令行运行 Dart 程序。
* Continued work on migrating code to null safety, in particular the
  [streams tutorial][].

  - 继续将代码迁移到空安全，
    尤其是 [Stream 教程][streams tutorial]。
* Made miscellaneous other updates:

  - 做了其他杂项更新：
  * Removed references to Stagehand, in favor of [`dart create`][].

    - 移除了对 Stagehand 的引用，改用 [`dart create`][`dart create`]。
  * Changed analytics options for dart.dev example code from
    using `pedantic` to using the recommended rules in [`lints`][].

    - 将 dart.dev 示例代码的分析选项从 `pedantic`
      改为 [`lints`][`lints`] 中的推荐规则。
  * Added Docker as a way to [get Dart][].

    - 添加了通过 Docker [获取 Dart][get Dart] 的方式。
  * Updated the [language evolution page][evolution] to reflect Dart 2.13.

    - 更新了[语言演进页面][evolution]以反映 Dart 2.13。

[`dart run` page]: /tools/dart-run
[`dart create`]: /tools/dart-create
[Fixing type promotion failures]: /tools/non-promotion-reasons
[get Dart]: /get-dart
[`lints`]: {{site.pub-pkg}}/lints
[Numbers in Dart]: /resources/language/number-representation
[streams tutorial]: /libraries/async/using-streams
[typedef section]: /language/typedefs
[Using Google APIs]: /resources/google-apis
[Using Google Cloud]: /server/google-cloud
[Writing package pages]: /tools/pub/writing-package-pages


### Articles added to the Dart blog {:.no_toc}

### Dart 博客新增文章 {:.no_toc}

We published the following articles on the Dart blog:

我们在 Dart 博客上发布了以下文章：

* [AngularDart, Flutter, and the web: Spring update][blog-5-12-21]

  - [AngularDart、Flutter 与 Web：春季更新][blog-5-12-21]
* [Announcing Dart support for GitHub Actions][blog-3-24-21]

  - [宣布 Dart 支持 GitHub Actions][blog-3-24-21]
* [Dart in Google Summer of Code 2021][blog-3-13-21]

  - [Dart 参加 Google Summer of Code 2021][blog-3-13-21]

[blog-5-12-21]: /blog/angulardart-flutter-and-the-web-spring-update
[blog-3-24-21]: /blog/announcing-dart-support-for-github-actions
[blog-3-13-21]: /blog/dart-in-google-summer-of-code-2021


## 2.12 release

## 2.12 版本发布

_Released on: March 3, 2021_

_发布日期：2021 年 3 月 3 日_

This section lists notable changes made from October 2, 2020,
through March 3, 2021.
For details about the 2.12 release, see [Announcing Dart 2.12][].

本节列出 2020 年 10 月 2 日至 2021 年 3 月 3 日期间的重要变更。
有关 2.12 版本的详细信息，请参阅[宣布 Dart 2.12][Announcing Dart 2.12]。


### Docs updated or added to dart.dev {:.no_toc}

### dart.dev 文档更新与新增 {:.no_toc}

In addition to bug fixes and incremental improvements, we made the following changes to this site:

除 bug 修复和渐进式改进外，我们还对本站做了以下变更：

* Updated and fleshed out null safety docs _(now [archived][ns-archive])_:

  - 更新并充实了空安全文档_（现已[归档][ns-archive]）_：
  * Provided a migration guide.

    - 提供了迁移指南。
  * Added a FAQ.

    - 添加了常见问题解答。
  * Created unsound null safety documentation.

    - 创建了非健全空安全文档。
  * Simplified the [null safety homepage][].

    - 简化了[空安全主页][null safety homepage]。
* Refreshed [Effective Dart][], updating code to be null safe and
  changing rules to reflect new guidance.

  - 刷新了 [Effective Dart][Effective Dart]，将代码更新为空安全，
    并修改规则以反映新的指导。
* Refreshed the [language tour][], updating code to be null safe and
  adding information about new features such as
  [`late` variables][].

  - 刷新了[语言导览][language tour]，将代码更新为空安全，
    并添加了 [`late` 变量][`late` variables]等新特性的信息。
* Updated the [language evolution page][evolution]
  to add information about language versioning
  and to reflect Dart 2.12.

  - 更新了[语言演进页面][evolution]，
    添加语言版本的相关信息并反映 Dart 2.12。
* Updated the [library tour][] and tutorials
  to reflect sound null safety.

  - 更新了[库导览][library tour]和教程，
    以反映健全空安全。
* Updated pages across the site to use [the `dart` tool][]
  instead of deprecated commands.
  Started adding pages for various `dart` commands, including
  [`dart analyze`][], [`dart compile`][], [`dart fix`][],
  and [`dart format`][].

  - 更新了全站页面，改用 [`dart` 工具][the `dart` tool]
    而非已弃用的命令。
    开始为各个 `dart` 命令添加页面，包括
    [`dart analyze`][`dart analyze`]、[`dart compile`][`dart compile`]、
    [`dart fix`][`dart fix`]和 [`dart format`][`dart format`]。
* Created a page documenting the quality and support of [Dart team packages][].

  - 创建了一个页面，记录 [Dart 团队 package][Dart team packages] 的质量与支持情况。
* Replaced the Platforms page with a new [Overview page][].

  - 用新的[概览页面][Overview page]替换了平台页面。
* Created this page ("What's new").

  - 创建了本页面（“新内容”）。

We also switched from Travis CI to GitHub Actions, and we made multiple CSS changes to improve site legibility.

我们还从 Travis CI 切换到了 GitHub Actions，并做了多处 CSS 改动以提升网站可读性。

[Announcing Dart 2.12]: /blog/announcing-dart-2-12
[ns-archive]: https://github.com/dart-community/migrate-to-null-safety
[null safety homepage]: /null-safety
[Overview page]: /overview
[Effective Dart]: /effective-dart
[language tour]: /language
[`late` variables]: /language/variables#late-variables
[library tour]: /libraries

[the `dart` tool]: /tools/dart-tool
[`dart analyze`]: /tools/dart-analyze
[`dart compile`]: /tools/dart-compile
[`dart fix`]: /tools/dart-fix
[`dart format`]: /tools/dart-format
[Dart team packages]: /resources/dart-team-packages


### Articles added to the Dart blog {:.no_toc}

### Dart 博客新增文章 {:.no_toc}

We published the following articles on the Dart blog:

我们在 Dart 博客上发布了以下文章：

* [Preparing the Dart and Flutter ecosystem for null safety][blog-2-16-21]
  announced null safety API stability and
  invited developers to publish stable, null-safe versions of their packages.

  - [让 Dart 和 Flutter 生态为空安全做好准备][blog-2-16-21]
    宣布了空安全 API 的稳定，
    并邀请开发者发布空安全的稳定版 package。
* [Dart and the performance benefits of sound types][blog-1-19-21]
  demonstrated how soundness and null safety enable Dart compilers to
  generate faster, smaller code.

  - [Dart 与健全类型的性能优势][blog-1-19-21]
    展示了健全性和空安全如何让 Dart 编译器
    生成更快、更小的代码。
* [Why nullable types?][blog-12-7-20]
  expanded on a discussion on the /r/dart_lang subreddit,
  answering the question "Why not get rid of null completely?"

  - [为什么需要可空类型？][blog-12-7-20]
    扩展了 /r/dart_lang 子版块上的一场讨论，
    回答“为什么不彻底去掉 null？”这个问题。
* [Announcing Dart null safety beta][blog-11-19-20]
  invited developers to start planning their migration to null safety.

  - [宣布 Dart 空安全进入 beta 阶段][blog-11-19-20]
    邀请开发者开始规划向空安全的迁移。

[blog-2-16-21]: /blog/preparing-the-dart-and-flutter-ecosystem-for-null-safety
[blog-1-19-21]: /blog/dart-and-the-performance-benefits-of-sound-types
[blog-12-7-20]: /blog/why-nullable-types
[blog-11-19-20]: /blog/announcing-dart-null-safety-beta

## 2.10 release

## 2.10 版本发布

_Released on: October 1, 2020_

_发布日期：2020 年 10 月 1 日_

This section lists notable changes made from
July 1 through October 1, 2020.
For details about the 2.10 release, see [Announcing Dart 2.10.][210-ann]

本节列出 2020 年 7 月 1 日至 2020 年 10 月 1 日期间的重要变更。
有关 2.10 版本的详细信息，请参阅[宣布 Dart 2.10][210-ann]。

[210-ann]: /blog/announcing-dart-2-10

<div class="no_toc_section">

### Docs updated or added to dart.dev {:.no_toc}

### dart.dev 文档更新与新增 {:.no_toc}

In addition to bug fixes and small improvements,
we made the following changes to this site:

除 bug 修复和小改进外，
我们还对本站做了以下变更：

* Added a [`dart` tool page][dart-tool]
  to document the new command-line interface to the Dart SDK.
  The new `dart` tool is analogous to the `flutter` tool in the Flutter SDK.
  Previously, the `dart` command only ran command-line apps.
  We updated the previous `dart` page accordingly
  and plan to update references to other tools over time.

  - 添加了 [`dart` 工具页面][dart-tool]，
    记录 Dart SDK 的新命令行界面。
    新的 `dart` 工具类似于 Flutter SDK 中的 `flutter` 工具。
    此前 `dart` 命令只能运行命令行应用。
    我们相应更新了旧的 `dart` 页面，
    并计划逐步更新对其他工具的引用。
* Updated the [package changelog documentation][changelog-docs]
  to recommend a standard format for `CHANGELOG.md` files.
  This new format lets tools
  (such as the relaunched pub.dev)
  parse changelogs.

  - 更新了 [package 更新日志文档][changelog-docs]，
    推荐 `CHANGELOG.md` 文件使用标准格式。
    这种新格式让工具（例如重新上线的 pub.dev）
    能够解析更新日志。
* Changed an [Effective Dart][] guideline to favor
  using `Object` instead of `dynamic`.
  For details, see the revised guideline
  [AVOID using `dynamic` unless you want to disable static checking.][dynamic]

  - 修改了一条 [Effective Dart][Effective Dart] 指南，
    倾向于使用 `Object` 而非 `dynamic`。
    详情见修订后的指南
    [**避免**使用 `dynamic`，除非你想禁用静态检查][dynamic]。
* Updated the [diagnostic messages page][diagnostics] to
  include more messages produced by the Dart analyzer.

  - 更新了[诊断消息页面][diagnostics]，
    纳入 Dart 分析器产生的更多消息。
* Updated the [evolution page][evolution]
  to include 2.9 and 2.10.

  - 更新了[演进页面][evolution]，
    纳入 2.9 和 2.10。
* Reorganized the [language specification page][spec]
  to make it easier to find the PDF version of
  the latest, in-progress specification.

  - 重组了[语言规范页面][spec]，
    便于找到最新的、仍在编写中的规范的 PDF 版本。
* Added or updated docs related to [sound null safety][],
  a feature that's coming to the Dart language:

  - 添加或更新了与[健全空安全][sound null safety]相关的文档，
    这是 Dart 语言即将推出的特性：
  * Clarified how to use [experiment flags with IDEs][experiments].

    - 澄清了如何[在 IDE 中使用实验标志][experiments]。
  * Updated the null safety page, adding information about
    [how to enable null safety][ns-enable].

    - 更新了空安全页面，
      添加[如何启用空安全][ns-enable]的信息。
  * Added a deep dive into null safety,
    [Understanding null safety][],
    written by Dart engineer Bob Nystrom.

    - 添加了深入讲解空安全的[理解空安全][Understanding null safety]，
      由 Dart 工程师 Bob Nystrom 撰写。

[dart-tool]: /tools/dart-tool
[diagnostics]: /tools/diagnostic-messages
[dynamic]: /effective-dart/design#avoid-using-dynamic-unless-you-want-to-disable-static-checking
[Effective Dart]: /effective-dart
[evolution]: /resources/language/evolution
[experiments]: /tools/experiment-flags#using-experiment-flags-with-ides
[ns-enable]: /null-safety#enable-null-safety
[Understanding null safety]: /null-safety/understanding-null-safety
[sound null safety]: /null-safety
[diagnostics]: /tools/diagnostic-messages
[changelog-docs]: /tools/pub/package-layout#changelog
[spec]: /resources/language/spec

### Articles added to the Dart blog {:.no_toc}

### Dart 博客新增文章 {:.no_toc}

We published the following articles on the [Dart blog:][Dart blog]

我们在 [Dart 博客][Dart blog]上发布了以下文章：

* [Exploring collections in Dart][] helps you use collections
  (lists, maps, sets, and more), with special attention to
  2.3 language features like collection if, collection for, and spreads.

  - [探索 Dart 中的集合][Exploring collections in Dart]帮助你使用集合
    （list、map、set 等），尤其关注 2.3 的语言特性，
    如集合 if、集合 for 和展开。
* [Google Summer of Code 2020 results][] describes the results of
  five projects that the Dart team mentored.

  - [Google Summer of Code 2020 成果][Google Summer of Code 2020 results]
    介绍了 Dart 团队指导的五个项目的成果。
* [Introducing a brand new pub.dev][] announces the relaunch of
  the [pub.dev site,][pub.dev] with new package scoring metrics, improved search,
  and a redesigned UI.

  - [全新的 pub.dev 登场][Introducing a brand new pub.dev]宣布
    [pub.dev 网站][pub.dev]重新上线，带来新的 package 评分指标、
    改进的搜索和重新设计的 UI。

We also improved the blog navigation,
adding **announcement** and **archive** tabs, plus a link to dart.dev.

我们还改进了博客导航，
新增 **announcement**（公告）和 **archive**（归档）标签页，
以及指向 dart.dev 的链接。

:::tip
All articles in the Dart blog are free to read.

Dart 博客中的所有文章都可以免费阅读。
:::

</div>

[Dart blog]: /blog
[Exploring collections in Dart]: /blog/exploring-collections-in-dart
[Google Summer of Code 2020 results]: /blog/google-summer-of-code-2020-results
[Introducing a brand new pub.dev]: /blog/introducing-a-brand-new-pub-dev
[pub.dev]: {{site.pub}}
