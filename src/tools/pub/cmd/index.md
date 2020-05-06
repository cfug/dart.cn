---
title: The pub tool
title: Pub 工具
description: Pub, a package management tool for Dart, supports a variety of commands.
description: Pub 是一个支持各种命令的 Dart 包管理工具。
---

The `pub` tool has commands for managing packages
and for deploying packages and command-line apps.
For general information about using the pub package manager, see
[How to use packages](/guides/packages).

`pub` 工具包含管理 Package 、部署 Package 和部署命令行应用的命令。有关如何使用 Pub Package 管理器的信息，请查阅[如何使用 Package](/guides/packages)。

{% include flutter-packages.md %}

Quick links to the `pub` commands:

`pub` 相关命令链接：

* [`pub cache`](/tools/pub/cmd/pub-cache)
* [`pub deps`](/tools/pub/cmd/pub-deps)
* [`pub downgrade`](/tools/pub/cmd/pub-downgrade)
* [`pub get`](/tools/pub/cmd/pub-get)
* [`pub global`](/tools/pub/cmd/pub-global)
* [`pub outdated`](/tools/pub/cmd/pub-outdated)
* [`pub publish`](/tools/pub/cmd/pub-lish)
* [`pub run`](/tools/pub/cmd/pub-run)
* [`pub upgrade`](/tools/pub/cmd/pub-upgrade)
* [`pub uploader`](/tools/pub/cmd/pub-uploader)

<aside class="alert alert-info" markdown="1">
*Problems?*
See [Troubleshooting Pub](/tools/pub/troubleshoot).

*有疑问？*
请查阅 [Pub 疑难协助](/tools/pub/troubleshoot).
</aside>

Pub's commands fall into the following categories:

Pub 的命令可以分为以下几类：

