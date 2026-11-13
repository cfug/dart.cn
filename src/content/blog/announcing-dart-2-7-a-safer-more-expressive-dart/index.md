---
# title: "Announcing Dart 2.7: A safer, more expressive Dart"
title: "宣布 Dart 2.7：更安全、更具表现力的 Dart"
# description: "Today we’re announcing the stable release of the Dart 2.7 SDK, with additional new capabilities for developers. It’s been a busy year for…"
description: "今天我们宣布 Dart 2.7 SDK 稳定版发布，为开发者带来更多新能力。对 Dart 来说，这是忙碌的一年……"
ai-translated: true
publishDate: 2019-12-11
author: mit-mit
image: images/0G-I1kyYJFCTCiAUk.webp
category: releases
layout: blog
---


Today we’re announcing the stable release of the Dart 2.7 SDK, with additional new capabilities for developers. It’s been a busy year for Dart, our client-optimized language for fast apps on any platform. We’ve shipped six new releases with dozens of new features. It’s been very rewarding to see the Dart community use these features, and we were delighted by the recent [GitHub Octoverse](https://octoverse.github.com/) report listing Dart as the [#1 fastest growing language](https://octoverse.github.com/#top-languages), ranked by number of contributors.

今天我们宣布 Dart 2.7 SDK 稳定版发布，为开发者带来更多新能力。
对 Dart 这门为任何平台构建快速应用而优化的客户端语言来说，
这是忙碌的一年：我们发布了六个新版本，带来数十项新特性。
看到 Dart 社区使用这些特性让我们非常有成就感，而最近的
[GitHub Octoverse](https://octoverse.github.com/) 报告按贡献者数量
把 Dart 列为[增长最快的语言第一名](https://octoverse.github.com/#top-languages)，
更是让我们欣喜不已。

Dart 2.7 adds support for extension methods, plus a new package for handling strings with special characters. We have an update on null safety (type-safe nullable and non-nullable types) and a brand new null safety playground experience in DartPad. At the ecosystem level, pub.dev has a new *Like* feature for giving feedback to packages that you appreciate. Dart 2.7 is available today as an SDK download from [dart.dev](http://dart.dev), and it’s also built into today’s [Flutter 1.12 release](https://medium.com/@csells_18027/flutter-1-12-release-blog-22c256ba525d).

Dart 2.7 新增了对 extension methods（扩展方法）的支持，
以及一个处理含特殊字符的字符串的新 package。
我们还带来了 null safety（空安全，即类型安全的可空与不可空类型）的最新进展，
以及 DartPad 中全新的空安全演练场体验。
在生态层面，pub.dev 推出了新的 *Like*（点赞）功能，
让你为欣赏的 package 给出反馈。
Dart 2.7 今天即可从 [dart.dev](http://dart.dev) 下载 SDK，
它也内置于今天发布的
[Flutter 1.12](https://medium.com/@csells_18027/flutter-1-12-release-blog-22c256ba525d) 中。

<DashImage src="images/0G-I1kyYJFCTCiAUk.webp" alt="Dart 2.7 release banner highlighting extension methods, the characters package in preview, and the null safety preview." />


## Extension methods

## 扩展方法（Extension methods）

Dart 2.7 adds a long-requested, powerful new language feature: **extension methods**. These enable you to add new functionality to any type — even types you don’t control — and have the brevity and auto-complete experience of regular method calls.

Dart 2.7 加入了一个大家期盼已久的强大新语言特性：**扩展方法**。
它让你能为任何类型——甚至是你无法控制的类型——添加新功能，
同时保有普通方法调用的简洁写法和自动补全体验。

Let’s look at a small example: adding support for parsing ints and doubles from Strings. As app developers we can’t change the `String` class, because that’s defined in the dart:core library, but with extension methods we can extend it! Once we define this extension, we can call our new `parseInt` method on a String as if the method was defined on the String class itself:

来看一个小例子：为 String 添加解析 int 和 double 的支持。
作为应用开发者，我们无法修改 `String` 类，因为它定义在 dart:core 库中，
但有了扩展方法，我们就能扩展它！定义好这个 extension 之后，
我们就可以在 String 上调用新的 `parseInt` 方法，
就像这个方法本来就定义在 String 类上一样：

```
extension ParseNumbers on String {
  int parseInt() {
    return int.parse(this);
  }

  double parseDouble() {
    return double.parse(this);
  }
}

main() {
  int i = '42'.parseInt();
  print(i);
}
```


## Extension methods are static

## 扩展方法是静态的

Extension methods are resolved and dispatched statically, which means you can’t call them on values whose type is `dynamic`. Here the call throws an exception at runtime:

扩展方法在编译期静态解析和分派，这意味着你不能在类型为 `dynamic`
的值上调用它们。下面这个调用会在运行时抛出异常：

```
dynamic d = '2';

d.parseInt();

→ Runtime exception: NoSuchMethodError
```


Extension methods work well with Dart’s [type inference](https://dart.dev/guides/language/sound-dart#type-inference), so in the following variable `v` is inferred to have type `String`, and the extension on String is available:

扩展方法与 Dart 的[类型推断](https://dart.dev/guides/language/sound-dart#type-inference)
配合得很好，所以下面的变量 `v` 会被推断为 `String` 类型，
String 上的 extension 也就可用了：

```
var v = '1';
v.parseInt(); // Works!
```


Because extension methods are resolved statically, they’re as fast as calling a static function or helper method, but with a much friendlier invocation syntax.

由于扩展方法是静态解析的，它们和调用静态函数或辅助方法一样快，
但调用语法要友好得多。

## Extensions can have type variables

## Extension 可以带类型变量

Imagine we want to define an extension on `List` for getting the elements at even indices. We’d like this extension to work on lists of any type, returning a new list of the same type as the input list. We can do this by making the extension generic and applying its type parameter to both the type it extends and the extension method:

假设我们想为 `List` 定义一个获取偶数下标元素的 extension。
我们希望它对任何类型的列表都适用，并返回与输入列表类型相同的新列表。
把 extension 定义为泛型，并把它的类型参数同时应用到被扩展的类型
和扩展方法上，就能做到这一点：

```
extension FancyList<T> on List<T> {
  List<T> get evenElements {
    return <T>[for (int i = 0; i < this.length; i += 2) this[i]];
  }
}
```


## Extension methods are really extension members

## 扩展方法其实是扩展成员

We call the feature *extension methods* because that’s familiar terminology if you’ve used the corresponding language feature in other programming languages. But in Dart the feature is more general: it also supports extending classes with new getters, setters, and operators. In the FancyList example above, `evenElements` is a getter. Here’s an example of adding an operator for shifting strings:

我们把这个特性叫做 *extension methods*（扩展方法），
因为如果你用过其他编程语言中的对应特性，这个叫法更熟悉。
但在 Dart 中，这个特性更通用：它还支持为类扩展新的
getter、setter 和运算符。在上面的 FancyList 例子中，
`evenElements` 就是一个 getter。
下面是一个为字符串添加移位运算符的例子：

```
extension ShiftString on String {
  String operator <<(int shift) {
    return this.substring(shift, this.length) + this.substring(0, shift);
  }
}
```


## Great examples from the community

## 来自社区的精彩示例

We’ve already seen many developers in the Dart community experiment with extension methods. Here are some of the cool uses we’ve seen so far.

我们已经看到 Dart 社区的许多开发者在尝试扩展方法。
下面是目前我们看到的一些很酷的用法。

Jeremiah Ogbomo created the [time package](https://pub.dev/packages/time), which uses extensions on `num` (the base class for ints and doubles) to enable easy construction of `Duration` objects:

Jeremiah Ogbomo 创建了
[time package](https://pub.dev/packages/time)，
它在 `num`（int 和 double 的基类）上使用 extension，
让构造 `Duration` 对象变得轻松：

```
// Create a Duration via a `minutes` extension on num.
Duration tenMinutes = 10.minutes;

// Create a Duration via an `hours` extension on num.
Duration oneHourThirtyMinutes = 1.5.hours;

// Create a DateTime using a `+` operator extension on DateTime.
final DateTime afterTenMinutes = DateTime.now() + 10.minutes;
```


Marcelo Glasberg created an [i18n (internationalization) package](https://www.reddit.com/r/FlutterDev/comments/dm288s/dart_extensions_applied_to_i18n_you_have/) that uses extension methods to simplify string localization:

Marcelo Glasberg 创建了一个
[i18n（国际化）package](https://www.reddit.com/r/FlutterDev/comments/dm288s/dart_extensions_applied_to_i18n_you_have/)，
用扩展方法简化字符串本地化：

```
Text('Hello'.i18n) // Displays Hello in English, Hola in Spanish, etc.
```


Simon Leier created the [dartx package](https://pub.dev/packages/dartx), which contains extensions for a bunch of core Dart types. Some examples:

Simon Leier 创建了
[dartx package](https://pub.dev/packages/dartx)，
其中包含一批 Dart 核心类型的 extension。举几个例子：

```
var allButFirstAndLast = list.slice(1, -2);    // [1, 2, 3, 4]
var notBlank = ' .'.isBlank;                   // false
var file = File('some/path/testFile.dart');
print(file.name);                              // testFile.dart
print(file.nameWithoutExtension);              // testFile
```


Brian Egan is [updating](https://github.com/ReactiveX/rxdart/pull/368) the popular [RxDart package](https://pub.dev/packages/rxdart) with extension methods to redefine the API for working with streams.

Brian Egan 正在用扩展方法[更新](https://github.com/ReactiveX/rxdart/pull/368)
广受欢迎的 [RxDart package](https://pub.dev/packages/rxdart)，
重新定义处理 stream 的 API。

## Safe substring handling

## 安全的子字符串处理

Dart’s standard String class uses the [UTF-16](https://en.wikipedia.org/wiki/UTF-16) encoding. This is a common choice in programming languages, especially those that offer support for running both natively on devices, and on the web.

Dart 标准的 String 类使用
[UTF-16](https://en.wikipedia.org/wiki/UTF-16) 编码。
这是编程语言中的常见选择，尤其是那些既支持在设备上原生运行、
又支持在 Web 上运行的语言。

UTF-16 strings usually work well, and the encoding is transparent to the developer. However, when manipulating strings, and especially when manipulating strings entered by users, you may experience a difference between what the user perceives as a character, and what is encoded as a code unit in UTF-16. Let’s look at a small example, extracting the first three characters of a string entered by a user:

UTF-16 字符串通常工作得很好，编码对开发者是透明的。
但在操作字符串时——尤其是操作用户输入的字符串时——
你可能会发现用户感知到的“字符”与 UTF-16 中编码的码元并不一致。
来看一个小例子：提取用户输入字符串的前三个字符：

```
var input = ['Resume'];
input.forEach((s) => print(s.substring(0, 3)));

$ dart main.dart
Res
```


No problems so far; we printed the first three characters of the string in our input list, and the result is `Res`. Now let’s consider users from varying regions, who might enter strings that contain accents, Hangul (Korean script), and even a combination of emoji to represent the concept ‘resume’:

到目前为止一切正常：我们打印了输入列表中字符串的前三个字符，
结果是 `Res`。现在考虑来自不同地区的用户，
他们输入的字符串可能包含重音符号、谚文（韩文字符），
甚至用 emoji 组合来表示“简历”这个概念：

```
// New longer input list:
var input = ['Resume', 'Résumé', '이력서', '💼📃', 'Currículo'];

$ dart main.dart
Res
Ré
이력서
💼�
Cur
```


Hmm, some of those worked, but what happened to the elements `Résumé` and `💼📃`? For `Résumé`, why did we get a “two character” string? For `💼📃`, what’s up with the odd question mark? The problems here lie in the [dark corners of Unicode](https://eev.ee/blog/2015/09/12/dark-corners-of-unicode/). The accented `é` in `Résumé` is actually two code points: an *e* and a [*combining acute accent*](https://unicode.org/cldr/utility/character.jsp?a=0301). And 📃, the [page with curl](https://emojipedia.org/emoji/%F0%9F%93%83/) emoji, is a single code point that happens to be encoded with a surrogate pair of `U+d83d U+dcc3`. Confused?

嗯，有些结果没问题，但 `Résumé` 和 `💼📃` 这两个元素怎么了？
对 `Résumé`，为什么得到一个“两个字符”的字符串？
对 `💼📃`，那个奇怪的问号又是怎么回事？
问题出在 [Unicode 的黑暗角落](https://eev.ee/blog/2015/09/12/dark-corners-of-unicode/)。
`Résumé` 中带重音的 `é` 其实是两个码点：一个 *e* 加上一个
[*组合尖音符*](https://unicode.org/cldr/utility/character.jsp?a=0301)。
而 📃 这个[卷角页面](https://emojipedia.org/emoji/%F0%9F%93%83/) emoji
是单个码点，恰好用 `U+d83d U+dcc3` 这对代理对来编码。晕了吗？

As we said, often you don’t need to worry about characters and code points. If all you do is receive, pass around, and hand over whole strings, the internal encoding is transparent. But if you need to iterate over the characters of a string or to manipulate the contents of a string, you can get into trouble. The good news is that Dart 2.7 **introduces a new package, [characters](https://pub.dev/packages/characters)**, for handling these cases. This package supports strings viewed as sequences of user-perceived characters, also known as Unicode [grapheme clusters](https://unicode.org/reports/tr29/#Grapheme_Cluster_Boundaries). With the characters package we can fix our code with a small change to the code that shortens the text:

如前所说，通常你不需要操心字符和码点。
如果你只是接收、传递和交出完整的字符串，内部编码是透明的。
但如果你需要遍历字符串中的字符或修改字符串内容，就可能遇到麻烦。
好消息是，Dart 2.7 **推出了一个新 package：
[characters](https://pub.dev/packages/characters)**，专门处理这些情况。
这个 package 支持把字符串视为用户感知字符的序列，
也就是 Unicode
[字素簇](https://unicode.org/reports/tr29/#Grapheme_Cluster_Boundaries)。
有了 characters package，只需小改一下截短文本的代码就能修复问题：

```
// Before:
input.forEach((s) => print(s.substring(0, 3)));

// After, using the characters package:
input.forEach((s) => print(s.characters.take(3)));
```


First we create a new `Characters` instance from the string in `s` (using the convenient `.characters` extension method). Then we use the nifty `take()` method to extract the initial 3 characters.

我们先用 `s` 中的字符串创建一个新的 `Characters` 实例
（借助方便的 `.characters` 扩展方法），
然后用灵巧的 `take()` 方法提取开头的 3 个字符。

A technical preview of this new package is [available on pub.dev](https://pub.dev/packages/characters). We’d love to hear your thoughts about this package. If you find any issues, [please report them](https://github.com/dart-lang/characters/issues).

这个新 package 的技术预览版已在
[pub.dev 上提供](https://pub.dev/packages/characters)。
我们很想听听你对它的想法。如果发现任何问题，
[请报告给我们](https://github.com/dart-lang/characters/issues)。

## Null safety preview

## 空安全预览

A few months ago we [announced our intent](/blog/announcing-dart-2-5-super-charged-development#closing-thoughts) to support **null safety** in Dart, adding support for accessing object references safely without triggering null reference exceptions. Today we’re giving you a way to preview null safety static analysis. Let’s look at a small motivating example:

几个月前我们[宣布了意向](/blog/announcing-dart-2-5-super-charged-development#closing-thoughts)：
在 Dart 中支持**空安全**，让对象引用的访问更安全，
不再触发空引用异常。今天我们提供了一种预览空安全静态分析的方式。
来看一个小的引子示例：

```
void main() {
  Person('Larry', birthday: DateTime(1973, 03, 26)).describe();
  Person('Sergey').describe();
}

class Person {
  String firstName;
  DateTime birthday;
  Person(this.firstName, {this.birthday});

  void describe() {
    print(firstName);
    int birthyear = birthday?.year;
    print('Born ${DateTime.now().year - birthyear} years ago');
  }
}
```


If we run this code it crashes with a null pointer exception while describing the second person, because that person doesn’t have a birthday set. We made a coding mistake: while we did anticipate some persons having unknown birthdays by making the `birthday` field optional in the constructor and by testing for a null birthday in `birthday?.year`, we forgot to handle the case where `birthyear` is null.

运行这段代码，在描述第二个人时会因空指针异常而崩溃，
因为那个人没有设置生日。我们犯了一个编码错误：
虽然我们在构造函数中把 `birthday` 字段设为可选，
并用 `birthday?.year` 检查了生日为 null 的情况，
预料到有些人的生日未知，却忘了处理 `birthyear` 为 null 的情形。

Let’s try to paste this code into our new [null safety playground](https://nullsafety.dartpad.dev), a special build of DartPad that contains a technical preview of the static analysis part of the null safety feature. Without even running the code, we can see three issues:

试着把这段代码粘贴到我们新的
[空安全演练场](https://nullsafety.dartpad.dev)里，
它是 DartPad 的一个特殊构建版本，包含空安全特性中
静态分析部分的技术预览。还没运行代码，就能看到三个问题：

<DashImage src="images/0YFTJUSwsYzsHTY4b.webp" alt="DartPad with null safety showing three diagnostics related to null." caption="DartPad with null safety showing three analysis errors related to nulls" />


By fixing these analysis errors, we can begin to take advantage of null safety. Try making the following edits in the null safety playground (eventually getting to [this safe code](https://gist.github.com/mit-mit/c210bfb088545e69ba9231ee459615ba)):

修复这些分析错误后，我们就能开始享受空安全的好处。
试着在空安全演练场中做以下修改
（最终得到[这份安全的代码](https://gist.github.com/mit-mit/c210bfb088545e69ba9231ee459615ba)）：

1. To declare that birthday might be null, change
*`DateTime birthday`* to *`DateTime? birthday`*

  要声明 birthday 可能为 null，把
  *`DateTime birthday`* 改为 *`DateTime? birthday`*

1. To declare that birthyear might be null when birthday is null, change 
*`int birthyear`* to *`int? birthyear`*

  要声明当 birthday 为 null 时 birthyear 也可能为 null，把
  *`int birthyear`* 改为 *`int? birthyear`*

1. Wrap the last print call in a null test:
`*if (birthyear != null)* {…}`

  把最后一个 print 调用包在 null 检查里：
  `*if (birthyear != null)* {…}`

We hope this example gives you a good indication of the experience we want with null safety. As mentioned, this playground is just an early technical preview of part of null safety, as it’s being built. We’re working hard on completing a first beta release of null safety in the Dart SDK. Here’s what we’re working on for beta:

希望这个例子能让你大致体会到我们想要的空安全体验。
如前所述，这个演练场只是空安全部分能力在构建过程中的早期技术预览。
我们正在努力完成 Dart SDK 中空安全的首个 beta 版本。
以下是 beta 阶段正在进行的工作：

1. Completing the full implementation of nullable and non-nullable references

  完成可空与不可空引用的完整实现

1. Integrating null safety into Dart’s type inference and smart promotion (for example, allowing safe access to a nullable variable after an assignment or null-check)

  把空安全整合进 Dart 的类型推断和智能类型提升
  （例如在赋值或 null 检查之后，允许安全访问可空变量）

1. Porting the Dart [core libraries](https://dart.dev/guides/libraries) to declare which types are nullable and which are non-nullable

  迁移 Dart [核心库](https://dart.dev/guides/libraries)，
  声明哪些类型可空、哪些不可空

1. Adding a migration tool, which can automate the majority of the upgrade tasks for porting Dart apps and packages

  添加迁移工具，自动完成 Dart 应用和 package 迁移中的大部分升级工作

Once this work is complete, we’ll make it available in a beta SDK, and you can begin to take advantage of the feature in your apps and packages. We also plan to keep the null safety playground updated with new features as they’re implemented.

这些工作完成后，我们会在 beta SDK 中提供该特性，
你就可以开始在自己的应用和 package 中使用它了。
我们还计划随着新特性的实现，持续更新空安全演练场。

While we’re sure many developers will want to use null safety as soon as it’s available, you can migrate whenever it’s convenient, opting into the feature when you’re ready. Libraries and packages that haven’t yet opted into the feature will be able to depend on libraries that *have opted in*, and vice versa.

虽然我们确信许多开发者会想在空安全可用后第一时间使用它，
但你可以在方便的时候再迁移，准备好了再启用该特性。
尚未启用该特性的库和 package 可以依赖*已启用*的库，反之亦然。

We’ll have more to say about null safety in the coming months, including more detailed advice on how to prepare for the transition.

未来几个月我们会分享更多关于空安全的内容，
包括如何为过渡做准备的更详细建议。

## Liking 👍 packages on pub.dev

## 在 pub.dev 上为 package 点赞 👍

Also launching on pub.dev today is a new ***Like* feature** for packages. This introduces a new “human signal” for indicating which packages you’re fond of. To like a package, simply click the thumbs-up icon that’s next to the package detail information:

今天 pub.dev 还上线了针对 package 的新 ***Like*（点赞）功能**。
它引入了一种新的“人类信号”，用来表达你喜欢哪些 package。
要给 package 点赞，只需点击 package 详情信息旁边的竖起大拇指图标：

<DashImage src="images/0xCGEGkntNxnM1XAh.webp" alt="Pub.dev package detail page with new Like-feature voting button." caption="*pub.dev package detail page with new Like-feature voting button*" />


Currently we don’t factor the number of likes into our overall scoring model, but we plan on doing so in a later release. We also plan on giving our general search UI and list pages a visual overhaul that will highlight the like-ability of a package.

目前我们还没有把点赞数纳入整体评分模型，但计划在后续版本中这样做。
我们还计划对整体搜索界面和列表页做一次视觉改版，
突出展示 package 的获赞情况。

## Thank you

## 致谢

On behalf of the Dart team, we’d like to thank you — and everyone in the Dart community — for your continued support! Please continue to offer us feedback, and participate in Dart [discussions and communities](https://dart.dev/community). We wouldn’t be a well-functioning open source project without the support we get from the Dart community.

我们谨代表 Dart 团队，感谢你——以及 Dart 社区中的每一个人——
一直以来的支持！请继续给我们反馈，参与 Dart 的
[讨论和社区](https://dart.dev/community)。
没有 Dart 社区的支持，我们不可能成为一个运转良好的开源项目。

2019 has been an incredibly exciting year for Dart, but we’re not stopping here. We have bold plans for 2020, including shipping stable versions of features like [dart:ffi](https://dart.dev/guides/libraries/c-interop) and [null safety](https://github.com/dart-lang/language/issues/110) and introducing new features. We invite you to start using Dart 2.7 today. It’s available from [dart.dev](http://dart.dev), in today’s [Flutter 1.12](https://medium.com/@csells_18027/flutter-1-12-release-blog-22c256ba525d) release, and on the recently [redesigned DartPad](/blog/a-brand-new-dartpad-dev-with-flutter-support).

2019 年对 Dart 来说是无比激动人心的一年，但我们不会止步于此。
我们对 2020 年有大胆的计划，包括发布
[dart:ffi](https://dart.dev/guides/libraries/c-interop) 和
[空安全](https://github.com/dart-lang/language/issues/110)
等特性的稳定版本，并引入新特性。
我们邀请你今天就开始使用 Dart 2.7：可以从 [dart.dev](http://dart.dev) 获取，
它也在今天发布的
[Flutter 1.12](https://medium.com/@csells_18027/flutter-1-12-release-blog-22c256ba525d)
以及最近[重新设计的 DartPad](/blog/a-brand-new-dartpad-dev-with-flutter-support) 中。
