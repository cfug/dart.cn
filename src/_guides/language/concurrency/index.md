---
title: Concurrency in Dart
title: Dart 中的并发
description: Use isolates to enable parallel code execution on multiple processor cores.
description: 使用 isolates 在多核设备上并发执行代码。
---

<?code-excerpt path-base="concurrency"?>

<style>
  img {
    padding: 15px 0;
  }
}

</style>

Dart supports concurrent programming with async-await, isolates, and
classes such as `Future` and `Stream`.
This page gives an overview of async-await, `Future`, and `Stream`,
but it's mostly about isolates.

Dart 通过 async-await、isolate 以及一些异步类型概念
（例如 `Future` 和 `Stream`）支持了并发代码编程。
本篇文章会对 async-await、`Future` 和 `Stream`
进行简略的介绍，而侧重点放在 isolate 的讲解上。

Within an app, all Dart code runs in an _isolate._
Each Dart isolate has a single thread of execution and
shares no mutable objects with other isolates.
To communicate with each other,
isolates use message passing.
Although Dart's isolate model is built with underlying primitives
such as processes and threads
that the operating system provides,
the Dart VM's use of these primitives
is an implementation detail that this page doesn't discuss.

在应用中，所有的 Dart 代码都在 **isolate** 中运行。
每一个 Dart 的 isolate 都有独立的运行线程，它们无法与其他 isolate 共享可变对象。
在需要进行通信的场景里，isolate 会使用消息机制。
尽管 Dart 的 isolate 模型设计是基于操作系统提供的进程和线程等更为底层的原语进行设计的，
但在本篇文章中，我们不对其具体实现展开讨论。

Many Dart apps use only one isolate (the _main isolate_),
but you can create additional isolates,
enabling parallel code execution on multiple processor cores.

大部分 Dart 应用只会使用一个 isolate（即 **主 isolate**），
同时你也可以创建更多的 isolate，从而在多个处理器内核上达成并行执行代码的目的。

{{site.alert.info}}

  **Platform note:**
  All apps can use async-await, `Future`, and `Stream`.
  Isolates are implemented only on the [Dart Native platform][];
  Dart web apps can use [web workers][] for similar functionality.

  **多平台使用时注意：**
  所有的 Dart 应用都可以使用 async-await、`Future` 和 `Stream`。
  而 isolate 仅针对 [原生平台的使用][Dart Native platform] 进行实现。
  使用 Dart 构建的网页应用可以 [使用 Web Workers][] 实现相似的功能。

{{site.alert.end}}

[Dart Native platform]: /overview#platform
[web workers]: https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Using_web_workers
[使用 Web Workers]: https://developer.mozilla.org/zh-CN/docs/Web/API/Web_Workers_API/Using_web_workers


## Asynchrony types and syntax

## 异步的类型和语法

If you’re already familiar with `Future`, `Stream`, and async-await,
then you can skip ahead to the [isolates section][].

如果你已经对 `Future`、`Stream` 和 async-await 比较熟悉了，
可以直接跳到 [isolate 部分][isolates section] 进行阅读。

[isolates section]: #how-isolates-work


### Future and Stream types

### Future 和 Stream 类型

The Dart language and libraries use `Future` and `Stream` objects to
represent values to be provided in the future.
For example, a promise to eventually provide an `int` value
is typed as `Future<int>`.
A promise to provide a series of `int` values
has the type `Stream<int>`.

Dart 语言和库通过 `Future` 和 `Stream` 对象，来提供会在当前调用的未来返回某些值的功能。
以 JavaScript 中的 Promise 为例，
在 Dart 中一个最终会返回 `int` 类型值的 promise，应当声明为 `Future<int>`；
一个会持续返回一系列 `int` 类型值的 promise，应当声明为 `Stream<int>`。

