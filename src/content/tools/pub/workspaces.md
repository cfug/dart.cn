---
# title: Pub workspaces (monorepo support)
title: pub 工作区（monorepo 支持）
# shortTitle: Workspaces
shortTitle: 工作区
# description: Learn more about pub workspaces, a way to manage package monorepos.
description: 进一步了解 pub 工作区，一种管理 package monorepo 的方式。
ai-translated: true
---

When working on a project, you might develop multiple Dart packages in the same
version control repository (a _monorepo_).

做项目时，你可能会在同一个版本控制仓库（即 **monorepo**）里开发多个 Dart package。

For example, you might have a directory layout like: 

例如，目录布局可能像这样：

<FileTree>

- /
  - packages/
    - shared/
      - pubspec.yaml
      - pubspec.lock
      - .dart_tool/
        - package_config.json
    - client_package/
      - pubspec.yaml
      - pubspec.lock
      - .dart_tool/
        - package_config.json
    - server_package/
      - pubspec.yaml
      - pubspec.lock
      - .dart_tool/
        - package_config.json

</FileTree>

There are some downsides to this setup:

这种布局有一些缺点：

* You need to run `dart pub get` once for each package.

  每个 package 都要单独运行一次 `dart pub get`。

* You risk ending up with different versions of dependencies for each package,
  leading to confusion when context switching between the packages.

  各个 package 的依赖版本可能不一致，
  在 package 之间切换时容易造成混淆。

* If you open the root folder in your IDE, the dart analyzer will create
  separate analysis contexts for each package, increasing memory usage.

  如果在 IDE 中打开根目录，Dart 分析器会为每个 package 创建单独的分析上下文，
  从而增加内存占用。

Pub allows you to organize your repository as a _workspace_ using a single
shared resolution for all your packages.
Using workspaces for large repositories reduces the amount of memory
required for analysis, hence improving performance.

pub 可以把仓库组织成一个 **工作区**，让所有 package 共用同一次解析。
大型仓库使用工作区可以减少分析所需的内存，从而提升性能。

:::note
Using a single shared dependency resolution for all your packages increases
the risks of dependency conflicts, because Dart doesn't allow multiple versions
of the same package.

If the packages are going to be used together (as is commonly the case),
this risk is a useful feature. It forces you to resolve incompatibilities between
your packages when they arise, rather than when you start using the packages.

让所有 package 共用同一次依赖解析，会增加依赖冲突的风险，
因为 Dart 不允许同一个 package 存在多个版本。

如果这些 package 会一起使用（通常就是这样），
这种风险反而是有用的特性。它会促使你在不兼容出现时就解决，
而不是等到开始使用这些 package 时才处理。
:::

To create a workspace:

要创建工作区：

* Add a `pubspec.yaml` at the repository root directory with a `workspace` entry
  enumerating the paths to the packages of the repository (the workspace
  packages):

  在仓库根目录添加 `pubspec.yaml`，用 `workspace` 条目列出仓库中各个 package 的路径
  （即工作区 package）：

  ```yaml
  name: _
  publish_to: none
  environment:
    sdk: ^3.6.0
  workspace:
    - packages/shared
    - packages/client_package
    - packages/server_package
  ```

* For each of the existing `pubspec.yaml` files, make sure their SDK constraint
  is at least `^3.6.0` and add a `resolution` entry:

  对于每个已有的 `pubspec.yaml`，请确保 SDK 约束至少为 `^3.6.0`，
  并添加 `resolution` 条目：

  ```yaml
  environment:
    sdk: ^3.6.0
  resolution: workspace
  ```

* Run `dart pub get` anywhere in the repository. This will:

  在仓库的任意位置运行 `dart pub get`。这会：

  * Create a single `pubspec.lock` next to the root `pubspec.yaml` that contains
    the resolution of all the `dependencies` and `dev_dependencies` of all the
    workspace packages. 

    在根 `pubspec.yaml` 旁边创建一份 `pubspec.lock`，
    其中包含所有工作区 package 的全部 `dependencies` 和 `dev_dependencies` 的解析结果。

  * Create a single shared `.dart_tool/package_config.json` that maps package
    names to file locations.

    创建一份共享的 `.dart_tool/package_config.json`，把 package 名称映射到文件位置。

  * Delete any other existing `pubspec.lock` and
    `.dart_tool/package_config.json` files next to workspace packages.

    删除工作区 package 旁边已有的其他 `pubspec.lock` 和
    `.dart_tool/package_config.json` 文件。

Now the file structure looks like this:

现在的文件结构如下：

<FileTree>

