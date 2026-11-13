---
# title: Futures and error handling
title: Future 和错误处理
# description: >-
#   Everything you wanted to know about handling errors and exceptions
#   when writing asynchronous code. And then some.
description: 编写异步代码时，关于处理错误和异常你想知道的内容，以及更多。
ai-translated: true
---

The Dart language has native
[asynchrony support](/language/async),
making asynchronous Dart code much easier to read and write.
However, some code—especially older code—might still use
[Future methods][Future class]
such as `then()`, `catchError()`, and `whenComplete()`.

Dart 语言原生支持
[异步](/language/async)，
让异步 Dart 代码更容易阅读和编写。
不过，有些代码（尤其是较旧的代码）可能仍在使用
[Future 方法][Future class]，
例如 `then()`、`catchError()` 和 `whenComplete()`。

This page can help you avoid some common pitfalls
when using those Future methods.

本页帮助你在使用这些 Future 方法时避开一些常见陷阱。

:::warning
You don't need this page if your code uses
the language's asynchrony support:
`async`, `await`, and error handling using try-catch.
For more information, see the
[asynchronous programming tutorial](/libraries/async/async-await).

如果代码使用的是语言自带的异步支持：
`async`、`await`，以及用 try-catch 处理错误，
就不需要阅读本页。
更多信息请参阅
[异步编程教程](/libraries/async/async-await)。
:::


## The Future API and callbacks

## Future API 与回调

Functions that use the Future API register callbacks that handle
the value (or the error) that completes a Future. For example:

使用 Future API 的函数会注册回调，
用来处理使 Future 完成的值（或错误）。例如：

<?code-excerpt "futures/lib/simple.dart (then-catch)"?>
```dart
myFunc().then(processValue).catchError(handleError);
```

The registered callbacks fire based on the following rules: `then()`'s
callback fires if it is invoked on a Future that completes with a value;
`catchError()`'s callback fires if it is invoked on a Future that completes
with an error.

已注册的回调按以下规则触发：
如果 `then()` 作用在以值完成的 Future 上，它的回调会触发；
如果 `catchError()` 作用在以错误完成的 Future 上，它的回调会触发。

In the example above, if `myFunc()`'s Future completes with a value,
`then()`'s callback fires. If no new error is produced within `then()`,
`catchError()`'s callback does not fire. On the other hand, if `myFunc()`
completes with an error, `then()`'s callback does not fire, and
`catchError()`'s callback does.

在上面的例子中，如果 `myFunc()` 的 Future 以值完成，
`then()` 的回调会触发。
如果 `then()` 内部没有产生新错误，
`catchError()` 的回调不会触发。
反过来，如果 `myFunc()` 以错误完成，
`then()` 的回调不会触发，
而 `catchError()` 的回调会触发。

## Examples of using then() with catchError()

## 结合使用 then() 与 catchError() 的例子

Chained `then()` and `catchError()` invocations are a common pattern when
dealing with Futures, and can be thought of as the rough equivalent of
try-catch blocks.

链式调用 `then()` 和 `catchError()` 是处理 Future 时的常见模式，
可以大致看成 try-catch 代码块。

The next few sections give examples of this pattern.

接下来几节给出这种模式的例子。

### catchError() as a comprehensive error handler

### 把 catchError() 用作全面的错误处理器

The following example deals with throwing an exception from within `then()`'s
callback and demonstrates `catchError()`'s versatility as an error handler:

下面的例子处理从 `then()` 回调内部抛出异常的情况，
并展示 `catchError()` 作为错误处理器的灵活性：

<?code-excerpt "futures/lib/simple.dart (comprehensive-errors)" replace="/ellipsis\(\);/.../g;"?>
```dart
myFunc()
    .then((value) {
      doSomethingWith(value);
      ...
      throw Exception('Some arbitrary error');
    })
    .catchError(handleError);
```

If `myFunc()`'s Future completes with a value, `then()`'s callback fires. If
code within `then()`'s callback throws (as it does in the example above),
`then()`'s Future completes with an error. That error is handled by
`catchError()`.

如果 `myFunc()` 的 Future 以值完成，`then()` 的回调会触发。
如果 `then()` 回调中的代码抛出异常（如上例），
`then()` 的 Future 会以错误完成。
该错误由 `catchError()` 处理。

