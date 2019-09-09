---
title: pub publish
title: pub publish
description: Use pub publish to publish your Dart package to the Pub site.
description: 使用 pub publish 命令将你的 Dart Package 发布到 Pub 网站。
toc: false
---

_Publish_ is one of the commands of the [pub tool](/tools/pub/cmd).

_Publish_ 命令是 [Pub 工具](/tools/pub/cmd) 中的一个命令。

{% prettify nocode %}
$ pub publish [--dry-run] [--force] [--server <url>]
{% endprettify %}

This command publishes your package on the
[Pub site]({{site.pub}}) for anyone to download and depend
on. For information on how to prepare your package for publishing,
and what files you should include or exclude,
see [Publishing packages](/tools/pub/publishing).

该命令用于将你的 Package 发布到 [Pub 网站]({{site.pub}}) 以供其他人下载和依赖。有关如果将你的 Package 发布以及哪些文件可以发布哪些不应该发布的信息请查阅 [发布 Package](/tools/pub/publishing)。

## Options

## 选项

For options that apply to all pub commands, see
[Global options](/tools/pub/cmd#global-options).

你可以查阅 [全局选项](/tools/pub/cmd#global-options) 获取 Pub 命令所支持的命令选项。

### `--dry-run` or `-n`

### `--dry-run` 选项或 `-n` 选项

With this, pub goes through the validation process but does not actually upload
the package. This is useful if you want to see if your package meets all of the
publishing requirements before you're ready to actually go public.

该选项可以让你运行上传 Package 的整个流程但不会真正地上传任何文件到 Pub 网站。此操作可以让你在真正上传到 Pub 网站前检查你的上传等相关配置是否有误。

### `--force` or `-f`

### `--force` 选项或 `-f` 选项

With this, pub does not ask for confirmation before publishing. Normally, it
shows you the package contents and asks for you to confirm the upload.

该选项让 Pub 在上传时不再向你进行确认。正常情况下，它会在你上传时向你显示 Package 的内容以及向你进行确认。

If your package has errors, pub doesn't upload it and exits with an error.
In the event of warnings, your package *is* uploaded.
To ensure that your package has no warnings before uploading,
either don't use `--force`, or use `--dry-run` first.

如果 Package 存在错误，Pub 则会退出且不继续进行上传。如果出现的是警告，则 Package 会依旧被上传。若你想确保你的 Package 在上传前没有警告，请确保不要使用 `--force` 和 `--dry-run` 选项。

### `--server`

If you pass `--server` followed by a URL, it attempts to publish the
package to that server. It assumes the server supports the same HTTP API that
the [Pub site][pubsite] uses.

如果你在 `--server` 选项后加上一个 URL 地址，则在 Package 进行发布的时候会同样地上传到该服务器中。但是服务器需要支持 [Pub 网站][pubsite] 所使用的 HTTP API。

This can be useful if you're running your own local package server for testing.
The main pub server is itself open source and available [here][pub repo].

该选项在你使用你自己的服务器进行测试时会非常有用如果你。主 Pub 服务器本身是开源的你可以在 [这里][pub repo] 找到它。

[pubsite]: {{site.pub}}
[pub repo]: https://github.com/dart-lang/pub-dartlang

<aside class="alert alert-info" markdown="1">
  *Problems?* See [Troubleshooting pub](/tools/pub/troubleshoot).

  **有疑问？** 请查阅 [Pub 疑难协助](/tools/pub/troubleshoot)。
</aside>
