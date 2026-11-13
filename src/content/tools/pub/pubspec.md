---
# title: The pubspec file
title: Pubspec 文件
# shortTitle: Pubspec file
shortTitle: Pubspec 文件
# description: Reference guide for the fields in pubspec.yaml.
description: pubspec.yaml 文件中各字段的参考说明。
ai-translated: true
---

Every [pub package](/tools/pub/packages) needs some metadata so it can specify its
[dependencies](/resources/glossary#dependency). Pub packages that are shared with
others also need to provide some other information so users can discover them.
All of this metadata goes in the package's _pubspec:_
a file named `pubspec.yaml` that's written in the
[YAML](https://yaml.org/) language.

每个 [pub package](/tools/pub/packages) 都需要一些元数据，以便指定它的
[依赖](/resources/glossary#dependency)。
与他人共享的 pub package 还需要提供一些其他信息，方便用户发现它们。
所有这些元数据都放在 package 的 **pubspec** 中：
一个名为 `pubspec.yaml`、用 [YAML](https://yaml.org/) 语言编写的文件。

{% comment %}
PENDING: acknowledge the existence of pubspec.lock files.
{% endcomment %}


## Supported fields

## 支持的字段

A pubspec can have the following fields:

pubspec 可以包含以下字段：

`name`
: Required for every package.
  [_Learn more._](#name)

  每个 package 都必填。
  **[了解更多。](#name)**

`version`
: Required for packages that are hosted on the pub.dev site.
  [_Learn more._](#version)

  托管在 pub.dev 网站上的 package 必填。
  **[了解更多。](#version)**

`description`
: Required for packages that are hosted on the pub.dev site.
  [_Learn more._](#description)

  托管在 pub.dev 网站上的 package 必填。
  **[了解更多。](#description)**

`homepage`
: Optional. URL pointing to the package's homepage (or source code repository).
  [_Learn more._](#homepage)

  可选。指向 package 主页（或源代码仓库）的 URL。
  **[了解更多。](#homepage)**

`repository`
: Optional. URL pointing to the package's source code repository.
  [_Learn more._](#repository)

  可选。指向 package 源代码仓库的 URL。
  **[了解更多。](#repository)**

`issue_tracker`
: Optional. URL pointing to an issue tracker for the package.
  [_Learn more._](#issue-tracker)

  可选。指向该 package 的 issue 跟踪器的 URL。
  **[了解更多。](#issue-tracker)**

`documentation`
: Optional. URL pointing to documentation for the package.
  [_Learn more._](#documentation)

  可选。指向该 package 文档的 URL。
  **[了解更多。](#documentation)**

`dependencies`
: Can be omitted if your package has no dependencies.
  [_Learn more._](#dependencies)

  如果 package 没有依赖，可以省略。
  **[了解更多。](#dependencies)**

`dev_dependencies`
: Can be omitted if your package has no dev dependencies.
  [_Learn more._](#dependencies)

  如果 package 没有开发依赖，可以省略。
  **[了解更多。](#dependencies)**

`dependency_overrides`
: Can be omitted if you do not need to override any dependencies.
  [_Learn more._](#dependencies)

  如果不需要覆盖任何依赖，可以省略。
  **[了解更多。](#dependencies)**

`environment`
: Required as of Dart 2.
  [_Learn more._](#sdk-constraints)

  从 Dart 2 起必填。
  **[了解更多。](#sdk-constraints)**

`executables`
: Optional. Used to put a package's executables on your PATH.
  [_Learn more._](#executables)

  可选。用来把 package 的可执行文件放到 PATH 上。
  **[了解更多。](#executables)**

`platforms`
: Optional. Used to explicitly declare supported platforms
  on the pub.dev site.
  [_Learn more._](#platforms)

  可选。用来在 pub.dev 网站上显式声明支持的平台。
  **[了解更多。](#platforms)**

`publish_to`
: Optional. Specify where to publish a package.
  [_Learn more._](#publish_to)

  可选。指定把 package 发布到哪里。
  **[了解更多。](#publish_to)**

`funding`
: Optional. List of URLs where users can sponsor development of the package.
  [_Learn more._](#funding)

  可选。用户可以赞助该 package 开发的 URL 列表。
  **[了解更多。](#funding)**

`false_secrets`
: Optional. Specify files to ignore when conducting a pre-publishing search
  for potential leaks of secrets.
  [_Learn more._](#false_secrets)

  可选。指定在发布前搜索潜在密钥泄漏时要忽略的文件。
  **[了解更多。](#false_secrets)**
  
`screenshots`
: Optional. Specify a list of screenshot files to display 
  on the [pub.dev site]({{site.pub}}).
  [_Learn more._](#screenshots)

  可选。指定要在 [pub.dev 网站]({{site.pub}}) 上展示的截图文件列表。
  **[了解更多。](#screenshots)**

`topics`
: Optional. List of topics for the package.
  [_Learn more._](#topics)

  可选。该 package 的主题列表。
  **[了解更多。](#topics)**

`ignored_advisories`
: Optional. List of ignored security advisories.
  [_Learn more._](#ignored_advisories)

  可选。被忽略的安全公告列表。
  **[了解更多。](#ignored_advisories)**

`hooks`
: Optional. Configure package-specific hooks, such as native build or link hooks.
  [_Learn more._](#hooks)

  可选。配置 package 专有的 hook，例如原生构建或链接 hook。
  **[了解更多。](#hooks)**

Pub ignores all other fields.

pub 会忽略所有其他字段。

:::flutter-note
Pubspecs for [Flutter apps]({{site.flutter}}) can have
[additional fields]({{site.flutter-docs}}/development/tools/pubspec)
for configuring the environment and managing assets.

[Flutter 应用]({{site.flutter}}) 的 pubspec 可以有
[额外字段]({{site.flutter-docs}}/development/tools/pubspec)，
用来配置环境和管理资源。
:::

If you add a custom field, give it a unique name
that won't clash with future pubspec fields.
For example, instead of adding `bugs`,
you might add a field named `my_pkg_bugs`.

如果添加自定义字段，请给它一个不会和未来的 pubspec 字段冲突的唯一名称。
例如，不要添加 `bugs`，可以添加名为 `my_pkg_bugs` 的字段。


## Example

## 示例

A simple but complete pubspec looks something like the following:

一个简单但完整的 pubspec 大致如下：

```yaml
name: newtify
description: >-
  Have you been turned into a newt?  Would you like to be?
  This package can help. It has all of the
  newt-transmogrification functionality you have been looking
  for.
version: 1.2.3
homepage: https://example-pet-store.com/newtify
documentation: https://example-pet-store.com/newtify/docs

environment:
  sdk: '^3.2.0'
  
dependencies:
  efts: ^2.0.4
  transmogrify: ^0.4.0
  
dev_dependencies:
  test: '>=1.15.0 <2.0.0'
```


## Details

## 细节

This section has more information about each of the pubspec fields.

本节提供每个 pubspec 字段的更多信息。

### Name

### 名称

Every package needs a name.  It's how other packages refer to yours,
and how it appears to the world, should you publish it.

每个 package 都需要一个名称。其他 package 靠它来引用你的 package，
如果你发布它，世界也是通过这个名称看到它。

The name should be all lowercase, with underscores to separate words,
`just_like_this`. Use only basic Latin letters and Arabic digits:
`[a-z0-9_]`. Also, make sure the name is a valid Dart identifier—that it
doesn't start with digits and isn't a
[reserved word](/language/keywords).

名称应该全部小写，用下划线分隔单词，`just_like_this`。
只能使用基本拉丁字母和阿拉伯数字：`[a-z0-9_]`。
还要确保名称是合法的 Dart 标识符——不以数字开头，
也不是 [保留字](/language/keywords)。

Try to pick a name that is clear, terse, and not already in use.
A quick search of packages on the
[pub.dev site]({{site.pub-pkg}})
to make sure that nothing else is using your name is recommended.

尽量选择清晰、简短、尚未被使用的名称。
建议在 [pub.dev 网站]({{site.pub-pkg}}) 上快速搜索一下 package，
确认没有别的东西在使用你的名称。

### Version

### 版本

Every package has a version. A version number is required to host your package
on the pub.dev site, but can be omitted for local-only packages. If you omit
it, your package is implicitly versioned `0.0.0`.

每个 package 都有版本。要把 package 托管到 pub.dev 网站，必须有版本号，
但仅在本地使用的 package 可以省略。如果省略，package 会被隐式标为 `0.0.0`。

Versioning is necessary for reusing code while letting it evolve quickly. A
version number is three numbers separated by dots, like `0.2.43`. It can also
optionally have a build ( `+1`, `+2`, `+hotfix.oopsie`) or prerelease
(`-dev.4`, `-alpha.12`, `-beta.7`, `-rc.5`) suffix.

版本管理让代码可以复用，同时又能快速演进。
版本号是用点分隔的三个数字，例如 `0.2.43`。
它也可以选择带上构建后缀（`+1`、`+2`、`+hotfix.oopsie`）
或预发布后缀（`-dev.4`、`-alpha.12`、`-beta.7`、`-rc.5`）。

Each time you publish your package, you publish it at a specific version.
Once that's been done, consider it hermetically sealed: you can't touch it
anymore. To make more changes, you'll need a new version.

每次发布 package，你都是以某个特定版本发布它。
一旦完成，就把它当作密封好的：你不能再改动它。
要做更多更改，你需要一个新版本。

When you select a version, follow [semantic versioning.][semantic versioning]

选择版本时，请遵循 [语义化版本][semantic versioning]。

[semantic versioning]: https://semver.org/spec/v2.0.0-rc.1.html

### Description

### 描述

This is optional for your own personal packages, but if you intend to
publish your package you must provide a description, which should be in English.
The description should be relatively short—60 to 180 characters—and
tell a casual reader what they might want to know about your package.

对于你自己的个人 package，这是可选的；
但如果你打算发布 package，就必须提供一段描述，而且应该使用英语。
描述应该相对简短——60 到 180 个字符——
并告诉随便看一眼的读者，他们可能想了解这个 package 的什么。

Think of the description as the sales pitch for your package. Users see it
when they [browse for packages.]({{site.pub-pkg}})
The description is plain text: no markdown or HTML.

把描述看作这个 package 的推销词。
用户在 [浏览 package]({{site.pub-pkg}}) 时会看到它。
描述是纯文本：不能使用 Markdown 或 HTML。

### Homepage

### 主页

This should be a URL pointing to the website for your package.
For [hosted packages](/tools/pub/dependencies#hosted-packages),
this URL is linked from the package's page.
While providing a `homepage` is optional, *please provide* it or `repository`
(or both). It helps users understand where your package is coming from.

这应该是指向你的 package 网站的 URL。
对于 [托管 package](/tools/pub/dependencies#hosted-packages)，
package 页面会链接到这个 URL。
虽然提供 `homepage` 是可选的，**请提供** 它或 `repository`（或两者都提供）。
这能帮助用户理解你的 package 从哪里来。

### Repository

### 仓库

The optional `repository` field should contain the URL for your package's source
code repository—for example, `https://github.com/<user>/<repository>`.
If you publish your package to the pub.dev site, then your package's page
displays the repository URL.
While providing a `repository` is optional, *please provide* it or `homepage`
(or both). It helps users understand where your package is coming from.

可选的 `repository` 字段应包含 package 源代码仓库的 URL，
例如 `https://github.com/<user>/<repository>`。
如果你把 package 发布到 pub.dev 网站，package 页面会显示仓库 URL。
虽然提供 `repository` 是可选的，**请提供** 它或 `homepage`（或两者都提供）。
这能帮助用户理解你的 package 从哪里来。

### Issue tracker

### Issue 跟踪器

The optional `issue_tracker` field should contain a URL for the package's
issue tracker, where existing bugs can be viewed and new bugs can be filed.
The pub.dev site attempts to display a link to each package's issue
tracker, using the value of this field. If `issue_tracker` is missing but
`repository` is present and points to GitHub, then the pub.dev site uses the
default issue tracker (`https://github.com/<user>/<repository>/issues`).

可选的 `issue_tracker` 字段应包含 package 的 issue 跟踪器 URL，
用户可以在那里查看已有缺陷并提交新缺陷。
pub.dev 网站会尝试用这个字段的值，显示每个 package 的 issue 跟踪器链接。
如果缺少 `issue_tracker`，但存在 `repository` 且指向 GitHub，
pub.dev 网站会使用默认的 issue 跟踪器
（`https://github.com/<user>/<repository>/issues`）。

### Documentation

### 文档

Some packages have a site that hosts documentation, separate from the main
homepage and from the Pub-generated API reference.
If your package has additional documentation, add a `documentation:` field
with that URL; pub shows a link to this documentation on your package's page.

有些 package 有一个专门托管文档的网站，
既不同于主页，也不同于 Pub 生成的 API 参考。
如果你的 package 有额外文档，请添加带有该 URL 的 `documentation:` 字段；
pub 会在 package 页面上显示指向这份文档的链接。

### Dependencies

### 依赖

[Dependencies](/resources/glossary#dependency) are the pubspec's *raison d'être*.
In this section you list each package that your package needs in order to work.

[依赖](/resources/glossary#dependency) 是 pubspec 存在的理由。
在这一节里，你列出 package 为了工作所需要的每一个 package。

Dependencies fall into one of two types. _Regular dependencies_ are listed
under `dependencies:`—these are packages that anyone using your package
will also need. Dependencies that are only needed in the development phase of
the package itself are listed under `dev_dependencies`.

依赖分为两类。**普通依赖** 列在 `dependencies:` 下——
任何使用你的 package 的人也需要这些 package。
只在 package 自身开发阶段需要的依赖列在 `dev_dependencies` 下。

During the development process, you might need to temporarily override
a dependency.  You can do so using `dependency_overrides`.

在开发过程中，你可能需要临时覆盖某项依赖。可以使用 `dependency_overrides` 来做。

For more information, see [Package dependencies](/tools/pub/dependencies).

更多信息请参阅 [Package 依赖](/tools/pub/dependencies)。

### Executables

### 可执行文件

A package might expose one or more of its scripts as executables that
can be run directly from the command line. To make a script publicly
available, list it under the `executables` field.
Entries are listed as key/value pairs:

package 可以把一个或多个脚本作为可执行文件暴露出来，直接从命令行运行。
要让脚本公开可用，请把它列在 `executables` 字段下。
条目以键值对列出：

```plaintext
<name-of-executable>: <Dart-script-from-bin>
```

For example, the following pubspec entry lists two scripts:

例如，下面的 pubspec 条目列出了两个脚本：

```yaml
executables:
  slidy: main
  fvm:
```

Once the package is activated using `dart pub global activate`,
typing `slidy` executes `bin/main.dart`.
Typing `fvm` executes `bin/fvm.dart`.
If you don't specify the value, it is inferred from the key.

使用 `dart pub global activate` 激活 package 之后，
输入 `slidy` 会执行 `bin/main.dart`。
输入 `fvm` 会执行 `bin/fvm.dart`。
如果你不指定值，就会从键推断出来。

For more information, see
[pub global](/tools/pub/cmd/pub-global#running-a-script-from-your-path).

更多信息请参阅 [pub global](/tools/pub/cmd/pub-global#running-a-script-from-your-path)。


### Platforms

### 平台

When you [publish a package][], pub.dev automatically 
detects the platforms that the package supports.
If this platform-support list is incorrect,
use `platforms` to explicitly declare
which platforms your package supports.

当你 [发布 package][publish a package] 时，pub.dev 会自动检测该 package 支持的平台。
如果这份平台支持列表不正确，请使用 `platforms` 显式声明你的 package 支持哪些平台。

For example, the following `platforms` entry causes pub.dev
to list the package as supporting
Android, iOS, Linux, macOS, Web, and Windows:

例如，下面的 `platforms` 条目会让 pub.dev 把该 package 列为支持
Android、iOS、Linux、macOS、Web 和 Windows：

```yaml
# This package supports all platforms listed below.
platforms:
  android:
  ios:
  linux:
  macos:
  web:
  windows:
```

Here is an example of declaring that the package supports
only Linux and macOS (and not, for example, Windows):

下面的例子声明该 package 只支持 Linux 和 macOS（例如不支持 Windows）：

```yaml
# This package supports only Linux and macOS.
platforms:
  linux:
  macos:
```

:::note If you use Flutter

**如果你使用 Flutter**

Flutter plugins platform support is by default derived from the
[plugin declarations][].

If there is a discrepancy between the plugin declaration and the actual platform
support, a top-level `platforms` declaration can still be used and takes
precedence over the Flutter plugin declaration when deciding platform support.

Flutter 插件的平台支持默认来自 [插件声明][plugin declarations]。

如果插件声明和实际平台支持不一致，
仍然可以使用顶层的 `platforms` 声明，
并且在判定平台支持时，它优先于 Flutter 插件声明。
:::

:::version-note
Support for the `platforms` entry was added in Dart 2.16.

对 `platforms` 条目的支持在 Dart 2.16 中加入。
:::

[publish a package]: /tools/pub/publishing
[plugin declarations]: {{site.flutter-docs}}/development/packages-and-plugins/developing-packages#plugin-platforms


### Publish_to

### Publish_to 字段

The default uses the [pub.dev site.]({{site.pub}}) Specify `none` to prevent
a package from being published. This setting can be used to specify a
[custom pub package server](/tools/pub/custom-package-repositories)
to publish.

默认使用 [pub.dev 网站]({{site.pub}})。指定 `none` 可以阻止 package 被发布。
这项设置也可以用来指定要发布到的
[自定义 pub package 服务器](/tools/pub/custom-package-repositories)。

```yaml
publish_to: none
```


### Funding

### 资助

Package authors can use the `funding` property to specify a list of URLs that
provide information on how users can help fund the development of the package.
For example:

package 作者可以用 `funding` 属性指定一组 URL，
说明用户如何帮助资助该 package 的开发。例如：

```yaml
funding:
 - https://www.buymeacoffee.com/example_user
 - https://www.patreon.com/some-account
```

If published to [pub.dev]({{site.pub}}) the links are displayed on the
package page. This aims to help users fund the development
of their dependencies.

如果发布到 [pub.dev]({{site.pub}})，这些链接会显示在 package 页面上。
这样做是为了帮助用户资助他们所依赖的 package 的开发。


### False_secrets

### False_secrets 字段

When you try to [publish a package][],
pub conducts a search for potential leaks of
secret credentials, API keys, or cryptographic keys.
If pub detects a potential leak in a file that would be published,
then pub warns you and refuses to publish the package.

当你尝试 [发布 package][publish a package] 时，
pub 会搜索可能泄漏的密钥凭据、API 密钥或加密密钥。
如果 pub 在即将发布的文件中检测到潜在泄漏，
它会警告你并拒绝发布该 package。

Leak detection isn't perfect.
To avoid false positives,
you can tell pub not to search for leaks in certain files,
by creating an allowlist
using [`gitignore` patterns][] under
`false_secrets` in the pubspec.

[`gitignore` patterns]: https://git-scm.com/docs/gitignore#_pattern_format

泄漏检测并不完美。
为了避免误报，你可以在 pubspec 的 `false_secrets` 下，
用 [`gitignore` 模式][`gitignore` patterns] 创建一份允许列表，
告诉 pub 不要在某些文件中搜索泄漏。

For example, the following entry causes pub not to look for leaks in
the file `lib/src/hardcoded_api_key.dart`
and in all `.pem` files in the `test/localhost_certificates/` directory:

例如，下面的条目会让 pub 不在文件 `lib/src/hardcoded_api_key.dart` 中，
也不在 `test/localhost_certificates/` 目录下的所有 `.pem` 文件中查找泄漏：

[publish a package]: /tools/pub/publishing

```yaml
false_secrets:
 - /lib/src/hardcoded_api_key.dart
 - /test/localhost_certificates/*.pem
```

Starting a `gitignore` pattern with slash (`/`) ensures that
the pattern is considered relative to the package's root directory.

`gitignore` 模式以斜杠（`/`）开头，可以确保该模式相对于 package 的根目录。

:::warning
**Don't rely on leak detection.**
It uses a limited set of patterns
to detect common mistakes.
You're responsible for managing your credentials,
preventing accidental leaks, and
revoking credentials that are accidentally leaked.

**不要依赖泄漏检测。**
它只用有限的一组模式来发现常见错误。
管理凭据、防止意外泄漏，以及撤销意外泄漏的凭据，都是你的责任。
:::

:::version-note
Dart 2.15 added support for the `false_secrets` field.

Dart 2.15 增加了对 `false_secrets` 字段的支持。
:::

### Screenshots

### 截图

Packages can showcase their widgets or other visual elements
using screenshots displayed on their pub.dev page. 
To specify screenshots for the package to display,
use the `screenshots` field.

package 可以用展示在 pub.dev 页面上的截图，来展示它们的 widget 或其他视觉元素。
要指定 package 要展示的截图，请使用 `screenshots` 字段。

A package can list up to 10 screenshots under the `screenshots` field.
Don't include logos or other branding imagery in this section.
Each screenshot includes one `description` and one `path`. 
The `description` explains what the screenshot depicts in
no more than 160 characters. 
For example:

一个 package 在 `screenshots` 字段下最多可以列出 10 张截图。
不要在这一节放入标志或其他品牌图像。
每张截图包含一个 `description` 和一个 `path`。
`description` 用不超过 160 个字符说明截图描绘的内容。例如：

```yaml
screenshots:
  - description: 'This screenshot shows the transformation of a number of bytes 
  to a human-readable expression.'
    path: path/to/image/in/package/500x500.webp
  - description: 'This screenshot shows a stack trace returning a human-readable
  representation.'
    path: path/to/image/in/package.png
```

Pub.dev limits screenshots to the following specifications:

pub.dev 对截图有以下限制：

- File size: max 4 MB per image.

  文件大小：每张图片最大 4 MB。

- File types: `png`, `jpg`, `gif`, or `webp`. 

  文件类型：`png`、`jpg`、`gif` 或 `webp`。

- Static and animated images are both allowed.

  静态图片和动态图片都可以。

Keep screenshot files small.
Each download of the package includes all screenshot files.

请把截图文件保持得小一些。
每次下载该 package 都会包含所有截图文件。

Pub.dev generates the package's thumbnail image from the first screenshot. If 
this screenshot uses animation, pub.dev uses its first frame.

pub.dev 用第一张截图生成 package 的缩略图。
如果这张截图使用了动画，pub.dev 会使用它的第一帧。
 
### Topics

### 主题

Package authors can use the `topics` field to categorize their package. Topics
can be used to assist discoverability during search with filters on pub.dev.
Pub.dev displays the topics on the package page as well as in the search
results.

package 作者可以用 `topics` 字段为 package 分类。
主题可以在 pub.dev 上配合筛选器，帮助搜索时被发现。
pub.dev 会在 package 页面和搜索结果中显示这些主题。

The field consists of a list of names. For example:

该字段由一组名称组成。例如：

```yaml
topics:
  - network
  - http
```

Pub.dev requires topics to follow these specifications:

pub.dev 要求主题遵循以下规范：

- Tag each package with at most 5 topics.

  每个 package 最多标记 5 个主题。

- Write the topic name following these requirements:

  主题名称按以下要求书写：

  - Use between 2 and 32 characters.

    使用 2 到 32 个字符。

  - Use only lowercase alphanumeric characters or hyphens (`a-z`, `0-9`, `-`).

    只使用小写字母数字或连字符（`a-z`、`0-9`、`-`）。

  - Don't use two consecutive hyphens (`--`).

    不要使用两个连续的连字符（`--`）。

  - Start the name with lowercase alphabet characters (`a-z`).

    名称以小写字母（`a-z`）开头。

  - End with alphanumeric characters (`a-z` or `0-9`).

    以字母数字字符（`a-z` 或 `0-9`）结尾。

When choosing topics, consider if [existing topics]({{site.pub}}/topics)
are relevant. Tagging with existing topics helps users discover your package.

选择主题时，考虑 [已有主题]({{site.pub}}/topics) 是否相关。
用已有主题打标签，有助于用户发现你的 package。

:::note
Pub.dev merges different spellings of a topic into a canonical topic to
avoid duplication and improve discovery by topic.

You can contribute to the list of canonical topics and their aliases
by opening a pull request that edits the [`topics.yaml` file][] on GitHub.

pub.dev 会把同一主题的不同拼写合并成一个规范主题，
以避免重复，并改进按主题发现的效果。

你可以在 GitHub 上提交拉取请求，编辑 [`topics.yaml` 文件][`topics.yaml` file]，
为规范主题及其别名列表做贡献。
:::

[`topics.yaml` file]: {{site.repo.dart.org}}/pub-dev/blob/master/doc/topics.yaml

### Ignored_advisories

### Ignored_advisories 字段

If a package has a dependency that is affected by a security advisory,
pub warns about the advisory during dependency resolution.
Package authors can use the `ignored_advisories` field as an allowlist
of triggered advisories that are not relevant for the package.

如果 package 的某项依赖受到安全公告影响，
pub 会在依赖解析时就该公告发出警告。
package 作者可以用 `ignored_advisories` 字段作为允许列表，
列入已触发但与该 package 无关的公告。

To suppress the warning about an advisory,
add the advisory identifier to the `ignored_advisories` list.
For example:

要抑制某条公告的警告，请把公告标识加入 `ignored_advisories` 列表。例如：

```yaml
name: myapp
dependencies:
  foo: ^1.0.0
ignored_advisories:
 - GHSA-4rgh-jx4f-qfcq
```

For more information, check out
[Security advisories](/tools/pub/security-advisories).

更多信息请参阅 [安全公告](/tools/pub/security-advisories)。

### Hooks

### Hook 配置

To configure package-specific hooks, such as native build or link hooks,
use the `hooks` field.
Under the `hooks` field,
configure parameters that customize how hooks run.

要配置 package 专有的 hook，例如原生构建或链接 hook，请使用 `hooks` 字段。
在 `hooks` 字段下，配置用来定制 hook 如何运行的参数。

For example:

例如：

```yaml
hooks:
  user_defines:
    my_package:
      enable_experimental: true
```

To learn more about configuring hooks,
check out [Hook configuration][].

要进一步了解如何配置 hook，请参阅 [Hook 配置][Hook configuration]。

[Hook configuration]: /tools/hooks#hook-configuration

### SDK constraints

### SDK 约束

A package can indicate which versions of its dependencies it supports, but
packages have another implicit dependency: the Dart platform itself.
The Dart platform evolves over time, and a package might only work with certain
versions of the platform.

package 可以表明它支持依赖的哪些版本，
但 package 还有另一项隐式依赖：Dart 平台本身。
Dart 平台会随时间演进，一个 package 可能只在平台的某些版本上工作。

A package can specify those versions using an *SDK constraint*. This
constraint goes inside a separate top-level `environment` field in the pubspec
and uses the same
[version constraint](/tools/pub/dependencies#version-constraints) syntax as
dependencies.

package 可以用 **SDK 约束** 指定这些版本。
这项约束放在 pubspec 中单独的顶层 `environment` 字段里，
并使用与依赖相同的
[版本约束](/tools/pub/dependencies#version-constraints) 语法。

:::version-note
For a package to use a feature introduced after 2.0,
its pubspec must have a lower constraint that's at least
the version when the feature was introduced.
For details, check out [Language versioning][].

package 要使用 2.0 之后引入的功能，
它的 pubspec 必须有一个下界约束，至少是该功能引入时的版本。
详情请参阅 [语言版本][Language versioning]。
:::

[Language versioning]: /language/versioning

For example, the following constraint says that this package
works with any Dart SDK that's version 3.0.0 or higher:

例如，下面的约束表示这个 package 可以在 3.0.0 或更高版本的任何 Dart SDK 上工作：

```yaml
environment:
  sdk: ^3.0.0
```

Pub tries to find the latest version of a package whose SDK constraint works
with the version of the Dart SDK that you have installed.

pub 会尝试找到 SDK 约束与你已安装的 Dart SDK 版本相匹配的最新 package 版本。

Omitting the SDK constraint is an error.
When the pubspec has no SDK constraint,
`dart pub get` fails with a message like the following:

省略 SDK 约束是错误的。
当 pubspec 没有 SDK 约束时，`dart pub get` 会失败，并显示类似下面的消息：

```plaintext
pubspec.yaml has no lower-bound SDK constraint.
You should edit pubspec.yaml to contain an SDK constraint:

environment:
  sdk: '^3.2.0'
  
See https://dart.dev/go/sdk-constraint
```

:::version-note
Before Dart 2.19, pub disallowed caret syntax in SDK constraints.
In earlier versions, provide a complete range,
such as `'>=2.12.0 <3.0.0'`.
For more information, check out
the [Caret syntax](/tools/pub/dependencies#caret-syntax) documentation.

在 Dart 2.19 之前，pub 不允许在 SDK 约束中使用插入符语法。
在更早的版本中，请提供完整范围，例如 `'>=2.12.0 <3.0.0'`。
更多信息请参阅 [插入符语法](/tools/pub/dependencies#caret-syntax) 文档。
:::


#### Flutter SDK constraints

#### Flutter SDK 约束

Pub supports specifying Flutter SDK constraints
under the `environment:` field:

pub 支持在 `environment:` 字段下指定 Flutter SDK 约束：

```yaml
environment:
  sdk: ^3.2.0
  flutter: '>=3.22.0'
```

A Flutter SDK constraint is satisfied only if pub is running in the
context of the `flutter` executable, and the Flutter SDK's
`version` file meets the version constraint's lower bound. Otherwise,
the package won't be selected.

只有当 pub 在 `flutter` 可执行文件的上下文中运行，
并且 Flutter SDK 的 `version` 文件满足版本约束的下界时，
Flutter SDK 约束才会得到满足。否则，该 package 不会被选中。

:::note
The Flutter SDK only enforces the lower bound of the flutter constraint.
To learn more, check out
[issue #95472](https://github.com/flutter/flutter/issues/95472)
in the `flutter/flutter` repository.

Flutter SDK 只强制执行 flutter 约束的下界。
要了解更多，请参阅 `flutter/flutter` 仓库中的
[issue #95472](https://github.com/flutter/flutter/issues/95472)。
:::

To publish a package with a Flutter SDK constraint,
you must specify a Dart SDK constraint with a minimum version of
at least 1.19.0, to ensure that older versions of pub won't
accidentally install packages that need Flutter.

要发布带有 Flutter SDK 约束的 package，
你必须指定最低版本至少为 1.19.0 的 Dart SDK 约束，
以确保较旧版本的 pub 不会意外安装需要 Flutter 的 package。

[pubsite]: {{site.pub}}
