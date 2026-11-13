---
# title: Collections
title: 集合
# description: Summary of the different types of collections in Dart.
description: "Dart 中不同类型集合的概述。"
ai-translated: true
prevpage:
  url: /language/records
# title: Records
  title: 记录
nextpage:
  url: /language/generics
# title: Generics
  title: 泛型
---

Dart has built-in support for list, set, and map [collections][].
To learn more about configuring the types collections contain,
check out [Generics][].

Dart 内置支持 list、set 和 map [集合][collections]。
要了解更多关于配置集合所含类型的内容，
请参阅 [泛型][generics]。

[generics]: /language/generics
[collections]: /libraries/dart-core#collections

## Lists

## List

Perhaps the most common collection in nearly every programming language
is the *array*, or ordered group of objects. In Dart, arrays are
[`List`][] objects, so most people just call them *lists*.

几乎每种编程语言中最常见的集合
大概就是 *数组*，即有序的对象组。
在 Dart 中，数组是 [`List`][] 对象，
所以大多数人直接称它们为 *list*。

Dart list literals are denoted by a comma-separated list of
elements enclosed in square brackets (`[]`). Each element
is usually an expression. Here's a simple Dart list:

Dart 的 list 字面量用方括号（`[]`）
括起一组逗号分隔的元素来表示。
每个元素通常是一个表达式。
下面是一个简单的 Dart list：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (list-literal)"?>
```dart
var list = [1, 2, 3];
```

:::note
Dart infers that `list` has type `List<int>`. If you try to add non-integer
objects to this list, the analyzer or runtime raises an error. For more
information, read about [type inference][].

Dart 推断出 `list` 的类型是 `List<int>`。
如果你试图向这个 list 添加非整数对象，
分析器或运行时就会报错。
更多信息请阅读 [类型推断][type inference]。
:::

<a id="trailing-comma"></a>
You can add a comma after the last item in a Dart collection literal.
This _trailing comma_ doesn't affect the collection,
but it can help prevent copy-paste errors.

你可以在 Dart 集合字面量的最后一项后面加一个逗号。
这个 _尾随逗号_ 不影响集合本身，
但有助于避免复制粘贴错误。

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (trailing-commas)"?>
```dart
var list = ['Car', 'Boat', 'Plane',];
```

Lists use zero-based indexing, where 0 is the index of the first element
and `list.length - 1` is the index of the last element.
You can get a list's length using the `.length` property
and access a list's elements using the subscript operator (`[]`):

list 使用从零开始的索引，
0 是第一个元素的索引，
`list.length - 1` 是最后一个元素的索引。
你可以用 `.length` 属性获取 list 的长度，
并用下标运算符（`[]`）访问 list 的元素：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (list-indexing)"?>
```dart
var list = [1, 2, 3];
assert(list.length == 3);
assert(list[1] == 2);

list[1] = 1;
assert(list[1] == 1);
```

To create a list that's a compile-time constant,
add `const` before the list literal:

要创建编译时常量的 list，
请在 list 字面量前加 `const`：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (const-list)"?>
```dart
var constantList = const [1, 2, 3];
// constantList[1] = 1; // This line will cause an error.
```

