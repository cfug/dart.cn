---
title: dartdoc
title: dartdoc 命令
description: API reference generation tool.
description: Dart 编程语言的 API 参考文档生成工具。
toc: false
---

The `dartdoc` command creates API reference documentation
from Dart source code.
You can add descriptions to the generated documentation
by using [documentation comments][],
which can contain markdown formatting.
For guidance on writing doc comments,
see the [documentation part of Effective Dart][effective doc].
{{site.alert.note}}
  To generate documentation, your package must pass [dart analyze][]
  without errors.
{{site.alert.end}}

`dartdoc` 命令可以从你 Dart 源代码中生成 API 参考文档。您可以使用 [文档注释][documentation comments] 向生成的文档添加说明，该说明支持 MarkDown 格式。你可以查阅 [高效 Dart 的文档部分][effective doc] 获取更多关于如何撰写文档注释的信息。

Run `dartdoc` from the root directory of your package. For example:

从你 Package 的根目录中运行 `dartdoc` 命令。例如：

```terminal
$ cd my_app
$ dartdoc
Documenting my_app...
...
Success! Docs generated into /Users/me/projects/my_app/doc/api
```

By default, the documentation files are static HTML files,
placed in the `doc/api` directory.
To view the rendered documentation, you need an HTTP server.

默认情况下，文档文件是存放在 `doc/api` 目录下的静态 HTML 文件。你需要一个 HTTP 服务器来查看渲染后的文档。

Although `dartdoc` is in the Dart SDK,
it's also available in the [dartdoc package.][]
You might use the package when you need a programmatic interface
or when you want to try features that
aren't yet in the SDK's version of `dartdoc`.

虽然 `dartdoc` 命令已存在于 Dart SDK 中，但你也可以从 [dartdoc Package][dartdoc package.] 找到它。你可以使用在需要编程接口或尝试 SDK 中的 `dartdoc` 命令没有的新功能时使用 dartdoc 的 Package。

For information on command-line options, use the `--help` flag:

使用 `--help` 命令行参数可以查看更多命令行选项：

```terminal
$ dartdoc --help
```

[documentation comments]: /guides/language/language-tour#documentation-comments
[effective doc]: /guides/language/effective-dart/documentation
[dart analyze]: /tools/dart-analyze
[dartdoc package.]: {{site.pub-pkg}}/dartdoc

{% comment %}
[PENDING: Add more help, info on commonly used options, links to examples of use.]
{% endcomment %}
