---
# title: Work with JSON data
title: 处理 JSON 数据
# shortTitle: Data and JSON
shortTitle: 数据与 JSON
# description: >-
#   Learn about JSON deserialization in Dart, including how to
#   use `dart:convert`, `jsonDecode`, and pattern matching to
#   work with JSON data from the Wikipedia API.
description: >-
  了解 Dart 中的 JSON 反序列化，包括如何使用
  `dart:convert`、`jsonDecode` 和模式匹配，
  处理来自 Wikipedia API 的 JSON 数据。
layout: learn
ai-translated: true
---

In this chapter, you'll learn how to work with
[JSON (JavaScript Object Notation)][] data in Dart.
JSON is a common format for data exchange on the web, and
you'll often encounter it when working with APIs.
You'll learn how to convert JSON data into Dart objects,
making it easier to work with in your application.
You'll use the [`dart:convert` library][],
the `jsonDecode` function, and pattern matching.

在本章中，你将学习如何在 Dart 中处理
[JSON（JavaScript Object Notation）][JSON (JavaScript Object Notation)] 数据。
JSON 是网上常见的数据交换格式，
使用 API 时你会经常遇到它。
你将学习如何把 JSON 数据转换成 Dart 对象，
从而在应用里更容易处理。
你将使用 [`dart:convert` 库][`dart:convert` library]、
`jsonDecode` 函数和模式匹配。

<SummaryCard>
title: 你将完成的内容
items:
  - title: 为 JSON 数据创建数据模型类
    icon: data_object
  - title: 使用 dart:convert 处理 JSON 数据
    icon: convert_to_text
  - title: 用模式匹配从 JSON 对象中提取数据
    icon: bento
  - title: 搭建多 package 工作区
    icon: workspaces
</SummaryCard>

[JSON (JavaScript Object Notation)]:  https://en.wikipedia.org/wiki/JSON
[`dart:convert` library]: {{site.dart-api}}/dart-convert

## Prerequisites

## 准备工作

Before you begin this chapter, ensure you:

开始本章之前，请确认你已经：

- Have completed Chapter 8 and have a
  working Dart development environment with the `dartpedia` project.

  完成了第 8 章，并且有可用的 Dart 开发环境，
  项目为 `dartpedia`。
- Understand basic Dart syntax, including [classes][] and data types.

  理解基本的 Dart 语法，包括 [类][classes] 和数据类型。

[classes]: /language/classes

## Tasks

## 任务

In this chapter, you'll create Dart classes to
represent the JSON data returned by the Wikipedia API.
This will allow you to easily access and use the data in your application.

在本章中，你将创建 Dart 类，
用来表示 Wikipedia API 返回的 JSON 数据。
这样你就可以在应用里轻松访问和使用这些数据。

### Task 1: Create the Wikipedia package

### 任务 1：创建 Wikipedia package

First, create a new Dart package to house the data models.

首先，创建一个新的 Dart package 来存放数据模型。

1.  Navigate to the root directory of your project (`/dartpedia`).

    进入项目的根目录（`/dartpedia`）。
1.  Run the following command in your terminal:

    在终端中运行以下命令：

    ```bash
    dart create wikipedia
    ```

    This command creates a new directory named `wikipedia` with
    the basic structure of a Dart package.
    You should now see a new folder `wikipedia` in your project root,
    alongside `cli` and `command_runner`.

    这条命令会创建一个名为 `wikipedia` 的新目录，
    其中包含 Dart package 的基本结构。
    现在你应该能在项目根目录中看到新文件夹 `wikipedia`，
    它和 `cli`、`command_runner` 并列。

### Task 2: Configure a Dart workspace

### 任务 2：配置 Dart 工作区

Dart workspaces allow you to
manage multiple related packages within a single project,
simplifying dependency management and local development.
Now that you're adding your third package,
it's a good time to configure your project to use a Dart workspace.

