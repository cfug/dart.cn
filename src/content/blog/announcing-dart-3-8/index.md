---
# title: "Announcing Dart 3.8"
title: "宣布 Dart 3.8"
# description: "This release brings formatter updates, null-aware elements for collections, new cross-platform development capabilities, a better way to…"
description: "这个版本带来格式化器更新、集合的 null-aware 元素、新的跨平台开发能力、更好的热门 package 发现方式……"
ai-translated: true
publishDate: 2025-05-20
author: antfitch
image: images/1cTcqAst5m1Vn6k71VWgTrQ.webp
category: releases
layout: blog
---


This release brings formatter updates, null-aware elements for collections, new cross-platform development capabilities, a better way to find trending packages on pub.dev, availability of hot reload on the web, and more! We’re also hoping there are a few developers out there who are interested in joining our FFigen and JNIgen early access program.

这个版本带来格式化器更新、集合的 null-aware 元素、
新的跨平台开发能力、在 pub.dev 上发现热门 package 的更好方式、
Web 上的热重载，以及更多！我们也希望有一些开发者
有兴趣加入我们的 FFigen 和 JNIgen 早期体验计划。

<DashImage src="images/1cTcqAst5m1Vn6k71VWgTrQ.webp" alt="Dart 3.8 release banner with the Dart logo and a bullseye icon." caption="Announcing Dart 3.8" />


## Formatter updates

## 格式化器更新