* [Managing package dependencies](#managing-apps)

  [管理 Package 的依赖关系](#managing-apps)

* [Running command-line apps](#running-command-line-apps)

  [运行命令行应用](#running-command-line-apps)

* [Deploying packages and apps](#deploying-packages-and-apps)

  [部署 Package 和应用](#deploying-packages-and-apps)


<a id="managing-apps"></a>
## Managing package dependencies

## 管理 Package 的依赖关系

Pub provides a number of commands for managing the
[packages your code depends on](/tools/pub/dependencies).

Pub 提供了许多命令，这些命令用于管理那些
[你代码所依赖 Package](/tools/pub/dependencies)。

In this group, the most commonly used commands are `pub get` and
`pub upgrade`, which retrieve or upgrade dependencies used by a package.
Every time you modify a pubspec file, run `pub get`
to make sure the dependencies are up to date. Some IDEs
perform this step automatically on the creation of a project,
or any modification of the pubspec.

在这些命令中，最常用的是 `pub get` 命令和 `pub upgrade` 命令，
前者用于检索 Package 的依赖项，后者用于更新 Package 的依赖项。
每一次你修改了 pubspec 文件后都需要执行 `pub get` 命令
来确保你所用的依赖项是最新的。
一些 IDE 会在创建项目或修改了 pubspec 文件后自动执行此操作。

[`pub cache`](/tools/pub/cmd/pub-cache)
<br> Manages pub's local package cache. Use this command to add packages
  to your cache, or to perform a clean reinstall of all packages in
  your cache.

[`pub cache`](/tools/pub/cmd/pub-cache) 命令
<br>用于管理 Pub 的本地 Package 缓存。使用该命令你可以将一个 Package 添加至缓存，
或者清除所有缓存的 Package 并重新安装。

[`pub deps`](/tools/pub/cmd/pub-deps)
<br> Lists all dependencies used by the current package.

[`pub deps`](/tools/pub/cmd/pub-deps) 命令
<br>用于显示当前 Package 使用的所有依赖项。

[`pub downgrade`](/tools/pub/cmd/pub-downgrade)
<br> Retrieves the lowest versions of all the packages that are
  listed as dependencies used by the current package. Used for testing
  the lower range of your package's dependencies.

[`pub downgrade`](/tools/pub/cmd/pub-downgrade) 命令
<br>用于检索当前 Package 所依赖的其它 Package 的最低版本。
用于测试这些较低版本依赖项的 Package 在当前 Package 上的兼容性。

[`pub get`](/tools/pub/cmd/pub-get)
<br> Retrieves the packages that are listed as the dependencies for
  the current package.
  If a `pubspec.lock` file already exists, fetches the version
  of each dependency (if possible) as listed in the lock file.
  Creates or updates the lock file, as needed.
  
[`pub get`](/tools/pub/cmd/pub-get) 命令
<br>用于检索当前 Package 所依赖的其它 Package。
如果 `pubspec.lock` 文件已经存在，
则根据该文件中保存的依赖项版本获取对应的依赖项。
如有必要，将会创建或更新该文件。

[`pub outdated`](/tools/pub/cmd/pub-outdated)
<br> Looks at every package that the current package depends on,
  determines which package dependencies are out of date,
  and gives you advice on how to update them.
  Use this command when you want to update package dependencies.
  
[`pub outdated`](/tools/pub/cmd/pub-outdated) 命令
<br> 查看当前软件包所依赖的每个 package，确定哪些 package 的依赖项已过时，
并为您提供有关如何更新它们的建议。当您要更新 package 的依赖性时，请使用此命令。

[`pub upgrade`](/tools/pub/cmd/pub-upgrade)
<br> Retrieves the latest version of each package listed
  as dependencies used by the current package. If a `pubspec.lock`
  file exists, ignores the versions listed in the lock file and fetches
  the newest versions that honor the constraints in the pubspec.
  Creates or updates the lock file, as needed.

[`pub upgrade`](/tools/pub/cmd/pub-upgrade) 命令
<br>用于检索当前 Package 所依赖的其它 Package 的最新版本。
如果 `pubspec.lock` 文件已经存在，
则忽略其保存的版本并以 pubspec 文件中指定的最新版本为主。
如有必要，将会创建或更新该文件。

## Running command-line apps

## 运行命令行应用

Two commands let you run Dart scripts from the command line:

你可以使用下面两个命令从命令行运行 Dart 脚本：

* The [`pub run`](/tools/pub/cmd/pub-run) command invokes a Dart script in your
  package, or in one of its dependencies.

  [`pub run`](/tools/pub/cmd/pub-run) 命令可以调用当前 Package 或
  当前 Package 所依赖的其它 Package 中的 Dart 脚本。

* The [`pub global`](/tools/pub/cmd/pub-global) command lets you work with
  globally available packages.

  [`pub global`](/tools/pub/cmd/pub-global) 命令
  可以让你使用那些可以全局可用的 Package。

## Deploying packages and apps

## 部署 Package 和应用

With pub you can publish packages and command-line apps.

使用 pub 命令你还可以发布 Package 和命令行应用。

{% include tools/pub-was-a-builder.md %}

### Packages

### Package

To share your Dart packages with the world, you can
use the [`pub publish`](/tools/pub/cmd/pub-lish) command to upload the
package to the [pub.dev site]({{site.pub}}). The
[`pub uploader`](/tools/pub/cmd/pub-uploader) command enables specific
users to modify and upload new versions of your package.

你可以使用 [`pub publish`](/tools/pub/cmd/pub-lish) 命令将
Package 上传至 [Pub 网站]({{site.pub}})以分享给全世界的开发者使用。
[`pub uploader`](/tools/pub/cmd/pub-uploader) 命令则可以允许指定用户
修改 Package 和上传新版本的 Package。

### Command-line apps

### 命令行应用

For any package that contains scripts (anything under the `bin/`
directory), consider adding the `executables` tag to the pubspec file.
When a script is listed under `executables`, users can run
[`pub global activate`](/tools/pub/cmd/pub-global#activating-a-package)
to make it directly available from the command line.

任何包含脚本（即在 `bin/` 目录下有任意文件）的 Package，
可以在 pubspec 文件中添加上 `executables` 标签。
当一个脚本标识为 `executables` 时，
用户可以直接从命令行使用
[`pub global activate`](/tools/pub/cmd/pub-global#activating-a-package) 
命令运行它。

---

## Global options

## 全局选项

Several command-line options work with all of the pub commands.
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
