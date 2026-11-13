---
# title: dart:async
title: dart:async
# description: Learn about the major features in Dart's dart:async library.
description: 了解 Dart dart:async 库的主要功能。
prevpage:
  url: /libraries/dart-core
# title: dart:core
  title: dart:core
nextpage:
  url: /libraries/dart-math
# title: dart:math
  title: dart:math
ai-translated: true
---

<?code-excerpt replace="/ *\/\/\s+ignore_for_file:[^\n]+\n//g; /(^|\n) *\/\/\s+ignore:[^\n]+\n/$1/g; /(\n[^\n]+) *\/\/\s+ignore:[^\n]+\n/$1\n/g"?>
<?code-excerpt plaster="none"?>

Asynchronous programming often uses callback functions, but Dart
provides alternatives: [Future][] and [Stream][] objects. A
Future is like a promise for a result to be provided sometime in the
future. A Stream is a way to get a sequence of values, such as events.
Future, Stream, and more are in the
dart:async library ([API reference][dart:async]).

异步编程常常使用回调函数，但 Dart 提供了替代方案：
[Future][Future] 和 [Stream][Stream] 对象。
Future 像是一份承诺，表示将来某个时刻会给出结果。
Stream 用来获取一系列值，例如事件。
Future、Stream 以及更多类型都在
dart:async 库（[API 参考][dart:async]）中。

:::note
You don't always need to use the Future or Stream APIs directly.
The Dart language supports asynchronous coding using
keywords such as `async` and `await`.
Check out the [asynchronous programming tutorial](/libraries/async/async-await)
for details.

你并不总是需要直接使用 Future 或 Stream API。
Dart 语言支持用 `async` 和 `await` 等关键字编写异步代码。
详情请参阅 [异步编程教程](/libraries/async/async-await)。
:::

The dart:async library works in both web apps and command-line apps. To
use it, import dart:async:

dart:async 库可用于 Web 应用和命令行应用。
要使用它，请导入 dart:async：

<?code-excerpt "misc/lib/library_tour/async/future.dart (import)"?>
```dart
import 'dart:async';
```

:::tip
You don't need to import dart:async to use the Future and
Stream APIs, because dart:core exports those classes.

使用 Future 和 Stream API 时不必导入 dart:async，
因为 dart:core 会导出这些类。
:::

## Future

## Future 类

Future objects appear throughout the Dart libraries, often as the object
returned by an asynchronous method. When a future *completes*, its value
is ready to use.

Future 对象遍布 Dart 库，常常作为异步方法的返回值。
当 Future **完成** 时，它的值就可以使用了。


### Using await

### 使用 await

Before you directly use the Future API, consider using `await` instead.
Code that uses `await` expressions can be easier to understand
than code that uses the Future API.

在直接使用 Future API 之前，可以考虑改用 `await`。
使用 `await` 表达式的代码，
往往比使用 Future API 的代码更容易理解。

Consider the following function.  It uses Future's `then()` method
to execute three asynchronous functions in a row,
waiting for each one to complete before executing the next one.

看下面这个函数。它使用 Future 的 `then()` 方法
依次执行三个异步函数，
等前一个完成后再执行下一个。

<?code-excerpt "misc/lib/library_tour/async/future.dart (run-using-future)"?>
```dart
void runUsingFuture() {
  // ...
  findEntryPoint()
      .then((entryPoint) {
        return runExecutable(entryPoint, args);
      })
      .then(flushThenExit);
}
```

The equivalent code with await expressions
looks more like synchronous code:

使用 await 表达式的等价代码更接近同步代码：

<?code-excerpt "misc/lib/library_tour/async/future.dart (run-using-async-await)"?>
```dart
Future<void> runUsingAsyncAwait() async {
  // ...
  var entryPoint = await findEntryPoint();
  var exitCode = await runExecutable(entryPoint, args);
  await flushThenExit(exitCode);
}
```

An `async` function can catch exceptions from Futures.
For example:

`async` 函数可以捕获来自 Future 的异常。例如：

<?code-excerpt "misc/lib/library_tour/async/future.dart (catch)"?>
```dart
var entryPoint = await findEntryPoint();
try {
  var exitCode = await runExecutable(entryPoint, args);
  await flushThenExit(exitCode);
} catch (e) {
  // Handle the error...
}
```