For more information about lists, refer to the Lists section of the
[`dart:core` documentation](/libraries/dart-core#lists).

关于 list 的更多信息，
请参阅 [`dart:core` 文档](/libraries/dart-core#lists)
的 Lists 一节。

[`List`]: {{site.dart-api}}/dart-core/List-class.html
[type inference]: /language/type-system#type-inference

## Sets

## Set

A set in Dart is an unordered collection of unique elements.
Dart support for sets is provided by set literals and the
[`Set`][] type.

Dart 中的 set 是无序的唯一元素集合。
Dart 通过 set 字面量和 [`Set`][] 类型
提供对 set 的支持。

Here is a simple Dart set, created using a set literal:

下面是用 set 字面量创建的一个简单 Dart set：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (set-literal)"?>
```dart
var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'};
```

:::note
Dart infers that `halogens` has the type `Set<String>`. If you try to add the
wrong type of element to the set, the analyzer or runtime raises an error. For
more information, read about
[type inference.](/language/type-system#type-inference)

Dart 推断出 `halogens` 的类型是 `Set<String>`。
如果你试图向 set 添加错误类型的元素，
分析器或运行时就会报错。
更多信息请阅读
[类型推断](/language/type-system#type-inference)。
:::

To create an empty set, use `{}` preceded by a type argument,
or assign `{}` to a variable of type `Set`:

要创建空 set，请在 `{}` 前加上类型实参，
或者把 `{}` 赋值给 `Set` 类型的变量：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (set-vs-map)"?>
```dart
var names = <String>{};
// Set<String> names = {}; // This works, too.
// var names = {}; // Creates a map, not a set.
```

:::note Set or map?
The syntax for map literals is similar to that for set
literals. Because map literals came first, `{}` defaults to the `Map` type. If
you forget the type annotation on `{}` or the variable it's assigned to, then
Dart creates an object of type `Map<dynamic, dynamic>`.

map 字面量的语法与 set 字面量相似。
由于 map 字面量出现得更早，
`{}` 默认是 `Map` 类型。
如果你忘了给 `{}` 或它被赋值到的变量写类型注解，
Dart 就会创建一个 `Map<dynamic, dynamic>` 类型的对象。
:::

Add items to an existing set using the `add()` or `addAll()` methods:

使用 `add()` 或 `addAll()` 方法
向已有的 set 添加元素：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (set-add-items)"?>
```dart
var elements = <String>{};
elements.add('fluorine');
elements.addAll(halogens);
```

Use `.length` to get the number of items in the set:

使用 `.length` 获取 set 中的元素数量：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (set-length)"?>
```dart
var elements = <String>{};
elements.add('fluorine');
elements.addAll(halogens);
assert(elements.length == 5);
```

To create a set that's a compile-time constant,
add `const` before the set literal:

要创建编译时常量的 set，
请在 set 字面量前加 `const`：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (const-set)"?>
```dart
final constantSet = const {
  'fluorine',
  'chlorine',
  'bromine',
  'iodine',
  'astatine',
};
// constantSet.add('helium'); // This line will cause an error.
```

For more information about sets, refer to the Sets section of the
[`dart:core` documentation](/libraries/dart-core#sets).

关于 set 的更多信息，
请参阅 [`dart:core` 文档](/libraries/dart-core#sets)
的 Sets 一节。

[`Set`]: {{site.dart-api}}/dart-core/Set-class.html

## Maps

## Map

In a map, each element is a key-value pair. Each key within
a pair is associated with a value, and both keys and values
can be any type of object. Each key can occur only once,
although the same value can be associated with multiple
different keys. Dart support for maps is provided by
map literals and the [`Map`][] type.

在 map 中，每个元素都是一个键值对。
每对中的键都关联着一个值，
键和值都可以是任何类型的对象。
每个键只能出现一次，
但同一个值可以关联多个不同的键。
Dart 通过 map 字面量和 [`Map`][] 类型
提供对 map 的支持。

Here are a couple of simple Dart maps, created using map literals:

下面是用 map 字面量创建的几个简单 Dart map：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (map-literal)"?>
```dart
var gifts = {
  // Key:    Value
  'first': 'partridge',
  'second': 'turtledoves',
  'fifth': 'golden rings',
};

var nobleGases = {2: 'helium', 10: 'neon', 18: 'argon'};
```

:::note
Dart infers that `gifts` has the type `Map<String, String>` and `nobleGases`
has the type `Map<int, String>`. If you try to add the wrong type of value to
either map, the analyzer or runtime raises an error. For more information,
read about [type inference][].

Dart 推断出 `gifts` 的类型是 `Map<String, String>`，
`nobleGases` 的类型是 `Map<int, String>`。
如果你试图向任一 map 添加错误类型的值，
分析器或运行时就会报错。
更多信息请阅读 [类型推断][type inference]。
:::

You can create the same objects using a Map constructor:

也可以用 Map 构造函数创建同样的对象：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (map-constructor)"?>
```dart
var gifts = Map<String, String>();
gifts['first'] = 'partridge';
gifts['second'] = 'turtledoves';
gifts['fifth'] = 'golden rings';

var nobleGases = Map<int, String>();
nobleGases[2] = 'helium';
nobleGases[10] = 'neon';
nobleGases[18] = 'argon';
```

:::note
If you come from a language like C# or Java, you might expect to see `new Map()` 
instead of just `Map()`. In Dart, the `new` keyword is optional.
For details, see [Using constructors][].

如果你来自 C# 或 Java 这样的语言，
可能期望看到 `new Map()` 而不只是 `Map()`。
在 Dart 中，`new` 关键字是可选的。
详情请参阅 [使用构造函数][Using constructors]。
:::

Add a new key-value pair to an existing map
using the subscript assignment operator (`[]=`):

使用下标赋值运算符（`[]=`）
向已有的 map 添加新的键值对：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (map-add-item)"?>
```dart
var gifts = {'first': 'partridge'};
gifts['fourth'] = 'calling birds'; // Add a key-value pair
```

Retrieve a value from a map using the subscript operator (`[]`):

使用下标运算符（`[]`）从 map 中取值：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (map-retrieve-item)"?>
```dart
var gifts = {'first': 'partridge'};
assert(gifts['first'] == 'partridge');
```

If you look for a key that isn't in a map, you get `null` in return:

如果查找 map 中不存在的键，会得到 `null`：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (map-missing-key)"?>
```dart
var gifts = {'first': 'partridge'};
assert(gifts['fifth'] == null);
```

Use `.length` to get the number of key-value pairs in the map:

使用 `.length` 获取 map 中键值对的数量：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (map-length)"?>
```dart
var gifts = {'first': 'partridge'};
gifts['fourth'] = 'calling birds';
assert(gifts.length == 2);
```

To create a map that's a compile-time constant,
add `const` before the map literal:

要创建编译时常量的 map，
请在 map 字面量前加 `const`：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (const-map)"?>
```dart
final constantMap = const {2: 'helium', 10: 'neon', 18: 'argon'};

// constantMap[2] = 'Helium'; // This line will cause an error.
```

For more information about maps, refer to the Maps section of the
[`dart:core` documentation](/libraries/dart-core#maps).

关于 map 的更多信息，
请参阅 [`dart:core` 文档](/libraries/dart-core#maps)
的 Maps 一节。

[Using constructors]: /language/classes#using-constructors
[`Map`]: {{site.dart-api}}/dart-core/Map-class.html
[type inference]: /language/type-system#type-inference

## Collection elements {: #collection-elements }

## 集合元素

A collection literal contains a series of elements. During
runtime, each element is evaluated, producing zero or more
values that are then inserted into the resulting collection.
These elements fall into two main categories: leaf elements
and control flow elements.

集合字面量包含一系列元素。
运行时，每个元素都会被求值，
产生零个或多个值，然后插入到结果集合中。
这些元素分为两大类：
叶子元素和控制流元素。

*   Leaf element: Inserts an individual item into a
    collection literal.

    叶子元素：向集合字面量中插入单个项。
    
    *   Expression element: Evaluates a single
        expression and inserts the resulting value
        into the collection.

        表达式元素：对单个表达式求值，
        并把结果值插入集合。

    *   Map entry element: Evaluates a pair of key and value
        expressions and inserts the resulting entry into the
        collection. 

        map 条目元素：对一对键和值表达式求值，
        并把结果条目插入集合。

*   Control flow element: Conditionally or iteratively adds
    zero or more values to the surrounding collection.

    控制流元素：有条件地或迭代地
    向外层集合添加零个或多个值。

    *   Null-aware element: Evaluates an expression and if
        the result is not `null`, inserts the value into the
        surrounding collection.

        空感知元素：对一个表达式求值，
        如果结果不是 `null`，
        就把该值插入外层集合。

    *   Spread element: Iterates over a given sequence
        (collection expression) and inserts all of the
        resulting values into the surrounding collection.

        展开元素：遍历给定的序列（集合表达式），
        并把所有结果值插入外层集合。
    
    *   Null-aware spread element: Similar to the
        spread element, but allows the collection to be
        `null` and inserts nothing if it is.

        空感知展开元素：与展开元素类似，
        但允许集合为 `null`，
        为 `null` 时不插入任何内容。

    *   If element: Conditionally evaluates an inner element
        based on given a condition expression, and
        optionally evaluates another `else` element if the
        condition is false.

        if 元素：根据给定的条件表达式
        有条件地对内部元素求值，
        条件为 false 时还可以对另一个
        `else` 元素求值。

    *   For element: Iterates and repeatedly evaluates a
        given inner element, inserting zero or more
        resulting values.

        for 元素：迭代并反复对给定的内部元素求值，
        插入零个或多个结果值。

To learn more about collection elements, see the following
sections.

要了解更多关于集合元素的内容，
请参阅以下各节。

<a id="control-flow-operators" aria-hidden="true"></a>
<a id="spread-operators" aria-hidden="true"></a>
<a id="collection-operators" aria-hidden="true"></a>

### Expression elements {: #expression-element }

### 表达式元素

An expression element evaluates a single expression
and inserts the resulting value into a collection. This
expression can encompass various constructs like
literals, variables, operators, function calls, and
constructor calls.

表达式元素对单个表达式求值，
并把结果值插入集合。
这个表达式可以包含各种结构，
如字面量、变量、运算符、函数调用和构造函数调用。

An expression element has this syntax in a collection:

表达式元素在集合中的语法如下：

```dart
<expression>
```

### Map entry elements {: #map-entry-element }

### map 条目元素

A map entry element evaluates a pair of key and value
expressions and inserts the resulting entry into a
collection. Both the key and the value within this pair can
be expressions.

map 条目元素对一对键和值表达式求值，
并把结果条目插入集合。
这一对中的键和值都可以是表达式。

A map entry element has this syntax in a collection:

map 条目元素在集合中的语法如下：

```dart
<key_expression>: <value_expression>
```

### Null-aware elements {: #null-aware-element }

### 空感知元素

A null-aware element evaluates an expression and if the
result is not `null`, inserts the value into the surrounding
collection.

空感知元素对一个表达式求值，
如果结果不是 `null`，
就把该值插入外层集合。

:::version-note
Null-aware collection elements require
a [language version][] of at least 3.8.

空感知集合元素需要至少 3.8 的
[语言版本][language version]。
:::

A null-aware element has the following syntax in an
expression element:

空感知元素在表达式元素中的语法如下：

```dart
?<expression>
```

A null-aware element has the following syntax in a
map entry element:

空感知元素在 map 条目元素中的语法如下：

```dart
// key is a null-aware element
?<key_expression>: <value_expression>
```

```dart
// value is a null-aware element
<key_expression>: ?<value_expression>
```

```dart
// key and value are null-aware elements
?<key_expression>: ?<value_expression>
```

In the following example, the result for the
null-aware element `?absentValue` is not added to a list called
`items` because `absentValue` is `null`:

在下面的例子中，
空感知元素 `?absentValue` 的结果
没有被加入名为 `items` 的 list，
因为 `absentValue` 是 `null`：

<?code-excerpt "misc/test/language_tour/collections/null_aware_element_a.dart (code-sample)"?>
```dart
int? absentValue = null;
int? presentValue = 3;
var items = [
  1,
  ?absentValue,
  ?presentValue,
  absentValue,
  5,
]; // [1, 3, null, 5]
```

The following example illustrates various ways that
you can use null-aware elements inside of
map entry elements:

下面的例子展示了在 map 条目元素中
使用空感知元素的各种方式：

<?code-excerpt "misc/test/language_tour/collections/null_aware_element_b.dart (code-sample)"?>
```dart
String? presentKey = 'Apple';
String? absentKey = null;

int? presentValue = 3;
int? absentValue = null;

var itemsA = {presentKey: absentValue}; // {Apple: null}
var itemsB = {presentKey: ?absentValue}; // {}

var itemsC = {absentKey: presentValue}; // {null: 3}
var itemsD = {?absentKey: presentValue}; // {}

var itemsE = {absentKey: absentValue}; // {null: null}
var itemsF = {?absentKey: ?absentValue}; // {}
```

[language version]: /language/versioning

### Spread elements {: #spread-element }

### 展开元素

The spread element iterates over a given sequence and
inserts all of the resulting values into the surrounding
collection.

展开元素遍历给定的序列，
并把所有结果值插入外层集合。

A spread element has the following syntax in a collection.
The sequence expression can represent any expression that
evaluates to an object that implements `Iterable`:

展开元素在集合中的语法如下。
序列表达式可以是任何求值结果
为实现 `Iterable` 的对象的表达式：

```dart
...<sequence_expression>
```

In the following example, the elements in a list called `a`
are added to a list called `items`.

在下面的例子中，名为 `a` 的 list 中的元素
被加入名为 `items` 的 list。

<?code-excerpt "misc/test/language_tour/collections/spread_operator_in_collection_a.dart (code_sample)"?>
```dart
var a = [1, 2, null, 4];
var items = [0, ...a, 5]; // [0, 1, 2, null, 4, 5]
```

If you are spreading an expression that might evaluate to
`null` and you want to ignore the `null` (and insert no
elements), use a [null-aware spread element][].

如果你要展开的表达式可能求值为 `null`，
而你想忽略这个 `null`（不插入任何元素），
请使用 [空感知展开元素][null-aware spread element]。

To learn more about the spread operator, see
[Spread operator][].

要了解更多关于展开运算符的内容，
请参阅 [展开运算符][Spread operator]。

[Spread operator]: /language/operators/#spread-operators
[null-aware spread element]: #null-spread-element

### Null-aware spread elements {: #null-spread-element }

### 空感知展开元素

The null-aware spread element is similar to the
spread element, but allows the collection to be `null` and
inserts nothing if it is.

空感知展开元素与展开元素类似，
但允许集合为 `null`，
为 `null` 时不插入任何内容。

A null-aware spread element has this syntax in a
collection:

空感知展开元素在集合中的语法如下：

```dart
...?<sequence_expression>
```

In the following example, a list called `a` is ignored
because it's null, but the elements in a list called `b`
are added to a list called `items`. Notice that if a
collection itself is not `null`, but it contains elements that
are, those `null` elements are still added to the result.

在下面的例子中，名为 `a` 的 list 因为是 null 而被忽略，
但名为 `b` 的 list 中的元素
被加入名为 `items` 的 list。
注意，如果集合本身不是 `null`，
但其中包含为 `null` 的元素，
这些 `null` 元素仍然会被加入结果。

```dart
List<int>? a = null;
var b = [1, null, 3];
var items = [0, ...?a, ...?b, 4]; // [0, 1, null, 3, 4]
```

Because of null safety, you can't perform a
spread operation (`...`) on a value that might be null. The
following example produces a compile-time error because the 
`extraOptions` parameter is nullable and the
spread operator used on `extraOptions` is not null-aware.

由于空安全的存在，
你不能对可能为 null 的值执行展开操作（`...`）。
下面的例子会产生编译时错误，
因为 `extraOptions` 参数是可空的，
而用在 `extraOptions` 上的展开运算符不是空感知的。

<?code-excerpt "misc/test/language_tour/collections/null_spread_operator_in_collection_b.dart (code_sample)"?>
```dart tag=fails-sa
List<String> buildCommandLine(
  String executable,
  List<String> options, [
  List<String>? extraOptions,
]) {
  return [
    executable,
    ...options,
    ...extraOptions, // <-- Error
  ];
}

// Usage:
//   buildCommandLine('dart', ['run', 'my_script.dart'], null);
// Result:
//   Compile-time error
```

If you want to spread a nullable collection, use a
null-aware spread element. The following example is valid
because the null-aware spread operator is used on `extraOptions`.

如果要展开可空的集合，请使用空感知展开元素。
下面的例子是合法的，
因为 `extraOptions` 上用的是空感知展开运算符。

<?code-excerpt "misc/test/language_tour/collections/null_spread_operator_in_collection_a.dart (code_sample)"?>
```dart
List<String> buildCommandLine(
  String executable,
  List<String> options, [
  List<String>? extraOptions,
]) {
  return [
    executable,
    ...options,
    ...?extraOptions, // <-- OK now.
  ];
}

// Usage:
//   buildCommandLine('dart', ['run', 'my_script.dart'], null);
// Result:
//   [dart, run, my_script.dart]
```

To learn more about the null-aware spread operator, see
[Spread operator][].

要了解更多关于空感知展开运算符的内容，
请参阅 [展开运算符][Spread operator]。

[Spread operator]: /language/operators/#spread-operators

### If elements {: #if-element }

### if 元素

An `if` element conditionally evaluates an inner element
based on given a condition expression, and optionally
evaluates another `else` element if the condition is false.

`if` 元素根据给定的条件表达式
有条件地对内部元素求值，
条件为 false 时还可以对另一个 `else` 元素求值。

The `if` element has a few syntax variations:

`if` 元素有几种语法变体：

```dart
// If the bool expression is true, include the result.
if (<bool_expression>) <result>
```

```dart
// If the expression matches the pattern, include the result.
if (<expression> case <pattern>) <result>
```

```dart
// If the operation resolves as true, include the first
// result, otherwise, include the second result.
if (<bool_expression>) <result> else <result>
```

```dart
// If the operation resolves as true, include the first
// result, otherwise, include the second result.
if (<expression> case <pattern>) <result> else <result>
```

The following examples illustrate various ways that
you can use an `if` element inside of a collection with
a boolean expression:

下面的例子展示了在集合中
配合布尔表达式使用 `if` 元素的各种方式：

<?code-excerpt "misc/test/language_tour/collections/if_case_operator_in_collection_e.dart (code_sample)"?>
```dart
var includeItem = true;
var items = [0, if (includeItem) 1, 2, 3]; // [0, 1, 2, 3]
```

<?code-excerpt "misc/test/language_tour/collections/if_case_operator_in_collection_f.dart (code_sample)"?>
```dart
var includeItem = true;
var items = [0, if (!includeItem) 1, 2, 3]; // [0, 2, 3]
```

<?code-excerpt "misc/test/language_tour/collections/if_case_operator_in_collection_g.dart (code_sample)"?>
```dart
var name = 'apple';
var items = [0, if (name == 'orange') 1 else 10, 2, 3]; // [0, 10, 2, 3]
```

<?code-excerpt "misc/test/language_tour/collections/if_case_operator_in_collection_h.dart (code_sample)"?>
```dart
var name = 'apple';
var items = [
  0,
  if (name == 'kiwi') 1 else if (name == 'pear') 10,
  2,
  3,
]; // [0, 2, 3]
```

The following examples illustrate various ways that
you can use an `if` element with a `case` part inside of a
collection:

下面的例子展示了在集合中
使用带 `case` 部分的 `if` 元素的各种方式：

<?code-excerpt "misc/test/language_tour/collections/if_case_operator_in_collection_a.dart (code_sample)"?>
```dart
Object data = 123;
var typeInfo = [
  if (data case int i) 'Data is an integer: $i',
  if (data case String s) 'Data is a string: $s',
  if (data case bool b) 'Data is a boolean: $b',
  if (data case double d) 'Data is a double: $d',
]; // [Data is an integer: 123]
```

<?code-excerpt "misc/test/language_tour/collections/if_case_operator_in_collection_d.dart (code_sample)"?>
```dart
var word = 'hello';
var items = [
  1,
  if (word case String(length: var wordLength)) wordLength,
  3,
]; // [1, 5, 3]
```

<?code-excerpt "misc/test/language_tour/collections/if_case_operator_in_collection_b.dart (code_sample)"?>
```dart
var orderDetails = ['Apples', 12, ''];
var summary = [
  'Product: ${orderDetails[0]}',
  if (orderDetails case [_, int qty, _]) 'Quantity: $qty',
  if (orderDetails case [_, _, ''])
    'Delivery: Not Started'
  else
    'Delivery: In Progress',
]; // [Product: Apples, Quantity: 12, Delivery: Not Started]
```

You can mix different `if` operations with an `else if`
part. For example:

你可以用 `else if` 部分
混合不同的 `if` 操作。例如：

<?code-excerpt "misc/test/language_tour/collections/if_case_operator_in_collection_c.dart (code_sample)"?>
```dart
var a = 'apple';
var b = 'orange';
var c = 'mango';
var items = [
  0,
  if (a == 'apple') 1 else if (a case 'mango') 10,
  if (b case 'pear') 2 else if (b == 'mango') 20,
  if (c case 'apple') 3 else if (c case 'mango') 30,
  4,
]; // [0, 1, 30, 4]
```

To learn more about the `if` conditional, see
[`if` statement][]. To learn more about the `if-case`
conditional, see [`if-case` statement][].

要了解更多关于 `if` 条件的内容，
请参阅 [`if` 语句][`if` statement]。
要了解更多关于 `if-case` 条件的内容，
请参阅 [`if-case` 语句][`if-case` statement]。

[`if` statement]: /language/branches#if
[`if-case` statement]: /language/branches#if-case

### For elements {: #for-element }

### for 元素

A `for` element iterates and repeatedly evaluates a given
inner element, inserting zero or more resulting values.

`for` 元素迭代并反复对给定的内部元素求值，
插入零个或多个结果值。

A `for` element has this syntax in a collection:

`for` 元素在集合中的语法如下：

```dart
for (<expression> in <collection>) <result>
```

```dart
for (<initialization_clause>; <condition_clause>; <increment_clause>) <result>
```

The following examples illustrate various ways that
you can use a `for` element inside of a collection:

下面的例子展示了在集合中
使用 `for` 元素的各种方式：

<?code-excerpt "misc/test/language_tour/collections/for_loop_in_collection_a.dart (code_sample)"?>
```dart
var numbers = [2, 3, 4];
var items = [1, for (var n in numbers) n * n, 7]; // [1, 4, 9, 16, 7]
```

<?code-excerpt "misc/test/language_tour/collections/for_loop_in_collection_b.dart (code_sample)"?>
```dart
var items = [1, for (var x = 5; x > 2; x--) x, 7]; // [1, 5, 4, 3, 7]
```

<?code-excerpt "misc/test/language_tour/collections/for_loop_in_collection_c.dart (code_sample)"?>
```dart
var items = [1, for (var x = 2; x < 4; x++) x, 7]; // [1, 2, 3, 7]
```

To learn more about the `for` loop, see
[`for` loops][].

要了解更多关于 `for` 循环的内容，
请参阅 [`for` 循环][`for` loops]。

[`for` loops]: /language/loops/#for-loops

### Nest control flow elements {: #nesting-elements }

### 嵌套控制流元素

You can nest control flow elements within each other. This
is a powerful alternative to list comprehensions in other
languages.

控制流元素可以互相嵌套。
这是其他语言中列表推导式的强大替代方案。

In the following example, only the even numbers in
`numbers` are included in `items`.

在下面的例子中，
只有 `numbers` 中的偶数被包含进 `items`。

<?code-excerpt "misc/test/language_tour/collections/nesting_in_collection_a.dart (code_sample)"?>
```dart
var numbers = [1, 2, 3, 4, 5, 6, 7];
var items = [
  0,
  for (var n in numbers)
    if (n.isEven) n,
  8,
]; // [0, 2, 4, 6, 8]
```

It's common and idiomatic to use a spread on a collection
literal immediately inside of an `if` or `for` element. For
example:

在 `if` 或 `for` 元素内部紧接着
对集合字面量使用展开，
是常见且地道的写法。例如：

<?code-excerpt "misc/test/language_tour/collections/nesting_in_collection_c.dart (code_sample)"?>
```dart
var items = [
  if (condition) oneThing(),
  if (condition) ...[multiple(), things()],
]; // [oneThing, [multiple_a, multiple_b], things]
```

You can nest all kinds of elements arbitrarily deep.
In the following example, `if`, `for` and spread elements
are nested within each other in a collection:

各种元素都可以任意深度地嵌套。
在下面的例子中，`if`、`for` 和展开元素
在一个集合中互相嵌套：

<?code-excerpt "misc/test/language_tour/collections/nesting_in_collection_b.dart (code_sample)"?>
```dart
var nestItems = true;
var ys = [1, 2, 3, 4];
var items = [
  if (nestItems) ...[
    for (var x = 0; x < 3; x++)
      for (var y in ys)
        if (x < y) x + y * 10,
  ],
]; // [10, 20, 30, 40, 21, 31, 41, 32, 42]
```
