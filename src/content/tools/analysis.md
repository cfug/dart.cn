---
# title: Customizing static analysis
title: 自定义静态分析
# description: >-
#   Use an analysis options file and code comments to customize static analysis.
description: 通过对分析文件和代码注释来自定义静态分析的内容。
body_class: highlight-diagnostics
---

<?code-excerpt replace="/ *\/\/\s+ignore_for_file:[^\n]+\n//g; /(^|\n) *\/\/\s+ignore: (stable|beta|dev)[^\n]+\n/$1/g; /(\n[^\n]+) *\/\/\s+ignore: (stable|beta|dev)[^\n]+\n/$1\n/g; /. • (lib|test)\/\w+\.dart:\d+:\d+//g"?>

Static analysis allows you to find problems before
executing a single line of code. It's a powerful tool
used to prevent bugs and ensure that code conforms to style
guidelines.

静态分析让你的代码问题能在运行前被发现，
它在防止问题产生和代码风格指南的遵循上很有帮助。

With the help of the analyzer, you can find
simple typos. For example, perhaps an accidental semicolon
made its way into an `if` statement:

在分析器的帮助下，你可以发现简单的拼写错误。
例如，可能在 `if` 语句中不小心多打了一个分号：

<blockquote class="ml-3">

<?code-excerpt "analysis/lib/lint.dart (empty_statements)" replace="/(if .*?)(;)/$1[!$2!]/g"?>
```dart showLineNumbers=8
void increment() {
  if (count < 10) [!;!]
  count++;
}
```

If properly configured, the analyzer points to the semicolon and
produces the following warning:

如果配置得当，分析器会指出这个分号的位置并输出如下警告：

<?code-excerpt "analysis/analyzer-results-stable.txt" retain="empty_statements" replace="/lib\/lint.dart/example.dart/g"?>
```plaintext
info - example.dart:9:19 - Unnecessary empty statement. Try removing the empty statement or restructuring the code. - empty_statements
```

</blockquote>

The analyzer can also help you find more subtle problems.
For example, perhaps you've forgotten to close a sink method:

分析器也能帮你找出更多细节问题。
例如，也许你忘记关闭一个 sink 了：

<blockquote class="ml-3">

<?code-excerpt "analysis/lib/lint.dart (close_sinks)" replace="/(contr.*?)(;)/[!$1!]$2/g"?>
```dart
var [!controller = StreamController<String>()!];
```

<?code-excerpt "analysis/analyzer-results-stable.txt" retain="close_sinks" replace="/-(.*?):(.*?):(.*?)-/-/g"?>
```plaintext
info - Unclosed instance of 'Sink'. Try invoking 'close' in the function in which the 'Sink' was created. - close_sinks
```

</blockquote>

In the Dart ecosystem,
the Dart Analysis Server and other tools use the
[analyzer package]({{site.pub-pkg}}/analyzer)
to perform static analysis.

在 Dart 生态系统中，Dart 分析服务和其他相关工具使用了
[analyzer]({{site.pub-pkg}}/analyzer)
来提供静态分析。

