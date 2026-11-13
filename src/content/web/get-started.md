---
# title: Build a web app with Dart
title: 用 Dart 构建 Web 应用
# description: Get started writing web apps in Dart.
description: 开始用 Dart 编写 Web 应用。
ai-translated: true
---

This page describes the steps to start developing **web-only** apps with Dart.
If you want to write a **multi-platform** app, then
[try Flutter.]({{site.flutter}}/web)

本页说明如何开始用 Dart 开发 **仅限 Web** 的应用。
如果你想编写 **多平台** 应用，请
[试试 Flutter]({{site.flutter}}/web)。

Before you begin, ensure you're comfortable with Dart basics
by reading the [Introduction to Dart](/language).
Then follow the steps below to create a small web app with Dart.

开始之前，请阅读 [Dart 简介](/language)，
确认你已经熟悉 Dart 基础。
然后按照下面的步骤，用 Dart 创建一个小型 Web 应用。

## 1. Install Dart {:#install-dart}

## 1. 安装 Dart

To develop Dart apps, you need the Dart SDK.
To continue with this guide,
either [download the Dart SDK][dart-download] or
[install Flutter][flutter-download],
which includes the full Dart SDK.

要开发 Dart 应用，你需要 Dart SDK。
要继续本指南，
可以 [下载 Dart SDK][dart-download]，
或者 [安装 Flutter][flutter-download]，
其中包含完整的 Dart SDK。

[dart-download]: /get-dart
[flutter-download]: {{site.flutter-docs}}/get-started/install

## 2. Get CLI tools or an IDE (or both) {:#tools}

## 2. 获取命令行工具或 IDE（或两者都要）

<i class="material-symbols">terminal</i>
If you like to use the command line, install the [`webdev`][] package:

如果你习惯使用命令行，请安装 [`webdev`][] package：

```console
$ dart pub global activate webdev
```

<i class="material-symbols">web</i>
Although using an IDE is optional, we highly recommend using one.
For a list of available IDEs, see the
[overview of editors & debuggers][].

虽然使用 IDE 是可选的，但我们强烈建议使用。
可用 IDE 的列表见
[编辑器与调试器概览][overview of editors & debuggers]。

[overview of editors & debuggers]: /tools#editors

## 3. Create a web app {:#create}

## 3. 创建 Web 应用

<i class="material-symbols">terminal</i>
To create a web app from the command line,
use the [`dart create`][] command with the `web` template:

要从命令行创建 Web 应用，
请使用带 `web` 模板的 [`dart create`][] 命令：

```console
$ dart create -t web quickstart
```

