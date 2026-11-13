---
# title: Package versioning
title: Package 的版本管理
# description: >-
#   How Dart's package management tool, pub, handles versioning of packages.
description: Dart 的 package 管理工具 pub 如何处理 package 的版本。
ai-translated: true
---

The [pub package manager][pub] helps you work with versioning.
This guide explains a bit about the history of versioning and pub's
approach to it.

[pub package 管理工具][pub] 会帮助你处理版本。
本指南介绍一点版本管理的历史，以及 pub 的做法。

Consider this to be advanced information.
To learn _why_ pub was designed the way it was, keep reading.
If you want to _use_ pub, consult the [other docs][pub].

请把这些内容视为进阶信息。
想了解 pub **为什么** 设计成这样，请继续阅读。
如果你想 **使用** pub，请查阅 [其他文档][pub]。

Modern software development, especially web development, leans heavily on
reusing lots and lots of existing code. That includes code _you_ wrote in the
past, but also code from third-parties, everything from big frameworks to small
utility libraries. It's not uncommon for an application to depend on
dozens of different packages and libraries.

现代软件开发，尤其是 Web 开发，非常依赖大量复用已有代码。
这既包括 **你** 过去写的代码，也包括第三方代码，
从大型框架到小型工具库都有。
一个应用依赖几十个不同的 package 和库，并不少见。

It's hard to understate how powerful this is. When you see stories of small web
startups building a site in a few weeks that gets millions of users, the
only reason they can achieve this is because the open source community has
laid a feast of software at their feet.

这一点的威力很难被低估。
当你看到小型 Web 创业公司在几周内做出一个拥有数百万用户的网站时，
他们能做到这一点，只是因为开源社区已经把一场软件盛宴摆在了他们面前。

But this doesn't come for free: There's a challenge to code
reuse, especially reusing code you don't maintain. When your app uses code
being developed by other people, what happens when they change it?
They don't want to break your app, and you certainly don't either.
We solve this problem by _versioning_.

但这并不是没有代价：代码复用存在挑战，
尤其是复用你并不维护的代码。
当你的应用使用别人正在开发的代码时，他们一改代码会怎样？
他们不想弄坏你的应用，你当然也不想。
我们用 **版本管理** 来解决这个问题。

## A name and a number

## 一个名称和一个数字

When you depend on some piece of outside code,
you don't just say "My app uses `widgets`." You say, "My app uses
`widgets 2.0.5`." That combination of name and version number uniquely
identifies an _immutable_ chunk of code. The people updating `widgets` can
make all of the changes they want, but they promise to not touch any already
released versions. They can put out `2.0.6` or `3.0.0` and it won't affect you
one bit because the version you use is unchanged.

依赖某段外部代码时，你不会只说「My app uses `widgets`.」。
你会说「My app uses `widgets 2.0.5`.」。
名称和版本号的组合，唯一标识一块 **不可变** 的代码。
更新 `widgets` 的人可以做他们想做的任何更改，
但他们承诺不会改动任何已经发布的版本。
他们可以发布 `2.0.6` 或 `3.0.0`，这完全不会影响你，
因为你使用的那个版本没有变化。

When you _do_ want to get those changes, you can always point your app to a
newer version of `widgets` and you don't have to coordinate with those
developers to do it. However, that doesn't entirely solve the problem.

当你 **确实** 想获取那些更改时，
你随时可以把应用指向更新版本的 `widgets`，
也不必和那些开发者协调。不过，这并没有完全解决问题。

The version numbers discussed in this guide might differ from the
version number set in the package filename.
They might include `-0` or `-beta`.
These notations don't affect dependency resolution.

本指南讨论的版本号可能和 package 文件名中的版本号不同。
它们可能包含 `-0` 或 `-beta`。
这些记法不影响依赖解析。

## Resolving shared dependencies

## 解析共享依赖

