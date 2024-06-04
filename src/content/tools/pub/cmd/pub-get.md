---
# title: dart pub get
title: dart pub get 命令
# description: >-
#   Use dart pub get to retrieve the dependencies used by your Dart application.
description: 使用 dart pub get 命令检索 Dart 应用使用的依赖项。
---

_Get_ is one of the commands of the [pub tool](/tools/pub/cmd).

_Get_ 命令是 [Pub 工具](/tools/pub/cmd) 中的一个命令。

```plaintext
$ dart pub get [options]
```

This command gets all the dependencies listed in the
[`pubspec.yaml`](/tools/pub/pubspec) file in the current working
directory, as well as their
[transitive dependencies](/tools/pub/glossary#transitive-dependency).
For example:

该命令获取所有在当前工作目录下的 [`pubspec.yaml`](/tools/pub/pubspec)
文件中列出的依赖项，以及这些依赖项的 [间接依赖项](/tools/pub/glossary#transitive-dependency)。
例如：

```console
$ dart pub get
Resolving dependencies...
Got dependencies!
```

If the [system cache](/tools/pub/glossary#system-cache)
doesn't already contain the dependencies, `dart pub get`
updates the cache,
downloading dependencies if necessary.
To map packages back to the system cache,
this command creates a `package_config.json` file
in the `.dart_tool/` directory.

如果 [Pub 的系统缓存](/tools/pub/glossary#system-cache) 中还没有该依赖项，
则 `dart pub get` 命令会在必要时下载该依赖项并更新缓存。
该命令会在 `.dart_tool/` 文件夹下创建一个
`package_config.json` 文件并将之映射到 Pub 的系统缓存中。

Once the dependencies are acquired, they may be referenced in Dart code.
For example, if a package depends on `test`:

一旦依赖获取完毕，就可以在 Dart 代码中引用。
例如，假如 package 依赖了名为 `test` 的 package，则可以使用该 package 下的资源：

```dart
import 'package:test/test.dart';
```

When `dart pub get` gets new dependencies, it writes a
[lockfile](/tools/pub/glossary#lockfile) to ensure that future
gets will use the same versions of those dependencies.
[Application packages][] should check in the lockfile to source control;
this ensures the application will use the exact same versions
of all dependencies for all developers and when deployed to production.
Regular packages should not check in the lockfile, though, since they're
expected to work with a range of dependency versions.

`dart pub get` 命令获取新依赖项后会写入一个 [lockfile](/tools/pub/glossary#lockfile) 文件
以确保下次执行该命令时会使用相同的依赖项版本。
[应用型的 package][Application packages] 应该总是签入该 lockfile 文件以控制来源；
从而确保在将 package 部署到生产环境时所有的依赖项对于所有开发者而言都是相同的版本。
库类型的 package 则不需要签入 lockfile 文件，因为它们可能需要使用到不同的依赖项版本。

If a lockfile already exists, `dart pub get` uses the versions of dependencies
locked in it if possible. If a dependency isn't locked, pub gets the
latest version of that dependency that satisfies all the [version
constraints](/tools/pub/glossary#version-constraint).
This is the primary difference between `dart pub get` and
[`dart pub upgrade`](/tools/pub/cmd/pub-upgrade), which always tries to
get the latest versions of all dependencies.

如果 lockfile 已经存在，`dart pub get` 命令会尽可能地使用锁定的依赖项版本。
如果某个依赖项没有被锁定，则 pub 会获取所有
[限定的版本](/tools/pub/glossary#version-constraint) 中最新的那个依赖项版本。
这是 `dart pub get` 命令与 [`dart pub upgrade`](/tools/pub/cmd/pub-upgrade) 命令最大的不同点，
后者总是会去尝试使用依赖项的最新版本。

[Application packages]: /tools/pub/glossary#application-package

## Package resolution

## Package 解析

By default, pub creates a `package_config.json` file
in the `.dart_tool/` directory that maps from package names to location URIs.

默认情况下，pub 会在 `.dart_tool/` 文件夹下创建一个
`.packages` 文件用于映射 package 名到位置 URI。

:::note

Don't check the generated `.dart_tool/` directory into your repo;
add it to your repo's `.gitignore` file.
For more information, 
see [What not to commit](/guides/libraries/private-files).

不要将仓库中由 pub 自动生成的 `.dart_tool` 目录添加至版本管理中；
请将它添加至 Git 仓库的 `.gitignore` 文件中。
更多信息请查阅 [你不应该提交哪些文件](/guides/libraries/private-files)。

:::


## Getting a new dependency

## 获取一个新的依赖项

If a dependency is added to the pubspec and then `dart pub get` is run,
it gets the new dependency and any of its transitive dependencies.
However, pub won't change the versions of any already-acquired
dependencies unless that's necessary to get the new dependency.

如果在执行 `dart pub get` 命令前将某个依赖添加至 pubspec 文件中，
则在执行该命令后会更新依赖项以及其间接依赖的其它依赖项。
但是，pub 不会更改哪些已经存在的依赖项除非有必要获取它们的新版本。

## Removing a dependency

## 移除一个依赖项

If a dependency is removed from the pubspec and then `dart pub get` is run,
the dependency is no longer available for importing.
Any transitive dependencies of the removed dependency are also removed,
as long as no remaining immediate dependencies also depend on them.
Removing a dependency never changes the versions of any
already-acquired dependencies.

如果在 `dart pub get` 命令前从 pubspec 文件移除了某个依赖项，
则在执行该命令后代码使用到该依赖项的相关导入将变得不可用。
所有该依赖项依赖的间接依赖项也同时会被移除，
只要这些间接依赖项没有没其它的依赖项所依赖。
移除某个依赖项不会对已经获得的依赖项版本产生任何影响。

## The system package cache

## 系统 Package 缓存

Dependencies downloaded over the internet, such as those from Git and the
[pub.dev site]({{site.pub}}), are stored in a
[system-wide cache](/tools/pub/glossary#system-cache).
This means that if multiple packages use the same version of the
same dependency, it only needs to be
downloaded and stored locally once.

依赖项通过网络从类似 Git 仓库和 [Pub 网站]({{site.pub}}) 下载并存储在一个
[系统级的缓存](/tools/pub/glossary#system-cache) 中。
这意味着如果多个 Package 使用了相同依赖项的相同版本，
它就不再需要通过网络下载，而仅仅只需从本地缓存获取即可。

By default, the system package cache is located in the `.pub-cache`
subdirectory of your home directory (on macOS and Linux),
or in `%LOCALAPPDATA%\Pub\Cache` (on Windows;
the location might vary depending on the Windows version).
You can configure the location of the cache by setting the
[`PUB_CACHE`](/tools/pub/environment-variables)
environment variable before running pub.

默认情况下，Pub 缓存存储在你的用户目录（macOS 和 Linux）或
`%APPDATA%\Pub\Cache` 目录下的 `.pub-cache` 子目录中
（Windows，不同版本的 Windows 操作系统可能会不一样）。
你可以在运行 Pub 相关命令前通过 [`PUB_CACHE`](/tools/pub/environment-variables) 
系统环境变量配置你想要的缓存存储目录。

## Getting while offline

## 离线检索

If you don't have network access, you can still run `dart pub get`.
Because pub downloads packages to a central cache shared by all packages
on your system, it can often find previously downloaded packages
without needing to use the network.

在没有网络的情况下你也依然可以运行 `dart pub get` 命令。
因为 pub 会将 Package 下载到一个统一的缓存区并将其与系统上其它的 package 进行共享，
如果你所需的 package 是一个使用频率很高的 package，
那么很有可能它已经被其它 package 在使用时下载到统一缓存区中了，此时你可以直接依赖使用它。

However, by default, `dart pub get` tries to go online if you
have any hosted dependencies,
so that pub can detect newer versions of dependencies.
If you don't want pub to do that, pass it the `--offline` flag.
In offline mode, pub looks only in your local package cache,
trying to find a set of versions that work with your package from what's already
available.

但是，默认情况下，`dart pub get` 命令会总是尝试获取线上的依赖版本，
因此 pub 可以确定依赖项是否有更新的版本。
如果你不想 pub 去线上检查，可以使用 `--offline` 命令参数让该命令在离线模式下执行。
在离线模式下，pub 只会从本地缓存区查找已经下载到的可用 Package。

Keep in mind that pub generates a lockfile. If the
only version of some dependency in your cache happens to be old,
offline `dart pub get` locks your app to that old version.
The next time you are online, you will likely want to
run [`dart pub upgrade`](/tools/pub/cmd/pub-upgrade) to upgrade to a later version.

切记 pub 会生成一个 lockfile 文件。如果缓存中某些依赖项目有且只有一个版本且非常旧，
离线模式下执行 `dart pub get` 命令则依然会使用那些旧的版本。
下次当你有可用的网络时，可以使用
[`dart pub upgrade`](/tools/pub/cmd/pub-upgrade) 命令将其更新到最新版本。

## Options

## 选项

For options that apply to all pub commands, see
[Global options](/tools/pub/cmd#global-options).

你可以查阅 [全局选项](/tools/pub/cmd#global-options) 获取 pub 命令所支持的命令选项。

### `--[no-]offline`

{% render 'tools/pub-option-no-offline.md' %}

### `--dry-run` or `-n`

### `--dry-run` 或 `-n`

Reports the dependencies that would be changed,
but doesn't make the changes. This is useful if you
want to analyze updates before making them.

打印出可能变化的依赖，但不会实际作出更改。
如果你想要在变更前进行分析，该命令非常有用。

### `--[no-]precompile`

By default, pub precompiles executables
in immediate dependencies (`--precompile`).
To prevent precompilation, use `--no-precompile`.

默认情况下，pub 将预编译直接依赖的 package 中的可执行文件 (`--precompile`)。
若你不需要预编译，请使用 `--no-precompile`。

### `--enforce-lockfile`

Refuses to resolve dependencies with an error message
if the `pubspec.lock` file deviates or is missing.

如果 `pubspec.lock` 文件偏离或丢失，
则拒绝通过错误消息解决依赖关系。

{% render 'pub-problems.md' %}
