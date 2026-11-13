---
# title: Custom package repositories
title: 自定义 package 仓库
# description: >-
#   How Dart's package management tool, pub,
#   works with custom package repositories.
description: Dart 的 package 管理工具 pub 如何与自定义 package 仓库配合使用。
ai-translated: true
---

The `dart pub` tool supports third-party package repositories.
A package repository is a server that hosts Dart packages
for consumption by the `dart pub` tool.
The default package repository used, [pub.dev]({{site.pub}}), 
is operated by the Dart team to 
facilitate publication of Dart packages for public use.
A package repository is identified by a
_hosted-url_, such as `https://dart-packages.example.com/`.

`dart pub` 工具支持第三方 package 仓库。
package 仓库是一台服务器，托管 Dart package，供 `dart pub` 工具使用。
默认使用的 package 仓库是 [pub.dev]({{site.pub}})，
由 Dart 团队运营，方便公开发布 Dart package。
package 仓库由 **hosted-url** 标识，
例如 `https://dart-packages.example.com/`。

Sometimes a custom package repository might be useful
for hosting private packages,
including in some of the following scenarios:

有时，自定义 package 仓库适合用来托管私有 package，
例如下面这些场景：

1. Sharing internal proprietary packages within an organization.

   在组织内部共享专有 package。

2. Tight control of dependencies in enterprise environments.

   在企业环境中严格控制依赖。

3. Secure environments without public internet access.

   无法访问公共互联网的安全环境。

It's also common to use [git-dependencies](/tools/pub/dependencies#git-packages) 
for hosting private packages, however, 
the `dart pub` tool doesn't support resolving versions against a git repository; 
it just fetches a specific revision of the git repository.
Therefore, when many people are collaborating
it's often preferable to use a private package repository.

