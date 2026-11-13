---
# title: "Bulk application of fixes"
title: "批量应用修复"
# description: "Fixing multiple analysis issues in one step"
description: "一步修复多个分析问题"
ai-translated: true
publishDate: 2022-05-05
author: bwilkerson
image: images/0URmNnWSjGRGOorjv.webp
category: other
layout: blog
---


In [Quick fixes for analysis issues](/blog/quick-fixes-for-analysis-issues) we looked at support for automatically fixing individual diagnostics while editing. Sometimes even that’s too slow and you’d really like to fix multiple diagnostics all at once. Fortunately, there’s support for that too, which we cover in this article.

在[分析问题的快速修复](/blog/quick-fixes-for-analysis-issues)一文中，我们介绍了编辑时自动修复单个诊断的支持。有时连这都嫌慢，你会希望一次性修复多个诊断。幸运的是，这也有相应的支持，本文就来介绍。

There are several ways to fix multiple diagnostics, depending on just how many diagnostics you want to fix, and we’ll look at each one separately.

修复多个诊断有好几种方式，取决于你想修复多少诊断，我们会逐一介绍。

## Fixing multiple occurrences of the same diagnostics

## 修复同一诊断的多次出现

Have you ever refactored your code by moving a class to a different file? If so, it’s fairly likely that some imports were only needed because of references in the class being moved, which leaves you with unused imports:

你是否重构过代码，把某个类移到另一个文件？如果是，很可能有些 import 只是因为被移走的类中的引用才需要，于是就留下了未使用的 import：

<DashImage src="images/0URmNnWSjGRGOorjv.webp" alt="A code snippet in Visual Studio Code showing unused import warnings." caption="[Visual Studio Code](https://code.visualstudio.com/)" />


<DashImage src="images/03QaE0FunXWpPp2Az.webp" alt="A code snippet in IntelliJ IDEA showing unused import warnings." caption="[IntelliJ IDEA](https://www.jetbrains.com/idea/)" />


For any fix that can be applied more than once within the same file, the tooling offers an option to apply it everywhere in the file.

对于任何可以在同一文件中多次应用的修复，工具都提供了一个选项，把它应用到文件中的所有位置。

These fixes show up in the same places as other fixes and are usually labeled similarly to the single location fixes, but with some phrase like “in file” added. For example, here’s how this fix appears in your IDE:

这些修复出现的位置与其他修复相同，标签通常也与单处修复类似，只是加上了类似 “in file” 的字样。例如，这个修复在你的 IDE 中是这样的：

<DashImage src="images/0p2Pf06L6A4JSX7IS.webp" alt="A context menu in Visual Studio Code offering to remove all unused imports in the file." caption="[Visual Studio Code](https://code.visualstudio.com/)" />


<DashImage src="images/0S4UnOqdx-h0U55jU.webp" alt="A context menu in IntelliJ IDEA offering to remove all unused imports in the file." caption="[IntelliJ IDEA](https://www.jetbrains.com/idea/)" />


Selecting the “in-file” fix does exactly what you’d expect — it removes all unused imports in the file:

选择这个“文件内”修复的效果正如你所料——它会移除文件中所有未使用的 import：

<DashImage src="images/0dHw4rjdxTR0liZX8.webp" alt="The code snippet in Visual Studio Code after removing unused imports." caption="[Visual Studio Code](https://code.visualstudio.com/)" />


<DashImage src="images/0Wk6qnyUlNr3qN0GQ.webp" alt="The code snippet in IntelliJ IDEA after removing unused imports." caption="[IntelliJ IDEA](https://www.jetbrains.com/idea/)" />


## Fixing all the diagnostics in a file

## 修复文件中的所有诊断

That’s great, but it only fixes a single kind of diagnostic, and it requires you to find the place where the diagnostic is being reported (either in the editor or in the problems view) to invoke the fix. It seems like the tooling could do more.

这很好，但它只能修复一种诊断，而且需要你先找到报告诊断的位置（在编辑器或问题视图中）才能调用修复。工具似乎还能做得更多。

