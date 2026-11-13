---
# title: "Google Summer of Code 2025 Results"
title: "Google Summer of Code 2025 成果"
# description: "The Google Summer of Code (GSoC) program focuses on engaging new developers worldwide with open source software development. Google…"
description: "Google Summer of Code（GSoC）计划致力于让世界各地的新开发者参与开源软件开发……"
ai-translated: true
publishDate: 2025-10-20
author: dcharkes
image: images/1AWu8hJLDQzrZqv7BxH3byA.webp
category: other
layout: blog
---


The [Google Summer of Code](https://summerofcode.withgoogle.com/) (GSoC) program focuses on engaging new developers worldwide with open source software development. Google sponsors contributors to work with a mentoring open source organization on a 12-week programming project during the summer. Over the past 20 years, more than 20,000 contributors have participated in Google Summer of Code.

[Google Summer of Code](https://summerofcode.withgoogle.com/)（GSoC）计划致力于让世界各地的新开发者参与开源软件开发。Google 资助贡献者在暑期与一个担任指导的开源组织合作，完成一个为期 12 周的编程项目。过去 20 年里，已有超过 20,000 名贡献者参加过 Google Summer of Code。

<DashImage src="images/1AWu8hJLDQzrZqv7BxH3byA.webp" alt="The Google Summer of Code logo next to the Dart logo." />


In 2025, Dart participated as a mentoring organization in Google Summer of Code for a sixth consecutive year. This year we received well over a 100 project proposals from prospective participants around the world. Today, we spotlight some of the projects we mentored this summer. The contributors describe their projects in this post.

2025 年，Dart 连续第六年作为指导组织参加 Google Summer of Code。今年我们收到了来自世界各地意向参与者的一百多份项目提案。今天，我们来重点介绍今年夏天指导的部分项目，由贡献者们在本文中亲自讲述。

## Custom iOS context menu items

## 自定义 iOS 上下文菜单项

*By Jing Shao*

*作者：Jing Shao*

A key goal in mobile app development is delivering a truly native experience. Before this project, Flutter apps on iOS had a major limitation — developers couldn’t add custom actions to the native iOS context menu. During GSoC 2025, I successfully implemented custom context menu support for Flutter iOS, which significantly enhanced Flutter apps’ interaction capabilities on iOS.

移动应用开发的一个关键目标是提供真正的原生体验。在这个项目之前，iOS 上的 Flutter 应用有一个重大限制——开发者无法向 iOS 原生上下文菜单添加自定义操作。在 GSoC 2025 期间，我成功为 Flutter iOS 实现了自定义上下文菜单支持，显著增强了 Flutter 应用在 iOS 上的交互能力。

This project created the new `IOSSystemContextMenuItemCustom` API, allowing developers to easily add custom actions to the native iOS menu through `TextField`’s `contextMenuBuilder` property; developers can add menu items with custom titles and callbacks. The implementation bridges Flutter with the native iOS UIMenu system, ensuring custom items integrate seamlessly with standard iOS menu options (copy, paste) while maintaining the native look and feel.

这个项目创建了新的 `IOSSystemContextMenuItemCustom` API，让开发者可以通过 `TextField` 的 `contextMenuBuilder` 属性轻松向 iOS 原生菜单添加自定义操作；开发者可以添加带自定义标题和回调的菜单项。实现把 Flutter 与 iOS 原生 UIMenu 系统打通，确保自定义菜单项与标准 iOS 菜单选项（复制、粘贴）无缝集成，同时保持原生的外观和体验。

With this improvement, Flutter developers can now build more expressive and feature-rich applications. This work marks an important step forward for Flutter in delivering excellent cross-platform native experiences, giving developers powerful tools to build outstanding apps. For more details, check out my technical blogs and PRs on [GitHub](https://gist.github.com/jingshao-code/f489d263bcd97a489896afafe0c99ccd). Feel free to reach out for any questions! I would like to thank my mentors [Justin ](https://github.com/justinmc)and [Huan](https://github.com/hellohuanlin) for their invaluable guidance and support throughout this project.

有了这项改进，Flutter 开发者现在可以构建更具表现力、功能更丰富的应用。这项工作是 Flutter 在提供出色跨平台原生体验方面迈出的重要一步，为开发者打造优秀应用提供了有力工具。更多细节请查看我在 [GitHub](https://gist.github.com/jingshao-code/f489d263bcd97a489896afafe0c99ccd) 上的技术博客和 PR。有任何问题欢迎随时联系！感谢我的导师 [Justin](https://github.com/justinmc) 和 [Huan](https://github.com/hellohuanlin) 在整个项目中给予的宝贵指导和支持。

Below is an example showing custom menu items like **Clear Text**, **Add Heart ❤️**, and **Uppercase** alongside standard iOS menu items in the native context menu.

下面是一个示例，展示原生上下文菜单中 **Clear Text**、**Add Heart ❤️** 和 **Uppercase** 等自定义菜单项与标准 iOS 菜单项并列的效果。

<DashImage src="images/1kkXQy4enw3Pr2or4OVlLtw.webp" alt="An animation showing a custom iOS context menu in a Flutter app with items like 'Clear Text', 'Add Heart', and 'Uppercase'." />


## Dart TUI framework

## Dart TUI 框架

*By Gedion Ezra*

*作者：Gedion Ezra*

Before this project, Dart developers who wanted to build interactive terminal applications often had to switch to Rust, Go, or Python. There was no mature text-based, user-interface (TUI) framework in Dart, limiting developers to GUIs or static CLI tools. As part of GSoC 2025, we built [Pixel Prompt](https://github.com/primequantuM4/pixel_prompt), a terminal UI framework inspired by Flutter’s declarative, component-based approach. Pixel Prompt allows developers to create dynamic interactive apps entirely in Dart.

在这个项目之前，想构建交互式终端应用的 Dart 开发者往往不得不改用 Rust、Go 或 Python。Dart 中没有成熟的文本用户界面（TUI）框架，开发者只能局限于 GUI 或静态 CLI 工具。作为 GSoC 2025 的一部分，我们构建了 [Pixel Prompt](https://github.com/primequantuM4/pixel_prompt)，一个受 Flutter 声明式、组件化方法启发的终端 UI 框架。Pixel Prompt 让开发者可以完全用 Dart 创建动态交互应用。

Pixel Prompt introduces a Component to a ComponentInstance model, inspired from Flutter’s layered architecture that maps a widget (in the widget layer) to an element layer and, in turn, to the RenderObject layer. Components describe the UI declaratively while `ComponentInstances` manage state layout and rendering. Check out a simplified version of the architecture:

Pixel Prompt 引入了 Component 到 ComponentInstance 的模型，灵感来自 Flutter 的分层架构：widget（位于 widget 层）映射到 element 层，再映射到 RenderObject 层。Component 以声明式描述 UI，而 `ComponentInstances` 管理状态、布局和渲染。下面是该架构的简化版本：

<DashImage src="images/1mDFQO27q9khSRlpThxmcKw.webp" alt="A diagram of the Pixel Prompt TUI framework architecture showing Input System, Render System, Component Tree, and Layout Engine." />


The framework supports stateful and stateless components, input handling, and optimized rendering with double buffering and ANSI diffing. This improves performance by minimizing terminal redraws and enables reliable golden testing with a virtual terminal interpreter.

该框架支持有状态和无状态组件、输入处理，以及带双缓冲和 ANSI 差分的优化渲染。这通过尽量减少终端重绘来提升性能，并借助虚拟终端解释器实现可靠的 golden 测试。

To give a visual sense of what Pixel Prompt can achieve, screenshots of some demo are available below. These demonstrate the declarative layout, interactive components, and real-time updates that the framework supports, showing that Dart can now power fully interactive terminal applications without leaving its ecosystem.

为了直观展示 Pixel Prompt 的能力，下面提供了一些演示截图。它们展示了框架支持的声明式布局、交互组件和实时更新，说明 Dart 如今无需离开自己的生态就能驱动完全交互式的终端应用。

<DashImage src="images/185MHC2CehYCqjIIb_FDQIQ.webp" alt="Terminal-based TODO list app built with Pixel Prompt." />


<DashImage src="images/1dTEQLLG7c6yfSbceRRc8pQ.webp" alt="Terminal-based stopwatch app built with Pixel Prompt." />


While Pixel Prompt already enables building core terminal applications, there’s more to come: the support for complex components like `TextArea` and `Tables`, a flex-like layout system, a dedicated animation API, and a visual debugger are planned for future contributions. Interested developers can explore open issues and contribute on the [pixel_prompt](https://github.com/primequantuM4/pixel_prompt) repo.

虽然 Pixel Prompt 已经能构建核心终端应用，但还有更多计划：对 `TextArea`、`Tables` 等复杂组件的支持、类 flex 的布局系统、专用动画 API 和可视化调试器都在后续贡献计划中。感兴趣的开发者可以在 [pixel_prompt](https://github.com/primequantuM4/pixel_prompt) 仓库浏览待解决的 issue 并参与贡献。

## TestGen — LLM-based test generation tool

## TestGen——基于 LLM 的测试生成工具

*By Amr Ahmed*

*作者：Amr Ahmed*

The primary goal of **TestGen**, an experimental project that automates unit test generation for Dart, is to improve test coverage by generating test cases that specifically **target uncovered lines** in the codebase. By leveraging large language models (LLMs) to produce meaningful tests, TestGen reduces the manual effort required to write tests, helping developers achieve higher coverage and improve code quality.

**TestGen** 是一个为 Dart 自动生成单元测试的实验性项目，它的主要目标是通过生成专门**针对代码库中未覆盖行**的测试用例来提升测试覆盖率。借助大语言模型（LLM）生成有意义的测试，TestGen 减少了手写测试的人工投入，帮助开发者获得更高覆盖率并提升代码质量。

One of the main challenges in using LLMs for automated test generation is deciding how much code context to give the model. For example, if a function needs testing and we provide the entire file as context, the LLM might get overwhelmed and produce irrelevant or inaccurate tests. If we provide only the function itself, the model can miss important dependencies inside the function, leading to incomplete or broken tests. To solve this, TestGen uses the Dart analyzer to parse the whole codebase into **Declarations,** which are classes that represent a code construct like a function, variable, class, or mixin**.** After parsing, it constructs a **dependency graph** across these declarations, which shows exactly the pieces of code on which a given declaration depends. This is done by traversing the **Abstract Syntax Tree (AST**) of a given declaration and recording its dependencies during the visit. Using this graph, TestGen can provide the LLM with only the ****relevant context *(context-aware prompting)* at a configurable depth, helping it generate accurate and focused tests without extra noise.

用 LLM 自动生成测试的主要挑战之一，是决定给模型多少代码上下文。例如，要测试一个函数时，如果把整个文件作为上下文，LLM 可能不堪重负，生成不相关或不准确的测试；如果只提供函数本身，模型又可能遗漏函数内部的重要依赖，导致测试不完整或无法运行。为解决这个问题，TestGen 使用 Dart 分析器把整个代码库解析为 **Declaration**——表示函数、变量、类或 mixin 等代码构造的类。解析之后，它在这些声明之间构建**依赖图**，精确展示某个声明依赖的代码片段。这是通过遍历声明的**抽象语法树（AST）**并在遍历过程中记录依赖来完成的。利用这张图，TestGen 可以按可配置的深度只向 LLM 提供*相关上下文*（上下文感知提示），帮助它生成准确、聚焦、没有额外噪声的测试。

<DashImage src="images/1ucv5C_h_O3tF8s5DKxKzGQ.webp" alt="Dart code for toBeTestedFunction beside a dependency graph linking it to getEmployee, globalVar, globalFunc, Employee, employees, and Person." caption="*The figure shows the dependency graph generated for the given Dart file. When testing toBeTestedFunction, the graph helps us easily retrieve all relevant context to include in the prompt. The LLM now can better understand the function and its surroundings, leading to a more effective and accurate test generation process.*" />


To make test generation effective, TestGen integrates with **`package:coverage`** to automatically detect which parts of the code are not yet tested and target those. The tool connects to **Gemini models** through `package:google_generative_ai`, *using variants like gemini-2.5-pro, gemini-2.5-flash, and gemini-2.5-flash-lite* to generate test cases. These tests then go through a validation and feedback loop, where they are executed and checked for errors. If issues are found, the errors are fed back into the LLM so it can refine the output, making the final tests more accurate and reliable.

为了让测试生成切实有效，TestGen 集成了 **`package:coverage`**，自动检测代码中尚未测试的部分并加以针对。该工具通过 `package:google_generative_ai` 连接 **Gemini 模型**，*使用 gemini-2.5-pro、gemini-2.5-flash 和 gemini-2.5-flash-lite 等变体*生成测试用例。这些测试随后进入验证与反馈循环：执行测试并检查错误。如果发现问题，就把错误反馈给 LLM 让它改进输出，使最终测试更准确、更可靠。

There is more to come for this package, including new features, improved testing, and adding support for Flutter projects. You can check the current list of issues on the [dart_testgen repo](https://github.com/AmrAhmed119/dart-testgen/issues). For a sample of how the generated prompts look, see the [default-prompt](https://github.com/AmrAhmed119/dart-testgen/blob/main/example/default_prompt.md) example. More details about the project are available in the full [GSoC report](https://github.com/AmrAhmed119/GSoC-2025-Report/blob/main/README.md).

这个 package 还有更多后续工作，包括新特性、测试改进以及对 Flutter 项目的支持。你可以在 [dart_testgen 仓库](https://github.com/AmrAhmed119/dart-testgen/issues)查看当前的 issue 列表。想看生成的提示词长什么样，请参阅 [default-prompt](https://github.com/AmrAhmed119/dart-testgen/blob/main/example/default_prompt.md) 示例。项目的更多细节见完整的 [GSoC 报告](https://github.com/AmrAhmed119/GSoC-2025-Report/blob/main/README.md)。

## LLM-powered translation of Android (Java/Kotlin) docs into Dart using JNIgen bindings

## 借助 JNIgen 绑定，用 LLM 把 Android（Java/Kotlin）文档翻译成 Dart

*By Marshelino Maged*

*作者：Marshelino Maged*

Android libraries and utilities are typically documented with Java/Kotlin code snippets. While JNIgen makes it possible to generate Dart bindings for these libraries, writing Dart code against the bindings can be challenging due to syntactic and structural differences between the languages. This means developers cannot directly reuse the many Java/Kotlin examples found in official Android documentation and tutorials. The native_doc_dartifier project was created to address this gap by automatically translating Java and Kotlin snippets in Android documentation into their Dart equivalents.

Android 库和工具通常用 Java/Kotlin 代码片段编写文档。虽然 JNIgen 可以为这些库生成 Dart 绑定，但由于语言之间语法和结构的差异，基于这些绑定编写 Dart 代码仍然很有挑战。这意味着开发者无法直接复用 Android 官方文档和教程中的大量 Java/Kotlin 示例。native_doc_dartifier 项目就是为了填补这个空缺而创建的，它把 Android 文档中的 Java 和 Kotlin 片段自动翻译成对应的 Dart 代码。

<DashImage src="images/1iC6YYhsTRRz1Cps07v5NIg.webp" alt="Java snippet calling ImageCapture.takePicture with output file options and saved and error callbacks." caption="Example Java snippet." />


<DashImage src="images/1Yalahis692k6SIKP4-N9JA.webp" alt="Dart code snippet showing the translated Java code." caption="Example snippet Translation." />


The project builds on JNIgen, which generates Dart bindings for Java and Kotlin APIs through foreign function interface (FFI). Because Java and Dart differ in both syntax and semantics, a direct translation is not sufficient. For example, Java supports method overloading while Dart does not, leading JNIgen to disambiguate bindings with renamed methods such as `add$1` and `add$2`. To generate accurate Dart code, the translation model must take these binding conventions into account rather than relying on surface-level conversion.

这个项目建立在 JNIgen 之上，后者通过外部函数接口（FFI）为 Java 和 Kotlin API 生成 Dart 绑定。由于 Java 和 Dart 在语法和语义上都不同，直接翻译并不够。例如，Java 支持方法重载而 Dart 不支持，因此 JNIgen 会用 `add$1`、`add$2` 这样的重命名方法来消除绑定的歧义。要生成准确的 Dart 代码，翻译模型必须考虑这些绑定约定，而不是只做表面转换。

A major technical challenge was scale: bindings for Android libraries often include hundreds of thousands of lines of boilerplate code, **far exceeding the input limits** of even the largest language models (currently 1M token). To address this, the project introduced **Abstract Syntax Tree (AST) extraction**, which reduces the bindings to their public API surface — resulting in about **6%** of the original size — while preserving critical information. This was combined with **retrieval-augmented generation (RAG)**, where each class’s AST is stored separately and only the most relevant classes are retrieved based on the snippet being translated.

一个重大技术挑战是规模：Android 库的绑定往往包含数十万行样板代码，**远超**最大语言模型的输入上限（目前为 100 万 token）。为解决这个问题，项目引入了**抽象语法树（AST）提取**，把绑定精简到公共 API 表面——只有原始规模的约 **6%**——同时保留关键信息。再结合**检索增强生成（RAG）**：每个类的 AST 单独存储，翻译时只根据待翻译片段检索最相关的类。

By combining **AST extraction with retrieval-based context selection**, `native_doc_dartifier` is able to produce Dart translations that are both accurate and aligned with the generated bindings, while remaining efficient within LLM context constraints. The result is a practical solution that reduces friction for Dart developers working with Android documentation and strengthens interoperability between the Java/Kotlin and Flutter ecosystems.

通过把 **AST 提取与基于检索的上下文选择**相结合，`native_doc_dartifier` 能生成既准确又与生成的绑定保持一致的 Dart 翻译，同时在 LLM 上下文限制内保持高效。最终成果是一个实用方案，减少了 Dart 开发者使用 Android 文档时的阻力，并加强了 Java/Kotlin 与 Flutter 生态之间的互操作。

Since translations are generated by an LLM, occasional errors can occur when compiling the produced Dart code. To improve reliability, the system incorporates a feedback loop: compilation errors are returned to the LLM for several iterations, allowing it to refine and correct the translation until a working version is produced. This iterative approach further increases the robustness of the generated examples.

由于翻译由 LLM 生成，编译产出的 Dart 代码时偶尔会出错。为提升可靠性，系统加入了反馈循环：把编译错误返回给 LLM 迭代若干轮，让它不断修正翻译，直到产出可运行的版本。这种迭代方式进一步增强了生成示例的健壮性。

For more information, visit the [native_doc_dartifier](https://github.com/dart-lang/native/tree/main/pkgs/native_doc_dartifier) repo.

更多信息请访问 [native_doc_dartifier](https://github.com/dart-lang/native/tree/main/pkgs/native_doc_dartifier) 仓库。

## Translate TS Declarations to Dart JS Interop Interfaces

## 把 TS 声明翻译成 Dart JS 互操作接口

*By Nikechukwu Okoronkwo*

*作者：Nikechukwu Okoronkwo*

<DashImage src="images/1dljRp-oi3pUFHHsdX6gYdQ.webp" alt="A side-by-side comparison of TypeScript interface declarations and the generated Dart extension types." />


Dart provides powerful interop with JavaScript through `dart:js_interop`, which can be used to interface with code written in JavaScript. However, writing bindings for large libraries and packages can be time-consuming and error-prone. To solve this, we created the JS Interop Generator. It automatically generates Dart wrappers from a [TypeScript declaration file](https://www.typescriptlang.org/docs/handbook/declaration-files/by-example.html) (`.d.ts`). This helps with Dart’s adoption on the web and allows Dart and Flutter developers to more easily leverage the vast ecosystem of JS libraries from NPM and elsewhere.

Dart 通过 `dart:js_interop` 提供强大的 JavaScript 互操作能力，可用于对接 JavaScript 编写的代码。然而，为大型库和 package 手写绑定既耗时又容易出错。为解决这个问题，我们创建了 JS Interop Generator。它从 [TypeScript 声明文件](https://www.typescriptlang.org/docs/handbook/declaration-files/by-example.html)（`.d.ts`）自动生成 Dart 包装器。这有助于 Dart 在 Web 上的普及，让 Dart 和 Flutter 开发者更容易利用 NPM 等来源的庞大 JS 库生态。

The generator works by parsing a `.d.ts` file and transforming its TypeScript declarations into their Dart equivalents. The declarations are generated based on how Dart interops with JS, ensuring correctness in terms of interop implementation with the JS code represented by the TS declaration code, as well as closeness to the TS declaration’s representation of the code, where possible.

生成器的工作方式是解析 `.d.ts` 文件，把其中的 TypeScript 声明转换成对应的 Dart 声明。声明基于 Dart 与 JS 的互操作方式生成，既确保与 TS 声明所表示的 JS 代码在互操作实现上的正确性，也在可能的情况下尽量贴近 TS 声明对代码的表示。

It supports a wide range of TS features, including variables, functions, enums, classes, interfaces, namespaces, and type-aliases. The generator produces equivalent Dart representations of TS types and leverages existing types from `dart:js_interop` and `package:web` when possible. This includes support for advanced TypeScript features like anonymous objects, anonymous closures, unions, merged types, and `typeof` / `keyof`.

它支持广泛的 TS 特性，包括变量、函数、枚举、类、接口、命名空间和类型别名。生成器为 TS 类型生成等价的 Dart 表示，并尽可能复用 `dart:js_interop` 和 `package:web` 中的现有类型。这包括对匿名对象、匿名闭包、联合类型、合并类型以及 `typeof` / `keyof` 等高级 TypeScript 特性的支持。

You can see many examples in the [integration test suite](https://github.com/dart-lang/web/tree/main/web_generator/test/integration/interop_gen). We’ve already used the generator to successfully create bindings for popular packages like [nanoid](https://www.npmjs.com/package/nanoid) and [uuid](https://www.npmjs.com/package/uuid). For more details on this, see the [generator test results](https://gist.github.com/nikeokoronkwo/dd83becbb6cee4d98f63556ba108e14b).

你可以在[集成测试套件](https://github.com/dart-lang/web/tree/main/web_generator/test/integration/interop_gen)中看到大量示例。我们已经用这个生成器成功为 [nanoid](https://www.npmjs.com/package/nanoid) 和 [uuid](https://www.npmjs.com/package/uuid) 等热门 package 创建了绑定。更多细节见[生成器测试结果](https://gist.github.com/nikeokoronkwo/dd83becbb6cee4d98f63556ba108e14b)。

The project is available in the `web_generator` package in the [web repo](https://github.com/dart-lang/web). You can try it out by running the `bin/gen_interop_bindings.dart` script. If you encounter any issues or bugs, feel free to file an issue and/or contribute!

这个项目位于 [web 仓库](https://github.com/dart-lang/web)的 `web_generator` package 中。运行 `bin/gen_interop_bindings.dart` 脚本即可试用。如果遇到任何问题或 bug，欢迎提 issue 和/或参与贡献！
