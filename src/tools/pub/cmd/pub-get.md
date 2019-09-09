---
title: pub get
title: pub get
description: Use pub get to retrieve the dependencies used by your Dart application.
description: 使用 pub get 命令检索 Dart 应用使用的依赖项。
---

_Get_ is one of the commands of the [pub tool](/tools/pub/cmd).

_Get_ 命令是 [Pub 工具](/tools/pub/cmd) 中的一个命令。

{% prettify nocode %}
$ pub get [--offline]
{% endprettify %}

This command gets all the dependencies listed in the
[`pubspec.yaml`](/tools/pub/pubspec) file in the current working
directory, as well as their
[transitive dependencies](/tools/pub/glossary#transitive-dependency).
For example:

该命令获取所有在当前工作目录下的 [`pubspec.yaml`](/tools/pub/pubspec) 文件中列出的依赖项，以及这些依赖项的 [间接依赖项](/tools/pub/glossary#transitive-dependency)。例如：

```terminal
$ pub get
Got dependencies!
```

If the [system cache](/tools/pub/glossary#system-cache)
doesn't already contain the dependencies, `pub get`
updates the cache,
downloading dependencies if necessary.
To map packages back to the system cache,
this command creates a `.packages` file.

如果 [Pub 的系统缓存](/tools/pub/glossary#system-cache) 中还没有该依赖项，则 `pub get` 命令会在必要时下载该依赖项并更新缓存。该命令会创建一个 `.packages` 文件并将之映射到 Pub 的系统缓存中。

Once the dependencies are acquired, they may be referenced in Dart code.
For example, if a package depends on `test`:

一旦依赖获取完毕，就可以在 Dart 代码中引用。例如，假如 Package 依赖了名为 `test` 的 Package，则可以使用该 Package 下的资源：

{% prettify dart %}
import 'package:test/test.dart';
{% endprettify %}

When `pub get` gets new dependencies, it writes a
[lockfile](/tools/pub/glossary#lockfile) to ensure that future
gets will use the same versions of those dependencies.
Application packages should check in the lockfile to source control;
this ensures the application will use the exact same versions
of all dependencies for all developers and when deployed to production.
Library packages should not check in the lockfile, though, since they're
expected to work with a range of dependency versions.

`pub get` 命令获取新依赖项后会写入一个 [lockfile](/tools/pub/glossary#lockfile) 文件以确保下次执行该命令时会使用相同的依赖项版本。应用型的 Package 应该总是签入该 lockfile 文件以控制来源；从而确保在将 Package 部署到生产环境时所有的依赖项对于所有开发者而言都是相同的版本。库类型的 Package 则不需要签入 lockfile 文件，因为它们可能需要使用到不同的依赖项版本。

If a lockfile already exists, `pub get` uses the versions of dependencies
locked in it if possible. If a dependency isn't locked, pub gets the
latest version of that dependency that satisfies all the [version
constraints](/tools/pub/glossary#version-constraint).
This is the primary difference between `pub get` and
[`pub upgrade`](/tools/pub/cmd/pub-upgrade), which always tries to
get the latest versions of all dependencies.

如果 lockfile 已经存在，`pub get` 命令会尽可能地使用锁定的依赖项版本。如果某个依赖项没有被锁定，则 Pub 会获取所有 [限定的版本](/tools/pub/glossary#version-constraint) 中最新的那个依赖项版本。这是 `pub get` 命令与 [`pub upgrade`](/tools/pub/cmd/pub-upgrade) 命令最大的不同点，后者总是会去尝试使用依赖项的最新版本。

{% include pub-in-prereleases.html %}

## Package resolution

## Package 解析

By default, pub creates a `.packages` file
that maps from package names to location URIs.
Before the `.packages` file, pub used to create `packages` directories.

默认情况下，Pub 会创建一个 `.packages` 文件用于映射 Package 名到位置 URI。在创建 `.packages` 文件之前，Pub 常常还会创建一个 `packages` 目录。

<aside class="alert alert-info" markdown="1">
**Note:** Don't check the generated `.packages` file,
`packages` directories (if present), or
`.dart_tool` directory into your repo;
add them to your repo's `.gitignore` file.
For more information, see
[What Not to Commit](/guides/libraries/private-files).

**注意：** 不要去检出你仓库中由 Pub 自动生成的 `.packages` 文件、`packages` 目录（如果存在的话）或者 `.dart_tool` 目录；请将它们添加至 Git 仓库的 `.gitignore` 文件中。更多信息请查阅 [你不应该提交哪些文件](/guides/libraries/private-files)。
{% comment %}
PENDING: here just to make it easy to find discussions of `packages`...
{% include packages-dir.html %}
{% endcomment %}
</aside>

For more information, see the
[package specification file proposal.](https://github.com/lrhn/dep-pkgspec/blob/master/DEP-pkgspec.md#proposal)

更多信息请查阅 [Package 文件规范建议。](https://github.com/lrhn/dep-pkgspec/blob/master/DEP-pkgspec.md#proposal)

## Getting a new dependency

## 获取一个新的依赖项

If a dependency is added to the pubspec and then `pub get` is run,
it gets the new dependency and any of its transitive dependencies and
updates the mapping in the `.packages` file.
However, pub won't change the versions of any already-acquired
dependencies unless that's necessary to get the new dependency.


## Removing a dependency

## 移除一个依赖项

If a dependency is removed from the pubspec and then `pub get` is run,
it removes the dependency from the `.packages` file,
making the dependency unavailable for importing.
Any transitive dependencies of the removed dependency are also removed,
as long as no remaining immediate dependencies also depend on them.
Removing a dependency never changes the versions of any
already-acquired dependencies.


## The system package cache

## 系统 Package 缓存

Dependencies downloaded over the internet, such as those from Git and the
[Pub site]({{site.pub}}), are stored in a
[system-wide cache](/tools/pub/glossary#system-cache).
This means that if multiple packages use the same version of the
same dependency, it only needs to be
downloaded and stored locally once.

By default, the system package cache is located in the `.pub-cache`
subdirectory of your home directory (on Mac and Linux),
or in `%APPDATA%\Pub\Cache` (on Windows;
the location might vary depending on the Windows version).
You can configure the location of the cache by setting the
[`PUB_CACHE`](/tools/pub/environment-variables)
environment variable before running pub.


## Getting while offline

## 离线检索

If you don't have network access, you can still run `pub get`.
Because pub downloads packages to a central cache shared by all packages
on your system, it can often find previously downloaded packages
without needing to use the network.

在没有网络的情况下你也依然可以运行 `pub get` 命令。因为 Pub 会将 Package 下载到一个统一的缓存区并将其与系统上其它的 Package 进行共享，如果你所需的 Package 是一个使用频率很高的 Package，那么很有可能它已经被其它 Package 在使用时下载到统一缓存区中了，此时你可以直接依赖使用它。

However, by default, `pub get` tries to go online if you
have any hosted dependencies,
so that pub can detect newer versions of dependencies.
If you don't want pub to do that, pass it the `--offline` flag.
In offline mode, pub looks only in your local package cache,
trying to find a set of versions that work with your package from what's already
available.

但是，默认情况下，`pub get` 命令会总是尝试获取线上的依赖版本，因此 Pub 可以确定依赖项是否有更新的版本。如果你不想 Pub 去线上检查，可以使用 `--offline` 命令参数让该命令在离线模式下执行。在离线模式下，Pub 只会从本地缓存区查找已经下载到的可用 Package。

Keep in mind that pub generates a lockfile. If the
only version of some dependency in your cache happens to be old,
offline `pub get` locks your app to that old version.
The next time you are online, you will likely want to
run [`pub upgrade`](/tools/pub/cmd/pub-upgrade) to upgrade to a later version.

切记 Pub 会生成一个 lockfile 文件。如果缓存中某些依赖项目有且只有一个版本且非常旧，离线模式下执行 `pub get` 命令则依然会使用那些旧的版本。下次当你有可用的网络时，可以使用 [`pub upgrade`](/tools/pub/cmd/pub-upgrade) 命令将其更新到最新版本。

## Options

## 选项

The `pub get` command supports the `--offline`
command-line argument, as discussed above.

`pub get` 命令支持我们上面所说的 `--offline` 命令行参数。

For options that apply to all pub commands, see
[Global options](/tools/pub/cmd#global-options).

你可以查阅 [全局选项](/tools/pub/cmd#global-options) 获取 Pub 命令所支持的命令选项。

<aside class="alert alert-info" markdown="1">
*Problems?*
See [Troubleshooting Pub](/tools/pub/troubleshoot).

**有疑问？**
请查阅 [Pub 疑难协助](/tools/pub/troubleshoot)。
</aside>
