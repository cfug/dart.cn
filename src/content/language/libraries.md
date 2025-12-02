---
# title: Libraries & imports
title: 库和导入
# shortTitle: Libraries
shortTitle: 库
# description: Guidance on importing and implementing libraries.
description: 关于导入和实现库的指导。
prevpage:
  url: /language/metadata
  # title: Metadata
  title: 元数据
nextpage:
  url: /language/classes
  # title: Classes
  title: 类
---

The `import` and `library` directives can help you create a
modular and shareable code base. Libraries not only provide APIs, but
are a unit of privacy: identifiers that start with an underscore (`_`)
are visible only inside the library. *Every Dart file (plus its parts) is a
[library][]*, even if it doesn't use a [`library`](#library-directive) directive.

`import` 和 `library` 指令可以帮助你创建一个模块化和可共享的代码库。
库不仅提供 API，还是一个隐私单元：
以下划线（`_`）开头的标识符只在库内部可见。
*每个 Dart 文件（及其部分）都是一个[库][library]*，
即使它没有使用 [`library`](#library-directive) 指令。

Libraries can be distributed using [packages](/tools/pub/packages).

库可以使用 [package](/tools/pub/packages) 来分发。

Dart uses underscores instead of access modifier keywords
like `public`, `protected`, or `private`.
While access modifier keywords from other languages
provide more fine-grained control,
Dart's use of underscores and library-based privacy
provides a straightforward configuration mechanism,
helps enable an efficient implementation of [dynamic access][],
and improves tree shaking (dead code elimination).

Dart 使用下划线而不是像 `public`、`protected` 或 `private`
这样的访问修饰符关键字。
虽然其他语言的访问修饰符关键字提供更细粒度的控制，
但 Dart 使用下划线和基于库的隐私机制提供了一种简单的配置机制，
有助于实现[动态访问][dynamic access]的高效实现，
并改进了摇树优化（死代码消除）。

[library]: /resources/glossary#library
[dynamic access]: /effective-dart/design#avoid-using-dynamic-unless-you-want-to-disable-static-checking

## Using libraries

## 使用库

Use `import` to specify how a namespace from one library is used in the
scope of another library.

使用 `import` 来指定如何在另一个库的作用域中使用一个库的命名空间。

For example, Dart web apps generally use the [`dart:js_interop`][]
library, which they can import like this:

例如，Dart Web 应用通常使用 [`dart:js_interop`][] 库，
可以像这样导入它：

<?code-excerpt "misc/test/language_tour/browser_test.dart (dart-js-interop-import)"?>
```dart
import 'dart:js_interop';
```

The only required argument to `import` is a URI specifying the
library.
For built-in libraries, the URI has the special `dart:` scheme.
For other libraries, you can use a file system path or the `package:`
scheme. The `package:` scheme specifies libraries provided by a package
manager such as the pub tool. For example:

`import` 唯一必需的参数是指定库的 URI。
对于内置库，URI 具有特殊的 `dart:` 方案。
对于其他库，你可以使用文件系统路径或 `package:` 方案。
`package:` 方案指定由包管理器（如 pub 工具）提供的库。例如：

<?code-excerpt "misc/test/language_tour/browser_test.dart (package-import)"?>
```dart
import 'package:test/test.dart';
```

:::note
*URI* stands for uniform resource identifier.
*URLs* (uniform resource locators) are a common kind of URI.

*URI* 代表统一资源标识符。
*URL*（统一资源定位符）是一种常见的 URI。
:::

### Specifying a library prefix

### 指定库前缀

If you import two libraries that have conflicting identifiers, then you
can specify a prefix for one or both libraries. For example, if library1
and library2 both have an Element class, then you might have code like
this:

如果你导入两个具有冲突标识符的库，
那么你可以为一个或两个库指定前缀。
例如，如果 library1 和 library2 都有一个 Element 类，
那么你可能会有这样的代码：

<?code-excerpt "misc/lib/language_tour/libraries/import_as.dart" replace="/(lib\d)\.dart/package:$1\/$&/g"?>
```dart
import 'package:lib1/lib1.dart';
import 'package:lib2/lib2.dart' as lib2;

// Uses Element from lib1.
Element element1 = Element();

// Uses Element from lib2.
lib2.Element element2 = lib2.Element();
```

Import prefixes with the [wildcard][] name `_` are non-binding,
but will provide access to the non-private extensions in that library.

使用[通配符][wildcard]名称 `_` 的导入前缀是非绑定的，
但将提供对该库中非私有扩展的访问。

[wildcard]: /language/variables#wildcard-variables

### Importing only part of a library

### 只导入库的一部分

If you want to use only part of a library, you can selectively import
the library. For example:

如果你只想使用库的一部分，可以选择性地导入库。例如：

<?code-excerpt "misc/lib/language_tour/libraries/show_hide.dart (imports)" replace="/(lib\d)\.dart/package:$1\/$&/g"?>
```dart
// Import only foo.
import 'package:lib1/lib1.dart' show foo;

// Import all names EXCEPT foo.
import 'package:lib2/lib2.dart' hide foo;
```

#### Lazily loading a library {:#lazily-loading-a-library}

#### 延迟加载库 {:#lazily-loading-a-library}

*Deferred loading* (also called *lazy loading*)
allows a web app to load a library on demand,
if and when the library is needed.
Use deferred loading when you want to meet one or more of the following needs.

*延迟加载*（也称为*懒加载*）允许 Web 应用在需要时按需加载库。
当你想要满足以下一个或多个需求时，请使用延迟加载。

* Reduce a web app's initial startup time.
* Perform A/B testing—trying out
  alternative implementations of an algorithm, for example.
* Load rarely used functionality, such as optional screens and dialogs.

* 减少 Web 应用的初始启动时间。
* 执行 A/B 测试——例如，尝试算法的替代实现。
* 加载很少使用的功能，例如可选的屏幕和对话框。

That doesn't mean Dart loads all the deferred components at start time.
The web app can download deferred components via the web when needed.

这并不意味着 Dart 在启动时加载所有延迟组件。
Web 应用可以在需要时通过网络下载延迟组件。

The `dart` tool doesn't support deferred loading for targets other than web.
If you're building a Flutter app,
consult its implementation of deferred loading in the Flutter guide on
[deferred components][flutter-deferred].

`dart` 工具不支持 Web 以外的目标的延迟加载。
如果你正在构建 Flutter 应用，
请参阅 Flutter 指南中关于[延迟组件][flutter-deferred]的延迟加载实现。

[flutter-deferred]: {{site.flutter-docs}}/perf/deferred-components

To lazily load a library, first import it using `deferred as`.

要延迟加载库，首先使用 `deferred as` 导入它。

<?code-excerpt "misc/lib/language_tour/libraries/greeter.dart (import)" replace="/hello\.dart/package:greetings\/$&/g"?>
```dart
import 'package:greetings/hello.dart' deferred as hello;
```

When you need the library, invoke
`loadLibrary()` using the library's identifier.

当你需要该库时，使用库的标识符调用 `loadLibrary()`。

<?code-excerpt "misc/lib/language_tour/libraries/greeter.dart (load-library)"?>
```dart
Future<void> greet() async {
  await hello.loadLibrary();
  hello.printGreeting();
}
```

In the preceding code,
the `await` keyword pauses execution until the library is loaded.
For more information about `async` and `await`,
check out [asynchronous programming](/language/async).

在前面的代码中，`await` 关键字暂停执行，直到库加载完成。
有关 `async` 和 `await` 的更多信息，
请查看[异步编程](/language/async)。

You can invoke `loadLibrary()` multiple times on a library without problems.
The library is loaded only once.

你可以在一个库上多次调用 `loadLibrary()` 而不会出现问题。
该库只会加载一次。

Keep in mind the following when you use deferred loading:

使用延迟加载时，请记住以下几点：

* A deferred library's constants aren't constants in the importing file.
  Remember, these constants don't exist until the deferred library is loaded.
* You can't use types from a deferred library in the importing file.
  Instead, consider moving interface types to a library imported by
  both the deferred library and the importing file.
* Dart implicitly inserts `loadLibrary()` into the namespace that you define
  using <code>deferred as <em>namespace</em></code>.
  The `loadLibrary()` function returns
  a [`Future`](/libraries/dart-async#future).

* 延迟库的常量在导入文件中不是常量。
  请记住，这些常量在延迟库加载之前不存在。
* 你不能在导入文件中使用延迟库中的类型。
  相反，考虑将接口类型移动到延迟库和导入文件都导入的库中。
* Dart 会隐式地将 `loadLibrary()` 插入到你使用
  <code>deferred as <em>namespace</em></code> 定义的命名空间中。
  `loadLibrary()` 函数返回一个 [`Future`](/libraries/dart-async#future)。

### The `library` directive {:#library-directive}

### `library` 指令 {:#library-directive}

To specify library-level [doc comments][] or [metadata annotations][],
attach them to a `library` declaration at the start of the file.

要指定库级别的[文档注释][doc comments]或[元数据注解][metadata annotations]，
请将它们附加到文件开头的 `library` 声明上。

<?code-excerpt "misc/lib/effective_dart/docs_good.dart (library-doc)"?>
```dart
/// A really great test library.
@TestOn('browser')
library;
```

## Implementing libraries

## 实现库

See
[Create Packages](/tools/pub/create-packages)
for advice on how to implement a package, including:

有关如何实现包的建议，请参阅
[创建包](/tools/pub/create-packages)，包括：

* How to organize library source code.
* How to use the `export` directive.
* When to use the `part` directive.
* How to use conditional imports and exports to implement
  a library that supports multiple platforms.

* 如何组织库源代码。
* 如何使用 `export` 指令。
* 何时使用 `part` 指令。
* 如何使用条件导入和导出来实现支持多平台的库。

[`dart:js_interop`]: {{site.dart-api}}/dart-js_interop/dart-js_interop-library.html
[doc comments]: /effective-dart/documentation#consider-writing-a-library-level-doc-comment
[metadata annotations]: /language/metadata
