---
# title: Patterns
title: 模式
# description: Summary of patterns in Dart.
description: "Dart 中模式的概述。"
ai-translated: true
prevpage:
  url: /language/type-system
# title: Type system
  title: 类型体系
nextpage:
  url: /language/pattern-types
# title: Pattern types
  title: 模式类型
---

:::version-note
Patterns require a [language version][] of at least 3.0.

模式要求 [语言版本][language version] 至少为 3.0。
:::

Patterns are a syntactic category in the Dart language,
like statements and expressions.
A pattern represents the shape of a set of values that
it might match against actual values.

模式是 Dart 语言中的一种语法范畴，和语句、表达式一样。
模式表示一组值的形状，
它可能会拿这个形状去匹配实际的值。

This page describes:

本页说明：

- What patterns do.

  模式做什么。
- Where patterns are allowed in Dart code.

  模式可以出现在 Dart 代码的哪些地方。
- What the common use cases for patterns are.

  模式的常见用途是什么。

To learn about the different kinds of patterns,
visit the [pattern types][types] page.

要了解不同种类的模式，
请访问 [模式类型][types] 页面。

## What patterns do

## 模式做什么

In general, a pattern can **match** a value, **destructure** a value, or both,
depending on the context and shape of the pattern.

一般来说，模式可以 **匹配** 一个值、**解构** 一个值，或两者都做，
具体取决于上下文和模式的形状。

First, _pattern matching_ allows you to check whether a given value:

首先，**模式匹配** 用来检查给定的值是否：

- Has a certain shape.

  具有某种形状。
- Is a certain constant.

  是某个常量。
- Is equal to something else.

  等于别的东西。
- Has a certain type.

  具有某种类型。

Then, _pattern destructuring_ provides you with a convenient declarative syntax to
break that value into its constituent parts. The same pattern can also let you 
bind variables to some or all of those parts in the process.

然后，**模式解构** 提供方便的声明式语法，
把这个值拆成它的组成部分。
同一个模式还可以在这个过程中，
把变量绑定到其中一部分或全部分量上。

### Matching

### 匹配

A pattern always tests against a value to determine if the value has the form
you expect. In other words, you are checking if the value _matches_ the pattern. 

模式总会对照一个值做测试，以判断该值是否具有你期望的形式。
换句话说，你在检查这个值是否 **匹配** 该模式。

What constitutes a match depends on [what kind of pattern][types] you are using.
For example, a constant pattern matches if the value is equal to the pattern's 
constant:

怎样才算匹配，取决于你使用的 [模式种类][types]。
例如，常量模式在值等于该模式的常量时匹配：

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

许多模式会使用子模式，有时分别称为 **外层** 模式和 **内层** 模式。
模式会递归地匹配它们的子模式。
例如，任何 [集合类型][collection-type] 模式的各个字段
都可以是 [变量模式][variable] 或 [常量模式][constant]：

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

要忽略已匹配值的某些部分，可以用 [通配符模式][wildcard pattern] 作为占位符。
对于列表模式，可以使用 [剩余元素][rest element]。

### Destructuring

### 解构

When an object and pattern match, the pattern can then access the object's data 
and extract it in parts. In other words, the pattern _destructures_ the object:

当对象与模式匹配时，模式就可以访问该对象的数据，
并把它拆成若干部分提取出来。
换句话说，模式会 **解构** 这个对象：

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

你可以在解构模式里嵌套 [任何种类的模式][types]。
例如，这个 case 模式会匹配并解构一个两元素列表，
且其第一个元素是 `'a'` 或 `'b'`：

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

模式可以用在 Dart 语言的好几个地方：

<a id="pattern-uses"></a>

