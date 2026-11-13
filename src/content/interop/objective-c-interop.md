---
# title: "Objective-C and Swift interop using package:ffigen"
title: "使用 package:ffigen 进行 Objective-C 与 Swift 互操作"
# shortTitle: Objective-C & Swift interop
shortTitle: Objective-C 与 Swift 互操作
# breadcrumb: Objective-C & Swift
breadcrumb: Objective-C 与 Swift
# description: >-
#   To use Objective-C and Swift code in your Dart program, use package:ffigen.
description: 在 Dart 程序中使用 package:ffigen 调用 Objective-C 和 Swift 代码。
ai-translated: true
ffigen: "https://pub.dev/packages/ffigen"
example: "https://github.com/dart-lang/native/tree/main/pkgs/ffigen/example/objective_c"
ffigenapi: "https://pub.dev/documentation/ffigen/latest/ffigen"
ffigendoc: "https://github.com/dart-lang/native/blob/main/pkgs/ffigen/doc/README.md"
appledoc: "https://developer.apple.com/documentation"
---

Dart apps running on the [Dart Native platform][] (macOS or iOS)
can use `dart:ffi` and [`package:ffigen`][]
to call Objective-C and Swift APIs.

运行在 [Dart 原生平台][Dart Native platform]（macOS 或 iOS）上的 Dart 应用，
可以使用 `dart:ffi` 和 [`package:ffigen`][]
调用 Objective-C 和 Swift API。

`dart:ffi` enables Dart code to interact with native C APIs.
Objective-C is based on and compatible with C,
so it's possible to interact with Objective-C APIs using only `dart:ffi`.
However, doing so requires significant boilerplate,
so you can use `package:ffigen` to automatically generate
the Dart FFI bindings for a given Objective-C API.
To learn more about FFI and interfacing with C code directly,
see the [C interop guide][].

`dart:ffi` 让 Dart 代码可以与原生 C API 交互。
Objective-C 基于 C 并与之兼容，
因此只用 `dart:ffi` 也能与 Objective-C API 交互。
不过这样做需要大量样板代码，
因此你可以使用 `package:ffigen`
为指定的 Objective-C API 自动生成 Dart FFI 绑定。
要进一步了解 FFI 以及如何直接对接 C 代码，
请参阅 [C 互操作指南][C interop guide]。

You can generate Objective-C headers for Swift APIs,
enabling `dart:ffi` and `package:ffigen` to interact with Swift.

你可以为 Swift API 生成 Objective-C 头文件，
从而让 `dart:ffi` 和 `package:ffigen` 与 Swift 交互。

For more information about using FFIgen,
see the [FFIgen README][]
and the [additional documentation][].

关于使用 FFIgen 的更多信息，
请参阅 [FFIgen README][]
和 [补充文档][additional documentation]。

[Dart Native platform]: /overview#platform
[`package:ffigen`]: {{page.ffigen}}
[C interop guide]: /interop/c-interop
[FFIgen README]: {{page.ffigen}}
[additional documentation]: {{page.ffigendoc}}

## Objective-C example

## Objective-C 示例

This guide walks you through [an example][]
that uses `package:ffigen` to generate bindings for
[`AVAudioPlayer`][].
This API requires at least macOS SDK 10.7,
so check your version and update Xcode if necessary:

本指南带你完成 [一个示例][an example]，
使用 `package:ffigen` 为 [`AVAudioPlayer`][] 生成绑定。
该 API 至少需要 macOS SDK 10.7，
请检查版本，并在必要时更新 Xcode：

```console
$ xcodebuild -showsdks
```

Generating bindings to wrap an Objective-C API is similar to wrapping a C API.
Direct `package:ffigen` at the header file that describes the API,
and then load the library with `dart:ffi`.

为 Objective-C API 生成包装绑定，与包装 C API 类似。
把 `package:ffigen` 指向描述该 API 的头文件，
然后用 `dart:ffi` 加载库。

`package:ffigen` parses Objective-C header files
using [LLVM][],
so you'll need to install that first.
See [Installing LLVM][]
from the FFIgen README for more details.

`package:ffigen` 使用 [LLVM][] 解析 Objective-C 头文件，
因此需要先安装 LLVM。
更多细节见 FFIgen README 中的 [安装 LLVM][Installing LLVM]。

