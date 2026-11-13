---
# title: Add interactivity to your app
title: 为应用添加交互
# shortTitle: Interactivity
shortTitle: 交互
# description: >-
#   Add simple commands to your cli application.
#   Learn the fundamentals of Dart syntax including
#   control flow, collections, variables, functions, and more.
description: >-
  为 CLI 应用添加简单命令。
  学习 Dart 语法基础，包括控制流、集合、变量、函数等。
layout: learn
ai-translated: true
---

In this chapter, you'll get hands-on practice with Dart syntax.
You'll learn how to read user input, print usage information, and
create a basic command-line interaction.

在本章中，你将动手练习 Dart 语法。
你将学习如何读取用户输入、打印用法信息，
以及创建基本的命令行交互。

<SummaryCard>
title: 你将完成的内容
items:
  - title: 用 if 语句构建命令处理逻辑
    icon: account_tree
  - title: 使用列表和变量
    icon: data_array
  - title: 在代码中处理可空性
    icon: help_outline
  - title: 定义并调用函数
    icon: function
  - title: 读取并处理用户输入
    icon: keyboard
</SummaryCard>

## Prerequisites

## 准备工作

Before you begin this chapter, ensure you have:

开始本章之前，请确认你已经：

- Completed Chapter 1 and have a working Dart development environment.

  完成了第 1 章，并且有可用的 Dart 开发环境。

- Familiarity with basic programming concepts
  (variables, data types, control flow).

  熟悉基本编程概念
  （变量、数据类型、控制流）。

## Tasks

## 任务

Add some basic functionality to your **Dartpedia** command-line application and
then explore the Dart syntax for it.

为你的 **Dartpedia** 命令行应用加上一些基本功能，
然后顺着这些代码熟悉 Dart 语法。

### Task 1: Implement version and help commands

### 任务 1：实现 version 与 help 命令

1.  **Implement the `version` command in `cli/bin/cli.dart`:**
    Add logic to handle a `version` command,
    which prints the current version of the CLI.
    Use an `if` statement to check if the first argument provided is `version`.
    You'll also need a `version` constant.

    **在 `cli/bin/cli.dart` 中实现 `version` 命令：**
    添加处理 `version` 命令的逻辑，让它打印 CLI 的当前版本。
    用 `if` 语句检查传入的第一个参数是不是 `version`。
    你还需要一个 `version` 常量。

    First, above your `main` function,
    declare a `const` variable for the version.
    The value of a `const` variable can never be changed after it's been set:

    首先，在 `main` 函数上方声明一个表示版本的 `const` 变量。
    `const` 变量的值一旦设定，就不能再改：

    ```dart
    const version = '0.0.1'; // Add this line
    ```

    Next, modify your `main` function to check for the `version` argument:

    接下来，修改 `main` 函数，检查 `version` 参数：

    ```dart
    void main(List<String> arguments) {
      if (arguments.isEmpty) {
        print('Hello, Dart!');
      } else if (arguments.first == 'version') {
        print('Dartpedia CLI version $version');
      }
    }
    ```
    The `$version` syntax is called string interpolation.
    It lets you embed the value of the variable directly into
    a string by prefixing the variable name with a `$` sign.

    `$version` 这种写法叫做字符串插值。
    在变量名前加上 `$`，就可以把变量的值直接嵌进字符串。

1.  **Test the `version` command:**
    Run your application with the version argument:

    **测试 `version` 命令：**
    带上 version 参数运行应用：

    ```bash
    dart bin/cli.dart version
    ```

    You should now see:

    你现在应该会看到：

    ```bash
    Dartpedia CLI version 0.0.1
    ```

    If you run your app without arguments, you'll still see "Hello, Dart!".

    如果不带参数运行应用，你仍然会看到「Hello, Dart!」。

1.  **Add a `printUsage` function:**
    To make the output more user-friendly,
    create a separate function to display usage information.
    Place this function outside and below your `main` function.

    **添加 `printUsage` 函数：**
    为了让输出更易读，单独写一个函数来显示用法信息。
    把这个函数放在 `main` 函数外面、它的下方。

    ```dart
    void printUsage() { // Add this new function
      print(
        "The following commands are valid: 'help', 'version', 'search <ARTICLE-TITLE>'"
      );
    }
    ```

    `search` is the command that will eventually search from Wikipedia.

    `search` 是之后用来搜索 Wikipedia 的命令。

