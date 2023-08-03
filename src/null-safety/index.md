---
title: Sound null safety
title: 健全的空安全
description: Information about Dart's null safety feature
description: Dart 空安全的有关内容
---

The Dart language enforces sound null safety.

Dart 语言要求使用健全的空安全特性。

Null safety prevents errors that result from unintentional access
of variables set to `null`.

空安全会在编译期防止意外访问 `null` 变量的错误的产生。

For example, if a method expects an integer but receives `null`,
your app causes a runtime error.
This type of error, a null dereference error, can be difficult to debug.

例如，如果一个方法需要整型结果，却接收到了 `null`，你的应用会出现运行时错误。
这类空引用错误在以前调试是非常困难的。

With sound null safety, all variables require a value.
This means Dart considers all variables _non-nullable_.
You can assign values of the declared type only, like `int i=42`.
You can never assign a value of `null` to default variable types.
To specify that a variable type can have a `null` value, add a `?` after
the type annotation: `int? i`.
These specific types can contain either a `null` _or_
a value of the defined type.

有了健全的空安全体系，变量需要有默认值，即 Dart 认为变量是「非空」的。
它们可以赋予与定义的类型相同类型的任意值（例如 `int i = 42`），
且永远不能被设置为 `null`。
你可以指定一个类型为可空（例如 `int? i`），
这类变量只能包含对应类型的值或者 `null`。

Sound null safety changes potential **runtime errors**
into **edit-time** analysis errors.
With null safety, the Dart analyzer and compilers
flag if a non-nullable variable has either:

健全的空安全通过对非空变量的未被初始化或以 `null` 初始化的情况进行标记，
把潜在的 **运行时错误** 转变成了 **编辑时** 的分析错误。
这样的特性让你在开发应用的过程中就可以修复这类错误：

* Not been initialized with a non-null value

  没有以非空的值初始化

* Been assigned a `null` value.

  赋了 `null` 值。

These checks allows you to fix these errors _before_ deploying your app.

这些检查让你能在构建你的应用前就修复这些错误。

## Introduction through examples

## 通过示例代码介绍空安全

With null safety, none of the variables in the following code can be `null`:

有了空安全，下面代码中所有的变量都是非空的：

```dart
// With null safety, none of these can ever be null.
var i = 42; // Inferred to be an int.
String name = getFileName();
final b = Foo();
```

<a id="creating-variables"></a>
To indicate that a variable might have the value `null`,
just add `?` to its type declaration:

<a id="creating-variables"></a>
若你想让变量可以为 `null`，只需要在类型声明后加上 `?`。

```dart
int? aNullableInt = null;
```

- To try an interactive example,
  see the [null safety codelab][Null safety codelab].

  你可以通过 [空安全 Codelab][Null safety codelab] 交互示例快速了解空安全。

- To learn more about this topic, see
  [Understanding null safety](/null-safety/understanding-null-safety).

  更深入的探讨，可以阅读文档 [深入理解空安全](/null-safety/understanding-null-safety)。

## Null safety principles

## 空安全的原则

Dart supports null safety using the following three core design principles:

Dart 的空安全支持基于以下三条核心原则：

* **Non-nullable by default**. Unless you explicitly tell Dart that a variable
   can be null, it's considered non-nullable. This default was chosen
   after research found that non-null was by far the most common choice in APIs.

   **默认不可空**。除非你将变量显式声明为可空，否则它一定是非空的类型。
   我们在研究后发现，非空是目前的 API 中最常见的选择，所以选择了非空作为默认值。

* **Fully sound**. Dart’s null safety is sound, which enables compiler optimizations.
  If the type system determines that something isn’t null, then that thing can _never_ be
  null. Once you migrate your whole project
  and its dependencies to null safety, 
  you reap the full benefits of soundness—not only 
  fewer bugs, but smaller binaries and faster execution.

  **完全可靠**。Dart 的空安全是非常可靠的，意味着编译期间包含了很多优化。
  如果类型系统推断出某个变量不为空，那么它 **永远** 不为空。
  当你将整个项目和其依赖完全迁移至空安全后，
  你会享有健全性带来的所有优势&mdash;&mdash;
  更少的 BUG、更小的二进制文件以及更快的执行速度。

## Dart 3 and null safety

Dart 3 has built-in sound null safety.
Dart 3 prevents code without it from running.

To learn how to migrate to Dart 3, 
check out the [Dart 3 migration guide](/resources/dart-3-migration).
Packages developed without null safety support cause issues
when resolving dependencies:

```terminal
$ dart pub get

Because pkg1 doesn't support null safety, version solving failed.
The lower bound of "sdk: '>=2.9.0 <3.0.0'" must be 2.12.0 or higher to enable null safety.
```

