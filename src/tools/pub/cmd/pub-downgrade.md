---
title: pub downgrade
title: pub downgrade
description: Use pub downgrade to get the lowest versions of all dependencies used by your Dart application.
description: 使用 pub downgrade 命令可以获取你 Dart 应用所使用的所有依赖项的最低版本。
---

_Downgrade_ is one of the commands of the [pub tool](/tools/pub/cmd).

_Downgrade_ 命令是 [Pub 工具](/tools/pub/cmd)中的一个命令。

{% prettify sh %}
$ pub downgrade [args] [dependencies]
{% endprettify %}

Without any additional arguments, `pub downgrade` gets the lowest versions of
all the dependencies listed in the [`pubspec.yaml`](/tools/pub/pubspec) file
in the current working directory, as well as their [transitive
dependencies](/tools/pub/glossary#transitive-dependency).
For example:

在没有其它额外参数的情况下，`pub downgrade` 命令会获取当前工作目录下 [`pubspec.yaml`](/tools/pub/pubspec) 文件中列出的所有依赖项以及它们 [间接依赖项](/tools/pub/glossary#transitive-dependency) 的最低版本。例如：

```terminal
$ pub downgrade
Resolving dependencies... (1.2s)
+ barback 0.13.0
+ collection 0.9.1
+ path 1.2.0
+ source_maps 0.9.0
+ source_span 1.0.0
+ stack_trace 0.9.1
Changed 6 dependencies!
```

The `pub downgrade` command creates a lockfile. If one already exists,
pub ignores that file and generates a new one from scratch, using the lowest
versions of all dependencies.

`pub downgrade` 命令会创建一个 lockfile 文件。如果 lockfile 文件已经存在，Pub 则会忽略该文件并通过 Scratch 生成一个新的 lockfile 文件，然后所有依赖项都会使用最低版本。

See the [`pub get` documentation](/tools/pub/cmd/pub-get) for more information
on package resolution and the system package cache.

请查阅 [`pub get` 命令文档](/tools/pub/cmd/pub-get) 获取更多关于 Package 解析和系统 Package 缓存的信息。

## Downgrading specific dependencies

## 降级指定依赖项

It's possible to tell `pub downgrade` to downgrade specific dependencies to the
lowest version while leaving the rest of the dependencies alone as much as
possible. For example:

你可以指定 `pub downgrade` 命令只将某个依赖项的版本降至最低且不影响其余依赖项。例如：

```terminal
$ pub downgrade test
Resolving dependencies...
  barback 0.15.2+2
  bot 0.27.0+2
  browser 0.10.0+2
  chrome 0.6.5
  collection 1.1.0
  path 1.3.0
  pool 1.0.1
  source_span 1.0.2
< stack_trace 0.9.2 (was 1.1.1)
  stagexl 0.10.2
< test 0.10.0 (was 0.11.4)
These packages are no longer being depended on:
- matcher 0.11.3
Changed 3 dependencies!
```

If you are downgrading a specific dependency, pub tries to find the
highest versions of any transitive dependencies that fit the new dependency
constraints. Any transitive dependencies are usually also downgraded
as a result.

如果你降低指定依赖项的版本，且该依赖项还有间接依赖项，那么在版本变更后这些间接依赖项可能不适配降低后的新版依赖项。此时，Pub 会尝试在新版本依赖项可接受的范围内查找版本最高的该依赖项所依赖的间接依赖项。因此，通常而言，降低某个依赖项的版本后，其间接依赖项的版本也会随之降低。

## Getting a new dependency

## 获取新的依赖项

If a dependency is added to the pubspec before `pub downgrade` is run,
it gets the new dependency and any of its transitive dependencies,
placing them in the `.packages` file. This
is the same behavior as `pub get`.

如果在执行 `pub downgrade` 命令前将某个依赖添加至 pubspec 文件中，则在执行该命令后会将该新的依赖项以及其间接依赖的其它依赖项下载并将其放到 `.packages` 文件中。这点与 `pub get` 命令一致。

## Removing a dependency

## 移除依赖项

If a dependency is removed from the pubspec before `pub downgrade` is
run, it removes the dependency from the `.packages` file,
thus making the dependency unavailable for
importing. Any transitive dependencies of the removed dependency are
also removed, as long as no remaining immediate dependencies also
depend on them. This is the same behavior as `pub get`.

如果在 `pub downgrade` 命令前从 pubspec 文件移除了某个依赖项，则在执行该命令后会将该依赖项从 `.packages` 文件中移除，且代码使用到该依赖项的相关导入将变得不可用。所有该依赖项依赖的间接依赖项也同时会被移除，只要这些间接依赖项没有没其它的依赖项所依赖。这点与 `pub get` 命令一致。

## Downgrading while offline

## 离线降级

If you don't have network access, you can still run `pub downgrade`.
Because pub downloads packages to a central cache shared by all packages
on your system, it can often find previously downloaded packages
without needing to use the network.

在没有网络的情况下你也依然可以运行 `pub downgrade` 命令。因为 Pub 会将 Package 下载到一个统一的缓存区并将其与系统上其它的 Package 进行共享，如果你所需的 Package 是一个使用频率很高的 Package，那么很有可能它已经被其它 Package 在使用时下载到统一缓存区中了，此时你可以直接依赖使用它。

However, by default, `pub downgrade` tries to go online if you
have any hosted dependencies.
If you don't want pub to do that, pass it the `--offline` flag.
In offline mode, pub looks only in your local package cache,
trying to find a set of versions that work with your package from what's already
available.

但是，默认情况下，`pub downgrade` 命令会总是尝试获取线上的依赖版本，因此 Pub 可以确定依赖项是否有更新的版本。如果你不想 Pub 去线上检查，可以使用 `--offline` 命令参数让该命令在离线模式下执行。在离线模式下，Pub 只会从本地缓存区查找已经下载到的可用 Package。

## Options {#options}

## 选项 {#options}

The `pub downgrade` command supports the
[`pub get` options](/tools/pub/cmd/pub-get#options).

`pub upgrade` 命令支持 [`pub get` 的命令选项](/tools/pub/cmd/pub-get#options)。

For options that apply to all pub commands, see
[Global options](/tools/pub/cmd#global-options).

你可以查阅 [全局选项](/tools/pub/cmd#global-options) 获取 Pub 命令所支持的命令选项。

<aside class="alert alert-info" markdown="1">
  *Problems?* See [Troubleshooting Pub](/tools/pub/troubleshoot).

  **有疑问？** 请查阅 [Pub 疑难协助](/tools/pub/troubleshoot)。
</aside>
