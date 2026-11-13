---
# title: "Screenshots and automated publishing for pub.dev"
title: "pub.dev 的截图与自动化发布"
# description: "We have a couple of new features available on pub.dev starting today: You can now declare screenshots for a package, enabling a more visual…"
description: "从今天起 pub.dev 上线了几个新特性：你现在可以为 package 声明截图，让搜索更直观……"
ai-translated: true
publishDate: 2023-01-18
author: jonasfj
image: images/169KfhhHmmvZ6BLvypXjx2A.webp
category: announcements
layout: blog
---


We have a couple of new features available on pub.dev starting today: You can now declare screenshots for a package, enabling a more visual approach to search. And the publishing flow can now be fully automated, powered by GitHub Actions.

从今天起，pub.dev 上线了几个新特性：你现在可以为 package 声明截图，让搜索更加直观。发布流程现在也可以借助 GitHub Actions 实现完全自动化。

## Adding screenshots to pub.dev

## 为 pub.dev 添加截图

One of the core objectives of pub.dev is to make it easy to find the right package for a given purpose. When you search for widgets or other visual components, images play an important role. We are now showing screenshots in package search results, to make it easier than ever to find a package.

pub.dev 的核心目标之一，是让你轻松找到适合特定用途的 package。当你搜索 widget 或其他可视化组件时，图片起着重要作用。我们现在会在 package 搜索结果中展示截图，让找 package 变得前所未有的容易。

### Screenshots in package search and on the package page

### package 搜索和 package 页面中的截图

Thumbnails of screenshots now appear in the search results and you can also filter the search to only list packages with screenshots.

截图缩略图现在会出现在搜索结果中，你还可以筛选搜索，只列出带截图的 package。

<DashImage src="images/1B2bqbwEtObMoGQTm8B-FVQ.webp" alt="Pub.dev search results filtered by has:screenshot, showing package screenshot thumbnails beside results." />


The screenshot thumbnail is also shown on the package page, and clicking the thumbnail triggers an image carousel with all the screenshots.

package 页面上也会显示截图缩略图，点击缩略图会打开一个包含所有截图的图片轮播。

<DashImage src="images/169KfhhHmmvZ6BLvypXjx2A.webp" alt="Image carousel displaying screenshots on a package page." />


### Declaring screenshots in `pubspec.yaml`

### 在 `pubspec.yaml` 中声明截图

Adding screenshots to a package is really simple. Declare the files in `pubspec.yaml` under the `screenshots` field with a `description` and a `path`. Below is an example from the `animations` package.

为 package 添加截图非常简单。在 `pubspec.yaml` 的 `screenshots` 字段下声明文件，附上 `description` 和 `path` 即可。下面是来自 `animations` package 的示例。

```yaml
name: animations
...
screenshots:
 - description: 'Examples of the container transform pattern.'
   path: example/screenshots/container_transform_lineup.png
 - description: 'Examples of the fade pattern.'
   path: example/screenshots/fade_lineup.png
   ...
```


