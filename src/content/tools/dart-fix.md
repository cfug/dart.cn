---
# title: dart fix
title: dart fix 命令
# description: >-
#   Command-line tool for applying analysis fixes and migrating API usages.
description: 用于应用分析修复并迁移 API 用法的命令行工具。
ai-translated: true
---

The `dart fix` command
finds and fixes two types of issues:

`dart fix` 命令会查找并修复两类问题：

* Analysis issues identified by [`dart analyze`][]
  that have associated automated fixes
  (sometimes called _quick-fixes_ or _code actions_).

  由 [`dart analyze`][] 找出、并且带有自动修复的分析问题
  （有时称为 **快速修复** 或 **代码操作**）。

* Outdated API usages when updating to
  newer releases of the Dart and Flutter SDKs.

  升级到更新的 Dart 和 Flutter SDK 时，过时的 API 用法。

:::tip
To learn about `dart fix` in a video format,
check out this [deep dive][] on **Decoding Flutter**:

想通过视频了解 `dart fix`，
可以观看 **Decoding Flutter** 上的这段 [深入讲解][deep dive]：

<YouTubeEmbed id="OBIuSrg_Quo" title="Using Dart analyze & Dart fix"></YouTubeEmbed>
:::

[deep dive]: {{site.yt.watch}}/OBIuSrg_Quo

<a id="usage"></a>
## Apply fixes

## 应用修复

To preview proposed changes, use the `--dry-run` flag:

要预览建议的更改，请使用 `--dry-run` 参数：

```console
$ dart fix --dry-run
```

To apply the proposed changes, use the `--apply` flag:

要应用建议的更改，请使用 `--apply` 参数：

```console
$ dart fix --apply
```

<a id="customization"></a>
## Customize behavior {:#customize}

## 自定义行为

The `dart fix` command only applies fixes
when there is a "problem" identified by a diagnostic.
Some diagnostics, such as compilation errors, are implicitly enabled,
while others, such as lints, must be explicitly enabled
in the [analysis options file](/tools/analysis),
as individual preferences for these vary.

只有当诊断指出存在「问题」时，
`dart fix` 命令才会应用修复。
有些诊断（例如编译错误）是默认启用的，
另一些（例如 lint）则必须在
[分析选项文件](/tools/analysis) 中显式启用，
因为大家对这些规则的偏好各不相同。

You can sometimes increase the number of fixes that can be applied
by enabling additional lints.
Note that not all diagnostics have associated fixes.

有时，启用更多 lint 可以增加能够应用的修复数量。
请注意，并非所有诊断都有对应的修复。

### Example

### 示例

Imagine you have code like this:

假设有这样的代码：

```dart
class Vector2d {
  final double x, y;
  Vector2d(this.x, this.y);
}

class Vector3d extends Vector2d {
  final double z;
  Vector3d(final double x, final double y, this.z) : super(x, y);
}
```

Dart 2.17 introduced a new language feature called super initializers,
which allows you to write the constructor of `Vector3d`
with a more compact style:

Dart 2.17 引入了名为 super initializer（超类初始化器）的语言特性，
让你可以用更紧凑的写法编写 `Vector3d` 的构造函数：

```dart
class Vector3d extends Vector2d {
  final double z;
  Vector3d(super.x, super.y, this.z);
}
```

To enable `dart fix` to upgrade existing code to use this feature,
and to ensure that the analyzer warns you when you later forget to use it,
configure your `analysis_options.yaml` file as follows:

要让 `dart fix` 把现有代码升级为使用该特性，
并在以后忘记使用时让分析器发出警告，
请按如下方式配置 `analysis_options.yaml`：

```yaml
linter:
  rules:
    - use_super_parameters
```

We also need to make sure the code enables the required [language version][].
Super initializers were introduced in Dart 2.17,
so update `pubspec.yaml` to have at least that
in the lower SDK constraint:

还需要确保代码启用了所需的 [语言版本][language version]。
super initializer 在 Dart 2.17 中引入，
因此请更新 `pubspec.yaml`，
使 SDK 约束的下限至少为该版本：

```yaml
environment:
  sdk: ">=2.17.0 <4.0.0"
```

You should then see the following when viewing the proposed changes:

查看建议的更改时，应该会看到如下输出：

```console
$ dart fix --dry-run
Computing fixes in myapp (dry run)... 9.0s

1 proposed fixes in 1 files.

lib/myapp.dart
  use_super_parameters • 1 fix
```

To learn more about customizing analysis results and behavior,
see [Customizing static analysis](/tools/analysis).

要进一步了解如何自定义分析结果和行为，
请参阅 [自定义静态分析](/tools/analysis)。

[`dart analyze`]: /tools/dart-analyze
[language version]: /language/versioning

## VS Code support

## VS Code 支持

When you open a project in VS Code,
the Dart plugin scans the project for issues that `dart fix` can repair.
If it finds issues for repair, VS Code displays a prompt to remind you.

在 VS Code 中打开项目时，
Dart 插件会扫描 `dart fix` 可以修复的问题。
如果找到可修复的问题，VS Code 会显示提示提醒你。

<img src="/assets/img/tools/vscode/dart_fix_notification.png" width="550" height="175" alt="VS Code notification about 'dart fix'">

After running `dart pub get` or `dart pub upgrade`,
VS Code might also display this prompt if package changes
add issues that `dart fix` can repair.

运行 `dart pub get` 或 `dart pub upgrade` 之后，
如果 package 变更带来了 `dart fix` 可以修复的问题，
VS Code 也可能显示这条提示。

Save all of your files before running `dart fix`.
This ensures that Dart uses the latest versions of your files.

运行 `dart fix` 之前请保存所有文件。
这样 Dart 才会使用文件的最新版本。