If `myFunc()`'s Future completes with an error, `then()`'s Future completes
with that error. The error is also handled by `catchError()`.

如果 `myFunc()` 的 Future 以错误完成，
`then()` 的 Future 也会以该错误完成。
这个错误同样由 `catchError()` 处理。

Regardless of whether the error originated within `myFunc()` or within
`then()`, `catchError()` successfully handles it.

无论错误来自 `myFunc()` 还是 `then()`，
`catchError()` 都能成功处理它。

### Error handling within then()

### 在 then() 内部处理错误

For more granular error handling, you can register a second (`onError`)
callback within `then()` to handle Futures completed with errors. Here is
`then()`'s signature:

如果需要更细粒度的错误处理，
可以在 `then()` 中注册第二个回调（`onError`），
用来处理以错误完成的 Future。
下面是 `then()` 的签名：

<?code-excerpt "futures/lib/simple.dart (future-then)"?>
```dart
Future<R> then<R>(FutureOr<R> Function(T value) onValue, {Function? onError});
```

Register the optional onError callback only if you want to differentiate
between an error forwarded _to_ `then()`, and an error generated _within_
`then()`:

只有在需要区分转发给 `then()` 的错误和在 `then()` **内部** 产生的错误时，
才注册可选的 onError 回调：

<?code-excerpt "futures/lib/simple.dart (throws-then-catch)"?>
```dart
asyncErrorFunction()
    .then(
      successCallback,
      onError: (e) {
        handleError(e); // Original error.
        anotherAsyncErrorFunction(); // Oops, new error.
      },
    )
    .catchError(handleError); // Error from within then() handled.
```

In the example above, `asyncErrorFunction()`'s Future's error is handled with the
`onError` callback; `anotherAsyncErrorFunction()` causes `then()`'s Future to
complete with an error; this error is handled by `catchError()`.

在上面的例子中，`asyncErrorFunction()` 的 Future 的错误由
`onError` 回调处理；
`anotherAsyncErrorFunction()` 使 `then()` 的 Future 以错误完成；
这个错误由 `catchError()` 处理。

In general, implementing two different error handling strategies is not
recommended: register a second callback only if there is a compelling reason
to catch the error within `then()`.

一般来说，不建议同时实现两套错误处理策略：
只有在确有必要于 `then()` 内部捕获错误时，才注册第二个回调。

### Errors in the middle of a long chain

### 长调用链中部的错误

It is common to have a succession of `then()` calls, and catch errors
generated from any part of the chain using `catchError()`:

连续多次调用 `then()`，
并用 `catchError()` 捕获链上任意一处产生的错误，这很常见：

<?code-excerpt "futures/lib/long_chain.dart"?>
```dart
Future<String> one() => Future.value('from one');
Future<String> two() => Future.error('error from two');
Future<String> three() => Future.value('from three');
Future<String> four() => Future.value('from four');

void main() {
  one() // Future completes with "from one".
      .then((_) => two()) // Future completes with two()'s error.
      .then((_) => three()) // Future completes with two()'s error.
      .then((_) => four()) // Future completes with two()'s error.
      .then((value) => value.length) // Future completes with two()'s error.
      .catchError((e) {
        print('Got error: $e'); // Finally, callback fires.
        return 42; // Future completes with 42.
      })
      .then((value) {
        print('The value is $value');
      });
}

// Output of this program:
//   Got error: error from two
//   The value is 42
```

In the code above, `one()`'s Future completes with a value, but `two()`'s
Future completes with an error. When `then()` is invoked on a Future that
completes with an error, `then()`'s callback does not fire. Instead,
`then()`'s Future completes with the error of its receiver. In our example,
this means that after `two()` is called, the Future returned by every
subsequent `then()`completes with `two()`'s error. That error is finally
handled within `catchError()`.

在上面的代码中，`one()` 的 Future 以值完成，
但 `two()` 的 Future 以错误完成。
当 `then()` 作用在以错误完成的 Future 上时，
`then()` 的回调不会触发。
相反，`then()` 的 Future 会以其接收者的错误完成。
在这个例子里，这意味着调用 `two()` 之后，
后续每个 `then()` 返回的 Future 都会以 `two()` 的错误完成。
该错误最终在 `catchError()` 中得到处理。

