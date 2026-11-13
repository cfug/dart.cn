---
# title: Writing package pages
title: 编写 package 的介绍页面
# description: Learn how to write a good package page.
description: 了解如何编写出色的 package 介绍页面。
ai-translated: true
---

<style>
  .screenshot, .screenshot-narrow {
    border-style: solid;
    border-width: 1px;
    border-color: var(--site-outline);
    margin: 0 20px;
    padding: 10px;
    width: 90%;
  }

  .screenshot-narrow {
    max-width: 400px;
  }
</style>

The guidelines on this page can help you create good package pages on pub.dev.
Specifically, this page has tips for
writing a better package README,
which provides the content marked **README (this document)**
in the following screenshot:

本页的指南可以帮助你在 pub.dev 上创建出色的 package 页面。
具体来说，本页提供了编写更好的 package README 的建议。
README 会提供下面截图中标记为 **README (this document)** 的内容：

<img 
  src="/assets/img/libraries/package-page-sections.png"
  alt="package page contains sections like package layout, flutter favorite, package scoring, verified publishers, pubspec file" 
  class="screenshot diagram-wrap">

For details about other parts of the package page,
follow these links:

package 页面其他部分的详情，请查看这些链接：

1. [Package layout ](/tools/pub/package-layout)

   [Package 的文件结构](/tools/pub/package-layout)

2. [Flutter Favorite]({{site.flutter-docs}}/development/packages-and-plugins/favorites)

   [Flutter Favorite]({{site.flutter-docs}}/development/packages-and-plugins/favorites)

3. [Package scoring]({{site.pub}}/help/scoring)

   [Package 评分]({{site.pub}}/help/scoring)

4. [Verified publishers](/tools/pub/verified-publishers)

   [已验证发布者](/tools/pub/verified-publishers)

5. [Pubspec file](/tools/pub/pubspec)

   [Pubspec 文件](/tools/pub/pubspec)


## Writing a good README is important

## 写好 README 很重要

People who find your package on pub.dev are likely to
quickly scan the README when deciding whether to try your package.
A good README catches the reader's attention and
shows that your package is worth trying.

在 pub.dev 上找到你的 package 的人，
往往会快速扫一眼 README，再决定要不要试用。
一份好的 README 能抓住读者的注意力，
并表明你的 package 值得一试。

:::note
The package README is used in multiple ways.
For example, its content appears not only in the package page on pub.dev,
but also in [`dart doc`][]-produced API reference documentation.

package 的 README 会以多种方式使用。
例如，它的内容不仅出现在 pub.dev 的 package 页面上，
也会出现在 [`dart doc`][] 生成的 API 参考文档中。
:::

Although this page features the [`in_app_purchase`][] package README,
yours might not need to be as large or detailed.
If your package is simple and has no associated UI,
its README might look more like the one for the [`yaml`][] package. 

虽然本页以 [`in_app_purchase`][] package 的 README 为例，
你的 README 不必同样长、同样详细。
如果你的 package 很简单，也没有配套的界面，
README 可能更接近 [`yaml`][] package 的那种。


## Seven tips for good README

## 写出好 README 的七条建议

Here are some suggestions for creating a README
that works well on pub.dev:

下面是一些建议，帮助你写出在 pub.dev 上效果好的 README：

