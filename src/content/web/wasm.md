---
# title: WebAssembly (Wasm) compilation
title: WebAssembly (Wasm) 编译
# description: Learn how to compile your Dart web app to WebAssembly.
description: 了解如何将 Dart Web 应用编译为 WebAssembly。
ai-translated: true
---

The Dart team is excited to add
[WebAssembly](https://webassembly.org/) as a compilation target when building
Dart and [Flutter][] applications for the web.

Dart 团队很高兴在为 Web 构建
Dart 和 [Flutter][] 应用时，
新增 [WebAssembly](https://webassembly.org/) 这一编译目标。

Development of WebAssembly support remains ongoing,
which will potentially result in frequent changes. 
Revisit this page for the latest updates.

WebAssembly 支持仍在持续开发中，
因此可能会经常发生变化。
请回到本页查看最新进展。

:::note
**Support for Wasm is now in stable!**

**Wasm 支持现已进入稳定版！**

WebAssembly support for Dart web is available on the Dart 
*stable* [channel](/get-dart#release-channels).

Dart Web 的 WebAssembly 支持已在 Dart
**稳定** [渠道](/get-dart#release-channels) 提供。
:::

## WebAssembly support

## WebAssembly 支持

The current version of Dart compilation to WebAssembly has a number of
restrictions:

当前版本的 Dart 到 WebAssembly 编译有若干限制：

1. It targets WebAssembly with Garbage Collection ([WasmGC][]),
   so not all browsers are currently supported.
   The current list of browsers is available in the [Flutter documentation][Flutter].

   它面向带垃圾回收的 WebAssembly（[WasmGC][]），
   因此目前并非所有浏览器都受支持。
   当前支持的浏览器列表见 [Flutter 文档][Flutter]。

1. The compiled Wasm output currently targets JavaScript environments
   (such as browsers), and thus currently doesn't support execution in standard
   Wasm run-times like wasmtime and wasmer. For details, see
   [issue #53884]({{site.repo.dart.sdk}}/issues/53884)

   编译出的 Wasm 目前面向 JavaScript 环境
   （例如浏览器），因此尚不支持在 wasmtime、wasmer
   等标准 Wasm 运行时中执行。详情见
   [issue #53884]({{site.repo.dart.sdk}}/issues/53884)。

1. Only Dart's
   [next-gen JS interop mechanism](/interop/js-interop/)
   is supported when compiling to Wasm.

   编译到 Wasm 时，只支持 Dart 的
   [新一代 JS 互操作机制](/interop/js-interop/)。

1. There is currently no support in the `webdev` tool for running
   (`webdev serve`) or building (`webdev build`). The steps below
   contain a temporary workaround. For details, see
   [webdev issue 2206]({{site.repo.dart.org}}/webdev/issues/2296).

   `webdev` 工具目前不支持运行
   （`webdev serve`）或构建（`webdev build`）。
   下面的步骤包含一个临时变通办法。详情见
   [webdev issue 2206]({{site.repo.dart.org}}/webdev/issues/2296)。

:::note
By default, compiled applications do not use [deferred loading][].
Deferred loading in Wasm is experimental. To enable it, use the
`--enable-deferred-loading` flag:

默认情况下，编译后的应用不使用 [延迟加载][deferred loading]。
Wasm 中的延迟加载仍是实验性功能。要启用它，请使用
`--enable-deferred-loading` 标志：

```console
$ dart compile wasm --enable-deferred-loading ...
```

Enabling deferred loading requires the app loader to supply a callback
that loads the module bytes:

启用延迟加载时，应用加载器需要提供一个回调，
用于加载模块字节：

```js
const app = await compileStreaming(...); // or compile(...)
const instantiatedApp = await app.instantiate({}, {
  loadDeferredModules: (modules, handleModuleByteSource) => {
    return Promise.all(
      modules.map((m) => fetch(m).then((r) => handleModuleByteSource(m, r)))
    );
  },
});
instantiatedApp.invokeMain();
```

This is available from the 3.13 Dart stable release.

此功能从 Dart 3.13 稳定版开始提供。
:::

### Supported packages

### 受支持的 package

To find Wasm-compatible packages,
use the [`wasm-ready`][] filter on [pub.dev][].

要查找与 Wasm 兼容的 package，
请在 [pub.dev][] 上使用 [`wasm-ready`][] 筛选器。

A package is "wasm-ready" if it doesn't import non-Wasm compliant libraries
like `dart:html`, `dart:js`, etc. You can find the full list of unallowed
libraries on the [JS interop page](/interop/js-interop/past-js-interop#next-generation-js-interop).

如果一个 package 没有导入不符合 Wasm 要求的库
（例如 `dart:html`、`dart:js` 等），它就是「wasm-ready」。
不允许导入的完整库列表见
[JS 互操作页面](/interop/js-interop/past-js-interop#next-generation-js-interop)。

[`wasm-ready`]: {{site.pub-pkg}}?q=is%3Awasm-ready
[pub.dev]: {{site.pub}}

## Compiling your web app to Wasm {:#compiling-to-wasm}

## 将 Web 应用编译为 Wasm

We've landed support in the `dart` CLI for invoking the
Wasm compiler in Dart and [Flutter][]:

`dart` 命令行已经支持调用
Dart 和 [Flutter][] 的 Wasm 编译器：

```console
$ dart help compile wasm
Compile Dart to a WebAssembly/WasmGC module.

Usage: dart compile wasm [arguments] <dart entry point>
-h, --help                  Print this usage information.
-o, --output                Write the output to <file name>.
                            This can be an absolute or relative path.
-v, --verbose               Print debug output during compilation
    --enable-asserts        Enable assert statements.
-D, --define=<key=value>    Define an environment declaration. To specify multiple declarations, use multiple
                            options or use commas to separate key-value pairs.
                            For example: dart compile wasm -Da=1,b=2 main.dart
```

Wasm compilation is available in stable, but still in preview.
While we continue optimizing tooling to improve developer experience,
you can try compiling Dart to Wasm today
by following the temporary steps outlined here:

Wasm 编译已在稳定版提供，但仍处于预览阶段。
在我们继续优化工具、改善开发体验的同时，
你现在就可以按照这里列出的临时步骤，
尝试将 Dart 编译为 Wasm：

1. Start with a web app: `dart create -t web mywebapp`

   从 Web 应用开始：`dart create -t web mywebapp`

    The template creates a small web app using [`package:web`][],
    which is necessary to run Wasm.
    Make sure your web apps are [migrated][] from `dart:html` to `package:web`.

    该模板使用 [`package:web`][] 创建一个小型 Web 应用，
    这是运行 Wasm 所必需的。
    请确认你的 Web 应用已从 `dart:html` [迁移][migrated] 到 `package:web`。

1. Compile with Wasm to a new `site` output directory: `mywebapp$ dart compile wasm web/main.dart -o site/main.wasm`

   用 Wasm 编译到新的 `site` 输出目录：`mywebapp$ dart compile wasm web/main.dart -o site/main.wasm`

1. Copy over the web files: `cp web/index.html web/styles.css site/`

   复制 Web 文件：`cp web/index.html web/styles.css site/`

1. Create a JS bootstrap file to load the Wasm code:

   创建一个 JS 引导文件来加载 Wasm 代码：
   
   Add a new file `site/main.dart.js` and fill it with the contents of
   this [`main.dart.js` sample](https://gist.github.com/mit-mit/0fcb1247a9444b0cadf611aa5fc6f32e).

   新增文件 `site/main.dart.js`，并填入
   这份 [`main.dart.js` 示例](https://gist.github.com/mit-mit/0fcb1247a9444b0cadf611aa5fc6f32e) 的内容。

1. Serve the output: `dart pub global run dhttpd` ([docs][dhttpd])

   提供输出目录：`dart pub global run dhttpd`（[文档][dhttpd]）

You can also try out this small example [here](https://github.com/mit-mit/sandbox).

你也可以在 [这里](https://github.com/mit-mit/sandbox) 试用这个小示例。

[WasmGC]: https://developer.chrome.com/blog/wasmgc/
[Flutter]: {{site.flutter}}/wasm
[`package:web`]: {{site.pub-pkg}}/web
[`dart:js_interop`]: {{site.dart.api}}/{{site.dart.sdk.channel}}/dart-js_interop 
[migrated]: /interop/js-interop/package-web/
[dhttpd]: {{site.pub-pkg}}/dhttpd
[deferred loading]: /language/libraries#lazily-loading-a-library
