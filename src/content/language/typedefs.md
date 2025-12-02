---
title: Typedefs
title: 类型别名
description: Learn about type aliases in Dart.
description: 了解 Dart 中的类型别名。
showToc: false
prevpage:
  url: /language/generics
  title: Generics
  title: 泛型
nextpage:
  url: /language/type-system
  title: Type system
  title: 类型系统
---

<?code-excerpt replace="/ *\/\/\s+ignore_for_file:[^\n]+\n//g; /(^|\n) *\/\/\s+ignore:[^\n]+\n/$1/g; /(\n[^\n]+) *\/\/\s+ignore:[^\n]+\n/$1\n/g; / *\/\/\s+ignore:[^\n]+//g; /([A-Z]\w*)\d\b/$1/g"?>

A type alias—often called a _typedef_ because
it's declared with the keyword `typedef`—is
a concise way to refer to a type.
Here's an example of declaring and using a type alias named `IntList`:

类型别名——通常称为 _typedef_，因为它使用关键字 `typedef` 声明——是
一种引用类型的简洁方式。
以下是声明和使用名为 `IntList` 的类型别名的示例：

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

在 2.13 之前，typedef 仅限于函数类型。
使用新的 typedef 需要至少 2.13 的[语言版本][language version]。
:::

We recommend using [inline function types][] instead of typedefs for functions,
in most situations.
However, function typedefs can still be useful:

在大多数情况下，我们建议对函数使用[内联函数类型][inline function types]
而不是 typedef。
但是，函数 typedef 仍然可以很有用：

<?code-excerpt "misc/lib/language_tour/typedefs/misc.dart (compare)"?>
```dart
typedef Compare<T> = int Function(T a, T b);

int sort(int a, int b) => a - b;

void main() {
  assert(sort is Compare<int>); // True!
}
```

[language version]: /resources/language/evolution#language-versioning
[inline function types]: /effective-dart/design#prefer-inline-function-types-over-typedefs
