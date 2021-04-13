---
title: "Null safety: frequently asked questions"
title: "空安全：常见问题"
description: FAQs to help you migrate your Dart code to null safety
description: 帮助您迁移到空安全的常见问题解答
short-title: FAQ (null safety)
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

但是有两项例外您需要注意：

-   The `!` operator is a runtime null check in all modes, for all users. So,
    when migrating, ensure that you only add `!` where it's an error for a
    `null` to flow to that location, even if the calling code has not migrated
    yet.

    对于任何模式而言，`!` 操作符都是在运行时进行的空检查。
    所以在进行迁移时，请确保您仅对 `null` 可能由混合模式造成污染的代码位置添加 `!`，
    就算发起调用的代码还未迁移至空安全，也应如此。

-   Runtime checks associated with the `late` keyword apply in all modes, for
    all users. Only mark a field `late` if you are sure it is always initialized
    before it is used.

    `late` 会在运行时检查。所以请您仅在确定它被使用前一定会被初始化的情况下使用 `late`。

## What if a value is only `null` in tests?

## 如果在测试中的值始终为 `null` 应该怎样处理？

If a value is only ever `null` in tests, the code can be improved by marking it
non-nullable and making the tests pass non-null values.

如果在测试中某个值始终为 `null`，可以通过将测试传值和测试需要的值改为非空，来改进您的测试。

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

当您在空安全的代码中使用空安全代码时，如果 `required` 修饰的参数未传递，
会显示一个错误。

What does this mean for migration? Be careful if adding `required` where there
was no `@required` before. Any callers not passing the newly-required argument
will no longer compile. Instead, you could add a default or make the argument
type nullable.

那么它对于迁移来说意味着什么呢？
当您给以前没有使用 `@required` 注解的参数加上 `required` 时要十分小心。
任何没有传递新需要的参数的代码，都无法进行编译。
实际上，您可以加上默认值，或是将参数变为可空类型。

## How should I migrate non-nullable fields that should be `final`, but aren't?

## 我应该如何迁移应该为 `final` 而目前并不是的字段？

Some computations can be moved to the static initializer. Instead of:

一些赋值计算可以移动到静态的初始化中。
与其使用下面的方式：

{:.bad}
{% prettify dart tag=pre+code %}
// Initalized without values
ListQueue _context;
Float32List _buffer;
dynamic _readObject;

Vec2D(Map<String, dynamic> object) {
  _buffer = Float32List.fromList([0.0, 0.0]);
  _readObject = object['container'];
  _context = ListQueue<dynamic>();
}
{% endprettify %}

you can do:

您可以这样做：

{:.good}
{% prettify dart tag=pre+code %}
// Initalized with values
final ListQueue _context = ListQueue<dynamic>();
final Float32List _buffer = Float32List.fromList([0.0, 0.0]);
final dynamic _readObject;

Vec2D(Map<String, dynamic> object) : _readObject = object['container'];
{% endprettify %}

However, if a field is initialized by doing computation in the constructor, then
it can't be `final`. With null safety, you'll find this also makes it harder for
it to be non-nullable; if it's initialized too late, then it's `null` until it's
initialized, and must be nullable. Fortunately, you have options:

然而，在构造函数中通过计算进行初始化的字段，是无法为 `final` 的。
在使用空安全的时候，您会发现想让它们的类型为非空，也不是一件容易的事。
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
    在空安全迁移介入 **之前**，您就可以这样进行调整。

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

{:.bad}
{% prettify dart tag=pre+code %}
  factory StreamReader(dynamic data) {
    StreamReader reader;
    if (data is ByteData) {
      reader = BlockReader(data);
    } else if (data is Map) {
      reader = JSONBlockReader(data);
    }
    return reader;
  }
{% endprettify %}

Do:

不如这样：

{:.good}
{% prettify dart tag=pre+code %}
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
{% endprettify %}


If the intent of the factory was indeed to return null, then you can turn it
into a static method so it is allowed to return `null`.

如果一个工厂方法的初衷就是可能返回空值，将其转为可返回 `null` 的静态方法是更好的选择。

## How should I migrate an `assert(x != null)` that now shows as unnecessary?

## 我应该如何迁移现在提示无用的 `assert(x != null)`？

The assert will be unnecessary when everything is fully migrated, but for now it
*is* needed if you actually want to keep the check. Options:

对于完全迁移的代码而言，这个断言是不必要的，但是如果您希望保留该检查，那么它 **也需要** 留下。
几种方式可供您选择：

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

An explicit runtime null check, for example `if (arg == null) throw
ArgumentError(...)`, will be flagged as an unnecessary comparison if you make
`arg` non-nullable.

类似 `if (arg == null) throw ArgumentError(...)` 这样的显式空判断，
会在 `arg` 为非空时标记为不必要。

But, the check *is* still needed if the program is a mixed-version one.  Until
everything is fully migrated and the code switches to running with sound null
safety, it will be possible for `arg` to be null.

但是在混合模式下的程序 **仍然需要** 这样的判断。
在所有代码都迁移且运行在完全的空安全模式下前，`arg` 仍然可能为空。

