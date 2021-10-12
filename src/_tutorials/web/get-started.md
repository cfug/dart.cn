---
title: "Get started: Web apps"
title: 起步：使用 Dart 开发 Web 应用
description: A guide to get you quickly writing web apps in Dart.
description: 帮助你快速入门使用 Dart 开发 Web 应用
js: [{url: 'https://dartpad.dev/inject_embed.dart.js', defer: true}]
---

Follow these steps to start using Dart to develop **web-only** apps.
If you want to write a **multi-platform** app, then
[try Flutter.]({{site.flutter}}/web)

下面的步骤将指引你使用 Dart 开发 web 应用。
如果你想编写 **跨平台** 应用，请
[尝试 Flutter]({{site.flutter}}/web)

Still here?
First you'll play with Dart in your browser, no download required.
Then you'll install Dart and build a small web app.

开始旅程？
你将先在浏览器中尝试 Dart，无需下载。
之后你将会安装 Dart 并创建一个小型 web 应用。

## 1. Play with a web app in DartPad

## 1. 在 DartPad 中开发 web 程序

With [DartPad][DartPad documentation]
you can experiment with the Dart language and APIs,
no download necessary.

通过 DartPad，
你不需要下载任何东西即可尝试 Dart 编程语言和 API。

For example, here's an embedded DartPad that lets you play with
the code for a todo-list generator.
Click **Run** to run the app;
the UI output appears to the right of the code.
Try editing the source code—perhaps you'd like to add "horses"
to the list of pets.

例如，下面这个内嵌的 DartPad
可以让你尝试待办列表生成器的代码。
点击 **Run** 运行程序；
输出界面显示在代码的右侧。
尝试编辑源码，
比如在 pets 列表中添加 “horses”。

{{site.alert.note}}
  {% include dartpad-embedded-troubleshooting.md %}
{{site.alert.end}}

```dart:run-dartpad:mode-html:ga_id-play_with_a_web_app:null_safety-true
{$ begin main.dart $}
import 'dart:html';

Iterable<String> thingsTodo() sync* {
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

void addTodoItem(String item) {
  final listElement = LIElement()..text = item;
  todoList.children.add(listElement);
}

late final UListElement todoList = querySelector('#todolist') as UListElement;

void main() {
  thingsTodo().forEach(addTodoItem);
}

{$ end main.dart $}
{$ begin index.html $}
<h2>A Simple To-Do List</h2>

<p>Things to do:</p>

<ul id="todolist">
</ul>
{$ end index.html $}
```

More information:

更多信息：

* [DartPad documentation][]
  
  [DartPad 文档][DartPad documentation]

* [Dart language tour][]

  [Dart 语言概览][Dart language tour]

* [Dart library tour][]

  [Dart 库概览][Dart library tour]

* [Tutorial introduction to using Dart for basic web programming][]

  [简明 Dart web 开发指南][Tutorial introduction to using Dart for basic web programming]

## 2. Install Dart

## 2. 安装 Dart

{% include get-sdk.md %}

## 3. Get CLI tools or an IDE (or both)

## 3. 获取 CLI 工具或者 IDE（或两者都有）

<i class="fas fa-terminal dark"></i>
If you like to use the command line, install [webdev][]:

如果你想使用命令行，请安装 [webdev][]:

```terminal
$ dart pub global activate webdev
```

<i class="material-icons">web</i>
Although using an IDE is optional, we highly recommend using one.
For a list of available IDEs, see the
[overview of editors & debuggers][].

尽管使用 IDE 是可选的，但我们强烈建议使用 IDE。
有关可用的 IDE 列表，请查看
[编辑器和调试器的概览][overview of editors & debuggers]。

## 4. Create a web app

## 4. 创建一个 web 应用

<i class="fas fa-terminal dark"></i>
To create a web app from the command line, use these commands:

通过在命令行输入以下命令，创建一个 web 应用：

```terminal
$ dart create -t web-simple quickstart
```

<i class="material-icons">web</i>
To create the same web app from an IDE that has Dart integration,
create a project using the template named **Bare-bones Web App**.

通过已经集成 Dart 的 IDE 同样可以创建一个 web 应用，
使用名为 **Bare-bones Web App** 的模版创建一个项目。

## 5. Run the app

## 5. 运行应用

<i class="fas fa-terminal dark"></i>
To run the app from the command line, use [webdev][] to build and serve the app:

要从命令行运行应用程序，可以使用 [webdev][] 构建和运行应用程序：

```terminal
$ cd quickstart
$ webdev serve
```

<i class="material-icons">web</i>
Or run the app from your IDE.

或者从 IDE 运行应用程序。

To view your app, use the Chrome browser to visit the app's URL —
for example, [localhost:8080](localhost:8080).

使用 Chrome 浏览器访问应用程序的 URL
即可查看你的应用程序。
比如，[localhost:8080](localhost:8080)。

Whether you use an IDE or the command line,
[webdev serve][] builds and serves your app
using the Dart development compiler, [dartdevc][].
Startup is slowest the first time dartdevc builds and serves your app.
After that, assets are cached on disk and incremental builds are much faster.

