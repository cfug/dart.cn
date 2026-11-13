---
# title: Fixing type promotion failures
title: 修复类型提升失败
# description: >-
#   Solutions for cases where you know more about a
#   field's type than Dart can determine.
description: "当你比 Dart 更了解某个字段的类型时，各种情况的解决方案。"
ai-translated: true
---

[Type promotion][] occurs when flow analysis can soundly confirm
that a variable of type `T` actually refers to an object of a subtype
`S` of `T`. The variable is then promoted to `S`.
As a special case, the variable may have a [nullable type][], and
flow analysis may confirm that it is *not null*. The variable is then
promoted to the corresponding non-nullable type.
Many circumstances can weaken a type's soundness,
causing type promotion to fail.

This page lists reasons why type promotion failures occur,
with tips on how to fix them.
To learn more about flow analysis and type promotion,
check out the [Understanding null safety][] page.

当流分析能够可靠地确认类型为 `T` 的变量
实际指向 `T` 的子类型 `S` 的对象时，
就会发生 [类型提升][Type promotion]，
该变量随即被提升为 `S`。
作为一种特殊情况，变量可能是 [可空类型][nullable type]，
流分析可以确认它 *不为 null*，
该变量随即被提升为对应的非空类型。
许多情况会削弱类型的可靠性，
导致类型提升失败。

本页列出类型提升失败的原因，
并给出修复建议。
要了解更多关于流分析和类型提升的内容，
请参阅 [理解空安全][Understanding null safety] 页面。

[Type promotion]: /null-safety/understanding-null-safety#type-promotion-on-null-checks
[nullable type]: /null-safety/understanding-null-safety#non-nullable-and-nullable-types
[Understanding null safety]: /null-safety/understanding-null-safety

## Unsupported language version for field promotion {:#language-version}

## 字段提升的语言版本不支持

**The cause:** 
You're trying to promote a field, but field promotion is language versioned,
and your code is set to a language version before 3.2.

**原因：**
你试图提升一个字段，但字段提升是随语言版本生效的，
而你的代码设置的语言版本早于 3.2。

If you're already using an SDK version >= Dart 3.2,
your code might still be explicitly targeted for an earlier [language version][].
This can happen either because:

如果你已经在使用 >= Dart 3.2 的 SDK 版本，
你的代码仍可能显式指定了更早的 [语言版本][language version]。
这可能是因为：

* Your [`pubspec.yaml`][] declares an SDK constraint with a
  lower bound below 3.2, or 

  你的 [`pubspec.yaml`][] 声明的 SDK 约束
  下界低于 3.2；或者
* You have a `// @dart=version` comment at the top of the file,
  where `version` is lower than 3.2.

  你在文件顶部写了 `// @dart=version` 注释，
  其中 `version` 低于 3.2。

**Example:**

```dart tag=bad
// @dart=3.1

class C {
  final int? _i;
  C(this._i);

  void f() {
    if (_i != null) {
      int i = _i;  // ERROR
    }
  }
}
```

**Message:**

```plaintext
'_i' refers to a field. It couldn't be promoted because field promotion is only available in Dart 3.2 and above.
```

**Solution:**

Ensure your library isn't using a [language version][] earlier than 3.2.
Check the top of your file for an outdated `// @dart=version` comment,
or your `pubspec.yaml` for an outdated [SDK constraint lower-bound][].

确保你的库没有使用早于 3.2 的 [语言版本][language version]。
检查文件顶部是否有过时的 `// @dart=version` 注释，
或 `pubspec.yaml` 中是否有过时的
[SDK 约束下界][SDK constraint lower-bound]。

[`pubspec.yaml`]: /tools/pub/pubspec
[SDK constraint lower-bound]: /tools/pub/pubspec#sdk-constraints

## Only local variables can be promoted (before Dart 3.2) {:#property}

## 只有局部变量能被提升（Dart 3.2 之前）

**The cause:**
You're trying to promote a property,
but only local variables can be promoted in Dart versions earlier than 3.2,
and you are using a version earlier than 3.2.

**原因：**
你试图提升一个属性，
但在早于 3.2 的 Dart 版本中只有局部变量能被提升，
而你使用的正是早于 3.2 的版本。

**Example:**

```dart tag=bad
class C {
  int? i;
  void f() {
    if (i == null) return;
    print(i.isEven);       // ERROR
  }
}
```

**Message:**

```plaintext
'i' refers to a property so it couldn't be promoted.
```

**Solution:**

If you are using Dart 3.1 or earlier, [upgrade to 3.2 or later][upgrade].

