---
# title: Concurrency in Dart
title: Dart 中的并发
# description: >-
#   Use isolates to enable parallel code execution on multiple processor cores.
description: "使用 isolate 在多个处理器核心上并行执行代码。"
ai-translated: true
# shortTitle: Concurrency
shortTitle: 并发
lastVerified: 2023-12-14
prevpage:
  url: /language/modifier-reference
# title: Class modifiers reference
  title: 类修饰符参考
nextpage:
  url: /language/async
# title: Async
  title: 异步编程
---

<?code-excerpt path-base="concurrency"?>

This page contains a conceptual overview of how concurrent programming works in
Dart. It explains the event-loop, async language features, and isolates from
a high-level. For more practical code examples of using concurrency in Dart,
read the [Asynchronous programming](/language/async) page and 
[Isolates](/language/isolates) page.

本页从概念上概述 Dart 中并发编程的工作方式，
从较高层面介绍事件循环、异步语言特性和 isolate。
想了解 Dart 并发更实际的代码示例，
请阅读 [异步编程](/language/async) 页面和
[Isolates](/language/isolates) 页面。

Concurrent programming in Dart refers to both asynchronous APIs, like `Future`
and `Stream`, and *isolates*, which allow you to move processes to separate
cores.

Dart 中的并发编程既指 `Future` 和 `Stream`
这样的异步 API，也指 *isolate*——
它允许你把处理过程移到不同的核心上。

All Dart code runs in isolates, starting in the default main isolate,
and optionally expanding to whatever subsequent isolates you
explicitly create. When you spawn a new isolate,
it has its own isolated memory, and its own event loop.
The event loop is what makes asynchronous and
concurrent programming possible in Dart.

所有 Dart 代码都运行在 isolate 中，
从默认的主 isolate 开始，
并可以扩展到你显式创建的后续 isolate。
当你派生一个新 isolate 时，
它拥有自己独立的内存和自己的事件循环。
正是事件循环让 Dart 中的异步和并发编程成为可能。

## Event Loop

## 事件循环

Dart’s runtime model is based on an event loop.
The event loop is responsible for executing your program's code,
collecting and processing events, and more.

Dart 的运行时模型基于事件循环。
事件循环负责执行程序的代码、
收集和处理事件等。

As your application runs, all events are added to a queue,
called the *event queue*.
Events can be anything from requests to repaint the UI,
to user taps and keystrokes, to I/O from the disk.
Because your app can’t predict what order events will happen,
the event loop processes events in the order they're queued, one at a time.

应用运行时，所有事件都会被加入一个队列，
称为 *事件队列*。
事件可以是任何东西：重绘 UI 的请求、
用户的点按和按键、磁盘 I/O 等。
因为应用无法预测事件发生的顺序，
事件循环按入队顺序逐个处理事件。

![A figure showing events being fed, one by one, into the event loop](/assets/img/language/concurrency/event-loop.png){:.diagram-wrap}

The way the event loop functions resembles this code:

事件循环的工作方式类似这段代码：

```dart
while (eventQueue.waitForEvent()) {
  eventQueue.processNextEvent();
}
```

This example event loop is synchronous and runs on a single thread.
However, most Dart applications need to do more than one thing at a time. 
For example, a client application might need to execute an HTTP request, 
while also listening for a user to tap a button. 
To handle this, Dart offers many async APIs, 
like [Futures, Streams, and async-await](/language/async).
These APIs are built around this event loop.

这个示例事件循环是同步的，运行在单个线程上。
然而，大多数 Dart 应用需要同时做多件事。
例如，客户端应用可能需要执行 HTTP 请求，
同时还要监听用户点按按钮。
为此，Dart 提供了许多异步 API，
如 [Future、Stream 和 async-await](/language/async)。
这些 API 都围绕这个事件循环构建。

For example, consider making a network request:

例如，考虑发起一个网络请求：

```dart
http.get('https://example.com').then((response) {
  if (response.statusCode == 200) {
    print('Success!');
  }  
}
```

