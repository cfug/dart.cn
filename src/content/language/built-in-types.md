---
title: Built-in types
title: 内置类型
description: Information on the types Dart supports.
description: 关于 Dart 支持的类型的信息。
prevpage:
  url: /language/comments
  title: Comments
  title: 注释
nextpage:
  url: /language/records
  title: Records
  title: Records（记录）
---

The Dart language has special support for the following:

Dart 语言对以下类型有特殊支持：

- [Numbers](#numbers) (`int`, `double`)

  [数字](#numbers)（`int`、`double`）

- [Strings](#strings) (`String`)

  [字符串](#strings)（`String`）

- [Booleans](#booleans) (`bool`)

  [布尔值](#booleans)（`bool`）

- [Records][] (`(value1, value2)`)

  [Records（记录）][Records]（`(value1, value2)`）

- [Functions][] (`Function`)

  [函数][Functions]（`Function`）

- [Lists][] (`List`, also known as *arrays*)

  [列表][Lists]（`List`，也称为**数组**）

- [Sets][] (`Set`)

  [集合][Sets]（`Set`）

- [Maps][] (`Map`)

  [映射][Maps]（`Map`）

- [Runes](#runes-and-grapheme-clusters) (`Runes`; often replaced by the `characters` API)

  [Runes 与 grapheme clusters](#runes-and-grapheme-clusters)（`Runes`；通常被 `characters` API 取代）

- [Symbols](#symbols) (`Symbol`)

  [Symbols（符号）](#symbols)（`Symbol`）

- The value `null` (`Null`)

  `null` 值（`Null`）

This support includes the ability to create objects using literals.
For example, `'this is a string'` is a string literal,
and `true` is a boolean literal.

这种支持包括使用字面量创建对象的能力。
例如，`'this is a string'` 是字符串字面量，
`true` 是布尔字面量。

Because every variable in Dart refers to an object—an instance of a
*class*—you can usually use *constructors* to initialize variables. Some
of the built-in types have their own constructors. For example, you can
use the `Map()` constructor to create a map.

因为 Dart 中的每个变量都引用一个对象——一个**类**的实例——
所以你通常可以使用**构造函数**来初始化变量。
一些内置类型有自己的构造函数。
例如，你可以使用 `Map()` 构造函数来创建一个 map。

Some other types also have special roles in the Dart language:

一些其他类型在 Dart 语言中也有特殊作用：

* `Object`: The superclass of all Dart classes except `Null`.

  `Object`：除了 `Null` 之外所有 Dart 类的超类。

* `Enum`: The superclass of all enums.

  `Enum`：所有枚举的超类。

* `Future` and `Stream`: Used in [asynchronous programming][].

  `Future` 和 `Stream`：用于 [异步编程][asynchronous programming]。

* `Iterable`: Used in [for-in loops][iteration] and
  in synchronous [generator functions][].

  `Iterable`：用于 [for-in 循环][iteration] 和同步 [生成器函数][generator functions]。

* `Never`: Indicates that an expression can never
  successfully finish evaluating.
  Most often used for functions that always throw an exception.

  `Never`：表示表达式永远无法成功完成求值。
  最常用于总是抛出异常的函数。

* `dynamic`: Indicates that you want to disable static checking.
  Usually you should use `Object` or `Object?` instead.

  `dynamic`：表示你想禁用静态检查。
  通常应该使用 `Object` 或 `Object?` 代替。

* `void`: Indicates that a value is never used.
  Often used as a return type.

  `void`：表示值永远不会被使用。
  通常用作返回类型。

The `Object`, `Object?`, `Null`, and `Never` classes
have special roles in the class hierarchy.
Learn about these roles in [Understanding null safety][].

`Object`、`Object?`、`Null` 和 `Never` 类在类层次结构中有特殊作用。
在 [理解空安全][Understanding null safety] 中了解这些作用。

{% comment %}
If we decide to cover `dynamic` more,
here's a nice example that illustrates what dynamic does:
  dynamic a = 2;
  String b = a; // No problem! Until runtime, when you get an uncaught error.

  Object c = 2;
  String d = c;  // Problem!
{% endcomment %}


## Numbers

## 数字

Dart numbers come in two flavors:

Dart 数字有两种形式：

[`int`][]

:   Integer values no larger than 64 bits,
    [depending on the platform][dart-numbers].
    On native platforms, values can be from
    -2<sup>63</sup> to 2<sup>63</sup> - 1.
    On the web, integer values are represented as JavaScript numbers
    (64-bit floating-point values with no fractional part)
    and can be from -2<sup>53</sup> to 2<sup>53</sup> - 1.

    不大于 64 位的整数值，[取决于平台][dart-numbers]。
    在原生平台上，值的范围是 -2<sup>63</sup> 到 2<sup>63</sup> - 1。
    在 Web 上，整数值表示为 JavaScript 数字
    （没有小数部分的 64 位浮点值），范围可以是 -2<sup>53</sup> 到 2<sup>53</sup> - 1。

[`double`][]

:   64-bit (double-precision) floating-point numbers, as specified by
    the IEEE 754 standard.

    64 位（双精度）浮点数，符合 IEEE 754 标准。

Both `int` and `double` are subtypes of [`num`][].
The num type includes basic operators such as +, -, /, and \*,
and is also where you'll find `abs()`,` ceil()`,
and `floor()`, among other methods.
(Bitwise operators, such as \>\>, are defined in the `int` class.)
If num and its subtypes don't have what you're looking for, the
[`dart:math`][] library might.

`int` 和 `double` 都是 [`num`][] 的子类型。
num 类型包括基本运算符，如 +、-、/ 和 \*，
你还可以在这里找到 `abs()`、`ceil()` 和 `floor()` 等方法。
（位运算符，如 \>\>，在 `int` 类中定义。）
如果 num 及其子类型没有你需要的，
[`dart:math`][] 库可能有。

Integers are numbers without a decimal point. Here are some examples of
defining integer literals:

整数是没有小数点的数字。以下是一些定义整数字面量的示例：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (integer-literals)"?>
```dart
var x = 1;
var hex = 0xDEADBEEF;
```

If a number includes a decimal, it is a double. Here are some examples
of defining double literals:

如果数字包含小数，则它是 double。以下是一些定义 double 字面量的示例：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (double-literals)"?>
```dart
var y = 1.1;
var exponents = 1.42e5;
```

You can also declare a variable as a num. If you do this, the variable
can have both integer and double values.

你也可以将变量声明为 num。这样，变量可以同时具有整数和 double 值。

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (declare-num)"?>
```dart
num x = 1; // x can have both int and double values
x += 2.5;
```

Integer literals are automatically converted to doubles when necessary:

整数字面量在必要时会自动转换为 double：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (int-to-double)"?>
```dart
double z = 1; // Equivalent to double z = 1.0.
```

Here's how you turn a string into a number, or vice versa:

以下是将字符串转换为数字或反过来的方法：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (number-conversion)"?>
```dart
// String -> int
var one = int.parse('1');
assert(one == 1);

// String -> double
var onePointOne = double.parse('1.1');
assert(onePointOne == 1.1);

// int -> String
String oneAsString = 1.toString();
assert(oneAsString == '1');

// double -> String
String piAsString = 3.14159.toStringAsFixed(2);
assert(piAsString == '3.14');
```

The `int` type specifies the traditional bitwise shift (`<<`, `>>`, `>>>`),
complement (`~`), AND (`&`), OR (`|`), and XOR (`^`) operators,
which are useful for manipulating and masking flags in bit fields.
For example:

`int` 类型指定了传统的位移（`<<`、`>>`、`>>>`）、
取反（`~`）、与（`&`）、或（`|`）和异或（`^`）运算符，
这些对于操作和屏蔽位字段中的标志非常有用。例如：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (bit-shifting)"?>
```dart
assert((3 << 1) == 6); // 0011 << 1 == 0110
assert((3 | 4) == 7); // 0011 | 0100 == 0111
assert((3 & 4) == 0); // 0011 & 0100 == 0000
```

For more examples, see the
[bitwise and shift operator][] section.

更多示例，请参阅 [位运算和移位运算符][bitwise and shift operator] 部分。

Number literals are compile-time constants.
Many arithmetic expressions are also compile-time constants,
as long as their operands are
compile-time constants that evaluate to numbers.

数字字面量是编译时常量。
许多算术表达式也是编译时常量，
只要它们的操作数是计算结果为数字的编译时常量。

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (const-num)"?>
```dart
const msPerSecond = 1000;
const secondsUntilRetry = 5;
const msUntilRetry = secondsUntilRetry * msPerSecond;
```

For more information, see [Numbers in Dart][dart-numbers].

更多信息，请参阅 [Dart 中的数字][dart-numbers]。

<a id="digit-separators"></a>

You can use one or more underscores (`_`) as digit separators
to make long number literals more readable.
Multiple digit separators allow for higher level grouping.

你可以使用一个或多个下划线（`_`）作为数字分隔符，
使长数字字面量更易读。
多个数字分隔符允许更高级别的分组。

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (digit-separators)"?>
```dart
var n1 = 1_000_000;
var n2 = 0.000_000_000_01;
var n3 = 0x00_14_22_01_23_45; // MAC address
var n4 = 555_123_4567; // US Phone number
var n5 = 100__000_000__000_000; // one hundred million million!
```

:::version-note
Using digit separators requires a [language version][] of at least 3.6.

使用数字分隔符需要至少 3.6 的 [语言版本][language version]。
:::

## Strings

## 字符串

A Dart string (`String` object) holds a sequence of UTF-16 code units.
You can use either
single or double quotes to create a string:

Dart 字符串（`String` 对象）包含一系列 UTF-16 代码单元。
你可以使用单引号或双引号来创建字符串：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (quoting)"?>
```dart
var s1 = 'Single quotes work well for string literals.';
var s2 = "Double quotes work just as well.";
var s3 = 'It\'s easy to escape the string delimiter.';
var s4 = "It's even easier to use the other delimiter.";
```

<a id="string-interpolation"></a>

You can put the value of an expression inside a string by using
`${`*`expression`*`}`. If the expression is an identifier, you can skip
the `{}`. To get the string corresponding to an object, Dart calls the
object's `toString()` method.

你可以使用 `${`*`expression`*`}` 将表达式的值放入字符串中。
如果表达式是标识符，可以省略 `{}`。
为了获取对象对应的字符串，Dart 会调用对象的 `toString()` 方法。

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (string-interpolation)"?>
```dart
var s = 'string interpolation';

assert(
  'Dart has $s, which is very handy.' ==
      'Dart has string interpolation, '
          'which is very handy.',
);
assert(
  'That deserves all caps. '
          '${s.toUpperCase()} is very handy!' ==
      'That deserves all caps. '
          'STRING INTERPOLATION is very handy!',
);
```

:::note
The `==` operator tests whether two objects are equivalent.
Two strings are equivalent if they contain the
same sequence of code units.

`==` 运算符测试两个对象是否相等。
如果两个字符串包含相同的代码单元序列，则它们相等。
:::

You can concatenate strings using adjacent string literals or the `+`
operator:

你可以使用相邻的字符串字面量或 `+` 运算符来连接字符串：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (adjacent-string-literals)"?>
```dart
var s1 =
    'String '
    'concatenation'
    " works even over line breaks.";
assert(
  s1 ==
      'String concatenation works even over '
          'line breaks.',
);

var s2 = 'The + operator ' + 'works, as well.';
assert(s2 == 'The + operator works, as well.');
```

To create a multi-line string, use a triple quote with
either single or double quotation marks:

要创建多行字符串，请使用带有单引号或双引号的三重引号：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (triple-quotes)"?>
```dart
var s1 = '''
You can create
multi-line strings like this one.
''';

var s2 = """This is also a
multi-line string.""";
```

You can create a "raw" string by prefixing it with `r`:

你可以通过在字符串前加上 `r` 来创建"原始"字符串：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (raw-strings)"?>
```dart
var s = r'In a raw string, not even \n gets special treatment.';
```

See [Runes and grapheme clusters](#runes-and-grapheme-clusters) for details on how
to express Unicode characters in a string.

有关如何在字符串中表达 Unicode 字符的详细信息，
请参阅 [Runes 和 grapheme clusters](#runes-and-grapheme-clusters)。

String literals are compile-time constants,
as long as any interpolated expression is a compile-time constant
that evaluates to null or a numeric, string, or boolean value.

字符串字面量是编译时常量，
只要任何插值表达式是计算结果为 null、数字、字符串或布尔值的编译时常量。

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (string-literals)"?>
```dart
// These work in a const string.
const aConstNum = 0;
const aConstBool = true;
const aConstString = 'a constant string';

// These do NOT work in a const string.
var aNum = 0;
var aBool = true;
var aString = 'a string';
const aConstList = [1, 2, 3];

const validConstString = '$aConstNum $aConstBool $aConstString';
// const invalidConstString = '$aNum $aBool $aString $aConstList';
```

For more information on using strings, check out
[Strings and regular expressions](/libraries/dart-core#strings-and-regular-expressions).

有关使用字符串的更多信息，请查看
[字符串和正则表达式](/libraries/dart-core#strings-and-regular-expressions)。


## Booleans

## 布尔值

To represent boolean values, Dart has a type named `bool`. Only two
objects have type bool: the boolean literals `true` and `false`,
which are both compile-time constants.

为了表示布尔值，Dart 有一个名为 `bool` 的类型。
只有两个对象具有 bool 类型：布尔字面量 `true` 和 `false`，
它们都是编译时常量。

Dart's type safety means that you can't use code like
<code>if (<em>nonbooleanValue</em>)</code> or
<code>assert (<em>nonbooleanValue</em>)</code>.
Instead, explicitly check for values, like this:


Dart 的类型安全意味着你不能使用
<code>if (<em>nonbooleanValue</em>)</code> 或
<code>assert (<em>nonbooleanValue</em>)</code> 这样的代码。
相反，需要显式检查值，如下所示：
<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (no-truthy)"?>
```dart
// Check for an empty string.
var fullName = '';
assert(fullName.isEmpty);

// Check for zero.
var hitPoints = 0;
assert(hitPoints == 0);

// Check for null.
var unicorn = null;
assert(unicorn == null);

// Check for NaN.
var iMeantToDoThis = 0 / 0;
assert(iMeantToDoThis.isNaN);
```

## Runes and grapheme clusters

## Runes 和 grapheme clusters

In Dart, [runes][] expose the Unicode code points of a string.
You can use the [characters package][]
to view or manipulate user-perceived characters,
also known as
[Unicode (extended) grapheme clusters.][grapheme clusters]

在 Dart 中，[runes][] 暴露字符串的 Unicode 码点。
你可以使用 [characters 包][characters package]
来查看或操作用户感知的字符，
也称为 [Unicode（扩展）grapheme clusters][grapheme clusters]。

Unicode defines a unique numeric value for each letter, digit,
and symbol used in all of the world's writing systems.
Because a Dart string is a sequence of UTF-16 code units,
expressing Unicode code points within a string requires
special syntax.
The usual way to express a Unicode code point is
`\uXXXX`, where XXXX is a 4-digit hexadecimal value.
For example, the heart character (♥) is `\u2665`.
To specify more or less than 4 hex digits,
place the value in curly brackets.
For example, the laughing emoji (😆) is `\u{1f606}`.

Unicode 为世界上所有书写系统中使用的每个字母、数字和符号定义了唯一的数值。
由于 Dart 字符串是 UTF-16 代码单元的序列，
因此在字符串中表达 Unicode 码点需要特殊的语法。
表达 Unicode 码点的常用方式是 `\uXXXX`，
其中 XXXX 是 4 位十六进制值。
例如，心形字符（♥）是 `\u2665`。
要指定多于或少于 4 个十六进制数字，请将值放在大括号中。
例如，笑的表情符号（😆）是 `\u{1f606}`。

If you need to read or write individual Unicode characters,
use the `characters` getter defined on String
by the characters package.
The returned [`Characters`][] object is the string as
a sequence of grapheme clusters.
Here's an example of using the characters API:

如果你需要读取或写入单个 Unicode 字符，
请使用 characters 包在 String 上定义的 `characters` getter。
返回的 [`Characters`][] 对象是作为 grapheme clusters 序列的字符串。
以下是使用 characters API 的示例：

<?code-excerpt "misc/lib/language_tour/characters.dart"?>
```dart
import 'package:characters/characters.dart';

void main() {
  var hi = 'Hi 🇩🇰';
  print(hi);
  print('The end of the string: ${hi.substring(hi.length - 1)}');
  print('The last character: ${hi.characters.last}');
}
```

The output, depending on your environment, looks something like this:

输出结果取决于你的环境，大致如下：

```console
$ dart run bin/main.dart
Hi 🇩🇰
The end of the string: ???
The last character: 🇩🇰
```

For details on using the characters package to manipulate strings,
see the [example][characters example] and [API reference][characters API]
for the characters package.

有关使用 characters 包操作字符串的详细信息，
请参阅 characters 包的 [示例][characters example] 和 [API 参考][characters API]。

## Symbols

## Symbols（符号）

A [`Symbol`][] object
represents an operator or identifier declared in a Dart program. You
might never need to use symbols, but they're invaluable for APIs that
refer to identifiers by name, because minification changes identifier
names but not identifier symbols.

[`Symbol`][] 对象表示在 Dart 程序中声明的运算符或标识符。
你可能永远不需要使用符号，但它们对于按名称引用标识符的 API 非常有价值，
因为代码压缩会更改标识符名称，但不会更改标识符符号。

To get the symbol for an identifier, use a symbol literal, which is just
`#` followed by the identifier:

要获取标识符的符号，请使用符号字面量，即 `#` 后跟标识符：

```plaintext
#radix
#bar
```

{% comment %}
The code from the following excerpt isn't actually what is being shown in the page

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (symbols)"?>
```dart
void main() {
  print(Function.apply(int.parse, ['11']));
  print(Function.apply(int.parse, ['11'], {#radix: 16}));
}
```
{% endcomment %}

Symbol literals are compile-time constants.

符号字面量是编译时常量。



[Records]: /language/records
[Functions]: /language/functions#function-types
[Lists]: /language/collections#lists
[Sets]: /language/collections#sets
[Maps]: /language/collections#maps
[asynchronous programming]: /language/async
[iteration]: /libraries/dart-core#iteration
[generator functions]: /language/functions#generators
[Understanding null safety]: /null-safety/understanding-null-safety#top-and-bottom
[`int`]: {{site.dart-api}}/dart-core/int-class.html
[`double`]: {{site.dart-api}}/dart-core/double-class.html
[`num`]: {{site.dart-api}}/dart-core/num-class.html
[`dart:math`]: {{site.dart-api}}/dart-math/dart-math-library.html
[bitwise and shift operator]: /language/operators#bitwise-and-shift-operators
[dart-numbers]: /resources/language/number-representation
[runes]: {{site.dart-api}}/dart-core/Runes-class.html
[characters package]: {{site.pub-pkg}}/characters
[grapheme clusters]: https://unicode.org/reports/tr29/#Grapheme_Cluster_Boundaries
[`Characters`]: {{site.pub-api}}/characters/latest/characters/Characters-class.html
[characters API]: {{site.pub-api}}/characters
[characters example]: {{site.pub-pkg}}/characters/example
[`Symbol`]: {{site.dart-api}}/dart-core/Symbol-class.html
[language version]: /resources/language/evolution#language-versioning
