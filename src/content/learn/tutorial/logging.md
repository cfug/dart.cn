---
# title: Add logging for debugging and monitoring
title: 添加日志以便调试和监控
# short-title: Logging
short-title: 日志
# description: >-
#   Learn how to add logging to your Dart application to
#   help with debugging and monitoring.
description: 学习如何为 Dart 应用添加日志，以便调试和监控。
layout: learn
ai-translated: true
---

In this chapter, you'll learn how to add logging to your Dart application.
Logging is a critical tool for debugging, monitoring, and
understanding the behavior of your application in different environments.

在本章中，你将学习如何为 Dart 应用添加日志。
日志是调试、监控以及
理解应用在不同环境中行为的关键工具。

<SummaryCard>
title: 你将完成的内容
items:
  - title: 添加并了解 logging package
    icon: note_stack
  - title: 配置日志级别和文件输出
    icon: tune
  - title: 把日志接入 CLI 命令
    icon: terminal
</SummaryCard>

## Prerequisites

## 准备工作

Before you begin this chapter, ensure you:

开始本章之前，请确认你已经：

- Have completed Chapter 11 and have a
  working Dart development environment with the `dartpedia` project.

  完成了第 11 章，并且有可用的 Dart 开发环境，
  项目为 `dartpedia`。
- Understand the basics of debugging and why it's
  important to track errors and events in your application.

  理解调试的基础知识，以及为什么
  跟踪应用中的错误和事件很重要。

## Tasks

## 任务

In this chapter, you'll add logging to the `dartpedia` CLI application to
help track errors and monitor its behavior.
This will involve adding the `logging` package,
creating a `Logger` instance, and writing log messages to a file.

在本章中，你将为 `dartpedia` CLI 应用添加日志，
帮助跟踪错误并监控它的行为。
这包括添加 `logging` package、
创建 `Logger` 实例，以及把日志消息写入文件。

### Task 1: Add the `logging` package

### 任务 1：添加 `logging` package

First, add the `logging` package to your project's dependencies.

首先，把 `logging` package 添加到项目依赖中。

1.  Open the `cli/pubspec.yaml` file.

    打开 `cli/pubspec.yaml` 文件。

1.  Locate the `dependencies` section.

    找到 `dependencies` 部分。

1.  Add the `logging` package to your dependencies:

    把 `logging` package 添加到依赖中：

    ```yaml
    dependencies:
      http: ^1.3.0
      command_runner:
        path: ../command_runner
      wikipedia:
        path: ../wikipedia
      # Add the following line
      logging: ^1.2.0
    ```

1.  Run `dart pub get` in the `cli` directory to fetch the new dependency.

    在 `cli` 目录中运行 `dart pub get`，获取新的依赖。

### Task 2: Create a logger

### 任务 2：创建 logger

Next, create a `Logger` instance and configure it to
write log messages to a file. This involves
creating a new file for the logger and setting up the necessary imports.

接下来，创建 `Logger` 实例，并把它配置为
把日志消息写入文件。这包括
为 logger 创建新文件，并设置必要的 import。

1.  Create a new file called `cli/lib/src/logger.dart`.

    创建名为 `cli/lib/src/logger.dart` 的新文件。

1.  Add the necessary imports and define the `initFileLogger` function.

    添加必要的 import，并定义 `initFileLogger` 函数。

    ```dart title="cli/lib/src/logger.dart"
    import 'dart:io';
    import 'package:logging/logging.dart';

    Logger initFileLogger(String name) {
      // Enables logging from child loggers.
      hierarchicalLoggingEnabled = true;

      // Create a logger instance with the provided name.
      final logger = Logger(name);
      final now = DateTime.now();

      // The rest of the function will be added below.
      // ...

      return logger;
    }
    ```

