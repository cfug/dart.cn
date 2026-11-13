---
# title: "Exploring collections in Dart"
title: "探索 Dart 中的集合"
# description: "If you have ever called add(), addAll(), map(), or toList() to build a list or map, you might want to check out collection if, collection…"
description: "如果你曾调用 add()、addAll()、map() 或 toList() 来构建列表或 map，不妨了解一下 collection if、collection…"
ai-translated: true
publishDate: 2020-09-15
author: johnpryan
image: images/1NLasdGsxG6bBzWYfe_9UJA.webp
category: deep-dive
layout: blog
---


<DashImage src="images/1NLasdGsxG6bBzWYfe_9UJA.webp" alt="Person pointing at a pineapple on a produce stand." />


If you have ever called `add()`, `addAll()`, `map()`, or `toList()` to build a list or map, you might want to check out *collection if*, *collection for*, and *spreads*. Last year, Dart [added these features in version 2.3](/blog/announcing-dart-2-3-optimized-for-building-user-interfaces).

如果你曾调用 `add()`、`addAll()`、`map()` 或 `toList()` 来构建列表或 map，
不妨了解一下 *collection if*（集合 if）、*collection for*（集合 for）
和*展开（spreads）*。去年，Dart
[在 2.3 版本中加入了这些特性](/blog/announcing-dart-2-3-optimized-for-building-user-interfaces)。

In this article, we’ll look at collections, explore these new features, and see some interesting examples. By mastering these features, you can make your code more succinct and easier to read.

本文将介绍集合，探索这些新特性，并看一些有趣的例子。
掌握这些特性后，你的代码会更简洁、更易读。

## Collections

## 集合

