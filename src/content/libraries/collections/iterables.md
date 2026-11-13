---
# title: Iterable collections
title: 可迭代集合
# description: >-
#   An interactive guide to using Iterable objects such as lists and sets.
description: 可迭代对象（例如列表和集合）的交互式指南
showBreadcrumbs: false
ai-translated: true
---
<?code-excerpt replace="/ *\/\/\s+ignore_for_file:[^\n]+\n//g; /(^|\n) *\/\/\s+ignore:[^\n]+\n/$1/g; /(\n[^\n]+) *\/\/\s+ignore:[^\n]+\n/$1\n/g"?>
<?code-excerpt plaster="none"?>

This tutorial teaches you how to use collections that
implement the [Iterable][iterable class] class—for example
[List][list class] and [Set.][set class]
Iterables are basic building blocks for
all sorts of Dart applications,
and you're probably already using them,
even without noticing.
This tutorial helps you make the most out of them.

本教程将教你如何使用实现了 [Iterable][iterable class] 类的集合，
例如 [List][list class] 和 [Set][set class]。
可迭代对象（Iterable）是各种 Dart 应用的基本构建块，
你可能早已在不知不觉中使用它们了。
本教程将帮助你充分发挥它们的作用。

Using the embedded DartPad editors,
you can test your knowledge by
running example code and completing exercises.

借助内嵌的 DartPad 编辑器，
你可以通过运行示例代码和完成练习
来检验自己的学习成果。

To get the most out of this tutorial,
you should have basic knowledge of [Dart syntax](/language).

要想充分掌握本教程的内容，
你应该具备 [Dart 语法](/language)的基础知识。

This tutorial covers the following material:

本教程涵盖以下内容：

* How to read elements of an Iterable.

  如何读取 Iterable 的元素。
* How to check if the elements of an Iterable satisfy a condition.

  如何检查 Iterable 的元素是否满足某个条件。
* How to filter the contents of an Iterable.

  如何过滤 Iterable 的内容。
* How to map the contents of an Iterable to a different value.

  如何把 Iterable 的内容映射为不同的值。

Estimated time to complete this tutorial: 60 minutes.

完成本教程的预计时间：60 分钟。

:::note
This page uses embedded DartPads to display examples and exercises.

本页面使用内嵌的 DartPads 来展示示例和练习。
{% render 'dartpads-embedded-troubleshooting.md' %}
:::

The exercises in this tutorial have partially completed code snippets.
You can use DartPad to test your knowledge by completing the code and
clicking the **Run** button.
**Don't edit the test code in the `main` function or below**.

本教程中的练习包含只写了一部分的代码片段。
你可以使用 DartPad 补全代码并点击 **Run** 按钮，
来检验自己的学习成果。
**不要修改 `main` 函数中及其之后的测试代码**。

If you need help, expand the **Hint** or **Solution** dropdown
after each exercise.

如果需要帮助，可以展开每个练习后面的
**Hint**（提示）或 **Solution**（答案）下拉框。

## What are collections?

## 什么是集合？

A collection is an object that
represents a group of objects, which are called _elements_. 
Iterables are a kind of collection.

集合（collection）是表示一组对象的对象，
这些对象称为_元素_（element）。
可迭代对象（Iterable）就是一种集合。

A collection can be empty, or it can contain many elements.
Depending on the purpose,
collections can have different structures and implementations.
These are some of the most common collection types:

集合可以是空的，也可以包含许多元素。
根据用途的不同，
集合可以有不同的结构和实现。
下面是一些最常见的集合类型：

* [List:][list class] Used to read elements by their indexes.

  [List][list class]：用于按索引读取元素。
* [Set:][set class] Used to contain elements that can occur only once.

  [Set][set class]：用于存放只能出现一次的元素。
* [Map:][map class] Used to read elements using a key.

  [Map][map class]：用于按键读取元素。


## What is an Iterable?

## 什么是 Iterable？

An `Iterable` is a collection of elements that can be accessed sequentially.

`Iterable` 是可以按顺序访问其元素的集合。

In Dart, an `Iterable` is an abstract class,
meaning that you can't instantiate it directly.
However, you can create a new `Iterable` by creating a new `List` or `Set`.

在 Dart 中，`Iterable` 是一个抽象类，
这意味着你不能直接实例化它。
不过，你可以通过创建新的 `List` 或 `Set` 来得到一个新的 `Iterable`。

Both `List` and `Set` are `Iterable`,
so they have the same methods and properties as the `Iterable` class.

`List` 和 `Set` 都是 `Iterable`，
所以它们拥有与 `Iterable` 类相同的方法和属性。

A `Map` uses a different data structure internally,
depending on its implementation.
For example, [HashMap][hashmap class] uses a hash table
in which the elements (also called _values_) are obtained using a key.
Elements of a `Map` can also be read as `Iterable` objects
by using the map's `entries` or `values` property.

`Map` 在内部使用了不同的数据结构，
具体取决于它的实现。
例如，[HashMap][hashmap class] 使用哈希表，
其中的元素（也称为_值_，value）通过键来获取。
`Map` 的元素也可以通过 map 的 `entries` 或 `values` 属性
以 `Iterable` 对象的形式读取。

This example shows a `List` of `int`,
which is also an `Iterable` of `int`:

这个示例展示了一个 `int` 的 `List`，
它同时也是一个 `int` 的 `Iterable`：

<?code-excerpt "iterables/test/iterables_test.dart (iterable)"?>
```dart
Iterable<int> iterable = [1, 2, 3];
```

The difference with a `List` is that with the `Iterable`,
you can't guarantee that reading elements by index will be efficient.
`Iterable`, as opposed to `List`, doesn't have the `[]` operator.

与 `List` 的区别在于，对于 `Iterable`，
你无法保证按索引读取元素是高效的。
与 `List` 不同，`Iterable` 没有 `[]` 运算符。

For example, consider the following code, which is **invalid**:

例如，看看下面这段**无效**的代码：

<?code-excerpt "iterables/test/iterables_test.dart (iterable-elementat)" replace="/\.elementAt\(1\)/[![1]!]/g"?>
```dart tag=bad
Iterable<int> iterable = [1, 2, 3];
int value = iterable[![1]!];
```

If you read elements with `[]`,
the compiler tells you that the operator `'[]'`
isn't defined for the class `Iterable`,
which means that you can't use `[index]` in this case.

