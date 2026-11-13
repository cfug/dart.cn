---
# title: Numbers in Dart
title: Dart 中的数字
# breadcrumb: Numbers
breadcrumb: 数字
# description: >-
#   Learn how Dart numbers are slightly different on the web,
#   when that might matter, and how you might adjust your code.
description: >-
  了解 Dart 的数字在 Web 上有哪些细微差别、
  这些差别何时重要，以及如何调整代码。
ai-translated: true
---

Dart apps often target multiple platforms.
For example, a Flutter app might target iOS, Android, and the web.
The code can be the same,
as long as the app doesn't rely on platform-specific libraries
or use numbers in a way that's platform dependent.

Dart 应用常常面向多个平台。
例如，一个 Flutter 应用可能同时面向 iOS、Android 和 Web。
只要应用不依赖特定平台的库，
也不以依赖平台的方式使用数字，代码就可以相同。

This page has details about the differences
between native and web number implementations,
and how to write code so that those differences don't matter.

本页详细说明原生实现与 Web 实现在数字上的差异，
以及如何编写代码，让这些差异变得无关紧要。

:::secondary Number implementations in Dart and other languages
Dart has always allowed platform-specific representations
and semantics for numbers, for reasons of 
performance, code size, and platform interoperability.

Similarly, in C/C++ the commonly used `int` type for integer values is
platform-specific to best map to the native machine architecture
(16-, 32-, or 64-bit).
In Java, the `float` and `double` types for fractional values
were originally designed to strictly follow IEEE 754 on all platforms,
but this constraint was loosened almost immediately for efficiency reasons
(`strictfp` is required for exact coherence).

:::secondary Dart 与其他语言中的数字实现
出于性能、代码体积和平台互操作的考虑，
Dart 一直允许数字使用特定平台的表示和语义。

类似地，C/C++ 中常用的整数类型 `int`
是特定于平台的，以便更好地映射到本机架构
（16 位、32 位或 64 位）。
在 Java 中，表示小数的 `float` 和 `double` 类型
最初被设计为在所有平台上严格遵循 IEEE 754，
但出于效率考虑，这一约束几乎立刻就被放宽了
（要完全一致，需要 `strictfp`）。
:::


## Dart number representation

## Dart 的数字表示

In Dart, all numbers are part of the common `Object` type hierarchy,
and there are two concrete, user-visible numeric types:
`int`, representing integer values, and `double`, representing fractional values.

在 Dart 中，所有数字都属于共同的 `Object` 类型层次，
并且有两种具体的、用户可见的数值类型：
表示整数值的 `int`，以及表示小数值的 `double`。

<img 
  src="/assets/img/number-class-hierarchy.svg" 
  alt="Object is the parent of num, which is the parent of int and double">

Depending on the platform,
those numeric types have different, hidden implementations.
In particular, Dart has two very different types of targets it compiles to:

这些数值类型会因平台而有不同的、隐藏的实现。
具体来说，Dart 会编译到两类差别很大的目标：

* **Native:** Most often, a 64-bit mobile or desktop processor.

  **原生：** 最常见的是 64 位移动或桌面处理器。

* **Web:** JavaScript as the primary execution engine.

  **Web：** 以 JavaScript 作为主要执行引擎。

The following table shows how Dart numbers are usually implemented:

下表展示 Dart 数字通常如何实现：

