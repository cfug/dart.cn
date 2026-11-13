---
# title: "package:skills"
title: "package:skills 工具"
# description: Command-line tool for managing AI agent skills in Dart projects.
description: 用于在 Dart 项目中管理 AI agent 技能的命令行工具。
ai-translated: true
---

The [`package:skills`]({{site.pub-pkg}}/skills) package provides
command-line tools to discover, install, and manage AI agent skills
for Dart and Flutter projects.

[`package:skills`]({{site.pub-pkg}}/skills) 提供命令行工具，
用于为 Dart 和 Flutter 项目发现、安装并管理 AI agent 技能。

An agent skill is a structured set of instructions, code examples,
and best practices following the [Agent Skills specification][agentskills].
When installed in your workspace,
AI coding agents, such as Cursor, Gemini, Claude Code, Cline, and Copilot,
use these skills to write accurate,
idiomatic code tailored to your dependencies.

agent 技能是遵循 [Agent Skills 规范][agentskills] 的一组结构化说明、
代码示例和最佳实践。
安装到工作区后，
Cursor、Gemini、Claude Code、Cline 和 Copilot 等 AI 编程代理
会使用这些技能，针对你的依赖写出准确、地道的代码。

## Running package:skills

## 运行 package:skills

You run `package:skills` using the `dart run skills@ <command>` syntax:

通过 `dart run skills@ <command>` 语法运行 `package:skills`：

```console
$ # From the root of your Dart or Flutter project:
$ dart run skills@ get
```

To view all available commands and flags, run `dart run skills@ --help`.

要查看全部可用命令和参数，请运行 `dart run skills@ --help`。

## Built-in commands

## 内置命令

The `package:skills` package includes the following commands:

`package:skills` 包含下列命令：

get
: Discovers and installs skills provided by dependencies in `pubspec.yaml`.
  In [workspaces](/tools/pub/workspaces) and monorepos,
  `dart run skills@ get` discovers and installs skills
  across all workspace packages.
  Supports interactive selection (<kbd>Ctrl</kbd>+<kbd>A</kbd> to toggle all),
  installing all skills without prompting (`--all`),
  or targeting specific packages and skills (`-p <package>`, `-s <skill>`):

  发现并安装 `pubspec.yaml` 中依赖所提供的技能。
  在 [工作区](/tools/pub/workspaces) 和 monorepo 中，
  `dart run skills@ get` 会发现并安装
  所有工作区 package 中的技能。
  支持交互式选择（<kbd>Ctrl</kbd>+<kbd>A</kbd> 切换全选）、
  不经提示安装全部技能（`--all`），
  或指定 package 和技能（`-p <package>`、`-s <skill>`）：

  ```console
  $ dart run skills@ get
  ```

add
: Adds an external Git repository as a skill source and installs its skills:

  将外部 Git 仓库添加为技能来源，并安装其中的技能：

  ```console
  $ dart run skills@ add <git_repository_url>
  ```

create
: Scaffolds a new skill directory and template for package authors:

  为 package 作者搭建新的技能目录和模板：

  ```console
  $ dart run skills@ create -n <skill_name> -d "<skill_description>"
  ```

list
: Displays all managed skills currently installed in your workspace:

  显示当前安装在工作区中、由该工具管理的全部技能：

  ```console
  $ dart run skills@ list
  ```

prune
: Automatically removes skills for packages
  that are no longer listed as dependencies in `pubspec.yaml`:

  自动移除那些 package
  已不再列为 `pubspec.yaml` 依赖的技能：

  ```console
  $ dart run skills@ prune
  ```

remove
: Removes managed skills interactively,
  or targets specific packages and skills (`-p <package>`, `-s <skill>`):

  以交互方式移除受管理的技能，
  或指定 package 和技能（`-p <package>`、`-s <skill>`）：

  ```console
  $ dart run skills@ remove
  ```

## More information

## 更多信息

To learn more about package skills workflows, see:

要进一步了解 package 技能的工作流程，请参阅：

* [Package skills user guide](/ai/package-skills)
  (Installing and using skills in your development workflows)

  [Package 技能用户指南](/ai/package-skills)
  （在开发流程中安装和使用技能）

* [Ship skills with packages](/tools/pub/package-skills)
  (Authoring and publishing skills with your packages)

  [随 package 发布技能](/tools/pub/package-skills)
  （随 package 编写并发布技能）

* [`package:skills` on pub.dev]({{site.pub-pkg}}/skills)

  [pub.dev 上的 `package:skills`]({{site.pub-pkg}}/skills)

* [Agent Skills specification][agentskills]

  [Agent Skills 规范][agentskills]

[agentskills]: https://agentskills.io
