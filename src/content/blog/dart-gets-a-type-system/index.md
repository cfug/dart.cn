---
# title: "Dart gets a Type System"
title: "Dart 有了类型系统"
# description: "Rejoice, all ye faithful, for Dart 2.0 is coming, and it has types."
description: "欢呼吧，各位忠实信徒，Dart 2.0 要来了，而且它带类型。"
ai-translated: true
publishDate: 2017-07-04
author: davidmorgan
image: images/0C4V5HBaOprKmpRUh.webp
category: announcements
layout: blog
---


<DashImage src="images/0C4V5HBaOprKmpRUh.webp" alt="Two people jumping in silhouette at sunset." />


This is Dart’s first major breaking change — hence the “2” — and it’s precisely *because* it’s a breaking change that it’s such an important development. Let’s dig into why that is. First, some Dart 1 code:

这是 Dart 的第一次重大破坏性变更——所以版本号是“2”——
而恰恰*因为*它是破坏性变更，才如此重要。
我们来挖一挖原因。先看一段 Dart 1 代码：

```
void main() {
  cleanUp([new TempFile(), new BankAccount()]);
}

void cleanUp(List<TempFile> files) =>
    files.forEach((f) => f.delete());

class TempFile {
  void delete() => print('TempFile deleted.');
}

class BankAccount {
  void delete() => print('BankAccount deleted. Whoops!');
}

> TempFile deleted.
> BankAccount deleted. Whoops!
```


The code is a little surprising.

这段代码有点出人意料。

Both “TempFile” and “BankAccount” have a “delete” method; it so happens that since Dart 1 does not, by default, care about types, it will happily let us call “delete” on a “BankAccount” when we were very clearly trying to call “delete” on a “TempFile”.

“TempFile”和“BankAccount”都有“delete”方法；
碰巧 Dart 1 默认不关心类型，
于是当我们明明想对“TempFile”调用“delete”时，
它却愉快地让我们对“BankAccount”调用了“delete”。

Not good.

这可不好。

## Strong Mode Analysis

## Strong Mode 分析

Enter Strong Mode, the new type system for Dart. (We won’t need the name once Dart 2.0 arrives; it’ll just be “the type system”).

Strong Mode 登场——Dart 的新类型系统。
（Dart 2.0 到来后就不需要这个名字了；它就是“类型系统”。）