### Handling specific errors

### 处理特定错误

What if we want to catch a specific error? Or catch more than one error?

如果只想捕获某一种错误呢？或者捕获不止一种错误？

`catchError()` takes an optional named argument, `test`, that
allows us to query the kind of error thrown.

`catchError()` 接受一个可选的命名参数 `test`，
用来查询抛出的是哪一种错误。

<?code-excerpt "futures/lib/simple.dart (future-catch-error)"?>
```dart
Future<T> catchError(Function onError, {bool Function(Object error)? test});
```

Consider `handleAuthResponse(params)`, a function that authenticates a user
based on the params provided, and redirects the user to an appropriate URL.
Given the complex workflow, `handleAuthResponse()` could generate various
errors and exceptions, and you should handle them differently. Here's
how you can use `test` to do that:

考虑 `handleAuthResponse(params)`，
它根据传入的参数认证用户，并把用户重定向到合适的 URL。
由于流程复杂，`handleAuthResponse()` 可能产生各种错误和异常，
你应当分别处理。
可以这样使用 `test`：

<?code-excerpt "futures/lib/simple.dart (auth-response)" replace="/ellipsis\(\)/.../g;"?>
```dart
void main() {
  handleAuthResponse(const {'username': 'dash', 'age': 3})
      .then((_) => ...)
      .catchError(handleFormatException, test: (e) => e is FormatException)
      .catchError(
        handleAuthorizationException,
        test: (e) => e is AuthorizationException,
      );
}
```

## Async try-catch-finally using whenComplete()

## 用 whenComplete() 实现异步 try-catch-finally

If `then().catchError()` mirrors a try-catch, `whenComplete()` is the
equivalent of 'finally'. The callback registered within `whenComplete()` is
called when `whenComplete()`'s receiver completes, whether it does so with a
value or with an error:

如果 `then().catchError()` 对应 try-catch，
那么 `whenComplete()` 就相当于 'finally'。
注册在 `whenComplete()` 中的回调会在其接收者完成时被调用，
无论完成时带的是值还是错误：

<?code-excerpt "futures/lib/simple.dart (connect-server)"?>
```dart
final server = connectToServer();
server
    .post(myUrl, fields: const {'name': 'Dash', 'profession': 'mascot'})
    .then(handleResponse)
    .catchError(handleError)
    .whenComplete(server.close);
```

We want to call `server.close` regardless of whether `server.post()` produces
a valid response, or an error. We ensure this happens by placing it inside
`whenComplete()`.

无论 `server.post()` 产生的是有效响应还是错误，
我们都希望调用 `server.close`。
把它放进 `whenComplete()` 就能保证这一点。

### Completing the Future returned by whenComplete()

### whenComplete() 所返回 Future 的完成方式

If no error is emitted from within `whenComplete()`, its Future completes
the same way as the Future that `whenComplete()` is invoked on. This is
easiest to understand through examples.

如果 `whenComplete()` 内部没有发出错误，
它的 Future 会以与调用 `whenComplete()` 的那个 Future 相同的方式完成。
通过例子最容易理解。

In the code below, `then()`'s Future completes with an error, so
`whenComplete()`'s Future also completes with that error.

在下面的代码中，`then()` 的 Future 以错误完成，
因此 `whenComplete()` 的 Future 也会以该错误完成。

<?code-excerpt "futures/lib/when_complete.dart (with-error)" replace="/withErrorMain/main/g; "?>
```dart
void main() {
  asyncErrorFunction()
      // Future completes with an error:
      .then((_) => print("Won't reach here"))
      // Future completes with the same error:
      .whenComplete(() => print('Reaches here'))
      // Future completes with the same error:
      .then((_) => print("Won't reach here"))
      // Error is handled here:
      .catchError(handleError);
}
```

In the code below, `then()`'s Future completes with an error, which is now
handled by `catchError()`.  Because `catchError()`'s Future completes with
`someObject`, `whenComplete()`'s Future completes with that same object.

