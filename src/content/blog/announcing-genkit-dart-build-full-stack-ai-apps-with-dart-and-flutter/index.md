---
# title: "Announcing Genkit Dart: Build full-stack AI apps with Dart and Flutter"
title: "宣布 Genkit Dart：用 Dart 和 Flutter 构建全栈 AI 应用"
# description: "Announcing the preview launch of Genkit Dart, an open-source AI framework for building full-stack, AI-powered apps for any platform."
description: "宣布 Genkit Dart 预览版发布，这是一个开源 AI 框架，用于为任何平台构建全栈、AI 驱动的应用。"
ai-translated: true
publishDate: 2026-03-10
author: chrisraygill
image: images/1haDapHjWrIlyQsYO-zLlLQ.webp
category: announcements
layout: blog
---


The Dart and Flutter communities have always pushed the boundaries of what’s possible across screens. You’ve shown that building high-quality, multi-platform applications doesn’t require compromising on developer experience. Now we’re bringing the same “write once, run anywhere” philosophy to AI-powered features and applications.

Dart 和 Flutter 社区一直在拓展跨屏幕可能性的边界。
你们证明了构建高质量、多平台的应用
不必牺牲开发体验。现在，我们把同样的
“一次编写、随处运行”理念带到 AI 驱动的功能和应用中。