Libraries incompatible with Dart 3 cause analysis or compilation errors.


```terminal
$ dart analyze .
Analyzing ....                         0.6s

  error • lib/pkg1.dart:1:1 • The language version must be >=2.12.0. 
  Try removing the language version override and migrating the code.
  • illegal_language_version_override
```

```terminal
$ dart run bin/my_app.dart
../pkg1/lib/pkg1.dart:1:1: Error: Library doesn't support null safety.
// @dart=2.9
^^^^^^^^^^^^
```

To resolve these issues:

1. Check for [null safe versions](/null-safety/migration-guide#check-dependency-status)
   of any packages you installed from pub.dev
2. [migrate](#migrate) all of your source code to use sound null safety.

Dart 3 can be found in the stable channels for Dart and Flutter.
To learn more, check out [the download page][] for details.
To test your code for Dart 3 compatibility, use Dart 3 or later.

```terminal
$ dart --version                     # make sure this reports 3.0.0-417.1.beta or higher
$ dart pub get / flutter pub get     # this should resolve without issues
$ dart analyze / flutter analyze     # this should pass without errors
```

If the `pub get` step fails, check the [status of the dependencies][].

If the `analyze` step fails, update your code to resolve the issues
listed by the analyzer.

[the download page]: /get-dart/archive
[status of the dependencies]: /null-safety/migration-guide#check-dependency-status

## Dart 2.x and null safety {#enable-null-safety}

## 启用和禁用空安全 {#enable-null-safety}

From Dart 2.12 to 2.19, you need to enable null safety.
You cannot use null safety in SDK versions earlier than Dart 2.12.

在 Dart 2.12 到 2.19 中，你需要手动启用空安全。
Dart 2.12 之前的 SDK 版本不提供空安全。

<a id="constraints"></a>
To enable sound null safety, set the
[SDK constraint lower-bound](/tools/pub/pubspec#sdk-constraints)
to a [language version][] of 2.12 or later.
For example, your `pubspec.yaml` file might have the following constraints:

<a id="constraints"></a>
想要启用健全空安全，你需要将 [SDK 的最低版本约束](/tools/pub/pubspec#sdk-constraints)
设定为 2.12 或者更高的 [语言版本][language version]。
例如，你的 `pubspec.yaml` 可以设置为如下的限制：

```yaml
environment:
  sdk: '>=2.12.0 <3.0.0'
```

[language version]: /guides/language/evolution#language-versioning

## Migrating existing code {#migrate}

### 迁移现有的 package 或应用 {#migrate}

{{site.alert.warning}}

  Dart 3 removes the `dart migrate` tool.
  If you need help migrating your code,
  run the tool with the 2.19 SDK, then upgrade to Dart 3.

  Dart 3 移除了 `dart migrate` 工具。
  如果你需要迁移你的代码至空安全，
  你需要用 2.19 的 SDK，并在升级完成后升级至 Dart 3。

  You can migrate without the tool, but it involves
  hand editing code.

  你也可以手动修改，而不用工具进行迁移。

{{site.alert.end}}

Dart code written without null safety support can be migrated to use null
safety. We recommend using the `dart migrate` tool, included in the Dart SDK
versions 2.12 to 2.19.

没有加入空安全支持的 Dart 代码可以迁移到使用空安全。
我们建议使用 Dart SDK 2.12 到 2.19 版本中包含的 `dart migrate` 工具。

```terminal
$ cd my_app
$ dart migrate
```

To learn how to migrate your code to null safety,
check out the [migration guide][].

你可以阅读 [迁移指南][migration guide] 来学习如何迁移你的代码至空安全。

## Where to learn more

## 学习更多

To learn more about null safety, check out the following resources:

想了解关于空安全的更多内容，可查看以下的资源内容：

* [Null safety codelab][]

  [空安全 Codelab][Null safety codelab]

* [Understanding null safety][]

  [深入理解空安全][Understanding null safety]

* [Migration guide for existing code][migration guide]

  [现有代码的迁移指南][migration guide]

* [Null safety FAQ][]

  [空安全常见问题和解答][Null safety FAQ]

* [Null safety sample code][calculate_lix]

  [空安全示例代码][calculate_lix]

[calculate_lix]: https://github.com/dart-lang/samples/tree/main/null_safety/calculate_lix
[migration guide]: /null-safety/migration-guide
[Null safety FAQ]: /null-safety/faq
[Null safety codelab]: /codelabs/null-safety
[Understanding null safety]: /null-safety/understanding-null-safety
[#34233]: https://github.com/dart-lang/sdk/issues/34233
[#49529]: https://github.com/dart-lang/sdk/issues/49529
[#2357]: https://github.com/dart-lang/language/issues/2357

