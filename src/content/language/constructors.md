---
# title: Constructors
title: 构造函数
# description: Everything about using constructors in Dart.
description: 了解如何在 Dart 中使用构造函数。
prevpage:
  url: /language/classes
  # title: Classes
  title: 类
nextpage:
  url: /language/primary-constructors
  # title: Primary constructors
  title: 主构造函数
ai-translated: true
---

Constructors are special functions that create instances of classes.

构造函数是用来创建类实例的特殊函数。

Dart implements many types of constructors.
Except for default constructors,
these functions use the same name as their class.

Dart 实现了多种构造函数。
除了默认构造函数，这些函数都与它们的类同名。

[Generative constructors][generative]
: Creates new instances and initializes instance variables.

[生成构造函数][generative]
: 创建新实例，并初始化实例变量。

[Default constructors][default]
: Used to create a new instance when a constructor hasn't been specified.
  It doesn't take arguments and isn't named.

[默认构造函数][default]
: 在没有指定构造函数时，用来创建新实例。
  它不接收参数，也没有名字。

[Named constructors][named]
: Clarifies the purpose of a constructor or
  allows the creation of multiple constructors for the same class.

[命名构造函数][named]
: 说明构造函数的用途，
  或者让同一个类可以有多个构造函数。

[Constant constructors][constant]
: Creates instances as compile-time constants.

[常量构造函数][constant]
: 把实例创建为编译时常量。

[Factory constructors][factory]
: Either creates a new instance of a subtype or
  returns an existing instance from cache.

[工厂构造函数][factory]
: 创建子类型的新实例，或者从缓存返回已有实例。

[Redirecting constructor][redirecting]
: Forwards calls to another constructor in the same class.

[重定向构造函数][redirecting]
: 把调用转发到同一个类里的另一个构造函数。

[default]: #default-constructors
[generative]: #generative-constructors
[named]: #named-constructors
[constant]: #constant-constructors
[factory]: #factory-constructors
[redirecting]: #redirecting-constructors

<?code-excerpt path-base="misc/lib/language_tour/classes"?>

<?code-excerpt replace="/ *\/\/\s+ignore_for_file:[^\n]+\n//g; /(^|\n) *\/\/\s+ignore:[^\n]+\n/$1/g; /(\n[^\n]+) *\/\/\s+ignore:[^\n]+\n/$1\n/g; / *\/\/\s+ignore:[^\n]+//g; /([A-Z]\w*)\d\b/$1/g"?>

## Types of constructors

## 构造函数的类型

### Generative constructors

### 生成构造函数

To instantiate a class, use a generative constructor.

要实例化一个类，使用生成构造函数。

<?code-excerpt "point_alt.dart (idiomatic-constructor)" plaster="none"?>
```dart
class Point {
  // Instance variables to hold the coordinates of the point.
  double x;
  double y;

  // Generative constructor with initializing formal parameters:
  Point(this.x, this.y);
}
```

### Default constructors

### 默认构造函数

If you don't declare a constructor, Dart uses the default constructor.
The default constructor is a generative constructor without arguments or name.

如果你没有声明构造函数，Dart 会使用默认构造函数。
默认构造函数是没有参数、也没有名字的生成构造函数。

### Named constructors

### 命名构造函数

Use a named constructor to implement multiple constructors for a class
or to provide extra clarity:

使用命名构造函数，可以为一个类实现多个构造函数，
或者把用途表达得更清楚：

<?code-excerpt "point.dart (named-constructor)" replace="/Point\.\S*/[!$&!]/g" plaster="none"?>
```dart
const double xOrigin = 0;
const double yOrigin = 0;

class Point {
  final double x;
  final double y;

  // Sets the x and y instance variables
  // before the constructor body runs.
  Point(this.x, this.y);

  // Named constructor
  [!Point.origin()!] : x = xOrigin, y = yOrigin;
}
```

A subclass doesn't inherit a superclass's named constructor.
To create a subclass with a named constructor defined in the superclass,
implement that constructor in the subclass.

子类不会继承超类的命名构造函数。
要创建的子类用到超类里定义的命名构造函数时，
就要在子类里实现该构造函数。

