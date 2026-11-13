---
# title: dart pub remove
title: dart pub remove 命令
# description: Use dart pub remove to remove a dependency.
description: 使用 dart pub remove 移除一项依赖。
ai-translated: true
---

_Remove_ is one of the commands of the [pub tool](/tools/pub/cmd).

**Remove** 命令是 [pub 工具](/tools/pub/cmd) 中的一个命令。

```plaintext
$ dart pub remove <package> [options]
```

This command removes the specified package from the pubspec as a dependency.

这个命令会从 pubspec 中移除指定的 package 依赖。

For example, the following command is equivalent to
editing `pubspec.yaml` (removing `http` from `dependencies` or `dev_dependencies`)
and then calling `dart pub get`:

例如，下面的命令相当于编辑 `pubspec.yaml`
（从 `dependencies` 或 `dev_dependencies` 中移除 `http`），
然后再执行 `dart pub get`：

```console
$ dart pub remove http
```

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

By default, after removing the specified dependencies,
pub also retrieves the dependencies of the
[`example/` directory][example-dir] of the package (`--example`).
To skip retrieving example dependencies, use `--no-example`.

默认情况下，移除指定依赖之后，
pub 还会获取该 package 的 [`example/` 目录][example-dir] 的依赖（`--example`）。
要跳过获取示例依赖，请使用 `--no-example`。

[example-dir]: /tools/pub/package-layout#examples

## In a workspace

## 在工作区中

In a [Pub workspace](/tools/pub/workspaces) `dart pub remove` removes
dependencies from the package in the current directory.

在 [pub 工作区](/tools/pub/workspaces) 中，`dart pub remove` 会从当前目录的 package 移除依赖。

{% render 'pub-problems.md' %}
