---
# title: Class modifiers for API maintainers
title: 面向 API 维护者的类修饰符
# description: >-
#  How to use the class modifiers added in Dart 3.0
#  to make your package's API more robust and maintainable.
description: "如何使用 Dart 3.0 新增的类修饰符，让 package 的 API 更稳健、更易维护。"
ai-translated: true
prevpage:
  url: /language/class-modifiers
# title: Class modifiers
  title: 类修饰符
nextpage:
  url: /language/modifier-reference
# title: Class modifiers reference
  title: 类修饰符参考
---

Dart 3.0 adds a few [new modifiers][class modifiers]
that you can place on class and [mixin declarations][mixin].
If you are the author of a library package,
these modifiers give you more control over what users are allowed to do
with the types that your package exports.
This can make it easier to evolve your package,
and easier to know if a change to your code might break users.

Dart 3.0 增加了几个可以放在类和 [mixin 声明][mixin] 上的
[新修饰符][class modifiers]。
如果你是库 package 的作者，
这些修饰符让你更能控制用户对 package 导出的类型可以做什么。
这样更容易演进 package，
也更容易判断某次代码修改会不会破坏用户的代码。

[class modifiers]: /language/class-modifiers
[mixin]: /language/mixins

Dart 3.0 also includes a [breaking change](/resources/dart-3-migration#mixin)
around using classes as mixins.
This change might not break *your* class,
but it could break *users* of your class.

Dart 3.0 还有一处关于把类当作 mixin 使用的
[破坏性变更](/resources/dart-3-migration#mixin)。
这个变更也许不会破坏 **你的** 类，
但可能破坏你的类的 **使用者**。

This guide walks you through these changes
so you know how to use the new modifiers,
and how they affect users of your libraries.

本指南会带你了解这些变更，
让你知道如何使用这些新修饰符，
以及它们如何影响你的库的用户。

## The `mixin` modifier on classes

## 类上的 `mixin` 修饰符

The most important modifier to be aware of is `mixin`.
[Language versions][] prior to Dart 3.0 allow any class to be used as a mixin
in another class's `with` clause, _UNLESS_ the class:

最需要注意的修饰符是 `mixin`。
Dart 3.0 之前的 [语言版本][Language versions]
可以把任何类当作 mixin，用在另一个类的 `with` 子句里，
**除非** 该类：

*   Declares any non-factory constructors.

    声明了任何非工厂构造函数。
*   Extends any class other than `Object`.

    扩展了 `Object` 以外的任何类。

This makes it easy to accidentally break someone else's code,
by adding a constructor or `extends` clause to a class
without realizing that others are using it in a `with` clause.

因此很容易在无意中破坏别人的代码：
给类加上构造函数或 `extends` 子句时，
没有意识到别人正在 `with` 子句里使用它。

Dart 3.0 no longer allows classes to be used as mixins by default.
Instead, you must explicitly opt-in to that behavior by declaring a `mixin class`:

Dart 3.0 起，类默认不能再被当作 mixin 使用。
你必须显式选择启用这种行为，把声明写成 `mixin class`：

```dart
mixin class Both {}

class UseAsMixin with Both {}
class UseAsSuperclass extends Both {}
```

If you update your package to Dart 3.0 and don't change any of your code,
you might not see any errors.
But you might inadvertently break users of your package
if they were using your classes as mixins.

如果把 package 升级到 Dart 3.0 却不改任何代码，
你可能看不到任何错误。
但如果用户把你的类当作 mixin 使用，
你可能会在无意中破坏他们的代码。

[Language versions]: /language/versioning

### Migrating classes as mixins

### 迁移被当作 mixin 的类

If the class has a non-factory constructor, an `extends` clause,
or a `with` clause, then it already can't be used as a mixin.
Behavior won't change with Dart 3.0; 
there's nothing to worry about and nothing you need to do.

如果类有非工厂构造函数、`extends` 子句或 `with` 子句，
那它本来就不能被当作 mixin。
Dart 3.0 不会改变这种行为；
没什么可担心的，你也不需要做任何事。

In practice, this describes about 90% of existing classes.
For the remaining classes that can be used as mixins,
you have to decide what you want to support.

实际上，这描述了大约 90% 的现有类。
对其余可以被当作 mixin 使用的类，
你必须决定想支持什么。

Here are a few questions to help decide. The first is pragmatic:

下面几个问题可以帮助你做决定。第一个很实际：

*   **Do you want to risk breaking any users?** If the answer is a hard "no",
    then place `mixin` before any and all classes that
    [could be used as a mixin](#the-mixin-modifier-on-classes).
    This exactly preserves the existing behavior of your API.

    **你想冒破坏任何用户的风险吗？** 如果答案是坚决的「不」，
    就在所有 [可以被当作 mixin 使用](#the-mixin-modifier-on-classes) 的类前面加上 `mixin`。
    这会完全保留 API 的现有行为。

On the other hand, if you want to take this opportunity to
rethink the affordances your API offers,
then you might want to *not* turn it into a `mixin class`.
Consider these two design questions:

另一方面，如果你想借这个机会重新思考 API 提供的使用方式，
那么你也许 **不** 想把它改成 `mixin class`。
考虑下面两个设计问题：

*   **Do you want users to be able to construct instances of it directly?**
    In other words, is the class deliberately not abstract?

    **你希望用户能够直接构造它的实例吗？**
    换句话说，这个类是故意不做成抽象的吗？

*   **Do you *want* people to be able to use the declaration as a mixin?**
    In other words, do you want them to be able to use it in `with` clauses?

    **你是否希望人们把这个声明当作 mixin 来用？**
    换句话说，你是否希望他们能把它用在 `with` 子句里？

If the answer to both is "yes", then make it a mixin class. If the answer to
the second is "no", then just leave it as a class. If the answer to the first
is "no" and the second is "yes", then change it from a class to a mixin
declaration.

如果两个问题的答案都是「是」，就把它做成 mixin 类。
如果第二个答案是「不」，就保持为普通类。
如果第一个答案是「不」、第二个是「是」，
就把它从类改成 mixin 声明。

The last two options, leaving it a class or turning it into a pure mixin,
are breaking API changes. You'll want to bump the major version of your package
if you do this.

最后两种选择——保持为类，或改成纯 mixin——
都是破坏性的 API 变更。如果这样做，你需要提升 package 的主版本号。

## Other opt-in modifiers

## 其它需要选择启用的修饰符

Handling classes as mixins is the only critical change in Dart 3.0
that affects the API of your package. Once you've gotten this far,
you can stop if you don't want to make other changes
to what your package allows users to do.

把类当作 mixin 处理，是 Dart 3.0 中唯一会实质影响 package API 的关键变更。
走到这一步之后，
如果你不想再改动用户对这个 package 能做的事，就可以停下来。

Note that if you do continue and use any of the modifiers described below,
it is potentially a breaking change to your package's API that necessitates
a major version increment.

注意，如果继续使用下面描述的任何修饰符，
就可能构成 package API 的破坏性变更，因此需要提升主版本号。

## The `interface` modifier

## `interface` 修饰符

Dart doesn't have a separate syntax for declaring pure interfaces.
Instead, you declare an abstract class that happens to contain only
abstract methods.
When a user sees that class in your package's API,
they might not know if it contains code they can reuse by extending the class,
or whether it is instead meant to be used as an interface.

Dart 没有单独的语法来声明纯接口。
你声明的是一个恰好只包含抽象方法的抽象类。
用户在 package 的 API 里看到这个类时，
可能不知道它是否包含可以通过扩展该类来复用的代码，
还是本来就只打算当作接口使用。

You can clarify that by putting the [`interface`](/language/class-modifiers#interface)
modifier on the class.
That allows the class to be used in an `implements` clause,
but prevents it from being used in `extends`.

你可以加上 [`interface`](/language/class-modifiers#interface) 修饰符来表明这一点。
这样该类可以用在 `implements` 子句中，但不能用在 `extends` 中。

Even when the class *does* have non-abstract methods,
you might want to prevent users from extending it.
Inheritance is one of the most powerful kinds of coupling in software,
because it enables code reuse.
But that coupling is also [dangerous and fragile][].
When inheritance crosses package boundaries,
it can be hard to evolve the superclass without breaking subclasses.

即使类 **确实** 有非抽象方法，
你也可能希望阻止用户扩展它。
继承是软件中最强的耦合形式之一，
因为它能复用代码。
但这种耦合也 [危险且脆弱][dangerous and fragile]。
当继承跨越 package 边界时，
很难在不破坏子类的情况下演进超类。

[dangerous and fragile]: https://en.wikipedia.org/wiki/Fragile_base_class

Marking the class `interface` lets users construct it (unless it's [also marked
`abstract`](/language/class-modifiers#abstract-interface))
and implement the class's interface,
but prevents them from reusing any of its code.

把类标成 `interface` 后，用户可以构造它
（除非它 [同时也标成 `abstract`](/language/class-modifiers#abstract-interface)），
并实现该类的接口，
但不能复用它的任何代码。

When a class is marked `interface`, the restriction can be ignored within
the library where the class is declared.
Inside the library, you're free to extend it since it's all your code
and presumably you know what you're doing.
The restriction applies to other packages,
and even other libraries within your own package.

类被标成 `interface` 时，这个限制在声明该类的库内部可以忽略。
在这个库里，你可以自由扩展它，因为都是你的代码，
而且你大概知道自己在做什么。
限制适用于其它 package，
甚至适用于你自己 package 里的其它库。

## The `base` modifier

## `base` 修饰符

The [`base`](/language/class-modifiers#base)
modifier is somewhat the opposite of `interface`.
It allows you to use the class in an `extends` clause,
or use a mixin or mixin class in a `with` clause.
But, it disallows code outside of the class's library
from using the class or mixin in an `implements` clause.

[`base`](/language/class-modifiers#base) 修饰符在某种程度上与 `interface` 相反。
你可以在 `extends` 子句中使用该类，
或者在 `with` 子句中使用 mixin 或 mixin 类。
但它不允许该类所在库之外的代码
在 `implements` 子句中使用该类或 mixin。

This ensures that every object that is an instance
of your class or mixin's interface inherits your actual implementation.
In particular, this means that every instance will include
all of the private members your class or mixin declares.
This can help prevent runtime errors that might otherwise occur.

这确保每一个作为你的类或 mixin 接口实例的对象，
都会继承你的实际实现。
具体来说，这意味着每个实例都会包含
你的类或 mixin 所声明的全部私有成员。
这有助于避免原本可能发生的运行时错误。

Consider this library:

考虑这个库：

```dart title="a.dart"
class A {
  void _privateMethod() {
    print('I inherited from A');
  }
}

void callPrivateMethod(A a) {
  a._privateMethod();
}
```

This code seems fine on its own,
but there's nothing preventing a user from creating another library like this:

这段代码本身看起来没问题，
但没有什么能阻止用户创建另一个像这样的库：

```dart title="b.dart"
import 'a.dart';

class B implements A {
  // No implementation of _privateMethod()!
}

main() {
  callPrivateMethod(B()); // Runtime exception!
}
```

Adding the `base` modifier to the class can help prevent these runtime errors.
As with `interface`, you can ignore this restriction
in the same library where the `base` class or mixin is declared.
Then subclasses in the same library
will be reminded to implement the private methods.
But note that the next section *does* apply:

给类加上 `base` 修饰符有助于避免这些运行时错误。
和 `interface` 一样，你可以在声明 `base` 类或 mixin 的同一个库里忽略这个限制。
这样，同一个库里的子类会被提醒去实现那些私有方法。
但请注意，下一节 **确实** 适用：

### Base transitivity

### `base` 的传递性

The goal of marking a class `base` is to ensure that
every instance of that type concretely inherits from it.
To maintain this, the base restriction is "contagious".
Every subtype of a type marked `base` -- *direct or indirect* --
must also prevent being implemented.
That means it must be marked `base`
(or `final` or `sealed`, which we'll get to next).

把类标成 `base` 的目的，是确保该类型的每个实例都具体地继承自它。
为了维持这一点，`base` 限制是会「传染」的。
标成 `base` 的类型的每个子类型—— **直接或间接** ——
也都必须阻止被实现。
这意味着它必须标成 `base`
（或者 `final` 或 `sealed`，下面会讲到）。

Applying `base` to a type requires some care, then.
It affects not just what users can do with your class or mixin,
but also the affordances *their* subclasses can offer.
Once you've put `base` on a type, the whole hierarchy under it
is prohibited from being implemented.

因此，对类型应用 `base` 需要小心。
它影响的不只是用户对你的类或 mixin 能做什么，
还包括 **他们的** 子类能提供的使用方式。
一旦给类型加上 `base`，它下面的整个层次都不能被实现。

That sounds intense, but it's how most other programming languages
have always worked.
Most don't have implicit interfaces at all,
so when you declare a class in Java, C#, or other languages,
you effectively have the same constraint.

这听起来很严格，但大多数其它编程语言一直就是这样。
它们大多根本没有隐式接口，
所以在 Java、C# 或其它语言里声明类时，
你实际上受到同样的约束。

## The `final` modifier

## `final` 修饰符

If you want all of the restrictions of both `interface` and `base`,
you can mark a class or mixin class [`final`](/language/class-modifiers#final).
This prevents anyone outside of your library from creating
any kind of subtype of it:
no using it in `implements`, `extends`, `with`, or `on` clauses.

如果想同时拥有 `interface` 和 `base` 的全部限制，
可以把类或 mixin 类标成 [`final`](/language/class-modifiers#final)。
这会阻止你的库之外的任何人创建它的任何种类的子类型：
不能在 `implements`、`extends`、`with` 或 `on` 子句中使用它。

This is the most restrictive for users of the class.
All they can do is construct it (unless it's marked `abstract`).
In return, you have the fewest restrictions as the class maintainer.
You can add new methods, turn constructors into factory constructors, etc.
without worrying about breaking any downstream users.

这对类的用户来说限制最严。
他们能做的只是构造它（除非它被标成 `abstract`）。
作为类的维护者，你受到的限制也最少。
你可以添加新方法、把构造函数改成工厂构造函数，等等，
而不必担心破坏任何下游用户。

<a id="the-sealed-modifer" aria-hidden="true"></a>

## The `sealed` modifier

## `sealed` 修饰符

The last modifier, [`sealed`](/language/class-modifiers#sealed), is special.
It exists primarily to enable [exhaustiveness checking][] in pattern matching.
If a switch has cases for every direct subtype of a type marked `sealed`,
then the compiler knows the switch is exhaustive.

最后一个修饰符 [`sealed`](/language/class-modifiers#sealed) 比较特殊。
它主要用来在模式匹配中启用 [穷尽性检查][exhaustiveness checking]。
如果 switch 为标成 `sealed` 的类型的每个直接子类型都写了 case，
编译器就知道这个 switch 是穷尽的。

[exhaustiveness checking]: /language/branches#exhaustiveness-checking

<?code-excerpt "language/lib/class_modifiers/sealed_exhaustiveness.dart"?>
```dart title="amigos.dart"
sealed class Amigo {}

class Lucky extends Amigo {}

class Dusty extends Amigo {}

class Ned extends Amigo {}

String lastName(Amigo amigo) => switch (amigo) {
  Lucky _ => 'Day',
  Dusty _ => 'Bottoms',
  Ned _ => 'Nederlander',
};
```

This switch has a case for each of the subtypes of `Amigo`.
The compiler knows that every instance of `Amigo` must be an instance of one
of those subtypes, so it knows the switch is safely exhaustive and doesn't
require any final default case.

这个 switch 为 `Amigo` 的每个子类型都写了 case。
编译器知道 `Amigo` 的每个实例都必须是这些子类型之一的实例，
因此它知道这个 switch 可以安全地视为穷尽，
不需要最后的 default case。

For this to be sound, the compiler enforces two restrictions:

为了让这一点是健全的，编译器强制执行两条限制：

1.  The sealed class can't itself be directly constructible.
    Otherwise, you could have an instance of `Amigo` that isn't
    an instance of *any* of the subtypes.
    So every `sealed` class is implicitly `abstract` too.

    sealed 类本身不能被直接构造。
    否则你就会得到一个 `Amigo` 实例，它不是 **任何** 子类型的实例。
    因此每个 `sealed` 类同时也隐式地是 `abstract`。

2.  Every direct subtype of the sealed type must be in the same library
    where the sealed type is declared.
    This way, the compiler can find them all. It knows that there aren't
    other hidden subtypes floating around that would not match any of the cases.

    sealed 类型的每个直接子类型都必须位于声明该 sealed 类型的同一个库中。
    这样编译器才能把它们全部找到。它知道不会有其它藏起来的子类型，
    以至于匹配不上任何一个 case。

The second restriction is similar to `final`.
Like `final`, it means that a class marked `sealed` can't be directly
extended, implemented, or mixed in outside of the library where it's declared.
But, unlike `base` and `final`, there is no *transitive* restriction:

第二条限制与 `final` 类似。
和 `final` 一样，它意味着标成 `sealed` 的类不能在声明它的库之外
被直接扩展、实现或混入。
但是，与 `base` 和 `final` 不同，这里没有 **传递性** 限制：

```dart title="amigo.dart"
sealed class Amigo {}
class Lucky extends Amigo {}
class Dusty extends Amigo {}
class Ned extends Amigo {}
```

```dart title="other.dart"
// This is an error:
class Bad extends Amigo {}

// But these are both fine:
class OtherLucky extends Lucky {}
class OtherDusty implements Dusty {}
```

Of course, if you *want* the subtypes of your sealed type
to be restricted as well, you can get that by marking them
using `interface`, `base`, `final`, or `sealed`.

当然，如果你 **希望** sealed 类型的子类型也受到限制，
可以把它们标成 `interface`、`base`、`final` 或 `sealed`。

### `sealed` versus `final`

### `sealed` 与 `final` 的取舍

If you have a class that you don't want users to be able to directly subtype,
when should you use `sealed` versus `final`?
A couple of simple rules:

如果你有一个不希望用户能够直接派生子类型的类，
什么时候用 `sealed`，什么时候用 `final`？
几条简单的规则：

*   If you want users to be able to directly construct instances of the class,
    then it *can't* use `sealed` since sealed types are implicitly abstract.

    如果你希望用户能够直接构造该类的实例，
    那它就 **不能** 使用 `sealed`，因为 sealed 类型是隐式抽象的。

*   If the class has no subtypes in your library, then there's no point in using
    `sealed` since you get no exhaustiveness checking benefits.

    如果这个类在你的库里没有子类型，那就没必要使用 `sealed`，
    因为你得不到穷尽性检查的好处。

Otherwise, if the class does have some subtypes that you define,
then `sealed` is likely what you want.
If users see that the class has a few subtypes, it's handy to be able
to handle each of them separately as switch cases
and have the compiler know that the entire type is covered.

否则，如果这个类确实有一些你定义的子类型，
那 `sealed` 很可能就是你想要的。
如果用户看到这个类有几个子类型，
就能方便地把它们分别写成 switch 的 case，
并让编译器知道整个类型都已被覆盖。

Using `sealed` does mean that if you later add another subtype to the library,
it's a breaking API change.
When a new subtype appears,
all of those existing switches become non-exhaustive
since they don't handle the new type.
It's exactly like adding a new value to an enum.

使用 `sealed` 确实意味着，如果以后再往库里添加另一个子类型，
那就是破坏性的 API 变更。
出现新的子类型时，
所有现有的 switch 都会变成非穷尽的，
因为它们没有处理这个新类型。
这和往枚举里添加一个新值完全一样。

Those non-exhaustive switch compile errors are *useful* to users
because they draw the user's attention to places in their code
where they'll need to handle the new type.

这些非穷尽 switch 的编译错误对用户是 **有用的**，
因为它们会把用户的注意力引到代码中
需要处理这个新类型的地方。

But it does mean that whenever you add a new subtype, it's a breaking change.
If you want the freedom to add new subtypes in a non-breaking way,
then it's better to mark the supertype using `final` instead of `sealed`.
That means that when a user switches on a value of that supertype,
even if they have cases for all of the subtypes,
the compiler will force them to add another default case.
That default case will then be what is executed if you add more subtypes later.

但这确实意味着，每当你添加新子类型，都是一次破坏性变更。
如果你希望能以非破坏性的方式添加新子类型，
最好用 `final` 而不是 `sealed` 来标记超类型。
这意味着当用户对这个超类型的值做 switch 时，
即使他们为所有子类型都写了 case，
编译器也会强制他们再加一个 default case。
以后如果你添加更多子类型，执行的就是这个 default case。

## Summary

## 小结

As an API designer,
these new modifiers give you control over how users work with your code,
and conversely how you are able to evolve your code without breaking theirs.

作为 API 设计者，
这些新修饰符让你控制用户如何使用你的代码，
反过来也让你能够在不破坏他们代码的情况下演进自己的代码。

But these options carry complexity with them:
you now have more choices to make as an API designer.
Also, since these features are new,
we still don't know what the best practices will be.
Every language's ecosystem is different and has different needs.

但这些选项也带来了复杂性：
作为 API 设计者，你现在有更多选择要做。
而且，由于这些特性还很新，
我们仍然不知道最佳实践会是什么。
每种语言的生态都不同，需求也不同。

Fortunately, you don't need to figure it out all at once.
We chose the defaults deliberately so that even if you do nothing,
your classes mostly have the same affordances they had before 3.0.
If you just want to keep your API the way it was,
put `mixin` on the classes that already supported that, and you're done.

好在你不必一次就全部想清楚。
我们有意选择了这些默认值，所以即使你什么都不做，
你的类大体上仍具有 3.0 之前的那些使用方式。
如果你只想让 API 保持原样，
给原本就支持 mixin 的类加上 `mixin`，就完成了。

Over time, as you get a sense of where you want finer control,
you can consider applying some of the other modifiers:

随着时间推移，当你弄清想在哪里做更细的控制时，
可以考虑应用其它一些修饰符：

*   Use `interface` to prevent users from reusing your class's code
    while allowing them to re-implement its interface.

    使用 `interface`，阻止用户复用你的类的代码，
    同时仍让他们重新实现它的接口。

*   Use `base` to require users to reuse your class's code
    and ensure every instance of your class's type is an instance
    of that actual class or a subclass.

    使用 `base`，要求用户复用你的类的代码，
    并确保你的类的类型的每个实例
    都是那个实际的类或其子类的实例。

*   Use `final` to completely prevent a class from being extended.

    使用 `final`，完全阻止一个类被扩展。

*   Use `sealed` to opt in to exhaustiveness checking on a family of subtypes.

    使用 `sealed`，为一族子类型选择启用穷尽性检查。

When you do, increment the major version when publishing your package,
since these modifiers all imply restrictions that are breaking changes.

这样做时，发布 package 要提升主版本号，
因为这些修饰符都意味着构成破坏性变更的限制。
