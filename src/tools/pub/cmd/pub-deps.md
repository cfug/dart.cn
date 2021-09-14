---
title: dart pub deps
title: dart pub deps
description: Use dart pub deps to print a dependency graph for a package.
description: 使用 dart pub deps 命令可以将 Package 的依赖项打印出来。
---

_Deps_ is one of the commands of the [pub tool](/tools/pub/cmd).

_Deps_ 命令是 [Pub 工具](/tools/pub/cmd) 中的一个命令。

```nocode
$ dart pub deps [--style=<style>] [--[no-]dev] [--executables]
```

This command prints the dependency graph for a package.
The graph includes both the
[immediate dependencies](/tools/pub/glossary#immediate-dependency)
that the package uses (as specified in the pubspec), as well as the
[transitive dependencies](/tools/pub/glossary#transitive-dependency)
pulled in by the immediate dependencies.

该命令可以将 Package 的依赖图示打印输出到控制台。
该图示中包括 Package 声明在 pubspec 文件中的 
[直接依赖](/tools/pub/glossary#immediate-dependency) 
以及这些直接依赖所依赖的
[间接依赖](/tools/pub/glossary#transitive-dependency)。

The dependency information is printed as a tree by default.

依赖信息默认以树状的形式打印输出。

For example, the pubspec for the markdown_converter example specifies
the following dependencies:

例如，markdown_converter 这个示例的 pubspec 文件中声明了如下依赖信息：

```yaml
dependencies:
  barback: ^0.15.2
  markdown: ^0.7.2
```

Here's an example of the `dart pub deps` output for markdown_converter:

当你执行 `dart pub deps` 命令时则会看到 markdown_converter 的依赖图示如下：

```terminal
$ dart pub deps
markdown_converter 0.0.0
|-- barback 0.15.2+6
|   |-- collection 1.1.2
|   |-- path 1.3.6
|   |-- pool 1.1.0
|   |   '-- stack_trace...
|   |-- source_span 1.2.0
|   |   '-- path...
|   '-- stack_trace 1.4.2
|       '-- path...
'-- markdown 0.7.2
```

## Options

## 选项

For options that apply to all pub commands, see
[Global options](/tools/pub/cmd#global-options).

你可以查阅 [全局选项](/tools/pub/cmd#global-options) 获取 Pub 命令所支持的命令选项。

### `--style=<style>` or `-s <style>`

### `--style=<style>` 或 `-s <style>`

The specified style determines the output format:

指定的样式输出格式。

* `tree`
: Prints dependency information as a tree. This is the 
default format.

  `tree`
：以树状的形式打印依赖信息。这是默认格式。

* `list`
: Prints dependency information as a list.

  `list`
： 以列表的形式打印依赖信息。

* `compact`
: Prints dependency information as a compact list.

  `compact`
： 以紧凑列表的形式打印依赖信息。

### `--[no-]dev`

By default, prints all dependencies, 
including dev dependencies (`--dev`).
To remove dev dependencies, use `--no-dev`.

打印所有包依赖信息，包括开发依赖。
如果你不想打印开发依赖，使用 `--no-dev`。

### `--executables`

Prints all available executables.

打印所有可用的可执行文件。

### `--json`

Generates output in JSON format.

以 JSON 格式输出。

{{site.alert.info}}

  *Problems?*
  See [Troubleshooting Pub](/tools/pub/troubleshoot).

  **有疑问？**请查阅 [Pub 疑难协助](/tools/pub/troubleshoot)。

{{site.alert.end}}
