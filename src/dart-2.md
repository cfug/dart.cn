---
title: Dart 2 migration guide
title: Dart 2 迁移指南
description: How Dart 2 is different from Dart 1.x, and how you can convert your code to work with Dart 2.
description: Dart 2 和 1.x 版本的区别，以及如何迁移到 Dart 2。
---

Dart 2 has a few key differences from earlier versions of Dart.
This page briefly covers those differences and
gives general advice on migrating your code to Dart 2.

Dart 2 有一些与早期版本 Dart 不同的关键点。本文将会简单地介绍这些差异并提供了一些将代码迁移到 Dart 2 的建议。

For information on _why_ Dart 2 has changed, see the
[Dart 2 announcement.][Dart 2 announcement]

至于 **为什么** Dart 2 要做这些改变，
你可以查阅 [Dart 2 公告][Dart 2 announcement]

## Differences

## 差异点

The Dart language, libraries, build system, and web development tools have changed.

Dart 语言、库、编译系统以及 Web 开发工具都已经有所变化。

### Language and libraries

### 语言和库

* [Dart's type system][sound Dart] is now sound.

  [Dart 的类型系统][sound Dart] 现在是健全的。

  * [Fixing common type problems][Fixing Common Type Problems]

    [修复常见的类型问题][Fixing Common Type Problems]

  * [Flutter announcement: Breaking Change: `--preview-dart-2` turned on by default][Leaf's email]

    [Flutter 公告：变更：`--preview-dart-2` 命令参数默认为开启][Leaf's email]

* Instance creation keywords are now generally optional,
  as described in [Using constructors][]:

  实例对象创建的关键字现在是可选的，就像 [使用构造函数][Using constructors] 中所说的那样：

  * `new` is always optional.

    `new` 关键字总是可选的。

  * `const` is optional inside of a constant context.

    `const` 在常量上下文环境中也是可选的。

* Dart no longer has checked mode.

  Dart 不再有检查模式。

  * [Assert statements][] are still supported, but you enable them differently.

    [Assert 语句][Assert statements] 依然支持，但是开启的方式改变了。

* Functions marked `async` now run synchronously
  until the first `await` statement. 

  标记为 `async` 的方法现在可以同步运行，直到第一个 `await` 语句为止。
  
  * Previously, execution returned immediately to the caller, and
    the function body was scheduled to run later.

    之前是立刻返回给调用者，方法体内的代码会在之后运行。
    
  * To learn more, read [the September 2017 Dart newsletter][sync async start].

    了解更多，请阅读 [2017 年 9 月的 Dart 新闻快报][sync async start]。

* The Dart language and core libraries have changed,
  partly as a result of the type system changes.

  Dart 语言和核心库也改变了，部分原因是因为类型系统的改变而改变。

  * [Dev channel API reference documentation][apiref]

    [开发渠道 API 参考文档][apiref]

  * [dart-lang/sdk CHANGELOG][]

    [dart-lang/sdk 变更日志][dart-lang/sdk CHANGELOG]

### Tools

### 工具

* Pub no longer supports transformers.
  Instead, use the [new build system.][build system]

  Pub 不再支持转换。作为替代，请使用 [新的编译系统。][build system]

* Tools related to web development have changed.

  Web 开发相关的工具已经改变。

  * The new build system [replaces `pub build` and `pub serve`.][build_runner web]

    新的编译系统 [替代 `pub build` 和 `pub serve`。][build_runner web]

  * Dartium is no longer supported. Instead, use [dartdevc][] and Chrome.

    Dartium 不再支持。作为替代，使用 [dartdevc][] 和 Chrome。


## Migrating your code {#migration}

## 迁移你的代码 {#migration}

How to migrate your code depends on how old your code is
and what platforms it runs on.
For help with migrating web apps,
see the [web app migration guide.][webdev dart2]
If you're migrating a Flutter app,
consult the [breaking change notification.][Leaf's email]
If you publish packages,
then in addition to making platform-specific changes,
follow the [package migration instructions below](#migrating-packages).

如何迁移你的代码取决于你的代码有多古老以及运行在什么平台。
有关如何迁移 Web 应用的帮助请查阅 [ Web 应用迁移指南][webdev dart2]。
如果你迁移一个 Flutter 应用，
请查阅 [变革公告][Leaf's email] 如果你发布了 package，
则除了适配平台不同的特性之外，
还需要遵循 [下述的 package 迁移说明](#migrating-packages)。

### General process

### 通用流程

Here's an overview of the process of migrating to Dart 2,
from either Dart 1.x or an earlier version of Dart 2.

下面是迁移到 Dart 2 的一个流程概述。

1. **Get an up-to-date version of the Flutter or Dart SDK
   and the plugins for any IDEs you use.**

   **获取一个最新的 Flutter 或 Dart SDK 版本以及你所使用的 IDE 的最新插件。**

   * [Flutter SDK upgrade instructions][Flutter SDK upgrade]

     [Flutter SDK 升级说明][Flutter SDK upgrade]

   * [Dart SDK instructions][Dart SDK install] (server-side or web)

     [Dart SDK 说明][Dart SDK install] (服务端或 Web)

2. **Upgrade the packages your app depends on.**

   **升级你应用依赖的 package。**

   * Flutter: [`flutter pub upgrade`][flutter pub upgrade]

     Flutter：[`flutter pub upgrade`][flutter pub upgrade]

   * Server-side or web: [`pub upgrade`][pub upgrade]

     服务端或 Web：[`pub upgrade`][pub upgrade]

3. **Run the [dart2_fix tool.][dart2_fix]** It helps migrate some
   usages of deprecated Dart 1.x APIs to Dart 2.

   **运行 [dart2_fix 工具][dart2_fix]** 它可以帮助迁移一些过时的 Dart 1.x API 到 Dart 2。

4. **Run the analyzer** to find [compile-time errors][]
   and deprecation hints.

   **运行分析器**以找出 [编译时错误][compile-time errors] 以及弃用提示。

   * Flutter: [`flutter analyze`][Flutter analyzer]
     or use the problems view in Android Studio/IntelliJ or VS Code.

     Flutter：[`flutter analyze`][Flutter analyzer]
     或使用 Android Studio/IntelliJ 或 VS Code 的问题视图。

   * Server-side or web: [`dartanalyzer`][dartanalyzer]

     服务端或 Web：[`dartanalyzer`][dartanalyzer]

5. **Fix issues in your code and run the analyzer again**,
   repeating until your code passes static analysis.

   **修复代码问题并再次运行分析器**，重复该操作直到你的代码通过静态分析。

6. **Run tests to find [runtime errors][].**

   **运行测试以找出 [运行时错误][runtime errors]**

   * Run all [automated tests] for your software.

     运行你软件所有的 [自动化测试]。

   * Do manual testing, and look for console errors.

     执行手动测试以查找控制台错误。

   Consider adding automated tests to catch issues that you find.

   考虑添加自动化测试来捕获你发现的问题。

7. **Fix issues until your code works.**

   **修复问题知道你的代码可以正常运行。**

8. _Optional:_ **Remove `new` and unnecessary `const`.**

   **可选的：** **移除 `new` 以及不必要的 `const` 关键字。**

   * You can remove these by hand or use a tool such as `dart format --fix`.

     你可以手动地移除它们或者使用类似 `dart format --fix` 这样的工具。

   * To find occurrences of `new` and unnecessary `const`, add the rules
     `unnecessary_new` and `unnecessary_const` to the `linter` section of your
     [analysis options file][].

     为了找到 `new` 和不必要的 `const` 出现的地方，
     可以将 `unnecessary_new` 和 `unnecessary_const` 
     规则添加至 [分析选项文件][analysis options file] 的 `linter` 部分。

### Migrating packages

### 迁移 package

As a package owner, you need to do the following:

作为一个 package 的拥有者，你需要遵循下列几项：

* Follow the migration tips for the platforms that your package supports
  (see [above](#migration)).

  遵循你的 package 所支持的平台的迁移技巧（详见 [上述](#migration)）。

* Make sure your package passes Dart 2 analysis (see **Run the analyzer** above)

  确保你的 package 通过了 Dart 2 分析（查阅上面的**运行分析器**）。

* Make sure your package's users know how to report issues.

  确保你 package 的使用者知道如何上报问题。

* Respond quickly to issue reports.

  能够对上报的问题快速地作出响应。

* If code changes aren't backward compatible,
  update the lower SDK constraint.

  如果代码的变更导致无法向后兼容，请升级最低的 SDK 版本限制。

#### Changes and backward compatibility

#### 变化以及向后兼容性

If you have to change your package's code,
**try to make it work in 1.x**, as well as Dart 2.
For example, you might be able to add type annotations
or (if an API has been removed) to use an alternative 1.x API.

如果你必须更改 package 的代码，请 **尝试令其可以在 1.x 中使用**，
就像其在 Dart 2 中使用那样。
例如，你可能需要添加类型注解（或者如果一个已被移除的 API）
去使用一个替代的 1.x API。

If a backward-compatible change isn't possible,
**update the lower [SDK constraint.][SDK constraints]**

如果代码的变更导致无法向后兼容，请**升级最低的 [SDK 限制][SDK constraints]**

[Test your changes][testing] to make sure that your package works as expected.

[测试你代码的变更][testing] 以确保你的 package 在使用时可以如你所愿地运行。

#### Upper constraints on the SDK version {#upper-constraint}

#### SDK 版本上限 {#upper-constraint}

Once your package passes Dart 2 analysis, update the upper constraint
to declare that the package is compatible with Dart 2:

一旦你的 package 通过了 Dart 2 分析，
请更新版本上限以表明其支持兼容到 Dart 2：

```yaml
environment:
  # 只能在 Dart 2 中使用
  sdk: '>=2.0.0 <3.0.0'
```

If you plan to maintain compatibility with older versions of Dart, adjust the
lower SDK constraint accordingly:

如果你计划保持与旧版 Dart 的兼容性，
请相应地调整 SDK 为较低的版本限制：

```yaml
environment:
  # 可以在 Dart 1（1.20.1 开始）以及 Dart 2 中使用。
  sdk: '>=1.20.1 <3.0.0'
```

If you use [features introduced after 2.0,][dart-lang/sdk CHANGELOG]
be sure to specify the correct lower SDK constraint:

如果你使用 [2.0 后引入的功能][dart-lang/sdk CHANGELOG] 请确保你指定了正确的 SDK 下限：

```yaml
environment:
  # 可以在 2.1 中使用但不能在 2.0 中使用
  sdk: '>=2.1.0 <3.0.0'
```

<aside class="alert alert-warning" markdown="1">
  **Packages must have an upper constraint of `<3.0.0`** to work in
  Dart 2 stable and subsequent Dart 2 releases.
  Dart 2 dev builds _before_ the stable release have
  lax upper constraint checking and can use packages that have
  no SDK constraints or an upper constraint of `<2.0.0`.

**Package 版本必须有 `<3.0.0` 的上限限制**
以便在 Dart 2 稳定版以及随后的发行版中使用。
Dart 2 在构建编译稳定发行版前的开发版本时有较为宽松的上限限制检查，
你可以在此情况下使用没有 SDK 限制或者上限限制 `<2.0.0` 的 package。
</aside>

## More resources

## 更多资源

* [DartPad](/tools/dartpad)

  [DartPad](/tools/dartpad)

* [Dart Language Specification][]

  [Dart 语言规范][Dart Language Specification]

* [About Dart SDK release channels and version strings][prerelease]

  [关于 Dart SDK 发布渠道和版本字符串][prerelease]

* [SDK constraints][]

  [SDK 限制][SDK constraints]

* [Updating your pub package to Dart 2,][]
  an article that includes tips for updating your code and
  using Travis to perform continuous integration (CI) testing

  [更新你的 pub package 到 Dart 2][Updating your pub package to Dart 2,]，
  这篇文章包含了更新代码和使用 Travis 执行可持续集成 (CI) 测试的技巧。

[analysis options file]: /guides/language/analysis-options#the-analysis-options-file
[dartdevc]: /tools/dartdevc
[build system]: https://github.com/dart-lang/build/tree/master/docs
[automated tests]: /guides/testing
[customize static analysis]: /guides/language/analysis-options
[Flutter analyzer]: {{site.flutter}}/docs/testing/debugging#the-dart-analyzer
[dartanalyzer]: /tools/dart-analyze
[flutter pub upgrade]: {{site.flutter}}/docs/development/packages-and-plugins/using-packages#updating-package-dependencies
[pub upgrade]: /guides/packages#upgrading-a-dependency
[dart2_fix]: https://github.com/dart-lang/dart2_fix
[angular-examples repos]: https://github.com/angular-examples
[apiref]: {{site.dart_api}}/dev
[assert statements]: /guides/language/language-tour#assert
[build_runner web]: /tools/build_runner
[compile-time errors]: /guides/language/sound-problems#static-errors-and-warnings
[creating library packages]: /guides/libraries/create-library-packages
[Dart 2 announcement]: https://medium.com/dartlang/announcing-dart-2-80ba01f43b6
[Dart Language Specification]: /guides/language/spec
[dart-lang/sdk CHANGELOG]: https://github.com/dart-lang/sdk/blob/master/CHANGELOG.md#200
[Dartium news]: {{site.group}}/2017/06/a-stronger-dart-for-everyone.html
[Fixing Common Type Problems]: /guides/language/sound-problems
[Flutter SDK upgrade]: {{site.flutter}}/docs/development/tools/sdk/upgrading
[Dart SDK install]: /get-dart
[Leaf's email]: https://groups.google.com/d/msg/flutter-dev/H8dDhWg_c8I/_Ql78q_6AgAJ
[newsletters]: https://github.com/dart-lang/sdk/tree/master/docs/newsletter#dart-language-and-library-newsletters
[prerelease]: /get-dart#release-channels
[runtime errors]: /guides/language/sound-problems#runtime-errors
[SDK constraints]: /tools/pub/pubspec#sdk-constraints
[sound Dart]: /guides/language/type-system
[testing]: /guides/testing
[Updating your pub package to Dart 2,]: https://medium.com/@filiph/updating-your-pub-package-to-dart-2-cd8ca343b1be
[Using constructors]: /guides/language/language-tour#using-constructors
[webdev dart2]: /web/dart-2
[sync async start]: https://github.com/dart-lang/sdk/blob/master/docs/newsletter/20170915.md#synchronous-async-start
