---
# title: "Moving Fast with Dart Immutable Values"
title: "用 Dart 不可变值快速前进"
# description: "Dart’s built_value provides powerful, convenient immutable values for Dart. The values might be immutable, but the package hasn’t been…"
description: "Dart 的 built_value 为 Dart 提供了强大、方便的不可变值。值虽然不可变，但这个 package 可没有停滞不前……"
ai-translated: true
publishDate: 2017-06-30
author: davidmorgan
category: deep-dive
layout: blog
---


Dart’s [built_value](https://github.com/google/built_value.dart) provides powerful, convenient immutable values for Dart. The values might be immutable, but the package hasn’t been standing still! In the six months since I [last wrote about](/blog/darts-built-value-for-immutable-object-models) built_value there have been ten major improvements to the package.

Dart 的 [built_value](https://github.com/google/built_value.dart)
为 Dart 提供了强大、方便的不可变（immutable）值。
值虽然是不可变的，但这个 package 可没有停滞不前！
自从我[上次写到](/blog/darts-built-value-for-immutable-object-models) built_value
以来的六个月里，这个 package 已经有了十项重大改进。

I also spotted some interesting uses of built_value in the Dart community:

我还发现了 Dart 社区中一些有趣的 built_value 用法：

* The [built_redux](https://github.com/davidmarne/built_redux) package is a [redux](http://redux.js.org/)-inspired package using built_value. It comes with bindings and examples for [flutter](https://github.com/davidmarne/flutter_built_redux/tree/master/example), [angular2](https://github.com/davidmarne/angular_built_redux/tree/master/example) and [react-dart](https://github.com/davidmarne/react_built_redux).

  [built_redux](https://github.com/davidmarne/built_redux) package
  是一个受 [redux](http://redux.js.org/) 启发、使用 built_value 的 package。
  它附带了 [flutter](https://github.com/davidmarne/flutter_built_redux/tree/master/example)、
  [angular2](https://github.com/davidmarne/angular_built_redux/tree/master/example)
  和 [react-dart](https://github.com/davidmarne/react_built_redux) 的绑定和示例。

* The [built_highcharts](https://github.com/vadimtsushko/built_highcharts) package is a [highcharts](https://www.highcharts.com/) wrapper using built_value. The [demo](https://vadimtsushko.github.io/built_highcharts/) is really rather nice.

  [built_highcharts](https://github.com/vadimtsushko/built_highcharts) package
  是一个使用 built_value 的 [highcharts](https://www.highcharts.com/) 封装。
  它的[演示](https://vadimtsushko.github.io/built_highcharts/)做得相当不错。

* And, here’s [another way](https://github.com/toufikzitouni/Built-Value-Example) of using built_value with Flutter.

  另外，这里还有[另一种](https://github.com/toufikzitouni/Built-Value-Example)
  在 Flutter 中使用 built_value 的方式。

Anyway, without further ado, here are all the great new things in built_value.

好了，闲话少说，下面就是 built_value 的所有精彩新特性。

## 1. Generic classes

## 1. 泛型类

Sophisticated object models use generics, so of course built_value needs [generics](https://github.com/google/built_value.dart/blob/master/example/lib/generics.dart). You can now declare your type using generics and the generated builder class will also support them:

复杂的对象模型会用到泛型，所以 built_value 当然需要
[泛型（generics）](https://github.com/google/built_value.dart/blob/master/example/lib/generics.dart)支持。
现在你可以用泛型声明类型，生成的构建器类也会支持它们：

```
abstract class GenericValue<T>
    implements Built<GenericValue<T>, GenericValueBuilder<T>> {
  T get value;
  ...
}

var value = new GenericValue<String>((b) => b..value = 'string');
```


Value types using generics are serializable, as usual.

使用泛型的值类型和往常一样可以序列化。

## 2. Serializer plugins

## 2. 序列化器插件

A new `SerializerPlugin` API allows you to make cross-cutting modifications to serialization, by running arbitrary code before and after every object is serialized or deserialized.

新的 `SerializerPlugin` API 允许你对序列化做横切修改：
在每个对象被序列化或反序列化之前和之后运行任意代码。

You could, for example, use this to map between two wire-incompatible versions of a protocol. But a better example is the next improvement…

例如，你可以用它在协议的两个传输格式不兼容的版本之间做映射。
不过更好的例子是下一项改进……

## 3. “Standard JSON” serializer plugin

## 3. “标准 JSON” 序列化器插件

By default, built_value serializes to and from its own list-based JSON format, for performance and flexibility.

默认情况下，出于性能和灵活性的考虑，
built_value 使用它自己的基于列表的 JSON 格式进行序列化与反序列化。

But many people need to inter-operate with existing JSON data and APIs. What should they do?

但很多人需要与现有的 JSON 数据和 API 互操作。他们该怎么办？

Now, you can install `StandardJsonPlugin` and switch to a standard map-based JSON format.

现在，你可以安装 `StandardJsonPlugin`，
切换到标准的基于 map 的 JSON 格式。

```
final standardSerializers =
    (serializers.toBuilder()
        ..addPlugin(new StandardJsonPlugin())).build();
```


See the [example](https://github.com/google/built_value.dart/blob/master/example/lib/example.dart) (towards the end).

参见[示例](https://github.com/google/built_value.dart/blob/master/example/lib/example.dart)（靠近末尾的部分）。

## 4. Getter memoization

## 4. Getter 记忆化

Immutable classes are great — but what should you do about *derived* fields? If a derived field is expensive to compute, then immutable classes give two bad options: computing them upfront and always paying a possibly unnecessary penalty, or recomputing them on demand and potentially paying that same large cost many times.

不可变类很棒——但*派生*字段该怎么办？
如果派生字段的计算代价很高，不可变类就给了你两个糟糕的选项：
要么提前计算，总是付出可能不必要的开销；
要么按需重新计算，可能把同样的高昂代价付上许多次。

Enter `@memoized` getters. Add this annotation to a built_value getter and it will be calculated lazily, but at most once; it’s then stored in a hidden field on the instance.

`@memoized` getter 登场。把这个注解加到 built_value 的 getter 上，
它就会被惰性计算，且至多计算一次；
结果随后存放在实例的一个隐藏字段里。

Since `1.1.2` built_value itself is a great example of `@memoized` getters. A built_value is used to wrap an `Element` from the analyzer, and computation is [done lazily in getters](https://github.com/google/built_value.dart/blob/master/built_value_generator/lib/src/value_source_class.dart):

从 `1.1.2` 起，built_value 自身就是 `@memoized` getter 的绝佳示例。
它用一个 built_value 来封装 analyzer 的 `Element`，
计算[在 getter 中惰性完成](https://github.com/google/built_value.dart/blob/master/built_value_generator/lib/src/value_source_class.dart)：

```
abstract class ValueSourceClass
    implements Built<ValueSourceClass, ValueSourceClassBuilder> {
  ClassElement get element;

  @memoized
  BuiltList<String> get genericParameters =>
      new BuiltList<String>(element.typeParameters
          .map((element) => element.computeNode().toString()));

  @memoized
  BuiltList<ValueSourceField> get fields =>
      ValueSourceField.fromClassElements(element, builderElement);

  // And many more @memoized getters.
}
```


## 5. Faster code generation

## 5. 更快的代码生成

…and as a result of moving to memoized getters, built_value is now significantly faster at generating code.

……而且得益于改用记忆化 getter，
built_value 现在生成代码的速度显著加快。

## 6. Simpler factories

## 6. 更简单的工厂构造器

Prior to `0.5.5` every built_value class had to have a factory method following a standard template. This requirement has been relaxed. Here are a few good ways to use this greater freedom.

在 `0.5.5` 之前，每个 built_value 类都必须有一个遵循标准模板的
工厂方法。这个要求已经放宽。下面是几种善用这份自由的好方法。

For classes with one or two fields, just take exactly those fields in the constructor:

对于只有一两个字段的类，直接在构造器中接收这些字段即可：

```
abstract class Value implements Built<Value, ValueBuilder> {
  ClassElement get element;

  factory Value(ClassElement element) =>
      new _$Value._(element: element);
}

void main() {
   var element = getElement();
   var value = new Value(element);
}
```


Or, where you want to set defaults for fields, you can now do this in the factory, instead of having to write your own builder class:

或者，如果你想为字段设置默认值，现在可以在工厂构造器里做，
而不必自己写构建器类：

```
abstract class Value implements Built<Value, ValueBuilder> {
  int get x;
  int get y;
  bool get awesome;

  factory Value([updates(ValueBuilder b)]) =>
      new _$Value((b) => b
          ..awesome = True
          ..update(updates));
}

void main() {
  var value = new Value((b) => b
      ..x = 10
      ..y = 20);
}
```


Finally, if you like named arguments, you can expose the named-argument-based constructor instead of the builder-based constructor:

最后，如果你喜欢命名参数，可以暴露基于命名参数的构造器，
代替基于构建器的构造器：

```
abstract class Value implements Built<Value, ValueBuilder> {
  int get x;
  int get y;

factory Value({int x, int y}) = _$Value._;

void main() {
  var value = new Value(x: 10, y: 20);
}
```


## 7. Prettier and customizable toString output

## 7. 更美观、可自定义的 toString 输出

Before `1.0.0` built_value’s `toString` output was rather flat. Now, by default it’s indented, so it’s easy to read:

在 `1.0.0` 之前，built_value 的 `toString` 输出相当扁平。
现在默认带缩进，更易阅读：

```
CompoundValue {
  simpleValue=SimpleValue {
    anInt=1,
  },
}
```


But, it’s also customizable, via a top-level global variable `newBuiltValueToStringHelper`. If you preferred the old format:

不过它也可以自定义——通过顶层全局变量 `newBuiltValueToStringHelper`。
如果你更喜欢旧格式：

```
newBuiltValueToStringHelper =
    (className) => new FlatBuiltValueToStringHelper(className);
```


Then:

那么输出就是：

```
CompoundValue {simpleValue=SimpleValue {anInt=1}}
```


And if you want to write your own — of course you can. The `BuiltValueToStringHelper` class is very easy to implement:

如果你想自己写一个——当然可以。
`BuiltValueToStringHelper` 类非常容易实现：

```
abstract class BuiltValueToStringHelper {
  void add(String field, Object value);
  String toString();
}
```


## 8. Serializable DateTime and JsonObject

## 8. 可序列化的 DateTime 和 JsonObject

The SDK`DateTime` class is now serializable — provided you use UTC rather than local time zone. (Serializing with local time zone is a recipe for disaster!)

SDK 的 `DateTime` 类现在可以序列化了——
前提是你使用 UTC 而不是本地时区。
（用本地时区序列化是灾难的配方！）

And, to help further with interop with existing JSON data and APIs, there is now a [`JsonObject`](https://github.com/google/built_value.dart/blob/master/built_value/lib/json_object.dart) class that wraps json values, lists and maps. Fields of type `JsonObject` serialize directly to and from raw JSON.

另外，为了进一步帮助与现有 JSON 数据和 API 互操作，
现在有了 [`JsonObject`](https://github.com/google/built_value.dart/blob/master/built_value/lib/json_object.dart) 类，
它封装 JSON 值、列表和 map。
`JsonObject` 类型的字段可以直接与原始 JSON 互相序列化。

## 9. Custom matcher for tests

## 9. 用于测试的自定义匹配器

The generated `operator==` methods in built_value are already very handy for tests, but there’s one thing they don’t give you: easily readable error messages. Instead, when an ‘equals’ check in a test fails, you’ll get the full `toString` of the expected and actual values.

built_value 生成的 `operator==` 方法对测试已经非常方便，
但有一样东西它们给不了你：易读的错误信息。
当测试中的 ‘equals’ 检查失败时，
你得到的是期望值和实际值完整的 `toString` 输出。

Not any more! You can now use `built_value_test`, a new pub package. If you [use it in a test](https://github.com/google/built_value.dart/blob/master/built_value_test/test/matcher_test.dart) you’ll now see errors like this:

现在不会了！你可以使用新的 pub package `built_value_test`。
如果你[在测试中使用它](https://github.com/google/built_value.dart/blob/master/built_value_test/test/matcher_test.dart)，
就会看到这样的错误信息：

```
was <3> instead of <5> at location ['simpleValue']['anInt']
```


If this looks a lot like the message you get when a map compare fails in a test, that’s because it’s the same: it’s implemented by converting the values to maps then comparing.

如果这看起来很像测试中 map 比较失败时的信息，
那是因为它们本来就是同一套：
它的实现就是把值转换成 map 再进行比较。

## 10. Implicit-dynamic and implicit-cast friendly code; better error messages

## 10. 对隐式 dynamic 与隐式转换友好的代码；更好的错误信息

The code generated by built_value has been cleaned up significantly to make it pass two very strict lints: it no longer uses `dynamic` implicitly anywhere, and it no longer relies on implicit casts.

built_value 生成的代码经过了大幅清理，以通过两条非常严格的 lint：
它不再在任何地方隐式使用 `dynamic`，也不再依赖隐式类型转换。

These two improvements may (or may not) lead to better code from the compiler.

这两项改进可能（也可能不会）让编译器生成更好的代码。

And, better error messages were added for when you declare a serializer field with the wrong type.

另外，当你用错误的类型声明 serializer 字段时，
现在会有更好的错误信息。

That was it! Thanks for reading. If you have any ideas or feature requests for built_value, head on over to the [issue tracker](https://github.com/google/built_value.dart/issues).

就这些！感谢阅读。如果你对 built_value 有任何想法或功能请求，
欢迎前往 [issue 跟踪器](https://github.com/google/built_value.dart/issues)。
