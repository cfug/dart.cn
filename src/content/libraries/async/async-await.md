---
# title: "Asynchronous programming: futures, async, await"
title: 异步编程：使用 Future 和 async-await
# shortTitle: Futures, async, and await
shortTitle: Future、async 和 await
# description: Learn about and practice writing asynchronous code in DartPad!
description: 学习如何在 DartPad 中练习异步编程！
ai-translated: true
---
<?code-excerpt replace="/ *\/\/\s+ignore_for_file:[^\n]+\n//g; /(^|\n) *\/\/\s+ignore:[^\n]+\n/$1/g; /(\n[^\n]+) *\/\/\s+ignore:[^\n]+\n/$1\n/g"?>
<?code-excerpt plaster="none"?>

This tutorial teaches you how to write asynchronous code using
futures and the `async` and `await` keywords. 
Using embedded DartPad editors, 
you can test your knowledge by running example code
and completing exercises.

本教程将教你如何使用 future 以及 `async` 和 `await` 关键字
编写异步代码。
借助内嵌的 DartPad 编辑器，
你可以通过运行示例代码和完成练习来检验自己的学习成果。

To get the most out of this tutorial, you should have the following:

要想充分掌握本教程的内容，你应该具备以下条件：

* Knowledge of [basic Dart syntax](/language).

  了解 [Dart 基础语法](/language)。
* Some experience writing asynchronous code in another language.

  有一些用其他语言编写异步代码的经验。
* The [`discarded_futures`][] and [`unawaited_futures`][] lints enabled.

  已启用 [`discarded_futures`][] 和 [`unawaited_futures`][]
  这两个 lint 规则。

[`discarded_futures`]: /tools/linter-rules/discarded_futures
[`unawaited_futures`]: /tools/linter-rules/unawaited_futures

This tutorial covers the following material:

本教程涵盖以下内容：

* How and when to use the `async` and `await` keywords.

  如何以及何时使用 `async` 和 `await` 关键字。
* How using `async` and `await` affects execution order.

  使用 `async` 和 `await` 会如何影响执行顺序。
* How to handle errors from an asynchronous call
  using `try-catch` expressions in `async` functions.

  如何在 `async` 函数中使用 `try-catch` 表达式
  处理异步调用产生的错误。

Estimated time to complete this tutorial: 40-60 minutes.

完成本教程的预计时间：40-60 分钟。

:::note
This page uses embedded DartPads to display examples and exercises.

本页面使用内嵌的 DartPads 来展示示例和练习。
{% render 'dartpads-embedded-troubleshooting.md' %}
:::

The exercises in this tutorial have partially completed code snippets.
You can use DartPad to test your knowledge by completing the code and
clicking the **Run** button.
**Don't edit the test code in the `main` function or below**.

本教程中的练习包含只写了一部分的代码片段。
你可以使用 DartPad 补全代码并点击 **Run** 按钮，
来检验自己的学习成果。
**不要修改 `main` 函数中及其之后的测试代码**。

If you need help, expand the **Hint** or **Solution** dropdown
after each exercise.

如果需要帮助，可以展开每个练习后面的
**Hint**（提示）或 **Solution**（答案）下拉框。

## Why asynchronous code matters

## 为什么需要异步代码

Asynchronous operations let your program complete work
while waiting for another operation to finish. 
Here are some common asynchronous operations:

异步操作让你的程序在等待另一个操作完成的同时，
还能继续完成其他工作。
下面是一些常见的异步操作：

* Fetching data over a network.

  通过网络获取数据。
* Writing to a database.

  写入数据库。
* Reading data from a file.

  从文件读取数据。

Such asynchronous computations usually provide their result as a `Future`
or, if the result has multiple parts, as a `Stream`.
These computations introduce asynchrony into a program.
To accommodate that initial asynchrony, 
other plain Dart functions also need to become asynchronous.

这类异步计算通常以 `Future` 的形式提供结果；
如果结果包含多个部分，则以 `Stream` 的形式提供。
这些计算给程序引入了异步性。
为了适应这种最初的异步性，
其他普通的 Dart 函数也需要变成异步的。

To interact with these asynchronous results,
you can use the `async` and `await` keywords.
Most asynchronous functions are just async Dart functions
that depend, possibly deep down, 
on an inherently asynchronous computation.

要与这些异步结果交互，
你可以使用 `async` 和 `await` 关键字。
大多数异步函数只是普通的异步 Dart 函数，
它们（可能层层深入地）依赖于某个本质上异步的计算。

### Example: Incorrectly using an asynchronous function

### 示例：错误地使用异步函数

The following example shows the wrong way
to use an asynchronous function (`fetchUserOrder()`). 
Later you'll fix the example using `async` and `await`.
Before running this example, try to spot the issue -- 
what do you think the output will be?

下面的示例展示了使用异步函数（`fetchUserOrder()`）的
错误方式。
稍后你会用 `async` 和 `await` 修复这个示例。
在运行之前，先试着找出问题所在——
你觉得输出会是什么？

<?code-excerpt "async_await/bin/get_order_sync_bad.dart" remove="Fetching"?>
```dartpad
// This example shows how *not* to write asynchronous Dart code.

String createOrderMessage() {
  var order = fetchUserOrder();
  return 'Your order is: $order';
}

Future<String> fetchUserOrder() =>
    // Imagine that this function is more complex and slow.
    Future.delayed(const Duration(seconds: 2), () => 'Large Latte');

void main() {
  print(createOrderMessage());
}
```

Here's why the example fails to print the value
that `fetchUserOrder()` eventually produces:

下面解释了为什么这个示例没能打印出
`fetchUserOrder()` 最终产生的值：

* `fetchUserOrder()` is an asynchronous function that, after a delay,
  provides a string that describes the user's order: a "Large Latte".

  `fetchUserOrder()` 是一个异步函数，它会在一段延迟之后
  提供一个描述用户订单的字符串："Large Latte"。
