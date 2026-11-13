---
# title: Language versioning
title: 语言版本控制
# description: >-
#   Learn how language versioning in Dart enables evolution of the language
#   and how to configure the language versions of your project and its libraries.
description: 了解 Dart 的语言版本控制如何让语言得以演进，以及如何配置项目及其库的语言版本。
ai-translated: true
---

## Overview

## 概述

A single Dart SDK can simultaneously support
multiple versions of the Dart language.
The compiler determines what version the code is targeting,
and it interprets the code according to that version.

同一个 Dart SDK 可以同时支持
多个版本的 Dart 语言。
编译器会判断代码面向的是哪个版本，
并按照该版本来解释代码。

Language versioning becomes important on the rare occasions when Dart
introduces an incompatible feature like [null safety][].
When Dart introduces a breaking change, code that
did compile might no longer compile.
Language versioning allows you to set each library's language version
to maintain compatibility.

当 Dart 偶尔引入不兼容的特性（例如 [空安全][null safety]）时，
语言版本控制就变得重要了。
当 Dart 引入破坏性变更时，原先能编译的代码
可能再也无法编译。
语言版本控制让你可以为每个库设置语言版本，
从而保持兼容。

In the case of null safety, Dart SDKs 2.12 through 2.19 allowed you
to _choose_ to update your code to use null safety.
Dart uses language versioning to permit non-null-safe code to run
alongside null-safe code.
This decision enabled migration from non-null-safe to null-safe code.
To review an example of how an app or package can migrate to a new
language version with an incompatible feature, check out this article on
[Gradual null safety migration for large Dart projects][].

就空安全而言，Dart SDK 2.12 到 2.19 让你可以
**选择** 是否把代码更新为使用空安全。
Dart 用语言版本控制，让非空安全的代码
可以和空安全的代码一起运行。
这个决定使得从非空安全代码迁移到空安全代码成为可能。
想看应用或 package 如何迁移到带有不兼容特性的新语言版本，
请参阅这篇文章：
[大型 Dart 项目的渐进式空安全迁移][Gradual null safety migration for large Dart projects]。

Each package has a default language version equal to the **lower bound**
of the [SDK constraint][] in the `pubspec.yaml` file.

每个 package 的默认语言版本，等于 `pubspec.yaml` 文件中
[SDK 约束][SDK constraint] 的 **下界**。

**For example:** The following entry in a `pubspec.yaml` file
indicates that this package defaults to the Dart 2.18 language version.

**例如：** 下面这条 `pubspec.yaml` 记录
表示该 package 默认使用 Dart 2.18 语言版本。

```yaml
environment:
  sdk: '>=2.18.0 <3.0.0'
```

To learn how and why the Dart team developed this versioning method,
check out the [language versioning specification][].

想了解 Dart 团队为何以及如何设计这套版本方法，
请参阅 [语言版本控制规范][language versioning specification]。

[null safety]: /null-safety
[Gradual null safety migration for large Dart projects]: /blog/gradual-null-safety-migration-for-large-dart-projects
[SDK constraint]: /tools/pub/pubspec#sdk-constraints
[language versioning specification]: {{site.repo.dart.lang}}/blob/main/accepted/2.8/language-versioning/feature-specification.md#dart-language-versioning

## Language version numbers

## 语言版本号

Dart formats its language versions as two numbers separated with a period.
It reads as a major version number and a minor version number.
Minor version numbers might introduce breaking changes.

Dart 把语言版本写成用句点分隔的两个数字。
它们分别是主版本号和次版本号。
次版本号可能引入破坏性变更。

Dart releases might append a patch number to a language version.
Patches should not change the language except for bug fixes.
To illustrate: Dart 2.18.3 serves as the latest release of the
Dart 2.18 SDK language version.

Dart 的发布版本可能会在语言版本后面再加上补丁号。
除了问题修复，补丁不应改变语言。
举例来说：Dart 2.18.3 是
Dart 2.18 SDK 语言版本的最新发布。

Each Dart SDK release supports its own language version and
all previous versions within the same major version number.
That means that Dart SDK 2.18.3 supports language versions
2.0 through 2.18 inclusive, but not Dart 1.x.

每个 Dart SDK 发布版都支持它自己的语言版本，
以及同一主版本号内的所有更早版本。
也就是说，Dart SDK 2.18.3 支持的语言版本
包括 2.0 到 2.18（含两端），但不包括 Dart 1.x。

