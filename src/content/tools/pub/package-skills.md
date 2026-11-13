---
# title: Ship skills with packages
title: 随 package 发布 skill
# description: >-
#   Learn how to author, structure, test, and publish AI agent skills with your
#   Dart and Flutter packages.
description: 了解如何随 Dart 和 Flutter package 编写、组织、测试并发布 AI agent skill。
ai-translated: true
---

When developers use your Dart or Flutter package,
their AI coding agents,
such as Cursor, Gemini, Claude Code, Cline, and Copilot,
rely on context to write accurate, idiomatic code.

开发者使用你的 Dart 或 Flutter package 时，
他们的 AI 编程助手，
例如 Cursor、Gemini、Claude Code、Cline 和 Copilot，
需要上下文才能写出准确、符合惯例的代码。

By shipping **agent skills** directly with your package,
you provide AI agents with authoritative instructions,
code examples,
and best practices tailored specifically to your library's APIs.
To learn how developers install and use skills in their projects,
see [Package skills](/ai/package-skills).

把 **agent skill** 直接随 package 一起发布，
就等于为 AI 助手提供权威说明、代码示例，
以及专门针对你的库 API 的最佳实践。
要了解开发者如何在项目中安装和使用 skill，
请参阅 [Package skill](/ai/package-skills)。

## Why ship skills with your package?

## 为什么要随 package 发布 skill？

Without skills,
AI coding agents often guess APIs,
suggest deprecated methods,
or miss architectural patterns specific to your library.
When you publish skills alongside your package:

如果没有 skill，
AI 编程助手常常会猜测 API、
建议已弃用的方法，
或者错过你的库特有的架构模式。
当你把 skill 和 package 一起发布时：

* **Fewer developer errors**: Agents generate working,
  idiomatic code on the first try.

  **更少的开发者错误**：助手第一次就能生成可运行、符合惯例的代码。

* **Reduced support burden**: Common setup pitfalls and anti-patterns
  are proactively prevented.

  **更轻的支持负担**：常见的配置陷阱和反模式会被提前避免。

* **Seamless installation**: Consumers of your package can install your skills
  with a single command: `dart run skills@ get`.

  **安装很直接**：package 的使用者用一条命令就能安装你的 skill：`dart run skills@ get`。

## Plan your package skills

## 规划 package 的 skill

A package skill is a set of guidelines and examples
that teaches an AI agent how to use a specific part of your library.
When planning skills for your package:

package skill 是一组指南和示例，
用来教 AI 助手如何使用你的库的某一部分。
为 package 规划 skill 时：

* **Focus on common workflows**: Create skills for key tasks,
  such as initial setup, routing, authentication, error handling,
  or performance optimization.

  **聚焦常见工作流**：为关键任务创建 skill，
  例如初始配置、路由、身份验证、错误处理或性能优化。

* **Keep skills modular**: Create separate, focused skills
  for distinct feature areas
  (for example, `my_package-routing` and `my_package-auth`)
  rather than bundling everything into one large skill.

  **保持 skill 模块化**：为不同的功能领域分别创建聚焦的 skill
  （例如 `my_package-routing` 和 `my_package-auth`），
  不要把所有内容塞进一个很大的 skill。

* **Write prescriptive instructions**: Use direct, unambiguous rules
  (such as "Always initialize X before calling Y")
  rather than open-ended explanations.

  **写出规定性的说明**：使用直接、没有歧义的规则
  （例如「Always initialize X before calling Y」），
  而不是开放式的解释。

## Set up the directory structure

## 建立目录结构

To provide skills in your package,
create a top-level `skills/` directory at the root of your package,
alongside `lib/` and `pubspec.yaml`:

要在 package 中提供 skill，
请在 package 根目录创建顶层 `skills/` 目录，
与 `lib/` 和 `pubspec.yaml` 并列：

```plaintext
my_package/
├── lib/
├── skills/
│   ├── my_package-routing/
│   │   ├── SKILL.md
│   │   ├── scripts/       # Optional helper scripts
│   │   ├── references/    # Optional reference docs
│   │   └── assets/        # Optional static resources
│   └── my_package-testing/
│       └── SKILL.md
└── pubspec.yaml
```

