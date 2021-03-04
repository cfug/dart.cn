---
title: Unsound null safety
title: 非健全的空安全
description: Mixing language versions lets you migrate to null safety at your own pace, with some of the benefits of null safety.
description: 非健全的空安全让您可以以自己的步调迁移到空安全，同时可以享受一些空安全的好处。
---

A Dart program can contain some libraries that
are [null safe][] and some that aren't.
These **mixed-version programs**
execute with **unsound null safety**.

一个 Dart 程序可以同时包含已经是 [空安全][null safe] 和未迁移至空安全的库。
这些 **混合模式的程序** 会运行在 **非健全的空安全** 下。

[null safe]: /null-safety

The ability to mix [language versions][]
frees package maintainers to migrate their code,
with the knowledge that even legacy users can get new
bug fixes and other improvements.
However, mixed-version programs don't get all the advantages
that null safety can bring.

[混合模式版本][language versions] 的空安全，
让软件包的维护者可以迁移至空安全的同时，
未迁移至空安全的使用者也可以享受新的问题修复和其他改进。
然而，混合模式的程序无法拥有空安全带来的所有优势。

[language versions]: /guides/language/evolution#language-versioning

This page describes the differences between sound and unsound null safety,
with the goal of helping you decide when to migrate to null safety.
After the conceptual discussion are instructions for migrating incrementally,
followed by details on testing and running mixed-version programs.

本文将描述健全和非健全的空安全之间的区别，让您可以为何时进行空安全迁移下定论。

{{ site.alert.note }}

  We recommend that, if possible, you wait for dependencies to migrate
  before you migrate your package.
  For details, see the [migration guide][].

  我们希望您能尽可能地等到所有您依赖的库都迁移完成后，再对您的软件包进行空安全迁移。
  更多细节，请参考 [迁移指南][migration guide]。

{{ site.alert.end }}

[migration guide]: /null-safety/migration-guide


## Sound and unsound null safety

## 健全和非健全的空安全

Dart provides sound null safety through a combination of
static and runtime checks.
Each Dart library that opts in to null safety gets
all the _static_ checks, with stricter compile-time errors.
This is true even in a mixed-version program that contains
null-unsafe libraries.
You start getting these benefits
as soon as you start migrating some of your code to null safety.

Dart 通过一系列的静态和运行时检查来提供健全的空安全。
每一个使用了空安全的 Dart 库都会拥有所有的 **静态** 检查和更严格的编译期的错误提醒。
对于包含了空安全库的混合模式程序也是如此。
代码一旦开始迁移，已迁移的部分就能立刻享有到它带来的好处。

However, a mixed-version program can't have the
_runtime_ soundness guarantees that a fully null-safe app has.
It's possible for `null` to leak out of the null-unsafe libraries
into the null-safe code, because
preventing that would break the existing behavior of the unmigrated code.

然而，混合模式的程序无法获得与空安全的程序的 **运行时** 健全性一致的保证。
`null` 很可能从非空安全的库污染到空安全的代码，
因为一旦它被阻止，就会对现有的代码行为造成破坏。

To maintain runtime compatibility with legacy libraries
while offering soundness to completely null-safe programs,
Dart tools support two modes:

为了在保持与传统库运行时的兼容性的同时，能为健全的空安全程序提供健全性，
Dart 工具提供了以下两种模式的支持：

* Mixed-version programs run with **unsound null safety**.
  It's possible for `null` reference errors to occur at runtime,
  but only because a `null` or nullable type escaped from
  some null-unsafe library and got into null-safe code.

  以 **非健全的空安全** 运行的混合模式的程序。
  在运行时有可能出现 `null` 引用错误，
  但这只是因为一些 `null` 值和可空类型在非空安全的库中污染了空安全的代码。

