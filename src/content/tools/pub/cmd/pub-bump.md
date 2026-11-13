---
# title: dart pub bump
title: dart pub bump 命令
# description: Use dart pub bump to increase the version number of the current package.
description: 使用 dart pub bump 提高当前 package 的版本号。
ai-translated: true
---

_Bump_ is one of the commands of the [pub tool](/tools/pub/cmd).

**Bump** 命令是 [pub 工具](/tools/pub/cmd) 中的一个命令。

```plaintext
$ dart pub bump <subcommand> [options]
```

This command increments the version number of the current package.
Use one of the subcommands `breaking`, `major`, `minor`,
or `patch` according to the type of increment desired. 

这个命令会递增当前 package 的版本号。
根据你希望的递增类型，使用 `breaking`、`major`、`minor` 或 `patch` 子命令之一。

Refer to [semver](https://semver.org/spec/v2.0.0-rc.1.html) for guidance on versioning your package.
For example:

package 的版本号请参考 [semver](https://semver.org/spec/v2.0.0-rc.1.html)。例如：

```console
$ dart pub bump minor
  Updating version from 1.0.0 to 1.1.0
  
  Diff:
  - version: 1.0.0
  + version: 1.1.0
  
  Remember to update `CHANGELOG.md` before publishing.
```

## Options

## 选项

For options that apply to all pub commands, see
[Global options](/tools/pub/cmd#global-options).

适用于所有 pub 命令的选项，请参阅 [全局选项](/tools/pub/cmd#global-options)。

### `-n, --dry-run`

### `-n, --dry-run` 选项

Reports what would change for the version number under each subcommand,
and shows the version diff, without changing anything.

报告每个子命令会如何改变版本号，并显示版本差异，不会实际修改任何内容。
