---
# title: Dart testing
title: Dart 里的测试
# shortTitle: Testing
shortTitle: 测试
# description: How to test Flutter, web, and VM applications.
description: 如何测试 Flutter、Web 和 Dart 应用。
ai-translated: true
---

Software testing, an important part of app development, helps verify that
your app is working correctly before you release it.
This Dart testing guide outlines several types of testing, and points
you to where you can learn how to test your
[Flutter]({{site.flutter}}), [web](/web),
and [server-side apps and scripts](/server).

软件测试是应用开发的重要部分，
帮助你在发布前确认应用工作正常。
这份 Dart 测试指南概述了几类测试，
并指出可以在哪里学习如何测试
[Flutter]({{site.flutter}})、[Web](/web)
以及 [服务器端应用和脚本](/server)。

You can run tests on the command line
using the [`dart test`][] command
(or, for Flutter apps, [`flutter test`][]).

可以在命令行使用 [`dart test`][] 命令运行测试
（Flutter 应用则使用 [`flutter test`][]）。

[`dart test`]: /tools/dart-test
[`flutter test`]: {{site.flutter-docs}}/reference/flutter-cli

## Kinds of testing

## 测试的种类

The Dart testing docs focus on three kinds of testing, out of the
[many kinds of testing](https://en.wikipedia.org/wiki/Software_testing)
that you might be familiar with: unit, component, and end-to-end
(a form of integration testing). Testing terminology varies,
but these are the terms and concepts that you are likely to
encounter when using Dart technologies:

在你可能熟悉的
[多种测试](https://en.wikipedia.org/wiki/Software_testing) 中，
Dart 测试文档重点介绍三类：单元测试、组件测试和端到端测试
（集成测试的一种形式）。测试术语并不统一，
但使用 Dart 技术时，你很可能会遇到下面这些术语和概念：

* _Unit_ tests focus on verifying the smallest piece of testable
  software, such as a function, method, or class. Your test suites
  should have more unit tests than other kinds of tests.

  **单元** 测试关注可测试软件中最小的一块，
  例如函数、方法或类。测试套件中的单元测试
  应当多于其他类型的测试。

* _Component_ tests (called _widget_ tests in Flutter)
  verify that a component (which usually consists of multiple classes)
  behaves as expected.
  A component test often requires the use of mock objects
  that can mimic user actions, events, perform layout,
  and instantiate child components.

  **组件** 测试（在 Flutter 中称为 **widget** 测试）
  验证一个组件（通常由多个类组成）的行为是否符合预期。
  组件测试常常需要使用模拟对象，
  用来模仿用户操作和事件、执行布局，
  并实例化子组件。

* _Integration_ and _end-to-end_ tests verify the behavior of
  an entire app, or a large chunk of an app. An integration test
  generally runs on a simulated or real device
  or on a browser (for the web) and consists of two pieces:
  the app itself, and the test app that puts
  the app through its paces. An integration test often measures performance,
  so the test app generally runs on a different device or OS
  than the app being tested.

  **集成** 测试和 **端到端** 测试验证整个应用
  或应用中很大一块的行为。集成测试通常在模拟设备、真机
  或浏览器（针对 Web）上运行，并由两部分组成：
  应用本身，以及让应用按流程跑起来的测试应用。
  集成测试常常会测量性能，
  因此测试应用一般运行在与被测应用不同的设备或操作系统上。

## Generally useful libraries

## 通常有用的库

Although your tests partly depend on the platform your code is intended
for—Flutter, the web, or server-side, for example—the
following packages are useful across Dart platforms:

虽然测试在一定程度上取决于代码的目标平台
（例如 Flutter、Web 或服务器端），
下列 package 在各种 Dart 平台上都有用：

* [package:test]({{site.pub-pkg}}/test)<br>
  Provides a standard way of writing tests in Dart. You can use the test
  package to:

  提供在 Dart 中编写测试的标准方式。可以用 test
  package 来：

    * Write single tests, or groups of tests.

      编写单个测试或一组测试。

    * Use the `@TestOn` annotation to restrict tests to run on
      specific environments.

      使用 `@TestOn` 注解，把测试限制在特定环境中运行。

    * Write asynchronous tests just as you would write synchronous
      tests.

      像编写同步测试一样编写异步测试。

    * Tag tests using the `@Tag` annotation. For example, define a tag to
      create a custom configuration for some tests, or to identify some tests
      as needing more time to complete.

      使用 `@Tag` 注解为测试打标签。例如，定义一个标签，
      为部分测试创建自定义配置，或标出需要更长时间才能完成的测试。

    * Create a `dart_test.yaml` file to configure tagged tests across
      multiple files or an entire package.

      创建 `dart_test.yaml` 文件，
      在多个文件或整个 package 中配置带标签的测试。


* [package:mockito]({{site.pub-pkg}}/mockito)<br>
  Provides a way to create
  [mock objects,](https://en.wikipedia.org/wiki/Mock_object)
  easily configured for use in fixed scenarios, and to verify
  that the system under test interacts with the mock object in
  expected ways.
  For an example that uses both package:test and package:mockito,
  see the [International Space Station API library and its unit
  tests]({{site.repo.dart.org}}/mockito/tree/master/example/iss)
  in the [mockito package]({{site.repo.dart.org}}/mockito).

  提供一种创建
  [模拟对象](https://en.wikipedia.org/wiki/Mock_object) 的方式，
  便于在固定场景中配置，并验证被测系统
  是否以预期方式与模拟对象交互。
  同时使用 package:test 和 package:mockito 的例子，
  见 [mockito package]({{site.repo.dart.org}}/mockito) 中的
  [国际空间站 API 库及其单元测试]({{site.repo.dart.org}}/mockito/tree/master/example/iss)。

## Flutter testing

## Flutter 测试

Use the following resources to learn more about testing Flutter apps:

使用下列资源进一步了解如何测试 Flutter 应用：

* [Testing Flutter Apps]({{site.flutter-docs}}/testing)<br>
  How to perform unit, widget, or integration tests on a Flutter app.

  [测试 Flutter 应用]({{site.flutter-docs}}/testing)<br>
  如何对 Flutter 应用进行单元测试、widget 测试或集成测试。

* [flutter_test]({{site.flutter-api}}/flutter/flutter_test/flutter_test-library.html)<br>
  A testing library for Flutter built on top of package:test.

  [flutter_test]({{site.flutter-api}}/flutter/flutter_test/flutter_test-library.html)<br>
  构建在 package:test 之上的 Flutter 测试库。

* [flutter_driver]({{site.flutter-api}}/flutter/flutter_driver/flutter_driver-library.html)<br>
  A testing library for testing Flutter applications on real devices and
  emulators (in a separate process).

  [flutter_driver]({{site.flutter-api}}/flutter/flutter_driver/flutter_driver-library.html)<br>
  用于在真机和模拟器上测试 Flutter 应用的库（在单独的进程中）。

* [flutter_gallery](https://github.com/flutter/gallery)<br>
  Source code and tests for the Flutter gallery example.

  [flutter_gallery](https://github.com/flutter/gallery)<br>
  Flutter gallery 示例的源代码和测试。

* [flutter/dev/manual_tests](https://github.com/flutter/flutter/tree/master/dev/manual_tests)<br>
  Many examples of tests in the Flutter SDK.

  [flutter/dev/manual_tests](https://github.com/flutter/flutter/tree/master/dev/manual_tests)<br>
  Flutter SDK 中的许多测试示例。

## Other tools and resources

## 其他工具和资源

You might also find the following resources useful for
developing and debugging Dart applications.

开发和调试 Dart 应用时，下列资源可能也有用。

### IDE

### IDE 工具

When it comes to debugging, your first line of defense is your IDE.
Dart plugins exist for many [commonly used IDEs](/tools#editors).

说到调试，第一道防线就是 IDE。
许多 [常用 IDE](/tools#editors) 都有 Dart 插件。

### Dart DevTools

### Dart DevTools 工具

Dart DevTools is a suite of performance tools for Dart and Flutter.
For details, see the
[Dart DevTools documentation.](/tools/dart-devtools)

Dart DevTools 是一套面向 Dart 和 Flutter 的性能工具。
详情见
[Dart DevTools 文档](/tools/dart-devtools)。


### Continuous integration

### 持续集成

Consider using continuous integration (CI) to build your project
and run its tests after every commit. Two CI services for GitHub are
[GitHub Actions](https://github.com/features/actions) and
[AppVeyor](https://www.appveyor.com/).

可以考虑使用持续集成（CI），在每次提交后构建项目并运行测试。
面向 GitHub 的两种 CI 服务是
[GitHub Actions](https://github.com/features/actions) 和
[AppVeyor](https://www.appveyor.com/)。

Learn more about GitHub Actions:

进一步了解 GitHub Actions：

* Many packages provided by the Dart team use GitHub Actions.
  For an example, see
  [`markdown.yaml`][markdown-ci] in the markdown package's repo.
  To see how that repo migrated from Travis CI to GitHub Actions,
  look at [PR #353]({{site.repo.dart.org}}/markdown/pull/353).

  Dart 团队提供的许多 package 都使用 GitHub Actions。
  例子见 markdown package 仓库中的
  [`markdown.yaml`][markdown-ci]。
  该仓库如何从 Travis CI 迁移到 GitHub Actions，
  见 [PR #353]({{site.repo.dart.org}}/markdown/pull/353)。

[markdown-ci]: {{site.repo.dart.org}}/tools/blob/main/.github/workflows/markdown.yaml
