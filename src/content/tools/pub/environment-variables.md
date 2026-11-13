---
# title: Configuring pub environment variables
title: 为 pub 命令配置环境变量
# shortTitle: Pub environment variables
shortTitle: pub 的环境变量
# description: >-
#   How to configure your environment for Dart's package management tool, pub.
description: 如何在你的开发环境里为 Dart 的 package 管理工具 pub 配置环境变量。
showToc: false
ai-translated: true
---

Environment variables allow you to customize pub to suit your needs.

环境变量可以按你的需要定制 pub。

`PUB_CACHE`
: Some of pub's dependencies are downloaded to the pub cache.
  By default, this directory is located under
  `$HOME/.pub-cache` (on macOS and Linux),
  or in `%LOCALAPPDATA%\Pub\Cache` (on Windows). (The precise location of the
  cache might vary depending on the Windows version.)
  You can use the `PUB_CACHE` environment
  variable to specify another location. For more information, see
  [The system package cache](/tools/pub/cmd/pub-get#the-system-package-cache).

  pub 的一部分依赖会下载到 pub 缓存。
  默认情况下，这个目录位于 `$HOME/.pub-cache`（macOS 和 Linux），
  或 `%LOCALAPPDATA%\Pub\Cache` (Windows)。
  （缓存的具体位置可能因 Windows 版本而异。）
  你可以用 `PUB_CACHE` 环境变量指定其他位置。
  更多信息请参阅
  [系统 package 缓存](/tools/pub/cmd/pub-get#the-system-package-cache)。

`PUB_HOSTED_URL`
: Pub downloads dependencies from the [pub.dev site.]({{site.pub}})
  To specify the location of a particular mirror server,
  use the `PUB_HOSTED_URL` environment variable. For example:

  pub 从 [pub.dev 网站]({{site.pub}}) 下载依赖。
  要指定某个镜像服务器的位置，请使用 `PUB_HOSTED_URL` 环境变量。例如：

```bash
PUB_HOSTED_URL = https://pub.example.com
```

For more information about using a private package repository,
see [Overriding the default package repository][].

关于使用私有 package 仓库的更多信息，
请参阅 [覆盖默认 package 仓库][Overriding the default package repository]。

:::note
If you are attempting to use `pub get` behind a corporate firewall
and it fails, 
please see [`pub get` fails from behind a corporate firewall][]
for information on how to set up the proxy environment variables
for your platform.

如果你在公司防火墙后使用 `pub get` 并且失败了，
请参阅 [在公司防火墙后 pub get 失败][`pub get` fails from behind a corporate firewall]，
了解如何为你的平台设置代理环境变量。
:::

[`pub get` fails from behind a corporate firewall]: /tools/pub/troubleshoot#pub-get-fails-from-behind-a-corporate-firewall
[Overriding the default package repository]: /tools/pub/custom-package-repositories#default-override
