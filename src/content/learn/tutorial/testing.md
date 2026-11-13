---
# title: Test your app & code
title: 测试你的应用和代码
# shortTitle: Testing
shortTitle: 测试
# description: >-
#   Learn how to write tests for your Dart code
#   using the `package:test` library.
description: 学习如何使用 `package:test` 库为 Dart 代码编写测试。
layout: learn
ai-translated: true
---

In this chapter, you'll learn how to write tests for your Dart code.
Testing is crucial for ensuring that your application behaves
as expected and remains stable as you make changes.
You'll use the `package:test` library, a popular testing framework for Dart,
to write unit tests for the data models you created in the previous chapter.

在本章中，你将学习如何为 Dart 代码编写测试。
测试对于确保应用行为符合预期、
并在你修改代码后仍然稳定至关重要。
你将使用 Dart 中常用的测试框架 `package:test` 库，
为上一章创建的数据模型编写单元测试。

<SummaryCard>
title: 你将完成的内容
items:
  - title: 把 test package 添加为开发依赖
    icon: experiment
  - title: 用 test package 和匹配器编写结构化测试
    icon: lab_panel
  - title: 测试 JSON 反序列化逻辑
    icon: fact_check
</SummaryCard>

## Prerequisites

## 准备工作

Before you begin this chapter, ensure you:

开始本章之前，请确认你已经：

-   Have completed Chapter 9 and have a
    working Dart development environment with the `dartpedia` project.

    已完成第 9 章，并且有可用的 Dart 开发环境，
    项目为 `dartpedia`。
-   Are familiar with basic programming concepts like
    variables, functions, and control flow.

    熟悉变量、函数、控制流等基本编程概念。
-   Understand the purpose of testing in software development.

    理解软件开发中测试的目的。

## Tasks

## 任务

In this chapter, you will add tests to the `wikipedia` package,
ensuring that the JSON deserialization logic for
your data models is working correctly.

在本章中，你将为 `wikipedia` package 添加测试，
确保数据模型的 JSON 反序列化逻辑工作正常。

### Task 1: Add the test dependency

### 任务 1：添加 test 依赖

First, you need to confirm that the `test` package is
already a development dependency in your project.

首先，你需要确认 `test` package
已经是项目中的开发依赖。

1.  Open the `wikipedia/pubspec.yaml` file within your project.

    打开项目中的 `wikipedia/pubspec.yaml` 文件。
1.  Locate the `dev_dependencies` section.

    找到 `dev_dependencies` 部分。
1.  Verify that `test: ^1.24.0` (or the latest stable version) is
    present under `dev_dependencies`.

    确认 `dev_dependencies` 下已经有
    `test: ^1.24.0`（或最新的稳定版本）。

    ```yaml highlightLines=3
    dev_dependencies:
      lints: ^5.0.0
      test: ^1.24.0
    ```

    If the `test` dependency is missing, add it to your `pubspec.yaml` file.
    The `^` symbol allows compatible versions to be used.

    如果缺少 `test` 依赖，就把它添加到 `pubspec.yaml`。
    `^` 符号表示可以使用兼容的版本。

1.  If you made any changes to the file, save `pubspec.yaml` and
    run `dart pub get` in your terminal from the `wikipedia` directory.
    This command fetches any newly added dependencies and
    makes them available for use in your project.

    如果修改了文件，请保存 `pubspec.yaml`，
    并在终端中从 `wikipedia` 目录运行 `dart pub get`。
    这条命令会获取新添加的依赖，
    并让项目可以使用它们。

    You should see output similar to this:

    你应该会看到类似下面的输出：

    ```bash
    Resolving dependencies...
    Downloading packages...
    + test 1.25.1
    Changed 2 dependencies!
    ```

### Task 2: Create a test file and add imports

### 任务 2：创建测试文件并添加 import

Next, create a test file for your data models and
add the necessary imports to it.

接下来，为数据模型创建测试文件，
并添加必要的 import。

1.  Navigate to the `wikipedia/test` directory.

    进入 `wikipedia/test` 目录。
1.  Create a new file named `model_test.dart` in this directory.

    在这个目录中创建名为 `model_test.dart` 的新文件。
1.  Open the `wikipedia/test/model_test.dart` file and
    add the following `import` statements at the top of the file:

    打开 `wikipedia/test/model_test.dart` 文件，
    在文件顶部添加以下 `import` 语句：

    ```dart
    import 'dart:convert';
    import 'dart:io';

    import 'package:test/test.dart';
    import 'package:wikipedia/src/model/article.dart';
    import 'package:wikipedia/src/model/search_results.dart';
    import 'package:wikipedia/src/model/summary.dart';

    const String dartLangSummaryJson = './test/test_data/dart_lang_summary.json';
    const String catExtractJson = './test/test_data/cat_extract.json';
    const String openSearchResponse = './test/test_data/open_search_response.json';
    ```

    These lines import the `test` package, which provides
    the testing framework and the data model files you want to test.
    The constant strings declare the location of your sample data.

    这些语句导入 `test` package，它提供测试框架，
    也导入你要测试的数据模型文件。
    常量字符串声明了示例数据的位置。

