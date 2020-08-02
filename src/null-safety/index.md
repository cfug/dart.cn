---
title: Sound null safety
description: Information about Dart's upcoming null safety feature
---

Sound null safety is coming to the Dart language!
When you opt into null safety,
types in your code are non-nullable by default, meaning that
values can’t be null _unless you say they can be._
With null safety, your **runtime** null-dereference errors
turn into **edit-time** analysis errors.

Dart 语言将要引入空安全声明了！
当您选择使用空安全时，代码中的类型将默认是非空的，
意味着**除非您声明它们可空**，它们的值都不能为空。
有了空安全，原本处于您的**运行时**的空值引用错误将变为**编译时**的分析错误。

With null safety,
the Dart analyzer enforces good practices.
For example, it makes sure you check for null before
reading a nullable variable.
And because Dart null safety is sound,
Dart compilers and runtimes can optimize away internal null checks,
so apps can be faster and smaller.

有了空安全，Dart 分析器可以进行更好的检查。
例如：它将在您读取一个可空的变量前提示您进行空检查。
由于 Dart 的空安全是十分有效的，
Dart 编译器和运行环境也同时可以通过优化减少内部的空安全检查，
这样应用就可以更快且更小。

{{ site.alert.important }}

  Because null safety is still in tech preview,
  **don't use null safety in production code.**
  In particular, the Flutter framework doesn't yet support null safety.
  Please test the feature using the Dart SDK,
  and [give us feedback.][]

  因为目前空安全仍然处于技术预览阶段，
  **请勿在生产环境使用空安全。**
  请注意，Flutter 目前尚未支持空安全。
  请通过 Dart SDK 测试这项特性，
  并且[给予我们反馈。][give us feedback.]

{{ site.alert.end }}

New operators and keywords related to null safety
include `?`, `!`, and `late`.
If you've used Kotlin, TypeScript, or C#,
the syntax for null safety might look familiar.
That's by design: the Dart language aims to be unsurprising.

与空安全相关的新操作符和关键词有 `?`、`!` 和 `late`。
如果您曾经使用过 Kotlin、TypeScript 或 C# 进行开发，
那么这些空安全的语法看起来会有些熟悉。
这是设计使然：Dart 语言的目标是不让您感到惊讶。

You can practice using null safety in the web app
[DartPad with Null Safety,][nullsafety.dartpad.dev]
shown in the following screenshot.
Or try null safety in your normal development environment,
using the instructions and configuration files in the
[null safety sample.][calculate_lix]

您可以通过下方截图中的[支持空声明的 DartPad][nullsafety.dartpad.dev]
进行练习。
或者按照[空安全示例][calculate_lix]中的指示和配置，在您的开发环境下
尝试空安全。

![Screenshot of DartPad null safety snippet with analysis errors](/null-safety/dartpad-snippet.png)
{% comment %}
[TODO: update that screenshot]
{% endcomment %}


## Creating variables

## 创建变量

When creating a variable,
you can use `?` and `late`
to inform Dart of the variable's nullability.

当您创建变量时，
您可以使用 `?` 和 `late`
告诉 Dart 这些变量是否可空。

Here are some examples of declaring **non-nullable variables**
(assuming you’ve opted into null safety):

以下是一些声明**非空变量**的例子
（假设您已经使用了空安全）：

```dart
// In null-safe Dart, none of these can ever be null.
var i = 42; // Inferred to be an int.
String name = getFileName();
final b = Foo();
```

If the variable _can_ have the value `null`,
**add `?`** to its type declaration:

如果这些变量**可以**为空值 ( `null` )，
在类型声明处**加上 `?`**。

```dart
int? aNullableInt = null;
```

If you know that a non-nullable variable will be
initialized to a non-null value before it's used,
but the Dart analyzer doesn't agree,
**insert `late`** before the variable's type:

如果您知道一个非空的变量将在使用前被初始化为一个非空的值，
又想让 Dart 的分析器同意这项行动，
那么您可以在变量的类型前**加上 `late`**。

```dart
class IntProvider {
  late int aRealInt;
  
  IntProvider() {
    aRealInt = calculate();
  }
}
```

The `late` keyword has two effects:

关键词 `late` 有两个作用：

