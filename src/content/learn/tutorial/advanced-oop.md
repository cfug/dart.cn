---
# title: Extend your app with enums and extensions
title: 用枚举和扩展增强应用
# shortTitle: Advanced OOP features
shortTitle: 进阶 OOP 特性
# description: >-
#   Enhance your Dart skills by exploring
#   advanced features like enhanced enums and extensions.
#   Improve your application's output formatting and color,
#   making it more user-friendly.
description: >-
  通过增强型枚举和扩展等进阶特性提升你的 Dart 能力。
  改进应用的输出格式和颜色，让它更好用。
layout: learn
ai-translated: true
---

In this chapter, you'll explore advanced Dart features that
improve the user experience of your command-line application.
You'll learn how to use enhanced enums to manage console colors and
extensions to add new functionality to existing types,
making your application more interactive and visually appealing.

在本章中，你将探索能改善命令行应用使用体验的 Dart 进阶特性。
你将学习如何用增强型枚举管理控制台颜色，
并用扩展为现有类型添加新功能，
让应用更具交互性，视觉上也更清楚。

<SummaryCard>
title: 你将完成的内容
items:
  - title: 使用带字段和方法的增强型枚举
    icon: format_list_bulleted
  - title: 用扩展为现有类型添加功能
    icon: extension
  - title: 添加彩色的控制台输出
    icon: palette
</SummaryCard>

## Prerequisites

## 准备工作

Before you begin this chapter, ensure you:

开始本章之前，请确认你已经：

-   Have completed Chapter 6 and have a
    working Dart development environment with the `dartpedia` project.

    已完成第 6 章，并且有可用的 Dart 开发环境，
    项目为 `dartpedia`。
-   Are familiar with basic programming concepts like
    variables, functions, and control flow.

    熟悉变量、函数、控制流等基本编程概念。
-   Understand the concepts of packages and libraries in Dart.

    理解 Dart 中 package 和库的概念。
-   Have a basic understanding of
    object-oriented programming concepts like classes and enums.

    对类、枚举等面向对象编程概念有基本了解。

## Tasks

## 任务

You will improve the user experience of your Dartpedia CLI application by
adding color to the output and improving text formatting.

你将为输出加上颜色并改进文本格式，
从而改善 Dartpedia CLI 应用的使用体验。

### Task 1: Enhance the console color enum

### 任务 1：增强控制台颜色枚举

First, add color to the console output.
The `ConsoleColor` enum will include RGB values and
methods for applying colors to text.

首先，为控制台输出加上颜色。
`ConsoleColor` 枚举将包含 RGB 值，
以及把颜色应用到文本上的方法。

1.  Create the `command_runner/lib/src/console.dart` file.

    创建 `command_runner/lib/src/console.dart` 文件。

1.  Add the following code to define the `ConsoleColor` enum:

    添加下面的代码来定义 `ConsoleColor` 枚举：

    ```dart title="command_runner/lib/src/console.dart"
    import 'dart:io';

    const String ansiEscapeLiteral = '\x1B';

    /// Splits strings on `\n` characters, then writes each line to the
    /// console. [duration] defines how many milliseconds there will be
    /// between each line print.
    Future<void> write(String text, {int duration = 50}) async {
      final List<String> lines = text.split('\n');
      for (final String l in lines) {
        await _delayedPrint('$l \n', duration: duration);
      }
    }

    /// Prints line-by-line
    Future<void> _delayedPrint(String text, {int duration = 0}) async {
      return Future<void>.delayed(
        Duration(milliseconds: duration),
        () => stdout.write(text),
      );
    }

    /// RGB formatted colors that are used to style input
    ///
    /// All colors from Dart's brand styleguide
    ///
    /// As a demo, only includes colors this program cares about.
    /// If you want to use more colors, add them here.
    enum ConsoleColor {
      /// Sky blue - #b8eafe
      lightBlue(184, 234, 254),

      /// Accent colors from Dart's brand guidelines
      /// Warm red - #F25D50
      red(242, 93, 80),

      /// Light yellow - #F9F8C4
      yellow(249, 248, 196),

      /// Light grey, good for text, #F8F9FA
      grey(240, 240, 240),

      ///
      white(255, 255, 255);

      const ConsoleColor(this.r, this.g, this.b);

      final int r;
      final int g;
      final int b;
    }
    ```

    This enum defines a set of console colors with
    their corresponding RGB values.
    Each color is a constant instance of the `ConsoleColor` enum.

    这个枚举定义了一组控制台颜色及其对应的 RGB 值。
    每种颜色都是 `ConsoleColor` 枚举的一个常量实例。