1.  Add the code to find the project's root directory,
    create a `logs` directory if one doesn't exist, and
    create a unique log file.

    添加代码来找到项目根目录，
    如果 `logs` 目录不存在就创建它，
    并创建一个唯一的日志文件。

    ```dart
    Logger initFileLogger(String name) {
      hierarchicalLoggingEnabled = true;
      final logger = Logger(name);
      final now = DateTime.now();

      // Get the path to the project directory from the current script.
      final scriptFile = File(Platform.script.toFilePath());
      final projectDir = scriptFile.parent.parent.path;

      // Create a 'logs' directory if it doesn't exist.
      final dir = Directory('$projectDir/logs');
      if (!dir.existsSync()) dir.createSync();

      // Create a log file with a unique name based on
      // the current date and logger name.
      final logFile = File(
        '${dir.path}/${now.year}_${now.month}_${now.day}_$name.txt',
      );

      // The rest of the function will be added below.
      // ...

      return logger;
    }
    ```

1.  Configure the logger's level and set up a listener to
    write log messages to the file.

    配置 logger 的级别，并设置监听器，
    把日志消息写入文件。

    ```dart
    Logger initFileLogger(String name) {
      hierarchicalLoggingEnabled = true;
      final logger = Logger(name);
      final now = DateTime.now();

      final scriptFile = File(Platform.script.toFilePath());
      final projectDir = scriptFile.parent.parent.path;
      final dir = Directory('$projectDir/logs');
      if (!dir.existsSync()) dir.createSync();
      final logFile = File(
        '${dir.path}/${now.year}_${now.month}_${now.day}_$name.txt',
      );

      // Set the logger level to ALL, so it logs all messages regardless of severity.
      // Level.ALL is useful for development and debugging, but you'll likely want to
      // use a more restrictive level like Level.INFO or Level.WARNING in production.
      logger.level = Level.ALL;

      // Listen for log records and write each one to the log file.
      logger.onRecord.listen((record) {
        final msg =
            '[${record.time} - ${record.loggerName}] ${record.level.name}: ${record.message}';
        logFile.writeAsStringSync('$msg \n', mode: FileMode.append);
      });

      return logger;
    }
    ```

    This code does the following:

    这段代码会做以下事情：

    -   It enables hierarchical logging using
        `hierarchicalLoggingEnabled = true`.

        它用 `hierarchicalLoggingEnabled = true` 启用分层日志。
    -   It creates a `Logger` instance with the given name.

        它用给定的名称创建一个 `Logger` 实例。
    -   It gets the project directory from the `Platform.script.path`.

        它从 `Platform.script.path` 取得项目目录。
    -   It creates a `logs` directory if it doesn't exist.

        如果 `logs` 目录不存在，它会创建该目录。
    -   It creates a log file with the current date and the logger name.

        它用当前日期和 logger 名称创建一个日志文件。
    -   It sets the logger level to `Level.ALL`,
        meaning it will log all messages.
        This is useful for development and debugging, but
        you'll likely want to use a more restrictive level like
        `Level.INFO` or `Level.WARNING` in production.

        它把 logger 级别设为 `Level.ALL`，
        也就是会记录所有消息。
        这对开发和调试很有用，
        但在生产环境中，你多半会想用更严格的级别，
        例如 `Level.INFO` 或 `Level.WARNING`。
    -   It listens for log records and writes them to the log file.

        它监听日志记录，并把它们写入日志文件。

1. Create a new file called `cli/lib/cli.dart` and export `logger.dart`.
   This makes the `initFileLogger` available to other parts of your app.

   创建名为 `cli/lib/cli.dart` 的新文件，并导出 `logger.dart`。
   这样应用的其他部分就可以使用 `initFileLogger`。

   ```dart title="cli/lib/cli.dart"
    export 'src/commands/get_article.dart';
    export 'src/commands/search.dart';
    export 'src/logger.dart';
   ```

### Task 3: Use the logger in `cli.dart`

### 任务 3：在 `cli.dart` 中使用 logger

Now, use the `initFileLogger` function in `cli/bin/cli.dart` to
create a logger instance and log messages to a file.

