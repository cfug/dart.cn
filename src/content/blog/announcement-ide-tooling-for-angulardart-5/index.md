---
# title: "Announcement: IDE Tooling for AngularDart 5"
title: "公告：AngularDart 5 的 IDE 工具"
# description: "Dart is a statically typed language which we know and love, and Dart 2 will be even more strictly typed. That is why it makes such a great…"
description: "Dart 是我们熟悉且喜爱的静态类型语言，Dart 2 的类型将更加严格。正因如此，它是……"
ai-translated: true
publishDate: 2018-03-27
author: mfairhurst
image: images/1_8_-jlg2S62p_a8plKAtgg.webp
category: announcements
layout: blog
---


<DashImage src="images/1ZrNw6Wd0ZqQibsfXS8Gsng.webp" alt="IDE showing an AngularDart HTML template with diagnostics." />


Dart is a statically typed language which we know and love, and Dart 2 will be even more strictly typed. That is why it makes such a great platform for the Angular framework, where components are mostly statically linked together in templates to create performant UIs.

Dart 是我们熟悉且喜爱的静态类型语言，而 Dart 2 的类型会更加严格。
正因如此，它是 Angular 框架的绝佳平台——
在 Angular 中，组件大多在模板中静态地链接在一起，
从而构建出高性能的 UI。

So, to further improve this productive and safe developer experience, we are announcing new IDE tools for preserving that type-safety inside your templates! It supports AngularDart 5, and works out of the box with IntelliJ/WebStorm. It can also be configured to work in VSCode, vim, and more.

因此，为了进一步提升这种高效又安全的开发体验，
我们宣布推出全新的 IDE 工具，让类型安全（type-safety）在模板内部也得以保持！
它支持 AngularDart 5，在 IntelliJ/WebStorm 中开箱即用，
也可以配置后在 VSCode、vim 等编辑器中使用。

