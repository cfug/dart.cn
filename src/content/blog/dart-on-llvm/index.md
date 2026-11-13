---
# title: "Dart-on-LLVM"
title: "Dart-on-LLVM：用 LLVM 编译 Dart 的实验"
# description: "This is a story about an experiment to compile the Dart language using the LLVM compiler framework. On its face this is pretty pointless…"
description: "这是一个关于使用 LLVM 编译器框架编译 Dart 语言的实验故事。表面看来这相当没有意义……"
ai-translated: true
publishDate: 2017-01-11
author: erikcorry
image: images/1DN03P0ofCSyHM6UwB42Nyg.webp
category: deep-dive
layout: blog
---


This is a story about an experiment to compile the [Dart](https://www.dartlang.org/) language using the [LLVM](http://llvm.org/) compiler framework. On its face this is pretty pointless, since

这是一个关于使用 [LLVM](http://llvm.org/) 编译器框架编译
[Dart](https://www.dartlang.org/) 语言的实验故事。
表面看来这相当没有意义，因为

<DashImage src="images/1DN03P0ofCSyHM6UwB42Nyg.webp" alt="The Dart logo next to a metallic screw and a mechanical dragon (LLVM logo)." />


Dart already has an excellent [virtual machine](https://www.dartlang.org/dart-vm/tools/dart-vm) which uses [just-in-time](https://en.wikipedia.org/wiki/Just-in-time_compilation) compilation to get excellent performance. Since Dart is dynamically typed (more precisely, it’s [optionally typed](https://www.dartlang.org/articles/language/optional-types)), a JIT compiler is a natural fit — it can use the types available at runtime to perform optimizations that a static compiler can’t do.

Dart 已经拥有一个出色的
[虚拟机](https://www.dartlang.org/dart-vm/tools/dart-vm)，
它使用[即时编译](https://en.wikipedia.org/wiki/Just-in-time_compilation)（JIT）
获得极佳的性能。由于 Dart 是动态类型的
（更准确地说，它是[可选类型](https://www.dartlang.org/articles/language/optional-types)的），
JIT 编译器是天然之选——它可以利用运行时可得的类型信息，
执行静态编译器做不到的优化。

Another reason Dart-on-LLVM looks like a fool’s errand is that, despite the name, LLVM is not a virtual machine, and until recently it was not suitable for languages with garbage collection. By suitable, we mean:

Dart-on-LLVM 看起来像徒劳之举的另一个原因是：
尽管名字里有 VM，LLVM 并不是虚拟机，
而且直到最近它都不适合带垃圾回收（GC）的语言。
所谓适合，我们指的是：

* Moving, precise (non-leaking) GC

  移动式（moving）、精确（不泄漏）的 GC

* Highly optimized

  高度优化

This is because, once the optimizer had munged your code, you no longer had any way to find the GC-able pointers on the stack. A common strategy was to move all pointers to special memory areas, but this defeats many of the optimization strategies in a modern compiler, which relies on register allocation of local variables to work its magic. You could either have good GC or full performance, not both.

这是因为，一旦优化器把你的代码改得面目全非，
你就再也没有办法在栈上找到可被 GC 的指针。
常见策略是把所有指针移到特殊内存区域，
但这会让现代编译器的许多优化策略失效——
它们依靠对局部变量做寄存器分配来施展魔法。
你要么拥有好的 GC，要么拥有完整的性能，二者不可兼得。

New winds are blowing in LLVM-land, though. Recently, LLVM has grown some GC support in the form of the experimental [*Statepoint*](http://llvm.org/docs/Statepoints.html) feature. This has been used by various brave groups, including the people behind the [LLV8](https://github.com/ispras/llv8/wiki) experiment and [Azul](http://llvm.org/devmtg/2015-10/slides/DasReames-LLVMForAManagedLanguage.pdf), who are using it for a new top-tier compiler for their JVM.

不过，LLVM 世界正吹来新风。最近，LLVM 以实验性的
[*Statepoint*](http://llvm.org/docs/Statepoints.html)
特性的形式增加了一些 GC 支持。多个勇敢的团队已经用上了它，
包括 [LLV8](https://github.com/ispras/llv8/wiki) 实验背后的人们，
以及 [Azul](http://llvm.org/devmtg/2015-10/slides/DasReames-LLVMForAManagedLanguage.pdf)——
他们正用它为自家 JVM 打造新的顶级编译器。

<DashImage src="images/1g6p0yM6fD_UD3rfsOWGQ-A.webp" alt="The V8 engine logo next to a metallic screw and a mechanical dragon (LLVM logo)." />


It appears that building a real VM based on LLVM has gone from being “mission impossible” to being merely “[mission difficult](https://www.youtube.com/watch?v=gJGJMi-sUS8)”. At the same time, [strong mode](https://github.com/dart-lang/dev_compiler/blob/master/STRONG_MODE.md) makes Dart more statically typed, and less dynamic. Also, we at Google are building [Flutter](https://www.youtube.com/watch?v=Mx-AllVZ1VY&t=0m29s) for iOS, where JIT compilation is banned. Both these developments align Dart better with the LLVM project’s goals and trade-offs.

看起来，基于 LLVM 构建真正的 VM
已经从“不可能完成的任务”变成了仅仅是
“[困难的任务](https://www.youtube.com/watch?v=gJGJMi-sUS8)”。
与此同时，[强模式（strong mode）](https://github.com/dart-lang/dev_compiler/blob/master/STRONG_MODE.md)
让 Dart 更加静态类型化、更少动态性。
另外，我们 Google 正在为 iOS 构建
[Flutter](https://www.youtube.com/watch?v=Mx-AllVZ1VY&t=0m29s)，
而 iOS 禁止 JIT 编译。
这两项发展都让 Dart 与 LLVM 项目的目标和取舍更加契合。

## Why LLVM?

## 为什么选择 LLVM？

LLVM is a modern, well maintained Open Source compiler framework, which gives us a lot of optimization and platforms “for free”. For example, there’s a complete [inlining](http://llvm.org/docs/Passes.html#inline-function-integration-inlining) pass which can inline any function into any other, and contains [heuristics](https://bugs.chromium.org/p/v8/issues/detail?id=3354) for when to do so.

LLVM 是一个现代、维护良好的开源编译器框架，
它让我们“免费”获得大量优化和平台支持。
例如，它有一个完整的
[内联](http://llvm.org/docs/Passes.html#inline-function-integration-inlining)（inlining）
优化阶段（pass），可以把任何函数内联进任何其他函数，
并包含判断何时内联的
[启发式规则](https://bugs.chromium.org/p/v8/issues/detail?id=3354)。

It also looks like an open, welcome community, which welcomes contributions.

它看起来也是一个开放、友好的社区，欢迎各种贡献。

## Goals of the experiment

## 实验目标

* The context is Strong Mode Dart in an ahead-of-time compiled scenario

  背景是强模式 Dart 在预先编译（AOT）场景下的使用

* Evaluate the feasibility of using Statepoint support for precise, moving GC

  评估利用 Statepoint 支持实现精确、移动式 GC 的可行性

* Evaluate performance

  评估性能

## Methodology

## 方法

We ([Erik Corry](https://twitter.com/erikcorry) and Dmitry Olshansky) based our experiment on the discontinued “[Dartino](https://github.com/dartino/sdk)” runtime. This was an experimental Dart runtime optimized for small devices. It had a few advantages for us over using the DartVM as a basis:

我们（[Erik Corry](https://twitter.com/erikcorry) 和 Dmitry Olshansky）
的实验基于已停止维护的
“[Dartino](https://github.com/dartino/sdk)”运行时。
这是一个为小型设备优化的实验性 Dart 运行时。
相比以 DartVM 为基础，它对我们有几个优势：

* There was already an experimental LLVM backend for Dartino, built by [Martin Kustermann](https://medium.com/@kustermann.martin). This had no GC support, so it crashed when it ran out of memory.

  Dartino 已经有一个由
  [Martin Kustermann](https://medium.com/@kustermann.martin)
  构建的实验性 LLVM 后端。
  它没有 GC 支持，所以内存耗尽时就会崩溃。

* Dartino makes use of a lot of the machinery of [Dart2JS](https://webdev.dartlang.org/tools/dart2js), and so it doesn’t need a complete parser, front end etc. The Dartino bytecodes we use as input already have a lot of difficult Dart features lowered away. For example, closures are objects, and optional arguments have been turned into different versions of functions.

  Dartino 复用了 [Dart2JS](https://webdev.dartlang.org/tools/dart2js)
  的大量机制，因此不需要完整的解析器、前端等。
  我们用作输入的 Dartino 字节码已经把许多棘手的 Dart 特性
  降级（lower）掉了。例如，闭包就是对象，
  可选参数已经变成了不同版本的函数。

* We were both already familiar with Dartino.

  我们俩都已经熟悉 Dartino。

* Dartino comes with a relatively complete runtime and is capable of running large apps, eg hosting Dart2JS. It doesn’t have a lot of Unix IO support and the threading model is different, so it is not a drop-in replacement.

  Dartino 自带一个相对完整的运行时，能够运行大型应用，
  例如承载 Dart2JS。它的 Unix IO 支持不多，线程模型也不同，
  所以并不是一个即插即用的替代品。

## Garbage Collection in Dartino

## Dartino 中的垃圾回收

The existing Dartino LLVM experiment was forked from Dartino a while back, when the GC was very simple (semispace [Cheney collector](https://en.wikipedia.org/wiki/Cheney's_algorithm), no generations, big pauses, 2x memory footprint overhead). We cherry-picked changes from the main Dartino branch to get a more conventional 2-generation GC with write barriers. There are no read barriers, and collection is stop-the-world, without concurrent GC (though LLVM Statepoints do look to have support for these features, and they are almost certainly being used by Azul in their closed source VM).

现有的 Dartino LLVM 实验是前段时间从 Dartino 分叉出来的，
当时 GC 非常简单（半空间
[Cheney 收集器](https://en.wikipedia.org/wiki/Cheney's_algorithm)，
无分代，停顿很大，内存占用有 2 倍开销）。
我们从 Dartino 主分支 cherry-pick 了一些改动，
得到更常规的带写屏障（write barrier）的两代 GC。
没有读屏障（read barrier），回收是全局暂停（stop-the-world）的，
没有并发 GC（不过 LLVM Statepoints 看起来确实支持这些特性，
Azul 在其闭源 VM 中几乎肯定用到了它们）。

We did not cherry pick the compacting old-generation support from newer Dartino versions.

我们没有 cherry-pick 较新 Dartino 版本中的老年代压缩（compacting）支持。

<DashImage src="images/1VqmfjhoN9cMWH0vz37zU6A.webp" alt="A miniature model of a street with two toy garbage trucks and toy people, symbolizing garbage collection." />


## Architecture

## 架构

<DashImage src="images/1pyM5bJo-_-i8Leum4yHPOQ.webp" alt="A flowchart diagram of the Dart-on-LLVM compilation pipeline from Dart source to Dartino bytecodes, LLVM bitcode, assembler, and machine code." />


The above pipeline shows the path from Dart source to machine code. In a real implementation, the first parts would be replaced by something based on the ‘[kernel](https://github.com/dart-lang/sdk/tree/master/pkg/kernel)’ format (preparsed Dart source frontend).

上面的流水线展示了从 Dart 源码到机器码的路径。
在真正的实现中，前面的部分会被基于
‘[kernel](https://github.com/dart-lang/sdk/tree/master/pkg/kernel)’
格式（预解析的 Dart 源码前端）的方案取代。

### Translation to LLVM and high level optimization

### 翻译到 LLVM 与高层优化

llvm-codegen is linked to our own copy of LLVM, and performs high level optimizations. At this stage, LLVM maintains the fiction that pointers are valid across GCs, but the pointers are marked with a non-default “address space” which prohibits LLVM from reasoning about their bit patterns in ways that would be incorrect in the presence of moving GC. Various custom LLVM intrinsics are used to mark points where GC can occur.

llvm-codegen 链接到我们自己的 LLVM 副本，执行高层优化。
在这个阶段，LLVM 维持着“指针在 GC 前后仍然有效”的假象，
但这些指针被标记为非默认的“地址空间”（address space），
禁止 LLVM 以在移动式 GC 存在时会出错的方式推断它们的位模式。
各种自定义的 LLVM 内建函数（intrinsic）
被用来标记可能发生 GC 的位置。

Because of tagged pointers, the LLVM bitcode is very ugly with lots of casts and adds. Therefore this document contains “LLVM pseudocode”, and not the true .ll file. If you are used to actual .ll files this is going to look like “Baby’s first .ll babblings”, sorry! The following represents the code for a dynamic dispatch after mem2reg, the pass that lifts local variables from the stack into [SSA](https://en.wikipedia.org/wiki/Static_single_assignment_form) registers:

由于带标签指针（tagged pointer）的存在，
LLVM 位码（bitcode）非常难看，充满各种类型转换和加法。
因此本文给出的是“LLVM 伪代码”，而不是真正的 .ll 文件。
如果你习惯了真实的 .ll 文件，
这看起来会像“婴儿的第一串 .ll 呓语”，抱歉！
下面展示的是经过 mem2reg（把局部变量从栈提升到
[SSA](https://en.wikipedia.org/wiki/Static_single_assignment_form)
寄存器的优化阶段）之后，一次动态分派的代码：

```llvm
%class = load_class(%this)
%id = load_class_id(%class)
%offset = add 291, %id
%code = array_load(@dartino_vtable, %offset)
%method_result = call %code(%process, %16)
; We can still use “%this” here, even if there has been a GC in the call
```

After the optimizer has run, the rather laborious lookup above has been lifted out of the loop, leaving only the call instruction. This is possible because class pointers are immutable in Dart and we have attached various metadata to the load instructions (not shown), including `invariant.load`and `never.faults`(the latter is an addition to our [patched version of LLVM](https://github.com/ErikCorryGoogle/llvm)).

优化器运行之后，上面那套相当费力的查找已被提升出循环，
只剩下 call 指令。这之所以可行，是因为 Dart 中类指针是不可变的，
而且我们给 load 指令附加了各种元数据（未展示），
包括 `invariant.load` 和 `never.faults`
（后者是我们[打过补丁的 LLVM 版本](https://github.com/ErikCorryGoogle/llvm)
中新增的）。

### Lowering

### 降级（Lowering）

Once high level optimizations have been run, we lower most of the intrinsics to normal LLVM instructions. For example, the write barrier is reduced to a series of stores (Dartino uses a card marking scheme that owes a lot to [Urs](https://medium.com/@urs.hoelzle)’ [PhD](http://hoelzle.org/publications/urs-thesis.pdf) section 6.2.3). After lowering, every local-variable pointer is rewritten by an opaque intrinsic at every possible GC point (every call, basically). This inhibits a lot of optimizations (which is why we had to do optimization passes before lowering), but serves two purposes:

高层优化运行完毕后，我们把大多数内建函数降级为普通 LLVM 指令。
例如，写屏障被简化为一系列 store
（Dartino 使用的卡标记（card marking）方案很大程度上得益于
[Urs](https://medium.com/@urs.hoelzle) 的
[博士论文](http://hoelzle.org/publications/urs-thesis.pdf)第 6.2.3 节）。
降级之后，每个局部变量指针都会在每个可能的 GC 点
（基本就是每次调用）被一个不透明（opaque）的内建函数重写。
这会抑制很多优化（这也是我们必须在降级之前做优化的原因），
但有两个目的：

* The intrinsic will later be used to generate stack maps, detailing the location of GC-able pointers on the stack.

  这个内建函数之后会被用来生成栈映射（stack map），
  详细记录可被 GC 的指针在栈上的位置。

* The SSA values are broken up into before-GC and after-GC values, which makes the GC visible to the optimizer and prevents invalid codegen.

  SSA 值被拆分为 GC 前和 GC 后的值，
  这让优化器能“看见”GC，防止生成非法代码。

The call now looks more like this (the dispatch has been hoisted out of a loop, so `%code` contains the code pointer — the loop is not shown)

现在调用看起来更像这样
（分派已被提升出循环，所以 `%code` 里是代码指针——循环未展示）：

```llvm
%statepoint_token = call token (…) @llvm.experimental.gc.statepoint(326, 0, %code, 3, 0, %process, %this, %16)
%method_result = call @llvm.experimental.gc.result(token %statepoint_token)
%this.relocated = call coldcc @llvm.experimental.gc.relocate(token %statepoint_token, 10, 10) ; (%this, %this)
%16.relocated = call coldcc @llvm.experimental.gc.relocate(token %statepoint_token, 11, 11) ; (%16, %16)
; We now have to use %this.relocated instead of %this,
; and %16.relocated instead of %16
```

The transformation is rather clumsy, creating a special token in the transformed call, and using that as an argument in the calls to `gc.result` and `gc.relocate`. The GC-able pointers are still specially marked (with a non-zero address space, not shown in the pseudo-LLVM above), which inhibits some optimizations at the next stage.

这种变换相当笨拙：在变换后的调用中创建一个特殊的 token，
再把它作为参数传给 `gc.result` 和 `gc.relocate` 调用。
可被 GC 的指针仍然被特殊标记
（用非零地址空间，上面的伪 LLVM 中未展示），
这会抑制下一阶段的一些优化。

### Code generation

### 代码生成

The final step is code generation, performed by the LLVM program `llc`. This step can be done by a completely unpatched ToT LLVM with the command `llc -O3`. The only backend with support for the experimental GC intrinsics is currently x64, but we don’t see any fundamental barriers to adding and upstreaming ARM support. The dynamic dispatch call site now looks like:

最后一步是代码生成，由 LLVM 程序 `llc` 完成。
这一步可以用完全未打补丁的 LLVM 最新源码（ToT）构建，
通过 `llc -O3` 命令完成。
目前唯一支持实验性 GC 内建函数的后端是 x64，
但我们认为添加 ARM 支持并合入上游不存在根本性障碍。
动态分派调用点现在看起来是：

```unix assembly
movq %rdx, (%rsp)
movq %rcx, 8(%rsp)
movq %rdx, 16(%rsp)
movq %rbx, %rdi
movq %rcx, %rsi
callq *%r14
```

This uses the standard (mostly register-based) calling convention for x64. Before every call, a bunch of registers are spilled to the stack, where they can be moved by the GC if needed. There is no support for callee-saved GC-able values (V8 and DartVM don’t support this either).

这里使用的是 x64 标准（主要基于寄存器的）
调用约定（calling convention）。每次调用之前，
一批寄存器被溢出（spill）到栈上，必要时 GC 可以移动它们。
不支持由被调用方保存（callee-saved）的可 GC 值
（V8 和 DartVM 也不支持）。

## Performance

## 性能

Dartino byte code is optimized for simplicity and compactness in a very dynamically typed environment. For this analysis we attempt to look forward to a scenario where strong mode is used, and types are known when compiling. In this scenario, dispatch of methods and access to member variables on objects would be simpler and faster. In order to get closer to that scenario, we are making use of some whole program analyses when generating LLVM code.

Dartino 字节码针对高度动态类型环境下的简单性和紧凑性做了优化。
在这次分析中，我们尝试展望强模式启用、编译时类型已知的场景。
在那种场景下，对象上的方法分派和成员变量访问会更简单、更快。
为了更接近那种场景，我们在生成 LLVM 代码时
使用了一些全程序分析（whole program analysis）。

The most important consequence of this is that if only a few classes have a method `foo()`, then we check for those classes and call the `foo()` method directly. Unlike some vtable-like dispatch mechanism, this lets LLVM inline the method where it makes sense. This is a huge win, especially for [getters and setters](https://www.dartlang.org/resources/dart-tips/dart-tips-ep-10), which are a great feature of Dart.

由此带来的最重要结果是：如果只有少数几个类拥有 `foo()` 方法，
我们就检查这些类并直接调用 `foo()` 方法。
与类似虚表（vtable）的分派机制不同，
这让 LLVM 可以在合适的地方内联该方法。
这是巨大的胜利，尤其是对 Dart 的出色特性
[getter 和 setter](https://www.dartlang.org/resources/dart-tips/dart-tips-ep-10)
而言。

The compiler still has to handle a lot of dynamic-language issues, which it does mostly correctly (see test status section below). In particular, integers can overflow and become real heap allocated number objects at any time. Together with the overloading of operators this makes even simple for-loops rather complicated. More static analysis can probably improve this.

编译器仍然必须处理大量动态语言问题，
而且大体上处理正确（见下文测试状态一节）。
特别是，整数随时可能溢出并变成真正堆分配的数字对象。
再加上运算符重载，这让哪怕简单的 for 循环都相当复杂。
更多的静态分析也许能改善这一点。

One difference to the real DartVM is that we don’t check for stack overflows and we don’t check for thread interruptions on loop back edges. Based on experience from V8 we guesstimate that fixing this could cost about 10% performance.

与真正的 DartVM 的一个区别是：我们不检查栈溢出，
也不在循环回边（loop back edge）检查线程中断。
根据 V8 的经验，我们粗略估计补上这些可能损失约 10% 的性能。

<DashImage src="images/1_B_KUgeFwaeUxC97GBIHPw.webp" alt="A bar chart comparing DeltaBlue, Richards, and Mini-Splay benchmark results for LLVM AOT, Dart AOT, and DartVM JIT." />


We compare against the regular JITing DartVM, and the new ahead-of-time support that has been added to the DartVM for [Flutter](https://flutter.io/). Benchmarks are [from Dartino](https://github.com/dartino/sdk/tree/master/benchmarks).

我们对比的对象是常规的 JIT 版 DartVM，
以及 DartVM 为 [Flutter](https://flutter.io/) 新增的预先编译支持。
基准测试[来自 Dartino](https://github.com/dartino/sdk/tree/master/benchmarks)。

<DashImage src="images/1uB5TngqsrAvvzu_fr8KCdg.webp" alt="A bar chart comparing 'Hello World' total run time for LLVM AOT, Dart AOT, and DartVM JIT." />


Running a short lived program like Hello World shows mainly the time to do startup. The JIT-based system spends time compiling code, and both the non-LLVM solutions here are deserializing a data heap on startup.

运行 Hello World 这样的短命程序，主要体现的是启动时间。
基于 JIT 的系统要花时间编译代码，
而这里两个非 LLVM 方案都要在启动时反序列化数据堆。

## Performance Conclusions

## 性能结论

We have comparable performance to Flutter’s existing ahead-of-time technology (which is a moving target — these measurements were made in late November 2016 on a beefy 64 bit Linux workstation). The JIT is still a long way ahead. The garbage collection performance of the Dartino fork we are running on, is not up to speed.
We also measured startup time. Dartino-LLVM generates static data for the classes, constants, and dispatch tables. These are loaded by the highly optimized [ld.linux](https://www.cs.virginia.edu/~dww4s/articles/ld_linux.html) runtime linker, and they load faster than the current Dart AOT data heap snapshot, giving very good performance for startup. For the startup tests the CPU governor was set to “performance”.

我们的性能与 Flutter 现有的 AOT 技术相当
（那是个不断移动的目标——这些测量是 2016 年 11 月下旬
在一台强劲的 64 位 Linux 工作站上进行的）。
JIT 仍然遥遥领先。我们所运行的 Dartino 分叉的垃圾回收性能
还跟不上。
我们还测量了启动时间。Dartino-LLVM 为类、常量和分派表
生成静态数据。这些数据由高度优化的
[ld.linux](https://www.cs.virginia.edu/~dww4s/articles/ld_linux.html)
运行时链接器加载，比当前 Dart AOT 的数据堆快照加载得更快，
因此启动性能非常好。启动测试时 CPU 调度器（governor）
设置为 “performance”。

## A note on compatibility

## 关于兼容性的说明

For this study we have not been especially focused on getting 100% Dart compatibility. It is sufficient to do the “hard things” i.e. GC and exception handling, to prove they are possible. In some cases we took a shortcut that showed a real solution was possible without wasting time on actually implementing the real solution. Here are some places we compromised:

在这项研究中，我们没有特别追求 100% 的 Dart 兼容性。
只要把“困难的事情”（即 GC 和异常处理）做出来，
证明它们可行就足够了。有些情况下我们走了捷径，
展示真正的解决方案是可行的，
而不浪费时间实际实现完整方案。以下是我们妥协的一些地方：

* Like Dartino we don’t have infinite-precision integers. However, we do check all int operations for overflow and switch dynamically to a boxed number representation (however, the boxed representation is only 64 bit, wrapping).

  和 Dartino 一样，我们没有无限精度整数。
  不过，我们确实会检查所有 int 运算是否溢出，
  并动态切换到装箱（boxed）的数字表示
  （但装箱表示只有 64 位，会回绕）。

* On no-such-method (a failed type check, essentially), we don’t follow the full Dart semantics, which includes calling the no-such-method method and checking for a getter, that has the same name as the missing method and returns an object with a ‘call’ method. However, we do throw an exception at a safe point (a point where allocation can take place).

  对于 no-such-method（本质上是一次失败的类型检查），
  我们没有遵循完整的 Dart 语义——完整语义包括调用
  no-such-method 方法，并检查是否存在与缺失方法同名、
  返回带 ‘call’ 方法对象的 getter。
  不过，我们确实会在安全点（safe point，
  可以发生内存分配的位置）抛出异常。

* We don’t check for stack overflow on calls, or check for interruptions on loop back edges. LLVM does have experimental support for these. The solutions we are comparing against do support this. Experience from V8 suggests that fixing this might cause about 10% performance degradation.

  我们不在调用时检查栈溢出，也不在循环回边检查中断。
  LLVM 对这些有实验性支持。我们对比的方案都支持这些。
  V8 的经验表明，补上这些可能带来约 10% 的性能下降。

* Our front-end compiler is a modified Dart2JS. Since Dartino was discontinued, it has not kept up with the latest changes to the language, and so there are some tests we cannot run.

  我们的前端编译器是修改过的 Dart2JS。
  由于 Dartino 已停止维护，它没有跟上语言的最新变化，
  因此有些测试我们无法运行。

* Dart exception handling is fully implemented apart from the no-such-method related exceptions. For this we used the exception handling support built into LLVM, which looks adequate for the task and well aligned to Dart’s exception model (which is at heart not so different from C++, for which LLVM was designed).

  除了与 no-such-method 相关的异常之外，
  Dart 异常处理已完整实现。为此我们使用了 LLVM 内建的
  异常处理支持，它看起来足以胜任，
  并且与 Dart 的异常模型高度契合
  （该模型本质上与 C++ 差别不大，而 LLVM 正是为 C++ 设计的）。

<DashImage src="images/14bthU0tgek2j09dJuKn-aQ.webp" alt="A pie chart showing that 88.4% of Dartino tests are passing." />


In all, we pass almost 90% of the tests that Dartino could pass. Of the ones we fail, the biggest reasons are problems with the compiler front-end and problems handling no-such-method events.

总的来说，Dartino 能通过的测试中，我们通过了近 90%。
在失败的测试中，最大的原因是编译器前端的问题
和处理 no-such-method 事件的问题。

Of the ca 11.6% tests that fail, here is a breakdown of why they fail:

在约 11.6% 的失败测试中，失败原因的分布如下：

<DashImage src="images/1f_vtnoVYGfdXXqPUaGrOGw.webp" alt="Pie chart of failing Dartino tests: Dart2JS at 40.1%, NoSuchMethod at 37.4%, Async at 15.4%, and smaller categories." />


## Conclusions

## 结论

The experimental LLVM GC support appears to be fully functional on x64.
Performance of the prototype was on a par with our more mature DartVM-based ahead-of-time solution.

实验性的 LLVM GC 支持在 x64 上看起来功能完备。
原型的性能与我们更成熟的基于 DartVM 的 AOT 方案不相上下。

For the performance analysis we are making no use of Dart strong mode, which can be expected to yield optimization opportunities that play to LLVM’s strengths. We are, however, making use of some closed world assumptions, which we think are realistic.

在性能分析中，我们完全没有利用 Dart 强模式，
而强模式有望带来能发挥 LLVM 长处的优化机会。
不过，我们确实利用了一些封闭世界假设（closed world assumption），
我们认为这些假设是现实的。

We are able to compile the last stage from LLVM bitcode to machine code using only an unpatched LLVM ToT build (marked in blue on the pipeline diagram above). The optimizations performed at this stage (-O3) did not cause any miscompilations or GC issues that we observed.

从 LLVM 位码到机器码的最后一个阶段，
我们只用未打补丁的 LLVM ToT 构建就能完成编译
（在上面的流水线图中以蓝色标出）。
这一阶段执行的优化（-O3）没有造成我们观察到的
任何错误编译或 GC 问题。

## Future

## 未来

There has been no decision on how and whether to use this approach for Dart or Flutter, but here are some random thoughts on interesting avenues that could be explored.

关于是否以及如何在 Dart 或 Flutter 中使用这一方案，
目前还没有决定，但这里有一些关于值得探索的有趣方向的随想。

* Having a home-grown language other than C++-with-handles to write runtime routines. The back-end would be LLVM-with-Statepoints. (There is a little Forth experiment in the current branch, but something more beefy would be needed to write more than the very simplest native routines in).

  用一门自研语言（而不是带句柄的 C++）来编写运行时例程。
  后端将是带 Statepoints 的 LLVM。
  （当前分支里有一个小小的 Forth 实验，
  但要编写比最简单的原生例程更复杂的东西，
  还需要更强大的语言。）

* What impact would wrapping 64 bit integers have?

  64 位整数回绕（wrapping）会带来什么影响？

* How can we use whole-program knowledge to generate code while still allowing parallel compilation of large projects?

  如何在利用全程序知识生成代码的同时，仍然允许大型项目并行编译？

## References

## 参考资料

LLVM GC support [http://llvm.org/docs/Statepoints.html](http://llvm.org/docs/Statepoints.html)
Dartino-LLVM repository [https://github.com/dartino/sdk/tree/llvm](https://github.com/dartino/sdk/tree/llvm)
Modified LLVM repo [https://github.com/ErikCorryGoogle/llvm](https://github.com/ErikCorryGoogle/llvm)
Urs Hölzle PhD: [http://hoelzle.org/publications/urs-thesis.pdf](http://hoelzle.org/publications/urs-thesis.pdf)
LLV8: [https://github.com/ispras/llv8](https://github.com/ispras/llv8)

LLVM GC 支持：[http://llvm.org/docs/Statepoints.html](http://llvm.org/docs/Statepoints.html)
Dartino-LLVM 仓库：[https://github.com/dartino/sdk/tree/llvm](https://github.com/dartino/sdk/tree/llvm)
修改版 LLVM 仓库：[https://github.com/ErikCorryGoogle/llvm](https://github.com/ErikCorryGoogle/llvm)
Urs Hölzle 博士论文：[http://hoelzle.org/publications/urs-thesis.pdf](http://hoelzle.org/publications/urs-thesis.pdf)
LLV8：[https://github.com/ispras/llv8](https://github.com/ispras/llv8)