### Constant constructors

### 常量构造函数

If your class produces unchanging objects, make these
objects compile-time constants.
To make objects compile-time constants, define a `const` constructor
with all instance variables set as `final`.

如果类产生的对象不会改变，就把这些对象做成编译时常量。
要把对象做成编译时常量，定义一个 `const` 构造函数，
并把所有实例变量都设为 `final`。

<?code-excerpt "immutable_point.dart"?>
```dart
class ImmutablePoint {
  static const ImmutablePoint origin = ImmutablePoint(0, 0);

  final double x, y;

  const ImmutablePoint(this.x, this.y);
}
```

Constant constructors don't always create constants.
They might be invoked in a non-`const` context.
To learn more, consult the section on [using constructors][].

常量构造函数并不总是创建常量。
它们也可能在非 `const` 上下文中被调用。
想了解更多，请查阅 [使用构造函数][using constructors] 一节。

### Redirecting constructors

### 重定向构造函数

A constructor might redirect to another constructor in the same class.
A redirecting constructor has an empty body.
The constructor uses `this` instead of the class name after a colon (`:`).

构造函数可以重定向到同一个类里的另一个构造函数。
重定向构造函数的函数体是空的。
在冒号（`:`）之后，构造函数使用 `this`，而不是类名。

<?code-excerpt "point_redirecting.dart"?>
```dart
class Point {
  double x, y;

  // The main constructor for this class.
  Point(this.x, this.y);

  // Delegates to the main constructor.
  Point.alongXAxis(double x) : this(x, 0);
}
```

### Factory constructors

### 工厂构造函数

When encountering one of following two cases of implementing a constructor,
use the `factory` keyword:

遇到下面两种实现构造函数的情况之一时，使用 `factory` 关键字：

* The constructor doesn't always create a new instance of its class.
  Although a factory constructor can't return `null`,
  it might return:

  构造函数并不总是创建它所属类的新实例。
  虽然工厂构造函数不能返回 `null`，但它可以返回：


  * an existing instance from a cache instead of creating a new one

    从缓存返回已有实例，而不是创建新实例

  * a new instance of a subtype

    子类型的新实例


* You need to perform non-trivial work prior to constructing an instance.
  This can include checking arguments or doing any other processing
  that can't be handled in the initializer list.

  在构造实例之前，你需要做一些不简单的工作。
  这可以包括检查参数，或者做初始化列表处理不了的其他处理。


:::tip
You can also handle late initialization of a final variable
with [`late final`][late-final-ivar] (carefully!).

你也可以用 [`late final`][late-final-ivar]
处理 final 变量的延迟初始化（请谨慎使用）。

:::

The following example includes two factory constructors.

下面的示例包含两个工厂构造函数。

* `Logger` factory constructor returns objects from a cache.

  `Logger` 工厂构造函数从缓存返回对象。

* `Logger.fromJson` factory constructor initializes a final variable
  from a JSON object.

  `Logger.fromJson` 工厂构造函数根据 JSON 对象初始化一个 final 变量。


<?code-excerpt "logger.dart (constructors)"?>
```dart
class Logger {
  final String name;
  bool mute = false;

  // _cache is library-private, thanks to
  // the _ in front of its name.
  static final Map<String, Logger> _cache = <String, Logger>{};

  factory Logger(String name) {
    return _cache.putIfAbsent(name, () => Logger._internal(name));
  }

  factory Logger.fromJson(Map<String, Object> json) {
    return Logger(json['name'].toString());
  }

  Logger._internal(this.name);

  void log(String msg) {
    if (!mute) print(msg);
  }
}
```

:::warning
Factory constructors can't access `this`.

工厂构造函数不能访问 `this`。

:::

Use a factory constructor as any other constructor:

工厂构造函数的用法与其他构造函数一样：

<?code-excerpt "logger.dart (logger)"?>
```dart
var logger = Logger('UI');
logger.log('Button clicked');

var logMap = {'name': 'UI'};
var loggerJson = Logger.fromJson(logMap);
```

### Redirecting factory constructors