* To get the user's order, `createOrderMessage()` should call `fetchUserOrder()`
  and wait for it to finish. Because `createOrderMessage()` does *not* wait
  for `fetchUserOrder()` to finish, `createOrderMessage()` fails to
  get the string value that `fetchUserOrder()` eventually provides.

  要获取用户的订单，`createOrderMessage()` 应该调用
  `fetchUserOrder()` 并等待它完成。由于 `createOrderMessage()`
  *没有*等待 `fetchUserOrder()` 完成，它没能获取到
  `fetchUserOrder()` 最终提供的字符串值。
* Instead, `createOrderMessage()` gets a representation of pending work to be
  done: an uncompleted future. 
  You'll learn more about futures in the next section.

  相反，`createOrderMessage()` 拿到的是待完成工作的
  一个表示：一个未完成的 future。
  你将在下一节中进一步了解 future。
* Because `createOrderMessage()` fails to get the value describing the user's
  order, the example fails to print "Large Latte" to the console, and instead
  prints "Your order is: Instance of '_Future\<String\>'".

  由于 `createOrderMessage()` 没能获取到描述用户订单的值，
  这个示例没能向控制台打印 "Large Latte"，
  而是打印了 "Your order is: Instance of '_Future\<String\>'"。

In the next sections you'll learn about futures and about working with futures
(using `async` and `await`)
so that you'll be able to write the code necessary to make `fetchUserOrder()`
print the desired value ("Large Latte") to the console.

在接下来的几节中，你将学习 future 以及如何使用 future
（借助 `async` 和 `await`），
从而写出必要的代码，让 `fetchUserOrder()`
向控制台打印期望的值（"Large Latte"）。

:::secondary Key terms
* **synchronous operation**: A synchronous operation blocks other operations
  from executing until it completes.

  **同步操作**（synchronous operation）：同步操作会阻塞其他操作，
  直到它执行完成。
* **synchronous function**: A synchronous function only performs synchronous
  operations.

  **同步函数**（synchronous function）：只执行同步操作的函数。
* **asynchronous operation**: Once initiated, an asynchronous operation allows
  other operations to execute before it completes.

  **异步操作**（asynchronous operation）：异步操作一旦启动，
  就允许其他操作在它完成之前执行。
* **asynchronous function**: An asynchronous function performs at least one
  asynchronous operation and can also perform _synchronous_ operations.

  **异步函数**（asynchronous function）：至少执行一个异步操作的
  函数，也可以执行_同步_操作。
:::


## What is a future?

## 什么是 future？

A future (lower case "f") is an instance
of the [Future][] (capitalized "F") class. 
A future represents the result of an asynchronous operation, 
and can have two states: uncompleted or completed.

future（小写 "f"）是 [Future][]（大写 "F"）类的一个实例。
future 表示一个异步操作的结果，
它可以处于两种状态之一：未完成（uncompleted）或已完成（completed）。

:::note
_Uncompleted_ is a Dart term referring to the state of a future
before it has produced a value.

_未完成_（uncompleted）是一个 Dart 术语，
指 future 尚未产生值时所处的状态。
:::

### Uncompleted

### 未完成

When you call an asynchronous function, it returns an uncompleted future.
That future is waiting for the function's asynchronous operation
to finish or to throw an error.

当你调用一个异步函数时，它会返回一个未完成的 future。
这个 future 正在等待函数的异步操作完成或抛出错误。

### Completed

### 已完成

If the asynchronous operation succeeds, 
the future completes with a value. 
Otherwise, it completes with an error.

如果异步操作成功，future 会带着一个值完成；
否则，它会带着一个错误完成。

#### Completing with a value

#### 带着值完成

A future of type `Future<T>` completes with a value of type `T`.
For example, a future with type `Future<String>` produces a string value.
If a future doesn't produce a usable value, 
then the future's type is `Future<void>`.

类型为 `Future<T>` 的 future 会带着一个类型为 `T` 的值完成。
例如，类型为 `Future<String>` 的 future 会产生一个字符串值。
如果 future 不产生可用的值，
那么它的类型就是 `Future<void>`。

#### Completing with an error

#### 带着错误完成

If the asynchronous operation performed by the function fails for any reason,
the future completes with an error.

如果函数执行的异步操作由于任何原因失败，
future 就会带着一个错误完成。

### Example: Introducing futures

### 示例：初识 future

In the following example, `fetchUserOrder()` returns a future
that completes after printing to the console. 
Because it doesn't return a usable value,
`fetchUserOrder()` has the type `Future<void>`. 
Before you run the example,
try to predict which will print first: 
"Large Latte" or "Fetching user order...".

在下面的示例中，`fetchUserOrder()` 返回一个 future，
它会在向控制台打印之后完成。
由于它不返回可用的值，
`fetchUserOrder()` 的类型是 `Future<void>`。
在运行示例之前，
试着预测一下哪个会先打印：
"Large Latte" 还是 "Fetching user order..."。

<?code-excerpt "async_await/bin/futures_intro.dart (no-error)"?>
```dartpad
Future<void> fetchUserOrder() {
  // Imagine that this function is fetching user info from another service or database.
  return Future.delayed(const Duration(seconds: 2), () => print('Large Latte'));
}

void main() {
  fetchUserOrder();
  print('Fetching user order...');
}
```

In the preceding example, 
even though `fetchUserOrder()` executes before the `print()` call on line 8, 
the console shows the output from line 8("Fetching user order...") 
before the output from `fetchUserOrder()` ("Large Latte").
This is because `fetchUserOrder()` delays before it prints "Large Latte".

在上面的示例中，
尽管 `fetchUserOrder()` 在第 8 行的 `print()` 调用之前执行，
控制台却先显示了第 8 行的输出（"Fetching user order..."），
然后才显示 `fetchUserOrder()` 的输出（"Large Latte"）。
这是因为 `fetchUserOrder()` 在打印 "Large Latte" 之前有一段延迟。

### Example: Completing with an error

### 示例：带着错误完成

Run the following example to see how a future completes with an error.
A bit later you'll learn how to handle the error.

