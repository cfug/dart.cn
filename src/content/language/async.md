---
# title: Asynchronous programming
title: 异步编程
# description: Information on writing asynchronous code in Dart.
description: 关于在 Dart 中编写异步代码的信息。
# shortTitle: Async programming
shortTitle: 异步编程
prevpage:
  url: /language/concurrency
  # title: Concurrency
  title: 并发
nextpage:
  url: /language/isolates
  # title: Isolates
  title: Isolate
---

<?code-excerpt replace="/ *\/\/\s+ignore_for_file:[^\n]+\n//g; /(^|\n) *\/\/\s+ignore:[^\n]+\n/$1/g; /(\n[^\n]+) *\/\/\s+ignore:[^\n]+\n/$1\n/g; / *\/\/\s+ignore:[^\n]+//g; /([A-Z]\w*)\d\b/$1/g"?>

Dart libraries are full of functions that
return [`Future`][] or [`Stream`][] objects.
These functions are _asynchronous_:
they return after setting up
a possibly time-consuming operation
(such as I/O),
without waiting for that operation to complete.

Dart 库中充满了返回 [`Future`][] 或 [`Stream`][] 对象的函数。
这些函数是 _异步的_：
它们在设置可能耗时的操作（如 I/O）后返回，
而不等待该操作完成。

The `async` and `await` keywords support asynchronous programming,
letting you write asynchronous code that
looks similar to synchronous code.

`async` 和 `await` 关键字支持异步编程，
让你可以编写看起来类似于同步代码的异步代码。


## Handling Futures

## 处理 Future

When you need the result of a completed Future,
you have two options:

当你需要已完成 Future 的结果时，你有两个选择：

* Use `async` and `await`, as described here and in the
  [asynchronous programming tutorial](/libraries/async/async-await).
