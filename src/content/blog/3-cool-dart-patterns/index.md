---
# title: "3 cool Dart patterns"
title: "3 个很酷的 Dart 模式"
# description: "Try these three useful Dart programming patterns in your next Flutter app."
description: "在你的下一个 Flutter 应用中试试这三个实用的 Dart 编程模式。"
ai-translated: true
publishDate: 2020-05-20
author: JoseAlba
image: images/0alx_hKg5fP3b1b22.webp
category: other
layout: blog
---


*About the author: Jose recently graduated from university and now works on [Material](https://material.io), a design system that helps teams build high-quality digital experiences. Jose’s team maintains the Flutter [material library](https://api.flutter.dev/flutter/material/material-library.html).*

*关于作者：Jose 刚从大学毕业，现在从事
[Material](https://material.io) 的工作——
一个帮助团队构建高质量数字体验的设计系统。
Jose 的团队维护 Flutter 的
[material 库](https://api.flutter.dev/flutter/material/material-library.html)。*

With the Flutter framework, you use the Dart programming language to create beautiful applications. Over time, I have learned useful Dart patterns that have helped me become a better Flutter developer. Here are three that I recommend you try in your next application:

使用 Flutter 框架时，你用 Dart 编程语言创建漂亮的应用。
随着时间推移，我学到了一些实用的 Dart 模式，
帮助我成为更好的 Flutter 开发者。
这里推荐三个，建议你在下一个应用中试试：

* Conditionally assigning a value: `boolean ? widget : widget`

  条件赋值：`boolean ? widget : widget`

* Merging widgets into a collection: `for ()...[]`

  把 widget 合并进集合：`for ()...[]`

* Immediately invoking an anonymous function: `() {} ()`

  立即调用匿名函数：`() {} ()`

This article shows you how to use each pattern, finishing with an embedded Pen where you can play with the code.

本文展示每个模式的用法，最后附上一个内嵌的 Pen，
你可以在里面把玩这些代码。

<DashImage src="images/0alx_hKg5fP3b1b22.webp" alt="A split screen showing a restaurant menu app UI on the right and the Dart code producing it on the left." caption="This screenshot shows the code I will discuss and the UI it produces." />


## Conditionally assigning a value

## 条件赋值

The [conditional assignment operator](https://dart.dev/guides/language/language-tour#conditional-expressions), `?:` (also known as a [ternary operator](https://en.wikipedia.org/wiki/%3F:)), requires one conditional expression and two value expressions. This pattern is useful when your widget depends on a boolean value. Instead of modularizing the operation into a separate method, you can use the ternary operator to run the code inline. I have used this technique countless times.

[条件赋值运算符](https://dart.dev/guides/language/language-tour#conditional-expressions)
`?:`（也称[三元运算符](https://en.wikipedia.org/wiki/%3F:)）
需要一个条件表达式和两个值表达式。
当你的 widget 依赖一个布尔值时，这个模式很有用。
不必把操作拆成单独的方法，你可以用三元运算符内联执行代码。
这个技巧我用过无数次。

In the following example, the `AppBar` title depends on a boolean value. (In this case, the value is dependent on the `isVegetarian` boolean.) If the value is true, the title text is set to the first value (“Vegetarian Food”); otherwise it’s the second value (“Non-Vegetarian Food”).

在下面的例子中，`AppBar` 的标题依赖一个布尔值
（这里取决于 `isVegetarian` 布尔值）。
值为 true 时，标题文本取第一个值（“Vegetarian Food”）；
否则取第二个值（“Non-Vegetarian Food”）。

```
appBar: AppBar(
  title: Text(Random().nextBool() 
      ? 'Vegetarian Food' 
      : 'Non-Vegetarian Food'),
),
```


## Merging widgets into a collection

## 把 widget 合并进集合

This pattern, `for () ...[]`, uses the spread operator (`...`) to merge a list of widgets into an existing collection. I use this any time I am working with a list of widgets, often with the `children` property. The following example uses this technique to create a list of widgets:

这个模式 `for () ...[]` 使用展开运算符（`...`）
把一组 widget 合并进既有集合。
只要处理 widget 列表我就会用它，常常配合 `children` 属性。
下面的例子用这个技巧创建一组 widget：

```
children: [
  Container(),
  for (final food in foods) ...[
    if (isVegetarian == food.isVegetarian)
      ListTile(title: Text(food.name)),
    SizedBox(height: 50.0),
  ],
],
```


In this example, `foods` is a list of `Food` objects, defined as follows:

这个例子中，`foods` 是一个 `Food` 对象列表，定义如下：

```
List<Food> foods = [
  Food(name: 'apple', isVegetarian: true),
  Food(name: 'nuts', isVegetarian: true),
  Food(name: 'eggs', isVegetarian: true),
  Food(name: 'chicken', isVegetarian: false),
];

class Food {
  Food({
    this.name,
    this.isVegetarian,
  });

  String name;
  bool isVegetarian;
}
```


The `for () ...[]` pattern is handy whenever you need to add multiple widgets (such as the `ListTile` widgets in the example if `isVegetarian` is true) multiple times (3 times, in the example) into a list of widgets.

每当你需要把多个 widget（比如例子中 `isVegetarian`
为 true 时的 `ListTile`）多次（例子中是 3 次）
加进 widget 列表时，`for () ...[]` 模式都很顺手。

Because the spread operator (`...`) is relatively new to Dart, make sure that your `pubspec.yaml` file specifies a Dart SDK of 2.3.0 or later:

由于展开运算符（`...`）对 Dart 来说还比较新，
请确保 `pubspec.yaml` 文件指定 Dart SDK 2.3.0 或更高：

```
environment:
  sdk: ">=2.3.0 < 3.0.0"
```


To learn more about [collection operators](https://dart.dev/guides/language/language-tour#collection-operators) and [spread operators](https://dart.dev/guides/language/language-tour#spread-operator), read the [Dart language tour](https://dart.dev/guides/language/language-tour).

想了解更多[集合运算符](https://dart.dev/guides/language/language-tour#collection-operators)
和[展开运算符](https://dart.dev/guides/language/language-tour#spread-operator)，
请阅读 [Dart 语言之旅](https://dart.dev/guides/language/language-tour)。

## Immediately invoking an anonymous function

## 立即调用匿名函数

The third pattern, `() {} ()`, is the Dart equivalent of an *immediately invoked function expression ([IIFE](https://en.wikipedia.org/wiki/Immediately_invoked_function_expression)).* This handy pattern lets you define an anonymous function and execute it immediately. I found this pattern extremely useful when working with a widget that could have multiple outputs. Instead of having nested ternary operators or modularizing a simple call, the code is available inline. The following example shows this pattern, with an anonymous function that contains a `switch` statement.

第三个模式 `() {} ()` 是 Dart 版的*立即调用函数表达式
（[IIFE](https://en.wikipedia.org/wiki/Immediately_invoked_function_expression)）*。
这个顺手的模式让你定义一个匿名函数并立即执行。
我发现处理可能有多种输出的 widget 时，这个模式极其有用。
不用嵌套三元运算符，也不用把简单调用拆成方法，
代码直接内联可用。下面的例子展示了这个模式：
一个包含 `switch` 语句的匿名函数。

```
color: () {
  switch (getRandomElement(foods).name) {
    case 'apple':
      return Colors.green;
    case 'nuts':
      return Colors.brown;
    case 'eggs':
      return Colors.yellow;
    default:
      return Colors.transparent;
  }
}(),
```


## Conclusion

## 结语

You can use CodePen to play with Flutter code. Here’s a Pen that has all the code in this article:

你可以用 CodePen 把玩 Flutter 代码。
这个 Pen 包含本文的全部代码：

<iframe src="https://codepen.io/JoseAlba/embed/mdeKexM" width="800" height="600" frameborder="0" allowfullscreen></iframe>


Here is another CodePen example with just colors:

这是另一个只涉及颜色的 CodePen 示例：

<iframe src="https://codepen.io/JoseAlba/embed/eYpgpzY" width="800" height="600" frameborder="0" allowfullscreen></iframe>


I hope that these three Dart patterns give you more freedom while developing Flutter applications. If you have other favorite techniques, share them in the comments!

希望这三个 Dart 模式让你开发 Flutter 应用时更自由。
如果你有其他喜欢的技巧，欢迎在评论区分享！

*To learn more about Jose, visit him on [GitHub](https://github.com/JoseAlba), [LinkedIn](https://www.linkedin.com/in/josealba1996/), [YouTube](https://www.youtube.com/channel/UCOdKA_On0oPe1tz02z1QfxA?view_as=subscriber), or [Instagram](https://www.instagram.com/jose.alba/).*

*想了解更多关于 Jose 的信息，请访问他的
[GitHub](https://github.com/JoseAlba)、
[LinkedIn](https://www.linkedin.com/in/josealba1996/)、
[YouTube](https://www.youtube.com/channel/UCOdKA_On0oPe1tz02z1QfxA?view_as=subscriber)
或 [Instagram](https://www.instagram.com/jose.alba/)。*