Dart 工作区让你可以在一个项目里管理多个相关的 package，
简化依赖管理和本地开发。
现在你要添加第三个 package，
正适合把项目配置成使用 Dart 工作区。

1.  **Create the root `pubspec.yaml` file.**

    **创建根目录的 `pubspec.yaml` 文件。**

    Navigate to the root directory of your project (`/dartpedia`) and
    create a new file named `pubspec.yaml` with the following content:

    进入项目根目录（`/dartpedia`），
    创建名为 `pubspec.yaml` 的新文件，并写入以下内容：

    ```yaml
    name: _
    publish_to: none

    environment:
      sdk: ^3.8.1 # IMPORTANT: Adjust this to match your Dart SDK version or a compatible range
    workspace:
      - cli
      - command_runner
      - wikipedia
    ```

1.  **Add workspace resolution to sub-packages.**

    **为子 package 添加工作区解析。**

    For each of your sub-packages (`cli`, `command_runner`, and `wikipedia`),
    open their respective `pubspec.yaml` files and
    add `resolution: workspace` to `pubspec.yaml`.
    This tells Dart to resolve dependencies within the workspace.

    对每个子 package（`cli`、`command_runner` 和 `wikipedia`），
    打开各自的 `pubspec.yaml`，
    并添加 `resolution: workspace`。
    这会告诉 Dart 在工作区内解析依赖。

    -   For `cli/pubspec.yaml`:

        对于 `cli/pubspec.yaml`：

        ```yaml highlightLines=5
        # ... (existing content) ...
        name: cli
        description: A sample command-line application.
        version: 1.0.0
        resolution: workspace # Add this line
        # ... (existing content) ...
        ```

    -   For `command_runner/pubspec.yaml`:

        对于 `command_runner/pubspec.yaml`：

        ```yaml highlightLines=5
        # ... (existing content) ...
        name: command_runner
        description: A starting point for Dart libraries or applications.
        version: 1.0.0
        resolution: workspace # Add this line
        # ... (existing content) ...
        ```

    -   For `wikipedia/pubspec.yaml`:

        对于 `wikipedia/pubspec.yaml`：

        ```yaml highlightLines=5
        # ... (existing content) ...
        name: wikipedia
        description: A sample command-line application.
        version: 1.0.0
        resolution: workspace # Add this line
        # ... (existing content) ...
        ```

### Task 3: Create the Summary class

### 任务 3：创建 Summary 类

The Wikipedia API returns a JSON object containing a summary of an article.
Let's create a Dart class to represent this summary.

Wikipedia API 返回的 JSON 对象包含文章摘要。
接下来创建一个 Dart 类来表示这个摘要。

1.  Create the directory `wikipedia/lib/src/model`.

    创建目录 `wikipedia/lib/src/model`。

    ```bash
    mkdir -p wikipedia/lib/src/model
    ```

1.  Create the file `wikipedia/lib/src/model/summary.dart`.

    创建文件 `wikipedia/lib/src/model/summary.dart`。

