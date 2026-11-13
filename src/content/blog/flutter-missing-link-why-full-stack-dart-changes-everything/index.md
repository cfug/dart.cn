---
# title: "The Flutter missing link: Why full-stack Dart changes everything"
title: "Flutter 缺失的一环：为什么全栈 Dart 改变一切"
# description: "With Cloud Functions for Firebase support for Dart, we can treat the entire stack as a single, unified application."
description: "随着 Cloud Functions for Firebase 支持 Dart，我们可以把整个技术栈当作一个统一的应用。"
ai-translated: true
publishDate: 2026-05-18
author: kevmoo
image: images/dart-firebase-functions-cover.webp
category: announcements
layout: blog
---

<DashImage src="images/dart-firebase-functions-cover.webp" alt="Two blue bird mascots, one wearing sunglasses and playing a black electric guitar connected to a glowing Firebase amplifier, and another wearing headphones operating a music synthesizer board in a clean studio environment." caption="The Flutter missing link" />

For years, Flutter developers have inhabited a divided architectural reality.
You build a high-performance, beautiful frontend using Dart,
leveraging its sound type system and expressive syntax.
But the moment you need to extend that logic to the cloud,
you’re forced into a "language mismatch."
Suddenly, you’re context-switching into TypeScript, Go, or Python—juggling
different concurrency models and manually porting your data structures.
This friction isn't just an inconvenience; it imposes the "Double-Doc Tax,"
a significant overhead where teams must synchronize logic and
documentation twice,
effectively robbing the project of valuable building time.

多年来，Flutter 开发者一直生活在割裂的架构现实中。
你用 Dart 构建高性能、漂亮的前端，
发挥其健全类型系统和富有表现力的语法。
但一旦需要把这些逻辑扩展到云端，
你就被迫陷入“语言错配”。
突然之间，你要切换到 TypeScript、Go 或 Python——
在不同的并发模型之间周旋，手动移植数据结构。
这种摩擦不只是不方便，它还带来“双重定义税”：
团队必须把逻辑和文档同步两遍，
这沉重的开销实际上偷走了项目宝贵的构建时间。

