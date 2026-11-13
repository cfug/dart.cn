---
# title: Write asynchronous code
title: 编写异步代码
# shortTitle: Async code
shortTitle: 异步代码
# description: >-
#   Learn about asynchronous programming in Dart and how to make HTTP requests.
description: 了解 Dart 中的异步编程，以及如何发出 HTTP 请求。
layout: learn
ai-translated: true
---

In this chapter, you'll explore asynchronous programming in Dart,
allowing your applications to perform multiple tasks concurrently.
You'll learn how to fetch data from the internet using the `http` package,
to retrieve an article summary from Wikipedia.

在本章中，你将探索 Dart 中的异步编程，
让应用可以同时执行多项任务。
你将学习如何使用 `http` package 从互联网获取数据，
以取得 Wikipedia 上的文章摘要。

<SummaryCard>
title: 你将完成的内容
items:
  - title: 用 Future 和 await 编写异步代码
    icon: sync
  - title: 安装并使用外部 package
    icon: package_2
  - title: 从 Wikipedia API 获取实时数据
    icon: cloud_download
</SummaryCard>

## Prerequisites

## 准备工作

- Completion of Chapter 2, which covered
  basic Dart syntax and command-line interaction.
  You should have a `dartpedia` project set up.

  已完成第 2 章，其中介绍了
  基本的 Dart 语法和命令行交互。
  你应该已经建好了 `dartpedia` 项目。
- Familiarity with the concept of APIs ([Application Programming Interfaces][])
  as a way to retrieve data.

  熟悉 API（[应用程序编程接口][Application Programming Interfaces]）的概念，
  把它当作获取数据的一种方式。

[Application Programming Interfaces]: https://www.postman.com/what-is-an-api/

## Tasks

## 任务

In this chapter, you will
modify the existing `dartpedia` CLI application to
fetch and display an **[article summary][]** using
the `http` package and asynchronous programming techniques.

在本章中，你将修改现有的 `dartpedia` CLI 应用，
使用 `http` package 和异步编程技术
获取并显示 **[文章摘要][article summary]**。

[article summary]: http://en.wikipedia.org/api/rest_v1/#/Page%20content/get_page_summary__title_

### Task 1: Add the http dependency

### 任务 1：添加 http 依赖

Before you can make HTTP requests,
you need to add the `http` package as a
dependency to your project.

在发出 HTTP 请求之前，
你需要把 `http` package 添加为项目的依赖。

1.  Open the `dartpedia/cli/pubspec.yaml` file within your project.
    This file is called the **pubspec**, and it manages your
    Dart project's metadata, dependencies (like the `http` package), and assets.

    打开项目中的 `dartpedia/cli/pubspec.yaml` 文件。
    这个文件叫做 **pubspec**，它管理
    Dart 项目的元数据、依赖（例如 `http` package）和资源。
1.  Locate the `dependencies` section.

    找到 `dependencies` 部分。
1.  Add `http: ^1.4.0` (or the latest stable version) under `dependencies`.
    The `^` symbol allows compatible versions to be used.

    在 `dependencies` 下添加 `http: ^1.4.0`（或最新的稳定版本）。
    `^` 符号表示可以使用兼容的版本。

    ```yaml
    dependencies:
      http: ^1.4.0
    ```

1.  Save the `pubspec.yaml` file.

    保存 `pubspec.yaml` 文件。
1.  Run `dart pub get` in your terminal from the `dartpedia/cli` directory.
    This command fetches the newly added dependency and
    makes it available for use in your project.

    在终端中从 `dartpedia/cli` 目录运行 `dart pub get`。
    这条命令会获取新添加的依赖，
    并让项目可以使用它。

    You should see output similar to this:

    你应该会看到类似下面的输出：

    ```bash
    Resolving dependencies...
    Downloading packages...
    + http 1.4.0
      lints 5.1.1 (6.0.0 available)
    Changed 1 dependency!
    1 package has newer versions incompatible with dependency constraints.
    Try `dart pub outdated` for more information.
    ```

### Task 2: Import the http package

### 任务 2：导入 http package

Now that you've added the `http` package,
you need to import it into your Dart file to use its functionalities.

现在你已经添加了 `http` package，
需要把它导入 Dart 文件才能使用它的功能。

1.  Open the `dartpedia/bin/cli.dart` file.

    打开 `dartpedia/bin/cli.dart` 文件。
