---
title: Dart cheatsheet codelab
title: Dart 速查表 codelab
description: Interactively learn (or relearn) some of Dart's unique features.
description: 用交互的形式学习（或回顾）Dart 的独特之处。
js: [{url: 'https://dartpad.cn/inject_embed.dart.js', defer: true}]
---
<?code-excerpt replace="/ *\/\/\s+ignore_for_file:[^\n]+\n//g; /(^|\n) *\/\/\s+ignore:[^\n]+\n/$1/g; /(\n[^\n]+) *\/\/\s+ignore:[^\n]+\n/$1\n/g"?>

The Dart language is designed to be easy to learn for
coders coming from other languages,
but it has a few unique features.
This codelab — which is based on a
[Dart language cheatsheet](/guides/language/cheatsheet)
written by and for Google engineers —
walks you through the most important of these language features.

Dart 语言旨在让从其他编程语言转来的开发者们能够轻松学习，但也有它的独特之处。
本篇将基于谷歌工程师编写的
[Dart 语言速查表](/guides/language/cheatsheet)
为你介绍一些最重要的语言特性。

The embedded editors in this codelab have partially completed code snippets.
You can use these editors to test your knowledge by completing the code and
clicking the **Run** button.
If you need help, click the **Hint** button.
To run the code formatter ([dart format](/tools/dart-format)), click **Format**.
The **Reset** button erases your work and
restores the editor to its original state.

在这篇 codelab 中的嵌入式编辑器已经完成了部分代码片段。
你可以在这些编辑器上将代码补充完整，然后点击 **Run (运行)** 按钮进行测试。
如果你需要帮助，请点击 **Hint (提示)** 按钮。
要运行代码格式化 ([dart format](/tools/dartfmt))，
点击 **Format (格式化)** 按钮，**Reset (重置)** 按钮将会清除你的操作，
并把编辑器恢复到初始状态。

{{site.alert.note}}

  This page uses embedded DartPads to display runnable examples.
  
  本页面内嵌了一些 DartPads 做例子展示，

  {% include dartpads-embedded-troubleshooting.md %}
  
{{site.alert.end}}

## String interpolation

## 字符串插值

To put the value of an expression inside a string, use `${expression}`.
If the expression is an identifier, you can omit the `{}`.

为了将表达式的值放在字符串中，请使用 `${expression}`。若表达式为单个标识符，则可以省略 `{}`。

Here are some examples of using string interpolation:

下面是一些使用字符串插值的例子：

| String  | | Result |
|-----------------------------+-+ -------|
| 字符串  | | 结果 |
| `'${3 + 2}'`                | | `'5'` |
| `'${"word".toUpperCase()}'` | | `'WORD'` |
| `'$myObject'`               | | The value of `myObject.toString()`|
| `'$myObject'`               | | `myObject.toString()` 的值|

### Code example

### 代码样例

The following function takes two integers as parameters.
Make it return a string containing both integers separated by a space.
For example, `stringify(2, 3)` should return `'2 3'`.

下面的方法接收两个整形变量作为参数，
然后让它返回一个包含以空格分隔的整数的字符串。
例如，`stringify(2, 3)` 应该返回 `'2 3'`。

```dart:run-dartpad:ga_id-string_interpolation:null_safety-true
{$ begin main.dart $}
String stringify(int x, int y) {
  TODO('Return a formatted string here');
}
{$ end main.dart $}
{$ begin solution.dart $}
String stringify(int x, int y) {
  return '$x $y';
}
{$ end solution.dart $}
{$ begin test.dart $}

void main() {
  try {
    final str = stringify(2, 3); 

    if (str == '2 3') {
      _result(true);
    } else if (str == '23') {
      _result(false, ['Test failed. It looks like you forgot the space!']);
    } else {
      _result(false, ['That\'s not quite right. Keep trying!']);
    }
  } on UnimplementedError {
    _result(false, ['Test failed. Did you implement the method?']);
  } catch (e) {
    _result(false, ['Tried calling stringify(2, 3), but received an exception: ${e.runtimeType}']);
  }
}
{$ end test.dart $}
{$ begin hint.txt $}
Both x and y are simple values,
and Dart's string interpolation will handle
converting them to string representations.
All you need to do is use the $ operator to
reference them inside single quotes, with a space in between.
{$ end hint.txt $}
```

## Nullable variables

## 可空的变量

Dart 2.12 introduced sound null safety,
meaning that (when you [enable null safety][])
values can’t be null unless you say they can be.
In other words, types are non-nullable by default.

Dart 2.12 引入了健全的空安全，这意味着在您启用了空安全时，
除非变量显式声明为可空类型，否则它们将不能为空。
换句话说，类型默认是不可为空的。

For example, consider the following code,
which is **invalid** because (with null safety)
a variable of type `int` can't have the value `null`:

举个例子，下面的代码在空安全下是有错误的，
因为 `int` 类型的变量不能为 `null`：

{% prettify dart tag=pre+code %}
int a = [!null!]; // INVALID in null-safe Dart.
{% endprettify %}

When creating a variable in Dart 2.12 or higher,
you can add `?` to the type to indicate
that the variable can be null:

在 Dart 2.12 或更高版本的 Dart 中（需要限制 SDK 为 2.12 及以上），
你可以通过在类型后添加 `?` 来表示该类型可空：

{% prettify dart tag=pre+code %}
[!int?!] a = null; // Valid in null-safe Dart.
{% endprettify %}

You can simplify that code a bit because, in all versions of Dart,
`null` is the default value for uninitialized variables:

在所有 Dart 版本中，`null` 在未初始化的变量里都是默认值，
所以你可以这样简化你的代码：

{% prettify dart tag=pre+code %}
int? a; // The initial value of a is null.
{% endprettify %}

For more information about null safety in Dart,
read the [sound null safety guide](/null-safety).

想了解更多有关 Dart 的空安全的内容，请阅读 [健全的空安全](/null-safety)。

[enable null safety]: https://dart.cn/null-safety#enable-null-safety

### Code example

### 代码样例

Try to declare two variables below:

试着定义以下两种变量：

- A nullable `String` named `name` with the value `'Jane'`.

  一个可空的 `String`，名为 `name`，值为 `'Jane'`。

- A nullable `String` named `address` with the value `null`.

  一个可空的 `String`，名为 `address`，值为 `null`。

Ignore all initial errors in the DartPad.

可以忽略以下代码一开始在 DartPad 中的错误。

{% comment %}
TODO: Add new ga_id tag.
{% endcomment -%}
```dart:run-dartpad:null_safety-true
{$ begin main.dart $}
// Declare the two variables here
{$ end main.dart $}
{$ begin solution.dart $}
String? name = 'Jane';
String? address;
{$ end solution.dart $}
{$ begin test.dart $}

void main() {
  try {
    if (name == 'Jane' && address == null) {
      // verify that "name" is nullable
      name = null;
      _result(true);
    } else {
      _result(false, ['That\'s not quite right. Keep trying!']);
    }
  } catch (e) {
    _result(false, ['Tried calling stringify(2, 3), but received an exception: ${e.runtimeType}']);
  }
}
{$ end test.dart $}
{$ begin hint.txt $}
Declare the two variables as "String" followed by "?".
Then, assign "Jane" to "name"
and leave "address" uninitalized.
{$ end hint.txt $}
```

## Null-aware operators

## 避空运算符

Dart offers some handy operators for dealing with values that might be null. One is the
`??=` assignment operator, which assigns a value to a variable only if that
variable is currently null:

Dart 提供了一系列方便的运算符用于处理可能会为空值的变量。
其中一个是 `??=` 赋值运算符，仅当该变量为空值时才为其赋值：

{% comment %}
TBD: Make this and all non-trivial snippets testable.
{% endcomment %}

<?code-excerpt "misc/bin/null_aware_operators.dart (null-aware-operators)"?>
```dart
int? a; // = null
a ??= 3;
print(a); // <-- Prints 3.

a ??= 5;
print(a); // <-- Still prints 3.
```

Another null-aware operator is `??`,
which returns the expression on its left unless
that expression's value is null,
in which case it evaluates and returns the expression on its right:

另外一个避空运算符是 `??`，如果该运算符左边的表达式返回的是空值，
则会计算并返回右边的表达式。

<?code-excerpt "misc/bin/null_aware_operators.dart (null-aware-operators-2)"?>
```dart
print(1 ?? 3); // <-- Prints 1.
print(null ?? 12); // <-- Prints 12.
```

### Code example

### 代码样例

Try putting the `??=` and `??` operators to work below.

尝试在下面使用 `??=` 和 `??` 操作符。

Ignore all initial errors in the DartPad.

可以忽略以下代码一开始在 DartPad 中的错误。

