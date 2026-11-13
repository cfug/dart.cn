---
# title: Verified publishers
title: 已验证发布者
# description: Learn what verified publishers are, and they're verified.
description: 了解已验证发布者是什么，以及它们如何完成验证。
ai-translated: true
---

The pub.dev verified publisher badge <img src="/assets/img/verified-publisher.svg" class="text-icon" alt="pub.dev verified publisher logo"> 
lets you know that the pub.dev site 
verified the identity of the publisher of a package.
For example, [dart.dev]({{site.pub}}/publishers/dart.dev/)
is the verified publisher for packages that Google's Dart
team supports.

pub.dev 的已验证发布者徽章 <img src="/assets/img/verified-publisher.svg" class="text-icon" alt="pub.dev verified publisher logo">
表示 pub.dev 网站已经核实了某个 package 发布者的身份。
例如，[dart.dev]({{site.pub}}/publishers/dart.dev/)
是 Google Dart 团队所支持 package 的已验证发布者。

The badge appears in several places on pub.dev,
next to packages that verified publishers published:

徽章会出现在 pub.dev 的多个位置，
位于已验证发布者所发布的 package 旁边：

  * Package search results

    package 搜索结果

  * Package detail pages

    package 详情页

  * Publisher profile pages

    发布者资料页

  * The pub.dev front page

    pub.dev 首页

Each publisher has a page with a list of
all packages belonging to that publisher,
plus additional details such as the publisher's contact email.
To visit the publisher page, click the publisher identity link
(for example, `dart.dev`) next to the verified publisher badge 
<img
class="text-icon"
  src="/assets/img/verified-publisher.svg" 
  alt="pub.dev verified publisher logo">.

每个发布者都有一个页面，列出属于该发布者的全部 package，
以及联系邮箱等其他信息。
要打开发布者页面，点击已验证发布者徽章旁边的发布者身份链接
（例如 `dart.dev`）
<img
class="text-icon"
  src="/assets/img/verified-publisher.svg" 
  alt="pub.dev verified publisher logo">。

## Verification process

## 验证流程

To ensure that creating verified publishers is low cost and available to anyone,
pub.dev relies on DNS (domain name system) domains as an identification token.
We chose DNS verification because many package authors
already have a trusted domain and a homepage for that domain.
During the [publisher creation process][publishing page],
pub.dev verifies that the user creating the verified publisher has
admin access to the associated ["Domain Property"][domain-prop],
based on existing logic in the [Google Search Console.][search-console]

为了让创建已验证发布者成本较低、任何人都能使用，
pub.dev 使用 DNS（域名系统）域名作为身份标识。
之所以选择 DNS 验证，是因为许多 package 作者
已经拥有受信任的域名，以及该域名对应的主页。
在 [发布者创建流程][publishing page] 中，
pub.dev 会根据 [Google Search Console][search-console] 里已有的逻辑，
验证创建已验证发布者的用户对关联的 [「Domain Property」][domain-prop]
拥有管理员权限。

:::note
Domain name ownership is verified only once when a publisher is created. After that:

域名所有权只在创建发布者时验证一次。此后：

- Losing control of a domain does not cause the original publisher owner to lose access to the publisher.

  失去对域名的控制，并不会让原发布者所有者失去对该发布者的访问权限。

- Acquiring a domain does not grant the new owner any rights to a publisher that was previously associated with it.

  获得某个域名，并不会让新所有者获得此前与该域名关联的发布者的任何权利。

- Publisher ownership must be explicitly transferred by the current publisher owner.

  发布者所有权必须由当前发布者所有者显式转移。
:::

## Creating a verified publisher account

## 创建已验证发布者账号

If you publish packages and want to create a new verified publisher,
see the instructions on the [publishing page][].

如果你发布 package，并想创建新的已验证发布者，
请参阅 [发布页面][publishing page] 上的说明。

[domain-prop]: https://support.google.com/webmasters/answer/34592
[publishing page]: /tools/pub/publishing#create-verified-publisher
[search-console]: https://search.google.com/search-console/about