<div class="table-wrapper">
  <table class="table table-striped nowrap">
    <tr>
      <th><t>Representation</t><t>表示</t></th>
      <th><t>Native <code>int</code></t><t>原生 <code>int</code></t></th>
      <th><t>Native <code>double</code></t><t>原生 <code>double</code></t></th>
      <th><t>Web <code>int</code></t><t>Web <code>int</code></t></th>
      <th><t>Web <code>double</code></t><t>Web <code>double</code></t></th>
    </tr>
    <tr>
      <td><a href="https://en.wikipedia.org/wiki/Two%27s_complement">
        64-bit signed two's complement</a>
      </td>
      <td>✅</td>
      <td></td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td><a href="https://en.wikipedia.org/wiki/Two%27s_complement">
        64 位有符号补码</a>
      </td>
      <td>✅</td>
      <td></td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td>
        <a href="https://en.wikipedia.org/wiki/Double-precision_floating-point_format">64-bit floating point</a>
      </td>
      <td></td>
      <td>✅</td>
      <td>✅</td>
      <td>✅</td>
    </tr>
    <tr>
      <td>
        <a href="https://en.wikipedia.org/wiki/Double-precision_floating-point_format">64 位浮点数</a>
      </td>
      <td></td>
      <td>✅</td>
      <td>✅</td>
      <td>✅</td>
    </tr>
  </table>
</div>

For native targets, you can assume that
`int` maps to a signed 64-bit integer representation and
`double` maps to a 64-bit IEEE floating-point representation
that matches the underlying processor.

对于原生目标，可以认为
`int` 映射到有符号 64 位整数表示，
`double` 映射到与底层处理器一致的 64 位 IEEE 浮点表示。

But on the web, where Dart compiles to and interoperates with JavaScript,
there is a single numeric representation:
a 64-bit double-precision floating-point value.
For efficiency, Dart maps both `int` and `double` to this single representation.
The visible type hierarchy remains the same,
but the underlying hidden implementation types are
different and intertwined.

但在 Web 上，Dart 编译到 JavaScript 并与之互操作，
数字只有一种表示：
64 位双精度浮点值。
为了效率，Dart 把 `int` 和 `double` 都映射到这一种表示。
可见的类型层次保持不变，
但底层隐藏的实现类型不同，而且彼此交织。

The following figure illustrates the platform-specific types (in blue)
for native and web targets.
As the figure shows,
the concrete type for `int` on native implements only the `int` interface.
However, the concrete type for `int` on the web implements
both `int` and `double`.

下图说明原生目标和 Web 目标上特定于平台的类型（图中为蓝色）。
如图所示，
原生平台上 `int` 的具体类型只实现 `int` 接口。
而 Web 上 `int` 的具体类型同时实现
`int` 和 `double`。

<img 
  src="/assets/img/number-platform-specific.svg" 
  alt="Implementation classes vary by platform; for JavaScript, the class that implements int also implements double">


:::note
Dart represents `int` and `double` in
a few different ways for efficiency,
but these implementation classes (in blue, above) are hidden.
In general, you can ignore the platform-specific types,
and think of `int` and `double` as concrete types. 

出于效率考虑，Dart 用几种不同方式表示 `int` 和 `double`，
但这些实现类（上图中的蓝色）是隐藏的。
一般来说，你可以忽略特定于平台的类型，
把 `int` 和 `double` 当作具体类型来看待。
:::

An `int` on the web is represented as
a double-precision floating-point value with no fractional part.
In practice, this works pretty well:
double-precision floating point provides 53 bits of integer precision.
However, `int` values are always also `double` values,
which can lead to some surprises.

Web 上的 `int` 表示为没有小数部分的双精度浮点值。
实践中这通常够用：
双精度浮点提供 53 位整数精度。
不过，`int` 值同时也总是 `double` 值，
这可能会带来一些意外。


## Differences in behavior

## 行为差异

Most integer and double arithmetic
has essentially the same behavior.
There are, however, important differences—particularly 
when your code has strict expectations about
precision, string formatting, or underlying runtime types.

大多数整数和双精度浮点运算
的行为基本相同。
不过也有重要差异，尤其是当你的代码对
精度、字符串格式或底层运行时类型有严格预期时。

When arithmetic results differ, as described in this section,
the behavior is **platform specific**
and **subject to change**.

当运算结果出现本节所述的差异时，
这种行为是 **平台相关** 的，
并且 **可能变化**。

:::note
Any platform-specific behavior that this page describes might change to be
less surprising, more consistent, or more performant.

