---
# title: Breaking changes and deprecations
title: 破坏性变更与弃用
breadcrumb: Legacy
# description: A list of breaking changes by release in Dart.
description: "按 Dart 版本列出的破坏性变更清单。"
ai-translated: true
maxTocDepth: 2
lastVerified: 2026-05-19
---

{% assign versioned = '<span class="tag-label language-versioned-tag">Language versioned</span>' %}
{% assign deprecated = '<span class="tag-label deprecated-tag">Deprecated</span>' %}
{% assign removed = '<span class="tag-label removed-tag">Removed</span>' %}
{% assign experimental = '<span class="tag-label experimental-tag">Experimental</span>' %}

:::warning
**This page has been deprecated.**
See the [Changelog](/changelog) for changes to the language and SDK,
and [Language versioning](/language/versioning) for how versioning is used
with Dart and the SDK.

**本页已弃用。**
语言和 SDK 的变更请参阅 [更新日志](/changelog)，
Dart 和 SDK 如何使用版本控制
请参阅 [语言版本控制](/language/versioning)。
:::

This page lists all breaking changes and deprecations in
updates to the Dart SDK, organized by release and area,
to help Dart developers understand and manage their impact.
Complete release notes are available in the [Dart SDK changelog][changelog].
The [breaking change policy][] document describes the policy and process
around breaking changes and deprecations in Dart.

本页按版本和领域列出 Dart SDK 更新中的
所有破坏性变更和弃用，
帮助 Dart 开发者理解和管理它们的影响。
完整的发布说明见 [Dart SDK 更新日志][changelog]。
[破坏性变更政策][breaking change policy] 文档描述了
Dart 中破坏性变更和弃用的政策与流程。

**This page includes the following types of breaking changes:**

**本页包含以下类型的破坏性变更：**

**Unversioned**
: The Dart SDK doesn't maintain backward compatibility,
  and code might break as soon as you [upgrade your sdk version][sdk] if
  it relies on the previous behavior.

  _These are the majority of changes and aren't specially marked in this list._

**不随版本生效（Unversioned）**
: Dart SDK 不维护向后兼容，
  如果代码依赖旧行为，[升级 SDK 版本][sdk]后
  可能立即失效。

  _这类变更占大多数，在本列表中不做特殊标记。_

**Language versioned**
: The Dart SDK maintains backward compatibility for existing code,
  and the behavior change only takes effect (potentially breaking
  code that relies on the previous behavior) when you
  upgrade the [language version][] of your code.

  _These are marked as:_ {{versioned}}

**随语言版本生效（Language versioned）**
: Dart SDK 为现有代码维护向后兼容，
  只有当你升级代码的 [语言版本][language version] 时，
  行为变更才会生效（可能破坏依赖旧行为的代码）。

  _这类变更标记为：_ {{versioned}}

**Deprecations**
: The Dart SDK maintains compatibility for deprecated code, with a warning.
  Deprecations are then completely removed in a later release,
  breaking any code that relies on the previous behavior.

  _These are marked as:_ {{deprecated}} / {{removed}}

**弃用（Deprecations）**
: Dart SDK 为已弃用的代码保持兼容，但会给出警告。
  弃用的内容会在之后的版本中完全移除，
  破坏任何依赖旧行为的代码。

  _这类变更标记为：_ {{deprecated}} / {{removed}}

**Experimental**
: Part of the release but not yet treated as stable in the SDK and
  can break from one version to another.
  Experimental changes don't always have a corresponding breaking change issue,
  but might have more details in the [SDK changelog][changelog].

  These are marked: {{experimental}}

**实验性（Experimental）**
: 属于发布的一部分，但在 SDK 中尚未被视为稳定，
  可能在不同版本之间发生变化。
  实验性变更不一定有对应的破坏性变更 issue，
  但可能在 [SDK 更新日志][changelog] 中有更多细节。

  这类变更标记为：{{experimental}}

If you have questions or concerns about any of these breaking changes,
please comment on the breaking change issue linked from the relevant entry.
To be notified about future breaking changes, join the [Dart announce][] group.

如果你对这些破坏性变更有任何疑问或顾虑，
请在相关条目链接的破坏性变更 issue 中评论。
要获得未来破坏性变更的通知，请加入 [Dart announce][] 群组。

[breaking change policy]: {{site.repo.dart.sdk}}/blob/main/docs/process/breaking-changes.md
[changelog]: {{site.repo.dart.sdk}}/blob/main/CHANGELOG.md
[sdk]: /get-dart
[language version]: /language/versioning
[Dart announce]: {{site.announce}}

{% comment %}
Create a new section from these headers for each release.
If no changes exist in a section (such as Language, `dart:async`, etc.),
don't include the section header.

## x.x.x

### Language

### 语言

### Libraries

### 库

#### (`dart:core`, `package:js`, etc)

### Tools

### 工具

#### (Dart VM, Pub, Linter, `dart2js`, etc)
{% endcomment %}

## 3.13.0

### Language

### 语言

- {{versioned}}
  You can no longer use `final` or `var` on non-declaring parameters.
  Dart now reserves both for
  [declaring parameters in primary constructors][primary constructors].
  Remove `final` or `var` from affected parameter declarations.
  If you still want to prevent parameter reassignment,
  you can use the [`parameter_assignments`][] lint rule.

  {{versioned}}
  不能再在非声明参数上使用 `final` 或 `var`。
  Dart 现在把两者都保留给
  [在主构造函数中声明参数][primary constructors]。
  请从受影响的参数声明中移除 `final` 或 `var`。
  如果仍想禁止参数重新赋值，
  可以使用 [`parameter_assignments`][] lint 规则。
- Type promotion in inner generator functions has been [adjusted][62889].

  内部生成器函数中的类型提升已[调整][62889]。

[62889]: {{site.repo.dart.sdk}}/issues/62889
[primary constructors]: /language/primary-constructors#field-declarations-in-parameters
[`parameter_assignments`]: /tools/linter-rules/parameter_assignments

### Libraries

### 库

#### `dart:io`

- `NetworkInterface.addresses` [now returns `List<InterfaceAddress>`][63216]
  instead of `List<InternetAddress>`.
  The new `InterfaceAddress` subtype of `InternetAddress`
  exposes a `prefixLength` field and a `broadcast` getter.
  Code that implements `NetworkInterface` and overrides `addresses`
  must update the return type.

  `NetworkInterface.addresses` [现在返回 `List<InterfaceAddress>`][63216]，
  而不是 `List<InternetAddress>`。
  `InternetAddress` 的新子类型 `InterfaceAddress`
  暴露了 `prefixLength` 字段和 `broadcast` getter。
  实现 `NetworkInterface` 并重写 `addresses` 的代码
  必须更新返回类型。
- `InternetAddress.lookup` no longer accepts invalid IPv4 addresses
  that are traditionally accepted by `inet_aton`.

  `InternetAddress.lookup` 不再接受
  传统上被 `inet_aton` 接受的无效 IPv4 地址。

[63216]: {{site.repo.dart.sdk}}/issues/63216

#### `dart:js_interop`

- `JSFunction` and `JSExportedDartFunction` are [now generic][54557].
  `JSExportedDartFunction<T>.toDart` now casts
  the original wrapped function to the type argument `T`,
  and `isA<JSExportedDartFunction<T>>` now also
  checks that the wrapped function is a `T`.
  The runtime types of `JSFunction` and `JSExportedDartFunction` don't change.

  `JSFunction` 和 `JSExportedDartFunction` [现在是泛型的][54557]。
  `JSExportedDartFunction<T>.toDart` 现在把
  被包装的原函数转换为类型实参 `T`，
  `isA<JSExportedDartFunction<T>>` 现在还会
  检查被包装的函数是否为 `T`。
  `JSFunction` 和 `JSExportedDartFunction` 的运行时类型不变。

[54557]: {{site.repo.dart.sdk}}/issues/54557

### Tools

### 工具

### Analyzer

### 分析器

- {{deprecated}}
  The [`avoid_private_typedef_functions`][] lint rule
  is deprecated and should be removed from `analysis_options.yaml` files.

  {{deprecated}}
  [`avoid_private_typedef_functions`][] lint 规则
  已弃用，应从 `analysis_options.yaml` 文件中移除。

- {{deprecated}}
  The [`one_member_abstracts`][] lint rule
  is deprecated and should be removed from `analysis_options.yaml` files.

  {{deprecated}}
  [`one_member_abstracts`][] lint 规则
  已弃用，应从 `analysis_options.yaml` 文件中移除。

[`avoid_private_typedef_functions`]: /tools/linter-rules/avoid_private_typedef_functions
[`one_member_abstracts`]: /tools/linter-rules/one_member_abstracts

#### Formatter (`dart format`)

#### 格式化器（`dart format`）

- Stopped adding a blank line before a comment at
  the end of a compilation unit or braced body.

  不再在编译单元或花括号体末尾的注释前
  添加空行。
- Extension type representation clauses are now formatted the same way
  primary constructor formal parameter lists are formatted.

  扩展类型表示子句的格式化方式
  现在与主构造函数形参列表相同。
- When [trailing commas are preserved][trailing-commas],
  no longer insert a newline before the `;` in an enum with members
  unless there is a trailing comma.

  [保留尾随逗号][trailing-commas]时，
  除非有尾随逗号，否则不再在带成员的 enum 的 `;` 前
  插入换行。
- Fixed a bug where some collections or arguments might split unnecessarily.

  修复了某些集合或实参可能不必要拆行的 bug。

- {{versioned}}
  Parameter lists can now be block formatted.

  {{versioned}}
  参数列表现在可以按块格式化。
- {{versioned}}
  `as`, `is`, and `is!` expressions can now be block formatted.

  {{versioned}}
  `as`、`is` 和 `is!` 表达式现在可以按块格式化。
- {{versioned}}
  Blank lines are added around `mixin` and `extension type` declarations
  if they don't have a `;` body.

  {{versioned}}
  如果 `mixin` 和 `extension type` 声明没有 `;` 体，
  会在其周围添加空行。
- {{versioned}}
  Imports are now separated into sections.

  {{versioned}}
  导入现在按节分隔。
- {{versioned}}
  Trailing commas are now added to split extension type representation clauses.

  {{versioned}}
  拆行的扩展类型表示子句现在会添加尾随逗号。

[trailing-commas]: /tools/analysis#trailing_commas

### Runtime

### 运行时

- {{removed}}
  The built-in fallback root certificates used when
  system certificates can't be found are no longer included.
  If the system certificates can't be found,
  use the `--root-certs-file` or `--root-certs-cache` options
  to provide fallback certificates to the standalone Dart VM.

  {{removed}}
  不再内置找不到系统证书时使用的
  备用根证书。
  如果找不到系统证书，
  请使用 `--root-certs-file` 或 `--root-certs-cache` 选项
  为独立 Dart VM 提供备用证书。

#### Embedder API

#### 嵌入器 API

- `Dart_FileModifiedCallback` in `runtime/include/dart_tools_api.h` now
  passes `int64_t since` as microseconds from epoch instead of milliseconds.

  `runtime/include/dart_tools_api.h` 中的 `Dart_FileModifiedCallback`
  现在以微秒（而非毫秒）传递自纪元以来的 `int64_t since`。

## 3.12.0

### Libraries

### 库

#### `dart:js_interop`

- The `isA` extension method has
  [moved from `JSAnyUtilityExtension` to `NullableObjectUtilExtension`][56905]
  to support type-checking any `Object?`.
  This change is only breaking if you referred to the extension name directly,
  either by applying the extension directly or through `show`/`hide` directives.

  `isA` extension 方法已
  [从 `JSAnyUtilityExtension` 移到 `NullableObjectUtilExtension`][56905]，
  以支持对任何 `Object?` 做类型检查。
  只有当你直接引用 extension 名称时
  （直接应用 extension 或通过 `show`/`hide` 指令），
  这个变更才是破坏性的。
- `isA<JSObject>()` now correctly handles JS objects with no prototypes,
  and `isA<JSAny>()` does a non-trivial check that the value is a JS value.

  `isA<JSObject>()` 现在能正确处理没有原型的 JS 对象，
  `isA<JSAny>()` 会做非平凡检查，确认值是 JS 值。
- `isA<JSExportedDartFunction>()` now checks whether the function is
  actually a JS wrapper function that's returned from
  `Function.toJS` or `Function.toJSCaptureThis`.

  `isA<JSExportedDartFunction>()` 现在会检查函数是否
  确实是由 `Function.toJS` 或 `Function.toJSCaptureThis`
  返回的 JS 包装函数。

