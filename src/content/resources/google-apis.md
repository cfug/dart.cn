---
# title: Using Google APIs
title: 使用 Google API
# shortTitle: Google APIs
shortTitle: Google API
# description: Your Dart apps can use Firebase and Google client APIs.
description: 你的 Dart 应用可以使用 Firebase 和 Google 客户端 API。
lastVerified: 2021-05-13
ai-translated: true
---

This page points to resources to help you use
[Firebase][] and [Google client APIs][] from a Dart app.

本页提供一些资源，帮助你在 Dart 应用里使用
[Firebase][] 和 [Google 客户端 API][Google client APIs]。


## Firebase

## Firebase 平台

The Dart API that you use with Firebase depends
on whether you're writing code for a Flutter app or another kind of Dart app.

配合 Firebase 使用的 Dart API，
取决于你写的是 Flutter 应用，还是其他类型的 Dart 应用。

Flutter apps can choose from many officially supported plugins for
popular Firebase products such as Analytics, Cloud Firestore,
Cloud Functions, and Crashlytics.
For a full list of these plugins, see [FlutterFire][].

Flutter 应用可以从许多官方支持的插件里选择，
覆盖 Analytics、Cloud Firestore、Cloud Functions 和 Crashlytics
等常用 Firebase 产品。
完整插件列表见 [FlutterFire][]。

Other kinds of Dart apps can use
the community-supported [`firebase` package][].

其他类型的 Dart 应用可以使用社区支持的
[`firebase` package][]。

## Google client APIs

## Google 客户端 API

The [`googleapis` package][] contains generated APIs for
over 180 Google client APIs,
such as the Google Docs API, YouTube Data API,
Cloud Translation API, and Cloud Storage API.

[`googleapis` package][] 包含 180 多个 Google 客户端 API 的生成代码，
例如 Google Docs API、YouTube Data API、
Cloud Translation API 和 Cloud Storage API。

If you're building a Flutter application, see the
[Flutter guide for Google APIs][flutter-google-apis].

如果要构建 Flutter 应用，请看
[Flutter 的 Google API 指南][flutter-google-apis]。

If you'd like to use Google APIs as part of a server application, see the
[google_apis server sample][server-sample].

如果想在服务端应用里使用 Google API，请看
[google_apis 服务端示例][server-sample]。

Some packages provide idiomatic Dart wrappers for
the APIs provided by `googleapis`.
For example, if you want to use the Google Sheets API,
consider the [`gsheets` package][],
which provides an [alternative API][gsheets-api-docs] to the
[automatically generated API][gsheets-api-docs-gapi].

有些 package 为 `googleapis` 提供的 API 做了更符合 Dart 习惯的封装。
例如要用 Google Sheets API，
可以考虑 [`gsheets` package][]。
它提供了一套 [替代 API][gsheets-api-docs]，
对应 [自动生成的 API][gsheets-api-docs-gapi]。

To find wrapper packages for Google client APIs, search for
[packages that depend on `googleapis`][gapi-packages].

要找 Google 客户端 API 的封装 package，
可以搜索 [依赖 `googleapis` 的 package][gapi-packages]。


[Firebase]: https://firebase.google.com/use-cases
[FlutterFire]: https://firebase.flutter.dev/
[`firebase` package]: {{site.pub-pkg}}/firebase
[gapi-packages]: {{site.pub-pkg}}?q=dependency%3Agoogleapis
[Google client APIs]: https://developers.google.com/api-client-library
[`googleapis` package]: {{site.pub-pkg}}/googleapis
[`gsheets` package]: {{site.pub-pkg}}/gsheets
[gsheets-api-docs]: {{site.pub-api}}/gsheets/latest/gsheets/gsheets-library.html
[gsheets-api-docs-gapi]: {{site.pub-api}}/googleapis/latest/sheets_v4/sheets_v4-library.html
[flutter-google-apis]: {{site.flutter-docs}}/development/data-and-backend/google-apis
[server-sample]: {{site.repo.dart.samples}}/tree/main/server/google_apis