### 重定向工厂构造函数

A redirecting factory constructor specifies a call to a constructor of another
class to use whenever someone makes a call to the redirecting constructor.

重定向工厂构造函数指定调用另一个类的构造函数，
每当有人调用这个重定向构造函数时就使用它。

```dart
factory Listenable.merge(List<Listenable> listenables) = _MergingListenable
```

Since ordinary factory constructors can create
and return instances of other classes as well,
redirecting factories seem unnecessary.
However, redirecting factories have several advantages:

普通工厂构造函数同样可以创建并返回其他类的实例，
因此重定向工厂看起来没有必要。
不过，重定向工厂有几个优点：

* An abstract class might provide a constant constructor
  that uses the constant constructor of another class.

  抽象类可以提供一个常量构造函数，并使用另一个类的常量构造函数。

* A redirecting factory constructor avoids the need for forwarders
  to repeat the formal parameters and their default values.

  重定向工厂构造函数不必让转发函数重复形参及其默认值。


### Constructor tear-offs

### 构造函数 tear-off

Dart allows you to supply a constructor as a parameter without calling it.
Called a _tear-off_ (as you _tear off_ the parentheses)
serves as a closure that invokes the constructor with the same parameters.

你可以把构造函数当作参数传入，而不实际调用它。
这称为 **tear-off**（因为你把括号 **撕掉** 了），
它是一个闭包，会用同样的参数调用该构造函数。

If the tear-off is a constructor with the same
signature and return type as the method accepts,
you can use the tear-off as a parameter or variable.

如果 tear-off 是一个构造函数，
其签名和返回类型与方法所接受的相同，
就可以把它用作参数或变量。

Tear-offs differ from lambdas or anonymous functions.
Lambdas serve as a wrapper for the constructor,
whereas a tear-off is the constructor.

tear-off 与 lambda 或匿名函数不同。
Lambda 是构造函数的一层包装，而 tear-off 就是构造函数本身。

**Use Tear-Offs**

**使用 tear-off**

```dart tag=good
// Use a tear-off for a named constructor:
var strings = charCodes.map(String.fromCharCode);

// Use a tear-off for an unnamed constructor:
var buffers = charCodes.map(StringBuffer.new);
```

**Not Lambdas**

**不要用 Lambda**

```dart tag=bad
// Instead of a lambda for a named constructor:
var strings = charCodes.map((code) => String.fromCharCode(code));

// Instead of a lambda for an unnamed constructor:
var buffers = charCodes.map((code) => StringBuffer(code));
```

For more discussion, watch this Decoding Flutter video on tear-offs.

想进一步讨论，可以观看这期讲 tear-off 的 Decoding Flutter 视频。

<YouTubeEmbed id="OmCaloD7sis" title="Dart Tear-offs | Decoding Flutter"></YouTubeEmbed>

## Concise constructor syntax

## 简洁构造函数语法

In Dart 3.13 and later, you can omit the class name
when declaring a generative or factory constructor inside the class body
by using the modifier `new` or `factory` directly:

在 Dart 3.13 及更高版本中，
在类体里声明生成构造函数或工厂构造函数时，
可以直接使用修饰符 `new` 或 `factory`，从而省略类名：

-   `new` or `new named`

    `new`，或者带名字的 `new named`

-   `factory` or `factory named`

    `factory`，或者带名字的 `factory named`


Unlike traditional named constructors (such as `Point.origin()`),
concise named constructors don't use a dot
between the keyword (modifier) and the name.

与传统命名构造函数（例如 `Point.origin()`）不同，
简洁命名构造函数在关键字（修饰符）和名字之间不使用点号。

<?code-excerpt "concise_syntax.dart (concise-syntax)"?>
```dart
class Point {
  double x, y;

  // Concise unnamed generative constructor.
  new(this.x, this.y);

  // Concise named generative constructor.
  new origin() : x = 0, y = 0;

  // Equivalent to `factory Point.clone(Point other)`.
  factory clone(Point other) => Point(other.x, other.y);
}
```

This syntax reduces verbosity and makes refactoring class names easier.

