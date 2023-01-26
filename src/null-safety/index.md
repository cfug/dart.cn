---
title: Sound null safety
title: 健全的空安全
description: Information about Dart's null safety feature
description: Dart 空安全的有关内容
---

The Dart language comes with sound null safety. 

In Dart 3, you always get null safety. In Dart 2.x,
it must be enabled [with a pubspec setting](#enable-null-safety).

Dart 语言包含了健全的空安全特性。

Null safety prevents errors that result from unintentional access
of variables set to `null`.
For example, if a method expects an integer but receives `null`,
your app causes a runtime error. This type of error, a null dereference error,
can be difficult to debug.

空安全会在编译期防止意外访问 `null` 变量的错误的产生。
例如，如果一个方法需要整型结果，却接收到了 `null`，你的应用会出现运行时错误。
这类空引用错误在以前调试是非常困难的。

With sound null safety variables are 'non-nullable' by default:
They can be assigned only values of the declared type
(e.g. `int i=42`), and never be assigned `null`.
You can specify that a type of a variable is nullable
(e.g. `int? i`),
and only then can they contain either a `null` *or*
a value of the defined type.

有了健全的空安全体系，变量默认是「非空」的：
它们可以赋予与定义的类型相同类型的任意值（例如 `int i = 42`），
且永远不能被设置为 `null`。
你可以指定一个类型为可空（例如 `int? i`），
这类变量只能包含对应类型的值或者 `null`。

Sound null safety changes potential **runtime errors**
into **edit-time** analysis errors, by flagging when
any non-nullable variable hasn't been initialized with a 
non-null value or is being assigned a `null`.
This allows you to fix these errors before deploying your app.

健全的空安全通过对非空变量的未被初始化或以 `null` 初始化的情况进行标记，
把潜在的 **运行时错误** 转变成了 **编辑时** 的分析错误。
这样的特性让你在开发应用的过程中就可以修复这类错误。

## Introduction through examples

## 通过示例代码介绍空安全

With null safety,
all of the variables in the following code are non-nullable:

有了空安全，下面代码中所有的变量都是非空的：

```dart
// In null-safe Dart, none of these can ever be null.
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

Dart null safety support is based on the following three core design principles:

Dart 的空安全支持基于以下三条核心原则：

* **Non-nullable by default**. Unless you explicitly tell Dart that a variable
   can be null, it's considered non-nullable. This default was chosen
   after research found that non-null was by far the most common choice in APIs.

   **默认不可空**。除非你将变量显式声明为可空，否则它一定是非空的类型。
   我们在研究后发现，非空是目前的 API 中最常见的选择，所以选择了非空作为默认值。

* **Incrementally adoptable**. You choose _what_ to migrate to null safety, and _when_.
  You can migrate incrementally, mixing null-safe and
  non-null-safe code in the same project. We provide tools to help you
  with the migration.

  **渐进迁移**。你可以自由地选择何时进行迁移，多少代码会进行迁移。
  你可以使用混合模式的空安全，在一个项目中同时使用空安全和非空安全的代码。
  我们也提供了帮助你进行迁移的工具。

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

Dart 3---planned for a mid-2023 release---always has sound null safety.
Dart 3 will prevent code from running without it.

Packages developed without null safety support will cause issues
when resolving dependencies:

```terminal
$ dart pub get

Because pkg1 doesn't support null safety, version solving failed.
The lower bound of "sdk: '>=2.9.0 <3.0.0'" must be 2.12.0 or higher to enable null safety.
```

Libraries that opt out of null safety will cause analysis or compilation
errors:

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

To resolve these issues, check for 
[null safe versions](/null-safety/migration-guide#check-dependency-status)
of any packages you installed from pub.dev, and [migrate](#migrate) all
of your own source code to use sound null safety.

As of late January 2023, **Dart 3 alpha** is available from the Dart dev channel
and the Flutter master channel; see [the download page][] for details.
We recommend you test your code for Dart 3 compatibility using that release:

```terminal
$ dart --version                     # make sure this reports 3.0.0-151.0.dev or higher
$ dart pub get / flutter pub get     # this should resolve without issues
$ dart analyze / flutter analyze     # this should pass without errors
```

If the `pub get` step fails, check the [status of the dependencies][].

If the `analyze` step fails, update your code to resolve the issues
listed by the analyzer.

[the download page]: /get-dart/archive#dart-3-alpha
[status of the dependencies]: /null-safety/migration-guide#check-dependency-status

### Dart 3 backwards compatibility

Packages and apps migrated to use null safety with Dart 2.12 or later will
likely be backwards compatible with Dart 3. Specifically, for any package where
the lower bound of the SDK constraint is 2.12.0 or higher, pub will allow
resolution even when the upper bound is limited to versions below 3.0.0. For
example, a package with the following constraint will be allowed to resolve with
a Dart 3.x SDK:

```yaml
environment:
  sdk: '>=2.14.0 <3.0.0'
```

This allows developers to use Dart 3 sound null safety with packages that have
been migrated to 2.12 null safety without needing a second migration.
Note that this only applies to code that
doesn't depend on Dart 3 breaking changes:

* Several historical core library APIs have been removed; for details,
  see the GitHub issues [#34233][] and [#49529][].
* The historical language syntax for default parameter values
  ([#2357][]) has been discontinued.


## Dart 2.x and null safety {#enable-null-safety}

## 启用和禁用空安全 {#enable-null-safety}

In Dart 2.12 to 2.19, null safety is a configuration option in the pubspec. Null
safety is not available in SDK versions prior to Dart 2.12.

在 Dart 2.12 到 2.19 中，空安全是 pubspec 中的一个配置项。
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

Dart code written without null safety support can be migrated to use null
safety. We recommend using the `dart migrate` tool, included in the Dart SDK
versions 2.12 to 2.19.

没有加入空安全支持的 Dart 代码可以迁移到使用空安全。
我们建议使用 Dart SDK 2.12 到 2.19 版本中包含的 `dart migrate` 工具。

```terminal
$ cd my_app
$ dart migrate
```

For more details on how to migrate your code to null safety,
see the [migration guide][].

你可以阅读 [迁移指南][migration guide] 来学习如何迁移你的代码至空安全。


## Where to learn more

## 学习更多

For more information about null safety, see the following resources:

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

[calculate_lix]: https://github.com/dart-lang/samples/tree/master/null_safety/calculate_lix
[migration guide]: /null-safety/migration-guide
[Null safety FAQ]: /null-safety/faq
[Null safety codelab]: /codelabs/null-safety
[Understanding null safety]: /null-safety/understanding-null-safety
[#34233]: https://github.com/dart-lang/sdk/issues/34233
[#49529]: https://github.com/dart-lang/sdk/issues/49529
[#2357]: https://github.com/dart-lang/language/issues/2357