For more details see [dart.dev/tools/pub/pubspec#screenshots](https://dart.dev/tools/pub/pubspec#screenshots).

更多细节参见 [dart.dev/tools/pub/pubspec#screenshots](https://dart.dev/tools/pub/pubspec#screenshots)。

## Automated publishing for pub.dev

## pub.dev 的自动化发布

Thousands of Dart community members publish packages on pub.dev, for the benefit of all Dart and Flutter developers. Traditionally, these package publishers have published to pub.dev by running a local terminal command, `dart pub publish`, and authenticating with their Google account. Behind the scenes a *refresh token* was stored in a configuration file on their development machine, which enabled them to publish a new version without authenticating again. This flow is simple and easy to understand, but requires a number of manual steps. We’re happy to introduce a new automated publishing flow, that enables publishing new pub.dev versions directly from a GitHub Action. This has several benefits:

数千名 Dart 社区成员在 pub.dev 上发布 package，惠及所有 Dart 和 Flutter 开发者。传统上，这些 package 发布者通过在本地终端运行 `dart pub publish` 命令并用 Google 账号认证来发布到 pub.dev。在幕后，一个*刷新令牌（refresh token）*会存储在开发机器的配置文件中，让他们无需再次认证就能发布新版本。这个流程简单易懂，但需要不少手动步骤。我们很高兴推出一种新的自动化发布流程，可以直接从 GitHub Action 发布新的 pub.dev 版本。它有以下几个好处：

* Each release is automatically tagged with consistent release tags in GitHub

  每次发布都会在 GitHub 中自动打上一致的发布标签

* It’s easy to configure a review and approval flow for publishing new versions.

  可以轻松为发布新版本配置审查和审批流程。

* The publishing process is authenticated by a token signed by GitHub, ensuring no credentials have to be stored on disk.

  发布过程通过 GitHub 签名的令牌进行认证，确保无需在磁盘上存储任何凭据。

<DashImage src="images/1dqxBy1vvLW108xdpqLLZ5Q.webp" alt="GitHub Actions run for Publish to pub.dev showing a successful dart pub publish command for testpkg 1.1.5." />


### Making automated publishing secure

### 让自动化发布更安全

Currently, some users have resorted to storing the `pub-credentials.json` configuration file containing the *refresh token* in a secret environment variable on GitHub Actions. This way, they could write a GitHub Action workflow that recovered the configuration file and used it to publish a new version of the package. While this flow technically works, the tooling wasn’t designed with this in mind and the flow has multiple downsides:

目前，一些用户把包含*刷新令牌*的 `pub-credentials.json` 配置文件存进了 GitHub Actions 的机密环境变量。这样，他们就能编写一个 GitHub Action 工作流，恢复该配置文件并用它发布 package 的新版本。虽然这个流程在技术上可行，但工具链的设计初衷并非如此，而且这个流程有多个缺点：

* The `pub-credentials.json` files can be used to publish any package the author has permission to publish, not just the one package published from the configured flow.

  `pub-credentials.json` 文件可以用来发布作者有权限发布的任何 package，而不只是配置好的流程所发布的那一个。

* If leaked, the `pub-credentials.json` can be used to publish new versions and new packages, impersonating the user who created the `pub-credentials.json` file.

  一旦泄露，`pub-credentials.json` 就能被用来冒充创建该文件的用户，发布新版本和新 package。

* The [UI for revoking](https://myaccount.google.com/permissions) the *refresh token* in `pub-credentials.json` is not easy to find.

  用于撤销 `pub-credentials.json` 中*刷新令牌*的[界面](https://myaccount.google.com/permissions)不容易找到。

Indeed, it has happened more than once that a package was published and it accidentally included the author’s `pub-credentials.json` file, because the author extracted the file inside a CI job. Publishing a package along with the credentials required to update the package is a pretty severe security vulnerability and we eventually [implemented leak detection](https://dart.dev/go/false-secrets) in `dart pub publish`.

事实上，已经不止一次发生过这样的事：发布的 package 意外包含了作者的 `pub-credentials.json` 文件，因为作者在 CI 任务中解压出了该文件。把 package 连同更新它所需的凭据一起发布，是相当严重的安全漏洞，我们最终在 `dart pub publish` 中[实现了泄露检测](https://dart.dev/go/false-secrets)。

Our new automated publishing support mitigates these issues, making it possible to authenticate to pub.dev using one of the following:

我们新的自动化发布支持缓解了这些问题，让你可以使用以下方式之一向 pub.dev 认证：

* A temporary [OIDC token signed by Github Actions](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect).

  一个由 [Github Actions 签名的临时 OIDC 令牌](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect)。

* A GCP service account that can be used from most GCP resources like Google Cloud Build or other cloud environments, such as Azure or AWS.

  一个 GCP 服务账号，可以在大多数 GCP 资源（如 Google Cloud Build）或其他云环境（如 Azure 或 AWS）中使用。

These flows enable automated publishing relying on long-lived secret tokens that can easily be abused, if leaked by accident. If deploying your publishing flow to a custom machine, you can, of course, rely on exported service account keys, but great care must be taken to properly secure such keys.

这些流程实现了自动化发布，而不必依赖那种一旦意外泄露就很容易被滥用的长期机密令牌。如果你把发布流程部署到自定义机器上，当然也可以依赖导出的服务账号密钥，但必须格外小心，妥善保护这些密钥。

### Enabling secure publishing

### 启用安全发布

You can enable automated publishing from GitHub with just a few steps — see [dart.dev/go/automated-publishing](http://dart.dev/go/automated-publishing) for all the details.

只需几个步骤就能启用从 GitHub 自动化发布——全部细节参见 [dart.dev/go/automated-publishing](http://dart.dev/go/automated-publishing)。