1. [Put a short description at the top](#tip1)

   [把简短说明放在最上方](#tip1)

2. [Include visual content](#tip2)

   [加入视觉内容](#tip2)

3. [Use lists to present important information](#tip3)

   [用列表呈现重要信息](#tip3)

4. [Include usage examples](#tip4)

   [加入用法示例](#tip4)

5. [Use Dart code formatting](#tip5)

   [使用 Dart 代码格式](#tip5)

6. [Mention related terms](#tip6)

   [提到相关术语](#tip6)

7. [Tell users where to go next](#tip7)

   [告诉用户接下来去哪里](#tip7)


### 1. Put a short description at the top {:#tip1}

### 1. 把简短说明放在最上方

According to our user research,
package users spend only a few seconds to
read the package description and decide whether to
read the rest of the README.
Thus, you should concisely describe what the package does or achieves,
at a glance.
Spend some time to craft a short and sweet description and
help the user to make decisions.

根据我们的用户研究，
package 用户只会花几秒钟阅读 package 说明，
然后决定要不要继续读 README 的其余部分。
因此，你应该一眼就能看懂地、简洁地说明这个 package 做什么、达成什么。
花点时间打磨一段短而清楚的说明，帮助用户做决定。

:::tip
Don't write the package name again at the top.
It's already visible in the pub.dev UI.

不要在最上方再写一遍 package 名称。
pub.dev 的界面上已经能看到它。
:::

Here are some examples of good descriptions:

下面是一些好的说明示例：

*   `A Flutter plugin for showing rainbows.`

    `一个用来展示彩虹的 Flutter 插件。`

*   `Use machine learning to categorize bird sounds.`

    `使用机器学习对鸟类声音进行分类。`

Important information such as project status or constraints
should also be near the top.
For example:

项目状态或约束这类重要信息也应该靠近顶部。例如：

*   `Does not work on iOS versions below 10.3.`

    `在低于 10.3 的 iOS 版本上无法工作。`

Here's a screenshot of the [`in_app_purchase`][] package page,
which starts with a brief explanation of the package and a caution:

下面是 [`in_app_purchase`][] package 页面的截图，
开头是对该 package 的简要说明和一条提醒：

<img 
  src="/assets/img/libraries/package-page-description.png"
  alt="description of the package in_app_purchase" 
  class="screenshot">

[Badges][] are often near the top of the README,
either above or under the short description. 

[徽章][Badges] 通常靠近 README 的顶部，
放在简短说明的上方或下方。


### 2. Include visual content {:#tip2}

### 2. 加入视觉内容

If your package page is a wall of text with no visual content,
users might find it intimidating and stop reading.
Images are especially important if your package supports UI,
but they're also useful for explaining important concepts.
Either way, visual content can help users
feel confident about using the package.

如果 package 页面是一堵没有视觉内容的文字墙，
用户可能会觉得难以入手，然后不再往下读。
如果你的 package 支持界面，图片尤其重要，
但图片同样有助于解释重要概念。
无论哪种情况，视觉内容都能让用户更有信心使用这个 package。

Place visual content such as static images, animated GIFs, and
videos (such as MOV or MP4 files)
close to the beginning of the README,
where users are likely to see them.

把静态图片、动态 GIF 和视频（例如 MOV 或 MP4 文件）
这类视觉内容放在 README 靠前的位置，
让用户更容易看到。

:::tip
Prefer animated GIFs and videos for UI-related content,
because most UIs aren't static,
and animation conveys more information about the UI's behavior.

与界面相关的内容，优先使用动态 GIF 和视频，
因为大多数界面不是静止的，
动画能传达更多关于界面行为的信息。
:::

The screenshots below show how
adding visual content made the `in_app_purchase` package page look informative at first glance.
(The _before_ picture is on the left; _after_ is on the right.)

下面的截图展示了加入视觉内容之后，
`in_app_purchase` 的 package 页面如何一眼就显得信息充分。
（**之前** 的图在左边，**之后** 的图在右边。）

<img 
  src="/assets/img/libraries/package-page-example-iap.png"
  alt="in_app_purchase readme without and with images" 
  class="screenshot">

:::tip
When adding visual content,
use absolute URLs for the files
to make the images reliably appear,
no matter where the README is published.
One place to host your images is in the repository itself,
like `in_app_purchase` does.

添加视觉内容时，请为文件使用绝对 URL，
这样无论 README 发布在哪里，图片都能稳定显示。
可以把图片托管在仓库本身，
`in_app_purchase` 就是这样做的。
:::


### 3. Use lists to present important information {:#tip3}

### 3. 用列表呈现重要信息

Lists can draw attention to important information on your README.
You might use lists for the following:

列表能把 README 上的重要信息突出来。你可以在这些地方使用列表：

*   [Key features of the package](#list1)

    [package 的关键功能](#list1)

*   [Parameters, attributes, or properties](#list2)

    [参数、特性或属性](#list2)

*   [Unusual requirements](#list3)

    [不寻常的要求](#list3)

*   [Functionality that's out of scope of your package](#list4)

    [不属于你的 package 范围的功能](#list4)

*   [A summary of the contents of a page or a section within a page
    (like this list)](#list5)

    [页面或页面中某一节的内容摘要（就像这个列表）](#list5)

Usually, lists are bulleted, like the list above.
Another option is using a table,
like the table of platform support in the next section.

列表通常使用项目符号，就像上面这个列表。
另一种选择是使用表格，
比如下一节中的平台支持表。


#### Key features of the package {:#list1}

#### package 的关键功能

First, clearly list what your package can do.
Some users might be looking for a very specific feature.
Help those users find out whether your package supports their needs.

首先，清楚地列出你的 package 能做什么。
有些用户可能在找一个非常具体的功能。
帮助这些用户判断你的 package 是否满足他们的需要。

The following screenshot shows how the `in_app_purchase` README
presents the package's features:

下面的截图展示了 `in_app_purchase` 的 README 如何呈现该 package 的功能：

<img 
  src="/assets/img/libraries/package-page-features-list.png"
  alt="list of features of the package in_app_purchase" 
  class="screenshot">

The next screenshot shows a table from the `just_audio` README
that lists the package's features and platform support:

下一张截图来自 `just_audio` 的 README，
用表格列出了该 package 的功能和平台支持：

<img 
  src="/assets/img/libraries/package-page-features-table.png"
  alt="list of features of the package just_audio in a table format" 
  class="screenshot-narrow">


#### Parameters, attributes, or properties {:#list2}

#### 参数、特性或属性

Consider listing parameters, attributes, or properties for quick reference.
(Remember, the content of the package README appears in the
API reference documentation, as well as in the package page.)

可以考虑列出参数、特性或属性，方便快速查阅。
（请记住，package README 的内容既会出现在 package 页面上，
也会出现在 API 参考文档中。）

For example, the `url_launcher` package has a table of supported URL schemes:

例如，`url_launcher` package 有一张支持的 URL scheme 表格：

<img 
  src="/assets/img/libraries/package-page-list-property.png"
  alt="list of supported schemes of the package url_launcher" 
  class="screenshot">

Linking to specific functions or classes
in the API reference documentation can also be useful.
See the [async]({{site.pub-pkg}}/async) package for an example.

链接到 API 参考文档中的特定函数或类也很有用。
可以参考 [async]({{site.pub-pkg}}/async) package。


#### Unusual requirements {:#list3}

#### 不寻常的要求

If your package needs a specific setup, beyond what all packages require,
list setup instructions in the README.

如果你的 package 需要超出所有 package 通用要求的特定配置，
请在 README 中列出配置步骤。

For example, the following screenshot for the `google_maps_flutter` package
shows instructions on getting started with Google Maps Platform:

例如，下面 `google_maps_flutter` package 的截图
展示了如何开始使用 Google Maps Platform：

<img 
  src="/assets/img/libraries/package-page-list-requirements.png" 
  alt="additional instructions to use google_maps_flutter" 
  class="screenshot">


#### Functionality that's out of scope of your package {:#list4}

#### 不属于你的 package 范围的功能

To help users know whether your package can help them,
list the features that users might expect,
but that your package _doesn't_ support.

为了帮助用户判断你的 package 能不能帮到他们，
请列出用户可能会期望、但你的 package **并不** 支持的功能。

Here are some examples of when
you might want to list out-of-scope functionality:

下面是一些适合列出范围外功能的例子：

* If your button package is focused only on text buttons
  and not on icon buttons,
  make that clear in the README.

  如果你的按钮 package 只关注文本按钮，而不关注图标按钮，
  请在 README 中写清楚。

* If your package supports only certain versions of Android,
  say that in the README.

  如果你的 package 只支持某些 Android 版本，请在 README 中说明。


#### Contents {:#list5}

#### 目录

Users find it easier to navigate a page or section
when it has a table of contents.
If a section in your README is very long,
consider listing the subsections clearly at the beginning of the section. 

当页面或某一节有目录时，用户会更容易浏览。
如果 README 中的某一节很长，
可以考虑在该节开头清楚地列出各个小节。

For example, the "Usage" section of the `in_app_purchase` README
has a lot of examples.
The following table of contents helps users understand which examples exist,
and go to the code that interests them:

例如，`in_app_purchase` README 的 “Usage” 一节有很多示例。
下面的目录帮助用户了解有哪些示例，并跳到他们感兴趣的代码：

<img 
  src="/assets/img/libraries/package-page-list-subsections.png" 
  alt="content of the usage section of the package in_app_purchase" 
  class="screenshot">


### 4. Include usage examples {:#tip4}

### 4. 加入用法示例

If your package looks promising, users might want to test your package.
Include a "Get started" or "Usage" section that has
at least one code sample that users can easily understand—and, 
ideally, that they can copy and paste into their project.
It's even better if you can provide more examples with more details
to help users to understand your package. 

如果用户觉得你的 package 有希望，他们可能会想试用。
请加入 “Get started” 或 “Usage” 一节，
其中至少有一段用户容易看懂的代码示例，
最好还能直接复制粘贴到他们的项目里。
如果你能提供更多、更详细的示例，帮助用户理解你的 package，那就更好了。

Remember that not all users speak English, but they all speak Dart!
Good code samples can go a long way.
Consider adding more complete examples
under your package's `example` directory,
which pub.dev can use to populate an **Examples** tab.
For details, see [Examples][] in
the [package layout conventions][].

请记住，并非所有用户都懂英语，但他们都懂 Dart！
好的代码示例能帮上大忙。
可以考虑在 package 的 `example` 目录下加入更完整的示例，
pub.dev 可以用它们填充 **Examples** 标签页。
详情请参阅 [package 布局约定][package layout conventions] 中的 [示例][Examples]。

[Examples]: /tools/pub/package-layout#examples
[package layout conventions]: /tools/pub/package-layout

The following screenshot shows one of several examples in the README for
the `in_app_purchase` package:

下面的截图展示了 `in_app_purchase` package 的 README 中若干示例之一：

<img 
  src="/assets/img/libraries/package-page-usage-example.png"
  alt="sample code of the package in_app_purchase" 
  class="screenshot">

### 5. Use Dart code formatting {:#tip5}

### 5. 使用 Dart 代码格式

When adding code examples,
use three backticks plus `dart` (<code>&#96;&#96;&#96;dart</code>) instead of
three backticks (<code>&#96;&#96;&#96;</code>).
As the following examples show,
adding `dart` tells pub.dev to use Dart syntax highlighting:

添加代码示例时，
请使用三个反引号加上 `dart`（<code>&#96;&#96;&#96;dart</code>），
而不是只有三个反引号（<code>&#96;&#96;&#96;</code>）。
如下例所示，加上 `dart` 会让 pub.dev 使用 Dart 语法高亮：

<table width="100%">
<tr>
<th> <b>Formatted with just <code>&#96;&#96;&#96;</code></b>

<b>仅使用 <code>&#96;&#96;&#96;</code> 格式化</b> </th>
<th> <b>Formatted with <code>&#96;&#96;&#96;dart</code></b>

<b>使用 <code>&#96;&#96;&#96;dart</code> 格式化</b> </th>
</tr>
<tr>
<td>

```plaintext
final like = 'this';
```

</td>
<td>

```dart
final like = 'this';
```

</td>
</tr>
</table>


### 6. Mention related terms {:#tip6}

### 6. 提到相关术语

A recent UX study found that
many users use the within-page search feature
(<kbd class="special-key">Cmd/Ctrl</kbd>+<kbd>F</kbd>)
to search for the feature they are looking for.
Thus, be sure to mention important terms in the README,
so that users can find them. 

最近的一项用户体验研究发现，
许多用户会使用页内搜索
（<kbd class="special-key">Cmd/Ctrl</kbd>+<kbd>F</kbd>）
来查找他们想要的功能。
因此，请务必在 README 中提到重要术语，让用户能搜到。

For example, users might want to know whether the `in_app_purchase` package
supports in-app subscription.
A user who searches for the keyword _subscription_
might abandon the page if the page doesn't use that term.

例如，用户可能想知道 `in_app_purchase` package 是否支持应用内订阅。
如果页面没有使用 **subscription** 这个词，
搜索该关键词的用户可能会离开这个页面。

<img 
  src="/assets/img/libraries/package-page-terms.png"
  alt="the keyword is highlighted when users search for it within the page" 
  class="screenshot">

After mentioning all the terms that people might search for,
be consistent about the terms you use.
If needed, clearly define the terms.

提到人们可能搜索的所有术语之后，请在用词上保持一致。
如果需要，请清楚地定义这些术语。

For example, the [`in_app_purchase`][] package defines
_underlying store_ at the beginning:

例如，[`in_app_purchase`][] package 在开头定义了 **underlying store**：

<img 
  src="/assets/img/libraries/package-page-terms-definition.png"
  alt="the meaning of underlying store" 
  class="screenshot">

The rest of the page consistently uses that term:

页面其余部分始终使用这个术语：

<img 
  src="/assets/img/libraries/package-page-terms-consistent.png"
  alt="The term underlying store is used consistently across the page" 
  class="screenshot">


### 7. Tell users where to go next {:#tip7}

### 7. 告诉用户接下来去哪里

Help your users find out more about the package.
Here are some suggestions for what to tell potential users:

帮助用户进一步了解这个 package。
下面是一些可以告诉潜在用户的内容：

* Where to learn more about the package.
  You might link to an article on Medium, or to a video on YouTube.

  去哪里进一步了解这个 package。
  你可以链接到 Medium 上的文章，或 YouTube 上的视频。

* Where to get help on using the package.
  Possibilities include an issue tracker, a chat room, or an email address.

  使用这个 package 时去哪里求助。
  可以是 issue 跟踪器、聊天室或电子邮箱。

* What you're planning to do with the package.
  A roadmap—either in the README or in an external page—can 
  help users know whether the feature they need is coming soon.

  你打算如何继续开发这个 package。
  路线图——放在 README 里或外部页面上——
  能帮助用户了解他们需要的功能是否即将到来。

* How to contribute code to the package.

  如何向这个 package 贡献代码。

The following screenshot shows the part of the `in_app_purchase` README
that has information for potential contributors:

下面的截图展示了 `in_app_purchase` README 中
面向潜在贡献者的那一部分：

<img 
  src="/assets/img/libraries/package-page-contribute.png"
  alt="how to contribute to in_app_purchase" 
  class="screenshot">


## Learn more about good README authoring

## 进一步了解如何写好 README

We've suggested seven tips for good README in this documentation.
You can learn more about common recommendations for developer documentation
from the [Google Developer Documentation Style Guide][style-guide].
Some additional tips include:  

本文给出了写出好 README 的七条建议。
你可以从 [Google 开发者文档风格指南][style-guide]
了解更多开发者文档的常见建议。另外还有一些提示：

*   Supply alt text for images.

    为图片提供替代文本。

*   Be succinct. Don't say please.

    写得简洁。不必说 please。

*   Keep the line length &lt;= 80 chars.

    把行长保持在 80 个字符以内。

*   Format code correctly (as `dart format` would).

    正确格式化代码（就像 `dart format` 那样）。

To learn more about good README practices,
see these resources:

要进一步了解好的 README 实践，请参阅这些资源：

[README Checklist][]
: A checklist for writing a README that
  helps readers feel confident about your project.

  一份用来编写 README 的检查清单，让读者对你的项目更有信心。

[Awesome README][]
: A curated, annotated list of great READMEs.

  一份经过挑选并加了注释的优秀 README 列表。

[Make a README][]
: An introduction to READMEs,
  with a template and suggestions for a good README.

  一篇 README 入门介绍，带有模板和写好 README 的建议。

[How to write a great README for your GitHub project][]
: Key elements of a good README, and a template.

  一份好 README 的关键要素，以及一份模板。

The suggestions in this page and others might not work for all packages.
Be creative!
Put yourself into users' shoes and
imagine what the reader might want to read and know.
You're the only person who can provide the information that the reader needs.

本页和其他页面上的建议未必适合所有 package。
发挥创造力！
站在用户的角度，想象读者可能想读到、想知道什么。
只有你能提供读者需要的信息。

[Awesome README]: https://github.com/matiassingers/awesome-readme
[Badges]: https://github.com/badges/shields#readme
[`dart doc`]: /tools/dart-doc
[How to write a great README for your GitHub project]: https://dbader.org/blog/write-a-great-readme-for-your-github-project
[`in_app_purchase`]: {{site.pub-pkg}}/in_app_purchase
[in its repo]: https://github.com/flutter/plugins/tree/master/packages/in_app_purchase/in_app_purchase/doc
[Make a README]: https://www.makeareadme.com
[README Checklist]: https://github.com/ddbeck/readme-checklist/blob/main/checklist.md
[style-guide]: https://developers.google.com/style/highlights
[`yaml`]: {{site.pub-pkg}}/yaml 
