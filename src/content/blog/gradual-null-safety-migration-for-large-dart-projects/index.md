---
# title: "Gradual null safety migration for large Dart projects"
title: "大型 Dart 项目的渐进式空安全迁移"
# description: "Dart null-safety migration is a 1-2 hour effort for a simple, small package but can be a months-long marathon for a large project. Ideally…"
description: "对简单的小型 package，Dart 空安全迁移只需 1-2 小时；对大型项目，则可能是一场长达数月的马拉松。理想情况下……"
ai-translated: true
publishDate: 2022-03-31
author: polina-c
image: images/16-SfhIoFLl1NPaNi8Ld8Og.webp
category: other
layout: blog
---


<DashImage src="images/16-SfhIoFLl1NPaNi8Ld8Og.webp" alt="Dart logo stamped with the words 'Null Safe'." />


[Dart null-safety migration](https://dart.dev/null-safety/migration-guide) is a 1-2 hour effort for a simple, small package but can be a months-long marathon for a large project. Ideally, you want to migrate your project gradually — during the marathon you want to keep your project growable, maintainable, and easy to release.

[Dart 空安全迁移](https://dart.dev/null-safety/migration-guide)
对简单的小型 package 来说是 1-2 小时的工作，
对大型项目却可能是一场长达数月的马拉松。理想情况下，
你希望渐进地迁移项目——在这场马拉松中，
你要让项目保持可扩展、可维护、易于发布。

I’ve migrated a large project to null safety and decided to put together steps and tips on how to make the process reliable and efficient, with the hope that it saves you time.

我曾把一个大型项目迁移到空安全（null safety），
决定把让这一过程可靠又高效的步骤和技巧整理出来，
希望能帮你节省时间。

## Step 1: Convert to unsound null-safety

## 第 1 步：转换到不健全空安全

First, migrate your project to [*unsound* null safety](https://dart.dev/null-safety/unsound-null-safety).

首先，把项目迁移到
[*不健全*空安全（unsound null safety）](https://dart.dev/null-safety/unsound-null-safety)。

Start with upgrading your dependencies to null-safe versions. Unsound null safety doesn’t require having all dependencies to be null-safe. However, waiting until all of your upstream dependencies are migrated is strongly recommended since migrating a dependency might force you to revisit migration decisions in your own code. For packages that are mutually dependent, you might be forced to migrate out of order, or to migrate the packages concurrently (many packages that are mutually dependent mostly refer to each other only in tests). Follow [the guidance on dart.dev](https://dart.dev/null-safety/migration-guide#update-dependencies) to upgrade as many dependencies as you can before migrating your code.

先把依赖升级到空安全版本。不健全空安全并不要求所有依赖都空安全。
不过，强烈建议等到所有上游依赖都完成迁移，
因为某个依赖的迁移可能迫使你重新审视自己代码中的迁移决策。
对于相互依赖的 package，你可能被迫打乱顺序迁移，
或同时迁移这些 package（许多相互依赖的 package
大多只在测试中相互引用）。请遵循
[dart.dev 上的指南](https://dart.dev/null-safety/migration-guide#update-dependencies)，
在迁移自己的代码之前尽可能多地升级依赖。

Next, update the Dart SDK for your package and mark each non-migrated library as legacy using the following steps:

接下来，更新 package 的 Dart SDK，
并按以下步骤把每个未迁移的库标记为遗留（legacy）库：

1. Make sure that your IDE (VSCode, IntelliJ / Android Studio) has the Dart plugin installed.

    确保你的 IDE（VSCode、IntelliJ / Android Studio）已安装 Dart 插件。

1. Open your package in the IDE and make sure there are no compilation errors.

    在 IDE 中打开你的 package，确保没有编译错误。

1. Update the `dart_sdk` dependency in the `pubspec.yaml` file to require the version range: `‘>=2.12.0 <3.0.0’`.

    更新 `pubspec.yaml` 文件中的 `dart_sdk` 依赖，
    把版本范围要求为 `>=2.12.0 <3.0.0`。

1. The IDE will highlight null-safe related errors in libraries that are not yet null safe. Remove the errors by adding the comment `‘// @dart=2.9’` on the top of each affected file. Add the comment to your main.dart file even if it does not have errors, to keep the app running in unsound mode until you are ready to switch.

    IDE 会在尚未空安全的库中高亮与空安全相关的错误。
    在每个受影响文件的顶部添加注释 `// @dart=2.9` 来消除这些错误。
    即使 main.dart 文件没有错误，也要给它加上这条注释，
    让应用在你准备好切换之前一直以不健全模式运行。

1. Verify that all tests pass, and submit the changes to your main branch. If your tests are already null-safe, you will need the command line flag `--no-sound-null-safety` to suppress null-safe errors.

    验证所有测试通过，并把改动提交到主分支。
    如果测试已经是空安全的，你需要命令行标志
    `--no-sound-null-safety` 来抑制空安全错误。

Make sure that you see `Running with unsound null-safety` in the console when starting the application.

启动应用时，请确保在控制台看到 `Running with unsound null-safety`。

Now you are ready to migrate your project to sound null safety one library at a time.

现在你可以逐个库地把项目迁移到健全空安全了。

## Step 2: Iterate towards sound null-safety

## 第 2 步：迭代迈向健全空安全

Choose a library or a set of libraries to migrate.

选择一个或一组要迁移的库。
> **Pro tip**: If the library you selected is large, you might want to break it into smaller libraries before migrating.

> **专业提示**：如果所选的库很大，
> 你可能想在迁移前先把它拆成更小的库。

Use `dart pub deps` to create a dependency graph of your project. It’s best to migrate packages from the bottom up; start with the leaves in the dependency tree and then iterate up to the root. However, if your project has dependency cycles, this might not be possible and it’s ok not to follow this order.

使用 `dart pub deps` 生成项目的依赖图。最好自底向上迁移 package：
从依赖树的叶子开始，然后逐步向上到根。不过，如果项目存在循环依赖，
这可能做不到，不遵循这一顺序也没关系。

Migrate the library (or set of libraries) by [using the migration tool](https://dart.dev/null-safety/migration-guide):

通过[使用迁移工具](https://dart.dev/null-safety/migration-guide)
迁移该库（或该组库）：

1. Start the interactive migration tool by running `dart migrate --skip-import-check`. You may want to `cd` to the directory with the selected libraries to ease navigation in the tree.

    运行 `dart migrate --skip-import-check` 启动交互式迁移工具。
    你可能想先 `cd` 到所选库所在的目录，以便在树中导航。

1. Deselect everything by deselecting the roots of the file view tree in the left panel. (If interested, vote for a [**Deselect All** button](https://github.com/dart-lang/sdk/issues/48314).)

    在左侧面板取消勾选文件视图树的根节点，从而取消选择所有文件。
    （如果你也想要这个功能，请为
    [**Deselect All** 按钮](https://github.com/dart-lang/sdk/issues/48314)投票。）

1. Use `Control+F` to find the file(s) that you want to migrate.

    使用 `Control+F` 查找你想迁移的文件。

1. Select the file(s) and click **Apply Migration**. There are two options how you can make adjustments: (1) use comments to adjust the tools’s choices before applying migration or (2) use an IDE to evaluate the nullability of fields, parameters, and variables after applying migration.

    选中文件并点击 **Apply Migration**。有两种调整方式：
    （1）在应用迁移前用注释调整工具的选择；
    （2）在应用迁移后用 IDE 评估字段、参数和变量的可空性。

1. Open the package in the IDE. Fix errors, and search the files for cases where the tool might be inaccurate (see a list of potential issues below). Make corrections and use lint warnings to interactively clean up upstream and downstream code.

    在 IDE 中打开 package。修复错误，并在文件中搜索工具可能
    不准确的情况（见下方潜在问题列表）。做出修正，
    并利用 lint 警告交互式地清理上下游代码。

You will not be able to fix two lint errors:

有两个 lint 错误你无法修复：

1. `import_of_legacy_library_into_null_safe` (in migrated libraries)

    `import_of_legacy_library_into_null_safe`（在已迁移的库中）

1. `avoid_redundant_argument_values` (in legacy libraries)

    `avoid_redundant_argument_values`（在遗留库中）

For now, disable these errors with comments. You’ll clean these up later, after migration is done.

暂时用注释禁用这些错误。迁移完成后再清理它们。

What potential tool inaccuracies to watch for:

需要留意哪些潜在的工具不准确之处：

1. Added types `dynamic` or `num`. Most likely you know which specific type should be used instead.

    添加了 `dynamic` 或 `num` 类型。你多半知道应该改用哪个具体类型。

1. In most cases, `bool?` can become `bool` with a default value.

    大多数情况下，`bool?` 可以改成带默认值的 `bool`。

1. Type casts (search for `‘ as ‘`) might mean that the tool didn’t add a generic type parameter. After adding it, a lint indicates that the cast has become unnecessary and can be removed.

    类型转换（搜索 ` as `）可能意味着工具没有添加泛型类型参数。
    添加之后，lint 会提示该转换已不必要，可以移除。

1. In some cases, the tool makes the bound on a generic parameter nullable when it might be better to make it non-nullable (search for `?>` and `?,`).

    某些情况下，工具把泛型参数的上界设为可空，
    而设为非空可能更好（搜索 `?>` 和 `?,`）。

1. The tool might make things nullable that could be better expressed using `late` or `late final`, or that could be refactored to allow initialization in the constructor’s initializer list. (If interested, vote for a [lint](https://github.com/dart-lang/linter/issues/3267).)

    工具可能把一些东西设为可空，而用 `late` 或 `late final`
    表达会更好，或者可以重构为在构造函数的初始化列表中初始化。
    （如果你也想要，请为一条
    [lint](https://github.com/dart-lang/linter/issues/3267) 投票。）

1. Using a null-assert operation `!` without first checking for a null value might mean that the variable or parameter should actually be non-nullable. (If interested, vote for a [lint](https://github.com/dart-lang/linter/issues/3266).)

    未先检查 null 值就使用 null 断言操作 `!`，
    可能意味着该变量或参数其实应该是非空的。
    （如果你也想要，请为一条
    [lint](https://github.com/dart-lang/linter/issues/3266) 投票。）

1. The tool adds casting for collections in the form `collection as Iterable<TheType>`. Sometimes, this change just makes a cast explicit that was already implicit. However, in other cases, these casts might introduce [runtime errors](https://stackoverflow.com/questions/72252891) because of mismatches in the nullability of the generic arguments. If in doubt, consider replacing the cast with an explicit per element conversion (for example, `collection.cast<TheType>()`), or consider using [the `whereNotNull` extension method from `package:collection`](https://pub.dev/documentation/collection/latest/collection/IterableNullableExtension/whereNotNull.html).

    工具会以 `collection as Iterable<TheType>` 的形式为集合添加转换。
    有时这只是把原本隐式的转换显式化。但在其他情况下，
    由于泛型实参的可空性不匹配，这些转换可能引入
    [运行时错误](https://stackoverflow.com/questions/72252891)。
    如有疑问，考虑把转换替换为显式的逐元素转换
    （例如 `collection.cast<TheType>()`），或考虑使用
    [`package:collection` 的 `whereNotNull` 扩展方法](https://pub.dev/documentation/collection/latest/collection/IterableNullableExtension/whereNotNull.html)。

1. If a variable, field, or parameter is nullable, but the nullability is used only in the tests, perhaps the code should be refactored to remove nullability for that identifier.

    如果某个变量、字段或参数是可空的，但可空性只在测试中用到，
    也许应该重构代码，去掉该标识符的可空性。

(Thanks to [Kenzie Davisson](https://github.com/kenzieschmoll), who helped me identify these cases.)

（感谢 [Kenzie Davisson](https://github.com/kenzieschmoll)
帮我识别出这些情况。）

## Step 3: Cleanup

## 第 3 步：清理

After migrating all of your libraries, do some final cleanup:

迁移完所有库之后，做一些最终清理：

1. Clean up the disabling comments for the lints.

    清理用于禁用 lint 的注释。

1. Upgrade the remaining dependencies to null safe versions.

    把剩余依赖升级到空安全版本。

1. Ensure that there are no ``//@dart = 2.9`` comments remaining in your app. At this point, you should see `Running with sound null-safety` in the console when starting the app. If you don’t see this, you either have libraries that aren’t yet migrated (search for ``// @dart = 2.9``), or a dependency that has not been migrated.

    确保应用中没有残留的 ``//@dart = 2.9`` 注释。此时启动应用，
    你应该能在控制台看到 `Running with sound null-safety`。
    如果没有看到，要么还有库未迁移（搜索 ``// @dart = 2.9``），
    要么有依赖尚未迁移。

1. Ensure that the app still runs correctly and that the tests pass. Since sound mode enables stronger runtime guarantees, it’s possible (though unlikely) that you will see new runtime errors which you need to fix when you enable sound null safety. Usually this is the result of casting a nullable collection (like `List<int?>`) to a non-nullable collection type (like `List<int>`).

    确保应用仍能正确运行、测试通过。由于健全模式带来更强的运行时
    保证，启用健全空安全时有可能（虽然不太可能）看到需要修复的
    新运行时错误。这通常是把可空集合（如 `List<int?>`）
    转换为非空集合类型（如 `List<int>`）导致的。

Have a happy migration!

祝迁移愉快！
