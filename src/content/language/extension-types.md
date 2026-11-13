---
# title: Extension types
title: 扩展类型
# description: Learn how to write a static-only interface for an existing type.
description: "了解如何为现有类型编写仅静态的接口。"
ai-translated: true
prevpage:
  url: /language/extension-methods
# title: Extension methods
  title: Extension 方法
nextpage:
  url: /language/callable-objects
# title: Callable objects
  title: 可调用对象
---

An extension type is a compile-time abstraction that "wraps"
an existing type with a different, static-only interface.
They are a major component of [static JS interop][] because
they can easily modify an existing type's interface
(crucial for any kind of interop)
without incurring the cost of an actual wrapper.

扩展类型是一种编译时抽象，用另一套仅静态的接口
「包装」现有类型。
它们是 [静态 JS 互操作][static JS interop] 的重要组成部分，
因为它们可以轻松修改现有类型的接口
（对任何互操作都至关重要），
而又不必付出真正包装对象的代价。

Extension types enforce discipline on the set of operations (or interface)
available to objects of an underlying type,
called the *representation type*.
When defining the interface of an extension type,
you can choose to reuse some members of the representation type,
omit others, replace others, and add new functionality.

扩展类型会约束底层类型对象可用的操作（或接口）。
这个底层类型称为 **表示类型**。
定义扩展类型的接口时，
你可以选择复用表示类型的某些成员，
省略另一些，替换另一些，并添加新功能。

The following example wraps the `int` type to create an extension type
that only allows operations that make sense for ID numbers:

下面的例子包装 `int` 类型，创建一个扩展类型，
只保留对 ID 号码有意义的操作：

```dart
extension type IdNumber(int id) {
  // Wraps the 'int' type's '<' operator:
  operator <(IdNumber other) => id < other.id;
  // Doesn't declare the '+' operator, for example,
  // because addition does not make sense for ID numbers.
}

void main() {
  // Without the discipline of an extension type,
  // 'int' exposes ID numbers to unsafe operations:
  int myUnsafeId = 42424242;
  myUnsafeId = myUnsafeId + 10; // This works, but shouldn't be allowed for IDs.

  var safeId = IdNumber(42424242);
  safeId + 10; // Compile-time error: No '+' operator.
  myUnsafeId = safeId; // Compile-time error: Wrong type.
  myUnsafeId = safeId as int; // OK: Run-time cast to representation type.
  safeId < IdNumber(42424241); // OK: Uses wrapped '<' operator.
}
```

:::note
Extension types serve the same purpose as **wrapper classes**,
but don't require the creation of an extra run-time object,
which can get expensive when you need to wrap lots of objects.
Because extension types are static-only and compiled away at run time,
they are essentially zero cost.

扩展类型的用途与 **包装类** 相同，
但不必额外创建一个运行时对象。
需要包装大量对象时，那种开销会变得很贵。
因为扩展类型只存在于静态层面，运行时会被编译掉，
所以它们本质上是零开销的。

[**Extension methods**][ext] (also known just as "extensions")
are a static abstraction similar to extension types.
However, an extension method adds functionality *directly*
to every instance of its underlying type.
Extension types are different;
an extension type's interface *only* applies to expressions
whose static type is that extension type.
They are distinct from the interface of their underlying type by default.

[**Extension 方法**][ext]（也直接叫作「extension」）
是与扩展类型类似的静态抽象。
不过，extension 方法会把功能 **直接** 加到其底层类型的每个实例上。
扩展类型则不同；
扩展类型的接口 **只** 适用于静态类型就是该扩展类型的表达式。
默认情况下，它们与底层类型的接口是分开的。
:::

[static JS interop]: /go/next-gen-js-interop
[ext]: /language/extension-methods

## Syntax

## 语法

### Declaration

### 声明

Define a new extension type with the `extension type` declaration and a name,
followed by the *representation type declaration* in parentheses:

用 `extension type` 声明和一个名称来定义新的扩展类型，
后面在圆括号里跟上 **表示类型声明**：

```dart
extension type E(int i) {
  // Define set of operations.
}
```

