---
# title: "Dart 3.1 & a retrospective on functional style programming in Dart 3"
title: "Dart 3.1 与 Dart 3 函数式风格编程回顾"
# description: "Pattern matching and exhaustive switches come together to enable functional style data models that blend seamlessly with Dart’s…"
description: "模式匹配与穷尽 switch 携手，让函数式风格的数据模型与 Dart 的面向对象核心无缝融合……"
ai-translated: true
publishDate: 2023-08-16
author: mbelanger
image: images/1IWd8aRO__OzDkJVsjfoe2A.webp
category: releases
layout: blog
---


### Pattern matching and exhaustive switches come together to enable functional style data models that blend seamlessly with Dart’s object-oriented core.

### 模式匹配与穷尽 switch 携手，让函数式风格的数据模型
### 与 Dart 的面向对象核心无缝融合。

<DashImage src="images/1IWd8aRO__OzDkJVsjfoe2A.webp" alt="A diff of a Dart 3 refactor using functional style features within Dart's internal code base." caption="Diff of a Dart 3 refactor using functional style features within Dart’s internal code base" />


*Today we’re releasing Dart 3.1, our first stable release since the major [Dart 3.0](/blog/announcing-dart-3) release in May. Dart 3.1 contains a handful of minor updates and a few API adjustments to further use class modifiers introduced in 3.0 (which you can read more about in the [changelog](https://github.com/dart-lang/sdk/blob/main/CHANGELOG.md#310)). Mostly, though, we’ve been spending our time on new roadmap items that we hope to see reach beta and stable over the coming releases. Stay tuned for more about that in the future!*

*今天我们发布 Dart 3.1，这是 5 月重大版本
[Dart 3.0](/blog/announcing-dart-3) 之后的首个稳定版。
Dart 3.1 包含少量小更新和一些 API 调整，
进一步使用 3.0 引入的类修饰符
（更多细节见[更新日志](https://github.com/dart-lang/sdk/blob/main/CHANGELOG.md#310)）。
不过，我们主要把时间花在新的路线图项目上，
希望它们在接下来的版本中进入 beta 和稳定。
敬请期待后续消息！*

*So, in place of a traditional release post, we’re revisiting a subset of Dart 3’s major features to talk about how they can completely change, and in some cases, greatly improve the way you write and structure your Dart code.*

*所以，这次不写传统的发布文章，
我们重温 Dart 3 的部分重要特性，
聊聊它们如何彻底改变——某些情况下大幅改进——
你编写和组织 Dart 代码的方式。*

## How do you model data?

## 你如何建模数据？

Object-oriented (OO) and functional languages differ in many ways, but it’s arguable that *how each paradigm models data* is the defining characteristic that separates them. Specifically, the question of modeling different variations of related data and the operations on those variants.

面向对象（OO）语言和函数式语言在许多方面不同，
但可以说*每种范式如何建模数据*是区分它们的
决定性特征。具体来说，就是如何建模相关数据的
不同变体，以及对这些变体的操作。

But *“how should I model this data?”* is usually not something we consciously give much thought to when starting a new project. We tend to default to whatever data modeling paradigm is common to the type of language we’re using, as opposed to the inverse of choosing the language based on the model that makes the most sense for our data.

但*“我该如何建模这些数据？”*通常不是我们
开始新项目时有意识深思的问题。我们倾向于默认采用
所用语言类型常见的数据建模范式，
而不是反过来——根据最适合数据的模型来选择语言。

If you’re using an OO language, you’ll model data with class hierarchies and operations on subtypes. If you’re using certain functional languages, the equivalent to the class hierarchy model is the [algebraic data type](https://en.wikipedia.org/wiki/Algebraic_data_type) model, whose equivalent to operating on subtypes is switching over them with [pattern matching](https://en.wikipedia.org/wiki/Pattern_matching).

如果你用 OO 语言，你会用类层次和对子类型的操作
来建模数据。如果你用某些函数式语言，
与类层次模型对应的是
[代数数据类型](https://en.wikipedia.org/wiki/Algebraic_data_type)
模型，与操作子类型对应的是用
[模式匹配](https://en.wikipedia.org/wiki/Pattern_matching)
对它们进行 switch。

<DashImage src="images/1mA116alArq7XKrm_PSCjyw.webp" alt="A simplified side-by-side comparison of the object-oriented class hierarchy model and the functional algebraic data type model." caption="Simplified side-by-side comparison of the object-oriented class hierarchy model and the functional algebraic data type model" />


Dart is an object-oriented language, but has been steadily incorporating functional features over time, allowing for a more multi-paradigm approach to data modeling. Most recently, Dart 3 added [pattern matching](https://dart.dev/language/patterns), new functionality on [switch](https://dart.dev/language/patterns#switch-statements-and-expressions), and [sealed types](https://dart.dev/language/class-modifiers#sealed). These features make it possible to implement algebraic data types in Dart, allowing you to write functional style code while continuing to maximize the capabilities of Dart’s object-oriented core.

Dart 是面向对象语言，但一直在稳步吸收函数式特性，
让数据建模可以采用更多范式的方法。最近，Dart 3 加入了
[模式匹配](https://dart.dev/language/patterns)、
[switch](https://dart.dev/language/patterns#switch-statements-and-expressions)
的新功能和[密封类型](https://dart.dev/language/class-modifiers#sealed)。
这些特性让在 Dart 中实现代数数据类型成为可能，
让你既能写函数式风格的代码，
又能继续最大化 Dart 面向对象核心的能力。

Multi-paradigm languages like Dart give you the tools and the opportunity to choose how you design anything from a single line expression, to entire class hierarchies. You can consider which model makes the most sense for your project, or even just for your personal preference. To help you make the best decision, this article summarizes the structure and strengths of each paradigm separately, and then teaches you how to use new features in Dart 3 to refactor some classic object-oriented designs that most benefit from being written in a functional style.

Dart 这样的多范式语言给你工具和机会，
选择如何设计从单行表达式到整个类层次的任何东西。
你可以考虑哪种模型对项目最合理，甚至只凭个人偏好。
为帮你做出最佳决定，本文先分别总结每种范式的
结构和优势，然后教你用 Dart 3 的新特性重构一些
最适合用函数式风格编写的经典面向对象设计。

### Object-oriented approach

### 面向对象方法

When you have operations specific to different data types, the standard organization approach in OO languages is to create a method on a base class, and a set of subclasses that override the base class to define their unique behavior. Each subclass has its data and operations together in one place inside its declaration.

当操作因数据类型而异时，OO 语言的标准组织方式是
在基类上创建方法，再由一组子类重写基类
来定义各自独特的行为。每个子类的数据和操作
都集中在其声明内部的一个地方。

Take this (high-level pseudocode) example of modeling recipes. It makes sense to have recipe objects, coupling ingredients and steps together with the recipe. The recipe base class would probably have some functions for the cooking methods that each recipe overrides with their unique requirements:

看这个建模食谱的（高层伪代码）例子。
拥有食谱对象是合理的，把配料和步骤与食谱耦合在一起。
食谱基类可能会有一些烹饪方法函数，
每个食谱按自己的独特需求重写它们：


Class hierarchies with instance methods make it easy to add new subclasses without having to touch any existing code. This works perfectly for some domains, like Flutter, where you have countless widgets that all extend the `Widget` class. Each widget can uniquely extend and override any necessary behavior directly inside their definition. You *definitely* don’t need to know how every widget subtype defines its methods to add specialized behavior to your own widgets.

带实例方法的类层次让添加新子类很容易，
无需触碰任何既有代码。这对某些领域非常合适，
比如 Flutter：无数 widget 都继承 `Widget` 类。
每个 widget 都能直接在自己的定义内独特地扩展
和重写任何必要的行为。你*绝对*不需要知道
每个 widget 子类型如何定义方法，
就能给自己的 widget 添加专门行为。

### Functional approach (algebraic data types)

### 函数式方法（代数数据类型）

You can think of functional style architecture as the inverse of OO architecture. Instead of having all the code for *one type in one place* (OO instance methods in subclass declarations), you have all the code for *one operation in one place* (functional switching over types to define behavior).

你可以把函数式风格架构看作 OO 架构的反面。
不是把*一个类型的所有代码放在一个地方*
（子类声明中的 OO 实例方法），
而是把*一个操作的所有代码放在一个地方*
（函数式地对类型 switch 来定义行为）。

Which begs the question, when *does* it make sense to know how every subtype in a hierarchy defines an operation? It could be for a few reasons:

这就引出一个问题：什么时候了解层次中每个子类型
如何定义某个操作*才*有意义？可能有几个原因：

* When adding, maintaining, and understanding variants of the same operation’s behavior across types is easier to do when they’re all side by side in the code.

  当同一操作在不同类型上的行为变体并排放在代码中时，
  添加、维护和理解它们更容易。

* When you can’t modify the subclasses yourself, but you want to define new behavior that is specific to each of them.

  当你无法自己修改子类，
  却想为每个子类定义专属的新行为。

* When the variations of an operation’s behavior for different types are more related to each other than they are to the types that they’re operating on*.*

  当一个操作在不同类型上的行为变体彼此之间的关联，
  比它们与所操作类型的关联更紧密*。*

Sometimes it’s obvious, but mostly it’s just a perspective shift. Think about the recipe example again. From the point of view of, say, an oven manual, it would make a lot more sense to group bake instructions together in one place for each recipe:

有时很明显，但多数时候只是视角的转换。
再想想食谱的例子。从烤箱说明书的角度看，
把每个食谱的烘焙说明集中放在一个地方要合理得多：


In this example, the program structure is focused on the `bake` operation. Whatever types `bake` operates on are simply different possible outputs of the same function; `bake` is independent of the types it operates on.

这个例子中，程序结构聚焦于 `bake` 操作。
`bake` 操作的任何类型都只是同一函数的不同可能输出；
`bake` 独立于它所操作的类型。

This is the **algebraic data type model** (named “algebraic” after mathematical set theory). It’s the core organizational model of functional languages, in the same way class hierarchies are core to OO languages. Algebraic data types separate behavior from data by grouping behavior for all types together by operation.

这就是**代数数据类型模型**（“代数”得名于数学集合论）。
它是函数式语言的核心组织模型，
正如类层次是 OO 语言的核心。
代数数据类型按操作把所有类型的行为分组，
从而把行为与数据分离。

And now, it’s possible to cohesively implement algebraic data types with Dart 3!

而现在，用 Dart 3 就能内聚地实现代数数据类型了！

## Modeling object oriented algebraic data types

## 建模面向对象的代数数据类型

Functional languages generally implement [algebraic data types](https://en.wikipedia.org/wiki/Algebraic_data_type) by pattern matching over the cases in a [sum type](https://en.wikipedia.org/wiki/Tagged_union) to assign behavior to each variant. Dart 3 achieves the same with [pattern matching](https://dart.dev/language/patterns#switch-statements-and-expressions) in switch cases, and takes advantage of the fact that OO subtyping already naturally models sum types. This allows us to implement truly [multi-paradigm algebraic data types](https://dart.dev/language/patterns#algebraic-data-types) using objects that blend into Dart seamlessly.

函数式语言通常通过对
[和类型](https://en.wikipedia.org/wiki/Tagged_union)
中的各个 case 进行模式匹配来实现
[代数数据类型](https://en.wikipedia.org/wiki/Algebraic_data_type)，
为每个变体指定行为。Dart 3 用 switch case 中的
[模式匹配](https://dart.dev/language/patterns#switch-statements-and-expressions)
达到同样效果，并利用 OO 子类型天然建模和类型这一事实。
这让我们能用与 Dart 无缝融合的对象，实现真正的
[多范式代数数据类型](https://dart.dev/language/patterns#algebraic-data-types)。

The following sections show you how to design algebraic data type models in Dart, alongside pre-Dart 3 examples of the same functionality.

接下来几节展示如何在 Dart 中设计代数数据类型模型，
并对照 Dart 3 之前实现相同功能的例子。

* First, we’ll explain how to group type-based variants of an operation together by switching over [object patterns](https://dart.dev/language/pattern-types#object).

  首先，我们解释如何通过对
  [对象 pattern](https://dart.dev/language/pattern-types#object)
  进行 switch，把一个操作基于类型的变体分组在一起。

* Then, we’ll take a step back and look at how to architect the subclasses themselves with the new [sealed](https://dart.dev/language/class-modifiers#sealed) class modifier, to ensure the switch defines behavior for [all possible subtypes the object might take](https://dart.dev/language/branches#exhaustiveness-checking).

  然后，我们退一步，看看如何用新的
  [sealed](https://dart.dev/language/class-modifiers#sealed)
  类修饰符设计子类本身，确保 switch 为
  [对象可能采取的所有子类型](https://dart.dev/language/branches#exhaustiveness-checking)
  定义行为。

### Grouping behaviors across types

### 跨类型分组行为

Individual parts of the Dart language (like statements, classes, and literals) each have their own definitions in class hierarchies, but are all subject to operations from multiple systems (such as parser, formatter, and compiler operations). Imagine how confusing the language implementation would be if every function that applied to every language element had to be defined inside those elements’ declarations! It would look something like this:

Dart 语言的各个组成部分（如语句、类和字面量）
在类层次中各有定义，但都要接受多个系统的操作
（如解析器、格式化器和编译器的操作）。
想象一下，如果作用于每个语言元素的每个函数
都必须定义在这些元素的声明内部，
语言实现会有多混乱！大概会是这样：


Dart’s internal code already naturally leans towards the functional approach of separating functions from type definitions for this reason. Take the [`annotation_verifier`](https://github.com/dart-lang/sdk/blob/main/pkg/analyzer/lib/src/error/annotation_verifier.dart) library in Dart’s analyzer. It contains functions that define behavior for annotations (like `@override` or `@deprecated`) depending on the part of code the annotation is attached to (like how `@override` affects a class as opposed to a field).

正因如此，Dart 的内部代码天然倾向于
把函数与类型定义分离的函数式方法。
以 Dart 分析器中的
[`annotation_verifier`](https://github.com/dart-lang/sdk/blob/main/pkg/analyzer/lib/src/error/annotation_verifier.dart)
库为例。它包含的函数根据注解所附着的代码部分，
为注解（如 `@override` 或 `@deprecated`）定义行为
（比如 `@override` 对类和对字段的影响不同）。

But assigning behavior per type is not as straightforward as making the decision to separate the behavior out in the first place. The standard way to define behaviors by type uses chained `if-else` statements, which you see a lot in the annotation verifier. Take the following verification function written without using any Dart 3 features. It verifies the behavior of the [recently contributed](https://github.com/dart-lang/sdk/commit/4079a47cc4fb8f88e2dd9b7faff3bd587931a379) `@visibleOutsideTemplate` annotation that opts out of the cascading effects of another annotation, `@visibleForTemplate`:

但按类型指定行为，并不像最初决定把行为分离出来
那么直截了当。按类型定义行为的标准方式
使用链式 `if-else` 语句，注解验证器里就有很多。
看下面这个不用任何 Dart 3 特性编写的验证函数。
它验证[最近贡献的](https://github.com/dart-lang/sdk/commit/4079a47cc4fb8f88e2dd9b7faff3bd587931a379)
`@visibleOutsideTemplate` 注解的行为——
该注解退出另一个注解 `@visibleForTemplate`
的级联效果：


The function uses elaborate chained `if-else` statements, testing whether the grandparent of the annotation is a certain kind of declaration (either `ClassDeclaration`, `EnumDeclaration`, or `MixinDeclaration`), and then defining its behavior based on the type.

这个函数使用复杂的链式 `if-else` 语句，
测试注解的祖父节点是否是某种声明
（`ClassDeclaration`、`EnumDeclaration`
或 `MixinDeclaration`），然后根据类型定义行为。

With Dart 3, you can use object patterns in switch cases to significantly refactor this structure to a more declarative style, making it shorter and easier to read. And the original author [did just that](https://github.com/dart-lang/sdk/blob/4079a47cc4fb8f88e2dd9b7faff3bd587931a379/pkg/analyzer/lib/src/error/annotation_verifier.dart#L417-L426)! 16 lines of chained `if-else` statements are pared down to a 7-line switch statement:

有了 Dart 3，你可以在 switch case 中使用对象 pattern，
把这个结构大幅重构成更声明式的风格，
更短、更易读。原作者
[正是这么做的](https://github.com/dart-lang/sdk/blob/4079a47cc4fb8f88e2dd9b7faff3bd587931a379/pkg/analyzer/lib/src/error/annotation_verifier.dart#L417-L426)！
16 行链式 `if-else` 语句精简成了 7 行 switch 语句：


Each case here is an [object pattern](https://dart.dev/language/pattern-types#object) that matches against the static type of `grandparent`. Instead of saying `if (object is Type && object.property != null)`, each case checks if the object’s pattern matches the pattern `Type(propertyOfType)`. Plus, when an object matches an object pattern, it implicitly requires that it’s not `null`, so there’s no need for an explicit null check!

这里每个 case 都是与 `grandparent` 静态类型匹配的
[对象 pattern](https://dart.dev/language/pattern-types#object)。
不用写 `if (object is Type && object.property != null)`，
每个 case 检查对象的 pattern 是否匹配
`Type(propertyOfType)`。而且，对象匹配对象 pattern 时
隐式要求它不为 `null`，所以不需要显式 null 检查！

Object patterns can also contain nested [variable patterns](https://dart.dev/language/pattern-types#variable) that allow you to extract (or [*destructure*](https://dart.dev/language/patterns#destructuring)) property values from an object in the same line of code you’re matching against. The syntax `(:var metadata)` just means “match and declare a new variable with the same name as this getter”. This is how the variable `metadata` comes into scope for the final for loop. Pretty concise!

对象 pattern 还可以包含嵌套的
[变量 pattern](https://dart.dev/language/pattern-types#variable)，
让你在匹配的同一行代码中从对象提取
（或[*解构*](https://dart.dev/language/patterns#destructuring)）
属性值。语法 `(:var metadata)` 的意思就是
“匹配并声明一个与这个 getter 同名的新变量”。
变量 `metadata` 就是这样进入最后的 for 循环作用域的。
相当简洁！

Notice that the `for` loop is now common between each case. Each type’s `declaredElement` property is actually a different subtype of another type, `InterfaceElement` (either a `classElement`, `enumElement`, or `mixinElement`). So, the pre-Dart 3 chained `if-else` statement iterated over `metadata` in each `if` clause separately, to ensure `final annotation` would be type safe for each of the possible types that `metadata` could take.

注意 `for` 循环现在在各 case 之间共用。
每个类型的 `declaredElement` 属性实际上是另一个类型
`InterfaceElement` 的不同子类型
（`classElement`、`enumElement` 或 `mixinElement`）。
所以 Dart 3 之前的链式 `if-else` 语句
在每个 `if` 分支中分别遍历 `metadata`，
以确保 `final annotation` 对 `metadata` 可能采取的
每种类型都类型安全。

Now, the refactored structure uses deeply nested object patterns for each case, to upcast `metadata` to its supertype, `InterfaceElement`. This makes a single shared `for` loop iterating over `metadata` type safe across the cases.

现在，重构后的结构在每个 case 中使用深度嵌套的
对象 pattern，把 `metadata` 向上转型为其超类型
`InterfaceElement`。这让共用的单个 `for` 循环
遍历 `metadata` 时在各 case 之间都类型安全。

<DashImage src="images/1qYQb8DZyeJDFD-VKEb4P6Q.webp" alt="Annotated Dart pattern syntax showing an object pattern, nested object pattern, upcast, and variable pattern." caption="Annotated depiction of the syntax for a deeply nested object and variable patterns" />


Switching over object patterns matters to Dart’s algebraic data type implementation because of its ability to concisely test subtypes and destructure values. A nice side effect is the simultaneous assurances that can be provided by a single line of code. To reiterate, each case pattern in this refactor is simultaneously verifying:

对对象 pattern 进行 switch 对 Dart 的代数数据类型
实现很重要，因为它能简洁地测试子类型并解构值。
一个不错的副作用是单行代码就能同时提供多重保证。
重申一下，这次重构中的每个 case pattern 同时在验证：

* The object is one of the types `ClassDeclaration`, `EnumDeclaration`, or `MixinDeclaration`.

  对象是 `ClassDeclaration`、`EnumDeclaration`
  或 `MixinDeclaration` 类型之一。

* The object has the property `declaredElement`.

  对象有 `declaredElement` 属性。

* `declaredElement` has the property `metadata`.

  `declaredElement` 有 `metadata` 属性。

* `metadata` is of type `InterfaceElement`.

  `metadata` 的类型是 `InterfaceElement`。

* None of the objects or properties in question are `null`.

  涉及的对象和属性都不为 `null`。

This is the perfect example of how thoroughly Dart 3 implements patterns to account for so many nuances of OO languages, and really make object-oriented algebraic data types a realistic design option in Dart.

这完美展示了 Dart 3 实现 patterns 的彻底程度：
照顾到 OO 语言的诸多细微之处，
真正让面向对象的代数数据类型成为 Dart 中
现实可行的设计选项。

Type tests over object patterns are great for separating behavior from types. But its missing one feature of OO subtyping, where the compiler lets you know if you declare a new subtype but don’t define behavior for one of its supertype’s abstract methods. How can Dart’s algebraic data type model implement the same safety assurances when we’re no longer dealing with instance methods on type declarations? The answer is *exhaustiveness checking*.

对对象 pattern 做类型测试很适合把行为与类型分离。
但它缺少 OO 子类型的一个特性：当你声明新子类型
却没为其超类型的某个抽象方法定义行为时，编译器会提醒你。
当我们不再处理类型声明上的实例方法时，
Dart 的代数数据类型模型如何实现同样的安全保证？
答案是*穷尽性检查*。

### Exhaustiveness checking

### 穷尽性检查

Functional languages’ implementations of algebraic data types use enumerable sum types, which means the compiler is always aware of all the possible variations of the type being switched over. The compiler can then let you know if your switch is missing a case, and therefore that it’s possible some values might fall through that switch without being addressed.

函数式语言的代数数据类型实现使用可枚举的和类型，
这意味着编译器始终知道被 switch 类型的所有可能变体。
于是编译器能在你的 switch 缺少 case 时提醒你——
也就是一些值可能穿过 switch 而未被处理。

This is called [exhaustiveness checking](https://dart.dev/language/branches#exhaustiveness-checking). It has technically always existed in Dart for enumerable types like enums and booleans. Those types have a set of possible values that cannot change, and if you’re switching over them, the compiler knows when you’ve missed one and warns you. Using a `default` clause is another kind of pseudo exhaustiveness. Since `default` matches all cases not explicitly accounted for, it causes the compiler to consider a switch exhaustive without knowing if all potential types are actually accounted for.

这叫[穷尽性检查](https://dart.dev/language/branches#exhaustiveness-checking)。
严格来说，Dart 对枚举和布尔等可枚举类型一直都有它。
这些类型的可能取值集合不会变化，
如果你对它们 switch，编译器知道你漏了哪个并警告你。
使用 `default` 分支是另一种伪穷尽。
由于 `default` 匹配所有未显式处理的 case，
它让编译器认为 switch 是穷尽的，
却不知道是否真的覆盖了所有潜在类型。

As mentioned, we wanted to use subtypes instead of sum types for Dart’s version of algebraic data type modeling. But since classes in Dart can be extended from any library, it would be impossible for the compiler to exhaustively enumerate subtypes of a class since it can’t know if any subclasses are declared in external libraries.

如前所述，Dart 版的代数数据类型建模想用子类型
而不是和类型。但由于 Dart 中的类可以从任何库被继承，
编译器不可能穷尽枚举一个类的子类型——
它无法知道外部库中是否声明了子类。

To get around this and complete Dart’s algebraic data type implementation, we added the [`sealed` class modifier](https://dart.dev/language/class-modifiers#sealed) to Dart 3. A `sealed` class cannot be extended or implemented from any library but its own ([the file that contains its definition](https://dart.dev/language/libraries)). This ensures the compiler is always aware of any and all possible subtypes, making them fully enumerable.

为解决这个问题并完成 Dart 的代数数据类型实现，
我们在 Dart 3 中加入了
[`sealed` 类修饰符](https://dart.dev/language/class-modifiers#sealed)。
`sealed` 类不能被自身所在库
（[包含其定义的文件](https://dart.dev/language/libraries)）
之外的任何库继承或实现。这确保编译器始终知道
所有可能的子类型，使它们完全可枚举。

Here’s an example of an actual refactor that went into the Dart SDK as part of the 3.1 release: [sealing `FileSystemEvent`](https://github.com/dart-lang/sdk/commit/c3e815bc7ad488eddf00344ab4106485a9d1ba32#diff-e98c6de423bf7e0b5b961cd10efed50330004229243aa87c18ad6314fef054b0L879-R879) so its subtypes can be exhaustively switched over. Brace yourself, refactors are hard…

下面是随 3.1 版本进入 Dart SDK 的真实重构例子：
[密封 `FileSystemEvent`](https://github.com/dart-lang/sdk/commit/c3e815bc7ad488eddf00344ab4106485a9d1ba32#diff-e98c6de423bf7e0b5b961cd10efed50330004229243aa87c18ad6314fef054b0L879-R879)，
让其子类型可以被穷尽地 switch。做好准备，重构很难……


Just kidding, that wasn’t hard at all! It should be noted, though, that sealing an existing class hierarchy is a breaking change. Code targeting older versions of Dart won’t be able to implement or extend the class, so always check dependencies and alert any users that might be subtyping your classes elsewhere.

开玩笑的，这一点都不难！不过要注意，
密封既有类层次是破坏性变更。面向旧版 Dart 的代码
将无法实现或继承这个类，所以务必检查依赖，
并提醒可能在别处派生你类的用户。

Sealing `FileSystemEvent` allows the events produced by `FileSystemEntity.watch`, which correspond to the subtypes of `FileSystemEvent`, to be exhaustively switched over. It’s typical to listen to this stream of events and use [chained `if-else`](https://github.com/dart-lang/sdk/issues/52273) statements to determine an action based on the type of the events that occur.

密封 `FileSystemEvent` 让 `FileSystemEntity.watch`
产生的事件（对应 `FileSystemEvent` 的子类型）
可以被穷尽地 switch。典型做法是监听这个事件流，
用[链式 `if-else`](https://github.com/dart-lang/sdk/issues/52273)
语句根据发生的事件类型决定动作。

But sealing the base class doesn’t only allow you to switch over object patterns, like the `_checkVisibleOutsideTemplate` example in the previous section. It also ensures that while doing so, you’re accounting for every possible value that could arise for that type, without the need for a `default` case:

但密封基类不只让你能像上一节
`_checkVisibleOutsideTemplate` 例子那样
对对象 pattern 进行 switch。它还确保你这样做时
覆盖了该类型可能出现的每个值，无需 `default` case：


If a new subtype was ever added that extends `FileSystemEvent`, perhaps `FileSystemSyncEvent` for example, the compiler would be aware of it because it could only be added to the [same library](https://github.com/dart-lang/sdk/blob/main/sdk/lib/io/file_system_entity.dart) as `FileSystemEvent`. Since the class hierarchy is sealed, the compiler requires any switch over its instances to be exhaustive, and will generate [an error](https://dart.dev/tools/diagnostic-messages#non_exhaustive_switch_expression) to alert the user (who wrote the switch, not the library owner) of unhandled cases:

如果将来添加了继承 `FileSystemEvent` 的新子类型，
比如 `FileSystemSyncEvent`，编译器会知道它，
因为它只能加在与 `FileSystemEvent`
[相同的库](https://github.com/dart-lang/sdk/blob/main/sdk/lib/io/file_system_entity.dart)中。
由于类层次是密封的，编译器要求对其实例的任何 switch
都必须穷尽，并会生成[错误](https://dart.dev/tools/diagnostic-messages#non_exhaustive_switch_expression)
提醒用户（写 switch 的人，而不是库所有者）
有未处理的 case：

```bash
The type 'FileSystemEvent' is not exhaustively matched by the switch cases since it doesn't match 'FileSystemSyncEvent'

类型 'FileSystemEvent' 未被 switch 的各个 case 穷尽匹配，
因为没有匹配 'FileSystemSyncEvent'
```


Combining sealed classes and switches over object patterns enables a complete, object-oriented algebraic data type style of program architecture in Dart.

把密封类与对对象 pattern 的 switch 结合，
就能在 Dart 中实现完整的、面向对象的
代数数据类型风格程序架构。

### Bonus functional features

### 附赠的函数式特性

The exhaustive switch example above includes even more functional features from Dart 3 than just the ones that facilitate algebraic data types.

上面的穷尽 switch 例子包含的 Dart 3 函数式特性，
不止促成代数数据类型的那些。

Notice that the switch is to the right of the `_fileListener` function’s return statement—that’s Dart 3’s new [switch expression](https://dart.dev/language/branches#switch-expressions). General emphasis on expressions and functions is a key element of functional languages. Dart 3 made switch expressions that can produce a value and go anywhere an expression is allowed.

注意 switch 在 `_fileListener` 函数 return 语句的右边——
那是 Dart 3 新的
[switch 表达式](https://dart.dev/language/branches#switch-expressions)。
普遍强调表达式和函数是函数式语言的关键要素。
Dart 3 的 switch 表达式能产生值，
可以出现在任何允许表达式的地方。

And what is `_fileListener` returning in the previous example, anyway? That’s a [record](https://dart.dev/language/records), another new Dart 3 feature also related to functional programming. Records let you return multiple heterogeneous values from a function, extending the usefulness of functions in Dart, and moving further away from reliance on custom classes (which would be the only other way to return multiple values of different types without losing their types in the process).

那么前一个例子中 `_fileListener` 返回的到底是什么？
是一个 [record](https://dart.dev/language/records)，
Dart 3 另一个与函数式编程相关的新特性。
Records 让你从函数返回多个异构值，
扩展了 Dart 中函数的用处，
进一步摆脱对自定义类的依赖
（否则那是唯一能在不丢失类型的前提下
返回多个不同类型值的方式）。

## Summary

## 总结

You can model algebraic data types in Dart by:

在 Dart 中建模代数数据类型的方法：

* Writing a function that switches *on* an instance of a sealed class, and *over* its subtypes,

  编写一个函数，*对*密封类的实例进行 switch，
  *覆盖*它的各个子类型，

* And defining variances in the behavior of each subtype in the switch cases.

  并在 switch 的 case 中定义每个子类型行为的差异。

Switching over object patterns allows you to keep all the operations together in a succinct way, and exhaustiveness checking ensures the compiler will alert you if you’re missing behavior definitions for any types. And it’s all built on top of the object-oriented classes Dart already uses.

对对象 pattern 进行 switch 让你以简洁的方式
把所有操作集中在一起，穷尽性检查确保你漏掉
任何类型的行为定义时编译器会提醒你。
而这一切都构建在 Dart 已有的面向对象类之上。

The best part is, you don’t have to pick either an object-oriented or functional style; the two paradigms blend together and you can use whichever style best fits the operation you’re defining.

最棒的是，你不必在面向对象和函数式风格之间二选一；
两种范式融合在一起，你可以用最适合
所定义操作的那种风格。

You can make existing class hierarchies more functional with minor modifications, and even mix the use of instance methods with algebraic data types within the same class hierarchy. Whether it makes sense to couple behavior closely to a type, or group behavior for different types in one function, you can use the style that makes the most sense.

只需小幅修改就能让既有类层次更函数式，
甚至在同一类层次中混用实例方法和代数数据类型。
无论是把行为与类型紧密耦合合理，
还是把不同类型的行为集中到一个函数里合理，
你都可以用最合理的那种风格。

We hope this introduction piques your interest in functional programming and trying out the new Dart 3 features. Who knows, maybe we’ll see the first fully-functional-style Dart program from one of you soon!

希望这篇介绍激发你对函数式编程的兴趣，
去尝试 Dart 3 的新特性。谁知道呢，
也许我们很快就能看到你们中有人写出
第一个完全函数式风格的 Dart 程序！

### Resources

### 资源

*To learn more about functional programming in and around Dart, check out these resources:*

*想了解更多 Dart 及周边的函数式编程，请查看这些资源：*

* The official Dart documentation on [patterns](https://dart.dev/language/patterns) and [exhaustiveness checking](https://dart.dev/language/branches#exhaustiveness-checking).

  Dart 官方文档：[patterns](https://dart.dev/language/patterns)
  和[穷尽性检查](https://dart.dev/language/branches#exhaustiveness-checking)。

* The [patterns and records codelab](https://codelabs.developers.google.com/codelabs/dart-patterns-records#0) about refactoring Flutter code with Dart 3.

  关于用 Dart 3 重构 Flutter 代码的
  [patterns 和 records codelab](https://codelabs.developers.google.com/codelabs/dart-patterns-records#0)。

* This [community talk](https://www.droidcon.com/2023/08/07/the-joy-of-functional-programming-in-dart/) from FlutterCon about functional programming in Dart.

  FlutterCon 上关于 Dart 函数式编程的
  [社区演讲](https://www.droidcon.com/2023/08/07/the-joy-of-functional-programming-in-dart/)。

* This [blog post](https://journal.stuffwithstuff.com/2023/08/04/representing-heterogeneous-data/) about modeling heterogeneous data from the personal blog of Bob Nystrom (who wrote [the design for patterns in Dart](https://github.com/dart-lang/language/blob/main/accepted/3.0/patterns/feature-specification.md)!).

  Bob Nystrom（他撰写了
  [Dart patterns 的设计](https://github.com/dart-lang/language/blob/main/accepted/3.0/patterns/feature-specification.md)！）
  个人博客上关于建模异构数据的
  [文章](https://journal.stuffwithstuff.com/2023/08/04/representing-heterogeneous-data/)。
