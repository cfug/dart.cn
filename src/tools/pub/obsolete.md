---
title: Obsolete pub features
title: 已失效的 pub 命令和功能
description: As of Dart 2, pub no longer supports pub build/serve or transformers.
description: 在 Dart 2 里，有些 pub 功能和命令被移除。
---

As of Dart 2, pub no longer supports `pub build`, `pub serve`, or transformers.
They're replaced by the **build system**, which includes the **build_runner** tool.

从 Dart 2 开始，pub 不再支持 `pub build`、`pub serve` 以及变换器。它们均由**build_runner**工具中的**build system**替代。

For information about building and serving apps in Dart 2, see the following:

有关在 Dart 2 中构建和提供应用的更多信息请查阅：

* Web development:

  Web 开发：

  * [Setup for Angular development (v5)]({{site.angulardart}}/guide/setup)

    [Angular 开发 (v5) 的设置]({{site.angulardart}}/guide/setup)

  * [Deployment (v5)]({{site.angulardart}}/guide/deployment)

    [部署 (v5)]({{site.angulardart}}/guide/deployment)

  * [Web-specific build_runner documentation](/tools/build_runner)

    [针对 Web 的 build_runner 文档](/tools/build_runner)

* General:

  通用：

  * [Build system](https://github.com/dart-lang/build)

    [编译系统](https://github.com/dart-lang/build)

  * [Build system documents,](https://github.com/dart-lang/build/tree/master/docs) including
    [getting started with build_runner](https://github.com/dart-lang/build/blob/master/docs/getting_started.md#getting-started-with-build_runner)

    [编译系统文档，](https://github.com/dart-lang/build/tree/master/docs) 包括 [开始使用 build_runner](https://github.com/dart-lang/build/blob/master/docs/getting_started.md#getting-started-with-build_runner)

If you use Dart 1.x for web development, see the following:

如果你使用 Dart 1.x 开发 Web，请查阅：

* [Setup for Angular development (v4)]({{site.angulardart}}/guide/setup)

  [Angular 开发 (v4) 的设置]({{site.angulardart}}/guide/setup)

* [Deployment (v4)]({{site.angulardart}}/guide/deployment)

  [部署 (v4)]({{site.angulardart}}/guide/deployment)

If you maintain a transformer, see the following:

如果你维护一个变换器，请查阅：

* [Assets and Transformers]({{site.prev-url}}/tools/pub/assets-and-transformers)
  in the [archived Dart site]({{site.prev-url}})

  [存档的 Dart 网站]({{site.prev-url}}) 中的 [ Assets 和变换器]({{site.prev-url}}/tools/pub/assets-and-transformers)

* [Writing a Pub Transformer]({{site.prev-url}}/tools/pub/transformers)
  in the [archived Dart site]({{site.prev-url}})

  [存档的 Dart 网站]({{site.prev-url}}) 中的 [开发一个 Pub 变化器]({{site.prev-url}}/tools/pub/transformers)

For help in switching from Dart 1.x to Dart 2, see the Dart 2 migration guides:

获取从 Dart 1 切换到 Dart 2 的帮助请查阅：

* [Language and core library migration guide](/dart-2#migration)

  [语言和核心库迁移指南](/dart-2#migration)

* [Web app migration guide](/web/dart-2)

  [Web 应用迁移指南](/web/dart-2)

* [Barback/transformer migration guide](https://github.com/dart-lang/build/blob/master/docs/from_barback_transformer.md)

  [Barback/transformer 迁移指南](https://github.com/dart-lang/build/blob/master/docs/from_barback_transformer.md)
