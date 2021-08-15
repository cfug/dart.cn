---
title: dart run
description: 运行Dart程序的命令行工具.
---

`dart run` 命令支持从文件、当前包或者当前包的依赖中运行Dart程序。该命令提供以前在“pub run”和Dart虚拟机工具提供的功能。

如果想从任意位置运行程序, 可以使用[pub global](/tools/pub/cmd/pub-global) 命令.

```
dart run [options] [<DART_FILE> | <PACKAGE_TARGET>] [args]
```

下面的例子演示了如何创建并且运行一个Dart程序:

```terminal
$ dart create myapp
$ cd myapp
$ dart run
```

{% include tools/dart-tool-note.md %}

## 运行Dart文件

可以通过传入Dart文件的相对路径来运行一个Dart程序：

```terminal
$ dart run tool/debug.dart
```

## 运行包中的Dart程序

本节中的说明假设你在当前Dart包的根目录执行'dart run'命令。
更多关于Dart包目录结构的介绍，请查阅
[package layout conventions](/guides/libraries/create-library-packages).

### 运行依赖包中的Dart程序

你可以运行当前包所依赖的任何包的Dart程序, 只要它在`bin`目录下。运行时请指定依赖的包名和程序名。
如果程序名与包名相同，则可以省略。

例如, 你现在位于包的根目录，想运行依赖包`bar`中的main程序 (`bin/bar.dart`), 那么你可以使用
下面的命令：

```terminal
$ dart run bar
```

如果程序名和包名不同, 则需要使用`<包名>:<程序名>`的形式来运行程序。
比如 `bin/baz.dart`程序在 `bar` 包中, 我们就可以这样运行: 

```terminal
$ dart run bar:baz
```

放在 `bin` 目录下的Dart文件是可以被Dart命令行工具直接访问的, 依赖包中的其他目录都是私有的。

### 在当前包中运行Dart程序

当当前目录与包名匹配时(也就是说，你在的目录与pubspec中的`name`属性匹配)，可以省略包名。如果程序名与包名匹配(也就是说，它是main程序)，也可以省略程序名。

`dart run`是运行Dart程序最短的形式，它运行当前包的主程序。例如，如果你在foo包的根目录，通过下面命令则会运行`bin/foo.dart`文件:

```terminal
$ dart run
```

如果程序名和包名不同, 需要使用`:<程序名>`的形式来运行程序，比如运行当前包中的`bin/baz.dart`文件:

```terminal
$ dart run :baz
```

要运行的程序在当前包，但不在 `bin` 目录时, 通过传递相对路径运行(如前面说的):

```terminal
$ dart run tool/debug.dart
```

## 给 main() 传递参数

[给 `main()` 函数传递参数][args]，只需要在命令行后面添加参数:

```terminal
$ dart run tool/debug.dart arg1 arg2
```

在当前包中运行`main`程序需要添加包名, 比如要传递参数并运行位于`foo`包中的`bin/foo.dart`程序：

```terminal
$ dart run foo arg1 arg2
```

[args]: /guides/language/language-tour#the-main-function

## 调试

可以通过传递一个或者多个调试选项来开启调试功能，下面是一个开启[断言][assert]功能的例子:

```terminal
$ dart run --enable-asserts tool/debug.dart
```

运行 `dart run --help` 获取更多信息.

[assert]: /guides/language/language-tour#assert

## 开启实验性功能

如果在开发中想尝试实验性功能, 可以通过传入 [experiment flags](/tools/experiment-flags) 参数.