无论使用 IDE 还是命令行，
[webdev serve][] 构建和运行你的程序
都是通过 Dart 开发编译器 [dartdevc][]。
第一次构建和运行应用程序时，启动速度很慢。
之后的构建会很快，因为资源会被缓存在磁盘并且使用增量构建。

Once your app has compiled, the browser should display
"Your Dart app is running."

一旦应用程序编译完成，
浏览器会显示
"Your Dart app is running."

![Launched bare-bones app]({% asset bare-bones-web-app.png @path %}){:width="500"}


## 6. Add custom code to the app

## 6. 添加自定义代码

Let's customize the app you just created.

让我们自定义刚才创建的应用。

 1. Copy the `thingsTodo()` function from the DartPad above
    to the `web/main.dart` file.

    从 DartPad 将 `thingsTodo()` 函数拷贝到 `web/main.dart` 文件中。

 2. Add the `newLI()` function (as shown below).
    It creates a new `LIElement` containing the specified `String`.

    添加 `newLI()` 函数（如下所示）。
    它接收 `String` 类型的参数
    并创建一个新的 `LIElement`。

    {% prettify dart tag=pre+code %}
    Iterable<String> thingsTodo() sync* { ... }

    [!LIElement newLI(String itemText) => LIElement()..text = itemText;!]

    void main() { ... }
    {% endprettify %}

 3. In the `main()` function, initialize the `output` element using
    `thingsTodo()`:

    在 `main()` 函数中，初始化 `output` 元素通过
    `thingsTodo()`：

    {% prettify dart tag=pre+code %}
    Iterable<String> thingsTodo() sync* { ... }

    LIElement newLI(String itemText) => LIElement()..text = itemText;

    void main() {
      querySelector('#output')?[!.children.addAll(thingsTodo().map(newLI));!]
    }
    {% endprettify %}

 4. Save your changes.

    保存你的修改。

 5. The webdev tool automatically rebuilds your app.
    Refresh the app's browser window.
    Now your simple Dart app has a todo list!
    It should look something like this:<br>
    ![Running the revised app]({% asset bare-bones-todo.png @path %}){:width="500"}

    webdev 工具会自动重新构建你的应用程序。
    在浏览器刷新应用。
    现在你简易的 Dart 程序已经有了一个待办列表！
    如下图所示：<br>
    ![Running the revised app]({% asset bare-bones-todo.png @path %}){:width="500"}

 6. Optionally, improve the formatting by editing `web/styles.css`,
    then reload the app to check your changes.

    你可以选择美化一下应用的样式通过编辑 `web/styles.css`，
    然后重新加载应用程序来检查你的改动。

    {% prettify css tag=pre+code %}
    #output {
      padding: 20px;
      [!text-align: left;!]
    }
    {% endprettify %}

## 7. Use Dart DevTools to inspect the app

## 7. 使用 Dart 开发者工具检查应用

Use Dart DevTools to set breakpoints, view values and types,
and step through your app's Dart code.
For setup details and a walkthrough, see
[Debugging Dart Web Apps][].

使用 Dart 开发者工具设置断点，
查看值和类型，
逐行运行你的 Dart 代码。
有关设置细节和演示，请查看
[调试 Dart Web 应用][Debugging Dart Web Apps]。

{{site.alert.info}}

  **Feeling lost? Don't worry!** This was a whirlwind introduction to Dart and
  web programming that left out many details. For a gentler approach, try a
  [low-level HTML tutorial for Dart][].

  **感觉没有理解? 别担心!** 本文只是粗略的介绍了 Dart 和 web 编程，
  其中忽略了很多细节。
  更详细的内容可以查阅
  [Dart 的初级 HTML 教程][low-level HTML tutorial for Dart]。

{{site.alert.end}}

## What next?

## 接下来做什么？

Check out these resources:

检索这些资源：

* Tutorials and codelabs for Dart
  * [Tutorials](/tutorials)
  * [Codelabs](/codelabs)
* Dart language, libraries, and conventions
  * [Sample code](/samples)
  * [Language tour](/guides/language/language-tour)
  * [Library tour](/guides/libraries/library-tour)
  * [Effective Dart](/guides/language/effective-dart)
* Tools & libraries
  * [Dart SDK](/tools/sdk)
  * [Dart tools](/tools)
  * [IDEs](/tools#ides-and-editors)
  * [Web libraries and packages](/web/libraries)

If you get stuck, find help at [Community and support.](/community)

如果你在这一步无法继续进行，可以从 [社区和帮助](/community) 中查找帮助。

[dartdevc]: /tools/dartdevc
[DartPad documentation]: /tools/dartpad
[Dart language tour]: /guides/language/language-tour
[Dart library tour]: /guides/libraries/library-tour
[Dart tools]: /tools
[Debugging Dart Web Apps]: /web/debugging
[low-level HTML tutorial for Dart]: /tutorials/web/low-level-html
[overview of editors & debuggers]: /tools#ides-and-editors
[Tutorial introduction to using Dart for basic web programming]: /tutorials/web/low-level-html/connect-dart-html
[webdev]: /tools/webdev
[webdev serve]: /tools/webdev#serve
