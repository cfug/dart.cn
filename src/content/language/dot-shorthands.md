---
# title: Dot shorthands
title: 点简写
# description: Learn about the dot shorthand syntax in Dart.
description: "了解 Dart 中的点简写语法。"
ai-translated: true
prevpage:
  url: /language/enums
# title: Enums
  title: 枚举
nextpage:
  url: /language/extension-methods
# title: Extension methods
  title: Extension 方法
---

<?code-excerpt replace="/ *\/\/\s+ignore_for_file:[^\n]+\n//g; /(^|\n) *\/\/\s+ignore:[^\n]+\n/$1/g; /(\n[^\n]+) *\/\/\s+ignore:[^\n]+\n/$1\n/g"?>

:::version-note
Dot shorthands require a [language version][] of at least 3.10.

点简写要求 [语言版本][language version] 至少为 3.10。
:::

[language version]: /language/versioning

## Overview

## 概述

Dot shorthand syntax `.foo` lets you write more concise Dart 
code by omitting the type when the compiler can infer it 
from context. This provides a clean alternative to writing 
the full `ContextType.foo` when accessing enum values, 
static members, or constructors.

点简写语法 `.foo` 让你在编译器能从上下文推断类型时省去类型名，
从而写出更简洁的 Dart 代码。
访问枚举值、静态成员或构造函数时，
不必再写完整的 `ContextType.foo`。

In essence, dot shorthands allow an expression 
to start with one of the following and then optionally chain 
other operations onto it:

本质上，点简写可以让表达式以下列形式之一开头，
然后再按需链式调用其他操作：

* Identifier `.myValue`

  标识符 `.myValue`

* Constructor `.new()`

  构造函数 `.new()`

* Constant creation `const .myValue()`

  常量创建 `const .myValue()`

Here's a quick look at how it simplifies an enum assignment:

下面快速看一下它如何简化枚举赋值：

<?code-excerpt "language/lib/shorthands/intro.dart"?>
```dart
// Use dot shorthand syntax on enums:
enum Status { none, running, stopped, paused }

Status currentStatus = .running; // Instead of Status.running

// Use dot shorthand syntax on a static method:
int port = .parse('8080'); // Instead of int.parse('8080')

// Uses dot shorthand syntax on a constructor:
class Point {
  final int x, y;
  Point(this.x, this.y);
  Point.origin() : x = 0, y = 0;
}

Point origin = .origin(); // Instead of Point.origin()
```

## The role of context type 

## 上下文类型的作用

Dot shorthands use the [context type][] to determine the member 
the compiler resolves to. The context type is the type that Dart 
expects an expression to have based on its location. 
For example, in `Status currentStatus = .running`, 
the compiler knows a `Status` is expected, so it infers 
`.running` to mean `Status.running`.

点简写借助 [上下文类型][context type] 确定编译器要解析到的成员。
上下文类型是 Dart 根据表达式所在位置，
期望该表达式具有的类型。
例如，在 `Status currentStatus = .running` 中，
编译器知道这里期望的是 `Status`，
因此会把 `.running` 推断为 `Status.running`。

[context type]: /resources/glossary#context-type

## Lexical structure and syntax

## 词法结构与语法

A _static member shorthand_ is an expression that
begins with a leading dot (`.`).
When the type is known from the surrounding context,
this syntax provides a concise way to access
static members, constructors, and enum values.

**静态成员简写** 是以先导点号（`.`）开头的表达式。
当周围上下文已经知道类型时，
这种语法可以简洁地访问静态成员、构造函数和枚举值。

### Enums

### 枚举

A primary and highly recommended use case for dot shorthands 
is with enums, especially in assignments and switch statements, 
where the enum type is very obvious.

点简写的一个主要且非常推荐的用途是配合枚举，
尤其是在赋值和 switch 语句中，
因为枚举类型通常非常明确。

<?code-excerpt "language/lib/shorthands/enums.dart"?>
```dart
enum LogLevel { debug, info, warning, error }

/// Returns the color code to use for the specified log [level].
String colorCode(LogLevel level) {
  // Use dot shorthand syntax for enum values in switch cases:
  return switch (level) {
    .debug => 'gray', // Instead of LogLevel.debug
    .info => 'blue', // Instead of LogLevel.info
    .warning => 'orange', // Instead of LogLevel.warning
    .error => 'red', // Instead of LogLevel.error
  };
}

// Example usage:
String warnColor = colorCode(.warning); // Returns 'orange'
```

### Named constructors

### 命名构造函数

Dot shorthands are useful for invoking named constructors 
or factory constructors. This syntax also works when providing 
type arguments to a generic class's constructor.

