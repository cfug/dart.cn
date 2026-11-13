---
# title: Define relationships with classes
title: 用类定义关系
# shortTitle: Object-oriented Dart
shortTitle: 面向对象的 Dart
# description: >-
#   Learn about object-oriented programming in Dart, including
#   abstract classes, inheritance, overrides, and enums.
#   Build a framework for well-architected CLI apps.
description: >-
  了解 Dart 中的面向对象编程，包括抽象类、继承、重写和枚举。
  为结构良好的 CLI 应用搭建框架。
layout: learn
ai-translated: true
---

In this chapter, you'll explore the
power of object-oriented programming (OOP) in Dart.
You'll learn how to create [classes](/language/classes) and
define relationships between them, including
[inheritance](/language/extend) and
[abstract classes](/language/class-modifiers#abstract).
You'll also build a foundation for creating well-structured CLI applications.

在本章中，你将探索
Dart 中面向对象编程（OOP）的能力。
你将学习如何创建 [类](/language/classes)，
并定义它们之间的关系，包括
[继承](/language/extend) 和
[抽象类](/language/class-modifiers#abstract)。
你还会为创建结构良好的 CLI 应用打下基础。

<SummaryCard>
title: 你将完成的内容
items:
  - title: 设计并理解抽象类
    icon: schema
  - title: 扩展父类并重写方法
    icon: account_tree
  - title: 用枚举表示固定的一组值
    icon: format_list_bulleted
  - title: 继续构建你的 CLI 框架
    icon: terminal
</SummaryCard>

## Prerequisites

## 准备工作

Before you begin this chapter, ensure you:

开始本章之前，请确认你已经：

- Have completed Chapter 4 and have a
  working Dart development environment with the `dartpedia` project.

  完成了第 4 章，并且有可用的 Dart 开发环境，
  项目为 `dartpedia`。
- Are familiar with basic programming concepts like
  variables, functions, and control flow.

  熟悉变量、函数、控制流等基本编程概念。
- Understand the concepts of packages and libraries in Dart.

  理解 Dart 中 package 和库的概念。

## Tasks

## 任务

A command-line interface (CLI) is defined by the
commands, options, and arguments a user can type into their terminal.

命令行界面（CLI）由用户可以在终端中输入的
命令、选项和参数来定义。

By the end of this lesson, you will have
built a framework that can understand a command like this:

本课结束时，你将搭建一个框架，
它能够理解像下面这样的命令：

```bash
$ dartpedia help --verbose --command=search
```

Here is a breakdown of each part:

下面拆开说明每一部分：

- `dartpedia`:
  This is the **executable**, the name of your application.

  这是 **可执行文件**，也就是应用的名称。
- `help`:
  This is a **command**, an action you want the application to perform.

  这是一条 **命令**，也就是你希望应用执行的动作。
- `--verbose`:
  This is a **flag** (a type of option that doesn't take a value),
  which modifies the command's behavior.

  这是一个 **标志**（一种不接收值的选项），
  用来改变命令的行为。
- `--command=search`:
  This is an **option** that takes a value.
  Here, the `option` is named `command`, and its value is `search`.

  这是一个接收值的 **选项**。
  这里，`option` 的名称是 `command`，它的值是 `search`。

The classes and logic you build in the following tasks
create the foundation for parsing and executing commands just like this one.

你在后续任务中构建的类和逻辑，
就是解析并执行这类命令的基础。

### Task 1: Define the argument hierarchy

### 任务 1：定义参数的层次结构

First, you'll define an `Argument` class,
an `Option` class, and a `Command` class,
establishing an inheritance relationship.

首先，你将定义 `Argument` 类、
`Option` 类和 `Command` 类，
并建立继承关系。

1.  Create the file `command_runner/lib/src/arguments.dart`.
    This file will
    contain the definitions for your `Argument`, `Option`, `Command`, and
    `ArgResults` classes.

    创建文件 `command_runner/lib/src/arguments.dart`。
    这个文件将包含
    `Argument`、`Option`、`Command` 和
    `ArgResults` 类的定义。

1.  Define an `enum` called `OptionType`.

    定义一个名为 `OptionType` 的 `enum`。

    ```dart title="command_runner/lib/src/arguments.dart"
    enum OptionType { flag, option }
    ```

    This [`enum`](/language/enums) represents the type of option,
    which can be either a **`flag`**
    (a boolean option) or a regular **`option`** (an option that takes a value).
    Enums are useful for representing a fixed set of possible values.

    这个 [`枚举`](/language/enums) 表示选项的类型，
    可以是 **`flag`**
    （布尔选项），也可以是普通的 **`option`**（接收值的选项）。
    枚举适合表示一组固定的可能值。

1.  Define an `abstract class` called `Argument`.

    定义一个名为 `Argument` 的 `abstract class`。

    Start by defining the basic structure of your `Argument` class.
    You'll declare it as [`abstract`](/language/class-modifiers#abstract),
    which means it serves as a base class that
    other classes can extend, but it can't be [instantiated](/resources/glossary#instantiate) on its own.

    先定义 `Argument` 类的基本结构。
    你将把它声明为 [`abstract`](/language/class-modifiers#abstract)，
    这意味着它是一个基类，
    其他类可以扩展它，但它自己不能被 [实例化](/resources/glossary#instantiate)。

    Below the `enum` you just added, paste in the following code:

    在你刚添加的 `enum` 下方，粘贴下面的代码：

    ```dart title="command_runner/lib/src/arguments.dart"
    // Paste this new class below the enum you added
    abstract class Argument {
      String get name;
      String? get help;

      // In the case of flags, the default value is a bool.
      // In other options and commands, the default value is a String.
      // NB: flags are just Option objects that don't take arguments
      Object? get defaultValue;
      String? get valueHelp;

      String get usage;
    }
    ```

    - **`name`** is a `String` that uniquely identifies the argument.

      **`name`** 是唯一标识该参数的 `String`。
    - **`help`** is an optional `String` that provides a description.

      **`help`** 是可选的 `String`，用来提供说明。
    - **`defaultValue`** is of type `Object?` because it
      can be a `bool` (for flags) or a `String`.

      **`defaultValue`** 的类型是 `Object?`，因为它
      可以是 `bool`（用于标志）或 `String`。
    - **`valueHelp`** is an optional `String` to
      give a hint about the expected value.

      **`valueHelp`** 是可选的 `String`，
      用来提示期望的值。
    - The **`usage`** [getter](/resources/glossary#getter) will provide a
      string showing how
      to use the argument.

      **`usage`** [getter](/resources/glossary#getter) 会提供一个字符串，
      说明如何使用这个参数。

    With the `Argument` class fully defined,
    you have a common interface for all types of command-line arguments.
    Next, you'll build upon this by defining `Option`,
    a specific type of argument that extends `Argument`.

    `Argument` 类定义完整之后，
    你就有了所有类型命令行参数的公共接口。
    接下来，你将在此基础上定义 `Option`，
    它是扩展 `Argument` 的一种具体参数。

1.  Define a class called `Option` that `extends` `Argument`.

    定义一个 `extends` `Argument` 的类，名为 `Option`。

    The `Option` class will represent command-line options like
    `--verbose` or `--output=file.txt`.
    It will inherit from your `Argument` class.

    `Option` 类将表示 `--verbose` 或 `--output=file.txt`
    这样的命令行选项。
    它会继承你的 `Argument` 类。

    Add the following `Option` class to the bottom of your file:

    把下面的 `Option` 类添加到文件底部：

    ```dart title="command_runner/lib/src/arguments.dart"
    class Option extends Argument {
      Option(
        this.name, {
        required this.type,
        this.help,
        this.abbr,
        this.defaultValue,
        this.valueHelp,
      });

      @override
      final String name;

      final OptionType type;

      @override
      final String? help;

      final String? abbr;

      @override
      final Object? defaultValue;

      @override
      final String? valueHelp;

      @override
      String get usage {
        if (abbr != null) {
          return '-$abbr,--$name: $help';
        }

        return '--$name: $help';
      }
    }
    ```

    The [**`extends`**](/language/extend) keyword establishes the inheritance relationship.
    The class uses the [`@override`](/language/extend#overriding-members) annotation
    on its properties and getters to indicate it is replacing the
    placeholder members defined in `Argument`.

    [**`extends`**](/language/extend) 关键字建立继承关系。
    这个类在属性和 getter 上使用
    [`@override`](/language/extend#overriding-members) 注解，
    表示它正在替换 `Argument` 中定义的占位成员。

    It also adds `type` (using the `OptionType` enum) and an
    optional `abbr` for a short-form of the option.
    The `usage` getter is implemented to provide clear instructions to the user.

    它还添加了 `type`（使用 `OptionType` 枚举），
    以及可选的 `abbr`，作为选项的短形式。
    `usage` getter 的实现用来向用户提供清晰的说明。

    With `Option` complete, you have a specialized type of argument. Next,
    you'll define the `Command` class, another type of argument that will
    represent the main actions a user can perform in your CLI application.

    `Option` 完成后，你就有了一种专门的参数类型。接下来，
    你将定义 `Command` 类，这是另一种参数，
    用来表示用户在 CLI 应用中可以执行的主要动作。

1.  Define an [`abstract class`](/language/class-modifiers#abstract) called `Command` that also `extends` `Argument`.

    定义一个同样 `extends` `Argument` 的 [`抽象类`](/language/class-modifiers#abstract)，名为 `Command`。

    The `Command` class will represent an executable action.
    Since it provides a template for other commands to follow,
    you'll declare it as **`abstract`**.

    `Command` 类将表示一个可执行的动作。
    因为它为其他命令提供了要遵循的模板，
    你将把它声明为 **`abstract`**。

    ```dart title="command_runner/lib/src/arguments.dart"
    // Add this class below the Option class
    abstract class Command extends Argument {
      // Properties and methods will go here
    }
    ```

    The **`abstract`** keyword means that
    `Command` can't be instantiated directly.
    It serves as a base class for other classes.

    **`abstract`** 关键字意味着
    `Command` 不能被直接实例化。
    它是其他类的基类。

    Now, add the core properties.
    A command needs a `name` and `description`.
    It also needs a reference back to the `CommandRunner` that executes it.

    现在，添加核心属性。
    命令需要 `name` 和 `description`。
    它还需要一个指回执行它的 `CommandRunner` 的引用。

    ```dart title="command_runner/lib/src/arguments.dart"
    abstract class Command extends Argument {
      @override
      String get name;

      String get description;

      bool get requiresArgument => false;

      late CommandRunner runner;

      @override
      String? help;

      @override
      String? defaultValue;

      @override
      String? valueHelp;
    }
    ```

    The `runner` property is of type `CommandRunner`,
    which you will define later in `command_runner_base.dart`.

    `runner` 属性的类型是 `CommandRunner`，
    你稍后会在 `command_runner_base.dart` 中定义它。

    Notice the [**`late`**](/language/variables#late-variables) keyword.
    It tells Dart that you promise to initialize this variable
    before it's ever accessed, allowing you to declare
    a non-nullable variable without assigning it immediately.
    This is helpful when a variable's initialization
    depends on other objects (like a command being added to a runner).

    注意 [**`late`**](/language/variables#late-variables) 关键字。
    它告诉 Dart，你保证在访问这个变量之前完成初始化，
    这样你就可以声明一个不可空变量，而不必立刻赋值。
    当变量的初始化依赖于其他对象时
    （例如命令被添加到 runner 时），这很有用。

    To make Dart aware of this class, you must import its defining file.
    Add the following import to the
    top of `command_runner/lib/src/arguments.dart`:

    要让 Dart 知道这个类，你必须导入定义它的文件。
    把下面的 import 添加到
    `command_runner/lib/src/arguments.dart` 的顶部：

    ```dart
    import '../command_runner.dart';
    ```

    Next, you'll give commands their own set of options.
    To prevent other parts of your code from unexpectedly modifying
    these options, you'll store them in a [private](/resources/glossary#library-private) list (`_options`).
    In Dart, prefixing a variable or field name with an underscore (`_`)
    makes it library-private.

    接下来，你将为每条命令准备一组自己的选项。
    为了防止代码的其他部分意外修改这些选项，
    你要把它们存在一个 [私有](/resources/glossary#library-private) 列表（`_options`）里。
    在 Dart 中，变量或字段名以下划线（`_`）开头，
    就会变成库私有。

    Instead of allowing direct access, you expose the options through a
    read-only unmodifiable view ([`UnmodifiableSetView`][unmodifiable-set-view]).
    This approach is a core part
    of encapsulation: the practice of restricting direct access to a class's
    internal state to prevent unintended interference.

    你不直接开放访问，而是通过只读、不可修改的视图
    （[`UnmodifiableSetView`][unmodifiable-set-view]）暴露这些选项。
    这是封装的核心做法：
    限制对类内部状态的直接访问，
    以防止意外干扰。

    The `UnmodifiableSetView` class is part of Dart's core collection library.
    To use it, you must import that library.

    `UnmodifiableSetView` 类属于 Dart 的核心集合库。
    要使用它，你必须导入那个库。

    Update the imports at the top of your file to include `dart:collection`:

    更新文件顶部的 import，加入 `dart:collection`：

    ```dart
    import 'dart:collection'; // New import
    import '../command_runner.dart';
    ```

    Now, add the `options` list and getter to your `Command` class:

    现在，把 `options` 列表和 getter 添加到 `Command` 类：

    ```dart
    abstract class Command extends Argument {
      // ... existing properties ...

      @override
      String? valueHelp;


      // Add the following lines to the bottom of your Command class:

      final List<Option> _options = [];

      UnmodifiableSetView<Option> get options =>
          UnmodifiableSetView(_options.toSet());
    }
    ```

    Because `_options` is private, external code can't add options directly.
    To allow commands to define their options, you'll provide two internal
    helper methods: `addFlag` and `addOption`. These methods will instantiate
    the appropriate `Option` objects and add them to the private list.

    因为 `_options` 是私有的，外部代码不能直接添加选项。
    为了让命令能够定义自己的选项，你将提供两个内部辅助方法：
    `addFlag` 和 `addOption`。这些方法会实例化
    合适的 `Option` 对象，并把它们加入私有列表。

    ```dart
    abstract class Command extends Argument {
      // ... existing properties and getters ...

      UnmodifiableSetView<Option> get options =>
          UnmodifiableSetView(_options.toSet());


      // Add the following lines to the bottom of your Command class:

      // A flag is an [Option] that's treated as a boolean.
      void addFlag(String name, {String? help, String? abbr, String? valueHelp}) {
        _options.add(
          Option(
            name,
            help: help,
            abbr: abbr,
            defaultValue: false,
            valueHelp: valueHelp,
            type: OptionType.flag,
          ),
        );
      }

      // An option is an [Option] that takes a value.
      void addOption(
        String name, {
        String? help,
        String? abbr,
        String? defaultValue,
        String? valueHelp,
      }) {
        _options.add(
          Option(
            name,
            help: help,
            abbr: abbr,
            defaultValue: defaultValue,
            valueHelp: valueHelp,
            type: OptionType.option,
          ),
        );
      }
    }
    ```

    Finally, every command must have logic to execute when called.
    You'll define an abstract `run` method that concrete commands must implement.

    最后，每个命令在被调用时都必须有要执行的逻辑。
    你将定义一个抽象的 `run` 方法，具体命令必须实现它。

    Because a command might be either synchronous or asynchronous, its `run`
    method returns the [`FutureOr`][future-or] type from `dart:async`, allowing it to
    return either a raw value or a `Future`. This is your final required import.

    因为命令可能是同步的，也可能是异步的，它的 `run`
    方法返回 `dart:async` 中的 [`FutureOr`][future-or] 类型，
    因此既可以返回原始值，也可以返回 `Future`。
    这是你需要的最后一个 import。

    Update the imports at the top of your file to include `dart:async`:

    更新文件顶部的 import，加入 `dart:async`：

    ```dart
    import 'dart:async'; // New import
    import 'dart:collection';
    import '../command_runner.dart';
    ```

    Now you can add the abstract `run` method and
    provide the `usage` implementation to complete the `Command` class.

    现在你可以添加抽象的 `run` 方法，
    并提供 `usage` 的实现，从而完成 `Command` 类。

    ```dart
    abstract class Command extends Argument {
      // ... existing properties, getters, and methods ...

      void addOption(
        String name, {
        String? help,
        String? abbr,
        String? defaultValue,
        String? valueHelp,
      }) {
        _options.add(
          Option(
            name,
            help: help,
            abbr: abbr,
            defaultValue: defaultValue,
            valueHelp: valueHelp,
            type: OptionType.option,
          ),
        );
      }


      // Add the following lines to the bottom of your Command class:
      FutureOr<Object?> run(ArgResults args);

      @override
      String get usage {
        return '$name:  $description';
      }
    }
    ```

    - **`run(ArgResults args)`**:
      This abstract method is where a command's logic resides.
      Concrete subclasses *must* implement it.

      **`run(ArgResults args)`**：
      这个抽象方法是命令逻辑所在的地方。
      具体子类 **必须** 实现它。
    - **`usage`**:
      This getter provides a simple usage string,
      combining the command's `name` and `description`.

      **`usage`**：
      这个 getter 提供一个简单的用法字符串，
      把命令的 `name` 和 `description` 组合起来。

    The `Command` class now provides a
    robust foundation for all commands in your CLI app.
    With the class hierarchy in place, you're ready to
    define `ArgResults` to hold the parsed input.

    `Command` 类现在为 CLI 应用中的所有命令
    提供了稳健的基础。
    类层次结构就绪之后，你可以定义 `ArgResults`，
    用来保存解析后的输入。

1.  Define a class called `ArgResults`.

    定义一个名为 `ArgResults` 的类。

    ```dart title="command_runner/lib/src/arguments.dart"
    // Add this class to the end of the file
    class ArgResults {
      Command? command;
      String? commandArg;
      Map<Option, Object?> options = {};

      // Returns true if the flag exists.
      bool flag(String name) {
        // Only check flags, because we're sure that flags are booleans.
        for (var option in options.keys.where(
          (option) => option.type == OptionType.flag,
        )) {
          if (option.name == name) {
            return options[option] as bool;
          }
        }
        return false;
      }

      bool hasOption(String name) {
        return options.keys.any((option) => option.name == name);
      }

      ({Option option, Object? input}) getOption(String name) {
        var mapEntry = options.entries.firstWhere(
          (entry) => entry.key.name == name || entry.key.abbr == name,
        );

        return (option: mapEntry.key, input: mapEntry.value);
      }
    }
    ```

    This class represents the results of parsing command-line arguments.
    It holds the detected command, any argument to that command, and
    a map of the specified options.

    这个类表示解析命令行参数的结果。
    它保存检测到的命令、该命令的参数，
    以及指定选项的映射。

    - The `flag()` method: Iterates over the keys of the `options` map,
      filtering for those where `type` is `OptionType.flag`. It uses explicit type 
      casting (`as bool`) because we know flags are boolean values.

      `flag()` 方法：遍历 `options` 映射的键，
      筛选出 `type` 为 `OptionType.flag` 的项。
      它使用显式类型转换（`as bool`），
      因为可以确定标志就是布尔值。
    - Record types: The `getOption` method returns a record type
      `(option: ..., input: ...)`, which lets you group multiple values together 
      without creating a full class.

      记录类型：`getOption` 方法返回记录类型
      `(option: ..., input: ...)`，让你把多个值组合在一起，
      而不必创建一个完整的类。

    Now you have defined the basic structure for handling
    commands, arguments, and options in your command-line application.

    现在你已经定义了在命令行应用中处理
    命令、参数和选项的基本结构。

### Task 2: Update the CommandRunner class

### 任务 2：更新 CommandRunner 类

Next, update the `CommandRunner` class to use the new `Argument` hierarchy.

接下来，更新 `CommandRunner` 类，使用新的 `Argument` 层次结构。

1.  Open the `command_runner/lib/src/command_runner_base.dart` file.

    打开 `command_runner/lib/src/command_runner_base.dart` 文件。

1.  Replace the existing `CommandRunner` class with the following:

    用下面的代码替换现有的 `CommandRunner` 类：

    ```dart title="command_runner/lib/src/command_runner_base.dart"
    import 'dart:collection';
    import 'dart:io';
    import 'arguments.dart';

    class CommandRunner {
      final Map<String, Command> _commands = <String, Command>{};

      UnmodifiableSetView<Command> get commands =>
          UnmodifiableSetView<Command>(<Command>{..._commands.values});

      Future<void> run(List<String> input) async {
        final ArgResults results = parse(input);
        if (results.command != null) {
          Object? output = await results.command!.run(results);
          print(output.toString());
        }
      }

      void addCommand(Command command) {
        // TODO: handle error (Commands can't have names that conflict)
        _commands[command.name] = command;
        command.runner = this;
      }

      ArgResults parse(List<String> input) {
        var results = ArgResults();
        results.command = _commands[input.first];
        return results;
      }

      // Returns usage for the executable only.
      // Should be overridden if you aren't using [HelpCommand]
      // or another means of printing usage.

      String get usage {
        final exeFile = Platform.script.path.split('/').last;
        return 'Usage: dart bin/$exeFile <command> [commandArg?] [...options?]';
      }
    }
    ```

    This updated class incorporates your new object-oriented structure.
    It uses the spread operator (`...`) in the `commands` getter to
    unpack the values of the `_commands` map into a new set.
    This ensures the return value is a copy,
    preventing external code from modifying your data.

    这个更新后的类纳入了你的新面向对象结构。
    它在 `commands` getter 中使用展开运算符（`...`），
    把 `_commands` 映射的值展开到一个新集合中。
    这样返回值就是一份副本，
    外部代码就无法修改你的数据。

    In the `run()` method, `results.command!.run(...)` uses the
    not-null assertion operator (`!`) to tell the Dart analyzer that you are
    sure `results.command` is not null.
    It's safe here because you just checked if it wasn't null
    in the preceding `if` statement.

    在 `run()` 方法中，`results.command!.run(...)` 使用
    非空断言运算符（`!`）告诉 Dart 分析器，
    你确定 `results.command` 不是 null。
    这里是安全的，因为你刚刚在前面的 `if` 语句中
    检查过它不是 null。

    Here are the key implementation details:

    下面是关键的实现细节：

    - **`_commands` map:** A private map linking command names to their
      concrete `Command` object instances. Its values are exposed via an
      `UnmodifiableSetView`.

      **`_commands` 映射：** 一个私有映射，把命令名关联到
      具体的 `Command` 对象实例。它的值通过
      `UnmodifiableSetView` 暴露出来。
    - **`addCommand()`:** Registers a command and assigns `this` runner to the 
      command's `runner` property. This fulfills the `late` initialization 
      promise made earlier in the `Command` class.

      **`addCommand()`：** 注册一条命令，并把 `this` runner 赋给
      命令的 `runner` 属性。这就兑现了前面在 `Command` 类中
      做出的 `late` 初始化承诺。
    - **`parse()` and `run()`:** Evaluates the user's input, identifies the 
      corresponding `Command` from the map, and uses `await` to call the 
      command's `run()` method.

      **`parse()` 和 `run()`：** 解析用户输入，从映射中找出
      对应的 `Command`，并用 `await` 调用
      命令的 `run()` 方法。

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

    // TODO: Export any libraries intended for clients of this package.
    ```

    This makes the `arguments.dart`, `command_runner_base.dart`, and
    `help_command.dart` files available to other packages that
    depend on `command_runner`.

    这让依赖 `command_runner` 的其他 package
    可以使用 `arguments.dart`、`command_runner_base.dart` 和
    `help_command.dart`。

### Task 3: Create a HelpCommand

### 任务 3：创建 HelpCommand

Create a `HelpCommand` that extends the `Command` class and
prints usage information.

创建一个扩展 `Command` 类的 `HelpCommand`，
并打印用法信息。

1.  Create the file `command_runner/lib/src/help_command.dart`.

    创建文件 `command_runner/lib/src/help_command.dart`。

1.  Add the following code to `command_runner/lib/src/help_command.dart`:

    把下面的代码添加到 `command_runner/lib/src/help_command.dart`：

    ```dart title="command_runner/lib/src/help_command.dart"
    import 'dart:async';

    import 'arguments.dart';

    // Prints program and argument usage.
    //
    // When given a command as an argument, it prints the usage of
    // that command only, including its options and other details.
    // When the flag 'verbose' is set, it prints options and details for all commands.
    //
    // This command isn't automatically added to CommandRunner instances.
    // Packages users should add it themselves with [CommandRunner.addCommand],
    // or create their own command that prints usage.

    class HelpCommand extends Command {
      HelpCommand() {
        addFlag(
          'verbose',
          abbr: 'v',
          help: 'When true, this command will print each command and its options.',
        );
        addOption(
          'command',
          abbr: 'c',
          help:
              "When a command is passed as an argument, prints only that command's verbose usage.",
        );
      }
      @override
      String get name => 'help';

      @override
      String get description => 'Prints usage information to the command line.';

      @override
      String? get help => 'Prints this usage information';

      @override
      FutureOr<Object?> run(ArgResults args) async {
        var usage = runner.usage;
        for (var command in runner.commands) {
          usage += '\n ${command.usage}';
        }

        return usage;
      }
    }
    ```

    The `HelpCommand` class demonstrates the benefits of inheritance.
    It uses its parent's methods to set up its options,
    overrides the abstract `run` method,
    and accesses the `runner` state to generate the usage message.

    `HelpCommand` 类展示了继承的好处。
    它使用父类的方法来设置自己的选项，
    重写抽象的 `run` 方法，
    并访问 `runner` 的状态来生成用法消息。

### Task 4: Update cli.dart to use the new CommandRunner

### 任务 4：更新 cli.dart 以使用新的 CommandRunner

Modify `cli/bin/cli.dart` to use the new `CommandRunner` and `HelpCommand`.

修改 `cli/bin/cli.dart`，使用新的 `CommandRunner` 和 `HelpCommand`。

1.  Open the `cli/bin/cli.dart` file.

    打开 `cli/bin/cli.dart` 文件。

1.  Replace the existing code with the following:

    用下面的代码替换现有代码：

    ```dart title="cli/bin/cli.dart"
    import 'package:command_runner/command_runner.dart';

    const version = '0.0.1';

    void main(List<String> arguments) {
      var commandRunner = CommandRunner()..addCommand(HelpCommand());
      commandRunner.run(arguments);
    }
    ```

    This code creates a `CommandRunner` instance,
    adds the `HelpCommand` to it using a
    [method cascade](/language/operators#cascade-notation) (`..addCommand`)
    which lets you call a method on an object directly after creating it, and
    then runs the command runner with the command-line arguments.

    这段代码创建一个 `CommandRunner` 实例，
    用 [方法级联](/language/operators#cascade-notation)（`..addCommand`）
    把 `HelpCommand` 添加进去。
    级联让你在创建对象之后立刻调用方法，
    然后用命令行参数运行这个命令运行器。

### Task 5: Run the application

### 任务 5：运行应用

Test the new `CommandRunner` and `HelpCommand`.

测试新的 `CommandRunner` 和 `HelpCommand`。

1.  Open your terminal and navigate to the `cli` directory.

    打开终端，进入 `cli` 目录。

1.  Run the command `dart run bin/cli.dart help`.

    运行命令 `dart run bin/cli.dart help`。

    You should see the usage information printed to the console:

    你应该会看到用法信息打印到控制台：

    ```bash
    Usage: dart bin/cli.dart <command> [commandArg?] [...options?]
     help:  Prints usage information to the command line.
    ```

    This confirms that the `CommandRunner` and `HelpCommand` are
    working correctly.

    这确认 `CommandRunner` 和 `HelpCommand` 工作正常。

## Review

## 回顾

<SummaryCard>
title: 你完成的内容
subtitle: 以下是你在本课中构建并学到的内容摘要。
completed: true
items:
  - title: 设计并理解了抽象类
    icon: schema
    details: >-
      你创建了抽象的 `Argument` 类作为基类，
      它不能被直接实例化。
      抽象类定义了子类必须履行的约定，
      从而保证类层次结构的一致性。
  - title: 扩展了父类并重写了方法
    icon: account_tree
    details: >-
      你使用 `extends` 创建了抽象 `Argument` 类的
      `Option` 和 `Command` 子类。
      在这些子类中，你使用 `@override`
      为抽象成员提供具体实现。
  - title: 用枚举表示了固定的一组值
    icon: format_list_bulleted
    details: >-
      你定义了 `OptionType` 枚举来表示一组固定的值。
      在 Dart 中，枚举是类型安全的，
      有助于防止在只接受特定选项的地方使用无效值。
  - title: 继续构建了你的 CLI 框架
    icon: terminal
    details: >-
      你运用面向对象编程原则，实现了一个
      稳健且可扩展的命令行参数解析框架。
</SummaryCard>

## Quiz

## 测验

<!-- title: Check your understanding -->
<Quiz title="检查你的理解" id="object-oriented" />

## Next lesson

## 下一课

In the next lesson, you'll learn how to
handle errors and exceptions in your Dart code.
You'll create a custom exception class and
add error handling to your `CommandRunner` to
make your application more robust.

在下一课中，你将学习如何在 Dart 代码中
处理错误和异常。
你将创建一个自定义异常类，
并为 `CommandRunner` 添加错误处理，
让应用更加稳健。

[unmodifiable-set-view]: {{site.dart-api}}/dart-collection/UnmodifiableSetView-class.html
[future-or]: {{site.dart-api}}/dart-async/FutureOr-class.html
