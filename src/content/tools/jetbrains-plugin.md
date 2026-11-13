---
# title: IntelliJ & Android Studio
title: IntelliJ 与 Android Studio
# description: Use the Dart plugin with a variety of IntelliJ Platform-based IDEs.
description: 在多种基于 IntelliJ 平台的 IDE 中使用 Dart 插件。
ai-translated: true
---

The Dart plugin adds Dart support to IntelliJ Platform-based IDEs.
These IDEs provide features unique to specific development technologies.
Whichever JetBrains IDE you choose for Dart development,
this page has resources to help you get started quickly
and find more information when you need it.

Dart 插件为基于 IntelliJ 平台的 IDE 增加 Dart 支持。
这些 IDE 会提供特定开发技术才有的功能。
无论你选择哪一款 JetBrains IDE 做 Dart 开发，
本页都提供帮助你快速上手、
并在需要时查找更多信息的资源。

## Get started

## 开始使用

If you don't already have the IDE and the Dart SDK, get them.
Then install the Dart plugin and tell it where to find the Dart SDK.

如果还没有 IDE 和 Dart SDK，请先获取它们。
然后安装 Dart 插件，并告诉它 Dart SDK 的位置。


### Download the IDE

### 下载 IDE

Install a JetBrains IDE if you don't already have one. Choose one:

如果还没有 JetBrains IDE，请安装一个。任选其一：

* [Android Studio][AS-Install]{:target="_blank" rel="noopener"}

  [下载 Android Studio][AS-Install]

* [IntelliJ IDEA Ultimate][IDEA-Install]{:target="_blank" rel="noopener"}

  [下载 IntelliJ IDEA Ultimate][IDEA-Install]

* [GoLand][GoLand-Install]{:target="_blank" rel="noopener"}

  [下载 GoLand][GoLand-Install]

* [WebStorm][WS-Install]{:target="_blank" rel="noopener"}

  [下载 WebStorm][WS-Install]

[AS-Install]: {{site.android-dev}}/studio/install
[IDEA-Install]: https://www.jetbrains.com/idea/download/
[GoLand-Install]: https://www.jetbrains.com/help/go/getting-started.html
[WS-Install]: https://www.jetbrains.com/webstorm/download/


### Download the Dart SDK

### 下载 Dart SDK

If you don't already have the Dart SDK,
install it.
You can get it either by itself or by downloading the Flutter SDK,
which includes the full Dart SDK.

如果还没有 Dart SDK，请安装它。
可以单独获取，也可以下载包含完整 Dart SDK 的 Flutter SDK。

Choose one:

任选其一：

* [Download the Dart SDK](/get-dart)

  [下载 Dart SDK](/get-dart)

* [Download the Flutter SDK]({{site.flutter-docs}}/get-started/install)

  [下载 Flutter SDK]({{site.flutter-docs}}/get-started/install)


### Install the Dart plugin

### 安装 Dart 插件

To configure Dart support, start by installing the plugin:

要配置 Dart 支持，请先安装插件：

1. Start the IDE.

   启动 IDE。

2. From the Welcome screen, choose **Plugins**.

   在欢迎屏幕中选择 **Plugins**。

3. Search for **Dart**.

   搜索 **Dart**。

4. Install the plugin and restart the IDE.

   安装插件并重启 IDE。


### Create a new Dart project

### 创建新的 Dart 项目

To create a new project:

要创建新项目：

1. From the Welcome screen, click **New Project**.

   在欢迎屏幕中点击 **New Project**。

2. In the next dialog, click **Dart**.

   在下一个对话框中点击 **Dart**。

3. If you don't see a value for the **Dart SDK** path,
   enter or select it.

   如果看不到 **Dart SDK** 路径的值，请输入或选择它。

   For example, the SDK path might be
   `<dart installation directory>/dart/dart-sdk`.

   例如，SDK 路径可能是
   `<dart installation directory>/dart/dart-sdk`。

   :::note
   The **Dart SDK** path is the directory containing
   the `bin` and `lib` directories.
   The `bin` directory contains tools such as `dart` and `dartaotruntime`.
   The IDE validates that the selected path is correct.

   **Dart SDK** 路径是包含 `bin` 和 `lib` 目录的目录。
   `bin` 目录包含 `dart` 和 `dartaotruntime` 等工具。
   IDE 会验证所选路径是否正确。
   :::

4. Choose a starting template.
   1. To enable starting templates, click **Generate sample content**.
   2. Pick your desired template.

   选择一个起始模板。
   1. 要启用起始模板，请点击 **Generate sample content**。
   2. 挑选你想要的模板。

5. Click **Next** and continue project setup.

   点击 **Next**，继续完成项目设置。


### Open an existing Dart project

### 打开已有的 Dart 项目

To work on an existing Dart application, open the project in the IDE and enable Dart support.