First, we need to understand what a collection is. A [collection](https://api.dart.dev/stable/dart-core/dart-core-library.html#collections) is an object that contains other objects. For example:

首先，我们需要理解什么是集合。
[集合（collection）](https://api.dart.dev/stable/dart-core/dart-core-library.html#collections)
是包含其他对象的对象。例如：

* **List**: an ordered collection of objects with a length (also called an *array*)

  **List（列表）**：有长度的有序对象集合（也叫*数组*）

* **Set**: an unordered collection of unique objects

  **Set（集合）**：由唯一对象组成的无序集合

* **Map**: an unordered collection of key-value pairs

  **Map（映射）**：键值对的无序集合

* **Queue**: an ordered collection that can add/remove objects on both ends

  **Queue（队列）**：可以在两端添加/移除对象的有序集合

* **SplayTreeMap**: an ordered collection of key-value pairs based on a self-balancing binary tree

  **SplayTreeMap（伸展树映射）**：基于自平衡二叉树的有序键值对集合

These types are available in the [dart:collection](https://api.dart.dev/stable/dart-collection/dart-collection-library.html) package. For even more collection types, check out [package:collection](https://pub.dev/packages/collection) on pub.dev.

这些类型可在
[dart:collection](https://api.dart.dev/stable/dart-collection/dart-collection-library.html)
包中找到。想要更多集合类型，可以看看 pub.dev 上的
[package:collection](https://pub.dev/packages/collection)。

Each of these collection types implements [Iterable](https://api.dart.dev/stable/dart-core/Iterable-class.html), which provides common behavior like running a function on each object in the collection, getting the first object, determining the length of the collection, and more.

这些集合类型都实现了
[Iterable](https://api.dart.dev/stable/dart-core/Iterable-class.html)，
它提供了常见行为，比如对集合中的每个对象执行函数、获取第一个对象、
确定集合长度等等。

## Collection literals

## 集合字面量

Dart supports syntax for constructing three types of collections: list literals (`[]`), map literals (`{}`) and set literals (also `{}`).

Dart 支持构造三种集合的语法：列表字面量（`[]`）、map 字面量（`{}`）
和 set 字面量（也是 `{}`）。

Here’s a list literal:

这是一个列表字面量：

```
List<String> getArtists() {
  return [
    'Picasso',
    'Warhol',
    'Monet',
  ];
}
```


Here’s a map literal:

这是一个 map 字面量：

```
Map<String, String> getArtistsByPainting {
  return {
    'The Old Guitarist': 'Picasso',
    'Orange Prince': 'Warhol',
    'The Water Lily Pond': 'Monet',
  };
}
```


And here’s a set literal, added in Dart 2.3:

这是 Dart 2.3 新增的 set 字面量：

```
Set<String> getArtistsSet() {
  return {
    'Picasso',
    'Warhol',
    'Monet',
  };
}
```


If you’re wondering why maps and sets can use the same `{}` syntax, it’s because Dart uses [type inference](https://dart.dev/guides/language/type-system#type-inference) to differentiate. The type system determines the type based on the type of parameters `a` and `b`. It can usually determine this based on the contents—for example, `{1}` is obviously a `Set`, and `{1: 2}` is obviously a `Map`.

如果你想知道为什么 map 和 set 能用同样的 `{}` 语法，
那是因为 Dart 使用
[类型推断](https://dart.dev/guides/language/type-system#type-inference)来区分。
类型系统根据参数 `a` 和 `b` 的类型来确定类型。
它通常可以根据内容判断——例如，`{1}` 显然是 `Set`，
而 `{1: 2}` 显然是 `Map`。
> **Note:** Using `{}` constructs a map by default. To create a set, you can use a generic type annotation: `&lt;String&gt;{}`. Using two generic type parameters creates a map: `&lt;String, String&gt;{}`.

> **注意：**使用 `{}` 默认构造的是 map。要创建 set，
> 可以使用泛型类型注解：`&lt;String&gt;{}`。
> 使用两个泛型类型参数则创建 map：`&lt;String, String&gt;{}`。

## Types of elements

## 元素的类型

Each item in a collection literal is usually a value or an expression, but can also be one of these new features: a *collection if*, *collection for*, or *spread*. All of these are called *elements*.

集合字面量中的每一项通常是值或表达式，但也可以是这些新特性之一：
*collection if*、*collection for* 或*展开*。它们都被称为*元素（element）*。

Each element unpacks zero or more items and puts them in the surrounding collection. For example, a string literal (say, `"oatmeal"`) results in one item, but a *collection for* unpacks 0 or more items. These features can also be combined in interesting ways, as we’ll explore below.

每个元素会解包出零个或多个项，放进外围的集合中。例如，
字符串字面量（比如 `"oatmeal"`）产生一个项，
而 *collection for* 会解包出 0 个或多个项。
这些特性还能以有趣的方式组合，我们下面就来探索。

### Spreads

### 展开（spread）

A *spread* takes a collection (for example, a list) and puts its contents into the surrounding collection:

*展开*接受一个集合（例如列表），把它的内容放进外围的集合中：

```
List<String> combineLists(List<String> a, List<String> b) {
  return [
    ...a,
    ...b,
  ];
}
```


The preceding code is equivalent to this:

上面的代码等价于：

```
List<String> combineLists(List<String> a, List<String> b) {
  var list = [];
  list.addAll(a);
  list.addAll(b);
  return list;
}
```


You can also use spreads in map and set literals:

你也可以在 map 和 set 字面量中使用展开：

```
Map<String, String> combineMaps(Map<String, String> a, Map<String, String> b) {
  return {
    ...a,
    ...b,
  };
}

Set<String> combineSets(Set<String> a, Set<String> b) {
  return {
    ...a,
    ...b,
  };
}
```


In both maps and sets, the contents of `b` overwrite the contents in `a` when there’s a conflict. For example, calling `combineMaps({'foo': 'bar'}, {'foo': 'baz'})` results in a map containing `{'foo': 'baz'}`.

在 map 和 set 中，发生冲突时 `b` 的内容会覆盖 `a` 中的内容。例如，
调用 `combineMaps({'foo': 'bar'}, {'foo': 'baz'})`
会得到包含 `{'foo': 'baz'}` 的 map。

### Null-aware spreads (`…?`)

### 空感知展开（`…?`）

A *null-aware spread* adds the contents to the collection only if the expression after the operator is non-null:

*空感知展开（null-aware spread）*只有在运算符后面的表达式非 null 时，
才把内容加入集合：

```
List<String> combineIfExists(List<String> a, List<String> b) {
  return [
    ...?a,
    ...?b,
  ];
}

void main() {
  var result = combineIfExists(['foo'], null);
  print(result); // [foo]
}
```


### Collection if

### Collection if

Use the `if`, `else`, and `else if` keywords to add something to a collection based on a condition. Here’s an example of using *collection if*:

使用 `if`、`else` 和 `else if` 关键字，可以根据条件向集合添加内容。
这是使用 *collection if* 的例子：

```
class Article {
  String title;
  DateTime date;

  Article(this.title, this.date);

  String toString() {
    return [
      if (title != null) title,
      date.toString(),
    ].join(', ');
  }
}
```


The `else` keyword can be added on the end:

可以在末尾加上 `else` 关键字：

```
String toString() {
  return [
     if (title != null) title else '(no title)',
  ].join(', ');
}
```


Notice where the comma is. The comma can’t be after `title` because the `else` is part of the same element. Keeping the `if` and `else` together before the comma is what keeps them separate from the next element in the collection.

注意逗号的位置。逗号不能放在 `title` 后面，
因为 `else` 是同一个元素的一部分。把 `if` 和 `else` 一起放在逗号之前，
才能让它们与集合中的下一个元素分开。

Adding an `else if` works too:

加上 `else if` 也可以：

```
String toString() {
  return [
    if (title != null) title else '(no title)',
    if (date == null)
      '(no date)'
    else if (date.year == DateTime.now().year)
      'this year'
    else
      '${date.year}',
  ].join(', ');
}
```


### Collection for

### Collection for

Lastly, use the `for` keyword to insert a sequence into the collection:

最后，使用 `for` 关键字把一个序列插入集合：

```
class Article {
  String title;
  DateTime date;
  List<String> tags;

  Article(this.title, this.date, this.tags);

  String toString() {
    return [
      title,
      date.toString(),
      for (var tag in tags) 'tag: $tag'
    ].join(', ');
  }
}
```


In this example, the `for` expression adds a string for each item in the `tags` list. Just like a normal `for` loop in Dart, the `tags` expression can be any `Iterable`.

在这个例子中，`for` 表达式为 `tags` 列表中的每一项添加一个字符串。
和 Dart 中普通的 `for` 循环一样，`tags` 表达式可以是任何 `Iterable`。

## Collections in Flutter code

## Flutter 代码中的集合

If you’re using Dart, there’s a good chance you’re [using it to build Flutter apps](https://www.zdnet.com/article/googles-flutter-2-million-developers-uptick-in-enterprise-use-new-release-model-revealed/). Since the features described here were [designed with Flutter in mind](https://github.com/munificent/ui-as-code/blob/master/Motivation.md), let’s take a look at some Flutter code.

如果你在用 Dart，很有可能你正在
[用它构建 Flutter 应用](https://www.zdnet.com/article/googles-flutter-2-million-developers-uptick-in-enterprise-use-new-release-model-revealed/)。
既然这里描述的特性是
[围绕 Flutter 设计的](https://github.com/munificent/ui-as-code/blob/master/Motivation.md)，
我们就来看一些 Flutter 代码。

### Refactoring a build() method

### 重构 build() 方法

In Flutter, it’s common to build up a list of widgets in a `build()` method:

在 Flutter 中，常见的做法是在 `build()` 方法里构建一个 widget 列表：

```
[@override](http://twitter.com/override)
Widget build(BuildContext context) {
  var articleWidgets = articles
      .map<Widget>((article) => ArticleWidget(article: article))
      .toList();

  return ListView(
    children: articleWidgets,
  );
}
```


This could be rewritten with a spread:

这可以用展开来改写：

```
Widget build(BuildContext context) {

  return ListView(
    children: [
      ...articles.map((article) => ArticleWidget(article:article))
    ],
  );
}
```


Or with a *collection for*:

或者用 *collection for*：

```
Widget build(BuildContext context) {
  return ListView(
    children: [
      for (var article in articles)
        ArticleWidget(article: article)
    ],
  );
}
```


The first snippet converts the `Article` class into a collection of `ArticleWidget` objects using `map()`, and then applies the spread operator to expand them into the surrounding list. In the second example, the *collection for* operator lets you express this a little more succinctly.

第一段代码用 `map()` 把 `Article` 类转换成 `ArticleWidget` 对象的集合，
然后用展开运算符把它们展开到外围列表中。第二个例子里，
*collection for* 运算符让表达更简洁一些。

### A larger build() method

### 更大的 build() 方法

Here’s a more complex example:

这是一个更复杂的例子：

```
Widget build(BuildContext context) {
  var headerStyle = Theme.of(context).textTheme.headline4;

  return Column(
    children: [
      if (article.title != null)
        Text(article.title, style: headerStyle),
      if (article.date != null)
        Text(article.date.toString()),
      Text('Tags:'),
      for (var tag in article.tags)
        Text(tag),
    ],
  );
}
```


The logic to place widgets in the `Column` is right where a reader might expect, and saves a lot of code. Before these features, the most common way to achieve the same behavior was to create a variable and use normal `if` statements that call `add()`.

把 widget 放进 `Column` 的逻辑就在读者期望的位置，还省了很多代码。
在这些特性出现之前，实现同样行为最常见的方式是创建一个变量，
用普通 `if` 语句调用 `add()`。

## Combining these features

## 组合这些特性

These features can be combined in interesting ways, as the examples in this section show. Here are a few things to keep in mind:

这些特性可以以有趣的方式组合，本节的例子就展示了这一点。
有几点要记住：

* Syntactically a *collection if*, *collection for*, or *spread* is a *single element* — even if it ends up creating multiple objects.

  从语法上讲，*collection if*、*collection for* 或*展开*
  都是*单个元素*——即使它最终创建了多个对象。

* Any expression can go in the body of a *collection if* or *collection for*.

  *collection if* 或 *collection for* 的主体中可以放任何表达式。

* Any *element* can go in the body of a *collection if* or *collection for*.

  *collection if* 或 *collection for* 的主体中可以放任何*元素*。

### Using if and for together

### 同时使用 if 和 for

Here’s some code that creates a list using a *collection if* inside of a *collection for*. Here, each article is added to the list if it’s after a certain date:

下面这段代码在 *collection for* 里嵌套 *collection if* 来创建列表。
这里，只有日期晚于某个时间点的文章才会被加入列表：

```
List<Article> recentArticles(List<Article> allArticles) {
  var ninetyDaysAgo = DateTime.now().subtract(Duration(days: 90));
  return [
    for (var article in allArticles)
      if (article.date.isAfter(ninetyDaysAgo))
        article
  ];
}
```


If you prefer spreads, the return value could instead be written as `...allArticles.where((article) =&gt; article.date.isAfter(ninetyDaysAgo))`.

如果你更喜欢展开，返回值也可以写成
`...allArticles.where((article) =&gt; article.date.isAfter(ninetyDaysAgo))`。

### Using collection if and spreads together

### 同时使用 collection if 和展开

A *collection if* takes a single element, but if you want to include more than one you can use a spread:

*collection if* 只接受单个元素，但如果你想包含多个，可以使用展开：

```
Widget build(BuildContext context) {
  return Column(
    children: [
      if (article.date != null) ...[
        Icon(Icons.calendar_today),
        Text('${article.date}'),
      ],
    ],
  );
}
```


### Using collection features with async-await

### 结合集合特性与 async-await

You can also combine asynchronous calls with collection literals. For example, a common pattern is to use `Future.wait()` to trigger a group of asynchronous calls:

你也可以把异步调用和集合字面量结合起来。例如，
常见的模式是用 `Future.wait()` 触发一组异步调用：

```
Future<Article> fetchArticle(String id);

Future<List<Article>> fetchArticles() async {
  return Future.wait([
    fetchArticle('1'),
    fetchArticle('2'),
    fetchArticle('3'),
  ]);
}
```


That code can be improved using a *collection for*:

这段代码可以用 *collection for* 改进：

```
Future<List<Article>> fetchArticles(List<String> ids) async {
  return Future.wait([
    for (var id in ids)
      fetchArticle(id),
  ]);
}
```


It’s also possible to put an `await` in a collection literal, although it will wait for each future in sequence:

也可以在集合字面量中放 `await`，不过它会按顺序等待每个 future：

```
Future<List<Article>> fetchArticles(List<String> ids) async {
  return [
    // fetches one at a time
    for (var id in ids)
      await fetchArticle(id),
  ];
}
```


The preceding code waits in sequence because it’s equivalent to the following:

上面的代码按顺序等待，因为它等价于：

```
Future<List<Article>> fetchArticles() async {
  return <Article>[
    // fetches one at a time
    await fetchArticle('1'),
    await fetchArticle('2'),
    await fetchArticle('3'),
  ];
}
```


You can also expand a Stream using `await for`:

你还可以用 `await for` 展开一个 Stream：

```
Stream<String> get idStream => Stream.fromIterable(['1','2','3']);
Future<List<String>> gatherIds(Stream<String> ids) async {
  return [
    await for (var id in ids)
      id
  ];
}

void main() async {
  print(await gatherIds(idStream)); // [1, 2, 3]
}
```


This is another example of how *collection if*, *collection for*, and spreads work with other parts of the language. If you’ve used an `await for` statement, you might be able to guess the behavior: it listens to the stream for new values and puts the body into the surrounding list.

这是 *collection if*、*collection for* 和展开与语言其他部分协作的
又一个例子。如果你用过 `await for` 语句，也许能猜到它的行为：
它监听流中的新值，把主体放进外围列表。

## Exploring further

## 进一步探索

Hopefully these tips help you write cleaner Dart code. There are even more ways to use these features than are mentioned here. If you find a nice technique, [share it with the community](https://dart.dev/community) or [mention *@dart_lang* on Twitter](https://twitter.com/dart_lang). For more details, check out [Making Dart a Better Language for UI](/blog/making-dart-a-better-language-for-ui) or the initial [language proposal on GitHub](https://github.com/dart-lang/language/blob/master/accepted/2.3/unified-collections/feature-specification.md).

希望这些技巧能帮你写出更整洁的 Dart 代码。
这些特性的用法比这里提到的还要多。如果你发现了不错的技巧，
[分享给社区](https://dart.dev/community)或
[在 Twitter 上提及 *@dart_lang*](https://twitter.com/dart_lang)。
更多细节请参阅
[Making Dart a Better Language for UI](/blog/making-dart-a-better-language-for-ui)
或 GitHub 上最初的
[语言提案](https://github.com/dart-lang/language/blob/master/accepted/2.3/unified-collections/feature-specification.md)。