With the [announcement](https://firebase.blog/posts/2026/05/dart-functions-exp)
of experimental support for Dart in Cloud Functions for Firebase,
that era of architectural friction is coming to an end.
For the first time, we can treat the entire stack as a single, unified
application.

随着 Cloud Functions for Firebase 对 Dart 实验性支持的
[宣布](https://firebase.blog/posts/2026/05/dart-functions-exp)，
架构摩擦的时代正在终结。
我们第一次可以把整个技术栈当作一个统一的应用。

## One language to rule them all

## 一门语言统领全部

<DashImage src="images/dart-package-dependency-structure.webp" alt="Infographic titled 'DART PACKAGE DEPENDENCY STRUCTURE' showing 'package:server' representing the backend cloud and 'package:app' representing the frontend mobile/web both depending on a central 'package:shared' package containing shared models and validation logic." caption="Dart package dependency structure" />

The most transformative aspect of this shift is the "Shared Package" pattern.
By moving your business logic and data models into a standalone Dart package,
you eliminate the manual duplication that plagues traditional stacks.
When you update a field in your shared package,
that change propagates instantly across the entire stack.
This architecture ensures that validation rules are identical on both the
client and server,
removing the errors inherent in cross-language implementation.

这次转变最具变革性的部分是“共享 package”模式。
把业务逻辑和数据模型移进一个独立的 Dart package，
你就消除了困扰传统技术栈的手动重复。
当你更新共享 package 中的一个字段时，
这个变更会立即传播到整个技术栈。
这种架构确保客户端和服务器上的校验规则完全一致，
消除跨语言实现固有的错误。

> By sharing data models and validation rules in a common Dart package,
> you can ensure your frontend and backend stay synchronized.

> 通过在公共 Dart package 中共享数据模型和校验规则，
> 你可以确保前端和后端保持同步。

Eliminating the "Double-Doc Tax" is a major productivity win.
By using the
[`firebase_functions`](https://pub.dev/packages/firebase_functions)
package and sharing your models,
you stop wasting time syncing teams and start building features.

消除“双重定义税”是生产力的重大胜利。
使用
[`firebase_functions`](https://pub.dev/packages/firebase_functions)
package 并共享你的模型，
你不再浪费时间同步团队，而是开始构建功能。

## Performance without the "warm-up"

## 无需“热身”的性能

In a serverless, "Scale-to-Zero" environment,
performance is defined by your cloud function cold starts.
Traditional runtimes like Node.js or Java often require a heavy virtual machine
or a Just-In-Time (JIT) warm-up period.
Dart changes the equation through Ahead-of-Time (AOT) compilation.
By compiling directly into lean, native binaries,
Dart functions spring to life *fast*.

在 serverless 的“缩容到零”环境中，
性能由云函数的冷启动决定。
Node.js 或 Java 等传统运行时往往需要沉重的虚拟机
或即时（JIT）编译的热身期。
Dart 通过提前（AOT）编译改变了这个等式。
直接编译成精简的原生二进制文件，
Dart 函数*飞速*启动。

While a traditional SDK footprint might sit at 211&nbsp;MB,
a native Dart binary can be as small as 10&nbsp;MB.
Because Dart utilizes an asynchronous, event-driven architecture,
it handles I/O-bound serverless tasks—like database queries and API requests—with
extreme efficiency,
without the overhead of large thread pools.

传统 SDK 的体积可能高达 211&nbsp;MB，
而原生 Dart 二进制文件可以小至 10&nbsp;MB。
由于 Dart 采用异步、事件驱动的架构，
它以极高的效率处理数据库查询和 API 请求等
I/O 密集型 serverless 任务，
无需大型线程池的开销。

> Dart binaries execute immediately without a warm-up period -
> as fast as 10 milliseconds.

> Dart 二进制文件无需热身期立即执行——
> 最快只要 10 毫秒。

## Containers are now optional

## 容器现在是可选项

One of the greatest hurdles for mobile developers moving to the backend has
been the infrastructure tax of writing Dockerfiles,
managing container registries,
and configuring Linux environments.
The Firebase CLI now abstracts this complexity entirely.
In a single command,
the CLI handles the heavy lifting of compilation and deployment to Google Cloud
infrastructure.

移动开发者转向后端的最大障碍之一，
是编写 Dockerfile、管理容器镜像仓库、
配置 Linux 环境这些基础设施税。
Firebase CLI 现在把这些复杂性完全抽象掉了。
只需一条命令，
CLI 就会承担编译和部署到 Google Cloud 基础设施的重活。

For power users,
there is a hidden 'pro tip'—the Dart toolchain allows for seamless
cross-compilation.
You can compile a Linux 64-bit binary directly on a Mac or Windows machine,
which the CLI then uploads to Cloud Run.

对高级用户来说，
还有一个隐藏的“专业技巧”——Dart 工具链支持无缝交叉编译。
你可以直接在 Mac 或 Windows 机器上编译 Linux 64 位
二进制文件，然后由 CLI 上传到 Cloud Run。

```shell
> dart compile exe bin/server.dart --target-arch x64 --target-os linux
Generated: /Users/user1/dart_server/bin/server.exe
> ls -l bin/server.exe
.rwxr-xr-x@ 7.8M user1 15 May 13:00 -I  bin/server.exe
```

## A development loop that actually loops

## 真正循环起来的开发闭环

The feature Flutter developers value most is "Hot Reload."
Native Dart support brings a similar philosophy to the backend
with the Firebase
Local Emulator Suite.
The suite provides a complete offline environment where the backend experience
finally feels "native" to the Dart developer.

Flutter 开发者最看重的特性是“热重载”。
原生 Dart 支持借助 Firebase 本地模拟器套件，
把类似的理念带到后端。
这套件提供完整的离线环境，
让后端体验对 Dart 开发者来说终于有了“原生”的感觉。

<DashImage src="images/firebase-emulator-suite.webp" alt="Firebase Local Emulator Suite UI in a web browser showing active emulators for Authentication, Firestore, and Functions, demonstrating a green status indicating that the local developer server is running and ready for end-to-end backend emulator testing." caption="Firebase Local Emulator Suite provides offline backend verification" />

This enables you to test your end-to-end application,
including Firestore and Auth interactions,
with near-instantaneous feedback before a single line of code reaches
production.

这让你能测试端到端应用，
包括 Firestore 和 Auth 交互，
在任何一行代码进入生产环境之前获得近乎即时的反馈。

## The experimental Admin SDK

## 实验性 Admin SDK

The foundation for this work is the new
[Firebase Admin SDK](https://pub.dev/packages/firebase_admin_sdk).
While it is automatically initialized within Cloud Functions to provide secure
access to services like Firestore,
its potential is far greater.
Because it is available on [pub.dev](https://pub.dev),
it is not tethered solely to "Functions."
It is a versatile server-side library that can run on Cloud Run,
Compute Engine,
or even your local machine.
This package is a step in Dart’s evolution into a robust, general-purpose
server-side language.

这项工作的基础是新的
[Firebase Admin SDK](https://pub.dev/packages/firebase_admin_sdk)。
虽然它在 Cloud Functions 中自动初始化，
提供对 Firestore 等服务的安全访问，
但它的潜力远不止于此。
因为它发布在 [pub.dev](https://pub.dev) 上，
并不只绑定于 “Functions”。
它是一个多用途的服务器端库，可以运行在 Cloud Run、
Compute Engine，甚至你的本地机器上。
这个 package 是 Dart 演进为健壮、通用的
服务器端语言的一步。

## The full-stack future

## 全栈的未来

While this represents a fundamental shift in the Flutter ecosystem,
you should be aware that we are still in the experimental stage.
To begin,
you must be on **Dart SDK 3.9 or higher** and **Firebase CLI v15.15.0 or
higher**.
Currently, support is focused on HTTPS and callable functions.

虽然这代表着 Flutter 生态的根本性转变，
但请注意我们仍处于实验阶段。
开始之前，
你必须使用 **Dart SDK 3.9 或更高版本**，以及
**Firebase CLI v15.15.0 或更高版本**。
目前支持聚焦于 HTTPS 和 callable 函数。

Eliminating the division between client and cloud is a major leap forward for
development velocity.
With a unified stack,
you can build end-to-end systems with maximum efficiency,
paving the way for a highly productive workflow and unlocking new possibilities
for Dart on the server.

消除客户端与云端之间的割裂，是开发速度的一大飞跃。
有了统一的技术栈，
你可以以最高效率构建端到端系统，
为高生产力的工作流铺路，
并解锁 Dart 在服务器端的新可能。

To get started with building your first Dart Cloud Functions,
check out the
[Cloud Functions for Firebase documentation](https://firebase.google.com/docs/functions/start-dart).
If you would like to deploy a Dart Cloud Function using Cloud Run instead,
check out this [sample app](https://github.com/dart-lang/samples/tree/main/server/simple).

要开始构建你的第一个 Dart Cloud Functions，
请查看
[Cloud Functions for Firebase 文档](https://firebase.google.com/docs/functions/start-dart)。
如果你想改用 Cloud Run 部署 Dart 云函数，
请查看这个[示例应用](https://github.com/dart-lang/samples/tree/main/server/simple)。
