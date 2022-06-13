---
title: Dart 2 migration guide for web apps
title: Dart 1 Web 应用迁移到 Dart 2
description: Tips for migrating your web app from Dart 1.x to Dart 2.
description: 从 Dart 1.x 版本升级到 Dart 2。
---

<style>
del { color: rgba(255,0,0,.35); }
del code { color: darkred; }
</style>

This page has information on migrating your Dart 1.x web app to Dart 2.
These changes are necessary because of the following:

本文将向你阐述迁移 Dart 1.x Web 应用到 Dart 2 的相关信息。这些迁移变化是必须的因为：

- [Tooling changes](#tools):

  [相关工具变更](#tools):

  - **Chrome** replaces Dartium and content-shell.

    **Chrome** 取代了 Dartium 和 content-shell。

  - A **new build system** replaces `pub build`, `pub serve`, pub transformers.

    **新的编译系统**取代了 `pub build`、`pub serve` 以及 pub 变换器。

- Dart 2 [language and library changes.][dart-2]

  Dart 2 [语言和库变化。][dart-2]


## Tools

## 工具

The development environment for web apps is different in Dart 2 from Dart 1.x.
Here are the highlights:

Dart 2 的 Web 应用开发环境与 Dart 1.x 不同。以下是重点：

| **Dart 1.x**           | **Dart 2**                                                 |
|------------------------|------------------------------------------------------------|
| Dartium, content shell | Chrome and the [`webdev` tool](/tools/webdev)              |
| `pub build`            | [`webdev build`](/tools/webdev#build)                      |
| `pub serve`            | [`webdev serve`](/tools/webdev#serve)                      |
| `pub run angular_test` | `dart run build_runner test -- -p chrome`                  |
| pub transformers       | [build][] package transformers. See: [Transforming code][] |
{:.table .table-striped}

## Code

## 代码

To migrate to Dart 2, you'll need to edit your web app's project files:

为了迁移到 Dart 2，你需要编辑你 Web 应用项目的一些文件：

- `pubspec.yaml`. [See details below.](#pubspec)

  `pubspec.yaml`, [详细信息见下方](#pubspec)。

- HTML files with `<script src="foo.dart"...>` elements,
  such as `web/index.html`. [See details below.](#web-index-html)

  包含 `<script src="foo.dart"...>` 标签的 HTML 文件,
  比如 `web/index.html`，[详细信息见下方](#web-index-html)。

- Dart code, due to changes in the [Dart language and libraries.][dart-2]

  由于 [Dart 语言和库的变化][dart-2]，需要修改的 Dart 代码。

For complete examples of migrating apps,
look at the files changed between the `4.x` and `master` branches
of the following apps:

你可以对比 `4.x` 和 `master` 分支的任意示例应用来获取完整的迁移示例，
比如这些：

- [Quickstart][angular-examples/quickstart]

  [快速上手][angular-examples/quickstart]

- [Tour of Heroes, part 5][angular-examples/toh-5]

  [英雄之路，第五章][angular-examples/toh-5]

### Pubspec

### Pubspec 文件

Make these changes to your `pubspec.yaml` file:

修改你 `pubspec.yaml` 文件的这些部分：

- Add new `dev_dependencies`:

- 在 `dev_dependencies` 添加新的节点：

  - `build_runner: {{site.data.pubspec.dev_dependencies.build_runner}}`
  - `build_test: {{site.data.pubspec.dev_dependencies.build_test}}`, if you are running tests

    `build_test: {{site.data.pubspec.dev_dependencies.build_test}}`，如果你正在运行测试

  - `build_web_compilers: {{site.data.pubspec.dev_dependencies.build_web_compilers}}`
- Drop `dev_dependencies`:

  删除 `dev_dependencies` 中的下列节点：

  - <del>`browser`</del>
  - <del>`dart_to_js_script_rewriter`</del>
- Upgrade to `test` version 0.12.30 or later; it runs Chrome tests headless by default.

  更新到 `测试` 版本 0.12.30 或更高；其会默认运行 Chrome 测试。

- Drop all `transformers`:

  删除所有的 `转换器`:

  - <del>`angular`</del>
  - <del>`dart_to_js_script_rewriter`</del>
  - <del>`test/pub_serve`</del>

For example, look at the differences in
the [Quickstart example's pubspec][angular-examples/quickstart/pubspec.yaml]
with these changes applied.

例如，[angular-examples/quickstart/pubspec.yaml][] 是一个应用了这些差异修改的示例。

<a id="web-index-html"></a>
### HTML with script elements

### 带脚本元素的 HTML

The most common example of a file with `<script>` elements is `web/index.html`.
You'll need to make these changes:

`web/index.html` 文件是一个使用了 `<script>` 元素的最常见栗子。你需要作出以下修改：

- Drop <del>`<script defer src="packages/browser/dart.js"></script>`</del>

  删除 <del>`<script defer src="packages/browser/dart.js"></script>`</del>

- Replace <del>`<script defer src="foo.dart" type="application/dart"></script>`</del> by<br>
  `<script defer src="foo.dart.js"></script>`

  替换为 <del>`<script defer src="foo.dart" type="application/dart"></script>`</del>
  由 <br>`<script defer src="foo.dart.js"></script>`

For example, look at the differences in the [Quickstart example's
web/index.html page][angular-examples/quickstart/web/index.html]
with these changes applied.

比如，查看这个
[快速入门范例的 web/index.html 页面][angular-examples/quickstart/web/index.html]
在应用这些变化后的差异。

[angular-examples/quickstart/web/index.html][] 中向你展示了如何应用这些更改。

## Additional resources

## 其他资源

The [Dart 2 migration guide][dart-2] has
information about changes in Dart 2, and how to migrate your code from Dart 1.x.

[Dart 2 迁移指南][dart-2] 中有关于 Dart 2 变化的信息，
以及如何从 Dart 1.x 版本迁移你的代码。

[angular-examples/quickstart]: https://github.com/googlearchive/quickstart/compare/4.x...master
[angular-examples/quickstart/pubspec.yaml]: https://github.com/googlearchive/quickstart/compare/4.x...master#diff-8b7e9df87668ffa6a04b32e1769a33434999e54ae081c52e5d943c541d4c0d25
[angular-examples/quickstart/web/index.html]: https://github.com/googlearchive/quickstart/compare/4.x...master#diff-8f62b6ced28d3396b501d2e89a2e7cb761d16cd7dc977aebece03d4a5da5c24e
[angular-examples/toh-5]: https://github.com/googlearchive/toh-5/compare/4.x...master
[build]: https://github.com/dart-lang/build
[dart-2]: /dart-2
[Documentation changelog]: https://web.archive.org/web/20181003225323/https://webdev.dartlang.org/changelog
[Transforming code]: https://github.com/dart-lang/build/blob/master/docs/transforming_code.md
