---
# title: Branches 
title: 分支
# description: Learn how to use branches to control the flow of your Dart code.
description: 了解如何使用分支控制 Dart 代码的流程。
prevpage:
  url: /language/loops
  # title: Loops
  title: 循环
nextpage:
  url: /language/error-handling
  # title: Error handling
  title: 错误处理
ai-translated: true
---

This page shows how you can control the flow of your Dart code using branches:

本页介绍如何用分支控制 Dart 代码的流程：

- `if` statements and elements

  `if` 语句和元素

- `if-case` statements and elements

  `if-case` 语句和元素

- `switch` statements and expressions

  `switch` 语句和表达式

You can also manipulate control flow in Dart using:

你也可以用下面的方式操纵 Dart 中的控制流：

- [Loops][], like `for` and `while`

  [循环][Loops]，例如 `for` 和 `while`

- [Exceptions][], like `try`, `catch`, and `throw`

  [异常][Exceptions]，例如 `try`、`catch` 和 `throw`

## If

## If 语句

Dart supports `if` statements with optional `else` clauses.
The condition in parentheses after `if` must be
an expression that evaluates to a [boolean][]:

Dart 支持带可选 `else` 子句的 `if` 语句。
`if` 后面括号中的条件必须是
求值为 [布尔值][boolean] 的表达式：

<?code-excerpt "language/lib/control_flow/branches.dart (if-else)"?>
```dart
if (isRaining()) {
  you.bringRainCoat();
} else if (isSnowing()) {
  you.wearJacket();
} else {
  car.putTopDown();
}
```

To learn how to use `if` in an expression context, 
check out [Conditional expressions][].

想了解如何在表达式上下文中使用 `if`，
请参阅 [条件表达式][Conditional expressions]。

### If-case

### If-case 语句

Dart `if` statements support `case` clauses followed by a [pattern][]: 

Dart 的 `if` 语句支持后面跟着 [模式][pattern] 的 `case` 子句：

<?code-excerpt "language/lib/control_flow/branches.dart (if-case)"?>
```dart
if (pair case [int x, int y]) return Point(x, y);
```

If the pattern matches the value,
then the branch executes with any variables the pattern defines in scope.

如果模式与该值匹配，
这个分支就会执行，模式所定义的任何变量都在作用域内。

In the previous example,
the list pattern `[int x, int y]` matches the value `pair`,
so the branch `return Point(x, y)` executes with the variables that
the pattern defined, `x` and `y`.

在上一个例子中，
列表模式 `[int x, int y]` 与值 `pair` 匹配，
因此分支 `return Point(x, y)` 会执行，
并且可以使用模式定义的变量 `x` 和 `y`。

Otherwise, control flow progresses to the `else` branch
to execute, if there is one:

否则，控制流会转到 `else` 分支去执行（如果有的话）：

<?code-excerpt "language/lib/control_flow/branches.dart (if-case-else)"?>
```dart 
if (pair case [int x, int y]) {
  print('Was coordinate array $x,$y');
} else {
  throw FormatException('Invalid coordinates.');
}
```