- Local variable [declarations](#variable-declaration) and [assignments](#variable-assignment)

  局部变量 [声明](#variable-declaration) 和 [赋值](#variable-assignment)
- [for and for-in loops][for]

  [for 和 for-in 循环][for]
- [if-case][if] and [switch-case][switch]

  [if-case][if] 和 [switch-case][switch]
- Control flow in [collection literals][]

  [集合字面量][collection literals] 中的控制流

This section describes common use cases for matching and destructuring with patterns.

本节说明用模式进行匹配和解构的常见用途。

### Variable declaration

### 变量声明

You can use a _pattern variable declaration_ anywhere Dart allows local variable
declaration. 
The pattern matches against the value on the right of the declaration.
Once matched, it destructures the value and binds it to new local variables:

在 Dart 允许局部变量声明的任何地方，都可以使用 **模式变量声明**。
模式会匹配声明右侧的值。
一旦匹配，它就解构该值，并绑定到新的局部变量：

<?code-excerpt "language/lib/patterns/destructuring.dart (variable-declaration)"?>
```dart
// Declares new variables a, b, and c.
var (a, [b, c]) = ('str', [1, 2]);
```

A pattern variable declaration must start with either `var` or `final`, followed
by a pattern. 

模式变量声明必须以 `var` 或 `final` 开头，后面跟一个模式。

### Variable assignment 

### 变量赋值

A _variable assignment pattern_ falls on the left side of an assignment.
First, it destructures the matched object. Then it assigns the values to
_existing_ variables, instead of binding new ones. 

**变量赋值模式** 出现在赋值号的左侧。
它首先解构匹配到的对象，然后把值赋给 **已有** 变量，
而不是绑定新变量。

Use a variable assignment pattern to swap the values of two variables without
declaring a third temporary one:

可以用变量赋值模式交换两个变量的值，
而不必再声明第三个临时变量：

<?code-excerpt "language/lib/patterns/destructuring.dart (variable-assignment)"?>
```dart
var (a, b) = ('left', 'right');
(b, a) = (a, b); // Swap.
print('$a $b'); // Prints "right left".
```

### Switch statements and expressions

### switch 语句和表达式

Every case clause contains a pattern. This applies to [switch statements][switch]
and [expressions][], as well as [if-case statements][if].
You can use [any kind of pattern][types] in a case.

每个 case 子句都包含一个模式。
这适用于 [switch 语句][switch]、[表达式][expressions]，
以及 [if-case 语句][if]。
case 里可以使用 [任何种类的模式][types]。

_Case patterns_ are [refutable][].
They allow control flow to either:

**case 模式** 是 [可反驳的][refutable]。
它们让控制流可以：
- Match and destructure the object being switched on.

  匹配并解构正在被 switch 的对象。
- Continue execution if the object doesn't match.

  如果对象不匹配，就继续执行。

The values that a pattern destructures in a case become local variables.
Their scope is only within the body of that case.

模式在 case 中解构出来的值会成为局部变量。
它们的作用域只在该 case 的体内。

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

[逻辑或模式][logical-or] 适合让多个 case 在 switch 表达式或语句中共享同一个函数体：

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

switch 语句也可以 [不使用逻辑或模式][share]，让多个 case 共享函数体，
但逻辑或模式仍然有独特的作用：
它能让多个 case 共享一个 [守卫][guard]：

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

[守卫子句][guard] 把任意条件作为 case 的一部分来求值。
条件为 false 时不会退出 switch
（如果在 case 体里使用 `if` 语句，就会退出）。

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

### for 与 for-in 循环

You can use patterns in [for and for-in loops][for] to iterate-over and destructure
values in a collection.

可以在 [for 和 for-in 循环][for] 中使用模式，
在遍历集合的同时解构其中的值。

This example uses [object destructuring][object] in a for-in loop to destructure
the [`MapEntry`][] objects that a `<Map>.entries` call returns:

这个例子在 for-in 循环中使用 [对象解构][object]，
解构 `<Map>.entries` 调用返回的 [`MapEntry`][] 对象：

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

对象模式检查 `hist.entries` 的命名类型是 `MapEntry`，
然后递归进入名为 `key` 和 `value` 的字段子模式。
它在每次迭代中对 `MapEntry` 调用 `key` getter 和 `value` getter，
并把结果分别绑定到局部变量 `key` 和 `count`。

Binding the result of a getter call to a variable of the same name is a common
use case, so object patterns can also infer the getter name from the
[variable subpattern][variable]. This allows you to simplify the variable pattern
from something redundant like `key: key` to just `:key`:

把 getter 调用的结果绑定到同名变量是常见用法，
因此对象模式也可以从 [变量子模式][variable] 推断 getter 名称。
这样你就可以把多余的 `key: key` 简化成 `:key`：

<?code-excerpt "language/lib/patterns/for_in.dart (for-in-short)"?>
```dart
for (var MapEntry(:key, value: count) in hist.entries) {
  print('$key occurred $count times');
}
```

## Use cases for patterns

## 模式的使用场景

The [previous section](#places-patterns-can-appear)
describes _how_ patterns fit into other Dart code constructs. 
You saw some interesting use cases as examples, like [swapping](#variable-assignment)
the values of two variables, or
[destructuring key-value pairs](#for-and-for-in-loops)
in a map. This section describes even more use cases, answering:

[上一节](#places-patterns-can-appear)
说明了模式 **如何** 嵌入其它 Dart 代码结构。
你已经看到一些有意思的例子，比如 [交换](#variable-assignment) 两个变量的值，
或者 [解构映射中的键值对](#for-and-for-in-loops)。
本节说明更多使用场景，并回答：

- _When and why_ you might want to use patterns.

  **何时以及为何** 你会想使用模式。
- What kinds of problems they solve.

  它们解决哪一类问题。
- Which idioms they best suit.

  它们最适合哪些惯用法。

### Destructuring multiple returns

### 解构多个返回值

Records allow aggregating and [returning multiple values][] from a single
function call. Patterns add the ability to destructure a record's fields
directly into local variables, inline with the function call.

记录可以在一次函数调用中聚合并 [返回多个值][returning multiple values]。
模式则能把记录的字段直接解构到局部变量中，就写在函数调用旁边。

Instead of individually declaring new local variables for each record field,
like this:

不必像下面这样，为记录的每个字段分别声明新的局部变量：

<?code-excerpt "language/lib/patterns/destructuring.dart (destructure-multiple-returns-1)"?>
```dart
var info = userInfo(json);
var name = info.$1;
var age = info.$2;
```

You can destructure the fields of a record that a function returns into local
variables using a [variable declaration](#variable-declaration) or
[assignment pattern](#variable-assignment), and a [record pattern][record]
as its subpattern:

可以用 [变量声明](#variable-declaration) 或
[赋值模式](#variable-assignment)，再配上作为子模式的 [记录模式][record]，
把函数返回的记录字段解构到局部变量中：

<?code-excerpt "language/lib/patterns/destructuring.dart (destructure-multiple-returns-2)"?>
```dart
var (name, age) = userInfo(json);
```

To destructure a record with named fields using a pattern:

要用模式解构带命名字段的记录：

<?code-excerpt "language/lib/patterns/destructuring.dart (destructure-multiple-returns-3)"?>
```dart
final (:name, :age) =
    getData(); // For example, return (name: 'doug', age: 25);
```

### Destructuring class instances

### 解构类实例

[Object patterns][object] match against named object types, allowing
you to destructure their data using the getters the object's class already exposes.

[对象模式][object] 按命名对象类型进行匹配，
从而用该类已经暴露的 getter 来解构数据。

To destructure an instance of a class, use the named type, 
followed by the properties to 
destructure enclosed in parentheses:

要解构类的实例，先写命名类型，
再把要解构的属性放在圆括号里：

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

对象解构和 switch 的 case 很适合用 [代数数据类型][algebraic data type] 的风格写代码。
在以下情况使用这种方法：
- You have a family of related types.

  你有一族相关的类型。
- You have an operation that needs specific behavior for each type.

  你有一个操作，需要对每种类型采用特定行为。
- You want to group that behavior in one place instead of spreading it across all
the different type definitions. 

  你希望把这些行为集中在一处，而不是分散到各个类型定义里。

Instead of implementing the operation as an instance method for every type,
keep the operation's variations in a single function that switches over the subtypes:

不必把这个操作实现成每个类型上的实例方法，
可以把操作的各个变体放在一个函数里，对子类型做 switch：

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

### 校验传入的 JSON

[Map][] and [list][] patterns work well for destructuring key-value pairs in
deserialized data, such as data parsed from JSON:

[映射][Map] 模式和 [列表][list] 模式很适合解构反序列化数据中的键值对，
例如从 JSON 解析出来的数据：

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

如果你知道 JSON 数据具有期望的结构，
上一个例子就是现实可用的。
但数据通常来自外部，比如通过网络。
你需要先校验它，确认它的结构。

Without patterns, validation is verbose:

没有模式时，校验会很啰嗦：

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

单个 [case 模式](#switch-statements-and-expressions)
就能完成同样的校验。
单个 case 最适合写成 [if-case][if] 语句。
模式提供了一种更声明式、也简练得多的 JSON 校验方法：

<?code-excerpt "language/lib/patterns/json.dart (json-3)"?>
```dart
if (data case {'user': [String name, int age]}) {
  print('User $name is $age years old.');
}
```

This case pattern simultaneously validates that:

这个 case 模式会同时校验：

- `json` is a map, because it must first match the outer [map pattern][map] to proceed.

  `json` 是映射，因为它必须先匹配外层 [映射模式][map] 才能继续。
  - And, since it's a map, it also confirms `json` is not null.

    而且，既然它是映射，也就确认了 `json` 不是 null。
- `json` contains a key `user`.

  `json` 包含键 `user`。
- The key `user` pairs with a list of two values.

  键 `user` 对应一个包含两个值的列表。
- The types of the list values are `String` and `int`.

  列表值的类型是 `String` 和 `int`。
- The new local variables to hold the values are `name` and `age`. 

  用来保存这些值的新局部变量是 `name` 和 `age`。


[language version]: /language/versioning
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