如果你用 `[]` 读取元素，
编译器会告诉你 `Iterable` 类没有定义 `'[]'` 运算符，
也就是说这种情况下你不能使用 `[index]`。

You can instead read elements with `elementAt()`,
which can step through the items of the iterable until
it reaches the item at that position.

你可以改用 `elementAt()` 读取元素，
它会逐个遍历可迭代对象中的项，
直到到达指定位置的那一项。

<?code-excerpt "iterables/test/iterables_test.dart (iterable-elementat)"?>
```dart
Iterable<int> iterable = [1, 2, 3];
int value = iterable.elementAt(1);
```

Depending on the iterable implementation and number of items,
`elementAt` can have a linear complexity and be expensive.
If you plan to access specific items repeatedly, then consider
calling `.toList()` on the iterable to convert it to a list once,
then use the `[]` operator.

取决于可迭代对象的实现和元素数量，
`elementAt` 可能具有线性复杂度，开销较大。
如果你打算反复访问特定的项，可以考虑
先对可迭代对象调用一次 `.toList()` 把它转换成列表，
然后使用 `[]` 运算符。

<?code-excerpt "iterables/test/iterables_test.dart (iterable-to-list)"?>
```dart
final items = veryLargeIterable().toList();

final tenthItem = items[9];
final hundredthItem = items[99];
final thousandthItem = items[999];
final lastItem = items.last;
```

Continue to the next section to learn more about
how to access elements of an `Iterable`.

继续阅读下一节，进一步了解
如何访问 `Iterable` 的元素。

## Reading elements

## 读取元素

You can read the elements of an iterable sequentially,
using a `for-in` loop.

你可以使用 `for-in` 循环
按顺序读取可迭代对象的元素。

### Example: Using a for-in loop

### 示例：使用 for-in 循环

The following example shows you how to read elements using  a `for-in` loop.

下面的示例展示了如何使用 `for-in` 循环读取元素。

<?code-excerpt "iterables/test/iterables_test.dart (for-in)"?>
```dartpad
void main() {
  const iterable = ['Salad', 'Popcorn', 'Toast'];
  for (final element in iterable) {
    print(element);
  }
}
```

:::note Details
Behind the scenes, the `for-in` loop uses an _iterator._
You rarely see the [Iterator API][iterator class] used directly, however,
because `for-in` is easier to read and understand,
and is less prone to errors.

在底层，`for-in` 循环使用的是_迭代器_（iterator）。
不过你很少会直接使用 [Iterator API][iterator class]，
因为 `for-in` 更容易阅读和理解，
也更不容易出错。
:::

:::secondary Key terms
* **Iterable**: The Dart [Iterable][iterable class] class.

  **Iterable**：Dart 的 [Iterable][iterable class] 类。
* **Iterator**: An object used by `for-in` to read elements from
  an `Iterable` object.

  **Iterator**（迭代器）：`for-in` 用来从 `Iterable` 对象中
  读取元素的对象。
* **`for-in` loop**: An easy way to sequentially read elements from
  an `Iterable`.

  **`for-in` 循环**：从 `Iterable` 中按顺序读取元素的
  一种简便方式。
:::

### Example: Using first and last

### 示例：使用 first 和 last

In some cases, you want to access only the first or the last element
of an `Iterable`.

在某些情况下，你只想访问 `Iterable` 的
第一个或最后一个元素。

With the `Iterable` class, you can't access the elements directly,
so you can't call `iterable[0]` to access the first element.
Instead, you can use `first`,
which gets the first element.

对于 `Iterable` 类，你不能直接访问元素，
所以不能通过 `iterable[0]` 来获取第一个元素。
你可以改用 `first`，
它会返回第一个元素。

Also, with the `Iterable` class,
you can't use the operator `[]` to access the last element,
but you can use the `last` property.

同样，对于 `Iterable` 类，
你不能用 `[]` 运算符访问最后一个元素，
但可以使用 `last` 属性。

:::warning
Because accessing the last element of an `Iterable` requires
stepping through all the other elements,
**`last` can be slow.**
Using `first` or `last` on an **empty `Iterable`**
results in a [StateError.][StateError class]

由于访问 `Iterable` 的最后一个元素需要
逐个遍历所有其他元素，
**`last` 可能会很慢。**
在**空的 `Iterable`** 上使用 `first` 或 `last`
会导致 [StateError][StateError class]。
:::

<?code-excerpt "iterables/test/iterables_test.dart (first-last)"?>
```dartpad
void main() {
  Iterable<String> iterable = const ['Salad', 'Popcorn', 'Toast'];
  print('The first element is ${iterable.first}');
  print('The last element is ${iterable.last}');
}
```

In this example you saw how to use `first` and `last` to
get the first and last elements of an `Iterable`.
It's also possible to find the first element that satisfies a condition.
The next section shows how to do that using a method called `firstWhere()`.

在这个示例中，你看到了如何使用 `first` 和 `last`
获取 `Iterable` 的第一个和最后一个元素。
你还可以找到第一个满足某个条件的元素。
下一节将展示如何使用 `firstWhere()` 方法做到这一点。

### Example: Using firstWhere()

### 示例：使用 firstWhere()

You already saw that you can access the elements of an `Iterable` sequentially,
and you can easily get the first or last element.

你已经知道可以按顺序访问 `Iterable` 的元素，
也可以轻松获取第一个或最后一个元素。

Now, you learn how to use `firstWhere()` to find the first element that
satisfies certain conditions.
This method requires you to pass a _predicate_,
which is a function that returns true if
the input satisfies a certain condition.

现在，你将学习如何使用 `firstWhere()` 找到
第一个满足特定条件的元素。
这个方法需要你传入一个_谓词_（predicate），
它是一个函数：当输入满足某个条件时返回 true。

<?code-excerpt "iterables/test/iterables_test.dart (firstwhere)"?>
```dart
String element = iterable.firstWhere((element) => element.length > 5);
```

For example, if you want to find the first `String` that has
more than 5 characters,
you must pass a predicate that returns true when
the element size is greater than 5.

例如，如果你想找到第一个长度超过 5 个字符的 `String`，
就必须传入一个在元素长度大于 5 时
返回 true 的谓词。

Run the following example to see how `firstWhere()` works.
Do you think all the functions will give the same result?