:::important
Async functions return Futures. If you don't want your function to return a
future, then use a different solution. For example, you might call an `async`
function from your function.

异步函数返回 Future。
如果你不希望自己的函数返回 Future，请换一种做法。
例如，可以在你的函数里调用一个 `async` 函数。
:::

For more information on using `await` and related Dart language features,
see the [asynchronous programming tutorial](/libraries/async/async-await).

关于 `await` 及相关 Dart 语言特性的更多信息，
请参阅 [异步编程教程](/libraries/async/async-await)。


### Basic usage

### 基本用法

You can use `then()` to schedule code that runs when the future completes. For
example, [`Client.read()`][] returns a Future, since HTTP requests
can take a while. Using `then()` lets you run some code when that Future
has completed and the promised string value is available:

可以用 `then()` 安排在 Future 完成时运行的代码。
例如，[`Client.read()`][] 返回 Future，因为 HTTP 请求可能需要一些时间。
使用 `then()` 可以在该 Future 完成、承诺的字符串值可用时运行一段代码：

<?code-excerpt "misc/lib/library_tour/async/basic.dart (then)"?>
```dart
httpClient.read(url).then((String result) {
  print(result);
});
```

Use `catchError()` to handle any errors or exceptions that a Future
object might throw.

使用 `catchError()` 处理 Future 对象可能抛出的错误或异常。

<?code-excerpt "misc/lib/library_tour/async/basic.dart (catch-error)"?>
```dart
httpClient
    .read(url)
    .then((String result) {
      print(result);
    })
    .catchError((e) {
      // Handle or ignore the error.
    });
```

The `then().catchError()` pattern is the asynchronous version of
`try`-`catch`.

`then().catchError()` 模式是 `try`-`catch` 的异步版本。

:::important
Be sure to invoke `catchError()` on the result of `then()`—not on
the result of the original `Future`. Otherwise, the
`catchError()` can handle errors only from the original Future's computation,
but not from the handler registered by `then()`.

请务必在 `then()` 的结果上调用 `catchError()`，
而不是在原来那个 `Future` 的结果上调用。
否则，`catchError()` 只能处理原来那个 Future 计算中的错误，
处理不了 `then()` 所注册的处理器里的错误。
:::

[`Client.read()`]: {{site.pub-api}}/http/latest/http/Client/read.html

### Chaining multiple asynchronous methods

### 链式调用多个异步方法

The `then()` method returns a Future, providing a useful way to run
multiple asynchronous functions in a certain order. 
If the callback registered with `then()` returns a Future, 
`then()` returns a Future that will complete
with the same result as the Future returned from the callback. 
If the callback returns a value of any other type,
`then()` creates a new Future that completes with the value.

`then()` 方法返回一个 Future，
可以用来按特定顺序运行多个异步函数。
如果注册到 `then()` 的回调返回 Future，
`then()` 返回的 Future 会以该回调所返回 Future 的同样结果完成。
如果回调返回其他类型的值，
`then()` 会创建一个以该值完成的新 Future。

<?code-excerpt "misc/lib/library_tour/async/future.dart (then-chain)"?>
```dart
Future result = costlyQuery(url);
result
    .then((value) => expensiveWork(value))
    .then((_) => lengthyComputation())
    .then((_) => print('Done!'))
    .catchError((exception) {
      /* Handle exception... */
    });
```

In the preceding example, the methods run in the following order:

在上面的例子中，这些方法按以下顺序运行：

1.  `costlyQuery()`

    `costlyQuery()`

2.  `expensiveWork()`

    `expensiveWork()`

3.  `lengthyComputation()`

    `lengthyComputation()`

Here is the same code written using await:

下面是用 await 改写的同一段代码：

<?code-excerpt "misc/lib/library_tour/async/future.dart (then-chain-as-await)"?>
```dart
try {
  final value = await costlyQuery(url);
  await expensiveWork(value);
  await lengthyComputation();
  print('Done!');
} catch (e) {
  /* Handle exception... */
}
```


### Waiting for multiple futures

### 等待多个 Future

Sometimes your algorithm needs to invoke many asynchronous functions and
wait for them all to complete before continuing. Use the [Future.wait()][]
static method to manage multiple Futures and wait for them to complete:

有时算法需要调用许多异步函数，
并等它们全部完成后再继续。
使用静态方法 [Future.wait()][Future.wait()]
管理多个 Future 并等待它们完成：