本页描述的任何特定于平台的行为，
都可能变得更符合直觉、更一致，或性能更好。
:::


### Precision

### 精度

The following table demonstrates how some numerical expressions
differ due to precision.
Here, `math` represents the `dart:math` library,
and `math.pow(2, 53)` is 2<sup>53</sup>.

下表展示一些数值表达式如何因精度而不同。
这里的 `math` 表示 `dart:math` 库，
`math.pow(2, 53)` 是 2<sup>53</sup>。

On the web, integers lose precision past 53 bits.
In particular, 2<sup>53</sup> and 2<sup>53</sup>+1
map to the same value due to truncation.
On native, these values can still be differentiated
because native numbers have 64 bits—63 bits for the value and 1 for the sign.

在 Web 上，整数超过 53 位后会丢失精度。
具体来说，2<sup>53</sup> 和 2<sup>53</sup>+1
会因截断而映射到同一个值。
在原生平台上，这些值仍然可以区分，
因为原生数字有 64 位：63 位表示数值，1 位表示符号。

The effect of overflow is visible
when comparing 2<sup>63</sup>-1 to 2<sup>63</sup>.
On native, the latter overflows to -2<sup>63</sup>,
as expected for two's-complement arithmetic.
On the web, these values do not overflow
because they are represented differently;
they're approximations due to the loss of precision.

比较 2<sup>63</sup>-1 和 2<sup>63</sup> 时，
可以看出溢出的影响。
在原生平台上，后者会溢出为 -2<sup>63</sup>，
这符合补码运算的预期。
在 Web 上，这些值不会溢出，
因为它们的表示不同；
它们是精度损失后的近似值。

<div class="table-wrapper">
  <table class="table table-striped nowrap">
    <tr>
      <th><t>Expression</t><t>表达式</t></th>
      <th><t>Native</t><t>原生</t></th>
      <th><t>Web</t><t>Web</t></th>
    </tr>
    <tr>
      <td><code>math.pow(2, 53) - 1</code></td>
      <td><code>9007199254740991</code></td>
      <td><code>9007199254740991</code></td>
    </tr>
    <tr>
      <td><code>math.pow(2, 53)</code></td>
      <td><code>9007199254740992</code></td>
      <td><code>9007199254740992</code></td>
    </tr>
    <tr>
      <td><code>math.pow(2, 53) + 1</code></td>
      <td><code>9007199254740993</code></td>
      <td><code>9007199254740992</code></td>
    </tr>
    <tr>
      <td><code>math.pow(2, 62)</code></td>
      <td><code>4611686018427387904</code></td>
      <td><code>4611686018427388000</code></td>
    </tr>
    <tr>
      <td><code>math.pow(2, 63) - 1</code></td>
      <td><code>9223372036854775807</code></td>
      <td><code>9223372036854776000</code></td>
    </tr>
    <tr>
      <td><code>math.pow(2, 63)</code></td>
      <td><code>-9223372036854775808</code></td>
      <td><code>9223372036854776000</code></td>
    </tr>
    <tr>
      <td><code>math.pow(2, 64)</code></td>
      <td><code>0</code></td>
      <td><code>18446744073709552000</code></td>
    </tr>
  </table>
</div>

### Identity

### 同一性

On native platforms, `double` and `int` are distinct types:
no value can be both a `double` and an `int` at the same time.
On the web, that isn't true.
Because of this difference,
identity can differ between platforms,
although equality (`==`) doesn't.

在原生平台上，`double` 和 `int` 是不同的类型：
没有任何值可以同时既是 `double` 又是 `int`。
在 Web 上并非如此。
由于这一差异，
不同平台上的同一性可能不同，
尽管相等（`==`）不会。

The following table shows some expressions that use equality and identity.
The equality expressions are the same on native and web;
the identity expressions are usually different.

下表展示一些使用相等和同一性的表达式。
相等表达式在原生平台和 Web 上结果相同；
同一性表达式通常不同。

