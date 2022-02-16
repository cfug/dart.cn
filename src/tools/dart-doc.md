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
which can contain markdown formatting.
For guidance on writing doc comments,
see the [documentation part of Effective Dart][effective doc].

{{site.alert.note}}
  To generate documentation, your package must pass [dart analyze][]
  without errors.
{{site.alert.end}}

`dartdoc` 命令可以从你 Dart 源代码中生成 API 参考文档。
您可以使用 [文档注释][documentation comments]
向生成的文档添加说明，该说明支持 MarkDown 格式。
你可以查阅 [高效 Dart 的文档部分][effective doc]
获取更多关于如何撰写文档注释的信息。

{{site.alert.note}}
  你的 package 必须在 [dart analyze][]
  静态分析中未出现错误才能生成文档。
{{site.alert.end}}

Run `dart doc` from the root directory of your package. For example:

从你 Package 的根目录中运行 `dartdoc` 命令。例如：

```terminal
$ cd my_app
$ dart doc .
Documenting my_app...
...
Success! Docs generated into /Users/me/projects/my_app/doc/api
```

By default, the documentation files are static HTML files,
placed in the `doc/api` directory. You can create the
files in a different directory with the `--output-dir` flag.

For information on command-line options, use the `help` command:

使用 `help` 命令可以查看更多命令行选项：

```terminal
$ dart help doc
```

[documentation comments]: /guides/language/language-tour#documentation-comments
[effective doc]: /guides/language/effective-dart/documentation
[dart analyze]: /tools/dart-analyze

{% comment %}
[PENDING: Add more help, info on commonly used options, links to examples of use.]
{% endcomment %}