```dart:run-dartpad:height-255px:ga_id-null_aware
{$ begin main.dart $}
String? foo = 'a string';
String? bar; // = null

// Substitute an operator that makes 'a string' be assigned to baz.
String? baz = foo /* TODO */ bar;

void updateSomeVars() {
  // Substitute an operator that makes 'a string' be assigned to bar.
  bar /* TODO */ 'a string';
}
{$ end main.dart $}
{$ begin solution.dart $}
String? foo = 'a string';
String? bar; // = null

// Substitute an operator that makes 'a string' be assigned to baz.
String? baz = foo ?? bar;

void updateSomeVars() {
  // Substitute an operator that makes 'a string' be assigned to bar.
  bar ??= 'a string';
}
{$ end solution.dart $}
{$ begin test.dart $}
void main() {
  final errs = <String>[];
  
  try {
    updateSomeVars();
    
    if (foo != 'a string') {
      errs.add('Looks like foo somehow ended up with the wrong value.');
    } else if (bar != 'a string') {
      errs.add('Looks like bar ended up with the wrong value.');
    } else if (baz != 'a string') {
      errs.add('Looks like baz ended up with the wrong value.');
    }
  } catch (e) {
    errs.add('Tried calling updateSomeVars and received an exception: ${e.runtimeType}.');
  }
  
  if (errs.isEmpty) {
   _result(true);
  } else {
    _result(false, errs);
  }
}
{$ end test.dart $}
{$ begin hint.txt $}
All you need to do in this exercise is
replace the TODO comments with either ?? or ??=.
Read the codelab text to make sure you understand both,
and then give it a try.
{$ end hint.txt $}
```


## Conditional property access

## 条件属性访问

To guard access to a property or method of an object that might be null,
put a question mark (`?`) before the dot (`.`):

要保护可能会为空的属性的正常访问，请在点（`.`）之前加一个问号（`?`）。

```dart
myObject?.someProperty
```

The preceding code is equivalent to the following:

上述代码等效于以下内容：

```dart
(myObject != null) ? myObject.someProperty : null
```

You can chain multiple uses of `?.` together in a single expression:

你可以在一个表达式中连续使用多个 `?.`：

```dart
myObject?.someProperty?.someMethod()
```

The preceding code returns null (and never calls `someMethod()`) if either
`myObject` or `myObject.someProperty` is
null.

如果 `myObject` 或 `myObject.someProperty` 为空，则前面的代码返回 null（并不再调用 `someMethod`）。

### Code example

### 代码样例

Try using conditional property access to finish the code snippet below.

尝试使用条件属性访问来完成下面的代码片段。

```dart:run-dartpad:ga_id-conditional-property_access:null_safety-true
{$ begin main.dart $}
// This method should return the uppercase version of `str`
// or null if `str` is null.
String? upperCaseIt(String? str) {
  // Try conditionally accessing the `toUpperCase` method here.
}
{$ end main.dart $}
{$ begin solution.dart $}
// This method should return the uppercase version of `str`
// or null if `str` is null.
String? upperCaseIt(String? str) {
  return str?.toUpperCase();
}
{$ end solution.dart $}
{$ begin test.dart $}
void main() {
  final errs = <String>[];
  
  try {
    String? one = upperCaseIt(null);

    if (one != null) {
      errs.add('Looks like you\'re not returning null for null inputs.');
    }
  } catch (e) {
    errs.add('Tried calling upperCaseIt(null) and got an exception: ${e.runtimeType}.');
  }
  
  try {
    String? two = upperCaseIt('asdf');

    if (two == null) {
      errs.add('Looks like you\'re returning null even when str has a value.');
    } else if (two != 'ASDF') {
      errs.add('Tried upperCaseIt(\'asdf\'), but didn\'t get \'ASDF\' in response.');
    }
  } catch (e) {
    errs.add('Tried calling upperCaseIt(\'asdf\') and got an exception: ${e.runtimeType}.');
  }
  
  if (errs.isEmpty) {
   _result(true);
  } else {
   _result(false, errs);
  }  
}
{$ end test.dart $}
{$ begin hint.txt $}
If this exercise wanted you to conditionally lowercase a string,
you could do it like this: str?.toLowerCase()
{$ end hint.txt $}
```

## Collection literals

## 集合字面量（Collection literals）

Dart has built-in support for lists, maps, and sets.
You can create them using literals:

Dart 内置了对 list、map 以及 set 的支持。
你可以通过字面量直接创建它们：

<?code-excerpt "misc/bin/cheatsheet/collection_literals.dart (collection-literals)"?>
```dart
final aListOfStrings = ['one', 'two', 'three'];
final aSetOfStrings = {'one', 'two', 'three'};
final aMapOfStringsToInts = {
  'one': 1,
  'two': 2,
  'three': 3,
};
```

Dart's type inference can assign types to these variables for you.
In this case, the inferred types are `List<String>`,
`Set<String>`, and `Map<String, int>`.

Dart 的类型推断可以自动帮你分配这些变量的类型。在这个例子中，推断类型是 `List<String>`、`Set<String>`和 `Map<String, int>`。

Or you can specify the type yourself:

你也可以手动指定类型：

<?code-excerpt "misc/bin/cheatsheet/collection_literals.dart (collection-literals-2)"?>
```dart
final aListOfInts = <int>[];
final aSetOfInts = <int>{};
final aMapOfIntToDouble = <int, double>{};
```

Specifying types is handy when you initialize a list with contents of a subtype,
but still want the list to be `List<BaseType>`:

在使用子类型的内容初始化列表，但仍希望列表为 `List <BaseType>` 时，指定其类型很方便：

<?code-excerpt "misc/bin/cheatsheet/collection_literals.dart (collection-literals-3)"?>
```dart
final aListOfBaseType = <BaseType>[SubType(), SubType()];
```

### Code example

### 代码样例

Try setting the following variables to the indicated values. Replace the existing null values.

尝试将以下变量设定为指定的值。替换当前的 null 值。

```dart:run-dartpad:height-400px:ga_id-collection_literals:null_safety-true
{$ begin main.dart $}
// Assign this a list containing 'a', 'b', and 'c' in that order:
final aListOfStrings = null;

// Assign this a set containing 3, 4, and 5:
final aSetOfInts = null;

// Assign this a map of String to int so that aMapOfStringsToInts['myKey'] returns 12:
final aMapOfStringsToInts = null;

// Assign this an empty List<double>:
final anEmptyListOfDouble = null;

// Assign this an empty Set<String>:
final anEmptySetOfString = null;

// Assign this an empty Map of double to int:
final anEmptyMapOfDoublesToInts = null;
{$ end main.dart $}
{$ begin solution.dart $}
// Assign this a list containing 'a', 'b', and 'c' in that order:
final aListOfStrings = ['a', 'b', 'c'];

// Assign this a set containing 3, 4, and 5:
final aSetOfInts = {3, 4, 5};

// Assign this a map of String to int so that aMapOfStringsToInts['myKey'] returns 12:
final aMapOfStringsToInts = {'myKey': 12};

// Assign this an empty List<double>:
final anEmptyListOfDouble = <double>[];

// Assign this an empty Set<String>:
final anEmptySetOfString = <String>{};

// Assign this an empty Map of double to int:
final anEmptyMapOfDoublesToInts = <double, int>{};
{$ end solution.dart $}
{$ begin test.dart $}
void main() {
  final errs = <String>[];
  
  if (aListOfStrings is! List<String>) {
    errs.add('aListOfStrings should have the type List<String>.');
  } else if (aListOfStrings.length != 3) {
    errs.add('aListOfStrings has ${aListOfStrings.length} items in it, rather than the expected 3.');
  } else if (aListOfStrings[0] != 'a' || aListOfStrings[1] != 'b' || aListOfStrings[2] != 'c') {
    errs.add('aListOfStrings doesn\'t contain the correct values (\'a\', \'b\', \'c\').');
  }

  if (aSetOfInts is! Set<int>) {
    errs.add('aSetOfInts should have the type Set<int>.');
  } else if (aSetOfInts.length != 3) {
    errs.add('aSetOfInts has ${aSetOfInts.length} items in it, rather than the expected 3.');
  } else if (!aSetOfInts.contains(3) || !aSetOfInts.contains(4) || !aSetOfInts.contains(5)) {
    errs.add('aSetOfInts doesn\'t contain the correct values (3, 4, 5).');
  }

  if (aMapOfStringsToInts is! Map<String, int>) {
    errs.add('aMapOfStringsToInts should have the type Map<String, int>.');
  } else if (aMapOfStringsToInts['myKey'] != 12) {
    errs.add('aMapOfStringsToInts doesn\'t contain the correct values (\'myKey\': 12).');
  }

  if (anEmptyListOfDouble is! List<double>) {
    errs.add('anEmptyListOfDouble should have the type List<double>.');
  } else if (anEmptyListOfDouble.isNotEmpty) {
    errs.add('anEmptyListOfDouble should be empty.');
  }

  if (anEmptySetOfString is! Set<String>) {
    errs.add('anEmptySetOfString should have the type Set<String>.');
  } else if (anEmptySetOfString.isNotEmpty) {
    errs.add('anEmptySetOfString should be empty.');
  }

  if (anEmptyMapOfDoublesToInts is! Map<double, int>) {
    errs.add('anEmptyMapOfDoublesToInts should have the type Map<double, int>.');
  } else if (anEmptyMapOfDoublesToInts.isNotEmpty) {
    errs.add('anEmptyMapOfDoublesToInts should be empty.');
  }

  if (errs.isEmpty) {
    _result(true);
  } else {
    _result(false, errs);
  }
}
{$ end test.dart $}
{$ begin hint.txt $}
This exercise is fairly straightforward.
Just add a list, set, or map literal after each equals sign.
See the codelab text for the correct syntax to use.
{$ end hint.txt $}
```

