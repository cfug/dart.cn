---
title: Records
title: Records（记录）
description: Summary of the record data structure in Dart.
description: Dart 中 record 数据结构的概述。
prevpage:
  url: /language/built-in-types
  title: Built-in types
  title: 内置类型
nextpage:
  url: /language/collections
  title: Collections
  title: 集合
---

:::version-note
  Records require a [language version][] of at least 3.0.

  Records 需要至少 3.0 的 [语言版本][language version]。
:::

Records are an anonymous, immutable, aggregate type. Like other [collection types][],
they let you bundle multiple objects into a single object. Unlike other collection
types, records are fixed-sized, heterogeneous, and typed.

Records 是一种匿名、不可变的聚合类型。
与其他 [集合类型][collection types] 一样，它允许你将多个对象捆绑成一个对象。
与其他集合类型不同的是，records 是固定大小、异构且有类型的。

Records are real values; you can store them in variables,
nest them, pass them to and from functions,
and store them in data structures such as lists, maps, and sets.

Records 是真正的值；你可以将它们存储在变量中、嵌套它们、
在函数之间传递它们，并将它们存储在列表、映射和集合等数据结构中。

## Record syntax

## Record 语法

_Records expressions_ are comma-delimited lists of named or positional fields,
enclosed in parentheses:

**Record 表达式**是用逗号分隔的命名字段或位置字段列表，用括号括起来：

<?code-excerpt "language/test/records_test.dart (record-syntax)"?>
```dart
var record = ('first', a: 2, b: true, 'last');
```

_Record type annotations_ are comma-delimited lists of types enclosed in parentheses.
You can use record type annotations to define return types and parameter types.
For example, the following `(int, int)` statements are record type annotations:

**Record 类型注解**是用逗号分隔的类型列表，用括号括起来。
你可以使用 record 类型注解来定义返回类型和参数类型。
例如，以下 `(int, int)` 语句是 record 类型注解：

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

Record 表达式和类型注解中的字段镜像了函数中
[参数和实参][parameters and arguments] 的工作方式。
位置字段直接放在括号内：

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

在 record 类型注解中，命名字段放在所有位置字段之后的
大括号分隔的类型和名称对部分中。
在 record 表达式中，名称放在每个字段值之前，后面跟冒号：

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

