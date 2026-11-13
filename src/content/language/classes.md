---
# title: Classes
title: 类
# description: Summary of classes, class instances, and their members.
description: "类、类实例及其成员概述。"
ai-translated: true
prevpage:
  url: /language/error-handling
# title: Error handling
  title: 错误处理
nextpage:
  url: /language/constructors
# title: Constructors
  title: 构造函数
---

<?code-excerpt replace="/ *\/\/\s+ignore_for_file:[^\n]+\n//g; /(^|\n) *\/\/\s+ignore:[^\n]+\n/$1/g; /(\n[^\n]+) *\/\/\s+ignore:[^\n]+\n/$1\n/g; / *\/\/\s+ignore:[^\n]+//g; /([A-Z]\w*)\d\b/$1/g"?>

Dart is an object-oriented language with classes and mixin-based
inheritance. Every object is an instance of a class, and all classes
except `Null` descend from [`Object`][].
*Mixin-based inheritance* means that although every class
(except for the [top class][top-and-bottom], `Object?`)
has exactly one superclass, a class body can be reused in
multiple class hierarchies.
[Extension methods][] are a way to
add functionality to a class without changing the class or creating a subclass.
[Class modifiers][] allow you to control how libraries can subtype a class.

Dart 是一门面向对象的语言，带有类以及基于 mixin 的继承。
每个对象都是某个类的实例，除 `Null` 以外的所有类都继承自 [`Object`][]。
**基于 mixin 的继承** 意味着：虽然每个类
（除了 [顶类型][top-and-bottom] `Object?`）
都恰好有一个超类，但类体可以在多个类层次中复用。
[Extension 方法][Extension methods] 可以在不修改类、也不创建子类的情况下，
为类增加功能。
[类修饰符][Class modifiers] 让你控制库可以如何对类派生子类型。


## Using class members

## 使用类成员

Objects have *members* consisting of functions and data (*methods* and
*instance variables*, respectively). When you call a method, you *invoke*
it on an object: the method has access to that object's functions and
data.

对象拥有由函数和数据组成的 **成员**
（分别是 **方法** 和 **实例变量**）。
调用方法时，你是在某个对象上 **调用** 它：
方法可以访问该对象的函数和数据。

Use a dot (`.`) to refer to an instance variable or method:

使用点号（`.`）引用实例变量或方法：

<?code-excerpt "misc/test/language_tour/classes_test.dart (object-members)"?>
```dart
var p = Point(2, 2);

// Get the value of y.
assert(p.y == 2);

// Invoke distanceTo() on p.
double distance = p.distanceTo(Point(4, 4));
```

Use `?.` instead of `.` to avoid an exception
when the leftmost operand is null:

当最左侧的操作数是 null 时，用 `?.` 代替 `.`，以避免异常：

<?code-excerpt "misc/test/language_tour/classes_test.dart (safe-member-access)"?>
```dart
// If p is non-null, set a variable equal to its y value.
var a = p?.y;
```


## Using constructors

## 使用构造函数

You can create an object using a *constructor*.
Constructor names can be either <code><em>ClassName</em></code> or
<code><em>ClassName</em>.<em>identifier</em></code>. For example,
the following code creates `Point` objects using the
`Point()` and `Point.fromJson()` constructors:

你可以用 **构造函数** 创建对象。
构造函数名可以是 <code>**类名**</code>，
也可以是 <code>**类名**.**标识符**</code>。
例如，下面的代码用 `Point()` 和 `Point.fromJson()` 构造函数创建 `Point` 对象：

<?code-excerpt "misc/test/language_tour/classes_test.dart (object-creation)" replace="/ as .*?;/;/g"?>
```dart
var p1 = Point(2, 2);
var p2 = Point.fromJson({'x': 1, 'y': 2});
```

The following code has the same effect, but
uses the optional `new` keyword before the constructor name:

下面的代码效果相同，但在构造函数名之前使用了可选的 `new` 关键字：

<?code-excerpt "misc/test/language_tour/classes_test.dart (object-creation-new)" replace="/ as .*?;/;/g"?>
```dart
var p1 = new Point(2, 2);
var p2 = new Point.fromJson({'x': 1, 'y': 2});
```

