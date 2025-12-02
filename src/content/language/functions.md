---
title: Functions
title: 函数
description: Everything about functions in Dart.
description: Dart 中关于函数的一切。
prevpage:
  url: /language/error-handling
  title: Error handling
  title: 错误处理
nextpage:
  url: /language/metadata
  title: Metadata
  title: 元数据
---

Dart is a true object-oriented language, so even functions are objects
and have a type, [Function.][Function API reference]
This means that functions can be assigned to variables or passed as arguments
to other functions. You can also call an instance of a Dart class as if
it were a function. For details, see [Callable objects][].

Dart 是一门真正的面向对象语言，所以即使函数也是对象，
并且有一个类型 [Function][Function API reference]。
这意味着函数可以被赋值给变量或作为参数传递给其他函数。
你还可以像调用函数一样调用 Dart 类的实例。
有关详细信息，请参阅[可调用对象][Callable objects]。

Here's an example of implementing a function:

以下是实现函数的示例：

<?code-excerpt "misc/lib/language_tour/functions.dart (function)"?>
```dart
bool isNoble(int atomicNumber) {
  return _nobleGases[atomicNumber] != null;
}
```

Although Effective Dart recommends
[type annotations for public APIs][],
the function still works if you omit the types:

虽然 Effective Dart 建议[为公共 API 添加类型注释][type annotations for public APIs]，
但如果省略类型，函数仍然可以工作：

<?code-excerpt "misc/lib/language_tour/functions.dart (function-omitting-types)"?>
```dart
isNoble(atomicNumber) {
  return _nobleGases[atomicNumber] != null;
}
```

For functions that contain just one expression, you can use a shorthand
syntax:

对于只包含一个表达式的函数，可以使用简写语法：

<?code-excerpt "misc/lib/language_tour/functions.dart (function-shorthand)"?>
```dart
bool isNoble(int atomicNumber) => _nobleGases[atomicNumber] != null;
```

The <code>=> <em>expr</em></code> syntax is a shorthand for
<code>{ return <em>expr</em>; }</code>. The `=>` notation
is sometimes referred to as _arrow_ syntax.

<code>=> <em>expr</em></code> 语法是 <code>{ return <em>expr</em>; }</code> 的简写。
`=>` 符号有时被称为_箭头_语法。

:::note
Only _expressions_ can appear between the arrow (`=>`) and the semicolon (`;`).
Expressions evaluate to values.
This means that you can't write a statement where Dart expects a value.
For example,
you could use a [conditional expression][] but not an [if statement][].
In the previous example,
`_nobleGases[atomicNumber] != null;` returns a boolean value.
The function then returns a boolean value
that indicates whether the `atomicNumber` falls into the noble gas range.

在箭头（`=>`）和分号（`;`）之间只能出现_表达式_。
表达式求值为值。
这意味着你不能在 Dart 期望值的地方写语句。
例如，你可以使用[条件表达式][conditional expression]但不能使用 [if 语句][if statement]。
在前面的示例中，`_nobleGases[atomicNumber] != null;` 返回一个布尔值。
然后函数返回一个布尔值，指示 `atomicNumber` 是否属于惰性气体范围。
:::

## Parameters

## 参数

A function can have any number of _required positional_ parameters. These can be
followed either by _named_ parameters or by _optional positional_ parameters
(but not both).

函数可以有任意数量的_必需位置_参数。这些参数后面可以跟_命名_参数
或_可选位置_参数（但不能同时使用两者）。

:::note
Some APIs—notably [Flutter][] widget constructors—use only named
parameters, even for parameters that are mandatory. See the next section for
details.

一些 API——尤其是 [Flutter][] widget 构造函数——只使用命名参数，
即使对于必需的参数也是如此。有关详细信息，请参阅下一节。
:::

You can use [trailing commas][] when you pass arguments to a function
or when you define function parameters.

当你向函数传递参数或定义函数参数时，可以使用[尾随逗号][trailing commas]。

### Named parameters

### 命名参数

Named parameters are optional
unless they're explicitly marked as `required`.

命名参数是可选的，除非它们被明确标记为 `required`。

When defining a function, use
<code>{<em>param1</em>, <em>param2</em>, …}</code>
to specify named parameters.
If you don't provide a default value
or mark a named parameter as `required`,
their types must be nullable
as their default value will be `null`:

