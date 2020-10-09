---
title: A tour of the Dart language
title: Dart 开发语言概览
description: A tour of all of the major Dart language features.
description: Dart 开发语言的主要特性概览。
short-title: Language tour
---
<?code-excerpt replace="/ *\/\/\s+ignore_for_file:[^\n]+\n//g; / *\/\/\s+ignore:[^\n]+//g; /([A-Z]\w*)\d\b/$1/g"?>

This page shows you how to use each major Dart feature, from
variables and operators to classes and libraries, with the assumption
that you already know how to program in another language.
For a briefer, less complete introduction to the language, see the
[language samples page](/samples).

本文将从变量和运算符开始到类和库的使用来向你介绍 Dart 编程语言的主要功能，
这里假设你已经有使用其它语言进行编程的经验。

To learn more about Dart's core libraries, see the
[library tour](/guides/libraries/library-tour).
Whenever you want more details about a language feature,
consult the [Dart language specification][].

你可以通过查看 [Dart 库概览](/guides/libraries/library-tour) 
学习更多关于 Dart 核心库的知识。
若还想了解更多有关语言功能的详细内容，
请参阅 [Dart 编程语言规范][Dart language specification]。

{{site.alert.note}}

  You can play with most of Dart's language features using DartPad
  ([learn more](/tools/dartpad)).
  **<a href="{{site.dartpad}}" target="_blank" rel="noopener">Open
  DartPad.</a>**
  
  使用 DartPad 可以体验 Dart 的大部分语言功能 ([了解更多](/tools/dartpad))，
  **<a href="{{site.dartpad}}" target="_blank" rel="noopener">打开 DartPad。</a>**
  
  This page uses embedded DartPads to display some of the examples.
  
  本页面内嵌了一些 DartPads 做例子展示，
  
  {% include dartpads-embedded-troubleshooting.md %}

{{site.alert.end}}

## A basic Dart program

## 一个简单的 Dart 程序

The following code uses many of Dart’s most basic features:

下面的应用程序代码用到了很多 Dart 的基本功能：

<?code-excerpt "misc/test/language_tour/basic_test.dart"?>
```dart
// Define a function.
printInteger(int aNumber) {
  print('The number is $aNumber.'); // 打印输出到控制台。
}

// Dart 程序从 main() 函数开始执行。
main() {
  var number = 42; // 声明并初始化一个变量。
  printInteger(number); // 调用一个函数。
}
```

Here’s what this program uses that applies to all (or almost all) Dart
apps:

下面是上述应用程序中使用到的代码片段，这些代码片段适用于所有（或几乎所有）的 Dart 应用：

<code>// <em>This is a comment.</em> </code>

<code>// <em>注释。</em> </code>

