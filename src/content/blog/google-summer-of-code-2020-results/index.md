---
# title: "Google Summer of Code 2020 results"
title: "Google Summer of Code 2020 成果"
# description: "The Dart team mentored 5 student developers this summer, as part of GSoC 2020. Read about the student projects."
description: "作为 GSoC 2020 的一部分，Dart 团队今年夏天指导了 5 名学生开发者。来读读他们的项目吧。"
ai-translated: true
publishDate: 2020-09-02
author: jonasfj
image: images/15VxyyQ1juWjwtTbSkwzzXA.webp
category: other
layout: blog
---


<DashImage src="images/15VxyyQ1juWjwtTbSkwzzXA.webp" alt="The Google Summer of Code logo." />


[Google Summer of Code (GSoC)](https://summerofcode.withgoogle.com/) is a global program focused on bringing student developers into open source software development. Students are sponsored by Google to work with a mentoring open source organization on a 3-month programming project during the summer.

[Google Summer of Code（GSoC）](https://summerofcode.withgoogle.com/)是一项全球性计划，致力于把学生开发者带入开源软件开发。Google 资助学生在暑期与一个担任指导的开源组织合作，完成一个为期 3 个月的编程项目。

In [February we were thrilled to announce](/blog/students-join-a-dart-project-for-google-summer-of-code-2020) that the Dart team would be a mentoring organization in GSoC 2020. We ended up [mentoring 5 projects](https://summerofcode.withgoogle.com/organizations/6544944065413120/), picked from more than 170 applications from students around the world. Today we’re excited to share our results, as described by the students who worked on the projects.

[二月份我们激动地宣布](/blog/students-join-a-dart-project-for-google-summer-of-code-2020)，Dart 团队将成为 GSoC 2020 的指导组织。我们最终从世界各地学生的 170 多份申请中挑选并[指导了 5 个项目](https://summerofcode.withgoogle.com/organizations/6544944065413120/)。今天，我们很高兴由参与项目的学生亲自讲述他们的成果。

### Generating dart:ffi bindings for Dart-C interop with package:ffigen

### 用 package:ffigen 生成 dart:ffi 绑定，实现 Dart 与 C 互操作

*By Prerak Mann*

*作者：Prerak Mann*

[package:ffigen](https://pub.dev/packages/ffigen) is an FFI generator that greatly reduces the effort of using `dart:ffi` by generating Dart bindings from C header files (`.h`).

[package:ffigen](https://pub.dev/packages/ffigen) 是一个 FFI 生成器，它从 C 头文件（`.h`）生成 Dart 绑定，大大减少了使用 `dart:ffi` 的工作量。

To understand the need for this tool, consider [LibClang](https://clang.llvm.org/doxygen/group__CINDEX.html) (the C interface to Clang). LibClang’s [API](https://github.com/dart-lang/ffigen/tree/master/third_party/libclang/include/clang-c) is about 8,000 lines of code (LOC). If you were to write Dart [bindings for LibClang](https://github.com/dart-lang/ffigen/blob/master/example/libclang-example/generated_bindings.dart) by hand, you’d need almost 4,500 LOC. With `package:ffigen`, all you need to do is pass in a [small YAML configuration file](https://github.com/dart-lang/ffigen/blob/master/example/libclang-example/pubspec.yaml#L14) that’s less than 20 LOC, and then you can generate the bindings.

要理解为什么需要这个工具，可以看看 [LibClang](https://clang.llvm.org/doxygen/group__CINDEX.html)（Clang 的 C 接口）。LibClang 的 [API](https://github.com/dart-lang/ffigen/tree/master/third_party/libclang/include/clang-c) 约有 8,000 行代码。如果手写 [LibClang 的 Dart 绑定](https://github.com/dart-lang/ffigen/blob/master/example/libclang-example/generated_bindings.dart)，你需要写将近 4,500 行。而用 `package:ffigen`，你只需传入一个不到 20 行的[小型 YAML 配置文件](https://github.com/dart-lang/ffigen/blob/master/example/libclang-example/pubspec.yaml#L14)，就能生成这些绑定。

You can control which C functions to generate, and use simple regular expressions to rename macros, enums, and individual struct members. You can also [generate array](https://github.com/dart-lang/ffigen#array-workaround) members nested in structs (which are not fully supported in `dart:ffi` yet).

你可以控制生成哪些 C 函数，并用简单的正则表达式重命名宏、枚举和单个结构体成员。你还可以[生成结构体中嵌套的数组](https://github.com/dart-lang/ffigen#array-workaround)成员（`dart:ffi` 尚未完全支持这类成员）。

Check out [github.com/dart-lang/ffigen](https://github.com/dart-lang/ffigen) for a complete list of [configurations](https://github.com/dart-lang/ffigen#configurations), [FAQs](https://github.com/dart-lang/ffigen#faq), [examples](https://github.com/dart-lang/ffigen/blob/master/example/), and more.

请访问 [github.com/dart-lang/ffigen](https://github.com/dart-lang/ffigen) 查看完整的[配置项](https://github.com/dart-lang/ffigen#configurations)、[常见问题](https://github.com/dart-lang/ffigen#faq)、[示例](https://github.com/dart-lang/ffigen/blob/master/example/)等内容。

### Learn testing with a new Flutter sample

### 通过新的 Flutter 示例学习测试

*By Abdullah Deshmukh*

*作者：Abdullah Deshmukh*

Have you been using Flutter for a while but still haven’t figured out how to test Flutter apps? Then you might be interested in the sample that we built to demonstrate best practices for testing Flutter apps. You’ll be able to learn testing in Flutter in a quick and easy way.

你已经用了一段时间 Flutter，却还没搞清楚怎么测试 Flutter 应用？那你可能会对我们为演示 Flutter 应用测试最佳实践而构建的示例感兴趣。你能以快速简单的方式学会 Flutter 中的测试。

The [sample](https://github.com/flutter/samples/tree/master/testing_app) shows different types of testing including:

这个[示例](https://github.com/flutter/samples/tree/master/testing_app)展示了多种测试类型，包括：

* Unit testing

  单元测试（Unit testing）

* Widget testing

  Widget 测试（Widget testing）

* Integration testing

  集成测试（Integration testing）

* Performance testing

  性能测试（Performance testing）

* State management testing

  状态管理测试（State management testing）

As a bonus, we also built a codelab on how to test Flutter apps. You can see a detailed report of the work done under the project in the article [Learn testing with the new Flutter sample]({{site.flutter-blog}}/learn-testing-with-the-new-flutter-sample-gsoc20-work-product).

额外福利：我们还制作了一个关于如何测试 Flutter 应用的 codelab。你可以在文章 [Learn testing with the new Flutter sample]({{site.flutter-blog}}/learn-testing-with-the-new-flutter-sample-gsoc20-work-product) 中查看该项目工作的详细报告。

### User-extensible translation file formats

### 用户可扩展的翻译文件格式

*By Jaime Blasco*

*作者：Jaime Blasco*

The [intl_translation](https://pub.dev/packages/intl_translation) package supports only the ARB file format, which is not widely used outside of Dart. The [intl_translation_format](https://pub.dev/packages/intl_translation_format) package, created during GSoC 2020, builds on intl_translation, adding a `TranslationFormat` class that can support widely varying formats. Developers can add support for additional formats in their own packages and in just a few lines create command-line tools for extraction and generation that integrate with the existing tools. With these, existing translations in other formats, even proprietary ones, can be imported into a Dart project easily and new messages originating in Dart code can be integrated into existing translation tools and workflows.

[intl_translation](https://pub.dev/packages/intl_translation) package 只支持 ARB 文件格式，而这种格式在 Dart 之外并不常用。GSoC 2020 期间创建的 [intl_translation_format](https://pub.dev/packages/intl_translation_format) package 基于 intl_translation 构建，新增了能支持各种不同格式的 `TranslationFormat` 类。开发者可以在自己的 package 中添加对其他格式的支持，只需几行代码就能创建与现有工具集成的提取和生成命令行工具。有了这些，其他格式（甚至是专有格式）的现有翻译可以轻松导入 Dart 项目，Dart 代码中新产生的消息也能接入现有的翻译工具和工作流。

As a demonstration of these capabilities, the new packages include support for several formats. In addition to ARB, it supports **XLIFF v1.2 (iOS), XLIFF v2.0,** and **JSON with ICU** messages. [Experimental libraries](https://github.com/jamesblasco/intl_translation_format_experiments) show how support for other formats, and even translations that can be updated at runtime, could be implemented.

作为这些能力的演示，新 package 内置了对多种格式的支持。除 ARB 外，还支持 **XLIFF v1.2（iOS）、XLIFF v2.0** 以及带 **ICU** 消息的 **JSON**。[实验性库](https://github.com/jamesblasco/intl_translation_format_experiments)展示了如何实现对其他格式的支持，甚至支持可在运行时更新的翻译。

### Platform channels in a mobile app and a federated plugin

### 移动应用与联合插件中的平台通道

*By Ayush Bherwani*

*作者：Ayush Bherwani*

After researching platform channels (the Flutter API for sending messages back and forth from Dart to native code like Swift or Kotlin), we decided to cover the topic with two different samples. One is a [straightforward Android and iOS demo](https://github.com/flutter/samples/tree/master/platform_channels), while the other is a [federated plugin](https://github.com/flutter/samples/tree/master/experimental/federated_plugin) capable of building with the master channel for web and desktop as well. Between the two samples, the codebase shows off not only the details of platform channels and the codecs that can be used to move data, but also the APIs for federated plugins and techniques for calling native code on web and desktop (Windows and Linux) APIs.

在研究了平台通道（Flutter 中用于在 Dart 与 Swift、Kotlin 等原生代码之间来回传递消息的 API）之后，我们决定用两个不同的示例来涵盖这个主题。一个是[简单直接的 Android 和 iOS 演示](https://github.com/flutter/samples/tree/master/platform_channels)，另一个是[联合插件](https://github.com/flutter/samples/tree/master/experimental/federated_plugin)，还能用 master 渠道为 Web 和桌面构建。这两个示例的代码不仅展示了平台通道的细节和可用于传输数据的编解码器，还展示了联合插件的 API，以及在 Web 和桌面（Windows 和 Linux）上调用原生 API 的技巧。

If you’re a developer looking to build a plugin or just access a platform API, these samples are a great place to get started learning. For more information about this project, see the article [Platform channel examples]({{site.flutter-blog}}/platform-channel-examples).

如果你想开发插件，或者只是想访问平台 API，这些示例都是很好的学习起点。关于这个项目的更多信息，请参阅文章 [Platform channel examples]({{site.flutter-blog}}/platform-channel-examples)。

### Writing package:yaml_edit to enable `pub add &lt;package&gt;`

### 编写 package:yaml_edit 以支持 `pub add &lt;package&gt;`

*By Garett Tok Ern Liang*

*作者：Garett Tok Ern Liang*

Dart projects specify package dependencies in a `pubspec.yaml` file. [YAML](https://yaml.org/spec/1.2/spec.html) is great because it allows us to write comments, but programmatically modifying YAML is a challenge.

Dart 项目在 `pubspec.yaml` 文件中指定 package 依赖。[YAML](https://yaml.org/spec/1.2/spec.html) 很棒，因为它允许我们写注释，但以编程方式修改 YAML 却是个挑战。

To tackle this challenge, we wrote [`package:yaml_edit`](https://pub.dev/packages/yaml_edit) to easily perform context-aware string manipulations that preserve formatting and comments. The test suite for the package contains more than 40,000 tests, and we think we have a pretty good solution working. Play with it and [file bugs](https://github.com/google/dart-neats/issues)!

为了应对这个挑战，我们编写了 [`package:yaml_edit`](https://pub.dev/packages/yaml_edit)，可以轻松执行保留格式和注释的上下文感知字符串操作。这个 package 的测试套件包含超过 40,000 个测试，我们认为已经有了一个相当不错的方案。快来试试并[提交 bug](https://github.com/google/dart-neats/issues) 吧！

Using `package:yaml_edit`, we added a new `pub add &lt;package&gt;` subcommand to `pub`, the package management tool for Dart and Flutter. `pub add` automatically resolves for the latest compatible version of the target package and adds it to a user’s `pubspec.yaml`. To put this into perspective, `pub add &lt;package&gt;` automates the tedium of having to do all of the following:

借助 `package:yaml_edit`，我们为 Dart 和 Flutter 的 package 管理工具 `pub` 添加了新的 `pub add &lt;package&gt;` 子命令。`pub add` 会自动解析目标 package 的最新兼容版本，并把它加入用户的 `pubspec.yaml`。具体来说，`pub add &lt;package&gt;` 把下面这些繁琐步骤自动化了：

1. Visiting `https://pub.dev/packages/<package>`

  访问 `https://pub.dev/packages/<package>`

1. Choosing a version to add to your package

  选择要添加到你 package 的版本

1. Modifying `pubspec.yaml`

  修改 `pubspec.yaml`

1. Running `pub get`

  运行 `pub get`

1. Repeating steps 2-4 as many times as needed to get a version compatible with your other dependencies

  按需重复第 2–4 步，直到找到与其他依赖兼容的版本

A similar command that removes dependencies — `pub remove &lt;package&gt;`— is also in the works. Keep your eyes peeled for these two commands coming to `pub` soon!

一个移除依赖的类似命令——`pub remove &lt;package&gt;`——也在开发中。敬请期待这两个命令很快登陆 `pub`！
> Huge thanks to everyone who applied for Google Summer of Code 2020 with Dart, and to the students who completed projects this year, and to the mentors who spent time every week to make this an awesome summer of code. We hope to see many of you students again as contributors throughout the Dart ecosystem.

> 衷心感谢所有申请 Dart Google Summer of Code 2020 的同学、今年完成项目的学生，以及每周投入时间打造这个精彩编程之夏的导师们。希望今后能在整个 Dart 生态中再次见到你们这些同学作为贡献者的身影。