运行下面的示例，看看 future 如何带着错误完成。
稍后你会学习如何处理这个错误。

<?code-excerpt "async_await/bin/futures_intro.dart (error)" replace="/Error//g"?>
```dartpad
Future<void> fetchUserOrder() {
  // Imagine that this function is fetching user info but encounters a bug.
  return Future.delayed(
    const Duration(seconds: 2),
    () => throw Exception('Logout failed: user ID is invalid'),
  );
}

void main() {
  fetchUserOrder();
  print('Fetching user order...');
}
```

In this example, `fetchUserOrder()` completes
with an error indicating that the user ID is invalid.

在这个示例中，`fetchUserOrder()` 带着一个
表示用户 ID 无效的错误完成。

You've learned about futures and how they complete, 
but how do you use the results of asynchronous functions? 
In the next section you'll learn how to get results
with the `async` and `await` keywords.

你已经了解了 future 以及它们如何完成，
但要如何使用异步函数的结果呢？
下一节将教你如何使用 `async` 和 `await` 关键字
获取结果。

:::secondary Quick review
* A [Future\<T\>][Future] instance produces a value of type `T`.

  一个 [Future\<T\>][Future] 实例会产生一个类型为 `T` 的值。
* If a future doesn't produce a usable value, 
  then the future's type is `Future<void>`.

  如果 future 不产生可用的值，
  那么它的类型就是 `Future<void>`。
* A future can be in one of two states: uncompleted or completed.

  future 可以处于两种状态之一：未完成或已完成。
* When you call a function that returns a future, 
  the function queues up work to be done and returns an uncompleted future.

  当你调用一个返回 future 的函数时，
  该函数会把要做的工作排入队列，并返回一个未完成的 future。
* When a future's operation finishes, 
  the future completes with a value or with an error.

  当 future 的操作结束时，
  它会带着一个值或一个错误完成。

**Key terms:**

**关键术语：**

* **Future**: the Dart [Future][] class.

  **Future**：Dart 的 [Future][] 类。
* **future**: an instance of the Dart `Future` class.

  **future**：Dart `Future` 类的一个实例。
:::

## Working with futures: async and await

## 使用 future：async 和 await

The `async` and `await` keywords provide a declarative way
to define asynchronous functions and use their results. 
Remember these two basic guidelines when using `async` and `await`:

`async` 和 `await` 关键字提供了一种声明式的方式，
用来定义异步函数并使用它们的结果。
使用 `async` 和 `await` 时，请记住这两条基本准则：

* __To define an async function, add `async` before the function body:__

  __要定义异步函数，在函数体前加上 `async`：__
* __The `await` keyword works only in `async` functions.__

  __`await` 关键字只能在 `async` 函数中使用。__

Here's an example  that converts `main()` 
from a synchronous to asynchronous function.

下面的示例把 `main()`
从同步函数转换为异步函数。

First, add the `async` keyword before the function body:

首先，在函数体前加上 `async` 关键字：

<?code-excerpt "async_await/bin/get_order_sync_bad.dart (main-sig)" replace="/main\(\)/$& async/g; /async/[!$&!]/g; /$/ ··· }/g"?>
```dart
void main() [!async!] { ··· }
```

If the function has a declared return type, 
then update the type to be `Future<T>`, 
where `T` is the type of the value that the function returns.
If the function doesn't explicitly return a value,
then the return type is `Future<void>`:

如果函数声明了返回类型，
就把类型更新为 `Future<T>`，
其中 `T` 是函数返回值的类型。
如果函数没有显式返回值，
那么返回类型就是 `Future<void>`：

<?code-excerpt "async_await/bin/get_order.dart (main-sig)" replace="/Future<\w+\W/[!$&!]/g;  /$/ ··· }/g"?>
```dart
[!Future<void>!] main() async { ··· }
```

Now that you have an `async` function, 
you can use the `await` keyword to wait for a future to complete:

现在你有了一个 `async` 函数，
就可以使用 `await` 关键字等待 future 完成：

<?code-excerpt "async_await/bin/get_order.dart (print-order)" replace="/await/[!$&!]/g"?>
```dart
print([!await!] createOrderMessage());
```

As the following two examples show, the `async` and `await` keywords 
result in asynchronous code that looks a lot like synchronous code.
The only differences are highlighted in the asynchronous example, 
which—if your window is wide enough—is 
to the right of the synchronous example.

正如下面两个示例所示，`async` 和 `await` 关键字
让异步代码看起来很像同步代码。
异步示例中仅有的差异已被高亮标出——
如果你的窗口足够宽，它会显示在同步示例的右侧。

#### Example: synchronous functions

#### 示例：同步函数

<?code-excerpt "async_await/bin/get_order_sync_bad.dart (no-warning)" replace="/(\s+\/\/ )(Imagine.*? is )(.*)/$1$2$1$3/g"?>
```dart
String createOrderMessage() {
  var order = fetchUserOrder();
  return 'Your order is: $order';
}

Future<String> fetchUserOrder() =>
    // Imagine that this function is
    // more complex and slow.
    Future.delayed(const Duration(seconds: 2), () => 'Large Latte');

void main() {
  print('Fetching user order...');
  print(createOrderMessage());
}
```

```plaintext
Fetching user order...
Your order is: Instance of 'Future<String>'
```

As shown in following two examples,
it operates like synchronous code.

正如下面两个示例所示，
它的运行方式就像同步代码一样。

#### Example: asynchronous functions

#### 示例：异步函数

<?code-excerpt "async_await/bin/get_order.dart" replace="/(\s+\/\/ )(Imagine.*? is )(.*)/$1$2$1$3/g; /async|await/[!$&!]/g; /(Future<\w+\W)( [^f])/[!$1!]$2/g; /4/2/g"?>
```dart
[!Future<String>!] createOrderMessage() [!async!] {
  var order = [!await!] fetchUserOrder();
  return 'Your order is: $order';
}

Future<String> fetchUserOrder() =>
    // Imagine that this function is
    // more complex and slow.
    Future.delayed(const Duration(seconds: 2), () => 'Large Latte');

[!Future<void>!] main() [!async!] {
  print('Fetching user order...');
  print([!await!] createOrderMessage());
}
```

