---
title: pub upgrade
title: pub upgrade
description: Use pub upgrade to get the latest versions of all dependencies used by your Dart application.
description: 使用 pub upgrade 命令来更新 Dart 应用的所有依赖项到最新版本
---

_Upgrade_ is one of the commands of the [pub tool](/tools/pub/cmd).

_Upgrade_ 命令是 [Pub 工具](/tools/pub/cmd)中的一个命令。

{% prettify nocode %}
$ pub upgrade [args] [dependencies]
{% endprettify %}

Like [`pub get`](/tools/pub/cmd/pub-get),
`pub upgrade` gets dependencies.
The difference is that `pub upgrade` ignores any existing
[lockfile](/tools/pub/glossary#lockfile),
so that pub can get the latest versions of all dependencies.

`pub upgrade` 命令与 [`pub get`](/tools/pub/cmd/pub-get) 命令一样，都是用于获取依赖项的。不同的是 `pub upgrade` 命令会忽略掉任何已存在的 [lockfile](/tools/pub/glossary#lockfile) 文件，因此 Pub 可以获取所有依赖项的最新版本。

Without any additional arguments, `pub upgrade` gets the latest
versions of all the dependencies listed in the
[`pubspec.yaml`](/tools/pub/pubspec) file in the current working
directory, as well as their [transitive
dependencies](/tools/pub/glossary#transitive-dependency).
For example:

在没有指定其它参数的情况下，`pub upgrade` 命令会获取当前工作目录下 [`pubspec.yaml`](/tools/pub/pubspec) 文件中所列出的所有依赖项的最新版本，包括[这些依赖项中内部依赖的其它依赖项](/tools/pub/glossary#transitive-dependency)。例如：

```terminal
$ pub upgrade
Dependencies upgraded!
```

When `pub upgrade` upgrades dependency versions, it writes a lockfile to ensure that
[`pub get`](/tools/pub/cmd/pub-get) will use the same versions of those
dependencies. For application packages, check in the lockfile to
source control; this ensures the application has the exact same
versions of all dependencies for all developers and when deployed to
production. For library packages, don't check in the lockfile,
because libraries are expected to work with a range of dependency versions.

`pub upgrade` 命令会在更新依赖的版本时写入一个 lockfile 文件以确保后续使用 [`pub get`](/tools/pub/cmd/pub-get) 命令时使用的是相同的依赖版本。对应用 Package 而言，签入 lockfile 文件以控制来源；此操作可以确保当你将应用部署到生产环境时，所有的开发者使用的依赖项都是完全相同的版本以避免冲突。而对库 Package 而言，则不要签入 lockfile 文件，因为库 Package 会使用到各种不同的依赖版本。

If a lockfile already exists, `pub upgrade` ignores it and generates a new
one from scratch, using the latest versions of all dependencies.

`pub upgrade` 命令会忽略掉已经存在的 lockfile 文件并从 Scratch 中新建一个，然后使用所有依赖项的最新版本。

See the [`pub get` documentation](/tools/pub/cmd/pub-get) for more information
on package resolution and the system package cache.

你可以查阅 [`pub get` 命令文档](/tools/pub/cmd/pub-get)获取更多关于 Package 解析以及系统 Package 缓存的信息。

## Upgrading specific dependencies

## 更新指定的依赖项

You can tell `pub upgrade` to upgrade specific dependencies to the
latest version while leaving the rest of the dependencies alone as much as
possible. For example:

你可以使用 `pub upgrade` 命令更新指定的依赖项到最新的版本同时尽可能地保持其余依赖项不变。例如：

```terminal
  $ pub upgrade test args
  Dependencies upgraded!
```

Upgrading a dependency upgrades its transitive dependencies to their latest
versions as well. Usually, no other dependencies are updated; they stay at the
versions that are locked in the lockfile. However, if the requested upgrades
cause incompatibilities with these locked versions, they are selectively
unlocked until a compatible set of versions is found.

更新一个依赖项也会将这个依赖项所依赖的其它依赖项更新到最新版本。通常而言，与这个依赖项无关的其它依赖项不会被更新；它们会保持处于 lockfile 文件中的版本不变。但是，如果该依赖的升级会导致这些锁定的版本不兼容的话，则不兼容的依赖会被解锁，直到找到一个兼容的版本后再重新锁定。

## Getting a new dependency

## 获取一个新的依赖项

If a dependency is added to the pubspec before `pub upgrade` is run,
it gets the new dependency and any of its transitive dependencies,
placing them in the `.packages` file. This
is the same behavior as `pub get`.

如果在运行 `pub upgrade` 命令前将一个依赖项添加至 pubspec 文件，则在运行该命令后会获取新的依赖项以及该依赖项所依赖的其它依赖项，并将它们放在`.packages`文件中。该行为与 `pub get` 命令一致。

## Removing a dependency

## 删除一个依赖项

If a dependency is removed from the pubspec before `pub upgrade` is
run, it removes the dependency from the `.packages` file,
thus making the dependency unavailable for
importing. Any transitive dependencies of the removed dependency are
also removed, as long as no remaining immediate dependencies also
depend on them. This is the same behavior as `pub get`.

如果在运行 `pub upgrade` 命令前将一个依赖项从 pubspec 文件删除，则在运行该命令后会删除 `.packages` 文件中对应的依赖项，且会导致已经导入使用的该依赖项相关代码不可用。任何该依赖项所依赖的其它依赖项也会被同时删除。该行为与 `pub get` 命令一致。

## Upgrading while offline

## 离线更新

If you don't have network access, you can still run `pub upgrade`.
Because pub downloads packages to a central cache shared by all packages
on your system, it can often find previously downloaded packages
without needing to use the network.

However, by default, `pub upgrade` tries to go online if you
have any hosted dependencies,
so that pub can detect newer versions of dependencies.
If you don't want pub to do that, pass it the `--offline` flag.
In offline mode, pub looks only in your local package cache,
trying to find a set of versions that work with your package from what's already
available.

Keep in mind that pub generates a lockfile. If the
only version of some dependency in your cache happens to be old,
offline `pub upgrade` locks your app to that old version.
The next time you are online, you will likely want to
run `pub upgrade` again to upgrade to a later version.


## Options

## 选项

The `pub upgrade` command supports the
[`pub get` options](/tools/pub/cmd/pub-get#options).

`pub upgrade` 命令支持 [`pub get` 的命令选项](/tools/pub/cmd/pub-get#options)。

For options that apply to all pub commands, see
[Global options](/tools/pub/cmd#global-options).

你可以查阅[全局选项](/tools/pub/cmd#global-options)获取 Pub 命令所支持的命令选项。

<aside class="alert alert-info" markdown="1">
*Problems?*
See [Troubleshooting Pub](/tools/pub/troubleshoot).

*有疑问？*
请查阅 [Pub 疑难协助](/tools/pub/troubleshoot)。
</aside>
