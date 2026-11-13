---
# title: Package skills
title: Package skills
# description: >-
#   Learn how to discover, install, and manage AI agent skills provided by
#   Dart and Flutter packages.
description: >-
  了解如何发现、安装和管理 Dart 与 Flutter package 提供的 AI agent skill。
ai-translated: true
---

AI coding agents, such as Cursor, Gemini, Claude Code, Cline, and Copilot,
help you write, test, and refactor Dart code.
To generate accurate, idiomatic code,
these agents rely on context about the libraries and packages
your project uses.

Cursor、Gemini、Claude Code、Cline 和 Copilot 等 AI 编程 agent
帮助你编写、测试和重构 Dart 代码。
要生成准确、符合习惯的代码，
这些 agent 需要你的项目所使用的库和 package 的上下文。

**Package skills** allow package authors to distribute standardized,
context-rich AI agent instructions directly with their pub packages.
Using the [`package:skills`]({{site.pub-pkg}}/skills) command-line tool
(invoked as `dart run skills@ <command>`),
you can discover, install, and update skills for your project dependencies,
enabling your AI agents to write better code with fewer hallucinations.
To learn how to author and publish skills for your own package,
refer to [Ship skills with packages](/tools/pub/package-skills).

**Package skills** 让 package 作者可以把标准化、
上下文丰富的 AI agent 说明直接随 pub package 一起分发。
使用 [`package:skills`]({{site.pub-pkg}}/skills) 命令行工具
（以 `dart run skills@ <command>` 调用），
你可以发现、安装并更新项目依赖的 skill，
让 AI agent 写出更好的代码，减少臆造。
想了解如何为自己的 package 编写并发布 skill，
请参阅 [随 package 发布 skill](/tools/pub/package-skills)。

## What are agent skills?

## 什么是 agent skill？

An agent skill is a structured set of instructions, code examples,
and best practices packaged alongside a library.
Skills follow the open [Agent Skills specification][agentskills],
which standardizes how AI coding agents discover and read instructions.

Agent skill 是与库一起打包的一组结构化说明、代码示例和最佳实践。
Skill 遵循开放的 [Agent Skills 规范][agentskills]，
它统一了 AI 编程 agent 发现和阅读说明的方式。

A skill typically includes:

一个 skill 通常包括：

* **Contextual rules**: Guidance on library patterns, architecture,
  and anti-patterns to avoid.

  **上下文规则**：关于库的模式、架构，
  以及应避免的反模式的指导。

* **Code patterns**: Concrete, copy-pasteable examples of common tasks.

  **代码模式**：常见任务中可以复制粘贴的具体示例。

* **Tooling & workflow scripts**: Optional helper scripts and commands
  that an agent can execute to perform tasks or validate code.

  **工具与工作流脚本**：可选的辅助脚本和命令，
  agent 可以执行它们来完成任务或验证代码。

Skills are stored in your project's agent directory
(such as `.agents/skills/`),
where AI coding tools and agents automatically discover and use them.

Skill 存放在项目的 agent 目录中
（例如 `.agents/skills/`），
AI 编程工具和 agent 会自动发现并使用它们。

[agentskills]: https://agentskills.io

## Why use package skills?

## 为什么使用 package skill？

General-purpose AI models are trained on public code across many languages,
which means they might:

通用 AI 模型是在多种语言的公开代码上训练的，
因此它们可能会：

* Suggest deprecated APIs or outdated syntax.

  建议已弃用的 API 或过时的语法。

* Miss package-specific architectural conventions.

  漏掉特定 package 的架构约定。

* Hallucinate APIs that don't exist in the specific version you're using.

  臆造你所使用的特定版本中并不存在的 API。

When you install package skills,
your AI agent gains immediate, authoritative knowledge
written and maintained by the package authors themselves.

安装 package skill 之后，
你的 AI agent 会立刻获得由 package 作者本人编写并维护的权威知识。

## Install skills for dependencies

## 为依赖安装 skill

To install and update skills provided by your project's dependencies,
use `dart run skills@ get`:

要安装并更新项目依赖提供的 skill，
请使用 `dart run skills@ get`：

```console
$ dart run skills@ get
```

When run in a project directory,
the tool scans your immediate dependencies in `pubspec.yaml`
for packages that vend a `skills/` directory and prompts you
to select which skills to install:

在项目目录中运行时，
该工具会扫描 `pubspec.yaml` 里的直接依赖，
找出带有 `skills/` 目录的 package，并提示你
选择要安装哪些 skill：

```console
Scanning dependencies for available skills...
? Select skills to install:
  [x] shelf: routing - Define and handle HTTP routes
  [ ] shelf: middleware - Add logging and CORS middleware
  [x] dio: error-handling - Configure retry interceptors
```

Use the arrow keys and spacebar to select individual skills,
or press <kbd>Ctrl</kbd>+<kbd>A</kbd> to select or deselect all skills,
then press <kbd>Enter</kbd>.

用方向键和空格键选择单个 skill，
或按 <kbd>Ctrl</kbd>+<kbd>A</kbd> 全选或取消全选，
然后按 <kbd>Enter</kbd>。

### Install skills from a specific package

### 从指定 package 安装 skill

To install or update skills from a single package dependency,
use the `-p` (or `--package`) option:

要从单个 package 依赖安装或更新 skill，
请使用 `-p`（或 `--package`）选项：

```console
$ dart run skills@ get -p <package_name>
```

### Install a specific skill

### 安装指定 skill

To install a specific skill by name,
use the `-s` (or `--skill`) option:

要按名称安装某个 skill，
请使用 `-s`（或 `--skill`）选项：

```console
$ dart run skills@ get -p <package_name> -s <skill_name>
```

