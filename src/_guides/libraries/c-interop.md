---
title: "C interop using dart:ffi"
title: "使用 dart:ffi 与 C 进行交互"
description: "To use C code in your Dart program, use the dart:ffi library."
description: "在你的 Dart 程序中使用 dart:ffi 库调用 C 语言的代码。"
hw: "https://github.com/dart-lang/samples/tree/master/ffi/hello_world"
samples: "https://github.com/dart-lang/samples/tree/master/ffi"
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
[`dart:ffi` API reference.]({{site.dart_api}}/dart-ffi/dart-ffi-library.html)

相关的 API 文档可在
[`dart:ffi` API 文档]({{site.dart_api}}/dart-ffi/dart-ffi-library.html)
查看。

## Examples

## 示例

The following examples show how to use the `dart:ffi` library:

以下的示例将展示如何使用 `dart:ffi` 库：

| **Example**     | **Description**                                                                                                             |
| **示例**        | **描述**                                                                                                                     |
| [hello_world][] | How to call a C function with no arguments and no return value.                                                             |
| [hello_world][] | 如何调用无参数和返回值的 C 语言函数。                                                                                           |
| [primitives][]  | How to call C functions that have arguments and return values that are **ints or pointers**. Also demonstrates **varargs**. |
| [primitives][]  | 如何调用参数和返回值为 **整型和指针** 的 C 语言函数。同时演示 **varargs**。                                                        |
| [structs][]     | How to use structs to pass **strings** to and from C and to handle **simple and complex C structures**.                     |
| [structs][]     | 如何与 C 语言互相传递字符串，以及如何处理 **C 语言定义的结构**。                                                                   |
| [sqlite][]      | An example in the Dart SDK repo that comes with a [mini tutorial.][]                                                        |
| [sqlite][]      | Dart SDK 仓库中包含的 [小型示例][mini tutorial.]。                                                                             |

## Walkthrough of hello_world

## 快速上手的 hello_world

The [hello_world example][hello_world] has the minimum necessary code
for calling a C library.

[hello_world 示例][hello_world] 展示了如何用最少的代码调用 C 语言库。

### Files

### 文件

The hello_world example has the following files:

hello_world 示例包含了以下文件：

| **Source file** | **Description** |
| **源文件** | **描述** |
| [hello.dart]({{page.hw}}/hello.dart) | A Dart file that uses the `hello_world()` function from a C library. |
| [hello.dart]({{page.hw}}/hello.dart) | 使用了 C 语言库中的 `hello_world()` 函数的文件。 |
| [pubspec.yaml]({{page.hw}}/pubspec.yaml) | The usual Dart [pubspec](/tools/pub/pubspec), with a lower bounds on the SDK that's at least 2.6. |
| [pubspec.yaml]({{page.hw}}/pubspec.yaml) | Dart 里常见的 [pubspec 文件](/tools/pub/pubspec)，最低 SDK 限制为 2.6。 |
| [hello_library/hello.h]({{page.hw}}/hello_library/hello.h) | Declares the `hello_world()` function. |
| [hello_library/hello.h]({{page.hw}}/hello_library/hello.h) | 声明了 `hello_world()` 函数。 |
| [hello_library/hello.c]({{page.hw}}/hello_library/hello.c) | A C file that imports `hello.h` and defines the `hello_world()` function. |
| [hello_library/hello.c]({{page.hw}}/hello_library/hello.c) | 该 C 文件导入了 `hello.h` 并实现了 `hello_world()` 函数。 |
| [hello_library/hello.def]({{page.hw}}/hello_library/hello.def) | A module-definition file which specifies information used when building a DLL. |
| [hello_library/hello.def]({{page.hw}}/hello_library/hello.def) | 包含 DLL 构建信息的模块定义。 |
| [hello_library/CMakeLists.txt]({{page.hw}}/hello_library/CMakeLists.txt) | A CMake build file for compiling the C code into a dynamic library. |
| [hello_library/CMakeLists.txt]({{page.hw}}/hello_library/CMakeLists.txt) | 将 C 文件代码编译为动态库的 CMake 文件。 |
{:.table .table-striped }

