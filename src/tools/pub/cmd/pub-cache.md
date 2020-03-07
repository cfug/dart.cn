---
title: pub cache
title: pub cache
description: Use pub cache to manage your system cache.
description: 使用 pub cache 命令管理你系统中的缓存。
toc: false
---

_Cache_ is one of the commands of the [pub tool](/tools/pub/cmd).

_Cache_ 命令是 [Pub 工具](/tools/pub/cmd) 中的一个命令。

```
$ pub cache add <package> [--version <constraint>] [--all]
$ pub cache repair
```

The `pub cache` command works with the
[system cache](/tools/pub/glossary#system-cache).
To add new packages to your cache, use `pub cache add`.
To perform a clean reinstall of the packages in your system cache,
use `pub cache repair`.

`pub cache` 命令用于操作 [Pub 位于系统中的缓存](/tools/pub/glossary#system-cache)。你可以使用 `pub cache add` 命令将新的 Package 添加至缓存。也可以使用 `pub cache repair` 命令将 Package 从缓存中清除并重新安装。

## Options

## 选项

For options that apply to all pub commands, see
[Global options](/tools/pub/cmd#global-options).

你可以查阅 [全局选项](/tools/pub/cmd#global-options) 获取 Pub 命令所支持的命令选项。

<dl>
<dt><code>add &lt;package&gt;</code></dt>
<dd>Installs a library in your cache.</dd>

<dd>在你的缓存中安装一个库。</dd>

<dt><code>--all</code></dt>
<dd>Optional. Use with <code>pub add</code> to install all
matching versions of a library.</dd>

<dd>可选的选项。与 <code>pub add</code> 结合使用用于安装某个库的所有版本。</dd>

<dt><code>--version &lt;constraint&gt;</code></dt>
<dd>Optional. Use with <code>pub add</code> to install the best
version matching the specified constraint. For example:

<dd>可选的选项。与 <code>pub add</code> 结合使用根据限制条件安装最适合的版本。例如：

{% prettify nocode tag=pre+code %}
$ pub cache add barback --version "<=0.8.0 <0.110"
{% endprettify %}

If <code>--version</code> is omitted, pub installs the best of all known
versions.</dd>

如果省略掉 <code>--version</code>，Pub 会从已知的版本中挑选一个最适合的进行安装。

<dt><code>repair</code></dt>
<dd>It's possible for packages in your pub cache to change or break.
For example, some editors make it easy to find implementation files for
packages in the pub cache, and you might accidentally edit one of those files.
The <code>pub cache repair</code> command performs a clean reinstall of all
hosted and git packages in the system cache.</dd>

<dd>你 Pub 缓存中的 Package 是有可能被修改或破坏的。例如，某些编辑器可以轻松地在 Pub 缓存中找到 Package 的实现文件，而你也许会对这些文件进行修改导致它们与原本的逻辑不一致。pub cache repair 命令可以对系统缓存中的所有 Package 执行重安装以修正篡改的问题。</dd>

<aside class="alert alert-info" markdown="1">
  *Problems?* See [Troubleshooting Pub](/tools/pub/troubleshoot).

  **有疑问？** 请查阅 [Pub 疑难协助](/tools/pub/troubleshoot)。
</aside>