You can customize static analysis to look for a variety of potential
problems, including errors and warnings specified in the
[Dart language spec](/guides/language/spec).
You can also configure linter rules,
to ensure that your code complies with the
[Dart Style Guide](/effective-dart/style)
and other suggested guidelines in [Effective Dart][]. 
Tools such as [`dart analyze`](/tools/dart-analyze),
[`flutter analyze`]({{site.flutter-docs}}/testing/debugging#the-dart-analyzer),
and [IDEs and editors](/tools#editors)
use the analyzer package to evaluate your code.

你可以自定义静态分析以寻找各种潜在的问题，
包括在 [Dart 编程语言规范](/guides/language/spec) 中规定的错误和警告。
你同样能通过配置 linter ——分析器的一个插件，
来确保你的代码遵循 [Dart 代码风格指南](/effective-dart/style)
和 [高效 Dart][Effective Dart] 中其他建议的准则。
诸如 [`dart analyze`](/tools/dart-analyze),
[`flutter analyze`]({{site.flutter-docs}}/testing/debugging#the-dart-analyzer),
以及 [IDE 和编辑器](/tools#ides-and-editors)
等 Dart 工具都会使用 analyzer package 来评估你的代码。

This document explains how to customize the behavior of the analyzer
using either an analysis options file or comments in Dart source code. If you want to
add static analysis to your tool, see the
[analyzer package]({{site.pub-pkg}}/analyzer) docs and the
[Analysis Server API Specification.](https://htmlpreview.github.io/?https://github.com/dart-lang/sdk/blob/main/pkg/analysis_server/doc/api.html)

这篇文档解释了如何通过使用分析配置文件，
或在 Dart 源代码中添加注释来自定义分析器的行为。
如果你想在工具中添加静态分析规则，请参考 [analyzer package]({{site.pub-pkg}}/analyzer) 的文档
和 [Analysis Server API 规范](https://htmlpreview.github.io/?https://github.com/dart-lang/sdk/blob/main/pkg/analysis_server/doc/api.html)。

:::note
  
To view various analyzer diagnostics with explanations and common fixes,
see [Diagnostic messages][diagnostics].

要查看分析器的各种诊断及其解释和通用修复，请参考 [诊断消息][diagnostics]。

:::

## The analysis options file

## 分析配置文件

Place the analysis options file, `analysis_options.yaml`,
at the root of the package, in the same directory as the pubspec file.

将分析配置文件 `analysis_options.yaml` 放在包的根目录，
即和 pubspec 文件同样的目录下。

Here's a sample analysis options file:

这是一个分析配置文件的示例：

<?code-excerpt "analysis_options.yaml" from="include" remove="implicit-dynamic" retain="/^$|\w+:|- cancel/" remove="https:"?>
```yaml title="analysis_options.yaml"
include: package:lints/recommended.yaml

analyzer:
  exclude: [build/**]
  language:
    strict-casts: true
    strict-raw-types: true

linter:
  rules:
    - cancel_subscriptions
```

The sample illustrates the most common top-level entries:

该示例说明了一些最常用的顶级配置入口：

- Use <code>include: <em>url</em></code> to
  bring in options from the specified URL—in this case,
  from a file in the `lints` package.
  Because YAML doesn't allow duplicate keys,
  you can include at most one file.
  
  使用 <code>include: <em>url</em></code> 来从指定的 URL 引入选项 —— 在这种情况下，
  通常是引入来自 lints 包中的文件。
  由于 YAML 不支持多个重复的 key，你只能引入最多一个文件；
  
- Use the `analyzer:` entry to customize static analysis:
  [enabling stricter type checks](#enabling-additional-type-checks),
  [excluding files](#excluding-files),
  [ignoring specific rules](#ignoring-rules),
  [changing the severity of rules](#changing-the-severity-of-rules), or
  [enabling experiments](/tools/experiment-flags#using-experiment-flags-with-the-dart-analyzer-command-line-and-ide).
  
  使用 `analyzer:` 入口来自定义静态分析：
  [启用更严格的类型检查](#enabling-additional-type-checks),
  [排除文件](#excluding-files),
  [忽略特定规则](#ignoring-rules),
  [改变规则的警告等级](#changing-the-severity-of-rules), or
  [开启实验性功能](/tools/experiment-flags#using-experiment-flags-with-the-dart-analyzer-command-line-and-ide)；

- Use the `linter:` entry to configure [linter rules](#enabling-linter-rules).

  使用 `linter:` 入口来配置 [linter 规则](#enabling-linter-rules)。

:::warning

**YAML is sensitive to whitespace.** 
Don't use tabs in a YAML file,
and use 2 spaces to denote each level of indentation.

**YAML 对空格敏感。**
不要在 YAML 文件中使用 tab，
用 2 个空格来表示每一级缩进。

:::

If the analyzer can't find an analysis options file at the package root,
it walks up the directory tree, looking for one.
If no file is available, the analyzer defaults to standard checks.

如果分析器在 package 的根目录下无法找到一个分析配置文件，
它将会往下查找整个目录树。
如果还是没有可用的配置文件，分析器则默认使用标准检查规则。

Consider the following directory structure for a large project:

对于如下所示的一个大型项目的目录结构而言：

<img 
  src="/assets/img/guides/analysis-options-directory-structure.png"
  alt="project root contains analysis_options.yaml (#1) and 3 packages, one of which (my_package) contains an analysis_options.yaml file (#2).">

The analyzer uses file #1 to analyze the code in `my_other_package`
and `my_other_other_package`, and file #2 to analyze the code in
`my_package`.

分析器使用 #1 文件来分析 `my_other_package` 
和 `my_other_other_package` 中的代码，
使用 #2 文件来分析 `my_package` 中的代码。

<!-- ## Enabling stricter type checks {:#enabling-additional-type-checks} -->

## 启用更严格的类型检查 {:#enabling-additional-type-checks}

If you want stricter static checks than
the [Dart type system][type-system] requires,
consider enabling the 
`strict-casts`, `strict-inference`, and `strict-raw-types` language modes:

如果你想要比 [Dart 类型系统][type-system] 所要求的更加严格的类型检查，
考虑开启 `strict-casts`，`strict-inference`，
和 `strict-raw-types` 语言模式：

<?code-excerpt "analysis/analysis_options.yaml" from="analyzer" to="strict-raw-types" remove="exclude"?>
```yaml title="analysis_options.yaml"
analyzer:
  language:
    strict-casts: true
    strict-inference: true
    strict-raw-types: true
```

You can use the modes together or separately; all default to `false`.

你可以单独或一起使用这些模式，他们默认都为 `false` 状态。

`strict-casts: <bool>`
<br> A value of `true` ensures that the type inference engine never
  implicitly casts from `dynamic` to a more specific type.
  The following valid Dart code includes an implicit downcast from the
  `dynamic` value returned by `jsonDecode` to `List<String>`
  that could fail at runtime.
  This mode reports the potential error, 
  requiring you to add an explicit cast or otherwise adjust your code.

`strict-casts: <bool>`
<br> 设为 `true` 可确保类型推理引擎不再将 `dynamic` 进行隐式类型转换。
  下方的 Dart 代码在 `List<String>` 参数上传递了一个 `jsonDecode` 方法的返回值，
  实际是将返回的 `dynamic` 做了隐式向下转换，在运行时可能导致错误。
  该模式会报告此类潜在的错误，要求你添加一个显示的类型转换或者调整你的代码。

<?code-excerpt "analysis/lib/strict_modes.dart (strict-casts)" replace="/jsonDecode\(jsonText\)/[!$&!]/g"?>
```dart tag=fails-sa
void foo(List<String> lines) {
  ...
}

void bar(String jsonText) {
  foo([!jsonDecode(jsonText)!]); // Implicit cast
}
```

<?code-excerpt "analysis/analyzer-results-stable.txt" retain="The argument type 'dynamic' can't be assigned"  replace="/-(.*?):(.*?):(.*?)-/-/g"?>
```plaintext
error - The argument type 'dynamic' can't be assigned to the parameter type 'List<String>'. - argument_type_not_assignable
```

:::version-note

The `strict-casts` mode was introduced in Dart 2.16.
To enable similar checks with earlier SDK releases,
consider using the now deprecated `implicit-casts` option:

`strict-casts` 模式在 Dart 2.16 中被引入。
想在更早的 SDK 发布版中启用类似的检查，
考虑使用当前已废弃的 `implicit-casts` 选项：

```yaml
analyzer:
  strong-mode:
    implicit-casts: false
```
:::

`strict-inference: <bool>`
<br> A value of `true` ensures that the type inference engine never chooses
  the `dynamic` type when it can't determine a static type.
  The following valid Dart code creates a `Map`
  whose type argument cannot be inferred, 
  resulting in an inference failure hint by this mode:

`strict-inference: <bool>`
<br> 设为 `true` 可确保当类型推理引擎无法确定静态类型时，不再选择`dynamic` 类型。
  下方合法 Dart 代码创建了一个类型参数无法被推断的 `Map`，
  在该模式下会触发推断失败的 hint 提示：

<?code-excerpt "analysis/lib/strict_modes.dart (strict-inference)" replace="/{}/[!$&!]/g"?>
```dart tag=fails-sa
final lines = [!{}!]; // Inference failure
lines['Dart'] = 10000;
lines['C++'] = 'one thousand';
lines['Go'] = 2000;
print('Lines: ${lines.values.reduce((a, b) => a + b)}'); // Runtime error
```
{:analyzer}

<?code-excerpt "analysis/analyzer-results-stable.txt" retain="The type argument(s) of 'Map'"  replace="/. Use.*'Map'. / /g; /-(.*?):(.*?):(.*?)-/-/g"?>
```plaintext
warning - The type argument(s) of 'Map' can't be inferred - inference_failure_on_collection_literal
```

:::tip

The `strict-inference` mode can identify many situations
which result in an inference failure.

`strict-inference` 模式能识别多种推断失败的情况。

See [Conditions for strict inference failure][] 
for an exhaustive list of inference failure conditions.

查看 [严格类型推断失败的条件][Conditions for strict inference failure]
来了解详细的推断失败条件清单。

:::

[Conditions for strict inference failure]: https://github.com/dart-lang/language/blob/main/resources/type-system/strict-inference.md#conditions-for-strict-inference-failure

`strict-raw-types: <bool>`
<br> A value of `true` ensures that the type inference engine never chooses
  the `dynamic` type when it can't determine a static type
  due to omitted type arguments.
  The following valid Dart code has a `List` variable with a raw type,
  resulting in a raw type hint by this mode:

`strict-raw-types: <bool>`
<br> 设为 `true` 可确保当类型推理引擎，由于省略类型参数而无法确定静态类型时，
  不再选择`dynamic` 类型。
  下方合法 Dart 代码中有一个原始类型的 `List` 变量，
  导致在该模式下触发了原始类型 hint 提示。

<?code-excerpt "analysis/lib/strict_modes.dart (strict-raw-types)" replace="/List n/[!List!] n/g"?>
```dart tag=fails-sa
[!List!] numbers = [1, 2, 3]; // List with raw type
for (final n in numbers) {
  print(n.length); // Runtime error
}
```

<?code-excerpt "analysis/analyzer-results-stable.txt" retain="The generic type" replace="/. Use explicit.*\. / /g; /-(.*?):(.*?):(.*?)-/-/g"?>
```plaintext
warning - The generic type 'List<dynamic>' should have explicit type arguments but doesn't - strict_raw_type
```

<!-- ## Enabling and disabling linter rules {:#enabling-linter-rules} -->

## 启用和停用 linter 规则 {:#enabling-linter-rules}

The analyzer package also provides a code linter. A wide variety of
[linter rules][] are available. Linters tend to be
nondenominational—rules don't have to agree with each other.
For example, some rules are more appropriate for regular Dart packages
and others are designed for Flutter apps.
Note that linter rules can have false positives, unlike static analysis.

analyzer 包同样提供一个代码 linter，并包含一份广泛多样的 [linter 规则][linter rules]。
提示规则之间往往是无关联性的，各种规则之间不必彼此遵守。
例如，有些规则更合适支持库，而另一些则是为 Flutter 应用设计的。
注意，linter 规则可能会触发误报，静态分析则不会。

<!-- ### Enabling Dart team recommended linter rules {:#lints} -->

### 启用 Dart 团队推荐的 linter 规则 {:#lints}

The Dart team provides two sets of recommended linter rules
in the [lints package][]:

Dart 团队在 [lints package][] 中提供了 2 个推荐的 linter 规则集合：

Core rules
<br> Help identify critical issues that are likely to lead to problems
  when running or consuming Dart code.
  All code should pass these linter rules.
  Packages that are uploaded to [pub.dev]({{site.pub}})
  have a [package score]({{site.pub}}/help/scoring)
  that's based in part on passing these rules.

核心规则
<br> 帮助确认可能导致在运行或使用 Dart 代码时引发问题的关键事项。
  所有类型的代码都应该符合这些 linter 规则。
  被上传至 [pub.dev]({{site.pub}}) 的 package，
  会有一个部分基于通过这些规则的情况而生成的 [package 评分]({{site.pub}}/help/scoring)。

Recommended rules
<br> Help identify additional issues
  that may lead to problems when running or consuming Dart code,
  and enforce a single, idiomatic style and format.
  We recommend that all Dart code use these rules,
  which are a superset of the core rules.

推荐规则
<br> 帮助确认其他可能导致运行或使用 Dart 代码时引发问题的事项，
  并强制使用单一、惯用的代码风格和代码格式化。
  作为一个核心规则的超集，我们推荐所有的 Dart 代码使用它。

:::tip

If you're working on Flutter code, then instead of using the `lints` package, 
use [`flutter_lints`]({{site.pub-pkg}}/flutter_lints),
which provides a superset of the recommended rules.

如果你专注于 Flutter 代码，可以用 [`flutter_lints`]({{site.pub-pkg}}/flutter_lints)
来取代 `lints` package，它提供了一个推荐规则的超集。

:::

To enable either set of lints,
add the [lints package][] as a dev dependency:

将 [lints package][] 作为 dev dependency 添加，
来启用任意 lints 集合。

```console
$ dart pub add --dev lints
```

Then edit your `analysis_options.yaml` file to include
your preferred rule set:

然后编辑 `analysis_options.yaml` 文件来引入你想要的规则集合：

```yaml
include: package:lints/<RULE_SET>.yaml
```

For example, you can include the recommended rule set like this:

例如，你可以像这样引入推荐规则的集合：

```yaml
include: package:lints/recommended.yaml
```

:::important

When a **new version of `lints`** is published,
code that previously passed analysis might **start failing analysis.**
We recommend updating your code to work with the new rules.
Other options are to explicitly enable individual linter rules 
or [disable individual rules][].

当一个 **新版本的 `lints`** 上线后，
之前通过 analysis 检查的代码，有可能 **开始无法通过**。
我们推荐更新你的代码以符合新版规则。
其他选项可以通过显式的方法，启用单条规则或 [停用单条规则][disable individual rules]。

:::

[lints package]: {{site.pub-pkg}}/lints

<!-- ### Enabling individual rules {:#individual-rules} -->

### 启用单条规则 {:#individual-rules}

To enable a single linter rule, add `linter:` to the analysis options file
as a top-level key,
followed by `rules:` as a second-level key.
On subsequent lines, specify the rules that you want to apply,
prefixed with dashes (the syntax for a YAML list).
For example:

在分析配置文件中添加顶层 key `linter:` 来启用单条规则，
紧跟着用 `rules:` 作为二级 key。
在后续行中，以短横杠为前缀（YAML 列表的语法），指定你想要添加的规则。
例如：

<?code-excerpt "analysis_options.yaml" from="linter:" take="12" remove="https:"?>
```yaml
linter:
  rules:
    - always_declare_return_types
    - cancel_subscriptions
    - close_sinks
    - combinators_ordering
    - comment_references
    - invalid_case_patterns
    - library_annotations
    - one_member_abstracts
    - only_throw_errors
```


### Disabling individual rules

### 停用单条规则

If you include an analysis options file such as the one in `lints`,
you might want to disable some of the included rules.
Disabling individual rules is similar to enabling them,
but requires the use of a map rather than a list
as the value for the `rules:` entry,
so each line should contain the name of a rule followed by
either `: false` or `: true`.

如果你引入了一个分析配置文件（比如 `lints` 中的某一个），
你可能会想要停用其中的一部分。
停用单条规则和启用单条规则是类似的，
但要求使用键值对而不是列表来作为 `rules:` 的值。
因此每一行应该包括规则的名字，后面跟上 `: false` 或者 `: true`。

Here's an example of an analysis options file
that uses all the recommended rules from `lints`
except `avoid_shadowing_type_parameters`.
It also enables the lint `await_only_futures`:

这里是一个分析配置文件的示例，
其中使用了来自 `lints` 的所有推荐规则，
除了 `avoid_shadowing_type_parameters` 被单独停用。
这里同样单独启用了 `await_only_futures` 这条 lint。

<?code-excerpt "analysis_alt/analysis_options_linter.yaml"?>
```yaml title="analysis_options.yaml"
include: package:lints/recommended.yaml

linter:
  rules:
    avoid_shadowing_type_parameters: false
    await_only_futures: true
```

:::note

Due to YAML restrictions, 
**you can't mix list and key-value syntax in the same `rules` entry.**
You can use the other syntax for rules in an included file.

由于 YAML 的限制，
**你不能把列表和键值对在同一个 `rules` 入口下混用。**
如果想这样做，你只能在引用的文件中使用另一种语法。

:::

## Enabling analyzer plugins (experimental) {:#plugins}

The analyzer has experimental support for plugins.
These plugins integrate with the analyzer to add functionality
such as new diagnostics, quick fixes, and custom code completion.
You can enable only one plugin per `analysis_options.yaml` file.
Enabling an analyzer plugin increases how much memory the analyzer uses.

Don't use analyzer plugins if your situation meets
either of the following conditions:

* You use a development machine with less than 16 GB of memory.
* You use a mono-repo with more than 10 `pubspec.yaml` and
  `analysis_options.yaml` files.
  
You can find a few analyzer plugins on
[pub.dev]({{site.pub-pkg}}?q=dependency%3Aanalyzer_plugin).

To enable a plugin:

 1. Add the package containing the plugin as a dev dependency.

    ```console
    $ dart pub add --dev <your_favorite_analyzer_plugin_package>
    ```

 2. Edit your `analysis_options.yaml` file to enable the plugin.

    ```yaml
    analyzer:
      plugins:
        - your_favorite_analyzer_plugin_package
    ```

    To indicate specific plugin functionality to enable,
    such as new diagnostics, additional setup might be required.

## Excluding code from analysis

## 从 analysis 中排除代码

Sometimes it's OK for some code to fail analysis.
For example, you might rely on code generated by a package that
you don't own—the generated code works,
but produces warnings during static analysis.
Or a linter rule might cause a false positive
that you want to suppress.

有时候，部分代码可能允许包含分析出的警告和提示。
例如，你也许依赖于某个不属于你 package 所生成的代码，
这些代码可以正常运行，但是在静态检查中会产生警告。
或者某个 linter 规则可能会出现你想关掉的误报。

You have a few ways to exclude code from analysis:

有几种方法可以从 analysis 中排除代码：

* Exclude entire files from analysis.

  从 analysis 中排除整个文件。

* Stop specific non-error rules from being applied to individual files.

  在单个文件中停止特定的非错误规则的生效。
  
* Stop specific non-error rules from being applied to individual lines of code.

  在单个文件的某几行中，停止特定的非错误规则的生效。

You can also [disable specific rules][disable individual rules]
for all files or
[change the severity of rules][].

你同样可以对所有文件 [停用特定的规则][disable individual rules]，
或者 [改变规则的警告等级][change the severity of rules]。

### Excluding files

### 排除文件

To exclude files from static analysis, use the `exclude:` analyzer option.
You can list individual files, or 
use [glob]({{site.pub-pkg}}/glob) pattern syntax.
All usages of glob patterns should be relative to the
directory containing the `analysis_options.yaml` file.

使用分析器选项 `exclude:` 在静态分析中排除文件。
你可以列出单独的文件，或者用 [glob]({{site.pub-pkg}}/glob) 语法。
所有 glob 都使用相对于 `analysis_options.yaml` 的路径。

<?code-excerpt "analysis_alt/analysis_options.yaml (exclude)" plaster="none"?>
```yaml
analyzer:
  exclude:
    - lib/client.dart
    - lib/server/*.g.dart
    - test/_data/**
```

<a id="suppressing-rules-for-a-file"></a>
### Suppressing diagnostics for a file

### 对单个文件忽略诊断

To ignore a specific non-error diagnostic for a specific file,
add an `ignore_for_file` comment to the file:

通过在文件中添加 `ignore_for_file` 注释，
使得特定的非错误诊断对该文件忽略。

<?code-excerpt "analysis/lib/assignment.dart (ignore_for_file)" replace="/, \w+//g"?>
```dart
// ignore_for_file: unused_local_variable
```

This acts for the whole file, before or after the comment, and is
particularly useful for generated code.

该操作对整个文件都生效，不论代码是在注释之前还是之后，
对于生成的代码尤其有用。

To suppress more than one diagnostic, use a comma-separated list:

使用逗号分隔的列表，可以忽略多条诊断：

<?code-excerpt "analysis/lib/assignment.dart (ignore_for_file)"?>
```dart
// ignore_for_file: unused_local_variable, duplicate_ignore, dead_code
```

To suppress all linter rules, add a `type=lint` specifier:

添加 `type=lint` 以忽略所有的 linter 规则：

<?code-excerpt "analysis/lib/ignore_lints.dart (ignore_type_for_file)"?>
```dart
// ignore_for_file: type=lint
```

:::version-note

Support for the `type=lint` specifier was added in Dart 2.15.

对 `type=lint` 的支持从 Dart 2.15 起被加入。

:::

<a id="suppressing-rules-for-a-line-of-code"></a>
### Suppressing diagnostics for a line of code

### 对一行代码忽略诊断

To suppress a specific non-error diagnostic on a specific line of Dart code,
put an `ignore` comment above the line of code. 
Here's an example of ignoring code that causes a runtime error, 
as you might do in a language test:

通过在单行代码的上方添加 `ignore` 注释，
使得特定的非错误诊断对该行 Dart 代码忽略。
这是一个忽略代码导致运行时错误的例子，
你可能会在一个开发语言的测试上使用。

<?code-excerpt "analysis/lib/assignment.dart (invalid_assignment)"?>
```dart
// ignore: invalid_assignment
int x = '';
```

To suppress more than one diagnostic, supply a comma-separated list:

使用逗号分隔的列表，可以忽略多条规则：

<?code-excerpt "analysis/lib/assignment.dart (ignore-more)"?>
```dart
// ignore: invalid_assignment, const_initialized_with_non_constant_value
const x = y;
```

Alternatively, append the ignore comment to the line that it applies to:

或者，将需要忽略的规则追加到相应的行后：

<?code-excerpt "analysis/lib/assignment.dart (single-line)"?>
```dart
int x = ''; // ignore: invalid_assignment
```

### Suppressing diagnostics in a pubspec file

If you need to suppress a non-error diagnostic from the analyzer
in a `pubspec.yaml` file, add an `ignore` comment above the affected line.

The following example ignores the [`sort_pub_dependencies`][] lint
as it wants to put the `flutter` dependency first:

```yaml title="pubspec.yaml".
dependencies:
  flutter:
    sdk: flutter

  # ignore: sort_pub_dependencies
  collection: ^1.18.0
```

:::version-note
Support for ignore comments in `pubspec.yaml` files was added in Dart 3.3.
If you are using Dart 3.2 or earlier,
the ignored diagnostic will still be triggered.
:::

[`sort_pub_dependencies`]: /tools/linter-rules/sort_pub_dependencies

## Customizing analysis rules

## 自定义 analysis 规则

Each [analyzer diagnostic][analyzer diagnostics] and
[linter rule][linter rules] has a default severity.
You can use the analysis options file to change
the severity of individual rules, or to always ignore some rules.

每个 [分析器错误][analyzer diagnostics] 和 [linter 规则][linter rules] 
都有一个默认的警告等级。
你可以使用分析配置文件来改变单个规则的警告等级，
或者总是忽略某些规则。

The analyzer supports three severity levels:

分析器支持三种警告等级：

`info`
<br> An informational message that doesn't cause analysis to fail.
  Example: [`dead_code`][dead_code]

`info`
<br> 消息，不会造成 analysis 验证失败。
  例如：[`dead_code`][dead_code]

`warning`
<br> A warning that doesn't cause analysis to fail unless
  the analyzer is configured to treat warnings as errors.
  Example: [`invalid_null_aware_operator`][invalid_null_aware_operator]

`warning`
<br> 警告，一般不会造成 analysis 验证失败，
  除非分析器被配置了对待警告与错误一致。
  例如：[`invalid_null_aware_operator`][invalid_null_aware_operator]

`error`
<br> An error that causes analysis to fail.
  Example: [`invalid_assignment`][invalid_assignment]

`error`
<br> 错误，会造成 analysis 验证失败。
  例如：[`invalid_assignment`][invalid_assignment]

### Ignoring rules

### 忽略规则

You can ignore specific [analyzer diagnostics][] and [linter rules][]
by using the `errors:` field.
List the rule, followed by <code>:&nbsp;ignore</code>. For example, the following
analysis options file instructs the analysis tools to ignore the TODO rule:

你可以通过使用 `errors:` 字段，
来忽略特定的 [分析器错误][analyzer diagnostics] and [linter 规则][linter rules]。
列出规则，在后面加上 <code>:&nbsp;ignore</code>。
例如下方的分析配置文件，指示分析器工具忽略了 TODO 规则：

<?code-excerpt "analysis_alt/analysis_options.yaml (errors)" to="ignore"?>
```yaml
analyzer:
  errors:
    todo: ignore
```


### Changing the severity of rules

### 修改规则的警告等级

You can globally change the severity of a particular rule.
This technique works for regular analysis issues as well as for lints.
For example, the following analysis options file instructs the analysis tools to
treat invalid assignments as warnings and missing returns as errors,
and to provide information (but not a warning or error) about dead code:

你可以全局修改单个规则的警告等级。
这项技术对于常规的 analysis 问题和 lints 问题都有效。
例如下方的分析配置文件，指示分析器工具把无效的赋值配置为警告，
把缺少返回值配置为错误，而对于无法执行到的代码，仅提供并非警告和错误的信息通知。

<?code-excerpt "analysis_alt/analysis_options.yaml (errors)" remove="ignore"?>
```yaml
analyzer:
  errors:
    invalid_assignment: warning
    missing_return: error
    dead_code: info
```


## Resources

## 更多资源

Use the following resources to learn more about static analysis in Dart:

你还可以通过以下资源来深入了解 Dart 的静态分析：

* [Dart's type system][type-system]
* [Dart linter rules][linter rules]
* [analyzer package]({{site.pub-pkg}}/analyzer)

[invalid_null_aware_operator]: /tools/diagnostic-messages#invalid_null_aware_operator
[analyzer diagnostics]: /tools/diagnostic-messages
[change the severity of rules]: #changing-the-severity-of-rules
[diagnostics]: /tools/diagnostic-messages
[invalid_assignment]: /tools/diagnostic-messages#invalid_assignment
[language version]: /guides/language/evolution#language-versioning
[linter rules]: /tools/linter-rules
[type-system]: /language/type-system
[dead_code]: /tools/diagnostic-messages#dead_code
[disable individual rules]: #disabling-individual-rules
[Effective Dart]: /effective-dart
