---
# title: "Null safety: Frequently asked questions"
title: 空安全：常见问题
# description: FAQs to help you migrate your Dart code to null safety
description: 帮助你迁移到空安全的常见问题解答
# short-title: FAQ (null safety)
short-title: 空安全常见问题
---

This page collects some common questions we've heard about [null safety](/null-safety)
based on the experience of migrating Google internal code.

此处涵盖了一些我们在迁移 Google 内部代码至 [空安全](/null-safety) 时遇到的常见问题。

## What runtime changes should I be aware of for users of migrated code?

## 在迁移代码时，我应该注意哪些运行时的改动？

Most of the effects of migration do not immediately affect users of migrated
code:

在空安全迁移中的大部分影响，不会立刻出现在刚刚迁移完成的开发者身上：

-   Static null safety checks for users first apply when they migrate their
    code.

    静态的空安全检查，会在开发者完成迁移后立刻生效。

-   Full null safety checks happen when all the code is migrated and sound mode
    is turned on.

    完整的空安全检查，只会在所有代码都已迁移，并且启用了完整的空安全模式时生效。

Two exceptions to be aware of are:

但是有两项例外你需要注意：

-   The `!` operator is a runtime null check in all modes, for all users. So,
    when migrating, ensure that you only add `!` where it's an error for a
    `null` to flow to that location, even if the calling code has not migrated
    yet.

    对于任何模式而言，`!` 操作符都是在运行时进行的空检查。
    所以在进行迁移时，请确保你仅对 `null` 可能由混合模式造成污染的代码位置添加 `!`，
    就算发起调用的代码还未迁移至空安全，也应如此。

-   Runtime checks associated with the `late` keyword apply in all modes, for
    all users. Only mark a field `late` if you are sure it is always initialized
    before it is used.

    `late` 会在运行时检查。所以请你仅在确定它被使用前一定会被初始化的情况下使用 `late`。

## What if a value is only `null` in tests?

## 如果在测试中的值始终为 `null` 应该怎样处理？

If a value is only ever `null` in tests, the code can be improved by marking it
non-nullable and making the tests pass non-null values.

如果在测试中某个值始终为 `null`，可以通过将测试传值和测试需要的值改为非空，来改进你的测试。

## How does `@required` compare to the new `required` keyword?

## 新的 `required` 和 `@required` 关键词有何异同？

The `@required` annotation marks named arguments that must be passed; if not,
the analyzer reports a hint.

`@required` 注解会将参数标记为必须传递。如果未传，分析器会给出一个提示。

With null safety, a named argument with a non-nullable type must either have a
default or be marked with the new `required` keyword. Otherwise, it wouldn't
make sense for it to be non-nullable, because it would default to `null` when
not passed.

有了空安全，非空类型的命名参数要么需要默认值，要么需要使用 `required` 关键字修饰。
否则，它在未传递时默认会是 `null`，就显得不合理了。

When null safe code is called from legacy code the `required` keyword is treated
exactly like the `@required` annotation: failure to supply the argument will
cause an analyzer hint.

在旧的代码中，`required` 关键词会被看作 `@required` 注解，
即参数未传递时会显示一个分析器提示。

When null safe code is called from null safe code, failing to supply a
`required` argument is an error.

当你在空安全的代码中使用空安全代码时，如果 `required` 修饰的参数未传递，
会显示一个错误。

What does this mean for migration? Be careful if adding `required` where there
was no `@required` before. Any callers not passing the newly-required argument
will no longer compile. Instead, you could add a default or make the argument
type nullable.

那么它对于迁移来说意味着什么呢？
当你给以前没有使用 `@required` 注解的参数加上 `required` 时要十分小心。
任何没有传递新需要的参数的代码，都无法进行编译。
实际上，你可以加上默认值，或是将参数变为可空类型。

## How should I migrate non-nullable fields that should be `final`, but aren't?

## 我应该如何迁移应该为 `final` 而目前并不是的字段？

Some computations can be moved to the static initializer. Instead of:

一些赋值计算可以移动到静态的初始化中。
与其使用下面的方式：