- /
  - packages/
    - shared/
      - pubspec.yaml
    - client_package/
      - pubspec.yaml
    - server_package/
      - pubspec.yaml
  - pubspec.yaml
  - pubspec.lock
  - .dart_tool/
    - package_config.json

</FileTree>

:::version-note
Support for pub workspaces was introduced in Dart 3.6.0.

To use pub workspaces, all your workspace packages (but not your dependencies)
must have an SDK version constraint of `^3.6.0` or higher.

pub 工作区支持在 Dart 3.6.0 中引入。

要使用 pub 工作区，所有工作区 package（不包括你的依赖）
的 SDK 版本约束都必须是 `^3.6.0` 或更高。
:::

## Glob pattern support

## glob 模式支持

:::version-note
Glob pattern support requires Dart 3.11 or later.
If you use an earlier version, use explicit paths instead.

glob 模式支持需要 Dart 3.11 或更高版本。
如果使用更早的版本，请改用明确的路径。
:::

The `workspace` entry supports glob patterns to
automatically include packages:

`workspace` 条目支持用 glob 模式自动包含 package：

```yaml
workspace:
  - packages/*
```

This includes all subdirectories in
`packages/` that contain a `pubspec.yaml` file,
eliminating the need to manually list each package.
This is especially useful for large or frequently growing monorepos.

这会包含 `packages/` 中所有带有 `pubspec.yaml` 文件的子目录，
不必再手动列出每个 package。
对于很大或经常增长的 monorepo，这尤其有用。

Instead of:

而不是写成：

```yaml
workspace:
  - packages/shared
  - packages/client_package
  - packages/server_package
```

You can use a glob pattern that automatically picks up new packages.

你可以使用 glob 模式，自动纳入新的 package。

## Nested workspaces

## 嵌套工作区

You can nest workspaces to organize packages
hierarchically in large repositories.
A workspace member can declare its own `workspace` field,
just like the root `pubspec.yaml`.

你可以嵌套工作区，在大型仓库中按层次组织 package。
工作区成员可以像根 `pubspec.yaml` 一样，声明自己的 `workspace` 字段。

For example, if a `server` package splits its implementation
into `auth` and `api` sub-packages,
list them in the `workspace` field of the `server` package:

例如，如果 `server` package 把实现拆成 `auth` 和 `api` 两个子 package，
就把它们列在 `server` package 的 `workspace` 字段中：

```yaml title="packages/server/pubspec.yaml" highlightLines=7-9
name: server

resolution: workspace
environment:
  sdk: ^3.6.0

workspace:
  - auth
  - api
```

Then mark each sub-package as using workspace resolution:

然后把每个子 package 标记为使用工作区解析：

```yaml title="packages/server/auth/pubspec.yaml" highlightLines=3
name: auth

resolution: workspace
environment:
  sdk: ^3.6.0
```

The root `pubspec.yaml` only needs to list `packages/server`.
Pub discovers `auth` and `api` through the `workspace` entry of
the `server` package and includes them in the
single, shared dependency resolution.

根 `pubspec.yaml` 只需要列出 `packages/server`。
pub 会通过 `server` package 的 `workspace` 条目发现 `auth` 和 `api`，
并把它们纳入同一次共享的依赖解析。

## Stray files

## 散落文件

When you migrate an existing monorepo to use Pub workspaces, there will
be existing "stray" `pubspec.lock` and `.dart_tool/package_config.json` files
adjacent to each pubspec. These shadow the `pubspec.lock` and
`.dart_tool/package_config.json` files placed next to the root.

把现有 monorepo 迁移到 pub 工作区时，
每个 pubspec 旁边往往已经有「散落」的 `pubspec.lock` 和
`.dart_tool/package_config.json` 文件。
它们会遮住放在根目录旁边的 `pubspec.lock` 和
`.dart_tool/package_config.json`。

Therefore, `pub get` will delete any `pubspec.lock` and
`.dart_tool/package_config.json` located in directories between the root and
(including) any workspace package.

因此，`pub get` 会删除从根目录到任意工作区 package（含该 package 所在目录）
之间的所有 `pubspec.lock` 和 `.dart_tool/package_config.json`。

<FileTree>

- /                    
  - packages/
    - foo/
      - pubspec.yaml   # Workspace member
      - pubspec.lock   # Deleted by `pub get`
      - .dart_tool/package_config.json # Deleted by `pub get`
    - pubspec.lock     # Deleted by `pub get`
    - .dart_tool/package_config.json # Deleted by `pub get`
  - pubspec.yaml       # Root

</FileTree>

