---
# title: Package layout conventions
title: Package 的文件结构
# breadcrumb: Package layout
breadcrumb: Package 文件结构
# description: >-
#   Learn more about the directory structure used by
#   Dart's package management tool, pub.
description: 进一步了解 pub 所使用的 package 目录结构。
ai-translated: true
---

When you build a [pub package](/tools/pub/packages),
we encourage you to follow the conventions that this page describes.
They describe how you organize the files and directories within your
package, and how to name things.

构建 [pub package](/tools/pub/packages) 时，
我们鼓励你遵循本页描述的约定。
这些约定说明如何组织 package 中的文件和目录，以及如何命名。

:::flutter-note
Flutter apps can use custom directories for their assets.
For details, see
[Adding assets and images]({{site.flutter-docs}}/development/ui/assets-and-images)
on the [Flutter website.]({{site.flutter-docs}})

Flutter 应用可以为资源使用自定义目录。
详情请参阅 [Flutter 网站]({{site.flutter-docs}}) 上的
[添加资源和图片]({{site.flutter-docs}}/development/ui/assets-and-images)。
:::

Here's what a complete package (named `enchilada`)
that uses every corner of these guidelines
might look like:

一个用尽这些指南各个角落的完整 package（名为 `enchilada`）可能像这样：

<FileTree>

- enchilada/
  - .dart_tool/ *
  - benchmark/
    - make_lunch.dart
  - bin/
    - enchilada
  - doc/
    - api/ ****
    - getting_started.md
  - example/
    - main.dart
  - hook/
    - build.dart
  - integration_test/
    - app_test.dart
  - lib/
    - enchilada.dart
    - tortilla.dart
    - guacamole.css
    - src/
      - beans.dart
      - queso.dart
  - skills/
    - enchilada-cooking/
      - SKILL.md
  - test/
    - enchilada_test.dart
    - tortilla_test.dart
  - tool/
    - generate_docs.dart
  - web/
    - index.html
    - main.dart
    - style.css
  - CHANGELOG.md
  - LICENSE
  - pubspec.yaml
  - pubspec_overrides.yaml **
  - pubspec.lock ***
  - README.md

</FileTree>