```dart tag=bad
// Initialized without values
ListQueue _context;
Float32List _buffer;
dynamic _readObject;

Vec2D(Map<String, dynamic> object) {
  _buffer = Float32List.fromList([0.0, 0.0]);
  _readObject = object['container'];
  _context = ListQueue<dynamic>();
}
```

you can do:

你可以这样做：

```dart tag=good
// Initialized with values
final ListQueue _context = ListQueue<dynamic>();
final Float32List _buffer = Float32List.fromList([0.0, 0.0]);
final dynamic _readObject;

Vec2D(Map<String, dynamic> object) : _readObject = object['container'];
```

However, if a field is initialized by doing computation in the constructor, then
it can't be `final`. With null safety, you'll find this also makes it harder for
it to be non-nullable; if it's initialized too late, then it's `null` until it's
initialized, and must be nullable. Fortunately, you have options:

然而，在构造函数中通过计算进行初始化的字段，是无法为 `final` 的。
在使用空安全的时候，你会发现想让它们的类型为非空，也不是一件容易的事。
如果初始化的时机不合适，那么直到初始化前，它都只能是可空的类型。
幸运的是，你还有其他选择：

-   Turn the constructor into a factory, then make it delegate to an actual
    constructor that initializes all the fields directly. A common name for such
    a private constructor is just an underscore: `_`. Then, the field can be
    `final` and non-nullable. This refactoring can be done *before* the
    migration to null safety.

    将构造转变为工厂方法，并将其委托给一个直接初始化所有字段的真正的构造函数。
    在 Dart 中，这样的私有构造通常是一个下划线：`_`。
    如此一来，字段就可以是 `final` 且非空了。
    在空安全迁移介入 **之前**，你就可以这样进行调整。

-   Or, mark the field `late final`. This enforces that it's initialized exactly
    once. It must be initialized before it can be read.

    或者，将字段标记为 `late final`。这会使得字段只被初始化一次。
    在它被读取之前必须被初始化。

## How should I migrate a `built_value` class?

## 我应该如何迁移 `built_value` 类？

Getters that were annotated `@nullable` should instead have nullable types; then
remove all `@nullable` annotations. For example:

使用了 `@nullable` 注解的 getter 应当直接转变为可空的类型，
然后移除所有的 `@nullable` 注解。例如：

```dart
@nullable
int get count;
```

becomes

变成

```dart
int? get count; //  Variable initialized with ?
```

Getters that were *not* marked `@nullable` should *not* have nullable types,
even if the migration tool suggests them. Add `!` hints as needed then rerun the
analysis.

就算迁移工具建议，**没有** 使用 `@nullable` 注解的 getter 也不应该是可空的类型。
这时可以根据需要添加 `!` 操作符，并且重新进行分析。

## How should I migrate a factory that can return `null`?

## 我应该如何迁移可能返回 `null` 的工厂方法？

_Prefer factories that do not return null._ We have seen code that meant to
throw an exception due to invalid input but instead ended up returning null.

**优先使用不返回 null 的工厂方法**。
我们看到了很多代码，本意是想在调用不正确时抛出一个异常，但最终却返回了空。

Instead of:

与其这样写：

```dart tag=bad
  factory StreamReader(dynamic data) {
    StreamReader reader;
    if (data is ByteData) {
      reader = BlockReader(data);
    } else if (data is Map) {
      reader = JSONBlockReader(data);
    }
    return reader;
  }
```

Do:

不如这样：

```dart tag=good
  factory StreamReader(dynamic data) {
    if (data is ByteData) {
      // Move the readIndex forward for the binary reader.
      return BlockReader(data);
    } else if (data is Map) {
      return JSONBlockReader(data);
    } else {
      throw ArgumentError('Unexpected type for data');
    }
  }
```


If the intent of the factory was indeed to return null, then you can turn it
into a static method so it is allowed to return `null`.

如果一个工厂方法的初衷就是可能返回空值，将其转为可返回 `null` 的静态方法是更好的选择。

## How should I migrate an `assert(x != null)` that now shows as unnecessary?

