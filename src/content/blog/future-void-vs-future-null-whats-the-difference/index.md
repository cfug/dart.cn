---
# title: "Future<void> vs Future<Null>, what’s the difference?"
title: "Future<void> 与 Future<Null> 有什么区别？"
# description: "One of the nice upgrades we were able to do in Dart 2 (in addition to better static checking, runtime type safety, optional new/const…"
description: "我们在 Dart 2 中完成的漂亮升级之一（除了更好的静态检查、运行时类型安全、可选的 new/const 之外……）"
ai-translated: true
publishDate: 2018-10-30
author: mfairhurst
image: images/0x0J9DBRyATjtQn42.webp
category: deep-dive
layout: blog
---


One of the nice upgrades we were able to do in [Dart 2](/blog/announcing-dart-2-stable-and-the-dart-web-platform) (in addition to better static checking, runtime type safety, optional new/const, core library improvements, and more) is to formalize `void` in a way that’s both more useful and less error-prone. This is especially clean in async programming where you can write `Future&lt;void&gt;` for asynchronous functions that don’t return an answer when their work completes. Before this you probably used `Future&lt;Null&gt;`, so common questions we get asked are: What’s the difference between `Future&lt;void&gt;` and `Future&lt;Null&gt;`? Which should I use, and when?

我们在 [Dart 2](/blog/announcing-dart-2-stable-and-the-dart-web-platform) 中完成的漂亮升级之一
（除了更好的静态检查、运行时类型安全、可选的 new/const、
核心库改进等等之外），是把 `void` 正规化，
让它既更有用又更不容易出错。
这在异步（async）编程中尤其干净利落：
对于工作完成后不返回结果的异步函数，你可以写 `Future&lt;void&gt;`。
在此之前你用的多半是 `Future&lt;Null&gt;`，
所以我们经常被问到：`Future&lt;void&gt;` 和 `Future&lt;Null&gt;` 有什么区别？
我该用哪个，什么时候用？

<DashImage src="images/0x0J9DBRyATjtQn42.webp" alt="Retro meme of a man gesturing beside the text 'VOID*'." />


Since my goal here is to be useful, I’m going to start with a TLDR.

既然我的目标是实用，那就先来个太长不看版（TLDR）。

TL;DR: **You want to use the void type 99.99% of the time.**

太长不看版：**99.99% 的情况下你都应该用 void 类型。**

