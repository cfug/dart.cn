---
# title: Package dependencies
title: Package 依赖
# breadcrumb: Dependencies
breadcrumb: 依赖
# description: >-
#   Add other packages to your app.
#   Specify package locations, version constraints, and more.
description: 向你的应用添加 package，指定 package 的位置、版本约束等。
ai-translated: true
---

Dependencies are one of the core concepts of the [pub package manager][].
A _dependency_ is another package that your package needs to work.
Dependencies are specified in your [pubspec](/tools/pub/pubspec).
You list only _immediate dependencies_: the
software that your package uses directly. Pub handles
[transitive dependencies](/resources/glossary#transitive-dependency) for you.

依赖是 [pub package 管理工具][pub package manager] 的核心概念之一。
**依赖** 是你的 package 为了工作所需要的另一个 package。
依赖写在 [pubspec](/tools/pub/pubspec) 中。
你只列出 **直接依赖**：你的 package 直接使用的软件。
pub 会为你处理 [传递依赖](/resources/glossary#transitive-dependency)。

This page has detailed information on how to specify dependencies.
At the end is a list of
[best practices for package dependencies](#best-practices).

本页详细说明如何指定依赖。
末尾有一份 [package 依赖的最佳实践](#best-practices) 列表。

## Overview

## 概述

For each dependency, you specify the _name_ of the package you depend on
and the _range of versions_ of that package that you allow.
You can also specify the [_source_][].
The source tells pub how to locate the package.

对于每一项依赖，你指定所依赖 package 的 **名称**，
以及你允许的该 package 的 **版本范围**。
你也可以指定 [**来源**][_source_]。
来源告诉 pub 如何定位这个 package。

[_source_]: /resources/glossary#dependency-source

As an example, you specify a dependency in the following format:

例如，你可以按下面的格式指定一项依赖：

```yaml
dependencies:
  transmogrify: ^1.0.0
```

This YAML code creates a dependency on the `transmogrify` package
using the default package repository ([pub.dev]({{site.pub}})) and
allowing any version from `1.0.0` to `2.0.0` (but not including `2.0.0`).
To learn about this syntax, check out
[version constraints](#version-constraints).

这段 YAML 会创建对 `transmogrify` package 的依赖，
使用默认 package 仓库（[pub.dev]({{site.pub}})），
并允许从 `1.0.0` 到 `2.0.0` 的任何版本（但不包括 `2.0.0`）。
要了解这种语法，请参阅 [版本约束](#version-constraints)。

To specify a source other than pub.dev,
use `sdk`, `hosted`, `git`, or `path`.
For example, the following YAML code uses `path`
to tell pub to get `transmogrify` from a local directory:

要指定 pub.dev 以外的来源，请使用 `sdk`、`hosted`、`git` 或 `path`。
例如，下面的 YAML 使用 `path`，告诉 pub 从本地目录获取 `transmogrify`：

```yaml
dependencies:
  transmogrify:
    path: /Users/me/transmogrify
```

The next section describes the format for each dependency source.

下一节说明每种依赖来源的格式。

## Dependency sources

## 依赖来源

Pub can use the following sources to locate packages:

pub 可以用下面这些来源定位 package：

* [Hosted packages](#hosted-packages)

  [托管 package](#hosted-packages)

* [Git packages](#git-packages)

  [Git package](#git-packages)

* [Path packages](#path-packages)

  [路径 package](#path-packages)

* [SDK](#sdk-packages)

  [SDK](#sdk-packages)

Several [`dart` tool][] commands also support specifying dependency sources
directly on the command line using [package descriptors](#package-descriptors).

若干 [`dart` 工具][`dart` tool] 命令也支持使用 [package 描述符](#package-descriptors)，
直接在命令行上指定依赖来源。

[`dart` tool]: /tools/dart-tool

### Hosted packages

### 托管 package

A _hosted_ package is one that can be downloaded from the pub.dev site
(or another HTTP server that speaks the same API). Here's an example
of declaring a dependency on a hosted package:

**托管** package 是可以从 pub.dev 网站
（或其他使用同一 API 的 HTTP 服务器）下载的 package。
下面是声明对托管 package 的依赖的例子：

```yaml
dependencies:
  transmogrify: ^1.4.0
```

This example specifies that your package depends on a hosted package named
`transmogrify` and works with any version from 1.4.0 to 2.0.0
(but not 2.0.0 itself).

这个例子指定你的 package 依赖名为 `transmogrify` 的托管 package，
并且可以配合从 1.4.0 到 2.0.0 的任何版本（但不包括 2.0.0 本身）。

If you want to use your [own package repository][],
you can use `hosted` to specify its URL.
The following YAML code creates a dependency on the `transmogrify` package
using the `hosted` source:

如果想使用你 [自己的 package 仓库][own package repository]，
可以用 `hosted` 指定它的 URL。
下面的 YAML 使用 `hosted` 来源创建对 `transmogrify` package 的依赖：

[own package repository]: /tools/pub/custom-package-repositories

```yaml
environment:
  sdk: '^[!2.19.0!]'

dependencies:
  transmogrify:
    [!hosted: https://some-package-server.com!]
    version: ^1.4.0
```

The version constraint is optional but recommended.
If no version constraint is given, `any` is assumed.

版本约束是可选的，但建议写上。
如果没有给出版本约束，则假定为 `any`。

:::version-note
If your package has a [SDK constraints][SDK version] earlier than 2.19,
you must use the lower and upper bound format for SDK versions.
The SDK constraint validator in those versions doesn't support
the caret syntax.

如果你的 package 的 [SDK 约束][SDK version] 早于 2.19，
必须对 SDK 版本使用下界和上界的格式。
那些版本中的 SDK 约束校验器不支持插入符语法。

```yaml
environment:
  sdk: [!'>=2.14.0 < 3.0.0'!]
```

If your package has a [SDK version][] earlier than 2.15,
you must use a more verbose `hosted` format.

如果你的 package 的 [SDK 版本][SDK version] 早于 2.15，
必须使用更冗长的 `hosted` 格式。

```yaml
environment:
  sdk: [!'>=2.14.0 < 3.0.0'!]

dependencies:
  transmogrify:
    [!hosted:!]
      [!name: transmogrify!]
      [!url: https://some-package-server.com!]
    version: ^1.4.0
```
:::

[SDK version]: /language/versioning

### Git packages

### Git 依赖

Sometimes you live on the bleeding edge and need to use packages that
haven't been formally released yet. Maybe your package itself is still in
development and is using other packages that are being developed at the
same time. To make that easier, you can depend directly on a package
stored in a [Git][] repository.

有时你走在最前沿，需要使用尚未正式发布的 package。
也许你自己的 package 仍在开发中，同时使用其他也在开发中的 package。
为了让这更容易，你可以直接依赖存放在 [Git][] 仓库中的 package。

[git]: https://git-scm.com/

```yaml
dependencies:
  kittens:
    git: https://github.com/munificent/kittens.git
```

The `git` here says this package is found using Git, and the URL after that is
the Git URL that can be used to clone the package.

这里的 `git` 表示用 Git 找到这个 package，后面的 URL 是可以用来克隆该 package 的 Git URL。

Even if the package repo is private, 
you can configure your `git` setup to access the repo using an
[HTTPS access key][GitHub HTTPS] or an [SSH key-pair][GitHub SSH].
Then you can depend on the package by using the repo's corresponding URL:

即使 package 仓库是私有的，你也可以配置 `git`，
用 [HTTPS 访问密钥][GitHub HTTPS] 或 [SSH 密钥对][GitHub SSH] 访问该仓库。
然后你可以用仓库对应的 URL 来依赖这个 package：

```yaml
dependencies:
  kittens:
    # SSH URL:
    git: git@github.com:munificent/kittens.git
```

The `dart pub` command calls `git clone` as a subprocess, so all you need to
provide is a `<url>` that works when `git clone <url>` is executed.

`dart pub` 命令会把 `git clone` 作为子进程调用，
所以你只需要提供一个在执行 `git clone <url>` 时能工作的 `<url>`。

If you want to depend on a specific commit, branch, or tag,
add a `ref` key to the description:

如果想依赖特定的提交、分支或标签，请在描述中添加 `ref` 键：

```yaml
dependencies:
  kittens:
    git:
      url: git@github.com:munificent/kittens.git
      ref: some-branch
```

The ref can be anything that Git allows to [identify a commit.][commit]

ref 可以是 Git 允许用来 [标识一次提交][commit] 的任何内容。

[commit]: https://www.kernel.org/pub/software/scm/git/docs/user-manual.html#naming-commits

If the package you depend on has tagged the
revision of each version of the package,
you can use `tag_pattern` instead of `ref`,
together with a version constraint.

如果所依赖的 package 为每个版本的修订打了标签，
你可以用 `tag_pattern` 代替 `ref`，并配合版本约束。

Pub will then query Git for all matching tags, and
feed those version to the version solver.

然后 pub 会向 Git 查询所有匹配的标签，并把这些版本交给版本求解器。

```yaml highlightLines=5
dependencies:
  kittens:
    git:
      url: git@github.com:munificent/kittens.git
      tag_pattern: v{% raw %}{{version}}{% endraw %} # Find version-tag prefixed by 'v'.
    version: ^2.0.1
```

:::version-note
Support for `tag_pattern` was introduced in Dart 3.9.

To use `tag_pattern`, the including pubspec (but not the dependency)
must have an SDK version constraint of `^3.9.0` or higher.

对 `tag_pattern` 的支持在 Dart 3.9 中引入。

要使用 `tag_pattern`，包含它的 pubspec（而不是该依赖）
的 SDK 版本约束必须是 `^3.9.0` 或更高。
:::

Pub assumes that the package is in the root of the Git repository. To specify a
different location in the repo, specify a `path` relative to the repository
root:

pub 假定 package 位于 Git 仓库的根目录。
要指定仓库中的其他位置，请指定相对于仓库根目录的 `path`：

```yaml
dependencies:
  kittens:
    git:
      url: git@github.com:munificent/cats.git
      path: path/to/kittens
```

The path is relative to the Git repo's root.

该路径相对于 Git 仓库的根目录。

Git dependencies are not allowed as dependencies
for packages uploaded to [pub.dev][pubsite].

上传到 [pub.dev][pubsite] 的 package 不允许使用 Git 依赖。

### Path packages

### 路径 package

Sometimes you find yourself working on multiple related packages at the same
time. Maybe you are creating a framework while building an app that uses it.
In those cases, during development you really want to depend on the _live_
version of that package on your local file system. That way changes in one
package are instantly picked up by the one that depends on it.

有时你会同时开发多个相关的 package。
也许你在构建使用某个框架的应用时，也在创建这个框架。
在这些情况下，开发期间你确实想依赖本地文件系统上该 package 的 **实时** 版本。
这样，一个 package 的更改会立刻被依赖它的 package 接收到。

To handle that, pub supports _path dependencies_.

为此，pub 支持 **路径依赖**。

```yaml
dependencies:
  transmogrify:
    path: /Users/me/transmogrify
```

This says the root directory for `transmogrify` is `/Users/me/transmogrify`.
For this dependency, pub generates a symlink directly to the `lib` directory
of the referenced package directory. Any changes you make to the dependent
package are seen immediately. You don't need to run pub every time you
change the dependent package.

这表示 `transmogrify` 的根目录是 `/Users/me/transmogrify`。
对于这项依赖，pub 会生成一个直接指向所引用 package 目录中 `lib` 目录的符号链接。
你对被依赖 package 做的任何更改都会立即可见。
每次更改被依赖的 package 时，不需要再运行 pub。

Relative paths are allowed and are considered relative to the directory
containing your pubspec.

允许使用相对路径，并且相对于包含你的 pubspec 的目录。

Path dependencies are useful for local development, but do not work when
sharing code with the outside world—not everyone can get to
your file system. Because of this, you cannot upload a package to the
[pub.dev site][pubsite] if it has any path dependencies in its pubspec.

路径依赖对本地开发很有用，但在与外界共享代码时行不通——
不是每个人都能访问你的文件系统。
因此，如果 pubspec 中有任何路径依赖，你就不能把 package 上传到 [pub.dev 网站][pubsite]。

Instead, the typical workflow is:

典型的工作流是：

1. Edit your pubspec locally to use a path dependency.

   在本地编辑 pubspec，改用路径依赖。

2. Work on the main package and the package it depends on.

   同时开发主 package 和它所依赖的 package。

3. Once they're both working, publish the dependent package.

   两者都能工作之后，发布被依赖的 package。

4. Change your pubspec to point to the now hosted version of its dependent.

   把 pubspec 改为指向现在已托管的被依赖版本。

5. Publish your main package too, if you want.

   如果需要，也发布你的主 package。

<a id="sdk" aria-hidden="true"></a>

### SDK packages

### SDK 依赖

The SDK source is used for any SDKs that are shipped along with packages,
which might themselves be dependencies.
Currently, Flutter is the only SDK that is supported.

SDK 来源用于任何随 package 一起提供的 SDK，这些 package 本身也可能是依赖。
目前，Flutter 是唯一受支持的 SDK。

The syntax looks like this:

语法如下：

```yaml
dependencies:
  flutter_driver:
    sdk: flutter
```

The identifier after `sdk:` indicates which SDK the package comes from.
If it's `flutter`, the dependency is satisfiable as long as:

`sdk:` 后面的标识符表明 package 来自哪个 SDK。
如果是 `flutter`，只要满足以下条件，该依赖就可以被满足：

* Pub is running in the context of the `flutter` executable

  pub 在 `flutter` 可执行文件的上下文中运行

* The Flutter SDK contains a package with the given name

  Flutter SDK 包含具有给定名称的 package

If it's an unknown identifier, the dependency is always considered unsatisfied.

如果是未知标识符，该依赖始终被视为无法满足。

<a id="source-descriptors" aria-hidden="true"></a>

## Package descriptors

## package 描述符

Several [`dart` tool][dart-tool] commands, such as
[`dart pub add`][pub-add] and [`dart pub unpack`][pub-unpack],
accept a _package descriptor_ after the package name
to specify the version or dependency source of a package.

若干 [`dart` 工具][dart-tool] 命令，例如
[`dart pub add`][pub-add] 和 [`dart pub unpack`][pub-unpack]，
会在 package 名称后面接受一个 **package 描述符**，
用来指定 package 的版本或依赖来源。

The simplest form of a package descriptor is
a [version constraint](#version-constraints),
assuming the default source of the [pub.dev site][pubsite].
For example, the following command uses a descriptor of `^1.2.3`
to [add a dependency][pub-add] on `package:foo` with a constraint of `^1.2.3`.

package 描述符最简单的形式是 [版本约束](#version-constraints)，
并假定默认来源是 [pub.dev 网站][pubsite]。
例如，下面的命令使用描述符 `^1.2.3`，
为 `package:foo` [添加一项依赖][pub-add]，版本约束为 `^1.2.3`。

```console
dart pub add foo:^1.2.3
```

To specify a custom [dependency source](#dependency-sources),
use the same structure as in `pubspec.yaml`,
but using [flow-style YAML][flow-style]:

要指定自定义的 [依赖来源](#dependency-sources)，
请使用与 `pubspec.yaml` 相同的结构，但采用 [流式 YAML][flow-style]：

```plaintext
{<source>: <descriptor>, [version: <constraint>]}
```

The following subsections show the package descriptor syntax
for each type of pub [dependency source](#dependency-sources).

下面各小节展示每种 pub [依赖来源](#dependency-sources) 的 package 描述符语法。

[dart-tool]: /tools/dart-tool
[pub-add]: /tools/pub/cmd/pub-add
[pub-unpack]: /tools/pub/cmd/pub-unpack
[flow-style]: https://yaml.org/spec/1.2.2/#chapter-7-flow-style-productions

### Hosted dependency descriptor

### 托管依赖描述符

To specify a [hosted package](#hosted-packages):

要指定 [托管 package](#hosted-packages)：

```plaintext
{hosted: my-pub.dev}
```

You can also specify a [version constraint](#version-constraints):

你也可以指定 [版本约束](#version-constraints)：

```plaintext
{hosted: my-pub.dev, version: ^1.2.3}
```

### Git dependency descriptor

### Git 依赖描述符

To specify a [git package](#git-packages):

要指定 [Git package](#git-packages)：

```plaintext
{git: https://github.com/foo/foo}
```

You can specify the repository URL, a branch or commit reference,
and the path to the package within the repository:

你可以指定仓库 URL、分支或提交引用，以及 package 在仓库中的路径：

```plaintext
{git: {url: ../foo.git, ref: branch, path: subdir}}
```

### Path package descriptor

### 路径 package 描述符

To specify a [path package](#path-packages):

要指定 [路径 package](#path-packages)：

```plaintext
{path: ../foo}
```

### SDK package descriptor

### SDK package 描述符

To specify an [SDK package](#sdk-packages):

要指定 [SDK package](#sdk-packages)：

```plaintext
{sdk: flutter}
```

## Version constraints

## 版本约束

Let's say that your Package A depends upon Package B.
How can you communicate to other developers which version of Package B
remains compatible with a given version of Package A?

假设 Package A 依赖 Package B。
你如何告诉其他开发者，Package B 的哪个版本仍然与 Package A 的某个给定版本兼容？

To let developers know version compatibility, specify version constraints.
You want to allow the widest range of versions possible
to give your package users flexibility.
The range should exclude versions that don't work or haven't been tested.

要让开发者知道版本兼容性，请指定版本约束。
你希望允许尽可能宽的版本范围，从而给 package 的用户留出灵活性。
这个范围应该排除不能工作或尚未测试过的版本。

The Dart community uses semantic versioning<sup id="fnref:semver"><a
href="#fn:semver">1</a></sup>.

Dart 社区使用语义化版本<sup id="fnref:semver"><a
href="#fn:semver">1</a></sup>。

You can express version constraints using either _traditional syntax_
or _caret syntax_ starting with Dart 2.19.
Both syntaxes specify a range of compatible versions.

从 Dart 2.19 起，你可以用 **传统语法** 或 **插入符语法** 表达版本约束。
两种语法都指定一段兼容版本的范围。

The traditional syntax provides an explicit range like `'>=1.2.3 <2.0.0'`.
The caret syntax provides an explicit starting version `^1.2.3`

传统语法提供显式范围，例如 `'>=1.2.3 <2.0.0'`。
插入符语法提供显式的起始版本 `^1.2.3`。

```yaml
environment:
  # This package must use a 3.x version of the Dart SDK starting with 3.2.
  sdk: ^3.2.0

dependencies:
  transmogrify:
    hosted:
      name: transmogrify
      url: https://some-package-server.com
    # This package must use a 1.x version of transmogrify starting with 1.4.
    version: ^1.4.0
```

To learn more about pub's version system, see the [package versioning page][].

要进一步了解 pub 的版本体系，请参阅 [package 版本管理页面][package versioning page]。

[package versioning page]: /tools/pub/versioning#semantic-versions

### Traditional syntax

### 传统语法

A version constraint that uses the traditional syntax can use any
of the following values:

使用传统语法的版本约束可以使用下面任意一种取值：

| <t>**Value**</t><t>**取值**</t> | <t>**Allows**</t><t>**允许的版本**</t> | <t>**Use?**</t><t>**是否使用？**</t> | <t>**Notes**</t><t>**说明**</t> |
|:---------:|:----------------------------------------|:--------:|:--------------------------------------------------------------------------------------------------------------------------------------------------------|
|   `any`   | All versions                            |    No    | Serves as a explicit declaration of empty version constraint.                                                                                           |
|   `any`   | 所有版本                                |    否    | 用来显式声明空的版本约束。                                                                                                                               |
|  `1.2.3`  | Only the given version                  |    No    | Limits adoption of your package due the additional limits it places on apps that use your package.                                                      |
|  `1.2.3`  | 仅给定版本                              |    否    | 会给使用你的 package 的应用增加额外限制，从而限制你的 package 被采用。                                                                                   |
| `>=1.2.3` | Given version or later                  |    Yes   |                                                                                                                                                         |
| `>=1.2.3` | 给定版本或更高                          |    是    |                                                                                                                                                         |
|  `>1.2.3` | Versions later than the given version   |    No    |                                                                                                                                                         |
|  `>1.2.3` | 晚于给定版本的版本                      |    否    |                                                                                                                                                         |
| `<=1.2.3` | Given version or earlier                |    No    |                                                                                                                                                         |
| `<=1.2.3` | 给定版本或更早                          |    否    |                                                                                                                                                         |
|  `<1.2.3` | Versions earlier than the given version |    No    | Use this when you know an upper bound version that _doesn't_ work with your package. This version might be the first to introduce some breaking change. |
|  `<1.2.3` | 早于给定版本的版本                      |    否    | 当你知道某个上界版本与你的 package **不** 兼容时使用。这个版本可能是第一个引入某项破坏性更改的版本。                                                     |

{:.table}

You can specify any combination of version values as their ranges intersect.
For example, if you set the version value as `'>=1.2.3 <2.0.0'`,
this combines the both limitations so the dependency can be any version
from `1.2.3` to `2.0.0` excluding `2.0.0` itself.

你可以指定版本取值的任意组合，因为它们的范围会取交集。
例如，如果把版本取值设为 `'>=1.2.3 <2.0.0'`，
就会把两种限制合在一起，使依赖可以是从 `1.2.3` 到 `2.0.0`、
但不包括 `2.0.0` 本身的任何版本。

:::warning
If you include the greater than (**>**) character in the version constraint,
**quote the entire constraint string**.
This prevents YAML from interpreting the character as YAML syntax.
For example: never use `>=1.2.3 <2.0.0`. Use `'>=1.2.3 <2.0.0'` or `^1.2.3`.

如果版本约束中包含大于号（**>**），**请给整个约束字符串加引号**。
这样可以避免 YAML 把该字符解释成 YAML 语法。
例如：绝不要使用 `>=1.2.3 <2.0.0`。请使用 `'>=1.2.3 <2.0.0'` 或 `^1.2.3`。
:::

### Caret syntax

### 插入符语法

Caret syntax expresses the version constraint in a compact way.
`^version` means _the range of all versions guaranteed to be backwards
compatible with the given version_.
This range would include all versions up to the next one to introduce a
breaking change. As Dart uses semantic versioning, this would be the next
major version for any package version 1.0 or later
or the next minor version for any package version earlier than 1.0.

插入符语法用紧凑的方式表达版本约束。
`^version` 表示 **保证与给定版本向后兼容的所有版本的范围**。
这个范围包括直到下一个引入破坏性更改的版本之前的所有版本。
由于 Dart 使用语义化版本，对于 1.0 或更高的 package 版本，这是下一个主版本；
对于早于 1.0 的 package 版本，这是下一个次版本。

| <t>Version value</t><t>版本取值</t> | <t>Range covers to</t><t>范围覆盖到</t> | <t>Caret Syntax</t><t>插入符语法</t> | <t>Traditional Syntax</t><t>传统语法</t> |
|:-------------:|:---------------:|:------------:|:-------------------:|
| >=1.0         | Next major      | `^1.3.0`     | `'>=1.3.0 <2.0.0'`  |
| >=1.0         | 下一个主版本    | `^1.3.0`     | `'>=1.3.0 <2.0.0'`  |
| <1.0          | Next minor      | `^0.1.2`     | `'>=0.1.2 <0.2.0'`  |
| <1.0          | 下一个次版本    | `^0.1.2`     | `'>=0.1.2 <0.2.0'`  |

{:.table}

The following example shows caret syntax:

下面的例子展示插入符语法：

```yaml
dependencies:
  # Covers all versions from 1.3.0 to 1.y.z, not including 2.0.0
  path: ^1.3.0
  # Covers all versions from 1.1.0 to 1.y.z, not including 2.0.0
  collection: ^1.1.0
  # Covers all versions from 0.1.2 to 0.1.z, not including 0.2.0
  string_scanner: ^0.1.2
```

## Dev dependencies

## 开发依赖

Pub supports two flavors of dependencies: regular dependencies and _dev
dependencies._ Dev dependencies differ from regular dependencies in that _dev
dependencies of packages you depend on are ignored_. Here's an example:

pub 支持两种依赖：普通依赖和 **开发依赖**。
开发依赖与普通依赖的不同在于，**你所依赖的 package 的开发依赖会被忽略**。下面是一个例子：

Say the `transmogrify` package uses the `test` package in its tests and only
in its tests. If someone just wants to use `transmogrify`—import its
libraries—it doesn't actually need `test`. In this case, it specifies
`test` as a dev dependency. Its pubspec will have something like:

假设 `transmogrify` package 在测试中使用 `test` package，并且只在测试中使用。
如果有人只是想使用 `transmogrify`——导入它的库——实际上并不需要 `test`。
在这种情况下，它把 `test` 指定为开发依赖。它的 pubspec 会类似这样：

```yaml
dev_dependencies:
  test: ^1.25.0
```

Pub gets every package that your package depends on, and everything _those_
packages depend on, transitively. It also gets your package's dev dependencies,
but it _ignores_ the dev dependencies of any dependent packages. Pub only gets
_your_ package's dev dependencies. So when your package depends on
`transmogrify` it will get `transmogrify` but not `test`.

pub 会获取你的 package 所依赖的每一个 package，以及 **那些** package 所依赖的一切，层层传递。
它也会获取你的 package 的开发依赖，但会 **忽略** 任何被依赖 package 的开发依赖。
pub 只获取 **你的** package 的开发依赖。
因此，当你的 package 依赖 `transmogrify` 时，它会获取 `transmogrify`，但不会获取 `test`。

The rule for deciding between a regular or dev dependency is simple: If
the dependency is imported from something in your `lib` or `bin` directories,
it needs to be a regular dependency. If it's only imported from `test`,
`example`, etc. it can and should be a dev dependency.

在普通依赖和开发依赖之间做选择的规则很简单：
如果依赖是从 `lib` 或 `bin` 目录中的内容导入的，它需要是普通依赖。
如果它只从 `test`、`example` 等位置导入，它可以而且应该是开发依赖。

Using dev dependencies makes dependency graphs smaller. That makes `pub` run
faster, and makes it easier to find a set of package versions that satisfies all
constraints.

使用开发依赖会让依赖图更小。这会让 `pub` 运行得更快，
也更容易找到一组满足全部约束的 package 版本。

## Dependency overrides

## 依赖覆盖

You can use `dependency_overrides` to temporarily override all references
to a dependency.

你可以用 `dependency_overrides` 临时覆盖对某项依赖的所有引用。

For example, perhaps you are updating a local copy of transmogrify, a
published package. Transmogrify is used by other packages in your
dependency graph, but you don't want to clone each package locally
and change each pubspec to test your local copy of transmogrify.

例如，也许你正在更新 transmogrify 这个已发布 package 的本地副本。
依赖图中的其他 package 也在使用 Transmogrify，
但你不想把每个 package 都克隆到本地并修改每个 pubspec，
只为了测试你的 transmogrify 本地副本。

In this situation, you can override the dependency using
`dependency_overrides` to specify the directory holding the local
copy of the package.

在这种情况下，你可以用 `dependency_overrides` 覆盖该依赖，
指定存放该 package 本地副本的目录。

The pubspec would look something like the following:

pubspec 大致如下：

```yaml
name: my_app
dependencies:
  transmogrify: ^1.2.0
dependency_overrides:
  transmogrify:
    path: ../transmogrify_patch/
```

When you run [`dart pub get`][] or [`dart pub upgrade`][],
the pubspec's lockfile is updated to reflect the
new path to your dependency and, wherever transmogrify is used, pub
uses the local version instead.

当你运行 [`dart pub get`][] 或 [`dart pub upgrade`][] 时，
pubspec 的 lockfile 会更新，以反映依赖的新路径；
无论哪里使用 transmogrify，pub 都会改用本地版本。

You can also use `dependency_overrides` to specify a particular
version of a package:

你也可以用 `dependency_overrides` 指定 package 的某个特定版本：

```yaml
name: my_app
dependencies:
  transmogrify: ^1.2.0
dependency_overrides:
  transmogrify: '3.2.1'
```

:::warning
Using a dependency override involves some risk. For example,
using an override to specify a version outside the range that the
package claims to support, or using an override to specify
a local copy of a package that has unexpected behaviors,
might break your application.

使用依赖覆盖会有一些风险。例如，
用覆盖指定 package 声称支持的范围之外的版本，
或者用覆盖指定行为出乎意料的 package 本地副本，
都可能弄坏你的应用。
:::

Only the dependency overrides in a **package's own pubspec**
are considered during package resolution. 
Dependency overrides inside any depended-on packages are ignored.

package 解析时，只会考虑 **package 自己的 pubspec** 中的依赖覆盖。
任何被依赖 package 内部的依赖覆盖都会被忽略。

As a result, if you publish a package to pub.dev,
keep in mind that your package's dependency overrides
are ignored by all users of your package.

因此，如果你把 package 发布到 pub.dev，
请记住，你的 package 的依赖覆盖会被该 package 的所有用户忽略。

If you are using a [pub workspace][workspaces],
you can have `dependency_overrides` in each workspace package, but
a single package can only be overridden once in the workspace.

如果使用 [pub 工作区][workspaces]，
每个工作区 package 都可以有 `dependency_overrides`，
但同一个 package 在工作区中只能被覆盖一次。

## `pubspec_overrides.yaml` {:#pubspec-overrides}

## `pubspec_overrides.yaml` 文件

If you want to change certain aspects of
the resolution of your `pubspec.yaml` file, but
do not want to change the actual file, you can
place a file named `pubspec_overrides.yaml` next to the `pubspec.yaml`.

如果想改变 `pubspec.yaml` 文件解析的某些方面，
又不想改动文件本身，可以在 `pubspec.yaml` 旁边放置名为 `pubspec_overrides.yaml` 的文件。

Attributes from that file will override those from `pubspec.yaml`.

该文件中的属性会覆盖 `pubspec.yaml` 中的对应属性。

The properties that can be overridden are:

可以覆盖的属性有：

* `dependency_overrides`

  `dependency_overrides`

* `workspace`

  `workspace`

* `resolution`

  `resolution`

This can be useful to avoid accidentally
checking temporary overrides in to version control.
It can also make it easier to generate overrides from a script.

这有助于避免不小心把临时覆盖签入版本控制。
也可以让脚本更容易生成覆盖项。

In a [pub workspace][workspaces], each workspace package
can have a `pubspec_overrides.yaml` file.

在 [pub 工作区][workspaces] 中，每个工作区 package 都可以有一份 `pubspec_overrides.yaml` 文件。

## Best practices

## 最佳实践

Be proactive in managing your dependencies.
Ensure that your packages depend on the freshest versions of packages
when possible.
If your package depends on a stale package,
that stale package might depend on other stale packages in its dependency tree.
Stale versions of packages can have a negative impact on
the stability, performance, and quality of your app.

请主动管理你的依赖。
尽可能确保你的 package 依赖最新的 package 版本。
如果你的 package 依赖一个过时的 package，
那个过时的 package 可能在它的依赖树中再依赖其他过时的 package。
过时的 package 版本会对应用的稳定性、性能和质量产生负面影响。

We recommend the following best practices for package dependencies.

我们建议 package 依赖遵循下面这些最佳实践。

### Use caret syntax

### 使用插入符语法

Specify dependencies using the [caret syntax](#caret-syntax).
This allows the pub tool to select newer versions of the package
when they become available.
Further, it places an upper bound on the allowed version.

使用 [插入符语法](#caret-syntax) 指定依赖。
这样 pub 工具就能在更新的版本可用时选择它们。
此外，它还会给允许的版本加上上界。

### Depend on the latest stable package versions

### 依赖最新的稳定 package 版本

Use [`dart pub upgrade`][] to update to the latest package versions
that your pubspec allows.
To identify dependencies in your app or package that
aren't on the latest stable versions,
use [`dart pub outdated`][].

使用 [`dart pub upgrade`][] 更新到 pubspec 允许的最新 package 版本。
要找出应用或 package 中尚未使用最新稳定版本的依赖，
请使用 [`dart pub outdated`][]。

### Tighten version constraints for dev dependencies

### 收紧开发依赖的版本约束

A dev dependency defines a package that you need only when developing.
A finished app won't need these packages.
Examples of these packages include tests or code generation tooling.
Set the version constraints of packages in [`dev_dependencies`][dev-dep]
to have a lower bound of the latest version on which your package depends.

开发依赖定义的是你只在开发时需要的 package。
完成的应用不需要这些 package。
这类 package 的例子包括测试或代码生成工具。
请把 [`dev_dependencies`][dev-dep] 中 package 的版本约束下界，
设为你的 package 所依赖的最新版本。

Tightening the version constraints of your dev dependencies might
resemble the following:

收紧开发依赖的版本约束可能像下面这样：

```yaml
dev_dependencies:
  build_runner: ^2.15.1
  lints: ^6.1.0
  test: ^1.31.1
```

This YAML sets the `dev_dependencies` to the latest patch versions.

这段 YAML 把 `dev_dependencies` 设为最新的补丁版本。

[dev-dep]: /tools/pub/dependencies#dev-dependencies

### Test whenever you update package dependencies

### 每次更新 package 依赖时都要测试

If you run [`dart pub upgrade`][] without updating your pubspec,
the API should stay the same
and your code should run as before—but test to make sure.
If you modify the pubspec and update to a new major version,
then you might encounter breaking changes,
so you need to test even more thoroughly.

如果在不更新 pubspec 的情况下运行 [`dart pub upgrade`][]，
API 应该保持不变，你的代码也应该和以前一样运行——但请测试确认。
如果你修改 pubspec 并升级到新的主版本，
就可能遇到破坏性更改，因此需要更彻底地测试。

### Test with downgraded dependencies

### 用降级后的依赖进行测试

When developing packages for publication, it is often preferable to
allow the widest dependency constraints possible.
A wide dependency constraint reduces the likelihood that
package consumers face a version resolution conflict.

开发准备发布的 package 时，通常最好允许尽可能宽的依赖约束。
宽的依赖约束可以降低 package 使用者遇到版本解析冲突的可能性。

For example, if you have a dependency on `foo: ^1.2.3` and
version `1.3.0` of `foo` is released, it might be reasonable to
keep the existing dependency constraint (`^1.2.3`).
But if your package starts using features that were added in `1.3.0`, then
you'll need to bump your constraint to `^1.3.0`.

例如，如果你依赖 `foo: ^1.2.3`，并且 `foo` 发布了 `1.3.0`，
保留现有依赖约束（`^1.2.3`）可能是合理的。
但如果你的 package 开始使用 `1.3.0` 中新增的功能，
就需要把约束提高到 `^1.3.0`。

However, it's easy to forget to bump a
dependency constraint when it becomes necessary.
Therefore, it's a best practice to test your package
against downgraded dependencies before publishing.

不过，在需要提高依赖约束时很容易忘记。
因此，发布前针对降级后的依赖测试 package 是一项最佳实践。

To test against downgraded dependencies, run [`dart pub downgrade`][] and
verify your package still analyzes without errors and passes all tests:

要针对降级后的依赖进行测试，请运行 [`dart pub downgrade`][]，
并确认 package 仍然能无错误地通过分析，且通过所有测试：

```console
dart pub downgrade
dart analyze
dart test
```

Testing with downgraded dependencies should
happen alongside normal tests with latest dependencies.
If dependency constraints need to be bumped, change them yourself or
use `dart pub upgrade --tighten` to update dependencies to the latest versions.

针对降级依赖的测试应该和针对最新依赖的常规测试一起进行。
如果需要提高依赖约束，可以自己修改，
或者使用 `dart pub upgrade --tighten` 把依赖更新到最新版本。

:::note
Testing with `dart pub downgrade` enables you to find incompatibilities that
you might not otherwise have discovered.
But it doesn't exclude the possibility of incompatibilities.

There are often so many different combinations of versions that
testing them all is infeasible.
There might also be older versions allowed by your dependency constraints that
can't be resolved due to mutually incompatible version constraints from
packages themselves or from your `dev_dependencies`.

用 `dart pub downgrade` 测试，可以让你发现原本可能发现不了的不兼容。
但它并不能排除不兼容的可能性。

版本组合往往多到无法全部测试。
依赖约束所允许的某些较旧版本，
也可能因为 package 自身或你的 `dev_dependencies` 中相互不兼容的版本约束而无法解析。
:::

[`dart pub downgrade`]: /tools/pub/cmd/pub-downgrade

### Verify the integrity of downloaded packages

### 校验已下载 package 的完整性

When retrieving new dependencies,
use the [`--enforce-lockfile`][enforce-lock] option to ensure
the extracted package contents match the contents of the original archive.
Without modifying the [lockfile][],
this flag only resolves new dependencies if:

获取新依赖时，使用 [`--enforce-lockfile`][enforce-lock] 选项，
确保解压后的 package 内容与原始归档的内容一致。
在不修改 [lockfile][] 的情况下，只有满足以下条件时，这个标志才会解析新依赖：

* `pubspec.yaml` is satisfied

  `pubspec.yaml` 得到满足

* `pubspec.lock` is not missing

  `pubspec.lock` 没有缺失

* The packages' [content hashes][] match

  各 package 的 [内容哈希][content hashes] 相匹配

[enforce-lock]: /tools/pub/cmd/pub-get#enforce-lockfile
[lockfile]: /resources/glossary#lockfile
[content hashes]: /resources/glossary#pub-content-hash

---

<aside id="fn:semver" class="footnote">

[1] Pub follows version `2.0.0-rc.1` of the
[semantic versioning specification][]
because that version allows packages to use build identifiers (`+12345`)
to differentiate versions. <a href="#fnref:semver">↩</a>

[1] pub 遵循 [语义化版本规范][semantic versioning specification] 的 `2.0.0-rc.1` 版本，
因为该版本允许 package 使用构建标识（`+12345`）来区分版本。 <a href="#fnref:semver">↩</a>

</aside>

[GitHub HTTPS]: https://docs.github.com/en/get-started/getting-started-with-git/caching-your-github-credentials-in-git
[GitHub SSH]: https://help.github.com/articles/connecting-to-github-with-ssh/
[pub package manager]: /tools/pub/packages
[`dart pub get`]: /tools/pub/cmd/pub-get
[`dart pub outdated`]: /tools/pub/cmd/pub-outdated
[`dart pub upgrade`]: /tools/pub/cmd/pub-upgrade
[pubsite]: {{site.pub}}
[semantic versioning specification]: https://semver.org/spec/v2.0.0-rc.1.html
[workspaces]: /tools/pub/workspaces
