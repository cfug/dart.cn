---
# title: Polish your CLI app
title: 打磨你的 CLI 应用
# shortTitle: CLI polish
shortTitle: 打磨 CLI
# description: >-
#   Improve the HelpCommand to provide more detailed information and
#   add an onOutput argument for flexible output handling.
description: >-
  改进 HelpCommand，让它提供更详细的信息，
  并添加 onOutput 参数，以便更灵活地处理输出。
layout: learn
ai-translated: true
---

In this chapter, you'll
put the finishing touches on the `command_runner` package.
You'll refine the `HelpCommand` to provide more detailed usage information and
add an `onOutput` argument for more flexible output handling.
This finalizes the `CommandRunner` package and prepares it for
use in more complex scenarios.

在本章中，你将为 `command_runner` package 收尾。
你会改进 `HelpCommand`，让它提供更详细的用法信息，
并添加 `onOutput` 参数，以便更灵活地处理输出。
至此，`CommandRunner` package 就完成了，
可以用于更复杂的场景。

<SummaryCard>
title: 你将完成的内容
items:
  - title: 学习如何逐步构建字符串
    icon: text_snippet
  - title: 增强帮助用法信息
    icon: help
  - title: 让命令运行器更灵活
    icon: terminal
</SummaryCard>

## Prerequisites

## 准备工作

Before you begin this chapter, ensure you:

开始本章之前，请确认你已经：

- Have completed Chapter 7 and have a
  working Dart development environment with the `dartpedia` project.

  完成了第 7 章，并且有可用的 Dart 开发环境，
  项目为 `dartpedia`。

- Are familiar with basic programming concepts like
  variables, functions, and control flow.

  熟悉变量、函数、控制流等基本编程概念。

- Understand the concepts of packages and libraries in Dart.

  理解 Dart 中 package 和库的概念。

- Are familiar with object-oriented programming principles like
  inheritance and abstract classes.

  熟悉继承、抽象类等面向对象编程原则。

## Tasks

## 任务

You will polish the `command_runner` package to
make it more robust and user-friendly.

你将打磨 `command_runner` package，
让它更稳健、也更好用。

### Task 1 Improve the `HelpCommand` output

### 任务 1：改进 `HelpCommand` 的输出

Enhance the `HelpCommand` to provide more detailed usage information,
including options and their descriptions.
This will make it easier for users to
understand how to use your CLI application.

增强 `HelpCommand`，让它提供更详细的用法信息，
包括选项及其说明。
这样用户就更容易理解如何使用你的 CLI 应用。

1.  Open the `command_runner/lib/src/help_command.dart` file.

    打开 `command_runner/lib/src/help_command.dart` 文件。

1.  Add imports for `console.dart` and `exceptions.dart` at the top of the file.
    You need these to use the color extensions and to
    throw an `ArgumentException`.

    在文件顶部为 `console.dart` 和 `exceptions.dart` 添加 import。
    你需要它们来使用颜色扩展，并抛出 `ArgumentException`。

    ```dart
    import 'dart:async';

    import 'package:command_runner/command_runner.dart';

    import 'console.dart';
    import 'exceptions.dart';
    ```

1.  Replace the existing `run` method with the following.
    This new version uses a `StringBuffer` to efficiently
    build the help string and includes logic to handle verbose output.

    用下面的代码替换现有的 `run` 方法。
    这个新版本用 `StringBuffer` 高效构建帮助字符串，
    并包含处理详细输出的逻辑。

    ```dart
    @override
    FutureOr<String> run(ArgResults args) async {
      final buffer = StringBuffer();
      buffer.writeln(runner.usage.titleText);

      if (args.flag('verbose')) {
        for (var cmd in runner.commands) {
          buffer.write(_renderCommandVerbose(cmd));
        }

        return buffer.toString();
      }

      if (args.hasOption('command')) {
        var (:option, :input) = args.getOption('command');

        var cmd = runner.commands.firstWhere(
          (command) => command.name == input,
          orElse: () {
            throw ArgumentException(
              'Input $input is not a known command.',
              name,
            );
          },
        );

        return _renderCommandVerbose(cmd);
      }

      // Verbose is false and no arg was passed in, so print basic usage.
      for (var command in runner.commands) {
        buffer.writeln(command.usage);
      }

      return buffer.toString();
    }
    ```

    `StringBuffer` is a Dart class that allows you to efficiently build strings.
    It's more performant than using the `+` operator,
    especially when performing many concatenations inside a loop.

    `StringBuffer` 是 Dart 里用来高效构建字符串的类。
    它比使用 `+` 运算符性能更好，
    尤其是在循环里做很多次拼接时。

1.  Add the `_renderCommandVerbose` private helper method to
    the `HelpCommand` class.
    This method formats the detailed output for a single command.

    为 `HelpCommand` 类添加私有辅助方法 `_renderCommandVerbose`。
    这个方法用来格式化单个命令的详细输出。

    ```dart
    String _renderCommandVerbose(Command cmd) {
      final indent = ' ' * 10;
      final buffer = StringBuffer();
      buffer.writeln(cmd.usage.instructionText); //abbr, name: description
      buffer.writeln('$indent ${cmd.help}');
      if (cmd.valueHelp != null) {
        buffer.writeln(
          '$indent [Argument] Required? ${cmd.requiresArgument}, Type: ${cmd.valueHelp}, Default: ${cmd.defaultValue ?? 'none'}',
        );
      }
      buffer.writeln('$indent Options:');
      for (var option in cmd.options) {
        buffer.writeln('$indent ${option.usage}');
      }
      return buffer.toString();
    }
    ```