1.  **Implement the `help` command and refine `main`:**
    Now, integrate the `help` command using an `else if` statement,
    and clean up the default behavior to call the `printUsage` function.

    **实现 `help` 命令，并完善 `main`：**
    现在用 `else if` 语句接入 `help` 命令，
    并把默认行为改成调用 `printUsage` 函数。

    Modify your `main` function to look like this:

    把 `main` 函数改成下面这样：

    ```dart
    void main(List<String> arguments) {
      if (arguments.isEmpty || arguments.first == 'help') {
        printUsage(); // Change this from 'Hello, Dart!'
      } else if (arguments.first == 'version') {
        print('Dartpedia CLI version $version');
      } else {
        printUsage(); // Catch-all for any unrecognized command.
      }
    }
    ```

1.  **Understand the `if/else` structure and variables:**
    Now that you've implemented control flow in the `main` function,
    review the code that was added for it.

    **理解 `if/else` 结构和变量：**
    你已经在 `main` 函数里实现了控制流，
    现在回顾一下为此添加的代码。

    - `arguments.isEmpty` checks if no command-line arguments were provided.

      `arguments.isEmpty` 用来检查是否没有提供命令行参数。

    - `arguments.first` accesses the very first argument,
      which you're using as our command.

      `arguments.first` 访问第一个参数，
      你把它当作命令来用。

    - `version` is declared as a `const`.
      This means its value is known at compile time, and
      you can't change it during runtime.

      `version` 声明为 `const`。
      这意味着它的值在编译期就已确定，
      运行时不能再改。

    - `arguments` is a regular (non-constant) variable because
      its content can change during runtime based on user input.

      `arguments` 是普通（非常量）变量，
      因为它的内容会在运行时随用户输入而变化。

    Run your application with the help argument.
    You should see the usage information printed:

    带上 help 参数运行应用。
    你应该会看到打印出的用法信息：

    ```bash
    dart bin/cli.dart help
    ```

    Also, try running it without any arguments:

    也可以试着不带任何参数运行：

    ```bash
    dart bin/cli.dart
    ```

    Notice that it continues to display usage information.
    At this point, any command you haven't defined will
    also print usage information. This is expected behavior for now.

    注意，它仍然会显示用法信息。
    目前，任何你还没定义的命令也会打印用法信息。
    这是现阶段的预期行为。

### Task 2: Implement the search command

### 任务 2：实现 search 命令

Next, implement a basic `search` command that takes an article title as input.
As you build this functionality, you'll work with
`List` manipulation, null checks, and string interpolation.

接下来，实现一个基本的 `search` 命令，它接收文章标题作为输入。
在构建这个功能时，你会用到
`List` 操作、空值检查和字符串插值。

1.  **Integrate the `search` command into `main`:**
    First, modify the `main` function in `cli/bin/cli.dart` to
    include an `else if` branch that handles the `search` command.
    For now, just print a placeholder message.

    **把 `search` 命令接入 `main`：**
    首先，修改 `cli/bin/cli.dart` 中的 `main` 函数，
    加上处理 `search` 命令的 `else if` 分支。
    目前先打印一条占位消息。

    ```dart
    void main(List<String> arguments) {
      if (arguments.isEmpty || arguments.first == 'help') {
        printUsage();
      } else if (arguments.first == 'version') {
        print('Dartpedia CLI version $version');
      } else if (arguments.first == 'search') {
        // Add this new block:
        print('Search command recognized!');
      } else {
        printUsage();
      }
    }
    ```

1.  **Test the new command:**
    Run your application with the `search` command:

    **测试新命令：**
    带上 `search` 命令运行应用：

    ```bash
    dart bin/cli.dart search
    ```

    You should see:

    你应该会看到：

    ```bash
    Search command recognized!
    ```

