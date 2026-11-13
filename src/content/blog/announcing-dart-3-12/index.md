---
# title: "Announcing Dart 3.12"
title: "宣布 Dart 3.12"
# description: "Supercharging developer productivity at Google I/O 2026"
description: "在 Google I/O 2026 为开发者生产力注入强劲动力"
ai-translated: true
publishDate: 2026-05-20
author: conooi
image: images/dart-3-12-cover.webp
category: releases
layout: blog
---

<DashImage src="images/dart-3-12-cover.webp" alt="Dart 3.12 release banner with the Dart logo and a bullseye icon." caption="Announcing Dart 3.12" />

This year at Google I/O 2026, the Flutter and Dart teams are celebrating a powerful theme: Everywhere, everyday, built by everyone, for everyone.

今年的 Google I/O 2026 上，Flutter 和 Dart 团队
围绕一个有力的主题庆祝：无处不在、无日不用，
由所有人构建、为所有人服务。

Dart 3.12 brings this theme to life. We are making the language more approachable and productive. Concise new primitives like private named parameters, alongside experimental support for primary constructors, make everyday coding cleaner. But we didn't stop at the syntax level. New features like Agentic Hot Reload and the addition of Genkit to the Dart ecosystem ensure you can build high-performance, AI-ready, and agentic apps that reach users anywhere. This is true whether you code alone or pair-program with an AI agent.

Dart 3.12 让这个主题落地。我们让语言更易上手、更有生产力。
私有命名参数等简洁的新原语，加上主构造函数的实验性支持，
让日常编码更干净。但我们没有止步于语法层面。
Agentic Hot Reload 等新特性，以及 Genkit 加入 Dart 生态，
确保你能构建高性能、AI 就绪、具备 agent 能力的应用，
触达任何地方的用户。无论你是独自编码，
还是与 AI agent 结对编程，都是如此。