The if-case statement provides a way to match and
[destructure][] against a _single_ pattern. 
To test a value against _multiple_ patterns, use [switch](#switch).

if-case 语句让你针对 **单个** 模式进行匹配和
[解构][destructure]。
要用 **多个** 模式测试一个值，请使用 [switch](#switch)。

:::version-note
Case clauses in if statements require
a [language version][] of at least 3.0.

`if` 语句中的 case 子句要求
[语言版本][language version] 至少为 3.0。

:::

<a id="switch"></a>
## Switch statements

## Switch 语句

A `switch` statement evaluates a value expression against a series of cases.
Each `case` clause is a [pattern][] for the value to match against.
You can use [any kind of pattern][] for a case.

`switch` 语句把一个值表达式与一系列 case 做比较。
每个 `case` 子句都是供该值去匹配的 [模式][pattern]。
case 可以使用 [任何种类的模式][any kind of pattern]。

When the value matches a case's pattern, the case body executes. 
Non-empty `case` clauses jump to the end of the switch after completion.
They do not require a `break` statement.
Other valid ways to end a non-empty `case` clause are a
[`continue`][break], [`throw`][], or [`return`][] statement.

当值与某个 case 的模式匹配时，该 case 的主体就会执行。
非空的 `case` 子句执行完毕后会跳到 switch 的末尾。
它们不需要 `break` 语句。
结束非空 `case` 子句的其他有效方式还有
[`continue`][break]、[`throw`][`throw`] 或 [`return`][`return`] 语句。

Use a `default` or [wildcard `_`][] clause to
execute code when no `case` clause matches:

当没有 `case` 子句匹配时，
使用 `default` 或 [通配符 `_`][wildcard `_`] 子句来执行代码：

<?code-excerpt "language/lib/control_flow/branches.dart (switch)"?>
```dart
var command = 'OPEN';
switch (command) {
  case 'CLOSED':
    executeClosed();
  case 'PENDING':
    executePending();
  case 'APPROVED':
    executeApproved();
  case 'DENIED':
    executeDenied();
  case 'OPEN':
    executeOpen();
  default:
    executeUnknown();
}
```

<a id="switch-share"></a>

Empty cases fall through to the next case, allowing cases to share a body. 
For an empty case that does not fall through,
use [`break`][break] for its body.
For non-sequential fall-through,
you can use a [`continue` statement][break] and a label:

空的 case 会贯穿到下一个 case，这样多个 case 就能共用一个主体。
对于不贯穿的空 case，
用 [`break`][break] 作为它的主体。
对于非顺序的贯穿，
可以使用 [`continue` 语句][break] 和标签：

<?code-excerpt "language/lib/control_flow/branches.dart (switch-empty)"?>
```dart
switch (command) {
  case 'OPEN':
    executeOpen();
    continue newCase; // Continues executing at the newCase label.

  case 'DENIED': // Empty case falls through.
  case 'CLOSED':
    executeClosed(); // Runs for both DENIED and CLOSED,

  newCase:
  case 'PENDING':
    executeNowClosed(); // Runs for both OPEN and PENDING.
}
```

You can use [logical-or patterns][] to allow cases to share a body or a guard.
To learn more about patterns and case clauses, 
check out the patterns documentation on [Switch statements and expressions][].

你可以用 [逻辑或模式][logical-or patterns] 让多个 case 共用一个主体或一个守卫。
要进一步了解模式和 case 子句，
请参阅模式文档中的 [switch 语句与表达式][Switch statements and expressions]。

[Switch statements and expressions]: /language/patterns#switch-statements-and-expressions

### Switch expressions

### Switch 表达式

A `switch` _expression_ produces a value based on the expression
body of whichever case matches. 
You can use a switch expression wherever Dart allows expressions,
_except_ at the start of an expression statement. For example:

`switch` **表达式** 会根据所匹配 case 的表达式主体产生一个值。
凡是 Dart 允许出现表达式的地方，都可以使用 switch 表达式，
表达式语句的开头 **除外**。例如：

```dart
var x = switch (y) { ... };

print(switch (x) { ... });

return switch (x) { ... };
```

If you want to use a switch at the start of an expression statement,
use a [switch statement](#switch-statements).

如果想在表达式语句的开头使用 switch，
请使用 [switch 语句](#switch-statements)。

Switch expressions allow you to rewrite a switch _statement_ like this:

switch 表达式可以把下面这样的 switch **语句** 改写一下：

<?code-excerpt "language/lib/control_flow/branches.dart (switch-stmt)"?>
```dart
// Where slash, star, comma, semicolon, etc., are constant variables...
switch (charCode) {
  case slash || star || plus || minus: // Logical-or pattern
    token = operator(charCode);
  case comma || semicolon: // Logical-or pattern
    token = punctuation(charCode);
  case >= digit0 && <= digit9: // Relational and logical-and patterns
    token = number();
  default:
    throw FormatException('Invalid');
}
```

Into an _expression_, like this:

改写成 **表达式**，像这样：

<?code-excerpt "language/lib/control_flow/branches.dart (switch-exp)"?>
```dart
token = switch (charCode) {
  slash || star || plus || minus => operator(charCode),
  comma || semicolon => punctuation(charCode),
  >= digit0 && <= digit9 => number(),
  _ => throw FormatException('Invalid'),
};
```

The syntax of a `switch` expression differs from `switch` statement syntax:

`switch` 表达式的语法与 `switch` 语句不同：

- Cases _do not_ start with the `case` keyword.

  case **不会** 以 `case` 关键字开头。

- A case body is a single expression instead of a series of statements.

  case 主体是单个表达式，而不是一系列语句。

- Each case must have a body; there is no implicit fallthrough for empty cases.

  每个 case 都必须有主体；空 case 没有隐式贯穿。

- Case patterns are separated from their bodies using `=>` instead of `:`.

  case 的模式与主体之间用 `=>` 分隔，而不是 `:`。

- Cases are separated by `,` (and an optional trailing `,` is allowed).

  case 之间用 `,` 分隔（也允许可选的尾随 `,`）。

- Default cases can _only_ use `_`, instead of allowing both `default` and `_`.

  默认 case **只能** 使用 `_`，不能同时接受 `default` 和 `_`。

:::version-note
Switch expressions require a [language version][] of at least 3.0.

switch 表达式要求 [语言版本][language version] 至少为 3.0。

:::

### Exhaustiveness checking

### 穷尽性检查

Exhaustiveness checking is a feature that reports a
compile-time error if it's possible for a value to enter a switch but
not match any of the cases.

穷尽性检查是一项这样的功能：如果某个值有可能进入 switch，
却匹配不到任何一个 case，它就会报告编译时错误。

<?code-excerpt "language/lib/control_flow/branches.dart (exh-bool)"?>
```dart
// Non-exhaustive switch on bool?, missing case to match null possibility:
switch (nullableBool) {
  case true:
    print('yes');
  case false:
    print('no');
}
```

A default case (`default` or `_`) covers all possible values that
can flow through a switch.
This makes a switch on any type exhaustive.

默认 case（`default` 或 `_`）覆盖了
所有可能流经 switch 的值。
这使得对任何类型做 switch 都是穷尽的。

[Enums][enum] and [sealed types][sealed] are particularly useful for
switches because, even without a default case, 
their possible values are known and fully enumerable. 
Use the [`sealed` modifier][sealed] on a class to enable
exhaustiveness checking when switching over subtypes of that class:

[枚举][enum] 和 [密封类型][sealed] 特别适合用于 switch，
因为即便没有默认 case，
它们可能的值也是已知且可以完全枚举的。
在类上使用 [`sealed` 修饰符][sealed]，
就能在对该类的子类型做 switch 时启用穷尽性检查：

<?code-excerpt "language/lib/patterns/algebraic_datatypes.dart (algebraic-datatypes)"?>
```dart
sealed class Shape {}

class Square implements Shape {
  final double length;
  Square(this.length);
}

class Circle implements Shape {
  final double radius;
  Circle(this.radius);
}

double calculateArea(Shape shape) => switch (shape) {
  Square(length: var l) => l * l,
  Circle(radius: var r) => math.pi * r * r,
};
```

If anyone were to add a new subclass of `Shape`, 
this `switch` expression would be incomplete. 
Exhaustiveness checking would inform you of the missing subtype.
This allows you to use Dart in a somewhat 
[functional algebraic datatype style](https://en.wikipedia.org/wiki/Algebraic_data_type). 

如果有人给 `Shape` 新增一个子类，
这个 `switch` 表达式就会不完整。
穷尽性检查会告诉你缺少了哪个子类型。
这样你就可以用一种略带
[函数式代数数据类型风格](https://en.wikipedia.org/wiki/Algebraic_data_type) 的方式来使用 Dart。

<a id="when"></a>
## Guard clause

## 守卫子句

To set an optional guard clause after a `case` clause, use the keyword `when`.
A guard clause can follow `if case`, and
both `switch` statements and expressions.

要在 `case` 子句后面设置可选的守卫子句，使用关键字 `when`。
守卫子句可以跟在 `if case` 后面，
也可以用于 `switch` 语句和表达式。

```dart
// Switch statement:
switch (something) {
  case somePattern when some || boolean || expression:
    //             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Guard clause.
    body;
}

// Switch expression:
var value = switch (something) {
  somePattern when some || boolean || expression => body,
  //               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Guard clause.
}

// If-case statement:
if (something case somePattern when some || boolean || expression) {
  //                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Guard clause.
  body;
}
```

Guards evaluate an arbitrary boolean expression _after_ matching.
This allows you to add further constraints on
whether a case body should execute.
When the guard clause evaluates to false, 
execution proceeds to the next case rather
than exiting the entire switch.

守卫在匹配 **之后** 对任意布尔表达式求值。
这样你就可以进一步约束
某个 case 主体是否应当执行。
当守卫子句求值为 false 时，
执行会继续到下一个 case，
而不是退出整个 switch。

[language version]: /language/versioning
[loops]: /language/loops
[exceptions]: /language/error-handling
[conditional expressions]: /language/operators#conditional-expressions
[boolean]: /language/built-in-types#booleans
[pattern]: /language/patterns
[enum]: /language/enums
[`throw`]: /language/error-handling#throw
[`return`]: /language/functions#return-values
[wildcard `_`]: /language/pattern-types#wildcard
[break]: /language/loops#break-and-continue
[sealed]: /language/class-modifiers#sealed
[any kind of pattern]: /language/pattern-types
[destructure]: /language/patterns#destructuring
[section on switch]: /language/patterns#switch-statements-and-expressions
[logical-or patterns]: /language/patterns#or-pattern-switch
