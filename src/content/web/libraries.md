---
# title: Web libraries and packages
title: Web 库和 package
# shortTitle: Web libraries
shortTitle: Web 库
# description: Libraries and packages that can help you write Dart web apps.
description: 帮助你编写 Dart Web 应用的库和 package。
ai-translated: true
---

Dart provides several packages and libraries to support
web app development, the recommended option being [`package:web`][web].
The [Dart SDK][] also contains other libraries that provide low-level web APIs.

Dart 提供了多个 package 和库来支持 Web 应用开发，
推荐使用 [`package:web`][web]。
[Dart SDK][] 还包含其他提供底层 Web API 的库。

## Web solutions

## Web 方案

[Migrate to `package:web`][migrate]
: Learn how to migrate to `package:web`
  from Dart's previous web library solutions, like [`dart:html`][html].

[迁移到 `package:web`][migrate]
: 了解如何从 Dart 以前的 Web 库方案
  （例如 [`dart:html`][html]）迁移到 `package:web`。

[`package:web` API reference][web]
: Dart's recommended web interop solution `package:web` exposes browser
  APIs with lightweight bindings built around static JS interop. 

[`package:web` API 参考][web]
: Dart 推荐的 Web 互操作方案 `package:web`
  通过围绕静态 JS 互操作构建的轻量绑定公开浏览器 API。

[JavaScript interoperability documentation][js]
: Learn how to interact with existing JavaScript or TypeScript libraries
  using Dart's JS interop support.

[JavaScript 互操作文档][js]
: 了解如何借助 Dart 的 JS 互操作支持，
  与现有的 JavaScript 或 TypeScript 库交互。

[`dart:js_interop` API reference][js_interop]
: Dart's web library `dart:js_interop` provides all the necessary members to
  facilitate sound interop between JavaScript and Dart types. 

[`dart:js_interop` API 参考][js_interop]
: Dart 的 Web 库 `dart:js_interop` 提供了必要的成员，
  以便在 JavaScript 与 Dart 类型之间进行健全的互操作。

[Flutter web support][flutter-web]
: The [Flutter framework][flutter] supports web development with Dart,
  in addition to mobile, desktop, and embedded device support.

[Flutter Web 支持][flutter-web]
: [Flutter 框架][flutter] 除了支持移动端、桌面端和嵌入式设备，
  也支持用 Dart 进行 Web 开发。

[Jaspr web framework][jaspr]
: [Jaspr][jaspr] is a Dart web framework for building fast and dynamic 
  HTML-based websites.

[Jaspr Web 框架][jaspr]
: [Jaspr][jaspr] 是一个 Dart Web 框架，
  用于构建快速、动态的基于 HTML 的网站。

[Build a web app with Dart](/web/get-started)
: A quick overview of how to build, run, and debug a web app with Dart.

[用 Dart 构建 Web 应用](/web/get-started)
: 简要介绍如何用 Dart 构建、运行和调试 Web 应用。

To find other libraries that support the web platform,
search pub.dev for [web packages][].

若要查找其他支持 Web 平台的库，
请在 pub.dev 上搜索 [Web package][web packages]。

[web]: {{site.pub-pkg}}/web
[Dart SDK]: {{site.dart-api}}
[migrate]: /interop/js-interop/package-web
[js_interop]: {{site.dart-api}}/dart-js_interop/dart-js_interop-library.html
[flutter-web]: {{site.flutter-docs}}/platform-integration/web
[flutter]: {{site.flutter}}
[jaspr]: https://jaspr.site
[web packages]: {{site.pub}}/web
[html]: /libraries/dart-html
[js]: /interop/js-interop
