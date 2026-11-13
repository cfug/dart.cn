---
# title: JS interop usage
title: JS 互操作用法
# breadcrumb: Usage
breadcrumb: 用法
# description: How to declare and use JS interop members.
description: 如何声明和使用 JS 互操作成员。
ai-translated: true
prevpage:
  url: /interop/js-interop/
# title: JS interop
  title: JS 互操作
nextpage:
  url: /interop/js-interop/js-types
# title: JS types
  title: JS 类型
---

JS interop provides the mechanisms to interact with JavaScript APIs from Dart.
It allows you to invoke these APIs and interact with the values that
you get from them using an explicit, idiomatic syntax.

JS 互操作提供了从 Dart 与 JavaScript API 交互的机制。
你可以借此用明确、符合语言习惯的语法调用这些 API，
并与从中得到的值交互。

Typically, you access a JavaScript API by making it available
somewhere within the [global JS scope][].
To call and receive JS values from this API,
you use [`external` interop members](#interop-members).
To construct and provide types for JS values, you use and declare
[interop types](#interop-types), which also contain interop members.
To pass Dart values like a `List` or `Function` to interop members or
convert from JS values to Dart values, you use [conversion functions][] unless
the interop member [contains a primitive type][].

通常，你把 JavaScript API 放在 [JS 全局作用域][global JS scope]
的某处，从而访问它。
要从该 API 调用并接收 JS 值，
请使用 [`external` 互操作成员](#interop-members)。
要构造 JS 值并为其提供类型，请使用并声明
[互操作类型](#interop-types)，其中也包含互操作成员。
要把 `List` 或 `Function` 这类 Dart 值传给互操作成员，
或把 JS 值转换为 Dart 值，请使用 [转换函数][conversion functions]，
除非该互操作成员 [包含基本类型][contains a primitive type]。

[global JS scope]: https://developer.mozilla.org/docs/Glossary/Global_scope
[conversion functions]: /interop/js-interop/js-types#conversions
[contains a primitive type]: /interop/js-interop/js-types#requirements-on-external-declarations-and-function-tojs

## Interop types

## 互操作类型

When interacting with a JS value, you need to provide a Dart type for it.
You can do this by either using or declaring an interop type.
Interop types are either a ["JS type"][] provided by Dart or
an [extension type][] wrapping an interop type.

与 JS 值交互时，你需要为它提供一个 Dart 类型。
可以通过使用或声明互操作类型来做到这一点。
互操作类型要么是 Dart 提供的 [「JS 类型」]["JS type"]，
要么是包装互操作类型的 [扩展类型][extension type]。

Interop types allow you to provide an interface for a JS value and
let you declare interop APIs for its members.
They're also used in the signature of other interop APIs.

互操作类型让你可以为 JS 值提供接口，
并为其成员声明互操作 API。
它们也会用在其他互操作 API 的签名中。

```dart
extension type Window(JSObject _) implements JSObject {}
```

`Window` is an interop type for an arbitrary `JSObject`.
There's no [runtime guarantee][] that `Window` is actually a JS [`Window`][].
There also is no conflict with any other interop interface that
is defined for the same value.
If you want to check that `Window` is actually a JS `Window`,
you can [check the type of the JS value through interop][].

`Window` 是任意 `JSObject` 的互操作类型。
并没有 [运行时保证][runtime guarantee] 表明 `Window` 确实是 JS 的 [`Window`][]。
它也不会与为同一值定义的其他互操作接口冲突。
如果要检查 `Window` 是否确实是 JS 的 `Window`，
可以 [通过互操作检查该 JS 值的类型][check the type of the JS value through interop]。

You can also declare your own interop type for the JS types that
Dart provides by wrapping them:

你也可以包装 Dart 提供的 JS 类型，
从而声明自己的互操作类型：

```dart
extension type Array._(JSArray<JSAny?> _) implements JSArray<JSAny?> {
  external Array();
}
```

In most cases, you'll likely declare an interop type using
`JSObject` as the [representation type][], because you're likely
interacting with JS objects which don't have an interop type provided by Dart.

大多数情况下，你会用 `JSObject` 作为 [表示类型][representation type]
来声明互操作类型，因为你交互的 JS 对象
往往没有 Dart 提供的互操作类型。

Interop types should also generally [implement][] their representation type so
that they can be used where the representation type is expected,
like in many APIs provided by [`package:web`][].

互操作类型通常还应 [实现][implement] 其表示类型，
这样在需要表示类型的地方就可以使用它们，
例如 [`package:web`][] 提供的许多 API。

["JS type"]: /interop/js-interop/js-types
[extension type]: /language/extension-types
[`Window`]: https://developer.mozilla.org/docs/Web/API/Window
[runtime guarantee]: /language/extension-types#type-considerations
[check the type of the JS value through interop]: /interop/js-interop/js-types#compatibility-type-checks-and-casts
[representation type]: /language/extension-types#declaration
[implement]: /language/extension-types#implements
[`package:web`]: {{site.pub-pkg}}/web

## Interop members

## 互操作成员

[`external`][] interop members provide an idiomatic syntax for JS members.
They allow you to write a Dart type signature for its
arguments and return value.
The types that can be written in the signature of
these members have [restrictions][].
The JS API the interop member corresponds to is determined by a combination of
where it's declared, its name, what kind of Dart member it is, and any
[renames](#js).

[`external`][] 互操作成员为 JS 成员提供了符合语言习惯的语法。
你可以借此为参数和返回值编写 Dart 类型签名。
这些成员签名中可以书写的类型有 [限制][restrictions]。
互操作成员对应的 JS API，由它的声明位置、名称、
Dart 成员种类以及任何 [重命名](#js) 共同决定。

[`external`]: /language/functions#external
[restrictions]: /interop/js-interop/js-types#requirements-on-external-declarations-and-function-tojs

### Top-level interop members

### 顶层互操作成员

Given the following JS members:

给定下面这些 JS 成员：

```js
globalThis.name = 'global';
globalThis.isNameEmpty = function() {
  return globalThis.name.length == 0;
}
```

You can write interop members for them like so:

你可以这样为它们编写互操作成员：

```dart
@JS()
external String get name;

@JS()
external set name(String value);

@JS()
external bool isNameEmpty();
```

Here, there exists a property `name` and a function `isNameEmpty` that
are exposed in the global scope. 
To access them, you use top-level interop members.
To get and set `name`, declare and use
an interop getter and setter with the same name.
To use `isNameEmpty`, declare and call an interop function with the same name.
You can declare top-level interop getters, setters, methods, and fields.
Interop fields are equivalent to getter and setter pairs.

这里，全局作用域中公开了属性 `name` 和函数 `isNameEmpty`。
要访问它们，请使用顶层互操作成员。
要获取和设置 `name`，请声明并使用同名的互操作 getter 和 setter。
要使用 `isNameEmpty`，请声明并调用同名的互操作函数。
你可以声明顶层互操作 getter、setter、方法和字段。
互操作字段等同于一对 getter 和 setter。

Top-level interop members must be declared with a [`@JS()`](#js) annotation to
distinguish them from other `external` top-level members,
like those that can be written using `dart:ffi`.

顶层互操作成员必须用 [`@JS()`](#js) 注解声明，
以便与其他 `external` 顶层成员区分开，
例如可以用 `dart:ffi` 编写的那些成员。

### Interop type members

### 互操作类型成员

Given a JS interface like the following:

给定如下 JS 接口：

```js
class Time {
  constructor(hours, minutes) {
    this._hours = Math.abs(hours) % 24;
    this._minutes = arguments.length == 1 ? 0 : Math.abs(minutes) % 60;
  }

  static dinnerTime = new Time(18, 0);

  static getTimeDifference(t1, t2) {
    return new Time(t1.hours - t2.hours, t1.minutes - t2.minutes);
  }

  get hours() {
    return this._hours;
  }

  set hours(value) {
    this._hours = Math.abs(value) % 24;
  }

  get minutes() {
    return this._minutes;
  }

  set minutes(value) {
    this._minutes = Math.abs(value) % 60;
  }

  isDinnerTime() {
    return this.hours == Time.dinnerTime.hours && this.minutes == Time.dinnerTime.minutes;
  }
}
// Need to expose the type to the global scope.
globalThis.Time = Time;
```

You can write an interop interface for it like so:

你可以这样为它编写互操作接口：

```dart
extension type Time._(JSObject _) implements JSObject {
  external Time(int hours, int minutes);
  external factory Time.onlyHours(int hours);

  external static Time dinnerTime;
  external static Time getTimeDifference(Time t1, Time t2);

  external int hours;
  external int minutes;
  external bool isDinnerTime();

  bool isMidnight() => hours == 0 && minutes == 0;
}
```

Within an interop type, you can declare several different types of
`external` interop members:

在互操作类型中，你可以声明几种不同的
`external` 互操作成员：

- **Constructors**. When called, constructors with only positional parameters
  create a new JS object whose constructor is defined by the name of the
  extension type using `new`.
  For example, calling `Time(0, 0)` in Dart generates a JS invocation that
  looks like `new Time(0, 0)`. Similarly, calling
  `Time.onlyHours(0)` generates a JS invocation that looks like `new Time(0)`.
  Note that the JS invocations of the two constructors follow the
  same semantics, regardless of whether they're
  given a Dart name or if they're a factory.

  **构造函数**。调用时，只有位置参数的构造函数
  会用 `new` 创建一个新的 JS 对象，
  其构造函数由扩展类型的名称定义。
  例如，在 Dart 中调用 `Time(0, 0)` 会生成类似
  `new Time(0, 0)` 的 JS 调用。同样，调用
  `Time.onlyHours(0)` 会生成类似 `new Time(0)` 的 JS 调用。
  请注意，这两个构造函数的 JS 调用遵循相同的语义，
  无论它们是否有 Dart 名称，也无论它们是否为工厂构造函数。

  - **Object literal constructors**. It's sometimes useful to
    create a JS [object literal][] that simply contains a
    number of properties and their values.
    In order to do this, declare a constructor with only named
    parameters, where the names of the parameters match the property names:

    **对象字面量构造函数**。有时需要创建一个 JS [对象字面量][object literal]，
    其中只包含若干属性及其值。
    为此，请声明一个只有命名参数的构造函数，
    参数名与属性名一致：

    ```dart
    extension type Options._(JSObject o) implements JSObject {
      external Options({int a, int b});
      external int get a;
      external int get b;
    }
    ```

    A call to `Options(a: 0, b: 1)` results in
    creating the JS object `{a: 0, b: 1}`.
    The object is defined by the invocation arguments, so
    calling `Options(a: 0)` results in `{a: 0}`.
    You can get or set the properties of the object through
    `external` instance members.

    调用 `Options(a: 0, b: 1)` 会创建 JS 对象 `{a: 0, b: 1}`。
    对象由调用参数定义，因此调用 `Options(a: 0)` 会得到 `{a: 0}`。
    你可以通过 `external` 实例成员获取或设置该对象的属性。

    :::warning
    Before Dart 3.3.1, object literal constructors required a
    [`@JS`](#js) annotation on the library to compile.
    To learn more, check out [`dart-lang/sdk#54801`][54801].

    在 Dart 3.3.1 之前，对象字面量构造函数需要在库上添加
    [`@JS`](#js) 注解才能编译。
    更多信息请查阅 [`dart-lang/sdk#54801`][54801]。
    :::

- **`static` members**. Like constructors, static members use
  the name of the extension type to generate the JS code. For example,
  calling `Time.getTimeDifference(t1, t2)` generates a JS invocation that
  looks like `Time.getTimeDifference(t1, t2)`.
  Similarly, calling `Time.dinnerTime` results in a JS invocation that
  looks like `Time.dinnerTime`. Like top-levels,
  you can declare `static` methods, getters, setters, and fields.

  **`static` 成员**。与构造函数一样，静态成员使用扩展类型的名称
  来生成 JS 代码。例如，调用 `Time.getTimeDifference(t1, t2)`
  会生成类似 `Time.getTimeDifference(t1, t2)` 的 JS 调用。
  同样，调用 `Time.dinnerTime` 会生成类似 `Time.dinnerTime` 的 JS 调用。
  与顶层成员一样，你可以声明 `static` 方法、getter、setter 和字段。

- **Instance members**. Like with other Dart types, instance members require
  an instance to be used. These members get, set, or invoke properties on
  the instance. For example:

  **实例成员**。与其他 Dart 类型一样，实例成员需要在实例上使用。
  这些成员会获取、设置或调用实例上的属性。例如：

  ```dart
    final time = Time(0, 0);
    print(time.isDinnerTime()); // false
    final dinnerTime = Time.dinnerTime;
    time.hours = dinnerTime.hours;
    time.minutes = dinnerTime.minutes;
    print(time.isDinnerTime()); // true
  ```

  The call to `dinnerTime.hours` gets the value of
  the `hours` property of `dinnerTime`.
  Similarly, the call to `time.minutes=` sets the value of
  the `minutes` property of time.
  The call to `time.isDinnerTime()` calls the function in
  the `isDinnerTime` property of `time` and returns the value.
  Like top-levels and `static` members, you can declare
  instance methods, getters, setters, and fields.

  调用 `dinnerTime.hours` 会获取 `dinnerTime` 的 `hours` 属性值。
  同样，调用 `time.minutes=` 会设置 time 的 `minutes` 属性值。
  调用 `time.isDinnerTime()` 会调用 `time` 的 `isDinnerTime` 属性中的函数，
  并返回该值。
  与顶层成员和 `static` 成员一样，你可以声明
  实例方法、getter、setter 和字段。

- **Operators**. There are only two `external` interop operators
  allowed in interop types: `[]` and `[]=`.
  These are instance members that
  match the semantics of JS' [property accessors][].
  For example, you can declare them like:

  **运算符**。互操作类型中只允许两个 `external` 互操作运算符：
  `[]` 和 `[]=`。
  它们是实例成员，语义与 JS 的 [属性访问器][property accessors] 一致。
  例如，可以这样声明：

  ```dart
  extension type Array(JSArray<JSNumber> _) implements JSArray<JSNumber> {
    external JSNumber operator [](int index);
    external void operator []=(int index, JSNumber value);
  }
  ```

  Calling `array[i]` gets the value in the `i`th slot of `array`, and
  `array[i] = i.toJS` sets the value in that slot to `i.toJS`.
  Other JS operators are exposed by [utility functions][] in `dart:js_interop`.

  调用 `array[i]` 会获取 `array` 第 `i` 个位置的值，
  `array[i] = i.toJS` 会把该位置的值设为 `i.toJS`。
  其他 JS 运算符由 `dart:js_interop` 中的 [实用函数][utility functions] 公开。

Lastly, like any other extension type, you're allowed to declare any
[non-`external` members][] in the interop type.
A boolean getter `isMidnight` that uses the interop values is one such example.

最后，与任何其他扩展类型一样，你可以在互操作类型中声明任何
[非 `external` 成员][non-`external` members]。
使用互操作值的布尔 getter `isMidnight` 就是这样一个例子。

[object literal]: https://developer.mozilla.org/docs/Web/JavaScript/Reference/Operators/Object_initializer
[54801]: {{site.repo.dart.sdk}}/issues/54801
[property accessors]: https://developer.mozilla.org/docs/Web/JavaScript/Reference/Operators/Property_accessors#bracket_notation
[utility functions]: {{site.dart-api}}/dart-js_interop/JSAnyOperatorExtension.html
[non-`external` members]: /language/extension-types#members

### Extension members on interop types

### 互操作类型上的扩展成员

You can also write `external` members in [extensions][] of interop types.
For example:

你也可以在互操作类型的 [扩展][extensions] 中编写 `external` 成员。
例如：

```dart
extension on Array {
  external int push(JSAny? any);
}
```

The semantics of calling `push` are identical to what it would have been if
it was in the definition of `Array` instead.
Extensions can have `external` instance members and operators, but
can't have `external` `static` members or constructors.
Like with interop types, you can
write any non-`external` members in the extension.
These extensions are useful for when an interop type doesn't
expose the `external` member you need, and you don't want to
create a new interop type.

调用 `push` 的语义，与它写在 `Array` 定义中时相同。
扩展可以有 `external` 实例成员和运算符，
但不能有 `external` 的 `static` 成员或构造函数。
与互操作类型一样，你可以在扩展中编写任何非 `external` 成员。
当互操作类型没有公开你需要的 `external` 成员，
而你又不想新建互操作类型时，这些扩展很有用。

[extensions]: /language/extension-methods

### Parameters

### 参数

`external` interop methods can only contain positional and optional arguments.
This is because JS members only take positional arguments.
The one exception is object literal constructors,
where they can contain only named arguments.

`external` 互操作方法只能包含位置参数和可选参数。
这是因为 JS 成员只接受位置参数。
唯一的例外是对象字面量构造函数，
它们只能包含命名参数。

Unlike with non-`external` methods, optional arguments don't get
replaced with their default value, but are instead omitted.
For example:

与非 `external` 方法不同，可选参数不会被替换为默认值，
而是被省略。例如：

```dart
external int push(JSAny? any, [JSAny? any2]);
```

Calling `array.push(0.toJS)` in Dart results in
a JS invocation of `array.push(0.toJS)` and *not* `array.push(0.toJS, null)`.
This allows users to not have to write multiple interop members for
the same JS API to avoid passing in `null`s.
If you declare a parameter with an explicit default value, you
get a warning that the value will be ignored.

在 Dart 中调用 `array.push(0.toJS)` 会生成
`array.push(0.toJS)` 这一 JS 调用，**不会** 生成 `array.push(0.toJS, null)`。
这样，用户就不必为同一个 JS API 编写多个互操作成员，
只为了避免传入 `null`。
如果为参数声明了显式默认值，
你会收到警告，说明该值将被忽略。

## `@JS()`

## `@JS()` 注解

It's sometimes useful to refer to a JS property with
a different name than the one written.
For example, if you want to write two `external` APIs that
point to the same JS property, you'd need to
write a different name for at least one of them.
Similarly, if you want to define multiple interop types that
refer to the same JS interface, you need to rename at least one of them.
Another example is if the JS name can't be written in Dart, such as `$a`.

有时需要用与所写名称不同的名字来引用 JS 属性。
例如，如果要编写两个指向同一 JS 属性的 `external` API，
至少其中一个需要使用不同的名称。
同样，如果要定义多个指向同一 JS 接口的互操作类型，
至少需要重命名其中一个。
另一个例子是 JS 名称无法用 Dart 书写，例如 `$a`。

To do this, you can use the [`@JS()`][] annotation with
a constant string value.
For example:

为此，可以使用带常量字符串值的 [`@JS()`][] 注解。
例如：

```dart
extension type Array._(JSArray<JSAny?> _) implements JSArray<JSAny?> {
  external int push(JSNumber number);
  @JS('push')
  external int pushString(JSString string);
}
```

Calling either `push` or `pushString` results in JS code that uses `push`.

调用 `push` 或 `pushString` 都会生成使用 `push` 的 JS 代码。

You can also rename interop types:

你也可以重命名互操作类型：

```dart
@JS('Date')
extension type JSDate._(JSObject _) implements JSObject {
  external JSDate();

  external static int now();
}
```

Calling `JSDate()` results in a JS invocation of `new Date()`.
Similarly, calling `JSDate.now()` results in a JS invocation of `Date.now()`.

调用 `JSDate()` 会生成 `new Date()` 这一 JS 调用。
同样，调用 `JSDate.now()` 会生成 `Date.now()` 这一 JS 调用。

Furthermore, you can namespace an entire library,
adding a prefix to all interop top-level members, interop types,
and `static` interop members within those types.
This is useful if you want to avoid adding
too many members to the global JS scope.

此外，你可以为整个库指定命名空间，
给所有互操作顶层成员、互操作类型
以及这些类型中的 `static` 互操作成员加上前缀。
如果你想避免往 JS 全局作用域中加入过多成员，这会很有用。

```dart
@JS('library1')
library;

import 'dart:js_interop';

@JS()
external void method();

extension type JSType._(JSObject _) implements JSObject {
  external JSType();

  external static int get staticMember;
}
```

Calling `method()` results in a JS invocation of `library1.method()`,
calling `JSType()` results in a JS invocation of `new library1.JSType()`,
and calling `JSType.staticMember` results in
a JS invocation of `library1.JSType.staticMember`.

调用 `method()` 会生成 `library1.method()` 这一 JS 调用，
调用 `JSType()` 会生成 `new library1.JSType()` 这一 JS 调用，
调用 `JSType.staticMember` 会生成
`library1.JSType.staticMember` 这一 JS 调用。

Unlike interop members and interop types, Dart only ever adds a library name in
the JS invocation if you provide a non-empty value in
the `@JS()` annotation on the library.
It doesn't use the Dart name of the library as the default.

与互操作成员和互操作类型不同，
只有当你在库的 `@JS()` 注解中提供非空值时，
Dart 才会在 JS 调用中加入库名。
它不会默认使用该库的 Dart 名称。

```dart
library interop_library;

import 'dart:js_interop';

@JS()
external void method();
```

Calling `method()` results in a JS invocation of `method()` and not
`interop_library.method()`.

调用 `method()` 会生成 `method()` 这一 JS 调用，
而不是 `interop_library.method()`。

You can also write multiple namespaces delimited by a `.` for
libraries, top-level members, and interop types:

你也可以为库、顶层成员和互操作类型
书写用 `.` 分隔的多个命名空间：

```dart
@JS('library1.library2')
library;

import 'dart:js_interop';

@JS('library3.method')
external void method();

@JS('library3.JSType')
extension type JSType._(JSObject _) implements JSObject {
  external JSType();
}
```

Calling `method()` results in
a JS invocation of `library1.library2.library3.method()`,
calling `JSType()` results in
a JS invocation of `new library1.library2.library3.JSType()`, and so forth.

调用 `method()` 会生成
`library1.library2.library3.method()` 这一 JS 调用，
调用 `JSType()` 会生成
`new library1.library2.library3.JSType()` 这一 JS 调用，依此类推。

However, you can't use `@JS()` annotations with `.` in
the value on interop type members or extension members of interop types.

不过，不能在互操作类型的成员或互操作类型的扩展成员上，
使用值中带 `.` 的 `@JS()` 注解。

If there's no value provided to `@JS()` or the value is empty,
no renaming occurs.

如果没有为 `@JS()` 提供值，或者值为空，
就不会发生重命名。

`@JS()` also tells the compiler that a member or type is
intended to be treated as a JS interop member or type.
It is required (with or without a value) for all top-level members to
distinguish them from other `external` top-level members, but
can often be elided on and within interop types and on extension members as
the compiler can tell it is a JS interop type from
the representation type and on-type.

`@JS()` 还会告诉编译器，某个成员或类型
应当被当作 JS 互操作成员或类型。
所有顶层成员都必须使用它（无论是否带值），
以便与其他 `external` 顶层成员区分开；
但在互操作类型上、类型内部以及扩展成员上通常可以省略，
因为编译器可以根据表示类型和所在类型判断它是 JS 互操作类型。

[`@JS()`]: {{site.dart-api}}/dart-js_interop/JS-class.html

<a id="exporting-dart-functions-and-objects-to-js" aria-hidden="true"></a>
## Export Dart functions and objects to JS {:#export}

## 把 Dart 函数和对象导出到 JS

The preceding sections show how to call JS members from Dart.
It's also useful to *export* Dart code so that it can be used in JS.
To export a Dart function to JS, first convert it using [`Function.toJS`][],
which wraps the Dart function with a JS function.
Then, pass the wrapped function to JS through an interop member.
At that point, it's ready to be called by other JS code.

前面几节说明了如何从 Dart 调用 JS 成员。
把 Dart 代码 **导出** 以便在 JS 中使用，同样有用。
要把 Dart 函数导出到 JS，首先用 [`Function.toJS`][] 转换它，
这会用 JS 函数包装该 Dart 函数。
然后通过互操作成员把包装后的函数传给 JS。
此时，其他 JS 代码就可以调用它。

For example, this code converts a Dart function and uses interop to
set it in a global property, which is then called in JS:

例如，下面的代码转换一个 Dart 函数，
并通过互操作把它设为全局属性，然后在 JS 中调用：

```dart
import 'dart:js_interop';

@JS()
external set exportedFunction(JSFunction value);

void printString(JSString string) {
  print(string.toDart);
}

void main() {
  exportedFunction = printString.toJS;
}
```

```js
globalThis.exportedFunction('hello world');
```

Functions that are exported this way have type [restrictions][] similar to
those of interop members.

以这种方式导出的函数，其类型 [限制][restrictions]
与互操作成员类似。

Sometimes it's useful to export an entire Dart interface so that
JS can interact with a Dart object.
To do this, mark the Dart class as exportable using [`@JSExport`][] and
wrap instances of that class using [`createJSInteropWrapper`][].
For a more detailed explanation of this technique, including how to
mock JS values, check out [How to mock JavaScript interop objects][].

有时需要导出整个 Dart 接口，以便 JS 与 Dart 对象交互。
为此，用 [`@JSExport`][] 把 Dart 类标记为可导出，
并用 [`createJSInteropWrapper`][] 包装该类的实例。
关于这一技巧的更详细说明，包括如何模拟 JS 值，
请查阅 [如何模拟 JavaScript 互操作对象][How to mock JavaScript interop objects]。

[`Function.toJS`]: {{site.dart-api}}/dart-js_interop/FunctionToJSExportedDartFunction/toJS.html
[restrictions]: /interop/js-interop/js-types#requirements-on-external-declarations-and-function-tojs
[`@JSExport`]: {{site.dart-api}}/dart-js_interop/JSExport-class.html
[`createJSInteropWrapper`]: {{site.dart-api}}/dart-js_interop/createJSInteropWrapper.html
[How to mock JavaScript interop objects]: /interop/js-interop/mock

## `dart:js_interop` and `dart:js_interop_unsafe`

## `dart:js_interop` 与 `dart:js_interop_unsafe`

[`dart:js_interop`][] contains all the necessary members you should need,
including `@JS`, JS types, conversion functions, and various utility functions.
Utility functions include:

[`dart:js_interop`][] 包含你应该需要的全部成员，
包括 `@JS`、JS 类型、转换函数以及各种实用函数。
实用函数包括：

- [`globalContext`][], which represents the global scope that
  the compilers use to find interop members and types.

  [`globalContext`][]，表示编译器用来查找
  互操作成员和类型的全局作用域。

- [Helpers to inspect the type of JS values][]

  [检查 JS 值类型的辅助函数][Helpers to inspect the type of JS values]

- JS operators

  JS 运算符

- [`dartify`][] and [`jsify`][], which check the type of certain JS values and
  convert them to Dart values and vice versa.
  Prefer using the specific conversion when you know the type of the JS value,
  as the extra type-checking might be expensive.

  [`dartify`][] 和 [`jsify`][]，它们会检查某些 JS 值的类型，
  并在 Dart 值与 JS 值之间转换。
  如果你知道 JS 值的类型，请优先使用具体的转换，
  因为额外的类型检查可能开销较大。

- [`importModule`][], which allows you to
  import modules dynamically as a `JSObject`.

  [`importModule`][]，让你可以
  把模块动态导入为 `JSObject`。

- [`isA`][], which allows you to check if a JS-interop value is
  an instance of the JS type specified by the type argument.

  [`isA`][]，让你可以检查某个 JS 互操作值
  是否为类型参数所指定的 JS 类型的实例。

More utilities might be added to this library in the future.

将来可能会向该库加入更多实用函数。

[`dart:js_interop_unsafe`][] contains members that allow
you to look up properties dynamically. For example:

[`dart:js_interop_unsafe`][] 包含可以动态查找属性的成员。例如：

```dart
JSFunction f = console['log'];
```

Instead of declaring an interop member named `log`,
a string can be used to access the property.
`dart:js_interop_unsafe` also provides functions to
dynamically check for, get, set, and call properties.

不必声明名为 `log` 的互操作成员，
可以用字符串访问该属性。
`dart:js_interop_unsafe` 还提供函数，
用于动态检查、获取、设置和调用属性。

:::tip
Avoid using `dart:js_interop_unsafe` if possible.
It makes security compliance more difficult to guarantee and
might lead to violations, which is why it can be "unsafe".

请尽可能避免使用 `dart:js_interop_unsafe`。
它更难保证安全合规，并且可能导致违规，
这也是它被称为「unsafe」的原因。
:::

[`dart:js_interop`]: {{site.dart-api}}/dart-js_interop/dart-js_interop-library.html
[`globalContext`]: {{site.dart-api}}/dart-js_interop/globalContext.html
[Helpers to inspect the type of JS values]: {{site.dart-api}}/dart-js_interop/JSAnyUtilityExtension.html
[`dartify`]: {{site.dart-api}}/dart-js_interop/JSAnyUtilityExtension/dartify.html
[`jsify`]: {{site.dart-api}}/dart-js_interop/NullableObjectUtilExtension/jsify.html
[`importModule`]: {{site.dart-api}}/dart-js_interop/importModule.html
[`isA`]: {{site.dart-api}}/dart-js_interop/JSAnyUtilityExtension/isA.html
[`dart:js_interop_unsafe`]: {{site.dart-api}}/dart-js_interop_unsafe/dart-js_interop_unsafe-library.html
