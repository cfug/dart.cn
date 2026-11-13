---
# title: "How Dart’s null safety helped me augment my projects"
title: "Dart 空安全如何帮我改进项目"
# description: "I migrated a running app and a published package to null safety, and it was awesome!"
description: "我把一个运行中的应用和一个已发布的 package 迁移到了空安全，体验太棒了！"
ai-translated: true
publishDate: 2021-06-23
author: wal33d
image: images/1HlInW7jXUifJIGBK1YEQEw.webp
category: other
layout: blog
---

> **About the author:** Waleed Arshad is a core mobile technologist, a passionate cross-platform developer, and the first person from Pakistan to become a Google Developer Expert for Flutter. After graduating from FAST Karachi, he has been working in the industry for more than five years and is currently working in the Developer Experience team for Flutter at Tendermint. He also leads Pakistan’s Flutter community.

> **关于作者：**Waleed Arshad 是核心移动技术专家、
> 充满热情的跨平台开发者，也是巴基斯坦第一位
> Flutter Google 开发专家。从 FAST Karachi 毕业后，
> 他已在行业工作五年多，目前在 Tendermint 的
> Flutter 开发者体验团队工作。他还领导着巴基斯坦的
> Flutter 社区。

<DashImage src="images/1HlInW7jXUifJIGBK1YEQEw.webp" alt="Close-up of a code editor diff showing a Flutter SDK version constraint changed for null safety." />


With the launch of Flutter 2, null safety was made available to Flutter’s stable channel. This post talks about my personal experiences with migrating my apps and packages to null safety, along with creating null-safe apps from scratch. In short, the results were amazing!

