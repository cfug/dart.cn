---
# title: Migrate to package:web
title: 迁移到 package:web
# description: How to migrate web interop code from dart:html to package:web.
description: 如何把 Web 互操作代码从 dart:html 迁移到 package:web。
ai-translated: true
prevpage:
  url: /interop/js-interop/past-js-interop
# title: Past JS interop
  title: 早期 JS 互操作
---

Dart's [`package:web`][] exposes access to browser APIs,
enabling interop between Dart applications and the web.
Use `package:web` to interact with the browser and
manipulate objects and elements in the DOM.

Dart 的 [`package:web`][] 公开了对浏览器 API 的访问，
使 Dart 应用可以与 Web 互操作。
使用 `package:web` 与浏览器交互，
并操作 DOM 中的对象和元素。

```dart
import 'package:web/web.dart';

void main() {
  final div = document.querySelector('div')!;
  div.text = 'Text set at ${DateTime.now()}';
}
```

:::important
If you maintain a public Flutter package that uses `dart:html` or any of the
other Dart SDK web libraries,
**you should migrate to `package:web` as soon as possible**.
`package:web` is replacing `dart:html` and other web libraries
as Dart's web interop solution long-term.
Read the **`package:web` vs `dart:html`** section for more information.

如果你维护的公开 Flutter package 使用了 `dart:html`
或其他 Dart SDK Web 库，
**应尽快迁移到 `package:web`**。
从长期来看，`package:web` 正在取代 `dart:html` 和其他 Web 库，
成为 Dart 的 Web 互操作方案。
更多信息请阅读 **`package:web` 与 `dart:html`** 一节。
:::

## `package:web` vs `dart:html`

## `package:web` 与 `dart:html`

The goal of `package:web` is to revamp how Dart exposes web APIs
by addressing several concerns with the existing Dart web libraries:

`package:web` 的目标是改进 Dart 公开 Web API 的方式，
解决现有 Dart Web 库的几个问题：

1. **Wasm compatibility**

   **Wasm 兼容性**

   Packages can only be compatible with [Wasm][]
   if they use [`dart:js_interop`][] and [`dart:js_interop_unsafe`][].
   `package:web` is based on `dart:js_interop`,
   so by default, it's supported on `dart2wasm`.

   只有使用 [`dart:js_interop`][] 和 [`dart:js_interop_unsafe`][] 的
   package 才能与 [Wasm][] 兼容。
   `package:web` 基于 `dart:js_interop`，
   因此默认支持 `dart2wasm`。

   Dart core web libraries, like [`dart:html`][html] and [`dart:svg`][svg],
   are deprecated and **not supported** when compiling to Wasm.

   [`dart:html`][html] 和 [`dart:svg`][svg] 等 Dart 核心 Web 库
   已弃用，编译到 Wasm 时 **不受支持**。

2. **Staying modern**

   **保持现代**

   `package:web` uses the [Web IDL][idl] to automatically generate
   [interop members][] and [interop types][]
   for each declaration in the IDL.
   Generating references directly,
   as opposed to the additional members and abstractions in `dart:html`,
   allows `package:web` to be more concise, easier to understand, more consistent,
   and more able to stay up-to-date with the future of Web developments.

   `package:web` 使用 [Web IDL][idl]，为 IDL 中的每个声明
   自动生成 [互操作成员][interop members] 和 [互操作类型][interop types]。
   与 `dart:html` 中额外的成员和抽象不同，
   直接生成引用让 `package:web` 更简洁、更易理解、更一致，
   也更能跟上 Web 的后续发展。

3. **Versioning**

   **版本管理**

   Because it's a package, `package:web` can be versioned
   more easily than a library like `dart:html` and avoid breaking user code as it
   evolves.
   It also makes the code less exclusive and more open to contributions.
   Developers can create [alternative interop declarations][] of their own
   and use them together with `package:web` without conflict.

   因为它是 package，`package:web` 比 `dart:html` 这样的库
   更容易做版本管理，并在演进时避免破坏用户代码。
   这也让代码不那么封闭，更欢迎贡献。
   开发者可以创建自己的 [替代互操作声明][alternative interop declarations]，
   并与 `package:web` 一起使用而不会冲突。

