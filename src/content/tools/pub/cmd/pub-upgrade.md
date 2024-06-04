---
title: dart pub upgrade
# description: Use dart pub upgrade to get the latest versions of all dependencies used by your Dart app.
description: 使用 dart pub upgrade 命令来更新 Dart 应用的所有依赖项到最新版本。
---

_Upgrade_ is one of the commands of the [pub tool](/tools/pub/cmd).

_Upgrade_ 命令是 [Pub 工具](/tools/pub/cmd) 中的一个命令。

```plaintext
$ dart pub upgrade [options] [dependencies]
```

Like [`dart pub get`](/tools/pub/cmd/pub-get),
`dart pub upgrade` gets dependencies.
The difference is that `dart pub upgrade` ignores any existing
[lockfile](/tools/pub/glossary#lockfile),
so that pub can get the latest versions of all dependencies.
A related command is [`dart pub outdated`](/tools/pub/cmd/pub-outdated),
which you can run to find out-of-date dependencies.

`dart pub upgrade` 命令与 [`dart pub get`](/tools/pub/cmd/pub-get)
命令一样，都是用于获取依赖项的。
不同的是 `dart pub upgrade` 命令会忽略掉任何已存在的
[lockfile](/tools/pub/glossary#lockfile) 文件，
因此 Pub 可以获取所有依赖项的最新版本。

Without any additional arguments, `dart pub upgrade` gets the latest
versions of all the dependencies listed in the
[`pubspec.yaml`](/tools/pub/pubspec) file in the current working
directory, as well as their [transitive
dependencies](/tools/pub/glossary#transitive-dependency).
For example:

在没有指定其它参数的情况下，`dart pub upgrade` 命令会获取当前工作目录下
[`pubspec.yaml`](/tools/pub/pubspec) 文件中所列出的所有依赖项的最新版本，
包括 [这些依赖项中内部依赖的其它依赖项](/tools/pub/glossary#transitive-dependency)。
例如：

```console
$ dart pub upgrade
Dependencies upgraded!
```

When `dart pub upgrade` upgrades dependency versions, it writes a lockfile to ensure that
[`dart pub get`](/tools/pub/cmd/pub-get) will use the same versions of those
dependencies. For [application packages][], check in the lockfile to
source control; this ensures the application has the exact same
versions of all dependencies for all developers and when deployed to
production. For regular packages, don't check in the lockfile,
because packages are expected to work with a range of dependency versions.

`dart pub upgrade` 命令会在更新依赖的版本时写入一个 lockfile 文件以确保后续使用
[`dart pub get`](/tools/pub/cmd/pub-get) 命令时使用的是相同的依赖版本。
对 [应用 Package][application packages] 而言，签入 lockfile 文件以控制来源；
此操作可以确保当你将应用部署到生产环境时，
所有的开发者使用的依赖项都是完全相同的版本以避免冲突。
而对库 Package 而言，则不要签入 lockfile 文件，
因为库 Package 会使用到各种不同的依赖版本。

If a lockfile already exists, `dart pub upgrade` ignores it and generates a new
one from scratch, using the latest versions of all dependencies.

`dart pub upgrade` 命令会忽略掉已经存在的 lockfile 文件并从 Scratch 中新建一个，
然后使用所有依赖项的最新版本。

See the [`dart pub get` documentation](/tools/pub/cmd/pub-get) for more information
on package resolution and the system package cache.

你可以查阅 [`dart pub get` 命令文档](/tools/pub/cmd/pub-get)
获取更多关于 Package 解析以及系统 Package 缓存的信息。

[application packages]: /tools/pub/glossary#application-package

## Upgrading specific dependencies

## 更新指定的依赖项

You can tell `dart pub upgrade` to upgrade specific dependencies to the
latest version while leaving the rest of the dependencies alone as much as
possible. For example:

你可以使用 `dart pub upgrade` 命令更新指定的依赖项到最新的版本同时尽可能地保持其余依赖项不变。
例如：

```console
$ dart pub upgrade test args
Dependencies upgraded!
```

Upgrading a dependency upgrades its transitive dependencies to their latest
versions as well. Usually, no other dependencies are updated; they stay at the
versions that are locked in the lockfile. However, if the requested upgrades
cause incompatibilities with these locked versions, they are selectively
unlocked until a compatible set of versions is found.

更新一个依赖项也会将这个依赖项所依赖的其它依赖项更新到最新版本。
通常而言，与这个依赖项无关的其它依赖项不会被更新；
它们会保持处于 lockfile 文件中的版本不变。
但是，如果该依赖的升级会导致这些锁定的版本不兼容的话，
则不兼容的依赖会被解锁，直到找到一个兼容的版本后再重新锁定。

## Getting a new dependency

## 获取一个新的依赖项

If a dependency is added to the pubspec before `dart pub upgrade` is run,
it gets the new dependency and any of its transitive dependencies.
This shares the same behavior as `dart pub get`.

如果在运行 `dart pub upgrade` 命令前将一个依赖项添加至 pubspec 文件，
则在运行该命令后会更新依赖项以及该依赖项所依赖的其它依赖项。
该行为与 `dart pub get` 命令一致。

## Removing a dependency

## 删除一个依赖项

If a dependency is removed from the pubspec before `dart pub upgrade` is run,
the dependency is no longer available for importing.
Any transitive dependencies of the removed dependency are also removed,
as long as no remaining immediate dependencies also depend on them.
This is the same behavior as `dart pub get`.

如果在运行 `dart pub upgrade` 命令前将一个依赖项从 pubspec 文件删除，
则在运行该命令后会导致已经导入使用的该依赖项相关代码不可用。
任何该依赖项所依赖的其它依赖项也会被同时删除。
该行为与 `dart pub get` 命令一致。

## Upgrading while offline

## 离线更新

If you don't have network access, you can still run `dart pub upgrade`.
Because pub downloads packages to a central cache shared by all packages
on your system, it can often find previously downloaded packages
without needing to use the network.

即便没有网络，你也可以运行 `dart pub upgrade` 命令。
因为 Pub 会将 Package 下载到系统的一个缓存中心并与其它 Package 分享，
其它 Package 也可以从该缓存中心获取任意已经下载过的 Package，
如果你所需的 Package 是一个流行的 Package，
则你可以直接从该缓存中依赖该 Package 而不需要使用网络。

However, by default, `dart pub upgrade` tries to go online if you
have any hosted dependencies,
so that pub can detect newer versions of dependencies.
If you don't want pub to do that, pass it the `--offline` flag.
In offline mode, pub looks only in your local package cache,
trying to find a set of versions that work with your package from what's already
available.

但是，默认情况下，`dart pub upgrade` 命令依然会尽可能地访问网络以获取最新的依赖项版本。
如果你不希望其通过网络查找依赖项，可以在该命令后加上 `--offline` 参数。
在离线模式下，Pub 只会从你的本地 Package 缓存中查找已经存在且能适用到你 Package 上的依赖项。

Keep in mind that pub generates a lockfile. If the
only version of some dependency in your cache happens to be old,
offline `dart pub upgrade` locks your app to that old version.
The next time you are online, you will likely want to
run `dart pub upgrade` again to upgrade to a later version.

记住 Pub 会生成一个 lockfile 文件。
如果缓存中某个依赖项只有一个版本且该版本是旧版本，
则在离线模式下 `dart pub upgrade` 命令会锁定你的应用使用这些旧版本。
等你有网时，你可以再次运行 `dart pub upgrade` 命令将它们更新到最新版本。

## Options

## 选项

The `dart pub upgrade` command supports the
[`dart pub get` options](/tools/pub/cmd/pub-get#options), and more.
For options that apply to all pub commands, see
[Global options](/tools/pub/cmd#global-options).

`dart pub upgrade` 命令支持
[`dart pub get` 的命令选项](/tools/pub/cmd/pub-get#options) 以及更多的选项。
你可以查阅[全局选项](/tools/pub/cmd#global-options) 获取 Pub 命令所支持的命令选项。

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

默认情况下，pub 会预编译直接依赖的 package 的可执行文件 (`precompile`)。
若你不需要预编译，请使用 `--no-precompile`。

### `--major-versions`

Gets the packages that [`dart pub outdated`][] lists as _resolvable_,
ignoring any upper-bound constraint in the `pubspec.yaml` file.
Also updates `pubspec.yaml` with the new constraints.

获取 [`dart pub outdated`][] 列表中标记为 **resolvable** 的依赖，
忽略 `pubspec.yaml` 文件中的任何上限。
同时 `pubspec.yaml` 文件中的限制也会更新。

[`dart pub outdated`]: /tools/pub/cmd/pub-outdated

:::tip

Commit the `pubspec.yaml` file before running this command,
so that you can undo the changes if necessary.

在运行该命令前提交 `pubspec.yaml` 文件的修改，这样如果有需要时可以进行回滚。

:::

To check which dependencies will be upgraded,
you can use `dart pub upgrade --major-versions --dry-run`.

想查看哪些依赖会被更新，可以运行
`dart pub upgrade --major-versions --dry-run`。

### `--tighten`

Updates the lower bounds of dependencies in `pubspec.yaml` to match the
resolved versions, and returns a list of the changed constraints. 
Can be applied to [specific dependencies](#upgrading-specific-dependencies).  

更新 `pubspec.yaml` 文件中的依赖下限，
并与已解析的版本相匹配后，返回已改变约束的依赖列表。
可用于 [指定的依赖](#upgrading-specific-dependencies)。


{% render 'pub-problems.md' %}