要开发已有的 Dart 应用，请在 IDE 中打开项目并启用 Dart 支持。

#### Open the project

#### 打开项目

1. From the Welcome screen, click **Open** or **Import**.
   Alternatively, select **File | Open** from the main menu.

   在欢迎屏幕中点击 **Open** 或 **Import**。
   也可以从主菜单选择 **File | Open**。

2. Select the folder containing your Dart project.

   选择包含 Dart 项目的文件夹。

#### Enable Dart support

#### 启用 Dart 支持

1. Open **Settings** (<kbd>Cmd</kbd> + <kbd>,</kbd>) and
   choose **Dart** under **Languages and Frameworks**.
   This will open the Dart page.

   打开 **Settings**（<kbd>Cmd</kbd> + <kbd>,</kbd>），
   在 **Languages and Frameworks** 下选择 **Dart**。
   这会打开 Dart 页面。

2. Check **Enable Dart support for the project &lt;project name&gt;**.

   勾选 **Enable Dart support for the project &lt;project name&gt;**。

3. Verify the **Dart SDK Path**.
   The IDE usually detects this automatically.
   If not, manually select the directory containing the Dart SDK.

   确认 **Dart SDK Path**。
   IDE 通常会自动检测到它。
   如果没有，请手动选择包含 Dart SDK 的目录。

4. Under **Enable Dart support for the following modules**,
   select the modules that require Dart functionality.

   在 **Enable Dart support for the following modules** 下，
   选择需要 Dart 功能的模块。


### Work with multiple Dart projects (packages)

### 在同一项目中处理多个 Dart 项目（package）

To work with multiple Dart projects (packages) in a single IntelliJ IDEA project,
add the additional project's root folder as a content root or as a new module.

要在同一个 IntelliJ IDEA 项目中处理多个 Dart 项目（package），
请把额外项目的根文件夹添加为内容根或新模块。

1. Go to the [Modules page](https://www.jetbrains.com/help/idea/modules-page.html)
    (**File | Project Structure | Modules**) and add a content root as described in
    [Adding a content root](https://www.jetbrains.com/help/idea/content-roots.html#adding_content_root).

   打开 [模块页面](https://www.jetbrains.com/help/idea/modules-page.html)
   （**File | Project Structure | Modules**），并按
   [添加内容根](https://www.jetbrains.com/help/idea/content-roots.html#adding_content_root)
   中的说明添加内容根。

2.  Select **File | New | Module from Existing Sources**
    and select the relevant module in the dialog that opens.

    选择 **File | New | Module from Existing Sources**，
    并在打开的对话框中选择相应模块。

### Configure syntax highlighting

### 配置语法高亮

You can customize Dart syntax highlighting to match your preferences.

可以根据自己的偏好自定义 Dart 语法高亮。

1. Open **Settings** (<kbd>Cmd</kbd> + <kbd>,</kbd>) and
   go to **Editor | Color Scheme | Dart**.

   打开 **Settings**（<kbd>Cmd</kbd> + <kbd>,</kbd>），
   进入 **Editor | Color Scheme | Dart**。

2. Select a color scheme, or customize the default settings as described in
   [Colors and fonts](https://www.jetbrains.com/help/idea/configuring-colors-and-fonts.html).

   选择一套配色方案，或按
   [颜色和字体](https://www.jetbrains.com/help/idea/configuring-colors-and-fonts.html)
   中的说明自定义默认设置。

## Report issues

## 报告问题

Please report issues and feedback via the
[IntelliJ issue tracker][]. Include details of the 
expected behavior, the actual behavior, and screenshots if appropriate.

请通过 [IntelliJ issue 跟踪器][IntelliJ issue tracker]
报告问题和反馈。请写上预期行为、实际行为，
并在合适时附上截图。

[IntelliJ issue tracker]: https://github.com/flutter/flutter-intellij/issues

## More information

## 更多信息

See the JetBrains website for more information.

更多信息请参阅 JetBrains 网站。

* [IntelliJ IDEA](https://www.jetbrains.com/idea/)

  [IntelliJ IDEA](https://www.jetbrains.com/idea/)

  * [Dart WebStorm Help](https://www.jetbrains.com/help/webstorm/dart.html)

    [Dart WebStorm 帮助](https://www.jetbrains.com/help/webstorm/dart.html)

  * [Features](https://www.jetbrains.com/idea/features/)

    [功能](https://www.jetbrains.com/idea/features/)

  * [Quick start](https://www.jetbrains.com/help/idea/getting-started.html)

    [快速入门](https://www.jetbrains.com/help/idea/getting-started.html)

* [Flutter Plugin for IntelliJ](https://github.com/flutter/flutter-intellij)

  [适用于 IntelliJ 的 Flutter 插件](https://github.com/flutter/flutter-intellij)
