---
# title: "Google Summer of Code 2022 Results"
title: "Google Summer of Code 2022 成果"
# description: "The Google Summer of Code (GSoC) program focuses on engaging new developers worldwide with open source software development. Google…"
description: "Google Summer of Code（GSoC）计划致力于让世界各地的新开发者参与开源软件开发……"
ai-translated: true
publishDate: 2022-11-03
author: jonasfj
image: images/1tzmsHv4_tAl7Nil6XZaANw.webp
category: other
layout: blog
---


The [Google Summer of Code](https://summerofcode.withgoogle.com/) (GSoC) program focuses on engaging new developers worldwide with open source software development. Google sponsors students to work with a mentoring open source organization on a 12-week programming project during the summer. Over the past 17 years, more than 18,000 contributors have participated in Google Summer of Code.

[Google Summer of Code](https://summerofcode.withgoogle.com/)（GSoC）计划致力于让世界各地的新开发者参与开源软件开发。Google 资助学生在暑期与一个担任指导的开源组织合作，完成一个为期 12 周的编程项目。过去 17 年里，已有超过 18,000 名贡献者参加过 Google Summer of Code。

<DashImage src="images/1tzmsHv4_tAl7Nil6XZaANw.webp" alt="The logos for Google Summer of Code and Dart side-by-side." />


In 2022, Dart have participated as mentoring organization in Google Summer of Code for a third consecutive year. Following our [call for proposals in March](/blog/contributors-for-google-summer-of-code-2022), we received 50 project proposals from prospective participants around the world. Today, we spotlight some of the projects we mentored this summer. The contributors describe their projects in this post.

2022 年，Dart 连续第三年作为指导组织参加 Google Summer of Code。在[三月份发出提案征集](/blog/contributors-for-google-summer-of-code-2022)之后，我们收到了来自世界各地意向参与者的 50 份项目提案。今天，我们来重点介绍今年夏天指导的部分项目，由贡献者们在本文中亲自讲述。

## JNI Interop for Dart

## Dart 的 JNI 互操作

*By Mahesh Hegde*

*作者：Mahesh Hegde*

Android platform uses Java as its official language. To access its rich ecosystem would add great value to Dart, so I developed a Java Native Interface (JNI) interop for Dart as my GSoC project.

Android 平台以 Java 作为官方语言。能够访问其丰富的生态将为 Dart 带来巨大价值，因此我的 GSoC 项目就是为 Dart 开发 Java 原生接口（JNI）互操作。

[*`package:jnigen`*](https://pub.dev/packages/jnigen) generates bindings to enable using Java classes and methods from Dart. `jnigen` generates C bindings that wrap Java libraries, and Dart bindings that call those C bindings. The support library [`package:jni`](https://pub.dev/packages/jni) provides the common functions to initialize and access JNI*.*

[*`package:jnigen`*](https://pub.dev/packages/jnigen) 生成绑定，让你能在 Dart 中使用 Java 类和方法。`jnigen` 生成包装 Java 库的 C 绑定，以及调用这些 C 绑定的 Dart 绑定。支持库 [`package:jni`](https://pub.dev/packages/jni) 提供初始化和访问 JNI 的通用函数。

In considering the complexity of both Java and JNI, JNI interop for Dart remains experimental. The interop can wrap basic features of the Java language, such as constructors, static and instance methods and field getters. Exceptions in Java get “rethrown” in Dart along with original stack traces. The interop cannot subclass a Java class from Dart or pass callbacks. After GSoC, we plan to improve the binding generation pipeline and implement more Java language features.

考虑到 Java 和 JNI 的复杂性，Dart 的 JNI 互操作仍处于实验阶段。该互操作可以包装 Java 语言的基本特性，例如构造函数、静态和实例方法以及字段 getter。Java 中的异常会连同原始堆栈跟踪在 Dart 中“重新抛出”。目前还不能在 Dart 中继承 Java 类或传递回调。GSoC 之后，我们计划改进绑定生成流水线并实现更多 Java 语言特性。

The technical complexity of the project proved challenging. We knew there hadn’t been any Java interop attempt for a natively-compiled, high-level language using JNI. We often had to find workarounds when something didn’t work as expected, like dynamic library loading and JNI exceptions. I ended up writing several tools to aid the project. These included one to get Java sources from maven and another to build shared libraries. I learned a lot about time management, prioritization, testing, and writing neat, readable and understandable code.

这个项目的技术复杂度很有挑战性。据我们所知，此前还没有人为原生编译的高级语言尝试过基于 JNI 的 Java 互操作。当动态库加载、JNI 异常等环节不按预期工作时，我们经常得寻找变通方案。我最终写了好几个工具来辅助项目，包括一个从 maven 获取 Java 源码的工具和一个构建共享库的工具。我在时间管理、优先级排序、测试，以及编写整洁、可读、易懂的代码方面学到了很多。

## Flutter Community admin dashboard

## Flutter Community 管理后台

*By Abdelrahman Amer*

*作者：Abdelrahman Amer*

For GSoC’22, I designed and built an [admin dashboard for Flutter Community repositories on GitHub](https://github.com/fluttercommunity/admin_dashboard). The dashboard assists Flutter Community admins through aggregating the latest activities on repositories, maintainers, levels of access, and more. It contains a trigger to build and deploy to [pub.dev](https://pub.dev/). I implemented the project using Flutter for the frontend and Firebase for the backend.

在 GSoC’22 中，我设计并构建了 [Flutter Community GitHub 仓库的管理后台](https://github.com/fluttercommunity/admin_dashboard)。这个后台通过汇总仓库的最新活动、维护者、访问权限级别等信息来协助 Flutter Community 管理员。它还包含一个构建并部署到 [pub.dev](https://pub.dev/) 的触发器。我用 Flutter 实现前端，用 Firebase 实现后端。

During the project, I developed interesting reusable components, including:

在项目过程中，我开发了一些有意思的可复用组件，包括：

1. A Firebase abstraction layer

  一个 Firebase 抽象层

1. A MVC widget and associated data structure classes to display any tabular information sortable by any field

  一个 MVC widget 及配套的数据结构类，用于展示可按任意字段排序的表格信息

1. A MVC widget and data structure classes to display graphical 2D data

  一个 MVC widget 及数据结构类，用于展示二维图形数据

The admin dashboard lacks some features, but the core functionalities have been implemented. I look forward to continuing work on more features after the GSoC period.

这个管理后台还缺少一些特性，但核心功能已经实现。我期待在 GSoC 结束后继续开发更多特性。

The GSoC experience taught me valuable development skills, especially in Flutter. I am very grateful for the opportunity, the great work environment, the experience I gained, and the mentoring I received from [Majid](https://github.com/mhadaily).

GSoC 的经历教会了我宝贵的开发技能，尤其是在 Flutter 方面。我非常感激这次机会、良好的工作环境、获得的经验，以及 [Majid](https://github.com/mhadaily) 给我的指导。

## Detecting incorrect version constraints

## 检测不正确的版本约束

*By Arseny Uskov*

*作者：Arseny Uskov*

A package maintainer must assign an appropriate version to each Dart package release. They must decide whether they have introduced breaking changes to the users depending on their package. Dependent packages also assume what an appropriate version range would be for each of *their* dependencies.

package 维护者必须为每次 Dart package 发布指定合适的版本号。他们必须判断自己是否给依赖该 package 的用户引入了破坏性变更。依赖方 package 也要为*它们自己的*每个依赖假定一个合适的版本范围。

Bugs can arise from incorrect assumptions in these areas. My project sought to identify and investigate a subset of these bugs.

这些环节中的错误假设可能引发 bug。我的项目旨在识别并调查其中一部分 bug。

<DashImage src="images/187NMdHXboVklByFDhR9d2Q.webp" alt="Diagram showing an incorrect dependency constraint caused by improper versioning of package:foo." caption="An incorrect dependency constraint caused by improper versioning of `package:foo`" />


The project provides tools that summarize a portion of the public API of a given version of a given package. This summary identifies any other packages dependent on the given package that might have an incorrect version constraint. Our use case covered where a package used a symbol defined in one of its dependencies, but the same symbol did not include the lowest allowed version of that dependency.

这个项目提供了一些工具，用于汇总给定 package 给定版本的部分公共 API。这份摘要能识别出依赖该 package 的其他 package 中可能存在的错误版本约束。我们覆盖的用例是：某个 package 使用了其某个依赖中定义的符号，但该符号在依赖允许的最低版本中并不存在。

The public API summary model allows for a range of other interesting static analysis applications. We did not have time to explore them during GSoC. To learn more, refer to the [API Analysis blog post](https://arseny.uk/posts/gsoc2022/) about the project, challenges we faced, results gathered from running analysis on the pub.dev ecosystem, bugs we found in real packages, and a starting point for hacking on the project yourself.

公共 API 摘要模型还能支持一系列其他有趣的静态分析应用。我们在 GSoC 期间没有时间去探索它们。要了解更多，请参阅 [API Analysis 博客文章](https://arseny.uk/posts/gsoc2022/)，其中介绍了这个项目、我们遇到的挑战、对 pub.dev 生态运行分析得到的结果、在真实 package 中发现的 bug，以及自己动手参与项目的起点。

*Huge thanks to everyone who applied for Google Summer of Code 2022 with Dart, to the contributors who completed projects this year, and to the mentors who helped make this an awesome summer of code. If you’re interested in hearing more about Dart in Google Summer of Code, check out [our 2021 post](/blog/google-summer-of-code-2021-results).*

*衷心感谢所有申请 Dart Google Summer of Code 2022 的同学、今年完成项目的贡献者，以及帮助打造这个精彩编程之夏的导师们。如果你想了解更多 Dart 参加 Google Summer of Code 的情况，欢迎阅读[我们 2021 年的文章](/blog/google-summer-of-code-2021-results)。*
