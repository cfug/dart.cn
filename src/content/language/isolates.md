---
# title: Isolates
title: isolate
# description: Information on writing isolates in Dart.
description: 在 Dart 中编写 isolate。
# shortTitle: Isolates
shortTitle: isolate
lastVerified: 2024-01-04
prevpage:
  url: /language/async
  # title: Asynchronous support
  title: 异步支持
nextpage:
  url: /null-safety
  # title: Sound null safety
  title: 健全的空安全
ai-translated: true
---

<?code-excerpt path-base="concurrency"?>

This page discusses some examples that use the `Isolate` API to implement 
isolates.

本页讨论一些使用 `Isolate` API 实现 isolate 的示例。

You should use isolates whenever your application is handling computations that 
are large enough to temporarily block other computations.
The most common example is in [Flutter][] applications, when you 
need to perform large computations that might otherwise cause the 
UI to become unresponsive.

当应用要处理大到会暂时挡住其他计算的运算时，就应该使用 isolate。
最常见的例子是 [Flutter][Flutter] 应用：
你需要做大规模计算，否则界面可能会失去响应。

:::flutter-note
Multiple Isolates not supported by Flutter web
See also: [Concurrency on the web](https://dart.dev/language/concurrency#concurrency-on-the-web)

Flutter Web 不支持多个 isolate。
另请参阅：[Web 上的并发](https://dart.dev/language/concurrency#concurrency-on-the-web)。

:::

There aren't any rules about when you _must_ use isolates, 
but here are some more situations where they can be useful:

并没有规定你 **必须** 在什么时候使用 isolate，
下面再举一些它们能派上用场的情况：

- Parsing and decoding exceptionally large JSON blobs.

  解析并解码特别大的 JSON 数据块。

- Processing and compressing photos, audio and video.

  处理和压缩照片、音频与视频。

- Converting audio and video files.

  转换音频和视频文件。

- Performing complex searching and filtering on large lists or within
  file systems.

  在很长的列表或文件系统里做复杂的搜索与过滤。

- Performing I/O, such as communicating with a database.

  执行 I/O，例如与数据库通信。

- Handling a large volume of network requests.

  处理大量网络请求。


[Flutter]: {{site.flutter-docs}}/perf/isolates

## Implementing a simple worker isolate

## 实现一个简单的工作 isolate

These examples implement a main isolate
that spawns a simple worker isolate.
[`Isolate.run()`][] simplifies the steps behind
setting up and managing worker isolates:

这些示例实现一个主 isolate，由它派生一个简单的工作 isolate。
[`Isolate.run()`][`Isolate.run()`] 简化了建立并管理工作 isolate 的步骤：

1. Spawns (starts and creates) an isolate.

   派生（启动并创建）一个 isolate。

2. Runs a function on the spawned isolate.

   在派生出的 isolate 上运行一个函数。

3. Captures the result.

   取得结果。

4. Returns the result to the main isolate.

   把结果返回给主 isolate。

5. Terminates the isolate once work is complete.

   工作完成后终止该 isolate。

6. Checks, captures, and throws exceptions and errors back to the main isolate.

   检查、捕获异常和错误，并抛回主 isolate。


[`Isolate.run()`]: {{site.dart-api}}/dart-isolate/Isolate/run.html

:::flutter-note
If you're using Flutter, you can use [Flutter's `compute` function][]
instead of `Isolate.run()`.

如果你在使用 Flutter，可以用
[Flutter 的 `compute` 函数][Flutter's `compute` function]
代替 `Isolate.run()`。

:::

[Flutter's `compute` function]: {{site.flutter-api}}/flutter/foundation/compute.html

### Running an existing method in a new isolate

### 在新 isolate 中运行已有方法

1. Call `run()` to spawn a new isolate (a [background worker][]),
   directly in the [main isolate][] while `main()` waits for the result:

   调用 `run()`，在 [主 isolate][main isolate] 里直接派生一个新 isolate
   （也就是一个 [后台工作者][background worker]），
   同时 `main()` 等待结果：


<?code-excerpt "lib/simple_worker_isolate.dart (main)"?>
```dart
const String filename = 'with_keys.json';

void main() async {
  // Read some data.
  final jsonData = await Isolate.run(_readAndParseJson);

  // Use that data.
  print('Number of JSON keys: ${jsonData.length}');
}
```

2. Pass the worker isolate the function you want it to execute
   as its first argument. In this example, it's the existing function `_readAndParseJson()`:

   把要执行的函数作为第一个参数传给工作 isolate。
   在这个示例里，它是已有的函数 `_readAndParseJson()`：


<?code-excerpt "lib/simple_worker_isolate.dart (spawned)"?>
```dart
Future<Map<String, dynamic>> _readAndParseJson() async {
  final fileData = await File(filename).readAsString();
  final jsonData = jsonDecode(fileData) as Map<String, dynamic>;
  return jsonData;
}
```

3. `Isolate.run()` takes the result `_readAndParseJson()` returns
   and sends the value back to the main isolate,
   shutting down the worker isolate.

   `Isolate.run()` 取得 `_readAndParseJson()` 返回的结果，
   把这个值送回主 isolate，并关闭工作 isolate。


4. The worker isolate *transfers* the memory holding the result
   to the main isolate. It *does not copy* the data.
   The worker isolate performs a verification pass to ensure
   the objects are allowed to be transferred.

   工作 isolate 把存放结果的内存 **转移** 给主 isolate。
   它 **不会复制** 这些数据。
   工作 isolate 会做一次校验，确认这些对象允许被转移。


`_readAndParseJson()` is an existing,
asynchronous function that could just as easily
run directly in the main isolate.
Using `Isolate.run()` to run it instead enables concurrency.
The worker isolate completely abstracts the computations
of `_readAndParseJson()`. It can complete without blocking the main isolate.

`_readAndParseJson()` 是一个已有的异步函数，
直接放在主 isolate 里运行也同样容易。
改用 `Isolate.run()` 来运行它，就能获得并发。
工作 isolate 完全封装了 `_readAndParseJson()` 的计算。
它可以完成工作，而不挡住主 isolate。

The result of `Isolate.run()` is always a Future,
because code in the main isolate continues to run.
Whether the computation the worker isolate executes
is synchronous or asynchronous doesn't impact the
main isolate, because it's running concurrently either way.

`Isolate.run()` 的结果始终是一个 Future，
因为主 isolate 里的代码会继续运行。
工作 isolate 执行的计算是同步还是异步，
都不会影响主 isolate，因为无论哪种，它都在并发运行。

For the complete program, check out the [send_and_receive.dart][] sample.

完整程序见 [send_and_receive.dart][send_and_receive.dart] 示例。

[send_and_receive.dart]: {{site.repo.dart.samples}}/blob/main/isolates/bin/send_and_receive.dart
[background worker]: /language/concurrency#background-workers
[main isolate]: /language/concurrency#the-main-isolate

### Sending closures with isolates

### 用 isolate 发送闭包

You can also create a simple worker isolate with `run()` using a
function literal, or closure, directly in the main isolate.

你也可以在主 isolate 里直接用函数字面量（也就是闭包）
调用 `run()`，创建一个简单的工作 isolate。

<?code-excerpt "lib/simple_isolate_closure.dart (worker)"?>
```dart
const String filename = 'with_keys.json';

void main() async {
  // Read some data.
  final jsonData = await Isolate.run(() async {
    final fileData = await File(filename).readAsString();
    final jsonData = jsonDecode(fileData) as Map<String, dynamic>;
    return jsonData;
  });

  // Use that data.
  print('Number of JSON keys: ${jsonData.length}');
}
```

This example accomplishes the same as the previous.
A new isolate spawns, computes something, and sends back the result.

这个示例完成的事情与上一个相同。
新 isolate 被派生出来，做一些计算，再把结果送回。

However, now the isolate sends a [closure][].
Closures are less limited than typical named functions,
both in how they function and how they're written into the code.
In this example, `Isolate.run()` executes what looks like local code, 
concurrently. In that sense, you can imagine `run()` to work like a 
control flow operator for "run in parallel".

不过，现在 isolate 发送的是一个 [闭包][closure]。
闭包比一般的具名函数限制更少，
无论是它的行为方式，还是写进代码的形式。
在这个示例里，`Isolate.run()` 并发执行看起来像局部代码的内容。
从这个意义上，可以把 `run()` 想成一个表示「并行运行」的控制流操作符。

[closure]: /language/functions#anonymous-functions

## Sending multiple messages between isolates with ports

## 用端口在 isolate 之间发送多条消息

Short-lived isolates are convenient to use,
but require performance overhead to spawn new isolates
and to copy objects from one isolate to another.
If your code relies on repeatedly running the same computation 
using `Isolate.run`, you might improve performance by instead creating
long-lived isolates that don’t exit immediately.

短生命周期的 isolate 用起来方便，
但派生新 isolate，以及把对象从一个 isolate 复制到另一个，
都有性能开销。
如果你的代码靠反复用 `Isolate.run` 跑同一段计算，
可以改成创建不会立刻退出的长生命周期 isolate，从而改善性能。

To do this, you can use some of the low-level isolate APIs that 
`Isolate.run` abstracts:

为此，可以使用 `Isolate.run` 所封装的一些底层 isolate API：

* [`Isolate.spawn()`][] and [`Isolate.exit()`][]

  [`Isolate.spawn()`][`Isolate.spawn()`] 与 [`Isolate.exit()`][`Isolate.exit()`]

* [`ReceivePort`][] and [`SendPort`][]

  [`ReceivePort`][`ReceivePort`] 与 [`SendPort`][`SendPort`]

* [`SendPort.send()` method][]

  [`SendPort.send()` 方法][`SendPort.send()` method]



This section goes over the steps required to establish
2-way communication between a newly spawned isolate
and the [main isolate][].
The first example, [Basic ports](#basic-ports-example), introduces the process
at a high-level. The second example, [Robust ports](#robust-ports-example),
gradually adds more practical, real-world functionality to the first.

本节说明在新派生的 isolate 与 [主 isolate][main isolate] 之间
建立双向通信所需的步骤。
第一个示例 [基础端口](#basic-ports-example) 从较高层面介绍这个过程。
第二个示例 [稳健端口](#robust-ports-example)
在第一个示例上逐步补上更实用的真实功能。

[`Isolate.exit()`]: {{site.dart-api}}/dart-isolate/Isolate/exit.html
[`Isolate.spawn()`]: {{site.dart-api}}/dart-isolate/Isolate/spawn.html
[`ReceivePort`]: {{site.dart-api}}/dart-isolate/ReceivePort-class.html
[`SendPort`]: {{site.dart-api}}/dart-isolate/SendPort-class.html
[`SendPort.send()` method]: {{site.dart-api}}/dart-isolate/SendPort/send.html
[main isolate]: /language/concurrency#isolates


### `ReceivePort` and `SendPort`

### `ReceivePort` 与 `SendPort`

Setting up long-lived communication between isolates requires
two classes (in addition to `Isolate`): `ReceivePort` and `SendPort`.
These ports are the only way isolates can communicate with each other.

在 isolate 之间建立长期通信，除了 `Isolate` 之外还需要两个类：
`ReceivePort` 和 `SendPort`。
这些端口是 isolate 彼此通信的唯一途径。

A `ReceivePort` is an object that handles messages that are sent from other
isolates. Those messages are sent via a `SendPort`.

`ReceivePort` 用来处理其他 isolate 发来的消息。
那些消息通过 `SendPort` 发送。

:::note
A `SendPort` object is associated with exactly one `ReceivePort`,
but a single `ReceivePort` can have many `SendPorts`.
When you create a `ReceivePort`, it creates a `SendPort` for itself.
You can create additional `SendPorts` that
can send messages to an existing `ReceivePort`.

一个 `SendPort` 对象恰好关联一个 `ReceivePort`，
但一个 `ReceivePort` 可以有很多个 `SendPort`。
创建 `ReceivePort` 时，它会为自己创建一个 `SendPort`。
你还可以再创建 `SendPort`，
向已有的 `ReceivePort` 发送消息。

:::

Ports behave similarly to [`Stream`][] objects 
(in fact, receive ports implement `Stream`!)
You can think of a `SendPort` and `ReceivePort` like
Stream's `StreamController` and listeners, respectively.
A `SendPort` is like a `StreamController` because you "add" messages to them
with the [`SendPort.send()` method][], and those messages are handled by a listener,
in this case the `ReceivePort`. The `ReceivePort` then handles the messages it
receives by passing them as arguments to a callback that you provide. 

端口的行为与 [`Stream`][`Stream`] 对象很像
（事实上，接收端口实现了 `Stream`）。
可以把 `SendPort` 和 `ReceivePort`
分别看成 Stream 的 `StreamController` 和监听器。
`SendPort` 像 `StreamController`，因为你用
[`SendPort.send()` 方法][`SendPort.send()` method] 向它们「添加」消息，
而这些消息由监听器处理，这里的监听器就是 `ReceivePort`。
`ReceivePort` 再把收到的消息作为参数，传给你提供的回调。

#### Setting up ports

#### 建立端口

A newly spawned isolate only has the information it receives through the
`Isolate.spawn` call. If you need the main isolate to continue to communicate
with a spawned isolate past its initial creation, you must set up a 
communication channel where the spawned isolate can send messages to the 
main isolate. Isolates can only communicate via message passing. 
They can’t “see”  inside each others’ memory, 
which is where the name “isolate” comes from.

新派生的 isolate 只拥有通过 `Isolate.spawn` 调用收到的信息。
如果主 isolate 在创建之后还要继续与派生出的 isolate 通信，
就必须建立一条通道，让派生出的 isolate 能向主 isolate 发消息。
isolate 只能通过传递消息来通信。
它们无法「看见」彼此的内存，isolate 这个名字正是由此而来。

To set up this 2-way communication, first create a [`ReceivePort`][] 
in the main isolate, then pass its [`SendPort`][] as an argument to the 
new isolate when spawning it with `Isolate.spawn`.
The new isolate then creates its own `ReceivePort`, and sends _its_ `SendPort`
back on the `SendPort` it was passed by the main isolate.
The main isolate receives this `SendPort`, and
now both sides have an open channel to send and receive messages.

要建立这种双向通信，先在主 isolate 里创建一个 [`ReceivePort`][`ReceivePort`]，
再用 `Isolate.spawn` 派生新 isolate 时，
把它的 [`SendPort`][`SendPort`] 作为参数传进去。
新 isolate 接着创建自己的 `ReceivePort`，
并把自己的 `SendPort` 经主 isolate 传来的那个 `SendPort` 送回去。
主 isolate 收到这个 `SendPort` 之后，
双方就都有了一条可以收发消息的开放通道。

:::note
The diagrams in this section are high-level and intended to convey the 
_concept_ of using ports for isolates. Actual implementation requires 
a bit more code, which you will find 
[later on this page](#basic-ports-example).

本节的图是高层示意，用来传达用端口配合 isolate 的 **概念**。
实际实现还需要更多代码，
你可以在 [本页后面](#basic-ports-example) 找到。

:::

![A figure showing events being fed, one by one, into the event loop](/assets/img/language/concurrency/ports-setup.png){:.diagram-wrap}

1. Create a `ReceivePort` in the main isolate. The `SendPort` is created
   automatically as a property on the `ReceivePort`.

   在主 isolate 里创建一个 `ReceivePort`。
   `SendPort` 会作为 `ReceivePort` 的属性自动创建。

2. Spawn the worker isolate with `Isolate.spawn()`

   用 `Isolate.spawn()` 派生工作 isolate。

3. Pass a reference to `ReceivePort.sendPort` as the first message to the
   worker isolate.

   把指向 `ReceivePort.sendPort` 的引用作为第一条消息传给工作 isolate。

4. Create another new `ReceivePort` in the worker isolate.

   在工作 isolate 里再创建一个新的 `ReceivePort`。

5. Pass a reference to the worker isolate's `ReceivePort.sendPort` as the
   first message _back_ to the main isolate.

   把指向工作 isolate 的 `ReceivePort.sendPort` 的引用
   作为 **返回** 主 isolate 的第一条消息传回去。


Along with creating the ports and setting up communication, you’ll also need
to tell the ports what to do when they receive messages. This is done using
the `listen` method on each respective `ReceivePort`.

除了创建端口并建好通信，你还要告诉端口收到消息时做什么。
这是通过各自 `ReceivePort` 上的 `listen` 方法完成的。

![A figure showing events being fed, one by one, into the event loop](/assets/img/language/concurrency/ports-passing-messages.png){:.diagram-wrap}

1. Send a message via the main isolate’s reference to the worker isolate's
   `SendPort`.

   通过主 isolate 持有的、指向工作 isolate `SendPort` 的引用发送一条消息。

2. Receive and handle the message via a listener on the worker isolate's
   `ReceivePort`. This is where the computation you want to move off the
   main isolate is executed.

   通过工作 isolate 的 `ReceivePort` 上的监听器接收并处理这条消息。
   你想从主 isolate 挪走的计算，就是在这里执行的。

3. Send a return message via the worker isolate's reference to the main
   isolate's `SendPort`.

   通过工作 isolate 持有的、指向主 isolate `SendPort` 的引用发送返回消息。

4. Receive the message via a listener on the main isolate's `ReceivePort`.

   通过主 isolate 的 `ReceivePort` 上的监听器接收这条消息。


### Basic ports example

### 基础端口示例

This example demonstrates how you can set up a long-lived worker isolate
with 2-way communication between it and the main isolate.
The code uses the example of sending JSON text to a new isolate,
where the JSON will be parsed and decoded,
before being sent back to the main isolate.

这个示例演示如何建立长期存活的工作 isolate，
并让它与主 isolate 双向通信。
代码把 JSON 文本发给一个新 isolate，
在那里解析并解码，然后再送回主 isolate。

:::warning
This example is meant to teach the _bare minimum_ needed to
spawn a new isolate that can send and receive multiple messages over time.

It does not cover important pieces of functionality that are expected
in production software, like error handling, shutting down ports,
and message sequencing.

The [Robust ports example][] in the next section covers this functionality and
discusses some of the issues that can arise without it.

这个示例只讲解派生一个新 isolate、
并让它随时间收发多条消息所需的 **最低限度**。

它不涵盖生产软件里应有的重要功能，
例如错误处理、关闭端口，以及消息顺序。

下一节的 [稳健端口示例][robust ports example]
会讲这些功能，并讨论缺少它们时可能出现的问题。

:::

[robust ports example]: #robust-ports-example

#### Step 1: Define the worker class

#### 第 1 步：定义 Worker 类

First, create a class for your background worker isolate. 
This class contains all the functionality you need to:

首先，为后台工作 isolate 创建一个类。
这个类包含你需要的全部功能：

- Spawn an isolate.

  派生一个 isolate。

- Send messages to that isolate.

  向该 isolate 发送消息。

- Have the isolate decode some JSON.

  让该 isolate 解码一些 JSON。

- Send the decoded JSON back to the main isolate.

  把解码后的 JSON 送回主 isolate。


The class exposes two public methods: one that spawns the worker 
isolate, and one that handles sending messages to that worker isolate.

这个类公开两个方法：一个用来派生工作 isolate，
一个用来向该工作 isolate 发送消息。

The remaining sections in this example will show you
how to fill in the class methods, one-by-one.

本示例剩下的各节会逐个说明如何填写这些类方法。

<?code-excerpt "lib/basic_ports_example/start.dart (worker)"?>
```dart
class Worker {
  Future<void> spawn() async {
    // TODO: Add functionality to spawn a worker isolate.
  }

  void _handleResponsesFromIsolate(dynamic message) {
    // TODO: Handle messages sent back from the worker isolate.
  }

  static void _startRemoteIsolate(SendPort port) {
    // TODO: Define code that should be executed on the worker isolate.
  }

  Future<void> parseJson(String message) async {
    // TODO: Define a public method that can
    // be used to send messages to the worker isolate.
  }
}
```

#### Step 2: Spawn a worker isolate

#### 第 2 步：派生工作 isolate

The `Worker.spawn` method is where you will group the code for creating the 
worker isolate and ensuring it can receive and send messages.

`Worker.spawn` 方法用来集中编写创建工作 isolate、
并确保它能收发消息的代码。

- First, create a `ReceivePort`. This allows the main isolate to receive
  messages sent from the newly spawned worker isolate.

  首先创建一个 `ReceivePort`。
  这样主 isolate 就能接收新派生的工作 isolate 发来的消息。

- Next, add a listener to the receive port to handle messages the worker isolate
  will send back. The callback passed to the
  listener, `_handleResponsesFromIsolate`, will be covered
  in [step 4](#step-4-handle-messages-on-the-main-isolate).

  接着给接收端口加上监听器，处理工作 isolate 将会送回的消息。
  传给监听器的回调 `_handleResponsesFromIsolate`
  会在 [第 4 步](#step-4-handle-messages-on-the-main-isolate) 说明。

- Finally, spawn the worker isolate with `Isolate.spawn`. It expects two
  arguments: a function to be executed on the worker isolate
  (covered in [step 3](#step-3-execute-code-on-the-worker-isolate)),
  and the `sendPort` property of the receive port.

  最后用 `Isolate.spawn` 派生工作 isolate。它需要两个参数：
  一个在工作 isolate 上执行的函数
  （见 [第 3 步](#step-3-execute-code-on-the-worker-isolate)），
  以及接收端口的 `sendPort` 属性。


<?code-excerpt "lib/basic_ports_example/complete.dart (spawn)"?>
```dart
Future<void> spawn() async {
  final receivePort = ReceivePort();
  receivePort.listen(_handleResponsesFromIsolate);
  await Isolate.spawn(_startRemoteIsolate, receivePort.sendPort);
}
```

The `receivePort.sendPort` argument will be passed to the
callback (`_startRemoteIsolate`) as an argument when it’s called on the
worker isolate. This is the first step in ensuring that the worker isolate has a
way to send messages back to the main isolate.

`receivePort.sendPort` 参数会在工作 isolate 上调用回调
（`_startRemoteIsolate`）时作为参数传入。
这是确保工作 isolate 有办法把消息送回主 isolate 的第一步。

#### Step 3: Execute code on the worker isolate

#### 第 3 步：在工作 isolate 上执行代码

In this step, you define the method `_startRemoteIsolate` that is sent to the
worker isolate to be executed when it spawns. This method is like the “main”
method for the worker isolate.

这一步定义方法 `_startRemoteIsolate`。
它会被送到工作 isolate，在派生时执行。
这个方法相当于工作 isolate 的「main」方法。

- First, create another new `ReceivePort`. This port receives
  future messages from the main isolate.

  首先再创建一个新的 `ReceivePort`。
  这个端口接收来自主 isolate 的后续消息。

- Next, send that port’s  `SendPort` back to the main isolate.

  接着把该端口的 `SendPort` 送回主 isolate。

- Finally, add a listener to the new `ReceivePort`. This listener handles
  messages the main isolate sends to the worker isolate.

  最后给新的 `ReceivePort` 加上监听器。
  这个监听器处理主 isolate 发给工作 isolate 的消息。


<?code-excerpt "lib/basic_ports_example/complete.dart (start-remote-isolate)"?>
```dart
static void _startRemoteIsolate(SendPort port) {
  final receivePort = ReceivePort();
  port.send(receivePort.sendPort);

  receivePort.listen((dynamic message) async {
    if (message is String) {
      final transformed = jsonDecode(message);
      port.send(transformed);
    }
  });
}
```

The listener on the worker’s `ReceivePort` decodes the JSON passed from the main
isolate, and then sends the decoded JSON back to the main isolate.

工作 isolate 的 `ReceivePort` 上的监听器会解码主 isolate 传来的 JSON，
再把解码后的 JSON 送回主 isolate。

This listener is the entry point for messages sent from the main isolate to the
worker isolate. **This is the only chance you have to tell the worker isolate what code
to execute in the future.**

这个监听器是主 isolate 发给工作 isolate 的消息的入口。
**这是你告诉工作 isolate 以后要执行什么代码的唯一机会。**

#### Step 4: Handle messages on the main isolate

#### 第 4 步：在主 isolate 上处理消息

Finally, you need to tell the main isolate how to handle messages sent from the
worker isolate back to the main isolate. To do so, you need to fill in
the `_handleResponsesFromIsolate` method. Recall that this method is passed to
the `receivePort.listen` method, as described
in [step 2](#step-2-spawn-a-worker-isolate):

最后，你需要告诉主 isolate 如何处理工作 isolate 送回的消息。
为此要填写 `_handleResponsesFromIsolate` 方法。
回想一下，这个方法被传给 `receivePort.listen`，
如 [第 2 步](#step-2-spawn-a-worker-isolate) 所述：

<?code-excerpt "lib/basic_ports_example/complete.dart (spawn)"?>
```dart
Future<void> spawn() async {
  final receivePort = ReceivePort();
  receivePort.listen(_handleResponsesFromIsolate);
  await Isolate.spawn(_startRemoteIsolate, receivePort.sendPort);
}
```

Also recall that you sent a `SendPort` back to the main isolate
in [step 3](#step-3-execute-code-on-the-worker-isolate). This method handles the
receipt of that `SendPort`, as well as handling future messages (which will be
decoded JSON).

还要回想一下，你在 [第 3 步](#step-3-execute-code-on-the-worker-isolate)
把一个 `SendPort` 送回了主 isolate。
这个方法负责接收那个 `SendPort`，以及之后的消息（解码后的 JSON）。

- First, check if the message is a `SendPort`. If so, assign that port to the
  class's `_sendPort` property so it can be used to send messages later.

  首先检查消息是不是 `SendPort`。
  如果是，就把该端口赋给类的 `_sendPort` 属性，以便稍后用来发消息。

- Next, check if the message is of type `Map<String, dynamic>`, the expected
  type of decoded JSON. If so, handle that message with your
  application-specific logic. In this example, the message is printed. 

  接着检查消息是不是 `Map<String, dynamic>`，
  也就是解码后 JSON 的预期类型。
  如果是，就用你的应用逻辑处理这条消息。
  在这个示例里，消息会被打印出来。


<?code-excerpt "lib/basic_ports_example/complete.dart (handle-responses)"?>
```dart
void _handleResponsesFromIsolate(dynamic message) {
  if (message is SendPort) {
    _sendPort = message;
    _isolateReady.complete();
  } else if (message is Map<String, dynamic>) {
    print(message);
  }
}
```

#### Step 5: Add a completer to ensure your isolate is set-up

#### 第 5 步：用 Completer 确保 isolate 已准备好

To complete the class, define a public method called `parseJson`, which is
responsible for sending messages to the worker isolate. It also needs to ensure
that messages can be sent before the isolate is fully set up.
To handle this, use a [`Completer`][].

为了完成这个类，定义一个名为 `parseJson` 的公开方法，
负责向工作 isolate 发送消息。
它还需要确保在 isolate 完全就绪之前不会发送消息。
这里使用 [`Completer`][`Completer`] 来处理。

- First, add a class-level property called a `Completer` and name
  it `_isolateReady`.

  首先添加一个类级别的 `Completer` 属性，命名为 `_isolateReady`。

- Next, add a call to `complete()` on the completer in
  the `_handleResponsesFromIsolate` method (created in [step 4](#step-4-handle-messages-on-the-main-isolate)) if the message is
  a `SendPort`.

  接着，如果消息是 `SendPort`，就在 `_handleResponsesFromIsolate` 方法里
  （创建于 [第 4 步](#step-4-handle-messages-on-the-main-isolate)）
  对 completer 调用 `complete()`。

- Finally, in the `parseJson` method, add `await _isolateReady.future` before
  adding `_sendPort.send`. This ensures that no message can be sent to the
  worker isolate until it is spawned _and_ has sent its `SendPort` back to the
  main isolate.

  最后，在 `parseJson` 方法里，在 `_sendPort.send` 之前加上
  `await _isolateReady.future`。
  这样可以保证，在工作 isolate 已经派生 **并且**
  把它的 `SendPort` 送回主 isolate 之前，
  不会有消息发给工作 isolate。


<?code-excerpt "lib/basic_ports_example/complete.dart (parse-json)"?>
```dart
Future<void> parseJson(String message) async {
  await _isolateReady.future;
  _sendPort.send(message);
}
```

#### Complete example

#### 完整示例

<details>
  <summary>Expand to see the complete example

  展开查看完整示例</summary>

  <?code-excerpt "lib/basic_ports_example/complete.dart"?>
  ```dart
  import 'dart:async';
  import 'dart:convert';
  import 'dart:isolate';
  
  void main() async {
    final worker = Worker();
    await worker.spawn();
    await worker.parseJson('{"key":"value"}');
  }
  
  class Worker {
    late SendPort _sendPort;
    final Completer<void> _isolateReady = Completer.sync();
  
    Future<void> spawn() async {
      final receivePort = ReceivePort();
      receivePort.listen(_handleResponsesFromIsolate);
      await Isolate.spawn(_startRemoteIsolate, receivePort.sendPort);
    }
  
    void _handleResponsesFromIsolate(dynamic message) {
      if (message is SendPort) {
        _sendPort = message;
        _isolateReady.complete();
      } else if (message is Map<String, dynamic>) {
        print(message);
      }
    }
  
    static void _startRemoteIsolate(SendPort port) {
      final receivePort = ReceivePort();
      port.send(receivePort.sendPort);
  
      receivePort.listen((dynamic message) async {
        if (message is String) {
          final transformed = jsonDecode(message);
          port.send(transformed);
        }
      });
    }
  
    Future<void> parseJson(String message) async {
      await _isolateReady.future;
      _sendPort.send(message);
    }
  
  }
  ```

</details>

### Robust ports example

### 稳健端口示例

The [previous example][] explained the basic building blocks needed to set up a
long-lived isolate with two-way communication. As mentioned, that example lacks
some important features, such as error handling, the ability to close the
ports when they’re no longer in use, and inconsistencies around message ordering
in some situations.

[上一个示例][previous example] 说明了建立双向通信的长生命周期 isolate
所需的基本构件。如前所述，那个示例缺少一些重要特性，
例如错误处理、在不再使用时关闭端口，
以及某些情况下消息顺序不一致。

This example expands on the information in the first example by creating a
long-lived worker isolate that has these additional features and more, and
follows better design patterns. Although this code has similarities to the first
example, it is not an extension of that example.

这个示例在第一个示例的信息上加以扩展，
创建一个具备这些附加特性以及其他特性的长生命周期工作 isolate，
并遵循更好的设计模式。
尽管这段代码与第一个示例有相似之处，它并不是那个示例的延伸。

:::note
This example assumes that you are already familiar with
establishing communication between isolates with `Isolate.spawn` and ports,
which was covered in the [previous example][]. 

本示例假定你已经熟悉如何用 `Isolate.spawn` 和端口
在 isolate 之间建立通信，这部分在 [上一个示例][previous example] 中讲过。

:::

#### Step 1: Define the worker class

#### 第 1 步：定义 Worker 类（稳健示例）

First, create a class for your background worker isolate. This class contains
all the functionality you need to:

首先，为后台工作 isolate 创建一个类。这个类包含你需要的全部功能：

- Spawn an isolate.

  派生一个 isolate。

- Send messages to that isolate.

  向该 isolate 发送消息。

- Have the isolate decode some JSON.

  让该 isolate 解码一些 JSON。

- Send the decoded JSON back to the main isolate.

  把解码后的 JSON 送回主 isolate。


The class exposes three public methods: one that creates the worker
isolate, one that handles sending messages to that worker isolate, and one
that can shut down the ports when they’re no longer in use.

这个类公开三个方法：一个用来创建工作 isolate，
一个用来向该工作 isolate 发送消息，
还有一个可以在端口不再使用时把它们关掉。

<?code-excerpt "lib/robust_ports_example/start.dart (worker)"?>
```dart
class Worker {
  final SendPort _commands;
  final ReceivePort _responses;

  Future<Object?> parseJson(String message) async {
    // TODO: Ensure the port is still open.
    _commands.send(message);
  }

  static Future<Worker> spawn() async {
    // TODO: Add functionality to create a new Worker object with a
    //  connection to a spawned isolate.
    throw UnimplementedError();
  }

  Worker._(this._responses, this._commands) {
    // TODO: Initialize main isolate receive port listener.
  }

  void _handleResponsesFromIsolate(dynamic message) {
    // TODO: Handle messages sent back from the worker isolate.
  }

  static void _handleCommandsToIsolate(ReceivePort rp, SendPort sp) async {
    // TODO: Handle messages sent back from the worker isolate.
  }

  static void _startRemoteIsolate(SendPort sp) {
    // TODO: Initialize worker isolate's ports.
  }
}
```

:::note
In this example, `SendPort` and `ReceivePort` instances
follow a best practice naming convention, in which they are named in relation to
the main isolate. The messages sent through the `SendPort` from the main isolate
to the worker isolate are called _commands_, and the messages sent back to the
main isolate are called _responses_.

在这个示例里，`SendPort` 和 `ReceivePort` 实例遵循一套推荐命名约定，
名称都是相对主 isolate 而言的。
经 `SendPort` 从主 isolate 发往工作 isolate 的消息称为 **commands**，
送回主 isolate 的消息称为 **responses**。

:::

#### Step 2: Create a `RawReceivePort` in the `Worker.spawn` method

#### 第 2 步：在 `Worker.spawn` 方法里创建 `RawReceivePort`

Before spawning an isolate, you need to create a [`RawReceivePort`][], which is
a lower-level `ReceivePort`. Using `RawReceivePort` is a preferred pattern
because it allows you to separate your isolate startup logic from logic that
handles message passing on the isolate.

派生 isolate 之前，需要创建一个 [`RawReceivePort`][`RawReceivePort`]，
它是更底层的 `ReceivePort`。优先使用 `RawReceivePort`，
因为这样可以把 isolate 的启动逻辑
和在 isolate 上传递消息的逻辑分开。

In the `Worker.spawn` method:

在 `Worker.spawn` 方法里：

- First, create the `RawReceivePort`. This `ReceivePort` is only responsible for
  receiving the initial message from the worker isolate, which will be
  a `SendPort`.

  首先创建 `RawReceivePort`。
  这个 `ReceivePort` 只负责接收工作 isolate 的初始消息，
  该消息会是一个 `SendPort`。

- Next, create a `Completer` that will indicate when the isolate is ready to
  receive messages. When this completes, it will return a record with
  a `ReceivePort` and a `SendPort`.

  接着创建一个 `Completer`，用来表示 isolate 何时准备好接收消息。
  它完成时会返回一条包含 `ReceivePort` 和 `SendPort` 的记录。

- Next, define the `RawReceivePort.handler` property. This property is
  a `Function?` that behaves like `ReceivePort.listener`. The function is called
  when a message is received by this port.

  然后定义 `RawReceivePort.handler` 属性。
  这个属性是 `Function?`，行为类似 `ReceivePort.listener`。
  此端口收到消息时会调用该函数。

- Within the handler function, call `connection.complete()`. This method expects
  a [record][] with a `ReceivePort` and a `SendPort` as an argument.
  The `SendPort` is the initial message sent from the worker isolate, which will
  be assigned in the next step to the class level `SendPort` named `_commands`.

  在处理函数里调用 `connection.complete()`。
  这个方法需要一条包含 `ReceivePort` 和 `SendPort` 的 [记录][record] 作为参数。
  这里的 `SendPort` 是工作 isolate 发来的初始消息，
  下一步会把它赋给类级别、名为 `_commands` 的 `SendPort`。

- Then, create a new `ReceivePort` with
  the `ReceivePort.fromRawReceivePort` constructor, and pass in
  the `initPort`.

  然后用 `ReceivePort.fromRawReceivePort` 构造函数创建一个新的 `ReceivePort`，
  并传入 `initPort`。


<?code-excerpt "lib/robust_ports_example/spawn_1.dart (worker-spawn)" plaster="none"?>
```dart
class Worker {
  final SendPort _commands;
  final ReceivePort _responses;

  static Future<Worker> spawn() async {
    // Create a receive port and add its initial message handler.
    final initPort = RawReceivePort();
    final connection = Completer<(ReceivePort, SendPort)>.sync();
    initPort.handler = (initialMessage) {
      final commandPort = initialMessage as SendPort;
      connection.complete((
        ReceivePort.fromRawReceivePort(initPort),
        commandPort,
      ));
    };
  }
}
```

By creating a `RawReceivePort` first, and then a `ReceivePort`, you’ll be able
to add a new callback to `ReceivePort.listen` later on. Conversely, if you were
to create a `ReceivePort` straight away, you’d only be able to add
one `listener`, because `ReceivePort` implements [`Stream`][], rather
than [`BroadcastStream`][].

先创建 `RawReceivePort`，再创建 `ReceivePort`，
你稍后就能给 `ReceivePort.listen` 再加一个回调。
反过来，如果一开始就直接创建 `ReceivePort`，
就只能添加一个 `listener`，
因为 `ReceivePort` 实现的是 [`Stream`][`Stream`]，
而不是 [`BroadcastStream`][`BroadcastStream`]。

Effectively, this allows you to separate your isolate start-up logic from the
logic that handles receiving messages after setting up communication is
complete. This benefit will become more obvious as the logic in the other
methods grows.

这样一来，你就可以把 isolate 的启动逻辑，
和通信建立完成之后接收消息的逻辑分开。
随着其他方法里的逻辑变多，这个好处会更明显。

#### Step 3: Spawn a worker isolate with `Isolate.spawn`

#### 第 3 步：用 `Isolate.spawn` 派生工作 isolate

This step continues to fill in the `Worker.spawn` method. You’ll add the code
needed to spawn an isolate, and return an instance of `Worker` from this class.
In this example, the call to `Isolate.spawn` is wrapped in
a [`try`/`catch` block][], which ensures that, if the isolate fails to start up,
the `initPort` will be closed, and the `Worker` object won’t be created.

这一步继续填写 `Worker.spawn` 方法。
你会加上派生 isolate 所需的代码，并从这个类返回一个 `Worker` 实例。
在这个示例里，对 `Isolate.spawn` 的调用包在
[`try`/`catch` 代码块][`try`/`catch` block] 中。
这样，如果 isolate 启动失败，就会关闭 `initPort`，并且不会创建 `Worker` 对象。

- First, attempt to spawn a worker isolate in a `try`/`catch` block. If spawning
  a worker isolate fails, close the receive port that was created in the
  previous step. The method passed to `Isolate.spawn` will be covered in a later
  step.

  首先在 `try`/`catch` 代码块里尝试派生工作 isolate。
  如果派生失败，就关闭上一步创建的接收端口。
  传给 `Isolate.spawn` 的方法会在后面的步骤里说明。

- Next, await the `connection.future`, and destructure the send port and
  receive port from the record it returns.

  接着等待 `connection.future`，
  并从它返回的记录里解构出发送端口和接收端口。

- Finally, return an instance of `Worker` by calling its private constructor,
  and passing in the ports from that completer.

  最后调用私有构造函数返回一个 `Worker` 实例，
  并传入该 completer 提供的端口。


<?code-excerpt "lib/robust_ports_example/spawn_2.dart (worker-spawn)" plaster="none"?>
```dart
class Worker {
  final SendPort _commands;
  final ReceivePort _responses;

  static Future<Worker> spawn() async {
    // Create a receive port and add its initial message handler.
    final initPort = RawReceivePort();
    final connection = Completer<(ReceivePort, SendPort)>.sync();
    initPort.handler = (initialMessage) {
      final commandPort = initialMessage as SendPort;
      connection.complete((
        ReceivePort.fromRawReceivePort(initPort),
        commandPort,
      ));
    };
    // Spawn the isolate.
    try {
      await Isolate.spawn(_startRemoteIsolate, (initPort.sendPort));
    } on Object {
      initPort.close();
      rethrow;
    }

    final (ReceivePort receivePort, SendPort sendPort) =
        await connection.future;

    return Worker._(receivePort, sendPort);
  }
}
```

Note that in this example (compared to the [previous example][]), `Worker.spawn`
acts as an asynchronous static constructor for this class and is the only way to
create an instance of `Worker`. This simplifies the API, making the code that
creates an instance of `Worker` cleaner.

请注意，在这个示例里（相比 [上一个示例][previous example]），
`Worker.spawn` 充当这个类的异步静态构造函数，
并且是创建 `Worker` 实例的唯一方式。
这简化了 API，让创建 `Worker` 实例的代码更干净。

#### Step 4: Complete the isolate setup process

In this step, you will complete the basic isolate setup process. This correlates
#### 第 4 步：完成 isolate 的建立过程

almost entirely to the [previous example][], and there are no new concepts.
There is a slight change in that the code is broken into more methods, which
is a design practice that
sets you up for adding more functionality through the remainder of this example.
For an in-depth walkthrough of the basic process of setting up an isolate, see
the [basic ports example](#basic-ports-example).

这一步将完成基本的 isolate 建立过程。
它几乎完全对应 [上一个示例][previous example]，没有新概念。
稍有不同的是，代码被拆成了更多方法。
这种设计是为了在本示例剩下的部分里方便继续加功能。
若要深入了解建立 isolate 的基本过程，
见 [基础端口示例](#basic-ports-example)。

First, create the private constructor that is returned from the `Worker.spawn`
method. In the constructor body, add a listener to the receive port used by the
main isolate, and pass an as-yet undefined method to that listener
called `_handleResponsesFromIsolate`. 

首先创建从 `Worker.spawn` 方法返回的私有构造函数。
在构造函数体里，给主 isolate 使用的接收端口加上监听器，
并把一个尚未定义的方法 `_handleResponsesFromIsolate` 传给该监听器。

<?code-excerpt "lib/robust_ports_example/step_4.dart (constructor)" plaster="none"?>
```dart
class Worker {
  final SendPort _commands;
  final ReceivePort _responses;

  Worker._(this._responses, this._commands) {
    _responses.listen(_handleResponsesFromIsolate);
  }
}
```

Next, add the code to `_startRemoteIsolate` that is responsible for initializing
the ports on the worker
isolate. [Recall](#step-3-spawn-a-worker-isolate-with-isolate-spawn) that this
method was passed to `Isolate.spawn` in the `Worker.spawn` method, and it will
be passed the main isolate’s `SendPort` as an argument.

接着添加 `_startRemoteIsolate` 中负责在工作 isolate 上初始化端口的代码。
[回想一下](#step-3-spawn-a-worker-isolate-with-isolate-spawn)，
这个方法在 `Worker.spawn` 里被传给了 `Isolate.spawn`，
调用时会收到主 isolate 的 `SendPort` 作为参数。

- Create a new `ReceivePort`.

  创建一个新的 `ReceivePort`。

- Send that port’s `SendPort` back to the main isolate.

  把该端口的 `SendPort` 送回主 isolate。

- Call a new method called `_handleCommandsToIsolate`, and pass both the
  new `ReceivePort` and `SendPort` from the main isolate as arguments.

  调用新方法 `_handleCommandsToIsolate`，
  并把新的 `ReceivePort` 以及来自主 isolate 的 `SendPort` 都作为参数传入。


<?code-excerpt "lib/robust_ports_example/step_4.dart (start-isolate)"?>
```dart
static void _startRemoteIsolate(SendPort sendPort) {
  final receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);
  _handleCommandsToIsolate(receivePort, sendPort);
}
```

Next, add the `_handleCommandsToIsolate` method, which is responsible for
receiving messages from the main isolate, decoding json on the worker isolate,
and sending the decoded json back as a response.

接着添加 `_handleCommandsToIsolate` 方法。
它负责接收来自主 isolate 的消息，在工作 isolate 上解码 JSON，
并把解码后的 JSON 作为响应送回。

- First, declare a listener on the worker isolate’s `ReceivePort`.

  首先在工作 isolate 的 `ReceivePort` 上声明一个监听器。

- Within the callback added to the listener, attempt to decode the JSON passed
  from the main isolate within a [`try`/`catch` block][]. If decoding is
  successful, send the decoded JSON back to the main isolate.

  在加到监听器上的回调里，于 [`try`/`catch` 代码块][`try`/`catch` block] 中
  尝试解码主 isolate 传来的 JSON。
  如果解码成功，就把解码后的 JSON 送回主 isolate。

- If there is an error, send back a [`RemoteError`][].

  如果出错，就送回一个 [`RemoteError`][`RemoteError`]。


<?code-excerpt "lib/robust_ports_example/step_4.dart (handle-commands)"?>
```dart
static void _handleCommandsToIsolate(
  ReceivePort receivePort,
  SendPort sendPort,
) {
  receivePort.listen((message) {
    try {
      final jsonData = jsonDecode(message as String);
      sendPort.send(jsonData);
    } catch (e) {
      sendPort.send(RemoteError(e.toString(), ''));
    }
  });
}
```

Next, add the code for the `_handleResponsesFromIsolate` method.

接着添加 `_handleResponsesFromIsolate` 方法的代码。

- First, check if the message is a `RemoteError`, in which case you
  should `throw` that error.

  首先检查消息是不是 `RemoteError`。如果是，就应该 `throw` 这个错误。

- Otherwise, print the message. In future steps, you will update this code to
  return messages rather than print them.

  否则打印这条消息。后面的步骤里，你会把这段代码改成返回消息，而不是打印它们。


<?code-excerpt "lib/robust_ports_example/step_4.dart (handle-response)"?>
```dart
void _handleResponsesFromIsolate(dynamic message) {
  if (message is RemoteError) {
    throw message;
  } else {
    print(message);
  }
}
```

Finally, add the `parseJson` method, which is a public method that allows
outside code to send JSON to the worker isolate to be decoded.

最后添加 `parseJson` 方法。这是一个公开方法，
让外部代码把 JSON 发给工作 isolate 去解码。

<?code-excerpt "lib/robust_ports_example/step_4.dart (parse-json)"?>
```dart
Future<Object?> parseJson(String message) async {
  _commands.send(message);
}
```

You will update this method in the next step.

下一步会更新这个方法。

#### Step 5: Handle multiple messages at the same time

Currently, if you rapidly send messages to the worker isolate, the isolate will
#### 第 5 步：同时处理多条消息

send the decoded json response in _the order that they complete_, rather than
the order that they’re sent. You have no way to determine which response
corresponds to which message.

目前，如果你快速向工作 isolate 发送消息，
isolate 会按 **它们完成的顺序** 送回解码后的 JSON 响应，
而不是按发送顺序。你无法判断哪条响应对应哪条消息。

In this step, you’ll fix this problem by giving each message an id, and
using `Completer` objects to ensure that when outside code calls `parseJson` the
response that is returned to that caller is the correct response.

这一步通过给每条消息一个 id，并用 `Completer` 对象来解决这个问题，
确保外部代码调用 `parseJson` 时，返回给该调用方的是正确的响应。

First, add two class-level properties to `Worker`:

首先给 `Worker` 添加两个类级别属性：

- `Map<int, Completer<Object?>> _activeRequests`

  进行中的请求表 `Map<int, Completer<Object?>> _activeRequests`

- `int _idCounter`

  整数计数器 `int _idCounter`。


<?code-excerpt "lib/robust_ports_example/step_5_add_completers.dart (vars)"?>
```dart
class Worker {
  final SendPort _commands;
  final ReceivePort _responses;
  final Map<int, Completer<Object?>> _activeRequests = {};
  int _idCounter = 0;
  // ···
}
```

The `_activeRequests` map associates a message sent to the worker isolate
with a `Completer`. The keys used in `_activeRequests` are taken
from `_idCounter`, which will be increased as more messages are sent.

`_activeRequests` 映射把发给工作 isolate 的消息与一个 `Completer` 关联起来。
`_activeRequests` 使用的键来自 `_idCounter`，
发送的消息越多，这个计数就越大。

Next, update the `parseJson` method to create completers before it sends
messages to the worker isolate.

接着更新 `parseJson` 方法，让它在向工作 isolate 发送消息之前创建 completer。

- First create a `Completer`.

  首先创建一个 `Completer`。

- Next, increment `_idCounter`, so that each `Completer` is associated with a
  unique number.

  接着递增 `_idCounter`，使每个 `Completer` 都对应一个唯一数字。

- Add an entry to the `_activeRequests` map in which the key is the current
  number of `_idCounter`, and the completer is the value.

  向 `_activeRequests` 映射添加一条记录，
  键是当前的 `_idCounter`，值是这个 completer。

- Send the message to the worker isolate, along with the id. Because you can
  only send one value through the `SendPort`, wrap the id and message in a
  [record][].

  把消息连同 id 发给工作 isolate。
  因为通过 `SendPort` 只能发送一个值，
  所以用一条 [记录][record] 把 id 和消息包在一起。

- Finally, return the completer’s future, which will eventually contain the
  response from the worker isolate.

  最后返回 completer 的 future，它最终会包含工作 isolate 的响应。


<?code-excerpt "lib/robust_ports_example/step_5_add_completers.dart (parse-json)"?>
```dart
Future<Object?> parseJson(String message) async {
  final completer = Completer<Object?>.sync();
  final id = _idCounter++;
  _activeRequests[id] = completer;
  _commands.send((id, message));
  return await completer.future;
}
```

You also need to update `_handleResponsesFromIsolate`
and `_handleCommandsToIsolate` to handle this system.

你还需要更新 `_handleResponsesFromIsolate` 和 `_handleCommandsToIsolate`，
以配合这套机制。

In `_handleCommandsToIsolate`, you need to account for the `message` being a
record with two values, rather than just the json text. Do so by destructuring
the values from `message`.

在 `_handleCommandsToIsolate` 里，需要考虑到 `message` 是一条含有两个值的记录，
而不再只是 JSON 文本。从 `message` 里解构出这些值即可。

Then, after decoding the json, update the call to `sendPort.send` to pass both
the id and the decoded json back to the main isolate, again using a record.

然后，在解码 JSON 之后，更新对 `sendPort.send` 的调用，
再次用记录把 id 和解码后的 JSON 一起传回主 isolate。

<?code-excerpt "lib/robust_ports_example/step_5_add_completers.dart (handle-commands)"?>
```dart
static void _handleCommandsToIsolate(
  ReceivePort receivePort,
  SendPort sendPort,
) {
  receivePort.listen((message) {
    final (int id, String jsonText) = message as (int, String); // New
    try {
      final jsonData = jsonDecode(jsonText);
      sendPort.send((id, jsonData)); // Updated
    } catch (e) {
      sendPort.send((id, RemoteError(e.toString(), '')));
    }
  });
}
```

Finally, update the `_handleResponsesFromIsolate`.

最后更新 `_handleResponsesFromIsolate`。

- First, destructure the id and the response from the message argument again.

  首先再次从消息参数里解构出 id 和响应。

- Then, remove the completer that corresponds to this request from
  the `_activeRequests` map.

  然后从 `_activeRequests` 映射里移除对应该请求的 completer。

- Lastly, rather than throwing an error or printing the decoded json, complete
  the completer, passing in the response. When this completes, the response will
  be returned to the code that called `parseJson` on the main isolate.

  最后，不再抛出错误或打印解码后的 JSON，而是完成这个 completer，并传入响应。
  完成后，响应会返回给在主 isolate 上调用 `parseJson` 的代码。


<?code-excerpt "lib/robust_ports_example/step_5_add_completers.dart (handle-response)"?>
```dart
void _handleResponsesFromIsolate(dynamic message) {
  final (int id, Object? response) = message as (int, Object?); // New
  final completer = _activeRequests.remove(id)!; // New

  if (response is RemoteError) {
    completer.completeError(response); // Updated
  } else {
    completer.complete(response); // Updated
  }
}
```

#### Step 6: Add functionality to close the ports

#### 第 6 步：添加关闭端口的功能

When the isolate is no longer being used by your code, you should close the
ports on the main isolate and the worker isolate.

当代码不再使用这个 isolate 时，应该关闭主 isolate 和工作 isolate 上的端口。

- First, add a class-level boolean that tracks if the ports are closed.

  首先添加一个类级别的布尔值，用来跟踪端口是否已关闭。

- Then, add the `Worker.close` method. Within this method:

  然后添加 `Worker.close` 方法。在这个方法里：

  - Update `_closed` to be true.

    把 `_closed` 更新为 true。

  - Send a final message to the worker isolate.
    This message is a `String` that reads “shutdown”,
    but it could be any object you’d like.
    You will use it in the next code snippet.

    向工作 isolate 发送最后一条消息。
    这条消息是内容为「shutdown」的 `String`，
    但也可以是你想用的任何对象。
    下一段代码会用到它。

- Finally, check if `_activeRequests` is empty. If it is, close down the main
  isolate’s `ReceivePort` named `_responses`.

  最后检查 `_activeRequests` 是否为空。
  如果为空，就关闭主 isolate 上名为 `_responses` 的 `ReceivePort`。


<?code-excerpt "lib/robust_ports_example/step_6_close_ports.dart (close)"?>
```dart
class Worker {
  bool _closed = false;
  // ···
  void close() {
    if (!_closed) {
      _closed = true;
      _commands.send('shutdown');
      if (_activeRequests.isEmpty) _responses.close();
      print('--- port closed --- ');
    }
  }
}
```

- Next, you need to handle the “shutdown” message in the worker isolate. Add the
  following code to the `_handleCommandsToIsolate` method. This code will check if
  the message is a `String` that reads “shutdown”. If it is, it will close the
  worker isolate’s `ReceivePort`, and return.

  接下来需要在工作 isolate 里处理「shutdown」消息。
  把下面的代码加到 `_handleCommandsToIsolate` 方法中。
  这段代码会检查消息是不是内容为「shutdown」的 `String`。
  如果是，就关闭工作 isolate 的 `ReceivePort` 并返回。


<?code-excerpt "lib/robust_ports_example/step_6_close_ports.dart (handle-commands)"?>
```dart
static void _handleCommandsToIsolate(
  ReceivePort receivePort,
  SendPort sendPort,
) {
  receivePort.listen((message) {
    // New if-block.
    if (message == 'shutdown') {
      receivePort.close();
      return;
    }
    final (int id, String jsonText) = message as (int, String);
    try {
      final jsonData = jsonDecode(jsonText);
      sendPort.send((id, jsonData));
    } catch (e) {
      sendPort.send((id, RemoteError(e.toString(), '')));
    }
  });
}
```

- Finally, you should add code to check if the ports are closed before trying to
  send messages. Add one line in the `Worker.parseJson` method.

  最后，应该在尝试发送消息之前加上检查端口是否已关闭的代码。
  在 `Worker.parseJson` 方法里加一行。


<?code-excerpt "lib/robust_ports_example/step_6_close_ports.dart (parse-json)"?>
```dart
Future<Object?> parseJson(String message) async {
  if (_closed) throw StateError('Closed'); // New
  final completer = Completer<Object?>.sync();
  final id = _idCounter++;
  _activeRequests[id] = completer;
  _commands.send((id, message));
  return await completer.future;
}
```

#### Complete example

#### 完整示例（稳健端口）

<details>
  <summary>Expand here to see the full example

  展开此处查看完整示例</summary>

<?code-excerpt "lib/robust_ports_example/complete.dart"?>
```dart
import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

void main() async {
  final worker = await Worker.spawn();
  print(await worker.parseJson('{"key":"value"}'));
  print(await worker.parseJson('"banana"'));
  print(await worker.parseJson('[true, false, null, 1, "string"]'));
  print(
    await Future.wait([worker.parseJson('"yes"'), worker.parseJson('"no"')]),
  );
  worker.close();
}

class Worker {
  final SendPort _commands;
  final ReceivePort _responses;
  final Map<int, Completer<Object?>> _activeRequests = {};
  int _idCounter = 0;
  bool _closed = false;

  Future<Object?> parseJson(String message) async {
    if (_closed) throw StateError('Closed');
    final completer = Completer<Object?>.sync();
    final id = _idCounter++;
    _activeRequests[id] = completer;
    _commands.send((id, message));
    return await completer.future;
  }

  static Future<Worker> spawn() async {
    // Create a receive port and add its initial message handler.
    final initPort = RawReceivePort();
    final connection = Completer<(ReceivePort, SendPort)>.sync();
    initPort.handler = (initialMessage) {
      final commandPort = initialMessage as SendPort;
      connection.complete((
        ReceivePort.fromRawReceivePort(initPort),
        commandPort,
      ));
    };

    // Spawn the isolate.
    try {
      await Isolate.spawn(_startRemoteIsolate, (initPort.sendPort));
    } on Object {
      initPort.close();
      rethrow;
    }

    final (ReceivePort receivePort, SendPort sendPort) =
        await connection.future;

    return Worker._(receivePort, sendPort);
  }

  Worker._(this._responses, this._commands) {
    _responses.listen(_handleResponsesFromIsolate);
  }

  void _handleResponsesFromIsolate(dynamic message) {
    final (int id, Object? response) = message as (int, Object?);
    final completer = _activeRequests.remove(id)!;

    if (response is RemoteError) {
      completer.completeError(response);
    } else {
      completer.complete(response);
    }

    if (_closed && _activeRequests.isEmpty) _responses.close();
  }

  static void _handleCommandsToIsolate(
    ReceivePort receivePort,
    SendPort sendPort,
  ) {
    receivePort.listen((message) {
      if (message == 'shutdown') {
        receivePort.close();
        return;
      }
      final (int id, String jsonText) = message as (int, String);
      try {
        final jsonData = jsonDecode(jsonText);
        sendPort.send((id, jsonData));
      } catch (e) {
        sendPort.send((id, RemoteError(e.toString(), '')));
      }
    });
  }

  static void _startRemoteIsolate(SendPort sendPort) {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);
    _handleCommandsToIsolate(receivePort, sendPort);
  }

  void close() {
    if (!_closed) {
      _closed = true;
      _commands.send('shutdown');
      if (_activeRequests.isEmpty) _responses.close();
      print('--- port closed --- ');
    }
  }
}
```

</details>

[`Isolate.exit()`]: {{site.dart-api}}/dart-isolate/Isolate/exit.html
[`Isolate.spawn()`]: {{site.dart-api}}/dart-isolate/Isolate/spawn.html
[`ReceivePort`]: {{site.dart-api}}/dart-isolate/ReceivePort-class.html
[`SendPort`]: {{site.dart-api}}/dart-isolate/SendPort-class.html
[`SendPort.send()` method]: {{site.dart-api}}/dart-isolate/SendPort/send.html
[main isolate]: /language/concurrency#isolates
[`Stream`]: {{site.dart-api}}/dart-async/Stream-class.html
[`BroadcastStream`]: {{site.dart-api}}/dart-async/BroadcastStream-class.html
[`Completer`]: {{site.dart-api}}/dart-async/Completer-class.html
[`RawReceivePort`]: {{site.dart-api}}/dart-isolate/RawReceivePort-class.html
[record]: /language/records
[previous example]: #basic-ports-example
[`try`/`catch` block]: /language/error-handling#catch
[`RemoteError`]: {{site.dart-api}}/dart-isolate/RemoteError-class.html
