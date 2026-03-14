---
# title: Sound null safety
title: 健全的空安全
# breadcrumb: Null safety
breadcrumb: 空安全
# description: An introduction to null safety in Dart.
description: Dart 空安全简介
---

The Dart language enforces sound null safety,
making it impossible to unintentionally access a member on a `null` value.

In Dart, types are non-nullable by default.
Variables of non-nullable types must be initialized
and can only be assigned non-null values.

The Dart analyzer and compilers catch unsafe usage
of potentially `null` values at edit time,
turning what would be **runtime errors** in other languages
into **analysis errors** you can fix before deploying.

<a id="creating-variables" aria-hidden="true"></a>
<a id="introduction-through-examples" aria-hidden="true"></a>

## Examples

None of the variables in the following code can be `null`:

```dart
// None of these can ever be null.
var i = 42; // Inferred to be an int.
String name = getFileName();
final b = Foo();
```

To indicate that a variable can have the value `null`,
add `?` to its type declaration:

<a id="creating-variables"></a>

```dart
int? aNullableInt = null;
```

- For interactive examples, try the [Dart cheatsheet][].
- To learn more about null safety, check out
  [Understanding null safety][].

[Dart cheatsheet]: /resources/dart-cheatsheet
[Understanding null safety]: /null-safety/understanding-null-safety

## Null safety principles

## 空安全原则

Null safety in Dart is built on two core design principles:

Dart 的空安全基于以下两条核心原则：

**Non-nullable by default**
<br> Unless you explicitly tell Dart that a variable can be null,
  it's considered non-nullable.
  This default was chosen after research found that
  non-null was by far the most common choice in APIs.

**默认不可空**
<br> 除非你将变量显式声明为可空，否则它一定是非空的类型。
  我们在研究后发现，非空是目前的 API 中最常见的选择，所以选择了非空作为默认值。

**Fully sound**
<br> If the type system determines that
  a variable or expression has a non-nullable type,
  it's guaranteed that it can never evaluate to `null` at runtime.

**完全可靠**
<br> 如果类型系统推断出某个变量或表达式具有不可空的类型，
  那么可以保证它在运行时永远不会为 `null`。

Together, these principles result in
fewer bugs, smaller binaries, and faster execution.

综合来看，这些原则带来了更少的错误、更精简的体积以及更快的运行速度。

<a id="dart-3-and-null-safety" aria-hidden="true"></a>
<a id="enable-null-safety" aria-hidden="true"></a>
<a id="where-to-learn-more" aria-hidden="true"></a>

## Historical migration resources {:#migrate}

## 以往的迁移资源

Dart has enforced sound null safety since Dart 3, released in May 2023.
If you still need to migrate your apps or packages to null safety,
check out the archived documentation in the
[`dart-community/migrate-to-null-safety`][] repository.

自 2023 年 5 月发布的 Dart 3 起，
Dart 已全面支持严格的空安全机制。
如果你仍然需要将你的应用或者 package 迁移至空安全，
请查阅 [`dart-community/migrate-to-null-safety`][] 仓库中的文档。

[`dart-community/migrate-to-null-safety`]: https://github.com/dart-community/migrate-to-null-safety#migrate-to-dart-null-safety
