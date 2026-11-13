---
# title: "Pedantic Dart"
title: "较真的 Dart"
# description: "Over at Dart’s package:pedantic, we’ve been slowly gathering a list of precisely correct lints you can apply to your Dart code."
description: "在 Dart 的 package:pedantic 里，我们一直在慢慢收集一份精确正确的 lint 清单，你可以把它们应用到自己的 Dart 代码上。"
ai-translated: true
publishDate: 2019-05-22
author: davidmorgan
image: images/1QCajckOeBhRaLzi0RoFqig.webp
category: other
layout: blog
---


<DashImage src="images/1QCajckOeBhRaLzi0RoFqig.webp" alt="The Dart logo." />


[Flutter](https://flutter.dev/) and [Flutter Web](https://flutter.dev/web) are generating plenty of buzz, and deservedly so; they are pushing the boundaries of UI development. Flutter is written in Dart, and Dart has just [gained a number of features](/blog/making-dart-a-better-language-for-ui) under the banner “UI as Code” that will bring joy to every Flutter developer’s day. These are exciting times.

[Flutter](https://flutter.dev/) 和
[Flutter Web](https://flutter.dev/web) 正引发大量关注，而且实至名归；
它们正在拓展 UI 开发的边界。Flutter 用 Dart 编写，
而 Dart 刚刚在 “UI as Code” 的旗帜下
[新增了一批特性](/blog/making-dart-a-better-language-for-ui)，
会让每位 Flutter 开发者的一天都充满欢乐。这是令人兴奋的时代。

But, wait! Not everything should move fast. Sometimes it pays to be meticulous, fussy, fastidious, finicky, or—dare I say it—*pedantic*. So, over at Dart’s [package:pedantic](https://github.com/dart-lang/pedantic), we’ve been slowly gathering a list of *precisely correct lints* that you can apply to your code.

但是，等等！不是所有事情都要快。
有时候，一丝不苟、吹毛求疵、精益求精、斤斤计较，
或者——恕我直言——*较真（pedantic）*，反而有回报。
所以，在 Dart 的 [package:pedantic](https://github.com/dart-lang/pedantic) 里，
我们一直在慢慢收集一份*精确正确的 lint* 清单，
你可以把它们应用到自己的代码上。

Of course, to check lints you need a linter. The [Dart linter](https://github.com/dart-lang/linter) is built right into the [Dart analyzer](https://github.com/dart-lang/sdk/tree/master/pkg/analyzer), which means its 146 lints (as I write this) are available everywhere you want them: on the command line, in your presubmit, and in your IDE. As a Dart (or Flutter) developer you have hundreds of lints at your fingertips; the only problem is deciding *which* lints to enable.

当然，要检查 lint，你需要一个 linter。
[Dart linter](https://github.com/dart-lang/linter) 直接内置在
[Dart 分析器（analyzer）](https://github.com/dart-lang/sdk/tree/master/pkg/analyzer)里，
这意味着它的 146 条 lint（写本文时）在你想要的任何地方都可用：
命令行、presubmit 检查和 IDE。
作为 Dart（或 Flutter）开发者，数百条 lint 触手可及；
唯一的问题是决定启用*哪些* lint。

This is a trickier problem than it might seem. If all you’d like to do is use the lints recommended by package:pedantic, no need to read on; simply [follow these instructions](https://dart.dev/guides/language/analysis-options#default-google-rules-pedantic).

这个问题比看上去更棘手。
如果你只想使用 package:pedantic 推荐的 lint，那不必往下读了；
直接[按照这些说明操作](https://dart.dev/guides/language/analysis-options#default-google-rules-pedantic)即可。

Still with me? Great. Now, let’s dig into why you can’t just enable all 146 lints and start coding. We’ll begin with the simplest reasons, and work up. Then we’ll see exactly how a lint is evaluated for inclusion in package:pedantic, work through an example of a lint that was particularly troublesome to enforce, and finish with some pointers to how you could get involved.

还在看？太好了。现在，让我们深入探究为什么不能直接启用
全部 146 条 lint 然后开始写代码。
我们会从最简单的理由讲起，逐步深入。
然后我们会看到一条 lint 是如何被评估能否进入 package:pedantic 的，
走一遍一个执行起来特别麻烦的 lint 的例子，
最后给出一些你可以参与进来的途径。

## Obsolete lints

## 过时的 lint

Some lints don’t make sense any more. An example is [super_goes_last](https://dart-lang.github.io/linter/lints/super_goes_last.html), which requires that `super` be placed last if it appears in a list of initializers. It was actually such a useful lint that with Dart 2 it became a requirement of the language, so the lint is no longer needed.

有些 lint 已经没有意义了。一个例子是
[super_goes_last](https://dart-lang.github.io/linter/lints/super_goes_last.html)，
它要求 `super` 如果出现在初始化列表中就必须放在最后。
这条 lint 实在太有用了，以至于 Dart 2 把它变成了语言本身的要求，
所以不再需要这条 lint 了。

```
// super_goes_last; now included in Dart 2, no need for a lint.
View(Style style, List children)
    : super(style), // LINT
      _children = children {
```


## Contraindicated lints

## 不宜使用的 lint

Some lints are not actually intended for public consumption. In particular, a number of lints that are designed for use within the Flutter SDK directly contradict the [Dart style guide](https://dart.dev/guides/language/effective-dart). An example is [always_specify_types](https://dart-lang.github.io/linter/lints/always_specify_types.html); over-specifying types means you lose the benefits of type inference. The style guide [carefully explains](https://dart.dev/guides/language/effective-dart/design#types) how to strike a good balance between type annotations and type inference.

有些 lint 实际上并不是给公众用的。
特别是，一些为 Flutter SDK 内部使用而设计的 lint
与 [Dart 风格指南](https://dart.dev/guides/language/effective-dart)直接冲突。
一个例子是
[always_specify_types](https://dart-lang.github.io/linter/lints/always_specify_types.html)；
过度指定类型意味着失去类型推断（type inference）的好处。
风格指南[仔细解释了](https://dart.dev/guides/language/effective-dart/design#types)
如何在类型注解和类型推断之间取得良好平衡。

```
// always_specify_types; do not use; breaks with recommended style!
var foo = 10; // LINT
final bar = new Bar(); // LINT
const quux = 20; // LINT
```


## Expensive lints

## 开销大的 lint

Evaluating lints involves arbitrary computation over a complex data structure — your source code. How do you know they won’t slow you down? Of course, every effort is made when adding lints to keep them efficient; but surprises can happen. The [library_prefixes](https://dart-lang.github.io/linter/lints/library_prefixes.html) lint had a performance bug that only surfaced in very obscure cases; now fixed, of course.

求值 lint 涉及对一个复杂数据结构——你的源代码——
进行任意计算。你怎么知道它们不会拖慢你？
当然，添加 lint 时会尽一切努力保持高效；但意外还是可能发生。
[library_prefixes](https://dart-lang.github.io/linter/lints/library_prefixes.html)
这条 lint 曾有一个只在非常罕见的情况下才暴露的性能 bug；
当然，现在已经修好了。

```
// library_prefixes; performance issue was fixed, now good to go!
import 'dart:math' as Math; // LINT
import 'dart:json' as JSON; // LINT
import 'package:js/js.dart' as JS; // LINT
```


## Redundant lints

## 冗余的 lint

Most lints are extremely fast to compute, but they’re not quite free. So a lint needs to pull its weight; it needs to offer enough value. For example, we rejected the [empty_statements](https://dart-lang.github.io/linter/lints/empty_statements.html) lint on the grounds that using `dartfmt` makes empty statements easy to spot. They’re unlikely to get written by mistake, and so the lint is redundant.

大多数 lint 计算起来极快，但并非完全免费。
所以一条 lint 得对得起它的开销；它得提供足够的价值。
例如，我们拒绝了
[empty_statements](https://dart-lang.github.io/linter/lints/empty_statements.html)
这条 lint，理由是使用 `dartfmt` 就能很容易发现空语句。
它们不太可能被误写出来，所以这条 lint 是冗余的。

```
// empty_statements; considered redundant with dartfmt.
if (complicated.expression.foo()) ; // LINT
```


## Overeager lints

## 过于激进的 lint

Some lints are not precise enough to be enforced. For example, omitting types for local variables in Dart is [good style](https://dart.dev/guides/language/effective-dart/design#avoid-type-annotating-initialized-local-variables), but only *most of the time*. It’s a recommendation, not a hard rule. That makes the corresponding lint [omit_local_variable_types](https://dart-lang.github.io/linter/lints/omit_local_variable_types.html) too strict to be enforced everywhere.

有些 lint 不够精确，不适合强制执行。
例如，在 Dart 中省略局部变量的类型是
[好风格](https://dart.dev/guides/language/effective-dart/design#avoid-type-annotating-initialized-local-variables)，
但只是*大多数时候*如此。这是一条建议，不是硬性规则。
这使得对应的 lint
[omit_local_variable_types](https://dart-lang.github.io/linter/lints/omit_local_variable_types.html)
过于严格，无法在所有地方强制执行。

```
// omit_local_variable_types; too strict. Local variable types
// are good style where they improve readability.
void myMethod() {
  MyType bar = expression.methodCall().otherMethodCall(); // LINT
}
```


## Opinionated lints

## 带有立场的 lint

Some lints push the code in a direction that’s not *wrong*, but is nonetheless unusual. An example is [prefer_final_locals](https://dart-lang.github.io/linter/lints/prefer_final_locals.html), which requires that local variables be declared, if possible, as `final`. This is a style that some developers prefer, but it’s not what *most* Dart developers prefer, and so by default the lint should be off.

有些 lint 把代码推向一个并不*错误*、但仍然少见的方向。
一个例子是
[prefer_final_locals](https://dart-lang.github.io/linter/lints/prefer_final_locals.html)，
它要求局部变量在可能的情况下声明为 `final`。
这是一部分开发者偏好的风格，但不是*大多数* Dart 开发者的偏好，
所以这条 lint 默认应该关闭。

```
// prefer_final_locals; inconsistent with common style.
void myMethod() {
  var label = 'foo'; // LINT 
}
```


## Evaluating all the lints

## 评估所有 lint

It may seem that, even taking all this into account, someone with a close knowledge of Dart should be able to sit down with the list of 146 available lints and produce a list of recommended lints without too much trouble.

看起来，即使把这一切都考虑在内，
一个非常了解 Dart 的人也应该能坐下来，
对着 146 条可用 lint 的清单，不太费劲地给出一份推荐 lint 清单。

But that isn’t what we’ve found; it’s simply too big a task. Just as each lint can do arbitrary evaluation on your code, deciding whether a particular lint is both correct and useful turns out to be almost arbitrarily hard.

但我们的发现并非如此；这任务实在太大了。
正如每条 lint 都能对你的代码做任意求值一样，
判断一条特定的 lint 是否既正确又有用，
结果也几乎是任意地困难。

A good way to approach a hard question is to ask for hard data. So when considering each lint, we first benchmark its performance and gather information on all violations of the lint currently present in Google’s internal Dart code.

处理难题的一个好办法是索取硬数据。
所以在考虑每条 lint 时，我们首先对它的性能做基准测试，
并收集 Google 内部 Dart 代码中当前所有违反该 lint 的信息。

These numbers give us a good starting point for discussion.

这些数字为我们的讨论提供了很好的起点。

If, for example, all of Google’s Dart code contains only five violations of the lint, then each had better be a serious bug; otherwise, it’s unlikely that the lint is pulling its weight. The [recursive_getters](https://dart-lang.github.io/linter/lints/recursive_getters.html) lint was a rare example of a lint catching a very small number of serious issues; a getter that calls itself is a stack overflow waiting to happen.

例如，如果 Google 的全部 Dart 代码只有五处违反这条 lint，
那每一处最好都是严重的 bug；
否则，这条 lint 就不太可能对得起它的开销。
[recursive_getters](https://dart-lang.github.io/linter/lints/recursive_getters.html)
是一个罕见的例子：一条 lint 抓到了极少量的严重问题；
一个调用自身的 getter 就是等着发生的栈溢出。

```
// recursive_getters; definitely not what you meant to write!
int get field => field; // LINT
```


If, on the other hand, we find many violations of the lint, the question turns around: the lint is going to change what a lot of developers are doing, so are we sure it’s an improvement, both overall and in each individual instance? If the lint will make a small number of cases worse, can we justify that? Or, perhaps, can we improve the lint?

另一方面，如果我们发现大量违反这条 lint 的情况，问题就反过来了：
这条 lint 将改变很多开发者的做法，
那么我们确定它是改进吗——无论整体上还是每一个具体案例？
如果这条 lint 会让少数情况变糟，我们能证明这样做合理吗？
或者，也许我们可以改进这条 lint？

The [unrelated_type_equality_checks](https://dart-lang.github.io/linter/lints/unrelated_type_equality_checks.html) lint is a good example. This lint requires that, before you are allowed to compare two objects, they must be of compatible static types. So you’re not allowed to check if `3` and `foo` are equal; it’s assumed that because one is an `int`and the other is a `String` that this question doesn’t even make sense.

[unrelated_type_equality_checks](https://dart-lang.github.io/linter/lints/unrelated_type_equality_checks.html)
这条 lint 是个好例子。它要求在比较两个对象之前，
它们必须具有兼容的静态类型（static type）。
所以你不能检查 `3` 和 `foo` 是否相等；
它假定既然一个是 `int` 而另一个是 `String`，
这个问题根本没有意义。

```
// unrelated_type_equality_checks; or, don't ask stupid questions!
void someFunction() {
  var x = '1';
  if (x == 1) print('surprise!'); // LINT
}
```


This sounds good, but it’s not correct for two reasons.

这听起来不错，但它不正确，原因有两个。

It fails in theory because of `implements`; an object can be of more than one type, and so two objects that appear statically to be unrelated might turn out at runtime to implement the same type, and be perfectly valid to compare.

它在理论上失败是因为 `implements`；一个对象可以属于多个类型，
所以两个静态看来毫无关系的对象，
运行时可能实现了同一个类型，比较它们完全有效。

```
// unrelated_type_equality_checks; objects _can_ hold surprises.
void checkForSurprise(Foo foo, Bar bar) {
  if (foo == bar) print('surprise!'); // LINT
}

abstract class Foo {}
abstract class Bar {}
class Baz implements Foo, Bar {}

void main() {
  var baz = Baz();
  checkForSurprise(baz, baz);
}
```


It fails in practice because `operator==` is left to each class author to implement, and nothing forces them to follow its contract. We found, in particular, that `Int64` and `Int32` from `package:fixnum` allow comparisons with `int`, but only when the `int` is on the right hand side of the`==`.

它在实践中失败是因为 `operator==` 留给每个类的作者去实现，
而没有任何东西强迫他们遵守其契约。
我们特别发现，`package:fixnum` 中的 `Int64` 和 `Int32`
允许与 `int` 比较，但仅当 `int` 在 `==` 的右侧时。

So, the data showed three outcomes for the lint: lots of correct findings (bugs caught), a small number of incorrect findings due to runtime types being compatible when static types were not, and a relatively large number of incorrect findings due to `Int64` being compared to `int`.

于是，数据显示这条 lint 有三种结果：大量正确的发现（抓到的 bug）、
少量因运行时类型兼容而静态类型不兼容导致的错误发现，
以及相对大量因 `Int64` 与 `int` 比较导致的错误发现。

What did we do? We improved the lint: it now knows about `Int64` (and `Int32`) and allows you to compare it to `int` as you did before. This left a very small number of false positives due to static types being incomplete; these we opted to refactor, using casts as necessary, to make them comply with the lint.

我们做了什么？我们改进了这条 lint：它现在认识 `Int64`（和 `Int32`），
并允许你像以前一样把它与 `int` 比较。
这留下了极少量因静态类型不完整导致的误报；
对这些，我们选择重构，必要时使用类型转换，让它们符合这条 lint。

With these changes, we were able to reach a consensus on having unrelated_type_equality_checks be enforced.

有了这些改动，我们就强制执行 unrelated_type_equality_checks
达成了共识。

By “we” in this instance, I mean “the set of all Google developers who care about Dart lints.” Anyone at Google who is writing Dart can get involved in this process, and many do, so we get plenty of input — particularly when a lint is controversial!

这里的“我们”，指的是“所有关心 Dart lint 的 Google 开发者的集合”。
Google 里任何写 Dart 的人都可以参与这个过程，而且很多人都在参与，
所以我们能得到大量意见——尤其是当一条 lint 有争议时！

If and when there is consensus on a lint, the next thing that happens is that the person who proposed enforcing the lint cleans up all of Google’s internal Dart code to pass the lint. Sometimes we learn something new during this process; if we missed something that would make the cleanup a breaking or difficult change, the cleanup is typically paused. Right now we have enough lints to be working on that we can just skip such cases and come back to them later.

一旦对某条 lint 达成共识，接下来发生的事就是：
提议强制执行这条 lint 的人会清理 Google 全部内部 Dart 代码，
使其通过这条 lint。有时我们会在这个过程中学到新东西；
如果漏掉了什么会让清理变成破坏性或困难的改动，
清理通常会暂停。目前我们手头有足够多的 lint 要处理，
可以先跳过这类情况，以后再回来处理。

Once a lint is successfully cleaned up everywhere, it’s then enforced on presubmit, preventing any further violations in Google internal code, and it’s published in the next release of`package:pedantic`.

一旦某条 lint 在所有地方都清理完毕，
它就会在 presubmit 中强制执行，防止 Google 内部代码再出现违反，
并在 `package:pedantic` 的下一个版本中发布。

The [unawaited_futures](https://dart-lang.github.io/linter/lints/unawaited_futures.html) lint was an even harder case. This lint addresses what used to be a very common developer complaint: forgetting to `await` a `Future`, causing unpredictable runtime behaviour and flaky tests.

[unawaited_futures](https://dart-lang.github.io/linter/lints/unawaited_futures.html)
这条 lint 是个更难的案例。它针对的是过去开发者非常常见的抱怨：
忘记 `await` 一个 `Future`，导致不可预测的运行时行为和时好时坏的测试。

```
// unawaited_futures; catching accidentally asynchronous behaviour.

Future<void> doSomething() => ...;
Future<void> doSomethingElse() => ...;

void main() async {
  doSomething(); // LINT
  doSomethingElse(); // LINT
}
```


But the lint is problematic because we *know* there are cases when you *do* want to start a `Future` and then continue without waiting for it to complete. One example is logging: it’s typically okay to know that logging will complete at some point, without needing to wait for it.

但这条 lint 有问题，因为我们*知道*有些情况下你*确实*想启动一个
`Future` 然后继续执行，不等它完成。
一个例子是日志：通常只要知道日志会在某个时刻完成就行，
不需要等它。

The lint offered tremendous value but couldn’t possibly be made correct. We discussed for a long time the best path. Dart lints can be ignored by writing `// ignore: &lt;lint_name&gt;` on the preceding line, so enforcing a lint is never *actually* blocking for developers. But, we really didn’t want to train developers to write `ignore`; the majority of lints we enforce *are* always correct, and should never be ignored.

这条 lint 价值巨大，却不可能做到完全正确。
我们讨论了很长时间该走哪条路。
Dart lint 可以通过在前一行写 `// ignore: &lt;lint_name&gt;` 来忽略，
所以强制执行一条 lint *实际上*从来不会阻塞开发者。
但是，我们真的不想训练开发者去写 `ignore`；
我们强制执行的大多数 lint *确实*总是正确的，永远不该被忽略。

This discussion is actually what lead to the creation of `package:pedantic` in the first place. We wanted to provide the canonical way to say, “I know about the unawaited_futures lint, and it doesn’t apply here.” That is now the `unawaited` method in`package:pedantic`. Having published that, we updated the message and docs for the unawaited_futures lint to point to `unawaited`, and now we are in what we hope is a reasonably good place: we have a lint that you might sometimes need to turn off, and a canonical, readable way to do so.

正是这场讨论最初促成了 `package:pedantic` 的诞生。
我们想提供一种规范的方式来表达：
“我知道 unawaited_futures 这条 lint，它在这里不适用。”
这就是现在 `package:pedantic` 里的 `unawaited` 方法。
发布之后，我们更新了 unawaited_futures lint 的提示信息和文档，
指向 `unawaited`，现在我们处于一个希望还算不错的位置：
有一条你有时可能需要关掉的 lint，
以及一种规范的、可读的方式来关掉它。

```
// unawaited_futures; say `unawaited` if that's what you wanted.

Future<void> doSomething() => ...;
Future<void> doSomethingElse() => ...;

void main() async {
  unawaited(doSomething());
  unawaited(doSomethingElse());
}
```


This was sufficient to reach a consensus on enforcing the unawaited_futures lint.

这足以让我们就强制执行 unawaited_futures lint 达成共识。

## Step by step towards perfect Dart linting

## 一步步走向完美的 Dart lint

And so the process continues. We are now up to 25 lints enabled and eight lints explicitly disabled, so we’re not quite a quarter of the way through the 146 lints available. Of course, people keep adding new lints — the linter design makes this easy to do — so it’s a moving target.

于是这个过程还在继续。我们现在启用了 25 条 lint，
明确禁用了 8 条，所以在 146 条可用 lint 中还没走完四分之一。
当然，人们还在不断添加新 lint——linter 的设计让这很容易——
所以这是个移动的目标。

I’d love to be able to wave a magic wand and provide the perfect list of lints; hopefully this article has explained why that isn’t possible, and that we’re working on it.

我也希望能挥一挥魔杖就给出一份完美的 lint 清单；
希望这篇文章解释了为什么那不可能，以及我们正在为此努力。

Finally, if lints already exist that you’d like to see enabled sooner rather than later, you’re welcome to use the `pedantic` [issue tracker](https://github.com/dart-lang/pedantic/issues) to make that known; we take issues into account when looking at what to tackle next. Unfortunately, since Google internal code is key to deciding which lints to enable, we can’t make the whole process transparent, but we aim to be as open as possible in our GitHub discussions. In particular, we can give feedback, as far as possible, on what’s likely to get into package:pedantic and when.

最后，如果已有的 lint 中有你希望尽早启用的，
欢迎到 `pedantic` 的
[issue 跟踪器](https://github.com/dart-lang/pedantic/issues)里告诉我们；
我们在决定接下来处理什么时会考虑这些 issue。
遗憾的是，由于 Google 内部代码是决定启用哪些 lint 的关键，
我们无法让整个流程完全透明，
但我们力求在 GitHub 讨论中尽可能开放。
特别是，我们可以尽可能反馈哪些内容可能进入 package:pedantic
以及大概什么时候。

If you’re interested in contributing new lints or improving existing ones, please get involved on GitHub!

如果你有兴趣贡献新 lint 或改进现有 lint，请到 GitHub 上参与进来！