点简写适合调用命名构造函数或工厂构造函数。
给泛型类的构造函数提供类型参数时，这种语法同样适用。

<?code-excerpt "language/lib/shorthands/constructors.dart"?>
```dart
class Point {
  final double x, y;
  const Point(this.x, this.y);
  const Point.origin() : x = 0, y = 0; // Named constructor

  // Factory constructor
  factory Point.fromList(List<double> list) {
    return Point(list[0], list[1]);
  }
}

// Use dot shorthand syntax on a named constructor:
Point origin = .origin(); // Instead of Point.origin()

// Use dot shorthand syntax on a factory constructor:
Point p1 = .fromList([1.0, 2.0]); // Instead of Point.fromList([1.0, 2.0])

// Use dot shorthand syntax on a generic class constructor:
List<int> intList = .filled(5, 0); // Instead of List.filled(5, 0)
``` 

### Unnamed constructors

### 未命名构造函数

The `.new` dot shorthand provides a concise way to call an
unnamed constructor of a class. This is useful 
for assigning fields or variables where the type is 
already explicitly declared.

`.new` 点简写提供了一种简洁的方式，用来调用类的未命名构造函数。
当字段或变量的类型已经显式声明时，这样赋值很方便。

This syntax is particularly effective for cleaning up 
repetitive class field initializers.
As shown in the following "after" example using dot shorthands,
it can be used for constructors both with and without arguments.
It also infers any generic type arguments 
from the context. 

这种语法特别适合清理重复的类字段初始化器。
下面的「之后」示例使用点简写，
无论构造函数有没有参数都可以使用。
它也会从上下文推断泛型类型参数。

**Without dot shorthands:**

**不使用点简写：**

<?code-excerpt "language/lib/shorthands/unnamed_constructors.dart (unnamed-before)"?>
```dart
class _PageState extends State<Page> {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
  );
  final ScrollController _scrollController = ScrollController();

  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  Map<String, Map<String, bool>> properties = <String, Map<String, bool>>{};
  // ...
}
```

**Using dot shorthands:**

**使用点简写：**

<?code-excerpt "language/lib/shorthands/unnamed_constructors.dart (unnamed-after)" replace="/_PageStateAfter/_PageState/g;"?>
```dart
// Use dot shorthand syntax for calling unnamed constructors:
class _PageState extends State<Page> {
  late final AnimationController _animationController = .new(vsync: this);
  final ScrollController _scrollController = .new();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey = .new();
  Map<String, Map<String, bool>> properties = .new();
  // ...
}
```

### Static members

### 静态成员

You can use dot shorthand syntax to call static methods or 
access static fields/getters. The compiler infers the 
target class from the context type of the expression.

你可以用点简写语法调用静态方法，或访问静态字段和 getter。
编译器会根据表达式的上下文类型推断目标类。

<?code-excerpt "language/lib/shorthands/static_members.dart"?>
```dart
// Use dot shorthand syntax to invoke a static method:
int httpPort = .parse('80'); // Instead of int.parse('80')

// Use dot shorthand syntax to access a static field or getter:
BigInt bigIntZero = .zero; // Instead of BigInt.zero
```

### Constant expressions 

### 常量表达式

You can use dot shorthands within a constant context
if the member being accessed is a compile-time constant. 
This is common for enum values and invoking `const` constructors.

如果被访问的成员是编译时常量，
就可以在常量上下文中使用点简写。
枚举值和调用 `const` 构造函数是常见情况。

<?code-excerpt "language/lib/shorthands/consts.dart"?>
```dart
enum Status { none, running, stopped, paused }

class Point {
  final double x, y;
  const Point(this.x, this.y);
  const Point.origin() : x = 0.0, y = 0.0;
}

// Use dot shorthand syntax for enum value:
const Status defaultStatus = .running; // Instead of Status.running

// Use dot shorthand syntax to invoke a const named constructor:
const Point myOrigin = .origin(); // Instead of Point.origin()

// Use dot shorthand syntax in a const collection literal:
const List<Point> keyPoints = [.origin(), .new(1.0, 1.0)];
// Instead of [Point.origin(), Point(1.0, 1.0)]
```

## Rules and limitations

## 规则与限制

Dot shorthands rely on a clear context type, which leads to 
a few specific rules and limitations you should know about.

点简写依赖明确的上下文类型，
因此有几条具体的规则和限制需要了解。

### Clear context type required in chains

### 链式调用需要明确的上下文类型

While you can chain operations like method calls or 
property accesses onto a dot shorthand, the entire expression 
is validated against the context type.

你可以把方法调用或属性访问链式接到点简写之后，
但整个表达式都会对照上下文类型进行校验。

The compiler first uses the context to determine what the 
dot shorthand resolves to. Any subsequent operations in the 
chain must return a value that matches that same initial 
context type.

