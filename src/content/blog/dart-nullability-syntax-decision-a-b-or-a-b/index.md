---
# title: "Dart nullability syntax decision: a?[b] or a?.[b]"
title: "Dart 可空性语法决策：a?[b] 还是 a?.[b]"
# description: "Dart is in the process of redesigning its type system so that individual types will be either nullable (expressions of that type can have…"
description: "Dart 正在重新设计其类型系统，让各个类型要么可空（该类型的表达式可以取值 null），要么非空……"
ai-translated: true
publishDate: 2019-08-26
author: kwalrath
image: images/1se-VT1aPyHd3J2VYDzDW5g.webp
category: other
layout: blog
---

> Update (3/2021): Thanks to your feedback, the Dart team [decided to use the a?[b] syntax](https://github.com/dart-lang/language/issues/376#issuecomment-576924506).

> 更新（2021 年 3 月）：感谢你的反馈，Dart 团队
> [决定采用 a?[b] 语法](https://github.com/dart-lang/language/issues/376#issuecomment-576924506)。

Dart is [in the process](https://github.com/dart-lang/language/issues/110) of redesigning its type system so that individual types will be either *nullable* (expressions of that type can have the value null) or *non-nullable*. Later this year we’ll tell you more about the timeline and roll-out process, but eventually Dart code will be non-nullable by default (*NNBD*), and you’ll have to use special syntax to say that a type permits null values.

Dart 正在[重新设计](https://github.com/dart-lang/language/issues/110)其类型系统，
让每个类型要么*可空*（nullable，该类型的表达式可以取值 null），
要么*非空*（non-nullable）。今年晚些时候我们会介绍更多时间表
和推出流程，但最终 Dart 代码将默认非空（*NNBD*），
你必须使用特殊语法来声明某个类型允许 null 值。

For example, to declare that an integer can be null, you’ll need to add a `?` after the type:

例如，要声明一个整数可以为 null，你需要在类型后加一个 `?`：

```
int? someInt; // someInt can be null.
```


That question mark syntax might be familiar if you’ve seen Kotlin, Swift, or C# code. But some things are different — notably the subscript (`[]`) operator, which you most often see used for list or array access. C# and Swift use `?[]`. The current plan for Dart (and, by the way, for [ECMAScript](https://github.com/tc39/proposal-optional-chaining#syntax)) is to use `?.[]` instead:

如果你见过 Kotlin、Swift 或 C# 代码，可能对这种问号语法很熟悉。
但有些地方不一样——尤其是下标（`[]`）运算符，
你最常见到它用于列表或数组访问。C# 和 Swift 使用 `?[]`。
Dart 目前的计划（顺便说一句，
[ECMAScript](https://github.com/tc39/proposal-optional-chaining#syntax) 也是）
是改用 `?.[]`：

```
e1?.[e2] // null if e1 is null; otherwise it’s e1[e2]
```


This article takes you behind the scenes to explain the reasoning behind this decision, and to encourage you to weigh in with your thoughts and suggestions. Most of this content is based on a [comment by Bob Nystrom](https://github.com/dart-lang/language/issues/376#issuecomment-497121257) ([munificent](https://github.com/munificent)) on language issue [#376](https://github.com/dart-lang/language/issues/376), which summarizes a discussion between Bob and the owner of the NNBD specification, Leaf Petersen ([leafpetersen](https://github.com/leafpetersen)).

本文带你走进幕后，解释这一决策背后的考量，
也欢迎你发表自己的想法和建议。本文大部分内容基于
Bob Nystrom（[munificent](https://github.com/munificent)）
在语言 issue [#376](https://github.com/dart-lang/language/issues/376) 中的
[一条评论](https://github.com/dart-lang/language/issues/376#issuecomment-497121257)，
该评论总结了他与 NNBD 规范负责人 Leaf Petersen
（[leafpetersen](https://github.com/leafpetersen)）之间的讨论。

## **Why use a dot?**

## **为什么要用点号？**

Both options for `[]` have advantages.

`[]` 的两种方案各有优点。

`e1?[e2]`:

`e1?[e2]`：

* Follows C# and Swift

  与 C# 和 Swift 一致

* Is concise

  简洁

* Is similar to the syntax for the `!` operator (which you’ll be able to add after an expression to say that its value isn’t null, even though it has a nullable type): `e1![e2]`

  与 `!` 运算符的语法相似（你可以把它加在表达式后面，
  表示尽管该表达式的类型可空，但其值不为 null）：`e1![e2]`

`e1?.[e2]`:

`e1?.[e2]`：

* Is similar to cascade syntax:
`e1..[e2] // cascade syntax
e1?..[e2] // null-aware cascade syntax`

  与级联（cascade）语法相似：
  `e1..[e2]`（级联语法）、`e1?..[e2]`（null 感知级联语法）

* Is similar to other null-aware method syntax: `e1?.e2()`

  与其他 null 感知（null-aware）方法语法相似：`e1?.e2()`

* Extends naturally to other operators

  能自然扩展到其他运算符

* Avoids the ambiguity in the following code: `{ e1 ? [e2] : e3 }`

  避免了下面这段代码的歧义：`{ e1 ? [e2] : e3 }`

We spent a while trying to come up with ways to avoid the ambiguity of `?[`. The problem is that you can’t tell whether code like `{ e1 ? [e2] : e3 }` is a [set literal](https://dart.dev/guides/language/language-tour#sets) containing the result of a conditional expression, or a [map literal](https://dart.dev/guides/language/language-tour#maps) containing the result of a null-aware subscript.

我们花了不少时间试图找到避免 `?[` 歧义的办法。
问题在于，你无法分辨 `{ e1 ? [e2] : e3 }` 这样的代码
到底是包含条件表达式结果的
[set 字面量](https://dart.dev/guides/language/language-tour#sets)，
还是包含 null 感知下标结果的
[map 字面量](https://dart.dev/guides/language/language-tour#maps)。

If we add parentheses to make that code unambiguous, we could either choose to add them around the entire expression — `{ (e1 ? [e2] : e3) }` — making it unambiguously a set literal. Or we could add them around the first part — `{ (e1 ? [e2]) : e3 }` — making it unambiguously a map literal. But in the absence of parentheses, the parser doesn’t know what to do.

如果加括号来消除这段代码的歧义，
我们既可以选择把整个表达式括起来——`{ (e1 ? [e2] : e3) }`——
让它明确是 set 字面量；也可以只把第一部分括起来——
`{ (e1 ? [e2]) : e3 }`——让它明确是 map 字面量。
但在没有括号的情况下，解析器无所适从。

There are various solutions to this ambiguity, but none of them seem very satisfying. One approach is to rely on whitespace to distinguish between the options. In this approach, you always treat `e1 ? [e2]` as the start of a conditional expression, because there is a space between the `?` and the `[`. And you always treat `e1?[e2]` as a null-aware subscript because there’s no space between those two tokens. But relying on whitespace can really harm the user experience.

这种歧义有多种解决方案，但没有一种令人十分满意。
一种思路是依靠空白字符来区分两种情况：
始终把 `e1 ? [e2]` 视为条件表达式的开头，
因为 `?` 和 `[` 之间有空格；
始终把 `e1?[e2]` 视为 null 感知下标，
因为这两个记号之间没有空格。
但依赖空白字符会严重损害用户体验。

In theory, relying on whitespace isn’t a problem in formatted code. But many users write unformatted Dart code as an input to the formatter. And that input format would thus become more whitespace sensitive and brittle in this corner of the language. So far, those kind of corners are very rare in Dart, which is a nice feature. (One such corner is that `— — a` and `--a` are both valid but mean different things.)

理论上，对格式化后的代码来说，依赖空白不是问题。
但许多用户会把未格式化的 Dart 代码作为格式化器的输入。
这样一来，在语言的这个角落里，输入格式就会对空白更敏感、更脆弱。
迄今为止，这类角落在 Dart 中非常少见，这是个优点。
（一个这样的角落是：`— — a` 和 `--a` 都合法，但含义不同。）

Ignoring the ambiguity, there’s another reason for using the dot: if we add null-aware forms for other operators — `e1?.+(e2)`, etc. — we’ll probably want to require the dot, in which case requiring it for subscript is consistent with that future.

抛开歧义不谈，使用点号还有另一个理由：
如果我们为其他运算符添加 null 感知形式——`e1?.+(e2)` 等——
我们很可能也会要求带点号，
那么下标要求点号就与那个未来保持一致。

Another addition we’ve discussed for NNBD is a null-aware call syntax. If we don’t require a dot there, it has the exact same ambiguity problem:

我们为 NNBD 讨论过的另一项新增内容是 null 感知调用语法。
如果那里不要求点号，就会遇到一模一样的歧义问题：

```
var wat = { e1?(e2):e3 }; // Map or set?
```


Whatever fix we come up with for the `?[`, we’ll also have to apply to `?(`.

无论我们为 `?[` 想出什么修复方案，也都必须应用到 `?(` 上。

Finally, consider this example of chaining the subscript:

最后，看看这个下标链式调用的例子：

```
someJson?[recipes]?[2]?[ingredients]?[pepper]
```


To our eyes, that doesn’t look very good. It scans less like a method chain and more like some combination of infix operators — a little like `??`. Compare it to this code:

在我们看来，这不太好看。它读起来不太像方法链，
更像某种中缀运算符的组合——有点像 `??`。对比这段代码：

```
someJson?.[recipes]?.[2]?.[ingredients]?.[pepper]
```


Here, it’s more clearly a method chain. Communicating that visually is important too, because users need to quickly understand how much of an expression will get null-short-circuited.

这里就更明显是一条方法链。在视觉上传达这一点也很重要，
因为用户需要快速理解表达式中有多大部分会被 null 短路。

Putting all of that together, it seems like we should use the `?.[` form for the following reasons:

综合以上各点，我们似乎应该使用 `?.[` 形式，理由如下：

* It avoids ambiguity problems. (The lexer already treats `?.` as a single “null-aware” token.)

  它避免了歧义问题。（词法分析器已经把 `?.`
  当作单个“null 感知”记号。）

* It extends naturally to a null-aware call.

  它能自然扩展到 null 感知调用。

* It extends to other null-aware operators.

  它能扩展到其他 null 感知运算符。

* It leaves Dart a more robust input language to the formatter.

  它让 Dart 作为格式化器的输入语言更加健壮。

* It looks pretty OK in a method chain.

  它在方法链中看起来还不错。

* It makes it visually clearer how much of a method chain may be short-circuited.

  它在视觉上更清楚地表明方法链中有多少部分可能被短路。

## What do you think?

## 你怎么看？

We’re always interested in feedback and suggestions. The best way to give feedback on this syntax is to comment (or thumbs-up a comment) on [language issue #376](https://github.com/dart-lang/language/issues/376). While you’re at it, consider checking out all of the other cool language features we’re working on.

我们始终欢迎反馈和建议。对这一语法给出反馈的最佳方式，
是在[语言 issue #376](https://github.com/dart-lang/language/issues/376)
下评论（或给某条评论点赞）。顺便也欢迎看看我们正在开发的
其他很酷的语言特性。

Here’s where you can find more information:

你可以在这些地方找到更多信息：

NNBD:

NNBD：

* [Feature specification](https://github.com/dart-lang/language/blob/master/accepted/future-releases/nnbd/feature-specification.md)

  [特性规范](https://github.com/dart-lang/language/blob/master/accepted/future-releases/nnbd/feature-specification.md)

* [Roadmap](https://github.com/dart-lang/language/blob/master/accepted/future-releases/nnbd/roadmap.md)

  [路线图](https://github.com/dart-lang/language/blob/master/accepted/future-releases/nnbd/roadmap.md)

* [Issues](https://github.com/dart-lang/language/issues?utf8=%E2%9C%93&q=label%3Annbd)

  [Issue 列表](https://github.com/dart-lang/language/issues?utf8=%E2%9C%93&q=label%3Annbd)

Other Dart language changes and features:

其他 Dart 语言变更与特性：

* [Status of language changes](https://github.com/dart-lang/language/projects/1)

  [语言变更状态](https://github.com/dart-lang/language/projects/1)

* [Language evolution process](https://github.com/dart-lang/language/blob/master/doc/life_of_a_language_feature.md#dart-language-evolution-process)

  [语言演进流程](https://github.com/dart-lang/language/blob/master/doc/life_of_a_language_feature.md#dart-language-evolution-process)

* [Dart language specification](https://dart.dev/guides/language/spec)

  [Dart 语言规范](https://dart.dev/guides/language/spec)

<DashImage src="images/1se-VT1aPyHd3J2VYDzDW5g.webp" alt="A function declaration demonstrating a nullable return type and a nullable argument." caption="A function that accepts a null argument and can return null." />
