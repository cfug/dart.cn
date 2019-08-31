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

`pub` 工具包含管理包以及部署包和命令行应用的命令。有关如何使用 pub 包管理器的信息，请查阅[如何使用包](/guides/packages)。

{% include flutter-packages.md %}

Quick links to the `pub` commands:

`pub` 相关命令链接：

* [`pub cache`](/tools/pub/cmd/pub-cache)
* [`pub deps`](/tools/pub/cmd/pub-deps)
* [`pub downgrade`](/tools/pub/cmd/pub-downgrade)
* [`pub get`](/tools/pub/cmd/pub-get)
* [`pub global`](/tools/pub/cmd/pub-global)
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

  [管理包的依赖关系](#managing-apps)

* [Running command-line apps](#running-command-line-apps)

  [运行命令行应用](#running-command-line-apps)

* [Deploying packages and apps](#deploying-packages-and-apps)

  [部署包和应用](#deploying-packages-and-apps)


<a id="managing-apps"></a>
## Managing package dependencies

## 管理包的依赖关系

Pub provides a number of commands for managing the
[packages your code depends on](/tools/pub/dependencies).

Pub 提供了许多管理[代码依赖包](/tools/pub/dependencies)的命令。

In this group, the most commonly used commands are `pub get` and
`pub upgrade`, which retrieve or upgrade dependencies used by a package.
Every time you modify a pubspec file, run `pub get`
to make sure the dependencies are up to date. Some IDEs
perform this step automatically on the creation of a project,
or any modification of the pubspec.

在这些命令中，最常用的是 `pub get` 和 `pub upgrade`，前者用于检索包的依赖项，后者用于更新包的依赖项。每一次你修改了 pubspec 文件后都需要执行 `pub get` 命令来确保你所用的依赖项是最新的。一些 IDE 会在创建项目或修改了 pubspec 文件后自动执行此操作。

[`pub cache`](/tools/pub/cmd/pub-cache)
: Manages pub's local package cache. Use this command to add packages
  to your cache, or to perform a clean reinstall of all packages in
  your cache.

[`pub cache`](/tools/pub/cmd/pub-cache)：管理 Pub 的本地包缓存。使用该命令你可以将一个包添加至缓存，或者清除所有缓存重新安装包。

[`pub deps`](/tools/pub/cmd/pub-deps)
: Lists all dependencies used by the current package.

[`pub deps`](/tools/pub/cmd/pub-deps)：显示当前包使用的所有依赖项。

[`pub downgrade`](/tools/pub/cmd/pub-downgrade)
: Retrieves the lowest versions of all the packages that are
  listed as dependencies used by the current package. Used for testing
  the lower range of your package's dependencies.

[`pub downgrade`](/tools/pub/cmd/pub-downgrade)：检索当前包所有依赖项的包的最低版本。用于测试较低版本的包依赖项兼容性。

[`pub get`](/tools/pub/cmd/pub-get)
: Retrieves the packages that are listed as the dependencies for
  the current package.
  If a `pubspec.lock` file already exists, fetches the version
  of each dependency (if possible) as listed in the lock file.
  Creates or updates the lock file, as needed.

[`pub get`](/tools/pub/cmd/pub-get)：检索当前包所依赖项的包。如果 `pubspec.lock` 已经存在，则在该文件中列出获取的每个依赖项版本（如果可能的话）。如有必要，将会创建或更新该文件。

[`pub upgrade`](/tools/pub/cmd/pub-upgrade)
: Retrieves the latest version of each package listed
  as dependencies used by the current package. If a `pubspec.lock`
  file exists, ignores the versions listed in the lock file and fetches
  the newest versions that honor the constraints in the pubspec.
  Creates or updates the lock file, as needed.

[`pub upgrade`](/tools/pub/cmd/pub-upgrade)：检索当前包所依赖项的包的最新版本。如果 `pubspec.lock` 已经存在，则忽略其缓存的版本并以 pubspec 文件中指定的最新版本为主。如有必要，将会创建或更新该文件。

## Running command-line apps

## 运行命令行应用

Two commands let you run Dart scripts from the command line:

* The [`pub run`](/tools/pub/cmd/pub-run) command invokes a Dart script in your
  package, or in one of its dependencies.

* The [`pub global`](/tools/pub/cmd/pub-global) command lets you work with
  globally available packages.

## Deploying packages and apps

## 部署包和应用

With pub you can publish packages and command-line apps.

{% include tools/pub-was-a-builder.md %}

### Packages

### 包

To share your Dart packages with the world, you can
use the [`pub publish`](/tools/pub/cmd/pub-lish) command to upload the
package to the [Pub site]({{site.pub}}). The
[`pub uploader`](/tools/pub/cmd/pub-uploader) command enables specific
users to modify and upload new versions of your package.

### Command-line apps

### 命令行应用

For any package that contains scripts (anything under the `bin/`
directory), consider adding the `executables` tag to the pubspec file.
When a script is listed under `executables`, users can run
[`pub global activate`](/tools/pub/cmd/pub-global#activating-a-package)
to make it directly available from the command line.

---

## Global options

## 全局选项

Several command-line options work with all of the pub commands.
These include:

有几个命令行选线可以用于所有 pub 命令。它们包括：

`--help` or `-h`
: Print usage information.

`--help` 或 `-h`：显示使用说明。

`--version`
: Print version of pub.

`--version`：显示当前 pub 命令的版本。

`--trace`
: Print debugging information when an error occurs.

`--trace`：当出现错误时输出调试信息。

`--verbosity=<level>`
: The specified level determines the amount of information that is displayed:

`--verbosity=<level>`：指定输出信息的级别：

* `all`
: Show all output, including internal tracing messages.

* `all`：显示所有出输出，包括内部追踪信息。

* `io`
: Show I/O operations.

* `io`：显示 I/O 操作。

* `normal`
: Show errors, warnings, and user messages.

* `normal`：显示错误、警告以及用户信息。

* `solver`
: Show steps during version resolution.

* `solver`：显示版本解析的步骤。

`-verbose` or `-v`
: Equivalent to `--verbosity=all`.

`-verbose` 或 `-v`：等同于 `--verbosity=all`。
