
### Install using a Linux package manager {:.no_toc}

### 使用 Linux 包管理器安装 {:.no_toc}

You have two options to install the Dart SDK on Ubuntu or Debian:

在 Ubuntu 或 Debian 上安装 Dart SDK 有两种方式：

* Use the [apt-get](#install-using-the-apt-get-package-manager) command.

  使用 [apt-get](#install-using-the-apt-get-package-manager) 命令。

* Download a [`.deb`](#install-as-a-debian-package) package
  and run the `dpkg` command.

  下载 [`.deb`](#install-as-a-debian-package) 包，
  然后运行 `dpkg` 命令。

### Install using the `apt-get` package manager {:.no_toc}

### 使用 `apt-get` 包管理器安装 {:.no_toc}

To install Dart with `apt-get`, perform the following steps.
You need steps 1 to 3 only for the first install.

要用 `apt-get` 安装 Dart，请按下面的步骤操作。
只有第一次安装才需要第 1 到第 3 步。

1. Update the package index files and
   install the secure HTTP and GPG packages.

   更新软件包索引，
   并安装安全 HTTP 和 GPG 软件包。

   ```console
   $ sudo apt-get update && sudo apt-get install apt-transport-https gpg
   ```

1. Download and add the Google Linux GPG public key.

   下载并添加 Google Linux GPG 公钥。

   ```console
   $ wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub \
     | sudo gpg --dearmor -o /usr/share/keyrings/dart.gpg
   ```

1. Add the Dart package repository to your Linux system.

   把 Dart 的软件源添加到 Linux 系统。

   ```console
   $ echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' \
     | sudo tee /etc/apt/sources.list.d/dart_stable.list
   ```

   Substitute `amd64` with `armhf`, `arm64`, or `riscv64` as
   needed for your system.

   按你的系统需要，把 `amd64` 换成 `armhf`、`arm64` 或 `riscv64`。

1. Use the following `sudo apt-get` commands.

   使用下面的 `sudo apt-get` 命令。

   ```console
   $ sudo apt-get update && sudo apt-get install dart
   ```

### Install as a Debian package {:.no_toc}

### 以 Debian 软件包安装 {:.no_toc}

To install the Dart SDK as a Debian package (`*.deb`),
perform the following steps.

要把 Dart SDK 安装为 Debian 软件包（`*.deb`），
请按下面的步骤操作。

1. Download the Dart SDK [Debian package](#){:.debian-link-stable}.

   下载 Dart SDK 的 [Debian 软件包](#){:.debian-link-stable}。

1. Use the `sudo dpkg` command to install the `*.deb` package.

   使用 `sudo dpkg` 命令安装 `*.deb` 软件包。

   ```console
   $ sudo dpkg -i dart_3.4.0-1_amd64.deb
   ```

   Substitute `dart_3.4.0-1_amd64.deb` with the current filename.

   把 `dart_3.4.0-1_amd64.deb` 换成当前的文件名。

## Upgrade the Dart SDK {:.no_toc}

## 升级 Dart SDK {:.no_toc}

Use the same command that you used to install the SDK.

使用与安装 SDK 时相同的命令。

### Upgrade using `apt-get` {:.no_toc}

### 使用 `apt-get` 升级 {:.no_toc}

If you installed the Dart SDK with `apt-get`,
use the following `sudo apt-get` commands.

如果是用 `apt-get` 安装的 Dart SDK，
请使用下面的 `sudo apt-get` 命令。

```console
$ sudo apt-get update && sudo apt-get install dart
```

### Upgrade using `dpkg` {:.no_toc}

### 使用 `dpkg` 升级 {:.no_toc}

If you installed the Dart SDK with `dpkg`,
use the `sudo dpkg` command.

如果是用 `dpkg` 安装的 Dart SDK，
请使用 `sudo dpkg` 命令。

```console
$ sudo dpkg -i dart_3.2.6-1_amd64.deb
```

Substitute `dart_3.4.0-1_amd64.deb` with the new upgrade's filename.

把 `dart_3.4.0-1_amd64.deb` 换成新升级包的文件名。

## Uninstall the Dart SDK {:.no_toc}

## 卸载 Dart SDK {:.no_toc}

### Uninstall using `apt-get` {:.no_toc}

### 使用 `apt-get` 卸载 {:.no_toc}

If you installed the Dart SDK with `apt-get`,
use the `sudo apt-get remove` command.

如果是用 `apt-get` 安装的 Dart SDK，
请使用 `sudo apt-get remove` 命令。

1. Use the `sudo apt-get remove` command.

   使用 `sudo apt-get remove` 命令。

   ```console
   $ sudo apt-get remove -y dart
   ```

1. Remove the Dart configuration files from your home directory.

   从主目录中删除 Dart 的配置文件。

   ```console
   $ rm -rf  ~/.dart*
   ```

### Uninstall using `dpkg` {:.no_toc}

### 使用 `dpkg` 卸载 {:.no_toc}

If you installed the Dart SDK with `dpkg`,
use the `sudo dpkg --purge` command.

如果是用 `dpkg` 安装的 Dart SDK，
请使用 `sudo dpkg --purge` 命令。

1. Use the `sudo dpkg --purge` command.

   使用 `sudo dpkg --purge` 命令。

   ```console
   $ sudo dpkg --purge dart
   ```

   This removes the configuration files at the same time.

   这会同时删除配置文件。

1. Verify the SDK has been removed.

   确认 SDK 已经移除。

   ```console
   $ dpkg -l | grep dart
   ```

[sudo]: https://www.sudo.ws/
