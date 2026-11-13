---
# title: dart doc
title: dart doc 命令
# description: >-
#   Learn how to generate HTML-reference documentation for public Dart libraries.
description: 了解如何为公开的 Dart 库生成 HTML 参考文档。
ai-translated: true
---

The `dart doc` command generates HTML reference documentation
for Dart source code.

`dart doc` 命令会为 Dart 源代码生成 HTML 参考文档。

## Write documentation {:#write}

## 编写文档

To add reference text and examples to the generated documentation,
use [documentation comments][] with [Markdown][] formatting.
For guidance on writing doc comments,
check out the [Effective Dart: Documentation][] guide.

要在生成的文档中加入参考文字和示例，
请使用带 [Markdown][] 格式的 [文档注释][documentation comments]。
编写文档注释的指导，
见 [Effective Dart：文档][Effective Dart: Documentation] 指南。

[documentation comments]: /language/comments#documentation-comments
[Markdown]: {{site.pub-pkg}}/markdown
[Effective Dart: Documentation]: /effective-dart/documentation

## Generate API docs {:#generate}

## 生成 API 文档

:::note
To generate documentation,
you must first run [`dart pub get`](/tools/pub/cmd/pub-get)
and your package must pass [`dart analyze`](/tools/dart-analyze)
without errors.

要生成文档，必须先运行 [`dart pub get`](/tools/pub/cmd/pub-get)，
并且 package 必须能通过 [`dart analyze`](/tools/dart-analyze)，
不能有错误。
:::

To generate the documentation for your package,
run `dart doc .` from the package's root directory.
For example, generating the API docs for a `my_package` package
could resemble the following:

要为 package 生成文档，
请在 package 根目录运行 `dart doc .`。
例如，为 `my_package` 生成 API 文档时，输出可能类似下面这样：

```console
$ cd my_package
$ dart pub get
$ dart doc .
Documenting my_package...
...
Success! Docs generated into /Users/me/projects/my_package/doc/api
```

By default, `dart doc` places the generated documentation
and supporting files in the `doc/api` directory.
To change the output directory, specify
a path with the `--output` flag:

默认情况下，`dart doc` 会把生成的文档和支持文件放在 `doc/api` 目录。
要更改输出目录，请用 `--output` 参数指定路径：

```console
$ dart doc --output=api_docs .
```

If there are any issues with your package setup or documentation comments,
`dart doc` outputs them as errors or warnings.
If you just want to test for issues without saving the generated documentation,
add the `--dry-run` flag:

如果 package 配置或文档注释有问题，
`dart doc` 会把它们输出为错误或警告。
如果只想检查问题、不保存生成的文档，
请加上 `--dry-run` 参数：

```console
$ dart doc --dry-run .
```

### Configure generation {:#configure}

### 配置生成过程

To configure how `dart doc` generates documentation, create a
file named `dartdoc_options.yaml` in the root directory of your package.

要配置 `dart doc` 如何生成文档，
请在 package 根目录创建名为 `dartdoc_options.yaml` 的文件。

To learn more about the file's format and supported configuration options,
check out [dart.dev/go/dartdoc-options-file][dartdoc-options].

要进一步了解该文件的格式和支持的配置选项，
请查看 [dart.dev/go/dartdoc-options-file][dartdoc-options]。

{% comment %}
TODO: Document the long-term supported options here.
{% endcomment -%}

[dartdoc-options]: {{site.repo.dart.org}}/dartdoc#dartdoc_optionsyaml

## View generated docs {:#view}

## 查看生成的文档

You can view docs generated with `dart doc` in a variety of ways.

可以用多种方式查看 `dart doc` 生成的文档。

### View local docs {:#view-local}

### 查看本地文档

To view API docs you generated with `dart doc` or downloaded from online,
you must load them with an HTTP server.

要查看用 `dart doc` 生成的、或从网上下载的 API 文档，
必须通过 HTTP 服务器加载它们。

To serve the files, use any HTTP server.
Consider using [`package:dhttpd`][] from pub.dev.

