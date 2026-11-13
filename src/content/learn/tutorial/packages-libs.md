---
# title: Organize Dart code with packages and libraries
title: 用 package 和库组织 Dart 代码
# shortTitle: Packages and libraries
shortTitle: package 与库
# description: >-
#   Learn how to organize your Dart code into reusable libraries and packages.
description: 学习如何把 Dart 代码组织成可复用的库和 package。
layout: learn
ai-translated: true
---

<YoutubeEmbed id="En5lVTdmZIY" title="The Dart platform" fullWidth="true"></YoutubeEmbed>

In this chapter, you'll level up from basic Dart syntax to
building command-line applications "the Dart way," embracing best practices.
You'll learn to refactor your code into reusable components by
creating a dedicated package for handling command-line arguments.

在本章中，你将从基础 Dart 语法更进一步，
以「Dart 的方式」构建命令行应用，并采用最佳实践。
你将学习如何把代码重构为可复用的组件，
创建一个专门处理命令行参数的 package。

This step sets you up for building a more advanced
command-line application in future chapters,
which will integrate specialized packages for
Wikipedia logic and a robust `command_runner` framework.
This chapter helps you understand Dart libraries, export statements, and
how to structure your project for better organization and maintainability.

这一步为后续章节构建更高级的命令行应用做好准备。
后面会接入专门处理 Wikipedia 逻辑的 package，
以及一套稳健的 `command_runner` 框架。
本章帮助你理解 Dart 的库、export 语句，
以及如何组织项目，让它更清晰、也更容易维护。

<SummaryCard>
title: 你将完成的内容
items:
  - title: 创建一个可复用的 Dart package
    icon: package_2
  - title: 用 export 定义公开 API
    icon: export_notes
  - title: 添加本地路径依赖
    icon: folder_code
</SummaryCard>

## Prerequisites

## 准备工作

- Completion of Chapter 3, which covered
  asynchronous programming and HTTP requests.

  已完成第 3 章，其中介绍了异步编程和 HTTP 请求。

## Tasks

## 任务

In this chapter, you'll be
refactoring the existing `dartpedia` CLI application by
extracting the command-line argument parsing logic into
a separate package called `command_runner`.
This will improve the structure of your project,
making it more modular and maintainable.

在本章中，你将重构现有的 `dartpedia` CLI 应用，
把命令行参数解析逻辑抽到一个名为 `command_runner` 的独立 package 中。
这会改善项目结构，让它更模块化，也更容易维护。

:::note
There is a `command_runner` class that is
part of the officially maintained [`args` package]({{site.pub-pkg}}/args).
For this tutorial we're building our own `command_runner` class,
but in a real project you would likely use the class from `args`.

官方维护的 [`args` package]({{site.pub-pkg}}/args) 里
已经有一个 `command_runner` 类。
本教程会带你自己实现一个 `command_runner` 类，
但在真实项目中，你多半会直接使用 `args` 里的那个类。
:::

### Task 1: Create the command_runner package

### 任务 1：创建 command_runner package

First, create a new Dart package to
house the command-line argument parsing logic.

首先，创建一个新的 Dart package，
用来存放命令行参数解析逻辑。

1.  Navigate to the root directory of your project (`/dartpedia`).

    进入项目的根目录（`/dartpedia`）。

1.  Run the following command in your terminal:

    在终端中运行以下命令：

    ```bash
    dart create -t package command_runner
    ```

    This command creates a new directory named `command_runner` with
    the basic structure of a Dart package.
    You should now see a new folder `command_runner` in
    your project root, alongside your `cli` package.

    这条命令会创建一个名为 `command_runner` 的新目录，
    其中包含 Dart package 的基本结构。
    现在你应该能在项目根目录中看到新文件夹 `command_runner`，
    它和 `cli` package 并列。

### Task 2: Implement the CommandRunner class

### 任务 2：实现 CommandRunner 类

Now that you have created the `command_runner` package,
add a placeholder class that will eventually
handle the command-line argument parsing logic.

现在你已经创建了 `command_runner` package，
添加一个占位类，它最终会处理命令行参数解析逻辑。

