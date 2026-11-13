---
# title: Class modifiers
title: 类修饰符
# description: >-
#   Modifier keywords for class declarations to control external library access.
description: "用于类声明的修饰符关键字，用来控制库外部的访问。"
ai-translated: true
prevpage:
  url: /language/callable-objects
# title: Callable objects
  title: 可调用对象
nextpage:
  url: /language/class-modifiers-for-apis
# title: Class modifiers for API maintainers
  title: 面向 API 维护者的类修饰符
---

<?code-excerpt replace="/ *\/\/\s+ignore_for_file:[^\n]+\n//g; /(^|\n) *\/\/\s+ignore: (stable|beta|dev)[^\n]+\n/$1/g; /(\n[^\n]+) *\/\/\s+ignore: (stable|beta|dev)[^\n]+\n/$1\n/g; /. • (lib|test)\/\w+\.dart:\d+:\d+//g"?>

:::version-note
Class modifiers, besides `abstract`, require
a [language version][] of at least 3.0.

类修饰符（除 `abstract` 外）要求 [语言版本][language version] 至少为 3.0。
:::

Class modifiers control how a class or mixin can be used, both
[from within its own library](#abstract), and
from outside the library where it's defined.

类修饰符控制类或 mixin 可以如何使用，
既包括 [在它自己的库内](#abstract)，
也包括在定义它的库之外。

Modifier keywords come before a class or mixin declaration.
For example, writing `abstract class` defines an abstract class.
The full set of modifiers that can appear before a class declaration include:

修饰符关键字写在类或 mixin 声明之前。
例如，写成 `abstract class` 就定义了一个抽象类。
可以出现在类声明之前的全部修饰符包括：

- `abstract`
- `base`
- `final`
- `interface`
- `sealed`
- [`mixin`][class, mixin, or mixin class]

Only the `base` modifier can appear before a mixin declaration.
The modifiers do not apply to other declarations like
`enum`, `typedef`, `extension`, or `extension type`.

只有 `base` 修饰符可以出现在 mixin 声明之前。
这些修饰符不适用于 `enum`、`typedef`、
`extension` 或 `extension type` 等其它声明。

When deciding whether to use class modifiers,
consider the intended uses of the class and
what behaviors the class needs to be able to rely on.

决定是否使用类修饰符时，
要考虑这个类的预期用途，
以及这个类需要能够依赖哪些行为。

:::tip
If you're already familiar with Dart's class modifiers and just want
an outline or refresher of their behavior when combined,
check out the [Class modifier reference][].

如果你已经熟悉 Dart 的类修饰符，
只想要一份它们组合之后行为的提纲或回顾，
请查看 [类修饰符参考][Class modifier reference]。

If you maintain a library,
read the [Class modifiers for API maintainers][] page for
guidance on how to navigate these changes for your libraries.

如果你在维护一个库，
请阅读 [面向 API 维护者的类修饰符][Class modifiers for API maintainers]，
了解这些变更对你的库有什么影响。
:::

[Class modifier reference]: /language/modifier-reference
[Class modifiers for API maintainers]: /language/class-modifiers-for-apis

## No modifier

## 无修饰符

To allow unrestricted permission to construct or subtype from any library,
use a `class` or `mixin` declaration without a modifier. By default, you can:

若希望任意库都能不受限制地构造或派生子类型，
使用不带修饰符的 `class` 或 `mixin` 声明。默认情况下，你可以：

- [Construct][] new instances of a class.

  用 [构造函数][Construct] 创建类的新实例。
- [Extend][] a class to create a new subtype.

  [扩展][Extend] 类以创建新的子类型。
- [Implement][] a class or mixin's interface.

  [实现][Implement] 类或 mixin 的接口。
- [Mix in][mixin] a mixin or mixin class.

  将 mixin 或 mixin 类 [混入][mixin]。

## `abstract`

## `abstract` 修饰符

To define a class that doesn't require a full, concrete implementation of
its entire interface, use the `abstract` modifier.

若要定义一个不需要完整、具体地实现其全部接口的类，
使用 `abstract` 修饰符。

Abstract classes cannot be constructed from any library, whether its own or
an outside library. Abstract classes often have [abstract methods][].

无论是在它自己的库还是外部库中，都不能构造抽象类。
抽象类通常包含 [抽象方法][abstract methods]。

<?code-excerpt "language/lib/class_modifiers/ex1/a.dart"?>
```dart title="a.dart"
abstract class Vehicle {
  void moveForward(int meters);
}
```

<?code-excerpt "language/lib/class_modifiers/ex1/b.dart (abstract-usages)"?>
```dart title="b.dart"
import 'a.dart';

// Error: `Vehicle` can't be instantiated because
// it is marked as `abstract`.
Vehicle myVehicle = Vehicle();

// Can be extended.
class Car extends Vehicle {
  int passengers = 4;

  @override
  void moveForward(int meters) {
    // ...
  }
}

// Can be implemented.
class MockVehicle implements Vehicle {
  @override
  void moveForward(int meters) {
    // ...
  }
}
```

If you want your abstract class to appear to be instantiable,
define a [factory constructor][].

如果你希望抽象类看起来可以被实例化，
就定义一个 [工厂构造函数][factory constructor]。

## `base`

## `base` 修饰符

To enforce inheritance of a class or mixin's implementation,
use the `base` modifier.
A base class disallows implementation outside of its own library.
This guarantees:

若要强制继承类或 mixin 的实现，使用 `base` 修饰符。
`base` 类不允许在它自己的库之外被实现。
这可以保证：

- The base class constructor is called whenever
  an instance of a subtype of the class is created.

  每当创建该类子类型的实例时，都会调用 `base` 类的构造函数。
- All implemented private members exist in subtypes.

  所有已实现的私有成员都存在于子类型中。
- A new implemented member in a `base` class does not break subtypes,
  since all subtypes inherit the new member.

  在 `base` 类中新增已实现的成员不会破坏子类型，
  因为所有子类型都会继承这个新成员。
  - This is true unless the subtype already declares a member with
    the same name and an incompatible signature.

    除非子类型已经声明了同名且签名不兼容的成员。

You must mark any class that implements or extends a base class as
`base`, `final`, or `sealed`. This prevents outside libraries from
breaking the base class guarantees.

任何实现或扩展 `base` 类的类，都必须标记为
`base`、`final` 或 `sealed`。
这可以防止外部库破坏 `base` 类的这些保证。

<?code-excerpt "language/lib/class_modifiers/ex2/a.dart"?>
```dart title="a.dart"
base class Vehicle {
  void moveForward(int meters) {
    // ...
  }
}
```

<?code-excerpt "language/lib/class_modifiers/ex2/b.dart"?>
```dart title="b.dart"
import 'a.dart';

// Can be constructed.
Vehicle myVehicle = Vehicle();

// Can be extended.
base class Car extends Vehicle {
  int passengers = 4;
  // ...
}

// ERROR: `Vehicle` can't be implemented in a different library because
// it is marked with `base`.
base class MockVehicle implements Vehicle {
  @override
  void moveForward() {
    // ...
  }
}
```

## `interface`

## `interface` 修饰符

To define an interface, use the `interface` modifier.
Libraries outside of the interface's own defining library can
implement the interface, but not extend it.
This guarantees:

若要定义接口，使用 `interface` 修饰符。
定义该接口的库之外的库可以实现该接口，但不能扩展它。
这可以保证：

- When one of the class's instance methods calls
  another instance method on `this`, it will always
  invoke a known implementation of the method from the same library.

  当该类的某个实例方法在 `this` 上调用另一个实例方法时，
  它总会调用同一库中该方法的已知实现。
- Other libraries can't override methods that the interface
  class's own methods might later call in unexpected ways.
  This reduces the [fragile base class problem][].

  其它库不能覆盖接口类自己的方法以后可能以意想不到的方式调用的那些方法。
  这减轻了 [脆弱基类问题][fragile base class problem]。

<?code-excerpt "language/lib/class_modifiers/ex3/a.dart"?>
```dart title="a.dart"
interface class Vehicle {
  void moveForward(int meters) {
    // ...
  }
}
```

<?code-excerpt "language/lib/class_modifiers/ex3/b.dart"?>
```dart title="b.dart"
import 'a.dart';

// Can be constructed.
Vehicle myVehicle = Vehicle();

// ERROR: `Vehicle` can't be extended in a different library because
// it is marked with `interface`.
class Car extends Vehicle {
  int passengers = 4;
  // ...
}

// Can be implemented.
class MockVehicle implements Vehicle {
  @override
  void moveForward(int meters) {
    // ...
  }
}
```

### `abstract interface`

### `abstract interface` 组合

The most common use for the `interface` modifier is to define a pure interface. 
[Combine](#combining-modifiers) the `interface` and [`abstract`](#abstract)
modifiers for an `abstract interface class`.

`interface` 修饰符最常见的用途是定义纯接口。
把 `interface` 和 [`abstract`](#abstract)
[组合](#combining-modifiers) 起来，
得到 `abstract interface class`。

Like an `interface` class, other libraries can
implement, but can't inherit, a pure interface.
Like an `abstract` class, a pure interface can have abstract members.

和 `interface` 类一样，其它库可以实现纯接口，但不能继承它。
和 `abstract` 类一样，纯接口可以有抽象成员。

## `final` 

## `final` 修饰符

To close the type hierarchy, use the `final` modifier.
This prevents subtyping from a class outside of the current library. 
Disallowing both inheritance and implementation prevents subtyping entirely.
This guarantees:

若要封闭类型层次，使用 `final` 修饰符。
这可以阻止从当前库之外对该类派生子类型。
同时禁止继承和实现，就完全阻止了子类型化。
这可以保证：

- You can safely add incremental changes to the API.

  你可以安全地对 API 做增量修改。
- You can call instance methods knowing that they haven't been overwritten in
  a third-party subclass.

  你可以调用实例方法，并确信它们没有在第三方子类中被覆盖。

Final classes can be extended or implemented within the same library.
The `final` modifier encompasses the effects of `base`, and
therefore any subclasses must also be marked `base`, `final`, or `sealed`.

`final` 类可以在同一个库内被扩展或实现。
`final` 修饰符涵盖了 `base` 的效果，
因此任何子类也必须标记为 `base`、`final` 或 `sealed`。

<?code-excerpt "language/lib/class_modifiers/ex4/a.dart"?>
```dart title="a.dart"
final class Vehicle {
  void moveForward(int meters) {
    // ...
  }
}
```

<?code-excerpt "language/lib/class_modifiers/ex4/b.dart"?>
```dart title="b.dart"
import 'a.dart';

// Can be constructed.
Vehicle myVehicle = Vehicle();

// ERROR: `Vehicle` can't be extended in a different library
// because it is marked `final`.
class Car extends Vehicle {
  int passengers = 4;
  // ...
}

// ERROR: `Vehicle` can't be implemented in a different library because
// it is marked `final`.
class MockVehicle implements Vehicle {
  @override
  void moveForward(int meters) {
    // ...
  }
}
```

## `sealed`

## `sealed` 修饰符

To create a known, enumerable set of subtypes, use the `sealed` modifier.
This allows you to create a switch over those subtypes that
is statically ensured to be [_exhaustive_][exhaustive].

若要创建一组已知、可枚举的子类型，使用 `sealed` 修饰符。
这样你就可以针对这些子类型编写 switch，
并在静态上保证它是 [**穷尽的**][exhaustive]。

The `sealed` modifier prevents a class from being extended or
implemented outside its own library. Sealed classes are implicitly
[abstract](#abstract).

`sealed` 修饰符阻止类在它自己的库之外被扩展或实现。
sealed 类隐式地也是 [abstract](#abstract)。

- They cannot be constructed themselves.

  它们自身不能被构造。
- They can have [factory constructors](/language/constructors#factory-constructors).

  它们可以有 [工厂构造函数](/language/constructors#factory-constructors)。
- They can define constructors for their subclasses to use.

  它们可以为子类定义构造函数。

Subclasses of sealed classes are, however, not implicitly abstract.

不过，sealed 类的子类并不会隐式地变成抽象类。

The compiler is aware of any possible direct subtypes
because they can only exist in the same library. 
This allows the compiler to alert you when a switch does not
exhaustively handle all possible subtypes in its cases:

编译器知道所有可能的直接子类型，
因为它们只能存在于同一个库中。
因此，当 switch 的各个 case 没有穷尽处理所有可能的子类型时，
编译器会提醒你：

<?code-excerpt "language/lib/class_modifiers/ex5/sealed.dart"?>
```dart
sealed class Vehicle {}

class Car extends Vehicle {}

class Truck implements Vehicle {}

class Bicycle extends Vehicle {}

// ERROR: `Vehicle` can't be instantiated because
// it is marked `sealed` and therefore, implicitly abstract.
Vehicle myVehicle = Vehicle();

// Subclasses of a sealed class can be instantiated unless also restricted.
Vehicle myCar = Car();

extension VehicleSounds on Vehicle {
  String get sound {
    // ERROR: The switch does not exhaustively account for
    // all possible objects of type `Vehicle`.
    // In this example, a `Vehicle` with a run-time type of `Bicycle`
    // would not match any of the cases.
    return switch (this) {
      Car() => 'vroom',
      Truck() => 'VROOOOMM',
    };
  }
}
```

If you don't want [exhaustive switching][exhaustive], 
or want to be able to add subtypes later without breaking the API, 
use the [`final`](#final) modifier. For a more in depth comparison,
read [`sealed` versus `final`](/language/class-modifiers-for-apis#sealed-versus-final).

如果你不需要 [穷尽的 switch][exhaustive]，
或者希望以后添加子类型时不破坏 API，
就使用 [`final`](#final) 修饰符。更深入的比较见
[`sealed` 与 `final`](/language/class-modifiers-for-apis#sealed-versus-final)。

## Combining modifiers

## 组合修饰符

You can combine some modifiers for layered restrictions. 
A class declaration can be, in order:

你可以把一些修饰符组合起来，形成分层的限制。
类声明可以按以下顺序包含：

1. (Optional) `abstract`, describing whether the class can
   contain abstract members and prevents instantiation.

   （可选）`abstract`，说明该类是否可以包含抽象成员，并阻止实例化。
2. (Optional) One of `base`, `interface`, `final` or `sealed`, describing
   restrictions on other libraries subtyping the class.

   （可选）`base`、`interface`、`final` 或 `sealed` 之一，
   说明其它库对该类派生子类型时的限制。
3. (Optional) `mixin`, describing whether the declaration can be mixed in.

   （可选）`mixin`，说明该声明是否可以被混入。
4. The `class` keyword itself.

   `class` 关键字本身。

You can't combine some modifiers because they are
contradictory, redundant, or otherwise mutually exclusive:

有些修饰符不能组合，因为它们相互矛盾、重复，或者彼此互斥：

* `abstract` with `sealed`. A [sealed](#sealed) class is
  implicitly [abstract](#abstract).

  `abstract` 与 `sealed`。[sealed](#sealed) 类隐式地是 [abstract](#abstract)。
* `interface`, `final` or `sealed` with `mixin`. These access modifiers
  prevent [mixing in][mixin].

  `interface`、`final` 或 `sealed` 与 `mixin`。
  这些访问修饰符会阻止 [混入][mixin]。

For further guidance on how class modifiers can be combined,
check out the [Class modifiers reference][].

关于类修饰符如何组合的更多说明，
请查看 [类修饰符参考][Class modifiers reference]。

[Class modifiers reference]: /language/modifier-reference


[language version]: /language/versioning
[class, mixin, or mixin class]: /language/mixins#class-mixin-or-mixin-class
[mixin]: /language/mixins
[fragile base class problem]: https://en.wikipedia.org/wiki/Fragile_base_class
[`noSuchMethod`]: /language/extend#nosuchmethod
[construct]: /language/constructors
[extend]: /language/extend
[implement]: /language/classes#implicit-interfaces
[factory constructor]: /language/constructors#factory-constructors
[exhaustive]: /language/branches#exhaustiveness-checking
[abstract methods]: /language/methods#abstract-methods
[syntax specification]: {{site.repo.dart.lang}}/blob/main/accepted/3.0/class-modifiers/feature-specification.md#syntax
