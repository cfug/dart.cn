---
# title: Methods
title: 成员方法
# description: Learn about methods in Dart.
description: 了解 Dart 中的方法。
prevpage:
  url: /language/primary-constructors
  # title: Primary constructors
  title: 主构造方法
nextpage:
  url: /language/extend
  # title: Extend a class
  title: 扩展类
ai-translated: true
---

<?code-excerpt replace="/ *\/\/\s+ignore_for_file:[^\n]+\n//g; /(^|\n) *\/\/\s+ignore:[^\n]+\n/$1/g; /(\n[^\n]+) *\/\/\s+ignore:[^\n]+\n/$1\n/g"?>

Methods are functions that provide behavior for an object.

方法是为对象提供行为的函数。

## Instance methods

## 实例方法

Instance methods on objects can access instance variables and `this`.
The `distanceTo()` method in the following sample is an example of an
instance method:

对象上的实例方法可以访问实例变量和 `this`。
下面示例中的 `distanceTo()` 方法就是一个
实例方法：

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

## 操作符

Most operators are instance methods with special names.
Dart allows you to define operators with the following names:

大多数操作符都是带有特殊名字的实例方法。
你可以用下面这些名字定义操作符：

|       |      |      |      |       |      |
|-------|------|------|------|-------|------|
| `<`   | `>`  | `<=` | `>=` | `==`  | `~`  |
| `<`   | `>`  | `<=` | `>=` | `==`  | `~`  |
| `-`   | `+`  | `/`  | `~/` | `*`   | `%`  |
| `-`   | `+`  | `/`  | `~/` | `*`   | `%`  |
| `\|`  | `ˆ`  | `&`  | `<<` | `>>>` | `>>` |
| `\|`  | `ˆ`  | `&`  | `<<` | `>>>` | `>>` |
| `[]=` | `[]` |      |      |       |      |
| `[]=` | `[]` |      |      |       |      |

{:.table}

:::note
You might have noticed that some [operators][], like `!=`, aren't in
the list of names. These operators aren't instance methods.
Their behavior is built in to Dart.

你可能已经注意到，有些 [操作符][operators]（例如 `!=`）不在
这份名字列表里。这些操作符不是实例方法。
它们的行为是内建在 Dart 里的。

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

要声明操作符，先写内建标识符 `operator`，
再写你正在定义的那个操作符。
下面的例子定义了向量加法（`+`）、减法（`-`）
和相等（`==`）：

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

## Getter 与 setter

Getters and setters are special methods that provide read and write
access to an object's properties. Recall that each instance variable has
an implicit getter, plus a setter if appropriate. You can create
additional properties by implementing getters and setters, using the
`get` and `set` keywords:

getter 和 setter 是特殊的方法，用来读写对象的属性。
回想一下，每个实例变量都有一个隐式 getter，
在合适的时候还有一个 setter。你可以用
`get` 和 `set` 关键字实现 getter 和 setter，
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

有了 getter 和 setter，你可以先从实例变量开始，
以后再把它们包进方法里，而调用方的代码完全不用改。

:::note
Operators such as increment (`++`) work in the expected way, whether or
not a getter is explicitly defined. To avoid any unexpected side
effects, the operator calls the getter exactly once, saving its value
in a temporary variable.

自增（`++`）这类操作符会按预期方式工作，
无论 getter 是否被显式定义。
为了避免意外的副作用，操作符会正好调用一次 getter，
并把得到的值保存在一个临时变量里。

:::

## Abstract methods

## 抽象方法

Instance, getter, and setter methods can be abstract, defining an
interface but leaving its implementation up to other classes.
Abstract methods can only exist in [abstract classes][] or [mixins][].

实例方法、getter 和 setter 都可以是抽象的：
它们定义接口，把实现留给其他类。
抽象方法只能存在于 [抽象类][abstract classes] 或 [mixin][mixins] 中。

To make a method abstract, use a semicolon (`;`) instead of a method body:

要把方法变成抽象的，用分号（`;`）代替方法体：

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
