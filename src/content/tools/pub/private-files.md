---
# title: What not to commit
title: 不应提交的内容
# description: Your development tools generate a bunch of files. Not all of them should be committed.
description: 开发工具会生成许多文件，并非所有文件都应该提交。
ai-translated: true
---

When you put Dart source code in a repository—using the
[pub tool](/tools/pub/cmd), [GitHub](https://github.com/),
or another source code management system—don't include most of the files
that your IDE or code editor, the pub tool, and other tools generate.

把 Dart 源代码放进仓库时——无论使用
[pub 工具](/tools/pub/cmd)、[GitHub](https://github.com/)
还是其他源代码管理系统——不要纳入 IDE 或代码编辑器、
pub 工具以及其他工具生成的大部分文件。

:::note
Except where noted, this page discusses only source code repositories,
_not_ app deployment.
Some files that you wouldn't normally put in a repository
are useful or essential when you deploy an app.

除非另有说明，本页只讨论源代码仓库，**不是** 应用部署。
有些通常不会放进仓库的文件，在部署应用时却很有用，甚至必不可少。
:::

## The rules

## 规则

**Don't commit** the following files and directories
created by pub:

**不要提交** pub 创建的以下文件和目录：

```plaintext
.dart_tool/
build/
pubspec.lock  # Except for application packages
```

**Don't commit** the API documentation directory
created by [`dart doc`](/tools/dart-doc):

**不要提交** [`dart doc`](/tools/dart-doc) 生成的 API 文档目录：

```plaintext
doc/api/
```

**Don't commit** files and directories
created by other development environments.
For example, if your development environment creates
any of the following files,
consider putting them in a global ignore file:

**不要提交** 其他开发环境创建的文件和目录。
例如，如果你的开发环境会创建下面这些文件，
可以考虑把它们放进全局忽略文件：

```plaintext
# IntelliJ
*.iml
*.ipr
*.iws
.idea/

# Mac
.DS_Store
```

For more details, read on.

更多细节请继续阅读。

## Details

## 细节

As a rule, commit only the files that people need
to use your package or source code repository.
Including additional files is unnecessary,
could be counterproductive,
and might have security implications
if you expose details about your machine's setup.
In many source code repositories,
the common practice is not to commit generated files, at all.

原则上，只提交别人使用你的 package 或源代码仓库所需要的文件。
多放进去的文件没有必要，
有时反而帮倒忙，
如果暴露了你机器环境的细节，还可能带来安全问题。
在许多源代码仓库里，常见做法是完全不提交生成的文件。

To avoid committing files that are
specific to your personal workflow or setup,
consider using a global ignore file
(for example, `.gitignore_global`).

为了避免提交只属于你个人工作流或环境的文件，
可以考虑使用全局忽略文件（例如 `.gitignore_global`）。

When you use pub from within a Git repo,
pub ignores the same files that Git does.
For example, if you run `pub publish` from a Git repo
that has a `.gitignore` file containing `keys.txt`,
then your published package won't contain the `keys.txt` file.

在 Git 仓库里使用 pub 时，
pub 会忽略 Git 所忽略的那些文件。
例如，如果某个 Git 仓库的 `.gitignore` 包含 `keys.txt`，
你在该仓库中运行 `pub publish`，
发布出去的 package 就不会包含 `keys.txt` 文件。

For more information on `.gitignore` files,
see the GitHub help page
[Ignoring files.](https://help.github.com/articles/ignoring-files)

关于 `.gitignore` 文件的更多信息，
请参阅 GitHub 帮助页面
[忽略文件](https://help.github.com/articles/ignoring-files)。

### .dart_tool/

### .dart_tool/ 目录

The `.dart_tool/` directory contains files used by 
various Dart tools.

`.dart_tool/` 目录包含各种 Dart 工具使用的文件。


### pubspec.lock

### pubspec.lock 文件

The `pubspec.lock` file is a special case,
similar to Ruby's `Gemfile.lock`.

`pubspec.lock` 文件是一种特殊情况，
类似于 Ruby 的 `Gemfile.lock`。

**For regular packages**, **don't commit** the `pubspec.lock` file.
Regenerating the `pubspec.lock` file lets you test your package
against the latest compatible versions of its dependencies.

**对于普通 package**，**不要提交** `pubspec.lock` 文件。
重新生成 `pubspec.lock`，可以让你针对依赖的最新兼容版本测试自己的 package。

**For application packages**, 
we recommend that you commit the `pubspec.lock` file.
Versioning the `pubspec.lock` file
ensures changes to transitive dependencies are explicit.
Each time the dependencies change due to `dart pub upgrade`
or a change in `pubspec.yaml` 
the difference will be apparent in the lock file.

**对于应用型 package**，建议你提交 `pubspec.lock` 文件。
把 `pubspec.lock` 纳入版本管理，
可以让传递依赖的变化明确可见。
每当依赖因为 `dart pub upgrade` 或 `pubspec.yaml` 的修改而变化时，
差异都会体现在 lockfile 中。
