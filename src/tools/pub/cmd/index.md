---
title: The pub tool
title: Pub 工具
description: The command-line interface for pub, a package management tool for Dart.
description: Pub 的命令行工具，是 Dart 的 package 管理工具。
---

The [pub package manager](/guides/packages) has a command-line interface
that works with either the
[`flutter` tool][flutter-cli] or the [`dart` tool][dart-cli].
With either tool, add the `pub` command followed by
a subcommand such as `get`:

```terminal
$ dart pub get    # Gets dependencies for a non-Flutter package
$ flutter pub get # Gets dependencies for a Flutter package
```

This site uses `dart pub <subcommand>` for its examples,
but if your current directory holds a Flutter app
or other Flutter-specific code,
use `flutter pub <subcommand>` instead.
For more information, see
[Using packages]({{site.flutter}}/using-packages)
on the [Flutter website]({{site.flutter}}).

[flutter-cli]: {{site.flutter}}/docs/reference/flutter-cli
[dart-cli]: /tools/dart-tool

{{ site.alert.version-note }}
  The `dart pub` command debuted in Dart 2.10.
  Although you might still find examples of
  using the standalone `pub` command instead of
  `dart pub` or `flutter pub`,
  the standalone `pub` command is deprecated.
{{ site.alert.end }}

If you encounter problems using the pub tool,
see [Troubleshooting Pub](/tools/pub/troubleshoot).


## List of subcommands

Detailed documentation exists for each of the following pub subcommands:

* [`cache`](/tools/pub/cmd/pub-cache)
* [`deps`](/tools/pub/cmd/pub-deps)
* [`downgrade`](/tools/pub/cmd/pub-downgrade)
* [`get`](/tools/pub/cmd/pub-get)
* [`global`](/tools/pub/cmd/pub-global)
* [`outdated`](/tools/pub/cmd/pub-outdated)
* [`publish`](/tools/pub/cmd/pub-lish)
* [`upgrade`](/tools/pub/cmd/pub-upgrade)
* [`uploader`](/tools/pub/cmd/pub-uploader)


## Overview of subcommands

Pub's subcommands fall into the following categories:

Pub 的命令可以分为以下几类：

