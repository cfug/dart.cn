---
# title: "Dart 2.18: Objective-C & Swift interop"
title: "Dart 2.18：Objective-C 与 Swift 互操作"
# description: "Enhanced interoperability, platform-specific networking, improved type inference, and an important update on our null safety language…"
description: "更强的互操作性、平台专属网络、改进的类型推断，以及空安全语言路线图的重要更新……"
ai-translated: true
publishDate: 2022-08-30
author: mit-mit
image: images/0byFoNx1wnEaO0S6N.webp
category: releases
layout: blog
---


### Enhanced interoperability, platform-specific networking, improved type inference, and an important update on our null safety language roadmap

### 更强的互操作性、平台专属网络、改进的类型推断，以及空安全语言路线图的重要更新

*Dart 2.18 is available today. This release features a preview of Objective-C & Swift interoperability and a new iOS/macOS networking package built on top of this interop. It also contains improved type inference for generic functions, performance improvements to async code, new pub.dev features, and cleanup of our tools and core libraries.*

*Dart 2.18 今天正式发布。这个版本带来了 Objective-C 与 Swift
互操作（interop）的预览版，以及一个基于该互操作能力构建的全新
iOS/macOS 网络 package。此外还包含泛型函数类型推断的改进、
异步代码的性能提升、pub.dev 的新功能，以及工具和核心库的清理。*

*Finally, we have the latest null safety migration status numbers and an important roadmap update on our path towards a fully null safe Dart. Please read to the end!*

*最后，我们还带来了最新的空安全（null safety）迁移状态数据，
以及迈向完全空安全 Dart 之路上的重要路线图更新。请一定读到最后！*

<DashImage src="images/0byFoNx1wnEaO0S6N.webp" alt="Dart 2.18 release banner highlighting Objective-C and Swift interop, platform-specific HTTP, and the roadmap." />


## Introducing Dart to Objective-C & Swift interop

## Dart 与 Objective-C、Swift 互操作简介

