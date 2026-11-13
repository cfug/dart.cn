---
# title: Past JS interop
title: 早期 JS 互操作
# breadcrumb: Legacy
breadcrumb: 旧版
# description: Archive of Dart's previous JS interop support.
description: Dart 早期 JS 互操作支持的存档。
ai-translated: true
prevpage:
  url: /interop/js-interop/tutorials
# title: JS interop tutorials
  title: JS 互操作教程
nextpage:
  url: /interop/js-interop/package-web/
# title: Migrate to package:web
  title: 迁移到 package:web
---

## The evolution of JavaScript interop {: #next-generation-js-interop }

## JavaScript 互操作的演进

[Dart 3.3][] introduces a new generation of JS interop that offers
a unified set of features and APIs to access JavaScript and browser
functionalities within your Dart code. This modern approach enhances the
developer experience and enables WebAssembly ([Wasm][]) support, aligning
Dart with the future of the web.

[Dart 3.3][] 引入了新一代 JS 互操作，
提供一套统一的功能和 API，
让你在 Dart 代码中访问 JavaScript 和浏览器功能。
这一现代方式改善了开发体验，并支持 WebAssembly（[Wasm][]），
使 Dart 与 Web 的未来保持一致。

The following table maps Dart's new JS and web interop solutions to
their past counterparts:

下表把 Dart 新的 JS 和 Web 互操作方案
对应到它们的早期方案：

| <t>New interop libraries</t><t>新的互操作库</t> | <t>Legacy libraries</t><t>旧版库</t> |
|------------------------------|------------------------------------------|
| [`package:web`][] | [`dart:html`][] <br> [`dart:indexed_db`][] <br> [`dart:svg`][] <br> [`dart:web_audio`][] <br> [`dart:web_gl`][] |
| [`package:web`][] | [`dart:html`][] <br> [`dart:indexed_db`][] <br> [`dart:svg`][] <br> [`dart:web_audio`][] <br> [`dart:web_gl`][] |
| [`dart:js_interop`][] <br> [`dart:js_interop_unsafe`][] | [`package:js`][] <br> [`dart:js`][] <br> [`dart:js_util`][] |
| [`dart:js_interop`][] <br> [`dart:js_interop_unsafe`][] | [`package:js`][] <br> [`dart:js`][] <br> [`dart:js_util`][] |

{:.table .table-striped}


Previous iterations of JS interop for Dart are considered legacy and
are deprecated as of Dart 3.7 (Feb 2025).
Prefer using [`dart:js_interop`][] going forwards and
migrate usages of old interop libraries when possible.
Support for browser APIs, such as [`dart:html`][],
are now supported by [`package:web`][].

Dart 早期的 JS 互操作被视为旧版，
并自 Dart 3.7（2025 年 2 月）起弃用。
今后请优先使用 [`dart:js_interop`][]，
并尽可能迁移旧互操作库的用法。
[`dart:html`][] 等浏览器 API 的支持，
现在由 [`package:web`][] 提供。


:::warning
None of the legacy interop libraries are supported when compiling to [Wasm][].

编译到 [Wasm][] 时，所有旧版互操作库都不受支持。
:::

[Dart 3.3]: /blog/new-in-dart-3-3-extension-types-javascript-interop-and-more
[`package:web`]: {{site.pub-pkg}}/web
[`dart:html`]: {{site.dart-api}}/dart-html/
[`dart:indexed_db`]: {{site.dart-api}}/dart-indexed_db/
[`dart:js_interop`]: {{site.dart-api}}/dart-js_interop/
[`dart:js_interop_unsafe`]: {{site.dart-api}}/dart-js_interop_unsafe/
[`dart:js_util`]: {{site.dart-api}}/dart-js_util/
[`dart:svg`]: {{site.dart-api}}/dart-svg/
[`dart:web_audio`]: {{site.dart-api}}/dart-web_audio/
[`dart:web_gl`]: {{site.dart-api}}/dart-web_gl/
[Wasm]: /web/wasm