We are thrilled to announce the preview launch of [**Genkit Dart**](https://genkit.dev/docs/dart/get-started/), an open-source AI framework for Dart and Flutter developers. Already available for TypeScript, Go, and Python, Genkit now empowers you to build **high-quality, full-stack, AI-powered applications for any platform**.

我们很高兴宣布
[**Genkit Dart**](https://genkit.dev/docs/dart/get-started/)
预览版发布，这是一个面向 Dart 和 Flutter 开发者的
开源 AI 框架。Genkit 此前已支持 TypeScript、Go 和 Python，
现在让你能构建**任何平台上的高质量、全栈、
AI 驱动应用**。

<DashImage src="images/1haDapHjWrIlyQsYO-zLlLQ.webp" alt="Graphic for the announcement of Genkit Dart Preview." caption="Announcing Genkit Dart (Preview)" />


## Why choose Genkit Dart?

## 为什么选择 Genkit Dart？

Genkit Dart provides you with the following capabilities:

Genkit Dart 为你提供以下能力：

* **Model-agnostic API:** Supports Google, Anthropic, OpenAI, and OpenAI API-compatible models out-of-the-box. You’re never locked into a single provider.

  **模型无关的 API：**开箱即用地支持 Google、Anthropic、
  OpenAI 以及 OpenAI API 兼容模型。你永远不会被锁定在
  单一供应商上。

* **Type safety:** Uses Dart’s strong type system with the [`schemantic`](https://pub.dev/packages/schemantic) package to generate strongly typed data and create type-safe AI flows.

  **类型安全：**结合 Dart 的强类型系统与
  [`schemantic`](https://pub.dev/packages/schemantic) package，
  生成强类型数据并创建类型安全的 AI 流程。

* **Run code anywhere:** Write your AI logic once and run it as a backend service or directly inside your Flutter app.

  **代码随处运行：**AI 逻辑只写一次，
  既能作为后端服务运行，也能直接在你的 Flutter 应用里运行。

* **Developer UI:** Includes a localhost web UI where you can test prompts, view traces, and debug your flows.

  **开发者 UI：**内置 localhost Web UI，
  可以测试提示词、查看追踪并调试流程。

* **Complete AI toolkit:** Provides everything you need to build high-quality AI features, including structured output, tools, multi-step flows, observability, and more.

  **完整的 AI 工具箱：**提供构建高质量 AI 功能所需的一切，
  包括结构化输出、工具、多步骤流程、可观测性等。

## Model-agnostic API

## 模型无关的 API

Genkit is designed to support any LLM provider, with out-of-the-box support for Google, Anthropic, OpenAI, and OpenAI API-compatible models in this release. This lets you switch between providers with minimal code changes.

Genkit 的设计支持任何 LLM 供应商，
这个版本开箱即用地支持 Google、Anthropic、OpenAI
以及 OpenAI API 兼容模型。
这让你只需极少的代码改动就能在供应商之间切换。

```dart
import 'package:genkit/genkit.dart';
import 'package:genkit_google_genai/genkit_google_genai.dart';
import 'package:genkit_anthropic/genkit_anthropic.dart';

void main() async {
  // Initialize Genkit with plugins
  final ai = Genkit(plugins: [
    googleAI(),
    anthropic(),
  ]);

  // Call Google Gemini
  final geminiResponse = await ai.generate(
    model: googleAI.gemini('gemini-3.1-pro-preview'),
    prompt: 'Hello from Gemini',
  );

  // Call Anthropic Claude
  final claudeResponse = await ai.generate(
    model: anthropic.model('claude-opus-4.6'),
    prompt: 'Hello from Claude',
  );
}
```


## Type-safe AI flows

## 类型安全的 AI 流程

Genkit lets you wrap your AI logic into testable, observable, deployable functions called **flows**.

Genkit 让你把 AI 逻辑封装成可测试、可观测、
可部署的函数，称为 **flows**（流程）。

Here is an example of a Travel Planner flow using strongly-typed input and output schemas, with tool calling:

下面是一个旅行规划器 flow 的例子，
使用强类型的输入输出 schema，并带工具调用：

```dart
import 'package:genkit/genkit.dart';
import 'package:genkit_google_genai/genkit_google_genai.dart';
import 'package:schemantic/schemantic.dart';

part 'travel_flow.g.dart';

// Define flow input schema with schemantic
@Schema()
abstract class $TripRequest {
  String get destination;
  int get days;
}

// Define tool input schema
@Schema()
abstract class $WeatherRequest {
  @Field(description: 'The city name')
  String get city;
}

void main() async {
  // Initialize Genkit and register the Google AI plugin
  final ai = Genkit(plugins: [googleAI()]);

  // Define a tool the model can invoke to fetch live data
  ai.defineTool(
    name: 'fetchWeather',
    description: 'Retrieves the current weather forecast for a given city',
    inputSchema: WeatherRequest.$schema,
    fn: (request, _) async => request.city.toLowerCase() == 'seattle' ? 'Rainy' : 'Sunny', 
  );

  // Construct a strongly-typed, observable flow
  final tripPlannerFlow = ai.defineFlow(
    name: 'planTrip',
    inputSchema: TripRequest.$schema,
    outputSchema: .string(),
    fn: (request, _) async {
      // Generate content using the model and tool
      final response = await ai.generate(
        model: googleAI.gemini('gemini-3.1-pro-preview'),
        prompt: 'Build a ${request.days}-day travel itinerary for ${request.destination}. '
                'Make sure to check the weather forecast first to suggest appropriate activities.',
        toolNames: ['fetchWeather'],
      );
      
      return response.text;
    },
  );

  // Run the flow
  final itinerary = await tripPlannerFlow(
    TripRequest(destination: 'Seattle', days: 3)
  );
  print(itinerary);
}
```


When you’re ready, you can easily expose your flow as an API using the `genkit_shelf`package and deploy it to any platform that supports Dart.

准备好之后，你可以用 `genkit_shelf` package
轻松把 flow 暴露为 API，部署到任何支持 Dart 的平台。

```dart
import 'package:genkit_shelf/genkit_shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf_io.dart' as io;

void main() async {
  // ... initialize Genkit and define tripPlannerFlow ...

  final router = Router()
    ..post(
      '/api/planTrip',
      shelfHandler(tripPlannerFlow),
    );

  await io.serve(router.call, 'localhost', 8080);
}
```


## Run anywhere Dart runs

## Dart 能跑的地方都能跑

Most complex AI logic runs on a server. However, because Dart works on both the frontend and backend, Genkit lets you easily move your AI code between your server and your Flutter app.

大多数复杂 AI 逻辑运行在服务器上。
但由于 Dart 在前端和后端都能工作，
Genkit 让你能轻松在服务器和 Flutter 应用之间
移动 AI 代码。

Here are a few ways you can build with Genkit Dart:

下面是用 Genkit Dart 构建的几种方式：

### 1. Entirely in Flutter for prototyping

### 1. 完全在 Flutter 中做原型

You can write all of your Genkit logic, including model calls, directly in your Flutter app. This is great for prototypes or apps where users provide their own API keys and prompts aren’t private.

你可以把所有 Genkit 逻辑（包括模型调用）
直接写在 Flutter 应用里。这非常适合原型，
或者用户自带 API key、提示词不涉及隐私的应用。
> **Warning:** You should never publish an app with your API key embedded in the source code as it can be extracted and used by others.

> **警告：**绝不要发布把 API key 嵌入源代码的应用，
> 因为它可能被提取并被他人使用。

### 2. Call backend flows from Flutter

### 2. 从 Flutter 调用后端 flow

When your prompts are sensitive or your AI logic is complex, you can move the entire flow to your backend. Your Flutter app can then call this flow by defining it as a “remote action”. Since the backend and frontend are both in Dart, they can share the same schemas for end-to-end type safety.

当提示词敏感或 AI 逻辑复杂时，
你可以把整个 flow 移到后端。
然后 Flutter 应用可以把它定义为“远程 action”来调用。
由于后端和前端都用 Dart，
它们可以共享相同的 schema，实现端到端类型安全。

Here is an example showing how to call the Trip Planner backend flow we defined earlier from your Flutter app:

下面的例子展示如何从 Flutter 应用调用
我们之前定义的旅行规划器后端 flow：

```dart
import 'package:genkit/client.dart';
import 'package:my_shared_models/models.dart'; // Shared schema

final tripPlannerFlow = defineRemoteAction(
  url: 'https://your-server.com/api/planTrip',
  inputSchema: TripRequest.$schema,
  outputSchema: .string(),
);

final itinerary = await tripPlannerFlow(
  input: TripRequest(destination: 'Tokyo', days: 5),
);
```


### 3. In Flutter with remote models

### 3. 在 Flutter 中使用远程模型

To secure your API keys while keeping the core AI logic in your Flutter app, you can create a small Genkit backend that proxies requests to the model provider with custom authorization logic. The models exposed through this backend are **remote models**.

要在把核心 AI 逻辑保留在 Flutter 应用中的同时
保护 API key，你可以创建一个小型 Genkit 后端，
用自定义授权逻辑把请求代理给模型供应商。
通过这个后端暴露的模型就是**远程模型**。

```dart
import 'package:genkit_google_genai/genkit_google_genai.dart';
import 'package:genkit_shelf/genkit_shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf_io.dart' as io;

// Backend securely proxies requests to the model
void main() async {
  final geminiApi = googleAI();
  final targetModel = geminiApi.model('gemini-3.1-flash-lite-preview');
  final router = Router()
    ..post(
      '/api/gemini-model',
      shelfHandler(
        targetModel,
        // Insert custom authorization logic here
        contextProvider: (req) async => {'customAuth': true}, 
      ),
    );
  await io.serve(router.call, 'localhost', 8080);
}
```


In your Flutter app, use the remote model instead of a direct model plugin, passing any headers your server needs. This saves you from exposing your API keys and gives you more control over request authorization.

在 Flutter 应用中，使用远程模型而不是直连的模型插件，
并传入服务器需要的任何 header。
这让你免于暴露 API key，并对请求授权有更多控制。

```dart
import 'package:genkit/genkit.dart';

// Flutter app communicates with the proxy server
final ai = Genkit();
final secureModel = ai.defineRemoteModel(
  name: 'secureModel',
  url: 'https://api.yourdomain.com/api/gemini-model',
  headers: (context) => {'Authorization': 'Bearer ${fetchSessionToken()}'}, 
);
final response = await ai.generate(model: secureModel, prompt: 'Write me a poem.');
```


## Powerful tools for AI development

## 强大的 AI 开发工具

Building high-quality AI applications requires thorough testing and continuous iteration to achieve reliable results. To help with this, Genkit provides a powerful local Developer UI.

构建高质量 AI 应用需要充分测试和持续迭代
才能获得可靠结果。为此，Genkit 提供了强大的
本地开发者 UI。

You can start the Developer UI alongside your code by running your app with the Genkit CLI:

用 Genkit CLI 运行你的应用，
就能在代码旁边启动开发者 UI：

```bash
genkit start -- dart run bin/server.dart
```


Here is a look at testing a more advanced version of our Trip Planner flow in the Developer UI:

下面是在开发者 UI 中测试更高级版本的
旅行规划器 flow 的样子：

<DashImage src="images/1xFu0Liex2708NAi02DsTTg.webp" alt="Genkit Developer UI running a flow." caption="Showing the Genkit Developer UI running a flow" />


## AI coding assistance

## AI 编码辅助

For the best experience using Genkit Dart with AI coding tools like Antigravity, Gemini CLI, or Claude Code, install the **Genkit Dart agent skill**. This gives your AI assistant the knowledge to accurately write and debug your AI features.

要在 Antigravity、Gemini CLI 或 Claude Code 等
AI 编码工具中获得使用 Genkit Dart 的最佳体验，
请安装 **Genkit Dart agent skill**。
它让你的 AI 助手掌握准确编写和调试 AI 功能的知识。

Add the skill to your project:

把这个 skill 添加到你的项目：

```bash
npx skills add genkit-ai/skills
```


## Learn more

## 了解更多

This release is an **early preview**. We want to work with Dart and Flutter developers to improve the framework. You can find the core packages and provider plugins on [pub.dev](https://pub.dev/packages/genkit) today.

这个版本是**早期预览**。我们希望与 Dart 和 Flutter
开发者一起改进这个框架。核心 package 和供应商插件
今天就可以在 [pub.dev](https://pub.dev/packages/genkit)
上找到。

* **Get started:** Read our [quickstart guide](https://genkit.dev/docs/dart/get-started/).

  **开始上手：**阅读我们的
  [快速入门指南](https://genkit.dev/docs/dart/get-started/)。

* **Join the community:** Join our [Discord server](https://discord.gg/qXt5zzQKpc) to ask questions and chat with the team.

  **加入社区：**加入我们的
  [Discord 服务器](https://discord.gg/qXt5zzQKpc)
  提问并与团队交流。

* **Stay updated:** Follow us on [X](https://x.com/genkitframework) and [LinkedIn](https://www.linkedin.com/company/genkit).

  **保持关注：**在 [X](https://x.com/genkitframework) 和
  [LinkedIn](https://www.linkedin.com/company/genkit)
  上关注我们。

* **Give feedback:** Open an issue on our [GitHub repository](https://github.com/genkit-ai/genkit-dart) to report bugs or request features.

  **提供反馈：**在我们的
  [GitHub 仓库](https://github.com/genkit-ai/genkit-dart)
  上开 issue 报告 bug 或请求特性。

We can’t wait to see what you build with Genkit Dart!

我们迫不及待想看到你用 Genkit Dart 构建的作品！
