---
# title: "Announcing Dart 3.9"
title: "宣布 Dart 3.9"
# description: "Hello, Dart developers! The latest stable version, Dart 3.9, is officially here!"
description: "Dart 开发者们好！最新稳定版 Dart 3.9 正式发布了！"
ai-translated: true
publishDate: 2025-08-14
author: antfitch
image: images/1VIHR_FuzQzulhqczfx8eAA.webp
category: releases
layout: blog
---


This release is all about making your work easier and your apps more efficient. With key updates to null safety, performance boosts to the Dart CLI, and the exciting addition of the Dart and Flutter MCP Server to empower your AI assistants, there’s a lot to love. Read on to discover everything that’s new in Dart 3.9.

这个版本旨在让你的工作更轻松、应用更高效。空安全的关键更新、Dart CLI 的性能提升，以及赋能 AI 助手的 Dart 和 Flutter MCP 服务器的加入，亮点多多。继续阅读，了解 Dart 3.9 的所有新内容。

<DashImage src="images/1VIHR_FuzQzulhqczfx8eAA.webp" alt="Dart 3.9 release banner with the Dart logo and an animated bullseye icon." caption="Announcing Dart 3.9" />


## Language updates

## 语言更新

### Null safety

### 空安全

Dart 3.9 assumes null safety when computing type promotion, reachability, and definite assignment. To take advantage of these improvements, set your package’s SDK constraint lower bound to 3.9 or greater (`sdk: ^3.9.0`). As a result of this change, more dead_code warnings may be produced.

Dart 3.9 在计算类型提升、可达性和明确赋值时假定空安全。要利用这些改进，把 package 的 SDK 约束下限设为 3.9 或更高（`sdk: ^3.9.0`）。这项变更可能产生更多 dead_code 警告。

### **Soundness updates**

### **健全性更新**

We fixed a soundness issue that allowed direct invocation of a value returned from a getter without any runtime checks when the getter’s return type was a generic type argument instantiated as dynamic or Function. This soundness issue arose with the dev-compiler DDC, and no other tools are affected.

我们修复了一个健全性问题：当 getter 的返回类型是实例化为 dynamic 或 Function 的泛型类型实参时，可以在没有任何运行时检查的情况下直接调用 getter 返回的值。这个健全性问题出现在开发编译器 DDC 中，其他工具不受影响。

Before the fix the following getter could trigger an issue with a direct invocation. For example:

修复之前，下面的 getter 在直接调用时可能触发问题。例如：

```dart
// The following getter used to trigger an issue with a direct 
// invocation

// The getter
class Container<T> {
  T get value => ((int i) => i.isEven) as T;
}

// The direct invocation
Container<dynamic>().value('Invocation with missing runtime checks!');
```


## Tools updates

## 工具更新

### **Dart and Flutter MCP Server**

### **Dart 和 Flutter MCP 服务器**

