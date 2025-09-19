---
title: 注释
description:  Dart 中不同类型的注释.
prevpage:
  url: /language/operators
  title: 操作符
nextpage:
  url: /language/built-in-types
  title: 基本数据类型
---

Dart supports single-line comments, multi-line comments, and
documentation comments.

Dart支持单行注释、多行注释和文档注释。


## Single-line comments

## 单行注释

A single-line comment begins with `//`. Everything between `//` and the
end of line is ignored by the Dart compiler.

单行注释以 `//` 开头。Dart 编译器会忽略 `//` 之后直到行末的所有内容。

<?code-excerpt "misc/lib/language_tour/comments.dart (single-line-comments)"?>
```dart
void main() {
  // TODO: refactor into an AbstractLlamaGreetingFactory?
  print('Welcome to my Llama farm!');
}
```

## Multi-line comments

## 多行注释

A multi-line comment begins with `/*` and ends with `*/`. Everything
between `/*` and `*/` is ignored by the Dart compiler (unless the
comment is a documentation comment; see the next section). Multi-line
comments can nest.

多行注释以 `/*` 开头，以 `*/` 结尾。
Dart 编译器会忽略 `/*` 和 `*/` 之间的所有内容
（除非该注释是文档注释；请参阅下一节）。
多行注释可以嵌套。

<?code-excerpt "misc/lib/language_tour/comments.dart (multi-line-comments)"?>
```dart
void main() {
  /*
   * This is a lot of work. Consider raising chickens.

  Llama larry = Llama();
  larry.feed();
  larry.exercise();
  larry.clean();
   */
}
```

## Documentation comments

## 文档注释

Documentation comments are multi-line or single-line comments that begin
with `///` or `/**`. Using `///` on consecutive lines has the same
effect as a multi-line doc comment.

文档注释是以 `///` 或 `/**` 开头的多行或单行注释。
连续多行使用 `///` 的注释效果与多行文档注释等效。

Inside a documentation comment, the analyzer ignores all text
unless it is enclosed in brackets. Using brackets, you can refer to
classes, methods, fields, top-level variables, functions, and
parameters. The names in brackets are resolved in the lexical scope of
the documented program element.

在文档注释中，分析器会处理被方括号括起来的文本内容。
通过使用方括号，你可以引用类、方法、字段、顶层变量、函数和参数。
方括号中的名称将根据注释对象的词法作用域 (Lexical Scope) 进行解析。

Here is an example of documentation comments with references to other
classes and arguments:

以下是一个包含对其他类和参数引用的文档注释示例：

<?code-excerpt "misc/lib/language_tour/comments.dart (doc-comments)"?>
```dart
/// A domesticated South American camelid (Lama glama).
///
/// Andean cultures have used llamas as meat and pack
/// animals since pre-Hispanic times.
///
/// Just like any other animal, llamas need to eat,
/// so don't forget to [feed] them some [Food].
class Llama {
  String? name;

  /// Feeds your llama [food].
  ///
  /// The typical llama eats one bale of hay per week.
  void feed(Food food) {
    // ...
  }

  /// Exercises your llama with an [activity] for
  /// [timeLimit] minutes.
  void exercise(Activity activity, int timeLimit) {
    // ...
  }
}
```

In the class's generated documentation, `[feed]` becomes a link
to the docs for the `feed` method,
and `[Food]` becomes a link to the docs for the `Food` class.

在生成的类文档中，
`[feed]` 会转换为指向 `feed` 方法文档的链接，
而 `[Food]` 则会转换为指向 `Food` 类文档的链接。

To parse Dart code and generate HTML documentation, you can use Dart's
documentation generation tool, [`dart doc`](/tools/dart-doc).
For an example of generated documentation, see the 
[Dart API documentation.]({{site.dart-api}}) 
For advice on how to structure your comments, see
[Effective Dart: Documentation.](/effective-dart/documentation)


要解析 Dart 代码并生成 HTML 文档，你可以使用 Dart 的文档生成工具  [`dart doc`](/tools/dart-doc)。有关生成文档的示例，请参阅 [Dart API documentation。]({{site.dart-api}}) 有关如何组织注释的建议，请参阅 [Effective Dart: Documentation。](/effective-dart/documentation)。
