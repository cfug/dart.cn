---
# title: "Announcing Dart 2.3: Optimized for building user interfaces"
title: "宣布 Dart 2.3：为构建用户界面而优化"
# description: "Today we’re announcing the stable release of the Dart 2.3 SDK, with new language features that improve your coding experience when…"
description: "今天我们宣布 Dart 2.3 SDK 稳定版发布，带来改善用户界面开发编码体验的新语言特性、开发 Flutter UI 的新工具支持，以及两个新网站：dart.dev 和 pub.dev"
ai-translated: true
publishDate: 2019-05-08
author: mit-mit
image: images/0iKWVPoE5aSiCI-mW.webp
category: releases
layout: blog
---


Today we’re announcing the stable release of the Dart 2.3 SDK, with new language features that improve your coding experience when developing user interfaces, new tooling support for developing Flutter UI, and two new websites: [dart.dev](https://dart.dev) & [pub.dev](https://pub.dev).

今天我们宣布 Dart 2.3 SDK 稳定版正式发布，带来改善用户界面开发
编码体验的新语言特性、开发 Flutter UI 的新工具支持，
以及两个新网站：[dart.dev](https://dart.dev) 和 [pub.dev](https://pub.dev)。

<DashImage src="images/0iKWVPoE5aSiCI-mW.webp" alt="Dart 2.3 release banner highlighting UI language support, IDE support, and the new dart.dev and pub.dev websites." />


## Dart’s momentum

## Dart 的发展势头

One of the developer research reports we look forward to every year is the [StackOverflow Developer Survey](https://insights.stackoverflow.com/survey/2019), which provides a comprehensive dataset on developer trends and sentiment towards different technologies. This year’s edition demonstrated the growth in popularity and awareness of Dart, which entered the list of [Most Loved Languages](https://insights.stackoverflow.com/survey/2019#technology-_-most-loved-dreaded-and-wanted-languages) for the first time and ranked alongside other popular languages like JavaScript, C#, and Go and ahead of the likes of C++, F#, and R. At the same time, our good friends in the Flutter community were ranked third in the list of [Most Loved Frameworks](https://insights.stackoverflow.com/survey/2019#technology-_-most-loved-dreaded-and-wanted-other-frameworks-libraries-and-tools). Last month’s Codementor survey on *which programming languages to learn and not to learn* had similar positive news:.

我们每年都期待的开发者研究报告之一是
[StackOverflow 开发者调查](https://insights.stackoverflow.com/survey/2019)，
它提供了关于开发者趋势和对不同技术态度的全面数据集。
今年的调查展示了 Dart 在流行度和知名度上的增长：
Dart 首次进入[最受喜爱语言](https://insights.stackoverflow.com/survey/2019#technology-_-most-loved-dreaded-and-wanted-languages)榜单，
与 JavaScript、C# 和 Go 等其他流行语言并列，
并领先于 C++、F# 和 R 等语言。与此同时，
我们在 Flutter 社区的好朋友们在
[最受喜爱框架](https://insights.stackoverflow.com/survey/2019#technology-_-most-loved-dreaded-and-wanted-other-frameworks-libraries-and-tools)榜单中名列第三。
上个月 Codementor 关于*该学和不该学哪些编程语言*的调查
也有类似的好消息：

> *“*Two examples of languages that really rose to the occasion for the title of Most Improved are Dart and Ruby*”.* Codementor, April 2019 [[source](https://www.codementor.io/blog/worst-languages-2019-6mvbfg3w9x)]

> *“*在角逐“进步最大”称号时真正表现出色的两门语言，是 Dart 和 Ruby*”。*
> Codementor，2019 年 4 月 [[来源](https://www.codementor.io/blog/worst-languages-2019-6mvbfg3w9x)]

We’d like to extend a big *thank you* to all developers in the Dart community. It really means a lot to us to see you adopt Dart, offer your feedback, and continue the journey with us as we attempt to build the best client-optimized language for fast apps that run on any platform.

我们想向 Dart 社区的所有开发者致以大大的*感谢*。
看到你们采用 Dart、提供反馈，并与我们一同继续这段旅程——
努力打造最好的、面向客户端优化的语言，
用于构建运行在任何平台上的快速应用——这对我们意义重大。

## New language features for building user interfaces

## 用于构建用户界面的新语言特性

Speaking of client development, one of the longstanding joint projects between the Dart & Flutter teams is creating great support for capturing user interface code using Dart, without needing a markup language. We think that using a single language for both behavior and layout has large benefits. These include reducing context switching, not having to learn two languages, and allowing all of the abstraction features of a general-purpose programming language when building your UI.

说到客户端开发，Dart 与 Flutter 团队之间一个长期合作的项目，
就是让 Dart 能够出色地表达用户界面代码，而无需借助标记语言。
我们认为，用同一种语言同时表达行为和布局有很大好处，
包括减少上下文切换、不必学习两门语言，
以及在构建 UI 时能够使用通用编程语言的全部抽象能力。

We’ve made several improvements over the last few releases, such as simplifying code for [constructing widgets](/blog/announcing-dart-2-optimized-for-client-side-development#ui-as-code), adding automatic [int-to-double conversion](/blog/announcing-dart-2-1-improved-performance-usability), and adding [set literals](/blog/announcing-dart-2-2-faster-native-code-support-for-set-literals). In Dart 2.3 we take another big step forward, with three new features for expressing UI that is list-based, conditional, or repeated.

过去几个版本我们已经做了多项改进，例如简化
[构造 widget](/blog/announcing-dart-2-optimized-for-client-side-development#ui-as-code) 的代码、
加入自动 [int 到 double 转换](/blog/announcing-dart-2-1-improved-performance-usability)，
以及加入 [set 字面量](/blog/announcing-dart-2-2-faster-native-code-support-for-set-literals)。
在 Dart 2.3 中，我们又迈出了一大步，
带来三个新特性，用于表达基于列表、条件或重复的 UI。

You can think of a UI as a tree of widget nodes. Some nodes contain lists of widgets — for example a list of scrollable elements. Often, these lists are built from other lists. For that, we have added a new [*spread operator*](https://dart.dev/guides/language/language-tour#spread-operator) feature for *unpacking* the elements from one list into another. In the following example, `buildMainElements()` returns a list of widgets, which is then unpacked into the surrounding list using the spread operator `…`:

你可以把 UI 想象成一棵 widget 节点树。有些节点包含 widget 列表
——例如一组可滚动元素。这些列表往往由其他列表构建而来。
为此，我们新增了[*展开运算符*](https://dart.dev/guides/language/language-tour#spread-operator)特性，
用于把一个列表中的元素*解包*到另一个列表中。在下面的例子里，
`buildMainElements()` 返回一个 widget 列表，
然后用展开运算符 `…` 把它解包到外层列表中：

```dart
Widget build(BuildContext context) {
  return Column(children: [
    Header(),
    ...buildMainElements(),
    Footer(),
  ]);
}
```

Another common UI task is to include a specific element based on a condition. For example, you may want to include a *Next* button on all pages but the last one. With Dart 2.3, you can do this using a [*collection if*](https://dart.dev/guides/language/language-tour#collection-operators):

另一个常见的 UI 任务是根据条件包含某个特定元素。
例如，你可能想在除最后一页之外的所有页面上都放一个*下一步*按钮。
在 Dart 2.3 中，你可以用
[*集合 if*](https://dart.dev/guides/language/language-tour#collection-operators) 来做到：

```dart
Widget build(BuildContext context) {
  return Column(children: [
    Text(mainText),
    if (page != pages.last)
      FlatButton(child: Text('Next')),
  ]);
}
```

Finally, UIs often build repeated elements from other repeated elements. You can express this using the new [*collection for*](https://dart.dev/guides/language/language-tour#collection-operators) feature:

最后，UI 经常需要从其他重复元素构建出重复元素。
你可以用新的
[*集合 for*](https://dart.dev/guides/language/language-tour#collection-operators) 特性来表达：

```dart
Widget build(BuildContext context) {
  return Column(children: [
    Text(mainText),
    for (var section in sections)
      HeadingAction(section.heading),
  ]);
}
```

And because the three new features are language features, and not markup commands, they are fully composable, and can be used in any context where you work on collections. The features are included in the [Flutter 1.5](https://medium.com/flutter-io/announcing-flutter-1-5-d203c6072e5c) release, and are available in the [Dart 2.3](https://dart.dev/get-dart) release, which you can download today. We’ve also added new lints that you can [configure in static analysis](https://dart.dev/guides/language/analysis-options#enabling-linter-rules) to enforce using the new [spread](http://dart-lang.github.io/linter/lints/prefer_spread_collections.html), [collection if](http://dart-lang.github.io/linter/lints/prefer_if_elements_to_conditional_expressions.html), and [collection for](http://dart-lang.github.io/linter/lints/prefer_for_elements_to_map_fromIterable.html) features.

由于这三个新特性是语言特性，而不是标记命令，
它们可以完全组合使用，并且能用在任何操作集合的上下文中。
这些特性已包含在 [Flutter 1.5](https://medium.com/flutter-io/announcing-flutter-1-5-d203c6072e5c) 版本中，
也可在今天即可下载的 [Dart 2.3](https://dart.dev/get-dart) 版本中使用。
我们还新增了 lint 规则，你可以[在静态分析中配置](https://dart.dev/guides/language/analysis-options#enabling-linter-rules)，
以强制使用新的 [spread](http://dart-lang.github.io/linter/lints/prefer_spread_collections.html)、
[collection if](http://dart-lang.github.io/linter/lints/prefer_if_elements_to_conditional_expressions.html)
和 [collection for](http://dart-lang.github.io/linter/lints/prefer_for_elements_to_map_fromIterable.html) 特性。

For details on all the work that was done to add these features, check out [this recent post](/blog/making-dart-a-better-language-for-ui) from Bob Nystrom (aka [munificentbob](https://twitter.com/munificentbob)), an engineer on the Dart language team.

想了解为添加这些特性所做的全部工作，
请阅读 Dart 语言团队工程师 Bob Nystrom
（也就是 [munificentbob](https://twitter.com/munificentbob)）
最近发布的[这篇文章](/blog/making-dart-a-better-language-for-ui)。

We’d also like to extend our gratitude to the developers who participated in the UX studies that were critical in shaping these new language features.

我们还要向参与用户体验研究的开发者们致谢，
这些研究对塑造这些新语言特性至关重要。

## IDE & editor features

## IDE 与编辑器特性

In keeping with Dart 2.3’s UI theme, we’ve also added a new UI Guides feature to our IDE support. UI Guides are horizontal and vertical lines drawn within UI code, making it much easier to see the tree structure of Flutter UI build() methods. Here’s an example (from a Calculator app) where the UI Guides clearly illustrate that the UI is built from an Expanded Column containing several KeyRows, each of which contains NumberKeys.

与 Dart 2.3 的 UI 主题相呼应，我们还在 IDE 支持中
加入了新的 UI Guides 特性。UI Guides 是在 UI 代码中绘制的
水平线和垂直线，让你更容易看清 Flutter UI build() 方法的树状结构。
下面是一个例子（来自一个计算器应用），UI Guides 清晰地展示了
这个 UI 由一个 Expanded Column 构成，其中包含若干 KeyRow，
每个 KeyRow 又包含若干 NumberKey。

<DashImage src="images/1CsGJu4iSvHzspALjfbQRfA.webp" alt="IDE with Flutter UI Guides visualizing the tree structure of UI code." caption="IDE with UI Guides visualizing the tree structure of UI code" />


UI Guides are available in [version 35.2](https://plugins.jetbrains.com/plugin/9212-flutter) of the IntelliJ IDEA and Android Studio plugin. To enable the feature, choose the setting *Preferences &gt; Languages & Frameworks &gt; Flutter &gt; UI Guides*. We hope to offer similar support in VS Code in a later release.

UI Guides 已在 IntelliJ IDEA 和 Android Studio 插件的
[35.2 版本](https://plugins.jetbrains.com/plugin/9212-flutter)中提供。
要启用该特性，请选择设置
*Preferences &gt; Languages & Frameworks &gt; Flutter &gt; UI Guides*。
我们希望在后续版本中为 VS Code 提供类似支持。

Finally, we’ve observed that developers often use code completion in their IDE as a way of exploring APIs. Code completion has worked well for exploring the APIs in the libraries that you’ve already imported, but it hasn’t been available for APIs in libraries that aren’t yet imported. Our tools can now support the latter use case: you can invoke code completion on any prefix, and you’ll see completions for all APIs in the current package, the packages it directly depends on, and the SDK. If you choose a completion from a not-yet-imported library (marked *Auto import*, as the following animation shows), then the tool adds the import statement for you.

最后，我们观察到开发者经常把 IDE 中的代码补全
当作探索 API 的一种方式。对于你已经导入的库中的 API，
代码补全一直很好用，但对于尚未导入的库中的 API 则无法使用。
现在我们的工具可以支持后一种场景：你可以在任意前缀上调用代码补全，
就会看到当前 package、它直接依赖的 package 以及 SDK 中
所有 API 的补全建议。如果你选择了一个来自尚未导入的库的补全项
（标记为 *Auto import*，如下面的动画所示），工具会自动为你添加 import 语句。

<DashImage src="images/0fqBkEGgVtWMT1QRy.webp" alt="An animated GIF showing code completion and automatic import insertion in an IDE." caption="Animation showing code completion & automatic import adding" />


This new auto-import feature is available in VS Code with the [v2.26 plugin](https://dartcode.org/releases/v2-26/), in IntelliJ 2019.1, and the upcoming Android Studio 3.5 release.

这个新的自动导入特性已在 VS Code 的
[v2.26 插件](https://dartcode.org/releases/v2-26/)、IntelliJ 2019.1
以及即将发布的 Android Studio 3.5 中提供。

## New Dart & Pub websites

## 全新的 Dart 与 Pub 网站

Last, but certainly not least, we’ve been very busy the last few months building a new website for the Dart platform: [dart.dev](https://dart.dev)

最后但同样重要的是，过去几个月我们一直在忙着
为 Dart 平台构建一个新网站：[dart.dev](https://dart.dev)

<DashImage src="images/1ydTSALWV77UbB3WHKsy9cg.webp" alt="Redesigned dart.dev homepage." caption="Redesigned [https://dart.dev](https://dart.dev) homepage" />


This new site features an entirely new landing page, focused on explaining the core benefits of the Dart platform. We’ve also updated the documentation pages to have better navigation and more visual appeal. Lastly, we’ve done a huge reorganization of all content to make discovery easier, and added new pages for core content that was missing before.

这个新网站有一个全新的首页，专注于阐述 Dart 平台的核心优势。
我们还更新了文档页面，使其导航更清晰、视觉更美观。
最后，我们对所有内容做了大规模重组，让发现内容更容易，
并为此前缺失的核心内容新增了页面。

In a similar vein, we’ve visually updated the Pub package site, and we’ve moved it to a convenient new URL: [pub.dev](https://pub.dev).

同样地，我们对 Pub package 网站做了视觉更新，
并把它迁移到了一个方便的新网址：[pub.dev](https://pub.dev)。

We’d love to hear your feedback on both sites. If you find a problem or have a suggestion, please create an issue in the [dart.dev issue tracker](https://github.com/dart-lang/site-www/issues) or the [pub.dev issue tracker](https://github.com/dart-lang/pub-dartlang-dart/issues). Thanks for your support!

我们很想听听你对这两个网站的反馈。如果你发现问题或有建议，
请在 [dart.dev issue 跟踪器](https://github.com/dart-lang/site-www/issues)
或 [pub.dev issue 跟踪器](https://github.com/dart-lang/pub-dartlang-dart/issues)中创建 issue。
感谢你的支持！
