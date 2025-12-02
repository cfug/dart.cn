---
# title: Extend a class
title: Extend a class
# description: Learn how to create subclasses from a superclass.
description: Learn how to create subclasses from a superclass.
prevpage:
  url: /language/methods
  title: Methods
nextpage:
  url: /language/mixins
  title: Mixins
---

Use `extends` to create a subclass, and `super` to refer to the
superclass:



使用 `extends` 来创建子类，使用 `super` 来引用超类：

<?code-excerpt "misc/lib/language_tour/classes/extends.dart (smart-tv)" replace="/extends|super/[!$&!]/g"?>
```dart
class Television {
  void turnOn() {
    _illuminateDisplay();
    _activateIrSensor();
  }
  // ···
}

class SmartTelevision [!extends!] Television {
  void turnOn() {
    [!super!].turnOn();
    _bootNetworkInterface();
    _initializeMemory();
    _upgradeApps();
  }
  // ···
}
```



关于 `extends` 的另一种用法，请参阅泛型页面中
[参数化类型][parameterized types]的讨论。

For another usage of `extends`, see the discussion of
[parameterized types][] on the Generics page.



## 重写成员

## Overriding members



子类可以重写实例方法（包括[运算符][operators]）、
getter 和 setter。
你可以使用 `@override` 注解来表明你是有意重写一个成员：

Subclasses can override instance methods (including [operators][]),
getters, and setters.
You can use the `@override` annotation to indicate that you are
intentionally overriding a member:



重写方法的声明必须在以下几个方面与其重写的方法（或多个方法）匹配：

<?code-excerpt "misc/lib/language_tour/metadata/television.dart (override)" replace="/@override/[!$&!]/g"?>
```dart
class Television {
  // ···
  set contrast(int value) {
    // ···
  }
}

class SmartTelevision extends Television {
  [!@override!]
  set contrast(num value) {
    // ···
  }
  // ···
}
```



* 返回类型必须与被重写方法的返回类型相同（或是其子类型）。
* 参数类型必须与被重写方法的参数类型相同（或是其超类型）。
  在前面的示例中，`SmartTelevision` 的 `contrast` setter
  将参数类型从 `int` 更改为其超类型 `num`。
* 如果被重写的方法接受 _n_ 个位置参数，
  那么重写方法也必须接受 _n_ 个位置参数。
* [泛型方法][generic method]不能重写非泛型方法，
  非泛型方法也不能重写泛型方法。

An overriding method declaration must match
the method (or methods) that it overrides in several ways:



有时你可能想缩小方法参数或实例变量的类型范围。
这违反了正常规则，
类似于向下转型，可能在运行时导致类型错误。
不过，如果代码能保证不会发生类型错误，
缩小类型范围仍然是可行的。
在这种情况下，你可以在参数声明中使用
[`covariant` 关键字](/language/type-system#covariant-keyword)。
有关详细信息，请参阅
[Dart 语言规范][Dart language specification]。

* The return type must be the same type as (or a subtype of)
  the overridden method's return type.
* Parameter types must be the same type as (or a supertype of)
  the overridden method's parameter types.
  In the preceding example, the `contrast` setter of `SmartTelevision`
  changes the parameter type from `int` to a supertype, `num`.
* If the overridden method accepts _n_ positional parameters,
  then the overriding method must also accept _n_ positional parameters.
* A [generic method][] can't override a non-generic one,
  and a non-generic method can't override a generic one.



如果你重写了 `==`，你也应该重写 Object 的 `hashCode` getter。
有关重写 `==` 和 `hashCode` 的示例，请查看
[实现 map 键](/libraries/dart-core#implementing-map-keys)。
:::

Sometimes you might want to narrow the type of
a method parameter or an instance variable.
This violates the normal rules, and
it's similar to a downcast in that it can cause a type error at runtime.
Still, narrowing the type is possible
if the code can guarantee that a type error won't occur.
In this case, you can use the
[`covariant` keyword](/language/type-system#covariant-keyword)
in a parameter declaration.
For details, see the
[Dart language specification][].



要在代码尝试使用不存在的方法或实例变量时进行检测或做出反应，
你可以重写 `noSuchMethod()`：

:::warning
If you override `==`, you should also override Object's `hashCode` getter.
For an example of overriding `==` and `hashCode`, check out
[Implementing map keys](/libraries/dart-core#implementing-map-keys).
:::

## noSuchMethod()



除非满足以下条件**之一**，否则你**无法调用**未实现的方法：

To detect or react whenever code attempts to use a non-existent method or
instance variable, you can override `noSuchMethod()`:



* 接收者的静态类型为 `dynamic`。

<?code-excerpt "misc/lib/language_tour/classes/no_such_method.dart (no-such-method-impl)" replace="/noSuchMethod(?!,)/[!$&!]/g"?>
```dart
class A {
  // Unless you override noSuchMethod, using a
  // non-existent member results in a NoSuchMethodError.
  @override
  void [!noSuchMethod!](Invocation invocation) {
    print(
      'You tried to use a non-existent member: '
      '${invocation.memberName}',
    );
  }
}
```

You **can't invoke** an unimplemented method unless
**one** of the following is true:



* 接收者的静态类型定义了该未实现的方法（抽象方法也可以），
并且接收者的动态类型有一个与 `Object` 类中不同的
`noSuchMethod()` 实现。

* The receiver has the static type `dynamic`.



有关更多信息，请参阅非正式的
[noSuchMethod 转发规范]({{site.repo.dart.lang}}/blob/main/archive/feature-specifications/nosuchmethod-forwarding.md)。

* The receiver has a static type that
defines the unimplemented method (abstract is OK),
and the dynamic type of the receiver has an implementation of `noSuchMethod()`
that's different from the one in class `Object`.

For more information, see the informal
[noSuchMethod forwarding specification.]({{site.repo.dart.lang}}/blob/main/archive/feature-specifications/nosuchmethod-forwarding.md)

[parameterized types]: /language/generics#restricting-the-parameterized-type
[operators]: /language/methods#operators
[generic method]: /language/generics#using-generic-methods
[Dart language specification]: /resources/language/spec
