---
title: Language samples
title: Dart 编程语言概览
description: Examples of idiomatic Dart with links to larger examples.
description: 展示常见的 Dart 语言的用法。
---

This collection is not exhaustive&mdash;it's just a brief
introduction to the language for people who like to learn by example.
You might also want to check out the language and library tours,
or the [Dart cheatsheet codelab](/codelabs/dart-cheatsheet).

本文向你展示的 Dart 语言用法并不全面&mdash;&mdash;
这里只是对那些喜欢通过示例了解语言的人提供一个简单的介绍。
你也许会对 [Dart 语言的速查表 CodeLab](/codelabs/dart-cheatsheet) 或
Dart 语言概览和库概览更感兴趣。

<div class="card-grid no_toc_section">
  <div class="card">
    <h3><a href="/guides/language/language-tour">Language tour</a></h3>
    <h3><a href="/guides/language/language-tour">语言概览</a></h3>
    <p>
      A comprehensive tour, with examples, of the Dart language.
      Most of the <em>read more</em> links in this page
      point to the language tour.
    </p>
    <p>
      包含示例的 Dart 语言全面概览。
      本文中大部分的 <strong>阅读更多</strong> 链接均会跳转到此概览中。
    </p>
  </div>
  <div class="card">
    <h3><a href="/guides/libraries/library-tour">Library tour</a></h3>
    <h3><a href="/guides/libraries/library-tour">库概览</a></h3>
    <p>
      An example-based introduction to the Dart core libraries.
      See how to use the built-in types, collections,
      dates and times, streams, and more.
    </p>
    <p>
      通过各种示例向你介绍 Dart 的核心库。
      通过此概览你可以了解更多关于内置类型、集合、
      日期时间、异步 Stream 以及其它 Dart 核心功能的相关信息。
    </p>
  </div>
</div>


## Hello World

## 你好，世界！

Every app has a `main()` function.
To display text on the console, you can use the top-level `print()` function:

每个应用都有一个 `main()` 函数。你可以使用顶层函数
`print()` 来将一段文本输出显示到控制台：

<?code-excerpt "misc/test/samples_test.dart (hello-world)"?>
```dart
void main() {
  print('Hello, World!');
}
```


## Variables

## 变量

Even in type-safe Dart code, most variables don't need explicit types,
thanks to type inference:

虽然 Dart 是代码类型安全的语言，但是由于其支持类型推断，
因此大多数变量不需要显式地指定类型：

<?code-excerpt "misc/test/samples_test.dart (var)"?>
```dart
var name = 'Voyager I';
var year = 1977;
var antennaDiameter = 3.7;
var flybyObjects = ['Jupiter', 'Saturn', 'Uranus', 'Neptune'];
var image = {
  'tags': ['saturn'],
  'url': '//path/to/saturn.jpg'
};
```