这种语法减少了冗长代码，也让重命名类更容易。

:::note
With this syntax, a method named `factory` with no return type
(like `factory () {}`) is interpreted as an unnamed factory constructor.

使用这种语法时，一个名为 `factory`、没有返回类型的方法
（例如 `factory () {}`）会被解释为无名工厂构造函数。

:::

The following table shows how to map traditional constructor syntax
to the concise constructor syntax (for a class named `LongClassName`):

下表说明如何把传统构造函数语法
映射到简洁构造函数语法（类名为 `LongClassName`）：

| <t>Original Dart syntax</t><t>原有 Dart 语法</t> | <t>Abbreviated syntax</t><t>简写语法</t> |
| ----------------------------------------- | --------------------------- |
| `LongClassName() {}`                      | `new() {}`                  |
| `LongClassName() {}`                      | `new() {}`                  |
| `LongClassName.name() {}`                 | `new name() {}`             |
| `LongClassName.name() {}`                 | `new name() {}`             |
| `const LongClassName();`                  | `const new();`              |
| `const LongClassName();`                  | `const new();`              |
| `const LongClassName.name();`             | `const new name();`         |
| `const LongClassName.name();`             | `const new name();`         |
| `LongClassName(): this.other();`          | `new(): this.other();`      |
| `LongClassName(): this.other();`          | `new(): this.other();`      |
| `LongClassName.name(): this();`           | `new name(): this();`       |
| `LongClassName.name(): this();`           | `new name(): this();`       |
| `const LongClassName(): this.other();`    | `const new(): this.other();` |
| `const LongClassName(): this.other();`    | `const new(): this.other();` |
| `const LongClassName.name(): this();`     | `const new name(): this();` |
| `const LongClassName.name(): this();`     | `const new name(): this();` |
| `factory LongClassName() { ... }`         | `factory() { ... }`         |
| `factory LongClassName() { ... }`         | `factory() { ... }`         |
| `factory LongClassName.name() { ... }`    | `factory name() { ... }`    |
| `factory LongClassName.name() { ... }`    | `factory name() { ... }`    |
| `factory LongClassName() = D;`            | `factory() = D;`            |
| `factory LongClassName() = D;`            | `factory() = D;`            |
| `factory LongClassName.name() = D;`       | `factory name() = D;`       |
| `factory LongClassName.name() = D;`       | `factory name() = D;`       |
| `const factory LongClassName() = D;`      | `const factory() = D;`      |
| `const factory LongClassName() = D;`      | `const factory() = D;`      |
| `const factory LongClassName.name() = D;` | `const factory name() = D;`  |
| `const factory LongClassName.name() = D;` | `const factory name() = D;`  |

For an even more concise syntax
where you define fields and constructors in a single line,
see [Primary constructors](/language/primary-constructors).

如果想要更简洁、在一行里同时定义字段和构造函数的语法，
请参阅 [主构造函数](/language/primary-constructors)。

## Instance variable initialization

## 实例变量初始化

Dart provides several ways to initialize instance variables.
You can assign values in the declaration,
use initializing formal parameters,
or use an initializer list.

Dart 提供了几种初始化实例变量的方式。
你可以在声明时赋值，使用初始化形参，或者使用初始化列表。

### Initialize instance variables in the declaration

### 在声明中初始化实例变量

Initialize the instance variables when you declare the variables.

在声明变量时初始化实例变量。

<?code-excerpt "point_alt.dart (initialize-declaration)" plaster="none"?>
```dart
class PointA {
  double x = 1.0;
  double y = 2.0;

  // The implicit default constructor sets these variables to (1.0,2.0)
  // PointA();

  @override
  String toString() {
    return 'PointA($x,$y)';
  }
}
```

### Use initializing formal parameters

### 使用初始化形参

To simplify the common pattern of assigning a constructor argument
to an instance variable, Dart has *initializing formal parameters*.

为了简化「把构造函数参数赋给实例变量」这种常见写法，
Dart 提供了 **初始化形参**。

In the constructor declaration, include `this.<propertyName>`
and omit the body. The `this` keyword refers to the current instance.