## Arrow syntax

## 箭头语法

You might have seen the `=>` symbol in Dart code.
This arrow syntax is a way to define a function that executes the
expression to its right and returns its value.

你也许已经在 Dart 代码中见到过 `=>` 符号。这种箭头语法是一种定义函数的方法，
该函数将在其右侧执行表达式并返回其值。

For example, consider this call to the `List` class's
`any()` method:

例如，考虑调用这个 `List` 类中的 `any` 方法：

<?code-excerpt "misc/bin/cheatsheet/arrow_functions.dart (has-empty-long)"?>
```dart
bool hasEmpty = aListOfStrings.any((s) {
  return s.isEmpty;
});
```

Here’s a simpler way to write that code:

这里是一个更简单的代码实现：

<?code-excerpt "misc/bin/cheatsheet/arrow_functions.dart (has-empty-short)"?>
```dart
bool hasEmpty = aListOfStrings.any((s) => s.isEmpty);
```

### Code example

### 代码样例

Try finishing the following statements, which use arrow syntax.

尝试使用箭头语法完成下面语句：

```dart:run-dartpad:height-345px:ga_id-arrow_syntax:null_safety-true
{$ begin main.dart $}
class MyClass {
  int value1 = 2;
  int value2 = 3;
  int value3 = 5;
  
  // Returns the product of the above values:
  int get product => TODO();
  
  // Adds 1 to value1:
  void incrementValue1() => TODO();
  
  // Returns a string containing each item in the
  // list, separated by commas (e.g. 'a,b,c'): 
  String joinWithCommas(List<String> strings) => TODO();
}
{$ end main.dart $}
{$ begin solution.dart $}
class MyClass {
  int value1 = 2;
  int value2 = 3;
  int value3 = 5;

  // Returns the product of the above values:
  int get product => value1 * value2 * value3;
  
  // Adds 1 to value1:
  void incrementValue1() => value1++; 
  
  // Returns a string containing each item in the
  // list, separated by commas (e.g. 'a,b,c'): 
  String joinWithCommas(List<String> strings) => strings.join(',');
}
{$ end solution.dart $}
{$ begin test.dart $}
void main() {
  final obj = MyClass();
  final errs = <String>[];
  
  try {
    final product = obj.product;
    
    if (product != 30) {
      errs.add('The product property returned $product instead of the expected value (30).'); 
    } 
  } on UnimplementedError {
    _result(false, ['Tried to use MyClass.product but failed. Did you implement the method?']);
    return;
  } catch (e) {
    _result(false, ['Tried to use MyClass.product, but encountered an exception: ${e.runtimeType}.']);
    return;
  }

  try {
    obj.incrementValue1();
    
    if (obj.value1 != 3) {
      errs.add('After calling incrementValue, value1 was ${obj.value1} instead of the expected value (3).'); 
    } 
  } on UnimplementedError {
    _result(false, ['Tried to use MyClass.incrementValue1 but failed. Did you implement the method?']);
    return;
  } catch (e) {
    _result(false, ['Tried to use MyClass.incrementValue1, but encountered an exception: ${e.runtimeType}.']);
    return;
  }

  try {
    final joined = obj.joinWithCommas(['one', 'two', 'three']);
    
    if (joined != 'one,two,three') {
      errs.add('Tried calling joinWithCommas([\'one\', \'two\', \'three\']) and received $joined instead of the expected value (\'one,two,three\').'); 
    } 
  } on UnimplementedError {
    _result(false, ['Tried to use MyClass.joinWithCommas but failed. Did you implement the method?']);
    return;
  } catch (e) {
    _result(false, ['Tried to use MyClass.joinWithCommas, but encountered an exception: ${e.runtimeType}.']);
    return;
  }

  if (errs.isEmpty) {
    _result(true);
  } else {
    _result(false, errs);
  }
}
{$ end test.dart $}
{$ begin hint.txt $}
For the product, you can just multiply the three values together.
For incrementValue1, you can use the increment operator (++).
For joinWithCommas, try using the join method found in the List class.
{$ end hint.txt $}
```

## Cascades

## 级连

To perform a sequence of operations on the same object, use cascades (`..`).
We've all seen an expression like this:

要对同一对象执行一系列操作，请使用级联（`..`）。我们都看到过这样的表达式：

<?code-excerpt "misc/bin/cheatsheet/cascades.dart (no-cascade)" replace="/;//g"?>
```dart
myObject.someMethod()
```

It invokes `someMethod()` on `myObject`, and the result of
the expression is the return value of `someMethod()`.

它在 `myObject` 上调用 `someMethod` 方法，而表达式的结果是 `someMethod` 的返回值。

Here's the same expression with a cascade:

下面是一个使用级连语法的相同表达式：

<?code-excerpt "misc/bin/cheatsheet/cascades.dart (uses-cascade)" replace="/;//g"?>
```dart
myObject..someMethod()
```

Although it still invokes `someMethod()` on `myObject`, the result
of the expression **isn't** the return value — it's a reference to `myObject`!

Using cascades, you can chain together operations that
would otherwise require separate statements.
For example, consider the following code,
which uses the conditional member access operator (`?.`)
to read properties of `button` if it isn't `null`:

虽然它仍然在 `myObject` 上调用了 `someMethod`，
但表达式的结果却**不是**该方法返回值，
而是是 `myObject` 对象的引用！
使用级联，你可以将需要单独操作的语句链接在一起。
例如，请考虑以下代码：

<?code-excerpt "misc/bin/cheatsheet/cascades.dart (query-without-cascades)"?>
```dart
var button = querySelector('#confirm');
button?.text = 'Confirm';
button?.classes.add('important');
button?.onClick.listen((e) => window.alert('Confirmed!'));
```

To instead use cascades, 
you can start with the _null-shorting_ cascade (`?..`), 
which guarantees that none of the cascade operations
are attempted on a `null` object.
Using cascades shortens the code
and makes the `button` variable unnecessary:

使用级连能够让代码变得更加简洁，而且你也不再需要 `button` 变量了。

<?code-excerpt "misc/bin/cheatsheet/cascades.dart (query-with-cascades)"?>
```dart
querySelector('#confirm')
  ?..text = 'Confirm'
  ..classes.add('important')
  ..onClick.listen((e) => window.alert('Confirmed!'));
```

### Code example

### 代码样例

Use cascades to create a single statement that
sets the `anInt`, `aString`, and `aList` properties of a `BigObject`
to `1`, `'String!'`, and `[3.0]` (respectively)
and then calls `allDone()`.

使用级联创建一个语句，
分别将 `BigObject` 的 `anInt` 属性设为 `1`、`aString` 
属性设为 `String!`、`aList` 属性设置为
`[3.0]` 然后调用 `allDone()`。

```dart:run-dartpad:height-345px:ga_id-cascades:null_safety-true
{$ begin main.dart $}
class BigObject {
  int anInt = 0;
  String aString = '';
  List<double> aList = [];
  bool _done = false;
  
  void allDone() {
    _done = true;
  }
}

BigObject fillBigObject(BigObject obj) {
  // Create a single statement that will update and return obj:
  return TODO('obj..');
}
{$ end main.dart $}
{$ begin solution.dart $}
class BigObject {
  int anInt = 0;
  String aString = '';
  List<double> aList = [];
  bool _done = false;
  
  void allDone() {
    _done = true;
  }
}

BigObject fillBigObject(BigObject obj) {
  return obj
    ..anInt = 1
    ..aString = 'String!'
    ..aList.add(3)
    ..allDone();
}
{$ end solution.dart $}
{$ begin test.dart $}
void main() {
  BigObject obj;

  try {
    obj = fillBigObject(BigObject());
  } on UnimplementedError {
    _result(false, ['Tried to call fillBigObject but failed. Did you implement the method?']);
    return;
  } catch (e) {
    _result(false, [
      'Caught an exception of type ${e.runtimeType} while running fillBigObject'
    ]);
    return;
  }

  final errs = <String>[];

  if (obj.anInt != 1) {
    errs.add(
        'The value of anInt was ${obj.anInt} rather than the expected (1).');
  }

  if (obj.aString != 'String!') {
    errs.add(
        'The value of aString was \'${obj.aString}\' rather than the expected (\'String!\').');
  }

  if (obj.aList.length != 1) {
    errs.add(
        'The length of aList was ${obj.aList.length} rather than the expected value (1).');
  } else {
    if (obj.aList[0] != 3.0) {
      errs.add(
          'The value found in aList was ${obj.aList[0]} rather than the expected (3.0).');
    }
  }
  
  if (!obj._done) {
    errs.add('It looks like allDone() wasn\'t called.');
  }

  if (errs.isEmpty) {
    _result(true);
  } else {
    _result(false, errs);
  }
}
{$ end test.dart $}
{$ begin hint.txt $}
The best solution for this exercise starts with obj.. and
has four assignment operations chained together.
Try starting with `return obj..anInt = 1`,
then add another cascade (..) and start the next assignment.
{$ end hint.txt $}
```


## Getters and setters

You can define getters and setters
whenever you need more control over a property
than a simple field allows.

任何需要对属性进行更多控制而不是允许简单字段访问的时候，你都可以自定义 getter 和 setter。

For example, you can make sure a property's value is valid:

例如，你可以用来确保属性值合法：

