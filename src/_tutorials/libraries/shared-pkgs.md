---
title: Install shared packages
title: 使用共享的 package
description: Packages are bundles of source code, tools, and resources that help you to organize and share code.
description: Package 是用于在 Dart 语言里打包代码、工具和资源的东西，可以帮助你更好的组织和分享代码。
---

### Borrow and share code.

### 借用和分享代码。

<div class="mini-toc" markdown="1">
  <h4>What's the point?</h4>

  <h4>本文的重点是什么？</h4>

  * The [pub.dev site]({{site.pub}}) is the primary public repository for Dart
    packages.

    [Pub.dev 网站]({{site.pub}})是 Dart 包主要的公共仓库。

  * Following a few conventions, such as having a valid pubspec.yaml file,
    makes your app a package.

    遵循一些规定，比如一个有效的 pubspec.yaml 文件，使你的应用成为一个包。

  * If you're developing a web or server-side app,
    use Stagehand to generate starting files.

    如果你正在开发一款 Web 或服务端应用，请使用 Stagehand 工具生成相关初始化文件。

  * If you're developing a web or server-side app,
    use `pub get` to download packages.

    如果你正在开发一款 Web 或服务端应用，请使用 `pub get` 命令下载相关包。

  * If you're developing a mobile app, use Flutter's tools.

    如果你正在开发一款移动应用，请使用 Flutter 工具。
</div>

Once you can create and run a Dart app,
you're ready to leverage code written by other programmers.
Many interesting and useful packages of reusable Dart code
are available at the [pub.dev site]({{site.pub}}) repository.

当你可以创建和运行 Dart 应用时，你就已经准备复用其他程序员编写的代码了。[pub.dev 网站]({{site.pub}}) 仓库有许多可用的使用 Dart 代码编写的包。

This tutorial shows how to use `pub`&mdash;a package manager
that comes with Dart&mdash;to
install one of the packages in the repository,
the vector_math package.
You can follow these same steps to install any package hosted at
the [pub.dev site]({{site.pub}});
just change the package name when you get to that step.
This tutorial also describes some of the resources you can expect to find
in a well-built package.

本教程将向你展示如何使用 `pub` 命令&mdash;Dart 的包管理命令&mdash;即用以安装仓库中某个包
（比如 vector_math 包）的命令。
你可以使用这些步骤来安装由 [pub.dev 网站]({{site.pub}}) 提供的任意一个包；
当你想安装其它你想要使用的包时只需修改这些步骤中的示例包名即可。
本教程同时也会向你展示一些你可能会使用到的优秀的包。

<aside class="alert alert-info" markdown="1">
  **Flutter note:**

  **使用 Flutter 的请注意：**

  This page doesn't describe the tools you use with Flutter, but the
  concepts are the same, and you can share packages between
  your Flutter and web or server-side apps.
  For more information, see the
  [Flutter package documentation.]({{site.flutter}}/docs/development/packages-and-plugins/using-packages)

  本文不会向你展示那些只针对 Flutter 的包，但是 Flutter 使用到的 Dart 包会被介绍，你也可以将你的包分享为可以在 Flutter、Web 或服务端应用上使用。更多相关信息，请查阅 [Flutter 包文档。]({{site.flutter}}/docs/development/packages-and-plugins/using-packages)
</aside>


## About the pubspec.yaml file

## 关于 pubspec.yaml 文件

To use an external package,
your app must itself be a package.
Any app with a valid pubspec.yaml file in its top-level directory
is a package and can therefore use external packages.

想要使用外部的包，你的应用其本身也必须是一个包。任何在顶层目录中包含有效 pubspec.yaml 文件的应用都是一个包，从而可以使该应用使用外部的包。

You can use the Stagehand tool to generate packages
with valid pubspec.yaml files and directory structures.
Stagehand works either at the command line or (behind the scenes) in an IDE
such as IntelliJ or WebStorm.

你可以使用 Stagehand 工具来生成带有有效 pubspec.yaml 文件和目录结构的包。你可以使用命令行工具来调用 Stagehand 工具，也可以使用类似 IntelliJ 或 WebStorm 这样的 IDE 来间接使用 Stagehand 工具。

