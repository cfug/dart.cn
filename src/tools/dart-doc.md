---
title: dart doc
title: dart doc 命令
description: API reference generation tool.
description: Dart 编程语言的 API 参考文档生成工具。
toc: false
---

The `dart doc` command (previously called `dartdoc`)
creates API reference documentation
from Dart source code.
You can add descriptions to the generated documentation
by using [documentation comments][],
which can contain [Markdown][] formatting.
For guidance on writing doc comments,
see the [documentation part of Effective Dart][effective doc].

`dart doc` 命令可以从你 Dart 源代码中生成 API 参考文档。
您可以使用 [文档注释][documentation comments]
向生成的文档添加说明，该说明支持 [MarkDown][] 格式。
你可以查阅 [高效 Dart 的文档部分][effective doc]
获取更多关于如何撰写文档注释的信息。

{{site.alert.note}}

  To generate documentation, 
  you must first run [`dart pub get`](/tools/pub/cmd/pub-get)
  and your package must pass [`dart analyze`](/tools/dart-analyze)
  without errors.

  想要生成文档，你需要先运行
  [`dart pub get`](/tools/pub/cmd/pub-get)，
  并且 package 必须在 [`dart analyze`](/tools/dart-analyze)
  静态分析中未出现错误才能正常生成。

{{site.alert.end}}

Run `dart doc` from the root directory of your package. 
For example:

从你 Package 的根目录中运行 `dartdoc` 命令。例如：

```terminal
$ cd my_app
$ dart pub get
$ dart doc .
Documenting my_app...
...
Success! Docs generated into /Users/me/projects/my_app/doc/api
```

By default, 
the documentation files are static HTML files,
placed in the `doc/api` directory. 
You can create the files in a different directory
with the `--output` flag.

生成的文档默认为 HTML 文件，保存在 `doc/api` 目录下。
你可以使用 `--output` 参数设置输出目录。

For information on command-line options, 
use the `help` command:

使用 `help` 命令可以查看更多命令行选项：

```terminal
$ dart help doc
```

[documentation comments]: /guides/language/language-tour#documentation-comments
[effective doc]: /guides/language/effective-dart/documentation
[Markdown]: {{site.pub-pkg}}/markdown

{% comment %}
[PENDING: Add more help, info on commonly used options, links to examples of use.]
{% endcomment %}