运行下面的示例，看看 `firstWhere()` 是如何工作的。
你觉得所有函数都会给出相同的结果吗？

<?code-excerpt "iterables/test/iterables_test.dart (first-where-long)"?>
```dartpad
bool predicate(String item) {
  return item.length > 5;
}

void main() {
  const items = ['Salad', 'Popcorn', 'Toast', 'Lasagne'];

  // You can find with a simple expression:
  var foundItem1 = items.firstWhere((item) => item.length > 5);
  print(foundItem1);

  // Or try using a function block:
  var foundItem2 = items.firstWhere((item) {
    return item.length > 5;
  });
  print(foundItem2);

  // Or even pass in a function reference:
  var foundItem3 = items.firstWhere(predicate);
  print(foundItem3);

  // You can also use an `orElse` function in case no value is found!
  var foundItem4 = items.firstWhere(
    (item) => item.length > 10,
    orElse: () => 'None!',
  );
  print(foundItem4);
}
```

In this example, you can see three different ways to write a predicate:

在这个示例中，你可以看到编写谓词的三种不同方式：

* **As an expression:**
  The test code has one line that uses arrow syntax (`=>`).

  **作为表达式：**
  测试代码只有一行，使用箭头语法（`=>`）。
* **As a block:**
  The test code has multiple lines between brackets and a return statement.

  **作为代码块：**
  测试代码在花括号之间有多行，并带有 return 语句。
* **As a function:**
  The test code is in an external function that's passed to
  the `firstWhere()` method as a parameter.

  **作为函数：**
  测试代码位于一个外部函数中，
  该函数作为参数传给 `firstWhere()` 方法。

There is no right or wrong way.
Use the way that works best for you, 
and that makes your code easier to read and understand.

这些方式没有对错之分。
选择最适合你的方式，
让你的代码更容易阅读和理解。

The final example calls `firstWhere()` with
the optional named parameter `orElse`,
which provides an alternative when an element isn't found.
In this case, the text `'None!'` is returned because
no element satisfies the provided condition.

最后一个示例调用 `firstWhere()` 时
使用了可选的命名参数 `orElse`，
它在找不到元素时提供一个替代值。
在这个例子中，由于没有元素满足给定条件，
返回的是文本 `'None!'`。

:::note
If no element satisfies the test predicate and
the `orElse` parameter isn't provided,
then `firstWhere()` throws a [StateError.][StateError class]

如果没有元素满足测试谓词，
且没有提供 `orElse` 参数，
那么 `firstWhere()` 会抛出 [StateError][StateError class]。
:::

:::secondary Quick review
* The elements of an `Iterable` must be accessed sequentially.

  `Iterable` 的元素必须按顺序访问。
* The easiest way to iterate through all the elements is
  using a `for-in` loop.

  遍历所有元素最简单的方式
  是使用 `for-in` 循环。
* You can use the `first` and `last` getters to get
  the first and last elements.

  你可以使用 `first` 和 `last` getter
  获取第一个和最后一个元素。
* You can also find the first element that
  satisfies a condition with `firstWhere()`.

  你还可以用 `firstWhere()` 找到
  第一个满足条件的元素。
* You can write test predicates as expressions, blocks, or functions.

  你可以把测试谓词写成表达式、代码块或函数。

  **Key terms:**

  **关键术语：**
* **Predicate:**
  A function that returns `true` when a certain condition is satisfied.

  **谓词（Predicate）：**
  当满足某个条件时返回 `true` 的函数。
:::

### Exercise: Practice writing a test predicate

### 练习：编写测试谓词

The following exercise is a failing unit test that
contains a partially complete code snippet.
Your task is to complete the exercise by writing code to make the tests pass.
You don't need to implement `main()`.

下面的练习是一个未通过的单元测试，
其中包含只写了一部分的代码片段。
你的任务是编写代码让测试通过，完成这个练习。
你不需要实现 `main()`。

This exercise introduces `singleWhere()`
This method works similarly to `firstWhere()`,
but in this case it expects only one element of the `Iterable` to
satisfy the predicate.
If more than one or no element in the `Iterable`
satisfies the predicate condition,
then the method throws a [StateError][StateError class] exception.

这个练习引入了 `singleWhere()`。
这个方法的工作方式与 `firstWhere()` 类似，
但在这里它要求 `Iterable` 中只有一个元素
满足谓词。
如果 `Iterable` 中有多于一个或没有元素
满足谓词条件，
该方法就会抛出 [StateError][StateError class] 异常。

:::warning
`singleWhere()` steps through the whole `Iterable` until the last element,
which can cause problems if the `Iterable` is infinite or
contains a large collection of elements.

`singleWhere()` 会遍历整个 `Iterable` 直到最后一个元素，
如果 `Iterable` 是无限的，
或者包含大量元素，这可能会带来问题。
:::

Your goal is to implement the predicate for `singleWhere()` that
satisfies the following conditions:

你的目标是为 `singleWhere()` 实现一个谓词，
使其满足以下条件：

* The element contains the character `'a'`.

  元素包含字符 `'a'`。
* The element starts with the character `'M'`.

  元素以字符 `'M'` 开头。

All the elements in the test data are [strings][String class];
you can check the class documentation for help.

测试数据中的所有元素都是[字符串][String class]；
你可以查阅该类的文档获取帮助。

```dartpad theme="dark"
// Implement the predicate of singleWhere
// with the following conditions
// * The element contains the character `'a'`
// * The element starts with the character `'M'`
String singleWhere(Iterable<String> items) {
  return items.singleWhere(TODO('Implement the outlined predicate.'));
}

// The following code is used to provide feedback on your solution.
// There is no need to read or modify it.
void main() {
  const items = [
    'Salad',
    'Popcorn',
    'Milk',
    'Toast',
    'Sugar',
    'Mozzarella',
    'Tomato',
    'Egg',
    'Water',
  ];

  try {
    final str = singleWhere(items);
    if (str == 'Mozzarella') {
      print('Success. All tests passed!');
    } else {
      print(
        'Tried calling singleWhere, but received $str instead of '
        'the expected value \'Mozzarella\'',
      );
    }
  } on StateError catch (stateError) {
    print(
      'Tried calling singleWhere, but received a StateError: ${stateError.message}. '
      'singleWhere will fail if 0 or many elements match the predicate.',
    );
  } on UnimplementedError {
    print(
      'Tried running `singleWhere`, but received an error. '
      'Did you implement the function?',
    );
  } catch (e) {
    print('Tried calling singleWhere, but received an exception: $e');
  }
}
```