* The analyzer doesn't require you to immediately initialize
  a `late` variable to a non-null value.

  分析器并不要求您立刻对使用 `late` 声明的变量初始化为非空值。

* The runtime lazily initializes the `late` variable.
  For example, if a non-nullable instance variable
  must be calculated,
  adding the `late` modifier delays the calculation
  until the first use of the instance variable.

  运行环境将懒加载 `late` 变量。
  例如：如果一个非空的实例变量必须被计算，
  那么 `late` 将会让它的计算延迟到首次使用再进行。

{% comment %}
PENDING: Say something about `late` variable initialization being lazy?

PENDING: Uncomment the following once we're ready to offer more guidance.

{{ site.alert.tip }}

  Avoid using `late final` unless you really need it.
  For example, prefer using an [initializer list][]
  to initialize instance variables.

  除非您真正需要 `late final`，否则请避免这样做。
  例如：推荐使用 [initializer list][] 来初始化实例变量。

{{ site.alert.end }}

[initializer list]: /guides/language/language-tour#initializer-list
{% endcomment %}


## Using variables and expressions

## 在变量和表达式中使用

With null safety, the Dart analyzer generates errors when
it finds a nullable value where a non-null value is required.
That isn't as bad as it sounds:
the analyzer can often recognize when
a variable or expression inside a function has
a nullable type but can't have a null value.

有了空安全，Dart 分析器会在要求非空而得到一个空值时抛出错误。
这并不像听起来那么糟糕：当函数内的一个变量或一条表达式为可空类型，
但不能有空值时，分析器通常也可以识别。

{{site.alert.info}}

  The analyzer can't model the flow of your whole application,
  so it can't predict the values of global variables or class fields.

  分析器不能对整个应用流程进行模拟，
  所以它并不能预测全局变量或者类的字段。

{{site.alert.end}}

When using a nullable variable or expression,
be sure to handle null values.
For example, you can use an `if` statement, the `??` operator,
or the `?.` operator to handle possible null values.

当您正在调用一个可空的变量或者表达式时，
请确保您自己处理了空值。
例如：您可以使用 `if` 条件句、`??` 操作符
或是 `?.` 操作符来处理可能为空的值。

Here's an example of using the [`??` operator][`??`]
to avoid setting a non-nullable variable to null:

下面是一个使用 [`??` 操作符][`??`]
来避免将非空变量赋予空值的例子。

```dart
int value = aNullableInt ?? 0; // 0 if it's null; otherwise, the integer
```

Here's similar code, but with an `if` statement that checks for null:

下面是一段类似的代码，但使用了 `if` 条件句来检查是否为空：

```dart
int definitelyInt(int? aNullableInt) {
  if (aNullableInt == null) {
    return 0;
  }
  return aNullableInt; // Can't be null!
}
```

If you're sure that an expression with a nullable type isn’t null,
you can add `!` to make Dart treat it as non-nullable:

如果您能确定一条可空的表达式不为空，
您可以在其后添加 `!` 让 Dart 处理为非空。

```dart
int? aNullableInt = 2;
int value = aNullableInt!; // `aNullableInt!` is an int.
// This throws if aNullableInt is null.
```

{{site.alert.important}}

  If you aren't positive that a value is non-null,
  **don't use the `!` operator**.

  如果您并不完全确定值为非空，
  **请不要使用 `!` 操作符。**

{{site.alert.end}}

If you need to change the type of a nullable variable —
beyond what the `!` operator can do —
you can use the [typecast operator (`as`)][`as`].
The following example uses `as` to convert a `num?` to an `int`:

如果您想改变一个可空变量的类型，
您可以使用[类型转换操作符 (`as`)][`as`]，
这是 `!` 操作符做不到的。
下面的例子使用了 `as` 将 `num?` 转换为 `int`。

```dart
return maybeNum() as int;
```

Once you opt into null safety,
you can't use the [member access operator (`.`)][other operators]
if the operand might be null.
Instead, you can use the null-aware version of that operator (`?.`):

一旦您开始使用空安全，
当操作对象可能为空时，您将不再能使用[成员访问符 (`.`)][other operators]。
取而代之的是可空版本的 `?.`。

```dart
double? d;  
print(d?.floor()); // Uses `?.` instead of `.` to invoke `floor()`.
```

