---
# title: Class modifiers reference
title: 类修饰符参考
# description: >-
#   The allowed and disallowed combinations of class modifiers.
description: 类修饰符的允许组合与不允许组合。
prevpage:
  url: /language/class-modifiers
  # title: Class modifiers
  title: 类修饰符
nextpage:
  url: /language/concurrency
  # title: Concurrency in Dart
  title: Dart 中的并发
ai-translated: true
---

This page contains reference information for
[class modifiers](/language/class-modifiers).

本页提供
[类修饰符](/language/class-modifiers) 的参考信息。

## Valid combinations

## 有效组合

The valid combinations of class modifiers and their resulting capabilities are:

类修饰符的有效组合，以及它们各自得到的能力如下：

| <t>Declaration</t><t>声明</t> | <t>[Construct][]?</t><t>[构造][Construct]？</t> | <t>[Extend][]?</t><t>[扩展][Extend]？</t> | <t>[Implement][]?</t><t>[实现][Implement]？</t> | <t>[Mix in][]?</t><t>[mixin][Mix in]？</t> | <t>[Exhaustive][]?</t><t>[穷尽][Exhaustive]？</t> |
|-----------------------------|----------------|-------------|----------------|-------------|-----------------|
| `class`                     | **Yes**        | **Yes**     | **Yes**        | No          | No              |
| `class`                     | **是**        | **是**     | **是**        | 否          | 否              |
| `base class`                | **Yes**        | **Yes**     | No             | No          | No              |
| `base class`                | **是**        | **是**     | 否             | 否          | 否              |
| `interface class`           | **Yes**        | No          | **Yes**        | No          | No              |
| `interface class`           | **是**        | 否          | **是**        | 否          | 否              |
| `final class`               | **Yes**        | No          | No             | No          | No              |
| `final class`               | **是**        | 否          | 否             | 否          | 否              |
| `sealed class`              | No             | No          | No             | No          | **Yes**         |
| `sealed class`              | 否             | 否          | 否             | 否          | **是**         |
| `abstract class`            | No             | **Yes**     | **Yes**        | No          | No              |
| `abstract class`            | 否             | **是**     | **是**        | 否          | 否              |
| `abstract base class`       | No             | **Yes**     | No             | No          | No              |
| `abstract base class`       | 否             | **是**     | 否             | 否          | 否              |
| `abstract interface class`  | No             | No          | **Yes**        | No          | No              |
| `abstract interface class`  | 否             | 否          | **是**        | 否          | 否              |
| `abstract final class`      | No             | No          | No             | No          | No              |
| `abstract final class`      | 否             | 否          | 否             | 否          | 否              |
| `mixin class`               | **Yes**        | **Yes**     | **Yes**        | **Yes**     | No              |
| `mixin class`               | **是**        | **是**     | **是**        | **是**     | 否              |
| `base mixin class`          | **Yes**        | **Yes**     | No             | **Yes**     | No              |
| `base mixin class`          | **是**        | **是**     | 否             | **是**     | 否              |
| `abstract mixin class`      | No             | **Yes**     | **Yes**        | **Yes**     | No              |
| `abstract mixin class`      | 否             | **是**     | **是**        | **是**     | 否              |
| `abstract base mixin class` | No             | **Yes**     | No             | **Yes**     | No              |
| `abstract base mixin class` | 否             | **是**     | 否             | **是**     | 否              |
| `mixin`                     | No             | No          | **Yes**        | **Yes**     | No              |
| `mixin`                     | 否             | 否          | **是**        | **是**     | 否              |
| `base mixin`                | No             | No          | No             | **Yes**     | No              |
| `base mixin`                | 否             | 否          | 否             | **是**     | 否              |

{: .table .table-striped .nowrap}

[Construct]: /language/classes#using-constructors
[Extend]: /language/extend
[Implement]: /language/classes#implicit-interfaces
[Mix in]: /language/mixins
[Exhaustive]: /language/branches#exhaustiveness-checking

## Invalid combinations

## 无效组合

Certain [combinations][] of modifiers aren't allowed:

某些修饰符 [组合][combinations] 是不允许的：

| <t>Combination</t><t>组合</t> | <t>Reasoning</t><t>原因</t> |
|-----------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------|
| `base`, `interface`, and `final`              | All control the same two capabilities (`extend` and `implement`), so are mutually exclusive.                                                    |
| `base`, `interface`, and `final` | 它们控制的是同一对能力（`extend` 和 `implement`），因此互相排斥。 |
| `sealed` and `abstract`                       | Neither can be constructed, so are redundant together.                                                                                          |
| `sealed` and `abstract` | 二者都不能被构造，放在一起是多余的。 |
| `sealed` with `base`, `interface`, or `final` | `sealed` types already cannot be mixed in, extended or implemented from another library, so are redundant to combine with the listed modifiers. |
| `sealed` with `base`, `interface`, or `final` | `sealed` 类型本来就不能从另一个库被 mixin、扩展或实现，因此再与列出的修饰符组合是多余的。 |
| `mixin` and `abstract`                        | Neither can be constructed, so are redundant together.                                                                                          |
| `mixin` and `abstract` | 二者都不能被构造，放在一起是多余的。 |
| `mixin` and `interface`, `final`, or `sealed` | A `mixin` or `mixin class` declaration is intended to be mixed in, which the listed modifiers prevent.                                          |
| `mixin` and `interface`, `final`, or `sealed` | `mixin` 或 `mixin class` 声明就是为了被 mixin 进去，而列出的修饰符会阻止这一点。 |
| `enum` and any modifiers                      | `enum` declarations can't be extended, implemented, mixed in, and can always be instantiated, so no modifiers apply to `enum` declarations.     |
| `enum` and any modifiers | `enum` 声明不能被扩展、实现或 mixin，并且始终可以实例化，因此任何修饰符都不适用于 `enum` 声明。 |
| `extension type` and any modifiers            | `extension type` declarations can't be extended or mixed in, and can only be implemented by other `extension type` declarations.                |
| `extension type` and any modifiers | `extension type` 声明不能被扩展或 mixin，并且只能由其他 `extension type` 声明来实现。 |

{: .table .table-striped .nowrap}

[combinations]: /language/class-modifiers#combining-modifiers