现在，在 `cli/bin/cli.dart` 中使用 `initFileLogger` 函数，
创建 logger 实例，并把日志消息写入文件。

1.  Open the `cli/bin/cli.dart` file.

    打开 `cli/bin/cli.dart` 文件。

1.  Add the import for the logger:

    添加 logger 的 import：

    ```dart title="cli/bin/cli.dart"
    import 'package:cli/cli.dart';
    import 'package:command_runner/command_runner.dart';
    ```

1.  Modify the `main` function to initialize the logger and
    pass it to the commands:

    修改 `main` 函数，初始化 logger，
    并把它传给各个命令：

    ```dart title="cli/bin/cli.dart"
    import 'package:cli/cli.dart';
    import 'package:command_runner/command_runner.dart';

    void main(List<String> arguments) async {
      final errorLogger = initFileLogger('errors');
      final app =
          CommandRunner(
              onOutput: (String output) async {
                await write(output);
              },
              onError: (Object error) {
                if (error is Error) {
                  errorLogger.severe(
                    '[Error] ${error.toString()}\n${error.stackTrace}',
                  );
                  throw error;
                }
                if (error is Exception) {
                  errorLogger.warning(error);
                  print(error);
                }
              },
            )
            ..addCommand(HelpCommand())
            ..addCommand(SearchCommand(logger: errorLogger))
            ..addCommand(GetArticleCommand(logger: errorLogger));

      app.run(arguments);
    }
    ```

    This code does the following:

    这段代码会做以下事情：

    -   It initializes a `Logger` instance using `initFileLogger('errors')`.

        它用 `initFileLogger('errors')` 初始化一个 `Logger` 实例。
    -   It passes the `logger` instance to `CommandRunner` and
        individual commands.

        它把 `logger` 实例传给 `CommandRunner`
        和各个命令。

### Task 4: Create the SearchCommand command

### 任务 4：创建 SearchCommand 命令

The core functionality of the CLI lives in its commands.
Create the `SearchCommand` and `GetArticleCommand` files and
add the necessary code, including the logging and error handling.

CLI 的核心功能就在它的命令里。
创建 `SearchCommand` 和 `GetArticleCommand` 文件，
并添加必要的代码，包括日志和错误处理。

1.  Create a new file named `/cli/lib/src/commands/search.dart`.

    创建名为 `/cli/lib/src/commands/search.dart` 的新文件。

1.  Add the imports and a basic class structure.
    This `SearchCommand` class extends `Command`, and
    its constructor accepts a `Logger` instance.
    Accepting the logger in the constructor is a
    common pattern called dependency injection,
    which allows the command to log events without
    needing to create its own logger.

    添加 import 和基本的类结构。
    这个 `SearchCommand` 类扩展了 `Command`，
    它的构造函数接受一个 `Logger` 实例。
    在构造函数中接收 logger 是一种常见模式，叫做依赖注入。
    这样命令就可以记录事件，而不必自己创建 logger。

    ```dart
    import 'dart:async';
    import 'dart:io';

    import 'package:command_runner/command_runner.dart';
    import 'package:logging/logging.dart';
    import 'package:wikipedia/wikipedia.dart';

    class SearchCommand extends Command {
      SearchCommand({required this.logger});

      final Logger logger;

      @override
      String get description => 'Search for Wikipedia articles.';

      @override
      bool get requiresArgument => true;

      @override
      String get name => 'search';

      @override
      String get valueHelp => 'STRING';

      @override
      String get help =>
          'Prints a list of links to Wikipedia articles that match the given term.';

      @override
      FutureOr<String> run(ArgResults args) async {
        // The rest of the function will be added below.
        // ...
      }
    }
    ```