1.  **Define the `searchWikipedia` function:**
    The `search` command will eventually run the core logic of your application
    by calling a function called `searchWikipedia`.
    For now, have `searchWikipedia` print the
    arguments passed into it with the `search` command.
    Place this new function below `main`.

    **定义 `searchWikipedia` 函数：**
    `search` 命令最终会调用名为 `searchWikipedia` 的函数，
    来运行应用的核心逻辑。
    目前，让 `searchWikipedia` 打印随 `search` 命令传入的参数。
    把这个新函数放在 `main` 下方。

    ```dart
    // ... (your existing main function)

    void searchWikipedia(List<String>? arguments) { // Add this new function and add ? to arguments type
      print('searchWikipedia received arguments: $arguments');
    }

    // ... (your existing printUsage() function)
    ```

    Highlights from the preceding code:

    上面这段代码的要点：

    -  `List<String>? arguments` means that the `arguments` list itself
       can be `null`.

       `List<String>? arguments` 表示 `arguments` 列表本身
       可以为 `null`。

       :::note
       Dart enforces [sound null safety][], which means you
       have to explicitly state when a variable can be null.
       Any variable that isn't marked as nullable is
       _guaranteed_ to never be null, even in production.

       The purpose of null safety isn't to
       stop you from ever using null in your code, because
       representing the absence of a value can be valuable.
       Rather, it's to force you to consider nullability and
       therefore be more careful about it.
       Along with the analyzer, this helps prevent
       one of the most common runtime crashes in programming:
       null-pointer errors.

       Dart 强制执行 [健全的空安全][sound null safety]，
       这意味着你必须显式声明一个变量何时可以为 null。
       任何没有标记为可空的变量，都 **保证** 永远不会是 null，
       即使在生产环境中也是如此。

       空安全的目的并不是让你在代码里完全不用 null，
       因为用 null 表示「没有值」本身很有用。
       它要做的是促使你认真考虑可空性，从而更加小心。
       再加上分析器，这有助于避免编程中最常见的一类运行时崩溃：
       空指针错误。
       :::

1.  **Call the `searchWikipedia` function from the `main` function:**
    Now, modify the `search` command block in `main` to
    call `searchWikipedia` and pass it any arguments that
    come after the `search` command itself.
    Use `arguments.sublist(1)` to get all arguments
    starting from the second one. If no arguments are provided after `search`,
    pass `null` to `searchWikipedia`.

    **在 `main` 函数中调用 `searchWikipedia`：**
    现在，修改 `main` 里的 `search` 命令分支，
    调用 `searchWikipedia`，并把 `search` 命令本身之后的参数传给它。
    用 `arguments.sublist(1)` 取得从第二个参数开始的全部参数。
    如果 `search` 后面没有参数，就向 `searchWikipedia` 传入 `null`。

    ```dart
    void main(List<String> arguments) {
      if (arguments.isEmpty || arguments.first == 'help') {
        printUsage();
      } else if (arguments.first == 'version') {
        print('Dartpedia CLI version $version');
      } else if (arguments.first == 'search') {
        // Add this new block:
        final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
        searchWikipedia(inputArgs);
      } else {
        printUsage();
      }
    }
    ```

    Highlights from the preceding code:

    上面这段代码的要点：

    - `final` variables can only be set once and are used when
      you never intend to change the variable again in the code.

      `final` 变量只能赋值一次。
      当你不打算在代码里再次修改这个变量时，就用它。

    - `arguments.sublist(1)` creates a new list containing all elements of
      the `arguments` list _after_ the first element (which was `search`).

      `arguments.sublist(1)` 会创建一个新列表，
      包含 `arguments` 列表中第一个元素 **之后** 的所有元素
      （第一个元素是 `search`）。

    - `arguments.length > 1 ? ... : null;` is a conditional (ternary) operator.
      It ensures that if no arguments are provided after the `search` command,
      `inputArgs` becomes `null`, matching the sample code's behavior for
      `searchWikipedia`'s `arguments` parameter of `List<String>?`.

      `arguments.length > 1 ? ... : null;` 是条件（三元）运算符。
      这样，如果 `search` 命令后面没有参数，
      `inputArgs` 就会变成 `null`，
      与示例代码中 `searchWikipedia` 的
      `arguments` 参数类型 `List<String>?` 的行为一致。

1.  **Test `searchWikipedia` with arguments:**
    Using the command line, run the application with a test article title:

    **带参数测试 `searchWikipedia`：**
    在命令行中带上一个测试用的文章标题来运行应用：

    ```bash
    dart bin/cli.dart search Dart Programming
    ```

    You should see:

    你应该会看到：

    ```bash
    searchWikipedia received arguments: [Dart, Programming]
    ```

    Next, run the same command without the extra arguments:

    接下来，不带额外参数运行同一条命令：

    ```bash
    dart bin/cli.dart search
    ```

    You should see:

    你应该会看到：

    ```bash
    searchWikipedia received arguments: null
    ```