随着 Flutter 2 发布，空安全进入了 Flutter 的稳定渠道。
这篇文章讲述我把应用和 package 迁移到空安全、
以及从零创建空安全应用的亲身经历。
简而言之，结果非常棒！
> If you aren’t aware of Flutter’s null safety feature, check out the [announcement of null safety](/blog/announcing-dart-null-safety-beta). If you want to fully understand null safety, check out [the Dart documentation for null safety](https://dart.dev/null-safety/understanding-null-safety).

> 如果你还不了解 Flutter 的空安全特性，
> 请查看[空安全公告](/blog/announcing-dart-null-safety-beta)。
> 想完全理解空安全，请查看
> [Dart 空安全文档](https://dart.dev/null-safety/understanding-null-safety)。

This article describes two of my experiences with null safety:

本文描述我与空安全的两段经历：

* Migrating an app and a package

  迁移一个应用和一个 package

* Writing new code in a null-safe environment

  在空安全环境中编写新代码

### Migrating an app and a package

### 迁移一个应用和一个 package

When I first upgraded Flutter to version 2.0 (the one that supports null safety) and updated my Dart SDK version to 2.12 in my Flutter app’s `pubspec.yaml` file, I saw a lot of errors. I wanted to initially try a manual migration to null safety (that is, migrate without the migration tool), so I started to resolve the null safety errors manually — adding question marks and exclamation points all over my code. I did all of that work intentionally, just to understand all the hard work done by the Flutter team on the [null safety migration tool](https://dart.dev/null-safety/migration-guide#migration-tool) to automate the process of changing and updating the code! After some experimentation, I reverted all the manual changes I’d made by hand, and I used the magic of the tool to complete the migration of my app.

当我第一次把 Flutter 升级到 2.0（支持空安全的版本），
并在 Flutter 应用的 `pubspec.yaml` 文件中把 Dart SDK
版本更新到 2.12 时，我看到了大量错误。
我起初想尝试手动迁移到空安全（即不用迁移工具），
于是开始手动解决空安全错误——在代码里到处加问号和感叹号。
我特意做了所有这些工作，只为体会 Flutter 团队在
[空安全迁移工具](https://dart.dev/null-safety/migration-guide#migration-tool)
上付出的努力——它把修改和更新代码的过程自动化了！
实验一番后，我撤销了所有手动改动，
用工具的魔法完成了应用迁移。

The application was an experimental COVID-19 stats app, and its code is fully open sourced. You can find it [on GitHub](https://github.com/wal33d006/novel_covid_19).

这个应用是一个实验性的新冠统计应用，代码完全开源。
你可以在 [GitHub](https://github.com/wal33d006/novel_covid_19)
上找到它。

It was really cool to see all the code changes the migration tool did in my project — code changes like adding question marks in nullables and adding exclamation points where the migration tool detected that the value was never going to be null.

看到迁移工具在我项目中做的所有代码改动真的很酷——
比如给可空类型加问号，在工具检测到值永远不会为 null
的地方加感叹号。

<DashImage src="images/14-Gy0ZFl5Sgn2Cw-LLn2lA.webp" alt="Diff from the null safety migration tool adding nullable markers to GlobalInfo, double, and HomeCountry fields." />


The following is an example of the migration tool automatically adding question marks and exclamation points . `_homeCountry` is a nullable property of a class named `HomeCountry` (which is also nullable). Therefore, to guard access to one of the properties of `_homeCountry`, the tool added the question mark operator.

下面是迁移工具自动添加问号和感叹号的例子。
`_homeCountry` 是名为 `HomeCountry` 的类的可空属性
（这个类本身也可空）。因此，为了保护对 `_homeCountry`
某个属性的访问，工具添加了问号运算符。

<DashImage src="images/1Cg1Ol3w_bIs6IIh734CBug.webp" alt="Code snippet showing the migration tool automatically adding question marks to nullable properties." />


After the migration, some issues in the code became evident, **which is the best part**.

迁移之后，代码中的一些问题浮出水面，**这是最棒的部分**。

<DashImage src="images/17nfnF2UAdK6zoIhX4wMG9w.webp" alt="Code snippet revealing an issue exposed after migrating to null safety." />


One of the issues was that some nullable strings were being passed as a list to an internal function of the [shared_preferences](https://pub.dev/packages/shared_preferences) plugin. Because these values were nullable, the tool made the whole list type `&lt;String?&gt;[]`*,* which started giving an error because the function accepted the type `&lt;String&gt;[]`*.*

其中一个问题是：一些可空字符串被作为 list 传给
[shared_preferences](https://pub.dev/packages/shared_preferences)
插件的内部函数。因为这些值可空，
工具把整个 list 类型变成了 `&lt;String?&gt;[]`*，*
于是开始报错，因为该函数接受的类型是 `&lt;String&gt;[]`*。*

<DashImage src="images/1ahhIw3H8kp5WGMjDmrSzLg.webp" alt="Analyzer error about passing nullable strings to a function expecting non-nullable strings." />


A simple solution to this problem was to remove the question mark and make the list type match the type of the function parameter. When I did that, the analyzer started saying that a nullable type (`String?`) can’t be assigned to a non-nullable type (`String`).

这个问题的简单解法是去掉问号，
让 list 类型与函数参数类型匹配。我这么做之后，
分析器开始说可空类型（`String?`）
不能赋给不可空类型（`String`）。

<DashImage src="images/1zHYqxaqdHWBdAILhoNMMrQ.webp" alt="Dart HomeCountry class with non-nullable String fields and required constructor parameters." />


To resolve the problem, I made each property of `HomeCountry` class non-nullable and added a `required` keyword in the constructor. That meant it was now necessary to pass the arguments while initializing `HomeCountry`. I didn’t have to change the `setHomeCountry` function because the variables being passed to the list were now non-nullable.

为了解决问题，我把 `HomeCountry` 类的每个属性
都改为不可空，并在构造函数中加了 `required` 关键字。
这意味着初始化 `HomeCountry` 时必须传入这些参数。
我不需要改 `setHomeCountry` 函数，
因为传给 list 的变量现在都不可空了。

This change prevented me from mistakenly sending a null value to shared preferences in my code, which was very valuable input by the null safety feature!

这个改动防止我在代码中误把 null 值发给 shared preferences，
这是空安全特性给出的非常有价值的提示！

Another thing null safety found was a bug that could cause a crash at runtime. See the following code snippet:

空安全发现的另一件事是一个可能导致运行时崩溃的 bug。
看下面的代码片段：

<DashImage src="images/1_uvcdlH2M7GvaW3tpgnTng.webp" alt="IDE warning on list index access because a nullable list might be null before indexing." />


Because `list` was a nullable variable, reading its index-based elements could cause a crash. After migrating to null safety, I couldn’t compile the app because there was no null check before reading the values in this list.

因为 `list` 是可空变量，按下标读取元素可能导致崩溃。
迁移到空安全后，应用无法编译，
因为读取这个 list 中的值之前没有 null 检查。

Ultimately, I added a null check to make the code compile and to prevent the app from crashing at this place in the code. It’s amazing how migrating helped me find an actual bug!

最终，我加了 null 检查让代码能编译，
并防止应用在这处代码崩溃。迁移帮我找到了一个真正的 bug，
太神奇了！

<DashImage src="images/1_a3XuVgmXlj9byIGPb-olg.webp" alt="Code snippet showing a null check added to make the setState code valid." caption="The code for setState is now valid because list isn’t null." />


I also happened to migrate a very small package, which you can find on [pub.dev](https://pub.dev/), called [progress_indicators](https://pub.dev/packages/progress_indicators). I was astonished to see how the migration tool added `late` keywords instead of question marks when it concluded that those variables were initialized before being used.

我还顺手迁移了一个很小的 package，
你可以在 [pub.dev](https://pub.dev/) 上找到它，叫
[progress_indicators](https://pub.dev/packages/progress_indicators)。
让我惊讶的是，当迁移工具判断某些变量在使用前
已初始化时，它加的是 `late` 关键字而不是问号。

<DashImage src="images/1Nfm_rVVsyCGnCLqWE1pvbQ.webp" alt="Code snippet showing the migration tool using late keywords for initialized variables." />


### Writing new code in a null-safe environment

### 在空安全环境中编写新代码

Now that Flutter has null safety, creating new apps is a better developer experience. Writing new code in a null-safe environment also provides a better understanding of code flows, along with being able to write crash-safe code. You cannot create compilable code with a class like this now:

现在 Flutter 有了空安全，创建新应用的开发体验更好了。
在空安全环境中写新代码还能让你更好地理解代码流，
并写出防崩溃的代码。现在这样的类无法通过编译：

```
class MyClass {
  String a;

  MyClass({this.a});
}
```


This code causes a compile-time error that says to mark `a` as nullable, put a `required` keyword in the constructor, or add an initializer. The code is making sure that `a` is never null. So, depending on your use case, you might do this:

这段代码导致编译期错误，提示把 `a` 标记为可空、
在构造函数中加 `required` 关键字，或添加初始化器。
代码在确保 `a` 永远不为 null。
所以，根据你的用例，你可以这样写：

```
class MyClass {
  String? a;

  MyClass({this.a});
}
```


Or you might do this:

或者这样写：

```
class MyClass {
  String a;

  MyClass({required this.a});
}
```

> Notice that you don’t put an at sign (`@`) before the `required` keyword, as of Flutter 2 (and Dart 2.12).

> 注意，从 Flutter 2（和 Dart 2.12）起，
> `required` 关键字前不加 at 符号（`@`）。

Or you might keep `a` as optional, but add an initializer giving it a default value if one isn’t passed:

或者保持 `a` 可选，但添加初始化器，
在没传值时给它一个默认值：

```
class MyClass {
  String a;

  MyClass({this.a = ''});
}
```


Also, now you can create nullable variables of your own created classes:

另外，现在你可以为自己创建的类声明可空变量：

```
class MyClass {
  String? a;

  MyClass({this.a});
}

// somewhere in main code

MyClass? myClass;
```


Because `myClass` has a nullable type, your compiler will give an error if you write something like this:

因为 `myClass` 是可空类型，如果你写出这样的代码，
编译器会报错：

```
print(myClass.a);
```


Here is the error:

错误如下：
> # The property ‘a’ can’t be unconditionally accessed because the receiver can be ‘null’.

> 属性 ‘a’ 不能被无条件访问，因为接收者可能为 ‘null’。

You can fix that error by adding a question mark:

加一个问号就能修复这个错误：

```
print(hello?.a);
```


Dart’s null safety feature makes sure that you write less vulnerable and safer code. Picking up errors related to null variables during compile time is a valuable addition to the development experience. The preceding example shows how the compiler stops you from compiling the code whenever it detects the possibility of a null-pointer exception causing the app to crash at runtime. This clearly means that the compiler tries to write null-safe code as much as possible (unless you use the `!` operator to force unwrap everything).

Dart 的空安全特性确保你写出更不易出错、更安全的代码。
在编译期捕获与 null 变量相关的错误，
是开发体验的宝贵补充。前面的例子展示了编译器
一旦检测到空指针异常可能导致应用运行时崩溃，
就会阻止代码编译。这清楚地表明编译器尽可能
帮你写出空安全的代码（除非你用 `!` 运算符
强行解包一切）。

In conclusion, Dart’s sound null safety is a credible kick starter for building safer, faster, and more reliable apps! The overall coding experience is now highly formulated and more organized. I recommend that you migrate your old Dart apps to null safety to understand how it works. Maybe you’ll be lucky enough to find and fix some bugs in your old code!

总之，Dart 的健全空安全是构建更安全、更快、
更可靠应用的可信起点！整体编码体验现在高度规范、
更有条理。我建议你把旧的 Dart 应用迁移到空安全，
了解它如何工作。也许你会幸运地发现并修复
旧代码中的一些 bug！

Happy coding! :)

祝编码愉快！:)
