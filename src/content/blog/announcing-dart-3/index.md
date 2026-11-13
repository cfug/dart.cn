---
# title: "Announcing Dart 3"
title: "宣布 Dart 3"
# description: "100% sound null safety. Records, patterns, and class modifiers. 
# And a peek into the future."
# publishDate: 2023-05-10
description: "100% 健全空安全。records、patterns 与类修饰符。并展望未来。"
ai-translated: true
author: mit-mit
image: images/12XwxNKHrKb3SGaWEyqg2nA.webp
category: releases
layout: blog
---


### 100% sound null safety. Records, patterns, and class modifiers. And a peek into the future.

### 100% 健全空安全。records、patterns 与类修饰符。并展望未来。

Hello from Google I/O 2023. Today, live from Mountain View, we’re announcing Dart 3 — the largest Dart release to date! Dart 3 contains three major advancements. First, we’ve completed the journey to 100% sound null safety. Second, we’ve added major new language features for records, patterns, and class modifiers. Third, we’re giving a preview of the future, where we broaden our platform support with native code for the web via Wasm compilation. Let’s get into the details.

我们在 Google I/O 2023 现场向你问好。今天，我们在山景城直播宣布
Dart 3——迄今为止最大的 Dart 版本！Dart 3 包含三项重大进展。
第一，我们完成了通往 100% 健全空安全（sound null safety）的旅程。
第二，我们加入了 records、patterns 和类修饰符（class modifiers）
等重要新语言特性。第三，我们预览了未来：通过 Wasm 编译为 Web
提供原生代码，从而拓宽平台支持。下面来看细节。

<DashImage src="images/12XwxNKHrKb3SGaWEyqg2nA.webp" alt="Dart 3 release banner with the Dart logo and a bullseye icon." />


## 100% sound null safety

## 100% 健全空安全

Over the last four years, we’ve evolved Dart into a fast, portable, and modern language. Now with Dart 3, it is a 100% sound null safe language! As we’ve [discussed before](/blog/the-road-to-dart-3-a-fully-sound-null-safe-language), we don’t believe any other programming language has ever added sound null safety to an existing language. So, it’s been quite a journey.

过去四年里，我们把 Dart 演进成一门快速、可移植的现代语言。
如今有了 Dart 3，它成为一门 100% 健全空安全的语言！
正如我们[之前讨论过的](/blog/the-road-to-dart-3-a-fully-sound-null-safe-language)，
我们认为此前从未有任何编程语言在既有语言上加入过健全空安全。
所以，这是一段相当漫长的旅程。

<DashImage src="images/1KPbxBAjFYPCSk2OqwjKs7A.webp" alt="Dart 3 null safety timeline from the July 2020 technical preview to the May 2023 stable release." />


With 100% null safety in Dart, we have a *sound* type system. You can trust that if a type says a value isn’t `null`, then it never can be `null`. This avoids certain classes of coding errors, like null pointer exceptions. It also allows our compilers and runtimes to optimize code in ways it couldn’t without null safety. This design choice involved a tradeoff. Though migrations became a bit harder, we believe we made the right choice for Dart.

Dart 实现 100% 空安全后，我们拥有了一个*健全*的类型系统。
你可以相信：如果一个类型说某个值不是 `null`，那它就永远不可能是 `null`。
这避免了某些类别的编码错误，比如空指针异常。
它也让我们的编译器和运行时能以没有空安全时做不到的方式优化代码。
这个设计选择有所取舍。虽然迁移变得难了一些，
但我们相信这是为 Dart 做出的正确选择。

### Migrating to Dart 3

### 迁移到 Dart 3

A critical part in achieving sound null safety has been the unwavering support from the Dart community: 99% of the top 1000 packages on pub.dev support null safety!

实现健全空安全的关键一环，是 Dart 社区坚定不移的支持：
pub.dev 上排名前 1000 的 package 中，99% 都已支持空安全！