1.  Open the `command_runner/lib/command_runner.dart` file.
    Remove any existing placeholder code and add the following:

    打开 `command_runner/lib/command_runner.dart` 文件。
    删掉已有的占位代码，并添加以下内容：

    ```dart title="command_runner/lib/command_runner.dart"
    /// A simple command runner to handle command-line arguments.
    ///
    /// More extensive documentation for this library goes here.
    library;

    export 'src/command_runner_base.dart';
    // TODO: Export any other libraries intended for clients of this package.
    ```

    Highlights from the preceding code:

    上面这段代码的要点：

    - `library;` declares this file as a library,
      which defines the boundaries and public interface of
      a reusable unit of Dart code.

      `library;` 把这个文件声明为一个库，
      用来划定一段可复用 Dart 代码的边界和公开接口。

    - `export 'src/command_runner_base.dart';` is a crucial line that
      makes declarations from `command_runner_base.dart` available to
      other packages that import the `command_runner` package.
      Without this `export` statement, the classes and functions
      within `command_runner_base.dart` would be private to
      the `command_runner` package, and you wouldn't be able to
      use them in your `dartpedia` application.

      `export 'src/command_runner_base.dart';` 这一行很关键，
      它让导入 `command_runner` package 的其他 package
      能够使用 `command_runner_base.dart` 中的声明。
      如果没有这条 `export` 语句，
      `command_runner_base.dart` 里的类和函数
      就只对 `command_runner` package 私有，
      你也就无法在 `dartpedia` 应用中使用它们。

1.  Open the file `command_runner/lib/src/command_runner_base.dart`.

    打开文件 `command_runner/lib/src/command_runner_base.dart`。

1.  Remove any existing placeholder code and
    add the following `CommandRunner` class to
    `command_runner/lib/src/command_runner_base.dart`:

    删掉已有的占位代码，并把下面的 `CommandRunner` 类添加到
    `command_runner/lib/src/command_runner_base.dart`：

    ```dart title="command_runner/lib/src/command_runner_base.dart"
    class CommandRunner {
      /// Runs the command-line application logic with the given arguments.
      Future<void> run(List<String> input) async {
        print('CommandRunner received arguments: $input');
      }
    }
    ```

    Highlights from the preceding code:

    上面这段代码的要点：

    - `CommandRunner` is a class that serves as a simplified stand-in for now.
      Its `run` method currently just prints the arguments it receives.
      In later chapters, you'll expand this class to
      handle complex and configurable command parsing.

      `CommandRunner` 目前是一个简化的占位类。
      它的 `run` 方法现在只是打印收到的参数。
      在后续章节中，你会扩展这个类，
      让它处理复杂且可配置的命令解析。

    - `Future<void>` is a return type that indicates that
      this method might perform asynchronous operations,
      but doesn't return a value.

      `Future<void>` 这种返回类型表示
      该方法可能会执行异步操作，但不返回值。

### Task 3: Add `command_runner` as a dependency

### 任务 3：把 `command_runner` 添加为依赖

Now that you've created the `command_runner` package and
added a placeholder `CommandRunner` class, you need to
tell your `cli` application that it depends on `command_runner`.
Because the `command_runner` package is located locally within your project,
you can use a [path dependency][].

现在你已经创建了 `command_runner` package，
并添加了占位的 `CommandRunner` 类，
接下来要告诉 `cli` 应用它依赖 `command_runner`。
因为 `command_runner` package 就在项目本地，
你可以使用 [路径依赖][path dependency]。

1.  Open the `cli/pubspec.yaml` file.

    打开 `cli/pubspec.yaml` 文件。

    :::note
    Make sure you open the correct `/dartpedia/cli/pubspec.yaml` file.
    When you created the `command_runner` package, it also came with a
    `/dartpedia/command_runner/pubspec.yaml` file.

    请确认你打开的是正确的 `/dartpedia/cli/pubspec.yaml` 文件。
    创建 `command_runner` package 时，
    它也会自带一个 `/dartpedia/command_runner/pubspec.yaml` 文件。
    :::

1.  Because the `cli` package is an application package and
    isn't intended to be published to pub.dev,
    add `publish_to: none` after the `name` field.
    This helps avoid accidental publishing and
    prevents analyzer warnings about adding path dependencies.

    因为 `cli` package 是应用 package，
    并不打算发布到 pub.dev，
    所以在 `name` 字段后面添加 `publish_to: none`。
    这有助于避免意外发布，
    也能避免分析器对添加路径依赖发出警告。

    ```yaml title="cli/pubspec.yaml" highlightLines=2
    name: cli
    publish_to: none
    # ...
    ```

1.  Locate the `dependencies` section. Add the following lines:

    找到 `dependencies` 部分，添加以下内容：

    ```yaml title="cli/pubspec.yaml" highlightLines=3-4
    dependencies:
      http: ^1.3.0 # Keep your existing http dependency
      command_runner:
        path: ../command_runner # Points to your local command_runner package
    ```

    This section tells the `cli` application to
    depend on the `command_runner` package, and specifies that
    the package is located in the `../command_runner` directory
    (relative to the `cli` directory).

    这一段告诉 `cli` 应用依赖 `command_runner` package，
    并指明该 package 位于 `../command_runner` 目录
    （相对于 `cli` 目录）。

