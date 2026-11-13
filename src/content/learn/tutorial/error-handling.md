---
# title: Handle errors gracefully
title: 妥善处理错误
# shortTitle: Error handling
shortTitle: 错误处理
# description: >-
#   Improve app robustness by handling errors.
#   Learn about exceptions, errors, `try/catch`, `throw`, and `rethrow`.
description: >-
  通过处理错误提升应用的稳健性。
  了解异常、错误、`try/catch`、`throw` 和 `rethrow`。
layout: learn
ai-translated: true
---

In this chapter, you'll learn how to
make your application more robust by handling errors gracefully.
You'll explore exceptions, `try/catch` blocks, and how to
create custom exceptions to manage errors in a structured way.

在本章中，你将学习如何通过妥善处理错误，
让应用更加稳健。
你将探索异常、`try/catch` 块，
以及如何创建自定义异常，有条理地管理错误。

<SummaryCard>
title: 你将完成的内容
items:
  - title: 区分错误和异常
    icon: error
  - title: 用 try/catch 处理失败
    icon: shield
  - title: 创建并抛出自定义异常
    icon: deployed_code_alert
</SummaryCard>

## Prerequisites

## 准备工作

Before you begin this chapter, ensure you:

开始本章之前，请确认你已经：

- Have completed Chapter 5 and have a
  working Dart development environment with the `dartpedia` project.

  完成了第 5 章，并且有可用的 Dart 开发环境，
  项目为 `dartpedia`。
- Understand basic programming concepts like functions and classes.

  理解函数和类等基本编程概念。

## Errors versus exceptions

## 错误与异常

Before you start writing code to handle failures,
you need to understand the two main types of failures in Dart:
**errors** and **exceptions**.

在开始编写处理失败的代码之前，
你需要理解 Dart 中两类主要的失败：
**错误** 和 **异常**。

- **Exceptions** represent conditions that you might expect to happen
  and that your program can recover from.
  Examples include invalid user input,
  a missing file, or a network timeout.
  Your code can catch and handle exceptions to keep running.

  **异常** 表示你可能预料到会发生、
  并且程序可以从中恢复的情况。
  例如无效的用户输入、缺失的文件或网络超时。
  你的代码可以捕获并处理异常，让程序继续运行。
- **Errors** represent failure conditions that indicate bugs in the code.
  Examples include calling a method on a `null` object,
  passing an invalid index to a list, or
  failing to initialize a late variable before use.
  You don't catch errors.
  Instead, you let them crash the application,
  which helps you find and fix the underlying bug.

  **错误** 表示代码中存在 bug 的失败情况。
  例如在 `null` 对象上调用方法、
  向列表传入无效索引，
  或在使用前没有初始化 late 变量。
  你不要捕获错误。
  相反，让它们使应用崩溃，
  这有助于你找到并修复底层 bug。

In Dart, any non-null object can be thrown as an exception.
However, by convention, exceptions implement `Exception`,
while errors extend or implement `Error`.
When you design an API, throw subtypes of `Exception` for
conditions that callers can catch and handle.

在 Dart 中，任何非空对象都可以作为异常抛出。
不过按照惯例，异常会实现 `Exception`，
而错误会扩展或实现 `Error`。
设计 API 时，对于调用方可以捕获并处理的情况，
应抛出 `Exception` 的子类型。

## Tasks

## 任务

In this chapter, you will improve the robustness of
your `command_runner` package by implementing error handling.
You'll create a custom exception class
and add error handling to the `CommandRunner` to
gracefully manage errors that might occur during command execution.

在本章中，你将通过实现错误处理，
提升 `command_runner` package 的稳健性。
你将创建一个自定义异常类，
并为 `CommandRunner` 添加错误处理，
妥善管理命令执行过程中可能出现的错误。

### Task 1: Create a custom ArgumentException

### 任务 1：创建自定义的 ArgumentException

First, define a custom exception class called `ArgumentException` to
represent errors related to command-line arguments.

首先，定义一个名为 `ArgumentException` 的自定义异常类，
用来表示与命令行参数相关的错误。

1.  Create the file `command_runner/lib/src/exceptions.dart`.
    This file will contain the definition for your `ArgumentException` class.

    创建文件 `command_runner/lib/src/exceptions.dart`。
    这个文件将包含 `ArgumentException` 类的定义。

