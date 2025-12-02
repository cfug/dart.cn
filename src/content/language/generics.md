---
# title: Generics
title: Generics
# description: Learn about generic types in Dart.
description: Learn about generic types in Dart.
prevpage:
  url: /language/collections
  title: Collections
nextpage:
  url: /language/typedefs
  title: Typedefs
---

<?code-excerpt replace="/ *\/\/\s+ignore_for_file:[^\n]+\n//g; /(^|\n) *\/\/\s+ignore:[^\n]+\n/$1/g; /(\n[^\n]+) *\/\/\s+ignore:[^\n]+\n/$1\n/g; / *\/\/\s+ignore:[^\n]+//g; /([A-Z]\w*)\d\b/$1/g"?>

If you look at the API documentation for the basic array type,
[`List`][], you'll see that the
type is actually `List<E>`. The \<...\> notation marks List as a
*generic* (or *parameterized*) type—a type that has formal type
parameters. [By convention][], most type variables have single-letter names,
such as E, T, S, K, and V.



如果你查看基本数组类型 [`List`][] 的 API 文档，
你会看到该类型实际上是 `List<E>`。
\<...\> 标记将 List 标记为*泛型*（或*参数化*）类型——
具有形式类型参数的类型。
[按照约定][By convention]，大多数类型变量使用单字母名称，
如 E、T、S、K 和 V。

## Why use generics?



## 为什么使用泛型？

Generics are often required for type safety, but they have more benefits
than just allowing your code to run:



泛型通常是类型安全所必需的，但它们的好处不仅仅是让你的代码运行：

* Properly specifying generic types results in better generated code.
* You can use generics to reduce code duplication.



* 正确指定泛型类型可以生成更好的代码。
* 你可以使用泛型来减少代码重复。

If you intend for a list to contain only strings, you can
declare it as `List<String>` (read that as "list of string"). That way
you, your fellow programmers, and your tools can detect that assigning a non-string to
the list is probably a mistake. Here's an example:



如果你打算让一个列表只包含字符串，
你可以将它声明为 `List<String>`（读作"字符串列表"）。
这样你、你的同事程序员和你的工具可以检测到
将非字符串赋值给列表可能是一个错误。下面是一个例子：

```dart tag=fails-sa
var names = <String>[];
names.addAll(['Seth', 'Kathy', 'Lars']);
names.add(42); // Error
```

Another reason for using generics is to reduce code duplication.
Generics let you share a single interface and implementation between
many types, while still taking advantage of static
analysis. For example, say you create an interface for
caching an object:



使用泛型的另一个原因是减少代码重复。
泛型让你可以在多种类型之间共享单个接口和实现，
同时仍然利用静态分析的优势。
例如，假设你创建一个用于缓存对象的接口：

<?code-excerpt "misc/lib/language_tour/generics/cache.dart (object-cache)"?>
```dart
abstract class ObjectCache {
  Object getByKey(String key);
  void setByKey(String key, Object value);
}
```

You discover that you want a string-specific version of this interface,
so you create another interface:



你发现你想要这个接口的字符串特定版本，
所以你创建另一个接口：

<?code-excerpt "misc/lib/language_tour/generics/cache.dart (string-cache)"?>
```dart
abstract class StringCache {
  String getByKey(String key);
  void setByKey(String key, String value);
}
```

Later, you decide you want a number-specific version of this
interface... You get the idea.



后来，你决定要一个数字特定版本的接口……你明白了。

Generic types can save you the trouble of creating all these interfaces.
Instead, you can create a single interface that takes a type parameter:



泛型类型可以省去创建所有这些接口的麻烦。
相反，你可以创建一个带有类型参数的单一接口：

<?code-excerpt "misc/lib/language_tour/generics/cache.dart (cache)"?>
```dart
abstract class Cache<T> {
  T getByKey(String key);
  void setByKey(String key, T value);
}
```

In this code, T is the stand-in type. It's a placeholder that you can
think of as a type that a developer will define later.



在这段代码中，T 是替代类型。
它是一个占位符，你可以将其视为开发者稍后将定义的类型。