1.  Add the following code to `wikipedia/lib/src/model/summary.dart`:

    把下面的代码添加到 `wikipedia/lib/src/model/summary.dart`：

    ```dart title="wikipedia/lib/src/model/summary.dart"
    import 'title_set.dart';

    class Summary {
      /// Returns a new [Summary] instance.
      Summary({
        required this.titles,
        required this.pageid,
        required this.extract,
        required this.extractHtml,
        required this.lang,
        required this.dir,
        this.url,
        this.description,
      });

      ///
      TitlesSet titles;

      /// The page ID
      int pageid;

      /// First several sentences of an article in plain text
      String extract;

      /// First several sentences of an article in simple HTML format
      String extractHtml;

      /// Url to the article on Wikipedia
      String? url;

      /// The page language code
      String lang;

      /// The page language direction code
      String dir;

      /// Wikidata description for the page
      String? description;

      /// Returns a new [Summary] instance
      static Summary fromJson(Map<String, Object?> json) {
        return switch (json) {
          {
            'titles': final Map<String, Object?> titles,
            'pageid': final int pageid,
            'extract': final String extract,
            'extract_html': final String extractHtml,
            'lang': final String lang,
            'dir': final String dir,
            'content_urls': {
              'desktop': {'page': final String url},
              'mobile': {'page': String _},
            },
            'description': final String description,
          } =>
            Summary(
              titles: TitlesSet.fromJson(titles),
              pageid: pageid,
              extract: extract,
              extractHtml: extractHtml,
              lang: lang,
              dir: dir,
              url: url,
              description: description,
            ),
          {
            'titles': final Map<String, Object?> titles,
            'pageid': final int pageid,
            'extract': final String extract,
            'extract_html': final String extractHtml,
            'lang': final String lang,
            'dir': final String dir,
            'content_urls': {
              'desktop': {'page': final String url},
              'mobile': {'page': String _},
            },
          } =>
            Summary(
              titles: TitlesSet.fromJson(titles),
              pageid: pageid,
              extract: extract,
              extractHtml: extractHtml,
              lang: lang,
              dir: dir,
              url: url,
            ),
          _ => throw FormatException('Could not deserialize Summary, json=$json'),
        };
      }

      @override
      String toString() =>
          'Summary['
          'titles=$titles, '
          'pageid=$pageid, '
          'extract=$extract, '
          'extractHtml=$extractHtml, '
          'lang=$lang, '
          'dir=$dir, '
          'description=$description'
          ']';
    }
    ```

    This code defines a `Summary` class with properties that
    correspond to the fields in the JSON response from the Wikipedia API.
    The `fromJson` method uses [pattern matching][] to
    extract the data from the JSON object and create a new `Summary` instance.
    The `toString` method provides a convenient way to
    print the contents of the `Summary` object.
    Note that the `TitlesSet` class is used in the `Summary` class,
    so you'll need to create that next.

    这段代码定义了 `Summary` 类，它的属性
    对应 Wikipedia API 的 JSON 响应字段。
    `fromJson` 方法使用 [模式匹配][pattern matching]
    从 JSON 对象中提取数据，并创建新的 `Summary` 实例。
    `toString` 方法提供了一种方便的方式，
    用来打印 `Summary` 对象的内容。
    注意 `Summary` 类使用了 `TitlesSet` 类，
    所以接下来你需要创建它。

[pattern matching]: /language/patterns

### Task 4: Create the TitleSet class

### 任务 4：创建 TitleSet 类

The `Summary` class uses a `TitlesSet` class to represent the title information.
Let's create that class now.

`Summary` 类使用 `TitlesSet` 类来表示标题信息。
现在来创建这个类。

1.  Create the file `wikipedia/lib/src/model/title_set.dart`.

    创建文件 `wikipedia/lib/src/model/title_set.dart`。

1.  Add the following code to `wikipedia/lib/src/model/title_set.dart`:

    把下面的代码添加到 `wikipedia/lib/src/model/title_set.dart`：

    ```dart title="wikipedia/lib/src/model/title_set.dart"
    class TitlesSet {
      /// Returns a new [TitlesSet] instance.
      TitlesSet({
        required this.canonical,
        required this.normalized,
        required this.display,
      });

      /// the DB key (non-prefixed), e.g. may have _ instead of spaces,
      /// best for making request URIs, still requires Percent-encoding
      String canonical;

      /// the normalized title (https://www.mediawiki.org/wiki/API:Query#Example_2:_Title_normalization),
      /// e.g. may have spaces instead of _
      String normalized;

      /// the title as it should be displayed to the user
      String display;

      /// Returns a new [TitlesSet] instance and imports its values from a JSON map
      static TitlesSet fromJson(Map<String, Object?> json) {
        if (json case {
          'canonical': final String canonical,
          'normalized': final String normalized,
          'display': final String display,
        }) {
          return TitlesSet(
            canonical: canonical,
            normalized: normalized,
            display: display,
          );
        }
        throw FormatException('Could not deserialize TitleSet, json=$json');
      }

      @override
      String toString() =>
          'TitlesSet['
          'canonical=$canonical, '
          'normalized=$normalized, '
          'display=$display'
          ']';
    }
    ```

    This code defines a `TitlesSet` class with properties that correspond to
    the title information in the JSON response from the Wikipedia API.
    The `fromJson` method uses pattern matching to
    extract the data from the JSON object and create a new `TitlesSet` instance.
    The `toString` method provides a convenient way to
    print the contents of the `TitlesSet` object.

    这段代码定义了 `TitlesSet` 类，它的属性对应
    Wikipedia API 的 JSON 响应中的标题信息。
    `fromJson` 方法使用模式匹配
    从 JSON 对象中提取数据，并创建新的 `TitlesSet` 实例。
    `toString` 方法提供了一种方便的方式，
    用来打印 `TitlesSet` 对象的内容。

