---
# title: dart pub outdated
title: dart pub outdated 命令
# description: Use dart pub outdated to help you update your package dependencies.
description: 使用 dart pub outdated 帮助你更新 package 依赖。
ai-translated: true
---

_Outdated_ is one of the commands of the [pub tool](/tools/pub/cmd).

**Outdated** 命令是 [pub 工具](/tools/pub/cmd) 中的一个命令。

```plaintext
$ dart pub outdated [options]
```

Use `dart pub outdated` to identify out-of-date [package dependencies][]
and get advice on how to update them.
[Best practices for dependency management][best practices]
include using the most recent stable package versions,
so you can get the latest bug fixes and improvements.

使用 `dart pub outdated` 找出过时的 [package 依赖][package dependencies]，
并获得如何更新它们的建议。
[依赖管理的最佳实践][best practices]
包括使用最新的稳定 package 版本，
以便获得最新的错误修复和改进。

## Overview

## 概述

Here's how you can use `dart pub outdated` to help you
update the dependencies of a package that you own
(whether it's an app or regular package):

下面说明如何用 `dart pub outdated` 帮助你更新自己拥有的 package 的依赖
（无论它是应用还是普通 package）：

1. If your package doesn't have a `pubspec.lock` file
   checked into source control,
   **run `dart pub get`** in the top directory of the package—the
   directory that contains your package's
   [`pubspec.yaml`](/tools/pub/pubspec) file.

   如果你的 package 没有把 `pubspec.lock` 文件签入源代码管理，
   请在 package 的顶层目录——也就是包含
   [`pubspec.yaml`](/tools/pub/pubspec) 文件的目录——**运行 `dart pub get`**。

2. **Run `dart pub outdated`**
   to identify which package dependencies are out-of-date.
   Note the affected packages,
   so that later you can test the behavior of code that uses them.

   **运行 `dart pub outdated`**，找出哪些 package 依赖已经过时。
   记下受影响的 package，以便稍后测试使用它们的代码的行为。

3. Follow the recommendations of `dart pub outdated` for updating the packages.
   Some updates might require only running `dart pub upgrade`.
   Others might require updating `pubspec.yaml`
   before running `dart pub upgrade`.

   按照 `dart pub outdated` 的建议更新这些 package。
   有些更新只需要运行 `dart pub upgrade`。
   另一些则需要先更新 `pubspec.yaml`，再运行 `dart pub upgrade`。

4. **Run `dart pub outdated`** to confirm that you're using
   the latest compatible package versions.

   **再次运行 `dart pub outdated`**，确认你使用的是最新的兼容 package 版本。

5. **Test** your package to confirm that it still works as expected.

   **测试** 你的 package，确认它仍然按预期工作。

You might still have out-of-date dependencies due to
[transitive dependencies][].
If you want to determine the cause,
try running [`dart pub deps`][] and searching the output for
the name of each out-of-date package.

由于 [传递依赖][transitive dependencies]，你可能仍然有过时的依赖。
如果想找出原因，可以运行 [`dart pub deps`][]，
并在输出中搜索每个过时 package 的名称。


## Example

## 示例

Here's an example of running `dart pub outdated` on
an example that has several out-of-date dependencies.
Three of the dependencies (`args`, `http`, and `path`) are direct,
and one is transitive (`meta`).
As the following example shows,
`dart pub outdated` colorizes the output by default
when you run it on the command line.

下面是对一个有多项过时依赖的示例运行 `dart pub outdated` 的结果。
其中三项依赖（`args`、`http` 和 `path`）是直接依赖，
一项是传递依赖（`meta`）。
如下例所示，在命令行中运行时，
`dart pub outdated` 默认会给输出着色。

{% render 'tools/pub-outdated-output.html' %}

The **Resolvable** column shows which versions you can upgrade to
for each out-of-date dependency.
You can get more information by looking for
the **leftmost column** with a **non-red value**.
For example, `args` is _upgradable_ to 1.6.0,
and `http` is _resolvable_ to 0.12.1.
The `path` and `meta` packages aren't the latest versions,
but are the most current _resolvable_ versions,
considering all the other dependencies.

**Resolvable** 列显示每一项过时依赖可以升级到哪个版本。
要获得更多信息，请寻找 **最左边** 那个值为 **非红色** 的列。
例如，`args` **可以升级** 到 1.6.0，
`http` **可以解析** 到 0.12.1。
`path` 和 `meta` 这两个 package 不是最新版本，
但在考虑所有其他依赖之后，它们是当前 **可解析** 的最新版本。

:::tip
To see what changed in the new version of a package
that's published on [pub.dev,]({{site.pub}})
look at the changelog in the package page.
For example, you can look at the **Changelog** tabs on the pages for the
[`args`][] and [`http`][] packages.

要查看发布在 [pub.dev]({{site.pub}}) 上的 package 新版本改了什么，
请阅读该 package 页面上的更新日志。
例如，可以查看 [`args`][] 和 [`http`][] package 页面上的 **Changelog** 标签页。
:::

To fix the first dependency (`args`),
which is listed as upgradable,
you just need to run `dart pub upgrade`:

要修复第一项依赖（`args`），它被列为可以升级，
只需要运行 `dart pub upgrade`：

```console
$ dart pub upgrade
Resolving dependencies...
> args 1.6.0 (was 1.4.4)
  ...
Changed 1 dependency!
```

To fix the second dependency (`http`),
which is listed as resolvable,
you can change the pubspec's `http` entry to use
the version in the **Resolvable** column
(or a compatible higher version).
In [caret syntax][], that's **`^0.12.1`**.
Here's the diff for `pubspec.yaml`:

要修复第二项依赖（`http`），它被列为可以解析，
可以把 pubspec 中的 `http` 条目改成 **Resolvable** 列中的版本
（或兼容的更高版本）。
用 [插入符语法][caret syntax] 来写，就是 **`^0.12.1`**。
下面是 `pubspec.yaml` 的差异：

```diff
-  http: ^0.11.0
+  http: ^0.12.1
```

After editing `pubspec.yaml`, you run `dart pub upgrade` to
update the `pubspec.lock` file.
You can then run `dart pub outdated` to confirm that
you've made all necessary changes.
In this example, the `path` and `meta` packages are still out-of-date,
due to constraints determined by other dependencies:

编辑 `pubspec.yaml` 之后，运行 `dart pub upgrade` 来更新 `pubspec.lock` 文件。
然后可以再运行 `dart pub outdated`，确认必要的更改都已完成。
在这个例子中，`path` 和 `meta` 仍然过时，
原因是其他依赖决定的版本约束：

```console
$ dart pub upgrade
...
$ dart pub outdated
Package Name  Current  Upgradable  Resolvable  Latest

direct dependencies:
path          1.6.2    1.6.2       1.6.2       1.7.0

dev_dependencies: all up-to-date

transitive dependencies:
meta          1.1.6    1.1.6       1.1.6       1.1.8

transitive dev_dependencies: all up-to-date

Dependencies are all on the latest resolvable versions.
Newer versions, while available, are not mutually compatible.
```

To see why these packages are out-of-date, you can run `dart pub deps`
and look for dependencies on these packages:

要查看这些 package 为什么过时，可以运行 `dart pub deps`，
并查找对这些 package 的依赖：

```console
$ dart pub deps -s list
...
dependencies:
...
- terminal_tools 0.1.0
  - path 1.6.2
  - meta 1.1.6
...
```

As the preceding output shows,
this package depends on the `terminal_tools` package,
which depends on old versions of `path` and `meta`.
Once the `terminal_tools` package is updated,
it should be possible to update this package.

从上面的输出可以看出，
这个 package 依赖 `terminal_tools` package，
而后者依赖旧版本的 `path` 和 `meta`。
等到 `terminal_tools` package 更新之后，
就应该可以更新这个 package。

:::important
Test your code to verify that it still works as expected
after updating the packages.

更新这些 package 之后，请测试你的代码，确认它仍然按预期工作。
:::


## Output columns

## 输出列

The output of `dart pub outdated` has four columns of version information
for each out-of-date dependency.
Here is the part of the [example](#example) output
that shows the four version columns:
Current, Upgradable, Resolvable, and Latest.

`dart pub outdated` 的输出中，每一项过时依赖都有四列版本信息。
下面是 [示例](#example) 输出中展示这四列版本的部分：
Current、Upgradable、Resolvable 和 Latest。

{% render 'tools/pub-outdated-output-columns.html' %}

Current
: The version used in your package, as recorded in `pubspec.lock`.
  If the package isn't in `pubspec.lock`,
  the value is `-`.

  你的 package 正在使用的版本，记录在 `pubspec.lock` 中。
  如果该 package 不在 `pubspec.lock` 里，值为 `-`。

Upgradable
: The latest version allowed by your `pubspec.yaml` file.
  This is the version that `dart pub upgrade` resolves to.
  The value is `-` if the value in the **Current** column is `-`.

  `pubspec.yaml` 文件允许的最新版本。
  这是 `dart pub upgrade` 会解析到的版本。
  如果 **Current** 列的值是 `-`，这里的值也是 `-`。

Resolvable
: The latest version that can be resolved,
  when combined with all other dependencies.
  This version corresponds to what `dart pub upgrade` gives you
  if all version constraints in `pubspec.yaml` are unbounded.
  A value of `-` means that the package won't be needed.

  与所有其他依赖放在一起时，能够解析到的最新版本。
  如果 `pubspec.yaml` 中的所有版本约束都没有上界，
  这个版本就是 `dart pub upgrade` 会给你的版本。
  值为 `-` 表示不需要这个 package。

Latest
: The latest version of the package available,
  excluding prereleases unless you use the option `--prereleases`.

  该 package 可用的最新版本。
  除非使用 `--prereleases` 选项，否则不包括预发布版本。

For example, say your app depends on the `foo` and `bar` packages,
but the latest version of `bar` allows only older major versions of `foo`.
The result is that the latest _resolvable_ version of `foo`
is different from the _latest_ version of `foo`.

例如，假设你的应用依赖 `foo` 和 `bar` 这两个 package，
但 `bar` 的最新版本只允许较旧的 `foo` 主版本。
结果就是，`foo` 最新的 **可解析** 版本和 `foo` 的 **最新** 版本并不相同。

When you edit the `pubspec.yaml` file,
you generally update the **dependencies** and **dev_dependencies** sections
so that each package uses the versions in the **Resolvable** column.

编辑 `pubspec.yaml` 文件时，
通常会更新 **dependencies** 和 **dev_dependencies** 部分，
让每个 package 使用 **Resolvable** 列中的版本。

## Options

## 选项

For options that apply to all pub commands, see
[Global options](/tools/pub/cmd#global-options).

适用于所有 pub 命令的选项，请参阅 [全局选项](/tools/pub/cmd#global-options)。

### `--[no-]dependency-overrides`

### `--[no-]dependency-overrides` 选项

By default, accounts for [`dependency_overrides`][]
when resolving package constraints (`--dependency-overrides`).
To not consider overrides, use `--no-dependency-overrides`.

默认情况下，解析 package 约束时会考虑 [`dependency_overrides`][]
（`--dependency-overrides`）。
要忽略覆盖项，请使用 `--no-dependency-overrides`。

### `--[no-]dev-dependencies`

### `--[no-]dev-dependencies` 选项

By default, accounts for [dev dependencies][dev dependency]
when resolving package constraints (`--dev-dependencies`).
To not consider dev dependencies, use `--no-dev-dependencies`.

默认情况下，解析 package 约束时会考虑 [开发依赖][dev dependency]
（`--dev-dependencies`）。
要忽略开发依赖，请使用 `--no-dev-dependencies`。

### `--json`

### `--json` 选项

Generates output in JSON format.

以 JSON 格式生成输出。

### `--[no-]prereleases`

### `--[no-]prereleases` 选项

By default, includes prereleases
when determining the last package versions (`--prereleases`).
To not consider preleases, use `--no-prereleases`.

默认情况下，确定 package 的最新版本时会包括预发布版本（`--prereleases`）。
要忽略预发布版本，请使用 `--no-prereleases`。

### `--[no-]transitive`

### `--[no-]transitive` 选项

By default, doesn't include [transitive dependencies][]
as part of the output (`--no-transitive`).
To include transitive dependencies, use `--transitive`.

默认情况下，输出中不包括 [传递依赖][transitive dependencies]（`--no-transitive`）。
要包括传递依赖，请使用 `--transitive`。

### `--[no-]up-to-date`

### `--[no-]up-to-date` 选项

By default, doesn't include dependencies that
are at the latest version (`--no-up-to-date`).
To include up-to-date dependencies, use `--up-to-date`.

默认情况下，不包括已经是最新版本的依赖（`--no-up-to-date`）。
要包括已是最新的依赖，请使用 `--up-to-date`。


## In a workspace

## 在工作区中

In a [Pub workspace](/tools/pub/workspaces) `dart pub outdated` lists
all dependencies 

在 [pub 工作区](/tools/pub/workspaces) 中，`dart pub outdated` 会列出所有依赖。

{% render 'pub-problems.md' %}

[`args`]: {{site.pub-pkg}}/args
[best practices]: /tools/pub/dependencies#best-practices
[caret syntax]: /tools/pub/dependencies#version-constraints
[dev dependency]: /tools/pub/dependencies#dev-dependencies
[`dependency_overrides`]: /tools/pub/dependencies#dependency-overrides
[package dependencies]: /tools/pub/dependencies
[`http`]: {{site.pub-pkg}}/http
[`dart pub deps`]: /tools/pub/cmd/pub-deps
[transitive dependencies]: /resources/glossary#transitive-dependency