<?code-excerpt "misc/lib/library_tour/async/future.dart (wait)" replace="/elideBody;/\/* ... *\//g"?>
```dart
Future<void> deleteLotsOfFiles() async =>  ...
Future<void> copyLotsOfFiles() async =>  ...
Future<void> checksumLotsOfOtherFiles() async =>  ...

await Future.wait([
  deleteLotsOfFiles(),
  copyLotsOfFiles(),
  checksumLotsOfOtherFiles(),
]);
print('Done with all the long steps!');
```

`Future.wait()` returns a future which completes once all the provided
futures have completed. It completes either with their results,
or with an error if any of the provided futures fail. 

`Future.wait()` 返回一个 Future，
它在所提供的 Future 全部完成后完成。
它会以这些结果完成，
或者在其中任何一个失败时以错误完成。

### Handling errors for multiple futures

### 处理多个 Future 的错误

You can also wait for parallel operations on:

也可以在以下对象上等待并行操作：

* An [iterable][iterable-futures] of futures

  Future 的 [Iterable][iterable-futures]

* A [record][record-futures] with futures as positional fields

  以 Future 作为位置字段的 [record][record-futures]

These extensions return a `Future` with the
resulting values of all provided futures.
Unlike `Future.wait`, they also let you handle errors.

这些扩展返回一个 `Future`，其中包含所提供的全部 Future 的结果值。
与 `Future.wait` 不同，它们还让你可以处理错误。

If any future in the collection completes with an error,
`wait` completes with a [`ParallelWaitError`][].
This allows the caller to handle individual errors and
dispose of successful results if necessary.

如果集合中任何一个 Future 以错误完成，
`wait` 会以 [`ParallelWaitError`][] 完成。
这样调用方可以分别处理各个错误，
并在需要时释放已经成功的结果。

When you _don't_ need the result values from each future,
use `wait` on an _iterable_ of futures:

当你 **不** 需要每个 Future 的结果值时，
对 Future 的 **Iterable** 使用 `wait`：

```dart
Future<int> delete() async => ...;
Future<String> copy() async => ...;
Future<bool> errorResult() async => ...;

void main() async {
  try {
    // Wait for each future in a list, returns a list of futures:
    var results = await [delete(), copy(), errorResult()].wait;
  } on ParallelWaitError<List<bool?>, List<AsyncError?>> catch (e) {
    print(e.values[0]);    // Prints successful future
    print(e.values[1]);    // Prints successful future
    print(e.values[2]);    // Prints null when the result is an error

    print(e.errors[0]);    // Prints null when the result is successful
    print(e.errors[1]);    // Prints null when the result is successful
    print(e.errors[2]);    // Prints error
  }
}
```

When you _do_ need the individual result values from each future,
use `wait` on a _record_ of futures.
This provides the additional benefit that the futures can be of different types:

当你 **确实** 需要每个 Future 各自的结果值时，
对 Future 的 **record** 使用 `wait`。
这样做还有一个好处：这些 Future 可以是不同的类型：

```dart
Future<int> delete() async => ...;
Future<String> copy() async => ...;
Future<bool> errorResult() async => ...;

void main() async {
  try {
    // Wait for each future in a record.
    // Returns a record of futures that you can destructure.
    final (deleteInt, copyString, errorBool) =
        await (delete(), copy(), errorResult()).wait;

    // Do something with the results...
  } on ParallelWaitError<
    (int?, String?, bool?),
    (AsyncError?, AsyncError?, AsyncError?)
  > catch (e) {
    // ...
  }
}
```

[iterable-futures]: {{site.dart-api}}/dart-async/FutureIterable/wait.html
[record-futures]: {{site.dart-api}}/dart-async/FutureRecord2/wait.html

## Stream

## Stream 类

Stream objects appear throughout Dart APIs, representing sequences of
data. For example, HTML events such as button clicks are delivered using
streams. You can also read a file as a stream.

Stream 对象遍布 Dart API，表示数据序列。
例如，按钮点击等 HTML 事件通过 Stream 传递。
也可以把文件当作 Stream 来读取。


### Using an asynchronous for loop

### 使用异步 for 循环

Sometimes you can use an asynchronous for loop (`await for`)
instead of using the Stream API.