* When a program is fully migrated and _all_ its libraries are null safe,
  then it runs with **sound null safety**, with
  all of the guarantees and compiler optimizations that soundness enables.

  当程序完全迁移至空安全，且它所依赖的库 **全部** 都迁移完成后，
  它就在以 **健全的空安全** 运行，拥有所有由健全性带来的保证和编译优化。

Sound null safety is what you want if possible.
Dart tools automatically run your program in sound mode if
the main entrypoint library of your program has opted into null safety.
If you import a null-unsafe library,
the tools print a warning to let you know that
they can only [run with unsound null safety](#analyzing-and-testing).

健全的空安全唾手可得。
当您的程序入口的库已经迁移至空安全，Dart 会自动以健全的空安全运行您的代码。
如果您导入了非空安全的库，会有一条提示告诉您，您的程序只能
[以非健全的空安全运行](#analyzing-and-testing)。

## Migrating incrementally

## 逐步迁移

Because Dart supports mixed-version programs,
you can migrate one library (generally one Dart file) at a time,
while still being able to run your program and its tests.

因为 Dart 支持混合模式的空安全，
所以您可以一个个迁移您的库（通常是一个文件），同时能正常运行程序和测试。

We recommend that you **first migrate leaf libraries** —
libraries that don't import other files from the package.
Then migrate libraries that directly depend on the leaf libraries.
End by migrating the libraries that have the most
intra-package dependencies.

我们推荐您 **优先迁移最下层的库** &mdash;&mdash; 指的是没有导入其他包的库。
接着迁移直接依赖了下层库的依赖库。
最后再迁移依赖项最多的库。

For example, say you have a `lib/src/util.dart` file
that imports other (null-safe) packages and core libraries,
but that doesn't have any `import '<local_path>'` directives.
Consider migrating `util.dart` first,
and then migrating files that depend only on `util.dart`.
If any libraries have cyclic imports
(for example, A imports B which imports C, and C imports A),
consider migrating those libraries together.

举个例子，假设您的 `lib/src/util.dart` 导入了其他（空安全）的软件包和核心库，
但它没有包含任何 `import '<本地路径>'` 的引用。
那么您应当优先考虑迁移 `util.dart`，然后迁移依赖了 `util.dart` 的文件。
如果有一些循环引用的库（例如 A 引用了 B，B 引用了 C，C 引用了 A），
建议同时对它们进行迁移。

### Using the migration tool

### 使用迁移工具

You can migrate incrementally using the
[migration tool][].
To opt out files or directories, click the green checkbox.
In the following screenshot,
all files in the `bin` directory are opted out.

您可以使用 [迁移工具][migration tool] 进行渐进迁移。
如果您需要排除部分文件或文件夹，勾选绿色的勾选框。
下方的截图中，`bin` 文件夹的所有文件都已被排除。

![Screenshot of file viewer in migration tool](/null-safety/migration-tool-incremental.png)

[migration tool]: /null-safety/migration-guide#step2-migrate

Each opted out file will be unchanged
except for a 2.9 [language version comment][].
You can later run `dart migrate` again to continue the migration.
Any files that are already migrated feature a disabled checkbox:
you cannot un-migrate a file once it has been migrated.

每个不迁移的文件都会加上 2.9 [语言版本的注释][language version comment]。
您可以之后再次运行 `dart migrate` 继续迁移。
已迁移的文件将显示为禁用的勾选框，它们无法撤销迁移更改。

### Migrating by hand

If you want to incrementally migrate a package by hand, follow these steps:

手动对软件包进行迁移时，请参考以下步骤：

1. Edit the package's `pubspec.yaml` file,
   setting the minimum SDK constraint to `2.12.0`:

   编辑软件包的 `pubspec.yaml` 文件，将最低 SDK 版本设置到 `2.12.0`：

   ```yaml
environment:
  sdk: '>=2.12.0 <3.0.0'
```

2. Regenerate the [package configuration file][]:

   重新生成 [软件包的配置文件][package configuration file]：

   ```terminal
   $ dart pub get
   ```

   [package configuration file]: https://github.com/dart-lang/language/blob/master/accepted/future-releases/language-versioning/package-config-file-v2.md

   Running `dart pub get` with a lower SDK constraint of `2.12.0`
   sets the default language version of
   every library in the package to 2.12,
   opting them all in to null safety.

   在版本低于 `2.12.0-0` 的 SDK 上运行 `dart pub get` 时，
   会将每个包的默认 SDK 版本设定为 2.12，并且默认它们已经迁移至空安全。

3. Open the package in your IDE. <br>
   You're likely to see a lot of analysis errors.
   That's OK.

   在您的 IDE 上打开软件包。<br>
   您也许会看到很多错误，没关系，让我们继续。

4. Add a [language version comment][] to the top of
   any Dart files that you don't want to consider during your current migration:

   在所有您不考虑进行迁移的 Dart 文件顶部加上
   [语言版本注释][language version comment]。

   ```dart
// @dart=2.9
```

   Using language version 2.9 for a library that's in a 2.12 package
   can reduce analysis errors (red squiggles) coming from unmigrated code.
   However, **unsound null safety reduces the
   information the analyzer can use.**
   For example, the analyzer might assume a
   parameter type is non-nullable,
   even though a 2.9 file might pass in a null value.

   在 2.12 软件包中为库指定 2.9 的语言版本可以减少一些未迁移的分析错误。
   然而，**非健全的空安全减少了分析器中可用的信息**。
   例如，就算 2.9 版本的文件中一个参数可能会传入空值，分析器也可能会假定参数类型不为空，

5. Migrate the code of each Dart file,
   using the analyzer to identify static errors. <br>
   Eliminate static errors by adding `?`, `!`, `required`, and `late`,
   as needed.

   利用分析器来辨析静态错误，逐个迁移 Dart 文件。<br>
   按需添加 `?`、`!`、`required` 以及 `late` 来消除静态错误。

## Testing or running mixed-version programs

## 测试或运行混合版本的程序

To test or run mixed-version code,
you need to disable sound null safety.
You can do this in two ways:

想要测试或运行混合版本的代码，您需要禁用健全的空安全。
有两种方式可以进行操作：

* Disable sound null safety using the `--no-sound-null-safety` flag
  to the `dart` or `flutter` command:

  在 `dart` 和 `flutter` 命令里，加入 `--no-sound-null-safety` 标记禁用。
  例如：

  ```terminal
  $ dart --no-sound-null-safety run
  $ flutter run --no-sound-null-safety
  ```

* Alternatively, set the language version in the entrypoint —
  the file that contains `main()` function — to 2.9.
  In Flutter apps, this file is often named `lib/main.dart`.
  In command-line apps, this file is often named `bin/<packageName>.dart`.
  You can also opt out files under `test`,
  because they are also entrypoints.
  Example:

  或者，设定程序入口的语言版本 &mdash;&mdash;
  包含 `main()` 函数的文件 &mdash;&mdash; 设定为 2.9。
  在 Flutter 应用中，一般是 `lib/main.dart`。
  在命令行应用中，一般是 `bin/<软件包名>.dart`。
  同时您也可以设定 `test` 下的文件，因为它们也包含程序入口。
  例如

  ```dart
  // @dart=2.9
  import 'src/my_app.dart';

  main() {
    //...
  }
  ```
  
Opting out tests using either of these mechanisms can be useful
for testing **during** your incremental migration process,
but doing so means that you aren't testing your code with
full null safety enabled.
It's important to opt your tests back _in_ to null safety
when you've finished the incremental migration of your libraries.

以上两种方式的规避，对于 **正在** 增量迁移的过程非常有用，
但这样做意味着您并未在完全启用空安全的情况下测试您的代码。
当您完成增量迁移后，也请记得将测试代码 **重新** 迁移至空安全。

[language version comment]: /guides/language/evolution#per-library-language-version-selection
[package config]: https://pub.dev/packages/package_config

