---
title: dart2aot
title: dart2aot 命令 (以 AOT 模式运行 Dart 代码)
description: Command-line tool for AOT-compiling Dart source code.
toc: false
---

Use the `dart2aot` command to AOT (ahead-of-time) compile a Dart program to
native x64 machine code. This tool is supported on Windows, macOS, and Linux.
Here's an example of using `dart2aot`:

```terminal
$ dart2aot main.dart main.dart.aot
```

The command takes two arguments:

* The location of the file that contains the main entrypoint of the program (typically `main.dart`)
* The filename to use for the tool's output (the compiled program)

To run the compiled program, use the `dartaotruntime` command:

```terminal
$ dartaotruntime main.dart.aot
Hello from Dart.
```

For more information, see [Dart platforms](/platforms).
