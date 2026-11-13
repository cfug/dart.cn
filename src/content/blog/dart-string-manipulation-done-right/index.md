---
# title: "Dart string manipulation done right 👉"
title: "正确处理 Dart 字符串 👉"
# description: "Does your app use emojis or support multiple languages? Dart just introduced a new way to safely handle them in string manipulation."
description: "你的应用使用 emoji 或支持多种语言吗？Dart 刚推出了一种在字符串处理中安全应对它们的新方法。"
ai-translated: true
publishDate: 2020-06-30
author: taodong
image: images/1H_-SP7V6x1cQpGM_6DUReg.webp
category: deep-dive
layout: blog
---


Like many other programming languages designed before emojis started to dominate our daily communications and the rise of multilingual support in commercial apps, Dart represents a string as [a sequence of UTF-16 code units](https://api.dart.dev/stable/2.8.4/dart-core/String-class.html). The encoding worked fine in most cases, until increased internationalization and the introduction of emojis that go with any language made the encoding’s inherent problems become everybody’s problems.

和许多在 emoji 开始主导日常交流、商业应用兴起多语言支持之前
设计的编程语言一样，Dart 把字符串表示为
[UTF-16 码元（code unit）序列](https://api.dart.dev/stable/2.8.4/dart-core/String-class.html)。
这种编码在大多数情况下都工作正常，直到日益增长的国际化需求，
以及能与任何语言搭配使用的 emoji 的出现，
让这种编码固有的问题变成了所有人的问题。

Consider this example:

看这个例子：

<DashImage src="images/1H_-SP7V6x1cQpGM_6DUReg.webp" alt="Diagram showing how the string 'Hello 👋' is mapped to UTF-16 code units." />


In the string “Hello👋”, each user-perceivable character is mapped to a single code unit except the waving hand emoji 👋. An immediate consequence of this mapping is confusion over the length of this string. Will the output of the following line of code be 6 or 7?

在字符串 “Hello👋” 中，除了挥手 emoji 👋，
每个用户可感知的字符都映射到单个码元。这种映射的直接后果
就是让人搞不清这个字符串的长度。下面这行代码的输出是 6 还是 7？

```
print('Hello👋'.length);
```


To the user, there are clearly 6 characters in this string unless you get philosophical. But the Dart `String` API will tell you that the [`length`](https://api.dart.dev/stable/dart-core/String/length.html) is 7, or to be precise, 7 UTF-16 code units. This difference has all kinds of ramifications, because so many text manipulation tasks involve using character indexes with the `String` API. For example, `"Hello👋"[5]` won’t return the 👋 emoji. Instead it will return a malformed character representing the first code unit of the emoji.

对用户来说，这个字符串显然有 6 个字符，除非你要上升到哲学层面。
但 Dart 的 `String` API 会告诉你
[`length`](https://api.dart.dev/stable/dart-core/String/length.html)
是 7，准确地说，是 7 个 UTF-16 码元。这个差异会带来各种影响，
因为太多文本处理任务都要通过 `String` API 使用字符索引。
例如，`"Hello👋"[5]` 不会返回 👋 emoji，
而是返回表示该 emoji 第一个码元的残缺字符。

The good news is that Dart has a new package called [*characters*](https://pub.dev/packages/characters) that operates on user-perceivable characters instead of UTF-16 code units. However, you, as a Dart programmer, need to know when to use the `characters` package. Our research indicates that even experienced Dart programmers can easily miss such problems when reading text manipulation code. In this article, I go over some common scenarios where you need to pay extra attention and consider using the `characters` package instead of Dart `String`.

好消息是，Dart 有一个名为
[*characters*](https://pub.dev/packages/characters) 的新 package，
它操作的是用户可感知字符，而不是 UTF-16 码元。不过，作为 Dart 程序员，
你需要知道何时该用 `characters` package。我们的研究表明，
即使经验丰富的 Dart 程序员，在阅读文本处理代码时也很容易漏掉这类问题。
本文会介绍一些需要格外留意、考虑用 `characters` package
代替 Dart `String` 的常见场景。

## Scenarios to watch out for

## 需要留意的场景

In this section, I’ll go over a few common text manipulation scenarios, explain why using Dart’s `String` API could cause problems in these scenarios, and show how to use the `characters` package for more reliable results. The use cases below generally assume that we’re dealing with strings entered by human users, which could include emojis or characters in a language the app developer doesn’t expect.

本节将介绍几个常见的文本处理场景，解释为什么在这些场景中
使用 Dart 的 `String` API 可能出问题，并展示如何用 `characters` package
获得更可靠的结果。下面的用例基本假设我们处理的是人类用户输入的字符串，
其中可能包含 emoji，或应用开发者没预料到的语言中的字符。

### Scenario 1: Counting characters in a string

### 场景 1：统计字符串中的字符数

Suppose you’re writing a function that checks if the text entered by the user has exceeded a specific number of characters. The function returns a positive number of remaining characters if the limit hasn’t been reached, or a negative number of extra characters if the limit has been exceeded.

假设你在写一个函数，检查用户输入的文本是否超过了指定的字符数。
如果未达到上限，函数返回剩余字符数（正数）；
如果超出上限，则返回超出的字符数（负数）。

This is pretty straightforward to do using the `String` API:

用 `String` API 实现非常直接：

```dart
// Implementation using the String API, 
// which counts the number of UTF-16 code units
// instead of user-perceivable characters.
int remainingCapacity(String input, int limit) {
  var length = input.length;
  return limit - length;
}

```

However, the following test reveals the problem with this code:

然而，下面的测试揭示了这段代码的问题：

```dart
test('remainingCapacity', (){
  var limit = 140;
  input = 'Laughter 😀 is the sensation of feeling good all over and showing it principally in one place.';
  expect(remainingCapacity(input, limit), equals(47));
});
```

Here are the testing results:

测试结果如下：

```
Expected: <47>
  Actual: <46>
```


We can rewrite this function using the `characters` package, which provides a convenient extension method on `String`, to produce the correct number of characters as follows:

我们可以用 `characters` package 重写这个函数。
它在 `String` 上提供了一个方便的扩展方法，可以得出正确的字符数：

```dart
int checkMaxLength(String input, int limit) {
  var length = input.characters.length;
  return limit - length;
}
```

### Scenario 2: Extracting a substring

### 场景 2：提取子串

In this scenario, we want to implement a function that deletes the last character from a string and returns the result as a new string. Let’s assume this string comes from user input.

这个场景中，我们要实现一个函数，删除字符串的最后一个字符，
并把结果作为新字符串返回。假设这个字符串来自用户输入。

This function is easy to implement using the `substring` method on `String` as follows:

用 `String` 的 `substring` 方法很容易实现这个函数：

```dart
String skipLastChar(String text) {
  return text.substring(0, max(0, text.length - 1));
}
```

However, a good emoji test can quickly break the code:

然而，一个好的 emoji 测试就能迅速让代码露馅：

```dart
test('skipLastChar(text)', () {
  var string = 'Hi 🇩🇰';
  expect(skipLastChar(string), equals('Hi '));
});
```

Here are the testing results:

测试结果如下：

```
Expected: ‘Hi ’
  Actual: ‘Hi 🇩???’
    Which: is different. Both strings start the same, but the actual value also has the following trailing characters: 🇩???
```


The `characters` package can handle this case with ease, as it provides high-level methods such as [`skipLast(int count)`](https://pub.dev/documentation/characters/latest/characters/Characters/skipLast.html)*.* We can rewrite this snippet into the following code:

`characters` package 可以轻松处理这种情况，
因为它提供了 [`skipLast(int count)`](https://pub.dev/documentation/characters/latest/characters/Characters/skipLast.html)
这样的高层方法。我们可以把这段代码改写成：

```dart
String skipLastChar(String text) {
  return text.characters.skipLast(1).toString();
}
```

### Scenario 3: Splitting a string on an emoji

### 场景 3：按 emoji 拆分字符串

In the third scenario, we want to split a string on a given emoji. Here is a function doing that using the split method on `String`:

第三个场景中，我们要按给定的 emoji 拆分字符串。
下面这个函数用 `String` 的 split 方法来实现：

```dart
List splitEmojiSeparatedWords(String text, String separator) {
  return text.split(separator);
}
```

Would it work? It probably will work just fine 99% of the time, but the test below illustrates an example where the above code produces rather surprising results.

它能工作吗？99% 的情况下大概都没问题，
但下面的测试展示了上面的代码产生相当意外结果的例子。

```dart
test('splitEmojiSeparatedWords(String text, String separator)', () {
   var text = 'abc👨‍👩‍👧‍👦👧abc👧abc👧abc';
   var separator = '👧';
   List<String> expected = ['abc👨‍👩‍👧‍👦', 'abc', 'abc', 'abc'];
   expect(td.splitEmojiSeparatedWords(text, separator), equals(expected));
});
```

Here are the testing results:

测试结果如下：

```
Expected: ['abc👨‍👩‍👧‍👦', 'abc', 'abc', 'abc']
  Actual: ['abc👨‍👩‍','‍👦', 'abc', 'abc', 'abc']
    Which: was 'abc👨‍👩‍' instead of 'abc👨‍👩‍👧‍👦' at location [0]
```


So, why did 👨‍👩‍👧‍👦 become two emojis 👨‍👩 when the string was split? It’s because 👨‍👩‍👧‍👦 is actually made of four different emojis: 👨👩👧👦. When the string was split on 👧, “abc👨‍👩‍👧‍👦” got separated into two parts: “abc👨‍👩” and “‍👦”.

那么，为什么字符串被拆分时 👨‍👩‍👧‍👦 变成了 👨‍👩 两个 emoji？
因为 👨‍👩‍👧‍👦 实际上由四个不同的 emoji 组成：👨👩👧👦。
当按 👧 拆分字符串时，“abc👨‍👩‍👧‍👦”被分成了两部分：
“abc👨‍👩”和“‍👦”。

You can avoid this issue by using the [`split`](https://pub.dev/documentation/characters/latest/characters/Characters/split.html) method on the `Characters` class, as the following code shows:

使用 `Characters` 类的
[`split`](https://pub.dev/documentation/characters/latest/characters/Characters/split.html)
方法就能避免这个问题，如下面的代码所示：

```dart
List<String> splitEmojiSeparatedWords(String text, String separator) {
  // Split returns an iterable, which we need to convert to a list.
  return [...text.characters.split(separator.characters)]; 
}
```

### Scenario 4: Accessing a specific character by its index

### 场景 4：按索引访问特定字符

In text manipulation, it’s common to access a specific character by its index (i.e., position) in the string. For example, the snippet shows a function that returns initials from the first name and the last name entered by the user in two separate text fields:

在文本处理中，按字符在字符串中的索引（即位置）访问特定字符很常见。
例如，下面的函数从用户在两个文本框中分别输入的名和姓中提取首字母：

```dart
String createInitials(String firstName, String lastName) {
    return firstName[0].toUpperCase() + lastName[0].toUpperCase();
}
```

But as we have demonstrated in the beginning of the article, using the index in a UTF-16-based string could be risky. Let’s verify the correctness of the above code with the test case below:

但正如我们在文章开头演示的，在基于 UTF-16 的字符串中使用索引可能有风险。
用下面的测试用例验证一下上面代码的正确性：

```dart
test("createInitials(firstName, lastname)", () {
    var firstName = 'étienne';
    var lastname = 'bézout';
    expect(td.createInitials(firstName, lastname), equals('ÉB'));
});
```

Here are the test results:

测试结果如下：

```
Expected: ‘ÉB’
  Actual: ‘EB’
    Which: is different.
```


Why did the test fail? It’s because the letter “É” could be a combination of “E” and the accent mark. You can use the `characters` package to easily avoid this problem:

测试为什么失败了？因为字母“É”可能是“E”和重音符号的组合。
使用 `characters` package 就能轻松避免这个问题：

```dart
String createInitials(String firstName, String lastName) {
  return '${firstName.characters.first}${lastName.characters.first}';
}
```

## Exercise: Omitting text overflow

## 练习：省略溢出文本

Now, here’s a challenge for you. In this scenario, the app needs to display a list of messages, one per line. You’re asked to review code that implements a function that displays text overflow as an ellipsis when the message’s length exceeds the given character limit.

现在给你一个挑战。这个场景中，应用需要逐行显示消息列表。
请你评审一段代码：它实现的函数在消息长度超过给定字符上限时，
把溢出文本显示为省略号。

```dart
String textOverflowEllipsis(String text, int limit) {
  if (text.length > limit) {
    return text.substring(0, limit - 3) + '…';
  } else {
    return text;
  }
}
```

Can you come up with a test to reveal a potential issue with this code snippet? How would you rewrite it using the `characters` package? The answer is at the end of this article.

你能想出一个测试来揭示这段代码的潜在问题吗？
你会如何用 `characters` package 重写它？答案在本文末尾。

## Mitigations and possible long-term solution

## 缓解措施与可能的长期方案

It’s unreasonable to expect Dart users to stay on high alert for the kinds of pitfalls described above. For example, in an experiment we conducted, 53.7% of Dart users were unable to detect the problem illustrated in the first scenario (counting characters), even though they received two pages of information about the `characters` package and the problem the package was designed to address just a few minutes before. Therefore, we are taking a two-staged approach to helping developers choose the most appropriate API for their text manipulation needs.

指望 Dart 用户对上述陷阱时刻保持警惕是不现实的。例如，
在我们进行的一项实验中，53.7% 的 Dart 用户没能发现第一个场景
（统计字符数）中演示的问题，尽管就在几分钟前他们刚读过两页关于
`characters` package 及其要解决的问题的资料。因此，
我们采取两阶段的方法，帮助开发者为自己的文本处理需求选择最合适的 API。

In the short term, we are introducing a set of mitigations in the Flutter framework and the Dart analyzer to make the `characters` package easier to discover and invoke in Dart UI programming. This involves a few steps:

短期内，我们会在 Flutter 框架和 Dart 分析器中引入一系列缓解措施，
让 `characters` package 在 Dart UI 编程中更容易被发现和调用。
这包括几个步骤：

1. Use the `characters` package in the internal implementation of the `TextField` widget. See [this PR](https://github.com/flutter/flutter/pull/53381) and [this design doc](https://docs.google.com/document/d/1OOFW0PEZf0orBl445YXJ3nfjyKOqZdmeQ6KU3glUh7s/edit) for more details.

    在 `TextField` widget 的内部实现中使用 `characters` package。
    详见[这个 PR](https://github.com/flutter/flutter/pull/53381)
    和[这份设计文档](https://docs.google.com/document/d/1OOFW0PEZf0orBl445YXJ3nfjyKOqZdmeQ6KU3glUh7s/edit)。

1. Expose the API of the `characters` package through the Flutter framework. Once this is done, Flutter users will have a higher chance of discovering the API through the extension method [`String.characters`](https://pub.dev/documentation/characters/latest/characters/StringCharacters.html), which will show up when doing an autocomplete on `String`. The status of this work is tracked in this issue: [https://github.com/flutter/flutter/issues/55593](https://github.com/flutter/flutter/issues/55593).

    通过 Flutter 框架暴露 `characters` package 的 API。完成后，
    Flutter 用户将更有机会通过扩展方法
    [`String.characters`](https://pub.dev/documentation/characters/latest/characters/StringCharacters.html)
    发现这个 API——对 `String` 自动补全时它就会显示出来。
    这项工作的进展在这个 issue 中跟踪：
    [https://github.com/flutter/flutter/issues/55593](https://github.com/flutter/flutter/issues/55593)。

1. Update the Flutter framework’s API documentation and sample code to suggest using the [`Characters`](https://pub.dev/documentation/characters/latest/characters/Characters-class.html) class when applicable, such as in the callback for [`TextField.onChanged`](https://api.flutter.dev/flutter/material/TextField/onChanged.html). This work is tracked in [https://github.com/flutter/flutter/issues/55598](https://github.com/flutter/flutter/issues/55598) with relevant details in [this doc](https://docs.google.com/document/d/18SxWeHpds4modnvo997vIOiq01EspeFgsNvPa5ey88w/edit#heading=h.1isiu2jji0ae).

    更新 Flutter 框架的 API 文档和示例代码，在适用时建议使用
    [`Characters`](https://pub.dev/documentation/characters/latest/characters/Characters-class.html)
    类，比如在
    [`TextField.onChanged`](https://api.flutter.dev/flutter/material/TextField/onChanged.html)
    的回调中。这项工作在
    [https://github.com/flutter/flutter/issues/55598](https://github.com/flutter/flutter/issues/55598)
    中跟踪，相关细节见[这份文档](https://docs.google.com/document/d/18SxWeHpds4modnvo997vIOiq01EspeFgsNvPa5ey88w/edit#heading=h.1isiu2jji0ae)。

1. Have the Dart analyzer suggest converting a `String` object to a `Characters` object when autocompleting a callback template for handling user-entered text. For example, the IDE could fill out everything in the snippet below after the user autocompletes on `onChanged`. This work is tracked in [https://github.com/dart-lang/sdk/issues/41677](https://github.com/dart-lang/sdk/issues/41677).

    让 Dart 分析器在自动补全处理用户输入文本的回调模板时，
    建议把 `String` 对象转换为 `Characters` 对象。例如，用户对
    `onChanged` 自动补全后，IDE 可以填好下面代码片段中的所有内容。
    这项工作在
    [https://github.com/dart-lang/sdk/issues/41677](https://github.com/dart-lang/sdk/issues/41677)
    中跟踪。

```dart
TextField(
  onChanged: (String value) {
  // Converting String to Characters to handle emojis 
  // and non-English characters more robustly.
  var myText = value.characters;      
  }
)
```

Those mitigations can help, but they are limited to string manipulations performed in the context of a Flutter project. We need to carefully measure their effectiveness after they become available. A more complete solution at the Dart language level will likely require migration of at least some existing code, although a few options (for example, [static extension types](https://github.com/dart-lang/language/issues/42)) *might* make breaking changes manageable. More technical investigation is needed to fully understand the trade-offs.

这些缓解措施能有所帮助，但仅限于 Flutter 项目中的字符串处理。
它们上线后，我们需要仔细衡量其效果。Dart 语言层面更完整的解决方案，
很可能需要迁移至少一部分现有代码，尽管一些选项
（例如[静态扩展类型](https://github.com/dart-lang/language/issues/42)）
*也许*能让破坏性变更可控。要充分理解其中的取舍，还需要更多技术调研。

## How you can help

## 你能帮上什么忙

Please help us raise awareness of how to fix string issues using the `characters` package:

请帮助我们提高对用 `characters` package 修复字符串问题的认识：

* Look for instances of using `String.length` or `String.substring` in your own code. If the string might have originated from user input, try to rewrite the code using the `characters` package.

  在自己的代码中查找使用 `String.length` 或 `String.substring` 的地方。
  如果字符串可能来自用户输入，尝试用 `characters` package 重写代码。

* Share this post with others in the Dart community.

  把这篇文章分享给 Dart 社区的其他人。

* Try to update [existing answers about Dart text manipulation](https://stackoverflow.com/search?q=%5Bdart%5D+or+%5BFlutter%5D+String) on StackOverflow. If the accepted answers missed this limitation of the `String` API, remind people of the risk.

  尝试更新 StackOverflow 上
  [关于 Dart 文本处理的现有回答](https://stackoverflow.com/search?q=%5Bdart%5D+or+%5BFlutter%5D+String)。
  如果被采纳的回答忽略了 `String` API 的这个局限，提醒大家注意风险。

* Comment on the GitHub issues listed above to let us know your thoughts and opinions.

  在上面列出的 GitHub issue 中评论，让我们知道你的想法和意见。

Now, happy coding 😉!

现在，祝你编码愉快 😉！

## Acknowledgments

## 致谢

Thanks to [Kathy Walrath](https://medium.com/@kathyw_39223), [Lasse Nielsen](https://medium.com/@lrhn), and [Michael Thomson](https://medium.com/@mit.mit) for reviewing this article. I would also like to thank developers who participated in our user research. Their participation helped the Dart and Flutter teams better understand the challenge of dealing with this limitation of the Dart `String` API.

感谢 [Kathy Walrath](https://medium.com/@kathyw_39223)、
[Lasse Nielsen](https://medium.com/@lrhn) 和
[Michael Thomson](https://medium.com/@mit.mit) 审阅本文。
我还要感谢参与我们用户研究的开发者。他们的参与帮助 Dart 和 Flutter 团队
更好地理解了应对 Dart `String` API 这一局限的挑战。

— — —

PS: Here is the solution for the exercise:

PS：练习的解答在这里：

```dart
// Prerequisite: add the characters package as a dependency in your pubspec.yaml.
import 'package:characters/characters.dart';

void main(List<String> arguments) {
  print(textOverflowEllipsis('😸cats', 10));
  print(textOverflowEllipsis('🦏rhinoceroses', 10));
}

// This function converts text overflow to an ellipsis
// when the text's length exceeds the given character limit.
String textOverflowEllipsis(String text, int limit) {
  var myChars = text.characters;
  if (myChars.length > limit) {
    return '${myChars.take(limit - 1)}…';
  } else {
    return text;
  }
}
```