<details>
  <summary title="Expand for a hint on the predicate exercise.">Hint</summary>

  Your solution might make use of the `contains` and `startsWith`
  methods from the `String` class.

  你的解法可能会用到 `String` 类的
  `contains` 和 `startsWith` 方法。

</details>

<details>
  <summary title="Expand for the solution of the predicate exercise.">Solution</summary>

  ```dart
  String singleWhere(Iterable<String> items) {
    return items.singleWhere(
            (element) => element.startsWith('M') && element.contains('a'));
  }
  ```

</details>

## Checking conditions

## 检查条件

When working with `Iterable`, sometimes you need to verify that
all the elements of a collection satisfy some condition.

在使用 `Iterable` 时，有时你需要验证
集合中的所有元素都满足某个条件。

You might be tempted to write a solution using a `for-in` loop like this one:

你可能会想写出一个像下面这样使用 `for-in` 循环的解法：

<?code-excerpt "iterables/test/iterables_test.dart (every-bad)"?>
```dart tag=bad
for (final item in items) {
  if (item.length < 5) {
    return false;
  }
}
return true;
```

However, you can accomplish the same using the `every()` method:

不过，你可以用 `every()` 方法达到同样的效果：

<?code-excerpt "iterables/test/iterables_test.dart (every-good)"?>
```dart
return items.every((item) => item.length >= 5);
```

Using the `every()` method results in code that is more
readable, compact, and less error-prone.

使用 `every()` 方法能让代码
更可读、更紧凑，也更不容易出错。

### Example: Using any() and every()

### 示例：使用 any() 和 every()

The `Iterable` class provides two methods that
you can use to verify conditions:

`Iterable` 类提供了两个方法，
可以用来验证条件：

* `any()`: Returns true if at least one element satisfies the condition.

  `any()`：只要至少有一个元素满足条件就返回 true。
* `every()`: Returns true if all elements satisfy the condition.

  `every()`：所有元素都满足条件才返回 true。

Run this exercise to see them in action.

运行这个练习，看看它们的实际效果。

<?code-excerpt "iterables/test/iterables_test.dart (any-every)"?>
```dartpad
void main() {
  const items = ['Salad', 'Popcorn', 'Toast'];

  if (items.any((item) => item.contains('a'))) {
    print('At least one item contains "a"');
  }

  if (items.every((item) => item.length >= 5)) {
    print('All items have length >= 5');
  }
}
```

In the example, `any()` verifies that
at least one element contains the character `a`,
and `every()` verifies that all elements
have a length equal to or greater than 5.

在这个示例中，`any()` 验证
至少有一个元素包含字符 `a`，
而 `every()` 验证所有元素的长度
都大于或等于 5。

After running the code, try changing the predicate of `any()` so
it returns false:

运行代码后，试着修改 `any()` 的谓词，
让它返回 false：

<?code-excerpt "iterables/test/iterables_test.dart (any-false)"?>
```dart
if (items.any((item) => item.contains('Z'))) {
  print('At least one item contains "Z"');
} else {
  print('No item contains "Z"');
}
```

You can also use `any()` to verify that no element of an `Iterable`
satisfies a certain condition.

你也可以用 `any()` 来验证 `Iterable` 中
没有元素满足某个条件。


### Exercise: Verify that an Iterable satisfies a condition

### 练习：验证 Iterable 满足条件

The following exercise provides practice using the
`any()` and `every()` methods, described in the previous example.
In this case, you work with a group of users,
represented by `User` objects that have the member field `age`.

下面的练习让你使用上一个示例中介绍的
`any()` 和 `every()` 方法进行练习。
这次你要处理一组用户，
它们由带有成员字段 `age` 的 `User` 对象表示。

Use `any()` and `every()` to implement two functions:

使用 `any()` 和 `every()` 实现两个函数：

* Part 1: Implement `anyUserUnder18()`.

  第 1 部分：实现 `anyUserUnder18()`。
  * Return `true` if at least one user is 17 or younger.

    如果至少有一个用户的年龄在 17 岁及以下，返回 `true`。
* Part 2: Implement `everyUserOver13()`.

  第 2 部分：实现 `everyUserOver13()`。
  * Return `true` if all users are 14 or older.

    如果所有用户的年龄都在 14 岁及以上，返回 `true`。

