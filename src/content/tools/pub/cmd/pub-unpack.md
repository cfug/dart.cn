---
# title: dart pub unpack
title: dart pub unpack 命令
# description: Downloads a package and unpacks its contents in place.
description: 下载一个 package，并就地解包其中的内容。
ai-translated: true
---

:::version-note
The `unpack` subcommand was introduced in Dart 3.4.
To download the archive of a package with an earlier SDK,
visit the **Versions** tab of a package on the [pub.dev site]({{site.pub}}).

`unpack` 子命令在 Dart 3.4 中引入。
如果使用更早的 SDK 下载 package 归档，
请打开 [pub.dev 网站]({{site.pub}}) 上该 package 的 **Versions** 标签页。
:::

_Unpack_ is one of the commands of the [pub tool](/tools/pub/cmd).

**Unpack** 命令是 [pub 工具](/tools/pub/cmd) 中的一个命令。

```plaintext
$ dart pub unpack <package>[:<descriptor>] [--[no-]resolve] [--output=<output directory>] [--[no-]force] [other options]
```

This command downloads the specified `<package>` and
extracts its contents to a `<package>-<version>` directory.

这个命令会下载指定的 `<package>`，
并把内容解压到 `<package>-<version>` 目录。

For example, the following command downloads and extracts the
latest stable version of `package:http` from the [pub.dev site]({{site.pub}}),
to the current directory:

例如，下面的命令会从 [pub.dev 网站]({{site.pub}})
下载并解压 `package:http` 的最新稳定版本到当前目录：

```console
$ dart pub unpack http
```

To change the source or version of the downloaded package,
add a [package descriptor][] after the package name and a colon.
For example, the following command downloads the `1.2.0` release
of `package:http` from the pub.dev site:

要更改所下载 package 的来源或版本，
在 package 名称和冒号后面加上 [package 描述符][package descriptor]。
例如，下面的命令会从 pub.dev 网站下载 `package:http` 的 `1.2.0` 版本：

```console
$ dart pub unpack http:1.2.0
```

To learn more about configuring the dependency source,
check out the documentation on [package descriptors][package descriptor].

要进一步了解如何配置依赖来源，
请参阅 [package 描述符][package descriptor] 的文档。

[package descriptor]: /tools/pub/dependencies#package-descriptors

## Options

## 选项

For options that apply to all pub commands, check out
[Global options](/tools/pub/cmd#global-options).

适用于所有 pub 命令的选项，请参阅 [全局选项](/tools/pub/cmd#global-options)。

### `--force` or `-f` {:#force-option}

### `--force` 或 `-f` 选项

Overwrite existing folders that conflict
with the package folder or its contents during extraction.

解压时，如果已有文件夹与 package 文件夹或其内容冲突，则覆盖这些文件夹。

### `--[no-]resolve` {:#resolve-option}

### `--[no-]resolve` 选项

By default, `dart pub get` runs automatically to complete
package resolution after downloading and unpacking a package.
To disable automatic resolution,
specify the `--no-resolve` flag:

默认情况下，下载并解包 package 之后，
会自动运行 `dart pub get` 以完成 package 解析。
要关闭自动解析，请指定 `--no-resolve` 标志：

```console
$ dart pub unpack http --no-resolve
```

### `--output=<dir>` or `-o <dir>` {:#output-option}

### `--output=<dir>` 或 `-o <dir>` 选项

By default, extract the package to the current directory (`.`).
To change the directory the package is extracted to,
specify the desired output directory with the `--output` option.

默认情况下，package 会解压到当前目录 (`.`)。
要更改解压目录，请用 `--output` 选项指定目标目录。

For example, the following command unpacks the
`1.2.0` release of `package:http` to the `local_http_copies` directory.

例如，下面的命令会把 `package:http` 的 `1.2.0` 版本
解压到 `local_http_copies` 目录。

```console
$ dart pub unpack http:1.2.0 -o local_http_copies
```


{% render 'pub-problems.md' %}