We previewed the Dart foreign function interface (FFI) for calling native C APIs in 2020 and released it in Dart 2.12 in March 2021. Since that release, a large selection of packages have taken advantage of this feature to integrate with existing native C APIs. A few examples include [`file_picker`](https://pub.dev/packages/file_picker), [`printing`](https://pub.dev/packages/printing), [`win32`](https://pub.dev/packages/win32), [`objectbox`](https://pub.dev/packages/objectbox), [`realm`](https://pub.dev/packages/realm), [`isar`](https://pub.dev/packages/isar), [`tflite_flutter`](https://pub.dev/packages/tflite_flutter), and [`dbus`](https://pub.dev/packages/dbus).

我们在 2020 年预览了用于调用原生 C API 的 Dart
外部函数接口（FFI），并在 2021 年 3 月的 Dart 2.12 中正式发布。
自那以后，大量 package 利用这一特性与现有的原生 C API 集成。
一些例子包括 [`file_picker`](https://pub.dev/packages/file_picker)、
[`printing`](https://pub.dev/packages/printing)、
[`win32`](https://pub.dev/packages/win32)、
[`objectbox`](https://pub.dev/packages/objectbox)、
[`realm`](https://pub.dev/packages/realm)、
[`isar`](https://pub.dev/packages/isar)、
[`tflite_flutter`](https://pub.dev/packages/tflite_flutter)
和 [`dbus`](https://pub.dev/packages/dbus)。

The Dart team wants Dart to support interoperability with all the primary languages on the platforms where Dart runs. Dart 2.18 meets the next milestone toward that goal. Your Dart code can call Objective-C and Swift code, as typically used for APIs on the macOS and iOS platforms. Dart supports this interop mechanism in any app from the CLI app to backend code to a Flutter UI.

Dart 团队希望 Dart 能与它所运行平台上的所有主要语言互操作。
Dart 2.18 达成了这一目标路上的下一个里程碑。
你的 Dart 代码可以调用 Objective-C 和 Swift 代码，
这正是 macOS 和 iOS 平台 API 通常使用的语言。
从 CLI 应用到后端代码再到 Flutter UI，
Dart 在任何应用中都支持这种互操作机制。

This new mechanism utilizes the fact that Objective-C and Swift code can be exposed as C code based on API bindings. The Dart API wrapper generation tool, [`ffigen`](https://pub.dev/packages/ffigen), can create these bindings from API headers. Let’s take a look at an example.

这一新机制利用了这样一个事实：Objective-C 和 Swift 代码
可以基于 API 绑定（binding）以 C 代码的形式暴露出来。
Dart 的 API 包装生成工具 [`ffigen`](https://pub.dev/packages/ffigen)
可以从 API 头文件生成这些绑定。我们来看一个例子。

## Time Zone example using Objective-C

## 使用 Objective-C 的时区示例

macOS has an API for querying time zones information exposed on the [`NSTimeZone` class](https://developer.apple.com/documentation/foundation/nstimezone?language=objc]). You can query this API for the time zone and [UTC time zone offset](https://www.w3.org/International/core/2005/09/timezone.html#:~:text=What%20is%20a%20%22zone%20offset,or%20%22%2D%22%20from%20UTC.) that the user has configured for their device.

macOS 在
[`NSTimeZone` 类](https://developer.apple.com/documentation/foundation/nstimezone?language=objc])
上暴露了查询时区信息的 API。
你可以用这个 API 查询用户为设备配置的时区，以及
[UTC 时区偏移](https://www.w3.org/International/core/2005/09/timezone.html#:~:text=What%20is%20a%20%22zone%20offset,or%20%22%2D%22%20from%20UTC.)。

The following example Objective-C app uses this timezone API to get the system time zone and the GMT offset:

下面这个 Objective-C 示例应用使用时区 API 获取系统时区和 GMT 偏移：

```objective-c
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSTimeZone *timezone = [NSTimeZone systemTimeZone]; // Get current time zone.
        NSLog(@"Timezone name: %@", timezone.name);
        NSLog(@"Timezone offset GMT: %ld hours", timezone.secondsFromGMT/60/60);
    }
    return 0;
}
```

The app imports `Foundation.h`, which contains the API headers for the Apple Foundation library. Next, inside the `main` method, it calls the `systemTimeZone` method from the `NSTimeZone` class. This method returns an `NSTimeZone` instance with the selected time zone on the device. Finally, the app outputs two lines to the console containing the name of the time zone and the UTC offset in hours.

这个应用导入了 `Foundation.h`，其中包含 Apple Foundation 库的
API 头文件。接着，在 `main` 方法里，它调用 `NSTimeZone` 类的
`systemTimeZone` 方法。该方法返回一个 `NSTimeZone` 实例，
对应用户设备上选择的时区。最后，应用向控制台输出两行内容：
时区名称和以小时为单位的 UTC 偏移。

If you run this app, it should return something resembling the following, depending on your location:

运行这个应用，根据你所在的位置，应该会返回类似下面的结果：

```
Timezone name: Europe/Copenhagen
Timezone offset GMT: 2 hours
```


## Time Zone example using Using Dart

## 使用 Dart 的时区示例

Let’s replicate this result with Dart using the new Objective-C interop.

我们用新的 Objective-C 互操作能力，在 Dart 中重现这个结果。

First create a new Dart CLI app:

首先创建一个新的 Dart CLI 应用：

```
$ dart create timezones
```


Then edit your `pubspec` file to contain the `ffigen` configuration. This configuration points to the header file and lists which Objective-C interfaces should generate wrappers:

然后编辑你的 `pubspec` 文件，加入 `ffigen` 配置。
这份配置指向头文件，并列出需要为哪些 Objective-C 接口生成包装：

```yaml
ffigen:
  name: TimeZoneLibrary
  language: objc
  output: "foundation_bindings.dart"
  exclude-all-by-default: true
  objc-interfaces:
    include:
      - "NSTimeZone"
  headers:
    entry-points:
      - "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks/Foundation.framework/
         Headers/NSTimeZone.h"
```

This selects Objective-C bindings for the headers in `NSTimeZone.h` and includes just the APIs in the `NSTimeZone` interface. To generate the wrappers, run `ffigen`:

这会为 `NSTimeZone.h` 中的头文件选择 Objective-C 绑定，
并且只包含 `NSTimeZone` 接口中的 API。运行 `ffigen` 生成包装：

```
$ dart run ffigen
```


This command creates a new file, `foundation_bindings.dart`, that contains a bunch of generated API bindings. Using this binding file, we can write our Dart `main` method. This method mirrors the Objective-C code:

这条命令会创建一个新文件 `foundation_bindings.dart`，
其中包含大量生成的 API 绑定。有了这个绑定文件，
我们就可以编写 Dart 的 `main` 方法了。
这个方法与 Objective-C 代码一一对应：

```dart
void main(List<String> args) async {
  const dylibPath =
      '/System/Library/Frameworks/Foundation.framework/Versions/Current/Foundation';
  final lib = TimeZoneLibrary(DynamicLibrary.open(dylibPath));

  final timeZone = NSTimeZone.getLocalTimeZone(lib);
  if (timeZone != null) {
    print('Timezone name: ${timeZone.name}');
    print('Offset from GMT: ${timeZone.secondsFromGMT / 60 / 60} hours');
  }
}
```

That’s it! This new support is available in an experimental state starting with today’s Dart 2.18. This boosts Dart’s general interop support to call macOS and iOS APIs directly. This, in turn, supplements Flutter’s plugins, with new support that works in any Dart app, and that allows you to call macOS and iOS APIs directly from Dart code.

就是这样！从今天发布的 Dart 2.18 开始，
这项新支持以实验状态提供。它增强了 Dart 的通用互操作能力，
让 Dart 可以直接调用 macOS 和 iOS API。
这反过来又补充了 Flutter 的插件体系：
新的支持适用于任何 Dart 应用，
让你可以直接在 Dart 代码中调用 macOS 和 iOS API。

We welcome your feedback. Let us know what worked, what might be changed, or what problems you experienced by commenting in the [feedback issue](https://github.com/dart-lang/sdk/issues/49673) on GitHub. To learn more about this interoperability, see the [Objective-C and Swift interoperability guide](https://dart.dev/guides/libraries/objective-c-interop).

我们欢迎你的反馈。请在 GitHub 的
[反馈 issue](https://github.com/dart-lang/sdk/issues/49673)
中留言，告诉我们哪些地方好用、哪些可以改进，或者你遇到了什么问题。
想进一步了解这种互操作，请参阅
[Objective-C 与 Swift 互操作指南](https://dart.dev/guides/libraries/objective-c-interop)。

## Platform-specific http libraries

## 平台专属的 http 库

Dart includes a general, multi-platform `http` library. This library allows you to write code without concern for platform specifics. On occasion, you might want to write code specific to a particular host platform’s networking APIs.

Dart 自带一个通用的多平台 `http` 库。
这个库让你编写代码时无需关心平台细节。
但有时你可能想针对某个宿主平台的网络 API 编写专属代码。

For example, Apple’s networking library [`NSURLSession`](https://developer.apple.com/documentation/foundation/nsurlsession) allows specifying WiFi-only networking or that it requires a VPN. To support these use cases, we’ve created a new networking package intended for the macOS and iOS platforms, [`cupertino_http`](https://pub.dev/packages/cupertino_http). This builds on the new Objective-C interop mentioned in the previous section. It uses a large set of API wrappers [generated](https://github.com/dart-lang/http/blob/master/pkgs/cupertino_http/ffigen.yaml) from Apple’s networking APIs in Foundation.

例如，Apple 的网络库
[`NSURLSession`](https://developer.apple.com/documentation/foundation/nsurlsession)
允许指定仅通过 WiFi 联网，或要求必须使用 VPN。
为支持这些用例，我们创建了面向 macOS 和 iOS 平台的全新网络 package
[`cupertino_http`](https://pub.dev/packages/cupertino_http)。
它构建在上一节提到的新 Objective-C 互操作之上，
使用了一大组从 Foundation 中 Apple 网络 API
[生成](https://github.com/dart-lang/http/blob/master/pkgs/cupertino_http/ffigen.yaml)
的 API 包装。

## Cupertino http library example

## Cupertino http 库示例

The following example sets a Flutter app’s http client to use the `cupertino_http` library on macOS and iOS and Dart’s regular http library from `dart:io` on other platforms:

下面的示例把 Flutter 应用的 http 客户端设置为：
在 macOS 和 iOS 上使用 `cupertino_http` 库，
在其他平台上使用来自 `dart:io` 的 Dart 常规 http 库：

```dart
late Client client;
if (Platform.isIOS || Platform.isMacOS) {
  final config = URLSessionConfiguration.ephemeralSessionConfiguration()
    ..allowsCellularAccess = false
    ..allowsExpensiveNetworkAccess = false;
  client = CupertinoClient.fromSessionConfiguration(config);
} else {
  client = Client(); // Uses an HTTP client based on dart:io
}
```

After this initial configuration, the app makes any subsequent networking calls on the specific client. For example, an http `get()` request now resembles this:

完成这个初始配置后，应用后续的所有网络调用都走这个特定的客户端。
例如，一个 http `get()` 请求现在看起来是这样的：

```dart
final response = await get(
  Uri.https(
    'www.googleapis.com',
    '/books/v1/volumes',
    {'q': 'HTTP', 'maxResults': '40', 'printType': 'books'},
  ),
);
```

When you cannot use the common client interface, you can call Apple’s networking APIs directly using the `cupertino_http` library:

当你无法使用通用客户端接口时，
可以通过 `cupertino_http` 库直接调用 Apple 的网络 API：

```dart
final session = URLSession.sessionWithConfiguration(
    URLSessionConfiguration.backgroundSession('com.example.bgdownload'),
    onFinishedDownloading: (s, t, fileUri) {
      actualContent = File.fromUri(fileUri).readAsStringSync();
    });

final task = session.downloadTaskWithRequest(
    URLRequest.fromUrl(Uri.https(...))
    ..resume();
```

## Platform-specific networking in multi-platform apps

## 多平台应用中的平台专属网络

As we designed this feature, the goal remained to keep apps as multi-platform as possible. To meet this goal, we kept our general multi-platform `http` API set for basic http operations, and allowed for configuring per-platform which networking library to use. You can minimize the amount of platform-specific code that you need to write by using the [`package:http` Client API](https://pub.dev/documentation/http/latest/http/Client-class.html). This API can be configured per-platform but used in a platform-independent manner.

在设计这个特性时，我们的目标始终是让应用尽可能保持多平台。
为达成这一目标，我们保留了用于基本 http 操作的通用多平台 `http` API 集，
同时允许按平台配置使用哪个网络库。
通过使用 [`package:http` Client API](https://pub.dev/documentation/http/latest/http/Client-class.html)，
你可以把需要编写的平台专属代码降到最低。
这套 API 可以按平台配置，却以平台无关的方式使用。

Dart 2.18 offers experimental support of two platform-specific http libraries that support the `package:http` [Client API](https://pub.dev/documentation/http/latest/http/Client-class.html):

Dart 2.18 以实验状态提供两个平台专属 http 库，
它们都支持 `package:http` 的
[Client API](https://pub.dev/documentation/http/latest/http/Client-class.html)：

* [`cupertino_http`](https://pub.dev/packages/cupertino_http) based on [`NSURLSession`](https://developer.apple.com/documentation/foundation/nsurlsession) for macOS/iOS.

  基于 [`NSURLSession`](https://developer.apple.com/documentation/foundation/nsurlsession)
  的 [`cupertino_http`](https://pub.dev/packages/cupertino_http)，
  面向 macOS/iOS。

* [`cronet_http`](https://pub.dev/packages/cronet_http) based on [Cronet](https://developer.android.com/guide/topics/connectivity/cronet), the networking library popular on Android.

  基于 [Cronet](https://developer.android.com/guide/topics/connectivity/cronet)
  的 [`cronet_http`](https://pub.dev/packages/cronet_http)，
  Cronet 是 Android 上流行的网络库。

Combining a common client API with several HTTP implementations gives you the best of both worlds. You can get platform-specific behavior while still maintaining your apps from a single set of shared sources for all your platforms. We’d love to hear your feedback on this [GitHub issue](https://github.com/dart-lang/http/issues/764).

把通用客户端 API 与多个 HTTP 实现结合起来，让你鱼与熊掌兼得。
你既能获得平台专属的行为，又能用一套共享源码维护所有平台的应用。
欢迎在这个 [GitHub issue](https://github.com/dart-lang/http/issues/764)
中告诉我们你的反馈。

## Improved type inference

## 改进的类型推断

Dart uses many generic functions. Consider the [`fold`](https://api.dart.dev/stable/2.17.6/dart-core/Iterable/fold.html) method, which reduces a collection of elements to a single value. The following example calculates the sum of a list of integers:

Dart 中有许多泛型函数。以
[`fold`](https://api.dart.dev/stable/2.17.6/dart-core/Iterable/fold.html)
方法为例，它把一组元素归约为单个值。
下面的示例计算一个整数列表的和：

```dart
List<int> numbers = [1, 2, 3];
final sum = numbers.fold(0, (x, y) => x + y);
print('The sum of $numbers is $sum');
```


With Dart 2.17 or earlier, this method returns a type error:

在 Dart 2.17 及更早版本中，这段代码会报类型错误：

```
line 2 • The operator '+' can't be unconditionally invoked 
         because the receiver can be 'null'.
```


Dart’s type inference couldn’t flow information between the arguments. This resulted in uncertainty of the type of `x`. To remedy the potential error, you needed to specify the type:

Dart 的类型推断（type inference）此前无法在参数之间传递信息，
导致 `x` 的类型不确定。为避免这个潜在错误，你需要显式指定类型：

```dart
final sum = numbers.fold(0, (int x, int y) => x + y);
```


Dart 2.18 improves type inference. The previous example passes static analysis and can infer that both x and y are non-nullable ints. This change allows you to write more concise Dart code while retaining the full soundness properties of the strongly inferred types.

Dart 2.18 改进了类型推断。前面的示例现在可以通过静态分析，
并能推断出 x 和 y 都是非空 int。
这一变化让你写出更简洁的 Dart 代码，
同时保留强类型推断的全部健全性（soundness）保证。

## Async performance improvements

## 异步性能改进

This version of Dart improves how the Dart VM applies the `async` method and the `async*`/`sync*` generator functions. This reduces code size. On two large internal Google apps, we saw a reduction of the AOT snapshot size of around 10%. We also saw a performance increase across our microbenchmarks.

这个版本的 Dart 改进了 Dart VM 实现 `async` 方法
和 `async*`/`sync*` 生成器函数的方式，从而减小了代码体积。
在 Google 内部两个大型应用上，我们观察到 AOT 快照体积缩小了约 10%。
微基准测试（microbenchmark）也普遍出现了性能提升。

These changes include additional small behavior changes; to learn more, see [the changelog](https://github.com/dart-lang/sdk/blob/master/CHANGELOG.md#dart-vm).

这些改动还包含一些小的行为变化；
了解更多请参阅[变更日志](https://github.com/dart-lang/sdk/blob/master/CHANGELOG.md#dart-vm)。

## pub.dev improvements

## pub.dev 改进

In conjunction with the 2.18 release, we’ve made two changes on the `pub.dev` package repository.

配合 2.18 的发布，我们在 `pub.dev` package 仓库上做了两项改动。

Individuals often maintain packages published on `pub.dev` in their spare time. This can be costly, both in terms of time and finances. To facilitate sponsorships we now support a new `funding` tag in the `pubspec`, which can be used by package publishers to list links to one or more ways of sponsoring the package. These links are then shown on `pub.dev` in the sidebar:

个人开发者常常利用业余时间维护发布在 `pub.dev` 上的 package，
这在时间和金钱上都可能代价不菲。为促进赞助，
我们现在支持在 `pubspec` 中使用新的 `funding` 标签，
package 发布者可以用它列出一个或多个赞助渠道的链接。
这些链接随后会显示在 `pub.dev` 的侧边栏中：

<DashImage src="images/0FteRd2cVBg3Zq7JO.webp" alt="A screenshot displaying a sponsorship link section in the sidebar on pub.dev." />


To learn more, see the [`pubspec` documentation](https://dart.dev/tools/pub/pubspec#funding).

了解更多请参阅 [`pubspec` 文档](https://dart.dev/tools/pub/pubspec#funding)。

Furthermore, we’d like to encourage a rich ecosystem of open source packages. To highlight this, the automated package scoring on `pub.dev` awards an additional 10 points for packages that use an [OSI approved license](https://opensource.org/licenses).

此外，我们希望鼓励繁荣的开源 package 生态。为此，
`pub.dev` 的自动 package 评分会为使用
[OSI 认可许可证](https://opensource.org/licenses)的 package
额外加 10 分。

## A few breaking changes

## 一些破坏性变更

Dart has a strong focus on simplicity and learnability. We’re constantly trying to keep a careful balance when adding new capabilities. One method to keep things simple is to remove historic functionality and APIs with little use or better replacements. Dart 2.18 cleans up items in this category, including a few smaller breaking changes:

Dart 非常注重简单性和易学性。在添加新能力时，
我们不断尝试保持谨慎的平衡。保持简单的一种方法，
是移除那些使用很少或已有更好替代的历史功能和 API。
Dart 2.18 清理了这一类内容，
包括几个较小的破坏性变更（breaking change）：

* We added the unified `dart` CLI developer tool back in October 2020. In 2.18, we completed the transition. This release removes the last two deprecated tools `dart2js` (use `dart compile js`) and `dartanalyzer` (use `dart analyze`).

  我们在 2020 年 10 月加入了统一的 `dart` CLI 开发者工具。
  在 2.18 中，这一过渡已经完成。本版本移除了最后两个已弃用的工具：
  `dart2js`（请改用 `dart compile js`）
  和 `dartanalyzer`（请改用 `dart analyze`）。

* With the introduction of language versioning, `pub` generates a new resolution file: `.dart_tool/package_config.json.` The previous file, `.packages`, used a format that couldn’t contain versions. We discontinued using the `.packages` file. If you have any `.packages` files, you can delete them.

  随着语言版本控制的引入，`pub` 会生成新的解析文件
  `.dart_tool/package_config.json`。之前的 `.packages` 文件
  使用的格式无法包含版本信息。我们已停止使用 `.packages` 文件。
  如果你还有 `.packages` 文件，可以直接删除。

* Mixins of classes that don’t extend `Object` can’t be used (breaking change [#48167](https://github.com/dart-lang/sdk/issues/48167)). This behavior was never intended.

  不继承 `Object` 的类的 mixin 无法再使用
  （破坏性变更 [#48167](https://github.com/dart-lang/sdk/issues/48167)）。
  这种行为从来就不是有意设计的。

* The `uri` property of `dart:io`’s `RedirectException` has been changed to nullable (breaking change [#49045](https://github.com/dart-lang/sdk/issues/49045)).

  `dart:io` 中 `RedirectException` 的 `uri` 属性改为可空
  （破坏性变更 [#49045](https://github.com/dart-lang/sdk/issues/49045)）。

* Constants in `dart:io`’s networking APIs following the SCREAMING_SNAKE convention have been removed (breaking change [#34218](https://github.com/dart-lang/sdk/issues/34218); previously deprecated). Use the corresponding lowerCamelCase constants instead.

  `dart:io` 网络 API 中遵循 SCREAMING_SNAKE 命名约定的常量已被移除
  （破坏性变更 [#34218](https://github.com/dart-lang/sdk/issues/34218)；
  此前已弃用）。请改用对应的 lowerCamelCase 常量。

* The Dart VM no longer restores the initial terminal settings upon exit. Programs that change the `Stdin` settings `lineMode` and `echoMode` are now responsible for restoring the settings upon program exit (breaking change [#45630](https://github.com/dart-lang/sdk/issues/45630)).

  Dart VM 不再在退出时恢复初始终端设置。
  修改了 `Stdin` 的 `lineMode` 和 `echoMode` 设置的程序，
  现在需要自行负责在程序退出时恢复这些设置
  （破坏性变更 [#45630](https://github.com/dart-lang/sdk/issues/45630)）。

## Null safety update

## 空安全进展

We’re very pleased to see the wide usage of null safety since its beta release in November 2020 and the [Dart 2.12](/blog/announcing-dart-2-12) release in March 2021.

自 2020 年 11 月发布 beta 版、2021 年 3 月随
[Dart 2.12](/blog/announcing-dart-2-12) 正式发布以来，
空安全得到了广泛使用，我们对此非常欣慰。

First, app developers of most all the popular packages on `pub.dev` migrated to null safety. Analysis shows that 100% of the top-250 and 98% of the top-1,000 most used packages support null safety.

首先，`pub.dev` 上几乎所有流行 package 的应用开发者都迁移到了空安全。
分析显示，使用量前 250 的 package 中 100%、
前 1000 的 package 中 98% 都已支持空安全。

Second, most app developers work in codebases with full null safety migration. This is crucial. Dart’s full [sound null safety](https://dart.dev/null-safety/understanding-null-safety) doesn’t kick in until you migrate all code and all dependencies (including transitive). We’re tracking this via telemetry from `flutter run` commands.

其次，大多数应用开发者工作在已完成全面空安全迁移的代码库中。
这一点至关重要。只有当你迁移了所有代码和所有依赖（包括传递依赖）之后，
Dart 完整的[健全空安全](https://dart.dev/null-safety/understanding-null-safety)
才会生效。我们通过 `flutter run` 命令的遥测数据跟踪这一进展。

The following graph shows the unsound vs. sound null safety executions of `flutter run`. Before the introduction of null safety, there were none of either. A rapid growth of unsound null safety followed. As apps started migrating to null safety, the developers made a partial migration. Some parts still needed to be migrated. Over time, we see a very healthy growth of sound null safety sessions. By the end of last month, there were four times more sound null safety sessions compared to unsound ones. We hope that, over the next few quarters, we’ll see the sound null safety approach 100%!

下图展示了 `flutter run` 以不健全（unsound）与健全（sound）
空安全方式执行的对比。在空安全推出之前，两者都不存在。
随后不健全空安全快速增长。当应用开始向空安全迁移时，
开发者往往只完成了部分迁移，仍有一些部分有待迁移。
随着时间推移，我们看到健全空安全会话非常健康地增长。
到上个月底，健全空安全会话已是不健全会话的四倍。
我们希望在接下来的几个季度里，看到健全空安全趋近 100%！

<DashImage src="images/0emVp4pmfOhLhiBJ4.webp" alt="A chart demonstrating the growth of sound null safety executions versus unsound ones over time." />


## An important null safety roadmap update

## 空安全路线图的重要更新

Supporting both unsound and sound null safety adds overhead and complexity.

同时支持不健全与健全空安全带来了额外的开销和复杂性。

First, Dart developers need to learn and understand both modes. Whenever reading a piece of Dart code, check the [language version](https://dart.dev/language/versioning) to see if types are non-null by default (Dart 2.12 and later) or nullable by default (Dart 2.11 and earlier).

首先，Dart 开发者需要学习并理解两种模式。
每当阅读一段 Dart 代码时，都要查看
[语言版本](https://dart.dev/language/versioning)，
确认类型是默认非空（Dart 2.12 及之后）
还是默认可空（Dart 2.11 及更早）。

Second, supporting both modes in our compilers and runtimes slows down evolving the Dart SDK to support new features.

其次，在编译器和运行时中同时支持两种模式，
拖慢了 Dart SDK 支持新特性的演进速度。

***Based on the overhead of unsound null safety and the very positive adoption numbers mentioned in the previous section, it’s our aim to transition to only supporting sound null safety and discontinue non-null safety and unsound null safety modes. We’ve tentatively slated this for release by mid-2023.***

***基于不健全空安全带来的开销，以及上一节提到的非常积极的采用数据，
我们的目标是过渡到只支持健全空安全，
并停止支持非空安全和不健全空安全模式。
我们暂定于 2023 年年中发布这一变更。***

This would mean that discontinuing support for Dart 2.11 and earlier. Pubspec files with an SDK constraint having a lower bound of less than 2.12 would no longer resolve in Dart 3 and later. In source code containing language markers, those would fail if set to less than 2.12 (such as`// @dart=2.9`).

这意味着停止支持 Dart 2.11 及更早版本。
SDK 约束下限低于 2.12 的 pubspec 文件，
在 Dart 3 及之后将无法完成解析。
源代码中如果包含语言版本标记，设置为低于 2.12 的值
（例如 `// @dart=2.9`）也会失败。

If you’ve migrated to sound null safety, your code will work with full null safety in Dart 3. If you haven’t, please migrate now! To learn more about these changes, see [this GitHub issue](https://github.com/dart-lang/sdk/issues/49530).

如果你已经迁移到健全空安全，
你的代码在 Dart 3 中将以完全空安全的方式运行。
如果还没有，请现在就迁移！想了解这些变更的更多信息，
请参阅[这个 GitHub issue](https://github.com/dart-lang/sdk/issues/49530)。

## Summary

## 总结

The new support for interop, networking, type inference, and `pub.dev` is available today. To get started, you can directly download the [Dart 2.18 release](https://dart.dev/get-dart), or get it embedded as part of today’s [Flutter 3.3]({{site.flutter-blog}}/announcing-flutter-3-3-at-flutter-vikings) SDK release.

互操作、网络、类型推断和 `pub.dev` 的新支持今天即可使用。
要开始体验，你可以直接下载
[Dart 2.18 发行版](https://dart.dev/get-dart)，
或者获取今天发布的
[Flutter 3.3]({{site.flutter-blog}}/announcing-flutter-3-3-at-flutter-vikings)
SDK，其中已内嵌 Dart 2.18。
