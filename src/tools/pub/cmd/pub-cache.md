---
title: dart pub cache
title: dart pub cache
description: Use dart pub cache to manage your system cache.
description: 使用 dart pub cache 命令管理你系统中的缓存。
toc: false
---

_Cache_ is one of the commands of the [pub tool](/tools/pub/cmd).

_Cache_ 命令是 [Pub 工具](/tools/pub/cmd) 中的一个命令。

```nocode
$ dart pub cache add <package> [--version <constraint>] [--all]
$ dart pub cache repair
```

The `dart pub cache` command works with the
[system cache](/tools/pub/glossary#system-cache).

## Adding a package to the system cache

You can manually add a package to your system cache:

```terminal
$ dart pub cache add <package>
```

## Reinstalling all packages in the system cache

You can perform a clean reinstallation of all packages in your system cache:

```terminal
$ dart pub cache repair
```

This command can be useful when packages in your system cache
are somehow changed or broken.

For example, some editors make it easy to find implementation files
for packages in the system cache,
and you might accidentally edit one of those files.

## Clearing the global system cache

You can empty the entire system cache:

```terminal
$ dart pub cache clear
```

`dart pub cache` 命令用于操作 [Pub 位于系统中的缓存](/tools/pub/glossary#system-cache)。你可以使用 `dart pub cache add` 命令将新的 Package 添加至缓存。也可以使用 `dart pub cache repair` 命令将 Package 从缓存中清除并重新安装。

## Options

## 选项

For options that apply to all pub commands, see
[Global options](/tools/pub/cmd#global-options).

你可以查阅 [全局选项](/tools/pub/cmd#global-options) 获取 Pub 命令所支持的命令选项。
### `--all`

Use `dart pub cache add --all` 
to install all matching versions of a library.

使用 `dart pub cache add --all` 命令安装用于某个库的所有版本。

### `--version `_`<constraint>`_

Use with `dart pub cache add`
to install the version best matching the specified constraint. 
For example:

使用 `dart pub cache add` 命令安装根据限制条件安装最适合的版本。
例如：

```terminal
$ dart pub cache add http --version "0.12.2"
```

If `--version` is omitted, pub installs the best of all known versions.

如果省略掉 <code>--version</code>，Pub 会从已知的版本中挑选一个最适合的进行安装。

{{site.alert.info}}
  *Problems?*
  See [Troubleshooting Pub](/tools/pub/troubleshoot).
{{site.alert.end}}

<dt><code>repair</code></dt>
<dd>It's possible for packages in your pub cache to change or break.
For example, some editors make it easy to find implementation files for
packages in the pub cache, and you might accidentally edit one of those files.
The <code>dart pub cache repair</code> command performs a clean reinstall of all
hosted and git packages in the system cache.</dd>

<dd>您的 pub 缓存中的 package 是有可能被修改或破坏的。例如，某些编辑器可以轻松地在 pub 缓存中找到 package 的实现文件，而你也许会对这些文件进行修改导致它们与原本的逻辑不一致。<code>dart pub cache repair</code> 命令可以对系统缓存中的所有 package 执行重安装以修正篡改的问题。</dd>

<aside class="alert alert-info" markdown="1">
  *Problems?* See [Troubleshooting Pub](/tools/pub/troubleshoot).

  **有疑问？** 请查阅 [Pub 疑难协助](/tools/pub/troubleshoot)。
</aside>