<div class="table-wrapper">
  <table class="table table-striped nowrap">
    <tr>
      <th><t>Expression</t><t>表达式</t></th>
      <th><t>Native</t><t>原生</t></th>
      <th><t>Web</t><t>Web</t></th>
    </tr>
    <tr>
      <td><code>1.0 == 1</code></td>
      <td><code>true</code></td>
      <td><code>true</code></td>
    </tr>
    <tr>
      <td><code>identical(1.0, 1)</code></td>
      <td><code>false</code></td>
      <td><code>true</code></td>
    </tr>
    <tr>
      <td><code>0.0 == -0.0</code></td>
      <td><code>true</code></td>
      <td><code>true</code></td>
    </tr>
    <tr>
      <td><code>identical(0.0, -0.0)</code></td>
      <td><code>false</code></td>
      <td><code>true</code></td>
    </tr>
    <tr>
      <td><code>double.nan == double.nan</code></td>
      <td><code>false</code></td>
      <td><code>false</code></td>
    </tr>
    <tr>
      <td><code>identical(double.nan, double.nan)</code></td>
      <td><code>true</code></td>
      <td><code>false</code></td>
    </tr>
    <tr>
      <td><code>double.infinity == double.infinity</code></td>
      <td><code>true</code></td>
      <td><code>true</code></td>
    </tr>
    <tr>
      <td><code>identical(double.infinity, double.infinity)</code></td>
      <td><code>true</code></td>
      <td><code>true</code></td>
    </tr>
  </table>
</div>

### Types and type checking

### 类型与类型检查

On the web, the underlying `int` type is like a subtype of `double`:
it's a double-precision value without a fractional part.
In fact, a type check on the web of the form `x is int`
returns true if `x` is a number (`double`) with
a zero-valued fractional part.

在 Web 上，底层的 `int` 类型就像 `double` 的子类型：
它是没有小数部分的双精度值。
事实上，Web 上形如 `x is int` 的类型检查，
在 `x` 是小数部分为零的数字（`double`）时会返回 true。

As a result, the following are true on the web:

因此，下面这些在 Web 上成立：

* All Dart numbers (values of type `num`) are `double`.

  所有 Dart 数字（类型为 `num` 的值）都是 `double`。

* A Dart number can be both a `double` and an `int` at the same time.

  一个 Dart 数字可以同时既是 `double` 又是 `int`。

These facts affect `is` checks and `runtimeType` properties.
A side effect is that `double.infinity` is interpreted as an `int`.
Because this is a platform-specific behavior,
it might change in the future.

这些事实会影响 `is` 检查和 `runtimeType` 属性。
一个副作用是 `double.infinity` 会被解释为 `int`。
因为这是特定于平台的行为，
将来可能会改变。

<div class="table-wrapper">
  <table class="table table-striped nowrap">
    <tr>
      <th><t>Expression</t><t>表达式</t></th>
      <th><t>Native</t><t>原生</t></th>
      <th><t>Web</t><t>Web</t></th>
    </tr>
    <tr>
      <td><code>1 is int</code></td>
      <td><code>true</code></td>
      <td><code>true</code></td>
    </tr>
    <tr>
      <td><code>1 is double</code></td>
      <td><code>false</code></td>
      <td><code>true</code></td>
    </tr>
    <tr>
      <td><code>1.0 is int</code></td>
      <td><code>false</code></td>
      <td><code>true</code></td>
    </tr>
    <tr>
      <td><code>1.0 is double</code></td>
      <td><code>true</code></td>
      <td><code>true</code></td>
    </tr>
    <tr>
      <td><code>(0.5 + 0.5) is int</code></td>
      <td><code>false</code></td>
      <td><code>true</code></td>
    </tr>
    <tr>
      <td><code>(0.5 + 0.5) is double</code></td>
      <td><code>true</code></td>
      <td><code>true</code></td>
    </tr>
    <tr>
      <td><code>3.14 is int</code></td>
      <td><code>false</code></td>
      <td><code>false</code></td>
    </tr>
    <tr>
      <td><code>3.14 is double</code></td>
      <td><code>true</code></td>
      <td><code>true</code></td>
    </tr>
    <tr>
      <td><code>double.infinity is int</code></td>
      <td><code>false</code></td>
      <td><code>true</code></td>
    </tr>
    <tr>
      <td><code>double.nan is int</code></td>
      <td><code>false</code></td>
      <td><code>false</code></td>
    </tr>
    <tr>
      <td><code>1.0.runtimeType</code></td>
      <td><code>double</code></td>
      <td><code>int</code></td>
    </tr>
    <tr>
      <td><code>1.runtimeType</code></td>
      <td><code>int</code></td>
      <td><code>int</code></td>
    </tr>
    <tr>
      <td><code>1.5.runtimeType</code></td>
      <td><code>double</code></td>
      <td><code>double</code></td>
    </tr>
  </table>