Install or update Stagehand using
[pub global activate](/tools/pub/cmd/pub-global):

你可以使用 [pub global activate](/tools/pub/cmd/pub-global) 命令安装或更新 Stagehand 工具：

```terminal
$ pub global activate stagehand
```

Now run the `stagehand` command to see what kinds of template files
it can generate:

现在你可以运行 `stagehand` 命令来查看它可以生成的模板文件：

```terminal
$ stagehand
```

You'll see a list of generators, including various web and server-side apps.
One of the generators is named **console-full**.

你将会看到一系列的生成器，包括各种 Web 和 服务端应用的。其中一个生成器叫**console-full**。

In a new directory named `vector_victor`,
use Stagehand to generate a command-line app:

在一个新建的名为 `vector_victor` 的目录中，使用 Stagehand 工具来生成一个命令行应用：

```terminal
$ mkdir vector_victor
$ cd vector_victor
$ stagehand console-full
```

The pubspec.yaml file contains the package specification written in YAML.
(Visit <a href="/tools/pub/pubspec">Pubspec Format</a>
for in-depth coverage.)
The contents of your pubspec.yaml file should look something like this:

pubspec.yaml 文件包含了由 YAML 语言撰写的包规格。（访问 <a href="/tools/pub/pubspec">Pubspec 格式 </a> 获取更多深入的介绍。）而你的 pubspec.yaml 文件看起来则应该是这样的：

```yaml
name: vector_victor
description: A sample command-line application.

environment:
  sdk: '>=2.1.0 <3.0.0'

#dependencies:
#  path: ^1.4.1

dev_dependencies:
  test: ^1.0.0
```

## Name the package dependencies

## 依赖包的命名

To use an external library package,
you need to add the package to your
app's list of dependencies
in the pubspec.yaml file.
Each item in the dependencies list
specifies the name and version
of a package that your app uses.

为了能够使用外部包，你需要将其添加到你应用 pubspec.yaml 文件的依赖里。依赖中的每一项都指定了你应用所使用的包名以及包版本。

Let's make the vector_victor app have a dependency
on the vector_math package,
which is available at the [pub.dev site]({{site.pub}}).

下面让我们为 vector_victor 应用添加一个名为 vector_math 的包，该包可以在 [pub.dev 网站]({{site.pub}}) 中找到。

 1. Get the current installation details for the package:

    获取包当前的安装细节信息：

    {: type="a"}
     1. Go to [vector_math's entry on the Package
        site.]({{site.pub}}/packages/vector_math)

        打开 [pub.dev 网站中 vector_math 包的网页。]({{site.pub}}/packages/vector_math)

     2. Click the **Installing** tab.

        点击**Installing**标签。

     3. Copy the **vector_math** line from the sample **dependencies** entry.
        The entry should look something like this:

        拷贝示例 _dependencies_ 实体中有 _vector_math_ 的那一行。 _dependencies_ 实体看起来像下面那样：

        ```yaml
        dependencies:
          vector_math: ^2.0.7
        ```

 2. Edit `pubspec.yaml`.

    编辑 `pubspec.yaml` 文件。

 3. In the dependencies section, add the string you copied from the
    pub.dev site. Be careful to keep the indentation the same; YAML is
    picky! For example:

    在 dependencies 部分，将上面你从 pub.dev 网站拷贝来的文本粘贴添加至这里。这里要注意缩进；必须严格按照 YAML 语言规范！例如：

    ```yaml
    environment:
      sdk: '>=2.1.0 <3.0.0'

    dependencies:
      vector_math: ^2.0.7

    dev_dependencies:
      test: ^1.0.0
    ```

For details of what version numbers mean
and how you can format them,
see [Pub versioning philosophy](/tools/pub/versioning).

你可以查阅 [Pub 版本管理](/tools/pub/versioning) 获取更多有关版本号含义以及格式化的相关信息。

The [pub.dev site]({{site.pub}})
is the primary public repository for Dart packages.
`pub` automatically checks that
website when resolving package dependencies.
To use one of the packages from that site,
you can specify it by its simple name,
as we have done here.

