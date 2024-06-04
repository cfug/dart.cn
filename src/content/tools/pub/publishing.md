---
# title: Publishing packages
title: 发布 package
# description: Learn how to publish a Dart package to pub.dev.
description: 学习如何将 Dart package 发布到 pub.dev 网站。
---

[The pub package manager][pub] isn't just for using other people's packages.
It also allows you to share your packages with the world. If you have a useful
project and you want others to be able to use it, use the `dart pub publish`
command.

[Pub package 管理工具][pub] 不但可以让你使用其他人开发的 package，
而且能向全世界分享你自己制作的 package。如果你有一个有用的项目，
且希望别人能够用到它，请使用 `dart pub publish` 命令。

:::note

To publish to a location other than pub.dev,
or to prevent publication anywhere, use the `publish_to` field,
as defined in the [pubspec][].

发布到除 pub.dev 以外的其他位置，或者不在任何地方发布，
使用 `publish_to` 参数，相当于在 [pubspec][] 中定义。

:::

Watch the following video for an overview of building and publishing packages.

观看下面的视频以了解构建和发布 package 的基本流程。

<iframe
  {{yt.std-size}}
  src="{{yt.embed}}/8V_TLiWszK0"
  title="Learn how to build and publish Dart packages"
  {{yt.set}}>
</iframe>

## Remember: Publishing is forever

## 请记住：发布是永久的

Keep in mind that a published package lasts forever.
As soon as you publish your package, users can depend on it.
Once they start depending on it, removing the package would break theirs.
To avoid that, the [pub.dev policy][policy]
disallows unpublishing packages except for very few cases.

切记，发布过的 package 将会永久存在。
只要你发布了你的 package，用户就能依赖它。
而依赖关系一旦建立，移除 package 将破坏他们的项目。
为了避免这种事发生，除了极少数情况，
[pub.dev 政策][policy] 不允许撤回已经发布的 package。

You can always upload new versions of your package,
but old ones remain available for users that can't upgrade yet.

你可以一直上传 package 的新版本，
但是旧版本对于那些尚未准备好升级的用户仍然可用。

