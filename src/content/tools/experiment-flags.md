---
# title: Experiment flags
title: 实验性的参数标记
# description: Using experiment flags with Dart tools.
description: 在 Dart 工具里使用一些实验性的参数。
---

The Dart SDK often contains experimental features,
which you can try by passing flags to Dart tools.

:::warning
Don't use experiments for production code.
Experiments might have breaking changes or be removed
without notice.
:::


## Using experiment flags with command-line tools

To use an experiment with Dart SDK [command line tools](/tools/sdk),
pass the corresponding flag to the tool.

For example, to enable the experiments
`super-mixins` and `no-slow-checks`,
add those flags to the `dart` command:

```console
$ dart run --enable-experiment=super-mixins,no-slow-checks bin/main.dart
```

Or to the `flutter` command:

```console
$ flutter run --enable-experiment=super-mixins,no-slow-checks
```

## Using experiment flags with the Dart analyzer (command-line and IDE)

To enable experiments affecting analysis,
use the `enable-experiment` key in the [analysis options file][].
Here's an example of enabling the experiments
`super-mixins` and `no-slow-checks` in `analysis_options.yaml`:

```yaml title="analysis_options.yaml"
analyzer:
  enable-experiment:
    - super-mixins
    - no-slow-checks
```

[analysis options file]: /tools/analysis#the-analysis-options-file


## Using experiment flags with IDEs

To enable experiments related to running or debugging apps in IDEs,
edit the launch configuration.

### Visual Studio Code

In `launch.json` under `configurations`,
add a new `toolArgs` key containing the desired flags.
Example:

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

[VSC instructions]: https://code.visualstudio.com/docs/editor/debugging#_launch-configurations


### Android Studio

Under `VMOptions` add the desired flags.
Example:

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

[AS instructions]: {{site.android-dev}}/studio/run/rundebugconfig


## More information

* For a complete list of experiments,
  see the Dart SDK file [`experimental_features.yaml`.][]
* For information on procedures and expectations for experiment flags,
  see the documentation of the
  [process for changes that are behind experimental flags.][flags]

[`experimental_features.yaml`.]: {{site.repo.dart.sdk}}/blob/main/tools/experimental_features.yaml
[flags]: {{site.repo.dart.sdk}}/blob/main/docs/process/experimental-flags.md