## Using collection literals



## 使用集合字面量

List, set, and map literals can be parameterized. Parameterized literals are
just like the literals you've already seen, except that you add
<code>&lt;<em>type</em>></code> (for lists and sets) or
<code>&lt;<em>keyType</em>, <em>valueType</em>></code> (for maps)
before the opening bracket. Here is an example of using typed literals:



List、set 和 map 字面量可以参数化。参数化字面量
与你已经看到的字面量一样，只是你在开括号之前添加了
<code>&lt;<em>type</em>></code>（对于 list 和 set）或
<code>&lt;<em>keyType</em>, <em>valueType</em>></code>（对于 map）。
下面是使用类型化字面量的示例：

<?code-excerpt "misc/lib/language_tour/generics/misc.dart (collection-literals)"?>
```dart
var names = <String>['Seth', 'Kathy', 'Lars'];
var uniqueNames = <String>{'Seth', 'Kathy', 'Lars'};
var pages = <String, String>{
  'index.html': 'Homepage',
  'robots.txt': 'Hints for web robots',
  'humans.txt': 'We are people, not machines',
};
```

## Using parameterized types with constructors



## 在构造函数中使用参数化类型

To specify one or more types when using a constructor, put the types in
angle brackets (`<...>`) just after the class name. For example:



要在使用构造函数时指定一个或多个类型，
请将类型放在类名后面的尖括号（`<...>`）中。例如：

<?code-excerpt "misc/test/language_tour/generics_test.dart (constructor-1)"?>
```dart
var nameSet = Set<String>.of(names);
```

The following code creates a `SplayTreeMap` that has
integer keys and values of type `View`:



以下代码创建一个具有整数键和 `View` 类型值的 `SplayTreeMap`：

<?code-excerpt "misc/test/language_tour/generics_test.dart (constructor-2)"?>
```dart
var views = SplayTreeMap<int, View>();
```

## Generic collections and the types they contain



## 泛型集合及其包含的类型

Dart generic types are *reified*, which means that they carry their type
information around at runtime. For example, you can test the type of a
collection:



Dart 泛型类型是*具体化的*，这意味着它们在运行时
携带其类型信息。例如，你可以测试集合的类型：

<?code-excerpt "misc/test/language_tour/generics_test.dart (generic-collections)"?>
```dart
var names = <String>[];
names.addAll(['Seth', 'Kathy', 'Lars']);
print(names is List<String>); // true
```

:::note
In contrast, generics in Java use *erasure*, which means that generic
type parameters are removed at runtime. In Java, you can test whether
an object is a List, but you can't test whether it's a `List<String>`.
:::

## Restricting the parameterized type



相比之下，Java 中的泛型使用*擦除*，
这意味着泛型类型参数在运行时被移除。
在 Java 中，你可以测试一个对象是否是 List，
但你不能测试它是否是 `List<String>`。
:::

When implementing a generic type,
you might want to limit the types that can be provided as arguments,
so that the argument must be a subtype of a particular type.
This restriction is called a bound.
You can do this using `extends`.



## 限制参数化类型

A common use case is ensuring that a type is non-nullable
by making it a subtype of `Object`
(instead of the default, [`Object?`][top-and-bottom]).



在实现泛型类型时，
你可能想要限制可以作为参数提供的类型，
以便参数必须是特定类型的子类型。
这种限制称为边界。
你可以使用 `extends` 来实现这一点。

<?code-excerpt "misc/lib/language_tour/generics/misc.dart (non-nullable)"?>
```dart
class Foo<T extends Object> {
  // Any type provided to Foo for T must be non-nullable.
}
```

You can use `extends` with other types besides `Object`.
Here's an example of extending `SomeBaseClass`,
so that members of `SomeBaseClass` can be called on objects of type `T`:



一个常见的用例是通过使类型成为 `Object` 的子类型
（而不是默认的 [`Object?`][top-and-bottom]）
来确保类型是非空的。