The simplest way to preserve behavior is change the check into
[`ArgumentError.checkNotNull`](https://api.dart.dev/stable/dart-core/ArgumentError/checkNotNull.html).

保留这项行为的最简单的方法是将判断改为
[`ArgumentError.checkNotNull`](https://api.dart.cn/stable/dart-core/ArgumentError/checkNotNull.html)。

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

导入 `package:collection` 包并使用 `firstWhereOrNull` 扩展方法代替 `firstWhere`。

## How do I deal with attributes that have setters?

## 我应该如何处理有 setters 的属性？

Unlike the `late final` suggestion above, these attributes cannot be marked as
final. Often, settable attributes also do not have initial values since they are
expected to be set sometime later.

与上文说到的 `late final` 的建议不同的是，这些字段不能被标记为终值。
通常，可被修改的属性也没有初始值，因为它们可能会在稍后才被赋值。

In such cases, you have two options:

在这样的情况下，您有两种选择：

-   Set it to an initial value. Often times, the omission of an initial value is
    by mistake rather than deliberate.

    为其设置初始值。通常情况下，初始值未被设置是无意的错误，而不是有意为之。

-   If you are _sure_ that the attribute needs to be set before accessed, mark
    it as `late`.

    如果您 **确定** 这个属性需要在访问之前被赋值，将它标记为 `late`。

    WARNING: The `late` keyword adds a runtime check. If any user calls `get`
    before `set` they'll get an error at runtime.

    **注意**：`late` 关键词会在运行时添加检查。
    如果在 `set` 之前调用了 `get`，会在运行时抛出异常。

## How do I signal that the return value from a Map is non-nullable?

## 我需要怎样标记映射的返回值为非空类型？

The
[lookup operator](https://api.dart.dev/stable/dart-core/Map/operator_get.html)
on Map (`[]`) by default returns a nullable type. There's no way to signal to
the language that the value is guaranteed to be there.

映射类型的
[查询操作符](https://api.dart.cn/stable/dart-core/Map/operator_get.html)
(`[]`) 返回的值默认是可空类型。
此处没有办法告诉 Dart ，返回的值一定是非空的。

In this case, you should use the bang operator (`!`) to cast the value back to
V:

在这种情况下，您应该使用强制非空操作符 (`!`) 将可空的类型转为非空 (V)。

```dart
return blockTypes[key]!;
```

Which will throw if the map returns null. If you want explicit handling for that case:

如果 map 返回了 null，则会抛出异常。如果您希望手动处理这些情况：

```dart
var result = blockTypes[key];
if (result != null) return result;
// Handle the null case here, e.g. throw with explanation.
```

## Why is the generic type on my List/Map nullable?

## 为什么我的 List/Map 中的泛型是可空的？

It is typically a code smell to end up with nullable code like this:

下面这样以可空内容结尾的代码是一种典型的代码异味：

{:.bad}
{% prettify dart tag=pre+code %}
List?<Foo?> fooList; // fooList can contain null values
{% endprettify %}

This implies `fooList` might contain null values. This might happen if you are
initializing the list with length and filling it in via a loop.

它隐含了 `fooList` 可能包含空值的信息。
在您以长度初始化列表并循环填入值时，这种情况可能会出现。

If you are simply initializing the list with the same value, you should instead
use the [`filled`](https://api.dart.dev/stable/dart-core/List/List.filled.html) constructor.

如果您仅仅想要以相同的值初始化列表，您应该使用
[`filled`](https://api.dart.cn/stable/dart-core/List/List.filled.html)
构造。

{:.bad}
{% prettify dart tag=pre+code %}
_jellyPoints = List<Vec2D>(jellyMax + 1);
for (var i = 0; i <= jellyMax; i++) {
  _jellyPoints[i] = Vec2D(); // List initalized with the same value
}
{% endprettify %}

{:.good}
{% prettify dart tag=pre+code %}
_jellyPoints = List<Vec2D>.filled(jellyMax + 1, Vec2D()); // List initialized with filled constructor
{% endprettify %}

If you are setting the elements of the list via an index, you should instead use
the `add` function to build the list. That is less error-prone and more
readable.

如果您需要通过索引来设置元素，您应该使用 `add` 函数来构建列表。
这个方法不会轻易出错，且可读性更好。

## What happened to the default List constructor?

## 默认的 List 构造有什么改动？

You may encounter this error:

您可能会遇到这样的错误：

```none
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
就算您未在迁移过程中手动更改类型，类型也可能会被改变，
因为启用空安全后，类型推导推算出了这样的结果。

The fix is to explicitly create such lists as `List<dynamic>`.

手动创建 `List<dynamic>` 类型的列表可以解决这个问题。

## Why does the migration tool add comments to my code? {#migration-comments}

## 为什么迁移工具在我的代码中添加了注释 {#migration-comments}

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
那么该工具会告诉您「这看起来永远为 false！」并让您进行决定。

## Resources

## 资源

*   [DartPad with Null Safety](https://nullsafety.dartpad.dev)
*   [Sound null safety](/null-safety)
