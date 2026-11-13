---
# title: Debugging Dart web apps
title: 调试 Dart Web 应用
# shortTitle: Debugging web apps
shortTitle: 调试 Web 应用
# breadcrumb: Debugging
breadcrumb: 调试
# description: Learn how to debug your Dart web app.
description: 调试你的 Web 应用。
ai-translated: true
---

You can use a [Dart IDE][IDE], [Dart DevTools][], and browser tools
such as [Chrome DevTools][] to debug your Dart web apps.

你可以使用 [Dart IDE][IDE]、[Dart 开发者工具][Dart DevTools]，
以及 [Chrome 开发者工具][Chrome DevTools] 等浏览器工具，
来调试 Dart Web 应用。

* To debug your app's logic,
  use your IDE, Dart DevTools, or browser tools.
  Dart DevTools has better support than browser tools
  for inspecting and automatically reloading Dart code.

  要调试应用的逻辑，
  请使用 IDE、Dart 开发者工具或浏览器工具。
  在检查和自动重新加载 Dart 代码方面，
  Dart 开发者工具比浏览器工具支持得更好。

* To debug your app's appearance (HTML/CSS) and performance,
  use your IDE or browser tools such as Chrome DevTools.

  要调试应用的外观（HTML/CSS）和性能，
  请使用 IDE，或 Chrome 开发者工具等浏览器工具。


## Overview

## 概览

To serve your app, use `webdev serve`
(either at the command line or through your IDE)
to start up the Dart development compiler.
To enable Dart DevTools, add the `--debug` or `--debug-extension` option
(at the command line or through your IDE):

要提供应用，请使用 `webdev serve`
（在命令行或通过 IDE）
启动 Dart 开发编译器。
要启用 Dart 开发者工具，请添加 `--debug` 或 `--debug-extension` 选项
（在命令行或通过 IDE）：

```console
$ webdev serve --debug
```

When running your app using the `--debug` flag of `webdev`,
you can open Dart DevTools by pressing
<kbd>Alt</kbd>+<kbd>D</kbd>
(or <kbd>Option</kbd>+<kbd>D</kbd> on macOS).

使用 `webdev` 的 `--debug` 标志运行应用时，
可以按 <kbd>Alt</kbd>+<kbd>D</kbd>
（在 macOS 上为 <kbd>Option</kbd>+<kbd>D</kbd>）
打开 Dart 开发者工具。

To open Chrome DevTools, press <kbd>Control</kbd>+<kbd>Shift</kbd>+<kbd>I</kbd>
(or <kbd>Command</kbd>+<kbd>Option</kbd>+<kbd>I</kbd> on macOS).
If you want to debug your app using Chrome DevTools,
you can use [source maps][] to display your Dart source files
instead of the JavaScript that the compiler produces.
For more information on using Chrome DevTools,
see the [Chrome DevTools documentation.][Chrome DevTools]

要打开 Chrome 开发者工具，请按
<kbd>Control</kbd>+<kbd>Shift</kbd>+<kbd>I</kbd>
（在 macOS 上为 <kbd>Command</kbd>+<kbd>Option</kbd>+<kbd>I</kbd>）。
如果要用 Chrome 开发者工具调试应用，
可以使用 [源映射][source maps] 显示 Dart 源文件，
而不是编译器生成的 JavaScript。
关于使用 Chrome 开发者工具的更多信息，
请参阅 [Chrome 开发者工具文档][Chrome DevTools]。

[source maps]: https://developer.chrome.com/docs/devtools/javascript/source-maps/

To use the Dart DevTools or Chrome DevTools
to debug a Dart web app, you need the following software:

要使用 Dart 开发者工具或 Chrome 开发者工具
调试 Dart Web 应用，你需要以下软件：

* [Google Chrome.][Google Chrome]

  [Google Chrome][Google Chrome]

* [Dart SDK][], version 2.0.0 or higher.

  [Dart SDK][]，版本 2.0.0 或更高。

* One of the following development environments:

  以下开发环境之一：

  * Command-line: [Dart command-line tool packages][cl-tools]
    such as webdev (required for both Dart and Chrome DevTools) and
    devtools (required for Dart DevTools).
    <br>_or_

    命令行：[Dart 命令行工具 package][cl-tools]，
    例如 webdev（Dart 开发者工具和 Chrome 开发者工具都需要）
    以及 devtools（Dart 开发者工具需要）。
    <br> **或者**

  * A [Dart IDE or editor][IDE] that supports web development.

    支持 Web 开发的 [Dart IDE 或编辑器][IDE]。