### Task 5: Create the Article class

### 任务 5：创建 Article 类

The Wikipedia API also returns a list of articles in a search result.
Let's create a Dart class to represent an article.

Wikipedia API 还会在搜索结果中返回文章列表。
接下来创建一个 Dart 类来表示一篇文章。

1.  Create the file `wikipedia/lib/src/model/article.dart`.

    创建文件 `wikipedia/lib/src/model/article.dart`。

1.  Add the following code to `wikipedia/lib/src/model/article.dart`:

    把下面的代码添加到 `wikipedia/lib/src/model/article.dart`：

    ```dart title="wikipedia/lib/src/model/article.dart"
    class Article {
      Article({required this.title, required this.extract});

      final String title;
      final String extract;

      static List<Article> listFromJson(Map<String, Object?> json) {
        final List<Article> articles = <Article>[];
        if (json case {'query': {'pages': final Map<String, Object?> pages}}) {
          for (final MapEntry<String, Object?>(:Object? value) in pages.entries) {
            if (value case {
              'title': final String title,
              'extract': final String extract,
            }) {
              articles.add(Article(title: title, extract: extract));
            }
          }
          return articles;
        }
        throw FormatException('Could not deserialize Article, json=$json');
      }

      Map<String, Object?> toJson() => <String, Object?>{
        'title': title,
        'extract': extract,
      };

      @override
      String toString() {
        return 'Article{title: $title, extract: $extract}';
      }
    }
    ```

    This code defines an `Article` class with properties for
    the title and extract of an article.
    The `listFromJson` method uses pattern matching to
    extract the data from the JSON object and
    create a list of `Article` instances.
    The `toJson` method converts the `Article` object back into a JSON object.
    The `toString` method provides a convenient way to
    print the contents of the `Article` object.

    这段代码定义了 `Article` 类，
    它有文章标题和摘要这两个属性。
    `listFromJson` 方法使用模式匹配
    从 JSON 对象中提取数据，
    并创建 `Article` 实例列表。
    `toJson` 方法把 `Article` 对象转换回 JSON 对象。
    `toString` 方法提供了一种方便的方式，
    用来打印 `Article` 对象的内容。

### Task 6: Create the SearchResults class

### 任务 6：创建 SearchResults 类

Finally, let's create a class to represent the
search results from the Wikipedia API.

最后，创建一个类来表示 Wikipedia API 的搜索结果。

1.  Create the file `wikipedia/lib/src/model/search_results.dart`.

    创建文件 `wikipedia/lib/src/model/search_results.dart`。