When this code reaches the event loop, it immediately calls the
first clause, `http.get`, and returns a `Future`.
It also tells the event loop to hold onto the callback in the `then()` clause
until the HTTP request resolves. When that happens, it should
execute that callback, passing the result of the request as an argument.

当这段代码到达事件循环时，会立即调用
第一个子句 `http.get`，并返回一个 `Future`。
它还会告诉事件循环保留 `then()` 子句中的回调，
直到 HTTP 请求完成。
请求完成时，就执行该回调，
并把请求结果作为参数传入。

![Figure showing async events being added to an event loop and holding onto a callback to execute later .](/assets/img/language/concurrency/async-event-loop.png){:.diagram-wrap}

This same model is generally how the event loop handles all other
asynchronous events in Dart, such as [`Stream`][] objects.

事件循环处理 Dart 中所有其他异步事件
（例如 [`Stream`][] 对象）时，
通常也采用同样的模型。

[`Stream`]: {{site.dart-api}}/dart-async/Stream-class.html

## Asynchronous programming

## 异步编程

This section summarizes the different types and syntaxes of asynchronous programming in Dart.
If you're already familiar with `Future`, `Stream`, and async-await,
then you can skip ahead to the [isolates section][].

本节总结 Dart 中异步编程的不同类型和语法。
如果你已经熟悉 `Future`、`Stream` 和 async-await，
可以直接跳到 [isolate 一节][isolates section]。

[isolates section]: #isolates

### Futures

### Future

A `Future` represents the result of an asynchronous operation that will 
eventually complete with a value or an error.

`Future` 表示一个异步操作的结果，
该操作最终会带着一个值或一个错误完成。

In this sample code, the return type of `Future<String>` represents a 
promise to eventually provide a `String` value (or error).

在这段示例代码中，返回类型 `Future<String>`
表示最终会提供一个 `String` 值（或错误）的承诺。

<?code-excerpt "lib/future_syntax.dart (read-async)"?>
```dart
Future<String> _readFileAsync(String filename) {
  final file = File(filename);

  // .readAsString() returns a Future.
  // .then() registers a callback to be executed when `readAsString` resolves.
  return file.readAsString().then((contents) {
    return contents.trim();
  });
}
```

### The async-await syntax

### async-await 语法

The `async` and `await` keywords provide a declarative way to define
asynchronous functions and use their results.

`async` 和 `await` 关键字提供了一种声明式的方式，
用于定义异步函数并使用它们的结果。

Here's an example of some synchronous code
that blocks while waiting for file I/O:

下面是一段同步代码的例子，
它在等待文件 I/O 时会阻塞：

<?code-excerpt "lib/sync_number_of_keys.dart (blocking)"?>
```dart
const String filename = 'with_keys.json';

void main() {
  // Read some data.
  final fileData = _readFileSync();
  final jsonData = jsonDecode(fileData);

  // Use that data.
  print('Number of JSON keys: ${jsonData.length}');
}

String _readFileSync() {
  final file = File(filename);
  final contents = file.readAsStringSync();
  return contents.trim();
}
```

Here's similar code, but with changes (highlighted) to make it asynchronous:

下面是类似的代码，但做了一些改动（高亮部分）使其变为异步：

<?code-excerpt "lib/async_number_of_keys.dart (non-blocking)" replace="/async|await|readAsString\(\)/[!$&!]/g; /Future<\w+\W/[!$&!]/g;"?>
```dart
const String filename = 'with_keys.json';

void main() [!async!] {
  // Read some data.
  final fileData = [!await!] _readFileAsync();
  final jsonData = jsonDecode(fileData);

  // Use that data.
  print('Number of JSON keys: ${jsonData.length}');
}

[!Future<String>!] _readFileAsync() [!async!] {
  final file = File(filename);
  final contents = [!await!] file.[!readAsString()!];
  return contents.trim();
}
```