1.  Run `dart pub get` in the `/dartpedia/cli` directory of your terminal to
    fetch the new dependency.

    在终端的 `/dartpedia/cli` 目录中运行 `dart pub get`，
    获取新的依赖。

[path dependency]: /tools/pub/dependencies#path-packages

### Task 4: Import and use the `command_runner` package

### 任务 4：导入并使用 `command_runner` package

Now that you've added `command_runner` as a dependency,
you can import it into your `cli` application and
replace your existing argument-handling logic with
the new `CommandRunner` class.

现在你已经把 `command_runner` 添加为依赖，
可以把它导入 `cli` 应用，
并用新的 `CommandRunner` 类替换现有的参数处理逻辑。

1.  Open the `cli/bin/cli.dart` file.

    打开 `cli/bin/cli.dart` 文件。

1.  Add the following import statement at the top of the file, alongside
    your other imports:

    在文件顶部和其他 import 一起，添加下面这条 import 语句：

    ```dart
    import 'package:command_runner/command_runner.dart';
    ```

    This statement imports the `command_runner` package,
    making the `CommandRunner` class available for use.

    这条语句导入 `command_runner` package，
    这样就可以使用 `CommandRunner` 类。

1.  **Refactor the `main` function and remove old logic:**
    Currently, your `main` function from Chapter 3 directly handles commands
    like `version`, `help`, and `wikipedia`, and then calls `searchWikipedia`.
    You'll now replace all of this custom command-handling logic with
    a single call to the new `CommandRunner` class.

    **重构 `main` 函数，并移除旧逻辑：**
    目前，第 3 章里的 `main` 函数会直接处理
    `version`、`help` 和 `wikipedia` 等命令，然后调用 `searchWikipedia`。
    现在你要把所有这些自定义的命令处理逻辑，
    换成对新 `CommandRunner` 类的一次调用。

    **Your `cli/bin/cli.dart` file (from Chapter 3) should
    currently look like this:**

    **你的 `cli/bin/cli.dart` 文件（来自第 3 章）目前应该如下所示：**

    ```dart title="cli/bin/cli.dart"
    import 'dart:io';
    import 'package:http/http.dart' as http;
    import 'package:command_runner/command_runner.dart';

    const version = '0.0.1';

    void main(List<String> arguments) {
      if (arguments.isEmpty || arguments.first == 'help') {
        printUsage();
      } else if (arguments.first == 'version') {
        print('Dartpedia CLI version $version');
      } else if (arguments.first == 'wikipedia') {
        final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
        searchWikipedia(inputArgs);
      } else {
        printUsage();
      }
    }

    void searchWikipedia(List<String>? arguments) async { /* ... existing logic ... */ }
    void printUsage() { /* ... existing logic ... */ }
    Future<String> getWikipediaArticle(String articleTitle) async { /* ... existing logic ... */ }
    ```

    **Now, replace the entire contents of `cli/bin/cli.dart`
    (except for the `http` import) with the following updated version:**

    **现在，把 `cli/bin/cli.dart` 的全部内容
    （`http` 的 import 除外）替换成下面的更新版本：**

    ```dart title="cli/bin/cli.dart"
    import 'dart:io';
    import 'package:http/http.dart' as http;
    import 'package:command_runner/command_runner.dart';

    void main(List<String> arguments) async { // main is now async and awaits the runner
      var runner = CommandRunner(); // Create an instance of your new CommandRunner
      await runner.run(arguments); // Call its run method, awaiting its Future<void>
    }
    ```

    Highlights from the preceding code:

    上面这段代码的要点：

    - Declaring `main` as `async` lets it use `await`.
      Because `runner.run()` returns a `Future`,
      awaiting it makes `main` explicitly wait for the runner's completion,
      ensuring clear logic order and improving error propagation.

      把 `main` 声明为 `async`，就可以使用 `await`。
      因为 `runner.run()` 返回一个 `Future`，
      对它使用 await 会让 `main` 明确等待 runner 完成，
      从而保证逻辑顺序清晰，并改善错误传播。

    - `var runner = CommandRunner();` creates an instance of the
      `CommandRunner` class from your new `command_runner` package.

      `var runner = CommandRunner();` 会创建
      新 `command_runner` package 中 `CommandRunner` 类的实例。

    - `await runner.run(arguments);` calls the `run` method on the
      `CommandRunner` instance, passing in the command-line arguments.

      `await runner.run(arguments);` 调用
      `CommandRunner` 实例的 `run` 方法，并传入命令行参数。

    Removed functions:

    移除的函数：

    - The `printUsage`, `searchWikipedia`, and `getWikipediaArticle` functions
      are now completely removed from `cli/bin/cli.dart`.
      Their logic will be redesigned and moved into
      the `command_runner` package in future chapters,
      as part of building the full command-line framework.

      `printUsage`、`searchWikipedia` 和 `getWikipediaArticle` 函数
      现在已从 `cli/bin/cli.dart` 中完全移除。
      它们的逻辑会在后续章节中重新设计，并移入
      `command_runner` package，
      作为构建完整命令行框架的一部分。