[an example]: {{page.example}}
[`AVAudioPlayer`]: {{page.appledoc}}/avfaudio/avaudioplayer?language=objc
[LLVM]: https://llvm.org/
[Installing LLVM]: {{page.ffigen}}#installing-llvm

### Configure FFIgen for Objective-C

### 为 Objective-C 配置 FFIgen

First, add `package:ffigen` as a dev dependency and the helpers
`package:objective_c` and `package:ffi` as a regular dependency:

首先，把 `package:ffigen` 添加为开发依赖，
并把辅助 package `package:objective_c` 和 `package:ffi`
添加为常规依赖：

```console
$ dart pub add dev:ffigen objective_c ffi
```

Then, configure FFIgen to generate bindings for the
Objective-C header containing the API.
Configure FFIgen using YAML or Dart code; we recommend Dart for new projects.
The YAML config will be deprecated in future versions of FFIgen.
Start by creating a `generate_code.dart` script somewhere in your package.
We recommend placing this file in `my_package/tool`.

然后，配置 FFIgen，为包含该 API 的 Objective-C 头文件生成绑定。
可以用 YAML 或 Dart 代码配置 FFIgen；新项目推荐使用 Dart。
YAML 配置将在 FFIgen 的未来版本中弃用。
先在 package 中的某处创建 `generate_code.dart` 脚本。
建议把该文件放在 `my_package/tool`。

The `generate_code.dart` script should create an `FfiGenerator` object,
which will contain all your configuration options,
then call its `.generate()` method.

`generate_code.dart` 脚本应创建一个 `FfiGenerator` 对象，
其中包含你的全部配置选项，
然后调用它的 `.generate()` 方法。

```dart
import 'package:ffigen/ffigen.dart';

final config = FfiGenerator(
);

void main() => config.generate();
```

First, you'll tell FFIgen where to find the API you're trying to
generate bindings for.
To do this, set the `headers.entryPoints` option.

首先，告诉 FFIgen 到哪里寻找你要生成绑定的 API。
为此，设置 `headers.entryPoints` 选项。

For this example, you'll load `AVAudioPlayer.h`.
This is part of the `AVFAudio` framework,
which is located in your Xcode installation.
FFIgen includes some helper functions to locate these sorts of APIs,
such as `macSdkPath`.
Using these helper functions makes your code generation script
more reliable across different machines,
which might have different SDK installation locations.

在本示例中，你将加载 `AVAudioPlayer.h`。
它属于 `AVFAudio` 框架，位于你的 Xcode 安装中。
FFIgen 包含一些辅助函数来定位这类 API，
例如 `macSdkPath`。
使用这些辅助函数，可以让代码生成脚本
在 SDK 安装位置不同的机器上更可靠。

The `macSdkPath` utility finds the macOS SDK by running `xcrun --show-sdk-path --sdk macosx`.
You can run this command in a terminal to locate your macOS SDKs,
or with `--sdk iphoneos` to find your iOS SDKs.
When generating bindings for an Apple API,
exploring these directories is a great way to find
the right headers to pass to FFIgen.

`macSdkPath` 实用工具通过运行 `xcrun --show-sdk-path --sdk macosx`
来查找 macOS SDK。
你可以在终端运行该命令来定位 macOS SDK，
或加上 `--sdk iphoneos` 来查找 iOS SDK。
为 Apple API 生成绑定时，
浏览这些目录是找到应传给 FFIgen 的正确头文件的好办法。

```dart highlightLines=4-10
import 'package:ffigen/ffigen.dart';

final config = FfiGenerator(
  headers: Headers(
    entryPoints: [
      Uri.file(
        '$macSdkPath/System/Library/Frameworks/AVFAudio.framework/Headers/AVAudioPlayer.h',
      ),
    ],
  ),
);

void main() => config.generate();
```

Next, you'll define the output file.
The main output of FFIgen is a single Dart file
containing bindings for the given inputs.
This file's location is defined by the `output.dartFile` option.

接下来定义输出文件。
FFIgen 的主要输出是一个 Dart 文件，
其中包含给定输入的绑定。
该文件的位置由 `output.dartFile` 选项定义。

