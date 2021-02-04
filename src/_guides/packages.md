---
title: How to use packages
title: 如何使用 package
short-title: Packages
description: Learn more about pub, Dart's tool for managing packages.
description: 关于 pub 命令的更多介绍，这是 Dart 里用于管理 package 的工具。
---

The Dart ecosystem uses _packages_ to manage shared software
such as libraries and tools.
To get Dart packages, you use the **pub package manager**.
You can find publicly available packages on the
[**pub.dev site**,]({{site.pub}})
or you can load packages from the local file system or elsewhere,
such as Git repositories.
Wherever your packages come from, pub manages version dependencies,
helping you get package versions that work with each other and
with your SDK version.

Dart 生态系统使用 _包_ 来管理**共享软件**，比如：库和工具。
我们使用 **Pub 包管理工具** 来获取 Dart 包。
在 [**Pub**]({{site.pub}}) 上，可以找到公开可用的包。
或者从本地文件系统或其他的位置，比如 Git 仓库，加载可用的包。
无论包是从什么途径加载的， Pub 都会进行版本依赖管理，
从而帮助我们获得版本兼容的软件包以及 SDK 。

Most [Dart-savvy IDEs][] offer support for using pub that
includes creating, downloading, updating, and publishing packages.
Or you can use [`dart pub` on the command line](/tools/pub/cmd).

大多数 [Dart-savvy IDEs][] 都支持 Pub 的使用，包括包的创建，下载，更新和发布。
同样上述功能也可以在命令行上通过 [`dart pub`](/tools/pub/cmd) 来操作。
或者可以在命令行上使用pub。

At a minimum,
a Dart package is a directory containing a [pubspec file](/tools/pub/pubspec).
The pubspec contains some metadata about the package. Additionally,
a package can contain dependencies (listed in the pubspec),
Dart libraries, apps, resources, tests, images, and examples.

Dart 包目录中至少包含一个 [pubspec 文件](/tools/pub/pubspec)。
pubspec 文件记录一些关于包的元数据。
此外，包还包含其他依赖项（在 pubspec 中列出），
Dart 库，应用，资源，测试，图片，以及示例。

To use a package, do the following:

通过以下步骤，引用使用包：

* Create a pubspec (a file named `pubspec.yaml` that lists package dependencies and includes
  other metadata, such as a version number).

  创建一个 pubspec （一个名为 `pubspec.yaml` 文件，
  文件列出依赖的包以及包含的其他元数据，比如当前包的版本）。

* Use pub to get your package's dependencies.

  使用 Pub 获取当前所依赖的包。

* If your Dart code depends on a library in the package, import the library.

  如果当前 Dart 代码依赖包中的某个库，导入（import）该库。

## Creating a pubspec

## 创建 pubspec

The pubspec is a file named <code class="literal">pubspec.yaml</code>
that's in the top directory of your application.
The simplest possible pubspec lists only the package name:

pubspec 是一个名为 <code class="literal">pubspec.yaml</code> 的文件，
文件位于应用的根路径。
最简单的 pubspec 只需要列出包名：

{% comment %} TODO: make 3-backtick-yaml the same as prettify yaml {% endcomment %}
{% prettify yaml tag=pre+code %}
name: my_app
{% endprettify %}

Here is an example of a pubspec that declares dependencies on
two packages (`js` and `intl`) that are hosted on the pub.dev site:

下面是一个 pubspec 的示例，示例中声明依赖了在 Pub 站点上托管的两个包（ `js` 和 `intl` ）：

{% prettify yaml tag=pre+code %}
name: my_app
dependencies:
  js: ^0.6.0
  intl: ^0.15.8
{% endprettify %}

For details on creating a pubspec,
see the [pubspec documentation](/tools/pub/pubspec)
and the documentation for the packages that you want to use.

有关创建 pubspec 的详细内容，请参阅 [pubspec 文档](/tools/pub/pubspec)
以及使用包的相关文档。

## Getting packages

## 获取包

Once you have a pubspec, you can run <code class="literal">pub
get</code> from the top directory of your application:

项目中一旦拥有了 pubspec 文件，就可以在项目根目录中执行
<code class="literal">pub get</code> 命令：

