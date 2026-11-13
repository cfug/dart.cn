---
# title: "Announcing Windows support for Dart on Travis CI"
title: "宣布 Travis CI 上的 Dart 支持 Windows"
# description: "Today, we’re announcing that Travis CI on Windows supports the Dart SDK, so you can run Dart build and test jobs on all major desktop OS’s."
description: "今天我们宣布 Windows 版 Travis CI 支持 Dart SDK，你可以在所有主流桌面操作系统上运行 Dart 构建和测试任务了。"
ai-translated: true
publishDate: 2019-04-15
author: mit-mit
image: images/1Zh0PvesZNUKCljlerYe4Sg.webp
category: announcements
layout: blog
---


Recently, [Travis CI](https://travis-ci.com/) — a continuous integration (CI) service for GitHub repos — [announced](https://blog.travis-ci.com/2018-10-11-windows-early-release) early release support for the Windows operating system. Today, we’re announcing that Travis CI on Windows supports the Dart SDK, so you can run Dart build and test jobs on all three major desktop operating systems: Linux, Mac, and Windows.

最近，[Travis CI](https://travis-ci.com/)——面向 GitHub 仓库的持续集成（CI）服务——[宣布](https://blog.travis-ci.com/2018-10-11-windows-early-release)了对 Windows 操作系统的早期版本支持。今天我们宣布，Windows 版 Travis CI 支持 Dart SDK，你可以在三大桌面操作系统——Linux、Mac 和 Windows——上运行 Dart 构建和测试任务了。

<DashImage src="images/1Zh0PvesZNUKCljlerYe4Sg.webp" alt="Announcement graphic for Windows support for Dart on Travis CI, showing successful build jobs for Linux, macOS, and Windows." />


### Configuring Travis CI jobs for multiple operating systems

### 为多个操作系统配置 Travis CI 任务

If you already use Travis CI to build or test your Dart code, you can easily run your jobs on all three operating systems. Just add (or extend) the `os:` section in your repo’s `.travis.yml` file:

如果你已经在用 Travis CI 构建或测试 Dart 代码，可以轻松地在全部三个操作系统上运行任务。只需在仓库的 `.travis.yml` 文件中添加（或扩展）`os:` 部分：

```
os:
- linux
- osx
- windows
```


Then, whenever Travis CI runs, you’ll see entries for each test configuration running on each of the enabled operating systems. Here’s [an example](https://travis-ci.org/grpc/grpc-dart/builds/517691491) from the [grpc-dart](https://github.com/grpc/grpc-dart) repo, after we [added Windows](https://github.com/grpc/grpc-dart/commit/0cbc5401c82500bf20b89654c4adbde355dcc8d3) to the test matrix:

之后每次 Travis CI 运行时，你都会看到每个测试配置在每个启用的操作系统上运行的条目。这是 [grpc-dart](https://github.com/grpc/grpc-dart) 仓库在我们[把 Windows 加入](https://github.com/grpc/grpc-dart/commit/0cbc5401c82500bf20b89654c4adbde355dcc8d3)测试矩阵后的[一个例子](https://travis-ci.org/grpc/grpc-dart/builds/517691491)：

<DashImage src="images/0wegLWjqUZkUfufxl.webp" alt="Travis CI test matrix running on Linux, macOS, and Windows." caption="Travis CI test matrix run on Linux, MacOS, and Windows" />


Because Windows support on Travis CI is still in an early release stage, we recommend that you review the [known issues](https://travis-ci.community/t/current-known-issues-please-read-this-before-posting-a-new-topic/264) before adding Windows to your Travis jobs.

由于 Travis CI 的 Windows 支持仍处于早期发布阶段，我们建议你在把 Windows 加入 Travis 任务之前先查看[已知问题](https://travis-ci.community/t/current-known-issues-please-read-this-before-posting-a-new-topic/264)。

### Adding Travis CI test support to a project

### 为项目添加 Travis CI 测试支持

If you don’t yet use Travis CI for testing Dart, it’s really easy to get started. The most minimal `.travis.yml` file contains just one line:

如果你还没用 Travis CI 测试 Dart，上手非常简单。最精简的 `.travis.yml` 文件只有一行：

```
language: dart
```


This config is the equivalent of `pub run test`.

这个配置等价于 `pub run test`。

List any additional tasks under the `dart_task:` tag. These include running static analysis and code formatting checks (for full details, see the [Travis documentation](https://docs.travis-ci.com/user/languages/dart/)).

在 `dart_task:` 标签下列出其他任务，包括运行静态分析和代码格式检查（完整细节见 [Travis 文档](https://docs.travis-ci.com/user/languages/dart/)）。

Here’s how to run static analysis, which checks your code for analysis errors:

下面是运行静态分析的方法，它会检查代码中的分析错误：

```
language: dart
dart_task:
- dartanalyzer
```


Here’s how to make sure that all Dart files are correctly formatted:

下面是确保所有 Dart 文件格式正确的方法：

```
language: dart
dart_task:
- dartfmt
```


If you have a more complicated repo with multiple Dart packages, you need a slightly more detailed setup. The `travis` command in the [mono_repo tool](https://pub.dartlang.org/packages/mono_repo) is one possible solution for creating this setup.

如果你的仓库更复杂、包含多个 Dart package，就需要稍微详细一点的配置。[mono_repo 工具](https://pub.dartlang.org/packages/mono_repo)中的 `travis` 命令是创建这种配置的一个可行方案。

### Alternatives to Travis CI

### Travis CI 的替代方案

Travis CI is one of several popular providers of continuous integration. Others with support for the Dart SDK include [AppVeyor](https://www.appveyor.com/) ([sample](https://github.com/dart-lang/dartdoc/blob/master/appveyor.yml)) and [Codeship](https://documentation.codeship.com/basic/languages-frameworks/dart/). For [Flutter](https://flutter.dev/) apps, options include [NeverCode](https://developer.nevercode.io/docs/building-flutter-apps), [CirrusCI](https://cirrus-ci.org/examples/#flutter), and [Bitrise](https://devcenter.bitrise.io/getting-started/getting-started-with-flutter-apps/).

Travis CI 是几家热门持续集成服务商之一。其他支持 Dart SDK 的还有 [AppVeyor](https://www.appveyor.com/)（[示例](https://github.com/dart-lang/dartdoc/blob/master/appveyor.yml)）和 [Codeship](https://documentation.codeship.com/basic/languages-frameworks/dart/)。对于 [Flutter](https://flutter.dev/) 应用，可选项包括 [NeverCode](https://developer.nevercode.io/docs/building-flutter-apps)、[CirrusCI](https://cirrus-ci.org/examples/#flutter) 和 [Bitrise](https://devcenter.bitrise.io/getting-started/getting-started-with-flutter-apps/)。

That’s it for now. We hope you enjoy this new CI support for Dart.

这次就到这里。希望你喜欢 Dart 的这项新 CI 支持。