### Task 5: Run the application

### 任务 5：运行应用

Now that you've refactored the code and
updated the `cli` application to use the `command_runner` package,
run the application to verify that everything
is working correctly at this stage.

现在你已经重构了代码，
并让 `cli` 应用使用 `command_runner` package，
运行应用，确认这一阶段一切正常。

1.  Open your terminal and navigate to the `cli` directory.

    打开终端，进入 `cli` 目录。

1.  Run the `wikipedia` command:

    运行 `wikipedia` 命令：

    ```bash
    dart run bin/cli.dart wikipedia Computer_programming
    ```

1.  Ensure that the application now
    executes without errors and print the arguments to the console,
    demonstrating that the control has
    successfully transferred to your new `command_runner` package.

    请确认应用现在能无错误地执行，并把参数打印到控制台，
    这表明控制权已成功转移到新的 `command_runner` package。

    ```bash
    CommandRunner received arguments: [wikipedia, Computer_programming]
    ```

    :::tip Troubleshooting
    If Dart reports a `Method not found: 'CommandRunner'` error
    when running `cli.dart`, ensure
    `command_runner/lib/src/command_runner_base.dart` was updated with
    the `CommandRunner` class from [Task 2][].

    :::tip 故障排查
    如果运行 `cli.dart` 时 Dart 报告
    `Method not found: 'CommandRunner'` 错误，
    请确认 `command_runner/lib/src/command_runner_base.dart`
    已按 [任务 2][Task 2] 更新，并包含 `CommandRunner` 类。
    :::

:::important Important note on functionality
You'll notice that the article-fetching functionality (from Chapter 3) is
no longer active. This is expected!
In this chapter, you've refactored the project structure by
moving the command-handling responsibility.
The next chapters will focus on rebuilding and
enhancing that core application logic within the `command_runner` package.

:::important 关于功能的重要说明
你会发现，获取文章的功能（来自第 3 章）已经不再工作。
这是预期行为！
在本章中，你通过转移命令处理的职责，重构了项目结构。
接下来的章节会着重在 `command_runner` package 中
重建并增强这部分核心应用逻辑。
:::

[Task 2]: #task-2-implement-the-commandrunner-class

## Review

## 回顾

<SummaryCard>
title: 你完成的内容
subtitle: 以下是你在本课中构建并学到的内容摘要。
completed: true
items:
  - title: 创建了一个可复用的 Dart package
    icon: package_2
    details: >-
      你使用 `dart create -t package command_runner`
      搭建了一个新的库 package，供其他 package 使用。
      库 package 是组织和分享可复用 Dart 库的标准方式，
      既可以放在项目工作区里，也可以发布到 pub.dev。
  - title: 用 export 定义了公开 API
    icon: export_notes
    details: >-
      你在库文件中添加了 `export` 语句，
      把特定的库及其定义暴露给使用者。
      如果没有从 `lib` 根目录下的文件导出，
      `lib/src/` 中的代码就仍然对 package 私有。
      这样你可以仔细设计给他人使用的公开 API，
      同时完全掌控实现细节。
  - title: 添加了本地路径依赖
    icon: folder_code
    details: >-
      你配置了 `pubspec.yaml`，
      通过路径依赖来依赖一个本地 package。
      这样就可以做多 package 项目，
      让各个 package 一起演进，之后再分别发布。
</SummaryCard>

## Quiz

## 测验

<!-- title: Check your understanding -->
<Quiz title="检查你的理解" id="packages-libs" />

## Next lesson

## 下一课

In the next chapter, you'll dive into
object-oriented programming (OOP) concepts in Dart.
You'll learn how to create classes, define inheritance relationships,
and build a more robust command-line argument parsing framework using
OOP principles within your new `command_runner` package.

在下一章中，你将深入 Dart 的面向对象编程（OOP）概念。
你将学习如何创建类、定义继承关系，
并在新的 `command_runner` package 中运用 OOP 原则，
构建更稳健的命令行参数解析框架。