Some classes provide [constant constructors][].
To create a compile-time constant using a constant constructor,
put the `const` keyword before the constructor name:

有些类提供 [常量构造函数][constant constructors]。
要用常量构造函数创建编译时常量，
把 `const` 关键字放在构造函数名之前：

<?code-excerpt "misc/test/language_tour/classes_test.dart (const)"?>
```dart
var p = const ImmutablePoint(2, 2);
```

Constructing two identical compile-time constants results in a single,
canonical instance:

构造两个相同的编译时常量，会得到同一个规范化实例：

<?code-excerpt "misc/test/language_tour/classes_test.dart (identical)"?>
```dart
var a = const ImmutablePoint(1, 1);
var b = const ImmutablePoint(1, 1);

assert(identical(a, b)); // They are the same instance!
```

Within a _constant context_, you can omit the `const` before a constructor
or literal. For example, look at this code, which creates a const map:

在 **常量上下文** 中，构造函数或字面量前面的 `const` 可以省略。
例如，看下面这段创建 const 映射的代码：

<?code-excerpt "misc/test/language_tour/classes_test.dart (const-context-withconst)" replace="/pointAndLine1/pointAndLine/g"?>
```dart
// Lots of const keywords here.
const pointAndLine = const {
  'point': const [const ImmutablePoint(0, 0)],
  'line': const [const ImmutablePoint(1, 10), const ImmutablePoint(-2, 11)],
};
```

You can omit all but the first use of the `const` keyword:

除了第一次使用，其余的 `const` 关键字都可以省略：

<?code-excerpt "misc/test/language_tour/classes_test.dart (const-context-noconst)" replace="/pointAndLine2/pointAndLine/g"?>
```dart
// Only one const, which establishes the constant context.
const pointAndLine = {
  'point': [ImmutablePoint(0, 0)],
  'line': [ImmutablePoint(1, 10), ImmutablePoint(-2, 11)],
};
```

If a constant constructor is outside of a constant context
and is invoked without `const`,
it creates a **non-constant object**:

如果常量构造函数不在常量上下文中，并且调用时没有 `const`，
它会创建一个 **非常量对象**：

<?code-excerpt "misc/test/language_tour/classes_test.dart (nonconst-const-constructor)"?>
```dart
var a = const ImmutablePoint(1, 1); // Creates a constant
var b = ImmutablePoint(1, 1); // Does NOT create a constant

assert(!identical(a, b)); // NOT the same instance!
```


## Getting an object's type

## 获取对象的类型

To get an object's type at runtime,
you can use the `Object` property `runtimeType`,
which returns a [`Type`][] object.

要在运行时获取对象的类型，可以使用 `Object` 的 `runtimeType` 属性，
它返回一个 [`Type`][] 对象。

<?code-excerpt "misc/test/language_tour/classes_test.dart (runtime-type)"?>
```dart
print('The type of a is ${a.runtimeType}');
```

:::warning
Use a [type test operator][] rather than `runtimeType`
to test an object's type.
In production environments, the test `object is Type` is more stable
than the test `object.runtimeType == Type`.

测试对象类型时，请使用 [类型测试运算符][type test operator]，而不是 `runtimeType`。
在生产环境中，`object is Type` 这种测试
比 `object.runtimeType == Type` 更稳定。
:::

Up to here, you've seen how to _use_ classes.
The rest of this section shows how to _implement_ classes.

到这里，你已经看到如何 **使用** 类。
本节其余部分说明如何 **实现** 类。


## Instance variables

## 实例变量

Here's how you declare instance variables:

下面是声明实例变量的方式：

<?code-excerpt "misc/lib/language_tour/classes/point_with_main.dart (class)"?>
```dart
class Point {
  double? x; // Declare instance variable x, initially null.
  double? y; // Declare y, initially null.
  double z = 0; // Declare z, initially 0.
}
```

An uninitialized instance variable declared with a
[nullable type][] has the value `null`.
Non-nullable instance variables [must be initialized][] at declaration.

