---
title: A tour of the Dart language
title: Dart 开发语言概览
description: A tour of all of the major Dart language features.
description: Dart 开发语言的主要特性概览。
short-title: Language tour
---
<?code-excerpt replace="/([A-Z]\w*)\d\b/$1/g"?>

This page shows you how to use each major Dart feature, from
variables and operators to classes and libraries, with the assumption
that you already know how to program in another language.

本文将从变量和运算符开始到类和库的使用来向你介绍 Dart 编程语言的主要功能，这里假设你已经有使用其它语言进行编程的经验。

To learn more about Dart's core libraries, see the
[library tour](/guides/libraries/library-tour).
Whenever you want more details about a language feature,
consult the [Dart language specification][].

你可以通过查看 [Dart 库概览](/guides/libraries/library-tour) 学习更多关于 Dart 核心库的知识。若还想了解更多有关语言功能的详细内容，请参阅 [Dart 编程语言规范][/guides/language/spec]

<div class="alert alert-info" markdown="1">
**Tip:**

**提示：**

You can play with most of Dart's language features using DartPad
([learn more](/tools/dartpad)).

使用 DartPad 可以体验 Dart 的大部分语言功能([了解更多](/tools/dartpad))。

**<a href="{{ site.dartpad }}" target="_blank">Open DartPad</a>**

**<a href="{{ site.dartpad }}"" target="_blank">打开 DartPad</a>**
</div>

## A basic Dart program

## 一个简单的 Dart 程序

The following code uses many of Dart’s most basic features:

下面的应用程序代码用到了很多 Dart 的基本功能：

<?code-excerpt "misc/test/language_tour/basic_test.dart"?>
{% prettify dart %}
// 定义一个函数。
printInteger(int aNumber) {
  print('The number is $aNumber.'); // 打印输出到控制台。
}

// Dart 程序从 main() 函数开始执行。
main() {
  var number = 42; // 声明并初始化一个变量。
  printInteger(number); // 调用一个函数。
}
{% endprettify %}

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

<div class="alert alert-info" markdown="1">
**Note:**

**提示：**

This site's code follows the conventions in the
[Dart style guide](/guides/language/effective-dart/style).

本站的代码遵循 [Dart 风格指南](/guides/language/effective-dart/style)中的约定。
</div>


## Important concepts

## 重要的概念

As you learn about the Dart language, keep these facts and concepts in
mind:

在学习 Dart 语言时, 应该基于以下事实和概念：

-   Everything you can place in a variable is an *object*, and every
    object is an instance of a *class*. Even numbers, functions, and
    `null` are objects. All objects inherit from the [Object][] class.

    任何保存在变量中的都是一个 *对象* ， 并且所有的对象都是对应一个 *类* 的实例。
    无论是数字，函数和 `null` 都是对象。所有对象继承自 [Object][] 类。

-   Although Dart is strongly typed, type annotations are optional
    because Dart can infer types. In the code above, `number`
    is inferred to be of type `int`. When you want to explicitly say
    that no type is expected,
    [use the special type `dynamic`][ObjectVsDynamic].

    尽管 Dart 是强类型的，但是 Dart 可以推断类型，所以类型注释是可选的。
    在上面的代码中， `number` 被推断为 `int` 类型。
    如果要明确说明不需要任何类型，
    [需要使用特殊类型 `dynamic`] [ObjectVsDynamic]。

-   Dart supports generic types, like `List<int>` (a list of integers)
    or `List<dynamic>` (a list of objects of any type).

    Dart 支持泛型，如 `List <int>` （整数列表）或 `List <dynamic>` （任何类型的对象列表）。

-   Dart supports top-level functions (such as `main()`), as well as
    functions tied to a class or object (*static* and *instance
    methods*, respectively). You can also create functions within
    functions (*nested* or *local functions*).

    Dart 支持顶级函数（例如 `main（）`），
    同样函数绑定在类或对象上（分别是*静态函数*和*实例函数*）。
    以及支持函数内创建函数（*嵌套*或*局部函数*）。

-   Similarly, Dart supports top-level *variables*, as well as variables
    tied to a class or object (static and instance variables). Instance
    variables are sometimes known as fields or properties.

    类似地， Dart 支持顶级*变量* ，
    同样变量绑定在类或对象上（静态变量和实例变量）。
    实例变量有时称为字段或属性。