```dartpad
bool anyUserUnder18(Iterable<User> users) {
  // TODO: Implement the anyUserUnder18 function.
}

bool everyUserOver13(Iterable<User> users) {
  // TODO: Implement the everyUserOver13 function.
}

class User {
  final String name;
  final int age;

  User(
    this.name,
    this.age,
  );
}

// The following code is used to provide feedback on your solution.
// There is no need to read or modify it.
void main() {
  final users = [
    User('Alice', 21),
    User('Bob', 17),
    User('Claire', 52),
    User('David', 14),
  ];

  try {
    final out = anyUserUnder18(users);
    if (!out) {
      print('Looks like `anyUserUnder18` is wrong. Keep trying!');
      return;
    }
  } on UnimplementedError {
    print(
      'Tried running `anyUserUnder18`, but received an error. '
      'Did you implement the function?',
    );
    return;
  } catch (e) {
    print('Tried running `anyUserUnder18`, but received an exception: $e');
    return;
  }

  try {
    // with only one user older than 18, should be false
    final out = anyUserUnder18([User('Alice', 21)]);
    if (out) {
      print(
          'Looks like `anyUserUnder18` is wrong. What if all users are over 18?');
      return;
    }
  } on UnimplementedError {
    print(
      'Tried running `anyUserUnder18`, but received an error. '
      'Did you implement the function?',
    );
    return;
  } catch (e) {
    print(
      'Tried running `anyUserUnder18([User("Alice", 21)])`, '
      'but received an exception: $e',
    );
    return;
  }

  try {
    final out = everyUserOver13(users);
    if (!out) {
      print(
        'Looks like `everyUserOver13` is wrong. '
        'There are no users under 13!',
      );
      return;
    }
  } on UnimplementedError {
    print(
      'Tried running `everyUserOver13`, but received an error. '
      'Did you implement the function?',
    );
    return;
  } catch (e) {
    print(
      'Tried running `everyUserOver13`, '
      'but received an exception: $e',
    );
    return;
  }

  try {
    final out = everyUserOver13([User('Dan', 12)]);
    if (out) {
      print(
        'Looks like `everyUserOver13` is wrong. '
        'There is at least one user under 13!',
      );
      return;
    }
  } on UnimplementedError {
    print(
      'Tried running `everyUserOver13`, but received an error. '
      'Did you implement the function?',
    );
    return;
  } catch (e) {
    print(
      'Tried running `everyUserOver13([User(\'Dan\', 12)])`, '
      'but received an exception: $e',
    );
    return;
  }

  print('Success. All tests passed!');
}
```

<details>
  <summary title="Expand for a hint on the conditional filtering exercise.">Hint</summary>

  Remember to use the `any` and `every` methods from the `Iterable` class.
  For help and examples using these methods, refer to
  the [earlier discussion of them](#example-using-any-and-every).

  记得使用 `Iterable` 类的 `any` 和 `every` 方法。
  关于这些方法的帮助和示例，请参阅
  [前面对它们的介绍](#example-using-any-and-every)。

</details>

<details>
  <summary title="Expand for the solution of the conditional filtering exercise.">Solution</summary>

  ```dart
  bool anyUserUnder18(Iterable<User> users) {
    return users.any((user) => user.age < 18);
  }
  
  bool everyUserOver13(Iterable<User> users) {
    return users.every((user) => user.age > 13);
  }
  ```

</details>

:::secondary Quick review
* Although you can use `for-in` loops to check conditions,
  there are better ways to do that.

  虽然你可以用 `for-in` 循环检查条件，
  但有更好的方式。
* The method `any()` enables you to check whether
  any element satisfies a condition.

  `any()` 方法让你检查
  是否有任意元素满足条件。
* The method `every()` enables you to verify that
  all elements satisfy a condition.

  `every()` 方法让你验证
  所有元素都满足条件。
:::

## Filtering

## 过滤

The previous sections cover methods like `firstWhere()` or
`singleWhere()` that can help you find an element that
satisfies a certain predicate.

前面几节介绍了 `firstWhere()`、`singleWhere()` 等方法，
它们可以帮你找到满足某个谓词的
一个元素。

But what if you want to find all the elements that
satisfy a certain condition?
You can accomplish that using the `where()` method.

但如果你想找到满足某个条件的
所有元素呢？
你可以使用 `where()` 方法做到这一点。

<?code-excerpt "iterables/test/iterables_test.dart (where)"?>
```dart
var evenNumbers = numbers.where((number) => number.isEven);
```

In this example,
`numbers` contains an `Iterable` with multiple `int` values, and
`where()` finds all the numbers that are even.

在这个示例中，
`numbers` 是一个包含多个 `int` 值的 `Iterable`，
`where()` 找出其中所有的偶数。

The output of `where()` is another `Iterable`,
and you can use it as such to iterate over it or
apply other `Iterable` methods.
In the next example, the output of `where()`
is used directly inside the `for-in` loop.

`where()` 的输出是另一个 `Iterable`，
你可以像使用普通 `Iterable` 一样遍历它，
或对它应用其他 `Iterable` 方法。
在下一个示例中，`where()` 的输出
被直接用在 `for-in` 循环里。

<?code-excerpt "iterables/test/iterables_test.dart (where-for)"?>
```dart
var evenNumbers = numbers.where((number) => number.isEven);
for (final number in evenNumbers) {
  print('$number is even');
}
```

### Example: Using where()

### 示例：使用 where()

Run this example to see how `where()` can be used together with other
methods like `any()`.

运行这个示例，看看 `where()` 如何与
`any()` 等其他方法配合使用。

<?code-excerpt "iterables/test/iterables_test.dart (numbers-where)"?>
```dartpad
void main() {
  var evenNumbers = const [1, -2, 3, 42].where((number) => number.isEven);

  for (final number in evenNumbers) {
    print('$number is even.');
  }

  if (evenNumbers.any((number) => number.isNegative)) {
    print('evenNumbers contains negative numbers.');
  }

  // If no element satisfies the predicate, the output is empty.
  var largeNumbers = evenNumbers.where((number) => number > 1000);
  if (largeNumbers.isEmpty) {
    print('largeNumbers is empty!');
  }
}
```

In this example, `where()` is used to find all numbers that are even, then
`any()` is used to check if the results contain a negative number.

在这个示例中，`where()` 用于找出所有偶数，
然后 `any()` 用于检查结果中是否包含负数。

Later in the example, `where()` is used again to
find all numbers larger than 1000.
Because there are none, the result is an empty `Iterable`.

在示例的后面，再次使用 `where()`
找出所有大于 1000 的数。
由于没有这样的数，结果是一个空的 `Iterable`。

:::note
If no element satisfies the predicate in `where()`,
then the method returns an empty `Iterable`.
Unlike `singleWhere()` or `firstWhere()`,
`where()` doesn't throw a [StateError][StateError class] exception.

如果 `where()` 中没有元素满足谓词，
该方法会返回一个空的 `Iterable`。
与 `singleWhere()` 或 `firstWhere()` 不同，
`where()` 不会抛出 [StateError][StateError class] 异常。
:::

### Example: Using takeWhile

### 示例：使用 takeWhile

The methods `takeWhile()` and `skipWhile()` can also
help you filter elements from an `Iterable`.

`takeWhile()` 和 `skipWhile()` 方法也可以
帮你从 `Iterable` 中过滤元素。

Run this example to see how `takeWhile()` and `skipWhile()` can
split an `Iterable` containing numbers.

运行这个示例，看看 `takeWhile()` 和 `skipWhile()`
如何拆分一个包含数字的 `Iterable`。

<?code-excerpt "iterables/test/iterables_test.dart (take-while-long)"?>
```dartpad
void main() {
  const numbers = [1, 3, -2, 0, 4, 5];

  var numbersUntilZero = numbers.takeWhile((number) => number != 0);
  print('Numbers until 0: $numbersUntilZero');

  var numbersStartingAtZero = numbers.skipWhile((number) => number != 0);
  print('Numbers starting at 0: $numbersStartingAtZero');
}
```

In this example, `takeWhile()` returns an `Iterable` that
contains all the elements before the one that
satisfies the predicate.
On the other hand, `skipWhile()` returns an `Iterable` 
that contains all elements after and including the first one
that _doesn't_ satisfy the predicate.

在这个示例中，`takeWhile()` 返回一个 `Iterable`，
它包含满足谓词的那个元素之前的
所有元素。
另一方面，`skipWhile()` 返回一个 `Iterable`，
它包含第一个_不_满足谓词的元素及其之后的
所有元素。

After running the example,
change `takeWhile()` to take elements until
it reaches the first negative number.

运行示例后，
修改 `takeWhile()`，让它取元素直到
遇到第一个负数为止。

<?code-excerpt "iterables/test/iterables_test.dart (takewhile)"?>
```dart
var numbersUntilNegative = numbers.takeWhile(
  (number) => !number.isNegative,
);
```

Notice that the condition `number.isNegative` is negated with `!`.

注意条件 `number.isNegative` 用 `!` 取反了。

### Exercise: Filtering elements from a list

### 练习：从列表中过滤元素

The following exercise provides practice using the `where()` method with 
the class `User` from the previous exercise.

下面的练习让你对上一个练习中的 `User` 类
使用 `where()` 方法进行练习。

Use `where()` to implement two functions:

使用 `where()` 实现两个函数：

* Part 1: Implement `filterOutUnder21()`.

  第 1 部分：实现 `filterOutUnder21()`。
  * Return an `Iterable` containing all users of age 21 or more.

    返回一个包含所有年龄在 21 岁及以上用户的 `Iterable`。
* Part 2: Implement `findShortNamed()`.

  第 2 部分：实现 `findShortNamed()`。
  * Return an `Iterable` containing all users with
    names of length 3 or less.

    返回一个 `Iterable`，包含所有
    名字长度不超过 3 的用户。

```dartpad theme="dark"
Iterable<User> filterOutUnder21(Iterable<User> users) {
  // TODO: Implement the filterOutUnder21 function.
}

