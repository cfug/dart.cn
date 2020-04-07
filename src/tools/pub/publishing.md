---
title: Publishing packages
title: 发布 package
description: Learn how to publish a Dart package to pub.dev.
description: 学习如何将 Dart package 发布到 pub.dev 网站。
---

[The pub package manager][pub] isn't just for using other people's packages.
It also allows you to share your packages with the world. If you have a useful
project and you want others to be able to use it, use the `pub publish`
command.

[ Pub 包管理工具][pub] 并不仅仅用于使用其他人开发的 Package ，它同样允许你向全世界分享自己制作的 Package 。如果你有一个有用的项目，而且希望别人能够用到它，使用 `pub publish` 命令。

{{site.alert.note}}

  To publish to a location other than pub.dev,
  or to prevent publication anywhere, use the `publish_to` field,
  as defined in the [pubspec][].

  发布到非 pub.dev 的其它位置，或者不在任何地方发布，使用 `publish_to` 参数，也可在 [pubspec][] 中设置。

{{site.alert.end}}

## Publishing is forever

## 发布是永久的

Keep in mind that publishing is forever. As soon as you publish your package,
users can depend on it. Once they start doing that, removing
the package would break theirs. To avoid that, the [pub.dev policy][policy]
disallows unpublishing packages except for very few cases.

切记，发布的 Package 将会永久存在。只要你发布了你的 Package ，用户就能依赖它。一旦他们开始这样做，移除 Package 的行为将破坏他们的项目。为了避免此类破坏发生，除了极少数情况， [ pub.dev 政策][policy] 不允许撤回已经发布的 Package 。

You can always upload new versions of your package, but
old ones will continue to be available for users that aren't ready to
upgrade yet.

你可以一直上传自己 Package 的新版本，但是旧版本对于那些尚未准备好升级的用户仍然可用。

