---
# title: "Dart DevTools: Analyzing application performance with the CPU Profiler"
title: "Dart DevTools：使用 CPU 分析器分析应用性能"
# description: "Whether you’re a backend developer writing a command line tool using Dart, or a UX engineer building applications with Flutter, program performance is critical to the success of your project. Command line tools should minimize latency and apps should be responsive and snappy with no dropped frames. As developers, we try our best to write performant code but sometimes it’s not clear why our code isn’t performing as well as we would expect."
description: "无论你是用 Dart 编写命令行工具的后端开发者，还是用 Flutter 构建应用的 UX 工程师，程序性能都是项目成功的关键。命令行工具应尽量降低延迟，应用应当响应迅速、流畅无掉帧。作为开发者，我们尽力编写高性能的代码，但有时并不清楚为什么代码的表现不如预期。"
ai-translated: true
publishDate: 2023-06-12
author: bkonyi
image: images/04btaxCBW8Btx71RM.webp
category: deep-dive
layout: blog
---


Tracking down performance issues in a code base can be a daunting task. There are multiple ways to write Flutter code such that it runs slower than it should. Some are glaringly obvious and others nefariously subtle. For example, perhaps you used the wrong API or data structure for a particular situation.

在代码库中追查性能问题可能是一项令人望而生畏的任务。
让 Flutter 代码跑得比应有的速度慢的方法有很多。
有些显而易见，有些则隐蔽得可恶。
例如，也许你在特定场景下用错了 API 或数据结构。

This article works through a simple case study examining the performance of a slow Dart command-line interface (CLI) application. You’ll learn about:

本文通过一个简单的案例研究，考察一个运行缓慢的 Dart
命令行界面（CLI）应用的性能。你将学到：

* General CPU profilers and their importance.

  CPU 分析器（CPU profiler）的一般知识及其重要性。

* The sampling CPU profiler that ships with Dart and Flutter.

  Dart 和 Flutter 自带的采样（sampling）CPU 分析器。

With this new understanding of CPU profiling, we’ll debug the performance of our program. We’ll do so using the Dart DevTools CPU Profiler and `dart:developer`’s `UserTag` functionality to pinpoint the inefficient code. We’ve got lots to cover, so let’s get started!

有了这些对 CPU 性能分析的新认识，我们就来调试程序的性能。
我们会使用 Dart DevTools 的 CPU 分析器（CPU Profiler）
和 `dart:developer` 的 `UserTag` 功能来定位低效代码。
要讲的内容很多，让我们开始吧！

*Note: Dart DevTools is also referred to as Flutter DevTools, but shouldn’t be confused with Chrome DevTools.*

*注意：Dart DevTools 也被称为 Flutter DevTools，但不要与 Chrome DevTools 混淆。*

## Case Study: Implementing grep in Dart

## 案例研究：用 Dart 实现 grep

Consider the following simple Dart CLI application:

来看下面这个简单的 Dart CLI 应用：

```dart

// filename: grep.dart
import 'dart:io';

/// Finds and prints all instances of [pattern] in the [file].
void grep(File file, String pattern) {
  // Open the file and read its contents.
  final lines = file.readAsLinesSync();

  String output = '';
  int lineNum = 1;
  // Check each line to see if it matches `pattern`.
  for (final line in lines) {
    final matcher = RegExp(pattern);
    if (matcher.hasMatch(line)) {
      final foundMessage = '$lineNum:$line';
      output += foundMessage;
    }
    lineNum++;
  }
  stdout.writeln(output);
}

void main(List<String> arguments) { 
  if (arguments.length != 2) {
    print('Usage: dart grep.dart <path> <pattern>');
    exitCode = 64;
    return;
  }
  final path = arguments[0];
  final pattern = arguments[1];

  final file = File(path);
  if (!file.existsSync()) {
    stderr.writeln("Error: unable to open file '$path'");
    exitCode = 64;
    return;
  }

  grep(file, pattern);
}
```


The `grep.dart` program implements a version of the common Unix tool. It allows users to search files for the occurrence of a string of characters that matches a specified pattern. For example, given a file `names.txt` containing:

`grep.dart` 程序实现了常见 Unix 工具的一个版本。
它让用户在文件中搜索匹配指定模式的字符串。
例如，给定一个包含以下内容的 `names.txt` 文件：

