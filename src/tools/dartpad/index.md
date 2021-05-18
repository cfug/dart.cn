---
title: DartPad
title: DartPad 线上工具
description: The tool that lets you interactively play with Dart in a browser.
description: 在浏览器里体验 Dart 编程语言的工具。
---

DartPad is an [open source tool](https://github.com/dart-lang/dart-pad)
that lets you play with the Dart language in any modern browser.

DartPad 是一个可以让你在任何现代化的浏览器中体验 Dart 编程语言线上工具，
它是 [开源](https://github.com/dart-lang/dart-pad) 的。

Many pages in this site — especially [codelabs](/codelabs) —
have [embedded DartPads](#embedding).
To open DartPad as a standalone web page, visit 
the [DartPad site (dartpad.dev)][DartPad]{:target="_blank" rel="noopener"}.

本网页里一些页面，尤其是 [codelabs](/codelabs) 页面，包含了很多[内嵌的 DartPads](#embedding)。
你可以在浏览器里输入下面的网址打开一个 DartPad 页面。
<a href="{{site.dartpad}}"
target="_blank">DartPad 页面 (dartpad.cn).</a>

{{site.alert.tip}}

  If you're in China, try [dartpad.cn.](https://dartpad.cn)
  
  如果你在中国，请尝试使用 [dartpad.cn](https://dartpad.cn)。

  If you have issues using DartPad, see the [DartPad troubleshooting
  tips](/tools/dartpad/troubleshoot).
  
  如果你在使用 DartPad 的过程中有任何的问题，
  请查阅 [DartPad 常见问题页面](/tools/dartpad/troubleshoot)。
  
{{site.alert.end}}

Here's what DartPad looks like when configured to run Dart:

DartPad 看起来是这样的：

<img src="{% asset dartpad-hello.png @path %}" alt="Showcases what a Hello World app looks like in DartPad" />


## Library support

## 可以在 DartPad 中使用的库

DartPad supports `dart:*` [core libraries](/guides/libraries) marked as
multi-platform and web platform. When writing Flutter apps,
DartPad also supports the `package:flutter`
and `dart:ui` libraries.

DartPad 支持标记为支持多平台以及 web 平台的 `dart:*` [核心库](/guides/libraries)。
不支持原生平台的库，也不支持 [延迟加载][deferred loading]。

DartPad doesn't support [deferred loading][] or any other libraries. 
For example, DartPad doesn't support using packages from 
the [pub.dev]({{site.pub}}) package repository. 
(Package support might change; for details, see [issue 901][].)

DartPad 不支持 [延迟加载][deferred loading] 以及其他三方库。
例如，DartPad 不支持使用 [pub.dev]({{site.pub}}) 仓库中的 package。
（对于 Package 的支持之后可能会有所变化，详情请关注[issue 901][]。）

## Getting started

## 开始体验

To get familiar with DartPad,
try running some samples and creating a simple command-line app.

为了可以尽快熟悉 DartPad，
你可以尝试在 DartPad 中运行一些示例，然后在 DartPad 中创建一个简单的命令行应用。

### Open DartPad and run a sample {#step-1-open-and-run}

### 打开 DartPad 并运行一些示例 {#step-1-open-and-run}

1. Go to [DartPad][]{:target="_blank" rel="noopener"}.

   打开 [DartPad][]
   
   Dart code appears on the left, and 
   a place for the output appears on the right.

   Dart 示例代码会出现在左边，而代码运行后的输出则会出现在右边。


2. Choose a Flutter sample such as **Sunflower**, 
   using the **Samples** list at the upper right.

   选择一个 Flutter 样例，例如 **Sunflower**，使用右上角的 **样例** 列表。
   
   The rendered output appears to the right.

   它的输出会出现在右边输出框里。
  </li>
</ol>


### Create a command-line app {#step-2-server}

### 创建一个命令行应用 {#step-2-server}

To create a simple command-line app, use **New Pad**.

使用 **New Pad** 来创建一个简单的命令行应用。

1. Click the **New Pad** button,
   and confirm that you want to discard changes to the current pad.

   点击 **New Pad** 按钮并确认你想放弃当前 Pad 中的修改。

2. Click the Dart logo, make sure that **HTML** support is disabled,
   and then click **Create**.

   点击 Dart logo，确保 **HTML** 支持已禁用，接着点击 **Create**。

3. Change the code. For example, change the `main()` function
   to contain this code: 

   然后修改代码。比如将 `main()` 函数中的代码修改为如下：

   <!-- library-tour/string-tests/bin/main.dart -->
   {% prettify dart tag=pre+code %}
   for (var char in 'hello'.split('')) {
     print(char);
   }
   {% endprettify %}  
   
   As you type, DartPad shows hints, documentation,
   and autocomplete suggestions.

   在你输入的时候，DartPad 会显示提示、文档以及自动完成建议。

4. Click the **Format** button.  

   点击 **Format** 按钮。

   DartPad uses the [Dart formatter](/tools/dart-format)
   to ensure that your code has proper indentation, white space,
   and line wrapping.

   DartPad 会使用 [Dart 格式化器](https://github.com/dart-lang/dart_style#readme) 
   来格式化你的代码以确保有合适的缩进、空格和换行。

5. Run your app.

   运行你的应用。

6. If you didn't happen to have any bugs while you were entering the code,
   try introducing a bug.  

   如果你写的代码没有显示任何 BUG，那么请尝试自行写出一个 BUG。

   For example, if you change `split` to `spit`,
   you get warnings at the bottom right of the window.
   If you run the app, a compilation error appears in the console.

   如果你将 `split` 写成 `spit`，
   你会在 DartPad 窗口的底部以及 Run 按钮上看到一些警告信息。
   如果你强行运行应用，你将会在控制台中看到一个异常。



## Checking Dart version info

## 检查 Dart 版本信息

The language features and APIs that DartPad supports depend on the
**Dart SDK** version that DartPad is currently using.
You can find this SDK version at the bottom right of DartPad.

DartPad 支持的语言功能和 API 取决于 DartPad 使用的 **Dart SDK** 版本。
你可以在 DartPad 的右下方找到其所使用的 SDK 版本。

## Embedding DartPad in web pages {#embedding}

## 网页中嵌入 DartPad {#embedding}

You can embed DartPad inside of web pages,
customizing it to suit your use case.
For example, the [futures codelab][]
contains multiple embedded DartPads
labeled as _examples_ and _exercises_.

你可以将 DartPad 嵌入到网页中，根据你的用途对其进行自定义。
例如 [futures codelab][] 包含了多个嵌入的 DartPads
并把它们用作 _examples_ 和 _exercises_。

For more information about how to use embedded DartPads, see
[best practices for using DartPad in tutorials][].

更多有关如何使用嵌入式 DartPads 的相关信息，参见[使用 DartPad 的最佳实践指南][best practices for using DartPad in tutorials]。

For technical details on embedding DartPads, see the
[DartPad embedding guide.][]

有关嵌入式 DartPads 的具体技术细节，参见 [DartPad 嵌入指南。][DartPad embedding guide.]

[DartPad]: {{site.dartpad}}
[best practices for using DartPad in tutorials]: /resources/dartpad-best-practices
[DartPad embedding guide.]: https://github.com/dart-lang/dart-pad/wiki/Embedding-Guide
[deferred loading]: /guides/language/language-tour#lazily-loading-a-library
[futures codelab]: /codelabs/async-await
[issue 901]: https://github.com/dart-lang/dart-pad/issues/901
