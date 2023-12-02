---
title: Variables
title: 变量
description: Learn about variables in Dart.
description: 了解 Dart 中的变量。
prevpage:
  url: /language
  title: Basics
nextpage:
  url: /language/operators
  title: Operators
---

<?code-excerpt replace="/ *\/\/\s+ignore_for_file:[^\n]+\n//g; /(^|\n) *\/\/\s+ignore:[^\n]+\n/$1/g; /(\n[^\n]+) *\/\/\s+ignore:[^\n]+\n/$1\n/g; / *\/\/\s+ignore:[^\n]+//g; /([A-Z]\w*)\d\b/$1/g"?>

Here's an example of creating a variable and initializing it:

下面是一个创建并初始化变量的例子：

<?code-excerpt "misc/lib/language_tour/variables.dart (var-decl)"?>
```dart
var name = 'Bob';
```

Variables store references. The variable called `name` contains a
reference to a `String` object with a value of "Bob".

变量会保存引用。`name` 变量包含一个值为 "Bob" 的 `String` 对象的引用。

The type of the `name` variable is inferred to be `String`,
but you can change that type by specifying it.
If an object isn't restricted to a single type,
specify the `Object` type (or `dynamic` if necessary).

变量 `name` 的类型被推断为 `String`，但你可以通过指定类型来更改它。
如果一个对象不受限于单一类型，可以指定为 `Object` 类型（或在必要时使用 `dynamic`）。

<?code-excerpt "misc/lib/language_tour/variables.dart (type-decl)"?>
```dart
Object name = 'Bob';
```

Another option is to explicitly declare the type that would be inferred:

另一种选择是显式声明将要被推断的类型：

<?code-excerpt "misc/lib/language_tour/variables.dart (static-types)"?>
```dart
String name = 'Bob';
```

