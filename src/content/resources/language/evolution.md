---
# title: Dart language evolution
title: Dart 语言的演进
# shortTitle: Language evolution
shortTitle: 语言演进
# breadcrumb: Legacy
breadcrumb: 旧版
# description: Notable changes and additions to the Dart programming language.
description: Dart 编程语言中值得注意的变更和新增内容。
lastVerified: 2026-08-12
ai-translated: true
---

:::warning
**This page has been deprecated.**
See the [Changelog](/changelog) for changes to the language and SDK,
and [Language versioning](/language/versioning) for how versioning is used
with Dart and the SDK.

**本页已弃用。**
语言和 SDK 的变更请看 [变更日志](/changelog)，
版本号如何用于 Dart 和 SDK 请看 [语言版本](/language/versioning)。
:::

This page lists notable changes and additions to the
Dart programming language.

本页列出 Dart 编程语言中值得注意的变更和新增内容。

* To learn specific details about the most recent supported language version,
  check out the [language documentation][] or the [language specification][].

  想了解当前受支持的最新语言版本的具体细节，
  请查阅 [语言文档][language documentation] 或 [语言规范][language specification]。

* For a full history of changes to the Dart SDK, see the [SDK changelog][].

  Dart SDK 变更的完整历史见 [SDK 变更日志][SDK changelog]。

* For a full history of breaking changes,
  including [language versioned][] changes,
  check out the [Breaking changes][] page.

  破坏性改动的完整历史，
  包括 [按语言版本区分][language versioned] 的变更，
  请查阅 [破坏性改动][Breaking changes] 页面。

To use a language feature introduced after 2.0,
set an [SDK constraint][] no lower than
the release when Dart first supported that feature.

要使用 2.0 之后引入的语言特性，
请把 [SDK 约束][SDK constraint] 的下界
设为不低于 Dart 首次支持该特性的版本。

**For example:** To use null safety, introduced in [2.12][],
set `2.12.0` as the lower constraint in the `pubspec.yaml` file.

**例如：** 要使用在 [2.12][] 引入的空安全，
请在 `pubspec.yaml` 文件中把下界约束设为 `2.12.0`。

```yaml
environment:
  sdk: '>=2.12.0 <3.0.0'
```

[2.12]: #dart-2-12
[SDK constraint]: /tools/pub/pubspec#sdk-constraints
[language versioned]: /language/versioning
[Breaking changes]: /resources/breaking-changes

:::tip
To review the features being discussed, investigated, and
added to the Dart language,
check out the [language funnel][] tracker
on the Dart language GitHub repo.

要查看正在讨论、调研并加入 Dart 语言的特性，
请查阅 Dart 语言 GitHub 仓库上的
[语言漏斗][language funnel] 跟踪表。
:::


## Changes in each release

## 各版本的变更

### Dart 3.13

### Dart 3.13 版本

_Released 12 August 2026_

**发布于 2026 年 8 月 12 日**

| [Dart 3.13 announcement](/blog/announcing-dart-3-13)

| [Dart 3.13 发布公告](/blog/announcing-dart-3-13)

Dart 3.13 introduces [primary constructors][],
a concise syntax for declaring a constructor and
its instance variables directly in the declaration header:

Dart 3.13 引入了 [主构造函数][primary constructors]，
这是一种简洁语法，可以直接在声明头里
声明构造函数及其实例变量：

<?code-excerpt "language/lib/primary_constructors/primary_constructors.dart (empty-bodies)" replace="/EmptyBodyPoint/Point/g"?>
```dart
class Point(var int x, var int y);
```

Primary constructors reduce the boilerplate of declaring fields,
passing parameters, and assigning them in a constructor body.
They change how you write a declaration, not how it behaves at runtime.

主构造函数减少了声明字段、传递参数
以及在构造函数体中赋值的样板代码。
它们改变的是声明的写法，而不是运行时行为。

Dart 3.13 also adds a [concise constructor syntax][]
for constructors declared in the class body:
you can write `new` or `factory` instead of repeating the class name.

Dart 3.13 还为在类体中声明的构造函数
增加了 [简洁构造函数语法][concise constructor syntax]：
你可以写 `new` 或 `factory`，而不必重复类名。

The release also includes the following language-versioned changes to
the output of [`dart format`][]:

该版本还包含下面这些按语言版本区分的变更，
影响 [`dart format`][] 的输出：

* Adds trailing commas to split extension type representation clauses.

  为拆开的扩展类型表示子句添加尾随逗号。

* Improves eager splitting to avoid suboptimal line splits.

  改进主动换行，避免不理想的折行。

* Prefers splitting call chains with single-element targets.

  优先拆分目标只有一个元素的调用链。

* Allows parameter lists to use block formatting.

  允许参数列表使用块格式。

* Allows `as`, `is`, and `is!` expressions to use block formatting.

  允许 `as`、`is` 和 `is!` 表达式使用块格式。

* Separates imports into distinct sections.

  把导入语句分成不同的部分。

* Splits an `if-case` guard when its pattern uses block formatting.

  当 `if-case` 的模式使用块格式时，拆开它的守卫。

* When no formatting solution fits the page width,
  prefers overflowing lines that end in string literals or comments.

  当没有格式化方案能放进页宽时，
  优先让以字符串字面量或注释结尾的行溢出。

* Adds blank lines around `mixin` and `extension type` declarations
  that don't have a `;` body.

  在没有 `;` 体的 `mixin` 和 `extension type` 声明周围添加空行。

For more information about these and additional changes,
see the [Dart 3.13 changelog][].

关于这些以及其他变更的更多信息，
请看 [Dart 3.13 变更日志][Dart 3.13 changelog]。