用 [Git 依赖](/tools/pub/dependencies#git-packages) 托管私有 package 也很常见，
不过 `dart pub` 工具不能针对 git 仓库解析版本，
它只会获取该 git 仓库的某个特定修订版。
因此，当很多人协作时，通常更适合使用私有 package 仓库。

## Authenticating with a custom package repository {:#token-authentication}

## 向自定义 package 仓库进行身份验证

Most custom package repositories are
private package repositories that require authentication.
To authenticate against custom package repositories,
the `dart pub` tool attaches a secret token to the requests.

大多数自定义 package 仓库都是需要身份验证的私有 package 仓库。
向自定义 package 仓库验证身份时，
`dart pub` 工具会在请求中附上密钥令牌。

You can obtain the secret token from your custom package repository
and either specify it manually or through an environment variable.
To manually specify the secret token,
use the `dart pub token add` command
which prompts for the token:

你可以从自定义 package 仓库获取密钥令牌，
然后手动指定，或者通过环境变量提供。
要手动指定密钥令牌，请使用 `dart pub token add` 命令，
它会提示你输入令牌：

```console
$ dart pub token add https://dart-packages.example.com
Enter secret token: [enter secret token]
Requests to "https://dart-packages.example.com" will now be authenticated using the secret token.
```

You can also tell `dart pub` to read the token from an environment variable,
including in a CI environment, with the `--env-var` flag:

你也可以用 `--env-var` 标志让 `dart pub` 从环境变量读取令牌，
在 CI 环境中同样适用：

```console
$ dart pub token add https://dart-packages.example.com --env-var MY_SECRET_TOKEN
Requests to "https://dart-packages.example.com" will now be authenticated using the secret token stored in the environment variable "MY_SECRET_TOKEN".
```

This ensures that `dart pub` doesn't actually 
store the secret token in its configuration, 
instead it merely stores the fact that it
should read the secret from the environment variable `$MY_SECRET_TOKEN`. 
This reduces the risk that secrets are accidentally leaked
if the execution environment is shared between CI jobs.

这样 `dart pub` 实际上不会把密钥令牌写入自己的配置，
它只记录应当从环境变量 `$MY_SECRET_TOKEN` 读取密钥。
如果多个 CI 任务共享同一执行环境，这样可以降低密钥意外泄漏的风险。

:::note
When the `dart pub` tool doesn't have a token for a given repository URL,
it attempts to make requests without authentication.

当 `dart pub` 工具没有某个仓库 URL 对应的令牌时，
它会尝试不带身份验证发出请求。
:::


## Retrieving dependencies from a custom package repository

## 从自定义 package 仓库获取依赖

To fetch a package from custom package repository,
you must specify the _hosted-url_ for the package in `pubspec.yaml`, 
using the syntax for [hosted packages](/tools/pub/dependencies#hosted-packages).
For example:

要从自定义 package 仓库获取 package，
必须在 `pubspec.yaml` 中为该 package 指定 **hosted-url**，
语法与 [托管 package](/tools/pub/dependencies#hosted-packages) 相同。例如：

```yaml
dependencies:
  example_package:
    hosted: https://dart-packages.example.com
    version: ^1.4.0
```

In the previous example, `package:example_package` 
is fetched from `https://dart-packages.example.com`. 
If authentication is required by this package repository, 
see [Authenticating with a custom package repository](#token-authentication)
for more information on how to authenticate your requests.

在上面的例子中，`package:example_package` 会从
`https://dart-packages.example.com` 获取。
如果这个 package 仓库需要身份验证，
请参阅 [向自定义 package 仓库进行身份验证](#token-authentication)，
了解如何为请求完成验证。

You can also use the `dart pub add` command
with the `--hosted` flag to add a dependency from a custom package repository:

也可以使用 `dart pub add` 命令配合 `--hosted` 标志，
从自定义 package 仓库添加依赖：

```console
$ dart pub add example_package --hosted https://dart-packages.example.com
```

### Using multiple package repositories

### 使用多个 package 仓库

You can also fetch different dependencies
from different package repositories, 
as the _hosted-url_ can be specified for each dependency:

你也可以从不同的 package 仓库获取不同的依赖，
因为每一项依赖都可以单独指定 **hosted-url**：

```yaml
dependencies:
  # package retry is fetched from pub.dev (the default package repository)
  retry: ^3.0.0
  # package example_package is fetched from https://dart-packages.example.com
  example_package:
    hosted: https://dart-packages.example.com
    version: ^1.4.0
```

This enables you to keep private packages on a private package repository
while using the most up-to-date public packages as dependencies. 

这样你就可以把私有 package 放在私有 package 仓库里，
同时把最新的公开 package 用作依赖。

However, conflicts can easily arise if your dependencies require
a package with the same name from different repositories.
For example, if package `retry` requires `meta` from pub.dev, 
and `example_package` requires `meta` from `https://dart-packages.example.com`.
Therefore, if mirroring any packages into a private package repository 
it's often necessary to mirror all dependencies
and either update the `dependencies` section of each package, 
or [override the default package repository](#default-override).

不过，如果各项依赖要求同名 package 来自不同仓库，就很容易发生冲突。
例如，package `retry` 需要来自 pub.dev 的 `meta`，
而 `example_package` 需要来自 `https://dart-packages.example.com` 的 `meta`。
因此，如果要把某些 package 镜像到私有 package 仓库，
通常需要镜像全部依赖，并更新每个 package 的 `dependencies` 部分，
或者 [覆盖默认 package 仓库](#default-override)。

:::note
To ensure that public packages are usable to everyone, 
the official package repository, [pub.dev]({{site.pub}}),
doesn't allow publication of packages
with git-dependencies or hosted-dependencies from custom package repositories.

However, such packages can be published to a custom package repository.

为了保证公开 package 对所有人可用，
官方 package 仓库 [pub.dev]({{site.pub}}) 不允许发布
带有 Git 依赖，或带有来自自定义 package 仓库的托管依赖的 package。

不过，这类 package 可以发布到自定义 package 仓库。
:::


## Publishing to a custom package repository

## 发布到自定义 package 仓库

To publish a package to a custom package repository
instead of [pub.dev]({{site.pub}}),
specify the 
[`publish_to`](/tools/pub/pubspec#publish_to) property in `pubspec.yaml`.
If authentication is enabled,
publishing uses the same [token authentication](#token-authentication)
as retrieving packages.

要把 package 发布到自定义 package 仓库而不是 [pub.dev]({{site.pub}})，
请在 `pubspec.yaml` 中指定
[`publish_to`](/tools/pub/pubspec#publish_to) 属性。
如果启用了身份验证，发布时使用的
[令牌验证](#token-authentication) 与获取 package 时相同。

:::note
To prevent accidental publication to [pub.dev]({{site.pub}})
when working on a private package, 
it's a good idea to specify this early in the development.

开发私有 package 时，为了避免意外发布到 [pub.dev]({{site.pub}})，
最好在开发早期就写上这项配置。
:::

To prepare a package for publishing to `https://dart-packages.example.com`,
your `pubspec.yaml` should look minimally like the following:

要把 package 准备发布到 `https://dart-packages.example.com`，
`pubspec.yaml` 至少应类似下面这样：

```yaml
name: example_package
version: 1.0.0
# Ensures the package is published to https://dart-packages.example.com
publish_to: https://dart-packages.example.com
```

To then publish a new version of the package,
use `dart pub publish`:

随后要发布该 package 的新版本，请使用 `dart pub publish`：

```console
$ dart pub publish
Publishing example_package 1.0.0 to https://dart-packages.example.com
|-- CHANGELOG.md
|-- LICENSE
|-- README.md
|-- lib
|   '-- example_package.dart
'-- pubspec.yaml
...
```

:::note
Even if you aren't using a private repository, 
you can specify `publish_to: none` 
which stops any accidental publication.

即使你没有使用私有仓库，
也可以指定 `publish_to: none`，从而阻止任何意外发布。
:::


### Overriding the default package repository {:#default-override}

### 覆盖默认 package 仓库

By default, `dart pub` retrieves dependencies from and publishes packages
to the [pub.dev site]({{site.pub}})
unless the hosted-dependency syntax
is used to specify a custom package repository.
However, you can override the default package repository using the
[`PUB_HOSTED_URL`](/tools/pub/environment-variables) environment variable.

默认情况下，`dart pub` 从 [pub.dev 网站]({{site.pub}}) 获取依赖，
也把 package 发布到那里，
除非使用托管依赖语法指定了自定义 package 仓库。
不过，你可以用 [`PUB_HOSTED_URL`](/tools/pub/environment-variables)
环境变量覆盖默认 package 仓库。

This approach is particularly useful when mirroring all packages
in a private package repository or a subset of pub.dev
when working in a restricted network environment.

在受限网络环境中，把全部 package 或 pub.dev 的一个子集
镜像到私有 package 仓库时，这种方式特别有用。


## Setting up a custom package repository

## 搭建自定义 package 仓库

You can write a custom package repository by implementing
the REST API outlined in the
[Hosted Pub Repository Specification Version 2][repository-spec-v2.md].

你可以实现
[Hosted Pub Repository Specification Version 2][repository-spec-v2.md]
中描述的 REST API，从而编写自己的自定义 package 仓库。

### Dart package repositories as a service

### 作为服务提供的 Dart package 仓库

Custom package repositories are also offered as a service
with support for token authentication by multiple vendors,
alleviating you from the overhead of hosting and maintaining
your own custom package repository:

多家供应商也以服务的形式提供自定义 package 仓库，并支持令牌身份验证，
这样你就不必自己承担托管和维护自定义 package 仓库的成本：

<ul class="logo-link-grids">
<li>
  <a href="https://help.cloudsmith.io/docs/dart-repository">
    <img src="/assets/img/tools/cloudsmith.svg" alt="Cloudsmith logo">
    <span>Cloudsmith</span>
  </a>
</li>
<li>
  <a href="https://docs.inedo.com/docs/proget/feeds/pub">
    <img src="/assets/img/tools/proget.svg" alt="Inedo ProGet logo">
    <span>Inedo ProGet</span>
  </a>
</li>
<li>
  <a href="https://www.jfrog.com/confluence/display/JFROG/Pub+Repositories">
    <img src="/assets/img/tools/jfrog.svg" alt="JFrog logo">
    <span>JFrog Artifactory</span>
  </a>
</li>
<li>
  <a href="https://onepub.dev">
    <img src="/assets/img/tools/onepub.svg" alt="OnePub logo">
    <span>OnePub Dart Repository</span>
  </a>
</li>
<li>
  <a href="https://publy.dev/docs/getting-started">
    <img src="/assets/img/tools/publy.svg" alt="Publy logo">
    <span>Publy</span>
  </a>
</li>
<li>
  <a href="https://glpub.dev/">
    <img src="/assets/img/tools/glpub.png" alt="GLPub logo">
    <span>GLPub.dev</span>
  </a>
</li>
</ul>


[repository-spec-v2.md]: {{site.repo.dart.org}}/pub/blob/master/doc/repository-spec-v2.md
