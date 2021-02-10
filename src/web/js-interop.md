---
title: JavaScript and TypeScript interop
title: Web 上与 JavaScript 互调
short-title: JS interop
short-title: 与 JS 互调
description: "Use package:js to integrate JavaScript or TypeScript code into your Dart web app."
description: 使用 js 这个 package 在你的 Dart Web 应用里集成 JavaScript 或 TypeScript。
toc: false
---

The [Dart web platform](/overview#web-platform/) supports calling
JavaScript using the `js` package,
also known as _package:js_.

For help using the `js` package, see the following:

* Documentation for the `js` package:
  * [pub.dev site page][js]
  * [API reference][js-api]
* Packages that use the `js` package:
  * [firebase_web][] is a good example of providing a Dart-like API
    to a JavaScript library.
  * [sass][] is an example of a more unusual use case: providing a
    way for JavaScript code to call Dart code.

[js]: {{site.pub-pkg}}/js
[js-api]: {{site.pub-api}}/js
[firebase_web]: {{site.pub-pkg}}/firebase_web
[sass]: {{site.pub-pkg}}/sass