You can skip straight to [setup](#how-to-use) now if you’re already sold, or follow along for a tour of what our new IDE integration offers you!

如果你已经心动了，现在就可以直接跳到[设置](#how-to-use)部分；
或者继续往下读，看看我们新的 IDE 集成都能为你提供什么！

## Errors

## 错误检查

The new analysis plugin will find many type errors inside your templates for you. Expressions are validated against the directives you use, the inputs they contain, and the references you bind (`#foo`, `let item of`, …).

新的分析插件会帮你找出模板中的许多类型错误。
表达式会根据你使用的指令、指令包含的输入，
以及你绑定的引用（`#foo`、`let item of` 等）进行校验。

Here’s a misspelled member, so you don’t have to play human-spellchecker!

这里是一个拼错的成员——你不用再充当人肉拼写检查器了！

<DashImage src="images/0Ia1RMoPF9nmaAsIJ.webp" alt="Template diagnostic for the misspelled length getter in an IDE." />


And mismatched types on a component input are no longer a problem either.

组件输入上的类型不匹配也不再是问题。

<DashImage src="images/0LJKT0LftQFRjuKaN.webp" alt="IDE showing an error for mismatched types on a component input." />


We can also give you errors related to `$event` variable types,

我们还能给出与 `$event` 变量类型相关的错误，

<DashImage src="images/04UKHl3KVHtpV6Ysx.webp" alt="KeyboardEvent diagnostic for a misspelled event property in an IDE." />


And we check the content you transclude inside your directives. This is one example of where we catch not only type errors but also dead code.

我们还会检查你嵌入（transclude）到指令内部的内容。
这个例子展示了我们不仅能捕获类型错误，还能捕获死代码（dead code）。

<DashImage src="images/02nWPvm2BGmt1SGMZ.webp" alt="IDE showing an error for transcluded content inside a directive." />


And we could go on! We catch a slew of other types of errors, both in templates, and component definitions.

这样的例子还可以继续列下去！
无论在模板中还是在组件定义中，我们都能捕获大量其他类型的错误。

In addition to being highlighted in your editor, the full listing of errors is displayed in the Dart Analysis panel.

除了在编辑器中高亮显示之外，
完整的错误列表还会显示在 Dart Analysis 面板中。

<DashImage src="images/1u34uyVu2qy_7p1xfxHFnCA.webp" alt="The Dart Analysis panel in an IDE showing 2 errors and 5 warnings, including 'Expected element decorator after whitespace'." />


## Autocomplete

## 自动补全

We didn’t just stop at validation! While much of the work was getting our analysis to be performant and fully well-behaved in regards to the compiler, much of the value comes from using that resolved template state to deliver you the goodness of regular Dart autocompletion in your templates:

我们并没有止步于校验！
虽然大量工作都花在让分析既高效、又与编译器的行为完全一致上，
但很大一部分价值在于：利用解析后的模板状态，
让你在模板中也能享受常规 Dart 自动补全（autocompletion）的便利：

<DashImage src="images/1Qh5P6t4ccwezdMLWjAWw9Q.webp" alt="IDE showing code completion for list methods in a template." />


But we can complete more than regular Dart members — how about inputs, outputs, and HTML tags?

但我们能补全的不只是常规 Dart 成员——输入、输出和 HTML 标签怎么样？

Tags? Check.

标签？没问题。

<DashImage src="images/1d3wuZHY5Ja52fe00u2jgSQ.webp" alt="IDE showing autocompletion for HTML tags." />


Attributes? Check.

属性？没问题。

<DashImage src="images/1UlT5D-O_rajaFS_MCyHWsA.webp" alt="IDE showing code completion for HTML attributes such as title bindings and abort events in a template." />


Stars? Check.

星号（star）语法？没问题。

<DashImage src="images/13QMba2E4BETXmoi-5bG6gQ.webp" alt="IDE showing code completion for AngularDart structural directives such as ngFor and ngIf in a template." />


Attributes within stars? Check.

星号语法内部的属性？也没问题。

<DashImage src="images/1Ep9sEzWfe9Kife8HyMjvKw.webp" alt="An IDE showing code completion for template inputs like 'template:' and 'trackBy:'." />


Bonus points: Suggested tags *with* attributes within component transclusions!

额外加分：在组件嵌入内容中，连标签*带*属性一起给出建议！

<DashImage src="images/1_8_-jlg2S62p_a8plKAtgg.webp" alt="IDE showing suggested tags with attributes inside component transclusions." />


*Transclusions are a famously advanced topic within angular, so if you think you know what exactly it is that we’re suggesting, pat yourself on the back for knowing AngularDart very well.*

*嵌入（transclusion）在 Angular 中是出了名的高级话题，
所以如果你认为自己确切知道我们在建议什么，
那就拍拍自己的肩膀吧——说明你对 AngularDart 非常了解。*

Suffice it to say, component APIs are much easier to follow when using our plugin!

一句话：使用我们的插件后，组件 API 用起来容易多了！

## Navigation

## 导航

Support here varies a lot more by editor, but within IntelliJ you can click through parts of Dart expressions. In other editors you may be able to navigate on even more entities such as tags and inputs/outputs.

这方面的支持因编辑器而异，差别更大，
但在 IntelliJ 中，你可以点击跳转 Dart 表达式的某些部分。
在其他编辑器中，你也许能在更多实体上导航，
例如标签和输入/输出。

<DashImage src="images/1ceQlGeSCVnfOJqtHEITljQ.webp" alt="IDE showing template expression navigation to relevant definitions." />


## How To Use

## 如何使用

Make sure you are using an AngularDart 5 beta release, and Dart 2.0.0-dev.31 or newer.

请确保你使用的是 AngularDart 5 的 beta 版本，
以及 Dart 2.0.0-dev.31 或更新版本。

Simply add this to your [analysis_options.yaml](https://www.dartlang.org/guides/language/analysis-options#the-analysis-options-file) file:

只需把下面这段添加到你的 [analysis_options.yaml](https://www.dartlang.org/guides/language/analysis-options#the-analysis-options-file) 文件中：

```
analyzer:
  plugins:
    - angular
```


And restart your IDE. Note, it may take a few seconds to spin up the plugin. It will first have to download sources & dependencies for you, and the first analysis will be slower than subsequent ones.

然后重启 IDE。注意，插件启动可能需要几秒钟。
它首先要为你下载源码和依赖，
所以第一次分析会比之后的分析慢一些。

You can also play around with it in our [analyzer plugin demo project](https://github.com/MichaelRFairhurst/dartconf-angular-plugin-lightning-demo).

你也可以在我们的[分析器插件演示项目](https://github.com/MichaelRFairhurst/dartconf-angular-plugin-lightning-demo)中体验它。

If you are using IntelliJ, this should be all you have to do. For other editors, they may not run our plugin on HTML without extra work — for instance, VSCode requires [a flag](https://github.com/Dart-Code/Dart-Code/issues/396#issuecomment-366058798).

如果你用的是 IntelliJ，要做应该就是这些了。
对于其他编辑器，不做额外配置的话，它们可能不会在 HTML 上运行我们的插件——
例如，VSCode 需要设置[一个标志](https://github.com/Dart-Code/Dart-Code/issues/396#issuecomment-366058798)。

## Feedback & More

## 反馈与更多

Our plugins source code lives [on Github](https://github.com/dart-lang/angular_analyzer_plugin), which has more information on what’s supported and where you can file issues if you have questions or come across any bugs.

我们的插件源码托管在 [GitHub](https://github.com/dart-lang/angular_analyzer_plugin) 上，
那里有关于支持范围的更多信息；
如果你有疑问或遇到任何 bug，也可以在那里提交 issue。

The new IDE tooling will be part of the next stable release of AngularDart (v5). We’re very excited to offer you even better productivity as you write your Angular web apps!

新的 IDE 工具将随 AngularDart 的下一个稳定版本（v5）一起发布。
我们非常兴奋，能让你在编写 Angular Web 应用时拥有更高的效率！
