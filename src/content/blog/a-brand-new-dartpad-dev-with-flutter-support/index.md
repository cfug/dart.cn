---
# title: "A brand new DartPad.dev with Flutter support"
title: "全新的 DartPad.dev，支持 Flutter"
# description: "Today, we’re announcing a major upgrade of DartPad.dev with a fresh new look-and-feel and support for the popular Flutter UI toolkit."
description: "今天我们宣布 DartPad.dev 重大升级：焕然一新的外观，并支持广受欢迎的 Flutter UI 工具包。"
ai-translated: true
publishDate: 2019-12-04
author: johnpryan
image: images/1X7Sild_wdEFGRYaSk2C3Og.webp
category: announcements
layout: blog
---


Today we’re announcing a major upgrade of [DartPad.dev](https://dartpad.dev) with a fresh new look-and-feel and support for the popular [Flutter](https://flutter.dev/) UI toolkit. DartPad is our online editor that runs Dart programs directly in your browser, and now it runs Flutter apps too.

今天我们宣布 [DartPad.dev](https://dartpad.dev) 的重大升级：焕然一新的外观，并支持广受欢迎的 [Flutter](https://flutter.dev/) UI 工具包。DartPad 是我们的在线编辑器，可以直接在浏览器中运行 Dart 程序，现在它也能运行 Flutter 应用了。

<DashImage src="images/1X7Sild_wdEFGRYaSk2C3Og.webp" alt="The DartPad interface running a Flutter application." />


## Make something today

## 今天就动手做点什么

To create a new Flutter project, click the **New Pad** button and choose **Flutter**.

要创建新的 Flutter 项目，点击 **New Pad** 按钮并选择 **Flutter**。

<DashImage src="images/1Sd404nMeJmYEgbPpE7HN7g.webp" alt="An animation showing how to create a new Flutter project in DartPad." />


This adds some starter code to the editor and runs it. Any time that DartPad sees that you’re using `package:flutter`, a panel comes up to display the UI. Or use the **Samples** menu to find a Flutter sample.

这会在编辑器中加入一些初始代码并运行。只要 DartPad 发现你在使用 `package:flutter`，就会弹出一个面板来显示 UI。也可以用 **Samples** 菜单找一个 Flutter 示例。

<DashImage src="images/1CONdjdCgZJH6oN7B4tjA5w.webp" alt="The DartPad samples menu displaying various Dart and Flutter examples." />


## Features

## 功能

All of Flutter’s core libraries, like [cupertino](https://api.flutter.dev/flutter/cupertino/cupertino-library.html) and [material](https://api.flutter.dev/flutter/material/material-library.html), are available to use, and DartPad can display their documentation. Select a symbol to see the documentation in the bottom panel.

Flutter 的所有核心库，如 [cupertino](https://api.flutter.dev/flutter/cupertino/cupertino-library.html) 和 [material](https://api.flutter.dev/flutter/material/material-library.html)，都可以使用，DartPad 还能显示它们的文档。选中一个符号即可在底部面板查看文档。

<DashImage src="images/1pjBKPqejQhVga2yXYWWigw.webp" alt="An animation showing documentation for the AppBar widget displayed in DartPad's bottom panel." />


DartPad formats code using the Dart formatter ([dartfmt](https://github.com/dart-lang/dart_style)), offers assists, provides fixes, suggests auto-completions, and shows errors and warnings.

DartPad 使用 Dart 格式化器（[dartfmt](https://github.com/dart-lang/dart_style)）格式化代码，提供辅助操作和修复建议、自动补全，并显示错误和警告。

<DashImage src="images/1f-DNPnkA6gB5wkT_TVVpSQ.webp" alt="An animation of DartPad's code completion and code assist support." />


When you’re ready to share your snippet, you can [create a GitHub gist](https://help.github.com/en/github/writing-on-github/creating-gists) and put the gist ID in a URL like this: `https://dartpad.dev/&lt;GistID&gt;`. You can share this link in a bug report, in a StackOverflow question, or on your social media platform of choice. Check out the [sharing guide](https://github.com/dart-lang/dart-pad/wiki/Sharing-Guide) for more details.

当你想分享代码片段时，可以[创建一个 GitHub gist](https://help.github.com/en/github/writing-on-github/creating-gists)，然后把 gist ID 放进这样的 URL：`https://dartpad.dev/&lt;GistID&gt;`。你可以把这个链接分享到 bug 报告、StackOverflow 问题或你喜欢的社交媒体平台。更多细节请参阅[分享指南](https://github.com/dart-lang/dart-pad/wiki/Sharing-Guide)。

You can also embed DartPad into a page, [like in this codelab](https://flutter.dev/docs/codelabs/layout-basics). Embedded DartPads are especially good for articles, codelabs, and tutorials. (Check out [this guide](https://dart.dev/resources/dartpad-tutorials.pdf) if you’re interested in using DartPad in codelabs and tutorials.) To learn more about adding DartPad to a page, check out the [embedding guide](https://github.com/dart-lang/dart-pad/wiki/Embedding-Guide).

你还可以把 DartPad 嵌入页面，[就像这个 codelab 一样](https://flutter.dev/docs/codelabs/layout-basics)。嵌入式 DartPad 特别适合文章、codelab 和教程。（如果你想在 codelab 和教程中使用 DartPad，请参阅[这份指南](https://dart.dev/resources/dartpad-tutorials.pdf)。）要了解如何把 DartPad 加入页面，请查看[嵌入指南](https://github.com/dart-lang/dart-pad/wiki/Embedding-Guide)。

## Thanks!

## 致谢！

DartPad is part of the Dart [open-source project](https://github.com/dart-lang). If you’ve filed [issues](https://github.com/dart-lang/dart-pad/issues) or submitted changes to DartPad, thank you for making it better. If you’d like to contribute, get started at [github.com/dart-lang/dart-pad](https://github.com/dart-lang/dart-pad). To learn more about running Flutter on the web, visit [flutter.dev/web](https://flutter.dev/web).

DartPad 是 Dart [开源项目](https://github.com/dart-lang)的一部分。如果你提过 [issue](https://github.com/dart-lang/dart-pad/issues) 或为 DartPad 提交过改动，感谢你让它变得更好。如果你想参与贡献，请从 [github.com/dart-lang/dart-pad](https://github.com/dart-lang/dart-pad) 开始。要进一步了解在 Web 上运行 Flutter，请访问 [flutter.dev/web](https://flutter.dev/web)。

We can’t wait to see what you build!

我们迫不及待想看到你的作品！
