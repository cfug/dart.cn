---
# title: "Announcing Dart 3.7"
title: "宣布 Dart 3.7"
# description: "It’s a new year, and time for a new Dart stable release. Welcome to Dart 3.7!"
description: "新的一年，新的 Dart 稳定版。欢迎使用 Dart 3.7！"
ai-translated: true
publishDate: 2025-02-12
author: mbelanger
image: images/1tdCaUfGrIk42FIuu2qs9Yw.webp
category: releases
layout: blog
---


The theme for this release is *developer productivity*. We’ve made the Dart language more consistent by tweaking how it handles wildcard variables. There’s also a brand new style in the Dart formatter, new quick fixes and lints in the analyzer, and several cool new features on pub.dev. Let’s get into the details!

这个版本的主题是*开发者生产力*。我们调整了 Dart 处理
通配符变量（wildcard variables）的方式，让语言更一致。
Dart 格式化器有了全新风格，分析器新增了快速修复和 lint，
pub.dev 也有几项很酷的新特性。来看细节！

<DashImage src="images/1tdCaUfGrIk42FIuu2qs9Yw.webp" alt="Dart 3.7 release banner with the Dart logo and an animated bullseye icon." caption="Announcing Dart 3.7" />


## Macros update

## 宏（Macros）进展更新

