---
# title: "Making Dart a Better Language for UI"
title: "让 Dart 成为更适合 UI 的语言"
# description: "On the Dart team, we are busy implementing a handful of language changes that I’m really excited about. They all relate to collection…"
description: "在 Dart 团队，我们正忙于实现几项让我非常兴奋的语言改动。它们都与集合字面量有关……"
ai-translated: true
publishDate: 2019-03-19
author: munificent
image: images/14PIeARfthvxtn0cvBB5MPw.webp
category: other
layout: blog
---


<DashImage src="images/14PIeARfthvxtn0cvBB5MPw.webp" alt="Close-up of Dart UI code showing a Widget build method." />


On the [Dart](https://www.dartlang.org/) team, we are busy implementing a handful of language changes that I’m really excited about. They all relate to collection literals, the built-in syntax for creating lists, maps, and sets:

在 [Dart](https://www.dartlang.org/) 团队，我们正忙于实现几项让我特别兴奋的语言改动。
它们都与集合字面量（collection literals）有关——
也就是创建列表、映射和集合的内置语法：

```dart
var someList = [1, 2, 3, 4];
var someMap = {key: 1, another: 2};
var someSet = {1, 2, 3, 4};
```

If you aren’t writing Dart code today, this may not be super relevant to you and your Life Goals, but I hope you’ll keep reading anyway. I think the features are interesting in their own right, and the execution model that underlies them might stretch your brain in useful and/or engaging ways. I always find it fun to learn about new language stuff, even in languages I don’t currently use.

如果你今天不写 Dart 代码，这些内容对你和你的人生目标可能没那么相关，
但我还是希望你能读下去。我觉得这些特性本身就很有意思，
而支撑它们的执行模型或许能以有益且/或引人入胜的方式拓展你的思维。
我一直觉得学习新的语言知识很有趣，哪怕是我目前不用的语言。

## How Flutter Users Build Their UI

## Flutter 用户如何构建 UI

If you heard anything about Dart in the past year, it was probably in the context of [Flutter](https://flutter.dev/). If that name doesn’t ring a bell, Flutter is a UI framework for building multi-platform mobile apps. I can’t do it justice here, but click the link and it will answer every question in your heart. (Well, at least every question regarding Flutter. It won’t tell you why that high school crush never called you back.)

过去一年里如果你听说过 Dart，多半是在 [Flutter](https://flutter.dev/) 的语境下。
如果这个名字听起来陌生，Flutter 是一个用于构建多平台移动应用的 UI 框架。
我在这里没法把它讲透，但点开链接，它就能回答你心中的每一个问题。
（好吧，至少是关于 Flutter 的每个问题。
它没法告诉你为什么高中时暗恋的那个人从没给你回电话。）

A key choice any UI framework makes is how the basic visual UI elements — buttons, colors, text, layout, etc. — are defined. Do you author these in some sort of separate “template” or “markup” format or right in the executable code where the UI’s behavior is defined? Every fifteen years or so, the industry flips on which answer is the right one.

[Angular](https://angular.io/) and most web frameworks follow in the footsteps of HTML and use templates. [React](https://reactjs.org/) puts the UI inside your JavaScript, but also adds an embedded DSL called [JSX](https://reactjs.org/docs/introducing-jsx.html) to make it look like HTML. Trying to have its cake and eat it too, I guess, though not everyone would describe HTML as particularly dessert-like.

[Angular](https://angular.io/) 和大多数 Web 框架追随 HTML 的脚步，使用模板。
[React](https://reactjs.org/) 把 UI 放进 JavaScript 里，
但又加了一门叫 [JSX](https://reactjs.org/docs/introducing-jsx.html) 的嵌入式 DSL，
让它看起来像 HTML。我猜这是想鱼与熊掌兼得，
不过不是每个人都会觉得 HTML 特别像甜点。

Flutter puts the UI right into your Dart code, using normal Dart expression syntax. Behold:

Flutter 直接把 UI 放进你的 Dart 代码，用的是普通的 Dart 表达式语法。请看：

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(title: Text('Welcome to Flutter')),
        body: Column(
          children: [
            Text('Hello World'),
            Text('This is Flutter'),
            Text('Written in Dart')
          ]
        )
      )
    );
  }
}
```

Everything after that `return` keyword is one big nested expression that produces a chunk of user interface. Using Dart for this has a handful of material benefits:

`return` 关键字之后的一切都是一个巨大的嵌套表达式，产出一块用户界面。
用 Dart 来做这件事有几个实实在在的好处：

* **There’s only one language to learn: Dart.** Since Dart was designed to be familiar to people coming from other languages, that’s hopefully not too difficult.

  **只需要学一门语言：Dart。** Dart 的设计初衷就是让来自其他语言的人感到熟悉，
  所以希望这不会太难。

* **You can use all of the abstraction features of a general-purpose programming language when building your UI.** Hoist pieces out into reusable functions. Give those functions parameters to vary the generated UI. Store things in local variables. You do you.

  **构建 UI 时，你可以使用通用编程语言的全部抽象能力。**
  把片段提取成可复用的函数。给这些函数加参数来变化生成的 UI。
  把东西存进局部变量。想怎么写就怎么写。

* **You never hit an expressiveness wall and have to port to a different language.** If you’ve ever used a declarative language, you’ve probably run into the situation where you hit the limit of what it can actually express. At that point, you either abandon what you were trying to do, or laboriously rewrite the whole thing in a lower level, usually imperative language. Since you’re already *in* a full-featured language with Dart, you never hit that wall and your UI code smoothly grows in sophistication.

  **你永远不会撞上表达能力的墙，被迫迁移到另一门语言。**
  如果你用过声明式语言，大概遇到过这种情况：
  你触及了它实际能表达的上限。
  这时你要么放弃想做的事，要么费力地把整个东西
  用更底层、通常是命令式的语言重写一遍。
  而用 Dart，你本来就*身处*一门功能完备的语言之中，
  永远不会撞上那堵墙，UI 代码可以平滑地变得越来越复杂。

The main challenge, of course, and the reason why people make declarative languages in the first place, is that defining stuff in an imperative language can be really tedious and difficult to read.

当然，主要的挑战——也是人们当初要发明声明式语言的原因——
在于用命令式语言定义东西可能非常繁琐、难以阅读。

Imagine that instead of this little bit of HTML:

想象一下，如果不是这一小段 HTML：

```html
<p>I am an <strong>exciting</strong> paragraph!</p>
```

You had to write something like:

你不得不写成这样：

```java
doc.beginTag("p");
doc.appendText("I am an ");
doc.beginTag("strong");
doc.appendText("exciting");
doc.endTag("strong");
doc.appendText("paragraph!");
doc.endTag("p");
```

Fortunately, modern languages and APIs aren’t quite *that* low level. Even though statements are imperative, *expressions* are pretty declarative. While the above code is gnarly, this one is about on par with HTML:

幸运的是，现代语言和 API 还没*那么*底层。
虽然语句是命令式的，*表达式*却相当声明式。
上面那段代码很狰狞，而这一段就和 HTML 差不多了：

```java
p("I am an ", strong("exciting"), " paragraph!")
```

The modern reactive paradigm where you “build” your UI by constructing it from scratch as a single expression gets you pretty far. The relevant part of the Flutter example up there is just:

现代的响应式范式让你通过从零构造一个表达式来“构建” UI，
这已经能走得很远。上面 Flutter 示例中相关的部分其实只是：

```dart
MaterialApp(
  title: 'Welcome to Flutter',
  home: Scaffold(
    appBar: AppBar(title: Text('Welcome to Flutter')),
    body: Column(
      children: [
        Text('Hello World'),
        Text('This is Flutter'),
        Text('Written in Dart')
      ]
    )
  )
)
```

It’s got parentheses and square brackets instead of angle brackets, but is otherwise not too far from a “markup” language. It’s surprising how well this works. Dart’s syntax is based on JavaScript, which got it from Java, which got it from C. Along the way, we added the square bracket list literal syntax and named parameters, but those are fairly minor.

它用的是圆括号和方括号而不是尖括号，
但除此之外离“标记”语言并不远。效果之好令人惊讶。
Dart 的语法基于 JavaScript，JavaScript 学自 Java，Java 学自 C。
一路走来，我们加了方括号列表字面量语法和命名参数，但这些都是小改动。

C was designed for implementing command-line operating systems on the PDP-11. The fact that its notation scales not *too* badly to building graphical UIs on mobile devices is either a testament to Ritchie’s design taste, or our collective Stockholm Syndrome around C syntax. Either way, it works… mostly.

C 是为在 PDP-11 上实现命令行操作系统而设计的。
它的记法用在移动设备上构建图形 UI 时居然没有*太*糟糕，
这要么证明了 Ritchie 的设计品味，
要么是我们对 C 语法的集体斯德哥尔摩综合征。
不管怎样，它能用……大体上。

In the example here, there’s no interesting runtime *logic* required to build the UI. Everything fits nicely into a single nested expression. But let’s say, for whatever reason, you don’t want to show the “This is Flutter” part of the text on Tuesdays. (Perhaps you need to make room on screen for the “Taco Tuesday!” banner.)

在这个例子里，构建 UI 不需要什么有意思的运行时*逻辑*。
一切都能妥帖地装进一个嵌套表达式。
但假设出于某种原因，你不想在星期二显示 “This is Flutter” 这段文字。
（也许你得给 “Taco Tuesday!” 横幅腾出屏幕空间。）

There are a few ways to express that, but none of them feel as nice and declarative as the above example. Here’s one:

有几种方式可以表达这个需求，
但没有一种像上面的例子那样优雅、声明式。这是其中一种：

```dart
Widget build(BuildContext context) {
  var texts = [Text('Hello World')];
  if (!isTuesday) {
    texts.add(Text('This is Flutter'));
  }
  texts.add(Text('Written in Dart'));

  return MaterialApp(
    title: 'Welcome to Flutter',
    home: Scaffold(
      appBar: AppBar(title: Text('Welcome to Flutter')),
      body: Column(children: texts)
    )
  );
}
```

We’re a lot closer to the nasty low-level imperative code that drives people to using templates. When we looked at real Flutter code, we were sad to see a lot that looked like this. So, about a year ago, the Flutter team asked us on Dart to come up with language changes to make UI code written in Dart easier to write, read, and maintain.

这就更接近那种把人逼向模板的糟糕底层命令式代码了。
我们查看真实的 Flutter 代码时，难过地发现很多代码长这样。
于是大约一年前，Flutter 团队请我们 Dart 团队想出一些语言改动，
让用 Dart 写的 UI 代码更容易编写、阅读和维护。

## “UI as Code”

## “UI 即代码”

We called this initiative “[UI as code](https://github.com/munificent/ui-as-code)”, since it’s about building your UI using code. But the ultimate goal is language features that are generally applicable to as many Dart programs, Flutter or not, as possible. (If you want a lot more background, here’s [a long motivation doc](https://github.com/munificent/ui-as-code/blob/master/Motivation.md) I wrote.)

我们把这项计划称为“[UI 即代码](https://github.com/munificent/ui-as-code)”，
因为它讲的是用代码构建 UI。
但最终目标是做出尽可能通用的语言特性，
适用于尽可能多的 Dart 程序，无论是不是 Flutter。
（想了解更多背景的话，这是我写的[一份长篇动机文档](https://github.com/munificent/ui-as-code/blob/master/Motivation.md)。）

After exploring [a bunch of options](https://github.com/munificent/ui-as-code/blob/master/Choices.md), we decided to focus on a few targeted improvements around collection literals. This may not seem as sexy as jamming something like JSX into Dart (not that I’m entirely ruling that out), but it has the advantage of being much easier for users to incrementally take advantage of in their code.

在探索了[一大堆选项](https://github.com/munificent/ui-as-code/blob/master/Choices.md)之后，
我们决定聚焦于围绕集合字面量的几项有针对性的改进。
这听起来可能不如把 JSX 之类的东西塞进 Dart 那么性感
（我倒也没完全排除那个可能），
但它的好处是用户更容易在代码中渐进地利用起来。

Just making list literals groovier might seem to have, uh, limited impact. But, if you look at Flutter UI code like the above, it’s basically a big tree of constructor calls and list literals. List literals are a large fraction of the territory. (Heck, [entire languages](https://en.wikipedia.org/wiki/Lisp_(programming_language)) have been designed around them.) If you dig into examples where it feels like you should be able to write something declaratively but instead have to do a bunch of gross imperative mutation, it’s very often around lists.

只是让列表字面量更带感，影响似乎，呃，有限。
但看看上面那样的 Flutter UI 代码，
它基本上就是一棵由构造器调用和列表字面量组成的大树。
列表字面量占了很大的地盘。
（见鬼，[有些语言](https://en.wikipedia.org/wiki/Lisp_(programming_language))整个就是围绕它们设计的。）
如果你去翻那些“感觉应该能声明式地写出来、
结果却不得不做一堆恶心的命令式修改”的例子，
十有八九都和列表有关。

If we can make collections better, we can make a *lot* of Dart code better. To that end, we’re adding three new features:

如果能让集合更好用，我们就能让*大量* Dart 代码更好用。
为此，我们要加入三个新特性：

## Spreads

## 展开（Spreads）

Often, when you build a list of widgets, some of those widgets are already in some *other* list. Here’s a bit of Flutter code:

通常，当你构建一个 widget 列表时，
其中一些 widget 已经在*另一个*列表里了。这是一段 Flutter 代码：

```dart
Widget build(BuildContext context) {
  var conversation = buildTab2Conversation();
  var listItems = [Tab2Header()];
  listItems.addAll(conversation);
  listItems.add(buildFooter());

  return CupertinoPageScaffold(
    child: ListView(children: conversation),
  );
}
```

The `buildTab2Conversation()` method returns a list of widgets that we want to surround with the header and footer. Having to build the resulting list imperatively is a real drag. It forces the code to read "backwards" where you see a bunch of stuff mucking around with the children before you get to the code to see what they are the children *of*.

`buildTab2Conversation()` 方法返回一个 widget 列表，
我们想在它前后加上页眉和页脚。
不得不用命令式方式构建结果列表实在让人难受。
它逼着代码“倒着”读：你先看到一堆东西在摆弄 children，
然后才看到它们到底是*谁的* children。

Dart has this feature called [method cascades](https://news.dartlang.org/2012/02/method-cascades-in-dart-posted-by-gilad.html) that helps somewhat. Those let you stuff a mutating method call in the middle of an expression while yielding the original object. With that, you get:

Dart 有个叫[方法级联](https://news.dartlang.org/2012/02/method-cascades-in-dart-posted-by-gilad.html)的特性，能帮上一点忙。
它让你把修改对象的方法调用塞进表达式中间，同时返回原对象。
用它就能写成：

```dart
Widget build(BuildContext context) {
  return CupertinoPageScaffold(
    child: ListView(children: [
      Tab2Header()
    ]..addAll(buildTab2Conversation())
      ..add(buildFooter())),
  );
}
```

That’s kind of better, but it’s still pretty awkward. That trailing `..add()` to append a single item is particularly egregious. You can probably guess how we fixed this since a number of other languages already have the same solution. (&gt;90% of language design is figuring out which features to borrow from other languages.) We’re adding [a new syntax called *spreads*](https://github.com/dart-lang/language/blob/master/accepted/future-releases/spread-collections/feature-specification.md).

这算是好了一点，但仍然挺别扭。
末尾那个只为追加一个元素的 `..add()` 尤其扎眼。
你大概能猜到我们要怎么修，因为不少其他语言已经有了同样的方案。
（语言设计 90% 以上的工作就是琢磨该从别的语言借哪些特性。）
我们要加入[一种叫*展开*（spreads）的新语法](https://github.com/dart-lang/language/blob/master/accepted/future-releases/spread-collections/feature-specification.md)。

Inside a collection literal, a spread unpacks another collection and inserts its contents directly in place. For example:

在集合字面量内部，展开操作会拆开另一个集合，
把它的内容直接插入原位。例如：

```dart
var a = [2, 3];
var b = [5, 6];
var c = [1, ...a, 4, ...b]; // [1, 2, 3, 4, 5, 6].
```

The `...` before the list element causes its elements to be interpolated into the surrounding list. This is the same syntax JavaScript uses. Python, Ruby, and a few others use a prefix `*` for the same thing, but we felt that didn't stand out visually enough. With this feature, the Flutter example becomes:

列表元素前的 `...` 会把它的元素插值进外围列表。
这和 JavaScript 用的语法相同。
Python、Ruby 等几门语言用前缀 `*` 做同样的事，
但我们觉得它在视觉上不够醒目。有了这个特性，Flutter 示例变成：

```dart
Widget build(BuildContext context) {
  return CupertinoPageScaffold(
    child: ListView(children: [
      Tab2Header(),
      ...buildTab2Conversation(),
      buildFooter()
    ]),
  );
}
```

I believe this is a real improvement. All of the children of the list view are nestled snug in the one list literal. This looks nicer, and also plays nicer with type inference. With all of the elements inside the list, we can use all of them when inferring the list’s type.

我认为这是实打实的改进。
列表视图的所有 children 都舒舒服服地窝在一个列表字面量里。
这看起来更舒服，和类型推断的配合也更好。
所有元素都在列表里，推断列表类型时就能把它们全用上。

I’m showing a Flutter example here, but I spent a lot of time combing through a huge corpus of Dart code to see where this syntax would be useful and it comes into play all over the place. In particular, code that builds lists of command line arguments for invoking other programs really benefits from spreads.

我这里展示的是 Flutter 示例，但我花了大量时间梳理海量 Dart 代码，
看这个语法在哪些地方有用，结果发现它到处都能派上用场。
特别是那些为调用其他程序而构建命令行参数列表的代码，
真的能从展开操作中获益。

## Elements

## 元素（Elements）

Before I get into the last two features, I want to dig into what a spread actually *is*. It will seem like I’m belaboring the point, but I promise being clear on this will be helpful later. Here’s a leading question: *is a spread an expression?*

在讲最后两个特性之前，我想深挖一下展开到底*是*什么。
看起来我像是在啰嗦，但我保证把这一点弄清楚后面会很有帮助。
先问一个引导性的问题：*展开是表达式吗？*

It seems like one, because it appears in a list literal in a place where an expression is expected:

看起来像是，因为它出现在列表字面量中本该放表达式的位置：

```dart
var stuff = [1, ...things, 4];
```

Like an expression, you evaluate it and it produces some data. Maybe it’s an expression that evaluates to an [Iterable](https://api.dartlang.org/stable/2.2.0/dart-core/Iterable-class.html) object? But, wait, that doesn’t make sense. That’s what the expression *inside* the spread does. If you just want an expression that evaluates to an Iterable, there’s no need to put the `...` before it.

和表达式一样，你对它求值，它产出一些数据。
也许它是一个求值为 [Iterable](https://api.dartlang.org/stable/2.2.0/dart-core/Iterable-class.html) 对象的表达式？
但等等，这说不通。那是展开*内部*的表达式干的事。
如果你只想要一个求值为 Iterable 的表达式，根本不必在前面加 `...`。

A spread doesn’t evaluate to a single Iterable object, it *unpacks* that object and evaluates to the *series* of objects produced by the Iterable. It wouldn’t be useful to then *repack* that back into some new object. But an expression always evaluates to a *single* object.

展开并不求值为单个 Iterable 对象，
它*拆开*那个对象，求值为该 Iterable 产出的*一系列*对象。
再把它们*重新打包*成某个新对象没什么意义。
但表达式总是求值为*单个*对象。

If a spread was an expression, what would it mean to use one in other places where an expression is allowed?

如果展开是表达式，那在其他允许表达式的地方用它意味着什么？

```dart
var wat = ...things;
```

What would this do? It doesn’t make sense to store the entire Iterable as an object in `wat`. If you wanted that, you could just omit the `...` entirely. The answer is that spreads *aren't* expressions. They are a different kind of syntactic category. Dart, like many languages, already has two big syntax groups: statements and expressions.

这会做什么？把整个 Iterable 作为一个对象存进 `wat` 说不通。
如果你想要那样，直接去掉 `...` 就行了。
答案是：展开*不是*表达式。它们是另一种语法范畴。
和许多语言一样，Dart 已经有两大语法类别：语句和表达式。

Statements are executed but don’t produce any result value. Instead, they are expected to have some useful side effect. They can’t be used in any context where a value is needed because it won’t give you one. That’s why, say, this is forbidden:

语句会被执行，但不产出任何结果值。
相反，人们期望它们产生某种有用的副作用。
它们不能用在任何需要值的上下文里，因为它给不了你值。
这就是为什么，比如说，这样写是被禁止的：

```dart
var wat = for (var i = 0; i < 10; i++) print(i);
```

A `for` statement doesn't produce a value, so it doesn't make sense to stuff one in a variable initializer. There *are* [languages that unify expressions and statements](https://en.wikipedia.org/wiki/Expression-oriented_programming_language) and allow code like this. They define each statement to execute in some way and *also* produce a value. But Dart isn't one of those languages.

`for` 语句不产出值，所以把它塞进变量初始化器里说不通。
*确实有*[统一表达式和语句的语言](https://en.wikipedia.org/wiki/Expression-oriented_programming_language)，允许这样的代码。
它们把每条语句定义为以某种方式执行，*同时*产出一个值。
但 Dart 不是这样的语言。

Expressions evaluate to a single result value. You can use them in places where a value is useful. There are also “[expression statements](https://www.eskimo.com/~scs/cclass/notes/sx3a.html)” — an expression followed by a semicolon — which are statements that contain a single expression. Handy since many expressions do also happen to have side effects and are useful even when their result isn’t needed.

表达式求值为单个结果值。你可以把它们用在需要值的地方。
还有“[表达式语句](https://www.eskimo.com/~scs/cclass/notes/sx3a.html)”——
表达式后跟一个分号——也就是只包含一个表达式的语句。
这很方便，因为许多表达式恰好也有副作用，
即使不需要它们的结果也很有用。

A spread is neither of those. A spread can evaluate to zero values (if you spread an empty collection), one value, or many. It’s its own kind of thing. A good name for this category would be “generator”. My model for this comes from [Icon](https://en.wikipedia.org/wiki/Icon_(programming_language)#Generators) where *every* expression can be a generator. But Dart already has [generator functions](https://www.dartlang.org/articles/language/beyond-async#generators) so I didn’t want to overload the term.

展开两者都不是。展开可以求值为零个值（展开空集合时）、
一个值或多个值。它是自成一类的东西。
给这个范畴起个好名字的话，可以叫“生成器”。
我的模型来自 [Icon](https://en.wikipedia.org/wiki/Icon_(programming_language)#Generators)，
在那里*每个*表达式都可以是生成器。
但 Dart 已经有[生成器函数](https://www.dartlang.org/articles/language/beyond-async#generators)了，
我不想再给这个词叠加含义。

A spread can only appear in a place that can gracefully handle receiving zero or more values. Without completely overhauling the language’s execution model and turning it into Icon (which I find strangely appealing, but probably not practical…), there aren’t too many places that fit that constraint. Basically collection literals and maybe positional argument lists. (I wrote [a proposal for the latter](https://github.com/munificent/ui-as-code/blob/master/in-progress/parameter-freedom.md), but it’s quite complex so we aren’t doing it, at least not right now.)

展开只能出现在能从容接收零个或多个值的地方。
除非彻底改造语言的执行模型、把它变成 Icon
（我觉得这莫名地有吸引力，但大概不现实……），
否则满足这个约束的地方并不多。
基本上就是集合字面量，也许还有位置参数列表。
（我为后者写过[一份提案](https://github.com/munificent/ui-as-code/blob/master/in-progress/parameter-freedom.md)，
但它相当复杂，所以我们不做，至少现在不做。）

That leaves inside the body of collection literals. Based on that, I call these “elements”. An element is a piece of code that when evaluated produces zero or more values. Those values are then interpolated in place into the surrounding context where they appear. So, in a list, they become a series of elements in the new list. In a map, they become a series of key/value pairs. You get the idea.

那就只剩下集合字面量的内部了。据此，我把这些东西称为“元素”（element）。
元素是一段代码，求值时产出零个或多个值。
这些值随后被就地插值进它们出现的外围上下文。
所以在列表里，它们成为新列表中的一系列元素；
在映射里，它们成为一系列键/值对。你懂的。

The body of a collection literal can thus contain either expressions or elements. Allowing two categories is a little confusing, but fortunately we can simplify this by saying that a collection only contains elements. Then we define an “expression element” to be an element containing a single expression. The element always produces one result — the value of the expression. Sort of like the element equivalent of an expression statement.

于是集合字面量的主体既可以包含表达式，也可以包含元素。
允许两种类别有点让人困惑，但幸运的是我们可以简化：
规定集合只包含元素。
然后定义“表达式元素”为只包含一个表达式的元素。
这种元素总是产出一个结果——表达式的值。
有点像表达式语句在元素世界的对应物。

Right, so that’s where we are. We’ve changed collections to contain elements instead of expressions and defined two kinds of elements, spreads and expression elements. To evaluate a collection literal, you walk the elements, evaluate each one, and concatenate (or union in the case of a set) all of the resulting objects.

好，我们说到哪儿了。我们把集合改成包含元素而非表达式，
并定义了两种元素：展开和表达式元素。
对集合字面量求值时，你遍历这些元素，逐个求值，
然后把所有结果对象拼接起来（对集合则是取并集）。

With that model in mind, we can walk through the other two new features:

带着这个模型，我们来看另外两个新特性：

## Collection If

## 集合 If

Write any Flutter code and you pretty quickly run into cases where the tree of widgets you want to build changes based on some condition. Say we have:

只要写点 Flutter 代码，你很快就会遇到这种情况：
想构建的 widget 树要根据某个条件变化。假设我们有：

```dart
Widget build(BuildContext context) {
  return Row(
    children: [
      IconButton(icon: Icon(Icons.menu)),
      Expanded(child: title),
      IconButton(icon: Icon(Icons.search)),
    ],
  );
}
```

Later, we decide that we want to use a different search button on Android. You can already do that using a conditional expression:

后来我们决定在 Android 上用不同的搜索按钮。
用条件表达式已经能做到：

```dart
Widget build(BuildContext context) {
  return Row(
    children: [
      IconButton(icon: Icon(Icons.menu)),
      Expanded(child: title),
      isAndroid
          ? TextButton("Search")
          : IconButton(icon: Icon(Icons.search)),
    ],
  );
}
```

This works OK, though I’ve never found C’s conditional operator very easy to read. Often, though, you don’t want to *swap out* a widget based on a condition, you want to simply *omit* one. Let’s say you don’t want to show a search box on Android at all. Today, Flutter users tend to use one of two patterns. This is one:

这还行，虽然我一直觉得 C 的条件运算符不太好读。
但很多时候，你不是想根据条件*替换*一个 widget，
而是想干脆*省略*一个。假设你根本不想在 Android 上显示搜索框。
如今 Flutter 用户倾向于用两种模式之一。这是第一种：

```dart
Widget build(BuildContext context) {
  var children = [
    IconButton(icon: Icon(Icons.menu)),
    Expanded(child: title)
  ];

  if (!isAndroid) {
    children.add(IconButton(icon: Icon(Icons.search)));
  }

  return Row(children: children);
}
```

It forces you to rearrange the entire function by hoisting the child list out and building it imperatively before you use it. The other pattern looks like:

它逼着你重排整个函数：把 children 列表提出来，
在使用之前用命令式方式构建它。另一种模式长这样：

```dart
Widget build(BuildContext context) {
  return Row(
    children: [
      IconButton(icon: Icon(Icons.menu)),
      Expanded(child: title),
      !isAndroid ? IconButton(icon: Icon(Icons.search)) : null,
    ].where((widget) => widget != null).toList(),
  );
}
```

This uses a conditional expression which sometimes produces a `null` and then filters that `null` out of the resulting list. Props to whoever came up with this, but it's not something any user should have to write to accomplish such a simple task. Simple problems should have simple solutions, and small conceptual changes to your program shouldn't require large textual changes.

这用了一个有时产出 `null` 的条件表达式，
然后把 `null` 从结果列表里过滤掉。
向想出这招的人致敬，但为了这么简单的任务，
任何用户都不该被迫写这种东西。
简单的问题应该有简单的解法，
程序里小的概念改动不该要求大的文本改动。

Here’s the new thing. For the first example where we want a different button on Android, it looks like this:

新东西来了。对于第一个想在 Android 上用不同按钮的例子，写出来是这样：

```dart
Widget build(BuildContext context) {
  return Row(
    children: [
      IconButton(icon: Icon(Icons.menu)),
      Expanded(child: title),
      if (isAndroid)
        TextButton("Search")
      else
        IconButton(icon: Icon(Icons.search)),
    ],
  );
}
```

Instead of `?:`, it uses the familiar `if` and `else` syntax. This is literally just a few tokens different from the existing conditional expression, so it doesn't seem to carry its weight. The more interesting case is when we want to *omit* the button on Android:

它不用 `?:`，而是用大家熟悉的 `if` 和 `else` 语法。
这和现有的条件表达式字面上只差几个 token，
似乎有点不值当。更有意思的情况是我们想在 Android 上*省略*这个按钮：

```dart
Widget build(BuildContext context) {
  return Row(
    children: [
      IconButton(icon: Icon(Icons.menu)),
      Expanded(child: title),
      if (!isAndroid)
        IconButton(icon: Icon(Icons.search)),
    ],
  );
}
```

Note there’s no `else` clause. Both of these examples look pretty similar to languages like Ruby where `if` is an expression. But an expression must always evaluate to a value, even when the condition is false. In Ruby, in that case, it implicitly evaluates to `nil`.

注意这里没有 `else` 子句。
这两个例子看起来很像 Ruby 之类 `if` 是表达式的语言。
但表达式必须总是求值为一个值，即使条件为假。
在 Ruby 里，那种情况下它会隐式地求值为 `nil`。

But that’s *not* what you want here. You don’t want to end up with a `null` element in your list of child widgets. That's why the conditional expression example up there had to use the annoying `where()` to filter it out. Fortunately, that's not a problem here. Because `if` inside a collection isn't an *expression*. It's an *element*.

但那*不是*你在这里想要的。
你不想让 children widget 列表里最后多出一个 `null` 元素。
这就是为什么上面的条件表达式例子不得不用烦人的 `where()` 把它滤掉。
幸运的是，这里没有这个问题。
因为集合内部的 `if` 不是*表达式*，而是*元素*。

Now you see why I was dragging you through all that stuff with spreads. Elements give us the foundation to have an `if`syntax that lets you completely omit an element from a collection. The `if` element produces a single value if the condition is true, or if there is an `else` case. If the condition is false and there is no `else` clause, it simply produces no values at all.

现在你明白我为什么要拉着你把展开的那些东西讲一遍了。
元素给了我们基础，让我们能有一种 `if` 语法，
可以把一个元素从集合中完全省略。
条件为真、或者存在 `else` 分支时，`if` 元素产出一个值。
如果条件为假且没有 `else` 子句，它就干脆一个值也不产出。

I think this behavior is really useful, but it’s also confusing if you look at the code and expect `if` to act like a simple expression.

我觉得这个行为非常有用，但如果你看着代码，
指望 `if` 表现得像个简单表达式，那也会困惑。

## Collection For

## 集合 For

The previous feature takes an existing bit of Dart statement syntax and repurposes it to do something useful in the context of a collection. Are there any other statement forms worth taking?

上一个特性拿了一段现有的 Dart 语句语法，
让它在集合的上下文里发挥新作用。还有别的语句形式值得拿来吗？

Most don’t make sense. Sticking a `return` statement in there wouldn't do anything useful since it would just exit the surrounding function. `while` isn't very useful either. In order to exit a `while` loop, the body typically contains a `break`, `return`, or some kind of side effect like an assignment. But that implies the body contains *statements*, which isn't what we want. The goal is to make collections more *expressive*, not more *imperative*.

大多数说不通。在里面塞个 `return` 语句没什么用，
因为它只会退出外围函数。`while` 也没多大用。
要退出 `while` 循环，循环体通常得包含 `break`、`return`
或赋值之类的副作用。但那意味着循环体包含*语句*，
这不是我们想要的。目标是让集合更有*表达力*，而不是更*命令式*。

I dug through a bunch of collection literals in existing code looking for patterns I thought could be improved by new syntax. The main one, by far, was `if`. But I saw a number of places that I thought could be improved by `for`. Here's a slightly cleaned up example of some code I found:

我翻了一堆现有代码里的集合字面量，
寻找我认为能用新语法改进的模式。
最主要的一个，遥遥领先，是 `if`。
但我也看到不少我认为能用 `for` 改进的地方。
这是我找到的一段代码，稍作整理后的例子：

```dart
var command = [
  engineDartPath,
  frontendServer,
];
for (var root in fileSystemRoots) {
  command.add("--filesystem-root=$root");
}
for (var entryPoint in entryPoints) {
  command.add("$entryPoint.json");
}
command.add(mainPath);
```

All of the `command.add()` stuff feels needlessly imperative. If we allow `for` loops inside a collection literal, this becomes:

那一堆 `command.add()` 感觉是不必要的命令式。
如果允许集合字面量内部使用 `for` 循环，这就变成：

```dart
var command = [
  engineDartPath,
  frontendServer,
  for (var root in fileSystemRoots) "--filesystem-root=$root",
  for (var entryPoint in entryPoints) "lib/$entryPoint",
  mainPath
];
```

## Composing Elements

## 组合元素

Given that we are already adding spreads, the `for` syntax doesn't seem very compelling. Couldn't you accomplish the same thing using spread with some combination of higher-order methods on iterables? Yes, you can. You'd get something like:

既然我们已经加了展开，`for` 语法似乎就没那么有说服力了。
用展开配合 iterable 上高阶方法的某种组合，难道做不到同样的事吗？
能。你会写出类似这样的东西：

```dart
var command = [
  engineDartPath,
  frontendServer,
  ...fileSystemRoots.map((root) => "--filesystem-root=$root"),
  ...entryPoints.map((entryPoint) => "lib/$entryPoint"),
  mainPath
];
```

This does work and is fine for some use cases. Let’s consider a slightly different example. Say we only want to include an entry point if a corresponding JSON file exists. That means we’re not doing a simple 1–1 mapping. Using only spreads, we get something like:

这确实可行，对某些用例也没问题。我们再看一个稍有不同的例子。
假设只有当对应的 JSON 文件存在时，我们才想包含某个入口点。
这意味着我们不是在做简单的一一映射。只用展开的话，会写成这样：

```dart
var command = [
  engineDartPath,
  frontendServer,
  ...fileSystemRoots.map((root) => "--filesystem-root=$root"),
  ...entryPoints
      .where((entryPoint) => fileExists("lib/$entryPoint.json"))
      .map((entryPoint) => "lib/$entryPoint"),
  mainPath
];
```

This works too. But it starts to get harder and harder to translate the simple “if the file exists, do this” logic to a stream-based, higher-order functional style. There’s always some combination of `map()`, `where()` and maybe `transform()` that does the job, but it can feel like translating a haiku into Reverse Polish Notation.

这也能用。但把简单的“如果文件存在，就做这个”的逻辑
翻译成基于流的高阶函数式风格，会变得越来越难。
总存在某种 `map()`、`where()`、也许还有 `transform()` 的组合能搞定，
但那感觉就像把一首俳句翻译成逆波兰表示法。

There is a cleaner solution, and it involves a key question: What is the *body* of these new `if` and `for` elements? In the examples I've shown you so far, it's always an expression. But there's no need to restrict it to just that. Instead, we allow any element to go there. In other words, all three of these new features can be composed freely. The above code can be expressed like:

有一个更干净的解法，它涉及一个关键问题：
这些新 `if` 和 `for` 元素的*主体*是什么？
到目前为止我展示的例子里，它总是表达式。
但没必要限制成这样。我们允许任何元素放在那里。
换句话说，这三个新特性可以自由组合。上面的代码可以表达为：

```dart
var command = [
  engineDartPath,
  frontendServer,
  for (var root in fileSystemRoots) "--filesystem-root=$root",
  for (var entryPoint in entryPoints)
    if (fileExists("lib/$entryPoint.json")) "lib/$entryPoint",
  mainPath
];
```

A simple `if` inside a `for`, just like you'd do if you were writing imperative statements. The semantics for composing elements turn out to be pretty obvious:

`for` 里面套一个简单的 `if`，就像写命令式语句时那样。
组合元素的语义结果相当直观：

* An `if` element produces all of the values produced by its then clause if the condition is true, otherwise it produces all of the elements of the "else" clause. If there is no "else", it produces no elements.

  条件为真时，`if` 元素产出其 then 分支产出的所有值；
  否则产出 “else” 分支的所有元素。如果没有 “else”，就不产出任何元素。

* A `for` element produces the concatenation of all of the values produced by its body element each time the body is executed.

  `for` 元素把每次执行循环体时其主体元素产出的所有值拼接起来。

This enables some patterns that I think are cool. An obvious problem you run into is wanting to include or omit *multiple* values based on a single condition. So, say in our previous example we wanted to skip both the title and the search box on Android. You can do that by wrapping a spread in an `if`:

这带来了一些我觉得很酷的模式。
你会遇到的一个明显问题是：想根据单个条件包含或省略*多个*值。
比如在前面的例子里，我们想在 Android 上同时跳过标题和搜索框。
把展开放进 `if` 里就能做到：

```dart
Widget build(BuildContext context) {
  return Row(
    children: [
      IconButton(icon: Icon(Icons.menu)),
      if (!isAndroid) ...[
        Expanded(child: title),
        IconButton(icon: Icon(Icons.search)),
      ]
    ],
  );
}
```

The spread is necessary here to unpack the inner list. Otherwise, when not on Android, you’d include the entire inner list as a single value. (We considered implicitly flattening in cases like this based on static types, but that gets really dubious when you think about how things like a `List&lt;Object&gt;` should behave.)

这里必须用展开来拆开内层列表。
否则在非 Android 上，你会把整个内层列表当作单个值包含进去。
（我们考虑过在这种情况下基于静态类型隐式扁平化，
但想想 `List&lt;Object&gt;` 之类的东西该怎么表现，这就很可疑了。）

You can think of spreading a list literal as the element equivalent of a curly block for statements — it lets you put multiple elements in a place where only one is expected. (If you’re familiar with the [comma operator](https://en.wikipedia.org/wiki/Comma_operator), that’s essentially the analogous form for expressions. Parallels everywhere.)

你可以把展开一个列表字面量看作语句的花括号块在元素世界的对应物——
它让你把多个元素放进只期望一个元素的位置。
（如果你熟悉[逗号运算符](https://en.wikipedia.org/wiki/Comma_operator)，
那本质上就是表达式世界的类似形式。到处都是对应关系。）

Using `for` and `if` in an empty collection literal gives you a syntax not too far from the special "list comprehension" syntax supported by some other languages like Python:

在空集合字面量里使用 `for` 和 `if`，
得到的语法离 Python 等其他语言支持的专门“列表推导式”语法不远了：

```dart
[for (var i = 1; i <= 5; i++) if (i.isOdd) i * i] // [1, 9, 25].
```

You can even nest `for`:

你甚至可以嵌套 `for`：

```dart
[for (var x in hor) for (var y in vert) Point(x, y)]
```

This builds a list containing the [Cartesian product](https://en.wikipedia.org/wiki/Cartesian_product) of all of the points in the given `hor` and `vert` rectangle.

这会构建一个列表，包含给定 `hor` 和 `vert` 矩形中
所有点的[笛卡尔积](https://en.wikipedia.org/wiki/Cartesian_product)。

Also, these new features compose across collection types. I’ve been using lists as the example because they come up most often, but all of these features work inside maps and sets too. The only difference is that with sets, duplicates get implicitly discarded. And in maps, instead of having primitive expression elements, the basic element is a key/value pair. For example, this:

另外，这些新特性可以跨集合类型组合。
我一直拿列表举例，因为它最常见，
但所有这些特性在映射和集合里同样适用。
唯一的区别是：对集合，重复项会被隐式丢弃；
而在映射里，基本元素不是原始的表达式元素，而是键/值对。例如这段：

```dart
Map<String, WidgetBuilder>.fromIterable(
  allGalleryDemos.where((demo) => demo.exists),
  key: (demo) => '${demo.routeName}',
  value: (demo) => demo.buildRoute,
);
```

Can be rewritten as:

可以改写为：

```dart
{
  for (var demo in allGalleryDemos)
    if (demo.exists) '${demo.routeName}': demo.buildRoute,
};
```

One real concern we have with all of these features is that we’re essentially giving you new ways to express things you can already express today. This has a cost because it means users need to spend brain juice [deciding *which* feature to use](https://en.wikipedia.org/wiki/Hick%27s_law), and when reading others’ code, they may spend time questioning why one option was chosen over the other. There are simply more features to learn and the language is bigger.

对这些特性，我们有一个切实的担忧：
我们本质上是在给你提供新的方式，去表达你今天已经能表达的东西。
这是有代价的，因为用户得花脑力[决定*用哪个*特性](https://en.wikipedia.org/wiki/Hick%27s_law)，
读别人代码时，可能还要花时间琢磨为什么选了这个而不是那个。
要学的特性就是变多了，语言也变大了。

We spent a lot of time [agonizing over this](https://github.com/munificent/ui-as-code/blob/master/Choices.md). Sometimes, simply doing nothing is the best design. Simplicity has a lot of value, and it’s rare that you get the chance to make a language simpler over time. However, after looking at a lot of code and working with a delightful UX researcher on a study, we’re fairly confident that these features are lightweight and useful enough to carry their weight.

我们花了大量时间[为此纠结](https://github.com/munificent/ui-as-code/blob/master/Choices.md)。
有时候，什么都不做就是最好的设计。
简单性很有价值，而且能让一门语言随时间变得更简单的机会很少见。
不过，在看了大量代码、并与一位出色的 UX 研究员合作开展研究之后，
我们相当确信这些特性足够轻量、足够有用，值得加入。

As with any language change, you never really know how it will work out until it gets into the hands of users. These features should fall into your grasp in the upcoming Dart 2.3 release, and I’m really excited to see what you make of them.

和任何语言改动一样，在交到用户手上之前，
你永远不知道它实际效果如何。
这些特性应该会在即将到来的 Dart 2.3 版本中与你见面，
我特别期待看到你会用它们做出什么。
