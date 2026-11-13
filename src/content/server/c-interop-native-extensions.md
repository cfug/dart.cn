---
# title: Native extensions for the standalone Dart VM
title: 独立 Dart VM 的原生扩展
# description: The original way for command-line Dart apps to call C/C++ functions.
description: 命令行 Dart 应用调用 C/C++ 函数的原始方式。
ai-translated: true
showToc: false
sitemap: false
---

:::note
The extension mechanism that was previously discussed
on this page—_native extensions_—was removed in Dart 2.15.

本页原先介绍的扩展机制——**原生扩展**——已在 Dart 2.15 中移除。

If you need to call existing code written in C or C++, see the
[FFI documentation](/server/c-interop).

若要调用现有的 C 或 C++ 代码，请参阅
[FFI 文档](/server/c-interop)。

A mechanism that's similar to 
native extensions—the [Dart Embedding API][`include/dart_api.h`]—is
supported when the Dart VM is
embedded as a library into another application. 
For examples of how to use the Dart Embedding API, see
[these examples maintained by the community][examples].

与原生扩展类似的机制是
[Dart Embedding API][`include/dart_api.h`]，
当 Dart VM 作为库嵌入另一个应用时仍然支持。
关于如何使用 Dart Embedding API，
请参阅 [社区维护的这些示例][examples]。
:::

[`include/dart_api.h`]: {{site.repo.dart.sdk}}/blob/main/runtime/include/dart_api.h
[examples]: https://github.com/fuzzybinary/dart_shared_libray