Depending on specific versions works fine when your dependency
_graph_ is really just a dependency _tree_. If your app depends on a bunch of
packages, and those things in turn have their own dependencies and so on, that
all works fine as long as none of those dependencies _overlap_.

当依赖 **图** 实际上只是一棵依赖 **树** 时，依赖具体版本就能工作得很好。
如果你的应用依赖一批 package，而这些 package 又有自己的依赖，如此层层下去，
只要这些依赖互不 **重叠**，一切都会顺利。

Consider the following example:

考虑下面的例子：

<img src="/assets/img/tools/pub/PubConstraintsDiagram.png" alt="dependency graph">

So your app uses `widgets` and `templates`, and _both_ of those use
`collection`. This is called a **shared dependency**. Now what happens when
`widgets` wants to use `collection 2.3.5` and `templates` wants
`collection 2.3.7`? What if they don't agree on a version?

于是你的应用使用 `widgets` 和 `templates`，而 **两者** 都使用 `collection`。
这叫做 **共享依赖**。
如果 `widgets` 想使用 `collection 2.3.5`，而 `templates` 想使用 `collection 2.3.7`，
会怎样？如果它们对版本达不成一致呢？

### Unshared libraries (the npm approach)

### 不共享库（npm 的做法）

One option is to just let the app use both
versions of `collection`. It will have two copies of the library at different
versions and `widgets` and `templates` will each get the one they want.

一种选择是让应用同时使用 `collection` 的两个版本。
库会有两份不同版本的副本，`widgets` 和 `templates` 各自拿到自己想要的那一份。

This is what [npm][] does for node.js. Would it work for Dart? Consider this
scenario:

这就是 [npm][] 在 node.js 中的做法。它对 Dart 适用吗？考虑这个场景：

 1. `collection` defines some `Dictionary` class.

    `collection` 定义了某个 `Dictionary` 类。

 2. `widgets` gets an instance of it from its copy of `collection` (`2.3.5`).
    It then passes it up to `my_app`.

    `widgets` 从自己的 `collection` 副本（`2.3.5`）拿到一个实例。
    然后把它向上传给 `my_app`。

 3. `my_app` sends the dictionary over to `templates`.

    `my_app` 把这个 dictionary 传给 `templates`。

 4. That in turn sends it down to *its* version of `collection` (`2.3.7`).

    后者再把它传给 **它自己的** `collection` 版本（`2.3.7`）。

 5. The method that takes it has a `Dictionary` type annotation for that object.

    接收它的方法为该对象标注了 `Dictionary` 类型。

As far as Dart is concerned, `collection 2.3.5` and `collection 2.3.7` are
entirely unrelated libraries. If you take an instance of class `Dictionary`
from one and pass it to a method in the other, that's a completely different
`Dictionary` type. That means it will fail to match a `Dictionary` type
annotation in the receiving library. Oops.

就 Dart 而言，`collection 2.3.5` 和 `collection 2.3.7` 是完全无关的库。
如果你从其中一个取出 `Dictionary` 类的实例，传给另一个库中的方法，
那就是完全不同的 `Dictionary` 类型。
因此它无法匹配接收方库里的 `Dictionary` 类型标注。糟糕。

Because of this (and because of the headaches of trying to debug an app that
has multiple versions of things with the same name), we've decided npm's model
isn't a good fit.

正因为如此（也因为调试一个同名事物存在多个版本的应用会很头疼），
我们认定 npm 的模型并不适合。

### Version lock (the dead end approach)

### 版本锁定（走不通的做法）

Instead, when you depend on a package, your app only uses a single copy of
that package. When you have a shared dependency, everything that depends on it
has to agree on which version to use. If they don't, you get an error.

因此，当你依赖一个 package 时，应用只使用该 package 的一份副本。
存在共享依赖时，所有依赖它的一方都必须就使用哪个版本达成一致。
如果达不成一致，你就会得到一个错误。

That doesn't actually solve your problem though. When you _do_ get that error,
you need to be able to resolve it. So let's say you've gotten yourself into
that situation in the previous example. You want to use `widgets` and
`templates`, but they are using different versions of `collection`. What do
you do?