{{site.alert.note}}

  This page follows the
  [style guide recommendation](/effective-dart/design#types)
  of using `var`, rather than type annotations, for local variables.

  文章遵循 [代码风格指南][style guide recommendation](/effective-dart/design#types) ，
  使用的是 `var` 声明局部变量，而不是使用准确的类型。

{{site.alert.end}}

## Null safety

## 空安全

The Dart language enforces sound null safety.

Dart 语言要求以健全的空安全方式编写代码。

Null safety prevents an error that results from unintentional access
of variables set to `null`. The error is called a null dereference error.
A null dereference error occurs when you access a property or call a method
on an expression that evaluates to `null`.
An exception to this rule is when `null` supports the property or method,
like `toString()` or `hashCode`. With null safety, the Dart compiler
detects these potential errors at compile time.

空安全能够防止意外访问 `null` 的变量而导致的错误。
这样的错误也被称为空解引用错误。
访问一个求值为 `null` 的表达式的属性或调用方法时，会发生空解引用错误。
但是对于 `toString()` 方法和 `hashCode` 属性，空安全会体现出例外情况。
Dart 编译器可以在空安全的基础上在编译期检测到这些潜在的错误。

For example, say you want to find the absolute value of an `int` variable `i`.
If `i` is `null`, calling `i.abs()` causes a null dereference error.
In other languages, trying this could lead to a runtime error,
but Dart's compiler prohibits these actions.
Therefore, Dart apps can't cause runtime errors.

例如，假设你想要查找 `int` 变量 `i` 的绝对值。
如果 `i` 是 `null` ，调用 `i.abs()` 会导致空解引用错误。
在其他语言中，尝试这样做可能会导致运行时错误，但是 Dart 的编译器禁止这些操作。
所以 Dart 应用程序不会引发运行时错误。

Null safety introduces three key changes:

空安全引入了三个关键更改：

1.  When you specify a type for a variable, parameter, or another
    relevant component, you can control whether the type allows `null`.
    To enable nullability, you add a `?` to the end of the type declaration.

    当你为变量、参数或另一个相关组件指定类型时，可以控制该类型是否允许 `null` 。
    要让一个变量可以为空，你可以在类型声明的末尾添加 `?` 。

    ```dart
    String? name  // Nullable type. Can be `null` or string.

    String name   // Non-nullable type. Cannot be `null` but can be string.
    ```

2.  You must initialize variables before using them.
    Nullable variables default to `null`, so they are initialized by default.
    Dart doesn't set initial values to non-nullable types.
    It forces you to set an initial value.
    Dart doesn't allow you to observe an uninitialized variable.
    This prevents you from accessing properties or calling methods
    where the receiver's type can be `null`
    but `null` doesn't support the method or property used.

    你必须在使用变量之前对其进行初始化。
    可空变量是默认初始化为 `null` 的。
    Dart 不会为非可空类型设置初始值，它强制要求你设置初始值。
    Dart 不允许你观察未初始化的变量。
    这可以防止你在接收者类型可以为 `null` 但 `null`
    不支持的相关方法或属性的情况下使用它。

3.  You can't access properties or call methods on an expression with a
    nullable type. The same exception applies where it's a property or method that `null` supports like `hashCode` or `toString()`.

   你不能在可空类型的表达式上访问属性或调用方法。
   同样的例外情况适用于 `null` 支持的属性或方法，例如 `hashCode` 或 `toString()` 。

Sound null safety changes potential **runtime errors**
into **edit-time** analysis errors.
Null safety flags a non-null variable when it has been either:

空安全将潜在的 **运行时错误** 转变为 **编辑时** 分析错误。当非空变量已经是以下情况之一时，空安全标记为非空变量：

* Not initialized with a non-null value.

  使用非空值不初始化。

* Assigned a `null` value.

  赋值为 `null` 值。

This check allows you to fix these errors _before_ deploying your app.

此检查允许你在部署应用程序 **之前** 修复这些错误。

## Default value

## 默认值

Uninitialized variables that have a nullable type
have an initial value of `null`.
Even variables with numeric types are initially null,
because numbers—like everything else in Dart—are objects.

具有可空类型的未初始化变量的初始值为 `null` 。
即使是具有数值类型的变量，初始值也为空，
因为数字（就像 Dart 中的其他所有东西一样）都是对象。

<?code-excerpt "misc/test/language_tour/variables_test.dart (var-null-init)"?>
```dart
int? lineCount;
assert(lineCount == null);
```

{{site.alert.note}}

  Production code ignores the `assert()` call. During development, on the other
  hand, <code>assert(<em>condition</em>)</code> throws an exception if
  _condition_ is false. For details, check out [Assert][].

  当你在生产环境中运行代码时，`assert()` 调用会被忽略。另外，在开发过程中，<code>assert(<em>condition</em>)</code> 如果 **condition** 为 false，会抛出一个异常。有关详细信息，请参阅 [断言][Assert]。

{{site.alert.end}}

With null safety, you must initialize the values
of non-nullable variables before you use them:

对于空安全，你必须在使用非空变量之前初始化它们的值：

<?code-excerpt "misc/lib/language_tour/variables.dart (var-ns-init)"?>
```dart
int lineCount = 0;
```

You don't have to initialize a local variable where it's declared,
but you do need to assign it a value before it's used.
For example, the following code is valid because
Dart can detect that `lineCount` is non-null by the time
it's passed to `print()`:

你不必在声明变量时初始化变量，但在使用之前需要为其赋值。例如，以下代码是合法的，因为 Dart 可以检测到 `lineCount` 在传递给 `print()` 时是非空的：

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

顶级变量和类变量是延迟初始化的；初始化代码会在变量第一次被使用时完成。


## Late variables

## 延迟初始化变量

The `late` modifier has two use cases:

late修饰符有两种用法：

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

通常，Dart 的语义分析可以检测非空变量在使用之前是否被复制，但有时分析会失败。两种常见情况是顶级变量和实例变量：Dart 通常无法确定它们是否已设值，因此不会尝试分析。

If you're sure that a variable is set before it's used,
but Dart disagrees,
you can fix the error by marking the variable as `late`:

如果你确定变量在使用之前已设置，但 Dart 判断失误的话，则可以通过将变量标记为 `late` 来解决这个问题：

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
{{site.alert.end}}

When you mark a variable as `late` but initialize it at its declaration,
then the initializer runs the first time the variable is used.
This lazy initialization is handy in a couple of cases:

当一个 `late` 修饰的变量在声明时就指定了初始化方法，那么初始化程序会在第一次使用变量时运行。这种延迟初始化在以下情况很方便：

* The variable might not be needed,
  and initializing it is costly.

  (Dart 认为)可能不需要该变量，并且初始化它开销很高。

* You're initializing an instance variable,
  and its initializer needs access to `this`.

  你正在初始化一个实例变量，它的初始化方法需要调用 `this`。

In the following example,
if the `temperature` variable is never used,
then the expensive `readThermometer()` function is never called:

在下面的例子中，如果从未使用 `temperature` 变量，则永远不会调用高开销的 `readThermometer()` 函数：

<?code-excerpt "misc/lib/language_tour/variables.dart (var-late-lazy)" replace="/late/[!$&!]/g"?>
```dart
// This is the program's only call to readThermometer().
[!late!] String temperature = readThermometer(); // Lazily initialized.
```


## Final and const

## 终值 (final) 和常量 (const)

If you never intend to change a variable, use `final` or `const`, either
instead of `var` or in addition to a type. A final variable can be set
only once; a const variable is a compile-time constant. (Const variables
are implicitly final.)

如果你永不打算更改变量，可以使用 `final` 或 `const` ，而不是 `var` 或作为类型附加。一个 final 变量只能设置一次；const 变量是编译时常量。（const 变量隐式为 final。）

{{site.alert.note}}

  [Instance variables][] can be `final` but not `const`.

  [实例变量][Instance variables] 可以是 `final` 但不能是 `const`。

{{site.alert.end}}

Here's an example of creating and setting a `final` variable:

下面是创建和设置 `final` 变量的示例：

<?code-excerpt "misc/lib/language_tour/variables.dart (final)"?>
```dart
final name = 'Bob'; // Without a type annotation
final String nickname = 'Bobby';
```

You can't change the value of a `final` variable:

你不能改变 `final` 变量的值：

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

对于希望成为 **编译时常量** 的变量，请使用 `const`。如果 const 变量位于类级别，请将其标记为 `static const`。在声明变量的位置，将其值设置为编译时常量，比如数字或字符串字面量，`const` 变量，或在常量数字上进行的算术运算的结果：

<?code-excerpt "misc/lib/language_tour/variables.dart (const)"?>
```dart
const bar = 1000000; // Unit of pressure (dynes/cm2)
const double atm = 1.01325 * bar; // Standard atmosphere
```

The `const` keyword isn't just for declaring constant variables.
You can also use it to create constant _values_,
as well as to declare constructors that _create_ constant values.
Any variable can have a constant value.

`const` 关键字不仅仅可用于声明常量，
你还可以使用它来创建常量 **值(values)**，以及声明 **创建(create)** 常量值的构造函数。
任何变量都可以拥有常量值。

<?code-excerpt "misc/lib/language_tour/variables.dart (const-vs-final)"?>
```dart
var foo = const [];
final bar = const [];
const baz = []; // Equivalent to `const []`
```

You can omit `const` from the initializing expression of a `const` declaration,
like for `baz` above. For details, see [DON'T use const redundantly][].

你可以省略 `const`  声明中的初始化表达式，就像上面的 `baz` 一样。详细信息，请看 [不要重复使用常量][DON'T use const redundantly]。

You can change the value of a non-final, non-const variable,
even if it used to have a `const` value:

如果变量没有以 `final` 或者 `const` 修饰，
即使它以前有的值是一个 `const` 修饰的值，
你也可以修改这个变量：

<?code-excerpt "misc/lib/language_tour/variables.dart (reassign-to-non-final)"?>
```dart
foo = [1, 2, 3]; // Was const []
```

You can't change the value of a `const` variable:

你不能改变 `const` 变量的值：

{:.fails-sa}
<?code-excerpt "misc/lib/language_tour/variables.dart (cant-assign-to-const)"?>
```dart
baz = [42]; // Error: Constant variables can't be assigned a value.
```

You can define constants that use
[type checks and casts][] (`is` and `as`),
[collection `if`][],
and [spread operators][] (`...` and `...?`):

你可以在定义常量时使用 [类型检查和转换][type checks and casts]（`is` 和 `as`）、
[集合中的 `if`][collection `if`] 和
[展开操作符][spread operators]（`...` 和 `...?`）：

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

  虽然 `final` 对象不能被修改，但它的字段可能可以被更改。
  相比之下，`const` 对象及其字段不能被更改：它们是 **不可变的**。

{{site.alert.end}}

For more information on using `const` to create constant values, see
[Lists][], [Maps][], and [Classes][].

有关使用 `const` 创建常量值的更多信息，请参见
[Lists][]、[Maps][] 和 [Classes][]。


[Assert]: /language/error-handling#assert
[Instance variables]: /language/classes#instance-variables
[DON'T use const redundantly]: /effective-dart/usage#dont-use-const-redundantly
[type checks and casts]: /language/operators#type-test-operators
[collection `if`]: /language/collections#control-flow-operators
[spread operators]: /language/collections#spread-operators
[Lists]: /language/collections#lists
[Maps]: /language/collections#maps
[Classes]: /language/classes