## `dart:js`

## `dart:js` 库

[`dart:js`][] exposed a concrete [`object wrapper`][] to interop with JS objects.
This wrapper contained String-based methods to dynamically get, set, and call
properties on the wrapped JS object. It was less performant due to wrapping
costs and ergonomically more difficult to use. For example, you did not get
code-completion as you couldn't declare interop members and instead relied on
Strings. Many of the functionalities exposed in `dart:js` like
[`allowInterop`][] were later re-exposed through other interop libraries.

[`dart:js`][] 公开了一个具体的 [对象包装][`object wrapper`]，
用来与 JS 对象互操作。
这个包装包含基于 String 的方法，
可以动态获取、设置和调用被包装 JS 对象上的属性。
由于包装开销，它的性能较差，使用起来也不够顺手。
例如，你无法声明互操作成员，只能依赖字符串，
因此没有代码补全。`dart:js` 中公开的许多功能，
例如 [`allowInterop`][]，后来通过其他互操作库重新公开。

This library has been legacy since
`package:js` and `dart:js_util` were released.

自 `package:js` 和 `dart:js_util` 发布起，
该库就已成为旧版。

[`object wrapper`]: {{site.dart-api}}/dart-js/JsObject-class.html
[`allowInterop`]: {{site.dart-api}}/dart-js_util/allowInterop.html

## `package:js`

## `package:js` 库

[`package:js`][] introduced functionality to declare interop types and members.
It allowed users to write interop classes instead of interop extension types.
At runtime, these classes were erased to a type that is similar to
`dart:js_interop`'s [`JSObject`].

[`package:js`][] 引入了声明互操作类型和成员的功能。
它让用户可以编写互操作类，而不是互操作扩展类型。
在运行时，这些类会被擦除为一种类型，
类似于 `dart:js_interop` 的 [`JSObject`]。

```dart
@JS()
class JSType {}
```

Users of `package:js` will find the
syntax and semantics of `dart:js_interop` familiar.
You might be able to migrate to `dart:js_interop` by
replacing the class definition with an extension type and
have it work in many cases.

`package:js` 的用户会觉得
`dart:js_interop` 的语法和语义很熟悉。
在许多情况下，把类定义替换为扩展类型，
就可以迁移到 `dart:js_interop`。

There are significant differences, however:

不过，两者有显著差别：

- `package:js` types could not be used to interop with browser APIs.
  `dart:js_interop` types can.

  `package:js` 类型不能用于与浏览器 API 互操作。
  `dart:js_interop` 类型可以。

- `package:js` allowed dynamic dispatch. This meant that if you cast the
  `package:js` type to `dynamic` and called an interop member on it, it would
  forward to the right member. This is no longer possible with
  `dart:js_interop`.

  `package:js` 支持动态分发。也就是说，如果把
  `package:js` 类型转换为 `dynamic` 并调用其上的互操作成员，
  调用会转发到正确的成员。`dart:js_interop` 不再支持这一点。

- `package:js`' `@JS` has no soundness guarantees as return types of
  `external` members were not checked. `dart:js_interop` is sound.

  `package:js` 的 `@JS` 没有健全性保证，
  因为不会检查 `external` 成员的返回类型。
  `dart:js_interop` 是健全的。

- `package:js` types could not rename instance members or have non-`external`
  members.

  `package:js` 类型不能重命名实例成员，
  也不能拥有非 `external` 成员。

- `package:js` types could subtype and be a supertype of non-interop classes.
  This was often used for mocks. With `dart:js_interop`, mocking is done by
  substituting the JS object instead. See the [tutorial on mocking].

  `package:js` 类型可以作为非互操作类的子类型和超类型。
  这常用于模拟。在 `dart:js_interop` 中，
  模拟改为替换 JS 对象。请参阅 [模拟教程][tutorial on mocking]。

