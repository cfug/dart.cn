---
# title: "Dart’s built_value for Serialization"
title: "Dart 的 built_value：序列化"
# description: "Last week I introduced built_value for immutable object models. We saw how to define object models in built_value; they’re immutable, easy…"
description: "上周我介绍了用于不可变对象模型的 built_value。我们看到了如何用 built_value 定义对象模型；它们不可变、易于使用……"
ai-translated: true
publishDate: 2016-12-07
author: davidmorgan
category: deep-dive
layout: blog
---


Last week I introduced [built_value for immutable object models](https://medium.com/@davidmorgan_14314/darts-built-value-for-immutable-object-models-83e2497922d4). We saw how to define object models in built_value; they’re immutable, easy to work with, and, if you like that sort of thing, a lot of fun.

上周我介绍了[用于不可变（immutable）对象模型的 built_value](https://medium.com/@davidmorgan_14314/darts-built-value-for-immutable-object-models-83e2497922d4)。
我们看到了如何用 built_value 定义对象模型；
它们不可变、易于使用，而且——如果你喜欢这类东西的话——非常有趣。

This article covers the rest of the built_value package. The biggest item is that, as you may have guessed from the title, they’re also serializable.

本文介绍 built_value package 的其余部分。
最重要的一点是——你可能已经从标题猜到了——它们还可以序列化（serialization）。

Here’s what built_value serialization looks like to use:

built_value 的序列化用起来是这样的：

```
// Value type defined using built_value.
abstract class Login implements Built<Login, LoginBuilder> {
  // Add serialization support by defining this static getter.
  static Serializer<Login> get serializer => _$loginSerializer;

  ...
}

// Once per app, define a top level "Serializer" to gather together
// all the generated serializers.
Serializers serializers = _$serializers;

// Use it!
var login = new Login((b) => b
  ..username = 'johnsmith'
  ..password = '123456');

print(JSON.encode(serializers.serialize(login)));
-->
["Login", "username", "johnsmith", "password", "123456"]
```


Notice the “JSON.encode”? The serializer doesn’t actually go as far as serializing to a String; rather it converts to primitives that Dart’s built-in JSON serialization knows how to handle. So if you want to, you can use something other than JSON.

注意到 “JSON.encode” 了吗？序列化器其实并不负责序列化成 String；
它只是转换成 Dart 内置 JSON 序列化能够处理的基本类型。
所以如果你愿意，可以使用 JSON 之外的格式。

You probably think of serialization as something that should “just work”, but there are a few subtle trade-offs involved. Let’s dig into built_value’s serialization.

你可能认为序列化就应该“开箱即用”，
但其中涉及一些微妙的权衡。我们来深入看看 built_value 的序列化。

## Polymorphism

## 多态

The single most important aspect of built_value’s serialization is that it supports polymorphism. Specifically, you can have fields of *abstract* types, and

built_value 序列化最重要的一点是支持多态（polymorphism）。
具体来说，你可以拥有*抽象*类型的字段，并且：

* any serializable implementation of that abstract type can be serialized;

  该抽象类型的任何可序列化实现都能被序列化；

* enough information will be written on the wire to deserialize to the correct types.

  传输数据中会写入足够的信息，以便反序列化（deserialization）
  出正确的类型。

The simplest example is that it can serialize a list of Object:

最简单的例子是它可以序列化一个 Object 列表：

```
serializers.serialize(new BuiltList<Object>([1, 'two', 3]));
-->
['list', ['int', 1, 'string', 'two', 'int', 3]]
```


Extra information is added on the wire only as required to disambiguate when deserializing. So if you have a field of type “BuiltList&lt;int&gt;”, it will be serialized like “[1, 2, 3]” and not like “[‘int’, 1, ‘int’, 2, ‘int’, 3]”.

只有在反序列化需要消除歧义时，才会在传输数据中添加额外信息。
所以如果你有一个 “BuiltList&lt;int&gt;” 类型的字段，
它会被序列化成 “[1, 2, 3]”，而不是 “[‘int’, 1, ‘int’, 2, ‘int’, 3]”。

The bottom line is that you can define your object model however you like, and built_value will serialize it. If you want to see this in more detail, the [map serializer test](https://github.com/google/built_value.dart/blob/master/built_value/test/built_map_serializer_test.dart) explores all the possibilities.

总而言之，你可以随意定义你的对象模型，built_value 都能把它序列化。
想了解更多细节，可以看看
[map 序列化器测试](https://github.com/google/built_value.dart/blob/master/built_value/test/built_map_serializer_test.dart)，
它探索了所有可能性。

## Multiple Implementations

## 多重实现

Another problem all serialization mechanisms have to face is somehow defining the *universe* of serializable types. Here built_json does something a little unusual by allowing *multiple implementations* of one “type”.

所有序列化机制都必须面对的另一个问题，
是如何定义可序列化类型的*全集*。
在这里 built_json 做了一件有点不寻常的事：
允许一个“类型”有*多个实现*。

This works because types are defined on the wire by their *class name only*. No attempt is made to disambiguate between different classes called “Login”, for example; it’s assumed that both sender and receiver have a compatible serializer for a class called “Login” available.

之所以可行，是因为类型在传输数据中*仅凭类名*来标识。
例如，系统不会尝试区分两个都叫 “Login” 的不同类；
它假定发送方和接收方都有名为 “Login” 的类的兼容序列化器可用。

This adds useful flexibility. If you’re using Dart on the server and the client, for example, you have a *choice* for each class in the object model:

这带来了实用的灵活性。例如，如果你在服务器和客户端都用 Dart，
那么对象模型中的每个类你都有*选择*：

* You can use the same class on the client and server.

  你可以在客户端和服务器使用同一个类。

* Or, you can use different classes. The implementations must have the same name and compatible fields.

  或者，你也可以使用不同的类。
  这些实现必须同名，且字段兼容。

For example, you could have a “Login” class for the client that deals with rendering and parsing; and a separate “Login” class for the server that deals with authentication and databases. Of course, the server-only implementation is free to use packages like “dart:io”, and the client-only implementation packages like “dart:html”.

例如，你可以有一个负责渲染和解析的客户端 “Login” 类，
再有一个负责认证和数据库的服务器端 “Login” 类。
当然，仅服务器端的实现可以放心使用 “dart:io” 之类的 package，
仅客户端的实现则可以使用 “dart:html” 之类的 package。

## Multiple Languages

## 多语言

Because built_value serialization identifies types by the class name alone, the serialized data maps well onto any object oriented language. Support for Java is planned via [AutoValue](https://github.com/google/auto/tree/master/value).

由于 built_value 序列化仅凭类名标识类型，
序列化后的数据可以很好地映射到任何面向对象语言。
对 Java 的支持已在计划中，将通过
[AutoValue](https://github.com/google/auto/tree/master/value) 实现。

## Multiple Versions

## 多版本

Serialized built_value data is backwards/forwards compatible in a very simple way: it relies on class names and field names. Class name changes and required field name changes are breaking.

序列化后的 built_value 数据以一种非常简单的方式实现
向前/向后兼容：它依赖类名和字段名。
更改类名、更改必填字段名都是破坏性变更。

Nullable fields are more flexible: on serialization, they will only be written if non-null; on deserialization, they will default to null if not found. So, nullable fields can be added, removing or renamed and this is not a breaking change.

可空字段更灵活：序列化时，只有非 null 才会被写入；
反序列化时，找不到就默认为 null。
所以，添加、删除或重命名可空字段都不是破坏性变更。

Unrecognized fields are simply ignored.

无法识别的字段会被直接忽略。

## No Mirrors

## 不使用 Mirrors

Finally, and crucial for performance, is that built_value doesn’t use mirrors in any shape or form. All analysis is done at codegen time, leaving you with minimal, performant serialization code.

最后，对性能至关重要的一点是：built_value 完全不使用
mirrors（镜像反射）。所有分析都在代码生成时完成，
留给你的是精简、高性能的序列化代码。

That was serialization with built_value. You can just sit down and write an object model and it is straight away serializable for use in RPCs or for long term storage.

以上就是 built_value 的序列化。你只管坐下来写对象模型，
它立刻就能序列化，用于 RPC 或长期存储。

## EnumClass

## EnumClass

Finally, built_value comes with one more feature: EnumClass. Dart enums [aren’t classes](https://www.dartlang.org/guides/language/language-tour#enumerated-types), but a powerful object model needs enums that behave like classes. The obvious pattern is to create a class with “static const” fields, and EnumClass makes this a little easier to do. It provides:

最后，built_value 还带来一个特性：EnumClass。
Dart 的枚举[不是类](https://www.dartlang.org/guides/language/language-tour#enumerated-types)，
但强大的对象模型需要行为像类的枚举。
显而易见的模式是创建一个带 “static const” 字段的类，
EnumClass 让这件事更简单一些。它提供：

* Generated code for “values” and “valueOf”.

  为 “values” 和 “valueOf” 生成的代码。

* Serialization via built_value serializers.

  通过 built_value 序列化器进行序列化。

* An extra bonus for Angular or Angular2 users: the codegen can optionally produce a mixin to help you use the enum from templates.

  给 Angular 或 Angular2 用户的额外福利：
  代码生成可以可选地产出一个 mixin，帮助你在模板中使用枚举。

All of these features can be seen in the [example](https://github.com/google/built_value.dart/blob/master/example/lib/enums.dart).

所有这些特性都可以在[示例](https://github.com/google/built_value.dart/blob/master/example/lib/enums.dart)中看到。

That’s it for this week! Having covered the basics of built_value I’m ready to dive into the chat example in detail next week. Stay tuned!

本周就到这里！built_value 的基础已经讲完，
下周我准备深入讲解聊天示例。敬请期待！

Edit: [next article](https://medium.com/@davidmorgan_14314/building-a-chat-app-in-dart-815fcd0e5a31#.ncnhb2fh0).

编辑补充：[下一篇文章](https://medium.com/@davidmorgan_14314/building-a-chat-app-in-dart-815fcd0e5a31#.ncnhb2fh0)。