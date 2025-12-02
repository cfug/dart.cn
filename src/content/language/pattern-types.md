---
title: Pattern types
title: 模式类型
description: Pattern type reference in Dart.
description: Dart 中的模式类型参考。
prevpage:
  url: /language/patterns
  title: Patterns
  title: 模式
nextpage:
  url: /language/loops
  title: Loops
  title: 循环
---

This page is a reference for the different kinds of patterns.
For an overview of how patterns work, where you can use them in Dart, and common
use cases, visit the main [Patterns][] page.

本页是不同类型模式的参考。
有关模式如何工作、在 Dart 中可以使用它们的位置以及常见用例的概述，
请访问主[模式][Patterns]页面。

#### Pattern precedence

#### 模式优先级

Similar to [operator precedence](/language/operators#operator-precedence-example),
pattern evaluation adheres to precedence rules.
You can use [parenthesized patterns](#parenthesized) to
evaluate lower-precedence patterns first.

与[运算符优先级](/language/operators#operator-precedence-example)类似，
模式评估遵循优先级规则。
你可以使用[括号模式](#parenthesized)来首先评估较低优先级的模式。

This document lists the pattern types in ascending order of precedence:

本文档按优先级升序列出模式类型：

* [Logical-or](#logical-or) patterns are lower-precedence than [logical-and](#logical-and),
logical-and patterns are lower-precedence than [relational](#relational) patterns,
and so on.

  [逻辑或](#logical-or)模式的优先级低于[逻辑与](#logical-and)，
  逻辑与模式的优先级低于[关系](#relational)模式，依此类推。

* Post-fix unary patterns ([cast](#cast), [null-check](#null-check),
and [null-assert](#null-assert)) share the same level of precedence.

  后缀一元模式（[类型转换](#cast)、[空检查](#null-check)和[空断言](#null-assert)）
  共享相同的优先级。

* The remaining primary patterns share the highest precedence.
Collection-type ([record](#record), [list](#list), and [map](#map))
and [Object](#object) patterns encompass other
data, so are evaluated first as outer-patterns.

  其余的主要模式共享最高优先级。
  集合类型（[record](#record)、[list](#list)和 [map](#map)）
  和[对象](#object)模式包含其他数据，因此作为外部模式首先被评估。 

## Logical-or

## 逻辑或

`subpattern1 || subpattern2`

A logical-or pattern separates subpatterns by `||` and matches if any of the
branches match. Branches are evaluated left-to-right. Once a branch matches, the
rest are not evaluated.

逻辑或模式通过 `||` 分隔子模式，如果任何分支匹配则匹配。
分支从左到右评估。一旦分支匹配，其余的不会被评估。

<?code-excerpt "language/lib/patterns/pattern_types.dart (logical-or)"?>
```dart
var isPrimary = switch (color) {
  Color.red || Color.yellow || Color.blue => true,
  _ => false,
};
```

Subpatterns in a logical-or pattern can bind variables, but the branches must
define the same set of variables, because only one branch will be evaluated when
the pattern matches.

逻辑或模式中的子模式可以绑定变量，但分支必须定义相同的变量集，
因为当模式匹配时只有一个分支会被评估。

## Logical-and

## 逻辑与

`subpattern1 && subpattern2`

A pair of patterns separated by `&&` matches only if both subpatterns match. If the
left branch does not match, the right branch is not evaluated.

由 `&&` 分隔的一对模式仅在两个子模式都匹配时才匹配。
如果左分支不匹配，则不评估右分支。

Subpatterns in a logical-and pattern can bind variables, but the variables in
each subpattern must not overlap, because they will both be bound if the pattern
matches:

逻辑与模式中的子模式可以绑定变量，但每个子模式中的变量不能重叠，
因为如果模式匹配，它们都会被绑定：

<?code-excerpt "language/lib/patterns/pattern_types.dart (logical-and)"?>
```dart
switch ((1, 2)) {
  // Error, both subpatterns attempt to bind 'b'.
  case (var a, var b) && (var b, var c): // ...
}
```

## Relational

## 关系

`== expression`

`< expression`

Relational patterns compare the matched value to a given constant using any of
the equality or relational operators: `==`, `!=`, `<`, `>`, `<=`, and `>=`.

关系模式使用任何相等或关系运算符将匹配的值与给定常量进行比较：
`==`、`!=`、`<`、`>`、`<=` 和 `>=`。

The pattern matches when calling the appropriate operator on the matched value
with the constant as an argument returns `true`.

当在匹配的值上调用适当的运算符并以常量作为参数返回 `true` 时，模式匹配。

Relational patterns are useful for matching on numeric ranges, especially when
combined with the [logical-and pattern](#logical-and):

关系模式对于匹配数字范围很有用，特别是与[逻辑与模式](#logical-and)结合使用时：

<?code-excerpt "language/lib/patterns/pattern_types.dart (relational)"?>
```dart
String asciiCharType(int char) {
  const space = 32;
  const zero = 48;
  const nine = 57;

  return switch (char) {
    < space => 'control',
    == space => 'space',
    > space && < zero => 'punctuation',
    >= zero && <= nine => 'digit',
    _ => '',
  };
}
```

## Cast

## 类型转换

`foo as String`

A cast pattern lets you insert a [type cast][] in the middle of destructuring,
before passing the value to another subpattern:

类型转换模式允许你在解构过程中插入[类型转换][type cast]，
然后将值传递给另一个子模式：

<?code-excerpt "language/lib/patterns/pattern_types.dart (cast)"?>
```dart
(num, Object) record = (1, 's');
var (i as int, s as String) = record;
```

Cast patterns will [throw][] if the value doesn't have the stated type.
Like the [null-assert pattern](#null-assert), this lets you forcibly assert the
expected type of some destructured value.

如果值没有声明的类型，类型转换模式将[抛出][throw]异常。
与[空断言模式](#null-assert)类似，这允许你强制断言某些解构值的预期类型。

## Null-check

## 空检查

`subpattern?`

Null-check patterns match first if the value is not null, and then match the inner
pattern against that same value. They let you bind a variable whose type is the
non-nullable base type of the nullable value being matched.

空检查模式首先在值不为 null 时匹配，然后将内部模式与同一值匹配。
它们让你绑定一个变量，其类型是被匹配的可空值的非空基本类型。

To treat `null` values as match failures
without throwing, use the null-check pattern.

要将 `null` 值视为匹配失败而不抛出异常，请使用空检查模式。

<?code-excerpt "language/lib/patterns/pattern_types.dart (null-check)"?>
```dart
String? maybeString = 'nullable with base type String';
switch (maybeString) {
  case var s?:
  // 's' has type non-nullable String here.
}
```

To match when the value _is_ null, use the [constant pattern](#constant) `null`.

要在值_为_ null 时匹配，请使用[常量模式](#constant) `null`。

## Null-assert

## 空断言

`subpattern!`

Null-assert patterns match first if the object is not null, then on the value.
They permit non-null values to flow through, but [throw][] if the matched value
is null.

空断言模式首先在对象不为 null 时匹配，然后匹配值。
它们允许非空值通过，但如果匹配的值为 null 则[抛出][throw]异常。

To ensure `null` values are not silently treated as match failures,
use a null-assert pattern while matching:

为确保 `null` 值不会被静默地视为匹配失败，
请在匹配时使用空断言模式：

<?code-excerpt "language/lib/patterns/pattern_types.dart (null-assert-match)"?>
```dart
List<String?> row = ['user', null];
switch (row) {
  case ['user', var name!]: // ...
  // 'name' is a non-nullable string here.
}
```

To eliminate `null` values from variable declaration patterns,
use the null-assert pattern:

要从变量声明模式中消除 `null` 值，请使用空断言模式：

<?code-excerpt "language/lib/patterns/pattern_types.dart (null-assert-dec)"?>
```dart
(int?, int?) position = (2, 3);

var (x!, y!) = position;
```

To match when the value _is_ null, use the [constant pattern](#constant) `null`.

要在值_为_ null 时匹配，请使用[常量模式](#constant) `null`。

## Constant

## 常量

`123, null, 'string', math.pi, SomeClass.constant, const Thing(1, 2), const (1 + 2)`

Constant patterns match when the value is equal to the constant:

当值等于常量时，常量模式匹配：

<?code-excerpt "language/lib/patterns/pattern_types.dart (constant)"?>
```dart
switch (number) {
  // Matches if 1 == number.
  case 1: // ...
}
```

You can use simple literals and references to named constants directly as constant patterns:

你可以直接使用简单字面量和对命名常量的引用作为常量模式：

- Number literals (`123`, `45.56`)

  数字字面量（`123`、`45.56`）

- Boolean literals (`true`)

  布尔字面量（`true`）

- String literals (`'string'`)

  字符串字面量（`'string'`）

- Named constants (`someConstant`, `math.pi`, `double.infinity`)

  命名常量（`someConstant`、`math.pi`、`double.infinity`）

- Constant constructors (`const Point(0, 0)`)

  常量构造函数（`const Point(0, 0)`）

- Constant collection literals (`const []`, `const {1, 2}`)

  常量集合字面量（`const []`、`const {1, 2}`）

More complex constant expressions must be parenthesized and prefixed with
`const` (`const (1 + 2)`):

更复杂的常量表达式必须用括号括起来并以 `const` 为前缀（`const (1 + 2)`）：

<?code-excerpt "language/lib/patterns/pattern_types.dart (complex-constant)"?>
```dart
// List or map pattern:
case [a, b]: // ...

// List or map literal:
case const [a, b]: // ...
```

## Variable

## 变量

`var bar, String str, final int _`

Variable patterns bind new variables to values that have been matched or destructured.
They usually occur as part of a [destructuring pattern][destructure] to
capture a destructured value.

变量模式将新变量绑定到已匹配或解构的值。
它们通常作为[解构模式][destructure]的一部分出现，以捕获解构的值。

The variables are in scope in a region of code that is only reachable when the
pattern has matched.

变量在仅当模式匹配时才可访问的代码区域内有效。

<?code-excerpt "language/lib/patterns/pattern_types.dart (variable)"?>
```dart
switch ((1, 2)) {
  // 'var a' and 'var b' are variable patterns that bind to 1 and 2, respectively.
  case (var a, var b): // ...
  // 'a' and 'b' are in scope in the case body.
}
```

A _typed_ variable pattern only matches if the matched value has the declared type,
and fails otherwise:

_带类型_的变量模式仅在匹配的值具有声明的类型时才匹配，否则失败：

<?code-excerpt "language/lib/patterns/pattern_types.dart (variable-typed)"?>
```dart
switch ((1, 2)) {
  // Does not match.
  case (int a, String b): // ...
}
```

You can use a [wildcard pattern](#wildcard) as a variable pattern.

你可以使用[通配符模式](#wildcard)作为变量模式。 

## Identifier

## 标识符

`foo, _`

Identifier patterns may behave like a [constant pattern](#constant) or like a
[variable pattern](#variable), depending on the context where they appear:

标识符模式可能表现得像[常量模式](#constant)或像[变量模式](#variable)，
这取决于它们出现的上下文：

- [Declaration][] context: declares a new variable with identifier name:
  `var (a, b) = (1, 2);`

  [声明][Declaration]上下文：用标识符名称声明新变量：`var (a, b) = (1, 2);`

- [Assignment][] context: assigns to existing variable with identifier name:
  `(a, b) = (3, 4);`

  [赋值][Assignment]上下文：赋值给具有标识符名称的现有变量：`(a, b) = (3, 4);`

- [Matching][] context: treated as a named constant pattern (unless its name is `_`):

  [匹配][Matching]上下文：被视为命名常量模式（除非其名称为 `_`）：

  <?code-excerpt "language/lib/patterns/pattern_types.dart (match-context)"?>
  ```dart
  const c = 1;
  switch (2) {
    case c:
      print('match $c');
    default:
      print('no match'); // Prints "no match".
  }
  ```
- [Wildcard](#wildcard) identifier in any context: matches any value and discards it:
  `case [_, var y, _]: print('The middle element is $y');`

  任何上下文中的[通配符](#wildcard)标识符：匹配任何值并丢弃它：
  `case [_, var y, _]: print('The middle element is $y');`

## Parenthesized

## 括号

`(subpattern)`

Like parenthesized expressions, parentheses in a pattern let you control
[pattern precedence](#pattern-precedence) and insert a lower-precedence
pattern where a higher precedence one is expected.

与括号表达式类似，模式中的括号让你控制[模式优先级](#pattern-precedence)
并在期望更高优先级模式的地方插入较低优先级的模式。

For example, imagine the boolean constants `x`, `y`, and `z`
equal `true`, `true`, and `false`, respectively.
Though the following example resembles boolean expression evaluation,
the example matches patterns.

例如，假设布尔常量 `x`、`y` 和 `z` 分别等于 `true`、`true` 和 `false`。
虽然以下示例类似于布尔表达式求值，但该示例匹配模式。

<?code-excerpt "language/lib/patterns/pattern_types.dart (parens)"?>
```dart
// ...
x || y => 'matches true',
x || y && z => 'matches true',
x || (y && z) => 'matches true',
// `x || y && z` is the same thing as `x || (y && z)`.
(x || y) && z => 'matches nothing',
// ...
```

Dart starts matching the pattern from left to right.

Dart 从左到右开始匹配模式。

1. The first pattern matches `true` as `x` matches `true`.

   第一个模式匹配 `true`，因为 `x` 匹配 `true`。

1. The second pattern matches `true` as `x` matches `true`.

   第二个模式匹配 `true`，因为 `x` 匹配 `true`。

1. The third pattern matches `true` as `x` matches `true`.

   第三个模式匹配 `true`，因为 `x` 匹配 `true`。

1. The fourth pattern `(x || y) && z` has no match.

   第四个模式 `(x || y) && z` 没有匹配。

   * The `x` matches `true`, so Dart doesn't try to match `y`.

     `x` 匹配 `true`，所以 Dart 不会尝试匹配 `y`。

   * Though `(x || y)` matches `true`, `z` doesn't match `true`

     虽然 `(x || y)` 匹配 `true`，但 `z` 不匹配 `true`

   * Therefore, pattern `(x || y) && z` doesn't match `true`.

     因此，模式 `(x || y) && z` 不匹配 `true`。

   * The subpattern `(x || y)` doesn't match `false`,
     so Dart doesn't try to match `z`.

     子模式 `(x || y)` 不匹配 `false`，所以 Dart 不会尝试匹配 `z`。

   * Therefore, pattern `(x || y) && z` doesn't match `false`.

     因此，模式 `(x || y) && z` 不匹配 `false`。

   * As a conclusion, `(x || y) && z` has no match.

     总之，`(x || y) && z` 没有匹配。

## List

## 列表

`[subpattern1, subpattern2]`

A list pattern matches values that implement [`List`][], and then recursively
matches its subpatterns against the list's elements to destructure them by position:

列表模式匹配实现 [`List`][] 的值，然后递归地将其子模式与列表的元素匹配，
以按位置解构它们：

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

List patterns require that the number of elements in the pattern match the entire
list. You can, however, use a [rest element](#rest-element) as a place holder to
account for any number of elements in a list.

列表模式要求模式中的元素数量与整个列表匹配。
但是，你可以使用[剩余元素](#rest-element)作为占位符来处理列表中任意数量的元素。

### Rest element

### 剩余元素

List patterns can contain _one_ rest element (`...`) which allows matching lists
of arbitrary lengths.

列表模式可以包含_一个_剩余元素（`...`），允许匹配任意长度的列表。

<?code-excerpt "language/lib/patterns/pattern_types.dart (rest)"?>
```dart
var [a, b, ..., c, d] = [1, 2, 3, 4, 5, 6, 7];
// Prints "1 2 6 7".
print('$a $b $c $d');
```

A rest element can also have a subpattern that collects elements that don't match
the other subpatterns in the list, into a new list:

剩余元素还可以有一个子模式，将列表中与其他子模式不匹配的元素收集到新列表中：

<?code-excerpt "language/lib/patterns/pattern_types.dart (rest-sub)"?>
```dart
var [a, b, ...rest, c, d] = [1, 2, 3, 4, 5, 6, 7];
// Prints "1 2 [3, 4, 5] 6 7".
print('$a $b $rest $c $d');
```

## Map

## 映射

`{"key": subpattern1, someConst: subpattern2}`

Map patterns match values that implement [`Map`][], and then recursively
match its subpatterns against the map's keys to destructure them.

映射模式匹配实现 [`Map`][] 的值，然后递归地将其子模式与映射的键匹配以解构它们。

Map patterns don't require the pattern to match the entire map. A map pattern
ignores any keys that the map contains that aren't matched by the pattern.
Trying to match a key that does not exist in the map will
throw a [`StateError`][]:

映射模式不要求模式匹配整个映射。映射模式忽略映射中包含的任何未被模式匹配的键。
尝试匹配映射中不存在的键将抛出 [`StateError`][]：

<?code-excerpt "language/lib/patterns/pattern_types.dart (map-error)"?>
```dart
final {'foo': int? foo} = {};
```

## Record

## Record

`(subpattern1, subpattern2)`

`(x: subpattern1, y: subpattern2)`

Record patterns match a [record][] object and destructure its fields.
If the value isn't a record with the same [shape][] as the pattern, the match
fails. Otherwise, the field subpatterns are matched against the corresponding
fields in the record.

Record 模式匹配 [record][] 对象并解构其字段。
如果值不是与模式具有相同[形状][shape]的 record，则匹配失败。
否则，字段子模式与 record 中的相应字段匹配。

Record patterns require that the pattern match the entire record. To destructure
a record with _named_ fields using a pattern, include the field names in the pattern:

Record 模式要求模式匹配整个 record。要使用模式解构具有_命名_字段的 record，
请在模式中包含字段名称：

<?code-excerpt "language/lib/patterns/pattern_types.dart (record)"?>
```dart
var (myString: foo, myNumber: bar) = (myString: 'string', myNumber: 1);
```

The getter name can be omitted and inferred from the [variable pattern](#variable)
or [identifier pattern](#identifier) in the field subpattern. These pairs of
patterns are each equivalent:

getter 名称可以省略，并从字段子模式中的[变量模式](#variable)
或[标识符模式](#identifier)推断。这些模式对是等价的：

<?code-excerpt "language/lib/patterns/pattern_types.dart (record-getter)"?>
```dart
// Record pattern with variable subpatterns:
var (untyped: untyped, typed: int typed) = record;
var (:untyped, :int typed) = record;

switch (record) {
  case (untyped: var untyped, typed: int typed): // ...
  case (:var untyped, :int typed): // ...
}

// Record pattern with null-check and null-assert subpatterns:
switch (record) {
  case (checked: var checked?, asserted: var asserted!): // ...
  case (:var checked?, :var asserted!): // ...
}

// Record pattern with cast subpattern:
var (untyped: untyped as int, typed: typed as String) = record;
var (:untyped as int, :typed as String) = record;
```

## Object

## 对象

`SomeClass(x: subpattern1, y: subpattern2)`

Object patterns check the matched value against a given named type to destructure
data using getters on the object's properties. They are [refuted][]
if the value doesn't have the same type.

对象模式根据给定的命名类型检查匹配的值，使用对象属性上的 getter 解构数据。
如果值没有相同的类型，则它们被[否决][refuted]。

<?code-excerpt "language/lib/patterns/pattern_types.dart (object)"?>
```dart
switch (shape) {
  // Matches if shape is of type Rect, and then against the properties of Rect.
  case Rect(width: var w, height: var h): // ...
}
```

The getter name can be omitted and inferred from the [variable pattern](#variable)
or [identifier pattern](#identifier) in the field subpattern:

getter 名称可以省略，并从字段子模式中的[变量模式](#variable)
或[标识符模式](#identifier)推断：

<?code-excerpt "language/lib/patterns/pattern_types.dart (object-getter)"?>
```dart
// Binds new variables x and y to the values of Point's x and y properties.
var Point(:x, :y) = Point(1, 2);
```

Object patterns don't require the pattern to match the entire object.
If an object has extra fields that the pattern doesn't destructure, it can still match.

对象模式不要求模式匹配整个对象。
如果对象有模式未解构的额外字段，它仍然可以匹配。

## Wildcard

## 通配符

`_`

A pattern named `_` is a wildcard, either a [variable pattern](#variable) or
[identifier pattern](#identifier), that doesn't bind or assign to any variable.

名为 `_` 的模式是通配符，可以是[变量模式](#variable)或[标识符模式](#identifier)，
它不会绑定或赋值给任何变量。

It's useful as a placeholder in places where you need a subpattern in order to
destructure later positional values:

当你需要子模式来解构后面的位置值时，它作为占位符很有用：

<?code-excerpt "language/lib/patterns/pattern_types.dart (wildcard)"?>
```dart
var list = [1, 2, 3];
var [_, two, _] = list;
```

A wildcard name with a type annotation is useful when you want to test a value's
type but not bind the value to a name:

当你想测试值的类型但不想将值绑定到名称时，带有类型注释的通配符名称很有用：

<?code-excerpt "language/lib/patterns/pattern_types.dart (wildcard-typed)"?>
```dart
switch (record) {
  case (int _, String _):
    print('First field is int and second is String.');
}
```

[Patterns]: /language/patterns
[type cast]: /language/operators#type-test-operators
[destructure]: /language/patterns#destructuring
[throw]: /language/error-handling#throw
[Declaration]: /language/patterns#variable-declaration
[Assignment]: /language/patterns#variable-assignment
[Matching]: /language/patterns#matching
[`List`]: /language/collections#lists
[`Map`]: /language/collections#maps
[`StateError`]: {{site.dart-api}}/dart-core/StateError-class.html
[refuted]: /resources/glossary#refutable-pattern
[record]: /language/records
[shape]: /language/records#record-types
[switch]: /language/branches#switch