* A [Dart web app][] to debug.

  一个要调试的 [Dart Web 应用][Dart web app]。

[cl-tools]: #getting-command-line-tool-packages

## Getting started with Dart DevTools {:#using-dart-devtools}

## 开始使用 Dart 开发者工具

<img src="/assets/img/dart-devtools-screenshot.png" alt="DevTools">

This section leads you through the basics of
using Dart DevTools to debug a web app.
If you already have an app that's ready to debug,
you can skip creating the test app (step 1),
but you'll need to adjust the instructions to match your app.

本节带你了解使用 Dart 开发者工具调试 Web 应用的基础。
如果你已经有可以调试的应用，
可以跳过创建测试应用（第 1 步），
但需要按你的应用调整说明。

1. _Optional:_ Clone the [webdev repo,][] so you can use its example app
   to play with Dart DevTools.

   **可选：** 克隆 [webdev 仓库][webdev repo,]，
   以便用它的示例应用试用 Dart 开发者工具。

1. _Optional:_ Install the [Dart Debug Extension][]
   so that you can run your app and open the Dart DevTools
   in an already-running instance of Chrome.

   **可选：** 安装 [Dart Debug Extension][]，
   这样就可以在已经运行的 Chrome 实例中
   运行应用并打开 Dart 开发者工具。

1. In your app's top directory, run `dart pub get` to get its dependencies.

   在应用的顶层目录中运行 `dart pub get`，以获取依赖。

   ```console
   $ cd example
   $ dart pub get
   ```

1. Compile and serve the app in debug mode,
   using either your IDE or `webdev` at the command line.

   使用 IDE 或命令行上的 `webdev`，
   以调试模式编译并提供应用。

   :::note
   The first compilation takes the longest,
   because the entire app must be compiled.
   After that, refreshes are much faster.

   第一次编译耗时最长，
   因为必须编译整个应用。
   之后刷新会快得多。
   :::

   If you're using webdev at the command line,
   the command to use depends on whether you want (or need) to
   run the app and debugger in an already-running instance of Chrome.

   如果在命令行使用 webdev，
   所用命令取决于你是否希望（或需要）
   在已经运行的 Chrome 实例中运行应用和调试器。

   * If you have [Dart Debug Extension][] installed and want to use
     an existing instance of Chrome to debug:

     如果已安装 [Dart Debug Extension][]，
     并且想用现有的 Chrome 实例调试：

     ```console
     $ webdev serve --debug-extension
     ```

   * Otherwise, use the following command, 
     which launches a new instance of Chrome
     and runs the app:

     否则使用下面的命令，
     它会启动一个新的 Chrome 实例并运行应用：

     ```console
     $ webdev serve --debug
     ```

