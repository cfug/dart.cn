---
# title: Built-in types
title: 基本类型
# description: Information on the types Dart supports.
description: "Dart 所支持的类型简介。"
ai-translated: true
prevpage:
  url: /language/comments
# title: Comments
  title: 注释
nextpage:
  url: /language/records
# title: Records
  title: 记录
---

The Dart language has special support for the following:

Dart 语言对下列类型提供了特殊支持：

- [Numbers](#numbers) (`int`, `double`)

  [数字](#numbers)（`int`、`double`）
- [Strings](#strings) (`String`)

  [字符串](#strings)（`String`）
- [Booleans](#booleans) (`bool`)

  [布尔值](#booleans)（`bool`）
- [Records][] (`(value1, value2)`)

  [记录][Records]（`(value1, value2)`）
- [Functions][] (`Function`)

  [函数][Functions]（`Function`）
- [Lists][] (`List`, also known as *arrays*)

  [列表][Lists]（`List`，也称为 **数组**）
- [Sets][] (`Set`)

  [集合][Sets]（`Set`）
- [Maps][] (`Map`)

  [映射][Maps]（`Map`）
- [Runes](#runes-and-grapheme-clusters) (`Runes`; often replaced by the `characters` API)

  [Rune](#runes-and-grapheme-clusters)（`Runes`；常常被 `characters` API 取代）
- [Symbols](#symbols) (`Symbol`)

  [符号](#symbols)（`Symbol`）
- The value `null` (`Null`)

  值 `null`（`Null`）

This support includes the ability to create objects using literals.
For example, `'this is a string'` is a string literal,
and `true` is a boolean literal.

这种支持包括用字面量创建对象的能力。
例如，`'this is a string'` 是字符串字面量，
`true` 是布尔字面量。

Because every variable in Dart refers to an object—an instance of a
*class*—you can usually use *constructors* to initialize variables. Some
of the built-in types have their own constructors. For example, you can
use the `Map()` constructor to create a map.

因为 Dart 中的每个变量都指向一个对象，也就是某个 **类** 的实例，
你通常可以用 **构造函数** 来初始化变量。
有些内置类型有自己的构造函数。例如，可以用 `Map()` 构造函数创建映射。

Some other types also have special roles in the Dart language:

还有一些其它类型在 Dart 语言中也有特殊角色：

* `Object`: The superclass of all Dart classes except `Null`.

  `Object`：除 `Null` 以外所有 Dart 类的超类。
* `Enum`: The superclass of all enums.

  `Enum`：所有枚举的超类。
* `Future` and `Stream`: Used in [asynchronous programming][].

  `Future` 和 `Stream`：用于 [异步编程][asynchronous programming]。
* `Iterable`: Used in [for-in loops][iteration] and
  in synchronous [generator functions][].

  `Iterable`：用于 [for-in 循环][iteration]，
  以及同步的 [生成器函数][generator functions]。
* `Never`: Indicates that an expression can never
  successfully finish evaluating.
  Most often used for functions that always throw an exception.

  `Never`：表示表达式永远无法成功完成求值。
  最常用于总会抛出异常的函数。
* `dynamic`: Indicates that you want to disable static checking.
  Usually you should use `Object` or `Object?` instead.

  `dynamic`：表示你想关闭静态检查。
  通常应该改用 `Object` 或 `Object?`。
* `void`: Indicates that a value is never used.
  Often used as a return type.

  `void`：表示值永远不会被使用。
  常用作返回类型。

The `Object`, `Object?`, `Null`, and `Never` classes
have special roles in the class hierarchy.
Learn about these roles in [Understanding null safety][].

`Object`、`Object?`、`Null` 和 `Never` 类
在类层次中有特殊角色。
这些角色见 [理解空安全][Understanding null safety]。

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

Dart 的数字有两种：

[`int`][]

:   Integer values no larger than 64 bits,
    [depending on the platform][dart-numbers].
    On native platforms, values can be from
    -2<sup>63</sup> to 2<sup>63</sup> - 1.
    On the web, integer values are represented as JavaScript numbers
    (64-bit floating-point values with no fractional part)
    and can be from -2<sup>53</sup> to 2<sup>53</sup> - 1.

    不超过 64 位的整数值，[具体取决于平台][dart-numbers]。
    在原生平台上，取值可以从 -2<sup>63</sup> 到 2<sup>63</sup> - 1。
    在 Web 上，整数值表示为 JavaScript 数字
    （没有小数部分的 64 位浮点值），
    范围可以从 -2<sup>53</sup> 到 2<sup>53</sup> - 1。

[`double`][]

:   64-bit (double-precision) floating-point numbers, as specified by
    the IEEE 754 standard.

    64 位（双精度）浮点数，由 IEEE 754 标准规定。

Both `int` and `double` are subtypes of [`num`][].
The num type includes basic operators such as +, -, /, and \*,
and is also where you'll find `abs()`,` ceil()`,
and `floor()`, among other methods.
(Bitwise operators, such as \>\>, are defined in the `int` class.)
If num and its subtypes don't have what you're looking for, the
[`dart:math`][] library might.

`int` 和 `double` 都是 [`num`][] 的子类型。
num 类型包含 +、-、/ 和 \* 等基本运算符，
你也可以在这里找到 `abs()`、`ceil()`、`floor()` 等方法。
（`>>` 等位运算符定义在 `int` 类中。）
如果 num 及其子类型没有你要的功能，
可以看看 [`dart:math`][] 库。

Integers are numbers without a decimal point. Here are some examples of
defining integer literals:

整数是没有小数点的数字。下面是定义整数字面量的一些例子：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (integer-literals)"?>
```dart
var x = 1;
var hex = 0xDEADBEEF;
```

If a number includes a decimal, it is a double. Here are some examples
of defining double literals:

如果数字包含小数，它就是 double。下面是定义 double 字面量的一些例子：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (double-literals)"?>
```dart
var y = 1.1;
var exponents = 1.42e5;
```

You can also declare a variable as a num. If you do this, the variable
can have both integer and double values.

你也可以把变量声明为 num。这样做之后，该变量可以同时持有整数和 double 值。

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (declare-num)"?>
```dart
num x = 1; // x can have both int and double values
x += 2.5;
```

Integer literals are automatically converted to doubles when necessary:

必要时，整数字面量会自动转换成 double：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (int-to-double)"?>
```dart
double z = 1; // Equivalent to double z = 1.0.
```

Here's how you turn a string into a number, or vice versa:

下面是把字符串转换成数字，或者反向转换的方法：

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

`int` 类型规定了传统的移位（`<<`、`>>`、`>>>`）、
取反（`~`）、与（`&`）、或（`|`）和异或（`^`）运算符，
它们适合在位域中操作和掩码标志。
例如：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (bit-shifting)"?>
```dart
assert((3 << 1) == 6); // 0011 << 1 == 0110
assert((3 | 4) == 7); // 0011 | 0100 == 0111
assert((3 & 4) == 0); // 0011 & 0100 == 0000
```

For more examples, see the
[bitwise and shift operator][] section.

更多例子见 [位运算和移位运算符][bitwise and shift operator] 一节。

Number literals are compile-time constants.
Many arithmetic expressions are also compile-time constants,
as long as their operands are
compile-time constants that evaluate to numbers.

数字字面量是编译时常量。
许多算术表达式也是编译时常量，
只要它们的操作数是求值为数字的编译时常量。

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (const-num)"?>
```dart
const msPerSecond = 1000;
const secondsUntilRetry = 5;
const msUntilRetry = secondsUntilRetry * msPerSecond;
```

For more information, see [Numbers in Dart][dart-numbers].

更多信息见 [Dart 中的数字][dart-numbers]。

<a id="digit-separators"></a>

You can use one or more underscores (`_`) as digit separators
to make long number literals more readable.
Multiple digit separators allow for higher level grouping.

你可以用一个或多个下划线（`_`）作为数字分隔符，
让很长的数字字面量更易读。
多个数字分隔符可以做更高层的分组。

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

使用数字分隔符要求 [语言版本][language version] 至少为 3.6。
:::

## Strings

## 字符串

A Dart string (`String` object) holds a sequence of UTF-16 code units.
You can use either
single or double quotes to create a string:

Dart 字符串（`String` 对象）保存的是 UTF-16 码元序列。
你可以用单引号或双引号创建字符串：

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

可以用 `${` **表达式** `}` 把表达式的值放进字符串。
如果表达式是标识符，可以省略 `{}`。
要得到对象对应的字符串，Dart 会调用该对象的 `toString()` 方法。

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

`==` 运算符测试两个对象是否等价。
如果两个字符串包含相同的码元序列，它们就等价。
:::

You can concatenate strings using adjacent string literals or the `+`
operator:

可以用相邻的字符串字面量或 `+` 运算符连接字符串：

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

要创建多行字符串，使用三个单引号或三个双引号：

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

可以在前面加上 `r`，创建「原始」字符串：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (raw-strings)"?>
```dart
var s = r'In a raw string, not even \n gets special treatment.';
```

See [Runes and grapheme clusters](#runes-and-grapheme-clusters) for details on how
to express Unicode characters in a string.

关于如何在字符串中表示 Unicode 字符，
详见 [Rune 与字素簇](#runes-and-grapheme-clusters)。

String literals are compile-time constants,
as long as any interpolated expression is a compile-time constant
that evaluates to null or a numeric, string, or boolean value.

只要插值表达式是求值为 null、数字、字符串或布尔值的编译时常量，
字符串字面量就是编译时常量。

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

更多关于字符串的用法，请查看
[字符串和正则表达式](/libraries/dart-core#strings-and-regular-expressions)。


## Booleans

## 布尔值

To represent boolean values, Dart has a type named `bool`. Only two
objects have type bool: the boolean literals `true` and `false`,
which are both compile-time constants.

Dart 用名为 `bool` 的类型表示布尔值。只有两个对象的类型是 bool：
布尔字面量 `true` 和 `false`，它们都是编译时常量。

Dart's type safety means that you can't use code like
<code>if (<em>nonBooleanValue</em>)</code> or
<code>assert (<em>nonBooleanValue</em>)</code>.
Instead, explicitly check for values, like this:

Dart 的类型安全意味着你不能写类似
<code>if（**非布尔值**）</code> 或
<code>assert（**非布尔值**）</code> 的代码。
应该像这样显式检查值：

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

## Rune 与字素簇

In Dart, [runes][] expose the Unicode code points of a string.
You can use the [characters package][]
to view or manipulate user-perceived characters,
also known as
[Unicode (extended) grapheme clusters.][grapheme clusters]

在 Dart 中，[rune][runes] 暴露字符串的 Unicode 码位。
你可以用 [characters package][characters package]
查看或操作用户感知的字符，
也就是 [Unicode（扩展）字素簇][grapheme clusters]。

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

Unicode 为世界上所有书写系统中的每个字母、数字和符号
定义了唯一的数值。
因为 Dart 字符串是 UTF-16 码元序列，
在字符串中表示 Unicode 码位需要特殊语法。
通常的写法是 `\uXXXX`，其中 XXXX 是 4 位十六进制值。
例如，心形字符（♥）是 `\u2665`。
要指定多于或少于 4 位十六进制数字，把值放进花括号。
例如，大笑表情（😆）是 `\u{1f606}`。

If you need to read or write individual Unicode characters,
use the `characters` getter defined on String
by the characters package.
The returned [`Characters`][] object is the string as
a sequence of grapheme clusters.
Here's an example of using the characters API:

如果需要读写单个 Unicode 字符，
使用 characters package 在 String 上定义的 `characters` getter。
返回的 [`Characters`][] 对象把字符串表示成字素簇序列。
下面是使用 characters API 的例子：

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

输出大致如下，具体取决于你的环境：

```console
$ dart run bin/main.dart
Hi 🇩🇰
The end of the string: ???
The last character: 🇩🇰
```

For details on using the characters package to manipulate strings,
see the [example][characters example] and [API reference][characters API]
for the characters package.

关于用 characters package 操作字符串的细节，
见该 package 的 [示例][characters example] 和 [API 参考][characters API]。

## Symbols

## 符号

A [`Symbol`][] object
represents an operator or identifier declared in a Dart program. You
might never need to use symbols, but they're invaluable for APIs that
refer to identifiers by name, because minification changes identifier
names but not identifier symbols.

[`Symbol`][] 对象表示 Dart 程序中声明的运算符或标识符。
你也许永远不需要使用符号，
但对于按名称引用标识符的 API，它们非常宝贵，
因为压缩会改变标识符的名称，但不会改变标识符符号。

To get the symbol for an identifier, use a symbol literal, which is just
`#` followed by the identifier:

要获取标识符的符号，使用符号字面量，
也就是 `#` 后面跟上标识符：

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
[language version]: /language/versioning
