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

在过去的几年里，我们编写了大量的 Dart 代码，并从中收获了很多经验和教训。我们将与你分享这些经验，这些经验将有助于你编写出一致、健壮、高效的代码。这里包含两主题：

 1. **Be consistent.** When it comes to things like formatting, and casing,
    arguments about which is better are subjective and impossible to resolve.
    What we do know is that being *consistent* is objectively helpful.

    **保持一致** 当谈论到格式、命名以及参数的相关规则时，哪种规则更好，得出的结论通常是主观且无法达成一致的。但我们知道的是，客观上保持 **一致** 是非常有益的。

    If two pieces of code look different it should be because they *are*
    different in some meaningful way. When a bit of code stands out and catches
    your eye, it should do so for a useful reason.

    如果两段代码看起来不同，那它们就应该有不同的含义。当一段突出的代码吸引到你的注意时，那它就应该有吸引你的理由。

 2. **Be brief.** Dart was designed to be familiar, so it inherits many of the
    same statements and expressions as C, Java, JavaScript and other languages.
    But we created Dart because there is a lot of room to improve on what those
    languages offer. We added a bunch of features, from string interpolation to
    initializing formals, to help you express your intent more simply and
    easily.

    **保持简洁** Dart 会让开发者感到很亲切，因为它继承了许多与 C、Java、JavaScript 及其他语言相同的语句和表达式语法。我们之所以开发 Dart 语言，是因为这些语言依然有很大的改进的空间。我们提供了很多新的特性，比如字符串插值、初始化范式等，以帮助你更简单、更轻松地表达意图。

    If there are multiple ways to say something, you should generally pick the
    most concise one. This is not to say you should [code golf][] yourself into
    cramming a whole program into a single line. The goal is code that is
    *economical*, not *dense*.

    如果有多种方式来描述一件事情，那么你通常应该选择其中最简洁的方式。这并不意味着你要像 [Code Golf][code golf]（代码高尔夫挑战赛）一样将所有代码塞到一行中。而是应该让代码变得 **简约** 而非 **密集**。

[code golf]: https://en.wikipedia.org/wiki/Code_golf

The Dart analyzer has a linter to help you write good, consistent code.
If a linter rule exists that can help you follow a guideline,
then the guideline links to that rule. Here's an example:

Dart Analyzer 中有一个 Linter 工具，该工具可以帮助你编写优秀的、一致性的代码。如果存在一个 Linter 规则可以帮助你遵循某个指南准则，那么该指南准则将链接到该规则。比如下面的示例：

{% include linter-rule.html rule="prefer_collection_literals" %}

