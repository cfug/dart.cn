---
# title: "Announcing Dart 3.13"
title: "宣布 Dart 3.13"
# description: "Bringing conciseness and simplicity to Dart codebases, tooling, and platforms."
description: "为 Dart 代码库、工具与平台带来简洁与简单。"
ai-translated: true
publishDate: 2026-08-12
author: conooi
image: images/dart3-13.webp
socialImage: images/dart3-13-cover.webp
category: releases
layout: blog
---

<DashImage
  src="images/dart3-13.webp"
  alt="Dart 3.13 release banner animation with the Dart logo."
  caption="Announcing Dart 3.13"
/>

We're thrilled to announce Dart 3.13!

我们很高兴宣布 Dart 3.13 发布！

In this release, we're celebrating a theme that every developer loves:
clean and lightweight code.
Dart 3.13 brings this focus to every layer of the developer experience.
On the language front, primary constructors eliminate repetitive boilerplate
so you can define classes in a single line of code.
In developer tooling, refinements to `dart format` keep your code neat
according to [Effective Dart style rules](https://dart.dev/effective-dart/style#ordering),
while `dart pub` introduces new workspace commands to keep monorepos tidy.
On pub.dev, richer documentation features like `<callout-box>` tags and
`{@example}` directives make package docs clearer to read.
Under the hood, native library tree-shaking (`@RecordUse`) and
WebAssembly deferred loading help keep your
compiled application binaries as compact as possible.

在这个版本中，我们围绕每个开发者都喜爱的主题庆祝：
干净、轻量的代码。
Dart 3.13 把这一关注点带到开发体验的每一层。
语言方面，主构造函数消除重复的样板代码，
让你用一行代码定义类。
开发工具方面，`dart format` 的改进让代码按
[Effective Dart 风格规则](https://dart.dev/effective-dart/style#ordering)
保持整洁，`dart pub` 则引入新的工作区命令让 monorepo 井井有条。
在 pub.dev 上，`<callout-box>` 标签和 `{@example}` 指令等
更丰富的文档特性让 package 文档更清晰易读。
底层方面，原生库 tree-shaking（`@RecordUse`）和
WebAssembly 延迟加载帮助让你的编译产物尽可能紧凑。

So [update Dart](https://dart.dev/get-dart) or
run [`flutter upgrade`](https://docs.flutter.dev/install/upgrade)
and follow along as we explore what's new in Dart 3.13!

那就[更新 Dart](https://dart.dev/get-dart) 或运行
[`flutter upgrade`](https://docs.flutter.dev/install/upgrade)，
跟我们一起探索 Dart 3.13 的新特性！

## Language updates

## 语言更新

### Primary constructors

### 主构造函数

Following an experimental preview in Dart 3.12,
primary constructors are now officially stable in Dart 3.13!

继 Dart 3.12 的实验性预览之后，
主构造函数在 Dart 3.13 中正式稳定了！

Primary constructors represent a major step forward for class conciseness.
We've heard from developers that repeating field names and types
across class bodies and parameter lists can feel tedious.
Primary constructors remove that repetition, letting you define, for example,
a `Point` class with two fields and a constructor in a single line of code:

主构造函数是类简洁性的一大步。
我们听到开发者反馈：在类体和参数列表中重复字段名和类型
让人厌烦。主构造函数消除了这种重复，
让你能用一行代码定义一个带两个字段和构造函数的
`Point` 类：

```dart
class Point(final int x, final int y);
```

This feature also includes
[concise syntax for constructors](https://dart.dev/language/constructors#concise-constructor-syntax)
using the `new` or `factory` keywords,
allowing empty declaration bodies to end with a `;`.

这个特性还包括使用 `new` 或 `factory` 关键字的
[简洁构造函数语法](https://dart.dev/language/constructors#concise-constructor-syntax)，
允许空声明体以 `;` 结尾。

To help you adopt primary constructors and maintain a consistent style
across your codebase, we've introduced several new lints with automated fixes:

为帮助你采用主构造函数并在代码库中保持一致的风格，
我们引入了几个带自动修复的新 lint：

- [`empty_container_bodies`](https://dart.dev/tools/linter-rules/empty_container_bodies):
  Encourages brevity by using `;` rather than `{}` in class-like declarations.

  [`empty_container_bodies`](https://dart.dev/tools/linter-rules/empty_container_bodies)：
  鼓励在类式声明中用 `;` 代替 `{}`，让代码更简洁。
- [`initialize_in_field_declaration`](https://dart.dev/tools/linter-rules/initialize_in_field_declaration):
  Encourages clarity by moving field initialization
  from a primary constructor to the field declaration.

  [`initialize_in_field_declaration`](https://dart.dev/tools/linter-rules/initialize_in_field_declaration)：
  鼓励把字段初始化从主构造函数移到字段声明处，让代码更清晰。
- [`unnecessary_const_in_enum_constructor`](https://dart.dev/tools/linter-rules/unnecessary_const_in_enum_constructor):
  Encourages brevity by removing `const` from enum constructors.

  [`unnecessary_const_in_enum_constructor`](https://dart.dev/tools/linter-rules/unnecessary_const_in_enum_constructor)：
  鼓励移除枚举构造函数中的 `const`，让代码更简洁。
- [`unnecessary_primary_constructor_body`](https://dart.dev/tools/linter-rules/unnecessary_primary_constructor_body):
  Encourages brevity by removing unneeded primary constructor bodies.

  [`unnecessary_primary_constructor_body`](https://dart.dev/tools/linter-rules/unnecessary_primary_constructor_body)：
  鼓励移除不必要的主构造函数体，让代码更简洁。
- [`unnecessary_type_name_in_constructor`](https://dart.dev/tools/linter-rules/unnecessary_type_name_in_constructor):
  Encourages brevity by replacing the type name
  with `new` in constructor declarations.

  [`unnecessary_type_name_in_constructor`](https://dart.dev/tools/linter-rules/unnecessary_type_name_in_constructor)：
  鼓励在构造函数声明中用 `new` 代替类型名，让代码更简洁。
- [`use_declaring_parameters`](https://dart.dev/tools/linter-rules/use_declaring_parameters):
  Encourages brevity by using declaring parameters where possible.

  [`use_declaring_parameters`](https://dart.dev/tools/linter-rules/use_declaring_parameters)：
  鼓励尽可能使用声明参数（declaring parameters），让代码更简洁。

Along with these lints, we've also added new IDE refactorings
to automate your code migration:

除了这些 lint，我们还添加了新的 IDE 重构操作，
自动完成代码迁移：

- **Convert to primary constructor**:
  Converts an eligible in-body constructor to a primary constructor.

  **转换为主构造函数**：
  把符合条件的类体内构造函数转换为主构造函数。
- **Convert to in-body constructor**:
  Converts a primary constructor to an in-body constructor.

  **转换为类体内构造函数**：
  把主构造函数转换为类体内构造函数。
- **Convert to declaring parameter**:
  Converts a non-declaring parameter in a primary constructor to
  a declaring parameter.

  **转换为声明参数**：
  把主构造函数中的非声明参数转换为声明参数。
- **Move initialization to the field declaration**:
  Moves field initialization from the constructor initializer list to
  the field declaration.

  **把初始化移到字段声明处**：
  把字段初始化从构造函数初始化列表移到字段声明处。

**Learn more:** [Primary constructors documentation](https://dart.dev/language/primary-constructors)

**了解更多：**[主构造函数文档](https://dart.dev/language/primary-constructors)

## Web platform updates

## Web 平台更新

### WebAssembly deferred loading preview

### WebAssembly 延迟加载预览

We've been hard at work expanding WebAssembly capabilities for Dart on the web.
In Dart 3.13, we're excited to share an early preview of
deferred loading support when compiling with `dart2wasm`.
You can enable it today using the experimental compiler flag:

我们一直在努力扩展 Dart 在 Web 上的 WebAssembly 能力。
在 Dart 3.13 中，我们很高兴分享用 `dart2wasm` 编译时
延迟加载支持的早期预览。
你今天就可以用实验性编译器标志启用它：

```bash
dart compile wasm -O2 --enable-deferred-loading
```

:::note
Deferred loading requires your app embedder to
supply a callback responsible for loading Wasm module bytes.
For details, see the `CompiledApp.instantiate` documentation in
your app's generated `<app>.mjs` file.
:::

:::note
延迟加载需要你的应用嵌入器提供一个负责加载
Wasm 模块字节的回调。详情请参见应用生成的
`<app>.mjs` 文件中 `CompiledApp.instantiate` 的文档。
:::

In large applications using deferred loading, `dart2wasm` delivers significant
initial page load (IPL) time improvements compared to `dart2js`,
benefiting both Flutter web apps and DOM-based web applications.

在使用延迟加载的大型应用中，与 `dart2js` 相比，
`dart2wasm` 带来显著的首次页面加载（IPL）时间改进，
Flutter Web 应用和基于 DOM 的 Web 应用都能受益。

As a reminder, the legacy web libraries like `dart:html` and `package:js`
aren't supported in `dart2wasm` and were deprecated in Dart 3.7
(and will stop working in `dart2js` in the future).
Many packages are already migrated,
so upgrading your package dependencies often resolves issues automatically.
However, if your code directly uses these legacy libraries,
check out our migration guides to adopt the supported
[`dart:js_interop`](https://dart.dev/interop/js-interop) and
[`package:web`](https://dart.dev/interop/js-interop/package-web)
libraries today.

提醒一下，`dart:html` 和 `package:js` 等遗留 Web 库
在 `dart2wasm` 中不受支持，并已在 Dart 3.7 中废弃
（将来也会在 `dart2js` 中停止工作）。
许多 package 已经完成迁移，
所以升级 package 依赖往往能自动解决问题。
但如果你的代码直接使用这些遗留库，
请查看我们的迁移指南，立即改用受支持的
[`dart:js_interop`](https://dart.dev/interop/js-interop) 和
[`package:web`](https://dart.dev/interop/js-interop/package-web) 库。

**Learn more:** [WebAssembly documentation](https://dart.dev/web/wasm)

**了解更多：**[WebAssembly 文档](https://dart.dev/web/wasm)

## Core engine and runtime updates

## 核心引擎与运行时更新

### Engineering highlights

### 工程亮点

Alongside our web platform progress, our team is constantly improving
the foundation of Dart.
Here are a few highlights of what we've worked on behind the scenes
over the past three months:

在推进 Web 平台的同时，我们团队也在持续改进 Dart 的根基。
下面是过去三个月我们在幕后工作的几个亮点：

- **Type promotion soundness fix**:
  Fixed a [rare unsoundness](https://github.com/dart-lang/sdk/issues/62889)
  issue with type promotion involving nested functions.

  **类型提升健全性修复**：
  修复了涉及嵌套函数的类型提升中一个
  [罕见的健全性问题](https://github.com/dart-lang/sdk/issues/62889)。
- **Common front-end refactoring**:
  Refactored internal common front-end components to
  enable greater code sharing with the Dart analyzer.

  **公共前端重构**：
  重构了内部公共前端组件，
  以便与 Dart 分析器共享更多代码。
- **DDC module system unification**:
  Continued removing legacy module systems from
  the Dart Development Compiler (DDC) across tools
  to establish a single, unified module system.

  **DDC 模块系统统一**：
  继续在各工具中移除 Dart 开发编译器（DDC）的
  遗留模块系统，建立单一、统一的模块系统。
- **Native runtime memory safety**:
  Enhanced native runtime memory safety by
  introducing a memory cage around the Dart heap.

  **原生运行时内存安全**：
  通过在 Dart 堆周围引入内存笼（memory cage），
  增强原生运行时的内存安全。
- **Dynamic module linking**:
  Initiated experiments with
  [dynamic modules](https://github.com/dart-lang/sdk/blob/f29989d506b2dd82957da5d1917bcc76628c5ddb/pkg/dynamic_modules/README.md)
  to enable dynamic code linking, paving the way for
  improved development workflows like fast prototype sharing within a team.

  **动态模块链接**：
  启动了[动态模块](https://github.com/dart-lang/sdk/blob/f29989d506b2dd82957da5d1917bcc76628c5ddb/pkg/dynamic_modules/README.md)
  实验以实现动态代码链接，为团队内快速共享原型等
  改进的开发工作流铺路。

## Tools updates

## 工具更新

### Dart formatter

### Dart 格式化器

Keeping codebases tidy and easy to read is a top priority for `dart format`.
In Dart 3.13, we've introduced a handful of style tweaks
to make formatted code even cleaner.
While most changes are minor, a few key updates will make your
everyday code noticeably easier to read:

让代码库整洁易读是 `dart format` 的首要任务。
在 Dart 3.13 中，我们引入了一些风格微调，
让格式化后的代码更干净。
虽然大多数变化很小，但几项关键更新会让你的
日常代码明显更易读：

- **Method call misformatting fix**:
  We fixed a bug where an optimization would
  sometimes erroneously kick in and misformat code.
  It mostly pops up around method calls containing large collection literals:

  **方法调用格式错误修复**：
  我们修复了一个 bug：某项优化有时会错误地生效，
  导致代码格式错乱。
  它大多出现在包含大型集合字面量的方法调用附近：

  ```dart
  // Before:
  await MethodChannelContainer()
      .onMethodChannelInvoke('reportCrash', <String, Object?>{
        'time': nowTime,
        'errorValue': errorName,
        'reason': reason,
        'stacktrace': stacktrace,
      });

  // After:
  await MethodChannelContainer().onMethodChannelInvoke(
    'reportCrash',
    <String, Object?>{
      'time': nowTime,
      'errorValue': errorName,
      'reason': reason,
      'stacktrace': stacktrace,
    },
  );
  ```

- **Method chain split heuristics**:
  We changed the heuristics around whether the formatter decides to
  split a method call chain at the `.` or inside one of the argument lists.
  If the target of the method chain is a collection literal or function call
  with a single element or argument, it now prefers to split the call chain
  instead of the target:

  **方法链拆分启发式**：
  我们调整了格式化器决定在 `.` 处还是在某个参数列表内部
  拆分方法调用链的启发式规则。
  如果方法链的目标是只含单个元素或参数的集合字面量
  或函数调用，现在会优先拆分调用链而不是目标：

  ```dart
  // Before, split the target:
  function(
    argument,
  ).method().another();

  // After, split the chain:
  function(argument)
      .method()
      .another();
  ```

- **Import section separation**:
  The formatter now inserts a blank line
  between different "sections" within a series of imports.
  The formatter doesn't sort the imports,
  but it does now separate them,
  according to [the rules in Effective Dart](https://dart.dev/effective-dart/style#ordering):

  **import 分区隔离**：
  格式化器现在会在一组 import 的不同“分区”之间
  插入空行。格式化器不排序 import，
  但现在会按照
  [Effective Dart 的规则](https://dart.dev/effective-dart/style#ordering)
  把它们分隔开：

  ```dart
  // Before:
  import 'dart:io';
  import 'dart:math';
  import 'package:args/args.dart';
  import 'package:test/test.dart';
  import 'my_library.dart';

  // After:
  import 'dart:io';
  import 'dart:math';

  import 'package:args/args.dart';
  import 'package:test/test.dart';

  import 'my_library.dart';
  ```

There are some other style tweaks described in the `dart_style`
[changelog](https://pub.dev/packages/dart_style/changelog#3110),
but those are the most visible ones.
We know that formatting changes can cause annoying churn,
so we try to be conservative when changing the style.
At the same time, a style improvement can make code easier to read,
which is a valuable benefit in an era when we're all
reviewing more code than ever thanks to generative AI.
Aside from the optimization bug fix, these style changes are
[language-versioned](https://dart.dev/language/versioning).
You'll only see them after you upgrade your code to Dart 3.13.

`dart_style` 的
[更新日志](https://pub.dev/packages/dart_style/changelog#3110)
还描述了其他一些风格微调，但以上是最显眼的。
我们知道格式变化会带来烦人的代码变动，
所以在改变风格时尽量保守。
同时，风格改进能让代码更易读——在生成式 AI 让我们
review 的代码比以往任何时候都多的时代，这是宝贵的收益。
除了那个优化 bug 修复，这些风格变化都
[按语言版本控制](https://dart.dev/language/versioning)。
只有把代码升级到 Dart 3.13 后你才会看到它们。

**Learn more:** [Dart formatter documentation](https://dart.dev/tools/dart-format)

**了解更多：**[Dart 格式化器文档](https://dart.dev/tools/dart-format)

### Pub updates

### Pub 更新

#### Package documentation updates

#### Package 文档更新

Clear and well-structured package documentation is
essential for a healthy ecosystem.
To help package authors create cleaner, more maintainable docs, pub.dev now
supports `<callout-box>` tags and `{@example}` directives end-to-end.
You can extract code snippets directly from example files
into your API documentation while hiding unnecessary boilerplate.

清晰、结构良好的 package 文档对健康的生态至关重要。
为帮助 package 作者创建更干净、更易维护的文档，
pub.dev 现在端到端支持 `<callout-box>` 标签和
`{@example}` 指令。你可以直接从示例文件中提取代码片段
放进 API 文档，同时隐藏不必要的样板代码。

For example, define a snippet region in `example/foo.dart`:

例如，在 `example/foo.dart` 中定义一个片段区域：

```dart
// example/foo.dart
void main() {
  // #region abc
  // Included in documentation
  foo();
  assert(false); // #hide
  // #endregion
}
```

Then reference that region in your Dart doc comments:

然后在 Dart 文档注释中引用该区域：

```dart
/// This is a great function.
///
/// Example usage:
/// {@example /example/foo.dart#abc}
void foo() {}
```

pub.dev renders the specified code region directly
in the generated documentation.

pub.dev 会把指定的代码区域直接渲染进生成的文档。

<DashImage
  src="images/pub-doc-callout-example.webp"
  alt="The cupertino_ui documentation on pub.dev displaying a 'callout-box' element with a blue border alongside an embedded '{@example}' code block."
  caption="The cupertino_ui documentation on pub.dev displaying a `<callout-box>` with a blue border alongside an embedded `{@example}` code block."
/>

Behind the scenes, pub.dev also deployed a
two-level hash index for dartdoc file lookups.
This update drastically speeds up documentation rendering for
large packages containing 100k+ generated files.

在幕后，pub.dev 还为 dartdoc 文件查找部署了
两级哈希索引。这项更新大幅加快了包含 10 万以上
生成文件的大型 package 的文档渲染速度。

<DashImage
  src="images/pub-latency-blob-index.webp"
  alt="Chart showing Docs Request Latency drop after deploying the new blob index."
  caption="Docs Request Latency drop after deploying the new blob index."
/>

**Learn more:** [`CupertinoActivityIndicator` class documentation](https://pub.dev/documentation/cupertino_ui/latest/cupertino_ui/CupertinoActivityIndicator-class.html)

**了解更多：**[`CupertinoActivityIndicator` 类文档](https://pub.dev/documentation/cupertino_ui/latest/cupertino_ui/CupertinoActivityIndicator-class.html)

## Native interop updates

## 原生互操作更新

### Tree-shaking native libraries with `@RecordUse` and `package:record_use`

### 用 `@RecordUse` 和 `package:record_use` 对原生库做 tree-shaking

Our commitment to efficiency extends all the way down to
your compiled application binaries.
When building Dart and Flutter apps that interoperate with
native C, C++, or Rust code using `dart:ffi` and Code Assets,
the Dart compiler has always tree-shaken unused Dart wrapper functions.
However, the underlying native binaries traditionally remained bundled in full.

我们对效率的追求一直延伸到你的编译产物。
构建使用 `dart:ffi` 和 Code Assets 与原生 C、C++ 或 Rust
代码互操作的 Dart 和 Flutter 应用时，
Dart 编译器一直会对未使用的 Dart 包装函数做 tree-shaking。
但底层的原生二进制文件传统上仍会被完整打包。

With `@RecordUse` (in `package:meta`) and `package:record_use`,
Dart and Flutter can now tree-shake native libraries alongside your Dart code.
This ensures your final application bundle contains only
the native code your app actually invokes.

有了 `@RecordUse`（位于 `package:meta`）和
`package:record_use`，Dart 和 Flutter 现在可以在
tree-shake Dart 代码的同时对原生库做 tree-shaking。
这确保最终的应用包只包含应用实际调用的原生代码。

#### How it works

#### 工作原理

1.  **Annotate native FFI bindings with `@RecordUse()`**:
    Mark your native FFI bindings (such as those generated by `ffigen`)
    with the `@RecordUse()` annotation:

    **用 `@RecordUse()` 标注原生 FFI 绑定**：
    用 `@RecordUse()` 注解标记你的原生 FFI 绑定
    （例如 `ffigen` 生成的那些）：

    ```dart
    import 'dart:ffi';
    import 'package:meta/meta.dart';

    @RecordUse()
    @Native<Int32 Function(Int32, Int32)>()
    external int sqlite3_open(
      Pointer<Utf8> filename,
      Pointer<Pointer<sqlite3>> ppDb,
    );

    @RecordUse()
    @Native<Int32 Function(Pointer<sqlite3>)>()
    external int sqlite3_close(Pointer<sqlite3> db);
    ```

2.  **Track reachable calls during compilation**:
    During whole-program compilation and tree-shaking in Dart AOT builds,
    the compiler tracks which bindings annotated with `@RecordUse()`
    are reachable in executable code.
    Calls that reside in unused Dart code that gets tree-shaken away
    are excluded automatically.

    **在编译期间追踪可达调用**：
    在 Dart AOT 构建的全程序编译和 tree-shaking 过程中，
    编译器追踪哪些标注了 `@RecordUse()` 的绑定
    在可执行代码中可达。
    位于被 tree-shake 掉的未使用 Dart 代码中的调用
    会被自动排除。

3.  **Prune unused native symbols in your link hook**:
    In your package's link hook (`hook/link.dart`),
    retrieve `input.recordedUses`.
    Using `package:record_use`,
    query recorded calls and instruct your native toolchain
    (such as `package:native_toolchain_c` or a Rust build script)
    to keep only the symbols that Dart actually calls:

    **在 link hook 中裁剪未使用的原生符号**：
    在 package 的 link hook（`hook/link.dart`）中，
    获取 `input.recordedUses`。
    使用 `package:record_use` 查询记录的调用，
    并指示你的原生工具链
    （如 `package:native_toolchain_c` 或 Rust 构建脚本）
    只保留 Dart 实际调用的符号：

    ```dart
    import 'package:hooks/hooks.dart';
    import 'package:native_toolchain_c/native_toolchain_c.dart';
    import 'package:record_use/record_use.dart';
    import 'package:my_package/src/c_library.dart';
    import 'package:my_package/src/record_use_mapping.dart';

    void main(List<String> arguments) async {
      await link(arguments, (input, output) async {
        // Extract symbols for functions called in reachable Dart code:
        final symbolsToKeep = input.recordedUses?.calls.keys
            .cast<Method>()
            .map((method) => recordUseMapping[method.name]!);

        await cLibrary.link(
          input: input,
          output: output,
          linkerOptions: LinkerOptions.treeshake(
            symbolsToKeep: symbolsToKeep,
          ),
        );
      });
    }
    ```

#### Why this matters

#### 为什么这很重要

- **Dramatically smaller binaries**:
  Heavy native dependencies like SQLite, cryptography, image decoders,
  or audio engines expose hundreds of functions.
  During release builds, the linker strips away unreferenced native code,
  dead object files, and unused exports.

  **显著更小的二进制文件**：
  SQLite、加密、图像解码器或音频引擎等重型原生依赖
  暴露数百个函数。在 release 构建中，
  链接器会剥离未引用的原生代码、无用的目标文件
  和未使用的导出。
- **Complete omission of unused native libraries**:
  If your application never invokes a package's native bindings,
  the link hook drops the native binary entirely
  from the final application bundle.

  **完全省略未使用的原生库**：
  如果你的应用从不调用某个 package 的原生绑定，
  link hook 会把该原生二进制文件从最终应用包中
  完全剔除。
- **Seamless tooling integration**:
  Tools like `ffigen` automatically annotate generated bindings,
  while `package:native_toolchain_c` integrates directly with
  link hooks for end-to-end native tree-shaking.

  **无缝的工具集成**：
  `ffigen` 等工具会自动标注生成的绑定，
  而 `package:native_toolchain_c` 直接与 link hooks 集成，
  实现端到端的原生 tree-shaking。

**Learn more:** [Native link hooks documentation](https://dart.dev/tools/hooks#link-hooks)
and [Record use documentation](https://pub.dev/packages/record_use)

**了解更多：**[原生 link hooks 文档](https://dart.dev/tools/hooks#link-hooks)
和 [Record use 文档](https://pub.dev/packages/record_use)

## Wrap up

## 总结

Dart 3.13 brings our vision for a simpler, cleaner developer experience to life.
By connecting expressive language features like
primary constructors with smarter tooling, richer pub.dev docs,
and compact native tree-shaking, this release helps you
focus on what matters most: building great apps.

Dart 3.13 让我们对更简单、更干净的开发体验的愿景落地。
通过把主构造函数等富有表现力的语言特性与更智能的工具、
更丰富的 pub.dev 文档和紧凑的原生 tree-shaking 结合起来，
这个版本帮你专注于最重要的事：构建优秀的应用。

Everything in this release is informed by your real-world insights,
bug reports, and package contributions.
The Dart ecosystem thrives because of your active participation,
and we're deeply grateful for your partnership in
shaping where the language goes next.

这个版本的一切都来自你的真实洞察、bug 报告
和 package 贡献。Dart 生态因你的积极参与而繁荣，
我们深深感谢你在塑造语言未来方向上的同行。

We can't wait to see what you create with Dart 3.13!
Take a moment to [update Dart](https://dart.dev/get-dart)
or run [`flutter upgrade`](https://docs.flutter.dev/install/upgrade) today,
and join the conversation on
our [GitHub issue tracker](https://github.com/dart-lang/sdk/issues).
Thank you for being such a passionate community and
building the future of Dart with us!

我们迫不及待想看到你用 Dart 3.13 创造的作品！
今天就花点时间[更新 Dart](https://dart.dev/get-dart)
或运行 [`flutter upgrade`](https://docs.flutter.dev/install/upgrade)，
并加入我们的
[GitHub issue 跟踪器](https://github.com/dart-lang/sdk/issues)
上的讨论。感谢你们组成如此热情的社区，
与我们一起构建 Dart 的未来！

**Learn more:** [Dart SDK changelog](https://github.com/dart-lang/sdk/blob/main/CHANGELOG.md#3130)

**了解更多：**[Dart SDK 更新日志](https://github.com/dart-lang/sdk/blob/main/CHANGELOG.md#3130)