[Read more](/guides/language/language-tour#variables) about variables in Dart, 
including default values, the `final` and `const` keywords, and static types.

你可以 [阅读更多](/guides/language/language-tour#variables) Dart 中关于变量的内容，包括变量的默认值，`final` 和 `const` 关键字以及静态类型等。

## Control flow statements

## 流程控制语句

Dart supports the usual control flow statements:

Dart 支持常用的流程控制语句：

<?code-excerpt "misc/test/samples_test.dart (control-flow)"?>
```dart
if (year >= 2001) {
  print('21st century');
} else if (year >= 1901) {
  print('20th century');
}

for (final object in flybyObjects) {
  print(object);
}

for (int month = 1; month <= 12; month++) {
  print(month);
}

while (year < 2016) {
  year += 1;
}
```

[Read more](/guides/language/language-tour#control-flow-statements) 
about control flow statements in Dart,
including `break` and `continue`, `switch` and `case`, and `assert`.

你可以 [阅读更多](/guides/language/language-tour#control-flow-statements) Dart 中关于控制流程语句的内容，包括 `break` 和 `continue` 关键字、`switch` 语句和 `case` 子句以及 `assert` 语句。

## Functions

## 函数

[We recommend](/guides/language/effective-dart/design#types)
specifying the types of each function's arguments and return value:

[我们建议](/guides/language/effective-dart/design#types)
为每个函数的参数以及返回值都指定类型：

<?code-excerpt "misc/test/samples_test.dart (functions)"?>
```dart
int fibonacci(int n) {
  if (n == 0 || n == 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

var result = fibonacci(20);
```

A shorthand `=>` (_arrow_) syntax is handy for functions that
contain a single statement.
This syntax is especially useful when passing anonymous functions as arguments:

`=>` (**胖箭头**) 简写语法用于仅包含一条语句的函数。
该语法在将匿名函数作为参数传递时非常有用：

<?code-excerpt "misc/test/samples_test.dart (arrow)"?>
```dart
flybyObjects.where((name) => name.contains('turn')).forEach(print);
```

Besides showing an anonymous function (the argument to `where()`),
this code shows that you can use a function as an argument:
the top-level `print()` function is an argument to `forEach()`.

上面的示例除了向你展示了匿名函数（上例中传入 `where()` 函数的参数即是一个匿名函数）外，还向你展示了将函数作为参数使用的方式：上面示例将顶层函数 `print()` 作为参数传给了 `forEach()` 函数。

[Read more](/guides/language/language-tour#functions) about functions in Dart,
including optional parameters, default parameter values, and lexical scope.

你可以 [阅读更多](/guides/language/language-tour#functions) Dart 中有关函数的内容，包括可选参数、默认参数值以及词法作用域。

## Comments

## 注释

Dart comments usually start with `//`.

Dart 通常使用双斜杠 `//` 作为注释的开始。

```dart

/// 这是一个文档注释。
/// 文档注释用于为库、类以及类的成员添加注释。
/// 像 IDE 和 dartdoc 这样的工具可以专门处理文档注释。

/* 也可以像这样使用单斜杠和星号的注释方式 */
```

[Read more](/guides/language/language-tour#comments) about comments in Dart,
including how the documentation tooling works.

你可以 [阅读更多](/guides/language/language-tour#comments) Dart 中有关注释的内容，包括文档工具的工作原理。

## Imports

## 导入（ Import ）

To access APIs defined in other libraries, use `import`.

使用 `import` 关键字来访问在其它库中定义的 API。

<?code-excerpt "misc/test/samples_test.dart (import)" plaster="none"?>
```
// Importing core libraries
import 'dart:math';

// Importing libraries from external packages
import 'package:test/test.dart';

// Importing files
import 'path/to/my_other_file.dart';
```

[Read more](/guides/language/language-tour#libraries-and-visibility) 
about libraries and visibility in Dart,
including library prefixes, `show` and `hide`, 
and lazy loading through the `deferred` keyword.

你可以 [阅读更多](/guides/language/language-tour#libraries-and-visibility)
Dart 中有关库和可见性的内容，包括库前缀、`show` 和 `hide`
关键字以及通过 `deferred` 关键字实现的懒加载。

## Classes

## 类（ Class ）

Here's an example of a class with three properties, two constructors,
and a method. One of the properties can't be set directly, so it's
defined using a getter method (instead of a variable).

下面的示例中向你展示了一个包含三个属性、
两个构造函数以及一个方法的类。其中一个属性不能直接赋值，
因此它被定义为一个 getter 方法（而不是变量）。

<?code-excerpt "misc/lib/samples/spacecraft.dart (class)"?>
```dart
class Spacecraft {
  String name;
  DateTime? launchDate;

  // Read-only non-final property
  int? get launchYear => launchDate?.year;

  // Constructor, with syntactic sugar for assignment to members.
  Spacecraft(this.name, this.launchDate) {
    // Initialization code goes here.
  }

  // Named constructor that forwards to the default one.
  Spacecraft.unlaunched(String name) : this(name, null);

  // Method.
  void describe() {
    print('Spacecraft: $name');
    // Type promotion doesn't work on getters.
    var launchDate = this.launchDate;
    if (launchDate != null) {
      int years =
          DateTime.now().difference(launchDate).inDays ~/ 365;
      print('Launched: $launchYear ($years years ago)');
    } else {
      print('Unlaunched');
    }
  }
}
```

You might use the `Spacecraft` class like this:

你可以像下面这样使用 `Spacecraft` 类：

<?code-excerpt "misc/test/samples_test.dart (use class)" plaster="none"?>
```dart
var voyager = Spacecraft('Voyager I', DateTime(1977, 9, 5));
voyager.describe();

var voyager3 = Spacecraft.unlaunched('Voyager III');
voyager3.describe();
```

[Read more](/guides/language/language-tour#classes) about classes in Dart,
including initializer lists, optional `new` and `const`, redirecting constructors,
`factory` constructors, getters, setters, and much more.

你可以 [阅读更多](/guides/language/language-tour#classes)
Dart 中有关类的内容，包括初始化列表、可选的 `new` 和 `const` 关键字、
重定向构造函数、由 `factory` 关键字定义的工厂构造函数
以及 Getter 和 Setter 方法等等。

## Inheritance

## 扩展类（继承）

Dart has single inheritance.

Dart 支持单继承。

<?code-excerpt "misc/lib/samples/spacecraft.dart (extends)"?>
```dart
class Orbiter extends Spacecraft {
  double altitude;

  Orbiter(String name, DateTime launchDate, this.altitude)
      : super(name, launchDate);
}
```

[Read more](/guides/language/language-tour#extending-a-class) 
about extending classes, the optional `@override` annotation, and more.

你可以 [阅读更多](/guides/language/language-tour#extending-a-class) Dart 中有关类继承的内容，比如可选的 `@override` 注解等等。

## Mixins

Mixins are a way of reusing code in multiple class hierarchies. The following is
a mixin declaration:

Mixin 是一种在多个类层次结构中重用代码的方法。下面的是声明一个 Mixin 的做法：

<?code-excerpt "misc/lib/samples/spacecraft.dart (mixin)"?>
```dart
mixin Piloted {
  int astronauts = 1;

  void describeCrew() {
    print('Number of astronauts: $astronauts');
  }
}
```

To add a mixin's capabilities to a class, just extend the class with the mixin.

现在你只需使用 Mixin 的方式继承这个类就可将该类中的功能添加给其它类。

<?code-excerpt "misc/lib/samples/spacecraft.dart (mixin-use)" replace="/with/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
class PilotedCraft extends Spacecraft [!with!] Piloted {
  // ···
}
{% endprettify %}

`PilotedCraft` now has the `astronauts` field as well as the `describeCrew()` method.

自此，`PilotedCraft` 类中就包含了 `astronauts` 字段以及 `describeCrew()` 方法。

[Read more](/guides/language/language-tour#adding-features-to-a-class-mixins) about mixins.

你可以 [阅读更多](/guides/language/language-tour#adding-features-to-a-class-mixins) 关于 Mixin 的内容。

## Interfaces and abstract classes

## 接口和抽象类

Dart has no `interface` keyword. 
Instead, all classes implicitly define an interface. 
Therefore, you can implement any class.

Dart 没有 `interface` 关键字。
相反，所有的类都隐式定义了一个接口。
因此，任意类都可以作为接口被实现。

<?code-excerpt "misc/lib/samples/spacecraft.dart (implements)"?>
```dart
class MockSpaceship implements Spacecraft {
  // ···
}
```

[Read more](/guides/language/language-tour#implicit-interfaces) about implicit interfaces.

你可以 [阅读更多](/guides/language/language-tour#implicit-interfaces) 关于隐式接口的内容。

You can create an abstract class 
to be extended (or implemented) by a concrete class. 
Abstract classes can contain abstract methods (with empty bodies).

你可以创建一个被任意具体类扩展（或实现）的抽象类。
抽象类可以包含抽象方法（不含方法体的方法）。

<?code-excerpt "misc/lib/samples/spacecraft.dart (abstract)" replace="/abstract/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
[!abstract!] class Describable {
  void describe();

  void describeWithEmphasis() {
    print('=========');
    describe();
    print('=========');
  }
}
{% endprettify %}

Any class extending `Describable` has the `describeWithEmphasis()` method, 
which calls the extender's implementation of `describe()`.

任意一个扩展了 `Describable` 的类都拥有 `describeWithEmphasis()` 方法，
这个方法又会去调用实现类中实现的 `describe()` 方法。

[Read more](/guides/language/language-tour#abstract-classes) 
about abstract classes and methods.

你可以 [阅读更多](/guides/language/language-tour#abstract-classes) 关于抽象类和抽象方法的内容。

## Async

## 异步

Avoid callback hell and make your code much more readable by
using `async` and `await`.

使用 `async` 和 `await` 关键字可以让你避免
回调地狱（Callback Hell）并使你的代码更具可读性。

<?code-excerpt "misc/test/samples_test.dart (async)" replace="/async/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
const oneSecond = Duration(seconds: 1);
// ···
Future<void> printWithDelay(String message) [!async!] {
  await Future.delayed(oneSecond);
  print(message);
}
{% endprettify %}

The method above is equivalent to:

上面的方法相当于：

<?code-excerpt "misc/test/samples_test.dart (Future.then)"?>
```dart
Future<void> printWithDelay(String message) {
  return Future.delayed(oneSecond).then((_) {
    print(message);
  });
}
```

As the next example shows, `async` and `await` help make asynchronous code
easy to read.

如下一个示例所示，`async` 和 `await` 关键字有助于使异步代码变得易于阅读。

<?code-excerpt "misc/test/samples_test.dart (await)"?>
```dart
Future<void> createDescriptions(Iterable<String> objects) async {
  for (final object in objects) {
    try {
      var file = File('$object.txt');
      if (await file.exists()) {
        var modified = await file.lastModified();
        print(
            'File for $object already exists. It was modified on $modified.');
        continue;
      }
      await file.create();
      await file.writeAsString('Start describing $object in this file.');
    } on IOException catch (e) {
      print('Cannot create description for $object: $e');
    }
  }
}
```

You can also use `async*`, which gives you a nice, readable way to build streams.

你也可以使用 `async*` 关键字，其可以为你提供一个可读性更好的方式去生成 Stream。

<?code-excerpt "misc/test/samples_test.dart (async*)"?>
```dart
Stream<String> report(Spacecraft craft, Iterable<String> objects) async* {
  for (final object in objects) {
    await Future.delayed(oneSecond);
    yield '${craft.name} flies by $object';
  }
}
```

[Read more](/guides/language/language-tour#asynchrony-support) about
asynchrony support, including `async` functions, `Future`, `Stream`,
and the asynchronous loop (`await for`).

你可以 [阅读更多](/guides/language/language-tour#asynchrony-support)
关于异步支持的内容，
包括异步函数、`Future`、`Stream` 以及异步循环（`await for`）。

## Exceptions

## 异常

To raise an exception, use `throw`:

使用 `throw` 关键字抛出一个异常：

<?code-excerpt "misc/test/samples_test.dart (throw)"?>
```dart
if (astronauts == 0) {
  throw StateError('No astronauts.');
}
```

To catch an exception, use a `try` statement with `on` or `catch` (or both):

使用 `try` 语句配合 `on` 或 `catch`（两者也可同时使用）
关键字来捕获一个异常:

<?code-excerpt "misc/test/samples_test.dart (try)"?>
```
try {
  for (final object in flybyObjects) {
    var description = await File('$object.txt').readAsString();
    print(description);
  }
} on IOException catch (e) {
  print('Could not describe object: $e');
} finally {
  flybyObjects.clear();
}
```

Note that the code above is asynchronous;
`try` works for both synchronous code and code in an `async` function.

注意上述代码是异步的；同步代码以及异步函数中得代码都可以使用 `try` 捕获异常。

[Read more](/guides/language/language-tour#exceptions) about exceptions, 
including stack traces, `rethrow`, 
and the difference between `Error` and `Exception`.

你可以 [阅读更多](/guides/language/language-tour#exceptions) 
关于异常的内容，包括栈追踪、`rethrow` 关键字以及 Error 和 Exception 之间的区别。

## Other topics

## 其他资源

Many more code samples are in the
[language tour](/guides/language/language-tour) and the
[library tour](/guides/libraries/library-tour).
Also see the [Dart API reference,]({{site.dart_api}})
which often contains examples.

[语言概览](/guides/language/language-tour) 和
[库概览](/guides/libraries/library-tour) 中会有更多的代码示例。
你也可以查阅 [Dart API 文档]({{site.dart_api}})，里面也常常会有示例代码。