编译器首先根据上下文确定点简写解析到什么。
链条上之后的任何操作，其返回值都必须匹配最初的那个上下文类型。

<?code-excerpt "language/lib/shorthands/chain.dart (chain)"?>
```dart
// .fromCharCode(72) resolves to the String "H",
// then the instance method .toLowerCase() is called on that String.
String lowerH = .fromCharCode(72).toLowerCase();
// Instead of String.fromCharCode(72).toLowerCase()

print(lowerH); // Output: h
```

### Asymmetric equality checks

### 不对称的相等判断

The `==` and `!=` operators have a special rule for dot shorthands. 
When dot shorthand syntax is used directly on the right-hand side
of an equality check, Dart uses the static type of the 
left-hand side to determine the class or enum for the shorthand.

`==` 和 `!=` 运算符对点简写有一条特殊规则。
当点简写直接出现在相等判断的右侧时，
Dart 使用左侧的静态类型来确定简写对应的类或枚举。

For instance, in an expression like `myColor == .green`, 
the type of the variable `myColor` is used as the context. 
This means the compiler interprets `.green` as `Color.green`.

例如，在 `myColor == .green` 这样的表达式中，
变量 `myColor` 的类型会用作上下文。
这意味着编译器会把 `.green` 解释为 `Color.green`。

<?code-excerpt "language/lib/shorthands/equality.dart"?>
```dart
enum Color { red, green, blue }

// Use dot shorthand syntax for equality expressions:
void allowedExamples() {
  Color myColor = Color.red;
  bool condition = true;

  // OK: `myColor` is a `Color`, so `.green` is inferred as `Color.green`.
  if (myColor == .green) {
    print('The color is green.');
  }

  // OK: Works with `!=` as well.
  if (myColor != .blue) {
    print('The color is not blue.');
  }

  // OK: The context for the ternary is the variable `inferredColor`
  // being assigned to, which has a type of `Color`.
  Color inferredColor = condition ? .green : .blue;
  print('Inferred color is $inferredColor');
}
```

The dot shorthand must be on the right-hand side of the `==` 
or `!=` operator. Comparing against a more complex expression, 
like a conditional expression, is also not allowed.

点简写必须位于 `==` 或 `!=` 运算符的右侧。
与更复杂的表达式（例如条件表达式）比较，同样不行。

<?code-excerpt "language/lib/shorthands/equality_with_errors.dart"?>
```dart tag=fails-sa
enum Color { red, green, blue }

void notAllowedExamples() {
  Color myColor = Color.red;
  bool condition = true;

  // ERROR: The shorthand must be on the right side of `==`.
  // Dart's `==` operator is not symmetric for this feature.
  if (.red == myColor) {
    print('This will not compile.');
  }

  // ERROR: The right-hand side is a complex expression (a conditional expression),
  // which is not a valid target for shorthand in a comparison.
  if (myColor == (condition ? .green : .blue)) {
    print('This will not compile.');
  }

  // ERROR: The type context is lost by casting `myColor` to `Object`.
  // The compiler no longer knows that `.green` should refer to `Color.green`.
  if ((myColor as Object) == .green) {
    print('This will not compile.');
  }
}
```

### Expression statements can't start with `.`

### 表达式语句不能以 `.` 开头

To avoid potential parsing ambiguities in the future, an
expression statement is not allowed to begin with a
`.` token.

为避免将来可能出现的解析歧义，
表达式语句不能以 `.` 记号开头。

<?code-excerpt "language/lib/shorthands/expression_with_errors.dart"?>
```dart tag=fails-sa
class Logger {
  static void log(String message) {
    print(message);
  }
}

void main() {
  // ERROR: An expression statement can't begin with `.`.
  // The compiler has no type context (like a variable assignment)
  // to infer that `.log` should refer to `Logger.log`.
  .log('Hello');
}
```

### Limited handling of union types

### 对联合类型的处理有限

While there is special handling for nullable types (`T?`) and
`FutureOr<T>`, support is limited.

虽然对可空类型（`T?`）和 `FutureOr<T>` 有特殊处理，
但支持范围有限。

*  For a nullable type (`T?`), you can access static members
   of `T`, but not of `Null`.

   对于可空类型（`T?`），可以访问 `T` 的静态成员，
   但不能访问 `Null` 的静态成员。

*  For `FutureOr<T>`, you can access static members of `T`
  (primarily to support `async` function returns), but you
  can't access static members of the `Future` class itself.

   对于 `FutureOr<T>`，可以访问 `T` 的静态成员
   （主要是为了支持 `async` 函数的返回值），
   但不能访问 `Future` 类本身的静态成员。
