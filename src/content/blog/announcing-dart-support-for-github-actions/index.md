---
# title: "Announcing Dart support for GitHub Actions"
title: "宣布 Dart 支持 GitHub Actions"
# description: "GitHub Actions is a popular offering for continuous integration (CI) for GitHub repos. Today, we’re announcing an official setup-dart…"
description: "GitHub Actions 是 GitHub 仓库流行的持续集成（CI）方案。今天，我们宣布官方 setup-dart……"
ai-translated: true
publishDate: 2021-03-24
author: mit-mit
image: images/15E8_aBC9TBl9oBUwN3jAJw.webp
category: announcements
layout: blog
---


[GitHub Actions](https://github.com/features/actions) is a popular offering for continuous integration (CI) for GitHub repos. Today, we’re announcing an official [**setup-dart** action](https://github.com/marketplace/actions/setup-dart-sdk) by the Dart team. This action supports downloading, installing, and configuring the Dart SDK, so you can run Dart build and test jobs with ease on GitHub Actions.

[GitHub Actions](https://github.com/features/actions)
是 GitHub 仓库流行的持续集成（CI）方案。今天，我们宣布
Dart 团队推出的官方
[**setup-dart** action](https://github.com/marketplace/actions/setup-dart-sdk)。
这个 action 支持下载、安装和配置 Dart SDK，
让你能轻松在 GitHub Actions 上运行 Dart 构建和测试任务。

If you author a Dart package for pub.dev, we encourage you to enable CI testing with Github Actions for your repo, to give you (and package users) a signal about whether your package is healthy. CI jobs on GitHub Actions are [free for public repos](https://github.com/pricing).

如果你为 pub.dev 编写 Dart package，
我们鼓励你为仓库启用 GitHub Actions CI 测试，
给你（和 package 用户）一个 package 是否健康的信号。
GitHub Actions 上的 CI 任务对
[公开仓库免费](https://github.com/pricing)。

<DashImage src="images/15E8_aBC9TBl9oBUwN3jAJw.webp" alt="GitHub Marketplace page for the Setup Dart SDK action." />


## Introducing setup-dart

## setup-dart 简介

If you have a GitHub repository with a Dart app in it, you can enable CI testing with GitHub Actions and the setup-dart action with just a few clicks. Here we have a new GitHub repo called [myapp](https://github.com/mit-mit/myapp), which contains the starting point for a small application generated with the Dart tool [by running](https://dart.dev/tutorials/server/get-started#3-create-a-small-app)
`dart create --template console-full myapp`.

如果你有一个包含 Dart 应用的 GitHub 仓库，
只需点击几下就能用 GitHub Actions 和 setup-dart action
启用 CI 测试。这里我们有一个名为
[myapp](https://github.com/mit-mit/myapp) 的新 GitHub 仓库，
里面是一个小应用的起点，用 Dart 工具
[运行](https://dart.dev/tutorials/server/get-started#3-create-a-small-app)
`dart create --template console-full myapp` 生成。

Next, open the GitHub web UI, and click the **Actions** tab:

接下来，打开 GitHub 网页界面，点击 **Actions** 标签页：

<DashImage src="images/0IA24lXOJ0Zy1uwXF.webp" alt="The Actions tab in the GitHub web UI." />


Just below the the introduction, you should see a section suggesting a workflow for a Dart repository:

就在介绍下方，你应该能看到一个为 Dart 仓库
推荐工作流的板块：

<DashImage src="images/0tz1_DLk4qI1MpI4z.webp" alt="A suggested Dart workflow in the GitHub Actions UI." />


Click the **Set up this workflow** button, and you’ll be taken to the GitHub UI for adding a new `.github/workflow/dart.yml` file. This is a YAML file that defines the GitHub Actions workflow to run in the repo. Let’s review each of the components suggested by the template [workflow](https://github.com/dart-lang/characters/blob/master/.github/workflows/test-package.yml) file.

点击 **Set up this workflow** 按钮，
就会进入添加新 `.github/workflow/dart.yml` 文件的
GitHub 界面。这是一个 YAML 文件，
定义要在仓库中运行的 GitHub Actions 工作流。
我们来逐一看看模板
[工作流](https://github.com/dart-lang/characters/blob/master/.github/workflows/test-package.yml)
文件建议的各个组成部分。

First we define the name of the workflow, which will be shown in the Actions admin UI:

首先定义工作流的名称，它会显示在 Actions 管理界面中：

```
name: Dart
```


Next, we define when the workflow should be run (the [event](https://docs.github.com/en/actions/learn-github-actions/introduction-to-github-actions) that triggers the workflow). Here the flow is configured to run whenever there is a push to the main branch, or a PR for the main branch. I’ve personally found that when I’m having trouble getting a workflow to run, it’s often because I’ve misspelled the branch name.

接下来定义工作流何时运行（触发工作流的
[事件](https://docs.github.com/en/actions/learn-github-actions/introduction-to-github-actions)）。
这里配置为：每当有推送到 main 分支，
或有针对 main 分支的 PR 时运行。我个人的经验是，
工作流跑不起来时，往往是因为我把分支名拼错了。

```
on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]
```


Then follows a list of jobs, each with a name (here `test`). Each job has its own definition, consisting of a listing of where to run the job (this job runs on Ubuntu Linux) and what steps to take:

然后是一组任务（jobs），每个都有名字（这里是 `test`）。
每个任务有自己的定义，包括在哪里运行
（这个任务运行在 Ubuntu Linux 上）以及要执行哪些步骤：

```
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
```


As for the specific test, first we check out the repository under `test`, and then we run the new setup-dart action. This downloads and installs the Dart SDK, and then adds the `dart` CLI and pub global directory to the path. Here we don’t specify which Dart SDK to install, so the action will install the most recent stable-channel SDK.

具体到测试：首先在 `test` 下检出仓库，
然后运行新的 setup-dart action。它会下载并安装 Dart SDK，
再把 `dart` CLI 和 pub 全局目录加入 path。
这里我们没有指定要安装哪个 Dart SDK，
所以 action 会安装最新的 stable 渠道 SDK。

```
      - uses: actions/checkout@v2
      - uses: dart-lang/setup-dart@v1
```


We can then go ahead and perform our desired tests, like formatting, analysis, and unit tests:

然后就可以执行我们想要的测试了，
比如格式检查、分析和单元测试：

```
      - name: Install dependencies
        run: dart pub get

      - name: Verify formatting
        run: dart format — output=none — set-exit-if-changed .

      - name: Analyze project source
        run: dart analyze

      - name: Run tests
        run: dart test
```


For a full example, see our [workflow for package:characters](https://github.com/dart-lang/characters/blob/master/.github/workflows/test-package.yml).

完整示例请参见我们的
[package:characters 工作流](https://github.com/dart-lang/characters/blob/master/.github/workflows/test-package.yml)。

## Specifying SDK version

## 指定 SDK 版本

The setup-dart action supports specifying the version of Dart you wish to install. This can take one of two forms:

setup-dart action 支持指定你想安装的 Dart 版本。
有两种形式：

* A specific version, e.g. `2.9.0` or `2.12.0–259.12.beta`

  具体版本，例如 `2.9.0` 或 `2.12.0–259.12.beta`

* The latest version from a [release channel](https://dart.dev/get-dart#release-channels), e.g. `stable` or `beta`

  某个[发布渠道](https://dart.dev/get-dart#release-channels)
  的最新版本，例如 `stable` 或 `beta`

To specify a version use the `sdk` argument, either directly or as part of a [test matrix](https://docs.github.com/en/actions/learn-github-actions/managing-complex-workflows#using-a-build-matrix):

要指定版本，使用 `sdk` 参数，可以直接指定，
也可以作为
[测试矩阵](https://docs.github.com/en/actions/learn-github-actions/managing-complex-workflows#using-a-build-matrix)
的一部分：

```
matrix:
    os: [ubuntu-latest, macos-latest, windows-latest]
    sdk: [2.10.0, stable, beta]
    runs-on: ${{ matrix.os }}
    steps:
      - uses: actions/checkout@v2
      - uses: dart-lang/setup-dart@v1.0
        with:
          sdk: ${{ matrix.sdk }}
```


The result of this matrix is nine separately run jobs:

这个矩阵的结果是九个独立运行的任务：

<DashImage src="images/0Wm1ERed37w-oyoDq.webp" alt="Nine separately run test jobs resulting from the GitHub Actions matrix." />


Now that everything is passing, you might want to [add a status badge](https://docs.github.com/en/actions/managing-workflow-runs/adding-a-workflow-status-badge) to your `README.md` file to display the test status.

现在一切都通过了，你可能想在 `README.md` 文件中
[添加状态徽章](https://docs.github.com/en/actions/managing-workflow-runs/adding-a-workflow-status-badge)
来展示测试状态。

## Alternative solutions

## 其他方案

GitHub Actions is one of several popular solutions for continuous integration. Others with support for the Dart SDK include [Travis](https://docs.travis-ci.com/user/languages/dart/), [AppVeyor](https://www.appveyor.com/), and [CodeShip](https://documentation.codeship.com/basic/languages-frameworks/dart/). For testing of [Flutter](https://flutter.dev/) apps, options include [Codemagic from Nevercode](https://developer.nevercode.io/docs/building-flutter-apps), [Cirrus CI](https://cirrus-ci.org/examples/#flutter), and [Bitrise](https://devcenter.bitrise.io/getting-started/getting-started-with-flutter-apps/). GitHub Actions for Flutter apps is enabled by community contributed actions, such as [flutter-action](https://github.com/marketplace/actions/flutter-action).

GitHub Actions 是几种流行持续集成方案之一。
其他支持 Dart SDK 的还有
[Travis](https://docs.travis-ci.com/user/languages/dart/)、
[AppVeyor](https://www.appveyor.com/) 和
[CodeShip](https://documentation.codeship.com/basic/languages-frameworks/dart/)。
测试 [Flutter](https://flutter.dev/) 应用的选项包括
[Nevercode 的 Codemagic](https://developer.nevercode.io/docs/building-flutter-apps)、
[Cirrus CI](https://cirrus-ci.org/examples/#flutter) 和
[Bitrise](https://devcenter.bitrise.io/getting-started/getting-started-with-flutter-apps/)。
Flutter 应用的 GitHub Actions 由社区贡献的 action 支持，
例如 [flutter-action](https://github.com/marketplace/actions/flutter-action)。

That’s it for now. We hope you enjoy [this new CI support for Dart](https://github.com/marketplace/actions/setup-dart-sdk), and if you have any feedback or issues with setup-dart, please let us know in [the issue tracker](https://github.com/dart-lang/setup-dart/issues).

今天就到这里。希望你喜欢
[Dart 的这项新 CI 支持](https://github.com/marketplace/actions/setup-dart-sdk)。
如果对 setup-dart 有任何反馈或问题，
请在 [issue 跟踪器](https://github.com/dart-lang/setup-dart/issues)
告诉我们。
