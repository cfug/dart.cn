---
# title: Error handling
title: 错误处理
# description: Learn about handling errors and exceptions in Dart.
description: 了解如何在 Dart 中处理错误和异常。
prevpage:
  url: /language/branches
  # title: Branches
  title: 分支
nextpage:
  url: /language/functions
  # title: Functions
  title: 函数方法
ai-translated: true
---

## Exceptions

## 异常

Your Dart code can throw and catch exceptions. Exceptions are errors
indicating that something unexpected happened. If the exception isn't
caught, the [isolate][] that raised the exception is suspended,
and typically the isolate and its program are terminated.

Dart 代码可以抛出并捕获异常。异常是一种错误，
表示发生了意料之外的事情。如果异常没有被捕获，
抛出该异常的 [isolate][] 会被挂起，
通常这个 isolate 以及它的程序都会终止。

In contrast to Java, all of Dart's exceptions are unchecked exceptions.
Methods don't declare which exceptions they might throw, and you aren't
required to catch any exceptions.

与 Java 不同，Dart 的异常全都是非受检异常。
方法不用声明自己可能抛出哪些异常，
你也不必捕获任何异常。

Dart provides [`Exception`][] and [`Error`][]
types, as well as numerous predefined subtypes. You can, of course,
define your own exceptions. However, Dart programs can throw any
non-null object—not just Exception and Error objects—as an exception.

Dart 提供了 [`Exception`][`Exception`] 和 [`Error`][`Error`] 类型，
以及许多预定义的子类型。你当然也可以定义自己的异常。
不过，Dart 程序可以把任何非空对象当作异常抛出，
并不限于 Exception 和 Error 对象。

### Throw

### 抛出

Here's an example of throwing, or *raising*, an exception:

下面是抛出（或者说 **引发**）异常的例子：

<?code-excerpt "misc/lib/language_tour/exceptions.dart (throw-FormatException)"?>
```dart
throw FormatException('Expected at least 1 section');
```

You can also throw arbitrary objects:

你也可以抛出任意对象：

<?code-excerpt "misc/lib/language_tour/exceptions.dart (out-of-llamas)"?>
```dart
throw 'Out of llamas!';
```

:::note
Production-quality code usually throws types that
implement [`Error`][] or [`Exception`][].

达到生产质量的代码通常会抛出实现了
[`Error`][`Error`] 或 [`Exception`][`Exception`] 的类型。

:::

Because throwing an exception is an expression, you can throw exceptions
in =\> statements, as well as anywhere else that allows expressions:

抛出异常是一个表达式，因此你可以在 `=>` 语句里抛出异常，
也可以在任何能够出现表达式的地方抛出：

<?code-excerpt "misc/lib/language_tour/exceptions.dart (throw-is-an-expression)"?>
```dart
void distanceTo(Point other) => throw UnimplementedError();
```


### Catch

### 捕获

Catching, or capturing, an exception stops the exception from
propagating (unless you rethrow the exception).
Catching an exception gives you a chance to handle it:

捕获异常会阻止异常继续传播（除非你重新抛出它）。
捕获异常让你有机会处理它：

<?code-excerpt "misc/lib/language_tour/exceptions.dart (try)"?>
```dart
try {
  breedMoreLlamas();
} on OutOfLlamasException {
  buyMoreLlamas();
}
```

To handle code that can throw more than one type of exception, you can
specify multiple catch clauses. The first catch clause that matches the
thrown object's type handles the exception. If the catch clause does not
specify a type, that clause can handle any type of thrown object:

要处理可能抛出多种异常的代码，
可以指定多个 catch 子句。
第一个与所抛出对象的类型匹配的 catch 子句会处理该异常。
如果 catch 子句没有指定类型，它就可以处理任何类型的抛出对象：

<?code-excerpt "misc/lib/language_tour/exceptions.dart (try-catch)"?>
```dart
try {
  breedMoreLlamas();
} on OutOfLlamasException {
  // A specific exception
  buyMoreLlamas();
} on Exception catch (e) {
  // Anything else that is an exception
  print('Unknown exception: $e');
} catch (e) {
  // No specified type, handles all
  print('Something really unknown: $e');
}
```

As the preceding code shows, you can use either `on` or `catch` or both.
Use `on` when you need to specify the exception type. Use `catch` when
your exception handler needs the exception object.

如上面的代码所示，你可以单独使用 `on` 或 `catch`，也可以同时使用。
需要指定异常类型时用 `on`。
异常处理程序需要异常对象时用 `catch`。

You can specify one or two parameters to `catch()`.
The first is the exception that was thrown,
and the second is the stack trace (a [`StackTrace`][] object).

你可以给 `catch()` 指定一个或两个参数。
第一个是被抛出的异常，
第二个是栈追踪（一个 [`StackTrace`][`StackTrace`] 对象）。

<?code-excerpt "misc/lib/language_tour/exceptions.dart (try-catch-2)" replace="/\(e.*?\)/[!$&!]/g"?>
```dart
try {
  // ···
} on Exception catch [!(e)!] {
  print('Exception details:\n $e');
} catch [!(e, s)!] {
  print('Exception details:\n $e');
  print('Stack trace:\n $s');
}
```

