---
# title: Fetch data from the internet
title: 从互联网获取数据
# shortTitle: HTTP requests
shortTitle: HTTP 请求
# description: >-
#   Refactor your application to use a robust, production-ready
#   API client for the Wikipedia CLI.
description: >-
  重构你的应用，为 Wikipedia CLI
  使用一套稳健、可用于生产环境的 API 客户端。
layout: learn
ai-translated: true
---

In Chapter 3, you used the `http` package to make a simple request.
Now, you'll revisit HTTP to
build a robust, production-ready API client within the `wikipedia` package.
You'll learn how to handle query parameters,
map JSON responses to your data models, and
export these functions for use in your CLI.

在第 3 章中，你使用 `http` package 发出了一个简单请求。
现在，你将再次处理 HTTP，
在 `wikipedia` package 中构建一套稳健、可用于生产环境的 API 客户端。
你将学习如何处理查询参数、
把 JSON 响应映射到数据模型，
并导出这些函数供 CLI 使用。

<SummaryCard>
title: 你将完成的内容
items:
  - title: 用查询参数构建复杂的 URI
    icon: link
  - title: 创建可用于生产环境的 HTTP API 客户端
    icon: cloud_download
  - title: 导出函数和类型以便复用
    icon: export_notes
</SummaryCard>

## Prerequisites

## 准备工作

Before you begin this chapter, ensure you:

开始本章之前，请确认你已经：

-   Have completed Chapter 10 and have a
    working Dart development environment with the `dartpedia` project.

    已完成第 10 章，并且有可用的 Dart 开发环境，
    项目为 `dartpedia`。
-   Understand basic networking concepts (like APIs and HTTP requests).

    理解基本的网络概念（例如 API 和 HTTP 请求）。
-   Understand basic data serialization formats such as JSON.

    理解 JSON 等基本的数据序列化格式。

## Tasks

## 任务

In this chapter, you'll move beyond simple scripts and
implement a proper API layer.
You'll work within the `wikipedia` package to
implement the API client logic, which
improves your application's scalability and maintainability.

在本章中，你将超越简单脚本，
实现一个真正的 API 层。
你将在 `wikipedia` package 中实现 API 客户端逻辑，
从而提升应用的可扩展性和可维护性。

### Task 1: Add the http dependency to the wikipedia package

### 任务 1：为 wikipedia package 添加 http 依赖

To make HTTP requests, you need to
add the `http` package as a dependency to the `wikipedia` package.

要发出 HTTP 请求，你需要把 `http` package
添加为 `wikipedia` package 的依赖。

1.  Open the `wikipedia/pubspec.yaml` file within your project.

    打开项目中的 `wikipedia/pubspec.yaml` 文件。

1.  Locate the `dependencies` section.

    找到 `dependencies` 部分。

1.  Add `http: ^1.3.0` (or the latest stable version) under `dependencies`.

    在 `dependencies` 下添加 `http: ^1.3.0`（或最新的稳定版本）。

    ```yaml
    dependencies:
      http: ^1.3.0
    ```

1.  Save the `pubspec.yaml` file.

    保存 `pubspec.yaml` 文件。

1.  Run `dart pub get` in your terminal from the `wikipedia` directory.

    在终端中从 `wikipedia` 目录运行 `dart pub get`。

### Task 2: Implement Wikipedia API calls

### 任务 2：实现 Wikipedia API 调用

Next, you'll create the API functions to fetch data from Wikipedia.
You'll create three files:

接下来，你将创建从 Wikipedia 获取数据的 API 函数。
你要创建三个文件：

- `summary.dart`:
  This file will contain functions for retrieving article summaries.

  这个文件包含获取文章摘要的函数。
- `search.dart`:
  This file will handle search queries to find articles.

  这个文件负责处理搜索查询，用来查找文章。
- `get_article.dart`:
  This file will contain functions for fetching the full content of an article.

  这个文件包含获取文章完整内容的函数。

1.  Create the directory `wikipedia/lib/src/api`.

    创建目录 `wikipedia/lib/src/api`。

1.  Create the file `wikipedia/lib/src/api/summary.dart`.

    创建文件 `wikipedia/lib/src/api/summary.dart`。