For help on
[enabling linter rules](/guides/language/analysis-options#enabling-linter-rules),
see the documentation for
[customizing static analysis](/guides/language/analysis-options).

更多关于 [开启 Linter 规则](/guides/language/analysis-options#enabling-linter-rules) 的帮助，请查阅 [自定义静态分析](/guides/language/analysis-options) 文档。

## The guides

## 指南

We split the guidelines into a few separate pages for easy digestion:

为了便于理解，这里我们将指南分成了几个部分：

  * **[Style Guide][]** &ndash; This defines the rules for laying out and
    organizing code, or at least the parts that [dart format] doesn't handle for
    you. The style guide also specifies how identifiers are formatted:
    `camelCase`, `using_underscores`, etc.

    **[风格指南][Style Guide]** &ndash; 该部分定义了布局和组织代码的规则，或者说是 [dartfmt] 不能为你格式化的那些代码的布局和组织规则。风格指南还为你指定了标识符的格式，比如：驼峰式大小写、下划线的使用等等。

  * **[Documentation Guide][]** &ndash; This tells you everything you need to
    know about what goes inside comments. Both doc comments and regular,
    run-of-the-mill code comments.

    **[注释指南][Documentation Guide]** &ndash; 该部分会告诉你注释中应该包含哪些内容。包括文档注释以及常规的普通代码注释。

  * **[Usage Guide][]** &ndash; This teaches you how to make the best use of
    language features to implement behavior. If it's in a statement or
    expression, it's covered here.

    **[使用指南][Usage Guide]** &ndash; 该部分将教你如何充分利用语言特性来实现相关功能。比如你可以在该部分找到如何利用语句或表达式来实现某个功能。

  * **[Design Guide][]** &ndash; This is the softest guide, but the one
    with the widest scope. It covers what we've learned about designing
    consistent, usable APIs for libraries. If it's in a type signature or
    declaration, this goes over it.

    **[设计指南][Design Guide]** &ndash; 该部分是最易理解但是覆盖范围最广的。其涵盖了我们所总结的为库设计一致、可用 API 的经验。比如这些 API 的类型签名或声明的说明则会在这里找到。

For links to all the guidelines, see the
[summary](#summary-of-all-rules).

有关所有指南的链接，请查阅 [概览](#summary-of-all-rules)。

{% comment %}
<aside class="alert alert-info" markdown="1">
  **Have feedback on the guides?** <br>
  Please create a [new issue][] or comment on one of our [existing issues][].

  [new issue]: {{site.repo.this}}/issues/new
  [existing issues]: {{site.repo.this}}/issues?q=is%3Aopen+is%3Aissue+label%3AEffectiveDart
</aside>
{% endcomment %}

[dart format]: /tools/dart-format
[style guide]: /guides/language/effective-dart/style
[documentation guide]: /guides/language/effective-dart/documentation
[usage guide]: /guides/language/effective-dart/usage
[design guide]: /guides/language/effective-dart/design

## How to read the guides

## 如何阅读这些指南

Each guide is broken into a few sections. Sections contain a list of guidelines.
Each guideline starts with one of these words:

每个指南都分为了几个部分。每个部分包含一些详细的准则。每条准则都以下面其中的一个词作为开头：

* **DO** guidelines describe practices that should always be followed. There
  will almost never be a valid reason to stray from them.

  **要**  准则所描述的内容应该始终被遵守。不应该以任何的理由来偏离违背这些准则。

* **DON'T** guidelines are the converse: things that are almost never a good
  idea. Hopefully, we don't have as many of these as other languages do because
  we have less historical baggage.

  **不要**  准则所描述的内容是相反的：描述的准则不是一个好注意。幸运的是，我们不会像其他语言有那么多这样的准则，因为我们没有太多的历史包袱。

* **PREFER** guidelines are practices that you *should* follow. However, there
  may be circumstances where it makes sense to do otherwise. Just make sure you
  understand the full implications of ignoring the guideline when you do.

  **推荐** 准则所描述的内容 **应该** 被遵守。但是在有些情况下，可能有更好的或者更合理的做法。请确保在你完全理解准则的情况下，再忽视这些准则。

* **AVOID** guidelines are the dual to "prefer": stuff you shouldn't do but
  where there may be good reasons to on rare occasions.

  **避免** 该单词描述的准则与 “推荐” 描述的准则相反：显然，这些事不应该做，但不排除在极少数场合下有充分的理由可以做。

* **CONSIDER** guidelines are practices that you might or might not want to
  follow, depending on circumstances, precedents, and your own preference.

  **考虑**  准则所描述的内容可以遵守也可以不遵守。取决于具体的情况、习惯做法以及自己的偏好。

Some guidelines describe an **exception** where the rule does *not* apply. When
listed, the exceptions may not be exhaustive&mdash;you might still need to use
your judgement on other cases.

某些准则描述了规则 **不** 适用的 **例外情况**。当这些例外列出时，也有可能不是详尽的&mdash;你可能还需要对其它的情况作出判断。

This sounds like the police are going to beat down your door if you don't have
your laces tied correctly. Things aren't that bad. Most of the guidelines here
are common sense and we're all reasonable people. The goal, as always, is nice,
readable and maintainable code.

这听起来好像有点小题大做。其实并没有那么糟糕。大部分的准则都是常识，也符合我们的认知。最终要达到的目标是写出优雅，可读，可维护的代码。

## Glossary

## 术语表

To keep the guidelines brief, we use a few shorthand terms to refer to different
Dart constructs.

为了使指南保持简洁，我们使用一些简写术语来指代不同的 Dart 结构。

* A **library member** is a top-level field, getter, setter, or function.
  Basically, anything at the top level that isn't a type.

  **库成员** 表示一个顶层字段、Getter 或 Setter 方法、或函数。基本而言，任何顶层的东西都不会是一种类型。

* A **class member** is a constructor, field, getter, setter, function, or
  operator declared inside a class. Class members can be instance or static,
  abstract or concrete.

  **类成员** 表示类内部声明的构造函数、字段、Getter 或 Setter 方法、函数或操作符。类成员可以是实例或静态的，也可以是抽象或具体的。

* A **member** is either a library member or a class member.

  **成员** 可以表示是一个库成员或者类成员。

* A **variable**, when used generally, refers to top-level variables,
  parameters, and local variables. It doesn't include static or instance fields.

  **变量** 通常指的是顶层变量、参数和局部变量。它不包括静态或实例字段。

* A **type** is any named type declaration: a class, typedef, or enum.

  **类型** 表示所有命名类型的声明：一个类、typedef 或枚举。

* A **property** is a top-level variable, getter (inside a class or at the top
  level, instance or static), setter (same), or field (instance or static).
  Roughly any "field-like" named construct.

  **属性** 表示顶层变量、Getter 和 Setter 方法（位于类中或顶层，可以是实例或静态的）或字段（实例或静态的）。基本上是任何类似字段的命名结构都可以称为属性。

## Summary of all rules

## 所有准则摘要

{% include_relative toc.md %}
