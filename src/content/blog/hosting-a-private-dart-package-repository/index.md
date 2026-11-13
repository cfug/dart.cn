---
# title: "Hosting a private Dart package repository"
title: "托管私有 Dart package 仓库"
# description: "Improvements in Dart 2.15 for secure enterprise package hosting"
description: "Dart 2.15 为企业安全 package 托管带来的改进"
ai-translated: true
publishDate: 2022-03-16
author: jonasfj
image: images/1hv1Nujq4-g2-y2uLuLYVqA.webp
category: other
layout: blog
---


Our recent Dart 2.15 release added support for private package repositories. A package repository is a server that hosts Dart packages for consumption by the `dart pub` client. This post discusses how to use private package repositories alongside [pub.dev](https://pub.dev), leveraging the new token authentication mechanism introduced in Dart 2.15.

我们最近发布的 Dart 2.15 增加了对私有 package 仓库的支持。
package 仓库（package repository）是托管 Dart package、
供 `dart pub` 客户端使用的服务器。本文讨论如何利用 Dart 2.15
引入的新令牌认证机制，让私有 package 仓库与
[pub.dev](https://pub.dev) 协同使用。

This feature has already been adopted by [Cloudsmith](https://help.cloudsmith.io/docs/dart-repository) and [JFrog Artifactory](https://jfrog.com/blog/how-to-use-pub-repositories-in-artifactory/) who offer custom package repositories as a service:

这一特性已被提供自定义 package 仓库服务的
[Cloudsmith](https://help.cloudsmith.io/docs/dart-repository) 和
[JFrog Artifactory](https://jfrog.com/blog/how-to-use-pub-repositories-in-artifactory/)
采用：

<DashImage src="images/1-xVF9afKxXP0_RTKs1pyxA.webp" alt="Logos for Cloudsmith and JFrog Artifactory." caption="Private Dart repositories are now offered by both Cloudsmith and JFrog Artifactory." />


## Why use a custom package repository?

## 为什么要使用自定义 package 仓库？

The default package repository, [pub.dev](https://pub.dev), is operated by the Dart team. It facilitates publication of Dart packages for public use, and allows any Dart developer to consume those packages simply by adding the name of the package to their pubspec file. This enables a rich collection of Dart packages to be created by an active ecosystem. However, a custom package repository might be useful in the following scenarios:

默认的 package 仓库 [pub.dev](https://pub.dev) 由 Dart 团队运营。
它方便发布供公众使用的 Dart package，任何 Dart 开发者只需把 package
名字加进 pubspec 文件就能使用这些 package。这让活跃的生态系统
创造了丰富的 Dart package 集合。不过，自定义 package 仓库
在以下场景中可能很有用：

1. Sharing private packages within an organization. This could be an organization looking to share internal proprietary packages among the members of the organization, and not with the general public.

    在组织内共享私有 package。比如某个组织希望只在组织成员之间
    共享内部专有 package，而不向公众开放。

1. Tight control of dependencies in enterprise environments. Some corporations want to explicitly create allow-lists for specific *package versions* approved for usage. This might be done to enforce code review policies or license compliance.

    在企业环境中严格控制依赖。一些公司希望为批准使用的特定
    *package 版本*显式创建允许列表（allow-list）。
    这可能是为了执行代码评审政策或许可证合规要求。

1. Secure environments without public internet access. Some organizations operate in a regulatory environment where connections to the public internet, and by extension [pub.dev](https://pub.dev), are not allowed. This typically applies to government agencies/contractors and some banking service providers.

    无法访问公共互联网的安全环境。一些组织所处的监管环境
    不允许连接公共互联网，自然也包括 [pub.dev](https://pub.dev)。
    这通常适用于政府机构/承包商和一些银行服务提供商。

Organizations that just need to share a few proprietary packages (scenario 1) might use [git-dependencies](https://dart.dev/tools/pub/dependencies#git-packages). This is a powerful mechanism because the`dart pub` client command invokes the `git` client for cloning git-dependencies — this way you might authenticate cloning a dependency using your SSH key, and manage permissions using GitHub/GitLab teams. With [GitHub support for SSH using Yubikeys](https://www.yubico.com/blog/github-now-supports-ssh-security-keys/) this setup works well in some cases.

只需要共享少量专有 package 的组织（场景 1）可以使用
[git 依赖](https://dart.dev/tools/pub/dependencies#git-packages)。
这是个强大的机制，因为 `dart pub` 客户端命令会调用 `git` 客户端
来克隆 git 依赖——这样你可以用 SSH 密钥认证依赖的克隆，
并用 GitHub/GitLab 团队管理权限。配合
[GitHub 对使用 Yubikey 的 SSH 的支持](https://www.yubico.com/blog/github-now-supports-ssh-security-keys/)，
这套方案在某些情况下很好用。

However, git-dependencies in `dart pub` have some limitations when it comes to version solving. When using a git-dependency, `dart pub` just clones the tag / branch / ref specified in `pubspec.yaml`, because there is no mechanism for trying multiple versions of the dependency. Thus, using a private custom package repository can be attractive because a custom package repository can supply the `dart pub` client with a list of versions, allowing the [version solver](https://nex3.medium.com/pubgrub-2fb6470504f') to pick a compatible version and avoid conflicts. It also makes it easy to upgrade both private and public dependencies using `dart pub outdated` and `dart pub upgrade --major-versions`.

然而，`dart pub` 中的 git 依赖在版本求解方面有一些限制。
使用 git 依赖时，`dart pub` 只会克隆 `pubspec.yaml` 中指定的
tag/分支/ref，因为没有尝试依赖多个版本的机制。因此，
使用私有自定义 package 仓库可能更有吸引力，因为它可以向
`dart pub` 客户端提供版本列表，让
[版本求解器](https://nex3.medium.com/pubgrub-2fb6470504f')
挑选兼容的版本、避免冲突。它还让你能方便地用 `dart pub outdated`
和 `dart pub upgrade --major-versions` 升级私有和公共依赖。

Git dependencies doesn’t support organizations looking for *tighter control around dependencies* (scenario 2) or using *a secure environment without internet access* (scenario 3), as a lot of packages have to be mirrored. In these scenarios it’s almost always preferable to simply have a custom package repository mirroring an allow-listed subset of [pub.dev](https://pub.dev).

git 依赖无法满足需要*更严格控制依赖*（场景 2）或
*无互联网访问的安全环境*（场景 3）的组织，因为必须镜像大量 package。
在这些场景中，几乎总是更推荐直接用一个自定义 package 仓库，
镜像 [pub.dev](https://pub.dev) 中允许列表内的子集。

## Using a custom package repository

## 使用自定义 package 仓库

Starting with Dart 2.15, you can depend on a package from a custom package repository using the *short-form hosted dependency* syntax:

从 Dart 2.15 开始，你可以使用*简写形式的 hosted 依赖*语法
来依赖自定义 package 仓库中的 package：

```
dependencies:
  foo:
    hosted: https://dart-packages.example.com
    version: ^1.4.0
environment: 
  sdk: >=2.15.0 <3.0.0
```


The short-form syntax requires an SDK constraint `&gt;=2.15.0,` because older versions of the Dart SDK don’t support this syntax. If you don’t want to worry about syntax, you can also just use the `dart pub add` command to add a dependency from a custom package repository:

简写语法要求 SDK 约束为 `&gt;=2.15.0,`，
因为旧版本的 Dart SDK 不支持这种语法。如果你不想操心语法，
也可以直接用 `dart pub add` 命令添加来自自定义 package 仓库的依赖：

```
$ dart pub add foo --hosted https://dart-packages.example.com
Resolving dependencies... 
+ foo 1.4.0
Changed 1 dependency!
```


Using the hosted-dependency syntax, it’s possible to mix dependencies from custom package repositories with dependencies from the official package repository. The following example depends on package `foo` from the `dart-packages.example.com` repository, and package `retry` from pub.dev:

使用 hosted 依赖语法，可以把来自自定义 package 仓库的依赖
与来自官方 package 仓库的依赖混用。下面的例子依赖来自
`dart-packages.example.com` 仓库的 package `foo`，
以及来自 pub.dev 的 package `retry`：

```
dependencies:
  retry: ^3.0.0
  foo:
    hosted: https://dart-packages.example.com
    version: ^1.4.0
environment: 
  sdk: >=2.15.0 <3.0.0
```


This is useful when sharing private packages using a custom package repository (scenario 1). But for *tighter control of dependencies* (scenario 2) or working in *a secure environment without internet access* (scenario 3), it might be preferable to override the default package repository.

这在用自定义 package 仓库共享私有 package（场景 1）时很有用。
但要*更严格地控制依赖*（场景 2），或在
*无互联网访问的安全环境*中工作（场景 3），
覆盖默认 package 仓库可能是更好的选择。

### Overriding the default package repository

### 覆盖默认 package 仓库

By default, `dart pub get` fetches dependencies from `pub.dev` unless the hosted-dependency syntax is used to specify a custom package repository. However, it’s possible to override the *default package repository* using the environment variable `PUB_HOSTED_URL`. This approach is particularly useful when mirroring a subset of pub.dev (scenario 2 or 3), as there is no need to update the `pubspec.yaml` file to reference the custom package repository URL. For example, it’s sufficient to write the following:

默认情况下，`dart pub get` 从 `pub.dev` 获取依赖，
除非使用 hosted 依赖语法指定了自定义 package 仓库。不过，
你可以用环境变量 `PUB_HOSTED_URL` 覆盖*默认 package 仓库*。
在镜像 pub.dev 子集（场景 2 或 3）时，这种方式特别有用，
因为无需修改 `pubspec.yaml` 文件来引用自定义 package 仓库的 URL。
例如，只需这样写：

```
dependencies:
  retry: ^3.0.0
  foo: ^1.0.0
```


If allow-listed versions of packages `retry` and `foo` are copied to the custom package repository, and the environment variable `PUB_HOSTED_URL` points to the custom package repository URL, `pub get` can work as follows:

如果 package `retry` 和 `foo` 的允许列表版本已被复制到
自定义 package 仓库，且环境变量 `PUB_HOSTED_URL` 指向
自定义 package 仓库的 URL，`pub get` 就能这样工作：

```
$ export PUB_HOSTED_URL=https://dart-packages.example.com
$ dart pub get
Resolving dependencies... 
+ retry 3.1.0
+ foo 1.4.0
Changed 2 dependencies!
```


This works best when the build server sits behind a corporate firewall that disallows outgoing network connections in order to avoid accidental injection attacks when someone forgets to set `PUB_HOSTED_URL`. Similarly, it’s also advisable to set `publish_to: &lt;hosted-url&gt;` in `pubspec.yaml` to avoid accidental publishing to pub.dev (when `PUB_HOSTED_URL` isn’t defined).

当构建服务器位于禁止出站网络连接的企业防火墙之后时，这种方式效果最好，
可以避免有人忘记设置 `PUB_HOSTED_URL` 时意外遭受注入攻击。
同样，也建议在 `pubspec.yaml` 中设置
`publish_to: &lt;hosted-url&gt;`，避免（在未定义 `PUB_HOSTED_URL` 时）
意外发布到 pub.dev。

### Authentication against custom package repositories

### 向自定义 package 仓库认证

Most custom package repositories are likely to be private package repositories that require authentication. Dart 2.15 introduced the [`dart pub token`](https://dart.dev/tools/pub/cmd/pub-token) command for managing authentication tokens. Requests to a custom package repository are authenticated using a secret token. You obtain the secret token from your custom package repository and pass it to `dart pub token add &lt;hosted-url&gt;`, which prompts for the token as shown below:

大多数自定义 package 仓库很可能是需要认证的私有 package 仓库。
Dart 2.15 引入了
[`dart pub token`](https://dart.dev/tools/pub/cmd/pub-token)
命令来管理认证令牌。对自定义 package 仓库的请求使用秘密令牌认证。
你从自定义 package 仓库获取秘密令牌，
然后传给 `dart pub token add &lt;hosted-url&gt;`，
它会像下面这样提示输入令牌：

```
$ dart pub token add https://dart-packages.example.com
Enter secret token: [enter secret token]
Requests to "dart-packages.example.com" will now be authenticated using the secret token.
```


### Authentication from CI environments

### CI 环境中的认证

When running in CI it’s often possible to [store secrets in environment variables](https://docs.github.com/en/actions/security-guides/encrypted-secrets#about-encrypted-secrets), and while it’s possible to pass secrets using `echo $TOKEN | dart pub token add &lt;hosted-url&gt;`, it’s also possible to tell `dart pub` to read a secret from an environment variable when talking to a specific custom repository:

在 CI 中运行时，通常可以
[把秘密存储在环境变量中](https://docs.github.com/en/actions/security-guides/encrypted-secrets#about-encrypted-secrets)。
虽然可以用 `echo $TOKEN | dart pub token add &lt;hosted-url&gt;`
传递秘密，但也可以告诉 `dart pub` 在与特定自定义仓库通信时
从环境变量读取秘密：

```
$ dart pub token add https://dart-packages.example.com --env-var MY_SECRET_TOKEN
Requests to "https://dart-packages.example.com" will now be authenticated using the secret token stored in the environment variable "MY_SECRET_TOKEN".
```


This ensures that `dart pub` doesn’t actually store the secret in its configuration file, instead it merely stores the fact that it should read the secret from the environment variable `$MY_SECRET_TOKEN`. This allows secrets to only be stored in environment variables when operating in a CI environment, and reduces the risk that secrets are accidentally leaked if the execution environment is shared between CI jobs.

这确保 `dart pub` 不会把秘密真正存进配置文件，
而只是记录它应该从环境变量 `$MY_SECRET_TOKEN` 读取秘密。
这样在 CI 环境中运行时，秘密可以只存储在环境变量里，
并降低执行环境在 CI 任务之间共享时秘密意外泄露的风险。

## Publishing to custom package repositories

## 发布到自定义 package 仓库

To publish a package to a custom package repository, you specify `publish_to: &lt;hosted-url&gt;` in `pubspec.yaml,` and run `dart pub publish`. This uses the same token for authentication as is used by `dart pub get`. At a minimum, your `pubspec.yaml` file should look something like the following:

要把 package 发布到自定义 package 仓库，
在 `pubspec.yaml,` 中指定 `publish_to: &lt;hosted-url&gt;`，
然后运行 `dart pub publish`。它使用与 `dart pub get`
相同的令牌进行认证。你的 `pubspec.yaml` 文件至少应该类似这样：

```
name: mypkg
version: 1.0.0
publish_to: https://dart-packages.example.com
dependencies:
  meta: ^1.7.0
environment:
  sdk: >=2.15.0 <3.0.0
```


When running `dart pub publish` it is important to review the information given. Before confirming the publishing action you should always do the following:

运行 `dart pub publish` 时，仔细查看给出的信息很重要。
在确认发布操作之前，你应该始终做以下几件事：

* Check the URL where the package will be published.

  检查 package 将被发布到的 URL。

* Review the list of files to be included in the package.

  查看将包含在 package 中的文件列表。

* Consider the package validation recommendations. For example:

  考虑 package 校验建议。例如：

```
$ dart pub publish
Publishing mypkg 1.0.0 to https://dart-packages.example.com
|-- CHANGELOG.md
|-- LICENSE
|-- README.md
|-- lib
|   '-- mypkg.dart
'-- pubspec.yaml
Package validation found the following potential issue:
* It's strongly recommended to include a "homepage" or "repository" field in your pubspec.yaml
...
```


For publishing to custom repositories the recommendations *might not* be important, but providing metadata for a package is often useful. On pub.dev, packages with proper metadata and documentation score more [pub points](https://pub.dev/help/scoring).

对于发布到自定义仓库，这些建议*可能并不*重要，
但为 package 提供元数据通常是有用的。在 pub.dev 上，
元数据和文档完善的 package 能获得更多
[pub 积分](https://pub.dev/help/scoring)。

It’s possible to publish to custom repositories by overriding the *default package repository* using the environment variable `PUB_HOSTED_URL` but, if you do this, it’s strongly recommended that you specify `publish_to: &lt;hosted-url&gt;` in your `pubspec.yaml` file; this prevents you from accidentally publishing your proprietary packages to the public repository. And if you don’t want to publish your proprietary packages to *any* package repository, specify `publish_to: none` to prevent accidental publication.

通过环境变量 `PUB_HOSTED_URL` 覆盖*默认 package 仓库*，
也可以发布到自定义仓库；但如果这样做，强烈建议你在
`pubspec.yaml` 文件中指定 `publish_to: &lt;hosted-url&gt;`，
这能防止你把专有 package 意外发布到公共仓库。
如果你不想把专有 package 发布到*任何* package 仓库，
可以指定 `publish_to: none` 来防止意外发布。

## Get a Custom Package Repository

## 获取自定义 package 仓库

As previously mentioned, custom package repositories are available as a service from multiple commercial vendors, alleviating you from the overhead of hosting and maintaining your own custom package repository.

如前所述，多家商业供应商以服务的形式提供自定义 package 仓库，
让你免于自行托管和维护自定义 package 仓库的开销。

### Token authentication in Cloudsmith

### Cloudsmith 中的令牌认证

Cloudsmith has been offering private and public Dart package repositories since 2020. [Cloudsmith recently announced](https://cloudsmith.com/resources/blog/improvements-to-dart-package-support) support for token authentication with their Dart package repository offering. For more information, check out the [Cloudsmith documentation](https://help.cloudsmith.io/docs/dart-repository).

Cloudsmith 自 2020 年起就提供私有和公共 Dart package 仓库。
[Cloudsmith 最近宣布](https://cloudsmith.com/resources/blog/improvements-to-dart-package-support)
其 Dart package 仓库服务支持令牌认证。更多信息请查看
[Cloudsmith 文档](https://help.cloudsmith.io/docs/dart-repository)。

<DashImage src="images/1hv1Nujq4-g2-y2uLuLYVqA.webp" alt="The Cloudsmith web interface showing a private Dart package repository." caption="A private Dart package repository hosted by Cloudsmith." />


### Dart support in JFrog Artifactory

### JFrog Artifactory 中的 Dart 支持

JFrog Artifactory recently [announced support for custom Dart package repositories](https://jfrog.com/blog/how-to-use-pub-repositories-in-artifactory), including support for layered repositories and mirroring packages from the public package repository on [pub.dev](https://pub.com). For more information, check out the [JFrog Artifactory documentation](https://www.jfrog.com/confluence/display/JFROG/Pub+Repositories).

JFrog Artifactory 最近
[宣布支持自定义 Dart package 仓库](https://jfrog.com/blog/how-to-use-pub-repositories-in-artifactory)，
包括分层仓库以及从 [pub.dev](https://pub.com) 上的公共 package 仓库
镜像 package 的支持。更多信息请查看
[JFrog Artifactory 文档](https://www.jfrog.com/confluence/display/JFROG/Pub+Repositories)。

<DashImage src="images/1JeK8mYxYCn-XoeHUCJlPEg.webp" alt="The JFrog Artifactory web interface showing a custom Dart package repository." caption="A custom Dart package repository managed by JFrog." />


### Closing comments

### 结语

For those who would like to write their own custom package repository, we’ve published a [specification for serving Dart package repositories](https://github.com/dart-lang/pub/blob/master/doc/repository-spec-v2.md). It’s fairly simple, but feel free to open issues on the [pub.dev repository](https://github.com/dart-lang/pub-dev/issues) if aspects are unclear, or if you have any suggestions for improvements.

对于想自己编写自定义 package 仓库的人，我们发布了
[Dart package 仓库服务规范](https://github.com/dart-lang/pub/blob/master/doc/repository-spec-v2.md)。
它相当简单，但如果有不清楚的地方，或有改进建议，
欢迎在 [pub.dev 仓库](https://github.com/dart-lang/pub-dev/issues)
提 issue。