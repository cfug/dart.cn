---
title: Effective Dart
title: 高效 Dart 语言指南
description: Best practices for building consistent, maintainable, efficient Dart libraries.
description: 编写具有高效、一致性、可维护的 Dart 代码。
declaration: 
permalink: /guides/language/effective-dart
nextpage:
  url: /guides/language/effective-dart/style
  title: Style
  title: 代码风格
---

Over the past several years, we've written a ton of Dart code and learned a lot
about what works well and what doesn't. We're sharing this with you so you can
write consistent, robust, fast code too. There are two overarching themes:

在过去的几年里，我们编写了大量的 Dart 代码，
也从中收获了很多经验和教训，
我们将与你分享这些经验，这些经验将有助于你编写出一致、健壮、高效的代码。
这里包含两主题：

 1. **Be consistent.** When it comes to things like formatting, and casing,
    arguments about which is better are subjective and impossible to resolve.
    What we do know is that being *consistent* is objectively helpful.

    **保持一致** 当谈论到格式、命名、参数相关规则时，其中那种规则更好，
    得出的结论通常是主观的，而且无法达成一致。
    但是我们知道，客观上保持*一致*是非常有益的。

    If two pieces of code look different it should be because they *are*
    different in some meaningful way. When a bit of code stands out and catches
    your eye, it should do so for a useful reason.

    如果两段代码看起来不同，那他们就应该有不同的含义。
    当一段突出的代码吸引到你的注意时，那他就应该有吸引你的理由。

 2. **Be brief.** Dart was designed to be familiar, so it inherits many of the
    same statements and expressions as C, Java, JavaScript and other languages.
    But we created Dart because there is a lot of room to improve on what those
    languages offer. We added a bunch of features, from string interpolation to
    initializing formals, to help you express your intent more simply and
    easily.

    **保持精简** 
    Dart 会让开发者感到很亲切，
    因此它继承了许多与 C，Java，JavaScript 及其他语言相同的语句和表达式。
    我们之所以开发 Dart 语言，是因为这些语言提供了很多改进的空间。
    我们提供了很多新的特性，
    比如字符串插值、初始化范式等，
    以帮助你更简单，更轻松地表达意图。

    If there are multiple ways to say something, you should generally pick the
    most concise one. This is not to say you should [code golf][] yourself into
    cramming a whole program into a single line. The goal is code that is
    *economical*, not *dense*.

    如果有多种方式来描述一件事情，
    那么你通常应该选择其中最简洁的方式。
    这并不意味着你要像 [code golf][] （代码高尔夫挑战赛）一样，将所有代码塞到一行中。
    目标是让代码*简约*，而不是*密集*。

[code golf]: https://en.wikipedia.org/wiki/Code_golf

The Dart analyzer has a linter to help you write good, consistent code.
If a linter rule exists that can help you follow a guideline,
then the guideline links to that rule. Here's an example:

Dart analyzer 包括一个 linter 可以帮助你编写一致性的，优秀的代码。
如果 linter 包含规则，那么它将会帮助你遵守这些准则，准则包含规则的链接。比如下面的示例：

{% include linter-rule.html rule="prefer_collection_literals" %}

