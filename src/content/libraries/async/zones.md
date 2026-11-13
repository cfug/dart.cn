---
# title: Zones
title: 区域 (Zone)
# description: >-
#   Manage your asynchronous code: handle uncaught errors, 
#   override behavior (such as printing and scheduling tasks), and more.
description: >-
  管理异步代码：处理未捕获的错误、
  覆盖行为（例如打印和调度任务）等。
date: 2014-03-03
obsolete: true
ai-translated: true
---

<style>
.zone1 {
  background-color: rgb(208, 211, 255);
}

.zone2 {
  background-color: rgb(195, 255, 231);
}

.zone3 {
  background-color: rgb(255, 240, 164);
}
</style>

## Asynchronous dynamic extents

## 异步动态范围

This article discusses zone-related APIs in the [dart:async][] library,
with a focus on the top-level [`runZoned()`][]
and [`runZonedGuarded()`][] functions.
Review the techniques covered in
[Futures and Error Handling](/libraries/async/futures-error-handling)
before reading this article.

本文讨论 [dart:async][] 库中与区域 (Zone) 相关的 API，
重点是顶层函数 [`runZoned()`][] 和 [`runZonedGuarded()`][]。
阅读本文之前，请先回顾
[Future 和错误处理](/libraries/async/futures-error-handling)
中的技巧。

[dart:async]: {{site.dart-api}}/dart-async/dart-async-library.html
[`runZoned()`]: {{site.dart-api}}/dart-async/runZoned.html
[`runZonedGuarded()`]: {{site.dart-api}}/dart-async/runZonedGuarded.html

Zones make the following tasks possible:

区域 (Zone) 让下面这些事情成为可能：

* **Protecting your app from exiting due to
  an uncaught exception**.
  For example,
  a simple HTTP server
  might use the following asynchronous code:

  **保护应用，避免因未捕获的异常而退出**。
  例如，一个简单的 HTTP 服务器可能会使用下面的异步代码：

  ```dart
  [!runZonedGuarded(() {!]
    HttpServer.bind('0.0.0.0', port).then((server) {
      server.listen(staticFiles.serveRequest);
    });
  [!},!]
  [!(error, stackTrace) => print('Oh noes! $error $stackTrace'));!]
  ```
  
  Running the HTTP server in a zone
  enables the app to continue running despite uncaught (but non-fatal)
  errors in the server's asynchronous code.

  在区域中运行 HTTP 服务器后，
  即使服务器的异步代码里出现未捕获（但非致命）的错误，
  应用也能继续运行。

* **Associating data**—known as
  <em>zone-local values</em>—**with individual zones**.

  **把数据（即区域局部值）关联到各个区域**。

* **Overriding a limited set of methods**,
  such as `print()` and `scheduleMicrotask()`,
  within part or all of the code.

  **覆盖有限的一组方法**，
  例如在部分或全部代码中覆盖 `print()` 和 `scheduleMicrotask()`。

* **Performing an operation each time that
  code enters or exits a zone**.
  Such operations could include
  starting or stopping a timer,
  or saving a stack trace.

  **在代码每次进入或离开区域时执行一项操作**。
  这类操作可以包括启动或停止计时器，或者保存栈追踪。