<?code-excerpt "misc/bin/cheatsheet/getters_setters.dart"?>
```dart
class MyClass {
  int _aProperty = 0;

  int get aProperty => _aProperty;

  set aProperty(int value) {
    if (value >= 0) {
      _aProperty = value;
    }
  }
}
```

You can also use a getter to define a computed property:

你还可以使用 getter 来定义计算属性：

<?code-excerpt "misc/bin/cheatsheet/getter_compute.dart"?>
```dart
class MyClass {
  final List<int> _values = [];

  void addValue(int value) {
    _values.add(value);
  }

  // A computed property.
  int get count {
    return _values.length;
  }
}
```

### Code example

### 代码样例

Imagine you have a shopping cart class that keeps a private `List<double>`
of prices.
Add the following:

想象你有一个购物车类，其中有一个私有的 `List<double>` 类型的 prices 属性。添加以下内容：

* A getter called `total` that returns the sum of the prices

  一个名为 `total` 的 getter，用于返回总价格。

* A setter that replaces the list with a new one,
  as long as the new list doesn't contain any negative prices
  (in which case the setter should throw an `InvalidPriceException`).

  只要新列表不包含任何负价格，
  setter 就会用新的列表替换列表
  （在这种情况下，setter 应该抛出 `InvalidPriceException`）。

Ignore all initial errors in the DartPad.

可以忽略以下代码一开始在 DartPad 中的错误。

```dart:run-dartpad:height-240px:ga_id-getters_setters:null_safety-true
{$ begin main.dart $}
class InvalidPriceException {}

class ShoppingCart {
  List<double> _prices = [];
  
  // Add a "total" getter here:

  // Add a "prices" setter here:
}
{$ end main.dart $}
{$ begin solution.dart $}
class InvalidPriceException {}

class ShoppingCart {
  List<double> _prices = [];
  
  double get total => _prices.fold(0, (e, t) => e + t);
  
  set prices(List<double> value) {
    if (value.any((p) => p < 0)) {
      throw InvalidPriceException();
    }
    
    _prices = value;
  }
}
{$ end solution.dart $}
{$ begin test.dart $}
void main() {
  var foundException = false;
  
  try {
    final cart = ShoppingCart();
    cart.prices = [12.0, 12.0, -23.0];
  } on InvalidPriceException {
    foundException = true;
  } catch (e) {
    _result(false, ['Tried setting a negative price and received a ${e.runtimeType} instead of an InvalidPriceException.']);
    return;
  }
  
  if (!foundException) {
    _result(false, ['Tried setting a negative price and didn\'t get an InvalidPriceException.']);
    return;
  }
  
  final secondCart = ShoppingCart();
  
  try {
    secondCart.prices = [1.0, 2.0, 3.0];
  } catch(e) {
    _result(false, ['Tried setting prices with a valid list, but received an exception: ${e.runtimeType}.']);
    return;
  }
  
  if (secondCart._prices.length != 3) {
    _result(false, ['Tried setting prices with a list of three values, but _prices ended up having length ${secondCart._prices.length}.']);
    return;
  }

  if (secondCart._prices[0] != 1.0 || secondCart._prices[1] != 2.0 || secondCart._prices[2] != 3.0) {
    final vals = secondCart._prices.map((p) => p.toString()).join(', ');
    _result(false, ['Tried setting prices with a list of three values (1, 2, 3), but incorrect ones ended up in the price list ($vals) .']);
    return;
  }
  
  var sum = 0.0;
  
  try {
    sum = secondCart.total;
  } catch (e) {
    _result(false, ['Tried to get total, but received an exception: ${e.runtimeType}.']);
    return;
  }
  
  if (sum != 6.0) {
    _result(false, ['After setting prices to (1, 2, 3), total returned $sum instead of 6.']);
    return;
  }
  
  _result(true);
}
{$ end test.dart $}
{$ begin hint.txt $}
Two functions are handy for this exercise. 
One is `fold`, which can reduce a list to a single value
(try it to calculate the total).
The other is `any`, which can check each item in a list
with a function you give it
(try using it to check if there are any negative prices in the prices setter).
{$ end hint.txt $}
```


## Optional positional parameters

## 可选位置参数

Dart has two kinds of function parameters: positional and named. Positional parameters are the kind
you're likely familiar with:

Dart 有两种传参方法：位置参数和命名参数。位置参数你可能会比较熟悉：

<?code-excerpt "misc/bin/optional_positional_args.dart (optional-positional-args)"?>
```dart
int sumUp(int a, int b, int c) {
  return a + b + c;
}
// ···
  int total = sumUp(1, 2, 3);
```

With Dart, you can make these positional parameters optional by wrapping them in brackets:

在 Dart 里，你可以将这些参数包裹在方括号中，使其变成可选位置参数：

<?code-excerpt "misc/bin/optional_positional_args.dart (optional-positional-args-2)" replace="/total2/total/g"?>
```dart
int sumUpToFive(int a, [int? b, int? c, int? d, int? e]) {
  int sum = a;
  if (b != null) sum += b;
  if (c != null) sum += c;
  if (d != null) sum += d;
  if (e != null) sum += e;
  return sum;
}
// ···
  int total = sumUpToFive(1, 2);
  int otherTotal = sumUpToFive(1, 2, 3, 4, 5);
```

Optional positional parameters are always last
in a function's parameter list.
Their default value is null unless you provide another default value:

可选位置参数永远放在方法参数列表的最后。
除非你给它们提供一个默认值，否则默认为 null:

<?code-excerpt "misc/bin/optional_positional_args2.dart"?>
```dart
int sumUpToFive(int a, [int b = 2, int c = 3, int d = 4, int e = 5]) {
// ···
}
// ···
  int newTotal = sumUpToFive(1);
  print(newTotal); // <-- prints 15
```

### Code example

### 代码样例

Implement a function called `joinWithCommas()` that accepts one to
five integers, then returns a string of those numbers separated by commas.
Here are some examples of function calls and returned values:

实现一个名为 `joinWithCommas` 的方法，它接收一至五个整数，
然后返回由逗号分隔的包含这些数字的字符串。
以下是方法调用和返回值的一些示例：

| <t>Function call</t><t>方法调用</t> | | <t>Returned value</t><t>返回值</t> |
|---------------------------------+-+----------------|
| `joinWithCommas(1)`             | | `'1'`          |
| `joinWithCommas(1, 2, 3)`       | | `'1,2,3'`      |
| `joinWithCommas(1, 1, 1, 1, 1)` | | `'1,1,1,1,1'`  |

<br>

```dart:run-dartpad:ga_id-optional_positional_parameters:null_safety-true
{$ begin main.dart $}
String joinWithCommas(int a, [int? b, int? c, int? d, int? e]) {
  return TODO();
}
{$ end main.dart $}
{$ begin solution.dart $}
String joinWithCommas(int a, [int? b, int? c, int? d, int? e]) {
  var total = '$a';
  if (b != null) total = '$total,$b';
  if (c != null) total = '$total,$c';
  if (d != null) total = '$total,$d';
  if (e != null) total = '$total,$e';
  return total;
}
{$ end solution.dart $}
{$ begin test.dart $}
void main() {
  final errs = <String>[];
  
  try {
    final value = joinWithCommas(1);
    
    if (value != '1') {
      errs.add('Tried calling joinWithCommas(1) and got $value instead of the expected (\'1\').'); 
    } 
  } on UnimplementedError {
    _result(false, ['Tried to call joinWithCommas but failed. Did you implement the method?']);
    return;
  } catch (e) {
    _result(false, ['Tried calling joinWithCommas(1), but encountered an exception: ${e.runtimeType}.']);
    return;
  }

  try {
    final value = joinWithCommas(1, 2, 3);
    
    if (value != '1,2,3') {
      errs.add('Tried calling joinWithCommas(1, 2, 3) and got $value instead of the expected (\'1,2,3\').'); 
    } 
  } on UnimplementedError {
    _result(false, ['Tried to call joinWithCommas but failed. Did you implement the method?']);
    return;
  } catch (e) {
    _result(false, ['Tried calling joinWithCommas(1, 2 ,3), but encountered an exception: ${e.runtimeType}.']);
    return;
  }

  try {
    final value = joinWithCommas(1, 2, 3, 4, 5);
    
    if (value != '1,2,3,4,5') {
      errs.add('Tried calling joinWithCommas(1, 2, 3, 4, 5) and got $value instead of the expected (\'1,2,3,4,5\').'); 
    } 
  } on UnimplementedError {
    _result(false, ['Tried to call joinWithCommas but failed. Did you implement the method?']);
    return;
  } catch (e) {
    _result(false, ['Tried calling stringify(1, 2, 3, 4 ,5), but encountered an exception: ${e.runtimeType}.']);
    return;
  }

  if (errs.isEmpty) {
    _result(true);
  } else {
    _result(false, errs);
  }
}
{$ end test.dart $}
{$ begin hint.txt $}
The b, c, d, and e paramters are null if they aren't provided by caller.
The important thing, then, is to check whether those arguments are null
before you add them to the final string.
{$ end hint.txt $}
```


## Optional named parameters

## 可选命名参数

Using a curly brace syntax,
you can define optional parameters that have names.

你可以使用大括号语法定义可选命名参数。