### Install all skills non-interactively

### 非交互地安装全部 skill

To install all available skills from all dependency sources
without interactive prompts, pass the `-a` (or `--all`) flag:

要在没有交互提示的情况下，
从所有依赖来源安装全部可用 skill，请传入 `-a`（或 `--all`）标志：

```console
$ dart run skills@ get --all
```

## Install skills from a Git repository

## 从 Git 仓库安装 skill

You can also install skills directly from any Git repository
using `dart run skills@ add`:

你也可以用 `dart run skills@ add`
直接从任意 Git 仓库安装 skill：

```console
$ dart run skills@ add <git_repository_url>
```

To install all skills from the Git repository without prompting,
add the `--all` flag:

要在不提示的情况下安装该 Git 仓库中的全部 skill，
请加上 `--all` 标志：

```console
$ dart run skills@ add <git_repository_url> --all
```

Once added as a source,
you can update skills from your configured Git repositories at any time
by running `dart run skills@ get`.

一旦添加为来源，
你可以随时运行 `dart run skills@ get`，
从已配置的 Git 仓库更新 skill。

## Skill directory structure

## Skill 的目录结构

When you install skills,
they are copied into the directory appropriate for your AI coding agent
(such as `.agents/skills/`):

安装 skill 时，
它们会被复制到适合你的 AI 编程 agent 的目录
（例如 `.agents/skills/`）：

```plaintext
my_project/
├── .agents/
│   └── skills/
│       ├── shelf-routing/
│       │   └── SKILL.md
│       └── dio-error-handling/
│           ├── SKILL.md
│           └── examples/
├── lib/
├── test/
└── pubspec.yaml
```

Once installed, the skills are immediately available
to your agent during code generation, refactoring, and chat.

安装之后，skill 会立刻在代码生成、重构和对话中
供你的 agent 使用。

### Version control and .gitignore

### 版本控制与 .gitignore

Whether you commit installed skills depends on your team's workflow:

是否提交已安装的 skill，取决于团队的工作流：

* **If you commit your skills directory** (such as `.agents/skills/`),
  also commit the `.config/dart_skills/` directory so all team members
  share the same skill definitions and update tracking.

  **如果提交 skill 目录**（例如 `.agents/skills/`），
  也请提交 `.config/dart_skills/` 目录，这样所有团队成员
  会共享同一套 skill 定义和更新跟踪信息。

* **If you ignore your skills directory**,
  also add `.config/dart_skills/` to `.gitignore`.
  Each developer can then run `dart run skills@ get` in their local workspace.

  **如果忽略 skill 目录**，
  也请把 `.config/dart_skills/` 加入 `.gitignore`。
  然后每位开发者可以在自己的本地工作区运行 `dart run skills@ get`。

## Update installed skills

## 更新已安装的 skill

As packages evolve, authors update their skills
with new best practices and API changes.
To update all installed skills to match the latest versions
of your dependencies, run:

随着 package 演进，作者会用新的最佳实践和 API 变更来更新 skill。
要让所有已安装的 skill 与依赖的最新版本一致，请运行：

```console
$ dart run skills@ get
```

### Handle local modifications

### 处理本地修改

One key advantage of agent skills is that you can edit them locally
to customize instructions for your team's architecture or style.

Agent skill 的一个关键好处是你可以在本地编辑它们，
按团队的架构或风格定制说明。

When you run `dart run skills@ get`,
`package:skills` tracks previously installed skills and detects changes
to your local files before updating.

运行 `dart run skills@ get` 时，
`package:skills` 会跟踪先前安装的 skill，
并在更新前检测本地文件的改动。

If a local modification is detected:

如果检测到本地修改：

* `package:skills` alerts you that the skill has been modified locally.

  `package:skills` 会提醒你该 skill 已在本地被修改。

* You are prompted to choose whether to **overwrite** your local changes
  with the upstream version or **keep** your local customizations.

  系统会提示你选择是用上游版本 **覆盖** 本地更改，
  还是 **保留** 本地定制。

## Manage and remove skills

## 管理和移除 skill

### List installed skills

### 列出已安装的 skill

To view all managed skills currently installed in your workspace,
run `dart run skills@ list`:

要查看工作区中当前安装的全部受管理 skill，
请运行 `dart run skills@ list`：

```console
$ dart run skills@ list
```

### Prune skills from removed dependencies

### 清理已移除依赖的 skill

If you remove a dependency from your `pubspec.yaml`,
its skills might still remain in your agent's skills directory.
To automatically remove skills for packages that are no longer dependencies,
run `dart run skills@ prune`:

如果从 `pubspec.yaml` 中移除了某个依赖，
它的 skill 可能仍留在 agent 的 skill 目录里。
要自动移除不再是依赖的 package 的 skill，
请运行 `dart run skills@ prune`：

```console
$ dart run skills@ prune
```

### Remove specific skills

### 移除指定 skill

To explicitly remove managed skills from your workspace,
use `dart run skills@ remove`:

要显式地从工作区移除受管理的 skill，
请使用 `dart run skills@ remove`：

```console
$ dart run skills@ remove -p <package_name>
```

## Related links

## 相关链接

* [Ship skills with packages](/tools/pub/package-skills)

  [随 package 发布 skill](/tools/pub/package-skills)

* [`package:skills` on pub.dev]({{site.pub-pkg}}/skills)

  [pub.dev 上的 `package:skills`]({{site.pub-pkg}}/skills)

* [Agent Skills specification][agentskills]

  [Agent Skills 规范][agentskills]

* [Dart and Flutter MCP server]({{site.flutter-docs}}/ai/mcp-server)

  [Dart 与 Flutter MCP 服务器]({{site.flutter-docs}}/ai/mcp-server)