用 [可空类型][nullable type] 声明、且未初始化的实例变量，值为 `null`。
非可空实例变量在声明时 [必须初始化][must be initialized]。

All instance variables generate an implicit *getter* method.
Non-final instance variables and
`late final` instance variables without initializers also generate
an implicit *setter* method. For details,
check out [Getters and setters][].

所有实例变量都会生成隐式的 **getter** 方法。
非 final 实例变量，以及没有初始化器的 `late final` 实例变量，
还会生成隐式的 **setter** 方法。
详情见 [getter 和 setter][Getters and setters]。

<?code-excerpt "misc/lib/language_tour/classes/point_with_main.dart (class-main)" replace="/(double .*?;).*/$1/g" plaster="none"?>
```dart
class Point {
  double? x; // Declare instance variable x, initially null.
  double? y; // Declare y, initially null.
}

void main() {
  var point = Point();
  point.x = 4; // Use the setter method for x.
  assert(point.x == 4); // Use the getter method for x.
  assert(point.y == null); // Values default to null.
}
```

Initializing a non-`late` instance variable where it's declared
sets the value when the instance is created,
before the constructor and its initializer list execute.
As a result, the initializing expression (after the `=`)
of a non-`late` instance variable can't access `this`.

在声明处初始化非 `late` 实例变量时，值会在实例创建时设置，
早于构造函数及其初始化列表执行。
因此，非 `late` 实例变量的初始化表达式（`=` 后面的部分）不能访问 `this`。

<?code-excerpt "misc/lib/language_tour/classes/point_this.dart"?>
```dart
double initialX = 1.5;

class Point {
  // OK, can access declarations that do not depend on `this`:
  double? x = initialX;

  // ERROR, can't access `this` in non-`late` initializer:
  double? y = this.x;

  // OK, can access `this` in `late` initializer:
  late double? z = this.x;

  // OK, `this.x` and `this.y` are parameter declarations, not expressions:
  Point(this.x, this.y);
}
```

Instance variables can be `final`,
in which case they must be set exactly once.
Initialize `final`, non-`late` instance variables
at declaration,
using a constructor parameter, or
using a constructor's [initializer list][]:

实例变量可以是 `final`，此时必须恰好赋值一次。
要初始化 `final` 且非 `late` 的实例变量，可以在声明时进行，
也可以使用构造函数参数，
或者使用构造函数的 [初始化列表][initializer list]：

<?code-excerpt "misc/lib/effective_dart/usage_good.dart (field-init-at-decl)"?>
```dart
class ProfileMark {
  final String name;
  final DateTime start = DateTime.now();

  ProfileMark(this.name);
  ProfileMark.unnamed() : name = '';
}
```

If you need to assign the value of a `final` instance variable
after the constructor body starts, you can use one of the following:

如果需要在构造函数体开始执行之后再给 `final` 实例变量赋值，
可以用下面的办法之一：

* Compute the value in a [factory constructor][],
  then pass it to a generative constructor that
  initializes the `final` instance variable.

  在 [工厂构造函数][factory constructor] 中算出值，
  再把它传给生成构造函数，由后者初始化这个 `final` 实例变量。
* Use `late final`, but [_be careful:_][late-final-ivar]
  a `late final` without an initializer adds a setter to the API.

  使用 `late final`，但请 [**当心：**][late-final-ivar]
  没有初始化器的 `late final` 会给 API 增加一个 setter。

## Implicit interfaces

## 隐式接口

Every class implicitly defines an interface containing all the instance
members of the class and of any interfaces it implements. If you want to
create a class A that supports class B's API without inheriting B's
implementation, class A should implement the B interface.

每个类都隐式定义了一个接口，
其中包含该类及其所实现的任何接口的全部实例成员。
如果你想创建类 A，让它支持类 B 的 API，但不继承 B 的实现，
类 A 就应该实现 B 接口。

A class implements one or more interfaces by declaring them in an
`implements` clause and then providing the APIs required by the
interfaces. For example:

类通过在 `implements` 子句中声明一个或多个接口来实现它们，
然后提供这些接口所要求的 API。例如：