有时可以用异步 for 循环（`await for`）代替 Stream API。

Consider the following function.
It uses Stream's `listen()` method
to subscribe to a list of files,
passing in a function literal that searches each file or directory.

看下面这个函数。
它使用 Stream 的 `listen()` 方法订阅文件列表，
并传入一个函数字面量来搜索每个文件或目录。

<?code-excerpt "misc/lib/library_tour/async/stream.dart (listen)" replace="/listen/[!$&!]/g"?>
```dart
void main(List<String> arguments) {
  // ...
  FileSystemEntity.isDirectory(searchPath).then((isDir) {
    if (isDir) {
      final startingDir = Directory(searchPath);
      startingDir.list().[!listen!]((entity) {
        if (entity is File) {
          searchFile(entity, searchTerms);
        }
      });
    } else {
      searchFile(File(searchPath), searchTerms);
    }
  });
}
```

The equivalent code with await expressions,
including an asynchronous for loop (`await for`),
looks more like synchronous code:

使用 await 表达式（包括异步 for 循环 `await for`）的等价代码
更接近同步代码：

<?code-excerpt "misc/lib/library_tour/async/stream.dart (await-for)" replace="/await for/[!$&!]/g"?>
```dart
void main(List<String> arguments) async {
  // ...
  if (await FileSystemEntity.isDirectory(searchPath)) {
    final startingDir = Directory(searchPath);
    [!await for!] (final entity in startingDir.list()) {
      if (entity is File) {
        searchFile(entity, searchTerms);
      }
    }
  } else {
    searchFile(File(searchPath), searchTerms);
  }
}
```

:::important
Before using `await for`, make sure that it makes the code clearer and that
you really do want to wait for all of the stream's results. For example, you
usually should **not** use `await for` for DOM event listeners, because the
DOM sends endless streams of events. If you use `await for` to register two
DOM event listeners in a row, then the second kind of event is never handled.

使用 `await for` 之前，请确认它能让代码更清晰，
并且你确实想等待 Stream 的全部结果。
例如，通常 **不** 应该对 DOM 事件监听器使用 `await for`，
因为 DOM 会发送无尽的事件 Stream。
如果用 `await for` 连续注册两种 DOM 事件监听器，
第二种事件就永远不会被处理。
:::

For more information on using `await` and related
Dart language features, see the
[asynchronous programming tutorial](/libraries/async/async-await).

关于 `await` 及相关 Dart 语言特性的更多信息，
请参阅 [异步编程教程](/libraries/async/async-await)。


### Listening for stream data

### 监听 Stream 数据

To get each value as it arrives, either use `await for` or
subscribe to the stream using the `listen()` method:

要在每个值到达时取得它，
可以使用 `await for`，也可以用 `listen()` 方法订阅 Stream：

<?code-excerpt "misc/lib/library_tour/async/stream_web.dart (listen)" replace="/listen/[!$&!]/g"?>
```dart
// Add an event handler to a button.
submitButton.onClick.[!listen!]((e) {
  // When the button is clicked, it runs this code.
  submitData();
});
```

In this example, the `onClick` property is a `Stream` object provided by
the submit button.

在这个例子中，`onClick` 属性是提交按钮提供的 `Stream` 对象。

If you care about only one event, you can get it using a property such
as `first`, `last`, or `single`. To test the event before handling it,
use a method such as `firstWhere()`, `lastWhere()`, or `singleWhere()`.
{% comment %}
{PENDING: example}
{% endcomment %}

如果只关心一个事件，可以用 `first`、`last` 或 `single` 等属性取得它。
要在处理前先检验事件，
可以使用 `firstWhere()`、`lastWhere()` 或 `singleWhere()` 等方法。

If you care about a subset of events, you can use methods such as
`skip()`, `skipWhile()`, `take()`, `takeWhile()`, and `where()`.
{% comment %}
{PENDING: example}
{% endcomment %}

如果只关心一部分事件，可以使用 `skip()`、`skipWhile()`、
`take()`、`takeWhile()` 和 `where()` 等方法。


### Transforming stream data

### 转换 Stream 数据

Often, you need to change the format of a stream's data before you can
use it. Use the `transform()` method to produce a stream with a
different type of data:

使用之前，常常需要改变 Stream 数据的格式。
使用 `transform()` 方法可以得到数据类型不同的 Stream：