So [update Dart](https://dart.dev/get-dart) or run [`flutter upgrade`](https://docs.flutter.dev/install/upgrade) and follow along to explore the new features in Dart 3.12. But remember, a more powerful Dart is only half the story. When you're ready to see how these features translate into beautiful UI, check out the [What's new in Flutter]({{site.flutter-blog}}/whats-new-in-flutter-3-44) blog post.

那就[更新 Dart](https://dart.dev/get-dart) 或运行
[`flutter upgrade`](https://docs.flutter.dev/install/upgrade)，
跟着我们一起探索 Dart 3.12 的新特性。但请记住，
更强大的 Dart 只是故事的一半。当你想看看这些特性
如何转化为漂亮的 UI 时，请查看
[Flutter 新特性]({{site.flutter-blog}}/whats-new-in-flutter-3-44)
博客文章。

## Language updates

## 语言更新

### Private named parameters

### 私有命名参数

Dart's initializing formals, using the `this.` constructor syntax, are incredibly convenient. They map a constructor parameter directly to a class field. This removes the need to write repetitive code.

Dart 使用 `this.` 构造函数语法的初始化形参
（initializing formals）非常方便。
它们把构造函数参数直接映射到类字段，
免去了编写重复代码的需要。

But there was a catch. Initializing formals struggled when combining named parameters with private fields. Before Dart 3.12, the language didn't allow a named parameter to start with an underscore:

但有个问题：初始化形参在命名参数与私有字段组合时
不太好用。在 Dart 3.12 之前，语言不允许命名参数
以下划线开头：

```dart
class Hummingbird {
  final String _petName;
  final int _wingbeatsPerSecond;

  // Compile error! Can't have private named parameter. :(
  Hummingbird({required this._petName, required this._wingbeatsPerSecond});
}
```

Instead, you had to write an explicit initializer list:

你只能改为显式编写初始化列表：

```dart
class Hummingbird {
  final String _petName;
  final int _wingbeatsPerSecond;

  Hummingbird({required String petName, required int wingbeatsPerSecond})
    : _petName = petName,
      _wingbeatsPerSecond = wingbeatsPerSecond;
}
```

This was tedious. All the initializer list is doing is removing the `_`. It added unnecessary boilerplate to simple classes.

这很繁琐。初始化列表做的全部事情就是去掉 `_`，
给简单的类增添了不必要的样板代码。

In Dart 3.12, the language can do that for you. Dart now lets you write private named initializing formals:

在 Dart 3.12 中，语言可以替你做这件事。
Dart 现在允许你编写私有的命名初始化形参：

```dart
class Hummingbird {
  final String _petName;
  final int _wingbeatsPerSecond;

  // OK with "Private Named Parameters"! :D
  Hummingbird({required this._petName, required this._wingbeatsPerSecond});
}
```

This code behaves exactly like the previous example. The initialized fields are private, but constructor parameters and the argument names written at the call site have the corresponding public names:

这段代码的行为与前一个例子完全相同。被初始化的字段
是私有的，但构造函数参数以及调用处写的实参名
使用对应的公开名称：

```dart
void main() {
  print(Hummingbird(petName: 'Dash', wingbeatsPerSecond: 75));
}
```

**Learn more**: [Private named parameters documentation](https://dart.dev/language/constructors#private-named-parameters)

**了解更多**：[私有命名参数文档](https://dart.dev/language/constructors#private-named-parameters)

### Primary constructors (experimental phase) {:#primary-constructors}

### 主构造函数（实验阶段）

We are excited to offer an early look at one of the most requested syntax features in Dart. Primary constructors represent a major step forward for class conciseness. They eliminate the need to repeat field names and types across your class body and parameter lists.

我们很高兴让你抢先体验 Dart 呼声最高的语法特性之一。
主构造函数（primary constructors）是类简洁性的一大步，
消除了跨类体和参数列表重复字段名与类型的需要。

Normally, even a simple two-field class requires multiple lines of repetitive boilerplate:

通常，即使是只有两个字段的简单类，
也需要多行重复的样板代码：

```dart
class Point {
  final int x;
  final int y;
  Point(this.x, this.y);
}
```

Primary constructors change this completely. You can now replace boilerplate with a single line of code by declaring parameters directly within the class header.

主构造函数彻底改变了这一点。现在你可以直接在类头部
声明参数，用一行代码取代样板代码。

```dart
class Point(final int x, final int y);
```

The feature goes further. It introduces a shorter syntax for declaring constructors inside the class body using the `new` or `factory` keywords. It also allows classes with empty bodies to end with a simple semicolon:

这个特性不止于此。它引入了更短的语法，
用 `new` 或 `factory` 关键字在类体内声明构造函数，
还允许空类体的类以一个简单的分号结尾：

```dart
class Pet {
  String name;

  new() : name = 'Fluffy';
  new withName(this.name);
}

class Dog extends Pet;
```

Primary constructors are launching as an experimental preview in Dart 3.12. Because this is a foundational shift in how Dart classes are defined, your real-world feedback is crucial. You can enable the feature using the `primary-constructors` [flag](https://dart.dev/tools/experiment-flags) when running your project:

主构造函数在 Dart 3.12 中以实验性预览的形式推出。
由于这是 Dart 类定义方式的基础性转变，
你的真实使用反馈至关重要。运行项目时，
你可以用 `primary-constructors`
[标志](https://dart.dev/tools/experiment-flags)启用该特性：

```console
dart run --enable-experiment=primary-constructors bin/main.dart
```

If you encounter any issues or have feedback on the design, please file an issue on the [Dart SDK repository](https://github.com/dart-lang/sdk) (and feel free to cc `@kallentu`). We look forward to hearing your thoughts!

如果你遇到任何问题或对设计有反馈，
请在 [Dart SDK 仓库](https://github.com/dart-lang/sdk)提交
issue（欢迎抄送 `@kallentu`）。期待听到你的想法！

**Learn more**: [Primary constructors documentation](https://dart.dev/language/primary-constructors)

**了解更多**：[主构造函数文档](https://dart.dev/language/primary-constructors)

## Ecosystem updates

## 生态更新

### Genkit Dart preview {:#genkit-dart}

### Genkit Dart 预览版

We're excited to announce the preview launch of Genkit Dart, an open-source framework for building full-stack, AI-powered agentic Dart and Flutter apps on any platform. It provides everything you need for AI apps out of the box:

我们很高兴宣布 Genkit Dart 预览版发布。
这是一个开源框架，用于在任何平台上构建全栈、
AI 驱动、具备 agent 能力的 Dart 和 Flutter 应用。
它开箱即用地提供 AI 应用所需的一切：

* **Model-agnostic API:** Supports Google, Anthropic, OpenAI, and OpenAI-compatible models.

  **模型无关的 API：**支持 Google、Anthropic、OpenAI
  以及 OpenAI 兼容模型。
* **Type safety:** Combines Dart's strong type system with the `schematic` package for strongly typed data generation and flows.

  **类型安全：**把 Dart 的强类型系统与 `schematic` package
  结合，实现强类型的数据生成和流程。
* **Run anywhere:** Write AI logic once and run it in a backend service or directly inside your Flutter app.

  **随处运行：**AI 逻辑只写一次，
  既能在后端服务中运行，也能直接在你的 Flutter 应用里运行。
* **Developer UI:** Includes a local web UI to test prompts, view traces, and debug workflows.

  **开发者 UI：**内置本地 Web UI，
  用于测试提示词、查看追踪和调试工作流。
* **Core AI primitives:** Built-in support for structured output, tool calling, and multi-step flows.

  **核心 AI 原语：**内建对结构化输出、工具调用
  和多步骤流程的支持。

Call multiple models in just a few lines of code:

只需几行代码即可调用多个模型：

```dart
import 'package:genkit/genkit.dart';
import 'package:genkit_google_genai/genkit_google_genai.dart';
import 'package:genkit_anthropic/genkit_anthropic.dart';

void main() async {
  final ai = Genkit(plugins: [googleAI(), anthropic()]);

  // Call a Gemini model from Google.
  final geminiResponse = await ai.generate(
    model: googleAI.gemini('gemini-flash-latest'),
    prompt: 'Hello from Gemini',
  );

  // Call a Claude model from Anthropic.
  final claudeResponse = await ai.generate(
    model: anthropic.model('claude-opus-4.6'),
    prompt: 'Hello from Claude',
  );
}
```

Chat with the Genkit team on [Discord](https://discord.gg/qXt5zzQKpc) and report any issues on [GitHub](https://github.com/genkit-ai/genkit-dart).

在 [Discord](https://discord.gg/qXt5zzQKpc) 上与 Genkit
团队交流，任何问题请在
[GitHub](https://github.com/genkit-ai/genkit-dart) 上报告。

**Learn more**: [Get started with Genkit for Dart](https://genkit.dev/docs/dart/get-started/)

**了解更多**：[Genkit for Dart 入门](https://genkit.dev/docs/dart/get-started/)

### Cloud Functions for Firebase and experimental Dart support {:#cloud-functions}

### Cloud Functions for Firebase 与实验性 Dart 支持

We are also thrilled to highlight the recent announcement of experimental support for Dart in Cloud Functions for Firebase. For years, extending a Flutter app to the cloud meant context-switching into other backend languages and duplicating data structures.

我们也很激动地重点介绍最近的宣布：
Cloud Functions for Firebase 实验性支持 Dart。
多年来，把 Flutter 应用扩展到云端意味着
切换到其他后端语言并重复定义数据结构。

Now, you can build a truly unified, full-stack Dart application. By leveraging the "Shared Package" pattern, you can share your data models, validation rules, and business logic directly between your frontend and backend—completely eliminating the "Double-Doc Tax."

现在，你可以构建真正统一的全栈 Dart 应用。
借助“共享 package”（Shared Package）模式，
你可以在前端和后端之间直接共享数据模型、
校验规则和业务逻辑——彻底消除“双重定义税”。

Thanks to Dart's Ahead-of-Time (AOT) compilation, your serverless functions benefit from incredibly fast cold starts, giving you instant scaling and performance without the hassle of Dockerfiles or container configuration.

得益于 Dart 的提前（AOT）编译，你的 serverless 函数
拥有极快的冷启动，带来即时的扩缩容和性能，
无需操心 Dockerfile 或容器配置。

**Learn more**: [Dart and Firebase blog post](https://dart.dev/blog/flutter-missing-link-why-full-stack-dart-changes-everything).

**了解更多**：[Dart 与 Firebase 博客文章](https://dart.dev/blog/flutter-missing-link-why-full-stack-dart-changes-everything)。

## Tooling updates

## 工具更新

### Agentic Hot Reload

### Agentic 热重载

We've heard from our community that you want AI coding agents to work seamlessly when using Dart and Flutter. That is why we are launching Agentic Hot Reload for Dart and Flutter apps, a new feature designed to keep you and your coding agent in flow. By using the Dart MCP server, your coding agent can now automatically hot reload, eliminating the friction of having to manually find and copy Dart Tooling Daemon (DTD) connection URIs.

我们从社区听到，你希望 AI 编码 agent 在使用 Dart 和
Flutter 时无缝工作。因此我们为 Dart 和 Flutter 应用推出
Agentic Hot Reload，这个新特性旨在让你和你的编码 agent
保持心流。借助 Dart MCP 服务器，你的编码 agent
现在可以自动热重载，免去手动查找和复制
Dart Tooling Daemon（DTD）连接 URI 的麻烦。

Behind the scenes, the Dart Tooling Daemon automatically exposes the connection details through a CLI command run by the MCP server, allowing your coding agent to instantly discover and connect to your running app in your workspace.

在幕后，Dart Tooling Daemon 通过 MCP 服务器运行的
CLI 命令自动暴露连接细节，让你的编码 agent
能即时发现并连接到你工作区中正在运行的应用。

With zero configuration, this integration streamlines your daily workflows. You can simply prompt your coding agent to fix a bug, change a UI widget, or diagnose a crash. The agent will autonomously modify your code, fetch live runtime diagnostics, and hot reload the app in real time.

零配置，这项集成简化了你的日常工作流。
你只需提示编码 agent 修复 bug、修改 UI widget
或诊断崩溃。agent 会自主修改代码、
获取实时运行时诊断，并实时热重载应用。

<DashImage src="images/agentic-hot-reload.webp" caption="Agentic hot reload powered by the Dart MCP server." alt="An animation demonstrating the Dart MCP server hot reloading a Flutter star counter app after the Gemini CLI changes the theme and star animation. The split-screen setup shows the driving macOS terminal on the left and the resulting Android emulator on the right." />

### Analysis server performance diagnostics

### 分析服务器性能诊断

To build the best tools for everyone, we want to understand Dart Analysis Server (DAS) performance exactly as you experience it on your machine. To make this possible, we have introduced the new `dart info record-performance` command.

为了给每个人打造最好的工具，我们想了解
Dart 分析服务器（DAS）在你机器上的真实性能表现。
为此，我们引入了新的 `dart info record-performance` 命令。

Developers experiencing slow analysis times or unresponsive completion can use this command to capture execution traces and CPU profiling data from active DAS processes on their machines. Including these traces when you file issues on GitHub gives our team the exact real-world data needed to diagnose and solve complex performance bottlenecks. By sharing your traces, you directly help us make Dart faster and more reliable for every developer.

遇到分析缓慢或补全无响应的开发者，
可以用这个命令从机器上活跃的 DAS 进程捕获执行追踪
和 CPU 性能分析数据。在 GitHub 提交 issue 时附上这些追踪，
能为我们团队提供诊断和解决复杂性能瓶颈所需的
真实数据。分享你的追踪，就是在直接帮助我们
让 Dart 对每位开发者都更快、更可靠。

## Pub updates

## Pub 更新

### Native Git LFS support in `pub` {:#git-lfs-support}

### `pub` 原生支持 Git LFS

Using packages with large files is now simpler than ever. As of Dart 3.12, `dart pub` natively supports git dependencies with Git Large File Storage (LFS).

使用包含大文件的 package 现在比以往更简单。
从 Dart 3.12 起，`dart pub` 原生支持使用
Git Large File Storage（LFS）的 git 依赖。

You don't need any custom configurations in your `pubspec.yaml` file. As long as `git lfs` is installed on your machine, the pub client handles everything automatically:

你不需要在 `pubspec.yaml` 文件中做任何自定义配置。
只要机器上安装了 `git lfs`，pub 客户端会自动处理一切：

```yaml
dependencies:
  kittens:
    git: https://github.com/munificent/kittens.git
```

This is a major improvement for teams versioning large media assets, data models, or binaries directly inside their git repositories.

对于直接在 git 仓库中对大型媒体资产、数据模型
或二进制文件做版本管理的团队来说，这是一项重大改进。

## Wrap up

## 总结

Dart 3.12 represents a major milestone in removing developer friction. From concise syntax additions to seamless agentic AI workflows and a stronger AI ecosystem, this release is built to support you. Every feature is designed to make your everyday development clean and efficient.

Dart 3.12 是消除开发者阻力道路上的重要里程碑。
从简洁的语法新增，到无缝的 agentic AI 工作流
和更强大的 AI 生态，这个版本为支持你而生。
每个特性都旨在让你的日常开发干净、高效。

We are excited to see what you build with these new capabilities. We hope you [update Dart](https://dart.dev/get-dart) or [upgrade Flutter](https://docs.flutter.dev/install/upgrade) today to try out these updates. If you are testing our experimental features like primary constructors, please share your feedback. Together, we will keep building a language that brings developer joy to everyone, everyday, and everywhere.

我们期待看到你用这些新能力构建的作品。
希望你今天就[更新 Dart](https://dart.dev/get-dart) 或
[升级 Flutter](https://docs.flutter.dev/install/upgrade)
来尝试这些更新。如果你正在测试主构造函数等实验性特性，
请分享你的反馈。我们将一起继续打造一门
为每个人、每一天、每个地方带来开发乐趣的语言。

**Learn more**: [Dart SDK changelog](https://github.com/dart-lang/sdk/blob/main/CHANGELOG.md#3120)

**了解更多**：[Dart SDK 更新日志](https://github.com/dart-lang/sdk/blob/main/CHANGELOG.md#3120)
