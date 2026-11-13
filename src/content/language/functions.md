---
# title: Functions
title: 函数
# description: Everything about functions in Dart.
description: "关于 Dart 中函数的一切。"
ai-translated: true
prevpage:
  url: /language/error-handling
# title: Error handling
  title: 错误处理
nextpage:
  url: /language/metadata
# title: Metadata
  title: 注解
---

Dart is a true object-oriented language, so even functions are objects
and have a type, [Function.][Function API reference]
This means that functions can be assigned to variables or passed as arguments
to other functions. You can also call an instance of a Dart class as if
it were a function. For details, see [Callable objects][].

Dart 是真正的面向对象语言，
所以连函数也是对象，
并且拥有一个类型：[Function][Function API reference]。
这意味着函数可以赋值给变量，
也可以作为参数传给其他函数。
你还可以像调用函数一样调用 Dart 类的实例。
详情请参阅 [可调用对象][Callable objects]。

Here's an example of implementing a function:

下面是实现一个函数的例子：

<?code-excerpt "misc/lib/language_tour/functions.dart (function)"?>
```dart
bool isNoble(int atomicNumber) {
  return _nobleGases[atomicNumber] != null;
}
```

Although Effective Dart recommends
[type annotations for public APIs][],
the function still works if you omit the types:

虽然 Effective Dart 建议
[为公共 API 添加类型注解][type annotations for public APIs]，
但省略类型后函数仍然可以工作：

<?code-excerpt "misc/lib/language_tour/functions.dart (function-omitting-types)"?>
```dart
isNoble(atomicNumber) {
  return _nobleGases[atomicNumber] != null;
}
```

For functions that contain just one expression, you can use a shorthand
syntax:

对于只包含一个表达式的函数，
可以使用简写语法：

<?code-excerpt "misc/lib/language_tour/functions.dart (function-shorthand)"?>
```dart
bool isNoble(int atomicNumber) => _nobleGases[atomicNumber] != null;
```

The <code>=> <em>expr</em></code> syntax is a shorthand for
<code>{ return <em>expr</em>; }</code>. The `=>` notation
is sometimes referred to as _arrow_ syntax.

<code>=> <em>expr</em></code> 语法是
<code>{ return <em>expr</em>; }</code> 的简写。
`=>` 记法有时被称为 _箭头_ 语法。

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

只有 _表达式_ 能出现在箭头（`=>`）和分号（`;`）之间。
表达式会求值为一个值。
这意味着在 Dart 期望值的地方不能写语句。
例如，你可以使用 [条件表达式][conditional expression]，
但不能使用 [if 语句][if statement]。
在前面的例子中，
`_nobleGases[atomicNumber] != null;` 返回一个布尔值，
函数随后返回这个布尔值，
表示 `atomicNumber` 是否落在稀有气体的范围内。
:::

## Parameters

## 参数

A function can have any number of _required positional_ parameters. These can be
followed either by _named_ parameters or by _optional positional_ parameters
(but not both).

函数可以有任意数量的 _必需位置_ 参数，
后面可以跟 _命名_ 参数或 _可选位置_ 参数
（但不能两者同时使用）。

:::note
Some APIs—notably [Flutter][] widget constructors—use only named
parameters, even for parameters that are mandatory. See the next section for
details.

有些 API（尤其是 [Flutter][] 的 widget 构造函数）
只使用命名参数，即使是必需的参数也是如此。
详情请参阅下一节。
:::

You can use [trailing commas][] when you pass arguments to a function
or when you define function parameters.

向函数传递实参或定义函数形参时，
都可以使用 [尾随逗号][trailing commas]。

### Named parameters

### 命名参数

Named parameters are optional
unless they're explicitly marked as `required`.

命名参数是可选的，
除非它们被显式标记为 `required`。

When defining a function, use
<code>{<em>param1</em>, <em>param2</em>, …}</code>
to specify named parameters.
If you don't provide a default value
or mark a named parameter as `required`,
their types must be nullable
as their default value will be `null`:

定义函数时，使用
<code>{<em>param1</em>, <em>param2</em>, …}</code>
来指定命名参数。
如果不提供默认值，
也不把命名参数标记为 `required`，
它们的类型必须是可空的，
因为其默认值将是 `null`：

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

调用函数时，可以用
<code><em>paramName</em>: <em>value</em></code>
的形式指定命名实参。
例如：

<?code-excerpt "misc/lib/language_tour/functions.dart (use-named-parameters)"?>
```dart
enableFlags(bold: true, hidden: false);
```

<a id="default-parameters"></a>
To define a default value for a named parameter besides `null`,
use `=` to specify a default value.
The specified value must be a compile-time constant.
For example:

要为命名参数定义 `null` 以外的默认值，
请使用 `=` 指定默认值。
指定的值必须是编译时常量。
例如：

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

如果你希望命名参数是必需的，
要求调用者必须为该参数提供值，
请用 `required` 标注它们：

<?code-excerpt "misc/lib/language_tour/functions.dart (required-named-parameters)" replace="/required/[!$&!]/g"?>
```dart
const Scrollbar({super.key, [!required!] Widget child});
```

If someone tries to create a `Scrollbar`
without specifying the `child` argument,
then the analyzer reports an issue.

如果有人试图创建 `Scrollbar`
却不指定 `child` 实参，
分析器就会报告一个问题。

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

你可能想把位置实参放在前面，
但 Dart 并不强制要求。
只要适合你的 API，Dart 允许把命名实参
放在实参列表的任何位置：

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

把一组函数参数用 `[]` 包起来，
就把它们标记为可选位置参数。
如果不提供默认值，
它们的类型必须是可空的，
因为其默认值将是 `null`：

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

下面是不带可选参数调用该函数的例子：

<?code-excerpt "misc/test/language_tour/functions_test.dart (call-without-optional-param)"?>
```dart
assert(say('Bob', 'Howdy') == 'Bob says Howdy');
```

And here's an example of calling this function with the third parameter:

下面是带第三个参数调用该函数的例子：

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

要为可选位置参数定义 `null` 以外的默认值，
请使用 `=` 指定默认值。
指定的值必须是编译时常量。
例如：

<?code-excerpt "misc/test/language_tour/functions_test.dart (optional-positional-param-default)"?>
```dart
String say(String from, String msg, [String device = 'carrier pigeon']) {
  var result = '$from says $msg with a $device';
  return result;
}

assert(say('Bob', 'Howdy') == 'Bob says Howdy with a carrier pigeon');
```

<a id="the-main-function" aria-hidden="true"></a>

### Parameter modifiers

### 参数修饰符

The `final` and `var` parameter modifiers are reserved exclusively for
[primary constructors][] to declare instance fields.
Using them on formal parameters in any other declaration produces
a compile-time error (`extraneous_modifier`).
For code examples and migration steps, see
[Parameter modifier restrictions][].

`final` 和 `var` 参数修饰符专门保留给
[主构造函数][primary constructors] 用于声明实例字段。
在任何其他声明的形参上使用它们，
都会产生编译时错误（`extraneous_modifier`）。
代码示例和迁移步骤请参阅
[参数修饰符限制][Parameter modifier restrictions]。

To enforce non-reassignable parameters as a style choice,
use the [`parameter_assignments`][] lint rule instead.

如果想把「参数不可重新赋值」作为风格约束来强制执行，
请改用 [`parameter_assignments`][] lint 规则。

## The main() function {:#main}

## main() 函数

Every app must have a top-level `main()` function, which serves as the
entrypoint to the app. The `main()` function returns `void` and has an
optional `List<String>` parameter for arguments.

每个应用都必须有一个顶层 `main()` 函数，
作为应用的入口。
`main()` 函数返回 `void`，
并有一个可选的 `List<String>` 参数用于接收实参。

Here's a simple `main()` function:

下面是一个简单的 `main()` 函数：

<?code-excerpt "misc/test/samples_test.dart (hello-world)"?>
```dart
void main() {
  print('Hello, World!');
}
```

Here's an example of the `main()` function for a command-line app that
takes arguments:

下面是接收实参的命令行应用的 `main()` 函数示例：

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

你可以使用 [args 库]({{site.pub-pkg}}/args)
来定义和解析命令行实参。

## Functions as first-class objects

## 函数作为一等对象

You can pass a function as a parameter to another function. For example:

可以把函数作为参数传给另一个函数。例如：

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

也可以把函数赋值给变量，例如：

<?code-excerpt "misc/test/language_tour/functions_test.dart (function-as-var)"?>
```dart
var loudify = (msg) => '!!! ${msg.toUpperCase()} !!!';
assert(loudify('hello') == '!!! HELLO !!!');
```

This example uses an anonymous function.
More about those in the next section.

这个例子使用了匿名函数。
下一节会详细介绍。

## Function types

## 函数类型

You can specify the type of a function, which is known as a _function type_.
A function type is obtained from a function declaration header by
replacing the function name by the keyword `Function`.
Moreover, you are allowed to omit the names of positional parameters, but
the names of named parameters can't be omitted. For example:

你可以指定函数的类型，称为 _函数类型_。
把函数声明头部的函数名替换为关键字 `Function`，
就得到了函数类型。
此外，位置参数的名称可以省略，
但命名参数的名称不能省略。例如：

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

You can use a [`typedef`][] declaration to explicitly name function types,
which can be useful for clarity and reusability.