[56905]: {{site.repo.dart.sdk}}/issues/56905

### Tools

### 工具

#### Pub

#### Pub

- `dart pub cache repair` now only repairs the packages referenced
  by the current project's `pubspec.lock` file by default.
  To repair all packages in the pub cache as in previous releases,
  pass the new `--all` flag.

  `dart pub cache repair` 现在默认只修复
  当前项目 `pubspec.lock` 文件引用的 package。
  要像以前的版本一样修复 pub 缓存中的所有 package，
  请传入新的 `--all` 参数。

#### Wasm compiler (dart2wasm)

#### Wasm 编译器（dart2wasm）

- The deferred loading module loader API has been updated to allow
  batched fetching of deferred modules.
  The embedder now takes `loadDeferredModules` instead of `loadDeferredModule`,
  where the new function should expect an array of module names
  rather than individual module names.
  All the module loading functions must now also accept an `instantiator`
  callback to which they should pass the loaded results.

  延迟加载的模块加载器 API 已更新，
  支持批量获取延迟模块。
  嵌入器现在接受 `loadDeferredModules` 而非 `loadDeferredModule`，
  新函数应期望一个模块名数组，
  而不是单个模块名。
  所有模块加载函数现在还必须接受一个 `instantiator` 回调，
  并把加载结果传给它。

#### Production JavaScript compiler (dart2js)

#### 生产 JavaScript 编译器（dart2js）

- `JSExportedDartFunction.toDart` now throws if the wrapper JS function
  wasn't a result of `Function.toJS` or `Function.toJSCaptureThis`,
  to be consistent with DDC and dart2wasm.
  Previously, it would sometimes incorrectly return the
  original Dart function even if the wrapper JS function was
  cast from a call to the deprecated `allowInterop` function.

  为与 DDC 和 dart2wasm 保持一致，
  如果包装的 JS 函数不是 `Function.toJS` 或
  `Function.toJSCaptureThis` 的结果，
  `JSExportedDartFunction.toDart` 现在会抛出异常。
  以前，即使包装的 JS 函数是从已弃用的
  `allowInterop` 函数调用转换而来，
  它有时也会错误地返回原 Dart 函数。

## 3.11.0

### Tools

### 工具

#### Analyzer

#### 分析器

- {{deprecated}}
  The [`avoid_null_checks_in_equality_operators`][] lint rule
  is deprecated and should be removed from `analysis_options.yaml` files.

  {{deprecated}}
  [`avoid_null_checks_in_equality_operators`][] lint 规则
  已弃用，应从 `analysis_options.yaml` 文件中移除。

- {{deprecated}}
  The [`prefer_final_parameters`][] lint rule
  is deprecated and should be removed from `analysis_options.yaml` files.

  {{deprecated}}
  [`prefer_final_parameters`][] lint 规则
  已弃用，应从 `analysis_options.yaml` 文件中移除。

- {{deprecated}}
  The [`use_if_null_to_convert_nulls_to_bools`][] lint rule
  is deprecated and should be removed from `analysis_options.yaml` files.

  {{deprecated}}
  [`use_if_null_to_convert_nulls_to_bools`][] lint 规则
  已弃用，应从 `analysis_options.yaml` 文件中移除。

[`avoid_null_checks_in_equality_operators`]: /tools/linter-rules/avoid_null_checks_in_equality_operators
[`prefer_final_parameters`]: /tools/linter-rules/prefer_final_parameters
[`use_if_null_to_convert_nulls_to_bools`]: /tools/linter-rules/use_if_null_to_convert_nulls_to_bools

#### Wasm compilation (`dart compile wasm`)

#### Wasm 编译（`dart compile wasm`）

- {{removed}}
  Code that imports `dart:js_util` or `package:js` now
  [results in a compilation error][61550] when compiling to WebAssembly.

  Invoking any API from these libraries will result in a runtime error.
  Usages should be migrated to `dart:js_interop` and `dart:js_interop_unsafe`.

  {{removed}}
  导入 `dart:js_util` 或 `package:js` 的代码
  编译到 WebAssembly 时现在会[产生编译错误][61550]。

  调用这些库的任何 API 都会导致运行时错误。
  用法应迁移到 `dart:js_interop` 和 `dart:js_interop_unsafe`。

[61550]: {{site.repo.dart.sdk}}/issues/61550

## 3.10.0

### Language

### 语言

- `sync*` and `async*` generator functions without a specified return now
  correctly infer return types as non-nullable when no `null` value is yielded.
  This might trigger new diagnostics related to unnecessary code elements,
  such as an unnecessary null-aware access operator (`?.`).

  未指定返回类型的 `sync*` 和 `async*` 生成器函数，
  在没有 yield 出 `null` 值时，
  现在能正确推断返回类型为非空。
  这可能触发与不必要代码元素相关的新诊断，
  例如不必要的空感知访问运算符（`?.`）。

### Libraries

### 库

#### `dart:core`

- The `Uri.parseIPv4Address` and `Uri.parseIPv6Address` functions
  [no longer incorrectly allow][61392] leading zeros in IPv4 addresses.

  `Uri.parseIPv4Address` 和 `Uri.parseIPv6Address` 函数
  [不再错误地允许][61392] IPv4 地址中的前导零。

- {{deprecated}}
  The ability to implement `RegExp` and `RegExpMatch` is deprecated
  and will be removed in a future release.

  {{deprecated}}
  实现 `RegExp` 和 `RegExpMatch` 的能力已弃用，
  将在未来版本中移除。

[61392]: {{site.repo.dart.sdk}}/issues/61392

#### `dart:io`

- `IOOverrides` can [no longer be implemented][56468],
  but can still be extended.

  `IOOverrides` [不能再被实现][56468]，
  但仍可以被继承。

[56468]: {{site.repo.dart.sdk}}/issues/56468

#### `dart:js_interop`

- The `Uint16ListToJSInt16Array` extension has been
  renamed to `Uint16ListToJSUint16Array`.

  `Uint16ListToJSInt16Array` extension
  已重命名为 `Uint16ListToJSUint16Array`。

- The `JSUint16ArrayToInt16List` extension has been
  renamed to `JSUint16ArrayToUint16List`.

  `JSUint16ArrayToInt16List` extension
  已重命名为 `JSUint16ArrayToUint16List`。

- The `Function.toJSCaptureThis` function now results in additional
  compile-time checks to match `Function.toJS`.
  If the function doesn't have a statically known type,
  has unsupported types in its signature, includes type parameters,
  or has any named parameters, the call will result in a compile-time error.

  `Function.toJSCaptureThis` 函数现在会进行额外的
  编译时检查，与 `Function.toJS` 保持一致。
  如果函数没有静态已知的类型、
  签名中包含不支持的类型、包含类型参数，
  或有任何命名参数，调用将产生编译时错误。

### Tools

### 工具

#### SDK

- The `dart` CLI and Dart VM are now separate executables,
  with the pure Dart VM executable and process called `dartvm`.
  Dart programs should still be run with [`dart run`][].

  `dart` CLI 和 Dart VM 现在是独立的可执行文件，
  纯 Dart VM 的可执行文件和进程名为 `dartvm`。
  Dart 程序仍应使用 [`dart run`][] 运行。

- Subcommands of the `dart` tool, such as `dart format` and `dart compile`
  now run AOT-compiled snapshots of the underlying tools.
  There should be no functional difference outside of performance improvements,
  but if you come across incompatibilities, please [report them][sdk report].

  `dart` 工具的子命令（如 `dart format` 和 `dart compile`）
  现在运行底层工具的 AOT 编译快照。
  除性能提升外不应有功能差异，
  但如果遇到不兼容问题，请[报告][sdk report]。

- {{removed}}
  The `dart` tool is no longer available for IA32 platforms
  as the Dart SDK no longer supports IA32.

  {{removed}}
  由于 Dart SDK 不再支持 IA32，
  `dart` 工具不再提供 IA32 平台版本。

[`dart run`]: /tools/dart-run
[sdk report]: {{site.repo.dart.sdk}}/issues/new/choose

#### Analyzer

#### 分析器

- Using members marked as `@experimental` outside
  the package they are declared in
  now results in a warning.

  在声明 `@experimental` 成员的 package 之外使用它们，
  现在会产生警告。

- Lint rules enabled in included analysis options files
  now result in incompatible lint diagnostics when appropriate.

  在被包含的分析选项文件中启用的 lint 规则，
  现在会在适当时产生不兼容的 lint 诊断。

- {{removed}}
  The deprecated `@required` annotation from
  `package:meta` is no longer supported.
  To mark a parameter as required, instead use the `required` keyword.

  {{removed}}
  不再支持 `package:meta` 中已弃用的 `@required` 注解。
  要把参数标记为必需，请改用 `required` 关键字。

#### Wasm compilation (`dart compile wasm`)

#### Wasm 编译（`dart compile wasm`）

- `dart:js_util` and `package:js` are [no longer supported][61550] when
  compiling to WebAssembly.
  Invoking any API from these libraries will result in a runtime error.
  Usages should be migrated to `dart:js_interop` and `dart:js_interop_unsafe`.

  编译到 WebAssembly 时
  [不再支持][61550] `dart:js_util` 和 `package:js`。
  调用这些库的任何 API 都会导致运行时错误。
  用法应迁移到 `dart:js_interop` 和 `dart:js_interop_unsafe`。

- To match the JS compilers, `dartify` when compiled to Wasm,
  [now converts][54573] JS `Promise` objects to Dart `Future` objects
  instead of Dart `JSValue` objects. 

  为与 JS 编译器保持一致，编译到 Wasm 时 `dartify`
  [现在把][54573] JS `Promise` 对象转换为 Dart `Future` 对象，
  而不是 Dart `JSValue` 对象。

[61550]: {{site.repo.dart.sdk}}/issues/61550
[54573]: {{site.repo.dart.sdk}}/issues/54573

## 3.9.0

### Language

### 语言

- {{versioned}}
  Null safety is now assumed when computing
  type promotion, reachability, and definite assignment.
  As a result, improved dead code analysis might
  cause new analyzer diagnostics to trigger on
  existing code that previously passed analysis.

  {{versioned}}
  计算类型提升、可达性和确定赋值时
  现在假定空安全。
  因此，改进后的死代码分析可能
  在以前能通过分析的现有代码上
  触发新的分析器诊断。

### Tools

### 工具

- Some subcommands of the `dart` tool, such as `dart analyze` and `dart fix`
  now run AOT-compiled snapshots of the underlying tools.
  There should be no functional difference outside of performance improvements,
  but if you come across incompatibilities, please [report them][sdk report].

  `dart` 工具的部分子命令（如 `dart analyze` 和 `dart fix`）
  现在运行底层工具的 AOT 编译快照。
  除性能提升外不应有功能差异，
  但如果遇到不兼容问题，请[报告][sdk report]。

[sdk report]: {{site.repo.dart.sdk}}/issues/new/choose

#### Pub

#### Pub

- {{versioned}}
  The upper bound of the  `flutter` SDK constraint
  in your workspace's root package is now respected.
  If your current SDK doesn't meet the specified bound,
  `dart pub get` and other actions that retrieve dependencies will fail.

  {{versioned}}
  现在会遵守工作区根 package 中
  `flutter` SDK 约束的上界。
  如果当前 SDK 不满足指定的界限，
  `dart pub get` 和其他获取依赖的操作将失败。

#### Dart build

#### Dart build

- {{experimental}}
  Building a CLI app bundle with experimental native asset support now
  requires using the `dart build cli` subcommand and
  specifying the app entrypoint with a new `--target` option.

  {{experimental}}
  使用实验性原生资源支持构建 CLI 应用包，
  现在需要使用 `dart build cli` 子命令，
  并用新的 `--target` 选项指定应用入口。

## 3.8.0

### Libraries

### 库

#### `dart:html`

- {{removed}}
  The `Element.created` constructor has been removed.

  {{removed}}
  `Element.created` 构造函数已被移除。
- Native classes in `dart:html`, such as `HtmlElement`,
  [can no longer be extended][53264].

  `dart:html` 中的原生类（如 `HtmlElement`）
  [不能再被继承][53264]。

[53264]: {{site.repo.dart.sdk}}/issues/53264

### Tools

### 工具

#### Analyzer

#### 分析器

