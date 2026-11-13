---
# title: "Quick assists for editing"
title: "编辑时的快速辅助操作"
# description: "Using localized refactorings to be more productive"
description: "用局部重构提高生产力"
ai-translated: true
publishDate: 2022-07-13
author: bwilkerson
image: images/0V2JRi49yUj_MkFjS.webp
category: other
layout: blog
---


Do you spend too much time performing repetitive tasks while coding? If so, then I have some good news for you. Many of the repetitive tasks can be performed automatically using a feature we call quick assists.

你是否在写代码时花了太多时间做重复性工作？如果是，那我有个好消息告诉你：许多重复性工作都可以用一个我们称为快速辅助操作（quick assist）的功能自动完成。

A *quick assist* is an automated edit targeted at making a common change to the code. Unlike a quick fix, which we looked at in [Quick fixes for analysis issues](/blog/quick-fixes-for-analysis-issues) and [Bulk application of fixes](/blog/bulk-application-of-fixes), the presence of a quick assist isn’t a suggestion that you should change your code, it’s simply there to make your work easier.

*快速辅助操作*是一种自动编辑，专门用于对代码做常见的改动。与快速修复不同——我们在[分析问题的快速修复](/blog/quick-fixes-for-analysis-issues)和[批量应用修复](/blog/bulk-application-of-fixes)中介绍过它——快速辅助操作的出现并不是在建议你修改代码，它只是为了让你的工作更轻松。

Let’s look at a couple of examples.

来看几个例子。

## Declaring local variables

## 声明局部变量

You likely spend a fair bit of time declaring and initializing local variables. The tools can help with some of that. If you type the initializer expression then you can use a quick assist to create a local variable to capture the value of the expression.

你可能花了不少时间声明和初始化局部变量。工具可以帮你分担其中一部分。如果你输入了初始化表达式，就可以用一个快速辅助操作创建局部变量来接收该表达式的值。

If you start with the code below and place the cursor anywhere in the expression, then the lightbulb icon appears near the left edge of the editor. If you hover over it you can then click to open a menu containing the available quick assists.

从下面的代码开始，把光标放在表达式中的任意位置，编辑器左边缘附近就会出现灯泡图标。把鼠标悬停在上面，再点击即可打开包含可用快速辅助操作的菜单。

<DashImage src="images/0V2JRi49yUj_MkFjS.webp" alt="Visual Studio Code showing the quick assist menu to extract a local variable." caption="[Visual Studio Code](https://code.visualstudio.com/)" />


<DashImage src="images/0SH7NIMTeCdgyE2Uf.webp" alt="IntelliJ IDEA showing the quick assist menu to extract a local variable." caption="[IntelliJ IDEA](https://www.jetbrains.com/idea/)" />


Choosing the assist inserts a variable declaration, using the expression as the initializer, and selects the name of the variable so that you can either choose one of the suggested names or type your own name:

选择这个辅助操作会插入一个变量声明，用该表达式作为初始化器，并选中变量名，这样你既可以从建议的名称中挑一个，也可以输入自己的名称：

<DashImage src="images/0zkIBfG56juJk2AuT.webp" alt="Visual Studio Code after extracting a local variable." caption="[Visual Studio Code](https://code.visualstudio.com/)" />


<DashImage src="images/0jfAvjus6m7-TCP4S.webp" alt="IntelliJ IDEA after extracting a local variable." caption="[IntelliJ IDEA](https://www.jetbrains.com/idea/)" />


Pressing the enter/return key accepts the entered name.

按下 enter/return 键即可确认输入的名称。

## Function body styles

## 函数体风格

If you frequently use expression bodied functions, then you’ve likely needed to convert one into a block bodied function at some point. There’s an assist for that too. For example, if you have code like the following and you place the cursor inside the arrow, you’ll see the following options:

如果你经常使用表达式函数体的函数，那你多半也遇到过需要把它转换成块函数体的时候。这也有对应的辅助操作。例如，对于下面这样的代码，把光标放在箭头里，就会看到以下选项：

<DashImage src="images/0hp1u0YSRQsoNMaJl.webp" alt="Visual Studio Code showing the quick assist to convert an expression body to a block body." caption="[Visual Studio Code](https://code.visualstudio.com/)" />


<DashImage src="images/0Ca5bRUzZ-Y4dHkw2.webp" alt="IntelliJ IDEA showing the quick assist to convert an expression body to a block body." caption="[IntelliJ IDEA](https://www.jetbrains.com/idea/)" />