定义函数时，使用 <code>{<em>param1</em>, <em>param2</em>, …}</code>
来指定命名参数。如果不提供默认值或将命名参数标记为 `required`，
它们的类型必须是可空的，因为它们的默认值将是 `null`：

<?code-excerpt "misc/lib/language_tour/functions.dart (specify-named-parameters)"?>
```dart
/// Sets the [bold] and [hidden] flags ...
void enableFlags({bool? bold, bool? hidden}) {
  ...
}
```

When calling a function,
you can specify named arguments using
<code><em>paramName</em>: <em>value</em></code>.
For example:

调用函数时，可以使用 <code><em>paramName</em>: <em>value</em></code>
指定命名参数。例如：

<?code-excerpt "misc/lib/language_tour/functions.dart (use-named-parameters)"?>
```dart
enableFlags(bold: true, hidden: false);
```

<a id="default-parameters"></a>
To define a default value for a named parameter besides `null`,
use `=` to specify a default value.
The specified value must be a compile-time constant.
For example:

<a id="default-parameters"></a>
要为命名参数定义除 `null` 之外的默认值，
使用 `=` 指定默认值。指定的值必须是编译时常量。例如：

<?code-excerpt "misc/lib/language_tour/functions.dart (named-parameter-default-values)"?>
```dart
/// Sets the [bold] and [hidden] flags ...
void enableFlags({bool bold = false, bool hidden = false}) {
  ...
}

// bold will be true; hidden will be false.
enableFlags(bold: true);
```

If you instead want a named parameter to be mandatory,
requiring callers to provide a value for the parameter,
annotate them with `required`:

如果你希望命名参数是必需的，要求调用者为参数提供值，
请用 `required` 注释它们：

<?code-excerpt "misc/lib/language_tour/functions.dart (required-named-parameters)" replace="/required/[!$&!]/g"?>
```dart
const Scrollbar({super.key, [!required!] Widget child});
```

If someone tries to create a `Scrollbar`
without specifying the `child` argument,
then the analyzer reports an issue.

如果有人尝试创建一个 `Scrollbar` 而不指定 `child` 参数，
那么分析器会报告一个问题。

:::note
A parameter marked as `required` can still be nullable:

标记为 `required` 的参数仍然可以是可空的：

<?code-excerpt "misc/lib/language_tour/functions.dart (required-named-parameters-nullable)" replace="/Widget\?/[!$&!]/g; /ScrollbarTwo/Scrollbar/g;"?>
```dart
const Scrollbar({super.key, required [!Widget?!] child});
```

:::

You might want to place positional arguments first,
but Dart doesn't require it.
Dart allows named arguments to be placed anywhere in the
argument list when it suits your API:

你可能想把位置参数放在前面，但 Dart 不要求这样做。
Dart 允许在适合你的 API 时将命名参数放在参数列表的任何位置：

<?code-excerpt "misc/lib/language_tour/functions.dart (named-arguments-anywhere)"?>
```dart
repeat(times: 2, () {
  ...
});
```

### Optional positional parameters

### 可选位置参数

Wrapping a set of function parameters in `[]`
marks them as optional positional parameters.
If you don't provide a default value,
their types must be nullable
as their default value will be `null`:

将一组函数参数包装在 `[]` 中可将它们标记为可选位置参数。
如果不提供默认值，它们的类型必须是可空的，因为它们的默认值将是 `null`：

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

Here's an example of calling this function
without the optional parameter:

以下是调用此函数但不带可选参数的示例：

<?code-excerpt "misc/test/language_tour/functions_test.dart (call-without-optional-param)"?>
```dart
assert(say('Bob', 'Howdy') == 'Bob says Howdy');
```

And here's an example of calling this function with the third parameter:

以下是使用第三个参数调用此函数的示例：

<?code-excerpt "misc/test/language_tour/functions_test.dart (call-with-optional-param)"?>
```dart
assert(
  say('Bob', 'Howdy', 'smoke signal') ==
      'Bob says Howdy with a smoke signal',
);
```

To define a default value for an optional positional parameter besides `null`,
use `=` to specify a default value.
The specified value must be a compile-time constant.
For example:

要为可选位置参数定义除 `null` 之外的默认值，
使用 `=` 指定默认值。指定的值必须是编译时常量。例如：

<?code-excerpt "misc/test/language_tour/functions_test.dart (optional-positional-param-default)"?>
```dart
String say(String from, String msg, [String device = 'carrier pigeon']) {
  var result = '$from says $msg with a $device';
  return result;
}

assert(say('Bob', 'Howdy') == 'Bob says Howdy with a carrier pigeon');
```

<a id="the-main-function" aria-hidden="true"></a>

## The main() function {:#main}

## main() 函数 {:#main}

Every app must have a top-level `main()` function, which serves as the
entrypoint to the app. The `main()` function returns `void` and has an
optional `List<String>` parameter for arguments.

每个应用都必须有一个顶级 `main()` 函数，它作为应用的入口点。
`main()` 函数返回 `void`，并有一个可选的 `List<String>` 参数用于接收参数。

Here's a simple `main()` function:

以下是一个简单的 `main()` 函数：

<?code-excerpt "misc/test/samples_test.dart (hello-world)"?>
```dart
void main() {
  print('Hello, World!');
}
```

Here's an example of the `main()` function for a command-line app that
takes arguments:

以下是一个接收参数的命令行应用的 `main()` 函数示例：

<?code-excerpt "misc/test/language_tour/functions_test.dart (main-args)"?>
```dart title="args.dart"
// Run the app like this: dart run args.dart 1 test
void main(List<String> arguments) {
  print(arguments);

  assert(arguments.length == 2);
  assert(int.parse(arguments[0]) == 1);
  assert(arguments[1] == 'test');
}
```

You can use the [args library]({{site.pub-pkg}}/args) to
define and parse command-line arguments.

你可以使用 [args 库]({{site.pub-pkg}}/args)来定义和解析命令行参数。

## Functions as first-class objects

## 函数作为一等对象

You can pass a function as a parameter to another function. For example:

你可以将函数作为参数传递给另一个函数。例如：

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

你也可以将函数赋值给变量，例如：

<?code-excerpt "misc/test/language_tour/functions_test.dart (function-as-var)"?>
```dart
var loudify = (msg) => '!!! ${msg.toUpperCase()} !!!';
assert(loudify('hello') == '!!! HELLO !!!');
```

This example uses an anonymous function.
More about those in the next section.

此示例使用了匿名函数。下一节会有更多关于匿名函数的内容。

## Function types

## 函数类型

You can specify the type of a function, which is known as a _function type_.
A function type is obtained from a function declaration header by
replacing the function name by the keyword `Function`.
Moreover, you are allowed to omit the names of positional parameters, but
the names of named parameters can't be omitted. For example:

你可以指定函数的类型，这被称为_函数类型_。
函数类型是通过将函数声明头中的函数名替换为关键字 `Function` 获得的。
此外，你可以省略位置参数的名称，但命名参数的名称不能省略。例如：

<?code-excerpt "misc/lib/language_tour/functions.dart (function-type)"?>
```dart
void greet(String name, {String greeting = 'Hello'}) =>
    print('$greeting $name!');

// Store `greet` in a variable and call it.
void Function(String, {String greeting}) g = greet;
g('Dash', greeting: 'Howdy');
```

:::note
In Dart, functions are first-class objects,
meaning they can be assigned to variables,
passed as arguments, and returned from other functions.

在 Dart 中，函数是一等对象，这意味着它们可以被赋值给变量、
作为参数传递以及从其他函数返回。

You can use a [`typedef`][] declaration to explicitly name function types,
which can be useful for clarity and reusability.

你可以使用 [`typedef`][] 声明来显式命名函数类型，
这对于代码清晰度和可重用性很有用。
:::

[`typedef`]: /language/typedefs

## Anonymous functions

## 匿名函数

Though you name most functions, such as `main()` or `printElement()`,
you can also create functions without names.
These functions are called _anonymous functions_, _lambdas_, or _closures_.

虽然大多数函数都有名称，如 `main()` 或 `printElement()`，
但你也可以创建没有名称的函数。
这些函数被称为_匿名函数_、_lambda_ 或_闭包_。

An anonymous function resembles a named function as it has:

匿名函数类似于命名函数，因为它具有：

- Zero or more parameters, comma-separated
- Optional type annotations between parentheses.