Record 类型中命名字段的名称是
[record 类型定义](#record-types) 或其**形状**的一部分。
两个具有不同名称的命名字段的 records 具有不同的类型：

<?code-excerpt "language/test/records_test.dart (record-type-mismatched-names)"?>
```dart
({int a, int b}) recordAB = (a: 1, b: 2);
({int x, int y}) recordXY = (x: 3, y: 4);

// Compile error! These records don't have the same type.
// recordAB = recordXY;
```

In a record type annotation, you can also name the *positional* fields, but
these names are purely for documentation and don't affect the record's type:

在 record 类型注解中，你也可以命名**位置**字段，
但这些名称纯粹用于文档，不会影响 record 的类型：

<?code-excerpt "language/test/records_test.dart (record-type-matched-names)"?>
```dart
(int a, int b) recordAB = (1, 2);
(int x, int y) recordXY = (3, 4);

recordAB = recordXY; // OK.
```

This is similar to how positional parameters
in a [function declaration or function typedef][function-type]
can have names but those names don't affect the signature of the function.

这类似于 [函数声明或函数 typedef][function-type] 中的位置参数
可以有名称，但这些名称不会影响函数的签名。

For more information and examples, check out
[Record types](#record-types) and [Record equality](#record-equality).

有关更多信息和示例，请查看
[Record 类型](#record-types) 和 [Record 相等性](#record-equality)。

## Record fields

## Record 字段

Record fields are accessible through built-in getters. Records are immutable,
so fields do not have setters.

Record 字段可通过内置的 getter 访问。Records 是不可变的，因此字段没有 setter。

Named fields expose getters of the same name. Positional fields expose getters
of the name `$<position>`, skipping named fields:

命名字段暴露同名的 getter。位置字段暴露名为 `$<position>` 的 getter，跳过命名字段：

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

要进一步简化 record 字段访问，请查看 [模式][pattern] 页面。

## Record types

## Record 类型

There is no type declaration for individual record types.
Records are structurally typed based on the types of their fields.
A record's _shape_ (the set of its fields, the fields' types,
and their names, if any) uniquely determines the type of a record.

单个 record 类型没有类型声明。
Records 根据其字段的类型进行结构化类型定义。
Record 的**形状**（其字段集、字段类型及其名称，如果有的话）
唯一确定 record 的类型。

Each field in a record has its own type. Field types can differ within the same
record. The type system is aware of each field's type wherever it is accessed
from the record:

Record 中的每个字段都有自己的类型。
字段类型可以在同一个 record 中不同。
类型系统在从 record 访问的任何地方都知道每个字段的类型：

<?code-excerpt "language/test/records_test.dart (record-getters-two)"?>
```dart
(num, Object) pair = (42, 'a');

var first = pair.$1; // Static type `num`, runtime type `int`.
var second = pair.$2; // Static type `Object`, runtime type `String`.
```

Consider two unrelated libraries that create records with the same set of fields.
The type system understands that those records are the same type even though the
libraries are not coupled to each other.

考虑两个不相关的库创建具有相同字段集的 records。
类型系统理解这些 records 是相同的类型，即使这些库彼此之间没有耦合。

:::tip
While you can't declare a unique type for a record shape,
you can create type aliases for readability and reuse.
To learn how and when to do so,
check out [Records and typedefs](#records-and-typedefs).

虽然你不能为 record 形状声明唯一的类型，
但你可以创建类型别名以提高可读性和复用性。
要了解如何以及何时这样做，请查看 [Records 和 typedefs](#records-and-typedefs)。
:::

## Record equality

## Record 相等性

Two records are equal if they have the same _shape_ (set of fields),
and their corresponding fields have the same values.
Since named field _order_ is not part of a record's shape, the order of named
fields does not affect equality.

如果两个 records 具有相同的**形状**（字段集），
并且它们对应的字段具有相同的值，则它们相等。
由于命名字段的**顺序**不是 record 形状的一部分，
因此命名字段的顺序不会影响相等性。

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

Records 根据其字段的结构自动定义 `hashCode` 和 `==` 方法。

## Multiple returns

## 多返回值

Records allow functions to return multiple values bundled together.
To retrieve record values from a return,
[destructure][] the values into local variables using [pattern matching][pattern].

Records 允许函数返回捆绑在一起的多个值。
要从返回值中检索 record 值，请使用 [模式匹配][pattern]
将值 [解构][destructure] 到局部变量中。

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

你也可以使用 [命名字段](#record-fields) 来解构 record，
使用冒号 `:` 语法，你可以在 [模式类型][Pattern types] 页面上阅读更多相关内容：

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

你可以在不使用 records 的情况下从函数返回多个值，
但其他方法有缺点。
例如，创建一个类要冗长得多，而使用其他集合类型（如 `List` 或 `Map`）会失去类型安全。

:::note
Records' multiple-return and heterogeneous-type characteristics enable
parallelization of futures of different types, which you can read about in the
[`dart:async` documentation][].

Records 的多返回值和异构类型特性使得可以并行化不同类型的 futures，
你可以在 [`dart:async` 文档][`dart:async` documentation] 中阅读相关内容。
:::

## Records as simple data structures

## Records 作为简单数据结构

Records only hold data. When that's all you need,
they're immediately available and easy to use
without needing to declare any new classes.
For a simple list of data tuples that all have the same shape,
a *list of records* is the most direct representation.

Records 只保存数据。当这就是你所需要的一切时，
它们可以立即使用且易于使用，无需声明任何新类。
对于所有具有相同形状的数据元组的简单列表，
**record 列表**是最直接的表示方式。

Take this list of "button definitions", for example:

以这个"按钮定义"列表为例：

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

这段代码可以直接编写，无需任何额外的声明。

### Records and typedefs

### Records 和 typedefs

You can choose to use [typedefs][] to give the record type itself a name,
and use that rather than writing out the full record type.
This method allows you to state that some fields can be null (`?`),
even if none of the current entries in the list have a null value.

你可以选择使用 [typedefs][] 为 record 类型本身命名，
并使用该名称而不是写出完整的 record 类型。
这种方法允许你声明某些字段可以为空（`?`），
即使列表中当前没有任何条目具有空值。

```dart
typedef ButtonItem = ({String label, Icon icon, void Function()? onPressed});
final List<ButtonItem> buttons = [
  // ...
];
```

Because record types are structural types, giving a name like `ButtonItem`
only introduces an alias that makes it easier to refer to the structural type:
`({String label, Icon icon, void Function()? onPressed})`.

因为 record 类型是结构类型，所以给它一个像 `ButtonItem` 这样的名称
只是引入了一个别名，使得更容易引用结构类型：
`({String label, Icon icon, void Function()? onPressed})`。

Having all your code refer to a record type by its alias makes it easier to
later change the record's implementation without needing to update every reference.

让所有代码通过别名引用 record 类型，
可以更容易地在以后更改 record 的实现，而无需更新每个引用。

Code can work with the given button definitions the same way it would
with simple class instances:

代码可以像使用简单类实例一样使用给定的按钮定义：

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

你甚至可以决定稍后将 record 类型更改为类类型以添加方法：

```dart
class ButtonItem {
  final String label;
  final Icon icon;
  final void Function()? onPressed;
  ButtonItem({required this.label, required this.icon, this.onPressed});
  bool get hasOnpressed => onPressed != null;
}
```

Or to an [extension type][]:

或者改为 [扩展类型][extension type]：

```dart
extension type ButtonItem._(({String label, Icon icon, void Function()? onPressed}) _) {
  String get label => _.label;
  Icon get icon => _.icon;
  void Function()? get onPressed => _.onPressed;
  ButtonItem({required String label, required Icon icon, void Function()? onPressed})
      : this._((label: label, icon: icon, onPressed: onPressed));
  bool get hasOnpressed => _.onPressed != null;
}
```

And then create the list of button definitions using that type's constructors:

然后使用该类型的构造函数创建按钮定义列表：

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

同样，所有这些都不需要更改使用该列表的代码。

Changing any type does require the code using it to be very careful about
not making assumptions. A type alias does not offer any protection or guarantee,
for the code using it as a reference, that the value being aliased is a record.
Extension types, also, offer little protection.
Only a class can provide full abstraction and encapsulation.

更改任何类型确实需要使用它的代码非常小心，不要做出假设。
类型别名不为使用它作为引用的代码提供任何保护或保证，
不能保证被别名的值是 record。
扩展类型也提供很少的保护。
只有类才能提供完整的抽象和封装。

[language version]: /resources/language/evolution#language-versioning
[collection types]: /language/collections
[pattern]: /language/patterns#destructuring-multiple-returns
[`dart:async` documentation]: /libraries/dart-async#handling-errors-for-multiple-futures
[parameters and arguments]: /language/functions#parameters
[function-type]: /language/functions#function-types
[destructure]: /language/patterns#destructuring
[Pattern types]: /language/pattern-types#record
[typedefs]: /language/typedefs
[extension type]: /language/extension-types