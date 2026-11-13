---
# title: Enumerated types
title: 枚举
# description: Learn about the enum type in Dart.
description: 了解 Dart 中的枚举类型。
# shortTitle: Enums
shortTitle: 枚举
prevpage:
  url: /language/mixins
  # title: Mixins
  title: 混入 (Mixin)
nextpage:
  url: /language/dot-shorthands
  # title: Dot shorthands
  title: 点的简写
ai-translated: true
---

Enumerated types, often called _enumerations_ or _enums_,
are a special kind of class used to represent
a fixed number of constant values.

枚举类型常称为 **enumeration** 或 **enum**，
是一种特殊的类，用来表示
固定数量的常量值。

:::note
All enums automatically extend the [`Enum`][] class.
They are also sealed,
meaning they cannot be subclassed, implemented, mixed in,
or otherwise explicitly instantiated.

所有枚举都会自动扩展 [`Enum`][`Enum`] 类。
它们也是密封的，
不能被派生子类、实现或 mixin，
也不能以其他方式显式实例化。

Abstract classes and mixins can explicitly implement or extend `Enum`,
but unless they are then implemented by or mixed into an enum declaration,
no objects can actually implement the type of that class or mixin.

抽象类和 mixin 可以显式实现或扩展 `Enum`，
但除非随后有枚举声明去实现它们，或把它们 mixin 进去，
否则实际上不会有对象实现该类或 mixin 的类型。

:::

## Declaring simple enums

## 声明简单枚举

To declare a simple enumerated type,
use the `enum` keyword and
list the values you want to be enumerated:

要声明一个简单的枚举类型，
使用 `enum` 关键字，并列出
想要枚举的值：

<?code-excerpt "misc/lib/language_tour/classes/enum.dart (enum)"?>
```dart
enum Color { red, green, blue }
```

:::tip
You can also use [trailing commas][] when declaring an enumerated type
to help prevent copy-paste errors.

声明枚举类型时也可以使用 [尾随逗号][trailing commas]，
以帮助避免复制粘贴时出错。

:::

## Declaring enhanced enums

## 声明增强型枚举

:::version-note
Enhanced enums require a [language version][] of at least 2.17.

增强型枚举要求 [语言版本][language version] 至少为 2.17。

:::

Dart also allows enum declarations to declare classes
with fields, methods, and const constructors
which are limited to a fixed number of known constant instances.

Dart 也支持在枚举声明里定义带有字段、方法和常量构造函数的类，
但已知的常量实例数量是固定的。

To declare an enhanced enum,
follow a syntax similar to normal [classes][],
but with a few extra requirements:

声明增强型枚举时，语法与普通 [类][classes] 相似，
但多了几项额外要求：

* Instance variables must be `final`,
  including those added by [mixins][].

  实例变量必须是 `final`，
  包括由 [mixin][mixins] 加入的实例变量。

* All [generative constructors][] must be constant.

  所有 [生成构造函数][generative constructors] 都必须是常量。

* [Factory constructors][] can only return
  one of the fixed, known enum instances.

  [工厂构造函数][Factory constructors] 只能返回
  某一个固定且已知的枚举实例。

* No other class can be extended as [`Enum`] is automatically extended.

  不能再扩展其他类，因为会自动扩展 [`Enum`][`Enum`]。

* There cannot be overrides for `index`, `hashCode`, the equality operator `==`.

  不能重写 `index`、`hashCode` 和相等操作符 `==`。

* A member named `values` cannot be declared in an enum,
  as it would conflict with the automatically generated static `values` getter.

  不能在枚举中声明名为 `values` 的成员，
  因为它会与自动生成的静态 `values` getter 冲突。

* All instances of the enum must be declared
  in the beginning of the declaration,
  and there must be at least one instance declared.

  枚举的所有实例都必须声明在声明的开头，
  并且至少要声明一个实例。

Instance methods in an enhanced enum can use `this` to
reference the current enum value.

增强型枚举中的实例方法可以用 `this`
引用当前的枚举值。

Here is an example that declares an enhanced enum
with multiple instances, instance variables,
getters, and an implemented interface:

下面的例子声明了一个增强型枚举，
它有多个实例、实例变量、
getter，并实现了一个接口：

