---
title: Patterns
title: 模式
description: Summary of patterns in Dart.
description: Dart 中模式的概述。
prevpage:
  url: /language/type-system
  title: Type system
  title: 类型系统
nextpage:
  url: /language/pattern-types
  title: Pattern types
  title: 模式类型
---

:::version-note
Patterns require a [language version][] of at least 3.0.

模式需要至少 3.0 的[语言版本][language version]。
:::

Patterns are a syntactic category in the Dart language, like statements and expressions.
A pattern represents the shape of a set of values that it may match against actual
values.

模式是 Dart 语言中的一个语法范畴，与语句和表达式类似。
模式表示一组值的形状，它可以与实际值进行匹配。

This page describes:
- What patterns do.
- Where patterns are allowed in Dart code.
- What the common use cases for patterns are.

本页描述：
- 模式的作用。
- Dart 代码中允许使用模式的位置。
- 模式的常见用例。

To learn about the different kinds of patterns, visit the [pattern types][types]
page.

要了解不同种类的模式，请访问[模式类型][types]页面。

## What patterns do

## 模式的作用

In general, a pattern may **match** a value, **destructure** a value, or both,
depending on the context and shape of the pattern.

一般来说，模式可以**匹配**一个值、**解构**一个值，或两者兼而有之，
这取决于模式的上下文和形状。

First, _pattern matching_ allows you to check whether a given value:
- Has a certain shape.
- Is a certain constant.
- Is equal to something else.
- Has a certain type.

首先，_模式匹配_允许你检查给定值是否：
- 具有某种形状。
- 是某个常量。
- 等于其他东西。
- 具有某种类型。

Then, _pattern destructuring_ provides you with a convenient declarative syntax to
break that value into its constituent parts. The same pattern can also let you
bind variables to some or all of those parts in the process.

然后，_模式解构_为你提供了一种方便的声明式语法，
将该值分解成其组成部分。同一模式还可以让你
在此过程中将变量绑定到这些部分的一部分或全部。

### Matching

### 匹配

A pattern always tests against a value to determine if the value has the form
you expect. In other words, you are checking if the value _matches_ the pattern.

模式总是针对一个值进行测试，以确定该值是否具有你期望的形式。
换句话说，你正在检查该值是否_匹配_模式。

What constitutes a match depends on [what kind of pattern][types] you are using.
For example, a constant pattern matches if the value is equal to the pattern's
constant:

什么构成匹配取决于你使用的[模式类型][types]。
例如，如果值等于模式的常量，则常量模式匹配：

<?code-excerpt "language/lib/patterns/switch.dart (constant-pattern)"?>
```dart
switch (number) {
  // Constant pattern matches if 1 == number.
  case 1:
    print('one');
}
```

Many patterns make use of subpatterns, sometimes called _outer_ and _inner_
patterns, respectively. Patterns match recursively on their subpatterns.
For example, the individual fields of any [collection-type][] pattern could be
[variable patterns][variable] or [constant patterns][constant]:

许多模式使用子模式，有时分别称为_外部_和_内部_模式。
模式在其子模式上递归匹配。
例如，任何[集合类型][collection-type]模式的各个字段可以是
[变量模式][variable]或[常量模式][constant]：

<?code-excerpt "language/lib/patterns/switch.dart (list-pattern)"?>
```dart
const a = 'a';
const b = 'b';
switch (obj) {
  // List pattern [a, b] matches obj first if obj is a list with two fields,
  // then if its fields match the constant subpatterns 'a' and 'b'.
  case [a, b]:
    print('$a, $b');
}
```

To ignore parts of a matched value, you can use a [wildcard pattern][]
as a placeholder. In the case of list patterns, you can use a [rest element][].

要忽略匹配值的部分，你可以使用[通配符模式][wildcard pattern]
作为占位符。对于列表模式，你可以使用[剩余元素][rest element]。

### Destructuring

### 解构

When an object and pattern match, the pattern can then access the object's data
and extract it in parts. In other words, the pattern _destructures_ the object:

当对象和模式匹配时，模式可以访问对象的数据并将其分解成部分。
换句话说，模式_解构_对象：

