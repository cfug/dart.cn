---
title: pub uploader
title: pub uploader
description: Use pub uploader to add or remove uploaders for your Dart package on the Pub site.
description: 使用 pub uploader 命令为你在 Pub 网站上的 Dart Package 添加或删除上传者。
toc: false
---

_Uploader_ is one of the commands of the [pub tool](/tools/pub/cmd).

_Uploader_ 命令是 [Pub 工具](/tools/pub/cmd)中的一个命令。

{% prettify nocode %}
$ pub uploader [options] {add/remove} <email>
{% endprettify %}

This command allows
[uploaders](/tools/pub/glossary#uploader) of a
package on the [Pub site]({{site.pub}}) to add or remove
other uploaders for that package. It has two sub-commands,
`add` and `remove`, that take the email address of the person to
add/remove as an uploader. For example:

该命令允许 [Pub 网站]({{site.pub}})上某个 Package 的[上传者](/tools/pub/glossary#uploader)为该 Package 添加或删除其它的上传者。其有两个子命令 `add` 和 `remove`，可以将电子邮件地址作为某个上传者的标识以此来添加或删除上传者。例如：

```terminal
~/code/transmogrify$ pub uploader add bob@example.com
'bob@example.com' added as an uploader for package 'transmogrify'.

“bob@example.com” 这个电子邮件的所有者将成为 “transmogrify” 这个 Package 的上传者。

~/code/transmogrify$ pub uploader remove bob@example.com
'bob@example.com' is no longer an uploader for package 'transmogrify'.

“bob@example.com” 这个电子邮件的所有者不再是 “transmogrify” 这个 Package 的上传者。
```

If a package has only one uploader, that uploader can't be removed. You may
remove yourself as an uploader (as long as other uploaders are available),
but you won't be able to re-add yourself again afterwards.

如果 Package 有且只有一个上传者，则该上传者不能再被删除。你可以将自己从上传者列表中删除（只要 Package 中还有其它的上传者即可），但是一旦你删除了自己后则不能再将自己添加回去。

By default, the package in the current working directory will have its
uploaders modified. You can also pass the `--package` flag to choose a
package by name. For example:

默认情况下，你修改的是当前工作目录中 Package 的上传者。你可以通过 `--package` 标识来指定修改哪个 Package 的上传者。例如：

```terminal
$ pub uploader --package=transmogrify add bob@example.com
'bob@example.com' added as an uploader for package 'transmogrify'.
“bob@example.com” 这个电子邮件的所有者将成为 “transmogrify” 这个 Package 的上传者。
```

Note that uploaders are identified by their Google accounts, so use a Gmail or
Google Apps email address for any new uploaders.

需要注意的是 Google 账户是上传者的识别标识，所以请使用 Gmail 或者 Google 应用电子邮件地址作为新上传者的标识。

## 选项

For options that apply to all pub commands, see
[Global options](/tools/pub/cmd#global-options).

你可以查阅[全局选项](/tools/pub/cmd#global-options)获取 Pub 命令所支持的命令选项。

<aside class="alert alert-info" markdown="1">
  *Problems?* See [Troubleshooting Pub](/tools/pub/troubleshoot).

  *有疑问？* 请查阅 [Pub 疑难协助](/tools/pub/troubleshoot)。
</aside>
