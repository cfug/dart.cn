---
# title: Enumerated types
title: Enumerated types
# description: Learn about the enum type in Dart.
description: Learn about the enum type in Dart.
# shortTitle: Enums
shortTitle: Enums
prevpage:
  url: /language/mixins
  title: Mixins
nextpage:
  url: /language/dot-shorthands
  title: Dot shorthands
---

Enumerated types, often called _enumerations_ or _enums_,
are a special kind of class used to represent
a fixed number of constant values.



枚举类型，通常称为 _enumerations_ 或 _enums_，
是一种特殊的类，用于表示固定数量的常量值。

:::note
All enums automatically extend the [`Enum`][] class.
They are also sealed,
meaning they cannot be subclassed, implemented, mixed in,
or otherwise explicitly instantiated.

Abstract classes and mixins can explicitly implement or extend `Enum`,
but unless they are then implemented by or mixed into an enum declaration,
no objects can actually implement the type of that class or mixin.
:::



所有枚举都自动扩展 [`Enum`][] 类。
它们也是密封的，
这意味着它们不能被子类化、实现、混入，
或以其他方式显式实例化。

## Declaring simple enums



抽象类和 mixin 可以显式实现或扩展 `Enum`，
但除非它们随后被枚举声明实现或混入，
否则没有对象可以真正实现该类或 mixin 的类型。
:::

To declare a simple enumerated type,
use the `enum` keyword and
list the values you want to be enumerated:



## 声明简单枚举

<?code-excerpt "misc/lib/language_tour/classes/enum.dart (enum)"?>
```dart
enum Color { red, green, blue }
```

:::tip
You can also use [trailing commas][] when declaring an enumerated type
to help prevent copy-paste errors.
:::

## Declaring enhanced enums



要声明一个简单的枚举类型，
使用 `enum` 关键字并列出你想要枚举的值：

Dart also allows enum declarations to declare classes
with fields, methods, and const constructors
which are limited to a fixed number of known constant instances.



在声明枚举类型时，你也可以使用[尾随逗号][trailing commas]
来帮助防止复制粘贴错误。
:::

To declare an enhanced enum,
follow a syntax similar to normal [classes][],
but with a few extra requirements:



## 声明增强枚举

* Instance variables must be `final`,
  including those added by [mixins][].
* All [generative constructors][] must be constant.
* [Factory constructors][] can only return
  one of the fixed, known enum instances.
* No other class can be extended as [`Enum`] is automatically extended.
* There cannot be overrides for `index`, `hashCode`, the equality operator `==`.
* A member named `values` cannot be declared in an enum,
  as it would conflict with the automatically generated static `values` getter.
* All instances of the enum must be declared
  in the beginning of the declaration,
  and there must be at least one instance declared.



Dart 还允许枚举声明来声明具有字段、方法和 const 构造函数的类，
这些类被限制为固定数量的已知常量实例。

Instance methods in an enhanced enum can use `this` to
reference the current enum value.



要声明一个增强枚举，
遵循与普通[类][classes]类似的语法，
但有一些额外的要求：

Here is an example that declares an enhanced enum
with multiple instances, instance variables,
getters, and an implemented interface:



* 实例变量必须是 `final` 的，
  包括由 [mixin][mixins] 添加的变量。
* 所有[生成式构造函数][generative constructors]必须是常量。
* [工厂构造函数][Factory constructors]只能返回
  固定的、已知的枚举实例之一。
* 不能扩展其他类，因为 [`Enum`] 是自动扩展的。
* 不能重写 `index`、`hashCode` 和相等运算符 `==`。
* 不能在枚举中声明名为 `values` 的成员，
  因为它会与自动生成的静态 `values` getter 冲突。
* 枚举的所有实例必须在声明的开头声明，
  并且必须至少声明一个实例。

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



增强枚举中的实例方法可以使用 `this` 来引用当前的枚举值。

final int tires;
  final int passengers;
  final int carbonPerKilometer;



下面是一个声明增强枚举的示例，
包含多个实例、实例变量、getter 和实现的接口：

int get carbonFootprint => (carbonPerKilometer / passengers).round();



增强枚举需要至少 2.17 的[语言版本][language version]。
:::

bool get isTwoWheeled => this == Vehicle.bicycle;



## 使用枚举

@override
  int compareTo(Vehicle other) => carbonFootprint - other.carbonFootprint;
}
```



像访问任何其他[静态变量][static variable]一样访问枚举值：

:::version-note
Enhanced enums require a [language version][] of at least 2.17.
:::

## Using enums



枚举中的每个值都有一个 `index` getter，
它返回该值在枚举声明中从零开始的位置。
例如，第一个值的索引是 0，第二个值的索引是 1。

Access the enumerated values like
any other [static variable][]:



要获取所有枚举值的列表，请使用枚举的 `values` 常量。

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



你可以在 [switch 语句][switch statements]中使用枚举，
如果你没有处理所有枚举值，你会收到警告：

<?code-excerpt "misc/lib/language_tour/classes/enum.dart (index)"?>
```dart
assert(Color.red.index == 0);
assert(Color.green.index == 1);
assert(Color.blue.index == 2);
```

To get a list of all the enumerated values,
use the enum's `values` constant.



如果你需要访问枚举值的名称，
例如从 `Color.blue` 获取 `'blue'`，
请使用 `.name` 属性：

<?code-excerpt "misc/lib/language_tour/classes/enum.dart (values)"?>
```dart
List<Color> colors = Color.values;
assert(colors[2] == Color.blue);
```

You can use enums in [switch statements][], and
you'll get a warning if you don't handle all of the enum's values:



你可以像访问普通对象一样访问枚举值的成员：

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

<?code-excerpt "misc/lib/language_tour/classes/enum.dart (name)"?>
```dart
print(Color.blue.name); // 'blue'
```

You can access a member of an enum value
like you would on a normal object:

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
[language version]: /resources/language/evolution#language-versioning
[static variable]: /language/classes#class-variables-and-methods
[switch statements]: /language/branches#switch