As another example, consider the dart:io methods for reading files.
The synchronous `File` method [`readAsStringSync()`][]
reads a file synchronously,
blocking until the file is either fully read or an error occurs.
The method then either returns an object of type `String`
or throws an exception.
The asynchronous equivalent, [`readAsString()`][],
immediately returns an object of type `Future<String>`.
At some point in the future,
the `Future<String>` completes with either a string value or an error.

让我们用 dart:io 来举另外一个例子。`File` 的同步方法 [`readAsStringSync()`][]
会以同步调用的方式读取文件，在读取完成或者抛出错误前保持阻塞。
这个会返回 `String` 类型的对象，或者抛出异常。
而与它等效的异步方法 [`readAsString()`][]，会在调用时立刻返回
`Future<String>` 类型的对象。
在未来的某一刻，`Future<String>` 会结束，并返回一个字符串或错误。

[`readAsStringSync()`]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-io/File/readAsStringSync.html
[`readAsString()`]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-io/File/readAsString.html

#### Why asynchronous code matters

#### 为什么异步的代码如此重要？

It matters whether a method is synchronous or asynchronous
because most apps need to do more than one thing at a time.

Asynchronous computations are often the result of performing computations
outside of the current Dart code; 
this includes computations that don't complete immediately, 
and where you aren't willing to block your Dart code waiting for the result.
For example, an app might start an HTTP request,
but need to update its display or respond to user input
before the HTTP request completes.
Asynchronous code helps apps stay responsive.

大部分应用需要在同一时刻做很多件事。
例如，应用可能会发起一个 HTTP 请求，
同时在请求返回前对用户的操作做出不同的界面更新。
异步的代码会有助于应用保持更高的可交互状态。

These scenarios include operating system calls like
non-blocking I/O, performing an HTTP request, or communicating with a browser. 
Other scenarios include waiting for computations
performed in another Dart isolate as described below, 
or maybe just waiting for a timer to trigger. 
All of these processes either run in a different thread, 
or are handled by the operating system or the Dart runtime, 
which allows Dart code to run concurrently with the computation.

异步场景包括调用系统 API，例如非阻塞的 I/O 操作、HTTP 请求或与浏览器交互。
还有一些场景是利用 Dart 的 isolate 进行计算，或等待一个计时器的触发。
这些场景要么是在不同的线程运行，要么是被系统或 Dart 运行时处理，
让 Dart 代码可以在计算时同步运行。

### The async-await syntax

### async-await 语法

The `async` and `await` keywords provide
a declarative way to define asynchronous functions
and use their results.

`async` 和 `await` 关键字是用声明来定义异步函数和获取它们的结果的方式。

Here’s an example of some synchronous code
that blocks while waiting for file I/O:

下面是一段同步代码调用文件 I/O 时阻塞的例子：