要提供这些文件，可以使用任意 HTTP 服务器。
可以考虑使用 pub.dev 上的 [`package:dhttpd`][]。

To use `package:dhttpd`, install it globally, then run it
and specify the path of your generated docs.
The following commands install the package,
then run it to serve the API docs located at `doc/api`:

要使用 `package:dhttpd`，请先全局安装，再运行它并指定生成文档的路径。
下面的命令会安装该 package，
然后用它提供位于 `doc/api` 的 API 文档：

```console
$ dart install dhttpd
$ dhttpd --path doc/api
```

To then read the generated docs in your browser,
open the link that `dhttpd` outputs, usually `http://localhost:8080`.

然后在浏览器中阅读生成的文档：
打开 `dhttpd` 输出的链接，通常是 `http://localhost:8080`。

[`package:dhttpd`]: {{site.pub-pkg}}/dhttpd

### View hosted docs {:#view-hosted}

### 查看托管的文档

You can also host your generated API docs online
using any hosting service that supports static web content.
Two common options are [Firebase hosting][] and [GitHub pages][].

也可以把生成的 API 文档托管到网上，
使用任何支持静态 Web 内容的托管服务即可。
两个常见选择是 [Firebase 托管][Firebase hosting] 和 [GitHub Pages][GitHub pages]。

[Firebase hosting]: https://firebase.google.com/docs/hosting
[GitHub pages]: https://pages.github.com/

### View package docs {:#view-pub}

### 查看 package 文档

The [pub.dev site]({{site.pub}}) generates and hosts
documentation for an uploaded package's public libraries.

[pub.dev 网站]({{site.pub}}) 会为已上传 package 的公开库
生成并托管文档。

To view a package's generated docs,
navigate to its page and open the **API reference** link
in the info box on the right side of the page.
For example, you can find the API docs for `package:http`
at [pub.dev/documentation/http]({{site.pub-api}}/http).

要查看某个 package 生成的文档，
请打开它的页面，并点击页面右侧信息框中的 **API reference** 链接。
例如，`package:http` 的 API 文档位于
[pub.dev/documentation/http]({{site.pub-api}}/http)。

### View core library docs {:#view-sdk}

### 查看核心库文档

`dart doc` is also used to generate the API reference documentation for
the Dart core libraries.

`dart doc` 也用于生成 Dart 核心库的 API 参考文档。

To view the Dart SDK reference docs, visit the api.dart.dev link
that corresponds to the Dart release channel you are developing with:

要查看 Dart SDK 参考文档，请访问与你正在使用的
Dart 发布渠道对应的 api.dart.dev 链接：

| <t>Branch</t><t>分支</t>   | <t>Generated docs</t><t>生成的文档</t>                              |
|----------|---------------------------------------------|
| `stable` | [api.dart.dev/stable]({{site.dart-api}})    |
| `stable` | [api.dart.dev/stable]({{site.dart-api}})    |
| `beta`   | [api.dart.dev/beta]({{site.dart-api}}/beta) |
| `beta`   | [api.dart.dev/beta]({{site.dart-api}}/beta) |
| `dev`    | [api.dart.dev/dev]({{site.dart-api}}/dev)   |
| `dev`    | [api.dart.dev/dev]({{site.dart-api}}/dev)   |
| `main`   | [api.dart.dev/main]({{site.dart-api}}/main) |
| `main`   | [api.dart.dev/main]({{site.dart-api}}/main) |

{:.table .table-striped}

## Troubleshoot

## 问题排查

To identify and resolve common issues with docs generated with `dart doc`,
consult the following reference section.

要识别并解决 `dart doc` 生成的文档中的常见问题，
请查阅下面的参考部分。

### Search bar failed to load {:#troubleshoot-search}

### 搜索栏加载失败

If the generated documentation's search bars aren't functional or
include text similar to "Failed to initialize search",
one of the following scenarios is possible:

