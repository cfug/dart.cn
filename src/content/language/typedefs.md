---
# title: Typedefs
title: Typedefs
# description: Learn about type aliases in Dart.
description: Learn about type aliases in Dart.
showToc: false
prevpage:
  url: /language/generics
  title: Generics
nextpage:
  url: /language/type-system
  title: Type system
---

<?code-excerpt replace="/ *\/\/\s+ignore_for_file:[^\n]+\n//g; /(^|\n) *\/\/\s+ignore:[^\n]+\n/$1/g; /(\n[^\n]+) *\/\/\s+ignore:[^\n]+\n/$1\n/g; / *\/\/\s+ignore:[^\n]+//g; /([A-Z]\w*)\d\b/$1/g"?>

A type alias—often called a _typedef_ because
it's declared with the keyword `typedef`—is
a concise way to refer to a type.
Here's an example of declaring and using a type alias named `IntList`:



类型别名——通常被称为 _typedef_，
因为它是用关键字 `typedef` 声明的——是
一种简洁地引用类型的方式。
下面是一个声明和使用名为 `IntList` 的类型别名的示例：

<?code-excerpt "misc/lib/language_tour/typedefs/misc.dart (int-list)"?>
```dart
typedef IntList = List<int>;
IntList il = [1, 2, 3];
```

A type alias can have type parameters:



类型别名可以有类型参数：

<?code-excerpt "misc/lib/language_tour/typedefs/misc.dart (list-mapper)"?>
```dart
typedef ListMapper<X> = Map<X, List<X>>;
Map<String, List<String>> m1 = {}; // Verbose.
ListMapper<String> m2 = {}; // Same thing but shorter and clearer.
```

:::version-note
Before 2.13, typedefs were restricted to function types.
Using the new typedefs requires a [language version][] of at least 2.13.
:::

We recommend using [inline function types][] instead of typedefs for functions,
in most situations.
However, function typedefs can still be useful:



在 2.13 之前，typedef 仅限于函数类型。
使用新的 typedef 需要[语言版本][language version]至少为 2.13。
:::

<?code-excerpt "misc/lib/language_tour/typedefs/misc.dart (compare)"?>
```dart
typedef Compare<T> = int Function(T a, T b);

int sort(int a, int b) => a - b;



在大多数情况下，我们建议使用[内联函数类型][inline function types]
而不是函数的 typedef。
但是，函数 typedef 仍然很有用：

void main() {
  assert(sort is Compare<int>); // True!
}
```

[language version]: /resources/language/evolution#language-versioning
[inline function types]: /effective-dart/design#prefer-inline-function-types-over-typedefs