1.  Add the following `import` statement at the top of the file,
    along with the existing `dart:io` import:

    在文件顶部、现有的 `dart:io` import 旁边，
    添加下面这条 `import` 语句：

    ```dart
    import 'dart:io';
    import 'package:http/http.dart' as http; // Add this line
    ```

    This line imports the `http` package and gives it the alias `http`.
    After you do this, you can refer to classes and functions within
    the `http` package using `http.` (for example, `http.Client`, `http.get`).
    The `as http` part is a standard convention to avoid naming conflicts if
    another imported library also has a similarly named class or function.

    这一行导入 `http` package，并给它起别名 `http`。
    之后，你可以用 `http.` 引用该 package 中的类和函数
    （例如 `http.Client`、`http.get`）。
    `as http` 是一种常见约定，用来避免命名冲突，
    以防另一个导入的库也有同名的类或函数。

### Task 3: Implement the `getWikipediaArticle` function

### 任务 3：实现 `getWikipediaArticle` 函数

Now create a new function called `getWikipediaArticle` that
handles fetching data from an external API.
This function will be `async` because
network requests are asynchronous operations.

现在创建一个名为 `getWikipediaArticle` 的新函数，
用来从外部 API 获取数据。
这个函数将是 `async` 的，
因为网络请求是异步操作。

1.  **Define the function signature:**
    Below your `main` function (and `printUsage` function),
    add the following function signature.

    **定义函数签名：**
    在 `main` 函数（以及 `printUsage` 函数）下方，
    添加下面的函数签名。

    ```dart
    // ... (your existing printUsage() function)

    Future<String> getWikipediaArticle(String articleTitle) async {
      //You'll add more code here soon
    }
    ```

    Highlights from the preceding code:

    上面这段代码的要点：

    - The `Future<String>` return type indicates that
      this function will eventually produce a `String` result,
      but not immediately, because it's an asynchronous operation.

      `Future<String>` 返回类型表示
      这个函数最终会产生一个 `String` 结果，
      但不会立刻产生，因为它是异步操作。
    - The `async` keyword marks the function as asynchronous,
      allowing you to use `await` inside it.

      `async` 关键字把函数标记为异步，
      这样你就可以在函数体内使用 `await`。

1.  **Construct the API URL:**
    Inside your new `getWikipediaArticle` function,
    create a `Uri` object.
    The `Uri` represents the endpoint of the Wikipedia API that
    you'll be calling to get an article summary.

    **构造 API URL：**
    在新的 `getWikipediaArticle` 函数内部创建一个 `Uri` 对象。
    这个 `Uri` 表示你将调用的 Wikipedia API 端点，
    用来获取文章摘要。

    Add these lines inside the `getWikipediaArticle` function:

    把这些行添加到 `getWikipediaArticle` 函数内部：

    ```dart
    Future<String> getWikipediaArticle(String articleTitle) async {
      final url = Uri.https(
        'en.wikipedia.org', // Wikipedia API domain
        '/api/rest_v1/page/summary/$articleTitle', // API path for article summary
      );
      // ...
    }
    ```

1.  **Make the HTTP request and handle the response:**
    Now, use the top-level `get` function from `package:http` to
    make an HTTP `GET` request to the URL you just constructed.
    The `await` keyword pauses the execution of `getWikipediaArticle` until
    the `get` call completes and returns an `http.Response` object.

    **发出 HTTP 请求并处理响应：**
    现在，使用 `package:http` 的顶层 `get` 函数，
    向你刚构造的 URL 发出 HTTP `GET` 请求。
    `await` 关键字会暂停 `getWikipediaArticle` 的执行，
    直到 `get` 调用完成并返回 `http.Response` 对象。

    After the request completes, check the `response.statusCode` to
    ensure the request was successful (a status code of `200` means OK).
    If successful, return the `response.body`, which
    contains the fetched data (in this case, raw JSON).
    If the request fails, return an informative error message.

    请求完成后，检查 `response.statusCode`，
    确认请求成功（状态码 `200` 表示成功）。
    如果成功，返回 `response.body`，
    其中包含获取到的数据（这里是原始 JSON）。
    如果请求失败，返回一条说明性的错误消息。

    Add these lines after the `Uri` construction within `getWikipediaArticle`:

    在 `getWikipediaArticle` 中构造 `Uri` 之后添加这些行：

    ```dart
    Future<String> getWikipediaArticle(String articleTitle) async {
      final url = Uri.https(
        'en.wikipedia.org',
        '/api/rest_v1/page/summary/$articleTitle',
      );
      final response = await http.get(url); // Make the HTTP request

      if (response.statusCode == 200) {
        return response.body; // Return the response body if successful
      }

      // Return an error message if the request failed
      return 'Error: Failed to fetch article "$articleTitle". Status code: ${response.statusCode}';
    }
    ```

