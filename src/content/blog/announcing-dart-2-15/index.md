---
# title: "Announcing Dart 2.15"
title: "宣布 Dart 2.15"
# description: "Fast concurrency, constructor tear-offs, improved enums, and more"
description: "快速并发、构造函数 tear-off、改进的枚举等"
ai-translated: true
publishDate: 2021-12-08
author: mit-mit
image: images/196RfgLO4RYR2ReAs8t6x5w.webp
category: releases
layout: blog
---


Today we’re releasing version 2.15 of the Dart SDK, featuring fast concurrency with worker isolates, a new constructor tear-off language feature, improved enum support in the dart:core library, new features for package publishers, and more.

今天我们发布 Dart SDK 2.15 版本，带来基于工作 isolate
（worker isolates）的快速并发、新的构造函数 tear-off
（constructor tear-off）语言特性、dart:core 库中改进的枚举（enum）支持、
面向 package 发布者的新特性，等等。

<DashImage src="images/196RfgLO4RYR2ReAs8t6x5w.webp" alt="Dart 2.15 release banner highlighting concurrency, constructor tear-offs, and pub tools." />


## Fast concurrency with worker isolates

## 用工作 isolate 实现快速并发

Just about all modern devices have CPUs with multiple cores, capable of running multiple tasks in parallel. For most Dart programs, how these cores are used is transparent to you as a developer: the Dart runtime system by default runs all your Dart code on a single core, but then uses additional cores for executing systems-level tasks such as async input/output, like writing a file or making a network call.

几乎所有现代设备的 CPU 都有多个核心，能够并行运行多个任务。
对大多数 Dart 程序来说，这些核心如何被使用对你作为开发者是透明的：
Dart 运行时系统默认在单个核心上运行你的所有 Dart 代码，
然后用额外的核心执行系统级任务，比如异步输入/输出
——写文件或发起网络调用。

But your Dart code itself may need to run concurrently. For example, you may have a continuous animation and a long-running task such as parsing a large JSON file. If the additional task takes too long, that might cause stutter or lag in the UI. By moving those additional tasks to a separate core, the animation can continue to run on the main thread of execution, uninterrupted.

但你的 Dart 代码本身可能需要并发运行。例如，
你可能有一个持续的动画和一个耗时任务（如解析大型 JSON 文件）。
如果额外任务耗时太久，可能导致 UI 卡顿或延迟。
把这些额外任务移到单独的核心上，
动画就能在主执行线程上不受干扰地继续运行。