Iterable<User> findShortNamed(Iterable<User> users) {
  // TODO: Implement the findShortNamed function.
}

class User {
  final String name;
  final int age;

  User(
    this.name,
    this.age,
  );
}

// The following code is used to provide feedback on your solution.
// There is no need to read or modify it.
void main() {
  final users = [
    User('Alice', 21),
    User('Bob', 17),
    User('Claire', 52),
    User('Dan', 12),
  ];

  try {
    final out = filterOutUnder21(users);
    if (out.any((user) => user.age < 21) || out.length != 2) {
      print(
        'Looks like `filterOutUnder21` is wrong, there are '
        'exactly two users with age under 21. Keep trying!',
      );
      return;
    }
  } on UnimplementedError {
    print(
      'Tried running `filterOutUnder21`, but received an error. '
      'Did you implement the function?',
    );
    return;
  } catch (e) {
    print(
      'Tried running `filterOutUnder21`, '
      'but received an exception: ${e.runtimeType}',
    );
    return;
  }

  try {
    final out = findShortNamed(users);
    if (out.any((user) => user.name.length > 3) || out.length != 2) {
      print(
        'Looks like `findShortNamed` is wrong, there are '
        'exactly two users with a three letter name. Keep trying!',
      );
      return;
    }
  } on UnimplementedError {
    print(
      'Tried running `findShortNamed`, but received an error. '
      'Did you implement the function?',
    );
    return;
  } catch (e) {
    print(
      'Tried running `findShortNamed`, '
      'but received an exception: ${e.runtimeType}',
    );
    return;
  }

  print('Success. All tests passed!');
}
```

<details>
  <summary title="Expand for a hint on the filtering elements exercise.">Hint</summary>

  Remember to take advantage of the `where` method from the `Iterable` class.
  For help and examples using `where`, refer to
  the [earlier discussion of it](#example-using-where).

  记得利用 `Iterable` 类的 `where` 方法。
  关于 `where` 的帮助和示例，请参阅
  [前面对它的介绍](#example-using-where)。

</details>

<details>
  <summary title="Expand for the solution of the filtering elements exercise.">Solution</summary>

  ```dart
  Iterable<User> filterOutUnder21(Iterable<User> users) {
    return users.where((user) => user.age >= 21);
  }
  
  Iterable<User> findShortNamed(Iterable<User> users) {
    return users.where((user) => user.name.length <= 3);
  }
  ```

</details>

:::secondary Quick review
* Filter the elements of an `Iterable` with `where()`.

  用 `where()` 过滤 `Iterable` 的元素。
* The output of `where()` is another `Iterable`.

  `where()` 的输出是另一个 `Iterable`。
* Use `takeWhile()` and `skipWhile()` to obtain elements until or after
  a condition is met.

  用 `takeWhile()` 和 `skipWhile()` 获取满足条件之前
  或之后的元素。
* The output of these methods can be an empty `Iterable`.

  这些方法的输出可能是一个空的 `Iterable`。
:::

## Mapping

## 映射

Mapping `Iterables` with the method `map()` enables you to
apply a function over each of the elements,
replacing each element with a new one.

用 `map()` 方法映射 `Iterable`，
可以对每个元素应用一个函数，
把每个元素替换为一个新的元素。

<?code-excerpt "iterables/test/iterables_test.dart (map-int)"?>
```dart
Iterable<int> output = numbers.map((number) => number * 10);
```

In this example, each element of the `Iterable` numbers is multiplied by 10.

在这个示例中，`Iterable` numbers 的每个元素都乘以了 10。

You can also use `map()` 
to transform an element into a different object—for example, 
to convert all `int` to `String`,
as you can see in the following example:

你也可以用 `map()`
把元素转换成不同的对象——例如，
把所有 `int` 转换为 `String`，
正如下面的示例所示：

<?code-excerpt "iterables/test/iterables_test.dart (map-string)"?>
```dart
Iterable<String> output = numbers.map((number) => number.toString());
```

:::note
`map()` returns a _lazy_ `Iterable`, meaning that the supplied function
is called only when the elements are iterated.

`map()` 返回一个_惰性_（lazy）的 `Iterable`，
这意味着只有在遍历元素时，传入的函数才会被调用。
:::

### Example: Using map to change elements

### 示例：用 map 修改元素

Run this example to see how to use `map()` to
multiply all the elements of an `Iterable` by 2.
What do you think the output will be?

运行这个示例，看看如何用 `map()`
把 `Iterable` 的所有元素都乘以 2。
你觉得输出会是什么？

<?code-excerpt "iterables/test/iterables_test.dart (numbers-by-two)"?>
```dartpad
void main() {
  var numbersByTwo = const [1, -2, 3, 42].map((number) => number * 2);
  print('Numbers: $numbersByTwo');
}
```


### Exercise: Mapping to a different type

### 练习：映射为不同的类型

In the previous example, you multiplied the elements of an `Iterable` by 2.
Both the input and the output of that operation were an `Iterable` of `int`.

在上一个示例中，你把 `Iterable` 的元素都乘以了 2。
该操作的输入和输出都是 `int` 的 `Iterable`。

In this exercise, your code takes an `Iterable` of `User`,
and you need to return an `Iterable` that
contains strings containing each user's name and age.

在这个练习中，你的代码接收一个 `User` 的 `Iterable`，
你需要返回一个 `Iterable`，
其中的字符串包含每个用户的名字和年龄。

Each string in the `Iterable` must follow this format:
`'{name} is {age}'`—for example `'Alice is 21'`.

`Iterable` 中的每个字符串都必须遵循这个格式：
`'{name} is {age}'`——例如 `'Alice is 21'`。

```dartpad theme="dark"
Iterable<String> getNameAndAges(Iterable<User> users) {
  // TODO: Implement the getNameAndAges function.
}

