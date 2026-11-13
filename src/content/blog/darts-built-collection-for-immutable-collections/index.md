---
# title: "Dart’s built_collection for Immutable Collections"
title: "Dart 的 built_collection：不可变集合"
# description: "A month ago I spoke at the Dart Developer Summit about object models with source_gen (video). I mentioned some packages and techniques that…"
description: "一个月前我在 Dart 开发者峰会上做了关于用 source_gen 构建对象模型的演讲（视频）。我提到了一些非常值得深入了解的 package 和技巧……"
ai-translated: true
publishDate: 2016-11-24
author: davidmorgan
category: deep-dive
layout: blog
---


A month ago I spoke at the [Dart Developer Summit](https://events.dartlang.org/2016/summit/) about [object models with source_gen (video)](https://www.youtube.com/watch?v=TMeJxWltoVo). I mentioned some packages and techniques that are highly deserving of a closer look, so here I am to tell the full story.

一个月前，我在 [Dart 开发者峰会](https://events.dartlang.org/2016/summit/)上
做了关于[用 source_gen 构建对象模型（视频）](https://www.youtube.com/watch?v=TMeJxWltoVo)的演讲。
我提到了一些非常值得深入了解的 package 和技巧，
所以这次我来把完整的故事讲给你听。

First up: [built_collection](https://github.com/google/built_collection.dart).

首先登场的是 [built_collection](https://github.com/google/built_collection.dart)。

The built_collection package provides SDK-like collections with immutability. Immutability for:

built_collection package 提供了具备不可变性（immutability）、
类似 SDK 风格的集合。不可变是为了：

* Simplicity, convenience. An immutable collection can be passed around without worrying about who might modify it.

  简单、方便。不可变集合可以放心传递，
  不用担心谁可能会修改它。

* Performance. Mutability leads to expensive patterns like defensive copying and change detection.

  性能。可变性会带来防御性拷贝（defensive copying）
  和变更检测（change detection）这类昂贵的模式。

The fact that built_collection is supposed to be *convenient* poses some challenges for the API. Let’s take a look. First, an immutable list:

built_collection 的目标是*方便*，这给 API 设计带来了一些挑战。
我们来看看。首先是一个不可变列表：

```
var list = new BuiltList<int>([1, 2, 3]);
```


Now I’d like to add a value to it. Of course, it’s immutable, so I can’t; what I actually want is to create a *new* list with an additional value tacked onto the end.

现在我想往里面添加一个值。当然，它是不可变的，所以我不能直接添加；
我真正想要的是创建一个*新*列表，在末尾追加一个值。

There is where we encounter the [builder pattern](https://en.wikipedia.org/wiki/Builder_pattern) for which the package is named. You get a new list by converting to a builder, making modifications, then building:

这就引出了这个 package 得名而来的[构建器模式（builder pattern）](https://en.wikipedia.org/wiki/Builder_pattern)。
你先把它转换成构建器（builder），做出修改，然后构建出新列表：

```
var builder = list.toBuilder();
builder.add(4);
var newList = builder.build();
```


Builders are usually used inline, so let’s do that:

构建器通常以内联方式使用，我们来试试：

```
var newList = (list.toBuilder()..add(4)).build()
```


This is as far as the builder pattern usually goes, but Dart has [lambdas](https://www.dartlang.org/guides/language/language-tour#anonymous-functions), so we can do better:

构建器模式通常也就到此为止了，但 Dart 有 [lambda](https://www.dartlang.org/guides/language/language-tour#anonymous-functions)，
所以我们可以做得更好：

```
var newList = list.rebuild((b) => b.add(4));
```


What we find is that [method cascading](https://en.wikipedia.org/wiki/Method_cascading) in Dart makes the builder pattern very powerful. You can almost always do what you want inline:

我们发现，Dart 的[方法级联（method cascading）](https://en.wikipedia.org/wiki/Method_cascading)
让构建器模式非常强大。你几乎总是可以内联完成想做的操作：

```
var newList = list.rebuild((b) => b
    ..add(4)
    ..addAll([7, 6, 5])
    ..sort()
    ..remove(1));
```


So, as hoped — built_collection is convenient.

所以，正如期望的那样——built_collection 很方便。

Let’s talk about performance.

我们来谈谈性能。

The Built Collections are currently optimized for code that has an update/publish cycle. That means: collections are converted to a builder, updated, built, then published — a reference is passed — for the rest of the code to consume.

Built Collections 目前针对具有“更新/发布”循环的代码做了优化。
也就是说：集合先转换成构建器、更新、构建，然后发布——
传递一个引用——供其余代码使用。

This fits typical use in web applications, for example Angular apps. There, a user interaction or RPC response triggers an update. The data model is rebuilt before being published for rendering.

这符合 Web 应用的典型用法，例如 Angular 应用。
在那里，一次用户交互或 RPC 响应会触发更新。
数据模型先重建，再发布出去用于渲染。

The Built Collections are not yet optimized for very frequent rebuilds, which would require implementing on top of [carefully chosen data structures](https://en.wikipedia.org/wiki/Hash_array_mapped_trie). If you have a use case for this, please get in touch — it is part of the design of Built Collections that this will be possible when it’s needed.

Built Collections 还没有针对非常频繁的重建做优化，
那需要在[精心选择的数据结构](https://en.wikipedia.org/wiki/Hash_array_mapped_trie)之上实现。
如果你有这样的使用场景，请联系我们——
Built Collections 的设计目标之一就是在需要时能够做到这一点。

Beyond just immutability, built_collection helps you to write good, correct code. A whole bundle of properties helps here:

除了不可变性，built_collection 还帮助你写出优质、正确的代码。
下面这一组特性都对此有帮助：

* Built Collections must be created with explicit type parameters; there is no such thing as a BuiltList&lt;dynamic&gt;.

  Built Collections 必须用显式类型参数创建；
  不存在 BuiltList&lt;dynamic&gt; 这种东西。

```
new BuiltList([1, 2, 3]);     // Throws an exception!
new BuiltList<int>([1, 2, 3]); // Better.
```


* Values must be non-null; nulls cannot be added to a Built Collection.

  值必须非空；不能向 Built Collection 中添加 null。

```
new BuiltList([1, 2, null]);  // Throws an exception!
```


* Built Collections are comparable and hashable. This means you can put them in maps, sets, and multimaps, creating exactly the collections to match your data.

  Built Collections 可比较、可哈希。这意味着你可以把它们放进
  map、set 和 multimap，构建出恰好匹配你的数据的集合。

These properties are particularly suited to collections of *business objects*: in a shopping web application, for example, to hold the current contents of the user’s shopping cart.

这些特性特别适合*业务对象*的集合：例如在购物 Web 应用中，
保存用户购物车的当前内容。

That was a quick overview of what built_collection provides and why; more information is available on the [github page](https://github.com/google/built_collection.dart). To make best use of immutable collections, though, you need immutable classes. Next up: [built_value](http://github.com/google/built_value.dart)!

以上就是 built_collection 提供什么以及为什么提供的快速概览；
更多信息见 [GitHub 页面](https://github.com/google/built_collection.dart)。
不过，要充分发挥不可变集合的威力，你还需要不可变的类。
下一篇：[built_value](http://github.com/google/built_value.dart)！

Edit: [next article](https://medium.com/@davidmorgan_14314/darts-built-value-for-immutable-object-models-83e2497922d4#.7uhmlrcz3).

编辑补充：[下一篇文章](https://medium.com/@davidmorgan_14314/darts-built-value-for-immutable-object-models-83e2497922d4#.7uhmlrcz3)。