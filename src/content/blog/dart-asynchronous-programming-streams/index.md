---
# title: "Dart asynchronous programming: Streams"
title: "Dart 异步编程：Stream"
# description: "This article covers one of the fundamentals of reactive programming: streams, which are objects of type Stream."
description: "本文介绍响应式编程的基础之一：流（stream），即 Stream 类型的对象。"
ai-translated: true
publishDate: 2020-02-11
author: kwalrath
image: images/1Q2-Ac9rjIDSuXzbrQqGkVA.webp
category: deep-dive
layout: blog
---


***Note**: You might want to check out a [version of this article where the code is updated to be null safe](/blog/dart-asynchronous-programming-streams). (The video has not changed.)*

***注意**：你可以看看
[本文代码已更新为空安全（null safe）的版本](/blog/dart-asynchronous-programming-streams)。
（视频没有变化。）*

<DashImage src="images/17v26fZu7zzY0QSBQAwj42Q.webp" alt="Flutter app screen titled Streams are awesome showing the waiting state before stream data arrives." caption="A simple Flutter app that displays data from a stream" />


This article covers one of the fundamentals of reactive programming: streams, which are objects of type [`Stream`](https://api.dart.dev/stable/dart-async/Stream-class.html).

本文介绍响应式编程（reactive programming）的基础之一：
流（stream），即
[`Stream`](https://api.dart.dev/stable/dart-async/Stream-class.html) 类型的对象。

If you’ve read the [previous article on futures](/blog/dart-asynchronous-programming-futures), you might remember that **each future represents a single value** (either an error or data) that it delivers **asynchronously**. Streams work similarly, but instead of a single thing, **a stream can deliver zero or more values and errors** over **time.**

如果你读过[上一篇关于 future 的文章](/blog/dart-asynchronous-programming-futures)，
你可能记得**每个 future 代表单个值**（错误或数据），
并且是**异步**交付的。流的工作方式与之类似，
但不是只有一个东西，**一个流可以随时间交付零个或多个值和错误**。
> This article is the third one based on the *Flutter in Focus* video series *Asynchronous Programming in Dart*. The first article, [Isolates and event loops](/blog/dart-asynchronous-programming-isolates-and-event-loops), covered the foundations of Dart’s support for background work. The second one, [Futures](/blog/dart-asynchronous-programming-futures), discussed the `Future` class.
> If you prefer to learn by watching or listening, everything in this article is covered in the following video.

> 本文是基于 *Flutter in Focus* 视频系列
> 《Dart 异步编程》（*Asynchronous Programming in Dart*）的第三篇文章。
> 第一篇文章[隔离与事件循环](/blog/dart-asynchronous-programming-isolates-and-event-loops)
> 介绍了 Dart 后台工作支持的基础。
> 第二篇 [Future](/blog/dart-asynchronous-programming-futures) 讨论了 `Future` 类。
> 如果你更喜欢通过观看或收听来学习，
> 本文的所有内容都包含在下面这个视频中。

<YoutubeEmbed id="nQBpOIHE4eE" title="Dart Streams - Flutter in Focus" fullwidth="true"/>


If you think about the way a single value relates to an [iterator](https://dart.dev/codelabs/iterables) of the same type, that’s how a future relates to a stream.

想一想单个值与同类型的[迭代器（iterator）](https://dart.dev/codelabs/iterables)
之间的关系，future 与流之间就是这样的关系。

<DashImage src="images/1q9cqGB5uXOX3tNw07SoJnQ.webp" alt="Table comparing int, Future of int, Iterator of int, and Stream of int by value count and delivery timing." />


Just like with futures, the key is deciding in advance, “Here’s what to do when a piece of data is ready, and when there’s an error, and when the stream completes.”

和 future 一样，关键在于提前决定好：
“当一份数据就绪时该做什么，出现错误时该做什么，
以及流结束（complete）时该做什么。”

*Also* just like with futures, the Dart event loop is still running the show.

*同样*和 future 一样，Dart 事件循环（event loop）仍然是幕后主导。

<DashImage src="images/0UVy8BLEUm4CifwDE.webp" alt="Three queued stream events approaching a gear with circular arrows representing the Dart event loop." caption="Streams work with the Dart event loop." />


If you’re using the `File` class’s [`openRead()`](https://api.dart.dev/stable/dart-io/File/openRead.html) method to read data from a file, for example, that method returns a stream.

例如，如果你使用 `File` 类的
[`openRead()`](https://api.dart.dev/stable/dart-io/File/openRead.html)
方法从文件中读取数据，该方法返回的就是一个流。

Chunks of data are read from disk and arrive at the event loop. A Dart library looks at them and says, “Ah, I’ve got somebody waiting for this,” adds the data to the stream, and it pops out in your app’s code.

一块块数据从磁盘读出并到达事件循环。
一个 Dart 库看着它们说：“啊，有人在等这个”，
于是把数据加入流中，数据就在你的应用代码里冒出来了。

When another piece of data arrives, in it goes, and out it comes. Timer-based streams, streaming data from a network socket — they work with the event loop, too, using clock and network events.

当另一份数据到达时，它进入流，再从流里出来。
基于定时器的流、从网络套接字（socket）流式传输的数据——
它们也借助时钟事件和网络事件与事件循环协同工作。

## Listening to streams

## 监听流

Let’s talk about how to work with data provided by a stream. Say you have a class that gives you a stream that kicks out a new integer once per second: 1, 2, 3, 4, 5…

我们来谈谈如何处理流提供的数据。
假设你有一个类，它给你一个每秒抛出一个新整数的流：1、2、3、4、5……

You can use the [`listen()`](https://api.dart.dev/stable/dart-async/Stream/listen.html) method to subscribe to the stream. The only required parameter is a function.

你可以使用
[`listen()`](https://api.dart.dev/stable/dart-async/Stream/listen.html)
方法订阅（subscribe）这个流。唯一的必需参数是一个函数。

```dart
final myStream = NumberCreator().stream;

final subscription = myStream.listen(
  (data) => print('Data: $data'),
);
```

Every time a new value is emitted by the stream, the function gets called and prints the value:

每当流发出（emit）一个新值，这个函数就会被调用并打印该值：

```
Data: 1
Data: 2
Data: 3
Data: 4
...
```


That’s how `listen()` works.

这就是 `listen()` 的工作方式。
> **Important:** By default, streams are set up for single subscription. They hold onto their values until someone subscribes, and they only allow a single listener for their entire lifespan. If you try to listen to a stream twice, you’ll get an exception.
> Fortunately Dart also offers broadcast streams. You can use the [`asBroadcastStream()`](https://api.dart.dev/stable/dart-async/Stream/asBroadcastStream.html) method to make a broadcast stream from a single subscription one. Broadcast streams work the same as single subscription streams, but they can have multiple listeners, and if nobody’s listening when a piece of data is ready, that data is tossed out.

> **重要：**默认情况下，流被设置为单订阅（single subscription）模式。
> 它们会保留自己的值直到有人订阅，
> 并且在整个生命周期内只允许一个监听器（listener）。
> 如果你尝试对一个流监听两次，就会得到异常。
> 幸运的是，Dart 还提供了广播流（broadcast stream）。
> 你可以使用
> [`asBroadcastStream()`](https://api.dart.dev/stable/dart-async/Stream/asBroadcastStream.html)
> 方法把单订阅流变成广播流。
> 广播流的工作方式与单订阅流相同，但可以有多个监听器，
> 而且如果一份数据就绪时没有人在监听，这份数据就会被丢弃。

```dart
final myStream = NumberCreator().stream.asBroadcastStream();

final subscription = myStream.listen(
  (data) => print('Data: $data'),
);

final subscription2 = myStream.listen(
  (data) => print('Data again: $data'),
);
```

Let’s go back to that first `listen()` call, because there are a couple more things to talk about.

让我们回到最初那个 `listen()` 调用，因为还有几件事要谈。

As we mentioned earlier, streams can produce errors just like futures can. By adding an `onError` function to the `listen()` call, you can catch and process any error.

如前所述，流和 future 一样可以产生错误。
通过在 `listen()` 调用中添加 `onError` 函数，
你可以捕获并处理任何错误。

There’s also a `cancelOnError` property that’s true by default, but can be set to false to keep the subscription going even after an error.

还有一个 `cancelOnError` 属性，默认为 true，
但可以设为 false，让订阅在出错后仍然继续。

And you can add an `onDone` function to execute some code when the stream is finished sending data, such as when a file has been completely read.

你还可以添加一个 `onDone` 函数，
在流发送完数据时执行一些代码，比如文件被完整读取之后。

With all four of those parameters combined — `onError`, `onDone`, `cancelOnError`, and the required parameter (`onData`) — you can be ready in advance for whatever happens.

把这四个参数组合起来——`onError`、`onDone`、`cancelOnError`，
以及必需参数（`onData`）——你就可以提前为任何情况做好准备。

```dart
final subscription = myStream.listen(
  (data) {
    print('Data: $data');
  },
  onError: (err) {
    print('Error!');
  },
  cancelOnError: false,
  onDone: () {
    print('Done!');
  },
);
```
> **Tip:** The little subscription object that `listen()` returns has some useful methods of its own. It’s a [*`StreamSubscription`*](https://api.dart.dev/stable/dart-async/StreamSubscription-class.html), and you can use it to pause, resume, and even cancel the flow of data.

> **提示：**`listen()` 返回的那个小小的订阅对象自带一些有用的方法。
> 它是一个
> [*`StreamSubscription`*](https://api.dart.dev/stable/dart-async/StreamSubscription-class.html)，
> 你可以用它来暂停、恢复、甚至取消数据流。

```dart
final subscription = myStream.listen(...);

subscription.pause();
subscription.resume();
subscription.cancel();
```

## Using and manipulating streams

## 使用和操作流

Now that you know how to use `listen()` to subscribe to a stream and receive data events, we can talk about what makes streams really cool: manipulating them. Once you’ve got data in a stream, a lot of operations become fluent and elegant.

既然你已经知道如何用 `listen()` 订阅流并接收数据事件，
我们就可以谈谈流真正酷的地方：对流进行操作。
一旦数据进入了流，许多操作都会变得流畅而优雅。

Going back to that number stream from earlier, we can use a method called [`map()`](https://api.dart.dev/stable/dart-async/Stream/map.html) to take each value from the stream and convert it on the fly into something else. Give `map()` a function to do the conversion, and it returns a new stream, typed to match the return value of the function. Instead of a stream of ints, you now have a stream of strings. You can throw a `listen()` call on the end, give it the `print()` function, and now you’re printing strings directly off the stream, asynchronously, as they arrive.

回到前面那个数字流，我们可以用一个叫
[`map()`](https://api.dart.dev/stable/dart-async/Stream/map.html)
的方法，取出流中的每个值并即时转换成别的东西。
给 `map()` 一个执行转换的函数，它就会返回一个新的流，
其类型与该函数的返回值相匹配。
现在你拥有的不再是 int 流，而是字符串流。
你可以在末尾加一个 `listen()` 调用，传给它 `print()` 函数，
这样你就能在字符串到达时，直接异步地从流中打印它们。

```dart
NumberCreator().stream
    .map((i) => 'String $i')
    .listen(print);
/*
OUTPUT: 
String 1
String 2
String 3
String 4
*/
```

There are a ton of methods that you can chain up like this. If you only want to print the even numbers, for example, you can use [`where()`](https://api.dart.dev/stable/dart-async/Stream/where.html) to filter the stream. Give it a test function that returns a boolean for each element, and it returns a new stream that only includes values that pass the test.

像这样可以链式调用的方法有一大堆。
例如，如果你只想打印偶数，可以用
[`where()`](https://api.dart.dev/stable/dart-async/Stream/where.html)
过滤流。给它一个为每个元素返回布尔值的测试函数，
它就会返回一个只包含通过测试的值的新流。

```dart
NumberCreator().stream
    .where((i) => i % 2 == 0)
    .map((i) => 'String $i')
    .listen(print);
/*
OUTPUT:
String 2
String 4
String 6
String 8
*/
```

The [`distinct()`](https://api.dart.dev/stable/dart-async/Stream/distinct.html) method is another good one. If you have an app that uses a Redux store, that store emits new app state objects in an `onChange` stream. You can use `map()` to convert that stream of state objects to a stream of view models for one part of the app. Then you can use the `distinct()` method to get a stream that filters out consecutive identical values (in case the store kicks out a change that doesn’t affect the subset of data in the view model). Then you can listen and update the UI whenever you get a new view model.

[`distinct()`](https://api.dart.dev/stable/dart-async/Stream/distinct.html)
方法是另一个好用的方法。
如果你的应用使用了 Redux store，
该 store 会在 `onChange` 流中发出新的应用状态对象。
你可以用 `map()` 把这个状态对象流转换成
应用某一部分的视图模型（view model）流。
然后可以用 `distinct()` 方法得到一个过滤掉连续相同值的流
（以防 store 抛出的变化并不影响视图模型中的那部分数据）。
之后你就可以监听，并在每次得到新视图模型时更新 UI。

```dart
myReduxStore.onChange
    .map((s) => MyViewModel(s))
    .distinct()
    .listen( /* update UI */ );
```

There are a bunch of additional methods built into Dart that you can use to shape and modify your streams. Plus, when you’re ready for even more advanced stuff, there’s the [async package](https://pub.dev/packages/async) maintained by the Dart team and available on [pub.dev](https://pub.dev). It has classes that can merge two streams together, cache results, and perform other types of stream-based wizardry.

Dart 内置了一大堆额外的方法，可以用来塑造和修改你的流。
此外，当你准备好尝试更高级的东西时，还有 Dart 团队维护的
[async package](https://pub.dev/packages/async)，
可以在 [pub.dev](https://pub.dev) 上获取。
它包含可以把两个流合并、缓存结果，
以及执行其他各种基于流的魔法操作的类。

<DashImage src="images/1WTHZRJjgF4qQvSDvY0Z9ow.webp" alt="Pub.dev page for async 2.4.0 showing utility classes for asynchronous computations." caption="Try the async package for more stream-based wizardry." />


For even more stream magic, take a look at the [stream_transform package](https://pub.dev/packages/stream_transform).

想要更多流魔法，可以看看
[stream_transform package](https://pub.dev/packages/stream_transform)。

## Creating streams

## 创建流

One advanced topic deserves a mention here, and that’s how to create streams of your own. Just like with futures, most of the time you’re going to be working with streams created for you by network libraries, file libraries, state management, and so on. But you can make your own as well, using a [`StreamController`](https://api.dart.dev/stable/dart-async/StreamController-class.html).

有一个高级话题值得在这里提一下，那就是如何创建你自己的流。
和 future 一样，大多数时候你使用的都是
网络库、文件库、状态管理等为你创建好的流。
但你也可以用
[`StreamController`](https://api.dart.dev/stable/dart-async/StreamController-class.html)
自己创建。

Let’s go back to that `NumberCreator` we’ve been using so far. Here’s the actual code for it:

让我们回到一直在用的那个 `NumberCreator`。它的实际代码如下：

```dart
class NumberCreator {
  NumberCreator() {
    Timer.periodic(Duration(seconds: 1), (t) {
      _controller.sink.add(_count);
      _count++;
    });
  }

  var _count = 1;
  final _controller = StreamController<int>();
  Stream<int> get stream => _controller.stream;
}

```

As you can see, it keeps a running count, and it uses a timer to increment that count each second. The interesting bit, though, is the stream controller.

如你所见，它维护一个不断累加的计数，
并用一个定时器每秒递增这个计数。
不过，有意思的部分是流控制器（stream controller）。

A `StreamController` creates a brand new stream from scratch, and gives you access to both ends of it. There’s the stream end itself, where data arrives. (We’ve been using that one throughout this article.)

`StreamController` 从零开始创建一个全新的流，
并让你能访问它的两端。
一端是流本身，数据从这里到达。
（本文一直在用的就是这一端。）

```
Stream<int> get stream => _controller.stream;
```


Then there’s the sink end, which is where new data gets added to the stream:

另一端是 sink（数据入口），新数据从这里被添加到流中：

```
_controller.sink.add(_count);
```


`NumberCreator` here uses both of them. When the timer goes off, it adds the latest count to the controller’s sink, and then it exposes the controller’s stream with a public property so other objects can subscribe to it.

这里的 `NumberCreator` 两端都用到了。
定时器触发时，它把最新的计数添加到控制器的 sink，
然后通过一个公开属性暴露控制器的流，
让其他对象可以订阅它。

## Building Flutter widgets using streams

## 使用流构建 Flutter widget

Now that we’ve covered creating, manipulating, and listening to streams, let’s talk about how to put them to work building widgets in Flutter.

我们已经介绍了流的创建、操作和监听，
现在来谈谈如何在 Flutter 中用它们构建 widget。

If you saw the previous video on futures, you might remember [`FutureBuilder`](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html). You give it a future and a builder method, and it builds widgets based on the state of the future.

如果你看过上一个关于 future 的视频，可能记得
[`FutureBuilder`](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html)。
你给它一个 future 和一个构建方法（builder method），
它就会根据 future 的状态构建 widget。

For streams, there’s a similar widget called [`StreamBuilder`](https://api.flutter.dev/flutter/widgets/StreamBuilder-class.html). Give it a stream and a builder method, and it will rebuild its children whenever a new value is emitted by the stream.

对于流，有一个类似的 widget 叫
[`StreamBuilder`](https://api.flutter.dev/flutter/widgets/StreamBuilder-class.html)。
给它一个流和一个构建方法，
每当流发出新值时，它就会重建其子 widget。

```dart
StreamBuilder<String>(
  stream: NumberCreator().stream.map((i) => 'String $i'),
  builder: (context, snapshot) {
    /* Build widgets! */
  }
)
```

The snapshot parameter is an [`AsyncSnapshot`](https://api.flutter.dev/flutter/widgets/AsyncSnapshot-class.html), just like with `FutureBuilder`. You can check its `connectionState` property to see if the stream hasn’t yet sent any data or if it’s completely finished. You can use the `hasError` property to see if the latest value is an error. And, of course, you can handle data values.

snapshot 参数是一个
[`AsyncSnapshot`](https://api.flutter.dev/flutter/widgets/AsyncSnapshot-class.html)，
和 `FutureBuilder` 一样。
你可以检查它的 `connectionState` 属性，
看看流是否还没发送任何数据，或者是否已经完全结束。
你可以用 `hasError` 属性看看最新的值是否是错误。
当然，你也可以处理数据值。

```dart
StreamBuilder<String>(
  stream: NumberCreator().stream.map((i) => 'String $i'),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Text('No data yet.');
    } else if (snapshot.connectionState == ConnectionState.done) {
      return Text('Done!');
    }
  }
)
```

The main thing is just to make sure your builder knows how to handle all the possible states of the stream. Once you’ve got that, it can react to whatever the stream does.

最重要的是确保你的构建函数知道如何处理流的所有可能状态。
做到这一点后，它就能对流的一举一动做出反应。

## Summary

## 总结

This article talked about what streams represent, how you get values from a stream, ways to manipulate those values, and how `StreamBuilder` helps you use stream values in a Flutter app.

本文介绍了流代表什么、如何从流中获取值、
操作这些值的方法，以及 `StreamBuilder`
如何帮你在 Flutter 应用中使用流的值。

You can learn more about streams from the Dart and Flutter documentation:

你可以从 Dart 和 Flutter 文档中了解更多关于流的内容：

* On [dart.dev](https://dart.dev), see the [streams tutorial](https://dart.dev/tutorials/language/streams), the [command-line app tutorial](https://dart.dev/tutorials/server/cmdline), and the [stream section](https://dart.dev/guides/libraries/library-tour#stream) of the library tour.

  在 [dart.dev](https://dart.dev) 上，参见
  [流教程](https://dart.dev/tutorials/language/streams)、
  [命令行应用教程](https://dart.dev/tutorials/server/cmdline)，
  以及库之旅的
  [Stream 章节](https://dart.dev/guides/libraries/library-tour#stream)。

* On [flutter.dev](https://flutter.dev), see [Work with WebSockets](https://flutter.dev/docs/cookbook/networking/web-sockets), which features an example that uses `StreamBuilder`.

  在 [flutter.dev](https://flutter.dev) 上，参见
  [使用 WebSocket](https://flutter.dev/docs/cookbook/networking/web-sockets)，
  其中有一个使用 `StreamBuilder` 的示例。

Or go on to the next video in the *Asynchronous Programming in Dart* series. It talks about `async` and `await`, which are two keywords that Dart offers to help you keep your asynchronous code tight and easy to read.

或者继续观看《Dart 异步编程》系列的下一个视频。
它讲的是 `async` 和 `await`，
这是 Dart 提供的两个关键字，
帮助你的异步代码保持紧凑、易读。

<YoutubeEmbed id="SmTCmDMi4BY" title="Async/Await - Flutter in Focus" fullwidth="true"/>


*Big thanks to Andrew Brogdon, who created the video that this article is based on.*

*特别感谢 Andrew Brogdon，他制作了本文所依据的视频。*

<DashImage src="images/1Q2-Ac9rjIDSuXzbrQqGkVA.webp" alt="Flutter app titled Streams are awesome showing Done after the stream completes." />