1.  Define a class called `ArgumentException` that `extends` `FormatException`.

    定义一个 `extends` `FormatException` 的类，名为 `ArgumentException`。

    ```dart title="command_runner/lib/src/exceptions.dart"
    class ArgumentException extends FormatException {
      /// The command that was parsed before discovering the error.
      ///
      /// This will be empty if the error was on the root parser.
      final String? command;

      /// The name of the argument that was being parsed when the error was
      /// discovered.
      final String? argumentName;

      ArgumentException(
        super.message, [
        this.command,
        this.argumentName,
        super.source,
        super.offset,
      ]);

      @override
      String toString() {
        return 'ArgumentException: $message';
      }
    }
    ```

    This class extends `FormatException`, which
    is a built-in Dart exception class.
    It includes additional properties to store the
    command and argument name associated with the error.
    This provides more context when handling the exception.

    这个类扩展了 `FormatException`，
    它是 Dart 内置的异常类。
    它还包含额外的属性，用来保存
    与错误相关的命令和参数名。
    处理异常时，这些信息能提供更多上下文。

    - `command`:
      The command that was being processed when the exception occurred.

      `command`：
      发生异常时正在处理的命令。
    - `argumentName`:
      The name of the argument that caused the exception.

      `argumentName`：
      导致异常的参数名。


## Task 2: Implement error handling in CommandRunner

## 任务 2：在 CommandRunner 中实现错误处理

Next, update the `CommandRunner` class to
handle potential errors gracefully.
This involves adding an error-handling callback,
using `try/catch` to manage exceptions, and
throwing your new `ArgumentException` when the user provides bad input.

接下来，更新 `CommandRunner` 类，
妥善处理可能出现的错误。
这包括添加错误处理回调、
用 `try/catch` 管理异常，
以及在用户提供了错误输入时抛出新的 `ArgumentException`。

1.  Add the necessary imports.

    添加必要的 import。

    In `command_runner/lib/src/command_runner_base.dart`,
    add imports for `dart:async` (to use `FutureOr`) and
    your new `exceptions.dart` file.

    在 `command_runner/lib/src/command_runner_base.dart` 中，
    添加 `dart:async`（以便使用 `FutureOr`）
    和新的 `exceptions.dart` 文件的 import。

    ```dart
    import 'dart:async'; // Add this line
    import 'dart:collection';
    import 'dart:io';

    import 'arguments.dart';
    import 'exceptions.dart'; // Add this line
    ```

1.  Add an `onError` callback to the `CommandRunner`.

    为 `CommandRunner` 添加 `onError` 回调。

    Modify the CommandRunner to
    accept an optional `onError` function in its constructor.
    This will allow the user of your package to
    define their own error-handling logic.

    修改 CommandRunner，
    让它的构造函数接受一个可选的 `onError` 函数。
    这样使用你的 package 的人就可以
    定义自己的错误处理逻辑。

    ```dart
    class CommandRunner {
      // Add a constructor that accepts the optional callback.
      CommandRunner({this.onError});

      final Map<String, Command> _commands = <String, Command>{};

      UnmodifiableSetView<Command> get commands =>
          UnmodifiableSetView<Command>(<Command>{..._commands.values});

      // Define the onError property.
      FutureOr<void> Function(Object)? onError;

      // The rest of the class implementation...
    }
    ```

    This change introduces a nullable `onError` property.
    The `FutureOr<void> Function(Object)?` type means it's a function that
    takes an `Object` and returns a `Future` or nothing, and it might be null.

    这个改动引入了一个可空的 `onError` 属性。
    `FutureOr<void> Function(Object)?` 类型表示它是一个函数，
    接收一个 `Object`，返回 `Future` 或不返回值，并且它本身可能为 null。

1.  Update the run method to use `try`/`catch`.

    更新 run 方法，使用 `try`/`catch`。

    Wrap the logic inside the run method in a `try`/`catch` block.
    If an exception occurs, this block will "catch" it and either
    pass it to the `onError` callback or rethrow it if no callback was provided.
    `rethrow` preserves the original error and stack trace.

    把 run 方法里的逻辑包进 `try`/`catch` 块。
    如果发生异常，这个块会「捕获」它，
    然后传给 `onError` 回调；如果没有提供回调，就重新抛出。
    `rethrow` 会保留原来的错误和堆栈跟踪。

    ```dart
    Future<void> run(List<String> input) async {
      // [Step 6 update] try/catch added
      try {
        final ArgResults results = parse(input);
        if (results.command != null) {
          Object? output = await results.command!.run(results);
          print(output.toString());
        }
      } on Exception catch (exception) {
        if (onError != null) {
          onError!(exception);
        } else {
          rethrow;
        }
      }
    }
    ```

