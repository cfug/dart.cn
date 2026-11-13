---
# title: Linter rules
title: Linter 规则
# description: Details about the Dart linter and its style rules you can choose.
description: 关于 Dart linter 以及可选代码风格规则的详细说明。
bodyClass: diagnostics
ai-translated: true
---

Use the Dart linter to identify possible problems in your Dart code.
You can use the linter through your IDE
or with the [`dart analyze`](/tools/dart-analyze) command.
For information on how to enable and disable individual linter rules, see
[individual rules sections][] of the [analyzer documentation][].

使用 Dart linter 找出 Dart 代码中可能存在的问题。
可以通过 IDE 使用 linter，
也可以使用 [`dart analyze`](/tools/dart-analyze) 命令。
如何启用和停用单条 linter 规则，
请参阅 [分析器文档][analyzer documentation] 的
[单条规则][individual rules sections] 部分。

[individual rules sections]: /tools/analysis#individual-rules
[analyzer documentation]: /tools/analysis

This page lists all the linter rules,
with details such as when you might want to use each rule,
what code patterns trigger it, and
how you might fix your code.

本页列出全部 linter 规则，
并说明何时可能想使用某条规则、
哪些代码模式会触发它，
以及如何修复代码。

:::tip
Linter rules (sometimes called _lints_) can have false positives,
and they don't all agree with each other.
For example, some rules are more appropriate for regular Dart packages,
and others are designed for Flutter apps.

linter 规则（有时称为 **lint**）可能出现误报，
而且它们彼此并不总是一致。
例如，有些规则更适合普通的 Dart package，
另一些则是为 Flutter 应用设计的。
:::

<a id="predefined-rule-sets"></a>
## Sets

## 规则集

To avoid the need to individually select compatible linter rules,
consider starting with a linter rule set,
which the following packages provide:

不必逐条挑选彼此兼容的 linter 规则，
可以先从一个 linter 规则集开始。
下列 package 提供了这些规则集：

<a id="lints"></a>

[lints][]
: Contains two rule sets curated by the Dart team. 
  We recommend using at least the `core` rule set, 
  which is used when [scoring]({{site.pub}}/help/scoring) 
  packages uploaded to [pub.dev]({{site.pub}}). 
  Or, better yet, use the `recommended` rule set, 
  a superset of `core` that identifies additional issues
  and enforces style and format. 
  If you're writing Flutter code, 
  use the rule set in the [`flutter_lints`](#flutter_lints) package,
  which builds on `lints`.

  包含 Dart 团队整理的两套规则集。
  建议至少使用 `core` 规则集，
  上传到 [pub.dev]({{site.pub}}) 的 package
  在 [评分]({{site.pub}}/help/scoring) 时会用到它。
  更好的选择是 `recommended` 规则集，
  它是 `core` 的超集，能发现更多问题，并约束代码风格和格式。
  如果在编写 Flutter 代码，
  请使用 [`flutter_lints`](#flutter_lints) package 中的规则集，
  它建立在 `lints` 之上。

<a id="flutter_lints"></a>

[flutter_lints][]
: Contains the `flutter` rule set,
  which the Flutter team encourages you to use
  in Flutter apps, packages, and plugins.
  This rule set is a superset of the [`recommended`](#lints) set,
  which is itself a superset of the [`core`](#lints) set that
  partially determines the [score]({{site.pub}}/help/scoring) of
  packages uploaded to [pub.dev]({{site.pub}}).

  包含 `flutter` 规则集。
  Flutter 团队鼓励在 Flutter 应用、package 和插件中使用它。
  该规则集是 [`recommended`](#lints) 的超集，
  而 `recommended` 又是 [`core`](#lints) 的超集。
  `core` 会部分决定上传到 [pub.dev]({{site.pub}}) 的 package 的
  [评分]({{site.pub}}/help/scoring)。

[lints]: {{site.pub-pkg}}/lints
[flutter_lints]: {{site.pub-pkg}}/flutter_lints

To learn how to use a specific rule set,
visit the documentation for [enabling and disabling linter rules][].

要了解如何使用某一规则集，
请参阅 [启用和停用 linter 规则][enabling and disabling linter rules] 的文档。

To find more predefined rule sets,
check out the [`#lints` topic]({{site.pub-pkg}}?q=topic:lints) on pub.dev.

要查找更多预定义规则集，
请查看 pub.dev 上的 [`#lints` 话题]({{site.pub-pkg}}?q=topic:lints)。

[enabling and disabling linter rules]: /tools/analysis#enabling-linter-rules

<a id="maturity-levels"></a>
## Status

## 状态

Each rule has a status or maturity level:

每条规则都有状态或成熟度：

**Stable**
: These rules are safe to use and are verified as functional
  with the latest versions of the Dart language.
  All rules are considered stable unless
  they're marked as experimental, deprecated, or removed.

  **稳定**
  这些规则可以放心使用，并已在最新版本的 Dart 语言上验证可用。
  除非规则被标记为实验性、已弃用或已移除，否则都视为稳定。

**Experimental**
: These rules are still under evaluation and might never be stabilized.
  Use these with caution and report any issues you come across.

  **实验性**
  这些规则仍在评估中，可能永远不会稳定下来。
  请谨慎使用，并报告遇到的问题。

**Deprecated**
: These rules are no longer suggested for use
  and might be removed in a future Dart release.

  **已弃用**
  这些规则不再建议使用，
  并可能在未来的 Dart 版本中移除。

**Removed**
: These rules have already been removed in the
  latest stable Dart release.

  **已移除**
  这些规则已在最新稳定版 Dart 中移除。

## Quick fixes

## 快速修复

Some rules can be fixed automatically using quick fixes.
A quick fix is an automated edit 
targeted at fixing the issue
reported by the linter rule.

有些规则可以通过快速修复自动改正。
快速修复是一次自动化编辑，
针对 linter 规则报告的问题进行修复。

If the rule has a quick fix,
it can be applied using [`dart fix`](/tools/dart-fix)
or using your [editor with Dart support](/tools#editors).
To learn more, see [Quick fixes for analysis issues][].

如果规则带有快速修复，
可以使用 [`dart fix`](/tools/dart-fix)，
或使用 [支持 Dart 的编辑器](/tools#editors) 来应用。
更多内容见 [分析问题的快速修复][Quick fixes for analysis issues]。

[Quick fixes for analysis issues]: /blog/quick-fixes-for-analysis-issues

## Rules

## 规则

The following is an index of all linter rules and 
a short description of their functionality.
To learn more about a specific rule, 
click the **Learn more** button on its card.

下面是全部 linter 规则的索引，
以及它们功能的简短说明。
要进一步了解某条规则，
请点击卡片上的 **Learn more** 按钮。

For an auto-generated list containing all linter rules
in Dart `{{site.sdkVersion}}`,
check out [All linter rules](/tools/linter-rules/all).

要查看 Dart `{{site.sdkVersion}}` 中
自动生成的全部 linter 规则列表，
请参阅 [全部 linter 规则](/tools/linter-rules/all)。

---

<div><LintRuleIndex></LintRuleIndex></div>

[Dart style guide]: /effective-dart/style