The representation type declaration `(int i)` specifies that
the underlying type of extension type `E` is `int`,
and that the reference to the *representation object* is named `i`.
The declaration also introduces:

表示类型声明 `(int i)` 指定扩展类型 `E` 的底层类型是 `int`，
并且指向 **表示对象** 的引用名为 `i`。
该声明还会引入：

- An implicit getter for the representation object
  with the representation type as the return type: `int get i`.

  表示对象的隐式 getter，返回类型就是表示类型：`int get i`。
- An implicit constructor: `E(int i) : i = i`.

  隐式构造函数：`E(int i) : i = i`。

The representation getter gives access to the
representation object typed as the underlying type.
The getter is in scope in the extension type body,
and you can access it using its name like any other getter:

表示 getter 让你能访问被类型化为底层类型的表示对象。
这个 getter 在扩展类型体内处于作用域中，
你可以像其它 getter 一样用它的名字访问：

- Within the extension type body using `i` (or `this.i`).

  在扩展类型体内使用 `i`（或 `this.i`）。
- Outside with a property extraction using `e.i`
  (where `e` has the extension type as its static type).

  在外部通过属性提取使用 `e.i`
  （其中 `e` 的静态类型是该扩展类型）。

Extension type declarations can also include [type parameters][generics]
just like classes or extensions:

扩展类型声明也可以像类或 extension 一样包含 [类型参数][generics]：

```dart
extension type E<T>(List<T> elements) {
  // ...
}
```

[generics]: /language/generics

### Constructors

### 构造函数

You can optionally declare [constructors][] in an extension type's body.
The representation declaration itself is an implicit constructor,
so by default takes the place of an unnamed constructor for the extension type.
Any additional non-redirecting generative constructors must
initialize the representation object's instance variable
using `this.i` in its initializer list or formal parameters.

你可以在扩展类型的体中可选地声明 [构造函数][constructors]。
表示声明本身就是一个隐式构造函数，
因此默认充当该扩展类型的未命名构造函数。
任何额外的、非重定向的生成构造函数，
都必须在初始化列表或形参中用 `this.i`
初始化表示对象的实例变量。

```dart
extension type E(int i) {
  E.n(this.i);
  E.m(int j, String foo) : i = j + foo.length;
}

void main() {
  E(4); // Implicit unnamed constructor.
  E.n(3); // Named constructor.
  E.m(5, "Hello!"); // Named constructor with additional parameters.
}
```

Or, you can name the representation declaration constructor,
in which case there is room for an unnamed constructor in the body:

或者，你可以为表示声明的构造函数命名，
这样体内就有空间再写一个未命名构造函数：

```dart
extension type const E._(int it) {
  E(): this._(42);
  E.otherName(this.it);
}

void main2() {
  E();
  const E._(2);
  E.otherName(3);
}
```

You can also completely hide the constructor, instead of just defining a new one,
using the same private constructor syntax for classes, `_`. For example,
if you only want clients constructing `E` with a `String`, even though
the underlying type is `int`:

你也可以完全隐藏构造函数，而不只是再定义一个新的，
做法与类的私有构造函数语法相同，使用 `_`。
例如，即使底层类型是 `int`，
你也只希望调用方用 `String` 来构造 `E`：

```dart
extension type E._(int i) {
  E.fromString(String foo) : i = int.parse(foo);
}
```

You can also declare forwarding generative constructors,
or [factory constructors][factory]
(which can also forward to constructors of sub-extension types).

你也可以声明转发的生成构造函数，
或 [工厂构造函数][factory]
（它们也可以转发到子扩展类型的构造函数）。

[constructors]: /language/constructors
[factory]: /language/constructors#factory-constructors

### Members

### 成员

Declare members in the body of an extension type to define its interface
the same way you would for class members.
Extension type members can be methods, getters, setters, or operators
(non-[`external`][] [instance variables][] and [abstract members][]
are not allowed):

在扩展类型的体中声明成员来定义它的接口，
方式与类成员相同。
扩展类型的成员可以是方法、getter、setter 或运算符
（不允许非 [`external`][] 的 [实例变量][instance variables]
和 [抽象成员][abstract members]）：

