---
# title: Metadata
title: 注解
# description: Metadata and annotations in Dart.
description: Dart 中的元数据与注解。
prevpage:
  url: /language/functions
  # title: Functions
  title: 函数方法
nextpage:
  url: /language/libraries
  # title: Libraries & imports
  title: 库与导入
ai-translated: true
---


Use metadata to provide additional static information about your code.
A metadata annotation begins with the character `@`, followed by either
a reference to a compile-time constant (such as `deprecated`) or
a call to a constant constructor.

用元数据为代码提供额外的静态信息。
元数据注解以字符 `@` 开头，后面要么是
一个编译时常量的引用（例如 `deprecated`），
要么是一次常量构造函数调用。

Metadata can be attached to most Dart program constructs by
adding annotations before the construct's declaration or directive.

把注解放在某个构造的声明或指令之前，
就可以把元数据附加到大多数 Dart 程序构造上。

## Built-in annotations

## 内置注解

The following annotations are available to all Dart code:

下面这些注解可以在所有 Dart 代码中使用：

[`@Deprecated`][]
: Marks a declaration as deprecated,
  indicating it should be migrated away from,
  with a message explaining the replacement and potential removal date.

  把声明标记为已弃用，
  表示应当迁离它，
  并用一条消息说明替代方案以及可能的移除日期。

  In addition to the general `@Deprecated` annotation, 
  you can use specific annotations to deprecate certain 
  usages of a declaration:

  除了通用的 `@Deprecated` 注解，
  你还可以用更具体的注解，
  弃用某个声明的特定用法：

  * [`@Deprecated.extend()`][]: Extending the class is deprecated.

    扩展该类的做法已弃用。

  * [`@Deprecated.implement()`][]: Implementing the class or 
    mixin is deprecated.

    实现该类或 mixin 的做法已弃用。

  * [`@Deprecated.subclass()`][]: Subclassing (extending or 
    implementing) the class or mixin is deprecated.

    对该类或 mixin 派生子类（扩展或实现）的做法已弃用。

  * [`@Deprecated.mixin()`][]: Mixing in the class is deprecated.

    将该类 mixin 进去的做法已弃用。

  * [`@Deprecated.instantiate()`][]: Instantiating the class is deprecated.

    实例化该类的做法已弃用。

  * [`@Deprecated.optional()`][]: Omitting an argument for 
    the parameter is deprecated.

    省略该参数的实参的做法已弃用。

  Here's an example of using the `@Deprecated` annotation:

  下面是使用 `@Deprecated` 注解的例子：

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

[`@deprecated`][]
: Marks a declaration as deprecated until an unspecified future release.
  Prefer using `@Deprecated` and [providing a deprecation message][].

  把声明标记为已弃用，直到某个未指明的未来版本。
  更推荐使用 `@Deprecated`，并 [提供弃用消息][providing a deprecation message]。

[`@override`][]
: Marks an instance member as an override or implementation of
  a member with the same name from a parent class or interface.
  For examples of using `@override`, check out [Extend a class][].

  把实例成员标记为对父类或接口中
  同名成员的重写或实现。
  `@override` 的用法示例，请参阅 [扩展类][Extend a class]。

[`@pragma`][]
: Provides specific instructions or hints about a declaration to
  Dart tools, such as the compiler or analyzer.

  向 Dart 工具（例如编译器或分析器）
  提供关于某个声明的具体指示或提示。

The [Dart analyzer][] provides feedback as diagnostics if
the `@override` annotation is needed and when using
members annotated with `@deprecated` or `@Deprecated`.

如果需要 `@override` 注解，
或者使用了标有 `@deprecated` 或 `@Deprecated` 的成员，
[Dart 分析器][Dart analyzer] 会以诊断信息给出反馈。

[`@Deprecated`]: {{site.dart-api}}/dart-core/Deprecated-class.html
[`@deprecated`]: {{site.dart-api}}/dart-core/deprecated-constant.html
[`@override`]: {{site.dart-api}}/dart-core/override-constant.html
[`@pragma`]: {{site.dart-api}}/dart-core/pragma-class.html
[providing a deprecation message]: /tools/linter-rules/provide_deprecation_message
[Extend a class]: /language/extend
[Dart analyzer]: /tools/analysis
[`@Deprecated.extend()`]: {{site.dart-api}}/dart-core/Deprecated/Deprecated.extend.html
[`@Deprecated.implement()`]: {{site.dart-api}}/dart-core/Deprecated/Deprecated.implement.html
[`@Deprecated.subclass()`]: {{site.dart-api}}/dart-core/Deprecated/Deprecated.subclass.html
[`@Deprecated.mixin()`]: {{site.dart-api}}/dart-core/Deprecated/Deprecated.mixin.html
[`@Deprecated.instantiate()`]: {{site.dart-api}}/dart-core/Deprecated/Deprecated.instantiate.html
[`@Deprecated.optional()`]: {{site.dart-api}}/dart-core/Deprecated/Deprecated.optional.html