- {{deprecated}}
  The [`avoid_null_checks_in_equality_operators`][] lint rule
  is deprecated and should be removed from `analysis_options.yaml` files.

  {{deprecated}}
  [`avoid_null_checks_in_equality_operators`][] lint 规则
  已弃用，应从 `analysis_options.yaml` 文件中移除。

[`avoid_null_checks_in_equality_operators`]: /tools/linter-rules/avoid_null_checks_in_equality_operators

#### Development JavaScript compiler (DDC)

#### 开发 JavaScript 编译器（DDC）

- Now throws a runtime error when a
  redirecting factory constructor is [torn off][tear-offs] and
  one of its optional non-nullable parameters is provided no value.
  In the future this is likely to be a compile-time error.

  当重定向工厂构造函数被 [tear-off][tear-offs]，
  且其某个可选非空参数没有提供值时，
  现在会抛出运行时错误。
  未来这很可能成为编译时错误。

[tear-offs]: /language/functions#tear-offs

#### Production JavaScript compiler (dart2js)

#### 生产 JavaScript 编译器（dart2js）

- {{experimental}} {{removed}}
  The `--experiment-new-rti` and `--use-old-rti` flags are no longer supported.

  {{experimental}} {{removed}}
  不再支持 `--experiment-new-rti` 和 `--use-old-rti` 参数。

#### Formatter (`dart format`)

#### 格式化器（`dart format`）

- {{versioned}}
  The formatter made changes and fixes that result in new output when
  formatting code with a [language version][] of 3.8 or greater.

  {{versioned}}
  格式化器做了一些变更和修复，
  格式化 [语言版本][language version] 为 3.8 或更高的代码时
  会产生新的输出。

[language version]: /language/versioning

## 3.7.0

### Language

### 语言

- {{versioned}} [Local variables and parameters named `_`][wildcards] are
  now non-binding and can no longer be used or accessed.

  {{versioned}} [名为 `_` 的局部变量和参数][wildcards]
  现在是非绑定的，不能再被使用或访问。
- [Reachability analysis now accounts for if a field is
  type promoted to `Null` using `is` or `as`][56893].
  This makes the type system more self-consistent, because it
  mirrors the behavior of promoted local variables.
  This change isn't expected to make any difference in practice.

  [可达性分析现在会考虑字段是否
  通过 `is` 或 `as` 被类型提升为 `Null`][56893]。
  这让类型系统更加自洽，
  因为它与已提升局部变量的行为一致。
  预计这个变更在实践中不会有任何影响。

[wildcards]: /language/variables#wildcard-variables
[56893]: {{site.repo.dart.sdk}}/issues/56893

### Libraries

### 库

#### `dart:html`, `dart:indexed:db`, `dart:svg`, `dart:web_audio`, `dart:web_gl`, `dart:js`

- {{deprecated}} These legacy web libraries are officially deprecated.
  They are expected to be removed in a future release.
  Project should migrate to use [`package:web`][] and `dart:js_interop`.
  To learn more, check out [Migrate to `package:web`][].

  {{deprecated}} 这些遗留 Web 库已正式弃用，
  预计将在未来版本中移除。
  项目应迁移到 [`package:web`][] 和 `dart:js_interop`。
  了解更多请参阅 [迁移到 `package:web`][Migrate to `package:web`]。

[`package:web`]: {{site.pub-pkg}}/web
[Migrate to `package:web`]: /interop/js-interop/package-web

#### `dart:js`, `dart:js_util`, `package:js`

- {{deprecated}} These legacy JS-interop libraries are officially deprecated.
  They are expected to be removed in a future release.
  Projects should migrate to use `dart:js_interop`.
  To learn more, check out [JS interop usage][].

  {{deprecated}} 这些遗留 JS 互操作库已正式弃用，
  预计将在未来版本中移除。
  项目应迁移到 `dart:js_interop`。
  了解更多请参阅 [JS 互操作用法][JS interop usage]。

[JS interop usage]: /interop/js-interop/usage

### Tools

### 工具

#### Analyzer

#### 分析器

- {{removed}} The [`package_api_docs`][] and [`unsafe_html`][] lint rules
  have been removed and should be removed from `analysis_options.yaml` files.

  {{removed}} [`package_api_docs`][] 和 [`unsafe_html`][] lint 规则
  已被移除，应从 `analysis_options.yaml` 文件中删除。

[`package_api_docs`]: /tools/linter-rules/package_api_docs
[`unsafe_html`]: /tools/linter-rules/unsafe_html

#### Formatter (`dart format`)

#### 格式化器（`dart format`）

- {{versioned}} The formatter implements a [new style][] that results in
  new output when formatting code with a [language version][] of 3.7 or greater.

  {{versioned}} 格式化器实现了[新风格][new style]，
  格式化 [语言版本][language version] 为 3.7 或更高的代码时
  会产生新的输出。
- {{removed}} The `--fix` flag for `dart format` is no longer supported.
  To apply similar fixes and more,
  [configure your analysis options][] and run [`dart fix`][].

  {{removed}} 不再支持 `dart format` 的 `--fix` 参数。
  要应用类似的修复及更多修复，
  请[配置分析选项][configure your analysis options]并运行 [`dart fix`][]。
- {{deprecated}} The `--line-length` option for `dart format` has been
  deprecated and set to be removed.
  All usages should be migrated to the new `--page-width` option.

  {{deprecated}} `dart format` 的 `--line-length` 选项
  已弃用并计划移除。
  所有用法应迁移到新的 `--page-width` 选项。

[new style]: {{site.repo.dart.org}}/dart_style/issues/1253
[language version]: /language/versioning
[configure your analysis options]: /tools/analysis
[`dart fix`]: /tools/dart-fix

## 3.6.0

### Language

### 语言

- [The context used by Dart to perform type inference on
  the operand of a throw expression has been changed from
  the "unknown type" to `Object`][56065].
  This makes the type system more self-consistent, because
  it reflects the fact that it's not legal to throw `null`.
  This change isn't expected to make any difference in practice.

  [Dart 对 throw 表达式操作数做类型推断时使用的上下文
  已从「未知类型」改为 `Object`][56065]。
  这让类型系统更加自洽，
  因为它反映了 throw `null` 不合法这一事实。
  预计这个变更在实践中不会有任何影响。

[56065]: {{site.repo.dart.sdk}}/issues/56065

### Libraries

### 库

#### `dart:io`

- {{removed}} [The `Platform()` constructor has been removed][52444].
  All instantiations of `Platform` should be removed.

  {{removed}} [`Platform()` 构造函数已被移除][52444]。
  应移除所有对 `Platform` 的实例化。
- `HttpClient` now responds to a redirect that's missing a "Location" header by
  [throwing a `RedirectException` instead of a `StateError`][53618].

  对于缺少 "Location" 头的重定向，`HttpClient` 现在
  [抛出 `RedirectException` 而非 `StateError`][53618]。

[52444]: {{site.repo.dart.sdk}}/issues/52444
[53618]: {{site.repo.dart.sdk}}/issues/53618

### Tools

### 工具

#### Analyzer

#### 分析器

- {{deprecated}} The [`package_api_docs`][] and [`unsafe_html`][] lint rules
  have been deprecated and are set to be removed in Dart 3.7.

  {{deprecated}} [`package_api_docs`][] 和 [`unsafe_html`][] lint 规则
  已弃用，计划在 Dart 3.7 中移除。

[`package_api_docs`]: /tools/linter-rules/package_api_docs
[`unsafe_html`]: /tools/linter-rules/unsafe_html

#### Compiler front end (cfe)

#### 编译器前端（cfe）