<?code-excerpt "lib/sync_number_of_keys.dart"?>
```dart
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

Here’s similar code, but with changes (highlighted) to make it asynchronous:

下面是类似的代码，但是变成了 **异步调用**：

<?code-excerpt "lib/async_number_of_keys.dart" replace="/async|await|readAsString\(\)/[!$&!]/g; /Future<\w+\W/[!$&!]/g;"?>
{% prettify dart tag=pre+code %}
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
{% endprettify %}

The `main()` function uses the `await` keyword in front of `_readFileAsync()`
to let other Dart code (such as event handlers) use the CPU
while native code (file I/O) executes.
Using `await` also has the effect of
converting the `Future<String>` returned by `_readFileAsync()` into a `String`.
As a result, the `contents` variable has the implicit type `String`.

`main()` 函数在调用 `_readFileAsync()` 前使用了 `await` 关键字，
让原生代码（文件 I/O）执行的同时，其他的 Dart 代码（例如事件处理器）能继续执行。
使用 `await` 后，`_readFileAsync()` 调用返回的 `Future<String>` 类型也转换为了 `String`。
从而在将结果 `content` 赋予变量时，隐式转换为 `String` 类型。

{{site.alert.note}}

  The `await` keyword works only in functions that
  have `async` before the function body.

  `await` 关键字仅在函数体前定义了 `async` 的函数中有效。

{{site.alert.end}}

As the following figure shows,
the Dart code pauses while `readAsString()` executes non-Dart code,
in either the Dart virtual machine (VM) or the operating system (OS).
Once `readAsString()` returns a value, Dart code execution resumes.

如下图所示，无论是在 Dart VM 还是在系统中，
Dart 代码都会在 `readAsString()` 执行非 Dart 代码时暂停。
在 `readAsString()` 返回值后，Dart 代码将继续执行。

![Flowchart-like figure showing app code executing from start to exit, waiting for native I/O in between](/guides/language/concurrency/images/basics-await.png)

If you’d like to learn more about using `async`, `await`, and futures,
visit the [asynchronous programming codelab][].

如果你想了解更多关于 `async`、`await` 和 `Future` 的内容，可以访问
[异步编程 codelab][asynchronous programming codelab] 进行学习。

[asynchronous programming codelab]: /codelabs/async-await


## How isolates work

## Isolate 的工作原理

Most modern devices have multi-core CPUs.
To take advantage of all those cores,
developers sometimes use shared-memory threads running concurrently.
However, shared-state concurrency is
[error prone](https://en.wikipedia.org/wiki/Race_condition#In_software) and
can lead to complicated code.

现代的设备通常会使用多核 CPU。开发者为了让程序在设备上有更好的表现，
有时会使用共享内容的线程来并发运行代码。
然而，状态的共享可能会 [产生竞态条件，从而造成错误](https://baike.baidu.com/l/kex6qKvt)，
也可能会增加代码的复杂度。

Instead of threads, all Dart code runs inside of isolates.
Each isolate has its own memory heap,
ensuring that none of the state in an isolate is accessible from
any other isolate.
Because there’s no shared memory, you don’t have to worry about
[mutexes or locks](https://en.wikipedia.org/wiki/Lock_(computer_science)).

Dart 代码并不在多个线程上运行，取而代之的是它们会在 isolate 内运行。
每一个 isolate 会有自己的堆内存，从而确保 isolate 之间互相隔离，无法互相访问状态。
由于这样的实现并不会共享内存，所以你也不需要担心
[互斥锁和其他锁](https://baike.baidu.com/l/My2bXiba)。

Using isolates, your Dart code can perform multiple independent tasks at once,
using additional processor cores if they’re available.
Isolates are like threads or processes,
but each isolate has its own memory and a single thread running an event loop.

在使用 isolate 时，你的 Dart 代码可以在同一时刻进行多个独立的任务，并且使用可用的处理器核心。
Isolate 与线程和进程近似，但是每个 isolate 都拥有独立的内存，以及运行事件循环的独立线程。

### The main isolate

### 主 isolate

You often don’t need to think about isolates at all.
A typical Dart app executes all its code in the app's main isolate,
as shown in the following figure:

在一般场景下，你完全无需关心 isolate。通常一个 Dart 应用会在主 isolate 下执行所有代码，
如下图所示：

![A figure showing a main isolate, which runs `main()`, responds to events, and then exits](/guides/language/concurrency/images/basics-main-isolate.png)

Even single-isolate programs can execute smoothly
by using async-await to wait for asynchronous operations to complete
before continuing to the next line of code.
A well-behaved app starts quickly,
getting to the event loop as soon as possible.
The app then responds to each queued event promptly,
using asynchronous operations as necessary.

就算是只有一个 isolate 的应用，只要通过使用 async-await 来处理异步操作，也完全可以流畅运行。
一个拥有良好性能的应用，会在快速启动后尽快进入事件循环。
这使得应用可以通过异步操作快速响应对应的事件。

### The isolate life cycle

### Isolate 的生命周期

As the following figure shows,
every isolate starts by running some Dart code,
such as the `main()` function.
This Dart code might register some event listeners—to 
respond to user input or file I/O, for example.
When the isolate's initial function returns,
the isolate stays around if it needs to handle events.
After handling the events, the isolate exits.

如下图所示，每个 isolate 都是从运行 Dart 代码开始的，比如 `main()` 函数。
执行的 Dart 代码可能会注册一些事件监听，例如处理用户操作或文件读写。
当 isolate 执行的 Dart 代码结束后，如果它还需要处理已监听的事件，那么它依旧会继续被保持。
处理完所有事件后，isolate 会退出。

![A more general figure showing that any isolate runs some code, optionally responds to events, and then exits](/guides/language/concurrency/images/basics-isolate.png)


### Event handling

### 事件处理

In a client app, the main isolate’s event queue might contain
repaint requests and notifications of tap and other UI events.
For example, the following figure shows a repaint event,
followed by a tap event, followed by two repaint events.
The event loop takes events from the queue in first in, first out order.

在客户端应用中，主 isolate 的事件队列内，可能会包含重绘的请求、点击的通知或者其他界面事件。
例如，下图展示了包含四个事件的事件队列，队列会按照先进先出的模式处理事件。

![A figure showing events being fed, one by one, into the event loop](/guides/language/concurrency/images/event-loop.png)

Event handling happens on the main isolate after `main()` exits.
In the following figure, after `main()` exits,
the main isolate handles the first repaint event.
After that, the main isolate handles the tap event,
followed by a repaint event.

如下图所示，在 `main()` 方法执行完毕后，事件队列中的处理才开始，此时处理的是第一个重绘的事件。
而后主 isolate 会处理点击事件，接着再处理另一个重绘事件。

![A figure showing the main isolate executing event handlers, one by one](/guides/language/concurrency/images/event-handling.png)

If a synchronous operation takes too much processing time,
the app can become unresponsive.
In the following figure, the tap-handling code takes too long,
so subsequent events are handled too late.
The app might appear to freeze,
and any animation it performs might be jerky.

如果某个同步执行的操作花费了很长的处理时间，应用看起来就像是失去了响应。
在下图中，处理点击事件的代码比较耗时，导致紧随其后的事件并没有及时处理。
这时应用可能会产生卡顿，所有的动画都无法流畅播放。

![A figure showing a tap handler with a too-long execution time](/guides/language/concurrency/images/event-jank.png)

In client apps, the result of a too-lengthy synchronous operation is often
[janky (non-smooth) UI animation][jank].
Worse, the UI might become completely unresponsive.

在一个客户端应用中，耗时过长的同步操作，通常会导致 [卡顿的动画][jank]。
而最糟糕的是，应用界面可能完全失去响应。

[jank]: {{site.flutter-docs}}/perf/rendering-performance


### Background workers

### 后台运行对象

If your app’s UI becomes unresponsive due to 
a time-consuming computation—[parsing a large JSON file][json], 
for example—consider offloading that computation to a worker isolate,
often called a _background worker._
A common case, shown in the following figure,
is spawning a simple worker isolate that
performs a computation and then exits.
The worker isolate returns its result in a message when the worker exits.

如果你的应用受到耗时计算的影响而出现卡顿，例如 [解析较大的 JSON 文件][json]，
你可以考虑将耗时计算转移到单独工作的 isolate，通常我们称这样的 isolate 为 **后台运行对象**。
下图展示了一种常用场景，你可以生成一个 isolate，它将执行耗时计算的任务，并在结束后退出。
这个 isolate 工作对象退出时会把结果返回。

[json]: {{site.flutter-docs}}/cookbook/networking/background-parsing

![A figure showing a main isolate and a simple worker isolate](/guides/language/concurrency/images/isolate-bg-worker.png)

Each isolate message can deliver one object,
which includes anything that’s transitively reachable from that object.
Not all object types are sendable, and
the send fails if any transitively reachable object is unsendable.
For example, you can send an object of type `List<Object>` only if
none of the objects in the list is unsendable.
If one of the objects is, say, a `Socket`, then
the send fails because sockets are unsendable.

每个 isolate 都可以通过消息通信传递一个对象，这个对象的所有内容都需要满足可传递的条件。
并非所有的对象都满足传递条件，在无法满足条件时，消息发送会失败。
举个例子，如果你想发送一个 `List<Object>`，你需要确保这个列表中所有元素都是可被传递的。
假设这个列表中有一个 `Socket`，由于它无法被传递，所以你无法发送整个列表。

For information on the kinds of objects that you can send in messages,
see the API reference documentation for the [`send()` method][].

你可以查阅 [`send()` 方法][`send()` method] 的文档来确定哪些类型可以进行传递。

A worker isolate can perform I/O
(reading and writing files, for example), set timers, and more.
It has its own memory and
doesn’t share any state with the main isolate.
The worker isolate can block without affecting other isolates.

Isolate 工作对象可以进行 I/O 操作、设置定时器，以及其他各种行为。
它会持有自己内存空间，与主 isolate 互相隔离。
这个 isolate 在阻塞时也不会对其他 isolate 造成影响。

[`send()` method]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-isolate/SendPort/send.html


## Code examples

## 代码示例

This section discusses some examples
that use the `Isolate` API
to implement isolates.

本节将重点讨论使用 `Isolate` API 实现 isolate 的一些示例。

{{site.alert.flutter-note}}

  If you're using Flutter on a non-web platform,
  then instead of using the `Isolate` API directly,
  consider using the [Flutter `compute()` function][].
  The `compute()` function is a simple way to
  move a single function call to a worker isolate.

  **Flutter 开发提示：**
  如果你在非 Web 平台上使用 Flutter 进行开发，那么与其直接使用 `Isolate` API，
  可以考虑使用 [Flutter 提供的 `compute()` 方法][Flutter `compute()` function]。
  `compute()` 方法能以简单的方式将一个函数的调用封装至 isolate 工作对象内。

{{site.alert.end}}

[Flutter `compute()` function]: {{site.flutter-docs}}/cookbook/networking/background-parsing#4-move-this-work-to-a-separate-isolate


### Implementing a simple worker isolate

### 实现一个简单的 isolate 工作对象

This section shows the implementation for a
main isolate and the simple worker isolate that it spawns.
The worker isolate executes a function and then exits,
sending the main isolate a single message as it exits.
(The [Flutter `compute()` function][] works in a similar way.)

本节将展示一个主 isolate 与它生成的 isolate 工作对象的实现。
Isolate 工作对象会执行一个函数，完成后结束对象，并将函数结果发送至主 isolate。
（[Flutter 提供的 `compute()` 方法][Flutter `compute()` function] 也是以类似的方式工作的。）

This example uses the following isolate-related API:

下面的示例将使用到这些与 isolate 相关的 API：

* [`Isolate.spawn()`][] and [`Isolate.exit()`][]

  [`Isolate.spawn()`][] 和 [`Isolate.exit()`][]

* [`ReceivePort`][] and [`SendPort`][]

  [`ReceivePort`][] 和 [`SendPort`][]

[`Isolate.exit()`]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-isolate/Isolate/exit.html
[`Isolate.spawn()`]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-isolate/Isolate/spawn.html
[`ReceivePort`]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-isolate/ReceivePort-class.html
[`SendPort`]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-isolate/SendPort-class.html

Here’s the code for the main isolate:

主 isolate 的代码如下：

<?code-excerpt "lib/simple_worker_isolate.dart (main)"?>
```dart
void main() async {
  // Read some data.
  final jsonData = await _parseInBackground();

  // Use that data
  print('Number of JSON keys: ${jsonData.length}');
}

