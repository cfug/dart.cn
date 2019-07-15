---
title: "Asynchronous programming: futures & async-await"
title: 异步编程：使用Future和async-await
description: How to write asynchronous Dart code that uses futures and the async and await keywords.
description: 如何使用Future和关键字async、await编写异步代码。
nextpage:
  url: /tutorials/language/streams
  title: "Asynchronous programming: streams"
  title: 异步编程：使用Stream
---
<?code-excerpt replace="/\b_(gather|print)/$1/g; /Async\w*\(\)/()/g"?>
<?code-excerpt plaster="none"?>

{% comment %}
[PENDING: This page might be replaced by the Futures codelab.]
{% endcomment %}

<div class="mini-toc" markdown="1">
  <h4>What's the point?</h4>

  * Dart code runs in a single "thread" of execution.
  * Code that blocks the thread of execution can make your program freeze.
  * `Future` objects (_futures_) represent the results of _asynchronous operations_ — processing or I/O to be completed later.
  * To suspend execution until a future completes, use `await` in an async function.
  * To catch errors, use try-catch expressions in async functions.
  * To run code concurrently, create an _isolate_ (or for a web app, a _worker_).
</div>

<div class="mini-toc" markdown="1">
  <h4>本章的重点</h4>

  * Dart代码运行在单个执行“线程”中。
  * 阻塞执行线程的代码会使你的程序“冻结”。
  * 一个`Future` 对象用于表示 _异步操作_ 的结果，这些正在处理的操作或I/O将会在稍后完成。
  * 在异步函数中使用 `await` 关键字暂停代码的执行直到对应的future完成。
  * 可以使用try-catch表达式来捕获异步函数中代码的执行错误。
  * 为了可以使不同的代码片段同时执行，可以为它们创建一个 _isolate_（如果你的程序是一个Web应用，则创建 _worker_ 替代 _isolate_）
</div>

Dart code runs in a single "thread" of execution. If Dart code blocks — for example, by performing a long-running calculation or waiting for I/O — the entire program freezes.

Dart代码运行在单个执行“线程”中。如果Dart代码在执行时阻塞，例如：处理一个需要长时间运行的计算操作或等待I/O完成。此时整个程序会被“冻结”。

Asynchronous operations let your program complete other work while waiting for an operation to finish. Dart uses `Future` objects (futures) to represent the results of asynchronous operations. To work with futures, you can use either `async` and `await` or the `Future` API.

异步操作可以让你的程序在等待一个操作完成时继续处理其它的工作。Dart使用 `Future` 对象来表示异步操作的结果。你可以用 `async` 和 `await` 关键字或 `Future` 类的相关API来配合使用future。

<aside class="alert alert-info" markdown="1">
  **Note:**
  All Dart code runs in the context of an _isolate_ that owns all of the memory that the Dart code uses. While Dart code is executing, no other code in the same isolate can run.

  **注意：**
  所有的Dart代码均运行在一个 _isolate_ 的上下文环境中，该 _isolate_ 中拥有对应Dart代码片段运行所需的所有内存。Dart代码执行时不允许其它的代码片段在与之相同的isolate中执行。

  <br>
  If you want multiple parts of Dart code to run concurrently, you can run them in separate isolates.( Web apps use workers instead of isolates.) Multiple isolates run at the same time, usually each on its own CPU core. Isolates don't share memory, and the only way they can interact is by sending messages to each other. For more information, see the documentation for [isolates][isolate] or [web workers.][worker]

  如果你想在同一时间运行多个不同的Dart代码片段，你可以将它们分别运行于不同的isolate中。（如果是Web应用则使用worker替代isolate。）一般来说如果多个isolate同时运行，那么每个isolate都会运行在属于自己的CPU内核中。isolate之间不会共享内存，它们唯一的交互方式是互相发送消息。可以查阅 [isolates][isolate] 和 [web workers.][worker] 的文档获取更多信息。
</aside>

## Introduction
## 引言

Let's look at some code that might cause a program to freeze:

让我们来看一些会使一个程序“冻结”的代码：