不过这并没有真正解决你的问题。当你 **确实** 遇到那个错误时，
你需要有办法处理它。假设你陷入了前面例子中的处境。
你想同时使用 `widgets` 和 `templates`，
但它们使用了不同版本的 `collection`。你该怎么办？

The answer is to try to upgrade one of those. `templates` wants
`collection 2.3.7`. Is there a later version of `widgets` that you can upgrade
to that works with that version?

答案是试着升级其中一方。`templates` 想要 `collection 2.3.7`。
有没有一个你能升级到的、更新的 `widgets` 版本，可以和这个版本一起工作？

In many cases, the answer will be "no". Look at it from the perspective of the
people developing `widgets`. They want to put out a new version with new changes
to _their_ code, and they want as many people to be able to upgrade to it as
possible. If they stick to their _current_ version of `collection` then anyone
who is using the current version `widgets` will be able to drop in this new one
too.

很多情况下，答案是「no」。
从开发 `widgets` 的人的角度来看。
他们想发布一个新版本，在 **他们自己** 的代码里加入新更改，
并且希望尽可能多的人能够升级到它。
如果他们坚持使用 **当前** 的 `collection` 版本，
那么任何正在使用当前版本 `widgets` 的人，也都能直接换上这个新版本。

If they were to upgrade _their_ dependency on `collection` then everyone who
upgrades `widgets` would have to as well, _whether they want to or not_.
That's painful, so you end up with a disincentive to upgrade dependencies.
That's called **version lock**:
everyone wants to move their dependencies forward,
but no one can take the first step because it forces everyone else to as well.

如果他们升级 **自己** 对 `collection` 的依赖，
那么每个升级 `widgets` 的人也都必须跟着升级，**无论他们是否愿意**。
这很痛苦，于是人们就不愿意升级依赖。
这叫做 **版本锁定**：
每个人都想把自己的依赖向前推进，
但没有人能迈出第一步，因为这一步会迫使其他所有人也跟着走。

### Version constraints (the Dart approach)

### 版本约束（Dart 的做法）

To solve version lock, we loosen the constraints that packages place on their
dependencies. If `widgets` and `templates` can both indicate a _range_ of
versions for `collection` that they work with, then that gives us enough
wiggle room to move our dependencies forward to newer versions. As long as there
is overlap in their ranges, we can still find a single version that makes them
both happy.

为了解决版本锁定，我们放宽 package 施加在依赖上的约束。
如果 `widgets` 和 `templates` 都能标明它们可以配合的 `collection` 版本 **范围**，
我们就有足够的余地把依赖向前推进到更新的版本。
只要它们的范围有重叠，我们仍然能找到一个让双方都满意的单一版本。

This is the model that [bundler][] follows,
and is pub's model too. When you add a dependency in your pubspec,
you can specify a _range_ of versions that you can accept.
If the pubspec for `widgets` looked like this:

这是 [bundler][] 采用的模型，也是 pub 的模型。
在 pubspec 中添加依赖时，你可以指定一个能够接受的版本 **范围**。
如果 `widgets` 的 pubspec 像这样：

```yaml
dependencies:
  collection: '>=2.3.5 <2.4.0'
```

You could pick version `2.3.7` for `collection`.
A single concrete version would satisfy constraints for
both the `widgets` and `templates` packages.

你可以为 `collection` 选择 `2.3.7` 版本。
一个具体版本就能同时满足 `widgets` 和 `templates` 这两个 package 的约束。

## Semantic versions

## 语义化版本

When you add a dependency to your package, you'll sometimes want to specify a
range of versions to allow. How do you know what range to pick? You need to be
forward compatible, so ideally the range encompasses future versions that
haven't been released yet. But how do you know your package is going to work
with some new version that doesn't even exist yet?

