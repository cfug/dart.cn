---
title: pub uploader
title: pub uploader
description: Use pub uploader to add or remove uploaders for your Dart package on the pub.dev site.
description: 使用 pub uploader 命令为你在 pub.dev 网站上的 Dart Package 添加或删除上传者。
toc: false
---

{{site.alert.tip}}

  Instead of specifying uploaders for each package you publish,
  consider using a
  [verified publisher](/tools/pub/verified-publishers).

  除了可以明确指定你发布的每个软件包的发布者之外，
  你还可以考虑使用 [verified publisher](/tools/pub/verified-publishers)。

{{site.alert.end}}

_Uploader_ is one of the commands of the [pub tool](/tools/pub/cmd).

_Uploader_ 命令是 [Pub 工具](/tools/pub/cmd) 中的一个命令。

{% prettify nocode tag=pre+code %}
$ pub uploader [options] {add/remove} <email>
{% endprettify %}

This command allows
[uploaders](/tools/pub/glossary#uploader) of a
package on the [pub.dev site]({{site.pub}}) to add (invite) or remove
other uploaders for that package. It has two sub-commands,
`add` and `remove`, that take the email address of the person to
add/remove as an uploader. For example:

该命令允许 [pub.dev 网站]({{site.pub}})上某个 Package 的 [上传者](/tools/pub/glossary#uploader) 
为该 Package 添加或删除其它的上传者。
其有两个子命令 `add` 和 `remove`，
可以将电子邮件地址作为某个上传者的标识以此来添加或删除上传者。例如：

```terminal
~/code/transmogrify$ pub uploader add bob@example.com
We have sent an invitation to bob@example.com, they will be added as uploader after they confirm it.
// 我们已经向 bob@example.com 发送了一份邀请函，在他/她确认后就会成被加入上传者（权限）

~/code/transmogrify$ pub uploader remove bob@example.com
Successfully removed uploader from package.
// 成功将该上传者从 package 中移除
```

If a package has only one uploader, that uploader can't be removed. You can
remove yourself as an uploader (as long as other uploaders are available),
but you can't re-add yourself again afterwards.

如果 Package 有且只有一个上传者，则该上传者不能再被删除。
你可以将自己从上传者列表中删除（只要 Package 中还有其它的上传者即可），
但是一旦你删除了自己后则不能再将自己添加回去。

By default, the package in the current working directory will have its
uploaders modified. You can also pass the `--package` flag to choose a
package by name. For example:

默认情况下，你修改的是当前工作目录中 Package 的上传者。
你可以通过 `--package` 标识来指定修改哪个 Package 的上传者。例如：

```terminal
$ pub uploader --package=transmogrify add bob@example.com
We have sent an invitation to bob@example.com, they will be added as uploader after they confirm it.
// 我们已经向 bob@example.com 发送了一份邀请函，在他/她确认后就会成被加入上传者（权限）
```

Note that uploaders are identified by their Google accounts, so use a Gmail or
Google Apps email address for any new uploaders.

需要注意的是 Google 账户是上传者的识别标识，
所以请使用 Gmail 或者 Google 应用电子邮件地址作为新上传者的标识。

{{site.alert.important}}

  The `pub uploader add <email>` command sends an invitation that
  the invited user must accept.
  For the invitation to work,
  `<email>` must be the **primary email address** of
  the associated Google account.
  
  通过 `pub uploader add <email>` 命令发送邀请，被邀请的用户必须接受。
  为了使邀请生效，`<email>` 字段必须是被邀请人
  Google 账户的**主要电子邮件地址**。
  
{{site.alert.end}}

## Options

## 选项

For options that apply to all pub commands, see
[Global options](/tools/pub/cmd#global-options).

你可以查阅 [全局选项](/tools/pub/cmd#global-options) 获取 Pub 命令所支持的命令选项。

<aside class="alert alert-info" markdown="1">
  *Problems?* See [Troubleshooting Pub](/tools/pub/troubleshoot).

  **有疑问？** 请查阅 [Pub 疑难协助](/tools/pub/troubleshoot)。
</aside>