Each subdirectory in `skills/` represents a single skill
and must contain a `SKILL.md` file following the open
[Agent Skills specification][agentskills].

`skills/` 中的每个子目录代表一个 skill，
并且必须包含一份遵循开放的
[Agent Skills 规范][agentskills] 的 `SKILL.md` 文件。

[agentskills]: https://agentskills.io

### Skill naming conventions

### skill 命名约定

To prevent naming collisions
when consumers install skills from multiple dependencies,
every skill directory name must begin with your package name
(or your package name with underscores replaced by hyphens)
followed by a hyphen:

为了避免使用者从多项依赖安装 skill 时发生名称冲突，
每个 skill 目录名都必须以你的 package 名称开头
（或者把 package 名称中的下划线换成连字符），
后面再跟一个连字符：

| <t>Package name</t><t>Package 名称</t> | <t>Directory name</t><t>目录名</t> | <t>Valid?</t><t>是否有效</t> |
| :--- | :--- | :--- |
| `shelf` | `shelf-routing` | Yes |
| `shelf` | `shelf-routing` | 是 |
| `my_package` | `my_package-routing` | Yes |
| `my_package` | `my_package-routing` | 是 |
| `my_package` | `my-package-routing` | Yes |
| `my_package` | `my-package-routing` | 是 |
| `my_package` | `routing` | No (missing package prefix) |
| `my_package` | `routing` | 否（缺少 package 前缀） |
| `my_package` | `other_pkg-routing` | No (wrong package prefix) |
| `my_package` | `other_pkg-routing` | 否（package 前缀错误） |

:::note
The `package:skills` installation tool validates this prefix
and skips any skills that do not match the package name.

`package:skills` 安装工具会校验这个前缀，
并跳过所有与 package 名称不匹配的 skill。
:::

## Author a skill

## 编写 skill

Each skill is defined in a `SKILL.md` file with YAML frontmatter
and Markdown instructions.

每个 skill 都定义在一份 `SKILL.md` 文件中，
其中包含 YAML frontmatter 和 Markdown 说明。

The following template illustrates the structure of a `SKILL.md` file
that you can customize for your package:

下面的模板展示了 `SKILL.md` 文件的结构，
你可以按自己的 package 进行修改：

````markdown
---
name: <package_name>-<skill_name>
description: >-
  Use when the user is working with <package_name> APIs to ensure correct
  patterns and error handling.
---

# <Skill Title>

## Guidelines

* Always call `initialize()` before invoking other methods.
* Prefer using `<SpecificException>` over generic `Exception` types.
* Dispose of controllers and streams when they are no longer needed.

## Examples

### Basic setup example

```dart
import 'package:<package_name>/<package_name>.dart';

void main() {
  // Provide clear, idiomatic Dart code snippets for the agent to follow.
}
```
````

### Key parts of a skill file

### skill 文件的关键部分

A `SKILL.md` file typically consists of three parts:

一份 `SKILL.md` 文件通常包含三个部分：

* **YAML frontmatter (`name`, `description`)**:
  Identifies the skill and tells the AI coding agent
  when to activate the skill based on the user's prompt.

  **YAML frontmatter（`name`、`description`）**：
  标识这个 skill，并根据用户的提示告诉 AI 编程助手何时启用它。

* **Guidelines**:
  A list of direct, prescriptive rules describing library conventions,
  recommended patterns, and common anti-patterns to avoid.

  **Guidelines**：
  一组直接、规定性的规则，说明库的约定、推荐模式，以及应避免的常见反模式。

* **Examples**:
  Copy-pasteable Dart code snippets showing how to implement common tasks
  using your library's APIs.

  **Examples**：
  可直接复制的 Dart 代码片段，展示如何用你的库 API 完成常见任务。

## Scaffold skills using the CLI

## 用 CLI 搭建 skill

You can use the `package:skills` CLI to quickly scaffold a new skill
in your current package:

你可以用 `package:skills` 的 CLI，在当前 package 中快速搭建一个新 skill：

```console
$ dart run skills@ create -n <skill_name> -d "<skill_description>"
```

This command automatically generates the prefixed directory
and a starter `SKILL.md` template.

这个命令会自动生成带前缀的目录，以及一份起步用的 `SKILL.md` 模板。

