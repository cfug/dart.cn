---
# title: Dart DevTools
title: Dart DevTools 工具
# shortTitle: DevTools
shortTitle: DevTools 工具
# description: A suite of debugging and performance tools.
description: 一套调试和性能工具。
ai-translated: true
---

Dart DevTools is a suite of debugging and performance tools
for Dart and Flutter.
These tools are distributed as part of the `dart` tool
and interact with tools such as IDEs, `dart run`, and `webdev`.

Dart DevTools 是一套面向 Dart 和 Flutter 的调试与性能工具。
这些工具随 `dart` 工具一起分发，
并与 IDE、`dart run` 和 `webdev` 等工具配合使用。

<img src="/assets/img/tools/devtools.png" width="800" alt="Screenshot of DevTools' Memory page">

The following table shows which tools
you can use with common Dart app types.

下表列出常见 Dart 应用类型可以使用哪些工具。

{% assign y = '<span class="material-symbols user-select-none" title="Supported" aria-label="Supported">done</span>' %}
{% assign b = '&nbsp;' %}
{% assign na = '&nbsp;' %}
{% comment %}
  Considered using this instead:
  assign b = '<span class="material-symbols" title="use browser tools instead">web</span>'
{% endcomment %}

| <t>Tool</t><t>工具</t>                  | <t>[Flutter mobile or desktop][Flutter devtools]</t><t>[Flutter 移动端或桌面端][Flutter devtools]</t> | <t>[Flutter web][Flutter devtools]</t><t>[Flutter Web][Flutter devtools]</t> | <t>[Other web][]</t><t>[其他 Web 应用][Other web]</t> | <t>[Command-line][]</t><t>[命令行][Command-line]</t> |
|-----------------------|:---------------------------------------------:|:-------------------------------:|:-------------:|:----------------:|
| [Debugger][]          |                     {{y}}                     |              {{y}}              |     {{y}}     |      {{y}}       |
| [调试器][Debugger]          |                     {{y}}                     |              {{y}}              |     {{y}}     |      {{y}}       |
| [Logging view]        |                     {{y}}                     |              {{y}}              |     {{y}}     |      {{y}}       |
| [日志视图][Logging view]        |                     {{y}}                     |              {{y}}              |     {{y}}     |      {{y}}       |
| [App size tool][]     |                     {{y}}                     |                                 |               |      {{y}}       |
| [应用体积工具][App size tool]     |                     {{y}}                     |                                 |               |      {{y}}       |
| [CPU profiler][]      |                     {{y}}                     |                                 |               |      {{y}}       |
| [CPU 分析器][CPU profiler]      |                     {{y}}                     |                                 |               |      {{y}}       |
| [Memory view][]       |                     {{y}}                     |                                 |               |      {{y}}       |
| [内存视图][Memory view]       |                     {{y}}                     |                                 |               |      {{y}}       |
| [Network view][]      |                     {{y}}                     |                                 |               |      {{y}}       |
| [网络视图][Network view]      |                     {{y}}                     |                                 |               |      {{y}}       |
| [Performance view][]  |                     {{y}}                     |                                 |               |      {{y}}       |
| [性能视图][Performance view]  |                     {{y}}                     |                                 |               |      {{y}}       |
| [Flutter inspector][] |                     {{y}}                     |              {{y}}              |               |                  |
| [Flutter 检查器][Flutter inspector] |                     {{y}}                     |              {{y}}              |               |                  |

{:.table .table-striped .nowrap}

For information about using Dart DevTools with each app type
(for example, command-line apps),
click the app type in the top row.
For details about individual tools
(for example, the debugger),
click the tool name in the left column.

要了解如何对每种应用类型使用 Dart DevTools
（例如命令行应用），
请点击顶行中的应用类型。
要了解各个工具的详情
（例如调试器），
请点击左列中的工具名称。

As the table shows, the debugger and the logging view
are the only parts of Dart DevTools that are available to all app types.
Web apps can't use the timeline, memory, and performance views;
instead, they can use browser tools such as the [Chrome DevTools.][]
The Flutter inspector works only for Flutter apps;
other web apps should use browser tools such as the Chrome DevTools.

如表所示，调试器和日志视图
是 Dart DevTools 中所有应用类型都能使用的部分。
Web 应用不能使用时间线、内存和性能视图；
可以改用浏览器工具，例如 [Chrome DevTools][Chrome DevTools.]。
Flutter 检查器只适用于 Flutter 应用；
其他 Web 应用应使用 Chrome DevTools 等浏览器工具。

<a id="using-devtools-with-a-command-line-apps" aria-hidden="true"></a>

## Command-line apps

## 命令行应用

You can use DevTools to perform source-level debugging 
or to view general log and diagnostics information
for a running command-line app.

可以用 DevTools 对正在运行的命令行应用
做源码级调试，或查看一般的日志和诊断信息。


### 1. Start the target app

### 1. 启动目标应用

Use the `dart run --observe` command to execute the main file
for the Dart command-line app that you want to debug or observe.
Optionally add `--pause-isolates-on-start`,
which automatically breaks execution at the start of the script.

使用 `dart run --observe` 命令执行要调试或观察的
Dart 命令行应用的主文件。
可以额外加上 `--pause-isolates-on-start`，
它会在脚本一开始就自动中断执行。

```console
$ cd path/to/dart/app
$ dart run --pause-isolates-on-start --observe main.dart

The Dart VM service is listening on http://127.0.0.1:8181/afZySiNbDPg=/
The Dart DevTools debugger and profiler is available at: http://127.0.0.1:8181/afZySiNbDPg=/devtools/#/?uri=ws%3A%2F%2F127.0.0.1%3A8181%2FafZySiNbDPg%3D%2Fws
```