为 package 添加依赖时，你有时会想指定允许的版本范围。
怎么知道该选什么范围？你需要向前兼容，
所以理想情况下，这个范围要覆盖尚未发布的未来版本。
但你怎么知道自己的 package 能和一个甚至还不存在的新版本一起工作？

To solve that, you need to agree on what a version number _means_.
Imagine that the developers of a package you depend on say,
"If we make any backwards incompatible change,
then we promise to increment the major version number."
If you trust them, then if you know your package works with `2.3.5` of theirs,
you can rely on it working all the way up to `3.0.0`.
You can set your range like:

要解决这个问题，你们需要对版本号 **意味着** 什么达成一致。
设想你所依赖的 package 的开发者说：
「If we make any backwards incompatible change,
then we promise to increment the major version number.」
如果你信任他们，而且知道自己的 package 能和他们的 `2.3.5` 一起工作，
你就可以指望它一直工作到 `3.0.0`。
你可以这样设置范围：

```yaml
dependencies:
  collection: ^2.3.5
```

:::note
This example uses _caret syntax_ to express a range of versions.
The string `^2.3.5` means "the range of all versions from 2.3.5 to 3.0.0,
not including 3.0.0."
To learn more, consult the [caret syntax][caret-syntax] section.

这个例子使用 **插入符语法** 来表达版本范围。
字符串 `^2.3.5` 的意思是「从 2.3.5 到 3.0.0 的所有版本，不包括 3.0.0」。
要了解更多，请参阅 [插入符语法][caret-syntax] 一节。
:::

To make this work, then, we need to come up with that set of promises.
Fortunately, other smart people have done the work of figuring this all out and
named it _[semantic versioning][semver]_.

于是，要让这套做法成立，我们需要提出那一组承诺。
好在其他聪明的人已经把这些都想清楚了，并把它命名为 **[语义化版本][semver]**。

That describes the format of a version number, and the exact API behavioral
differences when you increment to a later version number. Pub requires versions
to be formatted that way, and to play well with the pub community, your package
should follow the semantics it specifies. You should assume that the packages
you depend on also follow it. (And if you find out they don't, let their
authors know!)

它描述了版本号的格式，以及递增到更高版本号时 API 行为的确切差异。
pub 要求版本按这种方式书写。
要想和 pub 社区良好协作，你的 package 应该遵循它所规定的语义。
你也应该假定自己依赖的 package 同样遵循它。
（如果你发现它们没有遵循，请告诉它们的作者！）

Although semantic versioning doesn't promise any compatibility between versions
prior to `1.0.0`, the Dart community convention is to treat those versions
semantically as well. The interpretation of each number is just shifted down one
slot: going from `0.1.2` to `0.2.0` indicates a breaking change, going to
`0.1.3` indicates a new feature, and going to `0.1.2+1` indicates a change that
doesn't affect the public API.
For simplicity's sake, avoid using `+` after the version reaches `1.0.0`.

虽然语义化版本对 `1.0.0` 之前的版本不作任何兼容性承诺，
Dart 社区的约定是对这些版本同样按语义来对待。
每个数字的含义只是整体下移一档：
从 `0.1.2` 到 `0.2.0` 表示破坏性更改，到 `0.1.3` 表示新功能，
到 `0.1.2+1` 表示不影响公开 API 的更改。
为了简单起见，版本达到 `1.0.0` 之后请避免使用 `+`。

We've got almost all of the pieces we need to deal with versioning and API
evolution now. Let's see how they play together and what pub does.

现在，处理版本管理和 API 演进所需的部件几乎都齐了。
让我们看看它们如何配合，以及 pub 会做什么。

## Constraint solving

## 约束求解

When you define your package, you list its
[immediate dependencies][immediate-dep].
These are packages that your package uses.
For each of these packages, you specify the range of versions your package allows.
Each of those dependent packages might then have their own dependencies.
These are called [transitive dependencies][transitive-dep].
Pub traverses these and builds the entire dependency graph for your app.