在构造函数声明里写上 `this.<propertyName>`，并省略函数体。
`this` 关键字指当前实例。

When the name conflict exists, use `this`.
Otherwise, Dart style omits the `this`.
An exception exists for the generative constructor where
you must prefix the initializing formal parameter name with `this`.

存在命名冲突时，使用 `this`。
否则，按照 Dart 风格会省略 `this`。
生成构造函数是个例外：初始化形参的名字前面必须加上 `this`。

As noted earlier in this guide, certain constructors
and certain parts of constructors can't access `this`. These include:

正如本指南前面提到的，某些构造函数以及构造函数的某些部分不能访问 `this`。
其中包括：

* Factory constructors

  工厂构造函数

* The right-hand side of an initializer list

  初始化列表的右侧

* Arguments to a superclass constructor

  传给超类构造函数的参数


Initializing formal parameters also allow you to initialize
non-nullable or `final` instance variables.
Both of these types of variables require initialization or a default value.

初始化形参还可以用来初始化不可空或 `final` 的实例变量。
这两类变量都需要初始化，或者提供默认值。

<?code-excerpt "point_alt.dart (initialize-formal)" plaster="none"?>
```dart
class PointB {
  final double x;
  final double y;

  // Sets the x and y instance variables
  // before the constructor body runs.
  PointB(this.x, this.y);

  // Initializing formal parameters can also be optional.
  PointB.optional([this.x = 0.0, this.y = 0.0]);
}
```


This also works with named variables.

对命名变量同样有效。

<?code-excerpt "point_alt.dart (initialize-named)" plaster="none"?>
```dart
class PointC {
  double x; // must be set in constructor
  double y; // must be set in constructor

  // Generative constructor with initializing formal parameters
  // with default values
  PointC.named({this.x = 1.0, this.y = 1.0});

  @override
  String toString() {
    return 'PointC.named($x,$y)';
  }
}

// Constructor using named variables.
final pointC = PointC.named(x: 2.0, y: 2.0);
```

All variables introduced from initializing formal parameters are both
final and only in scope of the initialized variables.

由初始化形参引入的变量都是 final 的，
并且作用域只限于被初始化的那些变量。

