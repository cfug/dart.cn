---
# title: Web deployment
title: 部署 Web 应用
# description: Learn how to build your Dart web app for production deployment.
description: 学习如何部署你的 Dart Web 应用。
ai-translated: true
---

Deploying a Dart web app works like deploying any other web app.
This page describes how to compile your app, tips for making it smaller
and faster, and points you to resources for serving the app.

部署 Dart Web 应用与部署其他 Web 应用类似。
本页说明如何编译应用、如何让它更小更快，
并指出用于托管该应用的资源。

## Building your app {:#compiling-to-javascript}

## 构建应用

Use the `webdev` tool to build your app. It compiles Dart to JavaScript
and generates all the assets you need for deployment.
When you build using the production mode of the compiler,
you get a JavaScript file that's reasonably small,
thanks to the compiler support for tree shaking.

使用 `webdev` 工具构建应用。它会把 Dart 编译为 JavaScript，
并生成部署所需的全部资源。
使用编译器的生产模式构建时，
得益于编译器的摇树优化支持，
你会得到一个相当小的 JavaScript 文件。

With a little extra work, you can make your deployable app
[smaller, faster, and more reliable](#make-your-app-smaller-faster-and-more-reliable).

再做一点额外工作，就可以让可部署的应用
[更小、更快、更可靠](#make-your-app-smaller-faster-and-more-reliable)。

### Compile using webdev

### 使用 webdev 编译

[Use the `webdev build` command][build] to create a deployable version
of your app. This command converts your code to JavaScript and saves
the result as `build/web/main.dart.js`. You can use [any option
available to `dart compile js`](/tools/dart-compile#prod-compile-options)
with `webdev build`.

[使用 `webdev build` 命令][build] 创建应用的可部署版本。
该命令把代码转换为 JavaScript，
并将结果保存为 `build/web/main.dart.js`。
[`dart compile js` 可用的任何选项](/tools/dart-compile#prod-compile-options)
都可以用于 `webdev build`。

### Make your app smaller, faster, and more reliable

### 让应用更小、更快、更可靠

The following steps are optional. They can help make your app more
reliable and responsive.

以下步骤是可选的。它们可以帮助应用更可靠、响应更快。

* [Use deferred loading to reduce your app's initial size](#use-deferred-loading-to-reduce-your-apps-initial-size)

  [使用延迟加载减小应用的初始体积](#use-deferred-loading-to-reduce-your-apps-initial-size)

* [Follow best practices for web apps](#follow-best-practices-for-web-apps)

  [遵循 Web 应用的最佳实践](#follow-best-practices-for-web-apps)

* [Remove unneeded build files](#remove-unneeded-build-files)

  [移除不需要的构建文件](#remove-unneeded-build-files)

#### Use deferred loading to reduce your app's initial size

#### 使用延迟加载减小应用的初始体积

You can use Dart's support for deferred loading to
reduce your app's initial download size.
For details, see the language tour's coverage of
[deferred loading](/language/libraries#lazily-loading-a-library).

你可以使用 Dart 的延迟加载支持，
减小应用的初始下载体积。
详情见语言导览中的
[延迟加载](/language/libraries#lazily-loading-a-library)。

#### Follow best practices for web apps

#### 遵循 Web 应用的最佳实践

The usual advice for web apps applies to Dart web apps.
Here are a few resources:

适用于 Web 应用的一般建议，同样适用于 Dart Web 应用。
下面是一些资源：

* [Fast load times](https://web.dev/fast/)

  [快速加载](https://web.dev/fast/)

* [Web Fundamentals](https://developers.google.com/web/fundamentals/)
  (especially [Optimizing Content Efficiency](https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/))

  [Web Fundamentals](https://developers.google.com/web/fundamentals/)
  （尤其是 [优化内容效率](https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/)）

* [Progressive Web Apps](https://web.dev/progressive-web-apps/)

  [渐进式 Web 应用](https://web.dev/progressive-web-apps/)

* [Lighthouse](https://developers.google.com/web/tools/lighthouse/)

  [Lighthouse](https://developers.google.com/web/tools/lighthouse/)

#### Remove unneeded build files

#### 移除不需要的构建文件

Web compilers can produce files that are useful during development,
such as Dart-to-JavaScript map files, but unnecessary in production.

Web 编译器会生成在开发期间有用、
但生产环境不需要的文件，
例如 Dart 到 JavaScript 的映射文件。

To remove these files, you can run a command like the following:

要移除这些文件，可以运行类似下面的命令：

{% comment %}
Revise the following once https://github.com/dart-lang/angular/issues/1123 is resolved:
{% endcomment %}

```console
# From the root directory of your app:
$ find build -type f -name "*.js.map" -exec rm {} +
```

## Serving your app

## 托管应用

You can serve your Dart Web app just like you'd serve any other web app.
This section points to tips for serving Dart Web apps,
as well as Dart-specific resources to help you use GitHub Pages or Firebase
to serve your app.

你可以像托管其他 Web 应用一样托管 Dart Web 应用。
本节给出托管 Dart Web 应用的提示，
以及帮助你使用 GitHub Pages 或 Firebase
托管应用的 Dart 相关资源。

### GitHub Pages

### GitHub Pages 托管

If your app doesn't use routing or require server-side support,
you can serve the app using [GitHub Pages](https://pages.github.com/).
The [peanut][] package is
an easy way to automatically produce a gh-pages branch for any Dart web app.

如果应用不使用路由，也不需要服务端支持，
可以用 [GitHub Pages](https://pages.github.com/) 托管。
[peanut][] package
可以轻松地为任何 Dart Web 应用自动生成 gh-pages 分支。

The [startup_namer example](https://filiph.github.io/startup_namer/)
is hosted using GitHub Pages.
Its files are in the **gh-pages** branch of the
[filiph/startup_namer repo](https://github.com/filiph/startup_namer)
and were built using [peanut.][peanut]

[startup_namer 示例](https://filiph.github.io/startup_namer/)
使用 GitHub Pages 托管。
其文件位于
[filiph/startup_namer 仓库](https://github.com/filiph/startup_namer)
的 **gh-pages** 分支，
并由 [peanut][peanut] 构建。

### Firebase

### Firebase 平台
{% comment %}
TODO: Give an example of how to deploy with Firebase, which originally was shown on https://dart.academy/build-a-real-time-chat-web-app-with-dart-angular-2-and-firebase-3/
{% endcomment %}

To learn more about deploying with Firebase, see the following resources:

要进一步了解如何用 Firebase 部署，请参阅以下资源：

* The [Firebase Hosting documentation](https://firebase.google.com/docs/hosting/)
  describes how to deploy web apps with Firebase.

  [Firebase Hosting 文档](https://firebase.google.com/docs/hosting/)
  说明如何用 Firebase 部署 Web 应用。

* In the Firebase Hosting documentation,
  [Configure Hosting Behavior](https://firebase.google.com/docs/hosting/full-config)
  covers redirects, rewrites, and more.

  在 Firebase Hosting 文档中，
  [配置托管行为](https://firebase.google.com/docs/hosting/full-config)
  涵盖重定向、重写等内容。

[build]: /tools/webdev#build
[build_runner]: /tools/build_runner
[build_web_compilers]: {{site.pub-pkg}}/build_web_compilers
[config]: /tools/build_runner#config
[peanut]: {{site.pub-pkg}}/peanut
[webdev]: /tools/webdev