在 Dart 中，函数是一等对象，
意味着它们可以赋值给变量、
作为实参传递，以及从其他函数返回。

你可以用 [`typedef`][] 声明为函数类型显式命名，
这有助于提高清晰度和可复用性。
:::

[`typedef`]: /language/typedefs

## Anonymous functions

## 匿名函数

Though you name most functions, such as `main()` or `printElement()`,
you can also create functions without names.
These functions are called _anonymous functions_, _lambdas_, or _closures_.

虽然大多数函数都有名字，例如 `main()` 或 `printElement()`，
但你也可以创建没有名字的函数。
这些函数称为 _匿名函数_、_lambda_ 或 _闭包_。

An anonymous function resembles a named function as it has:

匿名函数与命名函数类似，它有：

- Zero or more parameters, comma-separated

  零个或多个参数，用逗号分隔。
- Optional type annotations between parentheses.

  圆括号之间可选的类型注解。

The following code block contains the function's body:

下面的代码块包含函数体：

```dart
([[Type] param1[, ...]]) {
  codeBlock;
}
```

The following example passes an anonymous function
with an untyped parameter, `item`,
to the `map` function.
The `map` function, invoked for each item in the list,
converts each string to uppercase.
Then, a `for-in` loop prints each converted string with its length.

下面的例子把一个带无类型参数 `item` 的匿名函数
传给 `map` 函数。
`map` 函数对列表中的每个元素调用，
把每个字符串转换为大写。
然后，`for-in` 循环打印每个转换后的字符串及其长度。

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

点击 **Run** 执行代码。

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

如果函数只包含单个表达式或 return 语句，
可以用箭头记法简化它。
把下面这行粘贴到 DartPad 并点击 **Run**，
验证它在功能上是等价的。

<?code-excerpt "misc/test/language_tour/functions_test.dart (anon-func)"?>
```dart
var uppercaseList = list.map((item) => item.toUpperCase()).toList();
```

## Lexical scope

## 词法作用域

Dart determines the scope of variables based on the layout of its code.
A programming language with this feature is termed a lexically scoped language.
You can "follow the curly braces outwards" to see if a variable is in scope.

Dart 根据代码的布局来确定变量的作用域。
具有这一特性的编程语言称为词法作用域语言。
你可以「沿着花括号向外找」，
来判断一个变量是否在作用域内。

**Example:** A series of nested functions with variables at each scope level:

**示例：** 一系列嵌套函数，每个作用域层级都有变量：

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

`nestedFunction()` 方法可以使用每一层的变量，
一直到顶层。

## Lexical closures

## 词法闭包

A function object that can access variables in its lexical scope
when the function sits outside that scope is called a _closure_.

当函数位于其词法作用域之外，
却仍能访问该作用域中的变量时，
这样的函数对象称为 _闭包_。

Functions can close over variables defined in surrounding scopes. In the
following example, `makeAdder()` captures the variable `addBy`. Wherever the
returned function goes, it remembers `addBy`.

函数可以「捕获」周围作用域中定义的变量。
在下面的例子中，`makeAdder()` 捕获了变量 `addBy`。
无论返回的函数到哪里，它都记得 `addBy`。

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

## Tear-off

When you refer to a function, method, or named constructor without parentheses,
Dart creates a _tear-off_. This is a closure that takes the same
parameters as the function and invokes the underlying function when you call it.
If your code needs a closure that invokes a named function with the same
parameters as the closure accepts, don't wrap the call in a lambda.
Use a tear-off.

当你不带圆括号地引用函数、方法或命名构造函数时，
Dart 会创建一个 _tear-off_。
它是一个闭包，接受与函数相同的参数，
并在你调用它时调用底层函数。
如果你的代码需要一个闭包，
用与闭包相同的参数调用一个命名函数，
不要把调用包在 lambda 里，
直接使用 tear-off。

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

## 测试函数的相等性

Here's an example of testing top-level functions, static methods, and
instance methods for equality:

下面是测试顶层函数、静态方法和实例方法相等性的例子：

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

所有函数都会返回一个值。
如果没有指定返回值，
函数体会被隐式追加 `return null;` 语句。

<?code-excerpt "misc/test/language_tour/functions_test.dart (implicit-return-null)"?>
```dart
foo() {}

assert(foo() == null);
```

To return multiple values in a function, aggregate the values in a [record][].

要在函数中返回多个值，
请把这些值聚合到一个 [记录][record] 中。

```dart
(String, int) foo() {
  return ('something', 42);
}
```

[record]: /language/records#multiple-returns

## Getters and setters

## Getter 与 setter

Every property access (top-level, static, or instance) is an invocation
of a getter or a setter. A variable implicitly creates a getter
and, if it's mutable, a setter. This is why when you access a property,
you're actually calling a small function in the background. Reading a
property calls a getter function, and writing one calls a setter function,
even in cases where the property is declared a variable.

