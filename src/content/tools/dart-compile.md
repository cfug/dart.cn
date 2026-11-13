---
# title: dart compile
title: dart compile 命令
# description: Command-line tool for compiling Dart source code.
description: "用于编译 Dart 源代码的命令行工具。"
ai-translated: true
---

This guide describes how to use the `dart compile` command
to compile a Dart program to a target platform.

本指南介绍如何使用 `dart compile` 命令，
把 Dart 程序编译到目标平台。

## Overview

## 概览

:::note
If your package or any of its dependencies has [build hooks](/tools/hooks),
you must use the [`dart build`](/tools/dart-build) command.
The `dart compile exe` and `dart compile aot-snapshot` commands don't
run build hooks, and will fail if hooks are present.

如果你的 package 或其任何依赖带有 [构建钩子](/tools/hooks)，
就必须使用 [`dart build`](/tools/dart-build) 命令。
`dart compile exe` 和 `dart compile aot-snapshot` 命令
不会运行构建钩子，存在钩子时会失败。
:::

Use the `dart compile` command to compile
a Dart program to a [target platform](/overview#platform).
The output—which you specify using a subcommand—can 
either include a [Dart runtime][] or be a _module_
(also known as a _snapshot_).

使用 `dart compile` 命令可以把 Dart 程序
编译到 [目标平台](/overview#platform)。
输出（通过子命令指定）可以包含 [Dart 运行时][]，
也可以是一个 _模块_（也称为 _快照_）。

{% render 'tools/dart-tool-note.md' %}

Here's an example of using the `exe` subcommand
to produce a self-contained executable file (`myapp.exe`):

下面是使用 `exe` 子命令
生成独立可执行文件（`myapp.exe`）的例子：

```console
$ dart compile exe bin/myapp.dart
Generated: /Users/me/myapp/bin/myapp.exe
```

The next example uses the `aot-snapshot` subcommand to
produce an ahead-of-time (AOT) compiled module (`myapp.aot`).
It then uses the [`dartaotruntime` command](/tools/dartaotruntime)
(which provides a [Dart runtime][])
to run the AOT module:

下一个例子使用 `aot-snapshot` 子命令
生成提前编译（AOT）的模块（`myapp.aot`），
然后用 [`dartaotruntime` 命令](/tools/dartaotruntime)
（它提供 [Dart 运行时][]）来运行这个 AOT 模块：

```console
$ dart compile aot-snapshot bin/myapp.dart
Generated: /Users/me/myapp/bin/myapp.aot
$ dartaotruntime bin/myapp.aot
```

To specify the path to the output file,
use the `-o` or `--output` option:

要指定输出文件的路径，
请使用 `-o` 或 `--output` 选项：

```console
$ dart compile exe bin/myapp.dart -o bin/runme
```

For more options and usage information,
run `dart compile [<subcommand>] --help`:

要了解更多选项和用法信息，
请运行 `dart compile [<subcommand>] --help`：

```console
$ dart compile exe --help
```

:::note
You don't need to compile Dart programs before running them.
Instead, you can use the [`dart run` command][dart-run],
which uses the Dart VM's JIT (just-in-time) compiler—a 
feature that's especially useful during development.
For more information on AOT and JIT compilation,
see the [platforms discussion](/overview#platform).

运行 Dart 程序之前不必先编译。
你可以直接使用 [`dart run` 命令][dart-run]，
它使用 Dart VM 的 JIT（即时）编译器，
这个特性在开发期间尤其有用。
关于 AOT 和 JIT 编译的更多信息，
请参阅 [平台讨论](/overview#platform)。
:::

Refer to the [native_app][] sample for a simple example of using `dart compile`
to compile a native app, 
followed by examples of running the app.

参阅 [native_app][] 示例，
了解如何使用 `dart compile` 编译原生应用，
以及随后运行该应用的例子。

[native_app]: {{site.repo.dart.samples}}/tree/main/native_app
[dart-run]: /tools/dart-run

## Subcommands

## 子命令

The following table shows the subcommands of `dart compile`.

下表列出了 `dart compile` 的子命令。

<table class="table table-striped nowrap">
  <tr>
    <th> Subcommand </th> <th> Output </th> <th> More information </th>
  </tr>

  <tr>
    <th> 子命令 </th> <th> 输出 </th> <th> 更多信息 </th>
  </tr>
  <tr>
    <td> <code>exe</code> </td>
    <td> <span style="white-space: nowrap">Self-contained</span> executable </td>
    <td> A standalone, architecture-specific executable file containing the source code
      compiled to machine code and a small <a href="/overview#runtime">Dart runtime</a>.
      <br><em><a href="#exe">Learn more.</a></em>
    </td>
  </tr>

  <tr>
    <td> <code>exe</code> </td>
    <td> <span style="white-space: nowrap">独立</span>可执行文件 </td>
    <td> 独立、与特定架构绑定的可执行文件，
      包含编译为机器码的源代码
      和一个小型 <a href="/overview#runtime">Dart 运行时</a>。
      <br><em><a href="#exe">了解详情。</a></em>
    </td>
  </tr>
  <tr>
    <td style="white-space: nowrap"> <code>aot-snapshot</code> </td>
    <td style="white-space: nowrap"> AOT module </td>
    <td> An architecture-specific file containing the source code
      compiled to machine code, but <b>no Dart runtime</b>.
      <br><em><a href="#aot-snapshot">Learn more.</a></em>
    </td>
  </tr>

  <tr>
    <td style="white-space: nowrap"> <code>aot-snapshot</code> </td>
    <td style="white-space: nowrap"> AOT 模块 </td>
    <td> 与特定架构绑定的文件，包含编译为机器码的源代码，
      但<b>不含 Dart 运行时</b>。
      <br><em><a href="#aot-snapshot">了解详情。</a></em>
    </td>
  </tr>
  <tr>
    <td> <code>jit-snapshot</code> </td>
    <td> JIT module </td>
    <td> An architecture-specific file with
      an intermediate representation of all source code,
      plus an optimized representation of the source code
      that executed during a training run of the program.
      JIT-compiled code can have faster peak performance than AOT code
      if the training data is good.
      <br><em><a href="#jit-snapshot">Learn more.</a></em>
    </td>
  </tr>

  <tr>
    <td> <code>jit-snapshot</code> </td>
    <td> JIT 模块 </td>
    <td> 与特定架构绑定的文件，
      包含所有源代码的中间表示，
      以及程序在训练运行期间执行过的源代码的优化表示。
      如果训练数据足够好，JIT 编译的代码
      峰值性能可能比 AOT 代码更快。
      <br><em><a href="#jit-snapshot">了解详情。</a></em>
    </td>
  </tr>
  <tr>
    <td> <code>kernel</code> </td>
    <td> Kernel module </td>
    <td> A portable,
      <a href="{{site.repo.dart.sdk}}/blob/main/pkg/kernel/binary.md">intermediate representation</a>
      of the source code.
      <br><em><a href="#kernel">Learn more.</a></em>
    </td>
  </tr>

  <tr>
    <td> <code>kernel</code> </td>
    <td> Kernel 模块 </td>
    <td> 源代码的可移植
      <a href="{{site.repo.dart.sdk}}/blob/main/pkg/kernel/binary.md">中间表示</a>。
      <br><em><a href="#kernel">了解详情。</a></em>
    </td>
  </tr>
  <tr>
    <td> <code>js</code> </td>
    <td> JavaScript </td>
    <td> A deployable JavaScript file, 
      compiled from the source code.
      <br><em><a href="#js">Learn more.</a></em>
    </td>
  </tr>

  <tr>
    <td> <code>js</code> </td>
    <td> JavaScript </td>
    <td> 由源代码编译而来、可部署的 JavaScript 文件。
      <br><em><a href="#js">了解详情。</a></em>
    </td>
  </tr>
  <tr>
    <td> <code>wasm</code> </td>
    <td> WebAssembly </td>
    <td> A portable, binary instruction format for a stack-based virtual machine.
         Currently under development.
      <br><em><a href="/web/wasm">Learn more.</a></em>
    </td>
  </tr>

  <tr>
    <td> <code>wasm</code> </td>
    <td> WebAssembly </td>
    <td> 面向基于栈的虚拟机的可移植二进制指令格式。
         目前正在开发中。
      <br><em><a href="/web/wasm">了解详情。</a></em>
    </td>
  </tr>
</table>


## Types of output

## 输出类型

The following sections have details about each type of output
that `dart compile` can produce.

以下各节详细介绍 `dart compile`
可以生成的每种输出类型。


### Self-contained executables (exe) {:#exe}

### 独立可执行文件（exe）

The `exe` subcommand produces a standalone executable for
Windows, macOS, or Linux.
A **standalone executable** is native machine code that's compiled from
the specified Dart file and its dependencies,
plus a small [Dart runtime][] that handles
type checking and garbage collection.

`exe` 子命令为 Windows、macOS 或 Linux
生成独立的可执行文件。
**独立可执行文件** 是由指定 Dart 文件及其依赖
编译而来的原生机器码，
外加一个负责类型检查和垃圾回收的
小型 [Dart 运行时][]。

You can distribute and run the output file like you would
any other executable file.

你可以像分发和运行其他可执行文件一样，
分发和运行这个输出文件。

Compile your app and set the output file:

编译应用并设置输出文件：

```console
$ dart compile exe bin/myapp.dart -o /tmp/myapp
```

When successful, this command outputs the following:

命令成功执行后，会输出以下内容：

```console
Generated: /tmp/myapp
```

Run your compiled app from the `/tmp` directory:

从 `/tmp` 目录运行编译好的应用：

```console
$ ./tmp/myapp
```

<a id="cross-compilation" aria-hidden="true"></a>

#### Cross-compilation {: #cross-compilation-exe }

#### 交叉编译

:::version-note
Support for Linux ARM64 and x64 cross-compilation was introduced in Dart 3.8.

Support for Linux ARM and RISCV64 was introduced in Dart 3.9.

Linux ARM64 和 x64 的交叉编译支持从 Dart 3.8 开始引入。

Linux ARM 和 RISCV64 的支持从 Dart 3.9 开始引入。
:::

The following table shows which 64-bit host operating systems support
cross-compilation to which targets:

下表列出了哪些 64 位宿主操作系统
支持交叉编译到哪些目标：

{% assign y = '<span class="material-symbols system-support" title="Supported" aria-label="Supported">done</span>' %}

| 64-bit host OS | Linux ARM | Linux ARM64 | Linux RISCV64 | Linux x64 |
|----------------|-----------|-------------|---------------|-----------|
| Linux          |   {{y}}   |    {{y}}    |    {{y}}      |    {{y}}  |
| macOS          |   {{y}}   |    {{y}}    |    {{y}}      |    {{y}}  |
| Windows        |   {{y}}   |    {{y}}    |    {{y}}      |    {{y}}  |

{:.table .table-striped .nowrap}

| 64 位宿主操作系统 | Linux ARM | Linux ARM64 | Linux RISCV64 | Linux x64 |
|----------------|-----------|-------------|---------------|-----------|
| Linux          |   {{y}}   |    {{y}}    |    {{y}}      |    {{y}}  |
| macOS          |   {{y}}   |    {{y}}    |    {{y}}      |    {{y}}  |
| Windows        |   {{y}}   |    {{y}}    |    {{y}}      |    {{y}}  |

{:.table .table-striped .nowrap}

To use cross-compilation, include the following flags:

要使用交叉编译，请加上以下参数：

`--target-os=linux`
: The target operating system for the compiled executable.
  Only the Linux operating system is supported at this time.

`--target-os=linux`
: 编译出的可执行文件的目标操作系统。
  目前仅支持 Linux 操作系统。

`--target-arch=value`
: The target architecture for the compiled executable.
  The value for this flag can be:

  - `arm`: 32-bit ARM processor
  - `arm64`: 64-bit ARM processor
  - `riscv64`: 64-bit RISC-V (RV64GC) processor
  - `x64`: x86-64 processor

`--target-arch=value`
: 编译出的可执行文件的目标架构。
  该参数的取值可以是：

  - `arm`：32 位 ARM 处理器
  - `arm64`：64 位 ARM 处理器
  - `riscv64`：64 位 RISC-V（RV64GC）处理器
  - `x64`：x86-64 处理器

The following command demonstrates how to cross-compile a
standalone executable for a 64-bit Linux system:

下面的命令演示如何为 64 位 Linux 系统
交叉编译独立可执行文件：

```console
dart compile exe \
  --target-os=linux \
  --target-arch=x64 \
  hello.dart
```

Internally, this command downloads additional Dart SDK binaries and
caches them in the `~/.dart` directory.

在内部，这条命令会下载额外的 Dart SDK 二进制文件，
并把它们缓存到 `~/.dart` 目录。

Here's a sample output with the `--verbose` flag specified with
the command:

下面是给命令加上 `--verbose` 参数后的示例输出：

```console
Downloading https://storage.googleapis.com/dart-archive/channels/dev/signed/hash/...4864.../sdk/gen_snapshot_macos_arm64_linux_x64...
Downloading https://storage.googleapis.com/dart-archive/channels/dev/raw/hash/...64e44.../sdk/dartaotruntime_linux_x64...
Specializing Platform getters for target OS linux.
Generating AOT kernel dill.
Compiling /tmp/hello.dart to /tmp/hello.exe using format Kind.exe:
Generating AOT snapshot. path/to/dir/.dart/3.8.0-265.0.dev/gen_snapshot_macos_arm64_linux_x64 []
Generating executable.
Marking binary executable.
Generated: /tmp/hello.exe
```

#### Signing

#### 签名

Executables created with `dart compile exe`
support signing on macOS and Windows.

用 `dart compile exe` 创建的可执行文件
支持在 macOS 和 Windows 上签名。

To learn more about platform-specific code signing,
see the platform documentation for those operating systems:

要了解更多平台相关的代码签名信息，
请参阅这些操作系统的平台文档：

* Windows [`SignTool.exe` documentation][]

  Windows 平台参阅 [`SignTool.exe` documentation][]。
* [Apple Code Signing guide][]

  Apple 平台参阅 [Apple Code Signing guide][]。

[`SignTool.exe` documentation]: https://docs.microsoft.com/dotnet/framework/tools/signtool-exe
[Apple Code Signing guide]: {{site.apple-dev}}/support/code-signing/

#### Known limitations {: #known-limitations }

#### 已知限制

The `exe` subcommand has the following known limitations:

`exe` 子命令有以下已知限制：

* No support for `dart:mirrors` and `dart:developer`.
  For a complete list of the core libraries you can use,
  reference the [Multi-platform][] and [Native platform][] library tables.

  不支持 `dart:mirrors` 和 `dart:developer`。
  可用核心库的完整列表，
  请参阅 [多平台][Multi-platform] 和
  [原生平台][Native platform] 库表格。

* Cross-compilation is supported, but the target OS is limited to Linux.
  To learn more, check out [Cross-compilation][].

  支持交叉编译，但目标操作系统仅限 Linux。
  详情请参阅 [交叉编译][Cross-compilation]。

[Multi-platform]: /libraries#multi-platform-libraries
[Native platform]: /libraries#native-platform-libraries
[Cross-compilation]: #cross-compilation-exe

### AOT modules (aot-snapshot) {:#aot-snapshot}

### AOT 模块（aot-snapshot）

Use AOT modules to reduce disk space requirements when distributing
multiple command-line apps. The `aot-snapshot` subcommand produces an
output file specific to the current architecture on which you compile
your app.

分发多个命令行应用时，可以使用 AOT 模块
来减少磁盘空间占用。
`aot-snapshot` 子命令生成的输出文件
与编译应用时所在的当前架构绑定。

For example, if you use macOS to create a `.aot` file,
then that file can run on macOS only.
Dart supports AOT modules on Windows, macOS, and Linux.

例如，如果你用 macOS 创建 `.aot` 文件，
那么这个文件只能在 macOS 上运行。
Dart 在 Windows、macOS 和 Linux 上都支持 AOT 模块。

Compile your app and set the output file:

编译应用并设置输出文件：

```console
$ dart compile aot-snapshot bin/myapp.dart
```

When successful, this command outputs the following:

命令成功执行后，会输出以下内容：

```console
Generated: /Users/me/myapp/bin/myapp.aot
```

Run your compiled app from the `/bin` directory:

从 `/bin` 目录运行编译好的应用：

```console
$ dartaotruntime bin/myapp.aot
```

To learn more, see the
[`dartaotruntime` documentation](/tools/dartaotruntime).

要了解更多，请参阅
[`dartaotruntime` 文档](/tools/dartaotruntime)。

{% comment %}
  TODO: Get info from https://github.com/dart-lang/sdk/wiki/Snapshots
{% endcomment %}

#### Cross-compilation {: #cross-compilation-aot }

#### 交叉编译

Cross-compilation support for the `aot-snapshot` subcommand
is the same as what's available for the `exe` subcommand.
For more information, see
[Self-contained executables (exe)][cross-compile-exe].

`aot-snapshot` 子命令的交叉编译支持
与 `exe` 子命令相同。
更多信息请参阅
[独立可执行文件（exe）][cross-compile-exe]。

[cross-compile-exe]: #cross-compilation-exe

#### Known limitations {: #known-limitations-aot }

#### 已知限制

The `aot-snapshot` subcommand has the same limitations
as the `exe` subcommand. For more information, see
[Self-contained executables (exe)][known-limitations-exe]

`aot-snapshot` 子命令的限制与 `exe` 子命令相同。
更多信息请参阅
[独立可执行文件（exe）][known-limitations-exe]。

[known-limitations-exe]: #known-limitations

### JIT modules (jit-snapshot) {:#jit-snapshot}

### JIT 模块（jit-snapshot）

JIT modules include all the parsed classes and compiled code that's
generated during a training run of a program.

JIT 模块包含程序在训练运行期间
生成的所有已解析类和已编译代码。

```console
$ dart compile jit-snapshot bin/myapp.dart
Compiling bin/myapp.dart to jit-snapshot file bin/myapp.jit.
Hello world!
$ dart run bin/myapp.jit
Hello world!
```

When running from an application module,
the Dart VM doesn't need to parse or compile classes and functions that
were already used during the training run,
so the VM starts running user code sooner.

从应用模块运行时，
Dart VM 不必再解析或编译
训练运行期间已经用过的类和函数，
因此 VM 能更快开始执行用户代码。

These modules are architecture specific,
unlike modules produced using the
[`kernel` subcommand](#kernel).

与 [`kernel` 子命令](#kernel) 生成的模块不同，
这些模块与特定架构绑定。


### Portable modules (kernel) {:#kernel}

### 可移植模块（kernel）

Use the `kernel` subcommand to package up an app into a
single, portable file that
can be run on all operating systems and CPU architectures.
A kernel module contains a binary form of the abstract syntax tree
([Kernel AST][]) for a Dart program.

使用 `kernel` 子命令可以把应用打包成
单个可移植文件，
在所有操作系统和 CPU 架构上运行。
kernel 模块包含 Dart 程序抽象语法树
（[Kernel AST][]）的二进制形式。

Here's an example of creating and running a kernel module:

下面是创建并运行 kernel 模块的例子：

```console
$ dart compile kernel bin/myapp.dart
Compiling bin/myapp.dart to kernel file bin/myapp.dill.
$ dart run bin/myapp.dill
```

Although kernel modules have reduced startup time compared to Dart code,
they can have much slower startup than architecture-specific AOT output formats.

虽然 kernel 模块相比 Dart 代码能缩短启动时间，
但它们的启动速度可能比
与特定架构绑定的 AOT 输出格式慢得多。

[Kernel AST]: {{site.repo.dart.sdk}}/blob/main/pkg/kernel/README.md


### JavaScript (js) {:#js}

### JavaScript（js）

The `js` subcommand compiles Dart code to deployable JavaScript.

`js` 子命令把 Dart 代码编译为可部署的 JavaScript。

:::note
Use the [`webdev` tool][webdev] rather than running the 
Dart-to-JavaScript compiler directly.

请使用 [`webdev` 工具][webdev]，
而不要直接运行 Dart 到 JavaScript 的编译器。

* The [`webdev build`][] command, by default,
  produces minified, deployable JavaScript.

  [`webdev build`][] 命令默认生成
  经过压缩、可部署的 JavaScript。

* The [`webdev serve`][] command, by default,
  produces JavaScript modules for running and debugging during development.

  [`webdev serve`][] 命令默认生成
  用于开发期间运行和调试的 JavaScript 模块。
:::

{% render 'tools/dart-compile-js-options.md', site: site %}

#### Compiling web app example

#### 编译 Web 应用示例

For example, to compile a Dart application to optimized JavaScript, run
the following command:

例如，要把 Dart 应用编译为优化过的 JavaScript，
请运行以下命令：

```console
$ dart compile js -O2 -o out/main.js web/main.dart
```


#### Improving production web compilation {:#helping-generate-efficient-code}

#### 改进生产环境的 Web 编译

Follow these practices to improve type inference, reduce file size, and
improve JavaScript performance:

遵循以下实践可以改进类型推断、减小文件体积，
并提升 JavaScript 性能：

* Don't use `Function.apply()`.

  不要使用 `Function.apply()`。
* Don't override `noSuchMethod()`.

  不要重写 `noSuchMethod()`。
* Avoid setting variables to `null`.

  避免把变量设为 `null`。
* Be consistent with the types of arguments
  you pass into each function or method.

  传入每个函数或方法的参数类型要保持一致。

:::tip
Don't worry about the size of your app's included libraries.
The production compiler performs tree shaking to omit
unused classes, functions, methods, and so on.
Import the libraries you think you'll need,
and let the compiler get rid of what it doesn't need.

不必担心应用引入的库的体积。
生产环境编译器会进行 tree shaking，
剔除未使用的类、函数、方法等。
尽管引入你认为需要的库，
让编译器去掉不需要的部分。
:::

To learn more about building and deploying JavaScript applications,
check out [Web deployment](/web/deployment).

要了解更多构建和部署 JavaScript 应用的信息，
请参阅 [Web 部署](/web/deployment)。

[webdev]: /tools/webdev
[`webdev build`]: /tools/webdev#build
[`webdev serve`]: /tools/webdev#serve
[Dart runtime]: /overview#runtime