定义 package 时，你会列出它的 [直接依赖][immediate-dep]。
这些是你的 package 所使用的 package。
对于每一个，你指定自己的 package 允许的版本范围。
这些被依赖的 package 可能又有自己的依赖。
这些叫做 [传递依赖][transitive-dep]。
pub 会遍历它们，并为你的应用构建完整的依赖图。

For each package in the graph, pub looks at everything that depends on it.
It gathers together all of their version constraints and
tries to simultaneously solve them. Basically, it intersects their ranges.
Then pub looks at the actual versions that have been released for that
package and selects the most recent one that meets all of those constraints.

对于图中的每个 package，pub 会查看所有依赖它的一方。
它收集它们的全部版本约束，并尝试同时求解。
基本上，就是取这些范围的交集。
然后 pub 查看该 package 已经发布的实际版本，
选择满足所有这些约束的最新一个。

For example, let's say our dependency graph contains `collection`, and three
packages depend on it. Their version constraints are:

例如，假设依赖图中包含 `collection`，并且有三个 package 依赖它。
它们的版本约束是：

```plaintext
>=1.7.0
^1.4.0
<1.9.0
```

The developers of `collection` have released these versions of it:

`collection` 的开发者已经发布了这些版本：

```plaintext
1.7.0
1.7.1
1.8.0
1.8.1
1.8.2
1.9.0
```

The highest version number that fits in all of those ranges is `1.8.2`, so pub
picks that. That means your app _and every package your app uses_ will all use
`collection 1.8.2`.

落在所有这些范围里的最高版本号是 `1.8.2`，所以 pub 选择它。
这意味着你的应用 **以及你的应用所使用的每一个 package** 都会使用 `collection 1.8.2`。

## Constraint context

## 约束上下文

The fact that selecting a package version takes into account _every_ package
that depends on it has an important consequence: _the specific version that
will be selected for a package is a global property of the app using that
package._

选择 package 版本时会考虑依赖它的 **每一个** package，这带来一个重要后果：
**为某个 package 选定的具体版本，是使用该 package 的应用的全局属性。**

The following example shows what this means. Let's say we have
two apps. Here are their pubspecs:

下面的例子说明这意味着什么。假设我们有两个应用。它们的 pubspec 如下：

```yaml
name: my_app
dependencies:
  widgets:
```

```yaml
name: other_app
dependencies:
  widgets:
  collection: '<1.5.0'
```

They both depend on `widgets`, whose pubspec is:

它们都依赖 `widgets`，其 pubspec 是：

```yaml
name: widgets
dependencies:
  collection: '>=1.0.0 <2.0.0'
```

The `other_app` package depends directly on `collection` itself. The
interesting part is that it happens to have a different version constraint on
it than `widgets` does.

`other_app` 这个 package 直接依赖 `collection` 本身。
有趣的是，它对 `collection` 的版本约束恰好和 `widgets` 的不同。

This means that you can't just look at the `widgets` package in
isolation to figure out what version of `collection` it will use. It depends
on the context. In `my_app`, `widgets` will use `collection 1.9.9`. But
in `other_app`, `widgets` will get saddled with `collection 1.4.9` because of
the _other_ constraint that `otherapp` places on it.

这意味着你不能孤立地看 `widgets` 这个 package，
就判断它会使用哪个版本的 `collection`。这取决于上下文。
在 `my_app` 中，`widgets` 会使用 `collection 1.9.9`。
但在 `other_app` 中，`widgets` 会被迫使用 `collection 1.4.9`，
因为 `otherapp` 对它施加了 **另一条** 约束。

This is why each app gets its own `package_config.json` file: The concrete version selected for each package depends on
the entire dependency graph of the containing app.

这就是每个应用都有自己的 `package_config.json` 文件的原因：
为每个 package 选定的具体版本，取决于包含它的应用的整张依赖图。

## Constraint solving for exported dependencies

## 导出依赖的约束求解

Package authors must define package constraints with care.
Consider the following scenario:

package 作者必须谨慎定义 package 约束。考虑下面的场景：

<img src="/assets/img/tools/pub/PubExportedConstraints.png" alt="dependency graph" class="diagram-wrap">

The `bookshelf` package depends on `widgets`.
The `widgets` package, currently at 1.2.0, exports
`collection` via `export 'package:collection/collection.dart'`, and is
at 2.4.0. The pubspec files are as follows:

`bookshelf` package 依赖 `widgets`。
`widgets` package 当前是 1.2.0，
通过 `export 'package:collection/collection.dart'` 导出 `collection`，
而 `collection` 是 2.4.0。pubspec 文件如下：

```yaml
name: bookshelf
dependencies:
  widgets: ^1.2.0
```

```yaml
name: widgets
dependencies:
  collection: ^2.4.0
```

The `collection` package is then updated to 2.5.0.
The 2.5.0 version of `collection` includes a new method called `sortBackwards()`.
`bookshelf` might call `sortBackwards()`,
because it's part of the API exposed by `widgets`,
despite `bookshelf` having only a transitive dependency on `collection`.

然后 `collection` package 更新到 2.5.0。
`collection` 的 2.5.0 版本包含一个名为 `sortBackwards()` 的新方法。
`bookshelf` 可能会调用 `sortBackwards()`，
因为它是 `widgets` 所暴露 API 的一部分，
尽管 `bookshelf` 对 `collection` 只有传递依赖。

Because `widgets` has an API that's not reflected in its version number,
the app that uses the `bookshelf` package and calls `sortBackwards()`
might crash.

因为 `widgets` 有一部分 API 没有反映在它的版本号里，
使用 `bookshelf` package 并调用 `sortBackwards()` 的应用可能会崩溃。

Exporting an API causes that API to be treated as if it is
defined in the package itself, but it can't increase the version number when
the API adds features. This means that `bookshelf` has no way of declaring
that it needs a version of `widgets` that supports `sortBackwards()`.

导出一个 API 会让这个 API 被当作定义在 package 自身之中，
但当这个 API 增加功能时，它并不能提高版本号。
这意味着 `bookshelf` 没有办法声明
自己需要一个支持 `sortBackwards()` 的 `widgets` 版本。

For this reason, when dealing with exported packages,
it's recommended that the package's author keeps a tighter
limit on the upper and lower bounds of a dependency.
In this case, the range for the `widgets` package should be narrowed:

因此，在处理被导出的 package 时，
建议 package 作者把依赖的上下界收得更紧。
在这个例子中，应该收窄 `widgets` package 的范围：

```yaml
name: bookshelf
dependencies:
  widgets: '>=1.2.0 <1.3.0'
```

```yaml
name: widgets
dependencies:
  collection: '>=2.4.0 <2.5.0'
```

This translates to a lower bound of 1.2.0 for `widgets`
and 2.4.0 for `collection`.
When someone releases the 2.5.0 version of `collection`,
pub updates `widgets` to 1.3.0 and updates the corresponding constraints
as well.

这相当于把 `widgets` 的下界设为 1.2.0，把 `collection` 的下界设为 2.4.0。
当有人发布 `collection` 的 2.5.0 版本时，
pub 会把 `widgets` 更新到 1.3.0，并同时更新相应的约束。

Using this convention ensures that users have the correct version of
both packages, even if one is not a direct dependency.

遵循这个约定，可以确保用户拿到两个 package 的正确版本，
即使其中一个不是直接依赖。

## Lockfiles

## Lockfile

So once pub has solved your app's version constraints, then what? The end
result is a complete list of every package that your app depends on either
directly or indirectly and the best version of that package that will work with
your app's constraints.

那么，一旦 pub 解出了应用的版本约束，接下来呢？
最终结果是一份完整列表，列出你的应用直接或间接依赖的每一个 package，
以及能配合你的应用约束的该 package 的最佳版本。