1. If your app isn't already running, open it in a Chrome browser window.
   <br>
   For example, if you use `webdev serve --debug-extension` with no arguments,
   open [http://127.0.0.1:8080](http://http://127.0.0.1:8080).

   如果应用尚未运行，请在 Chrome 浏览器窗口中打开它。
   <br>
   例如，如果使用不带参数的 `webdev serve --debug-extension`，
   请打开 [http://127.0.0.1:8080](http://http://127.0.0.1:8080)。

1. Open Dart DevTools to debug the app that's running in the current window.

   打开 Dart 开发者工具，调试当前窗口中正在运行的应用。

   * If Dart Debug Extension is installed and
     you used the `--debug-extension` flag to `webdev`,
     click the Dart logo
     <img src="/assets/img/logo/dart-64.png" alt="Dart logo" class="align-baseline text-icon">
     at the top right of the browser window.

     如果已安装 Dart Debug Extension，
     并且对 `webdev` 使用了 `--debug-extension` 标志，
     请点击浏览器窗口右上角的 Dart 标志
     <img src="/assets/img/logo/dart-64.png" alt="Dart logo" class="align-baseline text-icon">。
     
   * If you used the `--debug` flag to `webdev`,
     press <kbd>Alt</kbd>+<kbd>D</kbd>
     (or <kbd>Option</kbd>+<kbd>D</kbd> on macOS).

     如果对 `webdev` 使用了 `--debug` 标志，
     请按 <kbd>Alt</kbd>+<kbd>D</kbd>
     （在 macOS 上为 <kbd>Option</kbd>+<kbd>D</kbd>）。
   
   The Dart DevTools window comes up
   and displays the source code for your app's main file.

   随后会出现 Dart 开发者工具窗口，
   并显示应用主文件的源代码。

1. Set a breakpoint inside a timer or event handler
   by clicking to the left of one of its lines of code.
   <br>
   For example, click the line number for the first line inside
   an event handler or timer callback.

   在计时器或事件处理函数内部设置断点，
   点击某一行代码的左侧即可。
   <br>
   例如，点击事件处理函数或计时器回调中第一行的行号。

1. Trigger the event that causes the function call.
   Execution stops at the breakpoint.

   触发导致该函数调用的事件。
   执行会停在断点处。

1. In the **Variables** pane, inspect the values of variables.

   在 **Variables** 窗格中检查变量的值。

1. Resume script execution, and trigger the event again or press **Pause**.
   Execution pauses again.

   恢复脚本执行，然后再次触发事件，或按 **Pause**。
   执行会再次暂停。

1. Try stepping through code line-by-line using the
   **Step In**, **Step Over**, and **Step Out** buttons.

   尝试使用 **Step In**、**Step Over** 和 **Step Out** 按钮
   逐行单步执行代码。

   :::note
   Dart DevTools doesn't step into SDK code.
   For example, if you press **Step In** at a call to `print()`,
   you go to the next line, not into the SDK code that implements `print()`.

   Dart 开发者工具不会步入 SDK 代码。
   例如，如果在 `print()` 调用处按 **Step In**，
   会进入下一行，而不会进入实现 `print()` 的 SDK 代码。
   :::

1. Change your source code and reload the Chrome window that's running the app.
   The app quickly rebuilds and reloads.
   Until [issue 1925][] is fixed,
   you lose your breakpoints when reloading the app.

   修改源代码，并重新加载正在运行应用的 Chrome 窗口。
   应用会很快重新构建并重新加载。
   在 [issue 1925][] 修复之前，
   重新加载应用时断点会丢失。

1. Click the **Logging** button to see stdout, stderr, and system logs.

   点击 **Logging** 按钮查看 stdout、stderr 和系统日志。


## Getting command-line tool packages

## 获取命令行工具 package

If you're using the command line instead of an IDE or Dart-enabled editor,
then you need the [webdev tool][webdev].
Dart DevTools is provided by the SDK.

如果使用命令行，而不是 IDE 或支持 Dart 的编辑器，
则需要 [webdev 工具][webdev]。
Dart 开发者工具由 SDK 提供。

```console
$ dart pub global activate webdev
```

If your PATH environment variable is set up correctly,
you can now use these tools at the command line:

如果 PATH 环境变量设置正确，
现在就可以在命令行使用这些工具：

```console
$ webdev --help
A tool to develop Dart web projects.
...
```

For information on setting PATH, see the
[`dart pub global` documentation.][dart pub global documentation]

关于设置 PATH 的信息，请参阅
[`dart pub global` 文档][dart pub global documentation]。

Whenever you update the Dart SDK,
update the tools by activating them again:

每当更新 Dart SDK 时，
请再次激活这些工具以更新它们：

```console
$ dart pub global activate webdev     # update webdev
```

{% render 'tools/debug-prod-js-code.md', site: site %}

## Resources

## 资源

To learn more, see the following:

要了解更多信息，请参阅以下内容：

* Documentation for [your IDE][IDE]

  [你的 IDE][IDE] 的文档

* [Dart DevTools documentation][Dart DevTools]

  [Dart 开发者工具文档][Dart DevTools]

* [webdev tool documentation][webdev]

  [webdev 工具文档][webdev]

* [webdev package documentation][webdev-pkg]

  [webdev package 文档][webdev-pkg]

[Chrome DevTools]: https://developer.chrome.com/docs/devtools/
[Dart Debug Extension]: https://chrome.google.com/webstore/detail/dart-debug-extension/eljbmlghnomdjgdjmbdekegdkbabckhm
[Dart DevTools]: /tools/dart-devtools
[IDE]: /tools#editors
[Dart SDK]: /get-dart
[Dart web app]: /web
[Google Chrome]: https://www.google.com/chrome
[issue 1925]: https://github.com/flutter/devtools/issues/1925
[JavaScript debugging reference]: https://developer.chrome.com/docs/devtools/javascript/reference/
[dart pub global documentation]: /tools/pub/cmd/pub-global
[webdev]: /tools/webdev
[webdev repo,]: {{site.repo.dart.org}}/webdev
[webdev-pkg]: {{site.pub-pkg}}/webdev