<?code-excerpt "language/lib/patterns/destructuring.dart (list-pattern)"?>
```dart
var numList = [1, 2, 3];
// List pattern [a, b, c] destructures the three elements from numList...
var [a, b, c] = numList;
// ...and assigns them to new variables.
print(a + b + c);
```

You can nest [any kind of pattern][types] inside a destructuring pattern.
For example, this case pattern matches and destructures a two-element
list whose first element is `'a'` or `'b'`:

你可以在解构模式中嵌套[任何类型的模式][types]。
例如，这个 case 模式匹配并解构一个两元素列表，
其第一个元素是 `'a'` 或 `'b'`：

<?code-excerpt "language/lib/patterns/destructuring.dart (nested-pattern)"?>
```dart
switch (list) {
  case ['a' || 'b', var c]:
    print(c);
}
```

## Places patterns can appear

## 模式可以出现的位置

You can use patterns in several places in the Dart language:

你可以在 Dart 语言中的多个位置使用模式：

<a id="pattern-uses"></a>

- Local variable [declarations](#variable-declaration) and [assignments](#variable-assignment)

  局部变量[声明](#variable-declaration)和[赋值](#variable-assignment)

- [for and for-in loops][for]

  [for 和 for-in 循环][for]

- [if-case][if] and [switch-case][switch]

  [if-case][if] 和 [switch-case][switch]

- Control flow in [collection literals][]

  [集合字面量][collection literals]中的控制流

This section describes common use cases for matching and destructuring with patterns.

本节描述使用模式进行匹配和解构的常见用例。

### Variable declaration

### 变量声明

You can use a _pattern variable declaration_ anywhere Dart allows local variable
declaration.
The pattern matches against the value on the right of the declaration.
Once matched, it destructures the value and binds it to new local variables:

你可以在 Dart 允许局部变量声明的任何地方使用_模式变量声明_。
模式与声明右侧的值进行匹配。
一旦匹配，它就解构该值并将其绑定到新的局部变量：

<?code-excerpt "language/lib/patterns/destructuring.dart (variable-declaration)"?>
```dart
// Declares new variables a, b, and c.
var (a, [b, c]) = ('str', [1, 2]);
```

A pattern variable declaration must start with either `var` or `final`, followed
by a pattern.

模式变量声明必须以 `var` 或 `final` 开头，后跟模式。 

### Variable assignment

### 变量赋值

A _variable assignment pattern_ falls on the left side of an assignment.
First, it destructures the matched object. Then it assigns the values to
_existing_ variables, instead of binding new ones.

_变量赋值模式_位于赋值的左侧。
首先，它解构匹配的对象。然后它将值赋给_现有_变量，
而不是绑定新变量。

Use a variable assignment pattern to swap the values of two variables without
declaring a third temporary one:

使用变量赋值模式交换两个变量的值，而无需声明第三个临时变量：

<?code-excerpt "language/lib/patterns/destructuring.dart (variable-assignment)"?>
```dart
var (a, b) = ('left', 'right');
(b, a) = (a, b); // Swap.
print('$a $b'); // Prints "right left".
```

### Switch statements and expressions

### Switch 语句和表达式

Every case clause contains a pattern. This applies to [switch statements][switch]
and [expressions][], as well as [if-case statements][if].
You can use [any kind of pattern][types] in a case.

每个 case 子句都包含一个模式。这适用于 [switch 语句][switch]
和[表达式][expressions]，以及 [if-case 语句][if]。
你可以在 case 中使用[任何类型的模式][types]。

_Case patterns_ are [refutable][].
They allow control flow to either:
- Match and destructure the object being switched on.
- Continue execution if the object doesn't match.

_Case 模式_是[可反驳的][refutable]。
它们允许控制流：
- 匹配并解构被 switch 的对象。
- 如果对象不匹配则继续执行。

The values that a pattern destructures in a case become local variables.
Their scope is only within the body of that case.

模式在 case 中解构的值成为局部变量。
它们的作用域仅在该 case 的主体内。

<?code-excerpt "language/lib/patterns/switch.dart (switch-statement)"?>
```dart
switch (obj) {
  // Matches if 1 == obj.
  case 1:
    print('one');

  // Matches if the value of obj is between the
  // constant values of 'first' and 'last'.
  case >= first && <= last:
    print('in range');

  // Matches if obj is a record with two fields,
  // then assigns the fields to 'a' and 'b'.
  case (var a, var b):
    print('a = $a, b = $b');

  default:
}
```

<a id="or-pattern-switch"></a>

[Logical-or patterns][logical-or] are useful for having multiple cases share a
body in switch expressions or statements:

[逻辑或模式][logical-or]对于在 switch 表达式或语句中让多个 case 共享主体很有用：

<?code-excerpt "language/lib/patterns/switch.dart (or-share-body)"?>
```dart
var isPrimary = switch (color) {
  Color.red || Color.yellow || Color.blue => true,
  _ => false,
};
```

Switch statements can have multiple cases share a body
[without using logical-or patterns][share], but they are
still uniquely useful for allowing multiple cases to share a [guard][]:

Switch 语句可以[不使用逻辑或模式][share]让多个 case 共享主体，
但它们对于允许多个 case 共享 [guard][] 仍然非常有用：

<?code-excerpt "language/lib/patterns/switch.dart (or-share-guard)"?>
```dart
switch (shape) {
  case Square(size: var s) || Circle(size: var s) when s > 0:
    print('Non-empty symmetric shape');
}
```

[Guard clauses][guard] evaluate an arbitrary condition as part of a case, without
exiting the switch if the condition is false
(like using an `if` statement in the case body would cause).

[Guard 子句][guard]作为 case 的一部分评估任意条件，
如果条件为 false 不会退出 switch
（不像在 case 主体中使用 `if` 语句那样会导致退出）。

<?code-excerpt "language/lib/control_flow/branches.dart (guard)"?>
```dart
switch (pair) {
  case (int a, int b):
    if (a > b) print('First element greater');
  // If false, prints nothing and exits the switch.
  case (int a, int b) when a > b:
    // If false, prints nothing but proceeds to next case.
    print('First element greater');
  case (int a, int b):
    print('First element not greater');
}
```

### For and for-in loops

### For 和 for-in 循环

You can use patterns in [for and for-in loops][for] to iterate-over and destructure
values in a collection.

你可以在 [for 和 for-in 循环][for]中使用模式来迭代和解构集合中的值。

This example uses [object destructuring][object] in a for-in loop to destructure
the [`MapEntry`][] objects that a `<Map>.entries` call returns:

此示例在 for-in 循环中使用[对象解构][object]来解构
`<Map>.entries` 调用返回的 [`MapEntry`][] 对象：

<?code-excerpt "language/lib/patterns/for_in.dart (for-in-pattern)"?>
```dart
Map<String, int> hist = {'a': 23, 'b': 100};

for (var MapEntry(key: key, value: count) in hist.entries) {
  print('$key occurred $count times');
}
```

The object pattern checks that `hist.entries` has the named type `MapEntry`,
and then recurses into the named field subpatterns `key` and `value`.
It calls the `key` getter and `value` getter on the `MapEntry` in each iteration,
and binds the results to local variables `key` and `count`, respectively.

对象模式检查 `hist.entries` 是否具有命名类型 `MapEntry`，
然后递归进入命名字段子模式 `key` 和 `value`。
它在每次迭代中调用 `MapEntry` 上的 `key` getter 和 `value` getter，
并将结果分别绑定到局部变量 `key` 和 `count`。

Binding the result of a getter call to a variable of the same name is a common
use case, so object patterns can also infer the getter name from the
[variable subpattern][variable]. This allows you to simplify the variable pattern
from something redundant like `key: key` to just `:key`:

将 getter 调用的结果绑定到同名变量是一个常见用例，
因此对象模式还可以从[变量子模式][variable]推断 getter 名称。
这允许你将变量模式从冗余的 `key: key` 简化为 `:key`：

<?code-excerpt "language/lib/patterns/for_in.dart (for-in-short)"?>
```dart
for (var MapEntry(:key, value: count) in hist.entries) {
  print('$key occurred $count times');
}
```

## Use cases for patterns

## 模式的用例

The [previous section](#places-patterns-can-appear)
describes _how_ patterns fit into other Dart code constructs.
You saw some interesting use cases as examples, like [swapping](#variable-assignment)
the values of two variables, or
[destructuring key-value pairs](#for-and-for-in-loops)
in a map. This section describes even more use cases, answering:

[上一节](#places-patterns-can-appear)描述了模式_如何_融入其他 Dart 代码结构。
你看到了一些有趣的用例示例，比如[交换](#variable-assignment)两个变量的值，
或在 map 中[解构键值对](#for-and-for-in-loops)。
本节描述更多用例，回答：

- _When and why_ you might want to use patterns.
- What kinds of problems they solve.
- Which idioms they best suit.

- 你_何时以及为何_可能想要使用模式。
- 它们解决什么类型的问题。
- 它们最适合哪些惯用法。

### Destructuring multiple returns

### 解构多个返回值

Records allow aggregating and [returning multiple values][] from a single
function call. Patterns add the ability to destructure a record's fields
directly into local variables, inline with the function call.

Records 允许从单个函数调用[聚合和返回多个值][returning multiple values]。
模式添加了将 record 的字段直接解构到局部变量中的能力，与函数调用内联。

Instead of individually declaring new local variables for each record field,
like this:

而不是像这样为每个 record 字段单独声明新的局部变量：

<?code-excerpt "language/lib/patterns/destructuring.dart (destructure-multiple-returns-1)"?>
```dart
var info = userInfo(json);
var name = info.$1;
var age = info.$2;
```

You can destructure the fields of a record that a function returns into local
variables using a [variable declaration](#variable-declaration) or
[assigment pattern](#variable-assignment), and a [record pattern][record]
as its subpattern:

你可以使用[变量声明](#variable-declaration)或
[赋值模式](#variable-assignment)，以及作为其子模式的 [record 模式][record]，
将函数返回的 record 的字段解构到局部变量中：

<?code-excerpt "language/lib/patterns/destructuring.dart (destructure-multiple-returns-2)"?>
```dart
var (name, age) = userInfo(json);
```

To destructure a record with named fields using a pattern:

使用模式解构具有命名字段的 record：

<?code-excerpt "language/lib/patterns/destructuring.dart (destructure-multiple-returns-3)"?>
```dart
final (:name, :age) =
    getData(); // For example, return (name: 'doug', age: 25);
```

### Destructuring class instances

### 解构类实例

[Object patterns][object] match against named object types, allowing
you to destructure their data using the getters the object's class already exposes.

[对象模式][object]与命名对象类型匹配，
允许你使用对象的类已公开的 getter 解构其数据。

To destructure an instance of a class, use the named type,
followed by the properties to
destructure enclosed in parentheses:

要解构类的实例，使用命名类型，
后跟用括号括起来的要解构的属性：

<?code-excerpt "language/lib/patterns/destructuring.dart (destructure-class-instances)"?>
```dart
final Foo myFoo = Foo(one: 'one', two: 2);
var Foo(:one, :two) = myFoo;
print('one $one, two $two');
```

### Algebraic data types

### 代数数据类型

Object destructuring and switch cases are conducive to writing
code in an [algebraic data type][] style.
Use this method when:
- You have a family of related types.
- You have an operation that needs specific behavior for each type.
- You want to group that behavior in one place instead of spreading it across all
the different type definitions.

对象解构和 switch case 有利于以[代数数据类型][algebraic data type]风格编写代码。
在以下情况下使用此方法：
- 你有一系列相关类型。
- 你有一个需要针对每种类型特定行为的操作。
- 你想将该行为集中在一个地方，而不是分散在所有不同的类型定义中。

Instead of implementing the operation as an instance method for every type,
keep the operation's variations in a single function that switches over the subtypes:

不要将操作实现为每种类型的实例方法，
而是将操作的变体保留在一个对子类型进行 switch 的单个函数中：

<?code-excerpt "language/lib/patterns/algebraic_datatypes.dart (algebraic-datatypes)"?>
```dart
sealed class Shape {}

class Square implements Shape {
  final double length;
  Square(this.length);
}

class Circle implements Shape {
  final double radius;
  Circle(this.radius);
}

double calculateArea(Shape shape) => switch (shape) {
  Square(length: var l) => l * l,
  Circle(radius: var r) => math.pi * r * r,
};
```

### Validating incoming JSON

### 验证传入的 JSON

[Map][] and [list][] patterns work well for destructuring key-value pairs in
deserialized data, such as data parsed from JSON:

[Map][] 和 [list][] 模式非常适合解构反序列化数据中的键值对，
例如从 JSON 解析的数据：

<?code-excerpt "language/lib/patterns/json.dart (json-1)"?>
```dart
var data = {
  'user': ['Lily', 13],
};
var {'user': [name, age]} = data;
```

If you know that the JSON data has the structure you expect,
the previous example is realistic.
But data typically comes from an external source, like over the network.
You need to validate it first to confirm its structure.

如果你知道 JSON 数据具有你期望的结构，
前面的示例是实际的。
但数据通常来自外部源，例如通过网络。
你需要首先验证它以确认其结构。

Without patterns, validation is verbose:

没有模式，验证是冗长的：

<?code-excerpt "language/lib/patterns/json.dart (json-2)"?>
```dart
if (data is Map<String, Object?> &&
    data.length == 1 &&
    data.containsKey('user')) {
  var user = data['user'];
  if (user is List<Object> &&
      user.length == 2 &&
      user[0] is String &&
      user[1] is int) {
    var name = user[0] as String;
    var age = user[1] as int;
    print('User $name is $age years old.');
  }
}
```

A single [case pattern](#switch-statements-and-expressions)
can achieve the same validation.
Single cases work best as [if-case][if] statements.
Patterns provide a more declarative, and much less verbose
method of validating JSON:

单个 [case 模式](#switch-statements-and-expressions)可以实现相同的验证。
单个 case 最适合作为 [if-case][if] 语句。
模式提供了一种更具声明性且更简洁的验证 JSON 的方法：

<?code-excerpt "language/lib/patterns/json.dart (json-3)"?>
```dart
if (data case {'user': [String name, int age]}) {
  print('User $name is $age years old.');
}
```

This case pattern simultaneously validates that:

此 case 模式同时验证：

- `json` is a map, because it must first match the outer [map pattern][map] to proceed.
  - And, since it's a map, it also confirms `json` is not null.

  `json` 是一个 map，因为它必须首先匹配外部 [map 模式][map]才能继续。
  - 而且，由于它是 map，它还确认 `json` 不为 null。

- `json` contains a key `user`.

  `json` 包含键 `user`。

- The key `user` pairs with a list of two values.

  键 `user` 与一个包含两个值的列表配对。

- The types of the list values are `String` and `int`.

  列表值的类型是 `String` 和 `int`。

- The new local variables to hold the values are `name` and `age`.

  用于保存值的新局部变量是 `name` 和 `age`。 


[language version]: /resources/language/evolution#language-versioning
[types]: /language/pattern-types
[collection-type]: /language/collections
[wildcard pattern]: /language/pattern-types#wildcard
[rest element]: /language/pattern-types#rest-element
[null-check pattern]: /language/pattern-types#null-check
[for]: /language/loops#for-loops
[if]: /language/branches#if-case
[switch]: /language/branches#switch-statements
[expressions]: /language/branches#switch-expressions
[collection literals]: /language/collections#control-flow-operators
[null-assert pattern]: /language/pattern-types#null-assert
[record]: /language/pattern-types#record
[returning multiple values]: /language/records#multiple-returns
[refutable]: /resources/glossary#refutable-pattern
[constant]: /language/pattern-types#constant
[list]: /language/pattern-types#list
[map]: /language/pattern-types#map
[variable]: /language/pattern-types#variable
[logical-or]: /language/pattern-types#logical-or
[share]: /language/branches#switch-share
[guard]: /language/branches#guard-clause
[relational]: /language/pattern-types#relational
[check]: /language/pattern-types#null-check
[assert]: /language/pattern-types#null-assert
[object]: /language/pattern-types#object
[`MapEntry`]: {{site.dart-api}}/dart-core/MapEntry-class.html
[algebraic data type]: https://en.wikipedia.org/wiki/Algebraic_data_type