We recently posted updates in the [issue tracker](https://github.com/dart-lang/language/issues/1482#issuecomment-2622895490), as well as a [blog post](/blog/an-update-on-dart-macros-data-serialization), stating that we’re stopping work on our experimental macros feature. We’d like to thank the community for being so understanding of this unfortunate outcome.

我们最近在 [issue 跟踪器](https://github.com/dart-lang/language/issues/1482#issuecomment-2622895490)
和一篇[博客文章](/blog/an-update-on-dart-macros-data-serialization)中
发布了更新，说明我们将停止实验性宏特性的工作。
感谢社区对这一遗憾结果的理解。

With this change, however, the team gains back some capacity to invest in other valuable developments. We’re already looking into [improvements to build_runner performance](https://github.com/dart-lang/build/issues/3800), we still expect to launch the [augmentations language feature](https://github.com/dart-lang/language/blob/main/working/augmentation-libraries/feature-specification.md) (perhaps in a slightly different form), and we hope to find new and more direct ways for supporting modeling data and handling [serialization and deserialization](https://github.com/dart-lang/language/issues/4232) (to and from JSON, for example).

不过，这一变化让团队重新腾出了一些精力，
投入其他有价值的开发。我们已经在研究
[build_runner 性能改进](https://github.com/dart-lang/build/issues/3800)；
我们仍计划推出
[augmentations 语言特性](https://github.com/dart-lang/language/blob/main/working/augmentation-libraries/feature-specification.md)
（可能形式略有不同）；我们也希望找到更新、更直接的方式
来支持数据建模以及处理
[序列化与反序列化](https://github.com/dart-lang/language/issues/4232)
（例如与 JSON 之间的转换）。

## Wildcard variables language feature

## 通配符变量语言特性

Local variables and parameters named `_` are now what functional languages call “wildcards”. This means the name is a placeholder and declares no actual variable.

名为 `_` 的局部变量和参数，现在就是函数式语言所说的
“通配符”（wildcards）。这意味着这个名字只是占位符，
并不声明实际的变量。

Currently in Dart, it’s common to use `_` as the name of a callback parameter if the body of the callback doesn’t actually need to use the argument, like so:

目前在 Dart 中，如果回调体实际上不需要使用某个参数，
常见做法是把回调参数命名为 `_`，像这样：

```dart
void announceCompletion(Future<void> future) {
  future.then((_) { // <--
    print('Complete!');
  });
}
```


But, if a callback has multiple parameters that you don’t need to use, you end up naming them `_`, `__`, `___`, etc., because otherwise the names collide. Now, in Dart 3.7, parameters and local variables named `_` don’t actually create a variable, so there is no possibility of name collision. You can use `_` for multiple parameters, as in:

但如果回调有多个你不需要的参数，你只能把它们命名为
`_`、`__`、`___` 等，否则名字会冲突。现在，在 Dart 3.7 中，
名为 `_` 的参数和局部变量不会真正创建变量，
因此不存在名字冲突的可能。你可以对多个参数都用 `_`，比如：

```dart
void announceFailure(Future<void> future) {
  future.onError((_, _) { // <--
    print('Error!');
  });
}
```


If you have code that declares a parameter or variable named `_` *and uses it*, that code will no longer work in Dart 3.7. For example:

如果你的代码声明了名为 `_` 的参数或变量*并且使用了它*，
这段代码在 Dart 3.7 中将不再有效。例如：

```dart
var [1, 2, 3].map((_) {
  return _.toString();
  //     ^ Error! Reference to unknown variable.
});
```


You’ll have to rename the parameter or local variable in this situation. This language change only applies to parameters and local variables (not top-level variables or members), so you can do this renaming without breaking your library’s public API.

这种情况下你必须重命名该参数或局部变量。
这项语言变更只适用于参数和局部变量
（不包括顶层变量或成员），所以你可以放心重命名，
不会破坏库的公共 API。

Wildcard variables are a small feature that make the language more consistent. Variables named `_` in [patterns](https://dart.dev/language/patterns) have always behaved this way:

通配符变量是个让语言更一致的小特性。
[patterns](https://dart.dev/language/patterns) 中名为 `_`
的变量一直就是这么表现的：

```dart
var [_, _, third, _, _] = [1, 2, 3, 4, 5];
print(third); // Prints "3".
```


Now parameters and local variables behave the same way.

现在参数和局部变量也有了同样的行为。

## New formatting style in the Dart formatter

## Dart 格式化器的新格式风格

Dart 3.7 includes a re-written Dart formatter (`dart format`) with a [new formatting style](https://github.com/dart-lang/dart_style/issues/1253). The new style looks similar to the style you get when you add trailing commas to argument lists, except now the formatter will add and remove those commas for you. For example:

Dart 3.7 包含重写的 Dart 格式化器（`dart format`），
带来[新的格式风格](https://github.com/dart-lang/dart_style/issues/1253)。
新风格看起来类似于你给参数列表加上尾随逗号后得到的风格，
只不过现在格式化器会替你添加和删除这些逗号。例如：

```dart
// Old style:
void writeArgumentList(
    Token leftBracket, List<AstNode> elements, Token rightBracket) {
  writeList(
      leftBracket: leftBracket,
      elements,
      rightBracket: rightBracket,
      allowBlockArgument: true);
}

// New style:
void writeArgumentList(
  Token leftBracket,
  List<AstNode> elements,
  Token rightBracket,
) {
  writeList(
    leftBracket: leftBracket,
    elements,
    rightBracket: rightBracket,
    allowBlockArgument: true,
  );
}
```


This is a large change both to the tool, the output it produces, and how it behaves. To make the transition as smooth as possible, the formatting style you get depends on the [language version](https://dart.dev/language/versioning) of the code you’re formatting. If the language version is 3.6 or earlier, the code is formatted with the old style. If it’s 3.7 or later, it gets the new style.

无论对工具本身、它产生的输出还是它的行为，这都是一次大变更。
为了让过渡尽可能平滑，你得到的格式风格取决于所格式化代码的
[语言版本](https://dart.dev/language/versioning)。
语言版本是 3.6 或更早，代码按旧风格格式化；
是 3.7 或更晚，则使用新风格。

When you upgrade your package to use Dart 3.7 by bumping the SDK constraint in your package’s pubspec (and running `dart pub get`!), you are opting in to the new formatting style.

当你提升 package 的 pubspec 中的 SDK 约束
（并运行 `dart pub get`！）升级到 Dart 3.7 时，
你就选择了启用新格式风格。

To determine the language version of each file it formats, `dart format` looks for a `package_config.json`. This means that **you need to run `dart pub get` before formatting code in your package**. If you have format checks in your continuous integration server, make sure it runs `dart pub get`, too.

为了确定所格式化的每个文件的语言版本，
`dart format` 会查找 `package_config.json`。这意味着
**在格式化 package 中的代码之前，你需要先运行 `dart pub get`**。
如果你的持续集成服务器上有格式检查，也要确保它运行
`dart pub get`。

We don’t intend to support both styles indefinitely. At some point in the future, when most of the ecosystem is on 3.7 or later, support for the old style will be removed.

我们不打算无限期地同时支持两种风格。
将来某个时间点，当生态大多升级到 3.7 或更晚时，
对旧风格的支持就会被移除。

The new style includes some long-requested features:

新风格包含一些大家期盼已久的特性：

* **Project-wide page width configuration.** You can now configure your preferred formatting page width on a project-wide basis in your `analysis_options.yaml` file, like so:

  **项目级页宽配置。**现在你可以在 `analysis_options.yaml`
  文件中按项目配置你偏好的格式化页宽，像这样：

```yaml
    formatter:
      page_width: 123
```


* **Opting out a region of code from formatting.** You can use a pair of special marker comments to opt a region of code out of automated formatting:

  **让一段代码退出格式化。**你可以用一对特殊标记注释，
  让某段代码不参与自动格式化：

```dart
    main() {
      // dart format off
      no   +   formatting     +     here;
      // dart format on
    }
```


There is one **breaking change** as well. The formatter no longer supports `dart format --fix`. Instead, use `dart fix` to apply all the fixes that `dart format` could, and more.

还有一项**破坏性变更**：格式化器不再支持
`dart format --fix`。请改用 `dart fix`，
它能应用 `dart format` 原本能做的所有修复，而且更多。

You can find more details in the [CHANGELOG](https://github.com/dart-lang/dart_style/blob/cea5a1a3e974c5065e6f4cc19b2838cd62448f0a/CHANGELOG.md#300) and [FAQ](https://github.com/dart-lang/dart_style/wiki/FAQ).

更多细节请查看
[CHANGELOG](https://github.com/dart-lang/dart_style/blob/cea5a1a3e974c5065e6f4cc19b2838cd62448f0a/CHANGELOG.md#300)
和 [FAQ](https://github.com/dart-lang/dart_style/wiki/FAQ)。

## Updated quick fixes and new lints in the Dart analyzer

## Dart 分析器更新的快速修复与新 lint

We’re always actively improving Dart to boost developer productivity, and that means improving the analyzer with new lints, quick fixes, and assists in Dart 3.7. One notable addition is the `unnecessary_underscores` lint, which supports the new wildcard variable feature.

我们一直在积极改进 Dart 以提升开发者生产力，
这意味着在 Dart 3.7 中为分析器带来新的 lint、
快速修复和辅助操作（assists）。一个值得注意的新增是
`unnecessary_underscores` lint，它配合新的通配符变量特性。

Among the wide range of new quick fixes and assists Dart 3.7 includes are fixes for common issues like missing `await` keywords, incorrect import prefixes, and violations of lint rules like `cascade_invocations`. There are also handy assists for refactoring code, such as converting `else` blocks to `else if` and wrapping Flutter widgets with `Expanded` or `Flexible`.

Dart 3.7 包含的大量新快速修复和辅助操作中，
有针对常见问题的修复，比如缺少 `await` 关键字、
错误的 import 前缀，以及违反 `cascade_invocations`
等 lint 规则的情况。还有便于重构代码的实用辅助操作，
比如把 `else` 块转换为 `else if`，
以及用 `Expanded` 或 `Flexible` 包裹 Flutter widget。

You can find more details about all of these, and much more, in the full list of [analyzer changes](https://github.com/dart-lang/sdk/blob/master/CHANGELOG.md#analyzer-1).

关于所有这些以及更多内容，请查看完整的
[分析器变更列表](https://github.com/dart-lang/sdk/blob/master/CHANGELOG.md#analyzer-1)。

## Moving forward on the Dart web platform

## Dart Web 平台继续前进

A year ago, we introduced [new libraries and packages](/blog/new-in-dart-3-3-extension-types-javascript-interop-and-more) for interoperating with JavaScript and browser APIs from Dart. Going forward, the primary JavaScript library is [`dart:js_interop`](https://api.dart.dev/dart-js_interop/dart-js_interop-library.html). For browser APIs, use [`package:web`](https://pub.dev/packages/web).

一年前，我们引入了
[新的库和 package](/blog/new-in-dart-3-3-extension-types-javascript-interop-and-more)，
用于从 Dart 与 JavaScript 和浏览器 API 互操作。
今后，主要的 JavaScript 库是
[`dart:js_interop`](https://api.dart.dev/dart-js_interop/dart-js_interop-library.html)。
浏览器 API 请使用 [`package:web`](https://pub.dev/packages/web)。

As part of our continued effort to move the Dart and Flutter ecosystems to WebAssembly-compatible APIs, we are deprecating the associated legacy APIs in the Dart SDK. Seven Dart SDK libraries are deprecated in the Dart 3.7 release:

作为持续推动 Dart 和 Flutter 生态迁移到
WebAssembly 兼容 API 的一部分，我们正在废弃 Dart SDK
中相关的遗留 API。Dart 3.7 版本废弃了七个 Dart SDK 库：

* `dart:html`

* `dart:indexed_db`

* `dart:js`

* `dart:js_util`

* `dart:web_audio`

* `dart:web_gl`

We plan to remove these libraries at the end of 2025. You can learn about their replacements on the [JavaScript interoperability page](https://dart.dev/interop/js-interop).

我们计划在 2025 年底移除这些库。你可以在
[JavaScript 互操作页面](https://dart.dev/interop/js-interop)
了解它们的替代方案。

## New productivity features on the pub.dev package site

## pub.dev package 站点的新生产力特性

In December we launched [download counts for packages](/blog/announcing-dart-3-6) on pub.dev. These show monthly downloads along with a small chart showing weekly downloads over time.

去年 12 月，我们在 pub.dev 上推出了
[package 下载计数](/blog/announcing-dart-3-6)。
它展示每月下载量，并附带一张显示每周下载量随时间变化的
小图表。

Today, we are extending that with support for viewing download counts per package version. It’s now possible to get an indication of how many consumers of a package have upgraded to the latest version (or just the latest major version). These insights are meant to help package authors gauge the value of back-porting fixes to older major versions of a package.

今天，我们进一步支持按 package 版本查看下载计数。
现在你可以大致了解有多少 package 使用者升级到了最新版本
（或只是最新的主版本）。这些洞察旨在帮助 package 作者
评估把修复回迁（back-port）到旧主版本的价值。

<DashImage src="images/067af_RLHqiWxsXXL.webp" alt="Chart showing weekly downloads for a specific package version." caption="Weekly downloads chart, with versions separated" />


<DashImage src="images/0Cctb0O4F1D-0YYHY.webp" alt="Another chart showing weekly downloads but stacked by version." caption="Weekly downloads chart, with versions stacked" />


**Dark mode for pub.dev**

**pub.dev 深色模式**

Dark mode for pub.dev has long been a [popular request](https://github.com/dart-lang/pub-dev/issues/4416), and as of today it’s now possible to toggle pub.dev to dark mode. This toggle affects both package pages and package API documentation hosted on pub.dev.

pub.dev 的深色模式一直是[热门请求](https://github.com/dart-lang/pub-dev/issues/4416)，
从今天起你可以把 pub.dev 切换到深色模式了。
这个开关同时作用于 package 页面和托管在 pub.dev 上的
package API 文档。

<DashImage src="images/0j4Vh_XoLle5-RMQ2.webp" alt="Screenshot showing the dark mode toggle and UI on pub.dev." caption="Dark mode for pub.dev" />


**Topics for pub.dev**

**pub.dev 主题标签（Topics）**

Last year, we launched support for [topics](https://pub.dev/topics) on pub.dev. You can [add topics](https://dart.dev/tools/pub/pubspec#topics) to your `pubspec.yaml`, and if you see related topics that should be merged you can propose [canonicalization](https://github.com/dart-lang/pub-dev/blob/master/doc/topics.yaml) with a pull request.

去年，我们在 pub.dev 上推出了对[主题标签](https://pub.dev/topics)
的支持。你可以在 `pubspec.yaml` 中
[添加主题标签](https://dart.dev/tools/pub/pubspec#topics)；
如果你发现应该合并的相关主题标签，
可以通过 pull request 提议
[规范化](https://github.com/dart-lang/pub-dev/blob/master/doc/topics.yaml)。

Users browsing pub.dev can click on topics to browse related packages. We previously introduced the ability to search for topics on pub.dev, using [search keywords](https://pub.dev/help/search) (like “topic:widget”), but finding these keywords has not always been easy. So, we’ve launched an IDE-like auto-completer for search keywords on pub.dev. You can trigger it by pressing ctrl+space, or automatically trigger it when you type a matching prefix like “topic:” or “license:”.

浏览 pub.dev 的用户可以点击主题标签来浏览相关 package。
我们之前引入了用[搜索关键字](https://pub.dev/help/search)
（如 “topic:widget”）在 pub.dev 上搜索主题标签的能力，
但找到这些关键字并不总是容易。所以，我们为 pub.dev
的搜索关键字推出了类似 IDE 的自动补全器。
你可以按 ctrl+space 触发它，
或在输入 “topic:” 或 “license:” 等匹配前缀时自动触发。

<DashImage src="images/0kd0l2oZq_mg9g8YO.webp" alt="Screenshot showing the IDE-like auto-completer for search keywords on pub.dev." caption="Topics search keywords" />


## Wrap up

## 总结

That’s all we have today for Dart 3.7. As always, please let us know what you think! And don’t forget to check out the blog post for today’s [Flutter 3.29 release]({{site.flutter-blog}}/whats-new-in-flutter-3-29) as well. See you next time!

以上就是今天 Dart 3.7 的全部内容。一如既往，
请告诉我们你的想法！也别忘了看看今天
[Flutter 3.29 发布]({{site.flutter-blog}}/whats-new-in-flutter-3-29)
的博客文章。下次见！
