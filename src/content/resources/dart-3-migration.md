---
# title: Dart 3 migration guide
title: Dart 3 迁移指南
# description: How to migrate existing Dart code to be compatible with Dart 3.
description: 如何迁移现有 Dart 代码，使其兼容 Dart 3。
ai-translated: true
---

Dart 3 is a major release that introduces new core capabilities to Dart: 
[records][], [patterns][], and [class modifiers][].

Dart 3 是一个主要版本，为 Dart 引入了新的核心能力：
[记录类型][records]、[模式][patterns] 和 [类修饰符][class modifiers]。

Alongside these new capabilities, Dart 3 contains a number of changes
that may break existing code. 

除了这些新能力，Dart 3 还包含一些
可能破坏现有代码的改动。

This guide will help you resolve any migration issues you might encounter
after [upgrading to Dart 3](/get-dart).

本指南帮助你解决 [升级到 Dart 3](/get-dart) 之后
可能遇到的迁移问题。

## Introduction

## 简介

### Unversioned vs versioned changes

### 无版本变更与有版本变更

The potentially breaking changes listed below fall into one of two categories:

下面列出的潜在破坏性改动分为两类：

* **Unversioned changes**: These changes affect any Dart code
  after upgrading to a Dart 3.0 SDK or later. 
  There is no way to "turn off" these changes.

  **无版本变更**：升级到 Dart 3.0 或更高版本的 SDK 之后，
  这些变更会影响任何 Dart 代码。
  没有办法「关掉」这些变更。