<?code-excerpt "misc/lib/language_tour/classes/impostor.dart"?>
```dart
// A person. The implicit interface contains greet().
class Person {
  // In the interface, but visible only in this library.
  final String _name;

  // Not in the interface, since this is a constructor.
  Person(this._name);

  // In the interface.
  String greet(String who) => 'Hello, $who. I am $_name.';
}

// An implementation of the Person interface.
class Impostor implements Person {
  String get _name => '';

  String greet(String who) => 'Hi $who. Do you know who I am?';
}

String greetBob(Person person) => person.greet('Bob');

void main() {
  print(greetBob(Person('Kathy')));
  print(greetBob(Impostor()));
}
```

Here's an example of specifying that a class implements multiple
interfaces:

下面的例子指定一个类实现多个接口：

<?code-excerpt "misc/lib/language_tour/classes/misc.dart (point-interfaces)"?>
```dart
class Point implements Comparable, Location {
  ...
}
```


## Class variables and methods

## 类变量和类方法

Use the `static` keyword to implement class-wide variables and methods.

使用 `static` 关键字实现类级别的变量和方法。

### Static variables

### 静态变量

Static variables (class variables) are useful for class-wide state and
constants:

静态变量（类变量）适用于类级别的状态和常量：

<?code-excerpt "misc/lib/language_tour/classes/misc.dart (static-field)"?>
```dart
class Queue {
  static const initialCapacity = 16;
  // ···
}

void main() {
  assert(Queue.initialCapacity == 16);
}
```

Static variables aren't initialized until they're used.

静态变量直到被使用时才会初始化。

:::note
This page follows the
[style guide recommendation](/effective-dart/style#identifiers)
of preferring `lowerCamelCase` for constant names.

本页遵循 [代码风格指南的建议](/effective-dart/style#identifiers)，
常量名优先使用 `lowerCamelCase`。
:::

### Static methods

### 静态方法

Static methods (class methods) don't operate on an instance, and thus
don't have access to `this`.
They do, however, have access to static variables.
As the following example shows,
you invoke static methods directly on a class:

静态方法（类方法）不在实例上操作，因此不能访问 `this`。
不过它们可以访问静态变量。
正如下面的例子所示，你直接在类上调用静态方法：

<?code-excerpt "misc/lib/language_tour/classes/point_with_distance_method.dart"?>
```dart
import 'dart:math';

class Point {
  double x, y;
  Point(this.x, this.y);

  static double distanceBetween(Point a, Point b) {
    var dx = a.x - b.x;
    var dy = a.y - b.y;
    return sqrt(dx * dx + dy * dy);
  }
}

void main() {
  var a = Point(2, 2);
  var b = Point(4, 4);
  var distance = Point.distanceBetween(a, b);
  assert(2.8 < distance && distance < 2.9);
  print(distance);
}
```

:::note
Consider using top-level functions, instead of static methods, for
common or widely used utilities and functionality.

对于常用或广泛使用的工具和功能，
考虑使用顶层函数，而不是静态方法。
:::

You can use static methods as compile-time constants. For example, you
can pass a static method as a parameter to a constant constructor.

你可以把静态方法当作编译时常量使用。
例如，可以把静态方法作为参数传给常量构造函数。


[`Object`]: {{site.dart-api}}/dart-core/Object-class.html
[top-and-bottom]: /null-safety/understanding-null-safety#top-and-bottom
[Extension methods]: /language/extension-methods
[Class modifiers]: /language/class-modifiers
[constant constructors]: /language/constructors#constant-constructors
[`Type`]: {{site.dart-api}}/dart-core/Type-class.html
[type test operator]: /language/operators#type-test-operators
[Getters and setters]: /language/methods#getters-and-setters
[initializer list]: /language/constructors#use-an-initializer-list
[factory constructor]: /language/constructors#factory-constructors
[late-final-ivar]: /effective-dart/design#avoid-public-late-final-fields-without-initializers
[nullable type]: /null-safety/understanding-null-safety#using-nullable-types
[must be initialized]: /null-safety/understanding-null-safety#uninitialized-variables