For published packages that have lost relevance or lack maintainance,
[mark them as discontinued](#discontinue).

对于那些已经发布，但不再相关或不再维护的 package，
你可以 [把他们标记为终止](#discontinue)。

## Prepare your package for publication

## 准备发布你的 package

When publishing a package, follow the conventions found in the
[pubspec format][pubspec] and [package layout][pkg-layout] structure.
To simplify using your package, Dart requires these conventions.
These conventions contain some exceptions noted on the linked guides.
When invoked, `pub` points out what changes you can make so your package
works better within the Dart ecosystem.

发布一个 package 时，请遵守 [pubspec 格式][pubspec] 和
[package 的文件结构][pkg-layout] 中的规范。
为了简化 package 的使用，Dart 需要这些规范。
这些规范中还存在一些例外的情况，详情请查阅这两个规范中的内容。
当调用发布命令时，`pub` 会提示你可以做出的更改，
以便帮助你的 package 在 Dart 生态系统中更好地展现。

Beyond these conventions, you must follow these requirements:

除了这些规范以外，你还必须遵守以下要求：

* Include a `LICENSE` file in your package.
  We recommend the [BSD 3-clause license][],
  which the Dart and Flutter teams typically use.
  However, you can use any license appropriate for your package.

  你的 package 必须包含一个 `LICENSE` 文件。
  我们推荐 [BSD 3-clause 许可证][BSD 3-clause license]，
  也就是 Dart 和 Flutter 团队通常所使用的许可证。
  当然，你也可以使用任何适合你 package 的许可证。

* Verify that you have the legal right to redistribute anything that
  you upload as part of your package.

  对于你所上传的 package 任意部分，你必须拥有重新分发的合法权利。

* Keep package size to less than 100 MB after gzip compression.
  If it's too large, consider splitting it into multiple packages,
  using a `.pubignore` file to remove unnecessary content,
  or cutting down on the number of included resources or examples.

  通过 gzip 压缩后，你的 package 必须小于 100 MB。
  如果它所占空间过大，请考虑将它分割为多个小的 package，
  使用 `.pubignore` 移除不需要的文件，或者减少包含的资源或示例的数量。

* Have your package depend only on hosted dependencies
  from the default pub package server and SDK dependencies
  (`sdk: flutter`).
  These restrictions ensure that dependencies of your packages
  can be found and accessed in the future.

  让你的 package 仅依赖于来自默认的 pub package 服务托管的依赖项
  和属于 SDK 的依赖项（`sdk: flutter`）。
  这些限制条件确保了 package 的依赖项在未来依然可用。

* Own a [Google Account][]. Pub uses a Google account to manage package
  upload permissions. Your Google Account can be associated with
  a Gmail address or any other email address.

  你必须拥有一个 [Google 账户][Google Account]，
  Pub 将使用 Google 账户来管理 package 的上传权限。
  你的 Google 账户可以与 Gmail 或其他任何邮箱地址关联。

### Populate your pub.dev web page

### 完善你的 pub.dev 页面

Pub uses the contents of a few files to create a page for your
package at `pub.dev/packages/<your_package>`.
The following files affect the contents of your package's web page.

Pub 在 `pub.dev/packages/<your_package>` 里，
使用几个文件的内容来创建你的 package 页面。
以下就是会影响到页面内容的几个文件。

**`README.md`**
<br/> This file contains the main content featured in
  your package's web page.
  The file's contents should be marked up using [Markdown][].
  To learn how to write a great README, see
  [Writing package pages](/tools/pub/writing-package-pages).

**`README.md`**
<br/> 该文件是你的 package 页面主要的组成部分。
  文件内容请使用 [Markdown][] 标记语言进行编写。
  要了解如何编写出色的 README，
  请查阅 [编写 package 页面](/tools/pub/writing-package-pages)。

**`CHANGELOG.md`**
<br/> If found, this file populates its own tab on your package's web page.
  Developers can read your changes right from pub.dev.
  The file's contents should be marked up using [Markdown][].

**`CHANGELOG.md`**
<br/> 如果你的 package 存在 `CHANGELOG.md` 文件，
  它就会作为页面的一个选项卡进行展示。
  开发者可通过 pub.dev 直接阅读它的内容。
  文件内容请使用 [Markdown][] 标记语言进行编写。

**`pubspec.yaml`**
<br/> This file populates details about your package
  on the right side of your package's web page.
  The file's contents should follow YAML conventions.
  These details include description, homepage, and the like.

**`pubspec.yaml`**
<br/> 该文件用于完善你的 package 页面详细信息（包括描述、主页等），
  这些信息将被展现在页面的右侧。
  文件内容请遵守 YAML 的规范进行编写。

### Advantages of using a verified publisher {:#verified-publisher}

### 使用已验证发布者的优点

You can publish packages using either a verified publisher (recommended)
or an independent Google Account.
Using a verified publisher has the following advantages:

你可以使用已验证发布者（推荐）或一个独立的 Google 账户来发布 package。
使用已验证发布者有以下几个优点：

* The consumers of your package know that the publisher domain has been verified.

  你 package 的使用者知道发布者域名已经过验证。

* You can avoid having pub.dev display your personal email address.
  Instead, pub.dev displays the publisher domain and contact address.

  你可以避免让 pub.dev 展示你的个人邮箱，pub.dev 将展示发布者域名和联系地址作为代替。

* The pub.dev site displays a verified publisher badge
  <img src="/assets/img/verified-publisher.svg" class="text-icon" alt="pub.dev verified publisher logo">
  next to your package name on search pages and individual package pages.

  一个已验证发布者徽章
  <img src="/assets/img/verified-publisher.svg" width="20" height="20" alt="pub.dev verified publisher logo">
  将在你的 package 名字旁边展示，
  不论是在搜索页面还是单独的 package 页面。

### Create a verified publisher {:#create-verified-publisher}

### 创建一个已验证发布者

To create a [verified publisher][create-verified-publisher], follow these steps:

请按照以下步骤，来创建一个[已验证发布者][create-verified-publisher]：

1. Go to [pub.dev]({{site.pub}}).

   访问 [pub.dev]({{site.pub}})。

1. Log in to pub.dev using a Google Account.

   用一个 Google 账户登录 pub.dev。

1. From the user menu in the top-right corner, select **Create Publisher**.

   从右上角的用户菜单中，选择 **创建发布者 (Create Publisher)**。

1. Enter the domain name that you want to associate with your publisher
   (for example, `dart.dev`).

   输入你想要与发布者关联的域名（例如，`dart.dev`）。

1. Click **Create Publisher**.

   点击 **创建发布者 (Create Publisher)**。

1. In the confirmation dialog, select **OK**.

   在确认弹框中，选择 **OK**。

1. If prompted, complete the verification flow.
   This opens the [Google Search Console][google-search].

   如果出现提示，
   请在打开的 [Google Search Console][google-search] 中完成验证流程。

   * When adding DNS records,
     a few hours might pass before the Search Console reflects the changes.

     添加 DNS 记录时，
     Search Console 可能需要几个小时才能响应更改。

   * When the verification flow is complete, return to step 4.

     验证流程完成后，返回第 4 步。

:::tip
We strongly recommend you invite other members of your
organization to be members of the verified publisher.
This helps ensure that your organization retains access to
the publisher when you are not available.
:::

## Publish your package

## 发布你的 package

Use the [`dart pub publish`][] command to publish your package
for the first time or to update it to a new version.

使用 [`dart pub publish`][] 命令来首次发布你的 package，
或者将 package 升级到一个新版本。

### What files are published?

### 哪些文件会被发布？

The published package includes **all files** under the package root directory,
with the following exceptions:

在你 package 中的 **所有文件** 都会被包含在发布的 package 中，
但是以下情况除外：

* Any _hidden_ files or directories.
  These have names that begin with dot (`.`).

  所有 **隐藏** 文件和文件夹——即文件名以 `.` 开头的文件。

* Files and directories listed to be ignored in a
  `.pubignore` or `.gitignore` file

  在 `.pubignore` 和 `.gitignore` 文件中所列出的需要忽略的文件和目录。

To use different ignore rules for `git` and `dart pub publish`,
create a `.pubignore` file to overrule the
`.gitignore` file in a given directory.
If a directory contains both a `.pubignore` file and a `.gitignore` file,
then  `dart pub publish` _ignores_ that directory's `.gitignore` file.
The `.pubignore` files follow the same format as the
[`.gitignore` file][git-ignore-format].

如果你需要 `git` 和 `dart pub publish` 有不同的忽略规则，
你可以创建 `.pubignore` 文件来对 `.gitignore` 进行重载。
如果一个目录同时存在 `.pubignore` 和 `.gitignore` 文件，
则 `dart pub publish` **不会采用** `.gitignore` 的规则。
`.pubignore` 文件的格式与 [`.gitignore` 文件格式][git-ignore-format] 相同。

To avoid publishing unwanted files, follow these practices:

如果你不想发布一些文件，请参考以下步骤：

* Delete any files that you don't want to include or add them
  to a `.pubignore`  or `.gitignore` file.

  删除它们，或者把它们添加到 `.pubignore` 或 `.gitignore` 文件内。

* When uploading your package,
  examine the list of files that
  `dart pub publish --dry-run` shows it will publish.
  Cancel the upload if any undesired files appear in that list.

  上传 package 时，
  请执行 `dart pub publish --dry-run` 来仔细检查文件列表。
  如果发现了不需要的文件，则取消这次上传。

:::note

Most packages don't need a  `.pubignore` file.
To learn more about useful scenarios for this,
consult this [StackOverflow answer][pubignore-when].

大部分 package 不会需要一个 `.pubignore` 文件，
这个文件的应用场景可以在 [这个回答][pubignore-when] 里找到。

:::

### Test publishing your package

### 测试发布你的 package

To test how `dart pub publish` will work, you can perform a dry run:

为了测试 `dart pub publish` 命令会如何工作，你可以演示一次试运行（不会真的发布，只显示效果）：

```console
$ dart pub publish --dry-run
```

With this command, `dart pub` performs the following tasks:

通过该命令，`dart pub` 会执行以下流程：

1. Verifies that your package follows the [pubspec format][pubspec] and
   [package layout conventions][pkg-layout].

   验证 package 是否符合 [pubspec 格式][pubspec] 和
   [package 的文件结构][pkg-layout] 的规范。

1. Shows all of the files it intends to publish.

   展示所有准备发布的文件。

The following example shows the publishing a package named `transmogrify`:

以下示例展示了将要发布的名为 `transmogrify` 的 package：

```plaintext
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

### Publish to pub.dev

### 发布到 pub.dev

To publish your package when it's ready, remove the `--dry-run` argument:

当你已经准备好发布你的 package 时，请移除 `--dry-run` 参数：

```console
$ dart pub publish
```

With this command, `dart pub` performs the following tasks:

1. Verifies that your package follows the [pubspec format][pubspec] and
   [package layout conventions][pkg-layout].

1. Shows all of the files it intends to publish.

1. Uploads your package to [pub.dev]({{site.pub}}).

:::note

The pub command doesn't support direct publishing a new package to a
verified publisher. As a temporary workaround, publish new packages to a Google Account,
and then [transfer the package to a publisher](#transferring-a-package-to-a-verified-publisher).

pub 命令不支持将一个新的 package 直接发布至已验证发布者。
可先把新 package 发布至一个 Google 账户，作为一个临时空间，
然后再 [把 package 转移至已验证发布者](#transferring-a-package-to-a-verified-publisher)。

Once a package has been transferred to a publisher,
you can update the package using `dart pub publish`.

一旦这个 package 被转移到已验证发布者，你就可以通过 `dart pub publish` 命令来更新它。

:::

After your package succeeded in uploading to pub.dev, any pub user can
download it or depend on it in their projects.

在你的 package 成功上传至 pub.dev 之后，任何用户都能够下载或在项目中依赖它。

For example, if you just published version 1.0.0 of your `transmogrify` package,
then another Dart developer can add it as a dependency in their `pubspec.yaml`:

例如，如果你刚刚发布了你的 `transmogrify` package 1.0.0 版本，
那么另一个 Dart 开发者将可以把它作为一项依赖添加到 `pubspec.yaml` 文件中：

```yaml
dependencies:
  transmogrify: ^1.0.0
```

### Detect supported platforms

### 检测平台支持

The [pub.dev site]({{site.pub}}) detects which platforms a package supports,
displaying these platforms on the package page.
Users of pub.dev can filter searches by platform.

pub.dev 会检测 package 支持哪些平台，并呈现到 package 的页面上。
用户可以过滤查找特定平台的 package。

To change the generated list of supported platforms,
[specify supported platforms][] in the `pubspec.yaml` file.

若要改变生成的支持平台列表，则需要在 `pubspec.yaml` 文件中
[指定平台][specify supported platforms]。

[specify supported platforms]: /tools/pub/pubspec#platforms

### Automate publishing

Once you have published the first version of a package,
you can configure automated publishing
through GitHub Actions or Google Cloud service accounts.
To learn more about automated publishing, consult
[Automated publishing of packages to pub.dev](/tools/pub/automated-publishing).

### Publish prerelease versions {:#publishing-prereleases}

### 以预发行的方式发布

As you work on a package, consider publishing it as a prerelease.
Prereleases can be useful when:

如果你正专注于开发一个 package，考虑将它以预发行的方式发布。
预发行在以下情况很实用：

* You're actively developing the next major version of the package.

  你正在活跃的开发该 package 的下一个主版本。

* You want beta testers for the next release candidate of the package.

  你想要为该 package 下一个候选的发布版做 beta 测试。

* The package depends on an unstable version of the Dart or Flutter SDK.

  该 package 依赖于 Dart 或 Flutter SDK 的一个不稳定版本。

As described in [semantic versioning][semver],
to make a prerelease of a version, append a suffix to the version.
For example, to make a prerelease of version `2.0.0`,
you might use the version `2.0.0-dev.1`.
Later, when you release version `2.0.0`, it takes precedence over all
`2.0.0-XXX` prereleases.

正如在 [版本号语义][semver] 中描述的那样，
要制作一个版本的预发布，你需要为其添加一个后缀。
例如，要给 `2.0.0` 版本做一个预发布，
你可能会使用 `2.0.0-dev.1` 作为版本号。
接下来，当你发布 `2.0.0` 正式版后，
它将优先于所有诸如 `2.0.0-XXX` 的预发布。

As pub prefers stable releases when available, users of a prerelease package
might need to change their dependency constraints.
For example, if a user wants to test prereleases of version `2.1.0`, then
instead of `^2.0.0` or `^2.1.0` they might specify `^2.1.0-dev.1`.

pub 更优先选择使用稳定版本，所以使用预发布的用户可能需要手动改变它们的依赖约束。
例如，如果一个用户想要测试 `2.1.0` 的预发布版本，
那么他可能需要指明是 `^2.1.0-dev.1` 版本，而不是 `^2.0.0` 或者 `^2.1.0` 版本。

:::note

While `pub` prefers stable releases the same way it prefers newer versions,
the version solver does not attempt all solutions and may pick a prerelease,
even when a resolution that doesn't use prereleases exists.
Though this rarely happens in practice.

虽然 `pub` 会更优先使用稳定版本（就像更优先使用新版本一样），
但版本解析器不会尝试所有语义解析方案，
即使没有使用预发布版本的语义解析方案，
它也有可能会选择使用预发布版本。
当然，这样的情况在实际使用中很少发生。

:::

When you publish a prerelease to pub.dev,
the package page displays links to both the prerelease and the stable release.
The prerelease doesn't affect the analysis score, show up in search results,
or replace the package `README.md` and documentation.

当一个预发布被发布在 pub.dev，package 主页会同时展示预发布和稳定发布的链接。
预发布不会影响分析评分，不会出现在搜索结果里，也不会代替 package 的 `README.md` 文件和说明文档。

### Publish preview versions

### 发布预览版本

Previews can be useful when _all_ of the following are true:

在以下条件**都**满足时，发布预览版将会更有利：

* The next stable version of the package is complete.

  下一个稳定版本是完整功能的版本。

* That package version depends on an API or feature in the Dart SDK that
  hasn't yet been released in a stable version of the Dart SDK.

  在最新的稳定版 Dart SDK 中，没有发布目前版本使用的 API。

* You know that the API or feature that the package depends on is
  API-stable and won't change before it reaches the stable SDK.

  你的 package 所依赖的 API 或功能在发布到稳定版 SDK 前不会再改变。

As an example, consider a new version of `package:args` that has
a finished version `2.0.0`.
It depends on a feature in Dart `3.0.0-417.1.beta`.
However, the stable version of Dart SDK `3.0.0` hasn't been released.
The `pubspec.yaml` file might look like this:

举个例子，假设 `package:args` 的 `2.0.0` 版本是已经完成的版本，
但它依赖了 Dart `3.0.0-417.1.beta` 的功能，这时 `3.0.0` 的 SDK 尚未发布。
它的 pubspec 如下：

```yaml title="pubspec.yaml"
name: args
version: 2.0.0

environment:
  sdk: '^3.0.0-417.1.beta'
```

When you publish this package to pub.dev, it's tagged as a preview version.
The following screenshot illustrates this.
It lists the stable version as `1.6.0` and the preview version as `2.0.0`.

当这个 package 发布到 pub.dev 上时，会被标记为预览版，如下图所示，
`1.6.0` 是正式版而 `2.0.0` 是预览版。

![Illustration of a preview version](/assets/img/tools/pub/preview-version.png){:width="600px"}<br>

When Dart releases the stable version of `3.0.0`,
pub.dev updates the package listing to display
`2.0.0` as the latest (stable) version of the package.

当 `3.0.0` 稳定版的 Dart 发布后，pub.dev 会更新 package 列表，
此时 `2.0.0` 会显示为最新（稳定）版本。

If all of the conditions at the beginning of this section are true,
ignore the following warning from `dart pub publish`:

如果上面的所有条件都满足，那么你可以在运行 `dart pub publish` 时忽略以下的警告：

   _"Packages with an SDK constraint on a pre-release of the Dart SDK should
   themselves be published as a pre-release version. If this package needs Dart
   version 3.0.0-0, consider publishing the package as a pre-release
   instead."_

## Manage publishing permissions

## 管理发布权限

### Locate the package publisher

### 找到 package 发布者

If a package has a verified publisher,
the pub.dev page for that package displays the publisher domain.

如果 package 已经有了已验证发布者，
pub.dev 页面将展示已验证发布者域名。

For packages published without a publisher,
pub.dev doesn't disclose the publisher for privacy reasons.
The **Publisher** field displays "unverified uploader".

如果 package 的发布者没有选择认证，
出于隐私原因，pub.dev 不会披露发布者的信息。
**Publisher** 会显示 "unverified uploader (未经验证的上传者)"。

### Manage package uploaders {:#uploaders}

### 管理 package 上传者

Whoever publishes the first version of a package becomes
the first and _only_ person authorized to upload additional
versions of that package.

发布 package 第一个版本的人将成为唯一有权对其进行版本更新的人。

To allow or disallow other people to upload versions, either:

要允许或取消其他人更新版本，可以从下列两种方法中任选一种：

* Manage authorized uploaders on the admin page for the package:
  `https://pub.dev/packages/<package>/admin`.

  在管理页面上管理授权的 package 上传者：
  `https://pub.dev/packages/<package>/admin`。

* Transfer the package to a [verified publisher][];
  all members of a publisher are authorized to upload.

  将 package 转给一个 [已验证的发布者][verified publisher]，
  这个发布者的所有成员都有上传的权利。

:::tip
Invite other members of your team to become uploaders of the package.
This ensures that your team can access to the package when you aren't available.
:::

### Transfer a package to a verified publisher {:#transferring-a-package-to-a-verified-publisher}

### 将 package 转移至已验证发布者

To transfer a package to a verified publisher,
you must be an [uploader](#uploaders) for the package
and an admin for the verified publisher.

想要把 package 转移至已验证发布者，
你必须是 package 的一个[上传者](#uploaders)，以及已验证发布者的管理员。

:::important

_You can't reverse this process._ Once you transfer a package to a publisher,
you can't transfer it back to an individual account.

**这个过程是不可撤回的。**
一旦你把 package 转移至已验证发布者，
你将无法再把它转移回一个单独的账户。

:::

To transfer a package to a verified publisher:

请根据以下步骤，将 package 转移至已验证发布者：

1. Log in to [pub.dev]({{site.pub}}) with a Google Account that's listed as
   an uploader of the package.

   用一个作为 package 上传者之一的 Google 账户登录 [pub.dev]({{site.pub}})。

1. Go to the package details page (for example,
   `{{site.pub-pkg}}/http`).

   访问 package 详情页面（例如，`{{site.pub-pkg}}/http`）。

1. Select the **Admin** tab.

   选择 **Admin** 选项卡。

1. Enter the name of the publisher, and click **Transfer to Publisher**.

   输入已验证发布者的名称，然后点击 **转移至已验证发布者 (Transfer to Publisher)**。

## Manage your package

## 管理你的 package

### Retract a package version {:#retract}

### 撤回 package 的某个版本

To prevent new package consumers from adopting a published version
of your package within a seven-day window,
you can retract that package version within seven days of publication.
The retracted version can be restored again within seven days of retraction.

如果你需要为了在 7 天内防止新 package 用户采用已发布的 package 版本，
你可以在发布后 7 天内撤回该软件包版本。
撤回的版本可以在撤回后的 7 天内再次恢复。

_Retraction isn't deletion._
A retracted package version appears in the version listing
of the package on pub.dev in the **Retracted versions** section.
The detailed view of that package version displays a **RETRACTED** badge.

**撤回并不是删除。**
撤回的 package 版本会显示在 pub.dev 上版本列表的 **Retracted versions** 区域。
同时，对应版本的详细信息内会有一个 **RETRACTED** 标签。

Before retracting a package, consider publishing a new version instead.
Retracting a package can have a negative impact on package users.

在撤回版本之前，你可以考虑直接发布一个新版本。
撤回版本可能会对用户造成混乱和负面的使用体验。

If you publish a new version with either
a _missing dependency constraint_
or a _lax dependency constraint_,
then retracting the package version might be the only solution.
Publishing a newer version of your package won't stop the version
solver from picking the old version.
That version might be the only version pub can choose.
Retracting a package version with incorrect dependency constraints
forces users to either upgrade other dependencies or get a dependency conflict.

如果你不小心发布了 **未有效限制依赖版本** 的新版本，
那么撤回可能是唯一的选择。
发布新版本对于这样的情况来说是无效的，因为 pub 依然能解析到新版。
撤回未有效限制依赖版本的版本，可以让用户在尝试依赖时报错，或者升级到更新的版本。

However, if your package contains a minor bug,
you might not need to retract the version.
Publish a newer version with the bug fixed and a
description of the fixed bug in `CHANGELOG.md`.
This helps users to understand what happened.
Publishing a newer version is less disruptive to package users.

然而，如果你的新版本仅仅是包含了一个小 bug，便无需撤回版本。
发布一个修复了 bug 的新版，并且在 `CHANGELOG.md` 中标注内容，
可以帮助用户了解到问题所在。
发布新版也会让用户的使用体验更好。

:::version-note

Package retraction was introduced in Dart 2.15.
In pre-2.15 SDKs, the pub version solver ignores the retracted status.

版本撤回在 Dart 2.15 中引入。
在早于 2.15 的 SDK 中，pub 版本解析会忽略版本的撤回状态。

:::

#### How to use a retracted version of a package

#### 如何使用已撤回的版本

If a package depends on a package version that later is retracted,
it can still use that version as long as that version is in
the dependent package's `pubspec.lock` file.
To depend on a specific version that's already retracted,
the dependent package must pin the version in the
`dependency_overrides` section of the `pubspec.yaml` file.

如果一个 package 的对应版本已被撤回，在 `pubspec.lock` 标明它被依赖时仍然能被使用。
如果你想依赖某个撤回的版本，你可以在 `pubspec.yaml` 文件中的
`dependency_overrides` 部分固定对应版本的使用。

#### How to migrate away from a retracted package version

When a package depends on a retracted package version,
you have choices in how you migrate away from this version depending
on other available versions.

#### Upgrade to a newer version

In most cases a newer version has been published to
replace the retracted version.
In this case run `dart pub upgrade <package>`.

#### Downgrade to the newest non-retracted version

If no newer version is available, consider downgrading
to the newest non-retracted version.
You can do this in one of two ways.

1. Use [pub tool](/tools/pub/cmd) commands:

   1. Run `dart pub downgrade <package>` to
      get the lowest version  of the specified package that
      matches the constraints in the `pubspec.yaml` file.

   1. Run `dart pub upgrade <package>` to get the
      newest compatible and non-retracted version available.

1. Edit the `pubspec.lock` file in your preferred IDE:

   1. Delete the entire package entry for the package
      with the retracted version.

   1. Run `dart pub get` to get the
      newest compatible and non-retracted version available.

Though you could delete the `pubspec.lock` file and run `dart pub get`,
this is not recommended.
It might result in version changes for other dependencies.

#### Upgrade or downgrade to a version outside the specified version constraint

If there is no alternative version available that satisfies the
current version constraint, edit the version constraint
in the `pubspec.yaml` file and run `dart pub upgrade`.

#### How to retract or restore a package version

#### 如何撤回或恢复 package 的某个版本

To retract or restore a package version,
first sign in to pub.dev using a Google Account
that's either an uploader or a [verified publisher][] admin for the package.
Then go to the package's **Admin** tab,
where you can retract or restore recent package versions.

想要撤回或恢复 package 的某个版本，首先你需要使用 Google 账号登录到
pub.dev，该账号需要是该 package 的上传者或
[认证的发布者][verified publisher] 管理。
接着进入到 package 页面上的 **Admin** 标签栏，进行撤回和恢复版本操作。

### Discontinue a package {:#discontinue}

### 将 package 标记为终止

Although packages remain published, you can signal to
developers that a package receives no active maintenance.
This requires you to mark the package as **discontinued**.

Once you discontinue a package, the package will:

* Remain published on pub.dev.
* Remain viewable on pub.dev.
* Display a clear **DISCONTINUED** badge.
* Not appear in pub.dev search results.

To mark a package as discontinued:

1. Sign in to pub.dev using a Google Account with uploader or
   [verified publisher][]permissions for the package.

1. Navigate to the package's **Admin** tab.

1. To discontinue a package, select **Mark "discontinued"**.

You can also recommend a replacement package.

1. In the field under **Suggested replacement**,
   type the name of another package.

1. Click **Update "Suggested Replacement"**.

If you change your mind, you can remove the discontinued mark at any time.

[create-verified-publisher]: {{site.pub}}/create-publisher
[BSD 3-clause license]: https://opensource.org/licenses/BSD-3-Clause
[Google Account]: https://support.google.com/accounts/answer/27441
[Markdown]: {{site.pub-pkg}}/markdown
[pkg-layout]: /tools/pub/package-layout
[policy]: {{site.pub}}/policy
[pub]: /guides/packages
[`dart pub publish`]: /tools/pub/cmd/pub-lish
[pubspec]: /tools/pub/pubspec
[semver]: https://semver.org/spec/v2.0.0-rc.1.html
[verified publisher]: /tools/pub/verified-publishers
[git-ignore-format]: https://git-scm.com/docs/gitignore#_pattern_format
[pubignore-when]: https://stackoverflow.com/a/69767697
[google-search]: https://search.google.com/search-console/about
