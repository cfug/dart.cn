---
# title: Extension methods
title: 扩展方法
# description: Learn how to add to existing APIs.
description: 了解如何为现有 API 添加功能。
prevpage:
  url: /language/dot-shorthands
  # title: Dot shorthands
  title: 点的简写
nextpage:
  url: /language/extension-types
  # title: Extension types
  title: 扩展类型
ai-translated: true
---

Extension methods add functionality to existing libraries.
You might use extension methods without even knowing it.
For example, when you use code completion in an IDE,
it suggests extension methods alongside regular methods.

扩展方法为现有的库增加功能。
你可能在不知不觉中就用过扩展方法。
例如，在 IDE 里使用代码补全时，
它会把扩展方法和普通方法一起建议出来。

If watching videos helps you learn,
check out this overview of extension methods.

如果看视频有助于学习，
可以看看这个扩展方法概览。

<iframe
  {{site.bili.std-size}}
  title="Dart extension methods"
  src="{{site.bili.embed}}?aid=547449672&bvid=BV1Hq4y1M7zi&cid=391150414&page=1&autoplay=false"
  {{site.bili.set}}>
</iframe>

## Overview

## 概述

When you're using someone else's API or
when you implement a library that's widely used,
it's often impractical or impossible to change the API.
But you might still want to add some functionality.

当你使用别人的 API，
或者你实现的库被广泛使用时，
修改这个 API 往往不现实，甚至不可能。
但你可能仍然想增加一些功能。

For example, consider the following code that parses a string into an integer:

例如，考虑下面这段把字符串解析成整数的代码：

```dart
int.parse('42')
```

It might be nice—shorter and easier to use with tools—to
have that functionality be on `String` instead:

如果这个功能直接放在 `String` 上，会更好：
更短，也更容易配合工具使用。

```dart
'42'.parseInt()
```

To enable that code,
you can import a library that contains an extension of the `String` class:

要让那段代码成立，
可以导入一个包含 `String` 类扩展的库：

<?code-excerpt "extension_methods/lib/string_extensions/usage_simple_extension.dart (basic)" plaster="none"?>
```dart
import 'string_apis.dart';

void main() {
  print('42'.parseInt()); // Use an extension method.
}
```

Extensions can define not just methods,
but also other members such as getter, setters, and operators.
Also, extensions can have names, which can be helpful if an API conflict arises.
Here's how you might implement the extension method `parseInt()`,
using an extension (named `NumberParsing`) that operates on strings:

扩展不仅可以定义方法，
还可以定义 getter、setter 和操作符等其他成员。
扩展也可以有名字，这在出现 API 冲突时会有帮助。
下面是实现扩展方法 `parseInt()` 的一种方式，
它使用一个作用于字符串的扩展（名为 `NumberParsing`）：

<?code-excerpt "extension_methods/lib/string_extensions/string_apis.dart (parseInt)" plaster="none"?>
```dart title="lib/string_apis.dart"
extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }
}
```

The next section describes how to _use_ extension methods.
After that are sections about _implementing_ extension methods.

下一节说明如何 **使用** 扩展方法。
再往后是关于 **实现** 扩展方法的几节。


## Using extension methods

## 使用扩展方法

Like all Dart code, extension methods are in libraries.
You've already seen how to use an extension method—just 
import the library it's in, and use it like an ordinary method:

和所有 Dart 代码一样，扩展方法位于库中。
你已经见过如何使用扩展方法：
导入它所在的库，然后像普通方法一样使用它：

<?code-excerpt "extension_methods/lib/string_extensions/usage_simple_extension.dart (import-and-use)" plaster="none"?>
```dart
// Import a library that contains an extension on String.
import 'string_apis.dart';

void main() {
  print('42'.padLeft(5)); // Use a String method.
  print('42'.parseInt()); // Use an extension method.
}
```