1.  Add the following code to `wikipedia/lib/src/api/summary.dart`:

    把下面的代码添加到 `wikipedia/lib/src/api/summary.dart`：

    ```dart
    import 'dart:convert';
    import 'dart:io';

    import 'package:http/http.dart' as http;

    import '../model/summary.dart';

    Future<Summary> getRandomArticleSummary() async {
      final http.Client client = http.Client();
      try {
        final Uri url = Uri.https(
          'en.wikipedia.org',
          '/api/rest_v1/page/random/summary',
        );
        final http.Response response = await client.get(url);
        if (response.statusCode == 200) {
          final Map<String, Object?> jsonData =
              jsonDecode(response.body) as Map<String, Object?>;
          return Summary.fromJson(jsonData);
        } else {
          throw HttpException(
            '[WikipediaApiClient.getRandomArticleSummary] '
            'statusCode=${response.statusCode}, body=${response.body}',
          );
        }
      } on FormatException {
        // todo: log exceptions
        rethrow;
      } finally {
        client.close();
      }
    }

    Future<Summary> getArticleSummaryByTitle(String articleTitle) async {
      final http.Client client = http.Client();
      try {
        final Uri url = Uri.https(
          'en.wikipedia.org',
          '/api/rest_v1/page/summary/$articleTitle',
        );
        final http.Response response = await client.get(url);
        if (response.statusCode == 200) {
          final Map<String, Object?> jsonData =
              jsonDecode(response.body) as Map<String, Object?>;
          return Summary.fromJson(jsonData);
        } else {
          throw HttpException(
            '[WikipediaApiClient.getArticleSummaryByTitle] '
            'statusCode=${response.statusCode}, body=${response.body}',
          );
        }
      } on FormatException {
        // todo: log exceptions
        rethrow;
      } finally {
        client.close();
      }
    }
    ```

    This code defines two functions:
    `getRandomArticleSummary` and `getArticleSummaryByTitle`.
    Both functions use the `http` package to
    make GET requests to the Wikipedia API and return a `Summary` object.
    `getRandomArticleSummary` fetches a summary for a random article, while
    `getArticleSummaryByTitle` fetches a summary for a specific article title.

    这段代码定义了两个函数：
    `getRandomArticleSummary` 和 `getArticleSummaryByTitle`。
    两个函数都使用 `http` package
    向 Wikipedia API 发出 GET 请求，并返回 `Summary` 对象。
    `getRandomArticleSummary` 获取一篇随机文章的摘要，
    `getArticleSummaryByTitle` 则获取指定标题文章的摘要。

1.  Next create the file `wikipedia/lib/src/api/search.dart`.

    接下来创建文件 `wikipedia/lib/src/api/search.dart`。

1.  Add the following code to `wikipedia/lib/src/api/search.dart`:

    把下面的代码添加到 `wikipedia/lib/src/api/search.dart`：

    ```dart

    import 'dart:convert';
    import 'dart:io';

    import 'package:http/http.dart' as http;

    import '../model/search_results.dart';

    Future<SearchResults> search(String searchTerm) async {
      final http.Client client = http.Client();
      try {
        final Uri url = Uri.https(
          'en.wikipedia.org',
          '/w/api.php',
          <String, Object?>{
            'action': 'opensearch',
            'format': 'json',
            'search': searchTerm,
          },
        );
        final http.Response response = await client.get(url);
        if (response.statusCode == 200) {
          final List<Object?> jsonData = jsonDecode(response.body) as List<Object?>;
          return SearchResults.fromJson(jsonData);
        } else {
          throw HttpException(
            '[WikipediaApiClient.search] '
            'statusCode=${response.statusCode}, '
            'body=${response.body}',
          );
        }
      } on FormatException {
        rethrow;
      } finally {
        client.close();
      }
    }
    ```

    This code defines the `search` function, which
    uses the `http` package to make a GET request to the Wikipedia API's
    `opensearch` endpoint and returns a `SearchResults` object.
    The `opensearch` endpoint is used to search for
    Wikipedia articles based on a search term.

    这段代码定义了 `search` 函数。
    它使用 `http` package 向 Wikipedia API 的
    `opensearch` 端点发出 GET 请求，并返回 `SearchResults` 对象。
    `opensearch` 端点用来根据搜索词查找 Wikipedia 文章。

1.  Create the file `wikipedia/lib/src/api/get_article.dart`.

    创建文件 `wikipedia/lib/src/api/get_article.dart`。

1.  Add the following code to `wikipedia/lib/src/api/get_article.dart`:

    把下面的代码添加到 `wikipedia/lib/src/api/get_article.dart`：

    ```dart
    import 'dart:convert';
    import 'dart:io';

    import 'package:http/http.dart' as http;

    import '../model/article.dart';

    Future<List<Article>> getArticleByTitle(String title) async {
      final http.Client client = http.Client();
      try {
        final Uri url = Uri.https(
          'en.wikipedia.org',
          '/w/api.php',
          <String, Object?>{
            // order matters - explaintext must come after prop
            'action': 'query',
            'format': 'json',
            'titles': title.trim(),
            'prop': 'extracts',
            'explaintext': '',
          },
        );
        final http.Response response = await client.get(url);
        if (response.statusCode == 200) {
          final Map<String, Object?> jsonData =
              jsonDecode(response.body) as Map<String, Object?>;
          return Article.listFromJson(jsonData);
        } else {
          throw HttpException(
            '[WikipediaApiClient.getArticleByTitle] '
            'statusCode=${response.statusCode}, '
            'body=${response.body}',
          );
        }
      } on FormatException {
        // TODO: log
        rethrow;
      } finally {
        client.close();
      }
    }
    ```

    This code defines the `getArticleByTitle` function, which
    uses the `http` package to make a GET request to the Wikipedia API and
    returns a `List<Article>` object.
    This function retrieves the content of a
    Wikipedia article based on its title.

    这段代码定义了 `getArticleByTitle` 函数。
    它使用 `http` package 向 Wikipedia API 发出 GET 请求，
    并返回 `List<Article>` 对象。
    这个函数根据标题获取 Wikipedia 文章的内容。

