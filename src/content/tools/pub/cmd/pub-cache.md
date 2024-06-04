---
title: dart pub cache
# description: Use dart pub cache to manage your system cache.
description: 使用 dart pub cache 命令管理你系统中的缓存。
toc: false
---

_Cache_ is one of the commands of the [pub tool](/tools/pub/cmd).

_Cache_ 命令是 [Pub 工具](/tools/pub/cmd) 中的一个命令。

```plaintext
$ dart pub cache add <package> [--version <constraint>] [--all]
$ dart pub cache repair
$ dart pub cache clean
```

The `dart pub cache` command works with the
[system cache](/tools/pub/glossary#system-cache).

## Adding a package to the system cache

## 缓存一个 package 到本地

You can manually add a package to your system cache:

你可以手动缓存一个 package 到本地：

```console
$ dart pub cache add <package>
```

## Reinstalling all packages in the system cache

## 重建所有 packages 的本地缓存

You can perform a clean reinstallation of all packages in your system cache:

你可以将本地所有 package 的缓存清空并重新下载：

```console
$ dart pub cache repair
```

This command can be useful when packages in your system cache
are somehow changed or broken.

当你的本地缓存发生了意料之外的变化或损坏时，这个命令将非常有用。

For example, some editors make it easy to find implementation files
for packages in the system cache,
and you might accidentally edit one of those files.

例如，一部分编辑器可以很轻易地打开本地缓存中的文件，
此时你有可能在不经意间对它们进行改动。

## Clearing the global system cache

## 清空全局的本地缓存

You can empty the entire system cache
to reclaim extra disk space or remove problematic packages:

你可以使用以下命令清空缓存，从而释放空间或删除有问题的 package 缓存：

```console
$ dart pub cache clean
```

:::version-note

The `clean` subcommand was introduced in Dart 2.14.
To clear your system cache with an older SDK,
you can manually delete the [`PUB_CACHE`][] folder.

`clean` 命令是在 Dart 2.14 引入的。
若你需要在旧版本的 SDK 中清理缓存，
你可以手动删除 [`PUB_CACHE`][] 文件夹。

:::

[`PUB_CACHE`]: /tools/pub/environment-variables

## Options

## 选项

For options that apply to all pub commands, see
[Global options](/tools/pub/cmd#global-options).

你可以查阅 [全局选项](/tools/pub/cmd#global-options) 获取 Pub 命令所支持的命令选项。

### `--all`

Use `dart pub cache add --all` 
to install all matching versions of a library.

与 `dart pub add` 结合使用用于安装某个库的所有版本。

### `--version `_`<constraint>`_

Use with `dart pub cache add`
to install the version best matching the specified constraint. 
For example:

与 `dart pub add` 结合使用根据限制条件安装最适合的版本。例如：

```console
$ dart pub cache add http --version "0.12.2"
```

If `--version` is omitted, pub installs the best of all known versions.

如果省略掉 `--version`，Pub 会从已知的版本中挑选一个最适合的进行安装。

{% render 'pub-problems.md' %}
