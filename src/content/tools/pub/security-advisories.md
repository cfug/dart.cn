---
# title: Security advisories
title: 安全公告
# description: >-
#   Use security advisories to inform and be informed
#   about security vulnerabilities in Dart packages.
description: 使用安全公告来通报和了解 Dart package 中的安全漏洞。
ai-translated: true
---

Security advisories are a means to report information about security
vulnerabilities. Pub uses the [GitHub Advisory Database][]
for publishing security advisories for Dart and Flutter packages. 

安全公告用来报告安全漏洞相关的信息。
pub 使用 [GitHub Advisory Database][]
发布 Dart 和 Flutter package 的安全公告。

To create an advisory in your GitHub repository, use
GitHub's security advisory reporting mechanism as
explained in GitHub's docs on [Creating a repository security advisory][].
First you create a draft security advisory, which will then be reviewed by
GitHub and ingested into the central advisory database.

要在你的 GitHub 仓库中创建公告，
请使用 GitHub 的安全公告报告机制，
具体步骤见 GitHub 文档 [创建仓库安全公告][Creating a repository security advisory]。
你需要先创建一份安全公告草稿，
随后由 GitHub 审核，并收录到中央公告数据库。

[GitHub Advisory Database]: https://github.com/advisories
[Creating a repository security advisory]: https://docs.github.com/code-security/security-advisories/working-with-repository-security-advisories/creating-a-repository-security-advisory

## Security advisories in the pub client

## pub 客户端中的安全公告

The pub client surfaces security advisories at dependency resolution.
For instance, when running `dart pub get` you will get the following output:

pub 客户端会在依赖解析时提示安全公告。
例如，运行 `dart pub get` 时会看到如下输出：

```console
$ dart pub get
Resolving dependencies...
http 0.13.0 (affected by advisory: [^0], 1.2.0 available)
Got dependencies!
Dependencies are affected by security advisories:
  [^0]: https://github.com/advisories/GHSA-4rgh-jx4f-qfcq
```

If resolution identifies an advisory, the Dart team recommends you
visit the link and review the advisory.
If you assess that the vulnerability affects your package, you
should strongly consider upgrading to a non-affected version of the dependency.

如果解析过程发现了公告，Dart 团队建议你打开链接并阅读该公告。
如果你判断该漏洞会影响你的 package，
强烈建议升级到不受影响的依赖版本。


### Ignoring security advisories

### 忽略安全公告

If a security advisory is not relevant for your application,
you can suppress the warning by adding the advisory identifier to
the [`ignored_advisories`][] list in the `pubspec.yaml` of your package.
For example, the following ignores the advisory
with the GHSA identifier `GHSA-4rgh-jx4f-qfcq`:

如果某条安全公告与你的应用无关，
可以把公告标识加入 package 的 `pubspec.yaml` 里的
[`ignored_advisories`][] 列表，从而不再显示这条警告。
例如，下面的配置会忽略 GHSA 标识为 `GHSA-4rgh-jx4f-qfcq` 的公告：

```yaml
name: myapp
dependencies:
  foo: ^1.0.0
ignored_advisories:
 - GHSA-4rgh-jx4f-qfcq
```

The `ignored_advisories` list only affects the root package. Ignored
advisories in your dependencies will have no effect on package resolution
for your own package.

`ignored_advisories` 列表只对根 package 生效。
依赖里被忽略的公告，不会影响你自己的 package 的解析。

[`ignored_advisories`]: /tools/pub/pubspec#ignored_advisories