For each package, pub takes that information,
computes a [content hash][] from it,
and writes both to a _[lockfile][]_
in your app's directory called `pubspec.lock`. When pub builds the `.dart_tool/package_config.json` file for your app, it uses the lockfile to know what versions of each package to refer to. (And if you're curious to see what versions it selected, you can read the lockfile to find out.)

对于每个 package，pub 会取出这些信息，据此计算 [内容哈希][content hash]，
并把两者都写入应用目录中名为 `pubspec.lock` 的 **[lockfile][lockfile]**。
当 pub 为你的应用构建 `.dart_tool/package_config.json` 文件时，
它会用 lockfile 来确定每个 package 该引用哪个版本。
（如果你好奇它选了哪些版本，可以阅读 lockfile 来了解。）

The next important thing pub does is it _stops touching the lockfile_. Once
you've got a lockfile for your app, pub won't touch it until you tell it to.
This is important. It means you won't spontaneously start using new versions
of random packages in your app without intending to. Once your app is locked,
it stays locked until you manually tell it to update the lockfile.

pub 接下来做的一件重要的事，是 **不再改动 lockfile**。
一旦应用有了 lockfile，在你明确要求之前，pub 不会再碰它。
这很重要。这意味着你不会在无意中突然开始使用应用里某些 package 的新版本。
应用一旦锁定，就会保持锁定，直到你手动要求更新 lockfile。

If your package is for an app, you _check your lockfile into your source
control system!_ That way, everyone on your team will be using
the exact same versions of every dependency when they build your app. You'll
also use this when you deploy your app so you can ensure that your production
servers are using the exact same packages that you're developing with.

如果你的 package 是一个应用，**请把 lockfile 签入源代码管理系统！**
这样，团队里的每个人在构建应用时，都会使用每一项依赖的完全相同的版本。
部署应用时你也会用到它，从而确保生产服务器使用的 package
和你开发时使用的完全相同。

## When things go wrong

## 当出问题时

Of course, all of this presumes that your dependency graph is perfect and
flawless. Even with version ranges and pub's constraint solving and
semantic versioning, you can never be entirely spared from the
dangers of versionitis.

当然，以上这些都假定你的依赖图完美无缺。
即使有了版本范围、pub 的约束求解和语义化版本，
你也永远无法完全躲开 versionitis 带来的风险。

You might run into one of the following problems:

你可能会遇到下面这些问题之一：

### You can have disjoint constraints

### 约束可能互不相交

Let's say your app uses `widgets` and
`templates` and both use `collection`. But `widgets` asks for a version
of it between `1.0.0` and `2.0.0` and `templates` wants something
between `3.0.0` and `4.0.0`. Those ranges don't even overlap. There's no
possible version that would work.

假设你的应用使用 `widgets` 和 `templates`，两者都使用 `collection`。
但 `widgets` 要求的版本在 `1.0.0` 和 `2.0.0` 之间，
而 `templates` 想要 `3.0.0` 和 `4.0.0` 之间的某个版本。
这些范围甚至没有重叠。不存在任何一个能工作的版本。

### You can have ranges that don't contain a released version

### 范围里可能没有已发布的版本

Let's say after putting all of the constraints on a shared dependency together,
you have a narrow range of `>=1.2.4 <1.2.6`. It's not an empty range.
If there was a version `1.2.4` of the dependency, you'd be golden.
But maybe they never released that version.
Instead, they went straight from `1.2.3` to `1.3.0`.
You've got a range with nothing inside it.

假设把一项共享依赖上的全部约束放在一起之后，
你得到一个很窄的范围 `>=1.2.4 <1.2.6`。它并不是空范围。
如果依赖真的有 `1.2.4` 这个版本，你就没问题了。
但他们也许从未发布那个版本。
他们直接从 `1.2.3` 跳到了 `1.3.0`。
于是你有一个里面什么都没有的范围。

### You can have an unstable graph

### 依赖图可能不稳定