1.  **Handle the missing article title and
    user input with the `stdin` command:**
    It's more user-friendly to prompt the user if
    they don't provide an article title on the command line.
    Use `stdin.readLineSync()` for this.

    **用 `stdin` 处理缺失的文章标题和用户输入：**
    如果用户没有在命令行中提供文章标题，提示用户输入会更友好。
    这里使用 `stdin.readLineSync()`。

    First, add the necessary import at the top of your `cli/bin/cli.dart` file:

    首先，在 `cli/bin/cli.dart` 文件顶部添加必要的 import：

    ```dart
    import 'dart:io'; // Add this line at the top
    ```

    `dart:io` is a core library in the Dart SDK, and
    provides APIs to deal with files, directories, sockets, and
    HTTP clients and servers, and more.

    `dart:io` 是 Dart SDK 中的核心库，
    提供处理文件、目录、套接字、
    HTTP 客户端与服务器等 API。

    Now, update your `searchWikipedia` function.

    现在，更新 `searchWikipedia` 函数。

    ```dart
    void searchWikipedia(List<String>? arguments) {
      final String articleTitle;

      // If the user didn't pass in arguments, request an article title.
      if (arguments == null || arguments.isEmpty) {
        print('Please provide an article title.');
        // Await input and provide a default empty string if the input is null.
        articleTitle = stdin.readLineSync() ?? '';
      } else {
        // Otherwise, join the arguments into a single string.
        articleTitle = arguments.join(' ');
      }

      print('Current article title: $articleTitle');
    }
    ```

    This preceding code block introduces a few key concepts:

    上面这段代码引入了几个关键概念：

    - It declares a `final String articleTitle` variable.
      This allows static analysis to detect that
      `articleTitle` will be a `String` and won't be null.

      它声明了 `final String articleTitle` 变量。
      这样静态分析就能判断出
      `articleTitle` 会是 `String`，并且不会是 null。

    - An `if/else` statement then checks if command-line arguments for
      the search were provided.

      随后用 `if/else` 语句检查是否提供了搜索用的命令行参数。

    - If arguments are missing, it prompts the user,
      reads input using `stdin.readLineSync()`, and
      safely handles cases where no input is given.

      如果缺少参数，它会提示用户，
      用 `stdin.readLineSync()` 读取输入，
      并安全处理没有输入的情况。

    - If arguments _are_ present, it uses `arguments.join(' ')` to
      combine them into a single search string.

      如果参数 **确实** 存在，它会用 `arguments.join(' ')`
      把它们合并成一个搜索字符串。

    Highlights from the preceding code:

    上面这段代码的要点：

    - `stdin.readLineSync() ?? ''` reads the input from the user.
      While `stdin.readLineSync()` can return null,
      the null-coalescing operator (`??`) is used to provide
      an empty string (`''`) as a fallback if the input is null.
      This is a concise way to ensure that the variable is a non-null string.

      `stdin.readLineSync() ?? ''` 读取用户输入。
      虽然 `stdin.readLineSync()` 可能返回 null，
      但这里用空值合并运算符 (`??`)，
      在输入为 null 时回退到空字符串 (`''`)。
      这是一种简洁的写法，用来确保变量是非空字符串。

    - `arguments.join(' ')` concatenates all elements of the `arguments` list
      into a single string, using a space as the separator.
      For example, `['Dart', 'Programming']` becomes `"Dart Programming"`.
      This is crucial for treating multi-word
      command-line inputs as a single search phrase.

      `arguments.join(' ')` 把 `arguments` 列表中的所有元素
      拼接成一个字符串，分隔符是空格。
      例如，`['Dart', 'Programming']` 会变成 `"Dart Programming"`。
      这对于把多个单词的命令行输入当作一个搜索短语非常重要。

    - Dart static analysis can detect that `articleTitle` is
      guaranteed to be initialized when the print statement is executed.
      No matter which path is taken through this function body,
      the variable is non-nullable.

      Dart 静态分析能够判断，
      执行 print 语句时 `articleTitle` 一定已经初始化。
      无论函数体走哪条路径，这个变量都是不可空的。

