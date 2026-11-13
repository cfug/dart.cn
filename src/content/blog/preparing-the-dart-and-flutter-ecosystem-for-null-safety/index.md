---
# title: "Preparing the Dart and Flutter ecosystem for null safety"
title: "让 Dart 和 Flutter 生态为空安全做好准备"
# description: "Null safety is now API stable. Publish your stable packages now!"
description: "空安全的 API 现已稳定。现在就发布你的稳定版 package 吧！"
ai-translated: true
publishDate: 2021-02-16
author: kevmoo
image: images/1VTEwPWrLp7D0teLcI-HALw.webp
category: announcements
layout: blog
---


<DashImage src="images/1VTEwPWrLp7D0teLcI-HALw.webp" alt="Pub.dev args package card with a Null safety badge and text telling Dart package authors to migrate to null safety." />


Today we’re announcing a new beta release of Dart. This beta represents a new level of stability and confidence in the new [sound null safety](/blog/why-nullable-types) type system, which we’ve been working on for over a year. The updated Dart beta (2.12.0–259.9.beta) is available on [dart.dev](https://dart.dev/get-dart) and is also included in the [beta channel of Flutter](https://flutter.dev/docs/get-started/install). We don’t anticipate any more breaking changes between now and the stable release of this feature.

今天我们宣布发布一个新的 Dart beta 版本。这个 beta 版本标志着我们打磨了一年多的新[健全空安全](/blog/why-nullable-types)类型系统达到了新的稳定性和可靠性水平。更新后的 Dart beta（2.12.0–259.9.beta）已在 [dart.dev](https://dart.dev/get-dart) 上提供，也包含在 [Flutter 的 beta 渠道](https://flutter.dev/docs/get-started/install)中。我们预计从现在到该特性的稳定版发布之间不会再有破坏性变更。

If you’re a package developer, we invite you to begin publishing stable, null-safe versions of your packages to provide the best experience for users when we ship the stable version of Dart with null safety. We’ve started this process ourselves, publishing stable versions of null-safe packages such as [args](https://pub.dev/packages/args/versions/2.0.0), [yaml](https://pub.dev/packages/yaml/versions/3.0.0), and [grpc](https://pub.dev/packages/grpc/versions/3.0.0). If all of your dependencies are null-safe and published with stable versions (e.g. 1.0.0 instead of 1.0.0-nullsafety.123), now is the time for you to do the same!

如果你是 package 开发者，我们邀请你开始发布 package 的空安全稳定版本，以便我们发布带空安全的 Dart 稳定版时，用户能获得最佳体验。我们自己已经开始这个过程，发布了 [args](https://pub.dev/packages/args/versions/2.0.0)、[yaml](https://pub.dev/packages/yaml/versions/3.0.0) 和 [grpc](https://pub.dev/packages/grpc/versions/3.0.0) 等空安全 package 的稳定版本。如果你的所有依赖都已支持空安全并发布了稳定版本（例如 1.0.0 而不是 1.0.0-nullsafety.123），现在就是你做同样事情的时候了！

We’ve also added a new feature to pub.dev that tags package versions as [preview releases](https://dart.dev/tools/pub/publishing#publishing-previews) when their dependent Dart SDK hasn’t yet been released to stable. Preview releases will automatically be promoted to regular stable versions once a new stable Dart SDK is released.

我们还为 pub.dev 添加了一个新特性：当 package 版本依赖的 Dart SDK 尚未发布稳定版时，会把该版本标记为[预览发布](https://dart.dev/tools/pub/publishing#publishing-previews)。一旦新的 Dart SDK 稳定版发布，预览版本会自动升级为常规稳定版本。

<DashImage src="images/0GcE_GbN_IrB_dLtq.webp" alt="Pub.dev args package page with a 1.6.0 stable version and a 2.0.0 preview version." caption="*pub.dev showing the args package with a 1.6.0 stable version and a 2.0.0 preview version*" />


The [null safety migration guide](https://dart.dev/null-safety/migration-guide) has the latest information on how to migrate your packages. Pay close attention to the Dart SDK constraint and versions of your dependencies in the pubspec, as well as the version of the SDK that you’re using in continuous integration (CI) testing.

[空安全迁移指南](https://dart.dev/null-safety/migration-guide)提供了迁移 package 的最新信息。请密切注意 pubspec 中的 Dart SDK 约束和依赖版本，以及你在持续集成（CI）测试中使用的 SDK 版本。

The stable, null-safe version of Dart is coming soon! Thanks for helping us make it happen.

支持空安全的 Dart 稳定版即将到来！感谢你帮助我们实现它。
