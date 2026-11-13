---
# title: dart create
title: dart create 命令
# description: Command-line tool for creating Dart projects.
description: 用于创建 Dart 项目的命令行工具。
showToc: false
ai-translated: true
---

This guide describes how to use the `dart create` command to
create a Dart project.

本指南说明如何使用 `dart create` 命令创建 Dart 项目。

## Overview

## 概述

The `dart create` command creates a Dart project,
using one of several supported templates.
The same functionality is available in IDEs.

`dart create` 命令使用若干受支持的模板之一创建 Dart 项目。
IDE 中也提供相同功能。

{% render 'tools/dart-tool-note.md' %}

When you run `dart create`, it first creates a directory with the
project files. Then it gets package dependencies
(unless you specify the `--no-pub` flag).

运行 `dart create` 时，它会先创建包含项目文件的目录，
然后获取 package 依赖
（除非指定了 `--no-pub` 参数）。

## Create a basic Dart project

## 创建基本的 Dart 项目

To create a basic Dart project, follow the `dart create` command
with the name of your project. In the following example,
a directory named `my_cli` that contains a
simple console app (the default template) is created:

要创建基本的 Dart 项目，请在 `dart create` 命令后
跟上项目名称。下面的例子会创建名为 `my_cli` 的目录，
其中包含一个简单的控制台应用（默认模板）：

```console
$ dart create my_cli
```

## Specify a template

## 指定模板

To use a different template, use the `-t` (or `--template`)
flag followed by the template name:

要使用其他模板，请使用 `-t`（或 `--template`）参数，
并跟上模板名称：

```console
$ dart create -t web my_web_app
```

The `-t` flag allows you to specify which type of Dart project
you want to create. If you don't specify a template, `dart create`
uses the `console` template by default.

借助 `-t` 参数，可以指定要创建的 Dart 项目类型。
如果没有指定模板，`dart create` 默认使用 `console` 模板。

## Available templates

## 可用模板

The following table shows the templates you can use with the
`-t` flag:

下表列出可以配合 `-t` 参数使用的模板：

| <t>Template</t><t>模板</t>       | <t>Description</t><t>说明</t>                                                                                           |
|----------------|-------------------------------------------------------------------------------------------------------|
| `cli`          | A command-line application with basic argument parsing using [`package:args`]({{site.pub-pkg}}/args). |
| `cli`          | 使用 [`package:args`]({{site.pub-pkg}}/args) 做基本参数解析的命令行应用。 |
| `console`      | A command-line application (default template).                                                       |
| `console`      | 命令行应用（默认模板）。 |
| `package`      | A package containing shared Dart libraries.                                                           |
| `package`      | 包含可共享 Dart 库的 package。 |
| `server-shelf` | A server built using [shelf][].                                                                       |
| `server-shelf` | 使用 [shelf][] 构建的服务器。 |
| `web`          | A web app built using core Dart libraries.                                                            |
| `web`          | 使用 Dart 核心库构建的 Web 应用。 |

{:.table .table-striped .nowrap}

[shelf]: {{site.pub-pkg}}/shelf

These templates result in a file structure that follows
[package layout conventions](/tools/pub/package-layout).

这些模板生成的文件结构遵循
[package 布局约定](/tools/pub/package-layout)。

## Additional options

## 其他选项

Additionally, you can perform the following actions with
the `dart create` command.

还可以用 `dart create` 命令完成下列操作。

### Force project creation

### 强制创建项目

If the specified directory already exists, `dart create` fails. 
You can force project generation with the `--force` flag:

如果指定的目录已经存在，`dart create` 会失败。
可以使用 `--force` 参数强制生成项目：

```console
$ dart create --force <DIRECTORY>
```

### Get help

### 获取帮助

For further information on command-line options, use the `--help` flag:

要进一步了解命令行选项，请使用 `--help` 参数：

```console
$ dart create --help
```

{% comment %}
```
Create a new Dart project.

Usage: dart create [arguments] <directory>
-h, --help                       Print this usage information.
-t, --template                   The project template to use.

          [console] (default)    A command-line application.
          [package]              A package containing shared Dart libraries.
          [server-shelf]         A server app using `package:shelf`
          [web]                  A web app that uses only core Dart libraries.

    --[no-]pub                   Whether to run 'pub get' after the project has been created.
                                 (defaults to on)
    --force                      Force project generation, even if the target directory already exists.
```

{% endcomment %}
