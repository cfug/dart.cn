---
# title: Packaging and distributing Dart CLI tools
title: 打包并分发 Dart CLI 工具
# description: A guide for creating, building, and distributing command-line applications in Dart.
description: 在 Dart 中创建、构建并分发命令行应用的指南。
ai-translated: true
---

:::version-note
Dart 3.10 introduced support for `dart install`
and stable build hooks (`hook/build.dart`).
Dart 3.9 introduced the `dart build cli` command
for compiling CLI apps.

Dart 3.10 开始支持 `dart install`，
以及稳定的构建钩子（`hook/build.dart`）。
Dart 3.9 引入了 `dart build cli` 命令，
用于编译 CLI 应用。
:::

A Dart CLI tool is a standalone command-line application
distributed via the Pub package manager.
Creating your own CLI tools allows you to share developer utilities,
build scripts, or fully-featured desktop console applications
with the broader Dart ecosystem.

Dart CLI 工具是通过 Pub 包管理器分发的独立命令行应用。
编写自己的 CLI 工具，就可以把开发者实用程序、
构建脚本或功能完整的桌面控制台应用
分享给更广泛的 Dart 生态。

## Writing entrypoints

## 编写入口点

When a user installs a tool via [`dart install`][],
Pub looks for the entrypoints defined in your package's `pubspec.yaml` file.

用户通过 [`dart install`][] 安装工具时，
Pub 会查找 package 的 `pubspec.yaml` 中定义的入口点。

Create a Dart script in the `bin/` directory of your package.
For example, `bin/my_tool.dart`:

在 package 的 `bin/` 目录中创建一个 Dart 脚本。
例如 `bin/my_tool.dart`：

```dart
void main(List<String> arguments) {
  print('Hello from my tool!');
}
```

Then, map this script to a command name in your `pubspec.yaml`
using the `executables` section:

然后在 `pubspec.yaml` 的 `executables` 部分，
把这个脚本映射到一个命令名：

```yaml
name: my_package
version: 1.0.0
# ... other metadata

executables:
  my_tool: my_tool
```

The key (`my_tool`) is the name of the executable command
that Pub places on the user's PATH,
and the value (`my_tool`) corresponds to the `bin/my_tool.dart` script.

键（`my_tool`）是 Pub 放到用户 PATH 上的可执行命令名，
值（`my_tool`）对应 `bin/my_tool.dart` 脚本。

## Compiling via dart build cli

## 通过 dart build cli 编译

Starting in Dart 3.9, you can explicitly compile CLI applications
using the `dart build cli` command.

从 Dart 3.9 起，可以使用 `dart build cli` 命令
显式编译 CLI 应用。

Under the hood, `dart install` automatically invokes `dart build cli`
to create **AOT-compiled, self-contained native executables** for your tool.

在内部，`dart install` 会自动调用 `dart build cli`，
为工具生成 **经过 AOT 编译、自包含的原生可执行文件**。

AOT (Ahead-of-Time) compilation means your tool starts up instantly
without booting a Dart VM or JIT-compiling code dynamically,
leading to much faster and more consistent execution times for your users.

AOT（提前编译）意味着工具可以立即启动，
不必启动 Dart VM，也不必在运行时做 JIT 编译，
用户会得到更快、更稳定的执行时间。

## Adding build hooks

## 添加构建钩子

If your CLI tool depends on native C/C++ libraries
or needs to bundle specific data assets,
you can utilize [code assets and build hooks](/tools/hooks).

如果 CLI 工具依赖原生 C/C++ 库，
或需要打包特定的数据资源，
可以使用 [代码资源和构建钩子](/tools/hooks)。

By writing a `hook/build.dart` script,
you can instruct the Dart SDK to compile or download native dependencies
when the user installs your package.
`dart install` fully supports these hooks,
ensuring the compiled output (dynamic libraries and assets)
is placed alongside the AOT-compiled executable in the application bundle.

编写 `hook/build.dart` 脚本后，
可以让 Dart SDK 在用户安装 package 时
编译或下载原生依赖。
`dart install` 完整支持这些钩子，
并确保编译产物（动态库和资源）
与 AOT 编译的可执行文件一起放进应用包。

## Distribution

## 分发

Once your package is published to pub.dev (or pushed to a Git repository),
users can install it globally using the [`dart install`][] command:

package 发布到 pub.dev（或推送到 Git 仓库）之后，
用户可以用 [`dart install`][] 命令全局安装：

```console
$ dart install my_package
```

This command resolves dependencies,
runs any build hooks,
AOT-compiles the executable,
and places the resulting binary in the `$DART_DATA_HOME/install/bin` directory.

该命令会解析依赖、
运行所有构建钩子、
对可执行文件做 AOT 编译，
并把生成的二进制文件放到 `$DART_DATA_HOME/install/bin` 目录。

Depending on the platform, the default location is:

默认位置因平台而异：

| <t>Platform</t><t>平台</t> | <t>Default path</t><t>默认路径</t> |
|---|---|
| **macOS** | `$HOME/Library/Application Support/Dart/install/bin` |
| **macOS** | `$HOME/Library/Application Support/Dart/install/bin` |
| **Linux** | `$HOME/.local/share/dart/install/bin` (or `$XDG_DATA_HOME/dart/install/bin`) |
| **Linux** | `$HOME/.local/share/dart/install/bin`（或 `$XDG_DATA_HOME/dart/install/bin`） |
| **Windows** | `%LOCALAPPDATA%\Dart\install\bin` |
| **Windows** | `%LOCALAPPDATA%\Dart\install\bin` |

### Migrating users from pub global

### 引导用户从 pub global 迁移

If you maintain an existing Dart CLI package,
update your documentation (such as your `README.md`)
to recommend `dart install` instead of the legacy `dart pub global activate` command.
`dart install` produces faster,
self-contained applications that are uncoupled from the host Dart SDK version.

如果在维护已有的 Dart CLI package，
请更新文档（例如 `README.md`），
建议使用 `dart install`，不再使用旧的 `dart pub global activate` 命令。
`dart install` 生成的应用启动更快、自包含，
并且不再绑定宿主机上的 Dart SDK 版本。

[`dart install`]: /tools/dart-install