```plaintext
Fetching user order...
Your order is: Large Latte
```

The asynchronous example is different in three ways:

异步示例有三处不同：

* The return type for `createOrderMessage()` changes 
  from `String` to `Future<String>`.

  `createOrderMessage()` 的返回类型
  从 `String` 变成了 `Future<String>`。
* The **`async`** keyword appears before the function bodies for
  `createOrderMessage()` and `main()`.

  `createOrderMessage()` 和 `main()` 的函数体前
  出现了 **`async`** 关键字。
* The **`await`** keyword appears before calling the asynchronous functions
  `fetchUserOrder()` and `createOrderMessage()`.

  在调用异步函数 `fetchUserOrder()` 和 `createOrderMessage()` 之前
  出现了 **`await`** 关键字。

:::secondary Key terms
* **async**: You can use the `async` keyword before a function's body to mark it as
  asynchronous.

  **async**：可以在函数体前使用 `async` 关键字，
  将其标记为异步函数。
* **async function**:  An `async` function is a function labeled with the `async`
  keyword.

  **async 函数**：用 `async` 关键字标记的函数。
* **await**: You can use the `await` keyword to get the completed result of an
  asynchronous expression. The `await` keyword only works within an `async` function.

  **await**：可以使用 `await` 关键字获取异步表达式完成后的结果。
  `await` 关键字只能在 `async` 函数中使用。
:::

### Execution flow with async and await

### async 和 await 的执行流程

An `async` function runs synchronously until the first `await` keyword. 
This means that within an `async` function body, 
all synchronous code before the first `await` keyword executes immediately.

`async` 函数在遇到第一个 `await` 关键字之前是同步运行的。
这意味着在 `async` 函数体内，
第一个 `await` 关键字之前的所有同步代码都会立即执行。

### Example: Execution within async functions

### 示例：async 函数内的执行过程

Run the following example to see how execution proceeds
within an `async` function body. 
What do you think the output will be?

运行下面的示例，看看 `async` 函数体内的执行是如何进行的。
你觉得输出会是什么？

<?code-excerpt "async_await/bin/async_example.dart" remove="/\/\/ print/"?>
```dartpad
Future<void> printOrderMessage() async {
  print('Awaiting user order...');
  var order = await fetchUserOrder();
  print('Your order is: $order');
}

Future<String> fetchUserOrder() {
  // Imagine that this function is more complex and slow.
  return Future.delayed(const Duration(seconds: 4), () => 'Large Latte');
}

void main() async {
  countSeconds(4);
  await printOrderMessage();
}

// You can ignore this function - it's here to visualize delay time in this example.
void countSeconds(int s) {
  for (var i = 1; i <= s; i++) {
    Future.delayed(Duration(seconds: i), () => print(i));
  }
}
```

After running the code in the preceding example, try reversing lines 2 and 3:

运行上面示例中的代码后，试着交换第 2 行和第 3 行：

<?code-excerpt "async_await/bin/async_example.dart (swap-stmts)" replace="/\/\/ (print)/$1/g"?>
```dart
var order = await fetchUserOrder();
print('Awaiting user order...');
```

Notice that timing of the output shifts, now that `print('Awaiting user order')`
appears after the first `await` keyword in `printOrderMessage()`.

注意输出的时机发生了变化，因为 `print('Awaiting user order')`
现在出现在 `printOrderMessage()` 中第一个 `await` 关键字之后。

### Exercise: Practice using async and await

### 练习：使用 async 和 await

The following exercise is a failing unit test
that contains partially completed code snippets. 
Your task is to complete the exercise by writing code to make the tests pass.
You don't need to implement `main()`.

下面的练习是一个未通过的单元测试，
其中包含只写了一部分的代码片段。
你的任务是编写代码让测试通过，完成这个练习。
你不需要实现 `main()`。

To simulate asynchronous operations, call the following functions, 
which are provided for you:

要模拟异步操作，请调用下面这些为你提供的函数：

| Function           | Type signature                   | Description                                    |
|--------------------|----------------------------------|------------------------------------------------|
| fetchRole()        | `Future<String> fetchRole()`     | Gets a short description of the user's role.   |
| fetchLoginAmount() | `Future<int> fetchLoginAmount()` | Gets the number of times a user has logged in. |

{:.table .table-striped}

#### Part 1: `reportUserRole()`

#### 第 1 部分：`reportUserRole()`

Add code to the `reportUserRole()` function so that it does the following:

为 `reportUserRole()` 函数添加代码，使其完成以下工作：

* Returns a future that completes with the following
  string: `"User role: <user role>"`

  返回一个 future，它带着以下字符串完成：
  `"User role: <user role>"`
  * Note: You must use the actual value returned by `fetchRole()`; 
    copying and pasting the example return value won't make the test pass.

    注意：你必须使用 `fetchRole()` 返回的实际值；
    复制粘贴示例返回值无法让测试通过。
  * Example return value: `"User role: tester"`

    返回值示例：`"User role: tester"`
* Gets the user role by calling the provided function `fetchRole()`.

  通过调用提供的函数 `fetchRole()` 获取用户角色。

#### Part 2: `reportLogins()`

#### 第 2 部分：`reportLogins()`

Implement an `async` function `reportLogins()` so that it does the following:

实现一个 `async` 函数 `reportLogins()`，使其完成以下工作：

* Returns the string `"Total number of logins: <# of logins>"`.

  返回字符串 `"Total number of logins: <# of logins>"`。
  * Note: You must use the actual value returned by `fetchLoginAmount()`; 
    copying and pasting the example return value won't make the test pass.

    注意：你必须使用 `fetchLoginAmount()` 返回的实际值；
    复制粘贴示例返回值无法让测试通过。
  * Example return value from `reportLogins()`: `"Total number of logins: 57"`

    `reportLogins()` 的返回值示例：`"Total number of logins: 57"`
