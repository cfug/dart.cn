---
# title: How to mock JavaScript interop objects
title: 如何模拟 JavaScript 互操作对象
# shortTitle: Mock JS interop objects
shortTitle: 模拟 JS 互操作对象
# description: Learn how to mock JS interop objects in Dart for testing.
description: 了解如何在 Dart 中模拟 JS 互操作对象以便测试。
ai-translated: true
---

In this tutorial, you'll learn how to mock JS objects so that you can test
interop instance members without having to use a real implementation.

在本教程中，你将学习如何模拟 JS 对象，
从而在不使用真实实现的情况下测试互操作实例成员。

## Background and motivation

## 背景和动机

Mocking classes in Dart is usually done through overriding instance members.
However, since [extension types] are used to declare interop types, all
extension type members are dispatched statically and therefore overriding can't
be used. This [limitation is true for extension members] as well, and therefore
instance extension type or extension members can't be mocked.

在 Dart 中，模拟类通常通过重写实例成员完成。
不过，由于互操作类型使用 [扩展类型][extension types] 声明，
所有扩展类型成员都是静态分发的，因此不能重写。
[这一限制同样适用于扩展成员][limitation is true for extension members]，
所以扩展类型或扩展的实例成员无法被模拟。

While this applies to any non-`external` extension type member, `external`
interop members are special as they invoke members on a JS value.

这一点适用于任何非 `external` 的扩展类型成员，
但 `external` 互操作成员比较特殊，
因为它们会调用 JS 值上的成员。

```dart
extension type Date(JSObject _) implements JSObject {
  external int getDay();
}
```

As discussed in the [Usage] section, calling `getDay()` will result in calling
`getDay()` on the JS object. Therefore, by using a different `JSObject`, a
different *implementation* of `getDay` can be called.

如 [用法][Usage] 一节所述，调用 `getDay()` 会在 JS 对象上
调用 `getDay()`。因此，使用不同的 `JSObject`，
就可以调用 `getDay` 的不同 **实现**。

In order to do this, there should be some mechanism of creating a JS object that
has a property `getDay` which when called, calls a Dart function. A simple way
is to create a JS object and set the property `getDay` to a converted callback
e.g.

为此，需要某种机制来创建这样的 JS 对象：
它有一个 `getDay` 属性，调用时会调用 Dart 函数。
一种简单做法是创建 JS 对象，
并把 `getDay` 属性设为转换后的回调，例如：

```dart
final date = Date(JSObject());
date['getDay'] = (() => 0).toJS;
```

While this works, this is prone to error and doesn't scale well when you are
using many interop members. It also doesn't handle getters or setters properly.
Instead, you should use a combination of [`createJSInteropWrapper`] and
[`@JSExport`] to declare a type that provides an implementation for all the
`external` instance members.

这样做虽然可行，但容易出错，
而且在互操作成员很多时难以扩展。
它也不能正确处理 getter 或 setter。
你应该组合使用 [`createJSInteropWrapper`] 和 [`@JSExport`]，
声明一个类型，为所有 `external` 实例成员提供实现。

## Mocking example

## 模拟示例

```dart
import 'dart:js_interop';

import 'package:expect/minitest.dart';

// The Dart class must have `@JSExport` on it or at least one of its instance
// members.
@JSExport()
class FakeCounter {
  int value = 0;
  @JSExport('increment')
  void renamedIncrement() {
    value++;
  }
  void decrement() {
    value--;
  }
}

extension type Counter(JSObject _) implements JSObject {
  external int value;
  external void increment();
  void decrement() {
    value -= 2;
  }
}

void main() {
  var fakeCounter = FakeCounter();
  // Returns a JS object whose properties call the relevant instance members in
  // `fakeCounter`.
  var counter = createJSInteropWrapper<FakeCounter>(fakeCounter) as Counter;
  // Calls `FakeCounter.value`.
  expect(counter.value, 0);
  // `FakeCounter.renamedIncrement` is renamed to `increment`, so it gets
  // called.
  counter.increment();
  expect(counter.value, 1);
  expect(fakeCounter.value, 1);
   // Changes in the fake affect the wrapper and vice-versa.
  fakeCounter.value = 0;
  expect(counter.value, 0);
  counter.decrement();
  // Because `Counter.decrement` is non-`external`, we never called
  // `FakeCounter.decrement`.
  expect(counter.value, -2);
}
```

## [`@JSExport`] and [`createJSInteropWrapper`]

## [`@JSExport`] 与 [`createJSInteropWrapper`]

`@JSExport` allows you to declare a class that can be used in
`createJSInteropWrapper`. `createJSInteropWrapper` will create an object literal
that maps each of the class' instance member names (or renames) to a JS
callback, which is created using [`Function.toJS`]. When called, the JS callback
will in turn call the instance member. In the above example, getting and setting
`counter.value` gets and sets `fakeCounter.value`.

`@JSExport` 让你可以声明一个能用于
`createJSInteropWrapper` 的类。`createJSInteropWrapper` 会创建一个对象字面量，
把该类每个实例成员的名称（或重命名）映射到 JS 回调，
回调由 [`Function.toJS`] 创建。调用时，JS 回调
会再调用对应的实例成员。在上面的示例中，读取和设置
`counter.value` 就是读取和设置 `fakeCounter.value`。

You can specify only some members of a class to be exported by omitting the
annotation from the class and instead only annotate the specific members. You
can see more specifics on more specialized exporting (including inheritance) in
the documentation of [`@JSExport`].

你可以不在类上加注解，只给特定成员加注解，
从而只导出类的部分成员。
关于更专门的导出方式（包括继承），
请参阅 [`@JSExport`] 的文档。

Note that this mechanism isn't specific to testing only. You can use this to
provide a JS interface for an arbitrary Dart object, allowing you to essentially
*export* Dart objects to JS with a predefined interface.

请注意，这一机制并不只用于测试。
你可以用它为任意 Dart 对象提供 JS 接口，
从而按预定义接口把 Dart 对象 **导出** 到 JS。

{% comment %}
TODO: Should we add a section on general testing? We can't really mock
non-instance members unless the user explicitly replaces the real API in JS.
{% endcomment %}

[Usage]: /interop/js-interop/usage
[`createJSInteropWrapper`]: {{site.dart-api}}/dart-js_interop/createJSInteropWrapper.html
[`Function.toJS`]: {{site.dart-api}}/dart-js_interop/FunctionToJSExportedDartFunction/toJS.html
[`@JSExport`]: {{site.dart-api}}/dart-js_interop/JSExport-class.html
[limitation is true for extension members]: {{site.repo.dart.org}}/mockito/blob/master/FAQ.md#how-do-i-mock-an-extension-method
[extension types]: /language/extension-types
