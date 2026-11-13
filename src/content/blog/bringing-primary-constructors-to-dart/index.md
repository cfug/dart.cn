---
# title: "Bringing Primary Constructors to Dart"
title: "为 Dart 带来主构造函数"
# description: "An inside look at the design decisions, trade-offs, and syntactic sugar behind adding primary constructors to Dart 3.13."
description: "深入解读为 Dart 3.13 添加主构造函数背后的设计决策、取舍与语法糖。"
ai-translated: true
publishDate: 2026-08-20
author: munificent
image: images/dash-primary-constructors.webp
category: deep-dive
layout: blog
---

<DashImage
  src="images/dash-primary-constructors.webp"
  alt="Illustration of Dash with blueprint drawing of primary constructor syntax."
  caption="Bringing primary constructors to Dart"
/>

(AI disclosure: I wrote every sentence of this myself—including the em
dashes.)

（AI 披露：本文每一句话都是我亲手写的——包括那些破折号。）

My favorite feature in Dart 3.13 is
[primary constructors](https://dart.dev/language/primary-constructors).
Getting there took a lot of time and iteration before the language team had a
design we felt was solid. Since many of you have been patiently waiting for
this feature, I thought it would be worth writing about some of the challenges
we worked through to bring this large syntax change to Dart.

Dart 3.13 中我最喜欢的特性是
[主构造函数（primary constructors）](https://dart.dev/language/primary-constructors)。
在语言团队打磨出一个我们认为足够扎实的设计之前，
这个特性经历了大量的时间和反复迭代。
既然你们中的许多人一直在耐心等待这个特性，
我想值得写一写我们一路解决的那些挑战，
以及我们如何把这一大型语法变更带进 Dart。

## On syntactic sugar

## 谈语法糖

Users have been asking for something like primary constructors for years.
It's a highly desired feature, which is kind of strange when you think about
it. Primary constructors don't let you do anything you can't already do in
Dart. They're just a different—hopefully better!—syntax for what you can
already express.

多年来，用户一直在要求类似主构造函数的东西。
这是一个呼声极高的特性，仔细想想却有点奇怪：
主构造函数并不能让你做到任何 Dart 里本来做不到的事。
它只是为你已经能表达的东西提供另一种——希望是更好的！——语法。

In the 1960s, Peter Landin coined the term "syntactic sugaring" to refer to
layering some textual niceties on top of a more fundamental but unpleasant
language. Today, we tend to use the term more like a noun and call features
like these "syntactic sugar".

20 世纪 60 年代，Peter Landin 创造了“语法加糖”（syntactic sugaring）
一词，指在一门更基础但并不友好的语言之上，
叠加一些书写上的便利。如今，我们更倾向于把这个词当名词用，
把这类特性称为“语法糖”（syntactic sugar）。

The immortal enemy of every programming language is complexity.
Even the tiniest feature must be designed,
specified, implemented, tested, and documented.
The cost is large. I think of complexity in a language like weight in an
airplane. Some amount of it is necessary for the thing to work,
but you have to be careful to not add weight unnecessarily or risk the whole
apparatus not getting off the ground.

每门编程语言不共戴天的敌人都是复杂性。
哪怕最小的特性也必须经过设计、规范、实现、测试和文档编写。
代价是巨大的。我把语言中的复杂性想象成飞机的重量：
一定程度的重量是飞机能工作所必需的，
但你必须小心，不要无谓地增加重量，
否则整个装置可能根本飞不起来。

From that angle, syntactic sugar seems like a bad idea.
It's additional complexity with no additional utility.
Even worse, once we add it, we pass complexity onto our users too.
Now they have to choose which syntax to use each time they are trying to
express something.

从这个角度看，语法糖似乎是个坏主意：
它增加了复杂性，却没有增加任何效用。
更糟的是，一旦加了语法糖，我们也把复杂性转嫁给了用户。
现在，他们每次想表达某个东西时，都得选择用哪种语法。

When are these kinds of features ever a good idea?
(I admit I feel some need to justify this because so much of my work over the
past several years has been adding these kinds of features to Dart.)
I think syntactic sugar can carry its weight in a couple of ways:

这类特性什么时候才是好主意呢？
（我承认我觉得有必要为此辩护一下，
因为过去几年我的大量工作就是给 Dart 添加这类特性。）
我认为语法糖可以通过几种方式值回它的“体重”：

### The new way is simply better

### 新写法就是更好

Despite our somewhat robotic affect and fondness for
[EBNF](https://en.wikipedia.org/wiki/Extended_Backus%E2%80%93Naur_form), we
language designers are human and make mistakes.
Further, we are always learning, the ecosystem we serve is constantly
discovering new ways to make software,
and user expectations drift over time.

尽管我们显得有些机械刻板，还偏爱
[EBNF](https://en.wikipedia.org/wiki/Extended_Backus%E2%80%93Naur_form)，
但语言设计者也是人，也会犯错。
而且我们一直在不断学习，我们服务的生态系统
也在不断发现构建软件的新方式，用户的期望则会随时间变化。

When Dart was first designed, you had to use an explicit `new` keyword to call
a constructor. This was deliberate to be familiar to users coming from C++,
Java, JavaScript, and other languages.
The intent was to make it clearer in the code when a call allocates a new
object. As garbage collectors got better and users got more comfortable with
automatic memory management, most users found `new` to be more noise than
signal.

Dart 最初设计时，调用构造函数必须使用显式的 `new` 关键字。
这是有意为之，为的是让从 C++、Java、JavaScript
等语言过来的用户感到熟悉。
当时的意图是让代码更清楚地表明某次调用会分配一个新对象。
随着垃圾回收器越来越好、用户对自动内存管理越来越习惯，
大多数用户觉得 `new` 带来的噪音多于信号。

(Also, honestly, Dart has always undermined that signal by supporting
[factory constructors](https://dart.dev/language/constructors#factory-constructors).
A factory constructor can return some previously created object even when you
invoke it with `new`.)

（另外，说实话，Dart 一直都在削弱这个信号，
因为它支持[工厂构造函数（factory constructors）](https://dart.dev/language/constructors#factory-constructors)。
即使你用 `new` 调用工厂构造函数，
它也可以返回某个先前创建的对象。）

In Dart 2.0, we shipped a language change that allowed you to omit the `new`
keyword (and `const` in many places) when calling a constructor.
We still support the old syntax, so this language change is essentially
syntactic sugar, but we really only kept the old syntax around for backwards
compatibility.

在 Dart 2.0 中，我们发布了一项语言变更，
允许在调用构造函数时省略 `new` 关键字（很多地方还可以省略 `const`）。
我们仍然支持旧语法，所以这项语言变更本质上就是语法糖，
但我们保留旧语法其实只是为了向后兼容。

We always want you to use the new shorter syntax.
We shipped [tooling](https://dart.dev/tools/dart-fix) to automatically remove
the unnecessary `new` keywords, and have
[a lint](https://dart.dev/tools/linter-rules/unnecessary_new) that reminds you
when you forget. The old syntax is effectively deprecated and over time you
see it less and less. If you're new to Dart,
you may not have even realized we supported using `new` in constructor calls.

我们总是希望你使用更简短的新语法。
我们发布了能自动移除多余 `new` 关键字的[工具](https://dart.dev/tools/dart-fix)，
还提供了[一条 lint 规则](https://dart.dev/tools/linter-rules/unnecessary_new)，
在你忘记时提醒你。旧语法实际上已被弃用，
随着时间推移你会越来越少见到它。如果你刚接触 Dart，
你甚至可能没意识到我们曾支持在构造函数调用中使用 `new`。

That means the complexity for supporting constructor calls both with and
without `new` is low. There is a transition cost for existing users to learn
the new syntax. But new users will mostly just learn the new way and never
encounter the old. There's little cognitive load when choosing between the two
syntaxes because you simply always use the new one (and our tools will gently
remind you if you don't).

这意味着，同时支持带 `new` 和不带 `new`
的构造函数调用所带来的复杂性很低。
现有用户学习新语法有一定的过渡成本，
但新用户基本只会学到新写法，永远不会遇到旧写法。
在两种语法之间做选择几乎没有认知负担，
因为你总是用新的那种（如果你没用，我们的工具会温和地提醒你）。

Short of having a time machine to go back and do it right the first time,
this is the next best thing we can do to fix a mistake in the language.

除非有一台时光机能回到过去、第一次就做对，
否则这就是我们修正语言错误所能做的次优选择。

### The syntax can be much better for a common use case

### 对常见用例，语法可以好得多

For the first several years of its public existence,
Dart had no support for enum declarations.
The language didn't let you write:

在 Dart 公开发布后的最初几年里，
它并不支持枚举声明。这门语言不允许你写：

```dart
enum Color { red, blue, yellow }
```

Instead, you had to write something like this:

相反，你必须写类似这样的代码：

```dart
class Color {
  static const Color red = Color._(0, 'red');
  static const Color blue = Color._(1, 'blue');
  static const Color yellow = Color._(2, 'yellow');

  const Color._(this.index, this.name);

  final int index;
  final String name;
}
```

Old Java heads will remember this as Josh Bloch's "typesafe enum pattern".
Under the hood, this more verbose class declaration does almost exactly the
same thing as an enum declaration in Dart today.
Dart enum declarations are almost entirely sugar.
(I say "almost" because enum declarations give you
[exhaustiveness checks](https://dart.dev/language/branches#exhaustiveness-checking)
in switches.)

老 Java 程序员会记得，这就是 Josh Bloch 的
“类型安全枚举模式”（typesafe enum pattern）。
在底层，这个更冗长的类声明所做的事情，
几乎与今天 Dart 中的枚举声明完全相同。
Dart 的枚举声明几乎完全是糖。
（我说“几乎”，是因为枚举声明还能在 switch 中提供
[穷尽性检查（exhaustiveness checks）](https://dart.dev/language/branches#exhaustiveness-checking)。）

However, as you can see from these two examples,
enum declarations are *really nice* sugar.
A simple enum declaration unpacks to a lot of Dart code.
Now, if almost no one was writing enumerated types,
then it might still not be worth adding syntax to optimize for this use case.
But in a language that prioritizes type safety and data validation,
enums are quite common. The Flutter framework alone defines dozens of them.

不过，从这两个例子可以看出，
枚举声明是*非常棒的*糖。
一个简单的枚举声明展开后是大量 Dart 代码。
当然，如果几乎没人写枚举类型，
那么为这个用例优化语法可能仍然不值得。
但在一门把类型安全和数据校验放在优先位置的语言里，
枚举相当常见。仅 Flutter 框架就定义了几十个枚举。

A relatively small amount of syntactic sugar can sometimes make a *lot* of
user code shorter and simpler.

相对少量的语法糖，有时能让*大量*用户代码变得更短、更简单。

### The syntax can make the intent clearer

### 语法可以让意图更清晰

The previous section makes it sound like brevity is the whole point.
I suppose in a world where we are increasingly paying AI agents per-token
costs to read and write code there is a direct financial incentive.
But it's not just about character count.
Consider:

上一节听起来好像在说简洁就是全部意义。
我想，在一个我们越来越多地按 token 付费、
让 AI 智能体读写代码的世界里，这确实有直接的经济动机。
但这不只是字符数的问题。请看：

```dart
class Color {
  static const Color red = Color('red', 0xff0000);
  static const Color blue = Color('blue', 0x0000ff);
  static const Color yellow = Color('yellow', 0xff00ff);

  const Color(this.name, this.rgb);

  final String name;
  final int rgb;
}
```

Is this an enumerated type? By that,
I really mean *enumerated*: Should someone using this class assume that the
*only* instances of `Color` they will have to worry about are `red`,
`blue`, or `yellow`?

这是一个枚举类型吗？我说的“枚举”是真正*可枚举*的意思：
使用这个类的人是否应该假定，
他们需要关心的 `Color` 实例*只有* `red`、`blue` 和 `yellow`？

Note that the constructor *is* public,
so other libraries are free to invoke the constructor and create other colors.
Is the intent of this class to be a *closed* list of colors,
or an open factory of them with a handful of pre-defined values?

注意，这个构造函数*是*公开的，
所以其他库可以随意调用它来创建别的颜色。
这个类的意图是提供一个*封闭的*颜色列表，
还是一个开放的颜色工厂，只是附带几个预定义值？

Reading the code, *we don't know.* The code is a lot of machinery that defines
a type and some constants. It *looks like* the code you'd write if you did
want an enum, but the machinery doesn't reveal the intent.
The code tells the compiler what the code means,
but it doesn't tell a reader how to use it.

读这段代码，*我们无从得知。*
代码是一大堆定义类型和常量的机制。
它*看起来像*你想写枚举时会写的代码，
但这些机制并没有揭示意图。
代码告诉编译器它是什么意思，
却没有告诉读者该如何使用它。

If we change this to an enum declaration,
then the policy that it's a closed set of values becomes obvious.
(And, now that Dart has real enums,
choosing to *not* change this code to an enum declaration likely sends a
signal that it's *not* a closed set.)

如果我们把它改成枚举声明，
“这是一个封闭的值集合”这条策略就一目了然了。
（而且，既然 Dart 已经有了真正的枚举，
选择*不*把这段代码改成枚举声明，
很可能传递出它*不是*封闭集合的信号。）

For me, this is a compelling reason to add syntactic sugar.
Code is written and executed as syntax,
but what every user working with the code cares about is what it *means*—its
semantics. To maintain code correctly,
we need to understand its intentions and policy.
This is increasingly true in a world where AI is often generating code faster
than we have time to diligently review it.

对我来说，这是添加语法糖的一个令人信服的理由。
代码以语法的形式被书写和执行，
但每个使用代码的人真正关心的是它的*含义*——它的语义。
要正确地维护代码，我们需要理解它的意图和策略。
在一个 AI 生成代码的速度常常快过我们认真审查速度的世界里，
这一点越来越重要。

Even when it's possible to make the compiler do what you want by cobbling
together the machinery of several existing language features,
it can be worth it to have syntactic sugar that yields the same behavior
because better syntax raises that behavior into a higher level of abstraction
where the intended semantics are more obvious.
That can *reduce* the cognitive work required to understand the code even
though the entire language is more complex.

即使把几个现有语言特性的机制拼凑起来，
也能让编译器做你想做的事，
但拥有产生相同行为的语法糖仍然可能是值得的，
因为更好的语法把这种行为提升到更高的抽象层次，
让预期语义更加明显。
这可以*减少*理解代码所需的认知工作，
尽管整门语言变得更复杂了。

## Why primary constructors

## 为什么要主构造函数

Right, I'm supposed to be talking about primary constructors,
not enums and `new` keywords. (Though—foreshadowing!—I will be talking about
`new` too.) For many years, the
[#1 open issue](https://github.com/dart-lang/language/issues/314) on the Dart
language repo has been a feature request for data classes.
If you don't know, data classes are
[a feature in Kotlin](https://kotlinlang.org/docs/data-classes.html) that lets
you define a class with some fields,
and the compiler gives you equality,
hash code, and some other stuff for free.

好吧，我该谈的是主构造函数，而不是枚举和 `new` 关键字。
（不过——提前剧透！——我后面还会谈到 `new`。）
多年来，Dart 语言仓库中
[排名第一的开放 issue](https://github.com/dart-lang/language/issues/314)
一直是关于数据类的特性请求。
如果你不了解，数据类（data classes）是
[Kotlin 中的一项特性](https://kotlinlang.org/docs/data-classes.html)，
让你定义一个带若干字段的类，
编译器就免费为你提供相等性、哈希码以及其他一些东西。

If you read through the hundreds of comments on that issue,
you'll see that most users are less interested in the value semantics part—the
equality and hash code bits. It's mostly about having an easier way to define
a class that has a constructor and stores some state.

如果你通读那个 issue 下的数百条评论，
你会发现大多数用户对值语义（value semantics）部分——
相等性和哈希码那些东西——兴趣没那么大。
他们主要想要的是更轻松地定义一个
带构造函数、能存储一些状态的类。

That functionality actually comes from a different,
more fundamental feature in Kotlin:
[primary constructors](https://kotlinlang.org/docs/classes.html#primary-constructor).
I believe Kotlin got this idea from
[Scala](https://docs.scala-lang.org/scala3/book/domain-modeling-tools.html#classes).
Since then,
[C#](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/instance-constructors#primary-constructors)
and [Java](https://openjdk.org/jeps/395) have added their own takes on the
concept.

这个功能其实来自 Kotlin 中另一个更基础的特性：
[主构造函数](https://kotlinlang.org/docs/classes.html#primary-constructor)。
我相信 Kotlin 的这个想法来自
[Scala](https://docs.scala-lang.org/scala3/book/domain-modeling-tools.html#classes)。
在那之后，
[C#](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/instance-constructors#primary-constructors)
和 [Java](https://openjdk.org/jeps/395)
也各自加入了对这一概念的实现。

(The value semantics part of data classes is useful too.
We are
[exploring that separately](https://github.com/dart-lang/language/blob/main/working/value-classes/feature-specification.md).
)

（数据类的值语义部分也很有用。
我们正在[单独探索它](https://github.com/dart-lang/language/blob/main/working/value-classes/feature-specification.md)。）

There are two key pieces to primary constructors:

主构造函数有两个关键部分：

- You can define a constructor by writing a parameter list right inside the
  class header. That avoids needing to write a keyword or repeat the class name
  to declare the constructor. It also avoids two levels of nesting and
  indentation, one for the class body and one for the constructor parameter
  list, in very simple classes that only contain some state.

  你可以直接把参数列表写在类头部里来定义构造函数。
  这样就不需要写关键字或重复类名来声明构造函数，
  也省去了两层嵌套和缩进——一层属于类体，
  一层属于构造函数参数列表——
  对于只包含一些状态的非常简单的类来说尤其如此。

- Inside that parameter list, you can indicate that some parameters should
  declare corresponding instance fields that are automatically initialized from
  the parameter.

  在这个参数列表里，你可以指明某些参数应当声明对应的实例字段，
  并用参数的值自动初始化这些字段。

Without primary constructors or any other kind of syntactic sugar,
we have to do something like this in Dart:

如果没有主构造函数或任何其他语法糖，
我们在 Dart 里就得写这样的代码：

```dart
class Point {
  final int x;
  final int y;

  Point(int x, int y) : x = x, y = y;
}
```

In this example, we had to write the class name twice.
For each bit of state, we wrote its type twice and its name *four* times.
It's not too heinous in this example because there are only two fields and the
names are all short. Once you start dealing with complex domain-specific stuff
with long names and piles of state,
it gets ugly.

在这个例子里，类名我们写了两遍。
每一份状态，类型写了两遍，名字写了*四*遍。
这个例子还不算太糟，因为只有两个字段，名字也都很短。
一旦你开始处理名字很长、状态成堆的复杂领域逻辑，
代码就会变得难看。

This is not a new problem, and Dart has long had a bit of syntactic sugar
called "[initializing
formals](https://dart.dev/language/constructors#use-initializing-formal-parameters)"
to help:

这不是新问题，Dart 很早就有一点语法糖来帮忙，
叫做“[初始化形参（initializing formals）](https://dart.dev/language/constructors#use-initializing-formal-parameters)”：

```dart
class Point {
  final int x;
  final int y;

  Point(this.x, this.y);
}
```

Using `this.` on constructor parameters means you only have to write each
field's type once and name twice. Better!
But you still have to write the class name twice and each field's name twice.
Initializing formals are nice, but users still tell us they don't go far
enough.

在构造函数参数上使用 `this.`，
意味着每个字段的类型只需写一遍、名字写两遍。好多了！
但类名仍然要写两遍，每个字段的名字也还是要写两遍。
初始化形参很好，但用户仍然告诉我们：它还不够。

## On borrowing features from other languages

## 谈从其他语言借鉴特性

So some users coming to Dart from another language tell us that they miss a
feature. What do we do with that kind of feedback?

有些从其他语言转到 Dart 的用户告诉我们，他们想念某个特性。
我们该如何对待这类反馈？

Personally, I like borrowing features from other languages.
The creators of those languages have already put a lot of work into designing
and validating the feature. We can learn a lot from them,
and that other language is an existence proof that the feature is conceptually
coherent and tractable to implement.

就我个人而言，我喜欢从其他语言借鉴特性。
那些语言的创造者已经为设计和验证该特性投入了大量工作。
我们可以从中学到很多，
而且那门语言本身就是一份存在性证明：
这个特性在概念上是自洽的，在实现上是可行的。

Taking inspiration from other languages can also make our language easier to
learn. Unless a user is completely new to programming,
they aren't learning Dart from scratch.
They come to us with all that they have already learned from other languages.
What remains for them to learn is the *difference* between what they know and
what Dart contains. When we borrow syntax and semantics from other languages,
we reduce the size of that difference and lower the effort to learn Dart.

从其他语言汲取灵感还能让我们的语言更容易学。
除非用户完全是编程新手，否则他们并不是从零开始学 Dart。
他们带着从其他语言学到的全部知识来到我们这里。
剩下要学的，只是他们已知的东西与 Dart 所提供的东西之间的*差异*。
当我们从其他语言借鉴语法和语义时，
就缩小了这个差异，降低了学习 Dart 的成本。

This philosophy has been key to Dart's success.
From little semicolons all the way up to classes,
Dart was designed through and through to be familiar and easy to learn for
users of other mainstream languages like JavaScript,
Java, and C#.

这一理念是 Dart 成功的关键。
从小小的分号到类，Dart 自始至终的设计
都力求让 JavaScript、Java、C# 等其他主流语言的用户
感到熟悉、易于上手。

At the same time, good language design is contextual and holistic.
"What's a good pair of shoes?" has very different answers when you are
standing on the arctic tundra versus a Hawaiian beach.
A language feature that works beautifully in,
say, Rust might not slot gracefully into Dart with its distinct syntax,
semantics, history, user base, and ecosystem.

与此同时，好的语言设计要讲究语境和整体。
“什么是一双好鞋？”站在北极苔原上和站在夏威夷海滩上，
答案截然不同。
一个在（比如说）Rust 中运转出色的语言特性，
未必能优雅地融入拥有独特语法、语义、历史、
用户群和生态系统的 Dart。

I don't want Dart to feel like Frankenstein's monster stitched together from
body parts ripped off of other languages.
Thus, when the Dart language team looks at features from other languages,
we're simultaneously looking at how the feature solves problems in that
language's context and also at how well that context matches Dart's own.

我不希望 Dart 像弗兰肯斯坦的怪物那样，
由从其他语言身上撕下来的部件缝合而成。
因此，当 Dart 语言团队审视其他语言的特性时，
我们既在看该特性如何在那门语言的语境中解决问题，
也在看那个语境与 Dart 自身语境的契合程度。

## Adding primary constructors to Dart

## 为 Dart 添加主构造函数

We knew users wanted a nicer notation to define a class that initializes some
fields from constructor parameters.
With primary constructors, you write the constructor and the compiler
synthesizes the fields. A language could also go the other way.
You write the field declarations and the compiler gives you the constructor
for free. Swift does that with
[memberwise initializers](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/initialization/#Memberwise-Initializers-for-Structure-Types).

我们知道，用户想要一种更好的写法，
来定义一个用构造函数参数初始化若干字段的类。
有了主构造函数，你写构造函数，编译器合成字段。
一门语言也可以反过来：你写字段声明，编译器免费给你构造函数。
Swift 就是这么做的，用的是
[逐成员初始化器（memberwise initializers）](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/initialization/#Memberwise-Initializers-for-Structure-Types)。

A challenge any time your language derives two declarations from one piece of
syntax is that one syntax needs to handle all of the various ways you might
configure both of those declarations.
In our case here, the instance field may be final or not.
It might have metadata like `@override` or doc comments on it.
The constructor can be named or unnamed,
`const` or not. A constructor parameter can be positional or named,
optional or required. If it's optional,
it might need to specify a default value.

每当语言要从一段语法派生出两个声明时，都会面临一个挑战：
这一段语法必须覆盖你可能对这两个声明做的各种配置。
在我们这里，实例字段可以是 final 的，也可以不是；
它可能带有 `@override` 之类的元数据或文档注释。
构造函数可以是具名的或未命名的，可以是 `const` 的或不是。
构造函数参数可以是位置参数或命名参数，可选的或必需的。
如果是可选的，可能还需要指定默认值。

We spent some time investigating
[inferring a constructor from field declarations](https://github.com/dart-lang/language/issues/698),
but eventually decided that parameters were the more useful declaration for a
user to hand-author. Since the constructor is often public API,
it's important to control the signature fully:
the constructor's name and `const` -ness,
which parameters are named or positional,
the order of the positional ones, and their default values.

我们花了一些时间研究
[从字段声明推断构造函数](https://github.com/dart-lang/language/issues/698)，
但最终认定：参数才是更适合由用户亲手编写的声明。
由于构造函数往往是公开 API，完全控制它的签名很重要：
构造函数的名字、是否为 `const`、
哪些参数是命名参数或位置参数、
位置参数的顺序，以及它们的默认值。

In order to infer an instance field from a constructor parameter,
the only missing piece a user needs to provide is whether the field should be
final. It's fairly natural to allow a leading `final` or `var` on the
parameter to control that. The absence of both modifiers then means the
parameter doesn't declare an instance field at all.
That's similar to what Scala and Kotlin do with `val` and `var`.
The result in Dart looks like this:

要从构造函数参数推断出实例字段，
用户唯一还需要提供的信息是字段是否应为 final。
允许在参数前加 `final` 或 `var` 来控制这一点相当自然。
两个修饰符都不写，就表示该参数完全不声明实例字段。
这与 Scala 和 Kotlin 中 `val` 和 `var` 的做法类似。
在 Dart 中，结果看起来是这样：

```dart
class Point(
  final int x,
  final int y,
);
```

(Since primary constructors make empty class bodies more common,
we also now allow you to use `;` instead of `{}` for an empty class body.)

（由于主构造函数让空类体变得更常见，
我们现在也允许用 `;` 代替 `{}` 来表示空类体。）

## On syntactic cliffs

## 谈语法悬崖

This looks pretty nice, but what if the primary constructor also needs a body
or an initializer list? One option is to simply say,
"Well, in that case, don't use a primary constructor."
Syntactic sugar often takes a subset of use cases and offers more concise
syntax for them. If you fall outside of that subset,
it's reasonable to require the user to fall back to the older,
more elaborate syntax.

这看起来很不错，但如果主构造函数还需要函数体
或初始化列表呢？一种选择是直接说：
“那样的话，就别用主构造函数了。”
语法糖经常选取一部分用例，为它们提供更简洁的语法。
如果你的需求超出了这个子集，
要求用户退回到更老、更繁琐的语法是合理的。

That's the right call in some cases.
But the language team is very mindful that code evolves over time.
Let's say you're writing a class. It starts off simple with just a few fields
initialized from constructor parameters:

在某些情况下这是正确的选择。
但语言团队非常清楚：代码会随时间演化。
假设你正在写一个类。它一开始很简单，
只有几个由构造函数参数初始化的字段：

```dart
class FormatterOptions({
  final int indent = 0,
  final int pageWidth = 80,
}) {
  // ...
}
```

A perfect use case for a primary constructor.
Later you add some more fields and parameters.
Great. Before long, you have a constructor with a bunch of parameters
declaring fields:

这是主构造函数的完美用例。
后来你又加了一些字段和参数。很好。
没过多久，你就有了一个带一大堆声明字段的参数的构造函数：

```dart
class FormatterOptions(
  final int indent = 0,
  final int pageWidth = 80,
  final Version? languageVersion,
  final TrailingCommas? trailingCommas,
  final bool followLinks = false,
  final Show show = Show.changed,
  final Output output = Output.write,
  final Summary summary = Summary.none,
  final bool setExitIfChanged = false,
  final List<String> experimentFlags = const [],
) {
  // ...
}
```

Then one day you decide you want to do a little logging in the constructor
body. If primary constructors didn't support bodies,
then you would have to convert that entire primary constructor into an in-body
constructor:

然后有一天，你决定在构造函数体里做一点日志记录。
如果主构造函数不支持函数体，
你就不得不把整个主构造函数转换成类体内构造函数
（in-body constructor）：

```dart
class FormatterOptions {
  final int indent;
  final int pageWidth;
  final Version? languageVersion;
  final TrailingCommas? trailingCommas;
  final bool followLinks;
  final Show show;
  final Output output;
  final Summary summary;
  final bool setExitIfChanged;
  final List<String> experimentFlags;

  FormatterOptions({
    this.indent = 0,
    this.pageWidth = 80,
    this.languageVersion,
    this.trailingCommas,
    this.followLinks,
    this.show = Show.changed,
    this.output = Output.write,
    this.summary = Summary.none,
    this.setExitIfChanged = false,
    this.experimentFlags = const [],
  }) {
    log.write('Created options.');
  }

  // ...
}
```

That's doable. The Dart SDK includes lots of quick-fix tooling that can do
these exact kinds of changes for you with a click of a button,
so it's not *mechanically* hard to change the code.
But it's still a large textual change.
You just wanted to add a line of logging and now you have 20 lines of changes
to look at.

这是可行的。Dart SDK 包含大量快速修复工具，
一键就能替你完成这类改动，
所以改代码在*机械操作*上并不难。
但这仍然是一次很大的文本改动。
你只是想加一行日志，现在却要看 20 行的变更。

On the language team, we call this a "syntactic cliff".
You want to make a small *semantic* change (here,
adding a line of logging), but what you want to express is just slightly
outside the bounds of what the optimized syntax supports.
You fall off the nice plateau of that syntax and land on the more verbose
terrain below.

在语言团队里，我们把这称为“语法悬崖”（syntactic cliff）。
你想做一个很小的*语义*改动（这里是加一行日志），
但你想表达的东西恰好略微超出了优化语法所支持的范围。
你从那种语法的舒适高台上跌落，
落到下方更冗长的地形上。

It doesn't feel good when that happens.
You're trying to freely explore the semantic space of your program,
but it feels like some small steps in meaning are just out of reach in terms
of syntax. When we're designing language features,
we spend a lot of time talking about these kinds of cliffs and trying to avoid
them when we can.

发生这种事的感觉很不好。
你想自由探索程序的语义空间，
却感觉某些含义上的小步前进，在语法层面就是够不着。
在设计语言特性时，我们花大量时间讨论这类悬崖，
并尽可能避免它们。

We want the language to feel like smooth terrain where small semantic changes
only require equally small textual ones.
When you are doing a code review, we want the changed lines to reflect the
behavioral changes in the program, and not meaningless lateral moves through
the language's grammar.

我们希望语言像平缓的地形：
小的语义改动只需要同样小的文本改动。
当你做代码审查时，我们希望变更的行
反映程序行为的变化，
而不是在语言语法中毫无意义的横向平移。

## Primary constructor bodies

## 主构造函数的函数体

Kotlin's solution is to allow an
[initializer block](https://kotlinlang.org/docs/classes.html#initializer-blocks)
inside the class body. In Dart, we support something similar,
but using the `this` keyword:

Kotlin 的解决方案是允许在类体内写
[初始化块（initializer block）](https://kotlinlang.org/docs/classes.html#initializer-blocks)。
在 Dart 中，我们支持类似的机制，但使用 `this` 关键字：

```dart
class FormatterOptions(
  final int indent = 0,
  final int pageWidth = 80,
  final Version? languageVersion,
  final TrailingCommas? trailingCommas,
  final bool followLinks = false,
  final Show show = Show.changed,
  final Output output = Output.write,
  final Summary summary = Summary.none,
  final bool setExitIfChanged = false,
  final List<String> experimentFlags = const [],
) {
  this {
    log.write('Created options.');
  }
}
```

The initializer block gives you a place to fill in a body or initializer list
for the primary constructor. It's also a natural place to add a doc comment
for the constructor. (If you put the doc comment above the class header,
it applies to the entire class, not just the primary constructor.)

初始化块为你提供了一个地方，
用来给主构造函数补上函数体或初始化列表。
它也是给构造函数添加文档注释的自然位置。
（如果把文档注释放在类头部上方，
它作用于整个类，而不只是主构造函数。）

These initializer blocks are sort of syntactic sugar on top of syntactic
sugar. We don't need them, but they help prevent users from falling off a
syntactic cliff. You can start with a primary constructor while your class is
simple, and the language never forces you out of that choice as your class
evolves.

这些初始化块算是语法糖之上的语法糖。
我们并不需要它们，但它们有助于防止用户跌下语法悬崖。
类还简单时，你可以从主构造函数起步；
随着类的演化，语言永远不会强迫你放弃这个选择。

## On semantic bundling

## 谈语义捆绑

Now, even though *the language* won't force you to turn your primary
constructor into an in-body constructor,
*you* might still want to define a constructor inside the class body.
Classes can have a lot of things going on in the class header:
type parameters, an `extends` clause,
mixins in a `with` clause, and maybe `implements` too.
The constructor parameters might have doc comments.
It can get cluttered and messy up there.

现在，尽管*语言*不会强迫你把主构造函数变成类体内构造函数，
*你自己*可能仍然想在类体内定义构造函数。
类头部可能已经很热闹了：类型参数、`extends` 子句、
`with` 子句中的 mixin，也许还有 `implements`。
构造函数参数可能还带文档注释。
那里可能变得拥挤而杂乱。

Or you might have a class with multiple constructors where none of them is
clearly more "primary" than the others.
(When you have a primary constructor,
all other non-factory constructors for the class must redirect to it.)
Alternatively, maybe the most fundamental constructor is private,
and you think it looks confusing to put a private constructor in the highly
visible class header.

或者，你的类可能有多个构造函数，
没有哪一个明显比其他的更“主”。
（有主构造函数时，类的其他所有非工厂构造函数都必须重定向到它。）
又或者，最基础的构造函数是私有的，
而你觉得把私有构造函数放在显眼的类头部会让人困惑。

For these reasons and more, Dart still supports constructors declared inside
the class body. We don't think of primary constructors as *inherently superior
to* in-body constructors, just different and better suited to certain use
cases.

出于这些以及其他原因，Dart 仍然支持在类体内声明构造函数。
我们不认为主构造函数*天生优于*类体内构造函数，
它们只是不同，更适合某些用例而已。

However, only a primary constructor has access to the `var` and `final`
syntactic sugar on a parameter that implicitly declares an instance field and
initializes it from that parameter.
Those two features—declaring a constructor in the class header and constructor
parameters that induce fields—are bundled together.
You can't use the latter without the former.

不过，只有主构造函数才能使用参数上的 `var` 和 `final` 语法糖，
隐式声明一个实例字段并用该参数初始化它。
这两个特性——在类头部声明构造函数，
以及能引出字段的构造函数参数——被捆绑在一起。
没有前者，你就用不了后者。

In general, we try hard with the language to not put the user in a position
where they want only one of two behaviors but the language ties them together
and makes them take both. For example,
when we added [class modifiers](https://dart.dev/language/class-modifiers), we
deliberately added both `final` and `sealed`.
They are quite similar, but `final` lets you prevent subclassing *without*
also opting in to exhaustiveness checking.

总的来说，我们在语言设计上努力避免让用户陷入这种处境：
只想要两种行为中的一种，语言却把它们绑在一起，
迫使你两个都要。例如，
添加[类修饰符（class modifiers）](https://dart.dev/language/class-modifiers)时，
我们有意同时加入了 `final` 和 `sealed`。
它们很相似，但 `final` 让你可以阻止子类化，
而*不必*同时启用穷尽性检查。

Deciding what to bundle is a balancing act.
I believe a big part of what gives each programming language its character and
fitness for certain domains is how it chooses to map semantics onto syntax.
Part of that is where it hangs multiple behaviors off a single piece of text.
For example, in most object-oriented languages,
making a class a subclass of another also makes it a subtype in the static
type system. That's not strictly necessary,
as private inheritance in C++ shows.
But for most object-oriented languages,
that coupling seems to make sense.

决定捆绑什么是一种平衡的艺术。
我相信，每门编程语言的个性及其对特定领域的适配性，
很大程度上来自它如何选择把语义映射到语法。
其中一部分就是把多种行为挂在同一段文本上。
例如，在大多数面向对象语言中，
让一个类成为另一个类的子类，
也会让它在静态类型系统中成为后者的子类型。
这并非严格必需，C++ 的私有继承就是证明。
但对大多数面向对象语言来说，这种耦合似乎是合理的。

It might seem ideal to have a strict one-to-one mapping of behavior to text,
but bundling behavior can make it easier to express common patterns.
Think about how much easier it is to walk into a burger joint and say "I'll
have a #2," instead of, "a double cheeseburger with mustard but no ketchup,
medium fries, and a medium fountain drink."

行为与文本严格一一对应看似理想，
但把行为捆绑起来能让常见模式更容易表达。
想想走进汉堡店说“来份 2 号套餐”，
比说“一个双层芝士汉堡，加芥末不加番茄酱，
中份薯条，再来一中杯汽水”要容易多少。

When it comes to combining declaring parameters with primary constructors,
this felt like a relatively safe bundling.
Declaring parameters are themselves syntactic sugar and don't let you express
anything you can't already express in a normal class declaration.
If you don't want a constructor to be a primary constructor for whatever
reason, you have to give up the syntactic convenience of declaring parameters.
But brevity is all you give up. You can still define your class with exactly
the API and semantics you want.

把声明参数（declaring parameters）与主构造函数结合起来，
感觉是一次相对安全的捆绑。
声明参数本身就是语法糖，
不能让你表达任何普通类声明表达不了的东西。
如果出于任何原因你不想让某个构造函数成为主构造函数，
你就得放弃声明参数带来的语法便利。
但你放弃的只是简洁。你仍然可以按你想要的 API 和语义
来定义你的类。

It would be nice to be able to use declaring parameters inside in-body
constructors, and we worked on
[a proposal](https://github.com/dart-lang/language/blob/main/working/declaring-constructors/feature-specification.md)
to allow it. Ultimately, we felt there were too many negative consequences.
If some random constructor anywhere in the class body can implicitly declare
instance fields in its parameter list,
then it gets harder to find all the state a class stores and reason about it.
This is less of a problem with primary constructors because the primary
constructor is always right there at the top of the class.

如果能在类体内构造函数中使用声明参数就好了，
我们也曾为此做过[一份提案](https://github.com/dart-lang/language/blob/main/working/declaring-constructors/feature-specification.md)。
最终，我们觉得负面后果太多。
如果类体中随便哪个构造函数都能在其参数列表里
隐式声明实例字段，
那么就很难找全一个类存储的所有状态并对它进行推理。
主构造函数的问题就小得多，
因为它总是就在类的最顶部。

## Shorter in-body constructors

## 更简短的类体内构造函数

Another source of verbosity with Dart's existing constructor declaration
syntax is having to repeat the class name.
It doesn't look too bad with short names in examples like `Point`,
but when you have a class name like,
say,
[`AnimatedFractionallySizedBox`](https://api.flutter.dev/flutter/widgets/AnimatedFractionallySizedBox-class.html),
then repeating that entire 28-character identifier takes up a lot of space
that could otherwise be spent on the constructor's parameter list.

Dart 现有构造函数声明语法的另一个冗长来源，
是必须重复类名。
在 `Point` 这类名字很短的例子里还不算难看，
但当类名是（比如说）
[`AnimatedFractionallySizedBox`](https://api.flutter.dev/flutter/widgets/AnimatedFractionallySizedBox-class.html)
时，重复这个 28 个字符的标识符就会占用大量空间，
而这些空间本可以用来写构造函数的参数列表。

That problem we *can* fix. Dart's constructor syntax was inherited from Java
and C#, which in turn inherited it from C++.
Bjarne Stroustrup chose to use the class name to minimize the number of new
keywords and mirror what a constructor call looks like.
It's a cute syntax, but even he admits "this may have been overly clever."

这个问题我们*能*修。Dart 的构造函数语法继承自 Java 和 C#，
而它们又继承自 C++。
Bjarne Stroustrup 当年选择使用类名，
是为了尽量减少新关键字的数量，
并让声明与构造函数调用的样子相呼应。
这是个巧妙的语法，但连他自己也承认
“这可能有点聪明过头了”。

Having one part of a language's syntax mirror another part can be a useful
tool to help users understand what the code means.
When two pieces of code look the same,
it sends a signal that they probably relate to each other in some way.
And if declarations look like call sites,
then once you've read the declaration,
you know what to write to call it.

让语言语法的一部分与另一部分相呼应，
可以是帮助用户理解代码含义的有用工具。
当两段代码长得一样时，
就传递出一个信号：它们很可能以某种方式相关。
如果声明看起来像调用处，
那么读过声明之后，你就知道该怎么调用它。

At least, that's the idea. But Dart already fails to follow through on that
principle. It kind of works for function and method declarations if you ignore
the type annotations. Getters are declared using a `get` keyword without being
invoked using one. Operators are declared using a special `operator` keyword
and have the right-hand parameter in parentheses even though you don't need
parentheses to call the operator. Even in functions,
Dart uses `{...}` to declare named parameters,
which looks nothing like how you pass them at the call site.

至少，理念如此。但 Dart 早已没有把这一原则贯彻到底。
如果忽略类型注解，函数和方法声明勉强算是符合。
getter 用 `get` 关键字声明，调用时却不用它。
运算符用特殊的 `operator` 关键字声明，
右侧参数放在括号里，尽管调用运算符并不需要括号。
甚至在函数中，Dart 用 `{...}` 声明命名参数，
这与调用处传参的样子毫无相似之处。

Most other object-oriented languages don't use the class name to define a
constructor. Swift, Ruby, and Objective-C use `init()`.
Python sprinkles on some underscores and does `__init__()`.
JavaScript, TypeScript, and Kotlin use `constructor`.
PHP uses `__construct`.

大多数其他面向对象语言并不用类名来定义构造函数。
Swift、Ruby 和 Objective-C 用 `init()`。
Python 撒上几个下划线，用 `__init__()`。
JavaScript、TypeScript 和 Kotlin 用 `constructor`。
PHP 用 `__construct`。

This led us to conclude that repeating the class name for a constructor wasn't
really buying us much in terms of familiarity or consistency.
And there is a cost users must pay.
Names are often verbose, and every human,
template processor, code generator,
AI agent producing code, or future metaprogramming feature that wants to
inject a constructor into the class needs to know to use the class name.
It's almost like each class has its own special little contextual keyword.

这让我们得出结论：为构造函数重复类名，
在熟悉感或一致性方面其实没给我们带来多少好处。
而用户却必须付出代价。
名字往往很长，而每一个想往类里注入构造函数的人、
模板处理器、代码生成器、产出代码的 AI 智能体，
或未来的元编程特性，都得知道要使用类名。
这几乎就像每个类都有自己专属的小型上下文关键字。

That problem is particularly acute in another feature we're working on right
now:
[static extension members](https://github.com/dart-lang/language/blob/main/working/0723-static-extensions/feature-specification.md).
Extensions in Dart allow you to attach instance members to existing types,
but they don't currently let you add static members or constructors.
We'd like to support those too, but it raises a tricky edge case.
Extensions can be defined not just on classes,
but any static type, including typedefs.
Consider:

在我们正在开发的另一个特性中，这个问题尤其突出：
[静态扩展成员（static extension members）](https://github.com/dart-lang/language/blob/main/working/0723-static-extensions/feature-specification.md)。
Dart 中的扩展允许你为现有类型附加实例成员，
但目前不允许添加静态成员或构造函数。
我们也想支持它们，但这引出了一个棘手的边缘情况。
扩展不仅可以定义在类上，
还可以定义在任何静态类型上，包括类型别名（typedef）。
请看：

```dart
class SomeClass {}

typedef OtherName = SomeClass;

extension on OtherName {
  // ...
}
```

If you want to add a constructor in that extension,
what name do you use: `OtherName` or `SomeClass`?
Keep in mind that from the type system's perspective,
those are the exact same type. There is no class named `OtherName` anywhere in
the program. The typedef isn't creating a new named type,
it's just defining an ephemeral alias that can be used to refer to some other
type.

如果你想在这个扩展里添加构造函数，该用哪个名字：
`OtherName` 还是 `SomeClass`？
请记住，从类型系统的角度看，它们是同一个类型。
程序中根本不存在名为 `OtherName` 的类。
typedef 并没有创建新的具名类型，
它只是定义了一个临时别名，用来指代另一个类型。

We could require you to use `OtherName` because that's the name that you wrote
at the top of the extension declaration.
But that violates the principle that a type can be replaced with a typedef
that refers to the same type without breaking anything.
Usually, swapping out a reference to some type with a typedef is a transparent
change. Here, and only here, the typedef name would become significant.

我们可以要求你使用 `OtherName`，
因为那是你写在扩展声明顶部的名字。
但这违背了一条原则：把一个类型替换为指向同一类型的 typedef，
不应破坏任何东西。
通常，把对某个类型的引用换成 typedef 是透明的改动。
而在这里——也只在这里——typedef 的名字会变得举足轻重。

Or we could go the other way and say you have to use the name of the
underlying class that the typedef resolves to.
But that breaks the encapsulation of the typedef.
The typedef could be in another library and refer to a private class whose
name you can't even access in your library!

或者我们可以反过来，要求你使用 typedef
所解析到的底层类的名字。
但这破坏了 typedef 的封装。
typedef 可能位于另一个库中，指向一个私有类，
你在自己的库里甚至无法访问它的名字！

All the complexity here is a problem we created ourselves by using the class
name as a magic identifier to mean "constructor".
If we just pick a universal keyword,
the problem goes away.

这里所有的复杂性，都是我们自己造成的问题：
我们把类名当作表示“构造函数”的魔法标识符。
只要选一个通用关键字，问题就消失了。

So that's what we did. In Dart 3.13,
you can use `new` instead of the class name to declare a non-factory
constructor, and `factory` to declare a factory constructor.
If you want a named constructor, put the name after the `new` or `factory`
keyword.

于是我们就这么做了。在 Dart 3.13 中，
你可以用 `new` 代替类名来声明非工厂构造函数，
用 `factory` 来声明工厂构造函数。
如果想要具名构造函数，把名字放在 `new` 或 `factory`
关键字后面即可。

```dart
// Before Dart 3.13:
class LongClassName {
  LongClassName();                          // Unnamed constructor.
  LongClassName.create();                   // Named constructor.
}

class AnotherLongClass {
  factory AnotherLongClass() { ... }        // Factory constructor.
  factory AnotherLongClass.create() { ... } // Named factory constructor.
}

// New Dart 3.13 syntax:
class LongClassName {
  new();                                    // Unnamed constructor.
  new create();                             // Named constructor.
}

class AnotherLongClass {
  factory () { ... }                        // Factory constructor.
  factory create() { ... }                  // Named factory constructor.
}
```

(The syntax for redirecting constructors is similar.)

（重定向构造函数（redirecting constructors）的语法与此类似。）

This is in the category of syntactic sugar that we think is strictly better.
Unless your class name is shorter than three letters,
the new syntax is always shorter. It's more regular.
Aside from being unfamiliar right now (a feeling that will pass),
we think it's just better all around.

这属于我们认为严格更优的那类语法糖。
除非你的类名短于三个字母，新语法总是更短。
它也更规整。除了眼下还不熟悉（这种感觉会过去的），
我们认为它各方面都更好。

However, using `new` to define a constructor does lead to one weird
combination. If you also want that constructor to be constant,
you need a `const` modifier:

不过，用 `new` 定义构造函数确实会带来一个奇怪的组合。
如果你还想让这个构造函数是常量的，
就需要加 `const` 修饰符：

```dart
class SomeClass {
  const new() { ... }
}
```

I admit that `const new` looks oxymoronic.
This is especially true for Dart users who have been around long enough to
remember when every constructor *invocation* started with either `new` or
`const`. In that world, the two were directly opposed.
But you no longer write `new` to invoke constructors,
so the way I think of it now, the `new` keyword mostly just means "*declare* a
constructor" and `const` is always a modifier that means "make the thing
constant".

我承认 `const new` 看起来自相矛盾。
对那些资历够老、还记得每次构造函数*调用*
都以 `new` 或 `const` 开头的 Dart 用户来说尤其如此。
在那个世界里，两者是直接对立的。
但现在你调用构造函数已经不再写 `new` 了，
所以我现在的理解是：`new` 关键字基本只表示“*声明*一个构造函数”，
而 `const` 始终是一个修饰符，表示“让这个东西成为常量”。

## Recap

## 回顾

Thank you for revisiting this long design process with me.
We spent so long mulling over every detail of the semantics and syntax of
constructors leading up to Dart 3.13 that I could write another five thousand
words talking about it. We considered putting the primary constructor
parameter list after the `extends`,
`implements`, and `with` clauses in the class header.
We debated every corner of a class body to decide where primary constructor
parameters should be in scope. Should we allow a superclass call in the class
header? What does that mean for the `with` clause?
What happens if you have a factory constructor named `factory`?

感谢你陪我回顾这段漫长的设计过程。
在 Dart 3.13 发布之前，我们花了太长时间
反复斟酌构造函数语义和语法的每个细节，
我还能再写五千字来谈它。
我们曾考虑把主构造函数的参数列表
放在类头部中 `extends`、`implements` 和 `with` 子句之后。
我们辩论过类体的每个角落，
以确定主构造函数参数应在哪些作用域内可见。
该不该允许在类头部写超类调用？这对 `with` 子句意味着什么？
如果你有一个名叫 `factory` 的工厂构造函数，会发生什么？

Constructors are fundamental to object-oriented programming and Dart already
spends a *lot* of language complexity on them.
Weaving primary constructors into Dart required very carefully mending dozens
of wrinkles in the fabric of the language.
I hope the result feels seamless, but I'm sure it's not perfect.

构造函数是面向对象编程的基础，
Dart 已经在它们身上花费了*大量*的语言复杂性。
把主构造函数织入 Dart，
需要极其小心地抚平语言织物上的几十处褶皱。
我希望最终的结果浑然一体，但我确信它并不完美。

If you run into areas of the new features that feel weird or arbitrary,
I hope this long essay helps them make more sense.
If not, let us know. The language is always evolving and we're always trying
to make it better. In the meantime,
we hope you find that your code in Dart 3.13 feels cleaner,
simpler, and more enjoyable to read and write.

如果你在新特性中遇到感觉怪异或武断的地方，
希望这篇长文能让它们更说得通。
如果不能，请告诉我们。语言始终在演化，
我们也一直在努力让它更好。与此同时，
希望你会发现 Dart 3.13 中的代码更干净、更简单，
读起来和写起来都更愉快。
