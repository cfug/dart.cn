---
# title: Callable objects
title: 可调用对象
# description: Learn how to create and use callable objects in Dart.
description: 了解如何在 Dart 中创建并使用可调用对象。
showToc: false
prevpage:
  url: /language/extension-types
  # title: Extension types
  title: 扩展类型
nextpage:
  url: /language/class-modifiers
  # title: Class modifiers
  title: 类修饰符
ai-translated: true
---

<?code-excerpt replace="/ *\/\/\s+ignore_for_file:[^\n]+\n//g; /(^|\n) *\/\/\s+ignore: (stable|beta|dev)[^\n]+\n/$1/g; /(\n[^\n]+) *\/\/\s+ignore: (stable|beta|dev)[^\n]+\n/$1\n/g; /. • (lib|test)\/\w+\.dart:\d+:\d+//g"?>

To allow an instance of your Dart class to be called like a function,
implement the `call()` method.

要让你的 Dart 类实例可以像函数一样被调用，
请实现 `call()` 方法。

The `call()` method allows an instance of any class that defines it to emulate a function.
This method supports the same functionality as normal [functions][]
such as parameters and return types.

`call()` 方法让任何定义了它的类实例都能模拟一个函数。
该方法支持与普通 [函数][functions] 相同的功能，
例如参数和返回类型。

In the following example, the `WannabeFunction` class defines a `call()` function
that takes three strings and concatenates them, separating each with a space,
and appending an exclamation. Click **Run** to execute the code.

在下面的例子中，`WannabeFunction` 类定义了一个 `call()` 函数。
它接收三个字符串，用空格把它们拼接起来，
并在末尾加上一个感叹号。点击 **运行** 来执行代码。

<?code-excerpt "misc/lib/language_tour/callable_objects.dart"?>
```dartpad
class WannabeFunction {
  String call(String a, String b, String c) => '$a $b $c!';
}

var wf = WannabeFunction();
var out = wf('Hi', 'there,', 'gang');

void main() => print(out);
```

[functions]: /language/functions
