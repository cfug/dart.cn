---
# title: dart:math
title: dart:math
# description: Learn about the major features in Dart's dart:math library.
description: 了解 Dart dart:math 库的主要功能。
prevpage:
  url: /libraries/dart-async
# title: dart:async
  title: dart:async
nextpage:
  url: /libraries/dart-convert
# title: dart:convert
  title: dart:convert
ai-translated: true
---

<?code-excerpt replace="/ *\/\/\s+ignore_for_file:[^\n]+\n//g; /(^|\n) *\/\/\s+ignore:[^\n]+\n/$1/g; /(\n[^\n]+) *\/\/\s+ignore:[^\n]+\n/$1\n/g"?>
<?code-excerpt plaster="none"?>

The dart:math library ([API reference][dart:math])
provides common functionality such as sine and cosine,
maximum and minimum, and constants such as *pi* and *e*. Most of the
functionality in the Math library is implemented as top-level functions.

dart:math 库（[API 参考][dart:math]）
提供正弦、余弦、最大值、最小值等常用功能，
以及 **pi**、**e** 等常量。
Math 库中的大部分功能都实现为顶层函数。

To use this library in your app, import dart:math.

要在应用中使用这个库，请导入 dart:math。

<?code-excerpt "misc/test/library_tour/math_test.dart (import)"?>
```dart
import 'dart:math';
```


## Trigonometry

## 三角函数

The Math library provides basic trigonometric functions:

Math 库提供基本的三角函数：

<?code-excerpt "misc/test/library_tour/math_test.dart (trig)"?>
```dart
// Cosine
assert(cos(pi) == -1.0);

// Sine
var degrees = 30;
var radians = degrees * (pi / 180);
// radians is now 0.52359.
var sinOf30degrees = sin(radians);
// sin 30° = 0.5
assert((sinOf30degrees - 0.5).abs() < 0.01);
```

:::note
These functions use radians, not degrees!

这些函数使用弧度，而不是角度！
:::


## Maximum and minimum

## 最大值和最小值

The Math library provides `max()` and `min()` methods:

Math 库提供 `max()` 和 `min()` 方法：

<?code-excerpt "misc/test/library_tour/math_test.dart (min-max)"?>
```dart
assert(max(1, 1000) == 1000);
assert(min(1, -1000) == -1000);
```


## Math constants

## 数学常量

Find your favorite constants—*pi*, *e*, and more—in the Math library:

在 Math 库中可以找到常用常量，例如 **pi**、**e** 等：

<?code-excerpt "misc/test/library_tour/math_test.dart (constants)"?>
```dart
// See the Math library for additional constants.
print(e); // 2.718281828459045
print(pi); // 3.141592653589793
print(sqrt2); // 1.4142135623730951
```


## Random numbers

## 随机数

Generate random numbers with the [Random][] class. You can
optionally provide a seed to the Random constructor.

使用 [Random][Random] 类生成随机数。
你也可以向 Random 构造函数提供一个种子。

<?code-excerpt "misc/test/library_tour/math_test.dart (random)"?>
```dart
var random = Random();
random.nextDouble(); // Between 0.0 and 1.0: [0, 1)
random.nextInt(10); // Between 0 and 9.
```

You can even generate random booleans:

你还可以生成随机布尔值：

<?code-excerpt "misc/test/library_tour/math_test.dart (random-bool)"?>
```dart
var random = Random();
random.nextBool(); // true or false
```

:::warning
The default implementation of `Random` supplies a stream of pseudorandom bits
that are unsuitable for cryptographic purposes.
To create a cryptographically secure random number generator,
use the [`Random.secure()`][] constructor.

`Random` 的默认实现提供的是伪随机比特流，
不适合加密用途。
要创建加密安全的随机数生成器，
请使用 [`Random.secure()`][] 构造函数。
:::

## More information

## 更多信息

Refer to the [Math API reference][dart:math] for a full list of methods.
Also see the API reference for [num,][num] [int,][int] and [double.][double]

方法的完整列表请参阅 [Math API 参考][dart:math]。
也可参阅 [num][num]、[int][int] 和 [double][double] 的 API 参考。

[Random]: {{site.dart-api}}/dart-math/Random-class.html
[`Random.secure()`]: {{site.dart-api}}/dart-math/Random/Random.secure.html
[dart:math]: {{site.dart-api}}/dart-math/dart-math-library.html
[double]: {{site.dart-api}}/dart-core/double-class.html
[int]: {{site.dart-api}}/dart-core/int-class.html
[num]: {{site.dart-api}}/dart-core/num-class.html