### Task 4: Integrate the API call into searchWikipedia

### 任务 4：把 API 调用接入 searchWikipedia

You'll integrate the API call into `searchWikipedia`.
This function will house the core logic for handling the `wikipedia` command.

你将把 API 调用接入 `searchWikipedia`。
这个函数将承载处理 `wikipedia` 命令的核心逻辑。

1.  **Update `searchWikipedia` to use `async`:**
    Locate your `searchWikipedia` function and
    update its signature to be `async` as it will now
    perform asynchronous operations.

    **更新 `searchWikipedia`，让它使用 `async`：**
    找到 `searchWikipedia` 函数，
    把它的签名更新为 `async`，
    因为它现在要执行异步操作。

    Your `searchWikipedia` function should now look like this:

    你的 `searchWikipedia` 函数现在应该如下所示：

    ```dart
    // ... (your existing main function)

    void searchWikipedia(List<String>? arguments) async { // Added 'async'
      final String articleTitle;

      // If the user didn't pass in arguments, request an article title.
      if (arguments == null || arguments.isEmpty) {
        print('Please provide an article title.');
        // Read input and provide a default empty string if the input is null.
        articleTitle = stdin.readLineSync() ?? '';
      } else {
        // Otherwise, join the arguments into a single string.
        articleTitle = arguments.join(' ');
      }

      print('Looking up articles about "$articleTitle". Please wait.');
      print('Here ya go!');
      print('(Pretend this is an article about "$articleTitle")');
    }

    // ... (your existing printUsage() function)
    ```

    Highlights from the preceding code:

    上面这段代码的要点：

    - `void searchWikipedia(List<String>? arguments) async`:
      The function is now `async`.
      This is essential because it will call `getWikipediaArticle`, which
      is an `async` function itself and will need to `await` its result.

      `void searchWikipedia(List<String>? arguments) async`：
      函数现在是 `async` 的。
      这很必要，因为它会调用 `getWikipediaArticle`，
      而那个函数本身也是 `async`，需要 `await` 它的结果。

1.  **Reject `null` or empty string input:**
    Right now, if the user runs `dart bin/cli.dart search` and
    presses <kbd>Enter</kbd> without typing a title,
    `stdin.readLineSync()` returns an empty string.
    If the user presses <kbd>Control</kbd>+<kbd>D</kbd> or
    <kbd>Control</kbd>+<kbd>Z</kbd> to send an end-of-file (EOF) signal,
    `stdin.readLineSync()` returns `null`,
    and `?? ''` falls back to an empty string.
    In either case, the CLI makes a pretend request to Wikipedia
    with an empty string as the article title.

    **拒绝 `null` 或空字符串输入：**
    目前，如果用户运行 `dart bin/cli.dart search`
    并在没有输入标题时按下 <kbd>Enter</kbd>，
    `stdin.readLineSync()` 会返回空字符串。
    如果用户按下 <kbd>Control</kbd>+<kbd>D</kbd> 或
    <kbd>Control</kbd>+<kbd>Z</kbd> 发送文件结束（EOF）信号，
    `stdin.readLineSync()` 会返回 `null`，
    `?? ''` 会回退到空字符串。
    无论哪种情况，CLI 都会用空字符串作为文章标题，
    向 Wikipedia 发出一次假请求。

    Replace the `?? ''` fallback with a check that prints a message
    and exits the function when no valid input is given.

    把 `?? ''` 回退替换成一次检查：
    没有有效输入时打印一条消息并退出函数。

    ```dart
    void searchWikipedia(List<String>? arguments) async {
      final String articleTitle;

      if (arguments == null || arguments.isEmpty) {
        print('Please provide an article title.');
        // Read input without the `?? ''` fallback.
        final inputFromStdin = stdin.readLineSync();
        if (inputFromStdin == null || inputFromStdin.isEmpty) {
          print('No article title provided. Exiting.');
          return; // Exit the function if there's no valid input.
        }
        articleTitle = inputFromStdin;
      } else {
        // Otherwise, join the arguments into a single string.
        articleTitle = arguments.join(' ');
      }

      print('Looking up articles about "$articleTitle". Please wait.');
      print('Here ya go!');
      print('(Pretend this is an article about "$articleTitle")');
    }
    ```

