---
# title: Build your first app
title: 构建你的第一个应用
# shortTitle: Your first app
shortTitle: 你的第一个应用
# description: >-
#   Create, run, and make your first change to a Dart command-line program.
description: 创建、运行 Dart 命令行程序，并完成你的第一次修改。
layout: learn
ai-translated: true
---

<YoutubeEmbed id="ulg4bjQQJi0" title="What is Dart?" fullWidth="true"></YoutubeEmbed>

Welcome to Dart! In this chapter, you'll
ensure your setup is complete and then
work through creating your first Dart program.
This chapter starts simple but moves fast!

欢迎来到 Dart！在本章中，你将先确认环境已经就绪，
然后动手创建你的第一个 Dart 程序。
本章开头很简单，但节奏会很快！

<SummaryCard>
title: 你将完成的内容
items:
  - title: 确认 Dart SDK 已安装
    icon: check_circle
  - title: 用 dart create 创建 CLI 项目
    icon: terminal
  - title: 运行并修改你的第一个程序
    icon: play_arrow
</SummaryCard>

## Prerequisites

## 准备工作

Before you begin this chapter, ensure you:

开始本章之前，请确认你已经：

- [Installed the Dart SDK](/get-dart).

  已 [安装 Dart SDK](/get-dart)。

- Reviewed the [Dart overview](/overview) (if you're new to Dart).

  已阅读 [Dart 概览](/overview)（如果你是 Dart 新手）。

## Tasks

## 任务

Create the classic Hello World in Dart to get your project started.

用 Dart 写出经典的 Hello World，让项目跑起来。

### Task 1: Confirm your Dart setup

### 任务 1：确认 Dart 环境

First, make sure Dart is ready to go on your system by following these steps.

首先，按以下步骤确认 Dart 已在你的系统上就绪。

1.  Open a terminal (or command prompt).

    打开终端（或命令提示符）。

1.  Run the following command to check your Dart SDK version:

    运行以下命令，检查你的 Dart SDK 版本：

    ```bash
    dart --version
    ```

1.  Make sure that you see output similar to this
    (the version numbers might be different):

    请确认你看到的输出与下面类似
    （版本号可能不同）：

    ```bash
    Dart SDK version: 3.9.2 (stable) (Wed Aug 27 03:49:40 2025 -0700) on "linux_x64"
    ```

    If you see an error like "command not found," refer to the
    [Dart installation guide][] to set up your environment.

    如果看到类似「command not found」的错误，
    请参阅 [Dart 安装指南][Dart installation guide] 完成环境配置。

[Dart installation guide]: /get-dart

### Task 2: Create a new Dart project

### 任务 2：创建新的 Dart 项目

Now, create your first Dart command-line application.

现在，创建你的第一个 Dart 命令行应用。

1.  In the same terminal,
    create a new directory called `dartpedia` to hold your project.
    Then switch into that directory.

    在同一个终端中，创建一个名为 `dartpedia` 的新目录来存放项目，
    然后进入该目录。

    ```bash
    mkdir dartpedia
    cd dartpedia
    ```

1.  Run the following command:

    运行以下命令：

    ```bash
    dart create cli
    ```

    The `dart create` command generates a basic Dart project named
    "cli" (for Command Line Interface).
    It sets up the essential files and directories you need.

    `dart create` 命令会生成一个名为「cli」的基础 Dart 项目
    （cli 表示命令行界面，Command Line Interface）。
    它会准备好你需要的核心文件和目录。

1.  You should see output similar to this, confirming the project creation:

    你应该会看到类似下面的输出，表示项目已创建成功：

    ```bash
    Creating cli using template console...

      .gitignore
      analysis_options.yaml
      CHANGELOG.md
      pubspec.yaml
      README.md
      bin/cli.dart
      lib/cli.dart
      test/cli_test.dart

    Running pub get...                     1.2s
      Resolving dependencies...
      Downloading packages...
      Changed 49 dependencies!

    Created project cli in cli! In order to get started, run the following commands:

      cd cli
      dart run
    ```

    :::note
    The `dart create` command created a number of files.
    Don't worry about these now.
    Their specifics will be covered in future chapters.

    `dart create` 命令创建了多个文件。
    现在不必在意这些文件。
    后续章节会介绍它们的具体作用。
    :::

### Task 3: Run your first Dart program

### 任务 3：运行你的第一个 Dart 程序

Next, run your program to test it out.

接下来，运行程序，确认它能正常工作。

1.  In the terminal, navigate into your new project directory:

    在终端中进入你新建的项目目录：

    ```bash
    cd cli
    ```

1.  Run the default application:

    运行默认应用：

    ```bash
    dart run
    ```

    This command tells Dart to execute your program.

    这条命令会让 Dart 执行你的程序。

1.  You should see the following output:

    你应该会看到以下输出：

    ```bash
    Building package executable...
    Built cli:cli.
    Hello world: 42!
    ```

    Congratulations! You've successfully run your first Dart program!

    恭喜！你已经成功运行了第一个 Dart 程序！

### Task 4: Make your first code change

### 任务 4：完成你的第一次代码修改

Next, modify the code that generated `Hello world: 42!`.

接下来，修改生成 `Hello world: 42!` 的那段代码。

1.  In a code editor, open the `bin/cli.dart` file.

    在代码编辑器中打开 `bin/cli.dart` 文件。

    The `bin/` directory is where your executable code lives.
    `cli.dart` is the entry point of your application.

    `bin/` 目录存放可执行代码。
    `cli.dart` 是应用的入口。

    Inside, you'll see the `main` function.
    Every Dart program starts executing from its `main` function.

    文件里有 `main` 函数。
    每个 Dart 程序都从 `main` 函数开始执行。

1.  Check to make sure that your `bin/cli.dart` looks like this:

    请确认你的 `bin/cli.dart` 如下所示：

    ```dart title="bin/cli.dart"
    import 'package:cli/cli.dart' as cli;

    void main(List<String> arguments) {
      print('Hello world: ${cli.calculate()}!');
    }
    ```

1.  Simplify the output for now.
    Delete the first line (you don't need this import statement), and
    change the `print` statement to display a simple greeting:

    先把输出简化一下。
    删掉第一行（你不需要这条 import 语句），
    并把 `print` 语句改成显示一句简单的问候：

    ```dart title="bin/cli.dart" highlightLines=1,4
    import 'package:cli/cli.dart' as cli; // Delete this entire line

    void main(List<String> arguments) {
      print('Hello, Dart!'); // Change this line
    }
    ```

1.  Save your file. Then in the terminal, run your program again:

    保存文件。然后在终端中再次运行程序：

    ```bash
    dart run
    ```

1.  Check to make sure that you see the following:

    请确认你看到以下输出：

    ```bash
    Building package executable...
    Built cli:cli.
    Hello, Dart!
    ```

    You've successfully modified and re-run your first Dart program!

    你已经成功修改并重新运行了第一个 Dart 程序！

## Review

## 回顾

<SummaryCard>
title: 你完成的内容
subtitle: 以下是你在本课中构建并学到的内容摘要。
completed: true
items:
  - title: 确认了 Dart SDK 已安装
    icon: check_circle
    details: >-
      你运行了 `dart --version`，确认 Dart 已正确安装，
      并且可以在终端中使用。
  - title: 创建了你的第一个 CLI 项目
    icon: terminal
    details: >-
      你使用 `dart create` 生成了一个新的命令行应用。
      这条命令会搭建一个基础项目，
      其中包含 `pubspec.yaml` 等核心文件。
      它还会生成带有 `main` 函数的 `bin/cli.dart`，
      这个函数是程序的入口。
  - title: 运行并修改了你的程序
    icon: play_arrow
    details: >-
      你用 `dart run` 执行了应用，并看到了「Hello world」输出。
      然后你修改了 `main` 函数，让它打印自定义问候语，
      亲身体验了 Dart 的编辑与运行循环。
</SummaryCard>

## Quiz

## 测验

Here's a quick quiz to solidify your learning.

这里有一个小测验，帮助你巩固所学内容。

:::note
You'll see these quizzes throughout this tutorial.
Feel free to skip them if you want.

本教程中会多次出现这类测验。
如果想跳过，可以直接略过。
:::

<!-- title: Check your understanding -->
<Quiz title="检查你的理解" id="first-app" />

## Next lesson

## 下一课

In the next lesson, you'll learn how to
make your program respond to specific commands by
introducing command-line arguments and the `const` keyword.

在下一课中，你将学习命令行参数和 `const` 关键字，
让程序能够响应特定命令。
