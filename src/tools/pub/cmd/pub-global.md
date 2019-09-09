---
title: pub global
title: pub global
description: Use pub global to run Dart scripts hosted on the Pub site from the command line.
description: 使用 pub global 命令从命令行运行 Pub 网站上托管的 Dart 脚本。
---

_Global_ is one of the commands of the [pub tool](/tools/pub/cmd).

_Global_ 命令是 [Pub 工具](/tools/pub/cmd) 中的一个命令。

Pub's `global` option allows you to run Dart scripts from the
command line when you are not currently inside a package.
After [activating a package](#activating-a-package), you can
[run scripts](#running-a-script) from that package's `bin` directory.
[Deactivating a package](#deactivating-a-package) removes it from
your list of globally available packages.

Pub 的 `global` 选项允许你在任意位置下从命令行运行 Dart 脚本。在 [激活 Package](#activating-a-package) 后，你可以 [运行](#running-a-script) 该 Package `bin` 目录下的脚本。[停用 Package](#deactivating-a-package) 后你可以从全局可用的 Package 列表中将其移除。

For example, say you want to run
[Stagehand]({{site.pub}}/packages/stagehand)
the Dart project generator, from the command line.

例如，假设你想要从命令行运行 Dart 项目生成的 [Stagehand]({{site.pub}}/packages/stagehand)。

```terminal
$ pub global activate stagehand
$ stagehand
```

If this doesn't work, you might need to
[set up your path](#running-a-script-from-your-path).

如果该操作无效，你可能需要 [设置你的路径](#running-a-script-from-your-path)。

To run a Dart script from within a package, or from a
package that your package depends on, see [pub run](/tools/pub/cmd/pub-run).

如果想要从 Package 中运行 Dart 脚本，或者从 Package 所依赖的其它 Package 中运行脚本，请查阅 [pub run](/tools/pub/cmd/pub-run) 命令。

## Activating a package

## Package 激活

```nocode
pub global activate [--noexecutables] [--executable=<name>] [--overwrite] <package> [constraint]
```

Activate a package when you want to be able to run
one or more of its executable files from the command line.
You can activate packages that live on the
[Pub site]({{site.pub}}), a Git repository,
or your local machine.
Once you've activated a package, see [Running a
script](#running-a-script) to run scripts from the package's
`bin` directory.

当你想从命令行运行某个 Package 中的可执行对象时你需要先激活它。该 Package 可以是在 [Pub 网站]({{site.pub}})、Git 仓库或者你当前设备上。一旦你激活了 Package，就可以参阅 [Running a script](#running-a-script) 运行位于 Package `bin` 目录下的脚本。

When you activate a package you can specify an optional version
constraint.  See the [constraint](#options) flag for usage examples.

你可以在激活 Package 时指定一个可选的版本限制参数。关于其使用示例请查阅 [版本限制参数](#options)。

### Activating a package on the Pub site

### 激活 Pub 网站上的 Package

```terminal
$ pub global activate <pub.dartlang package>
```

Specify a package on the Pub site to activate it. For example:

激活 Pub 网站上的一个 Package。例如：

```terminal
$ pub global activate markdown
```

### Activating a package with Git

### 激活 Git 仓库中的 Package

```terminal
$ pub global activate --source git <Git URL>
$ pub global activate -sgit <Git URL>
```

Use `--source git` (or `-sgit`, for short) to activate
a package in a Git repository. The following examples,
which activate the `async_await` package on
[GitHub](https://github.com/), are equivalent:

使用 `--source git`（或 `-sgit` 简写）命令参数可以激活位于 Git 仓库中的 Package。下面的两个示例都可以用于激活位于 [GitHub](https://github.com/) 网站上名为 `async_await` 的 Package。

```terminal
$ pub global activate --source git https://github.com/dart-lang/async_await.git
$ pub global activate -sgit https://github.com/dart-lang/async_await.git
```

### Activating a package on your local machine

### 激活当前设备上的 Package

```terminal
$ pub global activate --source path <path>
```

Use `activate --source path <path>` to activate a package on your local machine.
The following example activates the `stopwatch` package from the
`~/dart` directory:

使用 `activate --source path <path>` 命令参数激活当前设备上的 Package。下面的示例激活了位于 `~/dart` 目录下名为 `stopwatch` 的 Package。

```terminal
$ pub global activate --source path ~/dart/stopwatch
```

### Updating an activated package

### 更新已经激活的 Package

Once a package has been activated, you can upgrade it by activating the
package again.

你可以再次激活一个已经激活的 Package 以更新它。

## Running a script

## 运行脚本

You can directly run a script from an activated package from the
command line. If you are unable to run the script directly,
you can also use `pub global run`.

### Running a script from your PATH

### 运行指定路径中的脚本

To run a script directly from the command line, add the `bin` file
for the [system cache](/tools/pub/glossary#system-cache) to your path.

For example, say you've activated the Stagehand script,
but you still can't run the command:

```terminal
$ pub global activate stagehand
$ stagehand
-bash: stagehand: command not found
```

Verify that the `bin` directory for the system cache is in your path.
The following path, on macOS, includes the system cache.

{% prettify none %}
$ echo $PATH
[!/Users/<user>/.pub-cache/bin!]:/Users/<user>/homebrew/bin:/usr/local/bin:/usr/bin:/bin
{% endprettify %}

If this directory is missing from your path,
locate the file for your platform and add it.

|-------------------+---------------------------|
|      Platform     |      Cache location       |
|-------------------|---------------------------|
| macOS or Linux | `$HOME/.pub-cache/bin`        |
| Windows<sup><strong>*</strong></sup> | `%APPDATA%\Pub\Cache\bin` |
{:.table .table-striped}

<sup><strong>*</strong></sup> The exact location of the system cache
may vary for different versions of Windows.

You can now directly invoke the command:

{% prettify none %}
$ mkdir angular_project
$ cd angular_project
$ [!stagehand web-angular!]
{% endprettify %}

If the script still fails to run from the command line, the
package may not be [configured](#configuring-package-executables) for
this feature. You can still run the script using `pub global run`.

### Running a script using `pub global run`

### 使用 `pub global run` 命令运行脚本

```nocode
$ pub global run <package>:<executable> [args...]
```

Even if a script is not configured to be run from the command line,
you can still use `pub global run`.
The following command runs the `bin/bar.dart` script from the
`foo` package, passing in two arguments.

```terminal
$ pub global run foo:bar arg1 arg2
```

### Configuring package executables

### 配置 Package 为可运行的

If you are not a package developer, you can skip this section.

A package can expose some of its scripts as executables
that can be run directly from the command line. The script or scripts
must be listed in the
[`executables`](/tools/pub/pubspec#executables)
entry of the pubspec file.  For example, the following pubspec file
identifies `bin/helloworld.dart` as an executable for the helloworld
package:

{% prettify yaml %}
name: helloworld

executables:
  helloworld:
{% endprettify %}

Failing to list a script under the `executables` tag reduces the script's
usability: unlisted scripts can be executed using `pub global run`, but not
directly from the command line.

## Deactivating a package

## 停用 Pacakge

```terminal
$ pub global deactivate <package>
```

Use `deactivate` to remove a package from the list of available
global packages. For example:

```terminal
$ pub global deactivate markdown
```

You can no longer invoke the package's scripts using `pub global run`,
or at the command line.

## Listing active packages

## 列出激活的 Package

```terminal
$ pub global list
```

Use `list` to list all currently active packages.

使用 `list` 列出当前所有已激活的 Package。

## Options

## 选项

For options that apply to all pub commands, see
[Global options](/tools/pub/cmd#global-options).

你可以查阅 [全局选项](/tools/pub/cmd#global-options) 获取 Pub 命令所支持的命令选项。

`<constraint>`
: Optional for `pub global activate`. The constraint allows you to pull
  in a specific version of the package. For example,
  the following command pulls the 0.6.0 version of the `markdown`
  package:

`<版本限制参数>`：`pub global activate` 命令的可选选项。使用版本限制参数可以允许你拉取 Package 的指定版本。例如，下述命令会拉取 `markdown` 这个 Package 的 0.6.0 版本：

  ```terminal
  $ pub global activate markdown 0.6.0
  ```

  If you specify a range, pub picks the best version that meets that
  constraint. For example:

如果你指定的是一个范围，Pub 则会在这个范围内选取一个最适合的版本。例如：

  ```terminal
  $ pub global activate foo <3.0.0
  ```

`--executable=<name>` or `-x<name>`
: Optional for `pub global activate`.
  Adds the specified executable to your PATH.
  You can pass more than one of these flags.
  For example, the following command adds `bar` and `baz` (but not
  any other executables that `foo` might define) to your PATH.

  ```terminal
  $ pub global activate foo -x bar -x baz
  ```

`--executable=<name>` 或 `-x<name>`：`pub global activate` 命令的可选选项。将指定的可执行对象添加至你的 PATH 路径中。你可以在一次命令执行中多次使用该选项以添加多个可执行对象到你的 PATH 路径中。例如，下述命令添加了 foo 中的 `bar` 和 `baz` 两个可执行对象（不包括 foo 中定义的其它可执行对象）到你的 PATH 中。

`--no-executables`
: Optional for `pub global activate`.
  Globally activates the package but doesn't put any
  executables in `bin`. You have to use `pub global run` to
  run any executables.

`--no-executables`：`pub global activate` 命令的可选选项。会在全局范围内激活 Package 但不会在 `bin` 目录下生成任何文件。你必须使用 `pub global run` 来运行任意这些可执行的对象。

`--overwrite`
: Optional for `pub global activate`.
  Normally, if executables from two global packages have a name
  collision, the preexisting executable wins. If you specify this flag,
  the new executable overwrites the previously activated executable.

`--overwrite`：`pub global activate` 命令的可选选项。默认情况下，如果执行的两个全局 Package 名字冲突了，那么会优先执行最先执行过的那个。但是如果你指定该标识，那么新执行的 Package 则会覆盖之前执行的那些。

<aside class="alert alert-info" markdown="1">
  *Problems?* See [Troubleshooting pub](/tools/pub/troubleshoot).

  **有疑问？** 请查阅 [Pub 疑难协助](/tools/pub/troubleshoot)。
</aside>
