---
# title: "Dart diagnostic messages"
title: "Dart 诊断信息"
# description: "Understanding error and warning messages from the Dart analyzer"
description: "理解 Dart 分析器的错误和警告信息"
ai-translated: true
publishDate: 2021-11-11
author: bwilkerson
image: images/1kUNsHzJZkZNRysNJmbNTdw.webp
category: deep-dive
layout: blog
---


Have you ever seen an error message and wondered what it means and what you should do about it? There might be more information available to help you answer those questions than you realize.

你是否见过一条错误信息，想知道它是什么意思、该怎么处理？其实，能帮你回答这些问题的信息可能比你意识到的要多。

Let’s take a fairly common example. There’s a problem in the following code:

来看一个相当常见的例子。下面的代码有个问题：

<DashImage src="images/1KDUXUtf0E8hb0kZBeIUdSA.webp" alt="A Dart code snippet showing a compilation error for an unchecked use of a nullable value." />


In IntelliJ IDEA, the message is visible in the Dart Analysis view:

在 IntelliJ IDEA 中，这条信息显示在 Dart Analysis 视图里：

<DashImage src="images/1mjwyDt_bsYpTZBPwLbFhwg.webp" alt="Dart Analysis view in IntelliJ IDEA displaying an unchecked use of nullable value diagnostic message." />


In Visual Studio Code, the problem message appears in the Problems panel:

在 Visual Studio Code 中，问题信息显示在 Problems 面板里：

<DashImage src="images/1XTJeTrWGGKzxfQv41qVfug.webp" alt="A screenshot showing the Problems panel in Visual Studio Code with the problem message." />


It seems odd that there’s a problem because we just checked that `values` isn’t `null`on the line above.

这似乎有点奇怪：我们明明在上一行刚检查过 `values` 不是 `null`，怎么还会有问题。

