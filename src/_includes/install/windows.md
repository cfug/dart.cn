
### Install using Chocolatey {:.no_toc}

### 使用 Chocolatey 安装 {:.no_toc}

To install the Dart SDK, use [Chocolatey][Chocolatey].
Chocolatey requires [elevated permissions].

要安装 Dart SDK，请使用 [Chocolatey][Chocolatey]。
Chocolatey 需要 [提升的权限][elevated permissions]。

1. Install Chocolatey.

   安装 Chocolatey。

1. Launch [PowerShell][] with elevated permissions.

   以提升的权限启动 [PowerShell][]。

   ```ps
   PS C:\> choco install dart-sdk
   ```

### Change default install path {:.no_toc}

### 更改默认安装路径 {:.no_toc}

By default, Chocolatey installs the SDK at `C:\tools\dart-sdk`.
To change that location, set the [`ChocolateyToolsLocation`][]
environment variable to your desired installation directory.

默认情况下，Chocolatey 会把 SDK 安装到 `C:\tools\dart-sdk`。
要更改这个位置，请把 [`ChocolateyToolsLocation`][]
环境变量设为你想要的安装目录。

### Verify your PATH includes Dart {:.no_toc}

### 确认 PATH 包含 Dart {:.no_toc}

Verify you can run Dart.

确认你可以运行 Dart。

```ps
PS C:\> dart --version
Dart SDK version: 3.2.4 (stable) (Thu Dec 21 19:13:53 2023 +0000) on "win_x64"
```

If your development machine doesn't return a Dart version,
add the SDK location to your PATH:

如果开发机器没有返回 Dart 版本，
请把 SDK 位置加入 PATH：

1. In the Windows search box, type `env`.

   在 Windows 搜索框中输入 `env`。

2. Click **Edit the system environment variables**.

   点击 **编辑系统环境变量**。

3. Click **Environment Variables...**.

   点击 **环境变量...**。

4. In the user variable section, select **Path** and click **Edit...**.

   在用户变量区域选择 **Path**，然后点击 **编辑...**。

5. Click **New**, and enter the path to the `dart-sdk` directory.

   点击 **新建**，输入 `dart-sdk` 目录的路径。

6. In each window that you just opened,
   click **Apply** or **OK** to dismiss it and apply the path change.

   在刚才打开的每个窗口中，
   点击 **应用** 或 **确定** 来关闭窗口并应用路径更改。

### Upgrade using Chocolatey {:.no_toc}

### 使用 Chocolatey 升级 {:.no_toc}

To upgrade the Dart SDK, use the following command.

要升级 Dart SDK，请使用下面的命令。

```ps
PS C:\> choco upgrade dart-sdk
```

### Uninstall using Chocolatey {:.no_toc}

### 使用 Chocolatey 卸载 {:.no_toc}

To uninstall the Dart SDK, perform the following steps.

要卸载 Dart SDK，请按下面的步骤操作。

1. Launch [PowerShell][] with elevated permissions.

   以提升的权限启动 [PowerShell][]。

1. Use the following command.

   使用下面的命令。

   ```ps
   PS C:\> choco uninstall dart-sdk
   ```

1. Remove the Dart configuration files from your home directory.

   从主目录中删除 Dart 的配置文件。

   ```ps
   PS C:\> Remove-Item -Recurse -Force ^
        -Path $env:LOCALAPPDATA\.dartServer,$env:APPDATA\.dart,$env:APPDATA\.dart-tool
   ```

[elevated permissions]: https://www.thewindowsclub.com/elevated-privileges-windows
[PowerShell]: https://www.thewindowsclub.com/how-to-open-an-elevated-powershell-prompt-in-windows-10
[Chocolatey]: https://chocolatey.org
[`ChocolateyToolsLocation`]: https://stackoverflow.com/questions/19752533/how-do-i-set-chocolatey-to-install-applications-onto-another-drive/68314437#68314437
