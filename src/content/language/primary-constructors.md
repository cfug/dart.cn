---
# title: Primary constructors
title: 主构造函数
# description: >-
#   Create classes concisely by
#   declaring parameters and fields in the class header.
description: "在类头部声明参数和字段，从而简洁地创建类。"
ai-translated: true
prevpage:
  url: /language/constructors
# title: Constructors
  title: 构造函数
nextpage:
  url: /language/methods
# title: Methods
  title: 方法
---

:::version-note
Primary constructors require a [language version][] of at least 3.13.

主构造函数要求 [语言版本][language version] 至少为 3.13。
:::

## Overview

## 概述

Primary constructors provide a concise way to declare a class's fields
and its main constructor in a single line.
They reduce the boilerplate of declaring fields, passing parameters,
and assigning them in the constructor body.
This shorthand changes how you write the declaration,
but it doesn't change runtime behavior.

主构造函数提供了一种简洁的方式，
可以在一行里同时声明类的字段和主构造函数。
它们减少了声明字段、传递参数并在构造函数体中赋值的样板代码。
这种简写改变的是声明的写法，运行时行为不变。

### Before and after

### 前后对比

Consider this traditional class with two fields and a constructor:

看这个带有两个字段和一个构造函数的传统类：

<?code-excerpt "language/lib/primary_constructors/point.dart (point)"?>
```dart
// Current syntax.
class Point {
  int x;
  int y;

  Point(this.x, this.y);
}
```

Using a primary constructor makes the same class much more concise:

使用主构造函数后，同一个类会简洁很多：

<?code-excerpt "language/lib/primary_constructors/point.dart (point-primary)" replace="/PointPrimary/Point/g"?>
```dart
// Using a primary constructor.
class Point(var int x, var int y);
```

Declaring a parameter in the primary constructor with `var` or `final`
implicitly induces an instance variable for that parameter.

在主构造函数中用 `var` 或 `final` 声明参数，
会为该参数隐式引入一个实例变量。

Any other constructors declared inside the class body are
referred to as **in-body constructors**.

类体内部声明的其它构造函数称为 **类体内构造函数**。

To ensure the primary constructor executes on every new instance,
a class, mixin class, or enum with a primary constructor
can't have any other non-redirecting generative in-body constructors.

为了确保每个新实例都会执行主构造函数，
带有主构造函数的类、mixin 类或枚举
不能再有其它非重定向的生成式类体内构造函数。

:::note
If you want to declare traditional constructors in
the class body more concisely without repeating the class name,
check out [Concise constructor syntax][].

如果想在类体里更简洁地声明传统构造函数，并且不必重复类名，
请查看 [简洁构造函数语法][Concise constructor syntax]。
:::

[Concise constructor syntax]: /language/constructors#concise-constructor-syntax

## Field declarations in parameters

## 在参数中声明字段

Parameters in primary constructors with the `var` or `final` modifier,
called **declaring parameters**, implicitly induce a field.

主构造函数中带 `var` 或 `final` 修饰符的参数称为 **声明参数**，
它们会隐式引入一个字段。

If you omit the modifier, the parameter doesn't create a field.
It behaves just like a parameter in a traditional constructor.

如果省略修饰符，该参数不会创建字段。
它的行为就和传统构造函数中的参数一样。

<?code-excerpt "language/lib/primary_constructors/primary_constructors.dart (declaring-parameters)"?>
```dart
// Declares both fields x and y.
class Point(var int x, var int y);

// Doesn't declare a field.
class User(String name);
```

For extension types, the primary constructor must have exactly one parameter.
This parameter is always a declaring parameter, even if you omit the modifier.

对于扩展类型，主构造函数必须恰好有一个参数。
即使省略修饰符，这个参数也始终是声明参数。

Mixin classes can only have a primary constructor
with no parameters, body, or initializer list.

mixin 类的主构造函数只能没有参数、没有函数体，也没有初始化列表。