</div>

### Bitwise operations

### 按位运算

For performance reasons on the web,
bitwise (`&`, `|`, `^`, `~`) and shift (`<<`,`>>`, `>>>`) operators on `int`
use the native JavaScript equivalents.
In JavaScript, the operands are truncated to 32-bit integers
that are treated as unsigned.
This treatment can lead to surprising results on larger numbers.
In particular, if operands are negative or don't fit into 32 bits,
they're likely to produce different results between native and web.

出于 Web 上的性能考虑，
`int` 上的按位运算符（`&`、`|`、`^`、`~`）和移位运算符（`<<`、`>>`、`>>>`）
使用 JavaScript 原生的对应运算。
在 JavaScript 中，操作数会被截断为当作无符号数处理的 32 位整数。
这种处理在更大的数字上可能导致意外结果。
尤其是当操作数为负数或放不进 32 位时，
原生平台和 Web 上很可能得到不同的结果。

The following table shows how native and web platforms
treat bitwise and shift operators when the operands
are either negative or close to 32 bits:

下表展示当操作数为负数或接近 32 位时，
原生平台和 Web 平台如何处理按位运算符和移位运算符：

<div class="table-wrapper">
  <table class="table table-striped nowrap">
    <tr>
      <th><t>Expression</t><t>表达式</t></th>
      <th><t>Native</t><t>原生</t></th>
      <th><t>Web</t><t>Web</t></th>
    </tr>
    <tr>
      <td><code>-1 >> 0</code></td>
      <td><code>-1</code></td>
      <td><code>4294967295</code></td>
    </tr>
    <tr>
      <td><code>-1 ^ 2</code></td>
      <td><code>-3</code></td>
      <td><code>4294967293</code></td>
    </tr>
    <tr>
      <td><code>math.pow(2, 32).toInt()</code></td>
      <td><code>4294967296</code></td>
      <td><code>4294967296</code></td>
    </tr>
    <tr>
      <td><code>math.pow(2, 32).toInt() >> 1</code></td>
      <td><code>2147483648</code></td>
      <td><code>0</code></td>
    </tr>
    <tr>
      <td><code>(math.pow(2, 32).toInt()-1) >> 1</code></td>
      <td><code>2147483647</code></td>
      <td><code>2147483647</code></td>
    </tr>
  </table>
</div>

### String representation

### 字符串表示

On the web, Dart generally defers to JavaScript to convert a number to a string
(for example, for a `print`).
The following table demonstrates how
converting the expressions in the first column can lead to different results.

在 Web 上，Dart 通常把数字转成字符串的工作交给 JavaScript
（例如 `print`）。
下表展示把第一列的表达式转换成字符串时，
如何得到不同的结果。

