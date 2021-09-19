If you're using Debian/Ubuntu on AMD64 (64-bit Intel), you can choose one of the
following options, both of which can update the SDK automatically when new
versions are released.

如果您使用 64 位的 Debian/Ubuntu 系统，请选择下面任意一种方式安装，
在新版本发布之后，它们都可以自动更新。

* [使用 apt-get 方式安装](#install-using-apt-get)
* [使用 Debian 安装包](#install-a-debian-package)

#### Install using apt-get

#### 使用 apt-get 方式安装

Perform the following **one-time setup**:

请使用如下的方式（只需设置一次）：

```terminal
$ sudo apt-get update
$ sudo apt-get install apt-transport-https
$ sudo sh -c 'wget -qO- https://dl.google.com/linux/linux_signing_key.pub | apt-key add -'
$ sudo sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
```

Developers from China: please considering replace to
the mirror site that you trusted.

中国的开发者，请将上面最后一行命令行的
storage.googleapis.com 替换为 storage.flutter-io.cn，如下：

```terminal
$ sudo sh -c 'wget -qO- https://storage.flutter-io.cn/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
```

Note: we didn't fully tested this mirror, it could be unstable,
if you have any questions, please file an issue to us.

我们尚未完整测试和保证这个镜像的稳定性，
不过有任何问题，您都可以点击文档右上方进行反馈。

Then install the Dart SDK:

然后安装 Dart SDK:

```terminal
$ sudo apt-get update
$ sudo apt-get install dart
```

#### Install a Debian package

#### 使用 Debian 安装包

Alternatively, download Dart SDK [as a Debian package](#){:.debian-link-stable}
in the `.deb` package format. 

通过 [`.deb` 软件包](#){:.debian-link-stable} 下载 Dart SDK。

#### Modify PATH for access to all Dart binaries

#### 在 PATH 环境变量里加入所有 Dart 二进制文件的访问

After installing the SDK, **add its `bin` directory to your `PATH`**. For example,
use the following command to change `PATH` in your active terminal session:

安装 SDK 之后需要把 SDK 的 `bin` 目录加入你环境变量的 `PATH` 中去。
比如，通过下面的命令可以在现有命令行窗口中加入 `PATH` 环境变量：

```terminal
$ export PATH="$PATH:/usr/lib/dart/bin"
```

To change the PATH for future terminal sessions, use a command like this:

为未来的命令行窗口执行永久的 `PATH` 环境变量设定，
可以使用下面的命令：

```terminal
$ echo 'export PATH="$PATH:/usr/lib/dart/bin"' >> ~/.profile
```
