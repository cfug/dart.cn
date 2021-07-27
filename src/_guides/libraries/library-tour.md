---
title: A tour of the core libraries
title: Dart 语言核心库一览
description: Learn about the major features in Dart's libraries.
description: 学习更多关于 Dart 语言核心库的特性。
short-title: Library tour
---
<?code-excerpt replace="/ *\/\/\s+ignore_for_file:[^\n]+\n//g; /\n? *\/\/\s+ignore:[^\n]+//g"?>
<?code-excerpt plaster="none"?>

This page shows you how to use the major features in Dart’s core libraries.
It’s just an overview, and by no means comprehensive.
Whenever you need more details about a class,
consult the [Dart API reference.][Dart API]

本页介绍如何使用 Dart 核心库中的主要功能。这只是一个概览，并不全面。
当你需要有关类的更多详细信息时，请参阅[Dart API 参考][Dart API]。

[dart:core](#dartcore---numbers-collections-strings-and-more)
<br> Built-in types, collections, and other core functionality.
  This library is automatically imported into every Dart program.

[dart:core](#dartcore---numbers-collections-strings-and-more)
<br> 内置类型，集合和其他核心功能。
  该库会被自动导入到所有的 Dart 程序。

[dart:async](#dartasync---asynchronous-programming)
<br> Support for asynchronous programming, with classes such as Future and Stream.

[dart:async](#dartasync---asynchronous-programming)
<br> 支持异步编程，包括Future和Stream等类。

[dart:math](#dartmath---math-and-random)
<br> Mathematical constants and functions, plus a random number generator.

[dart:math](#dartmath---math-and-random)
<br> 数学常数和函数，以及随机数生成器。

[dart:convert](#dartconvert---decoding-and-encoding-json-utf-8-and-more)
<br> Encoders and decoders for converting between different data representations, including JSON and UTF-8.

[dart:convert](#dartconvert---decoding-and-encoding-json-utf-8-and-more)
<br> 用于在不同数据表示之间进行转换的编码器和解码器，包括 JSON 和 UTF-8。

[dart:html](#darthtml)
<br> DOM and other APIs for browser-based apps.

[dart:html](#darthtml)
<br> 用于基于浏览器应用的 DOM 和其他 API。

[dart:io](#dartio)
<br> I/O for programs that can use the Dart VM,
  including Flutter apps, servers, and command-line scripts.

[dart:io](#dartio)
<br> 服务器和命令行应用程序的 I/O 操作，
  包括 Flutter 应用，服务端应用，以及命令行脚本。

This page is just an overview;
it covers only a few dart:* libraries
and no third-party libraries.

本章只是一个概述；
只涵盖了几个 dart:* 库，
不包括第三方库。

Other places to find library information are the
[pub.dev site]({{site.pub}}) and the
[Dart web developer library guide][webdev libraries].
You can find API documentation for all dart:* libraries in the
[Dart API reference][Dart API] or, if you're using Flutter,
the [Flutter API reference.][docs.flutter]

更多库信息可以在
[Pub site][pub.dartlang] 和
[Dart web developer library guide.][webdev libraries] 查找。
所有 dart:* 库的 API 文档可以在
[Dart API reference][Dart API] 查找， 如果使用的是 Flutter
可以在 [Flutter API reference.][docs.flutter] 查找。

{{site.alert.info}}

  **DartPad tip:** You can play with the code in this page by copying it into a
  [DartPad.]({{site.dartpad}})

  **DartPad tip：** 可以通过将该页中的代码拷贝到 [DartPad]({{site.dartpad}}) 中进行演示。

{{site.alert.end}}


## dart:core - numbers, collections, strings, and more

## dart:core - 数字，集合，字符串等

The dart:core library ([API reference][dart:core])
provides a small but critical set of built-in functionality.
This library is automatically imported into every Dart program.

dart:core 库 ([API reference][dart:core])
提供了一个少量但是重要的内置功能集合。
该库会被自动导入每个 Dart 程序。


### Printing to the console

### 控制台打印

The top-level `print()` method takes a single argument (any Object)
and displays that object's string value (as returned by `toString()`)
in the console.

顶级 `print()` 方法接受一个参数 任意对象）
并输出显示这个对象的字符串值(由 `toString()` 返回)
到控制台。

<?code-excerpt "misc/test/library_tour/core_test.dart (print)"?>
```dart
print(anObject);
print('I drink $tea.');
```

For more information on basic strings and `toString()`, see
[Strings](/guides/language/language-tour#strings) in the language tour.

有关基本字符串和 `toString()` 的更多信息，参考
[Strings](/guides/language/language-tour#strings) in the language tour.


### Numbers

### 数字

The dart:core library defines the num, int, and double classes, which
have some basic utilities for working with numbers.

dart:core 库定义了 num ，int 以及 double 类，
这些类拥有一定的工具方法来处理数字。

You can convert a string into an integer or double with the `parse()`
methods of int and double, respectively:

使用 int 和 double 的 `parse()` 方法将字符串转换为整型或双浮点型对象：

<?code-excerpt "misc/test/library_tour/core_test.dart (int|double.parse)"?>
```dart
assert(int.parse('42') == 42);
assert(int.parse('0x42') == 66);
assert(double.parse('0.50') == 0.5);
```

Or use the parse() method of num, which creates an integer if possible
and otherwise a double:

或者使用 num 的 parse() 方法，该方法可能会创建一个整型，否则为浮点型对象：

<?code-excerpt "misc/test/library_tour/core_test.dart (num-parse)"?>
```dart
assert(num.parse('42') is int);
assert(num.parse('0x42') is int);
assert(num.parse('0.50') is double);
```

To specify the base of an integer, add a `radix` parameter:

通过添加 `radix` 参数，指定整数的进制基数：

<?code-excerpt "misc/test/library_tour/core_test.dart (radix)"?>
```dart
assert(int.parse('42', radix: 16) == 66);
```

Use the `toString()` method to convert an
int or double to a string. To specify the number of digits to the right
of the decimal, use [toStringAsFixed().][toStringAsFixed()] To specify the
number of significant digits in the string, use
[toStringAsPrecision():][toStringAsPrecision()]

使用 `toString()` 方法将整型或双精度浮点类型转换为字符串类型。
使用 [toStringAsFixed().][toStringAsFixed()] 指定小数点右边的位数，
使用 [toStringAsPrecision():][toStringAsPrecision()] 指定字符串中的有效数字的位数。

<?code-excerpt "misc/test/library_tour/core_test.dart (toString())"?>
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
the [dart:math section](#dartmath---math-and-random).


### Strings and regular expressions

### 字符和正则表达式

A string in Dart is an immutable sequence of UTF-16 code units.
The language tour has more information about
[strings](/guides/language/language-tour#strings).
You can use regular expressions (RegExp objects)
to search within strings and to
replace parts of strings.

在 Dart 中一个字符串是一个固定不变的 UTF-16 编码单元序列。
语言概览中有更多关于 [strings](/guides/language/language-tour#strings) 的内容。
使用正则表达式 (RegExp 对象) 可以在字符串内搜索和替换部分字符串。


The String class defines such methods as `split()`, `contains()`,
`startsWith()`, `endsWith()`, and more.

String 定义了例如 `split()`， `contains()`，
`startsWith()`， `endsWith()` 等方法。

#### Searching inside a string

#### 在字符串中搜索

You can find particular locations within a string, as well as check
whether a string begins with or ends with a particular pattern. For
example:

可以在字符串内查找特定字符串的位置，
以及检查字符串是否以特定字符串作为开头或结尾。例如：

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

#### Extracting data from a string

#### 从字符串中提取数据

You can get the individual characters from a string as Strings or ints,
respectively. To be precise, you actually get individual UTF-16 code
units; high-numbered characters such as the treble clef symbol
('\\u{1D11E}') are two code units apiece.

可以获取字符串中的单个字符，将其作为字符串或者整数。
确切地说，实际上获取的是单独的UTF-16编码单元;
诸如高音谱号符号 ('\\u{1D11E}') 之类的高编号字符分别为两个编码单元。

You can also extract a substring or split a string into a list of
substrings:

你也可以获取字符串中的子字符串或者将一个字符串分割为子字符串列表：

<?code-excerpt "misc/test/library_tour/core_test.dart (substring-etc)"?>
```dart
// Grab a substring.
assert('Never odd or even'.substring(6, 9) == 'odd');

// Split a string using a string pattern.
var parts = 'structured web apps'.split(' ');
assert(parts.length == 3);
assert(parts[0] == 'structured');

// Get a UTF-16 code unit (as a string) by index.
assert('Never odd or even'[0] == 'N');

// Use split() with an empty string parameter to get
// a list of all characters (as Strings); good for
// iterating.
for (var char in 'hello'.split('')) {
  print(char);
}

// Get all the UTF-16 code units in the string.
var codeUnitList =
    'Never odd or even'.codeUnits.toList();
assert(codeUnitList[0] == 78);
```

{{site.alert.note}}

  In many cases, you want to work with
  Unicode grapheme clusters
  as opposed to pure code units.
  These are characters as they are perceived
  by the user (for example, "🇬🇧" is one
  user-perceived character but several
  UTF-16 code units).
  For this, the Dart team provides the
  [`characters` package.]({{site.pub-pkg}}/characters)

在一些情况下，你可能会希望使用「显性」 Unicode 字符，而不是用纯代码表示。
这种字符是用户可感知的，比如 "🇨🇳"，就是一个用户可感知的字符 (emoji)，而它其实也是一个 UTF-16 的字符 (`U+1F1E8 U+1F1F3`)。
为此，Dart 团队提供了 [`characters` 这个 package.]({{site.pub-pkg}}/characters) 供开发者使用。

{{site.alert.end}}

#### Converting to uppercase or lowercase

#### 首字母大小写转换

You can easily convert strings to their uppercase and lowercase
variants:

可以轻松的对字符串的首字母大小写进行转换：

<?code-excerpt "misc/test/library_tour/core_test.dart (toUpperCase-toLowerCase)"?>
```dart
// Convert to uppercase.
assert('structured web apps'.toUpperCase() ==
    'STRUCTURED WEB APPS');

// Convert to lowercase.
assert('STRUCTURED WEB APPS'.toLowerCase() ==
    'structured web apps');
```

{{site.alert.note}}

  These methods don't work for every language. For example, the Turkish
  alphabet's dotless *I* is converted incorrectly.

  这些方法不是在所有语言上都有效的。例如，土耳其字母表的无点 *I* 转换是不正确的。

{{site.alert.end}}


#### Trimming and empty strings

#### Trimming 和空字符串

Remove all leading and trailing white space with `trim()`. To check
whether a string is empty (length is zero), use `isEmpty`.

使用 `trim()` 移除首尾空格。
使用 `isEmpty` 检查一个字符串是否为空（长度为 0）。

<?code-excerpt "misc/test/library_tour/core_test.dart (trim-etc)"?>
```dart
// Trim a string.
assert('  hello  '.trim() == 'hello');

// Check whether a string is empty.
assert(''.isEmpty);

// Strings with only white space are not empty.
assert('  '.isNotEmpty);
```

#### Replacing part of a string

#### 替换部分字符串

Strings are immutable objects, which means you can create them but you
can’t change them. If you look closely at the [String API reference,][String]
you’ll notice that
none of the methods actually changes the state of a String. For example,
the method `replaceAll()` returns a new String without changing the
original String:

字符串是不可变的对象，也就是说字符串可以创建但是不能被修改。
如果仔细阅读了 [String API docs,][String]
你会注意到，没有一个方法实际的改变了字符串的状态。
例如，方法 `replaceAll()` 返回一个新字符串，
并没有改变原始字符串：

<?code-excerpt "misc/test/library_tour/core_test.dart (replace)"?>
```dart
var greetingTemplate = 'Hello, NAME!';
var greeting =
    greetingTemplate.replaceAll(RegExp('NAME'), 'Bob');

// greetingTemplate didn't change.
assert(greeting != greetingTemplate);
```

#### Building a string

#### 构建一个字符串

To programmatically generate a string, you can use StringBuffer. A
StringBuffer doesn’t generate a new String object until `toString()` is
called. The `writeAll()` method has an optional second parameter that
lets you specify a separator—in this case, a space.

要以代码方式生成字符串，可以使用 StringBuffer 。
在调用 `toString()` 之前， StringBuffer 不会生成新字符串对象。
`writeAll()` 的第二个参数为可选参数，用来指定分隔符，
本例中使用空格作为分隔符。

<?code-excerpt "misc/test/library_tour/core_test.dart (StringBuffer)"?>
```dart
var sb = StringBuffer();
sb
  ..write('Use a StringBuffer for ')
  ..writeAll(['efficient', 'string', 'creation'], ' ')
  ..write('.');

var fullString = sb.toString();

assert(fullString ==
    'Use a StringBuffer for efficient string creation.');
```

#### Regular expressions

#### 正则表达式

The RegExp class provides the same capabilities as JavaScript regular
expressions. Use regular expressions for efficient searching and pattern
matching of strings.

RegExp 类提供与 JavaScript 正则表达式相同的功能。
使用正则表达式可以对字符串进行高效搜索和模式匹配。

<?code-excerpt "misc/test/library_tour/core_test.dart (RegExp)"?>
```dart
// Here's a regular expression for one or more digits.
var numbers = RegExp(r'\d+');

var allCharacters = 'llamas live fifteen to twenty years';
var someDigits = 'llamas live 15 to 20 years';

// contains() can use a regular expression.
assert(!allCharacters.contains(numbers));
assert(someDigits.contains(numbers));

// Replace every match with another string.
var exedOut = someDigits.replaceAll(numbers, 'XX');
assert(exedOut == 'llamas live XX to XX years');
```

You can work directly with the RegExp class, too. The Match class
provides access to a regular expression match.

<?code-excerpt "misc/test/library_tour/core_test.dart (match)"?>
```dart
var numbers = RegExp(r'\d+');
var someDigits = 'llamas live 15 to 20 years';

// Check whether the reg exp has a match in a string.
assert(numbers.hasMatch(someDigits));

// Loop through all matches.
for (var match in numbers.allMatches(someDigits)) {
  print(match.group(0)); // 15, then 20
}
```

#### More information

#### 更多信息

Refer to the [String API reference][String] for a full list of
methods. Also see the API reference for [StringBuffer,][StringBuffer]
[Pattern,][Pattern] [RegExp,][RegExp] and [Match.][Match]

有关完整的方法列表，
请参考 [String API docs][String]。
另请参考 [StringBuffer，][StringBuffer]
[Pattern，][Pattern] [RegExp，][RegExp] 和 [Match][Match]
的 API 文档。

### Collections

### 集合

Dart ships with a core collections API, which includes classes for
lists, sets, and maps.

Dart 附带了核心集合 API ，其中包括 list、set 和 map 类。

{{site.alert.tip}}
  
  To practice using APIs that are available to both lists and sets,
  follow the [Iterable collections codelab](/codelabs/iterables).
  
  如果你需要尝试一下对列表 (list) 和集合 (set) 都可用的 API，
  请试试看 [遍历集合](/codelabs/iterables) 这个 codelab 教程。
  
{{site.alert.end}}

#### Lists

As the language tour shows, you can use literals to create and
initialize [lists](#lists). Alternatively, use one of the List
constructors. The List class also defines several methods for adding
items to and removing items from lists.

如语言概览中介绍，[lists](#lists) 可以通过字面量来创建和初始化。
另外，也可以使用 List 的构造函数。
List 类还定义了若干方法，用于向列表添加或删除项目。

<?code-excerpt "misc/test/library_tour/core_test.dart (List)"?>
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

使用 `indexOf()` 方法查找一个对象在 list 中的下标值。

<?code-excerpt "misc/test/library_tour/core_test.dart (indexOf)"?>
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

使用 `sort()` 方法排序一个 list 。
你可以提供一个排序函数用于比较两个对象。
比较函数在 *小于* 时返回 \ <0，*相等* 时返回 0，*bigger* 时返回 \> 0 。
下面示例中使用 `compareTo()` 函数，
该函数在 [Comparable][] 中定义，
并被 String 类实现。

<?code-excerpt "misc/test/library_tour/core_test.dart (compareTo)"?>
```dart
var fruits = ['bananas', 'apples', 'oranges'];

// Sort a list.
fruits.sort((a, b) => a.compareTo(b));
assert(fruits[0] == 'apples');
```

Lists are parameterized types
([generics](/guides/language/language-tour#generics)),
so you can specify the type that a list
should contain:

列表是参数化类型（[泛型](/guides/language/language-tour#generics)），
因此可以指定 list 应该包含的元素类型：

<?code-excerpt "misc/test/library_tour/core_test.dart (List-of-String)"?>
```dart
// This list should contain only strings.
var fruits = <String>[];

fruits.add('apples');
var fruit = fruits[0];
assert(fruit is String);
```

{:.fails-sa}
<?code-excerpt "misc/lib/library_tour/core/collections.dart (List-of-String)"?>
```dart
fruits.add(5); // Error: 'int' can't be assigned to 'String'
```

{{site.alert.note}}

  In many cases, you don't
  need to explicitly specify generic
  types, because Dart will
  [infer](/guides/language/type-system#type-inference)
  them for you.
  A list like `['Dash', 'Dart']` is understood
  to be a `List<String>` (read: list of strings).

  在大多数情况下，你不需要显式指定泛型，因为 Dart 帮你会
  [推断](/guides/language/type-system#type-inference)
  它们的类型。
  类似于 `['Dash', 'Dart']` 这样的 list 很容易可以推断为 `List<String>`。

  But there are times when you _should_ specify
  the generic type. Like, for example, when Dart doesn't have
  anything to infer from: `[]` could be a list of any
  combination of things.
  That's often not what you want, so you write `<String>[]`
  or `<Person>[]` or something similar.

  但有些时候你 **需要** 指定泛型。
  比如：Dart 无法从 `[]` 中推断出任何类型，它可以是任何类型元素的组合。
  这时推断的类型基本不会是你想要的，所以你需要写下
  `<String>[]` 或者 `<Person>[]` 这样的类型声明。

{{site.alert.end}}

Refer to the [List API reference][List] for a full list of methods.

全部的方法介绍 ，请参考 [List API docs][List]。

#### Sets

A set in Dart is an unordered collection of unique items. Because a set
is unordered, you can’t get a set’s items by index (position).

在 Dart 中，set 是一个无序的，元素唯一的集合。
因为一个 set 是无序的，所以无法通过下标（位置）获取 set 中的元素。

<?code-excerpt "misc/test/library_tour/core_test.dart (Set)"?>
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

使用 `contains()` 和 `containsAll()` 来检查一个或多个元素是否在 set 中：

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

交集是另外两个 set 中的公共元素组成的 set。

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

全部的方法介绍 ，请参考 [Set API docs][Set]。

#### Maps

A map, commonly known as a *dictionary* or *hash*, is an unordered
collection of key-value pairs. Maps associate a key to some value for
easy retrieval. Unlike in JavaScript, Dart objects are not maps.

map 是一个无序的 key-value （键值对）集合，就是大家熟知的 *dictionary* 或者 *hash*。
map 将 kay 与 value 关联，以便于检索。和 JavaScript 不同，Dart 对象不是 map。

You can declare a map using a terse literal syntax, or you can use a
traditional constructor:

声明 map 可以使用简洁的字面量语法，也可以使用传统构造函数：

<?code-excerpt "misc/test/library_tour/core_test.dart (Map)"?>
```dart
// Maps often use strings as keys.
var hawaiianBeaches = {
  'Oahu': ['Waikiki', 'Kailua', 'Waimanalo'],
  'Big Island': ['Wailea Bay', 'Pololu Beach'],
  'Kauai': ['Hanalei', 'Poipu']
};

// Maps can be built from a constructor.
var searchTerms = Map();

// Maps are parameterized types; you can specify what
// types the key and value should be.
var nobleGases = Map<int, String>();
```

You add, get, and set map items using the bracket syntax. Use `remove()`
to remove a key and its value from a map.

通过大括号语法可以为 map 添加，获取，设置元素。
使用 `remove()` 方法从 map 中移除键值对。

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

可以从一个 map 中检索出所有的 key 或所有的 value：

<?code-excerpt "misc/test/library_tour/core_test.dart (keys)"?>
```dart
var hawaiianBeaches = {
  'Oahu': ['Waikiki', 'Kailua', 'Waimanalo'],
  'Big Island': ['Wailea Bay', 'Pololu Beach'],
  'Kauai': ['Hanalei', 'Poipu']
};

// Get all the keys as an unordered collection
// (an Iterable).
var keys = hawaiianBeaches.keys;

assert(keys.length == 3);
assert(Set.from(keys).contains('Oahu'));

// Get all the values as an unordered collection
// (an Iterable of Lists).
var values = hawaiianBeaches.values;
assert(values.length == 3);
assert(values.any((v) => v.contains('Waikiki')));
```

To check whether a map contains a key, use `containsKey()`. Because map
values can be null, you cannot rely on simply getting the value for the
key and checking for null to determine the existence of a key.

使用 `containsKey()` 方法检查一个 map 中是否包含某个key 。
因为 map 中的 value 可能会是 null ，
所有通过 key 获取 value，并通过判断 value 是否为 null 来判断 key 是否存在是不可靠的。

<?code-excerpt "misc/test/library_tour/core_test.dart (containsKey)"?>
```dart
var hawaiianBeaches = {
  'Oahu': ['Waikiki', 'Kailua', 'Waimanalo'],
  'Big Island': ['Wailea Bay', 'Pololu Beach'],
  'Kauai': ['Hanalei', 'Poipu']
};

assert(hawaiianBeaches.containsKey('Oahu'));
assert(!hawaiianBeaches.containsKey('Florida'));
```

Use the `putIfAbsent()` method when you want to assign a value to a key
if and only if the key does not already exist in a map. You must provide
a function that returns the value.

如果当且仅当该 key 不存在于 map 中，且要为这个 key 赋值，
可使用`putIfAbsent（）`方法。
该方法需要一个方法返回这个 value。

<?code-excerpt "misc/test/library_tour/core_test.dart (putIfAbsent)"?>
```dart
var teamAssignments = <String, String>{};
teamAssignments.putIfAbsent(
    'Catcher', () => pickToughestKid());
assert(teamAssignments['Catcher'] != null);
```

Refer to the [Map API reference][Map] for a full list of methods.

全部的方法介绍 ，请参考 [Map API docs][Map]。

#### Common collection methods

#### 公共集合方法

List, Set, and Map share common functionality found in many collections.
Some of this common functionality is defined by the Iterable class,
which List and Set implement.

List, Set, 和 Map 共享许多集合中的常用功能。
其中一些常见功能由 Iterable 类定义，
这些函数由 List 和 Set 实现。

{{site.alert.note}}

  Although Map doesn’t implement Iterable, you can get Iterables from it using
  the Map `keys` and `values` properties.

  虽然Map没有实现 Iterable，但可以使用 Map `keys` 和 `values` 属性从中获取 Iterable 对象。

{{site.alert.end}}

Use `isEmpty` or `isNotEmpty` to check whether a list, set, or map has items:

使用 `isEmpty` 和 `isNotEmpty` 方法可以检查 list， set 或 map 对象中是否包含元素：

<?code-excerpt "misc/test/library_tour/core_test.dart (isEmpty)"?>
```dart
var coffees = <String>[];
var teas = ['green', 'black', 'chamomile', 'earl grey'];
assert(coffees.isEmpty);
assert(teas.isNotEmpty);
```

To apply a function to each item in a list, set, or map, you can use
`forEach()`:

使用 `forEach()` 可以让 list， set 或 map 对象中的每个元素都使用一个方法。

<?code-excerpt "misc/test/library_tour/core_test.dart (List.forEach)"?>
```dart
var teas = ['green', 'black', 'chamomile', 'earl grey'];

teas.forEach((tea) => print('I drink $tea'));
```

When you invoke `forEach()` on a map, your function must take two
arguments (the key and value):

当在 map 对象上调用 `forEach() 方法时，函数必须带两个参数（key 和 value）：

<?code-excerpt "misc/test/library_tour/core_test.dart (Map.forEach)"?>
```dart
hawaiianBeaches.forEach((k, v) {
  print('I want to visit $k and swim at $v');
  // I want to visit Oahu and swim at
  // [Waikiki, Kailua, Waimanalo], etc.
});
```

Iterables provide the `map()` method, which gives you all the results in
a single object:

Iterable 提供 `map()` 方法，这个方法将所有结果返回到一个对象中。

<?code-excerpt "misc/test/library_tour/core_test.dart (List.map)"?>
```dart
var teas = ['green', 'black', 'chamomile', 'earl grey'];

var loudTeas = teas.map((tea) => tea.toUpperCase());
loudTeas.forEach(print);
```

{{site.alert.note}}

  The object returned by `map()` is an Iterable that’s *lazily evaluated*: your
  function isn’t called until you ask for an item from the returned object.

  `map()` 方法返回的对象是一个 *懒求值（lazily evaluated）*对象：
  只有当访问对象里面的元素时，函数才会被调用。

{{site.alert.end}}

To force your function to be called immediately on each item, use
`map().toList()` or `map().toSet()`:

使用 `map().toList()` 或 `map().toSet()` ，
可以强制在每个项目上立即调用函数。

<?code-excerpt "misc/test/library_tour/core_test.dart (toList)"?>
```dart
var loudTeas =
    teas.map((tea) => tea.toUpperCase()).toList();
```

Use Iterable’s `where()` method to get all the items that match a
condition. Use Iterable’s `any()` and `every()` methods to check whether
some or all items match a condition.

使用 Iterable 的 `where()` 方法可以获取所有匹配条件的元素。
使用 Iterable 的 `any()` 和 `every()`
方法可以检查部分或者所有元素是否匹配某个条件。

{% comment %}
PENDING: Change example as suggested by floitsch to have (maybe)
cities instead of isDecaffeinated.
{% endcomment %}


<?code-excerpt "misc/test/library_tour/core_test.dart (where-etc)"?>
```dart
var teas = ['green', 'black', 'chamomile', 'earl grey'];

// Chamomile is not caffeinated.
bool isDecaffeinated(String teaName) =>
    teaName == 'chamomile';

// Use where() to find only the items that return true
// from the provided function.
var decaffeinatedTeas =
    teas.where((tea) => isDecaffeinated(tea));
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

有关方法的完整列表，请参考 [Iterable API docs,][Iterable] 以及
[List,][List] [Set,][Set] and [Map.][Map]

### URIs

The [Uri class][Uri] provides
functions to encode and decode strings for use in URIs (which you might
know as *URLs*). These functions handle characters that are special for
URIs, such as `&` and `=`. The Uri class also parses and exposes the
components of a URI—host, port, scheme, and so on.

在使用 URI（可能你会称它为 *URLs*） 时，[Uri 类][Uri] 提供对字符串的编解码操作。
这些函数用来处理 URI 特有的字符，例如 `＆` 和 `=` 。
Uri 类还可以解析和处理 URI—host，port，scheme等组件。

{% comment %}
{PENDING: show
constructors: Uri.http, Uri.https, Uri.file, per floitsch's suggestion}
{% endcomment %}

#### Encoding and decoding fully qualified URIs

#### 编码和解码完整合法的URI

To encode and decode characters *except* those with special meaning in a
URI (such as `/`, `:`, `&`, `#`), use the `encodeFull()` and
`decodeFull()` methods. These methods are good for encoding or decoding
a fully qualified URI, leaving intact special URI characters.

使用 `encodeFull()` 和 `decodeFull()` 方法，
对 URI 中除了特殊字符（例如 `/`， `:`， `&`， `#`）以外的字符进行编解码，
这些方法非常适合编解码完整合法的 URI，并保留 URI 中的特殊字符。

<?code-excerpt "misc/test/library_tour/core_test.dart (encodeFull)"?>
```dart
var uri = 'https://example.org/api?foo=some message';

var encoded = Uri.encodeFull(uri);
assert(encoded ==
    'https://example.org/api?foo=some%20message');

var decoded = Uri.decodeFull(encoded);
assert(uri == decoded);
```

Notice how only the space between `some` and `message` was encoded.

注意上面代码只编码了 `some` 和 `message` 之间的空格。

#### Encoding and decoding URI components

#### 编码和解码 URI 组件

To encode and decode all of a string’s characters that have special
meaning in a URI, including (but not limited to) `/`, `&`, and `:`, use
the `encodeComponent()` and `decodeComponent()` methods.

使用 `encodeComponent()` 和 `decodeComponent()` 方法，
对 URI 中具有特殊含义的所有字符串字符，
特殊字符包括（但不限于）`/`， `&`， 和  `:`。

<?code-excerpt "misc/test/library_tour/core_test.dart (encodeComponent)"?>
```dart
var uri = 'https://example.org/api?foo=some message';

var encoded = Uri.encodeComponent(uri);
assert(encoded ==
    'https%3A%2F%2Fexample.org%2Fapi%3Ffoo%3Dsome%20message');

var decoded = Uri.decodeComponent(encoded);
assert(uri == decoded);
```

Notice how every special character is encoded. For example, `/` is
encoded to `%2F`.

注意上面代码编码了所有的字符。例如 `/` 被编码为 `%2F`。

#### Parsing URIs

#### 解析 URI

If you have a Uri object or a URI string, you can get its parts using
Uri fields such as `path`. To create a Uri from a string, use the
`parse()` static method:

使用 Uri 对象的字段（例如 `path`），
来获取一个 Uri 对象或者 URI 字符串的一部分。
使用 `parse()` 静态方法，可以使用字符串创建 Uri 对象。

<?code-excerpt "misc/test/library_tour/core_test.dart (Uri.parse)"?>
```dart
var uri =
    Uri.parse('https://example.org:8080/foo/bar#frag');

assert(uri.scheme == 'https');
assert(uri.host == 'example.org');
assert(uri.path == '/foo/bar');
assert(uri.fragment == 'frag');
assert(uri.origin == 'https://example.org:8080');
```

See the [Uri API reference][Uri] for more URI components that you can get.

有关 URI 组件的更多内容，参考 [Uri API docs][Uri]。

#### Building URIs

#### 构建 URI

You can build up a URI from individual parts using the `Uri()`
constructor:

使用 `Uri()` 构造函数，可以将各组件部分构建成 URI 。

<?code-excerpt "misc/test/library_tour/core_test.dart (Uri)"?>
```dart
var uri = Uri(
    scheme: 'https',
    host: 'example.org',
    path: '/foo/bar',
    fragment: 'frag');
assert(
    uri.toString() == 'https://example.org/foo/bar#frag');
```


### Dates and times

### 日期和时间

A DateTime object is a point in time. The time zone is either UTC or the
local time zone.

DateTime 对象代表某个时刻，时区可以是 UTC 或者 本地时区。

You can create DateTime objects using several constructors:

DateTime 对象可以通过若干构造函数创建：

<?code-excerpt "misc/test/library_tour/core_test.dart (DateTime)"?>
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
y2k = DateTime.fromMillisecondsSinceEpoch(946684800000,
    isUtc: true);

// Parse an ISO 8601 date.
y2k = DateTime.parse('2000-01-01T00:00:00Z');
```

The `millisecondsSinceEpoch` property of a date returns the number of
milliseconds since the “Unix epoch”—January 1, 1970, UTC:

日期中 `millisecondsSinceEpoch` 属性返回自
“Unix 纪元（January 1, 1970, UTC）”以来的毫秒数：

<?code-excerpt "misc/test/library_tour/core_test.dart (millisecondsSinceEpoch)"?>
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

<?code-excerpt "misc/test/library_tour/core_test.dart (Duration)"?>
```dart
var y2k = DateTime.utc(2000);

// Add one year.
var y2001 = y2k.add(const Duration(days: 366));
assert(y2001.year == 2001);

// Subtract 30 days.
var december2000 =
    y2001.subtract(const Duration(days: 30));
assert(december2000.year == 2000);
assert(december2000.month == 12);

// Calculate the difference between two dates.
// Returns a Duration object.
var duration = y2001.difference(y2k);
assert(duration.inDays == 366); // y2k was a leap year.
```

{{site.alert.warning}}

  Using a Duration to shift a DateTime by days can be problematic, due to clock
  shifts (to daylight saving time, for example). Use UTC dates if you must shift
  days.

  由于时钟转换（例如，夏令时）的原因，
  使用 Duration 对 DateTime 按天移动可能会有问题。
  如果要按照天数来位移时间，请使用 UTC 日期。

{{site.alert.end}}

For a full list of methods,
refer to the API reference for [DateTime][] and [Duration.][Duration]

参考 [DateTime][] 和 [Duration][] API 文档了解全部方法列表。

### Utility classes

### 工具类

The core library contains various utility classes, useful for sorting,
mapping values, and iterating.

核心库包含各种工具类，可用于排序，映射值以及迭代。

#### Comparing objects

#### 比较对象

Implement the [Comparable][]
interface to indicate that an object can be compared to another object,
usually for sorting. The `compareTo()` method returns \< 0 for
*smaller*, 0 for the *same*, and \> 0 for *bigger*.

如果实现了 [Comparable][] 接口，
也就是说可以将该对象与另一个对象进行比较，
通常用于排序。
`compareTo()` 方法在 *小于* 时返回 \< 0，
在 *相等* 时返回 0，
在 *大于* 时返回  \> 0。

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

#### Implementing map keys

Each object in Dart automatically provides an integer hash code, and
thus can be used as a key in a map. However, you can override the
`hashCode` getter to generate a custom hash code. If you do, you might
also want to override the `==` operator. Objects that are equal (via
`==`) must have identical hash codes. A hash code doesn’t have to be
unique, but it should be well distributed.

在 Dart 中每个对象会默认提供一个整数的哈希值，
因此在 map 中可以作为 key 来使用，
重写 `hashCode` 的 getter 方法来生成自定义哈希值。
如果重写 `hashCode` 的 getter 方法，那么可能还需要重写 `==` 运算符。
相等的（通过 `==` ）对象必须拥有相同的哈希值。
哈希值并不要求是唯一的， 但是应该具有良好的分布形态。

{% comment %}
Note: There’s disagreement over whether to include identical() in the ==
implementation. It might improve speed, at least when you need to
compare many fields. They don’t do identical() automatically because, by
convention, NaN != NaN.
{% endcomment %}

<?code-excerpt "misc/lib/library_tour/core/hash_code.dart"?>
```dart
class Person {
  final String firstName, lastName;

  Person(this.firstName, this.lastName);

  // Override hashCode using strategy from Effective Java,
  // Chapter 11.
  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + firstName.hashCode;
    result = 37 * result + lastName.hashCode;
    return result;
  }

  // You should generally implement operator == if you
  // override hashCode.
  @override
  bool operator ==(dynamic other) {
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

#### Iteration

#### 迭代

The [Iterable][] and [Iterator][] classes
support sequential access to a collection of values.
To practice using these collections,
follow the [Iterable collections codelab](/codelabs/iterables).

[Iterable][] 和 [Iterator][] 类支持 for-in 循环。
当创建一个类的时候，继承或者实现 Iterable，
可以为该类提供用于 for-in 循环的 Iterators。
实现 Iterator 来定义实际的遍历操作。

If you create a class that can provide Iterators for use in for-in loops,
extend (if possible) or implement Iterable.
Implement Iterator to define the actual iteration ability.

如果你在 for-in 循环里要创建一个可以提供 Iterator 的类，
如果可以，请选择 extend 或者 implement Iterable 的方式。
Implement Iterator 来定义一个实际的迭代能力。

<?code-excerpt "misc/lib/library_tour/core/iterator.dart"?>
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
  for (var process in Processes()) {
    // Do something with the process.
  }
}
```

### Exceptions

### 异常

The Dart core library defines many common exceptions and errors.
Exceptions are considered conditions that you can plan ahead for and
catch. Errors are conditions that you don’t expect or plan for.

Dart 核心库定义了很多公共的异常和错误类。
异常通常是一些可以预见和预知的情况。
错误是无法预见或者预防的情况。

A couple of the most common errors are:

两个最常见的错误：

[NoSuchMethodError][]

:   Thrown when a receiving object (which might be null) does not
    implement a method.

    当方法的接受对象（可能为null）没有实现该方法时抛出。

[ArgumentError][]

:   Can be thrown by a method that encounters an unexpected argument.

    当方法在接受到一个不合法参数时抛出。

Throwing an application-specific exception is a common way to indicate
that an error has occurred. You can define a custom exception by
implementing the Exception interface:

通常通过抛出一个应用特定的异常，来表示应用发生了错误。
通过实现 Exception 接口来自定义异常：

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
[Exceptions](/guides/language/language-tour#exceptions)
(in the language tour) and the [Exception API reference.][Exception]

更多内容，参考 [Exceptions](#exceptions) 以及 [Exception API 文档。][Exception]

## dart:async - asynchronous programming

## dart:async - 异步编程

Asynchronous programming often uses callback functions, but Dart
provides alternatives: [Future][] and [Stream][] objects. A
Future is like a promise for a result to be provided sometime in the
future. A Stream is a way to get a sequence of values, such as events.
Future, Stream, and more are in the
dart:async library ([API reference][dart:async]).

异步编程通常使用回调方法来实现，但是 Dart
提供了其他方案：[Future][] 和 [Stream][] 对象。
Future 类似与 JavaScript 中的 Promise ，
代表在将来某个时刻会返回一个结果。
Stream 类可以用来获取一系列的值，比如，一系列事件。
Future， Stream，以及更多内容，参考
dart:async library ([API reference][dart:async])。

{{site.alert.note}}

  You don't always need to use the Future or Stream APIs directly. The Dart
  language supports asynchronous coding using keywords such as `async` and
  `await`. See the [asynchronous programming codelab](/codelabs/async-await) for
  details.

  你并不总是需要直接使用 Future 或 Stream 的 API。
  Dart 语言支持使用关键字（例如，`async` 和 `await` ）来实现异步编程。
  更多详情，参考这个 codelab 了解更多：[asynchronous programming codelab](/codelabs/async-await)。

{{site.alert.end}}

The dart:async library works in both web apps and command-line apps. To
use it, import dart:async:

dart:async 库可以工作在 web 应用及 command-line 应用。
通过 import dart:async 来使用。

<?code-excerpt "misc/lib/library_tour/async/future.dart (import)"?>
```dart
import 'dart:async';
```

{{site.alert.version-note}}

  As of Dart 2.1, you don't need to import dart:async to use the Future and
  Stream APIs, because dart:core exports those classes.

  从 Dart 2.1 开始，使用 Future 和 Stream 不需要导入 dart:async ，
  因为 dart:core 库 export 了这些类。

{{site.alert.end}}

### Future

Future objects appear throughout the Dart libraries, often as the object
returned by an asynchronous method. When a future *completes*, its value
is ready to use.

在 Dart 库中随处可见 Future 对象，通常异步函数返回的对象就是一个 Future。
当一个 future *完成执行后*，future 中的值就已经可以使用了。


#### Using await

#### 使用 await

Before you directly use the Future API, consider using `await` instead.
Code that uses `await` expressions can be easier to understand
than code that uses the Future API.

在直接使用 Future API 前，首先应该考虑 `await` 来替代。
代码中使用 `await` 表达式会比直接使用 Future API 更容易理解。

Consider the following function.  It uses Future's `then()` method
to execute three asynchronous functions in a row,
waiting for each one to complete before executing the next one.

阅读思考下面代码。
代码使用 Future 的 `then()` 方法在同一行执行了三个异步函数，
要等待上一个执行完成，再执行下一个任务。

<?code-excerpt "misc/lib/library_tour/async/future.dart (runUsingFuture)"?>
```dart
void runUsingFuture() {
  // ...
  findEntryPoint().then((entryPoint) {
    return runExecutable(entryPoint, args);
  }).then(flushThenExit);
}
```

The equivalent code with await expressions
looks more like synchronous code:

通过 await 表达式实现等价的代码，
看起来非常像同步代码：

<?code-excerpt "misc/lib/library_tour/async/future.dart (runUsingAsyncAwait)"?>
```dart
Future<void> runUsingAsyncAwait() async {
  // ...
  var entryPoint = await findEntryPoint();
  var exitCode = await runExecutable(entryPoint, args);
  await flushThenExit(exitCode);
}
```

An `async` function can catch exceptions from Futures.
For example:

`async` 函数能够捕获来自 Future 的异常。
例如：

<?code-excerpt "misc/lib/library_tour/async/future.dart (catch)"?>
```dart
var entryPoint = await findEntryPoint();
try {
  var exitCode = await runExecutable(entryPoint, args);
  await flushThenExit(exitCode);
} catch (e) {
  // Handle the error...
}
```

{{site.alert.important}}

  Async functions return Futures. If you don't want your function to return a
  future, then use a different solution. For example, you might call an `async`
  function from your function.

  `async` 函数 返回 Future 对象。
  如果你不希望你的函数返回一个 future 对象，
  可以使用其他方案。
  例如，你可以在你的方法中调用一个 async 方法。

{{site.alert.end}}

For more information on using `await` and related Dart language features,
see the [asynchronous programming codelab](/codelabs/async-await).

更多关于 `await` 的使用及相关的 Dart 语言特征，参考
[Asynchrony support](/guides/language/language-tour#asynchrony-support)。

#### Basic usage

#### 基本用法

{% comment %}
[PENDING: Delete much of the following content in favor of the tutorial coverage?]
{% endcomment %}

You can use `then()` to schedule code that runs when the future completes. For
example, `HttpRequest.getString()` returns a Future, since HTTP requests
can take a while. Using `then()` lets you run some code when that Future
has completed and the promised string value is available:

当 future 执行完成后，`then()` 中的代码会被执行。
`then()` 中的代码会在 future 完成后被执行。
例如，`HttpRequest.getString()` 返回一个 future 对象，
因为 HTTP 请求可能需要一段时间。
当 Future 完成并且保证字符串值有效后，
使用 `then()` 来执行你需要的代码：

<?code-excerpt "misc/lib/library_tour/async/basic.dart (then)"?>
```dart
HttpRequest.getString(url).then((String result) {
  print(result);
});
```

Use `catchError()` to handle any errors or exceptions that a Future
object might throw.

使用 `catchError()` 来处理一些 Future 对象可能抛出的错误或者异常。

<?code-excerpt "misc/lib/library_tour/async/basic.dart (catchError)"?>
```dart
HttpRequest.getString(url).then((String result) {
  print(result);
}).catchError((e) {
  // Handle or ignore the error.
});
```

The `then().catchError()` pattern is the asynchronous version of
`try`-`catch`.

`then().catchError()` 组合是 `try`-`catch` 的异步版本。

{{site.alert.important}}

  Be sure to invoke `catchError()` on the result of `then()`—not on the result
  of the original Future. Otherwise, the `catchError()` can handle errors only
  from the original Future's computation, but not from the handler registered by
  `then()`.

  确保调用 `catchError()` 方式在 `then()` 的结果上，而不是在原来的 Future 对象上调用。
  否则的话，`catchError()` 就只能处理原来 Future 对象抛出的异常，
  而无法处理 `then()` 代码里面的异常。

{{site.alert.end}}

#### Chaining multiple asynchronous methods

#### 链式异步编程

The `then()` method returns a Future, providing a useful way to run
multiple asynchronous functions in a certain order. If the callback
registered with `then()` returns a Future, `then()` returns an
equivalent Future. If the callback returns a value of any other type,
`then()` creates a new Future that completes with the value.

`then()` 方法返回一个 Future 对象，
这样就提供了一个非常好的方式让多个异步方法按顺序依次执行。
如果用 `then()` 注册的回调返回一个 Future ，
那么 `then()` 返回一个等价的 Future 。
如果回调返回任何其他类型的值，
那么 `then()` 会创建一个以该值完成的新 Future 。

<?code-excerpt "misc/lib/library_tour/async/future.dart (then-chain)"?>
```dart
Future result = costlyQuery(url);
result
    .then((value) => expensiveWork(value))
    .then((_) => lengthyComputation())
    .then((_) => print('Done!'))
    .catchError((exception) {
  /* Handle exception... */
});
```

In the preceding example, the methods run in the following order:

在上面的示例中，方法按下面顺序执行：

1.  `costlyQuery()`
2.  `expensiveWork()`
3.  `lengthyComputation()`

Here is the same code written using await:

这是使用 await 编写的等效代码：

<?code-excerpt "misc/lib/library_tour/async/future.dart (then-chain-as-await)"?>
```dart
try {
  final value = await costlyQuery(url);
  await expensiveWork(value);
  await lengthyComputation();
  print('Done!');
} catch (e) {
  /* Handle exception... */
}
```


#### Waiting for multiple futures

#### 等待多个 Future

Sometimes your algorithm needs to invoke many asynchronous functions and
wait for them all to complete before continuing. Use the [Future.wait()][]
static method to manage multiple Futures and wait for them to complete:

有时代码逻辑需要调用多个异步函数，
并等待它们全部完成后再继续执行。
使用 [Future.wait()][] 静态方法管理多个 Future 以及等待它们完成：

<?code-excerpt "misc/lib/library_tour/async/future.dart (wait)" replace="/elideBody;/\/* ... *\//g"?>
```dart
Future<void> deleteLotsOfFiles() async =>  ...
Future<void> copyLotsOfFiles() async =>  ...
Future<void> checksumLotsOfOtherFiles() async =>  ...

await Future.wait([
  deleteLotsOfFiles(),
  copyLotsOfFiles(),
  checksumLotsOfOtherFiles(),
]);
print('Done with all the long steps!');
```


### Stream

Stream objects appear throughout Dart APIs, representing sequences of
data. For example, HTML events such as button clicks are delivered using
streams. You can also read a file as a stream.

在 Dart API 中 Stream 对象随处可见，Stream 用来表示一系列数据。
例如，HTML 中的按钮点击就是通过 stream 传递的。
同样也可以将文件作为数据流来读取。


#### Using an asynchronous for loop

#### 异步循环

Sometimes you can use an asynchronous for loop (`await for`)
instead of using the Stream API.

有时，可以使用异步 for 循环 `await for` ，来替代 Stream API 。

Consider the following function.
It uses Stream's `listen()` method
to subscribe to a list of files,
passing in a function literal that searches each file or directory.

思考下面示例函数。
它使用 Stream 的 `listen()` 方法来订阅文件列表，
传入一个搜索文件或目录的函数

<!-- OLD dart-tutorials-samples/cmdline/bin/dgrep.dart -->
<?code-excerpt "misc/lib/library_tour/async/stream.dart (listen)" replace="/listen/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
void main(List<String> arguments) {
  // ...
  FileSystemEntity.isDirectory(searchPath).then((isDir) {
    if (isDir) {
      final startingDir = Directory(searchPath);
      startingDir.list().[!listen!]((entity) {
        if (entity is File) {
          searchFile(entity, searchTerms);
        }
      });
    } else {
      searchFile(File(searchPath), searchTerms);
    }
  });
}
{% endprettify %}

The equivalent code with await expressions,
including an asynchronous for loop (`await for`),
looks more like synchronous code:

下面是使用 await 表达式和异步 for 循环 (`await for`) 实现的等价的代码，
看起来更像是同步代码：

<?code-excerpt "misc/lib/library_tour/async/stream.dart (await-for)" replace="/await for/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
Future<void> main(List<String> arguments) async {
  // ...
  if (await FileSystemEntity.isDirectory(searchPath)) {
    final startingDir = Directory(searchPath);
    [!await for!] (var entity in startingDir.list()) {
      if (entity is File) {
        searchFile(entity, searchTerms);
      }
    }
  } else {
    searchFile(File(searchPath), searchTerms);
  }
}
{% endprettify %}

{{site.alert.important}}

  Before using `await for`, make sure that it makes the code clearer and that
  you really do want to wait for all of the stream's results. For example, you
  usually should **not** use `await for` for DOM event listeners, because the
  DOM sends endless streams of events. If you use `await for` to register two
  DOM event listeners in a row, then the second kind of event is never handled.

  在使用 `await for` 前，确认这样能保持代码清晰，
  并希望获取所有 stream 的结果。
  例如，你通常并 **不** 会使用 `await for` 来监听 DOM 事件，
  因为 DOM 会发送无尽的流事件。
  如果在同一行使用 `await for` 注册两个 DOM 事件，
  那么第二个事件永远不会被处理。

{{site.alert.end}}

For more information on using `await` and related
Dart language features, see the
[asynchronous programming codelab](/codelabs/async-await).

有关 `await` 的使用及 Dart 语言的相关信息，参考
[Asynchrony support](/guides/language/language-tour#asynchrony-support)。


#### Listening for stream data

#### 监听流数据（stream data）

To get each value as it arrives, either use `await for` or
subscribe to the stream using the `listen()` method:

使用 `await for` 或者使用 `listen()` 方法监听 stream，
来获取每个到达的数据流值：

<?code-excerpt "misc/lib/library_tour/async/stream_web.dart (listen)" replace="/listen/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
// Add an event handler to a button.
submitButton.onClick.[!listen!]((e) {
  // When the button is clicked, it runs this code.
  submitData();
});
{% endprettify %}

In this example, the `onClick` property is a `Stream` object provided by
the submit button.

下面示例中，ID 为 "submitInfo" button 提供的 `onClick` 属性是一个 Stream 对象。

If you care about only one event, you can get it using a property such
as `first`, `last`, or `single`. To test the event before handling it,
use a method such as `firstWhere()`, `lastWhere()`, or `singleWhere()`.

如果只关心其中一个事件，可以使用，例如，`first`， `last`，或 `single` 属性来获取。
要在处理时间前对事件进行测试，可以使用，例如 `firstWhere()`， `lastWhere()`， 或 `singleWhere()` 方法。

{% comment %}
{PENDING: example}
{% endcomment %}

If you care about a subset of events, you can use methods such as
`skip()`, `skipWhile()`, `take()`, `takeWhile()`, and `where()`.

如果只关心事件中的一个子集，可以使用，例如，`skip()`， `skipWhile()`，`take()`，`takeWhile()`， 和 `where()`。

{% comment %}
{PENDING: example}
{% endcomment %}


#### Transforming stream data

#### 传递流数据（stream data）

Often, you need to change the format of a stream's data before you can
use it. Use the `transform()` method to produce a stream with a
different type of data:

常常，在使用流数据前需要改变数据的格式。
使用 `transform()` 方法生成具有不同类型数据的流：

<?code-excerpt "misc/lib/library_tour/async/stream.dart (transform)"?>
```dart
var lines = inputStream
    .transform(utf8.decoder)
    .transform(LineSplitter());
```

This example uses two transformers. First it uses utf8.decoder to
transform the stream of integers into a stream of strings. Then it uses
a LineSplitter to transform the stream of strings into a stream of
separate lines. These transformers are from the dart:convert library (see the
[dart:convert section](#dartconvert---decoding-and-encoding-json-utf-8-and-more)).

上面例子中使用了两个 transformer 。
第一个使用 utf8.decoder 将整型流转换为字符串流。
接着，使用了 LineSplitter 将字符串流转换为多行字符串流。
这些 transformer 来自 dart:convert 库
（参考[dart:convert section](#dartconvert---decoding-and-encoding-json-utf-8-and-more)）。

{% comment %}
  PENDING: add onDone and onError. (See "Streaming file contents".)
{% endcomment %}


#### Handling errors and completion

#### 处理错误和完成

How you specify error and completion handling code
depends on whether you use an asynchronous for loop (`await for`)
or the Stream API.

处理错误和完成代码方式，
取决于使用的是 异步 for 循环（`await for`）还是 Stream API 。

If you use an asynchronous for loop,
then use try-catch to handle errors.
Code that executes after the stream is closed
goes after the asynchronous for loop.

如果使用的是异步 for 循环，
那么通过  try-catch 来处理错误。
代码位于异步 for 循环之后，
会在 stream 被关闭后执行。

<?code-excerpt "misc/lib/library_tour/async/stream.dart (readFileAwaitFor)" replace="/try|catch/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
Future<void> readFileAwaitFor() async {
  var config = File('config.txt');
  Stream<List<int>> inputStream = config.openRead();

  var lines = inputStream
      .transform(utf8.decoder)
      .transform(LineSplitter());
  [!try!] {
    await for (var line in lines) {
      print('Got ${line.length} characters from stream');
    }
    print('file is now closed');
  } [!catch!] (e) {
    print(e);
  }
}
{% endprettify %}

If you use the Stream API,
then handle errors by registering an `onError` listener.
Run code after the stream is closed by registering
an `onDone` listener.

如果使用的是 Stream API，
那么通过注册 `onError` 监听来处理错误。
代码位于注册的 `onDone` 中，
会在 stream 被关闭后执行。

<?code-excerpt "misc/lib/library_tour/async/stream.dart (onDone)" replace="/onDone|onError/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
var config = File('config.txt');
Stream<List<int>> inputStream = config.openRead();

inputStream
    .transform(utf8.decoder)
    .transform(LineSplitter())
    .listen((String line) {
  print('Got ${line.length} characters from stream');
}, [!onDone!]: () {
  print('file is now closed');
}, [!onError!]: (e) {
  print(e);
});
{% endprettify %}


### More information

### 更多内容

For some examples of using Future and Stream in command-line apps,
see the [dart:io tour][dart:io tour].
Also see these articles, codelabs, and tutorials:

更多在 command-line 应用中使用 Future 和 Stream 的实例，参考
[dart:io 概览][dart:io tour]
也可以参考下列文章和教程：

-   [Asynchronous programming: futures, async, await](/codelabs/async-await)
-   [Futures and error handling](/guides/libraries/futures-error-handling)
-   [Asynchronous programming: streams](/tutorials/language/streams)
-   [Creating streams in Dart](/articles/libraries/creating-streams)
-   [Dart asynchronous programming: Isolates and event loops](https://medium.com/dartlang/dart-asynchronous-programming-isolates-and-event-loops-bffc3e296a6a)

## dart:math - math and random

## dart:math - 数学和随机数

The dart:math library ([API reference][dart:math])
provides common functionality such as sine and cosine,
maximum and minimum, and constants such as *pi* and *e*. Most of the
functionality in the Math library is implemented as top-level functions.

dart:math 库（[API reference][dart:math]）
提供通用的功能，例如，正弦和余弦，
最大值和最小值，以及数学常数，例如 *pi* 和 *e*。
大多数在 Math 库中的功能是作为顶级函数实现的。

To use this library in your app, import dart:math.

通过导入 `dart:math` 来引入使用该库。

<?code-excerpt "misc/test/library_tour/math_test.dart (import)"?>
```dart
import 'dart:math';
```


### Trigonometry

### 三角函数

The Math library provides basic trigonometric functions:

Math 库提供基本的三角函数：

<?code-excerpt "misc/test/library_tour/math_test.dart (trig)"?>
```dart
// Cosine
assert(cos(pi) == -1.0);

// Sine
var degrees = 30;
var radians = degrees * (pi / 180);
// radians is now 0.52359.
var sinOf30degrees = sin(radians);
// sin 30° = 0.5
assert((sinOf30degrees - 0.5).abs() < 0.01);
```

{{site.alert.note}}

  These functions use radians, not degrees!

  这些函数参数单位是弧度，不是角度！

{{site.alert.end}}


### Maximum and minimum

### 最大值和最小值

The Math library provides `max()` and `min()` methods:

Math 库提供 `max()` 和 `min()` 方法：

<?code-excerpt "misc/test/library_tour/math_test.dart (min-max)"?>
```dart
assert(max(1, 1000) == 1000);
assert(min(1, -1000) == -1000);
```


### Math constants

### 数学常数

Find your favorite constants—*pi*, *e*, and more—in the Math library:

在 Math 库中可以找到你需要的数学常数，例如，*pi*， *e* 等等：

<?code-excerpt "misc/test/library_tour/math_test.dart (constants)"?>
```dart
// See the Math library for additional constants.
print(e); // 2.718281828459045
print(pi); // 3.141592653589793
print(sqrt2); // 1.4142135623730951
```


### Random numbers

### 随机数

Generate random numbers with the [Random][] class. You can
optionally provide a seed to the Random constructor.

使用 [Random][] 类产生随机数。
可以为 Random 构造函数提供一个可选的种子参数。

<?code-excerpt "misc/test/library_tour/math_test.dart (Random)"?>
```dart
var random = Random();
random.nextDouble(); // Between 0.0 and 1.0: [0, 1)
random.nextInt(10); // Between 0 and 9.
```

You can even generate random booleans:

也可以产生随机布尔值序列：

<?code-excerpt "misc/test/library_tour/math_test.dart (Random-bool)"?>
```dart
var random = Random();
random.nextBool(); // true or false
```


### More information

### 更多内容

Refer to the [Math API reference][dart:math] for a full list of methods.
Also see the API reference for [num,][num] [int,][int] and [double.][double]

完整方法列表参考 [Math API docs][dart:math]。
在 API 文档中参考 [num,][num] [int,][int] 和 [double][double]。

## dart:convert - decoding and encoding JSON, UTF-8, and more

## dart:convert - 编解码JSON，UTF-8等

The dart:convert library ([API reference][dart:convert])
has converters for JSON and UTF-8, as well as support for creating
additional converters. [JSON][] is a simple text format for representing
structured objects and collections. [UTF-8][] is a common variable-width
encoding that can represent every character in the Unicode character
set.

dart:convert 库 （[API reference][dart:convert]）提供 JSON 和 UTF-8 转换器，
以及创建其他转换器。
[JSON][] 是一种用于表示结构化对象和集合的简单文本格式。
[UTF-8][] 是一种常见的可变宽度编码，可以表示Unicode字符集中的每个字符。

To use this library, import dart:convert.

使用时，通过 import dart:convert 引入。

<?code-excerpt "misc/test/library_tour/convert_test.dart (import)"?>
```dart
import 'dart:convert';
```


### Decoding and encoding JSON

### 编解码JSON

Decode a JSON-encoded string into a Dart object with `jsonDecode()`:

使用 `jsonDecode()` 解码 JSON 编码的字符串为 Dart 对象：

<?code-excerpt "misc/test/library_tour/convert_test.dart (json-decode)"?>
```dart
// NOTE: Be sure to use double quotes ("),
// not single quotes ('), inside the JSON string.
// This string is JSON, not Dart.
var jsonString = '''
  [
    {"score": 40},
    {"score": 80}
  ]
''';

var scores = jsonDecode(jsonString);
assert(scores is List);

var firstScore = scores[0];
assert(firstScore is Map);
assert(firstScore['score'] == 40);
```

Encode a supported Dart object into a JSON-formatted string with
`jsonEncode()`:

使用 `jsonEncode()` 编码 Dart 对象为 JSON 格式的字符串：

<?code-excerpt "misc/test/library_tour/convert_test.dart (json-encode)"?>
```dart
var scores = [
  {'score': 40},
  {'score': 80},
  {'score': 100, 'overtime': true, 'special_guest': null}
];

var jsonText = jsonEncode(scores);
assert(jsonText ==
    '[{"score":40},{"score":80},'
        '{"score":100,"overtime":true,'
        '"special_guest":null}]');
```

Only objects of type int, double, String, bool, null, List, or Map (with
string keys) are directly encodable into JSON. List and Map objects are
encoded recursively.

只有 int， double， String， bool, null, List, 或者 Map 类型对象可以直接编码成 JSON。
List 和 Map 对象进行递归编码。

You have two options for encoding objects that aren't directly
encodable. The first is to invoke `jsonEncode()` with a second argument: a
function that returns an object that is directly encodable. Your second
option is to omit the second argument, in which case the encoder calls
the object's `toJson()` method.

不能直接编码的对象有两种方式对其编码。
第一种方式是调用 `jsonEncode()` 时赋值第二个参数，
这个参数是一个函数，
该函数返回一个能够直接编码的对象
第二种方式是省略第二个参数，着这种情况下编码器调用对象的 `toJson()` 方法。

For more examples and links to JSON-related packages, see
[Using JSON](/guides/json).

更多示例及 JSON 包相关链接，参考 [JSON Support](/guides/json) 。


### Decoding and encoding UTF-8 characters

### 编解码 UTF-8 字符

Use `utf8.decode()` to decode UTF8-encoded bytes to a Dart string:

使用 `utf8.decode()` 解码 UTF8 编码的字符创为 Dart 字符串：

<?code-excerpt "misc/test/library_tour/convert_test.dart (utf8-decode)" replace="/ \/\/line-br.*//g"?>
```dart
List<int> utf8Bytes = [
  0xc3, 0x8e, 0xc3, 0xb1, 0xc5, 0xa3, 0xc3, 0xa9,
  0x72, 0xc3, 0xb1, 0xc3, 0xa5, 0xc5, 0xa3, 0xc3,
  0xae, 0xc3, 0xb6, 0xc3, 0xb1, 0xc3, 0xa5, 0xc4,
  0xbc, 0xc3, 0xae, 0xc5, 0xbe, 0xc3, 0xa5, 0xc5,
  0xa3, 0xc3, 0xae, 0xe1, 0xbb, 0x9d, 0xc3, 0xb1
];

var funnyWord = utf8.decode(utf8Bytes);

assert(funnyWord == 'Îñţérñåţîöñåļîžåţîờñ');
```

To convert a stream of UTF-8 characters into a Dart string, specify
`utf8.decoder` to the Stream `transform()` method:

将 UTF-8 字符串流转换为 Dart 字符串，
为 Stream 的 `transform()` 方法上指定 `utf8.decoder`：

<?code-excerpt "misc/test/library_tour/io_test.dart (utf8-decoder)" replace="/utf8.decoder/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
var lines =
    [!utf8.decoder!].bind(inputStream).transform(LineSplitter());
try {
  await for (var line in lines) {
    print('Got ${line.length} characters from stream');
  }
  print('file is now closed');
} catch (e) {
  print(e);
}
{% endprettify %}

Use `utf8.encode()` to encode a Dart string as a list of UTF8-encoded
bytes:

使用 `utf8.encode()` 将 Dart 字符串编码为一个 UTF8 编码的字节流：

<?code-excerpt "misc/test/library_tour/convert_test.dart (utf8-encode)" replace="/ \/\/line-br.*//g"?>
```dart
List<int> encoded = utf8.encode('Îñţérñåţîöñåļîžåţîờñ');

assert(encoded.length == utf8Bytes.length);
for (int i = 0; i < encoded.length; i++) {
  assert(encoded[i] == utf8Bytes[i]);
}
```


### Other functionality

### 其他功能

The dart:convert library also has converters for ASCII and ISO-8859-1
(Latin1). For details, see the [API reference for the dart:convert library.][dart:convert]

dart:convert 库同样包含 ASCII 和 ISO-8859-1 (Latin1) 转换器。
更多详情，参考 [API docs for the dart:convert library。][dart:convert]


## dart:html - browser-based apps {#darthtml}

## dart:html - 基于浏览器应用 {#darthtml}

{% include_relative _dart-html-tour.md %}

## dart:io - I/O for servers and command-line apps {#dartio}

## dart:io - 服务器和命令行应用程序的 I/O 。 {#dartio}

{% include_relative _dart-io-tour.md %}

## Summary

## 总结

This page introduced you to the most commonly used functionality in
Dart’s built-in libraries. It didn’t cover all the built-in
libraries, however. Others that you might want to look into include
[dart:collection][] and [dart:typed\_data,][dart:typed\_data]
as well as platform-specific libraries like the
[Dart web development libraries][webdev libraries]
and the [Flutter libraries.][docs.flutter]

本页向您介绍了 Dart 内置库中最常用的功能。
但是，并没有涵盖所有内置库。
您可能想要查看的其他内容包括 [dart:collection][] 和 [dart:typed\_data,][dart:typed\_data] ，
以及特定于平台的库，如 [Dart web development libraries][webdev libraries] 和 [Flutter libraries.][docs.flutter] 。

You can get yet more libraries by using the [pub package manager](/guides/packages). The
[collection,]({{site.pub-pkg}}/collection)
[crypto,]({{site.pub-pkg}}/crypto)
[http,]({{site.pub-pkg}}/http)
[intl,]({{site.pub-pkg}}/intl) and
[test]({{site.pub-pkg}}/test) libraries are just a
sampling of what you can install using pub.

您可以使用 [pub 包管理](/guides/packages) 工具获得更多库。
[collection,]({{site.pub}}/packages/collection)
[crypto,]({{site.pub}}/packages/crypto)
[http,]({{site.pub}}/packages/http)
[intl,]({{site.pub}}/packages/intl) 以及
[test]({{site.pub}}/packages/test)
以上只是简单的列举了一些可以通过 pub 安装的库。

To learn more about the Dart language, see the
[language tour][].

要了解有关 Dart 语言的更多信息，请参考
[language tour][]。

[language tour]: /guides/language/language-tour
[docs.flutter]: {{site.flutter_api}}
[Assert]: /guides/language/language-tour#assert
[ArgumentError]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/ArgumentError-class.html
[Comparable]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Comparable-class.html
[dart:core]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/dart-core-library.html
[dart:async]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-async/dart-async-library.html
[dart:collection]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-collection/dart-collection-library.html
[dart:convert]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-convert/dart-convert-library.html
[dart:io tour]: #dartio
[dart:math]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-math/dart-math-library.html
[dart:typed\_data]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-typed_data/dart-typed_data-library.html
[Dart API]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}
[DateTime]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/DateTime-class.html
[double]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/double-class.html
[Duration]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Duration-class.html
[Exception]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Exception-class.html
[Future]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-async/Future-class.html
[Future.wait()]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-async/Future/wait.html
[IndexedDB]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-indexed_db/dart-indexed_db-library.html
[int]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/int-class.html
[Iterable]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Iterable-class.html
[Iterator]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Iterator-class.html
[JSON]: https://www.json.org/
[List]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/List-class.html
[Map]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Map-class.html
[Match]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Match-class.html
[NoSuchMethodError]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/NoSuchMethodError-class.html
[num]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/num-class.html
[Object]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Object-class.html
[Pattern]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Pattern-class.html
[Random]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-math/Random-class.html
[RegExp]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/RegExp-class.html
[Set]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Set-class.html
[Stream]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-async/Stream-class.html
[String]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/String-class.html
[StringBuffer]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/StringBuffer-class.html
[Symbol]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Symbol-class.html
[toStringAsFixed()]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/num/toStringAsFixed.html
[toStringAsPrecision()]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/num/toStringAsPrecision.html
[UTF-8]: https://en.wikipedia.org/wiki/UTF-8
[web audio]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-web_audio/dart-web_audio-library.html
[Uri]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Uri-class.html
[webdev libraries]: /web/libraries
