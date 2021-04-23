---
title: Sound null safety
title: 健全的空安全
description: Information about Dart's null safety feature
description: Dart 空安全的有关内容
---

The Dart language now supports sound null safety!

Dart 语言已支持健全的空安全机制！

When you opt into null safety,
types in your code are non-nullable by default, meaning that
variables can’t contain `null` _unless you say they can._
With null safety, your **runtime** null-dereference errors
turn into **edit-time** analysis errors.

当您选择使用空安全时，代码中的类型将默认是非空的，
意味着 **除非您声明它们可空**，否则它们的值都不能为空。
有了空安全，原本处于您的 **运行时** 的空值引用错误
将变为 **编辑时** 的分析错误。

With null safety,
all of the variables in the following code are non-nullable:

有了空安全，下面代码中所有的变量都是非空的：

```dart
// In null-safe Dart, none of these can ever be null.
var i = 42; // Inferred to be an int.
String name = getFileName();
final b = Foo();
```

To indicate that a variable might have the value `null`,
just add `?` to its type declaration:

若您想让变量可以为 `null`，只需要在类型声明后加上 `?`。

```dart
int? aNullableInt = null;
```

You can
[use null safety](#enable-null-safety) in your normal development environment,
[migrate existing code][migration guide] to use null safety,
enable null safety in [DartPad]({{site.dartpad}}),
or learn about null safety using
[DartPad with Null Safety][nullsafety.dartpad.dev]
(shown in the following screenshot).

您可以 [在您的开发项目里尝试空安全](#enable-null-safety)、
[迁移您项目中的代码][migration guide] 至空安全、
或者通过 [支持空安全的 DartPad][nullsafety.dartpad.dev] 进行练习，
如下面的截图所示。

![Screenshot of DartPad in null-safe mode](/null-safety/dartpad-snippet.png)

For an example-driven summary of null safety language features,
see the [null safety feature tour](/null-safety/tour).
For a more in-depth discussion, see
[Understanding null safety](/null-safety/understanding-null-safety).

若您想通过示例快速了解空安全，可以查看 [空安全功能之旅](/null-safety/tour)。
更深入的探讨，可以阅读 [深入理解空安全](/null-safety/understanding-null-safety)。

## Null safety principles

## 空安全的原则

Dart null safety support is based on the following three core design principles:

Dart 的空安全支持基于以下三条核心原则：

*  **Non-nullable by default**. Unless you explicitly tell Dart that a variable
   can be null, it's considered non-nullable. This default was chosen
   after research found that non-null was by far the most common choice in APIs.

   **默认不可空**。除非您将变量显式声明为可空，否则它一定是非空的类型。
   我们在研究后发现，非空是目前的 API 中最常见的选择，所以选择了非空作为默认值。

* **Incrementally adoptable**. You choose _what_ to migrate to null safety, and _when_.
  You can migrate incrementally, mixing null-safe and
  non-null-safe code in the same project. We provide tools to help you
  with the migration.

  **渐进迁移**。您可以自由地选择何时进行迁移，多少代码会进行迁移。
  您可以使用混合模式的空安全，在一个项目中同时使用空安全和非空安全的代码。
  我们也提供了帮助您进行迁移的工具。

* **Fully sound**. Dart’s null safety is sound, which enables compiler optimizations.
  If the type system determines that something isn’t null, then that thing can _never_ be
  null. Once you migrate your whole project
  and its dependencies to null safety, you reap the full benefits of soundness
  —- not only fewer bugs, but smaller binaries and faster execution.

  **完全可靠**。Dart 的空安全是非常可靠的，意味着编译期间包含了很多优化。
  如果类型系统推断出某个变量不为空，那么它 **永远** 不为空。
  当您将整个项目和其依赖完全迁移至空安全后，
  您会享有健全性带来的所有优势&mdash;&mdash;更少的 BUG、更小的二进制文件以及更快的执行速度。

## Enabling null safety {#enable-null-safety}

## 启用空安全 {#enable-null-safety}

Sound null safety is available in Dart 2.12 and Flutter 2.

健全的空安全已在 Dart 2.12 和 Flutter 2 中可用。

### Migrating an existing package or app {#migrate}

### 迁移已有 package 或应用 {#migrate}

For instructions on how to migrate your code to null safety,
see the [migration guide][].

若您需要代码迁移的指导，请查看 [迁移至空安全][migration guide]。

### Creating a null-safe package or app {#create}

### 创建空安全版本的 package 或应用 {#create}

The templates used by the [`dart create`][] command and IDEs
aren't null safe yet, so you need to migrate the code they create.
For example:

使用 [`dart create`][] 命令或 IDE 创建的模板尚未迁移至空安全。
在创建后您还需要对它们进行迁移。举个例子：

```terminal
$ dart create -t console-full my_cli
$ cd my_cli
$ dart migrate --apply-changes
```

### Behind the scenes: SDK constraints {#constraints}

### 幕后工作：SDK 限制 {#constraints}

To make Dart treat your code as null safe,
the [SDK constraints](/tools/pub/pubspec#sdk-constraints)
must require a [language version][] that has null safety support.
For example, your `pubspec.yaml` file might have the following constraints:

将 [SDK 版本约束](/tools/pub/pubspec#sdk-constraints)
设定为一个支持空安全的 SDK 版本。
例如，您的 `pubspec.yaml` 可以设置为如下的限制：

{% prettify yaml tag=pre+code %}
environment:
  sdk: ">=2.12.0 <3.0.0"
{% endprettify %}

[language version]: /guides/language/evolution#language-versioning

## Known issues

## 已知问题

Some parts of the Dart ecosystem still need additional work to
[migrate to null safety][migration guide].

Dart 的生态 [迁移到空安全][migration guide] 仍然需要一些额外的工作。

The Dart team is currently aware of the following issues:

Dart 团队已知晓以下问题：

  * Migration of the pub.dev packages owned by the Dart team
    is nearly complete, but a few are still missing. See pub.dev for
    [null-safe packages from the Dart team][ns-dart-pkgs].

    pub.dev 上属于 Dart 团队的一些 package 尚有部分未进行迁移。
    您可以查看 pub.dev 上 [Dart 团队已迁移的 package][ns-dart-pkgs]。

  * Packages that have unit tests typically have
    a dev dependency on the [`test` package][`test`].
    A few packages extend the framework in package:test,
    and might have a direct dependency on it.
    When publishing these packages you might get pub warnings about
    the `test` package not being fully migrated.
    As long as your package doesn't ignore any of the
    `import_of_legacy_library_into_null_safe` or
    [`export_legacy_symbol`][] analyzer warnings,
    then you can ignore this warning and safely publish your package.

    包含单元测试的 package，均通过开发依赖引用了 [`test` package][`test`]。
    部分 package 由于扩展了 test package 的框架，可能有直接引用的关联。
    在您发布 package 时可能会遇到 `test` package 尚未迁移的警告。
    只要您未让分析器忽略 `import_of_legacy_library_into_null_safe` 或者
    [`export_legacy_symbol`][] 的警告，您实际上可以忽略这个迁移警告。

[`export_legacy_symbol`]: /tools/diagnostic-messages#export_legacy_symbol
[`test`]: {{site.pub-pkg}}/test

[ns-dart-pkgs]: {{site.pub-pkg}}?q=publisher%3Adart.dev&null-safe=1


## Where to learn more

## 学习更多

For more information about null safety, see the following resources:

* [Null safety tour][]

  [空安全功能之旅][Null safety tour]

* [Understanding null safety][]

  [深入理解空安全][Understanding null safety]

* [Migration guide for existing code][migration guide]

  [现有代码的迁移指南][migration guide]

* [Null safety FAQ][]

  [空安全常见问题和解答][Null safety FAQ]
  
* [DartPad with null safety][nullsafety.dartpad.dev]

  [支持空声明的 DartPad (DartPad with null safety)][nullsafety.dartpad.dev]

* [Null safety sample code][calculate_lix]

  [空安全示例代码 (Null safety sample code)][calculate_lix]

* [Null safety tracking issue][110]

  [空安全的问题跟踪 (Null safety tracking issue)][110]

* [Dart blog][]

  [Dart 官方博客)][Dart blog]

[110]: https://github.com/dart-lang/language/issues/110
[calculate_lix]: https://github.com/dart-lang/samples/tree/master/null_safety/calculate_lix
[`dart create`]: /tools/dart-tool
[Dart blog]: https://medium.com/dartlang
[migration guide]: /null-safety/migration-guide
[Null safety FAQ]: /null-safety/faq
[Null safety tour]: /null-safety/tour
[nullsafety.dartpad.dev]: https://nullsafety.dartpad.dev
[Understanding null safety]: /null-safety/understanding-null-safety