### Task 3: Create the test data files

### 任务 3：创建测试数据文件

The tests you need to write rely on local JSON files that
mimic the responses from the Wikipedia API.
You need to create a `test_data` directory and
populate it with three files.

你要编写的测试依赖本地 JSON 文件，
这些文件模拟 Wikipedia API 的响应。
你需要创建一个 `test_data` 目录，
并在其中放入三个文件。

1.  Navigate to the `wikipedia/test` directory.

    进入 `wikipedia/test` 目录。

1.  Create a new directory named `test_data`.

    创建一个名为 `test_data` 的新目录。

1.  Inside the `test_data` directory,
    create a new file named `dart_lang_summary.json` and
    paste the following content into it:

    在 `test_data` 目录中，
    创建名为 `dart_lang_summary.json` 的新文件，
    并把下面的内容粘贴进去：

    ```json
    {
      "type": "standard",
      "title": "Dart (programming language)",
      "displaytitle": "<span class=\"mw-page-title-main\">Dart (programming language)</span>",
      "namespace": {
          "id": 0,
          "text": ""
      },
      "wikibase_item": "Q406009",
      "titles": {
        "canonical": "Dart_(programming_language)",
        "normalized": "Dart (programming language)",
        "display": "<span class=\"mw-page-title-main\">Dart (programming language)</span>"
      },
      "pageid": 33033735,
      "lang": "en",
      "dir": "ltr",
      "revision": "1259309990",
      "tid": "671bc7c6-aa67-11ef-aa2a-7c1da4fbe8fb",
      "timestamp": "2024-11-24T13:24:16Z",
      "description": "Programming language",
      "description_source": "local",
      "content_urls": {
        "desktop": {
          "page": "https://en.wikipedia.org/wiki/Dart_(programming_language)",
          "revisions": "https://en.wikipedia.org/wiki/Dart_(programming_language)?action=history",
          "edit": "https://en.wikipedia.org/wiki/Dart_(programming_language)?action=edit",
          "talk": "https://en.wikipedia.org/wiki/Talk:Dart_(programming_language)"
        },
        "mobile": {
          "page": "https://en.m.wikipedia.org/wiki/Dart_(programming_language)",
          "revisions": "https://en.m.wikipedia.org/wiki/Special:History/Dart_(programming_language)",
          "edit": "https://en.m.wikipedia.org/wiki/Dart_(programming_language)?action=edit",
          "talk": "https://en.m.wikipedia.org/wiki/Talk:Dart_(programming_language)"
        }
      },
      "extract": "Dart is a programming language designed by Lars Bak and Kasper Lund and developed by Google. It can be used to develop web and mobile apps as well as server and desktop applications.",
      "extract_html": "<p><b>Dart</b> is a programming language designed by Lars Bak and Kasper Lund and developed by Google. It can be used to develop web and mobile apps as well as server and desktop applications.</p>"
    }
    ```

1.  Next, create a file named `cat_extract.json`.
    This file is very long, so copy the contents from this link:
    https://github.com/ericwindmill/dash_getting_started/blob/main/dart_step_by_step/step_10/wikipedia/test/test_data/cat_extract.json

    接下来，创建名为 `cat_extract.json` 的文件。
    这个文件很长，请从下面的链接复制内容：
    https://github.com/ericwindmill/dash_getting_started/blob/main/dart_step_by_step/step_10/wikipedia/test/test_data/cat_extract.json

1.  Next, create a file named `open_search_response.json` and
    paste this content into it:

    接下来，创建名为 `open_search_response.json` 的文件，
    并把下面的内容粘贴进去：

    ```json
    [
        "dart",
        [
            "Dart",
            "Darth Vader",
            "Dartmouth College",
            "Darts",
            "Darth Maul",
            "Dartford Crossing",
            "Dart (programming language)",
            "Dartmouth College fraternities and sororities",
            "Dartmoor",
            "Dartmouth, Massachusetts"
        ],
        [
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            ""
        ],
        [
            "https://en.wikipedia.org/wiki/Dart",
            "https://en.wikipedia.org/wiki/Darth_Vader",
            "https://en.wikipedia.org/wiki/Dartmouth_College",
            "https://en.wikipedia.org/wiki/Darts",
            "https://en.wikipedia.org/wiki/Darth_Maul",
            "https://en.wikipedia.org/wiki/Dartford_Crossing",
            "https://en.wikipedia.org/wiki/Dart_(programming_language)",
            "https://en.wikipedia.org/wiki/Dartmouth_College_fraternities_and_sororities",
            "https://en.wikipedia.org/wiki/Dartmoor",
            "https://en.wikipedia.org/wiki/Dartmouth,_Massachusetts"
        ]
    ]
    ```