<?code-excerpt "misc/lib/tutorial/daily_news.dart (sync)" replace="/Sync(\(\))/$1/g"?>
{% prettify dart %}
// Synchronous code
// 同步执行的代码
void printDailyNewsDigest() {
  // var newsDigest = gatherNewsReports(); // Can take a while.
  var newsDigest = gatherNewsReports(); // 执行该函数会耗费一定时间。
  print(newsDigest);
}

main() {
  printDailyNewsDigest();
  printWinningLotteryNumbers();
  printWeatherForecast();
  printBaseballScore();
}
{% endprettify %}

Our program gathers the news of the day, prints it, and then prints a bunch of other items of interest to the user:

上述的程序中我们搜集当天的新闻以及用户感兴趣的其它一些信息并打印输出到控制台：

<?code-excerpt "misc/test/tutorial/futures_test.dart (sync-output)" replace="/const.*?'+//g; /'+;//g"?>
```nocode
<gathered news goes here>
Winning lotto numbers: [23, 63, 87, 26, 2]
Tomorrow's forecast: 70F, sunny.
Baseball score: Red Sox 10, Yankees 0

<搜集的新闻信息在这（省略……）>
乐透中奖号码：[23、63、87、26、2]
明天天气预报：21摄氏度，晴。
棒球赛比分：红袜队 10，洋基队 0
```

Our code is problematic: since `gatherNewsReports()` blocks, the remaining code runs only after `gatherNewsReports()` returns with the contents of the file, _however long that takes_. If reading the file takes a long time, the user has to wait, wondering if they won the lottery, what tomorrow's weather will be, and who won today's game.

上述的代码的问题在于：由于 `gatherNewsReports()` 函数阻塞，_不管要等多久_，剩下的代码都会在 `gatherNewsReports()` 函数返回了文件的内容后才会运行。如果读取文件需要耗费很长的时间，即便用户想马上知道他们是否中了乐透？明天天气如何？以及今天谁赢了比赛？都不得不等待 `gatherNewsReports()` 函数执行完毕。

To help keep the application responsive, Dart library authors use an asynchronous model when defining functions that do potentially expensive work. Such functions return their value using a future.

为了帮助保持应用的响应速度，Dart库的创作者们在定义可能需要执行耗时操作的函数时使用一种异步模型。这类函数使用一个future对象返回它们的值。

## What is a future? {#what-is-a-future}
## future是什么？ {#what-is-a-future}

A future is a [`Future<T>`][Future] object, which represents an asynchronous operation that produces a result of type `T`. If the result isn't a usable value, then the future's type is `Future<void>`. When a function that returns a future is invoked, two things happen:

1. The function queues up work to be done and returns an uncompleted `Future` object.
2. Later, when the operation is finished, the `Future` object completes with a value or with an error.

future是 [`Future<T>`][Future] 类的对象，其表示一个 `T` 类型的异步操作结果。如果异步操作不需要结果，则future的类型可为 `Future<void>`。当一个返回future对象的函数被调用时，会发生两件事：

1. 将函数操作列入队列等待执行并返回一个未完成的 `Future` 对象。
2. 不久后当函数操作执行完成，`Future` 对象变为完成并携带一个值或一个错误。

When writing code that depends on a future, you have two options:

* Use `async` and `await`
* Use the `Future` API

当你写的代码依赖于future对象时，你有两种可选的实现方式：

* 使用关键字 `async` 和 `await`
* 使用 `Future` API

## Async and await {#async-await}
## 关键字 async 和 await {#async-await}

The `async` and `await` keywords are part of the Dart language's [asynchrony support](/guides/language/language-tour#asynchrony-support). They allow you to write asynchronous code that looks like synchronous code and doesn't use the `Future` API. An _async function_ is one that has the `async` keyword before its body. The `await` keyword works only in async functions.