<?code-excerpt "misc/lib/library_tour/async/stream.dart (transform)"?>
```dart
var lines = inputStream
    .transform(utf8.decoder)
    .transform(const LineSplitter());
```

This example uses two transformers. First it uses utf8.decoder to
transform the stream of integers into a stream of strings. Then it uses
a LineSplitter to transform the stream of strings into a stream of
separate lines. These transformers are from the dart:convert library (see the
[dart:convert section](/libraries/dart-convert)).
{% comment %}
  PENDING: add onDone and onError. (See "Streaming file contents".)
{% endcomment %}

这个例子使用了两个转换器。
首先用 utf8.decoder 把整数 Stream 转换成字符串 Stream。
然后用 LineSplitter 把字符串 Stream 转换成一行行独立的 Stream。
这些转换器来自 dart:convert 库
（见 [dart:convert 一节](/libraries/dart-convert)）。


### Handling errors and completion

### 处理错误与完成

How you specify error and completion handling code
depends on whether you use an asynchronous for loop (`await for`)
or the Stream API.

如何指定错误处理和完成处理代码，
取决于你使用的是异步 for 循环（`await for`）还是 Stream API。

If you use an asynchronous for loop,
then use try-catch to handle errors.
Code that executes after the stream is closed
goes after the asynchronous for loop.

如果使用异步 for 循环，请用 try-catch 处理错误。
Stream 关闭之后要执行的代码，放在异步 for 循环之后。

<?code-excerpt "misc/lib/library_tour/async/stream.dart (read-file-await-for)" replace="/try|catch/[!$&!]/g"?>
```dart
Future<void> readFileAwaitFor() async {
  var config = File('config.txt');
  Stream<List<int>> inputStream = config.openRead();

  var lines = inputStream
      .transform(utf8.decoder)
      .transform(const LineSplitter());
  [!try!] {
    await for (final line in lines) {
      print('Got ${line.length} characters from stream');
    }
    print('file is now closed');
  } [!catch!] (e) {
    print(e);
  }
}
```

If you use the Stream API,
then handle errors by registering an `onError` listener.
Run code after the stream is closed by registering
an `onDone` listener.

如果使用 Stream API，
请注册 `onError` 监听器来处理错误。
注册 `onDone` 监听器，以便在 Stream 关闭后运行代码。

<?code-excerpt "misc/lib/library_tour/async/stream.dart (on-done)" replace="/onDone|onError/[!$&!]/g"?>
```dart
var config = File('config.txt');
Stream<List<int>> inputStream = config.openRead();

inputStream
    .transform(utf8.decoder)
    .transform(const LineSplitter())
    .listen(
      (String line) {
        print('Got ${line.length} characters from stream');
      },
      [!onDone!]: () {
        print('file is now closed');
      },
      [!onError!]: (e) {
        print(e);
      },
    );
```


## More information

## 更多信息

For some examples of using Future and Stream in command-line apps,
check out the [dart:io documentation][].
Also see these articles and tutorials:

命令行应用中使用 Future 和 Stream 的一些例子，
请参阅 [dart:io 文档][dart:io documentation]。
另见以下文章和教程：

- [Asynchronous programming: futures, async, await](/libraries/async/async-await)

  [异步编程：Future、async 和 await](/libraries/async/async-await)

- [Futures and error handling](/libraries/async/futures-error-handling)

  [Future 和错误处理](/libraries/async/futures-error-handling)

- [Asynchronous programming: streams](/libraries/async/using-streams)

  [异步编程：Stream](/libraries/async/using-streams)

- [Creating streams in Dart](/libraries/async/creating-streams)

  [在 Dart 中创建 Stream](/libraries/async/creating-streams)

- [Dart asynchronous programming: Isolates and event loops](/language/concurrency)

  [Dart 异步编程：isolate 和事件循环](/language/concurrency)


[Future.wait()]: {{site.dart-api}}/dart-async/Future/wait.html
[Future]: {{site.dart-api}}/dart-async/Future-class.html
[`ParallelWaitError`]: {{site.dart-api}}/dart-async/ParallelWaitError-class.html
[Stream]: {{site.dart-api}}/dart-async/Stream-class.html
[dart:async]: {{site.dart-api}}/dart-async/dart-async-library.html
[dart:io documentation]: /libraries/dart-io
