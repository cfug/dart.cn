---
# title: "C interop using dart:ffi"
title: "使用 dart:ffi 与 C 进行交互"
# description: "To use C code in your Dart program, use the dart:ffi library."
description: "在你的 Dart 程序中使用 dart:ffi 库调用 C 语言的代码。"
hw: "https://github.com/dart-lang/samples/tree/main/ffi/hello_world"
samples: "https://github.com/dart-lang/samples/tree/main/ffi"
---

Dart mobile, command-line, and server apps
running on the [Dart Native platform](/overview#platform)
can use the `dart:ffi` library to call native C APIs,
and to read, write, allocate, and deallocate native memory.
_FFI_ stands for [_foreign function interface._][FFI]
Other terms for similar functionality include
_native interface_ and _language bindings._

Dart 的移动端、命令行和服务端应用所运行的 [Dart 原生平台](/overview#platform)，
均可以使用 `dart:ffi` 库调用原生的 C 语言 API，用于读、写、分配和销毁原生内存。
**FFI** 指的是 [**外部函数接口**][FFI]。
类似的术语包括 **原生接口** 和 **语言绑定**。

API documentation is available in the
[`dart:ffi` API reference.]({{site.dart-api}}/dart-ffi/dart-ffi-library.html)

相关的 API 文档可在
[`dart:ffi` API 文档]({{site.dart-api}}/dart-ffi/dart-ffi-library.html)
查看。

## Download example files

## 下载示例文件

To work with the examples in this guide,
download the full [ffi samples]({{samples}}) directory.
It includes the following examples show how to use the `dart:ffi` library:

以下的示例将展示如何使用 `dart:ffi` 库：

| <t>**Example**</t><t>示例</t>    |  <t>**Description**</t><t>描述</t>                                                      |
| --------------- | ------------------------------------------------------------------------------------------------------- |
| [hello_world][] | How to call a C function with no arguments and no return value.                                         |
| [hello_world][] | 如何调用无参数和返回值的 C 语言函数。                                                                      |
| [primitives][]  | How to call C functions that have arguments and return values that are **ints or pointers**.            |
| [primitives][]  | 如何调用参数和返回值为 **整型和指针** 的 C 语言函数。                                                      |
| [structs][]     | How to use structs to pass **strings** to and from C and to handle **simple and complex C structures**. |
| [structs][]     | 如何与 C 语言互相传递字符串，以及如何处理 **C 语言定义的结构**。                                            |
| [test_utils][]  | Common testing utilities for all of these examples.                                                     |
| [test_utils][]  | 所有示例的通用测试工具。                                                                                  |

{:.table .table-striped }

### Review the hello_world example

### 回顾 hello_world 示例

The [hello_world example][hello_world] has the minimum necessary code
for calling a C library.
This example can be found in the `samples/ffi` you downloaded in the
previous section.

[hello_world 示例][hello_world] 展示了如何用最少的代码调用 C 语言库。
该示例可在上一节下载的 `samples/ffi` 中找到。

#### Files

#### 文件

The `hello_world` example has the following files:

`hello_world` 示例包含了以下文件：

| <t>**Source file**</t><t>源文件</t> | <t>**Description**</t><t>描述</t>                                            |
|----------------------------------|--------------------------------------------------------------------------------|
| [`hello.dart`]                   | A Dart file that uses the `hello_world()` function from a C library.           |
| [`hello.dart`]                   | 使用了 C 语言库中的 `hello_world()` 函数的文件。                                  |
| [`pubspec.yaml`]                 | The Dart [pubspec](/tools/pub/pubspec) file, with an SDK lower bound of 3.4.   |
| [`pubspec.yaml`]                 | Dart [pubspec 文件](/tools/pub/pubspec)，最低 SDK 限制为 3.4。                   |
| [`hello_library/hello.h`]        | Declares the `hello_world()` function.                                         |
| [`hello_library/hello.h`]        | 声明了 `hello_world()` 函数。                                                   |
| [`hello_library/hello.c`]        | A C file that imports `hello.h` and defines the `hello_world()` function.      |
| [`hello_library/hello.c`]        | 该 C 文件导入了 `hello.h` 并实现了 `hello_world()` 函数。                        |
| [`hello_library/hello.def`]      | A module-definition file which specifies information used when building a DLL. |
| [`hello_library/hello.def`]      | 包含 DLL 构建信息的模块定义。                                                    |
| [`hello_library/CMakeLists.txt`] | A CMake build file for compiling the C code into a dynamic library.            |
| [`hello_library/CMakeLists.txt`] | 将 C 文件代码编译为动态库的 CMake 文件。                                          |

{:.table .table-striped }

[`hello.dart`]: {{hw}}/hello.dart
[`pubspec.yaml`]: {{hw}}/pubspec.yaml
[`hello_library/hello.h`]: {{hw}}/hello_library/hello.h
[`hello_library/hello.c`]: {{hw}}/hello_library/hello.c
[`hello_library/hello.def`]: {{hw}}/hello_library/hello.def
[`hello_library/CMakeLists.txt`]: {{hw}}/hello_library/CMakeLists.txt

Building the C library creates several files,
including a dynamic library file named
`libhello.dylib` (macOS),
`libhello.dll` (Windows), or
`libhello.so` (Linux).

构建 C 代码库时将创建几个文件，包括动态库
`libhello.dylib`（仅 macOS）、
`libhello.dll`（仅 Windows）
或 `libhello.so`（仅 Linux）。

#### Build and execute

#### 构建并执行

The commands to build the dynamic library and execute the Dart app would
resemble the following series.

以下一系列命令是构建动态库并执行 Dart 应用的示例：

```console
$ cd hello_library
$ cmake .
...
$ make
...
$ cd ..
$ dart pub get
$ dart run hello.dart
Hello World
```

:::note

**On macOS,** executables, including the Dart VM (`dart`),
can load only **signed libraries.**
To learn more about signing libraries,
consult Apple's [Code Signing Guide.][codesign]

**在 macOS 上，** 包括 Dart VM (`dart`)
在内的可执行文件只能加载 **已签名的库。**
若想了解更多细节和解决方案，请查看 Apple 的 [签名指南][codesign]。

:::

[codesign]: {{site.apple-dev}}/library/content/documentation/Security/Conceptual/CodeSigningGuide/Introduction/Introduction.html

#### Leverage dart:ffi

#### 使用 dart:ffi

To learn how to call a C function using the `dart:ffi` library,
review the [`hello.dart` file]({{hw}}/hello.dart).
This section explains the contents of this file.

要学习如果使用 `dart:ffi` 库调用 C 函数，
请查看 [`hello.dart` 文件]({{hw}}/hello.dart)。
本节将分析该文件的内容。

1. Import `dart:ffi`.

   导入 `dart:ffi`。

   ```dart
   import 'dart:ffi' as ffi;
   ```

2. Import the path library that you'll use to store the path of dynamic library.

   导入 `path` 库用于合成动态库的路径。

   ```dart
   import 'dart:io' show Platform, Directory;
   import 'package:path/path.dart' as path;
   ```

3. Create a typedef with the FFI type signature of the C function.  
   To learn about the most used types according to the `dart:ffi` library
   consult [Interfacing with native types](#interface-with-native-types).

   用 C 函数的 FFI 类型签名定义一个 typedef。  
   请参阅 [定义原生类型的接口](#interface-with-native-types)
   来了解 `dart:ffi` 库中定义的常用类型。

   ```dart
   typedef hello_world_func = ffi.Void Function();
   ```

4. Create a `typedef` for the variable to use when calling the C function.

   为调用 C 函数的变量定义一个 `typedef`。

   ```dart
   typedef HelloWorld = void Function();
   ```

5. Create a variable to store the path of the dynamic library.

   定义一个变量来保存动态库的路径。

   ```dart
   var libraryPath = path.join(Directory.current.path, 'hello_library',
       'libhello.so');
   if (Platform.isMacOS) {
     libraryPath = path.join(Directory.current.path, 'hello_library',
         'libhello.dylib');
   } else if (Platform.isWindows) {
     libraryPath = path.join(Directory.current.path, 'hello_library',
         'Debug', 'hello.dll');
   }
   ```

6. Open the dynamic library that contains the C function.

   加载包含 C 函数的动态库。

   ```dart
   final dylib = ffi.DynamicLibrary.open(libraryPath);
   ```

7. Get a reference to the C function,
   and put it into a variable.
   This code uses the `typedefs` from steps 2 and 3,
   along with the dynamic library variable from step 4.

   获取该 C 函数的引用，接着将其赋予变量。
   这段代码使用了步骤 2 和 3 定义的 `typedef`，
   以及步骤 4 定义的动态库变量。

   ```dart
   final HelloWorld hello = dylib
       .lookup<ffi.NativeFunction<hello_world_func>>('hello_world')
       .asFunction();
   ```

8. Call the C function.

   调用 C 函数。

   ```dart
   hello();
   ```

Once you understand the `hello_world` example,
consult the [other `dart:ffi` examples](#download-example-files).

当你理解 `hello_world` 示例的内容后，
可以进一步学习 [其他的 `dart:ffi` 示例](#download-example-files)。

## Bundle and load C libraries

## 集成并加载 C 库

The method to bundle / package / distribute then
load a native C library depends on the platform and library type.

根据平台和库的类型的不同，
集成 / 打包 / 分发后加载原生 C 库的方式，也有所不同。

To learn how, consult the following pages and examples.

请参考以下页面和示例，来了解如何使用。

* Flutter `dart:ffi` for [Android][android] apps

  用于 [Android][android] 应用的 Flutter `dart:ffi`

* Flutter `dart:ffi` for [iOS][ios] apps

  用于 [iOS][ios] 应用的 Flutter `dart:ffi`

* Flutter `dart:ffi` for [macOS][macos] apps

  用于 [macOS][macos] 应用的 Flutter `dart:ffi`

* [`dart:ffi` examples]({{samples}})

  [`dart:ffi` 示例]({{samples}})

## Interface with native types

## 定义原生类型的接口

The `dart:ffi` library provides multiple types that implement [`NativeType`][]
and represent native types in C. You can instantiate some native types.
Some other native types can be used only as markers in type signatures.

### Can instantiate these type signature markers

The following native types can be used as markers in type signatures.
They or their subtypes _can_ be instantiated in Dart code.

{% capture dart-ffi -%}
{{site.dart-api}}/{{site.sdkInfo.channel}}/dart-ffi
{%- endcapture %}

| **Dart type**   | **Description**                                                  |
| --------------- | ---------------------------------------------------------------- |
| [Array][]       | A fixed-sized array of items. Supertype of type specific arrays. |
| [Pointer][]     | Represents a pointer into native C memory.                       |
| [Struct][]      | The supertype of all FFI struct types.                           |
| [Union][]       | The supertype of all FFI union types.                            |

{:.table .table-striped }

### Serve as type signature markers only

The following list shows which platform-agnostic native types
that serve as markers in type signatures.
They _can't_ be instantiated in Dart code.

| **Dart type**      | **Description**                                   |
| ------------------ | ------------------------------------------------- |
| [Bool][]           | Represents a native bool in C.                    |
| [Double][]         | Represents a native 64 bit double in C.           |
| [Float][]          | Represents a native 32 bit float in C.            |
| [Int8][]           | Represents a native signed 8 bit integer in C.    |
| [Int16][]          | Represents a native signed 16 bit integer in C.   |
| [Int32][]          | Represents a native signed 32 bit integer in C.   |
| [Int64][]          | Represents a native signed 64 bit integer in C.   |
| [NativeFunction][] | Represents a function type in C.                  |
| [Opaque][]         | The supertype of all opaque types in C.           |
| [Uint8][]          | Represents a native unsigned 8 bit integer in C.  |
| [Uint16][]         | Represents a native unsigned 16 bit integer in C. |
| [Uint32][]         | Represents a native unsigned 32 bit integer in C. |
| [Uint64][]         | Represents a native unsigned 64 bit integer in C. |
| [Void][]           | Represents the `void` type in C.                  |

{:.table .table-striped }

There are also many [ABI][] specific marker native types
that extend [AbiSpecificInteger][].
To learn how these types map on specific platforms,
consult the API documentation linked in the following table.

| **Dart type**            | **Description**                                    |
| -------------------------| -------------------------------------------------- |
| [AbiSpecificInteger][]   | The supertype of all ABI-specific integer types.   |
| [Int][]                  | Represents the `int` type in C.                    |
| [IntPtr][]               | Represents the `intptr_t` type in C.               |
| [Long][]                 | Represents the `long int` (`long`) type in C.      |
| [LongLong][]             | Represents the `long long` type in C.              |
| [Short][]                | Represents the `short` type in C.                  |
| [SignedChar][]           | Represents the `signed char` type in C.            |
| [Size][]                 | Represents the `size_t` type in C.                 |
| [UintPtr][]              | Represents the `uintptr_t` type in C.              |
| [UnsignedChar][]         | Represents the `unsigned char` type in C.          |
| [UnsignedInt][]          | Represents the `unsigned int` type in C.           |
| [UnsignedLong][]         | Represents the `unsigned long int` type in C.      |
| [UnsignedLongLong][]     | Represents the `unsigned long long` type in C.     |
| [UnsignedShort][]        | Represents the `unsigned short` type in C.         |
| [WChar][]                | Represents the `wchar_t` type in C.                |

{:.table .table-striped }

## Generate FFI bindings with `package:ffigen`

## 使用 `package:ffigen` 生成 FFI 的绑定

For large API surfaces, it can be time-consuming
to write the Dart bindings that integrate with the C code.
To have Dart create FFI wrappers from C header files,
use the [`package:ffigen`][ffigen] binding generator.

为大量的 API 编写绑定可能要花费你的大量时间。
你可以使用 [`package:ffigen`][ffigen] 绑定生成器，
自动地从 C 头文件生成 FFI 包装，从而减少时间消耗。

## Build and bundle native assets {:#native-assets}

:::note
The native assets are **experimental**,
and [in active development]({{site.repo.dart.sdk}}/issues/50565).
:::

The _Native Assets_ feature should resolve a number of issues associated with
the distribution of Dart packages that depend on native code.
It does so by providing uniform hooks for integrating with various
build systems involved in building Flutter and standalone Dart applications.

This feature should simplify how Dart packages depend on and use native code.
Native Assets should provide the following benefits:

* Build the native code or obtains the binaries
  using a package's `hook/build.dart` build hook.
* Bundle the native [`Asset`][] that the `build.dart` build hook reports.
* Make native assets available at runtime through
  declarative `@Native<>() extern` functions using the [`assetId`][].

When you [opt in](#opt-in-to-the-experiment) to the native experiment,
The `flutter (run|build)` and `dart (run|build)` commands
build and bundle native code with the Dart code.

### Review the `native_add_library` example

The [`native_add_library`][] example includes the minimum code to
build and bundle C code in a Dart package.

The example includes the following files:

{% capture native-assets -%}
{{site.repo.dart.org}}/native/blob/main/pkgs/native_assets_cli/example/build/native_add_library
{%- endcapture %}

| **Source file**                         | **Description**                                                                                                                                                                |
------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [`src/native_add_library.c`][]          | The C file containing the code for `add`.                                                                                                                                      |
| [`lib/native_add_library.dart`][]       | The Dart file that invokes the C function `add` in asset `package:native_add_library/native_add_library.dart` through FFI. (Note that _asset id_ defaults to the library uri.) |
| [`test/native_add_library_test.dart`][] | A Dart test using the native code.                                                                                                                                             |
| [`hook/build.dart`][]                   | A build hook for compiling `src/native_add_library.c` and declaring the compiled asset with  id `package:native_add_library/native_add_library.dart`.                              |

{:.table .table-striped }

[`src/native_add_library.c`]: {{native-assets}}/src/native_add_library.c
[`lib/native_add_library.dart`]: {{native-assets}}/lib/native_add_library.dart
[`test/native_add_library_test.dart`]: {{native-assets}}/test/native_add_library_test.dart
[`hook/build.dart`]: {{native-assets}}/hook/build.dart

When a Dart or Flutter project depends on `package:native_add_library`,
it invokes the `hook/build.dart` build hook on `run`, `build`, and `test` commands.
The [`native_add_app`][] example showcases a use of `native_add_library`.

### Review Native Asset API documentation

API documentation can be found for the following packages:

* To learn about native assets in Dart FFI,
  consult the `dart:ffi` API reference for [`Native`][] and [`DefaultAsset`][].
* To learn about the `hook/build.dart` build hook,
  consult the [`package:native_assets_cli` API reference][].

### Opt-in to the experiment

To learn how to enable the experiment and provide feedback,
consult these tracking issues:

* [Dart native assets]({{site.repo.dart.sdk}}/issues/50565)
* [Flutter native assets](https://github.com/flutter/flutter/issues/129757)

[`Asset`]: {{site.pub-api}}/native_assets_cli/latest/native_assets_cli/Asset-class.html
[`assetId`]: {{site.dart-api}}/dart-ffi/Native/assetId.html
[`DefaultAsset`]: {{site.dart-api}}/dart-ffi/DefaultAsset-class.html
[`native_add_app`]: {{site.repo.dart.org}}/native/tree/main/pkgs/native_assets_cli/example/build/native_add_app
[`native_add_library`]: {{native-assets}}
[`Native`]: {{site.dart-api}}/dart-ffi/Native-class.html
[`NativeType`]: {{dart-ffi}}/NativeType-class.html
[`package:native_assets_cli` API reference]: {{site.pub-api}}/native_assets_cli/latest/
[ABI]: {{dart-ffi}}/Abi-class.html
[AbiSpecificInteger]: {{dart-ffi}}/AbiSpecificInteger-class.html
[android]: {{site.flutter-docs}}/development/platform-integration/android/c-interop
[Bool]: {{dart-ffi}}/Bool-class.html
[Double]: {{dart-ffi}}/Double-class.html
[FFI]: https://en.wikipedia.org/wiki/Foreign_function_interface
[ffigen]: {{site.pub-pkg}}/ffigen
[Float]: {{dart-ffi}}/Float-class.html
[hello_world]: {{hw}}
[Int]: {{dart-ffi}}/Int-class.html
[Int16]: {{dart-ffi}}/Int16-class.html
[Int32]: {{dart-ffi}}/Int32-class.html
[Int64]: {{dart-ffi}}/Int64-class.html
[Int8]: {{dart-ffi}}/Int8-class.html
[IntPtr]: {{dart-ffi}}/IntPtr-class.html
[ios]: {{site.flutter-docs}}/development/platform-integration/ios/c-interop
[Long]: {{dart-ffi}}/Long-class.html
[LongLong]: {{dart-ffi}}/LongLong-class.html
[macos]: {{site.flutter-docs}}/development/platform-integration/macos/c-interop
[NativeFunction]: {{dart-ffi}}/NativeFunction-class.html
[Opaque]: {{dart-ffi}}/Opaque-class.html
[primitives]: {{samples}}/primitives
[Short]: {{dart-ffi}}/Short-class.html
[SignedChar]: {{dart-ffi}}/SignedChar-class.html
[Size]: {{dart-ffi}}/Size-class.html
[structs]: {{samples}}/structs
[test_utils]: {{samples}}/test_utils
[Uint16]: {{dart-ffi}}/Uint16-class.html
[Uint32]: {{dart-ffi}}/Uint32-class.html
[Uint64]: {{dart-ffi}}/Uint64-class.html
[Uint8]: {{dart-ffi}}/Uint8-class.html
[UintPtr]: {{dart-ffi}}/UintPtr-class.html
[UnsignedChar]: {{dart-ffi}}/UnsignedChar-class.html
[UnsignedInt]: {{dart-ffi}}/UnsignedInt-class.html
[UnsignedLong]: {{dart-ffi}}/UnsignedLong-class.html
[UnsignedLongLong]: {{dart-ffi}}/UnsignedLongLong-class.html
[UnsignedShort]: {{dart-ffi}}/UnsignedShort-class.html
[Void]: {{dart-ffi}}/Void-class.html
[WChar]: {{dart-ffi}}/WChar-class.html
[Array]: {{dart-ffi}}/Array-class.html
[Pointer]: {{dart-ffi}}/Pointer-class.html
[Struct]: {{dart-ffi}}/Struct-class.html
[Union]: {{dart-ffi}}/Union-class.html
