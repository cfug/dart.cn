---
# title: Loops
title: 循环
# description: Learn how to use loops to control the flow of your Dart code.
description: 了解如何使用循环来控制 Dart 代码的流程。
prevpage:
  url: /language/pattern-types
  # title: Pattern types
  title: 模式类型
nextpage:
  url: /language/branches
  # title: Branches
  title: 分支
---

This page shows how you can control the flow of your Dart code using loops and
supporting statements:

本页面展示如何使用循环和辅助语句来控制 Dart 代码的流程：

-   `for` loops
-   `while` and `do while` loops
-   `break` and `continue`

-   `for` 循环
-   `while` 和 `do while` 循环
-   `break` 和 `continue`

You can also manipulate control flow in Dart using:

你还可以使用以下方式在 Dart 中控制流程：

- [Branching][], like `if` and `switch`
- [Exceptions][], like `try`, `catch`, and `throw`

- [分支][Branching]，如 `if` 和 `switch`
- [异常][Exceptions]，如 `try`、`catch` 和 `throw`

## For loops

## For 循环

You can iterate with the standard `for` loop. For example:

你可以使用标准的 `for` 循环进行迭代。例如：

<?code-excerpt "language/test/control_flow/loops_test.dart (for)"?>
```dart
var message = StringBuffer('Dart is fun');
for (var i = 0; i < 5; i++) {
  message.write('!');
}
```

Closures inside of Dart's `for` loops capture the _value_ of the index.
This avoids a common pitfall found in JavaScript. For example, consider:

Dart `for` 循环内的闭包会捕获索引的_值_。
这避免了 JavaScript 中常见的陷阱。例如，考虑：

<?code-excerpt "language/test/control_flow/loops_test.dart (for-and-closures)"?>
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

输出如预期的那样是 `0` 然后是 `1`。
相比之下，该示例在 JavaScript 中会打印 `2` 然后是 `2`。

Sometimes you might not need to know the current iteration counter
when iterating over an [`Iterable`][] type, like `List` or `Set`.
In that case, use the `for-in` loop for cleaner code:

有时在遍历 [`Iterable`][] 类型（如 `List` 或 `Set`）时，
你可能不需要知道当前的迭代计数器。
在这种情况下，使用 `for-in` 循环可以使代码更简洁：

<?code-excerpt "language/lib/control_flow/loops.dart (collection)"?>
```dart
for (var candidate in candidates) {
  candidate.interview();
}
```

In the previous example loop, `candidate` is
defined within the loop body and
set to reference one value from `candidates` at a time.
`candidate` is a local [variable][].
Reassigning `candidate` inside the loop body only
changes the local variable for that iteration and
doesn't modify the original `candidates` iterable.

在前面的示例循环中，`candidate` 在循环体内定义，
并设置为每次引用 `candidates` 中的一个值。
`candidate` 是一个局部[变量][variable]。
在循环体内重新赋值 `candidate` 只会更改该次迭代的局部变量，
不会修改原始的 `candidates` 可迭代对象。

To process the values obtained from the iterable,
you can also use a [pattern][] in a `for-in` loop:

要处理从可迭代对象获取的值，
你也可以在 `for-in` 循环中使用[模式][pattern]：

<?code-excerpt "language/lib/control_flow/loops.dart (collection-for-pattern)"?>
```dart
for (final Candidate(:name, :yearsExperience) in candidates) {
  print('$name has $yearsExperience of experience.');
}
```

:::tip
To practice using `for-in`, follow the
[Iterable collections tutorial](/libraries/collections/iterables).

要练习使用 `for-in`，请参阅
[可迭代集合教程](/libraries/collections/iterables)。
:::

Iterable classes also have a [forEach()][] method as another option:

可迭代类还有一个 [forEach()][] 方法作为另一种选择：

<?code-excerpt "language/test/control_flow/loops_test.dart (for-each)"?>
```dart
var collection = [1, 2, 3];
collection.forEach(print); // 1 2 3
```

[variable]: /language/variables

## While and do-while

## While 和 do-while

A `while` loop evaluates the condition before the loop:

`while` 循环在循环之前评估条件：

<?code-excerpt "language/lib/control_flow/loops.dart (while)"?>
```dart
while (!isDone()) {
  doSomething();
}
```

A `do`-`while` loop evaluates the condition *after* the loop:

`do`-`while` 循环在循环*之后*评估条件：

<?code-excerpt "language/lib/control_flow/loops.dart (do-while)"?>
```dart
do {
  printLine();
} while (!atEndOfPage());
```


## Break and continue

## Break 和 continue

Use `break` to stop looping:

使用 `break` 停止循环：

<?code-excerpt "language/lib/control_flow/loops.dart (while-break)"?>
```dart
while (true) {
  if (shutDownRequested()) break;
  processIncomingRequests();
}
```