:::warning New parameter modifier restrictions
Because `final` and `var` on parameters are now reserved for
declaring parameters in primary constructors,
you can't use them on parameters in other declarations.
For code examples and migration guidance, see
[Parameter modifier restrictions](#parameter-modifier-restrictions).

:::warning 参数修饰符的新限制
`final` 和 `var` 用在参数上时，现在专门保留给主构造函数中的声明参数，
因此不能用在其它声明的参数上。
代码示例和迁移说明见
[参数修饰符限制](#parameter-modifier-restrictions)。
:::

<a id="primary-initializer-scope" aria-hidden="true"></a>

## Primary constructor scopes

## 主构造函数的作用域

When you use a primary constructor,
the parameters you declare in the class header are
available in different parts of the class declaration.
Dart manages their visibility using two distinct scopes:

使用主构造函数时，在类头部声明的参数
可以在类声明的不同部分使用。
Dart 用两个不同的作用域管理它们的可见性：

*   **Primary initializer scope**:
    Applies to non-late field initializers in the class body and
    to the primary constructor's initializer list (after `this :`).
    In this scope, a parameter name like `x` refers
    directly to the constructor parameter.

    **主初始化作用域**：
    适用于类体中的非 late 字段初始化器，
    以及主构造函数的初始化列表（`this :` 之后）。
    在这个作用域里，像 `x` 这样的参数名
    直接指构造函数参数。
*   **Primary parameter scope**:
    Applies to the body block of the primary constructor (inside `{ ... }`).
    In this scope, a declaring parameter's name
    refers to the _induced instance variable_ (field),
    while a non-declaring parameter's name still
    refers to the constructor parameter.

    **主参数作用域**：
    适用于主构造函数的函数体（`{ ... }` 内部）。
    在这个作用域里，声明参数的名字
    指 **推导出的实例变量**（字段），
    而非声明参数的名字仍然指构造函数参数。

The primary initializer scope makes the header parameters directly
available for initializing non-late fields,
which removes the need for a separate initializer list.
It works just as if you were initializing
variables in a traditional constructor's initializer list:

主初始化作用域让头部参数可以直接用来初始化非 late 字段，
因此不必再单独写初始化列表。
其效果就如同在传统构造函数的初始化列表里初始化变量：

<?code-excerpt "language/lib/primary_constructors/primary_constructors.dart (initializer-scope)"?>
```dart
class DeltaPoint(final int x, int delta) {
  // Accesses 'x' and 'delta' parameters directly!
  final int y = x + delta;
}
```

The primary parameter scope ensures that
any updates to instance variables are
correctly reflected in the constructor body,
while initializers still have access to the original parameters.
The following example shows how the
same name `x` resolves differently in each scope:

主参数作用域确保对实例变量的任何更新
都会正确反映在构造函数体中，
同时初始化器仍然可以访问原始参数。
下面的例子展示同一个名字 `x`
在两个作用域中如何解析到不同的东西：

<?code-excerpt "language/lib/primary_constructors/primary_constructors.dart (scoping-shadowing)"?>
```dart
class ScopingDemo(var String x, String suffix) {
  // In a non-late field initializer, 'x' refers to the parameter 'x'.
  final String fieldAtDeclaration = x;
  final String fieldInInitializer;

  // In the initializer list, 'x' refers to the parameter 'x'.
  this : fieldInInitializer = x {
    // Inside the body, 'x' refers to the induced instance variable,
    // so assigning to it updates the field.
    x = x.toUpperCase();
    // 'suffix' induces no field, so it still refers to the parameter.
    print('$x$suffix');
  }
}
```

This consistent behavior makes refactoring between
traditional and primary constructors simpler and safer.

这种一致的行为让传统构造函数和主构造函数之间的重构更简单，也更安全。

## Add constructor bodies

## 添加构造函数体

To validate input or perform complex initialization,
you can add a body to the primary constructor inside the class definition.
This body uses the `this` keyword followed by a block:

要校验输入或执行复杂的初始化，
可以在类定义内部为主构造函数添加函数体。
这个函数体使用 `this` 关键字，后面跟一个块：

<?code-excerpt "language/lib/primary_constructors/primary_constructors.dart (constructor-bodies)" replace="/PointWithBody/Point/g"?>
```dart
class Point(var int x, var int y) {
  this : assert(x >= 0 && y >= 0) {
    print('Point initialized at ($x, $y)');
  }
}
```

The block can specify an initializer list after `this` and/or a function body.
To provide only an initializer list,
end it with a semicolon, such as `this : assert(x >= 0);`.
You can also annotate the block with metadata,
such as `@metadata this;`.

这个块可以在 `this` 之后指定初始化列表和/或函数体。
如果只提供初始化列表，
用分号结束，例如 `this : assert(x >= 0);`。
也可以给这个块加上元数据，
例如 `@metadata this;`。

## Initialize private fields

## 初始化私有字段

To initialize a private field using a named parameter,
you can write manual assignment boilerplate in a traditional constructor:

要用命名参数初始化私有字段，
在传统构造函数里你可以手写赋值样板代码：

<?code-excerpt "language/lib/primary_constructors/private_named_parameters.dart (private-named-old)" replace="/UserOld/User/g"?>
```dart
// Variant not using a private named parameter.
class User({required String name}) {
  String _name = name;
}
```

With primary constructors and the private named parameters feature,
you can declare the private field directly in the constructor header.
When you use a private name (with a leading underscore) for a named parameter,
the compiler automatically makes the parameter name public for the caller
by removing the underscore:

有了主构造函数和私有命名参数，
你可以直接在构造函数头部声明私有字段。
当命名参数使用私有名称（以下划线开头）时，
编译器会自动去掉下划线，
让调用方使用公开的参数名：

<?code-excerpt "language/lib/primary_constructors/private_named_parameters.dart (private-named-new)" replace="/UserNew/User/g"?>
```dart
// Variant using a private named parameter.
class User({required var String _name});
```

In both cases, the caller uses the public name `name`
at the call site: `User(name: 'John Doe')`.

两种写法里，调用方在调用处都使用公开名称 `name`：
`User(name: 'John Doe')`。

## Empty bodies

## 空类体

An empty body of a class, mixin class, extension, or extension type (`{}`)
can be replaced by a semicolon (`;`).
While this is true in general for these declarations,
it's particularly useful when using a primary constructor to
keep the entire declaration on a single line.

类、mixin 类、extension 或扩展类型的空类体（`{}`）
可以换成分号（`;`）。
这些声明一般都允许这样做。
使用主构造函数时尤其有用，可以把整个声明保持在一行。

<?code-excerpt "language/lib/primary_constructors/primary_constructors.dart (empty-bodies)" replace="/EmptyBodyPoint/Point/g"?>
```dart
class Point(var int x, var int y);
```

## Constant primary constructors

## 常量主构造函数

Just like traditional constructors,
a primary constructor can be constant
if the class and its fields allow it.
To declare a constant primary constructor,
place the `const` modifier before the class name in the class header:

和传统构造函数一样，
只要类及其字段允许，主构造函数就可以是常量。
要声明常量主构造函数，
把 `const` 修饰符放在类头部的类名之前：

<?code-excerpt "language/lib/primary_constructors/primary_constructors.dart (const-constructor)"?>
```dart
class const ConstPoint(final int x, final int y) {
  final int z;
  // A constant primary constructor can have an initializer list,
  // but can't have a body block.
  this : z = x + y;
}
```

Constant primary constructors have these important constraints:

常量主构造函数有这些重要约束：

*   **No body block**:
    Having a `{ ... }` body is a compile-time error, even if it's empty.
    A constant primary constructor can only use
    an initializer list followed by a semicolon.

    **不能有函数体**：
    即使 `{ ... }` 函数体是空的，也是编译时错误。
    常量主构造函数只能使用初始化列表，并以分号结束。
*   **Definitely initialized final fields**:
    Like any class with a generative const constructor,
    every instance variable must be `final`, can't be `late`,
    and must be definitely initialized by a declaring parameter,
    field initializer, or the primary constructor's initializer list.

    **final 字段必须确定初始化**：
    和任何带有生成式 const 构造函数的类一样，
    每个实例变量都必须是 `final`，不能是 `late`，
    并且必须由声明参数、字段初始化器
    或主构造函数的初始化列表确定初始化。
*   **[Potentially constant][] initializers**:
    The initializing expressions for each instance variable
    must be potentially constant.
    This includes field initializers and
    expressions in the primary constructor's initializer list.

    **[潜在常量][Potentially constant] 初始化器**：
    每个实例变量的初始化表达式都必须是潜在常量。
    这包括字段初始化器，
    以及主构造函数初始化列表中的表达式。

## Named primary constructors

## 命名主构造函数

You can also declare a primary constructor as
a **named constructor** by appending a dot (`.`) and
a name after the class name in the class header:

你也可以把主构造函数声明为 **命名构造函数**：
在类头部的类名后面加上点号（`.`）和名称：

<?code-excerpt "language/lib/primary_constructors/point.dart (point-named)" replace="/PointNamed/Point/g"?>
```dart
// A named primary constructor.
class Point.custom(var int x, var int y);
```

A common pattern is to define a
private primary constructor (such as `Point._`) that
restricts direct instantiation and
forces callers to use factory methods or other constructors:

一种常见的写法是定义私有主构造函数（例如 `Point._`），
限制直接实例化，
并要求调用方使用工厂方法或其它构造函数：

<?code-excerpt "language/lib/primary_constructors/point.dart (point-private)" replace="/PointPrivate/Point/g"?>
```dart
// A private named primary constructor.
class Point._(var int x, var int y);
```

## Super parameters

## super 参数

Super parameters work just like they do in traditional constructors,
allowing you to forward parameters to the superclass constructor:

super 参数的用法和传统构造函数里一样，
可以把参数转发给超类构造函数：

<?code-excerpt "language/lib/primary_constructors/super_parameters.dart (super-parameters)"?>
```dart
class Person(final String name, final int age);

class Employee(super.name, super.age, final String role) extends Person;
```

This reduces boilerplate in hierarchical class structures,
eliminating the need to manually write initializer lists
or duplicate parameter declarations.

这减少了分层类结构中的样板代码，
不必再手写初始化列表，也不必重复声明参数。

## Enum primary constructors

## 枚举的主构造函数

You can use primary constructors to declare
[enhanced enums][] much more concisely.

你可以用主构造函数更简洁地声明 [增强型枚举][enhanced enums]。

By using a primary constructor,
you can define the enum's fields and its constructor in a single line,
eliminating the usual boilerplate of
declaring fields, parameters, and initializing them:

使用主构造函数，
你可以在一行里定义枚举的字段和构造函数，
省去通常那些声明字段、参数并初始化它们的样板代码：

<?code-excerpt "language/lib/primary_constructors/primary_constructors.dart (enums)"?>
```dart
enum Color(final String hex) {
  red('#FF0000'),
  green('#00FF00'),
  blue('#0000FF');
}
```

Primary constructors in enums are **implicitly constant**.
While you can optionally write the `const` modifier before the enum name
(such as in `enum const Color`), it's redundant and can be omitted.

枚举中的主构造函数是 **隐式常量**。
你可以在枚举名之前可选地写上 `const` 修饰符
（例如 `enum const Color`），但这是多余的，可以省略。

[enhanced enums]: /language/enums#declaring-enhanced-enums

## Constraints and breaking changes

## 约束与破坏性变更

Keep these constraints and potential errors in mind
when using primary constructors:

使用主构造函数时，请记住这些约束和可能的错误：

*   **Declaring parameters can't be `late` or `external`**:
    The `late` and `external` modifiers aren't allowed
    on parameters in the primary constructor header.
    To use these modifiers, declare the fields in the class body as usual.

    **声明参数不能是 `late` 或 `external`**：
    主构造函数头部的参数不能使用 `late` 和 `external` 修饰符。
    要用这些修饰符，还是在类体里像往常一样声明字段。
*   **Name collisions**:
    Declaring a parameter in the primary constructor
    with the same name as a method or another field in the class body
    results in a compile-time error.

    **名称冲突**：
    如果主构造函数中的参数与类体里的方法或另一个字段同名，
    会导致编译时错误。
*   **No assignments to primary constructor parameters**:
    Primary constructor parameters are read-only
    within the primary initializer scope.
    Assigning to them (such as with `x = 5` or `x++`) in a field initializer or
    the primary constructor's initializer list is a compile-time error.

    **不能给主构造函数参数赋值**：
    在主初始化作用域中，主构造函数参数是只读的。
    在字段初始化器或主构造函数的初始化列表里给它们赋值
    （例如 `x = 5` 或 `x++`）是编译时错误。
*   **Double initialization**:
    You can't initialize an instance variable both in
    its declaration and in the primary constructor's initializer list
    (or as an initializing formal parameter), even if the field is mutable.
    Doing so results in a compile-time error.

    **重复初始化**：
    不能既在实例变量的声明中初始化它，
    又在主构造函数的初始化列表中初始化它
    （或把它当作初始化形参），即使该字段是可变的。
    这样做会导致编译时错误。
*   **Body part constraints**:

    **函数体部分的约束**：
    *   A primary constructor body part (the `this` block) can't
        use the `async`, `async*`, or `sync*` modifiers, and it
        can't use the expression body arrow (`=>`) syntax.

        主构造函数的函数体部分（`this` 块）不能使用
        `async`、`async*` 或 `sync*` 修饰符，
        也不能使用表达式函数体的箭头（`=>`）语法。
    *   You can't write a `this` block if the class header
        doesn't declare a primary constructor.

        如果类头部没有声明主构造函数，就不能写 `this` 块。
    *   A class can have at most one primary constructor body part.

        一个类最多只能有一个主构造函数函数体部分。
*   **Mixin class primary constructors must be trivial**:
    A mixin class can only declare a primary constructor if it has
    no parameters, no initializer list, and no body.

    **mixin 类的主构造函数必须是平凡的**：
    mixin 类只有在没有参数、没有初始化列表、也没有函数体时，
    才能声明主构造函数。
*   **Covariant parameters**:
    You can only use the `covariant` modifier on a
    primary constructor parameter if it's a
    mutable declaring parameter (uses the `var` modifier).

    **协变参数**：
    只有当主构造函数参数是可变的声明参数（使用 `var` 修饰符）时，
    才能对它使用 `covariant` 修饰符。
*   **The `factory` method edge case**:
    If you have a method named `factory` with no return type
    (for example, `factory() {}`),
    the compiler parses it as a concise factory constructor.
    Make sure such methods have an explicit return type
    (for example, `void factory() {}`) to avoid this conflict.

    **名为 `factory` 的方法这一边界情况**：
    如果有一个名为 `factory`、没有返回类型的方法
    （例如 `factory() {}`），
    编译器会把它解析为简洁工厂构造函数。
    这类方法要写上显式返回类型
    （例如 `void factory() {}`），以避免这种冲突。

### Parameter modifier restrictions {:#parameter-modifier-restrictions}

### 参数修饰符限制

The `final` and `var` parameter modifiers are reserved exclusively for
declaring parameters in primary constructors.
Using `final` or `var` on formal parameters in any other declaration
(such as top-level functions, methods, closures, and in-body constructors)
produces a compile-time error (`extraneous_modifier`).

`final` 和 `var` 参数修饰符专门保留给主构造函数中的声明参数。
在任何其它声明的形参上使用 `final` 或 `var`
（例如顶层函数、方法、闭包和类体内构造函数）
都会产生编译时错误（`extraneous_modifier`）。

<?code-excerpt "language/lib/primary_constructors/primary_constructors.dart (declaring-parameters-error)" replace="/PointFinal/Point/g; /printValue\(/printValue(final /g"?>
```dart
// Valid: Primary constructor declaring parameter.
class Point(final int x, final int y);

// Compile-time error (extraneous_modifier):
void printValue(final int x) => print(x);
```

To fix this error, remove the modifier or run [`dart fix`][].
To enforce immutable parameters as a style choice,
use the [`parameter_assignments`][] lint rule instead.

要修复这个错误，去掉修饰符，或者运行 [`dart fix`][]。
如果只是想用代码风格来约束参数不可变，
改用 [`parameter_assignments`][] lint 规则。

If you are on a [language version][] of 3.12 or lower,
you can enable the [`avoid_final_parameters`][] and
[`var_with_no_type_annotation`][] lint rules to proactively find and
remove these modifiers ahead of upgrading to Dart 3.13.

如果你使用的 [语言版本][language version] 是 3.12 或更低，
可以启用 [`avoid_final_parameters`][] 和
[`var_with_no_type_annotation`][] lint 规则，
在升级到 Dart 3.13 之前主动找出并去掉这些修饰符。

[`avoid_final_parameters`]: /tools/linter-rules/avoid_final_parameters
[`dart fix`]: /tools/dart-fix
[language version]: /language/versioning
[`parameter_assignments`]: /tools/linter-rules/parameter_assignments
[potentially constant]: /resources/glossary#potentially-constant
[`var_with_no_type_annotation`]: /tools/linter-rules/var_with_no_type_annotation