With these files in place, you're ready to write the tests that
will verify your data models.

这些文件准备好之后，你就可以编写测试来验证数据模型了。

### Task 4: Write tests for JSON deserialization

### 任务 4：为 JSON 反序列化编写测试

Now, you'll write tests for the JSON deserialization logic in your data models.
You'll use the `group`, `test`, and `expect` functions from the `test` package.

现在，你将为数据模型中的 JSON 反序列化逻辑编写测试。
你将使用 `test` package 中的 `group`、`test` 和 `expect` 函数。

1.  Use the `group` function to group related tests together.
    Add the following to your `wikipedia/test/model_test.dart` file:

    使用 `group` 函数把相关测试分组。
    把下面的内容添加到 `wikipedia/test/model_test.dart`：

    ```dart
    void main() {
      group('deserialize example JSON responses from wikipedia API', () {
        // Tests will go here
      });
    }
    ```

    The `group` function takes a description of the group and a
    callback function that contains the tests.

    `group` 函数接收分组的描述，
    以及一个包含测试的回调函数。

1.  Create a test for the `Summary` model.
    Add the following `test` function inside the `group` function:

    为 `Summary` 模型创建一个测试。
    在 `group` 函数内部添加下面的 `test` 函数：

    ```dart
    void main() {
      group('deserialize example JSON responses from wikipedia API', () {
        test('deserialize Dart Programming Language page summary example data from '
            'json file into a Summary object', () async {
          final String pageSummaryInput =
              await File(dartLangSummaryJson).readAsString();
          final Map<String, Object?> pageSummaryMap =
              jsonDecode(pageSummaryInput) as Map<String, Object?>;
          final Summary summary = Summary.fromJson(pageSummaryMap);
          expect(summary.titles.canonical, 'Dart_(programming_language)');
        });
      });
    }
    ```

    This `test` function does the following:

    这个 `test` 函数会做以下事情：

    -   Reads the contents of the `dart_lang_summary.json` file.

        读取 `dart_lang_summary.json` 文件的内容。
    -   Decodes the JSON string into a `Map<String, Object?>`.

        把 JSON 字符串解码为 `Map<String, Object?>`。
    -   Creates a `Summary` object from the map using
        the `Summary.fromJson` constructor.

        使用 `Summary.fromJson` 构造函数，
        从映射创建 `Summary` 对象。
    -   Uses the `expect` function to assert that the
        `canonical` property of the `titles` object is
        equal to `'Dart_(programming_language)'`.

        使用 `expect` 函数断言
        `titles` 对象的 `canonical` 属性
        等于 `'Dart_(programming_language)'`。

    The `expect` function takes a value and a matcher.
    The matcher is used to assert that the value meets certain criteria.
    In this case, the `equals` matcher is used to
    assert that the value is equal to a specific string.

    `expect` 函数接收一个值和一个匹配器。
    匹配器用来断言该值是否满足某些条件。
    这里使用 `equals` 匹配器，
    断言该值等于一个特定字符串。

1.  Create a test for the `Article` model.
    Add the following `test` function inside
    the `group` function, after the previous test:

    为 `Article` 模型创建一个测试。
    在 `group` 函数内部、上一个测试之后，
    添加下面的 `test` 函数：

    ```dart
    void main() {
      group('deserialize example JSON responses from wikipedia API', () {
        test('deserialize Dart Programming Language page summary example data from '
            'json file into a Summary object', () async {
          final String pageSummaryInput =
              await File(dartLangSummaryJson).readAsString();
          final Map<String, Object?> pageSummaryMap =
              jsonDecode(pageSummaryInput) as Map<String, Object?>;
          final Summary summary = Summary.fromJson(pageSummaryMap);
          expect(summary.titles.canonical, 'Dart_(programming_language)');
        });

        test('deserialize Cat article example data from json file into '
            'an Article object', () async {
          final String articleJson = await File(catExtractJson).readAsString();
          final Map<String, Object?> articleMap =
              jsonDecode(articleJson) as Map<String, Object?>;
          final List<Article> articles = Article.listFromJson(articleMap);
          expect(articles.first.title.toLowerCase(), 'cat');
        });
      });
    }
    ```

    This `test` function does the following:

    这个 `test` 函数会做以下事情：

    -   Reads the contents of the `cat_extract.json` file.

        读取 `cat_extract.json` 文件的内容。
    -   Decodes the JSON string into a `Map<String, Object?>`.

        把 JSON 字符串解码为 `Map<String, Object?>`。
    -   Creates the `List<Article>` object from the map using
        the `Article.listFromJson` static method.

        使用 `Article.listFromJson` 静态方法，
        从映射创建 `List<Article>` 对象。
    -   Uses the `expect` function to assert that
        the `title` property of the first article is equal to `'cat'`.

        使用 `expect` 函数断言
        第一篇文章的 `title` 属性等于 `'cat'`。