[primary constructors]: /language/primary-constructors
[concise constructor syntax]: /language/constructors#concise-constructor-syntax
[`dart format`]: /tools/dart-format
[Dart 3.13 changelog]: {{site.repo.dart.sdk}}/blob/main/CHANGELOG.md#3130

### Dart 3.12

### Dart 3.12 版本

_Released 18 May 2026_

**发布于 2026 年 5 月 18 日**

| [Dart 3.12 announcement](/blog/announcing-dart-3-12)

| [Dart 3.12 发布公告](/blog/announcing-dart-3-12)

Dart 3.12 introduces [private named parameters][], which let you
initialize private fields directly through [initializing formal parameters][].
Previously, initializing a private field through a named parameter
required manual assignment in the constructor's initializer list.

Dart 3.12 引入了 [私有命名参数][private named parameters]，
让你可以通过 [初始化形式参数][initializing formal parameters]
直接初始化私有字段。
以前，要通过命名参数初始化私有字段，
必须在构造函数的初始化列表里手动赋值。

Now, when an initializing formal parameter refers to a private field,
Dart strips the leading underscore (`_`) to derive the parameter's public name,
so callers use the unprefixed name at the call site:

现在，当初始化形式参数指向私有字段时，
Dart 会去掉前导下划线（`_`）来得到参数的公开名称，
因此调用方在调用处使用不带前缀的名称：

```dart
class Point {
  final int _x;
  final int _y;

  Point({required this._x, required this._y});
}

void main() {
  // Callers use the public, unprefixed names of the parameters.
  final point = Point(x: 1, y: 2);
}
```

[initializing formal parameters]: /language/constructors#use-initializing-formal-parameters
[private named parameters]: /language/constructors#private-named-parameters

### Dart 3.11

### Dart 3.11 版本

_Released 9 February 2026_

**发布于 2026 年 2 月 9 日**

| [Dart 3.11 announcement](/blog/announcing-dart-3-11)

| [Dart 3.11 发布公告](/blog/announcing-dart-3-11)

While Dart 3.11 introduces no new language features,
the release includes several improvements to
analyzer and editor support for the
[dot shorthand][] syntax introduced in Dart 3.10.

虽然 Dart 3.11 没有引入新的语言特性，
但该版本改进了分析器和编辑器对
Dart 3.10 引入的 [点号简写][dot shorthand] 语法的支持。

[dot shorthand]: /language/dot-shorthands

### Dart 3.10

### Dart 3.10 版本

_Released 12 November 2025_

**发布于 2025 年 11 月 12 日**

| [Dart 3.10 announcement](/blog/announcing-dart-3-10)

| [Dart 3.10 发布公告](/blog/announcing-dart-3-10)

Dart 3.10 introduces [dot shorthands][], a concise syntax 
that lets you omit explicit type names when accessing enum values,
static members, or constructors. If the compiler can infer 
the type from context, you can now simply use `.foo` 
instead of the full `ContextType.foo`.

Dart 3.10 引入了 [点号简写][dot shorthands]，
这是一种简洁语法，访问枚举值、静态成员或构造函数时
可以省略显式类型名。如果编译器能从上下文推断类型，
你现在可以直接使用 `.foo`，而不必写完整的 `ContextType.foo`。

<?code-excerpt "language/lib/shorthands/intro.dart"?>
```dart
// Use dot shorthand syntax on enums:
enum Status { none, running, stopped, paused }

Status currentStatus = .running; // Instead of Status.running

// Use dot shorthand syntax on a static method:
int port = .parse('8080'); // Instead of int.parse('8080')

// Uses dot shorthand syntax on a constructor:
class Point {
  final int x, y;
  Point(this.x, this.y);
  Point.origin() : x = 0, y = 0;
}

Point origin = .origin(); // Instead of Point.origin()
```

[dot shorthands]: /language/dot-shorthands

### Dart 3.9

### Dart 3.9 版本

_Released 13 August 2025_

**发布于 2025 年 8 月 13 日**

| [Dart 3.9 announcement](/blog/announcing-dart-3-9)

| [Dart 3.9 发布公告](/blog/announcing-dart-3-9)


The following supporting features have been updated for
Dart 3.9:

Dart 3.9 更新了下面这些配套特性：

*   Null safety: Dart now assumes null safety when
    computing type promotion, reachability, and definite assignment.
    As a result of this change, more `dead_code` warnings
    might be produced.

    空安全：Dart 现在在计算类型提升、可达性和明确赋值时
    假定启用了空安全。
    因此，可能会产生更多 `dead_code` 警告。


