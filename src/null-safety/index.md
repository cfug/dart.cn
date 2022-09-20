---
title: Sound null safety
title: 健全的空安全
description: Information about Dart's null safety feature
description: Dart 空安全的有关内容
---

The Dart language comes with sound null safety.

Null safety prevents errors that result from unintentional access
of variables set to `null`.
For example, if a method expects an integer but receives `null`,
your app causes a runtime error. This type of error, a null dereference error,
can be difficult to debug.

With sound null safety variables are 'non-nullable' by default:
They can be assigned only values of the declared type
(e.g. `int i=42`), and never be assigned `null`.
You can specify that a type of a variable is nullable
(e.g. `int? i`),
and only then can they contain either a `null` *or*
a value of the defined type.

Sound null safety changes potential **runtime errors**
into **edit-time** analysis errors, by flagging when
any non-nullable variable hasn't been initialized with a 
non-null value or is being assigned a `null`.
This allows you to fix these errors before deploying your app.

{{site.alert.warn}}
In Dart 2.x SDKs, you can enable or disable sound null safety 
through configuration of the project SDK constraint.
To learn more, see [Enabling/disabling null safety](#enable-null-safety).

Dart 3--planned for a mid-2023 release--
will require sound null safety. It will prevent code from running without it.
All existing code must be [migrated](#migrate) to sound null safety
to be compatible with Dart 3.
To learn more, see the [Dart 3 sound null safety tracking issue][].
{{site.alert.end}}

[Dart 3 sound null safety tracking issue]: https://github.com/dart-lang/sdk/issues/49530

## Introduction through examples

## 通过实例代码介绍空安全

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

若你想让变量可以为 `null`，只需要在类型声明后加上 `?`。

```dart
int? aNullableInt = null;
```

- To try an interactive example,
  see the [null safety codelab][Null safety codelab].

  通过一个交互示例快速了解空安全，可以参阅 [空安全 Codelab][Null safety codelab]

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

## Enabling/disabling null safety {#enable-null-safety}

## 启用和禁用空安全 {#enable-null-safety}

You can use sound null safety in Dart 2.12 and Flutter 2.0 or later.
Dart 3 and later will [_only_ support sound null safety][Dart 3 sound null safety tracking issue].

健全的空安全已在 Dart 2.12 和 Flutter 2.0 中可用。
[Dart 3 和以后的版本将只支持健全的空安全][Dart 3 sound null safety tracking issue] 了。

<a id="constraints"></a>
To enable sound null safety, set the
[SDK constraint lower-bound](/tools/pub/pubspec#sdk-constraints)
to a [language version][] of 2.12 or later.
For example, your `pubspec.yaml` file might have the following constraints:

启用健全空安全，需要将 [SDK 版本约束](/tools/pub/pubspec#sdk-constraints)
的 [语言版本][language version] 设定为 2.12 或者更高。
例如，你的 `pubspec.yaml` 可以设置为如下的限制：

```yaml
environment:
  sdk: '>=2.12.0 <3.0.0'
```

[language version]: /guides/language/evolution#language-versioning

### Migrating an existing package or app {#migrate}

The Dart SDK includes the `dart migrate` tool.
This tool helps you migrate code that supports sound null safety. 
Use `dart migrate` if you wrote Dart code with Dart 2.12 or earlier.

```terminal
$ cd my_app
$ dart migrate
```

To learn how to migrate your code to null safety,
see the [migration guide][].


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
  
* [DartPad with null safety]({{site.dartpad}})

  [支持空声明的 DartPad (DartPad with null safety)]({{site.dartpad}})

* [Null safety sample code][calculate_lix]

  [空安全示例代码 (Null safety sample code)][calculate_lix]

* [Null safety tracking issue][110]

  [空安全的问题跟踪 (Null safety tracking issue)][110]

* [Dart blog][]

  [Dart 官方博客][Dart blog]

[110]: https://github.com/dart-lang/language/issues/110
[calculate_lix]: https://github.com/dart-lang/samples/tree/master/null_safety/calculate_lix
[`dart create`]: /tools/dart-create
[Dart blog]: https://medium.com/dartlang
[migration guide]: /null-safety/migration-guide
[Null safety FAQ]: /null-safety/faq
[Null safety codelab]: /codelabs/null-safety
[Understanding null safety]: /null-safety/understanding-null-safety