* Gets the number of logins by calling the provided function `fetchLoginAmount()`.

  通过调用提供的函数 `fetchLoginAmount()` 获取登录次数。

```dartpad theme="dark"
// Part 1
// Call the provided async function fetchRole()
// to return the user role.
Future<String> reportUserRole() async {
  // TODO: Implement the reportUserRole function here.
}

// Part 2
// TODO: Implement the reportLogins function here.
// Call the provided async function fetchLoginAmount()
// to return the number of times that the user has logged in.
reportLogins() {}

// The following functions those provided to you to simulate
// asynchronous operations that could take a while.

Future<String> fetchRole() => Future.delayed(_halfSecond, () => _role);
Future<int> fetchLoginAmount() => Future.delayed(_halfSecond, () => _logins);

// The following code is used to test and provide feedback on your solution.
// There is no need to read or modify it.

void main() async {
  print('Testing...');
  List<String> messages = [];
  const passed = 'PASSED';
  const testFailedMessage = 'Test failed for the function:';
  const typoMessage = 'Test failed! Check for typos in your return value';
  try {
    messages
      ..add(_makeReadable(
          testLabel: 'Part 1',
          testResult: await _asyncEquals(
            expected: 'User role: administrator',
            actual: await reportUserRole(),
            typoKeyword: _role,
          ),
          readableErrors: {
            typoMessage: typoMessage,
            'null':
                'Test failed! Did you forget to implement or return from reportUserRole?',
            'User role: Instance of \'Future<String>\'':
                '$testFailedMessage reportUserRole. Did you use the await keyword?',
            'User role: Instance of \'_Future<String>\'':
                '$testFailedMessage reportUserRole. Did you use the await keyword?',
            'User role:':
                '$testFailedMessage reportUserRole. Did you return a user role?',
            'User role: ':
                '$testFailedMessage reportUserRole. Did you return a user role?',
            'User role: tester':
                '$testFailedMessage reportUserRole. Did you invoke fetchRole to fetch the user\'s role?',
          }))
      ..add(_makeReadable(
          testLabel: 'Part 2',
          testResult: await _asyncEquals(
            expected: 'Total number of logins: 42',
            actual: await reportLogins(),
            typoKeyword: _logins.toString(),
          ),
          readableErrors: {
            typoMessage: typoMessage,
            'null':
                'Test failed! Did you forget to implement or return from reportLogins?',
            'Total number of logins: Instance of \'Future<int>\'':
                '$testFailedMessage reportLogins. Did you use the await keyword?',
            'Total number of logins: Instance of \'_Future<int>\'':
                '$testFailedMessage reportLogins. Did you use the await keyword?',
            'Total number of logins: ':
                '$testFailedMessage reportLogins. Did you return the number of logins?',
            'Total number of logins:':
                '$testFailedMessage reportLogins. Did you return the number of logins?',
            'Total number of logins: 57':
                '$testFailedMessage reportLogins. Did you invoke fetchLoginAmount to fetch the number of user logins?',
          }))
      ..removeWhere((m) => m.contains(passed))
      ..toList();

    if (messages.isEmpty) {
      print('Success. All tests passed!');
    } else {
      messages.forEach(print);
    }
  } on UnimplementedError {
    print(
        'Test failed! Did you forget to implement or return from reportUserRole?');
  } catch (e) {
    print('Tried to run solution, but received an exception: $e');
  }
}

const _role = 'administrator';
const _logins = 42;
const _halfSecond = Duration(milliseconds: 500);

// Test helpers.
String _makeReadable({
  required String testResult,
  required Map<String, String> readableErrors,
  required String testLabel,
}) {
  if (readableErrors.containsKey(testResult)) {
    var readable = readableErrors[testResult];
    return '$testLabel $readable';
  } else {
    return '$testLabel $testResult';
  }
}

// Assertions used in tests.
Future<String> _asyncEquals({
  required String expected,
  required dynamic actual,
  required String typoKeyword,
}) async {
  var strActual = actual is String ? actual : actual.toString();
  try {
    if (expected == actual) {
      return 'PASSED';
    } else if (strActual.contains(typoKeyword)) {
      return 'Test failed! Check for typos in your return value';
    } else {
      return strActual;
    }
  } catch (e) {
    return e.toString();
  }
}
```

<details>
  <summary title="Expand for a hint on the async-await exercise.">Hint</summary>

  Did you remember to add the `async` keyword to the `reportUserRole` function?

  你记得给 `reportUserRole` 函数加上 `async` 关键字了吗？
  
  Did you remember to use the `await` keyword before invoking `fetchRole()`?

  你记得在调用 `fetchRole()` 之前使用 `await` 关键字了吗？
  
  Remember: `reportUserRole` needs to return a `Future`.

  记住：`reportUserRole` 需要返回一个 `Future`。

</details>

<details>
  <summary title="Expand for the solution of the async-await exercise.">Solution</summary>

  ```dart
  Future<String> reportUserRole() async {
    final username = await fetchRole();
    return 'User role: $username';
  }
  
  Future<String> reportLogins() async {
    final logins = await fetchLoginAmount();
    return 'Total number of logins: $logins';
  }
  ```

</details>

## Handling errors

## 处理错误

To handle errors in an `async` function, use try-catch:

要处理 `async` 函数中的错误，请使用 try-catch：

<?code-excerpt "async_await/bin/try_catch.dart (try-catch)" remove="print(order)"?>
```dart
try {
  print('Awaiting user order...');
  var order = await fetchUserOrder();
} catch (err) {
  print('Caught error: $err');
}
```