Deriving the language version from the SDK version implies the following:

从 SDK 版本推导语言版本，意味着：

* Whenever a minor version of the SDK ships, a new language version appears.
  In practice, many of these language versions work in a very similar manner
  to previous versions and have with full compatibility between them.
  For example: The Dart 2.9 language works much like the Dart 2.8 language.

  SDK 每发布一个次版本，就会出现一个新的语言版本。
  实际上，这些语言版本中有许多与先前版本的工作方式非常接近，
  并且彼此完全兼容。
  例如：Dart 2.9 语言的工作方式与 Dart 2.8 非常相似。

* When a patch release of the SDK ships,
  it cannot introduce new language features.
  For example: The 2.18.3 release _remains_ language version 2.18.
  It must remain compatible with 2.18.2, 2.18.1, and 2.18.0.

  当 SDK 发布补丁版本时，
  它不能引入新的语言特性。
  例如：2.18.3 发布版 **仍然是** 语言版本 2.18。
  它必须与 2.18.2、2.18.1 和 2.18.0 保持兼容。

## Per-library language version selection {: #library-override}

## 按库选择语言版本

By default, every Dart file in a package uses the same language version.
Dart identifies the default language version as the
lower-bound of the SDK constraint specified in the `pubspec.yaml` file.
Sometimes, a Dart file might need to use an older language version.
For example, you might not be able to migrate all the files in a package
to null safety at the same time.

默认情况下，一个 package 里的每个 Dart 文件都使用相同的语言版本。
Dart 把 `pubspec.yaml` 文件中 SDK 约束的
下界当作默认语言版本。
有时，某个 Dart 文件需要使用更旧的语言版本。
例如，你可能无法同时把一个 package 里的所有文件
都迁移到空安全。

Dart supports per-library language version selection.
To opt to have a different language version from
the rest of a package, a [Dart library][] must
include a comment in the following format:

Dart 支持按库选择语言版本。
如果希望某个库使用与 package 其余部分不同的语言版本，
这个 [Dart 库][Dart library] 必须
包含如下格式的注释：

```dart
// @dart = <major>.<minor>
```

For example:

```dart
// Description of what's in this file.
// @dart = 2.17
import 'dart:math';

// ...
```

The `@dart` string must be in a `//` comment (not `///` or `/*`),
and it must appear before any Dart code in the file.
Whitespace (tabs and spaces) doesn't matter,
except within the `@dart` and version strings.
As the previous example shows,
other comments can appear before the `@dart` comment.

`@dart` 字符串必须放在 `//` 注释里（不能是 `///` 或 `/*`），
并且必须出现在文件中任何 Dart 代码之前。
空白（制表符和空格）无关紧要，
但 `@dart` 和版本字符串内部除外。
如前面的例子所示，
`@dart` 注释前面可以有其他注释。

[Dart library]: /tools/pub/create-packages#organizing-a-package

## Language-versioned changes

## 随语言版本变化的变更

Language versioning helps Dart and its tooling evolve over time.
Besides potentially breaking syntax and semantic language changes,
new features and tooling changes might also be gated behind a language version.
For example, `dart format` might format Dart code differently depending on
the language version of the library it is formatting.

语言版本控制帮助 Dart 及其工具链随时间演进。
除了可能破坏兼容性的语法和语义变更，
新特性和工具变更也可能被语言版本门槛挡住。
例如，`dart format` 可能会根据
所格式化库的语言版本，以不同方式格式化 Dart 代码。

To find what changes each language version introduced,
you can reference the filterable [Dart changelog][].
To learn specific details about each language version and its features,
check out the [language documentation][] and the [language specification][].

要查找每个语言版本引入了哪些变更，
可以参考可筛选的 [Dart 更新日志][Dart changelog]。
要了解每个语言版本及其特性的具体细节，
请参阅 [语言文档][language documentation] 和 [语言规范][language specification]。

:::tip
To review new Dart features and changes being
discussed, designed, and implemented,
check out the [Dart language funnel][] project on GitHub.

想查看正在讨论、设计和实现的新 Dart 特性与变更，
请参阅 GitHub 上的 [Dart 语言漏斗][Dart language funnel] 项目。

:::

[Dart changelog]: /changelog
[language documentation]: /language
[language specification]: /resources/language/spec
[Dart language funnel]: https://github.com/orgs/dart-lang/projects/90
