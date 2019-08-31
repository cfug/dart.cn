---
title: Platforms
title: 平台
description: "You can use Dart to write mobile apps, web apps, command-line apps, backends, and more."
description: 你可以使用 Dart 编写移动应用、Web 应用、命令行应用和服务端应用等。
toc: true
---

You can use Dart to write simple scripts or full-featured apps. Whether you're
creating a mobile app, web app, command-line script, or server-side app, there's
a Dart solution for that.

Dart 可以用来编写简单的脚本或完整功能的应用程序。无论是创建移动应用、Web 应用、命令行脚本还是服务端应用，都可以选择 Dart 作为解决方案。

Flexible compiler technology lets you run Dart code in different ways,
depending on your target platform and goals:

灵活的编译器技术允许以不同的方式运行 Dart 程序，具体的运行方式取决于目标平台以及需求：

  * **Dart Native**: For programs targeting devices (mobile, desktop, server,
    and more), Dart Native includes both a Dart VM with JIT (just-in-time)
    compilation and an AOT (ahead-of-time) compiler for producing machine
    code.

    **Dart Native**: 针对目标设备（移动设备、桌面设备、服务器等）的应用开发，Dart Native 包括使用 JIT（Just-In-Time）编译的 Dart VM 和用于生成机器码的 AOT（Ahead-Of-Time）编译器。

  * **Dart Web**: For programs targeting the web, Dart Web includes both a
    development time compiler (`dartdevc`) and a production time compiler
    (`dart2js`).

    **Dart Web**: 针对 Web 应用开发，Dart Web 包括开发时编译器（`dartdevc`）和生产时编译器（`dart2js`）。

<img src="{% asset platforms.svg @path %}" width="800px" alt="Dart platform">

## Dart Native (VM JIT and AOT)

Dart Native enables running Dart code compiled to native ARM or X64
machine code for mobile, desktop, and server apps.

Dart Native 支持将可执行的 Dart 代码编译为适用于移动，桌面和服务器应用程序的本机 ARM 或 X64 机器代码。

The [Flutter framework]({{site.flutter}}) is a popular multi-platform UI toolkit
that's powered by Dart Native when targeting mobile or desktop devices.

[Flutter 框架]({{site.flutter}})是一个流行的多平台 UI 工具包，
当应用的设备是移动端或桌面端时由 Dart Native 提供支持。

More information:

更多内容：

* [Flutter get started documentation]({{site.flutter}}/docs/get-started/)

  [Flutter 入门文档]({{site.flutter}}/docs/get-started/)

* [Get started: command-line and server apps](/tutorials/server/get-started)

  [命令行及服务端应用入门](/tutorials/server/get-started)

* [Write command-line apps](/tutorials/server/cmdline)

  [编写命令行应用](/tutorials/server/cmdline)

* [Write HTTP clients and servers](/tutorials/server/httpserver)

  [编写 HTTP 客户端和服务端应用](/tutorials/server/httpserver)

### Lightning fast developer workflow (Dart VM JIT)

### 极速开发 (Dart VM JIT)

Having a fast developer cycle is critical for iteration.

缩短开发周期对于迭代至关重要。

The Dart VM has a just-in-time compiler (JIT) that supports both pure interpretation
(as required on iOS devices, for example) and runtime optimization.

Dart VM 拥有 JIT （just-in-time）编译器
Dart VM 具有即时编译器（JIT），它支持纯解释（例如，基于 iOS 开发中的需求）和运行时优化。

More information: [`dart` VM tool](/tools/dart-vm)

更多内容： [`dart` VM 工具](/tools/dart-vm)

### Optimized production code (Dart AOT)

### 生产代码优化 (Dart AOT)

When apps are ready to be deployed to production — whether you're
publishing to an app store or deploying to a production backend —
you can use the Dart AOT compiler to ahead-of-time compile your app
to native ARM or X64 code machine code.
Your AOT-compiled app starts instantly and runs smoothly.