### Task 3: Export the API functions

### 任务 3：导出 API 函数

Now that you've created the API functions,
you need to export them from the `wikipedia` library so that
they can be used by the `cli` package.
You'll also export the existing models.

现在你已经创建了 API 函数，
需要从 `wikipedia` 库中导出它们，
这样 `cli` package 才能使用。
你也会导出现有的模型。

1.  Open the `wikipedia/lib/wikipedia.dart` file.

    打开 `wikipedia/lib/wikipedia.dart` 文件。

1.  Add the following `export` statements to the file:

    把下面的 `export` 语句添加到文件中：

    ```dart
    export 'src/api/get_article.dart';
    export 'src/api/search.dart';
    export 'src/api/summary.dart';
    export 'src/model/article.dart';
    export 'src/model/search_results.dart';
    export 'src/model/summary.dart';
    export 'src/model/title_set.dart';
    ```

    These `export` statements make the API functions and models available to
    other packages that depend on the `wikipedia` package.

    这些 `export` 语句让依赖 `wikipedia` package 的其他 package
    可以使用这些 API 函数和模型。


## Task 4: Verify with tests

## 任务 4：用测试验证

Now that you have implemented the API functions and
updated the package dependencies, it's good practice to
run the tests you created in the previous chapter.
This will confirm that your changes have not
broken the existing functionality of the `wikipedia` package.

现在你已经实现了 API 函数并更新了 package 依赖，
最好运行一下上一章编写的测试。
这样可以确认你的改动没有破坏
`wikipedia` package 的现有功能。

1.  Open your terminal and navigate to the `wikipedia/test` directory.

    打开终端，进入 `wikipedia/test` 目录。

1.  Remove the default test file by running the command `rm wikipedia_test.dart`
    (on macOS or Linux) or `del wikipedia_test.dart` (on Windows).
    This file was generated automatically but is not used in our project.

    运行 `rm wikipedia_test.dart`（macOS 或 Linux）
    或 `del wikipedia_test.dart`（Windows）来删除默认测试文件。
    这个文件是自动生成的，但本项目用不到。

1.  Open your terminal and navigate to the `wikipedia` directory.

    打开终端，进入 `wikipedia` 目录。

1.  Run the command `dart test`.

    运行命令 `dart test`。

    You should see output similar to this,
    confirming all your existing tests still pass:

    你应该会看到类似下面的输出，
    表示现有测试仍然全部通过：

    ```bash
    00:02 +3: All tests passed!
    This confirms that the wikipedia package is still working as expected.
    ```

## Review

## 回顾

<SummaryCard>
title: 你完成的内容
subtitle: 以下是你在本课中构建并学到的内容摘要。
completed: true
items:
  - title: 用查询参数构建了复杂的 URI
    icon: link
    details: >-
      你使用带查询参数映射的 `Uri.https()` 来构建 API URL。
      这种方式会正确编码特殊字符，
      并能处理复杂的查询参数组合。
  - title: 创建了可用于生产环境的 API 客户端
    icon: cloud_download
    details: >-
      你实现了多个函数，用 `try` 和 `finally` 妥善管理
      HTTP 客户端的生命周期，
      并把原始 JSON 响应映射为带类型的 Dart 对象。
  - title: 导出了函数和类型以便复用
    icon: export_notes
    details: >-
      你在 `wikipedia.dart` 中添加了 export 语句，
      同时暴露 API 函数和数据模型类型。
      这样就形成了一个公开库，
      `cli` package 可以直接导入并使用。
</SummaryCard>

## Quiz

## 测验

<!-- title: Check your understanding -->
<Quiz title="检查你的理解" id="fetch-data" />

## Next lesson

## 下一课

In the next lesson, you'll complete the CLI by
integrating the `wikipedia` package with the `cli` package.
You'll implement the command logic and display the results to the user.

在下一课中，你将把 `wikipedia` package 与 `cli` package 集成起来，
完成这个 CLI。
你将实现命令逻辑，并把结果展示给用户。
