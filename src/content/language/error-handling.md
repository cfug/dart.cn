---
# title: Error handling
title: Error handling
# description: Learn about handling errors and exceptions in Dart.
description: Learn about handling errors and exceptions in Dart.
prevpage:
  url: /language/branches
  title: Branches
nextpage:
  url: /language/functions
  title: Functions
---

## Exceptions



## 异常

Your Dart code can throw and catch exceptions. Exceptions are errors
indicating that something unexpected happened. If the exception isn't
caught, the [isolate][] that raised the exception is suspended,
and typically the isolate and its program are terminated.



你的 Dart 代码可以抛出和捕获异常。异常是表示发生了意外情况的错误。
如果异常没有被捕获，引发异常的 [isolate][] 将被挂起，
通常 isolate 及其程序将被终止。

In contrast to Java, all of Dart's exceptions are unchecked exceptions.
Methods don't declare which exceptions they might throw, and you aren't
required to catch any exceptions.



与 Java 不同，Dart 的所有异常都是非检查异常。
方法不会声明它们可能抛出哪些异常，
你也不需要捕获任何异常。

Dart provides [`Exception`][] and [`Error`][]
types, as well as numerous predefined subtypes. You can, of course,
define your own exceptions. However, Dart programs can throw any
non-null object—not just Exception and Error objects—as an exception.



Dart 提供了 [`Exception`][] 和 [`Error`][] 类型，
以及许多预定义的子类型。当然，你也可以定义自己的异常。
但是，Dart 程序可以将任何非空对象作为异常抛出——
不仅仅是 Exception 和 Error 对象。

### Throw



### 抛出

Here's an example of throwing, or *raising*, an exception:



下面是抛出或*引发*异常的示例：

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
:::

Because throwing an exception is an expression, you can throw exceptions
in =\> statements, as well as anywhere else that allows expressions:



生产质量的代码通常会抛出实现了 [`Error`][] 或 [`Exception`][] 的类型。
:::

<?code-excerpt "misc/lib/language_tour/exceptions.dart (throw-is-an-expression)"?>
```dart
void distanceTo(Point other) => throw UnimplementedError();
```

### Catch



因为抛出异常是一个表达式，所以你可以在 =\> 语句中抛出异常，
也可以在任何其他允许表达式的地方抛出异常：

Catching, or capturing, an exception stops the exception from
propagating (unless you rethrow the exception).
Catching an exception gives you a chance to handle it:



### 捕获

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



捕获异常可以阻止异常继续传播（除非你重新抛出异常）。
捕获异常让你有机会处理它：

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



要处理可能抛出多种类型异常的代码，你可以指定多个 catch 子句。
第一个与抛出对象类型匹配的 catch 子句将处理该异常。
如果 catch 子句没有指定类型，则该子句可以处理任何类型的抛出对象：

You can specify one or two parameters to `catch()`.
The first is the exception that was thrown,
and the second is the stack trace (a [`StackTrace`][] object).



如上面的代码所示，你可以使用 `on` 或 `catch`，或两者都用。
当你需要指定异常类型时使用 `on`。
当你的异常处理程序需要异常对象时使用 `catch`。

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



你可以为 `catch()` 指定一个或两个参数。
第一个是抛出的异常，第二个是堆栈跟踪（[`StackTrace`][] 对象）。

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



要部分处理异常，同时允许它继续传播，
请使用 `rethrow` 关键字。

### Finally



为了确保无论是否抛出异常某些代码都会运行，
请使用 `finally` 子句。
如果没有 `catch` 子句匹配该异常，
异常将在 `finally` 子句运行后传播：

To ensure that some code runs whether or not an exception is thrown, use
a `finally` clause. If no `catch` clause matches the exception, the
exception is propagated after the `finally` clause runs:



`finally` 子句在任何匹配的 `catch` 子句之后运行：

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



要了解更多信息，请查看[核心库异常文档](/libraries/dart-core#exceptions)。

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



## 断言

## Assert



在开发过程中，使用 assert 语句——
`assert(<condition>, <optionalMessage>);`——
如果布尔条件为 false，则中断正常执行。

During development, use an assert 
statement— `assert(<condition>, <optionalMessage>);` —to
disrupt normal execution if a boolean condition is false.



要为断言附加一条消息，
请将字符串作为 `assert` 的第二个参数添加
（可选择带有[尾随逗号][trailing comma]）：

<?code-excerpt "misc/test/language_tour/control_flow_test.dart (assert)"?>
```dart
// Make sure the variable has a non-null value.
assert(text != null);

// Make sure the value is less than 100.
assert(number < 100);



`assert` 的第一个参数可以是任何解析为布尔值的表达式。
如果表达式的值为 true，断言成功，执行继续。
如果为 false，断言失败，并抛出异常（[`AssertionError`][]）。

// Make sure this is an https URL.
assert(urlString.startsWith('https'));
```



断言究竟何时起作用？
这取决于你使用的工具和框架：

To attach a message to an assertion,
add a string as the second argument to `assert`
(optionally with a [trailing comma][]):



* Flutter 在[调试模式][Flutter debug mode]下启用断言。
* 仅用于开发的工具如 [`webdev serve`][] 通常默认启用断言。
* 某些工具，如 [`dart run`][] 和 [`dart compile js`][]，
  通过命令行标志支持断言：`--enable-asserts`。

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



在生产代码中，断言会被忽略，
`assert` 的参数不会被求值。

When exactly do assertions work?
That depends on the tools and framework you're using:

* Flutter enables assertions in [debug mode.][Flutter debug mode]
* Development-only tools such as [`webdev serve`][]
  typically enable assertions by default.
* Some tools, such as [`dart run`][] and [`dart compile js`][]
  support assertions through a command-line flag: `--enable-asserts`.

In production code, assertions are ignored, and
the arguments to `assert` aren't evaluated.

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
