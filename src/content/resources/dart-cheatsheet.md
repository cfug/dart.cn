---
# title: Dart cheatsheet
title: Dart 速查表
# description: Interactively learn (or relearn) some of Dart's unique features.
description: 用交互的形式学习（或回顾）Dart 的独特之处。
js: [{url: '/assets/js/inject_dartpad.js', defer: true}]
---
<?code-excerpt replace="/ *\/\/\s+ignore_for_file:[^\n]+\n//g; /(^|\n) *\/\/\s+ignore:[^\n]+\n/$1/g; /(\n[^\n]+) *\/\/\s+ignore:[^\n]+\n/$1\n/g"?>

The Dart language is designed to be easy to learn for
coders coming from other languages,
but it has a few unique features.
This tutorial walks you through
the most important of these language features.

Dart 语言旨在让从其他编程语言转来的开发者们能够轻松学习，但也有它的独特之处。
本篇将基于谷歌工程师编写的
[Dart 语言速查表](/guides/language/cheatsheet)
为你介绍一些最重要的语言特性。

The embedded editors in this tutorial have partially completed code snippets.
You can use these editors to test your knowledge by completing the code and
clicking the **Run** button. The editors also contain thorough test code;
**don't edit the test code**, but feel free to study it to learn about testing. 

这篇教程中的嵌入式编辑器已经完成了部分代码片段。
你可以在这些编辑器上将代码补充完整，然后点击 **Run (运行)** 按钮进行测试。
这些编辑器上还包含了健全的测试代码；
你可以随时研究这些代码来学习测试方面的知识，但 **不要编辑测试代码**。

:::note

This page uses embedded DartPads to display runnable examples.

本页面内嵌了一些 DartPads 做例子展示，

{% render 'dartpads-embedded-troubleshooting.md' %}
:::

## String interpolation

## 字符串插值

To put the value of an expression inside a string, use `${expression}`.
If the expression is an identifier, you can omit the `{}`.

为了将表达式的值放在字符串中，请使用 `${expression}`。若表达式为单个标识符，则可以省略 `{}`。

Here are some examples of using string interpolation:

下面是一些使用字符串插值的例子：

<div class="table-wrapper" markdown="1">

| <t>String</t><t>字符串</t>   | <t>Result</t><t>结果</t>           |
|-----------------------------|------------------------------------|
| `'${3 + 2}'`                | `'5'`                              |
| `'${"word".toUpperCase()}'` | `'WORD'`                           |
| `'$myObject'`               | The value of `myObject.toString()` |
| `'$myObject'`               | `myObject.toString()` 的值         |

</div>

### Code example {:.no_toc}

### 代码样例 {:.no_toc}

The following function takes two integers as parameters.
Make it return a string containing both integers separated by a space.
For example, `stringify(2, 3)` should return `'2 3'`.

下面的方法接收两个整型变量作为参数，
然后让它返回一个包含以空格分隔的整数的字符串。
例如，`stringify(2, 3)` 应该返回 `'2 3'`。

```dartpad
String stringify(int x, int y) {
  TODO('Return a formatted string here');
}


// Tests your solution (Don't edit!): 
void main() {
  assert(stringify(2, 3) == '2 3',
      "Your stringify method returned '${stringify(2, 3)}' instead of '2 3'");
  print('Success!');
}
```

<details>
  <summary>Solution for string interpolation example</summary>

  Both `x` and `y` are simple values,
  and Dart's string interpolation will handle
  converting them to string representations.
  All you need to do is use the `$` operator to
  reference them inside single quotes, with a space in between:

  ```dart
  String stringify(int x, int y) {
    return '$x $y';
  }
  ```

</details>


## Nullable variables

## 可空的变量

Dart enforces sound null safety.
This means values can't be null unless you say they can be.
In other words, types default to non-nullable.

Dart 要求使用健全的空安全，
这意味着除非变量显式声明为可空类型，否则它们将不能为空。
换句话说，类型默认是不可为空的。

For example, consider the following code.
With null safety, this code returns an error.
A variable of type `int` can't have the value `null`:

举个例子，下面的代码在空安全下是有错误的，
因为 `int` 类型的变量不能为 `null`：

<?code-excerpt "misc/bin/cheatsheet/nullable.dart (invalid-null)" replace="/null;/[!null!];/g"?>
```dart
int a = [!null!]; // INVALID.
```

When creating a variable, add `?` to the type to indicate
that the variable can be `null`:

你可以通过在类型后添加 `?` 来表示该类型可空：

<?code-excerpt "misc/bin/cheatsheet/nullable.dart (valid-null)" replace="/int\?/[!int?!]/g"?>
```dart
[!int?!] a = null; // Valid.
```

You can simplify that code a bit because, in all versions of Dart,
`null` is the default value for uninitialized variables:

在所有 Dart 版本中，`null` 在未初始化的变量里都是默认值，
所以你可以这样简化你的代码：

<?code-excerpt "misc/bin/cheatsheet/nullable.dart (simple-null)"?>
```dart
int? a; // The initial value of a is null.
```

To learn more about null safety in Dart,
read the [sound null safety guide](/null-safety).

想了解更多有关 Dart 的空安全的内容，
请阅读 [健全的空安全](/null-safety)。

### Code example {:.no_toc}

### 代码样例 {:.no_toc}

Declare two variables in this DartPad:

在此 DartPad 中声明以下两种变量：

* A nullable `String` named `name` with the value `'Jane'`.

  一个可空的 `String`，名为 `name`，值为 `'Jane'`。

* A nullable `String` named `address` with the value `null`.

  一个可空的 `String`，名为 `address`，值为 `null`。

Ignore all initial errors in the DartPad.

可以忽略以下代码一开始在 DartPad 中的错误。

```dartpad
// TODO: Declare the two variables here


// Tests your solution (Don't edit!): 
void main() {
  try {
    if (name == 'Jane' && address == null) {
      // verify that "name" is nullable
      name = null;
      print('Success!');
    } else {
      print('Not quite right, try again!');
    }
  } catch (e) {
    print('Exception: ${e.runtimeType}');
  }
}
```

<details>
  <summary>可空变量样例的解决方案</summary>

  Declare the two variables as `String` followed by `?`.
  Then, assign `'Jane'` to `name`
  and leave `address` uninitialized:

  将两个变量声明的 `String` 后面带上 `?`。
  然后，将 `name` 赋值为 `'Jane'` 并且
  不对 `address` 进行初始化赋值：

  ```dart
  String? name = 'Jane';
  String? address;
  ```

</details>

## Null-aware operators

## 避空运算符

Dart offers some handy operators for dealing with values that might be null. One is the
`??=` assignment operator, which assigns a value to a variable only if that
variable is currently null:

Dart 提供了一系列方便的运算符用于处理可能会为空值的变量。
其中一个是 `??=` 赋值运算符，仅当该变量为空值时才为其赋值：

