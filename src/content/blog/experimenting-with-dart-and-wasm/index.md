---
# title: "Experimenting with Dart and Wasm"
title: "Dart 与 Wasm 的实验"
# description: "Compiling Dart to Wasm, and calling Wasm modules from Dart"
description: "把 Dart 编译到 Wasm，以及从 Dart 调用 Wasm 模块"
ai-translated: true
publishDate: 2021-07-27
author: mit-mit
image: images/1UqHnD9vyTvndgJpz8gOv7Q.webp
category: other
layout: blog
---


*By Liam Appelbe & Michael Thomsen*

*作者：Liam Appelbe 与 Michael Thomsen*

[WebAssembly](https://webassembly.org/) (commonly abbreviated to Wasm) is *“a binary instruction format for a stack-based virtual machine”.* Although Wasm was originally designed for running native code on the web, Wasm has since evolved into a general technology for running compiled code across multiple platforms. Dart is already a highly portable and multi-platform language, so we’re very interested in how Wasm might enable us to extend these qualities of Dart.

[WebAssembly](https://webassembly.org/)（通常缩写为 Wasm）是
*“一种面向基于栈的虚拟机的二进制指令格式”*。
虽然 Wasm 最初是为在 Web 上运行原生代码而设计的，
但它后来已演变成一项跨多平台运行编译后代码的通用技术。
Dart 本身就是一门高度可移植的多平台语言，
所以我们非常感兴趣：Wasm 能否帮助我们进一步扩展 Dart 的这些特质。

## Why experiment with Wasm?

## 为什么要实验 Wasm？

Wasm has gained [broad support](https://webassembly.org/roadmap/) by browser vendors, such as Chrome, Edge, Firefox, and WebKit. This makes Wasm a very interesting prospect for running binary code in the browser. However, originally Wasm wasn’t designed for programming languages with garbage collection (GC), such as Dart and Java/Kotlin, making it difficult to efficiently compile GC-based languages to Wasm. By engaging with the Wasm project on their recent [GC proposal](https://github.com/WebAssembly/gc/blob/master/README.md), we’re hoping to both provide technical feedback on the proposal, and learn more about what gains we might get from running Dart-based web apps via Wasm code.

Wasm 已获得浏览器厂商的
[广泛支持](https://webassembly.org/roadmap/)，
如 Chrome、Edge、Firefox 和 WebKit。
这让 Wasm 成为在浏览器中运行二进制代码的极具吸引力的选择。
然而，Wasm 最初并不是为带垃圾回收（GC）的编程语言
（如 Dart 和 Java/Kotlin）设计的，
这使得把基于 GC 的语言高效编译到 Wasm 很困难。
通过参与 Wasm 项目最近的
[GC 提案](https://github.com/WebAssembly/gc/blob/master/README.md)，
我们希望既能为提案提供技术反馈，
也能更多地了解：通过 Wasm 代码运行基于 Dart 的 Web 应用
可能带来哪些收益。

A second quality of Wasm is that the binary Wasm modules are platform independent. This potentially makes interoperability with existing code more practical: If that existing code could be compiled to Wasm, then Dart apps across all platforms could depend on a single, shared binary Wasm module.

Wasm 的第二个特质是：二进制 Wasm 模块是平台无关的。
这有可能让与现有代码的互操作（interop）更加切实可行：
如果现有代码能编译到 Wasm，
那么所有平台上的 Dart 应用都可以依赖同一个共享的二进制 Wasm 模块。

In the remainder of this post we’ll discuss our experiments with Wasm and Dart in two forms:

在本文的剩余部分，我们将讨论 Wasm 与 Dart 两种形式的实验：

1) **Dart to Wasm compilation**: Extending our AOT compilers with support for compiling Dart source code to Wasm binary code (issue [32894](https://github.com/dart-lang/sdk/issues/32894)).

   **Dart 到 Wasm 的编译**：扩展我们的 AOT 编译器，
   支持把 Dart 源码编译为 Wasm 二进制代码
   （issue [32894](https://github.com/dart-lang/sdk/issues/32894)）。

2) **Dart to Wasm interop**: Support for calling from Dart code to compiled Wasm modules (issues [37355](https://github.com/dart-lang/sdk/issues/37355) & [37882](https://github.com/dart-lang/sdk/issues/37882)).

   **Dart 到 Wasm 的互操作**：支持从 Dart 代码调用编译好的 Wasm 模块
   （issue [37355](https://github.com/dart-lang/sdk/issues/37355)
   与 [37882](https://github.com/dart-lang/sdk/issues/37882)）。

<DashImage src="images/1UqHnD9vyTvndgJpz8gOv7Q.webp" alt="Diagram comparing Dart to Wasm compilation with Dart to Wasm interop through the Dart VM runtime." caption="Illustration of the two potential uses of Wasm with Dart" />


## Compiling Dart to Wasm

## 把 Dart 编译到 Wasm

As mentioned, Wasm originated as a way of running native code on the web. The web is traditionally powered by JavaScript code, which is run in a virtual machine (VM) that performs just-in-time (JIT) compilation of the JavaScript code to native code while the web app is running. In current Dart frameworks that target the web, such as [Flutter web](https://flutter.dev/web), the Dart app code is compiled to [optimized](https://dart.dev/web/deployment) JavaScript for deployment, and this JavaScript is then JIT-compiled by the web platform to native code when the app is running.

如前所述，Wasm 起源于在 Web 上运行原生代码的一种方式。
Web 传统上由 JavaScript 代码驱动，这些代码运行在虚拟机（VM）中，
虚拟机在 Web 应用运行时对 JavaScript 代码执行即时编译（JIT），
将其编译为原生代码。在当前面向 Web 的 Dart 框架中，
例如 [Flutter web](https://flutter.dev/web)，
Dart 应用代码会被编译成[优化过的](https://dart.dev/web/deployment)
JavaScript 用于部署，然后这段 JavaScript 在应用运行时
由 Web 平台 JIT 编译为原生代码。

We’re investigating compilation of Dart code directly to Wasm native code to see if we can get a more direct path to running native code on the web. The Wasm assembly format is low-level and closer than JavaScript to the abstraction level of machine code, which leads to improved startup time and generally a more predictable efficiency.

我们正在研究把 Dart 代码直接编译为 Wasm 原生代码，
看看能否得到一条在 Web 上运行原生代码的更直接路径。
Wasm 汇编格式非常底层，比 JavaScript 更接近机器码的抽象层级，
这带来了更好的启动时间，以及总体上更可预测的执行效率。

Dart’s support for compiling to Wasm is an early stage investigation and the compiler is incomplete, but we’re experimenting to learn. We’ve always had an interest in Wasm as a compilation target for Dart, but its original form doesn’t work well for languages with garbage collection. Wasm lacks built-in garbage collection support, so languages like Dart must include a garbage collection implementation into the compiled Wasm module. Including a GC implementation would be highly complex, would inflate the size of the compiled Wasm code and hurt startup time, and wouldn’t lend itself well to object-level interop with the rest of the browser system.

Dart 对编译到 Wasm 的支持还处于早期探索阶段，编译器尚不完整，
但我们正在通过实验来学习。我们一直对把 Wasm 作为 Dart
的编译目标感兴趣，但它最初的形态对带垃圾回收的语言并不友好。
Wasm 缺少内建的垃圾回收支持，所以像 Dart 这样的语言
必须把一份垃圾回收实现打包进编译出的 Wasm 模块。
包含 GC 实现会非常复杂，会增大编译后 Wasm 代码的体积、
拖累启动时间，也不利于与浏览器系统其余部分
进行对象级别的互操作。

Fortunately, an ongoing effort in the WebAssembly community, known as [Wasm GC](https://github.com/WebAssembly/gc/blob/master/README.md), is exploring the possibility of expanding Wasm with direct and performant support for garbage collected languages. Given our longstanding interest in Wasm, we saw an opportunity to engage the community and provide real-world experience by writing a compiler that translates Dart to Wasm GC.

幸运的是，WebAssembly 社区正在进行的一项工作——
[Wasm GC](https://github.com/WebAssembly/gc/blob/master/README.md)——
正在探索扩展 Wasm，为带垃圾回收的语言提供直接且高性能的支持。
鉴于我们对 Wasm 的长期兴趣，我们看到了一个参与社区、
提供真实世界经验的机会：编写一个把 Dart 翻译到 Wasm GC 的编译器。

It’s too early to predict where this might take us, but our initial prototyping is showing very positive results, with initial benchmarks showing both faster time to first frame and faster average frame time / throughput. If you’re interested in learning more about the project, take a look at the [wasm_prototype](https://github.com/askeksa-google/sdk/blob/wasm_prototype/dart2wasm.md) source code.

现在预测这将把我们带向何方还为时过早，
但初步原型展示了非常积极的结果：
早期基准测试显示首帧时间更快，平均帧时间/吞吐量也更快。
如果你有兴趣进一步了解这个项目，
可以看看 [wasm_prototype](https://github.com/askeksa-google/sdk/blob/wasm_prototype/dart2wasm.md)
的源码。

## Interoperability with Wasm code (package:wasm)

## 与 Wasm 代码互操作（package:wasm）

Besides compiling to Wasm, we’re also interested in investigating if Wasm can be used for integrating with existing code in a way that is more cross platform. Several languages support compiling to modules that follow the C calling convention, and with [Dart FFI](https://dart.dev/guides/libraries/c-interop) you have interoperability with these modules. Dart FFI can be a great way of leveraging existing source code and libraries, rather than having to reimplement the code in Dart.

除了编译到 Wasm，我们也有兴趣研究：
Wasm 能否以一种更跨平台的方式用于集成现有代码。
有几种语言支持编译为遵循 C 调用约定（calling convention）的模块，
而借助 [Dart FFI](https://dart.dev/guides/libraries/c-interop)
（外部函数接口），你就可以与这些模块互操作。
Dart FFI 是复用现有源码和库的绝佳方式，
而不必用 Dart 重新实现这些代码。

However, because C modules are platform specific, distributing shared packages with native C modules is complicated: it requires either a universal build system, or distributing multiple binary modules (one for each desired platform). Distribution would be much easier if a single Wasm binary assembly format could be used across all platforms. Then, rather than compiling your library to platform-specific binary code for every target platform, you could compile it once to a Wasm binary module and run that everywhere. This would potentially open the door to easy distribution on [pub.dev](https://pub.dev) of packages that contain native code.

然而，由于 C 模块是平台专属的，
分发包含原生 C 模块的共享 package 很复杂：
要么需要一套通用构建系统，要么分发多个二进制模块
（每个目标平台一个）。如果单一的 Wasm 二进制汇编格式
能在所有平台上使用，分发就会容易得多。
这样，你不必为每个目标平台把库编译成平台专属的二进制代码，
而是只需编译一次成 Wasm 二进制模块，就能到处运行。
这有可能为在 [pub.dev](https://pub.dev) 上
轻松分发包含原生代码的 package 打开大门。

We’re experimenting with support for Wasm interop in a new package, [`package:wasm`](https://pub.dev/packages/wasm). This prototype is built on the [Wasmer](https://wasmer.io/) runtime, and it supports [WASI](https://wasi.dev/) for OS interaction. Note that our current prototype is incomplete and supports only desktop platforms (Windows, Linux, and macOS).

我们正在一个新 package
[`package:wasm`](https://pub.dev/packages/wasm)
中实验 Wasm 互操作支持。这个原型构建在
[Wasmer](https://wasmer.io/) 运行时之上，
并支持通过 [WASI](https://wasi.dev/) 与操作系统交互。
注意，当前原型尚不完整，只支持桌面平台
（Windows、Linux 和 macOS）。

## Example: Calling into the Brotli compression library

## 示例：调用 Brotli 压缩库

Let’s take a look at an example of using `package:wasm` to leverage the [Brotli compression library](https://github.com/google/brotli), compiled to a Wasm module. In the example, we’ll read an input file, compress it, report its compression ratio, and then decompress it and verify we get the input back. See the GitHub repo for the full [sample source code](https://github.com/dart-lang/wasm/tree/main/example). Because `package:wasm` is built on top of [`dart:ffi`](https://dart.dev/guides/libraries/c-interop), you may find the steps familiar if you have experience with FFI.

我们来看一个例子：使用 `package:wasm` 调用编译为 Wasm 模块的
[Brotli 压缩库](https://github.com/google/brotli)。
在这个示例中，我们会读取一个输入文件，压缩它，报告压缩率，
然后解压并验证能还原出输入内容。
完整的[示例源码](https://github.com/dart-lang/wasm/tree/main/example)
见 GitHub 仓库。由于 `package:wasm` 构建在
[`dart:ffi`](https://dart.dev/guides/libraries/c-interop) 之上，
如果你有 FFI 经验，会对这些步骤感到熟悉。

There are a few ways of compiling C code to Wasm, but in this case we used [wasienv](https://github.com/wasienv/wasienv). Full details are available in the [README](https://github.com/dart-lang/wasm/blob/main/README.md).

把 C 代码编译到 Wasm 有几种方式，这里我们用的是
[wasienv](https://github.com/wasienv/wasienv)。
完整细节见 [README](https://github.com/dart-lang/wasm/blob/main/README.md)。

For this example, we’ll try to call these Brotli functions for compressing and decompressing data:

在这个示例中，我们要调用下面这些用于压缩和解压数据的 Brotli 函数：

```
int BrotliEncoderCompress(
  int quality, int lgwin, int mode, size_t input_size,
  const uint8_t* input_buffer, size_t* output_size,
  uint8_t* output_buffer);

int BrotliDecoderDecompress(
  size_t encoded_size, const uint8_t* encoded_buffer,
  size_t* output_size, uint8_t* output_buffer);
```


The `quality`, `lgwin`, and `mode` arguments are tuning parameters for the encoder. The details aren’t relevant to the example, so we’ll just use default values for these. Another thing to note is that `output_size` is an in-out parameter. When we call these functions, `output_size` must be initialized with the size of the `output_buffer` that we have allocated, and afterwards it will be set to the amount of the buffer that was actually used.

`quality`、`lgwin` 和 `mode` 参数是编码器的调优参数。
细节与本示例无关，所以我们直接使用默认值。
另一点需要注意的是 `output_size` 是一个输入输出（in-out）参数。
调用这些函数时，`output_size` 必须先初始化为我们分配的
`output_buffer` 的大小，调用之后它会被设置为
缓冲区实际使用的字节数。

The first step is to use our compiled Wasm binary to construct a `WasmModule` object. The binary data should be a `Uint8List`, which we can get by reading it from a file using `file.readAsBytesSync()`.

第一步是用编译好的 Wasm 二进制构造一个 `WasmModule` 对象。
二进制数据应当是一个 `Uint8List`，
可以通过 `file.readAsBytesSync()` 从文件读取获得。

```
var brotliPath = Platform.script.resolve(‘libbrotli.wasm’);
var moduleData = File(brotliPath.path).readAsBytesSync();
var module = WasmModule(moduleData);
```


A very useful debugging tool for making sure our Wasm module has the API we expect is `module.describe()`. This returns a string listing all of the module’s imports and exports.

要确认 Wasm 模块具备我们期望的 API，
一个非常有用的调试工具是 `module.describe()`。
它返回一个字符串，列出模块所有的导入和导出。

```
print(module.describe());
```


For our Brotli library, this is the output:

对我们的 Brotli 库，输出是这样的：

```
import function: int32 wasi_unstable::fd_close(int32)
import function: int32 wasi_unstable::fd_write(int32, int32, int32, int32)
import function: int32 wasi_unstable::fd_fdstat_get(int32, int32)
import function: int32 wasi_unstable::fd_seek(int32, int64, int32, int32)
import function: void wasi_unstable::proc_exit(int32)

export memory: memory
export function: int32 BrotliDecoderSetParameter(int32, int32, int32)
export function: int32 BrotliDecoderCreateInstance(int32, int32, int32)
export function: void BrotliDecoderDestroyInstance(int32)
export function: int32 BrotliDecoderDecompress(int32, int32, int32, int32)
…
export function: int32 BrotliEncoderSetParameter(int32, int32, int32)
export function: int32 BrotliEncoderCreateInstance(int32, int32, int32)
export function: void BrotliEncoderDestroyInstance(int32)
export function: int32 BrotliEncoderMaxCompressedSize(int32)
export function: int32 BrotliEncoderCompress(int32, int32, int32, int32, int32, int32, int32)

…
```


We can see that the module imports some WASI functions, and exports its memory and a bunch of Brotli functions. The two functions we’re interested in are exported, but their signature looks a bit different. This is because Wasm only supports 32-bit and 64-bit ints and floats. The pointers have become `int32` indexes into the exported memory.

可以看到，模块导入了一些 WASI 函数，
并导出了它的内存和一批 Brotli 函数。
我们感兴趣的两个函数确实被导出了，但签名看起来有点不一样。
这是因为 Wasm 只支持 32 位和 64 位的整数与浮点数。
指针变成了指向导出内存的 `int32` 索引。

The next step is to instantiate the module. During instantiation we must fill every import that the module is expecting. Instantiation uses the builder pattern `(module.instantiate(). initialization… .build())`. Our library only imports WASI functions, so we can just call `enableWasi()`:

下一步是实例化模块。实例化时必须填上模块期望的每一个导入。
实例化使用构建器（builder）模式
`(module.instantiate(). initialization… .build())`。
我们的库只导入 WASI 函数，所以直接调用 `enableWasi()` 即可：

```
var instance = module.instantiate().enableWasi().build();
```


If we had additional non-WASI function imports we could use `addFunction()` to import a Dart function into the wasm library.

如果还有额外的非 WASI 函数导入，
可以用 `addFunction()` 把一个 Dart 函数导入到 wasm 库中。

Now that we have a `WasmInstance`, we can look up any of its exported functions, or inspect its memory:

有了 `WasmInstance`，我们就可以查找它的任何导出函数，或查看它的内存：

```
var memory = instance.memory;
var compress = instance.lookupFunction(“BrotliEncoderCompress”);
var decompress = instance.lookupFunction(“BrotliDecoderDecompress”);
```


The next thing we want to do is use the compress and decompress functions on our input file. But we can’t pass the data directly to these functions. The C functions take `uint8_t` pointers to the data, but in Wasm code these pointers become `int32` indexes into the instance’s memory. Brotli also reports the size of the compressed and decompressed data using `size_t` pointers, which also become `int32`s.

接下来我们想对输入文件使用压缩和解压函数。
但不能把数据直接传给这些函数。
C 函数接收指向数据的 `uint8_t` 指针，
而在 Wasm 代码中这些指针变成了指向实例内存的 `int32` 索引。
Brotli 还通过 `size_t` 指针报告压缩和解压后数据的大小，
这些同样会变成 `int32`。

So to pass our data to the functions we have to copy it into the instance’s memory and pass its index to the function. We need 5 regions of memory: the input data, the compressed data, the compressed size, the decompressed data, and the decompressed size. For simplicity we’re just going to grab some unused areas of memory, but you could also export `malloc()` and `free()` in your library.

所以要把数据传给函数，我们必须把它复制进实例的内存，
并把索引传给函数。我们需要 5 块内存区域：
输入数据、压缩数据、压缩大小、解压数据和解压大小。
为简单起见，我们直接占用一些未使用的内存区域，
但你也可以在你的库中导出 `malloc()` 和 `free()`。

To make sure we’re putting the data in unused memory, we’re going to grow the instance memory and use the new region for our data:

为了确保数据放在未使用的内存里，
我们会增长实例内存，并把新区域用于我们的数据：

```
var inputPtr = memory.lengthInBytes;
memory.grow((3 * inputData.length /
    WasmMemory.kPageSizeInBytes).ceil());
var memoryView = memory.view;
var outputPtr = inputPtr + inputData.length;
var outSizePtr = outputPtr + inputData.length;
var decodedPtr = outSizePtr + 4;
var decSizePtr = decodedPtr + inputData.length;
```


Our memory regions look like this:

我们的内存区域看起来是这样的：

```
[initial instance memory][input][output][output size][decoded][decoded size]
```


Next, we load the input data in the memory, and call our compression function:

接下来，把输入数据加载进内存，并调用压缩函数：

```
memoryView.setRange(
    inputPtr, inputPtr + inputData.length, inputData);

var status = compress(kDefaultQuality, kDefaultWindow, kDefaultMode,
    inputData.length, inputPtr, outSizePtr, outputPtr);
```


The rest of the example works similarly. This is the result:

示例的其余部分工作方式类似。运行结果如下：

```
Loading lipsum.txt
Input size: 3210 bytes

Compressing…
Compression status: 1
Compressed size: 1198 bytes
Space saving: 62.68%

Decompressing…
Decompression status: 1
Decompressed size: 3210 bytes

Verifying decompression…
Decompression succeeded :)
```


## Trying package:wasm

## 试用 package:wasm

If you’re interested in trying Wasm interop, check out the `package:wasm` [README](https://pub.dev/packages/wasm) for instructions.

如果你有兴趣尝试 Wasm 互操作，
请查看 `package:wasm` 的
[README](https://pub.dev/packages/wasm) 获取使用说明。

## Roadmap

## 路线图

Both Wasm compilation and Wasm interop are experiments. If those experiments prove fruitful, we plan to continue to develop them and eventually productize them into stable, supported versions. However, if we learn that something doesn’t work as intended, or see a lack of interest, we’ll discontinue the experiments.

Wasm 编译和 Wasm 互操作都还是实验。
如果实验证明富有成果，我们计划继续开发，
并最终将它们产品化为稳定、受支持的版本。
但如果我们发现某些东西无法按预期工作，或者大家兴趣不大，
我们就会停止这些实验。

We’re making these experiments to learn, with two main components. First, we want to learn about the feasibility of technically supporting Wasm, and what the characteristics of this support might be. Can it make Dart code faster, smaller, or more predictable? Second, we’re interested in exploring what new technical capabilities Wasm might unlock, and what new use cases these might enable for Dart developers. Can we make interop with native code more portable?

我们做这些实验是为了学习，主要有两个方面。
第一，我们想了解在技术上支持 Wasm 的可行性，
以及这种支持可能具备什么特征。
它能让 Dart 代码更快、更小或更可预测吗？
第二，我们想探索 Wasm 可能解锁哪些新的技术能力，
以及这些能力能为 Dart 开发者带来哪些新用例。
我们能让与原生代码的互操作更具可移植性吗？

How do you think Wasm might apply to your needs? What do you think you’d use it for? We’d love to hear your thoughts. Please let us know on the [Dart misc discussion group](https://groups.google.com/a/dartlang.org/g/misc/).

你觉得 Wasm 能如何满足你的需求？你会想用它来做什么？
我们很想听听你的想法。请在
[Dart misc 讨论组](https://groups.google.com/a/dartlang.org/g/misc/)
告诉我们。
