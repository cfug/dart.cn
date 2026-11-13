---
# title: Getting started with JavaScript interop
title: JavaScript 互操作入门
# breadcrumb: Get started
breadcrumb: 入门
# description: A basic example of using browser APIs and a bundled JS library.
description: 使用浏览器 API 和打包的 JS 库的基本示例。
ai-translated: true
---

This tutorial teaches you the basics of interacting with JavaScript
in Dart code by using various browser and JavaScript APIs. 

本教程通过多种浏览器和 JavaScript API，
教你在 Dart 代码中与 JavaScript 交互的基础。

## Access and define a JavaScript object

## 访问并定义 JavaScript 对象

To access a global JavaScript object, such as the browser's
`document` object, declare an `@JS`-annotated, external
top-level getter. This returns the value as an opaque `JSObject`.

要访问全局 JavaScript 对象，例如浏览器的
`document` 对象，请声明一个带 `@JS` 注解的 external
顶层 getter。它会把值作为不透明的 `JSObject` 返回。

```dart
import 'dart:js_interop';

// All top-level JS interop APIs need the @JS annotation.
@JS()
external JSObject get document;
```

A `JSObject` is opaque and doesn't provide type safety or auto-completion.
To add type-safe members, define an interop type using an extension type.
This acts as an interface, allowing you to declare more interop APIs as
external members. You can define an interop type using
[extension types][] to view it differently:

`JSObject` 是不透明的，不提供类型安全或自动补全。
要添加类型安全的成员，请用扩展类型定义互操作类型。
它充当接口，让你可以把更多互操作 API 声明为
external 成员。你可以使用
[扩展类型][extension types] 定义互操作类型，从而以不同方式查看它：

```dart
@JS()
external Document get document;

extension type Document._(JSObject _) implements JSObject {}
```

Now, you can add external methods to your `Document` interface. For example,
add the `createElement()` instance method:

现在，你可以为 `Document` 接口添加 external 方法。例如，
添加 `createElement()` 实例方法：

```dart
extension type Document._(JSObject _) implements JSObject {
  external JSObject createElement(JSString tag);
}
```

With the `createElement` method defined, you can call it on the
`document` object. Notice that you must convert `'button'` from
a `String` to a `JSString` using the `.toJS` extension method.

定义 `createElement` 方法后，就可以在
`document` 对象上调用它。注意，必须使用 `.toJS` 扩展方法，
把 `'button'` 从 `String` 转换为 `JSString`。

```dart
var button = document.createElement('button'.toJS);
```

Values passed to and from interop APIs must be either an
interop type (like `JSObject` or `JSString`) or an allowed
Dart primitive.

传入和传出互操作 API 的值必须是
互操作类型（例如 `JSObject` 或 `JSString`），
或者是允许的 Dart 基本类型。

## Use automatic type conversions

## 使用自动类型转换

The compiler automatically converts most Dart primitive types
(like `String`, `num`, `bool`, and `null`), so you can often
use them directly in interop signatures to simplify your code.

编译器会自动转换大多数 Dart 基本类型
（例如 `String`、`num`、`bool` 和 `null`），
因此你通常可以直接在互操作签名中使用它们，从而简化代码。

For example, you can rewrite the `createElement` declaration
from the previous section to accept a Dart `String` directly.
For example:

例如，你可以把上一节的 `createElement` 声明
改写为直接接受 Dart `String`。
例如：

```dart
external JSObject createElement(String tag);
```

Now, you can call it without the explicit `.toJS` conversion.
For example:

现在，调用时可以不显式使用 `.toJS` 转换。
例如：

```dart
var button = document.createElement('button');
```

To add the newly created button to the document's body, first
define interop types for the `body` and its `appendChild()` method:

要把新创建的按钮添加到文档的 body，
首先为 `body` 及其 `appendChild()` 方法定义互操作类型：

```dart
extension type Document._(JSObject _) implements JSObject {
  external JSObject createElement(String tag);
  external Body get body;
}

extension type Body._(JSObject _) implements JSObject {
  external JSObject appendChild(JSObject child);
}
```

With these definitions, you can create a button and add it to
the page:

有了这些定义，就可以创建按钮并把它添加到页面：

```dart
var button = document.createElement('button');
document.body.appendChild(button);
```

## Handle events and callbacks

## 处理事件和回调

To handle user interactions, such as a button click,
you can register an event listener using `addEventListener()`.