// Spawns an isolate and waits for the first message
Future<Map<String, dynamic>> _parseInBackground() async {
  final p = ReceivePort();
  await Isolate.spawn(_readAndParseJson, p.sendPort);
  return await p.first as Map<String, dynamic>;
}
```

The `_parseInBackground()` function contains the code that
_spawns_ (creates and starts) the isolate for the background worker,
and then returns the result:

`_parseInBackground()` 方法包含了 **生成** 后台 isolate 工作对象的代码，并返回结果：

1. Before spawning the isolate, the code creates a `ReceivePort`,
   which enables the worker isolate
   to send messages to the main isolate.

   在生成 isolate 之前，代码创建了一个 `ReceivePort`，
   让 isolate 工作对象可以传递信息至主 isolate。 

2. Next is the call to `Isolate.spawn()`,
   which creates and starts the isolate for the background worker.
   The first argument to `Isolate.spawn()` is the function that
   the worker isolate executes: `_readAndParseJson`.
   The second argument is the `SendPort`
   that the worker isolate can use to send messages to the main isolate.
   The code doesn't _create_ a `SendPort`;
   it uses the `sendPort` property of the `ReceivePort`.

   接下来是调用 `Isolate.spawn()`，生成并启动一个在后台运行的 isolate 工作对象。
   该方法的第一个参数是 isolate 工作对象执行的函数引用：`_readAndParseJson`。
   第二个参数则是 isolate 用来与主 isolate 传递消息的 `SendPort`。
   此处的代码并没有 **创建** 新的 `SendPort`，
   而是直接使用了 `ReceivePort` 的 `sendPort` 属性。

3. Once the isolate is spawned, the main isolate waits for the result.
   Because the `ReceivePort` class implements `Stream`,
   the [`first`][] property is an easy way to get
   the single message that the worker isolate sends.

   Isolate 初始化完成后，主 isolate 即开始等待它的结果。
   由于 `ReceivePort` 实现了 `Stream`，你可以很方便地使用
   [`first`][] 属性获得 isolate 工作对象返回的单个消息。

[`first`]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-async/Stream/first.html

The spawned isolate executes the following code:

初始化后的 isolate 会执行以下代码：

<?code-excerpt "lib/simple_worker_isolate.dart (spawned)"?>
```dart
Future<void> _readAndParseJson(SendPort p) async {
  final fileData = await File(filename).readAsString();
  final jsonData = jsonDecode(fileData);
  Isolate.exit(p, jsonData);
}
```

The relevant statement is the last one, which exits the isolate,
sending `jsonData` to the passed-in `SendPort`.
Message passing using `SendPort.send` normally involves data copying,
and thus can be slow.
However, when you send the data using `Isolate.exit()`,
then the memory that holds the message in the exiting isolate isn’t copied,
but instead is transferred to the receiving isolate.
The sender will nonetheless perform a verification pass to ensure
the objects are allowed to be transferred.

在最后一句代码后，isolate 会退出，
将 `jsonData` 通过传入的 `SendPort` 发送。
在 isolate 之间传递消息时，通常会发生数据拷贝，
然而，当你使用 `Isolate.exit()` 发送数据时，
isolate 中持有的消息并没有发生拷贝，
而是直接转移到了接收的 isolate 中。

{{site.alert.version-note}}

  `Isolate.exit()` was added in 2.15.
  Previous releases support only explicit message passing,
  using `Isolate.send()` as shown in the next section's example.

  `Isolate.exit()` 在 Dart 2.15 中被引入。
  在先前的 Dart 版本中，仅支持通过 `Isolate.send()` 进行显式的消息传递，
  下一个小节的示例中将进行说明。

{{site.alert.end}}

The following figure illustrates the communication between
the main isolate and the worker isolate:

下图说明了主 isolate 和 isolate 工作对象之间的通信流程：

![A figure showing the previous snippets of code running in the main isolate and in the worker isolate](/guides/language/concurrency/images/isolate-api.png)


### Sending multiple messages between isolates

### 在 isolate 之间发送多次消息内容

If you need more communication between isolates,
then you need to use the [`send()` method][] of `SendPort`.
One common pattern, which the following figure shows,
is for the main isolate to send a request message to the worker isolate,
which then sends one or more reply messages.

如果你想在 isolate 之间建立更多的通信，那么你需要使用
`SendPort` 的 [`send()` 方法][`send()` method]。
下图展示了一种常见的场景，主 isolate 会发送请求消息至 isolate 工作对象，
然后它们之间会继续进行多次通信，进行请求和回复。

![A figure showing the main isolate spawning the isolate and then sending a request message, which the worker isolate responds to with a reply message; two request-reply cycles are shown](/guides/language/concurrency/images/isolate-custom-bg-worker.png)

For examples of sending multiple messages,
see the following [isolate samples][]:

下方列举的 [isolate 示例][isolate samples]
包含了发送多次消息的使用方法：

* [send_and_receive.dart][],
  which shows how to send a message from
  the main isolate to the spawned isolate.
  It’s otherwise similar to the preceding example.

  [send_and_receive.dart][] 展示了如何从主 isolate 发送消息至生成的 isolate。
  与前面的示例较为接近。

* [long_running_isolate.dart][],
  which shows how to spawn a long-running isolate that
  receives and sends multiple times.

  [long_running_isolate.dart][] 展示了如何生成一个长期运行、
  且多次发送和接收消息的 isolate。

{% assign samples = "https://github.com/dart-lang/samples/tree/master/isolates" %}

[isolate samples]: {{ samples }}
[send_and_receive.dart]: {{ samples }}/bin/send_and_receive.dart
[long_running_isolate.dart]: {{ samples }}/bin/long_running_isolate.dart


## Performance and isolate groups

## 性能和 isolate 组

When an isolate calls [`Isolate.spawn()`][],
the two isolates have the same executable code
and are in the same _isolate group_.
Isolate groups enable performance optimizations such as sharing code;
a new isolate immediately runs the code owned by the isolate group.
Also, `Isolate.exit()` works only when the isolates
are in the same isolate group.

当一个 isolate 调用了 [`Isolate.spawn()`][]，
两个 isolate 将拥有同样的执行代码，并归入同一个 **isolate 组** 中。
Isolate 组会带来性能优化，例如新的 isolate 会运行由 isolate 组持有的代码，即共享代码调用。
同时，`Isolate.exit()` 仅在对应的 isolate 属于同一组时有效。

In some special cases,
you might need to use [`Isolate.spawnUri()`][],
which sets up the new isolate with a copy of the code
that's at the specified URI.
However, `spawnUri()` is much slower than `spawn()`,
and the new isolate isn't in its spawner's isolate group.
Another performance consequence is that message passing
is slower when isolates are in different groups.

某些场景下，你可能需要使用 [`Isolate.spawnUri()`][]，
使用执行的 URI 生成新的 isolate，并且包含代码的副本。
然而，`spawnUri()` 会比 `spawn()` 慢很多，
并且新生成的 isolate 会位于新的 isolate 组。
另外，当 isolate 在不同的组中，它们之间的消息传递会变得更慢。

[`Isolate.spawnUri()`]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-isolate/Isolate/spawnUri.html

{{site.alert.flutter-note}}

  Flutter doesn't support `Isolate.spawnUri()`.

  Flutter 不支持 `Isolate.spawnUri()`。

{{site.alert.end}}

{% comment %}
TODO:
* After publishing:
  * Figure out how to save an editable version of the source that has the right fonts. (The SVG files don't like the custom fonts; otherwise, I would've used SVGs instead of PNGs.)
* Maybe:
  * Add a new macro & style for flutter notes?
  * Add the following text somewhere in this page (or in the FAQ):
    * Sometimes Dart is called a _single-threaded language._
    * Dart code executes in a predictable sequence that can’t be interrupted by other Dart code.
  * Add a figure up high in the doc? (if so, what?)
{% endcomment %}