- [`@anonymous`][] types were a way to declare an interop type with an object
  literal constructor. `dart:js_interop` doesn't distinguish types this way and
  any `external` named-argument constructor is an object literal constructor.

  [`@anonymous`][] 类型用来声明带对象字面量构造函数的互操作类型。
  `dart:js_interop` 不再以这种方式区分类型，
  任何带命名参数的 `external` 构造函数都是对象字面量构造函数。

[`JSObject`]: {{site.dart-api}}/dart-js_interop/JSObject-extension-type.html
[`@anonymous`]: {{site.repo.dart.sdk}}/blob/main/sdk/lib/js/_js_annotations.dart#L40
[tutorial on mocking]: /interop/js-interop/mock

### `@staticInterop`

### `@staticInterop` 注解

Along with `@JS` and `@anonymous`, `package:js` later exposed
[`@staticInterop`], which was a prototype of interop extension types. It is as
expressive and restrictive as `dart:js_interop` and was meant to be a
transitory syntax until extension types were available.

除了 `@JS` 和 `@anonymous`，`package:js` 后来还公开了
[`@staticInterop`]，它是互操作扩展类型的原型。
它的表达能力和限制与 `dart:js_interop` 相当，
本意是在扩展类型可用之前作为过渡语法。

`@staticInterop` types were implicitly erased to `JSObject`. It required users
to declare all instance members in extensions so that only static semantics
could be used, and had stronger soundness guarantees. Users could use it to
interact with browser APIs, and it also allowed things like renaming and
non-`external` members. Like interop extension types, it didn't have support for
dynamic dispatch.

`@staticInterop` 类型会被隐式擦除为 `JSObject`。
它要求用户在扩展中声明所有实例成员，
从而只能使用静态语义，并且有更强的健全性保证。
用户可以用它与浏览器 API 交互，
它也支持重命名和非 `external` 成员。
与互操作扩展类型一样，它不支持动态分发。

`@staticInterop` classes can almost always be migrated to an interop extension
type by just changing the class to an extension type and removing the
annotations.

几乎总是可以把 `@staticInterop` 类迁移为互操作扩展类型，
只需把类改成扩展类型并移除注解。

`dart:js_interop` exposed `@staticInterop` (and `@anonymous`, but only if
`@staticInterop` is also used) to support static interop semantics until
extension types were added to the language. All such types should now be
migrated to extension types.

在扩展类型加入语言之前，`dart:js_interop` 公开了
`@staticInterop`（以及 `@anonymous`，但仅当同时使用 `@staticInterop` 时），
以支持静态互操作语义。现在，所有这些类型都应迁移为扩展类型。

[`@staticInterop`]: {{site.repo.dart.sdk}}/blob/main/sdk/lib/js/_js_annotations.dart#L48

## `dart:js_util`

## `dart:js_util` 库

[`dart:js_util`] supplied a number of utility functions that could not be
declared in an `package:js` type or were necessary for values to be passed back
and forth. This included members like:

[`dart:js_util`] 提供了许多实用函数。
这些函数无法在 `package:js` 类型中声明，
或者是值来回传递所必需的。其中包括：

- `allowInterop` (which is now [`Function.toJS`][])

  `allowInterop`（现在是 [`Function.toJS`][]）

- `getProperty`/`setProperty`/`callMethod`/`callConstructor` (which are now in
  [`dart:js_interop_unsafe`])

  `getProperty`/`setProperty`/`callMethod`/`callConstructor`
  （现在位于 [`dart:js_interop_unsafe`]）

- Various JS operators

  各种 JS 运算符

- Type-checking helpers

  类型检查辅助函数

- Mocking support

  模拟支持

- And more.

  以及更多。

`dart:js_interop` and `dart:js_interop_unsafe` contain these helpers now with
possibly alternate syntax.

这些辅助函数现在位于 `dart:js_interop` 和 `dart:js_interop_unsafe` 中，
语法可能有所不同。

[`Function.toJS`]: {{site.dart-api}}/dart-js_interop/FunctionToJSExportedDartFunction/toJS.html

[`dart:js`]: {{site.dart-api}}/dart-js/
[`package:js`]: {{site.pub-pkg}}/js