关键字 `async` 和 `await` 是Dart语言 [异步支持](/guides/language/language-tour#asynchrony-support) 的一部分。它们允许你不使用 `Future` 的API编写看起来与同步代码一样的异步代码。_异步函数_ 即在函数头中包含关键字 `async` 的函数。关键字 `await` 只能用在异步函数中。

{% include async-await-2.0.md %}

The following app simulates reading the news by using `async` and `await`
to read the contents of a file on this site.
Click run {% asset red-run.png alt="" %} to start the app.
Or open a
[DartPad window containing the app,]({{site.dartpad}}/477fb799d21401f46f8c04462fd249c4){: target="_blank"}
run the app, and click CONSOLE to see the app's output.

接下来的应用使用关键字 `async` 和 `await` 读取本网站上文件的内容来模拟读取新闻。点击运行按钮{% asset red-run.png alt="" %}开始运行该应用。或者打开一个[包含该应用的DartPad窗口,]({{site.custom.dartpad.direct-link}}/477fb799d21401f46f8c04462fd249c4){: target="_blank"} 来运行该应用，请点击CONSOLE查看应用的运行结果输出。

{% comment %}
<?code-excerpt "misc/lib/tutorial/daily_news.dart (main-async)" replace="/Duration (oneSecond)/const $1/g"?>
{% prettify dart %}
// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
Future<void> printDailyNewsDigest() async {
  var newsDigest = await gatherNewsReports();
  print(newsDigest);
}

main() {
  printDailyNewsDigest();
  printWinningLotteryNumbers();
  printWeatherForecast();
  printBaseballScore();
}

printWinningLotteryNumbers() {
  // print('Winning lotto numbers: [23, 63, 87, 26, 2]');
  print('乐透中奖号码：[23、63、87、26、2]');
}

printWeatherForecast() {
  // print("Tomorrow's forecast: 70F, sunny.");
  print("明天天气：21摄氏度，晴。");
}

printBaseballScore() {
  // print('Baseball score: Red Sox 10, Yankees 0');
  print('棒球赛比分：红袜队 10，洋基队 0');
}

// const news = '<gathered news goes here>';
const news = '<搜集的新闻信息在这（省略……）>';
const oneSecond = Duration(seconds: 1);

// Imagine that this function is more complex and slow. :)
// 想象一下该函数非常复杂耗时。:)
Future<String> gatherNewsReports() => Future.delayed(oneSecond, () => news);

// Alternatively, you can get news from a server using features from either dart:io or dart:html. For example:
// 你也可以选择使用dart:io或dart:html中的功能来从一个服务器获取新闻信息。例如：
//
// import 'dart:html';
//
// Future<String> gatherNewsReportsFromServer() => HttpRequest.getString(
//      'https://www.dartlang.org/f/dailyNewsDigest.txt',
//    );
{% endprettify %}
{% endcomment %}

<iframe
src="{{site.custom.dartpad.embed-inline-prefix}}?id=477fb799d21401f46f8c04462fd249c4&horizontalRatio=99&verticalRatio=73"
    width="100%"
    height="500px"
    style="border: 1px solid #ccc;">
</iframe>

Notice that `printDailyNewsDigest()` is the first function called, but the news is the last thing to print, even though the file contains only a single line. This is because the code that reads and prints the file is running asynchronously.

这里需要注意，虽然函数 `printDailyNewsDigest()` 是第一个被调用的函数，但是新闻信息却是最后才打印输出的，即便该新闻信息只是一行模拟文本。这是因为代码在读取和打印输出该信息时是异步的。

In this example, the `printDailyNewsDigest()` function calls `gatherNewsReports()`, which is non-blocking.  Calling `gatherNewsReports()` queues up the work to be done but doesn't stop the rest of the code from executing. The program prints the lottery numbers, the forecast, and the baseball score; when `gatherNewsReports()` finishes gathering news, the program prints.  If `gatherNewsReports()` takes a little while to complete its work, no great harm is done: the user gets to read other things before the daily news digest is printed.

在这个例子中，函数 `printDailyNewsDigest()` 调用函数 `gatherNewsReports()`的过程是非阻塞的。调用函数 `gatherNewsReports()` 时会将该函数操作列入队列执行但不会阻止其它代码的执行。程序打印输出乐透号码、天气、以及棒球赛比分；当 `gatherNewsReports()` 函数搜集完新闻后程序也将其打印输出。即使 `gatherNewsReports()` 函数需要花费一点时间来完成它的工作，这也不会造成太大的影响：用户可以在每日新闻摘要打印输出前查看其它信息。

Note the return types. The return type of `gatherNewsReports()` is `Future<String>`, which means that it returns a future that completes with a string value. The `printDailyNewsDigest()` function, which doesn't return a value, has the return type `Future<void>`.

注意函数的返回类型。函数 `gatherNewsReports()` 的返回类型是 `Future<String>`，这表示其返回一个完成时包含一个字符串值的future对象。而函数 `printDailyNewsDigest()` 因为本身没有返回值，所以在变为异步函数后其返回值类型为 `Future<void>`。

The following diagram shows the flow of execution through the code. Each number corresponds to a step below.

<img src="../images/async-await.png" alt="diagram showing flow of control through the main() and printDailyNewsDigest functions">

1. The app begins executing.
2. The `main()` function calls the async function `printDailyNewsDigest()`, which begins executing synchronously.
3. `printDailyNewsDigest()` uses `await` to call the function `gatherNewsReports()`, which begins executing.
4. The `gatherNewsReports()` function returns an uncompleted future (an instance of `Future<String>`).
5. Because `printDailyNewsDigest()` is an async function and is awaiting a value, it pauses its execution and returns an uncompleted future (in this case, an instance of `Future<void>`) to its caller (`main()`).
6. The remaining print functions execute. Because they're synchronous, each function executes fully before moving on to the next print function. For example, the winning lottery numbers are all printed before the weather forecast is printed.
7. When `main()` has finished executing, the asynchronous functions can resume execution. First, the future returned by `gatherNewsReports()` completes. Then `printDailyNewsDigest()` continues executing, printing the news.
8. When the `printDailyNewsDigest()` function body finishes executing, the future that it originally returned completes, and the app exits.

下面的图示展示了代码的执行流程。每个数字对应图示下面的一个步骤。

<img src="../images/async-await-cn.png" alt="diagram showing flow of control through the main() and printDailyNewsDigest functions">

1. 应用开始执行。
2. `main()` 函数开始以同步的方式执行并调用异步函数 `printDailyNewsDigest()`。
3. `printDailyNewsDigest()`函数开始执行，并使用关键字 `await` 调用 `gatherNewsReports()` 函数。
4. 函数 `gatherNewsReports()` 返回一个未完成的future对象（ `Future<String>` 类的一个实例）。
5. 因为函数 `printDailyNewsDigest()` 是一个异步函数并且它在等待一个值（该值由第4步中函数 `gatherNewsReports()` 返回的future对象提供），所以它暂停其函数内代码的执行并返回一个未完成的future对象（在此例中，该future对象为 `Future<void>` 的一个实例）给它的调用者（`main()` 函数）。
6. 执行其它的打印输出函数。因为这些函数是同步的，所以每一个函数完整地执行完后才会执行下一个函数。例如乐透的中奖号码一定会在天气预报之前打印出来。
7. 当 `main()` 函数完成执行时，异步函数将会恢复执行。首先，函数 `gatherNewsReports()` 返回的future对象完成。然后函数 `printDailyNewsDigest()` 继续执行，最后打印出新闻。
8. 当 `printDailyNewsDigest()` 函数完成执行时，其刚开始返回的future对象也完成，并且应用退出。

Note that an async function starts executing right away (synchronously). The function suspends execution and returns an uncompleted future when it reaches the first occurrence of any of the following:

* The function's first `await` expression (after the function gets the uncompleted future from that expression).
* Any `return` statement in the function.
* The end of the function body.

请注意异步函数是立即开始执行的（同步地），其将会在下述情况之一首次出现时暂停执行并返回一个未完成的future对象：

* 函数中第一个 `await` 表达式出现时（在该函数从 `await` 表达式获取到未完成的future之后）。
* 函数中任何 `return` 语句的出现时。
* 函数体的结束。

### Handling errors {#handling-errors-async}
### 错误处理 {#handling-errors-async}

If a `Future`-returning function completes with an error, you probably want to capture that error. Async functions can handle errors using try-catch:

如果一个 `Future` 在函数返回完成时有错误，你可能想要捕获该错误。异步函数中可以使用try-catch语句来处理错误：

<?code-excerpt "misc/lib/tutorial/daily_news.dart (try-catch)"?>
{% prettify dart %}
Future<void> printDailyNewsDigest() async {
  try {
    var newsDigest = await gatherNewsReports();
    print(newsDigest);
  } catch (e) {
    // Handle error...
    // 处理代码执行错误...
  }
}
{% endprettify %}

The try-catch code behaves in the same way with asynchronous code as it does with synchronous code: if the code within the `try` block throws an exception, the code inside the `catch` clause executes.

try-catch语句处理异步代码错误的方式与同步代码相同： `catch` 语句块中的代码会在 `try` 语句块中的代码抛出异常时执行。

{% comment %}
[PENDING: say something about finally?]
{% endcomment %}

### Sequential processing {#sequential-processing-async}
### 顺序处理

You can use multiple `await` expressions to ensure that each statement completes before executing the next statement:

你可以使用多个 `await` 表达式来确保各个语句在执行下一个语句之前完成：

<?code-excerpt "misc/lib/tutorial/misc.dart (multiple-await)"?>
{% prettify dart %}
// Sequential processing using async and await.
// 使用关键字 async 和 await 顺序处理异步函数逻辑
main() async {
  await expensiveA();
  await expensiveB();
  doSomethingWith(await expensiveC());
}
{% endprettify %}

The `expensiveB()` function doesn't execute until `expensiveA()` has finished, and so on.

函数 `expensiveB()` 将会在函数 `expensiveA()` 执行完毕后才执行，接下来的其它类似函数也如此。

{% comment %}

[PENDING: Move this to the error handling page?]

## The Future API
## Future类API

Before `async` and `await` were added in Dart 1.9, you had to use the `Future` API. You might still see the `Future` API used in older code and in code that needs more functionality than async-await offers.

在Dart 1.9版本将 `async` 和 `await` 添加进关键字之前，你必须使用 `Future` 类的相关API来实现异步操作。即便到目前为止，你依然可能会在在老版本的代码或一些需要比async-await关键字提供更多功能的场景中看到使用 `Future` 类的API。

To write asynchronous code using the `Future` API, you use the `then()` method to register a callback.  This callback fires when the `Future` completes.

使用 `Future` 类相关的API编写异步代码的第一步是使用其 `then()` 方法来注册一个回调，该回调会在 `Future` 完成时触发。

The following app simulates reading the news by using the `Future` API to read
the contents of a file on this site.
Click run {% asset red-run.png %} to start the app.
Or open a
[DartPad window containing the app,]({{site.dartpad}}/5ceabe371903b6672026bd3fb30cdf5b){: target="_blank"}
run the app, and click CONSOLE to see the app's output.

接下来的应用使用 `Future` 类的相关API读取本网站上文件的内容来模拟读取新闻。点击运行按钮{% asset red-run.png alt="" %}开始运行该应用。或者打开一个[包含该应用的DartPad窗口,]({{site.custom.dartpad.direct-link}}/477fb799d21401f46f8c04462fd249c4){: target="_blank"} 来运行该应用，请点击CONSOLE查看应用的运行结果输出。

{% comment %}
<?code-excerpt "misc/lib/tutorial/daily_news.dart (main-future-api)" replace="/Duration (oneSecond)/const $1/g"?>
{% prettify dart %}
// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
Future<void> printDailyNewsDigest() {
  final future = gatherNewsReports();
  return future.then(print);
  // You don't *have* to return the future here. But if you don't, callers can't await it.
  // 你 *并非必须* 在这里返回future。但是如果不这么做，调用者将不会等待该函数执行完成。
}

main() {
  printDailyNewsDigest();
  printWinningLotteryNumbers();
  printWeatherForecast();
  printBaseballScore();
}

printWinningLotteryNumbers() {
  // print('Winning lotto numbers: [23, 63, 87, 26, 2]');
  print('乐透中奖号码：[23、63、87、26、2]');
}

printWeatherForecast() {
  // print("Tomorrow's forecast: 70F, sunny.");
  print("明天天气：21摄氏度，晴。");
}

printBaseballScore() {
  // print('Baseball score: Red Sox 10, Yankees 0');
  print('棒球赛比分：红袜队 10，洋基队 0');
}

// const news = '<gathered news goes here>';
const news = '<搜集的新闻信息在这（省略……）>';
const oneSecond = Duration(seconds: 1);

// Imagine that this function is more complex and slow. :)
// 想象一下该函数非常复杂耗时。:)
Future<String> gatherNewsReports() =>
    Future.delayed(oneSecond, () => news);

// Alternatively, you can get news from a server using features from either dart:io or dart:html. For example:
// 你也可以选择使用dart:io或dart:html中的功能来从一个服务器获取新闻信息。例如：
//
// import 'dart:html';
//
// Future<String> gatherNewsReportsFromServer() => HttpRequest.getString(
//      'https://www.dartlang.org/f/dailyNewsDigest.txt',
//    );
{% endprettify %}
{% endcomment %}

<iframe
src="{{site.custom.dartpad.embed-inline-prefix}}?id=5ceabe371903b6672026bd3fb30cdf5b&horizontalRatio=99&verticalRatio=73"
    width="100%"
    height="500px"
    style="border: 1px solid #ccc;">
</iframe>

Notice that `printDailyNewsDigest()` is the first function called, but the news is the last thing to print, even though the file contains only a single line. This is because the code that reads the file is running asynchronously.

这里需要注意，虽然函数 `printDailyNewsDigest()` 是第一个被调用的函数，但是新闻信息却是最后才打印输出的，即便该新闻信息只是一行模拟文本。这是因为代码在读取和打印输出该信息时是异步的。

This app executes as follows:

1. The app begins executing.
2. The main function calls the `printDailyNewsDigest()` function, which does not return immediately, but calls `gatherNewsReports()`.
3. `gatherNewsReports()` starts gathering news and returns a `Future`.
4. `printDailyNewsDigest()` uses `then()` to specify a response to the `Future`. Calling `then()` returns a new `Future` that will complete with the value returned by `then()`'s callback.
5. The remaining print functions execute. Because they're synchronous, each function executes fully before moving on to the next print function. For example, the winning lottery numbers are all printed before the weather forecast is printed.
6. When all of the news has arrived, the `Future` returned by `gatherNewsReports()` completes with a string containing the gathered news.
7. The code specified by `then()` in `printDailyNewsDigest()` runs, printing the news.
8. The app exits.

该应用的执行流程如下：

1. 应用开始执行。
2. main函数开始调用 `printDailyNewsDigest()` 函数，该函数不会立即返回，而是进一步调用 `gatherNewsReports()` 函数。
3. `gatherNewsReports()` 函数开始搜集新闻信息并与之同时返回一个 `Future` 的实例对象。
4. 在 `printDailyNewsDigest()` 函数中使用 `Future` 的 `then()` 方法为 `Future` 实例对象设置一个响应操作。 `then()` 方法会返回一个新的 `Future` 对象实例，该对象中包含了传入 `then()` 方法的回调函数所返回的值。
5. 执行其它的打印输出函数。因为这些函数是同步的，所以每一个函数完整地执行完后才会执行下一个函数。例如乐透的中奖号码一定会在天气预报之前打印出来。
6. 当所有的新闻搜集完成后，函数 `gatherNewsReports()` 返回的 `Future` 实例对象也完成并携带一个包含了搜集了新闻信息的字符串。
7. 执行函数 `printDailyNewsDigest()` 中 `then()` 方法指定的代码打印出新闻。
8. 应用执行完毕。

<aside class="alert alert-info" markdown="1">
  **Note:** In the `printDailyNewsDigest()` function, the code `future.then(print)` is equivalent to the following:<br>
  `future.then((newsDigest) => print(newsDigest))`

  **注意：**在函数 `printDailyNewsDigest()` 中，代码 `future.then(print)` 等价于：<br>
  `future.then((newsDigest) => print(newsDigest))`
{% comment %}

TODO: When https://github.com/dart-lang/site-www/issues/1158 is fixed, link to the descriptions of lambdas and tear-offs.

<?code-excerpt "misc/lib/tutorial/daily_news.dart (main-future-api-dont-pass-print)"?>
{% prettify dart %}
future.then((newsDigest) => print(newsDigest))
{% endprettify %}
{% endcomment %}
</aside>

Alternatively, the code inside `then()` can use curly braces:

你也可以选择在 `then()` 方法中使用花括号的方式编写代码：

<?code-excerpt "misc/lib/tutorial/daily_news.dart (main-future-api-using-braces)"?>
{% prettify dart %}
Future<void> printDailyNewsDigest() {
  final future = gatherNewsReports();
  return future.then((newsDigest) {
    print(newsDigest);
    // Do something else...
    // 处理其它的逻辑...
  });
}
{% endprettify %}

You need to provide an argument to `then()`'s callback, even if the `Future` is of type `Future<void>`. By convention, an unused argument is named `_` (underscore).

你始终需要向 `then()` 方法的回调函数提供一个参数，即便其 `Future` 实例对象的类型为 `Future<void>`。按照管理，你可以使用名为 `_` （下划线）的参数表示无实际意义的参数。

<?code-excerpt "misc/lib/tutorial/daily_news.dart (main-future-api-then-no-arg)"?>
```dart
final future = printDailyNewsDigest();
return future.then((_) {
  // Code that doesn't use the `_` parameter...
  // 这里的代码中不会使用到 `_` 这个参数...
  print('All reports printed.');
});
```

### Handling errors {#handling-errors-future-api}
### 错误处理 {#handling-errors-future-api}

With the `Future` API, you can capture an error using `catchError()`:

当你使用 `Future` 类的相关API实现异步操作时，可以通过 `catchError()` 方法捕获异步操作的错误。

<?code-excerpt "misc/lib/tutorial/daily_news.dart (future-api-try-catch)"?>
{% prettify dart %}
Future<void> printDailyNewsDigest() =>
    gatherNewsReports().then(print).catchError(handleError);
{% endprettify %}

If the news stream isn't available for reading, the code above executes as follows:

1. The future returned by `gatherNewsReports()` completes with an error.
2. The future returned by `then()` completes with an error; `print()` isn't called.
3. The callback for `catchError()` (`handleError()`) handles the error, the future returned by `catchError()` completes normally, and the error does not propagate.

如果新闻流不可读，上述代码执行则会经过下列步骤：

1. 函数 `gatherNewsReports()` 返回的future对象将包含一个错误。
2. 方法 `then()` 返回的future对象也会包含一个错误，因此 `print()` 函数不会被调用。
3. 方法 `catchError()` 的回调函数(`handleError()`)将处理该错误，而由 `catchError()` 方法返回的future对象将正常完成并且错误不再继续传递。

<aside class="alert alert-info" markdown="1">
  Chaining `catchError()` to `then()` is a common pattern when using the `Future` API. **Consider this pairing the `Future` API's equivalent of try-catch blocks.**

  使用 `Future` 的相关API实现异步操作时，在 `then()` 方法后调用 `catchError()` 方法是一种常见的模式。**你可以将这两个方法在 `Future` API中的使用看作与try-catch语句块相同**
</aside>

Like `then()`, `catchError()` returns a new `Future` that completes with the return value of its callback.

与 `then()` 方法类似的是， `catchError()` 方法会返回一个新的 `Future` 的实例对象，该对象会携带其回调函数所返回的值。

For more details and examples, read [Futures and Error Handling][].

更多详情和示例请参阅[Futures and Error Handling][]。

### Calling multiple functions that return futures {#calling-multiple-funcs}
### 调用多个返回future对象的函数 {#calling-multiple-funcs}

Consider three functions, `expensiveA()`, `expensiveB()`, and `expensiveC()`, that return `Future` objects.  You can invoke them sequentially (one function starts when a previous one completes), or you can kick off all of them at the same time and do something once all the values return. The `Future` interface is fluid enough to deal with both use cases.

假设有三个函数：`expensiveA()`、`expensiveB()`、`expensiveC()`，它们都返回 `Future` 实例对象。你可以按顺序调用它们（即在一个函数执行完成后再调用另一个），或者你也可以让它们同时开始执行并在所有函数都返回后再执行你的逻辑。`Future` 的API中提供了相关的方法来处理这两种情况。

#### Chaining function calls using then()
#### 使用then()方法链式调用函数

When `Future`-returning functions need to run in order, use chained `then()` calls:

当函数返回的 `Future` 需要顺序调用时，可以使用 `then()` 方法来完成此类调用：

<?code-excerpt "misc/lib/tutorial/misc.dart (chaining)"?>
{% prettify dart %}
expensiveA()
    .then((aValue) => expensiveB())
    .then((bValue) => expensiveC())
    .then((cValue) => doSomethingWith(cValue));
{% endprettify %}

Nested callbacks also work, but they're harder to read and not as Dart-y.

嵌套的回调在这依然有效，但是这种方式理解起来比普通的Dart属性参数更难。

#### Waiting on multiple futures to complete using Future.wait()
#### 使用wait()方法等待多个future对象完成

If the order of execution of the functions is not important, you can use `Future.wait()`.

如果函数之间不需要按顺序调用，那么你可以使用 `Future` 的 `wait()` 方法。

When you pass `Future.wait()` a list of futures, it immediately returns a `Future`. That future doesn't complete until all of the given futures have completed. Then it completes with a list containing the values produced by each future in the original list.

当你向 `Future` 的 `wait()` 方法中传入多个future对象时，该方法会立即返回一个 `Future` 的对象。当且仅当所有传入 `wait()` 方法的future对象完成时该返回的future对象才会完成。该返回的future对象完成时，会携带一个列表，该列表中包含了之前传入 `wait()` 方法中的所有future对象完成时所携带的值。

<?code-excerpt "misc/lib/tutorial/misc.dart (Future-wait)"?>
{% prettify dart %}
Future.wait([expensiveA(), expensiveB(), expensiveC()])
    .then((List responses) => chooseBestResponse(responses, moreInfo))
    .catchError(handleError);
{% endprettify %}

If any of the invoked functions completes with an error, the `Future` returned by `Future.wait()` also completes with an error. Use `catchError()` to handle the error.

如果调用的任意一个函数在执行时出现错误，`Future` 的 `wait()` 方法在执行完这些函数后同样也会包含该错误。你可以使用 `catchError()` 方法来处理该错误。

{% endcomment %}

## Other resources {#other-resources}
## 其它资源信息 {#other-resources}

Read the following documentation for more details on using futures and asynchronous programming in Dart:

* [Asynchrony support](/guides/language/language-tour#asynchrony-support), a section in the [language tour](/guides/language/language-tour).
* API reference documentation for [futures,][Future][isolates,][isolate] and [web workers.][worker]

可以阅读下面的文档获取更多关于在Dart中使用future和异步编程的信息：

* [Dart开发语言概览](/guides/language/language-tour)中的[异步支持](/guides/language/language-tour#asynchrony-support)部分。
* [futures,][Future][isolates,][isolate]以及[web workers.][worker]的API参考文档。

## What next? {#what-next}
* Read the [streams教程](streams), which shows you how to work with an event stream.

## 接下来做什么？ {#what-next}
* 查阅[streams教程](streams)，可以获取更多关于如何使用事件流的文档。

[Future]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-async/Future-class.html
[Futures and Error Handling]: /guides/libraries/futures-error-handling
[isolate]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-isolate/dart-isolate-library.html
[worker]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-html/Worker-class.html
