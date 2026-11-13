---
# title: "Why I’m joining the Dart team, of all places"
title: "我为什么偏偏加入 Dart 团队"
# description: "Two weeks ago, I transferred to the Dart team. For many, this was an obvious career move but there were some people who were genuinely surprised about it."
description: "两周前，我转到了 Dart 团队。对很多人来说这是显而易见的职业选择，但也有些人对此真心感到惊讶。"
ai-translated: true
publishDate: 2016-01-07
author: filiph
image: images/19XE0rGIm0oY0GOs5onZyvQ.webp
category: other
layout: blog
---


**UPDATE May 2018:** It’s 2 years later and this article still gets hundreds of reads a month. I should note some of the things below are outdated. For example, when I say “soon, you’ll be able to write Dart code for native Android and iOS apps” below — that’s already [very much possible](https://flutter.io/). So, enjoy this historical piece.

**2018 年 5 月更新：**两年过去了，这篇文章每月仍有数百次阅读。
需要说明下文有些内容已经过时。例如，我在下面说
“很快你就能用 Dart 为原生 Android 和 iOS 应用写代码”——
这已经[完全可行](https://flutter.io/)了。
所以，请把这篇当作历史文章来读。

<DashImage src="images/1BMKEJA3Ej-Yxa6lx7mct7A.webp" alt="Social media comment by Aleš Pecha saying, 'Wow, hope you won't be riding a dead horse then ;)'." caption="One of the well-meaning responses." />


Responses ranged from mild astonishment to friendly teasing to outright negativity. I don’t blame them: to many people, Dart is a strange animal. You can find plenty of smart developers on the internet who strongly believe Dart won’t be successful or that it has already failed.

反应从轻度惊讶到友好调侃，再到彻底的负面都有。
我不怪他们：对很多人来说，Dart 是个奇怪的物种。
网上有大量聪明的开发者坚信 Dart 不会成功，
或者认为它已经失败了。

I strongly believe the opposite. I might be wrong, of course, but I’m sure enough about Dart that I’m betting my career on it.

我坚信相反的结论。当然，我可能错了，
但我对 Dart 的信心足以让我押上自己的职业生涯。

So, here are a couple of reasons why I believe in Dart’s bright future. Obviously, you should keep in mind that *I’m a Google employee, on the Dart team*. I am as biased as anyone can get. If you want a non-Google-employee take, you have [other](http://astashov.github.io/blog/2015/11/18/when-dart-is-a-good-choice/) [options](http://mattbriggs.net/blog/2014/03/10/how-i-learned-to-stop-worrying/).

下面就是我相信 Dart 光明未来的几个理由。
显然，你要记住*我是 Google 员工，在 Dart 团队*。
我的偏见程度无人能及。如果你想看非 Google 员工的观点，
还有[其他](http://astashov.github.io/blog/2015/11/18/when-dart-is-a-good-choice/)
[选择](http://mattbriggs.net/blog/2014/03/10/how-i-learned-to-stop-worrying/)。

## **1. Dart is a big deal at Google**

## 1. Dart 在 Google 是件大事

<DashImage src="images/19XE0rGIm0oY0GOs5onZyvQ.webp" alt="Meme from the movie Zoolander humorously emphasizing that Dart is a big deal." caption="Obligatory Zoolander reference." />


I can’t share the actual numbers (yet?) but there is a lot of Dart code being written at Google. Many lines of code. Every day.

我不能分享具体数字（也许以后可以？），
但 Google 内部正在编写大量 Dart 代码。
很多行代码。每一天。

Almost all of the code is mission critical. Dart is used by the product team that brings majority of the revenue to Google.

几乎所有这些代码都是任务关键型的。
为 Google 带来大部分收入的产品团队就在使用 Dart。

On top of that, Dart recently joined an exclusive club of only a handful of programming languages that require a special process for code reviews at Google.

除此之外，Dart 最近加入了一个专属俱乐部：
在 Google 只有少数几种编程语言的代码 review
需要特殊流程，Dart 是其中之一。

In other words, Dart will be a success even if nobody except Google uses it. Having a lively community is of course a huge, *huge* blessing for any technology. It’s just that in the case of Dart, this definitely isn’t a requirement for survival right now.

换句话说，即使除了 Google 没人用 Dart，它也会成功。
拥有活跃的社区对任何技术当然都是巨大的、*巨大的*福气。
只是对 Dart 而言，这目前绝对不是生存的必要条件。

## **2. Dart is very actively maintained**

## 2. Dart 维护非常活跃

Dart is stable now — currently v1.13 — but that doesn’t mean work on it has stopped or even slowed down. If you look at [github.com/dart-lang](https://github.com/dart-lang), you’ll see 139 repositories pertaining to Dart that are maintained by Google. Let’s have a look just at the core ([sdk](https://github.com/dart-lang/sdk)) repo.

Dart 现在很稳定——当前是 v1.13——
但这不意味着开发停止甚至放缓了。
看看 [github.com/dart-lang](https://github.com/dart-lang)，
你会看到 Google 维护着 139 个与 Dart 相关的仓库。
我们只看核心（[sdk](https://github.com/dart-lang/sdk)）仓库。

For the last month, which included Christmas holidays, GitHub Pulse [reports](https://github.com/dart-lang/sdk/pulse/monthly):

上个月（包含圣诞假期），GitHub Pulse
[报告](https://github.com/dart-lang/sdk/pulse/monthly)：
> # *Excluding merges, **32** authors have pushed **408** commits to master and 412 commits to all branches. On master, 828 files have changed and there have been 93,059 additions and 88,236 deletions.*

> *不含合并，**32** 位作者向 master 推送了 **408** 个提交，
> 向所有分支推送了 412 个提交。master 上有 828 个文件变更，
> 新增 93,059 行，删除 88,236 行。*

Compare these numbers to those of other similar projects developed in the open, such as [Rust](https://github.com/rust-lang/rust/pulse/monthly), [Go](https://github.com/golang/go/pulse/monthly), [Scala](https://github.com/scala/scala/pulse/monthly), [TypeScript](https://github.com/Microsoft/TypeScript/pulse/monthly) or [Ruby](https://github.com/ruby/ruby/pulse/monthly).

把这些数字与其他公开开发的类似项目对比一下，比如
[Rust](https://github.com/rust-lang/rust/pulse/monthly)、
[Go](https://github.com/golang/go/pulse/monthly)、
[Scala](https://github.com/scala/scala/pulse/monthly)、
[TypeScript](https://github.com/Microsoft/TypeScript/pulse/monthly)
或 [Ruby](https://github.com/ruby/ruby/pulse/monthly)。

I’m not saying that commit velocity is equivalent to quality or anything like that. But it should tell you something about the investment, the focus, and the rate of improvement.

我不是说提交速度等同于质量之类的。
但它应该能让你了解投入、专注度和改进速度。

Programming languages and their standard libraries are complex beasts that are never finished.

编程语言及其标准库是永远不会完工的复杂巨兽。

A popular programmer fantasy is that you design a beautiful, elegant system and then — it just works. They key word here is: ‘fantasy’. Yes, the technologies we use every day are often elegant in design but *more importantly* the best ones have a huge amount of work (and re-work) behind them.

程序员中流行一种幻想：设计一个漂亮优雅的系统，
然后——它就能用了。这里的关键词是：“幻想”。
是的，我们每天使用的技术往往设计优雅，
但*更重要的是*，最好的那些背后都有海量工作
（以及返工）。

Oh, and it’s not just about the quantity, of course. The team behind Dart is made of seasoned Google SWEs. People like Kasper and Lars (of V8 fame), Gilad (of Java lang spec fame), John (of inotify fame) contribute daily. And then there are guest stars like Erik (of C# and Rx fame). In my mind, the quality of SWEs is the best predictor of the quality of the technology they’re building.

哦，当然不只是数量。Dart 背后的团队由资深 Google
软件工程师组成。像 Kasper 和 Lars（V8 的名人）、
Gilad（Java 语言规范的名人）、John（inotify 的名人）
每天都在贡献。还有 Erik（C# 和 Rx 的名人）这样的客座明星。
在我看来，工程师的质量是其所构建技术质量的最佳预测指标。

## **3. Dart will soon run everywhere**

## 3. Dart 很快将无处不在

Dart’s first target was the web, but from the beginning it was designed as a general purpose programming language.

Dart 的第一个目标是 Web，但从一开始
它就被设计为通用编程语言。

<YoutubeEmbed id="jjffmNHYHlc" title="Conway's Game of Life sample in Dart, running on Raspberry Pi + Sense HAT" fullwidth="true"/>


* You can compile Dart to JavaScript that runs in every browser.

  你可以把 Dart 编译成在每个浏览器中运行的 JavaScript。

* You can write command line tools and even servers in Dart.

  你可以用 Dart 编写命令行工具，甚至服务器。

* [Soon](http://dart-lang.github.io/fletch/), you’ll be able to write Dart code for micro-processors (think Raspberry Pi) and — more interestingly — for micro-*controllers* (think Arduino). This means developing for really compact, really cheap, really low-energy devices is no longer a C/C++/asm club.

  [很快](http://dart-lang.github.io/fletch/)，你就能为
  微处理器（想想树莓派）——更有趣的是为微*控制器*
  （想想 Arduino）——编写 Dart 代码。这意味着为极小巧、
  极便宜、极低能耗的设备开发不再是 C/C++/汇编的专属俱乐部。

* [Soon](http://flutter.io/), you’ll be able to write Dart code for native Android and iOS apps.

  [很快](http://flutter.io/)，你就能用 Dart
  为原生 Android 和 iOS 应用写代码。

## **4. Dart is stable and consistent**

## 4. Dart 稳定且一致

I’ve noticed that even early adopters are getting tired of the constant change in tooling and libraries *du jour*.

我注意到，即使是早期采用者，
也开始厌倦工具和*当红*库的不断变化。

Dart is evolving, yes, but projects you wrote a year or two ago still use the same standard lib, the same language features, and the same package & dependency manager.

Dart 在演进，没错，但你一两年前写的项目
仍然使用同样的标准库、同样的语言特性、
同样的 package 和依赖管理器。

Even apart from that, there are ‘dartisan’ ways to do things — most Dart code I’ve seen follows the [official](https://www.dartlang.org/effective-dart/) Style Guide, Usage Guide and Design Guide. Readability is valued in the Dart community.

除此之外，做事还有“Dart 匠人”的方式——
我见过的大多数 Dart 代码都遵循
[官方](https://www.dartlang.org/effective-dart/)的
风格指南、使用指南和设计指南。
Dart 社区重视可读性。

## **5. Programming in Dart feels right (to me)**

## 5. 用 Dart 编程感觉对（对我而言）

Ok, this is subjective. But let’s face it, our dev stack choices often are. If you can help it, you tend to use what feels right to you. Some developers love JavaScript, others hate it — although it’s still the same language. Same for Java, PHP, Ruby, or Dart.

好吧，这很主观。但说实话，我们对开发栈的选择往往就是主观的。
只要有的选，你就倾向于用感觉对的东西。
有些开发者爱 JavaScript，有些恨它——尽管还是同一门语言。
Java、PHP、Ruby 或 Dart 也一样。

A big reason why I’m perfectly willing to bet my career on Dart is that it’s not just me. There are a [lot](http://www.cnet.com/news/mixbook-sees-perfect-storm-for-googles-dart-language-q-a/) [of](http://suretalent.blogspot.cz/2012/04/dart-language-in-javascript-and-delphi.html) [smart](http://simonpai.github.io/2014/09/03/quire-building-with-dart/) [people](https://news.ycombinator.com/item?id=8222640) who use it and like the experience.

我完全愿意把职业生涯押在 Dart 上的一个重要原因是：
不止我一个人这么想。有
[很多](http://www.cnet.com/news/mixbook-sees-perfect-storm-for-googles-dart-language-q-a/)
[聪明人](http://suretalent.blogspot.cz/2012/04/dart-language-in-javascript-and-delphi.html)
[在使用它](http://simonpai.github.io/2014/09/03/quire-building-with-dart/)
[并喜欢这种体验](https://news.ycombinator.com/item?id=8222640)。

<YoutubeEmbed id="6p-Z6TXoN10" title="Notch recreating Doom in Dart (stream excerpt)" fullwidth="true"/>


Why? Dart is not for everyone, but for a particular type of developer it can be a breath of fresh air.

为什么？Dart 不适合所有人，
但对某一类开发者来说，它可以是一股清新的空气。

* It’s familiar (no weird syntax masturbation), especially if you’re coming from C#, ActionScript, Java, C, and the like.

  它很熟悉（没有奇怪的语法炫技），
  尤其当你来自 C#、ActionScript、Java、C 之类的语言。

* It’s unsurprising (no wtf semantics).

  它不出人意料（没有让人 WTF 的语义）。

* It gets out of your way (*optional* types, unsoundness, GC, everything-is-an-object, mirrors)…

  它不挡你的路（*可选*类型、非健全性、GC、
  一切皆对象、mirrors）……

* … but it lets you write robust code (optional *types*, optional generics, libraries, packages, transformers).

  ……但它也让你写出健壮的代码（可选*类型*、
  可选泛型、库、package、transformers）。

* It makes it easy to do the usual things (async/await, string interpolation, this.field, null-aware operators).

  它让常见的事情变得容易（async/await、字符串插值、
  this.field、null-aware 运算符）。

* It comes with a well-thought-out standard lib.

  它自带一个深思熟虑的标准库。

So there you have it. During 2016 I think much of what I’m describing above will start to make more sense to more people.

就是这样。我认为在 2016 年，
上面描述的很多东西会开始让更多人觉得有道理。

But at least now you know why (I think) my transfer to the Dart team isn’t a complete brainfart.

但至少现在你知道为什么（我认为）
我转到 Dart 团队不是完全的脑子进水了。
