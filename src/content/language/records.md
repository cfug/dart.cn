---
# title: Records
title: 记录
# description: Summary of the record data structure in Dart.
description: "Dart 中记录 (record) 数据结构的概述。"
ai-translated: true
prevpage:
  url: /language/built-in-types
# title: Built-in types
  title: 基本类型
nextpage:
  url: /language/collections
# title: Collections
  title: 集合
---

:::version-note
  Records require a [language version][] of at least 3.0.

  记录 (record) 要求 [语言版本][language version] 至少为 3.0。
:::

Records are an anonymous, immutable, aggregate type. Like other [collection types][], 
they let you bundle multiple objects into a single object. Unlike other collection 
types, records are fixed-sized, heterogeneous, and typed.

记录 (record) 是一种匿名、不可变的聚合类型。
和其它 [集合类型][collection types] 一样，
它让你把多个对象打包成一个对象。
与其它集合类型不同的是，记录大小固定、元素类型可以不同，并且带有类型。

Records are real values; you can store them in variables, 
nest them, pass them to and from functions, 
and store them in data structures such as lists, maps, and sets.

记录是真正的值：你可以把它存进变量、嵌套使用、
在函数之间传入传出，
也可以放进列表、映射和集合这类数据结构里。

## Record syntax

## 记录语法

_Records expressions_ are comma-delimited lists of named or positional fields,
enclosed in parentheses:

**记录表达式** 是用逗号分隔的命名字段或位置字段列表，
并用圆括号括起来：

<?code-excerpt "language/test/records_test.dart (record-syntax)"?>
```dart
var record = ('first', a: 2, b: true, 'last');
```

_Record type annotations_ are comma-delimited lists of types enclosed in parentheses.
You can use record type annotations to define return types and parameter types.
For example, the following `(int, int)` statements are record type annotations:

**记录类型注解** 是用圆括号括起来、以逗号分隔的类型列表。
你可以用记录类型注解来定义返回类型和参数类型。
例如，下面这些 `(int, int)` 语句就是记录类型注解：

<?code-excerpt "language/test/records_test.dart (record-type-annotation)"?>
```dart
(int, int) swap((int, int) record) {
  var (a, b) = record;
  return (b, a);
}
```

Fields in record expressions and type annotations mirror
how [parameters and arguments][] work in functions. 
Positional fields go directly inside the parentheses:

记录表达式和类型注解中的字段，
与函数中 [参数和实参][parameters and arguments] 的写法相对应。
位置字段直接写在圆括号里：

<?code-excerpt "language/test/records_test.dart (record-type-declaration)"?>
```dart
// Record type annotation in a variable declaration:
(String, int) record;

// Initialize it with a record expression:
record = ('A string', 123);
```

In a record type annotation, named fields go inside a curly brace-delimited
section of type-and-name pairs, after all positional fields. In a record
expression, the names go before each field value with a colon after:

在记录类型注解中，命名字段放在花括号围起来的类型与名称配对区域里，
并且位于所有位置字段之后。
在记录表达式中，名称写在每个字段值之前，后面加冒号：

<?code-excerpt "language/test/records_test.dart (record-type-named-declaration)"?>
```dart
// Record type annotation in a variable declaration:
({int a, bool b}) record;

// Initialize it with a record expression:
record = (a: 123, b: true);
```