* [Managing package dependencies](#managing-apps)

  [管理 Package 的依赖关系](#managing-apps)

* [Running command-line apps](#running-command-line-apps)

  [运行命令行应用](#running-command-line-apps)

* [Deploying packages and apps](#deploying-packages-and-apps)

  [部署 Package 和应用](#deploying-packages-and-apps)


<a id="managing-apps"></a>
### Managing package dependencies

### 管理 Package 的依赖关系

Pub provides a number of subcommands for managing the
[packages your code depends on](/tools/pub/dependencies).

Pub 提供了许多命令，这些命令用于管理那些
[你代码所依赖 Package](/tools/pub/dependencies)。

In this group, the most commonly used subcommands are `get` and
`upgrade`, which retrieve or upgrade dependencies used by a package.
Every time you modify a pubspec file,
run `dart pub get` or `flutter pub get`
to make sure the dependencies are up to date. Some IDEs
perform this step automatically on the creation of a project,
or any modification of the pubspec.

在这些命令中，最常用的是 `get` 命令和 `upgrade` 命令，
前者用于检索 Package 的依赖项，后者用于更新 Package 的依赖项。
每一次你修改了 pubspec 文件后都需要执行 `dart pub get` 或
`flutter pub get` 命令来确保你所用的依赖项是最新的。
一些 IDE 会在创建项目或修改了 pubspec 文件后自动执行此操作。

[`cache`](/tools/pub/cmd/pub-cache)
: Manages pub's local package cache. Use this subcommand to add packages
  to your cache, or to perform a clean reinstall of all packages in
  your cache.

[`cache`](/tools/pub/cmd/pub-cache) 命令
<br>用于管理 Pub 的本地 Package 缓存。使用该命令你可以将一个 Package 添加至缓存，
或者清除所有缓存的 Package 并重新安装。

[`deps`](/tools/pub/cmd/pub-deps)
: Lists all dependencies used by the current package.

[`deps`](/tools/pub/cmd/pub-deps) 命令
<br>用于显示当前 Package 使用的所有依赖项。

[`downgrade`](/tools/pub/cmd/pub-downgrade)
: Retrieves the lowest versions of all the packages that are
  listed as dependencies used by the current package. Used for testing
  the lower range of your package's dependencies.

[`downgrade`](/tools/pub/cmd/pub-downgrade) 命令
<br>用于检索当前 Package 所依赖的其它 Package 的最低版本。
用于测试这些较低版本依赖项的 Package 在当前 Package 上的兼容性。

[`get`](/tools/pub/cmd/pub-get)
: Retrieves the packages that are listed as the dependencies for
  the current package.
  If a `pubspec.lock` file already exists, fetches the version
  of each dependency (if possible) as listed in the lock file.
  Creates or updates the lock file, as needed.
  
[`get`](/tools/pub/cmd/pub-get) 命令
<br>用于检索当前 Package 所依赖的其它 Package。
如果 `pubspec.lock` 文件已经存在，
则根据该文件中保存的依赖项版本获取对应的依赖项。
如有必要，将会创建或更新该文件。

[`outdated`](/tools/pub/cmd/pub-outdated)
: Looks at every package that the current package depends on,
  determines which package dependencies are out of date,
  and gives you advice on how to update them.
  Use this subcommand when you want to update package dependencies.

[`outdated`](/tools/pub/cmd/pub-outdated) 命令
<br> 查看当前软件包所依赖的每个 package，确定哪些 package 的依赖项已过时，
并为您提供有关如何更新它们的建议。当您要更新 package 的依赖性时，请使用此命令。

[`upgrade`](/tools/pub/cmd/pub-upgrade)
: Retrieves the latest version of each package listed
  as dependencies used by the current package. If a `pubspec.lock`
  file exists, ignores the versions listed in the lock file and fetches
  the newest versions that honor the constraints in the pubspec.
  Creates or updates the lock file, as needed.

[`upgrade`](/tools/pub/cmd/pub-upgrade) 命令
<br>用于检索当前 Package 所依赖的其它 Package 的最新版本。
如果 `pubspec.lock` 文件已经存在，
则忽略其保存的版本并以 pubspec 文件中指定的最新版本为主。
如有必要，将会创建或更新该文件。

### Running command-line apps

### 运行命令行应用

The [`global`](/tools/pub/cmd/pub-global) subcommand lets you 
make a package globally available, 
so you can run scripts from that package’s `bin` directory.
To run globally available scripts, you must
[add the system cache `bin` directory to your path][add-path].

[add-path]: /tools/pub/cmd/pub-global#running-a-script-from-your-path

### Deploying packages and apps

## 部署 Package 和应用

With pub you can publish packages and command-line apps.

使用 pub 命令你还可以发布 Package 和命令行应用。

{% include tools/pub-was-a-builder.md %}

#### Packages

### Package

To share your Dart packages with the world, you can
use the [`publish`](/tools/pub/cmd/pub-lish) subcommand to upload the
package to the [pub.dev site]({{site.pub}}). The
[`uploader`](/tools/pub/cmd/pub-uploader) subcommand enables specific
users to modify and upload new versions of your package.

你可以使用 [`publish`](/tools/pub/cmd/pub-lish) 命令将
Package 上传至 [Pub 网站]({{site.pub}})以分享给全世界的开发者使用。
[`uploader`](/tools/pub/cmd/pub-uploader) 命令则可以允许指定用户
修改 Package 和上传新版本的 Package。

#### Command-line apps

#### 命令行应用

For any package that contains scripts (anything under the `bin/`
directory), consider adding the `executables` tag to the pubspec file.
When a script is listed under `executables`, users can run
[`dart pub global activate`](/tools/pub/cmd/pub-global#activating-a-package)
to make it directly available from the command line.

任何包含脚本（即在 `bin/` 目录下有任意文件）的 Package，
可以在 pubspec 文件中添加上 `executables` 标签。
当一个脚本标识为 `executables` 时，
用户可以直接从命令行使用
[`pub global activate`](/tools/pub/cmd/pub-global#activating-a-package) 
命令运行它。

## Global options

## 全局选项

Several command-line options work with all of the pub subcommands.
These include:

有几个命令行选线可以用于所有 pub 命令。它们包括：

`--help` or `-h`
<br> Print usage information.

`--help` 或 `-h`
<br>显示使用说明。

`--version`
<br> Print version of pub.

`--version`
<br>显示当前 pub 命令的版本。

`--trace`
<br> Print debugging information when an error occurs.

`--trace`
<br>当出现错误时输出调试信息。

`--verbosity=<level>`
<br> The specified level determines the amount of information that is displayed:

`--verbosity=<level>`
<br>指定输出信息的级别：

* `all`
<br> Show all output, including internal tracing messages.

  `all`：显示所有出输出，包括内部追踪信息。

* `io`
<br> Show I/O operations.

  `io`：显示 I/O 操作。

* `normal`
<br> Show errors, warnings, and user messages.

  `normal`：显示错误、警告以及用户信息。

* `solver`
<br> Show steps during version resolution.

  `solver`：显示版本解析的步骤。

`-verbose` or `-v`
<br> Equivalent to `--verbosity=all`.

`-verbose` 或 `-v`
<br> 等同于 `--verbosity=all`。