<?code-excerpt "misc/test/cheatsheet/null_aware_test.dart (null-aware-operators)"?>
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

<?code-excerpt "misc/test/cheatsheet/null_aware_test.dart (null-aware-operators-2)"?>
```dart
print(1 ?? 3); // <-- Prints 1.
print(null ?? 12); // <-- Prints 12.
```

### Code example {:.no_toc}

### 代码样例 {:.no_toc}

Try substituting in the `??=` and `??` operators
to implement the described behavior in the following snippet.

尝试在下面的代码片段中交替使用 `??=` 和 `??` 操作符，实现期望的需求。

Ignore all initial errors in the DartPad.

可以忽略以下代码一开始在 DartPad 中的错误。

```dartpad
String? foo = 'a string';
String? bar; // = null

// Substitute an operator that makes 'a string' be assigned to baz.
String? baz = foo /* TODO */ bar;

void updateSomeVars() {
  // Substitute an operator that makes 'a string' be assigned to bar.
  bar /* TODO */ 'a string';
}


// Tests your solution (Don't edit!):
void main() {
  try {
    updateSomeVars();
    
    if (foo != 'a string') {
      print('Looks like foo somehow ended up with the wrong value.');
    } else if (bar != 'a string') {
      print('Looks like bar ended up with the wrong value.');
    } else if (baz != 'a string') {
      print('Looks like baz ended up with the wrong value.');
    } else {
      print('Success!');
    }
  } catch (e) {
    print('Exception: ${e.runtimeType}.');
  }
  
}
```

<details>
  <summary>Solution for null-aware operators example</summary>

  All you need to do in this exercise is
  replace the `TODO` comments with either `??` or `??=`.
  Read the text above to make sure you understand both,
  and then give it a try:

  ```dart
  // Substitute an operator that makes 'a string' be assigned to baz.
  String? baz = foo ?? bar;
  
  void updateSomeVars() {
    // Substitute an operator that makes 'a string' be assigned to bar.
    bar ??= 'a string';
  }
  ```

</details>


## Conditional property access

## 条件属性访问

To guard access to a property or method of an object that might be null,
put a question mark (`?`) before the dot (`.`):

要保护可能会为空的属性的正常访问，请在点（`.`）之前加一个问号（`?`）。

<?code-excerpt "misc/test/cheatsheet/null_aware_test.dart (conditional-property-access)" replace="/result = //g; /;//g;"?>
```dart
myObject?.someProperty
```

The preceding code is equivalent to the following:

上述代码等效于以下内容：

<?code-excerpt "misc/test/cheatsheet/null_aware_test.dart (conditional-property-access-equivalent)" replace="/result = //g; /;//g;"?>
```dart
(myObject != null) ? myObject.someProperty : null
```

You can chain multiple uses of `?.` together in a single expression:

你可以在一个表达式中连续使用多个 `?.`：

<?code-excerpt "misc/test/cheatsheet/null_aware_test.dart (conditional-property-access-multiple)" replace="/result = //g; /;//g;"?>
```dart
myObject?.someProperty?.someMethod()
```

The preceding code returns null (and never calls `someMethod()`) if either
`myObject` or `myObject.someProperty` is
null.

如果 `myObject` 或 `myObject.someProperty` 为空，则前面的代码返回 null（并不再调用 `someMethod`）。

### Code example {:.no_toc}

### 代码样例 {:.no_toc}

The following function takes a nullable string as a parameter. 
Try using conditional property access to make it
return the uppercase version of `str`, or `null` if `str` is `null`.

下面的函数将一个可空的字符串作为参数。
请尝试使用条件属性访问来让它返回 `str` 的大写形式，
如果 `str` 为 `null` 则返回 `null`。

```dartpad
String? upperCaseIt(String? str) {
  // TODO: Try conditionally accessing the `toUpperCase` method here.
}


// Tests your solution (Don't edit!):
void main() {
  try {
    String? one = upperCaseIt(null);
    if (one != null) {
      print('Looks like you\'re not returning null for null inputs.');
    } else {
      print('Success when str is null!');
    }
  } catch (e) {
    print('Tried calling upperCaseIt(null) and got an exception: \n ${e.runtimeType}.');
  }
  
  try {
    String? two = upperCaseIt('a string');
    if (two == null) {
      print('Looks like you\'re returning null even when str has a value.');
    } else if (two != 'A STRING') {
      print('Tried upperCaseIt(\'a string\'), but didn\'t get \'A STRING\' in response.');
    } else {
      print('Success when str is not null!');
    }
  } catch (e) {
    print('Tried calling upperCaseIt(\'a string\') and got an exception: \n ${e.runtimeType}.');
  }
}
```

<details>
  <summary>条件属性访问样例的解决方案</summary>

  If this exercise wanted you to conditionally lowercase a string,
  you could do it like this: `str?.toLowerCase()`. Use the equivalent
  method to uppercase a string!

  如果本练习还想要你将字符串转为小写形式，
  你可以像这样做：`str?.toLowerCase()`。
  同样的道理，你可以使用相应的方法将字符串大写！

  ```dart
  String? upperCaseIt(String? str) {
    return str?.toUpperCase();
  }
  ```

</details>

## Collection literals

## 集合字面量 (Collection literals) 

Dart has built-in support for lists, maps, and sets.
You can create them using literals:

Dart 内置了对 list、map 以及 set 的支持。
你可以通过字面量直接创建它们：

<?code-excerpt "misc/test/cheatsheet/collections_test.dart (collection-literals-inferred)"?>
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

<?code-excerpt "misc/test/cheatsheet/collections_test.dart (collection-literals-specified)"?>
```dart
final aListOfInts = <int>[];
final aSetOfInts = <int>{};
final aMapOfIntToDouble = <int, double>{};
```

Specifying types is handy when you initialize a list with contents of a subtype,
but still want the list to be `List<BaseType>`:

在使用子类型的内容初始化列表，但仍希望列表为 `List <BaseType>` 时，指定其类型很方便：

<?code-excerpt "misc/test/cheatsheet/collections_test.dart (collection-literals-subtypes)"?>
```dart
final aListOfBaseType = <BaseType>[SubType(), SubType()];
```

### Code example {:.no_toc}

### 代码样例 {:.no_toc}

Try setting the following variables to the indicated values. Replace the existing null values.

尝试将以下变量设定为指定的值。替换当前的 null 值。