That's all you usually need to know to use extension methods.
As you write your code, you might also need to know
how extension methods depend on static types (as opposed to `dynamic`) and
how to resolve [API conflicts](#api-conflicts).

使用扩展方法时，通常知道这些就够了。
写代码时，你可能还需要知道
扩展方法如何依赖静态类型（而不是 `dynamic`），
以及如何解决 [API 冲突](#api-conflicts)。

### Static types and dynamic

### 静态类型与 dynamic

You can't invoke extension methods on variables of type `dynamic`.
For example, the following code results in a runtime exception:

不能在类型为 `dynamic` 的变量上调用扩展方法。
例如，下面的代码会导致运行时异常：

<?code-excerpt "extension_methods/lib/string_extensions/usage_simple_extension.dart (dynamic)" plaster="none" replace="/  \/\/ print/print/g"?>
```dart
dynamic d = '2';
print(d.parseInt()); // Runtime exception: NoSuchMethodError
```

Extension methods _do_ work with Dart's type inference.
The following code is fine because
the variable `v` is inferred to have type `String`:

扩展方法 **确实** 可以配合 Dart 的类型推断使用。
下面的代码没有问题，因为
变量 `v` 被推断为 `String` 类型：

<?code-excerpt "extension_methods/lib/string_extensions/usage_simple_extension.dart (var)"?>
```dart
var v = '2';
print(v.parseInt()); // Output: 2
```

The reason that `dynamic` doesn't work is that
extension methods are resolved against the static type of the receiver.
Because extension methods are resolved statically,
they're as fast as calling a static function.

`dynamic` 行不通的原因是，
扩展方法是根据接收者的静态类型来解析的。
因为扩展方法是静态解析的，
所以它们和调用静态函数一样快。

For more information about static types and `dynamic`, see
[The Dart type system](/language/type-system).

关于静态类型和 `dynamic` 的更多信息，请参阅
[Dart 类型系统](/language/type-system)。

### API conflicts

### API 冲突

If an extension member conflicts with
an interface or with another extension member,
then you have a few options.

如果扩展成员与某个接口冲突，
或者与另一个扩展成员冲突，
你有几种处理办法。

One option is changing how you import the conflicting extension,
using `show` or `hide` to limit the exposed API:

一种办法是改变冲突扩展的导入方式，
用 `show` 或 `hide` 限制暴露出来的 API：

<?code-excerpt "extension_methods/lib/string_extensions/usage_import.dart (hide-conflicts)" plaster="none"?>
```dart
// Defines the String extension method parseInt().
import 'string_apis.dart';

// Also defines parseInt(), but hiding NumberParsing2
// hides that extension method.
import 'string_apis_2.dart' hide NumberParsing2;

void main() {
  // Uses the parseInt() defined in 'string_apis.dart'.
  print('42'.parseInt());
}
```

Another option is applying the extension explicitly,
which results in code that looks as if the extension is a wrapper class:

另一种办法是显式应用扩展，
这样写出来的代码看起来就像扩展是一个包装类：

<?code-excerpt "extension_methods/lib/string_extensions/usage_explicit.dart (conflicts-explicit)" plaster="none"?>
```dart
// Both libraries define extensions on String that contain parseInt(),
// and the extensions have different names.
import 'string_apis.dart'; // Contains NumberParsing extension.
import 'string_apis_2.dart'; // Contains NumberParsing2 extension.

void main() {
  // print('42'.parseInt()); // Doesn't work.
  print(NumberParsing('42').parseInt());
  print(NumberParsing2('42').parseInt());
}
```

If both extensions have the same name,
then you might need to import using a prefix:

如果两个扩展同名，
你可能需要用前缀来导入：

<?code-excerpt "extension_methods/lib/string_extensions/usage_prefix.dart"?>
```dart
// Both libraries define extensions named NumberParsing
// that contain the extension method parseInt(). One NumberParsing
// extension (in 'string_apis_3.dart') also defines parseNum().
import 'string_apis.dart';
import 'string_apis_3.dart' as rad;

void main() {
  // print('42'.parseInt()); // Doesn't work.

  // Use the ParseNumbers extension from string_apis.dart.
  print(NumberParsing('42').parseInt());

  // Use the ParseNumbers extension from string_apis_3.dart.
  print(rad.NumberParsing('42').parseInt());

  // Only string_apis_3.dart has parseNum().
  print('42'.parseNum());
}
```

As the example shows,
you can invoke extension methods implicitly even if you import using a prefix.
The only time you need to use the prefix is
to avoid a name conflict when invoking an extension explicitly.

如例子所示，
即便使用前缀导入，你仍然可以隐式调用扩展方法。
只有在显式调用扩展、又要避免名字冲突时，
才需要使用这个前缀。


## Implementing extension methods

## 实现扩展方法

Use the following syntax to create an extension:

用下面的语法创建扩展：

```plaintext
extension <extension name>? on <type> { // <extension-name> is optional
  (<member definition>)* // Can provide one or more <member definition>.
}
```

For example, here's how you might implement an extension on the `String` class:

例如，下面是在 `String` 类上实现扩展的一种方式：

<?code-excerpt "extension_methods/lib/string_extensions/string_apis.dart"?>
```dart title="lib/string_apis.dart"
extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }

  double parseDouble() {
    return double.parse(this);
  }

}
```

The members of an extension can be methods, getters, setters, or operators.
Extensions can also have static fields and static helper methods.
To access static members outside the extension declaration, 
invoke them through the declaration name like [class variables and methods][]. 

扩展的成员可以是方法、getter、setter 或操作符。
扩展也可以有静态字段和静态辅助方法。
要在扩展声明之外访问静态成员，
像 [类变量和方法][class variables and methods] 那样，通过声明的名字来调用。

[class variables and methods]: /language/classes#class-variables-and-methods

### Unnamed extensions

### 未命名扩展

When declaring an extension, you can omit the name.
Unnamed extensions are visible only
in the library where they're declared.
Since they don't have a name,
they can't be explicitly applied
to resolve [API conflicts](#api-conflicts).

声明扩展时可以省略名字。
未命名扩展只在声明它的库里可见。
因为它们没有名字，
所以不能显式应用它们
来解决 [API 冲突](#api-conflicts)。

<?code-excerpt "extension_methods/lib/string_extensions/string_apis_unnamed.dart (unnamed)"?>
```dart
extension on String {
  bool get isBlank => trim().isEmpty;
}
```

:::note
You can invoke an unnamed extension's static members
only within the extension declaration.

未命名扩展的静态成员
只能在该扩展声明内部调用。

:::

## Implementing generic extensions

## 实现泛型扩展

Extensions can have generic type parameters.
For example, here's some code that extends the built-in `List<T>` type
with a getter, an operator, and a method:

扩展可以带有泛型类型参数。
例如，下面的代码为内置的 `List<T>` 类型增加了
一个 getter、一个操作符和一个方法：

<?code-excerpt "extension_methods/lib/fancylist.dart (generic)"?>
```dart
extension MyFancyList<T> on List<T> {
  int get doubleLength => length * 2;
  List<T> operator -() => reversed.toList();
  List<List<T>> split(int at) => [sublist(0, at), sublist(at)];
}
```

The type `T` is bound based on the static type of the list that
the methods are called on.

类型 `T` 会根据调用这些方法的那个列表的静态类型来绑定。

{% comment %}
TODO (https://github.com/dart-lang/site-www/issues/2171):
Add more info about generic extensions. 
For example, in the following code, `T` is `PENDING` because PENDING:

[PENDING: example]

[PENDING: Explain why it matters in normal usage.]
{% endcomment %}

## Resources

## 资源

For more information about extension methods, see the following:

关于扩展方法的更多信息，请参阅：

* [Article: Dart Extension Methods Fundamentals][article]

  [文章：Dart 扩展方法基础][article]

* [Feature specification][specification]

  [特性规范][specification]

* [Extension methods sample][sample]

  [扩展方法示例][sample]

[specification]: {{site.repo.dart.lang}}/blob/main/accepted/2.7/static-extension-methods/feature-specification.md#dart-static-extension-methods-design
[article]: /blog/dart-extension-method-fundamentals
[sample]: {{site.repo.dart.samples}}/tree/main/extension_methods