Selecting “Convert to block body” rewrites the function body to look like this:

选择 “Convert to block body” 会把函数体重写为：

<DashImage src="images/0mU7Y97eTeCILB1sr.webp" alt="Visual Studio Code after converting to a block body." caption="[Visual Studio Code](https://code.visualstudio.com/)" />


<DashImage src="images/0miez1wvKHge96Ggl.webp" alt="IntelliJ IDEA after converting to a block body." caption="[IntelliJ IDEA](https://www.jetbrains.com/idea/)" />


And, yes, there’s another assist that converts from a block body to an expression body.

没错，还有另一个辅助操作可以把块函数体转换回表达式函数体。

## Rewriting if statements

## 重写 if 语句

Assists can also help with bigger restructurings. If you’ve ever written code structured like this:

辅助操作还能帮你完成更大规模的代码重组。如果你写过这样结构的代码：

```
void f(int a, int b, int c, int d) {
  if (a == b) {
    if (a == c || a == d) {
      print(0);
    }
  }
}
```


and realized that you could combine the two conditions, there’s an assist for that. Put the cursor on the inner `if` and open the menu:

然后意识到可以把两个条件合并，这也有对应的辅助操作。把光标放在内层 `if` 上并打开菜单：

<DashImage src="images/06C745jOIAaB-k0f-.webp" alt="Visual Studio Code showing the quick assist to join an if statement with an outer if statement." caption="[Visual Studio Code](https://code.visualstudio.com/)" />


<DashImage src="images/09mRjNGVqm82qAeg0.webp" alt="IntelliJ IDEA showing the quick assist to join an if statement with an outer if statement." caption="[IntelliJ IDEA](https://www.jetbrains.com/idea/)" />


Selecting “Join ‘if’ statement with outer ‘if’ statement” rewrites the code to look like this:

选择 “Join ‘if’ statement with outer ‘if’ statement” 会把代码重写为：

```
void f(int a, int b, int c, int d) {
  if (a == b && (a == c || a == d)) {
    print(0);
  }
}
```


The assist also shows up if you put the cursor on the outer `if`, though the menu then reads “Join ‘if’ statement with inner ‘if’ statement”.

把光标放在外层 `if` 上也会出现这个辅助操作，只是菜单项会变成 “Join ‘if’ statement with inner ‘if’ statement”。

## Using newer language features

## 使用更新的语言特性

There are also assists to help you convert to newer language features. For example, if you have a class like this:

还有一些辅助操作可以帮你改用更新的语言特性。例如，如果你有这样的类：

```
class A {
  A({int? x, int? y});
}

class B extends A {
  B({int? x, int? y}) : super(x: x, y: y);
}
```


where the constructor in the subclass passes some parameters to the superclass without modifying them, there’s a cleaner way to write the code. Put the cursor on the name of the constructor `B` and open the menu:

其中子类的构造函数把一些参数原封不动地传给超类，其实有更简洁的写法。把光标放在构造函数 `B` 的名称上并打开菜单：

<DashImage src="images/0PGLOLXQPGGTZFTCE.webp" alt="Visual Studio Code showing the quick assist to convert to using super parameters." caption="[Visual Studio Code](https://code.visualstudio.com/)" />


<DashImage src="images/0pfrf--11lE_B1oTf.webp" alt="IntelliJ IDEA showing the quick assist to convert to using super parameters." caption="[IntelliJ IDEA](https://www.jetbrains.com/idea/)" />


Selecting “Convert to using super parameters” rewrites the code to look like this:

选择 “Convert to using super parameters” 会把代码重写为：

<DashImage src="images/0Lr2HLGu31CqL5JLd.webp" alt="Visual Studio Code after converting to super parameters." caption="[Visual Studio Code](https://code.visualstudio.com/)" />


<DashImage src="images/0nHsQKP9Wtm1UZn6-.webp" alt="IntelliJ IDEA after converting to super parameters." caption="[IntelliJ IDEA](https://www.jetbrains.com/idea/)" />


There are more assists available than we can cover in a single article. The next time you find yourself about to perform an edit that you do all the time, check out the context actions to see whether there’s an assist to make the task easier.

可用的辅助操作远不止一篇文章能介绍完的。下次当你又要做那种经常重复的编辑时，不妨看看上下文操作里有没有能让这项任务更轻松的辅助操作。