## Understanding list, set, and map types

## 理解列表、集合及映射类型中的使用

Lists, sets, and maps are commonly used collection types in Dart programs,
so you need to know how they interact with null safety.
Here are some examples of how Dart code uses these collection types:

列表、集合和映射是 Dart 程序中常用的集合类型，
所以您会需要了解它们如何与空安全进行交互。
下面是一些 Dart 代码如何使用这些集合类型的例子：

* Flutter layout widgets such as [`Column`][]
  often have a `children` property that’s a
  `List` of `Widget` objects.

  Flutter 布局 widgets 中的 [`Column`][]
  拥有 `children` 属性，它是元素为 `Widget` 的 `List`。

* The [Veggie Seasons][] sample uses a `Set` of `VeggieCategory` to
  store a user’s food preferences.

  [Veggie Seasons][] 示例中使用了元素为 `VeggieCategory` 的 `Set`
  用于保存用户的食物偏好。

* The [GitHub Dataviz][] sample has a `fromJson()`method that
  creates an object from JSON data that’s supplied in a
  `Map<String, dynamic>`.

  [GitHub Dataviz][] 示例中的 `fromJson()` 方法会
  从类型为 `Map<String, dynamic>` 的 JSON 数据中
  创建一个实例。


[`Column`]: https://api.flutter.dev/flutter/widgets/Column-class.html
[Veggie Seasons]: https://github.com/flutter/samples/tree/master/veggieseasons
[GitHub Dataviz]: https://github.com/flutter/samples/tree/master/web/github_dataviz


### List and set types {#list-and-set-types}

### 列表和集合类型 {#list-and-set-types}

When you’re declaring the type of a list or set,
think about what can be null.
The following table shows the possibilities for a list of strings
if you opt into null safety.

当您在声明列表或集合类型时，
仔细思考什么可以为空。
下面的表格展示了使用了空安全的列表的可空可能性。

{% assign yes = '<b>Yes</b>' %}

|----------------------+----------------------------------+--------------------------+------------|
|<t>Type</t><t>类型</t> | <t>Can the list<br>be null?</t><t>列表能<br>为空吗？</t> | <t>Can an item (string)<br>be null?</t><t>元素 (string)<br>能为空吗</t> | <t>Description</t><t>描述</t>|
|------------------|----------------------------------|--------------------------|------------|
| `List<String>`   | No      | No      | <t>A non-null list that contains<br> non-null strings</t><t>一个包含非空字符串的<br>非空列表</t> |
| `List<String>?`  | {{yes}} | No      | <t>A list that **might be null** and that<br> contains non-null strings</t><t>一个包含非空字符串的<br>**可空**列表</t> |
| `List<String?>`  | No      | {{yes}} | <t>A non-null list that contains<br> strings that **might be null**</t><t>一个包含**可空**字符串的<br>非空列表</t> |
| `List<String?>?` | {{yes}} | {{yes}} | <t>A list that **might be null** and that<br> contains strings that **might be null**</t><t>一个包含**可空**字符串的<br>**可空**列表</t> |
{:.table .table-striped}

When a literal creates a list or set,
then instead of a type like in the table above,
you typically see a type annotation on the literal.
For example, here’s the code you might use to create
a variable (`nameList`) of type `List<String?>` and
a variable (`nameSet`) of type `Set<String?>`:

在通过字面量创建一个列表或集合时，通常您会看到字面量类型注解
而不是表格上面的类型声明。
例如下面的代码可以用于创建一个名为 `nameList` 的 `List<String?>`
和一个名为 `nameSet` 的 `Set<String?>`：

```dart
var nameList = <String?>['Andrew', 'Anjan', 'Anya'];
var nameSet = <String?>{'Andrew', 'Anjan', 'Anya'};
```

### Map types {#map-types}

### 映射类型 {#map-types}

Map types behave mostly like you’d expect, with one exception:
**the returned value of a lookup can be null**.
Null is the value for a key that isn't present in the map.

映射类型大部分会如您预期表现一致，除了一处不同：
**查询的返回值可能为空**。
当一个映射中并未出现包含某个 key 时，将会是空值。

As an example, look at the following code.
What do you think the value and type of `uhOh` are?