Dart’s model for concurrency is based on [isolates](https://dart.dev/guides/language/concurrency) — independent units of execution that are isolated from one another — to prevent a large class of concurrency programming bugs related to shared memory, such as [*race conditions* like data races](https://en.wikipedia.org/wiki/Race_condition#In_software). Dart prevents these bugs by not allowing any mutable objects to be shared between isolates, and instead uses a model where isolates exchange state using [*message passing*](https://dart.dev/guides/language/concurrency#sending-multiple-messages-between-isolates). In Dart 2.15 we’ve made a number of substantial enhancements to isolates.

Dart 的并发模型基于 [isolate](https://dart.dev/guides/language/concurrency)
——彼此隔离的独立执行单元——以防止一大类与共享内存有关的
并发编程 bug，例如[数据竞争等*竞态条件*](https://en.wikipedia.org/wiki/Race_condition#In_software)。
Dart 不允许任何可变对象在 isolate 之间共享，从而防止这些 bug，
转而采用 isolate 之间通过[*消息传递*](https://dart.dev/guides/language/concurrency#sending-multiple-messages-between-isolates)
交换状态的模型。在 Dart 2.15 中，我们对 isolate 做了多项实质性增强。

We started by redesigning and reimplementing how isolates work, introducing a new concept: *isolate groups.* Isolates in an isolate group share various internal data structures representing the running program*.* This makes individual isolates in the group much cheaper. It is now more than 100 times faster to start an additional isolate in an existing isolate group as we don’t need to initialize the program structures, and those spawned isolates consume between 10–100 times less memory.

我们首先重新设计并重新实现了 isolate 的工作方式，
引入一个新概念：*isolate 组（isolate groups）*。
同一 isolate 组中的 isolate 共享表示运行中程序的
各种内部数据结构。这让组内的单个 isolate 开销小得多。
现在在已有 isolate 组中启动一个额外 isolate 快了 100 多倍，
因为无需再初始化程序结构，
而且这些派生出的 isolate 内存消耗降低了 10–100 倍。

While isolate groups still prevent shared access to mutable objects between isolates, the group is implemented with a shared heap, which unlocks further capabilities. We can pass objects from one isolate to another, which can be used for worker isolates that perform a task that returns a large piece of memory. An example is a worker isolate that makes a network call to get data, parses that data into a large JSON object graph, and then returns that JSON graph to the main isolate. Before Dart 2.15, that result needed to be deep-copied, which could itself cause UI jank if the copy took longer than the frame budget.

虽然 isolate 组仍然阻止 isolate 之间共享访问可变对象，
但组的实现使用了共享堆（shared heap），这解锁了更多能力。
我们可以把对象从一个 isolate 传给另一个，
这可用于执行任务并返回一大块内存的工作 isolate。
一个例子是：工作 isolate 发起网络调用获取数据，
把数据解析成大型 JSON 对象图，再把该 JSON 图返回给主 isolate。
在 Dart 2.15 之前，这个结果需要深拷贝，
如果拷贝耗时超过帧预算，本身就可能造成 UI 卡顿。

In 2.15 the worker isolate can call [`Isolate.exit()`](https://api.dart.dev/stable/2.15.0/dart-isolate/Isolate/exit.html), passing its result as an argument. The Dart runtime then passes the memory containing the result from the worker isolate to the main isolate without copying, and the main isolate can receive the result in constant time. We’ve updated the [`compute()`](https://api.flutter.dev/flutter/foundation/compute-constant.html) utility function in [Flutter 2.8 ]({{site.flutter-blog}}/whats-new-in-flutter-2-8)to take advantage of `Isolate.exit()`. If you’re already using `compute()`, then you’ll get these performance gains automatically after upgrading to Flutter 2.8.

在 2.15 中，工作 isolate 可以调用
[`Isolate.exit()`](https://api.dart.dev/stable/2.15.0/dart-isolate/Isolate/exit.html)，
把结果作为参数传入。Dart 运行时随后把包含结果的内存
从工作 isolate 传给主 isolate 而无需拷贝，
主 isolate 能以常数时间接收结果。我们已更新
[Flutter 2.8]({{site.flutter-blog}}/whats-new-in-flutter-2-8) 中的
[`compute()`](https://api.flutter.dev/flutter/foundation/compute-constant.html)
工具函数来利用 `Isolate.exit()`。如果你已在使用 `compute()`，
升级到 Flutter 2.8 后就会自动获得这些性能收益。

Finally, we’ve reworked how the isolate message passing mechanism is implemented, making passing of small-to-medium sized messages approximately 8 times faster. Sending is significantly faster, and receiving messages is almost always done in constant time. We’ve also expanded the kinds of objects that isolates can send to each other, adding support for function types, closures, and stacktrace objects. For details, see the API docs for [`SendPort.send()`](https://api.dart.dev/stable/2.15.0/dart-isolate/SendPort/send.html).

最后，我们重做了 isolate 消息传递机制的实现，
让中小型消息的传递快了约 8 倍。发送显著加快，
接收消息几乎总是以常数时间完成。我们还扩展了 isolate
之间可以互相发送的对象种类，新增支持函数类型、闭包
和堆栈跟踪对象。详情参见
[`SendPort.send()`](https://api.dart.dev/stable/2.15.0/dart-isolate/SendPort/send.html)
的 API 文档。

To learn more about how to use isolates, see the new [*Concurrency in Dart*](https://dart.dev/guides/language/concurrency) documentation we added for 2.15. We also have a number of [code samples](https://github.com/dart-lang/samples/tree/master/isolates) you can check out.

想了解更多如何使用 isolate，请参阅我们为 2.15 新增的
[*Dart 中的并发*](https://dart.dev/guides/language/concurrency)文档。
我们还准备了一些[代码示例](https://github.com/dart-lang/samples/tree/master/isolates)
供你查看。

## New language feature: Constructor tear-offs

## 新语言特性：构造函数 tear-off

In Dart you can create a function object, which points to a function on another object, by using the function’s name. In the following example, the second line of the main() method illustrates this syntax when it sets `g` to `m.greet`:

在 Dart 中，你可以用函数的名字创建一个函数对象，
它指向另一个对象上的函数。在下面的例子中，
main() 方法的第二行把 `g` 设为 `m.greet`，演示了这一语法：

```
class Greeter {
  final String name;
  Greeter(this.name);
  
  void greet(String who) {
    print('$name says: Hello $who!');
  }
}

void main() {
  final m = Greeter('Michael');
  final g = m.greet; // g holds a function pointer to m.greet.
  g('Leaf'); // Invokes and prints "Michael says: Hello Leaf!"
}
```


Such function pointers — also referred to as function *tear-offs* — appear frequently when using the Dart core libraries. Here’s an example of calling `foreach()` on an iterable by passing it a function pointer:

这样的函数指针——也称为函数 *tear-off*
（因为你把调用的括号“撕掉”了）——在使用 Dart 核心库时经常出现。
下面是一个把函数指针传给可迭代对象的 `foreach()` 调用的例子：

```
final m = Greeter('Michael');

['Lasse', 'Bob', 'Erik'].forEach(m.greet);

// Prints "Michael says: Hello Lasse!", "Michael says: Hello Bob!",
// "Michael says: Hello Erik!"
```


Historically we haven’t supported creating tear-offs from a constructor (language issue [#216](https://github.com/dart-lang/language/issues/216)). That’s annoying because in many cases — for example, when building Flutter UIs — a constructor tear-off is what you need. As of Dart 2.15, this syntax is now supported. Here’s an example of building a `Column` widget containing three `Text` widgets, by calling `.map()` and passing it a tear-off to the constructor of `Text`.

历史上我们一直不支持从构造函数创建 tear-off
（语言 issue [#216](https://github.com/dart-lang/language/issues/216)）。
这很烦人，因为在很多场景——例如构建 Flutter UI 时——
你需要的恰恰是构造函数 tear-off。从 Dart 2.15 起，
这一语法得到了支持。下面的例子通过调用 `.map()`
并传入 `Text` 构造函数的 tear-off，
构建了一个包含三个 `Text` widget 的 `Column` widget。

```
class FruitWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: ['Apple', 'Orange'].map(Text.new).toList());
  }
}
```


`Text.new` refers to the default constructor of the `Text` class. You can also refer to a named constructor — for example, `.map(Text.rich)`.

`Text.new` 指向 `Text` 类的默认构造函数。
你也可以指向命名构造函数——例如 `.map(Text.rich)`。

## Related language changes

## 相关语言变更

While we were implementing constructor tear-offs, we took the opportunity to fix some inconsistencies in our existing support for function pointers. You can now specialize a generic method to create a non-generic method:

在实现构造函数 tear-off 的同时，我们趁机修复了
现有函数指针支持中的一些不一致之处。
你现在可以特化泛型方法来创建非泛型方法：

```
T id<T>(T value) => value;
var intId = id<int>; // New in 2.15.
int Function(int) intId = id; // Pre-2.15 workaround.
```


You can even specialize a generic function object to create a non-generic function object:

你甚至可以特化泛型函数对象来创建非泛型函数对象：

```
const fo = id; // Tear off `id`, creating a function object.
const c1 = fo<int>; // New in 2.15; error before.
```


Lastly, we cleaned up type literals involving generics:

最后，我们清理了涉及泛型的类型字面量：

```
var y = List; // Already supported.
var z = List<int>; // New in 2.15.
var z = typeOf<List<int>>(); // Pre-2.15 workaround.
```


## Improved enums in the dart:core library

## dart:core 库中改进的枚举

We’ve made a number of convenience additions to the enum APIs in the dart:core library (language issue [#1511](https://github.com/dart-lang/language/issues/1511)). You can now get the `String` value for each enum value using `.name`:

我们为 dart:core 库中的枚举 API 添加了多项便利功能
（语言 issue [#1511](https://github.com/dart-lang/language/issues/1511)）。
现在你可以用 `.name` 获取每个枚举值的 `String` 值：

```
enum MyEnum {
  one, two, three
}

void main() {
  print(MyEnum.one.name);  // Prints "one".
}
```


You can also look up an enum value by name:

你也可以按名字查找枚举值：

```
print(MyEnum.values.byName('two') == MyEnum.two);  // Prints "true".
```


Finally, you can get a map of all name-value pairs:

最后，你可以获取包含所有名字-值对的映射：

```
final map = MyEnum.values.asNameMap(); 
print(map['three'] == MyEnum.three);  // Prints "true".
```


For an example of using these new APIs, see [this Flutter PR](https://github.com/flutter/flutter/pull/94496/files).

使用这些新 API 的例子，参见
[这个 Flutter PR](https://github.com/flutter/flutter/pull/94496/files)。

## Compressed pointers

## 压缩指针

Dart 2.15 adds support for compressed pointers, a technique where a 64-bit SDK can use a more space-efficient representation of pointers if only a 32-bit address space needs to be supported (up to 4 GB of memory). Compressed pointers result in a significant memory reduction; in our internal testing with the GPay app, we saw an approximately 10% reduction of the Dart heap size.

Dart 2.15 新增了对压缩指针（compressed pointers）的支持：
如果只需要支持 32 位地址空间（最多 4 GB 内存），
64 位 SDK 就能用更省空间的指针表示方式。
压缩指针带来显著的内存缩减；在我们对 GPay 应用的内部测试中，
Dart 堆大小缩减了约 10%。

Because compressed pointers imply not being able to address any available RAM above 4 GB, the feature is behind a configuration option in the Dart SDK that can only be toggled by embedders of the Dart SDK when the SDK is built. The Flutter SDK version 2.8 has enabled this configuration for Android builds, and the Flutter team is considering also [enabling it for iOS](https://github.com/flutter/flutter/issues/94753) builds in a future release.

由于压缩指针意味着无法寻址 4 GB 以上的可用内存，
该特性由 Dart SDK 中的一个配置选项控制，
只有 Dart SDK 的嵌入方在构建 SDK 时才能切换。
Flutter SDK 2.8 版本已为 Android 构建启用该配置，
Flutter 团队正在考虑在未来版本中也为
[iOS 构建启用它](https://github.com/flutter/flutter/issues/94753)。

## Dart DevTools included in the Dart SDK

## Dart SDK 内置 Dart DevTools

The [DevTools suite](https://dart.dev/tools/dart-devtools#) of debugging and performance tools previously wasn’t in the Dart SDK; you had to download it separately. Starting with Dart 2.15, you now get DevTools when you download the Dart SDK, with no further installation steps required. For more information on using DevTools with Dart command-line apps, see the [DevTools documentation](https://dart.dev/tools/dart-devtools#using-devtools-with-a-command-line-app).

[DevTools 套件](https://dart.dev/tools/dart-devtools#)
这组调试和性能工具此前不在 Dart SDK 中，你需要单独下载。
从 Dart 2.15 开始，下载 Dart SDK 就会获得 DevTools，
无需额外的安装步骤。关于在 Dart 命令行应用中使用 DevTools
的更多信息，参见
[DevTools 文档](https://dart.dev/tools/dart-devtools#using-devtools-with-a-command-line-app)。

## New pub features for package publishers

## 面向 package 发布者的新 pub 特性

Dart 2.15 SDK also has two new features in the `dart pub` developer command and the [pub.dev](https://pub.dev) package repository.

Dart 2.15 SDK 还在 `dart pub` 开发者命令和
[pub.dev](https://pub.dev) package 仓库中带来了两个新特性。

First, there’s a new security feature for package publishers. The aim is to detect when a publisher accidentally publishes secrets — for example Cloud or CI credentials — inside pub packages. We were inspired to add this leak detection after learning that inside GitHub repositories, thousands of secrets are [leaked every day](https://www.ndss-symposium.org/wp-content/uploads/2019/02/ndss2019_04B-3_Meli_paper.pdf).

首先是为 package 发布者准备的新安全特性。
目标是检测发布者是否不小心把机密信息（secrets）
——例如 Cloud 或 CI 凭据——发布到了 pub package 中。
我们之所以添加这项泄露检测，是因为了解到 GitHub 仓库中
每天都有数千个机密信息[被泄露](https://www.ndss-symposium.org/wp-content/uploads/2019/02/ndss2019_04B-3_Meli_paper.pdf)。

Leak detection runs as part of the pre-publish validation run in the `dart pub publish` command. If it detects a potential secret in the files about to be published, the `publish` command exits without publishing, and prints output like this:

泄露检测作为 `dart pub publish` 命令发布前校验的一部分运行。
如果它在即将发布的文件中检测到潜在的机密信息，
`publish` 命令会退出而不发布，并打印类似这样的输出：

```
Publishing my_package 1.0.0 to [https://pub.dartlang.org](https://pub.dartlang.org):
Package validation found the following errors:
* line 1, column 1 of lib/key.pem: Potential leak of Private Key detected.
╷
1 │ ┌ - - -BEGIN PRIVATE KEY - - -
2 │ │ H0M6xpM2q+53wmsN/eYLdgtjgBd3DBmHtPilCkiFICXyaA8z9LkJ
3 │ └ - - -END PRIVATE KEY - - -
╵
* line 2, column 23 of lib/my_package.dart: Potential leak of Google OAuth Refresh Token detected.
╷
2 │ final refreshToken = "1//042ys8uoFwZrkCgYIARAAGAQSNwF-L9IrXmFYE-sfKefSpoCnyqEcsHX97Y90KY-p8TPYPPnY2IPgRXdy0QeVw7URuF5u9oUeIF0";
```


On rare occasions this detection might have false positives, flagging potential leaks for content or files that you do in fact intend to publish. In those cases, you can add the files to an [allowlist](https://dart.dev/go/false-secrets).

在极少数情况下，这项检测可能误报，
把你确实打算发布的内容或文件标记为潜在泄露。
这时你可以把这些文件加入
[允许清单（allowlist）](https://dart.dev/go/false-secrets)。

Second, we’ve added another feature for publishers that supports retracting a package version that’s already been published. When a faulty package version is published, we usually recommend publishing a new version with a minor increment that fixes the unintended issue. In rare cases — for example when you don’t have such a fix yet, or where you accidentally published a new major version but intended to publish a new minor version — you can use the new [package retraction feature](https://dart.dev/go/package-retraction) as a last resort. This functionality is available in the Admin UI on pub.dev:

其次，我们为发布者添加了另一个特性：
支持撤回（retract）已发布的 package 版本。
当有问题的 package 版本被发布后，我们通常建议发布一个
修复该意外问题的小版本号递增的新版本。在少数情况下
——例如你还没有这样的修复，或者你不小心发布了新的主版本
而本来想发布新的次版本——你可以把新的
[package 撤回特性](https://dart.dev/go/package-retraction)
作为最后手段。该功能在 pub.dev 的管理界面中提供：

<DashImage src="images/19KDYm1R4x6D4S-mzL-QE2g.webp" alt="The pub.dev Admin interface showing the option to retract a package version." />


When a package version is retracted, the pub client no longer resolves to that version in `pub get` or `pub upgrade`. If any developers have already resolved to the retracted version (and it’s thus in their `pubspec.lock` file), they’ll see a warning the next time they run `pub`:

当某个 package 版本被撤回后，pub 客户端在 `pub get` 或
`pub upgrade` 时不会再解析到该版本。如果有开发者已经解析到了
被撤回的版本（因此它在其 `pubspec.lock` 文件中），
他们下次运行 `pub` 时会看到一条警告：

```
$ dart pub get
Resolving dependencies…
mypkg 0.0.181-buggy (retracted, 0.0.182-fixed available)
Got dependencies!
```


## Security analysis for detecting bidirectional Unicode characters (CVE-2021–22567)

## 检测双向 Unicode 字符的安全分析（CVE-2021–22567）

Recently a general programming language vulnerability was discovered involving bidirectional Unicode characters ([CVE-2021–42574](https://nvd.nist.gov/vuln/detail/CVE-2021-42574)). This vulnerability affects most modern programming languages that support Unicode. The following Dart source code illustrates the problem:

最近发现了一个涉及双向 Unicode 字符
（bidirectional Unicode characters）的通用编程语言漏洞
（[CVE-2021–42574](https://nvd.nist.gov/vuln/detail/CVE-2021-42574)）。
该漏洞影响大多数支持 Unicode 的现代编程语言。
下面的 Dart 源代码演示了这个问题：

```
main() {
  final accessLevel = 'user';

  if (accessLevel == 'user‮ .⁦// Check if admin⁩ ⁦') {
    print('You are a regular user.');
  } else {
    print('You are an admin.');
  }
}
```


You’d probably think that this program prints *You are a regular user.*, but it might in fact print *You are an admin.*! This exploit is possible by using a string containing bidirectional Unicode characters. These are characters that change the direction of the text from left-to-right to right-to-left and back, all within a single line. With bidirectional characters, the text can render onscreen quite differently from the actual text contents. You can see an example of this in [this GitHub code gist](https://gist.github.com/mit-mit/7dda00ca6278ce7d2555f78d59d9e67b?h=1).

你大概会以为这个程序打印 *You are a regular user.*，
但它实际上可能打印 *You are an admin.*！
这种攻击之所以可行，是因为使用了包含双向 Unicode 字符的字符串。
这些字符能在同一行内把文本方向从左到右切换为从右到左再切回来。
有了双向字符，文本在屏幕上的渲染可能与实际文本内容大相径庭。
你可以在[这个 GitHub 代码 gist](https://gist.github.com/mit-mit/7dda00ca6278ce7d2555f78d59d9e67b?h=1)
中看到一个例子。

Mitigations against this vulnerability include using tools (editors, code review tools, etc.) that detect bidirectional Unicode characters, so that a developer can be made aware of them, and knowingly accept their use. The GitHub gist file viewer linked to above is one example of a tool that reveals these characters.

针对该漏洞的缓解措施包括：使用能检测双向 Unicode 字符的工具
（编辑器、代码审查工具等），让开发者意识到它们的存在，
并在知情的情况下接受其使用。上面链接的 GitHub gist 文件查看器
就是能揭示这些字符的工具之一。

Dart 2.15 introduces one further mitigation (Dart security advisory [CVE-2021–22567](https://github.com/dart-lang/sdk/security/advisories/GHSA-8pcp-6qc9-rqmv)): the Dart analyzer now scans for bidirectional Unicode characters, and flags any use of them:

Dart 2.15 引入了一项进一步的缓解措施
（Dart 安全公告 [CVE-2021–22567](https://github.com/dart-lang/sdk/security/advisories/GHSA-8pcp-6qc9-rqmv)）：
Dart 分析器现在会扫描双向 Unicode 字符，并标记任何使用：

```
$ dart analyze
Analyzing cvetest...                   2.6s

info • bin/cvetest.dart:4:27 • The Unicode code point 'U+202E'
       changes the appearance of text from how it's interpreted
       by the compiler. Try removing the code point or using the 
       Unicode escape sequence '\u202E'. •
       text_direction_code_point_in_literal
```


We recommend replacing these characters by Unicode escape sequences, so that they’re visible in any text editor or viewer. Alternatively, if you do have a legitimate use of these characters, you can disable the warning by adding an override in the line preceding the use:

我们建议把这些字符替换为 Unicode 转义序列，
让它们在任何文本编辑器或查看器中都可见。或者，
如果你确实有使用这些字符的正当理由，
可以在使用处的前一行添加覆盖注释来禁用该警告：

```
// ignore: text_direction_code_point_in_literal
```


## Pub.dev credentials vulnerability when using third-party pub servers (CVE-2021–22568)

## 使用第三方 pub 服务器时的 Pub.dev 凭据漏洞（CVE-2021–22568）

We’re also publishing a second pub.dev-related Dart security advisory: [CVE-2021–22568](https://github.com/dart-lang/sdk/security/advisories/GHSA-r32f-vhjp-qhj7). This advisory is targeted at package publishers who may have published packages to third-party pub package servers, such as private or company-internal package servers. Developers who publish only to the public pub.dev repository (the standard configuration) are **not affected** by this vulnerability.

我们还发布了第二份与 pub.dev 相关的 Dart 安全公告：
[CVE-2021–22568](https://github.com/dart-lang/sdk/security/advisories/GHSA-r32f-vhjp-qhj7)。
该公告针对可能向第三方 pub package 服务器
（如私有或公司内部 package 服务器）发布过 package 的发布者。
只向公共 pub.dev 仓库发布（标准配置）的开发者
**不受**此漏洞影响。

If you’ve published to a third-party repository, the vulnerability is that the OAuth2 temporary (one-hour) access token presented for authentication at that third-party repository can be misused to authenticate against the public pub.dev repository. Thus a malicious third-party pub server might use an access token to impersonate you on pub.dev and publish packages there. If you’ve published a package to an untrusted third-party package repository, consider doing an audit of all your account activity on the pub.dev public package repository. You can use the [pub.dev activity log](https://pub.dev/my-activity-log) for this purpose.

如果你向第三方仓库发布过 package，漏洞在于：
用于在该第三方仓库进行身份验证的 OAuth2 临时（一小时）访问令牌，
可能被滥用来通过公共 pub.dev 仓库的身份验证。
因此，恶意的第三方 pub 服务器可能利用访问令牌
在 pub.dev 上冒充你并在那里发布 package。
如果你曾向不受信任的第三方 package 仓库发布过 package，
建议审计你在 pub.dev 公共 package 仓库上的所有账户活动。
你可以使用 [pub.dev 活动日志](https://pub.dev/my-activity-log)来做这件事。

## Closing comments

## 结语

We hope that you’ll enjoy the new features in Dart 2.15, [available today](https://dart.dev/get-dart). This is our last release of the year, and we’d like to take the chance to express our gratitude for the wonderful Dart ecosystem. Thanks for all the great feedback, for your continued support as witnessed by our continued growth, and for extending our ecosystem with thousands of packages published on [pub.dev](https://pub.dev) over the past year. We can’t wait to get back to it next year, and we have lots of exciting things planned for 2022. Until then, enjoy the holidays!

希望你喜欢 Dart 2.15 的新特性，
[今天即可获取](https://dart.dev/get-dart)。这是我们今年的最后一次发布，
我们想借此机会向精彩的 Dart 生态表达感谢。
感谢所有出色的反馈，感谢你们持续的支持——我们的持续成长就是见证，
也感谢过去一年里你们在 [pub.dev](https://pub.dev) 上发布的
数千个 package 对生态的扩展。我们迫不及待地想在明年继续投入，
2022 年我们计划了很多令人兴奋的事情。在那之前，祝节日快乐！
