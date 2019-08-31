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

{% include flutter-packages.md %}

Quick links to the `pub` commands:

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
</aside>

Pub's commands fall into the following categories:

* [Managing package dependencies](#managing-apps)
* [Running command-line apps](#running-command-line-apps)
* [Deploying packages and apps](#deploying-packages-and-apps)


<a id="managing-apps"></a>
## Managing package dependencies

## 管理包的依赖关系

Pub provides a number of commands for managing the
[packages your code depends on](/tools/pub/dependencies).

In this group, the most commonly used commands are `pub get` and
`pub upgrade`, which retrieve or upgrade dependencies used by a package.
Every time you modify a pubspec file, run `pub get`
to make sure the dependencies are up to date. Some IDEs
perform this step automatically on the creation of a project,
or any modification of the pubspec.

[`pub cache`](/tools/pub/cmd/pub-cache)
: Manages pub's local package cache. Use this command to add packages
  to your cache, or to perform a clean reinstall of all packages in
  your cache.

[`pub deps`](/tools/pub/cmd/pub-deps)
: Lists all dependencies used by the current package.

[`pub downgrade`](/tools/pub/cmd/pub-downgrade)
: Retrieves the lowest versions of all the packages that are
  listed as dependencies used by the current package. Used for testing
  the lower range of your package's dependencies.

[`pub get`](/tools/pub/cmd/pub-get)
: Retrieves the packages that are listed as the dependencies for
  the current package.
  If a `pubspec.lock` file already exists, fetches the version
  of each dependency (if possible) as listed in the lock file.
  Creates or updates the lock file, as needed.

[`pub upgrade`](/tools/pub/cmd/pub-upgrade)
: Retrieves the latest version of each package listed
  as dependencies used by the current package. If a `pubspec.lock`
  file exists, ignores the versions listed in the lock file and fetches
  the newest versions that honor the constraints in the pubspec.
  Creates or updates the lock file, as needed.


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
