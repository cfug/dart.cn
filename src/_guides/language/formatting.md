---
title: Formatting code
title: 代码格式化
description: Use `dart format` to format your code, and follow Effective Dart guidelines for what `dart format` doesn't cover.
description: 使用 `dart format` 来格式化你的代码，并且通过 Dart 高效指南 (Effective Dart) 进一步调整 `dart format` 没有包括的内容。
toc: false
---

As [Effective Dart][] says, when it comes to things like formatting,
arguments about which is better are subjective and impossible to resolve.
What we do know is that being consistent is objectively helpful.
If two pieces of code look different it should be because
they _are_ different in some meaningful way.
When a bit of code stands out and catches your eye, it should do so for a useful reason.

正如 [高效 Dart 语言指南][Effective Dart] 所说，
在面对代码格式化的问题时，哪个参数更好是一种主观感受，
无法完全解决。
Fortunately, you can use the [`dart format` tool][dartfmt] —
from the command line or in your favorite [Dart-savvy IDE][ide] —
to perform most of the drudge work of formatting your code.
For example, here's how to format all the Dart files
under the current directory's `bin`, `lib`, and `test` directories:

幸运的是，您可以在命令行或可以使用 Dart 的 IDE 中使用
[`dart format` 工具][dartfmt] 来进行繁杂的大部分格式化工作。
举个例子，下面是对当前目录下的 `bin`、`lib` 和 `test` 文件夹下的
所有 Dart 文件进行格式化的方法：
```terminal
$ dart format -w bin lib test
```

However, dart format can't do it all.
To avoid making changes that might be unsafe, `dart format` affects only whitespace.
For additional guidance, see the Effective Dart
[style guidelines][], especially the [formatting guidelines][]. 

然而，dart format 并不是面面俱到。
为了避免造成一些破坏性改动，
`dart format` 仅仅会对空格（包含换行和缩进）进行操作。
若需获得更多的指导，请查看高效 Dart 语言指南的 [风格指南][style guidelines]，
特别是其中的 [格式化指南][formatting guidelines] 部分。
More information:

更多信息：

* [`dart format`][dartfmt]
* [高效 Dart 语言指南：代码风格][style guidelines]

[dartfmt]: /tools/dartfmt
[Effective Dart]: /guides/language/effective-dart
[formatting guidelines]: /guides/language/effective-dart/style#formatting
[ide]: /tools/#ides-and-editors
[style guidelines]: /guides/language/effective-dart/style
