---
# title: "Making a Dart web app offline-capable: 3 lines of code"
title: "让 Dart Web 应用支持离线：只需 3 行代码"
# description: "Have you ever tried to load a web application (maybe a game or a measurement converter) and couldn’t use it because the network was down…"
description: "你有没有试过打开一个 Web 应用（也许是游戏或单位换算器），却因为断网而无法使用……"
ai-translated: true
publishDate: 2017-03-28
author: isoos
image: images/1GsjtYvVghuA63qhhRdyfPQ.webp
category: other
layout: blog
---


Have you ever tried to load a web application (maybe a game or a measurement converter) and couldn’t use it because the network was down? That’s an awful experience, but luckily we have the technology to make such apps available for our users.

你有没有试过打开一个 Web 应用（也许是游戏或单位换算器），
却因为断网而无法使用？那是很糟糕的体验，
但幸运的是，我们有技术让这类应用随时可供用户使用。

For most apps and games, this can be done with 3 lines of Dart code and 1 command in the terminal. In this short article I’ll guide you through the steps, and make sure that you can always play [Pop, Pop, Win!](https://isoos.github.io/offline_pop_pop_win/)

对大多数应用和游戏来说，只需 3 行 Dart 代码
和 1 条终端命令就能做到。在这篇短文里，
我会带你走完这些步骤，确保你随时都能玩
[Pop, Pop, Win!](https://isoos.github.io/offline_pop_pop_win/)。

<DashImage src="images/1GsjtYvVghuA63qhhRdyfPQ.webp" alt="Pop, Pop, Win! game board with numbered tiles, balloons, five bombs left, and a 24.5 second timer." caption="[Pop, Pop, Win!](https://dart-lang.github.io/sample-pop_pop_win/) — a [Minesweeper implementation](https://github.com/dart-lang/sample-pop_pop_win) in Dart" />


## Service workers

## Service worker

A service worker is a JavaScript file that runs in the background. It can control the web page or the site it is associated with, intercepting and modifying navigation and resource requests, and caching resources in a very granular fashion.

service worker 是在后台运行的 JavaScript 文件。
它可以控制与之关联的网页或站点，
拦截和修改导航与资源请求，并以非常细的粒度缓存资源。

It is a non-intrusive web technology: service workers can improve the user experience if the browser [supports them](http://caniuse.com/#feat=serviceworkers), but the site can operate just fine in their absence (with the default web behavior). This is a useful property that enables **progressive web applications (PWA)**, where you can provide more advanced features to the majority of the users, while making sure that the rest aren’t locked out.

这是一种非侵入式的 Web 技术：如果浏览器
[支持 service worker](http://caniuse.com/#feat=serviceworkers)，
它能改善用户体验；没有它，站点也能正常运行
（使用默认的 Web 行为）。这个有用的特性成就了
**渐进式 Web 应用（PWA）**：你可以为大多数用户
提供更高级的功能，同时确保其余用户不会被拒之门外。

As a background processing thread, a service worker can help with:

作为后台处理线程，service worker 可以帮忙做这些事：

* offline mode (fetching resources from cache while the network is down)

  离线模式（断网时从缓存获取资源）

* caching strategies (for near-instant cached responses that can be updated later with fresh content)

  缓存策略（近乎即时的缓存响应，稍后可用新内容更新）

* push notifications (like in a mobile app)

  推送通知（就像移动应用那样）

* messaging (if the application is open on multiple tabs)

  消息传递（如果应用在多个标签页中打开）

The important feature for our offline gaming experience is this: we would like to play Pop, Pop, Win!, and not meet this dinosaur:

对我们的离线游戏体验来说，重要的特性是这个：
我们想玩 Pop, Pop, Win!，而不是遇见这只恐龙：

<DashImage src="images/1cufcmiyxW8k4ku1-Y_zsvg.webp" alt="The Chrome offline dinosaur game indicating no internet connection." caption="Fun fact: you can play with that dinosaur by pushing the up arrow key." />


## Progressive web app with Dart

## 用 Dart 构建渐进式 Web 应用

Supporting offline mode requires roughly the following:

支持离线模式大致需要以下步骤：

1. Determining which resources to put in the cache for offline use.

    确定哪些资源要放进缓存供离线使用。

1. Creating a service worker that prepares a cache of these resources.

    创建一个 service worker，为这些资源准备缓存。

1. Registering the service worker, so that subsequent requests can be served from the offline cache (in case the network is down).

    注册 service worker，让后续请求可以由离线缓存
    提供服务（在断网的情况下）。

1. In that service worker, pre-populating the offline cache with the URLs, and also handling the appropriate fetch request either from the cache, or from the network.

    在这个 service worker 中，用这些 URL 预填充离线缓存，
    并处理相应的 fetch 请求——从缓存或从网络获取。

1. Making sure that the service worker detects changes to the app or static assets, and puts the new version in the cache.

    确保 service worker 能检测应用或静态资源的变化，
    并把新版本放进缓存。

While the above list may sound a bit scary, we have a [pwa](https://pub.dartlang.org/packages/pwa) package in Dart that does most of the work for us, providing a high-level API and automating most of the work.

上面的列表听起来可能有点吓人，但 Dart 有一个
[pwa](https://pub.dartlang.org/packages/pwa) package
替我们完成大部分工作，提供高层 API 并自动化大多数步骤。

### Changes in your application

### 应用中的改动

Import the `pwa` package in your `pubspec.yaml`:

在 `pubspec.yaml` 中引入 `pwa` package：

```
dependencies:
  pwa: ^0.1.2
```


After running `pub get`, add the client to your `web/main.dart`:

运行 `pub get` 之后，把客户端加进 `web/main.dart`：

```
import ‘package:pwa/client.dart’ as pwa;

main() {
  // register PWA ServiceWorker for offline caching.
  new pwa.Client();

}
```


The above code handles item 3 from the above list by registering the service worker (which we will create in the following step). Right now we don’t use the Client instance for anything else, but as the `pwa` package gets new features, it may become useful for other purposes.

上面的代码通过注册 service worker（我们将在下一步创建它）
完成了列表中的第 3 项。目前我们不用这个 Client 实例
做别的事，但随着 `pwa` package 增加新特性，
它可能会在其他用途上派上用场。

### Automatically generated progressive web application

### 自动生成的渐进式 Web 应用

The `pwa` package provides code generation that handles items 1–2 and 4–5 from the above list. To ensure proper cache use (both populating and invalidating the cache) use the following workflow:

`pwa` package 提供的代码生成完成了列表中第 1–2 和 4–5 项。
为确保正确使用缓存（填充和失效都包括），
请使用以下工作流：

1. Build your web app with all of the static resources landing in `build/web`:
`pub build`

    构建 Web 应用，让所有静态资源落到 `build/web`：
    `pub build`

1. Run `pwa`’s code generator to scan (or rescan) your offline assets:
`pub run pwa`

    运行 `pwa` 的代码生成器，扫描（或重新扫描）离线资源：
    `pub run pwa`

1. Build your project again, because you need to have your (new) `pwa.dart` file compiled:
`pub build`

    再次构建项目，因为需要编译（新的）`pwa.dart` 文件：
    `pub build`

These steps produce a file named `lib/pwa/offline_urls.g.dart` that contains a list of the offline URLs to be cached. The `.g.dart` extension indicates that the file is generated and may be overwritten automatically by `pwa`’s code generator tool.

这些步骤会生成名为 `lib/pwa/offline_urls.g.dart` 的文件，
包含要缓存的离线 URL 列表。`.g.dart` 扩展名表示
该文件是生成的，可能被 `pwa` 的代码生成工具自动覆盖。

On the first run, this workflow generates the `web/pwa.dart` file that contains your service worker with reasonable defaults. You can modify this file (to customize the offline URLs or use the high-level APIs, for example) because the code generator won’t change or override it again.

首次运行时，这个工作流会生成 `web/pwa.dart` 文件，
包含带合理默认值的 service worker。你可以修改这个文件
（例如自定义离线 URL 或使用高层 API），
因为代码生成器不会再改动或覆盖它。

## Caveats

## 注意事项

While Dartium is great for most web development, at the moment it’s hard to use with service workers. We recommend using Chrome or Firefox instead.

虽然 Dartium 适合大多数 Web 开发，
但目前它很难与 service worker 配合使用。
我们建议改用 Chrome 或 Firefox。

Cache invalidation is one of the hardest problems in computer science. The underlying [Web Cache API](https://developer.mozilla.org/en-US/docs/Web/API/Cache) provides some guarantees, and the `pwa` library goes to a great length to gracefully handle the edge cases, but don’t treat the cache as reliable storage for anything really important. Make use of the cache when it is available, and fail gracefully when it’s not.

缓存失效是计算机科学中最难的问题之一。底层的
[Web Cache API](https://developer.mozilla.org/en-US/docs/Web/API/Cache)
提供了一些保证，`pwa` 库也竭力优雅地处理边界情况，
但不要把缓存当作真正重要数据的可靠存储。
缓存可用时就利用它，不可用时就优雅地降级。

## Try it out

## 试一试

You can now deploy the new version of your application. Or try the [offline Pop, Pop, Win! game](https://isoos.github.io/offline_pop_pop_win/).

现在你可以部署应用的新版本了。或者试试
[离线版 Pop, Pop, Win! 游戏](https://isoos.github.io/offline_pop_pop_win/)。

After opening the game and playing one round, shut down your wi-fi or unplug the network cable, and then reload (or retype the URL). If you’re using Chrome or Firefox, your game should be up and running. Good luck, have fun!

打开游戏玩一局之后，关掉 wi-fi 或拔掉网线，
然后刷新（或重新输入 URL）。如果你用的是 Chrome 或
Firefox，游戏应该照常运行。祝好运，玩得开心！
