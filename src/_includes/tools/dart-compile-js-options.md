#### Options {:#prod-compile-options}

#### 选项

The `dart compile js` command has multiple options
to customize javascript code compilation.

`dart compile js` 命令有多个选项，
用来自定义 JavaScript 代码的编译。

* [Basic options](#basic-options)

  [基本选项](#basic-options)

* [Path and environment options](#path-and-environment-options)

  [路径与环境选项](#path-and-environment-options)

* [Display options](#display-options)

  [显示选项](#display-options)

* [Analysis options](#analysis-options)

  [分析选项](#analysis-options)

###### Basic options

###### 基本选项

Common options include:

常用选项包括：

`-o <file>` or `--output=<file>`
: Generates the output into `<file>`. 
  If not specified, the output goes in a file named `out.js`.

  把输出写入 `<file>`。
  如果未指定，输出会写入名为 `out.js` 的文件。

`--enable-asserts`
: Enables assertion checking.

  启用断言检查。

`-O{0|1|2|3|4}`
: Controls optimizations to reduce file size and
  improve code performance.
  To learn more about these optimizations, 
  run `dart compile js -hv`.

  控制优化，以减小文件体积并提高代码性能。
  想进一步了解这些优化，
  请运行 `dart compile js -hv`。

  * `-O0`: Disables many optimizations.

    `-O0`：关闭许多优化。

  * `-O1`: Enables default optimizations.

    `-O1`：启用默认优化。

  * `-O2`: Enables `-O1` optimizations, plus additional ones
    (such as minification) that respect the language semantics and
    are safe for all programs.

    `-O2`：启用 `-O1` 的优化，并加上额外的优化
    （例如压缩），这些优化遵守语言语义，
    对所有程序都是安全的。

    :::note
    With `-O2`, string representations of types are no longer the same as
    those in the Dart VM when compiled with the development JavaScript compiler.

    使用 `-O2` 时，类型的字符串表示
    不再与用开发用 JavaScript 编译器编译时 Dart VM 中的表示相同。
    :::
  * `-O3`: Enables `-O2` optimizations, plus omits implicit type checks.
    
    `-O3`：启用 `-O2` 的优化，并省略隐式类型检查。

    :::warning
    Omitting type checks can cause your app to crash due to type errors.
    Before using `-O3`, **test using `-O2`** to ensure that your app
    **never** throws a subtype of `Error` (such as `TypeError`).

    省略类型检查可能让应用因类型错误而崩溃。
    使用 `-O3` 之前，请 **用 `-O2` 测试**，确保应用
    **永远不会** 抛出 `Error` 的子类型（例如 `TypeError`）。
    :::
  * `-O4`: Enables more aggressive optimizations than `-O3`,
    but with the same assumptions.
    
    `-O4`：启用比 `-O3` 更激进的优化，
    但前提假设相同。

    :::warning
    The `-O4` optimizations are susceptible to variations in input data.
    Before relying on `-O4`, **test for edge cases in user input**.

    `-O4` 的优化容易受输入数据变化的影响。
    依赖 `-O4` 之前，请 **测试用户输入的边界情况**。
    :::

`--no-source-maps`
: Do not generate a source map file.

  不生成 source map 文件。

`-h` or `--help`
: Displays help. To get information about all options, use `-hv`.

  显示帮助。要查看所有选项的信息，请使用 `-hv`。


###### Path and environment options

###### 路径与环境选项

Some other handy options include:

其他一些方便的选项包括：

`--packages=<path>`
: Specifies the path to the package resolution configuration file.
  For more information, check out the
  [Dart package configuration file][] specification.

  指定 package 解析配置文件的路径。
  更多信息请查阅
  [Dart package 配置文件][Dart package configuration file] 规范。

`-D<flag>=<value>`
: Defines an environment declaration and value pair
  which can be accessed with 
  [`String.fromEnvironment`][], [`int.fromEnvironment`][], 
  [`bool.fromEnvironment`][], or [`bool.hasEnvironment`][].
  To learn more about environment declarations,
  see [Configuring apps with compilation environment declarations][].

  定义一对环境声明和值，
  可以通过 [`String.fromEnvironment`][]、[`int.fromEnvironment`][]、
  [`bool.fromEnvironment`][] 或 [`bool.hasEnvironment`][] 访问。
  想进一步了解环境声明，
  请看 [用编译环境声明配置应用][Configuring apps with compilation environment declarations]。

`--version`
: Displays version information for `dart`.

  显示 `dart` 的版本信息。

[Dart package configuration file]: {{site.repo.dart.lang}}/blob/main/accepted/2.8/language-versioning/package-config-file-v2.md
[`String.fromEnvironment`]: {{site.dart-api}}/dart-core/String/String.fromEnvironment.html
[`int.fromEnvironment`]: {{site.dart-api}}/dart-core/int/int.fromEnvironment.html
[`bool.fromEnvironment`]: {{site.dart-api}}/dart-core/bool/bool.fromEnvironment.html
[`bool.hasEnvironment`]: {{site.dart-api}}/dart-core/bool/bool.hasEnvironment.html
[Configuring apps with compilation environment declarations]: /libraries/core/environment-declarations

###### Display options

###### 显示选项

The following options help you control the compiler output.

下面这些选项用来控制编译器的输出。

`--suppress-warnings`
: Doesn't display warnings.

  不显示警告。

`--suppress-hints`
: Doesn't display hints.

  不显示提示。

`--terse`
: Emits diagnostics, 
  without suggesting how to get rid of the diagnosed problems.

  输出诊断信息，
  但不建议如何消除被诊断出的问题。

`-v` or `--verbose`
: Displays lots of information.

  显示大量信息。


###### Analysis options

###### 分析选项

The following options control the analysis performed on Dart code.

下面这些选项控制对 Dart 代码执行的分析。

`--fatal-warnings`
: Treat warnings as compilation errors.

  把警告当作编译错误。

`--enable-diagnostic-colors`
: Adds colors to diagnostic messages.

  为诊断消息加上颜色。

`--show-package-warnings`
: Shows warnings and hints generated from packages.

  显示 package 产生的警告和提示。

`--csp`
: Disables dynamic generation of code in the generated output.
  This is necessary to satisfy CSP restrictions
  (see [W3C Content Security Policy.](https://www.w3.org/TR/CSP/))

  禁止在生成的输出中动态生成代码。
  这是满足 CSP 限制所必需的
  （见 [W3C 内容安全策略](https://www.w3.org/TR/CSP/)）。

`--dump-info`
: Generates a file (with the suffix `.info.json`)
  that contains information about the generated code.
  You can inspect the generated file with tools in
  [dart2js_info](/go/dart2js-info).

  生成一个后缀为 `.info.json` 的文件，
  其中包含所生成代码的信息。
  你可以用 [dart2js_info](/go/dart2js-info) 中的工具
  检查生成的文件。