The names of named fields in a record type are part of
the [record's type definition](#record-types), or its _shape_. 
Two records with named fields with
different names have different types:

记录类型中命名字段的名称，是 [记录类型定义](#record-types)
（也就是它的 **形状**）的一部分。
两份命名字段名称不同的记录，类型也不同：

<?code-excerpt "language/test/records_test.dart (record-type-mismatched-names)"?>
```dart
({int a, int b}) recordAB = (a: 1, b: 2);
({int x, int y}) recordXY = (x: 3, y: 4);

// Compile error! These records don't have the same type.
// recordAB = recordXY;
```

In a record type annotation, you can also name the *positional* fields, but
these names are purely for documentation and don't affect the record's type:

在记录类型注解中，你也可以给 **位置** 字段起名，
但这些名称只用于文档，不影响记录的类型：

<?code-excerpt "language/test/records_test.dart (record-type-matched-names)"?>
```dart
(int a, int b) recordAB = (1, 2);
(int x, int y) recordXY = (3, 4);

recordAB = recordXY; // OK.
```

This is similar to how positional parameters
in a [function declaration or function typedef][function-type] can have names,
but those names don't affect the signature of the function.

这与 [函数声明或函数 typedef][function-type] 中的位置参数类似：
它们可以有名字，但这些名字不影响函数的签名。

For more information and examples, check out 
[Record types](#record-types) and [Record equality](#record-equality).

更多信息和示例，请查看
[记录类型](#record-types) 和 [记录相等性](#record-equality)。

## Record fields

## 记录字段

Record fields are accessible through built-in getters. Records are immutable,
so fields do not have setters. 

记录字段通过内置 getter 访问。记录是不可变的，
因此字段没有 setter。

Named fields expose getters of the same name. Positional fields expose getters
of the name `$<position>`, skipping named fields:

命名字段暴露同名 getter。位置字段暴露名为 `$<position>` 的 getter，
并且会跳过命名字段：

<?code-excerpt "language/test/records_test.dart (record-getters)"?>
```dart
var record = ('first', a: 2, b: true, 'last');

print(record.$1); // Prints 'first'
print(record.a); // Prints 2
print(record.b); // Prints true
print(record.$2); // Prints 'last'
```

To streamline record field access even more, 
check out the page on [Patterns][pattern].

若想进一步简化记录字段的访问，
请查看 [模式][pattern] 页面。

## Record types

## 记录类型

There is no type declaration for individual record types.
Records are structurally typed based on the types of their fields.
A record's _shape_ (the set of its fields, the fields' types,
and their names, if any) uniquely determines the type of a record.

单独的记录类型没有类型声明。
记录根据其字段的类型做结构化定型。
记录的 **形状**（字段集合、字段类型，以及字段名称（如果有））
唯一决定记录的类型。

Each field in a record has its own type. Field types can differ within the same
record. The type system is aware of each field's type wherever it is accessed
from the record:

记录中的每个字段都有自己的类型。同一条记录里的字段类型可以不同。
类型系统在从记录访问字段的每个位置，都知道该字段的类型：

<?code-excerpt "language/test/records_test.dart (record-getters-two)"?>
```dart
(num, Object) pair = (42, 'a');

var first = pair.$1; // Static type `num`, runtime type `int`.
var second = pair.$2; // Static type `Object`, runtime type `String`.
```

Consider two unrelated libraries that create records with the same set of fields.
The type system understands that those records are the same type even though the
libraries are not coupled to each other.

考虑两个互不相关的库，它们创建了字段集合相同的记录。
类型系统知道这些记录是同一类型，即使这些库彼此没有耦合。

:::tip
While you can't declare a unique type for a record shape,
you can create type aliases for readability and reuse.
To learn how and when to do so,
check out [Records and typedefs](#records-and-typedefs).

虽然不能为某种记录形状声明独特的类型，
但你可以创建类型别名，方便阅读和复用。
想了解如何做、何时做，
请查看 [记录与 typedef](#records-and-typedefs)。
:::

## Record equality

## 记录相等性

Two records are equal if they have the same _shape_ (set of fields),
and their corresponding fields have the same values.
Since named field _order_ is not part of a record's shape, the order of named
fields does not affect equality.

如果两条记录具有相同的 **形状**（字段集合），
并且对应字段的值相同，它们就相等。
命名字段的 **顺序** 不属于记录的形状，
因此命名字段的顺序不影响相等性。

For example:

例如：

<?code-excerpt "language/test/records_test.dart (record-shape)"?>
```dart
(int x, int y, int z) point = (1, 2, 3);
(int r, int g, int b) color = (1, 2, 3);

print(point == color); // Prints 'true'.
```

<?code-excerpt "language/test/records_test.dart (record-shape-mismatch)"?>
```dart
({int x, int y, int z}) point = (x: 1, y: 2, z: 3);
({int r, int g, int b}) color = (r: 1, g: 2, b: 3);

print(point == color); // Prints 'false'. Lint: Equals on unrelated types.
```

Records automatically define `hashCode` and `==` methods based on the structure
of their fields.

记录会根据字段结构自动定义 `hashCode` 和 `==` 方法。

## Multiple returns

## 多个返回值

Records allow functions to return multiple values bundled together.
To retrieve record values from a return,
[destructure][] the values into local variables using [pattern matching][pattern].

记录让函数可以把多个值打包后一起返回。
要从返回值中取出记录的值，
用 [模式匹配][pattern] 把这些值 [解构][destructure] 到局部变量中。

<?code-excerpt "language/test/records_test.dart (record-multiple-returns)"?>
```dart
// Returns multiple values in a record:
(String name, int age) userInfo(Map<String, dynamic> json) {
  return (json['name'] as String, json['age'] as int);
}

final json = <String, dynamic>{'name': 'Dash', 'age': 10, 'color': 'blue'};

// Destructures using a record pattern with positional fields:
var (name, age) = userInfo(json);

/* Equivalent to:
  var info = userInfo(json);
  var name = info.$1;
  var age  = info.$2;
*/
```

You can also destructure a record using its [named fields](#record-fields),
using the colon `:` syntax, which you can read more about on the
[Pattern types][] page:

你也可以用冒号 `:` 语法，按记录的 [命名字段](#record-fields) 来解构，
更多内容见 [模式类型][Pattern types] 页面：

<?code-excerpt "language/test/records_test.dart (record-name-destructure)"?>
```dart
({String name, int age}) userInfo(Map<String, dynamic> json)
// ···
// Destructures using a record pattern with named fields:
final (:name, :age) = userInfo(json);
```

You can return multiple values from a function without records,
but other methods come with downsides.
For example, creating a class is much more verbose, and using other collection
types like `List` or `Map` loses type safety. 

没有记录也可以从函数返回多个值，
但其它做法都有缺点。
例如，创建一个类要啰嗦得多，
而使用 `List` 或 `Map` 这类集合类型会失去类型安全。

:::note
Records' multiple-return and heterogeneous-type characteristics enable
parallelization of futures of different types, which you can read about in the
[`dart:async` documentation][].

记录的多返回值和异构类型这两个特点，
可以让不同类型的 future 并行执行。
详见 [`dart:async` 文档][`dart:async` documentation]。
:::

## Records as simple data structures

## 把记录用作简单数据结构

Records only hold data. When that's all you need,
they're immediately available and easy to use 
without needing to declare any new classes.
For a simple list of data tuples that all have the same shape,
a *list of records* is the most direct representation.

记录只保存数据。当这就是你需要的全部时，
它随手可用，也不必声明任何新类。
对于形状完全相同的简单数据元组列表，
**记录列表** 是最直接的表示。

Take this list of "button definitions", for example:

例如下面这份「按钮定义」列表：

```dart
final buttons = [
  (
    label: "Button I",
    icon: const Icon(Icons.upload_file),
    onPressed: () => print("Action -> Button I"),
  ),
  (
    label: "Button II",
    icon: const Icon(Icons.info),
    onPressed: () => print("Action -> Button II"),
  )
];
```

This code can be written directly without needing any additional declarations.

这段代码可以直接写下，不需要任何额外声明。

### Records and typedefs

### 记录与 typedef

You can choose to use [typedefs][] to give the record type itself a name,
and use that rather than writing out the full record type.
This method allows you to state that some fields can be null (`?`),
even if none of the current entries in the list have a null value.

你可以选用 [类型别名][typedefs] 给记录类型本身起一个名字，
然后使用这个名字，而不必写出完整的记录类型。
这样做可以标明某些字段可以为空（`?`），
即使列表里当前的条目都没有空值。

```dart
typedef ButtonItem = ({String label, Icon icon, void Function()? onPressed});
final List<ButtonItem> buttons = [
  // ...
];
```

Because record types are structural types, giving a name like `ButtonItem`
only introduces an alias that makes it easier to refer to the structural type: 
`({String label, Icon icon, void Function()? onPressed})`.

因为记录类型是结构化类型，像 `ButtonItem` 这样的名字
只是引入了一个别名，让人更容易引用这个结构化类型：
`({String label, Icon icon, void Function()? onPressed})`。

Having all your code refer to a record type by its alias makes it easier to
later change the record's implementation without needing to update every reference.

让所有代码都通过别名引用记录类型，
以后修改记录的实现时，就不必更新每一处引用。

Code can work with the given button definitions the same way it would
with simple class instances:

代码可以像使用简单的类实例一样，
使用给定的按钮定义：

```dart
List<Container> widget = [
  for (var button in buttons)
    Container(
      margin: const EdgeInsets.all(4.0),
      child: OutlinedButton.icon(
        onPressed: button.onPressed,
        icon: button.icon,
        label: Text(button.label),
      ),
    ),
];
```

You could even decide to later change the record type to a class type to add methods:

你甚至可以以后把记录类型改成类，以便添加方法：

```dart
class ButtonItem {
  final String label;
  final Icon icon;
  final void Function()? onPressed;
  ButtonItem({required this.label, required this.icon, this.onPressed});
  bool get hasOnPressed => onPressed != null;
}
```

Or to an [extension type][]:

或者改成 [扩展类型][extension type]：

```dart
extension type ButtonItem._(({String label, Icon icon, void Function()? onPressed}) _) {
  String get label => _.label;
  Icon get icon => _.icon;
  void Function()? get onPressed => _.onPressed;
  ButtonItem({required String label, required Icon icon, void Function()? onPressed})
      : this._((label: label, icon: icon, onPressed: onPressed));
  bool get hasOnPressed => _.onPressed != null;
}
```

And then create the list of button definitions using that type's constructors:

然后用该类型的构造函数创建按钮定义列表：

```dart
final List<ButtonItem> buttons =  [
  ButtonItem(
    label: "Button I",
    icon: const Icon(Icons.upload_file),
    onPressed: () => print("Action -> Button I"),
  ),
  ButtonItem(
    label: "Button II",
    icon: const Icon(Icons.info),
    onPressed: () => print("Action -> Button II"),
  )
];
```

Again, all while not needing to change the code that uses that list.

同样，使用该列表的代码完全不必修改。

Changing any type does require the code using it to be very careful about
not making assumptions. A type alias does not offer any protection or guarantee,
for the code using it as a reference, that the value being aliased is a record.
Extension types, also, offer little protection.
Only a class can provide full abstraction and encapsulation.

改动任何类型时，使用它的代码都必须非常小心，不能做多余的假设。
类型别名不会为把它当作引用的代码提供任何保护或保证，
不能保证被起别名的值一定是记录。
扩展类型提供的保护也很少。
只有类才能提供完整的抽象和封装。

[language version]: /language/versioning
[collection types]: /language/collections
[pattern]: /language/patterns#destructuring-multiple-returns
[`dart:async` documentation]: /libraries/dart-async#handling-errors-for-multiple-futures
[parameters and arguments]: /language/functions#parameters
[function-type]: /language/functions#function-types
[destructure]: /language/patterns#destructuring
[Pattern types]: /language/pattern-types#record
[typedefs]: /language/typedefs
[extension type]: /language/extension-types