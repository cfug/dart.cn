---
# title: Mixins
title: Mixins
# description: Learn how to add to features to a class in Dart.
description: Learn how to add to features to a class in Dart.
prevpage:
  url: /language/extend
  title: Extend a class
nextpage:
  url: /language/enums
  title: Enums
---

<?code-excerpt replace="/ *\/\/\s+ignore_for_file:[^\n]+\n//g; /(^|\n) *\/\/\s+ignore:[^\n]+\n/$1/g; /(\n[^\n]+) *\/\/\s+ignore:[^\n]+\n/$1\n/g; / *\/\/\s+ignore:[^\n]+//g; /([A-Z]\w*)\d\b/$1/g"?>

Mixins are a way of defining code that can be reused in multiple class hierarchies.
They are intended to provide member implementations en masse.



Mixin 是一种在多个类层次结构中重用代码的方式。
它们旨在批量提供成员实现。

To use a mixin, use the `with` keyword followed by one or more mixin
names. The following example shows two classes that use (or, are subclasses of)
mixins:



要使用 mixin，请使用 `with` 关键字后跟一个或多个 mixin 名称。
下面的示例展示了两个使用（或者说是子类化）mixin 的类：

<?code-excerpt "misc/lib/language_tour/classes/orchestra.dart (musician-and-maestro)" replace="/(with.*) \{/[!$1!] {/g"?>
```dart
class Musician extends Performer [!with Musical!] {
  // ···
}

class Maestro extends Person [!with Musical, Aggressive, Demented!] {
  Maestro(String maestroName) {
    name = maestroName;
    canConduct = true;
  }
}
```



