---
# title: Experiment flags
title: 实验性的参数标记
# description: Using experiment flags with Dart tools.
description: 在 Dart 工具里使用一些实验性的参数。
ai-translated: true
---

The Dart SDK often contains experimental features,
which you can try by passing flags to Dart tools.

Dart SDK 经常包含实验性功能，
可以把参数传给 Dart 工具来试用。

:::warning
Don't use experiments for production code.
Experiments might have breaking changes or be removed
without notice.

不要在生产代码中使用实验性功能。
实验性功能可能发生破坏性变更，或在不另行通知的情况下被移除。
:::


## Using experiment flags with command-line tools

## 在命令行工具中使用实验性参数

To use an experiment with Dart SDK [command line tools](/tools/sdk),
pass the corresponding flag to the tool.

要在 Dart SDK [命令行工具](/tools/sdk) 中使用某项实验，
请把对应的参数传给该工具。

For example, to enable the experiments
`super-mixins` and `no-slow-checks`,
add those flags to the `dart` command:

例如，要启用实验 `super-mixins` 和 `no-slow-checks`，
把这些参数加到 `dart` 命令上：

```console
$ dart run --enable-experiment=super-mixins,no-slow-checks bin/main.dart
```

Or to the `flutter` command:

或者加到 `flutter` 命令上：

```console
$ flutter run --enable-experiment=super-mixins,no-slow-checks
```

## Using experiment flags with the Dart analyzer (command-line and IDE)

## 在 Dart 分析器中使用实验性参数（命令行和 IDE）

To enable experiments affecting analysis,
use the `enable-experiment` key in the [analysis options file][].
Here's an example of enabling the experiments
`super-mixins` and `no-slow-checks` in `analysis_options.yaml`:

要启用影响分析的实验，
请在 [分析选项文件][analysis options file] 中使用 `enable-experiment` 键。
下面的例子在 `analysis_options.yaml` 中启用
`super-mixins` 和 `no-slow-checks`：

```yaml title="analysis_options.yaml"
analyzer:
  enable-experiment:
    - super-mixins
    - no-slow-checks
```

[analysis options file]: /tools/analysis#the-analysis-options-file


## Using experiment flags with IDEs

## 在 IDE 中使用实验性参数

To enable experiments related to running or debugging apps in IDEs,
edit the launch configuration.

要启用与在 IDE 中运行或调试应用相关的实验，
请编辑启动配置。

### Visual Studio Code

### Visual Studio Code 配置

In `launch.json` under `configurations`,
add a new `toolArgs` key containing the desired flags.
Example:

在 `launch.json` 的 `configurations` 下，
新增一个 `toolArgs` 键，填入所需参数。
例如：

```json title="launch.json"
 "configurations": [
        {
            "name": "Dart",
            "program": "bin/main.dart",
            "request": "launch",
            "type": "dart",
            "toolArgs": [
                "--enable-experiment=super-mixins,no-slow-checks",
            ],
        }
    ]
```

For more information, consult the documentation for
[VS Code launch configurations.][VSC instructions]

更多信息请查阅
[VS Code 启动配置][VSC instructions] 的文档。

[VSC instructions]: https://code.visualstudio.com/docs/editor/debugging#_launch-configurations


### Android Studio

### Android Studio 配置

Under `VMOptions` add the desired flags.
Example:

在 `VMOptions` 下添加所需参数。
例如：

```xml
<component name="ProjectRunConfigurationManager">
  <configuration default="false" name="Run main" type="DartCommandLineRunConfigurationType" factoryName="Dart Command Line Application">
    <option name="VMOptions" value="--enable-experiment=non-nullable" />
    <option name="filePath" value="$PROJECT_DIR$/bin/main.dart" />
    <method v="2" />
  </configuration>
</component>
```

For more information, consult the instructions for
[Android Studio run/debug configurations.][AS instructions]

更多信息请查阅
[Android Studio 运行 / 调试配置][AS instructions] 的说明。

[AS instructions]: {{site.android-dev}}/studio/run/rundebugconfig


## More information

## 更多信息

* For a complete list of experiments,
  see the Dart SDK file [`experimental_features.yaml`.][]

  完整的实验列表见 Dart SDK 文件
  [`experimental_features.yaml`][`experimental_features.yaml`.]。

* For information on procedures and expectations for experiment flags,
  see the documentation of the
  [process for changes that are behind experimental flags.][flags]

  关于实验性参数的流程和预期，
  请参阅
  [实验性参数背后的变更流程][flags] 文档。

[`experimental_features.yaml`.]: {{site.repo.dart.sdk}}/blob/main/tools/experimental_features.yaml
[flags]: {{site.repo.dart.sdk}}/blob/main/docs/process/experimental-flags.md