You might have encountered something similar to zones in other languages.
_Domains_ in Node.js were an inspiration for Dart's zones.
Java's _thread-local storage_
also has some similarities.
Closest of all is Brian Ford's JavaScript port of Dart zones,
[zone.js](https://github.com/btford/zone.js/), which he describes in
[this video]({{site.yt.watch}}?v=3IqtmUscE_U).

你可能在其他语言里见过与区域类似的东西。
Node.js 中的 **Domain** 是 Dart 区域的灵感来源。
Java 的 **线程局部存储** 也有一些相似之处。
最接近的是 Brian Ford 把 Dart 区域移植到 JavaScript 的
[zone.js](https://github.com/btford/zone.js/)，
他在 [这个视频]({{site.yt.watch}}?v=3IqtmUscE_U) 里作了介绍。


## Zone basics

## 区域基础

A _zone_ represents the asynchronous dynamic extent of a call.
It is the computation that is performed as part of a call and, transitively,
the asynchronous callbacks that have been registered by that code.

**区域** 表示一次调用的异步动态范围。
它是作为调用的一部分执行的计算，
以及由这段代码传递注册的异步回调。

For example,
in the HTTP server example,
`bind()`, `then()`, and the callback of `then()`
all execute in the same zone—the zone
that was created using `runZoned()`.

例如，在 HTTP 服务器的例子中，
`bind()`、`then()` 以及 `then()` 的回调
都在同一个区域中执行，
也就是用 `runZoned()` 创建的那个区域。

In the next example,
the code executes in 3 different zones:
<span class="zone1">zone #1</span> (the root zone),
<span class="zone2">zone #2</span>, and
<span class="zone3">zone #3</span>.

在下一个例子中，代码在 3 个不同的区域中执行：
<span class="zone1">区域 #1</span>（根区域）、
<span class="zone2">区域 #2</span> 和
<span class="zone3">区域 #3</span>。

<!-- ex1.dart -->
<!-- Using pre instead of prettify so we can use background colors -->
<pre>
import 'dart:async';

<span class="zone1">main() {
  foo();
  var future;
  runZoned(() {</span>          // Starts a new child zone (zone #2).
<span class="zone2">    future = new Future(bar).then(baz);
  </span><span class="zone1">});
  future.then(qux);
}</span>

foo() => <em><span class="zone1">...foo</span><span class="zone3">-body...</span></em>  // Executed twice (once each in two zones).
bar() => <em><span class="zone2">...bar-body...</span></em>
baz(x) => <span class="zone2">runZoned(() =></span> <span class="zone3">foo()</span><span class="zone2">);</span> // New child zone (zone #3).
qux(x) => <em><span class="zone1">...qux-body...</span></em>
</pre>

The following figure shows the code's execution order,
as well as which zone the code executes in.

下图展示代码的执行顺序，以及代码在哪个区域中执行。

![illustration of program execution](/assets/img/articles/zones/trace.png)

Each call to `runZoned()` creates a new zone
and executes code in that zone.
When that code schedules a task—such
as calling baz()—that
task executes in the zone where it was scheduled.
For example, the call to qux() (last line of main())
runs in
<span class="zone1">zone #1</span> (the root zone)
even though it's attached to a future that itself runs in
<span class="zone2">zone #2</span>.

每次调用 `runZoned()` 都会创建一个新区域，并在该区域中执行代码。
当这段代码调度任务（例如调用 baz()）时，
该任务会在它被调度时所在的区域中执行。
例如，对 qux() 的调用（main() 的最后一行）
运行在 <span class="zone1">区域 #1</span>（根区域）中，
尽管它挂在一个本身运行于 <span class="zone2">区域 #2</span> 的 Future 上。

Child zones don't completely replace their parent zone.
Instead new zones are nested inside their surrounding zone.
For example,
<span class="zone2">zone #2</span> contains
<span class="zone3">zone #3</span>, and
<span class="zone1">zone #1</span> (the root zone)
contains both
<span class="zone2">zone #2</span> and
<span class="zone3">zone #3</span>.

子区域并不会完全取代父区域。
新区域嵌套在包围它的区域之内。
例如，<span class="zone2">区域 #2</span> 包含
<span class="zone3">区域 #3</span>，
而 <span class="zone1">区域 #1</span>（根区域）
同时包含 <span class="zone2">区域 #2</span> 和
<span class="zone3">区域 #3</span>。

All Dart code executes in the root zone.
Code might execute in other nested child zones as well,
but at a minimum it always runs in the root zone.

所有 Dart 代码都在根区域中执行。
代码也可能在其他嵌套的子区域中执行，
但至少总会在根区域中运行。


## Handling uncaught errors

## 处理未捕获的错误

Zones are able to catch and handle uncaught errors.

区域可以捕获并处理未捕获的错误。

_Uncaught errors_ often occur because of code using `throw`
to raise an exception without an accompanying `catch`
statement to handle it.
Uncaught errors can also arise in `async` functions
when a Future completes with an error result,
but is missing a corresponding `await` to handle the error.

**未捕获的错误** 常常是因为代码用 `throw` 抛出异常，
却没有配套的 `catch` 语句来处理。
在 `async` 函数中，如果 Future 以错误结果完成，
却缺少对应的 `await` 来处理该错误，也会出现未捕获的错误。

An uncaught error reports to the current zone that failed to catch it.
By default, zones will crash the program in response to uncaught errors.
You can install your own custom _uncaught error handler_ to a new zone
to intercept and handle uncaught errors however you prefer.

未捕获的错误会报告给未能捕获它的当前区域。
默认情况下，区域会因未捕获的错误而使程序崩溃。
你可以为新区域安装自定义的 **未捕获错误处理器**，
按自己的方式拦截并处理未捕获的错误。

To introduce a new zone with an uncaught error handler,
use the `runZoneGuarded` method. Its `onError` callback becomes the
uncaught error handler of a new zone. This callback handles any
synchronous errors that the call throws.

要引入带未捕获错误处理器的新区域，
请使用 `runZoneGuarded` 方法。
它的 `onError` 回调会成为新区域的未捕获错误处理器。
这个回调会处理该调用抛出的任何同步错误。

<!-- run_zoned1.dart -->
```dart
runZonedGuarded(() {
  Timer.run(() { throw 'Would normally kill the program'; });
}, (error, stackTrace) {
  print('Uncaught error: $error');
});
```

_Other zone APIs that facilitate uncaught error handling include
[`Zone.fork`][], [`Zone.runGuarded`][]
and [`ZoneSpecification.uncaughtErrorHandler`][]._

**其他有助于处理未捕获错误的区域 API 包括
[`Zone.fork`][Zone.fork]、[`Zone.runGuarded`][Zone.runGuarded]
和 [`ZoneSpecification.uncaughtErrorHandler`][ZoneSpecification.uncaughtErrorHandler]。**

[`Zone.fork`]:  {{site.dart-api}}/dart-async/Zone/fork.html
[`Zone.runGuarded`]:  {{site.dart-api}}/dart-async/Zone/runGuarded.html
[`ZoneSpecification.uncaughtErrorHandler`]:  {{site.dart-api}}/dart-async/ZoneSpecification/handleUncaughtError.html

The preceding code has an asynchronous callback
(through `Timer.run()`) that throws an exception.
Normally this exception would be an unhandled error and reach the top level
(which, in the standalone Dart executable, would kill the running process).
However, with the zoned error handler,
the error is passed to the error handler and doesn't shut down the program.

前面的代码有一个异步回调（通过 `Timer.run()`），它会抛出异常。
通常这个异常会成为未处理的错误并到达顶层
（在独立的 Dart 可执行文件中，这会终止正在运行的进程）。
有了区域错误处理器之后，
错误会被传给错误处理器，而不会让程序退出。

One notable difference between try-catch and zoned error handlers is
that zones continue to execute after uncaught errors occur.
If other asynchronous callbacks are scheduled within the zone,
they still execute.
As a consequence a zoned error handler might
be invoked multiple times.

try-catch 与区域错误处理器的一个显著区别是：
出现未捕获的错误之后，区域仍会继续执行。
如果区域内还调度了其他异步回调，它们仍会执行。
因此，区域错误处理器可能会被调用多次。

Any zone with an uncaught error handler is called an _error zone_.
An error zone might handle errors that originate
in a descendant of that zone.
A simple rule determines where
errors are handled in a sequence of future transformations
(using `then()` or `catchError()`):
Errors on Future chains never cross the boundaries of error zones.

任何带有未捕获错误处理器的区域都称为 **错误区域**。
错误区域可能会处理源自其后代区域的错误。
有一条简单规则决定 Future 变换序列
（使用 `then()` 或 `catchError()`）中的错误在何处处理：
Future 链上的错误永远不会跨越错误区域的边界。

If an error reaches an error zone boundary,
it is treated as unhandled error at that point.

如果错误到达错误区域的边界，
就在该处被视为未处理的错误。

:::note API note
Handling uncaught errors doesn't *require* zones.
The isolate API [`Isolate.run()`][] also handles 
listening for uncaught errors.

:::note API 说明
处理未捕获的错误并不 **必须** 使用区域。
isolate API [`Isolate.run()`][] 也会监听未捕获的错误。
:::

[`Isolate.run()`]: {{site.dart-api}}/dev/dart-isolate/Isolate/run.html

### Example: Errors can't cross into error zones

### 示例：错误不能进入错误区域

In the following example,
the error raised by the first line
can't cross into an error zone.

在下面的例子中，第一行抛出的错误不能进入错误区域。

<!-- run_zoned2.dart -->
```dart
var f = new Future.error(499);
f = f.whenComplete(() { print('Outside of zones'); });
runZoned(() {
  f = f.whenComplete(() { print('Inside non-error zone'); });
});
runZonedGuarded(() {
  f = f.whenComplete(() { print('Inside error zone (not called)'); });
}, (error) { print(error); });
```

Here's the output you see if you run the example:

运行这个例子会看到如下输出：

```plaintext
Outside of zones
Inside non-error zone
Uncaught Error: 499
Unhandled exception:
499
...stack trace...
```

If you remove the call to `runZoned()` or
to `runZonedGuarded()`,
you see this output:

如果去掉对 `runZoned()` 或 `runZonedGuarded()` 的调用，
会看到这样的输出：

```plaintext
Outside of zones
Inside non-error zone
[!Inside error zone (not called)!]
Uncaught Error: 499
Unhandled exception:
499
...stack trace...
```

Note how removing either the zone or error zone causes
the error to propagate further.

注意，去掉普通区域或错误区域都会让错误传播得更远。

The stack trace appears because the error happens outside an error zone.
If you add an error zone around the whole code snippet,
then you can avoid the stack trace.

出现栈追踪是因为错误发生在错误区域之外。
如果用错误区域包住整段代码，就可以避免栈追踪。


### Example: Errors can't leave error zones

### 示例：错误不能离开错误区域

As the preceding code shows,
errors can't cross into error zones.
Similarly, errors can't cross _out_ of error zones.
Consider this example:

如前所示，错误不能进入错误区域。
同样，错误也不能 **离开** 错误区域。看这个例子：

<!-- run_zoned3.dart -->
```dart
var completer = new Completer();
var future = completer.future.then((x) => x + 1);
var zoneFuture;
runZonedGuarded(() {
  zoneFuture = future.then((y) => throw 'Inside zone');
}, (error) { print('Caught: $error'); });

zoneFuture.catchError((e) { print('Never reached'); });
completer.complete(499);
```

Even though the future chain ends in a `catchError()`,
the asynchronous error can't leave the error zone.
The zoned error handler found in `runZonedGuarded()`
handles the error.
As a result, *zoneFuture never completes* — neither
with a value, nor with an error.

尽管 Future 链的末尾有 `catchError()`，
这个异步错误也不能离开错误区域。
`runZonedGuarded()` 中的区域错误处理器会处理该错误。
结果是，**zoneFuture 永远不会完成**——
既不会以值完成，也不会以错误完成。

## Using zones with streams

## 在 Stream 中使用区域

The rule for zones and streams
is simpler than for futures:

区域与 Stream 的规则比 Future 更简单：

:::note
Transformations and other callbacks execute in the zone
where the stream is listened to.

转换和其他回调在监听该 Stream 的区域中执行。
:::

This rule follows from the guideline that
streams should have no side effect until listened to.
A similar situation in synchronous code is the behavior of Iterables,
which aren't evaluated until you ask for values.

这条规则来自这样的原则：
Stream 在被监听之前不应产生副作用。
同步代码中的类似情况是 Iterable 的行为：
在你请求值之前，它们不会求值。

### Example: Using a stream with `runZonedGuarded()`

### 示例：在 `runZonedGuarded()` 中使用 Stream

The following example sets up a stream with a callback,
and then executes that stream in a new zone with `runZonedGuarded()`:

下面的例子先建立一个带回调的 Stream，
再用 `runZonedGuarded()` 在新区域中执行该 Stream：

<!-- stream.dart -->
```dart
var stream = new File('stream.dart').openRead()
    .map((x) => throw 'Callback throws');

runZonedGuarded(() { stream.listen(print); },
         (e) { print('Caught error: $e'); });
```

The error handler in `runZonedGuarded()`
catches the error the callback throws.
Here's the output:

`runZonedGuarded()` 中的错误处理器会捕获回调抛出的错误。
输出如下：

```plaintext
Caught error: Callback throws
```

As the output shows,
the callback is associated with the listening zone,
not with the zone where `map()` is called.

从输出可以看出，
回调关联的是监听时所在的区域，
而不是调用 `map()` 时所在的区域。


## Storing zone-local values

## 存储区域局部值

If you ever wanted to use a static variable
but couldn't because
multiple concurrently running computations interfered with each other,
consider using a zone-local value.
You might add a zone-local value to help with debugging.
Another use case is dealing with an HTTP request:
you could have the user ID
and its authorization token in zone-local values.

如果你曾经想用静态变量，
却因为多个并发计算互相干扰而没法用，
可以考虑区域局部值。
可以添加区域局部值来帮助调试。
另一个用途是处理 HTTP 请求：
可以把用户 ID 及其授权令牌放在区域局部值中。

Use the `zoneValues` argument to `runZoned()` to
store values in the newly created zone:

用 `runZoned()` 的 `zoneValues` 参数
把值存入新创建的区域：

<!-- value1.dart -->
```dart
runZoned(() {
  print(Zone.current[#key]);
}, zoneValues: { #key: 499 });
```

To read zone-local values, use the zone's index operator and the value's key:
<code>[<em>key</em>]</code>.
Any object can be used as a key, as long as it has compatible
`operator ==` and `hashCode` implementations.
Typically, a key is a symbol literal:
<code>#<em>identifier</em></code>.

要读取区域局部值，请使用区域的索引运算符和该值的键：
<code>[<em>key</em>]</code>。
任何对象都可以作为键，只要它的
`operator ==` 和 `hashCode` 实现彼此兼容。
键通常是符号字面量：
<code>#<em>identifier</em></code>。

You can't change the object that a key maps to,
but you can manipulate the object.
For example, the following code
adds an item to a zone-local list:

不能更换键所映射的对象，但可以操作该对象。
例如，下面的代码向区域局部列表添加一项：

<!-- value1_1.dart -->
```dart
runZoned(() {
  Zone.current[#key].add(499);
  print(Zone.current[#key]); // [499]
}, zoneValues: { #key: [] });
```

A zone inherits zone-local values from its parent zone,
so adding nested zones doesn't accidentally drop existing values.
Nested zones can, however, shadow parent values.

区域会从父区域继承区域局部值，
因此增加嵌套区域不会意外丢掉已有的值。
不过，嵌套区域可以遮蔽父区域的值。

:::important
Try to use unique objects for keys,
so they're less likely to conflict with other libraries.

尽量使用唯一的对象作为键，
这样就不容易与其他库冲突。
:::


### Example: Using a zone-local value for debug logs

### 示例：用区域局部值做调试日志

Say you have two files, foo.txt and bar.txt,
and want to print all of their lines.
The program might look like this:

假设有 foo.txt 和 bar.txt 两个文件，
想打印它们的所有行。程序可能像这样：

<!-- value2.dart -->
```dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future splitLinesStream(stream) {
  return stream
      .transform(ASCII.decoder)
      .transform(const LineSplitter())
      .toList();
}

Future splitLines(filename) {
  return splitLinesStream(new File(filename).openRead());
}
main() {
  Future.forEach(['foo.txt', 'bar.txt'],
                 (file) => splitLines(file)
                     .then((lines) { lines.forEach(print); }));
}
```

This program works,
but let's assume that you now want to know
which file each line comes from,
and that you can't just add a filename argument to `splitLinesStream()`.
With zone-local values you can add the filename to the returned string
(new lines are highlighted):

这个程序可以工作，
但假设现在你想知道每一行来自哪个文件，
又不能直接给 `splitLinesStream()` 增加 filename 参数。
用区域局部值可以把文件名加到返回的字符串上
（新增的行已高亮）：

<!-- value3.dart -->
```dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future splitLinesStream(stream) {
  return stream
      .transform(ASCII.decoder)
      .transform(const LineSplitter())
[!      .map((line) => '${Zone.current[#filename]}: $line')!]
      .toList();
}

Future splitLines(filename) {
[!  return runZoned(() {!]
    return splitLinesStream(new File(filename).openRead());
[!  }, zoneValues: { #filename: filename });!]
}

main() {
  Future.forEach(['foo.txt', 'bar.txt'],
                 (file) => splitLines(file)
                     .then((lines) { lines.forEach(print); }));
}
```

Note that the new code doesn't modify the function signatures or
pass the filename from `splitLines()` to `splitLinesStream()`.
Instead, it uses zone-local values to implement
a feature similar to a static variable
that works in asynchronous contexts.

注意，新代码没有修改函数签名，
也没有把文件名从 `splitLines()` 传给 `splitLinesStream()`。
它用区域局部值实现了类似静态变量的功能，
并且能在异步上下文中工作。


## Overriding functionality

## 覆盖功能

Use the `zoneSpecification` argument to `runZoned()`
to override functionality that is managed by zones.
The argument's value is a
[ZoneSpecification]({{site.dart-api}}/dart-async/ZoneSpecification-class.html) object,
with which you can override any of the following functionality:

用 `runZoned()` 的 `zoneSpecification` 参数
覆盖由区域管理的功能。
该参数的值是
[ZoneSpecification]({{site.dart-api}}/dart-async/ZoneSpecification-class.html) 对象，
可以用它覆盖下列任何功能：

* Forking child zones

  派生子区域

* Registering and running callbacks in the zone

  在区域中注册并运行回调

* Scheduling microtasks and timers

  调度微任务和计时器

* Handling uncaught asynchronous errors
  (`runZonedGuarded()` is a shortcut for this)

  处理未捕获的异步错误
  （`runZonedGuarded()` 是这方面的快捷方式）

* Printing

  打印

### Example: Overriding print

### 示例：覆盖 print

As a simple example of overriding functionality,
here is a way to silence all prints inside a zone:

下面是覆盖功能的一个简单例子，
它可以让区域内的所有打印都静默：

<!-- specification1.dart -->
```dart
import 'dart:async';

main() {
  runZoned(() {
    print('Will be ignored');
  }, zoneSpecification: new ZoneSpecification(
    print: (self, parent, zone, message) {
      // Ignore message.
    }));
}
```

Inside the forked zone,
the `print()` function is overridden by the specified print interceptor,
which simply discards the message.
Overriding print is possible because `print()`
(like `scheduleMicrotask()` and the Timer constructors)
uses the current zone (`Zone.current`) to do its work.

在派生出的区域内部，
`print()` 函数被指定的 print 拦截器覆盖，
拦截器直接丢弃消息。
之所以能覆盖 print，是因为 `print()`
（和 `scheduleMicrotask()` 以及 Timer 构造函数一样）
通过当前区域（`Zone.current`）来完成工作。


### Arguments to interceptors and delegates

### 拦截器与委托的参数

As the print example shows,
an interceptor adds three arguments
to those defined in the Zone class's corresponding method.
For example, Zone's `print()` method has one argument:
`print(String line)`.
The interceptor version of `print()`,
as defined by ZoneSpecification,
has four arguments:
`print(Zone self, ZoneDelegate parent, Zone zone, String line)`.

如 print 的例子所示，
拦截器会在 Zone 类对应方法已有参数的基础上再加三个参数。
例如，Zone 的 `print()` 方法有一个参数：
`print(String line)`。
ZoneSpecification 所定义的拦截器版本的 `print()`
有四个参数：
`print(Zone self, ZoneDelegate parent, Zone zone, String line)`。

The three interceptor arguments always appear in the same order,
before any other arguments.

这三个拦截器参数总是以相同的顺序出现，并且位于其他参数之前。

`self`
: The zone that's handling the callback.

  正在处理该回调的区域。

`parent`
: A ZoneDelegate representing the parent zone.
  Use it to forward operations to the parent.

  代表父区域的 ZoneDelegate。
  用它把操作转发给父区域。

`zone`
: The zone where the operation originated.
  Some operations need to know which zone the operation was invoked on.
  For example, `zone.fork(specification)` must
  create a new zone as child of `zone`.
  As another example,
  even when you delegate `scheduleMicrotask()` to another zone,
  the original `zone` must be the one that executes the microtask.

  操作发起时所在的区域。
  有些操作需要知道它是在哪个区域上被调用的。
  例如，`zone.fork(specification)` 必须创建 `zone` 的子区域。
  再例如，即使把 `scheduleMicrotask()` 委托给另一个区域，
  执行该微任务的也必须是原来的 `zone`。


When an interceptor delegates a method to the parent,
the parent (ZoneDelegate) version of the method
has just one additional argument:
`zone`, the zone where the original call originated from.
For example,
the signature of the `print()` method on a ZoneDelegate is
`print(Zone zone, String line)`.

当拦截器把方法委托给父区域时，
父区域（ZoneDelegate）版本的方法只多一个参数：
`zone`，即原始调用发起时所在的区域。
例如，ZoneDelegate 上 `print()` 方法的签名是
`print(Zone zone, String line)`。

Here's an example of the arguments
for another interceptable method, `scheduleMicrotask()`:

下面是另一个可拦截方法 `scheduleMicrotask()` 的参数示例：

| <t>**Where defined**</t><t>**定义位置**</t> | <t>**Method signature**</t><t>**方法签名**</t> |
| Zone              | `void scheduleMicrotask(void f())` |
| Zone              | `void scheduleMicrotask(void f())` |
| ZoneSpecification&nbsp; | `void scheduleMicrotask(Zone self, ZoneDelegate parent, Zone zone, void f())` |
| ZoneSpecification&nbsp; | `void scheduleMicrotask(Zone self, ZoneDelegate parent, Zone zone, void f())` |
| ZoneDelegate      | `void scheduleMicrotask(Zone zone, void f())` |
| ZoneDelegate      | `void scheduleMicrotask(Zone zone, void f())` |


### Example: Delegating to the parent zone

### 示例：委托给父区域

Here is an example that shows how to delegate to the parent zone:

下面的例子展示如何委托给父区域：

<!-- specification2.dart -->
```dart
import 'dart:async';

main() {
  runZoned(() {
    var currentZone = Zone.current;
    scheduleMicrotask(() {
      print(identical(currentZone, Zone.current));  // prints true.
    });
  }, zoneSpecification: new ZoneSpecification(
    scheduleMicrotask: (self, parent, zone, task) {
      print('scheduleMicrotask has been called inside the zone');
      // The origin `zone` needs to be passed to the parent so that
      // the task can be executed in it.
      parent.scheduleMicrotask(zone, task);
    }));
}
```


### Example: Executing code when entering and leaving a zone

### 示例：进入和离开区域时执行代码

Say you want to know how much time some asynchronous code
spends executing.
You can do this by putting the code in a zone,
starting a timer every time the zone is entered,
and stopping the timer whenever the zone is left.

假设你想知道某段异步代码花了多少执行时间。
可以把代码放进一个区域，
每次进入该区域时启动计时器，
每次离开时停止计时器。

Providing `run*` parameters to the ZoneSpecification
lets you specify the code that the zone executes.

向 ZoneSpecification 提供 `run*` 参数，
就可以指定区域执行的代码。

:::note API note
In the future, zones might provide a simpler alternative
for the common case of sandwiching zone code:
an onEnter/onLeave API.
See [issue 17532]({{site.repo.dart.sdk}}/issues/17532)
for details.

:::note API 说明
将来，区域可能会为「在区域代码前后夹入逻辑」这一常见场景
提供更简单的做法：onEnter/onLeave API。
详情见 [issue 17532]({{site.repo.dart.sdk}}/issues/17532)。
:::

The `run*` parameters—`run`, `runUnary`, and `runBinary`—specify
code to execute every time the zone is asked to execute code.
These parameters work for zero-argument, one-argument,
and two-argument callbacks, respectively.
The `run` parameter also works for the initial, synchronous code
that executes just after calling `runZoned()`.

`run*` 参数（`run`、`runUnary` 和 `runBinary`）
指定每次要求区域执行代码时要运行的代码。
这些参数分别用于零参数、单参数和双参数回调。
`run` 参数也适用于调用 `runZoned()` 之后立即执行的那段初始同步代码。

Here's an example of profiling code using `run*`:

下面是用 `run*` 做性能分析的例子：

<!-- profile_run.dart -->
```dart
final total = new Stopwatch();
final user = new Stopwatch();

final specification = new ZoneSpecification(
  run: (self, parent, zone, f) {
    user.start();
    try { return parent.run(zone, f); } finally { user.stop(); }
  },
  runUnary: (self, parent, zone, f, arg) {
    user.start();
    try { return parent.runUnary(zone, f, arg); } finally { user.stop(); }
  },
  runBinary: (self, parent, zone, f, arg1, arg2) {
    user.start();
    try {
      return parent.runBinary(zone, f, arg1, arg2);
    } finally {
      user.stop();
    }
  });

runZoned(() {
  total.start();
  // ... Code that runs synchronously...
  // ... Then code that runs asynchronously ...
    .then((...) {
      print(total.elapsedMilliseconds);
      print(user.elapsedMilliseconds);
    });
}, zoneSpecification: specification);
```

In this code,
each `run*` override just starts the user timer,
executes the specified function,
and then stops the user timer.

在这段代码中，
每个 `run*` 覆盖都只是启动用户计时器、
执行指定的函数，然后停止用户计时器。


### Example: Handling callbacks

### 示例：处理回调

Provide `register*Callback` parameters to the ZoneSpecification
to wrap or change callback code—the code
that's executed asynchronously in the zone.
Like the `run*` parameters,
the `register*Callback` parameters have three forms:
`registerCallback` (for callbacks with no arguments),
`registerUnaryCallback` (one argument), and
`registerBinaryCallback` (two arguments).

向 ZoneSpecification 提供 `register*Callback` 参数，
可以包装或修改回调代码，
也就是在区域中异步执行的代码。
和 `run*` 参数一样，
`register*Callback` 参数有三种形式：
`registerCallback`（无参数回调）、
`registerUnaryCallback`（一个参数）和
`registerBinaryCallback`（两个参数）。

Here's an example that makes the zone
save a stack trace
before the code disappears into an asynchronous context.

下面的例子让区域在代码进入异步上下文之前保存栈追踪。

<!-- debug.dart -->
```dart
import 'dart:async';

get currentStackTrace {
  try {
    throw 0;
  } catch(_, st) {
    return st;
  }
}

var lastStackTrace = null;

bar() => throw "in bar";
foo() => new Future(bar);

main() {
  final specification = new ZoneSpecification(
    registerCallback: (self, parent, zone, f) {
      var stackTrace = currentStackTrace;
      return parent.registerCallback(zone, () {
        lastStackTrace = stackTrace;
        return f();
      });
    },
    registerUnaryCallback: (self, parent, zone, f) {
      var stackTrace = currentStackTrace;
      return parent.registerUnaryCallback(zone, (arg) {
        lastStackTrace = stackTrace;
        return f(arg);
      });
    },
    registerBinaryCallback: (self, parent, zone, f) {
      var stackTrace = currentStackTrace;
      return parent.registerBinaryCallback(zone, (arg1, arg2) {
        lastStackTrace = stackTrace;
        return f(arg1, arg2);
      });
    },
    handleUncaughtError: (self, parent, zone, error, stackTrace) {
      if (lastStackTrace != null) print("last stack: $lastStackTrace");
      return parent.handleUncaughtError(zone, error, stackTrace);
    });

  runZoned(() {
    foo();
  }, zoneSpecification: specification);
}
```

Go ahead and run the example.
You'll see a "last stack" trace (`lastStackTrace`)
that includes `foo()`,
since `foo()` was called synchronously.
The next stack trace (`stackTrace`)
is from the asynchronous context,
which knows about `bar()` but not `foo()`.

不妨运行这个例子。
你会看到一条包含 `foo()` 的 "last stack" 追踪（`lastStackTrace`），
因为 `foo()` 是同步调用的。
下一条栈追踪（`stackTrace`）来自异步上下文，
它知道 `bar()`，但不知道 `foo()`。


### Implementing asynchronous callbacks

### 实现异步回调

Even if you're implementing an asynchronous API,
you might not have to deal with zones at all.
For example, although you might expect the dart:io library
to keep track of the current zones,
it instead relies on the zone handling of dart:async classes
such as Future and Stream.

即使你在实现异步 API，
也可能完全不必亲自处理区域。
例如，你也许以为 dart:io 库会跟踪当前区域，
实际上它依赖 dart:async 中 Future 和 Stream 等类的区域处理。

If you do handle zones explicitly,
then you need to register all asynchronous callbacks
and ensure that each callback is invoked in the zone
where it was registered.
The `bind*Callback` helper methods of Zone
make this task easier.
They're shortcuts for `register*Callback` and `run*`,
ensuring that each callback is registered and runs in that Zone.

如果确实要显式处理区域，
就需要注册所有异步回调，
并确保每个回调都在它被注册的那个区域中调用。
Zone 的 `bind*Callback` 辅助方法可以简化这件事。
它们是 `register*Callback` 和 `run*` 的快捷方式，
确保每个回调都在该 Zone 中注册并运行。

If you need more control than `bind*Callback` gives you,
then you need to use `register*Callback` and `run*`.
You might also want to use the `run*Guarded` methods of Zone,
which wrap the call into a try-catch
and invoke the `uncaughtErrorHandler`
if an error occurs.

如果需要比 `bind*Callback` 更多的控制，
就得使用 `register*Callback` 和 `run*`。
你可能还想使用 Zone 的 `run*Guarded` 方法，
它们把调用包进 try-catch，
并在发生错误时调用 `uncaughtErrorHandler`。


## Summary

## 小结

Zones are good for protecting your code from
uncaught exceptions in asynchronous code,
but they can do much more.
You can associate data with zones,
and you can override core functionality such as
printing and task scheduling.
Zones enable better debugging and provide hooks
that you can use for functionality such as profiling.

区域很适合保护代码，
使其不受异步代码中未捕获异常的影响，
但它们能做的远不止这些。
你可以把数据关联到区域，
也可以覆盖打印和任务调度等核心功能。
区域能改善调试，并提供可用于性能分析等功能的钩子。


### More resources

### 更多资源

Zone-related API documentation
: Read the docs for
  [runZoned()]({{site.dart-api}}/dart-async/runZoned.html),
  [runZonedGuarded()]({{site.dart-api}}/dart-async/runZonedGuarded.html),
  [Zone]({{site.dart-api}}/dart-async/Zone-class.html),
  [ZoneDelegate]({{site.dart-api}}/dart-async/ZoneDelegate-class.html), and
  [ZoneSpecification]({{site.dart-api}}/dart-async/ZoneSpecification-class.html).

  阅读
  [runZoned()]({{site.dart-api}}/dart-async/runZoned.html)、
  [runZonedGuarded()]({{site.dart-api}}/dart-async/runZonedGuarded.html)、
  [Zone]({{site.dart-api}}/dart-async/Zone-class.html)、
  [ZoneDelegate]({{site.dart-api}}/dart-async/ZoneDelegate-class.html) 和
  [ZoneSpecification]({{site.dart-api}}/dart-async/ZoneSpecification-class.html)
  的文档。

stack_trace
: With the stack_trace library's
  [Chain class]({{site.pub-api}}/stack_trace/latest/stack_trace/Chain-class.html)
  you can get better stack traces for asynchronously executed code.
  See the [stack_trace package]({{site.pub-pkg}}/stack_trace)
  at the pub.dev site for more information.

  借助 stack_trace 库的
  [Chain 类]({{site.pub-api}}/stack_trace/latest/stack_trace/Chain-class.html)，
  可以为异步执行的代码得到更好的栈追踪。
  更多信息见 pub.dev 上的
  [stack_trace package]({{site.pub-pkg}}/stack_trace)。


### More examples

### 更多示例

Here are some more complex examples of using zones.

下面是一些更复杂的区域使用示例。

The task_interceptor example
: The toy zone in
  [task_interceptor.dart](https://github.com/dart-archive/www.dartlang.org/blob/master/src/tests/site/articles/zones/task_interceptor.dart)
  intercepts `scheduleMicrotask`, `createTimer`, and `createPeriodicTimer`
  to simulate the behavior of the Dart primitives
  without yielding to the event loop.

  [task_interceptor.dart](https://github.com/dart-archive/www.dartlang.org/blob/master/src/tests/site/articles/zones/task_interceptor.dart)
  中的示例区域会拦截 `scheduleMicrotask`、`createTimer` 和 `createPeriodicTimer`，
  以便在不让出事件循环的情况下模拟 Dart 原语的行为。

The source code for the stack_trace package
: The [stack_trace package]({{site.pub-pkg}}/stack_trace)
  uses zones to form chains of stack traces
  for debugging asynchronous code.
  Zone features used include error handling, zone-local values, and callbacks.
  You can find the stack_trace source code in the
  [stack_trace GitHub project]({{site.repo.dart.org}}/stack_trace).

  [stack_trace package]({{site.pub-pkg}}/stack_trace)
  使用区域把栈追踪串成链，以便调试异步代码。
  用到的区域特性包括错误处理、区域局部值和回调。
  stack_trace 的源代码见
  [stack_trace GitHub 项目]({{site.repo.dart.org}}/stack_trace)。

The source code for dart:async
: These two SDK libraries implement APIs featuring asynchronous callbacks,
  and thus they deal with zones.
  You can browse or download their source code under the
  [sdk/lib directory]({{site.repo.dart.sdk}}/tree/main/sdk/lib)
  of the
  [Dart GitHub project]({{site.repo.dart.sdk}}).

  这两个 SDK 库实现了带异步回调的 API，因此会处理区域。
  可以在 [Dart GitHub 项目]({{site.repo.dart.sdk}}) 的
  [sdk/lib 目录]({{site.repo.dart.sdk}}/tree/main/sdk/lib)
  下浏览或下载它们的源代码。


_Thanks to Anders Johnsen and Lasse Reichstein Nielsen
for their reviews of this article._

**感谢 Anders Johnsen 和 Lasse Reichstein Nielsen 审阅本文。**
