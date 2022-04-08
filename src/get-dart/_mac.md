[Install Homebrew,](https://brew.sh)
and then run the following commands:

[安装 Homebrew](https://brew.sh)
后运行以下命令：

```terminal
$ brew tap dart-lang/dart
$ brew install dart
```

{{site.alert.important}}

  Make sure the **Homebrew `bin` directory is in your `PATH`**. 
  Setting up the path correctly makes it easier to use Dart SDK commands
  such as `dart run` and `dart format`. 
  For help configuring your path, 
  consult the [Homebrew FAQ.](https://docs.brew.sh/FAQ)

  请确认 **Homebrew 的 `bin` 目录已包含在 `PATH` 中**。
  正确设置路径有助于 `dart run` 和 `dart format`
  这样的 Dart SDK 命令正常运行。
  若你需要设置 PATH 的帮助，请阅读
  [Homebrew 常见问题](https://docs.brew.sh/FAQ)。

{{site.alert.end}}

To upgrade when a new release of Dart is available:

想要更新到 Dart SDK 可用的更新版本，执行以下命令：

```terminal
$ brew upgrade dart
```

To switch between locally installed Dart releases, 
first install the version you want to switch to if you haven't.
For example, to install Dart 2.12:

想要切换本地 Dart SDK 的版本，
在你没有安装之前，需要先行安装对应版本。
例如，以下的命令将安装 Dart 2.12：

```terminal
$ brew install dart@2.12
```

Then to switch between versions, 
unlink the current version and link the desired version.

接着切换版本时，取消当前版本的链接，并链接目标版本。

```terminal
$ brew unlink dart@<old> && brew unlink dart@<new> && brew link dart@<new>
```

To see which versions of Dart you've installed:

运行以下命令查看已经安装的 Dart 版本：

```terminal
$ brew info dart
```