- 零个或多个参数，以逗号分隔
- 括号之间的可选类型注释

The following code block contains the function's body:

以下代码块包含函数体：

```dart
([[Type] param1[, ...]]) {
  codeBlock;
}
```

The following example defines an anonymous function
with an untyped parameter, `item`.
The anonymous function passes it to the `map` function.
The `map` function, invoked for each item in the list,
converts each string to uppercase.
Then, the anonymous function passed to `forEach`,
prints each converted string with its length.

以下示例定义了一个带有无类型参数 `item` 的匿名函数。
匿名函数将其传递给 `map` 函数。
`map` 函数为列表中的每个项调用，将每个字符串转换为大写。
然后，传递给 `forEach` 的匿名函数打印每个转换后的字符串及其长度。

<?code-excerpt "misc/test/language_tour/functions_test.dart (anonymous-function)"?>
```dart
const list = ['apples', 'bananas', 'oranges'];

var uppercaseList = list.map((item) {
  return item.toUpperCase();
}).toList();
// Convert to list after mapping

for (var item in uppercaseList) {
  print('$item: ${item.length}');
}
```

Click **Run** to execute the code.

点击 **Run** 来执行代码。

<?code-excerpt "misc/test/language_tour/functions_test.dart (anonymous-function-main)"?>
```dartpad
void main() {
  const list = ['apples', 'bananas', 'oranges'];

  var uppercaseList = list.map((item) {
    return item.toUpperCase();
  }).toList();
  // Convert to list after mapping

  for (var item in uppercaseList) {
    print('$item: ${item.length}');
  }
}
```

If the function contains only a single expression or return statement,
you can shorten it using arrow notation.
Paste the following line into DartPad and click **Run**
to verify that it is functionally equivalent.

如果函数只包含单个表达式或返回语句，
可以使用箭头符号缩短它。
将以下代码粘贴到 DartPad 中并点击 **Run**，
以验证它在功能上是等价的。

<?code-excerpt "misc/test/language_tour/functions_test.dart (anon-func)"?>
```dart
var uppercaseList = list.map((item) => item.toUpperCase()).toList();
uppercaseList.forEach((item) => print('$item: ${item.length}'));
```

## Lexical scope

## 词法作用域

Dart determines the scope of variables based on the layout of its code.
A programming language with this feature is termed a lexically scoped language.
You can "follow the curly braces outwards" to see if a variable is in scope.

Dart 根据代码的布局确定变量的作用域。
具有此特性的编程语言被称为词法作用域语言。
你可以"向外追踪大括号"来查看变量是否在作用域内。

**Example:** A series of nested functions with variables at each scope level:

**示例：** 一系列嵌套函数，每个作用域级别都有变量：

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

The `nestedFunction()` method can use variables from every level,
all the way up to the top level.

`nestedFunction()` 方法可以使用从每个级别一直到顶级的变量。

## Lexical closures

## 词法闭包

A function object that can access variables in its lexical scope
when the function sits outside that scope is called a _closure_.

当函数位于其词法作用域之外时，仍能访问该作用域中变量的函数对象被称为_闭包_。

Functions can close over variables defined in surrounding scopes. In the
following example, `makeAdder()` captures the variable `addBy`. Wherever the
returned function goes, it remembers `addBy`.

函数可以封闭在周围作用域中定义的变量。在以下示例中，`makeAdder()`
捕获了变量 `addBy`。无论返回的函数被传递到哪里，它都会记住 `addBy`。

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

## Tear-offs

## 函数分离

When you refer to a function, method, or named constructor without parentheses,
Dart creates a _tear-off_. This is a closure that takes the same
parameters as the function and invokes the underlying function when you call it.
If your code needs a closure that invokes a named function with the same
parameters as the closure accepts, don't wrap the call in a lambda.
Use a tear-off.

当你引用一个函数、方法或命名构造函数但不加括号时，Dart 会创建一个_函数分离（tear-off）_。
这是一个闭包，它接受与函数相同的参数，并在调用时调用底层函数。
如果你的代码需要一个闭包来调用一个命名函数，且该闭包接受与函数相同的参数，
那么不要将调用包装在 lambda 中，请使用函数分离。

<?code-excerpt "misc/lib/language_tour/tear_offs.dart (variables)" ?>
```dart
var charCodes = [68, 97, 114, 116];
var buffer = StringBuffer();
```

