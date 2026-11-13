---
# title: "Announcing Dart 2.13"
title: "宣布 Dart 2.13"
# description: "New type aliases language feature, improved Dart FFI"
description: "新的类型别名语言特性，改进的 Dart FFI"
ai-translated: true
publishDate: 2021-05-19
author: mit-mit
image: images/1qMQKtkRNuvBjORjoJrN2bQ.webp
category: releases
layout: blog
---


<DashImage src="images/1qMQKtkRNuvBjORjoJrN2bQ.webp" alt="Dart 2.13 release banner highlighting type aliases, faster FFI, null safety, and Docker support." />


*By Kevin Moore & Michael Thomsen*

*作者：Kevin Moore 与 Michael Thomsen*

Today we’re announcing Dart 2.13, featuring *type aliases* — currently our second most requested language feature. Dart 2.13 also includes improved Dart FFI and better performance, and we have new Docker Official Images for Dart. This post gives an update on the null safety feature introduced in 2.12, discusses the new 2.13 features, has some exciting news about Docker and Google Cloud support for Dart backends, and previews some changes that you can expect to see in future releases.

今天我们宣布 Dart 2.13 发布，带来*类型别名（type aliases）*
——目前呼声第二高的语言特性。Dart 2.13 还包含改进的 Dart FFI
和更好的性能，并且我们推出了新的 Dart Docker 官方镜像。
本文将更新 2.12 引入的空安全特性的进展，讨论 2.13 的新特性，
带来 Docker 和 Google Cloud 支持 Dart 后端的令人兴奋的消息，
并预览未来版本中你可以期待的一些变化。

## Null safety update

## 空安全进展