1.  Now, add the core logic to the `run` method.
    This code checks for a valid argument,
    calls the `search()` function from the `wikipedia` package,
    formats the results, and returns the results as a string.

    现在，把核心逻辑添加到 `run` 方法。
    这段代码检查参数是否有效，
    调用 `wikipedia` package 中的 `search()` 函数，
    格式化结果，并把结果作为字符串返回。

    ```dart
    import 'dart:async';
    import 'dart:io';

    import 'package:command_runner/command_runner.dart';
    import 'package:logging/logging.dart';
    import 'package:wikipedia/wikipedia.dart';

    class SearchCommand extends Command {
      SearchCommand({required this.logger});

      final Logger logger;

      @override
      String get description => 'Search for Wikipedia articles.';

      @override
      bool get requiresArgument => true;

      @override
      String get name => 'search';

      @override
      String get valueHelp => 'STRING';

      @override
      String get help =>
          'Prints a list of links to Wikipedia articles that match the given term.';

      @override
      FutureOr<String> run(ArgResults args) async {
        if (requiresArgument &&
            (args.commandArg == null || args.commandArg!.isEmpty)) {
          throw ArgumentException('Please include a search term', name);
        }

        final buffer = StringBuffer('Search results:\n');
        final SearchResults results = await search(args.commandArg!);

        for (var result in results.results) {
          buffer.writeln('${result.title} - ${result.url}');
        }
        return buffer.toString();
      }
    }
    ```

1.  Next, add the "I'm feeling lucky" feature by
    adding a flag to the constructor. Then, in the `run` method,
    add the logic to check if the flag is set and, if so,
    get the summary of the top search result.

    接下来，为构造函数添加一个标志，
    实现「I'm feeling lucky」（手气不错）功能。
    然后在 `run` 方法中加入逻辑：如果设置了这个标志，
    就获取排名第一的搜索结果的摘要。

    ```dart
    import 'dart:async';
    import 'dart:io';

    import 'package:command_runner/command_runner.dart';
    import 'package:logging/logging.dart';
    import 'package:wikipedia/wikipedia.dart';

    class SearchCommand extends Command {
      SearchCommand({required this.logger}) {
        addFlag(
          'im-feeling-lucky',
          help:
              'If true, prints the summary of the top article that the search returns.',
        );
      }

      final Logger logger;

      @override
      String get description => 'Search for Wikipedia articles.';

      @override
      bool get requiresArgument => true;

      @override
      String get name => 'search';

      @override
      String get valueHelp => 'STRING';

      @override
      String get help =>
          'Prints a list of links to Wikipedia articles that match the given term.';

      @override
      FutureOr<String> run(ArgResults args) async {
        if (requiresArgument &&
            (args.commandArg == null || args.commandArg!.isEmpty)) {
          throw ArgumentException('Please include a search term', name);
        }

        final buffer = StringBuffer('Search results:\n');
        final SearchResults results = await search(args.commandArg!);

        if (args.flag('im-feeling-lucky')) {
          final title = results.results.first.title;
          final Summary article = await getArticleSummaryByTitle(title);
          buffer.writeln('Lucky you!');
          buffer.writeln(article.titles.normalized.titleText);
          if (article.description != null) {
            buffer.writeln(article.description);
          }
          buffer.writeln(article.extract);
          buffer.writeln();
          buffer.writeln('All results:');
        }

        for (var result in results.results) {
          buffer.writeln('${result.title} - ${result.url}');
        }
        return buffer.toString();
      }
    }
    ```