<?code-excerpt "misc/lib/language_tour/tear_offs.dart (good-example)" ?>
```dart tag=good
// Function tear-off
charCodes.forEach(print);

// Method tear-off
charCodes.forEach(buffer.write);
```

<?code-excerpt "misc/lib/language_tour/tear_offs.dart (bad-example)" ?>
```dart tag=bad
// Function lambda
charCodes.forEach((code) {
  print(code);
});

// Method lambda
charCodes.forEach((code) {
  buffer.write(code);
});
```

## Testing functions for equality

## 测试函数相等性

Here's an example of testing top-level functions, static methods, and
instance methods for equality:

以下是测试顶级函数、静态方法和实例方法相等性的示例：

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

## Return values

## 返回值

All functions return a value. If no return value is specified, the
statement `return null;` is implicitly appended to the function body.

所有函数都返回一个值。如果没有指定返回值，则语句 `return null;`
会被隐式附加到函数体中。

<?code-excerpt "misc/test/language_tour/functions_test.dart (implicit-return-null)"?>
```dart
foo() {}

assert(foo() == null);
```

To return multiple values in a function, aggregate the values in a [record][].

要在函数中返回多个值，请将这些值聚合到一个[记录][record]中。

```dart
(String, int) foo() {
  return ('something', 42);
}
```

[record]: /language/records#multiple-returns

## Getters and setters

## Getter 和 setter

Every property access (top-level, static, or instance) is an invocation
of a getter or a setter. A variable implicitly creates a getter
and, if it's mutable, a setter. This is why when you access a property,
you're actually calling a small function in the background. Reading a
property calls a getter function, and writing one calls a setter function,
even in cases where the property is declared a variable.

每次属性访问（顶级、静态或实例）都是对 getter 或 setter 的调用。
变量隐式创建一个 getter，如果它是可变的，还会创建一个 setter。
这就是为什么当你访问一个属性时，实际上是在后台调用一个小函数。
读取属性会调用 getter 函数，写入属性会调用 setter 函数，
即使在属性被声明为变量的情况下也是如此。

However, you can also declare getters and setters explicitly with
the `get` and `set` keywords respectively.
This allows a property's value to be computed when it's read or written.

但是，你也可以分别使用 `get` 和 `set` 关键字显式声明 getter 和 setter。
这允许在读取或写入属性时计算属性的值。

The purpose of using getters and setters is to create a clear
separation between the client (the code that uses the property) and
the provider (the class or library that defines it). The client asks for or
sets a value without needing to know if that value is stored in a
simple variable or calculated on the spot. This gives the provider
the freedom to change how the property works.

使用 getter 和 setter 的目的是在客户端（使用属性的代码）和
提供者（定义属性的类或库）之间创建清晰的分离。
客户端请求或设置值时不需要知道该值是存储在简单变量中还是即时计算的。
这给了提供者改变属性工作方式的自由。

For example, because the value of the property might not be stored anywhere,
it could be computed each time the getter is called. Another example
is that when a value is stored in a private variable, and public access
is only allowed by calling a getter or a setter.

例如，由于属性的值可能不存储在任何地方，
它可以在每次调用 getter 时进行计算。
另一个例子是当值存储在私有变量中，而公共访问只允许通过调用 getter 或 setter。

The following example showcases this,
with the `secret` getter and setter providing
indirect access to the private variable `_secret` with
its own manipulations on the assigned and retrieved values.

以下示例展示了这一点，`secret` getter 和 setter 提供
对私有变量 `_secret` 的间接访问，
并对赋值和检索的值进行自己的操作。

<?code-excerpt "language/lib/functions/getters_setters.dart"?>
```dart highlightLines=3,7-10,14-20,24,33
// Defines a variable `_secret` that is private to the library since
// its identifier starts with an underscore (`_`).
String _secret = 'Hello';

// A public top-level getter that
// provides read access to [_secret].
String get secret {
  print('Getter was used!');
  return _secret.toUpperCase();
}

// A public top-level setter that
// provides write access to [_secret].
set secret(String newMessage) {
  print('Setter was used!');
  if (newMessage.isNotEmpty) {
    _secret = newMessage;
    print('New secret: "$newMessage"');
  }
}

void main() {
  // Reading the value calls the getter.
  print('Current message: $secret');

  /*
  Output:
  Getter was used!
  Current message: HELLO
  */

  // Assigning a value calls the setter.
  secret = 'Dart is fun';

  // Reading it again calls the getter to show the new computed value
  print('New message: $secret');

  /*
  Output:
  Setter was used! New secret: "Dart is fun"
  Getter was used!
  New message: DART IS FUN
  */
}
```

