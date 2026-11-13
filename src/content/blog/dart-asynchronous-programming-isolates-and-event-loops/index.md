---
# title: "Dart asynchronous programming: Isolates and event loops"
title: "Dart 异步编程：隔离与事件循环"
# description: "Dart, despite being a single-threaded language, offers support for futures, streams, background work, and all the other things you need to…"
description: "Dart 虽然是单线程语言，却支持 future、流、后台工作，以及以现代、异步、（在 Flutter 中）响应式的方式编写代码所需的一切。本文介绍其基础：隔离与事件循环。"
ai-translated: true
publishDate: 2019-07-25
author: kwalrath
image: images/1t-mHg6JrdkKCs65UvD70-Q.webp
category: deep-dive
layout: blog
---


Dart, despite being a single-threaded language, offers support for futures, streams, background work, and all the other things you need to write in a modern, asynchronous, and (in the case of Flutter) reactive way. This article covers the foundations of Dart’s support for background work: *isolates* and *event loops*.

Dart 虽然是一门单线程语言，却支持 future、流（stream）、后台工作，
以及以现代的、异步的、（在 Flutter 中）响应式的方式编写代码
所需的其他一切。本文介绍 Dart 后台工作支持的基础：
*隔离（isolate）*与*事件循环（event loop）*。

If you prefer to learn by watching or listening, everything in this article is covered in the following video, which is part of the *Flutter in Focus* video series *Asynchronous Programming in Dart:*

如果你更喜欢通过观看或收听来学习，
本文的所有内容都包含在下面这个视频中，
它是 *Flutter in Focus* 视频系列
《Dart 异步编程》（*Asynchronous Programming in Dart*）的一部分：

<YoutubeEmbed id="vl_AaCgudcY" title="Isolates and Event Loops - Flutter in Focus" fullwidth="true"/>


Still here? Let’s talk about isolates.

还在看？那我们来聊聊隔离。

## Isolates

## 隔离（Isolate）

An *isolate* is what all Dart code runs in. It’s like a little space on the machine with its own, private chunk of memory and a single thread running an event loop.

所有 Dart 代码都运行在*隔离*中。
它就像机器上的一个小空间，
拥有自己私有的一块内存，以及一个运行事件循环的线程。

<DashImage src="images/1xtjhmzoLQEmh7Od1BkroVg.webp" alt="Single isolate card containing a memory grid above circular event-loop arrows." caption="An isolate has its own memory and a single thread of execution that runs an event loop." />


In a lot of other languages like C++, you can have multiple threads sharing the same memory and running whatever code you want. In Dart, though, each thread is in its own isolate with its own memory, and the thread just processes events (more on that in a minute).

在 C++ 等许多其他语言中，你可以让多个线程共享同一块内存，
运行你想要的任何代码。但在 Dart 中，
每个线程都在自己的隔离里，拥有自己的内存，
线程只负责处理事件（稍后详述）。

