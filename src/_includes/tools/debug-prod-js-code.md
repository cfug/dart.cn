## Debugging production code {:#debugging}

## 调试生产代码

This section gives tips for debugging production-compiled code
in Chrome, Firefox, and Safari. You can only debug JavaScript code in
browsers that support source maps such as Chrome.

本节介绍在 Chrome、Firefox 和 Safari 中
调试生产环境编译代码的技巧。你只能在支持 source map 的浏览器
（例如 Chrome）里调试 JavaScript 代码。

:::tip
Whenever possible, instead of debugging production code,
debug code using a development server such as provided by [`webdev`][].

只要有可能，就不要调试生产代码，
请用 [`webdev`][] 提供的开发服务器来调试代码。
:::

[`webdev`]: /tools/webdev

Whichever browser you use, you should enable pausing on at least
uncaught exceptions, and perhaps on all exceptions. 
For frameworks such as `dart:async` that wrap user code in try-catch, 
we recommend pausing on all exceptions.

无论使用哪种浏览器，至少应启用在未捕获异常上暂停，
也可以在所有异常上暂停。
对于 `dart:async` 这类用 try-catch 包裹用户代码的框架，
我们建议在所有异常上暂停。

[debugging web apps]: /web/debugging


### Chrome {:#dart2js-debugging-chrome}

### Chrome 浏览器

To debug in Chrome:

在 Chrome 中调试：

1. Open the Developer Tools window, as described in the
   [Chrome DevTools documentation.](https://developer.chrome.com/docs/devtools/)

   按照 [Chrome DevTools 文档](https://developer.chrome.com/docs/devtools/)
   的说明，打开开发者工具窗口。

2. Turn on source maps, as described in the video
   [SourceMaps in Chrome.](https://bit.ly/YugIUY)

   按照视频 [Chrome 中的 Source Map](https://bit.ly/YugIUY)
   的说明，打开 source map。

3. Enable debugging, either on all exceptions or only on uncaught exceptions,
   as described in
   [How to set breakpoints.](https://developer.chrome.com/docs/devtools/javascript/breakpoints/)

   按照 [如何设置断点](https://developer.chrome.com/docs/devtools/javascript/breakpoints/)
   的说明，启用调试，可以是所有异常，也可以只针对未捕获异常。

4. Reload your app.

   重新加载应用。

### Edge {:#dart2js-debugging-ie}

### Edge 浏览器

To debug in Edge:

在 Edge 中调试：

1. Update to the latest version of Edge.

   更新到最新版本的 Edge。

2. Load [**Developer Tools**][edge-devtools] (<kbd>F12</kbd>).

   打开 [**开发者工具**][edge-devtools]（<kbd>F12</kbd>）。

3. Reload the app. The **debugger** tab shows source-mapped files.

   重新加载应用。**调试器** 标签页会显示经过 source map 映射的文件。

4. Exception behavior can be controlled through
   <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>E</kbd>;
   the default is **Break on unhandled exceptions**.

   异常行为可以通过
   <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>E</kbd> 控制；
   默认是 **在未处理的异常上中断**。

[edge-devtools]: https://learn.microsoft.com/en-us/microsoft-edge/devtools/landing/

### Firefox {:#dart2js-debugging-firefox}

### Firefox 浏览器

To debug in Firefox:

在 Firefox 中调试：

1. Open the **Web Developer Tools** window, as described in the
   [Firefox developer tools documentation](https://firefox-source-docs.mozilla.org/devtools-user/index.html).

   按照 [Firefox 开发者工具文档](https://firefox-source-docs.mozilla.org/devtools-user/index.html)
   的说明，打开 **Web 开发者工具** 窗口。

2. Enable **Pause on exceptions**, as shown in the following figure:

   如下图所示，启用 **在异常上暂停**：
   
   <img width="640px" src="/assets/img/ff-debug.png" alt="Enable Pause on exceptions in Firefox debugger">
   
3. Reload the app. The **Debugger** tab shows source-mapped files.

   重新加载应用。**调试器** 标签页会显示经过 source map 映射的文件。

### Safari {:#dart2js-debugging-safari}

### Safari 浏览器

To debug in Safari:

在 Safari 中调试：

1. Turn on the **Develop** menu, 
   as described in the [Safari Web Inspector Tutorial.]({{site.apple-dev}}/library/archive/documentation/NetworkingInternetWeb/Conceptual/Web_Inspector_Tutorial/EnableWebInspector/EnableWebInspector.html)

   按照 [Safari Web 检查器教程]({{site.apple-dev}}/library/archive/documentation/NetworkingInternetWeb/Conceptual/Web_Inspector_Tutorial/EnableWebInspector/EnableWebInspector.html)
   的说明，打开 **开发** 菜单。

2. Enable breaks, either on all exceptions or only on uncaught exceptions.
   See [Add a JavaScript breakpoint](https://support.apple.com/en-ca/guide/safari-developer/add-a-javascript-breakpoint-dev5e4caf347/mac) under [Safari Developer Help.](https://support.apple.com/en-ca/guide/safari-developer/welcome/mac)

   启用中断，可以是所有异常，也可以只针对未捕获异常。
   请看 [Safari 开发者帮助](https://support.apple.com/en-ca/guide/safari-developer/welcome/mac)
   中的 [添加 JavaScript 断点](https://support.apple.com/en-ca/guide/safari-developer/add-a-javascript-breakpoint-dev5e4caf347/mac)。

3. Reload your app.

   重新加载应用。
