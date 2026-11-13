---
# title: dart install
title: dart install 命令
# description: Install Dart CLI tools for global use.
description: 安装 Dart CLI 工具以供全局使用。
ai-translated: true
---

:::version-note
Support for `dart install` was introduced in Dart 3.10.

`dart install` 的支持从 Dart 3.10 开始引入。
:::

The `dart install` command installs Dart CLI tools for global use.
It is a newer alternative to `dart pub global activate`.

`dart install` 命令会安装 Dart CLI 工具，供全局使用。
它是 `dart pub global activate` 的较新替代方案。

## Install a package

## 安装 package

There are a few ways to install a package. To learn more,
see the following sections.

安装 package 有几种方式。更多内容见下列各节。

### Install a general package

### 安装一般的 package

The following command installs all executables specified in
a package's `pubspec.yaml` [executables][] section on the
PATH.

下面的命令会把 package 的 `pubspec.yaml` 中
[executables][] 部分指定的全部可执行文件安装到 PATH 上。

```console
$ dart install [arguments] <package> [version-constraint]
```

For example:

例如：

```console
$ dart install markdown
```

### Install a pub.dev package

### 安装 pub.dev 上的 package

The following command specifies a package on the pub.dev
site to install.

下面的命令指定要安装的 pub.dev 网站上的 package。

```console
$ dart install <pub.dev package>
```

For example:

例如：

```console
$ dart install markdown
```

### Install a Git package

### 安装 Git 上的 package

The following commands can both be used to install a package
in a Git repository.

下面的命令都可以用来安装 Git 仓库中的 package。

```console
$ dart install <Git URL>
```

The following example installs the `async_await` package from
[GitHub][]:

下面的例子从 [GitHub][] 安装 `async_await` package：

```console
$ dart install https://github.com/dart-lang/async_await.git
```

Pub expects to find the package in the root of the Git repository.
To specify a different location, use the `--git-path` option with
a path relative to the repository root:

Pub 期望在 Git 仓库的根目录找到 package。
要指定其他位置，请使用 `--git-path` 选项，
路径相对于仓库根目录：

```console
$ dart install \
  https://github.com/dart-lang/http.git \
  --git-path pkgs/http/
```

Pub uses the default branch of the Git repository. To specify a
different branch or commit, use the `--git-ref` option:

Pub 使用 Git 仓库的默认分支。要指定其他分支或提交，
请使用 `--git-ref` 选项：

```console
$ dart install \
  https://github.com/dart-lang/http.git \
  --git-ref 36f98e900347335af2338a0e087538009b7de2f9
```

## Command reference

## 命令参考

The following commands are useful for installing,
uninstalling, and checking the install state of a
Dart CLI tool.

下列命令用于安装、卸载 Dart CLI 工具，
以及检查其安装状态。

### dart install

### dart install 命令

Installs a package for Dart.

为 Dart 安装一个 package。

```console
$ dart install [arguments] <package> [version-constraint]
```

| <t>Arguments</t><t>参数</t>              | <t>Description</t><t>说明</t>                                                                                            |
| :--------------------- | :----------------------------------------------------------------------------------------------------- |
| **`--git-path`**       | Path of the git package within the repository. This only applies when using a git URL for `<package>`. |
| **`--git-path`**       | git package 在仓库中的路径。仅在 `<package>` 使用 git URL 时适用。 |
| **`--git-ref`**        | The specific git branch or commit to retrieve. This only applies when using a git URL for `<package>`. |
| **`--git-ref`**        | 要获取的特定 git 分支或提交。仅在 `<package>` 使用 git URL 时适用。 |
| **`--overwrite`**      | Allows overwriting executables from other packages that have the same name.                            |
| **`--overwrite`**      | 覆盖其他 package 中同名的可执行文件。 |
| **`-u, --hosted-url`** | A custom pub server URL for the package. This only applies when using a package name for `<package>`.  |
| **`-u, --hosted-url`** | package 的自定义 pub 服务器 URL。仅在 `<package>` 使用 package 名称时适用。 |

In the following example, the markdown package is installed
with no arguments or version constraints:

下面的例子安装 markdown package，
不带参数或版本约束：

```console
$ dart install markdown
```

### dart uninstall

### dart uninstall 命令

Uninstall a package for Dart.

卸载为 Dart 安装的 package。

```console
$ dart uninstall <package>
```

For example:

例如：

```console
$ dart uninstall markdown
```

### dart installed

### dart installed 命令

Check which packages are installed

查看已安装了哪些 package

```console
$ dart installed
```

## Options for the dart install command

## dart install 命令的选项

These options can be use for the `dart install` command.
For options that apply to all pub commands, see
[Global options][].

这些选项可用于 `dart install` 命令。
适用于所有 pub 命令的选项，见
[全局选项][Global options]。

### -h, --help

### -h、--help 参数

Use the `-h` or `--help` option to get help for a specific command.
For example, the following commands produce an overview and list
of arguments available to `dart install`:

使用 `-h` 或 `--help` 选项查看特定命令的帮助。
例如，下面的命令会给出 `dart install` 的概览
以及可用参数列表：

```console
$ dart install --help
```

```console
$ dart install -h
```

### --git-path

### --git-path 参数

Use the `--git-path` option to specify the path of the
package in the Git repository.

使用 `--git-path` 选项指定 package 在 Git 仓库中的路径。

```console
$ dart install --git-path <path>
```

For example:

例如：

```console
$ dart install --git-path https://github.com/dart-lang/async_await.git
```

### --git-ref

### --git-ref 参数

Use the `--git-ref` option to specify the Git branch or commit
to be retrieved.

使用 `--git-ref` 选项指定要获取的 Git 分支或提交。

```console
$ dart install --git-ref <ref>
```

For example:

例如：

```console
$ dart install --git-ref tmpfixes
```

### --overwrite

### --overwrite 参数

Use the `--overwrite` option to overwrite any previously
installed global executables with the same name. If you don't specify
this flag, the preexisting executable will not be replaced.

使用 `--overwrite` 选项覆盖先前安装的、同名的全局可执行文件。
如果不指定该参数，已有的可执行文件不会被替换。

```console
$ dart install <package> --overwrite
```

For example:

例如：

```console
$ dart install markdown --overwrite
```

### --hosted-url

### --hosted-url 参数

Use the `--hosted-url` option to specify a custom pub server
URL for the package. This only applies when using a package name
for `<package>`.

使用 `--hosted-url` 选项为 package 指定自定义 pub 服务器 URL。
仅在 `<package>` 使用 package 名称时适用。

```console
$ dart install --hosted-url <url>
```

For example:

例如：

```console
$ dart install --hosted-url https://dart-packages.example.com/
```

### [version-constraint]

### [version-constraint] 参数

Use the `version-constraint` option to specify a specific version
of the package.

使用 `version-constraint` 选项指定 package 的特定版本。

```console
$ dart install <package> [version-constraint]
```

For example, the following command
pulls the 0.6.0 version of the `markdown` package:

例如，下面的命令会获取 `markdown` package 的 0.6.0 版本：

```console
$ dart install markdown 0.6.0
```

If you specify a range, pub picks the best version that meets that
constraint. For example:

如果指定一个范围，pub 会选择满足该约束的最佳版本。例如：

```console
$ dart install foo <3.0.0
```

[pub tool]: /tools/pub/cmd
[executables]: https://dart.dev/tools/pub/pubspec#executables
[GitHub]: https://github.com/
[Global options]: /tools/pub/cmd#global-options