1.  **Finish `searchWikipedia` to print mock search results:**
    Update `searchWikipedia` to display messages that
    look like our program found something.
    This helps us see what our finished program will do without
    actually building everything right now.
    You'll only see these messages if you
    include a search query when you run the program.

    **完善 `searchWikipedia`，打印模拟的搜索结果：**
    更新 `searchWikipedia`，让它显示一些看起来像是程序找到了结果的消息。
    这样你不用现在就把所有功能做完，也能看出完成后的程序会做什么。
    只有在运行程序时带上搜索查询，你才会看到这些消息。

    For example: `dart bin/cli.dart search Dart Programming`.

    例如：`dart bin/cli.dart search Dart Programming`。

    ```dart
    void searchWikipedia(List<String>? arguments) {
      final String articleTitle;

      // If the user didn't pass in arguments, request an article title.
      if (arguments == null || arguments.isEmpty) {
        print('Please provide an article title.');
        // Await input and provide a default empty string if the input is null.
        articleTitle = stdin.readLineSync() ?? '';
      } else {
        // Otherwise, join the arguments into a single string.
        articleTitle = arguments.join(' ');
      }

      print('Looking up articles about "$articleTitle". Please wait.');
      print('Here ya go!');
      print('(Pretend this is an article about "$articleTitle")');
    }
    ```

1.  **Final Test Run with both scenarios:**

    **用两种场景做最后一次测试：**

    Now that the article simulation is set up,
    test the `searchWikipedia` function in a few different ways:

    文章模拟已经就绪，
    用几种不同方式测试 `searchWikipedia` 函数：

    ```bash
    dart bin/cli.dart search Dart Programming
    ```

    You should see:

    你应该会看到：

    ```bash
    Looking up articles about "Dart Programming". Please wait.
    Here ya go!
    (Pretend this is an article about "Dart Programming")
    ```

    Run without arguments (type "Flutter Framework" when prompted):

    不带参数运行（出现提示时输入「Flutter Framework」）：

    ```bash
    dart bin/cli.dart search
    ```

    ```bash
    Please provide an article title.
    Flutter Framework
    ```

    You have now successfully built the basic `search` command with
    user input handling, correctly treating multi-word command-line inputs as
    a single search phrase in the output.

    你已经成功实现了带用户输入处理的基本 `search` 命令，
    并能在输出中把多个单词的命令行输入正确地当作一个搜索短语。

[sound null safety]: /null-safety

## Review

## 回顾

<SummaryCard>
title: 你完成的内容
subtitle: 以下是你在本课中构建并学到的内容摘要。
completed: true
items:
  - title: 用 if 和 else 语句构建了命令处理逻辑
    icon: account_tree
    details: >-
      你使用 `if` 和 `else` 语句，
      把 `help`、`version` 和 `search` 等不同命令分流处理。
      这种控制流模式是构建能响应用户输入的交互式 CLI 应用的基础。
  - title: 使用了列表和变量
    icon: data_array
    details: >-
      你学习了用 `var`、`final` 和 `const` 声明变量，
      并用 `.isEmpty`、`.first`、`.sublist()` 和 `.join()` 操作列表。
      你还使用字符串插值（`$variable`）把值嵌进字符串字面量。
  - title: 在代码中处理了可空性
    icon: help_outline
    details: >-
      你借助 Dart 健全的空安全，使用可空类型（`?`）、
      空值检查和空值合并运算符（`??`），
      在表达式可能为 `null` 时提供默认值。
  - title: 定义并调用了函数
    icon: function
    details: >-
      你创建了 `printUsage()` 和 `searchWikipedia()` 函数，
      把代码组织成可复用的单元。
      把可复用逻辑拆到函数里，有助于保持 `main` 函数简洁，
      也让代码更容易阅读和维护。
  - title: 读取并处理了用户输入
    icon: keyboard
    details: >-
      你使用 `dart:io` 中的 `stdin.readLineSync()` 从终端读取输入。
      这样就可以用交互式提示，
      作为命令行参数的替代或补充。
</SummaryCard>

## Quiz

## 测验

<!-- title: Check your understanding -->
<Quiz title="检查你的理解" id="interactivity" />

## Next lesson

## 下一课

In the next chapter, you'll dive into
asynchronous programming and learn how to
fetch data from the Wikipedia API using the `http` package.
This will allow your application to
retrieve real data and display it to the user.

在下一章中，你将深入异步编程，
并学习如何使用 `http` package 从 Wikipedia API 获取数据。
这样你的应用就能获取真实数据并展示给用户。