To perform logic that you can't express in the initializer list,
create a [factory constructor](#factory-constructors)
or [static method][] with that logic.
You can then pass the computed values to a normal constructor.

如果逻辑无法写在初始化列表里，
可以创建带有该逻辑的 [工厂构造函数](#factory-constructors)
或 [静态方法][static method]。
然后把计算好的值传给普通构造函数。

You can set constructor parameters as nullable to avoid initializing them.

可以把构造函数参数设为可空，这样就不必初始化它们。

<?code-excerpt "point_alt.dart (initialize-null)" plaster="none"?>
```dart
class PointD {
  double? x; // null if not set in constructor
  double? y; // null if not set in constructor

  // Generative constructor with initializing formal parameters
  PointD(this.x, this.y);

  @override
  String toString() {
    return 'PointD($x,$y)';
  }
}
```

### Private named parameters

### 私有命名参数

:::version-note
Using private named parameters as initializing formals
requires a [language version][] of at least 3.12.

把私有命名参数用作初始化形参，
需要至少 3.12 的 [语言版本][language version]。

:::

In Dart, fields starting with an underscore are private to their library.
To initialize a private field using a named parameter,
you can write manual assignment boilerplate
in the initializer list:

在 Dart 里，以下划线开头的字段对该库私有。
要用命名参数初始化私有字段，
可以在初始化列表里手写赋值：

<?code-excerpt "point_private_old.dart (initialize-private-named-before)" plaster="none"?>
```dart
class Point {
  final double _x;
  Point({required double x}) : _x = x;
}
```

You can also initialize private fields directly
in the constructor parameter list.
When you prefix the named parameter with `this._`,
the compiler automatically strips the underscore for the caller,
allowing them to use a clean, public name:

你也可以在构造函数的参数列表里直接初始化私有字段。
当命名参数以 `this._` 为前缀时，
编译器会自动为调用方去掉下划线，
让调用方可以使用干净的公开名字：

<?code-excerpt "point_private_new.dart (initialize-private-named-after)" plaster="none"?>
```dart
class Point {
  final double _x;
  Point({required this._x});
}
```

In both cases,
the caller uses the public name `x` at the call site:

两种写法里，调用方在调用处都使用公开名字 `x`：

<?code-excerpt "point_private_new.dart (initialize-private-named-usage)" plaster="none"?>
```dart
var p = Point(x: 1.0);
```

Like regular [named parameters](/language/functions#named-parameters), you can
make private named parameters optional or required.
You can also provide explicit default values.

和普通的 [命名参数](/language/functions#named-parameters) 一样，
你可以把私有命名参数设为可选或必需。
也可以提供显式的默认值。

In the following example, the `_x` parameter is optional and defaults to `null`.
The `_y` parameter is also optional but has an explicit default value of `0.0`:

在下面的示例里，`_x` 参数是可选的，默认值为 `null`。
`_y` 参数也是可选的，但有显式默认值 `0.0`：

<?code-excerpt "point_alt.dart (initialize-private-named)" plaster="none"?>
```dart
class PointPrivate {
  final double? _x; // Nullable field
  final double _y; // Non-nullable field

  PointPrivate({this._x, this._y = 0.0});

  @override
  String toString() => 'PointPrivate($_x, $_y)';
}

void testPrivate() {
  var p = PointPrivate(x: 1.0, y: 2.0);
  print(p);
}
```

#### Constraints

#### 约束

* **No conflicts:** Neither the private name nor the generated public name
  can match any other parameter name in the same constructor.

  **不能冲突：** 私有名字和生成的公开名字
  都不能与同一构造函数里的其他参数名相同。

* **Initializing formals only:** Named parameters in Dart generally
  can't be private. This capability is an exception that only applies
  to named parameters that are initializing formals (`this._field`).
  You can't use private identifiers for regular named parameters.

  **仅限初始化形参：** Dart 的命名参数通常不能是私有的。
  这项能力是例外，只适用于作为初始化形参的命名参数（`this._field`）。
  普通命名参数不能使用私有标识符。

* **Valid public name:** The private name must map to a valid public identifier.
  For example, `this._` or `this._2x` are invalid
  because they don't have valid public counterparts.

  **公开名字必须合法：** 私有名字必须对应一个合法的公开标识符。
  例如，`this._` 或 `this._2x` 是无效的，
  因为它们没有合法的公开对应名字。


#### Usage in initializer lists

#### 在初始化列表中使用

Within the constructor's initializer list,
reference the parameter using its private name:

在构造函数的初始化列表里，用私有名字引用该参数：

<?code-excerpt "point_alt.dart (initialize-private-named-assert)" plaster="none"?>
```dart
class PointPrivateAssert {
  final double _x;

  PointPrivateAssert({required this._x}) : assert(_x >= 0);
}
```

#### Interaction with super parameters

#### 与 super 参数的相互作用

When extending a class that uses private named parameters,
subclasses use the public name for [super parameters][].

扩展使用了私有命名参数的类时，
子类的 [super 参数][super parameters] 使用公开名字。

In the following example, the `Tool` class defines the private field `_price`.
Even though the field is private,
its corresponding named parameter is public (`price` not `_price`).
To pass the value along,
the `Hammer` subclass uses the public `price` identifier:

在下面的示例里，`Tool` 类定义了私有字段 `_price`。
尽管字段是私有的，对应的命名参数却是公开的（`price` 而不是 `_price`）。
为了把值传下去，`Hammer` 子类使用公开标识符 `price`：

<?code-excerpt "point_alt.dart (initialize-private-named-super)" plaster="none"?>
```dart
class Tool {
  final int _price;
  Tool({required this._price});
}

class Hammer extends Tool {
  // Forwards to the public 'price' argument
  Hammer({required super.price});
}
```

[super parameters]: /resources/glossary#super-parameter

### Use an initializer list

### 使用初始化列表

Before the constructor body runs, you can initialize instance variables.
Separate initializers with commas.

在构造函数体运行之前，你可以初始化实例变量。
用逗号分隔各个初始化器。

<?code-excerpt "point_alt.dart (initializer-list)"?>
```dart
// Initializer list sets instance variables before
// the constructor body runs.
Point.fromJson(Map<String, double> json) : x = json['x']!, y = json['y']! {
  print('In Point.fromJson(): ($x, $y)');
}
```

:::warning
The right-hand side of an initializer list can't access `this`.

初始化列表的右侧不能访问 `this`。

:::

To validate inputs during development,
use `assert` in the initializer list.

要在开发期间校验输入，在初始化列表里使用 `assert`。

<?code-excerpt "point_alt.dart (initializer-list-with-assert)" replace="/assert\(.*?\)/[!$&!]/g"?>
```dart
Point.withAssert(this.x, this.y) : [!assert(x >= 0)!] {
  print('In Point.withAssert(): ($x, $y)');
}
```

Initializer lists help set up `final` fields.

初始化列表有助于设置 `final` 字段。

The following example initializes three `final` fields in an initializer list.
To execute the code, click **Run**.

下面的示例在初始化列表里初始化三个 `final` 字段。
要执行这段代码，点击 **Run**。

<?code-excerpt "point_with_distance_field.dart"?>
```dartpad
import 'dart:math';

class Point {
  final double x;
  final double y;
  final double distanceFromOrigin;

  Point(double x, double y)
    : x = x,
      y = y,
      distanceFromOrigin = sqrt(x * x + y * y);
}

void main() {
  var p = Point(2, 3);
  print(p.distanceFromOrigin);
}
```

## Constructor inheritance

## 构造函数继承

_Subclasses_, or child classes, don't inherit *constructors*
from their _superclass_, or immediate parent class.
If a class doesn't declare a constructor, it can only use the
[default constructor](#default-constructors).

**子类** 不会从 **超类**（直接父类）继承 **构造函数**。
如果一个类没有声明构造函数，它只能使用
[默认构造函数](#default-constructors)。

A class can inherit the _parameters_ of a superclass.
These are called [super parameters](#super-parameters)

类可以继承超类的 **参数**。
这些参数称为 [super 参数](#super-parameters)。

Constructors work in a somewhat similar way to
how you call a chain of static methods.
Each subclass can call its superclass's constructor to initialize an instance,
like a subclass can call a superclass's static method.
This process doesn't "inherit" constructor bodies or signatures.

构造函数的工作方式有点像调用一串静态方法。
每个子类都可以调用超类的构造函数来初始化实例，
就像子类可以调用超类的静态方法一样。
这个过程并不会「继承」构造函数体或签名。

### Non-default superclass constructors

### 非默认的超类构造函数

Dart executes constructors in the following order:

Dart 按以下顺序执行构造函数：

1. [initializer list](#use-an-initializer-list)

   [初始化列表](#use-an-initializer-list)

1. superclass's unnamed, no-arg constructor

   超类的无名、无参构造函数

1. main class's no-arg constructor

   主类的无参构造函数


If the superclass lacks an unnamed, no-argument constructor,
call one of the constructors in the superclass.
Before the constructor body (if any),
specify the superclass constructor after a colon (`:`).

如果超类没有无名、无参构造函数，
就调用超类中的某一个构造函数。
在构造函数体（如果有）之前，
在冒号（`:`）后面指定超类构造函数。

In the following example,
the `Employee` class constructor calls the named constructor
for its superclass, `Person`. To execute the following code, click **Run**.

在下面的示例里，`Employee` 类的构造函数
调用其超类 `Person` 的命名构造函数。
要执行下面的代码，点击 **Run**。

<?code-excerpt "employee.dart (super)" plaster="none"?>
```dartpad
class Person {
  String? firstName;

  Person.fromJson(Map data) {
    print('in Person');
  }
}

class Employee extends Person {
  // Person does not have a default constructor;
  // you must call super.fromJson().
  Employee.fromJson(Map data) : super.fromJson(data) {
    print('in Employee');
  }
}

void main() {
  var employee = Employee.fromJson({});
  print(employee);
  // Prints:
  // in Person
  // in Employee
  // Instance of 'Employee'
}
```

As Dart evaluates the arguments to the superclass constructor *before*
invoking the constructor, an argument can be an expression like a
function call.

Dart 在调用超类构造函数 **之前** 先求值传给它的参数，
因此参数可以是函数调用这样的表达式。

<?code-excerpt "employee.dart (method-then-constructor)"?>
```dart
class Employee extends Person {
  Employee() : super.fromJson(fetchDefaultData());
  // ···
}
```

:::warning
Arguments to the superclass constructor can't access `this`.
For example, arguments can call *static* methods
but not *instance* methods.

传给超类构造函数的参数不能访问 `this`。
例如，参数可以调用 **静态** 方法，但不能调用 **实例** 方法。

:::

### Super parameters

### super 参数

To avoid passing each parameter into the super invocation of a constructor,
use super-initializer parameters to forward parameters
to the specified or default superclass constructor.
You can't use this feature with
[redirecting constructors](#redirecting-constructors).
Super-initializer parameters have syntax and semantics like
[initializing formal parameters](#use-initializing-formal-parameters).

为了避免把每个参数都传进构造函数的 super 调用，
可以使用 super 初始化参数，把参数转发给指定的或默认的超类构造函数。
不能把这个特性与 [重定向构造函数](#redirecting-constructors) 一起使用。
Super 初始化参数的语法和语义
类似于 [初始化形参](#use-initializing-formal-parameters)。

:::version-note
Using super-initializer parameters
requires a [language version][] of at least 2.17.
If you're using an earlier language version,
you must manually pass in all super constructor parameters.

使用 super 初始化参数
需要至少 2.17 的 [语言版本][language version]。
如果你使用的语言版本更早，
就必须手动传入所有超类构造函数参数。

:::

If the super-constructor invocation includes positional arguments,
super-initializer parameters can't be positional.

如果 super 构造函数调用包含位置参数，
super 初始化参数就不能是位置参数。

<?code-excerpt "super_initializer_positional_parameters.dart (positional)" plaster="none"?>
```dart
class Vector2d {
  final double x;
  final double y;

  Vector2d(this.x, this.y);
}

class Vector3d extends Vector2d {
  final double z;

  // Forward the x and y parameters to the default super constructor like:
  // Vector3d(final double x, final double y, this.z) : super(x, y);
  Vector3d(super.x, super.y, this.z);
}
```

To further illustrate, consider the following example.

为了进一步说明，请看下面的示例。

```dart
  // If you invoke the super constructor (`super(0)`) with any
  // positional arguments, using a super parameter (`super.x`)
  // results in an error.
  Vector3d.xAxisError(super.x): z = 0, super(0); // BAD
```

This named constructor tries to set the `x` value twice:
once in the super constructor and once as a
positional super parameter.
As both address the `x` positional parameter, this results in an error.

这个命名构造函数试图设置两次 `x` 的值：
一次在 super 构造函数里，一次作为位置 super 参数。
两者都对应 `x` 这个位置参数，因此会报错。

When the super constructor has named arguments, you can split them
between named super parameters (`super.y` in the next example)
and named arguments to the super constructor invocation
(`super.named(x: 0)`).

当 super 构造函数有命名参数时，你可以把它们拆开：
一部分作为命名 super 参数（下一个示例里的 `super.y`），
一部分作为 super 构造函数调用的命名参数（`super.named(x: 0)`）。

<?code-excerpt "super_initializer_named_parameters.dart (named)" plaster="none"?>
```dart
class Vector2d {
  // ...
  Vector2d.named({required this.x, required this.y});
}

class Vector3d extends Vector2d {
  final double z;

  // Forward the y parameter to the named super constructor like:
  // Vector3d.yzPlane({required double y, required this.z})
  //       : super.named(x: 0, y: y);
  Vector3d.yzPlane({required super.y, required this.z}) : super.named(x: 0);
}
```

[language version]: /language/versioning
[using constructors]: /language/classes#using-constructors
[late-final-ivar]: /effective-dart/design#avoid-public-late-final-fields-without-initializers
[static method]: /language/classes#static-methods