In the previous release, Dart included a largely rewritten formatter that supported a new [“tall” style](https://github.com/dart-lang/dart_style/issues/1253). The Dart 3.8 release incorporates additional feedback, fixes bug reports, and adds other improvements.

上一个版本中，Dart 引入了大规模重写的格式化器，
支持新的[“tall”风格](https://github.com/dart-lang/dart_style/issues/1253)。
Dart 3.8 版本吸收了更多反馈、修复了报告的 bug，
并加入了其他改进。

Note that if you upgrade to the Dart 3.8 SDK, your formatting won’t change until you change your package’s pubspec to opt in to the latest [language version](https://dart.dev/language/versioning).

注意：如果你升级到 Dart 3.8 SDK，
在你修改 package 的 pubspec 选择启用最新
[语言版本](https://dart.dev/language/versioning)之前，
格式不会改变。

### **Trailing commas and taller code**

### 尾随逗号与更高的代码

In prior releases, a trailing comma would force the surrounding construct to split. The new formatter now decides whether a construct should split and then adds or removes the trailing comma as needed.

在之前的版本中，尾随逗号会强制所在结构拆分换行。
新格式化器现在自行决定一个结构是否应该拆分，
然后按需添加或删除尾随逗号。

```dart
// Before formatter
TabBar(tabs: [Tab(text: 'A'), Tab(text: 'B')], labelColor: Colors.white70);

// After formatter
TabBar(
  tabs: [
    Tab(text: 'A'),
    Tab(text: 'B'),
  ],
  labelColor: Colors.white70,
);
```


If you prefer the old behavior, you can re-enable it with a [configuration](https://github.com/dart-lang/dart_style/wiki/Configuration) flag.

如果你更喜欢旧行为，可以通过一个
[配置](https://github.com/dart-lang/dart_style/wiki/Configuration)
标志重新启用它。

### **Style changes**

### 风格变化

A number of style changes were added that tighten up and improve output. Here are some examples:

新增了一些风格变化，让输出更紧凑、更好。
下面是一些例子：

```dart
// Previously released formatter (functions)
function(
  name:
      (param) => another(
        argument1,
        argument2,
      ),
);

// Dart 3.8 formatter (functions)
function(
  name: (param) => another(
    argument1,
    argument2,
  ),
);

// Previously released formatter (variables)
variable =
    target.property
        .method()
        .another();

// Dart 3.8 formatter (variables)
variable = target.property
    .method()
    .another();
```


## Cross compilation

## 交叉编译

There is new support to [compile](https://dart.dev/tools/dart-compile#cross-compilation-exe) to native Linux binaries from Windows, macOS, and Linux development machines. You can do this with the `dart compile exe` or `dart compile aot-snapshot` command and the `--target-os` and `--target-arch` flags.

现在支持从 Windows、macOS 和 Linux 开发机
[编译](https://dart.dev/tools/dart-compile#cross-compilation-exe)
出原生 Linux 二进制文件。你可以使用 `dart compile exe`
或 `dart compile aot-snapshot` 命令，
配合 `--target-os` 和 `--target-arch` 标志来做到。

```shell
// cross compilation example for an exe
$ dart compile exe --target-os=linux --target-arch=arm64

// cross compilation example for an aot-snapshot
$ dart compile aot-snapshot --target-os=linux --target-arch=arm64
```


Sample use cases:

示例用例：

* Quicker compiles for embedded devices (for example, a Raspberry Pi) on a fast developer laptop, as opposed to the less powerful embedded device.

  在快速的开发笔记本上为嵌入式设备（例如树莓派）
  更快地编译，而不是在性能较弱的嵌入式设备上编译。

* Quicker compiles for a Linux-based backend on a non-Linux developer machine.

  在非 Linux 开发机上为基于 Linux 的后端更快地编译。

## **Null-aware elements**

## Null-aware 元素

New [null-aware elements](https://dart.dev/language/collections#null-aware-element) let you add elements to a collection such as a list, set, or map, if the elements are not null. To make an element a null-aware element in a collection literal, prepend the element with `?`.

新的 [null-aware 元素](https://dart.dev/language/collections#null-aware-element)
让你在元素不为 null 时才把它加入 list、set 或 map 等集合。
要在集合字面量中把一个元素变成 null-aware 元素，
在元素前加上 `?`。

A list without null-aware elements that removes null values:

不使用 null-aware 元素、剔除 null 值的 list：

```dart
// Code without null-aware elements
var listWithoutNullAwareElements = [
  if (promotableNullableValue != null)
    promotableNullableValue,
  if (nullable.value != null)
    nullable.value!,
  if (nullable.value case var value?)
    value,
];
```


A list with null-aware elements that removes null values:

使用 null-aware 元素、剔除 null 值的 list：

```dart
// Code with null-aware elements
var listWithNullAwareElements = [
  ?promotableNullableValue,
  ?nullable.value,
  ?nullable.value,
];
```


## Doc imports

## 文档导入（Doc imports）

There is now support for doc imports, a new comment-based syntax which enables external elements to be referenced in documentation comments without actually importing them. This tag can be specified in a doc comment above a `library` directive.

现在支持文档导入（doc imports）：一种基于注释的新语法，
让文档注释可以引用外部元素而无需真正导入它们。
这个标记可以写在 `library` 指令上方的文档注释中。

In the following example, `[Future]` and `[Future.value]` are imported from the `dart:async` library, but only for documentation comments:

在下面的例子中，`[Future]` 和 `[Future.value]`
从 `dart:async` 库导入，但仅用于文档注释：

```dart
/// @docImport 'dart:async';
library;

/// Doc comments can now reference elements like
/// [Future] and [Future.value] from `dart:async`,
/// even if the library is not imported with an
/// actual import.
class Foo {}
```


Doc imports support the same URI styles as regular Dart imports, including the `dart:` scheme, `package:` scheme and relative paths. However, they can’t be deferred or configured with `as`, `show`, `hide`.

文档导入支持与普通 Dart import 相同的 URI 形式，
包括 `dart:` scheme、`package:` scheme 和相对路径。
但它们不能延迟加载（deferred），
也不能用 `as`、`show`、`hide` 配置。

## Trending packages on pub.dev

## pub.dev 上的热门 package

The [pub.dev landing page](https://pub.dev/) replaces the “Most Popular Packages” section with the “Trending Packages” section. This new section showcases packages that have recently demonstrated notable growth in adoption and community interest.

[pub.dev 首页](https://pub.dev/)用 “Trending Packages”
（热门 package）板块取代了 “Most Popular Packages”
（最受欢迎 package）板块。这个新板块展示近期在采用度
和社区关注度上表现出显著增长的 package。

<DashImage src="images/1hwpiNbr2JrUE8cROV3KagQ.webp" alt="Pub.dev landing page with the new trending packages section." caption="Trending packages section on pub.dev" />


## Hot reload on the web (experimental)

## Web 上的热重载（实验性）

Stateful hot reload is now available on the web when you use the Dart Development Compiler (DDC). A redesign of the JS representation of Dart code lets you swap out code in a running application.

使用 Dart 开发编译器（DDC）时，Web 上现在也能
有状态热重载了。对 Dart 代码的 JS 表示形式的重新设计，
让你能在运行中的应用里替换代码。

Work is still iterating on this feature, but Dart 3.8 provides the first opportunity to try it, starting with Flutter apps. See the [Flutter blog post]({{site.flutter-blog}}/whats-new-in-flutter-3-32) for instructions on how to enable hot reload.

这个特性仍在迭代中，但 Dart 3.8 提供了首次尝试的机会，
先从 Flutter 应用开始。启用热重载的说明请参见
[Flutter 博客文章]({{site.flutter-blog}}/whats-new-in-flutter-3-32)。

<DashImage src="images/0NB_4jaD3XtdHpCQm.webp" alt="Animation showing Dart stateful hot reload enabled for a web app in DartPad." caption="Dart stateful hot reload for web" />


This was a multiyear effort that included changing the runtime type representation, redesigning class hierarchies, and updating the way code loads into the page. The goal is to reach full parity with the VM’s existing hot reload implementation. In almost all cases, the feature should already be indistinguishable from what you are used to from the VM. You can find all known issues in the [issue tracker](https://github.com/orgs/dart-lang/projects/107/views/1?filterQuery=-status%3ADone).

这是一项历时多年的工作，包括改变运行时类型表示、
重新设计类层次结构，以及更新代码加载进页面的方式。
目标是与 VM 现有的热重载实现完全对齐。
几乎所有情况下，这个特性的体验应该已经与你习惯的 VM
热重载没有区别。所有已知问题可以在
[issue 跟踪器](https://github.com/orgs/dart-lang/projects/107/views/1?filterQuery=-status%3ADone)中找到。

The focus makes this feature accessible in Flutter apps first, but the plan is to integrate hot reload into `build_web_compilers` for use within non-Flutter web apps later.

当前的重点让这个特性先在 Flutter 应用中可用，
但计划稍后把热重载集成进 `build_web_compilers`，
供非 Flutter 的 Web 应用使用。

## Direct native interoperability

## 直接原生互操作

We’re excited to launch an early access program for FFigen and JNIgen, the codegen solutions designed to simplify native platform API integration. We are seeking Flutter plugin authors who want to develop or refactor plugins with these solutions.

我们很高兴为 FFigen 和 JNIgen 推出早期体验计划。
这两个代码生成方案旨在简化原生平台 API 的集成。
我们正在寻找想用这些方案开发或重构插件的
Flutter 插件作者。

To learn more, read the blog post titled [Flutter’s Path Towards Seamless Interop](https://medium.com/@mariam.hasnany/4bf7d4579d9a). It covers our aspirations for direct native interoperability, the roadmap to achieve them, and the early access program.

想了解更多，请阅读题为
[Flutter’s Path Towards Seamless Interop](https://medium.com/@mariam.hasnany/4bf7d4579d9a)
的博客文章。它涵盖了我们对直接原生互操作的愿景、
实现路线图以及早期体验计划。

## Wrap up

## 总结

Dart 3.8 is a testament to our ongoing commitment to refine the development experience. We encourage you to explore these new features — from the intelligent formatter and cross-compilation support to null-aware elements, web hot reload, and the early access for native interop. Your insights and contributions are vital to Dart and Flutter’s continuous growth, and we can’t wait to see the apps you’ll bring to life.

Dart 3.8 印证了我们持续打磨开发体验的承诺。
我们鼓励你探索这些新特性——从智能格式化器和交叉编译支持，
到 null-aware 元素、Web 热重载，以及原生互操作的早期体验。
你的洞察和贡献对 Dart 和 Flutter 的持续成长至关重要，
我们迫不及待想看到你将创造的应用。

Upgrade to Dart 3.8 today and happy coding!

今天就升级到 Dart 3.8，祝编码愉快！