The `main()` function uses the `await` keyword in front of `_readFileAsync()`
to let other Dart code (such as event handlers) use the CPU while native code
(file I/O) executes. Using `await` also has the effect of converting
the `Future<String>` returned by `_readFileAsync()` into a `String`. As a
result, the `contents` variable has the implicit type `String`.

`main()` 函数在 `_readFileAsync()` 前使用 `await` 关键字，
让其他 Dart 代码（例如事件处理程序）
在原生代码（文件 I/O）执行期间使用 CPU。
使用 `await` 还会把 `_readFileAsync()` 返回的
`Future<String>` 转换为 `String`。
因此，`contents` 变量的隐式类型是 `String`。

:::note
The `await` keyword works only in functions that have `async` before the
function body.

`await` 关键字只能在函数体前
带有 `async` 的函数中使用。
:::

As the following figure shows, the Dart code pauses while `readAsString()`
executes non-Dart code, in either the Dart runtime or the operating system. 
Once `readAsString()` returns a value, Dart code execution resumes.

如下图所示，当 `readAsString()` 执行非 Dart 代码
（在 Dart 运行时或操作系统中）时，Dart 代码会暂停。
一旦 `readAsString()` 返回值，Dart 代码就恢复执行。

![Flowchart-like figure showing app code executing from start to exit, waiting for native I/O in between](/assets/img/language/concurrency/basics-await.png){:.diagram-wrap}

### Streams

### Stream

Dart also supports asynchronous code in the form of streams. Streams
provide values in the future and repeatedly over time. A promise to provide a
series of `int` values over time has the type `Stream<int>`.

Dart 还以流（stream）的形式支持异步代码。
Stream 在未来随时间反复提供值。
随时间提供一系列 `int` 值的承诺，
其类型是 `Stream<int>`。

In the following example, the stream created with `Stream.periodic`
repeatedly emits a new `int` value every second.

在下面的例子中，用 `Stream.periodic` 创建的流
每秒重复发出一个新的 `int` 值。

<?code-excerpt "lib/stream_syntax.dart"?>
```dart
Stream<int> stream = Stream.periodic(const Duration(seconds: 1), (i) => i * i);
```

#### await-for and yield

#### await-for 与 yield

Await-for is a type of for loop that executes each subsequent iteration of the
loop as new values are provided. In other words, it’s used to “loop over”
streams. In this example, a new value will be emitted from the function
`sumStream` as new values are emitted from the stream that’s provided as an
argument. The `yield` keyword is used rather than `return` in functions that 
return streams of values.

Await-for 是一种 for 循环，
每当有新值提供时就执行下一次迭代。
换句话说，它用于「遍历」流。
在这个例子中，当作为参数传入的流发出新值时，
函数 `sumStream` 也会发出新值。
在返回值流的函数中，
使用 `yield` 关键字而不是 `return`。

<?code-excerpt "lib/await_for_syntax.dart"?>
```dart
Stream<int> sumStream(Stream<int> stream) async* {
  var sum = 0;
  await for (final value in stream) {
    yield sum += value;
  }
}
```

If you'd like to learn more about using `async`, `await`, `Stream`s and
`Future`s, check out the [asynchronous programming tutorial][].

如果想了解更多使用 `async`、`await`、`Stream`
和 `Future` 的内容，
请参阅 [异步编程教程][asynchronous programming tutorial]。

[asynchronous programming tutorial]: /libraries/async/async-await

## Isolates