If any directory between the workspace root and a workspace package contains a
"stray" `pubspec.yaml` file that is not member of the workspace, `pub get` will
report an error and fail to resolve. This is because resolving such a `pubspec.yaml` would
create a `.dart_tool/package_config.json` file that shadows the one at the root.

如果工作区根目录和工作区 package 之间的某个目录里，
有一份不属于工作区成员的「散落」`pubspec.yaml`，
`pub get` 会报错并且解析失败。
这是因为解析这样的 `pubspec.yaml` 会创建一份
`.dart_tool/package_config.json`，从而遮住根目录的那一份。

For example:

例如：

<FileTree>

- /
  - packages/
    - foo/
      - pubspec.yaml    # Workspace member
    - pubspec.yaml      # Not workspace member => error
  - pubspec.yaml        # Root `workspace: ['packages/foo']`

</FileTree>

## Interdependencies between workspace packages

## 工作区 package 之间的相互依赖

If any of the workspace packages depend on each other, they will automatically
resolve to the one in the workspace, regardless of the source.

如果工作区 package 相互依赖，无论来源是什么，
都会自动解析到工作区里的那一份。

Eg. `packages/client_package/pubspec.yaml` might depend on `shared`:

例如，`packages/client_package/pubspec.yaml` 可能依赖 `shared`：

```yaml
dependencies:
  shared: ^2.3.0
```

When resolved inside the workspace, the _local_ version of `shared` will be
used.

在工作区内部解析时，会使用 `shared` 的 **本地** 版本。

The local version of `shared` would still have to match the constraint
(`^2.3.0`) though.

不过，`shared` 的本地版本仍然必须满足版本约束（`^2.3.0`）。

But when the package is consumed as a dependency without being part of the
workspace, the original source (here implicitly `hosted`) is used.

但是，当这个 package 作为依赖被使用、而又不属于该工作区时，
会使用原来的来源（这里隐式为 `hosted`）。

So if `client_package` is published to pub.dev and someone depends on it, they
will get the hosted version of `shared` as a transitive dependency.

因此，如果 `client_package` 发布到 pub.dev 并且有人依赖它，
对方会把托管版本的 `shared` 作为传递依赖获取到。

## Dependency overrides in a workspace

## 工作区中的依赖覆盖

All `dependency_overrides` sections in the workspace packages are respected.
You can also place a `pubspec_overrides.yaml` file next to any of the
workspace `pubspec.yaml` files.

工作区 package 中的所有 `dependency_overrides` 部分都会生效。
你也可以在任意工作区 `pubspec.yaml` 旁边放置 `pubspec_overrides.yaml` 文件。

You can only override a package once in the workspace. To keep overrides organized,
it's preferable to keep `dependency_overrides` in the root `pubspec.yaml`.

在工作区中，同一个 package 只能覆盖一次。
为了让覆盖项保持整齐，最好把 `dependency_overrides` 放在根 `pubspec.yaml` 中。

## Running a command in a specific workspace package

## 在指定的工作区 package 中运行命令

Some pub commands, such as `dart pub add`, and `dart pub publish` operate on a
"current" package. You can either change the directory, or use `-C` to point pub at
a directory:

有些 pub 命令，例如 `dart pub add` 和 `dart pub publish`，针对「当前」package 操作。
你可以切换目录，或者用 `-C` 让 pub 指向某个目录：

```console
$ dart pub -C packages/client_package publish
# Same as
$ cd packages/client_package ; dart pub publish ; cd -
```

## Temporarily resolving a package outside its workspace:

## 临时在工作区之外解析某个 package：

Sometimes you might want to resolve a workspace package on its own, for example
to validate its dependency constraints.

有时你可能想单独解析某个工作区 package，例如为了校验它的依赖约束。

One way to do this is to create a `pubspec_overrides.yaml` file that resets the
`resolution` setting, like so:

一种做法是创建 `pubspec_overrides.yaml` 文件，重置 `resolution` 设置，如下所示：

```yaml
# packages/client_package/pubspec_overrides.yaml
resolution:
```

Now running `dart pub get` inside `packages/client_package` will create an
independent resolution.

现在在 `packages/client_package` 里运行 `dart pub get`，就会创建一次独立的解析。

## Listing all workspace packages

## 列出所有工作区 package

You can run `dart pub workspace list` to list the packages of a workspace.

你可以运行 `dart pub workspace list` 来列出工作区中的 package。

```console
$ dart pub workspace list
Package         Path                      
_               ./                        
client_package  packages/client_package/  
server_package  packages/server_package/  
shared          packages/shared/
```
