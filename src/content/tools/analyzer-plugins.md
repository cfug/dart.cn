---
# title: Analyzer plugins
title: 分析器插件
# description: >-
#  Analyzer plugins allow you to create custom lints, warnings,
#  and IDE quick fixes for your Dart projects
description: 分析器插件让你可以为 Dart 项目创建自定义 lint、警告和 IDE 快速修复。
ai-translated: true
---

:::version-note
Support for analyzer plugins was added in Dart 3.10.

分析器插件的支持在 Dart 3.10 中加入。
:::

Analyzer plugins extend the [Dart analyzer][] to report custom
diagnostics (lints and warnings), offer quick fixes,
and provide assists. This functionality is available directly
in your IDE and at the command line when you run
`dart analyze` or `flutter analyze`.

分析器插件扩展了 [Dart 分析器][Dart analyzer]，
用来报告自定义诊断（lint 和警告）、提供快速修复，
并提供辅助。在 IDE 中可以直接使用这些功能，
在命令行运行 `dart analyze` 或 `flutter analyze` 时也可以。

[Dart analyzer]: /tools/analysis

## Use analyzer plugins

## 使用分析器插件

You can start using an analyzer plugin in your Dart project
by enabling it in the `analysis_options.yaml` 
file at the root of your package or workspace.

可以在 package 或工作区根目录的 `analysis_options.yaml` 
文件中启用分析器插件，从而在 Dart 项目里开始使用它。

You can search for analyzer plugins on
[pub.dev]({{site.pub-pkg}}?q=dependency%3Aanalysis_server_plugin).

可以在
[pub.dev]({{site.pub-pkg}}?q=dependency%3Aanalysis_server_plugin)
上搜索分析器插件。

### Enable a plugin

### 启用插件

To enable an analyzer plugin, add it to the top-level
plugins section of your `analysis_options.yaml` file. You can
add a plugin from [pub.dev][] using a version constraint:

要启用分析器插件，请把它加到 `analysis_options.yaml` 文件
顶层的 plugins 部分。可以用版本约束从 [pub.dev][]
添加插件：

```yaml title="analysis_options.yaml"
plugins:
  my_plugin: ^1.0.0
```

Or, if you are developing a plugin locally, 
you can use a local path:

如果正在本地开发插件，可以使用本地路径：

```yaml title="analysis_options.yaml"
plugins:
  my_plugin:
    path: /path/to/my_plugin
```

After you have made changes to the plugins section, 
restart the Dart Analysis Server to see the effects.

修改 plugins 部分之后，
请重启 Dart Analysis Server 才能看到效果。

[pub.dev]: {{site.pub}}

### Configure diagnostics

### 配置诊断

A plugin can report two kinds of diagnostics: warnings and lints. 
The analyzer handles them differently by default:

插件可以报告两类诊断：警告和 lint。
分析器默认对它们的处理方式不同：

* Warnings that a plugin defines are enabled by 
  default (just like standard analyzer warnings).

  插件定义的警告默认启用（与标准分析器警告一样）。

* Lint rules that a plugin defines are disabled by default 
  and must be explicitly enabled in your analysis options file.

  插件定义的 lint 规则默认停用，
  必须在分析选项文件中显式启用。

You can enable or disable specific lint rules under 
the diagnostics section for a plugin:

可以在插件的 diagnostics 部分
启用或停用特定的 lint 规则：

```yaml title="analysis_options.yaml"
plugins:
  my_plugin:
    path: /path/to/my_plugin
    diagnostics:
      rule_1: true
      rule_2: true
      rule_3: false
```

In the preceding example, `rule_1` and `rule_2` are enabled. 
`rule_3` is explicitly disabled, which is useful for 
overriding a rule that might be enabled from an [`include:`][] 
file.

在上面的例子中，`rule_1` 和 `rule_2` 已启用。
`rule_3` 被显式停用，这在需要覆盖
可能由 [`include:`][] 文件启用的规则时很有用。

[`include:`]: /tools/analysis#including-shared-options

### Suppress diagnostics

### 抑制诊断

You can suppress diagnostics from a plugin using the same 
`ignore` comments as you would for [built-in Dart diagnostics][]. 
To target a diagnostic from a specific plugin, 
prefix the diagnostic code with the plugin name followed 
by a slash (`/`).

可以用与 [内置 Dart 诊断][built-in Dart diagnostics] 相同的
`ignore` 注释来抑制插件的诊断。
要针对某个插件的诊断，
请在诊断代码前加上插件名和一个斜杠（`/`）。

For example, to suppress a diagnostic with the 
code `some_code` from a plugin named `some_plugin`, 
use one of the following formats:

例如，要抑制名为 `some_plugin` 的插件中
代码为 `some_code` 的诊断，
可以使用下列格式之一：

To suppress for a single line:

抑制单行：

```dart
// ignore: some_plugin/some_code
```

To suppress for an entire file:

抑制整个文件：

```dart
// ignore_for_file: some_plugin/some_code
```

[built-in Dart diagnostics]: /tools/analysis#suppressing-diagnostics-for-a-file

## Write an analyzer plugin

## 编写分析器插件

Create your own analyzer plugin to add custom static analysis, 
quick fixes, or [assists][] to the Dart development experience.

可以编写自己的分析器插件，为 Dart 开发体验添加自定义静态分析、
快速修复或 [辅助][assists]。

[assists]: /resources/glossary#assist

### Set up the plugin package

### 搭建插件 package

An analyzer plugin is a standard Dart package with 
specific dependencies and structure. The primary dependency 
is the [`analysis_server_plugin` package][], 
which provides the core `Plugin` class.