```dartpad
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


// Tests your solution (Don't edit!):
void main() {
  final errs = <String>[];
  
  if (aListOfStrings is! List<String>) {
    errs.add('aListOfStrings should have the type List<String>.');
  } else if (aListOfStrings.length != 3) {
    errs.add('aListOfStrings has ${aListOfStrings.length} items in it, \n rather than the expected 3.');
  } else if (aListOfStrings[0] != 'a' || aListOfStrings[1] != 'b' || aListOfStrings[2] != 'c') {
    errs.add('aListOfStrings doesn\'t contain the correct values (\'a\', \'b\', \'c\').');
  }

  if (aSetOfInts is! Set<int>) {
    errs.add('aSetOfInts should have the type Set<int>.');
  } else if (aSetOfInts.length != 3) {
    errs.add('aSetOfInts has ${aSetOfInts.length} items in it, \n rather than the expected 3.');
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
    print('Success!');
  } else {
    errs.forEach(print);
  }

  // ignore_for_file: unnecessary_type_check
}
```

<details>
  <summary>集合字面量 (Collection literals) 样例的解决方案</summary>

  Add a list, set, or map literal after each equals sign.
  Remember to specify the types for the empty declarations,
  since they can't be inferred.

  在每个等号后添加一个 list、set 或 map literal。
  切记要指定空声明的类型，
  因为它们是无法推断的。

  ```dart
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
  ```

</details>

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

<?code-excerpt "misc/test/cheatsheet/arrow_functions_test.dart (has-empty-long)"?>
```dart
bool hasEmpty = aListOfStrings.any((s) {
  return s.isEmpty;
});
```

Here's a simpler way to write that code:

这里是一个更简单的代码实现：

<?code-excerpt "misc/test/cheatsheet/arrow_functions_test.dart (has-empty-short)"?>
```dart
bool hasEmpty = aListOfStrings.any((s) => s.isEmpty);
```

### Code example {:.no_toc}

### 代码样例 {:.no_toc}

Try finishing the following statements, which use arrow syntax.

尝试使用箭头语法完成下面语句：

```dartpad
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


// Tests your solution (Don't edit!):
void main() {
  final obj = MyClass();
  final errs = <String>[];
  
  try {
    final product = obj.product;
    
    if (product != 30) {
      errs.add('The product property returned $product \n instead of the expected value (30).'); 
    } 
  } catch (e) {
    print('Tried to use MyClass.product, but encountered an exception: \n ${e.runtimeType}.');
    return;
  }

  try {
    obj.incrementValue1();
    
    if (obj.value1 != 3) {
      errs.add('After calling incrementValue, value1 was ${obj.value1} \n instead of the expected value (3).'); 
    } 
  } catch (e) {
    print('Tried to use MyClass.incrementValue1, but encountered an exception: \n ${e.runtimeType}.');
    return;
  }

  try {
    final joined = obj.joinWithCommas(['one', 'two', 'three']);
    
    if (joined != 'one,two,three') {
      errs.add('Tried calling joinWithCommas([\'one\', \'two\', \'three\']) \n and received $joined instead of the expected value (\'one,two,three\').'); 
    } 
  } catch (e) {
    print('Tried to use MyClass.joinWithCommas, but encountered an exception: \n ${e.runtimeType}.');
    return;
  }

  if (errs.isEmpty) {
    print('Success!');
  } else {
    errs.forEach(print);
  }
}
```

<details>
  <summary>箭头语法样例的解决方案</summary>

  For the product, you can use `*` to multiply the three values together.
  For `incrementValue1`, you can use the increment operator (`++`).
  For `joinWithCommas`, use the `join` method found in the `List` class.

  对于乘积，可以使用 `*` 将三个值相乘。
  对于 `incrementValue1`，可以使用增量运算符 (`++`)。
  对于 `joinWithCommas`，可以使用 `List` 类中的 `join` 方法。

  ```dart
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
  ```
</details>


## Cascades

## 级联

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
of the expression **isn't** the return value—it's a reference to `myObject`!

Using cascades, you can chain together operations that
would otherwise require separate statements.
For example, consider the following code,
which uses the conditional member access operator (`?.`)
to read properties of `button` if it isn't `null`:

虽然它仍然在 `myObject` 上调用了 `someMethod`，
但表达式的结果却**不是**该方法返回值，
而是是 `myObject` 对象的引用！
使用级联，你可以将需要单独操作的语句链接在一起。
例如，下方的代码使用了空判断调用符 (`?.`) 在 `button` 不为 `null` 时获取属性：

<?code-excerpt "misc/bin/cheatsheet/cascades.dart (query-without-cascades)"?>
```dart
var button = querySelector('#confirm');
button?.text = 'Confirm';
button?.classes.add('important');
button?.onClick.listen((e) => window.alert('Confirmed!'));
button?.scrollIntoView();
```

To instead use cascades, 
you can start with the _null-shorting_ cascade (`?..`), 
which guarantees that none of the cascade operations
are attempted on a `null` object.
Using cascades shortens the code
and makes the `button` variable unnecessary:

现在你可以在第一个级联位置，使用 **空判断** 级联操作符 (`?..`)，
它可以确保级联操作均在实例不为 `null` 时执行。
使用空判断级联后，你也不再需要 `button` 变量了：

<?code-excerpt "misc/bin/cheatsheet/cascades.dart (query-with-cascades)"?>
```dart
querySelector('#confirm')
  ?..text = 'Confirm'
  ..classes.add('important')
  ..onClick.listen((e) => window.alert('Confirmed!'))
  ..scrollIntoView();
```

### Code example {:.no_toc}

### 代码样例 {:.no_toc}

Use cascades to create a single statement that
sets the `anInt`, `aString`, and `aList` properties of a `BigObject`
to `1`, `'String!'`, and `[3.0]` (respectively)
and then calls `allDone()`.

使用级联创建一个语句，
分别将 `BigObject` 的 `anInt` 属性设为 `1`、`aString` 
属性设为 `String!`、`aList` 属性设置为
`[3.0]` 然后调用 `allDone()`。

```dartpad
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


// Tests your solution (Don't edit!):
void main() {
  BigObject obj;

  try {
    obj = fillBigObject(BigObject());
  } catch (e) {
    print('Caught an exception of type ${e.runtimeType} \n while running fillBigObject');
    return;
  }

  final errs = <String>[];

  if (obj.anInt != 1) {
    errs.add(
        'The value of anInt was ${obj.anInt} \n rather than the expected (1).');
  }

  if (obj.aString != 'String!') {
    errs.add(
        'The value of aString was \'${obj.aString}\' \n rather than the expected (\'String!\').');
  }

  if (obj.aList.length != 1) {
    errs.add(
        'The length of aList was ${obj.aList.length} \n rather than the expected value (1).');
  } else {
    if (obj.aList[0] != 3.0) {
      errs.add(
          'The value found in aList was ${obj.aList[0]} \n rather than the expected (3.0).');
    }
  }
  
  if (!obj._done) {
    errs.add('It looks like allDone() wasn\'t called.');
  }

  if (errs.isEmpty) {
    print('Success!');
  } else {
    errs.forEach(print);
  }
}
```

