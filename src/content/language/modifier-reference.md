---
# title: Class modifiers reference
title: 类修饰符参考
# description: >-
#   The allowed and disallowed combinations of class modifiers.
description: >-
  类修饰符的允许和禁止组合。
prevpage:
  url: /language/class-modifiers
  # title: Class modifiers
  title: 类修饰符
nextpage:
  url: /language/concurrency
  # title: Concurrency in Dart
  title: Dart 中的并发
---

This page contains reference information for
[class modifiers](/language/class-modifiers).

本页面包含[类修饰符](/language/class-modifiers)的参考信息。

## Valid combinations

## 有效组合

The valid combinations of class modifiers and their resulting capabilities are:

类修饰符的有效组合及其产生的功能如下：

| Declaration                 | [Construct][]? | [Extend][]? | [Implement][]? | [Mix in][]? | [Exhaustive][]? |
|-----------------------------|----------------|-------------|----------------|-------------|-----------------|
| `class`                     | **Yes**        | **Yes**     | **Yes**        | No          | No              |
| `base class`                | **Yes**        | **Yes**     | No             | No          | No              |
| `interface class`           | **Yes**        | No          | **Yes**        | No          | No              |
| `final class`               | **Yes**        | No          | No             | No          | No              |
| `sealed class`              | No             | No          | No             | No          | **Yes**         |
| `abstract class`            | No             | **Yes**     | **Yes**        | No          | No              |
| `abstract base class`       | No             | **Yes**     | No             | No          | No              |
| `abstract interface class`  | No             | No          | **Yes**        | No          | No              |
| `abstract final class`      | No             | No          | No             | No          | No              |
| `mixin class`               | **Yes**        | **Yes**     | **Yes**        | **Yes**     | No              |
| `base mixin class`          | **Yes**        | **Yes**     | No             | **Yes**     | No              |
| `abstract mixin class`      | No             | **Yes**     | **Yes**        | **Yes**     | No              |
| `abstract base mixin class` | No             | **Yes**     | No             | **Yes**     | No              |
| `mixin`                     | No             | No          | **Yes**        | **Yes**     | No              |
| `base mixin`                | No             | No          | No             | **Yes**     | No              |

{: .table .table-striped .nowrap}

[Construct]: /language/classes#using-constructors
[Extend]: /language/extend
[Implement]: /language/classes#implicit-interfaces
[Mix in]: /language/mixins
[Exhaustive]: /language/branches#exhaustiveness-checking

## Invalid combinations

## 无效组合

Certain [combinations][] of modifiers aren't allowed:

某些修饰符[组合][combinations]是不允许的：

| Combination                                   | Reasoning                                                                                                                                       |
|-----------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------|
| `base`, `interface`, and `final`              | All control the same two capabilities (`extend` and `implement`), so are mutually exclusive.                                                    |
| `sealed` and `abstract`                       | Neither can be constructed, so are redundant together.                                                                                          |
| `sealed` with `base`, `interface`, or `final` | `sealed` types already cannot be mixed in, extended or implemented from another library, so are redundant to combine with the listed modifiers. |
| `mixin` and `abstract`                        | Neither can be constructed, so are redundant together.                                                                                          |
| `mixin` and `interface`, `final`, or `sealed` | A `mixin` or `mixin class` declaration is intended to be mixed in, which the listed modifiers prevent.                                          |
| `enum` and any modifiers                      | `enum` declarations can't be extended, implemented, mixed in, and can always be instantiated, so no modifiers apply to `enum` declarations.     |
| `extension type` and any modifiers            | `extension type` declarations can't be extended or mixed in, and can only be implemented by other `extension type` declarations.                |

| 组合                                           | 原因                                                                                                                                       |
|-----------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------|
| `base`、`interface` 和 `final`                 | 都控制相同的两种功能（`extend` 和 `implement`），因此是互斥的。                                                    |
| `sealed` 和 `abstract`                         | 两者都不能被构造，因此放在一起是多余的。                                                                                          |
| `sealed` 与 `base`、`interface` 或 `final`     | `sealed` 类型已经不能从另一个库中被混入、扩展或实现，因此与列出的修饰符组合是多余的。 |
| `mixin` 和 `abstract`                          | 两者都不能被构造，因此放在一起是多余的。                                                                                          |
| `mixin` 与 `interface`、`final` 或 `sealed`    | `mixin` 或 `mixin class` 声明旨在被混入，而列出的修饰符会阻止这一点。                                          |
| `enum` 和任何修饰符                             | `enum` 声明不能被扩展、实现或混入，且总是可以被实例化，因此没有修饰符适用于 `enum` 声明。     |
| `extension type` 和任何修饰符                   | `extension type` 声明不能被扩展或混入，且只能被其他 `extension type` 声明实现。                |

{: .table .table-striped .nowrap}

[combinations]: /language/class-modifiers#combining-modifiers