* Use the Future API, as described in the
  [`dart:async` documentation](/libraries/dart-async#future).

* 使用 `async` 和 `await`，如此处和
  [异步编程教程](/libraries/async/async-await)中所述。
* 使用 Future API，如
  [`dart:async` 文档](/libraries/dart-async#future)中所述。

Code that uses `async` and `await` is asynchronous,
but it looks a lot like synchronous code.
For example, here's some code that uses `await`
to wait for the result of an asynchronous function:

使用 `async` 和 `await` 的代码是异步的，
但它看起来很像同步代码。
例如，下面是一些使用 `await` 等待异步函数结果的代码：

<?code-excerpt "misc/lib/language_tour/async.dart (await-look-up-version)"?>
```dart
await lookUpVersion();
```

To use `await`, code must be in an `async` function—a
function marked as `async`:

要使用 `await`，代码必须在 `async` 函数中——
即标记为 `async` 的函数：

<?code-excerpt "misc/lib/language_tour/async.dart (checkVersion)" replace="/async|await/[!$&!]/g"?>
```dart
Future<void> checkVersion() [!async!] {
  var version = [!await!] lookUpVersion();
  // Do something with version
}
```

:::note
Although an `async` function might perform time-consuming operations,
it doesn't wait for those operations.
Instead, the `async` function executes only
until it encounters its first `await` expression.
Then it returns a `Future` object,
resuming execution only after the `await` expression completes.

尽管 `async` 函数可能执行耗时的操作，
但它不会等待这些操作。
相反，`async` 函数只执行到遇到第一个 `await` 表达式为止。
然后它返回一个 `Future` 对象，
仅在 `await` 表达式完成后才恢复执行。
:::

Use `try`, `catch`, and `finally` to handle errors and cleanup
in code that uses `await`:

使用 `try`、`catch` 和 `finally` 来处理使用 `await` 的代码中的
错误和清理工作：

<?code-excerpt "misc/lib/language_tour/async.dart (try-catch)"?>
```dart
try {
  version = await lookUpVersion();
} catch (e) {
  // React to inability to look up the version
}
```

You can use `await` multiple times in an `async` function.
For example, the following code waits three times
for the results of functions:

你可以在 `async` 函数中多次使用 `await`。
例如，以下代码等待三次函数的结果：

<?code-excerpt "misc/lib/language_tour/async.dart (repeated-await)"?>
```dart
var entrypoint = await findEntryPoint();
var exitCode = await runExecutable(entrypoint, args);
await flushThenExit(exitCode);
```

In <code>await <em>expression</em></code>,
the value of <code><em>expression</em></code> is usually a Future;
if it isn't, then the value is automatically wrapped in a Future.
This Future object indicates a promise to return an object.
The value of <code>await <em>expression</em></code> is that returned object.
The await expression makes execution pause until that object is available.

在 <code>await <em>expression</em></code> 中，
<code><em>expression</em></code> 的值通常是一个 Future；
如果不是，那么该值会自动包装在一个 Future 中。
这个 Future 对象表示承诺返回一个对象。
<code>await <em>expression</em></code> 的值就是返回的对象。
await 表达式使执行暂停，直到该对象可用。

**If you get a compile-time error when using `await`,
make sure `await` is in an `async` function.**
For example, to use `await` in your app's `main()` function,
the body of `main()` must be marked as `async`:

**如果在使用 `await` 时遇到编译时错误，
请确保 `await` 在 `async` 函数中。**
例如，要在应用的 `main()` 函数中使用 `await`，
`main()` 的函数体必须标记为 `async`：

<?code-excerpt "misc/lib/language_tour/async.dart (main)" replace="/async|await/[!$&!]/g"?>
```dart
void main() [!async!] {
  checkVersion();
  print('In main: version is ${[!await!] lookUpVersion()}');
}
```

:::note
The preceding example uses an `async` function (`checkVersion()`)
without waiting for a result—a practice that can cause problems
if the code assumes that the function has finished executing.
To avoid this problem,
use the [unawaited_futures linter rule][].

前面的示例使用了 `async` 函数（`checkVersion()`）
而没有等待结果——如果代码假设该函数已完成执行，
这种做法可能会导致问题。
为避免此问题，
请使用 [unawaited_futures linter 规则][unawaited_futures linter rule]。
:::

For an interactive introduction to using futures, `async`, and `await`,
see the [asynchronous programming tutorial](/libraries/async/async-await).

有关使用 Future、`async` 和 `await` 的交互式介绍，
请参阅[异步编程教程](/libraries/async/async-await)。


## Declaring async functions

## 声明 async 函数

An `async` function is a function whose body is marked with
the `async` modifier.

`async` 函数是其函数体标记有 `async` 修饰符的函数。

Adding the `async` keyword to a function makes it return a Future.
For example, consider this synchronous function,
which returns a String:

将 `async` 关键字添加到函数会使其返回一个 Future。
例如，考虑这个返回 String 的同步函数：

<?code-excerpt "misc/lib/language_tour/async.dart (sync-look-up-version)"?>
```dart
String lookUpVersion() => '1.0.0';
```

If you change it to be an `async` function—for example,
because a future implementation will be time consuming—the
returned value is a Future:

如果你将它改为 `async` 函数——例如，
因为未来的实现将是耗时的——返回值就是一个 Future：

<?code-excerpt "misc/lib/language_tour/async.dart (async-look-up-version)"?>
```dart
Future<String> lookUpVersion() async => '1.0.0';
```

Note that the function's body doesn't need to use the Future API.
Dart creates the Future object if necessary.
If your function doesn't return a useful value,
make its return type `Future<void>`.

请注意，函数体不需要使用 Future API。
Dart 会在必要时创建 Future 对象。
如果你的函数不返回有用的值，
请将其返回类型设为 `Future<void>`。

For an interactive introduction to using futures, `async`, and `await`,
see the [asynchronous programming tutorial](/libraries/async/async-await).

有关使用 Future、`async` 和 `await` 的交互式介绍，
请参阅[异步编程教程](/libraries/async/async-await)。

{% comment %}
TODO #1117: Where else should we cover generalized void?
{% endcomment %}


## Handling Streams

## 处理 Stream

When you need to get values from a Stream,
you have two options:

当你需要从 Stream 获取值时，你有两个选择：

* Use `async` and an _asynchronous for loop_ (`await for`).
* Use the Stream API, as described in the
  [`dart:async` documentation](/libraries/dart-async#stream).

* 使用 `async` 和 _异步 for 循环_（`await for`）。
* 使用 Stream API，如
  [`dart:async` 文档](/libraries/dart-async#stream)中所述。

:::note
Before using `await for`, be sure that it makes the code clearer and that you
really do want to wait for all of the stream's results. For example, you
usually should **not** use `await for` for UI event listeners, because UI
frameworks send endless streams of events.

在使用 `await for` 之前，请确保它使代码更清晰，
并且你确实想要等待 stream 的所有结果。
例如，你通常**不应该**对 UI 事件监听器使用 `await for`，
因为 UI 框架会发送无尽的事件流。
:::

An asynchronous for loop has the following form:

异步 for 循环具有以下形式：

<?code-excerpt "misc/lib/language_tour/async.dart (await-for)"?>
```dart
await for (varOrType identifier in expression) {
  // Executes each time the stream emits a value.
}
```

The value of <code><em>expression</em></code> must have type Stream.
Execution proceeds as follows:

<code><em>expression</em></code> 的值必须是 Stream 类型。
执行过程如下：

1. Wait until the stream emits a value.
2. Execute the body of the for loop,
   with the variable set to that emitted value.
3. Repeat 1 and 2 until the stream is closed.

1. 等待 stream 发出一个值。
2. 执行 for 循环的主体，将变量设置为发出的值。
3. 重复 1 和 2，直到 stream 关闭。

To stop listening to the stream,
you can use a `break` or `return` statement,
which breaks out of the for loop
and unsubscribes from the stream.

要停止监听 stream，
你可以使用 `break` 或 `return` 语句，
这将跳出 for 循环并取消订阅 stream。

**If you get a compile-time error when implementing an asynchronous for loop,
make sure the `await for` is in an `async` function.**
For example, to use an asynchronous for loop in your app's `main()` function,
the body of `main()` must be marked as `async`:

**如果在实现异步 for 循环时遇到编译时错误，
请确保 `await for` 在 `async` 函数中。**
例如，要在应用的 `main()` 函数中使用异步 for 循环，
`main()` 的函数体必须标记为 `async`：

<?code-excerpt "misc/lib/language_tour/async.dart (number-thinker)" replace="/async|await for/[!$&!]/g"?>
```dart
void main() [!async!] {
  // ...
  [!await for!] (final request in requestServer) {
    handleRequest(request);
  }
  // ...
}
```

For more information about Dart's asynchronous programming support,
check out the [`dart:async`](/libraries/dart-async) library documentation.

有关 Dart 异步编程支持的更多信息，
请查看 [`dart:async`](/libraries/dart-async) 库文档。

[`Future`]: {{site.dart-api}}/dart-async/Future-class.html
[`Stream`]: {{site.dart-api}}/dart-async/Stream-class.html
[unawaited_futures linter rule]: /tools/linter-rules/unawaited_futures