class User {
  final String name;
  final int age;

  User(
    this.name,
    this.age,
  );
}

// The following code is used to provide feedback on your solution.
// There is no need to read or modify it.
void main() {
  final users = [
    User('Alice', 21),
    User('Bob', 17),
    User('Claire', 52),
  ];

  try {
    final out = getNameAndAges(users).toList();
    if (!_listEquals(out, ['Alice is 21', 'Bob is 17', 'Claire is 52'])) {
      print(
        'Looks like `getNameAndAges` is wrong. Keep trying! '
        'The output was: $out',
      );
      return;
    }
  } on UnimplementedError {
    print(
      'Tried running `getNameAndAges`, but received an error. '
      'Did you implement the function?',
    );
    return;
  } catch (e) {
    print('Tried running the function, but received an exception: $e');
    return;
  }

  print('Success. All tests passed!');
}

bool _listEquals<T>(List<T>? a, List<T>? b) {
  if (a == null) return b == null;
  if (b == null || a.length != b.length) return false;
  for (var index = 0; index < a.length; index += 1) {
    if (a[index] != b[index]) return false;
  }
  return true;
}
```

<details>
  <summary title="Expand for a hint on the mapping elements exercise.">Hint</summary>

  Remember to take advantage of the `map` method from the `Iterable` class.
  For help and examples using `map`, refer to
  the [earlier discussion of it](#example-using-map-to-change-elements).

  记得利用 `Iterable` 类的 `map` 方法。
  关于 `map` 的帮助和示例，请参阅
  [前面对它的介绍](#example-using-map-to-change-elements)。

  To concatenate multiple values into a single string, consider
  using [string interpolation](/language/built-in-types#string-interpolation).

  要把多个值拼接成一个字符串，可以考虑
  使用[字符串插值](/language/built-in-types#string-interpolation)。

</details>

<details>
  <summary title="Expand for the solution of the mapping elements exercise.">Solution</summary>

  ```dart
  Iterable<String> getNameAndAges(Iterable<User> users) {
    return users.map((user) => '${user.name} is ${user.age}');
  }
  ```

</details>

:::secondary Quick review
* `map()` applies a function to all the elements of an `Iterable`.

  `map()` 对 `Iterable` 的所有元素应用一个函数。
* The output of `map()` is another `Iterable`.

  `map()` 的输出是另一个 `Iterable`。
* The function isn't evaluated until the `Iterable` is iterated.

  在 `Iterable` 被遍历之前，函数不会被求值。
:::

## Exercise: Putting it all together

## 练习：综合运用

It's time to practice what you learned, in one final exercise.

是时候在最后一个练习中实践你所学的内容了。

This exercise provides the class `EmailAddress`,
which has a constructor that takes a string.
Another provided function is `isValidEmailAddress()`,
which tests whether an email address is valid.

这个练习提供了 `EmailAddress` 类，
它有一个接受字符串的构造函数。
另一个提供的函数是 `isValidEmailAddress()`，
用于测试电子邮件地址是否有效。

| Constructor/function  | Type signature                           | Description                                             |
|-----------------------|------------------------------------------|---------------------------------------------------------|
| EmailAddress()        | `EmailAddress(String address)`           | Creates an `EmailAddress` for the specified address.    | 
| isValidEmailAddress() | `bool isValidEmailAddress(EmailAddress)` | Returns `true` if the provided `EmailAddress` is valid. |

{:.table .table-striped}

Write the following code:

请编写以下代码：

Part 1: Implement `parseEmailAddresses()`.

第 1 部分：实现 `parseEmailAddresses()`。
- Write the function `parseEmailAddresses()`,
  which takes an `Iterable<String>` containing email addresses, 
  and returns an `Iterable<EmailAddress>`.

  编写函数 `parseEmailAddresses()`，
  它接受一个包含电子邮件地址的 `Iterable<String>`，
  并返回一个 `Iterable<EmailAddress>`。
- Use the method `map()` to map from a `String` to `EmailAddress`.

  使用 `map()` 方法把 `String` 映射为 `EmailAddress`。
- Create the `EmailAddress` objects using
  the constructor `EmailAddress(String)`.

  使用构造函数 `EmailAddress(String)`
  创建 `EmailAddress` 对象。

Part 2: Implement `anyInvalidEmailAddress()`.

第 2 部分：实现 `anyInvalidEmailAddress()`。
- Write the function `anyInvalidEmailAddress()`,
  which takes an `Iterable<EmailAddress>` and
  returns `true` if any `EmailAddress` in the `Iterable` isn't valid.

  编写函数 `anyInvalidEmailAddress()`，
  它接受一个 `Iterable<EmailAddress>`，
  如果 `Iterable` 中有任何 `EmailAddress` 无效，就返回 `true`。
- Use the method `any()` together with
  the provided function `isValidEmailAddress()`.

  把 `any()` 方法与提供的函数
  `isValidEmailAddress()` 结合使用。

Part 3: Implement `validEmailAddresses()`.

第 3 部分：实现 `validEmailAddresses()`。
- Write the function `validEmailAddresses()`,
  which takes an `Iterable<EmailAddress>` and
  returns another `Iterable<EmailAddress>` containing only valid addresses.

  编写函数 `validEmailAddresses()`，
  它接受一个 `Iterable<EmailAddress>`，
  并返回另一个只包含有效地址的 `Iterable<EmailAddress>`。
- Use the method `where()` to filter the `Iterable<EmailAddress>`.

  使用 `where()` 方法过滤 `Iterable<EmailAddress>`。
- Use the provided function `isValidEmailAddress()` to evaluate whether
  an `EmailAddress` is valid.

  使用提供的函数 `isValidEmailAddress()`
  来判断 `EmailAddress` 是否有效。

```dartpad theme="dark"
Iterable<EmailAddress> parseEmailAddresses(Iterable<String> strings) {
  // TODO: Implement the parseEmailAddresses function.
}