1.  Finally, wrap the main logic in a `try/catch` block.
    This allows you to handle potential exceptions that
    could arise from network issues or data formatting problems.
    You'll use the injected `logger` to record these errors to the log file.

    最后，把主要逻辑包进 `try/catch` 块。
    这样你就可以处理网络问题或数据格式问题
    可能引发的异常。
    你将使用注入的 `logger` 把这些错误记录到日志文件。

    ```dart
    import 'dart:async';
    import 'dart:io';

    import 'package:command_runner/command_runner.dart';
    import 'package:logging/logging.dart';
    import 'package:wikipedia/wikipedia.dart';

    class SearchCommand extends Command {
      SearchCommand({required this.logger}) {
        addFlag(
          'im-feeling-lucky',
          help:
              'If true, prints the summary of the top article that the search returns.',
        );
      }

      final Logger logger;

      @override
      String get description => 'Search for Wikipedia articles.';

      @override
      bool get requiresArgument => true;

      @override
      String get name => 'search';

      @override
      String get valueHelp => 'STRING';

      @override
      String get help =>
          'Prints a list of links to Wikipedia articles that match the given term.';

      @override
      FutureOr<String> run(ArgResults args) async {
        if (requiresArgument &&
            (args.commandArg == null || args.commandArg!.isEmpty)) {
          throw ArgumentException('Please include a search term', name);
        }

        final buffer = StringBuffer('Search results:\n');
        try {
          final SearchResults results = await search(args.commandArg!);

          if (args.flag('im-feeling-lucky')) {
            final title = results.results.first.title;
            final Summary article = await getArticleSummaryByTitle(title);
            buffer.writeln('Lucky you!');
            buffer.writeln(article.titles.normalized.titleText);
            if (article.description != null) {
              buffer.writeln(article.description);
            }
            buffer.writeln(article.extract);
            buffer.writeln();
            buffer.writeln('All results:');
          }

          for (var result in results.results) {
            buffer.writeln('${result.title} - ${result.url}');
          }
          return buffer.toString();
        } on HttpException catch (e) {
          logger
            ..warning(e.message)
            ..warning(e.uri)
            ..info(usage);
          return e.message;
        } on FormatException catch (e) {
          logger
            ..warning(e.message)
            ..warning(e.source)
            ..info(usage);
          return e.message;
        }
      }
    }
    ```

### Task 5: Create the GetArticleCommand command

### 任务 5：创建 GetArticleCommand 命令

Now, create the `GetArticleCommand` file and add the necessary code.
The code is similar to the previous `SearchCommand`, as it also
uses a `try/catch` block to handle potential network or data errors.

现在，创建 `GetArticleCommand` 文件并添加必要的代码。
这段代码与前面的 `SearchCommand` 类似，
同样用 `try/catch` 块处理可能的网络或数据错误。

1.  Create a new file named cli/lib/src/commands/get_article.dart.

    创建名为 cli/lib/src/commands/get_article.dart 的新文件。

1.  Add the following code to `get_article.dart`.

    把下面的代码添加到 `get_article.dart`。

    ```dart
    import 'dart:async';
    import 'dart:io';

    import 'package:command_runner/command_runner.dart';
    import 'package:logging/logging.dart';
    import 'package:wikipedia/wikipedia.dart';

    class GetArticleCommand extends Command {
      GetArticleCommand({required this.logger});

      final Logger logger;

      @override
      String get description => 'Read an article from Wikipedia';

      @override
      String get name => 'article';

      @override
      String get help => 'Gets an article by exact canonical wikipedia title.';

      @override
      String get defaultValue => 'cat';

      @override
      String get valueHelp => 'STRING';

      @override
      FutureOr<String> run(ArgResults args) async {
        try {
          var title = args.commandArg ?? defaultValue;
          final List<Article> articles = await getArticleByTitle(title);
          // API returns a list of articles, but we only care about the closest hit.
          final article = articles.first;
          final buffer = StringBuffer('\n=== ${article.title.titleText} ===\n\n');
          buffer.write(article.extract.split(' ').take(500).join(' '));
          return buffer.toString();
        } on HttpException catch (e) {
          logger
            ..warning(e.message)
            ..warning(e.uri)
            ..info(usage);
          return e.message;
        } on FormatException catch (e) {
          logger
            ..warning(e.message)
            ..warning(e.source)
            ..info(usage);
          return e.message;
        }
      }
    }
    ```

    Review the code you've just added.
    The `SearchCommand` and `GetArticleCommand` now:

    回顾一下你刚添加的代码。
    `SearchCommand` 和 `GetArticleCommand` 现在会：

    - Import the necessary packages like `command_runner`, `logging`, and
      `wikipedia` to use their classes and functions.

      导入 `command_runner`、`logging` 和
      `wikipedia` 等必要的 package，以使用它们的类和函数。
    - Accept a `Logger` instance through their constructor.
      This is a common pattern called dependency injection,
      which allows the command to log events without
      needing to create its own logger.

      通过构造函数接受 `Logger` 实例。
      这是一种叫做依赖注入的常见模式。
      这样命令就可以记录事件，而不必自己创建 logger。
    - Implement a `run` method that defines the command's logic.
      This method calls the appropriate wikipedia API and formats the output.

      实现定义命令逻辑的 `run` 方法。
      这个方法调用相应的 Wikipedia API，并格式化输出。
    - Include `try/catch` blocks to gracefully
      handle network errors (`HttpException`) and
      data parsing errors (`FormatException`), logging them for debugging.

      包含 `try/catch` 块，妥善处理
      网络错误（`HttpException`）和
      数据解析错误（`FormatException`），并把它们记入日志以便调试。