I also recommend you turn on two `void`-related [lint rules](https://www.dartlang.org/guides/language/analysis-options) in your projects, right now:

我还建议你现在就在项目里开启两条与 `void` 相关的
[lint 规则](https://www.dartlang.org/guides/language/analysis-options)：

* **prefer_void_to_null:** Helps keep you from slipping back into the habit of typing the mostly-antiquated `Null`.

  **prefer_void_to_null：**帮你避免滑回给基本过时的 `Null`
  写类型的老习惯。

* **void_checks:** Gives you voidness semantics that you may find more intuitive, even though they are not strictly necessary for safe code.

  **void_checks：**给你更符合直觉的 void 语义，
  尽管它对代码安全并非严格必需。

The rest of this article is not light reading. It is a combination of history, edge cases, and type theory. What I’m about to write is like trying to explain a [Monad](https://en.wikipedia.org/wiki/Monad_(functional_programming)), but I’ll do my best, and I hope you follow along for the ride.

本文接下来的内容并不轻松。它糅合了历史、边界情况和类型理论。
我接下来要写的东西就像试图解释
[Monad（单子）](https://en.wikipedia.org/wiki/Monad_(functional_programming))，
但我会尽力而为，也希望你能一路跟下来。

## Quick Future&lt;Null&gt; trivia

## Future&lt;Null&gt; 小知识问答

To demonstrate the value you might get out of reading this post, I pose a trivia question for you.

为了展示读这篇文章可能带来的收获，我先出一道小问答。

Say we limit ourselves to two `Future`s — a `Future&lt;User&gt;` and a `Future&lt;Null&gt;`. What do the following lines of code do?

假设我们只用两种 `Future`——`Future&lt;User&gt;` 和 `Future&lt;Null&gt;`。
下面这几行代码会发生什么？

```
// does this fail in your editor?
Future<User> f1 = Future<Null>.value(null);

// does this fail at runtime?
Future<Null> f2 = Future<User>.value(0);
```


Does it help if we switch to awaits?

换成 await 会有帮助吗？

```
User u = await Future<Null>.value(null);
Null n = await Future<User>.value(0);
```


**pauses for dramatic effect**

**（停顿，制造悬念）

The answer is that none of these four lines will show any errors in your editor, unless you have disabled implicit downcasts. That’s right, taking a `Future&lt;Null&gt;` and pretending it’s something it isn’t, like `Future&lt;User&gt;`, is 100% legal. This is not the case with `Future&lt;void&gt;`!

答案是：这四行代码在你的编辑器里都不会报错，
除非你禁用了隐式向下转型（implicit downcast）。
没错，拿一个 `Future&lt;Null&gt;` 假装它是别的东西，
比如 `Future&lt;User&gt;`，是 100% 合法的。
`Future&lt;void&gt;` 可不是这样！

Also unintuitively, the second and fourth lines fail at runtime (it’s not “safe” to throw away the result of a `Future` in this way), and the others succeed silently.

同样反直觉的是，第二行和第四行会在运行时失败
（以这种方式丢弃 `Future` 的结果并不“安全”），
而另外两行则悄无声息地成功了。

These behaviors should make you uncomfortable. But don’t worry! You already know the solution: use `Future&lt;void&gt;`. I’ll break down why this unintuitive behavior works this way.

这些行为应该让你感到不安。但别担心！你已经知道解决方案了：
用 `Future&lt;void&gt;`。下面我来拆解这种反直觉行为为什么会这样。

## How void works now

## void 现在如何工作

I debated a lot to myself about what the best ordering would be for this article. There are lots of concepts to explain here. However, I will try to go in order of most useful information to least useful information. Therefore, with void being much more useful than `Null` in Dart 2, it makes sense to start with Dart 2 `void` semantics.

关于这篇文章的最佳顺序，我内心纠结了很久。
这里有很多概念要解释。不过，我会尽量按信息从最有用到最没用的顺序讲。
因此，既然在 Dart 2 中 void 比 `Null` 有用得多，
从 Dart 2 的 `void` 语义讲起就顺理成章。

The fundamental idea behind `void` in Dart is derived from the goal that a `void` value should not be used.

Dart 中 `void` 背后的基本理念源自一个目标：
`void` 值不应该被使用。

```
void f() {}
print(f()); // error!
```


This is hopefully what you expect to happen! So with that, so far so good.

希望这正是你预期的行为！到目前为止，一切顺利。

It’s worth noting that achieving this goal *and* opening up `void` as a fairly normal type can get a bit weird:

值得注意的是，既要实现这个目标，*又*要把 `void`
开放成一个相当普通的类型，事情会变得有点怪：

```
f(void argument) {
  print(argument); // Error!
  // we can receive the argument, but we may not use it!
}
```


And this is where, in Dart 2, our new “generalized void” starts to get cool, and powerful…albeit sometimes confusing.

正是在这里，Dart 2 全新的“泛化 void（generalized void）”
开始变得酷炫而强大……尽管有时令人困惑。

I pose the question to you…what type of value could we pass in as the argument of `f`?

我来问你……什么类型的值可以作为 `f` 的参数传进去？

```
f(void argument) { … }
f(x); // what is x?
```


The answer to this is…anything! Because we don’t let you use the value of `x` inside the function `f`, we can confidently say that there *is no value* that `x` can take *that could cause any runtime errors*.

答案是……什么都行！因为我们不允许你在函数 `f` 内部使用 `x` 的值，
我们可以有把握地说：*不存在*任何一个 `x` 可取的值
*能引发运行时错误*。

```
f(1); // will have no difference compared to
f(“foo”); // will have no difference compared to
f([1, 2, 3]); // will have no difference compared to
// ...
```


If we derive the best semantics for `void` based on the idea that it is a value that will not be *used*, this is what we get. Which means, it’s a value that can be *filled* with absolutely anything. It’s like a vacuum: an input with no output.

如果我们基于“`void` 是一个不会被*使用*的值”这一理念
推导它的最佳语义，得到的就是上面这些。
这意味着它是一个可以用任何东西*填充*的值。
它就像一个真空：有输入，无输出。

Now, there are cases where something is always error-free at runtime, but still should cause static errors. This is a great case for a lint! And indeed this is the idea behind the `void_checks` lint. It looks for places where you pass anything but `null` into a `void` location, and I would encourage teams to enable it. It’s not required for soundness, but passing anything other than `null` into a `void` location is still likely to be an accident, which the lint will flag for you.

当然，有些情况在运行时永远不会出错，却仍然应该触发静态错误。
这正是 lint 大显身手的地方！
`void_checks` 这条 lint 背后的想法正是如此。
它会查找你把 `null` 以外的东西传入 `void` 位置的地方，
我鼓励各团队启用它。它对类型健全性（soundness）并非必需，
但把 `null` 以外的东西传入 `void` 位置仍然很可能是个失误，
这条 lint 会替你标记出来。

Since all of this is grounded in foundational type theory, `void` plays well with every part of Dart, even in continuations leveraging type inference in the context of a `Future&lt;void&gt;`:

由于这一切都扎根于基础类型理论，`void` 与 Dart 的各个部分
都配合良好，哪怕是在 `Future&lt;void&gt;` 上下文中
利用类型推断的续体（continuation）里：

```
Future<void>().then((x) {
  print(x); // error! x has type “void” so you can’t print it!
  // This is what we want!
});

// and yes, this is an error too:
Foo f = await voidFuture();
```


At this point, the average developer probably knows everything they need to know about `void` in order to effectively use it.

到这里，普通开发者大概已经掌握了有效使用 `void`
所需的全部知识。

<DashImage src="images/0_2MNvj3It63IUFUH.webp" alt="Robot reaction GIF with the subtitle 'Congratulations. You are being rescued'." />


If you are still following along, however, there are a few more interesting nuggets.

不过，如果你还在跟着读，后面还有一些有趣的干货。

Even with `void_checks` enabled, `void` locations will not be guaranteed to contain `null`. Take this override:

即使启用了 `void_checks`，也不保证 `void` 位置里装的是 `null`。
看看这个覆盖（override）：

```
class A {
  void f(Object o) {}
}

class B extends A {
  @override
  Object f(Object o) => o;
}
```


We don’t want to make this override illegal, because it’s safe, useful, and would be a breaking change from Dart 1. And so we are forced to accept that `void` locations may hold absolutely any value. We also cannot “optimize out” the value that `A.f()` returns, because at runtime it may be a `B`!

我们不想把这种覆盖判为非法，因为它是安全、有用的，
而且相对 Dart 1 来说判非法就是破坏性变更。
于是我们不得不接受：`void` 位置可能装着任何值。
我们也不能把 `A.f()` 返回的值“优化掉”，
因为运行时它可能是个 `B`！

Rather, we have the clever option of making `void` a sister type of `Object`. After all, it may hold any value, and all values are `Objects`. This is not something we designed, it’s just reality. Recognizing that reality makes it something we can then leverage.

相反，我们有一个聪明的选择：让 `void` 成为 `Object` 的姊妹类型。
毕竟它可能装任何值，而所有值都是 `Object`。
这不是我们设计出来的，而是现实。
承认这个现实，我们就能反过来利用它。

<DashImage src="images/01ZUU5fNh-kmpPzMU.webp" alt="Meme text: 'Brace yourselves. Backwards compatibility is coming'." />


By making `void` a sibling of `Object`, we leave ourselves no *requirements* that a `void` value go *completely* unused. We try our best to keep `void` to itself, but we deliberately relax these restrictions in a few places for the sake of backwards compatibility:

让 `void` 成为 `Object` 的兄弟类型，意味着我们不再*要求*
`void` 值*完全*不被使用。我们尽力让 `void` 安分守己，
但为了向后兼容，我们在少数几处刻意放宽了这些限制：

```
dynamic f() => voidFn(); // this is legal
voidFn() as dynamic; // this is legal
```


These are special cases that would be legal for an `Object`, and we made it legal for `void`, too, in the interest of making Dart 2 a smoother rollout.

这些对 `Object` 来说合法的特例，我们出于让 Dart 2
更平稳落地的考虑，也让它们对 `void` 合法。

Making `void` a sibling of `Object` also means that `void` can be used as a type parameter without bloating the compiled output (no “template specialization,” for you C++ folk). This reduction is good for keeping web & Flutter apps small, at the expense of allowing the following:

让 `void` 成为 `Object` 的兄弟类型还意味着：
`void` 可以用作类型参数而不让编译产物膨胀
（C++ 的朋友们，没有“模板特化”）。
这种精简有利于保持 Web 和 Flutter 应用的小体积，
代价是允许下面这样的代码：

```
<void>[1, 2, 3].toString(); // this is legal and prints [1, 2, 3]
```


And lastly, it may seem useless to ever type a parameter as `void`, especially since it’s a form of `Object`. However, `void` values can be *passed to* `void` *locations*:

最后，把参数声明为 `void` 类型似乎毫无用处，
尤其因为它还是 `Object` 的一种形式。
然而，`void` 值可以被*传入* `void` *位置*：

```
f(void x) { … }
f(voidFn()); // this is legal
```


This is useful for *sequencing*, which is for instance used by [Mockito](https://pub.dartlang.org/packages/mockito) when mocking methods that return `void`. (Replace `f` with `when` in the above code for a closer approximation.)

这对*排序执行（sequencing）*很有用，例如
[Mockito](https://pub.dartlang.org/packages/mockito) 在 mock
返回 `void` 的方法时就用到了它。
（把上面代码里的 `f` 换成 `when`，就更接近实际用法了。）

In summary:

总结一下：

* The `void` type is a sibling of `Object`.

  `void` 类型是 `Object` 的兄弟类型。

* Almost always, a `void` object can’t be used.

  几乎在所有情况下，`void` 对象都不能被使用。

* Something marked `void` could be, in practice, absolutely anything.

  标记为 `void` 的东西，实际上可能是任何值。

* Anything can be “thrown away” into a location marked `void`, and the lint `void_checks` restricts this behavior.

  任何东西都可以被“丢弃”到标记为 `void` 的位置，
  lint `void_checks` 会限制这种行为。

* A `void` value can be passed into other `void` locations.

  `void` 值可以传入其他 `void` 位置。

## The bottom type

## 底类型

Before I get to talking about `Null`, it’s critical we talk about the “bottom” type.

在开始谈 `Null` 之前，我们必须先谈谈“底（bottom）”类型。

This is a naturally occurring type in type theory, which has a short academic definition with a few practical applications.

这是类型理论中自然存在的一种类型，
学术定义很短，也有一些实际应用。

If you stop reading this section because *it’s so dang weird*, that is strong evidence of my original TLDR. Unless you want your code to be similarly dang weird, you probably want `void`. Now let’s explore this weird rabbit hole and see how far it goes, eh?

如果你因为*它实在太怪了*而不再往下读，
那恰恰有力地印证了我开头的太长不看版。
除非你想让自己的代码也一样怪，否则你多半该用 `void`。
现在，让我们钻进这个奇怪的兔子洞，看看它有多深，如何？

The bottom type is the subtype of all types. Put in simpler object-oriented terms, that means it’s a `Person`. And a `Car`. And an `Animal`. And every other type from every program ever written.

底类型是所有类型的子类型。用更简单的面向对象术语来说，
它既是 `Person`，也是 `Car`，也是 `Animal`，
还是有史以来所有程序里的每一种类型。

If this sounds absurd, that’s because it is. I like to think of it as a “placeholder” type. But “absurd” or “imaginary” type would also be a somewhat reasonable name for it. Instead, though, it’s called the *bottom* type, because it’s the bottom of the type hierarchy, which, in computer science, is upside down. ¯\_(ツ)_/¯. Formally, it may be referred to by the symbol ⊥, which you may also recognize as the symbol for “false.”

如果这听起来很荒谬，那是因为它确实荒谬。
我喜欢把它想成一种“占位”类型。
不过叫它“荒谬”类型或“虚构”类型也算合理。
但它实际叫*底（bottom）*类型，因为它位于类型层级的最底部，
而计算机科学里的类型层级是倒着画的。¯\_(ツ)_/¯。
正式场合它用符号 ⊥ 表示——你可能也认得，这是表示“假”的符号。

If you try to imagine a value that is a `Person` *and* a `Car` *and* an `Animal`, you won’t be able to think of anything. And surprisingly, that is where the practical usage of ⊥ comes from!

如果你试图想象一个既是 `Person` *又是* `Car` *又是* `Animal` 的值，
你什么都想不出来。而令人惊讶的是，
⊥ 的实际用途恰恰由此而来！

What if I write a function that never returns? There are two easy ways to do so:

如果我写一个永不返回的函数呢？有两种简单的写法：

```
loopForever() {
  while(true); // first way
}

alwaysThrow() {
  throw Exception(); // second way
}
```


What is the best return type for these two functions?

这两个函数的最佳返回类型是什么？

It depends. Because the function never returns, the return type doesn’t really matter. You can use any type — even the absurd bottom type, which can be used in various ways in various languages.

看情况。因为函数永不返回，返回类型其实无所谓。
你可以用任何类型——甚至是荒谬的底类型，
它在各种语言中有各种用法。

<DashImage src="images/0TkwIX5BsrbSzHfLr.webp" alt="Meme text: 'You can't have a runtime error in code that never runs'." />


C++ has this as `noreturn`. Rust has `!`, and Scala has `Nothing`. But my favorite example comes from Haskell, which has a very commonly used `undefined` function that aborts the program. It returns, you guessed it, the bottom type.

C++ 里它叫 `noreturn`。Rust 里是 `!`，Scala 里是 `Nothing`。
但我最喜欢的例子来自 Haskell：它有一个非常常用的
`undefined` 函数，会中止程序。
它返回的——你猜对了——正是底类型。

If we assume an `undefined` function in Dart like the one in Haskell, which merely throws an exception when called and returns ⊥, then it would look like the following:

假设 Dart 里也有一个像 Haskell 那样的 `undefined` 函数，
调用时只是抛出异常并返回 ⊥，那么用法会是这样：

```
Foo foo = cond ? val : undefined();
```


In the example usage line, the program can safely run and store `val` when `cond` is true. And when `cond` is false, the program will throw an exception during `undefined()`. It is safe to “store” the result of `undefined()` in foo, regardless of the type of `foo`, because that store will never actually happen!

在这行示例用法中，当 `cond` 为 true 时，
程序可以安全运行并把 `val` 存起来。
当 `cond` 为 false 时，程序会在 `undefined()` 处抛出异常。
把 `undefined()` 的结果“存”进 foo 是安全的，无论 `foo` 是什么类型，
因为这次存储实际上永远不会发生！

`undefined()` ****here does not return anything. But the lesson here is not that we can make `foo` empty…it’s that the bottom type is empty like an empty promise. It’s emptier than empty. It just never happens.

这里的 `undefined()` ****并不返回任何东西。
但这里的教训不是我们可以让 `foo` 为空……
而是底类型的“空”就像一张空头承诺。
它比空还要空。它根本不会发生。

One thing I must be careful to state is that you can and, depending on the usage, often should return `void` from these functions in practice. Usually code like `return loopForever()` is more likely to be a mistake than a useful pattern. However, the choice is yours to make.

有一点我必须谨慎说明：实践中你可以、
而且视用法往往应该让这些函数返回 `void`。
通常，像 `return loopForever()` 这样的代码更可能是失误
而不是有用的模式。不过，选择权在你。

The bottom type is also nice for read-only empty lists. In Dart, `List`s are covariant, so a `List&lt;int&gt;` is allowed to be used as a `List&lt;Object&gt;`. If you then attempt to stick a `String` inside that `List&lt;Object&gt;`, a runtime check will catch that for you and throw an error.

底类型对只读空列表也很好用。在 Dart 中，`List` 是协变
（covariant）的，所以 `List&lt;int&gt;` 可以当作 `List&lt;Object&gt;` 使用。
如果你随后试图往那个 `List&lt;Object&gt;` 里塞一个 `String`，
运行时检查会替你抓住并抛出错误。

That means that if we make a `List` of ⊥, there’s nothing we can put into it, but we can treat it as a list of anything:

这意味着，如果我们创建一个元素类型为 ⊥ 的 `List`，
没有任何东西能放进去，但我们可以把它当作任何类型的列表：

```
List<int> intList = <⊥>[];
  for(int i in intList) {
  print(i * 2); // valid, because this simply never happens
}
```


There are even more interesting cases when you look at what’s called “contravariant” placement of the bottom type.

当你考察底类型所谓的“逆变（contravariant）”位置时，
还有更有趣的情况。

<DashImage src="images/0OyVAekp1iwSQyfur.webp" alt="Meme close-up of a person gesturing with the word 'Contravariance'." />


Let’s say we define a function that has a ⊥ parameter:

假设我们定义一个带 ⊥ 参数的函数：

```
void f(⊥ x) {}
```


This is almost the opposite of the `undefined()` example. Rather than a function that never returns, we have declared a function that can’t be called! No actual value is assignable to that parameter `x`. You can’t pass in a `Person` because it’s *not also a* `Car`, and you can’t pass in a `Car` because it’s not also a `Person`. The only thing you could pass in is the absurd type itself:

这几乎和 `undefined()` 的例子相反。
我们声明的不是一个永不返回的函数，而是一个无法被调用的函数！
没有任何实际的值可以赋给参数 `x`。
你不能传入 `Person`，因为它*并不也是* `Car`；
你也不能传入 `Car`，因为它并不也是 `Person`。
你唯一能传入的就是这个荒谬类型本身：

```
f(undefined());
```


But as we just covered before, `undefined()` never returns, so `f()` is still never actually called in this case!

但正如刚才所说，`undefined()` 永不返回，
所以这种情况下 `f()` 实际上仍然从未被调用！

Typing a parameter as ⊥ may seem useless, but it has esoteric value because all functions that *can* be called are subtypes of functions that *can’t* be. **(Think about it: a function that *can* be called doesn’t *have* to be. And if a function is not called, it cannot produce runtime errors.)

把参数声明为 ⊥ 看似无用，却有一种深奥的价值：
所有*能*被调用的函数都是*不能*被调用的函数的子类型。
**（想想看：一个*能*被调用的函数并不*必须*被调用。
而一个函数如果不被调用，就不可能产生运行时错误。）

If you’re still with me, take a deep breath and pat yourself on the back.

如果你还跟得上，深呼吸一下，拍拍自己的肩膀吧。

Specifically, it’s safe to cast any `Function(X)` to a `Function(⊥)`, for any `X`. This is better than using Dart’s all-encompassing `Function` type, because it’s more specific.

具体来说，对任何 `X`，把 `Function(X)` 转换成 `Function(⊥)`
都是安全的。这比使用 Dart 包罗万象的 `Function` 类型更好，
因为它更具体。

With this you can, for instance, store any unary function in a field and call it dynamically, to get past static errors and replace them with runtime errors if you made a mistake:

有了它，你就可以把任意一元函数存进字段并动态调用，
从而绕过静态错误——如果你犯了错，就换成运行时错误：

```
Function(⊥) f;
f = (int x) => x + 1;

// the validity of 123 as an argument to f is checked at runtime
(f as dynamic)(123);
```


This is a neat trick to help you in a pinch.

这是个应急时能帮到你的小技巧。

Now we can talk about `Null`.

现在我们可以谈 `Null` 了。

## Null in Dart 2

## Dart 2 中的 Null

The conceptual “bottom” type (a type which is a subtype of all types) exists in Dart, but that’s not all. Such a value also exists in Dart 2! In Dart we call it `Null`, and that value is — you guessed it — `null`.

概念上的“底”类型（所有类型的子类型）在 Dart 中是存在的，
但还不止于此。这样的值在 Dart 2 中也存在！
在 Dart 里我们把它叫作 `Null`，而那个值——你猜对了——就是 `null`。

Since I can make anything `null`(/`Null`), the absurd type is not so absurd in Dart. Which makes it a bit complicated.

既然我可以让任何东西变成 `null`（/`Null`），
荒谬类型在 Dart 里就没那么荒谬了。这也让事情变得有点复杂。

Note: The value `null`, of course, is not a `Car`, and it’s not a `Person`. And we do get requests for non-nullable types in Dart. So if we do make such a change to Dart, we’ll need a new bottom type, likely named something to the effect of `Nothing`, and it will be a truer bottom type at that.

注意：值 `null` 当然不是 `Car`，也不是 `Person`。
我们也确实收到过在 Dart 中引入非空类型的请求。
所以如果我们真的对 Dart 做这样的改动，就需要一个新的底类型，
名字大概类似 `Nothing`，而且那才会是更纯粹的底类型。

Not only does `Null` have all the same absurd usages as the bottom type, but it also has an escape hatch. If you ever really need to return from a function that can’t return, or call a function that can’t be called, we give you an out! You can pass `null` in there! It would be, honestly, a bit unfair of us to do otherwise, when you look at the whole picture.

`Null` 不仅拥有底类型的全部荒谬用法，还带有一个逃生舱口。
如果你真的需要从一个不能返回的函数中返回，
或者调用一个不能被调用的函数，我们给你留了出路！
你可以把 `null` 传进去！说实话，纵观全局，
如果我们不这么做，反倒有点不近人情。

It does give a whole lot of caveats, though, to an otherwise simple declaration:

不过，这确实给一个本来很简单的声明带来了一大堆注意事项：

```
Null nothing() => null;
```


`Null` is the most specific type for `foo()`, so it’s a logical choice and a good starting place. The analyzer is also kind enough to warn you if you call methods on it that don’t exist:

`Null` 是 `foo()` 最具体的类型，
所以它是合乎逻辑的选择和不错的起点。
analyzer 也会好心地在你调用它上面不存在的方法时发出警告：

```
nothing().x; // error! No member x on Null
```


But this may give a false illusion of safety.

但这可能给你一种虚假的安全感。

```
nothing().toString(); // no error: Null defines toString()
Foo foo = nothing(); // no error: foo will become null

// Acceptable for all parameter types in f(x),
// runtime errors if f(x) expects non-null
f(nothing());
```


If your goal is for `nothing()` to be a synonym for `null`, then this would be the behavior you want, and `Null` is the correct type for your function that returns `null`.

如果你的目标是让 `nothing()` 成为 `null` 的同义词，
那这正是你想要的行为，`Null` 也是你那个返回 `null`
的函数的正确类型。

There were good reasons for suggesting `Future&lt;Null&gt;`, and it worked while we were coming up with the new `void` semantics. However, it has the same holes:

当年推荐 `Future&lt;Null&gt;` 有充分的理由，
在我们制定新的 `void` 语义期间它也确实好用。
然而，它有同样的漏洞：

```
(await futureNull()).toString(); // no error!
Foo foo = await futureNull(); // no error!
```


Essentially, by making some function `f()` return a `Future&lt;Null&gt;`, you are making `await f()` a synonym of `null` in your program! That’s dangerous because you can use `null` as if it were absolutely anything, absolutely any type. I don’t think that’s what most people want.

本质上，让某个函数 `f()` 返回 `Future&lt;Null&gt;`，
就是在你的程序里把 `await f()` 变成了 `null` 的同义词！
这很危险，因为你可以把 `null` 当作任何东西、任何类型来使用。
我认为这不是大多数人想要的。

<DashImage src="images/04NDBhLva40BBuX0f.webp" alt="Meme text: 'Null is not the type you are looking for'." />


Why else might you use `Future&lt;Null&gt;` instead of `Future&lt;void&gt;`? It all goes back to that mind-boggling bottom type. You might consider `Future&lt;Null&gt;` for futures that must be awaitable but that never complete, or that always complete with an error. This is directly comparable to why a function would return `Null`.

还有什么理由让你用 `Future&lt;Null&gt;` 而不是 `Future&lt;void&gt;`？
一切都要回到那个令人费解的底类型。
对于那些必须可以 await、但永不完成，
或总是以错误完成的 future，你可以考虑 `Future&lt;Null&gt;`。
这与函数返回 `Null` 的理由完全对应。

The same logic applies to `Stream&lt;Null&gt;`: Use this for a `Stream` that never sends any events. This is directly comparable to why a read-only empty list may be typed as `List&lt;Null&gt;`.

同样的逻辑适用于 `Stream&lt;Null&gt;`：
把它用于一个永不发送任何事件的 `Stream`。
这与只读空列表可以声明为 `List&lt;Null&gt;` 的理由完全对应。

Some trickier types to provide a guideline for are `StreamController&lt;Null&gt;` and `Sink&lt;Null&gt;`. These are comparable to functions. The most sound reason to use these types is to say that they should never be used. The next most sound is that you would like them to accept only synonyms of `Null`, which is reasonable only if you don’t have `void_checks` turned on.

更难给出指导的类型是 `StreamController&lt;Null&gt;` 和 `Sink&lt;Null&gt;`。
它们与函数类似。使用这些类型最站得住脚的理由，
是声明它们永远不应该被使用。
其次站得住脚的理由，是你希望它们只接受 `Null` 的同义词——
只有在你没开 `void_checks` 时这才说得通。

Imagine that Dart did not have `null` as an escape hatch for all values. Would you want to make a type `Sink&lt;⊥&gt;` that can only accept events from a `Stream&lt;⊥&gt;`, which itself never broadcasts an event? If the answer is yes, then go for it and make a `Sink&lt;Null&gt;`.

想象 Dart 没有把 `null` 作为所有值的逃生舱口。
你会想造一个 `Sink&lt;⊥&gt;` 类型，
它只能接受来自 `Stream&lt;⊥&gt;` 的事件，
而后者本身从不广播任何事件吗？
如果答案是会，那就放手去造一个 `Sink&lt;Null&gt;` 吧。

All of these usages have weak guarantees because the value `null` itself is an escape hatch for why you otherwise would be most likely to use the `Null` type itself. However, do not make the mistake of thinking that the *value* is the escape hatch itself, rather than the bunker. One is safe and sturdy and the other is to save you the effort of digging upwards through reinforced concrete when the bunker catches on fire with you in it.

所有这些用法的保证都很弱，因为值 `null` 本身就是一个逃生舱口，
恰恰对应你最可能使用 `Null` 类型的那些理由。
不过，千万别误以为这个*值*是逃生舱口本身，
而不是那个掩体。一个是安全坚固的掩体，
另一个则是为了让你在地堡着火、你还被困在里面时，
省得费力向上凿穿钢筋混凝土。

<DashImage src="images/0yepcr98D1YlpsRJF.webp" alt="Meme text: 'I don't always use null in my Dart code, but when I do, I leave a long comment explaining why.'" />


In summary, here are the main uses of typing something as `Null`:

总结一下，把某个东西声明为 `Null` 的主要用途有：

* As a synonym for `null`, usable everywhere as everything

  作为 `null` 的同义词，在任何地方当作任何东西使用

* As a placeholder for execution your program will never reach

  作为程序永远不会执行到的地方的占位符

* As a container that must stay empty so that it can masquerade as any type

  作为一个必须保持为空的容器，好让它能冒充任何类型

* As an output with no inputs

  作为一个没有输入的输出

## Final comparison

## 最终对比

*If you reached this point of the article, you deserve some sort of recompense — reach out to me and I’ll see about buying you a beer next time you’re free in Portland OR. :)*

*如果你读到了文章的这里，你值得某种奖励——
联系我，下次你在俄勒冈州波特兰有空时，我看看能不能请你喝杯啤酒。:)*

I talked a lot about the bottom type, but I didn’t get into its opposite at all, Top. The top type is, as you would expect, the polar opposite of the bottom type. And while Dart’s name for the bottom type is `Null`, Dart’s name for the top type is one of `dynamic`, `Object`, and `void` (three heads of the same coin).

我讲了大量底类型的内容，却完全没有涉及它的对立面：顶（Top）。
顶类型，正如你所预料的，是底类型的两极对立面。
Dart 给底类型起的名字是 `Null`，
而给顶类型起的名字则是 `dynamic`、`Object` 和 `void` 之一
（同一枚硬币的三个面）。

It may seem strange that words like “nothing” and “empty” in English can mean two such dissimilar things in type theory. Both are suitable descriptions of the exact opposite top and bottom types, and therefore, of `Null` and `void`. It may seem strange that two opposite types are appealing candidates for the same job! It may seem frustrating that Dart has so many weird quirks and edge cases, now that you’re reading up on which to use.

英语里 “nothing” 和 “empty” 这样的词，
在类型理论中竟能指两种如此不同的东西，这可能看起来很奇怪。
它们都适合描述恰好相反的顶类型和底类型，
因而也适合描述 `Null` 和 `void`。
两个相反的类型竟是同一份工作的热门候选，这可能看起来很奇怪！
当你正在研究该用哪个时，发现 Dart 有这么多怪癖和边界情况，
可能会让人沮丧。

<DashImage src="images/0ybPT9jlu0yGAnu2v.webp" alt="An illustration showing frustration with quirks and edge cases in type theory." />


Our mistake, I think, was in ever recommending `Null` to be used like `void` in the first place. It would at the time have been a disservice to users to withhold what was useful advice, given Dart 1 semantics. But we accidentally made a *very* esoteric type *very* commonly used.

我想，我们的错误在于当初就不该推荐把 `Null` 当 `void` 用。
考虑到 Dart 1 的语义，当时不给出这条有用的建议对用户是种亏欠。
但我们无意间让一个*非常*深奥的类型变得*非常*常用。

Well you’ve read the article now. What do you think? Do you expect to come across a valid use for `Null` any time soon? Do you have a firm understanding of where it’s useful?

好了，文章你已经读完了。你怎么看？
你预计近期会遇到 `Null` 的合理用途吗？
你是否已经清楚它在哪里有用？

And more importantly, can you help us spread the good news that `void` is here to make it all simpler?

更重要的是，你能帮我们传播这个好消息吗——
`void` 来了，让这一切都更简单？
