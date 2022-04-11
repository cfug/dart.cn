---
title: "Write HTTP servers"
title: "编写 HTTP 服务器"
description: Communicate over the internet
description: 通过网络进行通讯
toc: false
prevpage:
  url: /tutorials/server/cmdline
  title: "Write command-line apps"
  title: "编写命令行应用"
---


Here are some resources for writing servers using Dart:

* Documentation
  * [Using Google Cloud][] has information on Google Cloud products
    that Dart servers can use, such as Cloud Run.
  * [Using Google APIs][] points to resources to help you
    use Firebase and Google client APIs from a Dart app.
* Samples
  * [A simple Dart HTTP server][simple-sample]
    * Uses the [`shelf`][] package.
    * Also uses the [`shelf_router`][] and [`shelf_static`][] packages.
    * Is deployable on Cloud Run.
  * [A Dart HTTP server that uses Cloud Firestore][cloud-sample]
    * Uses the Cloud Firestore features in the [`googleapis`][] package.
    * Also uses the [`googleapis_auth`][], [`shelf`][], and
      [`shelf_router`][] packages.
    * Is deployable on Cloud Run.

[cloud-sample]: https://github.com/dart-lang/samples/tree/master/server/google_apis
[`googleapis`]: {{site.pub-pkg}}/googleapis
[`googleapis_auth`]: {{site.pub-pkg}}/googleapis_auth
[`shelf`]: {{site.pub-pkg}}/shelf
[`shelf_router`]: {{site.pub-pkg}}/shelf_router
[`shelf_static`]: {{site.pub-pkg}}/shelf_static
[simple-sample]: https://github.com/dart-lang/samples/tree/master/server/simple
[Using Google APIs]: /guides/google-apis
[Using Google Cloud]: /server/google-cloud