<details>
  <summary>Solution for cascades example</summary>

  The best solution for this exercise starts with `obj..` and
  has four assignment operations chained together.
  Start with `return obj..anInt = 1`,
  then add another cascade (`..`) and start the next assignment.

  ```dart
  BigObject fillBigObject(BigObject obj) {
    return obj
      ..anInt = 1
      ..aString = 'String!'
      ..aList.add(3)
      ..allDone();
  }
  ```
</details>


## Getters and setters

You can define getters and setters
whenever you need more control over a property
than a simple field allows.

任何需要对属性进行更多控制而不是允许简单字段访问的时候，你都可以自定义 getter 和 setter。

For example, you can make sure a property's value is valid:

例如，你可以用来确保属性值合法：

<?code-excerpt "misc/lib/cheatsheet/getters_setters.dart"?>
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

<?code-excerpt "misc/lib/cheatsheet/getter_compute.dart"?>
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

### Code example {:.no_toc}

### 代码样例 {:.no_toc}

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

```dartpad
class InvalidPriceException {}

class ShoppingCart {
  List<double> _prices = [];
  
  // TODO: Add a "total" getter here:

  // TODO: Add a "prices" setter here:
}


// Tests your solution (Don't edit!):
void main() {
  var foundException = false;
  
  try {
    final cart = ShoppingCart();
    cart.prices = [12.0, 12.0, -23.0];
  } on InvalidPriceException {
    foundException = true;
  } catch (e) {
    print('Tried setting a negative price and received a ${e.runtimeType} \n instead of an InvalidPriceException.');
    return;
  }
  
  if (!foundException) {
    print('Tried setting a negative price \n and didn\'t get an InvalidPriceException.');
    return;
  }
  
  final secondCart = ShoppingCart();
  
  try {
    secondCart.prices = [1.0, 2.0, 3.0];
  } catch(e) {
    print('Tried setting prices with a valid list, \n but received an exception: ${e.runtimeType}.');
    return;
  }
  
  if (secondCart._prices.length != 3) {
    print('Tried setting prices with a list of three values, \n but _prices ended up having length ${secondCart._prices.length}.');
    return;
  }

  if (secondCart._prices[0] != 1.0 || secondCart._prices[1] != 2.0 || secondCart._prices[2] != 3.0) {
    final vals = secondCart._prices.map((p) => p.toString()).join(', ');
    print('Tried setting prices with a list of three values (1, 2, 3), \n but incorrect ones ended up in the price list ($vals) .');
    return;
  }
  
  var sum = 0.0;
  
  try {
    sum = secondCart.total;
  } catch (e) {
    print('Tried to get total, but received an exception: ${e.runtimeType}.');
    return;
  }
  
  if (sum != 6.0) {
    print('After setting prices to (1, 2, 3), total returned $sum instead of 6.');
    return;
  }
  
  print('Success!');
}
```

<details>
  <summary>Solution for getters and setters example</summary>

  Two functions are handy for this exercise. 
  One is `fold`, which can reduce a list to a single value
  (use it to calculate the total).
  The other is `any`, which can check each item in a list
  with a function you give it
  (use it to check if there are any negative prices in the prices setter).

  ```dart
  // Add a "total" getter here:
  double get total => _prices.fold(0, (e, t) => e + t);

  // Add a "prices" setter here:
  set prices(List<double> value) {
    if (value.any((p) => p < 0)) {
      throw InvalidPriceException();
    }
    
    _prices = value;
  }
  ```

</details>


## Optional positional parameters

## 可选位置参数

Dart has two kinds of function parameters: positional and named. 
Positional parameters are the kind you're likely familiar with:

Dart 有两种传参方法：位置参数和命名参数。位置参数你可能会比较熟悉：

<?code-excerpt "misc/lib/cheatsheet/optional_positional_args.dart (optional-positional-args)"?>
```dart
int sumUp(int a, int b, int c) {
  return a + b + c;
}
  // ···
  int total = sumUp(1, 2, 3);
```

With Dart, you can make these positional parameters optional by wrapping them in brackets:

在 Dart 里，你可以将这些参数包裹在方括号中，使其变成可选位置参数：

<?code-excerpt "misc/lib/cheatsheet/optional_positional_args.dart (optional-positional-args-2)" replace="/total2/total/g"?>
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

<?code-excerpt "misc/lib/cheatsheet/optional_positional_args2.dart (sum-no-impl)"?>
```dart
int sumUpToFive(int a, [int b = 2, int c = 3, int d = 4, int e = 5]) {
  // ···
}

void main() {
  int newTotal = sumUpToFive(1);
  print(newTotal); // <-- prints 15
}
```

### Code example {:.no_toc}

### 代码样例 {:.no_toc}

Implement a function called `joinWithCommas()` that accepts one to
five integers, then returns a string of those numbers separated by commas.
Here are some examples of function calls and returned values:

实现一个名为 `joinWithCommas` 的方法，它接收一至五个整数，
然后返回由逗号分隔的包含这些数字的字符串。
以下是方法调用和返回值的一些示例：

| <t>Function call</t><t>方法调用</t> | <t>Returned value</t><t>返回值</t> |
|---------------------------------|----------------|
| `joinWithCommas(1)`             | `'1'`          |
| `joinWithCommas(1, 2, 3)`       | `'1,2,3'`      |
| `joinWithCommas(1, 1, 1, 1, 1)` | `'1,1,1,1,1'`  |

<br>

```dartpad
String joinWithCommas(int a, [int? b, int? c, int? d, int? e]) {
  return TODO();
}


// Tests your solution (Don't edit!):
void main() {
  final errs = <String>[];
  
  try {
    final value = joinWithCommas(1);
    
    if (value != '1') {
      errs.add('Tried calling joinWithCommas(1) \n and got $value instead of the expected (\'1\').'); 
    } 
  } on UnimplementedError {
    print('Tried to call joinWithCommas but failed. \n Did you implement the method?');
    return;
  } catch (e) {
    print('Tried calling joinWithCommas(1), \n but encountered an exception: ${e.runtimeType}.');
    return;
  }

  try {
    final value = joinWithCommas(1, 2, 3);
    
    if (value != '1,2,3') {
      errs.add('Tried calling joinWithCommas(1, 2, 3) \n and got $value instead of the expected (\'1,2,3\').'); 
    } 
  } on UnimplementedError {
    print('Tried to call joinWithCommas but failed. \n Did you implement the method?');
    return;
  } catch (e) {
    print('Tried calling joinWithCommas(1, 2 ,3), \n but encountered an exception: ${e.runtimeType}.');
    return;
  }

  try {
    final value = joinWithCommas(1, 2, 3, 4, 5);
    
    if (value != '1,2,3,4,5') {
      errs.add('Tried calling joinWithCommas(1, 2, 3, 4, 5) \n and got $value instead of the expected (\'1,2,3,4,5\').'); 
    } 
  } on UnimplementedError {
    print('Tried to call joinWithCommas but failed. \n Did you implement the method?');
    return;
  } catch (e) {
    print('Tried calling stringify(1, 2, 3, 4 ,5), \n but encountered an exception: ${e.runtimeType}.');
    return;
  }

  if (errs.isEmpty) {
    print('Success!');
  } else {
    errs.forEach(print);
  }
}
```

