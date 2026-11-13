---
# title: Troubleshoot analyzer performance
title: 排查分析器性能问题
# description: >-
#   Learn how to diagnose and resolve common
#   Dart analysis server performance issues.
description: 了解如何诊断并解决常见的 Dart 分析服务器性能问题。
ai-translated: true
---

This guide helps you diagnose and resolve common Dart analysis server 
performance issues in your Dart or Flutter IDE.

本指南帮助你诊断并解决 Dart 或 Flutter IDE 中
常见的 Dart 分析服务器性能问题。

## Known performance issues

## 已知的性能问题

Several common issues significantly hurt the performance of 
the Dart analysis server (the analyzer).
Check the following issues to see if they might be impacting 
your development environment.

有几类常见问题会明显拖慢
Dart 分析服务器（分析器）的性能。
请对照下列问题，看它们是否影响了你的开发环境。

### Security software on Windows

### Windows 上的安全软件

On Windows systems, if Windows Defender (or other real-time security software) 
is enabled, it can slow down the file read times enough 
to impact analyzer performance. The analyzer frequently reads files, 
and constant scanning can introduce latency. To mitigate this, 
you can set up exclusions for the directories the analyzer reads from.

在 Windows 上，如果启用了 Windows Defender
（或其他实时安全软件），
文件读取可能慢到影响分析器性能。
分析器会频繁读取文件，持续扫描会带来延迟。
为缓解这一问题，可以把分析器要读取的目录设为排除项。

:::warning
Excluding directories from security scans might diminish the 
protection that your antivirus software provides.
Proceed with caution.

把目录排除在安全扫描之外，可能会削弱杀毒软件提供的保护。
请谨慎操作。
:::

If you choose to set up exclusions, include the following directories:

如果决定设置排除项，请包含下列目录：

* The analysis server's cache directory: `%LOCALAPPDATA%\.dartServer`

  分析服务器的缓存目录：`%LOCALAPPDATA%\.dartServer`

* The directory for packages downloaded by pub: `%LOCALAPPDATA%\Pub\Cache`

  pub 下载的 package 所在目录：`%LOCALAPPDATA%\Pub\Cache`

* Any other directories containing code for your applications.

  其他包含应用代码的目录。

For another way to improve file I/O performance, 
consider setting up a [dev drive][].

另一种改善文件 I/O 性能的办法，
是设置 [dev drive][]。

### Symbolic links

### 符号链接

If your package directory contains symbolic links that point 
to a location inside the same directory, or to a parent directory, 
you might experience performance problems with Dart tooling (like the analyzer).

如果 package 目录中的符号链接指向同一目录内的位置，
或指向父目录，
Dart 工具（例如分析器）可能会出现性能问题。

**Status:** The Dart team is actively working on a fix for this issue.

**状态：** Dart 团队正在积极修复这个问题。

**Workaround:** There are no known workarounds at this time.

**变通办法：** 目前还没有已知的变通办法。

## Report unknown issues

## 报告未知问题

If the known issues don't seem to apply to your situation, 
please open an issue in the [Dart SDK issue tracker][]. 
The more information you provide,
the faster the team can diagnose and fix the problem.

如果已知问题似乎都不符合你的情况，
请在 [Dart SDK issue 跟踪器][Dart SDK issue tracker] 中提交 issue。
你提供的信息越多，团队就能越快诊断并修复问题。

### Include reproduction steps

### 附上复现步骤

In your issue, please provide detailed steps to
reproduce the behavior you're observing.

请在 issue 中提供详细步骤，
以便复现你观察到的行为。

1. If you're working on an open-source project, include instructions 
  for downloading the code.

   如果是开源项目，请附上下载代码的说明。

2. If you can't share your code, create a small, self-contained reproduction case.

   如果不能分享代码，请做一个小而自包含的复现用例。

3. If you can't provide either, please state that in the issue.

   如果两者都无法提供，请在 issue 中说明。

### Provide performance data

### 提供性能数据

If the issue is related to performance, providing performance data 
can be very helpful. You can collect this data using the 
analysis server's diagnostic pages:

如果问题与性能有关，提供性能数据会很有帮助。
可以通过分析服务器的诊断页面收集这些数据：

1. **Open the Analyzer Diagnostics page:**
    * **If you are using VS Code:**
        1. Click **View > Command Palette**.
        2. Type `Dart: Open Analyzer Diagnostics` and select it.
    * **If you are using IntelliJ / Android Studio:**
        1. Open the **Dart Analysis** tool window.
        2. Click the settings icon, and then select **View analyzer diagnostics**.

   **打开分析器诊断页面：**
    * **如果使用 VS Code：**
        1. 点击 **View > Command Palette**。
        2. 输入 `Dart: Open Analyzer Diagnostics` 并选中它。
    * **如果使用 IntelliJ / Android Studio：**
        1. 打开 **Dart Analysis** 工具窗口。
        2. 点击设置图标，然后选择 **View analyzer diagnostics**。

2. **Collect the report:**
    1. In the browser page that opens, click **Collect Report** in the top banner.
    2. Perform the actions that trigger the slow behavior.
    3. Click the **Download report** link.

   **收集报告：**
    1. 在打开的浏览器页面中，点击顶部横幅里的 **Collect Report**。
    2. 执行会触发变慢的操作。
    3. 点击 **Download report** 链接。

3. **Attach the report to your issue.**

   **把报告附到 issue 上。**

:::note
While the report shouldn't contain 
personal or proprietary information, 
review it before submitting it.

报告不应包含个人或专有信息，
提交前仍请检查一遍。
:::

### Capture instrumentation logs

### 捕获插桩日志

In some cases, instrumentation logs can provide additional 
details for diagnosing issues.

有时，插桩日志可以提供更多细节，帮助诊断问题。

To capture these logs:

要捕获这些日志：

* **VS Code:** Follow the instructions for 
  [capturing analyzer instrumentation logs][].

  **VS Code：** 按照
  [捕获分析器插桩日志][capturing analyzer instrumentation logs]
  的说明操作。

* **IntelliJ / Android Studio:** Follow the
  [analyzer instrumentation instructions][].

  **IntelliJ / Android Studio：** 按照
  [分析器插桩说明][analyzer instrumentation instructions] 操作。

Before attaching logs to a GitHub issue, review them carefully
to ensure they do not contain any personal, sensitive, or proprietary
information.

把日志附到 GitHub issue 之前，请仔细检查，
确认其中没有个人、敏感或专有信息。

[dev drive]: https://learn.microsoft.com/windows/dev-drive/
[Dart SDK issue tracker]: {{site.repo.dart.sdk}}/issues
[capturing analyzer instrumentation logs]: https://dartcode.org/docs/logging/#analyzer-instrumentation
[analyzer instrumentation instructions]: {{site.repo.dart.sdk}}/blob/main/pkg/analysis_server/doc/tutorial/instrumentation.md#intellij-idea-and-android-studio