1.  Create a test for the `SearchResults` model.
    Add the following `test` function inside the `group` function,
    after the previous test:

    为 `SearchResults` 模型创建一个测试。
    在 `group` 函数内部、上一个测试之后，
    添加下面的 `test` 函数：

    ```dart
    void main() {
      group('deserialize example JSON responses from wikipedia API', () {
        test('deserialize Dart Programming Language page summary example data from '
              'json file into a Summary object', () async {
          final String pageSummaryInput =
              await File(dartLangSummaryJson).readAsString();
          final Map<String, Object?> pageSummaryMap =
              jsonDecode(pageSummaryInput) as Map<String, Object?>;
          final Summary summary = Summary.fromJson(pageSummaryMap);
          expect(summary.titles.canonical, 'Dart_(programming_language)');
        });

        test('deserialize Cat article example data from json file into '
            'an Article object', () async {
          final String articleJson = await File(catExtractJson).readAsString();
          final Map<String, Object?> articleMap =
              jsonDecode(articleJson) as Map<String, Object?>;
          final List<Article> articles = Article.listFromJson(articleMap);
          expect(articles.first.title.toLowerCase(), 'cat');
        });

        test('deserialize Open Search results example data from json file '
            'into an SearchResults object', () async {
          final String resultsString =
              await File(openSearchResponse).readAsString();
          final List<Object?> resultsAsList =
              jsonDecode(resultsString) as List<Object?>;
          final SearchResults results = SearchResults.fromJson(resultsAsList);
          expect(results.results.length, greaterThan(1));
        });
      });
    }
    ```

    This `test` function does the following:

    这个 `test` 函数会做以下事情：

    -   Reads the contents of the `open_search_response.json` file.

        读取 `open_search_response.json` 文件的内容。
    -   Decodes the JSON string into a `List<Object?>`.

        把 JSON 字符串解码为 `List<Object?>`。
    -   Creates a `SearchResults` object from the list using
        the `SearchResults.fromJson` constructor.

        使用 `SearchResults.fromJson` 构造函数，
        从列表创建 `SearchResults` 对象。
    -   Uses the `expect` function to assert that
        the `results` list has a length greater than `1`.

        使用 `expect` 函数断言
        `results` 列表的长度大于 `1`。

### Task 5: Run the tests

### 任务 5：运行测试

Now that you've written the tests, you can run them to verify that they pass.

现在你已经写好了测试，可以运行它们，确认能够通过。

1.  Open your terminal and navigate to the `wikipedia` directory.

    打开终端，进入 `wikipedia` 目录。
1.  Run the command `dart test`.

    运行命令 `dart test`。

    You should see output similar to this:

    ```bash
    00:02 +4: All tests passed!
    ```

    This confirms that all three tests are passing.

    这确认三个测试都已通过。

## Review

## 回顾

<SummaryCard>
title: 你完成的内容
subtitle: 以下是你在本课中构建并学到的内容摘要。
completed: true
items:
  - title: 把 test package 添加为开发依赖
    icon: experiment
    details: >-
      你在 `pubspec.yaml` 中把 `test` 添加为开发依赖，
      并在 `test/` 目录中创建了测试文件。
      pub 的开发依赖用于开发和测试，而不是生产环境。
      因此，它们不能在 `lib` 目录中使用。
  - title: 用 test package 和匹配器编写了结构化测试
    icon: lab_panel
    details: >-
      你使用 `group()` 组织相关测试，
      用 `test()` 定义单个测试用例，
      并用 `expect()` 配合 `equals`、`greaterThan` 等匹配器断言预期行为。
      运行 `dart test` 会执行 package 声明的全部测试。
  - title: 测试了 JSON 反序列化逻辑
    icon: fact_check
    details: >-
      你创建了包含示例 JSON 的测试数据文件，
      并编写测试来验证 `fromJson` 方法能把数据正确解析为 Dart 对象。
      这能确保你的模型妥善处理真实的 API 响应。
</SummaryCard>

## Quiz

## 测验

<!-- title: Check your understanding -->
<Quiz title="检查你的理解" id="testing" />

## Next lesson

## 下一课

In the next lesson, you'll implement
the Wikipedia API calls in your `dartpedia` application.
You'll use the `http` package to
fetch data from the Wikipedia API and display it to the user.

在下一课中，你将在 `dartpedia` 应用里实现 Wikipedia API 调用。
你将使用 `http` package
从 Wikipedia API 获取数据，并展示给用户。
