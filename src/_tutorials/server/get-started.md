---
title: "Get started: command-line and server apps"
title: 起步教程：编写命令行和服务端应用
description: Get Dart, run and compile a small app
description: 获取 Dart SDK，运行和编译一个小应用
nextpage:
  url: /tutorials/server/cmdline
  title: Write command-line apps
  title: 编写命令行应用
prevpage:
  url: /tutorials/server
  title: Dart command-line and server tutorials
  title: 教程目录：使用 Dart 编写命令行和服务端应用
---

Follow these steps to start using the Dart SDK to develop command-line and server apps.
First you’ll play with the Dart language and libraries in your browser, no download required.
Then you’ll install the Dart SDK, write a small program, and run that program using the Dart VM.
Finally, you'll use an AOT (_ahead of time_) compiler to compile your finished program to native machine code,
which you'll execute using the Dart runtime.

跟着下面这些步骤开始使用 Dart SDK 来开发命令行和服务器应用。首先你将在浏览器中运行 Dart 编程语言和库而不需要下载它。接着，你需要安装 Dart SDK 并尝试开发一个小程序，然后使用 Dart VM 运行它。最后你将使用一个 AOT（**预**）编译器将你刚才完成的程序编译为可以被 Dart 运行时执行的原生机器码。

## 1. Play with Dart code in DartPad

## 1. 在 DartPad 中运行 Dart 代码

With DartPad you can experiment with the Dart language and APIs,
no download necessary.

你可以使用 DartPad 来简单地尝试 Dart 编程语言和 API 且不需要下载任何东西。

For example, here's an embedded DartPad that lets you play with the code for a
small Hello World program. Click **Run** to run the app; the console output
appears beneath the code. Try editing the source code—perhaps you'd like to
change the greeting to use another language. To get the full DartPad experience,
<a href="{{site.dartpad}}/27e044ec9e2957d9c5c7062871ce8bf3" target="_blank">open
the example at dartpad.dev.</a>

例如，下面这个内嵌的 DartPad 可以让你尝试一个简单的 Hello World 程序代码。
点击**运行**来运行应用；控制台输出的内容位于代码块下方。
你可以尝试更改源代码，比如更改问候语或者其它的一些语句。
你也可以 <a href="{{site.dartpad}}/27e044ec9e2957d9c5c7062871ce8bf3" target="_blank">在 dartpad.dev 中打开示例</a> 
以获取更完整的 DartPad 体验。

{{site.alert.note}}

  {% include dartpad-embedded-troubleshooting.md %}
  
{{site.alert.end}}

<iframe
    src="{{site.dartpad-embed-inline}}?id=27e044ec9e2957d9c5c7062871ce8bf3"
    width="100%"
    height="300px"
    style="border: 1px solid #ccc;">
</iframe>

More information:

更多信息：

* [DartPad documentation][]

  [DartPad 文档][]

* [Dart language tour][]

  [Dart 语言概览][]

* [Dart library tour][]

  [Dart 库概览][]

## 2. Install Dart

## 2. 安装 Dart

{% include get-sdk.md %}

## 3. Get more command-line developer tools

## 3. 获取更多命令行开发工具

Install [`stagehand`,][stagehand] which gives you templates for creating Dart apps:

安装 [`stagehand`][stagehand]，该工具可以让你在创建 Dart 应用时提供模板：

```terminal
$ pub global activate stagehand
```

Note that although these instructions feature the command line,
many IDEs support Dart development.
Those IDEs use Stagehand behind the scenes when you create new Dart projects.

注意尽管这些指令以命令行的形式存在，但是许多 IDE 也支持使用这些指令进行 Dart 开发。当你创建一个新的 Dart 项目时，那些 IDE 在底层依然使用 Stagehand 来进行创建。

<!-- PENDING: the following instructions assume you have the bin directory for the system cache in your path. -->

More information:

更多信息：

* [Dart tools](/tools)

  [Dart 工具](/tools)