:   A single-line comment.
    Dart also supports multi-line and document comments.
    For details, see [Comments](#comments).

    以双斜杠开头的一行语句称为单行注释。Dart 同样支持多行注释和文档注释。查阅[注释](#comments)获取更多相关信息。

`int`

:   A type. Some of the other [built-in types](#built-in-types)
    are `String`, `List`, and `bool`.

    表示一种数据类型。Dart 中一些其他的[内置类型](#built-in-types)包括 `String`、`List` 和 `bool`。

`42`

:   A number literal. Number literals are a kind of compile-time constant.

    表示一个数字字面量。数字字面量是一种编译时常量。

`print()`

:   A handy way to display output.

    一种便利的将信息输出显示的方式。

`'...'` (或 `"..."`)

:   A string literal.

    表示字符串字面量。

<code>$<em>variableName</em></code> (或 <code>${<em>expression</em>}</code>)

:   String interpolation: including a variable or expression’s string
    equivalent inside of a string literal. For more information, see
    [Strings](#strings).

    表示字符串插值：字符串字面量中包含的变量或表达式。查阅[字符串](#strings)获取更多相关信息。

`main()`

:   The special, *required*, top-level function where app execution
    starts. For more information, see
    [The main() function](#the-main-function).

    一个特殊且 *必须的* 顶级函数，Dart 应用程序总是会从该函数开始执行。查阅 [main() 函数](#the-main-function) 获取更多相关信息。

`var`

:   A way to declare a variable without specifying its type.

    用于定义变量，通过这种方式定义变量不需要指定变量类型。

{{site.alert.note}}

  This site's code follows the conventions in the
  [Dart style guide](/guides/language/effective-dart/style).
  
  本站的代码遵循 
  [Dart 风格指南](/guides/language/effective-dart/style) 中的约定。

{{site.alert.end}}


## Important concepts

## 重要概念

As you learn about the Dart language, keep these facts and concepts in
mind:

当你在学习 Dart 语言时, 应该牢记以下几点：

-   Everything you can place in a variable is an *object*, and every
    object is an instance of a *class*. Even numbers, functions, and
    `null` are objects. All objects inherit from the [Object][] class.

    所有变量引用的都是 *对象*，每个对象都是一个 *类* 的实例。数字、函数以及 `null` 都是对象。所有的类都继承于 [Object][] 类。

-   Although Dart is strongly typed, type annotations are optional
    because Dart can infer types. In the code above, `number`
    is inferred to be of type `int`. When you want to explicitly say
    that no type is expected,
    [use the special type `dynamic`][ObjectVsDynamic].

    尽管 Dart 是强类型语言，但是在声明变量时指定类型是可选的，因为 Dart 可以进行类型推断。在上述代码中，变量 `number` 的类型被推断为 `int` 类型。如果想显式地声明一个不确定的类型，可以[使用特殊类型 `dynamic`][ObjectVsDynamic]。

-   Dart supports generic types, like `List<int>` (a list of integers)
    or `List<dynamic>` (a list of objects of any type).

    Dart 支持泛型，比如 `List<int>`（表示一组由 int 对象组成的列表）或 `List<dynamic>`（表示一组由任何类型对象组成的列表）。

-   Dart supports top-level functions (such as `main()`), as well as
    functions tied to a class or object (*static* and *instance
    methods*, respectively). You can also create functions within
    functions (*nested* or *local functions*).

    Dart 支持顶级函数（例如 `main` 方法），同时还支持定义属于类或对象的函数（即 *静态* 和 *实例方法*）。你还可以在函数中定义函数（*嵌套* 或 *局部函数*）。

-   Similarly, Dart supports top-level *variables*, as well as variables
    tied to a class or object (static and instance variables). Instance
    variables are sometimes known as fields or properties.

    Dart 支持顶级 *变量*，以及定义属于类或对象的变量（静态和实例变量）。实例变量有时称之为域或属性。

-   Unlike Java, Dart doesn’t have the keywords `public`, `protected`,
    and `private`. If an identifier starts with an underscore (\_), it’s
    private to its library. For details, see
    [Libraries and visibility](#libraries-and-visibility).

    Dart 没有类似于 Java 那样的 `public`、`protected` 和 `private` 成员访问限定符。如果一个标识符以下划线 (\_) 开头则表示该标识符在库内是私有的。可以查阅 [库和可见性](#libraries-and-visibility) 获取更多相关信息。

-   *Identifiers* can start with a letter or underscore (\_), followed by any
    combination of those characters plus digits.

    *标识符* 可以以字母或者下划线 (\_) 开头，其后可跟字符和数字的组合。

-   Dart has both *expressions* (which have runtime values) and
    *statements* (which don't).
    For example, the [conditional expression](#conditional-expressions)
    `condition ? expr1 : expr2` has a value of `expr1` or `expr2`.
    Compare that to an [if-else statement](#if-and-else), which has no value.
    A statement often contains one or more expressions,
    but an expression can't directly contain a statement.

    Dart 中 *表达式* 和 *语句* 是有区别的，表达式有值而语句没有。比如[条件表达式](#conditional-expressions) `expression condition ? expr1 : expr2` 中含有值 `expr1` 或 `expr2`。与 [if-else 分支语句](#if-and-else)相比，`if-else` 分支语句则没有值。一个语句通常包含一个或多个表达式，但是一个表达式不能只包含一个语句。

-   Dart tools can report two kinds of problems: _warnings_ and _errors_.
    Warnings are just indications that your code might not work, but
    they don’t prevent your program from executing. Errors can be either
    compile-time or run-time. A compile-time error prevents the code
    from executing at all; a run-time error results in an
    [exception](#exceptions) being raised while the code executes.

    Dart 工具可以显示 _警告_ 和 _错误_ 两种类型的问题。警告表明代码可能有问题但不会阻止其运行。错误分为编译时错误和运行时错误；编译时错误代码无法运行；运行时错误会在代码运行时导致[异常](#exceptions)。

{{site.alert.note}}

  If you're curious why Dart uses underscores instead of
  access modifier keywords like `public` or `private`, see
  [SDK issue 33383](https://github.com/dart-lang/sdk/issues/33383).
  
  如果您好奇 Dart 为什么使用下划线而不使用诸如 `public` 或 `private` 作为修饰符，
  请参阅 [SDK 议题 #33383](https://github.com/dart-lang/sdk/issues/33383)。
{{site.alert.end}}


## Keywords

## 关键字

The following table lists the words that the Dart language treats specially.

下面的表格中列出了 Dart 语言所使用的关键字。

{% assign ckw = '&nbsp;<sup title="contextual keyword" alt="contextual keyword">1</sup>' %}
{% assign bii = '&nbsp;<sup title="built-in-identifier" alt="built-in-identifier">2</sup>' %}
{% assign lrw = '&nbsp;<sup title="limited reserved word" alt="limited reserved word">3</sup>' %}
| [abstract][]{{bii}}   | [else][]              | [import][]{{bii}}     | [super][]         |
| [as][]{{bii}}         | [enum][]              | [in][]                | [switch][]        |
| [assert][]            | [export][]{{bii}}     | [interface][]{{bii}}  | [sync][]{{ckw}}   |
| [async][]{{ckw}}      | [extends][]           | [is][]                | [this][]          |
| [await][]{{lrw}}      | [extension][]{{bii}}  | [library][]{{bii}}    | [throw][]         |
| [break][]             | [external][]{{bii}}   | [mixin][]{{bii}}      | [true][]          |
| [case][]              | [factory][]{{bii}}    | [new][]               | [try][]           |
| [catch][]             | [false][]             | [null][]              | [typedef][]{{bii}}|
| [class][]             | [final][]             | [on][]{{ckw}}         | [var][]           |
| [const][]             | [finally][]           | [operator][]{{bii}}   | [void][]          |
| [continue][]          | [for][]               | [part][]{{bii}}       | [while][]         |
| [covariant][]{{bii}}  | [Function][]{{bii}}   | [rethrow][]           | [with][]          |
| [default][]           | [get][]{{bii}}        | [return][]            | [yield][]{{lrw}}  |
| [deferred][]{{bii}}   | [hide][]{{ckw}}       | [set][]{{bii}}        |                   |
| [do][]                | [if][]                | [show][]{{ckw}}       |                   |
| [dynamic][]{{bii}}    | [implements][]{{bii}} | [static][]{{bii}}     |                   |
{:.table .table-striped .nowrap}

[abstract]: #abstract-classes
[as]: #type-test-operators
[assert]: #assert
[async]: #asynchrony-support
[await]: #asynchrony-support
[break]: #break-and-continue
[case]: #switch-and-case
[catch]: #catch
[class]: #instance-variables
[const]: #final-and-const
{% comment %}
  [TODO: Make sure that points to a place that talks about const constructors,
  as well as const literals and variables.]
{% endcomment %}
[continue]: #break-and-continue
[covariant]: /guides/language/sound-problems#the-covariant-keyword
[default]: #switch-and-case
[deferred]: #lazily-loading-a-library
[do]: #while-and-do-while
[dynamic]: #important-concepts
[else]: #if-and-else
[enum]: #enumerated-types
[export]: /guides/libraries/create-library-packages
[extends]: #extending-a-class
[extension]: #extension-methods
[external]: https://stackoverflow.com/questions/24929659/what-does-external-mean-in-dart
[factory]: #factory-constructors
[false]: #booleans
[final]: #final-and-const
[finally]: #finally
[for]: #for-loops
[Function]: #functions
[get]: #getters-and-setters
[hide]: #importing-only-part-of-a-library
[if]: #if-and-else
[implements]: #implicit-interfaces
[import]: #using-libraries
[in]: #for-loops
[interface]: https://stackoverflow.com/questions/28595501/was-the-interface-keyword-removed-from-dart
[is]: #type-test-operators
[library]: #libraries-and-visibility
[mixin]: #adding-features-to-a-class-mixins
[new]: #using-constructors
[null]: #default-value
[on]: #catch
[operator]: #overridable-operators
[part]: /guides/libraries/create-library-packages#organizing-a-library-package
[rethrow]: #catch
[return]: #functions
[set]: #getters-and-setters
[show]: #importing-only-part-of-a-library
[static]: #class-variables-and-methods
[super]: #extending-a-class
[switch]: #switch-and-case
[sync]: #generators
[this]: #constructors
[throw]: #throw
[true]: #booleans
[try]: #catch
[typedef]: #typedefs
[var]: #variables
[void]: https://medium.com/dartlang/dart-2-legacy-of-the-void-e7afb5f44df0
{% comment %}
  TODO: Add coverage of void to the language tour.
{% endcomment %}
[with]: #adding-features-to-a-class-mixins
[while]: #while-and-do-while
[yield]: #generators

Avoid using these words as identifiers.
However, if necessary, the keywords marked with superscripts can be identifiers:

应该避免使用这些单词作为标识符。但是，带有上标的单词可以在必要的情况下作为标识符：

* Words with the superscript **1** are **contextual keywords**,
  which have meaning only in specific places.
  They're valid identifiers everywhere.

  带有上标 **1** 的关键字为 **上下文关键字**，只有在特定的场景才有意义，它们可以在任何地方作为有效的标识符。

* Words with the superscript **2** are **built-in identifiers**.
  To simplify the task of porting JavaScript code to Dart,
  these keywords are valid identifiers in most places,
  but they can't be used as class or type names, or as import prefixes.

  带有上标 **2** 的关键字为 **内置标识符**，其作用只是在JavaScript代码转为Dart代码时更简单，这些关键字在大多数时候都可以作为有效的标识符，但是它们不能用作类名或者类型名或者作为导入前缀使用。

* Words with the superscript **3** are newer, limited reserved words related to
  the [asynchrony support](#asynchrony-support) that was added
  after Dart's 1.0 release.
  You can't use `await` or `yield` as an identifier
  in any function body marked with `async`, `async*`, or `sync*`.

  带有上标 **3** 的关键字为 Dart1.0 发布后用于[支持异步](#asynchrony-support)相关的特性新加的。不能在由关键字 `async`、`async*` 或 `sync*` 标识的方法体中使用 `await` 或 `yield` 作为标识符。

All other words in the table are **reserved words**,
which can't be identifiers.

其它没有上标的关键字为 **保留字**，均不能用作标识符。

## Variables

## 变量

Here’s an example of creating a variable and initializing it:

下面的示例代码将创建一个变量并将其初始化：

<?code-excerpt "misc/lib/language_tour/variables.dart (var-decl)"?>
```dart
var name = 'Bob';
```

Variables store references. The variable called `name` contains a
reference to a `String` object with a value of “Bob”.

变量仅存储对象的引用。这里名为 `name` 的变量存储了一个 `String` 类型对象的引用，“Bob” 则是该对象的值。

The type of the `name` variable is inferred to be `String`,
but you can change that type by specifying it.
If an object isn't restricted to a single type,
specify the `Object` or `dynamic` type, following
[design guidelines][ObjectVsDynamic].

`name` 变量的类型被推断为 `String`，但是你可以为其指定类型。如果一个对象的引用不局限于单一的类型，可以根据[设计指南][ObjectVsDynamic]将其指定为 `Object` 或 `dynamic` 类型。

{% comment %}
**[PENDING: check on Object vs. dynamic guidance.]**
{% endcomment %}

<?code-excerpt "misc/lib/language_tour/variables.dart (type-decl)"?>
```dart
dynamic name = 'Bob';
```

Another option is to explicitly declare the type that would be inferred:

除此之外你也可以指定类型：

<?code-excerpt "misc/lib/language_tour/variables.dart (static-types)"?>
```dart
String name = 'Bob';
```

{{site.alert.note}}

  This page follows the
  [style guide recommendation](/guides/language/effective-dart/design#types)
  of using `var`, rather than type annotations, for local variables.
  
  本文遵循
  [风格建议指南](/guides/language/effective-dart/design#types) 中的建议，
  通过 `var` 声明局部变量而非使用指定的类型。

{{site.alert.end}}


### Default value

### 默认值

Uninitialized variables have an initial value of `null`. Even variables
with numeric types are initially null, because numbers—like everything
else in Dart—are objects.

在 Dart 中，未初始化的变量拥有一个默认的初始化值：`null`。
即便数字也是如此，因为在 Dart 中一切皆为对象，数字也不例外。

<?code-excerpt "misc/test/language_tour/variables_test.dart (var-null-init)"?>
```dart
int lineCount;
assert(lineCount == null);
```

{{site.alert.note}}

  Production code ignores the `assert()` call. During development, on the other
  hand, <code>assert(<em>condition</em>)</code> throws an exception if
  _condition_ is false. For details, see [Assert](#assert).
  
  `assert()` 的调用将会在生产环境的代码中被忽略掉。
  在开发过程中，<code>assert(<em>condition</em>)</code> 
  将会在 **条件判断** 为 false 时抛出一个异常。
  详情请查阅 [Assert](#assert)。

{{site.alert.end}}

### Final and const

### Final 和 Const

If you never intend to change a variable, use `final` or `const`, either
instead of `var` or in addition to a type. A final variable can be set
only once; a const variable is a compile-time constant. (Const variables
are implicitly final.) A final top-level or class variable is initialized
the first time it's used.

如果你不想更改一个变量，可以使用关键字 `final` 或者 `const` 修饰变量，
这两个关键字可以替代 `var` 关键字或者加在一个具体的类型前。
一个 final 变量只可以被赋值一次；
一个 const 变量是一个编译时常量（const 变量同时也是 final 的）。
顶层的 final 变量或者类的 final 变量在其第一次使用的时候被初始化。


{{site.alert.note}}

  Instance variables can be `final` but not `const`.
  Final instance variables must be initialized before
  the constructor body starts —
  at the variable declaration, by a constructor parameter,
  or in the constructor's [initializer list](#initializer-list).
  
  实例变量可以是 `final` 的但不可以是 `const` 的，
  final 实例变量必须在构造器开始前被初始化，比如在声明实例变量时初始化，
  或者作为构造器参数，或者将其置于构造器的 [初始化列表](#initializer-list)中。

{{site.alert.end}}

Here's an example of creating and setting a final variable:

下面的示例中我们创建并设置两个 final 变量：

<?code-excerpt "misc/lib/language_tour/variables.dart (final)"?>
```dart
final name = 'Bob'; // Without a type annotation
final String nickname = 'Bobby';
```

You can't change the value of a final variable:

你不能修改一个 final 变量的值：

{:.fails-sa}
<?code-excerpt "misc/lib/language_tour/variables.dart (cant-assign-to-final)"?>
```dart
name = 'Alice'; // Error: a final variable can only be set once.
```

Use `const` for variables that you want to be **compile-time constants**. If
the const variable is at the class level, mark it `static const`.
Where you declare the variable, set the value to a compile-time constant
such as a number or string literal, a const
variable, or the result of an arithmetic operation on constant numbers:

使用关键字 `const` 修饰变量表示该变量为 **编译时常量**。如果使用 const 修饰类中的变量，则必须加上 static 关键字，即 `static const`（注意：顺序不能颠倒（译者注））。在声明 const 变量时可以直接为其赋值，也可以使用其它的 const 变量为其赋值：

<?code-excerpt "misc/lib/language_tour/variables.dart (const)"?>
```dart
const bar = 1000000; // 直接赋值 [Unit of pressure (dynes/cm2)]
const double atm = 1.01325 * bar; // 利用其它 const 变量赋值 (Standard atmosphere)
```

The `const` keyword isn't just for declaring constant variables.
You can also use it to create constant _values_,
as well as to declare constructors that _create_ constant values.
Any variable can have a constant value.

`const` 关键字不仅仅可以用来定义常量，还可以用来创建 _常量值_，该常量值可以赋予给任何变量。你也可以将构造函数声明为 const 的，这种类型的构造函数创建的对象是不可改变的。

<?code-excerpt "misc/lib/language_tour/variables.dart (const-vs-final)"?>
```dart
var foo = const [];
final bar = const [];
const baz = []; // 相当于 `const []` (Equivalent to `const []`)
```

You can omit `const` from the initializing expression of a `const` declaration,
like for `baz` above. For details, see [DON’T use const redundantly][].

如果使用初始化表达式为常量赋值可以省略掉关键字 `const`，比如上面的常量 `baz` 的赋值就省略掉了 `const`。详情请查阅[DON’T use const redundantly][]

You can change the value of a non-final, non-const variable,
even if it used to have a const value:

没有使用 final 或 const 修饰的变量的值是可以被更改的，即使这些变量之前引用过 const 的值。

<?code-excerpt "misc/lib/language_tour/variables.dart (reassign-to-non-final)"?>
```dart
foo = [1, 2, 3]; // foo 的值之前为 const [] (Was const [])
```

You can't change the value of a const variable:

常量的值不可以被修改：

{:.fails-sa}
<?code-excerpt "misc/lib/language_tour/variables.dart (cant-assign-to-const)"?>
```dart
baz = [42]; // 报错：常量不可以被赋值。(Error: Constant variables can't be assigned a value.)
```

As of Dart 2.5, you can define constants that use
[type checks and casts](#type-test-operators) (`is` and `as`),
[collection if](#collection-operators),
and [spread operators](#spread-operator) (`...` and `...?`):

从 Dart 2.5 开始，你可以在常量中使用[类型检查和强制类型转换](#type-test-operators) (`is` and `as`)、[collection if](#collection-operators) 以及 [spread operators](#spread-operator) (`...` and `...?`)：

<?code-excerpt "misc/lib/language_tour/variables.dart (const-dart-25)"?>
```dart
// Valid compile-time constants as of Dart 2.5.
const Object i = 3; // Where i is a const Object with an int value...
const list = [i as int]; // Use a typecast.
const map = {if (i is int) i: "int"}; // Use is and collection if.
const set = {if (list is List<int>) ...list}; // ...and a spread.
```
For more information on using `const` to create constant values, see
[Lists](#lists), [Maps](#maps), and [Classes](#classes).

可以查阅 [Lists](#lists)、[Maps](#maps) 和 [Classes](#classes) 
获取更多关于使用 `const` 创建常量值的信息。

## Built-in types

## 内置类型

The Dart language has special support for the following types:

Dart 语言支持下列的类型：

- numbers
- strings
- booleans
- lists (also known as *arrays*)

  lists (也被称为 *arrays*)

- sets
- maps
- runes (for expressing Unicode characters in a string)

  runes (用于在字符串中表示 Unicode 字符)

- symbols

You can initialize an object of any of these special types using a
literal. For example, `'this is a string'` is a string literal,
and `true` is a boolean literal.

可以直接使用字面量来初始化上述类型。例如 `'This is a string'` 是一个字符串字面量，`true` 是一个布尔字面量。

{% comment %}
PENDING: add info about support for Iterable, Future, Stream?
Those can't be initialized using literals, but they do have special support.
{% endcomment %}

Because every variable in Dart refers to an object—an instance of a
*class*—you can usually use *constructors* to initialize variables. Some
of the built-in types have their own constructors. For example, you can
use the `Map()` constructor to create a map.

由于 Dart 中每个变量引用都指向一个对象（一个 *类* 的实例），你通常也可以使用 *构造器* 来初始化变量。一些内置的类型有它们自己的构造器。例如你可以使用 `Map()` 来创建一个 map 对象。


### Numbers

Dart numbers come in two flavors:

Dart 支持两种 Number 类型：

[int][]

:   Integer values no larger than 64 bits,
    depending on the platform.
    On the Dart VM, values can be from
    -2<sup>63</sup> to 2<sup>63</sup> - 1.
    Dart that's compiled to JavaScript uses
    [JavaScript numbers,][js numbers]
    allowing values from -2<sup>53</sup> to 2<sup>53</sup> - 1.

    整数值；长度不超过 64位，具体取值范围依赖于不同的平台。
    在 DartVM 上其取值位于 -2<sup>63</sup> 至 2<sup>63</sup> - 1 之间。
    编译成 JavaScript 的 Dart 使用 [JavaScript 数字][js numbers]，
    其允许的取值范围在 -2<sup>53</sup> 至 2<sup>53</sup> - 1 之间。

{% comment %}
[PENDING: What about values on Android & iOS?
The informal spec is at
https://github.com/dart-lang/sdk/blob/master/docs/language/informal/int64.md.
{% endcomment %}

[double][]

:   64-bit (double-precision) floating-point numbers, as specified by
    the IEEE 754 standard.

    64位的双精度浮点数字，且符合 IEEE 754 标准。


Both `int` and `double` are subtypes of [`num`.][num]
The num type includes basic operators such as +, -, /, and \*,
and is also where you’ll find `abs()`,` ceil()`,
and `floor()`, among other methods.
(Bitwise operators, such as \>\>, are defined in the `int` class.)
If num and its subtypes don’t have what you’re looking for, the
[dart:math][] library might.

`int` 和 `double` 都是 [`num`][num] 的子类。
num 中定义了一些基本的运算符比如 +、-、\*、/ 等，
还定义了 `abs()`、`ceil()` 和 `floor()` 等方法
（位运算符，比如 >> 定义在 int 中）。
如果 num 及其子类不满足你的要求，
可以查看 [dart:math][] 库中的 API。

Integers are numbers without a decimal point. Here are some examples of
defining integer literals:

整数是不带小数点的数字，
下面是一些定义整数字面量的例子：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (integer-literals)"?>
```dart
var x = 1;
var hex = 0xDEADBEEF;
```

If a number includes a decimal, it is a double. Here are some examples
of defining double literals:

如果一个数字包含了小数点，那么它就是浮点型的。下面是一些定义浮点数字面量的例子：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (double-literals)"?>
```dart
var y = 1.1;
var exponents = 1.42e5;
```

As of Dart 2.1, integer literals are automatically converted to doubles
when necessary:

从 Dart 2.1 开始，整型字面量将会在必要的时候自动转换成浮点数字面量：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (int-to-double)"?>
```dart
double z = 1; // Equivalent to double z = 1.0.
```

{{site.alert.version-note}}

  Before Dart 2.1, it was an error to use an integer literal in a double
  context.
  
  在 Dart 2.1 之前，在浮点数上下文中使用整数字面量是错误的。

{{site.alert.end}}

Here’s how you turn a string into a number, or vice versa:

下面是字符串和数字之间转换的方式：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (number-conversion)"?>
```dart
// String -> int
var one = int.parse('1');
assert(one == 1);

// String -> double
var onePointOne = double.parse('1.1');
assert(onePointOne == 1.1);

// int -> String
String oneAsString = 1.toString();
assert(oneAsString == '1');

// double -> String
String piAsString = 3.14159.toStringAsFixed(2);
assert(piAsString == '3.14');
```

The int type specifies the traditional bitwise shift (\<\<, \>\>), AND
(&), and OR (|) operators. For example:

整型支持传统的位移操作，比如移位（\<\<、\>\>）、按位与（&）、按位或（|），例如：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (bit-shifting)"?>
```dart
assert((3 << 1) == 6); // 0011 << 1 == 0110
assert((3 >> 1) == 1); // 0011 >> 1 == 0001
assert((3 | 4) == 7); // 0011 | 0100 == 0111
```

Literal numbers are compile-time constants.
Many arithmetic expressions are also compile-time constants,
as long as their operands are
compile-time constants that evaluate to numbers.

数字字面量为编译时常量。很多算术表达式只要其操作数是常量，则表达式结果也是编译时常量。

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (const-num)"?>
```dart
const msPerSecond = 1000;
const secondsUntilRetry = 5;
const msUntilRetry = secondsUntilRetry * msPerSecond;
```


### Strings

A Dart string is a sequence of UTF-16 code units. You can use either
single or double quotes to create a string:

Dart 字符串是 UTF-16 编码的字符序列。可以使用单引号或者双引号来创建字符串：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (quoting)"?>
```dart
var s1 = 'Single quotes work well for string literals.';
var s2 = "Double quotes work just as well.";
var s3 = 'It\'s easy to escape the string delimiter.';
var s4 = "It's even easier to use the other delimiter.";

// 代码中文解释
var s1 = '使用单引号创建字符串字面量。';
var s2 = "双引号也可以用于创建字符串字面量。";
var s3 = '使用单引号创建字符串时可以使用斜杠来转义那些与单引号冲突的字符串：\'。';
var s4 = "而在双引号中则不需要使用转义与单引号冲突的字符串：'";
```

You can put the value of an expression inside a string by using
`${`*`expression`*`}`. If the expression is an identifier, you can skip
the {}. To get the string corresponding to an object, Dart calls the
object’s `toString()` method.

可以在字符串中以 `${`*`表达式`*`}` 的形式使用表达式，
如果表达式是一个标识符，可以省略掉 {}。
如果表达式的结果为一个对象，则 Dart 会调用该对象的 `toString` 方法来获取一个字符串。

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (string-interpolation)"?>
```dart
var s = 'string interpolation';

assert('Dart has $s, which is very handy.' ==
    'Dart has string interpolation, ' +
        'which is very handy.');
assert('That deserves all caps. ' +
        '${s.toUpperCase()} is very handy!' ==
    'That deserves all caps. ' +
        'STRING INTERPOLATION is very handy!');

// 代码中文解释
var s = '字符串插值';

assert('Dart 有$s，使用起来非常方便。' == 'Dart 有字符串插值，使用起来非常方便。');
assert('使用${s.substring(3,5)}表达式也非常方便' == '使用插值表达式也非常方便。');
```

{{site.alert.note}}

  The `==` operator tests whether two objects are equivalent. Two
  strings are equivalent if they contain the same sequence of code
  units.
  
  `==` 运算符判断两个对象的内容是否一样，
  如果两个字符串包含一样的字符编码序列，则表示相等。

{{site.alert.end}}

You can concatenate strings using adjacent string literals or the `+`
operator:

可以使用 `+` 运算符将两个字符串连接为一个，也可以将多个字符串挨着放一起变为一个：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (adjacent-string-literals)"?>
```dart
var s1 = 'String '
    'concatenation'
    " works even over line breaks.";
assert(s1 ==
    'String concatenation works even over '
        'line breaks.');

var s2 = 'The + operator ' + 'works, as well.';
assert(s2 == 'The + operator works, as well.');

// 代码中文解释
var s1 = '可以拼接'
    '字符串'
    "即便它们不在同一行。";
assert(s1 == '可以拼接字符串即便它们不在同一行。');

var s2 = '使用加号 + 运算符' + '也可以达到相同的效果。';
assert(s2 == '使用加号 + 运算符也可以达到相同的效果。');
```

Another way to create a multi-line string: use a triple quote with
either single or double quotation marks:

可以使用三个单引号或者三个双引号创建多行字符串：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (triple-quotes)"?>
```dart
var s1 = '''
你可以像这样创建
多行字符串。
''';

var s2 = """这也是一个
多行字符串。""";
```

You can create a “raw” string by prefixing it with `r`:

在字符串前加上 `r` 作为前缀创建 “raw” 字符串（即不会被做任何处理（比如转义）的字符串）：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (raw-strings)"?>
```dart
var s = r'In a raw string, not even \n gets special treatment.';

// 代码中文解释
var s = r'在 raw 字符串中，转义字符串 \n 会直接输出 “\n” 而不是转义为换行。';
```

See [Runes and grapheme clusters](#characters) for details on how
to express Unicode characters in a string.

你可以查阅 [Runes and grapheme clusters](#characters) 获取更多关于如何在字符串中表示 Unicode 字符的信息。

Literal strings are compile-time constants,
as long as any interpolated expression is a compile-time constant
that evaluates to null or a numeric, string, or boolean value.

字符串字面量是一个编译时常量，只要是编译时常量都可以作为字符串字面量的插值表达式：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (string-literals)"?>
```dart
// 可以将下面三个常量作为字符串插值拼接到字符串字面量中。(These work in a const string.)
const aConstNum = 0;
const aConstBool = true;
const aConstString = 'a constant string';

// 而下面三个常量则不能作为字符串插值拼接到字符串字面量。
var aNum = 0;
var aBool = true;
var aString = 'a string';
const aConstList = [1, 2, 3];

const validConstString = '$aConstNum $aConstBool $aConstString';
// const invalidConstString = '$aNum $aBool $aString $aConstList';
```

For more information on using strings, see
[Strings and regular expressions](/guides/libraries/library-tour#strings-and-regular-expressions).

可以查阅 [字符串和正则表达式](/guides/libraries/library-tour#strings-and-regular-expressions) 获取更多关于如何使用字符串的信息。


### Booleans

To represent boolean values, Dart has a type named `bool`. Only two
objects have type bool: the boolean literals `true` and `false`,
which are both compile-time constants.

Dart 使用 `bool` 关键字表示布尔类型，布尔类型只有两个对象 `true` 和 `false`，两者都是编译时常量。

Dart's type safety means that you can't use code like
<code>if (<em>nonbooleanValue</em>)</code> or
<code>assert (<em>nonbooleanValue</em>)</code>.
Instead, explicitly check for values, like this:

Dart 的类型安全不允许你使用类似 <code>if (<em>nonbooleanValue</em>)</code> 或者 <code>assert (<em>nonbooleanValue</em>)</code> 这样的代码检查布尔值。相反，你应该总是显示地检查布尔值，比如像下面的代码这样：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (no-truthy)"?>
```dart
// 检查是否为空字符串 (Check for an empty string).
var fullName = '';
assert(fullName.isEmpty);

// 检查是否小于等于零。
var hitPoints = 0;
assert(hitPoints <= 0);

// 检查是否为 null。
var unicorn;
assert(unicorn == null);

// 检查是否为 NaN。
var iMeantToDoThis = 0 / 0;
assert(iMeantToDoThis.isNaN);
```


### Lists

Perhaps the most common collection in nearly every programming language
is the *array*, or ordered group of objects. In Dart, arrays are
[List][] objects, so most people just call them *lists*.

数组 *Array* 是几乎所有编程语言中最常见的集合类型，在 Dart 中数组由 [List][] 对象表示。通常称之为 *List*。

Dart list literals look like JavaScript array literals. Here’s a simple
Dart list:

Dart 中 List 字面量看起来与 JavaScript 中数组字面量一样。下面是一个 Dart List 的示例：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (list-literal)"?>
```dart
var list = [1, 2, 3];
```

{{site.alert.note}}

  Dart infers that `list` has type `List<int>`. If you try to add non-integer
  objects to this list, the analyzer or runtime raises an error. For more
  information, read about
  [type inference.](/guides/language/type-system#type-inference)
  
  这里 Dart 推断出 `list` 的类型为 `List<int>`，
  如果往该数组中添加一个非 int 类型的对象则会报错。
  你可以阅读 
  [类型推断](/guides/language/type-system#type-inference) 获取更多相关信息。

{{site.alert.end}}

Lists use zero-based indexing, where 0 is the index of the first value
and `list.length - 1` is the index of the last value. You can get a
list’s length and refer to list values just as you would in
JavaScript:

List 的下标索引从 0 开始，第一个元素的下标为 0，最后一个元素的下标为 `list.length - 1`。你可以像 JavaScript 中的用法那样获取 Dart 中 List 的长度以及元素：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (list-indexing)"?>
```dart
var list = [1, 2, 3];
assert(list.length == 3);
assert(list[1] == 2);

list[1] = 1;
assert(list[1] == 1);
```

To create a list that's a compile-time constant,
add `const` before the list literal:

如果想要创建一个编译时常量的 List，在 List 字面量前添加 `const` 关键字即可：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (const-list)"?>
```dart
var constantList = const [1, 2, 3];
// constantList[1] = 1; // 取消注释将导致出错 (Uncommenting this causes an error.)
```

<a id="spread-operator"> </a>
Dart 2.3 introduced the **spread operator** (`...`) and the
**null-aware spread operator** (`...?`),
which provide a concise way to insert multiple values into a collection.

Dart 在 2.3 引入了 **扩展操作符**（`...`）和 **null-aware 扩展操作符**（`...?`），它们提供了一种将多个元素插入集合的简洁方法。

For example, you can use the spread operator (`...`) to insert
all the values of a list into another list:

例如，你可以使用扩展操作符（`...`）将一个 List 中的所有元素插入到另一个 List 中：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (list-spread)"?>
```dart
var list = [1, 2, 3];
var list2 = [0, ...list];
assert(list2.length == 4);
```

If the expression to the right of the spread operator might be null,
you can avoid exceptions by using a null-aware spread operator (`...?`):

如果扩展操作符右边可能为 null ，你可以使用 null-aware 扩展操作符（`...?`）来避免产生异常：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (list-null-spread)"?>
```dart
var list;
var list2 = [0, ...?list];
assert(list2.length == 1);
```

For more details and examples of using the spread operator, see the
[spread operator proposal.][spread proposal]

可以查阅[扩展操作符建议][spread proposal]获取更多关于如何使用扩展操作符的信息。

<a id="collection-operators"> </a>
Dart 2.3 also introduced **collection if** and **collection for**,
which you can use to build collections using conditionals (`if`)
and repetition (`for`).

Dart 在 2.3 还同时引入了 **Collection If** 和 **Collection For**，在构建集合时，可以使用条件判断（`if`）和循环（`for`）。

Here's an example of using **collection if**
to create a list with three or four items in it:

下面示例是使用 **Collection If** 来创建一个 List 的示例， 它可能包含 3 个或 4 个元素：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (list-if)"?>
```dart
var nav = [
  'Home',
  'Furniture',
  'Plants',
  if (promoActive) 'Outlet'
];
```

Here's an example of using **collection for**
to manipulate the items of a list before
adding them to another list:

下面示例是使用 **Collection For** 将列表中的元素修改后添加到另一个列表中的示例：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (list-for)"?>
```dart
var listOfInts = [1, 2, 3];
var listOfStrings = [
  '#0',
  for (var i in listOfInts) '#$i'
];
assert(listOfStrings[1] == '#1');
```

For more details and examples of using collection if and for, see the
[control flow collections proposal.][collections proposal]

你可以查阅[集合中使用控制流建议][collections proposal]获取更多关于使用 **Collection If** 和 **Collection For** 的细节内容和示例。

[collections proposal]: https://github.com/dart-lang/language/blob/master/accepted/2.3/control-flow-collections/feature-specification.md

[spread proposal]: https://github.com/dart-lang/language/blob/master/accepted/2.3/spread-collections/feature-specification.md

The List type has many handy methods for manipulating lists. For more
information about lists, see [Generics](#generics) and
[Collections](/guides/libraries/library-tour#collections).

List 类中有许多用于操作 List 的便捷方法，你可以查阅[泛型](#generics)和[集合](/guides/libraries/library-tour#collections)获取更多与之相关的信息。


### Sets

A set in Dart is an unordered collection of unique items.
Dart support for sets is provided by set literals and the [Set][Set class] type.

在 Dart 中，set 是一组特定元素的无序集合。
Dart 所支持的 set 由 set literals 和 [Set][Set class] 类所提供。

{{site.alert.version-note}}

  Although the Set _type_ has always been a core part of Dart, set _literals_
  were introduced in Dart 2.2.
  
  尽管 Set **类型(type)** 一直都是 Dart 的一项核心功能，
  但是 Set **字面量(literals)** 却是在 Dart2.2 中才加入的。

{{site.alert.end}}

Here is a simple Dart set, created using a set literal:

下面是使用 Set 字面量来创建一个 Set 集合的方法：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (set-literal)"?>
```dart
var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'};
```

{{site.alert.note}}

  Dart infers that `halogens` has the type `Set<String>`. If you try to add the
  wrong type of value to the set, the analyzer or runtime raises an error. For
  more information, read about
  [type inference.](/guides/language/type-system#type-inference)
  
  Dart 推断 `halogens` 变量是一个 `Set<String>` 类型的集合，
  如果往该 Set 中添加类型不正确的对象则会报错。
  你可以查阅
  [类型推断](/guides/language/type-system#type-inference) 获取更多与之相关的内容。

{{site.alert.end}}

To create an empty set, use `{}` preceded by a type argument,
or assign `{}` to a variable of type `Set`:

可以使用在 `{}` 前加上类型参数的方式创建一个空的 Set，或者将 `{}` 赋值给一个 Set 类型的变量：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (set-vs-map)"?>
```dart
var names = <String>{}; // 类型+{}的形式创建Set。
// Set<String> names = {}; // 声明类型变量的形式创建 Set (This works, too).
// var names = {}; // 这样的形式将创建一个 Map 而不是 Set (Creates a map, not a set.)
```

{{site.alert.info}}

  **Set or map?** The syntax for map literals is similar to that for set
  literals. Because map literals came first, `{}` defaults to the `Map` type. If
  you forget the type annotation on `{}` or the variable it's assigned to, then
  Dart creates an object of type `Map<dynamic, dynamic>`.
  
  **Set 还是 map?** Map 字面量语法同 Set 字面量语法非常相似。
  因为先有的 Map 字面量语法，所以 `{}` 默认是 `Map` 类型。
  如果忘记在 `{}` 上注释类型或赋值到一个未声明类型的变量上，
  那么 Dart 会创建一个类型为 `Map<dynamic, dynamic>` 的对象。

{{site.alert.end}}

Add items to an existing set using the `add()` or `addAll()` methods:

向一个已存在的 Set 中添加项目可以使用 `add()` 方法或 `addAll()` 方法：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (set-add-items)"?>
```dart
var elements = <String>{};
elements.add('fluorine');
elements.addAll(halogens);
```

Use `.length` to get the number of items in the set:

使用 `.length` 可以获取 Set 中元素的数量：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (set-length)"?>
```dart
var elements = <String>{};
elements.add('fluorine');
elements.addAll(halogens);
assert(elements.length == 5);
```

To create a set that's a compile-time constant,
add `const` before the set literal:

可以在 Set 字面量前添加 `const` 关键字创建一个 Set 编译时常量：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (const-set)"?>
```dart
final constantSet = const {
  'fluorine',
  'chlorine',
  'bromine',
  'iodine',
  'astatine',
};
// constantSet.add('helium'); // 取消注释将导致出错 (Uncommenting this causes an error).
```

As of Dart 2.3, sets support spread operators (`...` and `...?`)
and collection ifs and fors,
just like lists do.
For more information, see the
[list spread operator](#spread-operator) and
[list collection operator](#collection-operators) discussions.

从 Dart 2.3 开始，Set 可以像 List 一样支持使用扩展操作符（`...` 和 `...?`）
以及 Collection If 和 Collection For 操作。
你可以查阅 [List 扩展操作符](#spread-operator) 和
[List 集合操作符](#collection-operators) 获取更多相关信息。

For more information about sets, see
[Generics](#generics) and
[Sets](/guides/libraries/library-tour#sets).

你也可以查阅 [泛型](#generics) 以及
[Set](/guides/libraries/library-tour#sets) 获取更多相关信息。

### Maps

In general, a map is an object that associates keys and values. Both
keys and values can be any type of object. Each *key* occurs only once,
but you can use the same *value* multiple times. Dart support for maps
is provided by map literals and the [Map][] type.

通常来说， Map 是用来关联 keys 和 values 的对象。
keys 和 values 可以是任何类型的对象。在一个 Map 对象中一个 *key* 只能出现一次。
但是 *value* 可以出现多次。 Dart 中 Map 通过 Map 字面量 和 [Map][] 类型来实现。
通常来说，Map 是一个键值对相关的对象。其中键和值都可以是任何类型的对象。
每个 *键* 只能出现一次但是 *值* 可以重复出现多次。
Dart 中 Map 提供了 Map 字面量以及 [Map][] 类型两种形式的 Map。

Here are a couple of simple Dart maps, created using map literals:

下面是一对使用 Map 字面量创建 Map 的例子：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (map-literal)"?>
```dart
var gifts = {
  // 键:    值
  'first': 'partridge',
  'second': 'turtledoves',
  'fifth': 'golden rings'
};

var nobleGases = {
  2: 'helium',
  10: 'neon',
  18: 'argon',
};
```

{{site.alert.note}}

  Dart infers that `gifts` has the type `Map<String, String>` and `nobleGases`
  has the type `Map<int, String>`. If you try to add the wrong type of value to
  either map, the analyzer or runtime raises an error. For more information,
  read about [type inference.](/guides/language/type-system#type-inference)

  Dart 将 `gifts` 变量的类型推断为 `Map<String, String>`，
  而降 `nobleGases` 的类型推断为 `Map<int, String>`。
  如果你向这两个 Map 对象中添加不正确的类型值，将导致运行时异常。
  你可以阅读
  [类型推断](/guides/language/type-system#type-inference) 获取更多相关信息。

{{site.alert.end}}

You can create the same objects using a Map constructor:

你也可以使用 Map 的构造器创建 Map：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (map-constructor)"?>
```dart
var gifts = Map();
gifts['first'] = 'partridge';
gifts['second'] = 'turtledoves';
gifts['fifth'] = 'golden rings';

var nobleGases = Map();
nobleGases[2] = 'helium';
nobleGases[10] = 'neon';
nobleGases[18] = 'argon';
```

{{site.alert.note}}

  You might expect to see `new Map()` instead of just `Map()`.
  As of Dart 2, the `new` keyword is optional.
  For details, see [Using constructors](#using-constructors).
  
  这里为什么使用 `Map()` 而不是使用 `new Map()` 构造 Map 对象。
  因为从 Dart2 开始，构造对象的 `new` 关键字可以被省略掉。
  你可以查阅 [构造函数的使用](#using-constructors)获取更多相关信息。

{{site.alert.end}}

Add a new key-value pair to an existing map just as you would in
JavaScript:

向现有的 Map 中添加键值对与 JavaScript 的操作类似：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (map-add-item)"?>
```dart
var gifts = {'first': 'partridge'};
gifts['fourth'] = 'calling birds'; // 添加键值对 (Add a key-value pair)
```

Retrieve a value from a map the same way you would in JavaScript:

从一个 Map 中获取一个值的操作也与 JavaScript 类似。

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (map-retrieve-item)"?>
```dart
var gifts = {'first': 'partridge'};
assert(gifts['first'] == 'partridge');
```

If you look for a key that isn’t in a map, you get a null in return:

如果检索的 Key 不存在于 Map 中则会返回一个 null：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (map-missing-key)"?>
```dart
var gifts = {'first': 'partridge'};
assert(gifts['fifth'] == null);
```

Use `.length` to get the number of key-value pairs in the map:

使用 `.length` 可以获取 Map 中键值对的数量：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (map-length)"?>
```dart
var gifts = {'first': 'partridge'};
gifts['fourth'] = 'calling birds';
assert(gifts.length == 2);
```

To create a map that's a compile-time constant,
add `const` before the map literal:

在一个 Map 字面量前添加 `const` 关键字可以创建一个 Map 编译时常量：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (const-map)"?>
```dart
final constantMap = const {
  2: 'helium',
  10: 'neon',
  18: 'argon',
};

// constantMap[2] = 'Helium'; // 取消注释将导致出错 (Uncommenting this causes an error).
```

As of Dart 2.3, maps support spread operators (`...` and `...?`)
and collection if and for, just like lists do.
For details and examples, see the
[spread operator proposal][spread proposal] and the
[control flow collections proposal.][collections proposal]

从 Dart 2.3 Map 可以像 List 一样支持使用扩展操作符（`...` 和 `...?`）以及 Collection If 和 Collection For 操作。你可以查阅 [List 扩展操作符](#spread-operator)和 [List 集合操作符](#collection-operators)获取更多相关信息。

For more information about maps, see
[Generics](#generics) and
[Maps](/guides/libraries/library-tour#maps).

你也可以查阅[泛型](#generics)以及 [Maps](/guides/libraries/library-tour#maps) 获取更多相关信息。

<a id="characters"></a>
### Runes and grapheme clusters

### Runes 与 grapheme clusters

In Dart, [runes][] expose the Unicode code points of a string.
As of Dart 2.6, use the [characters package][]
to view or manipulate user-perceived characters,
also known as
[Unicode (extended) grapheme clusters.][grapheme clusters]

在 Dart 中，[runes][] 公开了字符串的 Unicode 码位。
从 Dart 2.6 开始，使用 [characters 包][characters package]来访问
或者操作用户感知的字符，也被称为 [Unicode (扩展) grapheme clusters.][grapheme clusters]。

Unicode defines a unique numeric value for each letter, digit,
and symbol used in all of the world's writing systems.
Because a Dart string is a sequence of UTF-16 code units,
expressing Unicode code points within a string requires
special syntax.

Unicode 编码为每一个字母、数字和符号都定义了一个唯一的数值。
因为 Dart 中的字符串是一个 UTF-16 的字符序列，
所以如果想要表示 32 位的 Unicode 数值则需要一种特殊的语法。

The usual way to express a Unicode code point is
`\uXXXX`, where XXXX is a 4-digit hexadecimal value.
For example, the heart character (♥) is `\u2665`.
To specify more or less than 4 hex digits,
place the value in curly brackets.
For example, the laughing emoji (😆) is `\u{1f606}`.

通常使用 `\uXXXX` 来表示 Unicode 字符，
XXXX 是一个四位数的 16 进制数字。
例如心形字符（♥）的 Unicode 为 `\u2665`。
对于不是四位数的 16 进制数字，
需要使用大括号将其括起来。
例如大笑的 emoji 表情（😆）的 Unicode 为 `\u{1f600}`。

If you need to read or write individual Unicode characters,
use the `characters` getter defined on String
by the characters package.
The returned [`Characters`][] object is the string as
a sequence of grapheme clusters.
Here's an example of using the characters API:

如果你需要读写单个 Unicode 字符，可以使用 characters 包中定义
的 `characters` getter。
它将返回 [`Characters`][] 作为一系列 grapheme clusters
的字符串。下面是使用 characters API 的样例：

{% comment %}
TODO: add test code
{% endcomment %}

```dart
import 'package:characters/characters.dart';
...
var hi = 'Hi 🇩🇰';
print(hi);
print('The end of the string: ${hi.substring(hi.length - 1)}');
print('The last character: ${hi.characters.last}\n');
```

The output, depending on your environment, looks something like this:

输出取决于你的环境，看上去会像这样：

```terminal
$ dart bin/main.dart
Hi 🇩🇰
The end of the string: ???
The last character: 🇩🇰
```

For details on using the characters package to manipulate strings,
see the [example][characters example] and [API reference][characters API]
for the characters package.

有关使用 characters 包操作字符串的详细信息，请参阅用于 characters 包的[样例][characters example]
和 [API 参考][characters API]。

{{site.alert.note}}

  Be careful when manipulating runes using list operations. This approach can
  easily break down, depending on the particular language, character set, and
  operation. For more information, see [How do I reverse a String in Dart?][] on
  Stack Overflow.
  
  在使用 List 操作 Rune 的时候需要小心，
  根据所操作的语种、字符集等不同可能会导致字符串出现问题，
  具体可参考 Stack Overflow 中的提问：
  [我如何在 Dart 中反转一个字符串？][How do I reverse a String in Dart?]。

{{site.alert.end}}

### Symbols

A [Symbol][] object
represents an operator or identifier declared in a Dart program. You
might never need to use symbols, but they're invaluable for APIs that
refer to identifiers by name, because minification changes identifier
names but not identifier symbols.

Symbol 表示 Dart 中声明的操作符或者标识符，该类型的对象几乎不会被使用到
，但是如果需要按名称引用它们的 API 时就非常有用。
因为代码压缩后会改变这些符号的名称但不会改变具体的符号。

To get the symbol for an identifier, use a symbol literal, which is just
`#` followed by the identifier:

可以使用在标识符前加 `#` 前缀来获取 Symbol：

```nocode
#radix
#bar
```

{% comment %}
The code from the following excerpt isn't actually what is being shown in the page

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (symbols)"?>
```dart
// MOVE TO library tour?

void main() {
  print(Function.apply(int.parse, ['11']));
  print(Function.apply(int.parse, ['11'], {#radix: 16}));
  print(Function.apply(int.parse, ['11a'], {#onError: handleError}));
  print(Function.apply(
      int.parse, ['11a'], {#radix: 16, #onError: handleError}));
}

int handleError(String source) {
  return 0;
}
```
{% endcomment %}

Symbol literals are compile-time constants.

Symbol 字面量是编译时常量。

## Functions

Dart is a true object-oriented language, so even functions are objects
and have a type, [Function.][Function API reference]
This means that functions can be assigned to variables or passed as arguments
to other functions. You can also call an instance of a Dart class as if
it were a function. For details, see [Callable classes](#callable-classes).

Dart 是一种真正面向对象的语言，所以即便函数也是对象并且类型为
[Function][Function API reference]，这意味着函数
可以被赋值给变量或者作为其它函数的参数。
你也可以像调用函数一样调用 Dart 类的实例。
详情请查阅 [可调用的类](#callable-classes)。

Here’s an example of implementing a function:

下面是定义一个函数的例子：

<?code-excerpt "misc/lib/language_tour/functions.dart (function)"?>
```dart
bool isNoble(int atomicNumber) {
  return _nobleGases[atomicNumber] != null;
}
```

Although Effective Dart recommends
[type annotations for public APIs](/guides/language/effective-dart/design#prefer-type-annotating-public-fields-and-top-level-variables-if-the-type-isnt-obvious),
the function still works if you omit the types:

虽然高效 Dart 指南建议在[公开的 API 上定义返回类型](/guides/language/effective-dart/design#prefer-type-annotating-public-fields-and-top-level-variables-if-the-type-isnt-obvious)，
不过即便不定义，该函数也依然有效：

<?code-excerpt "misc/lib/language_tour/functions.dart (function-omitting-types)"?>
```dart
isNoble(atomicNumber) {
  return _nobleGases[atomicNumber] != null;
}
```

For functions that contain just one expression, you can use a shorthand
syntax:

如果函数体内只包含一个表达式，你可以使用简写语法：

<?code-excerpt "misc/lib/language_tour/functions.dart (function-shorthand)"?>
```dart
bool isNoble(int atomicNumber) => _nobleGases[atomicNumber] != null;
```

The <code>=> <em>expr</em></code> syntax is a shorthand for
<code>{ return <em>expr</em>; }</code>. The `=>` notation
is sometimes referred to as _arrow_ syntax.

语法 <code>=> <em>表达式</em></code> 
是 <code>{ return <em>表达式</em>; }</code> 的简写，
`=>` 有时也称之为胖箭头语法。

{{site.alert.note}}

  Only an *expression*—not a *statement*—can appear between the arrow (=\>) and
  the semicolon (;). For example, you can’t put an [if statement](#if-and-else)
  there, but you can use a [conditional expression](#conditional-expressions).
  
  在 =\> 与 ; 之间的只能是 *表达式* 而非 *语句*。
  比如你不能将一个 [if语句](#if-and-else) 放在其中，
  但是可以放置 [条件表达式](#conditional-expressions)。

{{site.alert.end}}

### Parameters

A function can have any number of *required positional* parameters. These can be
followed either by *named* parameters or by *optional positional* parameters
(but not both).

函数可以有两种形式的参数：**必要参数** 和 **可选参数**。
必要参数定义在参数列表前面，可选参数则定义在必要参数后面。
可选参数可以是 **命名的** 或 **位置的**。

{{site.alert.note}}

  Some APIs — notably [Flutter][] widget constructors — use only named
  parameters, even for parameters that are mandatory. See the next section for
  details.
  
  某些 API，特别是 [Flutter][] 控件的构造器，它只使用命名参数，
  即便参数是强制性的。可以查阅下一节获取更多信息。

{{site.alert.end}}

#### Named parameters

#### 已命名的参数

Named parameters are optional unless they're specifically marked as required.

已命名的参数是可选参数了，除非他们被特别标记为 required。

When calling a function, you can specify named parameters using
<code><em>paramName</em>: <em>value</em></code>. For example:

当你调用函数时，可以使用 <code><em>参数名</em>: <em>参数值</em></code> 的形式来指定命名参数。例如：

<?code-excerpt "misc/lib/language_tour/functions.dart (use-named-parameters)"?>
```dart
enableFlags(bold: true, hidden: false);
```

When defining a function, use
<code>{<em>参数1</em>, <em>参数2</em>, …}</code>
to specify named parameters:

定义函数时，使用 <code>{<em>param1</em>, <em>param2</em>, …}</code> 来指定命名参数：

<?code-excerpt "misc/lib/language_tour/functions.dart (specify-named-parameters)"?>
```dart
/// 设置 [bold] 和 [hidden] 标识……
/// Sets the [bold] and [hidden] flags...
void enableFlags({bool bold, bool hidden}) {...}
```

Although named parameters are a kind of optional parameter,
you can annotate them with [@required][] to indicate
that the parameter is mandatory —
that users must provide a value for the parameter.
For example:

虽然命名参数是可选参数的一种类型，
但是你仍然可以使用 [@required][] 注解来标识一个命名参数是必须的参数，
此时调用者则必须为该参数提供一个值。例如：

<?code-excerpt "misc/lib/language_tour/functions.dart (required-named-parameters)" replace="/@required/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
const Scrollbar({Key key, [!@required!] Widget child})
{% endprettify %}

If someone tries to create a `Scrollbar`
without specifying the `child` argument,
then the analyzer reports an issue.

如果调用者想要通过 `Scrollbar` 的构造函数构造一个 Scrollbar 对象而不提供 `child` 参数，则会导致编译错误。

To use the [@required][] annotation,
depend on the [meta][] package and import `package:meta/meta.dart`.

[@required][] 注解定义在 [meta][] package 中，
可以直接导入 `package:meta/meta.dart` 包使用。

{% comment %}
NULLSAFE: Rewrite this section.
{% endcomment %}

#### Optional positional parameters

#### 可选的位置参数

Wrapping a set of function parameters in `[]` marks them as optional
positional parameters:

使用 `[]` 将一系列参数包裹起来作为位置参数：

<?code-excerpt "misc/test/language_tour/functions_test.dart (optional-positional-parameters)"?>
```dart
String say(String from, String msg, [String device]) {
  var result = '$from says $msg';
  if (device != null) {
    result = '$result with a $device';
  }
  return result;
}
```

Here’s an example of calling this function without the optional
parameter:

下面是不使用可选参数调用上述函数的示例：

<?code-excerpt "misc/test/language_tour/functions_test.dart (call-without-optional-param)"?>
```dart
assert(say('Bob', 'Howdy') == 'Bob says Howdy');
```

And here’s an example of calling this function with the third parameter:

下面是使用可选参数调用上述函数的示例：

<?code-excerpt "misc/test/language_tour/functions_test.dart (call-with-optional-param)"?>
```dart
assert(say('Bob', 'Howdy', 'smoke signal') ==
    'Bob says Howdy with a smoke signal');
```

<a id="default-parameters"></a>
#### Default parameter values

#### 默认参数值

Your function can use `=` to define default values for both named and positional
parameters. The default values must be compile-time constants.
If no default value is provided, the default value is `null`.

可以用 `=` 为函数的命名和位置参数定义默认值，默认值必须为编译时常量，没有指定默认值的情况下默认值为 `null`。

Here's an example of setting default values for named parameters:

下面是设置可选参数默认值示例：

<?code-excerpt "misc/lib/language_tour/functions.dart (named-parameter-default-values)"?>
```dart
/// 设置 [bold] 和 [hidden] 标识……
/// Sets the [bold] and [hidden] flags ...
void enableFlags({bool bold = false, bool hidden = false}) {...}

// bold 的值将为 true；而 hidden 将为 false。
enableFlags(bold: true);
```

{{site.alert.info}}

  **Deprecation note:** Old code might use a colon (`:`) instead of `=` to set
  default values of named parameters. The reason is that originally, only `:`
  was supported for named parameters. That support might be deprecated, so we
  recommend that you **[use `=` to specify default values.][use =]**
  
  在老版本的 Dart 代码中会使用 冒号（`:`）而不是 `=` 来设置命名参数的默认值。
  原因在于刚开始的时候命名参数只支持 `:`。不过现在这个支持已经过时，
  所以我们建议你现在都 **[使用 `=` 来指定默认值][use =]**。

  [use =]: /guides/language/effective-dart/usage#do-use--to-separate-a-named-parameter-from-its-default-value

{{site.alert.end}}

{% comment %}
PENDING: I don't see evidence that we've dropped support for `:`.
Update if/when we do. Issue #?
See `defaultNamedParameter` in the language spec.
{% endcomment %}

The next example shows how to set default values for positional parameters:

下一个示例将向你展示如何为位置参数设置默认值：

<?code-excerpt "misc/test/language_tour/functions_test.dart (optional-positional-param-default)"?>
```dart
String say(String from, String msg,
    [String device = 'carrier pigeon', String mood]) {
  var result = '$from says $msg';
  if (device != null) {
    result = '$result with a $device';
  }
  if (mood != null) {
    result = '$result (in a $mood mood)';
  }
  return result;
}

assert(say('Bob', 'Howdy') ==
    'Bob says Howdy with a carrier pigeon');
```

You can also pass lists or maps as default values.
The following example defines a function, `doStuff()`,
that specifies a default list for the `list`
parameter and a default map for the `gifts` parameter.

List 或 Map 同样也可以作为默认值。下面的示例定义了一个名为 `doStuff()` 的函数，并为其名为 `list` 和 `gifts` 的参数指定了一个 List 类型的值和 Map 类型的值。

{% comment %}
The function is called three times with different values. Click **Run** to see
list and map default values in action.
{% endcomment %}

<?code-excerpt "misc/lib/language_tour/functions.dart (list-map-default-function-param)"?>
```dart
void doStuff(
    {List<int> list = const [1, 2, 3],
    Map<String, String> gifts = const {
      'first': 'paper',
      'second': 'cotton',
      'third': 'leather'
    }}) {
  print('list:  $list');
  print('gifts: $gifts');
}
```

{% comment %}
https://gist.github.com/d988cfce0a54c6853799
{{site.dartpad}}/d988cfce0a54c6853799
(The gist needs updating: see https://github.com/dart-lang/site-www/issues/189)
<iframe
src="{{site.dartpad-embed-inline}}?id=d988cfce0a54c6853799&ga_id=default_parameter_values"
    width="100%"
    height="450px"
    style="border: 1px solid #ccc;">
</iframe>
{% endcomment %}


### The main() function

### main() 函数

Every app must have a top-level `main()` function, which serves as the
entrypoint to the app. The `main()` function returns `void` and has an
optional `List<String>` parameter for arguments.

每个 Dart 程序都必须有一个 `main()` 顶级函数作为程序的入口，`main()` 函数返回值为 `void` 并且有一个 `List<String>` 类型的可选参数。

Here's an example of the `main()` function for a web app:

下面是一个 Web 应用的 `main()` 函数示例：

<?code-excerpt "misc/test/language_tour/browser_test.dart (simple-web-main-function)"?>
```dart
void main() {
  querySelector('#sample_text_id')
    ..text = 'Click me!'
    ..onClick.listen(reverseText);
}
```

{{site.alert.note}}

  The `..` syntax in the preceding code is called a
  [cascade](#cascade-notation-). With cascades, you can perform multiple
  operations on the members of a single object.
  
  上述代码中的 `..` 语法称之为 [级联调用](#cascade-notation-)。
  使用级联访问可以在一个对象上执行多个操作。

{{site.alert.end}}

Here's an example of the `main()` function for a command-line app that
takes arguments:

下面是使用命令行访问带参数的 `main()` 函数示例：

<?code-excerpt "misc/test/language_tour/functions_test.dart (main-args)"?>
```dart
// 使用命令 dart args.dart 1 test 运行该应用
// Run the app like this: dart args.dart 1 test
void main(List<String> arguments) {
  print(arguments);

  assert(arguments.length == 2);
  assert(int.parse(arguments[0]) == 1);
  assert(arguments[1] == 'test');
}
```

You can use the [args library]({{site.pub}}/packages/args) to
define and parse command-line arguments.

你可以通过使用 [参数库]({{site.pub}}/packages/args) 来定义和解析命令行参数。

### Functions as first-class objects

### 函数作为一级对象

You can pass a function as a parameter to another function. For example:

可以将函数作为参数传递给另一个函数。例如：

<?code-excerpt "misc/lib/language_tour/functions.dart (function-as-param)"?>
```dart
void printElement(int element) {
  print(element);
}

var list = [1, 2, 3];

// 将 printElement 函数作为参数传递。
list.forEach(printElement);
```

You can also assign a function to a variable, such as:

你也可以将函数赋值给一个变量，比如：

<?code-excerpt "misc/test/language_tour/functions_test.dart (function-as-var)"?>
```dart
var loudify = (msg) => '!!! ${msg.toUpperCase()} !!!';
assert(loudify('hello') == '!!! HELLO !!!');
```

This example uses an anonymous function.
More about those in the next section.

该示例中使用了匿名函数。下一节会有更多与其相关的介绍。

### Anonymous functions

### 匿名函数

Most functions are named, such as `main()` or `printElement()`.
You can also create a nameless function
called an _anonymous function_, or sometimes a _lambda_ or _closure_.
You might assign an anonymous function to a variable so that,
for example, you can add or remove it from a collection.

大多数方法都是有名字的，比如 `main()` 或 `printElement()`。你可以创建一个没有名字的方法，称之为 _匿名函数_，或 _Lambda表达式_ 或 _Closure闭包_。你可以将匿名方法赋值给一个变量然后使用它，比如将该变量添加到集合或从中删除。

An anonymous function looks similar to a named function&mdash;
zero or more parameters, separated by commas
and optional type annotations, between parentheses.

匿名方法看起来与命名方法类似，在括号之间可以定义参数，参数之间用逗号分割。

The code block that follows contains the function's body:

后面大括号中的内容则为函数体：

<code>
([[<em>类型</em>] <em>参数</em>[, …]]) { <br>
&nbsp;&nbsp;<em>函数体</em>; <br>
}; <br>
</code>

The following example defines an anonymous function with an untyped parameter, `item`.
The function, invoked for each item in the list,
prints a string that includes the value at the specified index.

下面代码定义了只有一个参数 `item` 且没有参数类型的匿名方法。List 中的每个元素都会调用这个函数，打印元素位置和值的字符串：

<?code-excerpt "misc/test/language_tour/functions_test.dart (anonymous-function)"?>
```dart
var list = ['apples', 'bananas', 'oranges'];
list.forEach((item) {
  print('${list.indexOf(item)}: $item');
});
```

Click **Run** to execute the code.

点击运行按钮执行代码。

{% comment %}
https://gist.github.com/chalin/5d70bc1889d055c7a18d35d77874af88
{{site.dartpad}}/5d70bc1889d055c7a18d35d77874af88
{% endcomment %}

<iframe
src="{{site.dartpad-embed-inline}}?id=5d70bc1889d055c7a18d35d77874af88&split=60&ga_id=anonymous_functions"
    width="100%"
    height="400px"
    style="border: 1px solid #ccc;">
</iframe>

If the function contains only one statement, you can shorten it using arrow
notation. Paste the following line into DartPad and click **Run** to verify that
it is functionally equivalent.

如果函数体内只有一行语句，你可以使用胖箭头缩写法。粘贴下面代码到 DartPad 中并点击运行按钮，验证两个函数是否一致。

<?code-excerpt "misc/test/language_tour/functions_test.dart (anon-func)"?>
```dart
list.forEach(
    (item) => print('${list.indexOf(item)}: $item'));
```


### Lexical scope

### 词法作用域

Dart is a lexically scoped language, which means that the scope of
variables is determined statically, simply by the layout of the code.
You can “follow the curly braces outwards” to see if a variable is in
scope.

Dart 是词法有作用域语言，变量的作用域在写代码的时候就确定了，大括号内定义的变量只能在大括号内访问，与 Java 类似。

Here is an example of nested functions with variables at each scope
level:

下面是一个嵌套函数中变量在多个作用域中的示例：

<?code-excerpt "misc/test/language_tour/functions_test.dart (nested-functions)"?>
```dart
bool topLevel = true;

void main() {
  var insideMain = true;

  void myFunction() {
    var insideFunction = true;

    void nestedFunction() {
      var insideNestedFunction = true;

      assert(topLevel);
      assert(insideMain);
      assert(insideFunction);
      assert(insideNestedFunction);
    }
  }
}
```

Notice how `nestedFunction()` can use variables from every level, all
the way up to the top level.

注意 `nestedFunction()` 函数可以访问包括顶层变量在内的所有的变量。

### Lexical closures

### 词法闭包

A *closure* is a function object that has access to variables in its
lexical scope, even when the function is used outside of its original
scope.

*闭包* 即一个函数对象，即使函数对象的调用在它原始作用域之外，
依然能够访问在它词法作用域内的变量。

Functions can close over variables defined in surrounding scopes. In the
following example, `makeAdder()` captures the variable `addBy`. Wherever the
returned function goes, it remembers `addBy`.

函数可以封闭定义到它作用域内的变量。接下来的示例中，
函数 `makeAdder()` 捕获了变量 `addBy`。
无论函数在什么时候返回，它都可以使用捕获的 `addBy` 变量。

<?code-excerpt "misc/test/language_tour/functions_test.dart (function-closure)"?>
```dart
/// 返回一个将 [addBy] 添加到该函数参数的函数。
/// Returns a function that adds [addBy] to the
/// function's argument.
Function makeAdder(int addBy) {
  return (int i) => addBy + i;
}

void main() {
  // 生成加 2 的函数。
  var add2 = makeAdder(2);

  // 生成加 4 的函数。
  var add4 = makeAdder(4);

  assert(add2(3) == 5);
  assert(add4(3) == 7);
}
```


### Testing functions for equality

### 测试函数是否相等

Here's an example of testing top-level functions, static methods, and
instance methods for equality:

下面是顶级函数，静态方法和示例方法相等性的测试示例：

<?code-excerpt "misc/lib/language_tour/function_equality.dart"?>
```dart
void foo() {} // 定义顶层函数 (A top-level function)

class A {
  static void bar() {} // 定义静态方法
  void baz() {} // 定义实例方法
}

void main() {
  var x;

  // 比较顶层函数是否相等。
  x = foo;
  assert(foo == x);

  // 比较静态方法是否相等。
  x = A.bar;
  assert(A.bar == x);

  // 比较实例方法是否相等。
  var v = A(); // A 的实例 #1
  var w = A(); // A 的实例 #2
  var y = w;
  x = w.baz;

  // 这两个闭包引用了相同的实例对象，因此它们相等。
  assert(y.baz == x);

  // 这两个闭包引用了不同的实例对象，因此它们不相等。
  assert(v.baz != w.baz);
}
```


### Return values

### 返回值

All functions return a value. If no return value is specified, the
statement `return null;` is implicitly appended to the function body.

所有的函数都有返回值。没有显示返回语句的函数最后一行默认为执行 `return null;`。

<?code-excerpt "misc/test/language_tour/functions_test.dart (implicit-return-null)"?>
```dart
foo() {}

assert(foo() == null);
```


## Operators

## 运算符

Dart defines the operators shown in the following table.
You can override many of these operators, as described in
[Overridable operators](#overridable-operators).

|--------------------------+------------------------------------------------|
|Description               | Operator                                       |
|--------------------------|------------------------------------------------|
| 描述                     | 运算符                                         |
| unary postfix            | <code><em>expr</em>++</code>   <code><em>expr</em>--</code>   `()`   `[]`   `.`   `?.`     |
| 一元后缀                 | <code><em>表达式</em>++</code>   <code><em>表达式</em>--</code>   `()`   `[]`   `.`   `?.` |
| unary prefix             | <code>-<em>expr</em></code>   <code>!<em>expr</em></code>   <code>~<em>expr</em></code>   <code>++<em>expr</em></code>   <code>--<em>expr</em></code>    <code>await <em>expr</em></code>   |
| 一元前缀      | <code>-<em>表达式</em></code>   <code>!<em>表达式</em></code>   <code>~<em>表达式</em></code>   <code>++<em>表达式</em></code>   <code>--<em>表达式</em></code>  |
| multiplicative           | `*`   `/`   `%`    `~/`                      |
| 乘除法        | `*`   `/`   `%`    `~/`                                     |
| additive                 | `+`   `-`                                     |
| 加减法        | `+`   `-`                                                    |
| shift                    | `<<`   `>>`   `>>>`                          |
| 位运算        | `<<`   `>>`   `>>>`                                         |
| bitwise AND              | `&`                                            |
| 二进制与      | `&`                                                           |
| bitwise XOR              | `^`                                            |
| 二进制异或     | `^`                                                           |
| bitwise OR               | `|`                                            |
| 二进制或      | `|`                                                           |
| relational&nbsp;and&nbsp;type&nbsp;test | `>=`   `>`   `<=`   `<`   `as`   `is`   `is!` |
| 关系和类型测试 | `>=`   `>`   `<=`   `<`   `as`   `is`   `is!`           |
| equality                 | `==`   `!=`                                  |
| 相等判断      | `==`   `!=`                                                 |
| logical AND              | `&&`                                           |
| 逻辑与        | `&&`                                                          |
| logical OR               | `||`                                           |
| 逻辑或        | `||`                                                          |
| if null                  | `??`                                           |
| 空判断        | `??`                                                          |
| conditional              | <code><em>expr1</em> ? <em>expr2</em> : <em>expr3</em></code> |
| 条件表达式     | <code><em>表达式 1</em> ? <em>表达式 2</em> : <em>表达式 3</em></code> |
| cascade                  | `..`                                           |
| 级联          | `..`                                                          |
| assignment               | `=`   `*=`   `/=`   `+=`   `-=`   `&=`   `^=`   <em>etc.</em> |
| 赋值          | `=`   `*=`   `/=`   `+=`   `-=`   `&=`   `^=`   <em>等等……</em> |
{:.table .table-striped}

{{site.alert.warning}}

  Operator precedence is an approximation of the behavior of a Dart parser.
  For definitive answers, consult the grammar in the
  [Dart language specification][].
  
  上述运算符优先级是对 Dart 解析器行为的效仿。更准确的描述，
  请参阅 [Dart 语言规范][Dart language specification] 中的语法。

{{site.alert.end}}

When you use operators, you create expressions. Here are some examples
of operator expressions:

一旦你使用了运算符，就创建了表达式。下面是一些运算符表达式的示例：

<?code-excerpt "misc/test/language_tour/operators_test.dart (expressions)" replace="/,//g"?>
```dart
a++
a + b
a = b
a == b
c ? a : b
a is T
```

In the [operator table](#operators),
each operator has higher precedence than the operators in the rows
that follow it. For example, the multiplicative operator `%` has higher
precedence than (and thus executes before) the equality operator `==`,
which has higher precedence than the logical AND operator `&&`. That
precedence means that the following two lines of code execute the same
way:

在[运算符表](#operators) 中，运算符的优先级按先后排列，
即第一行优先级最高，最后一行优先级最低，
而同一行中，最左边的优先级最高，最右边的优先级最低。
例如：`%` 运算符优先级高于 `==` ，而 `==` 高于 `&&`。
根据优先级规则，那么意味着以下两行代码执行的效果相同：

<?code-excerpt "misc/test/language_tour/operators_test.dart (precedence)"?>
```dart
// 括号提高了可读性。
// Parentheses improve readability.
if ((n % i == 0) && (d % i == 0)) ...

// 难以理解，但是与上面的代码效果一样。
if (n % i == 0 && d % i == 0) ...
```

{{site.alert.warning}}

  For operators that work on two operands, the leftmost operand determines which
  version of the operator is used. For example, if you have a Vector object and
  a Point object, `aVector + aPoint` uses the Vector version of +.
  
  对于有两个操作数的运算符，左边的操作数决定了运算符的功能。
  比如如果有一个 Vector 对象和一个 Point 对象，
  表达式 `aVector + aPoint` 中所使用的是 Vector 对象中定义的 + 运算符。

{{site.alert.end}}


### Arithmetic operators

### 算术运算符

Dart supports the usual arithmetic operators, as shown in the following table.

Dart 支持常用的算术运算符：

|-----------------------------+-------------------------------------------|
| 运算符                       | 描述                                       |
|-----------------------------+-------------------------------------------|
| `+`                         | 加
| `–`                         | 减
| <code>-<em>表达式</em></code>| 一元负, 也可以作为反转（反转表达式的符号）
| `*`                         | 乘
| `/`                         | 除
| `~/`                        | 除并取整
| `%`                         | 取模
{:.table .table-striped}

Example:

示例：

<?code-excerpt "misc/test/language_tour/operators_test.dart (arithmetic)"?>
```dart
assert(2 + 3 == 5);
assert(2 - 3 == -1);
assert(2 * 3 == 6);
assert(5 / 2 == 2.5); // 结果是一个浮点数
assert(5 ~/ 2 == 2); // 结果是一个整数
assert(5 % 2 == 1); // 取余

assert('5/2 = ${5 ~/ 2} r ${5 % 2}' == '5/2 = 2 r 1');
```

Dart also supports both prefix and postfix increment and decrement
operators.

Dart 还支持自增自减操作。

|-----------------------------+-------------------------------------------|
| Operator                    | Meaning                                   |
|-----------------------------+-------------------------------------------|
| <code>++<em>var</em></code> | <code><em>var</em> = <em>var</em> + 1</code> (表达式的值为 <code><em>var</em> + 1</code>)
| <code><em>var</em>++</code> | <code><em>var</em> = <em>var</em> + 1</code> (表达式的值为 <code><em>var</em></code>)
| <code>--<em>var</em></code> | <code><em>var</em> = <em>var</em> – 1</code> (表达式的值为 <code><em>var</em> – 1</code>)
| <code><em>var</em>--</code> | <code><em>var</em> = <em>var</em> – 1</code> (表达式的值为 <code><em>var</em></code>)
{:.table .table-striped}

Example:

示例：

<?code-excerpt "misc/test/language_tour/operators_test.dart (increment-decrement)"?>
```dart
var a, b;

a = 0;
b = ++a; // 在 b 赋值前将 a 增加 1。
assert(a == b); // 1 == 1

a = 0;
b = a++; // 在 b 赋值后将 a 增加 1。
assert(a != b); // 1 != 0

a = 0;
b = --a; // 在 b 赋值前将 a 减少 1。
assert(a == b); // -1 == -1

a = 0;
b = a--; // 在 b 赋值后将 a 减少 1。
assert(a != b); // -1 != 0
```


### Equality and relational operators

### 关系运算符

The following table lists the meanings of equality and relational operators.

下表列出了关系运算符及含义：

|-----------+-------------------------------------------|
| Operator  | Meaning                                   |
|-----------+-------------------------------------------|
| `==`      |       相等
| `!=`      |       不等
| `>`       |       大于
| `<`       |       小于
| `>=`      |       大于等于
| `<=`      |       小于等于
{:.table .table-striped}

To test whether two objects x and y represent the same thing, use the
`==` operator. (In the rare case where you need to know whether two
objects are the exact same object, use the [identical()][]
function instead.) Here’s how the `==` operator works:

要判断两个对象 x 和 y 是否表示相同的事物使用 `==` 即可。
（在极少数情况下，可能需要使用 [identical()][] 函数来确定两个对象是否完全相同。）。下面是 `==` 运算符的一些规则：

1.  If *x* or *y* is null, return true if both are null, and false if only
    one is null.

    假设有变量 *x* 和 *y*，且 x 和 y 至少有一个为 null，
    则当且仅当 x 和 y 均为 null 时 x == y 才会返回 true，否则只有一个为 null 则返回 false。

2.  Return the result of the method invocation
    <code><em>x</em>.==(<em>y</em>)</code>. (That’s right,
    operators such as `==` are methods that are invoked on their first
    operand. You can even override many operators, including `==`, as
    you’ll see in
    [Overridable operators](#overridable-operators).)

    <code><em>x</em>.==(<em>y</em>)</code> 将会返回值，
    这里不管有没有 y，即 y 是可选的。
    也就是说 `==` 其实是 x 中的一个方法，并且可以被重写。
    详情请查阅[重写运算符](#overridable-operators)。

Here’s an example of using each of the equality and relational
operators:

下面的代码给出了每一种关系运算符的示例：

<?code-excerpt "misc/test/language_tour/operators_test.dart (relational)"?>
```dart
assert(2 == 2);
assert(2 != 3);
assert(3 > 2);
assert(2 < 3);
assert(3 >= 3);
assert(2 <= 3);
```


### Type test operators

### 类型判断运算符

The `as`, `is`, and `is!` operators are handy for checking types at
runtime.

`as`、`is`、`is!` 运算符是在运行时判断对象类型的运算符。

|-----------+-------------------------------------------|
| Operator  | Meaning                                   |
|-----------+-------------------------------------------|
| `as`      | 类型转换（也用作指定[类前缀](#specifying-a-library-prefix))）
| `is`      | 如果对象是指定类型则返回 true
| `is!`     | 如果对象是指定类型则返回 false
{:.table .table-striped}

The result of `obj is T` is true if `obj` implements the interface
specified by `T`. For example, `obj is Object` is always true.

当且仅当 `obj` 实现了 `T` 的接口，`obj is T` 才是 true。
例如 `obj is Object` 总为 true，因为所有类都是 Object 的子类。

Use the `as` operator to cast an object to a particular type if and only if
you are sure that the object is of that type. Example:

仅当你确定这个对象是该类型的时候，
你才可以使用 `as` 操作符可以把对象转换为特定的类型。例如：

<?code-excerpt "misc/lib/language_tour/classes/employee.dart (emp as Person)"?>
```dart
(emp as Person).firstName = 'Bob';
```

If you aren't sure that the object is of type `T`, then use `is T` to check the 
type before using the object.

如果你不确定这个对象类型是不是 `T`，
请在转型前使用 `is T` 检查类型。

<?code-excerpt "misc/lib/language_tour/classes/employee.dart (emp is Person)"?>
```dart
if (emp is Person) {
  // 类型检查
  emp.firstName = 'Bob';
}
```

You can make the code shorter using the `as` operator:

你可以使用 `as` 运算符进行缩写：

<?code-excerpt "misc/lib/language_tour/classes/employee.dart (emp as Person)"?>
```dart
(emp as Person).firstName = 'Bob';
```

{{site.alert.note}}

  The code isn’t equivalent. If `emp` is null or not a `Person`, the
  first example throws an exception; the second does nothing.
  
  上述两种方式是有区别的：如果 `emp` 为 null 或者不为 Person 类型，
  则第一种方式将会抛出异常，而第二种不会。

{{site.alert.end}}

### Assignment operators

### 赋值运算符

As you’ve already seen, you can assign values using the `=` operator.
To assign only if the assigned-to variable is null,
use the `??=` operator.

可以使用 `=` 来赋值，同时也可以使用 `??=` 来为值为 null 的变量赋值。

<?code-excerpt "misc/test/language_tour/operators_test.dart (assignment)"?>
```dart
// 将 value 赋值给 a (Assign value to a)
a = value;
// 当且仅当 b 为 null 时才赋值
b ??= value;
```

{% comment %}
<!-- embed a dartpad when we can hide code -->
https://gist.github.com/9de887c4daf76d39e524
{{site.dartpad}}/9de887c4daf76d39e524

<?code-excerpt "misc/test/language_tour/operators_test.dart (assignment-gist-main-body)" plaster="none"?>
```dart
void assignValues(int a, int b, int value) {
  print('Initially: a == $a, b == $b');
  // 将 value 赋值给 a
  a = value;
  // 当且仅当 b 为 null 时才赋值
  b ??= value;
  print('After: a == $a, b == $b');
}

main() {
  assignValues(0, 0, 1);
  assignValues(null, null, 1);
}
```
{% endcomment %}

Compound assignment operators such as `+=` combine
an operation with an assignment.

像 `+=` 这样的赋值运算符将算数运算符和赋值运算符组合在了一起。

| `=`  | `–=` | `/=`  | `%=`  | `>>=` | `^=`
| `+=` | `*=` | `~/=` | `<<=` | `&=`  | `|=`
{:.table}

Here’s how compound assignment operators work:

下表解释了符合运算符的原理：

|-----------+----------------------+-----------------------|
|    场景    |       复合运算        |        等效表达式       |
|-----------+----------------------+-----------------------|
|**假设有运算符 <em>op</em>：** | <code>a <em>op</em>= b</code> | <code>a = a <em>op</em> b</code>
|**示例：**                     |`a += b`                       | `a = a + b`
{:.table}

The following example uses assignment and compound assignment
operators:

下面的例子展示了如何使用赋值以及复合赋值运算符：

<?code-excerpt "misc/test/language_tour/operators_test.dart (op-assign)"?>
```dart
var a = 2; // 使用 = 赋值 (Assign using =)
a *= 3; // 赋值并做乘法运算 Assign and multiply: a = a * 3
assert(a == 6);
```


### Logical operators

### 逻辑运算符

You can invert or combine boolean expressions using the logical
operators.

使用逻辑运算符你可以反转或组合布尔表达式。

|-------------------------------+-------------------------------------------|
|             运算符             |                   描述                     |
|-------------------------------+-------------------------------------------|
| <code>!<em>表达式</em></code>  | 对表达式结果取反（即将 true 变为 false，false 变为 true）
| `||`                          | 逻辑或
| `&&`                          | 逻辑与
{:.table .table-striped}

Here’s an example of using the logical operators:

下面是使用逻辑表达式的示例：

<?code-excerpt "misc/lib/language_tour/operators.dart (op-logical)"?>
```dart
if (!done && (col == 0 || col == 3)) {
  // ...Do something...
}
```


### Bitwise and shift operators

### 按位和移位运算符

You can manipulate the individual bits of numbers in Dart. Usually,
you’d use these bitwise and shift operators with integers.

在 Dart 中，二进制位运算符可以操作二进制的某一位，但仅适用于整数。

|------------------------------+-------------------------------------------|
| 运算符                        | 描述                                       |
|------------------------------+-------------------------------------------|
| `&`                          | 按位与
| `|`                          | 按位或
| `^`                          | 按位异或
| <code>~<em>表达式</em></code> | 按位取反（即将 “0” 变为 “1”，“1” 变为 “0”）
| `<<`                         | 位左移
| `>>`                         | 位右移
{:.table .table-striped}

Here’s an example of using bitwise and shift operators:

下面是使用按位和移位运算符的示例：

<?code-excerpt "misc/test/language_tour/operators_test.dart (op-bitwise)"?>
```dart
final value = 0x22;
final bitmask = 0x0f;

assert((value & bitmask) == 0x02); // 按位与 (AND)
assert((value & ~bitmask) == 0x20); // 取反后按位与 (AND NOT)
assert((value | bitmask) == 0x2f); // 按位或 (OR)
assert((value ^ bitmask) == 0x2d); // 按位异或 (XOR)
assert((value << 4) == 0x220); // 位左移 (Shift left)
assert((value >> 4) == 0x02); // 位右移 (Shift right)
```


### Conditional expressions

### 条件表达式

Dart has two operators that let you concisely evaluate expressions
that might otherwise require [if-else](#if-and-else) statements:

Dart 有两个特殊的运算符可以用来替代 [if-else](#if-和-else) 语句：

<code><em>condition</em> ? <em>expr1</em> : <em>expr2</em></code>
: If _condition_ is true, evaluates _expr1_ (and returns its value);
  otherwise, evaluates and returns the value of _expr2_.

<code><em>条件</em> ? <em>表达式 1</em> : <em>表达式 2</em></code>
：如果条件为 true，执行表达式 1并返回执行结果，否则执行表达式 2 并返回执行结果。

<code><em>expr1</em> ?? <em>expr2</em></code>
: If _expr1_ is non-null, returns its value;
  otherwise, evaluates and returns the value of _expr2_.

<code><em>表达式 1</em> ?? <em>表达式 2</em></code>：如果表达式 1 为非 null 则返回其值，否则执行表达式 2 并返回其值。

When you need to assign a value
based on a boolean expression,
consider using `?:`.

如果赋值是根据布尔表达式则考虑使用 `?:`。

<?code-excerpt "misc/lib/language_tour/operators.dart (if-then-else-operator)"?>
```dart
var visibility = isPublic ? 'public' : 'private';
```

If the boolean expression tests for null,
consider using `??`.

如果赋值是根据判定是否为 null 则考虑使用 `??`。

<?code-excerpt "misc/test/language_tour/operators_test.dart (if-null)"?>
```dart
String playerName(String name) => name ?? 'Guest';
```

The previous example could have been written at least two other ways,
but not as succinctly:

上述示例还可以写成至少下面两种不同的形式，只是不够简洁：

<?code-excerpt "misc/test/language_tour/operators_test.dart (if-null-alt)"?>
```dart
// 相对使用 ?: 运算符来说稍微长了点。(Slightly longer version uses ?: operator).
String playerName(String name) => name != null ? name : 'Guest';

// 如果使用 if-else 则更长。
String playerName(String name) {
  if (name != null) {
    return name;
  } else {
    return 'Guest';
  }
}
```

<a id="cascade"></a>
### Cascade notation (..)

### 级联运算符（..）

Cascades (`..`) allow you to make a sequence of operations
on the same object. In addition to function calls,
you can also access fields on that same object.
This often saves you the step of creating a temporary variable and
allows you to write more fluid code.

级联运算符（`..`）可以让你在同一个对象上连续调用多个对象的变量或方法。

Consider the following code:

比如下面的代码：

<?code-excerpt "misc/test/language_tour/browser_test.dart (cascade-operator)"?>
```dart
querySelector('#confirm') // 获取对象 (Get an object).
  ..text = 'Confirm' // 使用对象的成员 (Use its members).
  ..classes.add('important')
  ..onClick.listen((e) => window.alert('Confirmed!'));
```

The first method call, `querySelector()`, returns a selector object.
The code that follows the cascade notation operates
on this selector object, ignoring any subsequent values that
might be returned.

第一个方法 `querySelector` 返回了一个 Selector 对象，后面的级联操作符都是调用这个 Selector 对象的成员并忽略每个操作的返回值。

The previous example is equivalent to:

上面的代码相当于：

<?code-excerpt "misc/test/language_tour/browser_test.dart (cascade-operator-example-expanded)"?>
```dart
var button = querySelector('#confirm');
button.text = 'Confirm';
button.classes.add('important');
button.onClick.listen((e) => window.alert('Confirmed!'));
```

You can also nest your cascades. For example:

级联运算符可以嵌套，例如：

<?code-excerpt "misc/lib/language_tour/operators.dart (nested-cascades)"?>
```dart
final addressBook = (AddressBookBuilder()
      ..name = 'jenny'
      ..email = 'jenny@example.com'
      ..phone = (PhoneNumberBuilder()
            ..number = '415-555-0100'
            ..label = 'home')
          .build())
    .build();
```

Be careful to construct your cascade on a function that returns
an actual object. For example, the following code fails:

在返回对象的函数中谨慎使用级联操作符。例如，下面的代码是错误的：

<?code-excerpt "misc/lib/language_tour/operators.dart (cannot-cascade-on-void)" plaster="none"?>
```dart
var sb = StringBuffer();
sb.write('foo')
  ..write('bar'); // 出错：void 对象中没有方法 write (Error: method 'write' isn't defined for 'void').
```

The `sb.write()` call returns void,
and you can't construct a cascade on `void`.

上述代码中的 `sb.write()` 方法返回的是 void，
返回值为 `void` 的方法则不能使用级联运算符。

{{site.alert.note}}

  Strictly speaking, the "double dot" notation for cascades is not an operator.
  It's just part of the Dart syntax.
  
  严格来说 `..` 级联操作并非一个运算符而是 Dart 的特殊语法。

{{site.alert.end}}

### Other operators

### 其他运算符

You've seen most of the remaining operators in other examples:

大多数其它的运算符，已经在其它的示例中使用过：

|----------+-------------------------------------------|
|   运算符  | 名字                  |          描述      |
|-----------+------------------------------------------|
| `()`     | 使用方法               | 代表调用一个方法
| `[]`     | 访问 List             | 访问 List 中特定位置的元素
| `.`      | 访问成员               | 成员访问符
| `?.`     | 条件访问成员            | 与上述成员访问符类似，但是左边的操作对象不能为 null，例如 foo?.bar，如果 foo 为 null 则返回 null ，否则返回 bar
{:.table .table-striped}

For more information about the `.`, `?.`, and `..` operators, see
[Classes](#classes).

更多关于 `.`, `?.` 和  `..` 运算符介绍，请参考[类](#classes).


## Control flow statements

## 流程控制语句

You can control the flow of your Dart code using any of the following:

你可以使用下面的语句来控制 Dart 代码的执行流程：

-   `if` and `else`

    `if` 和 `else`

-   `for` loops

    `for` 循环

-   `while` and `do`-`while` loops

    `while` 和 `do`-`while` 循环

-   `break` and `continue`

    `break` 和 `continue`

-   `switch` and `case`

    `switch` 和 `case`

-   `assert`

You can also affect the control flow using `try-catch` and `throw`, as
explained in [Exceptions](#exceptions).

使用 `try-catch` 和 `throw` 也能影响控制流，
详情参考[异常](#exceptions)部分。

### If and else

### If 和 Else

Dart supports `if` statements with optional `else` statements, as the
next sample shows. Also see [conditional expressions](#conditional-expressions).

Dart 支持 `if - else` 语句，其中 `else` 是可选的，
比如下面的例子。你也可以参考[条件表达式](#conditional-expressions)。

<?code-excerpt "misc/lib/language_tour/control_flow.dart (if-else)"?>
```dart
if (isRaining()) {
  you.bringRainCoat();
} else if (isSnowing()) {
  you.wearJacket();
} else {
  car.putTopDown();
}
```

Unlike JavaScript, conditions must use boolean values, nothing else. See
[Booleans](#booleans) for more information.

与 JavaScript 不同的是，Dart 的 if 语句中的条件必须是一个布尔值，
不能是其它类型。详情请查阅[布尔值](#booleans)。


### For loops

### For 循环

You can iterate with the standard `for` loop. For example:

你可以使用标准的 `for` 循环进行迭代。例如：

<?code-excerpt "misc/test/language_tour/control_flow_test.dart (for)"?>
```dart
var message = StringBuffer('Dart is fun');
for (var i = 0; i < 5; i++) {
  message.write('!');
}
```

Closures inside of Dart’s `for` loops capture the _value_ of the index,
avoiding a common pitfall found in JavaScript. For example, consider:

在 Dart 语言中，`for` 循环中的闭包会自动捕获循环的
**索引值** 以避免 JavaScript 中一些常见的陷阱。假设有如下代码：

<?code-excerpt "misc/test/language_tour/control_flow_test.dart (for-and-closures)"?>
```dart
var callbacks = [];
for (var i = 0; i < 2; i++) {
  callbacks.add(() => print(i));
}
callbacks.forEach((c) => c());
```

The output is `0` and then `1`, as expected. In contrast, the example
would print `2` and then `2` in JavaScript.

上述代码执行后会输出 `0` 和 `1`，但是如果在 JavaScript 中执行同样的代码则会输出两个 `2`。

If the object that you are iterating over is an Iterable, you can use the
[forEach()][] method. Using `forEach()` is a good option if you don’t need to
know the current iteration counter:

如果要遍历的对象实现了 Iterable 接口，则可以使用 [forEach()][] 方法，
如果不需要使用到索引，则使用 `forEach` 方法是一个非常好的选择：

<?code-excerpt "misc/lib/language_tour/control_flow.dart (forEach)"?>
```dart
candidates.forEach((candidate) => candidate.interview());
```

Iterable classes such as List and Set also support the `for-in` form of
[iteration](/guides/libraries/library-tour#iteration):

像 List 和 Set 等实现了 Iterable 接口的类
还支持 `for-in` 形式的 [迭代](/guides/libraries/library-tour#iteration)：

<?code-excerpt "misc/test/language_tour/control_flow_test.dart (collection)"?>
```dart
var collection = [1, 2, 3];
for (var x in collection) {
  print(x); // 1 2 3
}
```


### While and do-while

### While 和 Do-While

A `while` loop evaluates the condition before the loop:

`while` 循环会在执行循环体前先判断条件：

<?code-excerpt "misc/lib/language_tour/control_flow.dart (while)"?>
```dart
while (!isDone()) {
  doSomething();
}
```

A `do`-`while` loop evaluates the condition *after* the loop:

`do-while` 循环则会先执行一遍循环体 _再_ 判断条件：

<?code-excerpt "misc/lib/language_tour/control_flow.dart (do-while)"?>
```dart
do {
  printLine();
} while (!atEndOfPage());
```


### Break and continue

### Break 和 Continue

Use `break` to stop looping:

使用 `break` 可以中断循环：

<?code-excerpt "misc/lib/language_tour/control_flow.dart (while-break)"?>
```dart
while (true) {
  if (shutDownRequested()) break;
  processIncomingRequests();
}
```

Use `continue` to skip to the next loop iteration:

使用 `continue` 可以跳过本次循环直接进入下一次循环：

<?code-excerpt "misc/lib/language_tour/control_flow.dart (for-continue)"?>
```dart
for (int i = 0; i < candidates.length; i++) {
  var candidate = candidates[i];
  if (candidate.yearsExperience < 5) {
    continue;
  }
  candidate.interview();
}
```

You might write that example differently if you’re using an
[Iterable][] such as a list or set:

上述代码中的 candidates 如果像 List 或 Set
一样实现了 [Iterable][] 接口则可以简单地使用下述写法：

<?code-excerpt "misc/lib/language_tour/control_flow.dart (where)"?>
```dart
candidates
    .where((c) => c.yearsExperience >= 5)
    .forEach((c) => c.interview());
```


### Switch and case

### Switch 和 Case

Switch statements in Dart compare integer, string, or compile-time
constants using `==`. The compared objects must all be instances of the
same class (and not of any of its subtypes), and the class must not
override `==`.
[Enumerated types](#enumerated-types) work well in `switch` statements.

Switch 语句在 Dart 中使用 `==` 来比较整数、字符串或编译时常量，
比较的两个对象必须是同一个类型且不能是子类并且没有重写 `==` 操作符。
[枚举类型](#enumerated-types)非常适合在 `Switch` 语句中使用。

{{site.alert.note}}

  Switch statements in Dart are intended for limited circumstances,
  such as in interpreters or scanners.
  
  Dart 中的 Switch 语句仅适用于有限的情况，比如使用解释器和扫描器的场景。

{{site.alert.end}}

Each non-empty `case` clause ends with a `break` statement, as a rule.
Other valid ways to end a non-empty `case` clause are a `continue`,
`throw`, or `return` statement.

每一个非空的 `case` 子句都必须有一个 `break` 语句，
也可以通过 `continue`、`throw` 或者 `return` 来结束非空 `case` 语句。

Use a `default` clause to execute code when no `case` clause matches:

当没有 `case` 语句匹配时，可以使用 `default` 子句来匹配这种情况：

<?code-excerpt "misc/lib/language_tour/control_flow.dart (switch)"?>
```dart
var command = 'OPEN';
switch (command) {
  case 'CLOSED':
    executeClosed();
    break;
  case 'PENDING':
    executePending();
    break;
  case 'APPROVED':
    executeApproved();
    break;
  case 'DENIED':
    executeDenied();
    break;
  case 'OPEN':
    executeOpen();
    break;
  default:
    executeUnknown();
}
```

The following example omits the `break` statement in a `case` clause,
thus generating an error:

下面的例子忽略了 `case` 子句的 `break` 语句，因此会产生错误：

<?code-excerpt "misc/lib/language_tour/control_flow.dart (switch-break-omitted)" plaster="none"?>
```dart
var command = 'OPEN';
switch (command) {
  case 'OPEN':
    executeOpen();
    // 错误: 没有 break

  case 'CLOSED':
    executeClosed();
    break;
}
```

However, Dart does support empty `case` clauses, allowing a form of
fall-through:

但是，Dart 支持空的 `case` 语句，允许其以 fall-through 的形式执行。

<?code-excerpt "misc/lib/language_tour/control_flow.dart (switch-empty-case)"?>
```dart
var command = 'CLOSED';
switch (command) {
  case 'CLOSED': // case 语句为空时的 fall-through 形式。
  case 'NOW_CLOSED':
    // case 条件值为 CLOSED 和 NOW_CLOSED 时均会执行该语句。
    executeNowClosed();
    break;
}
```

If you really want fall-through, you can use a `continue` statement and
a label:

在非空 `case` 语句中想要实现 fall-through 的形式，
可以使用 `continue` 语句配合 lable 的方式实现:

<?code-excerpt "misc/lib/language_tour/control_flow.dart (switch-continue)"?>
```dart
var command = 'CLOSED';
switch (command) {
  case 'CLOSED':
    executeClosed();
    continue nowClosed;
  // 继续执行标签为 nowClosed 的 case 子句。

  nowClosed:
  case 'NOW_CLOSED':
    // case 条件值为 CLOSED 和 NOW_CLOSED 时均会执行该语句。
    executeNowClosed();
    break;
}
```

A `case` clause can have local variables, which are visible only inside
the scope of that clause.

每个 `case` 子句都可以有局部变量且仅在该 case 语句内可见。


### Assert

### 断言

During development, use an assert statement
— <code>assert(<em>condition</em>, <em>optionalMessage</em>)</code>; —
to disrupt normal execution if a boolean
condition is false. You can find examples of assert statements
throughout this tour. Here are some more:

在开发过程中，可以在条件表达式为 false 时
使用 - <code>assert(<em>条件</em>, <em>可选信息</em>)</code>; - 语句
来打断代码的执行。你可以在本文中找到大量使用 assert 的例子。
下面是相关示例：

<?code-excerpt "misc/test/language_tour/control_flow_test.dart (assert)"?>
```dart
// 确保变量值不为 null (Make sure the variable has a non-null value)
assert(text != null);

// 确保变量值小于 100。
assert(number < 100);

// 确保这是一个 https 地址。
assert(urlString.startsWith('https'));
```

To attach a message to an assertion,
add a string as the second argument to `assert`.

`assert` 的第二个参数可以为其添加一个字符串消息。

<?code-excerpt "misc/test/language_tour/control_flow_test.dart (assert-with-message)"?>
```dart
assert(urlString.startsWith('https'),
    'URL ($urlString) should start with "https".');
```

The first argument to `assert` can be any expression that
resolves to a boolean value. If the expression’s value
is true, the assertion succeeds and execution
continues. If it's false, the assertion fails and an exception (an
[AssertionError][]) is thrown.

`assert` 的第一个参数可以是值为布尔值的任何表达式。
如果表达式的值为 true，则断言成功，继续执行。
如果表达式的值为 false，则断言失败，抛出一个 [AssertionError][] 异常。

When exactly do assertions work?
That depends on the tools and framework you're using:

如何判断 assert 是否生效？assert 是否生效依赖开发工具和使用的框架：

* Flutter enables assertions in [debug mode.][Flutter debug mode]

  Flutter 在[调试模式][Flutter debug mode]时生效。

* Development-only tools such as [dartdevc][]
  typically enable assertions by default.

  一些开发工具比如 [dartdevc][] 通常情况下是默认生效的。

* Some tools, such as [dart][] and [dart2js,][dart2js]
  support assertions through a command-line flag: `--enable-asserts`.

  其他一些工具，比如 [dart][] 以及 [dart2js][dart2js] 
  通过在运行 Dart 程序时添加命令行参数 `--enable-asserts` 使 assert 生效。

In production code, assertions are ignored, and
the arguments to `assert` aren't evaluated.

在生产环境代码中，断言会被忽略，
与此同时传入 `assert` 的参数不被判断。


## Exceptions

## 异常

Your Dart code can throw and catch exceptions. Exceptions are errors
indicating that something unexpected happened. If the exception isn’t
caught, the [isolate](#isolates) that raised the exception is suspended, and
typically the isolate and its program are terminated.

Dart 代码可以抛出和捕获异常。异常表示一些未知的错误情况，
如果异常没有捕获则会被抛出从而导致抛出异常的代码终止执行。

In contrast to Java, all of Dart’s exceptions are unchecked exceptions.
Methods do not declare which exceptions they might throw, and you are
not required to catch any exceptions.

与 Java 不同的是，Dart 的所有异常都是非必检异常，
方法不一定会声明其所抛出的异常并且你也不会被要求捕获任何异常。

Dart provides [Exception][] and [Error][]
types, as well as numerous predefined subtypes. You can, of course,
define your own exceptions. However, Dart programs can throw any
non-null object—not just Exception and Error objects—as an exception.

Dart 提供了 [Exception][] 和 [Error][] 两种类型的异常以及它们一系列的子类，
你也可以定义自己的异常类型。
但是在 Dart 中可以将任何非 null 对象作为异常抛出
而不局限于 Exception 或 Error 类型。

### Throw

### 抛出异常

Here’s an example of throwing, or *raising*, an exception:

下面是关于抛出或者 *引发* 异常的示例：

<?code-excerpt "misc/lib/language_tour/exceptions.dart (throw-FormatException)"?>
```dart
throw FormatException('Expected at least 1 section');
```

You can also throw arbitrary objects:

你也可以抛出任意的对象：

<?code-excerpt "misc/lib/language_tour/exceptions.dart (out-of-llamas)"?>
```dart
throw 'Out of llamas!';
```

{{site.alert.note}}

  Production-quality code usually throws types that implement [Error][] or
  [Exception][].
  
  优秀的代码通常会抛出 [Error][] 或 [Exception][] 类型的异常。

{{site.alert.end}}

Because throwing an exception is an expression, you can throw exceptions
in =\> statements, as well as anywhere else that allows expressions:

因为抛出异常是一个表达式，所以可以在 =\> 语句中使用，
也可以在其他使用表达式的地方抛出异常：

<?code-excerpt "misc/lib/language_tour/exceptions.dart (throw-is-an-expression)"?>
```dart
void distanceTo(Point other) => throw UnimplementedError();
```


### Catch

### 捕获异常

Catching, or capturing, an exception stops the exception from
propagating (unless you rethrow the exception).
Catching an exception gives you a chance to handle it:

捕获异常可以避免异常继续传递（重新抛出异常除外）。
捕获一个异常可以给你处理它的机会：

<?code-excerpt "misc/lib/language_tour/exceptions.dart (try)"?>
```dart
try {
  breedMoreLlamas();
} on OutOfLlamasException {
  buyMoreLlamas();
}
```

To handle code that can throw more than one type of exception, you can
specify multiple catch clauses. The first catch clause that matches the
thrown object’s type handles the exception. If the catch clause does not
specify a type, that clause can handle any type of thrown object:

对于可以抛出多种异常类型的代码，也可以指定多个 catch 语句，
每个语句分别对应一个异常类型，
如果 catch 语句没有指定异常类型则表示可以捕获任意异常类型：

<?code-excerpt "misc/lib/language_tour/exceptions.dart (try-catch)"?>
```dart
try {
  breedMoreLlamas();
} on OutOfLlamasException {
  // 指定异常
  buyMoreLlamas();
} on Exception catch (e) {
  // 其它类型的异常
  print('Unknown exception: $e');
} catch (e) {
  // // 不指定类型，处理其它全部
  print('Something really unknown: $e');
}
```

As the preceding code shows, you can use either `on` or `catch` or both.
Use `on` when you need to specify the exception type. Use `catch` when
your exception handler needs the exception object.

如上述代码所示可以使用 `on` 或 `catch` 来捕获异常，
使用 `on` 来指定异常类型，使用 `catch` 来捕获异常对象，
两者可同时使用。

You can specify one or two parameters to `catch()`.
The first is the exception that was thrown,
and the second is the stack trace (a [StackTrace][] object).

你可以为 `catch` 方法指定两个参数，
第一个参数为抛出的异常对象，
第二个参数为栈信息 [StackTrace][] 对象：

<?code-excerpt "misc/lib/language_tour/exceptions.dart (try-catch-2)" replace="/\(e.*?\)/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
try {
  // ···
} on Exception catch [!(e)!] {
  print('Exception details:\n $e');
} catch [!(e, s)!] {
  print('Exception details:\n $e');
  print('Stack trace:\n $s');
}
{% endprettify %}

To partially handle an exception,
while allowing it to propagate,
use the `rethrow` keyword.

关键字 `rethrow` 可以将捕获的异常再次抛出：

<?code-excerpt "misc/test/language_tour/exceptions_test.dart (rethrow)" replace="/rethrow;/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
void misbehave() {
  try {
    dynamic foo = true;
    print(foo++); // 运行时错误
  } catch (e) {
    print('misbehave() partially handled ${e.runtimeType}.');
    [!rethrow;!] // 允许调用者查看异常。
  }
}

void main() {
  try {
    misbehave();
  } catch (e) {
    print('main() finished handling ${e.runtimeType}.');
  }
}
{% endprettify %}


### Finally

To ensure that some code runs whether or not an exception is thrown, use
a `finally` clause. If no `catch` clause matches the exception, the
exception is propagated after the `finally` clause runs:

可以使用 `finally` 语句来包裹确保不管有没有异常都执行代码，
如果没有指定 `catch` 语句来捕获异常，则在执行完 `finally` 语句后再抛出异常：

<?code-excerpt "misc/lib/language_tour/exceptions.dart (finally)"?>
```dart
try {
  breedMoreLlamas();
} finally {
  // 总是清理，即便抛出了异常。
  cleanLlamaStalls();
}
```

The `finally` clause runs after any matching `catch` clauses:

`finally` 语句会在任何匹配的 `catch` 语句后执行：

<?code-excerpt "misc/lib/language_tour/exceptions.dart (try-catch-finally)"?>
```dart
try {
  breedMoreLlamas();
} catch (e) {
  print('Error: $e'); // 先处理异常。
} finally {
  cleanLlamaStalls(); // 然后清理。
}
```

Learn more by reading the
[Exceptions](/guides/libraries/library-tour#exceptions)
section of the library tour.

更多详情，请参考
你可以阅读 Dart 核心库概览的
[异常](/guides/libraries/library-tour#exceptions) 章节获取更多相关信息。

## Classes

## 类

Dart is an object-oriented language with classes and mixin-based
inheritance. Every object is an instance of a class, and all classes
descend from [Object.][Object]
*Mixin-based inheritance* means that although every class (except for
Object) has exactly one superclass, a class body can be reused in
multiple class hierarchies.
[Extension methods](#extension-methods) are a way to
add functionality to a class without changing the class or creating a subclass.

Dart 是支持基于 mixin 继承机制的面向对象语言，所有对象都是一个类的实例，
而所有的类都继承自 [Object][Object] 类。
基于 *mixin 的继承* 意味着每个除 Object 类之外的类都只有一个超类，
一个类的代码可以在其它多个类继承中重复使用。
[Extension 方法](#extension-methods) 是一种在不更改类
或创建子类的情况下向类添加功能的方式。

### Using class members

### 使用类的成员

Objects have *members* consisting of functions and data (*methods* and
*instance variables*, respectively). When you call a method, you *invoke*
it on an object: the method has access to that object’s functions and
data.

对象的 *成员* 由函数和数据（即 *方法* 和 *实例变量*）组成。
方法的 *调用* 要通过对象来完成，
这种方式可以访问对象的函数和数据。

Use a dot (`.`) to refer to an instance variable or method:

使用（`.`）来访问对象的实例变量或方法：

<?code-excerpt "misc/test/language_tour/classes_test.dart (object-members)"?>
```dart
var p = Point(2, 2);

// 为实例变量 y 赋值。
p.y = 3;

// 获取 y 的值。
assert(p.y == 3);

// 调用变量 p 的 distanceTo() 方法。
double distance = p.distanceTo(Point(4, 4));
```

Use `?.` instead of `.` to avoid an exception
when the leftmost operand is null:

使用 `?.` 代替 `.` 可以避免因为左边表达式为 null 而导致的问题：

{% comment %}
{{site.dartpad}}/0cb25997742ed5382e4a
https://gist.github.com/0cb25997742ed5382e4a
{% endcomment %}

<?code-excerpt "misc/test/language_tour/classes_test.dart (safe-member-access)"?>
```dart
// If p is non-null, set its y value to 4.
// 如果 p 为非空则将其属性 y 的值设为 4
p?.y = 4;
```


### Using constructors

### 使用构造函数

You can create an object using a *constructor*.
Constructor names can be either <code><em>ClassName</em></code> or
<code><em>ClassName</em>.<em>identifier</em></code>. For example,
the following code creates `Point` objects using the
`Point()` and `Point.fromJson()` constructors:

可以使用 *构造函数* 来创建一个对象。
构造函数的命名方式可以为
<code><em>类名</em></code> 或 <code><em> 类名
</em>.<em> 标识符 </em></code> 的形式。
例如下述代码分别使用 `Point()` 和 `Point.fromJson()` 
两种构造器创建了 `Point` 对象：

<?code-excerpt "misc/test/language_tour/classes_test.dart (object-creation)" replace="/ as .*?;/;/g"?>
```dart
var p1 = Point(2, 2);
var p2 = Point.fromJson({'x': 1, 'y': 2});
```

The following code has the same effect, but
uses the optional `new` keyword before the constructor name:

以下代码具有相同的效果，
但是构造函数名前面的的 `new` 关键字是可选的：

<?code-excerpt "misc/test/language_tour/classes_test.dart (object-creation-new)" replace="/ as .*?;/;/g"?>
```dart
var p1 = new Point(2, 2);
var p2 = new Point.fromJson({'x': 1, 'y': 2});
```

{{site.alert.version-note}}

  The `new` keyword became optional in Dart 2.
  
  从 Dart 2 开始，`new` 关键字是可选的。

{{site.alert.end}}

Some classes provide [constant constructors](#constant-constructors).
To create a compile-time constant using a constant constructor,
put the `const` keyword before the constructor name:

一些类提供了[常量构造函数](#constant-constructors)。使用常量构造函数，
在构造函数名之前加 `const` 关键字，来创建编译时常量时：

<?code-excerpt "misc/test/language_tour/classes_test.dart (const)"?>
```dart
var p = const ImmutablePoint(2, 2);
```

Constructing two identical compile-time constants results in a single,
canonical instance:

两个使用相同构造函数相同参数值构造的编译时常量是同一个对象：

<?code-excerpt "misc/test/language_tour/classes_test.dart (identical)"?>
```dart
var a = const ImmutablePoint(1, 1);
var b = const ImmutablePoint(1, 1);

assert(identical(a, b)); // 它们是同一个实例 (They are the same instance!)
```

Within a _constant context_, you can omit the `const` before a constructor
or literal. For example, look at this code, which creates a const map:

根据使用 _常量上下文_ 的场景，
你可以省略掉构造函数或字面量前的 `const` 关键字。
例如下面的例子中我们创建了一个常量 Map：

<?code-excerpt "misc/test/language_tour/classes_test.dart (const-context-withconst)" replace="/pointAndLine1/pointAndLine/g"?>
```dart
// Lots of const keywords here.
// 这里有很多 const 关键字
const pointAndLine = const {
  'point': const [const ImmutablePoint(0, 0)],
  'line': const [const ImmutablePoint(1, 10), const ImmutablePoint(-2, 11)],
};
```

You can omit all but the first use of the `const` keyword:

根据上下文，你可以只保留第一个 `const` 关键字，
其余的全部省略：

<?code-excerpt "misc/test/language_tour/classes_test.dart (const-context-noconst)" replace="/pointAndLine2/pointAndLine/g"?>
```dart
// Only one const, which establishes the constant context.
// 只需要一个 const 关键字，其它的则会隐式地根据上下文进行关联。
const pointAndLine = {
  'point': [ImmutablePoint(0, 0)],
  'line': [ImmutablePoint(1, 10), ImmutablePoint(-2, 11)],
};
```

If a constant constructor is outside of a constant context
and is invoked without `const`,
it creates a **non-constant object**:

但是如果无法根据上下文判断是否可以省略 `cosnt`，
则不能省略掉 `const` 关键字，否则将会创建一个 **非常量对象** 例如：

<?code-excerpt "misc/test/language_tour/classes_test.dart (nonconst-const-constructor)"?>
```dart
var a = const ImmutablePoint(1, 1); // 创建一个常量 (Creates a constant)
var b = ImmutablePoint(1, 1); // 不会创建一个常量 (Does NOT create a constant)

assert(!identical(a, b)); // 这两变量并不相同 (NOT the same instance!)
```

{{site.alert.version-note}}

  The `const` keyword became optional within a constant context in Dart 2.
  
  只有从 Dart 2 开始才能根据上下文判断省略 `const` 关键字。

{{site.alert.end}}


### Getting an object's type

### 获取对象的类型

To get an object's type at runtime,
you can use Object's `runtimeType` property,
which returns a [Type][] object.

可以使用 Object 对象的 `runtimeType` 属性在运行时获取一个对象的类型，该对象类型是 [Type][] 的实例。

<?code-excerpt "misc/test/language_tour/classes_test.dart (runtimeType)"?>
```dart
print('The type of a is ${a.runtimeType}');
```

Up to here, you've seen how to _use_ classes.
The rest of this section shows how to _implement_ classes.

到目前为止，我们已经解了如何 _使用_ 类。本节的其余部分将向你介绍如何 _实现_ 一个类。

### Instance variables

### 实例变量

Here’s how you declare instance variables:

下面是声明实例变量的示例：

<?code-excerpt "misc/lib/language_tour/classes/point_with_main.dart (class)"?>
```dart
class Point {
  double x; // 声明 double 变量 x 并初始化为 null。
  double y; // 声明 double 变量 y 并初始化为 null
  double z = 0; // 声明 double 变量 z 并初始化为 0。
}
```

All uninitialized instance variables have the value `null`.

所有未初始化的实例变量其值均为 `null`。

All instance variables generate an implicit *getter* method. Non-final
instance variables also generate an implicit *setter* method. For details,
see [Getters and setters](#getters-and-setters).

所有实例变量均会隐式地声明一个 *Getter* 方法，
非 final 类型的实例变量还会隐式地声明一个 *Setter* 方法。
你可以查阅 [Getter 和 Setter](#getters-and-setters) 获取更多相关信息。

<?code-excerpt "misc/lib/language_tour/classes/point_with_main.dart (class+main)" replace="/(double .*?;).*/$1/g" plaster="none"?>
```dart
class Point {
  double x;
  double y;
}

void main() {
  var point = Point();
  point.x = 4; // 使用 x 的 Setter 方法。
  assert(point.x == 4); // 使用 x 的 Getter 方法。
  assert(point.y == null); // 默认值为 null。
}
```

If you initialize an instance variable where it is declared (instead of
in a constructor or method), the value is set when the instance is
created, which is before the constructor and its initializer list
execute.

如果你在声明一个实例变量的时候就将其初始化（而不是在构造函数或其它方法中），
那么该实例变量的值就会在对象实例创建的时候被设置，
该过程会在构造函数以及它的初始化器列表执行前。


### Constructors

### 构造函数

Declare a constructor by creating a function with the same name as its
class (plus, optionally, an additional identifier as described in
[Named constructors](#named-constructors)).
The most common form of constructor, the generative constructor, creates
a new instance of a class:

声明一个与类名一样的函数即可声明一个构造函数
（对于[命名式构造函数](#named-constructors) 还可以添加额外的标识符）。
大部分的构造函数形式是生成式构造函数，其用于创建一个类的实例：

<?code-excerpt "misc/lib/language_tour/classes/point_alt.dart (constructor-long-way)" plaster="none"?>
```dart
class Point {
  double x, y;

  Point(double x, double y) {
    // 还会有更好的方式来实现此逻辑，敬请期待。
    this.x = x;
    this.y = y;
  }
}
```

The `this` keyword refers to the current instance.

使用 `this` 关键字引用当前实例。

{{site.alert.note}}

  Use `this` only when there is a name conflict. Otherwise, Dart style
  omits the `this`.
  
  当且仅当命名冲突时使用 `this` 关键字才有意义，否则 Dart 会忽略 `this` 关键字。

{{site.alert.end}}

The pattern of assigning a constructor argument to an instance variable
is so common, Dart has syntactic sugar to make it easy:

对于大多数编程语言来说在构造函数中为实例变量赋值的过程都是类似的，而 Dart 则提供了一种特殊的语法糖来简化该步骤：

<?code-excerpt "misc/lib/language_tour/classes/point.dart (constructor-initializer)" plaster="none"?>
```dart
class Point {
  double x, y;

  // 在构造函数体执行前用于设置 x 和 y 的语法糖。
  Point(this.x, this.y);
}
```

#### Default constructors

#### 默认构造函数

If you don’t declare a constructor, a default constructor is provided
for you. The default constructor has no arguments and invokes the
no-argument constructor in the superclass.

如果你没有声明构造函数，那么 Dart 会自动生成一个无参数的构造函数并且该构造函数会调用其父类的无参数构造方法。

#### Constructors aren’t inherited

#### 构造函数不被继承

Subclasses don’t inherit constructors from their superclass. A subclass
that declares no constructors has only the default (no argument, no
name) constructor.

子类不会继承父类的构造函数，如果子类没有声明构造函数，那么只会有一个默认无参数的构造函数。

#### Named constructors

#### 命名式构造函数

Use a named constructor to implement multiple constructors for a class
or to provide extra clarity:

可以为一个类声明多个命名式构造函数来表达更明确的意图：

<?code-excerpt "misc/lib/language_tour/classes/point.dart (named-constructor)" replace="/Point\.\S*/[!$&!]/g" plaster="none"?>
{% prettify dart tag=pre+code %}
class Point {
  double x, y;

  Point(this.x, this.y);

  // 命名式构造函数
  [!Point.origin()!] {
    x = 0;
    y = 0;
  }
}
{% endprettify %}

Remember that constructors are not inherited, which means that a
superclass’s named constructor is not inherited by a subclass. If you
want a subclass to be created with a named constructor defined in the
superclass, you must implement that constructor in the subclass.

记住构造函数是不能被继承的，这将意味着子类不能继承父类的命名式构造函数，
如果你想在子类中提供一个与父类命名构造函数名字一样的命名构造函数，
则需要在子类中显式地声明。

#### Invoking a non-default superclass constructor

#### 调用父类非默认构造函数

By default, a constructor in a subclass calls the superclass’s unnamed,
no-argument constructor.
The superclass's constructor is called at the beginning of the
constructor body. If an [initializer list](#initializer-list)
is also being used, it executes before the superclass is called.
In summary, the order of execution is as follows:

默认情况下，子类的构造函数会调用父类的匿名无参数构造方法，
并且该调用会在子类构造函数的函数体代码执行前，
如果子类构造函数还有一个 [初始化列表](#initializer-list)，
那么该初始化列表会在调用父类的该构造函数之前被执行，
总的来说，这三者的调用顺序如下：

1. initializer list

   初始化列表

1. superclass's no-arg constructor

   父类的无参数构造函数

1. main class's no-arg constructor

   当前类的构造函数

If the superclass doesn’t have an unnamed, no-argument constructor,
then you must manually call one of the constructors in the
superclass. Specify the superclass constructor after a colon (`:`), just
before the constructor body (if any).

如果父类没有匿名无参数构造函数，那么子类必须调用父类的其中一个构造函数，
为子类的构造函数指定一个父类的构造函数只需在构造函数体前使用（`:`）指定。

In the following example, the constructor for the Employee class calls the named
constructor for its superclass, Person. Click **Run** to execute the code.

下面的示例中，Employee 类的构造函数调用了父类 Person 的命名构造函数。
点击运行按钮执行示例代码。

{% comment %}
https://gist.github.com/Sfshaza/e57aa06401e6618d4eb8
{{site.dartpad}}/e57aa06401e6618d4eb8

<?code-excerpt "misc/lib/language_tour/classes/employee.dart" plaster="none"?>
```dart
class Person {
  String firstName;

  Person.fromJson(Map data) {
    print('在 Person 对象中');
  }
}

class Employee extends Person {
  // Person没有默认的构造函数，你必须调用 super.fromJson(data)。
  Employee.fromJson(Map data) : super.fromJson(data) {
    print('在 Employee 对象中');
  }
}

void main() {
  var emp = Employee.fromJson({});
  // 打印输出:
  // 在 Person 对象中
  // 在 Employee 对象中

  if (emp is Person) {
    // 类型检查
    emp.firstName = 'Bob';
  }
  (emp as Person).firstName = 'Bob';
}
```
{% endcomment %}

<iframe
src="{{site.dartpad-embed-inline}}?id=e57aa06401e6618d4eb8&split=90&ga_id=non_default_superclass_constructor"
    width="100%"
    height="500px"
    style="border: 1px solid #ccc;">
</iframe>

Because the arguments to the superclass constructor are evaluated before
invoking the constructor, an argument can be an expression such as a
function call:

因为参数会在子类构造函数被执行前传递给父类的构造函数，
因此该参数也可以是一个表达式，比如一个函数：

<?code-excerpt "misc/lib/language_tour/classes/employee.dart (method-then-constructor)"?>
```dart
class Employee extends Person {
  Employee() : super.fromJson(defaultData);
  // ···
}
```

{{site.alert.warning}}

  Arguments to the superclass constructor do not have access to `this`. For
  example, arguments can call static methods but not instance methods.
  
  传递给父类构造函数的参数不能使用 `this` 关键字，
  因为在参数传递的这一步骤，子类构造函数尚未执行，
  子类的实例对象也就还未初始化，
  因此所有的实例成员都不能被访问，但是类成员可以。

{{site.alert.end}}

#### Initializer list

#### 初始化列表

Besides invoking a superclass constructor, you can also initialize
instance variables before the constructor body runs. Separate
initializers with commas.

除了调用父类构造函数之外，还可以在构造函数体执行之前初始化实例变量。
每个实例变量之间使用逗号分隔。

<?code-excerpt "misc/lib/language_tour/classes/point_alt.dart (initializer-list)"?>
```dart
// Initializer list sets instance variables before
// the constructor body runs.
// 使用初始化列表在构造函数体执行前设置实例变量。
Point.fromJson(Map<String, double> json)
    : x = json['x'],
      y = json['y'] {
  print('In Point.fromJson(): ($x, $y)');
}
```

{{site.alert.warning}}

  The right-hand side of an initializer does not have access to `this`.

  初始化列表表达式 = 右边的语句不能使用 `this` 关键字。

{{site.alert.end}}

During development, you can validate inputs by using `assert` in the
initializer list.

在开发模式下，你可以在初始化列表中使用 `assert` 来验证输入数据：

<?code-excerpt "misc/lib/language_tour/classes/point_alt.dart (initializer-list-with-assert)" replace="/assert\(.*?\)/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
Point.withAssert(this.x, this.y) : [!assert(x >= 0)!] {
  print('In Point.withAssert(): ($x, $y)');
}
{% endprettify %}

{% comment %}
[PENDING: the example could be better.
Note that DartPad doesn't support this yet?

https://github.com/dart-lang/sdk/issues/30968
https://github.com/dart-lang/sdk/blob/master/docs/language/informal/assert-in-initializer-list.md]
{% endcomment %}

Initializer lists are handy when setting up final fields. The following example
initializes three final fields in an initializer list. Click **Run** to execute
the code.

初始化列表用来设置 `final` 字段是非常好用的，
下面的示例中就使用初始化列表来设置了三个 `final` 变量的值。
点击运行按钮执行示例代码。

{% comment %}
https://gist.github.com/Sfshaza/7a9764702c0608711e08
{{site.dartpad}}/a9764702c0608711e08

<?code-excerpt "misc/lib/language_tour/classes/point_with_distance_field.dart"?>
```dart
import 'dart:math';

class Point {
  final double x;
  final double y;
  final double distanceFromOrigin;

  Point(double x, double y)
      : x = x,
        y = y,
        distanceFromOrigin = sqrt(x * x + y * y);
}

void main() {
  var p = Point(2, 3);
  print(p.distanceFromOrigin);
}
```
{% endcomment %}

<iframe
src="{{site.dartpad-embed-inline}}?id=7a9764702c0608711e08&split=90&ga_id=initializer_list"
    width="100%"
    height="420px"
    style="border: 1px solid #ccc;">
</iframe>


#### Redirecting constructors

#### 重定向构造函数

Sometimes a constructor’s only purpose is to redirect to another
constructor in the same class. A redirecting constructor’s body is
empty, with the constructor call appearing after a colon (:).

有时候类中的构造函数会调用类中其它的构造函数，
该重定向构造函数没有函数体，
只需在函数签名后使用（:）指定需要重定向到的其它构造函数即可：

<?code-excerpt "misc/lib/language_tour/classes/point_redirecting.dart"?>
```dart
class Point {
  double x, y;

  // 该类的主构造函数。
  Point(this.x, this.y);

  // 委托实现给主构造函数。
  Point.alongXAxis(double x) : this(x, 0);
}
```

#### Constant constructors

#### 常量构造函数

If your class produces objects that never change, you can make these
objects compile-time constants. To do this, define a `const` constructor
and make sure that all instance variables are `final`.

如果类生成的对象都是不会变的，那么可以在生成这些对象时就将其变为编译时常量。
你可以在类的构造函数前加上 `const` 关键字
并确保所有实例变量均为 `final` 来实现该功能。

<?code-excerpt "misc/lib/language_tour/classes/immutable_point.dart"?>
```dart
class ImmutablePoint {
  static final ImmutablePoint origin =
      const ImmutablePoint(0, 0);

  final double x, y;

  const ImmutablePoint(this.x, this.y);
}
```

Constant constructors don't always create constants.
For details, see the section on
[using constructors](#using-constructors).

常量构造函数创建的实例并不总是常量，
具体可以参考[使用构造函数](#using-constructors)章节。


#### Factory constructors

#### 工厂构造函数

Use the `factory` keyword when implementing a constructor that doesn’t
always create a new instance of its class. For example, a factory
constructor might return an instance from a cache, or it might
return an instance of a subtype.
Another use case for factory constructors is
initializing a final variable using
logic that can't be handled in the initializer list. 

使用 `factory` 关键字标识类的构造函数将会令该构造函数变为工厂构造函数，
这将意味着使用该构造函数构造类的实例时并非总是会返回新的实例对象。
例如，工厂构造函数可能会从缓存中返回一个实例，或者返回一个子类型的实例。

In the following example,
the `Logger` factory constructor returns objects from a cache,
and the `Logger.fromJson` factory constructor
initializes a final variable from a JSON object.

在如下的示例中，
`Logger` 的工厂构造函数从缓存中返回对象，
和 `Logger.fromJson` 工厂构造函数从 JSON 对象中
初始化一个最终变量。

<?code-excerpt "misc/lib/language_tour/classes/logger.dart"?>
```dart
class Logger {
  final String name;
  bool mute = false;

  // _cache 变量是库私有的，因为在其名字前面有下划线。
  static final Map<String, Logger> _cache =
      <String, Logger>{};

  factory Logger(String name) {
    return _cache.putIfAbsent(
        name, () => Logger._internal(name));
  }

  factory Logger.fromJson(Map<String, Object> json) {
    return Logger(json['name'].toString());
  }

  Logger._internal(this.name);

  void log(String msg) {
    if (!mute) print(msg);
  }
}
```

{{site.alert.note}}

  Factory constructors have no access to `this`.
  
  在工厂构造函数中无法访问 `this`。

{{site.alert.end}}

Invoke a factory constructor just like you would any other constructor:

工厂构造函的调用方式与其他构造函数一样：

<?code-excerpt "misc/lib/language_tour/classes/logger.dart (logger)"?>
```dart
var logger = Logger('UI');
logger.log('Button clicked');

var logMap = {'name': 'UI'};
var loggerJson = Logger.fromJson(logMap);
```


### Methods

### 方法

Methods are functions that provide behavior for an object.

方法是对象提供行为的函数。

#### Instance methods

#### 实例方法

Instance methods on objects can access instance variables and `this`.
The `distanceTo()` method in the following sample is an example of an
instance method:

对象的实例方法可以访问实例变量和 `this`。下面的 `distanceTo()` 方法就是一个实例方法的例子：


<?code-excerpt "misc/lib/language_tour/classes/point.dart (class-with-distanceTo)" plaster="none"?>
```dart
import 'dart:math';

class Point {
  double x, y;

  Point(this.x, this.y);

  double distanceTo(Point other) {
    var dx = x - other.x;
    var dy = y - other.y;
    return sqrt(dx * dx + dy * dy);
  }
}
```

#### Getters and setters

#### Getter 和 Setter

Getters and setters are special methods that provide read and write
access to an object’s properties. Recall that each instance variable has
an implicit getter, plus a setter if appropriate. You can create
additional properties by implementing getters and setters, using the
`get` and `set` keywords:

Getter 和 Setter 是一对用来读写对象属性的特殊方法，
上面说过实例对象的每一个属性都有一个隐式的 Getter 方法，
如果为非 final 属性的话还会有一个 Setter 方法，
你可以使用 `get` 和 `set` 关键字为额外的属性添加 Getter 和 Setter 方法：

<?code-excerpt "misc/lib/language_tour/classes/rectangle.dart"?>
```dart
class Rectangle {
  double left, top, width, height;

  Rectangle(this.left, this.top, this.width, this.height);

  // 定义两个计算产生的属性：right 和 bottom。
  double get right => left + width;
  set right(double value) => left = value - width;
  double get bottom => top + height;
  set bottom(double value) => top = value - height;
}

void main() {
  var rect = Rectangle(3, 4, 20, 15);
  assert(rect.left == 3);
  rect.right = 12;
  assert(rect.left == -8);
}
```

With getters and setters, you can start with instance variables, later
wrapping them with methods, all without changing client code.

使用 Getter 和 Setter 的好处是，你可以先使用你的实例变量，
过一段时间过再将它们包裹成方法且不需要改动任何代码，
即先定义后更改且不影响原有逻辑。

{{site.alert.note}}

  Operators such as increment (++) work in the expected way, whether or
  not a getter is explicitly defined. To avoid any unexpected side
  effects, the operator calls the getter exactly once, saving its value
  in a temporary variable.
  
  像自增（++）这样的操作符不管是否定义了 Getter 方法都会正确地执行。
  为了避免一些不必要的异常情况，
  运算符只会调用 Getter 一次，然后将其值存储在一个临时变量中。

{{site.alert.end}}

#### Abstract methods

#### 抽象方法

Instance, getter, and setter methods can be abstract, defining an
interface but leaving its implementation up to other classes.
Abstract methods can only exist in [abstract classes](#abstract-classes).

实例方法、Getter 方法以及 Setter 方法都可以是抽象的，
定义一个接口方法而不去做具体的实现让实现它的类去实现该方法，
抽象方法只能存在于 [抽象类](#abstract-classes)中。

To make a method abstract, use a semicolon (;) instead of a method body:

直接使用分号（;）替代方法体即可声明一个抽象方法：

<?code-excerpt "misc/lib/language_tour/classes/doer.dart"?>
```dart
abstract class Doer {
  // 定义实例变量和方法等等……

  void doSomething(); // 定义一个抽象方法。
}

class EffectiveDoer extends Doer {
  void doSomething() {
    // 提供一个实现，所以在这里该方法不再是抽象的……
  }
}
```


### Abstract classes

### 抽象类

Use the `abstract` modifier to define an *abstract class*—a class that
can’t be instantiated. Abstract classes are useful for defining
interfaces, often with some implementation. If you want your abstract
class to appear to be instantiable, define a [factory
constructor](#factory-constructors).

使用关键字 `abstract` 标识类可以让该类成为 *抽象类*，抽象类将无法被实例化。
抽象类常用于声明接口方法、有时也会有具体的方法实现。
如果想让抽象类同时可被实例化，可以为其定义 [工厂构造函数](#工厂构造函数)。

Abstract classes often have [abstract methods](#abstract-methods).
Here’s an example of declaring an abstract class that has an abstract
method:

抽象类常常会包含 [抽象方法](#abstract-methods)。
下面是一个声明具有抽象方法的抽象类示例：

<?code-excerpt "misc/lib/language_tour/classes/misc.dart (abstract)"?>
```dart
// This class is declared abstract and thus
// can't be instantiated.
// 该类被声明为抽象的，因此它不能被实例化。
abstract class AbstractContainer {
  // 定义构造函数、字段、方法等……

  void updateChildren(); // 抽象方法。
}
```


### Implicit interfaces

### 隐式接口

Every class implicitly defines an interface containing all the instance
members of the class and of any interfaces it implements. If you want to
create a class A that supports class B’s API without inheriting B’s
implementation, class A should implement the B interface.

每一个类都隐式地定义了一个接口并实现了该接口，
这个接口包含所有这个类的实例成员以及这个类所实现的其它接口。
如果想要创建一个 A 类支持调用 B 类的 API 且不想继承 B 类，
则可以实现 B 类的接口。

A class implements one or more interfaces by declaring them in an
`implements` clause and then providing the APIs required by the
interfaces. For example:

一个类可以通过关键字 `implements` 来实现一个或多个接口
并实现每个接口定义的 API：

<?code-excerpt "misc/lib/language_tour/classes/impostor.dart"?>
```dart
// A person. The implicit interface contains greet().
// Person 类的隐式接口中包含 greet() 方法。
class Person {
  // _name 变量同样包含在接口中，但它只是库内可见的。
  final _name;

  // 构造函数不在接口中。
  Person(this._name);

  // greet() 方法在接口中。
  String greet(String who) => '你好，$who。我是$_name。';
}

// Person 接口的一个实现。
class Impostor implements Person {
  get _name => '';

  String greet(String who) => '你好$who。你知道我是谁吗？';
}

String greetBob(Person person) => person.greet('小芳');

void main() {
  print(greetBob(Person('小芸')));
  print(greetBob(Impostor()));
}
```

Here’s an example of specifying that a class implements multiple
interfaces:

如果需要实现多个类接口，可以使用逗号分割每个接口类：

<?code-excerpt "misc/lib/language_tour/classes/misc.dart (point_interfaces)"?>
```dart
class Point implements Comparable, Location {...}
```


### Extending a class

### 扩展一个类

Use `extends` to create a subclass, and `super` to refer to the
superclass:

使用 `extends` 关键字来创建一个子类，
并可使用 `super` 关键字引用一个父类：

<?code-excerpt "misc/lib/language_tour/classes/extends.dart" replace="/extends|super/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
class Television {
  void turnOn() {
    _illuminateDisplay();
    _activateIrSensor();
  }
  // ···
}

class SmartTelevision [!extends!] Television {
  void turnOn() {
    [!super!].turnOn();
    _bootNetworkInterface();
    _initializeMemory();
    _upgradeApps();
  }
  // ···
}
{% endprettify %}




#### Overriding members

#### 重写类成员

Subclasses can override instance methods, getters, and setters.
You can use the `@override` annotation to indicate that you are
intentionally overriding a member:

子类可以重写父类的实例方法、Getter 以及 Setter 方法。
你可以使用 `@override` 注解来表示你重写了一个成员：

<?code-excerpt "misc/lib/language_tour/metadata/television.dart (override)" replace="/@override/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
class SmartTelevision extends Television {
  [!@override!]
  void turnOn() {...}
  // ···
}
{% endprettify %}

To narrow the type of a method parameter or instance variable in code that is
[type safe](/guides/language/type-system),
you can use the [`covariant` keyword](/guides/language/sound-problems#the-covariant-keyword).

限定方法参数以及实例变量的类型可以让代码更加
[类型安全](/guides/language/sound-dart)，你可以使用
[协变关键字](/guides/language/sound-problems#the-covariant-keyword)。

#### Overridable operators

#### 重写运算符

You can override the operators shown in the following table.
For example, if you define a
Vector class, you might define a `+` method to add two vectors.

可以在一个类中重写下表所罗列出的所有运算符。
比如如果定一个 Vector 表示矢量的类，
那么可以考虑重写 `+` 操作符来处理两个矢量的相加。

`<`  | `+`  | `|`  | `[]`
`>`  | `/`  | `^`  | `[]=`
`<=` | `~/` | `&`  | `~`
`>=` | `*`  | `<<` | `==`
`–`  | `%`  | `>>`
{:.table}

{{site.alert.note}}

  You may have noticed that `!=` is not an overridable operator. The expression
  `e1 != e2` is just syntactic sugar for `!(e1 == e2)`.
  
  必须要注意的是 `!=` 操作符并不是一个可被重写的操作符。
  表达式 `e1 != e2` 仅仅是 `!(e1 == e2)` 的一个语法糖。

{{site.alert.end}}

Here’s an example of a class that overrides the `+` and `-` operators:

下面是重写 `+` 和 `-` 操作符的例子：

<?code-excerpt "misc/lib/language_tour/classes/vector.dart"?>
```dart
class Vector {
  final int x, y;

  Vector(this.x, this.y);

  Vector operator +(Vector v) => Vector(x + v.x, y + v.y);
  Vector operator -(Vector v) => Vector(x - v.x, y - v.y);

  // 运算符 == 和 hashCode 的实现未在这里展示，详情请查看下方说明。
  // ···
}

void main() {
  final v = Vector(2, 3);
  final w = Vector(2, 2);

  assert(v + w == Vector(4, 5));
  assert(v - w == Vector(0, 1));
}
```

If you override `==`, you should also override Object's `hashCode` getter.
For an example of overriding `==` and `hashCode`, see
[Implementing map keys](/guides/libraries/library-tour#implementing-map-keys).

如果重写 `==` 操作符，必须也同时重写对象 `hashCode` 的 Getter 方法。
你可以查阅 [实现映射键](/guides/libraries/library-tour#implementing-map-keys)
获取更多关于重写的 `==` 和 `hashCode` 的例子。

For more information on overriding, in general, see
[Extending a class](#extending-a-class).

你也可以查阅 [扩展一个类](#extending-a-class)获取更多关于重写的信息。

#### noSuchMethod()

#### noSuchMethod 方法

To detect or react whenever code attempts to use a non-existent method or
instance variable, you can override `noSuchMethod()`:

如果调用了对象上不存在的方法或实例变量将会触发 `noSuchMethod` 方法，
你可以重写 `noSuchMethod` 方法来追踪和记录这一行为：

<?code-excerpt "misc/lib/language_tour/classes/no_such_method.dart" replace="/noSuchMethod(?!,)/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
class A {
  // 除非你重写 noSuchMethod，否则调用一个不存在的成员会导致 NoSuchMethodError。
  @override
  void [!noSuchMethod!](Invocation invocation) {
  print('你尝试使用一个不存在的成员：' +
  '${invocation.memberName}');
  }
}
{% endprettify %}

You **can't invoke** an unimplemented method unless
**one** of the following is true:

你不能调用一个未实现的方法除非下面其中的一个条件成立：

* The receiver has the static type `dynamic`.

  接收方是静态的 `dynamic` 类型。

* The receiver has a static type that
defines the unimplemented method (abstract is OK),
and the dynamic type of the receiver has an implemention of `noSuchMethod()`
that's different from the one in class `Object`.

  接收方具有静态类型，定义了未实现的方法（抽象亦可），
  并且接收方的动态类型实现了 `noSuchMethod` 
  方法且具体的实现与 `Object` 中的不同。

For more information, see the informal
[noSuchMethod forwarding specification.](https://github.com/dart-lang/sdk/blob/master/docs/language/informal/nosuchmethod-forwarding.md)

你可以查阅
[noSuchMethod 转发规范](https://github.com/dart-lang/sdk/blob/master/docs/language/informal/nosuchmethod-forwarding.md)
获取更多相关信息。


### Extension methods

### Extension 方法

Extension methods, introduced in Dart 2.7,
are a way to add functionality to existing libraries.
You might use extension methods without even knowing it.
For example, when you use code completion in an IDE,
it suggests extension methods alongside regular methods.

Dart 2.7 中引入的 Extension 方法是向现有库添加功能的一种方式。
你可能甚至都不知道有 Extension 方法。
例如，当您在 IDE 中使用代码完成功能时，
它建议将 Extension 方法与常规方法一起使用。

Here's an example of using an extension method on `String`
named `parseInt()` that's defined in `string_apis.dart`:

这里是一个在 `String` 中使用 extension 方法的样例，
我们取名为 `parseInt()`，它在 `string_apis.dart` 中定义：

```dart
import 'string_apis.dart';
...
print('42'.padLeft(5)); // Use a String method.
print('42'.parseInt()); // Use an extension method.
```

For details of using and implementing extension methods, see the
[extension methods page][].

有关使用以及实现 extension 方法的详细信息，请参阅
[extension methods 页面][extension methods page].

<a id="enums"></a>
### Enumerated types

### 枚举类型

Enumerated types, often called _enumerations_ or _enums_,
are a special kind of class used to represent
a fixed number of constant values.

枚举类型是一种特殊的类型，也称为 **enumerations** 或 **enums**，
用于定义一些固定数量的常量值。


#### Using enums

### 使用枚举

Declare an enumerated type using the `enum` keyword:

使用关键字 `enum` 来定义枚举类型：

<?code-excerpt "misc/lib/language_tour/classes/enum.dart (enum)"?>
```dart
enum Color { red, green, blue }
```

Each value in an enum has an `index` getter,
which returns the zero-based position of the value in the enum declaration.
For example, the first value has index 0,
and the second value has index 1.

每一个枚举值都有一个名为 `index` 成员变量的 Getter 方法，
该方法将会返回以 0 为基准索引的位置值。
例如，第一个枚举值的索引是 0 ，第二个枚举值的索引是 1。以此类推。

<?code-excerpt "misc/lib/language_tour/classes/enum.dart (index)"?>
```dart
assert(Color.red.index == 0);
assert(Color.green.index == 1);
assert(Color.blue.index == 2);
```

To get a list of all of the values in the enum,
use the enum's `values` constant.

可以使用枚举类的 `values` 方法获取一个包含所有枚举值的列表：

<?code-excerpt "misc/lib/language_tour/classes/enum.dart (values)"?>
```dart
List<Color> colors = Color.values;
assert(colors[2] == Color.blue);
```

You can use enums in [switch statements](#switch-and-case), and
you'll get a warning if you don't handle all of the enum's values:

你可以在 [Switch 语句](#switch-和-case)中使用枚举，
但是需要注意的是必须处理枚举值的每一种情况，
即每一个枚举值都必须成为一个 case 子句，不然会出现警告：

<?code-excerpt "misc/lib/language_tour/classes/enum.dart (switch)"?>
```dart
var aColor = Color.blue;

switch (aColor) {
  case Color.red:
    print('红如玫瑰！');
    break;
  case Color.green:
    print('绿如草原！');
    break;
  default: // 没有该语句会出现警告。
    print(aColor); // 'Color.blue'
}
```

Enumerated types have the following limits:

枚举类型有如下两个限制：

* You can't subclass, mix in, or implement an enum.

  枚举不能成为子类，也不可以 mix in，你也不可以实现一个枚举。

* You can't explicitly instantiate an enum.

  不能显式地实例化一个枚举类。

For more information, see the [Dart language specification][].

你可以查阅 [Dart 编程语言规范][]获取更多相关信息。


### Adding features to a class: mixins

### 使用 Mixin 为类添加功能

Mixins are a way of reusing a class's code in multiple class
hierarchies.

Mixin 是一种在多重继承中复用某个类中代码的方法模式。

To _use_ a mixin, use the `with` keyword followed by one or more mixin
names. The following example shows two classes that use mixins:

使用 `with` 关键字并在其后跟上 Mixin 类的名字来使用 Mixin 模式：

<?code-excerpt "misc/lib/language_tour/classes/orchestra.dart (Musician and Maestro)" replace="/(with.*) \{/[!$1!] {/g"?>
{% prettify dart tag=pre+code %}
class Musician extends Performer [!with Musical!] {
  // ···
}

class Maestro extends Person
    [!with Musical, Aggressive, Demented!] {
  Maestro(String maestroName) {
    name = maestroName;
    canConduct = true;
  }
}
{% endprettify %}

To _implement_ a mixin, create a class that extends Object and
declares no constructors.
Unless you want your mixin to be usable as a regular class,
use the `mixin` keyword instead of `class`.
For example:

定义一个类继承自 Object 并且不为该类定义构造函数，
这个类就是 Mixin 类，除非你想让该类与普通的类一样可以被正常地使用，
否则可以使用关键字 `mixin` 替代 `class` 让其成为一个单纯的 Mixin 类：

<?code-excerpt "misc/lib/language_tour/classes/orchestra.dart (Musical)"?>
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

Sometimes you might want to restrict the types that can use a mixin.
For example, the mixin might depend on being able to invoke a method
that the mixin doesn't define.
As the following example shows, you can restrict a mixin's use
by using the `on` keyword to specify the required superclass:

可以使用关键字 `on` 来指定哪些类可以使用该 Mixin 类，
比如有 Mixin 类 A，但是 A 只能被 B 类使用，
则可以这样定义 A：

<?code-excerpt "misc/lib/language_tour/classes/orchestra.dart (mixin-on)" plaster="none" replace="/on Musician2/[!on Musician!]/g" ?>
```dart
class Musician {
  // ...
}
mixin MusicalPerformer [!on Musician!] {
  // ...
}
class SingerDancer extends Musician with MusicalPerformer {
  // ...
}
```

In the preceding code,
only classes that extend or implement the `Musician` class
can use the mixin `MusicalPerformer`.
Because `SingerDancer` extends `Musician`,
`SingerDancer` can mix in `MusicalPerformer`.

{{site.alert.version-note}}

  Support for the `mixin` keyword was introduced in Dart 2.1. Code in earlier
  releases usually used `abstract class` instead. For more information on 2.1
  mixin changes, see the [Dart SDK changelog][] and [2.1 mixin specification.][]
  
  `mixin` 关键字在 Dart 2.1 中才被引用支持。
  早期版本中的代码通常使用 `abstract class` 代替。
  你可以查阅 
  [Dart SDK 变更日志][Dart SDK changelog]
  和 [2.1 mixin 规范][2.1 mixin specification.]
  获取更多有关 Mixin 在 2.1 中的变更信息。

{{site.alert.end}}

[Dart SDK changelog]: https://github.com/dart-lang/sdk/blob/master/CHANGELOG.md
[2.1 mixin specification.]: https://github.com/dart-lang/language/blob/master/accepted/2.1/super-mixins/feature-specification.md#dart-2-mixin-declarations

[Dart SDK 变更日志]: https://github.com/dart-lang/sdk/blob/master/CHANGELOG.md
[2.1 mixin 规范]: https://github.com/dart-lang/language/blob/master/accepted/2.1/super-mixins/feature-specification.md#dart-2-mixin-declarations


### Class variables and methods

### 类变量和方法

Use the `static` keyword to implement class-wide variables and methods.

使用关键字 `static` 可以声明类变量或类方法。

#### Static variables

#### 静态变量

Static variables (class variables) are useful for class-wide state and
constants:

静态变量（即类变量）常用于声明类范围内所属的状态变量和常量：

<?code-excerpt "misc/lib/language_tour/classes/misc.dart (static-field)"?>
```dart
class Queue {
  static const initialCapacity = 16;
  // ···
}

void main() {
  assert(Queue.initialCapacity == 16);
}
```

Static variables aren’t initialized until they’re used.

静态变量在其首次被使用的时候才被初始化。

{{site.alert.note}}

  This page follows the [style guide
  recommendation](/guides/language/effective-dart/style#identifiers)
  of preferring `lowerCamelCase` for constant names.
  
  本文代码准守
  [风格推荐指南](/guides/language/effective-dart/style#identifiers) 
  中的命名规则，使用 `驼峰式大小写` 来命名常量。

{{site.alert.end}}

#### Static methods

#### 静态方法

Static methods (class methods) do not operate on an instance, and thus
do not have access to `this`. For example:

静态方法（即类方法）不能被一个类的实例访问，同样地，静态方法内也不可以使用 `this`：

<?code-excerpt "misc/lib/language_tour/classes/point_with_distance_method.dart"?>
```dart
import 'dart:math';

class Point {
  double x, y;
  Point(this.x, this.y);

  static double distanceBetween(Point a, Point b) {
    var dx = a.x - b.x;
    var dy = a.y - b.y;
    return sqrt(dx * dx + dy * dy);
  }
}

void main() {
  var a = Point(2, 2);
  var b = Point(4, 4);
  var distance = Point.distanceBetween(a, b);
  assert(2.8 < distance && distance < 2.9);
  print(distance);
}
```

{{site.alert.note}}

  Consider using top-level functions, instead of static methods, for
  common or widely used utilities and functionality.
  
  对于一些通用或常用的静态方法，应该将其定义为顶级函数而非静态方法。

{{site.alert.end}}

You can use static methods as compile-time constants. For example, you
can pass a static method as a parameter to a constant constructor.

可以将静态方法作为编译时常量。例如，你可以将静态方法作为一个参数传递给一个常量构造函数。


## Generics

## 泛型

If you look at the API documentation for the basic array type,
[List,][List] you’ll see that the
type is actually `List<E>`. The \<...\> notation marks List as a
*generic* (or *parameterized*) type—a type that has formal type
parameters. [By convention][], most type variables have single-letter names,
such as E, T, S, K, and V.

如果你查看数组的 API 文档，你会发现数组 [List][] 的实际类型为 `List<E>`。
\<...\> 符号表示数组是一个 *泛型*（或 *参数化类型*）
[通常][By convention] 使用一个字母来代表类型参数，比如E、T、S、K 和 V 等等。

[By convention]: /guides/language/effective-dart/design#do-follow-existing-mnemonic-conventions-when-naming-type-parameters


### Why use generics?

### 为什么使用泛型？

Generics are often required for type safety, but they have more benefits
than just allowing your code to run:

泛型常用于需要要求类型安全的情况，但是它也会对代码运行有好处：

* Properly specifying generic types results in better generated code.

  适当地指定泛型可以更好地帮助代码生成。

* You can use generics to reduce code duplication.

  使用泛型可以减少代码重复。

If you intend for a list to contain only strings, you can
declare it as `List<String>` (read that as “list of string”). That way
you, your fellow programmers, and your tools can detect that assigning a non-string to
the list is probably a mistake. Here’s an example:

比如你想声明一个只能包含 String 类型的数组，
你可以将该数组声明为 `List<String>`（读作“字符串类型的 list”），
这样的话就可以很容易避免因为在该数组放入非 String 类变量而导致的诸多问题，
同时编译器以及其他阅读代码的人都可以很容易地发现并定位问题：

{:.fails-sa}
```dart
var names = List<String>();
names.addAll(['Seth', 'Kathy', 'Lars']);
names.add(42); // Error
```

Another reason for using generics is to reduce code duplication.
Generics let you share a single interface and implementation between
many types, while still taking advantage of static
analysis. For example, say you create an interface for
caching an object:

另一个使用泛型的原因是可以减少重复代码。
泛型可以让你在多个不同类型实现之间共享同一个接口声明，
比如下面的例子中声明了一个类用于缓存对象的接口：

<?code-excerpt "misc/lib/language_tour/generics/cache.dart (ObjectCache)"?>
```dart
abstract class ObjectCache {
  Object getByKey(String key);
  void setByKey(String key, Object value);
}
```

You discover that you want a string-specific version of this interface,
so you create another interface:

不久后你可能又会想专门为 String 类对象做一个缓存，
于是又有了专门为 String 做缓存的类：

<?code-excerpt "misc/lib/language_tour/generics/cache.dart (StringCache)"?>
```dart
abstract class StringCache {
  String getByKey(String key);
  void setByKey(String key, String value);
}
```

Later, you decide you want a number-specific version of this
interface... You get the idea.

如果过段时间你又想为数字类型也创建一个类，
那么就会有很多诸如此类的代码……

Generic types can save you the trouble of creating all these interfaces.
Instead, you can create a single interface that takes a type parameter:

这时候可以考虑使用泛型来声明一个类，
让不同类型的缓存实现该类做出不同的具体实现即可：

<?code-excerpt "misc/lib/language_tour/generics/cache.dart (Cache)"?>
```dart
abstract class Cache<T> {
  T getByKey(String key);
  void setByKey(String key, T value);
}
```

In this code, T is the stand-in type. It’s a placeholder that you can
think of as a type that a developer will define later.

在上述代码中，T 是一个替代类型。
其相当于类型占位符，在开发者调用该接口的时候会指定具体类型。


### Using collection literals

### 使用集合字面量

List, set, and map literals can be parameterized. Parameterized literals are
just like the literals you’ve already seen, except that you add
<code>&lt;<em>type</em>></code> (for lists and sets) or
<code>&lt;<em>keyType</em>, <em>valueType</em>></code> (for maps)
before the opening bracket. Here is an example of using typed literals:

List、Set 以及 Map 字面量也可以是参数化的。
定义参数化的 List 只需在中括号前添加
<code>&lt;<em>type</em>></code>；
定义参数化的 Map 只需要在大括号前添加
<code>&lt;<em>keyType</em>, <em>valueType</em>></code>：

<?code-excerpt "misc/lib/language_tour/generics/misc.dart (collection-literals)"?>
```dart
var names = <String>['小芸', '小芳', '小民'];
var uniqueNames = <String>{'小芸', '小芳', '小民'};
var pages = <String, String>{
  'index.html': '主页',
  'robots.txt': '网页机器人提示',
  'humans.txt': '我们是人类，不是机器'
};
```


### Using parameterized types with constructors

### 使用类型参数化的构造函数

To specify one or more types when using a constructor, put the types in
angle brackets (`<...>`) just after the class name. For example:

在调用构造方法时也可以使用泛型，
只需在类名后用尖括号（`<...>`）将一个或多个类型包裹即可：

<?code-excerpt "misc/test/language_tour/generics_test.dart (constructor-1)"?>
```dart
var nameSet = Set<String>.from(names);
```

{% comment %}[PENDING: update this sample; it ]{% endcomment %}

The following code creates a map that has integer keys and values of
type View:

下面代码创建了一个键为 Int 类型，值为 View 类型的 Map 对象：

<?code-excerpt "misc/test/language_tour/generics_test.dart (constructor-2)"?>
```dart
var views = Map<int, View>();
```


### Generic collections and the types they contain

### 泛型集合以及它们所包含的类型

Dart generic types are *reified*, which means that they carry their type
information around at runtime. For example, you can test the type of a
collection:

Dart的泛型类型是 *固化的*，这意味着即便在运行时也会保持类型信息：

<?code-excerpt "misc/test/language_tour/generics_test.dart (generic-collections)"?>
```dart
var names = List<String>();
names.addAll(['小芸', '小芳', '小民']);
print(names is List<String>); // true
```

{{site.alert.note}}

  In contrast, generics in Java use *erasure*, which means that generic
  type parameters are removed at runtime. In Java, you can test whether
  an object is a List, but you can’t test whether it’s a `List<String>`.
  
  与 Java 不同的是，Java 中的泛型是类型 *擦除* 的，这意味着泛型类型会在运行时被移除。在 Java 中你可以判断对象是否为 List 但不可以判断对象是否为 `List<String>`。

{{site.alert.end}}


### Restricting the parameterized type

### 限制参数化类型

When implementing a generic type,
you might want to limit the types of its parameters.
You can do this using `extends`.

有时使用泛型的时候可能会想限制泛型的类型范围，这时候可以使用 `extends` 关键字：

<?code-excerpt "misc/lib/language_tour/generics/base_class.dart" replace="/extends SomeBaseClass(?=. \{)/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
class Foo<T [!extends SomeBaseClass!]> {
  // 具体实现……
  String toString() => "'Foo<$T>' 的实例";
}

class Extender extends SomeBaseClass {...}
{% endprettify %}

It's OK to use `SomeBaseClass` or any of its subclasses as generic argument:

这时候就可以使用 `SomeBaseClass` 或者它的子类来作为泛型参数：

<?code-excerpt "misc/test/language_tour/generics_test.dart (SomeBaseClass-ok)" replace="/Foo.\w+./[!$&!]/g"?>
{% prettify dart tag=pre+code %}
var someBaseClassFoo = [!Foo<SomeBaseClass>!]();
var extenderFoo = [!Foo<Extender>!]();
{% endprettify %}

It's also OK to specify no generic argument:

这时候也可以指定无参数的泛型，这时无参数泛型的类型则为 `Foo<SomeBaseClass>`：

<?code-excerpt "misc/test/language_tour/generics_test.dart (no-generic-arg-ok)" replace="/expect\((.*?).toString\(\), .(.*?).\);/print($1); \/\/ $2/g"?>
```dart
var foo = Foo();
print(foo); // 'Foo<SomeBaseClass>' 的实例 (Instance of 'Foo<SomeBaseClass>')
```

Specifying any non-`SomeBaseClass` type results in an error:

将非 `SomeBaseClass` 的类型作为泛型参数则会导致编译错误：

{:.fails-sa}
{% prettify dart tag=pre+code %}
var foo = [!Foo<Object>!]();
{% endprettify %}


### Using generic methods

### 使用泛型方法

Initially, Dart's generic support was limited to classes.
A newer syntax, called _generic methods_, allows type arguments on methods and functions:

起初 Dart 只支持在类的声明时指定泛型，现在同样也可以在方法上使用泛型，称之为 _泛型方法_：

<!-- {{site.dartpad}}/a02c53b001977efa4d803109900f21bb -->
<!-- https://gist.github.com/a02c53b001977efa4d803109900f21bb -->
<?code-excerpt "misc/test/language_tour/generics_test.dart (method)" replace="/<T.(?=\()|T/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
[!T!] first[!<T>!](List<[!T!]> ts) {
  // 处理一些初始化工作或错误检测……
  [!T!] tmp = ts[0];
  // 处理一些额外的检查……
  return tmp;
}
{% endprettify %}

Here the generic type parameter on `first` (`<T>`)
allows you to use the type argument `T` in several places:

方法 `first<T>` 的泛型 `T` 可以在如下地方使用：

* In the function's return type (`T`).

  函数的返回值类型 (`T`)。

* In the type of an argument (`List<T>`).

  参数的类型 (`List<T>`)。

* In the type of a local variable (`T tmp`).

  局部变量的类型 (`T tmp`)。

For more information about generics, see
[Using Generic Methods.](https://github.com/dart-lang/sdk/blob/master/pkg/dev_compiler/doc/GENERIC_METHODS.md)

你可以查阅[使用泛型函数](https://github.com/dart-lang/sdk/blob/master/pkg/dev_compiler/doc/GENERIC_METHODS.md)获取更多关于泛型的信息。


## Libraries and visibility

## 库和可见性

The `import` and `library` directives can help you create a
modular and shareable code base. Libraries not only provide APIs, but
are a unit of privacy: identifiers that start with an underscore (\_)
are visible only inside the library. *Every Dart app is a library*, even
if it doesn’t use a `library` directive.

`import` 和 `library` 关键字可以帮助你创建一个模块化和可共享的代码库。代码库不仅只是提供 API 而且还起到了封装的作用：以下划线（\_）开头的成员仅在代码库中可见。*每个 Dart 程序都是一个库*，即便没有使用关键字 `library` 指定。

Libraries can be distributed using [packages](/guides/packages).

Dart 的库可以使用[包](/guides/packages)工具来发布和部署。


### Using libraries


### 使用库

Use `import` to specify how a namespace from one library is used in the
scope of another library.

使用 `import` 来指定命名空间以便其它库可以访问。

For example, Dart web apps generally use the [dart:html][]
library, which they can import like this:

比如你可以导入代码库 [dart:html][] 来使用 Dart Web 中相关 API：

<?code-excerpt "misc/test/language_tour/browser_test.dart (dart-html-import)"?>
```dart
import 'dart:html';
```

The only required argument to `import` is a URI specifying the
library.
For built-in libraries, the URI has the special `dart:` scheme.
For other libraries, you can use a file system path or the `package:`
scheme. The `package:` scheme specifies libraries provided by a package
manager such as the pub tool. For example:

`import` 的唯一参数是用于指定代码库的 URI，对于 Dart 内置的库，使用 `dart:xxxxxx` 的形式。而对于其它的库，你可以使用一个文件系统路径或者以 `package:xxxxxx` 的形式。`package:xxxxxx` 指定的库通过包管理器（比如 pub 工具）来提供：

<?code-excerpt "misc/test/language_tour/browser_test.dart (package-import)"?>
```dart
import 'package:test/test.dart';
```

{{site.alert.note}}

  *URI* stands for uniform resource identifier.
  
  *URI* 代表统一资源标识符。
  
  *URLs* (uniform resource locators) are a common kind of URI.
  
  *URL*（统一资源定位符）是一种常见的URI。

{{site.alert.end}}


#### Specifying a library prefix

#### 指定库前缀

If you import two libraries that have conflicting identifiers, then you
can specify a prefix for one or both libraries. For example, if library1
and library2 both have an Element class, then you might have code like
this:

如果你导入的两个代码库有冲突的标识符，你可以为其中一个指定前缀。比如如果 library1 和 library2 都有 Element 类，那么可以这么处理：

<?code-excerpt "misc/lib/language_tour/libraries/import_as.dart" replace="/(lib\d)\.dart/package:$1\/$&/g"?>
```dart
import 'package:lib1/lib1.dart';
import 'package:lib2/lib2.dart' as lib2;

// 使用 lib1 的 Element 类。
Element element1 = Element();

// 使用 lib2 的 Element 类。
lib2.Element element2 = lib2.Element();
```

#### Importing only part of a library

#### 导入库的一部分

If you want to use only part of a library, you can selectively import
the library. For example:

如果你只想使用代码库中的一部分，你可以有选择地导入代码库。例如：

<?code-excerpt "misc/lib/language_tour/libraries/show_hide.dart" replace="/(lib\d)\.dart/package:$1\/$&/g"?>
```dart
// 只导入 lib1 中的 foo。(Import only foo).
import 'package:lib1/lib1.dart' show foo;

// 导入 lib2 中除了 foo 外的所有。
import 'package:lib2/lib2.dart' hide foo;
```

<a id="deferred-loading"></a>
#### Lazily loading a library

#### 延迟加载库

_Deferred loading_ (also called _lazy loading_)
allows a web app to load a library on demand,
if and when the library is needed.
Here are some cases when you might use deferred loading:

_延迟加载_（也常称为 _懒加载_）允许应用在需要时再去加载代码库，
下面是可能使用到延迟加载的场景：

* To reduce a web app's initial startup time.

  为了减少应用的初始化时间。

* To perform A/B testing—trying out
  alternative implementations of an algorithm, for example.

  处理 A/B 测试，比如测试各种算法的不同实现。

* To load rarely used functionality, such as optional screens and dialogs.
 
  加载很少会使用到的功能，比如可选的屏幕和对话框。


{{site.alert.warn}}

  **Only dart2js supports deferred loading.**
  Flutter, the Dart VM, and dartdevc don't support deferred loading.
  For more information, see
  [issue #33118](https://github.com/dart-lang/sdk/issues/33118) and
  [issue #27776.](https://github.com/dart-lang/sdk/issues/27776)
  
  **目前只有 dart2js 支持延迟加载** 
  Flutter、Dart VM以及 DartDevc 目前都不支持延迟加载。
  你可以查阅 [issue #33118](https://github.com/dart-lang/sdk/issues/33118) 
  和 [issue #27776](https://github.com/dart-lang/sdk/issues/27776) 获取更多的相关信息。

{{site.alert.end}}

To lazily load a library, you must first
import it using `deferred as`.

使用 `deferred as` 关键字来标识需要延时加载的代码库：

<?code-excerpt "misc/lib/language_tour/libraries/greeter.dart (import)" replace="/hello\.dart/package:greetings\/$&/g"?>
```dart
import 'package:greetings/hello.dart' deferred as hello;
```

When you need the library, invoke
`loadLibrary()` using the library's identifier.

当实际需要使用到库中 API 时先调用 `loadLibrary` 函数加载库：

<?code-excerpt "misc/lib/language_tour/libraries/greeter.dart (loadLibrary)"?>
```dart
Future greet() async {
  await hello.loadLibrary();
  hello.printGreeting();
}
```

In the preceding code,
the `await` keyword pauses execution until the library is loaded.
For more information about `async` and `await`,
see [asynchrony support](#asynchrony-support).

在前面的代码，使用 `await` 关键字暂停代码执行直到库加载完成。更多关于 `async` 和 `await` 的信息请参考[异步支持](#asynchrony-support)。

You can invoke `loadLibrary()` multiple times on a library without problems.
The library is loaded only once.

`loadLibrary` 函数可以调用多次也没关系，代码库只会被加载一次。

Keep in mind the following when you use deferred loading:

当你使用延迟加载的时候需要牢记以下几点：

* A deferred library's constants aren't constants in the importing file.
  Remember, these constants don't exist until the deferred library is loaded.

  延迟加载的代码库中的常量需要在代码库被加载的时候才会导入，未加载时是不会导入的。

* You can't use types from a deferred library in the importing file.
  Instead, consider moving interface types to a library imported by
  both the deferred library and the importing file.

  导入文件的时候无法使用延迟加载库中的类型。如果你需要使用类型，则考虑吧接口类型转移到另一个库中然后让两个库都分别导入这个接口库。

* Dart implicitly inserts `loadLibrary()` into the namespace that you define
  using <code>deferred as <em>namespace</em></code>.
  The `loadLibrary()` function returns a [Future](/guides/libraries/library-tour#future).

  Dart会隐式地将 `loadLibrary` 方法导入到使用了 <code>deferred as <em>命名空间</em></code> 的类中。`loadLibrary` 函数返回的是一个 [Future](/guides/libraries/library-tour#future)。

### Implementing libraries

### 实现库

See
[Create Library Packages](/guides/libraries/create-library-packages)
for advice on how to implement a library package, including:

查阅[创建依赖库包](/guides/libraries/create-library-packages)可以获取有关如何实现库包的建议，包括：

* How to organize library source code.

  如何组织库的源文件。

* How to use the `export` directive.

  如何使用 `export` 命令。

* When to use the `part` directive.

  何时使用 `part` 命令。

* When to use the `library` directive.
 
  何时使用 `library` 命令。

* How to use conditional imports and exports to implement
  a library that supports multiple platforms.

  如何使用倒入和导出命令实现多平台的库支持。


<a id="asynchrony"></a>
## Asynchrony support

## 异步支持

Dart libraries are full of functions that
return [Future][] or [Stream][] objects.
These functions are _asynchronous_:
they return after setting up
a possibly time-consuming operation
(such as I/O),
without waiting for that operation to complete.

Dart 代码库中有大量返回 [Future][] 或 [Stream][] 对象的函数，这些函数都是 _异步_ 的，它们会在耗时操作（比如I/O）执行完毕前直接返回而不会等待耗时操作执行完毕。

The `async` and `await` keywords support asynchronous programming,
letting you write asynchronous code that
looks similar to synchronous code.

`async` 和 `await` 关键字用于实现异步编程，并且让你的代码看起来就像是同步的一样。

<a id="await"></a>
### Handling Futures

### 处理 Future

When you need the result of a completed Future,
you have two options:

可以通过下面两种方式，获得 Future 执行完成的结果：

* Use `async` and `await`.

  使用 `async` 和 `await`；

* Use the Future API, as described
  [in the library tour](/guides/libraries/library-tour#future).

  使用 Future API，具体描述，参考[库概览](/guides/libraries/library-tour#future)。

Code that uses `async` and `await` is asynchronous,
but it looks a lot like synchronous code.
For example, here's some code that uses `await`
to wait for the result of an asynchronous function:

使用 `async` 和 `await` 的代码是异步的，但是看起来有点像同步代码。例如，下面的代码使用 `await`
等待异步函数的执行结果。

<?code-excerpt "misc/lib/language_tour/async.dart (await-lookUpVersion)"?>
```dart
await lookUpVersion();
```

To use `await`, code must be in an `async` function—a
function marked as `async`:

必须在带有 async 关键字的 _异步函数_ 中使用 `await`：

<?code-excerpt "misc/lib/language_tour/async.dart (checkVersion)" replace="/async|await/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
Future checkVersion() [!async!] {
  var version = [!await!] lookUpVersion();
  // 使用 version 继续处理逻辑
}
{% endprettify %}

{{site.alert.note}}

  Although an `async` function might perform time-consuming operations, it
  doesn't wait for those operations. Instead, the `async` function executes only
  until it encounters its first `await` expression
  ([details][synchronous-async-start]). Then it returns a Future object,
  resuming execution only after the `await` expression completes.
  
  尽管异步函数可以处理耗时操作，但是它并不会等待这些耗时操作完成，
  异步函数执行时会在其遇到第一个 `await` 表达式
  （[详情见][synchronous-async-start]）的时候返回一个 Future 对象，
  然后等待 await 表达式执行完毕后继续执行。
  
{{site.alert.end}}

Use `try`, `catch`, and `finally` to handle errors and cleanup in code that uses
`await`:

使用 `try`、`catch` 以及 `finally` 来处理使用 `await` 导致的异常：

<?code-excerpt "misc/lib/language_tour/async.dart (try-catch)"?>
```dart
try {
  version = await lookUpVersion();
} catch (e) {
  // 无法找到版本时做出的反应
}
```

You can use `await` multiple times in an `async` function.
For example, the following code waits three times
for the results of functions:

你可以在异步函数中多次使用 `await` 关键字。例如，下面代码中等待了三次函数结果：


<?code-excerpt "misc/lib/language_tour/async.dart (repeated-await)"?>
```dart
var entrypoint = await findEntrypoint();
var exitCode = await runExecutable(entrypoint, args);
await flushThenExit(exitCode);
```

In <code>await <em>expression</em></code>,
the value of <code><em>expression</em></code> is usually a Future;
if it isn't, then the value is automatically wrapped in a Future.
This Future object indicates a promise to return an object.
The value of <code>await <em>expression</em></code> is that returned object.
The await expression makes execution pause until that object is available.

<code>await <em>表达式的返回值通常是一个 Future 对象；如果不是的话也会自动将其包裹在一个 Future 对象里。Future 对象代表一个“承诺”，<code>await <em>表达式</em></code>会阻塞直到需要的对象返回。

**If you get a compile-time error when using `await`,
make sure `await` is in an `async` function.**
For example, to use `await` in your app's `main()` function,
the body of `main()` must be marked as `async`:

**如果在使用 `await` 时导致编译错误，请确保 `await` 在一个异步函数中使用**。例如，如果想在 main() 函数中使用 `await`，那么 `main()` 函数就必须使用 `async` 关键字标识。

<?code-excerpt "misc/lib/language_tour/async.dart (main)" replace="/async|await/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
Future main() [!async!] {
  checkVersion();
  print('在 Main 函数中执行：版本是 ${[!await!] lookUpVersion()}');
}
{% endprettify %}


<a id="async"></a>
### Declaring async functions

### 声明异步函数

An `async` function is a function whose body is marked with
the `async` modifier.

定义 _异步函数_ 只需在普通方法上加上 `async` 关键字即可。

Adding the `async` keyword to a function makes it return a Future.
For example, consider this synchronous function,
which returns a String:

将关键字 `async` 添加到函数并让其返回一个 Future 对象。假设有如下返回 String 对象的方法：

<?code-excerpt "misc/lib/language_tour/async.dart (sync-lookUpVersion)"?>
```dart
String lookUpVersion() => '1.0.0';
```

If you change it to be an `async` function—for example,
because a future implementation will be time consuming—the
returned value is a Future:

将其改为异步函数，返回值是 Future：

<?code-excerpt "misc/lib/language_tour/async.dart (async-lookUpVersion)"?>
```dart
Future<String> lookUpVersion() async => '1.0.0';
```

Note that the function's body doesn't need to use the Future API.
Dart creates the Future object if necessary.

注意，函数体不需要使用 Future API。如有必要，Dart 会创建 Future 对象。

If your function doesn't return a useful value,
make its return type `Future<void>`.

如果函数没有返回有效值，需要设置其返回类型为 `Future<void>`。

For an interactive introduction to using futures, `async`, and `await`,
see the [asynchronous programming codelab](/codelabs/async-await).

关于 futures、`async` 和 `await` 的使用介绍，可以参见这个 codelab: 
[asynchronous programming codelab](/codelabs/async-await)。

{% comment %}
TODO: Where else should we cover generalized void?
{% endcomment %}


<a id="await-for"></a>
### Handling Streams

### 处理 Stream

When you need to get values from a Stream,
you have two options:

如果想从 Stream 中获取值，可以有两种选择：

* Use `async` and an _asynchronous for loop_ (`await for`).

  使用 `async` 关键字和一个 _异步循环_（使用 `await for` 关键字标识）。

* Use the Stream API, as described
  [in the library tour](/guides/libraries/library-tour#stream).

  使用 Stream API。详情参考[库概览](/guides/libraries/library-tour#stream)。

{{site.alert.note}}

  Before using `await for`, be sure that it makes the code clearer and that you
  really do want to wait for all of the stream's results. For example, you
  usually should **not** use `await for` for UI event listeners, because UI
  frameworks send endless streams of events.
  
  在使用 `await for` 关键字前，
  确保其可以令代码逻辑更加清晰并且是真的需要等待所有的结果执行完毕。
  例如，通常不应该在 UI 事件监听器上使用 `await for` 关键字，
  因为 UI 框架发出的事件流是无穷尽的。

{{site.alert.end}}

An asynchronous for loop has the following form:

使用 await for 定义异步循环看起来是这样的：

<?code-excerpt "misc/lib/language_tour/async.dart (await-for)"?>
```dart
await for (varOrType identifier in expression) {
  // 每当 Stream 发出一个值时会执行
}
```

The value of <code><em>expression</em></code> must have type Stream.
Execution proceeds as follows:

<code><em>表达式</em></code> 的类型必须是 Stream。执行流程如下：

1. Wait until the stream emits a value.

   等待直到 Stream 返回一个数据。

2. Execute the body of the for loop,
   with the variable set to that emitted value.

   使用 1 中 Stream 返回的数据执行循环体。

3. Repeat 1 and 2 until the stream is closed.

   重复 1、2 过程直到 Stream 数据返回完毕。

To stop listening to the stream,
you can use a `break` or `return` statement,
which breaks out of the for loop
and unsubscribes from the stream.

使用 `break` 和 `return` 语句可以停止接收 Stream 数据，这样就跳出了循环并取消注册监听 Stream。

**If you get a compile-time error when implementing an asynchronous for loop,
make sure the `await for` is in an `async` function.**
For example, to use an asynchronous for loop in your app's `main()` function,
the body of `main()` must be marked as `async`:

**如果在实现异步 for 循环时遇到编译时错误，请检查确保 `await for` 处于异步函数中。** 例如，要在应用程序的 `main()` 函数中使用异步 for 循环，`main()` 函数体必须标记为 `async`：

<?code-excerpt "misc/lib/language_tour/async.dart (number_thinker)" replace="/async|await for/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
Future main() [!async!] {
  // ...
  [!await for!] (var request in requestServer) {
    handleRequest(request);
  }
  // ...
}
{% endprettify %}

For more information about asynchronous programming, in general, see the
[dart:async](/guides/libraries/library-tour#dartasync---asynchronous-programming)
section of the library tour.

你可以查阅库概览中有关 [dart:async](/guides/libraries/library-tour#dartasync---asynchronous-programming) 的部分获取更多有关异步编程的信息。


<a id="generator"></a>
## Generators

## 生成器

When you need to lazily produce a sequence of values,
consider using a _generator function_.
Dart has built-in support for two kinds of generator functions:

当你需要延迟地生成一连串的值时，可以考虑使用 _生成器函数_。Dart 内置支持两种形式的生成器方法：

* **Synchronous** generator: Returns an **[Iterable]** object.

  **同步** 生成器：返回一个 **[Iterable]** 对象。

* **Asynchronous** generator: Returns a **[Stream]** object.

  **异步** 生成器：返回一个 **[Stream]** 对象。

To implement a **synchronous** generator function,
mark the function body as `sync*`,
and use `yield` statements to deliver values:

通过在函数上加 `sync*` 关键字并将返回值类型设置为 Iterable 来实现一个 **同步** 生成器函数，在函数中使用 `yield` 语句来传递值：

<?code-excerpt "misc/test/language_tour/async_test.dart (sync-generator)"?>
```dart
Iterable<int> naturalsTo(int n) sync* {
  int k = 0;
  while (k < n) yield k++;
}
```

To implement an **asynchronous** generator function,
mark the function body as `async*`,
and use `yield` statements to deliver values:

实现 **异步** 生成器函数与同步类似，只不过关键字为 `async*` 并且返回值为 Stream：

<?code-excerpt "misc/test/language_tour/async_test.dart (async-generator)"?>
```dart
Stream<int> asynchronousNaturalsTo(int n) async* {
  int k = 0;
  while (k < n) yield k++;
}
```

If your generator is recursive,
you can improve its performance by using `yield*`:

如果生成器是递归调用的，可是使用 `yield*` 语句提升执行性能：

<?code-excerpt "misc/test/language_tour/async_test.dart (recursive-generator)"?>
```dart
Iterable<int> naturalsDownFrom(int n) sync* {
  if (n > 0) {
    yield n;
    yield* naturalsDownFrom(n - 1);
  }
}
```


## Callable classes

## 可调用类

To allow an instance of your Dart class to be called like a function,
implement the `call()` method.

通过实现类的 `call()` 方法，允许使用类似函数调用的方式来使用该类的实例。

In the following example, the `WannabeFunction` class defines a call() function
that takes three strings and concatenates them, separating each with a space,
and appending an exclamation. Click **Run** to execute the code.

在下面的示例中，`WannabeFunction` 类定义了一个 call() 函数，
函数接受三个字符串参数，函数体将三个字符串拼接，字符串间用空格分割，
并在结尾附加了一个感叹号。单击运行按钮执行代码。

{% comment %}
https://gist.github.com/405379bacf30335f3aed
{{site.dartpad}}/405379bacf30335f3aed

<?code-excerpt "misc/lib/language_tour/callable_classes.dart"?>
```dart
class WannabeFunction {
  String call(String a, String b, String c) => '$a $b $c!';
}

var wf = WannabeFunction();
var out = wf('你好', '，使用 Dart 的', '朋友');

main() => print(out);
```
{% endcomment %}

<iframe
src="{{site.dartpad-embed-inline}}?id=3723fcf3915ca935d13393b8a9f86fd5&ga_id=callable_classes"
    width="100%"
    height="350px"
    style="border: 1px solid #ccc;">
</iframe>


## Isolates

## 隔离区

Most computers, even on mobile platforms, have multi-core CPUs.
To take advantage of all those cores, developers traditionally use
shared-memory threads running concurrently. However, shared-state
concurrency is error prone and can lead to complicated code.

大多数计算机中，甚至在移动平台上，都在使用多核 CPU。为了有效利用多核性能，开发者一般使用共享内存的方式让线程并发地运行。然而，多线程共享数据通常会导致很多潜在的问题，并导致代码运行出错。

Instead of threads, all Dart code runs inside of *isolates*. Each
isolate has its own memory heap, ensuring that no isolate’s state is
accessible from any other isolate.

为了解决多线程带来的并发问题，Dart 使用 isolates 替代线程，所有的 Dart 代码均运行在一个 *isolates* 中。每一个 isolates 有它自己的堆内存以确保其状态不被其它 isolates 访问。

For more information, see the following:

你可以查阅下面的文档获取更多相关信息：

* [Dart asynchronous programming: Isolates and event loops][isolates article]

  [Dart 异步编程：隔离区和事件循环][isolates article]

* [dart:isolate API reference,][dart:isolate]
  including [Isolate.spawn()][] and
  [TransferableTypedData][]

  [dart:isolate API 参考][dart:isolate]介绍了 [Isolate.spawn()][] 和 [TransferableTypedData][] 的用法

* [Background parsing][background json] cookbook on the Flutter site
* [Isolate sample app][]

  Flutter 网站上关于[后台解析][background json]的 Cookbook

[isolates article]: https://medium.com/dartlang/dart-asynchronous-programming-isolates-and-event-loops-bffc3e296a6a
[Isolate.spawn()]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-isolate/Isolate/spawn.html
[TransferableTypedData]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-isolate/TransferableTypedData-class.html
[background json]: {{site.flutter}}/docs/cookbook/networking/background-parsing
[Isolate sample app]: https://github.com/flutter/samples/tree/master/isolate_example

## Typedefs

## 类型定义

In Dart, functions are objects, just like strings and numbers are
objects. A *typedef*, or *function-type alias*, gives a function type a
name that you can use when declaring fields and return types. A typedef
retains type information when a function type is assigned to a variable.

在 Dart 语言中，函数与 String 和 Number 一样都是对象，可以使用 *类型定义*（或者叫 *方法类型别名*）来为函数的类型命名。使用函数命名将该函数类型的函数赋值给一个变量时，类型定义将会保留相关的类型信息。

Consider the following code, which doesn't use a typedef:

比如下面的代码没有使用类型定义：

<?code-excerpt "misc/lib/language_tour/typedefs/sorted_collection_1.dart"?>
```dart
class SortedCollection {
  Function compare;

  SortedCollection(int f(Object a, Object b)) {
    compare = f;
  }
}

// 简单的不完整实现。
int sort(Object a, Object b) => 0;

void main() {
  SortedCollection coll = SortedCollection(sort);

  // 我们知道 compare 是一个函数类型的变量，但是具体是什么样的函数却不得而知。
  assert(coll.compare is Function);
}
```

Type information is lost when assigning `f` to `compare`. The type of
`f` is `(Object, ``Object)` → `int` (where → means returns), yet the
type of `compare` is Function. If we change the code to use explicit
names and retain type information, both developers and tools can use
that information.

上述代码中，当将参数 `f` 赋值给 `compare` 时，函数的类型信息丢失了，这里 `f` 这个函数的类型为 `(Object, Object) → int`（→ 代表返回），当然该类型也是一个 Function 的子类，但是将 `f` 赋值给 `compare` 后，`f` 的类型 `(Object, Object) → int` 就会丢失。我们可以使用 `typedef` 显式地保留类型信息：

<?code-excerpt "misc/lib/language_tour/typedefs/sorted_collection_2.dart"?>
```dart
typedef Compare = int Function(Object a, Object b);

class SortedCollection {
  Compare compare;

  SortedCollection(this.compare);
}

// 简单的不完整实现。
int sort(Object a, Object b) => 0;

void main() {
  SortedCollection coll = SortedCollection(sort);
  assert(coll.compare is Function);
  assert(coll.compare is Compare);
}
```

{{site.alert.note}}

  Currently, typedefs are restricted to function types. We expect this to
  change.
  
  目前类型定义只能用在函数类型上，但是将来可能会有变化。
  
{{site.alert.end}}

Because typedefs are simply aliases, they offer a way to check the type
of any function. For example:

因为类型定义只是别名，因此我们可以使用它判断任意函数类型的方法：

<?code-excerpt "misc/lib/language_tour/typedefs/misc.dart (compare)"?>
```dart
typedef Compare<T> = int Function(T a, T b);

int sort(int a, int b) => a - b;

void main() {
  assert(sort is Compare<int>); // True!
}
```

## Metadata

## 元数据

Use metadata to give additional information about your code. A metadata
annotation begins with the character `@`, followed by either a reference
to a compile-time constant (such as `deprecated`) or a call to a
constant constructor.

使用元数据可以为代码增加一些额外的信息。元数据注解以 `@` 开头，其后紧跟一个编译时常量（比如 `deprecated`）或者调用一个常量构造函数。

Two annotations are available to all Dart code: `@deprecated` and
`@override`. For examples of using `@override`,
see [Extending a class](#extending-a-class).
Here’s an example of using the `@deprecated`
annotation:

Dart 中有两个注解是所有代码都可以使用的：`@deprecated` 和 `@override`。你可以查阅[扩展一个类](#extending-a-class)获取有关 `@override` 的使用示例。下面是使用 `@deprecated` 的示例：

<?code-excerpt "misc/lib/language_tour/metadata/television.dart (deprecated)" replace="/@deprecated/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
class Television {
  /// _弃用: 使用 [turnOn] 替代_
  [!@deprecated!]
  void activate() {
    turnOn();
  }

  /// 打开 TV 的电源。
  void turnOn() {...}
}
{% endprettify %}

You can define your own metadata annotations. Here’s an example of
defining a @todo annotation that takes two arguments:

可以自定义元数据注解。下面的示例定义了一个带有两个参数的 @todo 注解：

<?code-excerpt "misc/lib/language_tour/metadata/todo.dart"?>
```dart
library todo;

class Todo {
  final String who;
  final String what;

  const Todo(this.who, this.what);
}
```

And here’s an example of using that @todo annotation:

使用 @todo 注解的示例：

<?code-excerpt "misc/lib/language_tour/metadata/misc.dart"?>
```dart
import 'todo.dart';

@Todo('seth', 'make this do something')
void doSomething() {
  print('do something');
}
```

Metadata can appear before a library, class, typedef, type parameter,
constructor, factory, function, field, parameter, or variable
declaration and before an import or export directive. You can
retrieve metadata at runtime using reflection.

元数据可以在 library、class、typedef、type parameter、
constructor、factory、function、field、parameter
或者 variable 声明之前使用，
也可以在 import 或 export 之前使用。
可使用反射在运行时获取元数据信息。


## Comments

## 注释

Dart supports single-line comments, multi-line comments, and
documentation comments.

Dart 支持单行注释、多行注释和文档注释。

### Single-line comments

### 单行注释

A single-line comment begins with `//`. Everything between `//` and the
end of line is ignored by the Dart compiler.

单行注释以 `//` 开始。所有在 `//` 和该行结尾之间的内容被编译器忽略。

<?code-excerpt "misc/lib/language_tour/comments.dart (single-line-comments)"?>
```dart
void main() {
  // TODO: refactor into an AbstractLlamaGreetingFactory?
  print('Welcome to my Llama farm!');
}
```


### Multi-line comments

### 多行注释

A multi-line comment begins with `/*` and ends with `*/`. Everything
between `/*` and `*/` is ignored by the Dart compiler (unless the
comment is a documentation comment; see the next section). Multi-line
comments can nest.

多行注释以  `/*`  开始， 以 `*/` 结尾。所有在 `/*` 和 `*/`
之间的内容被编译器忽略（不会忽略文档注释），
多行注释可以嵌套。

<?code-excerpt "misc/lib/language_tour/comments.dart (multi-line-comments)"?>
```dart
void main() {
  /*
   * This is a lot of work. Consider raising chickens.

  Llama larry = Llama();
  larry.feed();
  larry.exercise();
  larry.clean();
   */
}
```


### Documentation comments

### 文档注释

Documentation comments are multi-line or single-line comments that begin
with `///` or `/**`. Using `///` on consecutive lines has the same
effect as a multi-line doc comment.

文档注释可以是多行注释，也可以是单行注释，
文档注释以 `///` 或者 `/**` 开始。
在连续行上使用 `///` 与多行文档注释具有相同的效果。

Inside a documentation comment, the Dart compiler ignores all text
unless it is enclosed in brackets. Using brackets, you can refer to
classes, methods, fields, top-level variables, functions, and
parameters. The names in brackets are resolved in the lexical scope of
the documented program element.

在文档注释中，除非用中括号括起来，否则 Dart 编译器会忽略所有文本。
使用中括号可以引用类、方法、字段、顶级变量、函数和参数。
括号中的符号会在已记录的程序元素的词法域中进行解析。

Here is an example of documentation comments with references to other
classes and arguments:

下面是一个引用其他类和成员的文档注释：

<?code-excerpt "misc/lib/language_tour/comments.dart (doc-comments)"?>
```dart
/// A domesticated South American camelid (Lama glama).
///
/// Andean cultures have used llamas as meat and pack
/// animals since pre-Hispanic times.
class Llama {
  String name;

  /// Feeds your llama [Food].
  ///
  /// The typical llama eats one bale of hay per week.
  void feed(Food food) {
    // ...
  }

  /// Exercises your llama with an [activity] for
  /// [timeLimit] minutes.
  void exercise(Activity activity, int timeLimit) {
    // ...
  }
}
```

In the generated documentation, `[Food]` becomes a link to the API docs
for the Food class.

在生成的文档中，`[Food]` 会成为一个链接，指向 Food 类的 API 文档。

To parse Dart code and generate HTML documentation, you can use the SDK’s
[documentation generation tool.](https://github.com/dart-lang/dartdoc#dartdoc)
For an example of generated documentation, see the [Dart API
documentation.]({{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}) For advice on how to structure
your comments, see
[Guidelines for Dart Doc Comments.](/guides/language/effective-dart/documentation)

解析 Dart 代码并生成 HTML 文档，可以使用 SDK 中的 
[文档生成工具](https://github.com/dart-lang/dartdoc#dartdoc) 关于生成文档的实例，
请参考
[Dart API documentation]({{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}) 
查看关于文档结构的建议，
请参考文档：
[Guidelines for Dart Doc Comments.](/guides/language/effective-dart/documentation)。


## Summary

## 总结

This page summarized the commonly used features in the Dart language.
More features are being implemented, but we expect that they won’t break
existing code. For more information, see the [Dart language specification][] and
[Effective Dart](/guides/language/effective-dart).

本页概述了 Dart 语言中常用的功能。还有更多特性有待实现，
但我们希望它们不会破坏现有代码。有关更多信息，
请参考 [Dart 语言规范][Dart language specification] 和
[高效 Dart 语言指南](/guides/language/effective-dart)。

To learn more about Dart's core libraries, see
[A Tour of the Dart Libraries](/guides/libraries/library-tour).

要了解更多关于 Dart 核心库的内容，
请参考 [Dart 核心库概览](/guides/libraries/library-tour)。

[AssertionError]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/AssertionError-class.html
[`Characters`]: {{site.pub-api}}/characters/latest/characters/Characters-class.html
[characters API]: {{site.pub-api}}/characters
[characters example]: {{site.pub-pkg}}/characters#-example-tab-
[characters package]: {{site.pub-pkg}}/characters
[dart2js]: /tools/dart2js
[dart:html]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-html
[dart:isolate]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-isolate
[dart:math]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-math
[dart]: /server/tools/dart-vm
[Dart language specification]: /guides/language/spec
[dartdevc]: /tools/dartdevc
[DON’T use const redundantly]: /guides/language/effective-dart/usage#dont-use-const-redundantly
[double]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/double-class.html
[Error]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Error-class.html
[Exception]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Exception-class.html
[extension methods page]: /guides/language/extension-methods
[Flutter]: {{site.flutter}}
[Flutter debug mode]: {{site.flutter}}/docs/testing/debugging#debug-mode-assertions
[forEach()]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Iterable/forEach.html
[Function API reference]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Function-class.html
[Future]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-async/Future-class.html
[grapheme clusters]: https://unicode.org/reports/tr29/#Grapheme_Cluster_Boundaries
[identical()]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/identical.html
[int]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/int-class.html
[Iterable]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Iterable-class.html
[js numbers]: https://stackoverflow.com/questions/2802957/number-of-bits-in-javascript-numbers/2803010#2803010
[List]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/List-class.html
[Map]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Map-class.html
[meta]: {{site.pub-pkg}}/meta
[num]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/num-class.html
[@required]: {{site.pub-api}}/meta/latest/meta/required-constant.html
[Object]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Object-class.html
[ObjectVsDynamic]: /guides/language/effective-dart/design#do-annotate-with-object-instead-of-dynamic-to-indicate-any-object-is-allowed
[runes]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Runes-class.html
[Set class]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Set-class.html
[StackTrace]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/StackTrace-class.html
[Stream]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-async/Stream-class.html
[String]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/String-class.html
[Symbol]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Symbol-class.html
[synchronous-async-start]: https://github.com/dart-lang/sdk/blob/master/docs/newsletter/20170915.md#synchronous-async-start
[Type]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Type-class.html
