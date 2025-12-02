---
# title: Metadata
title: Metadata
# description: Metadata and annotations in Dart.
description: Metadata and annotations in Dart.
prevpage:
  url: /language/functions
  title: Functions
nextpage:
  url: /language/libraries
  title: Libraries & imports
---

Use metadata to provide additional static information about your code.
A metadata annotation begins with the character `@`, followed by either
a reference to a compile-time constant (such as `deprecated`) or
a call to a constant constructor.



使用元数据为代码提供额外的静态信息。
元数据注解以字符 `@` 开头，
后跟对编译时常量的引用（如 `deprecated`）
或对常量构造函数的调用。

Metadata can be attached to most Dart program constructs by
adding annotations before the construct's declaration or directive.



通过在声明或指令之前添加注解，
可以将元数据附加到大多数 Dart 程序结构上。

## Built-in annotations



## 内置注解

The following annotations are available to all Dart code:



以下注解可用于所有 Dart 代码：

[`@Deprecated`][]
: Marks a declaration as deprecated,
  indicating it should be migrated away from,
  with a message explaining the replacement and potential removal date.



[`@Deprecated`][]
: 将声明标记为已弃用，
  表示应该迁移到其他方案，
  并附带一条消息说明替代方案和可能的移除日期。

[`@deprecated`][]
: Marks a declaration as deprecated until an unspecified future release.
  Prefer using `@Deprecated` and [providing a deprecation message][].



[`@deprecated`][]
: 将声明标记为已弃用，直到未来某个未指定的版本。
  建议使用 `@Deprecated` 并[提供弃用消息][providing a deprecation message]。

[`@override`][]
: Marks an instance member as an override or implementation of
  a member with the same name from a parent class or interface.
  For examples of using `@override`, check out [Extend a class][].



[`@override`][]
: 将实例成员标记为对父类或接口中同名成员的重写或实现。
  有关使用 `@override` 的示例，请查看[扩展一个类][Extend a class]。

[`@pragma`][]
: Provides specific instructions or hints about a declaration to
  Dart tools, such as the compiler or analyzer.



[`@pragma`][]
: 向 Dart 工具（如编译器或分析器）提供
  关于声明的特定指令或提示。

Here's an example of using the `@Deprecated` annotation:



下面是使用 `@Deprecated` 注解的示例：

<?code-excerpt "misc/lib/language_tour/metadata/television.dart (deprecated)"?>
```dart highlightLines=3
class Television {
  /// Use [turnOn] to turn the power on instead.
  @Deprecated('Use turnOn instead')
  void activate() {
    turnOn();
  }

/// Turns the TV's power on.
  void turnOn() {
    // ···
  }
  // ···
}
```



[Dart 分析器][Dart analyzer]会在需要 `@override` 注解时
以及使用带有 `@deprecated` 或 `@Deprecated` 注解的成员时
提供诊断反馈。

The [Dart analyzer][] provides feedback as diagnostics if
the `@override` annotation is needed and when using
members annotated with `@deprecated` or `@Deprecated`.



## 分析器支持的注解

[`@Deprecated`]: {{site.dart-api}}/dart-core/Deprecated-class.html
[`@deprecated`]: {{site.dart-api}}/dart-core/deprecated-constant.html
[`@override`]: {{site.dart-api}}/dart-core/override-constant.html
[`@pragma`]: {{site.dart-api}}/dart-core/pragma-class.html
[providing a deprecation message]: /tools/linter-rules/provide_deprecation_message
[Extend a class]: /language/extend
[Dart analyzer]: /tools/analysis

## Analyzer-supported annotations



除了为[内置注解][built-in annotations]提供支持和分析外，
[Dart 分析器][Dart analyzer]还为来自 [`package:meta`][] 的
各种注解提供额外的支持和诊断。
该包提供的一些常用注解包括：

Beyond providing support and analysis for the [built-in annotations][],
the [Dart analyzer][] provides additional support and diagnostics for
a variety of annotations from [`package:meta`][].
Some commonly used annotations the package provides include:



[`@visibleForTesting`][]
: 将包的成员标记为仅为公开状态，
  以便可以从包的测试中访问该成员。
  分析器会在自动完成建议中隐藏该成员，
  并在其他包使用时发出警告。

[`@visibleForTesting`][]
: Marks a member of a package as only public so that
  the member can be accessed from the package's tests.
  The analyzer hides the member from autocompletion suggestions
  and warns if it's used from another package.



[`@awaitNotRequired`][]
: 将具有 `Future` 类型的变量或返回 `Future` 的函数
  标记为不需要调用者 await 该 `Future`。
  这会阻止分析器因 [`discarded_futures`][] 或 [`unawaited_futures`][] 规则
  而警告未 await `Future` 的调用者。

[`@awaitNotRequired`][]
: Marks variables that have a `Future` type or functions that return a `Future`
  as not requiring the caller to await the `Future`.
  This stops the analyzer from warning callers that don't await the `Future`
  due to the [`discarded_futures`][] or [`unawaited_futures`][] lints.



要了解更多关于这些注解和该包提供的其他注解、
它们的含义、它们启用的功能以及如何使用它们，
请查看 [`package:meta/meta.dart` API 文档][meta-api]。

To learn more about these and the other annotations the package provides,
what they indicate, what functionality they enable, and how to use them,
check out the [`package:meta/meta.dart` API docs][meta-api].



## 自定义注解

[built-in annotations]: #built-in-annotations
[Dart analyzer]: /tools/analysis
[`@visibleForTesting`]: {{site.pub-api}}/meta/latest/meta/visibleForTesting-constant.html
[`@awaitNotRequired`]: {{site.pub-api}}/meta/latest/meta/awaitNotRequired-constant.html
[`discarded_futures`]: /tools/linter-rules/discarded_futures
[`unawaited_futures`]: /tools/linter-rules/unawaited_futures
[meta-api]: {{site.pub-api}}/meta/latest/meta/meta-library.html

## Custom annotations



你可以定义自己的元数据注解。下面是一个定义接受两个参数的
`@Todo` 注解的示例：

You can define your own metadata annotations. Here's an example of
defining a `@Todo` annotation that takes two arguments:



下面是使用 `@Todo` 注解的示例：

<?code-excerpt "misc/lib/language_tour/metadata/todo.dart (definition)"?>
```dart
class Todo {
  final String who;
  final String what;

const Todo(this.who, this.what);
}
```



### 指定支持的目标 {:.no_toc}

And here's an example of using that `@Todo` annotation:



要指示应该使用你的注解标注的语言结构类型，
请使用 [`package:meta`][] 中的 [`@Target`][] 注解。

<?code-excerpt "misc/lib/language_tour/metadata/misc.dart (usage)"?>
```dart highlightLines=1
@Todo('Dash', 'Implement this function')
void doSomething() {
  print('Do something');
}
```

### Specifying supported targets {:.no_toc}



例如，如果你希望前面的 `@Todo` 注解
只能用于函数和方法，
你可以添加以下注解：

To indicate the type of language constructs that
should be annotated with your annotation,
use the [`@Target`][] annotation from [`package:meta`][].



使用此配置，如果 `Todo` 被用作顶层函数或方法以外的
任何声明的注解，分析器将发出警告。

For example, if you wanted the earlier `@Todo` annotation to
only be allowed on functions and methods,
you'd add the following annotation:

<?code-excerpt "misc/lib/language_tour/metadata/todo.dart (target-kinds)"?>
```dart highlightLines=3
import 'package:meta/meta_meta.dart';

@Target({TargetKind.function, TargetKind.method})
class Todo {
  // ···
}
```

With this configuration, the analyzer will warn if `Todo` is used as
an annotation on any declaration besides a top-level function or method.

[`@Target`]: {{site.pub-api}}/meta/latest/meta_meta/Target-class.html
[`package:meta`]: {{site.pub-pkg}}/meta