FFIgen sometimes generates a `.m` file,
containing Objective-C code required for interop with the API.
FFIgen generates this file only if the API requires it
(for example, if you're using blocks or protocols).
By default, this file has the same name as the Dart bindings,
but with `.m` at the end of the file name.
You can change its location with the `output.objectiveCFile` option.
If FFIgen produces this file, you must compile it into your package,
otherwise you might get runtime exceptions relating to missing symbols.
For this example, FFIgen doesn't generate a `.m` file.

FFIgen 有时会生成 `.m` 文件，
其中包含与该 API 互操作所需的 Objective-C 代码。
只有当 API 需要时 FFIgen 才会生成该文件
（例如你使用了 block 或协议）。
默认情况下，该文件与 Dart 绑定同名，
只是文件名以 `.m` 结尾。
你可以用 `output.objectiveCFile` 选项更改它的位置。
如果 FFIgen 生成了该文件，你必须把它编译进 package，
否则可能会遇到与缺失符号相关的运行时异常。
在本示例中，FFIgen 不会生成 `.m` 文件。

```dart highlightLines=11-13
import 'package:ffigen/ffigen.dart';

final config = FfiGenerator(
  headers: Headers(
    entryPoints: [
      Uri.file(
        '$macSdkPath/System/Library/Frameworks/AVFAudio.framework/Headers/AVAudioPlayer.h',
      ),
    ],
  ),
  output: Output(
    dartFile: Uri.file('avf_audio_bindings.dart'),
  ),
);

void main() => config.generate();
```

Finally, tell FFIgen which parts of the input API to generate bindings for.
By default, FFIgen filters out all the bindings.
In this case, to generate bindings for `AVAudioPlayer`,
which is an Objective-C interface,
you have to set the `objectiveC.interfaces` field.

最后，告诉 FFIgen 要为输入 API 的哪些部分生成绑定。
默认情况下，FFIgen 会滤除全部绑定。
这里要为 Objective-C 接口 `AVAudioPlayer` 生成绑定，
必须设置 `objectiveC.interfaces` 字段。

Setting the `objectiveC` field tells FFIgen
to generate bindings for the Objective-C language.
By default, FFIgen generates C bindings.

设置 `objectiveC` 字段会告诉 FFIgen
为 Objective-C 语言生成绑定。
默认情况下，FFIgen 生成 C 绑定。

```dart highlightLines=11-13
import 'package:ffigen/ffigen.dart';

final config = FfiGenerator(
  headers: Headers(
    entryPoints: [
      Uri.file(
        '$macSdkPath/System/Library/Frameworks/AVFAudio.framework/Headers/AVAudioPlayer.h',
      ),
    ],
  ),
  objectiveC: ObjectiveC(
    interfaces: Interfaces.includeSet({'AVAudioPlayer'}),
  ),
  output: Output(
    dartFile: Uri.file('lib/avf_audio_bindings.dart'),
  ),
);

void main() => config.generate();
```

You can use `includeMember` to filter out specific methods from the class,
and `rename` or `renameMember` to rename the included classes or methods.
There are similar options for protocols and categories.

你可以用 `includeMember` 滤除类中的特定方法，
并用 `rename` 或 `renameMember` 重命名包含的类或方法。
协议和分类也有类似选项。

For a full list of configuration options,
check out the [FFIgen API documentation][].

完整的配置选项列表见 [FFIgen API 文档][FFIgen API documentation]。

[FFIgen API documentation]: {{page.ffigenapi}}

### Generate the Objective-C bindings

### 生成 Objective-C 绑定

To generate the bindings,
navigate to the `example` directory and run the script:

要生成绑定，
请进入 `example` 目录并运行脚本：

```console
$ dart run tool/generate_code.dart
```

This should generate a large `avf_audio_bindings.dart` file,
similar to [this one][].
The main class of interest is `AVAudioPlayer`.

这会生成一个很大的 `avf_audio_bindings.dart` 文件，
类似于 [这个文件][this one]。
主要关注的类是 `AVAudioPlayer`。

You might notice other classes in the file
with a comment indicating they are a stub.
FFIgen generates stub bindings for all transitive dependencies
of the directly included APIs.
To generate full bindings for these stubs,
add them to the includes in your config.
This stubbing behavior can be changed
with the `includeTransitive` options.

你可能会注意到文件中的其他类
带有表明它们是桩的注释。
FFIgen 会为直接包含的 API 的所有传递依赖
生成桩绑定。
要为这些桩生成完整绑定，
请把它们加入配置的 include 中。
这种桩行为可以用 `includeTransitive` 选项更改。

[this one]: {{page.example}}/avf_audio_bindings.dart

### Use the Objective-C bindings

### 使用 Objective-C 绑定

Now you're ready to load and interact with the generated library.
The example app, [play_audio.dart][],
loads and plays audio files passed as command line arguments.
The first step is to load the [dylib][]
and instantiate the native `AVFAudio` library:

现在可以加载生成的库并与之交互。
示例应用 [play_audio.dart][]
会加载并播放作为命令行参数传入的音频文件。
第一步是加载 [dylib][]（动态库），
并实例化原生 `AVFAudio` 库：

```dart
import 'dart:ffi';

import 'package:objective_c/objective_c.dart';

import 'avf_audio_bindings.dart';

const _dylibPath =
    '/System/Library/Frameworks/AVFAudio.framework/Versions/Current/AVFAudio';

void main(List<String> args) async {
  DynamicLibrary.open(_dylibPath);
}
```

Because this example loads a system library,
the dylib path points to the framework's internal dylib.
You can also load your own `.dylib` file,
or if the library is statically linked into your app (often the case on iOS)
you don't need to load anything.

因为本示例加载的是系统库，
dylib 路径指向框架内部的 dylib。
你也可以加载自己的 `.dylib` 文件；
如果库被静态链接进应用（在 iOS 上经常如此），
则无需加载任何东西。

The example plays each of the audio files
specified as command line arguments one by one.
For each argument,
you first have to convert the Dart `String` to an Objective-C `NSString`.
The generated `NSString` wrapper has a convenient constructor
that handles this conversion,
and a `toDartString()` method that converts it back to a Dart `String`.

该示例会逐个播放作为命令行参数指定的音频文件。
对每个参数，首先要把 Dart `String` 转换为 Objective-C `NSString`。
生成的 `NSString` 包装有一个方便的构造函数来处理这一转换，
还有 `toDartString()` 方法把它转回 Dart `String`。

```dart highlightLines=4-7
void main(List<String> args) async {
  DynamicLibrary.open(_dylibPath);

  for (final file in args) {
    final fileStr = NSString(file);
    print('Loading $file');
  }
}
```

The audio player expects an `NSURL`, so next,
use the [`fileURLWithPath:`][] method to convert the `NSString` to an `NSURL`.

音频播放器需要 `NSURL`，因此接下来
使用 [`fileURLWithPath:`][] 方法把 `NSString` 转换为 `NSURL`。

```dart highlightLines=8
void main(List<String> args) async {
  DynamicLibrary.open(_dylibPath);

  for (final file in args) {
    final fileStr = NSString(file);
    print('Loading $file');

    final fileUrl = NSURL.fileURLWithPath(fileStr);
  }
}
```

Now, you can construct the `AVAudioPlayer`.
Constructing an Objective-C object has two stages.
`alloc` allocates the memory for the object,
but doesn't initialize it.
Methods with names starting with `init*` do the initialization.
Some interfaces also provide `new*` methods that do both of these steps.

现在可以构造 `AVAudioPlayer`。
构造 Objective-C 对象有两个阶段。
`alloc` 为对象分配内存，但不初始化它。
名称以 `init*` 开头的方法负责初始化。
有些接口还提供 `new*` 方法，一次完成这两步。

To initialize the `AVAudioPlayer`,
use the [`initWithContentsOfURL:error:`][] method:

要初始化 `AVAudioPlayer`，
请使用 [`initWithContentsOfURL:error:`][] 方法：

```dart highlightLines=9-13
void main(List<String> args) async {
  DynamicLibrary.open(_dylibPath);

  for (final file in args) {
    final fileStr = NSString(file);
    print('Loading $file');

    final fileUrl = NSURL.fileURLWithPath(fileStr);
    final player = AVAudioPlayer.alloc().initWithContentsOfURL(fileUrl);
    if (player == null) {
      print('Failed to load audio.');
      continue;
    }
  }
}
```

This Dart `AVAudioPlayer` object is a wrapper around an underlying
Objective-C `AVAudioPlayer*` object pointer.

这个 Dart `AVAudioPlayer` 对象是底层
Objective-C `AVAudioPlayer*` 对象指针的包装。

Objective-C uses reference counting for memory management
(through retain, release, and other functions),
but on the Dart side memory management is handled automatically.
The Dart wrapper object retains a reference to the Objective-C object,
and when the Dart object is garbage collected,
the reference is automatically released.

Objective-C 使用引用计数管理内存
（通过 retain、release 和其他函数），
但在 Dart 一侧，内存管理是自动的。
Dart 包装对象会保留对 Objective-C 对象的引用，
当 Dart 对象被垃圾回收时，
该引用会自动释放。

Next, look up the length of the audio file,
which you'll need later to wait for the audio to finish.
The [`duration`][] is a `@property(readonly)`.
Objective-C properties are translated into getters and setters
on the generated Dart wrapper object.
Since `duration` is `readonly`, only the getter is generated.

接下来查看音频文件的长度，
稍后等待音频播放结束时会用到。
[`duration`][] 是 `@property(readonly)`。
Objective-C 属性会转换为生成的 Dart 包装对象上的 getter 和 setter。
由于 `duration` 是 `readonly`，只会生成 getter。

`NSTimeInterval` is a type alias for `double`,
so you can immediately use the Dart `.ceil()` method
to round up to the next second:

`NSTimeInterval` 是 `double` 的类型别名，
因此你可以直接使用 Dart 的 `.ceil()` 方法
向上取整到下一秒：

```dart highlightLines=15-16
void main(List<String> args) async {
  DynamicLibrary.open(_dylibPath);

  for (final file in args) {
    final fileStr = NSString(file);
    print('Loading $file');

    final fileUrl = NSURL.fileURLWithPath(fileStr);
    final player = AVAudioPlayer.alloc().initWithContentsOfURL(fileUrl);
    if (player == null) {
      print('Failed to load audio.');
      continue;
    }

    final durationSeconds = player.duration.ceil();
    print('$durationSeconds sec');
  }
}
```

Finally, you can use the [`play`][] method to play the audio,
then check the status, and wait for the duration of the audio file:

最后，可以使用 [`play`][] 方法播放音频，
然后检查状态，并等待音频文件的时长：

```dart highlightLines=18-24
void main(List<String> args) async {
  DynamicLibrary.open(_dylibPath);

  for (final file in args) {
    final fileStr = NSString(file);
    print('Loading $file');

    final fileUrl = NSURL.fileURLWithPath(fileStr);
    final player = AVAudioPlayer.alloc().initWithContentsOfURL(fileUrl);
    if (player == null) {
      print('Failed to load audio.');
      continue;
    }

    final durationSeconds = player.duration.ceil();
    print('$durationSeconds sec');

    final status = player.play();
    if (status) {
      print('Playing...');
      await Future<void>.delayed(Duration(seconds: durationSeconds));
    } else {
      print('Failed to play audio.');
    }
  }
}
```

[play_audio.dart]: {{page.example}}/play_audio.dart
[dylib]: {{page.appledoc}}/avfaudio?language=objc
[`fileURLWithPath:`]: {{page.appledoc}}/foundation/nsurl/1410828-fileurlwithpath?language=objc

### Callbacks and multithreading limitations

### 回调与多线程限制

Multithreading introduces complexity to interop between Objective-C and Dart.
This stems from differences between Dart isolates and OS threads,
and how Apple's APIs handle concurrency:

多线程让 Objective-C 与 Dart 之间的互操作变得复杂。
这源于 Dart isolate 与操作系统线程的差异，
以及 Apple API 处理并发的方式：

1. Dart isolates aren't the same thing as threads.
   Isolates run on threads but aren't
   guaranteed to run on any particular thread,
   and the VM might change which thread an isolate is
   running on without warning.
   There is an [open feature request][] to enable isolates to be
   pinned to specific threads.

   Dart isolate 与线程不是一回事。
   isolate 在线程上运行，但不保证运行在某个特定线程上，
   而且 VM 可能在没有警告的情况下更换 isolate 所在的线程。
   已有一个 [未解决的功能请求][open feature request]，
   希望能把 isolate 固定到特定线程。

2. While FFIgen supports converting
   Dart functions to Objective-C blocks,
   most Apple APIs don't make any guarantees about
   which thread a callback will run on.

   虽然 FFIgen 支持把 Dart 函数转换为 Objective-C block，
   但大多数 Apple API 并不保证回调会在哪个线程上运行。

3. Most APIs that involve UI interaction
   can only be called on the main thread,
   also called the platform thread in Flutter.

   大多数涉及 UI 交互的 API
   只能在主线程上调用，
   在 Flutter 中也称为平台线程。

4. Many Apple APIs are [not thread safe][].

   许多 Apple API [不是线程安全的][not thread safe]。

The first two points mean that a block created in one isolate
might be invoked on a thread running a different isolate,
or no isolate at all.
Depending on the type of block you are using,
this could cause your app to crash.
When a block is created, the isolate it was created in is its owner.
Blocks created using `FooBlock.fromFunction`
must be invoked on the owner isolate's thread,
otherwise they will crash.
Blocks created using `FooBlock.listener` or `FooBlock.blocking`
can be safely invoked from any thread,
and the function they wrap will (eventually) be invoked
inside the owner isolate,
though these constructors are only supported for blocks that return `void`.
If there is user demand for it, `FooBlock.blocking` might
add support for non-`void` return values in the future.

前两点意味着在一个 isolate 中创建的 block，
可能会在运行另一个 isolate 的线程上被调用，
甚至在没有任何 isolate 的线程上被调用。
根据你使用的 block 类型，这可能导致应用崩溃。
创建 block 时，创建它所在的 isolate 是它的所有者。
用 `FooBlock.fromFunction` 创建的 block
必须在所有者 isolate 的线程上调用，否则会崩溃。
用 `FooBlock.listener` 或 `FooBlock.blocking` 创建的 block
可以从任何线程安全调用，
它们包装的函数会（最终）在所有者 isolate 内被调用，
不过这些构造函数只支持返回 `void` 的 block。
如果用户有需求，`FooBlock.blocking` 将来可能会
增加对非 `void` 返回值的支持。

The third point means that directly calling some Apple APIs
using the generated Dart bindings might be thread unsafe.
This could crash your app or cause other unpredictable behavior.
In recent versions of Flutter, the main isolate runs on the platform thread,
so this isn't an issue when invoking these thread-locked APIs
from the main isolate.
If you need to invoke these APIs from other isolates,
or you need to support older versions of Flutter,
you can use the [`runOnPlatformThread`][] function.
For more information, see the [Objective-C dispatch documentation][].

第三点意味着，用生成的 Dart 绑定直接调用某些 Apple API
可能不是线程安全的。
这可能导致应用崩溃，或其他不可预测的行为。
在较新的 Flutter 版本中，主 isolate 运行在平台线程上，
因此从主 isolate 调用这些锁定线程的 API 没有问题。
如果需要从其他 isolate 调用这些 API，
或者需要支持较旧的 Flutter 版本，
可以使用 [`runOnPlatformThread`][] 函数。
更多信息见 [Objective-C dispatch 文档][Objective-C dispatch documentation]。

Regarding the last point,
although Dart isolates can switch threads,
they only ever run on one thread at a time.
The API you interact with doesn't need to be thread safe,
as long as it doesn't have constraints about
which thread it's called from.

关于最后一点，
虽然 Dart isolate 可以切换线程，
但它们在任一时刻只在一个线程上运行。
你交互的 API 不必是线程安全的，
只要它对被调用的线程没有限制。

You can safely interact with Objective-C code
as long as you keep these limitations in mind.

只要记住这些限制，
就可以安全地与 Objective-C 代码交互。

[`runOnPlatformThread`]: {{site.flutter-api}}/flutter/dart-ui/runOnPlatformThread.html

## Swift example

## Swift 示例

This [example][swift_example] demonstrates how to
make a Swift class compatible with Objective-C,
generate a wrapper header, and invoke it from Dart code.

[这个示例][swift_example] 演示如何让 Swift 类与 Objective-C 兼容，
生成包装头文件，并从 Dart 代码调用它。

The process below is manual.
There's an experimental project to automate these steps
called [Swiftgen][].

下面的过程是手动的。
有一个名为 [Swiftgen][] 的实验性项目可以自动完成这些步骤。

[Swiftgen]: {{site.pub-pkg}}/swiftgen

### Generating the Objective-C wrapper header

### 生成 Objective-C 包装头文件

Swift APIs can be made compatible with Objective-C,
by using the `@objc` annotation.
Make sure to make any classes or methods you want to use
`public`, and have your classes extend `NSObject`.

可以使用 `@objc` 注解让 Swift API 与 Objective-C 兼容。
请确保你想使用的类或方法是 `public`，
并且让类继承 `NSObject`。

```swift
import Foundation

@objc public class SwiftClass: NSObject {
  @objc public func sayHello() -> String {
    return "Hello from Swift!";
  }

  @objc public var someField = 123;
}
```

To interact with a third-party library you can't modify,
you might need to write an Objective-C compatible wrapper class
that exposes the methods you want to use.

要与无法修改的第三方库交互，
你可能需要编写一个与 Objective-C 兼容的包装类，
公开你想使用的方法。

For more information about Objective-C / Swift interoperability,
see the [Swift documentation][].

关于 Objective-C / Swift 互操作性的更多信息，
请参阅 [Swift 文档][Swift documentation]。

Once you've made your class compatible,
you can generate an Objective-C wrapper header.
You can do this using Xcode,
or using the Swift command-line compiler, `swiftc`.
This example uses the command line:

让类兼容之后，就可以生成 Objective-C 包装头文件。
可以使用 Xcode，也可以使用 Swift 命令行编译器 `swiftc`。
本示例使用命令行：

```console
$ swiftc -c swift_api.swift             \
    -module-name swift_module           \
    -emit-objc-header-path swift_api.h  \
    -emit-library -o libswiftapi.dylib
```

This command compiles the Swift file, `swift_api.swift`,
and generates a wrapper header, `swift_api.h`.
It also generates the dylib you're going to load later,
`libswiftapi.dylib`.

该命令编译 Swift 文件 `swift_api.swift`，
并生成包装头文件 `swift_api.h`。
它还会生成稍后要加载的 dylib
`libswiftapi.dylib`。

You can verify that the header generated correctly by opening it
and checking that the interfaces are what you expect.
Towards the bottom of the file,
you should see something like the following:

你可以打开头文件，检查接口是否符合预期，
以此验证头文件是否正确生成。
在文件靠近底部的位置，
你应该会看到类似下面的内容：

```objc
SWIFT_CLASS("_TtC12swift_module10SwiftClass")
@interface SwiftClass : NSObject
- (NSString * _Nonnull)sayHello SWIFT_WARN_UNUSED_RESULT;
@property (nonatomic) NSInteger someField;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end
```

If the interface is missing, or doesn't have all of its methods,
make sure they're all annotated with `@objc` and `public`.

如果接口缺失，或没有包含全部方法，
请确认它们都标注了 `@objc` 和 `public`。

### Configuring FFIgen for Swift

### 为 Swift 配置 FFIgen

FFIgen only sees the Objective-C wrapper header, `swift_api.h`.
So most of this config looks similar
to the Objective-C example,
including setting the language to `objc`.

FFIgen 只能看到 Objective-C 包装头文件 `swift_api.h`。
因此这份配置的大部分与 Objective-C 示例相似，
包括把语言设为 `objc`。

```yaml
ffigen:
  name: SwiftLibrary
  description: Bindings for swift_api.
  language: objc
  output: 'swift_api_bindings.dart'
  exclude-all-by-default: true
  objc-interfaces:
    include:
      - 'SwiftClass'
    module:
      'SwiftClass': 'swift_module'
  headers:
    entry-points:
      - 'swift_api.h'
```

As before, set the language to `objc`,
and the entry point to the header;
exclude everything by default,
and explicitly include the interface you are binding.

和之前一样，把语言设为 `objc`，
并把入口点设为该头文件；
默认排除一切，
再显式包含你要绑定的接口。

A key configuration difference for wrapped Swift APIs
is the `objc-interfaces` -> `module` option.
When `swiftc` compiles the library,
it gives the Objective-C interface a module prefix.
Internally, `SwiftClass` is registered as
`swift_module.SwiftClass`.
You need to tell `ffigen` about this prefix,
so it loads the correct class from the dylib.

包装后的 Swift API 有一个关键配置差异，
即 `objc-interfaces` -> `module` 选项。
`swiftc` 编译库时，
会给 Objective-C 接口加上模块前缀。
在内部，`SwiftClass` 注册为
`swift_module.SwiftClass`。
你需要把这个前缀告诉 `ffigen`，
这样它才能从 dylib 加载正确的类。

Not every class gets this prefix.
For example, `NSString` and `NSObject` 
won't get a module prefix, 
because they're internal classes.
This is why the `module` option maps
from class name to module prefix.
You can also use regular expressions to match
multiple class names at once.

并非每个类都会得到这个前缀。
例如，`NSString` 和 `NSObject`
不会得到模块前缀，
因为它们是内部类。
因此 `module` 选项把类名映射到模块前缀。
你也可以用正则表达式一次匹配多个类名。

The module prefix is whatever you passed to
`swiftc` in the `-module-name` flag.
In this example, it's `swift_module`.
If you don't explicitly set this flag,
it defaults to the name of the Swift file.

模块前缀就是你通过 `swiftc` 的 `-module-name` 标志
传入的值。
在本示例中是 `swift_module`。
如果没有显式设置该标志，
它会默认为 Swift 文件的名称。

If you aren't sure what the module name is,
you can also check the generated Objective-C header.
Above the `@interface`, you'll find a `SWIFT_CLASS` macro:

如果不确定模块名，
也可以查看生成的 Objective-C 头文件。
在 `@interface` 上方，你会找到 `SWIFT_CLASS` 宏：

```objc
SWIFT_CLASS("_TtC12swift_module10SwiftClass")
@interface SwiftClass : NSObject
```

The string inside the macro contains the module name and the class name:
`"_TtC12`***`swift_module`***`10`***`SwiftClass`***`"`.

宏内部的字符串包含模块名和类名：
`"_TtC12`***`swift_module`***`10`***`SwiftClass`***`"`。

Swift can even demangle this name for us:

Swift 甚至可以替我们还原这个名称：

```console
$ echo "_TtC12swift_module10SwiftClass" | swift demangle
```

This outputs `swift_module.SwiftClass`.

输出为 `swift_module.SwiftClass`。

### Generating the Swift bindings

### 生成 Swift 绑定

As before, to generate the bindings,
navigate to the example directory and run FFIgen:

和之前一样，要生成绑定，
请进入示例目录并运行 FFIgen：

```console
$ dart run ffigen
```

This generates `swift_api_bindings.dart`.

这会生成 `swift_api_bindings.dart`。

### Using the Swift bindings

### 使用 Swift 绑定

Interacting with these bindings is exactly the same
as for a normal Objective-C library:

与这些绑定交互的方式，
与普通的 Objective-C 库完全相同：

```dart
import 'dart:ffi';
import 'swift_api_bindings.dart';

void main() {
  final lib = SwiftLibrary(DynamicLibrary.open('libswiftapi.dylib'));
  final object = SwiftClass.new1(lib);
  print(object.sayHello());
  print('field = ${object.someField}');
  object.someField = 456;
  print('field = ${object.someField}');
}
```

Note that the module name is not mentioned
in the generated Dart API.
It's only used internally
to load the class from the dylib.

请注意，生成的 Dart API 中不会出现模块名。
它只在内部用于从 dylib 加载类。

Now you can run the example using:

现在可以用下面的命令运行示例：

```console
$ dart run example.dart
```

[`initWithContentsOfURL:error:`]: {{page.appledoc}}/avfaudio/avaudioplayer/1387281-initwithcontentsofurl?language=objc
[`duration`]: {{page.appledoc}}/avfaudio/avaudioplayer/1388395-duration?language=objc
[`play`]: {{page.appledoc}}/avfaudio/avaudioplayer/1387388-play?language=objc
[Swift documentation]: {{page.appledoc}}/swift/importing-swift-into-objective-c
[open feature request]: {{site.repo.dart.sdk}}/issues/46943
[`package:cupertino_http`]: {{site.repo.dart.org}}/http/blob/master/pkgs/cupertino_http/src/CUPHTTPClientDelegate.m
[not thread safe]: {{site.apple-dev}}/library/archive/documentation/Cocoa/Conceptual/Multithreading/ThreadSafetySummary/ThreadSafetySummary.html
[Objective-C dispatch documentation]: {{page.appledoc}}/dispatch?language=objc
[swift_example]: {{site.repo.dart.org}}/native/tree/main/pkgs/ffigen/example/swift