* [Running a script from your path](/tools/pub/cmd/pub-global#running-a-script-from-your-path)

  [从某个路径运行脚本](/tools/pub/cmd/pub-global#running-a-script-from-your-path)

## 4. Create a small app

## 4. 创建一个小应用

Create a command-line app:

创建一个命令行应用：

```terminal
$ mkdir cli
$ cd cli
$ stagehand console-full
```

These commands create a small Dart app that has the following:

这些命令创建一个包含下述信息的小 Dart 应用：

* A main Dart source file, `bin/main.dart`, that contains a top-level
  `main()` function. This is the entrypoint for your app.

  一个主要的 Dart 源文件，`bin/main.dart`，该文件包含一个顶层 `main()` 函数。该函数是你应用的入口。

* An additional Dart file, `lib/cli.dart`, that contains the functionality of
  the app and is imported by the `main.dart` file.

  一个额外的 Dart 文件，`lib/cli.dart`，包含一些功能性的函数方法，这些函数方法将会导入到 `main.dart` 文件中。

* A pubspec file, `pubspec.yaml`, that contains the app's metadata, including
  information about which [packages](/guides/packages) the app depends on
  and which versions of those packages are required.

  一个 pubspec 文件，`pubspec.yaml`，包含应用的元数据，包括应用依赖的 [包](/guides/packages) 信息以及所需的版本等。

## 5. Get the app's dependencies

## 5. 获取应用的依赖

Use the [`pub`](/tools/pub/cmd) command to get the packages
that the app depends on:

使用 [`pub`](/tools/pub/cmd) 命令获取应用依赖的包：

```terminal
$ pub get
```

## 6. Run the app

## 6. 运行应用

To run the app from the command line, use the Dart VM by running the
[`dart`](/tools/dart-vm) command:

为了从命令行运行应用，使用 [`dart`](/tools/dart-vm) 命令运行 Dart VM：

```terminal
$ dart bin/main.dart
Hello world: 42!
```

If you wish run the app with debugging support, see
[DevTools](/tools/dart-devtools).

## 7. Modify the app

## 7. 修改应用

Let's customize the app you just created.

 现在我们来自定义刚才你所创建的应用。

 1. Edit `lib/cli.dart` to calculate a different result. For example, divide the
    previous value by two (for details about `~/`, see [Arithmetic operators][]):

    编辑 `lib/cli.dart` 以返回一个不同的结果。例如，将先前的值除以2。
    （关于 `~/` 的详情请查看 [Arithmetic operators][]）：

    <?code-excerpt "misc/test/tutorial/get_started.dart (calculate)" replace="/~\/ 2/[!$&!]/g"?>
    {% prettify dart %}
    int calculate() {
      return 6 * 7 [!~/ 2!];
    }
    {% endprettify %}

 1. Save your changes.

    保存你刚才所做的改变。

 1. Rerun the main entrypoint of your app:

    重新运行你应用的入口 main 函数：

    ```terminal
    $ dart bin/main.dart
    Hello world: 21!
    ```

More information:
[Write command-line apps](/tutorials/server/cmdline)

更多信息：[开发命令行应用](/tutorials/server/cmdline)

## 8. Compile for production

## 8. 编译成正式产品

The steps above used the Dart VM (`dart`) to run the app. The Dart VM is
optimized for fast, incremental compilation to provide instant feedback
during development. Now that your small app is done,
it's time to AOT compile your Dart code to optimized native machine code.

上面的示例步骤我们使用的是 Dart VM（即 `dart` 命令）运行的应用。Dart VM 针对快速增量编译进行了优化，以便在开发过程中提供即时的响应。现在你的小应用已经完成，是时候 AOT 优化编译你的 Dart 代码为原生机器代码了。

Use the `dart2aot` tool to AOT compile the program to machine code:

使用 `dart2aot` 工具将程序 AOT 编译成机器代码：

```terminal
$ dart2aot bin/main.dart bin/main.dart.aot
```

Use the `dart2native` tool to AOT compile the program to machine code:

为了运行编译后的程序，使用 Dart 运行时（即 `dartaotruntime` 命令）：

```terminal
$ dart2native bin/main.dart -o bin/my_app
```
Notice how the compiled program starts instantly, completing quickly:

注意测量编译后的程序启动有多快：

```terminal
$ time bin/my_app
Hello world: 21!

real	0m0.016s
user	0m0.008s
sys	0m0.006s
```

## What next?

## 接下来做什么？

Check out these resources:

检索这些资源：

* Additional tutorials and codelabs for Dart

  其它额外的一些 Dart 教程和指引

  * [Tutorials](/tutorials)

    [教程](/tutorials)

  * [Codelabs](/codelabs)

    [指引](/codelabs)
    
* Dart language, libraries, and conventions

  Dart 语言、库以及习惯用法

  * [Sample code](/samples)

    [示例代码](/samples)

  * [Language tour](/guides/language/language-tour)

    [语言概览](/guides/language/language-tour)

  * [Library tour](/guides/libraries/library-tour)

    [库概览](/guides/libraries/library-tour)

  * [Effective Dart](/guides/language/effective-dart)

    [高效 Dart 编程](/guides/language/effective-dart)

* Tools and libraries

  工具和库

  * [Dart SDK](/tools/sdk)
  * [Dart tools](/tools)

    [Dart 工具](/tools)

  * [IDEs](/tools#ides-and-editors)

If you get stuck, find help at [Community and support.](/community)

如果你卡住了，可以从 [社区和帮助](/community) 中查找帮助。

[Arithmetic operators]: /guides/language/language-tour#arithmetic-operators
[stagehand]: {{site.pub-pkg}}/stagehand
[DartPad documentation]: /tools/dartpad
[Dart language tour]: /guides/language/language-tour
[Dart library tour]: /guides/libraries/library-tour
[ide]: /tools#ides-and-editors