-   Unlike Java, Dart doesn’t have the keywords `public`, `protected`,
    and `private`. If an identifier starts with an underscore (\_), it’s
    private to its library. For details, see
    [Libraries and visibility](#libraries-and-visibility).

    与 Java 不同，Dart 没有关键字 `public`， `protected` 和 `private`。
    如果标识符以下划线（\_）开头，则它相对于库是私有的。
    有关更多信息，参考 [库和可见性](#libraries-and-visibility)。

-   *Identifiers* can start with a letter or underscore (\_), followed by any
    combination of those characters plus digits.

    *标识符* 以字母或下划线（\_）开头，后跟任意字母和数字组合。

-   Dart has both *expressions* (which have runtime values) and
    *statements* (which don't).
    For example, the [conditional expression](#conditional-expressions)
    `condition ? expr1 : expr2` has a value of `expr1` or `expr2`.
    Compare that to an [if-else statement](#if-and-else), which has no value.
    A statement often contains one or more expressions,
    but an expression can't directly contain a statement.

    Dart 语法中包含*表达式（expressions）*（有运行时值）和*语句（ statements）*（没有运行时值）。
    例如，[条件表达式](#conditional-expressions)
    `condition ? expr1 : expr2` 的值可能是 `expr1` 或 `expr2` 。
    将其与 [if-else 语句](#if-和-else) 相比较，if-else 语句没有值。
    一条语句通常包含一个或多个表达式，相反表达式不能直接包含语句。

-   Dart tools can report two kinds of problems: _warnings_ and _errors_.
    Warnings are just indications that your code might not work, but
    they don’t prevent your program from executing. Errors can be either
    compile-time or run-time. A compile-time error prevents the code
    from executing at all; a run-time error results in an
    [exception](#exceptions) being raised while the code executes.

    Dart 工具提示两种类型问题：_警告_和_错误_。
    警告只是表明代码可能无法正常工作，但不会阻止程序的执行。
    错误可能是编译时错误或者运行时错误。
    编译时错误会阻止代码的执行;
    运行时错误会导致代码在执行过程中引发 [异常]（#exception）。


## Keywords

## 关键字

The following table lists the words that the Dart language treats specially.

Dart 语言关键字列表。

{% assign ckw = '&nbsp;<sup title="contextual keyword" alt="contextual keyword">1</sup>' %}
{% assign bii = '&nbsp;<sup title="built-in-identifier" alt="built-in-identifier">2</sup>' %}
{% assign lrw = '&nbsp;<sup title="limited reserved word" alt="limited reserved word">3</sup>' %}
| [abstract][]{{bii}}   | [dynamic][]{{bii}}    | [implements][]{{bii}} | [show][]{{ckw}}   |
| [as][]{{bii}}         | [else][]              | [import][]{{bii}}     | [static][]{{bii}} |
| [assert][]            | [enum][]              | [in][]                | [super][]         |
| [async][]{{ckw}}      | [export][]{{bii}}     | [interface][]{{bii}}  | [switch][]        |
| [await][]{{lrw}}      | [extends][]           | [is][]                | [sync][]{{ckw}}   |
| [break][]             | [external][]{{bii}}   | [library][]{{bii}}    | [this][]          |
| [case][]              | [factory][]{{bii}}    | [mixin][]{{bii}}      | [throw][]         |
| [catch][]             | [false][]             | [new][]               | [true][]          |
| [class][]             | [final][]             | [null][]              | [try][]           |
| [const][]             | [finally][]           | [on][]{{ckw}}         | [typedef][]{{bii}}|
| [continue][]          | [for][]               | [operator][]{{bii}}   | [var][]           |
| [covariant][]{{bii}}  | [Function][]{{bii}}   | [part][]{{bii}}       | [void][]          |
| [default][]           | [get][]{{bii}}        | [rethrow][]           | [while][]         |
| [deferred][]{{bii}}   | [hide][]{{ckw}}       | [return][]            | [with][]          |
| [do][]                | [if][]                | [set][]{{bii}}        | [yield][]{{lrw}}  |
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

避免使用这些单词作为标识符。
但是，如有必要，标有上标的关键字可以用作标识符：

* Words with the superscript **1** are **contextual keywords**,
  which have meaning only in specific places.
  They're valid identifiers everywhere.

  带有 **1** 上标的单词为 **上下文关键字**，
  仅在特定位置具有含义。
  他们在任何地方都是有效的标识符。

* Words with the superscript **2** are **built-in identifiers**.
  To simplify the task of porting JavaScript code to Dart,
  these keywords are valid identifiers in most places,
  but they can't be used as class or type names, or as import prefixes.

  带有 **2** 上标的单词为 **内置标识符**，
  为了简化将 JavaScript 代码移植到 Dart 的工作，
  这些关键字在大多数地方都是有效的标识符，
  但它们不能用作类或类型名称，也不能用作 import 前缀。

* Words with the superscript **3** are newer, limited reserved words related to
  the [asynchrony support](#asynchrony-support) that was added
  after Dart's 1.0 release.
  You can't use `await` or `yield` as an identifier
  in any function body marked with `async`, `async*`, or `sync*`.

  带有 **3** 上标的单词是与 Dart 1.0 发布后添加的 [异步支持](#asynchrony-support) 相关的更新，作为限制类保留字。  
  不能在标记为 `async`，`async*` 或 `sync*` 的任何函数体中使用 `await` 或 `yield` 作为标识符。

All other words in the table are **reserved words**,
which can't be identifiers.

关键字表中的剩余单词都是**保留字**。
不能将保留字用作标识符。

## Variables

## 变量

Here’s an example of creating a variable and initializing it:

创建一个变量并进行初始化:

<?code-excerpt "misc/lib/language_tour/variables.dart (var-decl)"?>
{% prettify dart %}
var name = 'Bob';
{% endprettify %}

Variables store references. The variable called `name` contains a
reference to a `String` object with a value of “Bob”.

变量仅存储对象引用，这里的变量是 `name` 存储了一个 `String` 类型的对象引用。
“Bob” 是这个 `String` 类型对象的值。

The type of the `name` variable is inferred to be `String`,
but you can change that type by specifying it.
If an object isn't restricted to a single type,
specify the `Object` or `dynamic` type, following
[design guidelines][ObjectVsDynamic].

`name` 变量的类型被推断为 `String` 。
但是也可以通过指定类型的方式，来改变变量类型。
如果对象不限定为单个类型，可以指定为 `对象类型` 或 `动态类型`，
参考 [设计指南][ObjectVsDynamic]。

{% comment %}
**[PENDING: check on Object vs. dynamic guidance.]**
{% endcomment %}

<?code-excerpt "misc/lib/language_tour/variables.dart (type-decl)"?>
{% prettify dart %}
dynamic name = 'Bob';
{% endprettify %}

Another option is to explicitly declare the type that would be inferred:

另一种方式是显式声明可以推断出的类型：

<?code-excerpt "misc/lib/language_tour/variables.dart (static-types)"?>
{% prettify dart %}
String name = 'Bob';
{% endprettify %}

<div class="alert alert-info" markdown="1">
**Note:**

**提示：**

This page follows the
[style guide recommendation](/guides/language/effective-dart/design#types)
of using `var`, rather than type annotations, for local variables.

本页局部变量遵守
[风格建议指南](/guides/language/effective-dart/design#types)
使用 `var`。 没有使用指定类型的方式。
</div>

### Default value

### 默认值

Uninitialized variables have an initial value of `null`. Even variables
with numeric types are initially null, because numbers—like everything
else in Dart—are objects.

未初始化的变量默认值是 `null`。即使变量是数字
类型默认值也是 null，因为在 Dart 中一切都是对象，数字类型
也不例外。

<?code-excerpt "misc/test/language_tour/variables_test.dart (var-null-init)"?>
{% prettify dart %}
int lineCount;
assert(lineCount == null);
{% endprettify %}

<div class="alert alert-info" markdown="1">
**Note:**

**提示：**

Production code ignores the `assert()` call.
During development, on the other hand,
<code>assert(<em>condition</em>)</code> throws an exception if
_condition_ is false.
For details, see [Assert](#assert).

在生产环境的代码中 `assert()` 调用会被忽略。
反过来，在开发过程中,
在_条件_为 fasle 的情况下 <code>assert(<em>condition</em>)</code> 会抛出异常。
更多详情，参考 [Assert](#assert) 。
</div>


### Final and const

### Final 和 Const

If you never intend to change a variable, use `final` or `const`, either
instead of `var` or in addition to a type. A final variable can be set
only once; a const variable is a compile-time constant. (Const variables
are implicitly final.) A final top-level or class variable is initialized
the first time it's used.

使用过程中从来不会被修改的变量， 可以使用 `final` 或 `const`, 而不是 `var` 或者其他类型，
Final 变量的值只能被设置一次；
Const 变量在编译时就已经固定 (Const 变量
是隐式 Final 的类型.) 最高级 final 变量或类变量在第一次使用时被初始化。

<div class="alert alert-info" markdown="1">
**Note:**

**提示：**

Instance variables can be `final` but not `const`.
Final instance variables must be initialized before
the constructor body starts —
at the variable declaration, by a constructor parameter,
or in the constructor's [initializer list](#initializer-list).

实例变量可以是 `final` 类型但不能是 `const` 类型。
必须在构造函数体执行之前初始化 final 实例变量 ——
在变量声明中，参数构造函数中或构造函数的[初始化列表](#initializer-list)中进行初始化。
</div>

Here's an example of creating and setting a final variable:

创建和设置一个 Final 变量：

<?code-excerpt "misc/lib/language_tour/variables.dart (final)"?>
{% prettify dart %}
final name = 'Bob'; // Without a type annotation
final String nickname = 'Bobby';
{% endprettify %}

You can't change the value of a final variable:

final 不能被修改:

{:.fails-sa}
<?code-excerpt "misc/lib/language_tour/variables.dart (cant-assign-to-final)"?>
{% prettify dart %}
name = 'Alice'; // Error: a final variable can only be set once.
{% endprettify %}

Use `const` for variables that you want to be **compile-time constants**. If
the const variable is at the class level, mark it `static const`.
Where you declare the variable, set the value to a compile-time constant
such as a number or string literal, a const
variable, or the result of an arithmetic operation on constant numbers:

如果需要在**编译时**就固定变量的值，可以使用 `const` 类型变量。
如果 Const 变量是类级别的，需要标记为 `static const`。
在这些地方可以使用在编译时就已经固定不变的值，字面量的数字和字符串，
固定的变量，或者是用于计算的固定数字：

<?code-excerpt "misc/lib/language_tour/variables.dart (const)"?>
{% prettify dart %}
const bar = 1000000; // Unit of pressure (dynes/cm2)
const double atm = 1.01325 * bar; // Standard atmosphere
{% endprettify %}

The `const` keyword isn't just for declaring constant variables.
You can also use it to create constant _values_,
as well as to declare constructors that _create_ constant values.
Any variable can have a constant value.

`const` 关键字不仅可以用于声明常量变量。
还可以用来创建 _常量值_，以及声明 _创建_ 常量值的构造函数。
任何变量都可以拥有常量值。

<?code-excerpt "misc/lib/language_tour/variables.dart (const-vs-final)"?>
{% prettify dart %}
var foo = const [];
final bar = const [];
const baz = []; // Equivalent to `const []`
{% endprettify %}

You can omit `const` from the initializing expression of a `const` declaration,
like for `baz` above. For details, see [DON’T use const redundantly][].

声明 `const` 的初始化表达式中 `const` 可以被省略。
比如上面的 `baz`。 有关更多信息，参考 [DON’T use const redundantly][]。

You can change the value of a non-final, non-const variable,
even if it used to have a const value:

非 Final ， 非 const 的变量是可以被修改的，即使这些变量
曾经引用过 const 值：

<?code-excerpt "misc/lib/language_tour/variables.dart (reassign-to-non-final)"?>
{% prettify dart %}
foo = [1, 2, 3]; // Was const []
{% endprettify %}

You can't change the value of a const variable:

Const 变量的值不可以修改：

{:.fails-sa}
<?code-excerpt "misc/lib/language_tour/variables.dart (cant-assign-to-const)"?>
{% prettify dart %}
baz = [42]; // Error: Constant variables can't be assigned a value.
{% endprettify %}

For more information on using `const` to create constant values, see
[Lists](#lists), [Maps](#maps), and [Classes](#classes).

更多关于使用 `const` 创建常量值，参考
[Lists](#lists)， [Maps](#maps)， 和 [Classes](#classes)。

## Built-in types

## 内建类型

The Dart language has special support for the following types:

Dart 语言支持以下内建类型：

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

这些类型都可以被初始化为字面量。
例如, `'this is a string'` 是一个字符串的字面量，
`true` 是一个布尔的字面量。

{% comment %}
PENDING: add info about support for Iterable, Future, Stream?
Those can't be initialized using literals, but they do have special support.
{% endcomment %}

Because every variable in Dart refers to an object—an instance of a
*class*—you can usually use *constructors* to initialize variables. Some
of the built-in types have their own constructors. For example, you can
use the `Map()` constructor to create a map.

因为在 Dart 所有的变量终究是一个对象（一个类的实例），
所以变量可以使用 *构造涵数* 进行初始化。
一些内建类型拥有自己的构造函数。
例如， 通过 `Map()` 来构造一个 map 变量。


### Numbers

Dart numbers come in two flavors:

Dart 语言的 Number 有两种类型:

[int][]

:   Integer values no larger than 64 bits,
    depending on the platform.
    On the Dart VM, values can be from
    -2<sup>63</sup> to 2<sup>63</sup> - 1.
    Dart that's compiled to JavaScript uses
    [JavaScript numbers,][js numbers]
    allowing values from -2<sup>53</sup> to 2<sup>53</sup> - 1.

    整数值不大于64位，
    具体取决于平台。
    在 Dart VM 上， 值的范围从
    -2<sup>63</sup> 到 2<sup>63</sup> - 1。
    Dart 被编译为 JavaScript 时，使用
    [JavaScript numbers,][js numbers]
    值的范围从 -2<sup>53</sup> 到 2<sup>53</sup> - 1。

{% comment %}
[PENDING: What about values on Android & iOS?
The informal spec is at
https://github.com/dart-lang/sdk/blob/master/docs/language/informal/int64.md.
{% endcomment %}

[double][]

:   64-bit (double-precision) floating-point numbers, as specified by
    the IEEE 754 standard.

    64位（双精度）浮点数，依据 IEEE 754 标准。


Both `int` and `double` are subtypes of [`num`.][num]
The num type includes basic operators such as +, -, /, and \*,
and is also where you’ll find `abs()`,` ceil()`,
and `floor()`, among other methods.
(Bitwise operators, such as \>\>, are defined in the `int` class.)
If num and its subtypes don’t have what you’re looking for, the
[dart:math][] library might.

`int` 和 `double` 都是 [`num`.][num] 的亚类型。
num 类型包括基本运算 +， -， /， 和 \*，
以及 `abs()`，` ceil()`，
和 `floor()`， 等函数方法。
（按位运算符，例如>>，定义在 int 类中。）
如果 num 及其亚类型找不到你想要的方法，
尝试查找使用 [dart:math][] 库。

Integers are numbers without a decimal point. Here are some examples of
defining integer literals:

整数类型不包含小数点。
下面是定义整数类型字面量的例子:

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (integer-literals)"?>
{% prettify dart %}
var x = 1;
var hex = 0xDEADBEEF;
{% endprettify %}

If a number includes a decimal, it is a double. Here are some examples
of defining double literals:

如果一个数字包含小数点，那么就是小数类型。
下面是定义小数类型字面量的例子:

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (double-literals)"?>
{% prettify dart %}
var y = 1.1;
var exponents = 1.42e5;
{% endprettify %}

As of Dart 2.1, integer literals are automatically converted to doubles
when necessary:

从 Dart 2.1 开始，必要的时候 int 字面量会自动转换成 double 类型。

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (int-to-double)"?>
{% prettify dart %}
double z = 1; // Equivalent to double z = 1.0.
{% endprettify %}

<aside class="alert alert-info" markdown="1">
  **Version note:**

  **版本提示：**

  Before Dart 2.1, it was an error to use an integer literal
  in a double context.

  在 2.1 之前，在 double 上下文中使用 int 字面量是错误的。
</aside>

Here’s how you turn a string into a number, or vice versa:

以下是将字符串转换为数字的方法，反之亦然：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (number-conversion)"?>
{% prettify dart %}
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
{% endprettify %}

The int type specifies the traditional bitwise shift (\<\<, \>\>), AND
(&), and OR (|) operators. For example:

int 特有的传统按位运算操作，移位（\<\<， \>\>），按位与（&）以及 按位或（|）。
例如：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (bit-shifting)"?>
{% prettify dart %}
assert((3 << 1) == 6); // 0011 << 1 == 0110
assert((3 >> 1) == 1); // 0011 >> 1 == 0001
assert((3 | 4) == 7); // 0011 | 0100 == 0111
{% endprettify %}

Literal numbers are compile-time constants.
Many arithmetic expressions are also compile-time constants,
as long as their operands are
compile-time constants that evaluate to numbers.

数字类型字面量是编译时常量。
在算术表达式中，只要参与计算的因子是编译时常量，
那么算术表达式的结果也是编译时常量。

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (const-num)"?>
{% prettify dart %}
const msPerSecond = 1000;
const secondsUntilRetry = 5;
const msUntilRetry = secondsUntilRetry * msPerSecond;
{% endprettify %}


### Strings

A Dart string is a sequence of UTF-16 code units. You can use either
single or double quotes to create a string:

Dart 字符串是一组 UTF-16 单元序列。
字符串通过单引号或者双引号创建。

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (quoting)"?>
{% prettify dart %}
var s1 = 'Single quotes work well for string literals.';
var s2 = "Double quotes work just as well.";
var s3 = 'It\'s easy to escape the string delimiter.';
var s4 = "It's even easier to use the other delimiter.";
{% endprettify %}

You can put the value of an expression inside a string by using
`${`*`expression`*`}`. If the expression is an identifier, you can skip
the {}. To get the string corresponding to an object, Dart calls the
object’s `toString()` method.

字符串可以通过 `${`*`expression`*`}` 的方式内嵌表达式。
如果表达式是一个标识符，则 {} 可以省略。
在 Dart 中通过调用就对象的 `toString()` 方法来得到对象相应的字符串。

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (string-interpolation)"?>
{% prettify dart %}
var s = 'string interpolation';

assert('Dart has $s, which is very handy.' ==
    'Dart has string interpolation, ' +
        'which is very handy.');
assert('That deserves all caps. ' +
        '${s.toUpperCase()} is very handy!' ==
    'That deserves all caps. ' +
        'STRING INTERPOLATION is very handy!');
{% endprettify %}

<div class="alert alert-info" markdown="1">
**Note:**

**提示：**

The `==` operator tests whether two objects are equivalent. Two
strings are equivalent if they contain the same sequence of code
units.

`==` 运算符用来测试两个对象是否相等。
在字符串中，如果两个字符串包含了相同的编码序列，那么这两个字符串相等。
units。
</div>

You can concatenate strings using adjacent string literals or the `+`
operator:

可以使用 `+` 运算符来把多个字符串连接为一个，也可以把多个字面量字符串写在一起来实现字符串连接：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (adjacent-string-literals)"?>
{% prettify dart %}
var s1 = 'String '
    'concatenation'
    " works even over line breaks.";
assert(s1 ==
    'String concatenation works even over '
        'line breaks.');

var s2 = 'The + operator ' + 'works, as well.';
assert(s2 == 'The + operator works, as well.');
{% endprettify %}

Another way to create a multi-line string: use a triple quote with
either single or double quotation marks:

使用连续三个单引号或者三个双引号实现多行字符串对象的创建：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (triple-quotes)"?>
{% prettify dart %}
var s1 = '''
You can create
multi-line strings like this one.
''';

var s2 = """This is also a
multi-line string.""";
{% endprettify %}

You can create a “raw” string by prefixing it with `r`:

使用 `r` 前缀，可以创建 “原始 raw” 字符串：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (raw-strings)"?>
{% prettify dart %}
var s = r'In a raw string, not even \n gets special treatment.';
{% endprettify %}

See [Runes](#runes) for details on how to express Unicode
characters in a string.

参考 [Runes](#runes) 来了解如何在字符串中表达 Unicode
字符。

Literal strings are compile-time constants,
as long as any interpolated expression is a compile-time constant
that evaluates to null or a numeric, string, or boolean value.

一个编译时常量的字面量字符串中，如果存在插值表达式，表达式内容也是编译时常量，
那么该字符串依旧是编译时常量。
插入的常量值类型可以是 null，数值，字符串或布尔值。

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (string-literals)"?>
{% prettify dart %}
// These work in a const string.
const aConstNum = 0;
const aConstBool = true;
const aConstString = 'a constant string';

// These do NOT work in a const string.
var aNum = 0;
var aBool = true;
var aString = 'a string';
const aConstList = [1, 2, 3];

const validConstString = '$aConstNum $aConstBool $aConstString';
// const invalidConstString = '$aNum $aBool $aString $aConstList';
{% endprettify %}

For more information on using strings, see
[Strings and regular expressions](/guides/libraries/library-tour#strings-and-regular-expressions).

更多关于 string 的使用, 参考
[字符串和正则表达式](/guides/libraries/library-tour#strings-and-regular-expressions)。


### Booleans

To represent boolean values, Dart has a type named `bool`. Only two
objects have type bool: the boolean literals `true` and `false`,
which are both compile-time constants.

Dart 使用 `bool` 类型表示布尔值。
Dart 只有字面量 `true` and `false` 是布尔类型，
这两个对象都是编译时常量。

Dart's type safety means that you can't use code like
<code>if (<em>nonbooleanValue</em>)</code> or
<code>assert (<em>nonbooleanValue</em>)</code>.
Instead, explicitly check for values, like this:

Dart 的类型安全意味着不能使用
<code>if (<em>nonbooleanValue</em>)</code> 或者
<code>assert (<em>nonbooleanValue</em>)</code>。
而是应该像下面这样，明确的进行值检查：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (no-truthy)"?>
{% prettify dart %}
// Check for an empty string.
var fullName = '';
assert(fullName.isEmpty);

// Check for zero.
var hitPoints = 0;
assert(hitPoints <= 0);

// Check for null.
var unicorn;
assert(unicorn == null);

// Check for NaN.
var iMeantToDoThis = 0 / 0;
assert(iMeantToDoThis.isNaN);
{% endprettify %}


### Lists

Perhaps the most common collection in nearly every programming language
is the *array*, or ordered group of objects. In Dart, arrays are
[List][] objects, so most people just call them *lists*.

几乎每种编程语言中最常见的集合可能是 *array* 或有序的对象集合。
在 Dart 中的 *array* 就是 [List][] 对象，
通常称之为 *lists*。

Dart list literals look like JavaScript array literals. Here’s a simple
Dart list:

Dart 中的 List 字面量非常像 JavaScript 中的 array 字面量。
下面是一个 Dart List 的示例：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (list-literal)"?>
{% prettify dart %}
var list = [1, 2, 3];
{% endprettify %}

<aside class="alert alert-info" markdown="1">
  **Note:**

  **提示：**

  Dart infers that `list` has type `List<int>`.
  If you try to add non-integer objects to this list,
  the analyzer or runtime raises an error.
  For more information, read about
  [type inference.](/guides/language/sound-dart#type-inference)

  Dart 推断 `list` 的类型为 `List<int>` 。
  如果尝试将非整数对象添加到此 List 中，
  则分析器或运行时会引发错误。
  有关更多信息，请阅读
  [类型推断。](/guides/language/sound-dart#type-inference)
</aside>

Lists use zero-based indexing, where 0 is the index of the first element
and `list.length - 1` is the index of the last element. You can get a
list’s length and refer to list elements just as you would in
JavaScript:

Lists 的下标索引从 0 开始，第一个元素的索引是 0。`list.length - 1` 是最后一个元素的索引。
访问 List 的长度和元素与 JavaScript 中的用法一样：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (list-indexing)"?>
{% prettify dart %}
var list = [1, 2, 3];
assert(list.length == 3);
assert(list[1] == 2);

list[1] = 1;
assert(list[1] == 1);
{% endprettify %}

To create a list that's a compile-time constant,
add `const` before the list literal:

在 List 字面量之前添加 `const` 关键字，可以定义 List 类型的编译时常量：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (const-list)"?>
{% prettify dart %}
var constantList = const [1, 2, 3];
// constantList[1] = 1; // Uncommenting this causes an error.
{% endprettify %}

<a id="spread-operator"> </a>
Dart 2.3 introduced the **spread operator** (`...`) and the
**null-aware spread operator** (`...?`),
which provide a concise way to insert multiple elements into a collection.

Dart 在 2.3 引入了 **Spread 操作符** (`...`) 和
**null-aware Spread 操作符** (`...?`)，
它提供了一种将多个元素插入集合的简洁方法。

For example, you can use the spread operator (`...`) to insert
all the elements of a list into another list:

例如，你可以使用 Spread 操作符 (`...`) 将一个 List 中的所有元素插入到
另一个 List 中：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (list-spread)"?>
{% prettify dart %}
var list = [1, 2, 3];
var list2 = [0, ...list];
assert(list2.length == 4);
{% endprettify %}

If the expression to the right of the spread operator might be null,
you can avoid exceptions by using a null-aware spread operator (`...?`):

如果 Spread 操作符右边可能为 null ，你可以使用 null-aware Spread 操作符 (`...?`) 来避免产生异常：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (list-null-spread)"?>
{% prettify dart %}
var list;
var list2 = [0, ...?list];
assert(list2.length == 1);
{% endprettify %}

For more details and examples of using the spread operator, see the
[spread operator proposal.][spread proposal]

更多 Spread 操作符的内容和使用示例，参见 [Spread 操作符提案。][spread proposal]

<a id="collection-operators"> </a>
Dart 2.3 also introduced **collection if** and **collection for**,
which you can use to build collections using conditionals (`if`)
and repetition (`for`).

Dart 在 2.3 还同时引入了 **Collection If** 和 **Collection For**，
在构建集合时，可以使用条件判断 (`if`) 和循环 (`for`) 。

Here's an example of using **collection if**
to create a list with three or four items in it:

下面示例是使用 **Collection If** 来创建一个 List ， 它可能包含
3 个或 4 个元素：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (list-if)"?>
{% prettify dart %}
var nav = [
  'Home',
  'Furniture',
  'Plants',
  if (promoActive) 'Outlet'
];
{% endprettify %}

Here's an example of using **collection for**
to manipulate the items of a list before
adding them to another list:

下面示例是使用 **Collection For** 将列表中的元素修改后添加到另一个列表中：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (list-for)"?>
{% prettify dart %}
var listOfInts = [1, 2, 3];
var listOfStrings = [
  '#0',
  for (var i in listOfInts) '#$i'
];
assert(listOfStrings[1] == '#1');
{% endprettify %}

For more details and examples of using collection if and for, see the
[control flow collections proposal.][collections proposal]

更多 **Collection If** 和 **Collection For** 的内容和使用示例，参阅
[集合的流控制提案。][collections proposal]

[collections proposal]: https://github.com/dart-lang/language/blob/master/accepted/2.3/control-flow-collections/feature-specification.md

[spread proposal]: https://github.com/dart-lang/language/blob/master/accepted/2.3/spread-collections/feature-specification.md

The List type has many handy methods for manipulating lists. For more
information about lists, see [Generics](#generics) and
[Collections](/guides/libraries/library-tour#collections).

List 类型包含了很多 List 的操作函数。
更多信息参考 [泛型](#generics) 和
[集合](/guides/libraries/library-tour#collections).


### Sets

A set in Dart is an unordered collection of unique items.
Dart support for sets is provided by set literals and the [Set][] type.

在 Dart 中 Set 是一个元素唯一且无需的集合。
Dart 为 Set 提供了 Set 字面量和 [Set][] 类型。

<aside class="alert alert-info" markdown="1">
  **Version note:** Although the Set _type_ has always been a core part of Dart,
  set _literals_ were introduced in Dart 2.2.

  **版本提示：** 虽然 Set _类型_ 一直是 Dart 的核心部分，
  但在 Dart2.2 中才引入了 Set _字面量_ 。
</aside>

Here is a simple Dart set, created using a set literal:

下面是通过字面量创建 Set 的一个简单示例：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (set-literal)"?>
{% prettify dart %}
var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'};
{% endprettify %}

<aside class="alert alert-info" markdown="1">
  **Note:**

  **注意:**

  Dart infers that `halogens` has the type
  `Set<String>`. If you try to add the wrong type of value
  to the set, the analyzer or runtime raises an error.
  For more information, read about
  [type inference.](/guides/language/sound-dart#type-inference)

  Dart 推断 `halogens` 类型为 `Set<String>` 。如果尝试为它添加一个错误类型的值，分析器或执行时会抛出错误。
  更多内容，参阅 [类型推断](/guides/language/sound-dart#type-inference)。
</aside>

To create an empty set, use `{}` preceded by a type argument,
or assign `{}` to a variable of type `Set`:

要创建一个空集，使用前面带有类型参数的 `{}` ，或者将 `{}` 赋值给 `Set` 类型的变量：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (set-vs-map)"?>
{% prettify dart %}
var names = <String>{};
// Set<String> names = {}; // This works, too.
// var names = {}; // Creates a map, not a set.
{% endprettify %}

<aside class="alert alert-info" markdown="1">
  **Set or map?**

  **是 Set 还是 Map ？**

  The syntax for map literals is similar to that for set literals.
  Because map literals came first, `{}` defaults to the `Map` type.
  If you forget the type annotation on `{}` or the variable it's assigned to,
  then Dart creates an object of type `Map<dynamic, dynamic>`.

  Map 字面量语法同 Set 字面量语法非常相似。
  因为先有的 Map 字母量语法，所以 `{}` 默认是 `Map` 类型。
  如果忘记在 `{}` 上注释类型或赋值到一个未声明类型的变量上，
  那么 Dart 会创建一个类型为 `Map<dynamic, dynamic>` 的对象。
</aside>

Add items to an existing set using the `add()` or `addAll()` methods:

使用 `add()` 或 `addAll()` 为已有的 Set 添加元素：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (set-add-items)"?>
{% prettify dart %}
var elements = <String>{};
elements.add('fluorine');
elements.addAll(halogens);
{% endprettify %}

Use `.length` to get the number of items in the set:

使用 `.length` 来获取 Set 中元素的个数：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (set-length)"?>
{% prettify dart %}
var elements = <String>{};
elements.add('fluorine');
elements.addAll(halogens);
assert(elements.length == 5);
{% endprettify %}

To create a set that's a compile-time constant,
add `const` before the set literal:

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (const-set)"?>
{% prettify dart %}
final constantSet = const {
  'fluorine',
  'chlorine',
  'bromine',
  'iodine',
  'astatine',
};
// constantSet.add('helium'); // Uncommenting this causes an error.
{% endprettify %}

As of Dart 2.3, sets support spread operators (`...` and `...?`)
and collection ifs and fors,
just like lists do.
For more information, see the
[list spread operator](#spread-operator) and
[list collection operator](#collection-operators) discussions.

在 Dart 2.3 中，Set 支持 Spread 操作符 (`...` and `...?`) 和
Collection If 和 Collection For ,就像 List 一样。
更多内容，参阅
[list spread operator](#spread-operator) 和
[list collection operator](#collection-operators) 相关讨论。

For more information about sets, see
[Generics](#generics) and
[Sets](/guides/libraries/library-tour#sets).

更多关于 Set 的内容，参阅
[Generic](#generics) 及
[Set](/guides/libraries/library-tour#sets)。

### Maps

In general, a map is an object that associates keys and values. Both
keys and values can be any type of object. Each *key* occurs only once,
but you can use the same *value* multiple times. Dart support for maps
is provided by map literals and the [Map][] type.

通常来说， Map 是用来关联 keys 和 values 的对象。
keys 和 values 可以是任何类型的对象。在一个 Map 对象中一个 *key* 只能出现一次。
但是 *value* 可以出现多次。 Dart 中 Map 通过 Map 字面量 和 [Map][] 类型来实现。

Here are a couple of simple Dart maps, created using map literals:

下面是使用 Map 字面量的两个简单例子：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (map-literal)"?>
{% prettify dart %}
var gifts = {
  // Key:    Value
  'first': 'partridge',
  'second': 'turtledoves',
  'fifth': 'golden rings'
};

var nobleGases = {
  2: 'helium',
  10: 'neon',
  18: 'argon',
};
{% endprettify %}

<aside class="alert alert-info" markdown="1">
  **Note:**

  **提示：**

  Dart infers that `gifts` has the type
  `Map<String, String>` and `nobleGases` has the type
  `Map<int, String>`. If you try to add the wrong type of value
  to either map, the analyzer or runtime raises an error.
  For more information, read about
  [type inference.](/guides/language/sound-dart#type-inference)

  Dart 会将 `gifts` 的类型推断为 `Map<String, String>`，
  `nobleGases` 的类型推断为 `Map<int, String>` 。
  如果尝试在上面的 map 中添加错误类型，那么分析器或者运行时会引发错误。
  有关更多信息，请阅读[类型推断。](/guides/language/sound-dart#type-inference)。
</aside>

You can create the same objects using a Map constructor:

以上 Map 对象也可以使用 Map 构造函数创建：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (map-constructor)"?>
{% prettify dart %}
var gifts = Map();
gifts['first'] = 'partridge';
gifts['second'] = 'turtledoves';
gifts['fifth'] = 'golden rings';

var nobleGases = Map();
nobleGases[2] = 'helium';
nobleGases[10] = 'neon';
nobleGases[18] = 'argon';
{% endprettify %}

<aside class="alert alert-info" markdown="1">
**Note:**

**提示:**

You might expect to see `new Map()` instead of just `Map()`.
As of Dart 2, the `new` keyword is optional.
For details, see [Using constructors](#using-constructors).

这里为什么只有 `Map()` ，而不是使用 `new Map()`。
因为在 Dart 2 中，`new` 关键字是可选的。
有关更多信息，参考 [构造函数的使用](#using-constructors)。
</aside>

Add a new key-value pair to an existing map just as you would in
JavaScript:

类似 JavaScript ，添加 key-value 对到已有的 Map 中：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (map-add-item)"?>
{% prettify dart %}
var gifts = {'first': 'partridge'};
gifts['fourth'] = 'calling birds'; // Add a key-value pair
{% endprettify %}

Retrieve a value from a map the same way you would in JavaScript:

类似 JavaScript ，从一个 Map 中获取一个 value：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (map-retrieve-item)"?>
{% prettify dart %}
var gifts = {'first': 'partridge'};
assert(gifts['first'] == 'partridge');
{% endprettify %}

If you look for a key that isn’t in a map, you get a null in return:

如果 Map 中不包含所要查找的 key，那么 Map 返回 null：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (map-missing-key)"?>
{% prettify dart %}
var gifts = {'first': 'partridge'};
assert(gifts['fifth'] == null);
{% endprettify %}

Use `.length` to get the number of key-value pairs in the map:

使用 `.length` 函数获取当前 Map 中的 key-value 对数量：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (map-length)"?>
{% prettify dart %}
var gifts = {'first': 'partridge'};
gifts['fourth'] = 'calling birds';
assert(gifts.length == 2);
{% endprettify %}

To create a map that's a compile-time constant,
add `const` before the map literal:

创建 Map 类型运行时常量，要在 Map 字面量前加上关键字 `const`。

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (const-map)"?>
{% prettify dart %}
final constantMap = const {
  2: 'helium',
  10: 'neon',
  18: 'argon',
};

// constantMap[2] = 'Helium'; // Uncommenting this causes an error.
{% endprettify %}

As of Dart 2.3, maps support spread operators (`...` and `...?`)
and collection if and for, just like lists do.
For details and examples, see the
[spread operator proposal][spread proposal] and the
[control flow collections proposal.][collections proposal]

在 Dart 2.3 中，Map 支持 Spread 操作符 (`...` and `...?`) 和
Collection If 和 Collection For ,就像 List 一样。
更多内容和示例，参阅
[list spread operator][spread proposal] 和
[list collection operator][collections proposal] 相关讨论。

For more information about maps, see
[Generics](#generics) and
[Maps](/guides/libraries/library-tour#maps).

更名多关于 Map 的内容，参考
[Generics](#generics) and
[Maps](/guides/libraries/library-tour#maps)。

### Runes

In Dart, runes are the UTF-32 code points of a string.

在 Dart 中， Rune 用来表示字符串中的 UTF-32 编码字符。

Unicode defines a unique numeric value for each letter, digit,
and symbol used in all of the world's writing systems.
Because a Dart string is a sequence of UTF-16 code units,
expressing 32-bit Unicode values within a string requires
special syntax.

Unicode 定义了一个全球的书写系统编码，
系统中使用的所有字母，数字和符号都对应唯一的数值编码。
由于 Dart 字符串是一系列 UTF-16 编码单元，
因此要在字符串中表示32位 Unicode 值需要特殊语法支持。

The usual way to express a Unicode code point is
`\uXXXX`, where XXXX is a 4-digit hexadecimal value.
For example, the heart character (♥) is `\u2665`.
To specify more or less than 4 hex digits,
place the value in curly brackets.
For example, the laughing emoji (😆) is `\u{1f600}`.

表示 Unicode 编码的常用方法是，
`\uXXXX`, 这里 XXXX 是一个4位的16进制数。
例如，心形符号 (♥) 是 `\u2665`。
对于特殊的非 4 个数值的情况，
把编码值放到大括号中即可。
例如，emoji 的笑脸(😆) 是 `\u{1f600}`。

The [String][]
class has several properties you can use to extract rune information.
The `codeUnitAt` and `codeUnit` properties return 16-bit code
units. Use the `runes` property to get the runes of a string.

[String][] 类有一些属性可以获得 rune 数据。
属性 `codeUnitAt` 和 `codeUnit` 返回16位编码数据。
属性 `runes` 获取字符串中的 Rune 。

The following example illustrates the relationship between runes,
16-bit code units, and 32-bit code points.
Click the run button {% asset red-run.png alt="" %}
to see runes in action.

下面是示例演示了 Rune 、 16-bit code units、
和 32-bit code points 之间的关系。
点击运行按钮 {% asset red-run.png alt="" %}
查看 runes 结果。

{% comment %}
https://gist.github.com/589bc5c95318696cefe5
{{site.dartpad}}/589bc5c95318696cefe5
Unicode emoji: http://unicode.org/emoji/charts/full-emoji-list.html

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (runes)"?>
{% prettify dart %}
void main() {
  var clapping = '\u{1f44f}';
  print(clapping);
  print(clapping.codeUnits);
  print(clapping.runes.toList());

  Runes input =
      Runes('\u2665  \u{1f605}  \u{1f60e}  \u{1f47b}  \u{1f596}  \u{1f44d}');
  print(String.fromCharCodes(input));
}
{% endprettify %}
{% endcomment %}

<iframe
src="{{site.custom.dartpad.embed-inline-prefix}}?id=589bc5c95318696cefe5&verticalRatio=65"
    width="100%"
    height="333px"
    style="border: 1px solid #ccc;">
</iframe>

<div class="alert alert-warning" markdown="1">
**Note:**

**提示：**

Be careful when manipulating runes using list operations.
This approach can easily break down,
depending on the particular language, character set, and operation.
For more information, see
[How do I reverse a String in Dart?](http://stackoverflow.com/questions/21521729/how-do-i-reverse-a-string-in-dart) on Stack Overflow.

谨慎使用 list 方式操作 Rune 。
这种方法很容易引发崩溃，
具体原因取决于特定的语言，字符集和操作。
有关更多信息，参考
[How do I reverse a String in Dart?](http://stackoverflow.com/questions/21521729/how-do-i-reverse-a-string-in-dart) on Stack Overflow.
</div>

### Symbols

A [Symbol][] object
represents an operator or identifier declared in a Dart program. You
might never need to use symbols, but they're invaluable for APIs that
refer to identifiers by name, because minification changes identifier
names but not identifier symbols.

一个 Symbol 对象表示 Dart 程序中声明的运算符或者标识符。
你也许永远都不需要使用 Symbol ，但要按名称引用标识符的 API 时， Symbol 就非常有用了。因为代码压缩后会改变标识符的名称，但不会改变标识符的符号。

To get the symbol for an identifier, use a symbol literal, which is just
`#` followed by the identifier:

通过字面量 Symbol ，也就是标识符前面添加一个 `#` 号，来获取标识符的 Symbol：

```nocode
#radix
#bar
```

{% comment %}
The code from the following excerpt isn't actually what is being shown in the page

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (symbols)"?>
{% prettify dart %}
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
{% endprettify %}
{% endcomment %}

Symbol literals are compile-time constants.

Symbol 字面量是编译时常量。

## Functions

Dart is a true object-oriented language, so even functions are objects
and have a type, [Function.][Function API reference]
This means that functions can be assigned to variables or passed as arguments
to other functions. You can also call an instance of a Dart class as if
it were a function. For details, see [Callable classes](#callable-classes).

Dart 是一门真正面向对象的语言，
甚至其中的函数也是对象，并且有它的类型
[Function][Function API reference] 。
这也意味着函数可以被赋值给变量或者作为参数传递给其他函数。
也可以把 Dart 类的实例当做方法来调用。
有关更多信息，参考 [Callable classes](#callable-classes)。

Here’s an example of implementing a function:

已下是函数实现的示例：

<?code-excerpt "misc/lib/language_tour/functions.dart (function)"?>
{% prettify dart %}
bool isNoble(int atomicNumber) {
  return _nobleGases[atomicNumber] != null;
}
{% endprettify %}

Although Effective Dart recommends
[type annotations for public APIs](/guides/language/effective-dart/design#prefer-type-annotating-public-fields-and-top-level-variables-if-the-type-isnt-obvious),
the function still works if you omit the types:

虽然在 Effective Dart 中推荐
[公共API中声明类型](/guides/language/effective-dart/design#prefer-type-annotating-public-fields-and-top-level-variables-if-the-type-isnt-obvious),
但是省略了类型声明，函数依旧是可以正常使用的：

<?code-excerpt "misc/lib/language_tour/functions.dart (function-omitting-types)"?>
{% prettify dart %}
isNoble(atomicNumber) {
  return _nobleGases[atomicNumber] != null;
}
{% endprettify %}

For functions that contain just one expression, you can use a shorthand
syntax:

如果函数中只有一句表达式，可以使用简写语法：

<?code-excerpt "misc/lib/language_tour/functions.dart (function-shorthand)"?>
{% prettify dart %}
bool isNoble(int atomicNumber) => _nobleGases[atomicNumber] != null;
{% endprettify %}

The <code>=> <em>expr</em></code> syntax is a shorthand for
<code>{ return <em>expr</em>; }</code>. The `=>` notation
is sometimes referred to as _arrow_ syntax.

<<<<<<< HEAD
<code>=> <em>expr</em></code> 语法是
<code>{ return <em>expr</em>; }</code> 的简写。 `=>` 符号
有时也被称为 _箭头_ 语法。

<div class="alert alert-info" markdown="1">
**Note:**

**提示：**

Only an *expression*—not a *statement*—can appear between the arrow
(=\>) and the semicolon (;). For example, you can’t put an [if
statement](#if-and-else) there, but you can use a [conditional
expression](#conditional-expressions).

在箭头 (=\>) 和分号 (;) 之间只能使用一个 *表达式* ，不能是 *语句* 。
例如：不能使用 [if
语句](#if-和-else) ，但是可以是用
[条件表达式](#conditional-expressions).
</div>
=======
<aside class="alert alert-info" markdown="1">
  **Note:**
  Only an *expression*—not a *statement*—can appear between the arrow
  (=\>) and the semicolon (;). For example, you can’t put an [if
  statement](#if-and-else) there, but you can use a [conditional
  expression](#conditional-expressions).
</aside>
>>>>>>> f26718e0e9d8b8ecf13131688ad7d0ab11a6c3ec

A function can have two types of parameters: _required_ and _optional_.
The required parameters are listed first, followed by any optional parameters.
Optional parameters can be _named_ or _positional_.

<<<<<<< HEAD
函数有两种参数类型: required 和 optional。
required 类型参数在参数最前面， 随后是 optional 类型参数。
命名的可选参数也可以标记为 “@ required” 。
参考下一章节，了解更多细节。

### Optional parameters

### 可选参数

Optional parameters can be either positional or named, but not both.

可选参数可以是命名参数或者位置参数，但一个参数只能选择其中一种方式修饰。

#### Optional named parameters
=======
<aside class="alert alert-info" markdown="1">
  **Note:**
  Some APIs — notably [Flutter][] widget constructors —
  use only named parameters,
  even for parameters that are mandatory.
  See the next section for details.
</aside>

### Optional parameters

Optional parameters can be either named or positional, but not both.

#### Named parameters
>>>>>>> f26718e0e9d8b8ecf13131688ad7d0ab11a6c3ec

#### 命名可选参数

When calling a function, you can specify named parameters using
<code><em>paramName</em>: <em>value</em></code>. For example:

调用函数时，可以使用指定命名参数
<code><em>paramName</em>: <em>value</em></code>。 例如：

<?code-excerpt "misc/lib/language_tour/functions.dart (use-named-parameters)"?>
{% prettify dart %}
enableFlags(bold: true, hidden: false);
{% endprettify %}

When defining a function, use
<code>{<em>param1</em>, <em>param2</em>, …}</code>
to specify named parameters:

定义函数是，使用
<code>{<em>param1</em>, <em>param2</em>, …}</code>
来指定命名参数：

<?code-excerpt "misc/lib/language_tour/functions.dart (specify-named-parameters)"?>
{% prettify dart %}
/// Sets the [bold] and [hidden] flags ...
void enableFlags({bool bold, bool hidden}) {...}
{% endprettify %}

<<<<<<< HEAD
[Flutter][] instance creation expressions can get complex, so widget
constructors use named parameters exclusively. This makes instance creation
expressions easier to read.

[Flutter][] 创建实例的表达式可能很复杂，
因此窗口小部件构造函数仅使用命名参数。
这样创建实例的表达式更易于阅读。

You can annotate a named parameter in any Dart code (not just Flutter) with
[@required][] to indicate that it is a _required_ parameter. For example:
=======
Although named parameters are a kind of optional parameter,
you can annotate them with [@required][] to indicate
that the parameter is mandatory —
that users must provide a value for the parameter.
For example:
>>>>>>> f26718e0e9d8b8ecf13131688ad7d0ab11a6c3ec

使用 [@required][] 注释表示参数是 _required_ 性质的命名参数，
该方式可以在任何 Dart 代码中使用（不仅仅是Flutter）。

<?code-excerpt "misc/lib/language_tour/functions.dart (required-named-parameters)" replace="/@required/[!$&!]/g"?>
{% prettify dart %}
const Scrollbar({Key key, [!@required!] Widget child})
{% endprettify %}

If someone tries to create a `Scrollbar`
without specifying the `child` argument,
then the analyzer reports an issue.

<<<<<<< HEAD
此时 `Scrollbar` 是一个构造函数， 当 `child` 参数缺少时，分析器会提示错误。

[Required][@required] is defined in the [meta][] package. Either import
`package:meta/meta.dart` directly, or import another package that exports
`meta`, such as Flutter's `package:flutter/material.dart`.

[Required][@required] 被定义在 [meta][] package。 无论是直接引入（import）
`package:meta/meta.dart` ，或者引入了其他 package，而这个 package 输出（export）了
`meta`，比如 Flutter 的 `package:flutter/material.dart`。

#### Optional positional parameters
=======
To use the [@required][] annotation,
depend on the [meta][] package and import `package:meta/meta.dart`.

#### Positional parameters
>>>>>>> f26718e0e9d8b8ecf13131688ad7d0ab11a6c3ec

#### 位置可选参数

Wrapping a set of function parameters in `[]` marks them as optional
positional parameters:

将参数放到 `[]` 中来标记参数是可选的：

<?code-excerpt "misc/test/language_tour/functions_test.dart (optional-positional-parameters)"?>
{% prettify dart %}
String say(String from, String msg, [String device]) {
  var result = '$from says $msg';
  if (device != null) {
    result = '$result with a $device';
  }
  return result;
}
{% endprettify %}

Here’s an example of calling this function without the optional
parameter:

下面是不使用可选参数调用上面方法的示例：

<?code-excerpt "misc/test/language_tour/functions_test.dart (call-without-optional-param)"?>
{% prettify dart %}
assert(say('Bob', 'Howdy') == 'Bob says Howdy');
{% endprettify %}

And here’s an example of calling this function with the third parameter:

下面是使用可选参数调用上面方法的示例：

<?code-excerpt "misc/test/language_tour/functions_test.dart (call-with-optional-param)"?>
{% prettify dart %}
assert(say('Bob', 'Howdy', 'smoke signal') ==
    'Bob says Howdy with a smoke signal');
{% endprettify %}

<a id="default-parameters"></a>
#### Default parameter values

#### 默认参数值

Your function can use `=` to define default values for both named and positional
parameters. The default values must be compile-time constants.
If no default value is provided, the default value is `null`.

在定义方法的时候，可以使用 `=` 来定义可选参数的默认值。
默认值只能是编译时常量。
如果没有提供默认值，则默认值为 null。

Here's an example of setting default values for named parameters:

下面是设置可选参数默认值示例：

<?code-excerpt "misc/lib/language_tour/functions.dart (named-parameter-default-values)"?>
{% prettify dart %}
/// Sets the [bold] and [hidden] flags ...
void enableFlags({bool bold = false, bool hidden = false}) {...}

// bold will be true; hidden will be false.
enableFlags(bold: true);
{% endprettify %}

<div class="alert alert-info" markdown="1">
**Deprecation note:**

**不推荐：**

Old code might use a colon (`:`) instead of `=`
to set default values of named parameters.
The reason is that originally, only `:` was supported for named parameters.
That support might be deprecated,
so we recommend that you
<<<<<<< HEAD
**[use `=` to specify default values.](/tools/pub/pubspec#sdk-constraints)**

旧版本代码中可能使用的是冒号 (`:`) 而不是 `=`
来设置参数默认值。
原因是起初命名参数只支持 `:`。
这种支持可能会被弃用。
建议
**[使用 `=` 指定默认值。](/tools/pub/pubspec#sdk-constraints)**
=======
**[use `=` to specify default values.](/guides/language/effective-dart/usage#do-use--to-separate-a-named-parameter-from-its-default-value)**
>>>>>>> f26718e0e9d8b8ecf13131688ad7d0ab11a6c3ec
</div>

{% comment %}
PENDING: I don't see evidence that we've dropped support for `:`.
Update if/when we do. Issue #?
See `defaultNamedParameter` in the language spec.
{% endcomment %}

The next example shows how to set default values for positional parameters:

下面示例演示了如何为位置参数设置默认值：

<?code-excerpt "misc/test/language_tour/functions_test.dart (optional-positional-param-default)"?>
{% prettify dart %}
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
{% endprettify %}

You can also pass lists or maps as default values.
The following example defines a function, `doStuff()`,
that specifies a default list for the `list`
parameter and a default map for the `gifts` parameter.

list 或 map 可以作为默认值传递。
下面的示例定义了一个方法 `doStuff()`，
并分别指定参数 `list` 和 `gifts`
的默认值。

{% comment %}
The function is called three times with different values.
Click the run button {% asset red-run.png alt="" %}
to see list and map default values in action.
{% endcomment %}

<?code-excerpt "misc/lib/language_tour/functions.dart (list-map-default-function-param)"?>
{% prettify dart %}
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
{% endprettify %}

{% comment %}
https://gist.github.com/d988cfce0a54c6853799
{{site.dartpad}}/d988cfce0a54c6853799
(The gist needs updating: see https://github.com/dart-lang/site-www/issues/189)
<iframe
src="{{site.custom.dartpad.embed-inline-prefix}}?id=d988cfce0a54c6853799&verticalRatio=70"
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

任何应用都必须有一个顶级 `main()` 函数，作为应用服务的入口。
`main()` 函数返回值为空，参数为一个可选的 `List<String>` 。

Here's an example of the `main()` function for a web app:

下面是 web 应用的 `main()` 函数：

<?code-excerpt "misc/test/language_tour/browser_test.dart (simple-web-main-function)"?>
{% prettify dart %}
void main() {
  querySelector('#sample_text_id')
    ..text = 'Click me!'
    ..onClick.listen(reverseText);
}
{% endprettify %}

<div class="alert alert-info" markdown="1">
**Note:**

**提示：**

The `..` syntax in the preceding code is called a [cascade](#cascade-notation-).
With cascades,
you can perform multiple operations on the members of a single object.

以上代码中的 `..` 语法为 [级联调用](#cascade-notation-) （cascade）。
使用级联调用， 可以简化在一个对象上执行的多个操作。
</div>

Here's an example of the `main()` function for a command-line app that
takes arguments:

下面是一个命令行应用的 `main()` 方法，并且使用了输入参数：

<?code-excerpt "misc/test/language_tour/functions_test.dart (main-args)"?>
{% prettify dart %}
// Run the app like this: dart args.dart 1 test
void main(List<String> arguments) {
  print(arguments);

  assert(arguments.length == 2);
  assert(int.parse(arguments[0]) == 1);
  assert(arguments[1] == 'test');
}
{% endprettify %}

You can use the [args library]({{site.pub}}/packages/args) to
define and parse command-line arguments.

使用 [args library]({{site.pub}}/packages/args) 可以定义和解析命令行参数。

### Functions as first-class objects

### 函数是一等对象

You can pass a function as a parameter to another function. For example:

一个函数可以作为另一个函数的参数。 例如：

<?code-excerpt "misc/lib/language_tour/functions.dart (function-as-param)"?>
{% prettify dart %}
void printElement(int element) {
  print(element);
}

var list = [1, 2, 3];

// Pass printElement as a parameter.
list.forEach(printElement);
{% endprettify %}

You can also assign a function to a variable, such as:

同样可以将一个函数赋值给一个变量，例如：

<?code-excerpt "misc/test/language_tour/functions_test.dart (function-as-var)"?>
{% prettify dart %}
var loudify = (msg) => '!!! ${msg.toUpperCase()} !!!';
assert(loudify('hello') == '!!! HELLO !!!');
{% endprettify %}

This example uses an anonymous function.
More about those in the next section.

示例中使用了匿名函数。
下一章节会有更多介绍。

### Anonymous functions

### 匿名函数

Most functions are named, such as `main()` or `printElement()`.
You can also create a nameless function
called an _anonymous function_, or sometimes a _lambda_ or _closure_.
You might assign an anonymous function to a variable so that,
for example, you can add or remove it from a collection.

多数函数是有名字的， 比如 `main()` 和 `printElement()`。
也可以创建没有名字的函数，这种函数被称为 _匿名函数_，
有时候也被称为 _lambda_ 或者 _closure_ 。
匿名函数可以赋值到一个变量中，
举个例子，在一个集合中可以添加或者删除一个匿名函数。

An anonymous function looks similar to a named function&mdash;
zero or more parameters, separated by commas
and optional type annotations, between parentheses.

匿名函数和命名函数看起来类似&mdash;
在括号之间可以定义一些参数或可选参数，参数使用逗号分割。

The code block that follows contains the function's body:

后面大括号中的代码为函数体：

<code>
([[<em>Type</em>] <em>param1</em>[, …]]) { <br>
&nbsp;&nbsp;<em>codeBlock</em>; <br>
}; <br>
</code>

The following example defines an anonymous function with an untyped parameter, `item`.
The function, invoked for each item in the list,
prints a string that includes the value at the specified index.

下面例子中定义了一个包含一个无类型参数 `item` 的匿名函数。
list 中的每个元素都会调用这个函数，打印元素位置和值的字符串。

<?code-excerpt "misc/test/language_tour/functions_test.dart (anonymous-function)"?>
{% prettify dart %}
var list = ['apples', 'bananas', 'oranges'];
list.forEach((item) {
  print('${list.indexOf(item)}: $item');
});
{% endprettify %}

Click the run button {% asset red-run.png alt="" %} to execute the code.

点击运行按钮 {% asset red-run.png alt="" %} 执行代码。

{% comment %}
https://gist.github.com/chalin/5d70bc1889d055c7a18d35d77874af88
{{site.dartpad}}/5d70bc1889d055c7a18d35d77874af88
{% endcomment %}

<iframe
src="{{site.custom.dartpad.embed-inline-prefix}}?id=5d70bc1889d055c7a18d35d77874af88&verticalRatio=60"
    width="100%"
    height="250px"
    style="border: 1px solid #ccc;">
</iframe>

If the function contains only one statement, you can shorten it using
arrow notation. Paste the following line into DartPad
and click run to verify that it is functionally equivalent.

如果函数只有一条语句，
可以使用箭头简写。粘贴下面代码到 DartPad 中
并点击运行按钮，验证两个函数是等价性。

<?code-excerpt "misc/test/language_tour/functions_test.dart (anon-func)"?>
{% prettify dart %}
list.forEach(
    (item) => print('${list.indexOf(item)}: $item'));
{% endprettify %}


### Lexical scope

### 词法作用域

Dart is a lexically scoped language, which means that the scope of
variables is determined statically, simply by the layout of the code.
You can “follow the curly braces outwards” to see if a variable is in
scope.

Dart 是一门词法作用域的编程语言，就意味着变量的作用域是固定的，
简单说变量的作用域在编写代码的时候就已经确定了。
花括号内的是变量可见的作用域。

Here is an example of nested functions with variables at each scope
level:

下面示例关于多个嵌套函数的变量作用域：

<?code-excerpt "misc/test/language_tour/functions_test.dart (nested-functions)"?>
{% prettify dart %}
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
{% endprettify %}

Notice how `nestedFunction()` can use variables from every level, all
the way up to the top level.

注意 `nestedFunction()` 可以访问所有的变量，
一直到顶级作用域变量。

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

函数可以封闭定义到它作用域内的变量。 接下来的示例中，
`makeAdder()` 捕获了变量 `addBy`。
无论在什么时候执行返回函数，函数都会使用捕获的 `addBy` 变量。

<?code-excerpt "misc/test/language_tour/functions_test.dart (function-closure)"?>
{% prettify dart %}
/// Returns a function that adds [addBy] to the
/// function's argument.
Function makeAdder(num addBy) {
  return (num i) => addBy + i;
}

void main() {
  // Create a function that adds 2.
  var add2 = makeAdder(2);

  // Create a function that adds 4.
  var add4 = makeAdder(4);

  assert(add2(3) == 5);
  assert(add4(3) == 7);
}
{% endprettify %}


### Testing functions for equality

### 测试函数是否相等

Here's an example of testing top-level functions, static methods, and
instance methods for equality:

下面是顶级函数，静态方法和示例方法相等性的测试示例：

<?code-excerpt "misc/lib/language_tour/function_equality.dart"?>
{% prettify dart %}
void foo() {} // A top-level function

class A {
  static void bar() {} // A static method
  void baz() {} // An instance method
}

void main() {
  var x;

  // Comparing top-level functions.
  x = foo;
  assert(foo == x);

  // Comparing static methods.
  x = A.bar;
  assert(A.bar == x);

  // Comparing instance methods.
  var v = A(); // Instance #1 of A
  var w = A(); // Instance #2 of A
  var y = w;
  x = w.baz;

  // These closures refer to the same instance (#2),
  // so they're equal.
  assert(y.baz == x);

  // These closures refer to different instances,
  // so they're unequal.
  assert(v.baz != w.baz);
}
{% endprettify %}


### Return values

### 返回值

All functions return a value. If no return value is specified, the
statement `return null;` is implicitly appended to the function body.

所有函数都会返回一个值。 如果没有明确指定返回值，
函数体会被隐式的添加 `return null;` 语句。

<?code-excerpt "misc/test/language_tour/functions_test.dart (implicit-return-null)"?>
{% prettify dart %}
foo() {}

assert(foo() == null);
{% endprettify %}


## Operators

## 运算符

Dart defines the operators shown in the following table.
You can override many of these operators, as described in
[Overridable operators](#overridable-operators).

下表是 Dart 定义的运算符。
多数运算符可以被重载，详情参考
[重写运算符](#overridable-operators)。

|--------------------------+------------------------------------------------|
|Description               | Operator                                       |
|--------------------------|------------------------------------------------|
| unary postfix            | <code><em>expr</em>++</code>    <code><em>expr</em>--</code>    `()`    `[]`    `.`    `?.` |
| unary prefix             | <code>-<em>expr</em></code>    <code>!<em>expr</em></code>    <code>~<em>expr</em></code>    <code>++<em>expr</em></code>    <code>--<em>expr</em></code>   |
| multiplicative           | `*`    `/`    `%`    `~/`                      |
| additive                 | `+`    `-`                                     |
| shift                    | `<<`    `>>`    `>>>`                          |
| bitwise AND              | `&`                                            |
| bitwise XOR              | `^`                                            |
| bitwise OR               | `|`                                            |
| relational&nbsp;and&nbsp;type&nbsp;test | `>=`    `>`    `<=`    `<`    `as`    `is`    `is!` |
| equality                 | `==`    `!=`                                   |
| logical AND              | `&&`                                           |
| logical OR               | `||`                                           |
| if null                  | `??`                                           |
| conditional              | <code><em>expr1</em> ? <em>expr2</em> : <em>expr3</em></code> |
| cascade                  | `..`                                           |
| assignment               | `=`    `*=`    `/=`    `+=`    `-=`    `&=`    `^=`    <em>etc.</em> |
{:.table .table-striped}

<aside class="alert alert-warning" markdown="1">
  **Warning:**

  **提示：**

  Operator precedence is an approximation of the behavior of a Dart parser.
  For definitive answers, consult the grammar in the
  [Dart language specification][].

  上述表格中描述的运算符优先级近似于Dart 解析器实际行为。
  更准确的描述，请参阅 [Dart language specification][] 中的语法。
</aside>

When you use operators, you create expressions. Here are some examples
of operator expressions:

创建表达式的时候会用到运算符。
下面是一些运算符表达式的实例：

<?code-excerpt "misc/test/language_tour/operators_test.dart (expressions)" replace="/,//g"?>
{% prettify dart %}
a++
a + b
a = b
a == b
c ? a : b
a is T
{% endprettify %}

In the [operator table](#operators),
each operator has higher precedence than the operators in the rows
that follow it. For example, the multiplicative operator `%` has higher
precedence than (and thus executes before) the equality operator `==`,
which has higher precedence than the logical AND operator `&&`. That
precedence means that the following two lines of code execute the same
way:

在 [运算符表](#operators) 中，
每一行的运算符优先级，由上到下依次排列，第一行优先级最高，最后一行优先级最低。
例如
`%` 运算符优先级高于 `==` ，
而 `==` 高于 `&&`。
根据优先级规则，那么意味着以下两行代码执行的方式相同：

<?code-excerpt "misc/test/language_tour/operators_test.dart (precedence)"?>
{% prettify dart %}
// Parentheses improve readability.
if ((n % i == 0) && (d % i == 0)) ...

// Harder to read, but equivalent.
if (n % i == 0 && d % i == 0) ...
{% endprettify %}

<div class="alert alert-warning" markdown="1">
**Warning:**

**警告：**

For operators that work on two operands, the leftmost operand
determines which version of the operator is used. For example, if you
have a Vector object and a Point object, `aVector + aPoint` uses the
Vector version of +.

对于有两个操作数的运算符，运算符的功能由左边的操作数决定。
例如,
如果有两个操作数 Vector 和 Point，
`aVector + aPoint` 使用的是 Vector 中定义的 + 运算符。
</div>


### Arithmetic operators

### 算术运算符

Dart supports the usual arithmetic operators, as shown in the following table.

Dart 支持常用的运算运算符，如下表所示：

|-----------------------------+-------------------------------------------|
| Operator                    | Meaning                                   |
|-----------------------------+-------------------------------------------|
| `+`                         | Add
| `–`                         | Subtract
| <code>-<em>expr</em></code> | Unary minus, also known as negation (reverse the sign of the expression)
| `*`                         | Multiply
| `/`                         | Divide
| `~/`                        | Divide, returning an integer result
| `%`                         | Get the remainder of an integer division (modulo)
{:.table .table-striped}

Example:

<?code-excerpt "misc/test/language_tour/operators_test.dart (arithmetic)"?>
{% prettify dart %}
assert(2 + 3 == 5);
assert(2 - 3 == -1);
assert(2 * 3 == 6);
assert(5 / 2 == 2.5); // Result is a double
assert(5 ~/ 2 == 2); // Result is an int
assert(5 % 2 == 1); // Remainder

assert('5/2 = ${5 ~/ 2} r ${5 % 2}' == '5/2 = 2 r 1');
{% endprettify %}

Dart also supports both prefix and postfix increment and decrement
operators.

|-----------------------------+-------------------------------------------|
| Operator                    | Meaning                                   |
|-----------------------------+-------------------------------------------|
| <code>++<em>var</em></code> | <code><em>var</em> = <em>var</em> + 1</code> (expression value is <code><em>var</em> + 1</code>)
| <code><em>var</em>++</code> | <code><em>var</em> = <em>var</em> + 1</code> (expression value is <code><em>var</em></code>)
| <code>--<em>var</em></code> | <code><em>var</em> = <em>var</em> – 1</code> (expression value is <code><em>var</em> – 1</code>)
| <code><em>var</em>--</code> | <code><em>var</em> = <em>var</em> – 1</code> (expression value is <code><em>var</em></code>)
{:.table .table-striped}

Example:

示例：

<?code-excerpt "misc/test/language_tour/operators_test.dart (increment-decrement)"?>
{% prettify dart %}
var a, b;

a = 0;
b = ++a; // Increment a before b gets its value.
assert(a == b); // 1 == 1

a = 0;
b = a++; // Increment a AFTER b gets its value.
assert(a != b); // 1 != 0

a = 0;
b = --a; // Decrement a before b gets its value.
assert(a == b); // -1 == -1

a = 0;
b = a--; // Decrement a AFTER b gets its value.
assert(a != b); // -1 != 0
{% endprettify %}


### Equality and relational operators

### 关系运算符

The following table lists the meanings of equality and relational operators.

下表列出了关系运算符及含义：

|-----------+-------------------------------------------|
| Operator  | Meaning                                   |
|-----------+-------------------------------------------|
| `==`      |       Equal; see discussion below
| `!=`      |       Not equal
| `>`       |       Greater than
| `<`       |       Less than
| `>=`      |       Greater than or equal to
| `<=`      |       Less than or equal to
{:.table .table-striped}

To test whether two objects x and y represent the same thing, use the
`==` operator. (In the rare case where you need to know whether two
objects are the exact same object, use the [identical()][]
function instead.) Here’s how the `==` operator works:

要测试两个对象x和y是否表示相同的事物，
使用 `==` 运算符。 (在极少数情况下，
要确定两个对象是否完全相同，需要使用 [identical()][] 函数。)
下面给出 `==` 运算符的工作原理：

1.  If *x* or *y* is null, return true if both are null, and false if only
    one is null.

    如果 *x* 或 *y* 可以 null，都为 null 时返回 true ，其中一个为 null 时返回 false。

2.  Return the result of the method invocation
    <code><em>x</em>.==(<em>y</em>)</code>. (That’s right,
    operators such as `==` are methods that are invoked on their first
    operand. You can even override many operators, including `==`, as
    you’ll see in
    [Overridable operators](#overridable-operators).)

    结果为函数 <code><em>x</em>.==(<em>y</em>)</code> 的返回值。
    (如上所见,
    `==` 运算符执行的是第一个运算符的函数。
    我们甚至可以重写很多运算符，包括 `==`，
    运算符的重写，参考
    [重写运算符](#overridable-operators)）

Here’s an example of using each of the equality and relational
operators:

这里列出了每种关系运算符的示例：

<?code-excerpt "misc/test/language_tour/operators_test.dart (relational)"?>
{% prettify dart %}
assert(2 == 2);
assert(2 != 3);
assert(3 > 2);
assert(2 < 3);
assert(3 >= 3);
assert(2 <= 3);
{% endprettify %}


### Type test operators

### 类型判定运算符

The `as`, `is`, and `is!` operators are handy for checking types at
runtime.

`as`， `is`， 和 `is!` 运算符用于在运行时处理类型检查。

|-----------+-------------------------------------------|
| Operator  | Meaning                                   |
|-----------+-------------------------------------------|
| `as`      | Typecast (also used to specify [library prefixes](#specifying-a-library-prefix))
| `is`      | True if the object has the specified type
| `is!`     | False if the object has the specified type
{:.table .table-striped}

The result of `obj is T` is true if `obj` implements the interface
specified by `T`. For example, `obj is Object` is always true.

例如， `obj is Object` 总是 true。
但是只有 `obj` 实现了 `T` 的接口时， `obj is T` 才是 true。

Use the `as` operator to cast an object to a particular type. In
general, you should use it as a shorthand for an `is` test on an object
following by an expression using that object. For example, consider the
following code:

使用 `as` 运算符将对象强制转换为特定类型。
通常，可以认为是 `is` 类型判定后，被判定对象调用函数的一种缩写形式。
请考虑以下代码：

<?code-excerpt "misc/lib/language_tour/classes/employee.dart (emp is Person)"?>
{% prettify dart %}
if (emp is Person) {
  // Type check
  emp.firstName = 'Bob';
}
{% endprettify %}

You can make the code shorter using the `as` operator:

使用 `as` 运算符进行缩写：

<?code-excerpt "misc/lib/language_tour/classes/employee.dart (emp as Person)"?>
{% prettify dart %}
(emp as Person).firstName = 'Bob';
{% endprettify %}

<div class="alert alert-info" markdown="1">
**Note:**

**提示：**

The code isn’t equivalent. If `emp` is null or not a Person, the
first example (with `is`) does nothing; the second (with `as`) throws
an exception.

以上代码并不是等价的。
如果 `emp` 为 null 或者不是 Person 对象，
那么第一个 `is` 的示例，后面将不回执行；
第二个 `as` 的示例会抛出异常。
</div>

### Assignment operators

### 赋值运算符

As you’ve already seen, you can assign values using the `=` operator.
To assign only if the assigned-to variable is null,
use the `??=` operator.

使用 `=` 为变量赋值。
使用 `??=` 运算符时，只有当被赋值的变量为 null 时才会赋值给它。

<?code-excerpt "misc/test/language_tour/operators_test.dart (assignment)"?>
{% prettify dart %}
// Assign value to a
a = value;
// Assign value to b if b is null; otherwise, b stays the same
b ??= value;
{% endprettify %}

{% comment %}
<!-- embed a dartpad when we can hide code -->
https://gist.github.com/9de887c4daf76d39e524
{{site.dartpad}}/9de887c4daf76d39e524

<?code-excerpt "misc/test/language_tour/operators_test.dart (assignment-gist-main-body)" plaster="none"?>
{% prettify dart %}
void assignValues(int a, int b, int value) {
  print('Initially: a == $a, b == $b');
  // Assign value to a
  a = value;
  // Assign value to b if b is null; otherwise, b stays the same
  b ??= value;
  print('After: a == $a, b == $b');
}

main() {
  assignValues(0, 0, 1);
  assignValues(null, null, 1);
}
{% endprettify %}
{% endcomment %}

Compound assignment operators such as `+=` combine
an operation with an assignment.

复合赋值运算符（如 `+=` ）将算术运算符和赋值运算符组合在了一起。

| `=`  | `–=` | `/=`  | `%=`  | `>>=` | `^=`
| `+=` | `*=` | `~/=` | `<<=` | `&=`  | `|=`
{:.table}

Here’s how compound assignment operators work:

以下说明复合赋值运算符的作用：

|-----------+----------------------+-----------------------|
|           | Compound assignment  | Equivalent expression |
|-----------+----------------------+-----------------------|
|**For an operator <em>op</em>:** | <code>a <em>op</em>= b</code> | <code>a = a <em>op</em> b</code>
|**Example:**                     |`a += b`                       | `a = a + b`
{:.table}

The following example uses assignment and compound assignment
operators:

以下示例使用赋值和复合赋值运算符：

<?code-excerpt "misc/test/language_tour/operators_test.dart (op-assign)"?>
{% prettify dart %}
var a = 2; // Assign using =
a *= 3; // Assign and multiply: a = a * 3
assert(a == 6);
{% endprettify %}


### Logical operators

### 逻辑运算符

You can invert or combine boolean expressions using the logical
operators.

### 逻辑运算符

|-----------------------------+-------------------------------------------|
| Operator                    | Meaning                                   |
|-----------------------------+-------------------------------------------|
| <code>!<em>expr</em></code> | inverts the following expression (changes false to true, and vice versa)
| `||`                        | logical OR
| `&&`                        | logical AND
{:.table .table-striped}

Here’s an example of using the logical operators:

下面是关于逻辑表达式的示例：

<?code-excerpt "misc/lib/language_tour/operators.dart (op-logical)"?>
{% prettify dart %}
if (!done && (col == 0 || col == 3)) {
  // ...Do something...
}
{% endprettify %}


### Bitwise and shift operators

### 按位和移位运算符

You can manipulate the individual bits of numbers in Dart. Usually,
you’d use these bitwise and shift operators with integers.

在 Dart 中，可以单独操作数字的某一位。
通常情况下整数类型使用按位和移位运算符来操作。

|-----------------------------+-------------------------------------------|
| Operator                    | Meaning                                   |
|-----------------------------+-------------------------------------------|
| `&`                         | AND
| `|`                         | OR
| `^`                         | XOR
| <code>~<em>expr</em></code> | Unary bitwise complement (0s become 1s; 1s become 0s)
| `<<`                        | Shift left
| `>>`                        | Shift right
{:.table .table-striped}

Here’s an example of using bitwise and shift operators:

下面是关于按位和移位运算符的示例：

<?code-excerpt "misc/test/language_tour/operators_test.dart (op-bitwise)"?>
{% prettify dart %}
final value = 0x22;
final bitmask = 0x0f;

assert((value & bitmask) == 0x02); // AND
assert((value & ~bitmask) == 0x20); // AND NOT
assert((value | bitmask) == 0x2f); // OR
assert((value ^ bitmask) == 0x2d); // XOR
assert((value << 4) == 0x220); // Shift left
assert((value >> 4) == 0x02); // Shift right
{% endprettify %}


### Conditional expressions

### 条件表达式

Dart has two operators that let you concisely evaluate expressions
that might otherwise require [if-else](#if-and-else) statements:

Dart有两个运算符，有时可以替换 [if-else](#if-和-else) 表达式，
让表达式更简洁：

<code><em>condition</em> ? <em>expr1</em> : <em>expr2</em>
: If _condition_ is true, evaluates _expr1_ (and returns its value);
  otherwise, evaluates and returns the value of _expr2_.

<code><em>condition</em> ? <em>expr1</em> : <em>expr2</em>
: 如果条件为 true, 执行 _expr1_ (并返回它的值)：
  否则, 执行并返回 _expr2_ 的值。

<code><em>expr1</em> ?? <em>expr2</em></code>
: If _expr1_ is non-null, returns its value;
  otherwise, evaluates and returns the value of _expr2_.

<code><em>expr1</em> ?? <em>expr2</em></code>
: 如果 _expr1_ 是 non-null， 返回 _expr1_ 的值；
  否则, 执行并返回 _expr2_ 的值。

When you need to assign a value
based on a boolean expression,
consider using `?:`.

如果赋值是根据布尔值，
考虑使用
 `?:`。

<?code-excerpt "misc/lib/language_tour/operators.dart (if-then-else-operator)"?>
{% prettify dart %}
var visibility = isPublic ? 'public' : 'private';
{% endprettify %}

If the boolean expression tests for null,
consider using `??`.

如果赋值是基于判定是否为 null，
考虑使用
 `??`。

<?code-excerpt "misc/test/language_tour/operators_test.dart (if-null)"?>
{% prettify dart %}
String playerName(String name) => name ?? 'Guest';
{% endprettify %}

The previous example could have been written at least two other ways,
but not as succinctly:

下面给出了其他两种实现方式，
但并不简洁：

<?code-excerpt "misc/test/language_tour/operators_test.dart (if-null-alt)"?>
{% prettify dart %}
// Slightly longer version uses ?: operator.
String playerName(String name) => name != null ? name : 'Guest';

// Very long version uses if-else statement.
String playerName(String name) {
  if (name != null) {
    return name;
  } else {
    return 'Guest';
  }
}
{% endprettify %}

<a id="cascade"></a>
### Cascade notation (..)

### 级联运算符 (..)

Cascades (`..`) allow you to make a sequence of operations
on the same object. In addition to function calls,
you can also access fields on that same object.
This often saves you the step of creating a temporary variable and
allows you to write more fluid code.

级联运算符 (`..`) 可以实现对同一个对像进行一系列的操作。
除了调用函数，
还可以访问同一对象上的字段属性。
这通常可以节省创建临时变量的步骤，
同时编写出更流畅的代码。

Consider the following code:

考虑一下代码：

<?code-excerpt "misc/test/language_tour/browser_test.dart (cascade-operator)"?>
{% prettify dart %}
querySelector('#confirm') // Get an object.
  ..text = 'Confirm' // Use its members.
  ..classes.add('important')
  ..onClick.listen((e) => window.alert('Confirmed!'));
{% endprettify %}

The first method call, `querySelector()`, returns a selector object.
The code that follows the cascade notation operates
on this selector object, ignoring any subsequent values that
might be returned.

第一句调用函数 `querySelector()` ， 返回获取到的对象。
获取的对象依次执行级联运算符后面的代码，
代码执行后的返回值会被忽略。

The previous example is equivalent to:

上面的代码等价于：

<?code-excerpt "misc/test/language_tour/browser_test.dart (cascade-operator-example-expanded)"?>
{% prettify dart %}
var button = querySelector('#confirm');
button.text = 'Confirm';
button.classes.add('important');
button.onClick.listen((e) => window.alert('Confirmed!'));
{% endprettify %}

You can also nest your cascades. For example:

级联运算符可以嵌套，例如：

<?code-excerpt "misc/lib/language_tour/operators.dart (nested-cascades)"?>
{% prettify dart %}
final addressBook = (AddressBookBuilder()
      ..name = 'jenny'
      ..email = 'jenny@example.com'
      ..phone = (PhoneNumberBuilder()
            ..number = '415-555-0100'
            ..label = 'home')
          .build())
    .build();
{% endprettify %}

Be careful to construct your cascade on a function that returns
an actual object. For example, the following code fails:

在返回对象的函数中谨慎使用级联操作符。
例如，下面的代码是错误的：

<?code-excerpt "misc/lib/language_tour/operators.dart (cannot-cascade-on-void)" plaster="none"?>
{% prettify dart %}
var sb = StringBuffer();
sb.write('foo')
  ..write('bar'); // Error: method 'write' isn't defined for 'void'.
{% endprettify %}

The `sb.write()` call returns void,
and you can't construct a cascade on `void`.

`sb.write()` 函数调用返回 void，
不能在 `void` 对象上创建级联操作。

<div class="alert alert-info" markdown="1">
**Note:**

**提示：**

Strictly speaking,
the "double dot" notation for cascades is not an operator.
It's just part of the Dart syntax.

严格的来讲，
"两个点" 的级联语法不是一个运算符。
它只是一个 Dart 的特殊语法。
</div>

### Other operators

### 其他运算符

You've seen most of the remaining operators in other examples:

大多数剩余的运算符，已在示例中使用过：

|----------+-------------------------------------------|
| Operator | Name                 |          Meaning   |
|-----------+------------------------------------------|
| `()`     | Function application | Represents a function call
| `[]`     | List access          | Refers to the value at the specified index in the list
| `.`      | Member access        | Refers to a property of an expression; example: `foo.bar` selects property `bar` from expression `foo`
| `?.`     | Conditional member access | Like `.`, but the leftmost operand can be null; example: `foo?.bar` selects property `bar` from expression `foo` unless `foo` is null (in which case the value of `foo?.bar` is null)
{:.table .table-striped}

For more information about the `.`, `?.`, and `..` operators, see
[Classes](#classes).

更多关于 `.`, `?.` 和  `..` 运算符介绍，参考
[Classes](#classes).


## Control flow statements

## 控制流程语句

You can control the flow of your Dart code using any of the following:

使用 `try-catch` 和 `throw` 也可以改变程序流程，
详见 [Exceptions](#exceptions)。

-   `if` and `else`
-   `for` loops
-   `while` and `do`-`while` loops
-   `break` and `continue`
-   `switch` and `case`
-   `assert`

You can also affect the control flow using `try-catch` and `throw`, as
explained in [Exceptions](#exceptions).


### If and else

### if 和 else

Dart supports `if` statements with optional `else` statements, as the
next sample shows. Also see [conditional expressions](#conditional-expressions).

Dart 支持 `if - else` 语句，其中 `else` 是可选的，
比如下面的例子， 另参考 [conditional expressions](#conditional-expressions).

<?code-excerpt "misc/lib/language_tour/control_flow.dart (if-else)"?>
{% prettify dart %}
if (isRaining()) {
  you.bringRainCoat();
} else if (isSnowing()) {
  you.wearJacket();
} else {
  car.putTopDown();
}
{% endprettify %}

Unlike JavaScript, conditions must use boolean values, nothing else. See
[Booleans](#booleans) for more information.

Dart 支持 `if - else` 语句，其中 `else` 是可选的，
比如下面的例子， 另参考 [conditional expressions](#conditional-expressions).


### For loops

### for 循环

You can iterate with the standard `for` loop. For example:

进行迭代操作，可以使用标准 `for` 语句。 例如：

<?code-excerpt "misc/test/language_tour/control_flow_test.dart (for)"?>
{% prettify dart %}
var message = StringBuffer('Dart is fun');
for (var i = 0; i < 5; i++) {
  message.write('!');
}
{% endprettify %}

Closures inside of Dart’s `for` loops capture the _value_ of the index,
avoiding a common pitfall found in JavaScript. For example, consider:

闭包在 Dart 的 `for` 循环中会捕获循环的 index 索引值， 来避免 JavaScript 中常见的陷阱。
请思考示例代码：

<?code-excerpt "misc/test/language_tour/control_flow_test.dart (for-and-closures)"?>
{% prettify dart %}
var callbacks = [];
for (var i = 0; i < 2; i++) {
  callbacks.add(() => print(i));
}
callbacks.forEach((c) => c());
{% endprettify %}

The output is `0` and then `1`, as expected. In contrast, the example
would print `2` and then `2` in JavaScript.

和期望一样，输出的是 `0` 和 `1`。
但是示例中的代码在 JavaScript 中会连续输出两个 `2` 。

If the object that you are iterating over is an Iterable, you can use the
[forEach()][] method. Using `forEach()` is a good option if you don’t need to
know the current iteration counter:

I如果要迭代一个实现了 Iterable 接口的对象，
可以使用 [forEach()][] 方法，
如果不需要使用当前计数值，
使用 `forEach()` 是非常棒的选择：

<?code-excerpt "misc/lib/language_tour/control_flow.dart (forEach)"?>
{% prettify dart %}
candidates.forEach((candidate) => candidate.interview());
{% endprettify %}

Iterable classes such as List and Set also support the `for-in` form of
[iteration](/guides/libraries/library-tour#iteration):

实现了 Iterable 的类（比如， List 和 Set）同样也支持使用 `for-in` 进行迭代操作
[iteration](/guides/libraries/library-tour#iteration) ：

<?code-excerpt "misc/test/language_tour/control_flow_test.dart (collection)"?>
{% prettify dart %}
var collection = [0, 1, 2];
for (var x in collection) {
  print(x); // 0 1 2
}
{% endprettify %}


### While and do-while

### while 和 do-while

A `while` loop evaluates the condition before the loop:

`while` 循环在执行前判断执行条件：

<?code-excerpt "misc/lib/language_tour/control_flow.dart (while)"?>
{% prettify dart %}
while (!isDone()) {
  doSomething();
}
{% endprettify %}

A `do`-`while` loop evaluates the condition *after* the loop:

`do`-`while` 循环在执行`后`判断执行条件：

<?code-excerpt "misc/lib/language_tour/control_flow.dart (do-while)"?>
{% prettify dart %}
do {
  printLine();
} while (!atEndOfPage());
{% endprettify %}

### Break and continue

### break 和 continue

Use `break` to stop looping:

使用 `break` 停止程序循环：

<?code-excerpt "misc/lib/language_tour/control_flow.dart (while-break)"?>
{% prettify dart %}
while (true) {
  if (shutDownRequested()) break;
  processIncomingRequests();
}
{% endprettify %}

Use `continue` to skip to the next loop iteration:

使用 `continue` 跳转到下一次迭代：

<?code-excerpt "misc/lib/language_tour/control_flow.dart (for-continue)"?>
{% prettify dart %}
for (int i = 0; i < candidates.length; i++) {
  var candidate = candidates[i];
  if (candidate.yearsExperience < 5) {
    continue;
  }
  candidate.interview();
}
{% endprettify %}

You might write that example differently if you’re using an
[Iterable][] such as a list or set:

如果对象实现了 [Iterable][] 接口 （例如，list 或者 set）。
那么上面示例完全可以用另一种方式来实现：

<?code-excerpt "misc/lib/language_tour/control_flow.dart (where)"?>
{% prettify dart %}
candidates
    .where((c) => c.yearsExperience >= 5)
    .forEach((c) => c.interview());
{% endprettify %}


### Switch and case

### switch 和 case

Switch statements in Dart compare integer, string, or compile-time
constants using `==`. The compared objects must all be instances of the
same class (and not of any of its subtypes), and the class must not
override `==`.
[Enumerated types](#enumerated-types) work well in `switch` statements.

在 Dart 中 switch 语句使用 `==` 比较整数，字符串，或者编译时常量。
比较的对象必须都是同一个类的实例（并且不可以是子类），
类必须没有对 `==` 重写。
[枚举类型](#枚举类型) 可以用于 `switch` 语句。

<div class="alert alert-info" markdown="1">
**Note:**

**提示：**

Switch statements in Dart are intended for limited circumstances,
such as in interpreters or scanners.

在 Dart 中 Switch 语句仅适用于有限的情况下，
例如在 interpreter 或 scanner 中。
</div>

Each non-empty `case` clause ends with a `break` statement, as a rule.
Other valid ways to end a non-empty `case` clause are a `continue`,
`throw`, or `return` statement.

在 `case` 语句中，每个非空的 `case` 语句结尾需要跟一个 `break` 语句。
除 `break` 以外，还有可以使用 `continue`, `throw`，者 `return`。

Use a `default` clause to execute code when no `case` clause matches:

当没有 `case` 语句匹配时，执行 `default` 代码：

<?code-excerpt "misc/lib/language_tour/control_flow.dart (switch)"?>
{% prettify dart %}
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
{% endprettify %}

The following example omits the `break` statement in a `case` clause,
thus generating an error:

下面的 `case` 程序示例中缺省了 `break` 语句，导致错误：

<?code-excerpt "misc/lib/language_tour/control_flow.dart (switch-break-omitted)" plaster="none"?>
{% prettify dart %}
var command = 'OPEN';
switch (command) {
  case 'OPEN':
    executeOpen();
    // ERROR: Missing break

  case 'CLOSED':
    executeClosed();
    break;
}
{% endprettify %}

However, Dart does support empty `case` clauses, allowing a form of
fall-through:

但是， Dart 支持空 `case` 语句，
允许程序以 fall-through 的形式执行。

<?code-excerpt "misc/lib/language_tour/control_flow.dart (switch-empty-case)"?>
{% prettify dart %}
var command = 'CLOSED';
switch (command) {
  case 'CLOSED': // Empty case falls through.
  case 'NOW_CLOSED':
    // Runs for both CLOSED and NOW_CLOSED.
    executeNowClosed();
    break;
}
{% endprettify %}

If you really want fall-through, you can use a `continue` statement and
a label:

在非空 `case` 中实现 fall-through 形式，
可以使用 `continue` 语句结合 `lable` 的方式实现:

<?code-excerpt "misc/lib/language_tour/control_flow.dart (switch-continue)"?>
{% prettify dart %}
var command = 'CLOSED';
switch (command) {
  case 'CLOSED':
    executeClosed();
    continue nowClosed;
  // Continues executing at the nowClosed label.

  nowClosed:
  case 'NOW_CLOSED':
    // Runs for both CLOSED and NOW_CLOSED.
    executeNowClosed();
    break;
}
{% endprettify %}

A `case` clause can have local variables, which are visible only inside
the scope of that clause.

在非空 `case` 中实现 fall-through 形式，
可以使用 `continue` 语句结合 `lable` 的方式实现:


### Assert

During development, use an assert statement
— <code>assert(<em>condition</em>, <em>optionalMessage</em>)</code>; —
to disrupt normal execution if a boolean
condition is false. You can find examples of assert statements
throughout this tour. Here are some more:

在开发过程中，如果使用的 assert 表达式
— <code>assert(<em>condition</em>, <em>optionalMessage</em>)</code>; —
布尔值为 false，正常的程序执行流程就会被中断。
本章中包含部分 assert 的使用，
以下是部分示例：

<?code-excerpt "misc/test/language_tour/control_flow_test.dart (assert)"?>
{% prettify dart %}
// Make sure the variable has a non-null value.
assert(text != null);

// Make sure the value is less than 100.
assert(number < 100);

// Make sure this is an https URL.
assert(urlString.startsWith('https'));
{% endprettify %}

To attach a message to an assertion,
add a string as the second argument to `assert`.

assert 的第二个参数可以为其添加一个字符串消息。

<?code-excerpt "misc/test/language_tour/control_flow_test.dart (assert-with-message)"?>
{% prettify dart %}
assert(urlString.startsWith('https'),
    'URL ($urlString) should start with "https".');
{% endprettify %}

The first argument to `assert` can be any expression that
resolves to a boolean value. If the expression’s value
is true, the assertion succeeds and execution
continues. If it's false, the assertion fails and an exception (an
[AssertionError][]) is thrown.

assert 的第一个参数可以是解析为布尔值的任何表达式。
如果表达式结果为 true ， 则断言成功，继续执行。
如果表达式结果为 false ， 则断言失败，抛出异常
([AssertionError][]) 。

When exactly do assertions work?
That depends on the tools and framework you're using:

如何判断 assert 是否生效？
assert 是否生效依赖开发工具和使用的框架：

* Flutter enables assertions in [debug mode.][Flutter debug mode]

  Flutter 在 [debug mode][Flutter debug mode] 时生效。

* Development-only tools such as [dartdevc][]
  typically enable assertions by default.

  开发工具比如 [dartdevc][] 通常情况下是默认生效的。

* Some tools, such as [dart][] and [dart2js,][dart2js]
  support assertions through a command-line flag: `--enable-asserts`.

  其他一些工具，比如 [dart][] 以及 [dart2js][dart2js] 通过命令参数 `--enable-asserts` 使 assert 生效。

In production code, assertions are ignored, and
the arguments to `assert` aren't evaluated.

在生产环境代码中， assert 被忽略，与此同时传入 `assert` 的参数不被判断。


## Exceptions

## 异常

Your Dart code can throw and catch exceptions. Exceptions are errors
indicating that something unexpected happened. If the exception isn’t
caught, the [isolate](#isolates) that raised the exception is suspended, and
typically the isolate and its program are terminated.


Dart 代码可以抛出和捕获异常。
异常表示一些未知的错误情况。
如果异常没有被捕获， 则异常会抛出，
导致抛出异常的代码终止执行。

In contrast to Java, all of Dart’s exceptions are unchecked exceptions.
Methods do not declare which exceptions they might throw, and you are
not required to catch any exceptions.

和 Java 有所不同， Dart 中的所有异常是非检查异常。
方法不会声明它们抛出的异常，
也不要求捕获任何异常。

Dart provides [Exception][] and [Error][]
types, as well as numerous predefined subtypes. You can, of course,
define your own exceptions. However, Dart programs can throw any
non-null object—not just Exception and Error objects—as an exception.

Dart 提供了 [Exception][] 和 [Error][] 类型，
以及一些子类型。
当然也可以定义自己的异常类型。
但是，此外 Dart 程序可以抛出任何非 null 对象， 不仅限 Exception 和 Error 对象。

### Throw

Here’s an example of throwing, or *raising*, an exception:

下面是关于抛出或者 *引发* 异常的示例：

<?code-excerpt "misc/lib/language_tour/exceptions.dart (throw-FormatException)"?>
{% prettify dart %}
throw FormatException('Expected at least 1 section');
{% endprettify %}

You can also throw arbitrary objects:

也可以抛出任意的对象：

<?code-excerpt "misc/lib/language_tour/exceptions.dart (out-of-llamas)"?>
{% prettify dart %}
throw 'Out of llamas!';
{% endprettify %}

<div class="alert alert-info" markdown="1">
  **Note:** Production-quality code usually throws types that implement
  [Error][] or [Exception][].

  **提示：** 高质量的生产环境代码通常会实现 [Error][] 或 [Exception][] 类型的异常抛出。
</div>

Because throwing an exception is an expression, you can throw exceptions
in =\> statements, as well as anywhere else that allows expressions:

因为抛出异常是一个表达式，
所以可以在 =\> 语句中使用，也可以在其他使用表达式的地方抛出异常：

<?code-excerpt "misc/lib/language_tour/exceptions.dart (throw-is-an-expression)"?>
{% prettify dart %}
void distanceTo(Point other) => throw UnimplementedError();
{% endprettify %}


### Catch

Catching, or capturing, an exception stops the exception from
propagating (unless you rethrow the exception).
Catching an exception gives you a chance to handle it:

捕获异常可以避免异常继续传递（除非重新抛出（ rethrow ）异常）。
可以通过捕获异常的机会来处理该异常：

<?code-excerpt "misc/lib/language_tour/exceptions.dart (try)"?>
{% prettify dart %}
try {
  breedMoreLlamas();
} on OutOfLlamasException {
  buyMoreLlamas();
}
{% endprettify %}

To handle code that can throw more than one type of exception, you can
specify multiple catch clauses. The first catch clause that matches the
thrown object’s type handles the exception. If the catch clause does not
specify a type, that clause can handle any type of thrown object:

通过指定多个 catch 语句，可以处理可能抛出多种类型异常的代码。
与抛出异常类型匹配的第一个 catch 语句处理异常。
如果 catch 语句未指定类型，
则该语句可以处理任何类型的抛出对象：

<?code-excerpt "misc/lib/language_tour/exceptions.dart (try-catch)"?>
{% prettify dart %}
try {
  breedMoreLlamas();
} on OutOfLlamasException {
  // A specific exception
  buyMoreLlamas();
} on Exception catch (e) {
  // Anything else that is an exception
  print('Unknown exception: $e');
} catch (e) {
  // No specified type, handles all
  print('Something really unknown: $e');
}
{% endprettify %}

As the preceding code shows, you can use either `on` or `catch` or both.
Use `on` when you need to specify the exception type. Use `catch` when
your exception handler needs the exception object.

如上述代码所示，捕获语句中可以同时使用 `on` 和 `catch` ，也可以单独分开使用。
使用 `on` 来指定异常类型，
使用 `catch` 来 捕获异常对象。

You can specify one or two parameters to `catch()`.
The first is the exception that was thrown,
and the second is the stack trace (a [StackTrace][] object).

`catch()` 函数可以指定1到2个参数，
第一个参数为抛出的异常对象，
第二个为堆栈信息 ( 一个 [StackTrace][] 对象 )。

<?code-excerpt "misc/lib/language_tour/exceptions.dart (try-catch-2)" replace="/\(e.*?\)/[!$&!]/g"?>
{% prettify dart %}
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

分处理异常，
那么可以使用关键字 `rethrow` 将异常重新抛出。

<?code-excerpt "misc/test/language_tour/exceptions_test.dart (rethrow)" replace="/rethrow;/[!$&!]/g"?>
{% prettify dart %}
void misbehave() {
  try {
    dynamic foo = true;
    print(foo++); // Runtime error
  } catch (e) {
    print('misbehave() partially handled ${e.runtimeType}.');
    [!rethrow;!] // Allow callers to see the exception.
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

不管是否抛出异常， `finally` 中的代码都会被执行。
如果 `catch` 没有匹配到异常，
异常会在 `finally` 执行完成后，再次被抛出：

<?code-excerpt "misc/lib/language_tour/exceptions.dart (finally)"?>
{% prettify dart %}
try {
  breedMoreLlamas();
} finally {
  // Always clean up, even if an exception is thrown.
  cleanLlamaStalls();
}
{% endprettify %}

The `finally` clause runs after any matching `catch` clauses:

任何匹配的 `catch` 执行完成后，再执行 `finally` ：

<?code-excerpt "misc/lib/language_tour/exceptions.dart (try-catch-finally)"?>
{% prettify dart %}
try {
  breedMoreLlamas();
} catch (e) {
  print('Error: $e'); // Handle the exception first.
} finally {
  cleanLlamaStalls(); // Then clean up.
}
{% endprettify %}

Learn more by reading the
[Exceptions](/guides/libraries/library-tour#exceptions)
section of the library tour.

更多详情，请参考
[Exceptions](/guides/libraries/library-tour#exceptions) 章节。

## Classes

## 类

Dart is an object-oriented language with classes and mixin-based
inheritance. Every object is an instance of a class, and all classes
descend from [Object.][Object]
*Mixin-based inheritance* means that although every class (except for
Object) has exactly one superclass, a class body can be reused in
multiple class hierarchies.

Dart 是一种基于类和 mixin 继承机制的面向对象的语言。
每个对象都是一个类的实例，所有的类都继承于 [Object.][Object] 。
基于 *Mixin 继承* 意味着每个类（除 Object 外） 都只有一个超类，
一个类中的代码可以在其他多个继承类中重复使用。


### Using class members

### 使用类的成员变量

Objects have *members* consisting of functions and data (*methods* and
*instance variables*, respectively). When you call a method, you *invoke*
it on an object: the method has access to that object’s functions and
data.

对象的*成员*由函数和数据（即*方法*和*实例变量*）组成。
方法的*调用*要通过对象来完成：
调用的方法可以访问其对象的其他函数和数据。

Use a dot (`.`) to refer to an instance variable or method:

使用 (`.`) 来引用实例对象的变量和方法：

<?code-excerpt "misc/test/language_tour/classes_test.dart (object-members)"?>
{% prettify dart %}
var p = Point(2, 2);

// Set the value of the instance variable y.
p.y = 3;

// Get the value of y.
assert(p.y == 3);

// Invoke distanceTo() on p.
num distance = p.distanceTo(Point(4, 4));
{% endprettify %}

Use `?.` instead of `.` to avoid an exception
when the leftmost operand is null:

使用 `?.` 来代替 `.` ，
可以避免因为左边对象可能为 null ，
导致的异常：

{% comment %}
{{site.dartpad}}/0cb25997742ed5382e4a
https://gist.github.com/0cb25997742ed5382e4a
{% endcomment %}

<?code-excerpt "misc/test/language_tour/classes_test.dart (safe-member-access)"?>
{% prettify dart %}
// If p is non-null, set its y value to 4.
p?.y = 4;
{% endprettify %}


### Using constructors

### 使用构造函数

You can create an object using a *constructor*.
Constructor names can be either <code><em>ClassName</em></code> or
<code><em>ClassName</em>.<em>identifier</em></code>. For example,
the following code creates `Point` objects using the
`Point()` and `Point.fromJson()` constructors:

通过 *构造函数* 创建对象。
构造函数的名字可以是 <code><em>ClassName</em></code> 或者
<code><em>ClassName</em>.<em>identifier</em></code>。例如，
以下代码使用 `Point` 和 `Point.fromJson()` 构造函数创建 `Point` 对象：

<?code-excerpt "misc/test/language_tour/classes_test.dart (object-creation)" replace="/ as .*?;/;/g"?>
{% prettify dart %}
var p1 = Point(2, 2);
var p2 = Point.fromJson({'x': 1, 'y': 2});
{% endprettify %}

The following code has the same effect, but
uses the optional `new` keyword before the constructor name:

以下代码具有相同的效果，
但是构造函数前面的的 `new` 关键字是可选的：

<?code-excerpt "misc/test/language_tour/classes_test.dart (object-creation-new)" replace="/ as .*?;/;/g"?>
{% prettify dart %}
var p1 = new Point(2, 2);
var p2 = new Point.fromJson({'x': 1, 'y': 2});
{% endprettify %}

<aside class="alert alert-info" markdown="1">
  **Version note:** The `new` keyword became optional in Dart 2.

  **版本提示：** 在 Dart 2 中 `new` 关键字变成了可选的。
</aside>

Some classes provide [constant constructors](#constant-constructors).
To create a compile-time constant using a constant constructor,
put the `const` keyword before the constructor name:

一些类提供了[常量构造函数](#constant-constructors)。
使用常量构造函数，在构造函数名之前加 `const` 关键字，来创建编译时常量时：

<?code-excerpt "misc/test/language_tour/classes_test.dart (const)"?>
{% prettify dart %}
var p = const ImmutablePoint(2, 2);
{% endprettify %}

Constructing two identical compile-time constants results in a single,
canonical instance:

构造两个相同的编译时常量会产生一个唯一的，
标准的实例：

<?code-excerpt "misc/test/language_tour/classes_test.dart (identical)"?>
{% prettify dart %}
var a = const ImmutablePoint(1, 1);
var b = const ImmutablePoint(1, 1);

assert(identical(a, b)); // They are the same instance!
{% endprettify %}

Within a _constant context_, you can omit the `const` before a constructor
or literal. For example, look at this code, which creates a const map:

在 _常量上下文_ 中， 构造函数或者字面量前的 `const` 可以省略。
例如，下面代码创建了一个 const 类型的 map 对象：

<?code-excerpt "misc/test/language_tour/classes_test.dart (const-context-withconst)" replace="/pointAndLine1/pointAndLine/g"?>
{% prettify dart %}
// Lots of const keywords here.
const pointAndLine = const {
  'point': const [const ImmutablePoint(0, 0)],
  'line': const [const ImmutablePoint(1, 10), const ImmutablePoint(-2, 11)],
};
{% endprettify %}

You can omit all but the first use of the `const` keyword:

保留第一个 `const` 关键字，其余的全部省略：

<?code-excerpt "misc/test/language_tour/classes_test.dart (const-context-noconst)" replace="/pointAndLine2/pointAndLine/g"?>
{% prettify dart %}
// Only one const, which establishes the constant context.
const pointAndLine = {
  'point': [ImmutablePoint(0, 0)],
  'line': [ImmutablePoint(1, 10), ImmutablePoint(-2, 11)],
};
{% endprettify %}

If a constant constructor is outside of a constant context
and is invoked without `const`,
it creates a **non-constant object**:

如果常量构造函数在常量上下文之外，
且省略了 `const` 关键字，
此时创建的对象是**非常量对象**：

<?code-excerpt "misc/test/language_tour/classes_test.dart (nonconst-const-constructor)"?>
{% prettify dart %}
var a = const ImmutablePoint(1, 1); // Creates a constant
var b = ImmutablePoint(1, 1); // Does NOT create a constant

assert(!identical(a, b)); // NOT the same instance!
{% endprettify %}

<aside class="alert alert-info" markdown="1">
  **Version note:** The `const` keyword became optional
  within a constant context in Dart 2.

  **版本提示：** 在 Dart 2 中，一个常量上下文中的 `const` 关键字可以被省略。
</aside>


### Getting an object's type

### 获取对象的类型

To get an object's type at runtime,
you can use Object's `runtimeType` property,
which returns a [Type][] object.

使用对象的 `runtimeType` 属性，
可以在运行时获取对象的类型，
`runtimeType` 属性回返回一个 [Type][] 对象。

<?code-excerpt "misc/test/language_tour/classes_test.dart (runtimeType)"?>
{% prettify dart %}
print('The type of a is ${a.runtimeType}');
{% endprettify %}

Up to here, you've seen how to _use_ classes.
The rest of this section shows how to _implement_ classes.

到目前为止，我们已经解了如何_使用_类。
本节的其余部分将介绍如何_实现_一个类。

### Instance variables

### 实例变量

Here’s how you declare instance variables:

下面是声明实例变量的示例：

<?code-excerpt "misc/lib/language_tour/classes/point_with_main.dart (class)"?>
{% prettify dart %}
class Point {
  num x; // Declare instance variable x, initially null.
  num y; // Declare y, initially null.
  num z = 0; // Declare z, initially 0.
}
{% endprettify %}

All uninitialized instance variables have the value `null`.

未初始化实例变量的默认人值为 “null” 。

All instance variables generate an implicit *getter* method. Non-final
instance variables also generate an implicit *setter* method. For details,
see [Getters and setters](#getters-and-setters).

所有实例变量都生成隐式 *getter* 方法。
非 final 的实例变量同样会生成隐式 *setter* 方法。
有关更多信息，参考 [Getters 和 setters](#getters-和-setters)。

<?code-excerpt "misc/lib/language_tour/classes/point_with_main.dart (class+main)" replace="/(num .*?;).*/$1/g" plaster="none"?>
{% prettify dart %}
class Point {
  num x;
  num y;
}

void main() {
  var point = Point();
  point.x = 4; // Use the setter method for x.
  assert(point.x == 4); // Use the getter method for x.
  assert(point.y == null); // Values default to null.
}
{% endprettify %}

If you initialize an instance variable where it is declared (instead of
in a constructor or method), the value is set when the instance is
created, which is before the constructor and its initializer list
execute.

如果在声明时进行了示例变量的初始化，
那么初始化值会在示例创建时赋值给变量，
该赋值过程在构造函数及其初始化列表执行之前。


### Constructors

### 构造函数

Declare a constructor by creating a function with the same name as its
class (plus, optionally, an additional identifier as described in
[Named constructors](#named-constructors)).
The most common form of constructor, the generative constructor, creates
a new instance of a class:

通过创建一个与其类同名的函数来声明构造函数
（另外，还可以附加一个额外的可选标识符，如 [命名构造函数](#named-constructors) 中所述）。
下面通过最常见的构造函数形式，
即生成构造函数，
创建一个类的实例：

<?code-excerpt "misc/lib/language_tour/classes/point_alt.dart (constructor-long-way)" plaster="none"?>
{% prettify dart %}
class Point {
  num x, y;

  Point(num x, num y) {
    // There's a better way to do this, stay tuned.
    this.x = x;
    this.y = y;
  }
}
{% endprettify %}

The `this` keyword refers to the current instance.

使用 `this` 关键字引用当前实例。

<div class="alert alert-info" markdown="1">
**Note:**

**提示：**

Use `this` only when there is a name conflict. Otherwise, Dart style
omits the `this`.

近当存在命名冲突时，使用 `this` 关键字。 否则，按照 Dart 风格应该省略 `this` 。
</div>

The pattern of assigning a constructor argument to an instance variable
is so common, Dart has syntactic sugar to make it easy:

通常模式下，会将构造函数传入的参数的值赋值给对应的实例变量，
Dart 自身的语法糖精简了这些代码：

<?code-excerpt "misc/lib/language_tour/classes/point.dart (constructor-initializer)" plaster="none"?>
{% prettify dart %}
class Point {
  num x, y;

  // Syntactic sugar for setting x and y
  // before the constructor body runs.
  Point(this.x, this.y);
}
{% endprettify %}

#### Default constructors

#### 默认构造函数

If you don’t declare a constructor, a default constructor is provided
for you. The default constructor has no arguments and invokes the
no-argument constructor in the superclass.

在没有声明构造函数的情况下， Dart 会提供一个默认的构造函数。
默认构造函数没有参数并会调用父类的无参构造函数。

#### Constructors aren’t inherited

#### 构造函数不被继承

Subclasses don’t inherit constructors from their superclass. A subclass
that declares no constructors has only the default (no argument, no
name) constructor.

子类不会继承父类的构造函数。
子类不声明构造函数，那么它就只有默认构造函数 (匿名，没有参数)。

#### Named constructors

#### 命名构造函数

Use a named constructor to implement multiple constructors for a class
or to provide extra clarity:

使用命名构造函数可为一个类实现多个构造函数，
也可以使用命名构造函数来更清晰的表明函数意图：

<?code-excerpt "misc/lib/language_tour/classes/point.dart (named-constructor)" replace="/Point\.\S*/[!$&!]/g" plaster="none"?>
{% prettify dart %}
class Point {
  num x, y;

  Point(this.x, this.y);

  // Named constructor
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

切记，构造函数不能够被继承，
这意味着父类的命名构造函数不会被子类继承。
如果希望使用父类中定义的命名构造函数创建子类，
就必须在子类中实现该构造函数。

#### Invoking a non-default superclass constructor

#### 调用父类非默认构造函数

By default, a constructor in a subclass calls the superclass’s unnamed,
no-argument constructor.
The superclass's constructor is called at the beginning of the
constructor body. If an [initializer list](#initializer-list)
is also being used, it executes before the superclass is called.
In summary, the order of execution is as follows:

默认情况下，子类的构造函数会自动调用父类的默认构造函数（匿名，无参数）。
父类的构造函数在子类构造函数体开始执行的位置被调用。
如果提供了一个 [initializer list](#initializer-list)（初始化参数列表），
则初始化参数列表在父类构造函数执行之前执行。
总之，执行顺序如下：

1. initializer list

   初始化参数列表

1. superclass's no-arg constructor

   父类的无名构造函数

1. main class's no-arg constructor

   主类的无名构造函数

If the superclass doesn’t have an unnamed, no-argument constructor,
then you must manually call one of the constructors in the
superclass. Specify the superclass constructor after a colon (`:`), just
before the constructor body (if any).

如果父类中没有匿名无参的构造函数，
则需要手工调用父类的其他构造函数。
在当前构造函数冒号 (`:`) 之后，函数体之前，声明调用父类构造函数。

In the following example, the constructor for the Employee class
calls the named constructor for its superclass, Person.
Click the run button {% asset red-run.png alt="" %} to execute the code.

下面的示例中，Employee 类的构造函数调用了父类 Person 的命名构造函数。
点击运行按钮{% asset red-run.png alt="" %} 执行示例代码。

{% comment %}
https://gist.github.com/Sfshaza/e57aa06401e6618d4eb8
{{site.dartpad}}/e57aa06401e6618d4eb8

<?code-excerpt "misc/lib/language_tour/classes/employee.dart" plaster="none"?>
{% prettify dart %}
class Person {
  String firstName;

  Person.fromJson(Map data) {
    print('in Person');
  }
}

class Employee extends Person {
  // Person does not have a default constructor;
  // you must call super.fromJson(data).
  Employee.fromJson(Map data) : super.fromJson(data) {
    print('in Employee');
  }
}

void main() {
  var emp = Employee.fromJson({});
  // Prints:
  // in Person
  // in Employee

  if (emp is Person) {
    // Type check
    emp.firstName = 'Bob';
  }
  (emp as Person).firstName = 'Bob';
}
{% endprettify %}
{% endcomment %}

<iframe
src="{{site.custom.dartpad.embed-inline-prefix}}?id=e57aa06401e6618d4eb8&verticalRatio=80"
    width="100%"
    height="500px"
    style="border: 1px solid #ccc;">
</iframe>

Because the arguments to the superclass constructor are evaluated before
invoking the constructor, an argument can be an expression such as a
function call:

由于父类的构造函数参数在构造函数执行之前执行，
所以参数可以是一个表达式或者一个方法调用：

<?code-excerpt "misc/lib/language_tour/classes/employee.dart (method-then-constructor)"?>
{% prettify dart %}
class Employee extends Person {
  Employee() : super.fromJson(getDefaultData());
  // ···
}
{% endprettify %}

<div class="alert alert-warning" markdown="1">
**Warning:**

**警告：**

Arguments to the superclass constructor do not have access to `this`.
For example, arguments can call static methods but not instance methods.

调用父类构造函数的参数无法访问 this。
例如，参数可以为静态函数但是不能是实例函数。
</div>

#### Initializer list

#### 初始化列表

Besides invoking a superclass constructor, you can also initialize
instance variables before the constructor body runs. Separate
initializers with commas.

除了调用超类构造函数之外，
还可以在构造函数体执行之前初始化实例变量。
各参数的初始化用逗号分隔。

<?code-excerpt "misc/lib/language_tour/classes/point_alt.dart (initializer-list)"?>
{% prettify dart %}
// Initializer list sets instance variables before
// the constructor body runs.
Point.fromJson(Map<String, num> json)
    : x = json['x'],
      y = json['y'] {
  print('In Point.fromJson(): ($x, $y)');
}
{% endprettify %}

<div class="alert alert-warning" markdown="1">
**Warning:**

**警告：**

The right-hand side of an initializer does not have access to `this`.

初始化程序的右侧无法访问 `this`。
</div>

During development, you can validate inputs by using `assert` in the
initializer list.

在开发期间，
可以使用 `assert` 来验证输入的初始化列表。

<?code-excerpt "misc/lib/language_tour/classes/point_alt.dart (initializer-list-with-assert)" replace="/assert\(.*?\)/[!$&!]/g"?>
{% prettify dart %}
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

Initializer lists are handy when setting up final fields.
The following example initializes three final fields in an initializer list.
Click the run button {% asset red-run.png alt="" %} to execute the code.

使用初始化列表可以很方便的设置 final 字段。
下面示例演示了，如何使用初始化列表初始化设置三个 final 字段。
点击运行按钮 {% asset red-run.png alt="" %} 执行示例代码。

{% comment %}
https://gist.github.com/Sfshaza/7a9764702c0608711e08
{{site.dartpad}}/a9764702c0608711e08

<?code-excerpt "misc/lib/language_tour/classes/point_with_distance_field.dart"?>
{% prettify dart %}
import 'dart:math';

class Point {
  final num x;
  final num y;
  final num distanceFromOrigin;

  Point(num x, num y)
      : x = x,
        y = y,
        distanceFromOrigin = sqrt(x * x + y * y);
}

void main() {
  var p = Point(2, 3);
  print(p.distanceFromOrigin);
}
{% endprettify %}
{% endcomment %}

<iframe
src="{{site.custom.dartpad.embed-inline-prefix}}?id=7a9764702c0608711e08&verticalRatio=85"
    width="100%"
    height="420px"
    style="border: 1px solid #ccc;">
</iframe>


#### Redirecting constructors

#### 重定向构造函数

Sometimes a constructor’s only purpose is to redirect to another
constructor in the same class. A redirecting constructor’s body is
empty, with the constructor call appearing after a colon (:).

有时构造函数的唯一目的是重定向到同一个类中的另一个构造函数。
重定向构造函数的函数体为空，
构造函数的调用在冒号 (:) 之后。

<?code-excerpt "misc/lib/language_tour/classes/point_redirecting.dart"?>
{% prettify dart %}
class Point {
  num x, y;

  // The main constructor for this class.
  Point(this.x, this.y);

  // Delegates to the main constructor.
  Point.alongXAxis(num x) : this(x, 0);
}
{% endprettify %}

#### Constant constructors

#### 常量构造函数

If your class produces objects that never change, you can make these
objects compile-time constants. To do this, define a `const` constructor
and make sure that all instance variables are `final`.

如果该类生成的对象是固定不变的，
那么就可以把这些对象定义为编译时常量。
为此，需要定义一个 `const` 构造函数，
并且声明所有实例变量为 `final`。

<?code-excerpt "misc/lib/language_tour/classes/immutable_point.dart"?>
{% prettify dart %}
class ImmutablePoint {
  static final ImmutablePoint origin =
      const ImmutablePoint(0, 0);

  final num x, y;

  const ImmutablePoint(this.x, this.y);
}
{% endprettify %}

Constant constructors don't always create constants.
For details, see the section on
[using constructors](#using-constructors).

常量构造函数创建的实例并不总是常量。
更多内容，查看 [使用构造函数](#using-constructors)章节。


#### Factory constructors

#### 工厂构造函数

Use the `factory` keyword when implementing a constructor that doesn’t
always create a new instance of its class. For example, a factory
constructor might return an instance from a cache, or it might return an
instance of a subtype.

当执行构造函数并不总是创建这个类的一个新实例时，则使用 `factory` 关键字。
例如，一个工厂构造函数可能会返回一个 cache 中的实例，
或者可能返回一个子类的实例。

The following example demonstrates a factory constructor returning
objects from a cache:

以下示例演示了从缓存中返回对象的工厂构造函数：

<?code-excerpt "misc/lib/language_tour/classes/logger.dart"?>
{% prettify dart %}
class Logger {
  final String name;
  bool mute = false;

  // _cache is library-private, thanks to
  // the _ in front of its name.
  static final Map<String, Logger> _cache =
      <String, Logger>{};

  factory Logger(String name) {
    if (_cache.containsKey(name)) {
      return _cache[name];
    } else {
      final logger = Logger._internal(name);
      _cache[name] = logger;
      return logger;
    }
  }

  Logger._internal(this.name);

  void log(String msg) {
    if (!mute) print(msg);
  }
}
{% endprettify %}

<div class="alert alert-info" markdown="1">
**Note:**

**提示：**

Factory constructors have no access to `this`.

工厂构造函数无法访问 this。
</div>

Invoke a factory constructor just like you would any other constructor:

工厂构造函的调用方式与其他构造函数一样：

<?code-excerpt "misc/lib/language_tour/classes/logger.dart (logger)"?>
{% prettify dart %}
var logger = Logger('UI');
logger.log('Button clicked');
{% endprettify %}


### Methods

### 方法

Methods are functions that provide behavior for an object.

方法是为对象提供行为的函数。

#### Instance methods

#### 实例方法

Instance methods on objects can access instance variables and `this`.
The `distanceTo()` method in the following sample is an example of an
instance method:

对象的实例方法可以访问 `this` 和实例变量。
以下示例中的 `distanceTo()` 方法就是实例方法：


<?code-excerpt "misc/lib/language_tour/classes/point.dart (class-with-distanceTo)" plaster="none"?>
{% prettify dart %}
import 'dart:math';

class Point {
  num x, y;

  Point(this.x, this.y);

  num distanceTo(Point other) {
    var dx = x - other.x;
    var dy = y - other.y;
    return sqrt(dx * dx + dy * dy);
  }
}
{% endprettify %}

#### Getters and setters

#### Getter 和 Setter

Getters and setters are special methods that provide read and write
access to an object’s properties. Recall that each instance variable has
an implicit getter, plus a setter if appropriate. You can create
additional properties by implementing getters and setters, using the
`get` and `set` keywords:


Getter 和 Setter 是用于对象属性读和写的特殊方法。
回想之前的例子，每个实例变量都有一个隐式 Getter ，通常情况下还会有一个 Setter 。
使用 `get` 和 `set` 关键字实现 Getter 和 Setter ，能够为实例创建额外的属性。

<?code-excerpt "misc/lib/language_tour/classes/rectangle.dart"?>
{% prettify dart %}
class Rectangle {
  num left, top, width, height;

  Rectangle(this.left, this.top, this.width, this.height);

  // Define two calculated properties: right and bottom.
  num get right => left + width;
  set right(num value) => left = value - width;
  num get bottom => top + height;
  set bottom(num value) => top = value - height;
}

void main() {
  var rect = Rectangle(3, 4, 20, 15);
  assert(rect.left == 3);
  rect.right = 12;
  assert(rect.left == -8);
}
{% endprettify %}

With getters and setters, you can start with instance variables, later
wrapping them with methods, all without changing client code.

最开始实现 Getter 和 Setter 也许是直接返回成员变量；
随着需求变化， Getter 和 Setter 可能需要进行计算处理而使用方法来实现；
但是，调用对象的代码不需要做任何的修改。


<div class="alert alert-info" markdown="1">
**Note:**

**提示：**

Operators such as increment (++) work in the expected way, whether or
not a getter is explicitly defined. To avoid any unexpected side
effects, the operator calls the getter exactly once, saving its value
in a temporary variable.

类似 (++) 之类操作符不管是否定义了 getter 方法，都能够正确的执行。
为了避免一些问题，操作符只调用一次 getter 方法，
然后把值保存到一个临时的变量中。
</div>

#### Abstract methods

#### 抽象方法

Instance, getter, and setter methods can be abstract, defining an
interface but leaving its implementation up to other classes.
Abstract methods can only exist in [abstract classes](#abstract-classes).

实例方法， getter， 和 setter 方法可以是抽象的，
只定义接口不进行实现，而是留给其他类去实现。
抽象方法只存在于 [抽象类](#abstract-classes) 中。

To make a method abstract, use a semicolon (;) instead of a method body:

定义一个抽象函数，使用分号 (;) 来代替函数体：

<?code-excerpt "misc/lib/language_tour/classes/doer.dart"?>
{% prettify dart %}
abstract class Doer {
  // Define instance variables and methods...

  void doSomething(); // Define an abstract method.
}

class EffectiveDoer extends Doer {
  void doSomething() {
    // Provide an implementation, so the method is not abstract here...
  }
}
{% endprettify %}


### Abstract classes

### 抽象类

Use the `abstract` modifier to define an *abstract class*—a class that
can’t be instantiated. Abstract classes are useful for defining
interfaces, often with some implementation. If you want your abstract
class to appear to be instantiable, define a [factory
constructor](#factory-constructors).

使用 `abstract` 修饰符来定义 *抽象类* — 抽象类不能实例化。
抽象类通常用来定义接口，以及部分实现。
如果希望抽象类能够被实例化，那么可以通过定义一个
[工厂构造函数](#工厂构造函数) 来实现。

Abstract classes often have [abstract methods](#abstract-methods).
Here’s an example of declaring an abstract class that has an abstract
method:

抽象类通常具有 [抽象方法](#abstract-methods)。
下面是一个声明具有抽象方法的抽象类示例：

<?code-excerpt "misc/lib/language_tour/classes/misc.dart (abstract)"?>
{% prettify dart %}
// This class is declared abstract and thus
// can't be instantiated.
abstract class AbstractContainer {
  // Define constructors, fields, methods...

  void updateChildren(); // Abstract method.
}
{% endprettify %}


### Implicit interfaces

### 隐式接口

Every class implicitly defines an interface containing all the instance
members of the class and of any interfaces it implements. If you want to
create a class A that supports class B’s API without inheriting B’s
implementation, class A should implement the B interface.

每个类都隐式的定义了一个接口，接口包含了该类所有的实例成员及其实现的接口。
如果要创建一个 A 类，A 要支持 B 类的 API ，但是不需要继承 B 的实现，
那么可以通过 A 实现 B 的接口。

A class implements one or more interfaces by declaring them in an
`implements` clause and then providing the APIs required by the
interfaces. For example:

一个类可以通过 `implements` 关键字来实现一个或者多个接口，
并实现每个接口要求的 API。
例如：

<?code-excerpt "misc/lib/language_tour/classes/impostor.dart"?>
{% prettify dart %}
// A person. The implicit interface contains greet().
class Person {
  // In the interface, but visible only in this library.
  final _name;

  // Not in the interface, since this is a constructor.
  Person(this._name);

  // In the interface.
  String greet(String who) => 'Hello, $who. I am $_name.';
}

// An implementation of the Person interface.
class Impostor implements Person {
  get _name => '';

  String greet(String who) => 'Hi $who. Do you know who I am?';
}

String greetBob(Person person) => person.greet('Bob');

void main() {
  print(greetBob(Person('Kathy')));
  print(greetBob(Impostor()));
}
{% endprettify %}

Here’s an example of specifying that a class implements multiple
interfaces:

下面示例演示一个类如何实现多个接口：

<?code-excerpt "misc/lib/language_tour/classes/misc.dart (point_interfaces)"?>
{% prettify dart %}
class Point implements Comparable, Location {...}
{% endprettify %}


### Extending a class

### 扩展类（继承）

Use `extends` to create a subclass, and `super` to refer to the
superclass:

使用 `extends` 关键字来创建子类，使用 `super` 关键字来引用父类：

<?code-excerpt "misc/lib/language_tour/classes/extends.dart" replace="/extends|super/[!$&!]/g"?>
{% prettify dart %}
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

子类可以重写实例方法，getter 和 setter。
可以使用 `@override` 注解指出想要重写的成员：

<?code-excerpt "misc/lib/language_tour/metadata/television.dart (override)" replace="/@override/[!$&!]/g"?>
{% prettify dart %}
class SmartTelevision extends Television {
  [!@override!]
  void turnOn() {...}
  // ···
}
{% endprettify %}

To narrow the type of a method parameter or instance variable in code that is
[type safe](/guides/language/sound-dart),
you can use the [`covariant` keyword](/guides/language/sound-problems#the-covariant-keyword).


#### Overridable operators

#### 重写运算符

You can override the operators shown in the following table.
For example, if you define a
Vector class, you might define a `+` method to add two vectors.

下标的运算符可以被重写。
例如，想要实现两个向量对象相加，可以重写 `+` 方法。

`<`  | `+`  | `|`  | `[]`
`>`  | `/`  | `^`  | `[]=`
`<=` | `~/` | `&`  | `~`
`>=` | `*`  | `<<` | `==`
`–`  | `%`  | `>>`
{:.table}

<div class="alert alert-info" markdown="1">
  **Note:** You may have noticed that `!=` is not an overridable operator.
  The expression `e1 != e2` is just syntactic sugar for `!(e1 == e2)`.

   **提示：** 你可能会被提示 `!=` 运算符为非可重载运算符。
  因为 `e1 != e2` 表达式仅仅是 `!(e1 == e2)` 的语法糖。
</div>

Here’s an example of a class that overrides the `+` and `-` operators:

下面示例演示一个类重写 `+` 和 `-` 操作符：

<?code-excerpt "misc/lib/language_tour/classes/vector.dart"?>
{% prettify dart %}
class Vector {
  final int x, y;

  Vector(this.x, this.y);

  Vector operator +(Vector v) => Vector(x + v.x, y + v.y);
  Vector operator -(Vector v) => Vector(x - v.x, y - v.y);

  // Operator == and hashCode not shown. For details, see note below.
  // ···
}

void main() {
  final v = Vector(2, 3);
  final w = Vector(2, 2);

  assert(v + w == Vector(4, 5));
  assert(v - w == Vector(0, 1));
}
{% endprettify %}

If you override `==`, you should also override Object's `hashCode` getter.
For an example of overriding `==` and `hashCode`, see
[Implementing map keys](/guides/libraries/library-tour#implementing-map-keys).

如果要重写 `==` 操作符，需要重写对象的 `hashCode` getter 方法。
重写 `==` 和 `hashCode` 的实例，参考
[Implementing map keys](/guides/libraries/library-tour#implementing-map-keys)。

For more information on overriding, in general, see
[Extending a class](#extending-a-class).


有关重写的更多介绍，请参考
[扩展类（继承）](#extending-a-class).


#### noSuchMethod()

To detect or react whenever code attempts to use a non-existent method or
instance variable, you can override `noSuchMethod()`:

当代码尝试使用不存在的方法或实例变量时，
通过重写 `noSuchMethod()` 方法，来实现检测和应对处理：

<?code-excerpt "misc/lib/language_tour/classes/no_such_method.dart" replace="/noSuchMethod(?!,)/[!$&!]/g"?>
{% prettify dart %}
class A {
  // Unless you override noSuchMethod, using a
  // non-existent member results in a NoSuchMethodError.
  @override
  void [!noSuchMethod!](Invocation invocation) {
    print('You tried to use a non-existent member: ' +
        '${invocation.memberName}');
  }
}
{% endprettify %}

You **can't invoke** an unimplemented method unless
**one** of the following is true:

除非符合下面的任意一项条件，
否则没有实现的方法不能够被调用：

* The receiver has the static type `dynamic`.

  receiver 具有 `dynamic` 的静态类型 。

* The receiver has a static type that
defines the unimplemented method (abstract is OK),
and the dynamic type of the receiver has an implemention of `noSuchMethod()`
that's different from the one in class `Object`.

  receiver 具有静态类型，用于定义为实现的方法 (可以是抽象的),
并且 receiver 的动态类型具有 `noSuchMethod()` 的实现，
该实现与 `Object` 类中的实现不同。

For more information, see the informal
[noSuchMethod forwarding specification.](https://github.com/dart-lang/sdk/blob/master/docs/language/informal/nosuchmethod-forwarding.md)

有关更多信息，参考
[noSuchMethod forwarding specification.](https://github.com/dart-lang/sdk/blob/master/docs/language/informal/nosuchmethod-forwarding.md)


<a id="enums"></a>
### Enumerated types

### 枚举类型

Enumerated types, often called _enumerations_ or _enums_,
are a special kind of class used to represent
a fixed number of constant values.

枚举类型也称为 _enumerations_ 或 _enums_ ，
是一种特殊的类，用于表示数量固定的常量值。


#### Using enums

### 使用枚举

Declare an enumerated type using the `enum` keyword:

使用 `enum` 关键字定义一个枚举类型：

<?code-excerpt "misc/lib/language_tour/classes/enum.dart (enum)"?>
{% prettify dart %}
enum Color { red, green, blue }
{% endprettify %}

Each value in an enum has an `index` getter,
which returns the zero-based position of the value in the enum declaration.
For example, the first value has index 0,
and the second value has index 1.

枚举中的每个值都有一个 `index` getter 方法，
该方法返回值所在枚举类型定义中的位置（从 0 开始）。
例如，第一个枚举值的索引是 0 ，
第二个枚举值的索引是 1。

<?code-excerpt "misc/lib/language_tour/classes/enum.dart (index)"?>
{% prettify dart %}
assert(Color.red.index == 0);
assert(Color.green.index == 1);
assert(Color.blue.index == 2);
{% endprettify %}

To get a list of all of the values in the enum,
use the enum's `values` constant.

使用枚举的 `values` 常量，
获取所有枚举值列表（list）。

<?code-excerpt "misc/lib/language_tour/classes/enum.dart (values)"?>
{% prettify dart %}
List<Color> colors = Color.values;
assert(colors[2] == Color.blue);
{% endprettify %}

You can use enums in [switch statements](#switch-and-case), and
you'll get a warning if you don't handle all of the enum's values:

可以在 [switch 语句](#switch-和-case) 中使用枚举，
如果不处理所有枚举值，会收到警告：

<?code-excerpt "misc/lib/language_tour/classes/enum.dart (switch)"?>
{% prettify dart %}
var aColor = Color.blue;

switch (aColor) {
  case Color.red:
    print('Red as roses!');
    break;
  case Color.green:
    print('Green as grass!');
    break;
  default: // Without this, you see a WARNING.
    print(aColor); // 'Color.blue'
}
{% endprettify %}

Enumerated types have the following limits:

枚举类型具有以下限制：

* You can't subclass, mix in, or implement an enum.

  枚举不能被子类化，混合或实现。

* You can't explicitly instantiate an enum.

  枚举不能被显式实例化。

For more information, see the [Dart language specification][].

有关更多信息，参考 [Dart language specification][]。


### Adding features to a class: mixins

### 为类添加功能： Mixin

Mixins are a way of reusing a class's code in multiple class
hierarchies.

Mixin 是复用类代码的一种途径，
复用的类可以在不同层级，之间可以不存在继承关系。

To _use_ a mixin, use the `with` keyword followed by one or more mixin
names. The following example shows two classes that use mixins:

通过 `with` 后面跟一个或多个混入的名称，来 _使用_ Mixin ，
下面的示例演示了两个使用 Mixin 的类：

<?code-excerpt "misc/lib/language_tour/classes/orchestra.dart (Musician and Maestro)" replace="/(with.*) \{/[!$1!] {/g"?>
{% prettify dart %}
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

通过创建一个继承自 Object 且没有构造函数的类，来 _实现_ 一个 Mixin 。
如果 Mixin 不希望作为常规类被使用，使用关键字 `mixin` 替换 `class` 。
例如：

<?code-excerpt "misc/lib/language_tour/classes/orchestra.dart (Musical)"?>
{% prettify dart %}
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
{% endprettify %}

To specify that only certain types can use the mixin — for example,
so your mixin can invoke a method that it doesn't define —
use `on` to specify the required superclass:

指定只有某些类型可以使用的 Mixin -
比如， Mixin 可以调用 Mixin 自身没有定义的方法 -
使用 `on` 来指定可以使用 Mixin 的父类类型：


<?code-excerpt "misc/lib/language_tour/classes/orchestra.dart (mixin-on)"?>
{% prettify dart %}
mixin MusicalPerformer on Musician {
  // ···
}
{% endprettify %}

<!-- Previous code snippet reveals an issue we expect to be fixed in 2.1.1:
  https://github.com/dart-lang/sdk/issues/35011
-->

<aside class="alert alert-info" markdown="1">
  **Version note:** Support for the `mixin` keyword was introduced in Dart 2.1.

  **版本提示：** `mixin` 关键字在 Dart 2.1 中被引用支持。

  Code in earlier releases usually used `abstract class` instead.
  For more information on 2.1 mixin changes, see the
  [Dart SDK changelog][] and [2.1 mixin specification.][]

  早期版本中的代码通常使用 `abstract class` 代替。
  更多有关 Mixin 在 2.1 中的变更信息，请参见
  [Dart SDK changelog][] 和 [2.1 mixin specification][] 。
</aside>

[Dart SDK changelog]: https://github.com/dart-lang/sdk/blob/master/CHANGELOG.md
[2.1 mixin specification.]: https://github.com/dart-lang/language/blob/master/accepted/2.1/super-mixins/feature-specification.md#dart-2-mixin-declarations


### Class variables and methods

### 类变量和方法

Use the `static` keyword to implement class-wide variables and methods.

使用 `static` 关键字实现类范围的变量和方法。

#### Static variables

#### 静态变量

Static variables (class variables) are useful for class-wide state and
constants:

静态变量（类变量）对于类级别的状态是非常有用的：

<?code-excerpt "misc/lib/language_tour/classes/misc.dart (static-field)"?>
{% prettify dart %}
class Queue {
  static const initialCapacity = 16;
  // ···
}

void main() {
  assert(Queue.initialCapacity == 16);
}
{% endprettify %}

Static variables aren’t initialized until they’re used.

静态变量只到它们被使用的时候才会初始化。

<div class="alert alert-info" markdown="1">
**Note:**

**提示：**

This page follows the [style guide
recommendation](/guides/language/effective-dart/style#identifiers)
of preferring `lowerCamelCase` for constant names.

代码准守[风格推荐指南](/guides/language/effective-dart/style#identifiers)
中的命名规则， 使用 `lowerCamelCase` 来命名常量。
</div>

#### Static methods

#### 静态方法

Static methods (class methods) do not operate on an instance, and thus
do not have access to `this`. For example:

静态方法（类方法）不能在实例上使用，因此它们不能访问 `this` 。
例如：

<?code-excerpt "misc/lib/language_tour/classes/point_with_distance_method.dart"?>
{% prettify dart %}
import 'dart:math';

class Point {
  num x, y;
  Point(this.x, this.y);

  static num distanceBetween(Point a, Point b) {
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
{% endprettify %}

<div class="alert alert-info" markdown="1">
**Note:**

**提示：**

Consider using top-level functions, instead of static methods, for
common or widely used utilities and functionality.

对于常见或广泛使用的工具和函数，
应该考虑使用顶级函数而不是静态方法。
</div>

You can use static methods as compile-time constants. For example, you
can pass a static method as a parameter to a constant constructor.

静态函数可以当做编译时常量使用。
例如，可以将静态方法作为参数传递给常量构造函数。


## Generics

## 泛型

If you look at the API documentation for the basic array type,
[List,][List] you’ll see that the
type is actually `List<E>`. The \<...\> notation marks List as a
*generic* (or *parameterized*) type—a type that has formal type
parameters. [By convention][], most type variables have single-letter names,
such as E, T, S, K, and V.

在 API 文档中你会发现基础数组类型 [List] 的实际类型是 `List<E>` 。
\<...\> 符号将 List 标记为 *泛型* (或 *参数化*) 类型。
这种类型具有形式化的参数。
[通常情况下][By convention]，使用一个字母来代表类型参数， 例如 E, T, S, K, 和 V 等。

[By convention]: /guides/language/effective-dart/design#do-follow-existing-mnemonic-conventions-when-naming-type-parameters


### Why use generics?

### 为什么使用泛型

Generics are often required for type safety, but they have more benefits
than just allowing your code to run:

在类型安全上通常需要泛型支持，
它的好处不仅仅是保证代码的正常运行：

* Properly specifying generic types results in better generated code.

  正确指定泛型类型可以提高代码质量。

* You can use generics to reduce code duplication.

  使用泛型可以减少重复的代码。

If you intend for a list to contain only strings, you can
declare it as `List<String>` (read that as “list of string”). That way
you, your fellow programmers, and your tools can detect that assigning a non-string to
the list is probably a mistake. Here’s an example:

如果想让 List 仅仅支持字符串类型，
可以将其声明为 `List<String>` （读作“字符串类型的 list ”）。
那么，当一个非字符串被赋值给了这个 list 时，开发工具就能够检测到这样的做法可能存在错误。
例如：

{:.fails-sa}
<?code-excerpt "misc/lib/language_tour/generics/misc.dart (why-generics)"?>
{% prettify dart %}
var names = List<String>();
names.addAll(['Seth', 'Kathy', 'Lars']);
names.add(42); // Error
{% endprettify %}

Another reason for using generics is to reduce code duplication.
Generics let you share a single interface and implementation between
many types, while still taking advantage of static
analysis. For example, say you create an interface for
caching an object:

另外一个使用泛型的原因是减少重复的代码。
泛型可以在多种类型之间定义同一个实现，
同时还可以继续使用检查模式和静态分析工具提供的代码分析功能。
例如，假设你创建了一个用于缓存对象的接口：

<?code-excerpt "misc/lib/language_tour/generics/cache.dart (ObjectCache)"?>
{% prettify dart %}
abstract class ObjectCache {
  Object getByKey(String key);
  void setByKey(String key, Object value);
}
{% endprettify %}

You discover that you want a string-specific version of this interface,
so you create another interface:

后来发现需要一个相同功能的字符串类型接口，因此又创建了另一个接口：

<?code-excerpt "misc/lib/language_tour/generics/cache.dart (StringCache)"?>
{% prettify dart %}
abstract class StringCache {
  String getByKey(String key);
  void setByKey(String key, String value);
}
{% endprettify %}

Later, you decide you want a number-specific version of this
interface... You get the idea.

后来，又发现需要一个相同功能的数字类型接口 ...
这里你应该明白了。

Generic types can save you the trouble of creating all these interfaces.
Instead, you can create a single interface that takes a type parameter:

泛型可以省去创建所有这些接口的麻烦。
通过创建一个带有泛型参数的接口，来代替上述接口：

<?code-excerpt "misc/lib/language_tour/generics/cache.dart (Cache)"?>
{% prettify dart %}
abstract class Cache<T> {
  T getByKey(String key);
  void setByKey(String key, T value);
}
{% endprettify %}

In this code, T is the stand-in type. It’s a placeholder that you can
think of as a type that a developer will define later.

在上面的代码中，T 是一个备用类型。
这是一个类型占位符，在开发者调用该接口的时候会指定具体类型。


### Using collection literals

### 使用集合字面量

List, set, and map literals can be parameterized. Parameterized literals are
just like the literals you’ve already seen, except that you add
<code>&lt;<em>type</em>></code> (for lists and sets) or
<code>&lt;<em>keyType</em>, <em>valueType</em>></code> (for maps)
before the opening bracket. Here
is example of using typed literals:

List , Set 和 Map 字面量也是可以参数化的。
参数化字面量和之前的字面量定义类似，
对于 List 或 Set 只需要在声明语句前加
<code>&lt;<em>type</em>></code> 前缀，
对于 Map 只需要在声明语句前加
<code>&lt;<em>keyType</em>, <em>valueType</em>></code> 前缀，
下面是参数化字面量的示例：

<?code-excerpt "misc/lib/language_tour/generics/misc.dart (collection-literals)"?>
{% prettify dart %}
var names = <String>['Seth', 'Kathy', 'Lars'];
var uniqueNames = <String>{'Seth', 'Kathy', 'Lars'};
var pages = <String, String>{
  'index.html': 'Homepage',
  'robots.txt': 'Hints for web robots',
  'humans.txt': 'We are people, not machines'
};
{% endprettify %}


### Using parameterized types with constructors

### 使用泛型类型的构造函数

To specify one or more types when using a constructor, put the types in
angle brackets (`<...>`) just after the class name. For example:

在调用构造函数的时，在类名字后面使用尖括号（`<...>`）来指定泛型类型。
例如：

<?code-excerpt "misc/test/language_tour/generics_test.dart (constructor-1)"?>
{% prettify dart %}
var nameSet = Set<String>.from(names);
{% endprettify %}

{% comment %}[PENDING: update this sample; it ]{% endcomment %}

The following code creates a map that has integer keys and values of
type View:

下面代码创建了一个 key 为 integer， value 为 View 的 map 对象：

<?code-excerpt "misc/test/language_tour/generics_test.dart (constructor-2)"?>
{% prettify dart %}
var views = Map<int, View>();
{% endprettify %}


### Generic collections and the types they contain

### 运行时中的泛型集合

Dart generic types are *reified*, which means that they carry their type
information around at runtime. For example, you can test the type of a
collection:

Dart 中泛型类型是 *固化的*，也就是说它们在运行时是携带着类型信息的。
例如，
在运行时检测集合的类型：

<?code-excerpt "misc/test/language_tour/generics_test.dart (generic-collections)"?>
{% prettify dart %}
var names = List<String>();
names.addAll(['Seth', 'Kathy', 'Lars']);
print(names is List<String>); // true
{% endprettify %}

<div class="alert alert-info" markdown="1">
**Note:**

**提示：**

In contrast, generics in Java use *erasure*, which means that generic
type parameters are removed at runtime. In Java, you can test whether
an object is a List, but you can’t test whether it’s a `List<String>`.

相反，Java中的泛型会被 *擦除* ，也就是说在运行时泛型类型参数的信息是不存在的。
在Java中，可以测试对象是否为 List 类型，
但无法测试它是否为 `List<String>` 。
</div>


### Restricting the parameterized type

### 限制泛型类型

When implementing a generic type,
you might want to limit the types of its parameters.
You can do this using `extends`.

使用泛型类型的时候，
可以使用 `extends` 实现参数类型的限制。

<?code-excerpt "misc/lib/language_tour/generics/base_class.dart" replace="/extends SomeBaseClass(?=. \{)/[!$&!]/g"?>
{% prettify dart %}
class Foo<T [!extends SomeBaseClass!]> {
  // Implementation goes here...
  String toString() => "Instance of 'Foo<$T>'";
}

class Extender extends SomeBaseClass {...}
{% endprettify %}

It's OK to use `SomeBaseClass` or any of its subclasses as generic argument:

可以使用 `SomeBaseClass` 或其任意子类作为通用参数：

<?code-excerpt "misc/test/language_tour/generics_test.dart (SomeBaseClass-ok)" replace="/Foo.\w+./[!$&!]/g"?>
{% prettify dart %}
var someBaseClassFoo = [!Foo<SomeBaseClass>!]();
var extenderFoo = [!Foo<Extender>!]();
{% endprettify %}

It's also OK to specify no generic argument:

也可以不指定泛型参数：

<?code-excerpt "misc/test/language_tour/generics_test.dart (no-generic-arg-ok)" replace="/expect\((.*?).toString\(\), .(.*?).\);/print($1); \/\/ $2/g"?>
{% prettify dart %}
var foo = Foo();
print(foo); // Instance of 'Foo<SomeBaseClass>'
{% endprettify %}

Specifying any non-`SomeBaseClass` type results in an error:

指定任何非 `SomeBaseClass` 类型会导致错误：

{:.fails-sa}
<?code-excerpt "misc/lib/language_tour/generics/misc.dart (Foo-Object-error)" replace="/Foo.\w+./[!$&!]/g"?>
{% prettify dart %}
var foo = [!Foo<Object>!]();
{% endprettify %}


### Using generic methods


### 使用泛型函数

Initially, Dart's generic support was limited to classes.
A newer syntax, called _generic methods_, allows type arguments on methods and functions:

最初，Dart 的泛型只能用于类。
新语法_泛型方法_，允许在方法和函数上使用类型参数：

<!-- {{site.dartpad}}/a02c53b001977efa4d803109900f21bb -->
<!-- https://gist.github.com/a02c53b001977efa4d803109900f21bb -->
<?code-excerpt "misc/test/language_tour/generics_test.dart (method)" replace="/<T.(?=\()|T/[!$&!]/g"?>
{% prettify dart %}
[!T!] first[!<T>!](List<[!T!]> ts) {
  // Do some initial work or error checking, then...
  [!T!] tmp = ts[0];
  // Do some additional checking or processing...
  return tmp;
}
{% endprettify %}

Here the generic type parameter on `first` (`<T>`)
allows you to use the type argument `T` in several places:

这里的 `first` (`<T>`)
泛型可以在如下地方使用参数 `T` ：

* In the function's return type (`T`).

  函数的返回值类型 (`T`)。

* In the type of an argument (`List<T>`).

  参数的类型 (`List<T>`)。

* In the type of a local variable (`T tmp`).

  局部变量的类型 (`T tmp`)。

For more information about generics, see
[Using Generic Methods.](https://github.com/dart-lang/sdk/blob/master/pkg/dev_compiler/doc/GENERIC_METHODS.md)

关于泛型的更多信息，参考
[使用泛型函数](https://github.com/dart-lang/sdk/blob/master/pkg/dev_compiler/doc/GENERIC_METHODS.md)


## Libraries and visibility

## 库和可见性

The `import` and `library` directives can help you create a
modular and shareable code base. Libraries not only provide APIs, but
are a unit of privacy: identifiers that start with an underscore (\_)
are visible only inside the library. *Every Dart app is a library*, even
if it doesn’t use a `library` directive.

`import` 和 `library` 指令可以用来创建一个模块化的，可共享的代码库。
库不仅提供了 API ，而且对代码起到了封装的作用：
以下划线 (\_) 开头的标识符仅在库内可见。
*每个 Dart 应用程序都是一个库* ，虽然没有使用 `library` 指令。

Libraries can be distributed using [packages](/guides/packages).

库可以通过[包](/guides/packages)来分发。


### Using libraries


### 使用库

Use `import` to specify how a namespace from one library is used in the
scope of another library.

通过 `import` 指定一个库命名空间中的内如如何在另一个库中使用。

For example, Dart web apps generally use the [dart:html][]
library, which they can import like this:

例如，Dart Web应用程序通常使用 [dart:html][] 库，它们可以像这样导入：

<?code-excerpt "misc/test/language_tour/browser_test.dart (dart-html-import)"?>
{% prettify dart %}
import 'dart:html';
{% endprettify %}

The only required argument to `import` is a URI specifying the
library.
For built-in libraries, the URI has the special `dart:` scheme.
For other libraries, you can use a file system path or the `package:`
scheme. The `package:` scheme specifies libraries provided by a package
manager such as the pub tool. For example:

`import` 参数只需要一个指向库的 URI。
对于内置库，URI 拥有自己特殊的`dart:` 方案。
对于其他的库，使用系统文件路径或者 `package:` 方案 。
`package:` 方案指定由包管理器（如 pub 工具）提供的库。例如：

<?code-excerpt "misc/test/language_tour/browser_test.dart (package-import)"?>
{% prettify dart %}
import 'package:test/test.dart';
{% endprettify %}

<div class="alert alert-info" markdown="1">
**Note:**

**提示：**

*URI* stands for uniform resource identifier.

*URI* 代表统一资源标识符。

*URLs* (uniform resource locators) are a common kind of URI.

*URL*（统一资源定位符）是一种常见的URI。
</div>


#### Specifying a library prefix

#### 指定库前缀

If you import two libraries that have conflicting identifiers, then you
can specify a prefix for one or both libraries. For example, if library1
and library2 both have an Element class, then you might have code like
this:

如果导入两个存在冲突标识符的库，
则可以为这两个库，或者其中一个指定前缀。
例如，如果 library1 和 library2 都有一个 Element 类，
那么可以通过下面的方式处理：

<?code-excerpt "misc/lib/language_tour/libraries/import_as.dart" replace="/(lib\d)\.dart/package:$1\/$&/g"?>
{% prettify dart %}
import 'package:lib1/lib1.dart';
import 'package:lib2/lib2.dart' as lib2;

// Uses Element from lib1.
Element element1 = Element();

// Uses Element from lib2.
lib2.Element element2 = lib2.Element();
{% endprettify %}

#### Importing only part of a library

#### 导入库的一部分

If you want to use only part of a library, you can selectively import
the library. For example:

如果你只使用库的一部分功能，则可以选择需要导入的
内容。例如：

<?code-excerpt "misc/lib/language_tour/libraries/show_hide.dart" replace="/(lib\d)\.dart/package:$1\/$&/g"?>
{% prettify dart %}
// Import only foo.
import 'package:lib1/lib1.dart' show foo;

// Import all names EXCEPT foo.
import 'package:lib2/lib2.dart' hide foo;
{% endprettify %}

<a id="deferred-loading"></a>
#### Lazily loading a library

#### 延迟加载库

_Deferred loading_ (also called _lazy loading_)
allows a web app to load a library on demand,
if and when the library is needed.
Here are some cases when you might use deferred loading:

_Deferred loading_ (也称之为 _lazy loading_)
可以让应用在需要的时候再加载库。
下面是一些使用延迟加载库的场景：

* To reduce a web app's initial startup time.

  减少 APP 的启动时间。

* To perform A/B testing—trying out
  alternative implementations of an algorithm, for example.

  执行 A/B 测试，例如 尝试各种算法的
  不同实现。

* To load rarely used functionality, such as optional screens and dialogs.

  加载很少使用的功能，例如可选的屏幕和对话框。

<aside class="alert alert-warning" markdown="1">

**Only dart2js supports deferred loading.**
Flutter, the Dart VM, and dartdevc don't support deferred loading.
For more information, see
[issue #33118](https://github.com/dart-lang/sdk/issues/33118) and
[issue #27776.](https://github.com/dart-lang/sdk/issues/27776)

**只有 dart2js 目前支持延迟加载**
Flutter、Dart 运行环境以及 dartdevc 目前都不支持延迟加载。
更多信息可参见 [issue #33118](https://github.com/dart-lang/sdk/issues/33118)
和 [issue #27776](https://github.com/dart-lang/sdk/issues/27776)。

</aside>

To lazily load a library, you must first
import it using `deferred as`.

要延迟加载一个库，需要先使用 `deferred as` 来导入：

<?code-excerpt "misc/lib/language_tour/libraries/greeter.dart (import)" replace="/hello\.dart/package:greetings\/$&/g"?>
{% prettify dart %}
import 'package:greetings/hello.dart' deferred as hello;
{% endprettify %}

When you need the library, invoke
`loadLibrary()` using the library's identifier.

当需要使用的时候，使用库标识符调用
`loadLibrary()` 函数来加载库：

<?code-excerpt "misc/lib/language_tour/libraries/greeter.dart (loadLibrary)"?>
{% prettify dart %}
Future greet() async {
  await hello.loadLibrary();
  hello.printGreeting();
}
{% endprettify %}

In the preceding code,
the `await` keyword pauses execution until the library is loaded.
For more information about `async` and `await`,
see [asynchrony support](#asynchrony-support).

在前面的代码，使用 `await` 关键字暂停代码执行一直到库加载完成。
关于 `async` 和 `await` 的更多信息请参考 [异步支持](#asynchrony-support)。

You can invoke `loadLibrary()` multiple times on a library without problems.
The library is loaded only once.

在一个库上你可以多次调用 `loadLibrary()` 函数。但是该库只是载入一次。

Keep in mind the following when you use deferred loading:

使用延迟加载库的时候，请注意一下问题：

* A deferred library's constants aren't constants in the importing file.
  Remember, these constants don't exist until the deferred library is loaded.

  延迟加载库的常量在导入的时候是不可用的。
  只有当库加载完毕的时候，库中常量才可以使用。

* You can't use types from a deferred library in the importing file.
  Instead, consider moving interface types to a library imported by
  both the deferred library and the importing file.

  在导入文件的时候无法使用延迟库中的类型。
  如果你需要使用类型，则考虑把接口类型移动到另外一个库中，
  让两个库都分别导入这个接口库。

* Dart implicitly inserts `loadLibrary()` into the namespace that you define
  using <code>deferred as <em>namespace</em></code>.
  The `loadLibrary()` function returns a [Future](/guides/libraries/library-tour#future).

<<<<<<< HEAD
  Dart 隐含的把 `loadLibrary()` 函数导入到使用
  <code>deferred as <em>的命名空间</em></code> 中。
  `loadLibrary()` 方法返回一个 [Future](/guides/libraries/library-tour#future)。

<aside class="alert alert-warning" markdown="1">
**Dart VM difference:**
The Dart VM allows access to members of deferred libraries
even before the call to `loadLibrary()`.
This behavior might change, so
**don't depend on the current VM behavior.**
For details, see [issue #33118.](https://github.com/dart-lang/sdk/issues/33118)
</aside>
=======
>>>>>>> 76d4c36ea7c56b6ef0930039ed9815df53987ce7

### Implementing libraries

### 实现库

See
[Create Library Packages](/guides/libraries/create-library-packages)
for advice on how to implement a library package, including:

有关如何实现库包的建议，请参考
[Create Library Packages](/guides/libraries/create-library-packages)
这里面包括：

* How to organize library source code.

  如何组织库的源文件。

* How to use the `export` directive.

  如何使用 `export` 命令。

* When to use the `part` directive.

  何时使用 `part` 命令。

* When to use the `library` directive.

  何时使用 `library` 命令。


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

Dart 库中包含许多返回 Future 或 Stream 对象的函数.
这些函数在设置完耗时任务（例如 I/O 曹组）后，
就立即返回了，不会等待耗任务完成。

The `async` and `await` keywords support asynchronous programming,
letting you write asynchronous code that
looks similar to synchronous code.

使用 `async` 和 `await` 关键字实现异步编程。
可以让你像编写同步代码一样实现异步操作。

<a id="await"></a>
### Handling Futures

### 处理 Future

When you need the result of a completed Future,
you have two options:

可以通过下面两种方式，获得 Future 执行完成的结果：

* Use `async` and `await`.

  使用 `async` 和 `await`。

* Use the Future API, as described
  [in the library tour](/guides/libraries/library-tour#future).

  使用 Future API，具体描述，参考
  [库概览](/guides/libraries/library-tour#future)。

Code that uses `async` and `await` is asynchronous,
but it looks a lot like synchronous code.
For example, here's some code that uses `await`
to wait for the result of an asynchronous function:

使用 `async` 和 `await` 关键字的代码是异步的。
虽然看起来有点想同步代码。
例如，下面的代码使用 `await`
等待异步函数的执行结果。

<?code-excerpt "misc/lib/language_tour/async.dart (await-lookUpVersion)"?>
{% prettify dart %}
await lookUpVersion();
{% endprettify %}

To use `await`, code must be in an _async function_—a
function marked as `async`:

要使用 `await` ，
代码必须在 _异步函数_（使用 `async` 标记的函数）中：

<?code-excerpt "misc/lib/language_tour/async.dart (checkVersion)" replace="/async|await/[!$&!]/g"?>
{% prettify dart %}
Future checkVersion() [!async!] {
  var version = [!await!] lookUpVersion();
  // Do something with version
}
{% endprettify %}

<aside class="alert alert-info" markdown="1">
**Note:**

**提示：**

Although an async function might perform time-consuming operations,
it doesn't wait for those operations.
Instead, the async function executes only until it encounters
its first `await` expression
([details][synchronous-async-start]).
Then it returns a Future object,
resuming execution only after the `await` expression completes.

虽然异步函数可能会执行耗时的操作，
但它不会等待这些操作。
相反，异步函数只有在遇到第一个 `await` 表达式（[详情见][synchronous-async-start]）时才会执行。
也就是说，它返回一个 Future 对象，
仅在await表达式完成后才恢复执行。
</aside>

Use `try`, `catch`, and `finally`
to handle errors and cleanup in code that uses `await`:

使用 `try`， `catch`， 和 `finally`
来处理代码中使用 `await` 导致的错误。

<?code-excerpt "misc/lib/language_tour/async.dart (try-catch)"?>
{% prettify dart %}
try {
  version = await lookUpVersion();
} catch (e) {
  // React to inability to look up the version
}
{% endprettify %}

You can use `await` multiple times in an async function.
For example, the following code waits three times
for the results of functions:

在一个异步函数中可以多次使用 `await` 。
例如，下面代码中等待了三次函数结果：


<?code-excerpt "misc/lib/language_tour/async.dart (repeated-await)"?>
{% prettify dart %}
var entrypoint = await findEntrypoint();
var exitCode = await runExecutable(entrypoint, args);
await flushThenExit(exitCode);
{% endprettify %}

In <code>await <em>expression</em></code>,
the value of <code><em>expression</em></code> is usually a Future;
if it isn't, then the value is automatically wrapped in a Future.
This Future object indicates a promise to return an object.
The value of <code>await <em>expression</em></code> is that returned object.
The await expression makes execution pause until that object is available.

在 <code>await <em>表达式</em></code> 中，
<code><em>表达式</em></code> 的值通常是一个 Future 对象；
如果不是，这是表达式的值会被自动包装成一个 Future 对象。
Future 对象指明返回一个对象的承诺（promise）。
<code>await <em>表达式</em></code> 执行的结果为这个返回的对象。
await 表达式会阻塞代码的执行，直到需要的对象返回为止。

**If you get a compile-time error when using `await`,
make sure `await` is in an async function.**
For example, to use `await` in your app's `main()` function,
the body of `main()` must be marked as `async`:

**如果在使用 `await` 导致编译时错误，
确认 `await` 是否在一个异步函数中。**
例如，在应用的 `main()` 函数中使用 `await` ，
`main()` 函数的函数体必须被标记为 `async` ：

<?code-excerpt "misc/lib/language_tour/async.dart (main)" replace="/async|await/[!$&!]/g"?>
{% prettify dart %}
Future main() [!async!] {
  checkVersion();
  print('In main: version is ${[!await!] lookUpVersion()}');
}
{% endprettify %}


<a id="async"></a>
### Declaring async functions

### 声明异步函数

An _async function_ is a function whose body is marked with
the `async` modifier.

函数体被 `async` 标示符标记的函数，即是一个 _异步函数_。

Adding the `async` keyword to a function makes it return a Future.
For example, consider this synchronous function,
which returns a String:

将 `async` 关键字添加到函数使其返回Future。
例如，考虑下面的同步函数，它返回一个 String ：

<?code-excerpt "misc/lib/language_tour/async.dart (sync-lookUpVersion)"?>
{% prettify dart %}
String lookUpVersion() => '1.0.0';
{% endprettify %}

If you change it to be an async function—for example,
because a future implementation will be time consuming—the
returned value is a Future:

例如，将来的实现将非常耗时，将其更改为异步函数，返回值是 Future：

<?code-excerpt "misc/lib/language_tour/async.dart (async-lookUpVersion)"?>
{% prettify dart %}
Future<String> lookUpVersion() async => '1.0.0';
{% endprettify %}

Note that the function's body doesn't need to use the Future API.
Dart creates the Future object if necessary.

注意，函数体不需要使用Future API。
如有必要， Dart 会创建 Future 对象。

If your function doesn't return a useful value,
make its return type `Future<void>`.

如果函数没有返回有效值，
需要设置其返回类型为 `Future<void>` 。

{% comment %}
PENDING: add example here

Where else should we cover generalized void?
{% endcomment %}


<a id="await-for"></a>
### Handling Streams

### 处理 Stream

When you need to get values from a Stream,
you have two options:

当需要从 Stream 中获取数据值时，
可以通过一下两种方式：

* Use `async` and an _asynchronous for loop_ (`await for`).

  使用 `async` 和 一个 _异步循环_ （`await for`）。

* Use the Stream API, as described
  [in the library tour](/guides/libraries/library-tour#stream).

  使用 Stream API, 更多详情，参考
  [in the library tour](/guides/libraries/library-tour#stream)。

<aside class="alert alert-warning" markdown="1">
**Note:**

**提示：**

Before using `await for`, be sure that it makes the code clearer
and that you really do want to wait for all of the stream's results.
For example, you usually should **not** use `await for` for UI event listeners,
because UI frameworks send endless streams of events.

在使用 `await for` 前，确保代码清晰，
并且确实希望等待所有流的结果。
例如，通常不应该使用 `await for` 的UI事件侦听器，
因为UI框架会发送无穷无尽的事件流。
</aside>

An asynchronous for loop has the following form:

以下是异步for循环的使用形式：

<?code-excerpt "misc/lib/language_tour/async.dart (await-for)"?>
{% prettify dart %}
await for (varOrType identifier in expression) {
  // Executes each time the stream emits a value.
}
{% endprettify %}

The value of <code><em>expression</em></code> must have type Stream.
Execution proceeds as follows:

上面 <code><em>表达式</em></code> 返回的值必须是 Stream 类型。
执行流程如下：

1. Wait until the stream emits a value.

   等待，直到流发出一个值。

2. Execute the body of the for loop,
   with the variable set to that emitted value.

   执行 for 循环体，将变量设置为该发出的值

3. Repeat 1 and 2 until the stream is closed.

   重复1和2，直到关闭流。

To stop listening to the stream,
you can use a `break` or `return` statement,
which breaks out of the for loop
and unsubscribes from the stream.

使用  break` 或者 `return` 语句可以停止接收 stream 的数据，
这样就跳出了 for 循环，
并且从 stream 上取消注册。

**If you get a compile-time error when implementing an asynchronous for loop,
make sure the `await for` is in an async function.**
For example, to use an asynchronous for loop in your app's `main()` function,
the body of `main()` must be marked as `async`:

**如果在实现异步 for 循环时遇到编译时错误，
请检查确保 `await for` 处于异步函数中。**
例如，要在应用程序的 `main()` 函数中使用异步 fo r循环，
`main()` 函数体必须标记为 `async` ：

<?code-excerpt "misc/lib/language_tour/async.dart (number_thinker)" replace="/async|await for/[!$&!]/g"?>
{% prettify dart %}
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

有关异步编程的更多信息，请参考
[dart:async](/guides/libraries/library-tour#dartasync---asynchronous-programming)
部分。


<a id="generator"></a>
## Generators

## 生成器

When you need to lazily produce a sequence of values,
consider using a _generator function_.
Dart has built-in support for two kinds of generator functions:

当您需要延迟生成( lazily produce )一系列值时，
可以考虑使用_生成器函数_。
Dart 内置支持两种生成器函数：

* **Synchronous** generator: Returns an **[Iterable]** object.

  **Synchronous** 生成器： 返回一个 **[Iterable]** 对象。

* **Asynchronous** generator: Returns a **[Stream]** object.

  **Asynchronous** 生成器： 返回一个 **[Stream]** 对象。

To implement a **synchronous** generator function,
mark the function body as `sync*`,
and use `yield` statements to deliver values:

通过在函数体标记 `sync*`，
可以实现一个**同步**生成器函数。
使用 `yield` 语句来传递值：

<?code-excerpt "misc/test/language_tour/async_test.dart (sync-generator)"?>
{% prettify dart %}
Iterable<int> naturalsTo(int n) sync* {
  int k = 0;
  while (k < n) yield k++;
}
{% endprettify %}

To implement an **asynchronous** generator function,
mark the function body as `async*`,
and use `yield` statements to deliver values:

通过在函数体标记 `async*`，
可以实现一个**异步**生成器函数。
使用 `yield` 语句来传递值：

<?code-excerpt "misc/test/language_tour/async_test.dart (async-generator)"?>
{% prettify dart %}
Stream<int> asynchronousNaturalsTo(int n) async* {
  int k = 0;
  while (k < n) yield k++;
}
{% endprettify %}

If your generator is recursive,
you can improve its performance by using `yield*`:

如果生成器是递归的，可以使用 `yield*` 来提高其性能：

<?code-excerpt "misc/test/language_tour/async_test.dart (recursive-generator)"?>
{% prettify dart %}
Iterable<int> naturalsDownFrom(int n) sync* {
  if (n > 0) {
    yield n;
    yield* naturalsDownFrom(n - 1);
  }
}
{% endprettify %}


## Callable classes

## 可调用类

To allow an instance of your Dart class to be called like a function,
implement the `call()` method.

通过实现类的 `call()` 方法，允许使用类似函数调用的方式来使用该类的实例。

In the following example, the `WannabeFunction` class defines
a call() function that takes three strings and concatenates them,
separating each with a space, and appending an exclamation.
Click the run button {% asset red-run.png alt="" %} to execute the code.

在下面的示例中，`WannabeFunction` 类定义了一个 call() 函数，
函数接受三个字符串参数，函数体将三个字符串拼接，字符串间用空格分割，并在结尾附加了一个感叹号。
单击运行按钮 {% asset red-run.png alt="" %} 执行代码。

{% comment %}
https://gist.github.com/405379bacf30335f3aed
{{site.dartpad}}/405379bacf30335f3aed

<?code-excerpt "misc/lib/language_tour/callable_classes.dart"?>
{% prettify dart %}
class WannabeFunction {
  String call(String a, String b, String c) => '$a $b $c!';
}

var wf = WannabeFunction();
var out = wf('Hi', 'there,', 'gang');

main() => print(out);
{% endprettify %}
{% endcomment %}

<iframe
src="{{site.custom.dartpad.embed-inline-prefix}}?id=405379bacf30335f3aed&verticalRatio=73"
    width="100%"
    height="240px"
    style="border: 1px solid #ccc;">
</iframe>


## Isolates

Most computers, even on mobile platforms, have multi-core CPUs.
To take advantage of all those cores, developers traditionally use
shared-memory threads running concurrently. However, shared-state
concurrency is error prone and can lead to complicated code.

大多数计算机中，甚至在移动平台上，都在使用多核CPU。
为了有效利用多核性能，开发者一般使用共享内存数据来保证多线程的正确执行。
然而，
多线程共享数据通常会导致很多潜在的问题，并导致代码运行出错。

Instead of threads, all Dart code runs inside of *isolates*. Each
isolate has its own memory heap, ensuring that no isolate’s state is
accessible from any other isolate.

<<<<<<< HEAD
所有 Dart 代码都在*隔离区*（ isolates ）内运行，而不是线程。
每个隔离区都有自己的内存堆，确保每个隔离区的状态都不会被其他隔离区访问。

For more information, see the
[dart:isolate library documentation.][dart:isolate]
=======
For more information, see the following:
* [Dart asynchronous programming: Isolates and event loops][isolates article]
* [dart:isolate API reference,][dart:isolate]
  including [Isolate.spawn()][] and
  [TransferableTypedData][]
* [Background parsing][background json] cookbook on the Flutter site

[isolates article]: https://medium.com/dartlang/dart-asynchronous-programming-isolates-and-event-loops-bffc3e296a6a
[Isolate.spawn()]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-isolate/Isolate/spawn.html
[TransferableTypedData]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-isolate/TransferableTypedData-class.html
[background json]: {{site.flutter}}/docs/cookbook/networking/background-parsing
>>>>>>> f26718e0e9d8b8ecf13131688ad7d0ab11a6c3ec

有关更多信息，请参考
[dart:isolate library documentation.][dart:isolate]。

## Typedefs

In Dart, functions are objects, just like strings and numbers are
objects. A *typedef*, or *function-type alias*, gives a function type a
name that you can use when declaring fields and return types. A typedef
retains type information when a function type is assigned to a variable.

在 Dart 中，函数也是对象，就想字符和数字对象一样。
使用 *typedef* ，或者 *function-type alias* 为函数起一个别名，
别名可以用来声明字段及返回值类型。
当函数类型分配给变量时，typedef会保留类型信息。

Consider the following code, which doesn't use a typedef:

请考虑以下代码，代码中未使用 typedef ：

<?code-excerpt "misc/lib/language_tour/typedefs/sorted_collection_1.dart"?>
{% prettify dart %}
class SortedCollection {
  Function compare;

  SortedCollection(int f(Object a, Object b)) {
    compare = f;
  }
}

// Initial, broken implementation.
int sort(Object a, Object b) => 0;

void main() {
  SortedCollection coll = SortedCollection(sort);

  // All we know is that compare is a function,
  // but what type of function?
  assert(coll.compare is Function);
}
{% endprettify %}

Type information is lost when assigning `f` to `compare`. The type of
`f` is `(Object, ``Object)` → `int` (where → means returns), yet the
type of `compare` is Function. If we change the code to use explicit
names and retain type information, both developers and tools can use
that information.

当把  `f` 赋值给 `compare` 的时候，类型信息丢失了。
`f` 的类型是 `(Object, ``Object)` → `int` (这里 → 代表返回值类型)，
但是 `compare` 得到的类型是 Function 。如果我们使用显式的名字并保留类型信息，
这样开发者和工具都可以使用这些信息。

<?code-excerpt "misc/lib/language_tour/typedefs/sorted_collection_2.dart"?>
{% prettify dart %}
typedef Compare = int Function(Object a, Object b);

class SortedCollection {
  Compare compare;

  SortedCollection(this.compare);
}

// Initial, broken implementation.
int sort(Object a, Object b) => 0;

void main() {
  SortedCollection coll = SortedCollection(sort);
  assert(coll.compare is Function);
  assert(coll.compare is Compare);
}
{% endprettify %}

<aside class="alert alert-info" markdown="1">
**Note:**

**提示：**

Currently, typedefs are restricted to function types. We expect this
to change.

目前，typedefs 只能使用在函数类型上，
我们希望将来这种情况有所改变。
</aside>

Because typedefs are simply aliases, they offer a way to check the type
of any function. For example:

由于 typedefs 只是别名，
他们还提供了一种方式来判断任意函数的类型。例如：

<?code-excerpt "misc/lib/language_tour/typedefs/misc.dart (compare)"?>
{% prettify dart %}
typedef Compare<T> = int Function(T a, T b);

int sort(int a, int b) => a - b;

void main() {
  assert(sort is Compare<int>); // True!
}
{% endprettify %}

## Metadata

## 元数据

Use metadata to give additional information about your code. A metadata
annotation begins with the character `@`, followed by either a reference
to a compile-time constant (such as `deprecated`) or a call to a
constant constructor.

使用元数据可以提供有关代码的其他信息。
元数据注释以字符 `@` 开头，
后跟对编译时常量 (如 `deprecated`) 的引用或对常量构造函数的调用。

Two annotations are available to all Dart code: `@deprecated` and
`@override`. For examples of using `@override`,
see [Extending a class](#extending-a-class).
Here’s an example of using the `@deprecated`
annotation:

对于所有 Dart 代码有两种可用注解：`@deprecated` 和 `@override`。
关于 `@override` 的使用，
参考 [扩展类（继承）](#扩展类继承)。
下面是使用 `@deprecated` 注解的示例：

<?code-excerpt "misc/lib/language_tour/metadata/television.dart (deprecated)" replace="/@deprecated/[!$&!]/g"?>
{% prettify dart %}
class Television {
  /// _Deprecated: Use [turnOn] instead._
  [!@deprecated!]
  void activate() {
    turnOn();
  }

  /// Turns the TV's power on.
  void turnOn() {...}
}
{% endprettify %}

You can define your own metadata annotations. Here’s an example of
defining a @todo annotation that takes two arguments:

可以自定义元数据注解。
下面的示例定义了一个带有两个参数的 @todo 注解：

<?code-excerpt "misc/lib/language_tour/metadata/todo.dart"?>
{% prettify dart %}
library todo;

class Todo {
  final String who;
  final String what;

  const Todo(this.who, this.what);
}
{% endprettify %}

And here’s an example of using that @todo annotation:

使用 @todo 注解的示例：

<?code-excerpt "misc/lib/language_tour/metadata/misc.dart"?>
{% prettify dart %}
import 'todo.dart';

@Todo('seth', 'make this do something')
void doSomething() {
  print('do something');
}
{% endprettify %}

Metadata can appear before a library, class, typedef, type parameter,
constructor, factory, function, field, parameter, or variable
declaration and before an import or export directive. You can
retrieve metadata at runtime using reflection.

元数据可以在 library、 class、 typedef、 type parameter、
constructor、 factory、 function、 field、 parameter 或者 variable
声明之前使用，也可以在 import 或者 export 指令之前使用。
使用反射可以在运行时获取元数据信息。


## Comments

## 注释

Dart supports single-line comments, multi-line comments, and
documentation comments.

Dart 支持单行注释、多行注释和文档注释。

### Single-line comments

### 单行注释

A single-line comment begins with `//`. Everything between `//` and the
end of line is ignored by the Dart compiler.

单行注释以 `//` 开始。
所有在 `//` 和改行结尾之间的内容被编译器忽略。

<?code-excerpt "misc/lib/language_tour/comments.dart (single-line-comments)"?>
{% prettify dart %}
void main() {
  // TODO: refactor into an AbstractLlamaGreetingFactory?
  print('Welcome to my Llama farm!');
}
{% endprettify %}


### Multi-line comments

### 多行注释

A multi-line comment begins with `/*` and ends with `*/`. Everything
between `/*` and `*/` is ignored by the Dart compiler (unless the
comment is a documentation comment; see the next section). Multi-line
comments can nest.

多行注释以  `/*`  开始， 以 `*/` 结尾。
所有在 `/*` 和 `*/` 之间的内容被编译器忽略
（不会忽略文档注释）。
多行注释可以嵌套。

<?code-excerpt "misc/lib/language_tour/comments.dart (multi-line-comments)"?>
{% prettify dart %}
void main() {
  /*
   * This is a lot of work. Consider raising chickens.

  Llama larry = Llama();
  larry.feed();
  larry.exercise();
  larry.clean();
   */
}
{% endprettify %}


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

在文档注释中，除非用中括号括起来，否则Dart 编译器会忽略所有文本。
使用中括号可以引用类、 方法、 字段、 顶级变量、 函数、 和参数。
括号中的符号会在已记录的程序元素的词法域中进行解析。

Here is an example of documentation comments with references to other
classes and arguments:

下面是一个引用其他类和成员的文档注释：

<?code-excerpt "misc/lib/language_tour/comments.dart (doc-comments)"?>
{% prettify dart %}
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
{% endprettify %}

In the generated documentation, `[Food]` becomes a link to the API docs
for the Food class.

在生成的文档中，`[Food]` 会成为一个链接，
指向 Food 类的 API 文档。

To parse Dart code and generate HTML documentation, you can use the SDK’s
[documentation generation tool.](https://github.com/dart-lang/dartdoc#dartdoc)
For an example of generated documentation, see the [Dart API
documentation.]({{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}) For advice on how to structure
your comments, see
[Guidelines for Dart Doc Comments.](/guides/language/effective-dart/documentation)

解析 Dart 代码并生成 HTML 文档，可以使用 SDK 中的
[documentation generation tool.](https://github.com/dart-lang/dartdoc#dartdoc)
关于生成文档的实例，请参考 [Dart API
documentation.]({{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}})
关于文档结构的建议，请参考
[Guidelines for Dart Doc Comments.](/guides/language/effective-dart/documentation)


## Summary

## 总结

This page summarized the commonly used features in the Dart language.
More features are being implemented, but we expect that they won’t break
existing code. For more information, see the [Dart language specification][] and
[Effective Dart](/guides/language/effective-dart).

本页概述了 Dart 语言中常用的功能。
还有更多特性有待实现，但我们希望它们不会破坏现有代码。
有关更多信息，请参考
[Dart language specification][] 和
[Effective Dart](/guides/language/effective-dart)。

To learn more about Dart's core libraries, see
[A Tour of the Dart Libraries](/guides/libraries/library-tour).

要了解更多关于 Dart 核心库的内容，请参考
[A Tour of the Dart Libraries](/guides/libraries/library-tour).

[AssertionError]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/AssertionError-class.html
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
[Flutter]: {{site.flutter}}
[Flutter debug mode]: {{site.flutter}}/docs/testing/debugging#debug-mode-assertions
[forEach()]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Iterable/forEach.html
[Function API reference]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Function-class.html
[Future]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-async/Future-class.html
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
[Set]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Set-class.html
[StackTrace]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/StackTrace-class.html
[Stream]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-async/Stream-class.html
[String]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/String-class.html
[Symbol]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Symbol-class.html
[synchronous-async-start]: https://github.com/dart-lang/sdk/blob/master/docs/newsletter/20170915.md#synchronous-async-start
[Type]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Type-class.html