<details>
  <summary>Solution for positional parameters example</summary>

  The `b`, `c`, `d`, and `e` parameters are null if they aren't provided by the
  caller. The important thing, then, is to check whether those arguments are `null`
  before you add them to the final string.

  ```dart
  String joinWithCommas(int a, [int? b, int? c, int? d, int? e]) {
    var total = '$a';
    if (b != null) total = '$total,$b';
    if (c != null) total = '$total,$c';
    if (d != null) total = '$total,$d';
    if (e != null) total = '$total,$e';
    return total;
  }
  ```

</details>

<a id="optional-named-parameters"></a>
## Named parameters

## 命名参数

Using a curly brace syntax at the end of the parameter list,
you can define parameters that have names.

你可以在参数列表的靠后位置使用花括号 (`{}`) 来定义命名参数。

Named parameters are optional
unless they're explicitly marked as `required`.

除非显式使用 `required` 进行标记，否则命名参数默认是可选的。

<?code-excerpt "misc/lib/cheatsheet/named_parameters.dart"?>
```dart
void printName(String firstName, String lastName, {String? middleName}) {
  print('$firstName ${middleName ?? ''} $lastName');
}

void main() {
  printName('Dash', 'Dartisan');
  printName('John', 'Smith', middleName: 'Who');
  // Named arguments can be placed anywhere in the argument list
  printName('John', middleName: 'Who', 'Smith');
}
```

As you might expect,
the default value of a nullable named parameter is `null`,
but you can provide a custom default value.

正如你所料，这些参数默认为 null，但你也可以为其提供默认值。