```shell
$ cat names.txt
Frank
Bob
Franny
June
Ben
Francis
```


Let’s find all lines containing the string `'Fran'`:

我们来找出所有包含字符串 `'Fran'` 的行：

```shell
$ dart grep.dart names.txt 'Fran'
1:Frank
3:Franny
6:Francis
```


Excellent! We should expect this output from `grep`. That said, `names.txt` is a *small* file. Let’s try and find all the instances of `'Hummingbird'` in a larger text document. What if we ran the same program on a 437,000 line, 147 MiB file about hummingbirds?

很好！这正是我们期望 `grep` 给出的输出。
不过，`names.txt` 是个*小*文件。
我们试试在一个更大的文本文档中找出所有 `'Hummingbird'`。
如果对一本 437,000 行、147 MiB 的蜂鸟百科全书
运行同一个程序会怎样？

```shell
$ dart grep.dart hummingbird_encyclopedia.txt 'Hummingbird'
```


Huh… it doesn’t complete, even after **two minutes**. How does Unix `grep` perform?

咦……**两分钟**过去了，它还没跑完。Unix `grep` 表现如何？

```shell
$ grep -n 'Hummingbird' hummingbird_encyclopedia.txt
16:'''Hummingbirds''' are [[bird]]s native to the…
22:Hummingbirds have the highest…
24:Hummingbirds split from their [[Sister taxon|sister group]]…
// Output continues
```


Unix’s `grep` searched the entire file and returned all lines containing `Hummingbird` in about 45 seconds. Clearly there’s something strange in our code that we should investigate. But how can we identify the cause of our performance issues? The **CPU Profiler** shipped with Dart DevTools is a great place to start!

Unix 的 `grep` 用大约 45 秒搜索了整个文件，
返回了所有包含 `Hummingbird` 的行。
显然我们的代码里有些奇怪的东西需要调查。
但要如何找出性能问题的原因呢？
Dart DevTools 自带的 **CPU 分析器（CPU Profiler）**
是一个绝佳的起点！

## What is a CPU profiler?

## 什么是 CPU 分析器？

CPU profiling tools track where a program spends its time when executing. To provide the most computationally efficient CPU profiling experience, the Dart virtual machine (VM), powering Dart CLI and Flutter applications, uses a **sampling** CPU profiler. When used with tools like Dart DevTools, you can identify performance bottlenecks in Dart programs.

CPU 性能分析工具跟踪程序执行时把时间花在了哪里。
为了提供计算开销最低的 CPU 性能分析体验，
驱动 Dart CLI 和 Flutter 应用的 Dart 虚拟机（VM）
使用**采样**式 CPU 分析器。配合 Dart DevTools 这样的工具，
你可以找出 Dart 程序中的性能瓶颈。

A sampling CPU profiler takes a statistical approach to collecting application performance data. It collects samples by interrupting threads at regular intervals and taking a snapshot of the current call stack and other relevant execution state. These samples can be processed to gain insights into approximately how much time is spent executing specific functions, and how frequently functions appear on different call stacks.

采样 CPU 分析器以统计方法收集应用性能数据。
它按固定间隔中断线程，对当前调用栈和其他相关执行状态
拍下快照，以此收集样本。处理这些样本，
就能大致了解执行特定函数花了多少时间，
以及函数在不同调用栈上出现的频率。

The frequency that samples are collected is known as the **sampling rate** and is measured in samples per second (otherwise known as hertz or Hz). Most sampling profilers have sampling rates of 1000 Hz or higher. Higher sampling rates result in more detailed CPU profiles, at the expense of higher sampling overhead in the target process. At reasonable sampling rates, sampling CPU profilers are efficient and have little to no impact on the performance characteristics of the profiled application. As an added bonus, the collected data is typically less computationally expensive to process for analysis when compared to tracing profilers.

收集样本的频率称为**采样率（sampling rate）**，
以每秒样本数（即赫兹，Hz）衡量。
大多数采样分析器的采样率为 1000 Hz 或更高。
更高的采样率带来更详细的 CPU 分析结果，
代价是目标进程中更高的采样开销。
在合理的采样率下，采样 CPU 分析器十分高效，
对被分析应用的性能特征几乎没有影响。
额外的好处是：与追踪（tracing）分析器相比，
收集到的数据在分析处理时的计算开销通常更低。