1.  Add the following code to `wikipedia/lib/src/model/search_results.dart`:

    把下面的代码添加到 `wikipedia/lib/src/model/search_results.dart`：

    ```dart title="wikipedia/lib/src/model/search_results.dart"
    class SearchResult {
      SearchResult({required this.title, required this.url});
      final String title;
      final String url;
    }

    class SearchResults {
      SearchResults(this.results, {this.searchTerm});
      final List<SearchResult> results;
      final String? searchTerm;

      static SearchResults fromJson(List<Object?> json) {
        final List<SearchResult> results = <SearchResult>[];
        if (json case [
          String searchTerm,
          Iterable articleTitles,
          Iterable _,
          Iterable urls,
        ]) {
          final List titlesList = articleTitles.toList();
          final List urlList = urls.toList();
          for (int i = 0; i < articleTitles.length; i++) {
            results.add(SearchResult(title: titlesList[i], url: urlList[i]));
          }
          return SearchResults(results, searchTerm: searchTerm);
        }
        throw FormatException('Could not deserialize SearchResults, json=$json');
      }

      @override
      String toString() {
        final StringBuffer pretty = StringBuffer();
        for (final SearchResult result in results) {
          pretty.write('${result.url} \n');
        }
        return '\nSearchResults for $searchTerm: \n$pretty';
      }
    }
    ```

    This code defines a `SearchResults` class with a
    list of `SearchResult` objects and a search term.
    The `fromJson` method uses pattern matching to extract the data from
    the JSON object and create a new `SearchResults` instance.
    The `toString` method provides a convenient way to
    print the contents of the `SearchResults` object.

    这段代码定义了 `SearchResults` 类，
    它包含 `SearchResult` 对象列表和一个搜索词。
    `fromJson` 方法使用模式匹配从 JSON 对象中提取数据，
    并创建新的 `SearchResults` 实例。
    `toString` 方法提供了一种方便的方式，
    用来打印 `SearchResults` 对象的内容。

At this point, you've created data models to represent JSON structures.
There's nothing to test at this point.
You'll add that application logic in the upcoming sections,
which will enable you to test how data is deserialized from the Wikipedia API.

至此，你已经创建了表示 JSON 结构的数据模型。
目前还没有可以测试的内容。
你将在接下来的章节中添加应用逻辑，
这样就能测试数据是如何从 Wikipedia API 反序列化的。

## Review

## 回顾

<SummaryCard>
title: 你完成的内容
subtitle: 以下是你在本课中构建并学到的内容摘要。
completed: true
items:
  - title: 为 JSON 创建了数据模型类
    icon: data_object
    details: >-
      你构建了 `Summary`、`TitlesSet`、`Article` 和 `SearchResults` 类，
      用来表示 Wikipedia API 的响应。
      这些带类型的模型在处理 API 数据时提供编译期安全性，
      以及 IDE 支持。
  - title: 使用 dart:convert 处理了 JSON 数据
    icon: convert_to_text
    details: >-
      你导入了 `dart:convert` 库，并用 `jsonDecode()`
      把 JSON 字符串解析为 Dart 对象，包括 `Map` 和 `List`，
      然后就可以用代码来处理它们。
  - title: 用模式匹配从 JSON 对象中提取了数据
    icon: bento
    details: >-
      你用 Dart 的模式匹配实现了 `fromJson` 工厂方法，
      配合 `switch` 表达式和 `if case` 语句。
      这样你可以在一个易读的表达式里校验 JSON 结构，
      并从 JSON 对象中提取值。
  - title: 搭建了 pub 工作区
    icon: workspaces
    details: >-
      为了简化多 package 项目的依赖管理，
      你创建了一个新的 pub 工作区。
      具体做法是创建根目录的 `pubspec.yaml`，
      用 `workspace:` 部分列出各个 package，
      然后在每个子 package 中添加 `resolution: workspace`。
</SummaryCard>

## Quiz

## 测验

<!-- title: Check your understanding -->
<Quiz title="检查你的理解" id="data-and-json" />

## Next lesson

## 下一课

In the next lesson, you'll learn how to
test your Dart code using the `package:test` library.
You'll write tests to ensure that your
JSON deserialization logic is working correctly.

在下一课中，你将学习如何使用 `package:test` 库测试 Dart 代码。
你将编写测试，确保 JSON 反序列化逻辑工作正常。