*   Flutter upper version bound is now respected: Starting from
    language version 3.9, the [flutter SDK constraint][] upper bound
    is now respected in your root package.

    Flutter 的版本上界现在会生效：从语言版本 3.9 起，
    根 package 会遵守 [Flutter SDK 约束][flutter SDK constraint] 的上界。

    For example, a `pubspec.yaml` file with the following constraints:

    例如，`pubspec.yaml` 文件有下面这些约束：

    ```yaml
    name: my_app
    environment:
      sdk: ^3.9.0
      flutter: 3.33.0
    ```

    Results in `dart pub get` failing if invoked with a version of
    the Flutter SDK different from `3.33.0`.
    The upper bound of the `flutter` constraint is
    still ignored in packages used as dependencies.
    For more background on this change, see [flutter/flutter#95472][].

    如果用不是 `3.33.0` 的 Flutter SDK 版本调用，
    `dart pub get` 会失败。
    作为依赖使用的 package 中，
    `flutter` 约束的上界仍然会被忽略。
    这项变更的更多背景见 [flutter/flutter#95472][]。

For more information about these and additional changes, see
the [Dart 3.9 changelog][].

关于这些以及其他变更的更多信息，
请看 [Dart 3.9 变更日志][Dart 3.9 changelog]。

[Dart 3.9 changelog]: {{site.repo.dart.sdk}}/blob/main/CHANGELOG.md#390
[flutter SDK constraint]: /tools/pub/pubspec#flutter-sdk-constraints
[flutter/flutter#95472]: https://github.com/flutter/flutter/issues/95472

### Dart 3.8

### Dart 3.8 版本

_Released 20 May 2025_

**发布于 2025 年 5 月 20 日**

| [Dart 3.8 announcement](/blog/announcing-dart-3-8)

| [Dart 3.8 发布公告](/blog/announcing-dart-3-8)

The following language features have been added to Dart 3.8:

Dart 3.8 增加了下面这些语言特性：

*   [Null-aware elements][]: A null-aware element evaluates
    an expression in a collection literal and if the result
    is not `null`, inserts the value into the surrounding
    collection.

    [空感知元素][Null-aware elements]：空感知元素会计算
    集合字面量中的表达式，如果结果不是 `null`，
    就把该值插入周围的集合。

The following supporting features have been updated:

下面这些配套特性已更新：

*   [Dart format][]: Dart 3.8's formatter builds on the
    previous release's rewrite, incorporating feedback,
    bug fixes, and further enhancements. It now
    intelligently automates trailing comma placement,
    deciding whether to split constructs rather than forcing
    them. The update also includes style changes to tighten
    and improve code output.
    
    [Dart format][]：Dart 3.8 的格式化工具在上一版重写的基础上，
    吸收了反馈、错误修复和进一步的改进。
    它现在会智能地自动放置尾随逗号，
    自行决定是否拆开结构，而不是强制拆开。
    这次更新还包括收紧并改进代码输出的风格变化。

For more information about these and additional changes, see
the [Dart 3.8 changelog][].

关于这些以及其他变更的更多信息，
请看 [Dart 3.8 变更日志][Dart 3.8 changelog]。

[Null-aware elements]: /language/collections#null-aware-element
[Dart format]: {{site.repo.dart.sdk}}/blob/main/CHANGELOG.md#380
[Dart 3.8 changelog]: {{site.repo.dart.sdk}}/blob/main/CHANGELOG.md#380

### Dart 3.7

### Dart 3.7 版本

_Released 12 February 2025_

**发布于 2025 年 2 月 12 日**

| [Dart 3.7 announcement](/blog/announcing-dart-3-7)

| [Dart 3.7 发布公告](/blog/announcing-dart-3-7)

Dart 3.7 added support for [wildcard variables][] to the language.
A wildcard variable is a local variable or parameter named `_`.
Wildcard variables are non-binding,
so they can be declared multiple times without collisions.
For example:

Dart 3.7 为语言增加了 [通配符变量][wildcard variables] 支持。
通配符变量是名为 `_` 的局部变量或参数。
通配符变量不绑定，
因此可以多次声明而不会冲突。
例如：

```dart
Foo(_, this._, super._, void _()) {}
```

The `dart format` command is also now tied to the language version as of 3.7.
If the language version of an input file is 3.7 or later, the code is formatted
with the new tall style. 

从 3.7 起，`dart format` 命令也与语言版本绑定。
如果输入文件的语言版本是 3.7 或更高，
代码会用新的纵向风格格式化。

The new style looks similar to the style you get when you add trailing commas
to argument lists, except that now the formatter will add and remove those
commas for you. When an argument or parameter lists splits, it is formatted
like so:

新风格看起来类似于你在参数列表中加上尾随逗号后的风格，
只不过现在格式化工具会替你添加和删除这些逗号。
当参数或形式参数列表被拆开时，格式如下：

```dart
longFunction(
  longArgument,
  anotherLongArgument,
);
```

You can find more details in the [changelog][dart-format].

更多细节见 [变更日志][dart-format]。

[wildcard variables]: /language/variables#wildcard-variables
[dart-format]: {{site.repo.dart.sdk}}/blob/main/CHANGELOG.md#dart-format

### Dart 3.6

### Dart 3.6 版本

_Released 11 December 2024_

**发布于 2024 年 12 月 11 日**

| [Dart 3.6 announcement](/blog/announcing-dart-3-6)

| [Dart 3.6 发布公告](/blog/announcing-dart-3-6)

Dart 3.6 added support for [digit separator][] underscores (`_`) to the language.
Digit separators improve readability of long number literals.

Dart 3.6 为语言增加了 [数字分隔符][digit separator] 下划线（`_`）支持。
数字分隔符提高了长数字字面量的可读性。

```dart
var m = 1__000_000__000_000__000_000;
```

[digit separator]: /language/built-in-types#digit-separators

### Dart 3.5

### Dart 3.5 版本

_Released 6 August 2024_

**发布于 2024 年 8 月 6 日**

| [Dart 3.5 announcement](/blog/announcing-dart-3-5-and-an-update-on-the-dart-roadmap)

| [Dart 3.5 发布公告](/blog/announcing-dart-3-5-and-an-update-on-the-dart-roadmap)

Dart 3.5 added no new language features, but made minor changes to the
context considered during type inference.
These include the following, non-language versioned changes:

Dart 3.5 没有增加新的语言特性，但对类型推断时
考虑的上下文做了小改动。
其中包括下面这些不按语言版本区分的变更：

* When the context for an `await` expression is `dynamic`,
  the context for the operand of expression is now `FutureOr<_>`.

  当 `await` 表达式的上下文是 `dynamic` 时，
  该表达式操作数的上下文现在是 `FutureOr<_>`。

* When the context for an entire if-null expression (`e1 ?? e2`) is `dynamic`,
  the context for `e2` is now the static type of `e1`.

  当整个 if-null 表达式（`e1 ?? e2`）的上下文是 `dynamic` 时，
  `e2` 的上下文现在是 `e1` 的静态类型。

### Dart 3.4

### Dart 3.4 版本

_Released 14 May 2024_

**发布于 2024 年 5 月 14 日**

| [Dart 3.4 announcement](/blog/announcing-dart-3-4)

| [Dart 3.4 发布公告](/blog/announcing-dart-3-4)

Dart 3.4 made several improvements related to type analysis. These include:

Dart 3.4 对类型分析做了若干改进。其中包括：

* Improvements to the type analysis of conditional expressions,
  if-null expressions and assignments, and switch expressions.

  改进了条件表达式、if-null 表达式与赋值，
  以及 switch 表达式的类型分析。

* Aligning the pattern context type schema for cast patterns with the spec.

  使 cast 模式的上下文类型纲要与规范一致。

* Making the type schema for the null-aware spread operator (`...?`)
  nullable for maps and set literals, to match the behavior of list literals.

  让空感知展开运算符（`...?`）在映射和集合字面量中的类型模式可空，
  以匹配列表字面量的行为。

### Dart 3.3

### Dart 3.3 版本

_Released 15 February 2024_

**发布于 2024 年 2 月 15 日**

| [Dart 3.3 announcement](/blog/new-in-dart-3-3-extension-types-javascript-interop-and-more)

| [Dart 3.3 发布公告](/blog/new-in-dart-3-3-extension-types-javascript-interop-and-more)

Dart 3.3 added some enhancements to the language:

Dart 3.3 为语言增加了一些增强：

* [Extension types][] are a new feature in Dart that allow zero-cost wrapping
  of an existing type. They are similar to wrapper classes and extension methods,
  but with implementation differences and different tradeoffs.

  [扩展类型][Extension types] 是 Dart 的新特性，
  可以零成本地包装现有类型。它们类似于包装类和扩展方法，
  但实现不同，取舍也不同。

  ```dart
  extension type Meters(int value) {
    String get label => '${value}m';
    Meters operator +(Meters other) => Meters(value + other.value);
  }

  void main() {
    var m = Meters(42); // Has type `Meters`.
    var m2 = m + m; // OK, type `Meters`.
    // int i = m; // Compile-time error, wrong type.
    // m.isEven; // Compile-time error, no such member.
    assert(identical(m, m.value)); // Succeeds.
  }
  ```

* Abstract getters are now promotable under the rules of
  [private final field promotion][], if there are no conflicting declarations.

  如果没有冲突的声明，抽象 getter 现在可以按
  [私有 final 字段提升][private final field promotion] 的规则被提升。

### Dart 3.2

### Dart 3.2 版本

_Released 15 November 2023_

**发布于 2023 年 11 月 15 日**

| [Dart 3.2 announcement](/blog/announcing-dart-3-2)

| [Dart 3.2 发布公告](/blog/announcing-dart-3-2)

Dart 3.2 added enhancements to flow analysis, including:

Dart 3.2 增强了流分析，其中包括：

* Expanded [type promotion](/null-safety/understanding-null-safety#type-promotion-on-null-checks)
  to work on private final fields. Previously only available for
  local variables and parameters, now private final fields can promote to
  non-nullable types through null checks and `is` tests. For example,
  the following code is now sound:

  把 [类型提升](/null-safety/understanding-null-safety#type-promotion-on-null-checks)
  扩展到私有 final 字段。以前只适用于局部变量和参数，
  现在私有 final 字段可以通过空检查和 `is` 测试
  提升为非可空类型。例如，下面的代码现在是健全的：

  ```dart
  class Example {
    final int? _privateField;
  
    Example(this._privateField);
  
    void f() {
      if (_privateField != null) {
        // _privateField has now been promoted; you can use it without
        // null checking it.
        int i = _privateField; // OK
      }
    }
  }
  
  // Private field promotions also work from outside of the class:
  void f(Example x) {
    if (x._privateField != null) {
      int i = x._privateField; // OK
    }
  }
  ```
  
  For more information on when private final fields can and can't promote, check
  out [Fixing type promotion failures](/tools/non-promotion-reasons).

  关于私有 final 字段何时能提升、何时不能，
  请查阅 [修复类型提升失败](/tools/non-promotion-reasons)。

* Corrected inconsistencies in type promotion behavior of
  [if-case](/language/branches#if-case) statements
  where the value being matched against throws an exception.

  修正了 [if-case](/language/branches#if-case) 语句在
  被匹配的值抛出异常时，类型提升行为的不一致。


### Dart 3.1

### Dart 3.1 版本

_Released 16 August 2023_

**发布于 2023 年 8 月 16 日**

| [Dart 3.1 announcement](/blog/dart-3-1-a-retrospective-on-functional-style-programming-in-dart-3)

| [Dart 3.1 发布公告](/blog/dart-3-1-a-retrospective-on-functional-style-programming-in-dart-3)

Dart 3.1 added no new features and made no changes to the language.

Dart 3.1 没有增加新特性，也没有对语言做改动。

### Dart 3.0

### Dart 3.0 版本

_Released 10 May 2023_

**发布于 2023 年 5 月 10 日**

| [Dart 3.0 announcement](/blog/announcing-dart-3)

| [Dart 3.0 发布公告](/blog/announcing-dart-3)

Dart 3.0 introduced several new major language features:

Dart 3.0 引入了几项新的主要语言特性：

* [Patterns][], a new category of grammar that lets you
  match and destructure values.

  [模式][Patterns]，一种新的语法类别，
  让你匹配并解构值。

* [Records][], a new type that lets you aggregate
  multiple values of different types in a single function return.

  [记录类型][Records]，一种新类型，
  让你在一次函数返回中汇集多个不同类型的值。

* [Class modifiers][], a new set of keywords that let you
  control how a class or mixin can be used.

  [类修饰符][Class modifiers]，一组新关键字，
  让你控制类或 mixin 可以如何使用。

* [Switch expressions][], a new form of multi-way branching
  allowed where expressions are expected.

  [Switch 表达式][Switch expressions]，一种新的多路分支形式，
  可以用在需要表达式的地方。

* [If-case clauses][], a new conditional construct that matches a value
  against a pattern and executes the then or else branch, depending
  on whether the pattern matches.

  [If-case 子句][If-case clauses]，一种新的条件结构，
  把值与模式匹配，并根据模式是否匹配
  执行 then 或 else 分支。

Dart 3.0 also introduced a few breaking language changes:

Dart 3.0 还引入了几项破坏性的语言变更：

* Class declarations without the [`mixin`][] class modifier
  can no longer be applied as mixins.

  没有 [`mixin`][] 类修饰符的类声明
  不能再当作 mixin 使用。

* It is now a compile time error if a colon (`:`) is used as the separator
  before the default value of an optional named parameter.
  Use an equal sign (`=`) instead.

  如果用冒号（`:`）作为可选命名参数默认值前面的分隔符，
  现在是编译时错误。
  请改用等号（`=`）。

* It is now a compile-time error if a `continue` statement targets a
  label that is not attached to a
  loop statement (`for`, `do`, and `while`) or a `switch` member.

  如果 `continue` 语句的目标标签没有附在
  循环语句（`for`、`do` 和 `while`）或 `switch` 成员上，
  现在是编译时错误。

:::note
The 3.0 release of the Dart SDK dropped support for
[language versions][] before 2.12.

Dart SDK 的 3.0 版本不再支持
2.12 之前的 [语言版本][language versions]。
:::

[Patterns]: /language/patterns
[Records]: /language/records
[Class modifiers]: /language/class-modifiers
[Switch expressions]: /language/branches#switch-expressions
[If-case clauses]: /language/branches#if-case
[`mixin`]: /language/mixins#class-mixin-or-mixin-class
[language versions]: /language/versioning

### Dart 2.19

### Dart 2.19 版本

_Released 25 January 2023_

**发布于 2023 年 1 月 25 日**

Dart 2.19 introduced some precautions surrounding type inference.
These include:

Dart 2.19 围绕类型推断引入了一些预防措施。
其中包括：

* More flow analysis flags for unreachable code cases.

  为不可达代码的情况增加了更多流分析标记。

* No longer delegate inaccessible private names to `noSuchMethod`.

  不再把不可访问的私有名称委托给 `noSuchMethod`。

* Top-level type inference throws on cyclic dependencies.

  顶层类型推断在遇到循环依赖时会抛出异常。

Dart 2.19 also introduced support for unnamed libraries.
Library directives, used for appending library-level doc comments and
annotations, can and [should][] now be written without a name:

Dart 2.19 还引入了对未命名库的支持。
用于附加库级文档注释和注解的库指令，
现在可以、也 [应该][should] 不写名称：

```dart
/// A really great test library.
@TestOn('browser')
library;
```


[should]: /effective-dart/style#dont-explicitly-name-libraries

### Dart 2.18

### Dart 2.18 版本

_Released 30 August 2022_

**发布于 2022 年 8 月 30 日**

| [Dart 2.18 announcement](/blog/dart-2-18-objective-c-swift-interop)

| [Dart 2.18 发布公告](/blog/dart-2-18-objective-c-swift-interop)

Dart 2.18 enhanced type inference.
This change allows information flow between arguments in generic function calls.
Before 2.18, if you didn't specify an argument's type in some methods,
Dart reported errors.
These type errors cited potential null occurrences.
With 2.18, the compiler infers the argument type
from other values in an invocation.
You don't need to specify the argument type inline.

Dart 2.18 增强了类型推断。
这项变更让泛型函数调用中的参数之间可以传递信息。
在 2.18 之前，如果某些方法里你没有指定参数类型，
Dart 会报告错误。
这些类型错误提到可能出现 null。
有了 2.18，编译器会根据同一次调用中的其他值
推断参数类型。
你不必在行内指定参数类型。

Dart 2.18 also discontinued support for mixin classes that don't extend
`Object`.

Dart 2.18 还停止支持不扩展 `Object` 的 mixin 类。

To learn more about these features, check out:

想进一步了解这些特性，请查阅：

* [Type argument inference][]

  [类型参数推断][Type argument inference]

* [Adding features to a class: mixins][]

  [为类添加特性：mixin][Adding features to a class: mixins]

[Type argument inference]: /language/type-system#type-argument-inference
[Adding features to a class: mixins]: /language/mixins

### Dart 2.17

### Dart 2.17 版本

_Released 11 May 2022_

**发布于 2022 年 5 月 11 日**

| [Dart 2.17 announcement](/blog/dart-2-17-productivity-and-integration)

| [Dart 2.17 发布公告](/blog/dart-2-17-productivity-and-integration)

Dart 2.17 expanded enum functionality with enhanced enums.
Enhanced enums allow enum declarations to define members
including fields, constructors, methods, getters, etc.

Dart 2.17 用增强枚举扩展了枚举的功能。
增强枚举允许枚举声明定义成员，
包括字段、构造函数、方法、getter 等。

Dart 2.17 added support for super-initializer parameters in
constructors.
Super parameters allow you to avoid having to manually pass each
parameter into the super invocation of a non-redirecting constructor.
You can instead use super parameters to forward parameters to a
superclass constructor.

Dart 2.17 为构造函数增加了超类初始化参数支持。
超类参数让你不必再把每个参数手动传给
非重定向构造函数的 super 调用。
你可以改用超类参数，把参数转发给超类构造函数。

Dart 2.17 removed some restrictions on named arguments.
Named arguments can now be freely interleaved with positional arguments.
As of Dart 2.17, you can write the following code:

Dart 2.17 取消了命名参数的一些限制。
命名参数现在可以与位置参数自由交错。
从 Dart 2.17 起，你可以写下面这样的代码：

```dart
void main() {
  test(skip: true, 'A test description', () {
    // Very long function body here...
  });
}
```

To learn more about these features, check out:

想进一步了解这些特性，请查阅：

* [Enhanced enums][]

  [增强枚举][Enhanced enums]

* [Super parameters][]

  [超类参数][Super parameters]

* [Named parameters][]

  [命名参数][Named parameters]

[Enhanced enums]: /language/enums#declaring-enhanced-enums
[Super parameters]: /language/constructors#super-parameters
[Named parameters]: /language/functions#named-parameters

### Dart 2.16

### Dart 2.16 版本

_Released 3 February 2022_

**发布于 2022 年 2 月 3 日**

| [Dart 2.16 announcement](/blog/announcing-dart-2-15)

| [Dart 2.16 发布公告](/blog/announcing-dart-2-15)

Dart 2.16 added no new features to the Dart language.
It did expand the Dart tools.

Dart 2.16 没有为 Dart 语言增加新特性。
它扩展了 Dart 工具。

### Dart 2.15

### Dart 2.15 版本

_Released 8 December 2021_

**发布于 2021 年 12 月 8 日**

| [Dart 2.15 announcement](/blog/announcing-dart-2-15)

| [Dart 2.15 发布公告](/blog/announcing-dart-2-15)

Dart 2.15 improved support for function pointers, known as _tear-offs._
In particular, constructor tear-offs are now supported.

Dart 2.15 改进了对函数指针的支持，也就是 **tear-off**。
特别是，现在支持构造函数 tear-off。

### Dart 2.14

### Dart 2.14 版本

_Released 8 September 2021_

**发布于 2021 年 9 月 8 日**

| [Dart 2.14 announcement](/blog/announcing-dart-2-14)

| [Dart 2.14 发布公告](/blog/announcing-dart-2-14)

Dart 2.14 added the unsigned shift (or _triple-shift_) operator (`>>>`).
This new operator works like `>>`,
except that it always fills the most significant bits with zeros.

Dart 2.14 增加了无符号移位（或称 **三重移位**）运算符（`>>>`）。
这个新运算符的作用类似 `>>`，
只不过它总是用零填充最高位。

To learn more about these operators, check out [bitwise and shift operators][].

想进一步了解这些运算符，请查阅 [按位运算符和移位运算符][bitwise and shift operators]。

[bitwise and shift operators]: /language/operators#bitwise-and-shift-operators

Dart 2.14 removed some restrictions on type arguments.
You can pass type arguments to annotations and use a generic function
type as a type argument.
As of Dart 2.14, you can write the following code:

Dart 2.14 取消了类型参数的一些限制。
你可以把类型参数传给注解，也可以把泛型函数类型用作类型参数。
从 Dart 2.14 起，你可以写下面这样的代码：

```dart
@TypeHelper<int>(42, "The meaning")
late List<T Function<T>(T)> idFunctions;
var callback = [<T>(T value) => value];
late S Function<S extends T Function<T>(T)>(S) f;
```

### Dart 2.13

### Dart 2.13 版本

_Released 19 May 2021_

**发布于 2021 年 5 月 19 日**

| [Dart 2.13 announcement](/blog/announcing-dart-2-13)

| [Dart 2.13 发布公告](/blog/announcing-dart-2-13)

Dart 2.13 expanded support for **[type aliases][]** (`typedef`).
Type aliases used to work only for function types
but now work for any type.
You can use the new name created with a type alias
anywhere the original type could be used.

Dart 2.13 扩展了对 **[类型别名][type aliases]**（`typedef`）的支持。
类型别名以前只适用于函数类型，
现在适用于任何类型。
你可以把类型别名创建的新名称
用在原来类型可以用的任何地方。

Dart 2.13 improved the struct support in **[Dart FFI][]**,
adding support for inline arrays and packed structs.

Dart 2.13 改进了 **[Dart FFI][]** 中的结构体支持，
增加了对内联数组和紧凑结构体的支持。

### Dart 2.12

### Dart 2.12 版本

_Released 3 March 2021_

**发布于 2021 年 3 月 3 日**

| [Dart 2.12 announcement](/blog/announcing-dart-2-12)

| [Dart 2.12 发布公告](/blog/announcing-dart-2-12)

Dart 2.12 added support for **[sound null safety][]**.
When you opt into null safety, types in your code are non-nullable by default,
meaning that variables can't contain null unless you say they can.
With null safety, your runtime null-dereference errors
turn into edit-time analysis errors.

Dart 2.12 增加了对 **[健全空安全][sound null safety]** 的支持。
启用空安全后，代码中的类型默认不可空，
也就是说，除非你明确说明，变量不能包含 null。
有了空安全，运行时空解引用错误
会变成编辑时的分析错误。

In Dart 2.12, **[Dart FFI][]** graduated from beta to the stable channel.

在 Dart 2.12 中，**[Dart FFI][]** 从测试版毕业，进入稳定版渠道。

### Dart 2.10

### Dart 2.10 版本

_Released 1 October 2020_

**发布于 2020 年 10 月 1 日**

| [Dart 2.10 announcement](/blog/announcing-dart-2-10)

| [Dart 2.10 发布公告](/blog/announcing-dart-2-10)

Dart 2.10 added no new features to the Dart language.

Dart 2.10 没有为 Dart 语言增加新特性。

### Dart 2.9

### Dart 2.9 版本

_Released 5 August 2020_

**发布于 2020 年 8 月 5 日**

Dart 2.9 added no new features to the Dart language.

Dart 2.9 没有为 Dart 语言增加新特性。

### Dart 2.8

### Dart 2.8 版本

_Released 6 May 2020_

**发布于 2020 年 5 月 6 日**

| [Dart 2.8 announcement](/blog/announcing-dart-2-8)

| [Dart 2.8 发布公告](/blog/announcing-dart-2-8)

Dart 2.8 didn't add any features to the Dart language. It did
contain a number of preparatory [breaking changes][2.8 breaking changes]
to improve nullability-related usability and performance for [null safety][].

Dart 2.8 没有为 Dart 语言增加任何特性。它确实包含
若干预备性的 [破坏性改动][2.8 breaking changes]，
用来改善 [空安全][null safety] 在可空性方面的可用性和性能。

### Dart 2.7

### Dart 2.7 版本

_Released 11 December 2019_

**发布于 2019 年 12 月 11 日**

| [Dart 2.7 announcement](/blog/announcing-dart-2-7-a-safer-more-expressive-dart)

| [Dart 2.7 发布公告](/blog/announcing-dart-2-7-a-safer-more-expressive-dart)

Dart 2.7 added support for **[extension methods][]**,
enabling you to add functionality to any type
—-even types you don't control—-
with the brevity and auto-complete experience of regular method calls.

Dart 2.7 增加了对 **[扩展方法][extension methods]** 的支持，
让你可以为任何类型添加功能，
哪怕是你无法控制的类型，
同时保留普通方法调用那样的简洁和自动补全体验。

The following example extends the `String` class from
`dart:core` with a new `parseInt()` method:

下面的例子为 `dart:core` 中的 `String` 类
增加了一个新的 `parseInt()` 方法：

```dart
extension ParseNumbers on String {
  int parseInt() {
    return int.parse(this);
  }
}

void main() {
  int i = '42'.parseInt();
  print(i);
}
```

### Dart 2.6

### Dart 2.6 版本

_Released 5 November 2019_

**发布于 2019 年 11 月 5 日**

| [Dart 2.6 announcement](/blog/announcing-dart-2-6-with-dart2native-compile-dart-to-self-contained-native-executables)

| [Dart 2.6 发布公告](/blog/announcing-dart-2-6-with-dart2native-compile-dart-to-self-contained-native-executables)

Dart 2.6 introduced a
[breaking change (dart-lang/sdk#37985)]({{site.repo.dart.sdk}}/issues/37985).
Constraints where `Null` serves as a subtype of `FutureOr<T>`
now yield `Null` as the solution for `T`.

Dart 2.6 引入了一项
[破坏性改动（dart-lang/sdk#37985）]({{site.repo.dart.sdk}}/issues/37985)。
当 `Null` 作为 `FutureOr<T>` 的子类型出现在约束中时，
现在会得到 `Null` 作为 `T` 的解。

For example: The following code now prints `Null`.
Before Dart 2.6, it printed `dynamic`.
The anonymous closure `() {}` returns the `Null` type.

例如：下面的代码现在会打印 `Null`。
在 Dart 2.6 之前，它打印 `dynamic`。
匿名闭包 `() {}` 返回 `Null` 类型。

```dart
import 'dart:async';

void foo<T>(FutureOr<T> Function() f) { print(T); }

main() { foo(() {}); }
```

### Dart 2.5

### Dart 2.5 版本

_Released 10 September 2019_

**发布于 2019 年 9 月 10 日**

| [Dart 2.5 announcement](/blog/announcing-dart-2-5-super-charged-development)

| [Dart 2.5 发布公告](/blog/announcing-dart-2-5-super-charged-development)

Dart 2.5 didn't add any features to the Dart language, but it did add
support for [calling native C code][] from Dart code
using a new **core library, `dart:ffi`.**

Dart 2.5 没有为 Dart 语言增加任何特性，但增加了
用新的 **核心库 `dart:ffi`** 从 Dart 代码
[调用原生 C 代码][calling native C code] 的支持。

### Dart 2.4

### Dart 2.4 版本

_Released 27 June 2019_

**发布于 2019 年 6 月 27 日**


Dart 2.4 introduces a breaking change
[dart-lang/sdk#35097]({{site.repo.dart.sdk}}/issues/35097).

Dart 2.4 引入了一项破坏性改动
[dart-lang/sdk#35097]({{site.repo.dart.sdk}}/issues/35097)。

Dart now enforces covariance of type variables used in super-interfaces.
For example: Prior to this release Dart accepted, but now rejects,
the following code:

Dart 现在会强制超接口中使用的类型变量保持协变。
例如：这个版本之前 Dart 接受下面的代码，现在会拒绝：

```dart
class A<X> {};
class B<X> extends A<void Function(X)> {};
```

You can now use `async` as an identifier in
asynchronous and generator functions.

你现在可以在异步函数和生成器函数中
把 `async` 用作标识符。

### Dart 2.3

### Dart 2.3 版本

_Released 8 May 2019_

**发布于 2019 年 5 月 8 日**

| [Dart 2.3 announcement](/blog/announcing-dart-2-3-optimized-for-building-user-interfaces)

| [Dart 2.3 发布公告](/blog/announcing-dart-2-3-optimized-for-building-user-interfaces)

Dart 2.3 added three operators designed to improve code that performs
list manipulation, such as declarative UI code.

Dart 2.3 增加了三个运算符，用来改进做列表操作的代码，
例如声明式界面代码。

The **[spread operator][]**
enables unpacking the elements from one list into another.
In the following example, the list returned by `buildMainElements()`
is unpacked into the list being passed to the `children` argument:

**[展开运算符][spread operator]**
可以把一个列表中的元素拆开，放进另一个列表。
在下面的例子中，`buildMainElements()` 返回的列表
被拆开放进传给 `children` 参数的列表：

```dart
Widget build(BuildContext context) {
  return Column(children: [
    Header(),
    ...buildMainElements(),
    Footer(),
  ]);
}
```

The **[collection if][]** operator enables adding elements conditionally.
The following example adds a `FlatButton` element unless
the app displays the last page:

**[集合 if][collection if]** 运算符可以按条件添加元素。
下面的例子会添加一个 `FlatButton` 元素，
除非应用正在显示最后一页：

```dart
Widget build(BuildContext context) {
  return Column(children: [
    Text(mainText),
    if (page != pages.last)
      FlatButton(child: Text('Next')),
  ]);
}
```

The **[collection for][]** operator enables building repeated elements.
The following example adds one `HeadingAction` element for
each section in `sections`:

**[集合 for][collection for]** 运算符可以构建重复的元素。
下面的例子为 `sections` 中的每个章节
添加一个 `HeadingAction` 元素：

```dart
Widget build(BuildContext context) {
  return Column(children: [
    Text(mainText),
    for (var section in sections)
      HeadingAction(section.heading),
  ]);
}
```


### Dart 2.2

### Dart 2.2 版本

_Released 26 February 2019_

**发布于 2019 年 2 月 26 日**

| [Dart 2.2 announcement](/blog/announcing-dart-2-2-faster-native-code-support-for-set-literals)

| [Dart 2.2 发布公告](/blog/announcing-dart-2-2-faster-native-code-support-for-set-literals)

Dart 2.2 added support for **[set literals][]**:

Dart 2.2 增加了对 **[集合字面量][set literals]** 的支持：

```dart
const Set<String> currencies = {'EUR', 'USD', 'JPY'};
```

### Dart 2.1

### Dart 2.1 版本

_Released 15 November 2018_

**发布于 2018 年 11 月 15 日**

| [Dart 2.1 announcement](/blog/announcing-dart-2-1-improved-performance-usability)

| [Dart 2.1 发布公告](/blog/announcing-dart-2-1-improved-performance-usability)

Dart 2.1 added support for **int-to-double conversion**,
allowing developers to set `double` values using integer literals.
This feature removed the annoyance of being forced to use a
`double` literal (for example, `4.0`)
when the value was an integer in concept.

Dart 2.1 增加了对 **int 到 double 的转换** 的支持，
让开发者可以用整数字面量设置 `double` 值。
这项特性消除了这样一种麻烦：当值在概念上是整数时，
却被迫使用 `double` 字面量（例如 `4.0`）。

In the following Flutter code, `horizontal` and `vertical` have type `double`:

在下面的 Flutter 代码中，`horizontal` 和 `vertical` 的类型是 `double`：

```dart
padding: const EdgeInsets.symmetric(
  horizontal: 4,
  vertical: 8,
)
```

### Dart 2.0

### Dart 2.0 版本

_Released 22 February 2018_

**发布于 2018 年 2 月 22 日**

| [Dart 2.0 announcement](/blog/announcing-dart-2-optimized-for-client-side-development)

| [Dart 2.0 发布公告](/blog/announcing-dart-2-optimized-for-client-side-development)

Dart 2.0 implemented a new **[sound type system][]**.
Before Dart 2.0, types weren't fully sound, and
Dart relied heavily on runtime type checking.
Dart 1.x code had to be migrated to Dart 2.

Dart 2.0 实现了新的 **[健全类型系统][sound type system]**。
在 Dart 2.0 之前，类型并不完全健全，
Dart 严重依赖运行时类型检查。
Dart 1.x 代码必须迁移到 Dart 2。

<a id="language-version-numbers" aria-hidden="true"></a>
<a id="per-library-language-version-selection" aria-hidden="true"></a>

## Language versioning

## 语言版本

:::warning Documentation moved
This content has been moved to a
dedicated page covering Dart [language versioning](/language/versioning).

:::warning 文档已迁移
这些内容已移至专门介绍 Dart
[语言版本](/language/versioning) 的页面。
:::

[2.8 breaking changes]: {{site.repo.dart.sdk}}/issues/40686
[calling native C code]: /interop/c-interop
[collection for]: /language/collections#control-flow-operators
[collection if]: /language/collections#control-flow-operators
[Dart library]: /tools/pub/create-packages#organizing-a-package
[Dart FFI]: /interop/c-interop
[extension methods]: /language/extension-methods
[Extension types]: /language/extension-types
[language funnel]: {{site.repo.dart.lang}}/projects/1
[language specification]: /resources/language/spec
[language documentation]: /language
[null safety]: /null-safety
[private final field promotion]: /tools/non-promotion-reasons
[SDK changelog]: {{site.repo.dart.sdk}}/blob/main/CHANGELOG.md
[set literals]: /language/collections#sets
[sound null safety]: /null-safety
[sound type system]: /language/type-system
[spread operator]: /language/collections#spread-operators
[type aliases]: /language/typedefs
