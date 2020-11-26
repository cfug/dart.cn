---
title: Sound null safety
title: 健全的空安全
description: Information about Dart's upcoming null safety feature
description: Dart 即将到来的空安全的有关内容
---

Sound null safety — currently in beta — is coming to the Dart language!

健全的空安全机制目前已经到 Beta 阶段啦！

When you opt into null safety,
types in your code are non-nullable by default, meaning that
values can’t be null _unless you say they can be._
With null safety, your **runtime** null-dereference errors
turn into **edit-time** analysis errors.

当您选择使用空安全时，代码中的类型将默认是非空的，
意味着 **除非您声明它们可空**，它们的值都不能为空。
有了空安全，原本处于您的 **运行时** 的空值引用错误
将变为 **编辑时** 的分析错误。

You can
[try null safety in your normal development environment](#enable-null-safety),
[migrate your existing code][migration-guide] to use null safety,
or you can practice using null safety in the web app
[DartPad with Null Safety,][nullsafety.dartpad.dev]
shown in the following screenshot.

您可以 [在您的开发项目里尝试空安全](#enable-null-safety)、
[迁移您项目中的代码][migration-guide] 至空安全、
或者通过 [支持空安全的 DartPad][nullsafety.dartpad.dev] 进行练习，
如下面的截图所示。

![Screenshot of DartPad null safety snippet with analysis errors](/null-safety/dartpad-snippet.png)
{% comment %}
[TODO: update that screenshot]
{% endcomment %}

## Null safety principles

## 空安全的原则

Dart null safety support is based on the following three core design principles:

*  **Non-nullable by default**. Unless you explicitly tell Dart that a variable
   can be null, it's considered non-nullable. This default was chosen
   after research found that non-null was by far the most common choice in APIs.

   **默认即非空**。除非您将变量显式声明为可空，否则它一定是非空的类型。
   我们在研究后发现，非空是目前的 API 中最常见的选择，所以选择了非空作为默认值。

* **Incrementally adoptable**. You choose _what_ to migrate to null safety, and _when_.
  You can migrate incrementally, mixing null-safe and
  non-null-safe code in the same project. We provide tools to help you
  with the migration.

  **渐进迁移**。您可以自由地选择何时进行迁移，多少代码会进行迁移。
  您可以使用混合模式的空安全，在一个项目中同时使用空安全和非空安全的代码。
  我们也提供了帮助您进行迁移的工具。

* **Fully sound**. Dart’s null safety is sound, which enables compiler optimizations.
  If the type system determines that something isn’t null, then that thing can _never_ be
  null. Once you migrate your whole project
  and its dependencies to null safety, you reap the full benefits of soundness
  —- not only fewer bugs, but smaller binaries and faster execution.

  **完全可靠**。Dart 的空安全是非常可靠的，意味着编译期间包含了很多优化。
  如果类型系统推断出某个变量不为空，那么它 **永远** 不为空。
  当您将整个项目和其依赖完全迁移至空安全后，您会享有健全性带来的所有优势&mdash&mdash
  更少的 BUG，更小的二进制文件，以及更快的执行速度。

## A tour of the null safety feature

## 空安全特性概览

New operators and keywords related to null safety
include `?`, `!`, and `late`.
If you've used Kotlin, TypeScript, or C#,
the syntax for null safety might look familiar.
That's by design: the Dart language aims to be unsurprising.

空安全带来的新的操作符和关键词，包括 `?`、`!` 和 `late`。
如果您曾经使用过 Kotlin、TypeScript 或 C#，会发现语法非常相似。
这是设计使然：Dart 希望让您不会感到陌生和惊讶。

### Creating variables

### 创建变量

When creating a variable,
you can use `?` and `late`
to inform Dart of the variable's nullability.

当您创建变量时，
您可以使用 `?` 和 `late`
告诉 Dart 这些变量是否可空。

Here are some examples of declaring **non-nullable variables**
(assuming you’ve opted into null safety):

以下是一些声明 **非空变量** 的例子
（假设您已经使用了空安全）：

```dart
// In null-safe Dart, none of these can ever be null.
var i = 42; // Inferred to be an int.
String name = getFileName();
final b = Foo();
```

If the variable _can_ have the value `null`,
**add `?`** to its type declaration:

如果这些变量 **可以** 为 `null`，
在类型声明处 **加上 `?`**。

```dart
int? aNullableInt = null;
```

If you know that a non-nullable variable will be
initialized to a non-null value before it's used,
but the Dart analyzer doesn't agree,
**insert `late`** before the variable's type:

在您已经明确一个非空变量一定会在使用前初始化，
而 Dart 分析器仍然无法明确的情况下，
您可以在变量的类型前 **加上 `late`**：

<?code-excerpt "../null_safety_examples/basics/lib/late.dart (late_field)"?>
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


### Using variables and expressions

### 在变量和表达式中使用

With null safety, the Dart analyzer generates errors when
it finds a nullable value where a non-null value is required.
That isn't as bad as it sounds:
the analyzer can often recognize when
a variable or expression inside a function has
a nullable type but can't have a null value.

有了空安全，Dart 分析器会在要求非空而得到一个空值时抛出错误。
这并不像听起来那么糟糕。当函数内的一个变量或一句表达式为可空的类型，
但不能包含空值时，分析器通常也可以识别。

{{site.alert.info}}

  The analyzer can't model the flow of your whole application,
  so it can't predict the values of global variables or class fields.

  分析器不能对整个应用流程进行模拟，
  所以它并不能对全局变量或者类的字段进行推断。

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
  **请不要使用 `!` 操作符**。

{{site.alert.end}}

If you need to change the type of a nullable variable —
beyond what the `!` operator can do —
you can use the [typecast operator (`as`)][`as`].
The following example uses `as` to convert a `num?` to an `int`:

如果您想改变一个可空变量的类型，
您可以使用 [类型转换操作符 (`as`)][`as`]，
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
当操作对象可能为空时，您将不再能使用 [成员访问符 (`.`)][other operators]。
取而代之的是可空版本的 `?.`。

```dart
double? d;
print(d?.floor()); // Uses `?.` instead of `.` to invoke `floor()`.
```

### Understanding list, set, and map types

### 理解列表、集合及映射类型中的使用

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


[`Column`]: https://api.flutter-io.cn/flutter/widgets/Column-class.html
[Veggie Seasons]: https://github.com/flutter/samples/tree/master/veggieseasons
[GitHub Dataviz]: https://github.com/flutter/samples/tree/master/web/github_dataviz


#### List and set types {#list-and-set-types}

#### 列表和集合类型 {#list-and-set-types}

When you’re declaring the type of a list or set,
think about what can be null.
The following table shows the possibilities for a list of strings
if you opt into null safety.

当您在声明列表或集合类型时，
仔细思考什么可以为空。
下面的表格展示了使用了空安全的列表的可空可能性。

{% assign yes = '<b>Yes</b>' %}

|----------------------+----------------------------------+--------------------------+------------|
|<t>Type</t><t>类型</t> | <t>Can the list<br>be null?</t><t>列表能<br>为空吗？</t> | <t>Can an item (string)<br>be null?</t><t>元素 (string)<br>能为空吗？</t> | <t>Description</t><t>描述</t>|
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

在通过字面量创建一个列表或集合时，通常您会看到字面量类型注解，
而不是表格上面的类型声明。
例如下面的代码可以用于创建一个名为 `nameList` 的 `List<String?>`
和一个名为 `nameSet` 的 `Set<String?>`：

```dart
var nameList = <String?>['Andrew', 'Anjan', 'Anya'];
var nameSet = <String?>{'Andrew', 'Anjan', 'Anya'};
```

#### Map types {#map-types}

#### 映射类型 {#map-types}

Map types behave mostly like you’d expect, with one exception:
**the returned value of a lookup can be null**.
Null is the value for a key that isn't present in the map.

映射类型大部分会与您预期的表现一致，除了一处不同：
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
|<t>Type</t><t>类型</t> | <t>Can the map<br>be null?</t><t>映射能<br>为空吗？</t> | <t>Can an item (int)<br>be null?</t><t>元素 (int)<br>能为空吗？</t> |
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

由于映射查询可能返回空值，您不能将其传递给非空变量：

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
var aMap = <String, int>{'one': 1};
...
int value = aMap['one'] ?? 0;
```

## Enabling null safety {#enable-null-safety}

## 启用空安全

Null safety is currently a beta feature. 
We recommend requiring and using the **most recent beta channel** release
of the Dart or Flutter SDK.
To find the most recent releases, see the
[beta channel][dart-beta-channel] section of the
Dart SDK archive, or the **Beta channel** section of the
[Flutter SDK archive.][flutter-sdks]

空安全目前处于 beta 阶段。
我们建议您使用 **最新的 beta 版本** 的 Dart 和 Flutter SDK。
您可以在 Dart SDK 归档的 [beta 频道][dart-beta-channel] 和
[Flutter SDK 归档][Flutter SDK archive] 的 **beta 频道**
找到最新的 beta 版本。

Set the [SDK constraints](/tools/pub/pubspec#sdk-constraints)
to require a [language version][] that has null safety support.
For example, your `pubspec.yaml` file might have the following constraints:

将 [SDK 版本约束](/tools/pub/pubspec#sdk-constraints)
设定为一个支持空安全的 SDK 版本。
例如，您的 `pubspec.yaml` 可以设置为如下的限制：

{% prettify yaml tag=pre+code %}
environment:
  sdk: ">=2.12.0-0 <3.0.0"
{% endprettify %}

{{site.alert.note}}

  The 2.12 SDK constraint above ends in **`-0`**.
  This use of [semantic versioning notation](https://semver.org/)
  allows 2.12.0 prereleases, such as the `2.12.0-29.10.beta` beta prerelease.

  2.12 版本的 Dart SDK 限制以 **`-0`** 结尾。
  依据 [语义化版本定义](https://semver.org/) 制定的版本号使得 2.12.0 可以预发布，
  例如 `2.12.0-29.10.beta` 也可以是一个预览版本。

{{site.alert.end}}

If you find any issues with null safety please [give us feedback.][]

如果发现任何空安全的问题，请在 [这里向我们反馈][give us feedback.]。

[language version]: /guides/language/evolution#language-versioning


## Where to learn more

## 学习更多

For more information about null safety, see the following resources:

更多关于空安全的信息，请前往以下内容继续阅读：

* [Understanding null safety][]

  [深入了解空安全][Understanding null safety]
  
* [Migration guide for existing code][migration-guide]

  [空安全迁移指南][migration-guide]

* [Null safety FAQ][]

  [空安全常见问题和解答][Null safety FAQ]
  
* [DartPad with null safety][nullsafety.dartpad.dev]

  [支持空声明的 DartPad (DartPad with null safety)][nullsafety.dartpad.dev]

* [Null safety sample code][calculate_lix]

  [空安全示例代码 (Null safety sample code)][calculate_lix]

* [Null safety tracking issue][110]

  [空安全的问题跟踪 (Null safety tracking issue)][110]

* [Dart blog][]

  [Dart 官方博客)][Dart blog]

[`??`]: /guides/language/language-tour#conditional-expressions
[110]: https://github.com/dart-lang/language/issues/110
[Announcing Dart 2.8]: https://medium.com/dartlang/announcing-dart-2-8-7750918db0a
[`as`]: /guides/language/language-tour#type-test-operators
[calculate_lix]: https://github.com/dart-lang/samples/tree/master/null_safety/calculate_lix
[Dart announce]: {{site.group}}/d/forum/announce
[Dart blog]: https://medium.com/dartlang
[dart-beta-channel]: /tools/sdk/archive#beta-channel
[experiment-flags]: /tools/experiment-flags
[flutter-sdks]: {{site.flutter}}/docs/development/tools/sdk/releases
[give us feedback.]: https://github.com/dart-lang/sdk/issues/new?title=Null%20safety%20feedback:%20[issue%20summary]&labels=NNBD&body=Describe%20the%20issue%20or%20potential%20improvement%20in%20detail%20here
[nullsafety.dartpad.dev]: https://nullsafety.dartpad.cn
[other operators]: /guides/language/language-tour#other-operators
[Understanding null safety]: /null-safety/understanding-null-safety
[migration-guide]: /null-safety/migration-guide
[Null safety FAQ]: /null-safety/faq