The [Dart analyzer](https://github.com/dart-lang/sdk/tree/master/pkg/analyzer_cli) has supported Strong Mode static analysis for some time; it uses type inference to work out what types you most likely meant, and requires that each variable can only have a single type. It also adds strictness around overrides and generics.

[Dart 分析器](https://github.com/dart-lang/sdk/tree/master/pkg/analyzer_cli)
支持 Strong Mode 静态分析已有一段时间；
它用类型推断算出你最可能想要的类型，
并要求每个变量只能有一个类型。
它还在重写和泛型方面增加了严格性。

If we feed the code snippet above to the analyzer with Strong Mode enabled, it tells us:

把上面的代码片段喂给启用 Strong Mode 的分析器，
它会告诉我们：

```
error: The element type 'BankAccount' can't be assigned to the list type 'TempFile'.
```


…which seems reasonable. Problem solved. Or is it?

……看起来合情合理。问题解决了。真的吗？

Unfortunately not. There are a few ways to trick static analysis. For example, we can use “new List.from”, which takes any “Iterable”:

可惜没有。有几种办法能骗过静态分析。
例如，我们可以用接受任意 “Iterable” 的 “new List.from”：

```
void main() {
  var list = new List<TempFile>.from(
      [new TempFile(), new BankAccount()]);
  cleanUp(list);
}

> TempFile deleted.
> BankAccount deleted. Whoops!
```


…and the analyzer is powerless to help. There is simply no way to catch this problem with static checks.

……分析器就无能为力了。静态检查根本无法抓住这个问题。

## Strong Mode Proper

## 真正的 Strong Mode

Here we approach the concept of soundness; whether the type system is able to deliver on what it promises. Extra static checks via the analyzer help catch bugs, but they’re not enough to close all the holes. What’s needed is some additional runtime checks.

这里我们触及健全性（soundness）的概念：
类型系统能否兑现它的承诺。
分析器的额外静态检查有助于抓 bug，
但不足以堵上所有漏洞。还需要一些额外的运行时检查。

There is currently only one Dart runtime that implements those checks; the [Dart Dev Compiler (DDC)](https://github.com/dart-lang/sdk/tree/master/pkg/dev_compiler). If we run that last snippet with DDC we get a runtime error:

目前只有一个 Dart 运行时实现了这些检查：
[Dart Dev Compiler（DDC）](https://github.com/dart-lang/sdk/tree/master/pkg/dev_compiler)。
用 DDC 运行最后那段代码，我们会得到运行时错误：

```
Type 'BankAccount' is not a subtype of type 'TempFile'
```


So, our bank account is safe. Strong Mode with runtime checks guarantees that if we are trying to run “TempFile.delete” we will never, under any circumstances[1], run “BankAccount.delete” instead.

这样，我们的银行账户就安全了。带运行时检查的 Strong Mode
保证：当我们想运行 “TempFile.delete” 时，
在任何情况下[1]都绝不会转而运行 “BankAccount.delete”。

## Dart 2.0

## Dart 2.0

And here we return to the announcement about Dart 2.0, and why it’s important.

现在回到 Dart 2.0 的宣布，以及它为什么重要。

The reason DDC is the only runtime to add these checks is that they are breaking changes to the language. Programs that used to be valid are no longer valid. DDC is a development tool, so it doesn’t need to compile and run all valid Dart; the VM and dart2js do.

DDC 之所以是唯一加入这些检查的运行时，
是因为它们对语言来说是破坏性变更。
以前合法的程序不再合法。DDC 是开发工具，
不需要编译和运行所有合法的 Dart；但 VM 和 dart2js 需要。

So with the change to Dart 2.0, those programs with type problems can now be declared invalid — and all the runtimes can move on to providing types that do what they promise. A happy ending, and an important step for my favourite programming language.

所以随着 Dart 2.0 的变更，那些有类型问题的程序
现在可以被宣布为非法——所有运行时都可以向前迈进，
提供言行一致的类型。这是个圆满的结局，
也是我最喜欢的编程语言的重要一步。

## Aside: And Nothing of Value was Lost

## 题外话：没有丢失任何有价值的东西

It’s natural to ask about the *downsides* of the change. What if we *want* loose types from Dart?

自然会想问这次变更的*坏处*。
如果我们就是*想要* Dart 的宽松类型呢？

Fortunately the language has that covered. We can always opt out of type checks with the special “dynamic” type. In fact, “dynamic” is the default if you don’t add a type annotation, so we could just have written “List” instead of “List&lt;TempFile&gt;”:

幸运的是语言考虑到了这一点。
我们随时可以用特殊的 “dynamic” 类型退出类型检查。
事实上，不加类型注解时默认就是 “dynamic”，
所以我们本可以写 “List” 而不是 “List&lt;TempFile&gt;”：

```
void main() {
  cleanUp([new TempFile(), new BankAccount()]);
}

void cleanUp(List files) =>
    files.forEach((f) => f.delete());

class TempFile {
  void delete() => print('TempFile deleted.');
}

class BankAccount {
  void delete() => print('BankAccount deleted. Whoops!');
}

> TempFile deleted.
> BankAccount deleted. Whoops!
```


…and we have perfectly valid Dart 2.0 code[2]. The “cleanUp” method is now written to work on *any* class with a “delete” method — and that’s exactly what it does.

……这就是完全合法的 Dart 2.0 代码[2]。
“cleanUp” 方法现在被写成对*任何*带 “delete” 方法的类
都有效——而它也确实就是这么做的。

*[1] As other languages [have shown](https://dev.to/rosstate/java-is-unsound-the-industry-perspective), getting a type system 100% sound is hard. But there won’t be any* known *ways of breaking the type system.*

*[1] 正如其他语言[所展示的](https://dev.to/rosstate/java-is-unsound-the-industry-perspective)，
让类型系统 100% 健全很难。但不会存在任何*已知的*
破坏类型系统的方法。*

*[2] Dart 2.0 doesn’t exist yet, so this isn’t 100% guaranteed. But as far as the types go, this should be fine.*

*[2] Dart 2.0 还不存在，所以这不是 100% 保证。
但就类型而言，应该没问题。*