The [Dart and Flutter MCP Server](https://dart.dev/tools/mcp-server) acts as a bridge, giving AI coding assistants such as Gemini CLI, Cursor, and GitHub Copilot, access to more of your Dart project’s context. Instead of just suggesting code, your AI assistant can now understand your project deeply and take action on your behalf.

[Dart 和 Flutter MCP 服务器](https://dart.dev/tools/mcp-server)充当桥梁，让 Gemini CLI、Cursor 和 GitHub Copilot 等 AI 编码助手能访问更多你 Dart 项目的上下文。你的 AI 助手不再只是建议代码，而是能深入理解你的项目并代你采取行动。

With the Dart and Flutter MCP Server, you can ask an AI assistant to:

有了 Dart 和 Flutter MCP 服务器，你可以让 AI 助手：

* Fix runtime errors ([see example](https://dart.dev/tools/mcp-server#fix-a-runtime-layout-error-in-a-flutter-app)).

  修复运行时错误（[示例](https://dart.dev/tools/mcp-server#fix-a-runtime-layout-error-in-a-flutter-app)）。

* Manage dependencies ([see example](https://dart.dev/tools/mcp-server#add-new-functionality-with-package-search)).

  管理依赖（[示例](https://dart.dev/tools/mcp-server#add-new-functionality-with-package-search)）。

* Write and correct code.

  编写和修正代码。

* And more.

  以及更多。

The Dart and Flutter MCP Server is now available on the stable channel of the Dart SDK.

Dart 和 Flutter MCP 服务器现已在 Dart SDK 的稳定渠道提供。

<DashImage src="images/13K1rgoDtIBWbIFZPp1VCEQ.webp" alt="Animation demonstrating an AI assistant fixing a layout issue using the Dart and Flutter MCP Server." caption="*Fixing a layout issue, enabled by the Dart and Flutter MCP Server (parts of this recording have been sped up)*" />


### **Faster Dart CLI**

### **更快的 Dart CLI**

Previously, when you ran some [Dart CLI commands](https://dart.dev/tools/dart-tool) like `dart analyze` ****and `dart fix`, your computer had to compile the code for the [analysis server](https://github.com/dart-lang/sdk/blob/main/pkg/analysis_server/README.md) just before running it. Now, these tools use an Ahead-Of-Time (AOT) compiled snapshot of the analysis server, which means the server has been pre-compiled into fast, native machine code.

以前，运行 `dart analyze` 和 `dart fix` 等一些 [Dart CLI 命令](https://dart.dev/tools/dart-tool)时，你的电脑必须在运行前临时编译[分析服务器](https://github.com/dart-lang/sdk/blob/main/pkg/analysis_server/README.md)的代码。现在，这些工具使用分析服务器的提前编译（AOT）快照，也就是说服务器已被预编译为快速的原生机器码。

Results vary depending on the source code, but we ran some common commands on a sample package and got some interesting results. Some short commands like `dart format` now complete in a fraction of the time and longer running ones like `dart analyze` got nearly 50% faster.

结果因源码而异，但我们在一个示例 package 上运行了一些常用命令，得到了有趣的结果。`dart format` 等一些短命令现在只需原来一小部分时间就能完成，`dart analyze` 等较长的命令则快了近 50%。

<DashImage src="images/1NkNNA4xfB08k9FjtIHSTEw.webp" alt="Chart showing performance improvements for Dart CLI commands, such as faster format and analyze." caption="Example performance results after the Dart CLI update" />


### **pub client updates**

### **pub 客户端更新**

[Git dependencies](https://dart.dev/tools/pub/dependencies#git-packages) can now be version-solved based on git tags.

[Git 依赖](https://dart.dev/tools/pub/dependencies#git-packages)现在可以基于 git tag 做版本解析。

When you use a `tag_pattern` in the descriptor and there is a `version` constraint, all commits matching the pattern are considered during resolution. In the following example, only version 2.0.1 of `my_dependency` and higher is considered:

当你在描述中使用 `tag_pattern` 且有 `version` 约束时，解析时会考虑所有匹配该模式的提交。在下面的例子中，只考虑 `my_dependency` 的 2.0.1 及更高版本：

```yaml
dependencies:
  my_dependency:
    git:
      url: https://github.com/example/my_dependency
      tag_pattern: v{{version}}
    version: ^2.0.1
```


Starting from [language version](https://dart.dev/language/versioning) 3.9, the `flutter` constraint upper bound is now respected in your root package (the `dart` constraint was already respected). Setting a narrow dart or flutter constraint can be useful to ensure a team of developers all use the same SDK version when jointly developing an app (see [issue #95472](https://github.com/flutter/flutter/issues/95472) for details).

从[语言版本](https://dart.dev/language/versioning) 3.9 起，根 package 中的 `flutter` 约束上限现在也会生效（`dart` 约束此前已生效）。设置较窄的 dart 或 flutter 约束有助于确保开发团队在共同开发应用时使用相同的 SDK 版本（详情见 [issue #95472](https://github.com/flutter/flutter/issues/95472)）。

For example, in a root pubspec like this `pub get` will fail if invoked with a version of the Flutter SDK that is not 3.33.0:

例如，在这样的根 pubspec 中，如果用非 3.33.0 版本的 Flutter SDK 调用 `pub get` 就会失败：

```yaml
name: my_app
environment:
  sdk: ^3.9.0
  flutter: 3.33.0
```


### **Dart native compiler**

### **Dart 原生编译器**

We added [cross-compilation support](https://dart.dev/tools/dart-compile#cross-compilation-exe) for target architectures of `arm` (ARM32) and `riscv64` (RV64GC) when the target OS is Linux.

我们添加了目标 OS 为 Linux 时对 `arm`（ARM32）和 `riscv64`（RV64GC）目标架构的[交叉编译支持](https://dart.dev/tools/dart-compile#cross-compilation-exe)。

## Deprecations & breaking changes

## 弃用与破坏性变更

### **32-bit x86 architecture**

### **32 位 x86 架构**

Dart has deprecated the 32-bit x86 architecture. For most developers this will have no impact, as it mainly affects older x86-based Android emulators and a small number of physical devices. 32-bit ARM and 64-bit x86_64 emulators and devices are still supported. The full technical breakdown is available in the [Dart GitHub deprecation issue](https://github.com/dart-lang/sdk/issues/49969).

Dart 已弃用 32 位 x86 架构。对大多数开发者没有影响，因为它主要影响较老的基于 x86 的 Android 模拟器和少量物理设备。32 位 ARM 和 64 位 x86_64 的模拟器和设备仍然受支持。完整技术细节见 [Dart GitHub 弃用 issue](https://github.com/dart-lang/sdk/issues/49969)。

### **dart build**

### **dart build**

`dart build` is in preview on the beta channel.

`dart build` 在 beta 渠道处于预览状态。

`dart build -f exe &lt;target&gt;` is now `dart build cli — target=&lt;target&gt;`. See `dart build cli — help` for more info.

`dart build -f exe &lt;target&gt;` 现在是 `dart build cli — target=&lt;target&gt;`。更多信息见 `dart build cli — help`。

## Wrap up

## 总结

That’s a wrap on Dart 3.9! We hope you’re as excited about these updates as we are. We always appreciate your feedback, so feel free to share your thoughts. Until next time, happy coding!

Dart 3.9 就介绍到这里！希望你和我们一样对这些更新感到兴奋。我们始终感谢你的反馈，欢迎分享想法。下次再见，编码愉快！
