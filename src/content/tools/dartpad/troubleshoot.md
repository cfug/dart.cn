---
# title: Troubleshooting DartPad
title: DartPad 问题排查
# breadcrumb: Troubleshooting
breadcrumb: 问题排查
# description: Common problems with using DartPad
description: 在使用 DartPad 时的常见问题
ai-translated: true
---

This page describes solutions to problems that might occur when
you're trying to use DartPad, whether at [dartpad.dev]({{site.dartpad}})
or in a page that has embedded DartPads.
For an overview of DartPad, see the
[DartPad page](/tools/dartpad).

本页说明使用 DartPad 时可能遇到的问题及解决办法，
无论是在 [dartpad.dev]({{site.dartpad}})，
还是在嵌入了 DartPad 的页面上。
DartPad 的概览见
[DartPad 页面](/tools/dartpad)。


## Embedded DartPads don't appear

## 嵌入的 DartPad 没有出现

The dart.dev homepage and many tutorials have embedded DartPads.
If these DartPads don't appear at all,
then try the following:

dart.dev 首页和许多教程都嵌入了 DartPad。
如果这些 DartPad 完全没有出现，
请尝试下列办法：

* Make sure you're using one of the latest two versions of Chrome,
  Edge, Firefox, or Safari.
  DartPad might not work in other browsers, and is known not to work in
  the default configuration of the Brave browser.

  请确认使用的是 Chrome、Edge、Firefox 或 Safari 最新的两个版本之一。
  DartPad 在其他浏览器中可能无法工作，
  并且已知在 Brave 浏览器的默认配置下无法工作。

* If you're using an ad blocker, disable it.

  如果使用了广告拦截器，请将其停用。

* Check whether you've disabled third-party
  tracking cookies ([Chrome instructions][chrome-cookies]).
  If you've disabled cookies, change your settings to
  **allow cookies for dartpad.dev**.
  If you're using embedded DartPads,
  such as in the [Dart cheatsheet](/resources/dart-cheatsheet) or the
  [implicit animations codelab]({{site.flutter-docs}}/codelabs/implicit-animations),
  you might need to allow cookies for the embedding site domain, as well
  (in these cases, **dart.dev** and **docs.flutter.dev**, respectively).

  检查是否停用了第三方跟踪 Cookie
  （[Chrome 说明][chrome-cookies]）。
  如果停用了 Cookie，请把设置改为
  **允许 dartpad.dev 的 Cookie**。
  如果使用的是嵌入的 DartPad，
  例如 [Dart 速查表](/resources/dart-cheatsheet) 或
  [隐式动画 codelab]({{site.flutter-docs}}/codelabs/implicit-animations)，
  可能还需要允许嵌入站点域名的 Cookie
  （这两个例子分别是 **dart.dev** 和 **docs.flutter.dev**）。

* If you repeatedly reload a page that contains embedded DartPads, 
  then you might run into [GitHub rate limiting.][]
  Within 60 minutes, you should be able to reload the page and 
  see code in the embedded DartPads.

  如果反复重新加载包含嵌入 DartPad 的页面，
  可能会遇到 [GitHub 速率限制][GitHub rate limiting.]。
  60 分钟内，你应该可以重新加载页面，
  并在嵌入的 DartPad 中看到代码。

Although DartPad doesn't use cookies, it does rely on local storage,
which browsers usually disable when cookies are disabled.

虽然 DartPad 不使用 Cookie，但它依赖本地存储，
而浏览器通常会在停用 Cookie 时一并停用本地存储。


## Code doesn't work outside DartPad

## 代码在 DartPad 之外无法运行

If you copy code from DartPad into another environment,
the code might not run successfully.
Here are some possible causes and fixes:

如果把代码从 DartPad 复制到其他环境，
代码可能无法成功运行。
下面是一些可能的原因和修复办法：

* If Dart can't find an imported library,
  make sure you've added all necessary package dependencies.
  DartPad includes many built-in packages by default,
  but your own project must explicitly list the packages that it depends on.
  To see the packages that DartPad includes, 
  go to [dartpad.dev]({{site.dartpad}}) 
  and click the **i** icon at the bottom right of the window.
  To learn more about adding package dependencies to your own project,
  see the documentation for [`dart pub add`](/tools/pub/cmd/pub-add).

  如果 Dart 找不到导入的库，
  请确认已经添加了所有必要的 package 依赖。
  DartPad 默认包含许多内置 package，
  但你自己的项目必须显式列出所依赖的 package。
  要查看 DartPad 包含哪些 package，
  请打开 [dartpad.dev]({{site.dartpad}})，
  点击窗口右下角的 **i** 图标。
  如何为自己的项目添加 package 依赖，
  见 [`dart pub add`](/tools/pub/cmd/pub-add) 的文档。

* If Dart can't find certain methods or properties,
  check the code included provided alongside the exercise.

  如果 Dart 找不到某些方法或属性，
  请检查练习附带的代码。

* If the code has other compilation errors,
  make sure you're using the latest stable version of the Dart SDK.
  DartPad and embedded samples 
  generally use the latest stable release of the SDK,
  and older versions might be missing necessary language or library features.
  To learn how to update the Dart SDK,
  see [Get the Dart SDK](/get-dart).

  如果代码还有其他编译错误，
  请确认使用的是最新稳定版 Dart SDK。
  DartPad 和嵌入的示例通常使用 SDK 的最新稳定版，
  较旧的版本可能缺少必要的语言或库功能。
  如何更新 Dart SDK，
  见 [获取 Dart SDK](/get-dart)。

* If you're creating a web app,
  make sure you have the proper project setup.
  DartPad doesn't show all the necessary markup to run Dart code.
  To get started creating web apps with Dart,
  check out [Build a web app with Dart](/web/get-started).

  如果正在创建 Web 应用，
  请确认项目配置正确。
  DartPad 不会展示运行 Dart 代码所需的全部标记。
  要开始用 Dart 创建 Web 应用，
  请参阅 [使用 Dart 构建 Web 应用](/web/get-started)。

## Previously working code now has errors

## 以前能运行的代码现在报错

If the code is using language or library features no longer supported
in the latest stable release of Dart,
the code might no longer analyze or run without errors.

如果代码使用的语言或库功能
已不再受最新稳定版 Dart 支持，
代码可能无法再无错误地分析或运行。

* If possible, update the code to work with the latest Dart release,
  as DartPad only supports the **stable** and **beta** channels.

  如果可能，请把代码更新到能在最新 Dart 版本上运行，
  因为 DartPad 只支持 **stable** 和 **beta** 渠道。

* If the code worked in an earlier Dart release,
  you can use that version of Dart locally.
  To learn how to install a specific version of Dart,
  check out [Get the Dart SDK](/get-dart).

  如果代码在更早的 Dart 版本上可以运行，
  可以在本地使用那个版本的 Dart。
  如何安装特定版本的 Dart，
  见 [获取 Dart SDK](/get-dart)。

## DartPad doesn't work in China

## DartPad 在中国无法使用

Try [dartpad.cn.](https://dartpad.cn)

请尝试 [dartpad.cn](https://dartpad.cn)。

## Other issues

## 其他问题

If you have any other problems when using DartPad,
[create an issue on GitHub.][new-issue]

使用 DartPad 时如果还有其他问题，
请 [在 GitHub 上创建 issue][new-issue]。

[GitHub rate limiting.]: https://docs.github.com/en/rest/overview/resources-in-the-rest-api#rate-limiting
[chrome-cookies]: https://support.google.com/chrome/answer/95647
[new-issue]: {{site.repo.dart.org}}/dart-pad/issues/new
