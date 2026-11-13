---
# title: Web platform
title: Web 平台
shortTitle: Web
# description: Resources for developing Dart web apps.
description: 开发 Dart Web 应用时候需要的资源列表。
ai-translated: true
showToc: false
---

Dart supports the web as one of its core [platforms](/overview#platform).
Dart-to-JavaScript compilers are available both for development
(with a quick edit-refresh cycle)
and for production
(with a focus on code size and speed).

Dart 将 Web 作为核心 [平台](/overview#platform) 之一。
Dart 到 JavaScript 的编译器同时适用于开发
（编辑后可以快速刷新）
和生产环境
（侧重代码体积和速度）。

In addition to compilers,
the Dart web platform provides [core libraries][],
access to the [DOM (Document Object Model)][DOM],
and [interoperability for calling JavaScript][interop] from Dart.

除了编译器，
Dart Web 平台还提供 [核心库][core libraries]、
对 [DOM（文档对象模型）][DOM] 的访问，
以及从 Dart [调用 JavaScript 的互操作][interop]。

You have the option of using Dart web with a higher-level framework.
Many apps that support web plus mobile or desktop are built
using [Flutter][] and [Flutter web][] support.
You can also use [Jaspr][] to build fast and dynamic HTML-based websites.
Flutter web support, Jaspr
and other web frameworks for Dart are powered by the Dart web platform.

你也可以搭配更高层的框架使用 Dart Web。
许多同时支持 Web 以及移动端或桌面端的应用，
都是借助 [Flutter][] 和 [Flutter Web][Flutter web] 支持构建的。
你也可以使用 [Jaspr][] 构建快速、动态的基于 HTML 的网站。
Flutter 的 Web 支持、Jaspr
以及其他 Dart Web 框架，都建立在 Dart Web 平台之上。

<div class="side-by-side">
<div class="centered-rows">
<p class="">
  <a href="/web/get-started" class="filled-button large-button"><t>Build a web app with Dart</t><t>用 Dart 构建 Web 应用</t></a>
</p>
</div>
<div class="centered-rows">
<figure>
  <img 
    src="/assets/img/flutter-gallery.jpg"
    alt="screenshot of Flutter Gallery">
  <figcaption><t>Flutter Gallery, running in a web browser</t><t>在网页浏览器中运行的 Flutter Gallery</t></figcaption>
</figure>
</div>
</div>

[core libraries]: /libraries#web-platform-libraries
[DOM]: /web/get-started
[Flutter]: {{site.flutter}}
[Flutter web]: {{site.flutter}}/web
[Jaspr]: https://jaspr.site
[interop]: /interop/js-interop