1.  **Call `getWikipediaArticle` and print the result:**
    Replace the two placeholder `print` lines at the end of `searchWikipedia`
    with a call to `getWikipediaArticle` and a single `print` of the result.

    **调用 `getWikipediaArticle` 并打印结果：**
    把 `searchWikipedia` 末尾的两行占位 `print`
    替换成对 `getWikipediaArticle` 的调用，以及一次打印结果的 `print`。

    ```dart
    void searchWikipedia(List<String>? arguments) async {
      final String articleTitle;

      if (arguments == null || arguments.isEmpty) {
        print('Please provide an article title.');
        final inputFromStdin = stdin.readLineSync();
        if (inputFromStdin == null || inputFromStdin.isEmpty) {
          print('No article title provided. Exiting.');
          return;
        }
        articleTitle = inputFromStdin;
      } else {
        articleTitle = arguments.join(' ');
      }

      print('Looking up articles about "$articleTitle". Please wait.');

      // Call the API and await the result.
      var articleContent = await getWikipediaArticle(articleTitle);
      print(articleContent); // Print the full article response (raw JSON for now)
    }
    ```

    Highlights from the preceding code:

    上面这段代码的要点：

    - `await getWikipediaArticle(articleTitle)`:
      Because `getWikipediaArticle` is an `async` function,
      you need to `await` its result.
      This pauses the `searchWikipedia` function until the
      `Future<String>` returned by `getWikipediaArticle` resolves into
      a `String` containing the article's contents.

      `await getWikipediaArticle(articleTitle)`：
      因为 `getWikipediaArticle` 是 `async` 函数，
      你需要 `await` 它的结果。
      这会暂停 `searchWikipedia`，直到
      `getWikipediaArticle` 返回的 `Future<String>`
      解析为包含文章内容的 `String`。
    - `print(articleContent)`:
      Prints the fetched article summary as a raw JSON string to the console.

      `print(articleContent)`：
      把获取到的文章摘要作为原始 JSON 字符串打印到控制台。

### Task 5: Update main to call searchWikipedia

### 任务 5：更新 main 以调用 searchWikipedia

Finally, update your `main` function to
call the new `searchWikipedia` function when
the `wikipedia` command is used.

最后，更新 `main` 函数，
在使用 `wikipedia` 命令时调用新的 `searchWikipedia` 函数。

1.  Locate the `else if` block in your `main` function that
    currently handles the `search` command.
    Change the command name from `search` to `wikipedia` and
    update the function call.

    找到 `main` 函数中当前处理 `search` 命令的 `else if` 块。
    把命令名从 `search` 改成 `wikipedia`，
    并更新函数调用。

    In the sample code, `main` does _not_ `await` the call to `searchWikipedia`,
    meaning `main` itself does not need to be marked `async`.

    在示例代码中，`main` **不会** `await` 对 `searchWikipedia` 的调用，
    因此 `main` 本身不需要标记为 `async`。

    Your `main` function should now look like this:

    你的 `main` 函数现在应该如下所示：

    ```dart
    // ... (existing const version declaration and printUsage function)

    void main(List<String> arguments) {
      if (arguments.isEmpty || arguments.first == 'help') {
        printUsage();
      } else if (arguments.first == 'version') {
        print('Dartpedia CLI version $version');
      } else if (arguments.first == 'wikipedia') { // Changed to 'wikipedia'
        // Pass all arguments *after* 'wikipedia' to searchWikipedia
        final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
        searchWikipedia(inputArgs); // Call searchWikipedia (no 'await' needed here for main)
      } else {
        printUsage(); // Catch all for any unrecognized command.
      }
    }
    ```

    - `arguments.sublist(1)`:
      This extracts all elements from the `arguments` list,
      starting from the second element (index 1).
      This effectively removes the `wikipedia` command itself,
      so `searchWikipedia` only receives the actual article title arguments.

      `arguments.sublist(1)`：
      这会从 `arguments` 列表中提取所有元素，
      从第二个元素（索引 1）开始。
      这样实际上去掉了 `wikipedia` 命令本身，
      于是 `searchWikipedia` 只收到真正的文章标题参数。
    - `searchWikipedia(inputArgs)`:
      This calls `searchWikipedia` directly.
      Since `main` doesn't need to
      do anything after `searchWikipedia` completes,
      you don't need to `await` it from `main`.
      Therefore `main` doesn't need to be `async`.

      `searchWikipedia(inputArgs)`：
      这会直接调用 `searchWikipedia`。
      因为 `main` 不需要在 `searchWikipedia` 完成后做任何事，
      所以不必在 `main` 里 `await` 它。
      因此 `main` 不需要是 `async`。

