---
# title: "Dart asynchronous programming: Futures"
title: "Dart 异步编程：Future"
# description: "One of the most basic APIs that Dart has for asynchronous programming is futures — objects of type Future. For the most part, Dart’s…"
description: "Dart 用于异步编程的最基础 API 之一是 future——Future 类型的对象。在很大程度上，Dart 的 future 与其他语言中的 future 或 promise API 非常相似。"
ai-translated: true
publishDate: 2019-09-18
author: kwalrath
image: images/1UD63BMoIBmzoA6jo3LjCCg.webp
category: deep-dive
layout: blog
---


<DashImage src="images/1G4044qvxp8yBjmGVHVLEyw.webp" alt="Dart code stores the result of http.get('http://example.com') in myFuture." caption="Many asynchronous Dart APIs return futures." />


One of the most basic APIs that Dart has for asynchronous programming is *futures —* objects of type [`Future`](https://api.dartlang.org/stable/dart-async/Future-class.html). For the most part, Dart’s futures are very similar to the *future* or *promise* APIs found in other languages.

Dart 用于异步编程的最基础 API 之一是 *future——*
[`Future`](https://api.dartlang.org/stable/dart-async/Future-class.html) 类型的对象。
在很大程度上，Dart 的 future 与其他语言中的
*future* 或 *promise* API 非常相似。

This article discusses the concepts behind Dart futures and tells you how to use the `Future` API. It also discusses the Flutter `FutureBuilder` widget, which helps you update a Flutter UI asynchronously, based on the state of a future.

本文介绍 Dart future 背后的概念，并告诉你如何使用 `Future` API。
本文还会讨论 Flutter 的 `FutureBuilder` widget，
它可以根据 future 的状态帮你异步更新 Flutter UI。

Thanks to Dart language features like [async-await](https://dart.dev/codelabs/async-await), you might never need to use the `Future` API directly. But you’re almost certain to encounter futures in your Dart code. And you might want to *create* futures or *read* code that uses the `Future` API.

得益于 [async-await](https://dart.dev/codelabs/async-await) 这样的 Dart 语言特性，
你可能永远都不需要直接使用 `Future` API。
但你几乎一定会在 Dart 代码中遇到 future。
而且你可能想要*创建* future，或者*阅读*使用 `Future` API 的代码。
> This article is the second one based on the *Flutter in Focus* video series *Asynchronous Programming in Dart*. The first article, [Isolates and event loops](/blog/dart-asynchronous-programming-isolates-and-event-loops), covered the foundations of Dart’s support for background work.
> If you prefer to learn by watching or listening, everything in this article is covered in the following video*.*

> 本文是基于 *Flutter in Focus* 视频系列
> 《Dart 异步编程》（*Asynchronous Programming in Dart*）的第二篇文章。
> 第一篇文章[隔离与事件循环](/blog/dart-asynchronous-programming-isolates-and-event-loops)
> 介绍了 Dart 后台工作支持的基础。
> 如果你更喜欢通过观看或收听来学习，
> 本文的所有内容都包含在下面这个视频中。

<YoutubeEmbed id="OTS-ap9_aXc" title="Dart Futures - Flutter in Focus" fullwidth="true"/>


You can think of futures as little gift boxes for data. Somebody hands you one of these gift boxes, which starts off closed. A little while later the box pops open, and inside there’s either a value or an error.

你可以把 future 想象成装数据的小礼盒。
有人递给你一个这样的礼盒，它一开始是关着的。
过一会儿盒子会弹开，里面要么是一个值，要么是一个错误。

So a future can be in one of 3 states:

因此，一个 future 可以处于以下 3 种状态之一：

1. **Uncompleted:** The gift box is closed*.*

    **未完成（Uncompleted）**：礼盒是关着的。

1. **Completed with a value:** The box is open, and your gift (data) is ready.

    **以值完成（Completed with a value）**：盒子打开了，你的礼物（数据）已就绪。

1. **Completed with an error:** The box is open, but something went wrong.

    **以错误完成（Completed with an error）**：盒子打开了，但出了点问题。

Most of the code you’re about to see revolves around dealing with these three states. You receive a future, and you need to decide what to do until the box opens, what to do when it opens with a value, and what to do if there’s an error. You’ll see that 1–2–3 pattern a lot.

你接下来看到的大部分代码都围绕如何处理这三种状态展开。
你收到一个 future，需要决定在盒子打开之前做什么、
盒子带着一个值打开时做什么，以及出现错误时做什么。
你会经常看到这个 1–2–3 模式。

<DashImage src="images/1UD63BMoIBmzoA6jo3LjCCg.webp" alt="Flowchart with Uncompleted branching to Completed with data and Completed with error." caption="The 3 states of a future" />


You might remember the event loop (pictured below) from our [article about the Dart event loop](/blog/dart-asynchronous-programming-isolates-and-event-loops). A good thing to know about futures is that they’re really just an API built to make using the event loop easier.

你可能还记得我们在[关于 Dart 事件循环的文章](/blog/dart-asynchronous-programming-isolates-and-event-loops)
中介绍过的事件循环（event loop，见下图）。
关于 future，有一点值得了解：
它其实只是一个为简化事件循环的使用而构建的 API。

<DashImage src="images/0xlxALlxjazVifRep.webp" alt="Queued events moving toward a gear with circular arrows representing the Dart event loop." caption="The Dart event loop processes one event at a time." />


The Dart code you write is executed by a single thread. The whole time your app is running, that one little thread just keeps going around and around, picking up events from the event queue and processing them.

你编写的 Dart 代码由单个线程执行。
在应用运行的整个过程中，这一个小线程只是不停地转啊转，
从事件队列（event queue）中取出事件并处理它们。

Say you have some code for a download button (implemented below as a `RaisedButton`). The user taps, and your button starts downloading a picture.

假设你有一个下载按钮的代码（下面用 `RaisedButton` 实现）。
用户点击后，你的按钮开始下载一张图片。

```dart
RaisedButton(
  onPressed: () {
    final myFuture = http.get('https://my.image.url');
    myFuture.then((resp) {
      setImage(resp);
    });
  },
  child: Text('Click me!'),
)
```

First the tap event occurs. The event loop gets the event, and it calls your tap handler (which you set using the `onPressed` parameter to the `RaisedButton` constructor). Your handler uses the http library to make a request (`http.get()`), and it gets a future in return (`myFuture`).

首先发生点击事件。事件循环获取这个事件，
并调用你的点击处理器
（通过 `RaisedButton` 构造函数的 `onPressed` 参数设置）。
你的处理器使用 http 库发起请求（`http.get()`），
并得到一个返回的 future（`myFuture`）。

So now you’ve got your little box, `myFuture`. It starts off closed. To register a callback for when it opens, you use `then()`.

现在你拿到了你的小盒子 `myFuture`。它一开始是关着的。
要为它打开的时刻注册一个回调（callback），你需要使用 `then()`。

Once you have your gift box, you wait. Maybe some other events come in, the user does some stuff, and your little box just sits there while the event loop keeps going around.

拿到礼盒之后，你就等着。
也许会有其他事件进来，用户做了些别的事情，
而你的小盒子就静静地待在那里，事件循环则继续不停地运转。

Eventually, data for the image is downloaded, and the http library says, “Great! I’ve got this future right here.” It puts the data in the box and pops it open, which triggers your callback.

最终，图片数据下载完成，http 库说：“太好了！我这儿正好有个 future。”
它把数据放进盒子并弹开盒子，从而触发你的回调。

Now that little piece of code you handed to `then()` executes, and it displays the image.

现在，你交给 `then()` 的那一小段代码执行了，并显示出图片。

Throughout that process, your code never had to touch the event loop directly. It didn’t matter what else was going on, or what other events came in. All you needed to do was get the future from the http library, and then say what to do when the future completed.

在整个过程中，你的代码从来不需要直接接触事件循环。
其他什么事情在发生、有什么别的事件进来，都无关紧要。
你需要做的只是从 http 库拿到 future，
然后说明 future 完成时该做什么。

In real code, you’d also take care of errors. We’ll show you how to do that a little later.

在实际代码中，你还需要处理错误。稍后我们会展示怎么做。

Let’s take a closer look at the `Future` API, some of which you just saw in use.

让我们仔细看看 `Future` API，你刚才已经见过其中一部分的用法了。

OK, first question: how do you get an instance of a `Future`? Most of the time, you don’t create futures directly. That’s because many of the common asynchronous programming tasks already have libraries that generate futures for you.

好，第一个问题：如何获得一个 `Future` 实例？
大多数时候，你并不直接创建 future。
这是因为许多常见的异步编程任务已经有现成的库为你生成 future。

For example, network communication returns a future:

例如，网络通信会返回一个 future：

```
final myFuture = http.get('http://example.com');
```


Getting access to shared preferences also returns a future:

访问共享偏好设置（shared preferences）也会返回一个 future：

```
final myFuture = SharedPreferences.getInstance();
```


But you can also use `Future` constructors to create futures.

不过你也可以使用 `Future` 构造函数来创建 future。

## Future constructors

## Future 构造函数

The simplest constructor is [`Future()`](https://api.dartlang.org/stable/dart-async/Future/Future.html), which takes a function and returns a future that matches the function’s return type. Later the function runs asynchronously, and the future completes with the function’s return value. Here’s an example of using `Future()`:

最简单的构造函数是
[`Future()`](https://api.dartlang.org/stable/dart-async/Future/Future.html)，
它接受一个函数，并返回一个与该函数返回类型相匹配的 future。
之后这个函数会异步运行，future 则以该函数的返回值完成。
下面是使用 `Future()` 的例子：

```dart
void main() {
  final myFuture = Future(() {
    return 12;
  });
}
```

Let’s add a couple of print statements to make the asynchronous part clear:

我们加几条打印语句，把异步的部分展示得更清楚：

```dart
void main() {
  final myFuture = Future(() {
    print('Creating the future.'); // Prints second.
    return 12;
  });
  print('Done with main().'); // Prints first.
}
```

If you run that code in DartPad ([dartpad.dev](https://dartpad.dev)), the entire main function finishes before the function given to the `Future()` constructor. That’s because the `Future()` constructor just returns an uncompleted future at first. It says, “Here’s this box. You hold onto that for now, and later I’ll go run your function and put some data in there for you.” Here’s the output of the preceding code:

如果你在 DartPad（[dartpad.dev](https://dartpad.dev)）中运行这段代码，
整个 main 函数会先于传给 `Future()` 构造函数的函数执行完毕。
这是因为 `Future()` 构造函数起初只是返回一个未完成的 future。
它的意思是：“给你这个盒子。你先拿着，
稍后我会去运行你的函数，并把一些数据放进去。”
上面代码的输出如下：

```
Done with main().
Creating the future.
```


Another constructor, [`Future.value()`](https://api.dartlang.org/stable/dart-async/Future/Future.value.html), is handy when you already know the value for the future. This constructor is useful when you’re building services that use caching. Sometimes you already have the value you need, so you can pop it right in there:

另一个构造函数
[`Future.value()`](https://api.dartlang.org/stable/dart-async/Future/Future.value.html)
在你已经知道 future 的值时很方便。
这个构造函数在构建使用缓存的服务时很有用。
有时你已经有了需要的值，直接放进去就行：

```
final myFuture = Future.value(12);
```


The `Future.value()` constructor has a counterpart for completing with an error. It’s called [`Future.error()`](https://api.dartlang.org/stable/dart-async/Future/Future.error.html), and it works essentially the same way, but takes an error object and an optional stacktrace:

`Future.value()` 构造函数有一个以错误完成的对应版本，叫做
[`Future.error()`](https://api.dartlang.org/stable/dart-async/Future/Future.error.html)，
工作方式基本相同，但接受一个错误对象和一个可选的堆栈跟踪（stack trace）：

```
final myFuture = Future.error(ArgumentError.notNull('input'));
```


The handiest future constructor is probably [`Future.delayed()`](https://api.dartlang.org/stable/dart-async/Future/Future.delayed.html). It works just like `Future()`, except that it waits for a specified length of time before running the function and completing the future.

最好用的 future 构造函数可能要数
[`Future.delayed()`](https://api.dartlang.org/stable/dart-async/Future/Future.delayed.html)。
它的工作方式与 `Future()` 一样，
只是会先等待指定的时长，再运行函数并完成 future。

One way to use `Future.delayed()` is when you’re creating mock network services for testing. If you need to make sure your loading spinner displays correctly, a delayed future is your friend.

`Future.delayed()` 的一个用途是在测试时创建模拟（mock）网络服务。
如果你需要确保加载动画（loading spinner）正确显示，
延迟的 future 就是你的好帮手。

```dart
final myFuture = Future.delayed(
  const Duration(seconds: 5),
  () => 12,
);
```

## Using futures

## 使用 future

Now that you know where futures come from, let’s talk about how to use them. As we mentioned earlier, using a future is mostly about accounting for the three states it can be in: uncompleted, completed with a value, or completed with an error.

既然你已经知道 future 从何而来，我们就来谈谈如何使用它们。
如前所述，使用 future 主要是要考虑到它可能处于的三种状态：
未完成、以值完成，或以错误完成。

The following code uses `Future.delayed()` to create a future that completes after 3 seconds with a value of 100.

下面的代码使用 `Future.delayed()` 创建了一个 future，
它会在 3 秒后以值 100 完成。

```dart
void main() {
  Future.delayed(
    const Duration(seconds: 3),
    () => 100,
  );
  print('Waiting for a value...');
}
```

When this code executes, `main()` runs from top to bottom, creating the future and printing “Waiting for a value…” That whole time, the future is uncompleted. It doesn’t complete for another 3 seconds.

这段代码执行时，`main()` 从上到下运行，
创建 future 并打印“Waiting for a value…”。
在此期间，future 一直处于未完成状态，还要再过 3 秒才会完成。

To *use* the completed value, you can use [`then()`](https://api.dartlang.org/stable/dart-async/Future/then.html). That’s an instance method on each future that you can use to register a callback for when the future completes with a value. You give it a function that takes a single parameter matching the type of the future. Once the future completes with a value, your function is called with that value.

要*使用*完成后的值，你可以用
[`then()`](https://api.dartlang.org/stable/dart-async/Future/then.html)。
这是每个 future 上的实例方法，
可以用来注册 future 以值完成时的回调。
你传给它一个函数，该函数接受一个与 future 类型相匹配的参数。
一旦 future 以某个值完成，你的函数就会带着那个值被调用。

```dart
void main() {
  Future.delayed(
    const Duration(seconds: 3),
    () => 100,
  ).then((value) {
    print('The value is $value.'); // Prints later, after 3 seconds.
  });
  print('Waiting for a value...'); // Prints first.
}
```

Here’s the output of the preceding code:

上面代码的输出如下：

```
Waiting for a value... *(3 seconds pass until callback executes)*
The value is 100.
```


In addition to executing your code, `then()` returns a future of its own, matching the return value of whatever function you give it. So if you need to make a couple of asynchronous calls, you can chain them together even if they have different return types.

除了执行你的代码，`then()` 还会返回它自己的一个 future，
其类型与你传入函数的返回值相匹配。
因此，如果你需要进行几次异步调用，
即使它们的返回类型不同，也可以把它们链式串联起来。

```dart
_fetchNameForId(12)
    .then((name) => _fetchCountForName(name))
    .then((count) => print('The count is $count.'));
```

Back to our first example, what happens if that initial future doesn’t complete with a value — what if it completes with an error? The `then()` method expects a value. You need a way to register another callback in case of an error.

回到第一个例子，如果最初那个 future 没有以值完成——
而是以错误完成，会发生什么？`then()` 方法期望的是一个值。
你需要一种方法，在出错时注册另一个回调。

The answer is to use [`catchError()`](https://api.dartlang.org/stable/dart-async/Future/catchError.html). It works just like `then()`, except that it takes an error instead of a value, and it executes if the future completes with an error. Just like `then()`, the `catchError()` method returns a future of its own, so you can build a whole chain of `then()` and `catchError()`methods that wait on one another.

答案是使用
[`catchError()`](https://api.dartlang.org/stable/dart-async/Future/catchError.html)。
它的工作方式与 `then()` 一样，只是接受的是错误而不是值，
并且会在 future 以错误完成时执行。
与 `then()` 一样，`catchError()` 方法也会返回自己的 future，
所以你可以构建一整条相互等待的 `then()` 和 `catchError()` 调用链。
> **Note:** You don’t need to call `then()` or `catchError()` if you use the async-await language feature. Instead, you await the completed value, and you use try-catch-finally to handle errors. For details, see the Dart language tour’s [asynchrony support section](https://dart.dev/guides/language/language-tour#asynchrony-support).

> **注意：**如果使用 async-await 语言特性，
> 你就不需要调用 `then()` 或 `catchError()`。
> 取而代之的是 await 完成后的值，并使用 try-catch-finally 处理错误。
> 详情请参阅 Dart 语言之旅的
> [异步支持章节](https://dart.dev/guides/language/language-tour#asynchrony-support)。

Here’s an example of using `catchError()` to handle the case where a future completes with an error:

下面是使用 `catchError()` 处理 future 以错误完成的情况的例子：

```dart
void main() {
  Future.delayed(
    Duration(seconds: 3),
    () => throw 'Error!', // Complete with an error.
  ).then((value) {
    print(value);
  }).catchError((err) {
    print('Caught $err'); // Handle the error.
  });
  print('Waiting for a value...');
}
```

You can even give `catchError()` a test function to check the error before invoking the callback. You can have multiple `catchError()` functions this way, each one checking for a different kind of error. Here’s an example of specifying a test function, using the optional `test` parameter to `catchError()`:

你甚至可以给 `catchError()` 传一个测试函数，
在调用回调之前先检查错误。
这样你可以有多个 `catchError()` 函数，每个检查不同种类的错误。
下面的例子使用 `catchError()` 的可选 `test` 参数指定了一个测试函数：

```dart
void main() {
  Future.delayed(
    Duration(seconds: 3),
    () => throw 'Error!',
  ).then((value) {
    print(value);
  }).catchError((err) {
    print('Caught $err');
  }, test: (err) { // Optional test parameter.
    return err is String;
  });
  print('Waiting for a value...');
}
```

Now that you’ve gotten this far, hopefully you can see how the three states of a future are often reflected by the structure of the code. There are three blocks in the preceding example:

看到这里，希望你能明白 future 的三种状态
是如何经常体现在代码结构中的。上面的例子有三个代码块：

1. The first block creates an uncompleted future.

    第一个代码块创建一个未完成的 future。

1. Then there’s a function to call if the future completes with a value.

    然后是一个在 future 以值完成时调用的函数。

1. Then there’s another function to call if the future completes with an error.

    接着是另一个在 future 以错误完成时调用的函数。

There’s one more method you might want to use: [`whenComplete()`](https://api.dartlang.org/stable/dart-async/Future/whenComplete.html). You can use it to execute a function when the future is completed, no matter whether it’s with a value or an error.

还有一个你可能会用到的方法：
[`whenComplete()`](https://api.dartlang.org/stable/dart-async/Future/whenComplete.html)。
你可以用它在 future 完成时执行一个函数，
无论它是以值完成还是以错误完成。

It’s kind of like the *finally* block in a try-catch-finally. There’s code executed if everything goes right, code for an error, and code that runs no matter what.

这有点像 try-catch-finally 中的 *finally* 块：
有一切顺利时执行的代码、出错时执行的代码，
以及无论如何都会运行的代码。

## Using futures in Flutter

## 在 Flutter 中使用 future

So that’s how you create futures, and a bit about how you can use their values. Now let’s talk putting them to work in Flutter.

以上就是创建 future 的方法，以及如何使用它们的值的一些介绍。
现在我们来谈谈如何在 Flutter 中让它们发挥作用。

Say you have a network service that’s going to return some JSON data, and you want to display that data. You could create a [`StatefulWidget`](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html) that creates the future, checks for completion or error, calls `setState()`, and generally handles all the wiring manually.

假设你有一个会返回一些 JSON 数据的网络服务，你想显示这些数据。
你可以创建一个
[`StatefulWidget`](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html)，
由它创建 future、检查完成或错误、调用 `setState()`，
总之手动处理所有的衔接工作。

Or you can use [`FutureBuilder`](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html). It’s a widget that comes with the Flutter SDK. You give it a future and a builder function, and it automatically rebuilds its children when the future completes.

或者你可以使用
[`FutureBuilder`](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html)。
这是 Flutter SDK 自带的一个 widget。
你给它一个 future 和一个构建函数（builder function），
它就会在 future 完成时自动重建其子 widget。

The `FutureBuilder` widget works by calling its builder function, which takes a context and a snapshot of the current state of the future.

`FutureBuilder` widget 的工作方式是调用它的构建函数，
该函数接受一个 context 和 future 当前状态的快照（snapshot）。

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use a FutureBuilder.
    return FutureBuilder<String>(
      future: _fetchNetworkData(),
      builder: (context, snapshot) {},
    );
  }
}
```

You can check the snapshot to see whether the future completed with an error:

你可以检查快照，看看 future 是否以错误完成：

```dart
    return FutureBuilder<String>(
      future: _fetchNetworkData(5),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // Future completed with an error.
          return Text(
            'There was an error',
          );
        }
        throw UnimplementedError("Case not handled yet");
      },
    );
```

Otherwise you can check the `hasData` property to see if it completed with a value:

否则，你可以检查 `hasData` 属性，看看它是否以值完成：

```dart
    return FutureBuilder<String>(
      future: _fetchNetworkData(5),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // Future completed with an error.
          return Text(
            'There was an error',
          );
        } else if (snapshot.hasData) {
          // Future completed with a value.
          return Text(
            json.decode(snapshot.data)['field'],
          );
        }
        throw UnimplementedError("Case not handled yet");
      },
    );
```

If neither `hasError` nor `hasData` is true, then you know you’re still waiting, and you can output something for that as well.

如果 `hasError` 和 `hasData` 都不为 true，
那你就知道还在等待中，也可以为此输出一些内容。

```dart
    return FutureBuilder<String>(
      future: _fetchNetworkData(5),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // Future completed with an error.
          return Text(
            'There was an error',
          );
        } else if (snapshot.hasData) {
          // Future completed with a value.
          return Text(
            json.decode(snapshot.data)['field'],
          );
        } else {
          // Uncompleted.
          return Text(
            'No value yet!',
          );
        }
      },
    );
```

Even in Flutter code, you can see how those three states keep popping up: uncompleted, completed with value, and completed with error.

即使在 Flutter 代码中，你也能看到那三种状态不断出现：
未完成、以值完成、以错误完成。

## Summary

## 总结

This article talked about what futures represent and how you can use the `Future` and `FutureBuilder` APIs to create futures and use their completed values.

本文介绍了 future 代表什么，
以及如何使用 `Future` 和 `FutureBuilder` API
创建 future 并使用它们完成后的值。

If you’d like to learn more about using futures—with the option of using runnable examples and interactive exercises to test your understanding—check out the asynchronous codelab on [futures, async, and await](https://dart.dev/codelabs/async-await).

如果你想进一步学习如何使用 future——
还可以借助可运行的示例和交互式练习来检验你的理解——
请看看关于
[future、async 和 await](https://dart.dev/codelabs/async-await)
的异步 codelab。

Or go on to the next video in the *Asynchronous Programming in Dart* series. It talks about *streams*, which are a lot like futures in that they can provide either values or errors. But where futures just give you one result and stop, streams just keep right on going.

或者继续观看《Dart 异步编程》系列的下一个视频。
它讲的是*流（stream）*，它与 future 很像，也可以提供值或错误。
但 future 只给你一个结果就停止了，而流会一直持续下去。

<YoutubeEmbed id="nQBpOIHE4eE" title="Dart Streams - Flutter in Focus" fullwidth="true"/>


*Big thanks to Andrew Brogdon, who created the video that this article is based on.*

*特别感谢 Andrew Brogdon，他制作了本文所依据的视频。*