在下面的代码中，`then()` 的 Future 以错误完成，
该错误现在由 `catchError()` 处理。
因为 `catchError()` 的 Future 以 `someObject` 完成，
`whenComplete()` 的 Future 也会以同一个对象完成。

<?code-excerpt "futures/lib/when_complete.dart (with-object)" replace="/ellipsis\(\)/.../g; /withObjectMain/main/g; "?>
```dart
void main() {
  asyncErrorFunction()
      // Future completes with an error:
      .then((_) => ...)
      .catchError((e) {
        handleError(e);
        printErrorMessage();
        return someObject; // Future completes with someObject
      })
      .whenComplete(() => print('Done!')); // Future completes with someObject
}
```

### Errors originating within whenComplete()

### 源自 whenComplete() 内部的错误

If `whenComplete()`'s callback throws an error, then `whenComplete()`'s Future
completes with that error:

如果 `whenComplete()` 的回调抛出错误，
那么 `whenComplete()` 的 Future 会以该错误完成：

<?code-excerpt "futures/lib/when_complete.dart (when-complete-error)" replace="/whenCompleteError/main/g; "?>
```dart
void main() {
  asyncErrorFunction()
      // Future completes with a value:
      .catchError(handleError)
      // Future completes with an error:
      .whenComplete(() => throw Exception('New error'))
      // Error is handled:
      .catchError(handleError);
}
```


## Potential problem: failing to register error handlers early

## 潜在问题：没有及早注册错误处理器

It is crucial that error handlers are installed before a Future completes:
this avoids scenarios where a Future completes with an error, the error
handler is not yet attached, and the error accidentally propagates. Consider
this code:

必须在 Future 完成之前装上错误处理器：
这样才能避免 Future 已经以错误完成、
错误处理器尚未挂上、错误意外传播的情况。
看这段代码：

<?code-excerpt "futures/lib/early_error_handlers.dart (bad)" replace="/ellipsis\(\)/.../g; /mainBad/main/g;"?>
```dart
void main() {
  Future<Object> future = asyncErrorFunction();

  // BAD: Too late to handle asyncErrorFunction() exception.
  Future.delayed(const Duration(milliseconds: 500), () {
    future.then(...).catchError(...);
  });
}
```

In the code above, `catchError()` is not registered until half a second after
`asyncErrorFunction()` is called, and the error goes unhandled.

在上面的代码中，`catchError()` 直到调用 `asyncErrorFunction()`
半秒之后才注册，错误因此未被处理。

The problem goes away if `asyncErrorFunction()` is called within the
`Future.delayed()` callback:

如果在 `Future.delayed()` 的回调里调用 `asyncErrorFunction()`，
这个问题就不会出现：

<?code-excerpt "futures/lib/early_error_handlers.dart (good)" replace="/ellipsis\(\)/.../g; /mainGood/main/g;"?>
```dart
void main() {
  Future.delayed(const Duration(milliseconds: 500), () {
    asyncErrorFunction()
        .then(...)
        .catchError(...); // We get here.
  });
}
```

## Potential problem: accidentally mixing synchronous and asynchronous errors

## 潜在问题：意外混用同步错误和异步错误

Functions that return Futures should almost always emit their errors in the
future. Since we do not want the caller of such functions to have to
implement multiple error-handling scenarios, we want to prevent any synchronous
errors from leaking out. Consider this code:

返回 Future 的函数几乎总是应该在 Future 中发出错误。
我们不希望这类函数的调用方必须实现多套错误处理，
因此要防止任何同步错误泄漏出去。看这段代码：

<?code-excerpt "futures/bin/mixing_errors_problematic.dart (parse)"?>
```dart
Future<int> parseAndRead(Map<String, dynamic> data) {
  final filename = obtainFilename(data); // Could throw.
  final file = File(filename);
  return file.readAsString().then((contents) {
    return parseFileData(contents); // Could throw.
  });
}
```

Two functions in that code could potentially throw synchronously:
`obtainFilename()` and `parseFileData()`. Because `parseFileData()` executes
inside a `then()` callback, its error does not leak out of the function.
Instead, `then()`'s Future completes with `parseFileData()`'s error, the error
eventually completes `parseAndRead()`'s Future, and the error can be
successfully handled by `catchError()`.

