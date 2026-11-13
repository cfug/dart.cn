---
# title: dart:core
title: dart:core
# description: Learn about the major features in Dart's dart:core library.
description: "了解 Dart 的 dart:core 库的主要功能。"
ai-translated: true
prevpage:
  url: /libraries
# title: Core libraries
  title: Dart 核心库
nextpage:
  url: /libraries/dart-async
# title: dart:async
  title: dart:async
---

<?code-excerpt replace="/ *\/\/\s+ignore_for_file:[^\n]+\n//g; /(^|\n) *\/\/\s+ignore:[^\n]+\n/$1/g; /(\n[^\n]+) *\/\/\s+ignore:[^\n]+\n/$1\n/g"?>
<?code-excerpt plaster="none"?>

The dart:core library ([API reference][dart:core])
provides a small but critical set of built-in functionality.
This library is automatically imported into every Dart program.

dart:core 库（[API 参考][dart:core]）
提供了一组小而关键的内置功能。
这个库会自动导入到每个 Dart 程序中。


## Printing to the console

## 打印到控制台

The top-level `print()` method takes a single argument (any Object)
and displays that object's string value (as returned by `toString()`)
in the console.

顶层 `print()` 方法接受单个参数（任何 Object），
并在控制台显示该对象的字符串值
（由 `toString()` 返回）。

<?code-excerpt "misc/test/library_tour/core_test.dart (print)"?>
```dart
print(anObject);
print('I drink $tea.');
```

