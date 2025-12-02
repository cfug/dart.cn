---
title: Operators
title: 运算符
description: Learn about the operators Dart supports.
description: 了解 Dart 支持的运算符。
prevpage:
  url: /language/variables
  title: Variables
  title: 变量
nextpage:
  url: /language/comments
  title: Comments
  title: 注释
---

<?code-excerpt replace="/ *\/\/\s+ignore_for_file:[^\n]+\n//g; /(^|\n) *\/\/\s+ignore:[^\n]+\n/$1/g; /(\n[^\n]+) *\/\/\s+ignore:[^\n]+\n/$1\n/g; / *\/\/\s+ignore:[^\n]+//g; /([A-Z]\w*)\d\b/$1/g"?>

<a name="operators"></a>

Dart supports the operators shown in the following table.
The table shows Dart's operator associativity
and [operator precedence](#operator-precedence-example) from highest to lowest,
which are an **approximation** of Dart's operator relationships.
You can implement many of these [operators as class members][].

Dart 支持下表中所示的运算符。该表按从高到低的优先级显示了 Dart 的运算符结合性和
[运算符优先级](#operator-precedence-example)，这是 Dart 运算符关系的**近似**表示。
你可以将这些[运算符实现为类成员][operators as class members]。

| Description                             | Operator                                                                                           | Associativity |
|-----------------------------------------|----------------------------------------------------------------------------------------------------|---------------|
| unary postfix                           | *`expr`*`++`    *`expr`*`--`    `()`    `[]`    `?[]`    `.`    `?.`    `!`                        | None          |
| unary prefix                            | `-`*`expr`*    `!`*`expr`*    `~`*`expr`*    `++`*`expr`*    `--`*`expr`*      `await` *`expr`*    | None          |
| multiplicative                          | `*`    `/`    `%`    `~/`                                                                          | Left          |
| additive                                | `+`    `-`                                                                                         | Left          |
| shift                                   | `<<`    `>>`    `>>>`                                                                              | Left          |
| bitwise AND                             | `&`                                                                                                | Left          |
| bitwise XOR                             | `^`                                                                                                | Left          |
| bitwise OR                              | <code>&#124;</code>                                                                                | Left          |
| relational and type test                | `>=`    `>`    `<=`    `<`    `as`    `is`    `is!`                                                | None          |
| equality                                | `==`    `!=`                                                                                       | None          |
| logical AND                             | `&&`                                                                                               | Left          |
| logical OR                              | <code>&#124;&#124;</code>                                                                          | Left          |
| if-null                                 | `??`                                                                                               | Left          |
| conditional                             | *`expr1`*    `?`    *`expr2`*    `:`    *`expr3`*                                                  | Right         |
| cascade                                 | `..`    `?..`                                                                                      | Left          |
| assignment                              | `=`    `*=`    `/=`    `+=`    `-=`    `&=`    `^=`    *etc.*                                      | Right         |
| spread  ([See note](#spread-operators)) | `...`    `...?`                                                                                    | None          |

{:.table .table-striped}

:::warning
The previous table should only be used as a helpful guide.
The notion of operator precedence and associativity
is an approximation of the truth found in the language grammar.
You can find the authoritative behavior of Dart's operator relationships
in the grammar defined in the [Dart language specification][].

上表仅应作为参考指南使用。
运算符优先级和结合性的概念是语言语法中真实情况的近似表示。
你可以在 [Dart 语言规范][Dart language specification]定义的语法中
找到 Dart 运算符关系的权威行为。
:::

When you use operators, you create expressions. Here are some examples
of operator expressions:

当你使用运算符时，你就创建了表达式。以下是一些运算符表达式的示例：

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

## 运算符优先级示例

In the [operator table](#operators),
each operator has higher precedence than the operators in the rows
that follow it. For example, the multiplicative operator `%` has higher
precedence than (and thus executes before) the equality operator `==`,
which has higher precedence than the logical AND operator `&&`. That
precedence means that the following two lines of code execute the same
way:

在[运算符表](#operators)中，每个运算符的优先级都高于其后行中的运算符。
例如，乘法运算符 `%` 的优先级高于（因此先于）等式运算符 `==`，
而等式运算符的优先级又高于逻辑与运算符 `&&`。
这种优先级意味着以下两行代码执行方式相同：

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

对于需要两个操作数的运算符，左侧操作数决定使用哪个方法。
例如，如果你有一个 `Vector` 对象和一个 `Point` 对象，
那么 `aVector + aPoint` 使用 `Vector` 的加法（`+`）。
:::


## Arithmetic operators

## 算术运算符

Dart supports the usual arithmetic operators, as shown in the following table.

Dart 支持常见的算术运算符，如下表所示。

| Operator    | Meaning                                                                  |
|-------------|--------------------------------------------------------------------------|
| `+`         | Add                                                                      |
| `-`         | Subtract                                                                 |
| `-`*`expr`* | Unary minus, also known as negation (reverse the sign of the expression) |
| `*`         | Multiply                                                                 |
| `/`         | Divide                                                                   |
| `~/`        | Divide, returning an integer result                                      |
| `%`         | Get the remainder of an integer division (modulo)                        |

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

Dart 还支持前缀和后缀递增和递减运算符。

| Operator                    | Meaning                                            |
|-----------------------------|----------------------------------------------------|
| `++`*`var`* | *`var`*  `=`  *`var `*  `+ 1` (expression value is *`var`* ` + 1`) |
| *`var`*`++` | *`var`*  `=`  *`var `*  `+ 1` (expression value is *`var`*)        |
| `--`*`var`* | *`var`*  `=`  *`var `*  `- 1` (expression value is *`var`* ` - 1`) |
| *`var`*`--` | *`var`*  `=`  *`var `*  `- 1` (expression value is *`var`*)       |

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

## 相等和关系运算符

The following table lists the meanings of equality and relational operators.

下表列出了相等和关系运算符的含义。

| Operator  | Meaning                                   |
|-----------|-------------------------------------------|
| `==`      | Equal; see discussion below               |
| `!=`      | Not equal                                 |
| `>`       | Greater than                              |
| `<`       | Less than                                 |
| `>=`      | Greater than or equal to                  |
| `<=`      | Less than or equal to                     |

{:.table .table-striped}

To test whether two objects x and y represent the same thing, use the
`==` operator. (In the rare case where you need to know whether two
objects are the exact same object, use the [identical()][]
function instead.) Here's how the `==` operator works:

要测试两个对象 x 和 y 是否表示相同的事物，请使用 `==` 运算符。
（在极少数情况下，如果你需要知道两个对象是否是完全相同的对象，
请改用 [identical()][] 函数。）`==` 运算符的工作方式如下：

1.  If *x* or *y* is null, return true if both are null, and false if only
    one is null.

1.  如果 *x* 或 *y* 为 null，则如果两者都为 null 则返回 true，
    如果只有一个为 null 则返回 false。

2.  Return the result of invoking the `==` method on *x* with the argument *y*.
    (That's right, operators such as `==` are methods that
    are invoked on their first operand.
    For details, see [Operators][].)

2.  返回在 *x* 上调用 `==` 方法并传入参数 *y* 的结果。
    （没错，像 `==` 这样的运算符是在第一个操作数上调用的方法。
    有关详细信息，请参阅[运算符][Operators]。）

Here's an example of using each of the equality and relational
operators:

以下是使用每个相等和关系运算符的示例：

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

## 类型测试运算符

The `as`, `is`, and `is!` operators are handy for checking types at
runtime.

`as`、`is` 和 `is!` 运算符便于在运行时检查类型。

| Operator  | Meaning                                              |
|-----------|------------------------------------------------------|
| `as`      | Typecast (also used to specify [library prefixes][]) |
| `is`      | True if the object has the specified type            |
| `is!`     | True if the object doesn't have the specified type   |

{:.table .table-striped}

The result of `obj is T` is true if `obj` implements the interface
specified by `T`. For example, `obj is Object?` is always true.

如果 `obj` 实现了 `T` 指定的接口，则 `obj is T` 的结果为 true。
例如，`obj is Object?` 总是为 true。

Use the `as` operator to cast an object to a particular type if and only if
you are sure that the object is of that type. Example:

当且仅当你确定对象是该类型时，使用 `as` 运算符将对象转换为特定类型。示例：

<?code-excerpt "misc/lib/language_tour/classes/employee.dart (emp-as-person)"?>
```dart
(employee as Person).firstName = 'Bob';
```

If you aren't sure that the object is of type `T`, then use `is T` to check the
type before using the object.

如果你不确定对象是否是类型 `T`，那么在使用对象之前使用 `is T` 检查类型。
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

这两段代码并不等价。如果 `employee` 为 null 或不是 `Person`，
第一个示例会抛出异常；第二个什么也不做。
:::

## Assignment operators

## 赋值运算符

As you've already seen, you can assign values using the `=` operator.
To assign only if the assigned-to variable is null,
use the `??=` operator.

如你所见，可以使用 `=` 运算符赋值。
要仅在被赋值变量为 null 时才赋值，请使用 `??=` 运算符。

<?code-excerpt "misc/test/language_tour/operators_test.dart (assignment)"?>
```dart
// Assign value to a
a = value;
// Assign value to b if b is null; otherwise, b stays the same
b ??= value;
```

Compound assignment operators such as `+=` combine
an operation with an assignment.

复合赋值运算符（如 `+=`）将操作与赋值结合在一起。

|      |       |       |        |                      |
|------|-------|-------|--------|----------------------|
| `=`  | `*=`  | `%=`  | `>>>=` | `^=`                 |
| `+=` | `/=`  | `<<=` | `&=`   | <code>&#124;=</code> |
| `-=` | `~/=` | `>>=` |        |                      |

{:.table}

Here's how compound assignment operators work:

以下是复合赋值运算符的工作方式：

|                           | Compound assignment | Equivalent expression |
|---------------------------|---------------------|-----------------------|
| **For an operator *op*:** | `a `  *`op`*`= b`   | `a = a ` *`op `* `b`  |
| **Example:**              | `a += b`            | `a = a + b`           |

{:.table}

The following example uses assignment and compound assignment
operators:

以下示例使用赋值和复合赋值运算符：

<?code-excerpt "misc/test/language_tour/operators_test.dart (op-assign)"?>
```dart
var a = 2; // Assign using =
a *= 3; // Assign and multiply: a = a * 3
assert(a == 6);
```


## Logical operators

## 逻辑运算符

You can invert or combine boolean expressions using the logical
operators.

你可以使用逻辑运算符反转或组合布尔表达式。

| Operator                   | Meaning                                                                  |
|----------------------------|--------------------------------------------------------------------------|
| `!`*`expr`*                | inverts the following expression (changes false to true, and vice versa) |
| <code>&#124;&#124;</code>  | logical OR                                                               |
| `&&`                       | logical AND                                                              |

{:.table .table-striped}

Here's an example of using the logical operators:

以下是使用逻辑运算符的示例：

<?code-excerpt "misc/lib/language_tour/operators.dart (op-logical)"?>
```dart
if (!done && (col == 0 || col == 3)) {
  // ...Do something...
}
```


## Bitwise and shift operators

## 位运算符和移位运算符

You can manipulate the individual bits of numbers in Dart. Usually,
you'd use these bitwise and shift operators with integers.

你可以在 Dart 中操作数字的各个位。通常，你会将这些位运算符和移位运算符与整数一起使用。

| Operator            | Meaning                                               |
|---------------------|-------------------------------------------------------|
| `&`                 | AND                                                   |
| <code>&#124;</code> | OR                                                    |
| `^`                 | XOR                                                   |
| `~`*`expr`*         | Unary bitwise complement (0s become 1s; 1s become 0s) |
| `<<`                | Shift left                                            |
| `>>`                | Shift right                                           |
| `>>>`               | Unsigned shift right                                  |

{:.table .table-striped}

:::note
The behavior of bitwise operations with large or negative operands
might differ between platforms.
To learn more, check out
[Bitwise operations platform differences][].

带有大数或负数操作数的位运算行为可能因平台而异。
要了解更多信息，请查看[位运算平台差异][Bitwise operations platform differences]。
:::

Here's an example of using bitwise and shift operators:

以下是使用位运算符和移位运算符的示例：

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

`>>>` 运算符（称为_三重移位_或_无符号移位_）
需要至少 2.14 的[语言版本][language version]。
:::

[Bitwise operations platform differences]: /resources/language/number-representation#bitwise-operations

## Conditional expressions

## 条件表达式

Dart has two operators that let you concisely evaluate expressions
that might otherwise require [if-else][] statements:

Dart 有两个运算符，可以让你简洁地求值那些可能需要 [if-else][] 语句的表达式：

_`condition`_ `?` _`expr1`_ `:` _`expr2`_
: If _condition_ is true, evaluates _expr1_ (and returns its value);
  otherwise, evaluates and returns the value of _expr2_.

_`condition`_ `?` _`expr1`_ `:` _`expr2`_
: 如果 _condition_ 为 true，则求值 _expr1_（并返回其值）；
  否则，求值并返回 _expr2_ 的值。

_`expr1`_ `??` _`expr2`_
: If _expr1_ is non-null, returns its value;
  otherwise, evaluates and returns the value of _expr2_.

_`expr1`_ `??` _`expr2`_
: 如果 _expr1_ 非空，则返回其值；
  否则，求值并返回 _expr2_ 的值。

When you need to assign a value
based on a boolean expression,
consider using the conditional operator `?` and `:`.

当你需要根据布尔表达式赋值时，考虑使用条件运算符 `?` 和 `:`。

<?code-excerpt "misc/lib/language_tour/operators.dart (if-then-else-operator)"?>
```dart
var visibility = isPublic ? 'public' : 'private';
```

If the boolean expression tests for null,
consider using the if-null operator `??`
(also known as the null-coalescing operator).

如果布尔表达式测试 null，考虑使用 if-null 运算符 `??`（也称为空值合并运算符）。

<?code-excerpt "misc/test/language_tour/operators_test.dart (if-null)"?>
```dart
String playerName(String? name) => name ?? 'Guest';
```

The previous example could have been written at least two other ways,
but not as succinctly:

前面的示例至少可以用另外两种方式编写，但不那么简洁：

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

## 级联表示法

Cascades (`..`, `?..`) allow you to make a sequence of operations
on the same object. In addition to accessing instance members,
you can also call instance methods on that same object.
This often saves you the step of creating a temporary variable and
allows you to write more fluid code.

级联（`..`、`?..`）允许你在同一对象上进行一系列操作。
除了访问实例成员外，你还可以在同一对象上调用实例方法。
这通常可以省去创建临时变量的步骤，并允许你编写更流畅的代码。

Consider the following code:

考虑以下代码：

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
级联表示法后面的代码对此对象进行操作，忽略任何可能返回的值。

The previous example is equivalent to this code:

前面的示例等价于以下代码：

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

如果级联操作的对象可能为 null，那么第一个操作使用_空值短路_级联（`?..`）。
以 `?..` 开始可以保证不会在该 null 对象上尝试任何级联操作。

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

前面的代码等价于以下代码：

<?code-excerpt "misc/test/language_tour/browser_test.dart (cascade-operator-example-expanded)"?>
```dart
final button = document.querySelector('#confirm');
button?.textContent = 'Confirm';
button?.classList.add('important');
button?.onClick.listen((e) => window.alert('Confirmed!'));
button?.scrollIntoView();
```

You can also nest cascades. For example:

你还可以嵌套级联。例如：

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

注意要在返回实际对象的函数上构造级联。例如，以下代码会失败：

<?code-excerpt "misc/lib/language_tour/operators.dart (cannot-cascade-on-void)" plaster="none"?>
```dart
var sb = StringBuffer();
sb.write('foo')
  ..write('bar'); // Error: method 'write' isn't defined for 'void'.
```

The `sb.write()` call returns void,
and you can't construct a cascade on `void`.

`sb.write()` 调用返回 void，你不能在 `void` 上构造级联。

:::note
Strictly speaking, the "double dot" notation for cascades isn't an operator.
It's just part of the Dart syntax.

严格来说，级联的"双点"表示法不是运算符。它只是 Dart 语法的一部分。
:::

## Spread operators

## 展开运算符

Spread operators evaluate an expression that yields a collection,
unpacks the resulting values, and inserts them into another collection.

展开运算符求值一个产生集合的表达式，解包结果值，并将它们插入到另一个集合中。

**The spread operator isn't actually an operator expression**.
The `...`/`...?` syntax is part of the collection literal itself.
So, you can learn more about spread operators on the
[Collections](/language/collections#spread-operators) page.

**展开运算符实际上不是一个运算符表达式**。
`...`/`...?` 语法是集合字面量本身的一部分。
因此，你可以在[集合](/language/collections#spread-operators)页面上了解更多关于展开运算符的信息。

Because it isn't an operator, the syntax doesn't
have any "[operator precedence](#operators)".
Effectively, it has the lowest "precedence" &mdash;
any kind of expression is valid as the spread target, such as:

因为它不是运算符，所以语法没有任何"[运算符优先级](#operators)"。
实际上，它具有最低的"优先级"——任何类型的表达式都可以作为展开目标，例如：

```dart
[...a + b]
```

## Other operators

## 其他运算符

You've seen most of the remaining operators in other examples:

你已经在其他示例中看到了大多数其他运算符：

| Operator | Name                         | Meaning                                                                                                                                                                                                                                                 |
|----------|------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `()`     | Function application         | Represents a function call                                                                                                                                                                                                                              |
| `[]`     | Subscript access             | Represents a call to the overridable `[]` operator; example: `fooList[1]` passes the int `1` to `fooList` to access the element at index `1`                                                                                                            |
| `?[]`    | Conditional subscript access | Like `[]`, but the leftmost operand can be null; example: `fooList?[1]` passes the int `1` to `fooList` to access the element at index `1` unless `fooList` is null (in which case the expression evaluates to null)                                    |
| `.`      | Member access                | Refers to a property of an expression; example: `foo.bar` selects property `bar` from expression `foo`                                                                                                                                                  |
| `?.`     | Conditional member access    | Like `.`, but the leftmost operand can be null; example: `foo?.bar` selects property `bar` from expression `foo` unless `foo` is null (in which case the value of `foo?.bar` is null)                                                                   |
| `!`      | Not-null assertion operator  | Casts an expression to its underlying non-nullable type, throwing a runtime exception if the cast fails; example: `foo!.bar` asserts `foo` is non-null and selects the property `bar`, unless `foo` is null (in which case a runtime exception is thrown) |

{:.table .table-striped}

For more information about the `.`, `?.`, and `..` operators, see
[Classes][].

有关 `.`、`?.` 和 `..` 运算符的更多信息，请参阅[类][Classes]。


[operators as class members]: /language/methods#operators
[Dart language specification]: /resources/language/spec
[identical()]: {{site.dart-api}}/dart-core/identical.html
[Operators]: /language/methods#operators
[library prefixes]: /language/libraries#specifying-a-library-prefix
[if-else]: /language/branches#if
[language version]: /resources/language/evolution#language-versioning
[Classes]: /language/classes
