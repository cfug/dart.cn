---
title: DartPad
title: DartPad 线上工具
description: The tool that lets you interactively play with Dart in a browser.
description: 在浏览器里体验 Dart 编程语言的工具。
---

<a href="{{site.dartpad}}"
target="_blank">DartPad (dartpad.dev)</a>
is an open-source tool that
lets you play with the Dart language in any modern browser.
Here's what DartPad looks like:

<a href="{{site.dartpad}}" target="_blank">DartPad (dartpad.dev)</a> 是一个可以让你在任何现代化的浏览器中体验 Dart 编程语言的开源工具。DartPad 看起来是这样的：

<img src="{% asset dartpad-hello.png @path %}" alt="DartPad Hello World" />

<aside class="alert alert-info" markdown="1">
  **Tip:** If you're in China, try [dartpad.cn.](https://dartpad.cn)

  **提示：** 如果你在中国，请尝试使用 [dartpad.cn](https://dartpad.cn)。

  If you have issues using DartPad, see the [DartPad troubleshooting
  tips](/tools/dartpad/troubleshoot).

  如果你在使用 DartPad 的过程中有任何的问题，请查阅 [DartPad 疑难排查提示](/tools/dartpad/troubleshoot)。
</aside>

## Library support

## 可以在 DartPad 中使用的库

DartPad supports
[dart:* libraries]({{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}})
that work with web apps; it doesn't support
[dart:io]({{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-io) or
libraries from [packages.]({{site.pub}})
If you want to use dart:io, use the [Dart SDK](/tools/sdk) instead.
If you want to use a package, get the SDK for a
[platform](/platforms) that the package supports.

DartPad 支持 Web 应用所使用的 [dart:* 库]({{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}})；但不支持 [dart:io]({{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-io) 库以及从 [Package]({{site.pub}}) 中导入库。如果你想要使用 dart:io，请使用 [Dart SDK](/tools/sdk) 替代。如果你想要使用某个 Package，则获取该 Package 支持的 [平台](/platforms) 的 SDK。

## Getting started

## 开始体验

To get familiar with DartPad,
try running some samples and then creating a simple command-line app.

为了可以尽快熟悉 DartPad，你可以尝试在 DartPad 中运行一些示例，然后在 DartPad 中创建一个简单的命令行应用。

### Open DartPad, and run some samples {#step-1-open-and-run}

### 打开 DartPad 并运行一些示例 {#step-1-open-and-run}

<ol markdown="1">
  <li markdown="1">
  Go to <a href="{{site.dartpad}}" target="_blank">DartPad.</a>

  打开 <a href="{{site.dartpad}}" target="_blank">DartPad。</a>

  A sample appears on the left and the output appears on the right.
  If you've played with DartPad before,
  you can click **New Pad** to get back to the original sample.

  一个示例代码会出现在左边而代码运行后的输出则会出现在右边。如果你之前使用过 DartPad，你可以点击 **New Pad** 打开最原始的那个示例代码。
  </li>

  <li markdown="1">
  Click **Run**.

  点击 **Run**.

  The sample runs again, updating the output.

  示例代码就会开始/重新运行并显示/更新输出。
  </li>

  <li markdown="1">
  Choose an HTML sample like **Sunflower**,
  using the **Samples** list at the upper right.

  你可以使用右上方的 **Samples** 按钮从下拉列表中选择一个 HTML 示例，比如 **Sunflower**。

  Again, the output appears to the right.
  By default, you see the HTML output—what you'd see in a browser.

  在你点击选择示例后，它的输出会出现在右边输出框里。默认情况下，你看到的 HTML 输出与你将会在浏览器中看到的一致。
  </li>

  <li markdown="1">
  Click **CONSOLE** to view the sample's console output.

  点击 **CONSOLE** 你则会看到示例代码的控制台输出。
  </li>

  <li markdown="1">
  On the left, click the **HTML** tab to view the sample's HTML markup.

  在左边的边框中，点击 **HTML** 标签可以查看示例代码的 HTML 标记符。
  </li>
</ol>


### Create a command-line app {#step-2-server}

### 创建一个命令行应用 {#step-2-server}

To create a simple command-line app, use **New Pad**.

<ol markdown="1">
  <li markdown="1">
  Click the **New Pad** button,
  and confirm that you want to discard changes to the current pad.

  The source code for the Hello World app appears
  under the DART tab.
  </li>

  <li markdown="1">
  Clear the **Show web content** checkbox,
  at the bottom right of DartPad.

  The HTML and CSS tabs disappear.
  </li>

  <li markdown="1">
  Change the code. For example, change the `main()` function
  to contain this code:

<!-- library-tour/string-tests/bin/main.dart -->
{% prettify dart %}
for (var char in 'hello'.split('')) {
  print(char);
}
{% endprettify %}

  As you type, DartPad shows hints, documentation,
  and autocomplete suggestions.
  </li>

  <li markdown="1">
  Click the **Format** button.
  DartPad uses the [Dart formatter](https://github.com/dart-lang/dart_style#readme)
  to ensure that your code has proper indentation, white space, and line wrapping.
  </li>

  <li markdown="1">
  Run your app.
  </li>

  <li markdown="1">
  If you didn't happen to have any bugs while you were entering the code,
  try introducing a bug.

  For example, if you change `split` to `spit`,
  you get warnings at the bottom of the window and in the Run button.
  If you run the app, you'll see output from an uncaught exception.
  </li>
</ol>


## Checking Dart version info

## 检查 Dart 版本信息

The language features and APIs that DartPad supports depend on the
**Dart SDK** version that DartPad is based on.
You can find the SDK version at the bottom right of DartPad.

DartPad 支持的语言功能和 API 取决于 DartPad 使用的 **Dart SDK** 版本。你可以在 DartPad 的右下方找到其所使用的 SDK 版本。