To partially handle an exception,
while allowing it to propagate,
use the `rethrow` keyword.

如果只想部分处理异常，同时让它继续传播，
使用 `rethrow` 关键字。

<?code-excerpt "misc/test/language_tour/exceptions_test.dart (rethrow)" replace="/rethrow;/[!$&!]/g"?>
```dart
void misbehave() {
  try {
    dynamic foo = true;
    print(foo++); // Runtime error
  } catch (e) {
    print('misbehave() partially handled ${e.runtimeType}.');
    [!rethrow;!] // Allow callers to see the exception.
  }
}

void main() {
  try {
    misbehave();
  } catch (e) {
    print('main() finished handling ${e.runtimeType}.');
  }
}
```


### Finally

### Finally 子句

To ensure that some code runs whether or not an exception is thrown, use
a `finally` clause. If no `catch` clause matches the exception, the
exception is propagated after the `finally` clause runs:

无论是否抛出异常，都要确保某段代码会运行，
就使用 `finally` 子句。如果没有 `catch` 子句匹配该异常，
异常会在 `finally` 子句运行之后继续传播：

<?code-excerpt "misc/lib/language_tour/exceptions.dart (finally)"?>
```dart
try {
  breedMoreLlamas();
} finally {
  // Always clean up, even if an exception is thrown.
  cleanLlamaStalls();
}
```

The `finally` clause runs after any matching `catch` clauses:

`finally` 子句会在所有匹配的 `catch` 子句之后运行：

<?code-excerpt "misc/lib/language_tour/exceptions.dart (try-catch-finally)"?>
```dart
try {
  breedMoreLlamas();
} catch (e) {
  print('Error: $e'); // Handle the exception first.
} finally {
  cleanLlamaStalls(); // Then clean up.
}
```

To learn more, check out the
[core library exception docs](/libraries/dart-core#exceptions).

想了解更多，请参阅
[核心库异常文档](/libraries/dart-core#exceptions)。

## Assert

## 断言

During development, use an assert 
statement— `assert(<condition>, <optionalMessage>);` —to
disrupt normal execution if a boolean condition is false. 

在开发期间，使用 assert 语句
`assert(<condition>, <optionalMessage>);`
可以在布尔条件为 false 时打断正常执行。

<?code-excerpt "misc/test/language_tour/control_flow_test.dart (assert)"?>
```dart
// Make sure the variable has a non-null value.
assert(text != null);

// Make sure the value is less than 100.
assert(number < 100);

// Make sure this is an https URL.
assert(urlString.startsWith('https'));
```

To attach a message to an assertion,
add a string as the second argument to `assert`
(optionally with a [trailing comma][]):

要给断言附上一条消息，
就把一个字符串作为 `assert` 的第二个参数
（可以带上可选的 [尾随逗号][trailing comma]）：

<?code-excerpt "misc/test/language_tour/control_flow_test.dart (assert-with-message)"?>
```dart
assert(
  urlString.startsWith('https'),
  'URL ($urlString) should start with "https".',
);
```

The first argument to `assert` can be any expression that
resolves to a boolean value. If the expression's value
is true, the assertion succeeds and execution
continues. If it's false, the assertion fails and an exception (an
[`AssertionError`][]) is thrown.

`assert` 的第一个参数可以是任何求值为布尔值的表达式。
如果表达式的值为 true，断言成功，执行继续。
如果为 false，断言失败，并抛出一个异常
（[`AssertionError`][`AssertionError`]）。

When exactly do assertions work?
That depends on the tools and framework you're using:

断言究竟在什么时候生效？
这取决于你使用的工具和框架：

* Flutter enables assertions in [debug mode.][Flutter debug mode]

  Flutter 在 [调试模式][Flutter debug mode] 下启用断言。

* Development-only tools such as [`webdev serve`][]
  typically enable assertions by default.

  仅用于开发的工具（例如 [`webdev serve`][`webdev serve`]）
  通常默认启用断言。

* Some tools, such as [`dart run`][] and [`dart compile js`][]
  support assertions through a command-line flag: `--enable-asserts`.

  有些工具，例如 [`dart run`][`dart run`] 和 [`dart compile js`][`dart compile js`]，
  通过命令行标志 `--enable-asserts` 支持断言。

In production code, assertions are ignored, and
the arguments to `assert` aren't evaluated.

在生产代码中，断言会被忽略，
`assert` 的参数也不会被求值。

[trailing comma]: /language/collections#trailing-comma
[`AssertionError`]: {{site.dart-api}}/dart-core/AssertionError-class.html
[Flutter debug mode]: {{site.flutter-docs}}/testing/debugging#debug-mode-assertions
[`webdev serve`]: /tools/webdev#serve
[`dart run`]: /tools/dart-run
[`dart compile js`]: /tools/dart-compile#js

[isolate]: /language/concurrency#isolates
[`Error`]: {{site.dart-api}}/dart-core/Error-class.html
[`Exception`]: {{site.dart-api}}/dart-core/Exception-class.html
[`StackTrace`]: {{site.dart-api}}/dart-core/StackTrace-class.html