## Development and published skills

## 开发用 skill 与发布的 skill

When developing your package,
distinguish between skills used internally for package development
and skills published for your package consumers:

开发 package 时，要区分仅供内部开发使用的 skill，
以及发布给 package 使用者的 skill：

| <t>Directory</t><t>目录</t> | <t>Audience</t><t>受众</t> | <t>Description</t><t>说明</t> |
| :--- | :--- | :--- |
| `skills/` | Package consumers | Public skills bundled with your package and installed with `dart run skills@ get`. |
| `skills/` | package 使用者 | 随 package 一起打包的公开 skill，通过 `dart run skills@ get` 安装。 |
| `.agents/skills/` | Package maintainers | Internal skills used while developing the repository. Not distributed to consumers. |
| `.agents/skills/` | package 维护者 | 开发该仓库时使用的内部 skill，不会分发给使用者。 |

## Test skills locally before publishing

## 发布前在本地测试 skill

Before publishing your package to pub.dev,
verify that your skills can be discovered and installed properly:

把 package 发布到 pub.dev 之前，
请确认你的 skill 能被正确发现并安装：

1. Create a sample Dart or Flutter project to act as a consumer.

   创建一个示例 Dart 或 Flutter 项目，当作使用者。

2. In the sample project's `pubspec.yaml`, add a [path dependency][]
   pointing to your local package:

   在示例项目的 `pubspec.yaml` 中，添加指向本地 package 的
   [路径依赖][path dependency]：

   ```yaml
   dependencies:
     my_package:
       path: ../path/to/my_package
   ```

3. Run `dart run skills@ get` in the sample project.

   在示例项目中运行 `dart run skills@ get`。

4. Verify that your skills appear in the interactive selection prompt
   and install cleanly into the sample project's `.agents/skills/` directory.

   确认你的 skill 出现在交互式选择提示中，
   并且能顺利安装到示例项目的 `.agents/skills/` 目录。

[path dependency]: /tools/pub/dependencies#path-packages

## Publish on pub.dev

## 在 pub.dev 上发布

When you publish your package with `dart pub publish`,
the `skills/` directory is automatically bundled into the package archive.
Once published, consumers who depend on your package can install your skills
by running `dart run skills@ get`.

使用 `dart pub publish` 发布 package 时，
`skills/` 目录会自动打进 package 归档。
发布之后，依赖你的 package 的使用者就可以运行 `dart run skills@ get`
来安装你的 skill。

## Best practices

## 最佳实践

* **Keep skills focused**: Create one skill per major feature area
  rather than a single oversized skill.

  **让 skill 保持聚焦**：每个主要功能领域单独做一个 skill，
  不要做成一个过大的 skill。

* **Write for the AI agent**: Use clear, prescriptive instructions.
  Direct rules (such as "Always use X before calling Y") are more effective
  than open-ended narrative text.

  **写给 AI 助手**：使用清晰、规定性的说明。
  直接的规则（例如「Always use X before calling Y」）
  比开放式的叙述更有效。

* **Include concrete code examples**: Show complete, working code snippets
  illustrating idiomatic Dart API usage.

  **包含具体的代码示例**：给出完整、可运行的代码片段，
  展示符合惯例的 Dart API 用法。

* **Keep `SKILL.md` concise**: Keep `SKILL.md` under 500 lines.
  Place extensive reference materials, schemas, or large documentation tables
  in subdirectories like `references/` or `assets/`.

  **保持 `SKILL.md` 精简**：把 `SKILL.md` 控制在 500 行以内。
  把大量参考材料、schema 或大型文档表格放到 `references/` 或 `assets/`
  这样的子目录中。

* **Version skills with your package**: When updating your package APIs
  in new versions, update your skills to reflect the latest recommendations.

  **让 skill 与 package 一起版本化**：在新版本中更新 package API 时，
  同步更新 skill，以反映最新的建议。

## Related links

## 相关链接

* [`package:skills` on pub.dev]({{site.pub-pkg}}/skills)

  [pub.dev 上的 `package:skills`]({{site.pub-pkg}}/skills)

* [Agent Skills specification][agentskills]

  [Agent Skills 规范][agentskills]