\* The `.dart_tool/` directory exists after you've run `dart pub get`.
   Don't check it into source control.
   To learn more, see 
   [Project specific caching for tools](#project-specific-caching-for-tools).

   运行 `dart pub get` 之后会出现 `.dart_tool/` 目录。
   不要把它签入源代码管理。
   要了解更多，请参阅
   [工具的项目级缓存](#project-specific-caching-for-tools)。

\** The [`pubspec_overrides.yaml`][] file,
    if present, overrides certain aspects of `pubspec.yaml`.
    Usually you don't want to check it into source control.

    如果存在 [`pubspec_overrides.yaml`][] 文件，
    它会覆盖 `pubspec.yaml` 的某些方面。
    通常你不会想把它签入源代码管理。

\*** The `pubspec.lock` file exists after you've run `dart pub get`.
    Leave it out of source control unless your package is an
    [application package](/resources/glossary#application-package).

    运行 `dart pub get` 之后会出现 `pubspec.lock` 文件。
    除非你的 package 是 [应用型 package](/resources/glossary#application-package)，
    否则不要把它放进源代码管理。

\**** The `doc/api` directory exists locally after you've run
     [`dart doc`](/tools/dart-doc).
     Don't check the `api` directory into source control.

     运行 [`dart doc`](/tools/dart-doc) 之后，本地会出现 `doc/api` 目录。
     不要把 `api` 目录签入源代码管理。


[`pubspec_overrides.yaml`]: /tools/pub/dependencies#pubspec-overrides

## The pubspec

## pubspec 文件

<FileTree>

- enchilada/
  - pubspec.yaml
  - pubspec.lock

</FileTree>

Every package has a [_pubspec_](/tools/pub/pubspec), a file named
`pubspec.yaml`, in the root directory of the package. That's what *makes* it a
package.

每个 package 的根目录里都有一份 **[pubspec](/tools/pub/pubspec)**，
文件名为 `pubspec.yaml`。正是它 **使** 一个目录成为 package。

Running [`dart pub get`](/tools/pub/cmd/pub-get),
[`dart pub upgrade`](/tools/pub/cmd/pub-upgrade), or
[`dart pub downgrade`](/tools/pub/cmd/pub-downgrade) on the package
creates a **lockfile**, named `pubspec.lock`. 
If your package is an 
[application package](/resources/glossary#application-package), 
check the lockfile into source control. Otherwise, don't.

对 package 运行 [`dart pub get`](/tools/pub/cmd/pub-get)、
[`dart pub upgrade`](/tools/pub/cmd/pub-upgrade) 或
[`dart pub downgrade`](/tools/pub/cmd/pub-downgrade)，
会创建一份名为 `pubspec.lock` 的 **lockfile**。
如果你的 package 是 [应用型 package](/resources/glossary#application-package)，
请把 lockfile 签入源代码管理。否则不要签入。

For more information, see the [pubspec page](/tools/pub/pubspec).

更多信息请参阅 [pubspec 页面](/tools/pub/pubspec)。

## LICENSE

## LICENSE 文件

<FileTree>

- enchilada/
  - LICENSE

</FileTree>

If you're publishing your package, include a license file named `LICENSE`.
We recommend using an [OSI-approved license](https://opensource.org/licenses)
such as [BSD-3-Clause,](https://opensource.org/licenses/BSD-3-Clause)
so that others can reuse your work.

如果要发布 package，请包含一个名为 `LICENSE` 的许可证文件。
我们建议使用 [OSI 批准的许可证](https://opensource.org/licenses)，
例如 [BSD-3-Clause](https://opensource.org/licenses/BSD-3-Clause)，
以便其他人可以复用你的工作。

## README.md

## README.md 文件

<FileTree>

- enchilada/
  - README.md

</FileTree>

One file that's very common in open source is a _README_ file that
describes the project. This is especially important in pub. When you upload
to the [pub.dev site,]({{site.pub}}) your `README.md` file
is shown—rendered as [Markdown][]—on the page for your package. 
This is the perfect place to introduce people to your code.

开源项目里很常见的一个文件是描述项目的 **README** 文件。
这在 pub 中尤其重要。当你上传到 [pub.dev 网站]({{site.pub}}) 时，
你的 `README.md` 文件会在 package 页面上显示——以 [Markdown][] 渲染。
这里是向人们介绍你的代码的理想位置。

For guidance on how to write a great README, see
[Writing package pages](/tools/pub/writing-package-pages).

关于如何写出出色 README 的指导，请参阅
[编写 package 介绍页面](/tools/pub/writing-package-pages)。

<a id="changelogmd" aria-hidden="true"></a>

## CHANGELOG.md {:#changelog}

## CHANGELOG.md 文件

<FileTree>

- enchilada/
  - CHANGELOG.md

</FileTree>

Include a `CHANGELOG.md` file that has a section for
each release of your package,
with notes to help users of your package upgrade.
Users of your package often review the changelog
to discover bug fixes and new features,
or to determine how much effort it will take to upgrade
to the latest version of your package.

请包含一份 `CHANGELOG.md` 文件，为 package 的每次发布设一节，
用说明帮助 package 的用户升级。
你的 package 的用户经常查阅更新日志，
以发现错误修复和新功能，
或者判断升级到最新版本需要多少精力。

To support tools that parse `CHANGELOG.md`,
use the following format:

为了支持解析 `CHANGELOG.md` 的工具，请使用下面的格式：

* Each version has its own section with a heading.

  每个版本有自己的一节，并带有标题。

* The version headings are either all level 1 or all level 2.

  版本标题要么全部是 1 级，要么全部是 2 级。

* The version heading text contains a package version number,
  optionally prefixed with "v".

  版本标题文本包含 package 版本号，可以选择以 “v” 作为前缀。

When you upload your package to the [pub.dev site,]({{site.pub}})
your package's `CHANGELOG.md` file (if any)
appears in the **Changelog** tab, rendered as [Markdown.][Markdown]

当你把 package 上传到 [pub.dev 网站]({{site.pub}}) 时，
package 的 `CHANGELOG.md` 文件（如果有）
会出现在 **Changelog** 标签页中，以 [Markdown][Markdown] 渲染。

Here's an example of a `CHANGELOG.md` file.
As the example shows, you can add subsections.

下面是一份 `CHANGELOG.md` 文件的示例。
如示例所示，你可以添加小节。

```markdown
# 1.0.1

* Fixed missing exclamation mark in `sayHi()` method.

# 1.0.0

* **Breaking change:** Removed deprecated `sayHello()` method.
* Initial stable release.

## Upgrading from 0.1.x

Change all calls to `sayHello()` to instead be to `sayHi()`.

# 0.1.1

* Deprecated the `sayHello()` method; use `sayHi()` instead.

# 0.1.0

* Initial development release.
```


## Public directories

## 公开目录

Two directories in your package are public to other packages: `lib` and
`bin`. You place [public libraries](#public-libraries) in `lib` and
[public tools](#public-tools) in `bin`.

package 中有两个目录对其他 package 公开：`lib` 和 `bin`。
把 [公开库](#public-libraries) 放在 `lib` 中，把 [公开工具](#public-tools) 放在 `bin` 中。

### Public libraries

### 公开库

The following directory structure shows the `lib` portion of enchilada:

下面的目录结构展示了 enchilada 的 `lib` 部分：

<FileTree>

- enchilada/
  - lib/
    - enchilada.dart
    - tortilla.dart

</FileTree>

Many [packages](/resources/glossary#package)
define Dart libraries that other packages can import and use.
These public Dart library files go inside a directory called `lib`.

许多 [package](/resources/glossary#package) 会定义其他 package 可以导入并使用的 Dart 库。
这些公开的 Dart 库文件放在名为 `lib` 的目录中。

Most packages define a single library that users can import. In that case,
its name should usually be the same as the name of the package, like
`enchilada.dart` in the example here. But you can also define other
libraries with whatever names make sense for your package.

大多数 package 只定义一个用户可以导入的库。
在这种情况下，它的名称通常应该和 package 名称相同，
就像这里示例中的 `enchilada.dart`。
你也可以用对 package 有意义的其他名称再定义一些库。

When you do, users can import these libraries using the name of the
package and the library file, like so:

这样做之后，用户可以用 package 名称和库文件来导入这些库，如下所示：

```dart
import 'package:enchilada/enchilada.dart';
import 'package:enchilada/tortilla.dart';
```

If you want to organize your public libraries, you can also create
subdirectories inside `lib`. If you do that, users will specify that path
when they import it. Say you have the following file hierarchy:

如果想组织公开库，你也可以在 `lib` 里创建子目录。
这样做之后，用户导入时会指定那条路径。假设你有下面的文件层次：

<FileTree>

- enchilada/
  - lib/
    - some/
      - path/
        - olives.dart

</FileTree>

Users import `olives.dart` as follows:

用户这样导入 `olives.dart`：

```dart
import 'package:enchilada/some/path/olives.dart';
```

Note that only *libraries* should be in `lib`.
*Entrypoints*—Dart scripts with a `main()` function—cannot
go in `lib`. If you place a Dart script inside `lib`,
you will discover that any `package:` imports it contains don't
resolve. Instead, your entrypoints should go in the appropriate
[entrypoint directory](/resources/glossary#entrypoint-directory).

请注意，`lib` 中应该只有 **库**。
**入口点**——带有 `main()` 函数的 Dart 脚本——不能放在 `lib` 中。
如果你把 Dart 脚本放进 `lib`，会发现其中的任何 `package:` 导入都无法解析。
入口点应该放在合适的 [入口点目录](/resources/glossary#entrypoint-directory) 中。

:::note Tip for web apps
For the best performance when developing web apps,
put [implementation files](#implementation-files) under `/lib/src`,
instead of elsewhere under `/lib`.
Also, avoid imports of <code>package:<em>package_name</em>/src/...</code>.

为了在开发 Web 应用时获得最好的性能，
请把 [实现文件](#implementation-files) 放在 `/lib/src` 下，
而不是 `/lib` 下的其他地方。
同时避免导入 <code>package:<em>package_name</em>/src/...</code>。
:::

For more information on packages, see
[Creating packages](/tools/pub/create-packages).

关于 package 的更多信息，请参阅 [创建 package](/tools/pub/create-packages)。

### Public tools

### 公开工具

Dart scripts placed inside of the `bin` directory are public. If you're
inside the directory of a package, you can use
[`dart run`](/tools/dart-run) to run scripts from the `bin`
directories of any other package the package depends on. From _any_
directory, you can [run scripts][]
from packages that you have activated using
[`dart pub global activate`][activate].

放在 `bin` 目录中的 Dart 脚本是公开的。
如果你位于某个 package 的目录中，可以用 [`dart run`](/tools/dart-run)
运行该 package 所依赖的任何其他 package 的 `bin` 目录中的脚本。
从 **任意** 目录，你都可以 [运行脚本][run scripts]，
这些脚本来自你用 [`dart pub global activate`][activate] 激活的 package。

[run scripts]: /tools/pub/cmd/pub-global#running-a-script
[activate]: /tools/pub/cmd/pub-global#activating-a-package

If you intend for your package to be depended on,
and you want your scripts to be private to your package, place them
in the top-level `tool` directory.
If you don't intend for your package to be depended on, you can leave your
scripts in `bin`.

如果你打算让别人依赖你的 package，
并且希望脚本只在 package 内部使用，请把它们放在顶层 `tool` 目录。
如果你不打算让别人依赖这个 package，可以把脚本留在 `bin` 中。


## Public assets

## 公开资源

<FileTree>

- enchilada/
  - lib/
    - guacamole.css

</FileTree>

While most packages exist to let you reuse Dart code, you can also
reuse other kinds of content. For example, a package for
[Bootstrap](https://getbootstrap.com/) might include a number of CSS files
for consumers of the package to use.

虽然大多数 package 是为了让你复用 Dart 代码，你也可以复用其他类型的内容。
例如，一个 [Bootstrap](https://getbootstrap.com/) 的 package
可能包含若干供 package 使用者使用的 CSS 文件。

These go in the top-level `lib` directory. You can put any kind of file
in there and organize it with subdirectories however you like.

这些文件放在顶层 `lib` 目录中。
你可以在里面放任何类型的文件，并用子目录按自己的方式组织。


## Implementation files

## 实现文件

<FileTree>

- enchilada/
  - lib/
    - src/
      - beans.dart
      - queso.dart

</FileTree>

The libraries inside `lib` are publicly visible: other packages are free to
import them. But much of a package's code is internal implementation libraries
that should only be imported and used by the package itself. Those go inside a
subdirectory of `lib` called `src`. You can create subdirectories in there if
it helps you organize things.

`lib` 里的库是公开可见的：其他 package 可以自由导入它们。
但 package 的很多代码是内部实现库，只应由 package 自己导入和使用。
这些文件放在 `lib` 的子目录 `src` 中。
如果有助于组织，你可以在里面再创建子目录。

You are free to import libraries that live in `lib/src` from within other Dart
code in the *same* package (like other libraries in `lib`, scripts in `bin`, and
tests) but you should never import from another package's `lib/src` directory.
Those files are not part of the package's public API, and they might change in
ways that could break your code.

你可以在 **同一个** package 的其他 Dart 代码中自由导入位于 `lib/src` 的库
（例如 `lib` 中的其他库、`bin` 中的脚本以及测试），
但绝不应该导入另一个 package 的 `lib/src` 目录。
那些文件不属于 package 的公开 API，它们的变化方式可能会弄坏你的代码。

How you import libraries from within your own package
depends on the locations of the libraries:

在自己的 package 内部如何导入库，取决于这些库的位置：

 * When [reaching inside or outside `lib/`][]
   (lint: [_avoid_relative_lib_imports_][]),
   use `package:`.

   当 [进入或离开 `lib/`][reaching inside or outside `lib/`]
   （lint：[_avoid_relative_lib_imports_][]）时，使用 `package:`。

 * Otherwise, [prefer relative imports][].

   否则，[优先使用相对导入][prefer relative imports]。
 
 [reaching inside or outside `lib/`]: /effective-dart/usage#dont-allow-an-import-path-to-reach-into-or-out-of-lib
 [_avoid_relative_lib_imports_]: /tools/linter-rules/avoid_relative_lib_imports
 [prefer relative imports]: /effective-dart/usage#prefer-relative-import-paths

For example:

例如：

```dart title="lib/beans.dart"
// When importing from within lib:
import 'src/beans.dart';
```

```dart title="test/beans_test.dart"
// When importing from outside lib:
import 'package:enchilada/src/beans.dart';
```

The name you use here (in this case `enchilada`) is the name you specify for
your package in its [pubspec](/tools/pub/pubspec).

这里使用的名称（本例中是 `enchilada`）是你在 [pubspec](/tools/pub/pubspec) 中为 package 指定的名称。

## Web files

## Web 文件

<FileTree>

- enchilada/
  - web/
    - index.html
    - main.dart
    - style.css

</FileTree>

For web packages, place entrypoint code—Dart scripts that include
`main()` and supporting files, such as CSS or HTML—under `web`.
You can organize the `web` directory into subdirectories if you like.

对于 Web package，把入口点代码——包含 `main()` 的 Dart 脚本，
以及 CSS 或 HTML 等配套文件——放在 `web` 下。
如果你愿意，可以把 `web` 目录组织成子目录。

Put [library code](#public-libraries) under `lib`.
If the library isn't imported directly by code under `web`, or by
another package, put it under `lib/src`.
Put [web-based examples](#examples) under `example`. See
[Public assets](#public-assets) for tips on where to put assets,
such as images.

把 [库代码](#public-libraries) 放在 `lib` 下。
如果库不会被 `web` 下的代码或其他 package 直接导入，请把它放在 `lib/src` 下。
把 [基于 Web 的示例](#examples) 放在 `example` 下。
关于图片等资源放在哪里，请参阅 [公开资源](#public-assets)。

## Command-line apps

## 命令行应用

<FileTree>

- enchilada/
  - bin/
    - enchilada

</FileTree>

Some packages define programs that can be run directly from the command
line. These can be shell scripts or any other scripting language,
including Dart.

有些 package 定义了可以直接从命令行运行的程序。
它们可以是 shell 脚本，也可以是包括 Dart 在内的任何其他脚本语言。

If your package defines code like this, put it in a directory named `bin`.
You can run that script from anywhere on the command line, if you set it up
using
[`dart pub global`](/tools/pub/cmd/pub-global#running-a-script-from-your-path).

如果你的 package 定义了这样的代码，请把它放在名为 `bin` 的目录中。
如果用 [`dart pub global`](/tools/pub/cmd/pub-global#running-a-script-from-your-path)
配置好，你就可以从命令行的任何位置运行该脚本。

## Tests and benchmarks

## 测试与基准

<FileTree>

- enchilada/
  - test/
    - enchilada_test.dart
    - tortilla_test.dart

</FileTree>

Every package should have tests. With pub, the convention is
that most of these go in a `test` directory (or some directory inside it if you
like) and have `_test` at the end of their file names.

每个 package 都应该有测试。在 pub 中，约定是这些测试大多放在 `test` 目录
（或者你喜欢的话，放在它里面的某个目录），并且文件名以 `_test` 结尾。

Typically, these use the [test]({{site.pub-pkg}}/test) package.

它们通常使用 [test]({{site.pub-pkg}}/test) package。

<FileTree>

- enchilada/
  - integration_test/
    - app_test.dart

</FileTree>

Flutter app packages might also have special integration tests, which use the
[integration_test]({{site.flutter-docs}}/cookbook/testing/integration/introduction)
package. These tests live in their own `integration_test` directory.

Flutter 应用型 package 也可能有专门的集成测试，使用
[integration_test]({{site.flutter-docs}}/cookbook/testing/integration/introduction)
package。这些测试放在自己的 `integration_test` 目录中。

Other packages might choose to follow a similar pattern, to separate their slower
integration tests from their unit tests, but note that by default `dart test`
will not run these tests. You will have to explicitly run them with
`dart test integration_test`.

其他 package 也可以采用类似的模式，把较慢的集成测试和单元测试分开，
但请注意，默认情况下 `dart test` 不会运行这些测试。
你必须用 `dart test integration_test` 显式运行它们。

<FileTree>

- enchilada/
  - benchmark/
    - make_lunch.dart

</FileTree>

Packages that have performance-critical code might also include *benchmarks*.
These test the API not for correctness but for speed (or memory use, or maybe
other empirical metrics).

包含性能关键代码的 package 也可能包含 **基准测试**。
它们测试 API 不是为了正确性，而是为了速度（或内存占用，或其他经验指标）。

## Documentation

## 文档

<FileTree>

- enchilada/
  - doc/
    - api/
    - getting_started.md

</FileTree>

If you have code and tests, the next piece you might want
is good documentation. That goes inside a directory named `doc`.

如果已经有了代码和测试，你接下来可能想要的就是好的文档。
文档放在名为 `doc` 的目录中。

When you run the [`dart doc`](/tools/dart-doc)
tool, it places the API documentation, by default, under `doc/api`.
Since the API documentation is generated from the source code,
you should not place it under source control.

运行 [`dart doc`](/tools/dart-doc) 工具时，
它默认把 API 文档放在 `doc/api` 下。
由于 API 文档是从源代码生成的，你不应该把它放进源代码管理。

Other than the generated `api`, we don't
have any guidelines about format or organization of the documentation
that you author.  Use whatever markup format that you prefer.

除了生成的 `api` 之外，我们对于你编写的文档的格式或组织没有其他指南。
使用你喜欢的任何标记格式。

## Examples

## 示例

<FileTree>

- enchilada/
  - example/
    - main.dart

</FileTree>

Code, tests, docs, what else
could your users want? Standalone example programs that use your package, of
course! Those go inside the `example` directory. If the examples are complex
and use multiple files, consider making a directory for each example. Otherwise,
you can place each one right inside `example`.

代码、测试、文档，用户还可能想要什么？
当然是使用你的 package 的独立示例程序！
它们放在 `example` 目录中。如果示例比较复杂、使用多个文件，
可以考虑为每个示例单独建一个目录。否则，可以把每个示例直接放在 `example` 里。

In your examples, use `package:` to import files from your own package.
That ensures that the example code in your package looks exactly
like code outside of your package would look.

在示例中，使用 `package:` 从你自己的 package 导入文件。
这样可以确保 package 里的示例代码看起来和 package 外部的代码完全一样。

If you might publish your package,
consider creating an example file with one of the following names:

如果你可能会发布 package，请考虑用下面这些名称之一创建示例文件：

* <code>example/example[.md]</code>

  <code>example/example[.md]</code>

* <code>example[/lib]/main.dart</code>

  <code>example[/lib]/main.dart</code>

* <code>example[/lib]/<em>package_name</em>.dart</code>

  <code>example[/lib]/<em>package_name</em>.dart</code>

* <code>example[/lib]/<em>package_name</em>_example.dart</code>

  <code>example[/lib]/<em>package_name</em>_example.dart</code>

* <code>example[/lib]/example.dart</code>

  <code>example[/lib]/example.dart</code>

* <code>example/README[.md]</code>

  <code>example/README[.md]</code>

When you publish a package that contains one or more of the above files,
the pub.dev site creates an **Example** tab to display the first file it finds
(searching in the order shown in the list above).
For example, if your package has many files under its `example` directory,
including a file named `README.md`,
then your package's Example tab displays the contents of `example/README.md`
(parsed as [Markdown][]).

当你发布的 package 包含上述文件中的一个或多个时，
pub.dev 网站会创建一个 **Example** 标签页，显示它找到的第一个文件
（按上面列表中的顺序搜索）。
例如，如果你的 package 在 `example` 目录下有许多文件，其中包括名为 `README.md` 的文件，
那么 package 的 Example 标签页会显示 `example/README.md` 的内容
（按 [Markdown][] 解析）。

{% comment %}
To see how the example file is chosen,
search the dart-lang repos for exampleFileCandidates:
https://github.com/search?q=org%3Adart-lang+exampleFileCandidates&type=Code
{% endcomment %}

## Internal tools and scripts

## 内部工具和脚本

<FileTree>

- enchilada/
  - tool/
    - generate_docs.dart

</FileTree>

Mature packages often have little helper scripts and programs that people
run while developing the package itself. Think things like test runners,
documentation generators, or other bits of automation.

成熟的 package 常常有一些小的辅助脚本和程序，人们在开发 package 本身时运行它们。
可以想想测试运行器、文档生成器或其他自动化片段。

Unlike the scripts in `bin`, these are *not* for external users of the package.
If you have any of these, place them in a directory called `tool`.

与 `bin` 中的脚本不同，这些 **不是** 给 package 的外部用户用的。
如果你有这类脚本，请把它们放在名为 `tool` 的目录中。

## Hooks

## Hook 配置

<FileTree>

- enchilada/
  - hook/
    - build.dart

</FileTree>

Packages can define hooks to be invoked by the Dart and Flutter SDK.
These hooks have a predefined CLI, and will be invoked by the SDK tools if present.

package 可以定义由 Dart 和 Flutter SDK 调用的 hook。
这些 hook 有预定义的 CLI，如果存在，就会被 SDK 工具调用。

Because these hooks are invoked by the
`dart` and `flutter` tools on runs and builds, the dependencies
of these hooks must be normal dependencies and not `dev_dependencies`.

因为这些 hook 会在运行和构建时被 `dart` 和 `flutter` 工具调用，
它们的依赖必须是普通依赖，而不能是 `dev_dependencies`。

To learn more about how to define hooks, refer to the [build hooks][] documentation.

要进一步了解如何定义 hook，请参阅 [构建 hook][build hooks] 文档。

[build hooks]: /tools/hooks

## Skills

## Skill 说明

<FileTree>

- enchilada/
  - skills/
    - enchilada-cooking/
      - SKILL.md

</FileTree>

Packages can provide [AI agent skills][] to teach AI coding agents
how to use the package's APIs, architecture, and best practices.

package 可以提供 [AI agent skill][AI agent skills]，
用来教 AI 编程助手如何使用该 package 的 API、架构和最佳实践。

Each skill lives in a subdirectory under `skills/`
and contains a `SKILL.md` file
following the [Agent Skills specification][agentskills].
To prevent naming collisions in consumer projects,
each skill subdirectory name must begin with the package name
(or the package name with underscores replaced by hyphens)
followed by a hyphen (such as `enchilada-cooking`).

每个 skill 位于 `skills/` 下的一个子目录中，并包含一份 `SKILL.md` 文件，
遵循 [Agent Skills 规范][agentskills]。
为了避免在使用者项目中发生名称冲突，
每个 skill 子目录名都必须以 package 名称开头
（或者把 package 名称中的下划线换成连字符），
后面再跟一个连字符（例如 `enchilada-cooking`）。

When consumers depend on your package,
they can install and update your skills using the `package:skills` tool
(`dart run skills@ get`).

当使用者依赖你的 package 时，
他们可以用 `package:skills` 工具（`dart run skills@ get`）安装和更新你的 skill。

To learn how to author, test, and publish skills with your package,
see [Ship skills with packages][].

要了解如何随 package 编写、测试并发布 skill，
请参阅 [随 package 发布 skill][Ship skills with packages]。

[AI agent skills]: /ai/package-skills
[Ship skills with packages]: /tools/pub/package-skills
[agentskills]: https://agentskills.io

## Project-specific caching for tools

## 工具的项目级缓存

:::note
Do not check the `.dart_tool/` directory into source control.
Instead, keep `.dart_tool/` in `.gitignore`.

不要把 `.dart_tool/` 目录签入源代码管理。
请把 `.dart_tool/` 保留在 `.gitignore` 中。
:::

The `.dart_tool/` directory is created when you run `dart pub get`
and might be deleted at any time. Various tools use this directory
for caching files specific to your project and/or local machine.
The `.dart_tool/` directory should never be checked into
source control, or copied between machines.

运行 `dart pub get` 时会创建 `.dart_tool/` 目录，而且它随时可能被删除。
各种工具用这个目录缓存特定于你的项目和/或本地机器的文件。
`.dart_tool/` 目录绝不应该签入源代码管理，也不应该在机器之间复制。

It is also generally safe to delete the `.dart_tool/` directory,
though some tools might need recompute the cached information. 

删除 `.dart_tool/` 目录通常也是安全的，
不过有些工具可能需要重新计算缓存的信息。

**Example:** The [`dart pub get`](/tools/pub/cmd/pub-get) tool
will download and extract dependencies to a global `$PUB_CACHE` directory,
and then write a `.dart_tool/package_config.json` file mapping _package names_
to directories in the global `$PUB_CACHE` directory.
The `.dart_tool/package_config.json` file is used by other tools,
such as the analyzer and compilers when they need to resolve statements
such as `import 'package:foo/foo.dart'`.

**示例：** [`dart pub get`](/tools/pub/cmd/pub-get) 工具会把依赖下载并解压到全局 `$PUB_CACHE` 目录，
然后写入 `.dart_tool/package_config.json` 文件，把 **package 名称**
映射到全局 `$PUB_CACHE` 目录中的目录。
其他工具会使用 `.dart_tool/package_config.json` 文件，
例如分析器和编译器在需要解析 `import 'package:foo/foo.dart'` 这样的语句时。

When developing a tool that needs project-specific caching, 
you might consider using the `.dart_tool/` directory 
because most users already ignore it with `.gitignore`.
When caching files for your tool in a user's `.dart_tool/` directory,
you should use a unique subdirectory. To avoid collisions,
subdirectories of the form `.dart_tool/<tool_package_name>/`
are reserved for the package named `<tool_package_name>`.
If your tool isn't distributed through the [pub.dev site,]({{site.pub}})
you might consider publishing a placeholder package in order to 
reserve the unique name.

开发需要项目级缓存的工具时，可以考虑使用 `.dart_tool/` 目录，
因为大多数用户已经用 `.gitignore` 忽略了它。
在用户的 `.dart_tool/` 目录中为你的工具缓存文件时，应该使用唯一的子目录。
为了避免冲突，形如 `.dart_tool/<tool_package_name>/` 的子目录
保留给名为 `<tool_package_name>` 的 package。
如果你的工具不是通过 [pub.dev 网站]({{site.pub}}) 分发的，
可以考虑发布一个占位 package，以便保留这个唯一名称。

**Example:** [`package:build`]({{site.pub-pkg}}/build) provides a
framework for writing code generation steps.
When running these build steps, files are cached in `.dart_tool/build/`.
This helps speed-up future re-runs of the build steps.

**示例：** [`package:build`]({{site.pub-pkg}}/build) 提供了编写代码生成步骤的框架。
运行这些构建步骤时，文件会缓存在 `.dart_tool/build/` 中。
这有助于加快以后重新运行构建步骤的速度。

:::warning
When developing a tool that wants to cache files in `.dart_tool/`,
ensure the following:
  
* You are using a subdirectory named after a package you own
  (`.dart_tool/<my_tool_package_name>/`)

  你使用的子目录以你拥有的 package 命名
  （`.dart_tool/<my_tool_package_name>/`）

* Your files don't belong under source control, 
  as `.dart_tool/` is generally listed in `.gitignore`

  你的文件不属于源代码管理，
  因为 `.gitignore` 通常会列出 `.dart_tool/`

确保在开发想把文件缓存在 `.dart_tool/` 中的工具时，满足以下条件：
:::


[Markdown]: {{site.pub-pkg}}/markdown
