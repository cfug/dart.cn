---
# title: "Why nullable types?"
title: "为什么需要可空类型？"
# description: "Null in Dart code indicates that a variable has no value, but some languages don’t allow null. Learn why both approaches work."
description: "Dart 代码中的 null 表示变量没有值，但有些语言不允许 null。了解为什么两种做法都行得通。"
ai-translated: true
publishDate: 2020-12-07
author: munificent
image: images/1ihpy1Ngzg7SczCKkuh_WhQ.webp
category: other
layout: blog
---


A few weeks ago, we announced Dart null safety beta, a major productivity feature intended to help you avoid null errors. Speaking of null values, in the /r/dart_lang subreddit [a user recently asked](https://www.reddit.com/r/dartlang/comments/jruhji/why_does_nnbd_dart_still_have_null/gbwi364/):

几周前，我们宣布了 Dart 空安全（null safety）进入 beta 阶段，
这是一项旨在帮助你避免 null 错误的重大生产力特性。
说到 null 值，最近在 /r/dart_lang 子版块里
[有用户问道](https://www.reddit.com/r/dartlang/comments/jruhji/why_does_nnbd_dart_still_have_null/gbwi364/)：
> But why do we even still have/want null values? Why not get rid of it completely? I’m currently also playing around with Rust and it doesn’t have null at all. So it seems to be possible to live without it.

> 但我们为什么还要保留、还想要 null 值呢？为什么不彻底去掉它？
> 我最近也在玩 Rust，它根本没有 null。
> 看来没有 null 也是能活得很好的。

I love this question. Why *not* get rid of `null` completely? This article is an expanded version of what I answered on that thread.

我很喜欢这个问题。为什么*不*彻底去掉 `null` 呢？
本文是我在那个帖子下回答的扩展版。

The short answer is that, yes, it is entirely possible to live without `null`, and languages like Rust do. But programmers *do* use `null`, so before we can take it away, we need to understand why it’s used. What is `null` usually *doing* when we use it in languages that do have it?

简短的回答是：没错，完全没有 `null` 也能活得很好，
Rust 这样的语言就是如此。但程序员*确实*在用 `null`，
所以在拿走它之前，我们需要理解它为什么被使用。
在那些有 `null` 的语言里，我们使用它时，它通常在*扮演什么角色*？

It turns out that `null` is typically used to represent the *absence* of a value, which is eminently useful. Some people don’t have middle names. Some mailing addresses don’t have apartment numbers. Some monsters don’t have any treasure to drop when you slay them.

事实证明，`null` 通常用来表示值的*缺失*，这非常有用。
有些人没有中间名。有些邮寄地址没有公寓号。
有些怪物被你斩杀时不会掉落任何宝物。

In cases like that, we want a way to express, “This variable could have a value of type X, or it may have no value at all.” The question then is how do we model that?

在这类情况下，我们希望有一种方式来表达：
“这个变量可能有一个 X 类型的值，也可能根本没有值。”
那么问题来了：我们该如何为此建模？

One option is to say that a variable can contain a value of the expected type, or it can contain the magic value `null`. If we try to use the value when it’s `null`, we get a runtime failure. This is what Dart did before null safety, what SQL does, what Java does for non-primitive types, and what C# does for class types.

一种选择是：变量可以包含预期类型的值，
也可以包含魔法值 `null`。如果我们在值为 `null` 时尝试使用它，
就会遭遇运行时失败。这就是空安全之前的 Dart、SQL、
Java 的非原始类型以及 C# 的类类型所采用的做法。

But failing at runtime sucks. It means our users experience the bug. We programmers would rather find those failures before they do. In fact, we’d be happy if we could find the bugs even before *we* ran our program. So how do we model the absence of a value in a way that the type system understands? In other words, how do we give “potentially absent” values and “definitely present” values different static types?

但在运行时失败很糟糕。这意味着用户会亲身遇到 bug。
我们程序员宁愿赶在用户之前发现这些失败。
事实上，如果能在*我们自己*运行程序之前就发现 bug，那就更开心了。
那么，如何以类型系统能理解的方式为值的缺失建模？
换句话说，如何给“可能缺失”的值和“必定存在”的值
赋予不同的静态类型？

There are two main solutions:

主要有两种解决方案：

1. Use an option or maybe type

    使用 option 或 maybe 类型

1. Use a nullable type

    使用可空类型

## Solution 1: Option types

## 方案 1：可选类型

This is what [ML](https://en.wikipedia.org/wiki/ML_(programming_language)) and most functional languages derived from ML (including Rust, Scala, and Swift) do. When we know we will definitely have a value, we just use the underlying type. If we write `int` it means, “There is definitely an integer here.”

[ML](https://en.wikipedia.org/wiki/ML_(programming_language))
以及大多数源自 ML 的函数式语言（包括 Rust、Scala 和 Swift）
就是这么做的。当我们确定一定会有值时，就直接使用底层类型。
写下 `int` 就意味着：“这里一定有一个整数。”

To express a potentially absent value, we *wrap* the underlying type in an [option type](https://en.wikipedia.org/wiki/Option_type). So `Option&lt;int&gt;` represents a value that might be an integer or might be nothing at all. It’s like a collection type that can contain zero or one item.

要表达可能缺失的值，我们把底层类型*包装*进一个
[可选类型（option type）](https://en.wikipedia.org/wiki/Option_type)。
于是 `Option&lt;int&gt;` 表示一个可能是整数、也可能什么都没有的值。
它就像一个只能包含零个或一个元素的集合类型。

From the type system’s perspective, there is no direction relationship between `int` and `Option&lt;int&gt;`. Treating these as distinct types means we can’t accidentally pass a potentially-absent `Option&lt;int&gt;` to something expecting a real `int`. We also can’t accidentally try to use an `Option&lt;int&gt;` as if it were an integer since it doesn’t support any of those operations. We can’t perform arithmetic on an `Option&lt;int&gt;` any more than we could on a `List&lt;int&gt;`.

从类型系统的角度看，`int` 和 `Option&lt;int&gt;` 之间没有直接关系。
把它们当作不同的类型，意味着我们不会不小心把可能缺失的
`Option&lt;int&gt;` 传给期望真正 `int` 的地方。
我们也不会不小心把 `Option&lt;int&gt;` 当作整数来用，
因为它不支持任何整数操作。我们不能对 `Option&lt;int&gt;` 做算术，
就像不能对 `List&lt;int&gt;` 做算术一样。

To create a value of an option type from a present value of the underlying type (say `3`), you construct the option like `Some(3)`. To create an option type when the value is absent, you write something like `None()`.

要从底层类型的一个存在值（比如 `3`）创建可选类型的值，
你可以像 `Some(3)` 这样构造。要在值缺失时创建可选类型，
则写类似 `None()` 的东西。

In order to use a potentially absent integer stored in an `Option&lt;int&gt;`, we have to first check and see if the value is there. If so, we can extract the integer from the option and use it, just like reading a value out of a collection. Languages that have option types usually also have nice [pattern matching](https://en.wikipedia.org/wiki/Pattern_matching) syntax, which gives us an elegant way to check if the value is there and use it if so.

要使用存储在 `Option&lt;int&gt;` 中可能缺失的整数，
我们必须先检查值是否存在。如果存在，就可以从 option 中
取出整数来用，就像从集合中读取值一样。
拥有可选类型的语言通常也有好用的
[模式匹配（pattern matching）](https://en.wikipedia.org/wiki/Pattern_matching)语法，
让我们能优雅地检查值是否存在，存在就使用它。

## Solution 2: Nullable types

## 方案 2：可空类型

The other option (heh), is what Kotlin, TypeScript, and now Dart do. [Nullable types](https://en.wikipedia.org/wiki/Nullable_type) are a special case of [union types](https://en.wikipedia.org/wiki/Union_type).

另一种选择（嘿，双关了），就是 Kotlin、TypeScript
以及现在的 Dart 的做法。
[可空类型（nullable type）](https://en.wikipedia.org/wiki/Nullable_type)是
[联合类型（union type）](https://en.wikipedia.org/wiki/Union_type)的特例。

(Tangent: The naming gets really confusing here. Option types — what ML and friends do above — are a special case of [algebraic datatypes](https://en.wikipedia.org/wiki/Algebraic_data_type). Another name for algebraic datatypes is “discriminated unions”. But, despite “union” being in the name, “discriminated unions” are quite different from “union types”. As Phil Karlton said, there are only two hard problems in computer science: cache invalidation and naming things.)

（题外话：这里的命名真的很让人困惑。可选类型——
上面 ML 及其伙伴们的做法——是
[代数数据类型](https://en.wikipedia.org/wiki/Algebraic_data_type)的特例。
代数数据类型的另一个名字是“可辨识联合”（discriminated unions）。
但是，尽管名字里有“联合”，“可辨识联合”与“联合类型”却大不相同。
正如 Phil Karlton 所说，计算机科学中只有两大难题：
缓存失效和命名。）

Similar to the option type approach, we use the underlying type to represent a definitely present value. So `int` again means we absolutely have an integer. If we want a potentially absent integer, we instead use the `int?` nullable type. The little question mark is syntactic sugar for writing what is essentially a union type like `int | Null`.

与可选类型的做法类似，我们用底层类型表示必定存在的值。
所以 `int` 同样意味着我们绝对有一个整数。
如果想要一个可能缺失的整数，就改用 `int?` 可空类型。
这个小小的问号是语法糖，本质上写的是
像 `int | Null` 这样的联合类型。

Just like with option types, a nullable type does not support the same operations as the underlying type. The type system won’t let us try to perform arithmetic on a nullable `int` because that isn’t safe. Likewise, we can’t pass a nullable integer to something that requires an actual integer.

和可选类型一样，可空类型不支持底层类型的那些操作。
类型系统不会让我们对可空的 `int` 做算术，因为那不安全。
同样，我们也不能把可空整数传给需要真正整数的地方。

However, the type system is a little more flexible than with option types. The type system understands that a union type is a supertype of its branches. In other words, `int` is a subtype of `int?`. That means we *can* pass a definitely-present-integer to something that expects a maybe-present-integer since that’s safe to do. It’s an upcast, just like we can pass a `String` to a function that takes `Object`. Dart only prohibits us from going the other way—from nullable to non-nullable—because that would be a downcast and those could fail.

不过，类型系统比可选类型的做法稍微灵活一些。
类型系统理解联合类型是其各分支的超类型。
换句话说，`int` 是 `int?` 的子类型。
这意味着我们*可以*把必定存在的整数传给期望可能存在整数的地方，
因为这样做是安全的。这是一次向上转型（upcast），
就像我们可以把 `String` 传给接受 `Object` 的函数。
Dart 只禁止反方向——从可空到非空——因为那是向下转型（downcast），
可能失败。

When we have a value of a nullable type and we want to see if there is an actual value or `null` there, we check the value imperatively just like we would naturally do in C or Java:

当我们拿到一个可空类型的值，想看看那里是实际的值还是 `null` 时，
就像在 C 或 Java 中自然会做的那样，用命令式的方式检查它：

```
foo(int? i) {
  if (i != null) {
    print(i + 1);
  }
}
```


The language then uses [flow analysis](https://en.wikipedia.org/wiki/Control-flow_graph) to determine which parts of the program are guarded behind those checks. The analysis determines that code can only be reached if the variable is not `null`, so inside those regions, the type system tightens the variable’s type to be non-nullable. So, here, it treats `i` as having type `int` inside the `if` statement.

然后语言使用[流分析（flow analysis）](https://en.wikipedia.org/wiki/Control-flow_graph)
来确定程序的哪些部分受到这些检查的保护。
分析确定：只有变量不为 `null` 时代码才可达，
所以在这些区域内，类型系统把变量的类型收紧为非空。
因此在这里，`if` 语句内部它把 `i` 当作 `int` 类型。

## Which solution should a language take?

## 一门语言该选哪种方案？

So when we on the Dart team decide to make the language handle null in a safer way, how should we go about choosing solution 1 or 2? We can start by observing our users. How do they want to write code that checks for absent values? In functional languages, pattern matching is one of the primary control flow structures, and users there are very comfortable with it. Using option types and pattern matching is natural in that style.

那么，当 Dart 团队决定让语言以更安全的方式处理 null 时，
该如何在方案 1 和方案 2 之间做选择？我们可以从观察用户开始。
他们想怎样编写检查缺失值的代码？在函数式语言中，
模式匹配是主要的控制流结构之一，那里的用户对此非常习惯。
在这种风格下，使用可选类型和模式匹配是很自然的。

In imperative languages derived from C, code like my previous example is the idiomatic way to check for `null`. Using flow analysis and nullable types makes that familiar code work correctly and safely. In fact, with Dart, we’ve found that *most existing code is already statically null safe with the new type system* because the new flow analysis correctly analyzes the already written code.

在源自 C 的命令式语言中，像我前面例子那样的代码
是检查 `null` 的惯用方式。使用流分析和可空类型，
能让这些熟悉的代码正确、安全地工作。事实上，在 Dart 中我们发现，
*大多数现有代码在新类型系统下已经是静态空安全的*，
因为新的流分析能正确分析已经写好的代码。

(This is in some ways not a surprise. *Most* code is already *dynamically* correct with regards to handling `null`. If it wasn’t, it would be crashing all the time. Much of the job is simply making the type system smart enough to see that that code is already correct, so that the user’s attention is drawn to the few bits that are *not*.)

（这在某种程度上并不意外。*大多数*代码在处理 `null` 方面
已经是*动态*正确的。否则它就会一直崩溃。
大部分工作只是让类型系统足够聪明，看出那些代码已经正确，
从而把用户的注意力引向*不正确*的那一小部分。）

So if our goal is to maximize familiarity and user comfort (which *are* important criteria in language design), we should just follow the path that our language’s control flow structures lay out for us.

所以，如果我们的目标是最大化熟悉度和用户舒适度
（这*确实是*语言设计的重要标准），
就应该顺着语言的控制流结构为我们铺好的路走。

## Representing absence and presence

## 缺失与存在的表示

There is a deeper way to approach this question based on differences between how option types and nullable types are represented. That representation difference forces a few key trade-offs on us, and those might lean us in one direction or the other.

还有一个更深入的视角：基于可选类型和可空类型
在表示方式上的差异来审视这个问题。
这种表示差异迫使我们做出几个关键取舍，
而这些取舍可能让我们倾向某一边。

With the first approach, a value of option type has a runtime representation distinct from the underlying value. Say we chose option types in Dart, and you created one and then upcast it to `Object`:

在第一种做法中，可选类型的值拥有与底层值不同的运行时表示。
假设 Dart 选择了可选类型，你创建了一个，
然后把它向上转型为 `Object`：

```
var optionalInt = Some(3);
Object obj = optionalInt;
print(obj is int); // false
```


Note the last line. An `Option&lt;int&gt;` value, even when present, is *not* the same kind of thing as a value of the underlying type. `Some(3)` and `3` are distinct, distinguishable values.

注意最后一行。`Option&lt;int&gt;` 的值即使存在，
也*不是*与底层类型的值同一种东西。
`Some(3)` 和 `3` 是两个不同、可区分的值。

That’s not how nullable types work:

可空类型不是这样工作的：

```
var nullableInt = 3 as int?;
Object obj = nullableInt;
print(obj is int); // true
```


Nullable types exist in the *static type system*, but the runtime representation of values uses the underlying type. If you have a “nullable 3”, at runtime it’s just the number `3`. If you have an absent value of some nullable type, at runtime you just have the solitary magic value `null`.

可空类型存在于*静态类型系统*中，
但值的运行时表示使用底层类型。如果你有一个“可空的 3”，
在运行时它就是数字 `3`。如果你有一个某可空类型的缺失值，
在运行时你就只有那个孤零零的魔法值 `null`。

You can ask if a value is of a nullable type:

你可以询问一个值是否属于可空类型：

```
print(obj is int?);
```


But the `is int?` expression is equivalent to:

但 `is int?` 表达式等价于：

```
print(obj is int || obj is Null);
```


## Nested optionals

## 嵌套的可选类型

Since values of option types are different from the underlying type, this gives us an important capability: Option types can nest.

由于可选类型的值不同于底层类型，这给了我们一个重要能力：
可选类型可以嵌套。

Let’s say we have some network service that gives out resource strings when given a request with some integer ID. Some resources are not present and the server will respond with no data for that ID. Since hitting the network is slow, we want to locally cache the results of requests we’ve already performed.

假设有一个网络服务，收到带整数 ID 的请求时返回资源字符串。
有些资源不存在，服务器对该 ID 会响应无数据。
由于访问网络很慢，我们想在本地缓存已执行请求的结果。

In Dart before null safety, we might use a map like so:

在空安全之前的 Dart 中，我们可能会用这样的 map：

```
Map<int, String> cache;
```


So before making a network request for some ID, we use the subscript operator on the cache map to look up the resource’s ID. That operator is defined on `Map` to return `null` if the key is not present. But the key could also be present and associated with a `null` value. If we do a lookup and get back `null`, it could mean either:

于是，在为某个 ID 发起网络请求之前，
我们用缓存 map 上的下标运算符查找该资源的 ID。
`Map` 上定义的该运算符在键不存在时返回 `null`。
但键也可能存在、且关联着一个 `null` 值。
如果查找后得到 `null`，它可能意味着两种情况之一：

* The key was not present in the map. This means we haven’t done the request yet, so we should ask the server to look up the resource.

  键不在 map 中。这意味着我们还没发起过请求，
  应该请服务器查找该资源。

* The key was present and associated with `null`. This means we already did ask the server, found that the resource wasn’t present, and stored that in the cache. We should use that result and not query the server again.

  键存在且关联着 `null`。这意味着我们已经问过服务器，
  发现资源不存在，并把这一结果存进了缓存。
  我们应该使用该结果，不再查询服务器。

Because there’s only a single `null` value in the entire system, we don’t have a runtime representation that can distinguish these two cases. This is why the `Map` class has a separate `containsKey()` method. That API provides a way to distinguish these two cases.

由于整个系统中只有一个 `null` 值，
我们没有能区分这两种情况的运行时表示。
这就是 `Map` 类有一个单独的 `containsKey()` 方法的原因。
那个 API 提供了区分这两种情况的途径。

Now, if Dart were built around option types, the cache would look like:

现在，如果 Dart 围绕可选类型构建，缓存会是这样：

```
Map<int, Option<String>> cache;
```


And the subscript operator would return an optional value:

而下标运算符会返回一个可选值：

```
class Map<K, V> {
  Option<V> operator [](K key) => ...
  ...
}
```


In the case of our `Map&lt;int, Option&lt;String&gt;&gt;`, that means the return type is `Option&lt;Option&lt;String&gt;&gt;`. Note the nesting! Now, when we look up a key in the cache, we can get a few different results:

对我们的 `Map&lt;int, Option&lt;String&gt;&gt;` 来说，
这意味着返回类型是 `Option&lt;Option&lt;String&gt;&gt;`。注意这个嵌套！
现在，在缓存中查找一个键时，可能得到几种不同的结果：

* A `Some(Some(string))` means the resource did exist on the server, and we have it in the cache now.

  `Some(Some(string))` 表示资源确实存在于服务器上，
  而且我们现在已把它缓存起来了。

* A `Some(None())` means we did ask the server and the resource was not there, so we have cached the fact that the resource doesn’t exist.

  `Some(None())` 表示我们问过服务器、资源不在那里，
  所以我们缓存了“资源不存在”这一事实。

* A `None()` means the cache does not contain this ID at all.

  `None()` 表示缓存中根本没有这个 ID。

We can distinguish the last two cases because options always wrap their underlying value in some extra state. At runtime, we can determine how many layers there are and peel them off individually.

我们能区分后两种情况，因为 option 总是用一些额外状态
包装底层值。在运行时，我们可以确定有多少层，
并逐层剥开。

Nullable types, since they have no explicit runtime representation, are implicitly flattened. So `int?` and `int??` are equivalent types to the type system and have equivalent sets of values at runtime. This is why fans of option types describe them as “more expressive”: because optional types give you a way to represent more kinds of values than nullable types do.

可空类型没有显式的运行时表示，因此被隐式地扁平化了。
所以对类型系统而言，`int?` 和 `int??` 是等价的类型，
在运行时也拥有等价的值集合。这就是可选类型的爱好者
称其“更有表达力”的原因：可选类型让你能表示
比可空类型更多种类的值。

## Nullable substitution

## 可空替换

Another way of thinking about “expressiveness” is how much *effort* it takes for the user to express what they actually want to express. A language is more expressive if the user can reach their goal while jumping through fewer hoops.

思考“表达力”的另一种方式是：用户要表达自己真正想表达的东西，
需要付出多少*努力*。如果用户能少绕弯子就达成目标，
这门语言就更有表达力。

An advantage of having no distinct representation for nullable types is that values can flow from non-nullable to nullable contexts much more easily. Let’s say you have a function that accepts an optional integer parameter. With option types, the signature would look something like:

可空类型没有独立表示的一个好处是：
值可以更容易地从非空上下文流向可空上下文。
假设你有一个接受可选整数参数的函数。
用可选类型的话，签名大概是这样：

```
takesMaybeInt(Option<int> optionalInt) {}
```


To call this function with a known integer, it must be wrapped in an option first:

要用一个已知整数调用这个函数，必须先把它包进 option：

```
takesMaybeInt(Some(3));
```


With nullable types, since there is no representation difference, you can pass a value of the underlying type directly:

用可空类型的话，由于没有表示上的差异，
你可以直接传底层类型的值：

```
takesMaybeInt(3);
```


You get this flexibility everywhere in the type system. You can override a method that returns a nullable type to return a non-nullable type. You can pass a `List&lt;int&gt;` to a function that wants a `List&lt;int?&gt;`.

这种灵活性遍布整个类型系统。你可以重写一个返回可空类型的方法，
让它返回非空类型。你可以把 `List&lt;int&gt;`
传给想要 `List&lt;int?&gt;` 的函数。

So while nullable types lose the ability to nest and represent multiple distinct *kinds* of “absence”, in return they make it much easier to work with the one blessed notion of `null`.

所以，虽然可空类型失去了嵌套、表示多种不同*种类*
“缺失”的能力，但作为回报，
它们让使用 `null` 这唯一公认概念变得容易得多。

## Nullability for Dart

## Dart 的可空性

Dart is an imperative language where people already use `if` statements to check for absent values at runtime. It’s also an object-oriented language where we already have a special `null` value with its own runtime representation. So solution 2, nullable types, was the natural answer for us. It lets our users write the kind of code they are familiar with, and takes advantage of how the runtime already represents values.

Dart 是一门命令式语言，人们已经在用 `if` 语句
在运行时检查缺失值。它也是一门面向对象语言，
已经有一个拥有自己运行时表示的特殊 `null` 值。
所以方案 2——可空类型——对我们来说是自然而然的答案。
它让用户编写自己熟悉的那类代码，
并利用运行时既有的值表示方式。

For more information about nullability in Dart, check out the [Where to learn more](https://dart.dev/null-safety#where-to-learn-more) section of the [Dart null safety docs](https://dart.dev/null-safety).

要进一步了解 Dart 中的可空性，请查看
[Dart 空安全文档](https://dart.dev/null-safety)的
[Where to learn more](https://dart.dev/null-safety#where-to-learn-more) 一节。

<DashImage src="images/1ihpy1Ngzg7SczCKkuh_WhQ.webp" alt="Puzzle with one missing piece." caption="One of these puzzle pieces is null." />