<?code-excerpt "misc/lib/language_tour/generics/base_class.dart (generic)" replace="/extends SomeBaseClass(?=. \{)/[!$&!]/g"?>
```dart
class Foo<T [!extends SomeBaseClass!]> {
  // Implementation goes here...
  String toString() => "Instance of 'Foo<$T>'";
}

class Extender extends SomeBaseClass {
  ...
}
```



你可以对 `Object` 以外的其他类型使用 `extends`。
下面是扩展 `SomeBaseClass` 的示例，
这样就可以在类型为 `T` 的对象上调用 `SomeBaseClass` 的成员：

It's OK to use `SomeBaseClass` or any of its subtypes as the generic argument:



可以使用 `SomeBaseClass` 或其任何子类型作为泛型参数：

<?code-excerpt "misc/test/language_tour/generics_test.dart (SomeBaseClass-ok)" replace="/Foo.\w+./[!$&!]/g"?>
```dart
var someBaseClassFoo = [!Foo<SomeBaseClass>!]();
var extenderFoo = [!Foo<Extender>!]();
```

It's also OK to specify no generic argument:



也可以不指定泛型参数：

<?code-excerpt "misc/test/language_tour/generics_test.dart (no-generic-arg-ok)" replace="/expect\((.*?).toString\(\), .(.*?).\);/print($1); \/\/ $2/g"?>
```dart
var foo = Foo();
print(foo); // Instance of 'Foo<SomeBaseClass>'
```

Specifying any non-`SomeBaseClass` type results in an error:



指定任何非 `SomeBaseClass` 类型会导致错误：

```dart tag=fails-sa
var foo = [!Foo<Object>!]();
```

### Self-referential type parameter restrictions (F-bounds) {:#f-bounds}



### 自引用类型参数限制（F-边界）{:#f-bounds}

When using bounds to restrict parameter types, you can refer the bound
back to the type parameter itself. This creates a self-referential constraint,
or F-bound. For example:



当使用边界来限制参数类型时，你可以将边界
引用回类型参数本身。这创建了一个自引用约束，
或 F-边界。例如：

<?code-excerpt "misc/test/language_tour/generics_test.dart (f-bound)"?>
```dart
abstract interface class Comparable<T> {
  int compareTo(T o);
}

int compareAndOffset<T extends Comparable<T>>(T t1, T t2) =>
    t1.compareTo(t2) + 1;



F-边界 `T extends Comparable<T>` 表示 `T` 必须与自身可比较。
因此，`A` 只能与相同类型的其他实例进行比较。

class A implements Comparable<A> {
  @override
  int compareTo(A other) => /*...implementation...*/ 0;
}



## 使用泛型方法

int useIt = compareAndOffset(A(), A());
```



方法和函数也允许类型参数：

The F-bound `T extends Comparable<T>` means `T` must be comparable to itself.
So, `A` can only be compared to other instances of the same type.



这里 `first` 上的泛型类型参数（`<T>`）
允许你在多个地方使用类型参数 `T`：

## Using generic methods



* 在函数的返回类型中（`T`）。
* 在参数的类型中（`List<T>`）。
* 在局部变量的类型中（`T tmp`）。

Methods and functions also allow type arguments:

<!-- {{site.dartpad}}/a02c53b001977efa4d803109900f21bb -->
<!-- https://gist.github.com/a02c53b001977efa4d803109900f21bb -->
<?code-excerpt "misc/test/language_tour/generics_test.dart (method)" replace="/<T.(?=\()|T/[!$&!]/g"?>
```dart
[!T!] first[!<T>!](List<[!T!]> ts) {
  // Do some initial work or error checking, then...
  [!T!] tmp = ts[0];
  // Do some additional checking or processing...
  return tmp;
}
```

Here the generic type parameter on `first` (`<T>`)
allows you to use the type argument `T` in several places:

* In the function's return type (`T`).
* In the type of an argument (`List<T>`).
* In the type of a local variable (`T tmp`).

[`List`]: {{site.dart-api}}/dart-core/List-class.html
[By convention]: /effective-dart/design#do-follow-existing-mnemonic-conventions-when-naming-type-parameters
[top-and-bottom]: /null-safety/understanding-null-safety#top-and-bottom
