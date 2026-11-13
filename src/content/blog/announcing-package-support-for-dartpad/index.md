---
# title: "Announcing package support for DartPad"
title: "宣布 DartPad 支持 package"
# description: "Create robust code snippets with popular packages in DartPad"
description: "在 DartPad 中用热门 package 创建健壮的代码片段"
ai-translated: true
publishDate: 2021-11-15
author: zoeyfan
image: images/05iMRgkKlQGK6fJx3.webp
category: announcements
layout: blog
---


Today we’re excited to announce that package support is now available in [DartPad](https://github.com/dart-lang/dart-pad)! DartPad is the open-sourced, web-based playground that runs Dart and Flutter apps directly in your web browser. It allows you to quickly run Dart code to test an idea or code up a technical concept without needing to install the Flutter SDK or any tools on your local system.

今天我们很高兴地宣布，[DartPad](https://github.com/dart-lang/dart-pad) 现已支持 package！DartPad 是一个开源的 Web 演练场，可以直接在浏览器中运行 Dart 和 Flutter 应用。它让你无需在本地安装 Flutter SDK 或任何工具，就能快速运行 Dart 代码来验证想法或编写技术概念代码。

Since the launch of DartPad, one of the [most popular requests](https://github.com/dart-lang/dart-pad/issues/901) has been to add support for importing packages, such as [Google Fonts](https://pub.dev/packages/google_fonts) or [Firebase Authentication](https://pub.dev/packages/firebase_auth), directly in DartPad’s editor. In this first phase of rollout, you can import from a set of popular packages.

自 DartPad 发布以来，[呼声最高的请求](https://github.com/dart-lang/dart-pad/issues/901)之一就是支持在 DartPad 编辑器中直接导入 package，例如 [Google Fonts](https://pub.dev/packages/google_fonts) 或 [Firebase Authentication](https://pub.dev/packages/firebase_auth)。在第一阶段的推出中，你可以导入一组热门 package。

To help you get started, we’ve created several new examples that you can find using DartPad’s **Samples** menu.

为了帮助你上手，我们创建了几个新示例，可以通过 DartPad 的 **Samples** 菜单找到。

## Google Fonts example

## Google Fonts 示例

Start using a package by adding an import statement for it at the top of the code editor. For example, to use the Google Fonts package, add this:

在代码编辑器顶部添加 import 语句即可开始使用 package。例如，要使用 Google Fonts package，添加这行：

`import 'package:google_fonts/google_fonts.dart';`

DartPad handles the pubspec details for you, so all you need is the import statement. You can use suggested completions to change fonts and then rerun the app, just like you would in an IDE.

DartPad 会替你处理 pubspec 细节，所以你只需要 import 语句。你可以用补全建议更换字体然后重新运行应用，就像在 IDE 里一样。

<DashImage src="images/05iMRgkKlQGK6fJx3.webp" alt="DartPad example using the google_fonts package." />


## How package support works

## package 支持的工作原理

Here’s a quick overview of how package support works in DartPad. The DartPad server takes the set of supported packages and uses `**flutter pub get**` to fetch the latest compatible version of each package. Then the server uses these package versions during analysis and compilation of your DartPad script.

下面快速介绍一下 DartPad 中 package 支持的工作原理。DartPad 服务器拿到受支持的 package 集合，用 `flutter pub get` 获取每个 package 的最新兼容版本。然后服务器在分析和编译你的 DartPad 脚本时使用这些 package 版本。

This release also supports the most popular Firebase packages, so you can access a suite of backend services without ever leaving DartPad. All necessary Firebase JavaScript SDKs are loaded into the output panel before running the compiled app.

这个版本还支持最热门的 Firebase package，让你不离开 DartPad 就能使用一整套后端服务。运行编译后的应用之前，所有必需的 Firebase JavaScript SDK 都会被加载到输出面板中。

Here’s a [simple chat app](https://dartpad.dev/?id=d57c6c898dabb8c6fb41018588b8cf73&null_safety=true) that uses Firebase:

这是一个使用 Firebase 的[简单聊天应用](https://dartpad.dev/?id=d57c6c898dabb8c6fb41018588b8cf73&null_safety=true)：

<DashImage src="images/05QSzuPZeeo3tb0R1.webp" alt="Basic chat app built with Firebase in DartPad." />


This multi-user chat app is implemented with only client-side Dart code running (and written) in the browser, and uses the Firestore database to share messages between users. While it might seem dangerous to open your database directly to users, it’s actually secured by only allowing chat messages that use a very specific set of words. Read the comments in [the code](https://gist.github.com/flutterdevrelgists/d57c6c898dabb8c6fb41018588b8cf73) to learn more about how it works.

这个多用户聊天应用完全由在浏览器中运行（且编写）的客户端 Dart 代码实现，并使用 Firestore 数据库在用户之间共享消息。把数据库直接开放给用户看似危险，但实际上它通过只允许使用一组特定词汇的聊天消息来保证安全。阅读[代码](https://gist.github.com/flutterdevrelgists/d57c6c898dabb8c6fb41018588b8cf73)中的注释可以了解它的工作原理。

To expand the chat app, you could implement sign-in to identify who said what by adding Firebase Authentication. We plan to add many more Firebase features to expand what you can do with Firebase in DartPad.

要扩展这个聊天应用，你可以添加 Firebase Authentication 实现登录，从而识别谁说了什么。我们计划添加更多 Firebase 特性，扩展你在 DartPad 中能用 Firebase 做的事情。

## Supported packages

## 受支持的 package

This first phase of the rollout supports a defined set of popular packages. To see what packages are available (and in what version), click the info icon at the lower right corner of the screen.

第一阶段的推出支持一组确定的热门 package。要查看可用的 package（及其版本），点击屏幕右下角的信息图标。

<DashImage src="images/0GiZCsPVISutlBMSG.webp" alt="A screenshot showing the info icon in DartPad that lists available packages." />


## Give it a try!

## 来试试吧！

Give DartPad package support a try today on [dartpad.dev](https://dartpad.dev), and share any [feedback](https://github.com/dart-lang/dart-pad/issues) with our team. We’ll continue to expand the list of supported packages over time. If you have any preference regarding which packages you’d like to see added, [search for the issue](https://github.com/dart-lang/dart-pad/issues) that contains the desired package name, and give it a 👍 “thumbs up” reaction. If there’s no issue for the package you want, please [create an issue](https://github.com/dart-lang/dart-pad/issues/new?template=everything-else.md) and put the package name in the title.

今天就在 [dartpad.dev](https://dartpad.dev) 上试试 DartPad 的 package 支持，并把任何[反馈](https://github.com/dart-lang/dart-pad/issues)分享给我们的团队。我们会持续扩充受支持的 package 列表。如果你有希望添加的 package，请[搜索包含该 package 名称的 issue](https://github.com/dart-lang/dart-pad/issues) 并点一个 👍。如果你想要的 package 还没有对应 issue，请[创建 issue](https://github.com/dart-lang/dart-pad/issues/new?template=everything-else.md) 并把 package 名称写进标题。

We hope package support on DartPad empowers you to build and showcase your Flutter designs, ideas, vignettes, and more. We can’t wait to see what you build next!

我们希望 DartPad 的 package 支持能帮助你构建和展示你的 Flutter 设计、想法、小作品等等。迫不及待想看到你的下一个作品！