```terminal
$ cd <path-to-my_app>
$ dart pub get
```

This process is called _getting the dependencies_.

上面的操作即 **获取依赖**。

The [`dart pub get`][] command determines which packages your app depends on,
and puts them in a central [system cache](/tools/pub/glossary#system-cache).
If your app depends on a published package, pub downloads that package from the
[pub.dev site.]({{site.pub}})
For a [Git dependency](/tools/pub/dependencies#git-packages),
pub clones the Git repository.
Transitive dependencies are included, too.
For example, if the `js` package depends on the `test` package, `pub`
grabs both the `js` package and the `test` package.

[`dart pub get`][] 命令确定当前应用所依赖的包，
并将它们保存到中央[系统缓存](/tools/pub/glossary#system-cache)（central system cache）中。
如果当前应用依赖了一个公开包， Pub 会从 [Pub 站点]({{site.pub}}) 该包。
对于一个 [Git 依赖](/tools/pub/dependencies#git-packages)， Pub 会 Clone 该 Git 仓库。
同样包括包的相关依赖也会被下载。
例如，如果 `js` 包依赖 `test` 包， `pub` 会同时获取 `js` 包和 `test` 包。

Pub creates a
`.packages` file (under your app’s top directory)
that maps each package name
that your app depends on to the corresponding package in the system cache.

Pub 会创建一个`.packages` 文件（位于应用程序的根路目录下），
该文件将应用程序所依赖的每个包名相应的映射到系统缓存中的包。

{% comment %}
PENDING: Here only to make it easy to find the packages discussion:
packages-dir.html
{% endcomment %}

## Importing libraries from packages

## 从包中导入库

To import libraries found in packages, use the
<code class="literal">package:</code> prefix:

使用 <code class="literal">package:</code> 前缀，导入包中的库：

```dart
import 'package:js/js.dart' as js;
import 'package:intl/intl.dart';
```

The Dart runtime takes everything after `package:`
and looks it up within the `.packages` file for
your app.

Dart 运行时会抓取 `package:` 之后的内容，
并在应用程序的 `.packages` 文件中查找它。

You can also use this style to import libraries from within your own package.
Consider the following pubspec file, which declares a dependency on
the (fictional) `transmogrify` package:

也可以使用此方式从自己的包中导入库。
思考下面的 pubspec 文件，该文件声明了对 `transmogrify` 包（虚构的包名）的依赖：

{% prettify yaml tag=pre+code %}
name: my_app
dependencies:
  transmogrify:
{% endprettify %}

Let's say that the `transmogrify` package is laid out as follows:

假如 `transmogrify` 这个 package 的布局如下：

{% prettify none tag=pre+code %}
transmogrify/
  lib/
    transmogrify.dart
    parser.dart
  test/
    parser/
      parser_test.dart
{% endprettify %}

The `parser_test.dart` file can import `parser.dart` like this:

`parser_test.dart` 就可以通过下面的方式导入 `parser.dart`：

{% prettify dart tag=pre+code %}
import 'package:transmogrify/parser.dart';
{% endprettify %}


## Upgrading a dependency

## 升级依赖

The first time you get a new dependency for your package,
pub downloads the latest version of it that's compatible with
your other dependencies.
It then locks your package to *always* use that version by
creating a **lockfile**.
This is a file named `pubspec.lock` that pub creates and stores next to your
pubspec. It lists the specific versions of each dependency (immediate and
transitive) that your package uses.

第一次获取依赖时，Pub 会下载依赖及其兼容的最新版本。
然后通过创建 **lockfile** 锁定依赖，以始终使用这个版本。
Pub 会在 pubspec 旁创建并存储一个名为 `pubspec.lock` 文件。
它列出了使用的每个依赖包的指定版本（当前包或传递包的版本）。

If your package is an application package,
you should check this file into
[source control](/guides/libraries/private-files).
That way, everyone working on your app uses the same versions
of all of the packages.
Checking in the lockfile also ensures that your deployed app
uses the same versions of code.

如果包是一个应用程序包，那么应该将此文件加入到 [源文件管理](/guides/libraries/private-files)。
这样，在应用上开发的每个人都能够使用所有相同版本的包。
同样加入到 lockfile 可以保证部署的应用使用的是同一版本的代码。

When you're ready to upgrade your dependencies to the latest versions,
use the [`dart pub upgrade`][] command:

如果已经准备更新依赖到最新版本，使用命令 `dart pub upgrade` ：

{% prettify sh tag=pre+code %}
$ dart pub upgrade
{% endprettify %}

The `dart pub upgrade` command tells pub to regenerate the lockfile, using the newest
available versions of your package's dependencies.
If you want to upgrade only one dependency,
you can specify the package to upgrade:

`dart pub upgrade` 命令用于重新生成 lockfile 文件，并使用最新可用版本的依赖包。
如果仅升级某个依赖，可以在命令中指定需要升级的包：

{% prettify sh tag=pre+code %}
$ dart pub upgrade transmogrify
{% endprettify %}

That command upgrades `transmogrify` to the latest version
but leaves everything else the same.

上面的命令升级 `transmogrify` 到最新版本，但维持其它包不变。

The [`dart pub upgrade`][] command can't always upgrade every package
to its latest version,
due to conflicting version constraints in the pubspec.
To identify out-of-date packages that require editing the pubspec,
use [`dart pub outdated`][].

[`dart pub upgrade`][] 命令并非总是可以将所有的 package 更新到最新版本，
原因是 pubspec 文件中的一些 package 之间有版本限制的冲突。
想要确定 pubspec 里已经过时且需要编辑的 package，
请使用 [`dart pub outdated`][] 命令。

## More information

## 更多内容

The following pages have more information about packages and
the pub package manager.

以下链接的页面是关于包及 Pub 包管理的更多内容。


### How to

### 如何使用

* [Creating packages](/guides/libraries/create-library-packages)

  [创建包](/guides/libraries/create-library-packages)

* [Publishing packages](/tools/pub/publishing)

  [发布包](/tools/pub/publishing)

### Reference

### 参考

* [Pub dependencies](/tools/pub/dependencies)
   
  [Pub 依赖](/tools/pub/dependencies)

* [Pub environment variables](/tools/pub/environment-variables)

  [Pub 环境变量](/tools/pub/environment-variables)

* [Pub glossary](/tools/pub/glossary)

  [Pub 术语](/tools/pub/glossary)

* [Pub package layout conventions](/tools/pub/package-layout)

  [Pub 包的布局约定](/tools/pub/package-layout)

* [Pub versioning philosophy](/tools/pub/versioning)
  
  [Pub 版本哲学](/tools/pub/versioning)

* [Pubspec format](/tools/pub/pubspec)

  [Pubspec 格式](/tools/pub/pubspec)

### Pub commands

### Pub 命令

The `pub` tool provides the following commands:

`pub` 工具提供了如下的命令：

* [`pub cache`][]
* [`pub deps`][]
* [`pub downgrade`][]
* [`pub get`][]
* [`pub global`][]
* [`pub outdated`][]
* [`pub publish`][]
* [`pub run`][]
* [`pub upgrade`][]
* [`pub uploader`][]

For an overview of all the `pub` commands,
see the [pub tool documentation](/tools/pub/cmd).

有关所有 `pub` 命令的概述，
参见 [pub 工具文档](/tools/pub/cmd)。

### Troubleshooting

### 故障排除

[Troubleshooting pub](/tools/pub/troubleshoot) gives solutions to problems that
you might encounter when using pub.

[Pub 故障排除](/tools/pub/troubleshoot) 提供使用中可能遇到问题的解决方法。

[Dart-savvy IDEs]: /tools#ides-and-editors
[`pub cache`]: /tools/pub/cmd/pub-cache
[`pub deps`]: /tools/pub/cmd/pub-deps
[`pub downgrade`]: /tools/pub/cmd/pub-downgrade
[`pub get`]: /tools/pub/cmd/pub-get
[`pub global`]: /tools/pub/cmd/pub-global
[`pub outdated`]: /tools/pub/cmd/pub-outdated
[`pub publish`]: /tools/pub/cmd/pub-lish
[`pub run`]: /tools/pub/cmd/pub-run
[`pub upgrade`]: /tools/pub/cmd/pub-upgrade
[`pub uploader`]: /tools/pub/cmd/pub-uploader
