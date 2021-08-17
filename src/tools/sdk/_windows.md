You can install the Dart SDK using [Chocolatey.][Chocolatey]

{{site.alert.important}}

  These commands require administrator rights.
  Here's one way to open a Command Prompt window
  that has admin rights:

  这些命令需要以管理员身份运行。
  以下是一种以管理员身份运行命令行的方式：

  1. Press <kbd>Windows+R</kbd> to open the **Run** window.

     按下 <kbd>Windows+R</kbd> 打开 **运行** 窗口。

  2. Type `cmd` into the box.

     在输入框中输入 `cmd`。

  3. Press <kbd>Ctrl+Shift+Enter</kbd>.

     按下 <kbd>Ctrl+Shift+Enter</kbd>。

{{site.alert.end}}

To install the Dart SDK:

安装 Dart SDK：

```terminal
C:\> choco install dart-sdk
```

To upgrade the Dart SDK:

升级 Dart SDK：

```terminal
C:\> choco upgrade dart-sdk
```

By default, the SDK is installed at `C:\tools\dart-sdk`.
You can change that location by setting
the [`ChocolateyToolsLocation`][] environment variable
to your chosen installation directory.

SDK 默认会安装在 `C:\tools\dart-sdk`。
你可以更改 [`ChocolateyToolsLocation`][] 环境变量来选择安装目录。

If you can't use the Dart SDK executables,
add the SDK location to your PATH:

如果安装后你无法使用 Dart SDK 的可执行文件，
请将 SDK 的路径添加到 PATH：

1. In the Windows search box, type `env`.

   打开 Windows 搜索，输入 `env`。

2. Click **Edit the system environment variables**.

   点击 **编辑系统环境变量**。

3. Click **Environment Variables...**.

   点击 **环境变量(N)...**。

4. In the user variable section, select **Path** and click **Edit...**.

   在用户变量部分，选择 **Path** 并点击 **编辑(E)...**。

5. Click **New**, and enter the path to the `dart-sdk` directory.

   点击 **新建(N)**，输入 `dart-sdk` 的路径。

6. In each window that you just opened,
   click **Apply** or **OK** to dismiss it and apply the path change.

   在每个打开的窗口点击 **应用(A)** 或 **确定**，关闭弹窗并应用路径修改。

[Chocolatey]: https://chocolatey.org
[`ChocolateyToolsLocation`]: https://stackoverflow.com/questions/19752533/how-do-i-set-chocolatey-to-install-applications-onto-another-drive/68314437#68314437