- The Dart compiler now [computes the upper and lower closures of type schemas
  just before they're passed into the subtype testing procedure][56466].
  Before Dart 3.6, the compiler computed them at the very beginning of
  the upper and lower-bound computations.
  The analyzer already followed this behavior, so apps that
  already pass analysis are unlikely to be affected by this change.

  Dart 编译器现在[在类型模式传入子类型测试过程之前
  才计算它们的上闭包和下闭包][56466]。
  在 Dart 3.6 之前，编译器在上界和下界计算的最开始
  就计算它们。
  分析器早已遵循这一行为，
  所以已经通过分析的应用不太可能受此变更影响。

[56466]: {{site.repo.dart.sdk}}/issues/56466

#### Wasm compiler (dart2wasm)

#### Wasm 编译器（dart2wasm）

- The condition `dart.library.js` is now `false` on conditional imports
  when compiling to WebAssembly.
  The `dart.library.js_interop` condition should be used instead.

  编译到 WebAssembly 时，
  条件导入中的 `dart.library.js` 条件现在为 `false`。
  应改用 `dart.library.js_interop` 条件。

#### Formatter (`dart format`)

#### 格式化器（`dart format`）

The following changes might result in small formatting changes
when running `dart format` with a Dart 3.6 SDK or later:

使用 Dart 3.6 或更高版本的 SDK 运行 `dart format` 时，
以下变更可能导致小的格式变化：

- Preserve type parameters on old-style function-typed formals that
  also use `this.` or `super.`.

  对同时使用 `this.` 或 `super.` 的旧式函数类型形参，
  保留其类型参数。
- Correctly format imports with both `as` and `if` clauses.

  正确格式化同时带 `as` 和 `if` 子句的导入。

#### Pub

#### Pub

- `dart pub publish` now warns if files that are
  tracked in git have uncommitted changes.

  如果 git 跟踪的文件有未提交的变更，
  `dart pub publish` 现在会发出警告。

## 3.5.0

### Language

### 语言

- [The context used by the compiler to perform type inference on
  the operand of an `await` expression has been changed to
  match the behavior of the analyzer.][55418]

  [编译器对 `await` 表达式操作数做类型推断时使用的上下文
  已更改，与分析器的行为保持一致。][55418]
- [The context used by the compiler to perform type inference on
  the right-hand side of an "if-null" expression (`e1 ?? e2`) has been
  changed to match the behavior of the analyzer.][55436]
  The old behavior can be restored by supplying explicit types.

  [编译器对 "if-null" 表达式（`e1 ?? e2`）右侧做类型推断时
  使用的上下文已更改，与分析器的行为保持一致。][55436]
  提供显式类型可以恢复旧行为。

[55418]: {{site.repo.dart.sdk}}/issues/55418
[55436]: {{site.repo.dart.sdk}}/issues/55436

### Libraries

### 库

#### `dart:core`

- [`DateTime` now stores microseconds on the web platform][44876],
  more closely matching the behavior on native platforms.

  [`DateTime` 现在在 Web 平台上存储微秒][44876]，
  更接近原生平台上的行为。

[44876]: {{site.repo.dart.sdk}}/issues/44876

#### `dart:io`

- [`SecurityContext` is now final and can no longer be subclassed][55786].

  [`SecurityContext` 现在是 final 的，不能再被子类化][55786]。

[55786]: {{site.repo.dart.sdk}}/issues/55786

#### `dart:js_interop`

- [`importModule` now accepts a `JSAny` instead of a `String`][55508] to
  support other JS values as well, such as `TrustedScriptURL` objects.

  [`importModule` 现在接受 `JSAny` 而非 `String`][55508]，
  以支持其他 JS 值，例如 `TrustedScriptURL` 对象。
- [`isTruthy` and `not` now return `JSBoolean` instead of `bool`][55267] to
  be consistent with other JS operator methods.

  [`isTruthy` 和 `not` 现在返回 `JSBoolean` 而非 `bool`][55267]，
  与其他 JS 运算符方法保持一致。
- [`ExternalDartReference` no longer implements `Object`][56015].
  Instead, it now accepts a type parameter (`T`) with a bound of
  `Object?` to capture the type of the Dart object that is externalized.

  [`ExternalDartReference` 不再实现 `Object`][56015]。
  它现在接受一个上界为 `Object?` 的类型参数（`T`），
  以捕获被外部化的 Dart 对象的类型。

[55508]: {{site.repo.dart.sdk}}/issues/55508
[55267]: {{site.repo.dart.sdk}}/issues/55267
[56015]: {{site.repo.dart.sdk}}/issues/56015

#### `dart:typed_data`

- {{removed}}
  [The unmodifiable view classes for typed data have been removed][53128].
  Instead of using the constructors of these classes, use
  the new `asUnmodifiableView` methods on typed data lists.

  {{removed}}
  [typed data 的不可修改视图类已被移除][53128]。
  请改用 typed data 列表上新的 `asUnmodifiableView` 方法，
  而不是这些类的构造函数。

### Runtime

### 运行时

- {{removed}} The Dart VM no longer supports unsound null safety.

  {{removed}} Dart VM 不再支持不健全的空安全。
  - The `--no-sound-null-safety` CLI option has been removed.

    `--no-sound-null-safety` CLI 选项已被移除。
  - The `Dart_NewListOf` and `Dart_IsLegacyType` functions have been
    removed from the C API.

    `Dart_NewListOf` 和 `Dart_IsLegacyType` 函数
    已从 C API 中移除。
- {{removed}} The `Dart_DefaultCanonicalizeUrl` function has been
  removed from the C API.

  {{removed}} `Dart_DefaultCanonicalizeUrl` 函数
  已从 C API 中移除。

## 3.4.0

### Language

### 语言

- [The pattern context type schema for cast patterns
  is now `_` (the unknown type) instead of `Object?`][54640].

  [cast 模式的模式上下文类型模式
  现在是 `_`（未知类型）而非 `Object?`][54640]。
- [The type schema used by the Dart compilers to
  perform type inference on the operand of a null-aware spread operator (`...?`)
  in map and set literals has been made nullable][54828],
  to match what currently happens in list literals.

  [Dart 编译器对 map 和 set 字面量中
  空感知展开运算符（`...?`）操作数做类型推断时
  使用的类型模式已改为可空][54828]，
  与 list 字面量中目前的行为保持一致。

[54640]: {{site.repo.dart.sdk}}/issues/54640
[54828]: {{site.repo.dart.sdk}}/issues/54828

### Libraries

### 库

#### `dart:cli`

- {{experimental}} {{removed}} [The `waitFor` function][52121]
  has been removed.

  {{experimental}} {{removed}} [`waitFor` 函数][52121]
  已被移除。

[52121]: {{site.repo.dart.sdk}}/issues/52121

#### `dart:html`, `dart:indexed:db`, `dart:svg`, `dart:web_audio`, `dart:web_gl`

- {{deprecated}} These libraries are now marked as legacy and
  will see less support in the future.
  New projects should prefer to use [`package:web`][] and `dart:js_interop`.
  To learn more, check out [Migrate to `package:web`][].

  {{deprecated}} 这些库现在被标记为遗留，
  未来获得的支持会更少。
  新项目应优先使用 [`package:web`][] 和 `dart:js_interop`。
  了解更多请参阅 [迁移到 `package:web`][Migrate to `package:web`]。

[`package:web`]: {{site.pub-pkg}}/web
[Migrate to `package:web`]: /interop/js-interop/package-web

#### `dart:js`

- {{deprecated}}
  This library is now marked as legacy and will see less support in the future.
  Usages should be migrated to `dart:js_interop` and `dart:js_interop_unsafe`.
  To learn more, check out [`/go/next-gen-js-interop`][].

  {{deprecated}}
  这个库现在被标记为遗留，未来获得的支持会更少。
  用法应迁移到 `dart:js_interop` 和 `dart:js_interop_unsafe`。
  了解更多请参阅 [`/go/next-gen-js-interop`][]。

[`/go/next-gen-js-interop`]: {{site.redirect.go}}/next-gen-js-interop

#### `dart:js_util`

- {{deprecated}}
  This library is now marked as legacy and will see less support in the future.
  Usages should be migrated to `dart:js_interop` and `dart:js_interop_unsafe`.
  To learn more, check out [`/go/next-gen-js-interop`][].

  {{deprecated}}
  这个库现在被标记为遗留，未来获得的支持会更少。
  用法应迁移到 `dart:js_interop` 和 `dart:js_interop_unsafe`。
  了解更多请参阅 [`/go/next-gen-js-interop`][]。

[`/go/next-gen-js-interop`]: {{site.redirect.go}}/next-gen-js-interop

#### `dart:io`

- [`Stdout` has a new field `lineTerminator`, which allows
  developers to control the line ending used by `stdout` and `stderr`.][53863]
  Classes that implement `Stdout` must define the `lineTerminator` field.
  The default semantics of `stdout` and `stderr` are not changed.

  [`Stdout` 新增了 `lineTerminator` 字段，
  允许开发者控制 `stdout` 和 `stderr` 使用的行结束符。][53863]
  实现 `Stdout` 的类必须定义 `lineTerminator` 字段。
  `stdout` 和 `stderr` 的默认语义不变。
- {{deprecated}} The `FileSystemDeleteEvent.isDirectory` property. 
  It always returns `false`.

  {{deprecated}} `FileSystemDeleteEvent.isDirectory` 属性。
  它总是返回 `false`。

[53863]: {{site.repo.dart.sdk}}/issues/53863

#### `dart:typed_data`

- {{deprecated}}
  [The unmodifiable view classes for typed data are deprecated][53128].
  Instead of using the constructors of these classes, use
  the new `asUnmodifiableView` methods on typed data lists.

  {{deprecated}}
  [typed data 的不可修改视图类已弃用][53128]。
  请改用 typed data 列表上新的 `asUnmodifiableView` 方法，
  而不是这些类的构造函数。

[53128]: {{site.repo.dart.sdk}}/issues/53218

### Tools

### 工具

#### Production JavaScript compiler (dart2js)

#### 生产 JavaScript 编译器（dart2js）

- {{experimental}} {{deprecated}} You should now specify a format to
  the `--dump-info` CLI option of either `binary` or `json`.
  The `json` format is deprecated and might be removed in a future Dart release.

  {{experimental}} {{deprecated}} 现在应为 `--dump-info` CLI 选项
  指定 `binary` 或 `json` 格式。
  `json` 格式已弃用，可能在未来 Dart 版本中移除。

#### Wasm compiler (dart2wasm)

#### Wasm 编译器（dart2wasm）

- {{experimental}} Various `dart compile wasm` CLI arguments have
  been updated, removed, or replaced.
  To learn more, run `dart compile wasm --verbose --help`.

  {{experimental}} 多个 `dart compile wasm` CLI 参数
  已更新、移除或替换。
  了解更多请运行 `dart compile wasm --verbose --help`。

### Runtime

### 运行时

- {{removed}} The Dart VM longer supports external strings.
  As a result, the `Dart_IsExternalString`, `Dart_NewExternalLatin1String`, and
  `Dart_NewExternalUTF16String` functions have been removed from the Dart C API.

  {{removed}} Dart VM 不再支持外部字符串。
  因此，`Dart_IsExternalString`、`Dart_NewExternalLatin1String` 和
  `Dart_NewExternalUTF16String` 函数已从 Dart C API 中移除。

## 3.3.0

### SDK

### SDK

* {{experimental}} {{removed}} The following experiments are now retired as
  they were released in Dart 3 and are no longer necessary with
  a language version of 3.0 or greater.
  Configuration of them should be removed from
  analysis options, CLI commands, and IDE configurations.

  {{experimental}} {{removed}} 以下实验已退役，
  因为它们已随 Dart 3 发布，
  语言版本为 3.0 或更高时不再需要。
  应从分析选项、CLI 命令和 IDE 配置中
  移除它们的配置。

  * `patterns`
  * `records`
  * `class-modifiers`
  * `sealed-class`

### Language

### 语言

* [An abstract getter is now considered promotable if
  there are no conflicting declarations][54056].

  [如果没有冲突的声明，
  抽象 getter 现在被视为可提升][54056]。

[54056]: {{site.repo.dart.sdk}}/issues/54056

### Libraries

### 库

#### `dart:cli`

* {{experimental}} {{deprecated}} [The `waitFor` function][52121]
  remains deprecated for another release and is set for removal in Dart 3.4.

  {{experimental}} {{deprecated}} [`waitFor` 函数][52121]
  再保留一个版本的弃用状态，计划在 Dart 3.4 中移除。

[52121]: {{site.repo.dart.sdk}}/issues/52121

#### `dart:ffi`

* {{deprecated}} [The `elementAt` pointer arithmetic methods
  on `Pointer` types are deprecated][54250].
  Migrate to the `-` and `+` operators instead.

  {{deprecated}} [`Pointer` 类型上的 `elementAt` 指针算术方法
  已弃用][54250]。
  请迁移到 `-` 和 `+` 运算符。
* {{experimental}} {{removed}} The previously deprecated
  `@FfiNative` annotation has been removed. Usages should be
  updated to use the `@Native` annotation.

  {{experimental}} {{removed}} 之前已弃用的
  `@FfiNative` 注解已被移除。
  用法应更新为使用 `@Native` 注解。

[54250]: {{site.repo.dart.sdk}}/issues/54250

#### `dart:html`

* Instead of using `HttpRequest` directly,
  it is now recommended to use [`package:http`][].

  现在建议改用 [`package:http`][]，
  而不是直接使用 `HttpRequest`。

[`package:http`]: {{site.pub-pkg}}/http

#### `dart:io`

* Instead of using `HttpClient` directly,
  it is now recommended to use [`package:http`][].

  现在建议改用 [`package:http`][]，
  而不是直接使用 `HttpClient`。

[`package:http`]: {{site.pub-pkg}}/http

#### `dart:js_interop`

* {{experimental}} JS types like `JSAny` have
  [new compiler-specific representation types][52687].

  {{experimental}} `JSAny` 等 JS 类型
  [有了新的编译器特定表示类型][52687]。
* {{experimental}} User-defined `@staticInterop` classes can
  [no longer implement `JSAny` or `JSObject`][52687].
  Usages should be migrated to `JSObject.fromInteropObject` or
  be defined as extension types.

  {{experimental}} 用户定义的 `@staticInterop` 类
  [不能再实现 `JSAny` 或 `JSObject`][52687]。
  用法应迁移到 `JSObject.fromInteropObject`，
  或定义为扩展类型。
* {{experimental}} `JSArray` and `JSPromise` now have generic parameters.

  {{experimental}} `JSArray` 和 `JSPromise` 现在有了泛型参数。
* {{experimental}} Various extension members were moved or renamed.
  To learn about the updated extensions, reference
  `JSAnyUtilityExtension` and `JSAnyOperatorExtension`.

  {{experimental}} 多个 extension 成员被移动或重命名。
  要了解更新后的 extension，
  请参阅 `JSAnyUtilityExtension` 和 `JSAnyOperatorExtension`。

[52687]: {{site.repo.dart.sdk}}/issues/52687

#### `dart:typed_data`

* [The unmodifiable view classes for typed data will
  be deprecated in Dart 3.4][53128].
  Instead of using the constructors of these classes, use
  the new `asUnmodifiableView` methods on typed data lists.

  [typed data 的不可修改视图类
  将在 Dart 3.4 中弃用][53128]。
  请改用 typed data 列表上新的 `asUnmodifiableView` 方法，
  而不是这些类的构造函数。

[53128]: {{site.repo.dart.sdk}}/issues/53218

#### `dart:nativewrappers`

* {{experimental}} [All native wrapper classes are now marked `base`][51896]
  so that none of their subtypes can be implemented.

  {{experimental}} [所有原生包装类现在都标记为 `base`][51896]，
  因此它们的任何子类型都不能被实现。

[51896]: {{site.repo.dart.sdk}}/issues/51896

### Tools

### 工具

#### Production JavaScript compiler (dart2js)

#### 生产 JavaScript 编译器（dart2js）

* [The `Invocation` that is passed to `noSuchMethod` no longer
  has a minified `memberName`][54201], even when compiled with `--minify`.

  [传给 `noSuchMethod` 的 `Invocation`
  不再带有被压缩的 `memberName`][54201]，即使使用 `--minify` 编译。

[54201]: {{site.repo.dart.sdk}}/issues/54201

#### Wasm compiler (dart2wasm)

#### Wasm 编译器（dart2wasm）

* {{experimental}} [Disallow importing legacy JS interop libraries][54004].
  Prefer using `dart:js_interop` and `dart:js_interop_unsafe` instead.

  {{experimental}} [禁止导入遗留 JS 互操作库][54004]。
  请优先使用 `dart:js_interop` 和 `dart:js_interop_unsafe`。

[54004]: {{site.repo.dart.sdk}}/issues/54004

#### Analyzer

#### 分析器

* {{experimental}} Invalid `dart doc` comment directives are
  now reported by the analyzer.

  {{experimental}} 无效的 `dart doc` 注释指令
  现在会被分析器报告。
* Due to [improvements in type promotion][54056], the following analyzer
  diagnostics might trigger on existing code that previously passed analysis:

  由于[类型提升的改进][54056]，以下分析器诊断
  可能在以前通过分析的现有代码上触发：

  * `unnecessary_non_null_assertion`
  * `unnecessary_cast`
  * `invalid_null_aware_operator`

[54056]: {{site.repo.dart.sdk}}/issues/54056

#### Linter

#### Linter

* The `iterable_contains_unrelated_type` and
  `list_remove_unrelated_type` lints were removed.
  Consider migrating to the expanded
  [`collection_methods_unrelated_type`][] lint.

  `iterable_contains_unrelated_type` 和
  `list_remove_unrelated_type` lint 已被移除。
  考虑迁移到扩展后的
  [`collection_methods_unrelated_type`][] lint。
* The following lints are removed due to no longer being
  necessary with sound null safety. You should remove configuration of them
  from your `analysis_options.yaml` files and any ignore comments.

  以下 lint 因健全空安全下不再需要而被移除。
  应从 `analysis_options.yaml` 文件和任何 ignore 注释中
  移除它们的配置。
  
  * `always_require_non_null_named_parameters`
  * `avoid_returning_null`
  * `avoid_returning_null_for_future`

[`collection_methods_unrelated_type`]: /tools/linter-rules/collection_methods_unrelated_type

## 3.2.0

### Language

### 语言

* {{versioned}} [Changed the split point for refutable patterns][53167]
  to the top level pattern so type promotion in if-case statements is consistent
  regardless of whether the scrutinee might throw an exception.

  {{versioned}} [可反驳模式的拆分点已改为顶层模式][53167]，
  使 if-case 语句中的类型提升保持一致，
  无论被检查对象是否可能抛出异常。

### Libraries

### 库

#### `dart:cli`

* {{experimental}} {{deprecated}} [The `waitFor` function.][52121]

  {{experimental}} {{deprecated}} [`waitFor` 函数。][52121]

#### `dart:convert`

* [Changed return types of `utf8.encode()` and `Utf8Codec.encode()`][52801]
 from `List<int>` to `Uint8List`.

  [`utf8.encode()` 和 `Utf8Codec.encode()` 的返回类型][52801]
  从 `List<int>` 改为 `Uint8List`。

#### `dart:developer`

* {{deprecated}} The `Service.getIsolateID` method.

  {{deprecated}} `Service.getIsolateID` 方法。

#### `dart:ffi`

* [Changed `NativeCallable.nativeFunction` so calls now throw an error if
  the receiver is already closed][53311], instead of returning `nullptr`.

  [修改了 `NativeCallable.nativeFunction`，
  接收者已关闭时调用现在会抛出错误][53311]，而不是返回 `nullptr`。

#### `dart:io`

* [Eliminated trailing whitespace from HTTP headers][53005].

  [去除了 HTTP 头中的尾随空白][53005]。
* [Inserted a space at the fold point of folded header values][53227]
  that `HttpClientResponse.headers` and `HttpRequest.headers` return.

  [在 `HttpClientResponse.headers` 和 `HttpRequest.headers` 返回的
  折叠头值的折叠点插入空格][53227]。

#### `dart:js_interop`

* {{experimental}} {{removed}} `JSNumber.toDart` in favor of `toDartDouble` and
  `toDartInt`.

  {{experimental}} {{removed}} 移除 `JSNumber.toDart`，
  改用 `toDartDouble` 和 `toDartInt`。
* {{experimental}} {{removed}} `Object.toJS` in favor of `Object.toJSBox.`

  {{experimental}} {{removed}} 移除 `Object.toJS`，改用 `Object.toJSBox`。
* {{experimental}} Restricted external JS interop APIs using `dart:js_interop`
  to a set of allowed types.

  {{experimental}} 使用 `dart:js_interop` 的外部 JS 互操作 API
  被限制为一组允许的类型。
* {{experimental}} Prohibited use of `isNull` and `isUndefined` on dart2wasm.

  {{experimental}} 禁止在 dart2wasm 上使用 `isNull` 和 `isUndefined`。
* {{experimental}} Changed `typeofEquals` and `instanceof` APIs to both return
  bool instead of `JSBoolean`.
  Also, `typeofEquals` now takes `String` instead of `JSString`.

  {{experimental}} `typeofEquals` 和 `instanceof` API 都改为返回
  bool 而非 `JSBoolean`。
  此外，`typeofEquals` 现在接受 `String` 而非 `JSString`。
* {{experimental}} Changed `JSAny` and `JSObject` types to only implementable,
  not extendable, by user `@staticInterop` types.

  {{experimental}} `JSAny` 和 `JSObject` 类型改为只能被用户的
  `@staticInterop` 类型实现，不能被继承。
* {{experimental}} Changed `JSArray.withLength` to take `int` instead of `JSNumber`.

  {{experimental}} `JSArray.withLength` 改为接受 `int` 而非 `JSNumber`。

### Tools

### 工具

#### Development JavaScript compiler (DDC)

#### 开发 JavaScript 编译器（DDC）

* [Added interceptors for JavaScript `Symbol` and `BigInt` types][53106];
  they should no longer be used with `package:js` classes.

  [为 JavaScript 的 `Symbol` 和 `BigInt` 类型添加了拦截器][53106]；
  它们不应再与 `package:js` 类一起使用。

#### Production JavaScript compiler (dart2js)

#### 生产 JavaScript 编译器（dart2js）

* [Added interceptors for JavaScript `Symbol` and `BigInt` types][53106];
  they should no longer be used with `package:js` classes.

  [为 JavaScript 的 `Symbol` 和 `BigInt` 类型添加了拦截器][53106]；
  它们不应再与 `package:js` 类一起使用。

#### Analyzer

#### 分析器

* {{versioned}} [Private final field promotion][2020] might cause the following
  analyzer warnings to trigger on existing code that previously passed analysis:

  {{versioned}} [私有 final 字段提升][2020]可能导致以下分析器警告
  在以前通过分析的现有代码上触发：
  
  * [`unnecessary_non_null_assertion`](/tools/diagnostic-messages#unnecessary_non_null_assertion)
  * [`invalid_null_aware_operator`](/tools/diagnostic-messages#invalid_null_aware_operator)
  * [`unnecessary_cast`](/tools/diagnostic-messages#unnecessary_cast)

  ```dart
  class C {
    final num? _x = null;

    void test() {
      if (_x != null) {
        print(_x! * 2); // unnecessary_non_null_assertion
        print(_x?.abs()); // invalid_null_aware_operator
      }
      if (_x is int) {
        print((_x as int).bitLength); // unnecessary_cast
      }
    }
  }
  ```

[53167]: {{site.repo.dart.sdk}}/issues/53167
[52121]: {{site.repo.dart.sdk}}/issues/52121
[52801]: {{site.repo.dart.sdk}}/issues/52801
[53311]: {{site.repo.dart.sdk}}/issues/53311
[53005]: {{site.repo.dart.sdk}}/issues/53005
[53227]: {{site.repo.dart.sdk}}/issues/53227
[53106]: {{site.repo.dart.sdk}}/issues/53106
[2020]: {{site.repo.dart.lang}}/issues/2020


## 3.1.0

### Libraries

### 库

#### `dart:async`

* [Added `interface` modifier to purely abstract classes:][52334]
 `MultiStreamController`, `StreamConsumer`, `StreamIterator` and `StreamTransformer`.

  [为纯抽象类添加了 `interface` 修饰符：][52334]
  `MultiStreamController`、`StreamConsumer`、`StreamIterator` 和 `StreamTransformer`。

#### `dart:io`

* [Added `sameSite` to the `Cookie` class, and added the class `SameSite`][51486].

  [为 `Cookie` 类添加了 `sameSite`，并新增了 `SameSite` 类][51486]。
* [`FileSystemEvent` is `sealed`][52027]. This means `FileSystemEvent` cannot be 
  extended or implemented.

  [`FileSystemEvent` 是 `sealed` 的][52027]。
  这意味着 `FileSystemEvent` 不能被继承或实现。

#### `dart:js_interop`

* {{experimental}} {{removed}} `ObjectLiteral`; create an object literal with
  no named members using `{}.jsify()`.

  {{experimental}} {{removed}} 移除 `ObjectLiteral`；
  用 `{}.jsify()` 创建没有命名成员的对象字面量。

#### `package:js`

* `external` `@staticInterop` members and `external` extension members can no
  longer be used as tear-offs. Declare a closure or a non-`external` method that
  calls these members, and use that instead.

  `external` `@staticInterop` 成员和 `external` extension 成员
  不能再用作 tear-off。
  请声明一个调用这些成员的闭包或非 `external` 方法，
  改用它。
* `external` `@staticInterop` members and `external` extension members will
  generate slightly different JS code for methods that have optional parameters.

  对于带可选参数的方法，`external` `@staticInterop` 成员
  和 `external` extension 成员会生成略有不同的 JS 代码。

[52334]: {{site.repo.dart.sdk}}/issues/52334
[51486]: {{site.repo.dart.sdk}}/issues/51486
[52027]: {{site.repo.dart.sdk}}/issues/52027

## 3.0.0

:::tip
The [Dart 3.0 migration guide][dart3] covers the complete details
on all the changes in this section.

[Dart 3.0 迁移指南][dart3] 涵盖了本节所有变更的完整细节。
:::

### Language

### 语言

* {{versioned}} Changed interpretation of [switch cases] from constant
  expressions to patterns.

  {{versioned}} [switch case] 的解释从常量表达式改为模式。

* {{versioned}} Class declarations from libraries that have been upgraded
  to Dart 3.0 [can no longer be used as mixins by default][mixin class].

  {{versioned}} 已升级到 Dart 3.0 的库中的类声明
  [默认不能再用作 mixin][mixin class]。

* [Dart reports a compile-time error][50902] if a `continue` statement targets
  a [label] that is not a loop (`for`, `do` and `while` statements) or a `switch`
  member.

  如果 `continue` 语句的目标[标签][label]不是循环
  （`for`、`do` 和 `while` 语句）或 `switch` 成员，
  [Dart 会报告编译时错误][50902]。

### Libraries

### 库

* The following existing classes have been made mixin classes:
  `Iterable`, `IterableMixin`, `IterableBase`, `ListMixin`, `SetMixin`, `MapMixin`,
  `LinkedListEntry`, `StringConversionSink`.

  以下现有类已改为 mixin 类：
  `Iterable`、`IterableMixin`、`IterableBase`、`ListMixin`、`SetMixin`、`MapMixin`、
  `LinkedListEntry`、`StringConversionSink`。

#### `dart:core`

* {{deprecated}} [Deprecated APIs][49529].

  {{deprecated}} [弃用的 API][49529]。

#### `dart:async`

* {{removed}} [Removed the deprecated][49529] [`DeferredLibrary`][] class.

  {{removed}} [移除了已弃用的][49529] [`DeferredLibrary`][] 类。

#### `dart:collection`

* {{versioned}} [Changes to platform libraries][collection].

  {{versioned}} [平台库的变更][collection]。

#### `dart:developer`

* {{removed}} [Removed the deprecated][49529] [`MAX_USER_TAGS`][] constant.
  Use [`maxUserTags`][] instead.

  {{removed}} [移除了已弃用的][49529] [`MAX_USER_TAGS`][] 常量。
  请改用 [`maxUserTags`][]。
* {{removed}} [Removed the deprecated][50231] [`Metrics`][], [`Metric`][], [`Counter`][],
  and [`Gauge`][] classes as they have been broken since Dart 2.0.

  {{removed}} [移除了已弃用的][50231] [`Metrics`][]、[`Metric`][]、[`Counter`][]
  和 [`Gauge`][] 类，它们自 Dart 2.0 起就已损坏。

#### `dart:ffi`

* {{experimental}} {{deprecated}} The `@FfiNative` annotation is
  now deprecated. Usages should be updated to use the `@Native` annotation.

  {{experimental}} {{deprecated}} `@FfiNative` 注解
  现已弃用。用法应更新为使用 `@Native` 注解。

#### `dart:html`

* {{removed}} [Removed the deprecated `registerElement` and `registerElement2`][49536]
  methods in `Document` and `HtmlDocument`.

  {{removed}} [移除了 `Document` 和 `HtmlDocument` 中已弃用的
  `registerElement` 和 `registerElement2`][49536] 方法。

#### `dart:math`

* {{versioned}} The `Random` interface can only be implemented,
  not extended.

  {{versioned}} `Random` 接口只能被实现，
  不能被继承。

#### `dart:io`

* [Updated `NetworkProfiling`][51035] to accommodate new `String` ids that are
  introduced in vm_service:11.0.0

  [更新了 `NetworkProfiling`][51035]，
  以适配 vm_service:11.0.0 引入的新 `String` id。

[dart3]: /resources/dart-3-migration/
[switch cases]: /language/branches#switch
[mixin class]: /language/mixins#class-mixin-or-mixin-class
[label]: /language/branches#switch
[50902]: {{site.repo.dart.sdk}}/issues/50902
[collection]: /resources/dart-3-migration#dart-collection
[49529]: {{site.repo.dart.sdk}}/issues/49529
[`DeferredLibrary`]: {{site.dart-api}}/stable/2.18.4/dart-async/DeferredLibrary-class.html
[`deferred as`]: /language/libraries#lazily-loading-a-library
[`MAX_USER_TAGS`]: {{site.dart-api}}/stable/dart-developer/UserTag/MAX_USER_TAGS-constant.html
[`maxUserTags`]: {{site.dart-api}}/dart-developer/UserTag/maxUserTags-constant.html
[50231]: {{site.repo.dart.sdk}}/issues/50231
[`Metrics`]: {{site.dart-api}}/stable/2.18.2/dart-developer/Metrics-class.html
[`Metric`]: {{site.dart-api}}/stable/2.18.2/dart-developer/Metric-class.html
[`Counter`]: {{site.dart-api}}/stable/2.18.2/dart-developer/Counter-class.html
[`Gauge`]: {{site.dart-api}}/stable/2.18.2/dart-developer/Gauge-class.html
[49536]: {{site.repo.dart.sdk}}/issues/49536
[51035]: {{site.repo.dart.sdk}}/issues/51035


## 2.19.0

### Language

### 语言

* [Flagged additional code as unreachable][49635] due to types `Null` and `Never`.

  由于 `Null` 和 `Never` 类型，[更多代码被标记为不可达][49635]。
* [Don't delegate inaccessible private names to `noSuchMethod`][49687].

  [不再把不可访问的私有名称委托给 `noSuchMethod`][49687]。
* [Report a compile-time error][50383] for all cyclic dependencies during
  top-level type inference.

  顶层类型推断期间的所有循环依赖
  现在都会[报告编译时错误][50383]。

### Libraries

### 库

#### `dart:convert`

* {{removed}} [The previously deprecated API][34233] [`DEFAULT_BUFFER_SIZE`] in `JsonUtf8Encoder`
  has been removed.

  {{removed}} `JsonUtf8Encoder` 中[之前已弃用的 API][34233]
  [`DEFAULT_BUFFER_SIZE`] 已被移除。

#### `dart:developer`

* {{removed}} [Removed previously deprecated APIs][34233] `kInvalidParams`,
  `kExtensionError`, `kExtensionErrorMax`, and `kExtensionErrorMin` in
  [`ServiceExtensionResponse`].

  {{removed}} [移除了之前已弃用的 API][34233]：
  [`ServiceExtensionResponse`] 中的 `kInvalidParams`、
  `kExtensionError`、`kExtensionErrorMax` 和 `kExtensionErrorMin`。

#### `dart:ffi`

* [Changed the runtime type argument of `Pointer` to `Never`][49935] in
  preparation of completely removing the runtime type argument. 
  Changed `Pointer.toString` to not report any type argument.

  [`Pointer` 的运行时类型实参改为 `Never`][49935]，
  为完全移除运行时类型实参做准备。
  `Pointer.toString` 改为不再报告任何类型实参。

#### `dart:io`

* [Disallow negative or hexadecimal content-length headers][49305].

  [禁止负数或十六进制的 content-length 头][49305]。
* [`File.create` now takes new optional `exclusive` `bool` parameter][49647],
  and when it is `true` the operation will fail if target file already exists.

  [`File.create` 新增可选的 `exclusive` `bool` 参数][49647]，
  为 `true` 时，如果目标文件已存在，操作将失败。
* Calling `ResourceHandle.toFile()`, `ResourceHandle.toSocket()`,
  `ResourceHandle.toRawSocket()` or `ResourceHandle.toRawDatagramSocket()`,
  more than once [now throws a `StateError`][49878].

  多次调用 `ResourceHandle.toFile()`、`ResourceHandle.toSocket()`、
  `ResourceHandle.toRawSocket()` 或 `ResourceHandle.toRawDatagramSocket()`
  [现在会抛出 `StateError`][49878]。

#### `dart:isolate`

* Reverted [`SendPort.send`] back to strict checks on contents of messages when
  sending messages between isolates that are not known to share the same code.

  在未知是否共享相同代码的 isolate 之间发送消息时，
  [`SendPort.send`] 恢复为对消息内容的严格检查。

#### `dart:mirrors`

* {{removed}} [Removed APIs][34233] `MirrorsUsed` and `Comment`.

  {{removed}} [移除了 API][34233] `MirrorsUsed` 和 `Comment`。

#### `package:js`

* Breaking changes to the preview feature `@staticInterop`:

  预览特性 `@staticInterop` 的破坏性变更：
  * Disallowed classes with this annotation from using `external`
    generative constructors. See [48730] and [49941] for more details.

    禁止带此注解的类使用 `external` 生成构造函数。
    详情见 [48730] 和 [49941]。
  * [Disallowed classes with this annotation's external extension members from
    using type parameters][49350].

    [禁止带此注解的类的 external extension 成员
    使用类型参数][49350]。
  * Classes with this annotation should also have the `@JS` annotation.

    带此注解的类还应带有 `@JS` 注解。
  * Classes with this annotation can not be implemented by classes without this
    annotation.

    带此注解的类不能被不带此注解的类实现。

#### `dart2js`

* [`dart2js` no longer supports HTTP URIs as inputs][49473].

  [`dart2js` 不再支持 HTTP URI 作为输入][49473]。

[49635]: {{site.repo.dart.sdk}}/issues/49635
[49687]: {{site.repo.dart.sdk}}/issues/49687
[50383]: {{site.repo.dart.sdk}}/issues/50383
[34233]: {{site.repo.dart.sdk}}/issues/34233
[`ServiceExtensionResponse`]: {{site.dart-api}}/stable/2.17.6/dart-developer/ServiceExtensionResponse-class.html#constants
[49935]: {{site.repo.dart.sdk}}/issues/49935
[49305]: {{site.repo.dart.sdk}}/issues/49305
[49647]: {{site.repo.dart.sdk}}/issues/49647
[49878]: {{site.repo.dart.sdk}}/issues/49878
[`SendPort.send`]: {{site.dart-api}}/stable/dart-isolate/SendPort/send.html
[34233]: {{site.repo.dart.sdk}}/issues/34233
[49473]: {{site.repo.dart.sdk}}/issues/49473
[48730]: {{site.repo.dart.sdk}}/issues/48730
[49941]: {{site.repo.dart.sdk}}/issues/49941
[49350]: {{site.repo.dart.sdk}}/issues/49350


## 2.18.0

### Language

### 语言

* [Removed support for mixin of classes that don't extend `Object`][48167].

  [移除了对不继承 `Object` 的类用作 mixin 的支持][48167]。

### Libraries

### 库

#### `dart:io`

* [Changed the `uri` property of `RedirectException` in `dart:io` to be nullable][49045].

  [`dart:io` 中 `RedirectException` 的 `uri` 属性改为可空][49045]。
* [Removed constants in `dart:io` networking APIs following the `SCREAMING_CAPS`
  convention][34218].

  [移除了 `dart:io` 网络 API 中遵循 `SCREAMING_CAPS`
  约定的常量][34218]。
* [The Dart VM no longer automatically restores the initial terminal settings][45630]
  upon exit.

  [Dart VM 退出时不再自动恢复初始终端设置][45630]。

### Tools

### 工具

* [Fully discontinued the `.packages` file][48272]. 

  [完全停用 `.packages` 文件][48272]。

#### Dart command line

#### Dart 命令行

* [Removed the standalone `dart2js` and `dartdevc` tools][46100].

  [移除了独立的 `dart2js` 和 `dartdevc` 工具][46100]。
* [Removed the standalone `dartanalyzer` tool][46100].

  [移除了独立的 `dartanalyzer` 工具][46100]。

[48167]: {{site.repo.dart.sdk}}/issues/48167
[49045]: {{site.repo.dart.sdk}}/issues/49045
[34218]: {{site.repo.dart.sdk}}/issues/34218
[45630]: {{site.repo.dart.sdk}}/issues/45630
[48272]: {{site.repo.dart.sdk}}/issues/48272
[46100]: {{site.repo.dart.sdk}}/issues/46100

## 2.17.0

### Libraries

### 库

#### `dart:io`

* [Added new `connectionFactory` property to `HttpClient`][47887].

  [为 `HttpClient` 新增 `connectionFactory` 属性][47887]。
* [Added new `keyLog` property to `HttpClient`][48093], which allows TLS keys to
  be logged for debugging purposes.

  [为 `HttpClient` 新增 `keyLog` 属性][48093]，
  允许记录 TLS 密钥以便调试。
* [Removed constants in `dart:io` following the `SCREAMING_CAPS`][34218]

  [移除了 `dart:io` 中遵循 `SCREAMING_CAPS` 的常量][34218]。
* [Added a new `allowLegacyUnsafeRenegotiation` property to `SecurityContext`][48513],
  which allows TLS renegotiation for client secure sockets.

  [为 `SecurityContext` 新增 `allowLegacyUnsafeRenegotiation` 属性][48513]，
  允许客户端安全套接字进行 TLS 重新协商。

### Tools

### 工具

#### Dart command line

#### Dart 命令行

* {{deprecated}} [Deprecated the standalone `dart2js` tool][46100].

  {{deprecated}} [弃用了独立的 `dart2js` 工具][46100]。
* {{deprecated}} [Deprecated the standalone `dartdevc` tool][46100].

  {{deprecated}} [弃用了独立的 `dartdevc` 工具][46100]。
* {{removed}} [Removed the standalone `dartdoc` tool][46100].

  {{removed}} [移除了独立的 `dartdoc` 工具][46100]。

[47887]: {{site.repo.dart.sdk}}/issues/47887
[48093]: {{site.repo.dart.sdk}}/issues/48093
[34218]: {{site.repo.dart.sdk}}/issues/34218
[48513]: {{site.repo.dart.sdk}}/issues/48513
[46100]: {{site.repo.dart.sdk}}/issues/46100

## 2.16.0

### Libraries

### 库

#### `dart:io`

* On Windows, [`Directory.rename` will no longer delete a directory][47653] if
  `newPath` specifies one. Instead, a `FileSystemException` will be thrown.

  在 Windows 上，如果 `newPath` 指定了一个目录，
  [`Directory.rename` 不再删除该目录][47653]，
  而是抛出 `FileSystemException`。
* {{removed}} [Removed the `Platform.packageRoot` API][47769].

  {{removed}} [移除了 `Platform.packageRoot` API][47769]。

#### `dart:isolate`

* {{removed}} [Removed the `Isolate.packageRoot` API][47769].

  {{removed}} [移除了 `Isolate.packageRoot` API][47769]。

### Tools

### 工具

#### Dart command line

#### Dart 命令行

* {{deprecated}} [Deprecated the standalone `dartanalyzer` tool][46100].

  {{deprecated}} [弃用了独立的 `dartanalyzer` 工具][46100]。
* {{deprecated}} [Deprecated the standalone `dartdoc` tool][46100].

  {{deprecated}} [弃用了独立的 `dartdoc` 工具][46100]。
* {{removed}} [Removed the deprecated standalone `pub` tool][46100].

  {{removed}} [移除了已弃用的独立 `pub` 工具][46100]。

[47653]: {{site.repo.dart.sdk}}/issues/47653
[47769]: {{site.repo.dart.sdk}}/issues/47769
[46100]: {{site.repo.dart.sdk}}/issues/46100

## 2.15.0

### Libraries

### 库

#### `dart:io`

* [Updated the `SecurityContext` class][46875] to set the minimum
  TLS protocol version to TLS1_2_VERSION (1.2) instead of TLS1_VERSION.

  [更新了 `SecurityContext` 类][46875]，
  把最低 TLS 协议版本设为 TLS1_2_VERSION（1.2）而非 TLS1_VERSION。

#### `dart:web_sql`

* [Completely deleted the `dart:web_sql` library][46316].

  [完全删除了 `dart:web_sql` 库][46316]。

#### `dart:html`

* [Removed `window.openDatabase`][46316] (related to `dart:web_sql` deletion above).

  [移除了 `window.openDatabase`][46316]（与上面删除 `dart:web_sql` 相关）。

### Tools

### 工具

#### Dart command line

#### Dart 命令行

* [Removed the standalone `dart2native` tool][46100].

  [移除了独立的 `dart2native` 工具][46100]。
* Removed the standalone `dartfmt` tool.

  移除了独立的 `dartfmt` 工具。

#### Dart VM

#### Dart VM

* [Removed support for `dart-ext:`-style native extensions][45451]

  [移除了对 `dart-ext:` 风格原生扩展的支持][45451]。
* [Grouped isolates spawned via the `Isolate.spawn()` API][46754] to operate on the
  same managed heap, and therefore share various VM-internal data structures.

  [通过 `Isolate.spawn()` API 派生的 isolate 被分组][46754]，
  在同一个托管堆上运行，因此共享各种 VM 内部数据结构。

[46875]: {{site.repo.dart.sdk}}/issues/46875
[46316]: {{site.repo.dart.sdk}}/issues/46316
[45451]: {{site.repo.dart.sdk}}/issues/45451
[46754]: {{site.repo.dart.sdk}}/issues/46754

## 2.14.0

### Libraries

### 库

#### `dart:io`

* The setter callbacks `.authenticate` and `.authenticateProxy` in `HttpClient`
  must now accept a nullable `realm` argument (for pre-migrated null safe code).

  `HttpClient` 中的 setter 回调 `.authenticate` 和 `.authenticateProxy`
  现在必须接受可空的 `realm` 参数（针对迁移前的空安全代码）。

#### `dart:typed_data`

* Most types exposed by this library [can no longer be extended, implemented or
  mixed-in][45115].

  这个库暴露的大多数类型[不能再被继承、实现或
  用作 mixin][45115]。

### Tools

### 工具

#### Dart VM

#### Dart VM

* Expandos, and the `object` parameters of `Dart_NewWeakPersistentHandle` and 
  `Dart_NewFinalizableHandle`, [no longer accept `Pointer` and subtypes of `Struct`][45071] 

  Expando，以及 `Dart_NewWeakPersistentHandle` 和
  `Dart_NewFinalizableHandle` 的 `object` 参数，
  [不再接受 `Pointer` 和 `Struct` 的子类型][45071]。

#### Dart command line

#### Dart 命令行

* [Deprecated the standalone `dart2native` tool][46100]

  [弃用了独立的 `dart2native` 工具][46100]。
* Deprecated the standalone `dartfmt` tool.

  弃用了独立的 `dartfmt` 工具。

#### `dart2js`

* [`dart2js` no longer supports legacy browsers][46545], because it emits ES6+
  JavaScript by default.

  [`dart2js` 不再支持旧浏览器][46545]，
  因为它默认输出 ES6+ JavaScript。

#### Dart Dev Compiler (DDC)

#### Dart 开发编译器（DDC）

* [Changed subtyping relations of `package:js` classes][44154] to be more correct and
  consistent with Dart2JS.

  [更改了 `package:js` 类的子类型关系][44154]，
  使其更正确并与 Dart2JS 保持一致。

[45115]: {{site.repo.dart.sdk}}/issues/45115
[45071]: {{site.repo.dart.sdk}}/issues/45071
[46545]: {{site.repo.dart.sdk}}/issues/46545
[44154]: {{site.repo.dart.sdk}}/issues/44154


## 2.13.0

### Libraries

### 库

#### `package:js`

* [No longer valid][44211] to use a `String` that matches an `@Native` annotation
  in an `@JS()` annotation for a non-anonymous JS interop class.

  对于非匿名 JS 互操作类，在 `@JS()` 注解中使用
  与 `@Native` 注解匹配的 `String` [不再合法][44211]。

[44211]: {{site.repo.dart.sdk}}/issues/44211

## 2.12.0

### Language

### 语言

* [Null safety] is now enabled by default in all code that
  has not opted out.

  [空安全][Null safety]现在在所有未选择退出的代码中默认启用。
* [Fixed an implementation bug][44660] where `this` would sometimes undergo type
  promotion in extensions.

  [修复了一个实现 bug][44660]：
  `this` 有时会在 extension 中发生类型提升。

### Libraries

### 库

#### `dart:ffi`

* [Deprecated invocations with a generic `T`][44621] of `sizeOf<T>`,
  `Pointer<T>.elementAt()`, `Pointer<T extends Struct>.ref`, and
  `Pointer<T extends Struct>[]`

  [弃用了带泛型 `T` 的调用][44621]：`sizeOf<T>`、
  `Pointer<T>.elementAt()`、`Pointer<T extends Struct>.ref`
  和 `Pointer<T extends Struct>[]`。
* [Deprecated `allocate` in `package:ffi`][44621], as it will no longer be
  able to invoke `sizeOf<T>` generically.

  [弃用了 `package:ffi` 中的 `allocate`][44621]，
  因为它将无法再以泛型方式调用 `sizeOf<T>`。
* [Deprecated subtypes of `Struct` without any native member][44622].

  [弃用了没有任何原生成员的 `Struct` 子类型][44622]。

### Tools

### 工具

#### Dart VM

#### Dart VM

* [`Dart_WeakPersistentHandle` no longer auto-deletes itself][42312] when the
  referenced object is garbage collected to avoid race conditions.

  为避免竞态条件，被引用对象被垃圾回收时，
  [`Dart_WeakPersistentHandle` 不再自动删除自身][42312]。
* [Renamed `Dart_WeakPersistentHandleFinalizer` to `Dart_HandleFinalizer`][42312] 
  and removed its `handle` argument.

  [`Dart_WeakPersistentHandleFinalizer` 重命名为 `Dart_HandleFinalizer`][42312]，
  并移除了它的 `handle` 参数。

#### Pub 

#### Pub

* [The Dart SDK constraint is now **required** in `pubspec.yaml`][44072].

  [`pubspec.yaml` 中的 Dart SDK 约束现在是**必需的**][44072]。

[Null safety]: /null-safety/understanding-null-safety
[44660]: {{site.repo.dart.sdk}}/issues/44660
[44621]: {{site.repo.dart.sdk}}/issues/44621
[42312]: {{site.repo.dart.sdk}}/issues/42312
[44622]: {{site.repo.dart.sdk}}/issues/44622
[44072]: {{site.repo.dart.sdk}}/issues/44072

## 2.10.0

### Tools

### 工具

#### Dart VM

#### Dart VM

* [Renamed `dart_api_dl.cc` to `dart_api_dl.c`][42982] and changed to a pure C file.

  [`dart_api_dl.cc` 重命名为 `dart_api_dl.c`][42982]，并改为纯 C 文件。

[42982]: {{site.repo.dart.sdk}}/issues/42982

## 2.9.0

### Libraries

### 库

#### `dart:convert`

* When encoding a string containing unpaired surrogates as UTF-8, [the unpaired
  surrogates will be encoded as replacement characters][41100] (`U+FFFD`).

  把包含未配对代理项的字符串编码为 UTF-8 时，
  [未配对的代理项会被编码为替换字符][41100]（`U+FFFD`）。
* When decoding UTF-8, [encoded surrogates will be treated as malformed input][41100].

  解码 UTF-8 时，[编码的代理项会被视为格式错误的输入][41100]。
* [Changed the number of replacement characters emitted][41100] for malformed
  input sequences to match the [WHATWG encoding standard][] when decoding UTF-8
  with `allowMalformed: true`.

  使用 `allowMalformed: true` 解码 UTF-8 时，
  [格式错误输入序列产生的替换字符数量已更改][41100]，
  与 [WHATWG 编码标准][whatwg encoding standard] 保持一致。

#### `dart:html`

* `CssClassSet.add()` and `CssClassSet.toggle` now return `false` instead of
   `null` if the `CssClassSet` corresponds to multiple elements. 

  如果 `CssClassSet` 对应多个元素，
  `CssClassSet.add()` 和 `CssClassSet.toggle` 现在返回 `false` 而非 `null`。

#### `dart:mirrors`

* [Web compilers (dart2js and DDC) now produce a compile-time error][42714] if
  `dart:mirrors` is imported.

  如果导入了 `dart:mirrors`，
  [Web 编译器（dart2js 和 DDC）现在会产生编译时错误][42714]。

### Tools

### 工具

#### Dart VM

#### Dart VM

* When printing a string using the `print` function, [the default implementation
  will print any unpaired surrogates in the string as replacement characters][41100]
  (`U+FFFD`).

  使用 `print` 函数打印字符串时，[默认实现会把字符串中
  未配对的代理项打印为替换字符][41100]（`U+FFFD`）。
* The `Dart_StringToUTF8` function in the Dart API [will convert unpaired
  surrogates into replacement characters][41100].

  Dart API 中的 `Dart_StringToUTF8` 函数
  [会把未配对的代理项转换为替换字符][41100]。


[41100]: {{site.repo.dart.sdk}}/issues/41100
[whatwg encoding standard]: https://encoding.spec.whatwg.org/#utf-8-decoder
[42714]: {{site.repo.dart.sdk}}/issues/42714

## 2.8.1

### Language

### 语言

* [Fixed an implementation bug][40675] where local variable inference would
  incorrectly use the promoted type of a type variable.

  [修复了一个实现 bug][40675]：
  局部变量推断会错误地使用类型变量的提升类型。
* [Fixed an implementation bug][41362] surrounding the clauses
  `implements Function`, `extends Function`, or `with Function` no longer having
  an effect since Dart 2.0.0.

  [修复了一个实现 bug][41362]：
  `implements Function`、`extends Function` 或 `with Function` 子句
  自 Dart 2.0.0 起不再起作用。

### Libraries

### 库

#### `dart:async`

* [Changed the return type of `StreamSubscription.cancel()` to `Future<void>`][40676].

  [`StreamSubscription.cancel()` 的返回类型改为 `Future<void>`][40676]。
* [Split the `runZoned()` function into two functions][40681]:
  `runZoned()` and `runZonedGuarded()`, where the latter has a
  required `onError` parameter, and the former has none.

  [`runZoned()` 函数拆分为两个函数][40681]：
  `runZoned()` 和 `runZonedGuarded()`，
  后者有必需的 `onError` 参数，前者没有。
* Errors passed to `Completer.completeError()`, `Stream.addError()`,
  `Future.error()`, etc. [can no longer be `null`][40683].

  传给 `Completer.completeError()`、`Stream.addError()`、
  `Future.error()` 等的错误[不能再是 `null`][40683]。
* [Made stack traces non-null ][40130].

  [堆栈跟踪改为非空][40130]。

#### `dart:core`

* Three members on `RuneIterator` [no longer return `null`][40674] when accessed
  before the first call to `moveNext()`.

  在第一次调用 `moveNext()` 之前访问时，
  `RuneIterator` 的三个成员[不再返回 `null`][40674]。
* The `String.fromEnvironment()` default value for `defaultValue` 
  [is now an empty string instead of `null`][40678].

  `String.fromEnvironment()` 的 `defaultValue` 默认值
  [现在是空字符串而非 `null`][40678]。
* The default value for `int.fromEnvironment()`'s `defaultValue` parameter
  [is now zero][40678].

  `int.fromEnvironment()` 的 `defaultValue` 参数默认值
  [现在是零][40678]。

#### `dart:ffi`

* Changed `Pointer.asFunction()` and `DynamicLibrary.lookupFunction()` to
  extension methods.

  `Pointer.asFunction()` 和 `DynamicLibrary.lookupFunction()`
  改为 extension 方法。

#### `dart:io`

* [Changed the signature of `HttpHeaders` methods][33501] `add()` and `set`.

  [更改了 `HttpHeaders` 方法][33501] `add()` 和 `set` 的签名。
* [The `Socket` class now throws a `SocketException`][40702] if the socket has
  been explicitly destroyed or upgraded to a secure socket upon setting or getting socket options.

  如果套接字已被显式销毁或升级为安全套接字，
  设置或获取套接字选项时，
  [`Socket` 类现在会抛出 `SocketException`][40702]。
* [The `Process` class now throws a `StateError`][40483]
  if the process is detached (`ProcessStartMode.detached` and
  `ProcessStartMode.detachedWithStdio`) upon accessing the `exitCode` getter.

  如果进程已分离（`ProcessStartMode.detached` 和
  `ProcessStartMode.detachedWithStdio`），
  访问 `exitCode` getter 时，
  [`Process` 类现在会抛出 `StateError`][40483]。
* [The `Process` class now also throws][40483] when not connected to the child
  process's stdio (`ProcessStartMode.detached` and `ProcessStartMode.inheritStdio`) upon accessing the `stdin`, `stdout`, and `stderr` getters.

  如果未连接到子进程的 stdio（`ProcessStartMode.detached` 和
  `ProcessStartMode.inheritStdio`），访问 `stdin`、`stdout` 和 `stderr` getter 时，
  [`Process` 类现在也会抛出异常][40483]。
* The dummy object returned if `FileStat.stat()` or `FileStat.statSync()` fail
  [now contains Unix epoch timestamps][40706] instead of `null` for the `accessed`,
  `changed`, and `modified` getters.

  `FileStat.stat()` 或 `FileStat.statSync()` 失败时返回的虚拟对象，
  其 `accessed`、`changed` 和 `modified` getter
  [现在包含 Unix 纪元时间戳][40706]而非 `null`。
* [The `HeaderValue` class now parses more strictly][40709] in two invalid edge cases.

  [`HeaderValue` 类在两种无效的边界情况下解析更严格][40709]。

### Tools

### 工具

#### Dart Dev Compiler (DDC)

#### Dart 开发编译器（DDC）

We fixed several inconsistencies between DDC and Dart2JS so that users less
frequently encounter code that is accepted by one compiler but then fails in the
other.

我们修复了 DDC 和 Dart2JS 之间的多处不一致，
让用户更少遇到被一个编译器接受、
却在另一个编译器上失败的代码。

* Deleted the legacy (analyzer based) version of [DDC][ddc].

  删除了 [DDC][ddc] 的遗留（基于分析器的）版本。
* Functions passed to JavaScript using the recommended `package:js` interop
  specification must now be wrapped with a call to `allowInterop`. 

  使用推荐的 `package:js` 互操作规范传给 JavaScript 的函数，
  现在必须用 `allowInterop` 调用包装。
* Constructors in `@JS()` classes must be marked with `external`.

  `@JS()` 类中的构造函数必须标记为 `external`。

#### `dart2js`

* Corresponding type parameter bounds now only need to be mutual
  subtypes rather than structurally equal up to renaming of bound type variables
  and equating all top types.

  对应的类型参数上界现在只需互为子类型，
  而不必在重命名约束类型变量、等同所有顶层类型后
  结构相等。
* Types are now [normalized].

  类型现在会被[规范化][normalized]。
* Constructors in `@JS()` classes must be marked with `external`.

  `@JS()` 类中的构造函数必须标记为 `external`。
* Completely removed the `--package-root` flag, which was hidden and disabled
  in Dart 2.0.0.

  完全移除了 `--package-root` 参数，
  它在 Dart 2.0.0 中已被隐藏和禁用。

[40675]: {{site.repo.dart.sdk}}/issues/40675
[41362]: {{site.repo.dart.sdk}}/issues/41362
[40676]: {{site.repo.dart.sdk}}/issues/40676
[40681]: {{site.repo.dart.sdk}}/issues/40681
[40683]: {{site.repo.dart.sdk}}/issues/40683
[40130]: {{site.repo.dart.sdk}}/issues/40130
[40674]: {{site.repo.dart.sdk}}/issues/40674
[40678]: {{site.repo.dart.sdk}}/issues/40678
[33501]: {{site.repo.dart.sdk}}/issues/33501
[40702]: {{site.repo.dart.sdk}}/issues/40702
[40483]: {{site.repo.dart.sdk}}/issues/40483
[40706]: {{site.repo.dart.sdk}}/issues/40706
[40709]: {{site.repo.dart.sdk}}/issues/40709
[ddc]: {{site.repo.dart.sdk}}/issues/38994
[normalized]: {{site.repo.dart.lang}}/blob/main/resources/type-system/normalization.md

## 2.7.1

* [The Dart SDK for macOS is now only available for x64][39810].

  [macOS 版 Dart SDK 现在只提供 x64 版本][39810]。

[39810]: {{site.repo.dart.sdk}}/issues/39810

## 2.7.0

### Language

### 语言

* [Static extension members are accessible when imported with a prefix][671].

  [带前缀导入时也可以访问静态 extension 成员][671]。

### Libraries

### 库

#### `dart:io`

* Added `IOOverrides.serverSocketBind` to aid in writing tests that wish to mock
  `ServerSocket.bind`.

  新增 `IOOverrides.serverSocketBind`，
  帮助编写想要 mock `ServerSocket.bind` 的测试。

## 2.6.0

### Language

### 语言

* [Changed inference when using `Null` values in a `FutureOr` context][37985].
  Namely, constraints of the forms similar to `Null` <: `FutureOr<T>` now yield
  `Null` as the solution for `T`.

  [更改了在 `FutureOr` 上下文中使用 `Null` 值时的推断][37985]。
  即类似 `Null` <: `FutureOr<T>` 形式的约束，
  现在得出 `T` 的解为 `Null`。

### Libraries

### 库

#### `dart:ffi`

* The API now makes use of static extension members. 

  API 现在使用静态 extension 成员。
* Removed memory management `Pointer.allocate` and `Pointer.free`.

  移除了内存管理方法 `Pointer.allocate` 和 `Pointer.free`。
* `Pointer.offsetBy` was removed, use `cast` and `elementAt` instead.

  移除了 `Pointer.offsetBy`，请改用 `cast` 和 `elementAt`。

[671]: {{site.repo.dart.lang}}/issues/671
[37985]: {{site.repo.dart.sdk}}/issues/37985

## 2.5.0

### Libraries

### 库

* Various methods and properties across various core libraries, which used
  to declare a return type of `List<int>`, were [updated to declare a return type
  of `Uint8List`][36900].

  各核心库中原本声明返回类型为 `List<int>` 的多个方法和属性，
  [已更新为声明返回类型 `Uint8List`][36900]。

#### `dart:io`

* The `Cookie` class's constructor's `name` and `value` optional positional
  parameters [are now mandatory][37192].

  `Cookie` 类构造函数的 `name` 和 `value` 可选位置参数
  [现在是必需的][37192]。
* [The `Cookie` class's `name` and `value` setters now validate][37192]
  that the strings are made from the allowed character set and are not null.

  [`Cookie` 类的 `name` 和 `value` setter 现在会验证][37192]
  字符串由允许的字符集组成且不为 null。

### Tools

### 工具

#### Pub

#### Pub

* Packages published to [pub.dev]({{site.pub}}) [can no longer contain git
  dependencies][36765].

  发布到 [pub.dev]({{site.pub}}) 的 package
  [不能再包含 git 依赖][36765]。

[36900]: {{site.repo.dart.sdk}}/issues/36900
[37192]: {{site.repo.dart.sdk}}/issues/37192
[37192]: {{site.repo.dart.sdk}}/issues/37192
[36765]: {{site.repo.dart.sdk}}/issues/36765

## 2.4.0

### Language

### 语言

* [Covariance of type variables used in super-interfaces is now enforced][35097]. 

  [现在会强制检查超接口中使用的类型变量的协变性][35097]。

### Libraries

### 库

#### `dart:isolate`

* `Isolate.resolvePackageUri` will always throw an `UnsupportedError` when
  compiled with dart2js or DDC.

  用 dart2js 或 DDC 编译时，
  `Isolate.resolvePackageUri` 总是抛出 `UnsupportedError`。

#### `dart:async`

* [Fixed a bug in the `StreamIterator` class][36382] where `await for` allowed
  `null` as a stream.

  [修复了 `StreamIterator` 类的一个 bug][36382]：
  `await for` 曾允许 `null` 作为流。

[35097]: {{site.repo.dart.sdk}}/issues/35097
[36382]: {{site.repo.dart.sdk}}/issues/36382

## 2.2.0

### Libraries

### 库

#### `package:kernel`

* The `klass` getter on the `InstanceConstant` class in the
  Kernel AST API has been renamed to `classNode` for consistency.

  为保持一致，Kernel AST API 中 `InstanceConstant` 类的
  `klass` getter 已重命名为 `classNode`。
* [Updated `Link` implementation][33966] to utilize true symbolic
  links instead of junctions on Windows.

  [更新了 `Link` 实现][33966]，
  在 Windows 上使用真正的符号链接而非 junction。

[33966]: {{site.repo.dart.sdk}}/issues/33966

## 2.1.1

### Libraries

### 库

#### `dart:io`

* [Added to a closed `IOSink` now throws a `StateError`][29554].

  [向已关闭的 `IOSink` 添加数据现在会抛出 `StateError`][29554]。

[29554]: {{site.repo.dart.sdk}}/issues/29554

### Tools

### 工具

#### Dart VM

#### Dart VM

* [Fixed a soundness hole when using `dart:mirrors`][35611] to reflectively
  invoke a method in an incorrect way that violates its static types.

  [修复了使用 `dart:mirrors` 时的一个健全性漏洞][35611]：
  以违反静态类型的错误方式反射调用方法。

[29554]: {{site.repo.dart.sdk}}/issues/29554
[35611]: {{site.repo.dart.sdk}}/issues/35611

## 2.1.0

### Language

### 语言

* A number of static errors that should have been detected
  and reported were not supported in 2.0.0. These are reported now, which means
  existing incorrect code might show new errors:

  一些本应被检测和报告的静态错误在 2.0.0 中未受支持。
  现在会报告这些错误，意味着现有的错误代码可能显示新错误：
  * [Mixins must correctly override their superclasses][34235].

    [mixin 必须正确重写其超类][34235]。
  * [Implicit type arguments in extends clauses must satisfy the class bounds][34532].

    [extends 子句中的隐式类型实参必须满足类的约束][34532]。
  * [Instance members should shadow prefixes][34498].

    [实例成员应遮蔽前缀][34498]。
  * [Constructor invocations must use valid syntax, even with optional `new`][34403].

    [即使 `new` 可选，构造函数调用也必须使用合法语法][34403]。
  * [Type arguments to generic typedefs must satisfy their bounds][33308].

    [泛型 typedef 的类型实参必须满足其约束][33308]。
  * [Classes can't implement FutureOr][33744].

    [类不能实现 FutureOr][33744]。
  * [Abstract methods may not unsoundly override a concrete method][32014].

    [抽象方法不能以不健全的方式重写具体方法][32014]。
  * [Constant constructors cannot redirect to non-constant constructors][34161].

    [常量构造函数不能重定向到非常量构造函数][34161]。
  * [Setters with the same name as the enclosing class aren't allowed][34225].

    [不允许与所在类同名的 setter][34225]。

### Tools

### 工具

#### `dart2js`

* Duplicate keys in a const map are not allowed and produce a compile-time error.

  const map 中不允许重复的键，会产生编译时错误。

[32014]: {{site.repo.dart.sdk}}/issues/32014
[33308]: {{site.repo.dart.sdk}}/issues/33308
[33744]: {{site.repo.dart.sdk}}/issues/33744
[34161]: {{site.repo.dart.sdk}}/issues/34161
[34225]: {{site.repo.dart.sdk}}/issues/34225
[34235]: {{site.repo.dart.sdk}}/issues/34235
[34403]: {{site.repo.dart.sdk}}/issues/34403
[34498]: {{site.repo.dart.sdk}}/issues/34498
[34532]: {{site.repo.dart.sdk}}/issues/34532

## 2.0.0

### Language

### 语言

* Replaced the unsound optional static type system with a sound static type
  system using type inference and runtime checks, formerly called [strong mode].

  用基于类型推断和运行时检查的健全静态类型系统
  取代了不健全的可选静态类型系统，
  前者曾称为 [strong mode]。
* [Functions marked `async` now run synchronously][30345] until the first
  `await` statement.

  [标记为 `async` 的函数现在同步运行][30345]，
  直到第一个 `await` 语句。

### Libraries

### 库

* Renamed constants in the core libraries from `SCREAMING_CAPS` to `lowerCamelCase`.

  核心库中的常量从 `SCREAMING_CAPS` 重命名为 `lowerCamelCase`。
* Added many new methods to core library classes that will need to be implemented
  if you implement the interfaces of these classes.

  为核心库类添加了许多新方法，
  如果你实现这些类的接口，就需要实现这些方法。
* `dart:isolate` and `dart:mirrors` are no longer supported when
  using Dart for the web.

  在 Web 上使用 Dart 时，
  不再支持 `dart:isolate` 和 `dart:mirrors`。

### Tools

### 工具

#### Pub

#### Pub

* Replaced pub's transformer-based build system with a [new build system][build system].

  用[新的构建系统][build system]取代了 pub 基于 transformer 的构建系统。

[30345]: {{site.repo.dart.sdk}}/issues/30345
[strong mode]: /language/type-system
[build system]: {{site.repo.dart.org}}/build
