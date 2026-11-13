---
# title: JS types
title: JS 类型
# breadcrumb: Types
breadcrumb: 类型
# description: Usage information about the core types in JS interop.
description: JS 互操作中核心类型的用法说明。
ai-translated: true
prevpage:
  url: /interop/js-interop/usage
# title: Usage
  title: 用法
nextpage:
  url: /interop/js-interop/tutorials
# title: JS interop tutorials
  title: JS 互操作教程
---

Dart values and JS values belong to separate language domains. When compiling to
[Wasm][], they execute in separate *runtimes* as well. As such, you should treat JS
values as foreign types. To provide Dart types for JS values,
[`dart:js_interop`] exposes a set of types prefixed with `JS` called "JS types".
These types are used to distinguish between Dart values and JS values at
compile-time.

Dart 值和 JS 值属于不同的语言领域。编译到
[Wasm][] 时，它们还会在各自的 **运行时** 中执行。
因此，你应当把 JS 值视为外部类型。
为了给 JS 值提供 Dart 类型，
[`dart:js_interop`] 公开了一组以 `JS` 为前缀的类型，称为「JS 类型」。
这些类型用于在编译期区分 Dart 值和 JS 值。

Importantly, these types are reified differently based on whether you compile to
Wasm or JS. This means that their runtime type will differ, and therefore you
[can't use `is` checks and `as` casts](#compatibility-type-checks-and-casts).
In order to interact with and examine these JS values, you should use
[`external`] interop members or [conversions](#conversions).

这些类型的具体化方式还取决于你编译到 Wasm 还是 JS。
这意味着它们的运行时类型会不同，因此你
[不能使用 `is` 检查和 `as` 转换](#compatibility-type-checks-and-casts)。
要与这些 JS 值交互并检查它们，应使用
[`external`] 互操作成员或 [转换](#conversions)。

## Type hierarchy

## 类型层次

JS types form a natural type hierarchy:

JS 类型构成自然的类型层次：

- Top type: `JSAny`, which is any non-nullish JS value

  顶层类型：`JSAny`，表示任何非 nullish 的 JS 值

  - Primitives: `JSNumber`, `JSBoolean`, `JSString`, `JSSymbol`, `JSBigInt`

    基本类型：`JSNumber`、`JSBoolean`、`JSString`、`JSSymbol`、`JSBigInt`

  - `JSObject`, which is any JS object

    `JSObject`，表示任何 JS 对象

    - `JSFunction`

      `JSFunction`

      - `JSExportedDartFunction`, which represents a Dart callback that was
      converted to a JS function

        `JSExportedDartFunction`，表示已转换为 JS 函数的 Dart 回调

    - `JSArray`

      `JSArray`

    - `JSPromise`

      `JSPromise`

    - `JSDataView`

      `JSDataView`

    - `JSTypedArray`

      `JSTypedArray`

      - JS typed arrays like `JSUint8Array`

        例如 `JSUint8Array` 的 JS 类型化数组

    - `JSBoxedDartObject`, which allows users to box and pass Dart values
      opaquely within the same Dart runtime

      `JSBoxedDartObject`，让用户可以在同一个 Dart 运行时中
      不透明地装箱并传递 Dart 值

      - From Dart 3.4 onwards, the type `ExternalDartReference` in
      `dart:js_interop` also allows users to pass Dart values opaquely, but is
      *not* a JS type. Learn more about the tradeoffs between each option
      [here](#jsboxeddartobject-vs-externaldartreference).

        从 Dart 3.4 起，`dart:js_interop` 中的
        `ExternalDartReference` 类型也可以不透明地传递 Dart 值，
        但它 **不是** JS 类型。两种选择的取舍见
        [这里](#jsboxeddartobject-vs-externaldartreference)。

You can find the definition of each type in the [`dart:js_interop` API docs].

每种类型的定义见 [`dart:js_interop` API 文档][`dart:js_interop` API docs]。

{% comment %}
TODO (srujzs): Should we add a tree diagram instead for JS types?
{% endcomment %}

## Conversions

## 转换

To use a value from one domain to another, you will likely want to *convert* the
value to the corresponding type of the other domain. For example, you might want
to convert a Dart `List<JSString>` into a JS array of strings, which is
represented by the JS type `JSArray<JSString>`, so that you can pass the array
to a JS interop API.

要把一个领域中的值用到另一个领域，通常需要把该值 **转换**
为另一个领域中对应的类型。例如，你可能想把 Dart 的
`List<JSString>` 转换为字符串的 JS 数组，
其 JS 类型为 `JSArray<JSString>`，
这样才能把数组传给 JS 互操作 API。

Dart supplies a number of conversion members on various Dart types and JS types
to convert the values between the domains for you.

Dart 在多种 Dart 类型和 JS 类型上提供了转换成员，
替你在两个领域之间转换值。

Members that convert values from Dart to JS usually start with `toJS`:

把值从 Dart 转换到 JS 的成员通常以 `toJS` 开头：

```dart
String str = 'hello world';
JSString jsStr = str.toJS;
```

Members that convert values from JS to Dart usually start with `toDart`:

把值从 JS 转换到 Dart 的成员通常以 `toDart` 开头：

```dart
JSNumber jsNum = ...;
int integer = jsNum.toDartInt;
```

Not all JS types have a conversion, and not all Dart types have a conversion.
Generally, the conversion table looks like the following:

并非所有 JS 类型都有转换，也并非所有 Dart 类型都有转换。
转换关系大致如下：

| <t>`dart:js_interop` type</t><t>`dart:js_interop` 类型</t> | <t>Dart type</t><t>Dart 类型</t> |
| ----------------------------------- | ---------------------------------------- |
| `JSNumber`, `JSBoolean`, `JSString` | `num`, `int`, `double`, `bool`, `String` |
| `JSNumber`、`JSBoolean`、`JSString` | `num`、`int`、`double`、`bool`、`String` |
| `JSExportedDartFunction`            | `Function`                               |
| `JSExportedDartFunction`            | `Function`                               |
| `JSArray<T extends JSAny?>`         | `List<T extends JSAny?>`                 |
| `JSArray<T extends JSAny?>`         | `List<T extends JSAny?>`                 |
| `JSPromise<T extends JSAny?>`       | `Future<T extends JSAny?>`               |
| `JSPromise<T extends JSAny?>`       | `Future<T extends JSAny?>`               |
| Typed arrays like `JSUint8Array`    | Typed lists from `dart:typed_data`       |
| 例如 `JSUint8Array` 的类型化数组    | 来自 `dart:typed_data` 的类型化列表       |
| `JSBoxedDartObject`                 | Opaque Dart value                        |
| `JSBoxedDartObject`                 | 不透明的 Dart 值                         |
| `ExternalDartReference`             | Opaque Dart value                        |
| `ExternalDartReference`             | 不透明的 Dart 值                         |

{:.table .table-striped}

:::warning
Compiling to JavaScript versus [Wasm][] can introduce inconsistencies in
both performance and semantics for conversions.
Conversions might have different costs depending on the compiler,
so prefer to only convert values if you need to.

编译到 JavaScript 与编译到 [Wasm][] 相比，
转换在性能和语义上可能不一致。
转换的开销会随编译器而不同，
因此只在需要时转换值。

Conversions also might or might not produce a new value. This doesn't matter for
immutable values like numbers, but does matter for types like `List`. Depending
on the implementation, a conversion to `JSArray` might return a reference, a
proxy, or a clone of the original list. To avoid this, do not rely on any
relation between the `List` and `JSArray` and only rely on their contents being
the same. Typed array conversions have a similar limitation. Look up the
specific conversion function for more details.

转换也未必会生成新值。对数字这类不可变值没有影响，
但对 `List` 这类类型有影响。根据实现，
转换为 `JSArray` 可能返回原列表的引用、代理或克隆。
为避免这一问题，不要依赖 `List` 与 `JSArray` 之间的任何关系，
只依赖它们的内容相同。类型化数组的转换也有类似限制。
请查阅具体的转换函数以了解详情。
:::

## Requirements on `external` declarations and `Function.toJS`

## 对 `external` 声明和 `Function.toJS` 的要求

In order to ensure type safety and consistency, the compiler places requirements
on what types can flow into and out of JS. Passing arbitrary Dart values into JS
is not allowed. Instead, the compiler requires users to use a compatible interop
type, `ExternalDartReference`, or a primitive, which would then be implicitly
converted by the compiler. For example, these would be allowed:

为了保证类型安全和一致性，编译器对哪些类型可以流入和流出 JS
提出了要求。不能把任意 Dart 值传入 JS。
编译器要求使用兼容的互操作类型、`ExternalDartReference` 或基本类型，
然后由编译器隐式转换。例如，下面这些是允许的：

```dart tag=good
@JS()
external void primitives(String a, int b, double c, num d, bool e);
```

```dart tag=good
@JS()
external JSArray jsTypes(JSObject _, JSString __);
```

```dart tag=good
extension type InteropType(JSObject _) implements JSObject {}

@JS()
external InteropType get interopType;
```

```dart tag=good
@JS()
external void externalDartReference(ExternalDartReference _);
```

Whereas these would return an error:

而下面这些会报错：

```dart tag=bad
@JS()
external Function get function;
```

```dart tag=bad
@JS()
external set list(List _);
```

These same requirements exist when you use [`Function.toJS`] to make a Dart
function callable in JS. The values that flow into and out of this callback must
be a compatible interop type or a primitive.

使用 [`Function.toJS`] 让 Dart 函数可以在 JS 中调用时，
也有同样的要求。流入和流出该回调的值
必须是兼容的互操作类型或基本类型。

If you use a Dart primitive like `String`, an implicit conversion happens in the
compiler to convert that value from a JS value to a Dart value. If performance
is critical and you don’t need to examine the contents of the string, then using
`JSString` instead to avoid the conversion cost might make sense like in the
second example.

如果使用 `String` 这类 Dart 基本类型，
编译器会隐式把该值从 JS 值转换为 Dart 值。
如果性能至关重要，而且你不需要检查字符串的内容，
那么像第二个示例那样改用 `JSString` 以避免转换开销，可能更合适。

## Compatibility, type checks, and casts

## 兼容性、类型检查和类型转换

The runtime type of JS types might differ based on the compiler. This affects
runtime type-checking and casts. Therefore, almost always avoid `is` checks
where the value is an interop type or where the target type is an interop type:

JS 类型的运行时类型可能因编译器而异。
这会影响运行时类型检查和类型转换。
因此，当值是互操作类型，或目标类型是互操作类型时，
几乎总是应避免 `is` 检查：

On WebAssembly, all JS interop types
(such as `JSString`, `JSArray`, and user-defined extension types)
share a single underlying runtime representation (typically `externref`).
Because Dart's extension types are erased at compile time,
a runtime check like `value is JSString` cannot distinguish
a string from any other JS value,
and will evaluate to `true` for almost any JS value,
leading to silent bugs.

在 WebAssembly 上，所有 JS 互操作类型
（例如 `JSString`、`JSArray` 以及用户定义的扩展类型）
共享同一种底层运行时表示（通常是 `externref`）。
由于 Dart 的扩展类型在编译期会被擦除，
`value is JSString` 这样的运行时检查无法把字符串
与其他 JS 值区分开，
并且对几乎任何 JS 值都会求值为 `true`，
从而造成不易察觉的错误。

```dart tag=bad
void f(JSAny a) {
  if (a is String) { … }
}
```

```dart tag=bad
void f(JSAny a) {
  if (a is JSObject) { … }
}
```

Also, avoid casts between Dart types and interop types:

同样，避免在 Dart 类型和互操作类型之间做类型转换：

```dart tag=bad
void f(JSString s) {
  s as String;
}
```

To type-check a JS value, use an interop member like [`typeofEquals`] or
[`instanceOfString`] that examines the JS value itself:

要检查 JS 值的类型，请使用 [`typeofEquals`] 或
[`instanceOfString`] 这类会检查 JS 值本身的互操作成员：

```dart tag=good
void f(JSAny a) {
  // Here `a` is verified to be a JS function, so the cast is okay.
  if (a.typeofEquals('function')) {
    a as JSFunction;
  }
}
```

From Dart 3.4 onwards, you can use the [`isA`] helper function to check whether
a value is any interop type:

从 Dart 3.4 起，可以使用 [`isA`] 辅助函数
检查某个值是否为任意互操作类型：

```dart tag=good
void f(JSAny a) {
  if (a.isA<JSString>()) {} // `typeofEquals('string')`
  if (a.isA<JSArray>()) {} // `instanceOfString('Array')`
  if (a.isA<CustomInteropType>()) {} // `instanceOfString('CustomInteropType')`
}
```

Depending on the type parameter, it'll transform the call into the appropriate
type-check for that type.

根据类型参数，它会把调用转换为该类型对应的类型检查。



To avoid invalid type checks with JS interop types,
enable the [`invalid_runtime_check_with_js_interop_types`][] lint rule.

为避免对 JS 互操作类型做无效的类型检查，
请启用 [`invalid_runtime_check_with_js_interop_types`][] lint 规则。

[`invalid_runtime_check_with_js_interop_types`]: /tools/linter-rules/invalid_runtime_check_with_js_interop_types

## `null` vs `undefined`

## `null` 与 `undefined`

JS has both a `null` and an `undefined` value. This is in contrast with Dart,
which only has `null`. In order to make JS values more ergonomic to use, if an
interop member were to return either JS `null` or `undefined`, the compiler maps
these values to Dart `null`. Therefore a member like `value` in the following
example can be interpreted as returning a JS object, JS `null`, or `undefined`:

JS 既有 `null` 也有 `undefined`。这与 Dart 不同，
Dart 只有 `null`。为了让 JS 值更好用，
如果互操作成员返回 JS `null` 或 `undefined`，
编译器会把这些值映射为 Dart `null`。
因此，下面示例中的 `value` 成员可以理解为
返回 JS 对象、JS `null` 或 `undefined`：

```dart
@JS()
external JSObject? get value;
```

If the return type was not declared as nullable, then the program will throw an
error if the value returned was JS `null` or `undefined` to ensure soundness.

如果返回类型没有声明为可空，
那么当返回值是 JS `null` 或 `undefined` 时，
程序会抛出错误，以保证健全性。

:::warning
There is a subtle inconsistency with regards to `undefined` between compiling to
JS and [Wasm][]. While compiling to JS *treats* `undefined` values as if they were
Dart `null`, it doesn't actually *change* the value itself. If an interop member
returns `undefined` and you pass that value back into JS, JS will see
`undefined`, *not* `null`, when compiling to JS.

在 `undefined` 上，编译到 JS 和编译到 [Wasm][] 有一处细微的不一致。
编译到 JS 时会把 `undefined` 值 **视为** Dart `null`，
但并不会真正 **改变** 该值本身。
如果互操作成员返回 `undefined`，你再把该值传回 JS，
在编译到 JS 时，JS 看到的是 `undefined`，**不是** `null`。

However, when compiling to Wasm, this is not the case,
and the value will be `null` in JS. This is because
the compiler implicitly *converts* the value to Dart `null` when compiling to
Wasm, thereby losing information on whether the original value was JS `null` or
`undefined`. Avoid writing code where this distinction matters by explicitly
passing Dart `null` instead to an interop member.

不过，编译到 Wasm 时并非如此，
该值在 JS 中会是 `null`。这是因为编译到 Wasm 时，
编译器会隐式把该值 **转换** 为 Dart `null`，
从而丢失原值是 JS `null` 还是 `undefined` 的信息。
如果这一区别会影响结果，请避免编写这样的代码，
改为向互操作成员显式传递 Dart `null`。

Currently, there's no platform-consistent way to provide `undefined`
to interop members or distinguish between JS `null` and `undefined` values,
but this will likely change in the future. See [#54025] for more details.

目前还没有跨平台一致的方式，
向互操作成员提供 `undefined`，
或区分 JS `null` 与 `undefined`，
但将来可能会改变。详情见 [#54025]。
:::

## `JSBoxedDartObject` vs `ExternalDartReference`

## `JSBoxedDartObject` 与 `ExternalDartReference`

From Dart 3.4 onwards, both [`JSBoxedDartObject`] and [`ExternalDartReference`]
can be used to pass opaque references to Dart `Object`s through JavaScript.
However, `JSBoxedDartObject` wraps the opaque reference in a JavaScript object,
while `ExternalDartReference` is the reference itself and therefore is not a JS
type.

从 Dart 3.4 起，[`JSBoxedDartObject`] 和 [`ExternalDartReference`]
都可以用来通过 JavaScript 传递指向 Dart `Object` 的不透明引用。
不过，`JSBoxedDartObject` 把不透明引用包装在 JavaScript 对象中，
而 `ExternalDartReference` 就是引用本身，因此不是 JS 类型。

Use `JSBoxedDartObject` if you need a JS type or if you need extra checks to
make sure Dart values don't get passed to another Dart runtime. For example, if
the Dart object needs to be placed in a `JSArray` or passed to an API that
accepts a `JSAny`, use `JSBoxedDartObject`. Use `ExternalDartReference`
otherwise as it will be faster.

如果需要 JS 类型，或者需要额外检查以确保
Dart 值不会被传到另一个 Dart 运行时，请使用 `JSBoxedDartObject`。
例如，如果 Dart 对象需要放入 `JSArray`，
或传给接受 `JSAny` 的 API，请使用 `JSBoxedDartObject`。
其他情况使用 `ExternalDartReference`，因为它更快。

See [`toExternalReference`] and [`toDartObject`] to convert to and from an
`ExternalDartReference`.

在 `ExternalDartReference` 与 Dart 对象之间转换，
请参阅 [`toExternalReference`] 和 [`toDartObject`]。

[`dart:js_interop`]: {{site.dart-api}}/dart-js_interop/dart-js_interop-library.html
[`external`]: /language/functions#external
[`Function.toJS`]: {{site.dart-api}}/dart-js_interop/FunctionToJSExportedDartFunction/toJS.html
[`dart:js_interop` API docs]: {{site.dart-api}}/dart-js_interop/dart-js_interop-library.html#extension-types
[`typeofEquals`]: {{site.dart-api}}/dart-js_interop/JSAnyUtilityExtension/typeofEquals.html
[`instanceOfString`]: {{site.dart-api}}/dart-js_interop/JSAnyUtilityExtension/instanceOfString.html
[`isA`]: {{site.dart-api}}/dart-js_interop/JSAnyUtilityExtension/isA.html
[#54025]: {{site.repo.dart.sdk}}/issues/54025
[`JSBoxedDartObject`]: {{site.dart-api}}/dart-js_interop/JSBoxedDartObject-extension-type.html
[`ExternalDartReference`]: {{site.dart-api}}/dart-js_interop/ExternalDartReference-extension-type.html
[`toExternalReference`]: {{site.dart-api}}/dart-js_interop/ObjectToExternalDartReference/toExternalReference.html
[`toDartObject`]: {{site.dart-api}}/dart-js_interop/ExternalDartReferenceToObject/toDartObject.html
[Wasm]: /web/wasm