当应用程序准备好部署到生产环境时 - 无论是发布到应用程序商店还是部署到生产后端 -
都可以使用 Dart AOT 编译器将应用程序提前编译为本机 ARM 或 X64 的机器码。
经过 AOT 编译的应用程序，能够快速启动和更流畅的运行。

The AOT-compiled code runs inside an efficient Dart runtime that enforces
the sound Dart type system and manages memory using fast object allocation and a [generational garbage
collector.](https://medium.com/flutter-io/flutter-dont-fear-the-garbage-collector-d69b3ff1ca30)

AOT 编译的程序在高效的 Dart 运行时内运行，该运行时会强制执行健全的 Dart 类型系统并使用快速对象分配和
[分代垃圾收集器管理](https://medium.com/flutter-io/flutter-dont-fear-the-garbage-collector-d69b3ff1ca30) 内存。

More information: [`dart2aot` tool](/tools/dart2aot)

更多内容：[`dart2aot` 工具](/tools/dart2aot)

## Dart Web (JavaScript)

Dart Web enables running Dart code on web platforms powered by
JavaScript. With Dart Web, you compile Dart code to JavaScript code, which in
turn runs in a browser — for example, [V8](https://v8.dev/) inside
[Chrome](https://www.google.com/chrome/).

Dart Web 可以让 Dart 代码运行在支持 JavaScript 的 Web 平台。
Dart Web 可以将 Dart 代码编译为 JavaScript 代码，
从而运行在浏览器中 -
例如，内嵌 [V8](https://v8.dev/) 的 [Chrome](https://www.google.com/chrome/) 浏览器。

The [Flutter framework]({{site.flutter}}), a popular multi-platform UI toolkit,
is powered by Dart Web when targeting web apps. The
[AngularDart]({{site.angulardart}}) framework, a popular web app toolkit, is
also powered by Dart Web.

[Flutter 框架]({{site.flutter}})是一个流行的多平台 UI 工具包，当应用的环境是 Web 时由 Dart Web 提供支持。
[AngularDart]({{site.angulardart}}) 框架是一个流行的 Web 应用程序工具包，也由 Dart Web 提供支持。


More information: [Get started: web apps](/tutorials/web/get-started)

更多内容： [Web 应用入门](/tutorials/web/get-started)

### Lightning fast developer workflow (Dart dev compiler)

### 极速开发 (Dart 开发编译器)

The Dart dev compiler (dartdevc) is a Dart-to-JavaScript compiler
that's optimized for quick turnaround. Instead of using dartdevc directly,
you use it with `webdev`, a tool that supports core developer tasks such as
running, debugging, and building.

Dart 开发编译器（dartdevc）是一个 Dart 转 JavaScript 编译器，编译器针对快速转译进行了优化。
避免直接使用 dartdevc，应该与 `webdev` 配合一起使用。
`webdev` 是一种支持核心开发任务（如运行，调试和构建）的工具。

More information:

更多内容：

* [`dartdevc` compiler](/tools/dartdevc)

  [`dartdevc` 编译器](/tools/dartdevc)

* [`webdev` tool](/tools/webdev)

  [`webdev` 工具](/tools/webdev)

### Optimized production code (Dart JS compiler)

### 生产代码优化 (Dart JS 编译器)

The `dart2js` tool compiles Dart code to fast, compact, deployable JavaScript.
It employs techniques such as dead-code elimination

`dart2js` 工具将 Dar t代码编译为快速，紧凑，可部署的 JavaScript 应用。
工具使用了诸如死码消除之类的技术。


More information:

更多内容：

* [Deployment tips](/web/deployment)

  [部署技巧](/web/deployment)

* [`dart2js` compiler](/tools/dart2js)

  [`dart2js` 编译器](/tools/dart2js)

* [`webdev` tool](/tools/webdev)

  [`webdev` 工具](/tools/webdev)