This is, by far, the most challenging part of
pub's version solving process. The process was described as _build up the
dependency graph and then solve all of the constraints and pick versions_.
But it doesn't actually work that way. How could you build up the _whole_
dependency graph before you've picked _any_ versions? _The pubspecs
themselves are version-specific._ Different versions of the same package
might have different sets of dependencies.

这是 pub 版本求解过程中迄今最难的部分。
前面把这个过程描述为 **先建立依赖图，然后求解全部约束并挑选版本**。
但实际上并不是这样工作的。
在选出 **任何** 版本之前，你怎么可能建立 **完整** 的依赖图？
**pubspec 本身是随版本变化的。**
同一个 package 的不同版本可能有不同的依赖集合。

As you're selecting versions of packages, they are changing the shape of
the dependency graph itself. As the graph changes, that might change
constraints, which can cause you to select different versions, and then you
go right back around in a circle.

当你挑选 package 版本时，它们本身就在改变依赖图的形状。
图一变，约束可能跟着变，这又会让你选出不同的版本，
然后你又绕回这个循环。

Sometimes this process never settles down into a stable solution.
Gaze into the abyss:

有时这个过程永远无法稳定到一个解上。凝视深渊：

```yaml
name: my_app
version: 0.0.0
dependencies:
  yin: '>=1.0.0'
```

```yaml
name: yin
version: 1.0.0
dependencies:
```

```yaml
name: yin
version: 2.0.0
dependencies:
  yang: '1.0.0'
```

```yaml
name: yang
version: 1.0.0
dependencies:
  yin: '1.0.0'
```

In all of these cases, there is no set of concrete versions that will work for
your app, and when this happens pub reports an error and tells you what's
going on. It definitely won't leave you in some weird state where you
think things can work but won't.

在所有这些情况下，都不存在一组能让你的应用工作的具体版本。
发生这种情况时，pub 会报告错误并告诉你发生了什么。
它绝不会把你留在一种奇怪的状态里：你以为事情能工作，实际上却不能。

## Summary

## 小结

In summary:

小结：

* Though code reuse has advantages,
  packages require the ability to evolve independently.

  尽管代码复用有好处，package 仍然需要能够独立演进。

* Versioning enables that independence.
  Depending on single concrete versions lacks flexibility.
  Coupled with shared dependencies, it leads to version lock.

  版本管理使这种独立性成为可能。
  依赖单一的具体版本缺乏灵活性。
  再加上共享依赖，就会导致版本锁定。

* To cope with version lock,
  your package should depend on a _range_ of versions.
  Pub then walks your dependency graph and picks the best versions for you.
  If it can't pick an appropriate version, pub alerts you.

  为了应对版本锁定，你的 package 应该依赖一个版本 **范围**。
  然后 pub 会遍历你的依赖图，为你挑选最佳版本。
  如果它选不出合适的版本，pub 会提醒你。

* Once your app has a solid set of versions for its dependencies,
  that set gets pinned down in a _lockfile_.
  That ensures that every machine running your app uses the same versions
  of all of its dependencies.

  一旦应用有了一组可靠的依赖版本，这组版本就会固定在 **lockfile** 中。
  这确保运行你的应用的每台机器都使用所有依赖的相同版本。

To learn more about pub's version solving algorithm,
consult the [PubGrub][pubgrub] article on Medium.

要进一步了解 pub 的版本求解算法，请参阅 Medium 上的 [PubGrub][pubgrub] 文章。

[immediate-dep]: /resources/glossary#immediate-dependency
[transitive-dep]: /resources/glossary#transitive-dependency
[pub]: /tools/pub/packages
[npm]: https://npmjs.org/
[bundler]: https://bundler.io
[caret-syntax]: /tools/pub/dependencies#caret-syntax
[semver]: https://semver.org/spec/v2.0.0-rc.1.html
[lockfile]: /resources/glossary#lockfile
[content hash]: /resources/glossary#pub-content-hash
[pubgrub]: https://medium.com/@nex3/pubgrub-2fb6470504f