For more information on basic strings and `toString()`, see
[Strings](/language/built-in-types#strings) in the language tour.

关于基本字符串和 `toString()` 的更多信息，
请参阅语言之旅中的
[字符串](/language/built-in-types#strings)。


## Numbers

## 数字

The dart:core library defines the num, int, and double classes, which
have some basic utilities for working with numbers.

dart:core 库定义了 num、int 和 double 类，
它们提供了一些处理数字的基本工具。

You can convert a string into an integer or double with the `parse()`
methods of int and double, respectively:

你可以分别用 int 和 double 的 `parse()` 方法
把字符串转换为整数或 double：

<?code-excerpt "misc/test/library_tour/core_test.dart (int-double-parse)"?>
```dart
assert(int.parse('42') == 42);
assert(int.parse('0x42') == 66);
assert(double.parse('0.50') == 0.5);
```

Or use the parse() method of num, which creates an integer if possible
and otherwise a double:

或者使用 num 的 parse() 方法，
它会尽可能创建整数，否则创建 double：

<?code-excerpt "misc/test/library_tour/core_test.dart (num-parse)"?>
```dart
assert(num.parse('42') is int);
assert(num.parse('0x42') is int);
assert(num.parse('0.50') is double);
```

To specify the base of an integer, add a `radix` parameter:

要指定整数的进制，请加上 `radix` 参数：

<?code-excerpt "misc/test/library_tour/core_test.dart (radix)"?>
```dart
assert(int.parse('42', radix: 16) == 66);
```

Use the `toString()` method to convert an
int or double to a string. To specify the number of digits to the right
of the decimal, use [toStringAsFixed().][toStringAsFixed()] To specify the
number of significant digits in the string, use
[toStringAsPrecision():][toStringAsPrecision()]

使用 `toString()` 方法可以把
int 或 double 转换为字符串。
要指定小数点右边的位数，
请使用 [toStringAsFixed()][toStringAsFixed()]。
要指定字符串中的有效数字位数，
请使用 [toStringAsPrecision()][toStringAsPrecision()]。

<?code-excerpt "misc/test/library_tour/core_test.dart (to-string)"?>
```dart
// Convert an int to a string.
assert(42.toString() == '42');

// Convert a double to a string.
assert(123.456.toString() == '123.456');

// Specify the number of digits after the decimal.
assert(123.456.toStringAsFixed(2) == '123.46');

// Specify the number of significant figures.
assert(123.456.toStringAsPrecision(2) == '1.2e+2');
assert(double.parse('1.2e+2') == 120.0);
```

For more information, see the API documentation for
[int,][int] [double,][double] and [num.][num] Also see
the [dart:math section](/libraries/dart-math)

更多信息请参阅
[int][int]、[double][double] 和 [num][num] 的 API 文档，
以及 [dart:math 一节](/libraries/dart-math)。

## Strings and regular expressions

## 字符串与正则表达式

A string in Dart is an immutable sequence of UTF-16 code units.
The language tour has more information about
[strings](/language/built-in-types#strings).
You can use regular expressions (RegExp objects)
to search within strings and to
replace parts of strings.

Dart 中的字符串是不可变的 UTF-16 码元序列。
语言之旅中有更多关于
[字符串](/language/built-in-types#strings) 的信息。
你可以使用正则表达式（RegExp 对象）
在字符串内搜索，以及替换字符串的部分内容。

The String class defines such methods as `split()`, `contains()`,
`startsWith()`, `endsWith()`, and more.

String 类定义了 `split()`、`contains()`、
`startsWith()`、`endsWith()` 等方法。

### Searching inside a string

### 在字符串内搜索

You can find particular locations within a string, as well as check
whether a string begins with or ends with a particular pattern. For
example:

你可以查找字符串中的特定位置，
也可以检查字符串是否以特定模式开头或结尾。
例如：

<?code-excerpt "misc/test/library_tour/core_test.dart (contains-etc)"?>
```dart
// Check whether a string contains another string.
assert('Never odd or even'.contains('odd'));

// Does a string start with another string?
assert('Never odd or even'.startsWith('Never'));

// Does a string end with another string?
assert('Never odd or even'.endsWith('even'));

// Find the location of a string inside a string.
assert('Never odd or even'.indexOf('odd') == 6);
```

### Extracting data from a string

### 从字符串中提取数据

You can get the individual characters from a string as Strings or ints,
respectively. To be precise, you actually get individual UTF-16 code
units; high-numbered characters such as the treble clef symbol
('\\u{1D11E}') are two code units apiece.

你可以分别以 String 或 int 的形式
获取字符串中的单个字符。
准确地说，你获取的是单个 UTF-16 码元；
高位字符（例如高音谱号符号 '\u{1D11E}'）
每个占两个码元。

You can also extract a substring or split a string into a list of
substrings:

你也可以提取子串，
或把字符串拆分为子串列表：

<?code-excerpt "misc/test/library_tour/core_test.dart (substring-etc)"?>
```dart
// Grab a substring.
assert('Never odd or even'.substring(6, 9) == 'odd');

// Split a string using a string pattern.
var parts = 'progressive web apps'.split(' ');
assert(parts.length == 3);
assert(parts[0] == 'progressive');

// Get a UTF-16 code unit (as a string) by index.
assert('Never odd or even'[0] == 'N');

// Use split() with an empty string parameter to get
// a list of all characters (as Strings); good for
// iterating.
for (final char in 'hello'.split('')) {
  print(char);
}

// Get all the UTF-16 code units in the string.
var codeUnitList = 'Never odd or even'.codeUnits.toList();
assert(codeUnitList[0] == 78);
```

:::note
In many cases, you want to work with
Unicode grapheme clusters
as opposed to pure code units.
These are characters as they are perceived
by the user (for example, "🇬🇧" is one
user-perceived character but several
UTF-16 code units).
For this, the Dart team provides the
[`characters` package.]({{site.pub-pkg}}/characters)

很多情况下，你想处理的是
Unicode 字素簇，而不是纯粹的码元。
它们是用户感知到的字符
（例如，「🇬🇧」是一个用户感知的字符，
却由多个 UTF-16 码元组成）。
为此，Dart 团队提供了
[`characters` package]({{site.pub-pkg}}/characters)。
:::

### Converting to uppercase or lowercase

### 转换为大写或小写

You can easily convert strings to their uppercase and lowercase
variants:

你可以轻松地把字符串转换为大写和小写形式：

<?code-excerpt "misc/test/library_tour/core_test.dart (case-conversions)"?>
```dart
// Convert to uppercase.
assert('web apps'.toUpperCase() == 'WEB APPS');

// Convert to lowercase.
assert('WEB APPS'.toLowerCase() == 'web apps');
```

:::note
These methods don't work for every language. For example, the Turkish
alphabet's dotless *I* is converted incorrectly.

这些方法并非对所有语言都有效。
例如，土耳其语字母表中不带点的 *I*
就会被错误转换。
:::


### Trimming and empty strings

### 去除空白与空字符串

Remove all leading and trailing white space with `trim()`. To check
whether a string is empty (length is zero), use `isEmpty`.

使用 `trim()` 去除所有前导和尾随空白。
要检查字符串是否为空（长度为零），
请使用 `isEmpty`。

<?code-excerpt "misc/test/library_tour/core_test.dart (trim-etc)"?>
```dart
// Trim a string.
assert('  hello  '.trim() == 'hello');

// Check whether a string is empty.
assert(''.isEmpty);

// Strings with only white space are not empty.
assert('  '.isNotEmpty);
```

### Replacing part of a string

### 替换字符串的一部分

Strings are immutable objects, which means you can create them but you
can't change them. If you look closely at the [String API reference,][String]
you'll notice that
none of the methods actually changes the state of a String. For example,
the method `replaceAll()` returns a new String without changing the
original String:

字符串是不可变对象，
意味着你可以创建它们，但不能修改它们。
如果你仔细查看 [String API 参考][String]，
会发现没有任何方法真正改变 String 的状态。
例如，`replaceAll()` 方法返回一个新的 String，
而不改变原来的 String：

<?code-excerpt "misc/test/library_tour/core_test.dart (replace)"?>
```dart
var greetingTemplate = 'Hello, NAME!';
var greeting = greetingTemplate.replaceAll(RegExp('NAME'), 'Bob');

// greetingTemplate didn't change.
assert(greeting != greetingTemplate);
```

### Building a string

### 构建字符串

To programmatically generate a string, you can use StringBuffer. A
StringBuffer doesn't generate a new String object until `toString()` is
called. The `writeAll()` method has an optional second parameter that
lets you specify a separator—in this case, a space.

要以编程方式生成字符串，可以使用 StringBuffer。
StringBuffer 在调用 `toString()` 之前
不会生成新的 String 对象。
`writeAll()` 方法有一个可选的第二个参数，
让你指定分隔符——在这个例子中是空格。

<?code-excerpt "misc/test/library_tour/core_test.dart (string-buffer)"?>
```dart
var sb = StringBuffer();
sb
  ..write('Use a StringBuffer for ')
  ..writeAll(['efficient', 'string', 'creation'], ' ')
  ..write('.');

var fullString = sb.toString();

assert(fullString == 'Use a StringBuffer for efficient string creation.');
```

### Regular expressions

### 正则表达式

The RegExp class provides the same capabilities as JavaScript regular
expressions. Use regular expressions for efficient searching and pattern
matching of strings.

RegExp 类提供与 JavaScript 正则表达式相同的能力。
使用正则表达式可以高效地搜索字符串
并进行模式匹配。

<?code-excerpt "misc/test/library_tour/core_test.dart (regexp)"?>
```dart
// Here's a regular expression for one or more digits.
var digitSequence = RegExp(r'\d+');

var lettersOnly = 'llamas live fifteen to twenty years';
var someDigits = 'llamas live 15 to 20 years';

// contains() can use a regular expression.
assert(!lettersOnly.contains(digitSequence));
assert(someDigits.contains(digitSequence));

// Replace every match with another string.
var exedOut = someDigits.replaceAll(digitSequence, 'XX');
assert(exedOut == 'llamas live XX to XX years');
```

You can work directly with the RegExp class, too. The Match class
provides access to a regular expression match.

你也可以直接使用 RegExp 类。
Match 类提供了对正则表达式匹配结果的访问。

<?code-excerpt "misc/test/library_tour/core_test.dart (match)"?>
```dart
var digitSequence = RegExp(r'\d+');
var someDigits = 'llamas live 15 to 20 years';

// Check whether the reg exp has a match in a string.
assert(digitSequence.hasMatch(someDigits));

// Loop through all matches.
for (final match in digitSequence.allMatches(someDigits)) {
  print(match.group(0)); // 15, then 20
}
```

### More information

### 更多信息

Refer to the [String API reference][String] for a full list of
methods. Also see the API reference for [StringBuffer,][StringBuffer]
[Pattern,][Pattern] [RegExp,][RegExp] and [Match.][Match]

完整的方法列表请参阅 [String API 参考][String]，
以及 [StringBuffer][StringBuffer]、[Pattern][Pattern]、
[RegExp][RegExp] 和 [Match][Match] 的 API 参考。

## Collections

## 集合

Dart ships with a core collections API, which includes classes for
lists, sets, and maps.

Dart 自带核心集合 API，
包含用于 list、set 和 map 的类。

:::tip
To practice using APIs that are available to both lists and sets,
follow the [Iterable collections tutorial](/libraries/collections/iterables).

要练习使用 list 和 set 都可用的 API，
请跟随
[Iterable 集合教程](/libraries/collections/iterables)。
:::

### Lists

### List

As the language tour shows, you can use literals to create and
initialize [lists](/language/collections#lists). Alternatively, use one of the List
constructors. The List class also defines several methods for adding
items to and removing items from lists.

正如语言之旅所示，你可以用字面量
创建并初始化 [list](/language/collections#lists)。
也可以使用 List 的某个构造函数。
List 类还定义了多个方法，
用于向 list 添加元素和从 list 移除元素。

<?code-excerpt "misc/test/library_tour/core_test.dart (list)"?>
```dart
// Create an empty list of strings.
var grains = <String>[];
assert(grains.isEmpty);

// Create a list using a list literal.
var fruits = ['apples', 'oranges'];

// Add to a list.
fruits.add('kiwis');

// Add multiple items to a list.
fruits.addAll(['grapes', 'bananas']);

// Get the list length.
assert(fruits.length == 5);

// Remove a single item.
var appleIndex = fruits.indexOf('apples');
fruits.removeAt(appleIndex);
assert(fruits.length == 4);

// Remove all elements from a list.
fruits.clear();
assert(fruits.isEmpty);

// You can also create a List using one of the constructors.
var vegetables = List.filled(99, 'broccoli');
assert(vegetables.every((v) => v == 'broccoli'));
```

Use `indexOf()` to find the index of an object in a list:

使用 `indexOf()` 查找对象在 list 中的索引：

<?code-excerpt "misc/test/library_tour/core_test.dart (index-of)"?>
```dart
var fruits = ['apples', 'oranges'];

// Access a list item by index.
assert(fruits[0] == 'apples');

// Find an item in a list.
assert(fruits.indexOf('apples') == 0);
```

Sort a list using the `sort()` method. You can provide a sorting
function that compares two objects. This sorting function must return \<
0 for *smaller*, 0 for the *same*, and \> 0 for *bigger*. The following
example uses `compareTo()`, which is defined by
[Comparable][] and implemented by String.

使用 `sort()` 方法对 list 排序。
你可以提供一个比较两个对象的排序函数。
这个排序函数对 *更小* 必须返回 \< 0，
对 *相同* 返回 0，对 *更大* 返回 \> 0。
下面的例子使用 `compareTo()`，
它由 [Comparable][] 定义、由 String 实现。

<?code-excerpt "misc/test/library_tour/core_test.dart (compare-to)"?>
```dart
var fruits = ['bananas', 'apples', 'oranges'];

// Sort a list.
fruits.sort((a, b) => a.compareTo(b));
assert(fruits[0] == 'apples');
```

Lists are parameterized types
([generics](/language/generics)),
so you can specify the type that a list
should contain:

list 是参数化类型（[泛型](/language/generics)），
所以你可以指定 list 应包含的类型：

<?code-excerpt "misc/test/library_tour/core_test.dart (list-of-string)"?>
```dart
// This list should contain only strings.
var fruits = <String>[];

fruits.add('apples');
var fruit = fruits[0];
assert(fruit is String);
```

<?code-excerpt "misc/lib/library_tour/core/collections.dart (list-of-string)"?>
```dart tag=fails-sa
fruits.add(5); // Error: 'int' can't be assigned to 'String'
```

:::note
In many cases, you don't
need to explicitly specify generic
types, because Dart will
[infer](/language/type-system#type-inference)
them for you.
A list like `['Dash', 'Dart']` is understood
to be a `List<String>` (read: list of strings).

But there are times when you _should_ specify
the generic type. Like, for example, when Dart doesn't have
anything to infer from: `[]` could be a list of any
combination of things.
That's often not what you want, so you write `<String>[]`
or `<Person>[]` or something similar.

很多情况下，你不必显式指定泛型类型，
因为 Dart 会为你
[推断](/language/type-system#type-inference)。
像 `['Dash', 'Dart']` 这样的 list
会被理解为 `List<String>`（读作：字符串的 list）。

但有时你 _应该_ 指定泛型类型。
例如，当 Dart 没有任何可供推断的信息时：
`[]` 可以是任何东西任意组合的 list。
这往往不是你想要的，
所以你会写 `<String>[]`、`<Person>[]`
或类似的形式。
:::

Refer to the [List API reference][List] for a full list of methods.

完整的方法列表请参阅 [List API 参考][List]。

### Sets

### Set

A set in Dart is an unordered collection of unique items. Because a set
is unordered, you can't get a set's items by index (position).

Dart 中的 set 是无序的唯一元素集合。
因为 set 是无序的，
你无法通过索引（位置）获取 set 的元素。

<?code-excerpt "misc/test/library_tour/core_test.dart (set)"?>
```dart
// Create an empty set of strings.
var ingredients = <String>{};

// Add new items to it.
ingredients.addAll(['gold', 'titanium', 'xenon']);
assert(ingredients.length == 3);

// Adding a duplicate item has no effect.
ingredients.add('gold');
assert(ingredients.length == 3);

// Remove an item from a set.
ingredients.remove('gold');
assert(ingredients.length == 2);

// You can also create sets using
// one of the constructors.
var atomicNumbers = Set.from([79, 22, 54]);
```

Use `contains()` and `containsAll()` to check whether one or more
objects are in a set:

使用 `contains()` 和 `containsAll()`
检查一个或多个对象是否在 set 中：

<?code-excerpt "misc/test/library_tour/core_test.dart (contains)"?>
```dart
var ingredients = Set<String>();
ingredients.addAll(['gold', 'titanium', 'xenon']);

// Check whether an item is in the set.
assert(ingredients.contains('titanium'));

// Check whether all the items are in the set.
assert(ingredients.containsAll(['titanium', 'xenon']));
```

An intersection is a set whose items are in two other sets.

交集是一个 set，其元素同时属于另外两个 set。

<?code-excerpt "misc/test/library_tour/core_test.dart (intersection)"?>
```dart
var ingredients = Set<String>();
ingredients.addAll(['gold', 'titanium', 'xenon']);

// Create the intersection of two sets.
var nobleGases = Set.from(['xenon', 'argon']);
var intersection = ingredients.intersection(nobleGases);
assert(intersection.length == 1);
assert(intersection.contains('xenon'));
```

Refer to the [Set API reference][Set] for a full list of methods.

完整的方法列表请参阅 [Set API 参考][Set]。

### Maps

### Map

A map, commonly known as a *dictionary* or *hash*, is an unordered
collection of key-value pairs. Maps associate a key to some value for
easy retrieval. Unlike in JavaScript, Dart objects are not maps.

map 通常称为 *字典* 或 *哈希*，
是无序的键值对集合。
map 把键关联到某个值，便于检索。
与 JavaScript 不同，Dart 对象不是 map。

You can declare a map using a terse literal syntax, or you can use a
traditional constructor:

你可以用简洁的字面量语法声明 map，
也可以使用传统的构造函数：

<?code-excerpt "misc/test/library_tour/core_test.dart (map)"?>
```dart
// Maps often use strings as keys.
var hawaiianBeaches = {
  'Oahu': ['Waikiki', 'Kailua', 'Waimanalo'],
  'Big Island': ['Wailea Bay', 'Pololu Beach'],
  'Kauai': ['Hanalei', 'Poipu'],
};

// Maps can be built from a constructor.
var searchTerms = Map();

// Maps are parameterized types; you can specify what
// types the key and value should be.
var nobleGases = Map<int, String>();
```

You add, get, and set map items using the bracket syntax. Use `remove()`
to remove a key and its value from a map.

使用方括号语法添加、获取和设置 map 元素。
使用 `remove()` 从 map 中移除键及其值。

<?code-excerpt "misc/test/library_tour/core_test.dart (remove)"?>
```dart
var nobleGases = {54: 'xenon'};

// Retrieve a value with a key.
assert(nobleGases[54] == 'xenon');

// Check whether a map contains a key.
assert(nobleGases.containsKey(54));

// Remove a key and its value.
nobleGases.remove(54);
assert(!nobleGases.containsKey(54));
```

You can retrieve all the values or all the keys from a map:

你可以从 map 中获取所有的值或所有的键：

<?code-excerpt "misc/test/library_tour/core_test.dart (keys)"?>
```dart
var hawaiianBeaches = {
  'Oahu': ['Waikiki', 'Kailua', 'Waimanalo'],
  'Big Island': ['Wailea Bay', 'Pololu Beach'],
  'Kauai': ['Hanalei', 'Poipu'],
};

// Get all the keys as an unordered collection
// (an Iterable).
var keys = hawaiianBeaches.keys;

assert(keys.length == 3);
assert(keys.contains('Oahu'));

// Get all the values as an unordered collection
// (an Iterable of Lists).
var values = hawaiianBeaches.values;
assert(values.length == 3);
assert(values.any((v) => v.contains('Waikiki')));
```

To check whether a map contains a key, use `containsKey()`. Because map
values can be null, you cannot rely on simply getting the value for the
key and checking for null to determine the existence of a key.

要检查 map 是否包含某个键，请使用 `containsKey()`。
因为 map 的值可以是 null，
你不能只靠获取键对应的值并检查是否为 null
来判断键是否存在。

<?code-excerpt "misc/test/library_tour/core_test.dart (contains-key)"?>
```dart
var hawaiianBeaches = {
  'Oahu': ['Waikiki', 'Kailua', 'Waimanalo'],
  'Big Island': ['Wailea Bay', 'Pololu Beach'],
  'Kauai': ['Hanalei', 'Poipu'],
};

assert(hawaiianBeaches.containsKey('Oahu'));
assert(!hawaiianBeaches.containsKey('Florida'));
```

Use the `putIfAbsent()` method when you want to assign a value to a key
if and only if the key does not already exist in a map. You must provide
a function that returns the value.

当你想「当且仅当键在 map 中尚不存在时」
才给键赋值，请使用 `putIfAbsent()` 方法。
你必须提供一个返回该值的函数。

<?code-excerpt "misc/test/library_tour/core_test.dart (put-if-absent)"?>
```dart
var teamAssignments = <String, String>{};
teamAssignments.putIfAbsent('Catcher', () => pickToughestKid());
assert(teamAssignments['Catcher'] != null);
```

Refer to the [Map API reference][Map] for a full list of methods.

完整的方法列表请参阅 [Map API 参考][Map]。

### Common collection methods

### 常用集合方法

List, Set, and Map share common functionality found in many collections.
Some of this common functionality is defined by the Iterable class,
which List and Set implement.

List、Set 和 Map 共享许多集合都有的通用功能。
其中一些通用功能由 Iterable 类定义，
List 和 Set 都实现了它。

:::note
  Although Map doesn't implement Iterable, you can get Iterables from it using
  the Map `keys` and `values` properties.

  虽然 Map 没有实现 Iterable，
  但你可以用 Map 的 `keys` 和 `values` 属性
  从中获取 Iterable。
:::

Use `isEmpty` or `isNotEmpty` to check whether a list, set, or map has items:

使用 `isEmpty` 或 `isNotEmpty`
检查 list、set 或 map 是否有元素：

<?code-excerpt "misc/test/library_tour/core_test.dart (is-empty)"?>
```dart
var coffees = <String>[];
var teas = ['green', 'black', 'chamomile', 'earl grey'];
assert(coffees.isEmpty);
assert(teas.isNotEmpty);
```

To apply a function to each item in a list, set, or map, you can use
`forEach()`:

要对 list、set 或 map 中的每个元素应用一个函数，
可以使用 `forEach()`：

<?code-excerpt "misc/test/library_tour/core_test.dart (list-for-each)"?>
```dart
var teas = ['green', 'black', 'chamomile', 'earl grey'];

teas.forEach((tea) => print('I drink $tea'));
```

When you invoke `forEach()` on a map, your function must take two
arguments (the key and value):

在 map 上调用 `forEach()` 时，
你的函数必须接受两个参数（键和值）：

<?code-excerpt "misc/test/library_tour/core_test.dart (map-for-each)"?>
```dart
hawaiianBeaches.forEach((k, v) {
  print('I want to visit $k and swim at $v');
  // I want to visit Oahu and swim at
  // [Waikiki, Kailua, Waimanalo], etc.
});
```

Iterables provide the `map()` method, which gives you all the results in
a single object:

Iterable 提供 `map()` 方法，
它把所有结果放在单个对象中返回：

<?code-excerpt "misc/test/library_tour/core_test.dart (list-map)"?>
```dart
var teas = ['green', 'black', 'chamomile', 'earl grey'];

var loudTeas = teas.map((tea) => tea.toUpperCase());
loudTeas.forEach(print);
```

:::note
The object returned by `map()` is an Iterable that's *lazily evaluated*: your
function isn't called until you ask for an item from the returned object.

`map()` 返回的对象是一个 *惰性求值* 的 Iterable：
直到你向返回的对象请求元素时，
你的函数才会被调用。
:::

To force your function to be called immediately on each item, use
`map().toList()` or `map().toSet()`:

要强制你的函数立即对每个元素调用，
请使用 `map().toList()` 或 `map().toSet()`：

<?code-excerpt "misc/test/library_tour/core_test.dart (to-list)"?>
```dart
var loudTeas = teas.map((tea) => tea.toUpperCase()).toList();
```

Use Iterable's `where()` method to get all the items that match a
condition. Use Iterable's `any()` and `every()` methods to check whether
some or all items match a condition.

使用 Iterable 的 `where()` 方法
获取所有满足条件的元素。
使用 Iterable 的 `any()` 和 `every()` 方法
检查是否有部分或全部元素满足条件。
{% comment %}
PENDING: Change example as suggested by floitsch to have (maybe)
cities instead of isDecaffeinated.
{% endcomment %}


<?code-excerpt "misc/test/library_tour/core_test.dart (where-etc)"?>
```dart
var teas = ['green', 'black', 'chamomile', 'earl grey'];

// Chamomile is not caffeinated.
bool isDecaffeinated(String teaName) => teaName == 'chamomile';

// Use where() to find only the items that return true
// from the provided function.
var decaffeinatedTeas = teas.where((tea) => isDecaffeinated(tea));
// or teas.where(isDecaffeinated)

// Use any() to check whether at least one item in the
// collection satisfies a condition.
assert(teas.any(isDecaffeinated));

// Use every() to check whether all the items in a
// collection satisfy a condition.
assert(!teas.every(isDecaffeinated));
```

For a full list of methods, refer to the [Iterable API reference,][Iterable]
as well as those for [List,][List] [Set,][Set] and [Map.][Map]

完整的方法列表请参阅 [Iterable API 参考][Iterable]，
以及 [List][List]、[Set][Set] 和 [Map][Map] 的 API 参考。


## URIs

## URI

The [Uri class][Uri] provides
functions to encode and decode strings for use in URIs (which you might
know as *URLs*). These functions handle characters that are special for
URIs, such as `&` and `=`. The Uri class also parses and exposes the
components of a URI—host, port, scheme, and so on.

[Uri 类][Uri] 提供了对字符串进行编码和解码
以便在 URI（你可能更熟悉 *URL* 这个叫法）中使用的函数。
这些函数会处理对 URI 有特殊含义的字符，
例如 `&` 和 `=`。
Uri 类还会解析并暴露 URI 的各个组成部分——
主机、端口、scheme 等。
{% comment %}
{PENDING: show
constructors: Uri.http, Uri.https, Uri.file, per floitsch's suggestion}
{% endcomment %}

### Encoding and decoding fully qualified URIs

### 编码和解码完整 URI

To encode and decode characters *except* those with special meaning in a
URI (such as `/`, `:`, `&`, `#`), use the `encodeFull()` and
`decodeFull()` methods. These methods are good for encoding or decoding
a fully qualified URI, leaving intact special URI characters.

要编码和解码 *除* URI 中有特殊含义的字符
（如 `/`、`:`、`&`、`#`）之外的字符，
请使用 `encodeFull()` 和 `decodeFull()` 方法。
这些方法适合编码或解码完整的 URI，
同时保留特殊的 URI 字符不变。

<?code-excerpt "misc/test/library_tour/core_test.dart (encode-full)"?>
```dart
var uri = 'https://example.org/api?foo=some message';

var encoded = Uri.encodeFull(uri);
assert(encoded == 'https://example.org/api?foo=some%20message');

var decoded = Uri.decodeFull(encoded);
assert(uri == decoded);
```

Notice how only the space between `some` and `message` was encoded.

注意，只有 `some` 和 `message` 之间的空格被编码了。

### Encoding and decoding URI components

### 编码和解码 URI 组件

To encode and decode all of a string's characters that have special
meaning in a URI, including (but not limited to) `/`, `&`, and `:`, use
the `encodeComponent()` and `decodeComponent()` methods.

要编码和解码字符串中所有在 URI 里有特殊含义的字符，
包括（但不限于）`/`、`&` 和 `:`，
请使用 `encodeComponent()` 和 `decodeComponent()` 方法。

<?code-excerpt "misc/test/library_tour/core_test.dart (encode-component)"?>
```dart
var uri = 'https://example.org/api?foo=some message';

var encoded = Uri.encodeComponent(uri);
assert(
  encoded == 'https%3A%2F%2Fexample.org%2Fapi%3Ffoo%3Dsome%20message',
);

var decoded = Uri.decodeComponent(encoded);
assert(uri == decoded);
```

Notice how every special character is encoded. For example, `/` is
encoded to `%2F`.

注意，每个特殊字符都被编码了。
例如，`/` 被编码为 `%2F`。

### Parsing URIs

### 解析 URI

If you have a Uri object or a URI string, you can get its parts using
Uri fields such as `path`. To create a Uri from a string, use the
`parse()` static method:

如果你有一个 Uri 对象或 URI 字符串，
可以用 `path` 等 Uri 字段获取它的各个部分。
要从字符串创建 Uri，请使用 `parse()` 静态方法：

<?code-excerpt "misc/test/library_tour/core_test.dart (uri-parse)"?>
```dart
var uri = Uri.parse('https://example.org:8080/foo/bar#frag');

assert(uri.scheme == 'https');
assert(uri.host == 'example.org');
assert(uri.path == '/foo/bar');
assert(uri.fragment == 'frag');
assert(uri.origin == 'https://example.org:8080');
```

See the [Uri API reference][Uri] for more URI components that you can get.

更多可获取的 URI 组件，
请参阅 [Uri API 参考][Uri]。

### Building URIs

### 构建 URI

You can build up a URI from individual parts using the `Uri()`
constructor:

你可以用 `Uri()` 构造函数
从各个部分构建 URI：

<?code-excerpt "misc/test/library_tour/core_test.dart (uri)"?>
```dart
var uri = Uri(
  scheme: 'https',
  host: 'example.org',
  path: '/foo/bar',
  fragment: 'frag',
  queryParameters: {'lang': 'dart'},
);
assert(uri.toString() == 'https://example.org/foo/bar?lang=dart#frag');
```

If you don't need to specify a fragment,
to create a URI with a http or https scheme,
you can instead use the [`Uri.http`][] or [`Uri.https`][] factory constructors:

如果不需要指定 fragment，
要创建 http 或 https scheme 的 URI，
可以改用 [`Uri.http`][] 或 [`Uri.https`][] 工厂构造函数：

<?code-excerpt "misc/test/library_tour/core_test.dart (uri-http)"?>
```dart
var httpUri = Uri.http('example.org', '/foo/bar', {'lang': 'dart'});
var httpsUri = Uri.https('example.org', '/foo/bar', {'lang': 'dart'});

assert(httpUri.toString() == 'http://example.org/foo/bar?lang=dart');
assert(httpsUri.toString() == 'https://example.org/foo/bar?lang=dart');
```

[`Uri.http`]: {{site.dart-api}}/dart-core/Uri/Uri.http.html
[`Uri.https`]: {{site.dart-api}}/dart-core/Uri/Uri.https.html

## Dates and times

## 日期与时间

A DateTime object is a point in time. The time zone is either UTC or the
local time zone.

DateTime 对象表示一个时间点。
时区可以是 UTC 或本地时区。

You can create DateTime objects using several constructors and methods:

你可以用多个构造函数和方法创建 DateTime 对象：

<?code-excerpt "misc/test/library_tour/core_test.dart (date-time)"?>
```dart
// Get the current date and time.
var now = DateTime.now();

// Create a new DateTime with the local time zone.
var y2k = DateTime(2000); // January 1, 2000

// Specify the month and day.
y2k = DateTime(2000, 1, 2); // January 2, 2000

// Specify the date as a UTC time.
y2k = DateTime.utc(2000); // 1/1/2000, UTC

// Specify a date and time in ms since the Unix epoch.
y2k = DateTime.fromMillisecondsSinceEpoch(946684800000, isUtc: true);

// Parse an ISO 8601 date in the UTC time zone.
y2k = DateTime.parse('2000-01-01T00:00:00Z');

// Create a new DateTime from an existing one, adjusting just some properties:
var sameTimeLastYear = now.copyWith(year: now.year - 1);
```

:::warning
`DateTime` operations might give unexpected results related to
Daylight Savings Time and other non-standard time adjustments.  

`DateTime` 操作可能会因为夏令时
和其他非标准时间调整而产生意外结果。
:::

The `millisecondsSinceEpoch` property of a date returns the number of
milliseconds since the "Unix epoch"—January 1, 1970, UTC:

日期的 `millisecondsSinceEpoch` 属性
返回自「Unix 纪元」（1970 年 1 月 1 日，UTC）
以来的毫秒数：

<?code-excerpt "misc/test/library_tour/core_test.dart (milliseconds-since-epoch)"?>
```dart
// 1/1/2000, UTC
var y2k = DateTime.utc(2000);
assert(y2k.millisecondsSinceEpoch == 946684800000);

// 1/1/1970, UTC
var unixEpoch = DateTime.utc(1970);
assert(unixEpoch.millisecondsSinceEpoch == 0);
```

Use the Duration class to calculate the difference between two dates and
to shift a date forward or backward:

使用 Duration 类可以计算两个日期之间的差，
并把日期向前或向后移动：

<?code-excerpt "misc/test/library_tour/core_test.dart (duration)"?>
```dart
var y2k = DateTime.utc(2000);

// Add one year.
var y2001 = y2k.add(const Duration(days: 366));
assert(y2001.year == 2001);

// Subtract 30 days.
var december2000 = y2001.subtract(const Duration(days: 30));
assert(december2000.year == 2000);
assert(december2000.month == 12);

// Calculate the difference between two dates.
// Returns a Duration object.
var duration = y2001.difference(y2k);
assert(duration.inDays == 366); // y2k was a leap year.
```

:::warning
Using a `Duration` to shift a `DateTime` by days can be problematic, due to
clock shifts (to daylight saving time, for example).
Use UTC dates if you must shift days.

由于时钟调整（例如切换到夏令时），
用 `Duration` 按天移动 `DateTime` 可能有问题。
如果必须按天移动，请使用 UTC 日期。
:::

For a full list of methods,
refer to the API reference for [DateTime][] and [Duration.][Duration]

完整的方法列表请参阅
[DateTime][] 和 [Duration][Duration] 的 API 参考。


## Utility classes

## 工具类

The core library contains various utility classes, useful for sorting,
mapping values, and iterating.

核心库包含各种工具类，
可用于排序、映射值和迭代。

### Comparing objects

### 比较对象

Implement the [Comparable][]
interface to indicate that an object can be compared to another object,
usually for sorting. The `compareTo()` method returns \< 0 for
*smaller*, 0 for the *same*, and \> 0 for *bigger*.

实现 [Comparable][] 接口
表示一个对象可以与另一个对象比较，
通常用于排序。
`compareTo()` 方法对 *更小* 返回 \< 0，
对 *相同* 返回 0，对 *更大* 返回 \> 0。

<?code-excerpt "misc/lib/library_tour/core/comparable.dart"?>
```dart
class Line implements Comparable<Line> {
  final int length;
  const Line(this.length);

  @override
  int compareTo(Line other) => length - other.length;
}

void main() {
  var short = const Line(1);
  var long = const Line(100);
  assert(short.compareTo(long) < 0);
}
```

### Implementing map keys

### 实现 map 的键

Each object in Dart automatically provides an integer hash code, and
thus can be used as a key in a map. However, you can override the
`hashCode` getter to generate a custom hash code. If you do, you might
also want to override the `==` operator. Objects that are equal (via
`==`) must have identical hash codes. A hash code doesn't have to be
unique, but it should be well distributed.

Dart 中的每个对象都自动提供一个整数哈希码，
因此可以用作 map 的键。
不过，你可以重写 `hashCode` getter
来生成自定义哈希码。
如果这样做，你可能还想重写 `==` 运算符。
相等的对象（通过 `==` 判断）必须有相同的哈希码。
哈希码不必唯一，但应该分布均匀。

:::tip
To consistently and easily implement the `hashCode` getter,
consider using the static hashing methods provided by the `Object` class.

To generate a single hash code for multiple properties of an object,
you can use [`Object.hash()`][].
To generate a hash code for a collection,
you can use either [`Object.hashAll()`][] (if element order matters)
or [`Object.hashAllUnordered()`][].

要一致且轻松地实现 `hashCode` getter，
可以考虑使用 `Object` 类提供的静态哈希方法。

要为对象的多个属性生成单个哈希码，
可以使用 [`Object.hash()`][]。
要为集合生成哈希码，
可以使用 [`Object.hashAll()`][]（如果元素顺序重要）
或 [`Object.hashAllUnordered()`][]。
:::

[`Object.hash()`]: {{site.dart-api}}/dart-core/Object/hash.html
[`Object.hashAll()`]: {{site.dart-api}}/dart-core/Object/hashAll.html
[`Object.hashAllUnordered()`]: {{site.dart-api}}/dart-core/Object/hashAllUnordered.html

{% comment %}
Note: There's disagreement over whether to include identical() in the ==
implementation. It might improve speed, at least when you need to
compare many fields. They don't do identical() automatically because, by
convention, NaN != NaN.
{% endcomment %}

<?code-excerpt "misc/lib/library_tour/core/hash_code.dart"?>
```dart
class Person {
  final String firstName, lastName;

  Person(this.firstName, this.lastName);

  // Override hashCode using the static hashing methods
  // provided by the `Object` class.
  @override
  int get hashCode => Object.hash(firstName, lastName);

  // You should generally implement operator `==` if you
  // override `hashCode`.
  @override
  bool operator ==(Object other) {
    return other is Person &&
        other.firstName == firstName &&
        other.lastName == lastName;
  }
}

void main() {
  var p1 = Person('Bob', 'Smith');
  var p2 = Person('Bob', 'Smith');
  var p3 = 'not a person';
  assert(p1.hashCode == p2.hashCode);
  assert(p1 == p2);
  assert(p1 != p3);
}
```

### Iteration

### 迭代

The [Iterable][] and [Iterator][] classes
support sequential access to a collection of values.
To practice using these collections,
follow the [Iterable collections tutorial](/libraries/collections/iterables).

[Iterable][] 和 [Iterator][] 类
支持对一组值进行顺序访问。
要练习使用这些集合，
请跟随
[Iterable 集合教程](/libraries/collections/iterables)。

If you create a class that can provide Iterators for use in for-in loops,
extend (if possible) or implement Iterable.
Implement Iterator to define the actual iteration ability.

如果你创建的类要为 for-in 循环提供 Iterator，
请（在可能的情况下）继承或实现 Iterable。
实现 Iterator 来定义实际的迭代能力。

<?code-excerpt "misc/lib/library_tour/core/iterator.dart (structure)"?>
```dart
class Process {
  // Represents a process...
}

class ProcessIterator implements Iterator<Process> {
  @override
  Process get current => ...
  @override
  bool moveNext() => ...
}

// A mythical class that lets you iterate through all
// processes. Extends a subclass of [Iterable].
class Processes extends IterableBase<Process> {
  @override
  final Iterator<Process> iterator = ProcessIterator();
}

void main() {
  // Iterable objects can be used with for-in.
  for (final process in Processes()) {
    // Do something with the process.
  }
}
```

## Exceptions

## 异常

The Dart core library defines many common exceptions and errors.
Exceptions are considered conditions that you can plan ahead for and
catch. Errors are conditions that you don't expect or plan for.

Dart 核心库定义了许多常见的异常和错误。
异常被认为是你可以提前预料并捕获的情况，
错误则是你不期望也没有预料的情况。

A couple of the most common errors are:

两个最常见的错误是：

[NoSuchMethodError][]
: Thrown when a receiving object (which might be `null`) does not
  implement a method.

[NoSuchMethodError][]
: 当接收对象（可能是 `null`）
  没有实现某个方法时抛出。

[ArgumentError][]
: Can be thrown by a method that encounters an unexpected argument.

[ArgumentError][]
: 方法遇到意外实参时可能抛出。

Throwing an application-specific exception is a common way to indicate
that an error has occurred. You can define a custom exception by
implementing the Exception interface:

抛出应用特定的异常是表明发生错误的常见方式。
你可以通过实现 Exception 接口
来定义自定义异常：

<?code-excerpt "misc/lib/library_tour/core/exception.dart"?>
```dart
class FooException implements Exception {
  final String? msg;

  const FooException([this.msg]);

  @override
  String toString() => msg ?? 'FooException';
}
```

For more information, see
[Exceptions](/language/error-handling#exceptions)
(in the language tour) and the [Exception API reference.][Exception]

更多信息请参阅
[异常](/language/error-handling#exceptions)
（在语言之旅中）和 [Exception API 参考][Exception]。

## Weak references and finalizers

## 弱引用与 finalizer

Dart is a [garbage-collected][] language,
which means that any Dart object
that isn't referenced
can be disposed by the garbage collector.
This default behavior might not be desirable in
some scenarios involving native resources or
if the target object can't be modified.

Dart 是一门 [垃圾回收][garbage-collected] 语言，
意味着任何没有被引用的 Dart 对象
都可以被垃圾回收器回收。
在某些涉及原生资源的场景，
或目标对象无法修改的情况下，
这种默认行为可能并不理想。

A [WeakReference][]
stores a reference to the target object
that does not affect how it is
collected by the garbage collector.
Another option is to use an [Expando][]
to add properties to an object.

[WeakReference][] 保存对目标对象的引用，
但不影响垃圾回收器对它的回收。
另一个选择是使用 [Expando][]
为对象添加属性。

A [Finalizer][] can be used to execute a callback function
after an object is no longer referenced.
However, it is not guaranteed to execute this callback.

[Finalizer][] 可用于在对象不再被引用后
执行一个回调函数。
不过，它不保证一定会执行这个回调。

A [NativeFinalizer][]
provides stronger guarantees
for interacting with native code using [dart:ffi][];
its callback is invoked at least once
after the object is no longer referenced.
Also, it can be used to close native resources
such as a database connection or open files.

[NativeFinalizer][] 为使用 [dart:ffi][]
与原生代码交互提供了更强的保证；
在对象不再被引用后，
它的回调至少会被调用一次。
此外，它还可以用于关闭原生资源，
例如数据库连接或打开的文件。

To ensure that an object won't be
garbage collected and finalized too early,
classes can implement the [Finalizable][] interface.
When a local variable is Finalizable,
it won't be garbage collected
until the code block where it is declared has exited.

为确保对象不会过早被垃圾回收和 finalize，
类可以实现 [Finalizable][] 接口。
当局部变量是 Finalizable 时，
在声明它的代码块退出之前，
它不会被垃圾回收。

:::version-note
Support for weak references and finalizers was added in Dart 2.17.

弱引用和 finalizer 的支持从 Dart 2.17 开始加入。
:::


[ArgumentError]: {{site.dart-api}}/dart-core/ArgumentError-class.html
[Comparable]: {{site.dart-api}}/dart-core/Comparable-class.html
[DateTime]: {{site.dart-api}}/dart-core/DateTime-class.html
[Duration]: {{site.dart-api}}/dart-core/Duration-class.html
[Exception]: {{site.dart-api}}/dart-core/Exception-class.html
[Expando]: {{site.dart-api}}/dart-core/Expando-class.html
[Finalizable]: {{site.dart-api}}/dart-ffi/Finalizable-class.html
[Finalizer]: {{site.dart-api}}/dart-core/Finalizer-class.html
[Iterable]: {{site.dart-api}}/dart-core/Iterable-class.html
[Iterator]: {{site.dart-api}}/dart-core/Iterator-class.html
[List]: {{site.dart-api}}/dart-core/List-class.html
[Map]: {{site.dart-api}}/dart-core/Map-class.html
[Match]: {{site.dart-api}}/dart-core/Match-class.html
[NativeFinalizer]: {{site.dart-api}}/dart-ffi/NativeFinalizer-class.html
[NoSuchMethodError]: {{site.dart-api}}/dart-core/NoSuchMethodError-class.html
[Pattern]: {{site.dart-api}}/dart-core/Pattern-class.html
[RegExp]: {{site.dart-api}}/dart-core/RegExp-class.html
[Set]: {{site.dart-api}}/dart-core/Set-class.html
[StringBuffer]: {{site.dart-api}}/dart-core/StringBuffer-class.html
[String]: {{site.dart-api}}/dart-core/String-class.html
[Uri]: {{site.dart-api}}/dart-core/Uri-class.html
[WeakReference]: {{site.dart-api}}/dart-core/WeakReference-class.html
[dart:core]: {{site.dart-api}}/dart-core/dart-core-library.html
[dart:ffi]: /interop/c-interop
[double]: {{site.dart-api}}/dart-core/double-class.html
[garbage-collected]: {{site.flutter-blog}}/flutter-dont-fear-the-garbage-collector
[int]: {{site.dart-api}}/dart-core/int-class.html
[num]: {{site.dart-api}}/dart-core/num-class.html
[toStringAsFixed()]: {{site.dart-api}}/dart-core/num/toStringAsFixed.html
[toStringAsPrecision()]: {{site.dart-api}}/dart-core/num/toStringAsPrecision.html