## 我应该如何迁移现在提示无用的 `assert(x != null)`？

The assert will be unnecessary when everything is fully migrated, but for now it
*is* needed if you actually want to keep the check. Options:

对于完全迁移的代码而言，这个断言是不必要的，但是如果你希望保留该检查，那么它 **也需要** 留下。
几种方式可供你选择：

-   Decide that the assert is not really necessary, and remove it. This is a
    change in behavior when asserts are enabled.

    确定是否真的需要这个断言，然后将其删除。
    当断言启用时，这是一种行为上的变更。

-   Decide that the assert can be checked always, and turn it into
    `ArgumentError.checkNotNull`. This is a change in behavior when asserts are
    not enabled.

    确定断言始终会被检查，接着将其转换为 `ArgumentError.checkNotNull`。
    当断言未启用时，这是一种行为上的变更。

-   Keep the behavior exactly as is: add `// ignore:
    unnecessary_null_comparison` to bypass the warning.

    通过添加 `//ignore: unnecessary_null_comparison` 来绕过警告并且保持原有的行为。

## How should I migrate a runtime null check that now shows as unnecessary?

## 我应该如何迁移现在提示不必要的运行时空判断？

The compiler flags an explicit runtime null check as an unnecessary
comparison if you make `arg` non-nullable.

如果 `arg` 为非空时，编译器会在运行时将显式空安全判断标记为非必要。