* **Versioned changes**: These changes only apply when the package or app's
  language version is set to >= Dart 3.0. 
  The [language version](/language/versioning#language-version-numbers)
  is derived from the `sdk` lower-constraint in the
  [`pubspec.yaml` file](/tools/pub/packages#creating-a-pubspec). 
  An SDK constraint like this does *not* apply the Dart 3 versioned changes:

  **有版本变更**：只有当 package 或应用的语言版本
  设为大于等于 Dart 3.0 时，这些变更才会生效。
  [语言版本](/language/versioning#language-version-numbers)
  来自 [`pubspec.yaml` 文件](/tools/pub/packages#creating-a-pubspec)
  中 `sdk` 约束的下界。
  像下面这样的 SDK 约束 **不会** 应用 Dart 3 的有版本变更：

  ```yaml
  environment:
    sdk: '>=2.14.0 <3.0.0'
  ```
  
  But an SDK constraint like this does:

  而像下面这样的 SDK 约束则会：

  ```yaml
  environment:
    sdk: '>=3.0.0 <4.0.0'
  ```

To use the new Dart 3 features you have to
update the language version to 3.0. 
This gets you the Dart 3 versioned changes at the same time.

要使用新的 Dart 3 特性，你必须
把语言版本更新到 3.0。
与此同时，你也会得到 Dart 3 的有版本变更。

### Dart 3 backwards compatibility

### Dart 3 的向后兼容

Many packages and apps that used null safety with Dart 2.12 or
later are likely backwards compatible with Dart 3. 
This is possible for any package where 
the lower bound of the SDK constraint is 2.12.0 or higher. 

许多在 Dart 2.12 或更高版本中使用了空安全的 package 和应用，
很可能向后兼容 Dart 3。
只要 package 的 SDK 约束下界是 2.12.0 或更高，就有可能。

[Dart's pub tool](/tools/pub/packages) allows resolution even when
the upper bound is limited to versions below 3.0.0. 
For example, a package with the following constraint
will be allowed to resolve with a Dart 3.x SDK, 
as pub will re-interpret the upper-constraint `<3.0.0` as `<4.0.0`
when the lower constraint is `2.12` or higher:

即使上界限制在 3.0.0 以下的版本，
[Dart 的 pub 工具](/tools/pub/packages) 也允许解析。
例如，具有下面这种约束的 package
可以与 Dart 3.x SDK 一起解析，
因为当下界是 `2.12` 或更高时，
pub 会把上界约束 `<3.0.0` 重新解释为 `<4.0.0`：

```yaml
environment:
  sdk: '>=2.14.0 <3.0.0'           # This is interpreted as '>=2.14.0 <4.0.0'
```

This allows developers to use Dart 3 sound null safety with packages
that already support 2.12 null safety
without needing a second migration, unless 
the code is affected by any other Dart 3 changes.

这样，开发者就可以把 Dart 3 的健全空安全
用于已经支持 2.12 空安全的 package，
而不需要再做一次迁移，除非
代码受到其他 Dart 3 变更的影响。

### Testing for impact

### 测试影响

To understand if your source code is impacted by any Dart 3 changes, 
use these steps:

要了解源代码是否受到任何 Dart 3 变更的影响，
请按这些步骤操作：

```console
$ dart --version    # Make sure this reports 3.0.0 or higher.
$ dart pub get      # This should resolve without issues.
$ dart analyze      # This should pass without errors.
```

If the `pub get` step fails, try to upgrade your dependencies
to see if more recent versions might support Dart 3:

如果 `pub get` 这一步失败，试着升级依赖，
看看更新的版本是否支持 Dart 3：

```console
$ dart pub upgrade
$ dart analyze      # This should pass without errors.
```

Or, if needed, also include [major versions][] upgrades:

或者，如有需要，也包含 [主版本][major versions] 升级：

```console
$ dart pub upgrade --major-versions
$ dart analyze      # This should pass without errors.
```

[major versions]: /tools/pub/cmd/pub-upgrade#major-versions

## Dart 3 language changes

## Dart 3 的语言变更

### 100% sound null safety

### 100% 健全的空安全

Dart 2.12 introduced null safety more than two years ago. 
In Dart 2.12, users needed to enable null safety [with a pubspec setting][].
In Dart 3, null safety is built in; you cannot turn it off.

Dart 2.12 在两年多前引入了空安全。
在 Dart 2.12 中，用户需要 [通过 pubspec 设置][with a pubspec setting] 来启用空安全。
在 Dart 3 中，空安全是内建的，你无法关闭它。

[with a pubspec setting]: /null-safety#enable-null-safety

#### Scope

#### 范围

This is an [*unversioned* change](#unversioned-vs-versioned-changes), 
that applies to all Dart 3 code.

这是一项 [**无版本** 变更](#unversioned-vs-versioned-changes)，
适用于所有 Dart 3 代码。

#### Symptom

#### 症状

Packages developed without null safety support will cause issues
when resolving dependencies with `pub get`:

没有空安全支持的 package 在用 `pub get` 解析依赖时会出问题：

```console
$ dart pub get

Because pkg1 doesn't support null safety, version solving failed.
The lower bound of "sdk: '>=2.9.0 <3.0.0'" must be 2.12.0 or higher to enable null safety.
```

Libraries that opt out of null safety with [language version comments][]
that select any language version below `2.12` will
cause analysis or compilation errors:

用 [语言版本注释][language version comments]
选择低于 `2.12` 的任何语言版本、从而退出空安全的库，
会导致分析或编译错误：

```console
$ dart analyze .
Analyzing ....                         0.6s

  error • lib/pkg1.dart:1:1 • The language version must be >=2.12.0. 
  Try removing the language version override and migrating the code.
  • illegal_language_version_override
```

```console
$ dart run bin/my_app.dart
../pkg1/lib/pkg1.dart:1:1: Error: Library doesn't support null safety.
// @dart=2.9
^^^^^^^^^^^^
```

[language version comments]: /language/versioning#library-override

#### Migration

#### 迁移

Before beginning any migration to Dart 3,
ensure your app or package has been 100% migrated to enable null safety.
This requires a Dart `2.19` SDK, not a Dart 3 SDK.
To learn how to first migrate your app or package to support null safety,
check out the [null safety migration guide][].

开始向 Dart 3 迁移之前，
请确保应用或 package 已经 100% 迁移到空安全。
这需要 Dart `2.19` SDK，而不是 Dart 3 SDK。
想了解如何先把应用或 package 迁移到支持空安全，
请查阅 [空安全迁移指南][null safety migration guide]。

[null safety migration guide]: https://github.com/dart-community/migrate-to-null-safety/blob/main/docs/migrate.md#migrate-to-null-safety

### Colon-syntax for default values

### 默认值的冒号语法

For historical reasons, named optional parameters could
specify their default value using either `:` or `=`. 
In Dart 3, only the `=` syntax is allowed.

由于历史原因，命名可选参数可以用 `:` 或 `=`
来指定默认值。
在 Dart 3 中，只允许 `=` 语法。

#### Scope

#### 范围

This is a [*versioned* change](#unversioned-vs-versioned-changes), 
that only applies to language version 3.0 or later.

这是一项 [**有版本** 变更](#unversioned-vs-versioned-changes)，
只适用于语言版本 3.0 或更高。

#### Symptom

#### 症状

Dart analysis produces errors like:

Dart 分析会产生类似这样的错误：

```plaintext
line 2 • Using a colon as a separator before a default value is no longer supported.
```

#### Migration

#### 迁移

Change from using colons:

不要再用冒号：

```dart
int someInt({int x: 0}) => x;
```

To using equals:

改用等号：

```dart
int someInt({int x = 0}) => x;
```

This migration can be made manually, or automated with `dart fix`:

这次迁移可以手动完成，也可以用 `dart fix` 自动完成：

```console
$ dart fix --apply --code=obsolete_colon_for_default_value
```

### `mixin`

### `mixin` 的变化

Pre-Dart 3, any `class` could be used as a `mixin`, as long as
it had no declared constructors and no superclass other than `Object`.

在 Dart 3 之前，任何 `class` 都可以用作 `mixin`，
只要它没有声明构造函数，并且除了 `Object` 之外没有其他超类。

In Dart 3, classes declared in libraries at language version 3.0 or later
can't be used as mixins unless marked `mixin`.
This restriction applies to code in any library
attempting to use the class as a mixin, 
regardless of the latter library's language version.

在 Dart 3 中，语言版本为 3.0 或更高的库里声明的类，
除非标成 `mixin`，否则不能当作 mixin 使用。
这一限制适用于任何试图把该类用作 mixin 的库中的代码，
与后一个库的语言版本无关。

#### Scope

#### 范围

This is a [*versioned* change](#unversioned-vs-versioned-changes), 
that only applies to language version 3.0 or later.

这是一项 [**有版本** 变更](#unversioned-vs-versioned-changes)，
只适用于语言版本 3.0 或更高。

#### Symptom

#### 症状

An analysis error like:

类似这样的分析错误：

```plaintext
Mixin can only be applied to class.
```

The analyzer produces this diagnostic when a class that is neither a
`mixin class` nor a `mixin` is used in a `with` clause.

当一个既不是 `mixin class` 也不是 `mixin` 的类
被用在 `with` 子句中时，分析器会产生这条诊断。

#### Migration

#### 迁移

Determine if the class is intended to be used as a mixin.

确认这个类是否本意就是用作 mixin。

If the class defines an interface, consider using `implements`.

如果这个类定义的是接口，可以考虑使用 `implements`。

### `switch`

### `switch` 的变化

Dart 3.0 interprets [switch](/language/branches#switch) cases
as [patterns][] instead of constant expressions. 

Dart 3.0 把 [switch](/language/branches#switch) 的 case
解释为 [模式][patterns]，而不是常量表达式。

#### Scope

#### 范围

This is a [*versioned* change](#unversioned-vs-versioned-changes), 
that only applies to language version 3.0 or later.

这是一项 [**有版本** 变更](#unversioned-vs-versioned-changes)，
只适用于语言版本 3.0 或更高。

#### Symptom

#### 症状

Most constant expressions found in switch cases are valid patterns
with the same meaning (named constants, literals, etc.).
These will behave the same and no symptoms will arise.

switch case 里的大多数常量表达式都是含义相同的合法模式
（命名常量、字面量等）。
它们的行为相同，不会出现症状。

The few constant expressions that aren't valid patterns
will trigger the [`invalid_case_patterns` lint][].

少数不是合法模式的常量表达式
会触发 [`invalid_case_patterns` lint][]。

[`invalid_case_patterns` lint]: /tools/linter-rules/invalid_case_patterns

#### Migration

#### 迁移

You can revert back to the original behavior by prefixing
the case pattern with `const`, so it's no longer interpreted as a pattern:

你可以在 case 模式前加上 `const`，回到原来的行为，
这样它就不再被解释为模式：

```dart
case const [1, 2]:
case const {'k': 'v'}:
case const {1, 2}:
case const Point(1, 2):
```

You can run a quick fix for this breaking change, 
by using `dart fix` or from your IDE.

你可以用 `dart fix` 或在 IDE 里
对这项破坏性改动运行快速修复。

### `continue`

### `continue` 的变化

Dart 3 reports a compile-time error if a continue statement targets a label
that is not a loop (`for`, `do`, and `while` statements) or a switch member.

如果 continue 语句的目标标签不是循环
（`for`、`do` 和 `while` 语句）或 switch 成员，
Dart 3 会报告编译时错误。

#### Scope

#### 范围

This is a [*versioned* change](#unversioned-vs-versioned-changes), 
that only applies to language version 3.0 or later.

这是一项 [**有版本** 变更](#unversioned-vs-versioned-changes)，
只适用于语言版本 3.0 或更高。

#### Symptom

#### 症状

You will see an error like:

你会看到类似这样的错误：

```plaintext
The label used in a 'continue' statement must be defined on either a loop or a switch member.
```

#### Migration

#### 迁移

If changing behavior is acceptable, 
change the `continue` to target a valid labeled statement,
which must be attached to a `for`, `do` or `while` statement.

如果可以改变行为，
就把 `continue` 的目标改成合法的带标签语句，
它必须附在 `for`、`do` 或 `while` 语句上。

If you want to preserve behavior, change the
`continue` statement to a `break` statement.
In previous versions of Dart, a `continue` statement 
that wasn't targeted at a loop or a switch member 
behaved like `break`.

如果想保持行为，把 `continue` 语句改成 `break` 语句。
在以前的 Dart 版本中，目标不是循环或 switch 成员的
`continue` 语句，行为与 `break` 相同。

## Dart 3 core library changes

## Dart 3 核心库的变更

### APIs removed

### 移除的 API

**Breaking change [#49529][]**: The core libraries have been cleaned up
to remove APIs that have been deprecated for several years. 
The following APIs no longer exist in the Dart core libraries.

**破坏性改动 [#49529][]**：核心库已清理，
移除了弃用多年的 API。
下面这些 API 不再存在于 Dart 核心库中。

[#49529]: {{site.repo.dart.sdk}}/issues/49529

#### Scope

#### 范围

This is an [*unversioned* change](#unversioned-vs-versioned-changes), 
that applies to all Dart 3 code.

这是一项 [**无版本** 变更](#unversioned-vs-versioned-changes)，
适用于所有 Dart 3 代码。

#### `dart:core`

#### `dart:core` 库

- Removed the deprecated `List` constructor, as it wasn't null safe.
  Use list literals (e.g. `[]` for an empty list or `<int>[]` for an empty
  typed list) or [`List.filled`][]. This only impacts non-null safe code,
  as null safe code already couldn't use this constructor.

  移除了已弃用的 `List` 构造函数，因为它不是空安全的。
  请使用列表字面量（例如空列表用 `[]`，空的带类型列表用 `<int>[]`）
  或 [`List.filled`][]。这只影响非空安全代码，
  因为空安全代码本来就不能使用这个构造函数。

- Removed the deprecated `onError` argument on [`int.parse`][], [`double.parse`][],
  and [`num.parse`][]. Use the [`tryParse`][] method instead.

  移除了 [`int.parse`][]、[`double.parse`][] 和 [`num.parse`][]
  上已弃用的 `onError` 参数。请改用 [`tryParse`][] 方法。

- Removed the deprecated [`proxy`][] and [`Provisional`][] annotations.
  The original `proxy` annotation has no effect in Dart 2,
  and the `Provisional` type and [`provisional`][] constant
  were only used internally during the Dart 2.0 development process.

  移除了已弃用的 [`proxy`][] 和 [`Provisional`][] 注解。
  原来的 `proxy` 注解在 Dart 2 中没有效果，
  `Provisional` 类型和 [`provisional`][] 常量
  只在 Dart 2.0 开发过程中内部使用。

- Removed the deprecated [`Deprecated.expires`][] getter.
  Use [`Deprecated.message`][] instead.

  移除了已弃用的 [`Deprecated.expires`][] getter。
  请改用 [`Deprecated.message`][]。

- Removed the deprecated [`CastError`][] error.
  Use [`TypeError`][] instead.

  移除了已弃用的 [`CastError`][] 错误。
  请改用 [`TypeError`][]。

- Removed the deprecated [`FallThroughError`][] error. The kind of
  fall-through previously throwing this error was made a compile-time
  error in Dart 2.0.

  移除了已弃用的 [`FallThroughError`][] 错误。
  以前会抛出这个错误的那种贯穿，
  在 Dart 2.0 中已经变成编译时错误。

- Removed the deprecated [`NullThrownError`][] error. This error is never
  thrown from null safe code.

  移除了已弃用的 [`NullThrownError`][] 错误。
  空安全代码永远不会抛出这个错误。

- Removed the deprecated [`AbstractClassInstantiationError`][] error. It was made
  a compile-time error to call the constructor of an abstract class in Dart 2.0.

  移除了已弃用的 [`AbstractClassInstantiationError`][] 错误。
  在 Dart 2.0 中，调用抽象类的构造函数已经变成编译时错误。

- Removed the deprecated [`CyclicInitializationError`]. Cyclic dependencies are
  no longer detected at runtime in null safe code. Such code will fail in other
  ways instead, possibly with a StackOverflowError.

  移除了已弃用的 [`CyclicInitializationError`]。
  空安全代码不再在运行时检测循环依赖。
  这类代码会以其他方式失败，可能是 StackOverflowError。

- Removed the deprecated [`NoSuchMethodError`][] default constructor.
  Use the [`NoSuchMethodError.withInvocation`][] named constructor instead.

  移除了已弃用的 [`NoSuchMethodError`][] 默认构造函数。
  请改用命名构造函数 [`NoSuchMethodError.withInvocation`][]。

- Removed the deprecated [`BidirectionalIterator`][] class.
  Existing bidirectional iterators can still work, they just don't have
  a shared supertype locking them to a specific name for moving backwards.

  移除了已弃用的 [`BidirectionalIterator`][] 类。
  现有的双向迭代器仍然可以工作，只是不再有一个共同的超类型，
  把向后移动锁定到某个特定名称上。

[`List.filled`]: {{site.dart-api}}/dart-core/List/List.filled.html
[`int.parse`]: {{site.dart-api}}/dart-core/int/parse.html
[`double.parse`]: {{site.dart-api}}/dart-core/double/parse.html
[`num.parse`]: {{site.dart-api}}/dart-core/num/parse.html
[`tryParse`]: {{site.dart-api}}/dart-core/num/tryParse.html
[`Deprecated.expires`]: {{site.dart-api}}/stable/2.19.6/dart-core/Deprecated/expires.html
[`Deprecated.message`]: {{site.dart-api}}/dart-core/Deprecated/message.html
[`AbstractClassInstantiationError`]: {{site.dart-api}}/stable/2.19.6/dart-core/AbstractClassInstantiationError-class.html
[`CastError`]: {{site.dart-api}}/stable/2.19.6/dart-core/CastError-class.html
[`FallThroughError`]: {{site.dart-api}}/stable/2.19.6/dart-core/FallThroughError-class.html
[`NoSuchMethodError`]: {{site.dart-api}}/stable/2.19.6/dart-core/NoSuchMethodError/NoSuchMethodError.html
[`NoSuchMethodError.withInvocation`]: {{site.dart-api}}/dart-core/NoSuchMethodError/NoSuchMethodError.withInvocation.html
[`CyclicInitializationError`]: {{site.dart-api}}/stable/2.19.6/dart-core/CyclicInitializationError-class.html
[`Provisional`]: {{site.dart-api}}/stable/2.19.6/dart-core/Provisional-class.html
[`provisional`]: {{site.dart-api}}/stable/2.19.6/dart-core/provisional-constant.html
[`proxy`]: {{site.dart-api}}/stable/2.19.6/dart-core/proxy-constant.html
[`CastError`]: {{site.dart-api}}/stable/2.19.6/dart-core/CastError-class.html
[`TypeError`]: {{site.dart-api}}/dart-core/TypeError-class.html
[`FallThroughError`]: {{site.dart-api}}/stable/2.19.6/dart-core/FallThroughError-class.html
[`NullThrownError`]: {{site.dart-api}}/stable/2.19.6/dart-core/NullThrownError-class.html
[`AbstractClassInstantiationError`]: {{site.dart-api}}/stable/2.19.6/dart-core/AbstractClassInstantiationError-class.html
[`CyclicInitializationError`]: {{site.dart-api}}/stable/2.19.6/dart-core/CyclicInitializationError-class.html
[`BidirectionalIterator`]: {{site.dart-api}}/stable/2.19.6/dart-core/BidirectionalIterator-class.html

#### `dart:async`

#### `dart:async` 库

- Removed the deprecated [`DeferredLibrary`][] class.
  Use the [`deferred as`][] import syntax instead.

  移除了已弃用的 [`DeferredLibrary`][] 类。
  请改用 [`deferred as`][] 导入语法。

[`DeferredLibrary`]: {{site.dart-api}}/stable/2.19.6/dart-async/DeferredLibrary-class.html
[`deferred as`]: /language/libraries#lazily-loading-a-library

#### `dart:developer`

#### `dart:developer` 库

- Removed the deprecated [`MAX_USER_TAGS`][] constant.
  Use [`maxUserTags`][] instead.

  移除了已弃用的 [`MAX_USER_TAGS`][] 常量。
  请改用 [`maxUserTags`][]。

- Removed the deprecated [`Metrics`][], [`Metric`][], [`Counter`][],
  and [`Gauge`][] classes as they have been broken since Dart 2.0.

  移除了已弃用的 [`Metrics`][]、[`Metric`][]、[`Counter`][]
  和 [`Gauge`][] 类，因为它们从 Dart 2.0 起就已经失效。

[`MAX_USER_TAGS`]: {{site.dart-api}}/stable/2.19.6/dart-developer/UserTag/MAX_USER_TAGS-constant.html
[`maxUserTags`]: {{site.dart-api}}/dart-developer/UserTag/maxUserTags-constant.html
[`Metrics`]: {{site.dart-api}}/stable/2.19.6/dart-developer/Metrics-class.html
[`Metric`]: {{site.dart-api}}/stable/2.19.6/dart-developer/Metric-class.html
[`Counter`]: {{site.dart-api}}/stable/2.19.6/dart-developer/Counter-class.html
[`Gauge`]: {{site.dart-api}}/stable/2.19.6/dart-developer/Gauge-class.html

#### `dart:html`

#### `dart:html` 库

- As previously announced, the deprecated `registerElement`
  and `registerElement2` methods in `Document` and `HtmlDocument` have been
  removed.  See [#49536]({{site.repo.dart.sdk}}/issues/49536) for
  details.

  如前所述，`Document` 和 `HtmlDocument` 中已弃用的
  `registerElement` 和 `registerElement2` 方法已被移除。
  详情见 [#49536]({{site.repo.dart.sdk}}/issues/49536)。

#### `dart:math`

#### `dart:math` 库

- The `Random` interface can only be implemented, not extended.

  `Random` 接口只能被实现，不能被扩展。

#### `dart:io`

#### `dart:io` 库

- Update `NetworkProfiling` to accommodate new `String` ids
  that are introduced in vm_service:11.0.0

  更新了 `NetworkProfiling`，以适配
  vm_service:11.0.0 中引入的新 `String` id。

#### Symptom

#### 症状

Dart analysis (e.g. in your IDE, or in `dart analyze`/`flutter analyze`)
will fail with errors like:

Dart 分析（例如在 IDE 中，或在 `dart analyze` / `flutter analyze` 中）
会因类似这样的错误而失败：

```plaintext
error line 2 • Undefined class 'CyclicInitializationError'.
```

#### Migration

#### 迁移

Manually migrate away from using these APIs.

请手动迁移，不再使用这些 API。

### Extends & implements

### 扩展与实现

Dart 3 supports new [class modifiers][] that
can restrict the capabilities of a class.
They have been applied to a number of classes in the core libraries.

Dart 3 支持新的 [类修饰符][class modifiers]，
可以限制类的能力。
它们已经被用在核心库的许多类上。

#### Scope

#### 范围

This is a [*versioned* change](#unversioned-vs-versioned-changes), 
that only applies to language version 3.0 or later.

这是一项 [**有版本** 变更](#unversioned-vs-versioned-changes)，
只适用于语言版本 3.0 或更高。

#### `dart:async`

#### `dart:async` 库

* The following declarations can only be implemented, not extended:

  下面这些声明只能被实现，不能被扩展：

  - `StreamConsumer`
  - `StreamIterator`
  - `StreamTransformer`
  - `MultiStreamController`

  None of these declarations contained any implementation to inherit.
  They are marked as `interface` to signify that
  they are only intended as interfaces.

  这些声明都不包含可供继承的实现。
  它们被标为 `interface`，表示只打算作为接口。

#### `dart:core`

#### `dart:core` 库

* The `Function` type can no longer be implemented, extended or mixed in.
  Since Dart 2.0, writing `implements Function` has been allowed
  for backwards compatibility, but it has not had any effect.
  In Dart 3.0, the `Function` type is final and cannot be subtyped,
  preventing code from mistakenly assuming it works.

  `Function` 类型不能再被实现、扩展或混入。
  从 Dart 2.0 起，为了向后兼容，允许写 `implements Function`，
  但它没有任何效果。
  在 Dart 3.0 中，`Function` 类型是 final 的，不能被子类型化，
  以免代码误以为这样做有效。

* The following declarations can only be implemented, not extended:

  下面这些声明只能被实现，不能被扩展：

  - `Comparable`
  - `Exception`
  - `Iterator`
  - `Pattern`
  - `Match`
  - `RegExp`
  - `RegExpMatch`
  - `StackTrace`
  - `StringSink`

  None of these declarations contained any implementation to inherit.
  They are marked as `interface` to signify that
  they are only intended as interfaces.

  这些声明都不包含可供继承的实现。
  它们被标为 `interface`，表示只打算作为接口。

* The following declarations can no longer be implemented or extended:

  下面这些声明不能再被实现或扩展：

  - `MapEntry`
  - `OutOfMemoryError`
  - `StackOverflowError`
  - `Expando`
  - `WeakReference`
  - `Finalizer`

  The `MapEntry` value class is restricted to enable later optimizations.
  The remaining classes are tightly coupled to the platform and not
  intended to be subclassed or implemented.

  限制 `MapEntry` 这个值类，是为了以后能做优化。
  其余类与平台紧密耦合，
  本就不打算被子类化或实现。

#### `dart:collection`

#### `dart:collection` 库

* The following interface can no longer be extended, only implemented:

  下面这个接口不能再被扩展，只能被实现：

  - `Queue`

* The following implementation classes can no longer be implemented:

  下面这些实现类不能再被实现：

  - `LinkedList`
  - `LinkedListEntry`

* The following implementation classes can no longer be implemented
  or extended:

  下面这些实现类不能再被实现或扩展：

  - `HasNextIterator` (Also deprecated.)

    `HasNextIterator`（同时已弃用。）

  - `HashMap`
  - `LinkedHashMap`
  - `HashSet`
  - `LinkedHashSet`
  - `DoubleLinkedQueue`
  - `ListQueue`
  - `SplayTreeMap`
  - `SplayTreeSet`

## Dart 3 tools changes

## Dart 3 工具的变更

### Removed tools

### 移除的工具

Historically the Dart team has offered a number of smaller developer tools for
things like formatting code (`dartfmt`), analyzing code (`dartanalyzer`), etc.
In Dart 2.10 (October 2020) we introduced a new unified Dart developer tool, the
[`dart` tool](/tools/dart-tool).

过去，Dart 团队提供过许多较小的开发者工具，
例如格式化代码的 `dartfmt`、分析代码的 `dartanalyzer` 等。
在 Dart 2.10（2020 年 10 月），我们引入了新的统一 Dart 开发者工具，
即 [`dart` 工具](/tools/dart-tool)。

#### Scope

#### 范围

This is an [*unversioned* change](#unversioned-vs-versioned-changes), 
that applies to all Dart 3 code.

这是一项 [**无版本** 变更](#unversioned-vs-versioned-changes)，
适用于所有 Dart 3 代码。

#### Symptom

#### 症状

In Dart 3 these smaller tools do not exist, and
have been replaced by the new combined `dart` tool.

在 Dart 3 中，这些较小的工具已经不存在，
被新的统一 `dart` 工具取代。

#### Migration

#### 迁移

Use new sub-commands available in the `dart` tool:

请使用 `dart` 工具中的新子命令：

| <t>Historical tool</t><t>原来的工具</t> | <t>`dart` replacement</t><t>`dart` 替代命令</t> | <t>Deprecation</t><t>弃用</t> | <t>Discontinuation</t><t>停止提供</t> |
|-----------------|-----------------------------------------------|-------------|-----------------|
| `stagehand`     | [`dart create`](/tools/dart-create)           | [2.14]({{site.repo.dart.org}}/stagehand/issues/671)        | 2.14*  |
| `dartfmt`       | [`dart format`](/tools/dart-format)           | [2.14]({{site.repo.dart.org}}/dart_style/issues/986)        | [2.15]({{site.repo.dart.org}}/dart_style/issues/986)            |
| `dart2native`   | [`dart compile exe`](/tools/dart-compile#exe) | [2.14]({{site.repo.dart.sdk}}/commit/cac00e9d956a6f7ef28628989912d971f6b908d4)        | [2.15]({{site.repo.dart.sdk}}/commit/6c5fb84716b1f257b170351efe8096fe2af2809b)            |
| `dart2js`       | [`dart compile js`](/tools/dart-compile)      | [2.17]({{site.repo.dart.sdk}}/commit/8415b70e75b1d5bbe8251fa6a9eab2d970cf9eec)         | [2.18]({{site.repo.dart.sdk}}/commit/69249df50bcc7a0489176efd3fd79fff018f1b91)             |
| `dartdevc`      | [`webdev`](/tools/webdev)                     | [2.17]({{site.repo.dart.sdk}}/commit/5173fd2d224f669fd8d0a1d21adbfd6187d10f53)         | [2.18]({{site.repo.dart.sdk}}/commit/69249df50bcc7a0489176efd3fd79fff018f1b91)             |
| `dartanalyzer`  | [`dart analyze`](/tools/dart-analyze)         | [2.16]({{site.repo.dart.sdk}}/commit/f7af5c5256ee6f3a167f380722b96e8af4360b46)         | [2.18]({{site.repo.dart.sdk}}/issues/48457)             |
| `dartdoc`       | [`dart doc`](/tools/dart-doc)                 | [2.16]({{site.repo.dart.sdk}}/issues/44610)         | [2.17](https://dart-review.googlesource.com/c/sdk/+/228647)             |
| `pub`           | [`dart pub`](/tools/dart-pub)                 | [2.15]({{site.repo.dart.org}}/pub/issues/2736)         | [2.17](https://dart-review.googlesource.com/c/sdk/+/234283)             |

{:.table .table-striped .nowrap}

### Null safety migration tools

### 空安全迁移工具

The following null safety migration commands have been removed,
as Dart 3 [doesn't support code without null safety](#100-sound-null-safety):

下面这些空安全迁移命令已被移除，
因为 Dart 3 [不支持没有空安全的代码](#100-sound-null-safety)：

- `dart migrate`
- `dart pub upgrade --null-safety`
- `dart pub outdated --mode=null-safety`

#### Scope

#### 范围

This is an [*unversioned* change](#unversioned-vs-versioned-changes), 
that applies to all Dart 3 code.

这是一项 [**无版本** 变更](#unversioned-vs-versioned-changes)，
适用于所有 Dart 3 代码。

#### Symptom

#### 症状

These commands will fail.

这些命令会失败。

#### Migration

#### 迁移

Use Dart 2.19 to [migrate to null safety][].

请使用 Dart 2.19 [迁移到空安全][migrate to null safety]。

[migrate to null safety]: https://github.com/dart-community/migrate-to-null-safety/blob/main/docs/migrate.md#migrate-to-null-safety

### Analyzer config

### 分析器配置

The [analyzer configuration options][] for
enabling stricter checking have changed.

用于启用更严格检查的 [分析器配置选项][analyzer configuration options]
已经改变。

[analyzer configuration options]: /tools/analysis#enabling-additional-type-checks

#### Scope

#### 范围

This is an [*unversioned* change](#unversioned-vs-versioned-changes), 
that applies to all Dart 3 code.

这是一项 [**无版本** 变更](#unversioned-vs-versioned-changes)，
适用于所有 Dart 3 代码。

#### Symptom

#### 症状

The former configuration options will fail with a warning like:

以前的配置选项会因类似这样的警告而失败：

```plaintext
The option 'implicit-casts' is no longer supported.
Try using the new 'strict-casts' option.
```

#### Migration

#### 迁移

Replace this part of the analyzer config:

把分析器配置中的这一部分：

```yaml
analyzer:
  strong-mode:
    implicit-casts: false
    implicit-dynamic: false
```

with:

替换为：

```yaml
analyzer:
  language:
    strict-casts: true
    strict-raw-types: true
```

### Other tools changes

### 其他工具变更

* The deprecated Observatory has been hidden by default. 
  We recommend using [DevTools](/tools/dart-devtools).

  已弃用的 Observatory 默认被隐藏。
  我们建议使用 [DevTools](/tools/dart-devtools)。

* The command `dart format fix` has been replaced by `dart fix`
  [#1153]({{site.repo.dart.org}}/dart_style/issues/1153).

  命令 `dart format fix` 已被 `dart fix` 取代，
  见 [#1153]({{site.repo.dart.org}}/dart_style/issues/1153)。

* The snapshot files bundled in the SDK for the Dart web compiler
  have been cleaned up [#50700]({{site.repo.dart.sdk}}/issues/50700).

  SDK 中为 Dart Web 编译器捆绑的快照文件
  已清理，见 [#50700]({{site.repo.dart.sdk}}/issues/50700)。

* The output of `dart format` changed a bit for
  [some code]({{site.repo.dart.sdk}}/blob/main/CHANGELOG.md#formatter).

  `dart format` 对
  [某些代码]({{site.repo.dart.sdk}}/blob/main/CHANGELOG.md#formatter) 的输出有一点变化。

* Ending backwards compatibility for the old location of pub-cache on Windows.
  Prior to Dart 3 `%APPDATA%\Pub\Cache` was a fallback location for pub-cache.
  Starting with Dart 3, the default pub-cache is located at
  `%LOCALAPPDATA%\Pub\Cache`.
  If you have added globally activated packages to your `PATH`, consider
  updating `PATH` to contain `%LOCALAPPDATA%\Pub\Cache\bin`.

  结束了 Windows 上 pub-cache 旧位置的向后兼容。
  在 Dart 3 之前，`%APPDATA%\Pub\Cache` 是 pub-cache 的后备位置。
  从 Dart 3 开始，默认的 pub-cache 位于
  `%LOCALAPPDATA%\Pub\Cache`。
  如果你把全局激活的 package 加进了 `PATH`，
  请考虑把 `PATH` 更新为包含 `%LOCALAPPDATA%\Pub\Cache\bin`。

#### Scope

#### 范围

This is an [*unversioned* change](#unversioned-vs-versioned-changes), 
that applies to all Dart 3 code.

这是一项 [**无版本** 变更](#unversioned-vs-versioned-changes)，
适用于所有 Dart 3 代码。

[records]: /language/records
[patterns]: /language/patterns
[class modifiers]: /language/class-modifiers