Within an `async` function, you can write 
[try-catch clauses](/language/error-handling#catch)
the same way you would in synchronous code.

在 `async` 函数中，你可以像在同步代码中一样
编写 [try-catch 语句](/language/error-handling#catch)。

### Example: async and await with try-catch

### 示例：async 和 await 搭配 try-catch

Run the following example to see how to handle an error
from an asynchronous function. 
What do you think the output will be?

运行下面的示例，看看如何处理异步函数产生的错误。
你觉得输出会是什么？

<?code-excerpt "async_await/bin/try_catch.dart"?>
```dartpad
Future<void> printOrderMessage() async {
  try {
    print('Awaiting user order...');
    var order = await fetchUserOrder();
    print(order);
  } catch (err) {
    print('Caught error: $err');
  }
}

Future<String> fetchUserOrder() {
  // Imagine that this function is more complex.
  var str = Future.delayed(
    const Duration(seconds: 4),
    () => throw 'Cannot locate user order',
  );
  return str;
}

void main() async {
  await printOrderMessage();
}
```

### Exercise: Practice handling errors

### 练习：处理错误

The following exercise provides practice handling errors with asynchronous code,
using the approach described in the previous section. To simulate asynchronous
operations, your code will call the following function, which is provided for you:

下面的练习让你用上一节介绍的方法，
练习处理异步代码中的错误。
为了模拟异步操作，你的代码将调用下面这个为你提供的函数：

| Function           | Type signature                      | Description                                                      |
|--------------------|-------------------------------------|------------------------------------------------------------------|
| fetchNewUsername() | `Future<String> fetchNewUsername()` | Returns the new username that you can use to replace an old one. |

{:.table .table-striped}

Use `async` and `await` to implement an asynchronous `changeUsername()` function
that does the following:

使用 `async` 和 `await` 实现一个异步的 `changeUsername()` 函数，
使其完成以下工作：

* Calls the provided asynchronous function `fetchNewUsername()` 
  and returns its result.

  调用提供的异步函数 `fetchNewUsername()`
  并返回其结果。
  * Example return value from `changeUsername()`: `"jane_smith_92"`

    `changeUsername()` 的返回值示例：`"jane_smith_92"`
* Catches any error that occurs and returns the string value of the error.

  捕获发生的任何错误，并返回该错误的字符串值。
  * You can use the
    [toString()]({{site.dart-api}}/dart-core/ArgumentError/toString.html)
    method to stringify both
    [Exceptions]({{site.dart-api}}/dart-core/Exception-class.html) 
    and
    [Errors.]({{site.dart-api}}/dart-core/Error-class.html)

    你可以使用
    [toString()]({{site.dart-api}}/dart-core/ArgumentError/toString.html)
    方法把
    [Exceptions]({{site.dart-api}}/dart-core/Exception-class.html)
    和 [Errors]({{site.dart-api}}/dart-core/Error-class.html)
    都转换为字符串。

```dartpad theme="dark"
// TODO: Implement changeUsername here.
changeUsername() {}

// The following function is provided to you to simulate
// an asynchronous operation that could take a while and
// potentially throw an exception.

Future<String> fetchNewUsername() =>
    Future.delayed(const Duration(milliseconds: 500), () => throw UserError());

class UserError implements Exception {
  @override
  String toString() => 'New username is invalid';
}

// The following code is used to test and provide feedback on your solution.
// There is no need to read or modify it.

void main() async {
  final List<String> messages = [];
  const typoMessage = 'Test failed! Check for typos in your return value';

  print('Testing...');
  try {
    messages
      ..add(_makeReadable(
          testLabel: '',
          testResult: await _asyncDidCatchException(changeUsername),
          readableErrors: {
            typoMessage: typoMessage,
            _noCatch:
                'Did you remember to call fetchNewUsername within a try/catch block?',
          }))
      ..add(_makeReadable(
          testLabel: '',
          testResult: await _asyncErrorEquals(changeUsername),
          readableErrors: {
            typoMessage: typoMessage,
            _noCatch:
                'Did you remember to call fetchNewUsername within a try/catch block?',
          }))
      ..removeWhere((m) => m.contains(_passed))
      ..toList();

    if (messages.isEmpty) {
      print('Success. All tests passed!');
    } else {
      messages.forEach(print);
    }
  } catch (e) {
    print('Tried to run solution, but received an exception: $e');
  }
}

// Test helpers.
String _makeReadable({
  required String testResult,
  required Map<String, String> readableErrors,
  required String testLabel,
}) {
  if (readableErrors.containsKey(testResult)) {
    final readable = readableErrors[testResult];
    return '$testLabel $readable';
  } else {
    return '$testLabel $testResult';
  }
}

Future<String> _asyncErrorEquals(Function fn) async {
  final result = await fn();
  if (result == UserError().toString()) {
    return _passed;
  } else {
    return 'Test failed! Did you stringify and return the caught error?';
  }
}

Future<String> _asyncDidCatchException(Function fn) async {
  var caught = true;
  try {
    await fn();
  } on UserError catch (_) {
    caught = false;
  }

  if (caught == false) {
    return _noCatch;
  } else {
    return _passed;
  }
}

const _passed = 'PASSED';
const _noCatch = 'NO_CATCH';
```

<details>
  <summary title="Expand for a hint on the error-handling exercise.">Hint</summary>

  Implement `changeUsername` to return the string from `fetchNewUsername` or,
  if that fails, the string value of any error that occurs.

  实现 `changeUsername`，让它返回 `fetchNewUsername` 的字符串；
  如果失败，则返回所发生错误的字符串值。
  
  Remember: You can use a [try-catch statement](/language/error-handling#catch)
  to catch and handle errors.

  记住：你可以使用
  [try-catch 语句](/language/error-handling#catch)
  来捕获并处理错误。

</details>

<details>
  <summary title="Expand for the solution of the error-handling exercise.">Solution</summary>

  ```dart
  Future<String> changeUsername() async {
    try {
      return await fetchNewUsername();
    } catch (err) {
      return err.toString();
    }
  }
  ```

</details>

## Exercise: Putting it all together

## 练习：综合运用

It's time to practice what you've learned in one final exercise.
To simulate asynchronous operations, this exercise provides the asynchronous
functions `fetchUsername()` and `logoutUser()`:

是时候在最后一个练习中实践你所学的内容了。
为了模拟异步操作，这个练习提供了异步函数
`fetchUsername()` 和 `logoutUser()`：

| Function        | Type signature                   | Description                                                                   |
|-----------------|----------------------------------|-------------------------------------------------------------------------------|
| fetchUsername() | `Future<String> fetchUsername()` | Returns the name associated with the current user.                            |
| logoutUser()    | `Future<String> logoutUser()`    | Performs logout of current user and returns the username that was logged out. |

{:.table .table-striped}

Write the following:

请编写以下内容：

####  Part 1: `addHello()`

#### 第 1 部分：`addHello()`

* Write a function `addHello()` that takes a single `String` argument.

  编写一个函数 `addHello()`，它接受一个 `String` 参数。
* `addHello()` returns its `String` argument preceded by `'Hello '`.<br>
  Example: `addHello('Jon')` returns `'Hello Jon'`.

  `addHello()` 在其 `String` 参数前加上 `'Hello '` 并返回。<br>
  例如：`addHello('Jon')` 返回 `'Hello Jon'`。

####  Part 2: `greetUser()`

#### 第 2 部分：`greetUser()`

* Write a function `greetUser()` that takes no arguments.

  编写一个不接受任何参数的函数 `greetUser()`。
* To get the username, `greetUser()` calls the provided asynchronous
  function `fetchUsername()`.

  为了获取用户名，`greetUser()` 调用提供的异步函数
  `fetchUsername()`。
* `greetUser()` creates a greeting for the user by calling `addHello()`,
  passing it the username, and returning the result.<br>
  Example: If `fetchUsername()` returns `'Jenny'`, then
  `greetUser()` returns `'Hello Jenny'`.

  `greetUser()` 通过调用 `addHello()` 并传入用户名，
  为用户生成问候语，然后返回结果。<br>
  例如：如果 `fetchUsername()` 返回 `'Jenny'`，
  那么 `greetUser()` 返回 `'Hello Jenny'`。

####  Part 3: `sayGoodbye()`

#### 第 3 部分：`sayGoodbye()`

* Write a function `sayGoodbye()` that does the following:

  编写一个函数 `sayGoodbye()`，完成以下工作：
  * Takes no arguments.

    不接受任何参数。
  * Catches any errors.

    捕获任何错误。
  * Calls the provided asynchronous function `logoutUser()`.

    调用提供的异步函数 `logoutUser()`。
* If `logoutUser()` fails, `sayGoodbye()` returns any string you like.

  如果 `logoutUser()` 失败，`sayGoodbye()` 返回你喜欢的任意字符串。
* If `logoutUser()` succeeds, `sayGoodbye()` returns the string
  `'<result> Thanks, see you next time'`, where `<result>` is
  the string value returned by calling `logoutUser()`.

  如果 `logoutUser()` 成功，`sayGoodbye()` 返回字符串
  `'<result> Thanks, see you next time'`，其中 `<result>` 是
  调用 `logoutUser()` 返回的字符串值。

```dartpad theme="dark"
// Part 1
addHello(String user) {}

// Part 2
// Call the provided async function fetchUsername()
// to return the username.
greetUser() {}

// Part 3
// Call the provided async function logoutUser()
// to log out the user.
sayGoodbye() {}

// The following functions are provided to you to use in your solutions.

Future<String> fetchUsername() => Future.delayed(_halfSecond, () => 'Jean');

Future<String> logoutUser() => Future.delayed(_halfSecond, _failOnce);

// The following code is used to test and provide feedback on your solution.
// There is no need to read or modify it.

void main() async {
  const didNotImplement =
      'Test failed! Did you forget to implement or return from';

  final List<String> messages = [];

  print('Testing...');
  try {
    messages
      ..add(_makeReadable(
          testLabel: 'Part 1',
          testResult: await _asyncEquals(
              expected: 'Hello Jerry',
              actual: addHello('Jerry'),
              typoKeyword: 'Jerry'),
          readableErrors: {
            _typoMessage: _typoMessage,
            'null': '$didNotImplement addHello?',
            'Hello Instance of \'Future<String>\'':
                'Looks like you forgot to use the \'await\' keyword!',
            'Hello Instance of \'_Future<String>\'':
                'Looks like you forgot to use the \'await\' keyword!',
          }))
      ..add(_makeReadable(
          testLabel: 'Part 2',
          testResult: await _asyncEquals(
              expected: 'Hello Jean',
              actual: await greetUser(),
              typoKeyword: 'Jean'),
          readableErrors: {
            _typoMessage: _typoMessage,
            'null': '$didNotImplement greetUser?',
            'HelloJean':
                'Looks like you forgot the space between \'Hello\' and \'Jean\'',
            'Hello Instance of \'Future<String>\'':
                'Looks like you forgot to use the \'await\' keyword!',
            'Hello Instance of \'_Future<String>\'':
                'Looks like you forgot to use the \'await\' keyword!',
            '{Closure: (String) => dynamic from Function \'addHello\': static.(await fetchUsername())}':
                'Did you place the \'\$\' character correctly?',
            '{Closure \'addHello\'(await fetchUsername())}':
                'Did you place the \'\$\' character correctly?',
          }))
      ..add(_makeReadable(
          testLabel: 'Part 3',
          testResult: await _asyncDidCatchException(sayGoodbye),
          readableErrors: {
            _typoMessage:
                '$_typoMessage. Did you add the text \'Thanks, see you next time\'?',
            'null': '$didNotImplement sayGoodbye?',
            _noCatch:
                'Did you remember to call logoutUser within a try/catch block?',
            'Instance of \'Future<String>\' Thanks, see you next time':
                'Did you remember to use the \'await\' keyword in the sayGoodbye function?',
            'Instance of \'_Future<String>\' Thanks, see you next time':
                'Did you remember to use the \'await\' keyword in the sayGoodbye function?',
          }))
      ..add(_makeReadable(
          testLabel: 'Part 3',
          testResult: await _asyncEquals(
              expected: 'Success! Thanks, see you next time',
              actual: await sayGoodbye(),
              typoKeyword: 'Success'),
          readableErrors: {
            _typoMessage:
                '$_typoMessage. Did you add the text \'Thanks, see you next time\'?',
            'null': '$didNotImplement sayGoodbye?',
            _noCatch:
                'Did you remember to call logoutUser within a try/catch block?',
            'Instance of \'Future<String>\' Thanks, see you next time':
                'Did you remember to use the \'await\' keyword in the sayGoodbye function?',
            'Instance of \'_Future<String>\' Thanks, see you next time':
                'Did you remember to use the \'await\' keyword in the sayGoodbye function?',
            'Instance of \'_Exception\'':
                'CAUGHT Did you remember to return a string?',
          }))
      ..removeWhere((m) => m.contains(_passed))
      ..toList();

    if (messages.isEmpty) {
      print('Success. All tests passed!');
    } else {
      messages.forEach(print);
    }
  } catch (e) {
    print('Tried to run solution, but received an exception: $e');
  }
}

// Test helpers.
String _makeReadable({
  required String testResult,
  required Map<String, String> readableErrors,
  required String testLabel,
}) {
  String? readable;
  if (readableErrors.containsKey(testResult)) {
    readable = readableErrors[testResult];
    return '$testLabel $readable';
  } else if ((testResult != _passed) && (testResult.length < 18)) {
    readable = _typoMessage;
    return '$testLabel $readable';
  } else {
    return '$testLabel $testResult';
  }
}

Future<String> _asyncEquals({
  required String expected,
  required dynamic actual,
  required String typoKeyword,
}) async {
  final strActual = actual is String ? actual : actual.toString();
  try {
    if (expected == actual) {
      return _passed;
    } else if (strActual.contains(typoKeyword)) {
      return _typoMessage;
    } else {
      return strActual;
    }
  } catch (e) {
    return e.toString();
  }
}

Future<String> _asyncDidCatchException(Function fn) async {
  var caught = true;
  try {
    await fn();
  } on Exception catch (_) {
    caught = false;
  }

  if (caught == true) {
    return _passed;
  } else {
    return _noCatch;
  }
}

const _typoMessage = 'Test failed! Check for typos in your return value';
const _passed = 'PASSED';
const _noCatch = 'NO_CATCH';
const _halfSecond = Duration(milliseconds: 500);

String _failOnce() {
  if (_logoutSucceeds) {
    return 'Success!';
  } else {
    _logoutSucceeds = true;
    throw Exception('Logout failed');
  }
}

bool _logoutSucceeds = false;
```

<details>
  <summary title="Expand for a hint on the 'Putting it all together' exercise.">Hint</summary>

  The `greetUser` and `sayGoodbye` functions should be asynchronous,
  while `addHello` should be a normal, synchronous function.

  `greetUser` 和 `sayGoodbye` 函数应该是异步的，
  而 `addHello` 应该是一个普通的同步函数。

  Remember: You can use a [try-catch statement](/language/error-handling#catch)
  to catch and handle errors.

  记住：你可以使用
  [try-catch 语句](/language/error-handling#catch)
  来捕获并处理错误。

</details>

<details>
  <summary title="Expand for the solution of the 'Putting it all together' exercise.">Solution</summary>

  ```dart
  String addHello(String user) => 'Hello $user';
  
  Future<String> greetUser() async {
    final username = await fetchUsername();
    return addHello(username);
  }
  
  Future<String> sayGoodbye() async {
    try {
      final result = await logoutUser();
      return '$result Thanks, see you next time';
    } catch (e) {
      return 'Failed to logout user: $e';
    }
  }
  ```

</details>

## Which lints work for futures?

## 哪些 lint 规则适用于 future？

To catch common mistakes that arise while working with async and futures,
[enable](/tools/analysis#individual-rules) the following lints:

为了捕捉使用 async 和 future 时出现的常见错误，
请[启用](/tools/analysis#individual-rules)以下 lint 规则：

* [`discarded_futures`][]
* [`unawaited_futures`][]

[`discarded_futures`]: /tools/linter-rules/discarded_futures
[`unawaited_futures`]: /tools/linter-rules/unawaited_futures

## What's next?

## 下一步

Congratulations, you've finished the tutorial! If you'd like to learn more, here
are some suggestions for where to go next:

恭喜你完成了本教程！如果你想继续学习，
这里有一些后续学习的建议：

- Play with [DartPad]({{site.dartpad}}).

  体验一下 [DartPad]({{site.dartpad}})。
- Learn more about futures and asynchronous code in Dart:

  进一步了解 Dart 中的 future 和异步代码：
  - [Streams tutorial](/libraries/async/using-streams):
    Learn how to work with a sequence of asynchronous events.

    [Stream 教程](/libraries/async/using-streams)：
    学习如何处理异步事件序列。
  - [Concurrency in Dart](/language/concurrency):
    Understand and learn how to implement concurrency in Dart.

    [Dart 中的并发](/language/concurrency)：
    理解并学习如何在 Dart 中实现并发。
  - [Asynchronous programming](/language/async):
    Dive in to Dart's language and library support for asynchronous coding.

    [异步编程](/language/async)：
    深入了解 Dart 语言和库对异步编程的支持。
  - [Dart videos from Google][Dart videos]:
    Watch one or more of the videos about asynchronous coding.

    [Google 的 Dart 视频][Dart videos]：
    观看一个或多个关于异步编程的视频。
- Get the [Dart SDK](/get-dart)!

  获取 [Dart SDK](/get-dart)！

[Dart videos]: {{site.yt.playlist}}PLjxrf2q8roU0Net_g1NT5_vOO3s_FR02J
[Future]: {{site.dart-api}}/dart-async/Future-class.html
[style guide]: /effective-dart/style
[documentation guide]: /effective-dart/documentation
[usage guide]: /effective-dart/usage
[design guide]: /effective-dart/design
