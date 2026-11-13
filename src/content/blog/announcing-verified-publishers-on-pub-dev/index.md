---
# title: "Announcing verified publishers on pub.dev"
title: "宣布 pub.dev 认证发布者"
# description: "Today we’re announcing a new ‘verified publishers’ feature on pub.dev,  the Dart package repository"
description: "今天我们宣布 Dart package 仓库 pub.dev 的新特性：“认证发布者”"
ai-translated: true
publishDate: 2019-10-10
author: mit-mit
image: images/0DfmB09PD2DK-pvTz.webp
category: announcements
layout: blog
---


Today we’re announcing a new feature on [pub.dev](https://pub.dev) (the Dart package repository): *verified publishers*. When you *use* a package that has a verified publisher, you can be sure that the publisher is who they claim to be. When you *publish* packages as a verified publisher, you get the bonus of easier package administration.

今天我们宣布 [pub.dev](https://pub.dev)（Dart package 仓库）的一个新特性：*认证发布者*。当你*使用*带有认证发布者的 package 时，可以确信发布者就是其声称的身份。当你以认证发布者身份*发布* package 时，还能额外获得更轻松的 package 管理体验。

<DashImage src="images/0DfmB09PD2DK-pvTz.webp" alt="Release banner reading 'Announcing verified publishers for pub.dev' with a shield checkmark icon." />


## Increasing trust for package consumers

## 增强 package 使用者的信任

App developers building apps with [Flutter](https://flutter.dev) tell us that having a rich selection of high-quality packages is critical to their productivity, allowing them to reuse common components and access popular SDKs and libraries. We’re seeing an immense amount of growth in the [pub.dev](https://pub.dev/) ecosystem, with thousands of packages published over the past year, and hundreds of thousands of developers using pub.dev every month to browse and search for new package content.

用 [Flutter](https://flutter.dev) 构建应用的开发者告诉我们，丰富的高质量 package 选择对他们的生产力至关重要，让他们可以复用常见组件并访问热门 SDK 和库。我们看到 [pub.dev](https://pub.dev/) 生态正在飞速增长：过去一年发布了数千个 package，每月有数十万开发者使用 pub.dev 浏览和搜索新的 package 内容。

One of the most important selection criteria we hear from package users is *who published the package.* Verified publishers strengthen this signal by verifying the identity of the publisher, and by clearly listing the publisher identity in package search results and on package detail pages (note the blue badge next to dart.dev in the screenshots below).

我们从 package 用户那里听到的最重要的选择标准之一是*package 是谁发布的*。认证发布者通过验证发布者身份，并在 package 搜索结果和详情页清晰列出发布者身份（注意下面截图中 dart.dev 旁边的蓝色徽章），强化了这个信号。

<DashImage src="images/0LQMWHLFUi6F7nPO1.webp" alt="Package search result showing a package that was published by a verified publisher." caption="*Package search result showing a package that was published by a verified publisher*" />


<DashImage src="images/0GJcMpmN8bNi6H5_g.webp" alt="Package detail page showing a package that was published by a verified publisher." caption="*Package detail page showing a package that was published by a verified publisher*" />


When you click the publisher, you can see a few more details, including a contact email for the publisher, a link to the publisher homepage, and a short description of the publisher. The publisher description is provided by the publisher, offering a small branding opportunity.

点击发布者可以看到更多细节，包括发布者的联系邮箱、主页链接和简短描述。发布者描述由发布者自己提供，是一个小小的品牌展示机会。

You can also view a list of all packages published by the publisher. Below is an example from the new [dart.dev publisher](https://pub.dev/publishers/dart.dev/packages).

你还可以查看该发布者发布的所有 package 列表。下面是新的 [dart.dev 发布者](https://pub.dev/publishers/dart.dev/packages)的示例。

<DashImage src="images/0Q24NUEox8eA10hVB.webp" alt="Package list for the verified dart.dev publisher." caption="*Sample package list for a publisher*" />


### Publisher verification process

### 发布者认证流程

When we designed the verification process, we wanted a mechanism that was trustworthy, low cost, and available to anyone interested in being a verified publisher. We also preferred a process that was automated, so accounts could be created without delays.

在设计认证流程时，我们希望这个机制可信、低成本，并且对任何想成为认证发布者的人开放。我们也倾向于自动化的流程，这样创建账号无需等待。

After reviewing several alternatives, we decided to base the verification on DNS (domain name system) second-level domains. We chose DNS because we believe that most package publishers already have a domain and a homepage at that domain. During the [publisher creation process](https://dart.dev/tools/pub/publishing#create-verified-publisher), pub.dev verifies that the user creating the verified publisher has admin access to the associated domain, based on existing logic in the [Google Search Console](https://search.google.com/search-console/about).

在评估了几个备选方案后，我们决定基于 DNS（域名系统）二级域名进行认证。选择 DNS 是因为我们相信大多数 package 发布者已经拥有域名和该域名下的主页。在[创建发布者的过程](https://dart.dev/tools/pub/publishing#create-verified-publisher)中，pub.dev 基于 [Google Search Console](https://search.google.com/search-console/about) 的现有逻辑，验证创建认证发布者的用户拥有关联域名的管理权限。

### Improved package administration

### 改进的 package 管理

Besides the clear benefits of verifying the publisher identity, the verified publishers feature also offers administrative benefits. Previously, if you published many packages, access management was a tedious, package-by-package job that took away time you could be spending on improving your packages. With verified publishers, you can configure a single team of admins for your publisher account, where all team members have the ability to publish updates to all packages owned by the publisher.

除了验证发布者身份带来的明显好处，认证发布者特性还带来管理上的便利。以前，如果你发布了很多 package，权限管理是一项繁琐的、逐个 package 进行的工作，占用了你本可用于改进 package 的时间。有了认证发布者，你可以为发布者账号配置一个统一的管理员团队，所有团队成员都能为该发布者名下的所有 package 发布更新。

We’ve also added a few new self-administration options, including the ability to move an existing package to a publisher account (see below), or to mark a package as [discontinued](https://dart.dev/tools/pub/publishing#discontinue).

我们还添加了一些新的自助管理选项，包括把现有 package 转移到发布者账号（见下文），或把 package 标记为[已停止维护](https://dart.dev/tools/pub/publishing#discontinue)。

### Transfer existing packages

### 转移现有 package

It’s easy to transfer existing packages to a verified publisher. Just [create a verified publisher](https://dart.dev/tools/pub/publishing#create-verified-publisher), and use the [transfer function](https://dart.dev/tools/pub/publishing#transferring-a-package-to-a-verified-publisher) on your existing packages. This simple process takes just a few minutes per package.

把现有 package 转移给认证发布者很简单。只需[创建认证发布者](https://dart.dev/tools/pub/publishing#create-verified-publisher)，然后对现有 package 使用[转移功能](https://dart.dev/tools/pub/publishing#transferring-a-package-to-a-verified-publisher)。这个简单的过程每个 package 只需几分钟。

### Pub.dev roadmap

### Pub.dev 路线图

We’re discussing lots of future improvements to pub.dev. Here are some of the ideas:

我们正在讨论 pub.dev 的许多未来改进。以下是其中一些想法：

* Search support for packages that support a particular platform (for example, Android or web; [#187](https://github.com/dart-lang/pub-dev/issues/187)), incl. better understanding of Dart web vs Flutter web packages

  支持按特定平台（例如 Android 或 Web；[#187](https://github.com/dart-lang/pub-dev/issues/187)）搜索 package，包括更好地区分 Dart web 与 Flutter web package

* Tags or categories for packages ([#367](https://github.com/dart-lang/pub-dev/issues/367))

  package 的标签或分类（[#367](https://github.com/dart-lang/pub-dev/issues/367)）

* Voting on or liking high-quality packages ([#798](https://github.com/dart-lang/pub-dev/issues/798))

  为高质量 package 投票或点赞（[#798](https://github.com/dart-lang/pub-dev/issues/798)）

* Clear policy and process for reporting questionable content ([#1570](https://github.com/dart-lang/pub-dev/issues/1570))

  举报可疑内容的明确政策和流程（[#1570](https://github.com/dart-lang/pub-dev/issues/1570)）

If you’re interested in a particular idea, we encourage you to check the [pub.dev issue tracker](https://github.com/dart-lang/pub-dev/issues?q=is%3Aissue+is%3Aopen+sort%3Areactions-%2B1-desc) to make sure the idea is already tracked, and to indicate your interest by adding a *thumbs up* reaction to the topmost comment of the issue.

如果你对某个想法感兴趣，我们建议你查看 [pub.dev issue 跟踪器](https://github.com/dart-lang/pub-dev/issues?q=is%3Aissue+is%3Aopen+sort%3Areactions-%2B1-desc)确认该想法已被跟踪，并在 issue 最上面的评论点一个*赞*来表达你的兴趣。

### Next steps

### 下一步

If you’re a package publisher, we encourage you to get your packages transferred to a verified publisher account as soon as possible, to get the benefits listed above for both yourself and the users of your packages. We’ve already transferred many of the most popular [dart.dev packages](https://pub.dev/publishers/dart.dev/packages), and expect more to be transferred shortly.

如果你是 package 发布者，我们建议你尽快把 package 转移到认证发布者账号，为你自己和 package 用户获得上述好处。我们已经转移了许多最热门的 [dart.dev package](https://pub.dev/publishers/dart.dev/packages)，预计很快会有更多完成转移。

That’s all for now. We look forward to seeing even more high-quality packages on [pub.dev](https://pub.dev/)!

这次就到这里。期待在 [pub.dev](https://pub.dev/) 上看到更多高质量 package！
