---
# title: "Dart’s built_value for Immutable Object Models"
title: "Dart 的 built_value：不可变对象模型"
# description: "Last week I wrote about built_collection. I finished by remarking that to really make use of immutable collections, you need immutable…"
description: "上周我写了关于 built_collection 的文章。结尾提到，要真正用好不可变集合，你需要不可变的值……"
ai-translated: true
publishDate: 2016-11-30
author: davidmorgan
category: deep-dive
layout: blog
---


Last week I [wrote about](https://medium.com/@davidmorgan_14314/darts-built-collection-for-immutable-collections-db662f705eff#.71roxijm3) [built_collection](https://github.com/google/built_collection.dart). I finished by remarking that to really make use of immutable collections, you need immutable values. So here we are: [built_value](https://github.com/google/built_value.dart). This is the second major piece behind my talk at [Dart Developer Summit (video)](https://www.youtube.com/watch?v=TMeJxWltoVo).

上周我[写了关于](https://medium.com/@davidmorgan_14314/darts-built-collection-for-immutable-collections-db662f705eff#.71roxijm3)
[built_collection](https://github.com/google/built_collection.dart) 的文章。
我在结尾提到，要真正用好不可变（immutable）集合，你需要不可变的值。
于是就有了今天的主题：[built_value](https://github.com/google/built_value.dart)。
这是我在 [Dart 开发者峰会演讲（视频）](https://www.youtube.com/watch?v=TMeJxWltoVo)背后
的第二大块内容。

## Value Types

## 值类型

The built_value package is for defining your own *value types*. The term has a [precise meaning](https://en.wikipedia.org/wiki/Value_type), but we use it informally to mean types where equality is based only on value. For example, numbers: my 3 is equal to your 3.

built_value package 用于定义你自己的*值类型（value type）*。
这个术语有[精确的含义](https://en.wikipedia.org/wiki/Value_type)，
但我们在这里非正式地用它指“相等性只基于值”的类型。
例如数字：我的 3 等于你的 3。

Not only that: my 3 will *always* equal your 3; it can’t change to be 4, or null, or a different type altogether. Value types are naturally immutable. This makes them simple to interact with and to reason about.

不仅如此：我的 3 *永远*等于你的 3；
它不可能变成 4、变成 null，或者干脆变成另一种类型。
值类型天然是不可变的。这让它们易于使用、易于推理。

This all sounds terribly abstract. What are value types good for? Well, it turns out: a lot. A whole lot. Arguably — and I do argue this, often — any class that’s used to model the real world should be a value type. Observe:

这些听起来非常抽象。值类型有什么用？答案是：很多用处，非常多。
可以说——我也经常这么主张——任何用于对现实世界建模的类
都应该是值类型。来看：

```
var user1 = new User(name: "John Smith");
var user2 = new User(name: "John Smith");

print(user1 == user2);
```


What should it print? Crucially, both instances are supposed to refer to someone in the real world. Because their values are identical they must refer to the *same person.* So they must be considered equal.

它应该打印什么？关键在于，这两个实例都指向现实世界中的某个人。
既然它们的值完全相同，它们必然指向*同一个人*，
所以它们必须被视为相等。

What about immutability? Consider:

那不可变性呢？考虑这段代码：

```
user1.nickname = 'Joe';
```


What does updating a “User” nickname mean? It could imply any number of changes; perhaps the welcome text on my web page uses the nickname, and that should be updated. I probably have some storage somewhere, so that will need updating too. I now have two major problems:

更新 “User” 的昵称意味着什么？它可能牵涉任意多的变更：
也许我网页上的欢迎语用到了这个昵称，那需要更新；
我大概还在某处有存储，那也需要更新。
现在我有两个大问题：

* I don’t know who has a reference to “user1”. The value has just changed under them; depending on how they’re using it, this could have any number of unpredictable effects.

  我不知道谁持有 “user1” 的引用。这个值刚刚在他们脚下变了；
  取决于他们如何使用它，这可能产生任意多不可预测的影响。

* Anyone holding “user2” or similar is now holding a value that’s out of date.

  任何持有 “user2” 或类似值的人，现在拿到的都是过时的值。

Immutability can’t help with the second problem, but it does remove the first. It means there are no unpredictable updates, just explicit ones:

不可变性解决不了第二个问题，但它能消除第一个问题。
它意味着没有不可预测的更新，只有显式的更新：

```
var updatedUser = new User(name: "John Smith", nickname: "Joe");
saveToDatabase(updatedUser); // Database will notify frontend.
```


Crucially, it means changes are *local until explicitly published*. This leads to simple code that’s easy to reason about — and to make both correct and fast.

关键在于，这意味着变更在被显式发布之前都是*局部的*。
这带来简单、易于推理的代码——也更容易做到既正确又快速。

## The Problem with Value Types

## 值类型的问题

So, the obvious question: if value types are so useful, why don’t we see them everywhere?

那么显而易见的问题是：如果值类型这么有用，为什么没有随处可见？

Unfortunately they’re extremely laborious to implement. In Dart and in most other Object Oriented languages, a large amount of [boilerplate code](https://en.wikipedia.org/wiki/Boilerplate_code) is needed. In my talk at the Dart Developer Summit I showed how a simple two-field class [needs so much boilerplate it fills a whole slide (video)](https://www.youtube.com/watch?v=TMeJxWltoVo&feature=youtu.be&t=369).

不幸的是，实现它们极其费力。在 Dart 和大多数其他面向对象语言中，
需要大量[样板代码（boilerplate code）](https://en.wikipedia.org/wiki/Boilerplate_code)。
在 Dart 开发者峰会的演讲里我展示过，一个简单的两字段类
[需要的样板代码多到占满一整页幻灯片（视频）](https://www.youtube.com/watch?v=TMeJxWltoVo&feature=youtu.be&t=369)。

## Introducing built_value

## built_value 登场

We need either a language feature — which is exciting to discuss, but unlikely to arrive any time soon — or some form of [metaprogramming](https://en.wikipedia.org/wiki/Metaprogramming). And what we find is that Dart already has a very nice way to do metaprogramming: [source_gen](https://github.com/dart-lang/source_gen).

我们要么需要一个语言特性——讨论起来令人兴奋，
但短期内不太可能落地——要么需要某种形式的
[元编程（metaprogramming）](https://en.wikipedia.org/wiki/Metaprogramming)。
而我们发现，Dart 已经有一种非常好的元编程方式：
[source_gen](https://github.com/dart-lang/source_gen)。

The goal is clear: make it so easy to define and use value types that we can use them wherever a value type makes sense.

目标很明确：让定义和使用值类型变得足够简单，
以至于凡是值类型有意义的地方我们都能用上它。

First we’ll need a quick detour to look at how this problem can be approached with source_gen. The source_gen tool creates generated source in new files next to your manually maintained source, so we need to leave room for a generated implementation. That means an abstract class:

首先我们稍微绕个路，看看如何用 source_gen 解决这个问题。
source_gen 工具会在你手工维护的源码旁边新建文件来存放生成的源码，
所以我们需要给生成的实现留出位置。这意味着要用抽象类：

```
abstract class User {
  String get name;
  
  @nullable
  String get nickname;
}
```


That has enough information to generate an implementation. By convention generated code starts with “_$”, to mark it as private and generated. So the generated implementation will be called “_$User”. To allow it to extend “User” there will be a private constructor for this purpose called “_”:

这些信息足以生成一个实现。按照惯例，生成的代码以 “_$” 开头，
表示它是私有且生成的。所以生成的实现将叫作 “_$User”。
为了让它能继承 “User”，需要一个专为此用途设置的私有构造器 “_”：

```
=== user.dart ===

abstract class User {
  String get name;

  @nullable
  String get nickname;

  User._();
  factory User() = UserImpl;
}

=== user.g.dart is generated by source_gen ===

class _$User extends User {
  String name;
  String nickname;

  _$User() : super._();
}
```


We need to use Dart’s “part” statement to pull in the generated code:

我们需要用 Dart 的 “part” 语句引入生成的代码：

```
=== user.dart ===

library user;

part 'user.g.dart';

abstract class User {
  String get name;

  @nullable
  String get nickname;

  User._();
  factory User() = _$User;
}

=== user.g.dart is generated by source_gen ===

part of user;

class _$User extends User {
  String name;
  String nickname;

  _$User() : super._();

  // Generated implementation goes here.
}
```


We’re getting somewhere! We have a way to generate code and plug it into the code we write by hand. Now back to the interesting part: what you actually have to write by hand and what built_value should generate.

有进展了！我们有了生成代码、并把它接入手写代码的办法。
现在回到有趣的部分：你实际需要手写什么，built_value 又应该生成什么。

We’re missing a way to actually specify values for the fields. We could think about using named optional parameters:

我们还缺一种真正为字段指定值的方式。可以考虑使用命名可选参数：

```
factory User({String name, String nickname}) = _$User;
```


But this has a couple of drawbacks: it forces you to repeat all the field names in the constructor, and it only provides a way to set all the fields in one go; what if you want to build up a value piece by piece?

但这有几个缺点：它迫使你把所有字段名在构造器里重复一遍，
而且只提供了“一次性设置所有字段”的方式；
如果你想一点一点地构建一个值呢？

Fortunately, the [builder pattern](https://en.wikipedia.org/wiki/Builder_pattern) comes to the rescue. We’ve already seen [how well it works](https://medium.com/@davidmorgan_14314/darts-built-collection-for-immutable-collections-db662f705eff#.oj7boxdoh) for collections in Dart — thanks to the cascade operator. Assuming we have a builder type, we can use that for the constructor — by asking for a function that takes a builder as a parameter:

幸运的是，[构建器模式（builder pattern）](https://en.wikipedia.org/wiki/Builder_pattern)前来救场。
我们已经见识过它[在 Dart 集合上有多好用](https://medium.com/@davidmorgan_14314/darts-built-collection-for-immutable-collections-db662f705eff#.oj7boxdoh)——
这要归功于级联运算符。假设我们有一个构建器类型，
就可以把它用在构造器上——要求传入一个以构建器为参数的函数：

```
abstract class User {
  String get name;

  @nullable
  String get nickname;

  User._();
  factory User([updates(UserBuilder b)]) = _$User;
}
```


That’s a bit surprising, but it leads to a very simple syntax for instantiation:

这有点出乎意料，但它带来了非常简单的实例化语法：

```
var user1 = new User((b) => b
    ..name = 'John Smith'
    ..nickname = 'Joe');
```


What about creating new values based on old ones? The traditional builder pattern provides a “toBuilder” method to convert to a builder; you then apply your updates and call “build”. But a nicer pattern for most use cases is to have a “rebuild” method. Like the constructor, it takes a function that takes a builder, and provides for easy inline updates:

那如何基于旧值创建新值呢？传统的构建器模式提供 “toBuilder” 方法
转换成构建器；然后你应用更新并调用 “build”。
但对大多数使用场景来说，更优雅的模式是提供 “rebuild” 方法。
和构造器一样，它接受一个以构建器为参数的函数，
让内联更新变得轻松：

```
var user2 = user.rebuild((b) => b
    ..nickname = 'Jojo');
```


We do still want “toBuilder”, though, for cases when you want to keep a builder around for a little while. So we want two methods for all our value types:

不过我们仍然想要 “toBuilder”，用于你想把构建器保留一段时间的场景。
所以我们希望所有值类型都有这两个方法：

```
abstract class Built<V, B> {
  // Creates a new instance: this one with [updates] applied.
  V rebuild(updates(B builder));

  // Converts to a builder.
  B toBuilder();
}
```


You don’t need to write the implementation for these, built_value will generate it for you. So you can just declare that you “implement Built”:

这些方法的实现你不用自己写，built_value 会替你生成。
所以你只需要声明自己 “implement Built”：

```
library user;

import 'package:built_value/built_value.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
  String get name;

  @nullable
  String get nickname;

  User._();
  factory User([updates(UserBuilder b)]) = _$User;
}
```


And that’s it! A value type defined, an implementation generated and easy to use. Of course, the generated implementation isn’t just fields: it also provides “operator==”, “hashCode”, “toString” and null checks for required fields.

就这样！一个值类型定义好了，实现生成了，而且易于使用。
当然，生成的实现不只是字段：它还提供 “operator==”、“hashCode”、
“toString”，以及对必填字段的 null 检查。

I’ve skipped over one major detail, though: I said “assuming we have a builder type”. Of course, we’re generating code, so the answer is simple: we’ll generate it for you. The “UserBuilder’ referred to from “User” is created in “user.g.dart”.

不过我跳过了一个重要细节：我说过“假设我们有一个构建器类型”。
当然，我们是在生成代码，所以答案很简单：我们会替你生成。
“User” 中引用的 “UserBuilder” 就创建在 “user.g.dart” 里。

…*unless* you wanted to write some code in the builder, which is a perfectly reasonable thing to want to do. If that’s what you want, you follow the same pattern for the builder. It’s declared as abstract, with a private constructor and a factory that delegates to the generated implementation:

……*除非*你想在构建器里写一些代码——这是完全合理的需求。
如果是这样，构建器也遵循同样的模式：
声明为抽象类，带一个私有构造器，
以及一个委托给生成实现的工厂构造器：

```
abstract class UserBuilder extends Builder<V, B> {
  @virtual
  String name;

  @virtual
  String nickname;

  // Parses e.g. John "Joe" Smith into username+nickname.
  void parseUser(String user) {
    ...
  }

  UserBuilder._();
  factory UserBuilder() => _$UserBuilder;
}
```


The “@virtual” annotations come from “package:meta”, and are needed to allow the generated implementation to override the fields. Now that you’ve added utility methods to your builder you can use them inline just like you could assign to fields:

“@virtual” 注解来自 “package:meta”，
有了它生成的实现才能覆盖这些字段。
现在你已经在构建器里加了实用方法，
就可以像给字段赋值一样内联使用它们：

```
var user = new User((b) => b..parseUser('John "Joe" Smith'));
```


The use cases for customizing a builder are relatively rare, but they can be very powerful. For example, you might want your builders to implement a common interface for setting shared fields, so they can be used interchangeably.

自定义构建器的使用场景相对少见，但可以非常强大。
例如，你可能想让各个构建器实现一个用于设置共享字段的公共接口，
这样它们就可以互换使用。

## Nested Builders

## 嵌套构建器

There’s a major feature of built_value you haven’t seen yet: nested builders. When a built_value field holds a built_collection or another built_value, by default it’s available in the builder as a *nested builder*. This means you can update deeply nested fields *more easily* than if the whole structure was mutable:

built_value 还有一个你没见过的重要特性：嵌套构建器（nested builder）。
当一个 built_value 字段持有 built_collection 或另一个 built_value 时，
默认情况下它在构建器中以*嵌套构建器*的形式提供。
这意味着更新深层嵌套的字段比整个结构可变时*更容易*：

```
var structuredData = new Account((b) => b
    ..user.name = 'John Smith'
    ..user.nickname = 'Joe'
    ..credentials.email = 'john.smith@example.com'
    ..credentials.phone.country = Country.us
    ..credentials.phone.number = '555 01234 567');

var updatedStructuredData = structuredData.rebuild((b) => b
    ..credentials.phone.country = Country.switzerland
    ..credentials.phone.number = '555 01234 555');
```


Why “more easily” than if the structure was mutable?

为什么比结构可变时“更容易”？

Firstly, the “update” method provided by all builders means you can enter a new scope whenever you like, “restarting” the cascade operator and making whatever updates you want both concisely and inline:

首先，所有构建器都提供 “update” 方法，
你可以随时进入一个新的作用域，“重启”级联运算符，
简洁、内联地做出你想要的任何更新：

```
var updatedStructuredData = structuredData.rebuild((b) => b
    ..user.update((b) => b
        ..name = 'Johnathan Smith')
    ..credentials.phone.update((b) => b
        ..country = Country.switzerland
        ..number = '555 01234 555'));
```


Secondly, nested builders are automatically created as needed. For example, in built_value’s benchmark code we define a type called Node:

其次，嵌套构建器会按需自动创建。
例如，在 built_value 的基准测试代码中，我们定义了一个叫 Node 的类型：

```
abstract class Node implements Built<Node, NodeBuilder> {
  @nullable
  String get label;
  @nullable
  Node get left; 
  @nullable
  Node get right;

  Node._();
  factory Node([updates(NodeBuilder b)]) = _$Node;
}
```


And the auto creation of builders lets us create whatever tree structure we want inline:

构建器的自动创建让我们可以内联构建任意树结构：

```
var node = new Node((b) => b
  ..left.left.left.right.left.right.label = 'I’m a leaf!'
  ..left.left.right.right.label = 'I’m also a leaf!');

var updatedNode = node.rebuild((b) => b
  ..left.left.right.right.label = 'I’m not a leaf any more!'
  ..left.left.right.right.right.label = 'I’m the leaf now!');
```


Did I mention a benchmark? When updating, built_value only copies the parts of the structure that need updating, reusing the rest. So it’s *fast —* and memory efficient*.*

我提到基准测试了吗？更新时，built_value 只拷贝结构中需要更新的部分，
其余部分直接复用。所以它*很快*——而且节省内存。

But you don’t just have to build trees. With built_value you have at your disposal fully typed immutable object models … that are as fast and powerful as efficient immutable trees. You can mix and match typed data, custom structures like the “Node” example, and collections from built_collection:

但你并不只能构建树。有了 built_value，
你手中是完全类型化的不可变对象模型……
它们和高效的不可变树一样快、一样强大。
你可以混合搭配类型化数据、像 “Node” 示例这样的自定义结构，
以及来自 built_collection 的集合：

```
var structuredData = new Account((b) => b
    ..user.update((b) => b
        ..name = 'John Smith')
    ..credentials.phone.update((b) => b
        ..country = Country.us
        ..number = '555 01234 567')
    ..node.left.left.left.account.update((b) => b
        ..user.name = 'John Smith II'
        ..user.nickname = 'Is lost in a tree')
    ..node.left.right.right.account.update((b) => b
        ..user.name = 'John Smith III'));
```


*These* are the value types that I’m talking about when I argue most data should be value types!

当我说大多数数据都应该是值类型时，我指的正是*这样的*值类型！

## More on built_value

## 关于 built_value 的更多内容

I’ve covered why built_value is needed and what it looks like to use. There’s more to come: built_value also provides EnumClass, for classes that act like enums, and JSON serialization, for server/client communication and data storage. I’ll talk about those in future articles.

我已经讲了为什么需要 built_value，以及用起来是什么样子。
还有更多内容：built_value 还提供 EnumClass——
用于行为类似枚举的类——以及用于服务端/客户端通信和数据存储的
JSON 序列化（serialization）。我会在后续文章中介绍它们。

After that I’ll dig into the [chat example](https://github.com/google/built_value.dart/tree/master/chat_example) that uses built_value in and end to end system with server and client.

之后我会深入讲解[聊天示例](https://github.com/google/built_value.dart/tree/master/chat_example)，
它在一个包含服务端和客户端的端到端系统中使用了 built_value。

Edit: [next article](https://medium.com/@davidmorgan_14314/darts-built-value-for-serialization-f5db9d0f4159#.par5t1142).

编辑补充：[下一篇文章](https://medium.com/@davidmorgan_14314/darts-built-value-for-serialization-f5db9d0f4159#.par5t1142)。