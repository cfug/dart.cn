---
title: "JavaScript and TypeScript interop"
title: Web 上与 JavaScript/TypeScript 互调
short-title: JS/TS interop
short-title: JS/TS 互调
description: "Use package:js to integrate JavaScript or TypeScript code into your Dart web app."
description: 使用 js 这个 package 在你的 Dart Web 应用里集成 JavaScript 或 TypeScript。
toc: false
---

The [Dart web platform](/platforms/) supports calling
JavaScript (JS) and TypeScript (TS) using the [`js`
package,]({{site.pub-pkg}}/js) also known as _`package:js`_.

For help using the `js` package, see the following:

[js_facade_gen](https://github.com/dart-lang/js_facade_gen)
: A tool that generates Dart code from JavaScript libraries that have
  [TypeScript type definitions.](http://definitelytyped.org/)

[dart_js_interop](https://github.com/matanlurey/dart_js_interop)
: Examples of using the `js` package,
  with comparisons to old code that uses the dart:js library.

[Packages that depend on `js`]({{site.pub}}?q=dependency%3Ajs)
: Published packages that have `js` in their pubspec.