Given this, we expect the vast majority of packages and apps that have been migrated to null safety to work with Dart 3. In just a few cases, a smaller amount of related cleanup in Dart 3 might impact some code. Some legacy core library APIs have been removed ([#34233](https://github.com/dart-lang/sdk/issues/34233), [#49529](https://github.com/dart-lang/sdk/issues/49529)) and some tools have been adjusted ([#50707](https://github.com/dart-lang/sdk/issues/50707)). Should you experience any issues migrating to using the Dart 3 SDK, please consult the [Dart 3 migration guide](https://dart.dev/resources/dart-3-migration). Other than that, we hope you’ll enjoy the new rationalized core libraries and tools.

有鉴于此，我们预计绝大多数已迁移到空安全的 package 和应用
都能在 Dart 3 上运行。只有少数情况下，Dart 3 中少量相关清理
可能影响一些代码。部分遗留核心库 API 已被移除
（[#34233](https://github.com/dart-lang/sdk/issues/34233)、
[#49529](https://github.com/dart-lang/sdk/issues/49529)），
一些工具也做了调整
（[#50707](https://github.com/dart-lang/sdk/issues/50707)）。
如果你在迁移到 Dart 3 SDK 时遇到任何问题，
请查阅 [Dart 3 迁移指南](https://dart.dev/resources/dart-3-migration)。
除此之外，希望你会喜欢经过梳理的核心库和工具。

## Major language features — Record, patterns, and class modifiers

## 重要语言特性——Record、patterns 与类修饰符

Dart 3 isn’t just about changing the existing language. It’s also about adding significant new features and capabilities! These include records, patterns, and class modifiers.

Dart 3 不只是改变既有语言，还加入了重要的新特性和能力！
它们包括 records、patterns 和类修饰符。

### Building up structured data with records

### 用 records 构建结构化数据

Traditionally, a Dart function could only return a single value. As a result, functions that needed to return multiple values had to either package these into other data types such as maps or lists or to define new classes that could hold the values. Using untyped data structures weakened type safety. Having to define new classes just to carry data adds friction during the coding process. You made this pretty clear to us: the language request for multiple return values is our [fourth highest rated](https://github.com/dart-lang/language/issues?q=is%3Aissue+sort%3Areactions-%2B1-desc+) issue.

传统上，Dart 函数只能返回单个值。因此，需要返回多个值的函数
要么把这些值打包进 map 或 list 等其他数据类型，
要么定义能容纳这些值的新类。使用无类型的数据结构会削弱类型安全，
而仅仅为了携带数据就要定义新类，会给编码过程增添阻力。
你们把这一点表达得很清楚：多返回值这个语言需求，
是我们[获赞第四高](https://github.com/dart-lang/language/issues?q=is%3Aissue+sort%3Areactions-%2B1-desc+)的
issue。

With records, you can build up structured data with a nice and crisp syntax. Consider this function. It reads out the name and age of a JSON blob and returns them both in a record:

有了 records，你可以用简洁明快的语法构建结构化数据。
看看这个函数：它从一段 JSON 中读出姓名和年龄，
并把两者放在一个 record 里返回：

```dart
(String, int) userInfo(Map<String, dynamic> json) {
  return (json['name'] as String, json['height'] as int);
}
```


This should look familiar to all Dart developers. A record looks like a list literal such as `[‘Michael’, ‘Product Manager’]` but uses parentheses instead of brackets. In Dart, records are a general feature. They can be used for more than function return values. You also store them in variables, put them into a list, use them as keys in a map, or create records containing other records. You can add both unnamed fields, like we did in the prior example, and named fields like `(42, description: ‘Meaning of life’)`.

所有 Dart 开发者应该都会觉得眼熟。record 看起来像
`[‘Michael’, ‘Product Manager’]` 这样的 list 字面量，
只是用圆括号代替了方括号。在 Dart 中，records 是通用特性，
用途不限于函数返回值。你还可以把它们存进变量、放进 list、
用作 map 的键，或创建包含其他 records 的 record。
你既能像前面的例子那样添加匿名字段，
也能添加像 `(42, description: ‘Meaning of life’)` 这样的具名字段。

Records are value types and don’t have an identity. This enables our compilers to completely erase the record object in some cases. Records also come with an automatically defined `==` operator and `hashCode` functions. The [records documentation](https://dart.dev/language/records) has more details.

Records 是值类型，没有身份标识（identity）。
这让我们的编译器在某些情况下可以完全消除 record 对象。
Records 还自带自动定义的 `==` 运算符和 `hashCode` 函数。
[records 文档](https://dart.dev/language/records)有更多细节。

### Working with structured data with patterns and pattern matching

### 用 patterns 和模式匹配处理结构化数据

Records simplify how you build up structured data. This does not replace using classes to build up more formal type hierarchies. It just offers another option. In either case, you might want to break that structured data into its individual elements to work with them. This is where pattern matching comes into play.

Records 简化了构建结构化数据的方式。这并不取代用类
构建更正式的类型层次结构，只是提供了另一个选项。
无论哪种方式，你可能都想把结构化数据拆解成单个元素来处理。
这正是模式匹配（pattern matching）大显身手的地方。

Consider a basic form of a pattern. The following record pattern destructures a record into two new variables `name` and `height`. These variables can then be used like any other variable, such as in a call to `print`:

来看 pattern 的一种基本形式。下面的 record pattern
把一个 record 解构为两个新变量 `name` 和 `height`。
之后这些变量可以像任何其他变量一样使用，比如传给 `print`：

```dart
var (String name, int height) = userInfo({'name': 'Michael', 'height': 180});
print('User $name is $height cm tall.');
```


Similar patterns exist for lists and maps. For all of these, you can skip individual elements with the underscore pattern:

list 和 map 也有类似的 pattern。对所有这些 pattern，
你都可以用下划线 pattern 跳过单个元素：

```dart
var (String name, _) = userInfo(…);
```


Patterns shine when used in a switch statement. Dart has had limited support for switch since the beginning. In Dart 3 we’ve broadened the power and expressiveness of the `switch` statement. We now support pattern matching in these cases. We’ve removed the need for adding `break` at the end of each case. We also support logical operators to combine cases. The following example shows a nice and crisp `switch` statement that parses a character code:

Patterns 在 switch 语句中最能大放异彩。Dart 从一开始对 switch
的支持就很有限。在 Dart 3 中，我们拓展了 `switch` 语句的能力
和表现力：现在支持在这些 case 中进行模式匹配；
不再需要在每个 case 末尾加 `break`；
还支持用逻辑运算符组合 case。下面的例子展示了一个
简洁明快的 `switch` 语句，用来解析字符编码：

```dart
switch (charCode) {
  case slash when nextCharCode == slash:
    skipComment();

  case slash || star || plus || minus:
    operator(charCode);

  case >= digit0 && <= digit9:
    number();

  default:
    invalid();
}
```


The switch statement provides a great help when you need one or more statements for each `case`. In some cases, all you want to do is to calculate a value. For that use case, we provide a very succinct switch *expression*. This resembles the switch *statement*, but uses different syntax that’s fine tuned for expressions. The following sample function returns the value of a switch expression to calculate a description of today’s weekday:

当每个 `case` 需要一条或多条语句时，switch 语句帮了大忙。
但有时你想做的只是计算一个值。针对这种场景，
我们提供了非常简洁的 switch *表达式*。它与 switch *语句*相似，
但使用了为表达式微调过的不同语法。下面的示例函数
返回一个 switch 表达式的值，用来生成今天是星期几的描述：

```dart
String describeDate(DateTime dt) =>
  switch (dt.weekday) {
      1 => 'Feeling the Monday blues?',
      6 || 7 => 'Enjoy the weekend!',
      _ => 'Hang in there.'
  };
```


A powerful feature of patterns is the ability to check for “exhaustiveness”, This feature ensures that the switch handles all the possible cases. In the previous example, we’re handling all possible values of weekday, which is an `int`. We exhaust all possible values through the combination of match statements for the specific values `1`, `6` or `7`, and then using a default case `_` for the remaining cases. To enable this check for user-defined data hierarchies, such as a class hierarchy, use the new `sealed` modifier on the top of the class hierarchy as in the following example:

Patterns 的一个强大能力是检查“穷尽性”（exhaustiveness）。
这个特性确保 switch 处理了所有可能的情况。在前面的例子里，
我们处理了 weekday（一个 `int`）的所有可能取值：
先匹配特定值 `1`、`6` 或 `7`，再用默认 case `_`
覆盖其余情况，从而穷尽所有可能值。要对用户自定义的数据层次
（比如类层次结构）启用这项检查，请在类层次的顶部
使用新的 `sealed` 修饰符，如下例所示：

```dart
sealed class Animal { … }
class Cow extends Animal { … }
class Sheep extends Animal { … }
class Pig extends Animal { … }

String whatDoesItSay(Animal a) =>
    switch (a) { Cow c => '$c says moo', Sheep s => '$s says baa' };
```


This returns the following error, alerting us that we missed handling the last possible subtype, Pig:

这会返回下面的错误，提醒我们漏掉了最后一个可能的子类型 Pig：

```
line 6 • The type 'Animal' is not exhaustively matched by the switch cases
since it doesn't match 'Pig()'.
```

（第 6 行 • 类型 'Animal' 未被 switch 的各个 case 穷尽匹配，
因为没有匹配 'Pig()'。）


Finally, `if` statements can use patterns too. In the next example, we’re using *if-case* matching against a map-pattern to destructure the JSON map. Inside that, we’re matching against constant values (strings like `'name'` and `'Michael'`) and a type test pattern `int h` to read out a JSON value. If the pattern matches fail, Dart executes the `else` statement.

最后，`if` 语句也能使用 patterns。在下一个例子中，
我们用 *if-case* 对一个 map-pattern 进行匹配，解构 JSON map。
在其中，我们匹配常量值（如 `'name'` 和 `'Michael'` 这样的字符串），
并用类型测试 pattern `int h` 读出一个 JSON 值。
如果 pattern 匹配失败，Dart 会执行 `else` 语句。

```dart
final json = {'name': 'Michael', 'height': 180};

// Find Michael's height.
if (json case {'name': 'Michael', 'height': int h}) {
  print('Michael is $h cm tall.'); 
} else { 
  print('Error: json contains no height info for Michael!');
}
```


This just touches on all the things you can do with patterns. We believe they will become pervasive across all Dart code. To learn more, check out the [patterns documentation](http://dart.dev/language/patterns) and [patterns codelab](https://codelabs.developers.google.com/codelabs/dart-patterns-records).

这只是 patterns 能力的冰山一角。我们相信它们会遍布所有
Dart 代码。想了解更多，请查看
[patterns 文档](http://dart.dev/language/patterns)和
[patterns codelab](https://codelabs.developers.google.com/codelabs/dart-patterns-records)。

### Fine grained access controls for classes with class modifiers

### 用类修饰符对类进行细粒度访问控制

A third Dart 3 language feature is class modifiers. Unlike records & patterns that we expect every Dart developer to use, this is more of a power-user feature. It addresses the needs of Dart developers crafting large API surfaces or building enterprise-class apps.

Dart 3 的第三项语言特性是类修饰符。与我们预期每位 Dart
开发者都会用到的 records 和 patterns 不同，
这更像是一个面向高级用户的特性，
满足的是打造大型 API 或构建企业级应用的 Dart 开发者的需求。

Class modifiers enable API authors to support only a specific set of capabilities. The defaults remain unchanged though. We want Dart to remain simple and approachable. So, like before, regular classes can be *constructed*, *extended* and *implemented*, as shown in the following examples:

类修饰符让 API 作者可以只支持特定的一组能力。
不过默认行为保持不变。我们希望 Dart 保持简单易上手。
所以和以前一样，普通类可以被*构造*、*继承*和*实现*，
如下面的例子所示：

```dart
class Vehicle {
  String make; String model;
  void moveForward(int meters) { … }
}

// Construct.
var myCar = Vehicle(make: 'Ford', model: 'T',);

// Extend.
class Car extends Vehicle {
  int passengers;
}

// Implement.
class MockVehicle implements Vehicle {
  @override void moveForward …
}
```


Class modifiers support adding restrictions to this. Consider some sample uses cases:

类修饰符支持在此基础上添加限制。来看一些示例用例：

* With an `interface class`, you can define a contract for others to implement. An interface class cannot be extended.

  用 `interface class`，你可以定义一份供他人实现的契约。
  interface class 不能被继承（extend）。

* With a `base class`, you can ensure that all of the subtypes of your class inherit from it, instead of implementing its interface. This ensures that private methods are available on all instances.

  用 `base class`，你可以确保类的所有子类型都继承自它，
  而不是只实现它的接口。这保证了私有方法在所有实例上都可用。

* With a `final class`, you can close the type hierarchy preventing any subclasses outside of your own library. As a sample benefit, this allows the API owner to add new members without risking breaking changes to the consumers of the API.

  用 `final class`，你可以封闭类型层次，
  禁止在自己的库之外出现任何子类。一个示例好处是：
  API 所有者可以添加新成员，而不必担心给 API 的使用者
  带来破坏性变更。

For details, see the new [class modifiers documentation](https://dart.dev/language/class-modifiers).

详情请参见新的[类修饰符文档](https://dart.dev/language/class-modifiers)。

## A view towards the future

## 展望未来

Dart 3 is not just a significant step forward in terms of new features you can use today. We’re also giving you a preview of what’s next.

Dart 3 不只是在你今天就能使用的新特性上迈出一大步，
我们还为你预览了接下来的方向。

### Dart language

### Dart 语言

Records, patterns, and class modifiers are very large new features, so it’s possible that there are parts of their design that could be improved. We’ll continue to monitor [your feedback](https://github.com/dart-lang/language/issues), and see if updates are needed in minor releases following Dart 3.

Records、patterns 和类修饰符都是非常庞大的新特性，
设计上可能有可以改进的地方。我们会持续关注
[你的反馈](https://github.com/dart-lang/language/issues)，
看看是否需要在 Dart 3 之后的小版本中更新。

We’re also looking at some smaller, more incremental features that are entirely non-breaking and focused on increasing developer productivity without migration cost. Two examples we’re exploring are [inline classes](https://github.com/dart-lang/language/issues/2727) for wrapping existing types with zero-cost “wrappers”, and [primary constructors](https://github.com/dart-lang/language/issues/2364); a feature that introduces a much more concise syntax for defining classes with a few fields and a primary constructor.

我们也在研究一些更小、更渐进的特性，它们完全不破坏兼容性，
专注于在没有迁移成本的前提下提升开发者生产力。
我们正在探索的两个例子是：
[inline classes](https://github.com/dart-lang/language/issues/2727)，
用零成本“包装器”包装既有类型；以及
[primary constructors](https://github.com/dart-lang/language/issues/2364)
（主构造函数），为定义只有几个字段和一个主构造函数的类
引入更简洁的语法。

We’ve previously discussed macros (also referred to as [meta-programming](https://github.com/dart-lang/language/blob/main/working/macros/feature-specification.md)). We’re in particular focused on this for enabling better deserialization of JSON (and similar), and for enabling data classes. Given the size and inherent risk in metaprogramming, we’re taking a very thorough approach, and we thus have no concrete timeline to share, even for finalizing design decisions.

我们之前讨论过宏（macros，也称
[元编程](https://github.com/dart-lang/language/blob/main/working/macros/feature-specification.md)）。
我们尤其关注用它实现更好的 JSON（及类似格式）反序列化，
以及实现数据类（data classes）。鉴于元编程的规模和固有风险，
我们采取了非常审慎的方式，因此没有具体的时间表可以分享，
连敲定设计决策的时间也没有。

### Native interop

### 原生互操作

Apps on mobile and desktop typically rely on lots of APIs provided by the native platform, whether it’s notifications, payments, or getting the phone’s location. Traditionally in Flutter these are accessed by building plugins, which require writing both Dart code for the API and a bunch of platform-specific code to provide the implementation.

移动端和桌面端应用通常依赖原生平台提供的大量 API，
无论是通知、支付，还是获取手机位置。传统上在 Flutter 中，
这些要通过构建插件来访问：既要为 API 编写 Dart 代码，
又要写一堆平台特定的代码来提供实现。

We already support interop with code that compiles to C libraries with [`dart:ffi`](https://dart.dev/guides/libraries/c-interop). We’re currently working on expanding this to support [Java and Kotlin interop](https://dart.dev/guides/libraries/java-interop) on Android, and [Objective C and Swift interop](https://dart.dev/guides/libraries/objective-c-interop) on iOS/macOS. For an introduction to the Android interop, checkout the new Google I/O 23 [Android interoperability video](https://io.google/2023/program/2f02692d-9a41-49c0-8786-1a22b7155628/).

我们已经通过 [`dart:ffi`](https://dart.dev/guides/libraries/c-interop)
支持与编译为 C 库的代码互操作。目前我们正在扩展这一能力，
以支持 Android 上的
[Java 和 Kotlin 互操作](https://dart.dev/guides/libraries/java-interop)，
以及 iOS/macOS 上的
[Objective C 和 Swift 互操作](https://dart.dev/guides/libraries/objective-c-interop)。
想了解 Android 互操作的入门介绍，请观看 Google I/O 23 新发布的
[Android 互操作视频](https://io.google/2023/program/2f02692d-9a41-49c0-8786-1a22b7155628/)。

### Compilation to WebAssembly — targeting the web with native code

### 编译到 WebAssembly——用原生代码面向 Web

[WebAssembly](https://webassembly.org/) (abbreviated Wasm) has been growing in maturity as a platform-neutral binary instruction format across [all modern browsers](https://caniuse.com/wasm). The Flutter framework has used Wasm for a while. It’s how we deliver the SKIA graphics rendering engine, written in C++, to the browser via a Wasm compiled module. We’ve long had an interest in using Wasm to deploy Dart code too, but we’ve been blocked. Dart, like many other object oriented languages, uses garbage collection. Over the past year, we’ve collaborated with several teams across the Wasm ecosystem to add a new WasmGC feature to the WebAssembly standard. This is now near-stable in the Chromium and Firefox browsers.

[WebAssembly](https://webassembly.org/)（简称 Wasm）
作为一种平台中立的二进制指令格式，
在[所有现代浏览器](https://caniuse.com/wasm)中日趋成熟。
Flutter 框架使用 Wasm 已有一段时间：我们正是通过 Wasm
编译模块，把用 C++ 编写的 SKIA 图形渲染引擎交付到浏览器。
我们早就想也用 Wasm 部署 Dart 代码，但一直受阻。
Dart 和许多其他面向对象语言一样使用垃圾回收。过去一年里，
我们与 Wasm 生态中的多个团队合作，
为 WebAssembly 标准加入了新的 WasmGC 特性。
它现在在 Chromium 和 Firefox 浏览器中已接近稳定。

Our work on compiling Dart to Wasm modules has two high-level goals for web apps:

我们把 Dart 编译为 Wasm 模块的工作，
对 Web 应用有两个高层目标：

* **Load time:** we hope that we can deliver deployment payloads with Wasm that the browser can load faster, thus improving the time it takes to get to the point where the user can interact with the web app.

  **加载时间：**我们希望用 Wasm 交付浏览器能更快加载的
  部署产物，从而缩短用户到能与 Web 应用交互那一刻的时间。

* **Performance:** Web apps powered by JavaScript require just-in-time compilation to achieve good performance. Wasm modules are more low-level and closer to machine code, so we think they can deliver higher performance with less jank and more consistent frame rates.

  **性能：**由 JavaScript 驱动的 Web 应用需要即时编译
  才能获得好性能。Wasm 模块更底层、更接近机器码，
  所以我们认为它们能带来更高的性能、更少的卡顿
  和更稳定的帧率。

* **Semantic consistency**: Dart takes pride in being highly consistent between our supported platforms. However, on the web, there are a few exceptions to this. For example, Dart web currently differs in how[ numbers are represented](https://dart.dev/guides/language/numbers). With Wasm modules, we’d be able to treat the web like a “native” platform with semantics similar to other native targets.

  **语义一致性**：Dart 以在所支持平台之间高度一致而自豪。
  但在 Web 上有少数例外。例如，Dart Web 目前在
  [数字的表示方式](https://dart.dev/guides/language/numbers)上有所不同。
  有了 Wasm 模块，我们就能把 Web 当作一个“原生”平台，
  拥有与其他原生目标相似的语义。

We’re excited to announce the first preview of Dart to Wasm compilation today! Our initial focus is on Flutter web support. It’s still early, and we have lots of work to complete, but we [invite you to experiment ](https://flutter.dev/wasm)and see if this has you as excited as we are.

我们很高兴在今天宣布 Dart 到 Wasm 编译的首个预览版！
我们最初的重点是 Flutter Web 支持。现在还处于早期，
有大量工作要完成，但我们
[邀请你来实验](https://flutter.dev/wasm)，
看看这是否也让你像我们一样兴奋。

## Closing

## 结语

Thanks for reading until the end. We hope this post has made you excited about Dart 3, available today in both the stand-alone [Dart SDK](https://dart.dev/get-dart) and in the [Flutter 3.10 SDK]({{site.flutter-blog}}/whats-new-in-flutter-3-10).

感谢你读到最后。希望这篇文章让你对 Dart 3 充满期待。
它今天已经在独立的 [Dart SDK](https://dart.dev/get-dart) 和
[Flutter 3.10 SDK]({{site.flutter-blog}}/whats-new-in-flutter-3-10)
中提供。

We’ve completed a major overhaul of the Dart language with sound null safety, and core library and tools cleanup. There are major new language features that make Dart more expressive and crisp with records and patterns. For large API surfaces, class modifiers enable detailed control. We’re also including a preview of the future with our coming support for WebAssembly.

我们通过健全空安全以及核心库和工具的清理，
完成了对 Dart 语言的一次重大改造。records 和 patterns
等重要新语言特性让 Dart 更具表现力、更简洁。
对于大型 API，类修饰符提供了精细的控制。
我们还通过即将到来的 WebAssembly 支持预览了未来。

With all of these features, we think Dart 3 illustrates our long-term vision: *To build the most productive programming language for building fast apps on any platform*. We hope you think so too!

有了所有这些特性，我们认为 Dart 3 诠释了我们的长期愿景：
*打造最有生产力的编程语言，用于在任何平台上构建快速应用*。
希望你也这么认为！
