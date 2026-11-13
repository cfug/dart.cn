---
# title: Pattern types
title: 模式类型
# description: Pattern type reference in Dart.
description: "Dart 模式类型参考。"
ai-translated: true
prevpage:
  url: /language/patterns
# title: Patterns
  title: 模式
nextpage:
  url: /language/loops
# title: Loops
  title: 循环
---

This page is a reference for the different kinds of patterns.
For an overview of how patterns work, where you can use them in Dart, and common
use cases, visit the main [Patterns][] page.

本页是各种模式的参考。
若要了解模式如何工作、可以在 Dart 的哪些地方使用，以及常见用途，
请访问主文档 [模式][Patterns]。

#### Pattern precedence

#### 模式优先级

Similar to [operator precedence](/language/operators#operator-precedence-example),
pattern evaluation adheres to precedence rules.
You can use [parenthesized patterns](#parenthesized) to 
evaluate lower-precedence patterns first.  

与 [运算符优先级](/language/operators#operator-precedence-example) 类似，
模式求值也遵守优先级规则。
可以用 [括号模式](#parenthesized)
让优先级较低的模式先求值。

This document lists the pattern types in ascending order of precedence:

本文档按优先级从低到高列出模式类型：

* [Logical-or](#logical-or) patterns are lower-precedence than [logical-and](#logical-and),
logical-and patterns are lower-precedence than [relational](#relational) patterns,
and so on. 

  [逻辑或](#logical-or) 模式的优先级低于 [逻辑与](#logical-and)，
  逻辑与模式的优先级低于 [关系](#relational) 模式，
  以此类推。

* Post-fix unary patterns ([cast](#cast), [null-check](#null-check),
and [null-assert](#null-assert)) share the same level of precedence. 

  后缀一元模式（[类型转换](#cast)、[空值检查](#null-check)
  和 [空值断言](#null-assert)）优先级相同。

* The remaining primary patterns share the highest precedence.
Collection-type ([record](#record), [list](#list), and [map](#map))
and [Object](#object) patterns encompass other
data, so are evaluated first as outer-patterns. 

  其余的主模式共享最高优先级。
  集合类型模式（[记录](#record)、[列表](#list) 和 [映射](#map)）
  以及 [对象](#object) 模式会包含其它数据，
  因此作为外层模式最先求值。

## Logical-or

## 逻辑或

`subpattern1 || subpattern2`

A logical-or pattern separates subpatterns by `||` and matches if any of the
branches match. Branches are evaluated left-to-right. Once a branch matches, the
rest are not evaluated.

逻辑或模式用 `||` 分隔子模式，任一分支匹配即匹配。
分支从左到右求值。一旦某个分支匹配，其余分支不再求值。

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

逻辑或模式中的子模式可以绑定变量，但各个分支必须定义同一组变量，
因为模式匹配时只会求值其中一个分支。

## Logical-and

## 逻辑与

`subpattern1 && subpattern2`

A pair of patterns separated by `&&` matches only if both subpatterns match. If the
left branch does not match, the right branch is not evaluated.

用 `&&` 分隔的一对模式，只有两个子模式都匹配时才匹配。
如果左分支不匹配，右分支不会求值。

Subpatterns in a logical-and pattern can bind variables, but the variables in
each subpattern must not overlap, because they will both be bound if the pattern
matches:

逻辑与模式中的子模式可以绑定变量，但各个子模式中的变量不能重叠，
因为模式匹配时它们都会被绑定：

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

关系模式用相等或关系运算符把匹配到的值与给定常量比较：
`==`、`!=`、`<`、`>`、`<=` 和 `>=`。

The pattern matches when calling the appropriate operator on the matched value
with the constant as an argument returns `true`.

在匹配到的值上调用相应运算符，并把常量作为参数，
返回 `true` 时模式匹配。

Relational patterns are useful for matching on numeric ranges, especially when
combined with the [logical-and pattern](#logical-and):

关系模式适合匹配数值范围，
尤其是与 [逻辑与模式](#logical-and) 组合使用时：

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

类型转换模式让你在解构过程中插入一次 [类型转换][type cast]，
然后再把值传给另一个子模式：

<?code-excerpt "language/lib/patterns/pattern_types.dart (cast)"?>
```dart
(num, Object) record = (1, 's');
var (i as int, s as String) = record;
```

Cast patterns will [throw][] if the value doesn't have the stated type.
Like the [null-assert pattern](#null-assert), this lets you forcibly assert the
expected type of some destructured value.

如果值不具有所声明的类型，类型转换模式会 [抛出][throw] 异常。
和 [空值断言模式](#null-assert) 一样，
这让你可以强制断言某个被解构值的期望类型。

## Null-check

## 空值检查

`subpattern?`

Null-check patterns match first if the value is not null, and then match the inner
pattern against that same value. They let you bind a variable whose type is the
non-nullable base type of the nullable value being matched.

空值检查模式首先在值不是 null 时匹配，
然后再用内部模式匹配同一个值。
这样你可以绑定一个变量，其类型是被匹配的可空值的非可空基类型。

To treat `null` values as match failures
without throwing, use the null-check pattern.

要把 `null` 值当作匹配失败、且不抛出异常，
使用空值检查模式。

<?code-excerpt "language/lib/patterns/pattern_types.dart (null-check)"?>
```dart
String? maybeString = 'nullable with base type String';
switch (maybeString) {
  case var s?:
  // 's' has type non-nullable String here.
}
```

To match when the value _is_ null, use the [constant pattern](#constant) `null`.

当值 **是** null 时要匹配，使用 [常量模式](#constant) `null`。

## Null-assert

## 空值断言

`subpattern!`

Null-assert patterns match first if the object is not null, then on the value.
They permit non-null values to flow through, but [throw][] if the matched value
is null. 

空值断言模式首先在对象不是 null 时匹配，然后再对这个值匹配。
非空值可以通过，但如果匹配到的值是 null，就会 [抛出][throw] 异常。

To ensure `null` values are not silently treated as match failures,
use a null-assert pattern while matching:

为了确保 `null` 值不会被静默当成匹配失败，
匹配时使用空值断言模式：

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

要从变量声明模式中消除 `null` 值，
使用空值断言模式：

<?code-excerpt "language/lib/patterns/pattern_types.dart (null-assert-dec)"?>
```dart
(int?, int?) position = (2, 3);

var (x!, y!) = position;
```

To match when the value _is_ null, use the [constant pattern](#constant) `null`.

当值 **是** null 时要匹配，使用 [常量模式](#constant) `null`。

## Constant

## 常量

`123, null, 'string', math.pi, SomeClass.constant, const Thing(1, 2), const (1 + 2)`

Constant patterns match when the value is equal to the constant: 

常量模式在值等于该常量时匹配：

<?code-excerpt "language/lib/patterns/pattern_types.dart (constant)"?>
```dart
switch (number) {
  // Matches if 1 == number.
  case 1: // ...
}
```

You can use simple literals and references to named constants directly as constant patterns:

简单字面量和对命名常量的引用可以直接当作常量模式：

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

更复杂的常量表达式必须加上括号，并以前缀 `const` 标明
（`const (1 + 2)`）：

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

变量模式把新变量绑定到已经匹配或解构出来的值上。
它们通常作为 [解构模式][destructure] 的一部分，
用来捕获解构出来的值。

The variables are in scope in a region of code that is only reachable when the
pattern has matched.

这些变量的作用域位于只有模式匹配成功时才能到达的代码区域。

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

**带类型的** 变量模式只有在匹配到的值具有所声明的类型时才匹配，
否则匹配失败：

<?code-excerpt "language/lib/patterns/pattern_types.dart (variable-typed)"?>
```dart
switch ((1, 2)) {
  // Does not match.
  case (int a, String b): // ...
}
```

You can use a [wildcard pattern](#wildcard) as a variable pattern. 

可以把 [通配符模式](#wildcard) 当作变量模式使用。

## Identifier

## 标识符

`foo, _`

Identifier patterns behave like a
[constant pattern](#constant) or like a [variable pattern](#variable),
depending on the context where they appear:

标识符模式的行为像 [常量模式](#constant)，
或像 [变量模式](#variable)，
取决于它们出现的上下文：

- [Declaration][] context: declares a new variable with identifier name:

  [声明][Declaration] 上下文：用该标识符名声明一个新变量：
  `var (a, b) = (1, 2);`
- [Assignment][] context: assigns to existing variable with identifier name:

  [赋值][Assignment] 上下文：赋给同名的已有变量：
  `(a, b) = (3, 4);`
- [Matching][] context: treated as a named constant pattern (unless its name is `_`):

  [匹配][Matching] 上下文：当作命名常量模式
  （除非它的名字是 `_`）：
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

  任何上下文中的 [通配符](#wildcard) 标识符：匹配任何值并丢弃它：
  `case [_, var y, _]: print('The middle element is $y');`

## Parenthesized

## 括号

`(subpattern)`

Like parenthesized expressions, parentheses in a pattern let you control
[pattern precedence](#pattern-precedence) and insert a lower-precedence
pattern where a higher precedence one is expected.

和带括号的表达式一样，模式中的括号让你控制
[模式优先级](#pattern-precedence)，
并在期望更高优先级模式的位置插入一个优先级更低的模式。

For example, imagine the boolean constants `x`, `y`, and `z`
equal `true`, `true`, and `false`, respectively.
Though the following example resembles boolean expression evaluation,
the example matches patterns.

例如，假设布尔常量 `x`、`y` 和 `z`
分别等于 `true`、`true` 和 `false`。
下面的例子看起来像在求布尔表达式，
实际上匹配的是模式。

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

   第一条模式匹配 `true`，因为 `x` 匹配 `true`。
1. The second pattern matches `true` as `x` matches `true`.

   第二条模式匹配 `true`，因为 `x` 匹配 `true`。
1. The third pattern matches `true` as `x` matches `true`.

   第三条模式匹配 `true`，因为 `x` 匹配 `true`。
1. The fourth pattern `(x || y) && z` has no match.

   第四条模式 `(x || y) && z` 没有匹配。

   * The `x` matches `true`, so Dart doesn't try to match `y`.

     `x` 匹配 `true`，因此 Dart 不会再尝试匹配 `y`。
   * Though `(x || y)` matches `true`, `z` doesn't match `true`

     虽然 `(x || y)` 匹配 `true`，但 `z` 不匹配 `true`。
   * Therefore, pattern `(x || y) && z` doesn't match `true`.

     因此，模式 `(x || y) && z` 不匹配 `true`。
   * The subpattern `(x || y)` doesn't match `false`,
     so Dart doesn't try to match `z`.

     子模式 `(x || y)` 不匹配 `false`，
     因此 Dart 不会再尝试匹配 `z`。
   * Therefore, pattern `(x || y) && z` doesn't match `false`.

     因此，模式 `(x || y) && z` 不匹配 `false`。
   * As a conclusion, `(x || y) && z` has no match.

     结论是，`(x || y) && z` 没有匹配。

## List

## 列表

`[subpattern1, subpattern2]`

A list pattern matches values that implement [`List`][], and then recursively
matches its subpatterns against the list's elements to destructure them by position:

列表模式匹配实现了 [`List`][] 的值，
然后按位置递归匹配子模式，从而解构列表元素：

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

列表模式要求模式中的元素个数与整个列表一致。
不过，可以用 [剩余元素](#rest-element) 作为占位符，
以对应列表中任意数量的元素。

### Rest element

### 剩余元素

List patterns can contain _one_ rest element (`...`) which allows matching lists
of arbitrary lengths.

列表模式可以包含 **一个** 剩余元素（`...`），
从而匹配任意长度的列表。

<?code-excerpt "language/lib/patterns/pattern_types.dart (rest)"?>
```dart
var [a, b, ..., c, d] = [1, 2, 3, 4, 5, 6, 7];
// Prints "1 2 6 7".
print('$a $b $c $d');
```

A rest element can also have a subpattern that collects elements that don't match
the other subpatterns in the list, into a new list:

剩余元素也可以带一个子模式，
把列表中未匹配其它子模式的元素收集到一个新列表里：

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

映射模式匹配实现了 [`Map`][] 的值，
然后按映射的键递归匹配子模式，从而解构它们。

Map patterns don't require the pattern to match the entire map. A map pattern
ignores any keys that the map contains that aren't matched by the pattern.
Trying to match a key that does not exist in the map will
throw a [`StateError`][]:

映射模式不要求模式匹配整个映射。
映射中有、但模式没有匹配的键会被忽略。
尝试匹配映射中不存在的键会抛出 [`StateError`][]：

<?code-excerpt "language/lib/patterns/pattern_types.dart (map-error)"?>
```dart
final {'foo': int? foo} = {};
```

## Record

## 记录

`(subpattern1, subpattern2)`

`(x: subpattern1, y: subpattern2)`

Record patterns match a [record][] object and destructure its fields.
If the value isn't a record with the same [shape][] as the pattern, the match
fails. Otherwise, the field subpatterns are matched against the corresponding
fields in the record.

记录模式匹配 [记录][record] 对象并解构它的字段。
如果值不是与模式具有相同 [形状][shape] 的记录，匹配失败。
否则，字段子模式会与记录中对应的字段进行匹配。

Record patterns require that the pattern match the entire record. To destructure 
a record with _named_ fields using a pattern, include the field names in the pattern:

记录模式要求模式匹配整条记录。
要用模式解构带 **命名** 字段的记录，
把字段名写进模式：

<?code-excerpt "language/lib/patterns/pattern_types.dart (record)"?>
```dart
var (myString: foo, myNumber: bar) = (myString: 'string', myNumber: 1);
```

The getter name can be omitted and inferred from the [variable pattern](#variable)
or [identifier pattern](#identifier) in the field subpattern. These pairs of
patterns are each equivalent:

可以省略 getter 名称，并从字段子模式中的 [变量模式](#variable)
或 [标识符模式](#identifier) 推断出来。
下面每一对模式都是等价的：

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

对象模式把匹配到的值与给定的命名类型核对，
并用对象属性上的 getter 来解构数据。
如果值不具有相同类型，匹配会被 [反驳][refuted]。

<?code-excerpt "language/lib/patterns/pattern_types.dart (object)"?>
```dart
switch (shape) {
  // Matches if shape is of type Rect, and then against the properties of Rect.
  case Rect(width: var w, height: var h): // ...
}
```  

The getter name can be omitted and inferred from the [variable pattern](#variable)
or [identifier pattern](#identifier) in the field subpattern:

可以省略 getter 名称，并从字段子模式中的 [变量模式](#variable)
或 [标识符模式](#identifier) 推断出来：

<?code-excerpt "language/lib/patterns/pattern_types.dart (object-getter)"?>
```dart
// Binds new variables x and y to the values of Point's x and y properties.
var Point(:x, :y) = Point(1, 2);
```

Object patterns don't require the pattern to match the entire object.
If an object has extra fields that the pattern doesn't destructure, it can still match.

对象模式不要求模式匹配整个对象。
如果对象还有模式没有解构的额外字段，它仍然可以匹配。

## Wildcard

## 通配符

`_`

A pattern named `_` is a wildcard, either a [variable pattern](#variable) or
[identifier pattern](#identifier), that doesn't bind or assign to any variable.

名为 `_` 的模式是通配符，它可以是 [变量模式](#variable)
或 [标识符模式](#identifier)，不会绑定或赋值给任何变量。

It's useful as a placeholder in places where you need a subpattern in order to
destructure later positional values:

当你需要一个子模式，以便稍后按位置解构后面的值时，
它适合作为占位符：

<?code-excerpt "language/lib/patterns/pattern_types.dart (wildcard)"?>
```dart
var list = [1, 2, 3];
var [_, two, _] = list;
```

A wildcard name with a type annotation is useful when you want to test a value's
type but not bind the value to a name:

带类型注解的通配符名称，适合在你想测试值的类型、
但不把值绑定到名字上的时候：

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