### Task 6: Run the application and check the logs

### 任务 6：运行应用并检查日志

Now that you've added logging to your application,
run it and check the log file to see the results.

现在你已经为应用添加了日志，
运行它并检查日志文件，看看结果。

1.  Run the application with a command that might produce an error.
    For example, try searching for an article that
    doesn't exist or that causes a `FormatException`.

    用一条可能会产生错误的命令运行应用。
    例如，试着搜索一篇不存在的文章，
    或者会引发 `FormatException` 的文章。

    ```bash
    dart run bin/cli.dart search blahblahblahblah
    ```

1.  Check the `logs` directory in your project.
    You should see a file with the current date and the name `errors.txt`.

    检查项目中的 `logs` 目录。
    你应该会看到一个以当前日期命名、名为 `errors.txt` 的文件。

1.  Open the log file and verify that the error message is logged.

    打开日志文件，确认错误消息已被记录。

    ```text
    [2025-02-20 16:23:45.678 - errors] WARNING: HttpException: HttpException: , uri = https://en.wikipedia.org/w/api.php?action=opensearch&format=json&search=blahblahblahblah
    [2025-02-20 16:23:45.678 - errors] INFO: Usage: dart bin/cli.dart <command> [commandArg?] [...options?]
    ```

## Review

## 回顾

<SummaryCard>
title: 你完成的内容
subtitle: 以下是你在本课中构建并学到的内容摘要。
completed: true
items:
  - title: 添加并了解了 logging package
    icon: note_stack
    details: >-
      你把 `logging` 添加到依赖中，并导入到 CLI。
      这个 package 提供 `Logger`、`Level` 和 `LogRecord` 类，
      用于带有可配置严重级别的结构化日志。
  - title: 配置了日志级别和文件输出
    icon: tune
    details: >-
      你创建了 `initFileLogger()`，把分层日志
      写到 `logs/` 目录中带时间戳的文件里。
      这样你就可以在事后回顾应用的行为。
  - title: 把日志接入了 CLI 命令
    icon: terminal
    details: >-
      你通过依赖注入把 logger 传给命令，
      然后用 `logger.warning()`、`logger.severe()` 和 `logger.info()`
      记录不同级别的错误以及相关上下文。
      这样在开发和生产环境中都更容易调试和筛选问题。
</SummaryCard>

## Quiz

## 测验

<!-- title: Check your understanding -->
<Quiz title="检查你的理解" id="logging" />

## Next lesson

## 下一课

Congratulations! You've now completed all the
core chapters of the Dart Getting Started tutorial.
Want to continue learning?
Check out the next step in the
[Dart and Flutter learning pathway][] on the Flutter site.

恭喜！你已经完成了
Dart 入门教程的全部核心章节。
还想继续学习吗？
请查看 Flutter 网站上
[Dart 与 Flutter 学习路径][Dart and Flutter learning pathway] 的下一步。

[Dart and Flutter learning pathway]: {{site.flutter-docs}}/learn/pathway