<div class="table-wrapper">
  <table class="table table-striped nowrap">
    <tr>
      <th><t>Expression</t><t>表达式</t></th>
      <th><t>Native <code>toString()</code></t><t>原生 <code>toString()</code></t></th>
      <th><t>Web <code>toString()</code></t><t>Web <code>toString()</code></t></th>
    </tr>
    <tr>
      <td><code>1</code></td>
      <td><code>"1"</code></td>
      <td><code>"1"</code></td>
    </tr>
    <tr>
      <td><code>1.0</code></td>
      <td><code>"1.0"</code></td>
      <td><code>"1"</code></td>
    </tr>
    <tr>
      <td><code>(0.5 + 0.5)</code></td>
      <td><code>"1.0"</code></td>
      <td><code>"1"</code></td>
    </tr>
    <tr>
      <td><code>1.5</code></td>
      <td><code>"1.5"</code></td>
      <td><code>"1.5"</code></td>
    </tr>
    <tr>
      <td><code>-0</code></td>
      <td><code>"0"</code></td>
      <td><code>"-0.0"</code></td>
    </tr>
    <tr>
      <td><code>math.pow(2, 0)</code></td>
      <td><code>"1"</code></td>
      <td><code>"1"</code></td>
    </tr>
    <tr>
      <td><code>math.pow(2, 80)</code></td>
      <td><code>"0"</code></td>
      <td><code>"1.2089258196146292e+24"</code></td>
    </tr>
  </table>
</div>

## What should you do?

## 你应该怎么做？

Usually, you don't need to change your numeric code.
Dart code has been running on both native and web platforms for years,
and number implementation differences are rarely a problem.
Common, typical code—such as iterating through a range of small integers 
and indexing a list—behaves the same.

通常你不需要修改数值相关的代码。
Dart 代码已经在原生平台和 Web 平台上运行了很多年，
数字实现上的差异很少成为问题。
常见、典型的代码，例如遍历一小段整数并按下标访问列表，
行为是一样的。

If you have tests or assertions that compare string results,
write them in a platform-resilient manner.
For example, suppose you're testing the value of string expressions
that have embedded numbers:

如果你的测试或断言会比较字符串结果，
请用能适应不同平台的方式来写。
例如，假设你在测试嵌入了数字的字符串表达式的值：

```dart
void main() {
  var count = 10.0 * 2;
  var message = "$count cows";
  if (message != "20.0 cows") throw Exception("Unexpected: $message");
}
```

The preceding code succeeds on native platforms but throws on the web
because `message` is `"20 cows"` (no decimal) on the web.
As an alternative, you might write the condition as follows,
so it passes on both native and web platforms:

前面这段代码在原生平台上会成功，但在 Web 上会抛出异常，
因为 Web 上的 `message` 是 `"20 cows"`（没有小数）。
作为替代，你可以这样写条件，
让它在原生平台和 Web 上都能通过：

```dart
if (message != "${20.0} cows") throw ... 
```

For bit manipulation, consider explicitly operating on 32-bit chunks,
which are consistent on all platforms.
To force a signed interpretation of a 32-bit chunk,
use `int.toSigned(32)`.

对于位操作，可以考虑显式地按 32 位的块来运算，
这在所有平台上都是一致的。
要强制把一个 32 位块按有符号数解释，
请使用 `int.toSigned(32)`。

For other cases where precision matters,
consider other numeric types.
The [`BigInt`][] type
provides arbitrary-precision integers on both native and web.
The [`fixnum`][] package
provides strict 64-bit signed numbers, even on the web.
Use these types with care, though:
they often result in significantly bigger and slower code.

对于其他精度重要的情况，
可以考虑其他数值类型。
[`BigInt`][] 类型
在原生平台和 Web 上都提供任意精度整数。
[`fixnum`][] package
即使在 Web 上也提供严格的 64 位有符号数。
不过使用这些类型要小心：
它们常常会让代码明显更大、更慢。

[`BigInt`]: {{site.dart-api}}/dart-core/BigInt-class.html
[`fixnum`]: {{site.pub-pkg}}/fixnum