每次属性访问（顶层、静态或实例）
都是对 getter 或 setter 的调用。
变量会隐式创建一个 getter，
如果它是可变的，还会创建一个 setter。
这就是为什么访问属性时，
实际上是在后台调用一个小函数。
读取属性会调用 getter 函数，
写入属性会调用 setter 函数，
即使该属性被声明为变量也是如此。

However, you can also declare getters and setters explicitly with
the `get` and `set` keywords respectively.
This allows a property's value to be computed when it's read or written.

不过，你也可以分别用 `get` 和 `set` 关键字
显式声明 getter 和 setter。
这样属性的值就可以在读取或写入时计算得出。

The purpose of using getters and setters is to create a clear
separation between the client (the code that uses the property) and
the provider (the class or library that defines it). The client asks for or
sets a value without needing to know if that value is stored in a
simple variable or calculated on the spot. This gives the provider
the freedom to change how the property works.

使用 getter 和 setter 的目的，
是在客户端（使用属性的代码）和
提供方（定义属性的类或库）之间建立清晰的分离。
客户端请求或设置值时，
不必知道这个值是存储在简单变量中，
还是当场计算出来的。
这让提供方可以自由改变属性的工作方式。

For example, because the value of the property might not be stored anywhere,
it could be computed each time the getter is called. Another example
is that when a value is stored in a private variable, and public access
is only allowed by calling a getter or a setter.

例如，属性的值可能根本没有存储在任何地方，
而是每次调用 getter 时计算得出。
另一个例子是：值存储在私有变量中，
只允许通过调用 getter 或 setter 来公开访问。

The following example showcases this,
with the `secret` getter and setter providing
indirect access to the private variable `_secret` with
its own manipulations on the assigned and retrieved values.

下面的例子展示了这一点：
`secret` getter 和 setter 提供了
对私有变量 `_secret` 的间接访问，
并对赋值和取值做自己的处理。

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

当你需要惰性地产生一系列值时，
可以考虑使用 _生成器函数_。
Dart 内置支持两种生成器函数：

- **Synchronous** generator: Returns an [`Iterable`] object.

  **同步** 生成器：返回一个 [`Iterable`] 对象。
- **Asynchronous** generator: Returns a [`Stream`] object.

  **异步** 生成器：返回一个 [`Stream`] 对象。

To implement a **synchronous** generator function,
mark the function body as `sync*`,
and use `yield` statements to deliver values:

要实现 **同步** 生成器函数，
把函数体标记为 `sync*`，
并使用 `yield` 语句逐个交付值：

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

要实现 **异步** 生成器函数，
把函数体标记为 `async*`，
并使用 `yield` 语句逐个交付值：

<?code-excerpt "misc/test/language_tour/async_test.dart (async-generator)"?>
```dart
Stream<int> asynchronousNaturalsTo(int n) async* {
  int k = 0;
  while (k < n) yield k++;
}
```

If your generator is recursive,
you can improve its performance by using `yield*`:

如果你的生成器是递归的，
可以使用 `yield*` 来提升性能：

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

## 外部函数

An external function is a function whose body is implemented separately from its
declaration. Include the `external` keyword before a function declaration, like so:

外部函数是函数体与声明分开实现的函数。
在函数声明前加上 `external` 关键字即可，如下所示：

```dart
external void someFunc(int i);
```

An external function's implementation can come from another Dart library,
or, more commonly, from another language. In interop contexts, `external`
introduces type information for foreign functions or values,
making them usable in Dart. Implementation and usage is
heavily platform specific, so check out the interop docs on, for example,
[C][] or [JavaScript][] to learn more.

外部函数的实现可以来自另一个 Dart 库，
更常见的是来自另一种语言。
在互操作场景中，`external`
为外部函数或值引入类型信息，
使它们可以在 Dart 中使用。
实现和用法高度依赖平台，
请参阅互操作文档（例如 [C][] 或 [JavaScript][]）了解更多。

External functions can be top-level functions, [instance methods][],
getters or setters, or [non-redirecting constructors][].
An [instance variable][] can be `external` too,
which is equivalent to an external getter and (if the variable
is not `final`) an external setter.

外部函数可以是顶层函数、[实例方法][instance methods]、
getter 或 setter，或 [非重定向构造函数][non-redirecting constructors]。
[实例变量][instance variable] 也可以是 `external` 的，
这等价于一个外部 getter，
以及（如果变量不是 `final`）一个外部 setter。

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
[primary constructors]: /language/primary-constructors
[`parameter_assignments`]: /tools/linter-rules/parameter_assignments
[Parameter modifier restrictions]: /language/primary-constructors#parameter-modifier-restrictions