1.  Add methods to the `ConsoleColor` enum for applying colors to text:

    为 `ConsoleColor` 枚举添加把颜色应用到文本上的方法：

    ```dart title="command_runner/lib/src/console.dart"
    enum ConsoleColor {
      // ... (existing enum values)

      const ConsoleColor(this.r, this.g, this.b);

      final int r;
      final int g;
      final int b;

      /// Change text color for all future output (until reset)
      /// ```dart
      /// print('hello'); // prints in terminal default color
      /// print(ConsoleColor.red.enableForeground);
      /// print('hello'); // prints in red color
      /// ```
      String get enableForeground => '$ansiEscapeLiteral[38;2;$r;$g;${b}m';

      /// Change text color for all future output (until reset)
      /// ```dart
      /// print('hello'); // prints in terminal default color
      /// print(ConsoleColor.red.enableBackground);
      /// print('hello'); // prints with red background color
      /// ```
      String get enableBackground => '$ansiEscapeLiteral[48;2;$r;$g;${b}m';

      /// Reset text and background color to terminal defaults
      static String get reset => '$ansiEscapeLiteral[0m';

      /// Sets text color for the input
      String applyForeground(String text) {
        return '$ansiEscapeLiteral[38;2;$r;$g;${b}m$text$reset';
      }

      /// Sets background color and then resets the color change
      String applyBackground(String text) {
        return '$ansiEscapeLiteral[48;2;$r;$g;${b}m$text$ansiEscapeLiteral[0m';
      }
    }
    ```

    These methods use [ANSI escape codes][] to
    apply foreground and background colors to text.
    The `applyForeground` and `applyBackground` methods return
    a string with the ANSI escape codes applied.

    这些方法使用 [ANSI 转义码][ANSI escape codes]
    为文本设置前景色和背景色。
    `applyForeground` 和 `applyBackground` 方法返回
    已经加上 ANSI 转义码的字符串。

[ANSI escape codes]: https://en.wikipedia.org/wiki/ANSI_escape_code

### Task 2: Create a String extension

### 任务 2：创建 String 扩展

Next, create an extension on the `String` class to
add utility methods for applying console colors and formatting text.

接下来，在 `String` 类上创建一个扩展，
添加用于应用控制台颜色和格式化文本的实用方法。

1.  Add the following code to the `command_runner/lib/src/console.dart` file:

    把下面的代码添加到 `command_runner/lib/src/console.dart` 文件：

    ```dart title="command_runner/lib/src/console.dart"
    // Add this code to the bottom of the file
    extension TextRenderUtils on String {
      String get errorText => ConsoleColor.red.applyForeground(this);
      String get instructionText => ConsoleColor.yellow.applyForeground(this);
      String get titleText => ConsoleColor.lightBlue.applyForeground(this);

      List<String> splitLinesByLength(int length) {
        final List<String> words = split(' ');
        final List<String> output = <String>[];
        final StringBuffer strBuffer = StringBuffer();
        for (int i = 0; i < words.length; i++) {
          final String word = words[i];
          if (strBuffer.length + word.length <= length) {
            strBuffer.write(word.trim());
            if (strBuffer.length + 1 <= length) {
              strBuffer.write(' ');
            }
          }
          // If the next word surpasses length, start the next line
          if (i + 1 < words.length &&
              words[i + 1].length + strBuffer.length + 1 > length) {
            output.add(strBuffer.toString().trim());
            strBuffer.clear();
          }
        }

        // Add left overs
        output.add(strBuffer.toString().trim());
        return output;
      }
    }
    ```

    This code defines an extension called
    `TextRenderUtils` on the `String` class.
    It adds three getter methods for applying console colors:
    `errorText`, `instructionText`, and `titleText`.
    It also adds a method for splitting a string into
    lines of a specified length called `splitLinesByLength`.

    这段代码在 `String` 类上定义了名为
    `TextRenderUtils` 的扩展。
    它添加了三个用于应用控制台颜色的 getter：
    `errorText`、`instructionText` 和 `titleText`。
    它还添加了 `splitLinesByLength` 方法，
    用来把字符串按指定长度拆成多行。

### Task 3: Update command_runner package

### 任务 3：更新 command_runner package

Update the `command_runner` package to export `console.dart`.

更新 `command_runner` package，导出 `console.dart`。

1.  Open `command_runner/lib/command_runner.dart` and add the following line:

    打开 `command_runner/lib/command_runner.dart`，并添加下面这一行：

    ```dart title="command_runner/lib/command_runner.dart"
    library;

    export 'src/arguments.dart';
    export 'src/command_runner_base.dart';
    export 'src/exceptions.dart';
    export 'src/help_command.dart';
    export 'src/console.dart'; // Add this line

    // TODO: Export any libraries intended for clients of this package.
    ```

### Task 4: Implement colorful echo command

### 任务 4：实现彩色的 echo 命令

Finally, implement an example command to test the print.
It's good practice to implement example usage of a package in Dart for
developers that will use your package.
This example creates a command that makes console output colorful.

最后，实现一个示例命令来测试打印效果。
在 Dart 中为将要使用你的 package 的开发者提供示例用法，是个好习惯。
这个示例创建一条让控制台输出带上颜色的命令。

1.  Open the `example/command_runner_example.dart` file.

    打开 `example/command_runner_example.dart` 文件。
1.  Replace the contents of the file with the following code:

    用下面的代码替换文件内容：

    ```dart title="command_runner/example/command_runner_example.dart"
    import 'dart:async';

    import 'package:command_runner/command_runner.dart';

    class PrettyEcho extends Command {
      PrettyEcho() {
        addFlag(
          'blue-only',
          abbr: 'b',
          help: 'When true, the echoed text will all be blue.',
        );
      }

      @override
      String get name => 'echo';

      @override
      bool get requiresArgument => true;

      @override
      String get description => 'Print input, but colorful.';

      @override
      String? get help =>
          'echos a String provided as an argument with ANSI coloring,';

      @override
      String? get valueHelp => 'STRING';

      @override
      FutureOr<String> run(ArgResults arg) {
        if (arg.commandArg == null) {
          throw ArgumentException(
            'This argument requires one positional argument',
            name,
          );
        }

        List<String> prettyWords = [];
        var words = arg.commandArg!.split(' ');
        for (var i = 0; i < words.length; i++) {
          var word = words[i];
          switch (i % 3) {
            case 0:
              prettyWords.add(word.titleText);
            case 1:
              prettyWords.add(word.instructionText);
            case 2:
              prettyWords.add(word.errorText);
          }
        }

        return prettyWords.join(' ');
      }
    }

    void main(List<String> arguments) {
      final runner = CommandRunner()..addCommand(PrettyEcho());

      runner.run(arguments);
    }
    ```

    This code defines a `PrettyEcho` command that
    extends the `Command` class.
    It takes a string as an argument and
    applies different colors to each word
    based on its position in the string.
    The `run` method uses the
    `titleText`, `instructionText`, and `errorText` getter methods from
    the `TextRenderUtils` extension to apply the colors.

    这段代码定义了扩展 `Command` 类的 `PrettyEcho` 命令。
    它接收一个字符串参数，
    并根据每个单词在字符串中的位置涂上不同颜色。
    `run` 方法使用 `TextRenderUtils` 扩展中的
    `titleText`、`instructionText` 和 `errorText` getter
    来应用这些颜色。

1.  Navigate to `/dartpedia/command_runner` and run the following command:

    进入 `/dartpedia/command_runner`，并运行以下命令：

    ```bash
    dart run example/command_runner_example.dart echo "hello world goodbye"
    ```

    You should see the following text printed to the console,
    with the first word appearing in light blue,
    the second in yellow, and the third in red.

    你应该会看到下面的文本打印到控制台，
    第一个单词是浅蓝色，
    第二个是黄色，第三个是红色。

    ```bash
    hello world goodbye
    ```

## Review

## 回顾

<SummaryCard>
title: 你完成的内容
subtitle: 以下是你在本课中构建并学到的内容摘要。
completed: true
items:
  - title: 使用了带字段和方法的增强型枚举
    icon: format_list_bulleted
    details: >-
      你把 `ConsoleColor` 创建为增强型枚举，
      它带有 `r`、`g`、`b` 字段以及 `applyForeground()` 等方法。
      增强型枚举可以有构造函数、属性和方法，
      兼具枚举和普通类的优点。
  - title: 用扩展为现有类型添加了功能
    icon: extension
    details: >-
      你在 `String` 类上创建了 `TextRenderUtils` 扩展，
      为所有字符串添加 `errorText`、`titleText` 等 getter。
      扩展让你可以为任何类型添加功能，
      而不必修改它或创建子类。
      这对无法派生子类的字符串之类的类型尤其有用。
  - title: 添加了彩色的控制台输出
    icon: palette
    details: >-
      为了提高 CLI 的可读性和使用体验，
      你使用 ANSI 转义码为终端输出加上颜色。
      具体来说，你使用了 `ConsoleColor`，
      并让 CLI 用红色显示错误、用蓝色显示标题、用黄色显示说明。
</SummaryCard>

## Quiz

## 测验

<!-- title: Check your understanding -->
<Quiz title="检查你的理解" id="advanced-oop" />

## Next lesson

## 下一课

In the next lesson, you'll learn how to
further improve the `command_runner` package by
polishing the `HelpCommand`, completing the `CommandRunner` class,
adding the `onOutput` argument, and providing a complete example.

在下一课中，你将进一步改进 `command_runner` package：
打磨 `HelpCommand`、完成 `CommandRunner` 类、
添加 `onOutput` 参数，并提供一个完整示例。
