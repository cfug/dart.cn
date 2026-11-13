---
# title: "Quick fixes for analysis issues"
title: "分析问题的快速修复"
# description: "Resolving diagnostics with a single click"
description: "一键解决诊断问题"
ai-translated: true
publishDate: 2022-03-04
author: bwilkerson
image: images/0PHnbrlzf5BzJAyp8.webp
category: other
layout: blog
---


If you’re like me, too much of your development time is spent fixing problems (diagnostics) the analyzer finds. If you’ve ever wished it could be easier, then I have some good news for you. Many of the diagnostics the analyzer produces can be fixed automatically using quick fixes.

如果你和我一样，开发时间里有太多花在了修复分析器发现的问题（诊断）上。如果你曾希望这件事能更轻松一些，那我有个好消息告诉你：分析器产生的许多诊断都可以用快速修复（quick fix）自动修复。

A *quick fix* is an automated edit targeted at fixing the issue reported by a specific diagnostic. In the [Dart diagnostic messages](/blog/dart-diagnostic-messages) article, we looked at the following code:

*快速修复*是一种自动编辑，专门用于修复某个特定诊断报告的问题。在 [Dart 诊断信息](/blog/dart-diagnostic-messages)一文中，我们看过下面这段代码：

<DashImage src="images/0PHnbrlzf5BzJAyp8.webp" alt="Code snippet showing an error with quick fix suggestions." />


The correction message suggests two ways of resolving the problem: “Try making the access conditional (using ‘?.’) or adding a null check to the target (‘!’).”

修正信息给出了两种解决问题的方法：“尝试把这次访问改为条件访问（使用 ‘?.’），或给目标添加 null 检查（‘!’）。”

If you click in the highlighted region (the area with the red squiggly underline), you’ll see a light bulb icon near the left edge of the editor. If you hover over it, you can then click to open a menu containing the available quick fixes.

如果你点击高亮区域（带红色波浪下划线的部分），就会在编辑器左边缘附近看到一个灯泡图标。把鼠标悬停在上面，再点击即可打开包含可用快速修复的菜单。

Both of the suggested corrections are available from the menu. Selecting one applies the change to your code. For example, if you select the first fix, it updates the code to the following:

菜单里提供了建议的两种修正方法。选择其中一种就会把改动应用到你的代码上。例如，选择第一个修复后，代码会更新为：

<DashImage src="images/0kv6ByFzA_oUH-1J-.webp" alt="Dart code after applying a quick fix, replacing values.length with values?.length inside a null check." />


