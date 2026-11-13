---
# title: "Dart and the performance benefits of sound types"
title: "Dart 与健全类型的性能优势"
# description: "Using soundness and null safety to generate faster, smaller code."
description: "利用健全性和空安全生成更快、更小的代码。"
ai-translated: true
publishDate: 2021-01-19
author: vijaysmenon
image: images/1x0UcFY8XwG-3vHe5hYxyQw.webp
category: other
layout: blog
---


### Using soundness and null safety to generate faster, smaller code

### 利用健全性和空安全生成更快、更小的代码

<DashImage src="images/1WOmw6jN-nt82uXjGCqRC4g.webp" alt="Code generated from the same Dart method in Dart 1.24, 2.0, and 2.12 (left to right) showing a reduction in size." caption="Code generated from the same Dart method in Dart 1.24, 2.0, and 2.12 (left to right) has gotten smaller. To see why (and to see the actual generated code), keep reading." />


We’ve strengthened Dart’s type system over the past few years. The original Dart language (Dart 1) had an unsound, optional type system (similar to typed JavaScript dialects such as Microsoft’s TypeScript or Facebook’s Flow). Dart 2 introduced a stricter, [*sound* type system](https://dart.dev/guides/language/type-system). Over the past two years, we’ve been working on extending the type system further, via [*sound null safety*](https://dart.dev/null-safety).

过去几年我们不断强化 Dart 的类型系统（type system）。
最初的 Dart 语言（Dart 1）拥有一个不健全（unsound）的可选类型系统
（类似于带类型的 JavaScript 方言，
如微软的 TypeScript 或 Facebook 的 Flow）。
Dart 2 引入了更严格的
[*健全（sound）*类型系统](https://dart.dev/guides/language/type-system)。
过去两年，我们一直在通过
[*健全空安全（sound null safety）*](https://dart.dev/null-safety)
进一步扩展类型系统。

While a sound type system provides developers with greater confidence, it also enables our compilers to safely use types to optimize generated code. With soundness, our tools guarantee that types are correct via a combination of static and (when needed) runtime checking. Without soundness, type checking can only go so far, and static types may be incorrect at runtime.

健全类型系统不仅给开发者更大的信心，
也让我们的编译器能够安全地利用类型来优化生成的代码。
有了健全性（soundness），我们的工具通过静态检查
和（必要时的）运行时检查相结合来保证类型正确。
没有健全性，类型检查只能做到一定程度，
静态类型在运行时可能并不正确。

In practice, soundness allows our compilers to generate smaller and faster code, particularly in an ahead-of-time (AOT) setting, where we ship precompiled native code to clients.

在实践中，健全性让我们的编译器生成更小、更快的代码，
尤其是在提前编译（ahead-of-time，AOT）场景下——
我们把预编译的原生代码交付给客户端。

## An example

## 一个例子

The following example method demonstrates how sound types can have a dramatic impact on relatively simple code:

下面这个示例方法展示了健全类型如何对相对简单的代码
产生巨大影响：

```
**int getAge(Animal a) {
  return a.age;
}**
```


In our last stable Dart 1 version (1.24.3), this method mapped to **26 native x64 instructions** — and that was only after instrumentation and profile-guided optimization, which slowed initial runtime startup. With sound null safety in Dart 2.12, this code maps to just **3 instructions**, without any need for profile-guided optimization.
> Dart compiles to both ARM32/64 and x86/x64 architectures. In the examples below, we use x64, but results are similar on other targets.

在我们最后一个 Dart 1 稳定版（1.24.3）中，
这个方法对应 **26 条原生 x64 指令**——
而且那还是经过插桩（instrumentation）和基于性能剖析的优化
（profile-guided optimization）之后的结果，
这些会拖慢运行时的初始启动。
在 Dart 2.12 的健全空安全下，这段代码只对应 **3 条指令**，
完全不需要基于性能剖析的优化。

> Dart 可以编译到 ARM32/64 和 x86/x64 架构。
> 下面的例子使用 x64，但在其他目标平台上结果类似。

The full Dart code and context for the example method are shown at the end of this article, but here are the key points:

示例方法的完整 Dart 代码和上下文在本文末尾给出，
这里先说要点：

* The class `Animal` contains a field `age` of type `int`.

  `Animal` 类包含一个 `int` 类型的字段 `age`。

* `Animal` has several subclasses (`Cat`, `Dog`, `Snake`, `Hamster`).

  `Animal` 有几个子类（`Cat`、`Dog`、`Snake`、`Hamster`）。

* The method above is called on many of these types at runtime.

  上面的方法在运行时会被用于其中许多类型。

## Dart object layout

## Dart 对象布局

The Dart class `Animal`, when compiled to native (x64) code, has a simple layout:

Dart 类 `Animal` 编译为原生（x64）代码后，布局很简单：

<DashImage src="images/1GjL59kevCm5NQ5P9Unn_NA.webp" alt="Memory layout of the Animal class when compiled to native code." />


The first 8 bytes are a header that provides reified type information (that is, the runtime type of the object). The second 8 bytes contain the `age` field. All subclasses preserve (and potentially add to) this structure: any additional fields are laid out after, preserving the base type’s structure. The `getAge` method, given an instance of `Animal` (or any subclass) should load the field from an 8-byte offset and return it.

前 8 个字节是头部，提供具体化（reified）的类型信息
（即对象的运行时类型）。第二个 8 字节存放 `age` 字段。
所有子类都保留（并可能扩展）这个结构：
任何额外字段都排在后面，保持基类型的结构不变。
`getAge` 方法拿到 `Animal`（或其任何子类）的实例后，
应该从 8 字节偏移处加载该字段并返回。

## Dart 1: Unsound types

## Dart 1：不健全的类型

In Dart 1, however, static types weren’t sound and were effectively ignored during compilation. At runtime, we couldn’t assume that the static type was correct (and, therefore, the layout was as expected). The access to `age` might be to a field at a different offset, to a getter that triggered further executable code, or to a non-existent field (triggering a catchable runtime error).

然而在 Dart 1 中，静态类型不健全，编译时实际上被忽略。
运行时我们不能假定静态类型是正确的
（因而也不能假定布局符合预期）。
对 `age` 的访问可能指向不同偏移处的字段、
一个会触发更多可执行代码的 getter，
或者一个不存在的字段（触发可捕获的运行时错误）。

Dart 1 was designed to rely on a just-in-time compiler and virtual machine on the client device, which optimized the code using runtime type information. In this scheme, we actually compiled each method twice: first, to collect information, and second (for hot methods) to generate more optimized code based on the observed runtime behavior.

Dart 1 的设计依赖客户端设备上的即时（just-in-time，JIT）编译器
和虚拟机，利用运行时类型信息优化代码。
在这个方案中，我们实际上把每个方法编译两次：
第一次收集信息，第二次（针对热点方法）
基于观察到的运行时行为生成更优化的代码。

### Dart 1: First compilation

### Dart 1：第一次编译

The first compilation for `getAge` produced the following 47 instructions on x64:

`getAge` 的第一次编译在 x64 上产生了以下 47 条指令：

<DashImage src="images/1BmagjRb3ei3C-HjyYfLNyw.webp" alt="Assembly code showing the 47 instructions produced by the first compilation of getAge in Dart 1." />


Note that this code is instrumented to determine what happens at runtime. It assumes nothing about the passed object and effectively performs the equivalent of a hash table lookup to correctly find the field, execute a getter, or throw an error.

注意这段代码带有插桩，用来确定运行时发生了什么。
它对传入的对象不做任何假设，
实际上执行了相当于哈希表查找的操作，
来正确地找到字段、执行 getter 或抛出错误。

### Dart 1: Second compilation

### Dart 1：第二次编译

In this case, the code is called repeatedly and triggers a second, optimizing compilation that generates the following 26 instructions:

在这个例子中，代码被反复调用，触发了第二次优化编译，
生成以下 26 条指令：

<DashImage src="images/11bEjUe15A0s47XMsZPqdNQ.webp" alt="Assembly code showing the 26 instructions produced by the optimizing compilation in Dart 1." />


This optimized code is still quite large. It’s based on profile information that found the method was only invoked on instances of `Cat`, `Hamster`, and `Dog`, and is optimized with the assumption that the same will be true going forward.

这段优化后的代码仍然相当大。
它基于性能剖析信息：发现该方法只在 `Cat`、`Hamster`
和 `Dog` 的实例上被调用，
并假定今后也会如此，据此进行优化。

The code in **blue** is the prologue and epilogue for the method (to set up and restore the stack frame). The code in **red** checks for the expected cases — that the instance is non-null and is of one of the previously seen types — and invokes a slow path for other cases. The code in **bold** is the actual work to load the field.

**蓝色**代码是方法的序言（prologue）和尾声（epilogue）
（用于建立和恢复栈帧）。
**红色**代码检查预期情况——实例非空且属于之前见过的类型之一——
其他情况则走慢速路径（slow path）。
**加粗**代码是加载字段的实际工作。

The optimized code may actually be slower if future behavior is different from the past: if `getAge` is invoked on a new instance (such as a `Snake`) the code will perform the extra checks but still fall down the slow path.

如果未来的行为与过去不同，优化后的代码实际上可能更慢：
如果 `getAge` 被用于一个新实例（比如 `Snake`），
代码会执行额外的检查，但最终仍落入慢速路径。

### Problems with Dart 1 generated code

### Dart 1 生成代码的问题

The generated code above is very similar in structure to that produced today by V8, the JavaScript engine in Chrome, when given a more-or-less equivalent JavaScript/TypeScript/Flow program. While this approach (and the corresponding generated code) can give good performance in many scenarios, it wasn’t suitable as we began (with Flutter in particular) to target a broader set of client platforms, including mobile devices more sensitive to size and memory footprint:

上面生成的代码在结构上与今天 Chrome 中的 JavaScript 引擎 V8
对大致等价的 JavaScript/TypeScript/Flow 程序生成的代码非常相似。
虽然这种方式（及其生成的代码）在许多场景下能带来不错的性能，
但当我们开始（尤其是随着 Flutter）面向更广泛的客户端平台，
包括对体积和内存占用更敏感的移动设备时，它就不合适了：

* First, the cost of client-side compilation increased the overall footprint of Dart applications.

  首先，客户端编译的开销增加了 Dart 应用的整体占用。

* Second, the cost of two-phase speculative compilation was detrimental to application startup.

  其次，两阶段推测式编译的开销损害了应用启动。

* Third, just-in-time compilation isn’t allowed on iOS: we’d need an alternative strategy for at least some targets.

  第三，iOS 上不允许即时编译：
  至少对部分目标平台我们需要另一种策略。

We shifted instead to an ahead-of-time compilation approach, but with Dart 1 it resulted in considerably worse code. Even with sophisticated, whole-program analysis, we couldn’t always determine type information at compilation time, particularly as applications became larger. In addition, the cost of speculation — the red code above — became prohibitive when the entire application was precompiled.

于是我们转向提前编译方式，但在 Dart 1 下它产生的代码要差得多。
即使有复杂的全程序分析，我们也无法总在编译期确定类型信息，
应用越大越是如此。此外，当整个应用都被预编译时，
推测的代价——上面的红色代码——变得难以承受。

## Dart 2: Sound types

## Dart 2：健全类型

With Dart 2, we introduced soundness, which enabled us to safely compile code based upon type information and reduced our reliance on profiling for performance. With Dart 2, on a single ahead-of-time compile, we generate 10 instructions on x64:

随着 Dart 2，我们引入了健全性，
这让我们能够安全地基于类型信息编译代码，
并减少对性能剖析的依赖。
在 Dart 2 中，一次提前编译就能在 x64 上生成 10 条指令：

<DashImage src="images/1x0UcFY8XwG-3vHe5hYxyQw.webp" alt="Assembly code showing the 10 instructions generated by Dart 2 on a single ahead-of-time compile." />


This code still performs the null check (in red) and calls a helper method if null is found.

这段代码仍然执行空值检查（红色部分），
发现 null 时调用一个辅助方法。

## Dart 2.12: Sound null safety

## Dart 2.12：健全空安全

With sound null safety, the type system is richer, and our compiler can leverage that. The compiler can safely rely upon the (now) non-nullable type and eliminate the code in red above. In Dart 2.12 beta, we generate 3 fewer instructions:

有了健全空安全，类型系统更丰富，我们的编译器可以加以利用。
编译器可以安全地依赖（现在）不可为 null 的类型，
消除上面的红色代码。在 Dart 2.12 beta 中，我们少生成 3 条指令：

<DashImage src="images/1xVdpKVxtt_TtfoXZDlu1Qw.webp" alt="Assembly instructions generated for Dart 2.12 with sound null safety." />


In fact, as the code has gotten simpler, we’ve also been able to streamline the prologue and epilogue. In our forthcoming stable release, we’ll generate just 3 instructions for the example method:

事实上，随着代码变得更简单，我们还能精简序言和尾声。
在即将发布的稳定版中，我们将只为这个示例方法生成 3 条指令：

<DashImage src="images/1JPFuwgxqf2K-7tVD52M5uQ.webp" alt="Simplified assembly instructions for sound null safety, reduced to just 3 instructions." />


With sound null safety, we can reduce the generated code for this method to its essence: a field load. In practice, a call to this method will always be inlined, as it’s now trivial for the compiler to see that inlining is both a performance and code size win. Runtime checking and compensation code are no longer necessary: more of the heavy lifting happens at compile time. We no longer need the startup and memory overhead of client-side compilation. As a result, our users get smaller and faster code.

有了健全空安全，我们可以把这个方法生成的代码精简到本质：
一次字段加载。实践中，对这个方法的调用总会被内联（inline），
因为编译器现在很容易看出内联在性能和代码体积上都是双赢。
运行时检查和补偿代码不再必要：更多繁重的工作发生在编译期。
我们不再需要客户端编译带来的启动和内存开销。
结果就是，我们的用户得到更小、更快的代码。

## Try it!

## 试一试！

We encourage you to try out [null safety](https://dart.dev/null-safety). It’s available in Dart 2.12, now in our beta channel. Once your upstream dependencies are migrated, you’ll be able to migrate your own packages and applications. As the example here illustrates, you may not need to change too much.

我们鼓励你试试[空安全](https://dart.dev/null-safety)。
它在 Dart 2.12 中可用，目前在 beta 渠道。
一旦你的上游依赖完成迁移，你就可以迁移自己的 package 和应用。
正如这里的例子所示，你可能不需要改动太多。

Remember, to get the performance benefits of null safety, you’ll need a fully migrated application. Once your application is fully migrated, our compilers will automatically take advantage of null safety to generate better, smaller code.

记住，要获得空安全的性能优势，你需要一个完全迁移的应用。
一旦你的应用完全迁移，我们的编译器就会自动利用空安全
生成更好、更小的代码。

## PS: The code

## 附：代码

Here’s the full Dart code that I compiled to generate all the code in this article. While the example here is contrived, the pattern — a field in a class hierarchy — is quite common.

下面是我用来生成本文所有代码的完整 Dart 代码。
虽然这里的例子是刻意构造的，
但这种模式——类层次结构中的一个字段——相当常见。

```dart
int N = 1000000;

class Animal {
  int age = 0;
}

class Cat extends Animal {}

class Dog extends Animal {}

class Snake extends Animal {}

class Hamster extends Animal {}

List<Animal> _animals = [
  new Cat()..age = 1,
  new Hamster()..age = 2,
  new Dog()..age = 3
];
List<Animal> listOfA = [];
void init() {
  for (int i = 0; i < N; ++i) {
    listOfA.add(_animals[i % _animals.length]);
  }
}

int sum() {
  int k = 0;
  for (int i = 0; i < N; ++i) {
    k += getAge(listOfA[i]);
  }
  return k;
}

@pragma('vm:never-inline')
int getAge(Animal a) {
  return a.age;
}

void main() {
  init();
  print(sum());
  print(getAge(listOfA[0]));
}
```