1.  Add validation to the `parse` method.

    为 `parse` 方法添加校验。

    Finally, replace the existing `parse` method in `command_runner_base.dart`
    with the following updated version. This new version is much more robust.
    It's filled with checks that will throw your custom `ArgumentException`
    whenever it detects invalid user input.

    最后，用下面的更新版本替换
    `command_runner_base.dart` 中现有的 `parse` 方法。
    这个新版本稳健得多。
    它充满了检查，一旦发现无效的用户输入，
    就会抛出你的自定义 `ArgumentException`。

    ```dart
    // [Step 6 update] This method is replaced entirely.
    ArgResults parse(List<String> input) {
      ArgResults results = ArgResults();
      if (input.isEmpty) return results;

      // Throw an exception if the command is not recognized.
      if (_commands.containsKey(input.first)) {
        results.command = _commands[input.first];
        input = input.sublist(1);
      } else {
        throw ArgumentException(
          'The first word of input must be a command.',
          null,
          input.first,
        );
      }

      // Throw an exception if multiple commands are provided.
      if (results.command != null &&
          input.isNotEmpty &&
          _commands.containsKey(input.first)) {
        throw ArgumentException(
          'Input can only contain one command. Got ${input.first} and ${results.command!.name}',
          null,
          input.first,
        );
      }

      // Section: Handle options, including flags.
      Map<Option, Object?> inputOptions = {};
      int i = 0;
      while (i < input.length) {
        if (input[i].startsWith('-')) {
          var base = _removeDash(input[i]);
          // Throw an exception if an option is not recognized for the given command.
          var option = results.command!.options.firstWhere(
            (option) => option.name == base || option.abbr == base,
            orElse: () {
              throw ArgumentException(
                'Unknown option ${input[i]}',
                results.command!.name,
                input[i],
              );
            },
          );

          if (option.type == OptionType.flag) {
            inputOptions[option] = true;
            i++;
            continue;
          }

          if (option.type == OptionType.option) {
            // Throw an exception if an option requires an argument but none is given.
            if (i + 1 >= input.length) {
              throw ArgumentException(
                'Option ${option.name} requires an argument',
                results.command!.name,
                option.name,
              );
            }
            if (input[i + 1].startsWith('-')) {
              throw ArgumentException(
                'Option ${option.name} requires an argument, but got another option ${input[i + 1]}',
                results.command!.name,
                option.name,
              );
            }
            var arg = input[i + 1];
            inputOptions[option] = arg;
            i++;
          }
        } else {
          // Throw an exception if more than one positional argument is provided.
          if (results.commandArg != null && results.commandArg!.isNotEmpty) {
            throw ArgumentException(
              'Commands can only have up to one argument.',
              results.command!.name,
              input[i],
            );
          }
          results.commandArg = input[i];
        }
        i++;
      }
      results.options = inputOptions;

      return results;
    }

    String _removeDash(String input) {
      if (input.startsWith('--')) {
        return input.substring(2);
      }
      if (input.startsWith('-')) {
        return input.substring(1);
      }
      return input;
    }
    ```

    This updated parse method now actively defends against bad input.
    Specifically, the new throw statements handle several common error cases:

    更新后的 parse 方法现在会主动防御错误输入。
    具体来说，新的 throw 语句处理几种常见的错误情况：

    -   **Unknown commands:**
        The first `if`/`else` block ensures the
        first argument is a valid command.

        **未知命令：**
        第一个 `if`/`else` 块确保
        第一个参数是有效命令。
    -   **Multiple commands:**
        It checks that the user hasn't tried to
        run more than one command at a time.

        **多个命令：**
        它检查用户是否试图
        一次运行多个命令。
    -   **Unknown options:**
        The `orElse` parameter within `firstWhere` now throws an
        exception if a user provides a flag or option (like `--foo`) that
        hasn't been defined for that command.

        **未知选项：**
        `firstWhere` 的 `orElse` 参数现在会在用户提供了
        该命令尚未定义的标志或选项（例如 `--foo`）时
        抛出异常。
    -   **Missing option values:**
        It ensures that an option (like `--output`) is followed by a value and
        not another option or the end of the input.

        **缺少选项值：**
        它确保选项（例如 `--output`）后面跟着一个值，
        而不是另一个选项或输入的结尾。
    -   **Too many arguments:**
        It enforces a rule that commands can
        only have one positional argument.

        **参数过多：**
        它强制要求命令
        最多只能有一个位置参数。

### Task 3: Update cli.dart to use the new error handling

### 任务 3：更新 cli.dart 以使用新的错误处理

Modify `cli/bin/cli.dart` to use the new error handling in `CommandRunner`.

修改 `cli/bin/cli.dart`，使用 `CommandRunner` 中新的错误处理。

1.  Open the `cli/bin/cli.dart` file.

    打开 `cli/bin/cli.dart` 文件。