Use `continue` to skip to the next loop iteration:

使用 `continue` 跳到下一次循环迭代：

<?code-excerpt "language/lib/control_flow/loops.dart (for-continue)"?>
```dart
for (int i = 0; i < candidates.length; i++) {
  var candidate = candidates[i];
  if (candidate.yearsExperience < 5) {
    continue;
  }
  candidate.interview();
}
```

If you're using an [`Iterable`][] such as a list or set,
how you write the previous example might differ:

如果你使用的是 [`Iterable`][]（如列表或集合），
编写前面示例的方式可能会有所不同：

<?code-excerpt "language/lib/control_flow/loops.dart (where)"?>
```dart
candidates
    .where((c) => c.yearsExperience >= 5)
    .forEach((c) => c.interview());
```

## Labels

## 标签

A label is an identifier followed by a colon (`labelName:`)
that you can place before a statement to create a
_labeled statement_. Loops and switch cases are often used as
labeled statements. A labeled statement can be referenced later
in a `break` or `continue` statement as follows:

标签是一个后跟冒号（`labelName:`）的标识符，
你可以将其放在语句之前以创建_带标签的语句_。
循环和 switch case 通常用作带标签的语句。
带标签的语句可以稍后在 `break` 或 `continue` 语句中引用，如下所示：

* `break labelName;`
  Terminates the execution of the labeled statement.
  This is useful for breaking out of a specific outer loop when you're
  within a nested loop.

* `break labelName;`
  终止带标签语句的执行。
  当你在嵌套循环中时，这对于跳出特定的外部循环很有用。

* `continue labelName;`
  Skips the rest of the current iteration of the
  labeled statement loop and continues with the next iteration.

* `continue labelName;`
  跳过带标签语句循环当前迭代的剩余部分，
  并继续下一次迭代。

Labels are used to manage control flow. They are often used with
loops and switch cases and allow you to specify which statement to
break out of or continue, rather than affecting the innermost
loop by default.

标签用于管理控制流。它们通常与循环和 switch case 一起使用，
允许你指定要跳出或继续的语句，
而不是默认影响最内层的循环。

### Labels in for loop using `break` {:.no_toc}

### 在 for 循环中使用 `break` 的标签 {:.no_toc}

The following code demonstrates the usage of a label called `outerLoop`
in a  `for` loop with a `break` statement:

以下代码演示了在带有 `break` 语句的 `for` 循环中
使用名为 `outerLoop` 的标签：

<?code-excerpt "language/lib/control_flow/loops.dart (label-for-loop-break)"?>
```dart
outerLoop:
for (var i = 1; i <= 3; i++) {
  for (var j = 1; j <= 3; j++) {
    print('i = $i, j = $j');
    if (i == 2 && j == 2) {
      break outerLoop;
    }
  }
}
print('outerLoop exited');
```

In the previous example, when `i == 2` and `j == 2`, the `break outerLoop;`
statement stops both inner and outer loops. As a result, the output is:

在前面的示例中，当 `i == 2` 且 `j == 2` 时，
`break outerLoop;` 语句会停止内部和外部循环。因此，输出是：

```plaintext
i = 1, j = 1
i = 1, j = 2
i = 1, j = 3
i = 2, j = 1
i = 2, j = 2
outerLoop exited
```

### Labels in for loop using `continue` {:.no_toc}

### 在 for 循环中使用 `continue` 的标签 {:.no_toc}

The following code demonstrates the use of a label called `outerLoop`
in a  `for` loop with a `continue` statement:

以下代码演示了在带有 `continue` 语句的 `for` 循环中
使用名为 `outerLoop` 的标签：

<?code-excerpt "language/lib/control_flow/loops.dart (label-for-loop-continue)"?>
```dart
outerLoop:
for (var i = 1; i <= 3; i++) {
  for (var j = 1; j <= 3; j++) {
    if (i == 2 && j == 2) {
      continue outerLoop;
    }
    print('i = $i, j = $j');
  }
}
```

In the previous example, when `i == 2` and `j == 2`, `continue outerLoop;` skips the
rest of the iterations for `i = 2` and moves to `i = 3`. As a result, the output is:

在前面的示例中，当 `i == 2` 且 `j == 2` 时，
`continue outerLoop;` 跳过 `i = 2` 的剩余迭代并移动到 `i = 3`。
因此，输出是：

```plaintext
i = 1, j = 1
i = 1, j = 2
i = 1, j = 3
i = 2, j = 1
i = 3, j = 1
i = 3, j = 2
i = 3, j = 3
```

### Labels in while loop using `break` {:.no_toc}

### 在 while 循环中使用 `break` 的标签 {:.no_toc}

The following code demonstrates the use of a label called `outerLoop` in
a `while` loop with a `break` statement:

以下代码演示了在带有 `break` 语句的 `while` 循环中
使用名为 `outerLoop` 的标签：

<?code-excerpt "language/lib/control_flow/loops.dart (label-while-loop-break)"?>
```dart
var i = 1;

outerLoop:
while (i <= 3) {
  var j = 1;
  while (j <= 3) {
    print('i = $i, j = $j');
    if (i == 2 && j == 2) {
      break outerLoop;
    }
    j++;
  }
  i++;
}
print('outerLoop exited');
```

In the previous example, the program breaks out of both inner and outer `while` loops
when `i == 2` and `j == 2`. As a result, the output is:

在前面的示例中，当 `i == 2` 且 `j == 2` 时，
程序跳出内部和外部的 `while` 循环。因此，输出是：

```plaintext
i = 1, j = 1
i = 1, j = 2
i = 1, j = 3
i = 2, j = 1
i = 2, j = 2
outerLoop exited
```

### Labels in while loop using `continue` {:.no_toc}

### 在 while 循环中使用 `continue` 的标签 {:.no_toc}

The following code demonstrates the use of a label called `outerLoop` in
a `while` loop with a `continue` statement:

以下代码演示了在带有 `continue` 语句的 `while` 循环中
使用名为 `outerLoop` 的标签：

<?code-excerpt "language/lib/control_flow/loops.dart (label-while-loop-continue)"?>
```dart
var i = 1;

outerLoop:
while (i <= 3) {
  var j = 1;
  while (j <= 3) {
    if (i == 2 && j == 2) {
      i++;
      continue outerLoop;
    }
    print('i = $i, j = $j');
    j++;
  }
  i++;
}
```

In the previous example, the iteration for `i = 2` and `j = 2` is skipped and the loop moves
directly to `i = 3`. As a result, the output is:

在前面的示例中，`i = 2` 且 `j = 2` 的迭代被跳过，
循环直接移动到 `i = 3`。因此，输出是：

```plaintext
i = 1, j = 1
i = 1, j = 2
i = 1, j = 3
i = 2, j = 1
i = 3, j = 1
i = 3, j = 2
i = 3, j = 3
```

### Labels in do-while loop using `break` {:.no_toc}

### 在 do-while 循环中使用 `break` 的标签 {:.no_toc}

The following code demonstrates the use of a label called `outerLoop` in
a `do while` loop with a `break` statement:

以下代码演示了在带有 `break` 语句的 `do while` 循环中
使用名为 `outerLoop` 的标签：

<?code-excerpt "language/lib/control_flow/loops.dart (label-do-while-loop-break)"?>
```dart
var i = 1;

outerLoop:
do {
  var j = 1;
  do {
    print('i = $i, j = $j');
    if (i == 2 && j == 2) {
      break outerLoop;
    }
    j++;
  } while (j <= 3);
  i++;
} while (i <= 3);

print('outerLoop exited');
```

In the previous example, the program breaks out of both inner and outer loops when `i == 2` and
`j == 2`. As a result, the output is:

在前面的示例中，当 `i == 2` 且 `j == 2` 时，
程序跳出内部和外部循环。因此，输出是：

```plaintext
i = 1, j = 1
i = 1, j = 2
i = 1, j = 3
i = 2, j = 1
i = 2, j = 2
outerLoop exited
```

### Labels in do-while loop using `continue` {:.no_toc}

### 在 do-while 循环中使用 `continue` 的标签 {:.no_toc}

The following code demonstrates the use of a label called `outerLoop` in
a `do while` loop with a `continue` statement:

以下代码演示了在带有 `continue` 语句的 `do while` 循环中
使用名为 `outerLoop` 的标签：

<?code-excerpt "language/lib/control_flow/loops.dart (label-do-while-loop-continue)"?>
```dart
var i = 1;

outerLoop:
do {
  var j = 1;
  do {
    if (i == 2 && j == 2) {
      i++;
      continue outerLoop;
    }
    print('i = $i, j = $j');
    j++;
  } while (j <= 3);
  i++;
} while (i <= 3);
```

In the previous example, the loop skips `i = 2` and `j = 2` and moves directly to `i = 3`.
As a result, the output is:

在前面的示例中，循环跳过 `i = 2` 且 `j = 2`，
并直接移动到 `i = 3`。因此，输出是：

```plaintext
i = 1, j = 1
i = 1, j = 2
i = 1, j = 3
i = 2, j = 1
i = 3, j = 1
i = 3, j = 2
i = 3, j = 3
```

[exceptions]: /language/error-handling
[branching]: /language/branches
[iteration]: /libraries/dart-core#iteration
[forEach()]: {{site.dart-api}}/dart-core/Iterable/forEach.html
[`Iterable`]: {{site.dart-api}}/dart-core/Iterable-class.html
[pattern]: /language/patterns