### Task 2 Add an `onOutput` callback

### 任务 2：添加 `onOutput` 回调

Next, add an `onOutput` argument to the `CommandRunner` to
allow for flexible output handling.

接下来，为 `CommandRunner` 添加 `onOutput` 参数，
以便更灵活地处理输出。

1.  Open the `command_runner/lib/src/command_runner_base.dart` file.

    打开 `command_runner/lib/src/command_runner_base.dart` 文件。

1.  Add the `onOutput` argument to the `CommandRunner` constructor, and
    add the corresponding `onOutput` member to the class.

    为 `CommandRunner` 构造函数添加 `onOutput` 参数，
    并在类中添加对应的 `onOutput` 成员。

    ```dart
    class CommandRunner {
      CommandRunner({this.onOutput, this.onError});

      /// If not null, this method is used to handle output. Useful if you want to
      /// execute code before the output is printed to the console, or if you
      /// want to do something other than print output the console.
      /// If null, the onInput method will [print] the output.
      FutureOr<void> Function(String)? onOutput;

      FutureOr<void> Function(Object)? onError;

      // ... rest of the class
    }
    ```

1.  Update the `run` method to use the `onOutput` argument.

    更新 `run` 方法，让它使用 `onOutput` 参数。

    ```dart
      Future<void> run(List<String> input) async {
        try {
          final ArgResults results = parse(input);
          if (results.command != null) {
            Object? output = await results.command!.run(results);
            if (onOutput != null) {
              await onOutput!(output.toString());
            } else {
              print(output.toString());
            }
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

    This updates the `run` method to
    use the `onOutput` function if it is provided, otherwise it
    defaults to printing to the console.

    这样 `run` 方法会在提供了 `onOutput` 函数时使用它，
    否则默认打印到控制台。

### Task 3 Use the `onOutput` callback

### 任务 3：使用 `onOutput` 回调

Finally, update your main application to use the new `onOutput` feature.

最后，更新主应用，使用新的 `onOutput` 功能。

1.  Open the `cli/bin/cli.dart` file.

    打开 `cli/bin/cli.dart` 文件。

1.  Update the `main` function to
    pass the `onOutput` function to the `CommandRunner`.
    You will also need to add an import for `console.dart` to
    make the `write` function available.

    更新 `main` 函数，把 `onOutput` 函数传给 `CommandRunner`。
    你还需要为 `console.dart` 添加 import，
    这样就能使用 `write` 函数。

    ```dart
    import 'package:command_runner/command_runner.dart';

    const version = '0.0.1';

    void main(List<String> arguments) {
      var commandRunner = CommandRunner(
        onOutput: (String output) async {
          await write(output);
        },
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

### Task 4 Test the changes

### 任务 4：测试这些改动

Test the improved `HelpCommand` and the `onOutput` callback.

测试改进后的 `HelpCommand` 和 `onOutput` 回调。

1.  Open your terminal and navigate to the `cli` directory.

    打开终端，进入 `cli` 目录。

1.  Run the command `dart run bin/cli.dart help --verbose`.

    运行命令 `dart run bin/cli.dart help --verbose`。

    You should see detailed usage information for the `help` command,
    printed using the custom `write` function.

    你应该会看到 `help` 命令的详细用法信息，
    这些信息是用自定义的 `write` 函数打印出来的。

## Review

## 回顾

<SummaryCard>
title: 你完成的内容
subtitle: 以下是你在本课中构建并学到的内容摘要。
completed: true
items:
  - title: 使用 StringBuffer 高效构建字符串
    icon: text_snippet
    details: >-
      你用 `StringBuffer` 替换了字符串拼接。
      在循环中构建字符串时，它往往更高效。
      `writeln()` 和 `write()` 等方法用来追加内容，
      `toString()` 则生成最终字符串。
  - title: 为 HelpCommand 增加了详细输出
    icon: help
    details: >-
      你改进了帮助系统，让它显示详细的用法信息，
      包括选项、默认值和说明。
      `--verbose` 标志和 `--command` 选项让用户可以
      控制信息的详细程度。
  - title: 添加了 onOutput 回调参数，以便灵活处理输出
    icon: terminal
    details: >-
      你为 `CommandRunner` 添加了 `onOutput`，
      让库的使用者可以自定义输出的显示方式。
      这种模式让 package 更灵活、更容易适配，
      可以延迟打印、记录日志或重定向输出。
</SummaryCard>

## Quiz

## 测验

<!-- title: Check your understanding -->
<Quiz title="检查你的理解" id="cli-polish" />

## Next lesson

## 下一课

In the next lesson, you'll prepare for
the Wikipedia portion of the application.

在下一课中，你将为应用中的 Wikipedia 部分做准备。
