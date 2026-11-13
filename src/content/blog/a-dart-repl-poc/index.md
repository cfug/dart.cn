---
# title: "A Dart REPL PoC"
title: "一个 Dart REPL 概念验证"
# description: "Hacking with Dart"
description: "用 Dart 动手折腾"
ai-translated: true
publishDate: 2017-01-17
author: BlackHC
image: images/0lOBcrb2bYgKV6VYT.webp
category: deep-dive
layout: blog
---


<DashImage src="images/0lOBcrb2bYgKV6VYT.webp" alt="An origami hummingbird in Dart's original color scheme." />


[Python](https://www.python.org/)’s interactive mode is great. [Dart](http://dartlang.org/) does not have an interactive mode at the moment, but it is really good for prototyping ideas quickly, so let’s see if we can hack something together!

[Python](https://www.python.org/) 的交互模式（interactive mode）非常棒。
[Dart](http://dartlang.org/) 目前还没有交互模式，
但它非常适合快速把想法做成原型，
所以让我们看看能不能动手攒一个出来！

*Disclaimer: I do work for Google, but this post is about a personal project. I’m not on the Dart team or related. This is just my humble opinion and my story. Come along.*

*免责声明：我确实在 Google 工作，但本文讲的是一个个人项目。
我不在 Dart 团队，也没有相关关联。
这只是我的个人浅见和我自己的故事。一起来看看吧。*

The interactive mode in languages like Python or Ruby has helped make them very approachable for beginners. But these are not the only ones that use the concept of a [REPL](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop). A REPL is a read-eval-print loop. Shells like BASH or zsh also employ REPLs when you interact with them in a terminal. It is also what you get when you work with notebooks in [Jupyter](http://jupyter.org/) (IPython Notebooks), [Matlab](https://www.mathworks.com/products/matlab.html), [Mathematica](https://www.wolfram.com/mathematica/) or [Maple](https://www.maplesoft.com/products/maple/). This way of interactive computing is very popular with researchers.

Python 或 Ruby 这类语言的交互模式让它们对初学者非常友好。
但使用 [REPL](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop)
概念的并不只有它们。REPL 即读取-求值-打印循环（read-eval-print loop）。
像 BASH 或 zsh 这样的 shell，当你在终端里与它们交互时，用的也是 REPL。
在 [Jupyter](http://jupyter.org/)（IPython Notebooks）、
[Matlab](https://www.mathworks.com/products/matlab.html)、
[Mathematica](https://www.wolfram.com/mathematica/)
或 [Maple](https://www.maplesoft.com/products/maple/)
里使用 notebook 时，得到的也是 REPL。
这种交互式计算方式在研究人员中非常流行。

This is what Python’s interactive mode looks like:

Python 的交互模式长这样：

<DashImage src="images/1sqspbSjstPhKIsIbZBDq-Q.webp" alt="A user interacts with the Python REPL." caption="Good ol’ Python REPL" />


Dart does not support evaluating statements in a global scope like Python, so there is no obvious way to do it correctly. In Dart, statements have to be inside functions and the main function is the entry point of a program. Just like in C++ or C#. Personally, I prefer this as it makes it easier to figure out what is happening when a program runs. But… I’d still really want an interactive mode. It would allow me to play around with ideas and try things out even faster. So let’s see if we can create a REPL as a proof of concept!

Dart 不支持像 Python 那样在全局作用域里求值语句，
所以没有显而易见的正确做法。在 Dart 中，语句必须放在函数里，
而 main 函数是程序的入口点，就像 C++ 或 C# 一样。
就我个人而言，我更喜欢这种方式，
因为它让程序运行时发生的事情更容易弄清。
但是……我仍然非常想要一个交互模式。
它能让我更快地把玩想法、尝试各种东西。
那么，让我们看看能否做一个 REPL 的概念验证（proof of concept）！

## How can we create a REPL in dart?

## 如何在 Dart 中创建 REPL？

Dart is really good for prototyping. So let’s do just that and not get bogged down by language design questions :)

Dart 非常适合做原型。那我们就直接动手，
别陷入语言设计问题的泥潭 :)

Now there is no `eval` function like in JavaScript or Python, and I don’t want to write a full blown interpreter myself to implement one. It wouldn’t be very fast and I don’t have a lot of time either. However, when you debug [Dart code in Intellij](https://www.dartlang.org/tools/jetbrains-plugin), you can evaluate expressions while you step through your code. Evaluating expressions is very much what we’d like to do, isn’t it? Can we use this feature?

Dart 没有像 JavaScript 或 Python 那样的 `eval` 函数，
而我也不想自己写一个完整的解释器来实现它。
那样既不会很快，我也没那么多时间。
不过，当你在 [Intellij 里调试 Dart 代码](https://www.dartlang.org/tools/jetbrains-plugin)时，
可以在单步执行代码的同时求值表达式。
求值表达式正是我们想做的事情，不是吗？能不能利用这个特性？

Dart’s debugging capabilities are exposed through its [VM service](https://github.com/dart-lang/sdk/blob/master/runtime/vm/service/service.md). It is an JSON-RPC service provided by the [Dart VM](https://www.dartlang.org/dart-vm) that you can connect to to debug your application. [Natalie Weizenbaum](https://twitter.com/nex3) has published an article about the `vm_service_client` package that provides a very nice API to interact with the VM service: [http://news.dartlang.org/2016/05/unboxing-packages-vmserviceclient.html](http://news.dartlang.org/2016/05/unboxing-packages-vmserviceclient.html)

Dart 的调试能力通过它的
[VM 服务（VM service）](https://github.com/dart-lang/sdk/blob/master/runtime/vm/service/service.md)暴露出来。
这是由 [Dart VM](https://www.dartlang.org/dart-vm) 提供的一个 JSON-RPC 服务，
你可以连接它来调试你的应用。
[Natalie Weizenbaum](https://twitter.com/nex3) 发表过一篇文章，
介绍 `vm_service_client` package——
它提供了与 VM 服务交互的非常好的 API：
[http://news.dartlang.org/2016/05/unboxing-packages-vmserviceclient.html](http://news.dartlang.org/2016/05/unboxing-packages-vmserviceclient.html)

Now what we can do is: our REPL can connect to its own VM service to evaluate expressions that it reads from the terminal! That sounds crazy…

现在我们能做的是：让 REPL 连接它自己的 VM 服务，
来求值它从终端读到的表达式！这听起来很疯狂……

<DashImage src="images/0wtt2rUBIRxHnPUHv.webp" alt="Person smiling while holding a banana, overlaid with the text 'You are so crazy lol'." />


… but it works! I have written a [quick spike](https://github.com/BlackHC/dart_repl/blob/ca3518074c94f48ce5be872b15b58556133a474c/bin/repl.dart) and indeed it works. Dart supports [asynchronous programming](https://www.dartlang.org/tutorials/language/futures), which comes in really handy as it keeps the program from blocking itself when talking to its own VM service.
> # Spikes are a concept from test-driven development: they are quick and dirty experiments one writes to figure out some technical questions.

……但它真的能跑！我写了一个
[快速 spike](https://github.com/BlackHC/dart_repl/blob/ca3518074c94f48ce5be872b15b58556133a474c/bin/repl.dart)，它确实可以工作。
Dart 支持[异步编程](https://www.dartlang.org/tutorials/language/futures)，
这在这里非常顺手：它让程序在与自己的 VM 服务通信时不会把自己阻塞住。

> # Spike 是测试驱动开发中的一个概念：
> 为了弄清某些技术问题而写的快速而粗糙的实验。

With the question of feasibility settled, it is easy to write a proper proof of concept. To evaluate expressions that go beyond `1 + 1`, we need to support variables. Now variables cannot easily be created because a variable declaration is not an expression in Dart. In Python, you can just declare a variable on the fly by assigning to it. In Dart, we can simulate dynamic fields by overloading `n[oSuchMethod](https://www.dartlang.org/articles/language/emulating-functions#interactions-with-mirrors-and-nosuchmethod)` to create elements in a dictionary on the fly. I call this class `Scope` and when we [evaluate expressions within an instance](https://www.dartdocs.org/documentation/vm_service_client/0.2.3/vm_service_client/VMInstanceRef/evaluate.html) of it, the fields can be accessed like globals.

可行性问题解决之后，写一个像样的概念验证就容易了。
要求值超出 `1 + 1` 的表达式，我们需要支持变量。
而变量并不好创建，因为在 Dart 中变量声明不是表达式。
在 Python 里，你可以直接给变量赋值来随时声明它。
在 Dart 中，我们可以通过重载
[noSuchMethod](https://www.dartlang.org/articles/language/emulating-functions#interactions-with-mirrors-and-nosuchmethod)
来模拟动态字段，随时在字典里创建元素。
我把这个类叫作 `Scope`，当我们
[在它的实例中求值表达式](https://www.dartdocs.org/documentation/vm_service_client/0.2.3/vm_service_client/VMInstanceRef/evaluate.html)时，
这些字段就可以像全局变量一样访问。

<DashImage src="images/02PUDlyPF7rchkNmA.webp" alt="Confused person holding their head, overlaid with the text 'What do these words mean'." />


The code is actually more straight-forward:

代码其实更直白：

```dart
// Copyright (c) 2016, Andreas 'blackhc' Kirsch. All rights reserved. Use of 
// this source code is governed by a BSD-style license that can be found in the 
// LICENSE file.
import 'dart:mirrors';

Scope currentScope;

@proxy
class Scope {
  final _scope = <Symbol, dynamic>{};

  Scope();

  Scope.predefined(Map<Symbol, dynamic> symbols) {
    _scope.addAll(symbols);
  }

  factory Scope.clone(Scope other) => new Scope.predefined(other._scope);

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.isGetter) {
      if (_scope.containsKey(invocation.memberName)) {
        return _scope[invocation.memberName];
      } else {
        return super.noSuchMethod(invocation);
      }
    } else if (invocation.isSetter) {
      final variable = MirrorSystem.getSymbol(
          MirrorSystem.getName(invocation.memberName).split('=').first);
      _scope[variable] = invocation.positionalArguments.first;
      return null;
    } else if (invocation.isMethod) {
      return Function.apply(_scope[invocation.memberName] as Function,
          invocation.positionalArguments, invocation.namedArguments);
    } else {
      throw new UnsupportedError('Neither setter, nor getter, nor method!');
    }
  }

  @override
  String toString() => _scope.toString();
}
```

With this, we can already do stuff like `a = 3`and `b = a*3`:

有了它，我们已经可以做 `a = 3` 和 `b = a*3` 这样的事情了：

<DashImage src="images/12tDjwpxSxslDUfiv8enwow.webp" alt="A user evaluates simple expressions in the Dart REPL." caption="Simple expressions: DONE" />


One limitation, we quickly run into is, that we can only access symbols that have been imported in the file that declares the `Scope` class. `import ‘…’;` cannot be evaluated using the VM service. So no `dart:io` if we don’t import it explicitly, and no custom libraries :(

我们很快遇到的一个限制是：只能访问在声明 `Scope` 类的文件里
已经导入的符号。`import ‘…’;` 无法通过 VM 服务求值。
所以如果不显式导入就用不了 `dart:io`，自定义库也不行 :(

Oh wait! Dart can spawn new isolates (independent workers) using a URI with [Isolate.spawnUri](https://api.dartlang.org/stable/1.21.1/dart-isolate/Isolate/spawnUri.html). Users could specify additional imports on the command-line, and the REPL could generate source code to include these imports and then spawn a new isolate using the generated code that has the imports available for the user.

哦等等！Dart 可以用 URI 通过
[Isolate.spawnUri](https://api.dartlang.org/stable/1.21.1/dart-isolate/Isolate/spawnUri.html)
派生新的 isolate（独立的工作单元）。
用户可以在命令行指定额外的 import，
REPL 可以生成包含这些 import 的源代码，
然后用生成的代码派生一个新的 isolate，
让用户可以使用这些导入。

<DashImage src="images/0bgs2vFlKPkZsFbSO.webp" alt="Person leaning forward in conversation, overlaid with the text 'That's not enough. We have to go deeper'." />


And it works \o/

而且它真的能跑 \o/

<DashImage src="images/1eh9q0mNToXK0R_QiYdrylw.webp" alt="A user successfully imports custom libraries in the Dart REPL." caption="Custom imports: DONE" />


## Supporting more Dart

## 支持更多 Dart 语法

Now another issue is that we only can evaluate expressions. Control statements like `if/else` blocks or `while` loops are not expressions. For statements, we could wrap them in a closure and execute the closure, which is a function call expression. Thus, `if (a == 1) print('a is 1!!');` would become

另一个问题是，我们只能求值表达式。
像 `if/else` 块或 `while` 循环这样的控制语句不是表达式。
对于语句，我们可以把它们包进一个闭包里再执行这个闭包，
而闭包调用是一个函数调用表达式。
于是，`if (a == 1) print('a is 1!!');` 就会变成

```
() { if (a == 1) print('a is 1!!'); }();
```


We just need to figure out if the input is an expression or a statement. This is difficult because we’d have to write a Dart parser for this. But Dart is written in Dart, and the [`analyzer`](https://pub.dartlang.org/packages/analyzer) package provides a parser that can parse any Dart code for free!

我们只需要判断输入是表达式还是语句。
这有点难，因为为此我们得写一个 Dart 解析器。
但 Dart 是用 Dart 写的，而且
[`analyzer`](https://pub.dartlang.org/packages/analyzer) package
免费提供了一个能解析任何 Dart 代码的解析器！

```dart
// Copyright (c) 2016, Andreas 'blackhc' Kirsch. All rights reserved. Use of 
// this source code is governed by a BSD-style license that can be found in the 
// LICENSE file.
import 'dart:io';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/src/dart/scanner/reader.dart';
import 'package:analyzer/src/dart/scanner/scanner.dart';
import 'package:analyzer/src/generated/parser.dart';

bool _tryParse(String code, Function parse) {
  final reader = new CharSequenceReader(code);
  final errorListener = new BooleanErrorListener();
  final scanner = new Scanner(null, reader, errorListener);
  final token = scanner.tokenize();
  final parser = new Parser(null, errorListener);
  final node = parse(parser, token) as AstNode;

  return !errorListener.errorReported &&
      node != null &&
      node.endToken.next.type == TokenType.EOF;
}

bool isExpression(String code) => _tryParse(
    code, (Parser parser, Token token) => parser.parseExpression(token));

bool isStatements(String code) => _tryParse(code, (Parser parser, Token token) {
      final statements = parser.parseStatements(token);
      if (statements.isEmpty) {
        return null;
      }
      return statements.last;
    });
```

And thus, that is also solved.

于是，这个问题也解决了。

<DashImage src="images/1uemGA2TzYypx2RmooQfwmg.webp" alt="A user evaluates both statements and expressions in the Dart REPL." caption="Statements and expressions: DONE" />


## More imports

## 更多 import

The last bit that keeps us from importing just any library is that by default a new Isolate only sees the packages that are mentioned in its `pubspec.yaml`. We want to support importing any library though. `Isolate.spawnUri` has a `packageConfig` parameter that allows us to specify a map from package name to package path. We can just use another command-line parameter to target another package and use its package config in our Isolate. Woohoo!

阻碍我们导入任意库的最后一点是：默认情况下，
新的 isolate 只能看到它自己的 `pubspec.yaml` 里提到的 package。
但我们想支持导入任何库。`Isolate.spawnUri` 有一个 `packageConfig` 参数，
允许我们指定从 package 名到 package 路径的映射。
我们只需再用一个命令行参数指向另一个 package，
并在我们的 isolate 里使用它的 package 配置。呜呼！

We quickly run into the problem that our Isolate needs to access the `analyzer` package (and others) that might not be loaded by whatever package you want to toy around with in your REPL session. Package [`package_resolver`](https://pub.dartlang.org/packages/package_resolver) to the rescue! With it, we can easily manipulate package configurations.

我们很快又遇到问题：我们的 isolate 需要访问 `analyzer` package
（以及其他一些），而你想在 REPL 会话里把玩的那个 package
未必加载了它们。
[`package_resolver`](https://pub.dartlang.org/packages/package_resolver) package 来救场！
有了它，我们可以轻松操纵 package 配置。

```dart
import 'package:package_resolver/package_resolver.dart';

Future<PackageResolver> mergePackageConfigs(String otherPackageRoot) async {
  final currentConfig = await PackageResolver.current.packageConfigMap;
  final otherConfig =
      (await SyncPackageResolver.loadConfig(otherPackageRoot + '/.packages'))
          .packageConfigMap;
  // We do something horrible here: We simply merge the current config with
  // the other. Hoping it will still work..
  final config = <String, Uri>{};
  config.addAll(currentConfig);
  config.addAll(otherConfig);
  return new PackageResolver.config(config);
}
```

With all this, we have a full workflow implemented:

有了这一切，我们就实现了一个完整的工作流：

<DashImage src="images/1KKIJauKlylkVMaLvhJQq9w.webp" alt="A user imports a library from another package in the Dart REPL." caption="Import any library from another package: DONE" />


## What’s next?

## 接下来做什么？

This was a long post… The whole proof of concept clocks in at **451 lines of code**, so almost as long as this post.

这是一篇长文……整个概念验证总共 **451 行代码**，
几乎和这篇文章一样长。

<DashImage src="images/0Xn430bpRfeDmM9uF.webp" alt="Grumpy Cat meme with the text 'THE END IS NEAR - GOOD'." />


The code can be found on [https://github.com/BlackHC/dart_repl](https://github.com/BlackHC/dart_repl/tree/master/lib). You can give it a go easily if you have Dart installed:

代码在
[https://github.com/BlackHC/dart_repl](https://github.com/BlackHC/dart_repl/tree/master/lib)。
如果你安装了 Dart，可以轻松试一试：

```
pub global activate dart_repl
pub global run dart_repl
```


I really enjoyed creating this proof of concept in my spare time. All the pieces just fell into place within a couple of hours. IDE support for Dart in IntelliJ is excellent, and there are a ton of documentation and articles around now. Check out [Natalie Weizenbaum](https://twitter.com/nex3)’s Unboxing Packages series for example: [http://news.dartlang.org/2016/04/unboxing-packages-async-part-3.html](http://news.dartlang.org/2016/04/unboxing-packages-async-part-3.html) et al. Low-level hacking in Dart is fun, and there are great libraries to get creative with. [`code_builder`](https://github.com/dart-lang/code_builder) is looking very promising and [`built_collection`](https://github.com/google/built_collection.dart) is providing immutable collections. [David Morgan](https://twitter.com/__davidmorgan__) has also been publishing articles on [immutable collections](/blog/darts-built-collection-for-immutable-collections) in Dart.

我非常享受在业余时间创建这个概念验证的过程。
所有部件在几个小时内就各就各位。
IntelliJ 对 Dart 的 IDE 支持非常出色，
现在也有大量的文档和文章。
比如可以看看 [Natalie Weizenbaum](https://twitter.com/nex3) 的
Unboxing Packages 系列：
[http://news.dartlang.org/2016/04/unboxing-packages-async-part-3.html](http://news.dartlang.org/2016/04/unboxing-packages-async-part-3.html) 等等。
在 Dart 里做底层折腾很有趣，还有很多很棒的库可以发挥创意。
[`code_builder`](https://github.com/dart-lang/code_builder) 看起来非常有前途，
[`built_collection`](https://github.com/google/built_collection.dart) 提供了不可变集合。
[David Morgan](https://twitter.com/__davidmorgan__) 也一直在发表关于
Dart 中[不可变集合](/blog/darts-built-collection-for-immutable-collections)的文章。

For `dart_repl`, it would be nice to import additional libraries at runtime without restarts. The Dart team has recently added support for hot reloading to the VM. This mainly provides a better experience in [Flutter](https://flutter.io/) for mobile app developers. Maybe, this could be used for adhoc imports and for defining functions and classes in the REPL, too.

对 `dart_repl` 来说，如果能在运行时导入额外的库而无需重启就更好了。
Dart 团队最近给 VM 加了热重载（hot reload）支持。
这主要为移动应用开发者在 [Flutter](https://flutter.io/) 中提供更好的体验。
也许，它也可以用来在 REPL 里临时导入，以及定义函数和类。

In general, Dart could be great for research and for researchers, and I would absolutely love to see Jupyter support for Dart. One would only have to implement its kernel interface to make such a Dart REPL compatible with it… :) That should be easy, right?

总的来说，Dart 对科研和研究人员来说可以非常出色，
我非常希望看到 Jupyter 对 Dart 的支持。
只需要实现它的 kernel 接口，就能让这样一个 Dart REPL 与之兼容…… :)
那应该很容易，对吧？

<DashImage src="images/00_DI8nuDDB5VwIbc.webp" alt="Closing meme about the Dart REPL proof of concept with the text 'You Deserve A Cookie'." />
