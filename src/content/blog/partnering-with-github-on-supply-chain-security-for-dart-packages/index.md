---
# title: "Partnering with GitHub on supply chain security for Dart packages"
title: "与 GitHub 合作保障 Dart package 的供应链安全"
# description: "Starting today, GitHub supports Dart in its Advisory Database, dependency graph, and Dependabot. This means GitHub now offers comprehensive…"
description: "从今天起，GitHub 的 Advisory Database、依赖图和 Dependabot 都支持 Dart 了……"
ai-translated: true
publishDate: 2022-10-06
author: mit-mit
image: images/1MdOSko9W_PJA0KwuQ_mu6w.webp
category: announcements
layout: blog
---


Starting today, GitHub supports Dart in its [Advisory Database](https://github.com/advisories), [dependency graph](https://docs.github.com/en/code-security/supply-chain-security/understanding-your-software-supply-chain/about-the-dependency-graph), and [Dependabot](https://docs.github.com/en/code-security/dependabot/dependabot-alerts/about-dependabot-alerts). This means GitHub now offers comprehensive support for supply chain security for Dart and Flutter apps.

从今天起，GitHub 的 [Advisory Database](https://github.com/advisories)、[依赖图](https://docs.github.com/en/code-security/supply-chain-security/understanding-your-software-supply-chain/about-the-dependency-graph)和 [Dependabot](https://docs.github.com/en/code-security/dependabot/dependabot-alerts/about-dependabot-alerts) 都支持 Dart 了。这意味着 GitHub 现在为 Dart 和 Flutter 应用提供全面的供应链安全支持。

To learn about these new capabilities, check out the [GitHub blog post](https://github.blog/2022-10-06-githubs-supply-chain-security-features-now-support-dart). To learn what this means to you as a Dart developer, keep reading.

要了解这些新能力，请查看 [GitHub 博客文章](https://github.blog/2022-10-06-githubs-supply-chain-security-features-now-support-dart)。要了解这对你这个 Dart 开发者意味着什么，请继续读下去。
> “With Dart now in our supply chain security ecosystem, GitHub extends its support for a fast-growing segment of the open source community,” *Courtney Claessens, Senior Product Manager for GitHub, said.* “And by moving security left, we help not only developers, but the millions of users who rely on apps developed in Dart.”

> “随着 Dart 加入我们的供应链安全生态，GitHub 把支持扩展到了开源社区中一个快速增长的部分，”*GitHub 高级产品经理 Courtney Claessens 说。*“通过安全左移，我们不仅帮助了开发者，也帮助了依赖 Dart 开发的应用的数百万用户。”

## Learning about package security issues

## 了解 package 安全问题

Imagine you’re building a fantastic new Flutter app. You’re using lots of really good packages in your `pubspec` (such as something [like this](https://github.com/gskinnerTeam/flutter-wonderous-app/blob/master/pubspec.yaml)) and shipping your app to multiple stores. What would happen if one of them had an important update to fix a security vulnerability? How would you find out about that? You can’t, short of manually checking the`CHANGELOG` for each of the tens of packages on a regular basis. This is a real challenge.

想象你正在构建一个出色的新 Flutter 应用。你在 `pubspec` 中用了很多很棒的 package（比如[这样的](https://github.com/gskinnerTeam/flutter-wonderous-app/blob/master/pubspec.yaml)），并把应用发布到多个商店。如果其中一个 package 发布了修复安全漏洞的重要更新，会发生什么？你怎么才能知道？除非定期手动检查几十个 package 的 `CHANGELOG`，否则你无从得知。这是个实实在在的挑战。

This is where Dependabot comes in. If you manage your source code in GitHub repository, the dependency graph and Dependabot monitor your pubspec dependencies and lets you know if you’re missing an update. The Dependabot submits a pull request to update `pubspec.yaml` to the latest version of the package on your behalf. This all comes about through new Dart-specific improvements in GitHub.

这就是 Dependabot 的用武之地。如果你在 GitHub 仓库中管理源码，依赖图和 Dependabot 会监控你的 pubspec 依赖，在你错过更新时通知你。Dependabot 会代你提交 pull request，把 `pubspec.yaml` 中的 package 更新到最新版本。这一切都得益于 GitHub 针对 Dart 的新改进。

<DashImage src="images/1MdOSko9W_PJA0KwuQ_mu6w.webp" alt="Dependabot pull request to update a Dart package dependency." caption="Dependabot sending a PR to bump (update) a package dependency to a more recent version." />


<DashImage src="images/1AVm9C0qX5t-FhYp8lJzU4Q.webp" alt="GitHub dependency graph listing dependencies for a Dart package." caption="Dependency Graph showing the set of dependencies for a Dart package." />


## An advisory database for Dart packages

## Dart package 的安全公告数据库

This scenario relies on a high quality, open database of security advisories that lists known vulnerabilities in Dart packages. For this feature, we partnered with GitHub to add Dart support to their popular [GitHub Advisory Database](https://github.com/advisories). This database already contains thousands of advisories for other ecosystems like npm, NuGet, and Maven.

这个场景依赖一个高质量、开放的安全公告数据库，列出 Dart package 中的已知漏洞。为了这个特性，我们与 GitHub 合作，为其广受欢迎的 [GitHub Advisory Database](https://github.com/advisories) 添加了 Dart 支持。这个数据库已经包含 npm、NuGet 和 Maven 等其他生态的数千条公告。

Starting today, you can now select the **Pub** ecosystem when creating advisories for published Dart packages.

从今天起，为已发布的 Dart package 创建公告时可以选择 **Pub** 生态了。

<DashImage src="images/1oPBNmrTaMOB_etyNOp9JJA.webp" alt="GitHub draft security advisory form with the ecosystem dropdown open and Pub selected." caption="Creating a new security advisory for a Dart package published on pub.dev" />


If you publish packages on [pub.dev](https://pub.dev/), we recommend two new best practices.

如果你在 [pub.dev](https://pub.dev/) 上发布 package，我们推荐两条新的最佳实践。

1. Use GitHub’s [security advisory](https://docs.github.com/en/code-security/repository-security-advisories/creating-a-repository-security-advisory) feature to create new advisories in your GitHub repo. GitHub ingests these advisories into the central GitHub Advisory database.

  使用 GitHub 的[安全公告](https://docs.github.com/en/code-security/repository-security-advisories/creating-a-repository-security-advisory)功能在你的 GitHub 仓库中创建新公告。GitHub 会把这些公告收录进中心的 GitHub Advisory 数据库。

1. Configure your [security policy](https://docs.github.com/en/code-security/getting-started/adding-a-security-policy-to-your-repository) including detailing how users can report vulnerabilities.

  配置你的[安全政策](https://docs.github.com/en/code-security/getting-started/adding-a-security-policy-to-your-repository)，包括详细说明用户如何报告漏洞。

## Secure your Dart repositories today

## 今天就保护你的 Dart 仓库

The new security features are available today. If your source code resides in a public repository, Dependabot has started monitoring for security issues. If your source lives in a private GitHub repo, you need a bit more [configuration](https://github.blog/2022-10-06-githubs-supply-chain-security-features-now-support-dart) to enable this feature.

新的安全特性今天就可使用。如果你的源码在公开仓库中，Dependabot 已经开始监控安全问题。如果源码在私有 GitHub 仓库中，你需要多一点[配置](https://github.blog/2022-10-06-githubs-supply-chain-security-features-now-support-dart)来启用这个特性。