分析器插件是一个标准的 Dart package，
具有特定的依赖和结构。主要依赖是
[`analysis_server_plugin` package][]，
它提供核心的 `Plugin` 类。

[`analysis_server_plugin` package]: {{site.pub-pkg}}/analysis_server_plugin

1. Create the `pubspec.yaml` file. For example:

   创建 `pubspec.yaml` 文件。例如：

   ```yaml title"pubspec.yaml"
   name: test_analyzer_plugin
   version: 0.0.1
   
   environment:
     sdk: ^3.10.0
   
   dependencies:
     analysis_server_plugin: ^0.3.0
     analyzer_plugin: ^0.13.0
     analyzer: ^8.0.0
   ```

2. Create the plugin entry point. For example:

   创建插件入口点。例如：

   ```dart title="lib/main.dart"
   import 'package:analysis_server_plugin/plugin.dart';
   import 'package:analysis_server_plugin/registry.dart';
   
   final plugin = SimplePlugin();
   
   class SimplePlugin extends Plugin {
     @override
     String get name => 'Simple plugin';
   
     @override
     void register(PluginRegistry registry) {
       // Register diagnostics, quick fixes, and assists.
     }
   }
   ```
   
   The preceding code represents the basic structure for plugin 
   entry point. Make sure that you have a `lib/main.dart` file 
   in your package because this is the entry point for the 
   analysis server to load your plugin.

   上面的代码是插件入口点的基本结构。
   请确保 package 中有 `lib/main.dart` 文件，
   因为分析服务器会从这个入口点加载插件。

Key points:

要点：

* You need a top-level variable named `plugin` that 
  instantiates your class. The Dart Analysis Server looks 
  for this variable.

  需要一个名为 `plugin` 的顶层变量来实例化你的类。
  Dart Analysis Server 会查找这个变量。

* Your class must extend `Plugin` from 
  `package:analysis_server_plugin/plugin.dart`.

  你的类必须扩展
  `package:analysis_server_plugin/plugin.dart` 中的 `Plugin`。

* Override the `register` method to add your 
  plugin's features. This method serves as the main entry 
  point for registering your custom analysis rules, 
  quick fixes, and assists with the analyzer.

  重写 `register` 方法来添加插件功能。
  该方法是向分析器注册自定义分析规则、
  快速修复和辅助的主要入口。

:::tip
After you have made changes to your plugin, restart the Dart
Analysis Server to see the effects.

修改插件之后，请重启 Dart Analysis Server 才能看到效果。
:::

### Implement plugin features

### 实现插件功能

Once you have your basic plugin package set up, 
you can start adding custom functionality by 
implementing the `register` method.

基本的插件 package 搭好之后，
就可以通过实现 `register` 方法开始添加自定义功能。

Read the following guides to learn how to implement specific
functionality:

阅读下列指南，了解如何实现具体功能：

* [Writing rules][]

  [编写规则][Writing rules]

* [Writing fixes][]

  [编写修复][Writing fixes]

* [Writing assists][]

  [编写辅助][Writing assists]

* [Testing rules][]

  [测试规则][Testing rules]

[Writing rules]: {{site.repo.dart.sdk}}/blob/main/pkg/analysis_server_plugin/doc/writing_rules.md
[Writing fixes]: {{site.repo.dart.sdk}}/blob/main/pkg/analysis_server_plugin/doc/writing_fixes.md
[Writing assists]: {{site.repo.dart.sdk}}/blob/main/pkg/analysis_server_plugin/doc/writing_assists.md
[Testing rules]: {{site.repo.dart.sdk}}/blob/main/pkg/analysis_server_plugin/doc/testing_rules.md

Check the Dart Analysis Server for many examples of rules,
fixes, and, assists:

Dart Analysis Server 中有许多规则、修复和辅助的例子：

* [Dart Analysis Server's rules][]

  [Dart Analysis Server 的规则][Dart Analysis Server's rules]

* [Dart Analysis Server's fixes][]

  [Dart Analysis Server 的修复][Dart Analysis Server's fixes]

* [Dart Analysis Server's assists][]

  [Dart Analysis Server 的辅助][Dart Analysis Server's assists]

[Dart Analysis Server's rules]: {{site.repo.dart.sdk}}/tree/main/pkg/linter/lib/src/rules
[Dart Analysis Server's fixes]: {{site.repo.dart.sdk}}/tree/main/pkg/analysis_server/lib/src/services/correction/dart
[Dart Analysis Server's assists]: {{site.repo.dart.sdk}}/tree/main/pkg/analysis_server/lib/src/services/correction/dart

### Debug a plugin

### 调试插件

If your plugin is not working as expected, 
here are the recommended ways to debug it:

如果插件没有按预期工作，推荐用下面的方式调试：

* Your first stop should be the [analyzer diagnostics pages][]. 
  If your plugin's isolate crashes, the "plugins" screen 
  displays the crash information and stack trace.

  首先应该查看 [分析器诊断页面][analyzer diagnostics pages]。
  如果插件的 isolate 崩溃，"plugins" 界面会显示崩溃信息和堆栈跟踪。

* `print` statements won't work. 
  Plugins run in a separate isolate, and their standard output 
  is not connected to your console.

  `print` 语句不会生效。
  插件运行在单独的 isolate 中，它们的标准输出没有连接到你的控制台。

* The most reliable way to trace your plugin's execution 
  and inspect values is to write to a log file from 
  your plugin's code.

  跟踪插件执行并检查值的最可靠办法，
  是在插件代码中写入日志文件。


[analyzer diagnostics pages]: {{site.repo.dart.sdk}}/blob/main/pkg/analysis_server/doc/tutorial/instrumentation.md#open-the-analyzer-diagnostics-pages
