---
title: Migrating to null safety
title: 迁移至空安全
description: How to move your existing Dart code to the world of null safety
description: 将您现有的代码带到空安全的世界
---

This page describes how and when to migrate your code to [null safety][].
Here are the basic steps for migrating each package that you own:

本文将介绍如何将您的代码迁移至 [空安全][null safety]。
以下是对您的软件包逐个迁移的基本步骤：

1. [**Wait**](#step1-wait) for the packages
   that you depend on to migrate.

   [**等待**](#step1-wait) 您依赖的软件包迁移完成。

2. [**Migrate**](#step2-migrate) your package's code,
   preferably using the interactive migration tool.

   [**迁移**](#step2-migrate) 您的包的代码，最好使用交互式的迁移工具。

3. [**Statically analyze**](#step3-analyze) your package's code.

   [**静态分析**](#step3-analyze) 包的代码。

4. [**Test**](#step4-test) to make sure your changes work.

   [**测试**](#step4-test) 您的代码，确保可用。

5. If the package is already on pub.dev,
   [**publish**](#step5-publish) the null-safe version
   as a **prerelease** version.

   如果您已经在 pub.flutter-io.cn 发布了您的包，
   可以将迁移完成的空安全版本以 **预发布** 版本进行 [**发布**](#step5-publish)。

{{ site.alert.info }}

  **Migrating an app is technically the same as migrating a package.**
  Before migrating an app,
  consider waiting for a stable release of the Dart SDK that
  contains null safety. 
  Also, make sure all your dependencies are ready.

  **理论上，迁移应用和迁移软件包的过程一致。**
  在迁移应用之前，建议您等到 Dart 发布包含空安全的稳定版 SDK，
  且您所依赖的包全部迁移完成后，再进行迁移。

{{ site.alert.end }}

For an informal look at the experience of using the migration tool, watch this video:

如果您想预览迁移工具的体验，可以查看以下视频：

<iframe width="560" height="315" src="https://www.youtube.com/embed/eBr5tlumwlg" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

[null safety]: /null-safety

**可交互的迁移工具让您可以简化迁移至空安全的过程。**

## 1. Wait to migrate {#step1-wait}

## 1. 等待迁移 {#step1-wait}

We strongly recommend migrating code in order, 
with the leaves of the dependency graph being migrated first.
For example, if package C depends on package B, which depends on package A,
then A should be migrated to null safety first, then B, then C.

我们强烈建议您按顺序迁移代码，先迁移依赖关系中的处于最末端的依赖。
例如，如果 C 依赖了 B，B 依赖了 A，那么应该按照 A -> B -> C 的顺序进行迁移。

![Illustration of C/B/A sentence](/null-safety/null-safety-migration-order.png){:width="454px"}<br>

Although you [_can_ migrate][Unsound null safety]
before your dependencies support null safety,
you might have to change your code when your dependencies migrate.
For example, if you predict that a function will take a nullable parameter but
the package migrates it to be non-nullable,
then passing a nullable argument becomes a compile error.

虽然您在您的所有依赖迁移完成前就 [**可以** 进行迁移][Unsound null safety]，
但在它们迁移完成后，您可能需要再对您的代码进行调整。
例如，如果您推测一个函数可以接受一个可空的参数，但依赖的包迁移后变为了非空，
在传递可空的参数时便会出现编译错误。

{{ site.alert.info }}

  **You can — and should — migrate your package before
  packages that depend on it are migrated.**
  Your null-safe package is usable by packages and apps that
  don't use null safety yet,
  as long as they use Dart 2.12 or later.
  For example, the Dart and Flutter core libraries are null safe,
  and they're still usable by apps that haven't migrated to null safety.

  **您应当在其他依赖于您的软件包进行迁移之前，对您的包进行迁移。**
  您已迁移的软件包对于未进行迁移的包和应用而言，仍然可用（前提是使用的 Dart 2.12 及之后的版本）。
  例如，Dart 和 Flutter 的核心库现已完全迁移至空安全，而尚未进行迁移的应用仍然可以使用。

{{ site.alert.end }}

This section tells you how to
check and update your package's dependencies,
with the help of the `dart pub outdated` command in null-safety mode.
The instructions assume your code is under **source control**,
so that you can easily undo any changes.

该节会讲述如何在空安全模式下，使用 `dart pub outdated` 检查并更新您的依赖。
如果您的代码应用了 **版本管理**，您可以随时回滚所有的改动。

### Switch to the Dart 2.12 release

### 切换至 2.12 beta 版本

Switch to the **latest stable release**
of either the Dart SDK or the Flutter SDK.

**切换至最新的稳定版本** 的 Dart SDK 或 Flutter SDK。
您可以根据您的使用情况，参考以下的方式获取 SDK：

Check that you have Dart 2.12 or later:

查看您的 Dart 版本是否为 2.12 或更高：

  ```terminal
$ dart --version
```

### Check dependency status

### 检查所有依赖的迁移状态

Get the migration state of your package's dependencies,
using the following command:

通过以下命令检查您的依赖包的迁移状态：

```terminal
$ dart pub outdated --mode=null-safety
```

If the output says that all the packages support null safety,
then you can start migrating.
Otherwise, use the **Resolvable** column to find
null-safe releases, if they exist.

如果您看到所有依赖都已支持空安全，就意味着您可以开始迁移了。
否则请使用 **Resolvable** 列内列举的已迁移至空安全的版本。

{{ site.alert.info }}

  **Why do all dependencies need to support null safety?**
  When all of an app's direct dependencies support null safety,
  you can _run the app_ with sound null safety.
  When all the dev dependencies support null safety,
  you can _run tests_ with sound null safety.
  You might also need null-safe dev dependencies for other reasons,
  such as code generation.

  **为何所有的依赖都需要支持空安全？**
  当应用的所有依赖都支持空安全时，您可以在健全的空安全下 **运行应用**。
  同样，当开发期依赖也已支持时，您可以在健全的空安全下 **进行测试**。
  您可能会因为需要生成代码，而使用已迁移到空安全的开发期依赖。

{{ site.alert.end }}

Here's an example of the output for a simple package.
The green checkmarked version for each package supports null safety:

这是一个简单的包的输入示例。
每个包的绿色对勾代表着对应版本已支持空安全：

![Output of dart pub outdated](/null-safety/pub-outdated-output.png)

The output shows that all of the package's dependencies
have resolvable prereleases that support null safety.

上面的输出说明了所有依赖的包都有可使用的已支持空安全的预发布版本。

If any of your package's dependencies _don't_ yet support null safety,
we encourage you to reach out to the package owner.
You can find contact details on the package page on [pub.dev][].

如果您的软件包的依赖中，有一些 **尚未** 支持空安全，
我们推荐您联系对应依赖的作者。
您可以在 [pub.flutter-io.cn][pub.dev] 对应依赖包的页面，找到作者的联系信息。

[pub.dev]: {{ site.pub }}


### Update dependencies

### 升级依赖

Before migrating your package's code,
update its dependencies to null-safe versions:

1. Run `dart pub upgrade --null-safety` to upgrade to the latest versions
   supporting null safety.
   **Note:** This command changes your `pubspec.yaml` file.

   运行 `dart pub upgrade --null-safety` 将依赖升级至支持空安全的最新版本。
   **注意：** 该命令会更改您的 `pubspec.yaml` 文件。

2. Run `dart pub get`.

   运行 `dart pub upgrade`。

## 2. Migrate {#step2-migrate}

## 2. 迁移 {#step2-migrate}

Most of the changes that your code needs to be null safe
are easily predictable.
For example, if a variable can be `null`,
[its type needs a `?` suffix][nullable type].
A named parameter that shouldn't be nullable
needs to be [marked `required`][required].

您的代码里大部分需要更改的代码，都是可以轻易推导的。
例如，如果一个变量可以为空，[它的类型需要 `?` 后缀][nullable type]。
一个不可以为空的命名参数，需要使用 [`required` 标记][required]。

You have two options for migrating:

针对迁移，您有两个选项可以选择：

* [Use the migration tool][migration tool],
  which can make most of the easily predictable changes for you.

  [使用迁移工具][migration tool]，它可以帮您处理大多数可推导的变更。

* [Migrate your code by hand.](#migrating-by-hand)

  [自己动手，丰衣足食。](#migrating-by-hand)

{{ site.alert.tip }}

  For additional help while migrating code, check the
  [null safety FAQ][].

  若您在迁移过程中需要额外的帮助，请查看 [空安全常见问题][null safety FAQ]。

{{ site.alert.end }}

[nullable type]: /null-safety#creating-variables
[required]: /null-safety/understanding-null-safety#required-named-parameters
[migration tool]: #migration-tool
[null safety FAQ]: /null-safety/faq


### Using the migration tool {#migration-tool}

### 使用迁移工具 {#migration-tool}

The migration tool takes a package of null-unsafe Dart code
and converts it to null safety.
You can guide the tool's conversion by
adding [hint markers][] to your Dart code.

迁移工具会带上一个非空安全的包，将它转换至空安全。
您可以先在代码中添加 [提示标记][hint markers] 来引导迁移工具的转换。

[hint markers]: #hint-markers

Before starting the tool, make sure you're ready:

开始转换前，请做好如下的准备：

* Use the latest beta release of the Dart SDK.

  使用 Dart SDK 的最新 beta 版本。

* Use `dart pub outdated --mode=null-safety` to make sure that
  all dependencies are null safe and up-to-date.

  运行 `dart pub outdated --mode=null-safety`
  以确保所有依赖为最新且空安全。

Start the migration tool by running the `dart migrate` command
in the directory that contains the package's `pubspec.yaml` file:

在包含 `pubspec.yaml` 的目录下，执行 `dart migrate` 命令，启动迁移工具。

```terminal
$ dart migrate
```

If your package is ready to migrate,
then the tool produces a line like the following:

如果您的包可以进行迁移，工具会输出类似以下的内容：

```terminal
View the migration suggestions by visiting:

  http://127.0.0.1:60278/Users/you/project/mypkg.console-simple?authToken=Xfz0jvpyeMI%3D
```

Visit that URL in a Chrome browser
to see an interactive UI
where you can guide the migration process:

使用 Chrome 浏览器访问 URL，您可以看到一个交互式的界面，引导您进行迁移：

![Screenshot of migration tool](/null-safety/migration-tool.png)

For every variable and type annotation,
you can see what nullability the tool infers.
For example, in the preceding screenshot,
the tool infers that the `ints` list (previously a list of `int`)
in line 1 is nullable, and thus should be a list of `int?`.

您可以在工具中看到其推断的所有变量和类型注解。
例如，在上面的截图中，工具推断第一行的 `ints` 列表元素可能为空，
所以应该变为 `int?`（先前为 `int`）。

#### Understanding migration results

#### 理解迁移的结果

To see the reasons for each change (or non-change),
click its line number in the **Proposed Edits** pane.
The reasons appear in the **Edit Details** pane.

若要了解每个变化（或者未变化）的原因，点击 **Proposed Edits** 窗口中的行数，
原因会出现在 **Edit Details** 窗口中。

For example, consider the following code,
from before null safety:

举个例子，假设我们有如下的非空安全的代码：

```dart
var ints = const <int>[0, null];
var zero = ints[0];
var one = zero + 1;
var zeroOne = <int>[zero, one];
```

The default migration when this code is outside a function
(it's different within a function)
is backward compatible but not ideal:

当这些代码处在函数外时，默认的迁移改动是向后兼容的，但并不理想
（在函数内时会稍有不同）：

```dart
var ints = const <int?>[0, null];
var zero = ints[0];
var one = zero! + 1;
var zeroOne = <int?>[zero, one];
```

By clicking the **line 3** link,
you can see the migration tool's reasons for
adding the `!`.
Because you know that `zero` can't be null,
you can improve the migration result.

点击 **line 3** 链接，您可以看到迁移工具添加 `!` 的原因。
而因为您知道 `zero` 不会为空，所以您可以改进迁移结果。

#### Improving migration results {#hint-markers}

#### 改进迁移的结果 {#hint-markers}

When analysis infers the wrong nullability,
you can override its proposed edits by inserting temporary hint markers:

当分析结果推导了错误的可空性时，您可以添加临时的提示标记来改变建议的编辑：

* In the **Edit Details** pane of the migration tool,
  you can insert hint markers using the
  **Add `/*?*/` hint** and **Add `/*!*/` hint** buttons.

  在迁移工具的 **Edit Details** 窗格中，您可以通过 **Add `/*?*/` hint** 和
  **Add `/*!*/` hint** 按钮来添加提示标记。

  These buttons add comments to your file immediately,
  and there's **no Undo**.
  If you don't want a hint that the tool inserted,
  you can use your usual code editor to remove it.

  按下这些按钮，相应的标记会立刻添加到代码中，并且 **无法撤销**。
  如果您想删除标记，可以和平常一样使用代码编辑器删除它。

* You can use an editor to add hint markers,
  even while the tool is still running.
  Because your code hasn't opted into null safety yet,
  you can't use new null-safety features.
  You can, however, make changes like refactoring
  that don't depend on null-safety features.

  就算迁移工具正在运行，您也可以使用编辑器添加提示标记。
  由于您的代码还未迁移到空安全，所以无法使用空安全的新特性。
  但是您可以进行与空安全无关的改动，例如重构。

  When you've finished editing your code,
  click **Rerun from sources** to pick up your changes.

  当您完成编辑后，点击 **Rerun from sources** 进行更改。

The following table shows the hint markers that you can use
to change the migration tool's proposed edits.

下方的表格展示了可以使用的提示标记。

|------------------+--------------------------------------------------------------------------|
| <t>Hint marker</t><t>提示标记</t> | <t>Effect on the migration tool</t><t>对迁移工具的影响</t> |
|------------------|--------------------------------------------------------------------------|
| <code><em>expression</em>&nbsp;/*!*/</code> | <t>Adds a `!` to the migrated code, casting _expression_ to its underlying non-nullable type.</t><t>添加 `!` 至代码中，将 **表达式** 转换为其基础类型对应的不可空的类型。</t> |
| <code><em>type</em> /*!*/</code> | <t>Marks _type_ as non-nullable.</t><t>将 **类型** 标记为非空。</t> |
| `/*?*/`          | <t>Marks the preceding type as nullable.</t><t>将前面的类型标记为可空。</t> |
| `/*late*/`       | <t>Marks the variable declaration as `late`, indicating that it has late initialization.</t><t>将变量声明标记为 `late`，表示其不会第一时间进行初始化。</t> |
| `/*late final*/` | <t>Marks the variable declaration as `late final`, indicating that it has late, one-time initialization.</t><t>将变量声明标记为 `late final`，表示其不会第一时间进行初始化，且初始化后不可改变。</t> |
| `/*required*/`   | <t>Marks the parameter as `required`.</t><t>将参数标记为 `required`。</t> |
{:.table .table-striped}

A single hint can have ripple effects elsewhere in the code.
In the example from before,
manually adding a `/*!*/` marker where `zero` is assigned its value (on line 2)
makes the migration tool infer the type of `zero` as `int` instead of `int?`.
This type change can affect code that directly or indirectly uses `zero`.

一个提示也可能产生蝴蝶效应，影响其他的代码。
在先前的例子中，如果在 `zero` 被赋值的位置（第二行）添加一个 `/*!*/` 标记，
迁移工具就会推断 `zero` 的类型是 `int` 而非 `int?`。
这就会影响到直接或间接使用了 `zero` 的代码。

```dart
var zero = ints[0]/*!*/;
```

With the above hint, the migration tool changes its proposed edits,
as the following code snippets show.
Line 3 no longer has a `!` after `zero`,
and in line 4 `zeroOne` is inferred to be
a list of `int`, not `int?`.

通过添加了以上的提示，迁移工具将调整建议的更改，如下面的代码所示。
第三行的 `zero` 后面不再有 `!`，第四行的 `zeroOne` 也被推断为 `int` 列表而不是 `int?`。

<table markdown="1">
<tr>
<th><t>First migration</t><t>首次迁移</t></th>
<th><t>Migration with hint</t><t>添加提示后的迁移</t></th>
</tr>
<tr markdown="1">
  <td markdown="1">
```dart
var ints = const <int?>[0, null];
var zero = ints[0];
var one = zero! + 1;
var zeroOne = <int?>[zero, one];
```
  </td>
  <td markdown="1">
```dart
var ints = const <int?>[0, null];
var zero = ints[0]/*!*/;
var one = zero + 1;
var zeroOne = <int>[zero, one];
```
  </td>
</tr>
</table>

#### Opting out files

Although we recommend migrating all at once,
sometimes that isn't practical,
especially in a large app or package.
To opt out a file or directory,
click its green checkbox.
Later, when you apply changes,
each opted out file will be unchanged
except for a 2.9 [version comment][].

For more information about incremental migration, see
[Unsound null safety][].

[version comment]: /guides/language/evolution#per-library-language-version-selection


#### Applying changes

#### 应用更改

When you like all of the changes
that the migration tool proposes, click **Apply migration**.
The migration tool deletes the hint markers and
saves the migrated code.
The tool also updates the minimum SDK constraint in the pubspec,
which opts the package into null safety.

当您觉得迁移工具提示的更改部分可以应用了，点击 **Apply migration**。
迁移工具会删除所有的提示标记，保存迁移后的代码。
同时，迁移工具也会更改 pubspec 的 SDK 限制，将包迁移至空安全。

The next step is to [statically analyze your code](#step3-analyze).
If it's valid, then [test your code](#step4-test).
Then, if you've published your code on pub.dev,
[publish a null-safe prerelease](#step5-publish).

下一步就是对代码进行 [**静态分析**](#step3-analyze)。
如果一切正常，下一步就是 [测试您的代码](#step4-test)。
最后，如果您已经将包发布至 pub.flutter-io.cn，
[发布空安全的预览版本](#step5-publish)。

### Migrating by hand

### 手动迁移

If you prefer not to use the migration tool,
you can migrate manually.

如果您不想使用迁移工具，您也可以手动进行迁移。

We recommend that you **first migrate leaf libraries** —
libraries that don't import other files from the package.
Then migrate libraries that directly depend on the leaf libraries.
End by migrating the libraries that have the most
intra-package dependencies.

我们推荐您 **优先迁移最下层的库** &mdash;&mdash; 指的是没有导入其他包的库。
接着迁移直接依赖了下层库的依赖库。
最后再迁移依赖项最多的库。

For example, say you have a `lib/src/util.dart` file
that imports other (null-safe) packages and core libraries,
but that doesn't have any `import '<local_path>'` directives.
Consider migrating `util.dart` first,
and then migrating simple files that depend only on `util.dart`.
If any libraries have cyclic imports
(for example, A imports B which imports C, and C imports A),
consider migrating those libraries together.

举个例子，假设您的 `lib/src/util.dart` 导入了其他（空安全）的软件包和核心库，
但它没有包含任何 `import '<本地路径>'` 的引用。
那么您应当优先考虑迁移 `util.dart`，然后迁移依赖了 `util.dart` 的文件。
如果有一些循环引用的库（例如 A 引用了 B，B 引用了 C，C 引用了 A），
建议同时对它们进行迁移。

To migrate a package by hand, follow these steps:

手动对软件包进行迁移时，请参考以下步骤：

1. Edit the package's `pubspec.yaml` file,
   setting the minimum SDK constraint to `2.12.0`:

   编辑软件包的 `pubspec.yaml` 文件，将最低 SDK 版本设置到 `2.12.0`：

   ```yaml
   environment:
     sdk: '>=2.12.0 <3.0.0'
   ```

2. Regenerate the [package configuration file][]:

   重新生成 [软件包的配置文件][package configuration file]：

   ```terminal
   $ dart pub get
   ```

   [package configuration file]: https://github.com/dart-lang/language/blob/master/accepted/future-releases/language-versioning/package-config-file-v2.md

   Running `dart pub get` with a lower SDK constraint of `2.12.0`
   sets the default language version of
   every library in the package to 2.12,
   opting them all in to null safety.

   在版本最低是 `2.12.0-0` 的 SDK 上运行 `dart pub get` 时，
   会将每个包的默认 SDK 版本设定为 2.12，并且默认它们已经迁移至空安全。

3. Open the package in your IDE. <br>
   You're likely to see a lot of analysis errors.
   That's OK.

   在您的 IDE 上打开软件包。<br>
   您也许会看到很多错误，没关系，让我们继续。

4. Migrate the code of each Dart file,
   using the analyzer to identify static errors. <br>
   Eliminate static errors by adding `?`, `!`, `required`, and `late`,
   as needed.

   利用分析器来辨析静态错误，逐个迁移 Dart 文件。<br>
   按需添加 `?`、`!`、`required` 以及 `late` 来消除静态错误。

See [Unsound null safety][]
for more help on migrating code by hand.

想获得更多手动迁移的帮助，请前往 [非健全的空安全][Unsound null safety]。

[Unsound null safety]: /null-safety/unsound-null-safety


## 3. Analyze {#step3-analyze}

## 3. 分析 {#step3-analyze}

Update your packages
(using `pub get` in your IDE or on the command line).
Then use your IDE or the command line
to perform [static analysis][] on your code:

更新您的软件包（在 IDE 或命令行工具中使用 `pub get`）
后在 IDE 或命令行工具中对您的代码进行 [静态分析][static analysis]：

```terminal
$ dart pub get
$ dart analyze     # or `flutter analyze`
```

[static analysis]: /guides/language/analysis-options


## 4. Test {#step4-test}

## 4. 测试 {#step4-test}

If your code passes analysis, run tests:

如果您的代码通过了分析，接下来可以开始测试：

```terminal
$ dart test       # or `flutter test`
```

You might need to update tests that expect null values.

您可能需要更新使用了空值作为预期用例的测试代码。

If you need to make large changes to your code,
then you might need to remigrate it.
If so, revert your code changes before using the migration tool again.

如果您需要对代码作出大量的更改，那么您可能需要重新对代码进行迁移。
这时请先回滚代码更改，再运行迁移工具进行迁移。

## 5. Publish {#step5-publish}

## 5. 发布 {#step5-publish}

We encourage you to publish packages as prereleases
as soon as you migrate:

我们希望您完成迁移后尽快将其发布为预览版：

* [Set the SDK constraints to the tested beta version.](#sdk-constraints)

  [将 SDK 限制设定为已测试的 beta 版本。](#sdk-constraints)

* [Set the package version to indicate a breaking change.](#version)

  [调整 package 的版，表示该版本包含了破坏性的改动。](#version)

### SDK constraints

Set the lower SDK constraint to 2.12.0:

将 SDK 限制的下界设置为 2.12.0：

```yaml
environment:
  sdk: '>=2.12.0 <3.0.0'
```

With these constraints,
packages that are published during null safety beta
can still work with the next stable release of the Dart SDK.

在空安全测试期间以这种形式进行发布的包，能在下一个 Dart SDK 稳定版中继续使用。

### Package version

### 软件包的版本

Update the version of the package
to indicate a breaking change:

为版本添加 `nullsafety` 后缀，表示该版本包含了破坏性的改动。

* If your package is already at 1.0.0 or greater,
  increase the major version.
  For example, if the previous version is `2.3.2`,
  the new version is `3.0.0`.

  如果您的软件包版本已经大于或等于 1.0.0，请提升主版本。
  例如，上一个版本为 `2.3.2`，那么新版本应该为 **`3.0.0-nullsafety.0`**。

* If your package hasn't reached 1.0.0 yet,
  _either_ increase the minor version _or_ update the version to 1.0.0.
  For example, if the previous version is `0.3.2`,
  the new version is either `0.4.0` or `1.0.0`.

  如果您的软件包的版本还未高于 1.0.0，
  您可以 **提升次版本**，也可以 **提升至 1.0.0**。
  例如，上一个版本为 `0.3.2`，那么新版本可以是 **`0.4.0`** 或 **`1.0.0`**。

Before you publish a stable null safety version of a package,
we strongly recommend following these pubspec rules:

在您发布稳定版本的空安全 package 前，我们强烈建议您遵循以下 pubspec 的规则：

  * Set the Dart lower SDK constraint to `2.12.0`.

    将 SDK 的最低限制设置为 `2.12.0`。

  * Use stable versions of all direct dependencies.

    所有的直接依赖都使用稳定版本。

## Welcome to null safety

## 欢迎使用空安全

If you made it this far,
you should have a fully migrated, null-safe Dart package.
If all of the packages you depend on are migrated too,
then your program is sound with respect to null-reference errors.

如果您走到了这一步，您应该已经完全将您的 Dart 软件包迁移至空安全了。
当您的所有依赖也都完成了迁移，那么您的程序就是健全的，同时可以正确处理空引用的错误。

From all of the Dart team, *thank you* for migrating your code.

谨代表 Dart 团队的所有成员，**感谢您** 迁移您的代码。