## Deep Dive: How does a sampling profiler work?

## 深入探究：采样分析器如何工作？

*This section goes into detail about how the Dart VM’s sampling CPU profiler works. You don’t need to know these details when analyzing CPU profiles. If you don’t care about the nitty gritty details of sampling CPU profilers, skip this section.*

*本节详细介绍 Dart VM 的采样 CPU 分析器的工作原理。
分析 CPU 性能数据时你并不需要了解这些细节。
如果你不关心采样 CPU 分析器的细枝末节，可以跳过本节。*

The Dart VM’s sampling CPU profiler has three important components: the thread interrupter, the sample collector, and the sample processor.

Dart VM 的采样 CPU 分析器有三个重要组件：
线程中断器（thread interrupter）、样本收集器（sample collector）
和样本处理器（sample processor）。

### Thread Interrupter

### 线程中断器

The [**thread interrupter**](https://github.com/dart-lang/sdk/blob/main/runtime/vm/thread_interrupter.cc) runs on a dedicated thread and triggers the CPU sample collection on each thread that the VM manages. The thread interrupter is typically inactive, only waking up once per sampling interval. After each sampling interval, the interrupter iterates over the list of threads, informing each thread that it should pause and collect a sample. The thread interrupter has slightly different behavior on different platforms due to operating system specific details.

[**线程中断器**](https://github.com/dart-lang/sdk/blob/main/runtime/vm/thread_interrupter.cc)
运行在一个专用线程上，负责触发 VM 管理的每个线程上的
CPU 样本收集。线程中断器通常处于休眠状态，
每个采样间隔只醒来一次。每个采样间隔过后，
中断器遍历线程列表，通知每个线程暂停并收集一个样本。
由于操作系统细节的差异，
线程中断器在不同平台上的行为略有不同。

On most platforms which support [signal-based control flow](https://en.wikipedia.org/wiki/Signal_(IPC)) (Android and Linux), the [`SIGPROF`](https://www.gnu.org/software/libc/manual/html_node/Alarm-Signals.html) signal is sent to each thread. This triggers an [interrupt](https://en.wikipedia.org/wiki/Interrupt) that invokes a signal handler registered by the CPU profiler on the target thread that then collects the CPU sample before resuming its work.

在大多数支持
[基于信号的控制流](https://en.wikipedia.org/wiki/Signal_(IPC))
的平台（Android 和 Linux）上，会向每个线程发送
[`SIGPROF`](https://www.gnu.org/software/libc/manual/html_node/Alarm-Signals.html)
信号。这会触发一次
[中断](https://en.wikipedia.org/wiki/Interrupt)，
调用 CPU 分析器在目标线程上注册的信号处理器，
由它收集 CPU 样本，然后线程恢复工作。

On other platforms which don’t support signals (Windows and Fuchsia) or have poor performance in some situations when using SIGPROF (MacOS and iOS), the thread interrupter uses system calls to explicitly pause and resume each thread after collecting the CPU sample. In this case, sample collection is done on the thread interrupter thread rather than on the thread being sampled.

在其他不支持信号的平台（Windows 和 Fuchsia），
或在某些情况下使用 SIGPROF 性能不佳的平台（MacOS 和 iOS）上，
线程中断器使用系统调用显式暂停每个线程，
收集 CPU 样本后再恢复线程。
这种情况下，样本收集在中断器线程上完成，
而不是在被采样的线程上。

### Sample collection

### 样本收集

Once a thread has been interrupted, the CPU profiler [collects a sample](https://github.com/dart-lang/sdk/blob/bbacf39e9c1085650b5f2a180285792ad0dd76d9/runtime/vm/profiler.cc#L1311) of the thread’s current execution state. Each [sample](https://github.com/dart-lang/sdk/blob/bbacf39e9c1085650b5f2a180285792ad0dd76d9/runtime/vm/profiler.h#L195) includes metadata such as:

线程被中断后，CPU 分析器会
[收集一个样本](https://github.com/dart-lang/sdk/blob/bbacf39e9c1085650b5f2a180285792ad0dd76d9/runtime/vm/profiler.cc#L1311)，
记录线程当前的执行状态。每个
[样本](https://github.com/dart-lang/sdk/blob/bbacf39e9c1085650b5f2a180285792ad0dd76d9/runtime/vm/profiler.h#L195)
包含如下元数据：

* thread and isolate identifiers

  线程和 isolate 标识符

* active [user tag](https://api.dart.dev/stable/dart-developer/UserTag/UserTag.html) for the thread

  线程当前激活的
  [用户标签（user tag）](https://api.dart.dev/stable/dart-developer/UserTag/UserTag.html)

* collection timestamps

  收集时间戳

* current stack trace of the sampled thread

  被采样线程的当前栈跟踪（stack trace）

The collected stack trace consists of a list of program counters (PCs), which correspond to the return addresses of each Dart and native function found on the stack. These PCs are collected through a process known as “walking the stack”. While performing a [stack walk](https://github.com/dart-lang/sdk/blob/bbacf39e9c1085650b5f2a180285792ad0dd76d9/runtime/vm/profiler.cc#L208), the stack walker uses the top frame’s frame pointer (FP) and the known layout of each stack frame to find and record the PC associated with the function as well as the FP of the previous stack frame. The stack walker repeats this process, using the previous frame’s FP as a starting point, until it reaches the end of the stack as shown in Figure 1.

收集到的栈跟踪由一组程序计数器（PC）构成，
对应栈上每个 Dart 函数和原生函数的返回地址。
这些 PC 通过一个称为“栈遍历（walking the stack）”的过程收集。
执行[栈遍历](https://github.com/dart-lang/sdk/blob/bbacf39e9c1085650b5f2a180285792ad0dd76d9/runtime/vm/profiler.cc#L208)时，
栈遍历器利用栈顶帧的帧指针（FP）和每个栈帧的已知布局，
找到并记录与函数关联的 PC，以及上一个栈帧的 FP。
栈遍历器以上一帧的 FP 为起点重复这个过程，
直到到达栈的末端，如图 1 所示。

<DashImage src="images/1manGRq62JBgJER8ufYlAfA.webp" alt="A diagram showing an example of stack trace collection on an ARM64 system." caption="***Figure 1: An example of stack trace collection on an ARM64 system. The stack walker starts at `FP(N+1)`, retrieves the program counter (PC) from address FP(N+1) + 0x10, and adds it to the stack trace as Frame 0. The stack walker then looks up FP(N) from address FP(N+1) + 0x8, repeating the same procedure using FP(N) to look up details for Frame 1.***" />


Each collected sample is stored in the VM’s sample buffer, a [circular buffer](https://en.wikipedia.org/wiki/Circular_buffer) that can store a limited number of CPU samples. This allows for the VM to avoid the need for additional allocations at runtime, which can negatively impact performance or [cause bad things to happen if done in the signal handler](https://en.wikipedia.org/wiki/Signal_(IPC)#Risks).

每个收集到的样本都存储在 VM 的样本缓冲区中，
这是一个能存储有限数量 CPU 样本的
[环形缓冲区](https://en.wikipedia.org/wiki/Circular_buffer)。
这让 VM 避免了在运行时进行额外内存分配——
额外分配可能对性能产生负面影响，
[如果在信号处理器中进行还可能引发严重问题](https://en.wikipedia.org/wiki/Signal_(IPC)#Risks)。

The size of the sample buffer is fixed at runtime and, once full, old samples will be overwritten with new samples by the profiler. The rate at which the sample buffer fills up depends on the sampling rate and average stack depth of each sample. For example, higher sampling rates and deeper stacks cause the buffer to wrap around more quickly. In DevTools, developers can control how quickly the sample buffer wraps around by [choosing](https://docs.flutter.dev/tools/devtools/cpu-profiler#cpu-sampling-rate) between low (1000 Hz), medium (4000 Hz), and high (20,000 Hz) sampling rates.

样本缓冲区的大小在运行时是固定的，一旦装满，
分析器就会用新样本覆盖旧样本。
缓冲区被填满的速度取决于采样率和每个样本的平均栈深度。
例如，更高的采样率和更深的栈会让缓冲区更快回绕。
在 DevTools 中，开发者可以通过
[选择](https://docs.flutter.dev/tools/devtools/cpu-profiler#cpu-sampling-rate)
低（1000 Hz）、中（4000 Hz）、高（20,000 Hz）采样率
来控制样本缓冲区回绕的快慢。

### Sample processing

### 样本处理

When a client sends a request for a CPU sample profile via the [VM service protocol](https://github.com/dart-lang/sdk/blob/main/runtime/vm/service/service.md#getcpusamples), the CPU profiler needs to process the collected samples before sending them to the client. The profiler:

当客户端通过
[VM 服务协议](https://github.com/dart-lang/sdk/blob/main/runtime/vm/service/service.md#getcpusamples)
请求 CPU 样本分析数据时，CPU 分析器需要先处理收集到的样本，
再把它们发给客户端。分析器会：

1. Iterates over the sample buffer, using filters to only retrieve samples for the isolate and time period specified by the client.

    遍历样本缓冲区，使用过滤器只取出客户端指定的
    isolate 和时间段内的样本。

1. *Symbolizes*, or maps PCs to function names, each stack frame in the set of samples.

    对样本集中的每个栈帧进行*符号化*（symbolize），即把 PC 映射为函数名。

1. Serializes the entire processed sample buffer to JSON.

    把处理后的整个样本缓冲区序列化为 JSON。

1. Sends the JSON back to the client.

    把 JSON 发回客户端。

Even after processing done by the profiler, the [CPU samples response](https://github.com/dart-lang/sdk/blob/main/runtime/vm/service/service.md#cpusamples) is low-level and requires additional processing by developer tooling to be useful. For example, Dart DevTools can convert the list of CPU samples into various structural representations that allow for identifying expensive functions ([Bottom Up](https://docs.flutter.dev/tools/devtools/cpu-profiler#bottom-up)) and costly call paths ([Call Tree](https://docs.flutter.dev/tools/devtools/cpu-profiler#call-tree) and [CPU Flame Chart](https://docs.flutter.dev/tools/devtools/cpu-profiler#flame-chart)), and inspecting caller and callee statistics ([Method Table](https://docs.flutter.dev/tools/devtools/cpu-profiler#method-table)) for individual methods.

即便经过分析器的处理，
[CPU 样本响应](https://github.com/dart-lang/sdk/blob/main/runtime/vm/service/service.md#cpusamples)
仍然是低层数据，需要开发者工具进一步处理才有用。
例如，Dart DevTools 可以把 CPU 样本列表转换成多种结构化表示，
用于识别开销大的函数
（[Bottom Up](https://docs.flutter.dev/tools/devtools/cpu-profiler#bottom-up)）、
代价高的调用路径
（[Call Tree](https://docs.flutter.dev/tools/devtools/cpu-profiler#call-tree)
和 [CPU 火焰图](https://docs.flutter.dev/tools/devtools/cpu-profiler#flame-chart)），
以及查看单个方法的调用方和被调用方统计
（[Method Table](https://docs.flutter.dev/tools/devtools/cpu-profiler#method-table)）。

## Using Dart DevTools to Profile Dart and Flutter Applications

## 使用 Dart DevTools 分析 Dart 和 Flutter 应用

Now that you’re familiar with what sampling CPU profilers are and how they work, let’s debug the performance of our `grep` implementation. Let’s run the code again with `--observe` and open up the Dart DevTools CPU Profiler tab:

现在你已经熟悉采样 CPU 分析器是什么、如何工作了，
我们来调试 `grep` 实现的性能。
带上 `--observe` 再次运行代码，
并打开 Dart DevTools 的 CPU Profiler 标签页：

***Note:** You don’t need to use the `--observe` flag when testing a Flutter app in DevTools.*

***注意：**在 DevTools 中测试 Flutter 应用时，不需要使用 `--observe` 标志。*

```shell
$ dart — observe grep.dart hummingbird_encyclopedia.txt 'Hummingbird'
The Dart VM service is listening on http://127.0.0.1:8181/omxEtsCtW9k=/
The Dart DevTools debugger and profiler is available at: http://127.0.0.1:8181/omxEtsCtW9k=/devtools?uri=ws://127.0.0.1:8181/omxEtsCtW9k=/ws
// At this point, the terminal hangs with no output.
```


<DashImage src="images/04btaxCBW8Btx71RM.webp" alt="Dart DevTools CPU Profiler showing StringBase plus taking most of the CPU time." />


Yikes! Of all the samples collected in a period of 11.6 seconds, the isolate spent more than 90% of its CPU time executing `_StringBase.+`. It’s likely that this is related to our performance issues, but it might not be obvious what block of code in our `grep` function is the source of the slowdown. Luckily, we can further narrow down the location of the expensive calls to `_StringBase.+` using **user tags.**

糟糕！在 11.6 秒内收集的所有样本中，
isolate 把超过 90% 的 CPU 时间花在执行 `_StringBase.+` 上。
这很可能与我们的性能问题有关，
但 `grep` 函数中哪段代码是拖慢的源头可能并不明显。
幸运的是，我们可以用**用户标签（user tag）**
进一步缩小这些高开销 `_StringBase.+` 调用的位置。

## Categorizing CPU samples with User Tags

## 用 User Tag 给 CPU 样本分类

When the Dart CPU profiler interrupts a thread to collect a new sample, it records the current user tag set for the isolate. The [`dart:developer`](https://api.dart.dev/stable/dart-developer/dart-developer-library.html) library provides the [`UserTag`](https://api.dart.dev/stable/dart-developer/dart-developer-library.html) class that allows you to specify and set custom tags for sections of code that you’re interested in profiling.

Dart CPU 分析器中断线程收集新样本时，
会记录 isolate 当前设置的用户标签。
[`dart:developer`](https://api.dart.dev/stable/dart-developer/dart-developer-library.html)
库提供了
[`UserTag`](https://api.dart.dev/stable/dart-developer/dart-developer-library.html)
类，让你为想要分析的代码段指定并设置自定义标签。

To better understand where we’re spending time in our `grep` implementation, we can instrument the function with user tags:

为了更好地理解 `grep` 实现的时间都花在哪里，
我们可以用用户标签给函数打上标记：

```dart
// filename: grep.dart
import 'dart:developer';
import 'dart:io';

/// Finds and prints all instances of [pattern] in the [file].
void grep(File file, String pattern) {
  final defaultTag = getCurrentTag();
  final fileReadTag = UserTag('File Read');
  final textMatchTag = UserTag('Text Matching');
  final printTag = UserTag('Print Output');

  // Set the 'File Read' tag as the current user tag.
  fileReadTag.makeCurrent();

  // Open the file and read its contents.
  final lines = file.readAsLinesSync();

  // Set the 'Text Matching' tag as the current user tag.
  textMatchTag.makeCurrent();
  String output = '';
  int lineNum = 1;
  // Check each line to see if it matches `pattern`.
  for (final line in lines) {
    final matcher = RegExp(pattern);
    if (matcher.hasMatch(line)) {
      final foundMessage = '$lineNum:$line';
      output += foundMessage;
    }
    lineNum++;
  }

  // Set the 'Print Output' tag as the current user tag.
  printTag.makeCurrent();
  stdout.writeln(output);

  // Reset the user tag to the tag set when grep was invoked.
  defaultTag.makeCurrent();
}
```


Now, let’s re-run our program and open up the CPU Profiler. To see our categorized profile, select the **Group by: User Tag** option from the dropdown:

现在，重新运行程序并打开 CPU Profiler。
要查看分类后的分析结果，
从下拉菜单中选择 **Group by: User Tag** 选项：

<DashImage src="images/0zxcsj31nCh14rLYa.webp" alt="The Group by dropdown in the CPU Profiler with User Tag selected." />


When we expand the **Text Matching** tag, we confirm that the `_StringBase.+` method is called in our text-matching loop:

展开 **Text Matching** 标签后，
我们确认 `_StringBase.+` 方法是在文本匹配循环中被调用的：

<DashImage src="images/0ai9S8-Y8c_94rr6p.webp" alt="Text Matching tag expanded in the CPU Profiler, showing the StringBase plus method call." />


With this information, we should be able to take a closer look at our code and identify the issue:

有了这些信息，我们应该能仔细检查代码并找出问题：

```dart
  // Set the ‘Text Matching’ tag as the current user tag.
  textMatchTag.makeCurrent();
  String output = '';
  int lineNum = 1;
  // Check each line to see if it matches `pattern`.
  for (final line in lines) {
    final matcher = RegExp(pattern);
    if (matcher.hasMatch(line)) {
      final foundMessage = '$lineNum:$line';
      // Ahah! This is our call to _StringBase.+!
      output += foundMessage;
    }
    lineNum++;
  }
```


There it is! We’ve made the classic mistake of appending content to a [`String`](https://api.dart.dev/stable/dart-core/String-class.html) multiple times rather than using a [`StringBuffer`](https://api.dart.dev/stable/dart-core/StringBuffer-class.html). Appending content to a `String` creates a new string to store the result of the `_StringBase.+` method. As a result, we copy `output + foundMessage` into a new string each time we find a match.

找到了！我们犯了一个经典错误：
多次向 [`String`](https://api.dart.dev/stable/dart-core/String-class.html)
追加内容，而不是使用
[`StringBuffer`](https://api.dart.dev/stable/dart-core/StringBuffer-class.html)。
向 `String` 追加内容会创建一个新字符串来保存
`_StringBase.+` 方法的结果。于是每找到一次匹配，
我们都要把 `output + foundMessage` 复制进一个新字符串。

As output gets longer, appending data to it becomes more expensive, taking `O(m*n)` to perform the copies, where `m` is the average number of characters in a match and `n` is the total number of characters in the final string. If we use a `StringBuffer`, we don’t copy `output` each time we append to it, instead concatenating the matches in a single `O(n)` operation at the end of the function.

随着输出变长，追加数据的开销越来越大，
完成这些复制需要 `O(m*n)`，其中 `m` 是每次匹配的平均字符数，
`n` 是最终字符串的总字符数。如果使用 `StringBuffer`，
每次追加时就不必复制 `output`，
而是在函数末尾用一次 `O(n)` 操作把所有匹配拼接起来。

Now that our app uses [`StringBuffer.writeln`](https://api.dart.dev/stable/dart-core/StringBuffer/writeln.html) instead of appending to a `String`, let’s look at our function:

现在应用改用
[`StringBuffer.writeln`](https://api.dart.dev/stable/dart-core/StringBuffer/writeln.html)
而不是向 `String` 追加内容，来看看我们的函数：

```dart
// filename: grep.dart
import ‘dart:developer’;
import 'dart:io';

/// Finds and prints all instances of [pattern] in the [file].
void grep(File file, String pattern) {
  final defaultTag = getCurrentTag();
  final fileReadTag = UserTag(‘File Read’);
  final textMatchTag = UserTag(‘Text Matching’);
  final printTag = UserTag(‘Print Output’);

  // Set the ‘File Read’ tag as the current user tag.
  fileReadTag.makeCurrent();

  // Open the file and read its contents.
  final lines = file.readAsLinesSync();

  // Set the ‘Text Matching’ tag as the current user tag.
  textMatchTag.makeCurrent();
  final output = StringBuffer();
  int lineNum = 1;
  // Check each line to see if it matches `pattern`.
  for (final line in lines) {
    final matcher = RegExp(pattern);
    if (matcher.hasMatch(line)) {
      final foundMessage = '$lineNum:$line';
      // Add the match to the buffer without creating a copy.
      output.writeln(foundMessage);
    }
    lineNum++;
  }

  // Set the ‘Print Output’ tag as the current user tag.
  printTag.makeCurrent();
  // output.toString() concatenates each entry in the buffer
  // into a new String, only performing a single allocation of
  // size `output.length`. 
  stdout.writeln(output);

  // Reset the user tag to the tag set when grep was invoked.
  defaultTag.makeCurrent();
}
```


Let’s run our test again to see if there’s any improvement:

再运行一次测试，看看有没有改善：

```shell
$ dart grep.dart hummingbird_encyclopedia.txt 'Hummingbird'
16:‘’’Hummingbirds’’’ are [[bird]]s native to the…
22:Hummingbirds have the highest…
24:Hummingbirds split from their [[Sister taxon|sister group]]…
// Output continues
```


Using `StringBuffer`, we can find all the instances of `'Hummingbird'` in about **45 seconds**. That’s much better and almost the same as the Unix `grep` implementation! Let’s take another look at the CPU profiler to see if we can improve performance further:

使用 `StringBuffer` 后，我们能在大约 **45 秒**内
找出所有 `'Hummingbird'`。这好多了，
几乎与 Unix `grep` 实现一样快！
再看看 CPU 分析器，看能否进一步提升性能：

<DashImage src="images/0dL9EpPsSbaU-Bem-.webp" alt="The CPU Profiler shows time spent primarily on printing matches rather than text matching." />


A quick glance at the profile tells us that we spend most of our time printing matches and that the actual matching only takes about 200ms. We should focus on the code that falls under the `'Print Output'` tag:

快速浏览分析结果就能发现，大部分时间花在打印匹配结果上，
真正的匹配只用了约 200ms。
我们应该关注 `'Print Output'` 标签下的代码：

```dart
  // Set the ‘Print Output’ tag as the current user tag.
  printTag.makeCurrent();
  // output.toString() concatenates each entry in the buffer
  // into a new String, only performing a single allocation of
  // size `output.length`. 
  stdout.writeln(output);
```


There doesn’t seem much we can do as we are only making a single call to [`stdout.writeln`](https://api.dart.dev/stable/dart-io/stdout.html), a member of the core [`dart:io`](https://api.dart.dev/stable/dart-io/dart-io-library.html) library. Looking at the [CPU flame chart in the profiler](https://docs.flutter.dev/tools/devtools/cpu-profiler#flame-chart), we see that this code is in the SDK and that we can make no more performance gains in our code.

似乎没什么可做的了，因为我们只调用了一次
[`stdout.writeln`](https://api.dart.dev/stable/dart-io/stdout.html)，
它是核心库
[`dart:io`](https://api.dart.dev/stable/dart-io/dart-io-library.html)
的成员。查看
[分析器中的 CPU 火焰图](https://docs.flutter.dev/tools/devtools/cpu-profiler#flame-chart)，
可以看到这段代码位于 SDK 内部，
我们自己的代码已无性能可挖。

With that, we’re done!

到此，大功告成！

## Summary

## 总结

We’ve accomplished a lot since the beginning of this article. We:

从文章开头到现在，我们完成了不少事情。我们：

* Wrote a simple `grep` tool in Dart.

  用 Dart 写了一个简单的 `grep` 工具。

* Identified our program had poor performance.

  发现程序性能不佳。

* Learned about CPU profilers and explored the Dart VM’s sampling CPU profiler.

  学习了 CPU 分析器的知识，并探究了 Dart VM 的采样 CPU 分析器。

* Used the Dart DevTools’ [CPU Profiler](https://docs.flutter.dev/tools/devtools/cpu-profiler) to identify and fix our program’s performance issues.

  使用 Dart DevTools 的
  [CPU Profiler](https://docs.flutter.dev/tools/devtools/cpu-profiler)
  找出并修复了程序的性能问题。

Having a good understanding of performance tooling is an important skill and, as we’ve shown in this article, can help you identify potentially subtle performance issues in your code. The CPU Profiler is only one of many tools shipped with [Dart DevTools](https://docs.flutter.dev/tools/devtools/overview) that can help you better understand the behavior and performance of your Dart CLI and Flutter applications.

深入理解性能工具是一项重要技能，正如本文所展示的，
它能帮你发现代码中可能很隐蔽的性能问题。
CPU Profiler 只是 [Dart DevTools](https://docs.flutter.dev/tools/devtools/overview)
自带的众多工具之一，这些工具能帮你更好地理解
Dart CLI 和 Flutter 应用的行为与性能。

In future articles, we’ll explore other ways to use Dart DevTools to debug and optimize your apps, including:

在未来的文章中，我们将探索使用 Dart DevTools 调试和优化应用的其他方法，包括：

* Analyzing memory usage through the [Memory](https://docs.flutter.dev/tools/devtools/memory) screen

  通过 [Memory](https://docs.flutter.dev/tools/devtools/memory)
  页面分析内存使用

* Examining execution timelines through the [Performance](https://docs.flutter.dev/tools/devtools/performance) screen

  通过 [Performance](https://docs.flutter.dev/tools/devtools/performance)
  页面查看执行时间线

* Inspecting HTTP traffic through the [Network](https://docs.flutter.dev/tools/devtools/network) screen

  通过 [Network](https://docs.flutter.dev/tools/devtools/network)
  页面检查 HTTP 流量

Until then, happy hacking!

在那之前，祝你编码愉快！

*If you feel so inclined, [follow me on GitHub](https://github.com/bkonyi) to keep up with my work on Flutter and the Dart virtual machine, as well as my other pet projects.*

*如果你愿意，欢迎
[在 GitHub 上关注我](https://github.com/bkonyi)，
了解我在 Flutter 和 Dart 虚拟机上的工作，以及我的其他业余项目。*
