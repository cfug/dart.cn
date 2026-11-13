---
# title: "Announcing Dart 3.11"
title: "宣布 Dart 3.11"
# description: "Hello, Dart developers! The latest stable version, Dart 3.11, is officially here!"
description: "Dart 开发者们好！最新稳定版 Dart 3.11 正式发布了！"
ai-translated: true
publishDate: 2026-02-11
author: conooi
image: images/129dKLBxAMepAi2od91c3TA.webp
category: releases
layout: blog
---


This release focuses heavily on responsiveness and tooling improvements that you’ll feel in your daily workflow. From a smarter analysis server to new pub client capabilities and enhanced AI support, Dart 3.11 is built to keep you in the flow. Read on to learn more.

这个版本重点改进响应速度和工具，你在日常工作流中就能感受到。从更智能的分析服务器，到新的 pub 客户端能力和增强的 AI 支持，Dart 3.11 旨在让你保持心流。继续阅读了解更多。

<DashImage src="images/129dKLBxAMepAi2od91c3TA.webp" alt="Dart 3.11 release banner with the Dart logo and a bullseye icon." caption="Announcing Dart 3.11" />


## Language updates

## 语言更新

No new language updates in this release of Dart.

这个 Dart 版本没有新的语言更新。

## Tools updates

## 工具更新

### Dart MCP & AI Support: Package URI

### Dart MCP 与 AI 支持：package URI

We are continuing to improve the [Dart and Flutter MCP Server](https://docs.flutter.dev/ai/mcp-server) to better support AI coding assistants.

我们持续改进 [Dart 和 Flutter MCP 服务器](https://docs.flutter.dev/ai/mcp-server)，以更好地支持 AI 编码助手。

We’ve added a new tool called `read_package_uris` to the MCP server. This tool allows AI agents (like Cursor, Gemini, or Copilot) to read package URIs from your projects and add them to their context. This ensures that your AI assistant can correctly read, resolve, and utilize dependencies when generating code.

我们为 MCP 服务器添加了名为 `read_package_uris` 的新工具。这个工具让 AI agent（如 Cursor、Gemini 或 Copilot）能读取你项目中的 package URI 并加入其上下文。这确保你的 AI 助手在生成代码时能正确读取、解析和利用依赖。

### Analysis server

### 分析服务器

This release includes numerous performance improvements in the Dart analysis server. The server now uses “fine-grained dependencies” making it more intelligent in deciding what code needs to be re-analyzed during IDE sessions.

这个版本包含 Dart 分析服务器的大量性能改进。服务器现在使用“细粒度依赖”，在 IDE 会话中更智能地决定哪些代码需要重新分析。

We’ve also improved analysis performance in specific situations, such as analyzing code with cycles in the directory structure caused by symlinks, or deep trees of many constant objects.

我们还改进了特定情况下的分析性能，例如分析目录结构因符号链接产生环的代码，或由大量常量对象组成的深层树。

The server now caches compiled analyzer plugin entry points, resulting in faster startup time in IDE sessions and the `dart analyze` and `flutter analyze` commands.

服务器现在会缓存编译后的分析器插件入口点，让 IDE 会话以及 `dart analyze` 和 `flutter analyze` 命令的启动更快。

Finally, we’ve enhanced “dot shorthands” support across many analysis server features, especially code completion, quick fixes, and quick assists.

最后，我们增强了分析服务器多项功能对“点简写（dot shorthands）”的支持，尤其是代码补全、快速修复和快速辅助。

## Pub updates

## Pub 更新

### Glob support in pub workspaces

### pub workspace 支持 glob

[Pub workspaces](https://dart.dev/tools/pub/workspaces) now support declaring packages using globs. This enables you to easily include all packages in a directory in the pub workspace without enumerating them all:

[Pub workspace](https://dart.dev/tools/pub/workspaces) 现在支持用 glob 声明 package。这让你无需逐个枚举，就能轻松把目录中的所有 package 纳入 pub workspace：

```yaml
# Before
name: workspace
environment:
 sdk: ^3.10.0
workspace:
 - pkg/a
 - pkg/b
 - pkg/c

# After
name: workspace
environment:
 sdk: ^3.11.0
workspace:
 - pkg/* # Adds all packages inside pkg.
```


Note: To use this feature, your `pubspec.yaml` must have a Dart version of 3.11 or higher.

注意：要使用这个特性，你的 `pubspec.yaml` 的 Dart 版本必须为 3.11 或更高。

### Pub cache gc

### Pub 缓存回收

Pub has always stored packages in a single global `PUB_CACHE`, ensuring you never download the same package twice. However, since Pub didn’t track which projects used the cache, there was no way to know which packages were outdated, causing package-versions to accumulate over time. Until now, the only solution was to wipe the entire cache and start over.

Pub 一直把 package 存储在单一的全局 `PUB_CACHE` 中，确保同一个 package 不会下载两次。但由于 Pub 不跟踪哪些项目使用了缓存，无法知道哪些 package 已过时，导致 package 版本随时间不断累积。在此之前，唯一的办法是清空整个缓存重来。

As of Dart 3.9, `pub get` has been storing the path to the resolved project inside the cache. Now in Dart 3.11, we introduce the command `pub cache gc` that iterates over all “living” projects, marks all package versions they depend on, and deletes the rest. This can help you reclaim valuable disk space.

从 Dart 3.9 起，`pub get` 会把解析过的项目路径存进缓存。现在 Dart 3.11 引入了 `pub cache gc` 命令，它遍历所有“活跃”项目，标记它们依赖的所有 package 版本，并删除其余的。这能帮你回收宝贵的磁盘空间。

```bash
> dart pub cache gc
Found 3 active projects:
* /home/yourusername/projects/pub
* /home/yourusername/projects/pub-dev
* /home/yourusername/projects/pana
All other projects will need to run `dart pub get` again to work correctly.
Will recover 2 GB.
Are you sure you want to continue? (y/N)? y
Deleting unused cache entries... (4.5s)
>
```


## Wrap up

## 总结

That’s it for Dart 3.11! This release is all about the details that make a difference in your day-to-day development.

Dart 3.11 就介绍到这里！这个版本全是让你日常开发与众不同的细节。

For a full list of changes, check out the [Dart SDK changelog](https://github.com/dart-lang/sdk/blob/main/CHANGELOG.md). As always, we’d love to hear your feedback!

完整变更列表请查看 [Dart SDK 更新日志](https://github.com/dart-lang/sdk/blob/main/CHANGELOG.md)。一如既往，我们期待你的反馈！
