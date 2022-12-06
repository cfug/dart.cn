---
title: A tour of the Dart language
title: Dart 开发语言概览
description: A tour of all the major Dart language features.
description: Dart 开发语言的主要特性概览。
short-title: Language tour
js: [{url: 'https://dartpad.cn/inject_embed.dart.js', defer: true}]
---
<?code-excerpt replace="/ *\/\/\s+ignore_for_file:[^\n]+\n//g; /(^|\n) *\/\/\s+ignore:[^\n]+\n/$1/g; /(\n[^\n]+) *\/\/\s+ignore:[^\n]+\n/$1\n/g; / *\/\/\s+ignore:[^\n]+//g; /([A-Z]\w*)\d\b/$1/g"?>

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

  你可以通过 DartPad 体验 Dart 的大部分语言功能 ([了解更多](/tools/dartpad))，
  **<a href="{{site.dartpad}}" target="_blank" rel="noopener">打开 DartPad。</a>**

  This page uses embedded DartPads to display some of the examples.

  本页面内嵌了一些 DartPads 做例子展示，

  {% include dartpads-embedded-troubleshooting.md %}

{{site.alert.end}}

{% comment %}
[TODO #2950: Look for null, ?, !, late, optional, Map, List, Set.
(Anything else?)
Look for dynamic. Look for code that isn't auto-included (no code-excerpt.)]
{% endcomment %}

## A basic Dart program

## 一个简单的 Dart 程序

The following code uses many of Dart’s most basic features:

下面的应用程序代码用到了很多 Dart 的基本功能：

<?code-excerpt "misc/test/language_tour/basic_test.dart"?>
```dart
// Define a function.
void printInteger(int aNumber) {
  print('The number is $aNumber.'); // Print to console.
}

// This is where the app starts executing.
void main() {
  var number = 42; // Declare and initialize a variable.
  printInteger(number); // Call a function.
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

`void`

:   A special type that indicates a value that's never used.
    Functions like `printInteger()` and `main()` that don't explicitly return a value
    have the `void` return type.

    一种特殊的类型，表示一个值永远不会被使用。
    类似于 `main()` 和 `printInteger()` 的函数，
    以 `void` 声明的函数返回类型，并不会返回值。

`int`

:   Another type, indicating an integer.
    Some additional [built-in types](#built-in-types)
    are `String`, `List`, and `bool`.

    另一种数据类型，表示一个整型数字。
    Dart 中一些其他的[内置类型](#built-in-types)包括 `String`、`List` 和 `bool`。

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

    一个特殊且 **必须的** 顶级函数，Dart 应用程序总是会从该函数开始执行。查阅 [main() 函数](#the-main-function) 获取更多相关信息。

`var`

:   A way to declare a variable without specifying its type.
    The type of this variable (`int`)
    is determined by its initial value (`42`).

    用于定义变量，通过这种方式定义变量不需要指定变量类型。
    这类变量的类型 (`int`) 由它的初始值决定 (`42`)。

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
    `null` are objects.
    With the exception of `null` (if you enable [sound null safety][ns]),
    all objects inherit from the [`Object`][] class.

    {{site.alert.version-note}}
      [Null safety][ns] was introduced in Dart 2.12.
      Using null safety requires a [language version][] of at least 2.12.
    {{site.alert.end}}

    所有变量引用的都是 **对象**，每个对象都是一个 **类** 的实例。
    数字、函数以及 `null` 都是对象。
    除去 `null` 以外（如果你开启了 [空安全][ns]）,
    所有的类都继承于 [`Object`][] 类。

-   Although Dart is strongly typed, type annotations are optional
    because Dart can infer types. In the code above, `number`
    is inferred to be of type `int`.

    尽管 Dart 是强类型语言，但是在声明变量时指定类型是可选的，因为 Dart 可以进行类型推断。
    在上述代码中，变量 `number` 的类型被推断为 `int` 类型。

-   If you enable [null safety][ns],
    variables can’t contain `null` unless you say they can.
    You can make a variable nullable by
    putting a question mark (`?`) at the end of its type.
    For example, a variable of type `int?` might be an integer,
    or it might be `null`.
    If you _know_ that an expression never evaluates to `null`
    but Dart disagrees,
    you can add `!` to assert that it isn't null
    (and to throw an exception if it is).
    An example: `int x = nullableButNotNullInt!`

    如果你开启了 [空安全][ns]，变量在未声明为可空类型时不能为 `null`。
    你可以通过在类型后加上问号 (`?`) 将类型声明为可空。
    例如，`int?` 类型的变量可以是整形数字或 `null`。
    如果你 **明确知道** 一个表达式不会为空，但 Dart 不这么认为时，
    你可以在表达式后添加 `!` 来断言表达式不为空（为空时将抛出异常）。
    例如：`int x = nullableButNotNullInt!`

-   When you want to explicitly say
    that any type is allowed, use the type `Object?`
    (if you've [enabled null safety][ns-enable]), `Object`,
    or—if you must defer type checking until runtime—the
    [special type `dynamic`][ObjectVsDynamic].

    如果你想要显式地声明允许任意类型，使用 `Object?`（如果你 [开启了空安全][ns-enable]）、
    `Object` 或者 [特殊类型 `dynamic`][ObjectVsDynamic] 将检查延迟到运行时进行。

-   Dart supports generic types, like `List<int>` (a list of integers)
    or `List<Object>` (a list of objects of any type).

    Dart 支持泛型，比如 `List<int>`（表示一组由 int 对象组成的列表）或
    `List<Object>`（表示一组由任何类型对象组成的列表）。

-   Dart supports top-level functions (such as `main()`), as well as
    functions tied to a class or object (*static* and *instance
    methods*, respectively). You can also create functions within
    functions (*nested* or *local functions*).

    Dart 支持顶级函数（例如 `main` 方法），
    同时还支持定义属于类或对象的函数（即 *静态* 和 *实例方法*）。
    你还可以在函数中定义函数（*嵌套* 或 *局部函数*）。

-   Similarly, Dart supports top-level *variables*, as well as variables
    tied to a class or object (static and instance variables). Instance
    variables are sometimes known as *fields* or *properties*.

    Dart 支持顶级 **变量**，以及定义属于类或对象的变量（静态和实例变量）。
    实例变量有时称之为域或属性。

-   Unlike Java, Dart doesn’t have the keywords `public`, `protected`,
    and `private`. If an identifier starts with an underscore (`_`), it’s
    private to its library. For details, see
    [Libraries and visibility](#libraries-and-visibility).

    Dart 没有类似于 Java 那样的 `public`、`protected` 和 `private` 成员访问限定符。
    如果一个标识符以下划线 (`_`) 开头则表示该标识符在库内是私有的。可以查阅 [库和可见性](#libraries-and-visibility) 获取更多相关信息。

-   *Identifiers* can start with a letter or underscore (`_`), followed by any
    combination of those characters plus digits.

    *标识符* 可以以字母或者下划线 (`_`) 开头，其后可跟字符和数字的组合。

-   Dart has both *expressions* (which have runtime values) and
    *statements* (which don't).
    For example, the [conditional expression](#conditional-expressions)
    `condition ? expr1 : expr2` has a value of `expr1` or `expr2`.
    Compare that to an [if-else statement](#if-and-else), which has no value.
    A statement often contains one or more expressions,
    but an expression can't directly contain a statement.

    Dart 中 **表达式** 和 **语句** 是有区别的，表达式有值而语句没有。比如[条件表达式](#conditional-expressions) `expression condition ? expr1 : expr2` 中含有值 `expr1` 或 `expr2`。与 [if-else 分支语句](#if-and-else)相比，`if-else` 分支语句则没有值。一个语句通常包含一个或多个表达式，但是一个表达式不能只包含一个语句。

-   Dart tools can report two kinds of problems: _warnings_ and _errors_.
    Warnings are just indications that your code might not work, but
    they don’t prevent your program from executing. Errors can be either
    compile-time or run-time. A compile-time error prevents the code
    from executing at all; a run-time error results in an
    [exception](#exceptions) being raised while the code executes.

    Dart 工具可以显示 **警告** 和 **错误** 两种类型的问题。
    警告表明代码可能有问题但不会阻止其运行。
    错误分为编译时错误和运行时错误；
    编译时错误代码无法运行；
    运行时错误会在代码运行时导致 [异常](#exceptions)。

## Keywords

## 关键字

The following table lists the words that the Dart language treats specially.

下面的表格中列出了 Dart 语言所使用的关键字。

{% assign ckw = '&nbsp;<sup title="contextual keyword" alt="contextual keyword">1</sup>' %}
{% assign bii = '&nbsp;<sup title="built-in-identifier" alt="built-in-identifier">2</sup>' %}
{% assign lrw = '&nbsp;<sup title="limited reserved word" alt="limited reserved word">3</sup>' %}
<div class="table-wrapper" markdown="1">
| [abstract][]{{bii}}   | [else][]              | [import][]{{bii}}     | [show][]{{ckw}}   |
| [as][]{{bii}}         | [enum][]              | [in][]                | [static][]{{bii}} |
| [assert][]            | [export][]{{bii}}     | [interface][]{{bii}}  | [super][]         |
| [async][]{{ckw}}      | [extends][]           | [is][]                | [switch][]        |
| [await][]{{lrw}}      | [extension][]{{bii}}  | [late][]{{bii}}       | [sync][]{{ckw}}   |
| [break][]             | [external][]{{bii}}   | [library][]{{bii}}    | [this][]          |
| [case][]              | [factory][]{{bii}}    | [mixin][]{{bii}}      | [throw][]         |
| [catch][]             | [false][]             | [new][]               | [true][]          |
| [class][]             | [final][]             | [null][]              | [try][]           |
| [const][]             | [finally][]           | [on][]{{ckw}}         | [typedef][]{{bii}}|
| [continue][]          | [for][]               | [operator][]{{bii}}   | [var][]           |
| [covariant][]{{bii}}  | [Function][]{{bii}}   | [part][]{{bii}}       | [void][]          |
| [default][]           | [get][]{{bii}}        | [required][]{{bii}}   | [while][]         |
| [deferred][]{{bii}}   | [hide][]{{ckw}}       | [rethrow][]           | [with][]          |
| [do][]                | [if][]                | [return][]            | [yield][]{{lrw}}  |
| [dynamic][]{{bii}}    | [implements][]{{bii}} | [set][]{{bii}}        |                   |
{:.table .table-striped .nowrap}
</div>

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
  [TODO #2950: Make sure that points to a place that talks about const constructors,
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
[external]: https://spec.dart.dev/DartLangSpecDraft.pdf#External%20Functions
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
[interface]: #implicit-interfaces
[is]: #type-test-operators
[late]: #late-variables
[library]: #libraries-and-visibility
[mixin]: #adding-features-to-a-class-mixins
[new]: #using-constructors
[null]: #default-value
[on]: #catch
[operator]: #_operators
[part]: /guides/libraries/create-library-packages#organizing-a-library-package
[required]: #named-parameters
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
[void]: #built-in-types
{% comment %}
  TODO #2950: Add coverage of void to the language tour.
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
  These keywords are valid identifiers in most places,
  but they can't be used as class or type names, or as import prefixes.

  带有上标 **2** 的关键字为 **内置标识符**，这些关键字在大多数时候都可以作为有效的标识符，但是它们不能用作类名或者类型名或者作为导入前缀使用。

* Words with the superscript **3** are limited reserved words related to
  [asynchrony support](#asynchrony-support).
  You can't use `await` or `yield` as an identifier
  in any function body marked with `async`, `async*`, or `sync*`.

  带有上标 **3** 的关键字为 Dart 1.0 发布后用于 [支持异步](#asynchrony-support) 相关内容。不能在由关键字 `async`、`async*` 或 `sync*` 标识的方法体中使用 `await` 或 `yield` 作为标识符。

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
specify the `Object` type (or `dynamic` if necessary).

`name` 变量的类型被推断为 `String`，但是你可以为其指定类型。
如果一个对象的引用不局限于单一的类型，可以将其指定为 `Object`（或 `dynamic`）类型。

<?code-excerpt "misc/lib/language_tour/variables.dart (type-decl)"?>
```dart
Object name = 'Bob';
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

Uninitialized variables that have a nullable type
have an initial value of `null`.
(If you haven't opted into [null safety][ns],
then every variable has a nullable type.)
Even variables with numeric types are initially null,
because numbers—like everything else in Dart—are objects.

在 Dart 中，未初始化以及可空类型的变量拥有一个默认的初始值 `null`。
（如果你未迁移至 [空安全][ns]，所有变量都为可空类型。）
即便数字也是如此，因为在 Dart 中一切皆为对象，数字也不例外。

<?code-excerpt "misc/test/language_tour/variables_test.dart (var-null-init)"?>
```dart
int? lineCount;
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

If you enable null safety, then you must initialize the values
of non-nullable variables before you use them:

若你启用了空安全，你必须在使用变量前初始化它的值。

<?code-excerpt "misc/lib/language_tour/variables.dart (var-ns-init)"?>
```dart
int lineCount = 0;
```

You don't have to initialize a local variable where it's declared,
but you do need to assign it a value before it's used.
For example, the following code is valid because
Dart can detect that `lineCount` is non-null by the time
it's passed to `print()`:

你并不需要在声明变量时初始化，只需在第一次用到这个变量前初始化即可。
例如，下面的代码是正确的，因为 Dart 可以在 `lineCount` 被传递到 `print()` 时检测它是否为空:

<?code-excerpt "misc/lib/language_tour/variables.dart (var-ns-flow)"?>
```dart
int lineCount;

if (weLikeToCount) {
  lineCount = countLines();
} else {
  lineCount = 0;
}

print(lineCount);
```

Top-level and class variables are lazily initialized;
the initialization code runs
the first time the variable is used.

顶级变量以及类变量是延迟初始化的，
即检查变量的初始化会在它第一次被使用的时候完成。

### Late variables

### 延迟初始化变量

Dart 2.12 added the `late` modifier, which has two use cases:

Dart 2.12 新增了 `late` 修饰符，这个修饰符可以在以下情况中使用：

* Declaring a non-nullable variable that's initialized after its declaration.
  
  声明一个非空变量，但不在声明时初始化。

* Lazily initializing a variable.

   延迟初始化一个变量。

Often Dart's control flow analysis can detect when a non-nullable variable
is set to a non-null value before it's used,
but sometimes analysis fails.
Two common cases are top-level variables and instance variables:
Dart often can't determine whether they're set,
so it doesn't try.

通常 Dart 的语义分析会在一个已声明为非空的变量被使用前检查它是否已经被赋值，
但有时这个分析会失败。
例如：在检查顶级变量和实例变量时，分析通常无法判断它们是否已经被初始化，因此不会进行分析。

If you're sure that a variable is set before it's used,
but Dart disagrees,
you can fix the error by marking the variable as `late`:

如果你确定这个变量在使用前就已经被声明，但 Dart 判断失误的话，
你可以在声明变量的时候使用 `late` 修饰来解决这个问题。

<?code-excerpt "misc/lib/language_tour/variables.dart (var-late-top-level)" replace="/late/[!$&!]/g"?>
```dart
[!late!] String description;

void main() {
  description = 'Feijoada!';
  print(description);
}
```

{{site.alert.warn}}

  If you fail to initialize a `late` variable,
  a runtime error occurs when the variable is used.
  
  若 `late` 标记的变量在使用前没有初始化，
  在变量被使用时会抛出运行时异常。
  
{{site.alert.end}}

When you mark a variable as `late` but initialize it at its declaration,
then the initializer runs the first time the variable is used.
This lazy initialization is handy in a couple of cases:

如果一个 `late` 修饰的变量在声明时就指定了初始化方法，
那么它实际的初始化过程会发生在第一次被使用的时候。
这样的延迟初始化在以下场景中会带来便利：

* The variable might not be needed,
  and initializing it is costly.
  
  Dart 认为这个变量可能在后文中没被使用，而且初始化时将产生较大的代价。
  
* You're initializing an instance variable,
  and its initializer needs access to `this`.
  
  你正在初始化一个实例变量，它的初始化方法需要调用 `this`。

In the following example,
if the `temperature` variable is never used,
then the expensive `readThermometer()` function is never called:

在下面这个例子中，如果 `temperature` 变量从未被使用的话，
那么 `readThermometer()` 将永远不会被调用：

<?code-excerpt "misc/lib/language_tour/variables.dart (var-late-lazy)" replace="/late/[!$&!]/g"?>
```dart
// This is the program's only call to readThermometer().
[!late!] String temperature = readThermometer(); // Lazily initialized.
```

### Final and const

### Final 和 Const

If you never intend to change a variable, use `final` or `const`, either
instead of `var` or in addition to a type. A final variable can be set
only once; a const variable is a compile-time constant. (Const variables
are implicitly final.)

如果你不想更改一个变量，可以使用关键字 `final` 或者 `const` 修饰变量，
这两个关键字可以替代 `var` 关键字或者加在一个具体的类型前。
一个 final 变量只可以被赋值一次；
一个 const 变量是一个编译时常量（const 变量同时也是 final 的）。
顶层的 final 变量或者类的 final 变量在其第一次使用的时候被初始化。


{{site.alert.note}}

  [Instance variables](#instance-variables) can be `final` but not `const`.

  [实例变量](#instance-variables) 可以是 `final` 的但不可以是 `const`，

{{site.alert.end}}

Here's an example of creating and setting a `final` variable:

下面的示例中我们创建并设置两个 `final` 变量：

<?code-excerpt "misc/lib/language_tour/variables.dart (final)"?>
```dart
final name = 'Bob'; // Without a type annotation
final String nickname = 'Bobby';
```

You can't change the value of a `final` variable:

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

使用关键字 `const` 修饰变量表示该变量为 **编译时常量**。
如果使用 const 修饰类中的变量，则必须加上 static 关键字，
即 `static const`（译者注：顺序不能颠倒）。
在声明 const 变量时可以直接为其赋值，也可以使用其它的 const 变量为其赋值：

<?code-excerpt "misc/lib/language_tour/variables.dart (const)"?>
```dart
const bar = 1000000; // Unit of pressure (dynes/cm2)
const double atm = 1.01325 * bar; // Standard atmosphere
```

The `const` keyword isn't just for declaring constant variables.
You can also use it to create constant _values_,
as well as to declare constructors that _create_ constant values.
Any variable can have a constant value.

`const` 关键字不仅仅可以用来定义常量，
还可以用来创建 **常量值**，该常量值可以赋予给任何变量。
你也可以将构造函数声明为 const 的，这种类型的构造函数创建的对象是不可改变的。

<?code-excerpt "misc/lib/language_tour/variables.dart (const-vs-final)"?>
```dart
var foo = const [];
final bar = const [];
const baz = []; // Equivalent to `const []`
```

You can omit `const` from the initializing expression of a `const` declaration,
like for `baz` above. For details, see [DON’T use const redundantly][].

如果使用初始化表达式为常量赋值可以省略掉关键字 `const`，比如上面的常量 `baz` 的赋值就省略掉了 `const`。
详情请查阅 [不要冗余地使用 `const`][DON’T use const redundantly]。

You can change the value of a non-final, non-const variable,
even if it used to have a `const` value:

没有使用 final 或 const 修饰的变量的值是可以被更改的，
即使这些变量之前引用过 `const` 的值。

<?code-excerpt "misc/lib/language_tour/variables.dart (reassign-to-non-final)"?>
```dart
foo = [1, 2, 3]; // Was const []
```

You can't change the value of a `const` variable:

常量的值不可以被修改：

{:.fails-sa}
<?code-excerpt "misc/lib/language_tour/variables.dart (cant-assign-to-const)"?>
```dart
baz = [42]; // Error: Constant variables can't be assigned a value.
```

You can define constants that use
[type checks and casts](#type-test-operators) (`is` and `as`),
[collection `if`](#collection-operators),
and [spread operators](#spread-operator) (`...` and `...?`):

你可以在常量中使用 [类型检查和强制类型转换](#type-test-operators) (`is` 和 `as`)、
[集合中的 `if`](#collection-operators) 以及
[展开操作符](#spread-operator) (`...` 和 `...?`)：

<?code-excerpt "misc/lib/language_tour/variables.dart (const-dart-25)"?>
```dart
const Object i = 3; // Where i is a const Object with an int value...
const list = [i as int]; // Use a typecast.
const map = {if (i is int) i: 'int'}; // Use is and collection if.
const set = {if (list is List<int>) ...list}; // ...and a spread.
```

{{site.alert.note}}
  Although a `final` object cannot be modified,
  its fields can be changed.
  In comparison, a `const` object and its fields
  cannot be changed: they're _immutable_.
{{site.alert.end}}

For more information on using `const` to create constant values, see
[Lists](#lists), [Maps](#maps), and [Classes](#classes).

可以查阅 [Lists](#lists)、[Maps](#maps) 和 [Classes](#classes)
获取更多关于使用 `const` 创建常量值的信息。

## Built-in types

## 内置类型

The Dart language has special support for the following:

Dart 语言支持下列内容：

- [Numbers](#numbers) (`int`, `double`)
- [Strings](#strings) (`String`)
- [Booleans](#booleans) (`bool`)
- [Lists](#lists) (`List`, also known as *arrays*)

  [Lists](#lists) (也被称为 *arrays*)

- [Sets](#sets) (`Set`)
- [Maps](#maps) (`Map`)
- [Runes](#characters) (`Runes`; often replaced by the `characters` API)

  [Runes](#characters) (常用于在 `Characters` API 中进行字符替换)

- [Symbols](#symbols) (`Symbol`)
- The value `null` (`Null`)

This support includes the ability to create objects using literals.
For example, `'this is a string'` is a string literal,
and `true` is a boolean literal.

使用字面量来创建对象也受到支持。
例如 `'This is a string'` 是一个字符串字面量，`true` 是一个布尔字面量。

Because every variable in Dart refers to an object—an instance of a
*class*—you can usually use *constructors* to initialize variables. Some
of the built-in types have their own constructors. For example, you can
use the `Map()` constructor to create a map.

由于 Dart 中每个变量引用都指向一个对象（一个 **类** 的实例），
通常也可以使用 **构造器** 来初始化变量。一些内置的类型有它们自己的构造器。
例如你可以使用 `Map()` 来创建一个 map 对象。

Some other types also have special roles in the Dart language:

* `Object`: The superclass of all Dart classes except `Null`.
* `Enum`: The superclass of all enums.
* `Future` and `Stream`: Used in [asynchrony support](#asynchrony-support).
* `Iterable`: Used in [for-in loops][iteration] and
  in synchronous [generator functions](#generator).
* `Never`: Indicates that an expression can never
  successfully finish evaluating.
  Most often used for functions that always throw an exception.
* `dynamic`: Indicates that you want to disable static checking.
  Usually you should use `Object` or `Object?` instead.
* `void`: Indicates that a value is never used.
  Often used as a return type.

{% comment %}
[TODO: move/add for-in coverage to language tour?]
{% endcomment %}

The `Object`, `Object?`, `Null`, and `Never` classes
have special roles in the class hierarchy,
as described in the [top-and-bottom][] section of
[Understanding null safety][].

{% comment %}
If we decide to cover `dynamic` more,
here's a nice example that illustrates what dynamic does:
  dynamic a = 2;
  String b = a; // No problem! Until runtime, when you get an uncaught error.

  Object c = 2;
  String d = c;  // Problem!
{% endcomment %}

### Numbers

Dart numbers come in two flavors:

Dart 支持两种 Number 类型：

[`int`][]

:   Integer values no larger than 64 bits,
    [depending on the platform][dart-numbers].
    On native platforms, values can be from
    -2<sup>63</sup> to 2<sup>63</sup> - 1.
    On the web, integer values are represented as JavaScript numbers
    (64-bit floating-point values with no fractional part)
    and can be from -2<sup>53</sup> to 2<sup>53</sup> - 1.

    整数值；长度不超过 64 位，具体取值范围 [依赖于不同的平台][dart-numbers]。
    在 DartVM 上其取值位于 -2<sup>63</sup> 至 2<sup>63</sup> - 1 之间。
    在 Web 上，整型数值代表着 JavaScript 的数字（64 位无小数浮点型），
    其允许的取值范围在 -2<sup>53</sup> 至 2<sup>53</sup> - 1 之间。

[`double`][]

:   64-bit (double-precision) floating-point numbers, as specified by
    the IEEE 754 standard.

    64 位的双精度浮点数字，且符合 IEEE 754 标准。

Both `int` and `double` are subtypes of [`num`][].
The num type includes basic operators such as +, -, /, and \*,
and is also where you’ll find `abs()`,` ceil()`,
and `floor()`, among other methods.
(Bitwise operators, such as \>\>, are defined in the `int` class.)
If num and its subtypes don’t have what you’re looking for, the
[dart:math][] library might.

`int` 和 `double` 都是 [`num`][] 的子类。
num 中定义了一些基本的运算符比如 +、-、\*、/ 等，
还定义了 `abs()`、`ceil()` 和 `floor()` 等方法
（位运算符，比如 \>\> 定义在 int 中）。
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

如果一个数字包含了小数点，那么它就是浮点型的。
下面是一些定义浮点数字面量的例子：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (double-literals)"?>
```dart
var y = 1.1;
var exponents = 1.42e5;
```

You can also declare a variable as a num. If you do this, the variable
can have both integer and double values.

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (declare-num)"?>
```dart
num x = 1; // x can have both int and double values
x += 2.5;
```

Integer literals are automatically converted to doubles when necessary:

整型字面量将会在必要的时候自动转换成浮点数字面量：

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

The `int` type specifies the traditional bitwise shift (`<<`, `>>`, `>>>`),
complement (`~`), AND (`&`), OR (`|`), and XOR (`^`) operators,
which are useful for manipulating and masking flags in bit fields.
For example:

整型支持传统的位移操作，比如移位（`<<`、`>>` 和 `>>>`）、
补码 (`~`)、按位与 (`&`)、按位或 (`|`) 以及按位异或 (`^`)，例如：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (bit-shifting)"?>
```dart
assert((3 << 1) == 6); // 0011 << 1 == 0110
assert((3 | 4) == 7); // 0011 | 0100 == 0111
assert((3 & 4) == 0); // 0011 & 0100 == 0000
```

For more examples, see the
[bitwise and shift operator](#bitwise-and-shift-operators) section.

更多示例请查看 [移位操作符](#bitwise-and-shift-operators) 小节。

Literal numbers are compile-time constants.
Many arithmetic expressions are also compile-time constants,
as long as their operands are
compile-time constants that evaluate to numbers.

数字字面量为编译时常量。很多算术表达式只要其操作数是常量，
则表达式结果也是编译时常量。

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (const-num)"?>
```dart
const msPerSecond = 1000;
const secondsUntilRetry = 5;
const msUntilRetry = secondsUntilRetry * msPerSecond;
```

For more information, see [Numbers in Dart][dart-numbers].

更多内容，请查看 [Dart 中的数字][dart-numbers]。

[dart-numbers]: /guides/language/numbers

### Strings

A Dart string (`String` object) holds a sequence of UTF-16 code units.
You can use either
single or double quotes to create a string:

Dart 字符串 （`String` 对象）包含了 UTF-16 编码的字符序列。
可以使用单引号或者双引号来创建字符串：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (quoting)"?>
```dart
var s1 = 'Single quotes work well for string literals.';
var s2 = "Double quotes work just as well.";
var s3 = 'It\'s easy to escape the string delimiter.';
var s4 = "It's even easier to use the other delimiter.";
```

<!--skip-->
```dart
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

在字符串中，请以 `${`*`表达式`*`}` 的形式使用表达式，
如果表达式是一个标识符，可以省略掉 {}。
如果表达式的结果为一个对象，则 Dart 会调用该对象的 `toString` 方法来获取一个字符串。

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (string-interpolation)"?>
```dart
var s = 'string interpolation';

assert('Dart has $s, which is very handy.' ==
    'Dart has string interpolation, '
        'which is very handy.');
assert('That deserves all caps. '
        '${s.toUpperCase()} is very handy!' ==
    'That deserves all caps. '
        'STRING INTERPOLATION is very handy!');
```

<!--skip-->
```dart
// 代码中文解释
var s = '字符串插值';

assert('Dart 有$s，使用起来非常方便。' == 'Dart 有字符串插值，使用起来非常方便。');
assert('使用${s.substring(3,5)}表达式也非常方便' == '使用插值表达式也非常方便。');
```

{{site.alert.note}}

  The `==` operator tests whether two objects are equivalent. Two
  strings are equivalent if they contain the same sequence of code
  units.

  `==` 运算符负责判断两个对象的内容是否一样，
  如果两个字符串包含一样的字符编码序列，则表示相等。

{{site.alert.end}}

You can concatenate strings using adjacent string literals or the `+`
operator:

你可以使用 `+` 运算符或并列放置多个字符串来连接字符串：

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
```

<!--skip-->
```dart
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

使用三个单引号或者三个双引号也能创建多行字符串：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (triple-quotes)"?>
```dart
var s1 = '''
You can create
multi-line strings like this one.
''';

var s2 = """This is also a
multi-line string.""";
```

<!--skip-->
```dart
// 代码中文解释
var s1 = '''
你可以像这样创建
多行字符串。
''';

var s2 = """这也是一个
多行字符串。""";
```

You can create a “raw” string by prefixing it with `r`:

在字符串前加上 `r` 作为前缀创建 “raw” 字符串
（即不会被做任何处理（比如转义）的字符串）：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (raw-strings)"?>
```dart
var s = r'In a raw string, not even \n gets special treatment.';
```

<!--skip-->
```dart
// 代码中文解释
var s = r'在 raw 字符串中，转义字符串 \n 会直接输出 “\n” 而不是转义为换行。';
```

See [Runes and grapheme clusters](#characters) for details on how
to express Unicode characters in a string.

你可以查阅 [Runes 与 grapheme clusters](#characters) 获取更多关于如何在字符串中表示 Unicode 字符的信息。

Literal strings are compile-time constants,
as long as any interpolated expression is a compile-time constant
that evaluates to null or a numeric, string, or boolean value.

字符串字面量是一个编译时常量，
只要是编译时常量 (null、数字、字符串、布尔)
都可以作为字符串字面量的插值表达式：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (string-literals)"?>
```dart
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
```

For more information on using strings, see
[Strings and regular expressions](/guides/libraries/library-tour#strings-and-regular-expressions).

可以查阅
[字符串和正则表达式](/guides/libraries/library-tour#strings-and-regular-expressions)
获取更多关于如何使用字符串的信息。

### Booleans

### 布尔类型

To represent boolean values, Dart has a type named `bool`. Only two
objects have type bool: the boolean literals `true` and `false`,
which are both compile-time constants.

Dart 使用 `bool` 关键字表示布尔类型，
布尔类型只有两个对象 `true` 和 `false`，两者都是编译时常量。

Dart's type safety means that you can't use code like
<code>if (<em>nonbooleanValue</em>)</code> or
<code>assert (<em>nonbooleanValue</em>)</code>.
Instead, explicitly check for values, like this:

Dart 的类型安全不允许你使用类似 <code>if (<em>nonbooleanValue</em>)</code>
或者 <code>assert (<em>nonbooleanValue</em>)</code> 这样的代码检查布尔值。
相反，你应该总是显示地检查布尔值，比如像下面的代码这样：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (no-truthy)"?>
```dart
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
```

### Lists

Perhaps the most common collection in nearly every programming language
is the *array*, or ordered group of objects. In Dart, arrays are
[`List`][] objects, so most people just call them *lists*.

数组 (**Array**) 是几乎所有编程语言中最常见的集合类型，
在 Dart 中数组由 [`List`][] 对象表示。
通常称之为 **List**。

Dart list literals are denoted by
a comma separated list of expressions or values,
enclosed in square brackets (`[]`).
Here's a simple Dart list:

Dart 中的列表字面量是由逗号分隔的一串表达式或值并以方括号 (`[]`) 包裹而组成的。
下面是一个 Dart List 的示例：

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

<a name="trailing-comma"></a>
You can add a comma after the last item in a Dart collection literal.
This _trailing comma_ doesn't affect the collection,
but it can help prevent copy-paste errors.

<a name="trailing-comma"></a>
你可以在 Dart 的集合类型的最后一个项目后添加逗号。
这个尾随逗号并不会影响集合，但它能有效避免「复制粘贴」的错误。

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (trailing-commas)"?>
```dart
var list = [
  'Car',
  'Boat',
  'Plane',
];
```

Lists use zero-based indexing, where 0 is the index of the first value
and `list.length - 1` is the index of the last value. 
You can get a list’s length using the `.length` property
and access a list's values using the subscript operator (`[]`):

List 的下标索引从 0 开始，第一个元素的下标为 0，
最后一个元素的下标为 `list.length - 1`。
你可以像 JavaScript 中的用法那样获取 Dart 中 List 的长度以及元素：

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

在 List 字面量前添加 `const` 关键字
会创建一个编译时常量：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (const-list)"?>
```dart
var constantList = const [1, 2, 3];
// constantList[1] = 1; // This line will cause an error.
```

<a id="spread-operator"> </a>
Dart supports the **spread operator** (`...`) and the
**null-aware spread operator** (`...?`),
which provide a concise way to insert multiple values into a collection.

<a id="spread-operator"> </a>
Dart 在 2.3 引入了 **扩展操作符**（`...`）和 **空感知扩展操作符**（`...?`），
它们提供了一种将多个元素插入集合的简洁方法。

For example, you can use the spread operator (`...`) to insert
all the values of a list into another list:

例如，你可以使用扩展操作符（`...`）
将一个 List 中的所有元素插入到另一个 List 中：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (list-spread)"?>
```dart
var list = [1, 2, 3];
var list2 = [0, ...list];
assert(list2.length == 4);
```

If the expression to the right of the spread operator might be null,
you can avoid exceptions by using a null-aware spread operator (`...?`):

如果扩展操作符右边可能为 null ，
你可以使用 null-aware 扩展操作符（`...?`）来避免产生异常：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (list-null-spread)"?>
```dart
var list2 = [0, ...?list];
assert(list2.length == 1);
```

For more details and examples of using the spread operator, see the
[spread operator proposal.][spread proposal]

可以查阅[扩展操作符建议][spread proposal]获取更多关于如何使用扩展操作符的信息。

<a id="collection-operators"> </a>
Dart also offers **collection if** and **collection for**,
which you can use to build collections using conditionals (`if`)
and repetition (`for`).

<a id="collection-operators"> </a>
Dart 还同时引入了 **集合中的 if** 和 **集合中的 for** 操作，
在构建集合时，可以使用条件判断 (`if`) 和循环 (`for`)。

Here's an example of using **collection if**
to create a list with three or four items in it:

下面示例是使用 **集合中的 if** 来创建一个 List 的示例，
它可能包含 3 个或 4 个元素：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (list-if)"?>
```dart
var nav = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];
```

Here's an example of using **collection for**
to manipulate the items of a list before
adding them to another list:

下面是使用 **集合中的 for** 将列表中的元素修改后添加到另一个列表中的示例：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (list-for)"?>
```dart
var listOfInts = [1, 2, 3];
var listOfStrings = ['#0', for (var i in listOfInts) '#$i'];
assert(listOfStrings[1] == '#1');
```

For more details and examples of using collection `if` and `for`, see the
[control flow collections proposal.][collections proposal]

你可以查阅 [集合中使用控制流建议][collections proposal]
获取更多关于在集合中使用 `if` 和 `for` 的细节内容和示例。

[collections proposal]: https://github.com/dart-lang/language/blob/master/accepted/2.3/control-flow-collections/feature-specification.md

[spread proposal]: https://github.com/dart-lang/language/blob/master/accepted/2.3/spread-collections/feature-specification.md

The List type has many handy methods for manipulating lists. For more
information about lists, see [Generics](#generics) and
[Collections](/guides/libraries/library-tour#collections).

List 类中有许多用于操作 List 的便捷方法，
你可以查阅 [泛型](#generics) 和 [集合](/guides/libraries/library-tour#collections)
获取更多与之相关的信息。

### Sets

A set in Dart is an unordered collection of unique items.
Dart support for sets is provided by set literals and the
[`Set`][] type.

在 Dart 中，set 是一组特定元素的无序集合。
Dart 支持的集合由集合的字面量和 [`Set`] 类提供。

{{site.alert.version-note}}

  Although the Set _type_ has always been a core part of Dart, set _literals_
  were introduced in Dart 2.2.

  尽管 Set **类型(type)** 一直都是 Dart 的一项核心功能，
  但是 Set **字面量(literals)** 是在 Dart 2.2 中才加入的。

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

可以使用在 `{}` 前加上类型参数的方式创建一个空的 Set，
或者将 `{}` 赋值给一个 Set 类型的变量：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (set-vs-map)"?>
```dart
var names = <String>{};
// Set<String> names = {}; // This works, too.
// var names = {}; // Creates a map, not a set.
```

{{site.alert.info}}

  **Set or map?** The syntax for map literals is similar to that for set
  literals. Because map literals came first, `{}` defaults to the `Map` type. If
  you forget the type annotation on `{}` or the variable it's assigned to, then
  Dart creates an object of type `Map<dynamic, dynamic>`.

  **Set 还是 map?** Map 字面量语法相似于 Set 字面量语法。
  因为先有的 Map 字面量语法，所以 `{}` 默认是 `Map` 类型。
  如果忘记在 `{}` 上注释类型或赋值到一个未声明类型的变量上，
  那么 Dart 会创建一个类型为 `Map<dynamic, dynamic>` 的对象。

{{site.alert.end}}

Add items to an existing set using the `add()` or `addAll()` methods:

使用 `add()` 方法或 `addAll()` 方法向已存在的 Set 中添加项目：

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

可以在 Set 变量前添加 `const` 关键字创建一个 Set 编译时常量：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (const-set)"?>
```dart
final constantSet = const {
  'fluorine',
  'chlorine',
  'bromine',
  'iodine',
  'astatine',
};
// constantSet.add('helium'); // This line will cause an error.
```

Sets support spread operators (`...` and `...?`)
and collection `if` and `for`,
just like lists do.
For more information, see the
[list spread operator](#spread-operator) and
[list collection operator](#collection-operators) discussions.

从 Dart 2.3 开始，Set 可以像 List 一样支持使用扩展操作符（`...` 和 `...?`）
以及 Collection `if` 和 `for` 操作。
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
is provided by map literals and the [`Map`][] type.

通常来说，Map 是用来关联 keys 和 values 的对象。其中键和值都可以是任何类型的对象。
每个 *键* 只能出现一次但是 *值* 可以重复出现多次。
Dart 中 Map 提供了 Map 字面量以及 [`Map`][] 类型两种形式的 Map。

Here are a couple of simple Dart maps, created using map literals:

下面是一对使用 Map 字面量创建 Map 的例子：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (map-literal)"?>
```dart
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
```

{{site.alert.note}}

  Dart infers that `gifts` has the type `Map<String, String>` and `nobleGases`
  has the type `Map<int, String>`. If you try to add the wrong type of value to
  either map, the analyzer or runtime raises an error. For more information,
  read about [type inference.](/guides/language/type-system#type-inference)

  Dart 将 `gifts` 变量的类型推断为 `Map<String, String>`，
  而将 `nobleGases` 的类型推断为 `Map<int, String>`。
  如果你向这两个 Map 对象中添加不正确的类型值，将导致运行时异常。
  你可以阅读
  [类型推断](/guides/language/type-system#type-inference) 获取更多相关信息。

{{site.alert.end}}

You can create the same objects using a Map constructor:

你也可以使用 Map 的构造器创建 Map：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (map-constructor)"?>
```dart
var gifts = Map<String, String>();
gifts['first'] = 'partridge';
gifts['second'] = 'turtledoves';
gifts['fifth'] = 'golden rings';

var nobleGases = Map<int, String>();
nobleGases[2] = 'helium';
nobleGases[10] = 'neon';
nobleGases[18] = 'argon';
```

{{site.alert.note}}
  If you come from a language like C# or Java, you might expect to see `new Map()` 
  instead of just `Map()`. In Dart, the `new` keyword is optional.
  For details, see [Using constructors](#using-constructors).

  如果你之前是使用的 C# 或 Java 这样的语言，也许你想使用 `new Map()` 构造 Map 对象。但是在 Dart 中，`new` 关键词是可选的。(译者注：且不被建议使用)
  你可以查阅 [构造函数的使用](#using-constructors) 获取更多相关信息。

{{site.alert.end}}

Add a new key-value pair to an existing map
using the subscript assignment operator (`[]=`):

向现有的 Map 中添加键值对与 JavaScript 的操作类似：

<?code-excerpt "misc/lib/language_tour/built_in_types.dart (map-add-item)"?>
```dart
var gifts = {'first': 'partridge'};
gifts['fourth'] = 'calling birds'; // Add a key-value pair
```

Retrieve a value from a map using the subscript operator (`[]`):

从一个 Map 中获取一个值的操作也与 JavaScript 类似：

<?code-excerpt "misc/test/language_tour/built_in_types_test.dart (map-retrieve-item)"?>
```dart
var gifts = {'first': 'partridge'};
assert(gifts['first'] == 'partridge');
```

If you look for a key that isn’t in a map, you get `null` in return:

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

// constantMap[2] = 'Helium'; // This line will cause an error.
```

Maps support spread operators (`...` and `...?`)
and collection `if` and `for`, just like lists do.
For details and examples, see the
[spread operator proposal][spread proposal] and the
[control flow collections proposal.][collections proposal]

Map 可以像 List 一样支持使用扩展操作符（`...` 和 `...?`）
以及集合的 if 和 for 操作。
你可以查阅 [List 扩展操作符](#spread-operator)
和 [List 集合操作符](#collection-operators) 获取更多相关信息。

For more information about maps, see the
[generics](#generics) section and
the library tour's coverage of
the [`Maps` API](/guides/libraries/library-tour#maps).

你也可以查阅 [泛型](#generics) 以及
[`Maps` API](/guides/libraries/library-tour#maps) 获取更多相关信息。

<a id="characters"></a>
### Runes and grapheme clusters

### Runes 与 grapheme clusters

In Dart, [runes][] expose the Unicode code points of a string.
You can use the [characters package][]
to view or manipulate user-perceived characters,
also known as
[Unicode (extended) grapheme clusters.][grapheme clusters]

在 Dart 中，[runes][] 公开了字符串的 Unicode 码位。
使用 [characters 包][characters package] 来访问
或者操作用户感知的字符，也被称为
[Unicode (扩展) grapheme clusters][grapheme clusters]。

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

表示 Unicode 字符的常见方式是使用 `\uXXXX`，
其中 XXXX 是一个四位数的 16 进制数字。
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
它将返回 [`Characters`][] 对象作为一系列 grapheme clusters
的字符串。下面是使用 characters API 的样例：

<?code-excerpt "misc/lib/language_tour/characters.dart"?>
```dart
import 'package:characters/characters.dart';

void main() {
  var hi = 'Hi 🇩🇰';
  print(hi);
  print('The end of the string: ${hi.substring(hi.length - 1)}');
  print('The last character: ${hi.characters.last}');
}
```

The output, depending on your environment, looks something like this:

输出取决于你的环境，大致类似于：

```terminal
$ dart run bin/main.dart
Hi 🇩🇰
The end of the string: ???
The last character: 🇩🇰
```

For details on using the characters package to manipulate strings,
see the [example][characters example] and [API reference][characters API]
for the characters package.

有关使用 characters 包操作字符串的详细信息，请参阅用于 characters 包的[样例][characters example]
和 [API 参考][characters API]。

### Symbols

A [`Symbol`][] object
represents an operator or identifier declared in a Dart program. You
might never need to use symbols, but they're invaluable for APIs that
refer to identifiers by name, because minification changes identifier
names but not identifier symbols.

[`Symbol`][] 表示 Dart 中声明的操作符或者标识符。
你几乎不会需要 Symbol，但是它们对于那些通过名称引用标识符的 API 很有用，
因为代码压缩后，尽管标识符的名称会改变，但是它们的 Symbol 会保持不变。

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

## 函数

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
[type annotations for public APIs](/guides/language/effective-dart/design#do-type-annotate-fields-and-top-level-variables-if-the-type-isnt-obvious),
the function still works if you omit the types:

虽然高效 Dart 指南建议在
[公开的 API 上定义返回类型](/guides/language/effective-dart/design#do-type-annotate-fields-and-top-level-variables-if-the-type-isnt-obvious)，
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
`=>` 有时也称之为 **箭头** 函数。

{{site.alert.note}}

  Only an *expression*—not a *statement*—can appear between the arrow (=\>) and
  the semicolon (;). For example, you can’t put an [if statement](#if-and-else)
  there, but you can use a [conditional expression](#conditional-expressions).

  在 =\> 与 ; 之间的只能是 *表达式* 而非 *语句*。
  比如你不能将一个 [if语句](#if-and-else) 放在其中，
  但是可以放置 [条件表达式](#conditional-expressions)。

{{site.alert.end}}

### Parameters

### 参数

A function can have any number of *required positional* parameters. These can be
followed either by *named* parameters or by *optional positional* parameters
(but not both).

函数可以有两种形式的参数：**必要参数** 和 **可选参数**。
必要参数定义在参数列表前面，可选参数则定义在必要参数后面。
可选参数可以是 **命名的** 或 **位置的**。

{{site.alert.note}}

  Some APIs—notably [Flutter][] widget constructors—use only named
  parameters, even for parameters that are mandatory. See the next section for
  details.

  某些 API（特别是 [Flutter][] 控件的构造器）只使用命名参数，
  即便参数是强制性的。可以查阅下一节获取更多信息。

{{site.alert.end}}

You can use [trailing commas][] when you pass arguments to a function
or when you define function parameters.

向函数传入参数或者定义函数参数时，可以使用 [尾逗号][trailing commas]。

#### Named parameters

#### 命名参数

Named parameters are optional
unless they're explicitly marked as `required`.

命名参数默认为可选参数，除非他们被特别标记为 `required`。

When defining a function, use
<code>{<em>param1</em>, <em>param2</em>, …}</code>
to specify named parameters:

定义函数时，使用
<code>{<em>参数1</em>, <em>参数2</em>, …}</code>
来指定命名参数：

<?code-excerpt "misc/lib/language_tour/functions.dart (specify-named-parameters)"?>
```dart
/// Sets the [bold] and [hidden] flags ...
void enableFlags({bool? bold, bool? hidden}) {...}
```

When calling a function, 
you can specify named arguments using
<code><em>paramName</em>: <em>value</em></code>. 
For example:

当调用函数时，你可以使用 <code><em>参数名</em>: <em>参数值</em></code>
指定一个命名参数的值。例如：

<?code-excerpt "misc/lib/language_tour/functions.dart (use-named-parameters)"?>
```dart
enableFlags(bold: true, hidden: false);
```

Although it often makes sense to place positional arguments first,
named arguments can be placed anywhere in the argument list
when it suits your API:

尽管先使用位置参数会比较合理，但你也可以在任意位置使用命名参数，
让整个调用的方式看起来更适合你的 API：

<?code-excerpt "misc/lib/language_tour/functions.dart (named-arguments-anywhere)"?>
```dart
repeat(times: 2, () {
  ...
});
```

{{site.alert.tip}}

  If a parameter is optional but can't be `null`,
  provide a [default value](#default-parameter-values).

  如果一个参数是可选的，但是不能为 `null`，
  你需要为它提供一个 [默认值](#default-parameter-values)。

{{site.alert.end}}

Although named parameters are a kind of optional parameter,
you can annotate them with `required` to indicate
that the parameter is mandatory—that users
must provide a value for the parameter.
For example:

虽然命名参数是可选参数的一种类型，
但是你仍然可以使用 `required` 来标识一个命名参数是必须的参数，
此时调用者必须为该参数提供一个值。
例如：

<?code-excerpt "misc/lib/language_tour/functions.dart (required-named-parameters)" replace="/required/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
const Scrollbar({super.key, [!required!] Widget child});
{% endprettify %}

If someone tries to create a `Scrollbar`
without specifying the `child` argument,
then the analyzer reports an issue.

如果调用者想要通过 `Scrollbar` 的构造函数构造一个 Scrollbar 对象而不提供 `child` 参数，
则会导致编译错误。

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
String say(String from, String msg, [String? device]) {
  var result = '$from says $msg';
  if (device != null) {
    result = '$result with a $device';
  }
  return result;
}
```

Here’s an example of calling this function without the optional
parameter:

下面是不使用可选参数调用上述函数的示例

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

Your function can use `=` to define default values for optional parameters,
both named and positional. The default values must be compile-time constants.
If no default value is provided, the default value is `null`.

可以用 `=` 为函数的命名参数和位置参数定义默认值，默认值必须为编译时常量，
没有指定默认值的情况下默认值为 `null`。

Here's an example of setting default values for named parameters:

下面是设置可选参数默认值示例：

<?code-excerpt "misc/lib/language_tour/functions.dart (named-parameter-default-values)"?>
```dart
/// Sets the [bold] and [hidden] flags ...
void enableFlags({bool bold = false, bool hidden = false}) {...}

// bold will be true; hidden will be false.
enableFlags(bold: true);
```

{{site.alert.secondary}}

  **Deprecation note:** Old code might use a colon (`:`) instead of `=`
  to specify default values of named parameters. 
  The reason is that originally, only `:` was supported for named parameters. 
  That support is deprecated and will be removed, 
  so we recommend that you **[use `=` to specify default values.][use =]**

  If you have the [`prefer_equal_for_default_values`][] linter rule enabled,
  you can use [`dart fix`][] to migrate to the suggested `=` syntax.

  在老版本的 Dart 代码中会使用 冒号（`:`）而不是 `=` 来设置命名参数的默认值。
  原因在于刚开始的时候命名参数只支持 `:`。
  不过现在这个支持已经过时并且会被移除掉，
  所以我们建议你仅 **[使用 `=` 来指定默认值][use =]**。

  如果你启用了 [`prefer_equal_for_default_values`][] 这个 linter 规则，
  你可以使用 [`dart fix`][] 命令来迁移到建议的 `=` 语法。

  [use =]: /guides/language/effective-dart/usage#do-use--to-separate-a-named-parameter-from-its-default-value
  [`prefer_equal_for_default_values`]: /tools/linter-rules#prefer_equal_for_default_values
  [`dart fix`]: /tools/dart-fix

{{site.alert.end}}

{% comment %}
TODO #2950: Update if/when we drop support for `:`.
See `defaultNamedParameter` in the language spec.
{% endcomment %}

The next example shows how to set default values for positional parameters:

下一个示例将向你展示如何为位置参数设置默认值：

<?code-excerpt "misc/test/language_tour/functions_test.dart (optional-positional-param-default)"?>
```dart
String say(String from, String msg, [String device = 'carrier pigeon']) {
  var result = '$from says $msg with a $device';
  return result;
}

assert(say('Bob', 'Howdy') == 'Bob says Howdy with a carrier pigeon');
```

You can also pass lists or maps as default values.
The following example defines a function, `doStuff()`,
that specifies a default list for the `list`
parameter and a default map for the `gifts` parameter.

List 或 Map 同样也可以作为默认值。下面的示例定义了一个名为 `doStuff()` 的函数，
并为其名为 `list` 和 `gifts` 的参数指定了一个 List 类型的值和 Map 类型的值。

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

### The main() function

### main() 函数

Every app must have a top-level `main()` function, which serves as the
entrypoint to the app. The `main()` function returns `void` and has an
optional `List<String>` parameter for arguments.

每个 Dart 程序都必须有一个 `main()` 顶级函数作为程序的入口，
`main()` 函数返回值为 `void` 并且有一个 `List<String>` 类型的可选参数。

Here's a simple `main()` function:

下面是一个简单 `main()` 函数：

<?code-excerpt "misc/test/samples_test.dart (hello-world)"?>
```dart
void main() {
  print('Hello, World!');
}
```

Here's an example of the `main()` function for a command-line app that
takes arguments:

下面是使用命令行访问带参数的 `main()` 函数示例：

<?code-excerpt "misc/test/language_tour/functions_test.dart (main-args)"?>
```dart
// Run the app like this: dart args.dart 1 test
void main(List<String> arguments) {
  print(arguments);

  assert(arguments.length == 2);
  assert(int.parse(arguments[0]) == 1);
  assert(arguments[1] == 'test');
}
```

You can use the [args library]({{site.pub-pkg}}/args) to
define and parse command-line arguments.

你可以通过使用 [参数库]({{site.pub}}/packages/args) 来定义和解析命令行参数。

### Functions as first-class objects

### 函数是一级对象

You can pass a function as a parameter to another function. For example:

可以将函数作为参数传递给另一个函数。例如：

<?code-excerpt "misc/lib/language_tour/functions.dart (function-as-param)"?>
```dart
void printElement(int element) {
  print(element);
}

var list = [1, 2, 3];

// Pass printElement as a parameter.
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

大多数方法都是有名字的，比如 `main()` 或 `printElement()`。
你可以创建一个没有名字的方法，称之为 **匿名函数**、
**Lambda 表达式** 或 **Closure 闭包**。
你可以将匿名方法赋值给一个变量然后使用它，
比如将该变量添加到集合或从中删除。

An anonymous function looks similar
to a named function—zero or more parameters, separated by commas
and optional type annotations, between parentheses.

匿名方法看起来与命名方法类似，在括号之间可以定义参数，参数之间用逗号分割。

The code block that follows contains the function's body:

后面大括号中的内容则为函数体：

<code>
([[<em>类型</em>] <em>参数</em>[, …]]) { <br>
&nbsp;&nbsp;<em>函数体</em>; <br>
}; <br>
</code>

The following example defines an anonymous function
with an untyped parameter, `item`,
and passes it to the `map` function.
The function, invoked for each item in the list,
converts each string to uppercase.
Then in the anonymous function passed to `forEach`,
each converted string is printed out alongside its length.

下面代码定义了只有一个参数 `item` 且没有参数类型的匿名方法。
List 中的每个元素都会调用这个函数，打印元素位置和值的字符串：

<?code-excerpt "misc/test/language_tour/functions_test.dart (anonymous-function)"?>
```dart
const list = ['apples', 'bananas', 'oranges'];
list.map((item) {
  return item.toUpperCase();
}).forEach((item) {
  print('$item: ${item.length}');
});
```

Click **Run** to execute the code.

点击 **Run** 按钮执行代码。

<?code-excerpt "misc/test/language_tour/functions_test.dart (anonymous-function-main)"?>
```dart:run-dartpad:height-400px:ga_id-anonymous_functions
void main() {
  const list = ['apples', 'bananas', 'oranges'];
  list.map((item) {
    return item.toUpperCase();
  }).forEach((item) {
    print('$item: ${item.length}');
  });
}
```

If the function contains only a single expression or return statement,
you can shorten it using arrow notation. 
Paste the following line into DartPad and click **Run**
to verify that it is functionally equivalent.

如果函数体内只有一行返回语句，你可以使用胖箭头缩写法。
粘贴下面代码到 DartPad 中并点击运行按钮，验证两个函数是否一致。

<?code-excerpt "misc/test/language_tour/functions_test.dart (anon-func)"?>
```dart
list
    .map((item) => item.toUpperCase())
    .forEach((item) => print('$item: ${item.length}'));
```


### Lexical scope

### 词法作用域

Dart is a lexically scoped language, which means that the scope of
variables is determined statically, simply by the layout of the code.
You can “follow the curly braces outwards” to see if a variable is in
scope.

Dart 是词法有作用域语言，变量的作用域在写代码的时候就确定了，
大括号内定义的变量只能在大括号内访问，与 Java 类似。

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

**闭包** 即一个函数对象，即使函数对象的调用在它原始作用域之外，
依然能够访问在它词法作用域内的变量。

Functions can close over variables defined in surrounding scopes. In the
following example, `makeAdder()` captures the variable `addBy`. Wherever the
returned function goes, it remembers `addBy`.

函数可以封闭定义到它作用域内的变量。接下来的示例中，
函数 `makeAdder()` 捕获了变量 `addBy`。
无论函数在什么时候返回，它都可以使用捕获的 `addBy` 变量。

<?code-excerpt "misc/test/language_tour/functions_test.dart (function-closure)"?>
```dart
/// Returns a function that adds [addBy] to the
/// function's argument.
Function makeAdder(int addBy) {
  return (int i) => addBy + i;
}

void main() {
  // Create a function that adds 2.
  var add2 = makeAdder(2);

  // Create a function that adds 4.
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
void foo() {} // A top-level function

class A {
  static void bar() {} // A static method
  void baz() {} // An instance method
}

void main() {
  Function x;

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

Dart supports the operators shown in the following table.
You can implement many of these [operators as class members](#_operators).

Dart 支持下表的操作符。
你可以将这些运算符实现为 [一个类的成员](#_operators)。

|--------------------------+------------------------------------------------|
| 描述                     | 运算符                                         |
|--------------------------|------------------------------------------------|
| 一元后缀                 | <code><em>表达式</em>++</code>   <code><em>表达式</em>--</code> `()` `[]` `.` `?.` `!` |
| 一元前缀      | <code>-<em>表达式</em></code>   <code>!<em>表达式</em></code>   <code>~<em>表达式</em></code>   <code>++<em>表达式</em></code>   <code>--<em>表达式</em></code>  |
| 乘除法        | `*`   `/`   `%`    `~/`                                     |
| 加减法        | `+`   `-`                                                    |
| 位运算        | `<<`   `>>`   `>>>`                                         |
| 二进制与      | `&`                                                           |
| 二进制异或     | `^`                                                           |
| 二进制或      | `|`                                                           |
| 关系和类型测试 | `>=`   `>`   `<=`   `<`   `as`   `is`   `is!`           |
| 相等判断      | `==`   `!=`                                                 |
| 逻辑与        | `&&`                                                          |
| 逻辑或        | `||`                                                          |
| 空判断        | `??`                                                          |
| 条件表达式     | <code><em>表达式 1</em> ? <em>表达式 2</em> : <em>表达式 3</em></code> |
| 级联          | `..`   `?..`                                      |
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

在 [运算符表](#operators) 中，运算符的优先级按先后排列，
即第一行优先级最高，最后一行优先级最低，
而同一行中，最左边的优先级最高，最右边的优先级最低。
例如：`%` 运算符优先级高于 `==` ，而 `==` 高于 `&&`。
根据优先级规则，那么意味着以下两行代码执行的效果相同：

<?code-excerpt "misc/test/language_tour/operators_test.dart (precedence)"?>
```dart
// Parentheses improve readability.
if ((n % i == 0) && (d % i == 0)) ...

// Harder to read, but equivalent.
if (n % i == 0 && d % i == 0) ...
```

{{site.alert.warning}}

  For operators that take two operands, the leftmost operand determines which
  method is used. For example, if you have a `Vector` object and
  a `Point` object, then `aVector + aPoint` uses `Vector` addition (`+`).

  对于有两个操作数的运算符，左边的操作数决定了运算符的功能。
  比如对于一个 Vector 对象和一个 Point 对象，
  表达式 `aVector + aPoint` 中所使用的是 Vector 对象中定义的相加运算符 (`+`)。

{{site.alert.end}}


### Arithmetic operators

### 算术运算符

Dart supports the usual arithmetic operators, as shown in the following table.

Dart 支持常用的算术运算符：

|-----------------------------+-------------------------------------------|
| 运算符                       | 描述                                       |
|-----------------------------+-------------------------------------------|
| `+`                         | 加
| `-`                         | 减
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
assert(5 / 2 == 2.5); // Result is a double
assert(5 ~/ 2 == 2); // Result is an int
assert(5 % 2 == 1); // Remainder

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
| <code>--<em>var</em></code> | <code><em>var</em> = <em>var</em> - 1</code> (表达式的值为 <code><em>var</em> - 1</code>)
| <code><em>var</em>--</code> | <code><em>var</em> = <em>var</em> - 1</code> (表达式的值为 <code><em>var</em></code>)
{:.table .table-striped}

Example:

示例：

<?code-excerpt "misc/test/language_tour/operators_test.dart (increment-decrement)"?>
```dart
int a;
int b;

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
（在极少数情况下，可能需要使用 [identical()][] 函数来确定两个对象是否完全相同）。
下面是 `==` 运算符的一些规则：

1.  If *x* or *y* is null, return true if both are null, and false if only
    one is null.

    当 **x** 和 **y** 同时为空时返回 true，而只有一个为空时返回 false。

2.  Return the result of invoking the `==` method on *x* with the argument *y*.
    (That’s right, operators such as `==` are methods that
    are invoked on their first operand.
    For details, see [Operators](#_operators).)

    返回对 **x** 调用 `==` 方法的结果，参数为 **y**。
    （像 `==` 这样的操作符是对左侧内容进行调用的。
    详情请查阅 [操作符](#_operators)。）

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
| `as`      | Typecast (also used to specify [library prefixes](#specifying-a-library-prefix))
| `as`      | 类型转换（也用作指定 [类前缀](#specifying-a-library-prefix))）
| `is`      | True if the object has the specified type
| `is`      | 如果对象是指定类型则返回 true
| `is!`     | True if the object doesn't have the specified type
| `is!`     | 如果对象是指定类型则返回 false
{:.table .table-striped}

The result of `obj is T` is true if `obj` implements the interface
specified by `T`. For example, `obj is Object?` is always true.

当且仅当 `obj` 实现了 `T` 的接口，`obj is T` 才是 true。
例如 `obj is Object` 总为 true，因为所有类都是 Object 的子类。

Use the `as` operator to cast an object to a particular type if and only if
you are sure that the object is of that type. Example:

仅当你确定这个对象是该类型的时候，
你才可以使用 `as` 操作符可以把对象转换为特定的类型。例如：

<?code-excerpt "misc/lib/language_tour/classes/employee.dart (emp as Person)"?>
```dart
(employee as Person).firstName = 'Bob';
```

If you aren't sure that the object is of type `T`, then use `is T` to check the
type before using the object.

如果你不确定这个对象类型是不是 `T`，
请在转型前使用 `is T` 检查类型。

<?code-excerpt "misc/lib/language_tour/classes/employee.dart (emp is Person)"?>
```dart
if (employee is Person) {
  // Type check
  employee.firstName = 'Bob';
}
```

{{site.alert.note}}

  The code isn’t equivalent. If `employee` is null or not a `Person`, the
  first example throws an exception; the second does nothing.

  上述两种方式是有区别的：如果 `employee` 为 null 或者不为 `Person` 类型，
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
// Assign value to a
a = value;
// Assign value to b if b is null; otherwise, b stays the same
b ??= value;
```

Compound assignment operators such as `+=` combine
an operation with an assignment.

像 `+=` 这样的赋值运算符将算数运算符和赋值运算符组合在了一起。

| `=`  | `*=`  | `%=`  | `>>>=` | `^=`
| `+=` | `/=`  | `<<=` | `&=`   | `|=`
| `-=` | `~/=` | `>>=`
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
var a = 2; // Assign using =
a *= 3; // Assign and multiply: a = a * 3
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
| `>>>`                        | 无符号右移
{:.table .table-striped}

Here’s an example of using bitwise and shift operators:

下面是使用按位和移位运算符的示例：

<?code-excerpt "misc/test/language_tour/operators_test.dart (op-bitwise)"?>
```dart
final value = 0x22;
final bitmask = 0x0f;

assert((value & bitmask) == 0x02); // AND
assert((value & ~bitmask) == 0x20); // AND NOT
assert((value | bitmask) == 0x2f); // OR
assert((value ^ bitmask) == 0x2d); // XOR
assert((value << 4) == 0x220); // Shift left
assert((value >> 4) == 0x02); // Shift right
assert((value >>> 4) == 0x02); // Unsigned shift right
assert((-value >> 4) == -0x03); // Shift right
assert((-value >>> 4) > 0); // Unsigned shift right
```

{{site.alert.version-note}}

  The `>>>` operator (known as _triple-shift_ or _unsigned shift_)
  requires a [language version][] of at least 2.14.

  `>>>` 操作符在 2.14 以上的 [Dart 版本][language version] 中可用。

{{site.alert.end}}

### Conditional expressions

### 条件表达式

Dart has two operators that let you concisely evaluate expressions
that might otherwise require [if-else](#if-and-else) statements:

Dart 有两个特殊的运算符可以用来替代 [if-else](#if-and-else) 语句：

<code><em>condition</em> ? <em>expr1</em> : <em>expr2</em></code>
<br> If _condition_ is true, evaluates _expr1_ (and returns its value);
  otherwise, evaluates and returns the value of _expr2_.

<code><em>条件</em> ? <em>表达式 1</em> : <em>表达式 2</em></code>
<br> 如果条件为 true，执行表达式 1并返回执行结果，否则执行表达式 2 并返回执行结果。

<code><em>expr1</em> ?? <em>expr2</em></code>
<br> If _expr1_ is non-null, returns its value;
  otherwise, evaluates and returns the value of _expr2_.

<code><em>表达式 1</em> ?? <em>表达式 2</em></code>
<br>如果表达式 1 为非 null 则返回其值，否则执行表达式 2 并返回其值。

When you need to assign a value
based on a boolean expression,
consider using `?` and `:`.

根据布尔表达式确定赋值时，请考虑使用 `?` 和 `:`

<?code-excerpt "misc/lib/language_tour/operators.dart (if-then-else-operator)"?>
```dart
var visibility = isPublic ? 'public' : 'private';
```

If the boolean expression tests for null,
consider using `??`.

如果赋值是根据判定是否为 null 则考虑使用 `??`。

<?code-excerpt "misc/test/language_tour/operators_test.dart (if-null)"?>
```dart
String playerName(String? name) => name ?? 'Guest';
```

The previous example could have been written at least two other ways,
but not as succinctly:

上述示例还可以写成至少下面两种不同的形式，只是不够简洁：

<?code-excerpt "misc/test/language_tour/operators_test.dart (if-null-alt)"?>
```dart
// Slightly longer version uses ?: operator.
String playerName(String? name) => name != null ? name : 'Guest';

// Very long version uses if-else statement.
String playerName(String? name) {
  if (name != null) {
    return name;
  } else {
    return 'Guest';
  }
}
```

<a id="cascade"></a>
### Cascade notation

### 级联运算符

Cascades (`..`, `?..`) allow you to make a sequence of operations
on the same object. In addition to accessing instance members,
you can also call instance methods on that same object.
This often saves you the step of creating a temporary variable and
allows you to write more fluid code.

级联运算符 (`..`, `?..`) 可以让你在同一个对象上连续调用多个对象的变量或方法。

Consider the following code:

比如下面的代码：

<?code-excerpt "misc/lib/language_tour/cascades.dart (cascade)"?>
```dart
var paint = Paint()
  ..color = Colors.black
  ..strokeCap = StrokeCap.round
  ..strokeWidth = 5.0;
```

The constructor, `Paint()`,
returns a `Paint` object.
The code that follows the cascade notation operates
on this object, ignoring any values that
might be returned.

The previous example is equivalent to this code:

<?code-excerpt "misc/lib/language_tour/cascades.dart (cascade-expanded)"?>
```dart
var paint = Paint();
paint.color = Colors.black;
paint.strokeCap = StrokeCap.round;
paint.strokeWidth = 5.0;
```

If the object that the cascade operates on can be null,
then use a _null-shorting_ cascade (`?..`) for the first operation.
Starting with `?..` guarantees that none of the cascade operations
are attempted on that null object.

<?code-excerpt "misc/test/language_tour/browser_test.dart (cascade-operator)"?>
```dart
querySelector('#confirm') // Get an object.
  ?..text = 'Confirm' // Use its members.
  ..classes.add('important')
  ..onClick.listen((e) => window.alert('Confirmed!'))
  ..scrollIntoView();
```

{{site.alert.version-note}}

  The `?..` syntax requires a [language version][] of at least 2.12.

  `?..` 运行在 2.12 和以上的 [版本][language version] 中可用。

{{site.alert.end}}

The previous code is equivalent to the following:

上面的代码相当于：

<?code-excerpt "misc/test/language_tour/browser_test.dart (cascade-operator-example-expanded)"?>
```dart
var button = querySelector('#confirm');
button?.text = 'Confirm';
button?.classes.add('important');
button?.onClick.listen((e) => window.alert('Confirmed!'));
button?.scrollIntoView();
```

You can also nest cascades. For example:

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
  ..write('bar'); // Error: method 'write' isn't defined for 'void'.
```

The `sb.write()` call returns void,
and you can't construct a cascade on `void`.

上述代码中的 `sb.write()` 方法返回的是 void，
返回值为 `void` 的方法则不能使用级联运算符。

{{site.alert.note}}

  Strictly speaking, the "double dot" notation for cascades isn't an operator.
  It's just part of the Dart syntax.

  严格来说 `..` 级联操作并非一个运算符而是 Dart 的特殊语法。

{{site.alert.end}}

### Other operators

### 其他运算符

You've seen most of the remaining operators in other examples:

大多数其它的运算符，已经在其它的示例中使用过：

|----------+-----------------------+-------------------|
|   运算符  | 名字                  | 描述               |
|----------+-----------------------+-------------------|
| `()`     | 使用方法               | 代表调用一个方法
| `[]`     | 访问 List             | 访问 List 中特定位置的元素
| `?[]`    | 判空访问 List          | 左侧调用者不为空时，访问 List 中特定位置的元素
| `.`      | 访问成员               | 成员访问符
| `?.`     | 条件访问成员            | 与上述成员访问符类似，但是左边的操作对象不能为 null，例如 foo?.bar，如果 foo 为 null 则返回 null ，否则返回 bar
| `!`      | 空断言操作符            | 将表达式的类型转换为其基础类型，如果转换失败会抛出运行时异常。例如 `foo!.bar`，如果 `foo` 为 null，则抛出运行时异常
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

The statement conditions must be expressions
that evaluate to boolean values, nothing else.
See [Booleans](#booleans) for more information.

Dart 的 if 语句中的条件必须是布尔值而不能为其它类型。
详情请查阅 [布尔值](#booleans)。


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

for (final c in callbacks) {
  c();
}
```

The output is `0` and then `1`, as expected. In contrast, the example
would print `2` and then `2` in JavaScript.

上述代码执行后会输出 `0` 和 `1`，但是如果在 JavaScript 中执行同样的代码则会输出两个 `2`。

If the object that you are iterating over is an Iterable (such as List or Set)
and if you don't need to know the current iteration counter, 
you can use the `for-in` form of [iteration][]:

如果要遍历的对象是一个可迭代对象（例如 List 或 Set），并且你不需要知道当前的遍历索引，
则可以使用 `for-in` 方法进行 [遍历](/guides/libraries/library-tour#iteration)：

<?code-excerpt "misc/lib/language_tour/control_flow.dart (collection)"?>
```dart
for (final candidate in candidates) {
  candidate.interview();
}
```

{{site.alert.tip}}

  To practice using `for-in`, follow the
  [Iterable collections codelab](/codelabs/iterables).
  
  若想练习使用 `for-in`，请参考 [遍历集合 codelab](/codelabs/iterables)。
  
{{site.alert.end}}

Iterable classes also have a [forEach()][] method as another option:

可迭代对象同时可以使用 [forEach()][] 方法作为另一种选择：

<?code-excerpt "misc/test/language_tour/control_flow_test.dart (forEach)"?>
```dart
var collection = [1, 2, 3];
collection.forEach(print); // 1 2 3
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

`do-while` 循环则会 **先执行一遍循环体** 再判断条件：

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
[`Iterable`][] such as a list or set:

如果你正在使用诸如 List 或 Set 之类的 [`Iterable`][] 对象，你可以用以下方式重写上述例子:

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

不匹配任何 `case` 语句的情况下，会执行 `default` 子句中的代码：

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
    // ERROR: Missing break

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
  case 'CLOSED': // Empty case falls through.
  case 'NOW_CLOSED':
    // Runs for both CLOSED and NOW_CLOSED.
    executeNowClosed();
    break;
}
```

If you really want fall-through, you can use a `continue` statement and
a label:

在非空 `case` 语句中想要实现 fall-through 的形式，
可以使用 `continue` 语句配合 label 的方式实现:

<?code-excerpt "misc/lib/language_tour/control_flow.dart (switch-continue)"?>
```dart
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
```

A `case` clause can have local variables, which are visible only inside
the scope of that clause.

每个 `case` 子句都可以有局部变量且仅在该 case 语句内可见。


### Assert

### 断言

During development, use an assert 
statement—<code>assert(<em>condition</em>, <em>optionalMessage</em>)</code>;—to
disrupt normal execution if a boolean condition is false. 
You can find examples of assert statements throughout this tour. 
Here are some more:

在开发过程中，可以在条件表达式为 false 时
使用 — <code>assert(<em>条件</em>, <em>可选信息</em>)</code>; — 语句
来打断代码的执行。你可以在本文中找到大量使用 assert 的例子。
下面是相关示例：

<?code-excerpt "misc/test/language_tour/control_flow_test.dart (assert)"?>
```dart
// Make sure the variable has a non-null value.
assert(text != null);

// Make sure the value is less than 100.
assert(number < 100);

// Make sure this is an https URL.
assert(urlString.startsWith('https'));
```

To attach a message to an assertion,
add a string as the second argument to `assert`
(optionally with a [trailing comma][trailing commas]):

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
[`AssertionError`][]) is thrown.

`assert` 的第一个参数可以是值为布尔值的任何表达式。
如果表达式的值为 true，则断言成功，继续执行。
如果表达式的值为 false，则断言失败，抛出一个 [`AssertionError`][] 异常。

When exactly do assertions work?
That depends on the tools and framework you're using:

如何判断断言是否生效？
断言是否生效依赖开发工具和使用的框架：

* Flutter enables assertions in [debug mode.][Flutter debug mode]

  Flutter 在 [调试模式][Flutter debug mode] 时生效。

* Development-only tools such as [`webdev serve`][]
  typically enable assertions by default.

  一些开发工具比如 [`webdev serve`][] 通常情况下是默认生效的。

* Some tools, such as [`dart run`][] and [`dart compile js`][]
  support assertions through a command-line flag: `--enable-asserts`.

  其他一些工具，比如 [`dart run`][] 以及 [`dart compile js`][]
  通过在运行 Dart 程序时添加命令行参数 `--enable-asserts` 使 assert 生效。

In production code, assertions are ignored, and
the arguments to `assert` aren't evaluated.

在生产环境代码中，断言会被忽略，
与此同时传入 `assert` 的参数不被判断。

[webdev serve]: /tools/webdev#serve
[dart compile js]: /tools/dart-compile#js

## Exceptions

## 异常

Your Dart code can throw and catch exceptions. Exceptions are errors
indicating that something unexpected happened. If the exception isn’t
caught, the [isolate](#isolates) that raised the exception is suspended,
and typically the isolate and its program are terminated.

Dart 代码可以抛出和捕获异常。异常表示一些未知的错误情况，
如果异常没有捕获则会被抛出从而导致抛出异常的代码终止执行。

In contrast to Java, all of Dart’s exceptions are unchecked exceptions.
Methods don't declare which exceptions they might throw, and you aren't
required to catch any exceptions.

与 Java 不同的是，Dart 的所有异常都是非必检异常，
方法不必声明会抛出哪些异常，并且你也不必捕获任何异常。

Dart provides [`Exception`][] and [`Error`][]
types, as well as numerous predefined subtypes. You can, of course,
define your own exceptions. However, Dart programs can throw any
non-null object—not just Exception and Error objects—as an exception.

Dart 提供了 [`Exception`][] 和 [`Error`][] 两种类型的异常以及它们一系列的子类，
你也可以定义自己的异常类型。
但是在 Dart 中可以将任何非 null 对象作为异常抛出
而不局限于 Exception 或 Error 类型。

### Throw

### 抛出异常

Here’s an example of throwing, or *raising*, an exception:

下面是关于抛出或者 **引发** 异常的示例：

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

  Production-quality code usually throws types that implement [`Error`][] or
  [`Exception`][].

  优秀的代码通常会抛出 [`Error`][] 或 [`Exception`][] 类型的异常。

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
  // A specific exception
  buyMoreLlamas();
} on Exception catch (e) {
  // Anything else that is an exception
  print('Unknown exception: $e');
} catch (e) {
  // No specified type, handles all
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
and the second is the stack trace (a [`StackTrace`][] object).

你可以为 `catch` 方法指定两个参数，
第一个参数为抛出的异常对象，
第二个参数为栈信息 [`StackTrace`][] 对象：

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

无论是否抛出异常，`finally` 语句始终执行，
如果没有指定 `catch` 语句来捕获异常，则异常会在执行完 `finally` 语句后抛出：

<?code-excerpt "misc/lib/language_tour/exceptions.dart (finally)"?>
```dart
try {
  breedMoreLlamas();
} finally {
  // Always clean up, even if an exception is thrown.
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
  print('Error: $e'); // Handle the exception first.
} finally {
  cleanLlamaStalls(); // Then clean up.
}
```

Learn more by reading the
[Exceptions](/guides/libraries/library-tour#exceptions)
section of the library tour.

你可以阅读 Dart 核心库概览的
[异常](/guides/libraries/library-tour#exceptions) 章节获取更多相关信息。

## Classes

## 类

Dart is an object-oriented language with classes and mixin-based
inheritance. Every object is an instance of a class, and all classes
except `Null` descend from [`Object`][].
*Mixin-based inheritance* means that although every class
(except for the [top class][top-and-bottom], `Object?`)
has exactly one superclass, a class body can be reused in
multiple class hierarchies.
[Extension methods](#extension-methods) are a way to
add functionality to a class without changing the class or creating a subclass.

Dart 是支持基于 mixin 继承机制的面向对象语言，所有对象都是一个类的实例，
而除了 `Null` 以外的所有的类都继承自 [`Object`][] 类。
**基于 mixin 的继承** 意味着尽管每个类（[top class][top-and-bottom] `Object?` 除外）
都只有一个超类，一个类的代码可以在其它多个类继承中重复使用。
[扩展方法](#extension-methods) 是一种在不更改类
或创建子类的情况下向类添加功能的方式。

### Using class members

### 使用类的成员

Objects have *members* consisting of functions and data (*methods* and
*instance variables*, respectively). When you call a method, you *invoke*
it on an object: the method has access to that object’s functions and
data.

对象的 **成员** 由函数和数据（即 **方法** 和 **实例变量**）组成。
方法的 **调用** 要通过对象来完成，
这种方式可以访问对象的函数和数据。

Use a dot (`.`) to refer to an instance variable or method:

使用（`.`）来访问对象的实例变量或方法：

<?code-excerpt "misc/test/language_tour/classes_test.dart (object-members)"?>
```dart
var p = Point(2, 2);

// Get the value of y.
assert(p.y == 2);

// Invoke distanceTo() on p.
double distance = p.distanceTo(Point(4, 4));
```

Use `?.` instead of `.` to avoid an exception
when the leftmost operand is null:

使用 `?.` 代替 `.` 可以避免因为左边表达式为 null 而导致的问题：

<?code-excerpt "misc/test/language_tour/classes_test.dart (safe-member-access)"?>
```dart
// If p is non-null, set a variable equal to its y value.
var a = p?.y;
```


### Using constructors

### 使用构造函数

You can create an object using a *constructor*.
Constructor names can be either <code><em>ClassName</em></code> or
<code><em>ClassName</em>.<em>identifier</em></code>. For example,
the following code creates `Point` objects using the
`Point()` and `Point.fromJson()` constructors:

可以使用 **构造函数** 来创建一个对象。
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

assert(identical(a, b)); // They are the same instance!
```

Within a _constant context_, you can omit the `const` before a constructor
or literal. For example, look at this code, which creates a const map:

在 **常量上下文** 场景中，
你可以省略掉构造函数或字面量前的 `const` 关键字。
例如下面的例子中我们创建了一个常量 Map：

<?code-excerpt "misc/test/language_tour/classes_test.dart (const-context-withconst)" replace="/pointAndLine1/pointAndLine/g"?>
```dart
// Lots of const keywords here.
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
const pointAndLine = {
  'point': [ImmutablePoint(0, 0)],
  'line': [ImmutablePoint(1, 10), ImmutablePoint(-2, 11)],
};
```

If a constant constructor is outside of a constant context
and is invoked without `const`,
it creates a **non-constant object**:

但是如果无法根据上下文判断是否可以省略 `const`，
则不能省略掉 `const` 关键字，否则将会创建一个 **非常量对象** 例如：

<?code-excerpt "misc/test/language_tour/classes_test.dart (nonconst-const-constructor)"?>
```dart
var a = const ImmutablePoint(1, 1); // Creates a constant
var b = ImmutablePoint(1, 1); // Does NOT create a constant

assert(!identical(a, b)); // NOT the same instance!
```


### Getting an object's type

### 获取对象的类型

To get an object's type at runtime,
you can use the `Object` property `runtimeType`,
which returns a [`Type`][] object.

可以使用 `Object` 对象的 `runtimeType` 属性在运行时获取一个对象的类型，
该对象类型是 [`Type`][] 的实例。

<?code-excerpt "misc/test/language_tour/classes_test.dart (runtimeType)"?>
```dart
print('The type of a is ${a.runtimeType}');
```

{{site.alert.warn}}
  Use a [type test operator][] rather than `runtimeType`
  to test an object's type.
  In production environments, the test `object is Type` is more stable
  than the test `object.runtimeType == Type`.
{{site.alert.end}}

Up to here, you've seen how to _use_ classes.
The rest of this section shows how to _implement_ classes.

到目前为止，我们已经了解了如何 **使用** 类。
本节的其余部分将向你介绍如何 **实现** 一个类。

### Instance variables

### 实例变量

Here’s how you declare instance variables:

下面是声明实例变量的示例：

<?code-excerpt "misc/lib/language_tour/classes/point_with_main.dart (class)"?>
```dart
class Point {
  double? x; // Declare instance variable x, initially null.
  double? y; // Declare y, initially null.
  double z = 0; // Declare z, initially 0.
}
```

All uninitialized instance variables have the value `null`.

所有未初始化的实例变量其值均为 `null`。

All instance variables generate an implicit *getter* method.
Non-final instance variables and
`late final` instance variables without initializers also generate
an implicit *setter* method. For details,
see [Getters and setters](#getters-and-setters).

所有实例变量均会隐式地声明一个 *Getter* 方法。
非终值的实例变量和 `late final` 声明但未声明初始化的实例变量还会隐式地声明一个 *Setter* 方法。
你可以查阅 [Getter 和 Setter](#getters-and-setters) 获取更多相关信息。

<?code-excerpt "misc/lib/language_tour/classes/point_with_main.dart (class+main)" replace="/(double .*?;).*/$1/g" plaster="none"?>
```dart
class Point {
  double? x; // Declare instance variable x, initially null.
  double? y; // Declare y, initially null.
}

void main() {
  var point = Point();
  point.x = 4; // Use the setter method for x.
  assert(point.x == 4); // Use the getter method for x.
  assert(point.y == null); // Values default to null.
}
```

Instance variables can be `final`,
in which case they must be set exactly once.
Initialize `final`, non-`late` instance variables
at declaration,
using a constructor parameter, or
using a constructor's [initializer list](#initializer-list):

<?code-excerpt "misc/lib/effective_dart/usage_good.dart (field-init-at-decl)"?>
```dart
class ProfileMark {
  final String name;
  final DateTime start = DateTime.now();

  ProfileMark(this.name);
  ProfileMark.unnamed() : name = '';
}
```

If you need to assign the value of a `final` instance variable
after the constructor body starts, you can use one of the following:

* Use a [factory constructor](#factory-constructors).
* Use `late final`, but [_be careful:_][late-final-ivar]
  a `late final` without an initializer adds a setter to the API.

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
  double x = 0;
  double y = 0;

  Point(double x, double y) {
    // See initializing formal parameters for a better way
    // to initialize instance variables.
    this.x = x;
    this.y = y;
  }
}
```

The `this` keyword refers to the current instance.

使用 `this` 关键字引用当前实例。

{{site.alert.note}}

  Use `this` only when there is a name conflict. 
  Otherwise, Dart style omits the `this`.

  当且仅当命名冲突时使用 `this` 关键字才有意义，否则 Dart 会忽略 `this` 关键字。

{{site.alert.end}}


#### Initializing formal parameters

#### 终值初始化

The pattern of assigning a constructor argument to an instance variable
is so common, 
Dart has initializing formal parameters to make it easy.

对于大多数编程语言来说在构造函数中为实例变量赋值的过程都是类似的，
而 Dart 则提供了一种特殊的语法糖来简化该步骤。

Initializing parameters can also be used to initialize
non-nullable or `final` instance variables,
which both must be initialized or provided a default value.

构造中初始化的参数可以用于初始化非空或 `final` 修饰的变量，
它们都必须被初始化或提供一个默认值。

<?code-excerpt "misc/lib/language_tour/classes/point.dart (constructor-initializer)" plaster="none"?>
```dart
class Point {
  final double x;
  final double y;

  // Sets the x and y instance variables
  // before the constructor body runs.
  Point(this.x, this.y);
}
```

The variables introduced by the initializing formals
are implicitly final and only in scope of the initializer list.

在初始化时出现的变量默认是隐式终值，且只在初始化时可用。

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
const double xOrigin = 0;
const double yOrigin = 0;

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);

  // Named constructor
  [!Point.origin()!]
      : x = xOrigin,
        y = yOrigin;
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

<?code-excerpt "misc/lib/language_tour/classes/employee.dart (super)" plaster="none"?>
```dart:run-dartpad:height-450px:ga_id-non_default_superclass_constructor
class Person {
  String? firstName;

  Person.fromJson(Map data) {
    print('in Person');
  }
}

class Employee extends Person {
  // Person does not have a default constructor;
  // you must call super.fromJson().
  Employee.fromJson(super.data) : super.fromJson() {
    print('in Employee');
  }
}

void main() {
  var employee = Employee.fromJson({});
  print(employee);
  // Prints:
  // in Person
  // in Employee
  // Instance of 'Employee'
}
```

Because the arguments to the superclass constructor are evaluated before
invoking the constructor, an argument can be an expression such as a
function call:

因为参数会在子类构造函数被执行前传递给父类的构造函数，
因此该参数也可以是一个表达式，比如一个函数：

<?code-excerpt "misc/lib/language_tour/classes/employee.dart (method-then-constructor)"?>
```dart
class Employee extends Person {
  Employee() : super.fromJson(fetchDefaultData());
  // ···
}
```

{{site.alert.warning}}

  Arguments to the superclass constructor don't have access to `this`. For
  example, arguments can call static methods but not instance methods.

  传递给父类构造函数的参数不能使用 `this` 关键字，
  因为在参数传递的这一步骤，子类构造函数尚未执行，
  子类的实例对象也就还未初始化，
  因此所有的实例成员都不能被访问，但是类成员可以。

{{site.alert.end}}

#### Super parameters

#### 超类参数

To avoid having to manually pass each parameter
into the super invocation of a constructor,
you can use super-initializer parameters to forward parameters
to the specified or default superclass constructor.
This feature can't be used with redirecting constructors.
Super-initializer parameters have similar syntax and semantics to
[initializing formal parameters](#initializing-formal-parameters):

为了不重复地将参数传递到超类构造的指定参数，
你可以使用超类参数，直接在子类的构造中使用超类构造的某个参数。
超类参数不能和重定向的参数一起使用。
超类参数的表达式和写法与
[终值初始化](#initializing-formal-parameters) 类似：

<?code-excerpt "misc/lib/language_tour/classes/super_initializer_parameters.dart (positional)" plaster="none"?>
```dart
class Vector2d {
  final double x;
  final double y;

  Vector2d(this.x, this.y);
}

class Vector3d extends Vector2d {
  final double z;

  // Forward the x and y parameters to the default super constructor like:
  // Vector3d(final double x, final double y, this.z) : super(x, y);
  Vector3d(super.x, super.y, this.z);
}
```

Super-initializer parameters cannot be positional 
if the super-constructor invocation already has positional arguments,
but they can always be named:

如果超类构造的位置参数已被使用，
那么超类构造参数就不能再继续使用被占用的位置。
但是超类构造参数可以始终是命名参数：

<?code-excerpt "misc/lib/language_tour/classes/super_initializer_parameters.dart (named)" plaster="none"?>
```dart
class Vector2d {
  // ...

  Vector2d.named({required this.x, required this.y});
}

class Vector3d extends Vector2d {
  // ...

  // Forward the y parameter to the named super constructor like:
  // Vector3d.yzPlane({required double y, required this.z})
  //       : super.named(x: 0, y: y);
  Vector3d.yzPlane({required super.y, required this.z}) : super.named(x: 0);
}
```

{{site.alert.version-note}}

  Using super-initializer parameters 
  requires a [language version][] of at least 2.17.
  If you're using an earlier language version,
  you must manually pass in all super constructor parameters.

  使用超类参数需要 [Dart SDK 版本][language version] 至少为 2.17。
  在先前的版本中，你必须手动传递所有的超类构造参数。

{{site.alert.end}}

#### Initializer list

#### 初始化列表

Besides invoking a superclass constructor, you can also initialize
instance variables before the constructor body runs. Separate
initializers with commas.

除了调用父类构造函数之外，还可以在构造函数体执行之前初始化实例变量。
每个实例变量之间使用逗号分隔。

{% comment %}
[TODO #2950: Maybe change example or point to discussion of ! (in map section?).]
{% endcomment %}

<?code-excerpt "misc/lib/language_tour/classes/point_alt.dart (initializer-list)"?>
```dart
// Initializer list sets instance variables before
// the constructor body runs.
Point.fromJson(Map<String, double> json)
    : x = json['x']!,
      y = json['y']! {
  print('In Point.fromJson(): ($x, $y)');
}
```

{{site.alert.warning}}

  The right-hand side of an initializer doesn't have access to `this`.

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

Initializer lists are handy when setting up final fields. The following example
initializes three final fields in an initializer list. Click **Run** to execute
the code.

使用初始化列表设置 `final` 字段非常方便，
下面的示例中就使用初始化列表来设置了三个 `final` 变量的值。
点击运行按钮执行示例代码。

<?code-excerpt "misc/lib/language_tour/classes/point_with_distance_field.dart"?>
```dart:run-dartpad:height-340px:ga_id-initializer_list
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


#### Redirecting constructors

#### 重定向构造函数

Sometimes a constructor’s only purpose is to redirect to another
constructor in the same class. A redirecting constructor’s body is
empty, with the constructor call
(using `this` instead of the class name)
appearing after a colon (:).

有时候类中的构造函数仅用于调用类中其它的构造函数，此时该构造函数没有函数体，
只需在函数签名后使用（:）指定需要重定向到的其它构造函数 (使用 `this` 而非类名)：

<?code-excerpt "misc/lib/language_tour/classes/point_redirecting.dart"?>
```dart
class Point {
  double x, y;

  // The main constructor for this class.
  Point(this.x, this.y);

  // Delegates to the main constructor.
  Point.alongXAxis(double x) : this(x, 0);
}
```

#### Constant constructors

#### 常量构造函数

If your class produces objects that never change, you can make these
objects compile-time constants. To do this, define a `const` constructor
and make sure that all instance variables are `final`.

如果类生成的对象都是不变的，可以在生成这些对象时就将其变为编译时常量。
你可以在类的构造函数前加上 `const` 关键字
并确保所有实例变量均为 `final` 来实现该功能。

<?code-excerpt "misc/lib/language_tour/classes/immutable_point.dart"?>
```dart
class ImmutablePoint {
  static const ImmutablePoint origin = ImmutablePoint(0, 0);

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

{{site.alert.tip}}

  Another way to handle late initialization of a final variable
  is to [use `late final` (carefully!)][late-final-ivar].

  另一种处理懒加载变量的方式是
  [使用 `late final`（谨慎使用）][late-final-ivar]。

{{site.alert.end}}

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

  // _cache is library-private, thanks to
  // the _ in front of its name.
  static final Map<String, Logger> _cache = <String, Logger>{};

  factory Logger(String name) {
    return _cache.putIfAbsent(name, () => Logger._internal(name));
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

工厂构造函数的调用方式与其他构造函数一样：

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

方法是为对象提供行为的函数。

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
  final double x;
  final double y;

  Point(this.x, this.y);

  double distanceTo(Point other) {
    var dx = x - other.x;
    var dy = y - other.y;
    return sqrt(dx * dx + dy * dy);
  }
}
```

#### Operators {#_operators}

#### 操作符

Operators are instance methods with special names.
Dart allows you to define operators with the following names:

运算符是有着特殊名称的实例方法。
Dart 允许您使用以下名称定义运算符：

`<`  | `+`  | `|`  | `>>>`
`>`  | `/`  | `^`  | `[]`
`<=` | `~/` | `&`  | `[]=`
`>=` | `*`  | `<<` | `~`
`-`  | `%`  | `>>` | `==`
{:.table}

{{site.alert.note}}

  You may have noticed that some [operators](#operators), like `!=`, aren't in
  the list of names. That's because they're just syntactic sugar. For example,
  the expression `e1 != e2` is syntactic sugar for `!(e1 == e2)`.

  你可能注意到有一些 [操作符](#operators) 没有出现在列表中，例如 `!=`。
  因为它们仅仅是语法糖。
  表达式 `e1 != e2` 仅仅是 `!(e1 == e2)` 的一个语法糖。

{{site.alert.end}}

{%- comment %}
  Internal note from https://github.com/dart-lang/site-www/pull/2691#discussion_r506184100:
  -  `??`, `&&` and `||` are excluded because they are lazy / short-circuiting operators
  - `!` is probably excluded for historical reasons
{% endcomment %}

An operator declaration is identified using the built-in identifier `operator`.
The following example defines vector 
addition (`+`), subtraction (`-`), and equality (`==`):

为了表示重写操作符，我们使用 `operator` 标识来进行标记。
下面是重写 `+` 和 `-` 操作符的例子

<?code-excerpt "misc/lib/language_tour/classes/vector.dart"?>
```dart
class Vector {
  final int x, y;

  Vector(this.x, this.y);

  Vector operator +(Vector v) => Vector(x + v.x, y + v.y);
  Vector operator -(Vector v) => Vector(x - v.x, y - v.y);

  @override
  bool operator ==(Object other) =>
      other is Vector && x == other.x && y == other.y;

  @override
  int get hashCode => Object.hash(x, y);
}

void main() {
  final v = Vector(2, 3);
  final w = Vector(2, 2);

  assert(v + w == Vector(4, 5));
  assert(v - w == Vector(0, 1));
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

  // Define two calculated properties: right and bottom.
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
  // Define instance variables and methods...

  void doSomething(); // Define an abstract method.
}

class EffectiveDoer extends Doer {
  void doSomething() {
    // Provide an implementation, so the method is not abstract here...
  }
}
```


### Abstract classes

### 抽象类

Use the `abstract` modifier to define an *abstract class*—a class that
can’t be instantiated. Abstract classes are useful for defining
interfaces, often with some implementation. If you want your abstract
class to appear to be instantiable, define a [factory constructor][factory].

使用关键字 `abstract` 标识类可以让该类成为 **抽象类**，抽象类将无法被实例化。
抽象类常用于声明接口方法、有时也会有具体的方法实现。
如果想让抽象类同时可被实例化，可以为其定义 [工厂构造函数][factory]。

[factory]: #factory-constructors

Abstract classes often have [abstract methods](#abstract-methods).
Here’s an example of declaring an abstract class that has an abstract
method:

抽象类常常会包含 [抽象方法](#abstract-methods)。
下面是一个声明具有抽象方法的抽象类示例：

<?code-excerpt "misc/lib/language_tour/classes/misc.dart (abstract)"?>
```dart
// This class is declared abstract and thus
// can't be instantiated.
abstract class AbstractContainer {
  // Define constructors, fields, methods...

  void updateChildren(); // Abstract method.
}
```

<a id="interfaces"></a>
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
class Person {
  // In the interface, but visible only in this library.
  final String _name;

  // Not in the interface, since this is a constructor.
  Person(this._name);

  // In the interface.
  String greet(String who) => 'Hello, $who. I am $_name.';
}

// An implementation of the Person interface.
class Impostor implements Person {
  String get _name => '';

  String greet(String who) => 'Hi $who. Do you know who I am?';
}

String greetBob(Person person) => person.greet('Bob');

void main() {
  print(greetBob(Person('Kathy')));
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

For another usage of `extends`, see the discussion of
[parameterized types](#restricting-the-parameterized-type)
in [generics](#generics).

想了解其他 `extends` 的用法，请查看 [泛型](#generics) 部分中的
[参数化类型](#restricting-the-parameterized-type)。

<a name="overridable-operators"></a>

#### Overriding members

#### 重写类成员

Subclasses can override instance methods (including [operators](#_operators)),
getters, and setters.
You can use the `@override` annotation to indicate that you are
intentionally overriding a member:

子类可以重写父类的实例方法（包括 [操作符](#_operators)）、
Getter 以及 Setter 方法。
你可以使用 `@override` 注解来表示你重写了一个成员：

<?code-excerpt "misc/lib/language_tour/metadata/television.dart (override)" replace="/@override/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
class Television {
  // ···
  set contrast(int value) {...}
}

class SmartTelevision extends Television {
  [!@override!]
  set contrast(num value) {...}
  // ···
}
{% endprettify %}

An overriding method declaration must match
the method (or methods) that it overrides in several ways:

* The return type must be the same type as (or a subtype of)
  the overridden method's return type.
* Argument types must be the same type as (or a supertype of)
  the overridden method's argument types.
  In the preceding example, the `contrast` setter of `SmartTelevision`
  changes the argument type from `int` to a supertype, `num`.
* If the overridden method accepts _n_ positional parameters,
  then the overriding method must also accept _n_ positional parameters.
* A [generic method](#using-generic-methods) can't override a non-generic one,
  and a non-generic method can't override a generic one.

Sometimes you might want to narrow the type of
a method parameter or an instance variable.
This violates the normal rules, and
it's similar to a downcast in that it can cause a type error at runtime.
Still, narrowing the type is possible
if the code can guarantee that a type error won't occur.
In this case, you can use the 
[`covariant` keyword](/guides/language/sound-problems#the-covariant-keyword)
in a parameter declaration.
For details, see the 
[Dart language specification][].

你可以使用 [`covariant` 关键字](/guides/language/sound-problems#the-covariant-keyword)
来缩小代码中那些符合 [类型安全](/guides/language/type-system) 的方法参数或实例变量的类型。

{{site.alert.warning}}

  If you override `==`, you should also override Object's `hashCode` getter.
  For an example of overriding `==` and `hashCode`, see
  [Implementing map keys](/guides/libraries/library-tour#implementing-map-keys).

  如果重写 `==` 操作符，必须同时重写对象 `hashCode` 的 Getter 方法。
  你可以查阅 [实现映射键](/guides/libraries/library-tour#implementing-map-keys)
  获取更多关于重写的 `==` 和 `hashCode` 的例子。

{{site.alert.end}}

#### noSuchMethod()

#### noSuchMethod 方法

To detect or react whenever code attempts to use a non-existent method or
instance variable, you can override `noSuchMethod()`:

如果调用了对象上不存在的方法或实例变量将会触发 `noSuchMethod` 方法，
你可以重写 `noSuchMethod` 方法来追踪和记录这一行为：

<?code-excerpt "misc/lib/language_tour/classes/no_such_method.dart" replace="/noSuchMethod(?!,)/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
class A {
  // Unless you override noSuchMethod, using a
  // non-existent member results in a NoSuchMethodError.
  @override
  void [!noSuchMethod!](Invocation invocation) {
    print('You tried to use a non-existent member: '
        '${invocation.memberName}');
  }
}
{% endprettify %}

You **can't invoke** an unimplemented method unless
**one** of the following is true:

只有下面其中一个条件成立时，你才能调用一个未实现的方法：

* The receiver has the static type `dynamic`.

  接收方是静态的 `dynamic` 类型。

* The receiver has a static type that
defines the unimplemented method (abstract is OK),
and the dynamic type of the receiver has an implementation of `noSuchMethod()`
that's different from the one in class `Object`.

  接收方具有静态类型，定义了未实现的方法（抽象亦可），
  并且接收方的动态类型实现了 `noSuchMethod`
  方法且具体的实现与 `Object` 中的不同。

For more information, see the informal
[noSuchMethod forwarding specification.](https://github.com/dart-lang/language/blob/master/archive/feature-specifications/nosuchmethod-forwarding.md)

你可以查阅
[noSuchMethod 转发规范](https://github.com/dart-lang/language/blob/master/archive/feature-specifications/nosuchmethod-forwarding.md)
获取更多相关信息。

### Extension methods

### 扩展方法

Extension methods are a way to add functionality to existing libraries.
You might use extension methods without even knowing it.
For example, when you use code completion in an IDE,
it suggests extension methods alongside regular methods.

扩展方法是向现有库添加功能的一种方式。
你可能已经在不知道它是扩展方法的情况下使用了它。
例如，当您在 IDE 中使用代码完成功能时，
它建议将扩展方法与常规方法一起使用。

Here's an example of using an extension method on `String`
named `parseInt()` that's defined in `string_apis.dart`:

这里是一个在 `String` 中使用扩展方法的样例，
我们取名为 `parseInt()`，它在 `string_apis.dart` 中定义：

```dart
import 'string_apis.dart';
...
print('42'.padLeft(5)); // Use a String method.
print('42'.parseInt()); // Use an extension method.
```

For details of using and implementing extension methods, see the
[extension methods page][].

有关使用以及实现扩展方法的详细信息，请参阅
[扩展方法页面][extension methods page]。

<a id="enums"></a>
### Enumerated types

### 枚举类型

Enumerated types, often called _enumerations_ or _enums_,
are a special kind of class used to represent
a fixed number of constant values.

枚举类型是一种特殊的类型，也称为 **enumerations** 或 **enums**，
用于定义一些固定数量的常量值。

{{site.alert.note}}

  All enums automatically extend the [`Enum`][] class.
  They are also sealed, 
  meaning they cannot be subclassed, implemented, mixed in, 
  or otherwise explicitly instantiated.

  所有的枚举都继承于 [`Enum`][] 类。
  枚举类是封闭的，即不能被继承、被实现、被 mixin 混入或显式被实例化。

  Abstract classes and mixins can explicitly implement or extend `Enum`,
  but unless they are then implemented by or mixed into an enum declaration,
  no objects can actually implement the type of that class or mixin.

  抽象类和 mixin 可以显式的实现或继承 `Enum`，
  但只有枚举可以实现或混入这个类，其他类无法享有同样的操作。

{{site.alert.end}}

#### Declaring simple enums

#### 声明简单的枚举

To declare a simple enumerated type,
use the `enum` keyword and
list the values you want to be enumerated:

你可以使用关键字 `enum` 来定义简单的枚举类型和枚举值：

<?code-excerpt "misc/lib/language_tour/classes/enum.dart (enum)"?>
```dart
enum Color { red, green, blue }
```

{{site.alert.tip}}
  You can also use [trailing commas][] when declaring an enumerated type
  to help prevent copy-paste errors.
{{site.alert.end}}

#### Declaring enhanced enums

#### 声明增强的枚举类型

Dart also allows enum declarations to declare classes
with fields, methods, and const constructors
which are limited to a fixed number of known constant instances.

Dart 中的枚举也支持定义字段、方法和常量构造，
常量构造只能构造出已知数量的常量实例（已定义的枚举值）。

To declare an enhanced enum,
follow a syntax similar to normal [classes](#classes),
but with a few extra requirements:

你可以使用与定义 [类](#classes) 类似的语句来定义增强的枚举，
但是这样的定义有一些限制条件：

* Instance variables must be `final`, 
  including those added by [mixins](#mixins).

  实例的字段必须是 `final`，包括由 [mixin](#mixins) 混入的字段。

* All [generative constructors](#constant-constructors) must be constant.

  所有的 [实例化构造](#constant-constructors) 必须以 `const` 修饰。

* [Factory constructors](#factory-constructors) can only return
  one of the fixed, known enum instances.

  [工厂构造](#factory-constructors) 只能返回已知的一个枚举实例。

* No other class can be extended as [`Enum`] is automatically extended.

  由于 [`Enum`][] 已经自动进行了继承，所以枚举类不能再继承其他类。

* There cannot be overrides for `index`, `hashCode`, the equality operator `==`.

  不能重载 `index`、`hashCode` 和比较操作符 `==`。

* A member named `values` cannot be declared in an enum,
  as it would conflict with the automatically generated static `values` getter.

  不能声明 `values` 字段，否则它将与枚举本身的静态 `values` getter 冲突。

* All instances of the enum must be declared
  in the beginning of the declaration,
  and there must be at least one instance declared.

  在进行枚举定义时，所有的实例都需要首先进行声明，
  且至少要声明一个枚举实例。


Here is an example that declares an enhanced enum
with multiple instances, instance variables,
a getter, and an implemented interface:

下方是一个增强枚举的例子，
它包含多个枚举实例、成员变量、getter 并且实现了接口：

<?code-excerpt "misc/lib/language_tour/classes/enum.dart (enhanced)"?>
```dart
enum Vehicle implements Comparable<Vehicle> {
  car(tires: 4, passengers: 5, carbonPerKilometer: 400),
  bus(tires: 6, passengers: 50, carbonPerKilometer: 800),
  bicycle(tires: 2, passengers: 1, carbonPerKilometer: 0);

  const Vehicle({
    required this.tires,
    required this.passengers,
    required this.carbonPerKilometer,
  });

  final int tires;
  final int passengers;
  final int carbonPerKilometer;

  int get carbonFootprint => (carbonPerKilometer / passengers).round();

  @override
  int compareTo(Vehicle other) => carbonFootprint - other.carbonFootprint;
}
```

To learn more about declaring enhanced enums,
see the section on [Classes](#classes).

想要了解更多关于定义增强枚举的内容，
可以阅读 [类](#classes) 小节。

{{site.alert.version-note}}

  Enhanced enums require a [language version][] of at least 2.17.

  增强枚举仅在 [Dart SDK 版本][language version] 2.17 以上可用。

{{site.alert.end}}

#### Using enums

#### 使用枚举

Access the enumerated values like
any other [static variable](#static-variables):

你可以像访问 [静态变量](#static-variables) 一样访问枚举值：

<?code-excerpt "misc/lib/language_tour/classes/enum.dart (access)"?>
```dart
final favoriteColor = Color.blue;
if (favoriteColor == Color.blue) {
  print('Your favorite color is blue!');
}
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

To get a list of all the enumerated values,
use the enum's `values` constant.

想要获得全部的枚举值，使用枚举类的 `values` 方法获取包含它们的列表：

<?code-excerpt "misc/lib/language_tour/classes/enum.dart (values)"?>
```dart
List<Color> colors = Color.values;
assert(colors[2] == Color.blue);
```

You can use enums in [switch statements](#switch-and-case), and
you'll get a warning if you don't handle all of the enum's values:

你可以在 [Switch 语句](#switch-and-case)中使用枚举，
但是需要注意的是必须处理枚举值的每一种情况，
即每一个枚举值都必须成为一个 case 子句，不然会出现警告：

<?code-excerpt "misc/lib/language_tour/classes/enum.dart (switch)"?>
```dart
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
```

If you need to access the name of an enumerated value,
such as `'blue'` from `Color.blue`,
use the `.name` property:

如果你想要获取一个枚举值的名称，例如 `Color.blue` 的 `'blue'`，
请使用 `.name` 属性：

<?code-excerpt "misc/lib/language_tour/classes/enum.dart (name)"?>
```dart
print(Color.blue.name); // 'blue'
```


<a id="mixins"></a>
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

class Maestro extends Person [!with Musical, Aggressive, Demented!] {
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

想要实现一个 Mixin，请创建一个继承自 Object 且未声明构造函数的类。
除非你想让该类与普通的类一样可以被正常地使用，否则请使用关键字 `mixin` 替代 `class`。
例如：

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

Static methods (class methods) don't operate on an instance, and thus
don't have access to `this`.
They do, however, have access to static variables.
As the following example shows,
you invoke static methods directly on a class:

静态方法（即类方法）不能对实例进行操作，因此不能使用 `this`。
但是他们可以访问静态变量。
如下面的例子所示，你可以在一个类上直接调用静态方法：

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
[`List`][], you’ll see that the
type is actually `List<E>`. The \<...\> notation marks List as a
*generic* (or *parameterized*) type—a type that has formal type
parameters. [By convention][], most type variables have single-letter names,
such as E, T, S, K, and V.

如果你查看数组的 API 文档，你会发现数组 [`List`][] 的实际类型为 `List<E>`。
\<...\> 符号表示数组是一个 *泛型*（或 *参数化类型*）
[通常][By convention] 使用一个字母来代表类型参数，比如 E、T、S、K 和 V 等等。

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
var names = <String>[];
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
var names = <String>['Seth', 'Kathy', 'Lars'];
var uniqueNames = <String>{'Seth', 'Kathy', 'Lars'};
var pages = <String, String>{
  'index.html': 'Homepage',
  'robots.txt': 'Hints for web robots',
  'humans.txt': 'We are people, not machines'
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

{% comment %}[TODO #2950: It isn't idiomatic to use a constructor for an empty Map. Change to a class that doesn't have literal support.]{% endcomment %}

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

Dart的泛型类型是 **固化的**，这意味着即便在运行时也会保持类型信息：

<?code-excerpt "misc/test/language_tour/generics_test.dart (generic-collections)"?>
```dart
var names = <String>[];
names.addAll(['Seth', 'Kathy', 'Lars']);
print(names is List<String>); // true
```

{{site.alert.note}}

  In contrast, generics in Java use *erasure*, which means that generic
  type parameters are removed at runtime. In Java, you can test whether
  an object is a List, but you can’t test whether it’s a `List<String>`.

  与 Java 不同的是，Java 中的泛型是类型 **擦除** 的，这意味着泛型类型会在运行时被移除。在 Java 中你可以判断对象是否为 List 但不可以判断对象是否为 `List<String>`。

{{site.alert.end}}


### Restricting the parameterized type

### 限制参数化类型

When implementing a generic type,
you might want to limit the types that can be provided as arguments,
so that the argument must be a subtype of a particular type.
You can do this using `extends`.

有时使用泛型的时候，你可能会想限制可作为参数的泛型范围，
也就是参数必须是指定类型的子类，
这时候可以使用 `extends` 关键字。

A common use case is ensuring that a type is non-nullable
by making it a subtype of `Object`
(instead of the default, [`Object?`][top-and-bottom]).

一种常见的非空类型处理方式，是将子类限制继承 `Object`
（而不是默认的 [`Object?`][top-and-bottom]）。

<?code-excerpt "misc/lib/language_tour/generics/misc.dart (non-nullable)"?>
```dart
class Foo<T extends Object> {
  // Any type provided to Foo for T must be non-nullable.
}
```

You can use `extends` with other types besides `Object`.
Here's an example of extending `SomeBaseClass`,
so that members of `SomeBaseClass` can be called on objects of type `T`:

<?code-excerpt "misc/lib/language_tour/generics/base_class.dart" replace="/extends SomeBaseClass(?=. \{)/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
class Foo<T [!extends SomeBaseClass!]> {
  // Implementation goes here...
  String toString() => "Instance of 'Foo<$T>'";
}

class Extender extends SomeBaseClass {...}
{% endprettify %}

It's OK to use `SomeBaseClass` or any of its subtypes as the generic argument:

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
print(foo); // Instance of 'Foo<SomeBaseClass>'
```

Specifying any non-`SomeBaseClass` type results in an error:

将非 `SomeBaseClass` 的类型作为泛型参数则会导致编译错误：

{:.fails-sa}
{% prettify dart tag=pre+code %}
var foo = [!Foo<Object>!]();
{% endprettify %}


### Using generic methods

### 使用泛型方法

Methods and functions also allow type arguments:

方法和参数也可以使用类型参数了:

<!-- {{site.dartpad}}/a02c53b001977efa4d803109900f21bb -->
<!-- https://gist.github.com/a02c53b001977efa4d803109900f21bb -->
<?code-excerpt "misc/test/language_tour/generics_test.dart (method)" replace="/<T.(?=\()|T/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
[!T!] first[!<T>!](List<[!T!]> ts) {
  // Do some initial work or error checking, then...
  [!T!] tmp = ts[0];
  // Do some additional checking or processing...
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

你可以查阅
[使用泛型函数](https://github.com/dart-lang/sdk/blob/master/pkg/dev_compiler/doc/GENERIC_METHODS.md)
获取更多关于泛型的信息。


## Libraries and visibility

## 库和可见性

The `import` and `library` directives can help you create a
modular and shareable code base. Libraries not only provide APIs, but
are a unit of privacy: identifiers that start with an underscore (`_`)
are visible only inside the library. *Every Dart app is a library*, even
if it doesn’t use a `library` directive.

`import` 和 `library` 关键字可以帮助你创建一个模块化和可共享的代码库。
代码库不仅只是提供 API 而且还起到了封装的作用：以下划线（`_`）开头的成员仅在代码库中可见。
**每个 Dart 程序都是一个库**，即便没有使用关键字 `library` 指定。

Libraries can be distributed using [packages](/guides/packages).

Dart 的库可以使用 [包工具](/guides/packages) 来发布和部署。

{{site.alert.info}}

  If you're curious why Dart uses underscores instead of
  access modifier keywords like `public` or `private`, see
  [SDK issue 33383](https://github.com/dart-lang/sdk/issues/33383).

  如果你对 Dart 为何使用下划线而不使用 `public` 或 `private` 作为可访问性关键字，
  可以查看 [SDK issue 33383](https://github.com/dart-lang/sdk/issues/33383)。

{{site.alert.end}}

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

`import` 的唯一参数是用于指定代码库的 URI，对于 Dart 内置的库，使用 `dart:xxxxxx` 的形式。
而对于其它的库，你可以使用一个文件系统路径或者以 `package:xxxxxx` 的形式。
`package:xxxxxx` 指定的库通过包管理器（比如 pub 工具）来提供：

<?code-excerpt "misc/test/language_tour/browser_test.dart (package-import)"?>
```dart
import 'package:test/test.dart';
```

{{site.alert.note}}

  *URI* stands for uniform resource identifier.

  **URI** 代表统一资源标识符。

  *URLs* (uniform resource locators) are a common kind of URI.

  **URL**（统一资源定位符）是一种常见的 URI。

{{site.alert.end}}


#### Specifying a library prefix

#### 指定库前缀

If you import two libraries that have conflicting identifiers, then you
can specify a prefix for one or both libraries. For example, if library1
and library2 both have an Element class, then you might have code like
this:

如果你导入的两个代码库有冲突的标识符，你可以为其中一个指定前缀。
比如如果 library1 和 library2 都有 Element 类，那么可以这么处理：

<?code-excerpt "misc/lib/language_tour/libraries/import_as.dart" replace="/(lib\d)\.dart/package:$1\/$&/g"?>
```dart
import 'package:lib1/lib1.dart';
import 'package:lib2/lib2.dart' as lib2;

// Uses Element from lib1.
Element element1 = Element();

// Uses Element from lib2.
lib2.Element element2 = lib2.Element();
```

#### Importing only part of a library

#### 导入库的一部分

If you want to use only part of a library, you can selectively import
the library. For example:

如果你只想使用代码库中的一部分，你可以有选择地导入代码库。例如：

<?code-excerpt "misc/lib/language_tour/libraries/show_hide.dart" replace="/(lib\d)\.dart/package:$1\/$&/g"?>
```dart
// Import only foo.
import 'package:lib1/lib1.dart' show foo;

// Import all names EXCEPT foo.
import 'package:lib2/lib2.dart' hide foo;
```

<a id="deferred-loading"></a>
#### Lazily loading a library

#### 延迟加载库

_Deferred loading_ (also called _lazy loading_)
allows a web app to load a library on demand,
if and when the library is needed.
Here are some cases when you might use deferred loading:

**延迟加载**（也常称为 **懒加载**）允许应用在需要时再去加载代码库，
下面是可能使用到延迟加载的场景：

* To reduce a web app's initial startup time.

  为了减少应用的初始化时间。

* To perform A/B testing—trying out
  alternative implementations of an algorithm, for example.

  处理 A/B 测试，比如测试各种算法的不同实现。

* To load rarely used functionality, such as optional screens and dialogs.

  加载很少会使用到的功能，比如可选的屏幕和对话框。


{{site.alert.warn}}

  **Only `dart compile js` supports deferred loading.**
  Flutter and the Dart VM don't support deferred loading.
  To learn more, see
  [issue #33118](https://github.com/dart-lang/sdk/issues/33118) and
  [issue #27776.](https://github.com/dart-lang/sdk/issues/27776)

  **目前只有 `dart compile js` 支持延迟加载**
  Flutter 和 Dart VM目前都不支持延迟加载。
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
Future<void> greet() async {
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

  导入文件的时候无法使用延迟加载库中的类型。如果你需要使用类型，则考虑把接口类型转移到另一个库中然后让两个库都分别导入这个接口库。

* Dart implicitly inserts `loadLibrary()` into the namespace that you define
  using <code>deferred as <em>namespace</em></code>.
  The `loadLibrary()` function returns a [`Future`](/guides/libraries/library-tour#future).

  Dart会隐式地将 `loadLibrary()` 导入到使用了
  <code>deferred as <em>命名空间</em></code> 的类中。
  `loadLibrary()` 函数返回的是一个 [Future](/guides/libraries/library-tour#future)。

### Implementing libraries

### 实现库

See
[Create Library Packages](/guides/libraries/create-library-packages)
for advice on how to implement a library package, including:

查阅 [创建依赖库包](/guides/libraries/create-library-packages) 可以获取有关如何实现库包的建议，包括：

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

  如何使用导入和导出命令实现多平台的库支持。


<a id="asynchrony"></a>
## Asynchrony support

## 异步支持

Dart libraries are full of functions that
return [`Future`][] or [`Stream`][] objects.
These functions are _asynchronous_:
they return after setting up
a possibly time-consuming operation
(such as I/O),
without waiting for that operation to complete.

Dart 代码库中有大量返回 [`Future`][] 或 [`Stream`][] 对象的函数，这些函数都是 **异步** 的，
它们会在耗时操作（比如I/O）执行完毕前直接返回而不会等待耗时操作执行完毕。

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

* Use `async` and `await`, as described here and in the
  [asynchronous programming codelab](/codelabs/async-await).

  使用 `async` 和 `await`，在
  [异步编程 codelab](/codelabs/async-await)
  中有更多描述；

* Use the Future API, as described
  [in the library tour](/guides/libraries/library-tour#future).

  使用 Future API，具体描述参考 [库概览](/guides/libraries/library-tour#future)。

Code that uses `async` and `await` is asynchronous,
but it looks a lot like synchronous code.
For example, here's some code that uses `await`
to wait for the result of an asynchronous function:

使用 `async` 和 `await` 的代码是异步的，但是看起来有点像同步代码。
例如，下面的代码使用 `await` 等待异步函数的执行结果。

<?code-excerpt "misc/lib/language_tour/async.dart (await-lookUpVersion)"?>
```dart
await lookUpVersion();
```

To use `await`, code must be in an `async` function—a
function marked as `async`:

必须在带有 async 关键字的 **异步函数** 中使用 `await`：

<?code-excerpt "misc/lib/language_tour/async.dart (checkVersion)" replace="/async|await/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
Future<void> checkVersion() [!async!] {
  var version = [!await!] lookUpVersion();
  // Do something with version
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
  （[代码行][synchronous-async-start]）时返回一个 Future 对象，
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
  // React to inability to look up the version
}
```

You can use `await` multiple times in an `async` function.
For example, the following code waits three times
for the results of functions:

你可以在异步函数中多次使用 `await` 关键字。
例如，下面代码中等待了三次函数结果：

<?code-excerpt "misc/lib/language_tour/async.dart (repeated-await)"?>
```dart
var entrypoint = await findEntryPoint();
var exitCode = await runExecutable(entrypoint, args);
await flushThenExit(exitCode);
```

In <code>await <em>expression</em></code>,
the value of <code><em>expression</em></code> is usually a Future;
if it isn't, then the value is automatically wrapped in a Future.
This Future object indicates a promise to return an object.
The value of <code>await <em>expression</em></code> is that returned object.
The await expression makes execution pause until that object is available.

<code>await <em>表达式的返回值通常是一个 Future 对象；
如果不是的话也会自动将其包裹在一个 Future 对象里。
Future 对象代表一个“承诺”，
<code>await <em>表达式</em></code>会阻塞直到需要的对象返回。

**If you get a compile-time error when using `await`,
make sure `await` is in an `async` function.**
For example, to use `await` in your app's `main()` function,
the body of `main()` must be marked as `async`:

**如果在使用 `await` 时导致编译错误，请确保 `await` 在一个异步函数中使用**。
例如，如果想在 main() 函数中使用 `await`，
那么 `main()` 函数就必须使用 `async` 关键字标识。

<?code-excerpt "misc/lib/language_tour/async.dart (main)" replace="/async|await/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
void main() [!async!] {
  checkVersion();
  print('In main: version is ${[!await!] lookUpVersion()}');
}
{% endprettify %}

{{site.alert.note}}

  The preceding example uses an `async` function (`checkVersion()`)
  without waiting for a result—a practice that can cause problems
  if the code assumes that the function has finished executing.
  To avoid this problem,
  use the [unawaited_futures linter rule][].

  如上的例子使用了声明为 `async` 的函数 `checkVersion()`，但没有等待其结果。
  在实际的开发中，如果代码假设函数已经执行完成，则可能导致一些异步的问题。
  想要避免这些问题，请使用
  [unawaited_futures 提示规则][unawaited_futures linter rule]。

{{site.alert.end}}

[unawaited_futures linter rule]: /tools/linter-rules#unawaited_futures

For an interactive introduction to using futures, `async`, and `await`,
see the [asynchronous programming codelab](/codelabs/async-await).


<a id="async"></a>
### Declaring async functions

### 声明异步函数

An `async` function is a function whose body is marked with
the `async` modifier.

**异步函数** 是函数体由 `async` 关键字标记的函数。

Adding the `async` keyword to a function makes it return a Future.
For example, consider this synchronous function,
which returns a String:

将关键字 `async` 添加到函数并让其返回一个 Future 对象。
假设有如下返回 String 对象的方法：

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

关于 Future、`async` 和 `await` 的使用介绍，可以参见这个 codelab:
[asynchronous programming codelab](/codelabs/async-await)。

{% comment %}
TODO #1117: Where else should we cover generalized void?
{% endcomment %}


<a id="await-for"></a>
### Handling Streams

### 处理 Stream

When you need to get values from a Stream,
you have two options:

如果想从 Stream 中获取值，可以有两种选择：

* Use `async` and an _asynchronous for loop_ (`await for`).

  使用 `async` 关键字和一个 **异步循环**（使用 `await for` 关键字标识）。

* Use the Stream API, as described
  [in the library tour](/guides/libraries/library-tour#stream).

  使用 Stream API。详情参考 [库概览](/guides/libraries/library-tour#stream)。

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
  // Executes each time the stream emits a value.
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

**如果在实现异步 for 循环时遇到编译时错误，请检查确保 `await for` 处于异步函数中。
** 例如，要在应用程序的 `main()` 函数中使用异步 for 循环，`main()` 函数体必须标记为 `async`：

<?code-excerpt "misc/lib/language_tour/async.dart (number_thinker)" replace="/async|await for/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
void main() [!async!] {
  // ...
  [!await for!] (final request in requestServer) {
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

* **Synchronous** generator: Returns an **[`Iterable`]** object.

  **同步** 生成器：返回一个 **[`Iterable`]** 对象。

* **Asynchronous** generator: Returns a **[`Stream`]** object.

  **异步** 生成器：返回一个 **[`Stream`]** 对象。

To implement a **synchronous** generator function,
mark the function body as `sync*`,
and use `yield` statements to deliver values:

通过在函数上加 `sync*` 关键字并将返回值类型设置为 Iterable 来实现一个 **同步** 生成器函数，
在函数中使用 `yield` 语句来传递值：

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

实现 **异步** 生成器函数与同步类似，
只不过关键字为 `async*` 并且返回值为 Stream：

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

The `call()` method allows any class that defines it to emulate a function.
This method supports the same functionality as normal [functions](#functions)
such as parameters and return types.

所有的类都可以定义并模拟 `call()` 方法，这个方法与普通 [函数](#functions) 是一样的，
支持传参和定义返回类型等。

In the following example, the `WannabeFunction` class defines a `call()` function
that takes three strings and concatenates them, separating each with a space,
and appending an exclamation. Click **Run** to execute the code.

在下面的示例中，`WannabeFunction` 类定义了一个 `call()` 函数，
函数接受三个字符串参数，函数体将三个字符串拼接，字符串间用空格分割，
并在结尾附加了一个感叹号。单击运行按钮执行代码。

<?code-excerpt "misc/lib/language_tour/callable_classes.dart"?>
```dart:run-dartpad:height-350px:ga_id-callable_classes
class WannabeFunction {
  String call(String a, String b, String c) => '$a $b $c!';
}

var wf = WannabeFunction();
var out = wf('Hi', 'there,', 'gang');

void main() => print(out);
```

## Isolates

## 隔离区

Most computers, even on mobile platforms, have multi-core CPUs.
To take advantage of all those cores, developers traditionally use
shared-memory threads running concurrently. However, shared-state
concurrency is error prone and can lead to complicated code.

大多数计算机中，甚至在移动平台上，都在使用多核 CPU。为了有效利用多核性能，开发者一般使用共享内存的方式让线程并发地运行。然而，多线程共享数据通常会导致很多潜在的问题，并导致代码运行出错。

Instead of threads, all Dart code runs inside of *isolates*. 
Each Dart isolate has a single thread of execution and
shares no mutable objects with other isolates.  

为了解决多线程带来的并发问题，Dart 使用 isolate 替代线程，所有的 Dart 代码均运行在一个 **isolate** 中。每一个 isolate 有它自己的堆内存以确保其状态不被其它 isolate 访问。

所有的 Dart 代码都是在一个 isolate 中运行，而非线程。
每个 isolate 都有一个单独的执行线程，并且不与其他的 isolate 共享任何可变对象。

For more information, see the following:

你可以查阅下面的文档获取更多相关信息：
* [Concurrency in Dart](/guides/language/concurrency)
  
  [Dart 中的并发特性](/guides/language/concurrency)

* [dart:isolate API reference,][dart:isolate]
  including [Isolate.spawn()][] and
  [TransferableTypedData][]

  [dart:isolate API 参考][dart:isolate] 介绍了 [Isolate.spawn()][] 和 [TransferableTypedData][] 的用法

* [Background parsing][background json] cookbook on the Flutter site

   Flutter 文档上关于 [后台解析][background json] 的实用教程

* [Isolate sample app][]

[Isolate.spawn()]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-isolate/Isolate/spawn.html
[TransferableTypedData]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-isolate/TransferableTypedData-class.html
[background json]: {{site.flutter-docs}}/cookbook/networking/background-parsing
[Isolate sample app]: https://github.com/flutter/samples/tree/main/isolate_example

## Typedefs

A type alias—often called a _typedef_ because
it's declared with the keyword `typedef`—is
a concise way to refer to a type.
Here's an example of declaring and using a type alias named `IntList`:
  
类型别名是引用某一类型的简便方法，因为其使用关键字 `typedef`，因此通常被称作 **typedef**。下面是一个使用 `IntList` 来声明和使用类型别名的例子:

<?code-excerpt "misc/lib/language_tour/typedefs/misc.dart (int-list)"?>
```dart
typedef IntList = List<int>;
IntList il = [1, 2, 3];
```

A type alias can have type parameters:

类型别名可以有类型参数:

<?code-excerpt "misc/lib/language_tour/typedefs/misc.dart (list-mapper)"?>
```dart
typedef ListMapper<X> = Map<X, List<X>>;
Map<String, List<String>> m1 = {}; // Verbose.
ListMapper<String> m2 = {}; // Same thing but shorter and clearer.
```

{{site.alert.version-note}}
  Before 2.13, typedefs were restricted to function types.
  Using the new typedefs requires a [language version][] of at least 2.13.
{{site.alert.end}}

We recommend using [inline function types][] instead of typedefs for functions,
in most situations.
However, function typedefs can still be useful:

针对函数，在大多数情况下，我们推荐使用 [内联函数类型][inline function types]
替代 typedefs。然而，函数的 typedefs 仍然是有用的:

<?code-excerpt "misc/lib/language_tour/typedefs/misc.dart (compare)"?>
```dart
typedef Compare<T> = int Function(T a, T b);

int sort(int a, int b) => a - b;

void main() {
  assert(sort is Compare<int>); // True!
}
```

[typedef-functions]: /guides/language/effective-dart/design#dont-use-the-legacy-typedef-syntax
[inline function types]: /guides/language/effective-dart/design#prefer-inline-function-types-over-typedefs


## Metadata

## 元数据

Use metadata to give additional information about your code. A metadata
annotation begins with the character `@`, followed by either a reference
to a compile-time constant (such as `deprecated`) or a call to a
constant constructor.

使用元数据可以为代码增加一些额外的信息。元数据注解以 `@` 开头，
其后紧跟一个编译时常量（比如 `deprecated`）或者调用一个常量构造函数。

Three annotations are available to all Dart code: 
`@Deprecated`, `@deprecated`, and `@override`. 
For examples of using `@override`,
see [Extending a class](#extending-a-class).
Here’s an example of using the `@Deprecated` annotation:

Dart 中有两个注解是所有代码都可以使用的：
`@deprecated`、`@Deprecated` 和 `@override`。
你可以查阅 [扩展一个类](#extending-a-class) 获取有关 `@override` 的使用示例。
下面是使用 `@deprecated` 的示例：

<?code-excerpt "misc/lib/language_tour/metadata/television.dart (deprecated)" replace="/@Deprecated.*/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
class Television {
  /// Use [turnOn] to turn the power on instead.
  [!@Deprecated('Use turnOn instead')!]
  void activate() {
    turnOn();
  }

  /// Turns the TV's power on.
  void turnOn() {...}
  // ···
}
{% endprettify %}

You can define your own metadata annotations. Here’s an example of
defining a `@Todo` annotation that takes two arguments:

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

And here’s an example of using that `@Todo` annotation:

使用 @Todo 注解的示例：

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

单行注释以 `//` 开始。所有在 `//` 和该行结尾之间的内容均被编译器忽略。

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

多行注释以 `/*` 开始， 以 `*/` 结尾。所有在 `/*` 和 `*/`
之间的内容均被编译器忽略（不会忽略文档注释），
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

Inside a documentation comment, the analyzer ignores all text
unless it is enclosed in brackets. Using brackets, you can refer to
classes, methods, fields, top-level variables, functions, and
parameters. The names in brackets are resolved in the lexical scope of
the documented program element.

在文档注释中，除非用中括号括起来，否则分析器会忽略所有文本。
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
///
/// Just like any other animal, llamas need to eat,
/// so don't forget to [feed] them some [Food].
class Llama {
  String? name;

  /// Feeds your llama [food].
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

In the class's generated documentation, `[feed]` becomes a link
to the docs for the `feed` method,
and `[Food]` becomes a link to the docs for the `Food` class.

在生成的文档中，`[feed]` 会成为一个链接，指向 `feed` 方法的文档，
`[Food]` 会成为一个链接，指向 `Food` 类的 API 文档。

To parse Dart code and generate HTML documentation, you can use Dart's
documentation generation tool, [`dart doc`](/tools/dart-doc).
For an example of generated documentation, see the 
[Dart API documentation.]({{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}) 
For advice on how to structure your comments, see
[Effective Dart: Documentation.](/guides/language/effective-dart/documentation)

解析 Dart 代码并生成 HTML 文档，
可以使用 Dart 的文档生成工具 [`dart doc`](/tools/dartdoc)。
关于生成文档的示例，请参考
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

[`AssertionError`]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/AssertionError-class.html
[`Characters`]: {{site.pub-api}}/characters/latest/characters/Characters-class.html
[characters API]: {{site.pub-api}}/characters
[characters example]: {{site.pub-pkg}}/characters/example
[characters package]: {{site.pub-pkg}}/characters
[`dart run`]: /tools/dart-run
[dart:html]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-html
[dart:isolate]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-isolate
[dart:math]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-math
[Dart language specification]: /guides/language/spec
[dartdevc]: /tools/dartdevc
[DON’T use const redundantly]: /guides/language/effective-dart/usage#dont-use-const-redundantly
[`double`]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/double-class.html
[`Enum`]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Enum-class.html
[`Error`]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Error-class.html
[`Exception`]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Exception-class.html
[extension methods page]: /guides/language/extension-methods
[Flutter]: {{site.flutter}}
[Flutter debug mode]: {{site.flutter-docs}}/testing/debugging#debug-mode-assertions
[forEach()]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Iterable/forEach.html
[Function API reference]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Function-class.html
[`Future`]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-async/Future-class.html
[grapheme clusters]: https://unicode.org/reports/tr29/#Grapheme_Cluster_Boundaries
[identical()]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/identical.html
[`int`]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/int-class.html
[`Iterable`]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Iterable-class.html
[iteration]: /guides/libraries/library-tour#iteration
[js numbers]: https://stackoverflow.com/questions/2802957/number-of-bits-in-javascript-numbers/2803010#2803010
[language version]: /guides/language/evolution#language-versioning
[late-final-ivar]: /guides/language/effective-dart/design#avoid-public-late-final-fields-without-initializers
[`List`]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/List-class.html
[`Map`]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Map-class.html
[meta]: {{site.pub-pkg}}/meta
[ns]: /null-safety
[ns-enable]: /null-safety#enable-null-safety
[`num`]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/num-class.html
[`Object`]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Object-class.html
[ObjectVsDynamic]: /guides/language/effective-dart/design#avoid-using-dynamic-unless-you-want-to-disable-static-checking
[runes]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Runes-class.html
[`Set`]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Set-class.html
[`StackTrace`]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/StackTrace-class.html
[`Stream`]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-async/Stream-class.html
[`String`]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/String-class.html
[`Symbol`]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Symbol-class.html
[synchronous-async-start]: https://github.com/dart-lang/language/blob/master/archive/newsletter/20170915.md#synchronous-async-start
[top-and-bottom]: /null-safety/understanding-null-safety#top-and-bottom
[trailing commas]: #trailing-comma
[type test operator]: #type-test-operators
[`Type`]: {{site.dart-api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Type-class.html
[Understanding null safety]: /null-safety/understanding-null-safety