要处理用户交互，例如按钮点击，
可以使用 `addEventListener()` 注册事件监听器。

First, create an interface for a button element. Then, call
`addEventListener` with the event name and a callback function.

首先为按钮元素创建一个接口。然后用事件名和回调函数
调用 `addEventListener`。

```dart
extension type ButtonElement(JSObject _) implements JSObject {
  external void addEventListener(String event, JSFunction listener);
}
```

```dart
var button = ButtonElement(document.createElement('button'));
document.body.appendChild(button);
button.addEventListener('click', (JSObject event) {
  print('Clicked!');
}.toJS);
```

Callbacks converted to JS with `.toJS` have the same
type limitations as other interop APIs in that their parameters
and return values must be interop types or compatible primitives.

用 `.toJS` 转换为 JS 的回调，
与其他互操作 API 有相同的类型限制：
参数和返回值必须是互操作类型或兼容的基本类型。

## Work with Promises and Arrays

## 使用 Promise 和 Array

JavaScript interop provides helpers for other common types, like
converting JavaScript Promises to and from Dart `Futures`, and
`Arrays` to and from `Lists`.

JavaScript 互操作为其他常见类型提供了辅助方法，
例如在 JavaScript Promise 与 Dart `Future` 之间转换，
以及在 `Array` 与 `List` 之间转换。

### Promises and futures

### Promise 与 Future

This example uses the `fetch` API, which returns a `Promise`.
The `.toDart` extension converts the `Promise` to a `Future`,
so you can `await` its result in Dart:

本示例使用 `fetch` API，它返回一个 `Promise`。
`.toDart` 扩展把 `Promise` 转换为 `Future`，
因此你可以在 Dart 中 `await` 它的结果：

```dart
import 'dart:js_interop';

extension type Response._(JSObject _) implements JSObject {
  external bool get ok;
}

@JS()
external Response fetch(String resource);

void main() async {
  var response = await fetch('image.png').toDart;
  print(response.ok);
}
```

### Arrays and Lists

### Array 与 List

This example calls the static JavaScript `Array.of` method
to create a `JSArray`. It then converts the array to a
Dart `List`, iterates over it, and prints each element.

本示例调用 JavaScript 的静态方法 `Array.of`
来创建 `JSArray`。然后把数组转换为
Dart `List`，遍历并打印每个元素。

```dart
import 'dart:js_interop';

@JS('Array.of')
external JSArray<JSString> arrayOf(String a, String b);

void main() {
  var array = arrayOf('hello', 'world');
  var list = array.toDart;
  for (var element in list) {
    print(element.toDart);
  }
}
```

When converting a generic type like a `List`, its elements
must already be JS interop types. For example, to convert
a `List<String>`, you must first convert each `String`
into a `JSString`.

转换 `List` 这类泛型时，其元素必须已经是 JS 互操作类型。
例如，要转换 `List<String>`，必须先把每个 `String`
转换为 `JSString`。

```dart
// Option 1: Create the list with JS types initially.
List<JSString> list = ['hello'.toJS, 'world'.toJS];
JSArray jsArray1 = list.toJS;

// Option 2: Map a Dart list to a list of JS types.
List<String> dartList = ['hello', 'world'];
JSArray jsArray2 = dartList.map((e) => e.toJS).toList().toJS;
```

## Learn more

## 了解更多

* For more information on type conversions, check out [Conversions][].

  关于类型转换的更多信息，请查阅 [转换][Conversions]。

* For more information on how to write interop APIs, see the [Usage guide][].

  关于如何编写互操作 API 的更多信息，请参阅 [用法指南][Usage guide]。

* To access common utility functions, see:

  要使用常见的实用函数，请参阅：

  * The [`dart:js_interop`][] library, and

    [`dart:js_interop`][] 库，以及

  * The [`dart:js_interop_unsafe`][] library.

    [`dart:js_interop_unsafe`][] 库。

* The [`package:web`][] exposes many of the browser APIs
  (including those used in the above examples) through interop declarations.

  [`package:web`][] 通过互操作声明公开许多浏览器 API
  （包括上面示例中使用的那些）。

[extension types]: /language/extension-types
[Conversions]: /interop/js-interop/js-types#conversions
[Usage guide]: /interop/js-interop/usage
[`dart:js_interop`]: {{site.dart-api}}/dart-js_interop/
[`dart:js_interop_unsafe`]: {{site.dart-api}}/dart-js_interop_unsafe/
[`package:web`]: /interop/js-interop/package-web