---

These improvements naturally result in some
implementation differences between `package:web` and `dart:html`.
The changes that affect existing packages the most,
like IDL [renames](#renames) and
[type tests](#type-tests),
are addressed in the migration sections that follow. While we only refer to
`dart:html` for brevity, the same migration patterns apply to any other Dart
core web library like `dart:svg`.

这些改进自然会带来 `package:web` 与 `dart:html` 之间的一些实现差异。
对现有 package 影响最大的变更，
例如 IDL [重命名](#renames) 和 [类型测试](#type-tests)，
会在后面的迁移章节中说明。为简洁起见，这里只提 `dart:html`，
同样的迁移方式也适用于 `dart:svg` 等其他 Dart 核心 Web 库。

## Migrating from `dart:html`

## 从 `dart:html` 迁移

Remove the `dart:html` import and replace it with `package:web/web.dart`:

移除 `dart:html` 导入，并替换为 `package:web/web.dart`：

```dart
import 'dart:html' as html; // Remove
import 'package:web/web.dart' as web; // Add
```

Add `web` to the `dependencies` in your pubspec:

把 `web` 加入 pubspec 的 `dependencies`：

```console
dart pub add web
```

The following sections cover some of the common migration issues
from `dart:html` to `package:web`.

以下各节介绍从 `dart:html` 迁移到 `package:web` 时的一些常见问题。

For any other migration issues, check the [dart-lang/web][] repo and
file an issue.

对于其他迁移问题，请查看 [dart-lang/web][] 仓库并提交 issue。

### Renames

### 重命名

Many of the symbols in `dart:html` were renamed from
their original IDL declaration to align more with Dart style.
For example, `appendChild` became `append`,
`HTMLElement` became `HtmlElement`, etc.

`dart:html` 中的许多符号相对原始 IDL 声明做了重命名，
以便更符合 Dart 风格。
例如，`appendChild` 变成了 `append`，
`HTMLElement` 变成了 `HtmlElement`，等等。

In contrast, to reduce confusion,
`package:web` uses the original names from the IDL definitions.
A `dart fix` is available to convert types that have been renamed
between `dart:html` and `package:web`.

相比之下，为了减少混淆，
`package:web` 使用 IDL 定义中的原始名称。
可以用 `dart fix` 转换在 `dart:html` 和 `package:web` 之间
被重命名的类型。

After changing the import, any renamed objects will be new "undefined" errors.
You can address these either:

更改导入后，任何被重命名的对象都会变成新的「undefined」错误。
可以这样处理：

- From the CLI, by running `dart fix --dry-run`.

  从命令行运行 `dart fix --dry-run`。

- In your IDE, by selecting the `dart fix`: **Rename to '`package:web name`'**.

  在 IDE 中选择 `dart fix`：**Rename to '`package:web name`'**。

{% comment %}
TODO: Update this documentation to refer to symbols instead of just types once
we have a dart fix for that.
{% endcomment -%}

The `dart fix` covers many of the common type renames.
If you come across a `dart:html` type without a `dart fix` to rename it,
first let us know by filing an [issue][].

`dart fix` 覆盖了许多常见的类型重命名。
如果遇到某个 `dart:html` 类型没有对应的 `dart fix`，
请先提交 [issue][] 告诉我们。

Then, you can try manually discovering the `package:web` type name of an
existing `dart:html` member by looking up its definition.
The value of the `@Native` annotation on a `dart:html` member definition
tells the compiler to treat any JS object of that type as the Dart class
that it annotates. For example, the `@Native` annotation tells us that the
native JS name of `dart:html`'s `HtmlElement` member is `HTMLElement`,
so the `package:web` name will also be `HTMLElement`:

然后，可以查看现有 `dart:html` 成员的定义，
手动找出对应的 `package:web` 类型名。
`dart:html` 成员定义上的 `@Native` 注解值
会告诉编译器，把该类型的任何 JS 对象
当作它所注解的 Dart 类。例如，`@Native` 注解表明
`dart:html` 的 `HtmlElement` 成员的原生 JS 名称是 `HTMLElement`，
因此 `package:web` 中的名称也是 `HTMLElement`：

```dart
@Native("HTMLElement")
class HtmlElement extends Element implements NoncedElement { }
```

To find the `dart:html` definition for an undefined member in `package:web`, 
try either of the following methods:

要查找 `package:web` 中未定义成员对应的 `dart:html` 定义，
可以尝试下面任一方法：

- Ctrl or command click the undefined name in the IDE and choose
  **Go to Definition**.

  在 IDE 中按住 Ctrl 或 Command 点击未定义的名称，
  并选择 **Go to Definition**。

- Search for the name in the [`dart:html` API docs][html]
  and check its page under *Annotations*.

  在 [`dart:html` API 文档][html] 中搜索该名称，
  并查看页面上的 **Annotations** 部分。

Similarly, you might find an undefined `package:web` API whose corresponding
`dart:html` member's definition uses the keyword `native`.
Check if the definition uses the `@JSName` annotation for a rename;
the value of the annotation will tell you the name the member uses in
`package:web`:

同样，你可能会发现某个未定义的 `package:web` API，
其对应的 `dart:html` 成员定义使用了关键字 `native`。
请检查该定义是否用 `@JSName` 注解做了重命名；
注解的值会告诉你该成员在 `package:web` 中使用的名称：

```dart
@JSName('appendChild')
Node append(Node node) native;
```

`native` is an internal keyword that means the same as `external` in this
context.

在此上下文中，`native` 是内部关键字，含义与 `external` 相同。

### `Element` and `HTMLElement`

### `Element` 与 `HTMLElement`

`Element` is now `HTMLElement` but the extension type `Element` also exists as
a base type for `HTMLElement`, `SVGElement`, etc.
See [Element MDN documentation][].
`querySelector` returns an Element as it can return other subtypes of `Element`
besides `HTMLElement` like `SVGElement`. A downcast to `HTMLElement` is needed
if you need to access its methods.

`Element` 现在是 `HTMLElement`，但扩展类型 `Element`
仍然作为 `HTMLElement`、`SVGElement` 等的基类型存在。
请参阅 [Element 的 MDN 文档][Element MDN documentation]。
`querySelector` 返回 Element，因为它除了 `HTMLElement`，
还可能返回 `SVGElement` 等其他 `Element` 子类型。
如果需要访问 `HTMLElement` 的方法，就要向下转换为 `HTMLElement`。

```dart
element.querySelector('#selectme')!.className = 'test'; // valid in both

element.querySelector('#selectme')!.style.color = 'red'; // Remove
(element.querySelector('#selectme') as HTMLElement).style.color = 'red'; // Add
```

### List operations

### 列表操作

Unlike `dart:html`, `package:web` methods like `Element.querySelectorAll` and
`Element.children` return values that don't implement `List`. If a `List` is
required, you'll need to wrap it with a class.

与 `dart:html` 不同，`package:web` 中
`Element.querySelectorAll` 和 `Element.children` 等方法
返回的值不实现 `List`。如果需要 `List`，
就要用一个类把它包装起来。

For immutable operations, you can use `JSImmutableListWrapper`:

对于不可变操作，可以使用 `JSImmutableListWrapper`：

```dart
final anchors = document.querySelectorAll('a');
for (final anchor in anchors) {} // Remove
for (final anchor in JSImmutableListWrapper(anchors)) {} //Add

for (final child in parent.children) {} // Remove
for (final child in JSImmutableListWrapper(parent.children)) {} // Add
```

You need to add implementation for simple mutable operations like `removeWhere`:

对于 `removeWhere` 这类简单的可变操作，你需要自己补充实现：

```dart
parent.children.removeWhere(test); // Remove

for (var i = parent.children.length - 1; i >= 0; --i) {
  if (test(parent.children.item(i)!)) {
    parent.children.item(i)!.remove();
  }
}  // Add

```

### Common DOM manipulation examples

### 常见的 DOM 操作示例

Here are some common examples of trivial changes that need to be made when
migrating from `dart:html` to `package:web`:

下面是从 `dart:html` 迁移到 `package:web` 时
一些需要做的细微改动示例：

```dart
element.querySelector('#selector')?.innerHtml = 'something'; // Remove
element.querySelector('#selector')?.innerHTML = 'something'.toJS; // Add

element.parent.classes.add('class'); // Remove
element.parentElement.classList.add('class'); // Add

element.appendHtml(html); // Remove
element.insertAdjacentHTML('beforeend', html.toJS); // Add

var checkbox = CheckboxInputElement(); // Remove
var checkbox = HTMLInputElement()..type='checkbox'; // Add

element.querySelectorAll('a').classes.add('link'); // Remove
for (final a in JSImmutableListWrapper(element.querySelectorAll('a'))) {
  a.classList.add('a');
} // Add
```

{% comment %}
TODO: add more examples
{% endcomment -%}

### Type tests

### 类型测试

It's common for code that uses `dart:html` to utilize runtime checks like `is`.
When used with a `dart:html` object, `is` and `as` verify that the object is
the JS type within the `@Native` annotation.
In contrast, all `package:web` types are reified to [`JSObject`][]. This means a
runtime type test will result in different behavior between `dart:html` and
`package:web` types.

使用 `dart:html` 的代码常常会用 `is` 这类运行时检查。
对 `dart:html` 对象使用 `is` 和 `as` 时，
会验证该对象是否为 `@Native` 注解中的 JS 类型。
相比之下，所有 `package:web` 类型都被具体化为 [`JSObject`][]。
这意味着运行时类型测试在 `dart:html` 和 `package:web` 类型之间
会有不同的行为。

To be able to perform type tests, migrate any `dart:html` code
using `is` type tests to use [interop methods][] like `instanceOfString`
or the more convenient and typed [`isA`][] helper
(available from Dart 3.4 onward).
The [Compatibility, type checks, and casts][]
section of the JS types page covers alternatives in detail.

要做类型测试，请把使用 `is` 类型测试的 `dart:html` 代码
迁移为使用 `instanceOfString` 等 [互操作方法][interop methods]，
或更方便且带类型的 [`isA`][] 辅助函数
（从 Dart 3.4 起可用）。
JS 类型页面的 [兼容性、类型检查和类型转换][Compatibility, type checks, and casts]
一节详细介绍了替代做法。

```dart
obj is Window; // Remove
obj.instanceOfString('Window'); // Add

element is InputElement; // Remove
element.isA<HTMLInputElement>(); // Add
```

### Type signatures

### 类型签名

Many APIs in `dart:html` support various Dart types in their type signatures.
Because `dart:js_interop` [restricts] the types that can be written, some of
the members in `package:web` will now require you to *convert* the value before
calling the member.
Learn how to use interop conversion methods from the [Conversions][]
section of the JS types page.

`dart:html` 中的许多 API 在类型签名中支持多种 Dart 类型。
由于 `dart:js_interop` [限制][restricts] 了可以书写的类型，
`package:web` 中的一些成员现在会要求你在调用之前先 **转换** 该值。
如何使用互操作转换方法，请参阅 JS 类型页面的 [转换][Conversions] 一节。

```dart
window.addEventListener('click', callback); // Remove
window.addEventListener('click', callback.toJS); // Add
```

{% comment %}
TODO: Think of a better example. People will likely use the stream helpers
instead of `addEventListener`.
{% endcomment -%}

Generally, you can spot which methods need a conversion because they'll be
flagged with some variation of the exception:

通常可以看出哪些方法需要转换，
因为它们会被某种形式的异常标出：

```plaintext
A value of type '...' can't be assigned to a variable of type 'JSFunction?'
```

### Conditional imports

### 条件导入

It's common for code to use a conditional import based on whether `dart:html`
is supported to differentiate between native and web:

代码常常根据是否支持 `dart:html` 使用条件导入，
以区分原生平台和 Web：

```dart
export 'src/hw_none.dart'
    if (dart.library.io) 'src/hw_io.dart'
    if (dart.library.html) 'src/hw_html.dart';
```

However, since `dart:html` is deprecated and not supported when
compiling to Wasm, the correct alternative now is to
use `dart.library.js_interop` to differentiate between native and web:

不过，由于 `dart:html` 已弃用，并且编译到 Wasm 时不受支持，
现在正确的替代做法是使用 `dart.library.js_interop`
来区分原生平台和 Web：

<?code-excerpt "create_libraries/lib/hw_mp.dart (export)"?>
```dart
export 'src/hw_none.dart' // Stub implementation
    if (dart.library.io) 'src/hw_io.dart' // dart:io implementation
    if (dart.library.js_interop) 'src/hw_web.dart'; // package:web implementation
```

### Virtual dispatch and mocking

### 虚分发与模拟

`dart:html` classes supported virtual dispatch, but because JS interop uses
extension types, virtual dispatch is [not possible]. Similarly, `dynamic` calls
with `package:web` types won't work as expected (or, they might continue to work
just by chance, but will stop when `dart:html` is removed), as their members are
only available statically. Migrate all code that relies on virtual dispatch to
avoid this issue.

`dart:html` 类支持虚分发，但由于 JS 互操作使用扩展类型，
虚分发 [无法实现][not possible]。同样，对 `package:web` 类型的
`dynamic` 调用也不会按预期工作（或者可能碰巧还能工作，
但在移除 `dart:html` 后就会停止），因为它们的成员只在静态时可用。
请迁移所有依赖虚分发的代码，以避免这个问题。

One use case of virtual dispatch is mocking. If you have a mocking class that
`implements` a `dart:html` class, it can't be used to implement a `package:web`
type. Instead, prefer mocking the JS object itself. See the [mocking tutorial]
for more information.

虚分发的一个用途是模拟。如果有一个模拟类
`implements` 了某个 `dart:html` 类，
它就不能用来实现 `package:web` 类型。
请改为模拟 JS 对象本身。更多信息见 [模拟教程][mocking tutorial]。

### Non-`native` APIs

### 非 `native` API

`dart:html` classes might also contain APIs that have a non-trivial
implementation. These members might or might not exist in the `package:web`
[helpers](#helpers). If your code relies on the specifics of that
implementation, you might be able to copy the necessary code.
However, if you think that's not tractable or if that code would be beneficial
for other users as well, consider filing an issue or uploading a pull request to
[`package:web`][dart-lang/web] to support that member.

`dart:html` 类中也可能包含实现并不简单的 API。
这些成员在 `package:web` 的 [辅助库](#helpers) 中可能存在，也可能不存在。
如果代码依赖该实现的具体细节，你也许可以复制所需代码。
不过，如果这样做不现实，或者这段代码对其他用户也有帮助，
请考虑提交 issue，或向 [`package:web`][dart-lang/web]
发起 pull request 以支持该成员。

### Zones

### Zone

In `dart:html`, callbacks are automatically zoned.
This is not the case in `package:web`. There is no automatic binding of
callbacks in the current zone.

在 `dart:html` 中，回调会自动进入当前 zone。
`package:web` 并非如此。当前 zone 中没有对回调的自动绑定。

If this matters for your application, you can still use zones, but you will have
to [write them yourself][zones] by binding the callback. See [#54507] for more
details.

如果这对你的应用很重要，你仍然可以使用 zone，
但必须通过绑定回调 [自己编写][zones]。详情见 [#54507]。

For example, when passing a callback to a DOM event listener,
manually bind it to the current zone before converting it with `.toJS`:

例如，把回调传给 DOM 事件监听器时，
在用 `.toJS` 转换之前，先把它手动绑定到当前 zone：

<?code-excerpt "misc/lib/interop/zones_example.dart (before)"?>
```dart
// Before: Callback lost zone context
element.addEventListener(
  'click',
  (web.Event event) {
    // ... relies on zone-local values
  }.toJS,
);
```

<?code-excerpt "misc/lib/interop/zones_example.dart (after)"?>
```dart
element.addEventListener(
  'click',
  Zone.current.bindUnaryCallback((web.Event event) {
    // ... zone-local values are preserved
  }).toJS,
);
```

There is no conversion API or [helper](#helpers) available yet to
automatically do this.

目前还没有转换 API 或 [辅助函数](#helpers)
可以自动完成这一步。

## Helpers

## 辅助库

The core of `package:web` contains `external` interop members,
but doesn't provide other functionality that `dart:html` provided by default.
To mitigate these differences, `package:web` contains [`helpers`][helpers]
for additional support in handling a number of use cases
that aren't directly available through the core interop.
The helper library contains various members to expose some legacy features from
the Dart web libraries.

`package:web` 的核心包含 `external` 互操作成员，
但不提供 `dart:html` 默认提供的其他功能。
为了缩小这些差异，`package:web` 包含 [`helpers`][helpers]，
为若干无法直接通过核心互操作处理的场景提供额外支持。
该辅助库包含各种成员，用来公开 Dart Web 库中的一些旧功能。

For example, the core `package:web` only has support for adding and removing
event listeners. Instead, you can use [stream helpers][] that makes it easy to
subscribe to events with Dart `Stream`s without writing that code yourself.

例如，核心 `package:web` 只支持添加和移除事件监听器。
你可以改用 [Stream 辅助函数][stream helpers]，
用 Dart `Stream` 订阅事件，而不必自己编写那段代码。

```dart
// Original dart:html version:
final htmlInput = InputElement();
await htmlInput.onBlur.first;

// Migrated package:web version:
final webInput = HTMLInputElement();
await webInput.onBlur.first;
```

You can find all the helpers and their documentation in the repo at
[`package:web/helpers`][helpers]. They will continuously be updated to aid users
in migration and make it easier to use the web APIs.

所有辅助函数及其文档都在仓库的
[`package:web/helpers`][helpers] 中。
它们会持续更新，以帮助用户迁移，并让 Web API 更好用。

## Examples

## 示例

Here are some examples of packages that have been migrated from `dart:html`
to `package:web`:

下面是一些已从 `dart:html` 迁移到 `package:web` 的 package 示例：

- [Upgrading `url_launcher` to `package:web`][]

  [把 `url_launcher` 升级到 `package:web`][Upgrading `url_launcher` to `package:web`]

{% comment %}
Do we have any other package migrations to show off here?
{% endcomment -%}

[`package:web`]: {{site.pub-pkg}}/web
[Wasm]: /web/wasm
[html]: {{site.dart-api}}/dart-html/dart-html-library.html
[svg]: {{site.dart-api}}/dart-svg/dart-svg-library.html
[`dart:js_interop`]: {{site.dart-api}}/dart-js_interop/dart-js_interop-library.html
[`dart:js_interop_unsafe`]: {{site.dart-api}}/dart-js_interop_unsafe/dart-js_interop_unsafe-library.html
[idl]: https://www.npmjs.com/package/@webref/idl
[interop members]: /interop/js-interop/usage#interop-members
[interop types]: /interop/js-interop/usage#interop-types
[dart-lang/web]: {{site.repo.dart.org}}/web
[issue]: {{site.repo.dart.org}}/web/issues/new
[helpers]: {{site.repo.dart.org}}/web/tree/main/web/lib/src/helpers
[zones]: /libraries/async/zones
[Conversions]: /interop/js-interop/js-types#conversions
[interop methods]: {{site.dart-api}}/dart-js_interop/JSAnyUtilityExtension.html#instance-methods
[alternative interop declarations]: /interop/js-interop/usage
[Compatibility, type checks, and casts]: /interop/js-interop/js-types#compatibility-type-checks-and-casts
[Upgrading `url_launcher` to `package:web`]: https://github.com/flutter/packages/pull/5451/files
[stream helpers]: {{site.repo.dart.org}}/web/blob/main/web/lib/src/helpers/events/streams.dart
[not possible]: /language/extension-types
[`JSObject`]: {{site.dart-api}}/dart-js_interop/JSObject-extension-type.html
[`isA`]: {{site.dart-api}}/dart-js_interop/JSAnyUtilityExtension/isA.html
[restricts]: /interop/js-interop/js-types#requirements-on-external-declarations-and-function-tojs
[#54507]: {{site.repo.dart.sdk}}/issues/54507
[mocking tutorial]: /interop/js-interop/mock
[Element MDN documentation]: https://developer.mozilla.org/en-US/docs/Web/API/Element
