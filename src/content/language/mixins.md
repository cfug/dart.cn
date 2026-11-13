---
# title: Mixins
title: 混入 (Mixin)
# description: Learn how to add to features to a class in Dart.
description: 了解如何在 Dart 中为类添加可复用的特性。
prevpage:
  url: /language/extend
  # title: Extend a class
  title: 扩展类
nextpage:
  url: /language/enums
  # title: Enums
  title: 枚举
ai-translated: true
---

<?code-excerpt replace="/ *\/\/\s+ignore_for_file:[^\n]+\n//g; /(^|\n) *\/\/\s+ignore:[^\n]+\n/$1/g; /(\n[^\n]+) *\/\/\s+ignore:[^\n]+\n/$1\n/g; / *\/\/\s+ignore:[^\n]+//g; /([A-Z]\w*)\d\b/$1/g"?>

Mixins are a way of defining code that can be reused in multiple class hierarchies.
They are intended to provide member implementations en masse. 

mixin 是一种在多个类层次结构中复用代码的方式。
它们的目的是成批提供成员实现。

To use a mixin, use the `with` keyword followed by one or more mixin
names. The following example shows two classes that use (or, are subclasses of)
mixins:

要使用 mixin，在 `with` 关键字后面写上一个或多个 mixin 的名字。
下面的例子展示了两个使用 mixin
（或者说，作为 mixin 子类）的类：

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

To define a mixin, use the `mixin` declaration. 
In the rare case where you need to define both a mixin _and_ a class, you can use
the [`mixin class` declaration](#class-mixin-or-mixin-class).

要定义 mixin，使用 `mixin` 声明。
在极少数情况下，你需要同时定义 mixin **和** 类，
可以使用 [`mixin class` 声明](#class-mixin-or-mixin-class)。

Mixins and mixin classes cannot have an `extends` clause,
and must not declare any generative constructors.

mixin 和 mixin class 不能有 `extends` 子句，
也不能声明任何生成构造函数。

For example:

例如：

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

## Specify members a mixin can call on itself

## 指定 mixin 可以在自身上调用的成员

Sometimes a mixin depends on being able to invoke a method or access fields,
but can't define those members itself (because mixins can't use constructor
parameters to instantiate their own fields).

有时 mixin 依赖于能够调用某个方法或访问某些字段，
但自己又不能定义这些成员
（因为 mixin 不能用构造函数参数来实例化自己的字段）。

The following sections cover different strategies for ensuring any subclass
of a mixin defines any members the mixin's behavior depends on. 

下面几节介绍不同的策略，用来确保 mixin 的任何子类
都会定义 mixin 行为所依赖的成员。

### Define abstract members in the mixin

### 在 mixin 中定义抽象成员

Declaring an abstract method in a mixin forces any type that uses
the mixin to define the abstract method upon which its behavior depends. 

在 mixin 中声明抽象方法，会迫使任何使用该 mixin 的类型
去定义其行为所依赖的那个抽象方法。

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

class Virtuoso with Musician { 

  @override
  void playInstrument(String instrumentName) { // Subclass must define.
    print('Plays the $instrumentName beautifully');
  }  
} 
```

#### Access state in the mixin's subclass

#### 访问 mixin 子类中的状态

Declaring abstract members also allows you to access state on the subclass
of a mixin, by calling getters which are defined as abstract on the mixin:

声明抽象成员后，你还可以访问 mixin 子类上的状态：
调用那些在 mixin 上被定义为抽象的 getter。

```dart
/// Can be applied to any type with a [name] property and provides an
/// implementation of [hashCode] and operator `==` in terms of it.
mixin NameIdentity {
  String get name;

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(other) => other is NameIdentity && name == other.name;
}

class Person with NameIdentity {
  final String name;

  Person(this.name);
}
```

### Implement an interface

### 实现接口

Similar to declaring the mixin abstract, putting an `implements` clause on the
mixin while not actually implementing the interface will also ensure any member
dependencies are defined for the mixin.

与把 mixin 声明为抽象类似，在 mixin 上写 `implements` 子句、
但实际上并不实现该接口，
同样可以确保 mixin 所依赖的成员都被定义。

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

### 用 `on` 子句声明超类

The `on` clause exists to define the type that `super` calls are resolved against.
So, you should only use it if you need to have a `super` call inside a mixin. 

`on` 子句用来定义 `super` 调用要针对哪种类型来解析。
因此，只有当你需要在 mixin 内部调用 `super` 时才应该使用它。

The `on` clause forces any class that uses a mixin to also be a subclass
of the type in the `on` clause.
If the mixin depends on members in the superclass,
this ensures those members are available where the mixin is used:

`on` 子句迫使任何使用该 mixin 的类，
同时也必须是 `on` 子句中那个类型的子类。
如果 mixin 依赖于超类中的成员，
这就能确保在使用该 mixin 的地方这些成员是可用的：

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

在这个例子中，只有扩展或实现了 `Musician` 类的类
才能使用 mixin `MusicalPerformer`。
因为 `SingerDancer` 扩展了 `Musician`，
所以 `SingerDancer` 可以 mixin `MusicalPerformer`。

## `class`, `mixin`, or `mixin class`?

## `class`、`mixin` 还是 `mixin class`？

:::version-note
The `mixin class` declaration requires a [language version][] of at least 3.0.

`mixin class` 声明要求 [语言版本][language version] 至少为 3.0。

:::

A `mixin` declaration defines a mixin. A `class` declaration defines a [class][].
A `mixin class` declaration defines a class that is usable as both a regular class
and a mixin, with the same name and the same type.

`mixin` 声明定义的是 mixin。`class` 声明定义的是 [类][class]。
`mixin class` 声明定义的是一个类，它既能当普通类用，
也能当 mixin 用，名字相同，类型也相同。

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

适用于类或 mixin 的限制，同样适用于 mixin class：

- Mixins can't have `extends` or `with` clauses, so neither can a `mixin class`.

  mixin 不能有 `extends` 或 `with` 子句，因此 `mixin class` 也不能有。

- Classes can't have an `on` clause, so neither can a `mixin class`.

  类不能有 `on` 子句，因此 `mixin class` 也不能有。

[language version]: /language/versioning
[class]: /language/classes
[class modifiers]: /language/class-modifiers