For already published packages that are no longer relevant or being maintained,
you can [mark them as discontinued](#discontinue).

对于那些已经发布，但不再相关或不再维护的 Package ，你可以 [把他们标记为终止](#discontinue) 。

## Preparing to publish

## 准备发布

When publishing a package, it's important to follow the [pubspec
format][pubspec] and
[package layout conventions][].
Some of these are required in order for others to be able to use your package.
Others are suggestions to help make it easier for users to understand and work
with your package. In both cases, pub tries to help you by pointing out what
changes will help make your package play nicer with the Dart ecosystem. There
are a few additional requirements for uploading a package:

发布一个 Package 时，遵守 [ pubspec 格式][pubspec] 和 [ Package 布局惯例][] 很重要。
为了其它人能够使用你的 Package ，其中有些要求是必须的，其它则是一些有助于用户能更好的理解和使用的建议。无论是哪些， pub 都会指出什么样的改变能让你的 Package 在 Dart 生态系统中展现的更好。对于上传 Package 有一些额外的要求：

* You must include a `LICENSE` file
  that contains an [open-source license.][open-source license]
  We recommend the [BSD license,][BSD license]
  which is used by Dart itself. You must also have the legal right to
  redistribute anything that you upload as part of your package.

  你必须带有一个包含 [开源许可证][open-source license] 的 `LICENSE` 文件。
  我们推荐 [ BSD 许可证][BSD license] ，也就是 Dart 自身所使用的开源许可证。同时，对于你所上传的 Package 的任意部分，你必须拥有重新发布的合法权利。

* Your package must be less than 10 MB large after gzip compression. If
  it's too large, consider splitting it into multiple packages, or cutting down
  on the number of included resources or examples.

  通过 gzip 压缩后，你的 Package 大小必须小于 10 MB 。如果它所占空间过大，考虑将它分割为几个小的 Package ，或者减少包含资源或实例的数量。

* Your package should depend only on hosted dependencies (from the default pub
  package server) and SDK dependencies (`sdk: flutter`). These restrictions
  ensure that dependencies of your packages cannot become unavailable in the
  future.

  你的 Package 应该仅依赖于已被托管的依赖项（来自默认的 pub 包服务）和属于 SDK 的依赖项（`sdk: flutter`）。这些限制条件确保了你的 Package 的依赖项在未来依然可用。

* You must have a [Google Account,][Google Account]
  which pub uses to manage package upload permissions.
  Your Google Account can be associated with a Gmail address or
  with any other email address.

  你必须有一个 [ Google 账户][Google Account]， pub 将使用它来管理 Package 更新权限。
  你的 Google 账户可以与 Gmail 或其他任何邮箱地址关联。

{{site.alert.note}}
  
  Unless you publish using a [verified publisher][],
  **pub.dev displays the email address associated with your Google Account.**

  除非你的发布使用了 [已验证发布者][]，** pub.dev 将展示与你 Google 账户关联的邮箱**

{{site.alert.end}}

### Important files

### 重要的文件

Pub uses the contents of a few files to create a page for your
package at `pub.dev/packages/<your_package>`. Here are the files that
affect how your package's page looks:

Pub 使用几个文件的内容来创建你的 Package 在 `pub.dev/packages/<your_package>` 的页面。以下就是会影响你的 Package 页面效果的文件：

* **README.md:** The `README.md` file
  is the main content featured in your package's page.
  The file's contents are rendered as [Markdown.][Markdown]

  **README.md:** `README.md` 文件是你的 Package 页面主要组成部分。
  这个文件的内容将会以 [Markdown][Markdown] 格式渲染。

* **CHANGELOG.md:** Your package's `CHANGELOG.md` file, if found,
  is also featured in a tab on your package's page,
  so that developers can read it right from pub.dev.
  The file's contents are rendered as [Markdown.][Markdown]

  **CHANGELOG.md:** 如果你的 Package 的 `CHANGELOG.md` 文件存在，同样会作为 Package 页面的一个选项卡展示。开发者可通过 pub.dev 阅读它。
  这个文件的内容将会以 [Markdown][Markdown] 格式渲染。

* **The pubspec:** Your package's `pubspec.yaml` file is used to fill out
  details about your package on the right side of your package's page, like its
  description, homepage, etc.

  **The pubspec:** 你的 Package 的 `pubspec.yaml` 文件被用于填写关于 Package 本身的细节，例如它的描述，主页等等。这些信息将被展现在 Package 页面的右侧。

### Advantages of using a verified publisher {#verified-publisher}

### 使用已验证发布者的优点 {#verified-publisher}

You can publish packages using either a verified publisher (recommended)
or an independent Google Account.
Using a verified publisher has the following advantages:

你可以使用已验证发布者（推荐）或一个独立的 Google 账户来发布 Package 。
使用已验证发布者有以下几个优点：

* The consumers of your package know that the publisher domain has been verified.

  你的 Package 的使用者知道发布者域名已经过验证。

* You can avoid having pub.dev display your personal email address.
  Instead, pub.dev displays displays the publisher domain and contact address.

  你能够避免让 pub.dev 展示你的个人邮箱。
  pub.dev 将展示发布者域名和联系地址作为代替。

* A verified publisher badge {% asset verified-publisher.svg
  alt="pub.dev verified publisher logo" %} is displayed next to your package name
  on both search pages and individual package pages.

  一个已验证发布者徽章 {% asset verified-publisher.svg
  alt="pub.dev verified publisher logo" %} 将在你的 Package 名字旁边展示，不论是在搜索页面还是单独的 Package 页面。

### Creating a verified publisher {#create-verified-publisher}

### 创建一个已验证发布者 {#create-verified-publisher}

To create a verified publisher, follow these steps:

想要创建一个已验证发布者，跟随以下步骤：

1. Go to [pub.dev.]({{site.pub}})

   访问 [pub.dev]({{site.pub}})。

1. Log in to pub.dev using a Google Account.

   用一个 Google 账户登录 pub.dev 。

1. In the user menu in the top-right corner, select **Create Publisher**.

   在右上角的用户菜单中，选择 **创建发布者**。

1. Enter the domain name that you want to associate with your publisher (for example,
   `dart.dev`), and click **Create Publisher**.

   输入你想要与发布者关联的域名（例如，`dart.dev`），然后点击 **创建发布者**。

1. In the confirmation dialog, select **OK**.

   在确认弹框中，选择 **好**。

1. If prompted, complete the verification flow, which opens the [Google
   Search Console.](https://search.google.com/search-console/about)
   * When adding DNS records, it may take a few hours before the Search Console
   reflects the changes.
   * When the verification flow is complete, return to step 4.

   如果收到提示，在打开的 [ Google 搜索控制台](https://search.google.com/search-console/about) 中完成确认流程。
   * 添加 NDS 记录，可能需要几个小时让搜索控制台确认改动。
   * 确认流程完成后，返回第四步。

## Publishing your package

## 发布你的 Package 

Use the [pub publish][] command to publish your package for the first time,
or to update it to a new version.

使用 [pub publish][] 命令来首次发布你的 Package ，或者把它升级到一个新版本。

### Performing a dry run

### 演示一次试运行

To test how `pub publish` will work, you can perform a dry run:

为了测试 `pub publish` 命令会如何工作，你可以演示一次试运行（不会真的发布，只显示效果）：

```terminal
$ pub publish --dry-run
```

Pub makes sure that your package follows the
[pubspec format][pubspec] and
[package layout conventions][],
and then uploads your package to [pub.dev.]({{site.pub}}) Pub also shows you all of
the files it intends to publish. Here's an example of publishing a package
named `transmogrify`:

Pub 会确认你的 Package 符合 [ pubspec 格式][pubspec] 和 [ Package 布局惯例][] ，然后把你的 Package 上传至 [pub.dev]({{site.pub}})。 Pub 也会提前向你展示所有准备发布的文件。如下是一个发布名为 `transmogrify` 的 Package 的例子：

{:.console-output}
```nocode
Publishing transmogrify 1.0.0
    .gitignore
    CHANGELOG.md
    README.md
    lib
        transmogrify.dart
        src
            transmogrifier.dart
            transmogrification.dart
    pubspec.yaml
    test
        transmogrify_test.dart

Package has 0 warnings.
```

### Publishing

### 发布

When you're ready to publish your package, remove the `--dry-run` argument:

当你已经准备好发布你的 Package 后，移除 `--dry-run` 参数：

```terminal
$ pub publish
```

{{site.alert.note}}

  The `pub` command currently doesn't support publishing a new package directly to a
  verified publisher. As a temporary workaround, publish new packages to a Google Account,
  and then [transfer the package to a publisher](#transferring-a-package-to-a-verified-publisher).

  `pub` 命令目前不支持把一个新的 Package 直接发布至已验证发布者。作为一个临时空间，先把新的 Package 发布至一个 Google 账户，然后再 [把 Package 转移至已验证发布者](#transferring-a-package-to-a-verified-publisher)。

  Once a package has been transferred to a publisher,
  you can update the package using `pub publish`.

  一旦这个 Package 被转移到已验证发布者，你就可以通过 `pub publish` 命令来更新它。

{{site.alert.end}}

After your package has been successfully uploaded to pub.dev, any pub user can
download it or depend on it in their projects. For example, if you just
published version 1.0.0 of your `transmogrify` package, then another Dart
developer can add it as a dependency in their `pubspec.yaml`:

在你的 Package 成功上传至 pub.dev 之后，任何 pub 用户都能够下载或在他们的项目中依赖它。例如，如果你刚刚发布了你的  `transmogrify` Package 1.0.0 版本，那么另一个 Dart 开发者将可以把它作为一项依赖添加到 `pubspec.yaml` 文件中：

```yaml
dependencies:
  transmogrify: ^1.0.0
```

### Transferring a package to a verified publisher

To transfer a package to a verified publisher,
you must be an [uploader](#uploaders) for the package
and an admin for the verified publisher.

{{site.alert.note}}
  This process isn't reversible. Once you transfer a package to a publisher,
  you can't transfer it back to an individual account.
{{site.alert.end}}

Here's how to transfer a package to a verified publisher:

1. Log in to [pub.dev]({{site.pub}}) with a Google Account that's listed as
   an uploader of the package.
1. Go to the package details page (for example,
   `{{site.pub-pkg}}/http`).
1. Select the **Admin** tab.
1. Enter the name of the publisher, and click **Transfer to Publisher**.


## What files are published?

**All files** in your package are included in the published package, with
the following exceptions:

* Any `packages` directories.
* Your package's [lockfile](/tools/pub/glossary#lockfile).
* If you aren't using Git, all _hidden_ files (that is,
  files whose names begin with `.`).
* If you're using Git, any files ignored by your `.gitignore` file.

{% comment %}
PENDING: Here only to make it easy to find the packages discussion: packages-dir.html
{% endcomment %}

Be sure to delete any files you don't want to include (or add them to
`.gitignore`). `pub publish` lists all files that it's going to publish
before uploading your package,
so examine the list carefully before completing your upload.

## Uploaders

Whoever publishes the first version of a package automatically becomes
the first and only person authorized to upload additional versions of that package.
To allow or disallow other people to upload versions,
use the [pub uploader][] command
or transfer the package to a [verified publisher][].

If a package has a verified publisher,
then the pub.dev page for that package displays the publisher domain.
Otherwise, the page displays the email addresses of
the authorized uploaders for the package.


## Publishing prereleases

As you work on a package, consider publishing it as a prerelease.
Prereleases can be useful when any of the following are true:

* You're actively developing the next major version of the package.
* You want beta testers for the next release candidate of the package.
* The package depends on an unstable version of the Dart or Flutter SDK.

As described in [semantic versioning,][semver] to make a prerelease of a version
you append a suffix to the version. For example, to make a prerelease of
version `2.0.0` you might use the version `2.0.0-dev.1`. Later, when you
release version `2.0.0`, it will take precedence over all `2.0.0-XXX` prereleases.

Because pub prefers stable releases when available, users of a prerelease package
might need to change their dependency constraints.
For example, if a user wants to test prereleases of version 2.1, then
instead of `^2.0.0` or `^2.1.0` they might specify `^2.1.0-dev.1`.

{{site.alert.note}}
  If a stable package in the dependency graph depends on a prerelease,
  then pub chooses that prerelease instead of a stable release.
{{site.alert.end}}

When a prerelease is published to pub.dev,
the package page displays links to both the prerelease and the stable release.
The prerelease doesn't affect the analysis score, show up in search results,
or replace the package `README.md` and documentation.


## Marking packages as discontinued {#discontinue}

Although packages always remain published, it can be useful to signal to
developers that a package is no longer being actively maintained.
For this, you can mark a package as **discontinued**.
A discontinued package remains published and viewable on pub.dev,
but it has a clear **DISCONTINUED** badge and
doesn't appear in pub.dev search results.

To mark a package as discontinued, sign in to pub.dev using a Google Account
that's an uploader or verified publisher admin for the package.
Then use the **Admin** tab of the individual package to mark the package as
discontinued.

## Resources

For more information, see the reference pages for the following `pub` commands:

* [pub publish][]
* [pub uploader][]

[BSD license]: https://opensource.org/licenses/BSD-3-Clause
[Google Account]: https://support.google.com/accounts/answer/27441
[Markdown]: {{site.pub-pkg}}/markdown
[open-source license]: https://opensource.org/
[package layout conventions]: /tools/pub/package-layout
[policy]: https://pub.dev/policy
[pub]: /guides/packages
[pub publish]: /tools/pub/cmd/pub-lish
[pub uploader]: /tools/pub/cmd/pub-uploader
[pubspec]: /tools/pub/pubspec
[semver]: https://semver.org/spec/v2.0.0-rc.1.html
[verified publisher]: /tools/pub/verified-publishers