Let’s first take a quick look at how to apply a fix in both [IntelliJ IDEA](https://www.jetbrains.com/idea/) and [Visual Studio Code](https://code.visualstudio.com/), then look at a more powerful example of what quick fixes can do.

我们先快速看看如何在 [IntelliJ IDEA](https://www.jetbrains.com/idea/) 和 [Visual Studio Code](https://code.visualstudio.com/) 中应用修复，然后再看一个更能体现快速修复威力的例子。

## IntelliJ IDEA

## 在 IntelliJ IDEA 中

The context actions menu in the editor looks like the following:

编辑器中的上下文操作菜单如下所示：

<DashImage src="images/0SSy3gV3OrvEOjqyY.webp" alt="IntelliJ IDEA context actions menu offering to replace '.' with '?.' or add a null check for values.length." />


You can access the same list by selecting “Show Context Actions” from the context menu in the editor or by using its keyboard equivalent (**Alt+Enter** on Windows and Linux, or **Option+Enter** on macOS).

你也可以从编辑器的上下文菜单中选择 “Show Context Actions”，或使用对应的快捷键（Windows 和 Linux 上是 **Alt+Enter**，macOS 上是 **Option+Enter**）来打开同一份列表。

You can also invoke these fixes directly from the hover text when you hover over the highlighted region. If there are too many fixes, there’s a **More Actions** item also opens the menu:

把鼠标悬停在高亮区域上时，你还可以直接从悬停提示中调用这些修复。如果修复太多，会有一个 **More Actions** 项，同样可以打开菜单：

<DashImage src="images/09fUhfo7YYZeSkbwJ.webp" alt="IntelliJ IDEA hover text explaining that values.length can't be unconditionally accessed and offering the ?. quick fix." />


If that’s not enough, you can also invoke the available fixes from the context menu in the Dart Analysis view:

如果这还不够，你也可以从 Dart Analysis 视图的上下文菜单中调用可用的修复：

<DashImage src="images/0KOFAwRRqF1nxP-X4.webp" alt="Dart Analysis context menu in IntelliJ IDEA offering quick fixes for the nullable values.length diagnostic." />


## Visual Studio Code

## 在 Visual Studio Code 中

The code actions menu in the editor looks like the following:

编辑器中的代码操作菜单如下所示：

<DashImage src="images/06MrUQEB2aHocDDXS.webp" alt="Visual Studio Code actions menu offering to replace '.' with '?.' or add a null check for values.length." />


The first two items are the quick fixes, the others are refactorings. You can access the same list by using its keyboard equivalent (**Control+.** on Windows and Linux, or **Command+.** on MacOS), or by selecting **Quick Fix …** from the hover text in the editor:

前两项是快速修复，其余是重构操作。你可以使用对应的快捷键（Windows 和 Linux 上是 **Control+.**，MacOS 上是 **Command+.**），或者从编辑器的悬停提示中选择 **Quick Fix …** 来打开同一份列表：

<DashImage src="images/0t9j1bNBN9t_H_vGm.webp" alt="An IDE showing the Problems panel in Visual Studio Code with a quick fix menu open offering to replace '.' with '?.'." />


You can also invoke them from the context menu in the Problems panel:

你也可以从 Problems 面板的上下文菜单中调用它们：

<DashImage src="images/0rD7c_L6FPLusv6lm.webp" alt="The Visual Studio Code context menu for a problem entry showing 'Quick Fix' and 'Copy' options." />


## Another example

## 另一个例子

While the fix above saves you the time and effort of finding the correction message and then making the edit by hand, adding a single character is admittedly not a huge time-saver. However, some fixes provide a bigger productivity boost. Consider the following code:

虽然上面的修复省去了你查找修正信息再手动编辑的时间和精力，但只添加一个字符确实算不上节省了大量时间。不过，有些修复能带来更大的生产力提升。看看下面这段代码：

<DashImage src="images/0JudcB_TM8lvc32Ld.webp" alt="An IDE showing the code 'await file.readAsString();' with a red squiggly line under 'await' and an error about using await in a non-async function." />


The diagnostic tells you that “the await expression can only be used in an async function.” Assuming that you don’t want to use synchronous I/O, the correction is to mark the body of the function with the `async` keyword. Doing that causes another error telling you that the return type of the method needs to be `Future`, so you’ll also end up updating the return type.

诊断告诉你“await 表达式只能在 async 函数中使用”。假设你不想使用同步 I/O，修正方法就是给函数体加上 `async` 关键字。这样做又会引发另一个错误，提示该方法的返回类型需要是 `Future`，于是你还得更新返回类型。

Fortunately, there’s a quick fix for the original problem:

幸运的是，最初那个问题有一个快速修复：

<DashImage src="images/0sgdKZfY_KVOLiIJU.webp" alt="An IDE showing the quick fix menu with 'Add async modifier' highlighted to fix the 'await' error." />


Selecting this fix not only adds the modifier, but also updates the return type, allowing you to fix the problem in one step:

选择这个修复不仅会添加修饰符，还会更新返回类型，让你一步就解决问题：

<DashImage src="images/0WW-9wW23CnKxWZO2.webp" alt="An IDE showing the code after the quick fix, now with the 'async' keyword and the return type updated to a Future of String." />


## Summary

## 总结

Not every problem can be fixed automatically, and there isn’t a quick fix for every problem that could have one. Nevertheless, it’s definitely worth checking to see whether there’s an available quick fix the next time you have a diagnostic to fix. And if you don’t see a fix for a diagnostic that ought to have one, please let us know by [creating a dart-lang/sdk issue](https://github.com/dart-lang/sdk/issues/new).

并不是每个问题都能自动修复，也不是每个本可以有快速修复的问题都已经有了。尽管如此，下次你要修复诊断时，绝对值得先看看有没有可用的快速修复。如果你发现某个理应有修复的诊断却没有修复，请[创建 dart-lang/sdk issue](https://github.com/dart-lang/sdk/issues/new) 告诉我们。