Many Dart apps run all their code in a single isolate, but you can have more than one if you need it. If you have a computation to perform that’s so enormous it could cause you to drop frames if it were run in the main isolate, then you can use [Isolate.spawn()](https://api.dartlang.org/stable/dart-isolate/Isolate/spawn.html) or [Flutter’s compute() function](https://flutter.dev/docs/cookbook/networking/background-parsing#4-move-this-work-to-a-separate-isolate). Both of those functions create a separate isolate to do the number crunching, leaving your main isolate free to — say— rebuild and render the widget tree.

许多 Dart 应用把所有代码都运行在单个隔离中，
但需要时你也可以使用多个。
如果你有一项庞大的计算，放在主隔离（main isolate）里运行
可能会导致丢帧，那么你可以使用
[Isolate.spawn()](https://api.dartlang.org/stable/dart-isolate/Isolate/spawn.html)
或 [Flutter 的 compute() 函数](https://flutter.dev/docs/cookbook/networking/background-parsing#4-move-this-work-to-a-separate-isolate)。
这两个函数都会创建一个单独的隔离来做数值计算，
让你的主隔离腾出手来——比如说——重建和渲染 widget 树。

<DashImage src="images/1MnJQG2bdbcqmEwu1lSL52Q.webp" alt="Two separate isolate cards, each with its own memory grid and event-loop arrows." caption="Two isolates, each with its own memory and thread of execution." />


The new isolate gets its own event loop and its own memory, which the original isolate — even though it’s the parent of this new one — isn’t allowed to access. That’s the source of the name *isolate*: these little spaces are kept *isolated* from one another.

新隔离拥有自己的事件循环和自己的内存，
原来的隔离——尽管它是新隔离的父级——也不允许访问这些内存。
这就是 *isolate* 这个名字的由来：
这些小空间彼此之间保持*隔离*。

In fact, the only way that isolates can work together is by passing messages back and forth. One isolate sends a message to the other, and the receiving isolate processes that message using its event loop.

事实上，隔离之间协作的唯一方式就是来回传递消息（message）。
一个隔离向另一个发送消息，
接收方隔离用自己的事件循环处理这条消息。

<DashImage src="images/1kxDfLtL2ySN1yiY1nmcTrA.webp" alt="Two isolate cards with a message marker entering the second isolate's event loop." caption="Isolates can send messages to other isolates." />


This lack of shared memory might sound kind of strict, especially if you’re coming from a language like Java or C++, but it has some key benefits for Dart coders.

这种不共享内存的做法听起来可能有点严格，
尤其是如果你来自 Java 或 C++ 这样的语言，
但它给 Dart 开发者带来了一些关键的好处。

For example, memory allocation and garbage collection in an isolate don’t require locking. There’s only one thread, so if it’s not busy, you know the memory isn’t being mutated. That works out well for Flutter apps, which sometimes need to build up and tear down a bunch of widgets quickly.

例如，隔离中的内存分配和垃圾回收（garbage collection）不需要加锁。
只有一个线程，所以只要它不忙，你就知道内存没有被修改。
这对 Flutter 应用很有利，
因为它们有时需要快速构建和销毁大量 widget。

## Event loops

## 事件循环

Now that you’ve had a basic introduction to isolates, let’s dig in to what really makes asynchronous code possible: the *event loop*.

在对隔离有了基本了解之后，
让我们深入看看真正让异步代码成为可能的东西：*事件循环*。

Imagine the life of an app stretched out on a timeline. The app starts, the app stops, and in between a bunch of events occur — I/O from the disk, finger taps from the user… all kinds of stuff.

想象把一个应用的生命周期铺在一条时间线上。
应用启动，应用停止，中间发生了一大堆事件——
磁盘 I/O、用户的手指点击……各种各样的。

Your app can’t predict when these events will happen or in what order, and it has to handle all of them with a single thread that never blocks. So, the app runs an event loop. It grabs the oldest event from its event queue, processes it, goes back for the next one, processes it, and so on, until the event queue is empty.

你的应用无法预测这些事件何时发生、以什么顺序发生，
而且必须用一个永不阻塞的线程处理所有事件。
于是，应用运行一个事件循环。
它从事件队列中取出最旧的事件，处理它，
再回去取下一个，处理它，如此往复，直到事件队列为空。

The whole time the app is running — you’re tapping on the screen, things are downloading, a timer goes off — that event loop is just going around and around, processing those events one at a time.

在应用运行的整个过程中——你在点击屏幕、
有东西在下载、定时器触发了——
事件循环只是不停地转啊转，一次处理一个事件。

<DashImage src="images/1t-mHg6JrdkKCs65UvD70-Q.webp" alt="Queued events moving one at a time toward a gear with circular event-loop arrows." caption="The event loop processes one event at a time." />


When there’s a break in the action, the thread just hangs out, waiting for the next event. It can trigger the garbage collector, get some coffee, whatever.

当没有事情可做时，线程就闲待着，等待下一个事件。
它可以触发垃圾回收器，喝杯咖啡，随便干点什么。

All of the high-level APIs and language features that Dart has for asynchronous programming — futures, streams, async and await — they’re all built on and around this simple loop.

Dart 为异步编程提供的所有高层 API 和语言特性——
future、流、async 和 await——
全都构建在这个简单的循环之上、围绕着它。

For example, say you have a button that initiates a network request, like this one:

例如，假设你有一个发起网络请求的按钮，就像这个：

```dart
RaisedButton(
  child: Text('Click me'),
  onPressed: () {
    final myFuture = http.get('https://example.com');
    myFuture.then((response) {
      if (response.statusCode == 200) {
        print('Success!');
      }
    });
  },
)
```

When you run your app, Flutter builds the button and puts it on screen. Then your app waits.

运行应用时，Flutter 构建这个按钮并把它放到屏幕上。
然后你的应用开始等待。

Your app’s event loop just sort of idles, waiting for the next event. Events that aren’t related to the button might come in and get handled, while the button sits there waiting for the user to tap on it. Eventually they do, and a tap event enters the queue.

你的应用的事件循环差不多处于空闲状态，等待下一个事件。
与按钮无关的事件可能会进来并被处理，
而按钮就待在那里等着用户点击。
最终用户点了，一个点击事件进入队列。

That event gets picked up for processing. Flutter looks at it, and the rendering system says, “Those coordinates match the raised button,” so Flutter executes the onPressed function. That code initiates a network request (which returns a future) and registers a completion handler for the future by using the then() method.

这个事件被取出处理。Flutter 查看它，
渲染系统说：“这些坐标正好在那个凸起按钮上”，
于是 Flutter 执行 onPressed 函数。
这段代码发起一个网络请求（返回一个 future），
并用 then() 方法为这个 future 注册一个完成处理器。

That’s it. The loop is finished processing that tap event, and it’s discarded.

就这样。循环处理完了那个点击事件，事件被丢弃。

Now, onPressed is a property of [RaisedButton](https://api.flutter.dev/flutter/material/RaisedButton-class.html), and the network event uses a callback for a [future](https://api.dart.dev/stable/dart-async/Future-class.html), but both of those techniques are doing the same basic thing. They’re both a way to tell Flutter, “Hey, later on, you might see a particular type of event come in. When you do, please execute this piece of code.”

注意，onPressed 是
[RaisedButton](https://api.flutter.dev/flutter/material/RaisedButton-class.html)
的一个属性，而网络事件使用了
[future](https://api.dart.dev/stable/dart-async/Future-class.html)
的回调，但这两种技术做的是同一件基本的事情。
它们都是在告诉 Flutter：“嘿，稍后你可能会看到
某种特定类型的事件进来。到时候，请执行这段代码。”

So, onPressed is waiting for a tap, and the future is waiting for network data, but from Dart’s perspective, those are both just events in the queue.

所以，onPressed 在等一次点击，future 在等网络数据，
但从 Dart 的角度看，它们都只是队列中的事件。

And that’s how asynchronous coding works in Dart. Futures, streams, async and await — these APIs are all just ways for you to tell Dart’s event loop, “Here’s some code, please run it later.”

这就是 Dart 中异步编程的工作方式。
future、流、async 和 await——
这些 API 都只是你告诉 Dart 事件循环的方式：
“这里有些代码，请稍后再运行。”

If we look back at the code example, you can now see exactly how it’s broken up into blocks for particular events. There’s the initial build (1), the tap event (2), and the network response event (3).

回头看代码示例，你现在可以清楚地看到
它是如何按特定事件拆分成代码块的：
初始构建（1）、点击事件（2）、网络响应事件（3）。

```dart
RaisedButton( // (1)
  child: Text('Click me'),
  onPressed: () { // (2)
    final myFuture = http.get('https://example.com');
    myFuture.then((response) { // (3)
      if (response.statusCode == 200) {
        print('Success!');
      }
    });
  },
)
```

After you get used to working with asynchronous code, you’ll start recognizing these patterns all over the place. Understanding the event loop is going to help as you move on to the higher level APIs.

习惯使用异步代码之后，你会开始在各处认出这些模式。
理解事件循环将有助于你继续使用更高层的 API。

## Summary

## 总结

We took a quick look at isolates, the event loop, and the foundation of asynchronous coding in Dart. If you’re looking for more details such as how the microtask queue works, see the out-of-date, archived-but-still-beloved article [The Event Loop and Dart](https://web.archive.org/web/20170704074724/https://webdev.dartlang.org/articles/performance/event-loop).

我们快速浏览了隔离、事件循环，
以及 Dart 异步编程的基础。
如果你想了解更多细节，比如微任务队列（microtask queue）
如何工作，请参阅那篇已过时、已归档但仍深受喜爱的文章
[The Event Loop and Dart](https://web.archive.org/web/20170704074724/https://webdev.dartlang.org/articles/performance/event-loop)。

To learn more about asynchrony in Dart, check out the next article in this series, [Dart asynchronous programming: Futures](/blog/dart-asynchronous-programming-futures).

要进一步了解 Dart 中的异步，
请阅读本系列的下一篇文章
[Dart 异步编程：Future](/blog/dart-asynchronous-programming-futures)。

*Big thanks to Andrew Brogdon, who created the video that this article is based on.*

*特别感谢 Andrew Brogdon，他制作了本文所依据的视频。*