<i class="material-symbols">web</i>
To create the same web app from an IDE that has Dart integration,
[create a project]({{site.flutter}}/tools/vs-code#creating-a-new-project)
using the template named **Bare-bones Web App**.

要从已集成 Dart 的 IDE 创建同样的 Web 应用，
请使用名为 **Bare-bones Web App** 的模板
[创建项目]({{site.flutter}}/tools/vs-code#creating-a-new-project)。

The web app template imports [`package:web`][], Dart's powerful and concise web
interop solution built for the modern web. To learn more about it, check out the
[web interop overview](/interop/js-interop/package-web).

Web 应用模板会导入 [`package:web`][]，
这是为现代 Web 构建的强大而简洁的 Dart Web 互操作方案。
要进一步了解，请查阅
[Web 互操作概览](/interop/js-interop/package-web)。

[`dart create`]: /tools/dart-create
[`package:web`]: {{site.pub-pkg}}/web

## 4. Run the app {:#run}

## 4. 运行应用

<i class="material-symbols">terminal</i>
To run the app from the command line,
use [`webdev`][] to build and serve the app:

要从命令行运行应用，
请使用 [`webdev`][] 构建并提供应用：

```console
$ cd quickstart
$ webdev serve
```

<i class="material-symbols">web</i>
Or run the app from your IDE.

也可以从 IDE 运行应用。

To view your app, use the Chrome browser
to visit the app's URL—for example,
[`localhost:8080`](http://localhost:8080).

要查看应用，请用 Chrome 浏览器
访问应用的 URL，例如
[`localhost:8080`](http://localhost:8080)。

Whether you use an IDE or the command line,
[`webdev serve`][] builds and serves your app
using the development JavaScript compiler.
Startup is slowest the first time the
development compiler builds and serves your app.
After that, assets are cached on disk and incremental builds are much faster.

无论使用 IDE 还是命令行，
[`webdev serve`][] 都会用开发用 JavaScript 编译器
构建并提供应用。
开发编译器第一次构建并提供应用时启动最慢。
之后资源会缓存在磁盘上，增量构建会快得多。

Once your app has compiled, the browser should display
"Your Dart app is running."

应用编译完成后，浏览器应显示
「Your Dart app is running.」。

![Launched bare-bones app](/assets/img/bare-bones-web-app.png){:width="500"}

[`webdev serve`]: /tools/webdev#serve

## 5. Add custom code to the app {:#add-code}

## 5. 为应用添加自定义代码

Let's customize the app you just created.

接下来自定义刚刚创建的应用。

1. Copy the `thingsToDo()` function from the following snippet
   to the `web/main.dart` file:

   把下面代码片段中的 `thingsToDo()` 函数
   复制到 `web/main.dart` 文件：

   ```dart
   Iterable<String> thingsToDo() sync* {
     const actions = ['Walk', 'Wash', 'Feed'];
     const pets = ['cats', 'dogs'];

     for (final action in actions) {
       for (final pet in pets) {
         if (pet != 'cats' || action == 'Feed') {
           yield '$action the $pet';
         }
       }
     }
   }
   ```

2. Add the `newLI()` function (as shown below).
   It creates a new `LIElement` containing the specified `String`.

   添加 `newLI()` 函数（如下所示）。
   它会创建一个包含指定 `String` 的新 `LIElement`。

   ```dart highlightLines=3-5
   Iterable<String> thingsToDo() sync* { /* ... */ }

   web.HTMLLIElement newLI(String itemText) =>
       (web.document.createElement('li') as web.HTMLLIElement)
         ..textContent = itemText;

   void main() { /* ... */ }
   ```

3. In the `main()` function, append content to the `output` element
   using `appendChild` and the values from `thingsToDo()`:

   在 `main()` 函数中，用 `appendChild`
   和 `thingsToDo()` 的值，
   把内容追加到 `output` 元素：

   ```dart highlightLines=9-11
   Iterable<String> thingsToDo() sync* { /* ... */ }

   web.HTMLLIElement newLI(String itemText) =>
       (web.document.createElement('li') as web.HTMLLIElement)
         ..textContent = itemText;

   void main() {
     final output = web.document.querySelector('#output');
     for (final item in thingsToDo()) {
       output?.appendChild(newLI(item));
     }
   }
   ```

4. Save your changes.

   保存更改。

5. The `webdev` tool automatically rebuilds your app.
   Refresh the app's browser window.
   Now your simple Dart app has a todo list!
   It should look something like this:<br>
   ![Running the revised app](/assets/img/bare-bones-todo.png){:width="500"}

   `webdev` 工具会自动重新构建应用。
   刷新应用的浏览器窗口。
   现在这个简单的 Dart 应用有了一份待办列表！
   看起来应类似这样：

6. Optionally, improve the formatting by editing `web/styles.css`,
   then reload the app to check your changes.

   可选：编辑 `web/styles.css` 改善格式，
   然后重新加载应用以检查更改。

   ```css highlightLines=3
   #output {
     padding: 20px;
     text-align: left;
   }
   ```


## 6. Use Dart DevTools to inspect the app {:#devtools}

## 6. 使用 Dart 开发者工具检查应用

Use Dart DevTools to set breakpoints, view values and types,
and step through your app's Dart code.
For setup details and a walkthrough, see
[Debugging Dart Web Apps][].

使用 Dart 开发者工具设置断点、查看值和类型，
并逐步执行应用的 Dart 代码。
设置细节和演练见
[调试 Dart Web 应用][Debugging Dart Web Apps]。

[Debugging Dart Web Apps]: /web/debugging

## 7. Build and deploy your web app {:#deploy}

## 7. 构建并部署 Web 应用

To run your web app outside your development environment,
you'll need to build and deploy it.
To learn more about deploying Dart web apps,
check out [Web deployment][].

要在开发环境之外运行 Web 应用，
你需要构建并部署它。
要进一步了解如何部署 Dart Web 应用，
请查阅 [Web 部署][Web deployment]。

[Web deployment]: /web/deployment

## What next?

## 接下来做什么？

Check out these resources:

看看这些资源：

* Dart language, libraries, and conventions

  Dart 语言、库和约定

  * [Language tour](/language)

    [语言导览](/language)

  * [Core library walkthrough](/libraries)

    [核心库导览](/libraries)

  * [Effective Dart](/effective-dart)

    [高效 Dart](/effective-dart)

* Web development

  Web 开发

  * [JavaScript interoperability](/interop/js-interop)

    [JavaScript 互操作](/interop/js-interop)

  * [Web libraries and packages](/web/libraries)

    [Web 库和 package](/web/libraries)

  * [`package:web` overview](/interop/js-interop/package-web)

    [`package:web` 概览](/interop/js-interop/package-web)

  * [Introduction to the DOM][]

    [DOM 简介][Introduction to the DOM]

If you get stuck, find help at [Community and support.](/community)

如果遇到问题，请到 [社区与支持](/community) 寻求帮助。

[Introduction to the DOM]: https://developer.mozilla.org/docs/Web/API/Document_Object_Model/Introduction

[`webdev`]: /tools/webdev