If the type of a parameter is non-nullable,
then you must either provide a default value
(as shown in the following code)
or mark the parameter as `required`
(as shown in the
[constructor section](#using-this-in-a-constructor)).

如果一个参数的类型是非空的，那么你必须要提供一个默认值（如下方代码所示），
或者将其标记为 `required`（如 [构造部分](#using-this-in-a-constructor)所示）。

<?code-excerpt "misc/test/cheatsheet/arguments_test.dart (defaulted-middle)" replace="/ = ''/[! = ''!]/g;"?>
```dart
void printName(String firstName, String lastName, {String middleName[! = ''!]}) {
  print('$firstName $middleName $lastName');
}
```

A function can't have both optional positional and named parameters.

一个方法不能同时使用可选位置参数和可选命名参数。

### Code example {:.no_toc}

### 代码样例 {:.no_toc}

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

```dartpad
class MyDataObject {
  final int anInt;
  final String aString;
  final double aDouble;

  MyDataObject({
     this.anInt = 1,
     this.aString = 'Old!',
     this.aDouble = 2.0,
  });

  // TODO: Add your copyWith method here:
}


// Tests your solution (Don't edit!):
void main() {
  final source = MyDataObject();
  final errs = <String>[];
  
  try {
    final copy = source.copyWith(newInt: 12, newString: 'New!', newDouble: 3.0);
    
    if (copy.anInt != 12) {
      errs.add('Called copyWith(newInt: 12, newString: \'New!\', newDouble: 3.0), \n and the new object\'s anInt was ${copy.anInt} rather than the expected value (12).');
    }
    
    if (copy.aString != 'New!') {
      errs.add('Called copyWith(newInt: 12, newString: \'New!\', newDouble: 3.0), \n and the new object\'s aString was ${copy.aString} rather than the expected value (\'New!\').');
    }
    
    if (copy.aDouble != 3) {
      errs.add('Called copyWith(newInt: 12, newString: \'New!\', newDouble: 3.0), \n and the new object\'s aDouble was ${copy.aDouble} rather than the expected value (3).');
    }
  } catch (e) {
    print('Called copyWith(newInt: 12, newString: \'New!\', newDouble: 3.0) \n and got an exception: ${e.runtimeType}');
  }
  
  try {
    final copy = source.copyWith();
    
    if (copy.anInt != 1) {
      errs.add('Called copyWith(), and the new object\'s anInt was ${copy.anInt} \n rather than the expected value (1).');
    }
    
    if (copy.aString != 'Old!') {
      errs.add('Called copyWith(), and the new object\'s aString was ${copy.aString} \n rather than the expected value (\'Old!\').');
    }
    
    if (copy.aDouble != 2) {
      errs.add('Called copyWith(), and the new object\'s aDouble was ${copy.aDouble} \n rather than the expected value (2).');
    }
  } catch (e) {
    print('Called copyWith() and got an exception: ${e.runtimeType}');
  }
  
  if (errs.isEmpty) {
    print('Success!');
  } else {
    errs.forEach(print);
  }
}
```

<details>
  <summary>Solution for named parameters example</summary>

  The `copyWith` method shows up in a lot of classes and libraries.
  Yours should do a few things:
  use optional named parameters,
  create a new instance of `MyDataObject`,
  and use the data from the parameters to fill it
  (or the data from the current instance if the parameters are null).
  This is a chance to get more practice with the `??` operator!

  ```dart
    MyDataObject copyWith({int? newInt, String? newString, double? newDouble}) {
      return MyDataObject(
        anInt: newInt ?? this.anInt,
        aString: newString ?? this.aString,
        aDouble: newDouble ?? this.aDouble,
      );
    }
  ```
</details>


## Exceptions

## 异常

Dart code can throw and catch exceptions.
In contrast to Java, all of Dart's exceptions are unchecked.
Methods don't declare which exceptions they might throw and
you aren't required to catch any exceptions.

Dart 代码可以抛出和捕获异常。
与 Java 不同的是，Dart 的所有异常都是 unchecked exception。
方法不会声明它们可能抛出的异常，你也不需要捕获任何异常。

Dart provides `Exception` and `Error` types, but you're
allowed to throw any non-null object:

虽然 Dart 提供了 Exception 和 Error 类型，但是你可以抛出任何非空对象：

<?code-excerpt "misc/test/cheatsheet/exceptions_test.dart (simple-throws)"?>
```dart
throw Exception('Something bad happened.');
throw 'Waaaaaaah!';
```

Use the `try`, `on`, and `catch` keywords when handling exceptions:

使用 `try`、`on` 以及 `catch` 关键字来处理异常： 

<?code-excerpt "misc/test/cheatsheet/exceptions_test.dart (try-on-catch)"?>
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

<?code-excerpt "misc/test/cheatsheet/exceptions_test.dart (try-catch)"?>
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

<?code-excerpt "misc/test/cheatsheet/exceptions_test.dart (try-catch-finally)"?>
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

### Code example {:.no_toc}

### 代码样例 {:.no_toc}

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

```dartpad
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
  try {
    untrustworthy();
  } on ExceptionWithMessage catch (e) {
    logger.logException(e.runtimeType, e.message); 
  } on Exception catch (e) {
    logger.logException(e.runtimeType);
  } finally {
    logger.doneLogging();
  }
}

// Tests your solution (Don't edit!):
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
      errs.add('Untrustworthy threw an Exception, but a different type was logged: \n ${logger.lastType}.');
    }
    
    if (logger.lastMessage != '') {
      errs.add('Untrustworthy threw an Exception with no message, but a message \n was logged anyway: \'${logger.lastMessage}\'.');
    }
    
    if (!logger.done) {
      errs.add('Untrustworthy threw an Exception, \n and doneLogging() wasn\'t called afterward.');
    }
  } catch (e) {
    print('Untrustworthy threw an exception, and an exception of type \n ${e.runtimeType} was unhandled by tryFunction.');
  }
  
  logger = MyLogger();
  
  try {
    tryFunction(() => throw ExceptionWithMessage('Hey!'), logger);
  
    if (logger.lastType != ExceptionWithMessage) {
      errs.add('Untrustworthy threw an ExceptionWithMessage(\'Hey!\'), but a \n different type was logged: ${logger.lastType}.');
    }
    
    if (logger.lastMessage != 'Hey!') {
      errs.add('Untrustworthy threw an ExceptionWithMessage(\'Hey!\'), but a \n different message was logged: \'${logger.lastMessage}\'.');
    }
    
    if (!logger.done) {
      errs.add('Untrustworthy threw an ExceptionWithMessage(\'Hey!\'), \n and doneLogging() wasn\'t called afterward.');
    }
  } catch (e) {
    print('Untrustworthy threw an ExceptionWithMessage(\'Hey!\'), \n and an exception of type ${e.runtimeType} was unhandled by tryFunction.');
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
      errs.add('Untrustworthy didn\'t throw an Exception, \n but one was logged anyway: ${logger.lastType}.');
    }
    
    if (logger.lastMessage != '') {
      errs.add('Untrustworthy didn\'t throw an Exception with no message, \n but a message was logged anyway: \'${logger.lastMessage}\'.');
    }
    
    if (!logger.done) {
      errs.add('Untrustworthy didn\'t throw an Exception, \n but doneLogging() wasn\'t called afterward.');
    }
  } catch (e) {
    print('Untrustworthy didn\'t throw an exception, \n but an exception of type ${e.runtimeType} was unhandled by tryFunction anyway.');
  }
  
  if (errs.isEmpty) {
    print('Success!');
  } else {
    errs.forEach(print);
  }
}
```

<details>
  <summary>Solution for exceptions example</summary>

  This exercise looks tricky, but it's really one big `try` statement.
  Call `untrustworthy` inside the `try`, and
  then use `on`, `catch`, and `finally` to catch exceptions and
  call methods on the logger.

  ```dart
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
  ```

</details>


## Using `this` in a constructor

## 在构造方法中使用 `this`

Dart provides a handy shortcut for assigning
values to properties in a constructor:
use `this.propertyName` when declaring the constructor:

Dart 提供了一个方便的快捷方式，
用于为构造方法中的属性赋值：
在声明构造方法时使用 `this.propertyName`。

<?code-excerpt "misc/lib/cheatsheet/this_constructor.dart (required-positional)"?>
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

<?code-excerpt "misc/lib/cheatsheet/this_constructor.dart (required-named)" replace="/int.*;/.../g; /olorRN/olor/g;"?>
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

<?code-excerpt "misc/lib/cheatsheet/this_constructor.dart (defaulted)" replace="/olorO/olor/g; /.positional//g; /.named//g;"?>
```dart
MyColor([this.red = 0, this.green = 0, this.blue = 0]);
// or
MyColor({this.red = 0, this.green = 0, this.blue = 0});
```

### Code example {:.no_toc}

### 代码样例 {:.no_toc}

Add a one-line constructor to `MyClass` that uses
`this.` syntax to receive and assign values for
all three properties of the class.

使用 `this` 语法向 `MyClass` 添加一行构造方法，
并接收和分配全部（三个）属性。

Ignore all initial errors in the DartPad.

可以忽略以下代码一开始在 DartPad 中的错误。

```dartpad
class MyClass {
  final int anInt;
  final String aString;
  final double aDouble;
  
  // TODO: Create the constructor here.
}


// Tests your solution (Don't edit!):
void main() {
  final errs = <String>[];
  
  try {
    final obj = MyClass(1, 'two', 3);
    
    if (obj.anInt != 1) {
      errs.add('Called MyClass(1, \'two\', 3) and got an object with anInt of ${obj.anInt} \n instead of the expected value (1).');
    }

    if (obj.anInt != 1) {
      errs.add('Called MyClass(1, \'two\', 3) and got an object with aString of \'${obj.aString}\' \n instead of the expected value (\'two\').');
    }

    if (obj.anInt != 1) {
      errs.add('Called MyClass(1, \'two\', 3) and got an object with aDouble of ${obj.aDouble} \n instead of the expected value (3).');
    }
  } catch (e) {
    print('Called MyClass(1, \'two\', 3) and got an exception \n of type ${e.runtimeType}.');
  }
  
  if (errs.isEmpty) {
    print('Success!');
  } else {
    errs.forEach(print);
  }
}
```

<details>
  <summary>Solution for `this` example</summary>

  This exercise has a one-line solution.
  Declare the constructor with
  `this.anInt`, `this.aString`, and `this.aDouble`
  as its parameters in that order.

  ```dart    
  MyClass(this.anInt, this.aString, this.aDouble);
  ```

</details>

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

有时，当你在实现构造函数时，你需要在构造函数体执行之前进行一些初始化。
例如，final 修饰的字段必须在构造函数体执行之前赋值。
在初始化列表中执行此操作，该列表位于构造函数的签名与其函数体之间：

<?code-excerpt "misc/lib/language_tour/classes/point_alt.dart (initializer-list-no-comment)"?>
```dart
Point.fromJson(Map<String, double> json)
    : x = json['x']!,
      y = json['y']! {
  print('In Point.fromJson(): ($x, $y)');
}
```

The initializer list is also a handy place to put asserts,
which run only during development:

初始化列表也是放置断言的便利位置，它仅会在开发期间运行：

<?code-excerpt "misc/lib/cheatsheet/initializer_lists.dart (assert)"?>
```dart
NonNegativePoint(this.x, this.y)
    : assert(x >= 0),
      assert(y >= 0) {
  print('I just made a NonNegativePoint: ($x, $y)');
}
```

### Code example {:.no_toc}

### 代码样例 {:.no_toc}

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

```dartpad
class FirstTwoLetters {
  final String letterOne;
  final String letterTwo;

  // TODO: Create a constructor with an initializer list here:
  FirstTwoLetters(String word)

}


// Tests your solution (Don't edit!):
void main() {
  final errs = <String>[];

  try {
    final result = FirstTwoLetters('My String');
    
    if (result.letterOne != 'M') {
      errs.add('Called FirstTwoLetters(\'My String\') and got an object with \n letterOne equal to \'${result.letterOne}\' instead of the expected value (\'M\').');
    }

    if (result.letterTwo != 'y') {
      errs.add('Called FirstTwoLetters(\'My String\') and got an object with \n letterTwo equal to \'${result.letterTwo}\' instead of the expected value (\'y\').');
    }
  } catch (e) {
    errs.add('Called FirstTwoLetters(\'My String\') and got an exception \n of type ${e.runtimeType}.');
  }

  bool caughtException = false;
  
  try {
    FirstTwoLetters('');
  } catch (e) {
    caughtException = true;
  }
  
  if (!caughtException) {
    errs.add('Called FirstTwoLetters(\'\') and didn\'t get an exception \n from the failed assertion.');
  }
  
  if (errs.isEmpty) {
    print('Success!');
  } else {
    errs.forEach(print);
  }
}
```

<details>
  <summary>Solution for initializer lists example</summary>

  Two assignments need to happen:
  `letterOne` should be assigned `word[0]`,
  and `letterTwo` should be assigned `word[1]`.

  ```dart    
    FirstTwoLetters(String word)
        : assert(word.length >= 2),
          letterOne = word[0],
          letterTwo = word[1];
  ```
</details>

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

<?code-excerpt "misc/lib/cheatsheet/named_constructor.dart (point-class)"?>
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

<?code-excerpt "misc/test/cheatsheet/constructor_test.dart (origin-point)"?>
```dart
final myPoint = Point.origin();
```

### Code example {:.no_toc}

### 代码样例 {:.no_toc}

Give the `Color` class a constructor named `Color.black`
that sets all three properties to zero.

给 `Color` 类添加一个叫做 `Color.black` 的方法，
它将会把三个属性的值都设为 0。

Ignore all initial errors in the DartPad.

可以忽略以下代码一开始在 DartPad 中的错误。

```dartpad
class Color {
  int red;
  int green;
  int blue;
  
  Color(this.red, this.green, this.blue);

  // TODO: Create a named constructor called "Color.black" here:

}


// Tests your solution (Don't edit!):
void main() {
  final errs = <String>[];

  try {
    final result = Color.black();
    
    if (result.red != 0) {
      errs.add('Called Color.black() and got a Color with red equal to \n ${result.red} instead of the expected value (0).');
    }

    if (result.green != 0) {
      errs.add('Called Color.black() and got a Color with green equal to \n ${result.green} instead of the expected value (0).');
    }

    if (result.blue != 0) {
  errs.add('Called Color.black() and got a Color with blue equal to \n ${result.blue} instead of the expected value (0).');
    }
  } catch (e) {
    print('Called Color.black() and got an exception of type \n ${e.runtimeType}.');
    return;
  }

  if (errs.isEmpty) {
    print('Success!');
  } else {
    errs.forEach(print);
  }
}
```

<details>
  <summary>Solution for named constructors example</summary>

  The declaration for your constructor should begin with `Color.black(): `.
  In the initializer list (after the colon), set `red`, `green`, and `blue` to `0`.

  ```dart    
    Color.black()
        : red = 0,
          green = 0,
          blue = 0;
  ```

</details>

## Factory constructors

## 工厂构造方法

Dart supports factory constructors,
which can return subtypes or even null.
To create a factory constructor, use the `factory` keyword:

Dart 支持工厂构造方法。它能够返回其子类甚至 null 对象。
要创建一个工厂构造方法，请使用 `factory` 关键字。

<?code-excerpt "misc/lib/cheatsheet/factory_constructors.dart"?>
```dart
class Square extends Shape {}

class Circle extends Shape {}

class Shape {
  Shape();

  factory Shape.fromTypeName(String typeName) {
    if (typeName == 'square') return Square();
    if (typeName == 'circle') return Circle();

    throw ArgumentError('Unrecognized $typeName');
  }
}
```

### Code example {:.no_toc}

Replace the line `TODO();` in the factory constructor
named `IntegerHolder.fromList` to return the following:

替换名为 `IntegerHolder.fromList` 工厂构造函数中的 `TODO();` 行，
使其执行以下操作：

* If the list has **one** value,
  create an `IntegerSingle` instance using that value.

  如果列表只有**一个**值，那么就用它来创建一个 `IntegerSingle` 实例。

* If the list has **two** values,
  create an `IntegerDouble` instance using the values in order.

  如果这个列表有**两个**值，那么按其顺序创建一个 `IntegerDouble` 实例。

* If the list has **three** values,
  create an `IntegerTriple` instance using the values in order.

  如果这个列表有**三个**值，那么按其顺序创建一个 `IntegerTriple` 实例。

* Otherwise, throw an `Error`.

  否则，抛出一个 `Error`。

If you succeed, the console should display `Success!`.

如果成功，控制台应显示 `Success!`。

```dartpad
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

// Tests your solution (Don't edit from this point to end of file):
void main() {
  final errs = <String>[];

  // Run 5 tests to see which values have valid integer holders
  for (var tests = 0; tests < 5; tests++) {
    if (!testNumberOfArgs(errs, tests)) return;
  }

  // The goal is no errors with values 1 to 3,
  // but have errors with values 0 and 4.
  // The testNumberOfArgs method adds to the errs array if
  // the values 1 to 3 have an error and
  // the values 0 and 4 don't have an error
  if (errs.isEmpty) {
    print('Success!');
  } else {
    errs.forEach(print);
  }
}

bool testNumberOfArgs(List<String> errs, int count) {
  bool _threw = false;
  final ex = List.generate(count, (index) => index + 1);
  final callTxt = "IntegerHolder.fromList(${ex})";
  try {
    final obj = IntegerHolder.fromList(ex);
    final String vals = count == 1 ? "value" : "values";
    // Uncomment the next line if you want to see the results realtime
    // print("Testing with ${count} ${vals} using ${obj.runtimeType}.");
    testValues(errs, ex, obj, callTxt);
  } on Error {
    _threw = true;
  } catch (e) {
    switch (count) {
      case (< 1 && > 3):
        if (!_threw) {
          errs.add('Called ${callTxt} and it didn\'t throw an Error.');
        }
      default:
        errs.add('Called $callTxt and received an Error.');
    }
  }
  return true;
}

void testValues(List<String> errs, List<int> expectedValues, IntegerHolder obj,
    String callText) {
  for (var i = 0; i < expectedValues.length; i++) {
    int found;
    if (obj is IntegerSingle) {
      found = obj.a;
    } else if (obj is IntegerDouble) {
      found = i == 0 ? obj.a : obj.b;
    } else if (obj is IntegerTriple) {
      found = i == 0
          ? obj.a
          : i == 1
              ? obj.b
              : obj.c;
    } else {
      throw ArgumentError(
          "This IntegerHolder type (${obj.runtimeType}) is unsupported.");
    }

    if (found != expectedValues[i]) {
      errs.add(
          "Called $callText and got a ${obj.runtimeType} " + 
          "with a property at index $i value of $found " +
          "instead of the expected (${expectedValues[i]}).");
    }
  }
}

```

<details>
  <summary>Solution for factory constructors example</summary>

  Inside the factory constructor,
  check the length of the list, then create and return an
  `IntegerSingle`, `IntegerDouble`, or `IntegerTriple` as appropriate.

  Replace `TODO();` with the following code block.

  ```dart
    switch (list.length) {
      case 1:
        return IntegerSingle(list[0]);
      case 2:
        return IntegerDouble(list[0], list[1]);
      case 3:
        return IntegerTriple(list[0], list[1], list[2]);
      default:
        throw ArgumentError("List must between 1 and 3 items. This list was ${list.length} items.");
    }
  ```

</details>

## Redirecting constructors

## 重定向构造方法

Sometimes a constructor's only purpose is to redirect to
another constructor in the same class.
A redirecting constructor's body is empty,
with the constructor call appearing after a colon (`:`).

有时一个构造方法仅仅用来重定向到该类的另一个构造方法。
重定向方法没有主体，它在冒号（`:`）之后调用另一个构造方法。

<?code-excerpt "misc/lib/cheatsheet/redirecting_constructors.dart (redirecting-constructors)"?>
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

### Code example {:.no_toc}

### 代码样例 {:.no_toc}

Remember the `Color` class from above? Create a named constructor called
`black`, but rather than manually assigning the properties, redirect it to the
default constructor with zeros as the arguments.

还记得我们之前提到的 `Color` 类吗？创建一个叫做 `black` 的命名构造方法，
但这次我们不要手动分配属性，而是将 0 作为参数，
重定向到默认的构造方法。

Ignore all initial errors in the DartPad.

可以忽略以下代码一开始在 DartPad 中的错误。

```dartpad
class Color {
  int red;
  int green;
  int blue;
  
  Color(this.red, this.green, this.blue);

  // TODO: Create a named constructor called "black" here
  // and redirect it to call the existing constructor
}


// Tests your solution (Don't edit!):
void main() {
  final errs = <String>[];

  try {
    final result = Color.black();
    
    if (result.red != 0) {
      errs.add('Called Color.black() and got a Color with red equal to \n ${result.red} instead of the expected value (0).');
    }

    if (result.green != 0) {
      errs.add('Called Color.black() and got a Color with green equal to \n ${result.green} instead of the expected value (0).');
    }

    if (result.blue != 0) {
  errs.add('Called Color.black() and got a Color with blue equal to \n ${result.blue} instead of the expected value (0).');
    }
  } catch (e) {
    print('Called Color.black() and got an exception of type ${e.runtimeType}.');
    return;
  }

  if (errs.isEmpty) {
    print('Success!');
  } else {
    errs.forEach(print);
  }
}
```

<details>
  <summary>Solution for redirecting constructors example</summary>

  Your constructor should redirect to `this(0, 0, 0)`.

  ```dart
    Color.black() : this(0, 0, 0);
  ```

</details>

## Const constructors

## Const 构造方法

If your class produces objects that never change, you can make these objects compile-time constants. To
do this, define a `const` constructor and make sure that all instance variables
are final.

如果你的类生成的对象永远都不会更改，
则可以让这些对象成为编译时常量。
为此，请定义 `const` 构造方法并确保所有实例变量都是 final 的。

<?code-excerpt "misc/lib/cheatsheet/redirecting_constructors.dart (const-constructors)"?>
```dart
class ImmutablePoint {
  static const ImmutablePoint origin = ImmutablePoint(0, 0);

  final int x;
  final int y;

  const ImmutablePoint(this.x, this.y);
}
```

### Code example {:.no_toc}

### 代码样例 {:.no_toc}

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

```dartpad
class Recipe {
  List<String> ingredients;
  int calories;
  double milligramsOfSodium;

  // TODO: Create a const constructor here"

}


// Tests your solution (Don't edit!):
void main() {
  final errs = <String>[];

  try {
    const obj = Recipe(['1 egg', 'Pat of butter', 'Pinch salt'], 120, 200);
    
    if (obj.ingredients.length != 3) {
      errs.add('Called Recipe([\'1 egg\', \'Pat of butter\', \'Pinch salt\'], 120, 200) \n and got an object with ingredient list of length ${obj.ingredients.length} rather than the expected length (3).');
    }
    
    if (obj.calories != 120) {
      errs.add('Called Recipe([\'1 egg\', \'Pat of butter\', \'Pinch salt\'], 120, 200) \n and got an object with a calorie value of ${obj.calories} rather than the expected value (120).');
    }
    
    if (obj.milligramsOfSodium != 200) {
      errs.add('Called Recipe([\'1 egg\', \'Pat of butter\', \'Pinch salt\'], 120, 200) \n and got an object with a milligramsOfSodium value of ${obj.milligramsOfSodium} rather than the expected value (200).');
    }
  } catch (e) {
    print('Tried calling Recipe([\'1 egg\', \'Pat of butter\', \'Pinch salt\'], 120, 200) \n and received a null.');
  }

  if (errs.isEmpty) {
    print('Success!');
  } else {
    errs.forEach(print);
  }
}
```

<details>
  <summary>Solution for const constructors example</summary>

  To make the constructor const, you'll need to make all the properties final.

  ```dart
  class Recipe {
    final List<String> ingredients;
    final int calories;
    final double milligramsOfSodium;

    const Recipe(this.ingredients, this.calories, this.milligramsOfSodium);
  }
  ```

</details>

## What's next?

## 接下来呢？

We hope you enjoyed using this tutorial to learn or test your knowledge of
some of the most interesting features of the Dart language.

我们希望你能够喜欢这个教程来学习或测试你对 Dart 语言中一些有趣特性的了解。

What you can try next includes:

接下来你可以尝试：

* Try [other Dart tutorials](/tutorials).

  尝试其他 Dart 教程。

* Read the [Dart language tour](/language).

  阅读 [Dart 语言之旅](/language)。

* Play with [DartPad.]({{site.dartpad}})

  在 [DartPad]({{site.dartpad}}) 上进行练习。

* [Get the Dart SDK](/get-dart).

  [获取 Dart SDK](/get-dart)。