<?code-excerpt "misc/lib/language_tour/classes/enum.dart (enhanced)"?>
```dart
enum Vehicle implements Comparable<Vehicle> {
  car(tires: 4, passengers: 5, carbonPerKilometer: 400),
  bus(tires: 6, passengers: 50, carbonPerKilometer: 800),
  bicycle(tires: 2, passengers: 1, carbonPerKilometer: 0);

  const Vehicle({
    required this.tires,
    required this.passengers,
    required this.carbonPerKilometer,
  });

  final int tires;
  final int passengers;
  final int carbonPerKilometer;

  int get carbonFootprint => (carbonPerKilometer / passengers).round();

  bool get isTwoWheeled => this == Vehicle.bicycle;

  @override
  int compareTo(Vehicle other) => carbonFootprint - other.carbonFootprint;
}
```

:::tip
In Dart 3.13 and later,
you can declare enhanced enums even more concisely
using [primary constructors][]:

在 Dart 3.13 及更高版本中，
你可以用 [主构造函数][primary constructors]
更简洁地声明增强型枚举：

<?code-excerpt "language/lib/primary_constructors/enum.dart (enhanced-primary)"?>
```dart
enum Vehicle(
  final int tires,
  final int passengers,
  final int carbonPerKilometer,
) implements Comparable<Vehicle> {
  car(4, 5, 400),
  bus(6, 50, 800),
  bicycle(2, 1, 0);

  int get carbonFootprint => (carbonPerKilometer / passengers).round();

  bool get isTwoWheeled => this == Vehicle.bicycle;

  @override
  int compareTo(Vehicle other) => carbonFootprint - other.carbonFootprint;
}
```
:::

[language version]: /language/versioning
[primary constructors]: /language/primary-constructors

## Using enums

## 使用枚举

Access the enumerated values like
any other [static variable][]:

访问枚举值的方式与访问其他 [静态变量][static variable] 一样：

<?code-excerpt "misc/lib/language_tour/classes/enum.dart (access)"?>
```dart
final favoriteColor = Color.blue;
if (favoriteColor == Color.blue) {
  print('Your favorite color is blue!');
}
```

Each value in an enum has an `index` getter,
which returns the zero-based position of the value in the enum declaration.
For example, the first value has index 0,
and the second value has index 1.

枚举中的每个值都有一个 `index` getter，
返回该值在枚举声明中从零开始的位置。
例如，第一个值的 index 是 0，
第二个值的 index 是 1。

<?code-excerpt "misc/lib/language_tour/classes/enum.dart (index)"?>
```dart
assert(Color.red.index == 0);
assert(Color.green.index == 1);
assert(Color.blue.index == 2);
```

To get a list of all the enumerated values,
use the enum's `values` constant.

要获取所有枚举值的列表，
使用枚举的 `values` 常量。

<?code-excerpt "misc/lib/language_tour/classes/enum.dart (values)"?>
```dart
List<Color> colors = Color.values;
assert(colors[2] == Color.blue);
```

You can use enums in [switch statements][], and
you'll get a warning if you don't handle all of the enum's values:

你可以在 [switch 语句][switch statements] 里使用枚举，
如果没有处理枚举的全部值，就会得到一条警告：

<?code-excerpt "misc/lib/language_tour/classes/enum.dart (switch)"?>
```dart
var aColor = Color.blue;

switch (aColor) {
  case Color.red:
    print('Red as roses!');
  case Color.green:
    print('Green as grass!');
  default: // Without this, you see a WARNING.
    print(aColor); // 'Color.blue'
}
```

If you need to access the name of an enumerated value,
such as `'blue'` from `Color.blue`,
use the `.name` property:

如果需要访问枚举值的名字，
例如从 `Color.blue` 得到 `'blue'`，
使用 `.name` 属性：

<?code-excerpt "misc/lib/language_tour/classes/enum.dart (name)"?>
```dart
print(Color.blue.name); // 'blue'
```

You can access a member of an enum value
like you would on a normal object:

访问枚举值的成员时，
方式和访问普通对象一样：

<?code-excerpt "misc/lib/language_tour/classes/enum.dart (method-call)"?>
```dart
print(Vehicle.car.carbonFootprint);
```

[`Enum`]: {{site.dart-api}}/dart-core/Enum-class.html
[trailing commas]: /language/collections#lists
[classes]: /language/classes
[mixins]: /language/mixins
[generative constructors]: /language/constructors#constant-constructors
[Factory constructors]: /language/constructors#factory-constructors
[static variable]: /language/classes#class-variables-and-methods
[switch statements]: /language/branches#switch