If you need to keep using an older version,
read [Other causes and workarounds](#other-causes-and-workarounds)

如果你在使用 Dart 3.1 或更早版本，
请 [升级到 3.2 或更高版本][upgrade]。

如果你需要继续使用旧版本，
请阅读 [其他原因与变通方案](#other-causes-and-workarounds)。

[upgrade]: /get-dart

## Other causes and workarounds

## 其他原因与变通方案

The remaining examples on this page document reasons for promotion failures
unrelated to version inconsistencies,
for both field and local variable failures, with examples and workarounds.

本页其余示例记录了与版本不一致无关的提升失败原因，
涵盖字段和局部变量的失败情况，并附示例和变通方案。

In general, the usual fixes for promotion failures
are one or more of the following:

一般来说，提升失败的常见修复方式
是以下一种或多种：

* Assign the property's value to a local variable with
  the non-nullable type you need.

  把属性的值赋给你所需非空类型的局部变量。
* Add an explicit null check (for example, `i == null`).

  添加显式的 null 检查（例如 `i == null`）。
* Use `!` or `as` as a [redundant check](#redundant-check)
  if you're sure an expression can't be `null`.

  如果你确定表达式不可能为 `null`，
  使用 `!` 或 `as` 作为 [冗余检查](#redundant-check)。

Here's an example of creating a local variable
(which can be named `i`)
that holds the value of `i`:

下面是创建一个局部变量（可以命名为 `i`）
来保存 `i` 的值的例子：

<?code-excerpt "non_promotion/lib/non_promotion.dart (property-copy)" replace="/final.*/[!$&!]/g"?>
```dart tag=good
class C {
  int? i;
  void f() {
    [!final i = this.i;!]
    if (i == null) return;
    print(i.isEven);
  }
}
```

This example features an instance field,
but it could instead use an instance getter, a static field or getter,
a top-level variable or getter, or [`this`](#this).

这个例子用的是实例字段，
但也可以换成实例 getter、静态字段或 getter、
顶层变量或 getter，或 [`this`](#this)。

:::tip
When creating a local variable to hold a field's value,
**make the variable `final`**.
That way, you can't accidentally update the local variable
when you intend to update the field.

创建局部变量来保存字段的值时，
**请把变量设为 `final`**。
这样，当你本想更新字段时，
就不会意外更新局部变量。
:::

And here's an example of using `i!`:

下面是使用 `i!` 的例子：

<?code-excerpt "non_promotion/lib/non_promotion.dart (property-bang)" replace="/!/[!!!]/g"?>
```dart tag=good
print(i[!!!].isEven);
```


<a id="redundant-check" aria-hidden="true"></a>

:::note
You can work around all of these non-promotion examples by adding
a _redundant check_—code that confirms a
condition that's already been checked.
If the promotion that's failing is a null check, use `!`;
if it's a type check, you can use `as`.

Redundant checks are an easy but error-prone solution
to type promotion failures.
Because they overrule the compiler,
they can lead to mistakes in a way that other solutions don't.

It's up to you whether to do the extra work to get types to promote 
(giving you confidence that the code is correct)
or to do a redundant check
(which might introduce a bug if your reasoning is wrong).

所有这些无法提升的例子，都可以通过添加
_冗余检查_ 来绕过——即确认一个已经检查过的条件的代码。
如果失败的提升是 null 检查，请使用 `!`；
如果是类型检查，可以使用 `as`。

冗余检查是解决类型提升失败的简单但容易出错的方案。
因为它们凌驾于编译器之上，
可能以其他方案不会有的方式引入错误。

是多做些工作让类型得以提升
（让你确信代码是正确的），
还是做冗余检查
（如果你的推理有误，可能引入 bug），
由你决定。
:::


### Can't promote `this` {:#this}

### 无法提升 `this`

**The cause:**
You're trying to promote `this`,
but type promotion for `this` is not yet supported.

**原因：**
你试图提升 `this`，
但尚不支持对 `this` 的类型提升。

One common `this` promotion scenario is when writing [extension methods][].
If the [`on` type][] of the extension method is a nullable type,
you'd want to do a null check to see whether `this` is `null`:

一个常见的 `this` 提升场景是编写 [extension 方法][extension methods]。
如果 extension 方法的 [`on` 类型][`on` type] 是可空类型，
你会想做 null 检查，看看 `this` 是否为 `null`：

**Example:**

```dart tag=bad
extension on int? {
  int get valueOrZero {
    return this == null ? 0 : this; // ERROR
  }
}
```

**Message:**

```plaintext
`this` can't be promoted. 
```

**Solution:**

Create a local variable to hold the value of `this`,
then perform the null check.

创建一个局部变量来保存 `this` 的值，
然后执行 null 检查。

<?code-excerpt "non_promotion/lib/non_promotion.dart (this)" replace="/final.*/[!$&!]/g"?>
```dart tag=good
extension on int? {
  int get valueOrZero {
    [!final self = this;!]
    return self == null ? 0 : self;
  }
}
```

[extension methods]: /language/extension-methods
[`on` type]: /language/extension-methods#implementing-extension-methods

### Only private fields can be promoted {:#private}

### 只有私有字段能被提升

**The cause:**
You're trying to promote a field, but the field is not private.

**原因：**
你试图提升一个字段，但该字段不是私有的。

It's possible for other libraries in your program
to override public fields with a getter. Because
[getters might not return a stable value](#not-field),
and the compiler can't know what other libraries are doing,
non-private fields cannot be promoted.

程序中的其他库有可能用 getter 重写公共字段。
因为 [getter 可能返回不稳定的值](#not-field)，
而且编译器无法知道其他库在做什么，
所以非私有字段不能被提升。

**Example:**

```dart tag=bad
class Example {
  final int? value;
  Example(this.value);
}

void test(Example x) {
  if (x.value != null) {
    print(x.value + 1); // ERROR
  }
}
```

**Message:**

```plaintext
'value' refers to a public property so it couldn't be promoted.
```

**Solution:**

Making the field private lets the compiler be sure that no outside libraries
could possibly override its value, so it's safe to promote.

把字段设为私有，编译器就能确定
外部库不可能重写它的值，因此可以安全地提升。

<?code-excerpt "non_promotion/lib/non_promotion.dart (private)" replace="/_val/_value/g; /_value;/[!_value!];/g; /PrivateFieldExample/Example/g;"?>
```dart tag=good
class Example {
  final int? [!_value!];
  Example(this._value);
}

void test(Example x) {
  if (x._value != null) {
    print(x._value + 1);
  }
}
```

### Only final fields can be promoted {:#final}

### 只有 final 字段能被提升

**The cause:**
You're trying to promote a field, but the field is not final.

**原因：**
你试图提升一个字段，但该字段不是 final 的。

To the compiler, non-final fields could, in principle,
be modified any time between the time
they're tested and the time they're used.
So it's not safe for the compiler to promote a non-final nullable type
to a non-nullable type.

对编译器来说，非 final 字段原则上
可能在被检查之后、被使用之前的任何时刻被修改。
所以编译器把非 final 的可空类型提升为非空类型
是不安全的。

**Example:**

```dart tag=bad
class Example {
  int? _mutablePrivateField;
  Example(this._mutablePrivateField);

  void f() {
    if (_mutablePrivateField != null) {
      int i = _mutablePrivateField; // ERROR
    }
  }
}
```

**Message:**

```plaintext
'_mutablePrivateField' refers to a non-final field so it couldn't be promoted.
```

**Solution:**

Make the field `final`:

把字段设为 `final`：

<?code-excerpt "non_promotion/lib/non_promotion.dart (final)" replace="/final/[!$&!]/g; /FinalExample/Example/g;"?>
```dart tag=good
class Example {
  [!final!] int? _immutablePrivateField;
  Example(this._immutablePrivateField);

  void f() {
    if (_immutablePrivateField != null) {
      int i = _immutablePrivateField; // OK
    }
  }
}
```

### Getters can't be promoted {:#not-field}

### getter 不能被提升

**The cause:** You're trying to promote a getter,
but only instance *fields* can be promoted, not instance getters. 

**原因：** 你试图提升一个 getter，
但只有实例 *字段* 能被提升，实例 getter 不行。

The compiler has no way to guarantee that
a getter returns the same result every time.
Because their stability can't be confirmed,
getters are not safe to promote.

编译器无法保证 getter 每次都返回相同的结果。
因为无法确认它们的稳定性，
提升 getter 是不安全的。

**Example:**

```dart tag=bad
import 'dart:math';

abstract class Example {
  int? get _value => Random().nextBool() ? 123 : null;
}

void f(Example x) {
  if (x._value != null) {
    print(x._value.isEven); // ERROR
  }
}
```

**Message:**

```plaintext
'_value' refers to a getter so it couldn't be promoted.
```

**Solution:**

Assign the getter to a local variable:

把 getter 的值赋给局部变量：

<?code-excerpt "non_promotion/lib/non_promotion.dart (not-field)" plaster="" replace="/final.*/[!$&!]/g; /NotFieldExample/Example/g;"?>
```dart tag=good
import 'dart:math';

abstract class Example {
  int? get _value => Random().nextBool() ? 123 : null;
}

void f(Example x) {
  [!final value = x._value;!]
  if (value != null) {
    print(value.isEven); // OK
  }
}
```

:::note
Flow analysis considers `abstract` getters stable enough to
allow type promotion, as long as there are no conflicting declarations.

只要没有冲突的声明，流分析认为 `abstract` getter
足够稳定，允许类型提升。
:::

### External fields can't be promoted {:#external}

### 外部字段不能被提升

**The cause:**
You're trying to promote a field, but the field is marked `external`.

**原因：**
你试图提升一个字段，但该字段被标记为 `external`。

External fields don't promote because they are essentially external getters;
their implementation is code from outside of Dart,
so there's no guarantee for the compiler that an external field 
will return the same value each time it's called.

外部字段不能被提升，因为它们本质上是外部 getter；
它们的实现是来自 Dart 之外的代码，
所以编译器无法保证外部字段每次调用都返回相同的值。

**Example:**

```dart tag=bad
class Example {
  external final int? _externalField;

  void f() {
    if (_externalField != null) {
      print(_externalField.isEven); // ERROR
    }
  }
}
```

**Message:**

```plaintext
'_externalField' refers to an external field so it couldn't be promoted.
```

**Solution:**

Assign the external field's value to a local variable:

把外部字段的值赋给局部变量：

<?code-excerpt "non_promotion/lib/non_promotion.dart (external)" replace="/final i =.*/[!$&!]/g; /ExternalExample/Example/g;"?>
```dart tag=good
class Example {
  external final int? _externalField;

  void f() {
    [!final i = _externalField;!]
    if (i != null) {
      print(i.isEven); // OK
    }
  }
}
```

### Conflict with getter elsewhere in library {:#getter-name}

### 与库中其他位置的 getter 冲突

**The cause:**
You're trying to promote a field,
but another class in the same library contains
a concrete getter with the same name.

**原因：**
你试图提升一个字段，
但同一库中的另一个类包含同名的具体 getter。

**Example:**

```dart tag=bad
import 'dart:math';

class Example {
  final int? _overridden;
  Example(this._overridden);
}

class Override implements Example {
  @override
  int? get _overridden => Random().nextBool() ? 1 : null;
}

void testParity(Example x) {
  if (x._overridden != null) {
    print(x._overridden.isEven); // ERROR
  }
}
```

**Message:**

```plaintext
'_overridden' couldn't be promoted because there is a conflicting getter in class 'Override'.
```

**Solution**:

If the getter and field are related and need to share their name 
(like when one of them overrides the other, as in the example above),
then you can enable type promotion by assigning the value to a local variable:

如果 getter 和字段相关且需要共享名称
（例如其中一个重写另一个，就像上面的例子），
那么把值赋给局部变量就能启用类型提升：

<?code-excerpt "non_promotion/lib/non_promotion.dart (conflicting-getter)" plaster="" replace="/final i =.*/[!$&!]/g; /GetterExample/Example/g;"?>
```dart tag=good
import 'dart:math';

class Example {
  final int? _overridden;
  Example(this._overridden);
}

class Override implements Example {
  @override
  int? get _overridden => Random().nextBool() ? 1 : null;
}

void testParity(Example x) {
  [!final i = x._overridden;!]
  if (i != null) {
    print(i.isEven); // OK
  }
}
```

#### Note about unrelated classes

#### 关于不相关类的说明

Note that in the above example it's clear
why it's unsafe to promote the field `_overridden`:
because there's an override relationship between the field and the getter. 
However, a conflicting getter will prevent field promotion
even if the classes are unrelated. For example:

注意，在上面的例子中，
为什么提升字段 `_overridden` 不安全是很清楚的：
因为字段和 getter 之间存在重写关系。
然而，即使类之间不相关，
冲突的 getter 也会阻止字段提升。例如：

```dart tag=bad
import 'dart:math';

class Example {
  final int? _i;
  Example(this._i);
}

class Unrelated {
  int? get _i => Random().nextBool() ? 1 : null;
}

void f(Example x) {
  if (x._i != null) {
    int i = x._i; // ERROR
  }
}
```

Another library might contain a class that combines the two unrelated
classes together into the same class hierarchy,
which would cause the reference in function `f` to `x._i` to
get dispatched to `Unrelated._i`. For example:

另一个库可能包含一个类，
把这两个不相关的类合并到同一个类层次结构中，
这会导致函数 `f` 中对 `x._i` 的引用
被分派到 `Unrelated._i`。例如：

```dart tag=bad
class Surprise extends Unrelated implements Example {}

void main() {
  f(Surprise());
}
```

**Solution:**

If the field and the conflicting entity are truly unrelated,
you can work around the problem by giving them different names:

如果字段和冲突的实体确实不相关，
可以给它们起不同的名字来绕过这个问题：

<?code-excerpt "non_promotion/lib/non_promotion.dart (unrelated)" replace="/get _j/[!$&!]/g; /UnrelatedExample/Example/g; /f2/f/g;"?>
```dart tag=good
class Example {
  final int? _i;
  Example(this._i);
}

class Unrelated {
  int? [!get _j!] => Random().nextBool() ? 1 : null;
}

void f(Example x) {
  if (x._i != null) {
    int i = x._i; // OK
  }
}
```

### Conflict with non-promotable field elsewhere in library {:#field-name}

### 与库中其他位置不可提升的字段冲突

**The cause:**
You're trying to promote a field, but another class in the same library
contains a field with the same name that isn't promotable
(for any of the other reasons listed on this page).

**原因：**
你试图提升一个字段，但同一库中的另一个类
包含同名的、不可提升的字段
（由于本页列出的其他任何原因）。

**Example:**

```dart tag=bad
class Example {
  final int? _overridden;
  Example(this._overridden);
}

class Override implements Example {
  @override
  int? _overridden;
}

void f(Example x) {
  if (x._overridden != null) {
    print(x._overridden.isEven); // ERROR
  }
}
```

This example fails because at runtime, `x` might actually be an
instance of `Override`, so promotion would not be sound.

这个例子失败是因为在运行时，
`x` 实际上可能是 `Override` 的实例，
所以提升会不可靠。

**Message:**

```plaintext
'overridden' couldn't be promoted because there is a conflicting non-promotable field in class 'Override'.
```

**Solution:**

If the fields are actually related and need to share a name, then
you can enable type promotion by assigning the value to a
final local variable to promote:

如果这些字段确实相关且需要共享名称，
那么把值赋给一个 final 局部变量来提升，
就能启用类型提升：

<?code-excerpt "non_promotion/lib/non_promotion.dart (conflicting-field)" replace="/final i =.*/[!$&!]/g; /FieldExample/Example/g; /f3/f/g; /Override2/Override/g;"?>
```dart tag=good
class Example {
  final int? _overridden;
  Example(this._overridden);
}

class Override implements Example {
  @override
  int? _overridden;
}

void f(Example x) {
  [!final i = x._overridden;!]
  if (i != null) {
    print(i.isEven); // OK
  }
}
```

If the fields are unrelated,
then rename one of the fields so they don't conflict.
Read the [Note about unrelated classes](#note-about-unrelated-classes). 

如果字段不相关，
请重命名其中一个字段以避免冲突。
阅读 [关于不相关类的说明](#note-about-unrelated-classes)。


### Conflict with implicit `noSuchMethod` forwarder {:#nosuchmethod}

### 与隐式 `noSuchMethod` 转发器冲突

**The cause:**
You're trying to promote a field that is private and final,
but another class in the same library contains an
[implicit `noSuchMethod` forwarder][nosuchmethod]
with the same name as the field.

**原因：**
你试图提升一个私有且 final 的字段，
但同一库中的另一个类包含一个
与该字段同名的
[隐式 `noSuchMethod` 转发器][nosuchmethod]。

This is unsound because there's no guarantee that `noSuchMethod`
will return a stable value from one invocation to the next.

这是不可靠的，因为无法保证 `noSuchMethod`
在每次调用之间返回稳定的值。

**Example:**

```dart tag=bad
import 'package:mockito/mockito.dart';

class Example {
  final int? _i;
  Example(this._i);
}

class MockExample extends Mock implements Example {}

void f(Example x) {
  if (x._i != null) {
    int i = x._i; // ERROR
  }
}
```

In this example, `_i` can't be promoted because it could
resolve to the unsound implicit `noSuchMethod` forwarder (also named `_i`) that
the compiler generates inside `MockExample`. 

在这个例子中，`_i` 不能被提升，
因为它可能解析到编译器在 `MockExample` 内部生成的、
不可靠的隐式 `noSuchMethod` 转发器（也叫 `_i`）。

The compiler creates this implicit implementation of `_i` because
`MockExample` promises to support a getter for `_i` when it implements
`Example` in its declaration, but doesn't fulfill that promise. 
So, the undefined getter implementation is handled by
[`Mock`'s `noSuchMethod` definition][], which
creates an implicit `noSuchMethod` forwarder of the same name.

编译器创建这个 `_i` 的隐式实现，是因为
`MockExample` 在声明中实现 `Example` 时
承诺支持 `_i` 的 getter，却没有兑现这个承诺。
于是，未定义的 getter 实现由
[`Mock` 的 `noSuchMethod` 定义][`Mock`'s `noSuchMethod` definition] 处理，
它创建了一个同名的隐式 `noSuchMethod` 转发器。

The failure can also occur between fields in
[unrelated classes](#note-about-unrelated-classes).

这种失败也可能发生在
[不相关类](#note-about-unrelated-classes) 的字段之间。

**Message:**

```plaintext
'_i' couldn't be promoted because there is a conflicting noSuchMethod forwarder in class 'MockExample'.
```

**Solution:**

Define the getter in question so that `noSuchMethod` doesn't have
to implicitly handle its implementation:

显式定义相关的 getter，
这样 `noSuchMethod` 就不必隐式处理它的实现：

<?code-excerpt "non_promotion/lib/non_promotion.dart (mock)" plaster="" replace="/late.*/[!$&!]/g; /MockingExample/Example/g; /f4/f/g;"?>
```dart tag=good
import 'package:mockito/mockito.dart';

class Example {
  final int? _i;
  Example(this._i);
}

class MockExample extends Mock implements Example {
  @override
  [!late final int? _i;!]
}

void f(Example x) {
  if (x._i != null) {
    int i = x._i; // OK
  }
}
```

The getter is declared `late` to be consistent with
how mocks are generally used; it's not necessary to
declare the getter `late` to solve this type promotion failure in
scenarios not involving mocks.

把 getter 声明为 `late` 是为了与 mock 的常见用法保持一致；
在不涉及 mock 的场景中，
解决这种类型提升失败并不必把 getter 声明为 `late`。

:::note
The example above uses [mocks]({{site.pub-pkg}}/mockito) simply because
`Mock` already contains a `noSuchMethod` definition,
so we don't have to define an arbitrary one
and can keep the example code short. 

We don't expect problems like this to arise very often in practice with mocks,
because usually mocks are declared
in a different library than the class they are mocking.
When the classes in question are declared in different libraries,
private names aren't forwarded to `noSuchMethod`
(because that would violate privacy expectations),
so it's still safe to promote the field.

上面的例子使用 [mock]({{site.pub-pkg}}/mockito)，
只是因为 `Mock` 已经包含 `noSuchMethod` 定义，
我们不必再定义一个任意的实现，
可以让示例代码保持简短。

我们不期望这类问题在使用 mock 的实践中经常出现，
因为 mock 通常声明在与被 mock 的类不同的库中。
当相关类声明在不同的库中时，
私有名称不会被转发到 `noSuchMethod`
（因为那会违反隐私预期），
所以提升该字段仍然是安全的。
:::

[nosuchmethod]: /language/extend#nosuchmethod
[`Mock`'s `noSuchMethod` definition]: {{site.pub-api}}/mockito/latest/mockito/Mock/noSuchMethod.html

### Possibly written after promotion {:#write}

### 提升后可能被写入

**The cause:**
You're trying to promote a variable that might have been
written to since it was promoted.

**原因：**
你试图提升一个变量，
但它在被提升之后可能又被写入过。

**Example:**

```dart tag=bad
void f(bool b, int? i, int? j) {
  if (i == null) return;
  if (b) {
    i = j;           // (1)
  }
  if (!b) {
    print(i.isEven); // (2) ERROR
  }
}
```

**Solution**:

In this example, when flow analysis hits (1),
it demotes `i` from non-nullable `int` back to nullable `int?`.
A human can tell that the access at (2) is safe
because there's no code path that includes both (1) and (2), but
flow analysis isn't smart enough to see that,
because it doesn't track correlations between
conditions in separate `if` statements.

在这个例子中，当流分析到达 (1) 时，
它把 `i` 从非空的 `int` 降级回可空的 `int?`。
人能看出 (2) 处的访问是安全的，
因为不存在同时包含 (1) 和 (2) 的代码路径，
但流分析还不够聪明，看不出这一点，
因为它不跟踪不同 `if` 语句中条件之间的关联。

You might fix the problem by combining the two `if` statements:

你可以把两个 `if` 语句合并来修复这个问题：

<?code-excerpt "non_promotion/lib/non_promotion.dart (write-combine-ifs)" replace="/else/[!$&!]/g"?>
```dart tag=good
void f(bool b, int? i, int? j) {
  if (i == null) return;
  if (b) {
    i = j;
  } [!else!] {
    print(i.isEven);
  }
}
```

In straight-line control flow cases like these (no loops),
flow analysis takes into account the right-hand side of the assignment
when deciding whether to demote.
As a result, another way to fix this code is
to change the type of `j` to `int`.

在这类直线控制流的情况下（没有循环），
流分析在决定是否降级时
会考虑赋值右侧的类型。
因此，修复这段代码的另一种方式
是把 `j` 的类型改为 `int`。

<?code-excerpt "non_promotion/lib/non_promotion.dart (write-change-type)" replace="/int j/[!$&!]/g"?>
```dart tag=good
void f(bool b, int? i, [!int j!]) {
  if (i == null) return;
  if (b) {
    i = j;
  }
  if (!b) {
    print(i.isEven);
  }
}
```

### Possibly written in a previous loop iteration {:#loop-or-switch}

### 可能在之前的循环迭代中被写入

**The cause:**
You're trying to promote something that
might have been written to in a previous iteration of a loop,
and so the promotion was invalidated.

**原因：**
你试图提升的东西
可能在循环的上一次迭代中被写入过，
因此提升已失效。

**Example:**

```dart tag=bad
void f(Link? p) {
  if (p != null) return;
  while (true) {    // (1)
    print(p.value); // (2) ERROR
    var next = p.next;
    if (next == null) break;
    p = next;       // (3)
  }
}
```

When flow analysis reaches (1),
it looks ahead and sees the write to `p` at (3).
But because it's looking ahead,
it hasn't yet figured out the type of the right-hand side of the assignment,
so it doesn't know whether it's safe to retain the promotion.
To be safe, it invalidates the promotion.

当流分析到达 (1) 时，
它向前看，发现了 (3) 处对 `p` 的写入。
但因为它是向前看的，
还没有弄清赋值右侧的类型，
所以不知道保留提升是否安全。
为保险起见，它使提升失效。

**Solution**:

You can fix this problem by moving the null check to the top of the loop:

把 null 检查移到循环顶部就能修复这个问题：

<?code-excerpt "non_promotion/lib/non_promotion.dart (loop)" replace="/p != null/[!$&!]/g"?>
```dart tag=good
void f(Link? p) {
  while ([!p != null!]) {
    print(p.value);
    p = p.next;
  }
}
```

This situation can also arise in `switch` statements if
a `case` block has a label,
because you can use labeled `switch` statements to construct loops:

如果 `case` 块带有标签，
这种情况也可能出现在 `switch` 语句中，
因为你可以用带标签的 `switch` 语句构造循环：

```dart tag=bad
void f(int i, int? j, int? k) {
  if (j == null) return;
  switch (i) {
    label:
    case 0:
      print(j.isEven); // ERROR
      j = k;
      continue label;
  }
}
```

Again, you can fix the problem by moving the null check to the top of the loop:

同样，把 null 检查移到循环顶部就能修复这个问题：

<?code-excerpt "non_promotion/lib/non_promotion.dart (switch-loop)" replace="/if .*/[!$&!]/g"?>
```dart tag=good
void f(int i, int? j, int? k) {
  switch (i) {
    label:
    case 0:
      [!if (j == null) return;!]
      print(j.isEven);
      j = k;
      continue label;
  }
}
```

### In catch after possible write in try {:#catch}

### try 中可能写入后进入 catch

**The cause:**
The variable might have been written to in a `try` block,
and execution is now in a `catch` block.

**原因：**
变量可能在 `try` 块中被写入过，
而现在执行到了 `catch` 块。

**Example:**

```dart tag=bad
void f(int? i, int? j) {
  if (i == null) return;
  try {
    i = j;                 // (1)
    // ... Additional code ...
    if (i == null) return; // (2)
    // ... Additional code ...
  } catch (e) {
    print(i.isEven);       // (3) ERROR
  }
}
```

In this case, flow analysis doesn't consider `i.isEven` (3) safe,
because it has no way of knowing when in the `try` block
the exception might have occurred,
so it conservatively assumes that it might have happened between (1) and (2),
when `i` was potentially `null`.

在这种情况下，流分析不认为 `i.isEven` (3) 是安全的，
因为它无法知道异常可能发生在 `try` 块中的哪个时刻，
所以保守地假设异常可能发生在 (1) 和 (2) 之间，
那时 `i` 可能是 `null`。

Similar situations can occur between `try` and `finally` blocks, and
between `catch` and `finally` blocks.
Because of a historical artifact of how the implementation was done,
these `try`/`catch`/`finally` situations don't take into account
the right-hand side of the assignment,
similar to what happens in loops.

类似的情况也可能发生在 `try` 和 `finally` 块之间，
以及 `catch` 和 `finally` 块之间。
由于实现方式的历史遗留问题，
这些 `try`/`catch`/`finally` 情况不考虑赋值右侧的类型，
与循环中的情况类似。

**Solution**:

To fix the problem, make sure that the `catch` block doesn't
rely on assumptions about the state of variables that get
changed inside the `try` block.
Remember, the exception might occur at any time during the `try` block,

要修复这个问题，请确保 `catch` 块
不依赖对在 `try` 块内被修改的变量状态的假设。
记住，异常可能在 `try` 块执行期间的任何时刻发生，
那时 `i` 可能是 `null`。
possibly when `i` is `null`.

The safest solution is to add a null check inside the `catch` block:

最安全的解决方案是在 `catch` 块内添加 null 检查：

<?code-excerpt "non_promotion/lib/non_promotion.dart (catch-null-check)" replace="/if.*/[!$&!]/g;/(} else {|  \/\/ H.*)/[!$&!]/g;/  }/  [!}!]/g"?>
```dart tag=good
try {
  // ···
} catch (e) {
  [!if (i != null) {!]
    print(i.isEven); // (3) OK due to the null check in the line above.
  [!} else {!]
  [!  // Handle the case where i is null.!]
  [!}!]
}
```

Or, if you're sure that an exception can't occur while `i` is `null`,
just use the `!` operator:

或者，如果你确定 `i` 为 `null` 时不可能发生异常，
直接使用 `!` 运算符：

<?code-excerpt "non_promotion/lib/non_promotion.dart (catch-bang)" replace="/i!/i[!!!]/g"?>
```dart
try {
  // ···
} catch (e) {
  print(i[!!!].isEven); // (3) OK because of the `!`.
}
```

### Subtype mismatch

### 子类型不匹配

**The cause:**
You're trying to promote to a type that isn't a subtype of
the variable's current promoted type
(or wasn't a subtype at the time of the promotion attempt).

**原因：**
你试图提升到的类型不是变量当前已提升类型的子类型
（或在尝试提升时不是其子类型）。

**Example:**

```dart tag=bad
void f(Object o) {
  if (o is Comparable /* (1) */ ) {
    if (o is Pattern /* (2) */ ) {
      print(o.matchAsPrefix('foo')); // (3) ERROR
    }
  }
}
```

In this example, `o` is promoted to `Comparable` at (1), but
it isn't promoted to `Pattern` at (2),
because `Pattern` isn't a subtype of `Comparable`.
(The rationale is that if it did promote,
then you wouldn't be able to use methods on `Comparable`.)
Note that just because `Pattern` isn't a subtype of `Comparable`
doesn't mean the code at (3) is dead;
`o` might have a type—like `String`—that 
implements both `Comparable` and `Pattern`.

在这个例子中，`o` 在 (1) 处被提升为 `Comparable`，
但在 (2) 处没有被提升为 `Pattern`，
因为 `Pattern` 不是 `Comparable` 的子类型。
（理由是：如果提升了，
你就无法使用 `Comparable` 上的方法了。）
注意，`Pattern` 不是 `Comparable` 的子类型，
并不意味着 (3) 处的代码是死代码；
`o` 可能具有同时实现 `Comparable` 和 `Pattern` 的类型，
比如 `String`。

**Solution**:

One possible solution is to create a new local variable so that
the original variable is promoted to `Comparable`, and
the new variable is promoted to `Pattern`:

一个可能的解决方案是创建一个新的局部变量，
让原变量提升为 `Comparable`，
新变量提升为 `Pattern`：

<?code-excerpt "non_promotion/lib/non_promotion.dart (subtype-variable)" replace="/Object o2.*/[!$&!]/g;/(o2)(\.| is)/[!$1!]$2/g"?>
```dart
void f(Object o) {
  if (o is Comparable /* (1) */ ) {
    [!Object o2 = o;!]
    if ([!o2!] is Pattern /* (2) */ ) {
      print(
        [!o2!].matchAsPrefix('foo'),
      ); // (3) OK; o2 was promoted to `Pattern`.
    }
  }
}
```

However, someone who edits the code later might be tempted to
change `Object o2` to `var o2`.
That change gives `o2` a type of `Comparable`,
which brings back the problem of the object not being promotable to `Pattern`.

然而，之后编辑代码的人可能忍不住
把 `Object o2` 改成 `var o2`。
这个改动会让 `o2` 的类型变成 `Comparable`，
从而重新带来对象无法提升为 `Pattern` 的问题。

A redundant type check might be a better solution:

冗余类型检查可能是更好的解决方案：

<?code-excerpt "non_promotion/lib/non_promotion.dart (subtype-redundant)" replace="/\(o as Pattern\)/[!$&!]/g"?>
```dart tag=good
void f(Object o) {
  if (o is Comparable /* (1) */ ) {
    if (o is Pattern /* (2) */ ) {
      print([!(o as Pattern)!].matchAsPrefix('foo')); // (3) OK
    }
  }
}
```

Another solution that sometimes works is when you can use a more precise type.
If line 3 cares only about strings,
then you can use `String` in your type check.
Because `String` is a subtype of `Comparable`, the promotion works:

另一种有时可行的方案是使用更精确的类型。
如果第 3 行只关心字符串，
那么可以在类型检查中使用 `String`。
因为 `String` 是 `Comparable` 的子类型，提升就能成功：

<?code-excerpt "non_promotion/lib/non_promotion.dart (subtype-string)" replace="/is String/is [!String!]/g"?>
```dart tag=good
void f(Object o) {
  if (o is Comparable /* (1) */ ) {
    if (o is [!String!] /* (2) */ ) {
      print(o.matchAsPrefix('foo')); // (3) OK
    }
  }
}
```


### Write captured by a local function {:#captured-local}

### 写入被局部函数捕获

**The cause:**
The variable has been write-captured by
a local function or function expression.

**原因：**
变量的写入被局部函数或函数表达式捕获了。

**Example:**

```dart tag=bad
void f(int? i, int? j) {
  var foo = () {
    i = j;
  };
  // ... Use foo ... 
  if (i == null) return; // (1)
  // ... Additional code ...
  print(i.isEven);       // (2) ERROR
}
```

Flow analysis reasons that as soon as the definition of `foo` is reached,
it might get called at any time,
therefore it's no longer safe to promote `i` at all.
As with loops, this demotion happens regardless of
the type of the right-hand side of the assignment.

流分析认为，一旦到达 `foo` 的定义，
它就可能随时被调用，
因此再提升 `i` 就不安全了。
与循环一样，无论赋值右侧是什么类型，
都会发生这种降级。

**Solution**:

Sometimes it's possible to restructure the logic so that
the promotion is before the write capture:

有时可以重构逻辑，
让提升发生在写入捕获之前：

<?code-excerpt "non_promotion/lib/non_promotion.dart (local-write-capture-reorder)" replace="/(  )((var foo|  i = j|\}\;|\/\/ ... Use foo).*)/$1[!$2!]/g"?>
```dart tag=good
void f(int? i, int? j) {
  if (i == null) return; // (1)
  // ... Additional code ...
  print(i.isEven); // (2) OK
  [!var foo = () {!]
  [!  i = j;!]
  [!};!]
  [!// ... Use foo ...!]
}
```

Another option is to create a local variable, so it isn't write captured:

另一个选择是创建局部变量，这样它就不会被写入捕获：

<?code-excerpt "non_promotion/lib/non_promotion.dart (local-write-capture-copy)" replace="/var i2.*/[!$&!]/g;/(i2)( ==|\.)/[!$1!]$2/g"?>
```dart tag=good
void f(int? i, int? j) {
  var foo = () {
    i = j;
  };
  // ... Use foo ...
  [!var i2 = i;!]
  if ([!i2!] == null) return; // (1)
  // ... Additional code ...
  print([!i2!].isEven); // (2) OK because `i2` isn't write captured.
}
```

Or you can do a redundant check:

或者你可以做冗余检查：

<?code-excerpt "non_promotion/lib/non_promotion.dart (local-write-capture-bang)" replace="/i!/i[!!!]/g"?>
```dart
void f(int? i, int? j) {
  var foo = () {
    i = j;
  };
  // ... Use foo ...
  if (i == null) return; // (1)
  // ... Additional code ...
  print(i[!!!].isEven); // (2) OK due to `!` check.
}
```


### Written outside of the current closure or function expression {:#write-outer}

### 在当前闭包或函数表达式之外被写入

**The cause:**
The variable is written to outside of a closure or function expression,
and the type promotion location is
inside the closure or function expression.

**原因：**
变量在闭包或函数表达式之外被写入，
而类型提升的位置在闭包或函数表达式之内。

**Example:**

```dart tag=bad
void f(int? i, int? j) {
  if (i == null) return;
  var foo = () {
    print(i.isEven); // (1) ERROR
  };
  i = j;             // (2)
}
```

Flow analysis reasons that there's no way to determine
when `foo` might get called,
so it might get called after the assignment at (2),
and thus the promotion might no longer be valid.
As with loops, this demotion happens regardless of the type of
the right-hand side of the assignment.

流分析认为无法确定 `foo` 何时可能被调用，
所以它可能在 (2) 处的赋值之后被调用，
因此提升可能不再有效。
与循环一样，无论赋值右侧是什么类型，
都会发生这种降级。

**Solution**:

A solution is to create a local variable:

一个解决方案是创建局部变量：

<?code-excerpt "non_promotion/lib/non_promotion.dart (closure-new-var)" replace="/var i2.*/[!$&!]/g;/i2\./[!i2!]./g"?>
```dart tag=good
void f(int? i, int? j) {
  if (i == null) return;
  [!var i2 = i;!]
  var foo = () {
    print([!i2!].isEven); // (1) OK because `i2` isn't changed later.
  };
  i = j; // (2)
}
```

**Example:**

A particularly nasty case looks like this:

一个特别棘手的案例是这样的：

```dart tag=bad
void f(int? i) {
  i ??= 0;
  var foo = () {
    print(i.isEven); // ERROR
  };
}
```

In this case, a human can see that the promotion is safe because
the only write to `i` uses a non-null value and
happens before `foo` is ever created.
But [flow analysis isn't that smart][1536].

在这种情况下，人能看出提升是安全的，
因为对 `i` 的唯一写入使用的是非 null 值，
并且发生在 `foo` 创建之前。
但 [流分析没那么聪明][1536]。

[1536]: {{site.repo.dart.lang}}/issues/1536

**Solution**:

Again, a solution is to create a local variable:

同样，一个解决方案是创建局部变量：

<?code-excerpt "non_promotion/lib/non_promotion.dart (closure-new-var2)" replace="/var j.*/[!$&!]/g;/j\./[!j!]./g"?>
```dart tag=good
void f(int? i) {
  [!var j = i ?? 0;!]
  var foo = () {
    print([!j!].isEven); // OK
  };
}
```

This solution works because `j` is inferred to have a non-nullable type (`int`)
due to its initial value (`i ?? 0`).
Because `j` has a non-nullable type,
whether or not it's assigned later,
`j` can never have a non-null value.

这个方案可行，是因为 `j` 的初始值（`i ?? 0`）
让它被推断为非空类型（`int`）。
因为 `j` 是非空类型，
无论之后是否被赋值，
`j` 都不可能是 null 值。


### Write captured outside of the current closure or function expression {:#captured-outer}

### 写入在当前闭包或函数表达式之外被捕获

**The cause:**
The variable you're trying to promote is write captured
outside of a closure or function expression,
but this use of the variable is inside of the closure or function expression
that's trying to promote it.

**原因：**
你试图提升的变量，
其写入在闭包或函数表达式之外被捕获，
而对该变量的这次使用，
位于试图提升它的闭包或函数表达式之内。

**Example:**

```dart tag=bad
void f(int? i, int? j) {
  var foo = () {
    if (i == null) return;
    print(i.isEven); // ERROR
  };
  var bar = () {
    i = j;
  };
}
```

Flow analysis reasons that there's no way of telling
what order `foo` and `bar` might be executed in;
in fact, `bar` might even get executed halfway through executing `foo`
(due to `foo` calling something that calls `bar`).
So it isn't safe to promote `i` at all inside `foo`.

流分析认为无法判断 `foo` 和 `bar` 的执行顺序；
事实上，`bar` 甚至可能在 `foo` 执行到一半时被执行
（因为 `foo` 调用了某个会调用 `bar` 的东西）。
所以在 `foo` 内部提升 `i` 完全是不安全的。

**Solution**:

The best solution is probably to create a local variable:

最好的解决方案大概是创建局部变量：

<?code-excerpt "non_promotion/lib/non_promotion.dart (closure-write-capture)" replace="/var i2.*/[!$&!]/g;/(i2)( ==|\.)/[!i2!]$2/g"?>
```dart tag=good
void f(int? i, int? j) {
  var foo = () {
    [!var i2 = i;!]
    if ([!i2!] == null) return;
    print([!i2!].isEven); // OK because i2 is local to this closure.
  };
  var bar = () {
    i = j;
  };
}
```

### Promotion lost across an `await` or `yield` {:#suspension}

### 提升在 `await` 或 `yield` 之后丢失

**The cause:**
Flow analysis drops type promotion when execution suspends
across an `await` expression or `yield` statement.

**原因：**
当执行跨越 `await` 表达式或 `yield` 语句挂起时，
流分析会丢弃类型提升。

For this promotion failure to occur,
the following conditions must be met:

要发生这种提升失败，
必须满足以下条件：

1. A function or method contains a write to a local variable or parameter.

   函数或方法包含对局部变量或参数的写入。
1. That function contains an inner function or closure
   that promotes the variable.

   该函数包含一个提升该变量的内部函数或闭包。
1. The inner function suspends itself using `await` or `yield`,
   letting the outer function continue execution.

   内部函数用 `await` 或 `yield` 挂起自己，
   让外部函数继续执行。
1. The inner function attempts to use the local variable again
   after the suspension.

   内部函数在挂起之后试图再次使用该局部变量。

In earlier SDK releases, using the local variable after the suspension
retained its promoted type.
However, that behavior was unsound:
while the inner function is suspended,
the outer function can continue running and modify the variable's value.
Starting in Dart 3.13, to guarantee soundness,
flow analysis drops the promotion when the inner function suspends.

在较早的 SDK 版本中，挂起之后使用该局部变量
仍保留其提升后的类型。
然而，那种行为是不可靠的：
内部函数挂起期间，
外部函数可以继续运行并修改变量的值。
从 Dart 3.13 开始，为保证可靠性，
流分析在内部函数挂起时丢弃提升。

**Example:**

The compiler drops a promotion across suspension points,
even if it's clear that retaining the promotion is safe.

编译器会丢弃跨越挂起点的提升，
即使保留提升显然是安全的。

```dart tag=bad
import 'dart:async';

Future<void> example(String? extraInfo) async {
  extraInfo ??= 'No extra info'; // (1)
  unawaited(() async {
    log('Doing some asynchronous task...');
    log(extraInfo!);
    await longTask(); // (2)
    log('Done!');
    log(extraInfo); // (3) ERROR
  }());
}

Future<void> longTask() async {
  await Future<void>.delayed(const Duration(seconds: 10));
}

void log(String s) {
  print(s);
}
```

In this example, assigning a value to `extraInfo` at `(1)`
means it isn't effectively final.
Flow analysis conservatively assumes
that any modified variable captured by a closure
might change while the closure is suspended at `(2)`,
even though the assignment at `(1)` always happens before the closure runs.
To ensure soundness, flow analysis drops the promotion.
As a result, at `(3)`, `extraInfo` demotes back to `String?`,
which isn't compatible with `log(String s)` and produces a compile-time error.

在这个例子中，在 `(1)` 处给 `extraInfo` 赋值
意味着它不是有效 final 的。
流分析保守地假设，
被闭包捕获的任何被修改过的变量，
都可能在闭包于 `(2)` 处挂起期间发生变化，
尽管 `(1)` 处的赋值总是发生在闭包运行之前。
为确保可靠性，流分析丢弃提升。
结果在 `(3)` 处，`extraInfo` 降级回 `String?`，
它与 `log(String s)` 不兼容，产生编译时错误。

**Message:**

When this situation occurs, the compiler or analyzer emits
an error and context message:

出现这种情况时，编译器或分析器会发出
错误和上下文消息：

```plaintext
example.dart:10:9: Error: The argument type 'String?' can't be assigned to the parameter type 'String'.
    log(extraInfo);
        ^
example.dart:8:5: Context: Variable 'extraInfo' could not be promoted due to an 'await' or 'yield'.
Try checking the type of the variable after the 'await' or 'yield'.  See http://dart.dev/go/non-promo-suspension
    await longTask();
    ^
```

**Solution:**

To fix this compile-time error,
re-verify the variable's non-null type, add an explicit null check,
or use a not-null assertion (`!`) after the suspension point:

要修复这个编译时错误，
请在挂起点之后重新验证变量的非空类型、
添加显式的 null 检查，
或使用非空断言（`!`）：

<?code-excerpt "non_promotion/lib/non_promotion.dart (suspension)" plaster="" replace="/(Done!'\);\n +log\()extraInfo!/$1[!extraInfo!!]/g"?>
```dart tag=good
import 'dart:async';

Future<void> example(String? extraInfo) async {
  extraInfo ??= 'No extra info';
  unawaited(() async {
    log('Doing some asynchronous task...');
    log(extraInfo!);
    await longTask();
    log('Done!');
    log([!extraInfo!!]);
  }());
}

Future<void> longTask() async {
  await Future<void>.delayed(const Duration(seconds: 10));
}

void log(String s) {
  print(s);
}
```

Alternatively, assign the variable to a `final` local variable
prior to suspension,
or re-check `extraInfo != null` after the `await` expression.

或者，在挂起之前把变量赋给一个 `final` 局部变量，
或在 `await` 表达式之后重新检查 `extraInfo != null`。

[language version]: /language/versioning
