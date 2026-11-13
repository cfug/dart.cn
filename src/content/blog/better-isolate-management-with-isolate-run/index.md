---
# title: "Better isolate management with Isolate.run()"
title: "用 Isolate.run() 更好地管理隔离"
# description: "Dart 2.19 introduces a new function that makes implementing concurrency as simple as a single line of code."
description: "Dart 2.19 引入了一个新函数，让实现并发像一行代码那样简单。"
ai-translated: true
publishDate: 2023-01-24
author: mbelanger
image: images/0Bt-V4nlGjNKquFhK.webp
category: deep-dive
layout: blog
---


<DashImage src="images/0Bt-V4nlGjNKquFhK.webp" alt="A benchmark test showcasing the speed of the new Isolate.run() function." caption="A benchmark test showcasing the speed of the new Isolate.run() function" />


All Dart code runs in isolates. Whether you implement multiple isolates to enable [concurrency](https://dart.dev/guides/language/concurrency) in your Dart programs is up to you. *How* you can implement multiple isolates is up to us on the Dart team, and in Dart 2.19, we’ve made a huge upgrade to the process that we’re excited to share. Meet `Isolate.run()`!

所有 Dart 代码都运行在隔离（isolate）中。
是否使用多个隔离来让你的 Dart 程序实现
[并发（concurrency）](https://dart.dev/guides/language/concurrency)，由你决定。
而*如何*实现多个隔离，则由我们 Dart 团队负责。
在 Dart 2.19 中，我们对这个过程做了一次重大升级，
迫不及待地想与你分享。来认识一下 `Isolate.run()`！

`run()` takes all of the complexity of setting up and managing isolates and completely abstracts it into a single function call. It’s been possible to use isolates with a handful of primitives for a while now. But, even with all [the recent performance improvements](/blog/announcing-dart-2-15#fast-concurrency-with-worker-isolates) for isolates, the process was at best, tedious, and at worst, error-prone.

`run()` 把设置和管理隔离的所有复杂性
完全抽象成了一次函数调用。
一段时间以来，使用少量原语（primitive）就可以使用隔离。
但是，即便有了隔离
[近期的所有性能改进](/blog/announcing-dart-2-15#fast-concurrency-with-worker-isolates)，
这个过程往好了说是繁琐，往坏了说则是容易出错。

To appreciate how much of an improvement `run()` is, this article breaks down the previous method of building out the functionality piece-by-piece from low-level primitives. Then, we’ll contrast that to using `Isolate.run()`, and show you how it works on the inside. Even if you’ve never used isolates before, we’re sure that `run()` will get you excited to try them out!

为了体会 `run()` 带来了多大的改进，
本文先拆解以前的做法：用底层原语一点一点搭建出所需功能。
然后，我们会把它与使用 `Isolate.run()` 的方式做对比，
并向你展示它的内部工作原理。
即使你以前从未用过隔离，
我们也相信 `run()` 会让你兴奋地想要试一试！

### Isolates

### 隔离（Isolate）

Isolates are a fairly straightforward concept. An [isolate](/blog/dart-asynchronous-programming-isolates-and-event-loops) is essentially a single thread of execution in Dart. They let you execute parts of your code in parallel. You can start new parallel executions (as many as you want) and tell them what to do, right from `main` (the main thread, or [main isolate](https://dart.dev/guides/language/concurrency#the-main-isolate)). Isolates don’t share memory; instead, they pass messages back and forth to communicate. So, you don’t have to worry about typical multithreading problems, like race conditions, or mutexes and locks.

隔离是一个相当直观的概念。
[隔离](/blog/dart-asynchronous-programming-isolates-and-event-loops)
本质上是 Dart 中的单个执行线程。
它们让你并行执行代码的各个部分。
你可以直接在 `main`（主线程，
即[主隔离](https://dart.dev/guides/language/concurrency#the-main-isolate)）中
启动新的并行执行（想启动多少就多少）并告诉它们要做什么。
隔离之间不共享内存，而是通过来回传递消息进行通信。
因此，你不必担心典型的多线程问题，
比如竞态条件（race condition）、互斥量（mutex）和锁。

<DashImage src="images/0eCogwJXZtpbg5Hbq.webp" alt="A diagram illustrating how isolates communicate through message passing without sharing memory." />


Sounds great! But how do you use them? Before `Isolate.run()`, that’s where things became tricky.

听起来很棒！但怎么使用它们呢？
在 `Isolate.run()` 出现之前，事情就在这里变得棘手了。

[The isolate API](https://api.dart.dev/stable/dart-isolate/Isolate-class.html) is made up of low-level primitives that provide a wide range of functionality. Granularity like that is great when you need to customize your isolates’ functionality. Granularity is not so great, though, when it’s necessary to use isolates *at all*. Especially since almost all of the use cases for isolates require the same basic configurations for setup and management. This basically meant exposing every implementation detail for you, Dart’s users, to handle yourselves.

[隔离 API](https://api.dart.dev/stable/dart-isolate/Isolate-class.html)
由提供各种功能的底层原语组成。
当你需要定制隔离的功能时，这样的细粒度非常好。
但当只是*想用上*隔离时，细粒度就不那么好了。
尤其是几乎所有隔离的用例
都需要相同的基本设置和管理配置。
这基本意味着把每一个实现细节都暴露出来，
让你——Dart 的用户——自己去处理。

Let’s take a look at a typical isolate setup to better understand the tedious process that `Isolate.run()` solves.

让我们看看一个典型的隔离设置过程，
以便更好地理解 `Isolate.run()` 所解决的繁琐流程。

### Using Isolates (before)

### 使用隔离（之前）

You can think of [`Isolate.spawn()`](https://api.dart.dev/stable/dart-isolate/Isolate/spawn.html) as the old starting point for isolates. Flutter’s compute function was built off of `spawn()`. It takes a method to invoke as its `entrypoint` argument, plus any arguments for that method, and other configurations for the isolate itself. In the past, this `entrypoint` could only be a top-level or static method.

你可以把
[`Isolate.spawn()`](https://api.dart.dev/stable/dart-isolate/Isolate/spawn.html)
看作使用隔离的旧起点。Flutter 的 compute 函数就是基于 `spawn()` 构建的。
它接受一个要调用的方法作为 `entrypoint` 参数，
外加该方法的任意参数，以及隔离本身的其他配置。
过去，这个 `entrypoint` 只能是顶层方法或静态方法。

`Isolate.spawn(_readAndParseJson, filename);`

Isolate created, all done! Just kidding. Not even close.

隔离创建了，大功告成！开玩笑的。还差得远呢。

Calling `spawn` won’t return anything to actually work with. It only returns an isolate object, which simply confirms the isolate has started.

调用 `spawn` 不会返回任何实际可用的东西。
它只返回一个隔离对象，仅仅确认隔离已经启动。

The main isolate and the spawned isolate (the isolate created by `spawn()`) can’t communicate directly, beyond the initial arguments passed on creation. Realistically, even if you don’t need any computation results back from the spawned isolate, you would still want some kind of verification that the computation succeeded, so you’re always going to want a message back.

主隔离和被派生的隔离（由 `spawn()` 创建的隔离）
除了创建时传入的初始参数外，无法直接通信。
实际上，即使你不需要被派生隔离返回任何计算结果，
你也仍然想要某种计算成功的确认，
所以你总是需要一条返回的消息。

To enable communication, you have to set up ports. You create a `ReceivePort` object before calling spawn. The `sendPort` member of the `ReceivePort` object goes to the spawned isolate as another argument for `spawn`.

要实现通信，你必须设置端口（port）。
在调用 spawn 之前创建一个 `ReceivePort` 对象。
`ReceivePort` 对象的 `sendPort` 成员
作为 `spawn` 的另一个参数传给被派生的隔离。

```dart
void main() async {
 final resultPort = ReceivePort();
 final jsonData = await Isolate.spawn(_readAndParseJson, [resultPort.sendPort, filename]);
}

```

This means the function you pass to `spawn` has to be *specifically* configured to do something with that `sendPort`. In other words, you can’t just reuse existing functions with isolates. So instead of passing `spawn` a regular function that just reads and parses a JSON file, you would create something like:

这意味着你传给 `spawn` 的函数必须经过*专门*配置，
以便对那个 `sendPort` 做点什么。
换句话说，你不能直接把现有函数拿来配合隔离使用。
所以，你不能只是给 `spawn` 传一个
读取并解析 JSON 文件的普通函数，而是要创建类似这样的东西：

```dart
Future<void> _readAndParseJson(List<dynamic> args) async {
  SendPort responsePort = args[0];
  String fileName = args[1];

  final fileData = await File(filename).readAsString();
  final result = jsonDecode(fileData);
// ...
}

```

Your special, isolate-friendly, JSON-decoding function can simply “`return result`” and you’re all done, right? Not quite. The result needs to be sent through `responsePort`. That’s how isolates communicate with ports. You can use another primitive, [`Isolate.exit()`](https://api.dart.dev/stable/dart-isolate/Isolate/exit.html) to return the result efficiently and close the spawned isolate at the same time:

你那个专门的、隔离友好的 JSON 解码函数
是不是只要“`return result`”就大功告成了？还不行。
结果需要通过 `responsePort` 发送出去。
这就是隔离用端口通信的方式。
你可以使用另一个原语
[`Isolate.exit()`](https://api.dart.dev/stable/dart-isolate/Isolate/exit.html)
高效地返回结果，同时关闭被派生的隔离：

`Isolate.exit(responsePort, result);`

The `exit()` function *transfers* the memory that holds the message in the spawned isolate to the main isolate (as opposed to copying it over) and safely closes the isolate.

`exit()` 函数把被派生隔离中存放消息的内存
*转移*（而不是复制）到主隔离，并安全地关闭该隔离。

Let’s string this all together. Since `result` in this example is parsed JSON , you’d probably want to destructure it a little to actually use it. For the sake of clean code, instead of planting those three lines that create the `receivePort` and the isolate, and await their response, right into `main()`, we should put them in their own function.

让我们把这些串起来。由于本例中的 `result` 是解析后的 JSON，
你可能想稍微解构一下才能真正使用它。
为了代码整洁，与其把创建 `receivePort` 和隔离、
并等待其响应的那三行代码直接塞进 `main()`，
我们应该把它们放进单独的函数里。

```dart
void main() async {
  final jsonData = await _spawnAndReceive(filename);
  print('Received JSON with ${jsonData.length} keys');
}

// Spawns an isolate and waits for the first message
Future<Map<String, dynamic>> _spawnAndReceive(String filename) async {
  final resultPort = ReceivePort();
  await Isolate.spawn(_readAndParseJson, [resultPort.sendPort, filename]);
  
  return (await resultPort.first) as Map<String, dynamic>;
}

// The entrypoint that runs on the spawned isolate.
void _readAndParseJson(List<dynamic> args) async {
  SendPort responsePort = args[0];
  String fileName = args[1];
  
  final fileData = await File(filename).readAsString();
  final result = jsonDecode(fileData) as Map<String, dynamic>;
  
  Isolate.exit(responsePort, result);
}

```

What’s being accomplished is relatively straightforward. It’s the exposure of implementation details that makes it *feel* complicated, like ports for message passing, and needing a dedicated function for dealing with ports that’s otherwise isolate-agnostic.

要做的事情其实相对简单。
是暴露出来的实现细节让它*感觉*复杂，
比如用于消息传递的端口，
以及需要一个专门处理端口的函数——
除此之外这个函数本可以与隔离无关。

### Error handling

### 错误处理

The example so far *still* isn’t really a “complete”, production-ready implementation. You’d be doing yourself a disservice to leave out any kind of error handling, but it’s commonly forgotten as an additional step in an already substantial process. Without any error handling, if an uncaught async error were to crash your isolate, for example, you wouldn’t know what happened to cause the error, or even be alerted that *anything had happened at all*.

到目前为止，这个例子*仍然*算不上“完整”的、
可用于生产环境的实现。
省略任何形式的错误处理都是对自己不负责任，
但在本已相当繁重的流程中，
它作为额外的一步经常被遗忘。
没有任何错误处理的话，举例来说，
如果一个未捕获的异步错误让你的隔离崩溃了，
你不会知道是什么导致了错误，
甚至不会收到*发生过任何事情*的提醒。

Covering every error handling possibility for isolates would be extensive, but in general it would involve a few more additions to the code.

覆盖隔离的所有错误处理可能性会是一项浩大的工程，
但总的来说，需要在代码中再增加几处内容。

You could, as a minimum, add the `errorsAreFatal`, `onExit`, and `onError` parameters to the spawn call:

至少，你可以给 spawn 调用添加
`errorsAreFatal`、`onExit` 和 `onError` 参数：

```dart
  await Isolate.spawn(_readAndParseJson, [resultPort.sendPort, filename],
          onError: resultPort.sendPort,
          onExit: resultPort.sendPort,
          errorsAreFatal: true
  );

```

This ensures that `resultPort` receives a message even if the spawned isolate terminates without sending a result, or if it has any uncaught errors. Making errors fatal means uncaught errors exit the isolate as a safety precaution, to ensure it terminates at all.

这确保即使被派生的隔离没有发送结果就终止，
或者出现任何未捕获的错误，`resultPort` 也能收到一条消息。
把错误设为致命意味着未捕获的错误会让隔离退出，
作为一种安全预防措施，确保它无论如何都会终止。

The `onExit` argument makes the isolate send `null` to the port upon exiting. The `onError` argument makes an uncaught error send a list of two strings to the port (the `toString` of both the error and stack trace).

`onExit` 参数让隔离在退出时向端口发送 `null`。
`onError` 参数让未捕获的错误向端口发送一个包含两个字符串的列表
（分别是错误和堆栈跟踪的 `toString` 结果）。

Reusing the result port lets you avoid creating more ports, so you only have to look for messages in one place. But it also means you need to distinguish the `onExit` and `onError` messages from the result value. Here, we assume that the JSON must be a `Map`, so it cannot be a list or `null`. Otherwise you’d also have to wrap the result in something recognizable. You would have to create a (trivial) message protocol on top of the port messages.

复用结果端口可以避免创建更多端口，
这样你只需要在一个地方查找消息。
但这也意味着你需要把 `onExit` 和 `onError` 消息
与结果值区分开来。
这里我们假定 JSON 必须是 `Map`，因此不可能是列表或 `null`。
否则你还得把结果包装成某种可识别的东西。
你就必须在端口消息之上创建一个（简单的）消息协议。

Beyond that minimum, you could then check `response` for specific errors. One such case would be checking if `resultPort` is `null`, meaning the isolate terminated without sending results:

在这个最低要求之外，你还可以检查 `response` 中的特定错误。
一种情况是检查 `resultPort` 是否为 `null`，
这意味着隔离没有发送结果就终止了：

```dart
  final response = await resultPort.first;
  if (response == null) {
    // Isolate exited. Throw some error, for example:
    throw RemoteError("Isolate terminated without result"); 
  }

```

Another would be checking if the result is a list, meaning an uncaught error occurred:

另一种情况是检查结果是否为列表，这意味着发生了未捕获的错误：

```dart
  if (response is List<dynamic>) {
    // Uncaught error, list of two strings.
    var remoteError = RemoteError(response[0], response[1]);
    await Future.error(remoteError); // Rethrow.
  }

```

Then, finally, handle an actual result:

然后，终于，处理真正的结果：

```dart
// Otherwise it's a result value, which is a map.
return message as Map<String, dynamic>;

```

In any case, you’d want to put `spawn` in a `try` block to check if sending the `entrypoint` to the new isolate failed. If it did, the result port won’t get any message, and needs to be closed:

无论如何，你都会想把 `spawn` 放进 `try` 块，
以检查把 `entrypoint` 发送给新隔离是否失败。
如果失败了，结果端口不会收到任何消息，需要被关闭：

```dart
  try {
    await Isolate.spawn( ... ); 
  } on Object {
    resultPort.close();
    rethrow;
  }

```

Providing a bare minimum of error handling ensures that the result port is always closed, and `_spawnAndReceive` always completes, no matter how the spawned isolate exits. You could also make things *nicer*, for example, by catching and sending errors and stack traces back as actual objects, not just strings like the `onError` handler.

提供最基本的错误处理可以确保结果端口总是被关闭，
并且无论被派生的隔离如何退出，`_spawnAndReceive` 总能完成。
你还可以把事情做得*更漂亮*，例如，
捕获错误和堆栈跟踪并作为真正的对象传回，
而不是像 `onError` 处理器那样只传字符串。

Error handling obviously introduces a lot of variation, and with it the mental overhead of deciding how to approach it and what to factor for. It’s understandable that it’s commonly left out of primitive isolate setup.

错误处理显然引入了大量变数，
随之而来的是决定如何处理、要考虑哪些因素的心智负担。
在基于原语的隔离设置中它经常被省略，也就不难理解了。

### Using Isolates (after)

### 使用隔离（之后）

`Isolate.run()` sets up all parts of isolate implementation with the primitives you previously had to use yourself, in a single function call:

`Isolate.run()` 用一次函数调用，
借助你以前必须亲自使用的那些原语，
设置好隔离实现的所有部分：

```dart
void main() async {
  final jsonData = await Isolate.run(_readAndParseJson);
  print('Received JSON with ${jsonData.length} keys');
}

```

No ports, no separate spawning, exiting, or error handling, and no special return structure. Perhaps the best part, the `entrypoint` you pass to `run` can be any existing function:

没有端口，没有单独的派生、退出或错误处理，
也没有特殊的返回结构。
也许最棒的是，你传给 `run` 的 `entrypoint` 可以是任何现有函数：

```dart
Future<Map<String, dynamic>> _readAndParseJson() async {
  final fileData = await File(filename).readAsString();
  return jsonDecode(fileData);
}

```

This example shows an *asynchronous* function, but `run` could just as easily execute a *synchronous* function. The `run` function itself always returns asynchronously, which is all that matters.

这个例子展示的是*异步*函数，
但 `run` 同样可以轻松地执行*同步*函数。
`run` 函数本身总是异步返回，这才是关键所在。

The `entrypoint` can also be a *function expression*, written directly inline wherever you call `run`. Isolates, and any higher-level APIs written on top, are no longer limited to running only static or top-level functions.

`entrypoint` 还可以是*函数表达式*，
直接内联写在调用 `run` 的任何地方。
隔离，以及构建在其之上的任何高层 API，
不再局限于只能运行静态函数或顶层函数。

```dart
  final jsonData = await Isolate.run(() async {
    final fileData = await File(filename).readAsString();
    final jsonData = jsonDecode(fileData) as Map<String, dynamic>;
    return jsonData;
  });
```

The additional message parameter is no longer necessary, and you can avoid packing and unpacking arguments in data structures like lists.

额外的消息参数不再必要，
你可以避免在列表之类的数据结构中打包和解包参数。

You don’t have to think much about error handling at all. The `run` function combines local and remote error capturing, handling and cross-isolate communication, and exposes the result as a single normal (asynchronous) error that you can catch in a standard `try`/`catch`. You can forget isolates, and treat it as a normal function.

你几乎完全不用考虑错误处理。
`run` 函数把本地和远程的错误捕获、处理以及跨隔离通信
结合在一起，并把结果暴露为一个普通的（异步）错误，
你可以在标准的 `try`/`catch` 中捕获它。
你可以忘掉隔离，把它当作一个普通函数来对待。

```dart
  try {
    await Isolate.run(_readAndParseJson);
  } on FormatException catch (e, s) {
    print(e.message); 
  }

```

`Isolate.run()` enables much cleaner and ergonomic code. Flutter’s `compute` function even switched over to using `run` instead of `spawn`!

`Isolate.run()` 让代码更干净、更符合人体工程学。
Flutter 的 `compute` 函数甚至也改用了 `run` 而不是 `spawn`！

### Inside Isolate.run()

### Isolate.run() 内部

Take a look at the [implementation of `run`](https://api.dart.dev/dev/3.0.0-125.0.dev/dart-isolate/Isolate/run.html#implementation:~:text=isolate%20for%20debugging.-,Implementation,-%40Since(%222.19) itself. It digs into all the low-level isolate-related APIs (which would’ve been your job to implement before) to construct a “perfect”, comprehensive isolate setup. It takes the method to execute, `computation`, and sets up all the ports and their returns to account for efficient message passing between isolates.

看看
[`run` 的实现](https://api.dart.dev/dev/3.0.0-125.0.dev/dart-isolate/Isolate/run.html#implementation:~:text=isolate%20for%20debugging.-,Implementation,-%40Since(%222.19)本身。
它深入所有底层的隔离相关 API
（以前这些都得由你来实现），
构建出一个“完美”、全面的隔离设置。
它接受要执行的方法 `computation`，
并设置好所有端口及其返回，
以实现隔离之间高效的消息传递。

```dart
static Future<R> run<R>(FutureOr<R> computation(), {String? debugName}) {
    var result = Completer<R>();
    var resultPort = RawReceivePort();
    // ...
    result.complete;    // or result.completeError for error handling blocks
    // ...

```

There’s *thorough* error handling for every potential case. The `run` function checks whether an isolate dies before it’s done computing. If the computation throws, the isolate terminates and throws the same error to the main isolate.

针对每一种潜在情况都有*周全的*错误处理。
`run` 函数会检查隔离是否在计算完成前就死掉了。
如果计算抛出错误，隔离会终止，
并把同样的错误抛给主隔离。

```dart
// ...
    resultPort.handler = (response) {
      resultPort.close();
      if (response == null) {
        // onExit handler message, isolate terminated without sending result.
        result.completeError(
            RemoteError("Computation ended without result", ""),
            StackTrace.empty);
        return;
      }
// ...

```

If an uncaught asynchronous error occurs, the isolate terminates and reports the error asynchronously to the main isolate. If the main isolate terminates first, the spawned isolate terminates and treats the situation as an uncaught async error.

如果发生未捕获的异步错误，隔离会终止，
并异步地把错误报告给主隔离。
如果主隔离先终止，被派生的隔离也会终止，
并把这种情况当作未捕获的异步错误来处理。

```dart
// ...
void _run() async {
    R result;
    try {
      var potentiallyAsyncResult = computation();
      if (potentiallyAsyncResult is Future<R>) {
        result = await potentiallyAsyncResult;
      } else {
        result = potentiallyAsyncResult;
      }
    } catch (e, s) {
      // If sending fails, the error becomes an uncaught error.
      Isolate.exit(resultPort, _list2(e, s));
    }
    Isolate.exit(resultPort, _list1(result));
  }

```

Lastly, `run` always uses `exit` to safely shut down. That means data is efficiently transferred from isolate to isolate without actually copying it.

最后，`run` 总是使用 `exit` 来安全关闭。
这意味着数据在隔离之间高效转移，而无需实际复制。

### Summary

### 总结

The `run` function is ideal for starting one computation and waiting for the results. The primitives are still there if you want to build out your own isolate setup for something that `run` doesn’t cover, like a [long-running isolate](https://github.com/dart-lang/samples/blob/master/isolates/bin/long_running_isolate.dart) that can send and receive messages multiple times. For most cases though, replacing `spawn` and all its supporting configurations with a single `run` statement should be used over any other configuration.

`run` 函数非常适合启动一项计算并等待结果。
如果你想为 `run` 覆盖不到的场景搭建自己的隔离设置，
那些原语仍然还在，比如可以多次收发消息的
[长时间运行的隔离](https://github.com/dart-lang/samples/blob/master/isolates/bin/long_running_isolate.dart)。
不过对大多数情况而言，
用一条 `run` 语句取代 `spawn` 及其所有配套配置，
应该优先于任何其他配置方式。

If you’d never tried isolate management before `run`, it would be hard to believe all this functionality previously had to be implemented by the user! `Isolate.run()` — available in Dart 2.19 and Flutter 3.7 — makes code so much more ergonomic, and makes isolates so much easier to use. What will you do with all the time `run` saves you?

如果你在 `run` 出现之前从未尝试过隔离管理，
你很难相信所有这些功能以前都得由用户自己实现！
`Isolate.run()`——在 Dart 2.19 和 Flutter 3.7 中可用——
让代码更符合人体工程学，让隔离更容易使用。
`run` 为你省下的所有时间，你打算拿来做什么？