bool anyInvalidEmailAddress(Iterable<EmailAddress> emails) {
  // TODO: Implement the anyInvalidEmailAddress function.
}

Iterable<EmailAddress> validEmailAddresses(Iterable<EmailAddress> emails) {
  // TODO: Implement the validEmailAddresses function.
}

class EmailAddress {
  final String address;

  EmailAddress(this.address);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmailAddress && address == other.address;

  @override
  int get hashCode => address.hashCode;

  @override
  String toString() => 'EmailAddress{address: $address}';
}

// The following code is used to provide feedback on your solution.
// There is no need to read or modify it.
void main() {
  const input = [
    'ali@gmail.com',
    'bobgmail.com',
    'cal@gmail.com',
  ];

  const correctInput = ['dash@gmail.com', 'sparky@gmail.com'];

  bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (var index = 0; index < a.length; index += 1) {
      if (a[index] != b[index]) return false;
    }
    return true;
  }

  final Iterable<EmailAddress> emails;
  final Iterable<EmailAddress> correctEmails;
  try {
    emails = parseEmailAddresses(input);
    correctEmails = parseEmailAddresses(correctInput);
    if (emails.isEmpty) {
      print(
        'Tried running `parseEmailAddresses`, but received an empty list.',
      );
      return;
    }
    if (!_listEquals(emails.toList(), [
      EmailAddress('ali@gmail.com'),
      EmailAddress('bobgmail.com'),
      EmailAddress('cal@gmail.com'),
    ])) {
      print('Looks like `parseEmailAddresses` is wrong. Keep trying!');
      return;
    }
  } on UnimplementedError {
    print(
      'Tried running `parseEmailAddresses`, but received an error. '
      'Did you implement the function?',
    );
    return;
  } catch (e) {
    print(
      'Tried running `parseEmailAddresses`, '
      'but received an exception: $e',
    );
    return;
  }

  try {
    final out = anyInvalidEmailAddress(emails);
    if (!out) {
      print(
        'Looks like `anyInvalidEmailAddress` is wrong. Keep trying! '
        'The result should be false with at least one invalid address.',
      );
      return;
    }
    final falseOut = anyInvalidEmailAddress(correctEmails);
    if (falseOut) {
      print(
        'Looks like `anyInvalidEmailAddress` is wrong. Keep trying! '
        'The result should be false with all valid addresses.',
      );
      return;
    }
  } on UnimplementedError {
    print(
      'Tried running `anyInvalidEmailAddress`, but received an error. '
      'Did you implement the function?',
    );
    return;
  } catch (e) {
    print(
        'Tried running `anyInvalidEmailAddress`, but received an exception: $e');
    return;
  }

  try {
    final valid = validEmailAddresses(emails);
    if (emails.isEmpty) {
      print('Tried running `validEmailAddresses`, but received an empty list.');
      return;
    }
    if (!_listEquals(valid.toList(), [
      EmailAddress('ali@gmail.com'),
      EmailAddress('cal@gmail.com'),
    ])) {
      print('Looks like `validEmailAddresses` is wrong. Keep trying!');
      return;
    }
  } on UnimplementedError {
    print(
      'Tried running `validEmailAddresses`, but received an error. '
      'Did you implement the function?',
    );
    return;
  } catch (e) {
    print(
      'Tried running the `validEmailAddresses`, '
      'but received an exception: $e',
    );
    return;
  }

  print('Success. All tests passed!');
}

bool isValidEmailAddress(EmailAddress email) {
  return email.address.contains('@');
}
```

<details>
  <summary title="Expand for the solution of the 'Putting it all together' exercise.">Solution</summary>

  ```dart
  Iterable<EmailAddress> parseEmailAddresses(Iterable<String> strings) {
    return strings.map((s) => EmailAddress(s));
  }
  
  bool anyInvalidEmailAddress(Iterable<EmailAddress> emails) {
    return emails.any((email) => !isValidEmailAddress(email));
  }
  
  Iterable<EmailAddress> validEmailAddresses(Iterable<EmailAddress> emails) {
    return emails.where((email) => isValidEmailAddress(email));
  }
  ```

</details>

## What's next

## 下一步

Congratulations, you finished the tutorial!
If you want to learn more,
here are some suggestions for where to go next:

恭喜你完成了本教程！
如果你想继续学习，
这里有一些后续学习的建议：

* Play with [DartPad.]({{site.dartpad}})

  体验一下 [DartPad]({{site.dartpad}})。
* Read the [Iterable API reference][iterable class]
  to learn about methods that this tutorial doesn't cover.

  阅读 [Iterable API 参考文档][iterable class]，
  了解本教程没有涵盖的方法。

[hashmap class]: {{site.dart-api}}/dart-collection/HashMap-class.html
[iterable class]: {{site.dart-api}}/dart-core/Iterable-class.html
[iterator class]: {{site.dart-api}}/dart-core/Iterator-class.html
[list class]: {{site.dart-api}}/dart-core/List-class.html
[map class]: {{site.dart-api}}/dart-core/Map-class.html
[set class]: {{site.dart-api}}/dart-core/Set-class.html
[StateError class]: {{site.dart-api}}/dart-core/StateError-class.html
[String class]: {{site.dart-api}}/dart-core/String-class.html
