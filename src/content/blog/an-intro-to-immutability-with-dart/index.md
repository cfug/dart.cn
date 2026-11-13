---
# title: "An intro to immutability with Dart"
title: "Dart 不可变性入门"
# description: "It’s impossible to deny that immutability is a hot topic in programming, especially front-end programming. Libraries like Immutable.js and…"
description: "不可否认，不可变性是编程领域的热门话题，尤其是前端编程。Immutable.js 之类的库……"
ai-translated: true
publishDate: 2017-04-24
author: matanlurey
category: other
layout: blog
---


It’s impossible to deny that [immutability](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=2&cad=rja&uact=8&ved=0ahUKEwiM4_LAjLzTAhWDKGMKHbnICLYQFggmMAE&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FImmutable_object&usg=AFQjCNEkdj3g887nk6kENS9SYN-2xsqXpw&sig2=hZqSkCh5MKP-OX2w8YyjvQ) is a hot topic in programming, especially front-end programming. Libraries like [Immutable.js](https://facebook.github.io/immutable-js/) and other concepts like unidirectional data flow have argued it’s easier to reason about data when it doesn’t change underneath you:

不可否认，[不可变性（immutability）](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=2&cad=rja&uact=8&ved=0ahUKEwiM4_LAjLzTAhWDKGMKHbnICLYQFggmMAE&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FImmutable_object&usg=AFQjCNEkdj3g887nk6kENS9SYN-2xsqXpw&sig2=hZqSkCh5MKP-OX2w8YyjvQ)
是编程领域的热门话题，尤其是前端编程。
[Immutable.js](https://facebook.github.io/immutable-js/) 之类的库
以及单向数据流（unidirectional data flow）等理念都主张：
当数据不会在你脚下悄悄变化时，更容易对数据进行推理：
> In object-oriented and functional programming, an **immutable** object (unchangeable object) is an object whose state cannot be modified after it is created. This is in contrast to a mutable object (changeable object), which can be modified after it is created.

> 在面向对象和函数式编程中，**不可变（immutable）**对象
> （不可更改的对象）是指创建之后其状态就不能再被修改的对象。
> 与之相对的是可变（mutable）对象（可更改的对象），
> 它在创建之后仍然可以被修改。

Well, what about Dart? We have a couple concepts that lend themselves well to immutability and immutable objects built-in, starting with the *const* modifier and *const* constructor. Not to be confused with *const* in ES6, which is merely an immutable binding:

那么 Dart 呢？Dart 内置了一些非常适合不可变性和不可变对象的概念，
首先就是 *const* 修饰符和 *const* 构造器。
注意不要和 ES6 里的 *const* 混淆——那只是一个不可变的绑定（binding）：

```javascript
// Define USER as a constant and give it an initial value.
const USER = { name: 'Joe'; }

// This will throw an error.
USER = {};

// But this will not.
USER.name = 'Jill';

```

In Dart, *const* is both an immutable binding *and* an immutable object:

在 Dart 中，*const* 既是不可变的绑定，*也*是不可变的对象：

```dart
main() {
  const user = const {'name': 'Joe'};
  
  // Static error: "Constant variables cannot be assigned a value".
  user = {};
  
  // Runtime error: "Unsupported operation: Cannot modify unmodifiable Map".
  user['name'] = 'Jill';
}

```

All literals (*Null, String, int, double, num, bool, Map, List, Symbol*) are capable of being *const*, and it’s possible to create user-types with a *const* constructor:

所有字面量（*Null、String、int、double、num、bool、Map、List、Symbol*）
都可以是 *const*，你也可以通过 *const* 构造器创建自定义类型：

```dart
class User {
  final String name;
  
  const User(this.name);
}

main() {
  const user = const User('Joe');
}

```

Let’s review — *const* instances are both immutable bindings and *enforced* at a language level to be both deeply immutable — and also are *canonicalized* at compile-time — that is, any two instances are considered equivalent, and are only represented by a single instance when running. For example, the following is rather cheap — it only allocates a single instance at runtime:

回顾一下——*const* 实例既是不可变的绑定，
又在语言层面被*强制*保证深度不可变——
并且会在编译期被*规范化（canonicalized）*——也就是说，
任意两个等价的实例在运行时只由同一个实例表示。
例如下面这段代码开销很小——它在运行时只分配一个实例：

```dart
class User {
  final String name;
  final List<String> cars;
  
  User(this.name, {this.cars});
}

main() {
  for (var i = 0; i < 100; i++) {
    const users = const {
      'Matan': const User(
        'Matan Lurey',
        cars: const [
          'Truck',
          'Jeep',
          'GoKart',
        ],
      ),
    };
  }
}

```

Want to learn more? [Read the Dart language tour about final and const](https://www.dartlang.org/guides/language/language-tour#final-and-const).

想了解更多？[阅读 Dart 语言之旅中关于 final 和 const 的部分](https://www.dartlang.org/guides/language/language-tour#final-and-const)。

## Further static checking with package:meta

## 使用 package:meta 进行更多静态检查

Of course, *const* is a bit restrictive — you must be able to create a class at compile-time — so you couldn’t for example read a database and create *const* objects at runtime. We’ve recently introduced the “immutable” annotation with [package:meta](https://pub.dartlang.org/packages/meta):

当然，*const* 有些限制——你必须能在编译期创建类的实例——
所以你没法在运行时读取数据库再创建 *const* 对象。
我们最近通过 [package:meta](https://pub.dartlang.org/packages/meta)
引入了 “immutable” 注解：

```dart
import 'package:meta/meta.dart';

// Error: This class inherits from a class marked as @immutable, and therefore 
// should be immutable (all instance fields must be final).
@immutable
class User {
  String name;
}

```

You can use this annotation to help enforce that developers keep your classes deeply immutable. It won’t be canonicalized like *const*, but can still be quite helpful for developers.

你可以用这个注解来帮助确保开发者让你的类保持深度不可变。
它不会像 *const* 那样被规范化，但对开发者仍然相当有帮助。

I hope this was a nice introduction to immutability. Please let me know in the comments or on twitter if you’d like to learn more about Dart or immutability.

希望这是一篇不错的不可变性入门文章。
如果你想了解更多 Dart 或不可变性的内容，
请在评论区或 Twitter 上告诉我。
