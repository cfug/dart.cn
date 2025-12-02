---
# title: Methods
title: 方法
# description: Learn about methods in Dart.
description: 了解 Dart 中的方法。
prevpage:
  url: /language/constructors
  # title: Constructors
  title: 构造函数
nextpage:
  url: /language/extend
  # title: Extend a class
  title: 扩展一个类
---

<?code-excerpt replace="/ *\/\/\s+ignore_for_file:[^\n]+\n//g; /(^|\n) *\/\/\s+ignore:[^\n]+\n/$1/g; /(\n[^\n]+) *\/\/\s+ignore:[^\n]+\n/$1\n/g"?>

Methods are functions that provide behavior for an object.

方法是为对象提供行为的函数。

## Instance methods

## 实例方法

Instance methods on objects can access instance variables and `this`.
The `distanceTo()` method in the following sample is an example of an
instance method:

对象的实例方法可以访问实例变量和 `this`。
下面示例中的 `distanceTo()` 方法就是一个实例方法的例子：

<?code-excerpt "misc/lib/language_tour/classes/point.dart (class-with-distance-to)" plaster="none"?>
```dart
import 'dart:math';

class Point {
  final double x;
  final double y;

  // Sets the x and y instance variables
  // before the constructor body runs.
  Point(this.x, this.y);

  double distanceTo(Point other) {
    var dx = x - other.x;
    var dy = y - other.y;
    return sqrt(dx * dx + dy * dy);
  }

}
```

## Operators

## 运算符

Most operators are instance methods with special names.
Dart allows you to define operators with the following names:

大多数运算符是具有特殊名称的实例方法。
Dart 允许你使用以下名称定义运算符：

|       |      |      |      |       |      |
|-------|------|------|------|-------|------|
| `<`   | `>`  | `<=` | `>=` | `==`  | `~`  |
| `-`   | `+`  | `/`  | `~/` | `*`   | `%`  |
| `\|`  | `ˆ`  | `&`  | `<<` | `>>>` | `>>` |
| `[]=` | `[]` |      |      |       |      |

{:.table}

:::note
You may have noticed that some [operators][], like `!=`, aren't in
the list of names. These operators aren't instance methods.
Their behavior is built in to Dart.

你可能已经注意到，一些[运算符][operators]，如 `!=`，
不在名称列表中。这些运算符不是实例方法。
它们的行为是 Dart 内置的。
:::

{%- comment %}
  Internal note from https://github.com/dart-lang/site-www/pull/2691#discussion_r506184100:
  -  `??`, `&&` and `||` are excluded because they are lazy / short-circuiting operators
  - `!` is probably excluded for historical reasons
{% endcomment %}

To declare an operator, use the built-in identifier
`operator` then the operator you are defining.
The following example defines vector addition (`+`), subtraction (`-`),
and equality (`==`):

要声明一个运算符，请使用内置标识符 `operator`，
然后是你要定义的运算符。
下面的示例定义了向量加法（`+`）、减法（`-`）
和相等（`==`）运算符：

<?code-excerpt "misc/lib/language_tour/classes/vector.dart"?>
```dart
class Vector {
  final int x, y;

  Vector(this.x, this.y);

  Vector operator +(Vector v) => Vector(x + v.x, y + v.y);
  Vector operator -(Vector v) => Vector(x - v.x, y - v.y);

  @override
  bool operator ==(Object other) =>
      other is Vector && x == other.x && y == other.y;

  @override
  int get hashCode => Object.hash(x, y);
}

void main() {
  final v = Vector(2, 3);
  final w = Vector(2, 2);

  assert(v + w == Vector(4, 5));
  assert(v - w == Vector(0, 1));
}
```


## Getters and setters

## Getter 和 Setter

Getters and setters are special methods that provide read and write
access to an object's properties. Recall that each instance variable has
an implicit getter, plus a setter if appropriate. You can create
additional properties by implementing getters and setters, using the
`get` and `set` keywords:

Getter 和 setter 是提供对象属性读写访问的特殊方法。
回想一下，每个实例变量都有一个隐式的 getter，
如果合适的话还有一个 setter。
你可以使用 `get` 和 `set` 关键字来实现 getter 和 setter，
从而创建额外的属性：

<?code-excerpt "misc/lib/language_tour/classes/rectangle.dart"?>
```dart highlightLines=8-12
/// A rectangle in a screen coordinate system,
/// where the origin `(0, 0)` is in the top-left corner.
class Rectangle {
  double left, top, width, height;

  Rectangle(this.left, this.top, this.width, this.height);

  // Define two calculated properties: right and bottom.
  double get right => left + width;
  set right(double value) => left = value - width;
  double get bottom => top + height;
  set bottom(double value) => top = value - height;
}

void main() {
  var rect = Rectangle(3, 4, 20, 15);
  assert(rect.left == 3);
  rect.right = 12;
  assert(rect.left == -8);
}
```

With getters and setters, you can start with instance variables, later
wrapping them with methods, all without changing client code.

使用 getter 和 setter，你可以从实例变量开始，
之后用方法包装它们，而无需更改客户端代码。

:::note
Operators such as increment (`++`) work in the expected way, whether or
not a getter is explicitly defined. To avoid any unexpected side
effects, the operator calls the getter exactly once, saving its value
in a temporary variable.

无论是否显式定义了 getter，
像自增（`++`）这样的运算符都会按预期方式工作。
为了避免任何意外的副作用，
运算符只调用一次 getter，并将其值保存在临时变量中。
:::

## Abstract methods

## 抽象方法

Instance, getter, and setter methods can be abstract, defining an
interface but leaving its implementation up to other classes.
Abstract methods can only exist in [abstract classes][] or [mixins][].

实例方法、getter 和 setter 方法可以是抽象的，
定义一个接口但将其实现留给其他类。
抽象方法只能存在于[抽象类][abstract classes]或 [mixin][mixins] 中。

To make a method abstract, use a semicolon (`;`) instead of a method body:

要使方法成为抽象方法，请使用分号（`;`）代替方法体：

<?code-excerpt "misc/lib/language_tour/classes/doer.dart"?>
```dart
abstract class Doer {
  // Define instance variables and methods...

  void doSomething(); // Define an abstract method.
}

class EffectiveDoer extends Doer {
  void doSomething() {
    // Provide an implementation, so the method is not abstract here...
  }
}
```

[operators]: /language/operators
[abstract classes]: /language/class-modifiers#abstract
[mixins]: /language/mixins
