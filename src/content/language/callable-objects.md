---
# title: Callable objects
title: Callable objects
# description: Learn how to create and use callable objects in Dart.
description: Learn how to create and use callable objects in Dart.
showToc: false
prevpage:
  url: /language/extension-types
  title: Extension types
nextpage:
  url: /language/class-modifiers
  title: Class modifiers
---

<?code-excerpt replace="/ *\/\/\s+ignore_for_file:[^\n]+\n//g; /(^|\n) *\/\/\s+ignore: (stable|beta|dev)[^\n]+\n/$1/g; /(\n[^\n]+) *\/\/\s+ignore: (stable|beta|dev)[^\n]+\n/$1\n/g; /. • (lib|test)\/\w+\.dart:\d+:\d+//g"?>

To allow an instance of your Dart class to be called like a function,
implement the `call()` method.



要让 Dart 类的实例能够像函数一样被调用，
请实现 `call()` 方法。

The `call()` method allows an instance of any class that defines it to emulate a function.
This method supports the same functionality as normal [functions][]
such as parameters and return types.



`call()` 方法允许任何定义了它的类的实例模拟函数。
此方法支持与普通[函数][functions]相同的功能，
如参数和返回类型。

In the following example, the `WannabeFunction` class defines a `call()` function
that takes three strings and concatenates them, separating each with a space,
and appending an exclamation. Click **Run** to execute the code.



在下面的示例中，`WannabeFunction` 类定义了一个 `call()` 函数，
该函数接受三个字符串并将它们连接起来，用空格分隔，
并在末尾添加感叹号。点击 **Run** 执行代码。

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