The message tells us what’s wrong, but it doesn’t really help us understand why the check wasn’t sufficient or how to respond to the error. That extra information is actually available; it just might not be obvious how to find it. The rest of this article shows you how to find the location of this extra information in the output of [IntelliJ IDEA](https://www.jetbrains.com/idea/), [Visual Studio Code](https://code.visualstudio.com/), and the `dart analyze` command-line tool.

这条信息告诉了我们哪里出了问题，却没有真正帮我们理解为什么那次检查不够、该如何应对这个错误。这些额外信息其实是有的，只是可能不太容易发现怎么找到它们。本文余下部分将告诉你，如何在 [IntelliJ IDEA](https://www.jetbrains.com/idea/)、[Visual Studio Code](https://code.visualstudio.com/) 和 `dart analyze` 命令行工具的输出中找到这些额外信息的位置。

### IntelliJ IDEA

### 在 IntelliJ IDEA 中

If you hover over the highlighted text you can get more information:

把鼠标悬停在高亮文本上，就能看到更多信息：

<DashImage src="images/1m2K6XXsAfB7gK0oBPGNwag.webp" alt="A screenshot displaying hover text over the diagnostic message with context and correction information." />


The hover includes the message we saw above (which we call the *problem message*), but it also includes other useful information:

悬停提示包含上面看到的那条信息（我们称之为*问题信息*），还包含其他有用的信息：

* A link to [external documentation about the diagnostic](https://dart.dev/tools/diagnostic-messages#unchecked_use_of_nullable_value)

  指向[该诊断的外部文档](https://dart.dev/tools/diagnostic-messages#unchecked_use_of_nullable_value)的链接

* A *context message* that explains why the null comparison wasn’t sufficient to promote the type of the property to be non-nullable

  一条*上下文信息*，解释为什么这次 null 比较不足以把该属性的类型提升为非空类型

* A *correction message* that describes some of the things you can do to correct the code

  一条*修正信息*，描述你可以采取哪些做法来修正代码

The context message includes the URL of additional documentation related to type promotion and tells you the line and file on which the field is defined. Unfortunately you can’t navigate to the context location from the hover, but you can from the Dart Analysis view.

上下文信息包含与类型提升相关的补充文档的 URL，并告诉你该字段定义所在的行和文件。遗憾的是，你无法从悬停提示跳转到上下文位置，但可以从 Dart Analysis 视图跳转。

Although the Dart Analysis view displays only the problem message, double-clicking the message navigates you to the text with the red squiggly underline where the problem is being reported. For other useful features, bring up the context menu:

虽然 Dart Analysis 视图只显示问题信息，但双击这条信息就能跳转到报告问题处带红色波浪下划线的文本。要使用其他实用功能，请打开上下文菜单：

<DashImage src="images/1KUQaTyshPTkO9eF0Rdxe2w.webp" alt="IDE context menu showing Jump to Source and Open Documentation options." />


With the context menu, you can navigate to either the location where the diagnostic was reported (using **Jump to Source**, which works just like double-clicking the problem message) or to the declaration of `values` (using the menu item labeled by the context message). Selecting **Open Documentation** opens the external documentation about the diagnostic.

借助上下文菜单，你既可以跳转到报告诊断的位置（使用 **Jump to Source**，效果与双击问题信息相同），也可以跳转到 `values` 的声明处（使用以上下文信息命名的菜单项）。选择 **Open Documentation** 则会打开关于该诊断的外部文档。

### Visual Studio Code

### 在 Visual Studio Code 中

In Visual Studio Code there are two ways to see the extra information. The first is to expand the entry in the Problems panel:

在 Visual Studio Code 中，有两种方式查看这些额外信息。第一种是展开 Problems 面板中的条目：

<DashImage src="images/1qsXBZQMBgk6W5WaUBOQ_bA.webp" alt="A screenshot showing an expanded entry in the Problems panel displaying context and correction messages." />


The first line is the message we saw before (which we call the *problem message*). Double-clicking either the first or second line navigates you to the text with the red squiggly underline where the problem is.

第一行是我们之前看到的那条信息（我们称之为*问题信息*）。双击第一行或第二行，都会跳转到问题所在处带红色波浪下划线的文本。

The second line is a *correction message* that describes some of the things you can do to correct the code. It also contains a link, labeled by the ID of the diagnostic, that opens [external documentation about the diagnostic](https://dart.dev/tools/diagnostic-messages#unchecked_use_of_nullable_value).

第二行是一条*修正信息*，描述你可以采取哪些做法来修正代码。它还包含一个以诊断 ID 命名的链接，点击可打开[关于该诊断的外部文档](https://dart.dev/tools/diagnostic-messages#unchecked_use_of_nullable_value)。

The third line is a *context message* that explains why the null comparison wasn’t sufficient to promote the type to be non-nullable. Double-clicking the context message navigates you to the declaration of `values`. The context message includes the URL of additional documentation related to type promotion.

第三行是一条*上下文信息*，解释为什么这次 null 比较不足以把类型提升为非空类型。双击上下文信息会跳转到 `values` 的声明处。上下文信息还包含与类型提升相关的补充文档的 URL。

You can also see this information by hovering over the highlighted text, which causes hover text to be opened:

你也可以把鼠标悬停在高亮文本上查看这些信息，这会打开悬停提示：

<DashImage src="images/1kUNsHzJZkZNRysNJmbNTdw.webp" alt="A screenshot demonstrating hover text in Visual Studio Code revealing additional problem details." />


The hover text contains the same information as the Problems panel. It contains a link to take you to the external documentation and another link to navigate to the declaration of `values`.

悬停提示包含与 Problems 面板相同的信息：一个链接带你前往外部文档，另一个链接跳转到 `values` 的声明处。

### dart analyze

### dart analyze 命令

The command-line analyzer `dart analyze` can display the same information as the IDEs, but you need to use the`--verbose`flag to see all of it.

命令行分析器 `dart analyze` 能显示与 IDE 相同的信息，但你需要使用 `--verbose` 标志才能看到全部内容。

<DashImage src="images/1GtSPY3IoZDeGkfkolrXO7A.webp" alt="A terminal output screenshot demonstrating the detailed diagnostic messages provided by the dart analyze --verbose command." />


### Summary

### 总结

I hope this article helps you more easily find the information you need to understand the analyzer’s diagnostics.

希望这篇文章能帮你更轻松地找到理解分析器诊断所需的信息。

If you find diagnostics that are still hard to understand — because the message isn’t clear, it needs a context message to help you find other related code locations, or the documentation isn’t complete enough — please let us know by [creating a dart-lang/sdk issue](https://github.com/dart-lang/sdk/issues/new). We’re always interested in improving the tools.

如果你发现仍有难以理解的诊断——比如信息不够清晰、需要上下文信息来帮你找到其他相关代码位置，或者文档不够完整——请[创建 dart-lang/sdk issue](https://github.com/dart-lang/sdk/issues/new) 告诉我们。我们始终乐于改进这些工具。