We launched [sound null safety](https://dart.dev/null-safety) in March in the [Dart 2.12](/blog/announcing-dart-2-12) release. Null safety is Dart’s latest major productivity feature, intended to help you avoid null errors — a class of bugs that are often hard to spot. With that launch we encouraged package publishers to start migrating shared packages on pub.dev to null safety.

我们在三月的 [Dart 2.12](/blog/announcing-dart-2-12) 版本中发布了
[健全空安全（sound null safety）](https://dart.dev/null-safety)。
空安全（null safety）是 Dart 最新的重大生产力特性，
旨在帮助你避免 null 错误——这类 bug 往往很难被发现。
发布时我们鼓励 package 发布者开始把 pub.dev 上的共享 package
迁移到空安全。

We’ve been extremely pleased to see how quickly null safety has been adopted! Just a few months after launch, **93% of the top-500 most popular packages on pub.dev already support null safety**. We’d like to extend our sincere thanks to all package developers for doing this work so quickly, and for helping the entire ecosystem to move forward!

我们非常高兴看到空安全被如此迅速地采用！发布仅几个月后，
**pub.dev 上最流行的前 500 个 package 中已有 93% 支持空安全**。
我们要向所有 package 开发者致以诚挚的感谢，
感谢你们如此迅速地完成这项工作，帮助整个生态向前迈进！

With so many packages supporting null safety, there’s a good chance that you can begin to migrate your apps to use null safety. The first step is to use `dart pub outdated` to check your app’s dependencies. For details, see the [null safety migration guide](https://dart.dev/null-safety/migration-guide#step1-wait). We’ve also changed our `dart create` and `flutter create` templates so that they now enable null safety by default in new apps and packages.

有这么多 package 支持空安全，你很可能已经可以开始
把自己的应用迁移到空安全了。第一步是用 `dart pub outdated`
检查应用的依赖。详情参见
[空安全迁移指南](https://dart.dev/null-safety/migration-guide#step1-wait)。
我们还修改了 `dart create` 和 `flutter create` 模板，
现在新建的应用和 package 会默认启用空安全。

## Announcing type aliases

## 宣布类型别名

Type aliases is a new feature in the 2.13 language. It extends our earlier support, which allowed for creating type aliases of function types, but not any other types. This highly sought-after feature was the second highest [rated](https://github.com/dart-lang/language/issues?q=is%3Aissue+is%3Aopen+sort%3Areactions-%2B1-desc) in the language issue tracker.

类型别名是 2.13 语言的新特性。它扩展了我们此前的支持
——此前只能为函数类型创建类型别名，不能用于其他类型。
这个备受期待的特性在语言 issue 跟踪器中
[投票数](https://github.com/dart-lang/language/issues?q=is%3Aissue+is%3Aopen+sort%3Areactions-%2B1-desc)排名第二。

Using a type alias you can create a new name for any existing type, which can then be used anywhere the original type could be used. You aren’t really defining a new type, just introducing a short-hand alias. The alias even passes type equality tests:

用类型别名，你可以为任何现有类型创建一个新名字，
之后在任何能使用原类型的地方都能使用它。
你并不是真的定义了一个新类型，只是引入了一个简写别名。
别名甚至能通过类型相等性测试：

```
typedef Integer = int;

void main() {
  print(int == Integer); // true
}
```


So what can you use type aliases for? One common use is to give a shorter or more descriptive name to a type, making your code more readable and maintainable.

那么类型别名能用来做什么？一个常见用途是给类型起一个
更短或更有描述性的名字，让代码更易读、更易维护。

A good example is working with JSON (thanks to GitHub user [Levi-Lesches](https://github.com/Levi-Lesches) for this example). Here we can define a new type alias `Json`, which describes a JSON document as a map from `String` keys to any value (using the `dynamic` type). Then we can use that `Json` type alias when defining our `fromJson` named constructor and `json` getter.

一个很好的例子是处理 JSON（感谢 GitHub 用户
[Levi-Lesches](https://github.com/Levi-Lesches) 提供这个例子）。
这里我们定义一个新的类型别名 `Json`，把 JSON 文档描述为
从 `String` 键到任意值（使用 `dynamic` 类型）的映射。
然后就可以在定义 `fromJson` 命名构造函数和 `json` getter 时
使用这个 `Json` 类型别名。

```
typedef Json = Map<String, dynamic>;

class User {
  final String name;
  final int age;

  User.fromJson(Json json) :
    name = json['name'],
    age = json['age'];

Json get json => {
    'name': name,
    'age': age,
  };
}
```


You can also call constructors on a type alias that names a class, so the following is perfectly legal:

你还可以对指向类的类型别名调用构造函数，
所以下面的写法完全合法：

```
main() {
  var j = Json();
  j['name'] = 'Michael';
}
```


By using type aliases to give names to complex types, you can make it easier for readers to understand the invariants of your code. For example, the following code defines a type alias to describe maps that contain keys of generic type `X` and values of type `List&lt;X&gt;`. By giving the type a name with a single type parameter, the regular structure of the map becomes more apparent to the reader of the code.

用类型别名给复杂类型命名，可以让读者更容易理解代码的不变量。
例如，下面的代码定义了一个类型别名，描述键为泛型类型 `X`、
值为 `List&lt;X&gt;` 类型的映射。通过给这个带单个类型参数的类型
起名字，映射的规则结构对代码读者来说更加一目了然。

```
typedef MapToList<X> = Map<X, List<X>>;
void main() {
  MapToList<int> m = {};
  m[7] = [7]; // OK
  m[8] = [2, 2, 2]; // OK
  for (var x in m.keys) {
    print('$x --> ${m[x]}');
  }
}

=>

7 --> [7]
8 --> [2, 2, 2]
```


If you try to use types that don’t match, you’ll get an analysis error:

如果你尝试使用不匹配的类型，会得到一个分析错误：

```
m[42] = ['The', 'meaning', 'of', 'life'];

=>

The element type 'String' can't be assigned to the list type 'int'.
```


You can even use type aliases when renaming classes in public libraries. Imagine you have an existing class `PoorlyNamedClass` in a public library that you want to rename to `BetterNamedClass`. If you simply rename the class, then your API customers will get sudden compilation errors. With type aliases you can go ahead and do the rename, but then define a new type alias for the old class name, and then add a `@Deprecated` annotation for the old name. Uses of `PoorlyNamedClass` will then cause a warning when used, but will continue to compile and work as before, giving users time to upgrade their code.

你甚至可以在公共库中重命名类时使用类型别名。
假设公共库里有个现有的类 `PoorlyNamedClass`，
你想把它改名为 `BetterNamedClass`。如果直接重命名，
你的 API 用户会突然遇到编译错误。有了类型别名，
你可以直接重命名，然后为旧类名定义一个新的类型别名，
再给旧名字加上 `@Deprecated` 注解。这样使用 `PoorlyNamedClass`
时会产生警告，但仍能像以前一样编译和工作，
给用户留出升级代码的时间。

Here’s how you might implement `BetterNamedClass` and deprecate `PoorlyNamedClass` (in a file named `mylibrary.dart`):

下面是实现 `BetterNamedClass` 并弃用 `PoorlyNamedClass`
的一种写法（在名为 `mylibrary.dart` 的文件中）：

```
class BetterNamedClass {...}

@Deprecated('Use BetterNamedClass instead')
typedef PoorlyNamedClass = BetterNamedClass;
```


And here’s what happens what someone tries to use `PoorlyNamedClass`:

而当有人尝试使用 `PoorlyNamedClass` 时，会发生这样的事：

```
import 'mylibrary.dart';

void main() {
  PoorlyNamedClass p;
}

=>

'PoorlyNamedClass' is deprecated and shouldn't be used. Use BetterNamedClass instead.
```


The type alias feature is available starting with Dart 2.13. To enable it, set the lower Dart SDK constraint in your pubspec to at least 2.13:

类型别名特性从 Dart 2.13 开始可用。要启用它，
把 pubspec 中的 Dart SDK 下限约束设为至少 2.13：

```
environment:
  sdk: ">=2.13.0 <3.0.0"
```


This feature is backward compatible, thanks to [language versioning](https://dart.dev/language/versioning). Packages with lower SDK constraints under 2.13 can safely refer to type aliases defined in 2.13 packages, even though pre-2.13 packages can’t define their own type aliases.

得益于[语言版本控制](https://dart.dev/language/versioning)，
该特性是向后兼容的。SDK 下限约束低于 2.13 的 package
可以安全地引用 2.13 package 中定义的类型别名，
尽管 2.13 之前的 package 不能定义自己的类型别名。

## Dart 2.13 FFI changes

## Dart 2.13 的 FFI 变更

We also have a couple of new features in Dart FFI, our interop mechanism for calling C code.

Dart FFI——我们调用 C 代码的互操作机制——也有几个新特性。

First, FFI now supports structs that have inline arrays ([#35763](https://github.com/dart-lang/sdk/issues/35763)). Consider a C struct with an inline array like this:

首先，FFI 现在支持带内联数组的结构体
（[#35763](https://github.com/dart-lang/sdk/issues/35763)）。
考虑这样一个带内联数组的 C 结构体：

```
struct MyStruct {
  uint8_t arr[8];
}
```


You can now wrap that in Dart directly, specifying the element type with a type argument to `Array`:

现在你可以直接在 Dart 中包装它，
用传给 `Array` 的类型实参指定元素类型：

```
class StructInlineArray extends Struct {
  [@Array](http://twitter.com/Array)(8)
  external Array<Uint8> arr;
}
```


Second, FFI now supports packed structs ([#38158](https://github.com/dart-lang/sdk/issues/38158)). Normally structs are laid out in memory so that members fall in address boundaries that are easier to access for the CPU. With [packed structs](http://www.catb.org/esr/structure-packing/) some of this padding is omitted to lower overall memory consumption, often in platform-specific ways. With the new `@Packed(&lt;alignment&gt;)` annotation, you can easily specify the padding. For example, the following code creates a struct that has 4-byte alignment when it’s in memory:

其次，FFI 现在支持紧凑结构体（packed structs）
（[#38158](https://github.com/dart-lang/sdk/issues/38158)）。
通常结构体在内存中的布局会让成员落在便于 CPU 访问的地址边界上。
使用[紧凑结构体](http://www.catb.org/esr/structure-packing/)
可以省略部分填充（padding），降低整体内存占用，
这通常是平台相关的方式。借助新的 `@Packed(&lt;alignment&gt;)` 注解，
你可以轻松指定填充。例如，下面的代码创建了一个
在内存中按 4 字节对齐的结构体：

```
[@Packed](http://twitter.com/Packed)(4)
class TASKDIALOGCONFIG extends Struct {
  [@Uint32](http://twitter.com/Uint32)()
  external int cbSize;
  [@IntPtr](http://twitter.com/IntPtr)()
  external int hwndParent;
  [@IntPtr](http://twitter.com/IntPtr)()
  external int hInstance;
  [@Uint32](http://twitter.com/Uint32)()
  external int dwFlags;
  ...
}
```


## Dart 2.13 performance changes

## Dart 2.13 的性能变更

We’re continuing to work on reducing the application size and memory footprint of Dart code. In large Flutter applications, internal structures representing metadata of an AOT-compiled Dart program might occupy a sizable chunk of memory. Most of this metadata is present to enable features like hot reload, interactive debugging, and formatting of human-readable stack traces — features that are never used in deployed applications. Over the previous year we’ve been restructuring the Dart native runtime to eliminate as much of this overhead as possible. Some of these improvements apply to all Flutter applications built in release mode, but some require you to forgo human-readable stack traces by splitting debug information out of AOT-compiled applications using the [`--split-debug-info`](https://flutter.dev/docs/perf/app-size#reducing-app-size) flag.

我们持续致力于减小 Dart 代码的应用体积和内存占用。
在大型 Flutter 应用中，表示 AOT 编译的 Dart 程序元数据的
内部结构可能占用相当大的一块内存。这些元数据大多是为了支持
热重载、交互式调试和人类可读的堆栈跟踪格式化等特性
——而这些特性在已部署的应用中从不会用到。过去一年，
我们一直在重构 Dart 原生运行时，尽可能消除这些开销。
其中一些改进适用于所有以 release 模式构建的 Flutter 应用，
但另一些需要你放弃人类可读的堆栈跟踪：使用
[`--split-debug-info`](https://flutter.dev/docs/perf/app-size#reducing-app-size)
标志把调试信息从 AOT 编译的应用中拆分出去。

Dart 2.13 includes a number of changes that significantly reduce the space occupied by program metadata when `--split-debug-info` is used. Take as an example the Flutter Gallery app. On Android the release APK is 112.4 MB with debug information, and 106.7 MB without it (a 5% overall reduction). This APK contains a lot of assets. Looking just at the code metadata inside the APK, it was reduced from 5.7MB in Dart 2.12 and only 3.7MB in Dart 2.13 (a 35% reduction).

Dart 2.13 包含多项变更，在使用 `--split-debug-info` 时
显著减少程序元数据占用的空间。以 Flutter Gallery 应用为例：
在 Android 上，带调试信息的 release APK 为 112.4 MB，
不带则为 106.7 MB（整体缩减 5%）。这个 APK 包含大量资源文件。
只看 APK 内的代码元数据，它从 Dart 2.12 的 5.7MB
降到了 Dart 2.13 的仅 3.7MB（缩减 35%）。

If app size and memory footprint are important to you, consider omitting the debug information using the `--split-debug-info` flag. Note that when doing so you’ll need to use the [`symbolize`](https://flutter.dev/docs/deployment/obfuscate#reading-an-obfuscated-stack-trace) command to make the stack traces human readable again.

如果应用体积和内存占用对你很重要，
可以考虑用 `--split-debug-info` 标志省略调试信息。
注意这样做之后，你需要用
[`symbolize`](https://flutter.dev/docs/deployment/obfuscate#reading-an-obfuscated-stack-trace)
命令把堆栈跟踪恢复为人类可读的形式。

## Official Docker support and Dart on Google Cloud

## 官方 Docker 支持与 Google Cloud 上的 Dart

Dart is now available as [Docker Official Images](https://docs.docker.com/docker-hub/official_images/). While Dart has provided Docker images for years, these [new Dart images](https://hub.docker.com/_/dart) are tested and validated by Docker to follow best practices. They also support ahead-of-time (AOT) compilation, which can dramatically reduce the size of built containers and can improve the speed of deployment in container environments — like [Cloud Run](https://cloud.google.com/run).

Dart 现在以 [Docker 官方镜像](https://docs.docker.com/docker-hub/official_images/)
的形式提供。虽然 Dart 多年来一直提供 Docker 镜像，
但这些[新的 Dart 镜像](https://hub.docker.com/_/dart)
经过 Docker 的测试和验证，遵循最佳实践。
它们还支持提前编译（AOT），可以大幅减小构建出的容器体积，
并提升在容器环境（如 [Cloud Run](https://cloud.google.com/run)）
中的部署速度。

While Dart remains focused on enabling app frameworks like Flutter to drive beautiful pixels across every screen, we realize that behind most user experiences is at least one hosted service. By making it easy to build backend services with Dart, we support a full stack experience that lets developers extend their application to the cloud using the same language and business logic they use to power widgets on the frontend.

虽然 Dart 仍专注于让 Flutter 等应用框架在每块屏幕上
呈现精美的像素，但我们意识到大多数用户体验背后
至少有一个托管服务。通过让 Dart 轻松构建后端服务，
我们支持全栈体验：开发者可以用驱动前端 widget 的
同一门语言和同一套业务逻辑，把应用扩展到云端。

In general, using Dart for Flutter app backends is an especially good fit for the simplicity and scalability of Google’s managed serverless platform, Cloud Run. This includes scale-to-zero, which means you don’t incur costs when your backend isn’t handling any requests. We work with the Google Cloud team to provide the [Functions Framework for Dart](https://pub.dev/packages/functions_framework), a collection of packages, tools, and examples that make it easy to write Dart functions to deploy instead of full servers for handling HTTP requests and CloudEvents.

总的来说，用 Dart 做 Flutter 应用后端，特别适合
Google 托管的 serverless 平台 Cloud Run 的简单性与可扩展性。
这包括缩容到零（scale-to-zero）：后端不处理任何请求时
不会产生费用。我们与 Google Cloud 团队合作提供了
[Dart 版 Functions Framework](https://pub.dev/packages/functions_framework)
——一组 package、工具和示例，让你轻松编写可部署的 Dart 函数
来处理 HTTP 请求和 CloudEvents，而不必编写完整的服务器。

Check out our [Google Cloud docs](https://dart.dev/server/google-cloud) to get started.

查看我们的 [Google Cloud 文档](https://dart.dev/server/google-cloud)
即可开始。

## A few words about what’s next

## 关于下一步的几句话

We’re already working on some exciting changes for upcoming releases. As always, you can use the [language funnel](https://github.com/dart-lang/language/projects/1) tracker to keep an eye on our progress.

我们已经在为接下来的版本开发一些令人兴奋的变更。
一如既往，你可以用
[语言漏斗](https://github.com/dart-lang/language/projects/1)
跟踪器关注我们的进展。

One area we’re working on is a new set of canonical lints for both Dart and Flutter. Lints are a powerful way to configure Dart [static analysis](https://dart.dev/guides/language/analysis-options), but with hundreds of possible lints to toggle on or off, it can be hard to decide on what to choose. We’re currently working on defining two canonical sets of lints that we’ll apply by default in Dart and Flutter projects. We expect this to be enabled by default in the next stable release. If you’d like a preview, checkout the two packages [lints](https://pub.dev/packages/lints) and [flutter_lints](https://pub.dev/packages/flutter_lints).

我们正在做的一个方向，是为 Dart 和 Flutter 提供
一套新的规范 lint。lint 是配置 Dart
[静态分析](https://dart.dev/guides/language/analysis-options)
的强大方式，但有数百个 lint 可以开关，很难决定选哪些。
我们目前正在定义两套规范 lint 集合，
将默认应用于 Dart 和 Flutter 项目。
我们预计下一个稳定版本会默认启用。
如果想先睹为快，可以看看这两个 package：
[lints](https://pub.dev/packages/lints) 和
[flutter_lints](https://pub.dev/packages/flutter_lints)。

Finally, if you do deep embedding of the Dart VM runtime, please note that we’re planning to deprecate the existing mechanism for this. We’ll replace it with a faster, more flexible model based on Dart FFI (see tracking issue [#45451](https://github.com/dart-lang/sdk/issues/45451)).

最后，如果你对 Dart VM 运行时做深度嵌入，
请注意我们计划弃用现有机制。我们会用一个基于 Dart FFI 的
更快、更灵活的模型来替代它（见跟踪 issue
[#45451](https://github.com/dart-lang/sdk/issues/45451)）。

## Dart 2.13 is available now

## Dart 2.13 现已可用

Dart 2.13, with type aliases and improved FFI, is available today in the [Dart 2.13](https://dart.dev/get-dart) and [Flutter 2.2](https://flutter.dev/docs/get-started/) SDKs.

带类型别名和改进 FFI 的 Dart 2.13，今天已可在
[Dart 2.13](https://dart.dev/get-dart) 和
[Flutter 2.2](https://flutter.dev/docs/get-started/) SDK 中获取。

If you’ve been waiting for your dependencies to migrate to null safety, you might want to check again, using `dart pub outdated`. With 93% of the top-500 most popular packages already migrated, there’s a good chance that you’re unblocked. We’d also like to extend a big thanks to developers who’ve already migrated!

如果你一直在等依赖迁移到空安全，不妨用 `dart pub outdated`
再检查一次。最流行的前 500 个 package 中已有 93% 完成迁移，
你很可能已经不再被阻塞。我们也要向已经完成迁移的开发者
致以衷心的感谢！

We’d love to hear about your experience with the new features and changes discussed in this blog post. Leave a comment below or tweet us [@dart_lang](https://twitter.com/dart_lang).

我们很想听听你使用本文讨论的新特性和变更的体验。
欢迎在下方留言，或在推特上联系我们
[@dart_lang](https://twitter.com/dart_lang)。