## Generators

## 生成器

When you need to lazily produce a sequence of values,
consider using a _generator function_.
Dart has built-in support for two kinds of generator functions:

当你需要延迟生成一系列值时，考虑使用_生成器函数_。
Dart 内置支持两种生成器函数：

- **Synchronous** generator: Returns an [`Iterable`] object.
- **Asynchronous** generator: Returns a [`Stream`] object.

- **同步**生成器：返回一个 [`Iterable`] 对象。
- **异步**生成器：返回一个 [`Stream`] 对象。

To implement a **synchronous** generator function,
mark the function body as `sync*`,
and use `yield` statements to deliver values:

要实现**同步**生成器函数，将函数体标记为 `sync*`，
并使用 `yield` 语句传递值：

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

要实现**异步**生成器函数，将函数体标记为 `async*`，
并使用 `yield` 语句传递值：

<?code-excerpt "misc/test/language_tour/async_test.dart (async-generator)"?>
```dart
Stream<int> asynchronousNaturalsTo(int n) async* {
  int k = 0;
  while (k < n) yield k++;
}
```

If your generator is recursive,
you can improve its performance by using `yield*`:

如果你的生成器是递归的，可以使用 `yield*` 来提高其性能：

<?code-excerpt "misc/test/language_tour/async_test.dart (recursive-generator)"?>
```dart
Iterable<int> naturalsDownFrom(int n) sync* {
  if (n > 0) {
    yield n;
    yield* naturalsDownFrom(n - 1);
  }
}
```

[`Iterable`]: {{site.dart-api}}/dart-core/Iterable-class.html
[`Stream`]: {{site.dart-api}}/dart-async/Stream-class.html

## External functions {:#external}

## 外部函数 {:#external}

An external function is a function whose body is implemented separately from its
declaration. Include the `external` keyword before a function declaration, like so:

外部函数是指函数体与其声明分开实现的函数。
在函数声明前包含 `external` 关键字，如下所示：

```dart
external void someFunc(int i);
```

An external function's implementation can come from another Dart library,
or, more commonly, from another language. In interop contexts, `external`
introduces type information for foreign functions or values,
making them usable in Dart. Implementation and usage is
heavily platform specific, so check out the interop docs on, for example,
[C][] or [JavaScript][] to learn more.

外部函数的实现可以来自另一个 Dart 库，或者更常见的是来自另一种语言。
在互操作上下文中，`external` 为外部函数或值引入类型信息，
使它们在 Dart 中可用。实现和使用在很大程度上取决于平台，
因此请查看互操作文档，例如 [C][] 或 [JavaScript][] 以了解更多信息。

External functions can be top-level functions, [instance methods][],
getters or setters, or [non-redirecting constructors][].
An [instance variable][] can be `external` too,
which is equivalent to an external getter and (if the variable
is not `final`) an external setter.

外部函数可以是顶级函数、[实例方法][instance methods]、
getter 或 setter，或[非重定向构造函数][non-redirecting constructors]。
[实例变量][instance variable]也可以是 `external` 的，
这相当于一个外部 getter 和（如果变量不是 `final`）一个外部 setter。

[instance methods]: /language/methods#instance-methods
[non-redirecting constructors]: /language/constructors#redirecting-constructors
[instance variable]: /language/classes#instance-variables
[C]: /interop/c-interop
[JavaScript]: /interop/js-interop
[Function API reference]: {{site.dart-api}}/dart-core/Function-class.html
[Callable objects]: /language/callable-objects
[type annotations for public APIs]: /effective-dart/design#do-type-annotate-fields-and-top-level-variables-if-the-type-isnt-obvious
[if statement]: /language/branches#if
[conditional expression]: /language/operators#conditional-expressions
[Flutter]: {{site.flutter}}
[trailing commas]: /language/collections#lists