{% comment %}
[PENDING: say something about other files, like setup.sh?]
[TODO (https://github.com/dart-lang/site-www/issues/2219): Fix build instructions.]
{% endcomment %}

Building the C library creates several files,
including a dynamic library file named
`libhello.dylib` (macOS), 
`libhello.dll` (Windows), or
`libhello.so` (Linux).

构建 C 代码库时将创建几个文件，包括动态库
`libhello.dylib`（仅 macOS）、
`libhello.dll`（仅 Windows）
或 `libhello.so`（仅 Linux）。

### Building and running

### 构建并运行

Here's an example of building the dynamic library and executing the Dart app:

以下是构建动态库并执行 Dart 应用的示例：

```terminal
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

{{site.alert.info}}

  **On macOS,** the Dart VM (`dart`) can load only **signed libraries.**
  For details and workarounds,
  see [SDK issue #38314.][38314]

  **在 macOS 上，** Dart VM (`dart`) 只能加载 **已签名的库。**
  若想了解更多细节和解决方案，请查看 [SDK 的 issue #38314][38314]。

{{site.alert.end}}

[38314]: https://github.com/dart-lang/sdk/issues/38314
  

### Using dart:ffi

### 使用 dart:ffi

The [`hello.dart` file]({{page.hw}}/hello.dart)
illustrates the steps for using `dart:ffi` to call a C function:

[`hello.dart` 文件]({{page.hw}}/hello.dart)
阐述了使用 dart:ffi 调用 C 函数的步骤：

1. Import `dart:ffi`.

   导入 `dart:ffi`。

2. Import the path library that you'll use to store the path of dynamic library.

   导入 `path` 库用于合成动态库的路径。

3. Create a typedef with the FFI type signature of the C function.

   为 C 函数的 FFI 类型签名的定义一个类型。

4. Create a typedef for the variable that you'll use when calling the C function.

   为调用 C 函数的变量定义一个类型。

5. Create a variable to store the path of the dynamic library.

   利用一个变量保存动态库的路径。

6. Open the dynamic library that contains the C function.

   加载包含 C 函数的动态库。

7. Get a reference to the C function, and put it into a variable.

   创建该 C 函数的引用，接着将其赋予变量。

8. Call the C function.

   调用 C 函数。

Here's the code for each step.

以下是每一个步骤对应的代码。

1. Import `dart:ffi`.

   导入 dart:ffi。

```dart
import 'dart:ffi' as ffi;
```

2. Import the path library that you'll use to store the path of dynamic library.

   导入 `path` 库用于合成动态库的路径。

```dart
import 'dart:io' show Platform, Directory;
import 'package:path/path.dart' as path;
```

3. Create a typedef with the FFI type signature of the C function. <br>
   See [Interfacing with native types](#interfacing-with-native-types)
   for commonly used types defined by `dart:ffi` library.

   为 C 函数的 FFI 类型签名的定义一个类型。<br>
   参阅 [定义原生类型的接口](#interfacing-with-native-types)
   了解 `dart:ffi` 库中定义的常用类型。

```dart
typedef hello_world_func = ffi.Void Function();
```

4. Create a typedef for the variable that you'll use
   when calling the C function.

   为调用 C 函数的变量定义一个类型。

```dart
typedef HelloWorld = void Function();
```

5. Create a variable to store the path of the dynamic library.

   利用一个变量保存动态库的路径。

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
   This code uses the typedefs defined in steps 2 and 3, 
   along with the dynamic library variable from step 4.

   创建该 C 函数的引用，接着将其赋予变量。
   这段代码使用了步骤 2 和 3 定义的类型，以及步骤 4 创建的动态库变量。

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

Once you understand the hello_world example, 
you should be ready to look at the
[other `dart:ffi` examples](#examples).

当你理解 hello_world 示例的内容后，
可以进一步学习 [其他的 `dart:ffi` 示例](#examples)。

## Bundling and loading C libraries

## 集成并加载 C 库

How you bundle (or _package_ or _distribute_)
a C library with your package or app
and then load that library
depends on your platform and the type of library.
For details, see the following:

根据平台和库的类型的不同，捆绑（或 **打包** 和 **分发**）
C 库到 package 或应用并进行加载的方式，有所不同。

* [Flutter `dart:ffi` page][binding]

  [Flutter `dart:ffi` 页面][binding]

* [`dart:ffi` examples]({{page.samples}})

  [`dart:ffi` 示例]({{page.samples}})

## Interfacing with native types

The `dart:ffi` library provides multiple types
that implement [`NativeType`][]
and represent native types in C.

Some native types are only used as markers in type signatures
while others (or their subtypes) can be instantiated.

#### Purely marker native types

The following table lists some native types that are only
used as markers in type signatures,
and can't be instantiated in Dart code:

| **Dart type**                                                                                                     | **Description**                                      |
|-------------------------------------------------------------------------------------------------------------------|------------------------------------------------------|
| [AbiSpecificInteger]({{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-ffi/AbiSpecificInteger-class.html) | The supertype of all [Abi][] specific integer types. |
| [Bool]({{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-ffi/Bool-class.html)                             | Represents a native bool in C.                       |
| [Double]({{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-ffi/Double-class.html)                         | Represents a native 64 bit double in C.              |
| [Float]({{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-ffi/Float-class.html)                           | Represents a native 32 bit float in C.               |
| [Int8]({{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-ffi/Int8-class.html)                             | Represents a native signed 8 bit integer in C.       |
| [Int16]({{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-ffi/Int16-class.html)                           | Represents a native signed 16 bit integer in C.      |
| [Int32]({{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-ffi/Int32-class.html)                           | Represents a native signed 32 bit integer in C.      |
| [Int64]({{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-ffi/Int64-class.html)                           | Represents a native signed 64 bit integer in C.      |
| [NativeFunction]({{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-ffi/NativeFunction-class.html)         | Represents a function type in C.                     |
| [Opaque]({{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-ffi/Opaque-class.html)                         | The supertype of all opaque types in C.              |
| [Uint8]({{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-ffi/Uint8-class.html)                           | Represents a native unsigned 8 bit integer in C.     |
| [Uint16]({{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-ffi/Uint16-class.html)                         | Represents a native unsigned 16 bit integer in C.    |
| [Uint32]({{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-ffi/Uint32-class.html)                         | Represents a native unsigned 32 bit integer in C.    |
| [Uint64]({{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-ffi/Uint64-class.html)                         | Represents a native unsigned 64 bit integer in C.    |
| [Void]({{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-ffi/Void-class.html)                             | Represents a void type in C.                         |
{:.table .table-striped }

#### Instantiable native types

The following native types can be used as markers in type signatures
and they (or their subtypes) can be instantiated in Dart code:

| **Dart type**                                                                               | **Description**                                                  |
|---------------------------------------------------------------------------------------------|------------------------------------------------------------------|
| [Array]({{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-ffi/Array-class.html)     | A fixed-sized array of items. Supertype of type specific arrays. |
| [Pointer]({{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-ffi/Pointer-class.html) | Represents a pointer into native C memory.                       |
| [Struct]({{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-ffi/Struct-class.html)   | The supertype of all FFI struct types.                           |
| [Union]({{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-ffi/Union-class.html)     | The supertype of all FFI union types.                            |
{:.table .table-striped }

## Generating FFI bindings with `package:ffigen`

## 使用 `package:ffigen` 生成 FFI 的绑定

For large API surfaces it can be time-consuming
to write the Dart bindings that integrate with the C code. 
To reduce this burden, 
you can use the [`package:ffigen`][ffigen] binding generator 
to automatically create FFI wrappers from C header files.

为大量的 API 编写绑定可能要花费你的大量时间。你可以使用 [`package:ffigen`][ffigen]
绑定生成器，自动地从 C 头文件生成 FFI 包装，从而减少时间消耗。

[Abi]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-ffi/Abi-class.html
[binding]: {{site.flutter-docs}}/development/platform-integration/c-interop
[FFI]: https://en.wikipedia.org/wiki/Foreign_function_interface
[hello_world]: {{page.hw}}
[primitives]: {{page.samples}}/primitives
[structs]: {{page.samples}}/structs
[sqlite]: https://github.com/dart-lang/sdk/tree/main/samples/ffi/sqlite
[mini tutorial.]: https://github.com/dart-lang/sdk/blob/main/samples/ffi/sqlite/docs/sqlite-tutorial.md
[`NativeType`]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-ffi/NativeType-class.html
[ffigen]: {{site.pub-pkg}}/ffigen
