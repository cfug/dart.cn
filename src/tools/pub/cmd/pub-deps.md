---
title: pub deps
title: pub deps
description: Use pub deps to print a dependency graph for a package.
description: 使用 pub deps 命令可以将 Package 的依赖项打印出来。
toc: false
---

_Deps_ is one of the commands of the [pub tool](/tools/pub/cmd).

{% prettify none %}
$ pub deps [--style=<style>]
{% endprettify %}

This command prints the dependency graph for a package.
The graph includes both the
[immediate dependencies](/tools/pub/glossary#immediate-dependency)
that the package uses (as specified in the pubspec), as well as the
[transitive dependencies](/tools/pub/glossary#transitive-dependency)
pulled in by the immediate dependencies.

The dependency information is printed as a tree, a list, or a compact
list.

For example, the pubspec for the markdown_converter example specifies
the following dependencies:

{% prettify yaml %}
dependencies:
  barback: ^0.15.2
  markdown: ^0.7.2
{% endprettify %}

Here's an example of the `pub deps` output for markdown_converter:

```terminal
$ pub deps
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

`--style=<style>` or `-s <style>`
: Optional. How the output should be displayed. The options are:
`compact`, `tree`, or `list`. The default is tree.

`--style=<style>` 选项或 `-s <style>` 选项：可选的选项。用于指定依赖项打印输出的样式。共有 `简洁`、`树状` 和 `列表` 三种，默认是树状样式。

<aside class="alert alert-info" markdown="1">
*Problems?*
See [Troubleshooting Pub](/tools/pub/troubleshoot).

*有疑问？*
请查阅 [Pub 疑难协助](/tools/pub/troubleshoot)。
</aside>