如果生成文档的搜索栏无法使用，
或出现类似 "Failed to initialize search" 的文字，
可能是下列情形之一：

1. You are accessing the docs from your own file system,
   but they aren't being served and loaded with an HTTP server.
   To learn how to serve local API docs,
   check out [how to view generated docs locally](#view-local).

   你是从自己的文件系统访问文档，
   但文档并没有通过 HTTP 服务器提供和加载。
   如何提供本地 API 文档，
   见 [如何在本地查看生成的文档](#view-local)。

2. The `index.json` file generated by `dart doc` is missing or inaccessible
   from the documentation directory or your hosted web server.
   Try regenerating the docs and validating your hosting configuration.

   `dart doc` 生成的 `index.json` 文件缺失，
   或无法从文档目录或托管的 Web 服务器访问。
   请尝试重新生成文档，并检查托管配置。

### Sidebar failed to load {:#troubleshoot-sidebar}

### 侧边栏加载失败

If the generated documentation's sidebars are missing or
include text similar to "Failed to load sidebar",
one of the following scenarios is possible:

如果生成文档的侧边栏缺失，
或出现类似 "Failed to load sidebar" 的文字，
可能是下列情形之一：

1. You are accessing the docs from your own file system,
   but the docs aren't being served and loaded with an HTTP server.
   To learn how to serve local API docs,
   check out [how to view local docs](#view-local).

   你是从自己的文件系统访问文档，
   但文档并没有通过 HTTP 服务器提供和加载。
   如何提供本地 API 文档，
   见 [如何查看本地文档](#view-local)。

2. The generated docs' base-href behavior is configured.
   This configuration option is deprecated and should no longer be used.
   Try removing the option and using the default behavior of `dart doc`.
   If the default behavior breaks links in your generated docs,
   please [file an issue][].

   生成文档的 base-href 行为被配置过。
   该配置选项已弃用，不应再使用。
   请尝试移除该选项，改用 `dart doc` 的默认行为。
   如果默认行为破坏了生成文档中的链接，
   请 [提交 issue][file an issue]。

[file an issue]: {{site.repo.dart.org}}/dartdoc/issues

### Missing API documentation {:#troubleshoot-missing}

### 缺少 API 文档

If you can't find or access the generated documentation
for an API you expect to have docs,
one of the following scenarios is possible:

如果找不到或无法访问你预期应有文档的某个 API，
可能是下列情形之一：

1. The package does not expose the API you are looking for as a public API.
   `dart doc` only generates documentation for public libraries and members
   that are exposed for other packages to import and use.
   To learn more about configuring a package's public libraries,
   check out the package layout guide on [public libraries][].

   该 package 没有把你要找的 API 作为公开 API 暴露出来。
   `dart doc` 只为公开库和成员生成文档，
   也就是暴露给其他 package 导入和使用的那些。
   如何配置 package 的公开库，
   见 package 布局指南中的 [公开库][public libraries]。

2. The URL you are attempting to access has incorrect capitalization.
   By default, `dart doc` generates filenames that are case-sensitive,
   match their corresponding source declarations, and have a `.html` extension.
   Try verifying the URL matches these expectations.

   你尝试访问的 URL 大小写不正确。
   默认情况下，`dart doc` 生成的文件名区分大小写，
   与对应的源码声明一致，并带有 `.html` 扩展名。
   请确认 URL 符合这些要求。

[public libraries]: /tools/pub/package-layout#public-libraries

### Text where icons should be {:#troubleshoot-icons}

### 图标的位置显示成了文字

If you see text instead of icons like the menu and theme buttons,
your browser was likely unable to load the Material Symbols font.
Some options to solve this include:

如果菜单和主题按钮等图标的位置显示成了文字，
多半是浏览器没能加载 Material Symbols 字体。
可以尝试下列办法：

1. Try using a proxy that enables access to the Google Fonts servers.

   尝试使用能够访问 Google Fonts 服务器的代理。

2. Update the generated pages to use a local version of the font.

   更新生成的页面，改用本地版本的字体。
