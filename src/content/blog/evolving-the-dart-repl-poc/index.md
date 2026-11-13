---
# title: "Evolving the Dart REPL PoC"
title: "Dart REPL 概念验证的演进"
# description: "Hacking with Dart"
description: "用 Dart 动手折腾"
ai-translated: true
publishDate: 2017-04-19
author: BlackHC
image: images/0VisHHMp_ARvFA08w.webp
category: deep-dive
layout: blog
---


<DashImage src="images/0VisHHMp_ARvFA08w.webp" alt="Flutter logo." />


The [Dart REPL](https://github.com/BlackHC/dart_repl) allows you to evaluate Dart expressions and statements in an [interactive shell](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop). It has been awhile since [my first post about the Dart REPL](/blog/a-dart-repl-poc) (you don’t need to read it to enjoy this post), and lots of features are still missing. In particular, dynamic imports and support for top-level declarations would be very useful, so let’s look into how to support them.

[Dart REPL](https://github.com/BlackHC/dart_repl) 让你可以在
[交互式 shell](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop)
里求值 Dart 表达式和语句。
距离[我第一篇关于 Dart REPL 的文章](/blog/a-dart-repl-poc)
已经过去一段时间了（不读那篇也不影响阅读本文），
而且还有很多特性缺失。
特别是动态导入和对顶层声明（top-level declarations）的支持会非常有用，
让我们看看如何支持它们。

*Disclaimer: I do work for Google, but this post is about a personal project. I’m not on the Dart team or related. This article only contains my humble personal opinion.*

*免责声明：我确实在 Google 工作，但本文讲的是一个个人项目。
我不在 Dart 团队，也没有相关关联。本文只包含我个人的浅见。*

**tl;dr**: Code and instructions on how to run the Dart REPL can be found at [https://github.com/BlackHC/dart_repl](https://github.com/BlackHC/dart_repl).

**太长不看（tl;dr）**：Dart REPL 的代码和运行说明见
[https://github.com/BlackHC/dart_repl](https://github.com/BlackHC/dart_repl)。

<DashImage src="images/0pmcEIyli_y3CLPCi.webp" alt="Deadpool meme with the text 'Lets get this party started'." />


## Hot reload

## 热重载

For [Flutter](https://flutter.io/), a cool new feature has been added to the Dart VM: [**hot reload**](https://github.com/flutter/flutter/wiki/Hot-Reload). There is an entertaining YouTube clip from the Dart DevSummit that explains and shows it in detail:

为了 [Flutter](https://flutter.io/)，Dart VM 新增了一个很酷的特性：
[**热重载（hot reload）**](https://github.com/flutter/flutter/wiki/Hot-Reload)。
Dart DevSummit 上有一段有趣的 YouTube 视频，详细解释并演示了它：

<YoutubeEmbed id="iPlPk43RbpA" title="Flutter Hot Reload (Dart Developer Summit 2016)" fullwidth="true"/>


Hot reload allows you to change your code while your program is running. The Dart VM will pick up the changes you’ve made and try to apply them while keeping everything running. And if it can’t, it will tell you why. This is very cool! In the spirit of hacking Dart to do great things, let us ponder how we can use this to implement the new features.

热重载允许你在程序运行时修改代码。
Dart VM 会拿到你的修改，并尝试在保持程序运行的同时应用它们。
如果做不到，它会告诉你原因。这非常酷！
本着用 Dart 折腾出好东西的精神，
让我们想想如何用它来实现新特性。

### Why can’t we import new libraries in the current version of the REPL?

### 为什么当前版本的 REPL 不能导入新库？

The REPL uses Dart’s VM service to evaluate expressions. Sadly, importing a library is not expression in Dart, so we can’t just evaluate it in that context. However, we can change the code of the REPL’s sandbox while it is running to import a new library and then we could just trigger a hot reload to update the REPL. Does this work? It actually does \o/

REPL 使用 Dart 的 VM 服务来求值表达式。
遗憾的是，在 Dart 中导入库不是表达式，
所以我们不能直接在那个上下文里求值它。
不过，我们可以在 REPL 的沙箱（sandbox）运行时修改它的代码来导入新库，
然后只需触发一次热重载来更新 REPL。这行得通吗？还真行 \o/

<DashImage src="images/13Zj7w3g1jNI_SXtkvM8-Lg.webp" alt="An animated terminal showing the Dart REPL executing code with runtime imports." caption="Dart REPL with runtime imports" />


But wait: another thing that we can’t do by evaluating expressions via the VM service is creating new classes and functions. In fact, none of Dart’s top-level declarations can be executed by evaluating an expression for this reason.

但等等：通过 VM 服务求值表达式还做不到另一件事——
创建新的类和函数。事实上，正因如此，
Dart 的任何顶层声明都无法通过求值表达式来执行。

## How can we allow top-level declarations?

## 如何支持顶层声明？

Of course, we could use the same idea described above to also add a new class or a global function. However, anyone who has used IPython or similar for a while knows that you tend to redeclare the same class or function frequently as you iterate on the code. You re-execute slightly modified versions of the same code over and over again while you play around with it.

当然，我们可以用上面描述的同样思路来添加新类或全局函数。
不过，用过 IPython 或类似工具一段时间的人都知道，
在迭代代码时你往往会频繁地重新声明同一个类或函数。
把玩代码时，你会一遍又一遍地重新执行同一段代码的略微修改版。

If we were to just add these declarations to our sandbox Dart library, it would require us to keep tab of what has been declared when and where in the file in order to update the declaration when you iterate on it. This requires a lot of logic and clever code. Sadly, it would also break easily if a change to a class were to break compatibility with older code or other declarations. This would keep the REPL from hot reloading and would force the user to restart it :( This sounds complex and brittle: not a winning combination, I think!

如果只是把这些声明加进我们的沙箱 Dart 库，
我们就得记录什么声明在什么时候加到了文件的什么位置，
以便在你迭代时更新声明。这需要大量逻辑和巧妙的代码。
更糟的是，如果对类的修改破坏了与旧代码或其他声明的兼容性，
它也很容易崩掉。这会让 REPL 无法热重载，迫使用户重启它 :(
这听起来既复杂又脆弱：我觉得这可不是制胜组合！

<DashImage src="images/0JRC_8ZBdApr8CNWF.webp" alt="Meme text asking, 'Why you have to go and make things so complicated?'" />


### Spike & chains

### Spike 与链

Instead, what if we could redefine the same top-level declaration multiple times without the redeclarations ever colliding? Is that even possible in Dart? You bet it is! But not within the same library :) Dart allows you to import a library and then declare a class, function or global variable that shadows an existing declaration.

换个思路，如果我们能多次重新定义同一个顶层声明，
而重新声明之间永远不会冲突呢？这在 Dart 里可能吗？
当然可能！但不能在同一个库里 :)
Dart 允许你导入一个库，然后声明一个
遮蔽（shadow）已有声明的类、函数或全局变量。

```dart
class MyClass {
  static final value = 1;
}
```

```dart
import ‘a.dart’;

class MyClass {
  static final value = 10;
}
```

In this example, there will be no complaints about `b.dart`’s `MyClass` shadowing `a.dart`’s version because they live in different libraries and the local declaration in `b.dart` has precedence over the one imported from `a.dart`.

在这个例子中，不会有对 `b.dart` 的 `MyClass`
遮蔽 `a.dart` 版本的抱怨，因为它们位于不同的库中，
而 `b.dart` 里的本地声明优先于从 `a.dart` 导入的那个。

In general, shadowing is what happens when you declare a variable that hides another variable from an outer scope. For example:

一般来说，遮蔽（shadowing）是指你声明的变量
隐藏了外层作用域中的另一个变量。例如：

```dart
float a;

void func() {
  float a;  // This `a` shadows global `a`.
}
```

Can we use this? To investigate it, I have implemented a quick spike [here](https://github.com/BlackHC/dart_repl/tree/master/spikes/import_spike). It doesn’t generate any code. Rather, it is a very dumb example to make sure that what we think will work actually works. It would be frustrating to spend a lot of time on implementing this using code generation only to find out that it could have never worked! This is the gist of it:

我们能利用这一点吗？为了研究它，我在
[这里](https://github.com/BlackHC/dart_repl/tree/master/spikes/import_spike)
实现了一个快速 spike。它不生成任何代码，
只是一个非常笨的例子，用来确认我们认为可行的东西真的可行。
花大量时间用代码生成实现它，最后却发现根本行不通，
那可就太令人沮丧了！它的要点如下：

```dart
class A {
  int f() => 1;
}
```

```dart
import 'import_1.dart';
export 'import_1.dart';

class A {
  int f() => 2;
}
```

```dart
import 'import_2.dart';

void main() {
  result = new A().f();
  print(result);
}
```

This works indeed! We can create a chain of libraries that import each other (and also export each other because otherwise the symbols will not be available everywhere). Then the users can redefine symbols as often as they want. Obviously, this can result in old code referring to shadowed symbols, which might make things slightly confusing, but at least it won’t break. And anybody who has used IPython or similar has learnt to live with it, too. It can’t be that bad.

这确实可行！我们可以创建一条相互导入的库链
（还要相互导出，否则符号无法处处可用）。
然后用户想重新定义符号多少次都可以。
显然，这可能导致旧代码引用被遮蔽的符号，稍微有点混乱，
但至少不会崩。用过 IPython 或类似工具的人也都学会了与之共处。
应该没那么糟。

<DashImage src="images/1jjpANyPKXUIge1JcUA3WSQ.webp" alt="A diagram showing how top-level declarations are shadowed across multiple Dart libraries." />


The diagram above shows how it works: as we add new top-level declarations, new “cells” (Dart libraries) are created which import (and export) the previous cell. The final cell is imported in the sandbox library that is used as execution environment for normal Dart expressions and statements. The sandbox file is edited in-place and then reloaded using hot reload.

上图展示了它的工作方式：当我们添加新的顶层声明时，
会创建新的“单元（cell）”（Dart 库），它导入（并导出）上一个单元。
最后一个单元被导入沙箱库，
沙箱库用作普通 Dart 表达式和语句的执行环境。
沙箱文件被就地修改，然后通过热重载重新加载。

### A workflow vision

### 一个工作流愿景

Moreover, if you want to update code continuously without shadowing anything, that is still possible, too: hot reload already allows for this workflow in normal Dart programs. You can do the same in the REPL. You can edit your amazing Dart library `amazing_dart_library.dart` and import it into REPL, play around with it, and while you do so, you can edit the code in your editor of choice and have the REPL hot reload the code when you want by calling `reload()`. The best of both worlds \o/

此外，如果你想持续更新代码而不遮蔽任何东西，也仍然可行：
热重载在普通 Dart 程序中已经支持这种工作流。
你在 REPL 里也可以这么做。
你可以编写你那了不起的 Dart 库 `amazing_dart_library.dart`
并把它导入 REPL，把玩它；与此同时，
你可以在你喜欢的编辑器里改代码，
想什么时候让 REPL 热重载代码，就调用 `reload()`。两全其美 \o/

## How can we implement this in practice?

## 实践中如何实现？

<DashImage src="images/0lKzRhG-9uyW5eLvq.webp" alt="Philosoraptor meme asking, 'What if this topic is too complex to be represented in a single meme?'" />


Well, we are hacking Dart here, so let’s see: Hot reload is not supported by the [`vm_service_client`](https://pub.dartlang.org/packages/vm_service_client) yet since it is such a new feature and the [service specification](https://github.com/dart-lang/sdk/blob/master/runtime/vm/service/service.md) is not totally complete yet. I started writing [a pull request](https://github.com/dart-lang/vm_service_client/pull/14) for Natalie (the maintainer) to add support for it, but really, as my coworkers know: production quality code is not my thing, especially not in my spare time (sorry Natalie!). However, this does not block our hacking adventure.

好吧，我们是在折腾 Dart，那就看看：
[`vm_service_client`](https://pub.dartlang.org/packages/vm_service_client)
还不支持热重载，因为这个特性太新了，而且
[服务规范](https://github.com/dart-lang/sdk/blob/master/runtime/vm/service/service.md)
也还不完全。我开始给维护者 Natalie 写
[一个 pull request](https://github.com/dart-lang/vm_service_client/pull/14)
来添加支持，但说真的，我的同事都知道：
生产级代码不是我的强项，业余时间尤其如此（抱歉 Natalie！）。
不过，这并不妨碍我们的折腾之旅。

[pub](https://pub.dartlang.org/), Dart’s package management system, not only supports automatic version constraint resolution and a centralized repository of packages, it also allows you [to use local packages or to depend directly on GitHub](https://www.dartlang.org/tools/pub/dependencies) . This is usually not advisable because you lose much of what makes pub great, but here it works: I simply forked `vm_service_client` into my own GitHub clone and made the necessary changes. You can find the code at [https://github.com/BlackHC/vm_service_client/tree/reload_sources_poc](https://github.com/BlackHC/vm_service_client/tree/reload_sources_poc). Afterwards, I changed the Dart REPL’s `pubspec.yaml` to link to my GitHub clone instead of the official version:

Dart 的 package 管理系统 [pub](https://pub.dartlang.org/)
不仅支持自动的版本约束解析和集中的 package 仓库，
还允许你[使用本地 package 或直接依赖 GitHub](https://www.dartlang.org/tools/pub/dependencies)。
通常不建议这么做，因为你会失去 pub 的许多优点，但在这里行得通：
我直接把 `vm_service_client` fork 到我自己的 GitHub 克隆并做了必要的修改。
代码在
[https://github.com/BlackHC/vm_service_client/tree/reload_sources_poc](https://github.com/BlackHC/vm_service_client/tree/reload_sources_poc)。
然后，我修改了 Dart REPL 的 `pubspec.yaml`，
让它指向我的 GitHub 克隆而不是官方版本：

```yaml
[...]
  vm_service_client:
    git:
      url: git://github.com/BlackHC/vm_service_client.git
      ref: reload_sources_poc
[...]
```

And that’s it! A simple`pub get`in the terminal now updates the Dart REPL to use the forked version.

就这样！在终端里跑一个简单的 `pub get`，
Dart REPL 就会改用 fork 的版本。

This makes it really easy to experiment with anything: you can fork other packages to try things out and easily depend on them. And the cool thing is, I can publish this and when you download the REPL for yourself using pub, it will grab the code from GitHub, too. Very hackable yet shareable! (Even if it’s not advisable for production packages in general :)

这让任何实验都变得非常容易：
你可以 fork 其他 package 来尝试新东西，并轻松依赖它们。
更酷的是，我可以把它发布出去，当你用 pub 下载这个 REPL 时，
它也会从 GitHub 拉取代码。既能随意折腾又能分享！
（尽管对生产用的 package 一般不建议这么做 :)

The main bit of juicy logic is the cell generator that implements a very simple templating mechanism in line with what we’ve discussed above:

最主要的核心逻辑是单元生成器，
它按照我们上面讨论的思路实现了一个非常简单的模板机制：

```dart
import 'dart:io';

class DartTemplate {
  final String content;

  DartTemplate(this.content);

  void instantiate(String targetPath,
      {String source, String library, String imports}) {
    final instanceSource = content
        .replaceAll('/*{SOURCE}*/', source ?? '')
        .replaceAll('/*{IMPORTS}*/', imports ?? '')
        .replaceAll('/*{LIBRARY}*/', library ?? '');
    new File(targetPath).writeAsStringSync(instanceSource);
    //print('wrote $targetPath:\n$instanceSource');
  }
}

/// Keeps a chain of temporary cell files that import and re-export each other.
/// This allows us to create top-level cells that contains classes and other
/// top-level decls that can shadow each other.
class TopLevelCellChain {
  final DartTemplate cellTemplate;
  final String headName;
  final String basePath;

  int _currentCellIndex = 0;

  TopLevelCellChain(this.cellTemplate, this.headName, this.basePath);

  String get currentCellPath => '$basePath/$currentCellName';
  String get currentCellName => 'cell${_currentCellIndex}.dart';
  String get headPath => '$basePath/$headName';

  void addCell(String source) {
    // Import and export the previous cell.
    final imports = _currentCellIndex > 0
        ? '''
// Import the previous cell and export it to make its symbols available to the
// next cell.
import '$currentCellName';
export '$currentCellName';
'''
        : '';

    _currentCellIndex++;
    cellTemplate.instantiate(currentCellPath, imports: imports, source: source);

    // Update the sandbox.
    refreshSandboxLibrary();
  }

  void refreshSandboxLibrary() {
    var libraryStatement = '''
/// This library name is needed to find the library using reflection.
library sandbox;
''';

    cellTemplate.instantiate(headPath,
        imports: _currentCellIndex > 0 ? 'import \'$currentCellName\';' : '',
        library: libraryStatement);
  }

  void undoCell() {
    if (_currentCellIndex > 0) {
      _currentCellIndex--;
    }
    refreshSandboxLibrary();
  }
}
```

The hot reload feature is called from the REPL when a new import is needed:

需要新的 import 时，REPL 会调用热重载特性：

```dart
Future linkAndExecuteCell(SandboxIsolate sandboxIsolate, String input,
    VMRunnableIsolate runnableIsolate) async {
  sandboxIsolate.cellChain.addCell(input);
  final report = await runnableIsolate.reloadSources();
  if (!report.status) {
    print(report.message);
    // Undo the last cell, so we can try again.
    sandboxIsolate.cellChain.undoCell();
  }
}
```

And that’s pretty much it! You can have a look at all the changes in the pull request: [https://github.com/BlackHC/dart_repl/pull/2](https://github.com/BlackHC/dart_repl/pull/2).
I admit the code is a bit hacky and untidy. There is also quite a bit of unrelated wrapper code for message passing between the REPL and the sandbox in the pull request. This sadly obfuscates the main changes a bit. I need to see how we can refactor all this to make it neater and tidier again… but sometimes, it’s just easier to get things running quickly than writing the best code and pull requests. Sorry about that!

基本就是这样！你可以在 pull request 里看到所有改动：
[https://github.com/BlackHC/dart_repl/pull/2](https://github.com/BlackHC/dart_repl/pull/2)。
我承认代码有点 hacky、不太整洁。
pull request 里还有不少与主题无关的包装代码，
用于 REPL 和沙箱之间的消息传递。这遗憾地让主要改动有点难以看清。
我得看看怎么重构这一切，让它重新变得干净整洁……
但有时候，先让东西跑起来比写出最好的代码和 pull request 更容易。
抱歉啦！

<DashImage src="images/1lR3fQGmW9Bjxtcxy-mJsjg.webp" alt="An animated terminal demonstrating the Dart REPL with top-level declarations." caption="Dart REPL with top-level declarations" />


The Dart REPL’s source can be found at [https://github.com/BlackHC/dart_repl](https://github.com/BlackHC/dart_repl). In addition to supporting top-level declarations, I have also added support for built-in`import`, `loadPackage` and `reload` commands. (Please note: `loadPackage` requires the soon-to-be-released 1.24 dev builds of the Dart SDK. It’s a no-op right otherwise.) These built-in commands are all trivial extensions that use hot reload. Finally, to load new packages from your local pub cache, I’m using the excellent [`pub_cache`](https://github.com/dart-lang/pub_cache) package.

Dart REPL 的源码在
[https://github.com/BlackHC/dart_repl](https://github.com/BlackHC/dart_repl)。
除了支持顶层声明，我还添加了对内置 `import`、`loadPackage`
和 `reload` 命令的支持。
（请注意：`loadPackage` 需要即将发布的 Dart SDK 1.24 dev 版本，
否则它什么都不做。）这些内置命令都是使用热重载的简单扩展。
最后，为了从你本地的 pub 缓存加载新 package，
我用了出色的 [`pub_cache`](https://github.com/dart-lang/pub_cache) package。

To give it a go (and assuming you have installed the Dart SDK), just run:

想试一试的话（假设你已经安装了 Dart SDK），只需运行：

```
pub global activate dart_repl
pub global run dart_repl
```


Thanks for making it to the end of this article! Please let me know what you think :)

感谢你读到最后！请告诉我你的想法 :)

Cheers,
Andreas

祝好，
Andreas