Note the **Dart DevTools debugger and profiler** URL.
You'll need it in the next step.

请记下 **Dart DevTools debugger and profiler** 的 URL。
下一步会用到它。

:::important
This URL contains a security token and
is different for each run of your app.
If you stop your app and rerun it,
then you need to connect to DevTools with the new URL.

这个 URL 含有安全令牌，
并且每次运行应用都会不同。
如果停止应用后重新运行，
就需要用新的 URL 连接 DevTools。
:::

### 2. Open DevTools and connect to the target app

### 2. 打开 DevTools 并连接到目标应用

Copy the **Dart DevTools debugger and profiler** URL,
and paste it into the address bar of a Chrome browser window.

复制 **Dart DevTools debugger and profiler** 的 URL，
粘贴到 Chrome 浏览器窗口的地址栏。

When you visit that URL in Chrome,
the Dart DevTools UI appears,
displaying information about the target app.
Click **Debugger** to start debugging the app.

在 Chrome 中打开该 URL 后，
会出现 Dart DevTools 界面，
并显示目标应用的信息。
点击 **Debugger** 开始调试应用。

<a id="command-line-apps" aria-hidden="true"></a>

## VS Code debug configurations

## VS Code 调试配置

Configure VS Code to launch Dart command-line apps with DevTools enabled to access features like the Timeline view.

配置 VS Code，在启用 DevTools 的情况下启动 Dart 命令行应用，以便使用时间线视图等功能。

### Debug configurations in VS Code

### VS Code 中的调试配置

The following table shows examples of VS Code debug configurations for Dart apps:

下表是 Dart 应用的 VS Code 调试配置示例：

| <t>Configuration</t><t>配置</t> | <t>`vmAdditionalArgs`</t><t>`vmAdditionalArgs` 参数</t> | <t>Description</t><t>说明</t> |
|---------------|---------------------|-------------|
| Default VS Code debug | `[]` | Standard debugging. Includes debugger and logging; excludes timeline data. |
| VS Code 默认调试 | `[]` | 标准调试。包含调试器和日志，不包含时间线数据。 |
| With timeline streams | `["--timeline_streams=VM,Isolate,GC"]` | Enables timeline streams for timeline, memory, and performance profiling. |
| 启用时间线流 | `["--timeline_streams=VM,Isolate,GC"]` | 启用时间线流，用于时间线、内存和性能分析。 |

{:.table .table-striped}

### Example launch.json

### launch.json 示例

To enable timeline events, add this configuration to your `.vscode/launch.json`:

要启用时间线事件，请把下面的配置加到 `.vscode/launch.json`：

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Dart with DevTools Timeline",
      "type": "dart",
      "request": "launch",
      "vmAdditionalArgs": [
        "--timeline_streams=VM,Isolate,GC"
      ],
      "program": "main.dart"
    }
  ]
}
```

Replace `"main.dart"` with the path to your app's main file.

把 `"main.dart"` 换成应用主文件的路径。

### Connect DevTools

### 连接 DevTools

1. Start debugging in VS Code using the configured launch configuration.

   使用配置好的启动配置，在 VS Code 中开始调试。

2. In the VS Code Debug Console or terminal output, look for a line similar to:
   ```
   The Dart DevTools debugger and profiler is available at: http://127.0.0.1:8181/aBcDeFg123=/devtools/#/?uri=...
   ```

   在 VS Code 调试控制台或终端输出中，查找类似上面的一行。

3. Copy the DevTools URL and paste it into a Chrome browser window.

   复制 DevTools URL，粘贴到 Chrome 浏览器窗口。

4. In DevTools, view the timeline, memory, and performance for your running app.

   在 DevTools 中查看正在运行的应用的时间线、内存和性能。

<a id="using-devtools-with-a-flutter-app" aria-hidden="true"></a>

## Flutter apps

## Flutter 应用

For details on using DevTools with a Flutter app for any platform
(including web) see the
[DevTools documentation on flutter.dev.][Flutter devtools]

如何在任意平台（包括 Web）的 Flutter 应用中使用 DevTools，
见 [flutter.dev 上的 DevTools 文档][Flutter devtools]。

<a id="using-devtools-with-a-non-flutter-web-app" aria-hidden="true"></a>

## Other web apps

## 其他 Web 应用

To launch a web app so that you can use Dart DevTools,
use the `webdev serve` command with the `--debug` or `--debug-extension` flag:

要启动 Web 应用以便使用 Dart DevTools，
请使用带 `--debug` 或 `--debug-extension` 参数的 `webdev serve` 命令：

```console
$ webdev serve --debug
```

For more information, see [Debugging Dart web apps][].

更多信息见 [调试 Dart Web 应用][Debugging Dart web apps]。

[App size tool]: {{site.flutter-docs}}/tools/devtools/app-size
[Chrome DevTools.]: https://developer.chrome.com/docs/devtools/
[Command-line]: #command-line-apps
[CPU profiler]: {{site.flutter-docs}}/tools/devtools/cpu-profiler
[Debugger]: {{site.flutter-docs}}/tools/devtools/debugger
[Debugging Dart web apps]: /web/debugging
[Flutter inspector]: {{site.flutter-docs}}/tools/devtools/inspector
[Flutter devtools]: {{site.flutter-docs}}/tools/devtools/overview
[Logging view]: {{site.flutter-docs}}/tools/devtools/logging
[Memory view]: {{site.flutter-docs}}/tools/devtools/memory
[Network view]: {{site.flutter-docs}}/tools/devtools/network
[Other web]: #other-web-apps
[Performance view]: {{site.flutter-docs}}/tools/devtools/performance
[Timeline view]: {{site.flutter-docs}}/tools/devtools/timeline