### Task 6: Run the application

### 任务 6：运行应用

Now that you've implemented the `http` request and
integrated it into your application, test it out.

现在你已经实现了 `http` 请求并把它接入应用，来测试一下。

1.  Open your terminal and run the following command:

    打开终端，运行以下命令：

    ```bash
    dart run bin/cli.dart wikipedia "Dart_(programming_language)"
    ```

1.  Check to make sure that the application fetched
    the summary of the "Dart" article from the Wikipedia API and
    print the raw JSON response to the console.
    You might see something like:

    请确认应用已经从 Wikipedia API 获取了
    「Dart」文章的摘要，
    并把原始 JSON 响应打印到控制台。
    你可能会看到类似这样的内容：

    ```bash
    Looking up articles about "Dart_(programming_language)". Please wait.
    {
      "type": "standard",
      "title": "Dart (programming language)",
      "displaytitle": "<span class=\"mw-page-title-main\">Dart (programming language)</span>",
      "namespace": {
          "id": 0,
          "text": ""
        }

      // ... (rest of the JSON output will be present but truncated here)

    }
    ```
1.  Next, try running without arguments.
    For example, when prompted, enter "Flutter_(software)".

    接下来，试着不带参数运行。
    例如，出现提示时输入「Flutter_(software)」。

    ```bash
    dart run bin/cli.dart wikipedia
    ```

    ```bash
    Please provide an article title.
    Flutter_(software)
    Looking up articles about "Flutter_(software)". Please wait.
    {
      "type": "standard",
      "title": "Flutter (software)",
      "displaytitle": "<span class=\"mw-page-title-main\">Flutter (software)</span>",
      "namespace": {
          "id": 0,
          "text": ""
      }

    // ... (rest of the JSON output will be present but truncated here)

    }
    ```
    You have now successfully implemented the basic `wikipedia` command that
    fetches real data from an external API!

    你已经成功实现了基本的 `wikipedia` 命令，
    它能从外部 API 获取真实数据！

## Review

## 回顾

<SummaryCard>
title: 你完成的内容
subtitle: 以下是你在本课中构建并学到的内容摘要。
completed: true
items:
  - title: 掌握了 Future、async 和 await
    icon: sync
    details: >-
      你了解到 `Future` 表示一个稍后才会就绪的值。
      `async` 关键字把函数标记为异步，
      `await` 会暂停执行，直到 `Future` 完成。
  - title: 把 http package 添加为依赖
    icon: package_2
    details: >-
      你修改了 `pubspec.yaml` 来添加 `http` package，
      运行 `dart pub get` 获取它，并用别名（`as http`）导入。
      按同样的步骤，可以从 pub.dev 添加任何外部 package。
  - title: 从 Wikipedia 获取了实时数据
    icon: cloud_download
    details: >-
      你构建了 `getWikipediaArticle()`，
      使用 `package:http` 的 `get` 函数发出 HTTP GET 请求，
      构造了 URI，检查了状态码，并返回响应体。
      你的 CLI 现在可以从网上获取真实数据了！
</SummaryCard>

## Quiz

## 测验

<!-- title: Check your understanding -->
<Quiz title="检查你的理解" id="async" />

## Next lesson

## 下一课

In the next chapter, you'll focus on
organizing our code into reusable libraries and packages.
You'll refactor your application to
improve its structure and maintainability by
creating a separate package for handling command-line arguments.

在下一章中，你将着重把代码组织成可复用的库和 package。
你将重构应用，
通过创建一个单独处理命令行参数的 package，
改善它的结构和可维护性。
