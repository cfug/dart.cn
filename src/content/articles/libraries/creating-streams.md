---
# title: Creating streams in Dart
title: 在 Dart 里使用 Stream
# description: A stream is a sequence of results; learn how to create your own.
description: Stream 是一个结果序列，本篇带你学会如何创建自己的 Stream。
original-date: 2013-04-08
date: 2021-05-16
---

<style>
.comment {color:red;}
</style>

_Written by Lasse Nielsen <br>
April 2013 (updated May 2021)_

The dart:async library contains two types
that are important for many Dart APIs:
[Stream]({{site.dart-api}}/{{site.sdkInfo.channel}}/dart-async/Stream-class.html) and
[Future.]({{site.dart-api}}/{{site.sdkInfo.channel}}/dart-async/Future-class.html)
Where a Future represents the result of a single computation,
a stream is a _sequence_ of results.
You listen on a stream to get notified of the results
(both data and errors)
and of the stream shutting down.
You can also pause while listening or stop listening to the stream
before it is complete.

dart:async 库中有两个类型，它们对许多 Dart API 来说都非常重要：
[Stream]({{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-async/Stream-class.html) 
和 [Future]({{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-async/Future-class.html)。
Future 用于表示单个运算的结果，而 Stream 则表示多个结果的序列。
你可以监听 Stream 以获取其结果（包括数据和错误）或其关闭事件。
也可以在 Stream 完成前对其暂停或停止监听。

But this article is not about _using_ streams.
It's about creating your own streams.
You can create streams in a few ways:

但是本篇文章并非阐述 **如何使用** Stream，
而是向你介绍如何创建 Stream。
你可以通过以下几种方式创建 Stream。

* Transforming existing streams.

  转换现有的 Stream。

* Creating a stream from scratch by using an `async*` function.

  使用 `async*` 函数创建 Stream。

* Creating a stream by using a `StreamController`.

  使用 `StreamController` 生成 Stream。

This article shows the code for each approach
and gives tips to help you implement your stream correctly.

本文将向你展示每种方式的代码并且会给你一些有用的提示，
这些提示可以帮助你正确创建 Stream。

For help on using streams, see
[Asynchronous Programming: Streams](/tutorials/language/streams).

可以查阅　[异步编程：使用 Stream](/tutorials/language/streams) 
获取更多关于 Stream 的信息。

## Transforming an existing stream

## 转换现有的 Stream

The common case for creating streams is that you already have a stream,
and you want to create a new stream based on the original stream's events.
For example you might have a stream of bytes that
you want to convert to a stream of strings by UTF-8 decoding the input.
The most general approach is to create a new stream that
waits for events on the original stream and then
outputs new events. Example:

我们在创建 Stream 时常见的情形是根据现有 Stream 的事件创建一个新的 Stream。
比如你已经有了一个可以提供字节事件的 Stream，
然后你想将该 Stream 变为一个可以提供字符串的 Stream，
并且该 Stream 中的字符串还经过 UTF-8 编码。
对于这种情况，常用的办法是创建一个新的 Stream 去等待获取原 Stream 的事件，
然后再将新 Stream 中的事件输出。例如：

<?code-excerpt "misc/lib/articles/creating-streams/line_stream_generator.dart (split-into-lines)"?>
```dart
/// Splits a stream of consecutive strings into lines.
///
/// The input string is provided in smaller chunks through
/// the `source` stream.
Stream<String> lines(Stream<String> source) async* {
  // Stores any partial line from the previous chunk.
  var partial = '';
  // Wait until a new chunk is available, then process it.
  await for (final chunk in source) {
    var lines = chunk.split('\n');
    lines[0] = partial + lines[0]; // Prepend partial line.
    partial = lines.removeLast(); // Remove new partial line.
    for (final line in lines) {
      yield line; // Add lines to output stream.
    }
  }
  // Add final partial line to output stream, if any.
  if (partial.isNotEmpty) yield partial;
}
```

For many common transformations,
you can use `Stream`-supplied transforming methods
such as `map()`, `where()`, `expand()`, and `take()`.

你可以使用 `Stream` 类提供的转换类方法，比如 
`map()`、`where()`、`expand()` 和 `take()` 来应对大多数常见的转换需求。

For example, assume you have a stream, `counterStream`,
that emits an increasing counter every second.
Here's how it might be implemented:

例如，假设你有一个名为 `counterStream` 的 Stream，
用于每秒打印输出一个自增的整数。其实现过程可能如下：

<?code-excerpt "misc/lib/articles/creating-streams/stream_controller.dart (basic-usage)"?>
```dart
var counterStream =
    Stream<int>.periodic(const Duration(seconds: 1), (x) => x).take(15);
```

To quickly see the events, you can use code like this:

你可以使用下面的代码快速查看事件：

<?code-excerpt "misc/lib/articles/creating-streams/stream_controller.dart (basic-for-each)"?>
```dart
counterStream.forEach(print); // Print an integer every second, 15 times.
```

To transform the stream events, you can invoke a transforming method
such as `map()` on the stream before listening to it.
The method returns a new stream.

你可以在监听 Stream 前调用一个类似 `map()` 
的转换方法来转换 Stream 的事件。该方法将返回一个新的 Stream。

<?code-excerpt "misc/lib/articles/creating-streams/stream_controller.dart (use-map)"?>
```dart
// Double the integer in each event.
var doubleCounterStream = counterStream.map((int x) => x * 2);
doubleCounterStream.forEach(print);
```

Instead of `map()`, you could use any other transforming method,
such as the following:

你可以使用任意其它的变换方法替代 `map()`，
比如类似下面的这些：

<?code-excerpt "misc/lib/articles/creating-streams/stream_controller.dart (use-where)"?>
```dart
.where((int x) => x.isEven) // Retain only even integer events.
.expand((var x) => [x, x]) // Duplicate each event.
.take(5) // Stop after the first five events.
```

Often, a transforming method is all you need.
However, if you need even more control over the transformation,
you can specify a
[StreamTransformer]({{site.dart-api}}/{{site.sdkInfo.channel}}/dart-async/StreamTransformer-class.html)
with `Stream`'s `transform()` method.
The platform libraries provide stream transformers for many common tasks.
For example, the following code uses the `utf8.decoder` and `LineSplitter`
transformers provided by the dart:convert library.

通常而言，使用各种转换方法足以满足你简单的使用需求。
但是，如果你需要对转换进行更多的控制，
你可以使用 `Stream` 类的 `transform()` 方法指定一个 
[StreamTransformer]({{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-async/StreamTransformer-class.html)。
Dart 平台库为许多常见的任务需求提供了 Stream 转换器。
例如下面的代码使用了由 dart:convert 库提供的
`utf8.decoder` 和 `LineSplitter` 转换器。

<?code-excerpt "misc/lib/articles/creating-streams/stream_controller.dart (use-transform)"?>
```dart
Stream<List<int>> content = File('someFile.txt').openRead();
List<String> lines = await content
    .transform(utf8.decoder)
    .transform(const LineSplitter())
    .toList();
```


## Creating a stream from scratch

## 从零开始创建 Stream

One way to create a new stream is with
an asynchronous generator (`async*`) function.
The stream is created when the function is called,
and the function's body starts running when the stream is listened to.
When the function returns, the stream closes.
Until the function returns, it can emit events on the stream by
using `yield` or `yield*` statements.

上一小节中我们使用一个现有的 Stream 经过转换生成新的 Stream。
这一小节我们通过异步生成器 (`async*`) 函数来完完全全地创建一个 Stream。
当异步生成器函数被调用时会创建一个 Stream，
而函数体则会在该 Stream 被监听时开始运行。
当函数返回时，Stream 关闭。在函数返回前，
你可以使用 `yield` 或 `yield*` 语句向该 Stream 提交事件。

Here's a primitive example that emits numbers at regular intervals:

下面是一个周期性发送整数的函数例子：

<?code-excerpt "misc/lib/articles/creating-streams/stream_controller.dart (async-generator)" replace="/timedCounterGenerator/timedCounter/g"?>
```dart
Stream<int> timedCounter(Duration interval, [int? maxCount]) async* {
  int i = 0;
  while (true) {
    await Future.delayed(interval);
    yield i++;
    if (i == maxCount) break;
  }
}
```

{% comment %}
[PENDING: show code that uses it, so we have some context for
the mention of StreamSubscription?]
{% endcomment %}

This function returns a `Stream`.
When that stream is listened to, the body starts running.
It repeatedly delays for the requested interval and then yields the next number.
If the `maxCount` parameter is omitted, there is no stop condition on the loop,
so the stream outputs increasingly larger numbers forever -
or until the listener cancels its subscription.

该函数返回一个 `Stream`。而函数体会在该 Stream 被监听时开始运行
且以一定的周期间隔在指定的数字范围内不断地生成一个递增数字。
如果省略掉 `count` 参数，那么循环将无休止地执行下去，
此时除非取消订阅，否则 Stream 会不停地生成越来越多的数字。

When the listener cancels
(by invoking `cancel()` on the `StreamSubscription`
object returned by the `listen()` method),
then the next time the body reaches a `yield` statement,
the `yield` instead acts as a `return` statement.
Any enclosing `finally` block is executed,
and the function exits.
If the function attempts to yield a value before exiting,
that fails and acts as a return.

当监听器取消时（调用由 `listen()` 方法返回的 `StreamSubscription` 
对象中的 `cancel()` 方法），如果下一次循环体执行到 `yield` 语句，
此时该语句的作用类似于 `return` 语句。而且任意 `finally`
语句块在此时执行均会导致函数退出。如果函数尝试在退出前 yield 一个值，
那么该尝试将会以失败告终并产生类似于 return 语句的效果。

When the function finally exits, the future returned by
the `cancel()` method completes.
If the function exits with an error, the future completes with that error;
otherwise, it completes with `null`.

当函数最终退出时，由 `cancel()` 方法返回的 Future 完成。
如果函数是因为出错导致退出，
则 Future 完成时会携带对应的错误，否则其会携带一个 `null` 。

Another, more useful example is a function that converts
a sequence of futures to a stream:

另外，一个更有用的示例是将一个 Future 序列转换为 Stream 的函数：

<?code-excerpt "misc/lib/articles/creating-streams/stream_controller.dart (stream-from-futures)"?>
```dart
Stream<T> streamFromFutures<T>(Iterable<Future<T>> futures) async* {
  for (final future in futures) {
    var result = await future;
    yield result;
  }
}
```

This function asks the `futures` iterable for a new future,
waits for that future, emits the resulting value, and then loops.
If a future completes with an error, then the stream completes with that error.

该函数循环向 `Future` 序列请求一个 Future 并等待该 Future 完成获取其结果后
提交给 Stream。如果某个 Future 因出错完成，则该错误也会提交给 Stream。

It's rare to have an `async*` function building a stream from nothing.
It needs to get its data from somewhere,
and most often that somewhere is another stream.
In some cases, like the sequence of futures above,
the data comes from other asynchronous event sources.
In many cases, however, an `async*` function is too simplistic to
easily handle multiple data sources.
That's where the `StreamController` class comes in.

在实际应用中，通过 `async*` 函数从零构建 Stream 的情况比较少见。
`async*` 函数通常会根据某些数据源来创建 Stream，
而这些数据源常常又是另一个 Stream。
比如像上述示例中的 Future 序列，其数据往往来自于其它的异步事件源。
然而，在许多情况下，异步函数过于简单难以轻松地处理多个数据源的场景。
而这就是 `StreamController` 类的用武之地。


## Using a StreamController

## 使用 StreamController

If the events of your stream comes from different parts of your program,
and not just from a stream or futures that can traversed by an `async` function,
then use a
[StreamController]({{site.dart-api}}/{{site.sdkInfo.channel}}/dart-async/StreamController-class.html)
to create and populate the stream.

如果你 Stream 的事件不仅来自于异步函数可以遍历的 Stream 和 Future，
还来自于你程序的不同部分，这种情况使用上述两种方式生成 Stream 就显得比较困难。
面对这种情况，我们可以使用一个
[StreamController]({{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-async/StreamController-class.html)
来创建和填充 Stream。

A `StreamController` gives you a new stream
and a way to add events to the stream at any point, and from anywhere.
The stream has all the logic necessary to handle listeners and pausing.
You return the stream and keep the controller to yourself.

`StreamController` 可以为你生成一个 Stream，
并提供在任何时候、任何地方将事件添加到该 Stream 的方法。
该 Stream 具有处理监听器和暂停所需的所有逻辑。
控制器对象你可以自行处理而只需返回调用者所需的 Stream 即可。

The following example
(from [stream_controller_bad.dart][])
shows a basic, though flawed, usage of `StreamController`
to implement the `timedCounter()` function from the previous examples.
This code creates a stream to return,
and then feeds data into it based on timer events,
which are neither futures nor stream events.

下面的代码将为你展示一个简单的示例
（出自 [stream_controller_bad.dart][]），
该示例使用 `StreamController` 来实现上一个示例中的 `timedCounter()` 函数。
尽管该示例有一定的缺陷，但其为你展示了 `StreamController` 的基本用法。
该代码将数据直接添加至 `StreamController` 而不是从 Future 或 Stream 中获取，
并在最后返回 `StreamController` 中的 Stream。

[stream_controller_bad.dart]: {{site.repo.this}}/blob/main/examples/misc/lib/articles/creating-streams/stream_controller_bad.dart

<?code-excerpt "misc/lib/articles/creating-streams/stream_controller_bad.dart (flawed-stream)"?>
```dart tag=bad
// NOTE: This implementation is FLAWED!
// It starts before it has subscribers, and it doesn't implement pause.
Stream<int> timedCounter(Duration interval, [int? maxCount]) {
  var controller = StreamController<int>();
  int counter = 0;
  void tick(Timer timer) {
    counter++;
    controller.add(counter); // Ask stream to send counter values as event.
    if (maxCount != null && counter >= maxCount) {
      timer.cancel();
      controller.close(); // Ask stream to shut down and tell listeners.
    }
  }

  Timer.periodic(interval, tick); // BAD: Starts before it has subscribers.
  return controller.stream;
}
```

As before, you can use the stream returned by `timedCounter()` like this:

与前面一样，你可以像下面这样使用由 `timedCounter()` 函数返回的 Stream：

{% comment %}
**[PENDING: Did we show this before?]**
{% endcomment %}

<?code-excerpt "misc/lib/articles/creating-streams/stream_controller_bad.dart (using-stream)"?>
```dart
var counterStream = timedCounter(const Duration(seconds: 1), 15);
counterStream.listen(print); // Print an integer every second, 15 times.
```

This implementation of `timedCounter()` has
a couple of problems:

`timedCounter()` 函数的实现有两个问题：

* It starts producing events before it has subscribers.

  它在拥有订阅者之前就开始生成事件。

* It keeps producing events even if the subscriber requests a pause.

  即使订阅者请求暂停，它也会继续生成事件。

As the next sections show,
you can fix both of these problems by specifying
callbacks such as `onListen` and `onPause`
when creating the `StreamController`.

如下一节所示，你可以在创建 `StreamController` 时通过指定回调，
比如 `onListen` 和 `onPause` 来修复这些问题。


### Waiting for a subscription

### 等待订阅

As a rule, streams should wait for subscribers before starting their work.
An `async*` function does this automatically,
but when using a `StreamController`,
you are in full control and can add events even when you shouldn't.
When a stream has no subscriber,
its `StreamController` buffers events,
which can lead to a memory leak
if the stream never gets a subscriber.

一般来说，Stream 应该在它生成事件前等待订阅者，否则事件的生成毫无意义。
对 `async*` 函数而言，它可以自行处理该问题。但是当使用 `StreamController` 时，
因为你可以有比使用 `async*` 函数更多的控制能力，
因此你完全可以无视相关规则自行添加并控制事件。
如果一个 Stream 没有订阅者，它的 `StreamController` 会不断缓存事件，
这可能会导致内存泄露。

Try changing the code that uses the stream to the following:

将上面示例中使用 Stream 的代码更改为如下：

<?code-excerpt "misc/lib/articles/creating-streams/stream_controller_bad.dart (pre-subscribe-problem)"?>
```dart
void listenAfterDelay() async {
  var counterStream = timedCounter(const Duration(seconds: 1), 15);
  await Future.delayed(const Duration(seconds: 5));

  // After 5 seconds, add a listener.
  await for (final n in counterStream) {
    print(n); // Print an integer every second, 15 times.
  }
}
```

When this code runs,
nothing is printed for the first 5 seconds,
although the stream is doing work.
Then the listener is added,
and the first 5 or so events are printed all at once,
since they were buffered by the `StreamController`.

当我们运行上述代码时，尽管 Stream 一开始就工作，
但最开始的 5 秒内不会有任何东西打印输出。
5 秒后我们向 Stream 添加监听器，
此时前面的 5 个事件会被同时输出，
因为它们被 `StreamController` 缓存了。

To be notified of subscriptions, specify an
`onListen` argument when you create the `StreamController`.
The `onListen` callback is called
when the stream gets its first subscriber.
If you specify an `onCancel` callback,
it's called when the controller loses its last subscriber.
In the preceding example,
`Timer.periodic()`
should move to an `onListen` handler,
as shown in the next section.

当你构建 `StreamController` 时，
可以为其指定一个 `onListen` 参数回调用以接收订阅通知。
当 Stream 获取到它的第一个订阅者时会触发调用 `onListen` 回调。
同样地，你也可以指定一个 `onCancel` 回调，
该回调则会在控制器丢失它最后一个订阅者时触发调用。
在上述例子中，
`Timer.periodic()` 的调用应该移至 `onListen` 中进行，如下一节所示。


### Honoring the pause state

### 遵循并实现暂停

Avoid producing events when the listener has requested a pause.
An `async*` function automatically pauses at a `yield` statement
while the stream subscription is paused.
A `StreamController`, on the other hand, buffers events during the pause.
If the code providing the events doesn't respect the pause,
the size of the buffer can grow indefinitely.
Also, if the listener stops listening soon after pausing,
then the work spent creating the buffer is wasted.

当监听器请求暂停时应当避免继续生成事件。
当 Stream 订阅暂停时，async* 函数可以自动地在一个 `yield` 语句执行时暂停。
而 `StreamController` 则会在暂停时缓存事件。
如果代码在处理事件生成时不考虑暂停功能，则缓存的大小可以无限制地增长。
而且如果在暂停后监听器很快又请求停止，
那么在暂停到停止这段时间内所做的缓存工作都是浪费的。

To see what happens without pause support,
try changing the code that uses the stream to the following:

为了可以查看在不支持暂停的时候会发生什么，
我们将上面使用 Stream 的代码更改为如下：

<?code-excerpt "misc/lib/articles/creating-streams/stream_controller_bad.dart (pause-problem)"?>
```dart
void listenWithPause() {
  var counterStream = timedCounter(const Duration(seconds: 1), 15);
  late StreamSubscription<int> subscription;

  subscription = counterStream.listen((int counter) {
    print(counter); // Print an integer every second.
    if (counter == 5) {
      // After 5 ticks, pause for five seconds, then resume.
      subscription.pause(Future.delayed(const Duration(seconds: 5)));
    }
  });
}
```

When the five seconds of pause are up,
the events fired during that time are all received at once.
That happens because the stream's source doesn't honor pauses
and keeps adding events to the stream.
So the stream buffers the events,
and it then empties its buffer when the stream becomes unpaused.

当五秒钟的暂停时间结束时，在此期间生成的事件将同时被输出。
出现这种状况的原因是因为生成 Stream 的源没有遵循暂停规则，
因此其会持续不断地向向 Stream 中添加事件。
进而导致 Stream 缓存事件，
然后，当 Stream 从暂停中恢复时，它会清空并输出其缓存。

The following version of `timedCounter()`
(from [stream_controller.dart][])
implements pause by using the
`onListen`, `onPause`, `onResume`, and `onCancel` callbacks
on the `StreamController`.

下面代码所实现的 `timedCounter()` 版本
（出自 [stream_controller.dart][]）
通过使用 `StreamController` 中的
`onListen`、`onPause`、`onResume` 和 `onCancel` 回调实现暂停功能。

[stream_controller.dart]: {{site.repo.this}}/blob/main/examples/misc/lib/articles/creating-streams/stream_controller.dart

<?code-excerpt "misc/lib/articles/creating-streams/stream_controller.dart (better-stream)"?>
```dart
Stream<int> timedCounter(Duration interval, [int? maxCount]) {
  late StreamController<int> controller;
  Timer? timer;
  int counter = 0;

  void tick(_) {
    counter++;
    controller.add(counter); // Ask stream to send counter values as event.
    if (counter == maxCount) {
      timer?.cancel();
      controller.close(); // Ask stream to shut down and tell listeners.
    }
  }

  void startTimer() {
    timer = Timer.periodic(interval, tick);
  }

  void stopTimer() {
    timer?.cancel();
    timer = null;
  }

  controller = StreamController<int>(
      onListen: startTimer,
      onPause: stopTimer,
      onResume: startTimer,
      onCancel: stopTimer);

  return controller.stream;
}
```

Run this code with the `listenWithPause()` function above.
You'll see that it stops counting while paused,
and it resumes nicely afterwards.

在 `listenWithPause()` 函数中使用上面的这个 `timedCounter` 函数，
运行后你就可以看到当订阅暂停时打印输出的计数也会暂停，
尔后又可以正确地恢复。

You must use all of the listeners—`onListen`,
`onCancel`, `onPause`, and `onResume`—to be
notified of changes in pause state.
The reason is that if the
subscription and pause states both change at the same time,
only the `onListen` or `onCancel` callback is called.

你必须使用全部的回调 `onListen`、`onCancel`、`onPause` 和 `onResume`
来通知暂停状态的变化，否则如果订阅状态与暂停状态在同一时间都改变了，
只会有 `onListen` 或 `onCancel` 回调会被调用。


## Final hints

## 最后的提示

When creating a stream without using an async* function,
keep these tips in mind:

当你不通过 async* 函数创建 Stream 时，请务必牢记以下几点：

* Be careful when using a synchronous controller—for example,
  one created using `StreamController(sync: true)`.
  When you send an event on an unpaused synchronous controller
  (for example, using the `add()`, `addError()`, or `close()` methods defined by
  [EventSink]({{site.dart-api}}/{{site.sdkInfo.channel}}/dart-async/EventSink-class.html)),
  the event is sent immediately to all listeners on the stream.
  `Stream` listeners must never be called until
  the code that added the listener has fully returned,
  and using a synchronous controller at the wrong time can
  break this promise and cause good code to fail.
  Avoid using synchronous controllers.

  使用同步控制器时要小心。
  例如，使用 `StreamController(sync: true)` 构造方法创建控制器。
  当你发送一个事件到一个未暂停的同步控制器
  （例如：使用 [EventSink]({{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-async/EventSink-class.html) 
  中定义的 `add()`、`addError()` 或 `close()` 方法），
  事件立即发送给所有 Stream 的监听器。
  在添加监听器的代码返回之前，决不能调用 `Stream` 监听器，
  而在错误的事件使用同步控制器会破坏该规则并导致其它正常代码执行失败。
  因此，你应该避免使用同步控制器。

* If you use `StreamController`,
  the `onListen` callback is called before
  the `listen` call returns the `StreamSubscription`.
  Don't let the `onListen` callback depend
  on the subscription already existing.
  For example, in the following code,
  an `onListen` event fires
  (and `handler` is called)
  before the `subscription` variable
  has a valid value.

  如果你使用 `StreamController`，
  `onListen` 回调会在 `listen` 方法调用返回 `StreamSubscription` 前返回。
  不要让 `onListen` 回调依赖于已经存在的订阅。
  例如，在下面的代码中，`onListen` 回调有可能会在 `subscription`
  变量被初始化为一个有效值之前被触发（同时 `处理器` 被调用）。

  <?code-excerpt "misc/lib/articles/creating-streams/stream_controller.dart (stream-listen-hint)"?>
  ```dart
  subscription = stream.listen(handler);
  ```

* The `onListen`, `onPause`, `onResume`, and `onCancel`
  callbacks defined by `StreamController` are
  called by the stream when the stream's listener state changes,
  but never during the firing of an event
  or during the call of another state change handler.
  In those cases, the state change callback is delayed until
  the previous callback is complete.

  当 Stream 的监听器状态改变时，
  由 `StreamController` 定义的
  `onListen`、`onPause`、`onResume` 和 `onCancel` 回调会被调用，
  该调用绝不会发生在事件生成时或在某个状态变化处理回调的调用期间。
  在这些情况出现时，状态变化的回调会被延迟，直到上一个回调执行完成。

* Don't try to implement the `Stream` interface yourself.
  It's easy to get the interaction between events, callbacks,
  and adding and removing listeners subtly wrong.
  Always use an existing stream, possibly from a `StreamController`,
  to implement the `listen` call of a new stream.

  不要尝试自己去实现 `Stream` 接口。
  否则很容易在事件、回调以及添加和移除监听器这些操作交互时出现一些难以察觉的错误。
  你应该总是使用一个现有的 Stream（比如由 `StreamController` 生成的）
  去实现新 Stream 中 `listen` 方法的调用。

* Although it's possible to create classes that extend `Stream` with
  more functionality by extending the `Stream` class and
  implementing the `listen` method and the extra functionality on top,
  that is generally not recommended because
  it introduces a new type that users have to consider.
  Instead of a class that _is_ a `Stream` (and more), 
  you can often make a class that _has_ a `Stream` (and more).

  尽管你可以通过扩展 `Stream` 类并实现 `listen` 方法来实现更多额外的功能，
  但一般不建议这么做，因为这样会引入一个调用者必须考虑的新类型。
  相反，你可以创建一个（或多个）具有 `Stream` 的类而不是一个（或多个）Stream。

{% comment %}
The tests for this article are at /src/tests/site/articles/creating-streams.
{% endcomment %}