<?code-excerpt "misc/bin/optional_named_params.dart"?>
```dart
void printName(String firstName, String lastName, {String? suffix}) {
  print('$firstName $lastName ${suffix ?? ''}');
}
// ···
  printName('Avinash', 'Gupta');
  printName('Poshmeister', 'Moneybuckets', suffix: 'IV');
```

As you might expect,
the default value of an optional named parameter is `null`,
but you can provide a default value.

正如你所料，这些参数默认为 null，但你也可以为其提供默认值。

If the type of a parameter is non-nullable,
then you must either provide a default value
(as shown in the following code)
or mark the parameter as `required`
(as shown in the
[constructor section](#using-this-in-a-constructor)).

如果一个参数的类型是非空的，那么你必须要提供一个默认值（如下方代码所示），
或者将其标记为 `required`（如 [构造部分](#using-this-in-a-constructor)所示）。

{% prettify dart tag=pre+code %}
void printName(String firstName, String lastName, {String suffix[! = ''!]}) {
  print('$firstName $lastName $suffix');
}
{% endprettify %}

A function can't have both optional positional and optional named parameters.

一个方法不能同时使用可选位置参数和可选命名参数。

### Code example

### 代码样例

Add a `copyWith()` instance method to the `MyDataObject`
class. It should take three named, nullable parameters:

向 `MyDataObject` 类添加一个 `copyWith()` 实例方法，
它应该包含三个可空的命名参数。

* `int? newInt`
* `String? newString`
* `double? newDouble`

Your `copyWith()` method should return a new `MyDataObject`
based on the current instance,
with data from the preceding parameters (if any)
copied into the object's properties.
For example, if `newInt` is non-null,
then copy its value into `anInt`.

`copyWith` 方法应该根据当前实例返回一个新的
`MyDataObject` 并将前面参数（如果有的话）的数据复制到对象的属性中。
例如，如果 `newInt` 不为空，则将其值复制到 `anInt` 中。

Ignore all initial errors in the DartPad.

可以忽略以下代码一开始在 DartPad 中的错误。

```dart:run-dartpad:height-310px:ga_id-optional_named_parameters:null_safety-true
{$ begin main.dart $}
class MyDataObject {
  final int anInt;
  final String aString;
  final double aDouble;

  MyDataObject({
     this.anInt = 1,
     this.aString = 'Old!',
     this.aDouble = 2.0,
  });

  // Add your copyWith method here:
}
{$ end main.dart $}
{$ begin solution.dart $}
class MyDataObject {
  final int anInt;
  final String aString;
  final double aDouble;

  MyDataObject({
     this.anInt = 1,
     this.aString = 'Old!',
     this.aDouble = 2.0,
  });

  MyDataObject copyWith({int? newInt, String? newString, double? newDouble}) {
    return MyDataObject(
      anInt: newInt ?? this.anInt,
      aString: newString ?? this.aString,
      aDouble: newDouble ?? this.aDouble,
    );
  }
}
{$ end solution.dart $}
{$ begin test.dart $}
void main() {
  final source = MyDataObject();
  final errs = <String>[];
  
  try {
    final copy = source.copyWith(newInt: 12, newString: 'New!', newDouble: 3.0);
    
    if (copy.anInt != 12) {
      errs.add('Called copyWith(newInt: 12, newString: \'New!\', newDouble: 3.0), and the new object\'s anInt was ${copy.anInt} rather than the expected value (12).');
    }
    
    if (copy.aString != 'New!') {
      errs.add('Called copyWith(newInt: 12, newString: \'New!\', newDouble: 3.0), and the new object\'s aString was ${copy.aString} rather than the expected value (\'New!\').');
    }
    
    if (copy.aDouble != 3) {
      errs.add('Called copyWith(newInt: 12, newString: \'New!\', newDouble: 3.0), and the new object\'s aDouble was ${copy.aDouble} rather than the expected value (3).');
    }
  } catch (e) {
    _result(false, ['Called copyWith(newInt: 12, newString: \'New!\', newDouble: 3.0) and got an exception: ${e.runtimeType}']);
  }
  
  try {
    final copy = source.copyWith();
    
    if (copy.anInt != 1) {
      errs.add('Called copyWith(), and the new object\'s anInt was ${copy.anInt} rather than the expected value (1).');
    }
    
    if (copy.aString != 'Old!') {
      errs.add('Called copyWith(), and the new object\'s aString was ${copy.aString} rather than the expected value (\'Old!\').');
    }
    
    if (copy.aDouble != 2) {
      errs.add('Called copyWith(), and the new object\'s aDouble was ${copy.aDouble} rather than the expected value (2).');
    }
  } catch (e) {
    _result(false, ['Called copyWith() and got an exception: ${e.runtimeType}']);
  }
  
  if (errs.isEmpty) {
    _result(true);
  } else {
    _result(false, errs);
  }
}
{$ end test.dart $}
{$ begin hint.txt $}
The copyWith method shows up in a lot of classes and libraries.
Yours should do a few things:
use optional named parameters,
create a new instance of MyDataObject,
and use the data from the parameters to fill it
(or the data from the current instance if the parameters are null).
This is a chance to get more practice with the ?? operator!
{$ end hint.txt $}
```


## Exceptions

## 异常

Dart code can throw and catch exceptions. In contrast to Java, all of Dart’s exceptions are unchecked
exceptions. Methods don't declare which exceptions they might throw, and you aren't required to catch
any exceptions.

Dart 代码可以抛出和捕获异常。与 Java 相比，Dart 的所有异常都是 unchecked exception。方法不会声明它们可能抛出的异常，你也不需要捕获任何异常。

Dart provides `Exception` and `Error` types, but you're
allowed to throw any non-null object:

虽然 Dart 提供了 Exception 和 Error 类型，但是你可以抛出任何非空对象：

<?code-excerpt "misc/bin/cheatsheet/exceptions.dart (simple-throws)"?>
```dart
throw Exception('Something bad happened.');
throw 'Waaaaaaah!';
```

Use the `try`, `on`, and `catch` keywords when handling exceptions:

使用 `try`、`on` 以及 `catch` 关键字来处理异常： 

<?code-excerpt "misc/bin/cheatsheet/exceptions.dart (try-on-catch)"?>
```dart
try {
  breedMoreLlamas();
} on OutOfLlamasException {
  // A specific exception
  buyMoreLlamas();
} on Exception catch (e) {
  // Anything else that is an exception
  print('Unknown exception: $e');
} catch (e) {
  // No specified type, handles all
  print('Something really unknown: $e');
}
```

The `try` keyword works as it does in most other languages.
Use the `on` keyword to filter for specific exceptions by type,
and the `catch` keyword to get a reference to the exception object.

If you can't completely handle the exception, use the `rethrow` keyword
to propagate the exception:

如果你无法完全处理该异常，请使用 `rethrow` 关键字再次抛出异常：

<?code-excerpt "misc/bin/cheatsheet/exceptions.dart (try-catch)"?>
```dart
try {
  breedMoreLlamas();
} catch (e) {
  print('I was just trying to breed llamas!');
  rethrow;
}
```

To execute code whether or not an exception is thrown,
use `finally`:

要执行一段无论是否抛出异常都会执行的代码，请使用 `finally`：

<?code-excerpt "misc/bin/cheatsheet/exceptions.dart (try-catch-finally)"?>
```dart
try {
  breedMoreLlamas();
} catch (e) {
  // ... handle exception ...
} finally {
  // Always clean up, even if an exception is thrown.
  cleanLlamaStalls();
}
```

### Code example

### 代码样例

Implement `tryFunction()` below. It should execute an untrustworthy method and
then do the following:

在下面实现 `tryFunction()` 方法。它应该会执行一个不可靠的方法，然后做以下操作：

* If `untrustworthy()` throws an `ExceptionWithMessage`,
  call `logger.logException` with the exception type and message
  (try using `on` and `catch`).

  如果 `untrustworthy()` 抛出了 `ExceptionWithMessage`，则调用 `logger.logException` 并传入使用异常类型和消息（尝试使用 `on` 和 `catch`）。

* If `untrustworthy()` throws an `Exception`,
  call `logger.logException` with the exception type
  (try using `on` for this one).

  如果 `untrustworthy()` 抛出了一个 `Exception`，则调用 `logger.logException` 并传入使用异常类型（这次请尝试使用 `on`）。

* If `untrustworthy()` throws any other object, don't catch the exception.

  如果 `untrustworthy()` 抛出了其他对象，请不要捕获该异常。

* After everything's caught and handled, call `logger.doneLogging`
  (try using `finally`).

  捕获并处理完所有内容后，
  调用 `logger.doneLogging`（尝试使用 `finally`）。

```dart:run-dartpad:height-420px:ga_id-exceptions:null_safety-true
{$ begin main.dart $}
typedef VoidFunction = void Function();

class ExceptionWithMessage {
  final String message;
  const ExceptionWithMessage(this.message);
}

// Call logException to log an exception, and doneLogging when finished.
abstract class Logger {
  void logException(Type t, [String? msg]);
  void doneLogging();
}

void tryFunction(VoidFunction untrustworthy, Logger logger) {
  // Invoking this method might cause an exception. Catch and handle
  // them using try-on-catch-finally.
  untrustworthy();
}
{$ end main.dart $}
{$ begin solution.dart $}
typedef VoidFunction = void Function();

class ExceptionWithMessage {
  final String message;
  const ExceptionWithMessage(this.message);
}

abstract class Logger {
  void logException(Type t, [String? msg]);
  void doneLogging();
}

void tryFunction(VoidFunction untrustworthy, Logger logger) {
  try {
    untrustworthy();
  } on ExceptionWithMessage catch (e) {
    logger.logException(e.runtimeType, e.message);
  } on Exception {
    logger.logException(Exception);
  } finally {
    logger.doneLogging();
  }
}
{$ end solution.dart $}
{$ begin test.dart $}
class MyLogger extends Logger {
  Type? lastType;
  String lastMessage = '';
  bool done = false;
  
  void logException(Type t, [String? message]) {
    lastType = t;
    lastMessage = message ?? lastMessage;
  }
  
  void doneLogging() => done = true;  
}

void main() {
  final errs = <String>[];
  var logger = MyLogger();
  
  try {
    tryFunction(() => throw Exception(), logger);
  
    if ('${logger.lastType}' != 'Exception' && '${logger.lastType}' != '_Exception') {
      errs.add('Untrustworthy threw an Exception, but a different type was logged: ${logger.lastType}.');
    }
    
    if (logger.lastMessage != '') {
      errs.add('Untrustworthy threw an Exception with no message, but a message was logged anyway: \'${logger.lastMessage}\'.');
    }
    
    if (!logger.done) {
      errs.add('Untrustworthy threw an Exception, and doneLogging() wasn\'t called afterward.');
    }
  } catch (e) {
    _result(false, ['Untrustworthy threw an exception, and an exception of type ${e.runtimeType} was unhandled by tryFunction.']);
  }
  
  logger = MyLogger();
  
  try {
    tryFunction(() => throw ExceptionWithMessage('Hey!'), logger);
  
    if (logger.lastType != ExceptionWithMessage) {
      errs.add('Untrustworthy threw an ExceptionWithMessage(\'Hey!\'), but a different type was logged: ${logger.lastType}.');
    }
    
    if (logger.lastMessage != 'Hey!') {
      errs.add('Untrustworthy threw an ExceptionWithMessage(\'Hey!\'), but a different message was logged: \'${logger.lastMessage}\'.');
    }
    
    if (!logger.done) {
      errs.add('Untrustworthy threw an ExceptionWithMessage(\'Hey!\'), and doneLogging() wasn\'t called afterward.');
    }
  } catch (e) {
    _result(false, ['Untrustworthy threw an ExceptionWithMessage(\'Hey!\'), and an exception of type ${e.runtimeType} was unhandled by tryFunction.']);
  }
  
  logger = MyLogger();
  bool caughtStringException = false;

  try {
    tryFunction(() => throw 'A String', logger);
  } on String {
    caughtStringException = true;
  }

  if (!caughtStringException) {
    errs.add('Untrustworthy threw a string, and it was incorrectly handled inside tryFunction().');
  }
  
  logger = MyLogger();
  
  try {
    tryFunction(() {}, logger);
  
    if (logger.lastType != null) {
      errs.add('Untrustworthy didn\'t throw an Exception, but one was logged anyway: ${logger.lastType}.');
    }
    
    if (logger.lastMessage != '') {
      errs.add('Untrustworthy didn\'t throw an Exception with no message, but a message was logged anyway: \'${logger.lastMessage}\'.');
    }
    
    if (!logger.done) {
      errs.add('Untrustworthy didn\'t throw an Exception, but doneLogging() wasn\'t called afterward.');
    }
  } catch (e) {
    _result(false, ['Untrustworthy didn\'t throw an exception, but an exception of type ${e.runtimeType} was unhandled by tryFunction anyway.']);
  }
  
  if (errs.isEmpty) {
    _result(true);
  } else {
    _result(false, errs);
  }
}
{$ end test.dart $}
{$ begin hint.txt $}
This exercise looks tricky, but it's really one big `try` statement.
Just call `untrustworthy` inside the `try`, and
then use `on`, `catch`, and `finally` to catch exceptions and
call methods on the logger.
{$ end hint.txt $}
```


## Using `this` in a constructor

## 在构造方法中使用 `this`

Dart provides a handy shortcut for assigning
values to properties in a constructor:
use `this.propertyName` when declaring the constructor:

Dart 提供了一个方便的快捷方式，
用于为构造方法中的属性赋值：
在声明构造方法时使用 `this.propertyName`。

<?code-excerpt "misc/bin/this_constructor.dart"?>
```dart
class MyColor {
  int red;
  int green;
  int blue;

  MyColor(this.red, this.green, this.blue);
}

final color = MyColor(80, 80, 128);
```

This technique works for named parameters, too.
Property names become the names of the parameters:

此技巧同样也适用于命名参数。属性名为参数的名称：

```dart
class MyColor {
  ...

  MyColor({required this.red, required this.green, required this.blue});
}

final color = MyColor(red: 80, green: 80, blue: 80);
```

In the preceding code, `red`, `green`, and `blue` are marked as `required`
because these `int` values can't be null.
If you add default values, you can omit `required`:

在上面的代码中，`red`、`green` 和 `blue` 被标记为 `required`，
因为这些 `int` 数值不能为空。
如果你指定了默认值，你可以忽略 `required`。

对于可选参数，默认值为期望值：

```dart
MyColor([this.red = 0, this.green = 0, this.blue = 0]);
// or
MyColor({this.red = 0, this.green = 0, this.blue = 0});
```

### Code example

### 代码样例

Add a one-line constructor to `MyClass` that uses
`this.` syntax to receive and assign values for
all three properties of the class.

使用 `this` 语法向 `MyClass` 添加一行构造方法，
并接收和分配全部（三个）属性。

Ignore all initial errors in the DartPad.

可以忽略以下代码一开始在 DartPad 中的错误。

```dart:run-dartpad:ga_id-this_constructor:null_safety-true
{$ begin main.dart $}
class MyClass {
  final int anInt;
  final String aString;
  final double aDouble;
  
  // Create a constructor here.
}
{$ end main.dart $}
{$ begin solution.dart $}
class MyClass {
  final int anInt;
  final String aString;
  final double aDouble;
  
  MyClass(this.anInt, this.aString, this.aDouble);
}
{$ end solution.dart $}
{$ begin test.dart $}
void main() {
  final errs = <String>[];
  
  try {
    final obj = MyClass(1, 'two', 3);
    
    if (obj.anInt != 1) {
      errs.add('Called MyClass(1, \'two\', 3) and got an object with anInt of ${obj.anInt} instead of the expected value (1).');
    }

    if (obj.anInt != 1) {
      errs.add('Called MyClass(1, \'two\', 3) and got an object with aString of \'${obj.aString}\' instead of the expected value (\'two\').');
    }

    if (obj.anInt != 1) {
      errs.add('Called MyClass(1, \'two\', 3) and got an object with aDouble of ${obj.aDouble} instead of the expected value (3).');
    }
  } catch (e) {
    _result(false, ['Called MyClass(1, \'two\', 3) and got an exception of type ${e.runtimeType}.']);
  }
  
  if (errs.isEmpty) {
    _result(true);
  } else {
    _result(false, errs);
  }
}
{$ end test.dart $}
{$ begin hint.txt $}
This exercise has a one-line solution.
Just declare the constructor with
`this.anInt`, `this.aString`, and `this.aDouble`
as its parameters in that order.
{$ end hint.txt $}
```

{% comment %}
This one seems super easy compared to previous ones.
We've already seen it in the Exceptions example,
and I'd already used it in a previous example.
Move it up higher? Or make it more challenging, somehow?
Maybe require both positional and optional named parameters (with defaults)?

这样相比之前要简单很多。我们已经在 Exception 的样例中见过它了。并且我已经在之前的样例中使用了。
把它变得更高级？或者以某种方式让它更具挑战性？
也许需要位置和可选的命名参数（具有默认值）？

{% endcomment %}

## Initializer lists

Sometimes when you implement a constructor,
you need to do some setup before the constructor body executes.
For example, final fields must have values
before the constructor body executes.
Do this work in an initializer list,
which goes between the constructor's signature and its body:

有时，当你在实现构造函数时，您需要在构造函数体执行之前进行一些初始化。
例如，final 修饰的字段必须在构造函数体执行之前赋值。
在初始化列表中执行此操作，该列表位于构造函数的签名与其函数体之间：

```dart
Point.fromJson(Map<String, num> json)
    : x = json['x'],
      y = json['y'] {
  print('In Point.fromJson(): ($x, $y)');
}
```

The initializer list is also a handy place to put asserts,
which run only during development:

初始化列表也是放置断言的便利位置，它仅会在开发期间运行：

```dart
NonNegativePoint(this.x, this.y)
    : assert(x >= 0),
      assert(y >= 0) {
  print('I just made a NonNegativePoint: ($x, $y)');
}
```

### Code example

### 代码样例

Complete the `FirstTwoLetters` constructor below.
Use an initializer list to assign the first two characters in `word` to
the `letterOne` and `LetterTwo` properties.
For extra credit, add an `assert` to catch words of less than two characters.

完成下面的 `FirstTwoLetters` 的构造函数。使用的初始化列表将 `word` 的前两个字符分配给 `letterOne` 和 `LetterTwo` 属性。要获得额外的信用，请添加一个 `断言` 以捕获少于两个字符的单词。

Ignore all initial errors in the DartPad.

可以忽略以下代码一开始在 DartPad 中的错误。

{% comment %}

Is the assert even executed? I can't see any effect on the test,
which makes me think asserts are ignored.
Also, the test just checks for the presence of any exception, not for
an AssertionError.

Also, my print() wasn't visible in the Output until I fixed my code and/or
the test. That was unexpected.
It'd be cool if Output appeared only if you want it, like Solution does.

FINALLY: Suggest using https://pub.dev/packages/characters
if this is a user-entered string.
{% endcomment %}

```dart:run-dartpad:ga_id-initializer_lists:null_safety-true
{$ begin main.dart $}
class FirstTwoLetters {
  final String letterOne;
  final String letterTwo;

  // Create a constructor with an initializer list here:
  FirstTwoLetters(String word)
    ...
}
{$ end main.dart $}
{$ begin solution.dart $}
class FirstTwoLetters {
  final String letterOne;
  final String letterTwo;

  FirstTwoLetters(String word)
      : assert(word.length >= 2),
        letterOne = word[0],
        letterTwo = word[1];
}
{$ end solution.dart $}
{$ begin test.dart $}
void main() {
  final errs = <String>[];

  try {
    final result = FirstTwoLetters('My String');
    
    if (result.letterOne != 'M') {
      errs.add('Called FirstTwoLetters(\'My String\') and got an object with letterOne equal to \'${result.letterOne}\' instead of the expected value (\'M\').');
    }

    if (result.letterTwo != 'y') {
      errs.add('Called FirstTwoLetters(\'My String\') and got an object with letterTwo equal to \'${result.letterTwo}\' instead of the expected value (\'y\').');
    }
  } catch (e) {
    errs.add('Called FirstTwoLetters(\'My String\') and got an exception of type ${e.runtimeType}.');
  }

  bool caughtException = false;
  
  try {
    FirstTwoLetters('');
  } catch (e) {
    caughtException = true;
  }
  
  if (!caughtException) {
    errs.add('Called FirstTwoLetters(\'\') and didn\'t get an exception from the failed assertion.');
  }
  
  if (errs.isEmpty) {
    _result(true);
  } else {
    _result(false, errs);
  }
}
{$ end test.dart $}
{$ begin hint.txt $}
Two assignments need to happen:
letterOne should be word[0], and letterTwo should be word[1].
{$ end hint.txt $}
```


## Named constructors

## 命名构造方法

{% comment %}
Much like JavaScript, Dart doesn't support method overloads
(two methods with the same name but different signatures).
[ISSUE: methods & constructors aren't the same thing,
so I deleted that. We can add it back if we can word it better.]
{% endcomment %}
To allow classes to have multiple constructors,
Dart supports named constructors:

为了允许一个类具有多个构造方法，
Dart 支持命名构造方法：

<?code-excerpt "misc/bin/named_constructor.dart"?>
```dart
class Point {
  double x, y;

  Point(this.x, this.y);

  Point.origin()
      : x = 0,
        y = 0;
}
```

To use a named constructor, invoke it using its full name:

为了使用命名构造方法，请使用全名调用它：

```dart
final myPoint = Point.origin();
```

### Code example

### 代码样例

Give the `Color` class a constructor named `Color.black`
that sets all three properties to zero.

给 `Color` 类添加一个叫做 `Color.black` 的方法，
它将会把三个属性的值都设为 0。

Ignore all initial errors in the DartPad.

可以忽略以下代码一开始在 DartPad 中的错误。

```dart:run-dartpad:height-240px:ga_id-named_constructors:null_safety-true
{$ begin main.dart $}
class Color {
  int red;
  int green;
  int blue;
  
  Color(this.red, this.green, this.blue);

  // Create a named constructor called "Color.black" here:
}
{$ end main.dart $}
{$ begin solution.dart $}
class Color {
  int red;
  int green;
  int blue;
  
  Color(this.red, this.green, this.blue);

  Color.black()
      : red = 0,
        green = 0,
        blue = 0;
}
{$ end solution.dart $}
{$ begin test.dart $}
void main() {
  final errs = <String>[];

  try {
    final result = Color.black();
    
    if (result.red != 0) {
      errs.add('Called Color.black() and got a Color with red equal to ${result.red} instead of the expected value (0).');
    }

    if (result.green != 0) {
      errs.add('Called Color.black() and got a Color with green equal to ${result.green} instead of the expected value (0).');
    }

    if (result.blue != 0) {
  errs.add('Called Color.black() and got a Color with blue equal to ${result.blue} instead of the expected value (0).');
    }
  } catch (e) {
    _result(false, ['Called Color.black() and got an exception of type ${e.runtimeType}.']);
    return;
  }

  if (errs.isEmpty) {
    _result(true);
  } else {
    _result(false, errs);
  }
}
{$ end test.dart $}
{$ begin hint.txt $}
The declaration for your constructor should be `Color.black() {}`.
Inside the braces, set red, green, and blue to zero.
{$ end hint.txt $}
```


## Factory constructors

## 工厂构造方法

Dart supports factory constructors,
which can return subtypes or even null.
To create a factory constructor, use the `factory` keyword:

Dart 支持工厂构造方法。它能够返回其子类甚至 null 对象。
要创建一个工厂构造方法，请使用 `factory` 关键字。

<?code-excerpt "misc/bin/factory_constructors.dart"?>
```dart
class Square extends Shape {}

class Circle extends Shape {}

class Shape {
  Shape();

  factory Shape.fromTypeName(String typeName) {
    if (typeName == 'square') return Square();
    if (typeName == 'circle') return Circle();

    print('I don\'t recognize $typeName');
    throw Error();
  }
}
```

### Code example

### 代码样例

Fill in the factory constructor named `IntegerHolder.fromList`,
making it do the following:

填写名为 `IntegerHolder.fromList` 的工厂构造方法，使其执行以下操作：

* If the list has **one** value,
  create an `IntegerSingle` with that value.

  若列表只有**一个**值，那么就用它来创建一个 `IntegerSingle`。

* If the list has **two** values,
  create an `IntegerDouble` with the values in order.

  如果这个列表有两个值，那么按其顺序创建一个 `IntegerDouble`。

* If the list has **three** values,
  create an `IntegerTriple` with the values in order.

  如果这个列表有三个值，那么按其顺序创建一个 `IntegerTriple`。

* Otherwise, throw an `Error`.

  否则，抛出一个 `Error`。

```dart:run-dartpad:height-415px:ga_id-factory_constructors:null_safety-true
{$ begin main.dart $}
class IntegerHolder {
  IntegerHolder();
  
  // Implement this factory constructor.
  factory IntegerHolder.fromList(List<int> list) {
    TODO();
  }
}

class IntegerSingle extends IntegerHolder {
  final int a;
  IntegerSingle(this.a); 
}

class IntegerDouble extends IntegerHolder {
  final int a;
  final int b;
  IntegerDouble(this.a, this.b); 
}

class IntegerTriple extends IntegerHolder {
  final int a;
  final int b;
  final int c;
  IntegerTriple(this.a, this.b, this.c); 
}
{$ end main.dart $}
{$ begin solution.dart $}
class IntegerHolder {
  IntegerHolder();
  
  factory IntegerHolder.fromList(List<int> list) {
    if (list.length == 1) {
      return IntegerSingle(list[0]);
    } else if (list.length == 2) {
      return IntegerDouble(list[0], list[1]);
    } else if (list.length == 3) {
      return IntegerTriple(list[0], list[1], list[2]);
    } else {
      throw Error();
    } 
  }
}

class IntegerSingle extends IntegerHolder {
  final int a;
  IntegerSingle(this.a); 
}

class IntegerDouble extends IntegerHolder {
  final int a;
  final int b;
  IntegerDouble(this.a, this.b); 
}

class IntegerTriple extends IntegerHolder {
  final int a;
  final int b;
  final int c;
  IntegerTriple(this.a, this.b, this.c); 
}
{$ end solution.dart $}
{$ begin test.dart $}
void main() {
  final errs = <String>[];

  bool _throwed = false;
  try {
    IntegerHolder.fromList([]);
  } on UnimplementedError {
    _result(false, ['Test failed. Did you implement the method?']);
    return;
  } on Error {
    _throwed = true;
  } catch (e) {
    _result(false, ['Called IntegerSingle.fromList([]) and got an exception of type ${e.runtimeType}.']);
    return;
  }
  
  if (!_throwed) {
    errs.add('Called IntegerSingle.fromList([]) and didn\'t throw Error.');
  } 

  try {
    final obj = IntegerHolder.fromList([1]);
    
    if (obj is! IntegerSingle) {
      errs.add('Called IntegerHolder.fromList([1]) and got an object of type ${obj.runtimeType} instead of IntegerSingle.');
    } else {
      if (obj.a != 1) {
        errs.add('Called IntegerHolder.fromList([1]) and got an IntegerSingle with an \'a\' value of ${obj.a} instead of the expected (1).');
      }
    }
  } catch (e) {
    _result(false, ['Called IntegerHolder.fromList([]) and got an exception of type ${e.runtimeType}.']);
    return;
  }

  try {
    final obj = IntegerHolder.fromList([1, 2]);
    
    if (obj is! IntegerDouble) {
      errs.add('Called IntegerHolder.fromList([1, 2]) and got an object of type ${obj.runtimeType} instead of IntegerDouble.');
    } else {
      if (obj.a != 1) {
        errs.add('Called IntegerHolder.fromList([1, 2]) and got an IntegerDouble with an \'a\' value of ${obj.a} instead of the expected (1).');
      }
      
      if (obj.b != 2) {
        errs.add('Called IntegerHolder.fromList([1, 2]) and got an IntegerDouble with an \'b\' value of ${obj.b} instead of the expected (2).');
      }
    }
  } catch (e) {
    _result(false, ['Called IntegerHolder.fromList([1, 2]) and got an exception of type ${e.runtimeType}.']);
    return;
  }

  try {
    final obj = IntegerHolder.fromList([1, 2, 3]);
    
    if (obj is! IntegerTriple) {
      errs.add('Called IntegerHolder.fromList([1, 2, 3]) and got an object of type ${obj.runtimeType} instead of IntegerTriple.');
    } else {
      if (obj.a != 1) {
        errs.add('Called IntegerHolder.fromList([1, 2, 3]) and got an IntegerTriple with an \'a\' value of ${obj.a} instead of the expected (1).');
      }
      
      if (obj.b != 2) {
        errs.add('Called IntegerHolder.fromList([1, 2, 3]) and got an IntegerTriple with an \'a\' value of ${obj.b} instead of the expected (2).');
      }

      if (obj.c != 3) {
        errs.add('Called IntegerHolder.fromList([1, 2, 3]) and got an IntegerTriple with an \'a\' value of ${obj.b} instead of the expected (2).');
      }
    }
  } catch (e) {
    _result(false, ['Called IntegerHolder.fromList([1, 2, 3]) and got an exception of type ${e.runtimeType}.']);
    return;
  }

  if (errs.isEmpty) {
    _result(true);
  } else {
    _result(false, errs);
  }
}
{$ end test.dart $}
{$ begin hint.txt $}
Inside the factory constructor,
check the length of the list and create an
IntegerSingle, IntegerDouble, or IntegerTriple as appropriate.
{$ end hint.txt $}
```

## Redirecting constructors

## 重定向构造方法

Sometimes a constructor’s only purpose is to redirect to
another constructor in the same class.
A redirecting constructor’s body is empty,
with the constructor call appearing after a colon (`:`).

有时一个构造方法仅仅用来重定向到该类的另一个构造方法。
重定向方法没有主体，它在冒号（`:`）之后调用另一个构造方法。

<?code-excerpt "misc/bin/redirecting_const_constructors.dart (redirecting-constructors)"?>
```dart
class Automobile {
  String make;
  String model;
  int mpg;

  // The main constructor for this class.
  Automobile(this.make, this.model, this.mpg);

  // Delegates to the main constructor.
  Automobile.hybrid(String make, String model) : this(make, model, 60);

  // Delegates to a named constructor
  Automobile.fancyHybrid() : this.hybrid('Futurecar', 'Mark 2');
}
```

### Code example

### 代码样例

Remember the `Color` class from above? Create a named constructor called
`black`, but rather than manually assigning the properties, redirect it to the
default constructor with zeros as the arguments.

还记得我们之前提到的 `Color` 类吗？创建一个叫做 `black` 的命名构造方法，
但这次我们不要手动分配属性，而是将 0 作为参数，
重定向到默认的构造方法。

Ignore all initial errors in the DartPad.

可以忽略以下代码一开始在 DartPad 中的错误。

```dart:run-dartpad:height-255px:ga_id-redirecting_constructors:null_safety-true
{$ begin main.dart $}
class Color {
  int red;
  int green;
  int blue;
  
  Color(this.red, this.green, this.blue);

  // Create a named constructor called "black" here and redirect it
  // to call the existing constructor
}
{$ end main.dart $}
{$ begin solution.dart $}
class Color {
  int red;
  int green;
  int blue;
  
  Color(this.red, this.green, this.blue);

  Color.black() : this(0, 0, 0);
}
{$ end solution.dart $}
{$ begin test.dart $}
void main() {
  final errs = <String>[];

  try {
    final result = Color.black();
    
    if (result.red != 0) {
      errs.add('Called Color.black() and got a Color with red equal to ${result.red} instead of the expected value (0).');
    }

    if (result.green != 0) {
      errs.add('Called Color.black() and got a Color with green equal to ${result.green} instead of the expected value (0).');
    }

    if (result.blue != 0) {
  errs.add('Called Color.black() and got a Color with blue equal to ${result.blue} instead of the expected value (0).');
    }
  } catch (e) {
    _result(false, ['Called Color.black() and got an exception of type ${e.runtimeType}.']);
    return;
  }

  if (errs.isEmpty) {
    _result(true);
  } else {
    _result(false, errs);
  }
}
{$ end test.dart $}
{$ begin hint.txt $}
Your constructor should redirect to `this(0, 0, 0)`.
{$ end hint.txt $}
```


## Const constructors

## Const 构造方法

If your class produces objects that never change, you can make these objects compile-time constants. To
do this, define a `const` constructor and make sure that all instance variables
are final.

如果你的类生成的对象永远都不会更改，
则可以让这些对象成为编译时常量。
为此，请定义 `const` 构造方法并确保所有实例变量都是 final 的。

<?code-excerpt "misc/bin/redirecting_const_constructors.dart (const-constructors)"?>
```dart
class ImmutablePoint {
  const ImmutablePoint(this.x, this.y);

  final int x;
  final int y;

  static const ImmutablePoint origin = ImmutablePoint(0, 0);
}
```

### Code example

### 代码样例

Modify the `Recipe` class so its instances can be constants,
and create a constant constructor that does the following:

修改 `Recipe` 类，使其实例成为常量，并创建一个执行以下操作的常量构造方法：

* Has three parameters: `ingredients`, `calories`,
  and `milligramsOfSodium` (in that order).

  该方法有三个参数：`ingredients`、`calories` 和 `milligramsOfSodium`。（按照此顺序）

* Uses `this.` syntax to automatically assign the parameter values to the
  object properties of the same name.

  使用 `this` 语法自动将参数值分配给同名的对象属性。

* Is constant, with the `const` keyword just before
  `Recipe` in the constructor declaration.

  在 `Recipe` 的构造方法声明之前，
  用 `const` 关键字使其成为常量。

Ignore all initial errors in the DartPad.

可以忽略以下代码一开始在 DartPad 中的错误。

```dart:run-dartpad:ga_id-const_constructors:null_safety-true
{$ begin main.dart $}
class Recipe {
  List<String> ingredients;
  int calories;
  double milligramsOfSodium;
}
{$ end main.dart $}
{$ begin solution.dart $}
class Recipe {
  final List<String> ingredients;
  final int calories;
  final double milligramsOfSodium;

  const Recipe(this.ingredients, this.calories, this.milligramsOfSodium);
}
{$ end solution.dart $}
{$ begin test.dart $}
void main() {
  final errs = <String>[];

  try {
    const obj = Recipe(['1 egg', 'Pat of butter', 'Pinch salt'], 120, 200);
    
    if (obj.ingredients.length != 3) {
      errs.add('Called Recipe([\'1 egg\', \'Pat of butter\', \'Pinch salt\'], 120, 200) and got an object with ingredient list of length ${obj.ingredients.length} rather than the expected length (3).');
    }
    
    if (obj.calories != 120) {
      errs.add('Called Recipe([\'1 egg\', \'Pat of butter\', \'Pinch salt\'], 120, 200) and got an object with a calorie value of ${obj.calories} rather than the expected value (120).');
    }
    
    if (obj.milligramsOfSodium != 200) {
      errs.add('Called Recipe([\'1 egg\', \'Pat of butter\', \'Pinch salt\'], 120, 200) and got an object with a milligramsOfSodium value of ${obj.milligramsOfSodium} rather than the expected value (200).');
    }
  } catch (e) {
    _result(false, ['Tried calling Recipe([\'1 egg\', \'Pat of butter\', \'Pinch salt\'], 120, 200) and received a null.']);
  }
  
  if (errs.isEmpty) {
    _result(true);
  } else {
    _result(false, errs);
  }
}
{$ end test.dart $}
{$ begin hint.txt $}
To make the constructor const, you'll need to make all the properties final.
{$ end hint.txt $}
```

## What next?

## 下一步是什么？

We hope you enjoyed using this codelab to learn or test your knowledge of
some of the most interesting features of the Dart language.
Here are some suggestions for what to do now:

我们希望你能够喜欢这个 codelab 来学习或测试你对 Dart 语言中一些最有趣的功能的知识。下面是一些有关现在该做什么的建议：

* Try [other Dart codelabs](/codelabs).

  尝试阅读 [其他 Dart codelab](/codelabs)。

* Read the [Dart language tour](/guides/language/language-tour).

  阅读 [Dart 语言之旅](/guides/language/language-tour)。

* Play with [DartPad.]({{site.dartpad}})

  在 [DartPad]({{site.dartpad}}) 上进行练习。

* [Get the Dart SDK](/get-dart).

  [获取 Dart SDK](/get-dart)。
