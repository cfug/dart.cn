
### Install using Homebrew {:.no_toc}

### 使用 Homebrew 安装 {:.no_toc}

To install the Dart SDK, use [Homebrew][].

要安装 Dart SDK，请使用 [Homebrew][]。

1. Install Homebrew if needed.

   如有需要，先安装 Homebrew。

1. Add and trust the [official tap][tap].

   添加并信任 [官方 tap][tap]。

   ```console
   $ brew tap dart-lang/dart
   $ brew trust dart-lang/dart
   ```

1. Install the Dart SDK.

   安装 Dart SDK。

   ```console
   $ brew install dart
   ```

### Verify PATH includes Homebrew {:.no_toc}

### 确认 PATH 包含 Homebrew {:.no_toc}

Verify that your `PATH` includes the **Homebrew `bin` directory**.
Setting up the correct path simplifies using Dart SDK commands
such as `dart run` and `dart format`.

确认你的 `PATH` 包含 **Homebrew 的 `bin` 目录**。
把路径设置正确，使用 `dart run` 和 `dart format`
等 Dart SDK 命令会更方便。

To get help configuring your `PATH`, consult the [Homebrew FAQ][].

配置 `PATH` 需要帮助时，请查阅 [Homebrew 常见问题][Homebrew FAQ]。

### Upgrade using Homebrew {:.no_toc}

### 使用 Homebrew 升级 {:.no_toc}

To upgrade when a new release of Dart is available:

当 Dart 有新版本时，这样升级：

```console
$ brew upgrade dart
```

### Switch Dart versions {:.no_toc}

### 切换 Dart 版本 {:.no_toc}

To switch between locally installed Dart releases:

要在本地已安装的 Dart 版本之间切换：

1. Install the version to which you want to switch.

   安装你想切换到的版本。

   For example, to install Dart 3.1:

   例如，安装 Dart 3.1：

   ```console
   $ brew install dart@3.1
   ```

1. To switch between versions,
   unlink the current version and link the desired version.

   要在版本之间切换，
   先取消链接当前版本，再链接想要的版本。

   ```console
   $ brew unlink dart@<old> \
     && brew unlink dart@<new> \
     && brew link dart@<new>
   ```

### List installed Dart versions {:.no_toc}

### 列出已安装的 Dart 版本 {:.no_toc}

To see which versions of Dart you've installed:

查看你安装了哪些 Dart 版本：

```console
$ brew info dart
```

### Uninstall using Homebrew {:.no_toc}

### 使用 Homebrew 卸载 {:.no_toc}

To uninstall the Dart SDK, use [Homebrew][].

要卸载 Dart SDK，请使用 [Homebrew][]。

1. Uninstall the Dart SDK.

   卸载 Dart SDK。

   ```console
   $ brew uninstall dart
   ```

1. Remove the Dart configuration files from your home directory.

   从主目录中删除 Dart 的配置文件。

   ```dart
   rm -rf  ~/.dart*
   ```

[Homebrew]: https://brew.sh
[tap]: {{site.repo.dart.org}}/homebrew-dart
[Homebrew FAQ]: https://docs.brew.sh/FAQ#my-mac-apps-dont-find-homebrew-utilities