Dart supports concurrency via isolates, in addition to [asynchronous APIs](#asynchronous-programming).
Most modern devices have multi-core
CPUs. To take advantage of multiple cores, developers sometimes use
shared-memory threads running concurrently. However, shared-state concurrency is
[error prone](https://en.wikipedia.org/wiki/Race_condition#In_software) and can
lead to complicated code.

除了 [异步 API](#asynchronous-programming)，
Dart 还通过 isolate 支持并发。
大多数现代设备都有多核 CPU。
为了利用多个核心，开发者有时会使用
并发运行的共享内存线程。
然而，共享状态的并发
[容易出错](https://en.wikipedia.org/wiki/Race_condition#In_software)，
并可能导致复杂的代码。

Instead of threads, all Dart code runs inside isolates.
Using isolates, your Dart code can perform multiple independent tasks at once,
using additional processor cores if they're available.
Isolates are like threads or processes, but each isolate has its own memory
and a single thread running an event loop.

Dart 不使用线程，所有 Dart 代码都运行在 isolate 内。
使用 isolate，你的 Dart 代码可以同时执行多个独立任务，
并在可用时利用额外的处理器核心。
isolate 类似线程或进程，
但每个 isolate 都有自己的内存，
以及一个运行事件循环的单线程。

Each isolate has its own global fields,
ensuring that none of the state in an isolate is accessible
from any other isolate. Isolates can only communicate to each other via message
passing. No shared state between isolates means concurrency complexities like
[mutexes or locks](https://en.wikipedia.org/wiki/Lock_(computer_science))
and [data races](https://en.wikipedia.org/wiki/Race_condition#Data_race)
won't occur in Dart. That said, isolates don't prevent race conditions all
together. For more information on this concurrency model, read about
the [Actor model](https://en.wikipedia.org/wiki/Actor_model).

每个 isolate 都有自己的全局字段，
确保一个 isolate 中的任何状态
都无法从其他 isolate 访问。
isolate 之间只能通过消息传递通信。
isolate 之间没有共享状态，意味着
[互斥量或锁](https://en.wikipedia.org/wiki/Lock_(computer_science))
和 [数据竞争](https://en.wikipedia.org/wiki/Race_condition#Data_race)
这类并发复杂性不会在 Dart 中出现。
话虽如此，isolate 并不能完全杜绝竞态条件。
关于这种并发模型的更多信息，
请阅读 [Actor 模型](https://en.wikipedia.org/wiki/Actor_model)。

:::note Platform note
Only the [Dart Native platform][] implements isolates.
To learn more about the Dart Web platform,
see the [Concurrency on the web](#concurrency-on-the-web) section.

只有 [Dart Native 平台][Dart Native platform] 实现了 isolate。
要了解 Dart Web 平台的更多信息，
请参阅 [Web 上的并发](#concurrency-on-the-web) 一节。
:::

[Dart Native platform]: /overview#platform

### The main isolate

### 主 isolate

In most cases, you don't need to think about isolates at all. Dart programs run
in the main isolate by default. It’s the thread where a program starts to run
and execute, as shown in the following figure:

大多数情况下，你完全不必考虑 isolate。
Dart 程序默认运行在主 isolate 中。
它是程序开始运行和执行的线程，如下图所示：

![A figure showing a main isolate, which runs `main()`, responds to events, and then exits](/assets/img/language/concurrency/basics-main-isolate.png){:.diagram-wrap}

Even single-isolate programs can execute smoothly. Before continuing to the next
line of code, these apps use [async-await][] to wait for asynchronous operations to
complete. A well-behaved app starts quickly, getting to the event loop as soon
as possible. The app then responds to each queued event promptly, using
asynchronous operations as necessary.

即使是单 isolate 程序也能流畅执行。
在执行下一行代码之前，这些应用使用 [async-await][]
等待异步操作完成。
行为良好的应用启动迅速，尽快进入事件循环，
然后及时响应每个入队的事件，
并在必要时使用异步操作。

[async-await]: /libraries/async/async-await

### The isolate life cycle

### isolate 的生命周期

As the following figure shows,
every isolate starts by running some Dart code,
such as the `main()` function.
This Dart code might register some event listeners—to
respond to user input or file I/O, for example.
When the isolate's initial function returns,
the isolate stays around if it needs to handle events.
After handling the events, the isolate exits.

如下图所示，每个 isolate 都从运行一些 Dart 代码开始，
例如 `main()` 函数。
这些 Dart 代码可能注册一些事件监听器，
例如响应用户输入或文件 I/O。
当 isolate 的初始函数返回时，
如果还需要处理事件，isolate 会继续存在。
处理完事件后，isolate 退出。

![A more general figure showing that any isolate runs some code, optionally responds to events, and then exits](/assets/img/language/concurrency/basics-isolate.png){:.diagram-wrap}

### Event handling

### 事件处理

In a client app, the main isolate's event queue might contain repaint requests
and notifications of tap and other UI events. For example, the following figure
shows a repaint event, followed by a tap event, followed by two repaint events.
The event loop takes events from the queue in first in, first out order.

在客户端应用中，主 isolate 的事件队列
可能包含重绘请求，以及点按和其他 UI 事件的通知。
例如，下图展示了一个重绘事件，接着一个点按事件，
再接着两个重绘事件。
事件循环按先进先出的顺序从队列中取出事件。

![A figure showing events being fed, one by one, into the event loop](/assets/img/language/concurrency/event-loop.png){:.diagram-wrap}

Event handling happens on the main isolate after `main()` exits. In the
following figure, after `main()` exits, the main isolate handles the first
repaint event. After that, the main isolate handles the tap event, followed by a
repaint event.

事件处理发生在 `main()` 退出之后的主 isolate 上。
在下图中，`main()` 退出后，
主 isolate 处理第一个重绘事件，
然后处理点按事件，接着再处理一个重绘事件。

If a synchronous operation takes too much processing time, the app can become
unresponsive. In the following figure, the tap-handling code takes too long, so
subsequent events are handled too late. The app might appear to freeze, and any
animation it performs might be jerky.

如果同步操作占用太多处理时间，应用可能变得无响应。
在下图中，点按处理代码耗时过长，
导致后续事件处理得太晚。
应用看起来可能像卡住了，
它执行的任何动画都可能不流畅。

![A figure showing a tap handler with a too-long execution time](/assets/img/language/concurrency/event-jank.png){:.diagram-wrap}

In client apps, the result of a too-lengthy synchronous operation is often
[janky (non-smooth) UI animation][jank]. Worse, the UI might become completely
unresponsive.

在客户端应用中，过长的同步操作
往往导致 [卡顿（不流畅）的 UI 动画][jank]。
更糟的是，UI 可能完全无响应。

[jank]: {{site.flutter-docs}}/perf/rendering-performance

### Background workers

### 后台 worker

If your app's UI becomes unresponsive due to a time-consuming
computation—[parsing a large JSON file][json], for example—consider offloading
that computation to a worker isolate, often called a _background worker._
A common case, shown in the following figure, is spawning a simple worker
isolate that performs a computation and then exits. The worker isolate returns
its result in a message when it exits.

如果应用的 UI 因为耗时的计算
（例如 [解析大型 JSON 文件][json]）而变得无响应，
可以考虑把计算转移到 worker isolate 上，
通常称为 _后台 worker_。
一个常见场景（如下图所示）是派生一个简单的 worker isolate，
执行计算然后退出。
worker isolate 在退出时通过消息返回结果。

[json]: {{site.flutter-docs}}/cookbook/networking/background-parsing

![A figure showing a main isolate and a simple worker isolate](/assets/img/language/concurrency/isolate-bg-worker.png){:.diagram-wrap}

A worker isolate can perform I/O
(reading and writing files, for example), set timers, and more. It has its own
memory and doesn't share any state with the main isolate. The worker isolate can
block without affecting other isolates.

worker isolate 可以执行 I/O（例如读写文件）、
设置定时器等。
它有自己的内存，不与主 isolate 共享任何状态。
worker isolate 可以阻塞而不影响其他 isolate。

### Using isolates

### 使用 isolate

There are two ways to work with isolates in Dart, depending on the use-case:

在 Dart 中使用 isolate 有两种方式，取决于使用场景：

* Use [`Isolate.run()`][] to perform a single computation on a separate thread.

  使用 [`Isolate.run()`][] 在单独的线程上执行一次计算。
* Use [`Isolate.spawn()`][] to create an isolate that will handle multiple
  messages over time, or a background worker. For more information on working
  with long-lived isolates, read the [Isolates](/language/isolates) page.

  使用 [`Isolate.spawn()`][] 创建一个随时间处理多条消息的
  isolate，或一个后台 worker。
  关于长生命周期 isolate 的更多信息，
  请阅读 [Isolates](/language/isolates) 页面。

In most cases, `Isolate.run` is the recommended
API to run processes in the background.

大多数情况下，`Isolate.run` 是
在后台运行处理过程的推荐 API。

#### `Isolate.run()`

The static `Isolate.run()` method requires one argument: a callback that will be
run on the newly spawned isolate.

静态方法 `Isolate.run()` 需要一个参数：
一个将在新派生的 isolate 上运行的回调。

<?code-excerpt "lib/isolate_run_syntax.dart (slow)"?>
```dart
int slowFib(int n) => n <= 1 ? 1 : slowFib(n - 1) + slowFib(n - 2);

// Compute without blocking current isolate.
void fib40() async {
  var result = await Isolate.run(() => slowFib(40));
  print('Fib(40) = $result');
}
```

### Performance and isolate groups

### 性能与 isolate 组

When an isolate calls [`Isolate.spawn()`][], the two isolates have the same
executable code and are in the same _isolate group_. Isolate groups enable
performance optimizations such as sharing code; a new isolate immediately runs
the code owned by the isolate group. Also, `Isolate.exit()` works only when the
isolates are in the same isolate group.

当一个 isolate 调用 [`Isolate.spawn()`][] 时，
两个 isolate 拥有相同的可执行代码，
并处于同一个 _isolate 组_ 中。
isolate 组支持共享代码等性能优化；
新 isolate 会立即运行 isolate 组拥有的代码。
此外，`Isolate.exit()` 只有在
isolate 处于同一 isolate 组时才有效。

In some special cases, you might need to use [`Isolate.spawnUri()`][], which
sets up the new isolate with a copy of the code that's at the specified URI.
However, `spawnUri()` is much slower than `spawn()`, and the new isolate isn't
in its spawner's isolate group. Another performance consequence is that message
passing is slower when isolates are in different groups.

在某些特殊情况下，你可能需要使用 [`Isolate.spawnUri()`][]，
它会用指定 URI 处代码的副本来建立新 isolate。
然而，`spawnUri()` 比 `spawn()` 慢得多，
而且新 isolate 不在派生者的 isolate 组中。
另一个性能影响是：当 isolate 处于不同组时，
消息传递会更慢。

[`Isolate.spawnUri()`]: {{site.dart-api}}/dart-isolate/Isolate/spawnUri.html

### Limitations of isolates

### isolate 的限制

#### Isolates aren't threads

#### isolate 不是线程

If you’re coming to Dart from a language with multithreading, it’d be reasonable
to expect isolates to behave like threads, but that isn’t the case. Each isolate
has its own state, ensuring that none of the state in an isolate is
accessible from any other isolate. Therefore, isolates are limited by their
access to their own memory.

如果你来自一门支持多线程的语言，
很自然会期望 isolate 表现得像线程，但事实并非如此。
每个 isolate 都有自己的状态，
确保一个 isolate 中的任何状态
都无法从其他 isolate 访问。
因此，isolate 只能访问自己的内存。

For example, if you have an application with a
global mutable variable, that variable will be a separate
variable in your spawned isolate. If you mutate that variable in the spawned
isolate, it will remain untouched in the main isolate. This is how isolates are
meant to function, and it's important to keep in mind when you’re considering
using isolates.

例如，如果你的应用有一个全局可变变量，
那么在派生的 isolate 中，
这个变量会是一个独立的变量。
如果你在派生的 isolate 中修改该变量，
主 isolate 中的变量不受影响。
这就是 isolate 的设计工作方式，
在考虑使用 isolate 时务必记住这一点。

#### Message types

#### 消息类型

Messages sent via [`SendPort`][]
can be almost any type of Dart object, but there are a few exceptions:

通过 [`SendPort`][] 发送的消息
几乎可以是任何类型的 Dart 对象，但有几个例外：

- Objects with native resources, such as [`Socket`][].
- [`ReceivePort`][]
- [`DynamicLibrary`][]
- [`Finalizable`][]
- [`Finalizer`][]
- [`NativeFinalizer`][]
- [`Pointer`][]
- [`UserTag`][]
- Instances of classes that are marked with `@pragma('vm:isolate-unsendable')`

Apart from those exceptions, any object can be sent.
Check out the [`SendPort.send`][] documentation for more information.

除了这些例外，任何对象都可以发送。
更多信息请查阅 [`SendPort.send`][] 文档。

Note that `Isolate.spawn()` and `Isolate.exit()` abstract over `SendPort` 
objects, so they're subject to the same limitations.

注意，`Isolate.spawn()` 和 `Isolate.exit()`
对 `SendPort` 对象做了抽象，
因此它们受到同样的限制。

[`SendPort.send`]: {{site.dart-api}}/dart-isolate/SendPort/send.html
[`Socket`]: {{site.dart-api}}/dart-io/Socket-class.html
[`DynamicLibrary`]: {{site.dart-api}}/dart-ffi/DynamicLibrary-class.html
[`Finalizable`]: {{site.dart-api}}/dart-ffi/Finalizable-class.html
[`Finalizer`]: {{site.dart-api}}/dart-core/Finalizer-class.html
[`NativeFinalizer`]: {{site.dart-api}}/dart-ffi/NativeFinalizer-class.html
[`Pointer`]: {{site.dart-api}}/dart-ffi/Pointer-class.html
[`UserTag`]: {{site.dart-api}}/dart-developer/UserTag-class.html

#### Synchronous blocking communication between isolates

#### isolate 之间的同步阻塞通信

There is a limit to the number of isolates that can run in parallel.
This limit doesn't affect the standard *asynchronous* communication between isolates
via messages in Dart. You can have hundreds of isolates running concurrently
and making progress. The isolates are scheduled on the CPU in round-robin fashion,
and yield to each other often.

可以并行运行的 isolate 数量是有上限的。
这个限制不影响 Dart 中 isolate 之间
通过消息进行的标准 *异步* 通信。
你可以让数百个 isolate 并发运行并取得进展。
这些 isolate 以轮转方式在 CPU 上调度，
并经常互相让出执行权。

Isolates can only communicate *synchronously* outside of pure Dart,
using C code via [FFI] to do so. 
Attempting synchronous communication between isolates
by synchronous blocking in FFI calls
might result in deadlock if the number of isolates is over the limit,
unless special care is taken.
The limit is not hardcoded to a particular number,
it's calculated based on the Dart VM heap size available to the Dart application.

isolate 只能在纯 Dart 之外进行 *同步* 通信，
即通过 [FFI] 使用 C 代码来实现。
如果试图通过在 FFI 调用中同步阻塞
来进行 isolate 之间的同步通信，
当 isolate 数量超过上限时，
除非特别小心，否则可能导致死锁。
这个上限不是硬编码的固定数字，
而是根据 Dart 应用可用的 Dart VM 堆大小计算得出的。

To avoid this situation, the C code performing synchronous blocking
needs to leave the current isolate before performing the blocking operation
and re-enter it before returning to Dart from the FFI call.
Read about [`Dart_EnterIsolate`] and [`Dart_ExitIsolate`] to learn more.

为避免这种情况，执行同步阻塞的 C 代码
需要在执行阻塞操作之前离开当前 isolate，
并在从 FFI 调用返回 Dart 之前重新进入它。
阅读 [`Dart_EnterIsolate`] 和 [`Dart_ExitIsolate`] 了解更多。

[FFI]: /interop/c-interop
[`Dart_EnterIsolate`]: {{site.repo.dart.sdk}}/blob/c9a8bbd8d6024e419b5e5f26b5131285eb19cc93/runtime/include/dart_api.h#L1254
[`Dart_ExitIsolate`]: {{site.repo.dart.sdk}}/blob/c9a8bbd8d6024e419b5e5f26b5131285eb19cc93/runtime/include/dart_api.h#L1455

<a id="web"></a>
## Concurrency on the web

## Web 上的并发

All Dart apps can use `async-await`, `Future`, and `Stream`
for non-blocking, interleaved computations. The [Dart web platform][], however,
does not support isolates. Dart web apps can use [web workers][] to run scripts
in background threads similar to isolates. Web workers' functionality and
capabilities differ somewhat from isolates, though.

所有 Dart 应用都可以使用 `async-await`、`Future` 和 `Stream`
进行非阻塞、交错执行的计算。
然而，[Dart Web 平台][Dart web platform] 不支持 isolate。
Dart Web 应用可以使用 [web worker][web workers]
在类似 isolate 的后台线程中运行脚本。
不过，web worker 的功能和能力与 isolate 有所不同。

For instance, when web workers send data between threads, they copy the data
back and forth. Data copying can be very slow, though, especially for large
messages. Isolates do the same, but also provide APIs that can more efficiently
_transfer_
the memory that holds the message instead.

例如，web worker 在线程之间发送数据时，
会来回复制数据。
数据复制可能非常慢，尤其是大消息。
isolate 也会这样做，但还提供了
可以更高效地 _转移_ 承载消息的内存的 API。

Creating web workers and isolates also differs. You can only create web workers
by declaring a separate program entrypoint and compiling it separately. Starting
a web worker is similar to using `Isolate.spawnUri` to start an isolate. You can
also start an isolate with `Isolate.spawn`, which requires fewer resources
because it
[reuses some of the same code and data](#performance-and-isolate-groups)
as the spawning isolate. Web workers don't have an equivalent API.

创建 web worker 和 isolate 的方式也不同。
你只能通过声明一个单独的程序入口并单独编译它
来创建 web worker。
启动 web worker 类似于用 `Isolate.spawnUri` 启动 isolate。
你也可以用 `Isolate.spawn` 启动 isolate，
它需要的资源更少，因为它
[复用了与派生 isolate 相同的部分代码和数据](#performance-and-isolate-groups)。
web worker 没有等价的 API。

[Dart web platform]: /overview#platform
[web workers]: https://developer.mozilla.org/docs/Web/API/Web_Workers_API/Using_web_workers


## Additional resources

## 更多资源

- If you’re using many isolates, consider
  the [`IsolateNameServer`][]
  in Flutter, or
  [`package:isolate_name_server`][] that provides
  similar functionality for non-Flutter Dart applications.

  如果你使用了很多 isolate，可以考虑 Flutter 中的
  [`IsolateNameServer`][]，
  或为非 Flutter Dart 应用提供类似功能的
  [`package:isolate_name_server`][]。
- Read more about [Actor model][], which Dart's isolates are based on.

  Dart 的 isolate 基于 [Actor 模型][Actor model]，
  可以阅读更多相关内容。
- Additional documentation on `Isolate` APIs:

  `Isolate` API 的更多文档：
    - [`Isolate.exit()`][]
    - [`Isolate.spawn()`][]
    - [`ReceivePort`][]
    - [`SendPort`][]

[`IsolateNameServer`]: {{site.flutter-api}}/flutter/dart-ui/IsolateNameServer-class.html
[`package:isolate_name_server`]: {{site.pub-pkg}}/isolate_name_server
[Actor model]: https://en.wikipedia.org/wiki/Actor_model
[`Isolate.run()`]: {{site.dart-api}}/dart-isolate/Isolate/run.html
[`Isolate.exit()`]: {{site.dart-api}}/dart-isolate/Isolate/exit.html
[`Isolate.spawn()`]: {{site.dart-api}}/dart-isolate/Isolate/spawn.html
[`ReceivePort`]: {{site.dart-api}}/dart-isolate/ReceivePort-class.html
[`SendPort`]: {{site.dart-api}}/dart-isolate/SendPort-class.html
