---
# title: Operators
title: 操作符
# description: Learn about the operators Dart supports.
description: 了解 Dart 支持的操作符。
prevpage:
  url: /language/variables
  # title: Variables
  title: 变量
nextpage:
  url: /language/comments
  # title: Comments
  title: 注释
ai-translated: true
---

<?code-excerpt replace="/ *\/\/\s+ignore_for_file:[^\n]+\n//g; /(^|\n) *\/\/\s+ignore:[^\n]+\n/$1/g; /(\n[^\n]+) *\/\/\s+ignore:[^\n]+\n/$1\n/g; / *\/\/\s+ignore:[^\n]+//g; /([A-Z]\w*)\d\b/$1/g"?>

<a name="operators"></a>

Dart supports the operators shown in the following table.
The table shows Dart's operator associativity 
and [operator precedence](#operator-precedence-example) from highest to lowest,
which are an **approximation** of Dart's operator relationships.
You can implement many of these [operators as class members][].

Dart 支持下表中的操作符。
表中给出了 Dart 操作符的结合性，
以及从高到低的 [操作符优先级](#operator-precedence-example)，
它们是 Dart 操作符关系的一种 **近似**。
其中许多 [操作符可以作为类成员][operators as class members] 来实现。

| <t>Description</t><t>说明</t> | <t>Operator</t><t>操作符</t> | <t>Associativity</t><t>结合性</t> |
|-----------------------------------------|----------------------------------------------------------------------------------------------------|---------------|
| unary postfix                           | *`expr`*`++`    *`expr`*`--`    `()`    `[]`    `?[]`    `.`    `?.`    `!`                        | None          |
| 一元后缀 | *`expr`*`++`    *`expr`*`--`    `()`    `[]`    `?[]`    `.`    `?.`    `!` | 无 |
| unary prefix                            | `-`*`expr`*    `!`*`expr`*    `~`*`expr`*    `++`*`expr`*    `--`*`expr`*      `await` *`expr`*    | None          |
| 一元前缀 | `-`*`expr`*    `!`*`expr`*    `~`*`expr`*    `++`*`expr`*    `--`*`expr`*      `await` *`expr`* | 无 |
| multiplicative                          | `*`    `/`    `%`    `~/`                                                                          | Left          |
| 乘法 | `*`    `/`    `%`    `~/` | 左结合 |
| additive                                | `+`    `-`                                                                                         | Left          |
| 加法 | `+`    `-` | 左结合 |
| shift                                   | `<<`    `>>`    `>>>`                                                                              | Left          |
| 移位 | `<<`    `>>`    `>>>` | 左结合 |
| bitwise AND                             | `&`                                                                                                | Left          |
| 按位与 | `&` | 左结合 |
| bitwise XOR                             | `^`                                                                                                | Left          |
| 按位异或 | `^` | 左结合 |
| bitwise OR                              | <code>&#124;</code>                                                                                | Left          |
| 按位或 | <code>&#124;</code> | 左结合 |
| relational and type test                | `>=`    `>`    `<=`    `<`    `as`    `is`    `is!`                                                | None          |
| 关系运算与类型测试 | `>=`    `>`    `<=`    `<`    `as`    `is`    `is!` | 无 |
| equality                                | `==`    `!=`                                                                                       | None          |
| 相等 | `==`    `!=` | 无 |
| logical AND                             | `&&`                                                                                               | Left          |
| 逻辑与 | `&&` | 左结合 |
| logical OR                              | <code>&#124;&#124;</code>                                                                          | Left          |
| 逻辑或 | <code>&#124;&#124;</code> | 左结合 |
| if-null                                 | `??`                                                                                               | Left          |
| if-null | `??` | 左结合 |
| conditional                             | *`expr1`*    `?`    *`expr2`*    `:`    *`expr3`*                                                  | Right         |
| 条件 | *`expr1`*    `?`    *`expr2`*    `:`    *`expr3`* | 右结合 |
| cascade                                 | `..`    `?..`                                                                                      | Left          |
| 级联 | `..`    `?..` | 左结合 |
| assignment                              | `=`    `*=`    `/=`    `+=`    `-=`    `&=`    `^=`    *etc.*                                      | Right         |
| 赋值 | `=`    `*=`    `/=`    `+=`    `-=`    `&=`    `^=`    *etc.* | 右结合 |
| spread  ([See note](#spread-operators)) | `...`    `...?`                                                                                    | None          |
| 展开（[参见说明](#spread-operators)） | `...`    `...?` | 无 |

{:.table .table-striped}

:::warning
The previous table should only be used as a helpful guide.
The notion of operator precedence and associativity
is an approximation of the truth found in the language grammar.
You can find the authoritative behavior of Dart's operator relationships
in the grammar defined in the [Dart language specification][].

上一张表只适合当作辅助参考。
操作符优先级和结合性的概念，
只是语言语法中真实规则的近似。
Dart 操作符关系的权威行为，
见 [Dart 语言规范][Dart language specification] 中定义的语法。

:::

When you use operators, you create expressions. Here are some examples
of operator expressions:

使用操作符时，你会创建表达式。下面是一些操作符表达式的例子：

<?code-excerpt "misc/test/language_tour/operators_test.dart (expressions)" replace="/,//g"?>
```dart
a++
a + b
a = b
a == b
c ? a : b
a is T
```

## Operator precedence example

## 操作符优先级示例

In the [operator table](#operators),
each operator has higher precedence than the operators in the rows
that follow it. For example, the multiplicative operator `%` has higher
precedence than (and thus executes before) the equality operator `==`,
which has higher precedence than the logical AND operator `&&`. That
precedence means that the following two lines of code execute the same
way:

在 [操作符表](#operators) 中，
每一行的操作符都比它下面各行的操作符优先级更高。
例如，乘法操作符 `%` 的优先级高于（因此会先于）相等操作符 `==`，
而 `==` 又高于逻辑与操作符 `&&`。
这种优先级意味着下面两行代码的执行方式相同：

<?code-excerpt "misc/test/language_tour/operators_test.dart (precedence)"?>
```dart
// Parentheses improve readability.
if ((n % i == 0) && (d % i == 0)) {
  // ...
}

// Harder to read, but equivalent.
if (n % i == 0 && d % i == 0) {
  // ...
}
```

:::warning
For operators that take two operands, the leftmost operand determines which
method is used. For example, if you have a `Vector` object and
a `Point` object, then `aVector + aPoint` uses `Vector` addition (`+`).

对于接受两个操作数的操作符，最左侧的操作数决定使用哪个方法。
例如，如果你有一个 `Vector` 对象和一个 `Point` 对象，
那么 `aVector + aPoint` 使用的是 `Vector` 的加法（`+`）。

:::


## Arithmetic operators

## 算术操作符

Dart supports the usual arithmetic operators, as shown in the following table.

Dart 支持常见的算术操作符，如下表所示。

| <t>Operator</t><t>操作符</t> | <t>Meaning</t><t>含义</t> |
|-------------|--------------------------------------------------------------------------|
| `+`         | Add                                                                      |
| `+` | 相加 |
| `-`         | Subtract                                                                 |
| `-` | 相减 |
| `-`*`expr`* | Unary minus, also known as negation (reverse the sign of the expression) |
| `-`*`expr`* | 一元负号，也称为取反（反转表达式的符号） |
| `*`         | Multiply                                                                 |
| `*` | 相乘 |
| `/`         | Divide                                                                   |
| `/` | 相除 |
| `~/`        | Divide, returning an integer result                                      |
| `~/` | 相除，并返回整数结果 |
| `%`         | Get the remainder of an integer division (modulo)                        |
| `%` | 取整数除法的余数（取模） |

{:.table .table-striped}

Example:

示例：

<?code-excerpt "misc/test/language_tour/operators_test.dart (arithmetic)"?>
```dart
assert(2 + 3 == 5);
assert(2 - 3 == -1);
assert(2 * 3 == 6);
assert(5 / 2 == 2.5); // Result is a double
assert(5 ~/ 2 == 2); // Result is an int
assert(5 % 2 == 1); // Remainder

assert('5/2 = ${5 ~/ 2} r ${5 % 2}' == '5/2 = 2 r 1');
```

Dart also supports both prefix and postfix increment and decrement
operators.

Dart 也支持前缀和后缀形式的自增、自减操作符。

| <t>Operator</t><t>操作符</t> | <t>Meaning</t><t>含义</t> |
|-----------------------------|----------------------------------------------------|
| `++`*`var`* | *`var`*  `=`  *`var `*  `+ 1` (expression value is *`var`* ` + 1`) |
| `++`*`var`* | **var** = **var** + 1（表达式的值是 **var** + 1） |
| *`var`*`++` | *`var`*  `=`  *`var `*  `+ 1` (expression value is *`var`*)        |
| *`var`*`++` | **var** = **var** + 1（表达式的值是 **var**） |
| `--`*`var`* | *`var`*  `=`  *`var `*  `- 1` (expression value is *`var`* ` - 1`) |
| `--`*`var`* | **var** = **var** - 1（表达式的值是 **var** - 1） |
| *`var`*`--` | *`var`*  `=`  *`var `*  `- 1` (expression value is *`var`*)       |
| *`var`*`--` | **var** = **var** - 1（表达式的值是 **var**） |

{:.table .table-striped}

Example:

示例：

<?code-excerpt "misc/test/language_tour/operators_test.dart (increment-decrement)"?>
```dart
int a;
int b;

a = 0;
b = ++a; // Increment a before b gets its value.
assert(a == b); // 1 == 1

a = 0;
b = a++; // Increment a after b gets its value.
assert(a != b); // 1 != 0

a = 0;
b = --a; // Decrement a before b gets its value.
assert(a == b); // -1 == -1

a = 0;
b = a--; // Decrement a after b gets its value.
assert(a != b); // -1 != 0
```


## Equality and relational operators

## 相等与关系操作符

The following table lists the meanings of equality and relational operators.

下表列出了相等操作符和关系操作符的含义。

| <t>Operator</t><t>操作符</t> | <t>Meaning</t><t>含义</t> |
|-----------|-------------------------------------------|
| `==`      | Equal; see discussion below               |
| `==` | 相等；见下文讨论 |
| `!=`      | Not equal                                 |
| `!=` | 不相等 |
| `>`       | Greater than                              |
| `>` | 大于 |
| `<`       | Less than                                 |
| `<` | 小于 |
| `>=`      | Greater than or equal to                  |
| `>=` | 大于或等于 |
| `<=`      | Less than or equal to                     |
| `<=` | 小于或等于 |

{:.table .table-striped}

To test whether two objects x and y represent the same thing, use the
`==` operator. (In the rare case where you need to know whether two
objects are the exact same object, use the [identical()][]
function instead.) Here's how the `==` operator works:

要测试两个对象 x 和 y 是否表示同一事物，使用 `==` 操作符。
（在极少数需要知道两个对象是不是同一个对象的情况下，
改用 [identical()][identical()] 函数。）
`==` 操作符的工作方式如下：

1.  If *x* or *y* is null, return true if both are null, and false if only
    one is null.

    如果 **x** 或 **y** 为 null，两者都为 null 时返回 true，
    只有一个为 null 时返回 false。


2.  Return the result of invoking the `==` method on *x* with the argument *y*.
    (That's right, operators such as `==` are methods that
    are invoked on their first operand.
    For details, see [Operators][].)

    返回在 **x** 上以 **y** 为参数调用 `==` 方法的结果。
    （没错，`==` 这类操作符是在它们的第一个操作数上调用的方法。
    详情见 [操作符][Operators]。）


Here's an example of using each of the equality and relational
operators:

下面是使用各个相等操作符和关系操作符的示例：

<?code-excerpt "misc/test/language_tour/operators_test.dart (relational)"?>
```dart
assert(2 == 2);
assert(2 != 3);
assert(3 > 2);
assert(2 < 3);
assert(3 >= 3);
assert(2 <= 3);
```


## Type test operators

## 类型测试操作符

The `as`, `is`, and `is!` operators are handy for checking types at
runtime.

`as`、`is` 和 `is!` 操作符便于在运行时检查类型。

| <t>Operator</t><t>操作符</t> | <t>Meaning</t><t>含义</t> |
|-----------|------------------------------------------------------|
| `as`      | Typecast (also used to specify [library prefixes][]) |
| `as` | 类型转换（也用于指定 [库前缀][library prefixes]） |
| `is`      | True if the object has the specified type            |
| `is` | 若对象具有指定类型，则为 true |
| `is!`     | True if the object doesn't have the specified type   |
| `is!` | 若对象不具有指定类型，则为 true |

{:.table .table-striped}

The result of `obj is T` is true if `obj` implements the interface
specified by `T`. For example, `obj is Object?` is always true.

如果 `obj` 实现了 `T` 所指定的接口，`obj is T` 的结果为 true。
例如，`obj is Object?` 永远为 true。

Use the `as` operator to cast an object to a particular type if and only if
you are sure that the object is of that type. Example:

只有当你确定对象就是某一类型时，才用 `as` 操作符把它转换成该类型。示例：

<?code-excerpt "misc/lib/language_tour/classes/employee.dart (emp-as-person)"?>
```dart
(employee as Person).firstName = 'Bob';
```

If you aren't sure that the object is of type `T`, then use `is T` to check the
type before using the object.

如果你不确定对象是不是 `T` 类型，就先用 `is T` 检查类型，再使用该对象。

<?code-excerpt "misc/lib/language_tour/classes/employee.dart (emp-is-person)"?>
```dart
if (employee is Person) {
  // Type check
  employee.firstName = 'Bob';
}
```

:::note
The code isn't equivalent. If `employee` is null or not a `Person`, the
first example throws an exception; the second does nothing.

这两段代码并不等价。如果 `employee` 为 null 或者不是 `Person`，
第一个示例会抛出异常；第二个示例什么也不做。

:::

## Assignment operators

## 赋值操作符

As you've already seen, you can assign values using the `=` operator.
To assign only if the assigned-to variable is null,
use the `??=` operator.

正如你已经看到的，可以用 `=` 操作符赋值。
只有当被赋值的变量为 null 时才赋值，使用 `??=` 操作符。

<?code-excerpt "misc/test/language_tour/operators_test.dart (assignment)"?>
```dart
// Assign value to a
a = value;
// Assign value to b if b is null; otherwise, b stays the same
b ??= value;
```

Compound assignment operators such as `+=` combine
an operation with an assignment.

像 `+=` 这样的复合赋值操作符，把一次运算和一次赋值合在一起。

|      |       |       |        |                      |
|------|-------|-------|--------|----------------------|
| `=`  | `*=`  | `%=`  | `>>>=` | `^=`                 |
| `=`  | `*=`  | `%=`  | `>>>=` | `^=`                 |
| `+=` | `/=`  | `<<=` | `&=`   | <code>&#124;=</code> |
| `+=` | `/=`  | `<<=` | `&=`   | <code>&#124;=</code> |
| `-=` | `~/=` | `>>=` |        |                      |
| `-=` | `~/=` | `>>=` |        |                      |

{:.table}

Here's how compound assignment operators work:

复合赋值操作符的工作方式如下：

| | <t>Compound assignment</t><t>复合赋值</t> | <t>Equivalent expression</t><t>等价表达式</t> |
|---------------------------|---------------------|-----------------------|
| **For an operator *op*:** | `a `  *`op`*`= b`   | `a = a ` *`op `* `b`  |
| 对于操作符 **op**： | `a `  *`op`*`= b` | `a = a ` *`op `* `b` |
| **Example:**              | `a += b`            | `a = a + b`           |
| **示例：** | `a += b` | `a = a + b` |

{:.table}

The following example uses assignment and compound assignment
operators:

下面的示例使用了赋值操作符和复合赋值操作符：

<?code-excerpt "misc/test/language_tour/operators_test.dart (op-assign)"?>
```dart
var a = 2; // Assign using =
a *= 3; // Assign and multiply: a = a * 3
assert(a == 6);
```


## Logical operators

## 逻辑操作符

You can invert or combine boolean expressions using the logical
operators.

你可以用逻辑操作符对布尔表达式取反或把它们组合起来。

| <t>Operator</t><t>操作符</t> | <t>Meaning</t><t>含义</t> |
|----------------------------|--------------------------------------------------------------------------|
| `!`*`expr`*                | inverts the following expression (changes false to true, and vice versa) |
| `!`*`expr`* | 对后面的表达式取反（把 false 变成 true，反之亦然） |
| <code>&#124;&#124;</code>  | logical OR                                                               |
| <code>&#124;&#124;</code> | 逻辑或 |
| `&&`                       | logical AND                                                              |
| `&&` | 逻辑与 |

{:.table .table-striped}

Here's an example of using the logical operators:

下面是使用逻辑操作符的示例：

<?code-excerpt "misc/lib/language_tour/operators.dart (op-logical)"?>
```dart
if (!done && (col == 0 || col == 3)) {
  // ...Do something...
}
```


## Bitwise and shift operators

## 按位与移位操作符

You can manipulate the individual bits of numbers in Dart. Usually,
you'd use these bitwise and shift operators with integers.

你可以在 Dart 里操作数字的各个位。
通常，这些按位操作符和移位操作符会与整数一起使用。

| <t>Operator</t><t>操作符</t> | <t>Meaning</t><t>含义</t> |
|---------------------|-------------------------------------------------------|
| `&`                 | AND                                                   |
| `&` | 与 |
| <code>&#124;</code> | OR                                                    |
| <code>&#124;</code> | 或 |
| `^`                 | XOR                                                   |
| `^` | 异或 |
| `~`*`expr`*         | Unary bitwise complement (0s become 1s; 1s become 0s) |
| `~`*`expr`* | 一元按位补码（0 变成 1，1 变成 0） |
| `<<`                | Shift left                                            |
| `<<` | 左移 |
| `>>`                | Shift right                                           |
| `>>` | 右移 |
| `>>>`               | Unsigned shift right                                  |
| `>>>` | 无符号右移 |

{:.table .table-striped}

:::note
The behavior of bitwise operations with large or negative operands
might differ between platforms.
To learn more, check out
[Bitwise operations platform differences][].

操作数很大或为负数时，按位运算的行为在不同平台上可能不同。
想了解更多，请查看
[按位运算的平台差异][Bitwise operations platform differences]。

:::

Here's an example of using bitwise and shift operators:

下面是使用按位操作符和移位操作符的示例：

<?code-excerpt "misc/test/language_tour/operators_test.dart (op-bitwise)"?>
```dart
final value = 0x22;
final bitmask = 0x0f;

assert((value & bitmask) == 0x02); // AND
assert((value & ~bitmask) == 0x20); // AND NOT
assert((value | bitmask) == 0x2f); // OR
assert((value ^ bitmask) == 0x2d); // XOR

assert((value << 4) == 0x220); // Shift left
assert((value >> 4) == 0x02); // Shift right

// Shift right example that results in different behavior on web
// because the operand value changes when masked to 32 bits:
assert((-value >> 4) == -0x03);

assert((value >>> 4) == 0x02); // Unsigned shift right
assert((-value >>> 4) > 0); // Unsigned shift right
```

:::version-note
The `>>>` operator (known as _triple-shift_ or _unsigned shift_)
requires a [language version][] of at least 2.14.

`>>>` 操作符（也称为 **三重移位** 或 **无符号移位**）
需要至少 2.14 的 [语言版本][language version]。

:::

[Bitwise operations platform differences]: /resources/language/number-representation#bitwise-operations

## Conditional expressions

## 条件表达式

Dart has two operators that let you concisely evaluate expressions
that might otherwise require [if-else][] statements:

Dart 有两个操作符，让你简洁地求值那些
否则可能需要 [if-else][if-else] 语句的表达式：

_`condition`_ `?` _`expr1`_ `:` _`expr2`_
: If _condition_ is true, evaluates _expr1_ (and returns its value);
  otherwise, evaluates and returns the value of _expr2_.

**`condition`** `?` **`expr1`** `:` **`expr2`**
: 如果 **condition** 为 true，就求值 **expr1**（并返回它的值）；
  否则求值并返回 **expr2** 的值。

_`expr1`_ `??` _`expr2`_
: If _expr1_ is non-null, returns its value;
  otherwise, evaluates and returns the value of _expr2_.

**`expr1`** `??` **`expr2`**
: 如果 **expr1** 非空，就返回它的值；
  否则求值并返回 **expr2** 的值。

When you need to assign a value
based on a boolean expression,
consider using the conditional operator `?` and `:`.

当需要根据布尔表达式赋值时，
可以考虑使用条件操作符 `?` 和 `:`。

<?code-excerpt "misc/lib/language_tour/operators.dart (if-then-else-operator)"?>
```dart
var visibility = isPublic ? 'public' : 'private';
```

If the boolean expression tests for null,
consider using the if-null operator `??`
(also known as the null-coalescing operator).

如果布尔表达式是在测试 null，
可以考虑使用 if-null 操作符 `??`
（也称为空值合并操作符）。

<?code-excerpt "misc/test/language_tour/operators_test.dart (if-null)"?>
```dart
String playerName(String? name) => name ?? 'Guest';
```

The previous example could have been written at least two other ways,
but not as succinctly:

上一个示例至少还可以写成另外两种方式，但都没有这么简洁：

<?code-excerpt "misc/test/language_tour/operators_test.dart (if-null-alt)"?>
```dart
// Slightly longer version uses ?: operator.
String playerName(String? name) => name != null ? name : 'Guest';

// Very long version uses if-else statement.
String playerName(String? name) {
  if (name != null) {
    return name;
  } else {
    return 'Guest';
  }
}
```

## Cascade notation

## 级联记法

Cascades (`..`, `?..`) allow you to make a sequence of operations
on the same object. In addition to accessing instance members,
you can also call instance methods on that same object.
This often saves you the step of creating a temporary variable and
allows you to write more fluid code.

级联（`..`、`?..`）让你对同一个对象连续做一系列操作。
除了访问实例成员，你也可以在同一个对象上调用实例方法。
这常常省去创建临时变量这一步，也能写出更流畅的代码。

Consider the following code:

考虑下面的代码：

<?code-excerpt "misc/lib/language_tour/cascades.dart (cascade)"?>
```dart
var paint = Paint()
  ..color = Colors.black
  ..strokeCap = StrokeCap.round
  ..strokeWidth = 5.0;
```

The constructor, `Paint()`,
returns a `Paint` object.
The code that follows the cascade notation operates
on this object, ignoring any values that
might be returned.

构造函数 `Paint()` 返回一个 `Paint` 对象。
级联记法后面的代码在这个对象上操作，
并忽略可能返回的任何值。

The previous example is equivalent to this code:

上一个示例等价于这段代码：

<?code-excerpt "misc/lib/language_tour/cascades.dart (cascade-expanded)"?>
```dart
var paint = Paint();
paint.color = Colors.black;
paint.strokeCap = StrokeCap.round;
paint.strokeWidth = 5.0;
```

If the object that the cascade operates on can be null,
then use a _null-shorting_ cascade (`?..`) for the first operation.
Starting with `?..` guarantees that none of the cascade operations
are attempted on that null object.

如果级联所操作的对象可能为 null，
就在第一个操作上使用 **空值短路** 级联（`?..`）。
以 `?..` 开头可以保证不会在那个 null 对象上尝试任何级联操作。

<?code-excerpt "misc/test/language_tour/browser_test.dart (cascade-operator)"?>
```dart
document.querySelector('#confirm') // Get an object.
  ?..textContent =
      'Confirm' // Use its members.
  ..classList.add('important')
  ..onClick.listen((e) => window.alert('Confirmed!'))
  ..scrollIntoView();
```

The previous code is equivalent to the following:

上面的代码等价于下面这段：

<?code-excerpt "misc/test/language_tour/browser_test.dart (cascade-operator-example-expanded)"?>
```dart
final button = document.querySelector('#confirm');
button?.textContent = 'Confirm';
button?.classList.add('important');
button?.onClick.listen((e) => window.alert('Confirmed!'));
button?.scrollIntoView();
```

You can also nest cascades. For example:

你也可以嵌套级联。例如：

<?code-excerpt "misc/lib/language_tour/operators.dart (nested-cascades)"?>
```dart
final addressBook =
    (AddressBookBuilder()
          ..name = 'jenny'
          ..email = 'jenny@example.com'
          ..phone =
              (PhoneNumberBuilder()
                    ..number = '415-555-0100'
                    ..label = 'home')
                  .build())
        .build();
```

Be careful to construct your cascade on a function that returns
an actual object. For example, the following code fails:

注意，级联要建在一个返回实际对象的函数上。
例如，下面的代码会失败：

<?code-excerpt "misc/lib/language_tour/operators.dart (cannot-cascade-on-void)" plaster="none"?>
```dart
var sb = StringBuffer();
sb.write('foo')
  ..write('bar'); // Error: method 'write' isn't defined for 'void'.
```

The `sb.write()` call returns void,
and you can't construct a cascade on `void`.

`sb.write()` 调用返回 void，
你不能在 `void` 上构建级联。

:::note
Strictly speaking, the "double dot" notation for cascades isn't an operator.
It's just part of the Dart syntax.

严格来说，级联的「双点」记法并不是操作符。
它只是 Dart 语法的一部分。

:::

## Spread operators

## 展开操作符

Spread operators evaluate an expression that yields a collection,
unpacks the resulting values, and inserts them into another collection.

展开操作符对一个会产生集合的表达式求值，
拆开得到的值，再把它们插入另一个集合。

**The spread operator isn't actually an operator expression**.
The `...`/`...?` syntax is part of the collection literal itself.
So, you can learn more about spread operators on the
[Collections](/language/collections#spread-operators) page.

**展开操作符实际上并不是操作符表达式**。
`...` / `...?` 语法是集合字面量本身的一部分。
因此，你可以在
[集合](/language/collections#spread-operators) 页面了解更多关于展开操作符的内容。

Because it isn't an operator, the syntax doesn't
have any "[operator precedence](#operators)".
Effectively, it has the lowest "precedence" &mdash;
any kind of expression is valid as the spread target, such as:

因为它不是操作符，这种语法没有任何「[操作符优先级](#operators)」。
实际上，它的「优先级」最低——
任何表达式都可以作为展开的目标，例如：

```dart
[...a + b]
```

## Other operators

## 其他操作符

You've seen most of the remaining operators in other examples:

其余大多数操作符你已经在其他示例里见过：

| <t>Operator</t><t>操作符</t> | <t>Name</t><t>名称</t> | <t>Meaning</t><t>含义</t> |
|----------|------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `()`     | Function application         | Represents a function call                                                                                                                                                                                                                              |
| `()` | 函数调用 | 表示一次函数调用 |
| `[]`     | Subscript access             | Represents a call to the overridable `[]` operator; example: `fooList[1]` passes the int `1` to `fooList` to access the element at index `1`                                                                                                            |
| `[]` | 下标访问 | 表示对可重写的 `[]` 操作符的调用；例如：`fooList[1]` 把 int `1` 传给 `fooList`，以访问下标 `1` 处的元素 |
| `?[]`    | Conditional subscript access | Like `[]`, but the leftmost operand can be null; example: `fooList?[1]` passes the int `1` to `fooList` to access the element at index `1` unless `fooList` is null (in which case the expression evaluates to null)                                    |
| `?[]` | 条件下标访问 | 与 `[]` 类似，但最左侧的操作数可以为 null；例如：`fooList?[1]` 把 int `1` 传给 `fooList`，以访问下标 `1` 处的元素，除非 `fooList` 为 null（此时表达式求值为 null） |
| `.`      | Member access                | Refers to a property of an expression; example: `foo.bar` selects property `bar` from expression `foo`                                                                                                                                                  |
| `.` | 成员访问 | 引用表达式的属性；例如：`foo.bar` 从表达式 `foo` 中选取属性 `bar` |
| `?.`     | Conditional member access    | Like `.`, but the leftmost operand can be null; example: `foo?.bar` selects property `bar` from expression `foo` unless `foo` is null (in which case the value of `foo?.bar` is null)                                                                   |
| `?.` | 条件成员访问 | 与 `.` 类似，但最左侧的操作数可以为 null；例如：`foo?.bar` 从表达式 `foo` 中选取属性 `bar`，除非 `foo` 为 null（此时 `foo?.bar` 的值为 null） |
| `!`      | Not-null assertion operator  | Casts an expression to its underlying non-nullable type, throwing a runtime exception if the cast fails; example: `foo!.bar` asserts `foo` is non-null and selects the property `bar`, unless `foo` is null (in which case a runtime exception is thrown) |
| `!` | 非空断言操作符 | 把表达式转换为其底层的非空类型，转换失败时抛出运行时异常；例如：`foo!.bar` 断言 `foo` 非空并选取属性 `bar`，若 `foo` 为 null 则抛出运行时异常 |

{:.table .table-striped}

For more information about the `.`, `?.`, and `..` operators, see
[Classes][].

关于 `.`、`?.` 和 `..` 操作符的更多信息，见
[类][Classes]。


[operators as class members]: /language/methods#operators
[Dart language specification]: /resources/language/spec
[identical()]: {{site.dart-api}}/dart-core/identical.html
[Operators]: /language/methods#operators
[library prefixes]: /language/libraries#specifying-a-library-prefix
[if-else]: /language/branches#if
[language version]: /language/versioning
[Classes]: /language/classes