```dart
if (arg == null) throw ArgumentError(...)`
```

You must include this check if the program is a mixed-version one.
Until everything is fully migrated and the code switches to running
with sound null safety, `arg` might be set to `null`.

混合模式下的程序必须包含这样的判断。
在所有代码都迁移且运行在完全的空安全模式下前，
`arg` 仍然可能为 `null`。

The simplest way to preserve behavior is change the check into
[`ArgumentError.checkNotNull`]({{site.dart-api}}/{{site.sdkInfo.channel}}/dart-core/ArgumentError/checkNotNull.html).

保留这项行为的最简单的方法是将判断改为
[`ArgumentError.checkNotNull`]({{site.dart-api}}/stable/dart-core/ArgumentError/checkNotNull.html)。

The same applies to some runtime type checks. If `arg`
has static type `String`, then `if (arg is! String)` is actually checking
whether `arg` is `null`. It might look like migrating to null safety means `arg`
can never be `null`, but it could be `null` in unsound null safety. So, to preserve
behavior, the null check should remain.

运行时的检查同样适用。如果 `arg` 指定了静态类型为 `String`，
那么 `if (arg is! String)` 实际上是在检查 `arg` 是否为 `null`。
尽管代码在迁移到空安全后，`arg` 应该是永远不为 `null` 的，
但是在不完全的空安全中它仍有可能为 `null` 的。

## The `Iterable.firstWhere` method no longer accepts `orElse: () => null`.

## `Iterable.firstWhere` 方法不再接受 `orElse: () => null`。

Import `package:collection` and use the extension method `firstWhereOrNull`
instead of `firstWhere`.

导入 `package:collection` package 并使用 `firstWhereOrNull` 扩展方法代替 `firstWhere`。

## How do I deal with attributes that have setters?

## 我应该如何处理有 setters 的属性？

Unlike the `late final` suggestion above, these attributes cannot be marked as
final. Often, settable attributes also do not have initial values since they are
expected to be set sometime later.

与上文说到的 `late final` 的建议不同的是，这些字段不能被标记为终值。
通常，可被修改的属性也没有初始值，因为它们可能会在稍后才被赋值。

In such cases, you have two options:

在这样的情况下，你有两种选择：

-   Set it to an initial value. Often times, the omission of an initial value is
    by mistake rather than deliberate.

    为其设置初始值。通常情况下，初始值未被设置是无意的错误，而不是有意为之。

-   If you are _sure_ that the attribute needs to be set before accessed, mark
    it as `late`.

    如果你 **确定** 这个属性需要在访问之前被赋值，将它标记为 `late`。

    WARNING: The `late` keyword adds a runtime check. If any user calls `get`
    before `set` they'll get an error at runtime.

    **注意**：`late` 关键词会在运行时添加检查。
    如果在 `set` 之前调用了 `get`，会在运行时抛出异常。

## How do I signal that the return value from a Map is non-nullable?

## 我需要怎样标记映射的返回值为非空类型？

The
[lookup operator]({{site.dart-api}}/{{site.sdkInfo.channel}}/dart-core/Map/operator_get.html)
on Map (`[]`) by default returns a nullable type. There's no way to signal to
the language that the value is guaranteed to be there.

映射类型的
[查询操作符]({{site.dart-api}}/stable/dart-core/Map/operator_get.html)
(`[]`) 返回的值默认是可空类型。
此处没有办法告诉 Dart ，返回的值一定是非空的。

In this case, you should use the bang operator (`!`) to cast the value back to
V:

在这种情况下，你应该使用强制非空操作符 (`!`) 将可空的类型转为非空 (V)。

```dart
return blockTypes[key]!;
```

Which will throw if the map returns null. If you want explicit handling for that case:

如果 map 返回了 null，则会抛出异常。如果你希望手动处理这些情况：

```dart
var result = blockTypes[key];
if (result != null) return result;
// Handle the null case here, e.g. throw with explanation.
```

## Why is the generic type on my List/Map nullable?

## 为什么我的 List/Map 中的泛型是可空的？

It is typically a code smell to end up with nullable code like this:

下面这样以可空内容结尾的代码是一种典型的代码异味：

```dart tag=bad
List<Foo?> fooList; // fooList can contain null values
```

This implies `fooList` might contain null values. This might happen if you are
initializing the list with length and filling it in via a loop.

它隐含了 `fooList` 可能包含空值的信息。
在你以长度初始化列表并循环填入值时，这种情况可能会出现。

If you are simply initializing the list with the same value, you should instead
use the 
[`filled`]({{site.dart-api}}/{{site.sdkInfo.channel}}/dart-core/List/List.filled.html) 
constructor.

如果你仅仅想要以相同的值初始化列表，你应该使用
[`filled`]({{site.dart-api}}/stable/dart-core/List/List.filled.html)
构造。

```dart tag=bad
_jellyCounts = List<int?>(jellyMax + 1);
for (var i = 0; i <= jellyMax; i++) {
  _jellyCounts[i] = 0; // List initialized with the same value
}
```

```dart tag=good
_jellyCounts = List<int>.filled(jellyMax + 1, 0); // List initialized with filled constructor
```

If you are setting the elements of the list via an index, or you are populating
each element of the list with a distinct value, you should instead use the
list literal syntax to build the list.

如果你需要通过索引来设置元素，或者使用不同的值填充每个元素，
则应该使用列表的字面量表达式来构建列表。

```dart tag=bad
_jellyPoints = List<Vec2D?>(jellyMax + 1);
for (var i = 0; i <= jellyMax; i++) {
  _jellyPoints[i] = Vec2D(); // Each list element is a distinct Vec2D
}
```

```dart tag=good
_jellyPoints = [
  for (var i = 0; i <= jellyMax; i++)
    Vec2D() // Each list element is a distinct Vec2D
];
```

To generate a fixed-length list,
use the [`List.generate`][] constructor
with the `growable` parameter set to `false`:

你可以使用 [`List.generate`][] 构造加
`growable` 参数设置为 `false` 来生成固定长度的列表：

```dart
_jellyPoints = List.generate(jellyMax, (_) => Vec2D(), growable: false);
```

[`List.generate`]: {{site.dart-api}}/{{site.sdkInfo.channel}}/dart-core/List/List.generate.html

{% comment %}
  Would preferably suggest a language syntax here,
  which is being suggested in {{site.repo.dart.lang}}/issues/2477.
{% endcomment %}
 
## What happened to the default List constructor?

## 默认的 List 构造有什么改动？

You may encounter this error:

你可能会遇到这样的错误：

```plaintext
The default 'List' constructor isn't available when null safety is enabled. #default_list_constructor
```

The default list constructor fills the list with `null`, which is a problem.

默认的列表构造会将列表用 `null` 填充，会造成问题。

Change it to `List.filled(length, default)` instead.

将它变为 `List.filled(length, default)` 即可。

## I'm using `package:ffi` and get a failure with `Dart_CObject_kUnsupported` when I migrate. What happened?

## 我在迁移使用了 `package:ffi` 的代码的时候遇到了 `Dart_CObject_kUnsupported` 的错误。发生了什么？

Lists sent via ffi can only be `List<dynamic>`, not `List<Object>` or
`List<Object?>`. If you didn't change a list type explicitly in your migration,
a type might still have changed because of changes to type inference that happen
when you enable null safety.

通过 ffi 发送的列表只能是 `List<dynamic>`，
而不能是 `List<Object>` 或 `List<Object?>`。
就算你未在迁移过程中手动更改类型，类型也可能会被改变，
因为启用空安全后，类型推导推算出了这样的结果。

The fix is to explicitly create such lists as `List<dynamic>`.

手动创建 `List<dynamic>` 类型的列表可以解决这个问题。

## Why does the migration tool add comments to my code? {:#migration-comments}

## 为什么迁移工具在我的代码中添加了注释 {:#为什么迁移工具在我的代码中添加了注释}

The migration tool adds `/* == false */` or `/* == true */` comments when it
sees conditions that will always be false or true while running in sound mode.
Comments like these might indicate that the automatic migration is incorrect and
needs human intervention. For example:

空安全模式下，在当某个表达式的结果一定为 false 或 true 的时候，
迁移工具会自动添加 `/* == false */` 或者 `/* == true */` 这样的注释。
这样的注释将会导致自动迁移出现错误，并且需要人工干预。例如：

```dart
if (registry.viewFactory(viewDescriptor.id) == null /* == false */)
```

In these cases, the migration tool can't distinguish defensive-coding situations
and situations where a null value is really expected. So the tool tells you what
it knows ("it looks like this condition will always be false!") and lets you
decide what to do.

在这些情况下，迁移工具无法区分防御性编码情况或是确实需要空值的情况。
那么该工具会告诉你「这看起来永远为 false！」并让你进行决定。

## What should I know about compiling to JavaScript and null safety?

## 关于编译为 JavaScript 时的空安全我应该知道什么？

Null safety brings many benefits like reduced code size and improved
app performance. Such benefits surface more when compiled to native
targets like Flutter and AOT. Previous work on the production web
compiler had introduced optimizations similar to what null safety
later introduced. This may make resulting gains to production web apps
seem less than their native targets.

空安全带来了代码体积减小及性能提升等优化。
表面上 Flutter 编译为原生端的构建的优化会更加明显，例如 AOT。
我们先前已经在 Web 的生产构建器上已经引入了一些类似空安全的优化。
所以，Web 应用上的变化可能并不如原生端明显。

A few notes that are worth highlighting:

依然有几点值得注意：

* The production JavaScript compiler generates `!` null assertions. You might
  not notice them when comparing the output of the compiler before and
  after adding null assertions. That's because the compiler already
  generated null checks in programs that weren't null safe.

  生产环境下的 JavaScript 编译器会生成 `!` 空断言，
  在比较输出的时候你可能不会注意到它。
  这是因为编译器已支持了对空值进行检查。

* The compiler generates these null assertions regardless of the
  soundness of null safety or optimization level. In fact, the compiler
  doesn't remove `!` when using `-O3` or `--omit-implicit-checks`.

  无论是健全或非健全的安全，又或是不同的优化等级，编译器都会生成这些空断言，
  实际上在使用 `-O3` 或 `--omit-implicit-checks` 时编译器都不会移除 `!`。

* The production JavaScript compiler might remove unnecessary null checks.
  This happens because the optimizations that the production web
  compiler made prior to null safety removed those checks when it
  knew the value was not null.

  生产环境下的 JavaScript 编译器可能会移除没有必要的空检查，
  一般会发生在生产环境下的 Web 编译器在空安全之前做了一些优化，
  当它知道值不为空的时候，就删除了这些检查。

* By default, the compiler would generate parameter subtype checks.
  These runtime checks ensure covariant virtual calls have appropriate
  arguments. The compiler skips these checks with the
  `--omit-implicit-checks` option. Using this option can generate apps
  with unexpected behavior if the code includes invalid types.
  To avoid any surprises, continue provide strong test coverage for
  your code. In particular, the compiler optimizes code based
  on the fact that inputs should comply with the type declaration. If
  the code provides arguments of an invalid type, those optimizations
  would be wrong and the program could misbehave. This was true for
  inconsistent types before, and is true with inconsistent 
  nullabilities now with sound null-safety.

  默认情况下，编译器会生成参数子类型的检查。
  （用于确保协变的虚拟调用使用了合适的参数的运行时检查）。
  与先前相同，使用 `--omit-implicit-checks` 编译器会省略它们。
  回想一下，如果类型无效，这个开关会让程序出现异常，
  因此我们依然建议代码测试覆盖率尽可能地高，以避免任何事故。
  特别是编译器会基于传入值符合类型声明这一条件来优化代码。
  如果代码提供了无效类型的参数，优化将不是正确的，导致程序异常。
  这对于之前的类型不一致是正确的，对于现在健全的空安全的可空性不一致也是如此。

* You may notice that the development JavaScript compiler and the Dart 
  VM have special error messages for null checks, but to keep 
  applications small, the production JavaScript compiler does not.

  你可能会注意到开发版的 JavaScript 编译器和 Dart VM
  对于空检查的错误有比较特殊的错误提示，
  但是为了保持应用的轻量体积，
  生产环境下的编译器并没有这样的提示。

* You may see errors indicating that `.toString` is not found on `null`.
  This is not a bug. The compiler has always encoded some null checks
  in this way. That is, the compiler represents some null checks
  compactly by making an unguarded access of a property of the
  receiver. So instead of `if (a == null) throw`, it generates
  `a.toString`. The `toString` method is defined in JavaScript Object
  and is a fast way to verify that an object is not null.

  你可能会看到 `.toString` 在 `null` 上未找到的错误。
  这不是一个 bug，是编译器一直以来添加的空检查。
  编译器会通过对接收者对象属性的访问来压缩一些空检查。
  它生成的是 `a.toString` 而不是 `if (a == null) throw`。
  在 JavaScript 对象中定义的 `toString` 方法可以快速验证对象是否可空。

  If the very first action after a null check is an action that crashes
  when the value is null, the compiler can remove the null check and
  let the action cause the error.

  如果空检查后的第一个行为是当值为空时会崩溃，
  编译器可以删除空检查并让动作抛出错误。

  For example, a Dart expression `print(a!.foo());` could turn directly
  into:

  例如，`print(a!.foo());` 语句可以直接转换为：

  ```js
    P.print(a.foo$0());
  ```

  This is because the call `a.foo$()` will crash if `a` is null.
  If the compiler inlines `foo`, it will preserve the null check.
  So for example, if `foo` was `int foo() => 1;`  the compiler might 
  generate:

  这是因为调用 `a.foo$()` 会在 `a` 为空时崩溃。
  如果 dart2js 内联 `foo`，它将保留空检查。
  例如，如果 `foo` 是 `int foo() => 1;`，编译器可能会生成：

  ```js
    a.toString;
    P.print(1);
  ```

  If the inlined method first accessed a field on the receiver, like
  `int foo() => this.x + 1;`, then the production compiler can remove
  the redundant `a.toString` null check, as non-inlined calls, and
  generate:

  如果内联方法做的第一件事是对接收者的字段访问，例如 `int foo() => this.x + 1;`，
  那么 dart2js 可以再次删除多余的 `a.toString` 空检查，就像非内联调用一样生成：

  ```js
    P.print(a.x + 1);
  ```
    
## Resources

## 资源

*   [DartPad with Null Safety]({{site.dartpad}})

    [支持空安全的 DartPad]({{site.dartpad}})

*   [Sound null safety](/null-safety)

    [健全的空安全](/null-safety)