For help on
[enabling linter rules](/guides/language/analysis-options#enabling-linter-rules),
see the documentation for
[customizing static analysis](/guides/language/analysis-options).

获取帮助 [开启 linter 规则](/guides/language/analysis-options#enabling-linter-rules)，
查看文档 [自定义静态分析](/guides/language/analysis-options)。


## The guides

## 指南

We split the guidelines into a few separate pages for easy digestion:

我们将指南分成几个单独的页面以便于消化：

  * **[Style Guide][]** &ndash; This defines the rules for laying out and
    organizing code, or at least the parts that [dartfmt] doesn't handle for
    you. The style guide also specifies how identifiers are formatted:
    `camelCase`, `using_underscores`, etc.

    **[风格指南][]** &ndash; 这定义了布局和组织代码的规则，
    [dartfmt] 的实现使用同样的规则。指南中还指定了标识符的格式：
    `camelCase`，`using_underscores` 等。

  * **[Documentation Guide][]** &ndash; This tells you everything you need to
    know about what goes inside comments. Both doc comments and regular,
    run-of-the-mill code comments.

    **[注释指南][]** &ndash; 这会告诉你关于如何编写注释文档的一切内容。
    包括文档注释，常规的普通代码注释。


  * **[Usage Guide][]** &ndash; This teaches you how to make the best use of
    language features to implement behavior. If it's in a statement or
    expression, it's covered here.

    **[使用指南][]** &ndash; 这将教你如何充分利用语言功能来实现功能。
    例如语句和表达式相关的内容，则会在这里介绍。

  * **[Design Guide][]** &ndash; This is the softest guide, but the one
    with the widest scope. It covers what we've learned about designing
    consistent, usable APIs for libraries. If it's in a type signature or
    declaration, this goes over it.

    **[设计指南][]** &ndash; 这是一份宽松的指南，但是覆盖范围最广。
    这里涵盖了如何为库设计一致的、可用的 API。例如类型签名或声明相关内容，
    则会在这里介绍。

For links to all the guidelines, see the
[summary](#summary-of-all-rules).

有关所有指南的链接，参考
[summary](#summary-of-all-rules)。

{% comment %}
<aside class="alert alert-info" markdown="1">
  **Have feedback on the guides?** <br>
  Please create a [new issue][] or comment on one of our [existing issues][].

  [new issue]: {{site.repo.this}}/issues/new
  [existing issues]: {{site.repo.this}}/issues?q=is%3Aopen+is%3Aissue+label%3AEffectiveDart
</aside>
{% endcomment %}

[dartfmt]: https://github.com/dart-lang/dart_style#readme
[style guide]: /guides/language/effective-dart/style
[documentation guide]: /guides/language/effective-dart/documentation
[usage guide]: /guides/language/effective-dart/usage
[design guide]: /guides/language/effective-dart/design
[风格指南]: /guides/language/effective-dart/style
[注释指南]: /guides/language/effective-dart/documentation
[使用指南]: /guides/language/effective-dart/usage
[设计指南]: /guides/language/effective-dart/design

## How to read the guides

## 如何阅读本指南

Each guide is broken into a few sections. Sections contain a list of guidelines.
Each guideline starts with one of these words:

每个指南都分为了几个部分。每个部分包含一些详细的准则。
每条准则都以下面其中的一个词作为开头：

* **DO** guidelines describe practices that should always be followed. There
  will almost never be a valid reason to stray from them.

  **要**  准则所描述的内容应该始终被遵守。 
  不应该以任何的理由来偏离违背这些准则。

* **DON'T** guidelines are the converse: things that are almost never a good
  idea. Hopefully, we don't have as many of these as other languages do because
  we have less historical baggage.

  **不要**  准则所描述的内容是相反的：
  描述的几乎从来不是一个好注意。
  幸运的是，我们不会像其他语言有那么多这样的准则，因为我们没有太多的历史包袱。

* **PREFER** guidelines are practices that you *should* follow. However, there
  may be circumstances where it makes sense to do otherwise. Just make sure you
  understand the full implications of ignoring the guideline when you do.

  **推荐** 准则所描述的内容*应该*被遵守。 
  但是在有些情况下，可能有更好的或者更合理的做法。
  请确保在你完全理解准则的情况下，再忽视这些准则。

* **AVOID** guidelines are the dual to "prefer": stuff you shouldn't do but
  where there may be good reasons to on rare occasions.

  **避免** 准则与 "推荐" 准则相反：
  显然，这些事不应该做，但不排除在极少数场合下有充分的理由可以使用。

* **CONSIDER** guidelines are practices that you might or might not want to
  follow, depending on circumstances, precedents, and your own preference.

  **考虑**  准则所描述的内容可以遵守，也可以不遵守。
  取决于具体的情况、先前的做法以及自己的偏好。

This sounds like the police are going to beat down your door if you don't have
your laces tied correctly. Things aren't that bad. Most of the guidelines here
are common sense and we're all reasonable people. The goal, as always, is nice,
readable and maintainable code.

这听起来好像有点小题大做。其实并没有那么糟糕。大部分的准则都是常识，也符合我们的认知。
最终要达到的目标是写出优雅，可读，可维护的代码。

## Glossary

## 词汇表

To keep the guidelines brief, we use a few shorthand terms to refer to different
Dart constructs.

为了使指南保持简洁，
我们使用一些简写术语来指代不同的 Dart 结构。

* A **library member** is a top-level field, getter, setter, or function.
  Basically, anything at the top level that isn't a type.

  **库成员** 是一个顶级字段，getter 方法，setter 方法，或者函数，
  基本上，任何顶级的东西都不会是一种类型。

* A **class member** is a constructor, field, getter, setter, function, or
  operator declared inside a class. Class members can be instance or static,
  abstract or concrete.

  **类成员** 是一个类内部声明的构造函数，字段，getter 方法，setter 方法，函数，或者操作符。
  类成员可以是实例的或者静态的，抽象的或者具体的。

* A **member** is either a library member or a class member.

  **成员** 是一个库成员或者是类成员。

* A **variable**, when used generally, refers to top-level variables,
  parameters, and local variables. It doesn't include static or instance fields.

  **变量** 通常是指顶级变量，参数和局部变量。
  它不包括静态或实例的字段。

* A **type** is any named type declaration: a class, typedef, or enum.

  **类型** 是任意命名类型的声明：一个类、 typedef、或者 enum。

* A **property** is a top-level variable, getter (inside a class or at the top
  level, instance or static), setter (same), or field (instance or static).
  Roughly any "field-like" named construct.

  **属性** 是一个顶级变量，getter 方法（在一个类或者顶级实例或静态类中），
  setter（同getter），或者字段（示例或静态类）。
  大致上任何“字段式”命名构造。

## Summary of all rules

## 所有准则摘要

{% include_relative toc.md %}
