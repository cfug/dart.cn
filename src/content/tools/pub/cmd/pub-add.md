---
# title: dart pub add
title: dart pub add 命令
# description: Use dart pub add to add a dependency.
description: 使用 dart pub add 添加一项依赖。
ai-translated: true
---

_Add_ is one of the commands of the [pub tool](/tools/pub/cmd).

**Add** 命令是 [pub 工具](/tools/pub/cmd) 中的一个命令。

```plaintext
$ dart pub add [{dev|override}:]<package>[:<descriptor>] [[{dev|override}:]<package>[:<descriptor>] ...] [options]
```

This command adds the specified packages to the `pubspec.yaml` as dependencies,
and then retrieves the dependencies to resolve `pubspec.yaml`.

这个命令会把指定的 package 作为依赖写入 `pubspec.yaml`，
然后获取依赖以解析 `pubspec.yaml`。

The following example command is equivalent to
editing `pubspec.yaml` to add the `http` package,
and then calling `dart pub get`:

下面的示例命令相当于编辑 `pubspec.yaml` 添加 `http` package，
然后再执行 `dart pub get`：

```console
$ dart pub add http
```

## Version constraint

## 版本约束

By default, `dart pub add` uses the
latest stable version of the package from the [pub.dev site]({{site.pub}})
that is compatible with your SDK constraints and dependencies.
For example, if `0.13.3` is the latest stable version of the `http` package,
then `dart pub add http` adds `http: ^0.13.3`
under `dependencies` in your `pubspec.yaml`.

默认情况下，`dart pub add` 会使用 [pub.dev 网站]({{site.pub}}) 上
与你的 SDK 约束和依赖兼容的最新稳定版本。
例如，如果 `http` package 的最新稳定版本是 `0.13.3`，
那么 `dart pub add http` 会在 `pubspec.yaml` 的 `dependencies` 下
添加 `http: ^0.13.3`。

You can also specify a constraint or constraint range:

你也可以指定版本约束或约束范围：

```console
$ dart pub add foo:2.0.0
$ dart pub add foo:'^2.0.0'
$ dart pub add foo:'>=2.0.0 <3.0.1'
```

If the specified package is an existing dependency in your `pubspec.yaml`,
`dart pub add` updates the dependency's constraint
to the one specified in the command.

如果指定的 package 已经是 `pubspec.yaml` 中的依赖，
`dart pub add` 会把该依赖的版本约束更新为命令中指定的约束。

## Dev dependency

## 开发依赖

The `dev:` prefix adds the package as a [dev dependency][],
instead of as a regular dependency.

`dev:` 前缀会把 package 添加为 [开发依赖][dev dependency]，
而不是普通依赖。

[dev dependency]: /tools/pub/dependencies#dev-dependencies

```console
$ dart pub add dev:foo           # adds newest compatible stable version of foo
$ dart pub add dev:foo:^2.0.0    # adds specified constraint of foo
$ dart pub add foo dev:bar       # adds regular dependency foo and dev dependency bar simultaneously
```

_Previously the `-d, --dev` option_:

**以前使用的是 `-d, --dev` 选项**：

```console
$ dart pub add --dev foo
```

## Dependency override

## 依赖覆盖

To specify a [dependency override][], add the `override:` prefix and
include a [version constraint](#version-constraint) or other
[package descriptor](/tools/pub/dependencies#package-descriptors).

要指定 [依赖覆盖][dependency override]，请加上 `override:` 前缀，
并带上 [版本约束](#version-constraint) 或其他
[package 描述符](/tools/pub/dependencies#package-descriptors)。

[dependency override]: /tools/pub/dependencies#dependency-overrides

**For example:** To override all references to `package:foo`
to use version `1.0.0` of the package,
run the following command:

**例如：** 要把所有对 `package:foo` 的引用
覆盖为该 package 的 `1.0.0` 版本，请运行下面的命令：

```console
$ dart pub add override:foo:1.0.0
```

This adds the override to your `pubspec.yaml` file:

这会把覆盖项写入你的 `pubspec.yaml` 文件：

```yaml
dependency_overrides:
  foo: 1.0.0
```

<a id="source-descriptor" aria-hidden="true"></a>

## Package descriptor

## package 描述符

To specify the version or [dependency source][] when adding a dependency,
use the [package descriptor][] syntax after the package name and a colon.
For example, the following command adds `package:foo` as a dev dependency
using a git repository as the dependency source:

添加依赖时，要指定版本或 [依赖来源][dependency source]，
请在 package 名称和冒号后面使用 [package 描述符][package descriptor] 语法。
例如，下面的命令会把 `package:foo` 添加为开发依赖，
并使用 git 仓库作为依赖来源：

```console
$ dart pub add dev:foo:"{git: https://github.com/foo/foo}"
```

The descriptor syntax allows you to
add multiple packages from different sources as dependencies and
apply different options and constraints to each.

描述符语法可以一次添加来自不同来源的多个 package 作为依赖，
并为每一个分别指定不同的选项和版本约束。

[dependency source]: /tools/pub/dependencies#dependency-sources
[package descriptor]: /tools/pub/dependencies#package-descriptors

## Options

## 选项

For options that apply to all pub commands, see
[Global options](/tools/pub/cmd#global-options).

适用于所有 pub 命令的选项，请参阅 [全局选项](/tools/pub/cmd#global-options)。

### `--[no-]offline`

### `--[no-]offline` 选项

{% render 'tools/pub-option-no-offline.md' %}

### `-n, --dry-run`

### `-n, --dry-run` 选项

Reports which dependencies would change,
but doesn't change any.

报告哪些依赖会发生变化，但不会实际修改任何内容。

### `--[no-]precompile`

### `--[no-]precompile` 选项

By default, pub precompiles executables
in immediate dependencies (`--precompile`).
To prevent precompilation, use `--no-precompile`.

默认情况下，pub 会预编译直接依赖中的可执行文件（`--precompile`）。
要跳过预编译，请使用 `--no-precompile`。

### `--[no-]example`

### `--[no-]example` 选项

By default, after adding the specified dependencies,
pub also retrieves the dependencies of the
[`example/` directory][example-dir] of the package (`--example`).
To skip retrieving example dependencies, use `--no-example`.

默认情况下，添加指定依赖之后，
pub 还会获取该 package 的 [`example/` 目录][example-dir] 的依赖（`--example`）。
要跳过获取示例依赖，请使用 `--no-example`。

[example-dir]: /tools/pub/package-layout#examples

## In a workspace

## 在工作区中

In a [Pub workspace](/tools/pub/workspaces) `dart pub add` will add
dependencies only to the package in the current directory.

在 [pub 工作区](/tools/pub/workspaces) 中，`dart pub add` 只会把依赖添加到当前目录的 package。

{% render 'pub-problems.md' %}