[pub.dev 网站]({{site.pub}}) 是 Dart 包主要的公共仓库。`pub` 命令在解析包依赖时会自动去该网站进行检查。如果你想使用该网站的某个包，你可以像我们上面所说的那样在 dependencies 中指定对应的包名。

## Install the package dependencies

## 安装依赖包

If you're using an IDE or Dart-savvy editor to edit `pubspec.yaml`,
it might automatically install the packages your app depends on.

如果你使用 IDE 或适配了 Dart 语言开发的编辑器去编辑 `pubspec.yaml` 文件，其可能会在你编辑了该文件后自动下载安装相关的依赖包。

If not, do it yourself by running
[pub get](/tools/pub/cmd/pub-get):

否则，你只能手动地执行 [pub get](/tools/pub/cmd/pub-get) 命令进行下载安装：

```terminal
$ pub get
Resolving dependencies...
+ vector_math 2.0.7
Changed 1 dependency!
Precompiling executables...
Precompiled vector_math:mesh_generator.
```

The `pub get` command installs the
packages in your app's dependencies list.
Each package can contain libraries and other assets.
Pub works recursively;
if an included package has dependencies, those packages are installed as well.
Pub caches the files for each package your app depends on,
pointing to them from a file named `.packages`.

`pub get` 命令会安装你应用依赖列表中的包。而每一个包可能还会包含其它的库或资源，Pub 同样会将它们依次安装；如果一个依赖包已经安装过，则会直接使用。Pub 会缓存你应用依赖过的每一个包并将其缓存至一个名为 `.packages` 的文件中。

{% comment %}
PENDING: Here only to make it easy to find the packages discussion: packages-dir.html
{% endcomment %}

Pub creates a file called `pubspec.lock`
that identifies the specific versions of the packages that were installed.
This helps to provide a stable development environment.
Later you can modify the version constraints and use `pub upgrade`
to update to new versions as needed.

Pub 会创建一个名为 `pubspec.lock` 的文件来标识哪些包的哪些版本已经安装过。此举可以为开发者提供一个稳定的开发环境。你也可以修改包版本并使用 `pub upgrade` 命令来更新包。

## What did you get (and not get)?

## 你可以从中获取（或不可获取）什么？

Besides the Dart libraries,
the vector_math package has other resources that might be useful to you
that do not get installed into your app directory.
Let's take a step back for a moment to look at what
you got and where it came from.

除了 Dart 库以外，vector_math 包可能包含其它对你有用但不会安装到你应用目录的资源。让我们后退一步看看你在依赖包时得到了什么以及从何而来。

To see the contents of the vector_math package,
visit the
<a href="https://github.com/johnmccutchan/vector_math"
target="_blank" rel="noopener">Dart vector math repository</a>
at GitHub.
Although many files and directories are in the repository,
only one, `lib`, was installed when you ran pub get.

访问 <a href="https://github.com/johnmccutchan/vector_math" target="_blank">Dart 数学矢量仓库 </a> 的 Github 仓库查看 vector_math 包的具体内容。尽管该仓库中有大量的文件和目录，但是只有 `lib` 目录下的文件会在你执行 pub get 命令时安装。