And in [Visual Studio Code](https://code.visualstudio.com/), it can. You can apply fixes for all the diagnostics within a single file. To see how, we’ll use the same example as above:

在 [Visual Studio Code](https://code.visualstudio.com/) 中，确实可以。你可以为单个文件中的所有诊断应用修复。为了演示，我们沿用上面的例子：

<DashImage src="images/0mr1A2XnnRCaamU22.webp" alt="A code editor showing multiple unused import warnings marked with blue squiggly lines." />


If you right click to open the context menu, you’ll see the following:

右键打开上下文菜单，你会看到：

<DashImage src="images/03klKEJk5p40lCPbO.webp" alt="The right-click context menu in Visual Studio Code with 'Source Action...' highlighted." />


If you select **Source Action…**, it opens a second menu:

选择 **Source Action…** 会打开第二层菜单：

<DashImage src="images/0iRZIzPrwKl7jEYNY.webp" alt="The 'Source Action...' menu in Visual Studio Code displaying 'Sort Members', 'Organize Imports', and 'Fix All' options." />


Selecting **Fix All** causes fixes to be applied to all the diagnostics in the editor, producing the following:

选择 **Fix All** 会对编辑器中的所有诊断应用修复，得到如下结果：

<DashImage src="images/0FDf16dDPwfPg_dET.webp" alt="The code editor after selecting 'Fix All', showing the unused imports have been successfully removed." />


You can also invoke the **Fix All** command from the command palette, which you can open by selecting **Command Palette…** from the **View** menu, or by using the keyboard shortcut (`F1` on any platform, `Control+Shift+P` on Windows and Linux, or `Command+Shift+P` on macOS). You can filter the list by typing the name of the command. The command palette looks something like this:

你也可以从命令面板调用 **Fix All** 命令。打开命令面板的方式是：从 **View** 菜单选择 **Command Palette…**，或使用快捷键（任何平台上都是 `F1`，Windows 和 Linux 上是 `Control+Shift+P`，macOS 上是 `Command+Shift+P`）。输入命令名称可以筛选列表。命令面板大致是这样的：

<DashImage src="images/0Jrz3MRfYVtcXrb9C.webp" alt="The Visual Studio Code command palette with 'fix' typed into the search bar, showing the 'Fix All' command." />


## Fixing all the diagnostics in a directory

## 修复目录中的所有诊断

The most complete tool we have for fixing diagnostics is the `[dart fix](https://dart.dev/tools/dart-fix)` command-line tool. It can fix all the diagnostics in a given directory, which means that you can use it to fix everything in your package or application.

我们拥有的最完整的诊断修复工具是 `[dart fix](https://dart.dev/tools/dart-fix)` 命令行工具。它能修复给定目录中的所有诊断，也就是说你可以用它修复整个 package 或应用中的所有问题。

Of course, there are a couple of caveats. It doesn’t fix every diagnostic, because it applies the same quick fixes that are available in the IDE, and there aren’t quick fixes for every diagnostic. It also doesn’t apply quick fixes for diagnostics when there are multiple equally valid ways of fixing the problem, because it can’t know which fix you prefer to apply. These caveats also apply to the **Fix All** command described in the previous section.

当然，有几点需要注意。它并不能修复所有诊断，因为它应用的是与 IDE 中相同的快速修复，而并非每个诊断都有快速修复。当一个问题有多种同样有效的修复方式时，它也不会应用快速修复，因为它无法知道你更想用哪一种。这些限制同样适用于上一节介绍的 **Fix All** 命令。

While the need for this tool doesn’t come up often (which is one reason you might not know about it), there are a couple of situations where it’s especially useful.

虽然用到这个工具的场景不多（这也是你可能不知道它的原因之一），但有几种情况下它特别有用。

First, consider the case where you want to enable a new lint, or even a set of lints, such as one of the [`core`](https://github.com/dart-lang/lints/blob/main/lib/core.yaml), [`recommended`](https://github.com/dart-lang/lints/blob/main/lib/recommended.yaml), or [`flutter`](https://github.com/flutter/packages/blob/master/packages/flutter_lints/lib/flutter.yaml) rule sets. Chances are good that there are at least a few violations of the lint rules in your package. If there’s a fix associated with the lint, then it’s convenient to apply that fix everywhere in one step rather than applying the fix to each violation individually.

首先，考虑你想启用一条新 lint、甚至一整套 lint 的情况，比如 [`core`](https://github.com/dart-lang/lints/blob/main/lib/core.yaml)、[`recommended`](https://github.com/dart-lang/lints/blob/main/lib/recommended.yaml) 或 [`flutter`](https://github.com/flutter/packages/blob/master/packages/flutter_lints/lib/flutter.yaml) 规则集之一。你的 package 里很可能至少有几处违反这些 lint 规则的地方。如果该 lint 有关联的修复，那么一步就把修复应用到所有位置，显然比逐个违规处应用修复更方便。

Second, consider the case where you’re updating from one release of Flutter to another. If there have been API changes between the two releases, there’s a good chance that there’s a fix to upgrade your code to conform to the latest release. Again, it’s convenient if all of those changes are applied in a single operation.

其次，考虑你从 Flutter 的一个版本升级到另一个版本的情况。如果两个版本之间有 API 变更，很可能有对应的修复能把你的代码升级到符合最新版本。同样，如果所有这些改动都能在一次操作中应用，那就方便多了。

That’s where the [`dart fix`](https://dart.dev/tools/dart-fix) command comes in. It can apply quick fixes for multiple diagnostics in multiple files.

这正是 [`dart fix`](https://dart.dev/tools/dart-fix) 命令的用武之地。它可以为多个文件中的多个诊断应用快速修复。

The command has two modes. The *dry-run* mode tells you how many changes it can apply and which diagnostics it can fix, but without modifying any files. The *apply* mode applies the changes.

这个命令有两种模式。*dry-run* 模式告诉你它能应用多少改动、能修复哪些诊断，但不会修改任何文件。*apply* 模式则会应用这些改动。

You can provide the path to the directory containing the files to be fixed, but if you omit the directory it recursively fixes all the files in the current directory and its subdirectories.

你可以提供包含待修复文件的目录路径；如果省略目录，它会递归修复当前目录及其子目录中的所有文件。

Let’s assume that you’ve enabled the `prefer_single_quotes` lint, and that you have a file containing the following:

假设你启用了 `prefer_single_quotes` lint，并且有一个包含以下内容的文件：

```
import 'package:logging/logging.dart';

void main() {
  var logger = Logger("myApp");
  logger.info("Entering myApp");
  // Do stuff.
  logger.info("Exiting myApp");
}
```


Running the [`dart fix`](https://dart.dev/tools/dart-fix) command with the `--dry-run` option from the directory containing this file produces the following output:

在包含该文件的目录中，带 `--dry-run` 选项运行 [`dart fix`](https://dart.dev/tools/dart-fix) 命令，会产生以下输出：

```
$ dart fix --dry-run
Computing fixes in __bin__ (dry run)... 4.3s

3 proposed fixes in 1 file.

demo.dart
  prefer_single_quotes • 3 fixes
```


The tool has found three violations of the lint and reports that it’s able to fix all three, but it doesn’t modify the file.

工具找到了三处违反该 lint 的地方，并报告它可以全部修复，但它没有修改文件。

Running the [`dart fix`](https://dart.dev/tools/dart-fix) tool again, but this time with the `--apply` option, produces almost the same output:

再次运行 [`dart fix`](https://dart.dev/tools/dart-fix) 工具，这次带上 `--apply` 选项，输出几乎相同：

```
$ dart fix --apply
Computing fixes in __bin__... 5.3s
Applying fixes...         0.0s

3 proposed fixes in 1 file.

demo.dart
  prefer_single_quotes • 3 fixes

3 fixes made in 1 file.
```


But this time the file is updated to contain the following:

但这次文件被更新为以下内容：

```
import 'package:logging/logging.dart';

void main() {
  var logger = Logger('myApp');
  logger.info('Entering myApp');
  // Do stuff.
  logger.info('Exiting myApp');
}
```


Because the dry-run mode doesn’t produce any kind of diff output that allows you to see the actual changes that are being proposed, **consider committing your changes before running the tool using the `--apply` option**. That way it’s easier to see what changes the tool has actually made and to revert any changes you don’t like.

由于 dry-run 模式不会输出任何形式的 diff 让你查看它建议的实际改动，**建议在使用 `--apply` 选项运行工具之前先提交你的改动**。这样更容易看清工具实际做了哪些改动，也方便回退你不喜欢的改动。

If you don’t want to commit before running the tool, and you’re using IntelliJ IDEA, you can use the **File-&gt;Local History** feature to compare the state before and after applying the fixes. (For more information see [Add labels to specific states Local History](https://www.jetbrains.com/help/idea/local-history.html#label-local-history-revisions).)

如果你不想在运行工具前提交，并且使用的是 IntelliJ IDEA，可以用 **File-&gt;Local History** 功能比较应用修复前后的状态。（更多信息参见 [Add labels to specific states Local History](https://www.jetbrains.com/help/idea/local-history.html#label-local-history-revisions)。）

The [`dart fix`](https://dart.dev/tools/dart-fix) command can’t fix every problem, but when it can, it’s much easier than manually applying the fix everywhere.

[`dart fix`](https://dart.dev/tools/dart-fix) 命令不能修复所有问题，但在它能修复的时候，比手动到处应用修复要轻松得多。

## Summary

## 总结

Being able to apply multiple fixes in a single operation not only increases the power of quick fixes, but might also make it easier to make larger scale changes, such as enabling a new lint rule or upgrading to the latest version of Flutter.

能够在一次操作中应用多个修复，不仅增强了快速修复的威力，还可能让更大规模的改动变得更容易，比如启用新的 lint 规则或升级到最新版本的 Flutter。

As always, if you have ideas for how to improve these tools, please let us know by [creating a dart-lang/sdk issue](https://github.com/dart-lang/sdk/issues/new).

一如既往，如果你有改进这些工具的想法，请[创建 dart-lang/sdk issue](https://github.com/dart-lang/sdk/issues/new) 告诉我们。