## Analyzer-supported annotations

## 分析器支持的注解

Beyond providing support and analysis for the [built-in annotations][],
the [Dart analyzer][] provides additional support and diagnostics for
a variety of annotations from [`package:meta`][].
Some commonly used annotations the package provides include:

除了为 [内置注解][built-in annotations] 提供支持和分析，
[Dart 分析器][Dart analyzer] 还为 [`package:meta`][`package:meta`]
中的多种注解提供额外的支持和诊断。
这个 package 提供的一些常用注解包括：

[`@visibleForTesting`][]
: Marks a member of a package as only public so that
  the member can be accessed from the package's tests.
  The analyzer hides the member from autocompletion suggestions
  and warns if it's used from another package.

  把 package 的某个成员标成仅为测试而公开，
  这样 package 的测试就可以访问该成员。
  分析器会在自动补全建议中隐藏该成员，
  并在其他 package 使用它时发出警告。

[`@awaitNotRequired`][]
: Marks variables that have a `Future` type or functions that return a `Future`
  as not requiring the caller to await the `Future`.
  This stops the analyzer from warning callers that don't await the `Future`
  due to the [`discarded_futures`][] or [`unawaited_futures`][] lints.

  把类型为 `Future` 的变量，或返回 `Future` 的函数，
  标记为不要求调用方 await 这个 `Future`。
  这样，当调用方因为 [`discarded_futures`][`discarded_futures`]
  或 [`unawaited_futures`][`unawaited_futures`] 这两条 lint
  而没有 await 该 `Future` 时，分析器就不会发出警告。

To learn more about these and the other annotations the package provides,
what they indicate, what functionality they enable, and how to use them,
check out the [`package:meta/meta.dart` API docs][meta-api].

想进一步了解这些注解以及该 package 提供的其他注解、
它们表示什么、能启用什么功能，以及如何使用，
请参阅 [`package:meta/meta.dart` API 文档][meta-api]。

[built-in annotations]: #built-in-annotations
[Dart analyzer]: /tools/analysis
[`@visibleForTesting`]: {{site.pub-api}}/meta/latest/meta/visibleForTesting-constant.html
[`@awaitNotRequired`]: {{site.pub-api}}/meta/latest/meta/awaitNotRequired-constant.html
[`discarded_futures`]: /tools/linter-rules/discarded_futures
[`unawaited_futures`]: /tools/linter-rules/unawaited_futures
[meta-api]: {{site.pub-api}}/meta/latest/meta/meta-library.html

## Custom annotations

## 自定义注解

You can define your own metadata annotations. Here's an example of
defining a `@Todo` annotation that takes two arguments:

你可以定义自己的元数据注解。
下面的例子定义了一个接受两个参数的 `@Todo` 注解：

<?code-excerpt "misc/lib/language_tour/metadata/todo.dart (definition)"?>
```dart
class Todo {
  final String who;
  final String what;

  const Todo(this.who, this.what);
}
```

And here's an example of using that `@Todo` annotation:

下面是使用这个 `@Todo` 注解的例子：

<?code-excerpt "misc/lib/language_tour/metadata/misc.dart (usage)"?>
```dart highlightLines=1
@Todo('Dash', 'Implement this function')
void doSomething() {
  print('Do something');
}
```

### Specifying supported targets {:.no_toc}

### 指定支持的目标 {:.no_toc}

To indicate the type of language constructs that
should be annotated with your annotation,
use the [`@Target`][] annotation from [`package:meta`][].

要标明你的注解应该用在哪类语言构造上，
使用 [`package:meta`][`package:meta`] 中的 [`@Target`][`@Target`] 注解。

For example, if you wanted the earlier `@Todo` annotation to
only be allowed on functions and methods,
you'd add the following annotation:

例如，如果希望前面的 `@Todo` 注解
只能用在函数和方法上，
就加上下面这个注解：

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

这样配置之后，如果把 `Todo` 用在
顶层函数或方法以外的任何声明上，分析器都会发出警告。

[`@Target`]: {{site.pub-api}}/meta/latest/meta_meta/Target-class.html
[`package:meta`]: {{site.pub-pkg}}/meta
