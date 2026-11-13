---
# title: Security
title: 安全
# description: >-
#   An overview of the Dart team's philosophy and processes for security.
description: >-
  Dart 团队的安全理念和流程的概述
showBreadcrumbs: false
skipFreshness: true
ai-translated: true
---

The Dart team takes the security of Dart and the applications
created with it seriously.
This page describes how to report any vulnerabilities that you find,
and lists best practices to minimize the risk of introducing a vulnerability.

Dart 团队认真对待 Dart 以及用它创建的应用的安全。
本页说明如何报告你发现的漏洞，
并列出降低引入漏洞风险的最佳实践。

## Security philosophy

## 安全理念

Dart's security strategy is based on five key pillars:

Dart 的安全策略基于五个关键支柱：

- **Identify**: Track & prioritize key security risks by identifying core assets, 
  key threats and vulnerabilities. 

  **识别**：找出核心资产、主要威胁和漏洞，
  据此跟踪关键安全风险并排定优先级。

- **Detect**: Detect and identify vulnerabilities using techniques and tools like
  vulnerability scanning,
  static application security testing and fuzzing.

  **检测**：使用漏洞扫描、静态应用安全测试和模糊测试等
  技术与工具来发现并确认漏洞。

- **Protect**: Eliminate risks by mitigating known vulnerabilities and protect 
  critical assets against source threats.

  **防护**：处理已知漏洞以消除风险，
  并保护关键资产不受威胁来源的影响。

- **Respond**: Define processes to report, triage and respond to vulnerabilities 
  or attacks.

  **响应**：定好流程，用来报告、分类并处理漏洞或攻击。

- **Recover**: Build capabilities to contain and recover from an incident with 
  minimal impact.

  **恢复**：具备把事件控制住并恢复过来的能力，
  把影响压到最小。

## Reporting vulnerabilities

## 报告漏洞

To report a security issue, use [https://g.co/vulnz][].
Coordination and disclosure happen in the [dart-lang GitHub repos][repos]
(including [GitHub security advisories][]).
Please include a detailed description of the issue,
the steps you took to create the issue, affected versions, and any 
mitigations for the issue.
The Google Security Team will respond within 5 working days of
your report on g.co/vulnz.

要报告安全问题，请使用 [https://g.co/vulnz][]。
协调和披露在 [dart-lang GitHub 仓库][repos]
（包括 [GitHub 安全公告][GitHub security advisories]）中进行。
请附上问题的详细说明、
你复现该问题的步骤、受影响的版本，以及你知道的缓解办法。
Google 安全团队会在你通过 g.co/vulnz 提交报告后的 5 个工作日内回复。

For more information about how Google handles security issues, see
[Google's security philosophy][].

想进一步了解 Google 如何处理安全问题，请看
[Google 的安全理念][Google's security philosophy]。

##  Flagging existing issues as security-related

## 把已有 issue 标为与安全相关

If you believe that an existing issue is security-related, 
we ask that you report it via [https://g.co/vulnz][] and include 
the issue id in your report.

如果你认为某个已有 issue 与安全相关，
请通过 [https://g.co/vulnz][] 报告，
并在报告中附上该 issue 的 id。

## Supported versions

## 受支持的版本

We commit to publishing security updates for the version of Dart currently for 
the most recent [stable][] Dart release.

我们承诺为当前最新的 [稳定版][stable] Dart 发布安全更新。

[stable]: https://dart.dev/get-dart#release-channels

## Expectations

## 预期

We treat security issues equivalent to a P0 priority level 
and release a beta or patch fix
for any major security issues found
in the most recent stable release of the Dart SDK.
Any vulnerability reported for Dart websites like dart.dev does not 
require a release and will be fixed in the website itself.

我们把安全问题等同于 P0 优先级，
并对 Dart SDK 最新稳定版中发现的任何重大安全问题
发布测试版或补丁修复。
针对 dart.dev 等 Dart 网站报告的漏洞
不需要发版，会直接在网站上修复。

Dart does not have a bug bounty program.

Dart 没有漏洞赏金计划。

## Receiving security updates

## 接收安全更新

Depending on the issue and the fix release, an announcement will be made to
[dart-announce]({{site.announce}}) 
mailing list.

视问题和修复版本而定，我们会在
[dart-announce]({{site.announce}})
邮件列表上发布公告。

## Best practices

## 最佳实践

* **Keep current with the latest Dart SDK releases.**
  We regularly update Dart, and these updates might fix security
  defects discovered in previous versions.
  Check the [Dart changelog][]
  for security-related updates.

  **跟上最新的 Dart SDK 版本。**
  我们会定期更新 Dart，这些更新可能会修复
  先前版本中发现的安全缺陷。
  请查看 [Dart 变更日志][Dart changelog]
  中与安全相关的更新。

* **Keep your application's dependencies up to date.**
  Make sure you [upgrade your package dependencies][]
  to keep the dependencies up to date.
  Avoid pinning to specific versions
  for your dependencies and, if you do, make sure you check
  periodically to see if your dependencies have had security updates,
  and update the version pin accordingly.

  **让应用的依赖保持最新。**
  请 [升级 package 依赖][upgrade your package dependencies]，
  使依赖保持最新。
  避免把依赖钉死在特定版本；
  如果已经钉死，请定期检查依赖是否有安全更新，
  并相应更新所钉的版本。

[Dart changelog]: /changelog
[GitHub security advisories]: https://docs.github.com/en/code-security/security-advisories
[Google's security philosophy]: https://www.google.com/about/appsecurity/
[https://g.co/vulnz]: https://g.co/vulnz
[repos]: {{site.repo.dart.org}}/
[upgrade your package dependencies]: /tools/pub/packages#upgrading-a-dependency
