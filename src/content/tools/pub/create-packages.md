---
# title: Creating packages
title: 创建 package
# description: Learn how to create packages in Dart.
description: 学习如何在 Dart 里创建可复用的库。
---

The Dart ecosystem uses [packages](/tools/pub/packages)
to share software such as libraries and tools.
This page tells you how to create a standard shared 
[package](/tools/pub/glossary#package).

在 Dart 生态系统中使用 [packages](/tools/pub/packages) 实现共享软件，
比如一些库和工具。
本章将通过最常见的 [Package](/tools/pub/glossary#package)
来介绍如何创建一个 Package。

## Creating a new package

## 创建一个新的 package

To create the initial directory and structure for a package,
use the [`dart create`](/tools/dart-create) command
and the `package` template:

若要为 package 创建一个初始化的目录和结构，
使用 [`dart create`](/tools/dart-create) 命令，
并加入 `package` 作为命令参数来创建：

```console
$ dart create -t package <PACKAGE_NAME>
```

## What makes a package

## Package 的组成

The following diagram shows the simplest layout of a package:

下图展示了最简单的 Package 的结构：

<img
  src="/assets/img/libraries/simple-lib2.png"
  class="diagram-wrap"
  alt="root directory contains pubspec.yaml and lib/file.dart">

The minimal requirements for a library are:

Package 的最基本要求包括：

pubspec file
<br> The `pubspec.yaml` file for a library is the same
  as for an [application package][]—there is no special
  designation to indicate that the package is a library.

pubspec 文件
<br> Package 的 `pubspec.yaml` 文件与
  [应用程序的 `pubspec.yaml` 文件][application package]
  相同&mdash; `pubspec.yaml`
  文件中并没有特别的指出这个 Package 是一个库。

lib directory
<br> As you might expect, the library code lives under the _lib_
  directory and is public to other packages.
  You can create any hierarchy under lib, as needed.
  By convention, implementation code is placed under _lib/src_.
  Code under lib/src is considered private;
  other packages should never need to import `src/...`.
  To make APIs under lib/src public, you can export lib/src files
  from a file that's directly under lib.

lib 目录
<br> 如你所料，库的代码位于 _lib_ 目录下，
  且对于其他 Package 是公开的。
  你可以根据需要在 **lib** 下任意创建组织文件结构。
  按照惯例，实现代码会放在 **lib/src** 目录下。
  lib/src 目录下的代码被认为是私有的。
  其他 Package 应该永远不需要导入 `src/...` 目录下代码。
  通过导出 lib/src 目录的文件到一个 lib 目录的文件，实现
  对 lib/src 目录中 API 的公开。

[application package]: /tools/pub/glossary#application-package

## Organizing a package

## 组织 Package 的代码结构

Packages are easiest to maintain, extend, and test
when you create small, individual libraries, referred to as
_mini libraries_.
In most cases, each class should be in its own mini library, unless
you have a situation where two classes are tightly coupled.

在创建一个小的，独立的 Package 时（称之为 **Mini Library**），
它非常容易维护，扩展和测试。
大多数情况下，除非存在两个类紧密耦合的情况，否则每个类都应该将自己视为一个 Mini Library 。

:::note

You might know about the `part` directive.
This directive allows you to split a library into multiple Dart files.
Though part files can incorporate generated code into a library,
the Dart team doesn't recommend using them.
Instead, create small libraries.

你也许知道 `part` 指令。
该指令允许你将一个 library 分割成多个 Dart 文件。
虽然 part 文件可以将生成的代码整合到 library 中，
但 Dart 团队并不推荐使用它们。
取而代之更推荐创建 Mini Library。

:::

Create a "main" library file directly under lib,
lib/_&lt;package-name&gt;_.dart, that
exports all of the public APIs.
This allows the user to get all of a library's functionality
by importing a single file.

直接在 lib 目录下创建“主” Library 文件，lib/_&lt;package-name&gt;_.dart，
该文件导出所有的公开的 API 。
这样就可以允许使用者导入单个文件就能够获得 Library 的所有功能。

The lib directory might also include other importable, non-src, libraries.
For example, perhaps your main library works across platforms, but
you create separate libraries that rely on `dart:io` or `dart:js_interop`.
Some packages have separate libraries that are meant to be imported
with a prefix, when the main library is not.

lib 目录还可能包含其他可导入的非 src 代码。
例如，主 Library 可能是跨平台的，
但创建的独立 Library 依赖于 `dart:io` 或 `dart:js_interop` 。
Some packages have separate libraries that are meant to be imported
with a prefix, when the main library is not.

Let's look at the organization of a real-world package: shelf. The
[shelf]({{site.repo.dart.org}}/shelf)
package provides an easy way to create web servers using Dart,
and is laid out in a structure that is commonly used for Dart packages:

这里让我们来看下一个真实 Library Package 的组织结构：shelf 。
[shelf]({{site.repo.dart.org}}/shelf) Package
提供了一种使用 Dart 创建 Web 服务器的简便方法，
它是一种 Dart Package 的常用结构：

<img
  src="/assets/img/libraries/shelf.png"
  class="diagram-wrap"
  alt="shelf root directory contains example, lib, test, and tool subdirectories">

Directly under lib, the main library file,
`shelf.dart`, exports API from several files in `lib/src`.
To avoid exposing more API than intended—and 
to give developers an overview of the entire
public API of the package—`shelf.dart` 
uses `show` to specify exactly which symbols to export:

主 Library 文件 `shelf.dart` 在 lib 目录下，
通过 `shelf.dart` 文件导出 lib/src 目录下的若干文件。
为了不导出过多的 API，并且为开发者提供公开的 API 的概览，
`shelf.dart` 使用了 `show` 来指定哪些内容需要导出：

```dart title="lib/shelf.dart"
export 'src/cascade.dart' show Cascade;
export 'src/handler.dart' show Handler;
export 'src/hijack_exception.dart' show HijackException;
export 'src/middleware.dart' show Middleware, createMiddleware;
export 'src/middleware/add_chunked_encoding.dart' show addChunkedEncoding;
export 'src/middleware/logger.dart' show logRequests;
export 'src/middleware_extensions.dart' show MiddlewareExtensions;
export 'src/pipeline.dart' show Pipeline;
export 'src/request.dart' show Request;
export 'src/response.dart' show Response;
export 'src/server.dart' show Server;
export 'src/server_handler.dart' show ServerHandler;
```

The shelf package also contains a mini library: shelf_io.
This adapter handles HttpRequest objects from `dart:io`.

在 shelf Package 中同样包含了 Mini Library：shelf_io 。
适配器用来处理来自 `dart:io` 的 HttpRequest 对象。

:::tip

For the best performance when developing with the
development JavaScript compiler through [`webdev serve`][],
put [implementation files](/tools/pub/package-layout#implementation-files) 
under `/lib/src`, instead of elsewhere under `/lib`.
Also, avoid imports of <code>package:<em>package_name</em>/src/...</code>.

为了在开发时使 [`webdev serve`][] 工具能够达到最佳性能，
应该将 [实现文件](/tools/pub/package-layout#implementation-files) 放到目录 `/lib/src` 下，
而不是 `/lib` 目录的其他地方。
另外，避免通过 <code>package:<em>package_name</em>/src/...</code> 导入文件。

:::

[`webdev serve`]: /tools/webdev#serve

## Importing library files

## 导入库文件

When importing a library file from another package, use
the `package:` directive to specify the URI of that file.

在从其他 package 导入库文件时，
使用 `package:` 命令来指定文件的 URI 。

```dart
import 'package:utilities/utilities.dart';
```

When importing a library file from your own package,
use a relative path when both files are inside of lib,
or when both files are outside of lib. 
Use `package:` when the imported file is in lib and the importer is outside.

在两个文件都在 lib 目录中，或两个文件都在 lib 目录外，
我们都可以使用相对路径的方式导入 Library 。
但是，如果两个文件不都在 lib 目录中，需要对 lib 内或者 lib 外进行查找，
那么此时必须要使用 `package:` 导入。
如果对当前使用存在疑惑，那么直接 `package:` ； `package:` 满足所有情况。

The following graphic shows how
to import `lib/foo/a.dart` from both lib and web.

下面图片展示分别从 lib 和 web 目录中导入 `lib/foo/a.dart` 。

<img
  src="/assets/img/libraries/import-lib-rules.png"
  class="diagram-wrap"
  alt="lib/bar/b.dart uses a relative import; web/main.dart uses a package import">

## Conditionally importing and exporting library files

## 条件导入或条件导出 Library 文件

If your library supports multiple platforms,
then you might need to conditionally import or export library files.
A common use case is a library that supports both web and native platforms.

如果你的 library 支持多平台，那么你应该会用到条件导入
或条件导出 library 文件。
常见的用例是，一个库同时支持 Web 和 Native 平台。

To conditionally import or export,
you need to check for the presence of `dart:*` libraries.
Here's an example of conditional export code that
checks for the presence of `dart:io` and `dart:js_interop`:

为了使用条件导入或条件导出，你需要检查
是否存在 `dart:*` 库。
下面是一个条件导出代码的样例，
它将检查是否存在 `dart:io` and `dart:html` 库：

<?code-excerpt "create_libraries/lib/hw_mp.dart (export)"?>
```dart title="lib/hw_mp.dart"
export 'src/hw_none.dart' // Stub implementation
    if (dart.library.io) 'src/hw_io.dart' // dart:io implementation
    if (dart.library.js_interop) 'src/hw_web.dart'; // package:web implementation
```

Here's what that code does:

该代码的作用如下：

* In an app that can use `dart:io`
  (for example, a command-line app),
  export `src/hw_io.dart`.

  在一个可以使用 `dart:io` 的 app 中
  （例如一个命令行应用），
  导出 `src/hw_io.dart`。

* In an app that can use `dart:js_interop`
  (a web app),
  export `src/hw_web.dart`.

  在一个 web 应用中可以使用 `dart:js_interop`
  导出 `src/hw_web.dart`。

* Otherwise, export `src/hw_none.dart`.

  若是其他情况，则导出 `src/hw_none.dart`。

To conditionally import a file, use the same code as above,
but change `export` to `import`.

要条件导入一个文件可以使用和上面一样的方式，
仅需将 `export` 改为 `import` 即可。

:::note

Conditional imports or exports only work with keys in the compilation
environment. Any sequence of dot-separated identifiers is valid syntax.
Currently, only keys of the form  `dart.library.name` are provided.
`dart.library.name` is set to `"true"` in the compilation 
environment if the library `dart:name` is _available for use_ on
the current platform, not whether it's actually imported or used.

条件导入或条件导出仅在编译环境中存在对应的键时才有效。
任何以点分割的标识符序列都是有效的语法。
目前，只提供 `dart.library.name` 形式的键。
在编译环境中，如果 `dart:name` 库在当前平台上 _可用_，
不论该库是否实际导入或使用，
`dart.library.name` 都会被设置为 `"true"`。

:::

All of the conditionally exported libraries must implement the same API.
For example, here's the `dart:io` implementation:

所有条件导出的库必须实现相同的 API。
下面是 `dart:io` 实现的一个例子：

<?code-excerpt "create_libraries/lib/src/hw_io.dart"?>
```dart title="lib/src/hw_io.dart"
import 'dart:io';

void alarm([String? text]) {
  stderr.writeln(text ?? message);
}

String get message => 'Hello World from the VM!';
```

And here's the default implementation,
which uses stubs that throw `UnsupportedError`:

这是一个默认实现，它会导致抛出 `UnsupportedErrors`：

<?code-excerpt "create_libraries/lib/src/hw_none.dart"?>
```dart title="lib/src/hw_none.dart"
void alarm([String? text]) => throw UnsupportedError('hw_none alarm');

String get message => throw UnsupportedError('hw_none message');
```

On any platform,
you can import the library that has the conditional export code:

在任何平台上，你都可以导入具有条件导出代码的库：

<?code-excerpt "create_libraries/example/hw_example.dart" replace="/create_libraries/hw_mp/g"?>
```dart
import 'package:hw_mp/hw_mp.dart';

void main() {
  print(message);
}
```

## Providing additional files

## 提供额外文件

A well-designed package is easy to test.
We recommend that you write tests using the
[test]({{site.repo.dart.org}}/test) package,
placing the test code in the `test` directory at the
top of the package.

一个设计良好的 Package 很容易被测试。
我们建议使用 [test]({{site.repo.dart.org}}/test) Package
编写测试用例，并将测试代码放到 Package 根目录的 `test` 目录中。

If you create any command-line tools intended for public consumption,
place those in the `bin` directory, which is public.
Enable running a tool from the command line, using
[`dart pub global activate`](/tools/pub/cmd/pub-global#activating-a-package).
Listing the tool in the
[`executables` section](/tools/pub/pubspec#executables)
of the pubspec allows a user to run it directly without calling
[`dart pub global run`](/tools/pub/cmd/pub-global#running-a-script-using-dart-pub-global-run).

如果要创建一个公用的命令行工具，应该将这些工具放到公共目录 `bin` 中。
使用 [`dart pub global activate`](/tools/pub/cmd/pub-global#activating-a-package) 命令行
来运行工具。
在 pubspec 的 [`executables` 部分](/tools/pub/pubspec#executables)
列出的工具允许用户直接运行它而无需调用
[`dart pub global run`](/tools/pub/cmd/pub-global#running-a-script-using-dart-pub-global-run)。

It's helpful if you include an example of how to use your library.
This goes into the `example` directory at the top of the package.

在 Library 中包含一个 example 程序演示如何使用 Library 是非常有用的。
example 程序在 Package 根目录的 `example` 目录中。

Any tools or executables that you create during development that aren't for
public use go into the `tool` directory.

在开发过程中任何非公开的工具或可执行程序，应该放到 `tool` 文件夹。

Other files that are required if you publish your library to the
[pub.dev]({{site.pub}}) site, such as `README.md` and `CHANGELOG.md`, are
described in [Publishing a package](/tools/pub/publishing).
For more information on how to organize a package directory,
see the [pub package layout conventions](/tools/pub/package-layout).

如果要将 Library 发布到 Pub 网站还要求一些其他的文件来描述 [发布的 Package](/tools/pub/publishing) ，
例如：`README.md` 和 `CHANGELOG.md` 文件。
更多关于如何组织 Package 目录的内容，参见 [Pub Package 布局约定](/tools/pub/package-layout)。

## Documenting a library

## 为 Library 制作文档

You can generate API docs for your library using
the [`dart doc`][] tool.
`dart doc` parses the source looking for
[documentation comments](/effective-dart/documentation#doc-comments),
which use the `///` syntax:

使用 [`dart doc`][] 可以为 Library 生成 API 文档。
dartdoc 解析源文件去查找使用 `///` 语法标注的
[文档注释](/effective-dart/documentation#doc-comments)：

```dart
/// The event handler responsible for updating the badge in the UI.
void updateBadge() {
  ...
}
```

For an example of generated docs, see the
[shelf documentation.]({{site.pub-api}}/shelf/latest)

文档生成示例，参见 [shelf 文档]({{site.pub-api}}/shelf/latest)。

To include any *library-level* documentation in the generated docs,
add a `library` directive and attach the comment directly above it.
For the how-and-why of documenting libraries, see
[Effective Dart: Documentation](/effective-dart/documentation#consider-writing-a-library-level-doc-comment).

若要自动生成任何库级别的文档，请添加一个 `library` 指令并直接在其上方附加注释。
更多详情，请参阅文档
[Effective Dart: Documentation](/effective-dart/documentation#consider-writing-a-library-level-doc-comment)。

## Distributing an open source library {:#distributing-a-library}

## 分发开源 Library

If your library is open source,
we recommend sharing it on the [pub.dev site.]({{site.pub}})
To publish or update the library,
use [pub publish](/tools/pub/cmd/pub-lish),
which uploads your package and creates or updates its page.
For example, see the page for the [shelf package.]({{site.pub-pkg}}/shelf)
See [Publishing a package](/tools/pub/publishing)
for details on how to prepare your package for publishing.

如果 Library 是开源的，
我们建议将他共享到 [Pub 网站]({{site.pub}})。
使用 [pub publish](/tools/pub/cmd/pub-lish) 来发布或者更新 Library，
该命令将会上传 Package 并创建或更新其页面。
示例参见 [shelf Package]({{site.pub-pkg}}/shelf) 页面。
有关如何准备发布 Package 的详细内容，参见 [发布 Package](/tools/pub/publishing)。

The pub.dev site not only hosts your package,
but also generates and hosts your package's API reference docs.
A link to the latest generated docs is in the package's **About** box;
for example, see the shelf package's
[API docs.]({{site.pub-api}}/shelf)
Links to previous versions' docs are in the
**Versions** tab of the package's page.

Pub.dev 网站不仅仅是 Dart Packages 的发布网站，
Pub 网站不仅用于托管 Package ，还能够生成托管 Package 的 API 参考文档。
最新生成的文档的链接位于 Package 的 **About** 选项卡中;
示例参见 shelf Package 的 [API 文档]({{site.pub-api}}/shelf)。
链接到以前版本的文档，位于 Package 页面的 **Versions** 选项卡中。

To ensure that your package's API docs look good on the pub.dev site,
follow these steps:

为了确保 Package 的 API 文档在 Pub 网站上看起来更美观，
请遵循以下步骤：

* Before publishing your package, run the [`dart doc`][] tool
  to make sure that your docs generate successfully and look as expected.

  在发布 Package 前，请通过执行 [`dart doc`][]
  工具确保文档能够生成成功且符合预期。

* After publishing your package, check the **Versions** tab
  to make sure that the docs generated successfully.

  在发布 Package 后，请检查 **Versions** 选项卡，确保文档生成成功。

* If the docs didn't generate at all,
  click **failed** in the **Versions** tab to see the `dart doc` output.

  如果文档没有生成，点击 **Versions** 选项卡中的 **failed** 查看 dartdoc 的输出。

## Resources

## 资源

Use the following resources to learn more about packages:

通过运用以下资源来了解学习更多关于 Library Package 的内容：

* [Libraries and imports](/language/libraries) covers
  using library files.

  在 [库及可见性](/language/libraries) 中涵盖了库文件使用的内容。

* The [package](/tools/pub/packages) documentation is useful, particularly the
  [package layout conventions](/tools/pub/package-layout).

  [Package](/tools/pub/packages) 文档非常有用，尤其是 
  [Package 结构约定](/tools/pub/package-layout).

* [What not to commit](/tools/pub/private-files)
  covers what shouldn't be checked into a source code repository

  [什么不应该被提交](/tools/pub/private-files)
  包含了关于什么文件不应该被提交到源码仓库的介绍。

* The newer packages under the
  [dart-lang]({{site.repo.dart.org}}) organization tend
  to show best practices. Consider studying these examples:
  [dart_style,]({{site.repo.dart.org}}/dart_style)
  [path,]({{site.repo.dart.org}}/core/tree/main/pkgs/path)
  [shelf,]({{site.repo.dart.org}}/shelf)
  [source_gen,]({{site.repo.dart.org}}/source_gen) and
  [test.]({{site.repo.dart.org}}/test)

  [dart-lang]({{site.repo.dart.org}}) 组织下的最新 Package
  常常是最佳实践的提现。可以参考学些以下这些实例：
  [dart_style]({{site.repo.dart.org}}/dart_style)，
  [path]({{site.repo.dart.org}}/path)，
  [shelf]({{site.repo.dart.org}}/shelf)，
  [source_gen]({{site.repo.dart.org}}/source_gen) 以及
  [test]({{site.repo.dart.org}}/test) 。

[`dart doc`]: /tools/dart-doc