```dart
extension type NumberE(int value) {
  // Operator:
  NumberE operator +(NumberE other) =>
      NumberE(value + other.value);
  // Getter:
  NumberE get myNum => this;
  // Method:
  bool isValid() => !value.isNegative;
}
```

Interface members of the representation type are not interface members
of the extension type [by default](#transparency).
To make a single member of the representation type available
on the extension type, you must write a declaration for it
in the extension type definition, like the `operator +` in `NumberE`.
You also can define new members unrelated to the representation type,
like the `i` getter and `isValid` method.

表示类型的接口成员 [默认](#transparency) 并不是扩展类型的接口成员。
要让表示类型的某一个成员在扩展类型上可用，
必须在扩展类型定义中为它写一份声明，
就像 `NumberE` 中的 `operator +`。
你也可以定义与表示类型无关的新成员，
例如 `i` getter 和 `isValid` 方法。

[`external`]: /language/functions#external
[instance variables]: /language/classes#instance-variables
[abstract members]: /language/methods#abstract-methods

### Implements

### implements 子句

You can optionally use the `implements` clause to:

你可以选择使用 `implements` 子句来：

- Introduce a subtype relationship on an extension type, AND

  在扩展类型上引入子类型关系，**并且**
- Add the members of the representation object to the extension type interface.

  把表示对象的成员加入扩展类型的接口。

The `implements` clause introduces an [applicability][]
relationship like the one between an [extension method][ext] and its `on` type.
Members that are applicable to the supertype are applicable to the
subtype as well, unless the subtype has a declaration with the same
member name.

`implements` 子句引入一种 [适用性][applicability] 关系，
类似于 [extension 方法][ext] 与其 `on` 类型之间的关系。
适用于超类型的成员也适用于子类型，
除非子类型有一份同名成员声明。

An extension type can only implement:

扩展类型只能实现：

- **Its representation type**.
  This makes all members of the representation type implicitly available
  to the extension type.

  **它的表示类型**。
  这会让表示类型的所有成员隐式地对扩展类型可用。

  ```dart
  extension type NumberI(int i)
    implements int{
    // 'NumberI' can invoke all members of 'int',
    // plus anything else it declares here.
  }
  ```

- **A supertype of its representation type**.
  This makes the members of the supertype available,
  while not necessarily all the members of representation type.

  **它的表示类型的超类型**。
  这会让该超类型的成员可用，
  但不一定包括表示类型的全部成员。

  ```dart
  extension type Sequence<T>(List<T> _) implements Iterable<T> {
    // Better operations than List.
  }

  extension type Id(int _id) implements Object {
    // Makes the extension type non-nullable.
    static Id? tryParse(String source) => int.tryParse(source) as Id?;
  }
  ```

- **Another extension type** that is valid on the same representation type.
  This allows you to reuse operations across multiple extension types
  (similar to multiple inheritance).

  在同一表示类型上有效的 **另一个扩展类型**。
  这样就可以在多个扩展类型之间复用操作
  （类似于多重继承）。

  ```dart
  extension type const Opt<T>._(({T value})? _) {
    const factory Opt(T value) = Val<T>;
    const factory Opt.none() = Non<T>;
  }
  extension type const Val<T>._(({T value}) _) implements Opt<T> {
    const Val(T value) : this._((value: value));
    T get value => _.value;
  }
  extension type const Non<T>._(Null _) implements Opt<Never> {
    const Non() : this._(null);
  }
  ```

Read the [Usage](#usage) section to learn more about the effect of `implements`
in different scenarios.

阅读 [用法](#usage) 一节，进一步了解 `implements` 在不同场景中的效果。

[applicability]: {{site.repo.dart.lang}}/blob/main/accepted/2.7/static-extension-methods/feature-specification.md#examples
[ext]: /language/extension-methods

#### `@redeclare`

#### `@redeclare` 注解

Declaring an extension type member that
shares a name with a member of a supertype is *not* an
override relationship like it is between classes, but rather a *redeclaration*.
An extension type member declaration *completely replaces* any
supertype member with the same name.
It's not possible to provide an
alternative implementation for the same function.

如果扩展类型的成员与超类型的某个成员同名，
这 **不是** 类之间那种覆盖关系，而是 **重新声明**。
扩展类型的成员声明会 **完全替换** 任何同名的超类型成员。
不能为同一个函数再提供另一份实现。

You can use the [`@redeclare`][] annotation from `package:meta` to
tell the compiler you are *knowingly* choosing to
use the same name as a supertype's member.
The analyzer will then warn you if that's not actually true,
for example, if one of the names is mistyped.

你可以使用来自 `package:meta` 的 [`@redeclare`][] 注解，
告诉编译器你是 **有意** 使用与超类型成员相同的名字。
如果实际情况并非如此，分析器会警告你，
例如某个名字写错了。

<?code-excerpt "language/lib/extension_types/redeclare.dart"?>
```dart
import 'package:meta/meta.dart';

extension type MyString(String _) implements String {
  // Replaces 'String.operator[]'.
  @redeclare
  int operator [](int index) => codeUnitAt(index);
}
```

You can also enable the lint [`annotate_redeclares`][]
to get a warning if you declare an extension type method
that hides a superinterface member and *isn't* annotated with `@redeclare`.

你也可以启用 [`annotate_redeclares`][] lint，
这样当你声明的扩展类型方法隐藏了超接口成员、
却 **没有** 用 `@redeclare` 注解时，就会得到警告。

[`@redeclare`]: {{site.pub-api}}/meta/latest/meta/redeclare-constant.html
[`annotate_redeclares`]: /tools/linter-rules/annotate_redeclares

## Usage

## 用法

To use an extension type, create an instance the same as you would with a class:
by calling a constructor:

要使用扩展类型，创建实例的方式与类相同：
调用构造函数：

```dart
extension type NumberE(int value) {
  NumberE operator +(NumberE other) =>
      NumberE(value + other.value);

  NumberE get next => NumberE(value + 1);
  bool isValid() => !value.isNegative;
}

void testE() {
  var num = NumberE(1);
}
```

Then, you can invoke members on the object as you would with a class object.

然后，你可以像调用类对象的成员一样调用该对象上的成员。

There are two equally valid, but substantially different core use cases
for extension types:

扩展类型有两种同样有效、但实质不同的核心用途：

1. Providing an *extended* interface to an existing type.

   为现有类型提供一套 **扩充后的** 接口。
2. Providing a *different* interface to an existing type.

   为现有类型提供 **另一套** 接口。

:::note
In any case, the representation type of an extension type is never its subtype,
so a representation type can't be used interchangeably where
the extension type is needed.

无论如何，扩展类型的表示类型永远不是它的子类型，
因此在需要扩展类型的地方，不能把表示类型互换使用。
:::

<a id="transparency" aria-hidden="true"></a>
<a id="1-provide-an-extended-interface-to-an-existing-type" aria-hidden="true"></a>

### 1. Provide an *extended* interface to an existing type {: #provide-extended-interface}

### 1. 为现有类型提供 **扩充后的** 接口

When an extension type [implements](#implements) its representation type,
you can consider it "transparent", because it allows the extension type
to "see" the underlying type.

当扩展类型 [实现](#implements) 它的表示类型时，
可以把它看成「透明」的，
因为它让扩展类型能够「看见」底层类型。

A transparent extension type can invoke all members of the
representation type (that aren't [redeclared](#redeclare)),
plus any auxiliary members it defines.
This creates a new, *extended* interface for an existing type.
The new interface is available to expressions
whose static type is the extension type.

透明的扩展类型可以调用表示类型的所有成员
（那些没有被 [重新声明](#redeclare) 的），
再加上它自己定义的任何辅助成员。
这就为现有类型创建了一套新的、**扩充后的** 接口。
这套新接口可用于静态类型为该扩展类型的表达式。

This means you *can* invoke members of the representation type
(unlike a [non-transparent](#provide-different-interface)
extension type), like so:

这意味着你 **可以** 调用表示类型的成员
（与 [非透明](#provide-different-interface) 的扩展类型不同），
如下所示：

```dart
extension type NumberT(int value)
  implements int {
  // Doesn't explicitly declare any members of 'int'.
  NumberT get i => this;
}

void main () {
  // All OK: Transparency allows invoking `int` members on the extension type:
  var v1 = NumberT(1); // v1 type: NumberT
  int v2 = NumberT(2); // v2 type: int
  var v3 = v1.i - v1;  // v3 type: int
  var v4 = v2 + v1; // v4 type: int
  var v5 = 2 + v1; // v5 type: int
  // Error: Extension type interface is not available to representation type
  v2.i;
}
```

You can also have a "mostly-transparent" extension type
that adds new members and adapts others by redeclaring a given member name
from the supertype.
This would allow you to use stricter types on some parameters of a method,
or different default values, for example.

你也可以有一种「大致透明」的扩展类型，
它添加新成员，并通过重新声明超类型中的某个成员名来调整其它成员。
这样你就可以在方法的某些参数上使用更严格的类型，
或者使用不同的默认值。

Another mostly-transparent extension type approach is to implement
a type that is a supertype of the representation type.
For example, if the representation type is private but its supertype
defines the part of the interface that matters for clients.

另一种大致透明的做法，是实现表示类型的某个超类型。
例如，表示类型是私有的，
但它的超类型定义了对调用方重要的那部分接口。

<a id="2-provide-a-different-interface-to-an-existing-type" aria-hidden="true"></a>

### 2. Provide a *different* interface to an existing type {:#provide-different-interface}

### 2. 为现有类型提供 **另一套** 接口

An extension type that is not [transparent](#transparency)
(that does not [`implement`](#implements) its representation type)
is statically treated as a completely new type,
distinct from its representation type.
You can't assign it to its representation type,
and it doesn't expose its representation type's members.

不是 [透明](#transparency) 的扩展类型
（也就是没有 [`implement`](#implements) 其表示类型）
在静态上会被当作一个全新的类型，
与它的表示类型不同。
你不能把它赋给表示类型，
它也不会暴露表示类型的成员。

For example, take the `NumberE` extension type we declared under [Usage](#usage):

例如，拿我们在 [用法](#usage) 中声明的 `NumberE` 扩展类型来说：

```dart
void testE() {
  var num1 = NumberE(1);
  int num2 = NumberE(2); // Error: Can't assign 'NumberE' to 'int'.

  num1.isValid(); // OK: Extension member invocation.
  num1.isNegative(); // Error: 'NumberE' does not define 'int' member 'isNegative'.

  var sum1 = num1 + num1; // OK: 'NumberE' defines '+'.
  var diff1 = num1 - num1; // Error: 'NumberE' does not define 'int' member '-'.
  var diff2 = num1.value - 2; // OK: Can access representation object with reference.
  var sum2 = num1 + 2; // Error: Can't assign 'int' to parameter type 'NumberE'.

  List<NumberE> numbers = [
    NumberE(1),
    num1.next, // OK: 'next' getter returns type 'NumberE'.
    1, // Error: Can't assign 'int' element to list type 'NumberE'.
  ];
}
```

You can use an extension type this way to *replace* the interface
of an existing type. This allows you to model an interface that is
makes sense for the constraints of your new type
(like the `IdNumber` example in the introduction), while also benefitting from
the performance and convenience of a simple pre-defined type, like `int`.

你可以这样用扩展类型来 **替换** 现有类型的接口。
这样你就可以为新类型的约束建模一套合理的接口
（就像引言中的 `IdNumber` 例子），
同时还能受益于 `int` 这类简单预定义类型的性能和便利。

This use case is as close as you can get to the complete encapsulation
of a wrapper class (but is realistically only a
[*somewhat* protected](#type-considerations) abstraction).

这种用法已经尽可能接近包装类的完整封装
（但实际上只是一种
[**某种程度上受保护的**](#type-considerations) 抽象）。

## Type considerations

## 类型方面的考虑

Extension types are a compile-time wrapping construct.
At run time, there is absolutely no trace of the extension type.
Any type query or similar run-time operations work on the representation type.

扩展类型是一种编译时的包装构造。
在运行时，扩展类型完全不会留下痕迹。
任何类型查询或类似的运行时操作，作用的都是表示类型。

This makes extension types an *unsafe* abstraction,
because you can always find out the representation type at run time
and access the underlying object.

这使扩展类型成为一种 **不安全的** 抽象，
因为你总能在运行时查出表示类型，并访问底层对象。

Dynamic type tests (`e is T`), casts (`e as T`),
and other run-time type queries (like `switch (e) ...` or `if (e case ...)`)
all evaluate to the underlying representation object,
and type check against that object's runtime type.
That's true when the static type of `e` is an extension type,
and when testing against an extension type (`case MyExtensionType(): ... `).

动态类型测试（`e is T`）、类型转换（`e as T`），
以及其它运行时类型查询（如 `switch (e) ...` 或 `if (e case ...)`）
求值的都是底层表示对象，
并对照该对象的运行时类型做类型检查。
无论 `e` 的静态类型是扩展类型，
还是在针对扩展类型做测试（`case MyExtensionType(): ...`），都是如此。

```dart
void main() {
  var n = NumberE(1);

  // The run-time type of 'n' is the representation type 'int'.
  if (n is int) print(n); // Prints 1.

  // Can use 'int' methods on 'n' at run time.
  if (n case int x) print(x.toRadixString(10)); // Prints 1.
  switch (n) {
    case int(:var isEven): print("$n (${isEven ? "even" : "odd"})"); // Prints 1 (odd).
  }
}
```

Similarly, the static type of the matched value is that of the extension type
in this example:

同样，在这个例子中，匹配到的值的静态类型是扩展类型：

```dart
void main() {
  int i = 2;
  if (i is NumberE) print("It is"); // Prints 'It is'.
  if (i case NumberE v) print("value: ${v.value}"); // Prints 'value: 2'.
  switch (i) {
    case NumberE(:var value): print("value: $value"); // Prints 'value: 2'.
  }
}
```

When `i` gets the static type `NumberE` based on a cast or a pattern match, `i`
still refers to the same object, and `v` refers to the same object as `i`, and
the object itself remains unchanged. It is only the static type that changed
(and hence the methods that we can call on this object). In particular, the
change of type does not involve an invocation of a constructor. If you wish to
execute a constructor (for example, to perform some kind of validation) then it
is necessary to write an explicit constructor invocation (such as `NumberE(i)`).

当 `i` 因类型转换或模式匹配而获得静态类型 `NumberE` 时，
`i` 仍然指向同一个对象，`v` 也指向与 `i` 相同的对象，
对象本身没有变化。变化的只是静态类型
（因此也改变了我们可以在这个对象上调用的方法）。
特别是，类型的变化并不涉及调用构造函数。
如果你希望执行构造函数（例如做某种校验），
就必须显式写一次构造函数调用（例如 `NumberE(i)`）。

It's important to be aware of this behavior when using extension types.
Always keep in mind that an extension type exists and matters at compile time,
but gets _erased_ during compilation.

使用扩展类型时，了解这一行为很重要。
始终记住：扩展类型在编译时存在并且有意义，
但在编译过程中会被 **擦除**。

For example, consider an expression `e` whose static type is the
extension type `E`. Assume that the representation type of `E` is `R`.
The run-time type of the value of `e` is then a subtype of `R`.
Even the type itself is erased;
`List<E>` is exactly the same thing as `List<R>` at run time.

例如，考虑表达式 `e`，其静态类型是扩展类型 `E`。
假设 `E` 的表示类型是 `R`。
那么 `e` 的值的运行时类型是 `R` 的子类型。
甚至类型本身也会被擦除；
运行时 `List<E>` 与 `List<R>` 完全是一回事。

In other words, a real wrapper class can encapsulate a wrapped object,
whereas an extension type is just a compile-time view on the wrapped object.
While a real wrapper is safer, the trade-off is extension types
give you the option to avoid wrapper objects, which can greatly
improve performance in some scenarios.

换句话说，真正的包装类可以封装被包装的对象，
而扩展类型只是对被包装对象的一种编译时视图。
真正的包装更安全，而扩展类型的取舍是：
你可以选择避免包装对象，
这在某些场景下能大幅提升性能。