1.  Update the `main` function to pass in
    an `onError` function to the `CommandRunner`:

    更新 `main` 函数，
    向 `CommandRunner` 传入一个 `onError` 函数：

    ```dart title="cli/bin/cli.dart"
    import 'package:command_runner/command_runner.dart';

    const version = '0.0.1';

    void main(List<String> arguments) {
      // [Step 6 update] Add onError method
      var commandRunner = CommandRunner(
        onError: (Object error) {
          if (error is Error) {
            throw error;
          }
          if (error is Exception) {
            print(error);
          }
        },
      )..addCommand(HelpCommand());
      commandRunner.run(arguments);
    }
    ```

    This code passes in an `onError` callback function to
    the `CommandRunner` constructor.
    If an error occurs during the execution of a command,
    the `onError` callback function is called with the error object.
    The callback checks whether the error is an `Error` or an `Exception`.
    Because an `Error` indicates a bug in the code,
    the callback rethrows it.
    This lets the application crash so you can fix the bug.
    For an `Exception`, which represents a recoverable failure,
    the callback handles it gracefully by
    printing it to the console instead of rethrowing it.

    这段代码把 `onError` 回调函数传给
    `CommandRunner` 构造函数。
    如果命令执行过程中发生错误，
    就会用错误对象调用 `onError` 回调。
    回调会检查错误是 `Error` 还是 `Exception`。
    因为 `Error` 表示代码中的 bug，
    回调会重新抛出它。
    这样应用就会崩溃，方便你修复 bug。
    对于表示可恢复失败的 `Exception`，
    回调会妥善处理：
    把它打印到控制台，而不是重新抛出。

### Task 4: Update command_runner library exports

### 任务 4：更新 command_runner 库的导出

Make `ArgumentException` available to the `command_runner` library.

让 `ArgumentException` 可以被 `command_runner` 库使用。

1.  Open `command_runner/lib/command_runner.dart`, and
    add the following exports:

    打开 `command_runner/lib/command_runner.dart`，
    并添加以下 export：

    ```dart title="command_runner/lib/command_runner.dart"
    /// Support for doing something awesome.
    ///
    /// More dartdocs go here.
    library;

    export 'src/arguments.dart';
    export 'src/command_runner_base.dart';
    export 'src/help_command.dart';
    export 'src/exceptions.dart'; // Add this line

    // TODO: Export any libraries intended for clients of this package.
    ```

    This ensures that the `ArgumentException` is
    available to consumers of the `command_runner` package.

    这样 `command_runner` package 的使用者
    就可以使用 `ArgumentException`。

### Task 5: Test the new error handling

### 任务 5：测试新的错误处理

Test the new error handling by running the application with invalid arguments.

用无效参数运行应用，测试新的错误处理。

1.  Open your terminal and navigate to the `cli` directory.

    打开终端，进入 `cli` 目录。

1.  Run the command `dart run bin/cli.dart invalid_command`.

    运行命令 `dart run bin/cli.dart invalid_command`。

    You should see the following output:

    你应该会看到以下输出：

    ```bash
    ArgumentException: The first word of input must be a command.
    ```

    This confirms that the `ArgumentException` is
    being thrown and caught correctly.

    这确认 `ArgumentException` 已被正确抛出并捕获。

## Review

## 回顾

<SummaryCard>
title: 你完成的内容
subtitle: 以下是你在本课中构建并学到的内容摘要。
completed: true
items:
  - title: 区分了错误和异常
    icon: error
    details: >-
      你了解到 `Error` 的子类型表示程序中的 bug，
      并不打算被捕获；
      而 `Exception` 的子类型表示可恢复的失败，
      你的代码可以妥善处理。
  - title: 用 try-catch 块处理了失败
    icon: shield
    details: >-
      你把有风险的代码包进 `try`-`catch` 块来拦截异常。
      你使用 `on ExceptionType catch (e)` 处理特定类型，
      并用 `rethrow` 重新抛出异常，同时保留堆栈跟踪。
  - title: 创建并抛出了自定义异常
    icon: deployed_code_alert
    details: >-
      你构建了继承 `FormatException` 的 `ArgumentException` 类，
      用来提供包含上下文的错误信息。
      然后你使用 `throw` 标出校验失败，
      并带上有意义的消息，方便调试和向用户反馈。
</SummaryCard>

## Quiz

## 测验

<!-- title: Check your understanding -->
<Quiz title="检查你的理解" id="error-handling" />

## Next lesson

## 下一课

In the next lesson, you'll learn about
advanced object-oriented features in Dart,
including enhanced enums and extensions.
You'll improve the output formatting and add color to your CLI application.

在下一课中，你将学习 Dart 中更进一步的面向对象特性，
包括增强型枚举和扩展。
你将改进输出格式，并为 CLI 应用加上颜色。