<div>
  <hr>
  <div class="row">
    <div class="col-lg-3">
    <img class="scale-img-max" src="/tutorials/images/libraries-folder.png"
         alt="Dart libraries directory"/>
    </div>
    <div class="col-lg-7">
      <em>Dart libraries:</em>
      <em>Dart 库：</em>
      The lib directory contains one or more Dart libraries,
      which can be imported into your Dart programs.

      lib 目录包含一个或多个可以安装到你 Dart 程序的 Dart 库。
    </div>
  </div>
  <hr>
  <div class="row">
    <div class="col-lg-3">
    <img class="scale-img-max" src="/tutorials/images/housekeeping-files.png"
         alt="Housekeeping files"/>
    </div>
    <div class="col-lg-7">
      <em>Housekeeping files:</em>
      <em>管理文件：</em>
      When using a package written by someone else,
      the <code>README.md</code> file is a good place to start.
      It should contain important information about the package,
      such as its intent, contents, samples, and instructions.
      The <code>LICENSE</code> file provides
      copyright and rules-of-use information.
      All of these files are in the package repository;
      the contents of some,
      such as <code>README.md</code>,
      are also displayed in pub.dev.
      These files aren't installed when you install a package.

      当使用别人开发的包时，README 文件是了解该包最好的地方。它会包含与包相关的重要信息，比如开发包时的想法、包的相关内容、示例以及使用说明。
      LICENSE 文件则包含了版权信息以及使用规则信息。所有文件均在包仓库中，且在你安装包时它们不会被下载。而 <code>README.md</code> 中的内容同样也会展示在 pub.dev。
    </div>
  </div>
  <hr>
  <div class="row">
    <div class="col-lg-3">
    <img class="scale-img-max" src="/tutorials/images/other-folders.png"
         alt="Document, scripts, tests, and other resources"/>
    </div>
    <div class="col-lg-7">
      <em>Other resources:</em>
      <em>其它资源：</em>
      Along with Dart libraries,
      a package might also contain other resources
      such as example code, tests, scripts, and documentation.
      If a package contains these resources,
      they should be in the directories as specified in the pub

      包可能会包含库以外的其它资源，比如示例代码、测试、脚本以及文档。如果包中包含诸如此类的信息，它们会存放在 Pub 指定的目录中。
<a href="/tools/pub/package-layout">conventions</a>.
    </div>
  </div>
  <hr>
</div>

## Import libraries from a package

## 从包中导入库

Now that you've installed the package,
you can import its libraries and use them in your app.

现在你已经安装了包，你可以在你的应用中导入和使用包中的库。

As with the SDK libraries,
use the **import** directive to use code from an installed library.
The Dart SDK libraries are built in and
are identified with the special `dart:` prefix.
For external libraries installed by pub,
use the `package:` prefix.

与 SDK 库一样，使用_ import_ 关键字导入使用安装了的库中的代码。Dart SDK 库是内置的且由特殊的 `dart:` 前缀标识。如果你使用由 pub 命令安装的外部库，请使用 `package:` 前缀。

1. Get the import details for the package's main library:

   获取包中主要库的导入流程：

   {: type="a"}
   1. Go to [vector_math's entry on the Package
      site.]({{site.pub}}/packages/vector_math)

      打开 [pub.dev 网站中 vector_math 包的网页。]({{site.pub}}/packages/vector_math)

   2. Click the **Installing** tab.

      点击**Installing**标签。

   3. Copy the **import** line. It should look something like this:

      拷贝有**import**的这一行代码。其看起来像下面这样：

      ```dart
      import 'package:vector_math/vector_math.dart';
      ```

2. In your vector_victor app, edit `lib/vector_victor.dart`,
   so that it imports the vector_math library and uses some of its API.
   For inspiration, look at the
   [vector_math API
   docs]({{site.pub}}/documentation/vector_math/latest),
   which you can find from the pub.dev site entry.

   在你的 vector_victor 应用中，编辑 `lib/vector_victor.dart` 文件，由此它导入 vector_math 库并使用了它的一些 API。你可以阅读 [vector_math API 文档]({{site.pub}}/documentation/vector_math/latest) 获取更多相关信息。

   <aside class="alert alert-info" markdown="1">
     **Note:** You specify a filename, not a library name,
     when you import a library from a package.

     **注意：**当你从包中导入一个库时你指定的是文件名而不是库名。
   </aside>


## Other resources

## 其它资源

* Dart developers share packages at the [pub.dev site]({{site.pub}}).
  Look there for packages that might be useful to you,
  or share your own Dart packages.

  Dart 开发者们在 [pub.dev site]({{site.pub}}) 分享它们开发的包。你可以在那里查找你想要使用的包或者分享你自己开发的包。

* See the [pub package documentation](/guides/packages)
  for more information on using and sharing packages.

  你也可以查阅 [pub 包文档](/guides/packages) 获取更多有关如何使用和分享包的信息。