看看下面的示例代码。
您认为 `uhOh` 的类型和值会是什么呢？

```dart
var myMap = <String, int>{'one': 1};
var uhOh = myMap['two'];
```

The answer is that `uhOh` is null and has type `int?`. 

答案是 `uhOh` 是空值，类型为 `int?`。

Like lists and sets, maps can have a variety of types:

就像列表和集合一样，映射也会有一些不同的类型：

|----------------------+-------------------------------+-------------------------|
|<t>Type</t><t>类型</t> | <t>Can the map<br>be null?</t><t>映射能<br>为空吗？</t> | <t>Can an item (string)<br>be null?</t><t>元素 (string)<br>能为空吗</t> | <t>Description</t><t>描述</t>|
|----------------------|-------------------------------|-------------------------|
| `Map<String, int>`   | No                            | No*                     |
| `Map<String, int>?`  | {{yes}}                       | No*                     |
| `Map<String, int?>`  | No                            | {{yes}}                 |
| `Map<String, int?>?` | {{yes}}                       | {{yes}}                 |
{:.table .table-striped}

_\* Even when all the int values in the map are non-null,
when you use an invalid key to do a map lookup, the returned value is null._

**\* 尽管映射中的所有 int 值都是非空值，
但当您在查询时使用了无效的 key，返回的仍是空值。**

Because map lookups can return null,
you can't assign them to non-nullable variables:

由于映射查询可能返回空值，
您不能将其复制给非空变量：

```dart
// Assigning a lookup result to a non-nullable
// variable causes an error.
int value = <String, int>{'one': 1}['one']; // ERROR
```

{% comment %}
**[QUESTION: Will the analyzer ever be able to detect that is non-null?]**
{% endcomment %}

One workaround is to change the type of the variable to be nullable:

一个变通的方法是将变量的类型改为可空：

```dart
int? value = <String, int>{'one': 1}['one']; // OK
```

Another way to fix the problem —
if you're sure the lookup succeeds —
is to add a `!`:

如果您确定查询必定成功，
那么另一种避免问题的方法是加上 `!`：

```dart
int value = <String, int>{'one': 1}['one']!; // OK
```

A safer approach is to use the lookup value only if it's not null.
You can test its value using
an `if` statement or the [`??` operator][`??`].
Here's an example of using the value `0` if the lookup returns a null value:

更安全的实现是仅在查询结果不为空时使用结果。
您可以使用 `if` 条件句或者 [`??` 操作符][`??`]进行判断。
下面是当查询结果为空时使用 `0` 为值的一个例子：

```dart
var aList = <String, int>{'one': 1};
...
int value = aList['one'] ?? 0;
```


## Where to learn more

## 学习更多

For more information about null safety, see the following resources:

更多关于空安全的信息，请前往以下内容：

* [Dart announcements group][Dart announce]

  [Dart 公告小组 (Dart announcements group)][Dart announce]

* [Dart blog][]

  [Dart 博客 (Dart blog)][Dart blog]

* [DartPad with null safety][nullsafety.dartpad.dev]

  [支持空声明的 DartPad (DartPad with null safety)][nullsafety.dartpad.dev]

* [Null safety sample code][calculate_lix]

  [空安全示例代码 (Null safety sample code)][calculate_lix]

* [Null safety tracking issue][110]

  [空安全的问题跟踪 (Null safety tracking issue)][110]

[`??`]: /guides/language/language-tour#conditional-expressions
[110]: https://github.com/dart-lang/language/issues/110
[Announcing Dart 2.8]: https://medium.com/dartlang/announcing-dart-2-8-7750918db0a
[`as`]: /guides/language/language-tour#type-test-operators
[calculate_lix]: https://github.com/dart-lang/samples/tree/master/null_safety/calculate_lix
[Dart announce]: {{site.group}}/d/forum/announce
[Dart blog]: https://medium.com/dartlang
[give us feedback.]: https://github.com/dart-lang/sdk/issues/new?title=Null%20safety%20feedback:%20[issue%20summary]&labels=NNBD&body=Describe%20the%20issue%20or%20potential%20improvement%20in%20detail%20here
[nullsafety.dartpad.dev]: https://nullsafety.dartpad.dev
[other operators]: /guides/language/language-tour#other-operators