要定义 mixin，请使用 `mixin` 声明。
在需要同时定义 mixin _和_ 类的罕见情况下，
你可以使用 [`mixin class` 声明](#class-mixin-or-mixin-class)。

To define a mixin, use the `mixin` declaration. 
In the rare case where you need to define both a mixin _and_ a class, you can use
the [`mixin class` declaration](#class-mixin-or-mixin-class).



Mixin 和 mixin 类不能有 `extends` 子句，
并且不能声明任何生成式构造函数。

Mixins and mixin classes cannot have an `extends` clause,
and must not declare any generative constructors.



例如：

For example:



## 指定 mixin 可以调用自身的成员

<?code-excerpt "misc/lib/language_tour/classes/orchestra.dart (musical)"?>
```dart
mixin Musical {
  bool canPlayPiano = false;
  bool canCompose = false;
  bool canConduct = false;

void entertainMe() {
    if (canPlayPiano) {
      print('Playing piano');
    } else if (canConduct) {
      print('Waving hands');
    } else {
      print('Humming to self');
    }
  }
}
```



有时 mixin 依赖于能够调用方法或访问字段，
但不能自己定义这些成员（因为 mixin 不能使用构造函数参数
来实例化自己的字段）。

## Specify members a mixin can call on itself



以下部分介绍了确保 mixin 的任何子类定义 mixin 行为所依赖的
任何成员的不同策略。

Sometimes a mixin depends on being able to invoke a method or access fields,
but can't define those members itself (because mixins can't use constructor
parameters to instantiate their own fields).



### 在 mixin 中定义抽象成员

The following sections cover different strategies for ensuring any subclass
of a mixin defines any members the mixin's behavior depends on.



在 mixin 中声明抽象方法会强制任何使用该 mixin 的类型
定义其行为所依赖的抽象方法。

### Define abstract members in the mixin



#### 访问 mixin 子类中的状态

Declaring an abstract method in a mixin forces any type that uses
the mixin to define the abstract method upon which its behavior depends.



声明抽象成员还允许你通过调用在 mixin 上定义为抽象的 getter
来访问 mixin 子类上的状态：

```dart
mixin Musician {
  void playInstrument(String instrumentName); // Abstract method.

void playPiano() {
    playInstrument('Piano');
  }
  void playFlute() {
    playInstrument('Flute');
  }
}



### 实现接口

class Virtuoso with Musician {



与将 mixin 声明为抽象类似，在 mixin 上放置 `implements` 子句
但不实际实现接口，也将确保为 mixin 定义任何成员依赖项。

@override
  void playInstrument(String instrumentName) { // Subclass must define.
    print('Plays the $instrumentName beautifully');
  }  
} 
```



### 使用 `on` 子句声明超类

#### Access state in the mixin's subclass



`on` 子句用于定义 `super` 调用所针对的类型。
因此，只有在需要在 mixin 中使用 `super` 调用时才应该使用它。

Declaring abstract members also allows you to access state on the subclass
of a mixin, by calling getters which are defined as abstract on the mixin:



`on` 子句强制任何使用 mixin 的类也必须是 `on` 子句中类型的子类。
如果 mixin 依赖于超类中的成员，
这可以确保在使用 mixin 的地方这些成员是可用的：

```dart
/// Can be applied to any type with a [name] property and provides an
/// implementation of [hashCode] and operator `==` in terms of it.
mixin NameIdentity {
  String get name;

@override
  int get hashCode => name.hashCode;



在这个示例中，只有扩展或实现 `Musician` 类的类
才能使用 `MusicalPerformer` mixin。
因为 `SingerDancer` 扩展了 `Musician`，
所以 `SingerDancer` 可以混入 `MusicalPerformer`。

@override
  bool operator ==(other) => other is NameIdentity && name == other.name;
}



## `class`、`mixin` 还是 `mixin class`？

class Person with NameIdentity {
  final String name;



`mixin class` 声明需要至少 3.0 的[语言版本][language version]。
:::

Person(this.name);
}
```



`mixin` 声明定义了一个 mixin。`class` 声明定义了一个[类][class]。
`mixin class` 声明定义了一个既可以用作普通类又可以用作 mixin 的类，
具有相同的名称和相同的类型。

### Implement an interface



适用于类或 mixin 的任何限制也适用于 mixin 类：

Similar to declaring the mixin abstract, putting an `implements` clause on the
mixin while not actually implementing the interface will also ensure any member
dependencies are defined for the mixin.



- Mixin 不能有 `extends` 或 `with` 子句，因此 `mixin class` 也不能有。
- 类不能有 `on` 子句，因此 `mixin class` 也不能有。

```dart
abstract interface class Tuner {
  void tuneInstrument();
}

mixin Guitarist implements Tuner {
  void playSong() {
    tuneInstrument();

print('Strums guitar majestically.');
  }
}

class PunkRocker with Guitarist {

@override
  void tuneInstrument() {
    print("Don't bother, being out of tune is punk rock.");
  }
}
```

### Use the `on` clause to declare a superclass

The `on` clause exists to define the type that `super` calls are resolved against.
So, you should only use it if you need to have a `super` call inside a mixin.

The `on` clause forces any class that uses a mixin to also be a subclass
of the type in the `on` clause.
If the mixin depends on members in the superclass,
this ensures those members are available where the mixin is used:

```dart
class Musician {
  musicianMethod() {
    print('Playing music!');
  }
}

mixin MusicalPerformer [!on Musician!] {
  performerMethod() {
    print('Performing music!');
    super.musicianMethod();
  }
}

class SingerDancer extends Musician with MusicalPerformer { }

main() {
  SingerDancer().performerMethod();
}
```

In this example, only classes that extend or implement the `Musician` class
can use the mixin `MusicalPerformer`. Because `SingerDancer` extends `Musician`,
`SingerDancer` can mix in `MusicalPerformer`.

## `class`, `mixin`, or `mixin class`?

:::version-note
The `mixin class` declaration requires a [language version][] of at least 3.0.
:::

A `mixin` declaration defines a mixin. A `class` declaration defines a [class][].
A `mixin class` declaration defines a class that is usable as both a regular class
and a mixin, with the same name and the same type.

```dart
mixin class Musician {
  // ...
}

class Novice with Musician { // Use Musician as a mixin
  // ...
}

class Novice extends Musician { // Use Musician as a class
  // ...
}
```

Any restrictions that apply to classes or mixins also apply to mixin classes:

- Mixins can't have `extends` or `with` clauses, so neither can a `mixin class`.
- Classes can't have an `on` clause, so neither can a `mixin class`.

[language version]: /resources/language/evolution#language-versioning
[class]: /language/classes
[class modifiers]: /language/class-modifiers
