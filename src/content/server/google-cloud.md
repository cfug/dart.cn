---
# title: Using Google Cloud
title: 使用 Google Cloud
# shortTitle: Google Cloud
shortTitle: Google Cloud
# description: >-
#   Your Dart app can use many Google Cloud services:
#   Firebase, Google Cloud Platform, and more.
description: Dart 应用可以使用许多 Google Cloud 服务，包括 Firebase、Google Cloud Platform 等。
ai-translated: true
---

Dart servers can use many
[Google Cloud products](https://cloud.google.com/products),
often with the help of the pre-packaged Docker
[Official Images for Dart](https://hub.docker.com/_/dart).
To get started creating HTTP servers with Dart,
check out some of the popular [server frameworks][server-frameworks].

Dart 服务器可以使用许多
[Google Cloud 产品](https://cloud.google.com/products)，
通常可以借助预打包的 Docker
[Dart 官方镜像](https://hub.docker.com/_/dart)。
若要开始用 Dart 创建 HTTP 服务器，
可以看看一些常用的 [服务端框架][server-frameworks]。

For information about other Google APIs (including Firebase)
that you might want to use from Dart code,
see the [Google APIs page](/resources/google-apis).

关于你可能想在 Dart 代码中使用的其他 Google API
（包括 Firebase），
请参阅 [Google API 页面](/resources/google-apis)。

[server-frameworks]: /server#frameworks

## Recommended solutions

## 推荐方案

To run Dart in the Cloud, we recommend using serverless computing solutions.

要在云端运行 Dart，我们推荐使用无服务器计算方案。

### Cloud Run

### Cloud Run 平台

You can use Cloud Run's flexible container support,
combined with Dart's Docker images, to run server-side Dart code.
Creating scalable, high performance APIs and event-driven apps
are good use cases for Cloud Run's serverless platform,
which frees developers from managing infrastructure.

你可以结合 Cloud Run 灵活的容器支持
和 Dart 的 Docker 镜像，运行服务端 Dart 代码。
构建可扩展的高性能 API 和事件驱动应用，
很适合 Cloud Run 的无服务器平台，
开发者无需自己管理基础设施。

Examples of Dart servers implemented to run on Cloud Run are
[in the dart-lang/samples/repo][server examples].

在 Cloud Run 上运行的 Dart 服务器示例
位于 [dart-lang/samples 仓库][server examples]。

For more information about using Cloud Run, see the documentation for
[building and deploying a service in other languages][cr].

关于使用 Cloud Run 的更多信息，请参阅
[用其他语言构建和部署服务][cr] 的文档。

### Cloud Functions for Firebase

### 适用于 Firebase 的 Cloud Functions

Write Cloud Functions for Firebase using Dart to enable full-stack development,
reuse code between your client and backend, and respond to Firebase triggers.
To get started, see the
[Cloud Functions for Firebase documentation][firebase-docs].

用 Dart 编写适用于 Firebase 的 Cloud Functions，
可以进行全栈开发，在客户端和后端之间复用代码，
并响应 Firebase 触发器。
入门请参阅
[适用于 Firebase 的 Cloud Functions 文档][firebase-docs]。

[Firebase Functions package]({{site.pub-pkg}}/firebase_functions)
: The core package to write backend functions and APIs in Dart.

[Firebase Functions package]({{site.pub-pkg}}/firebase_functions)
: 用 Dart 编写后端函数和 API 的核心 package。

[Firebase Admin SDK package]({{site.pub-pkg}}/firebase_admin_sdk)
: Access Firebase services securely from backend servers or Cloud Functions.
  Use it to manage data, send notifications, or verify authentication tokens.

[Firebase Admin SDK package]({{site.pub-pkg}}/firebase_admin_sdk)
: 从后端服务器或 Cloud Functions 安全地访问 Firebase 服务。
  可用于管理数据、发送通知或验证身份令牌。

[Firebase Functions for Dart repository][firebase-repo]
: GitHub repository with quickstart guides, examples, and source code.

[适用于 Dart 的 Firebase Functions 仓库][firebase-repo]
: 包含快速入门指南、示例和源代码的 GitHub 仓库。

[firebase-docs]: https://firebase.google.com/docs/functions/start-dart
[firebase-repo]: https://github.com/firebase/firebase-functions-dart

## Other solutions

## 其他方案

Depending on your needs, you might also want to consider running Dart on the
following Google Cloud compute platforms.

根据你的需求，也可以考虑在以下
Google Cloud 计算平台上运行 Dart。

### Compute Engine

### Compute Engine 平台

To run Dart code on Compute Engine,
use Compute Engine's support for running containers,
combined with Dart's Docker images.

要在 Compute Engine 上运行 Dart 代码，
可以使用 Compute Engine 的容器支持，
并结合 Dart 的 Docker 镜像。

For more information, see the Compute Engine documentation for
[using software containers][ce].

更多信息请参阅 Compute Engine 文档中的
[使用软件容器][ce]。

### Kubernetes

### Kubernetes 平台

To run Dart on clusters of Compute Engine instances,
use Google Kubernetes Engine (GKE).

要在 Compute Engine 实例集群上运行 Dart，
请使用 Google Kubernetes Engine (GKE)。

For more information, see the [GKE overview][].

更多信息请参阅 [GKE 概览][GKE overview]。

### App Engine

### App Engine 平台

[App Engine][] support for Dart is incomplete and requires the
[App Engine flexible environment][], which does not
[autoscale to zero instances][scale to zero], so we recommend **Cloud Run** for new
server-side Dart code.
If you _want_ to use App Engine, consider using the [`appengine` package][].

[App Engine][] 对 Dart 的支持尚不完整，
并且需要 [App Engine 柔性环境][App Engine flexible environment]，
该环境不会 [自动缩容到零实例][scale to zero]，
因此新的服务端 Dart 代码我们推荐 **Cloud Run**。
如果你 **想要** 使用 App Engine，
可以考虑使用 [`appengine` package][]。


[App Engine]: https://cloud.google.com/appengine
[App Engine flexible environment]: https://cloud.google.com/appengine/docs/flexible
[scale to zero]: https://cloud.google.com/run/docs/about-instance-autoscaling
[`appengine` package]: {{site.pub-pkg}}/appengine
[ce]: https://cloud.google.com/compute/docs/containers
[cr]: https://cloud.google.com/run/docs/quickstarts/build-and-deploy/other
[server examples]: {{site.repo.dart.samples}}/tree/main/server
[GKE overview]: https://cloud.google.com/kubernetes-engine/docs/concepts/kubernetes-engine-overview
[Dart Functions Framework]: {{site.pub-pkg}}/functions_framework
[CloudEvents]: https://cloudevents.io/
[functions docs]: https://github.com/GoogleCloudPlatform/functions-framework-dart/blob/main/docs/README.md