这段代码里有两个函数可能同步抛出异常：
`obtainFilename()` 和 `parseFileData()`。
因为 `parseFileData()` 在 `then()` 回调里执行，
它的错误不会泄漏出函数。
相反，`then()` 的 Future 会以 `parseFileData()` 的错误完成，
该错误最终使 `parseAndRead()` 的 Future 完成，
并且可以由 `catchError()` 成功处理。

But `obtainFilename()` is not called within a `then()` callback; if _it_
throws, a synchronous error propagates:

但 `obtainFilename()` 并不是在 `then()` 回调里调用的；
如果 **它** 抛出异常，同步错误就会传播出去：

<?code-excerpt "futures/bin/mixing_errors_problematic.dart (main)"?>
```dart
void main() {
  parseAndRead(data).catchError((e) {
    print('Inside catchError');
    print(e);
    return -1;
  });
}

// Program Output:
//   Unhandled exception:
//   <error from obtainFilename>
//   ...
```

Because using `catchError()` does not capture the error, a client of
`parseAndRead()` would implement a separate error-handling strategy for this
error.

因为 `catchError()` 捕获不到这个错误，
`parseAndRead()` 的调用方就得为它单独实现一套错误处理策略。

### Solution: Using Future.sync() to wrap your code

### 解决办法：用 Future.sync() 包裹代码

A common pattern for ensuring that no synchronous error is accidentally
thrown from a function is to wrap the function body inside a new `Future.sync()`
callback:

一种常见模式是把函数体包进新的 `Future.sync()` 回调，
以确保函数不会意外抛出同步错误：

<?code-excerpt "futures/bin/mixing_errors_solution.dart (parse)"?>
```dart
Future<int> parseAndRead(Map<String, dynamic> data) {
  return Future.sync(() {
    final filename = obtainFilename(data); // Could throw.
    final file = File(filename);
    return file.readAsString().then((contents) {
      return parseFileData(contents); // Could throw.
    });
  });
}
```

If the callback returns a non-Future value, `Future.sync()`'s Future completes
with that value. If the callback throws (as it does in the example
above), the Future completes with an error. If the callback itself returns a
Future, the value or the error of that Future completes `Future.sync()`'s
Future.

如果回调返回的不是 Future，
`Future.sync()` 的 Future 会以该值完成。
如果回调抛出异常（如上例），Future 会以错误完成。
如果回调本身返回 Future，
那个 Future 的值或错误会使 `Future.sync()` 的 Future 完成。

With code wrapped within `Future.sync()`, `catchError()` can handle all errors:

把代码包在 `Future.sync()` 里之后，`catchError()` 可以处理所有错误：

<?code-excerpt "futures/bin/mixing_errors_solution.dart (main)"?>
```dart
void main() {
  parseAndRead(data).catchError((e) {
    print('Inside catchError');
    print(e);
    return -1;
  });
}

// Program Output:
//   Inside catchError
//   <error from obtainFilename>
```

`Future.sync()` makes your code resilient against uncaught exceptions. If your
function has a lot of code packed into it, chances are that you could be doing
something dangerous without realizing it:

`Future.sync()` 让代码更能抵御未捕获的异常。
如果函数里塞了大量代码，
你很可能在不知不觉中做了危险的事：

<?code-excerpt "futures/bin/mixing_errors_problematic.dart (fragile)" replace="/ellipsis\(\);/.../g;"?>
```dart
Future fragileFunc() {
  return Future.sync(() {
    final x = someFunc(); // Unexpectedly throws in some rare cases.
    var y = 10 / x; // x should not equal 0.
    ...
  });
}
```

`Future.sync()` not only allows you to handle errors you know might occur, but
also prevents errors from *accidentally* leaking out of your function.

`Future.sync()` 不仅让你可以处理已知可能发生的错误，
也能防止错误 **意外地** 从函数中泄漏出去。


## More information

## 更多信息

See the [Future API reference][Future class]
for more information on Futures.

关于 Future 的更多信息，
请参阅 [Future API 参考][Future class]。

[Future class]: {{site.dart-api}}/dart-async/Future-class.html
