---
title: "Effective Dart: Design"
title: 高效 Dart 语言指南：API 设计
description: Design consistent, usable libraries.
description: 库的 API 设计。
prevpage:
  url: /guides/language/effective-dart/usage
  title: Usage
  title: 用法示例
---
<?code-excerpt replace="/([A-Z]\w*)\d\b/$1/g"?>
<?code-excerpt plaster="none"?>

Here are some guidelines for writing consistent, usable APIs for libraries.

下面给出的准则用于指导为库编写一致的、可用的 API。

## Names

## 命名

Naming is an important part of writing readable, maintainable code.
The following best practices can help you achieve that goal.

命名是编写可读，可维护代码的重要部分。
以下最佳实践可帮助你实现这个目标。

### DO use terms consistently.

### **要** 使用一致的术语。

Use the same name for the same thing, throughout your code. If a precedent
already exists outside your API that users are likely to know, follow that
precedent.

在你的代码中，同样的东西要使用同样的名字。
如果之前已经存在的 API 之外命名，并且用户已经熟知，
那么请继续使用这个命名。

{:.good}
{% prettify dart tag=pre+code %}
pageCount         // A field.
updatePageCount() // Consistent with pageCount.
toSomething()     // Consistent with Iterable's toList().
asSomething()     // Consistent with List's asMap().
Point             // A familiar concept.
{% endprettify %}

{:.bad}
{% prettify dart tag=pre+code %}
renumberPages()      // Confusingly different from pageCount.
convertToSomething() // Inconsistent with toX() precedent.
wrappedAsSomething() // Inconsistent with asX() precedent.
Cartesian            // Unfamiliar to most users.
{% endprettify %}

The goal is to take advantage of what the user already knows. This includes
their knowledge of the problem domain itself, the conventions of the core
libraries, and other parts of your own API. By building on top of those, you
reduce the amount of new knowledge they have to acquire before they can be
productive.

总的目的是充分利用用户已经知道的内容。
这里包括他们所了解的问题领域，所熟悉的核心库，以及你自己 API 那部分。
基于以上这些内容，他们在使用之前，不需要学习大量的新知识。


### AVOID abbreviations.

### **避免** 缩写。

Unless the abbreviation is more common than the unabbreviated term, don't
abbreviate. If you do abbreviate, [capitalize it correctly][caps].

只使用广为人知的缩写，对于特有领域的缩写，请避免使用。
如果要使用，请 [正确的指定首字母大小写][caps]。

[caps]: /guides/language/effective-dart/style#identifiers

{:.good}
{% prettify dart tag=pre+code %}
pageCount
buildRectangles
IOStream
HttpRequest
{% endprettify %}

{:.bad}
{% prettify dart tag=pre+code %}
numPages    // "num" is an abbreviation of number(of)
buildRects
InputOutputStream
HypertextTransferProtocolRequest
{% endprettify %}


### PREFER putting the most descriptive noun last.

### **推荐** 把最具描述性的名词放到最后。

The last word should be the most descriptive of what the thing is. You can
prefix it with other words, such as adjectives, to further describe the thing.

最后一个词应该是最具描述性的东西。
你可以在其前面添加其他单词，例如形容词，以进一步描述该事物。

{:.good}
{% prettify dart tag=pre+code %}
pageCount             // A count (of pages).
ConversionSink        // A sink for doing conversions.
ChunkedConversionSink // A ConversionSink that's chunked.
CssFontFaceRule       // A rule for font faces in CSS.
{% endprettify %}

{:.bad}
{% prettify dart tag=pre+code %}
numPages                  // Not a collection of pages.
CanvasRenderingContext2D  // Not a "2D".
RuleFontFaceCss           // Not a CSS.
{% endprettify %}


### CONSIDER making the code read like a sentence.

### **考虑** 尽量让代码看起来像普通的句子。

When in doubt about naming, write some code that uses your API, and try to read
it like a sentence.

当你不知道如何命名 API 的时候，
使用你的 API 编写些代码，试着让代码看起来像普通的句子。

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (code-like-prose)"?>
{% prettify dart tag=pre+code %}
// "If errors is empty..."
if (errors.isEmpty) ...

// "Hey, subscription, cancel!"
subscription.cancel();

// "Get the monsters where the monster has claws."
monsters.where((monster) => monster.hasClaws);
{% endprettify %}

{:.bad}
<?code-excerpt "misc/lib/effective_dart/design_bad.dart (code-like-prose)" replace="/ as bool//g"?>
{% prettify dart tag=pre+code %}
// Telling errors to empty itself, or asking if it is?
if (errors.empty) ...

// Toggle what? To what?
subscription.toggle();

// Filter the monsters with claws *out* or include *only* those?
monsters.filter((monster) => monster.hasClaws);
{% endprettify %}

It's helpful to try out your API and see how it "reads" when used in code, but
you can go too far. It's not helpful to add articles and other parts of speech
to force your names to *literally* read like a grammatically correct sentence.

尝试着使用你自己的 API，并且阅读写出来的代码，可以帮助你为 API 命名，但是不要过于冗余。
添加文章和其他词性以强制名字读起来就像语法正确的句子一样，是没用的。

{:.bad}
<?code-excerpt "misc/lib/effective_dart/design_bad.dart (code-like-prose-overdone)"?>
{% prettify dart tag=pre+code %}
if (theCollectionOfErrors.isEmpty) ...

monsters.producesANewSequenceWhereEach((monster) => monster.hasClaws);
{% endprettify %}


### PREFER a noun phrase for a non-boolean property or variable.

### **推荐** 使用名词短语来命名不是布尔类型的变量和属性。

The reader's focus is on *what* the property is. If the user cares more about
*how* a property is determined, then it should probably be a method with a
verb phrase name.

读者关注属性是*什么*。
如果用户更关心*如何*确定一个属性，则很可能应该是一个使用动词短语命名函数。

{:.good}
{% prettify dart tag=pre+code %}
list.length
context.lineWidth
quest.rampagingSwampBeast
{% endprettify %}

{:.bad}
{% prettify dart tag=pre+code %}
list.deleteItems
{% endprettify %}


### PREFER a non-imperative verb phrase for a boolean property or variable.

### **推荐** 使用非命令式动词短语命名布尔类型的变量和属性。

Boolean names are often used as conditions in control flow, so you want a name
that reads well there. Compare:

布尔名称通常用在控制语句中当做条件，
因此你要应该让这个名字在控制语句中读起来语感很好。比较下面的两个：

{% prettify dart tag=pre+code %}
if (window.closeable) ...  // Adjective.
if (window.canClose) ...   // Verb.
{% endprettify %}

Good names tend to start with one of a few kinds of verbs:

好的名字往往以某一种动词作为开头：

*   a form of "to be": `isEnabled`, `wasShown`, `willFire`. These are, by far,
    the most common.

    “to be” 形式： `isEnabled`， `wasShown`， `willFire`。 
    就目前来看，这些时做常见的。

*   an [auxiliary verb][]: `hasElements`, `canClose`,
    `shouldConsume`, `mustSave`.

    一个 [辅助动词][auxiliary verb]: `hasElements`， `canClose`，
    `shouldConsume`， `mustSave`。

*   an active verb: `ignoresInput`, `wroteFile`. These are rare because they are
    usually ambiguous. `loggedResult` is a bad name because it could mean
    "whether or not a result was logged" or "the result that was logged".
    Likewise, `closingConnection` could be "whether the connection is closing"
    or "the connection that is closing". Active verbs are allowed when the name
    can *only* be read as a predicate.

    一个主动动词： `ignoresInput`， `wroteFile`。
    因为经常引起歧义，所以这种形式比较少见。
    `loggedResult` 是一个不好的命名，因为它的意思可能是：
    "whether or not a result was logged" 或者 "the result that was logged"。
    `closingConnection` 的意思可能是：
    "whether the connection is closing" 或者 "the connection that is closing"。
    *只有* 当名字可以预期的时候才使用主动动词。

[auxiliary verb]: https://en.wikipedia.org/wiki/Auxiliary_verb

What separates all these verb phrases from method names is that they are not
*imperative*. A boolean name should never sound like a command to tell the
object to do something, because accessing a property doesn't change the object.
(If the property *does* modify the object in a meaningful way, it should be a
method.)

可以使用命令式动词来区分布尔变量名字和函数名字。
一个布尔变量的名字不应该看起来像一个命令，告诉这个对象做什么事情。
原因在于访问一个变量的属性并没有修改对象的状态。
（如果这个属性*确实*修改了对象的状态，则它应该是一个函数。）

{:.good}
{% prettify dart tag=pre+code %}
isEmpty
hasElements
canClose
closesWindow
canShowPopup
hasShownPopup
{% endprettify %}

{:.bad}
{% prettify dart tag=pre+code %}
empty         // Adjective or verb?
withElements  // Sounds like it might hold elements.
closeable     // Sounds like an interface.
              // "canClose" reads better as a sentence.
closingWindow // Returns a bool or a window?
showPopup     // Sounds like it shows the popup.
{% endprettify %}

**Exception:** Input properties in [Angular][] components sometimes use
imperative verbs for boolean setters because these setters are invoked in
templates, not from other Dart code.

这条规则有一个例外。[Angular][] 组件中的输入属性有时会使用命令式动词来表示布尔设置器，
因为这些 setter 是在模板中调用的，而不是从其它 Dart 代码中调用的。

[angular]: {{site.angulardart}}


### CONSIDER omitting the verb for a named boolean *parameter*.

### **考虑** 省略命名布尔*参数*的动词。

This refines the previous rule. For named parameters that are boolean, the name
is often just as clear without the verb, and the code reads better at the call
site.

提炼于上一条规则。对于命名布尔参数，
没有动词的名称通常看起来更加舒服。

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (omit-verb-for-bool-param)"?>
{% prettify dart tag=pre+code %}
Isolate.spawn(entryPoint, message, paused: false);
var copy = List.from(elements, growable: true);
var regExp = RegExp(pattern, caseSensitive: false);
{% endprettify %}


### PREFER the "positive" name for a boolean property or variable.

### **考虑** 为布尔属性或变量取“肯定”含义的名字。

Most boolean names have conceptually "positive" and "negative" forms where the
former feels like the fundamental concept and the latter is its
negation&mdash;"open" and "closed", "enabled" and "disabled", etc. Often the
latter name literally has a prefix that negates the former: "visible" and
"*in*-visible", "connected" and "*dis*-connected", "zero" and "*non*-zero".

大多数布尔值名称具有概念形式上的“肯定”和“否定”，
前者感觉更现实基本描述，后者是对基本描述的否定，例如：
"open" 和 "closed"， "enabled" 和 "disabled"，等等。
通常后者的名称字面上有个前缀，用来否定前者：
"visible" 和 "*in*-visible"，
"connected" 和 "*dis*-connected"，
"zero" 和 "*non*-zero"。

When choosing which of the two cases that `true` represents &mdash; and thus
which case the property is named for &mdash; prefer the positive or more
fundamental one. Boolean members are often nested inside logical expressions,
including negation operators. If your property itself reads like a negation,
it's harder for the reader to mentally perform the double negation and
understand what the code means.

当选择 `true` 代表两种情况中的其中一种情况
在布尔的两种情况中，当选择 `true` 代表其中一种情况，
或使用这种情况作为属性名称时，更倾向使用“肯定”或基本描述的方式。
布尔成员通常嵌套在逻辑表达式中，包括否定运算符。
如果属性本身读起来想是个“否定”的，
这将让读者耗费更多精力去阅读双重否定及理解代码的含义。

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (positive)"?>
{% prettify dart tag=pre+code %}
if (socket.isConnected && database.hasData) {
  socket.write(database.read());
}
{% endprettify %}

{:.bad}
<?code-excerpt "misc/lib/effective_dart/design_bad.dart (positive)"?>
{% prettify dart tag=pre+code %}
if (!socket.isDisconnected && !database.isEmpty) {
  socket.write(database.read());
}
{% endprettify %}

For some properties, there is no obvious positive form. Is a document that has
been flushed to disk "saved" or "*un*-changed"? Is a document that *hasn't* been
flushed "*un*-saved" or "changed"? In ambiguous cases, lean towards the choice
that is less likely to be negated by users or has the shorter name.

对于一些属性，没有明显的“肯定”形式。
文档已经刷新 “saved” 到磁盘，或者 "*un*-changed"？
文档还未属性 “*un*-saved” 到磁盘，或者 "changed"？
在模棱两可的情况下，倾向于选择不太可能被用户否定或较短的名字。

**Exception:** With some properties, the negative form is what users
overwhelmingly need to use. Choosing the positive case would force them to
negate the property with `!` everywhere. Instead, it may be better to use the
negative case for that property.

**例外:**  “否定”用户绝大多数用到的形式。
选择“肯定”方式，将会迫使在他们到处使用 `!` 对属性进行取反操作。
这样相反，属性应该使用“否定”形式进行命名。


### PREFER an imperative verb phrase for a function or method whose main purpose is a side effect.

### **推荐** 使用命令式动词短语来命名带有副作用的函数或者方法。

Callable members can return a result to the caller and perform other work or
side effects. In an imperative language like Dart, members are often called
mainly for their side effect: they may change an object's internal state,
produce some output, or talk to the outside world.

函数通常返回一个结果给调用者，并且执行一些任务或者带有副作用。
在像 Dart 这种命令式语言中，调用函数通常为了实现其副作用：
可能改变了对象的内部状态、
产生一些输出内容、或者和外部世界沟通等。

Those kinds of members should be named using an imperative verb phrase that
clarifies the work the member performs.

这种类型的成员应该使用命令式动词短语来命名，强调
该成员所执行的任务。

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (verb-for-func-with-side-effect)"?>
{% prettify dart tag=pre+code %}
list.add("element");
queue.removeFirst();
window.refresh();
{% endprettify %}

This way, an invocation reads like a command to do that work.

这样，调用的方法读起来会让人觉得是一个执行命令。


### PREFER a noun phrase or non-imperative verb phrase for a function or method if returning a value is its primary purpose.

### **考虑** 使用名词短语或者非命令式动词短语命名返回数据为主要功能的方法或者函数。

Other callable members have few side effects but return a useful result to the
caller. If the member needs no parameters to do that, it should generally be a
getter. But, sometimes a logical "property" needs some parameters. For example,
`elementAt()` returns a piece of data from a collection, but it needs a
parameter to know *which* piece of data to return.

虽然这些函数可能也有副作用，但是其主要目的是返回一个数据给调用者。
如果该函数无需参数通常应该是一个 getter 。
有时候获取一个属性则需要一些参数，比如，
`elementAt()` 从集合中返回一个数据，但是需要一个指定返回那个数据的参数。

This means the member is *syntactically* a method, but *conceptually* it is a
property, and should be named as such using a phrase that describes *what* the
member returns.

在*语法*上看这是一个函数，其实*严格来说*其返回的是集合中的一个属性，
应该使用一个能够表示该函数返回的是*什么*的词语来命名。

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (noun-for-func-returning-value)"?>
{% prettify dart tag=pre+code %}
var element = list.elementAt(3);
var first = list.firstWhere(test);
var char = string.codeUnitAt(4);
{% endprettify %}

This guideline is deliberately softer than the previous one. Sometimes a method
has no side effects but is still simpler to name with a verb phrase like
`list.take()` or `string.split()`.

这条规则比前一条要宽松一些。有时候一些
函数没有副作用，但仍然使用一个动词短语来命名，例如：
`list.take()` 或者 `string.split()`。


### CONSIDER an imperative verb phrase for a function or method if you want to draw attention to the work it performs.

### **考虑** 使用命令式动词短语命名一个函数或方法，若果你希望它的执行能被重视。

When a member produces a result without any side effects, it should usually be a
getter or a method with a noun phrase name describing the result it returns.
However, sometimes the work required to produce that result is important. It may
be prone to runtime failures, or use heavyweight resources like networking or
file I/O. In cases like this, where you want the caller to think about the work
the member is doing, give the member a verb phrase name that describes that
work.

当一个成员产生的结果没有额外的影响，它通常应该使用一个 getter 或者一个名词短语描述来命名，用于描述它返回的结果。
但是，有时候执行产生的结果很重要。
它可能容易导致运行时故障，或者使用重量级的资源（例如，网络或文件 I/O）。
在这种情况下，你希望调用者考虑成员在进行的工作，
这时，为成员提供描述该工作的动词短语。

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (verb-for-func-with-work)"?>
{% prettify dart tag=pre+code %}
var table = database.downloadData();
var packageVersions = packageGraph.solveConstraints();
{% endprettify %}

Note, though, that this guideline is softer than the previous two. The work an
operation performs is often an implementation detail that isn't relevant to the
caller, and performance and robustness boundaries change over time. Most of the
time, name your members based on *what* they do for the caller, not *how* they
do it.

但请注意，此准则比前两个更宽松。操作执行工作的实现细节通常与调用这无关，
并且性能和健壮性是随时间经常改变的。
大多数情况下，根据成员为调用者做了“什么”来命名，而不是“如何”做。


### AVOID starting a method name with `get`.

### **避免** 在方法命名中使用 `get` 开头。

In most cases, the method should be a getter with `get` removed from the name.
For example, instead of a method named `getBreakfastOrder()`, define a getter
named `breakfastOrder`.

在大多数情况下，getter 方法名称中应该移除 `get` 。
例如，定义一个名为 `breakfastOrder` 的 getter 方法，
来替代名为 `getBreakfastOrder()` 的方法。

Even if the member does need to be a method because it takes arguments or
otherwise isn't a good fit for a getter, you should still avoid `get`. Like the
previous guidelines state, either:

即使成员因为需要传入参数或者 getter 不适用，
而需要通过方法来实现，也应该避免使用 `get` 开头。
与之前的准则一样：

* Simply drop `get` and [use a noun phrase name][noun] like `breakfastOrder()`
  if the caller mostly cares about the value the method returns.

  如果调用者主要关心的是方法的返回值，只需删除 `get` 并使用 [名词短语][noun] 命名，
  如 `breakfastOrder()` 。

* [Use a verb phrase name][verb] if the caller cares about the work being done,
  but pick a verb that more precisely describes the work than `get`, like
  `create`, `download`, `fetch`, `calculate`, `request`, `aggregate`, etc.

  如果调用者关心的是正在完成的工作，请使用 [动名词短语][verb] 命名，
  这种情况下应该选择一个更能准确描述工作的动名词，而不是使用 `get` 命名，
  如 `create`， `download`， `fetch`， `calculate`， `request`， `aggregate`，等等。

[noun]: #prefer-a-noun-phrase-or-non-imperative-verb-phrase-for-a-function-or-method-if-returning-a-value-is-its-primary-purpose

[verb]: #consider-an-imperative-verb-phrase-for-a-function-or-method-if-you-want-to-draw-attention-to-the-work-it-performs


### PREFER naming a method `to___()` if it copies the object's state to a new object.

### **推荐** 使用 `to___()` 来命名把对象的状态转换到一个新的对象的函数。

{% include linter-rule.html rule="use_to_and_as_if_applicable" %}

A *conversion* method is one that returns a new object containing a copy of
almost all of the state of the receiver but usually in some different form or
representation. The core libraries have a convention that these methods are
named starting with `to` followed by the kind of result.

一个转换函数返回一个新的对象，里面包含一些原对象的状态，但通常新对象的形式或表现方式与原对象不同。
核心库有一个约定，这些类型结果的方法名应该以 `to` 作为开头。

If you define a conversion method, it's helpful to follow that convention.

如果要定义一个转换函数，遵循该约定是非常有益的。

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (to___)"?>
{% prettify dart tag=pre+code %}
list.toSet();
stackTrace.toString();
dateTime.toLocal();
{% endprettify %}


### PREFER naming a method `as___()` if it returns a different representation backed by the original object.

### **推荐** 使用 `as___()` 来命名把原来对象转换为另外一种表现形式的函数。

{% include linter-rule.html rule="use_to_and_as_if_applicable" %}

Conversion methods are "snapshots". The resulting object has its own copy of the
original object's state. There are other conversion-like methods that return
*views*&mdash;they provide a new object, but that object refers back to the
original. Later changes to the original object are reflected in the view.

转换函数提供的是“快照功能”。返回的对象有自己的数据副本，
修改原来对象的数据不会改变返回的对象中的数据。
另外一种函数返回的是同一份数据的另外一种表现形式，返回的是一个新的对象，
但是其内部引用的数据和原来对象引用的数据一样。
修改原来对象中的数据，新返回的对象中的数据也一起被修改。

The core library convention for you to follow is `as___()`.

这种函数在核心库中被命名为 `as___()`。

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (as___)"?>
{% prettify dart tag=pre+code %}
var map = table.asMap();
var list = bytes.asFloat32List();
var future = subscription.asFuture();
{% endprettify %}


### AVOID describing the parameters in the function's or method's name.

### **避免** 在方法或者函数名称中描述参数。

The user will see the argument at the callsite, so it usually doesn't help
readability to also refer to it in the name itself.

在调用代码的时候可以看到参数，所以无需再次显示参数了。

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (avoid-desc-param-in-func)"?>
{% prettify dart tag=pre+code %}
list.add(element);
map.remove(key);
{% endprettify %}

{:.bad}
{% prettify dart tag=pre+code %}
list.addElement(element)
map.removeKey(key)
{% endprettify %}

However, it can be useful to mention a parameter to disambiguate it from other
similarly-named methods that take different types:

但是，对于具有多个类似的函数的时候，使用参数名字可以消除歧义，
这个时候应该带有参数名字：

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (desc-param-in-func-ok)"?>
{% prettify dart tag=pre+code %}
map.containsKey(key);
map.containsValue(value);
{% endprettify %}


### DO follow existing mnemonic conventions when naming type parameters.

### **要** 在命名参数时，遵循现有的助记符约定。

Single letter names aren't exactly illuminating, but almost all generic types
use them. Fortunately, they mostly use them in a consistent, mnemonic way.
The conventions are:

单字母命名没有直接的启发性，但是几乎所有通用类型都使用时情况就不一样了。
幸运的是，它们大多数以一致的助记方式在使用，这些约定如下：

*   `E` for the **element** type in a collection:

    `E` 用于集合中的 **元素** 类型:

    {:.good}
    <?code-excerpt "misc/lib/effective_dart/design_good.dart (type-parameter-e)" replace="/\n\n/\n/g"?>
    {% prettify dart tag=pre+code %}
    class IterableBase<E> {}
    class List<E> {}
    class HashSet<E> {}
    class RedBlackTree<E> {}
    {% endprettify %}

*   `K` and `V` for the **key** and **value** types in an associative
    collection:

    `K` 和 `V` 分别用于关联集合中的 **key** 和 **value** 类型：

    {:.good}
    <?code-excerpt "misc/lib/effective_dart/design_good.dart (type-parameter-k-v)" replace="/\n\n/\n/g"?>
    {% prettify dart tag=pre+code %}
    class Map<K, V> {}
    class Multimap<K, V> {}
    class MapEntry<K, V> {}
    {% endprettify %}

*   `R` for a type used as the **return** type of a function or a class's
    methods. This isn't common, but appears in typedefs sometimes and in classes
    that implement the visitor pattern:

    `R` 用于函数或类方法的 **返回值** 类型。 这种情况并不常见，
    但有时会出现在typedef中，或实现访问者模式的类中：

    {:.good}
    <?code-excerpt "misc/lib/effective_dart/design_good.dart (type-parameter-r)"?>
    {% prettify dart tag=pre+code %}
    abstract class ExpressionVisitor<R> {
      R visitBinary(BinaryExpression node);
      R visitLiteral(LiteralExpression node);
      R visitUnary(UnaryExpression node);
    }
    {% endprettify %}

*   Otherwise, use `T`, `S`, and `U` for generics that have a single type
    parameter and where the surrounding type makes its meaning obvious. There
    are multiple letters here to allow nesting without shadowing a surrounding
    name. For example:

    除此以外，对于具有单个类型参数的泛型，如果助记符能在周围类型中明显表达泛型含义，
    请使用`T`，`S` 和 `U` 。
    这里允许多个字母嵌套且不会与周围命名产生歧义。例如：

    {:.good}
    <?code-excerpt "misc/lib/effective_dart/design_good.dart (type-parameter-t)"?>
    {% prettify dart tag=pre+code %}
    class Future<T> {
      Future<S> then<S>(FutureOr<S> onValue(T value)) => ...
    }
    {% endprettify %}

    Here, the generic method `then<S>()` uses `S` to avoid shadowing the `T`
    on `Future<T>`.

    这里，通常 `then<S>()` 方法使用 `S` 避免 `Future<T>` 中的 `T` 产生歧义。

If none of the above cases are a good fit, then either another single-letter
mnemonic name or a descriptive name is fine:

如果上述情况都不合适，则可以使用另一个单字母助记符名称或描述性的名称：

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (type-parameter-graph)"?>
{% prettify dart tag=pre+code %}
class Graph<N, E> {
  final List<N> nodes = [];
  final List<E> edges = [];
}

class Graph<Node, Edge> {
  final List<Node> nodes = [];
  final List<Edge> edges = [];
}
{% endprettify %}

In practice, the existing conventions cover most type parameters.

在实践中，以上的约定涵盖了大多数参数类型。

## Libraries

## 库

A leading underscore character ( `_` ) indicates that a member is private to its
library. This is not mere convention, but is built into the language itself.

以 ( `_` ) 开头的成员只能在其库的内部被访问，是库的私有成员。
这是 Dart 语言的内置特性，不仅仅是惯例。

### PREFER making declarations private.

### **推荐** 使用私有声明。

A public declaration in a library&mdash;either top level or in a class&mdash;is
a signal that other libraries can and should access that member. It is also a
commitment on your library's part to support that and behave properly when it
happens.

库中的公开声明&mdash;顶级定义或者在类中定义&mdash;是一种信号，
表示其他库可以并应该访问这些成员。
同时公开声明也是一种你的库需要实现的契约，
当使用这些成员的时候，应该实现其宣称的功能。

If that's not what you intend, add the little `_` and be happy. Narrow public
interfaces are easier for you to maintain and easier for users to learn. As a
nice bonus, the analyzer will tell you about unused private declarations so you
can delete dead code. It can't do that if the member is public because it
doesn't know if any code outside of its view is using it.

如果某个成员你不希望公开，则在成员名字之前添加一个 `_` 即可。
减少公开的接口让你的库更容易维护，也让用户更加容易掌握你的库如何使用。
另外，分析工具还可以分析出没有用到的私有成员定义，然后告诉你可以删除这些无用的代码。
私有成员第三方代码无法调用而你自己在库中也没有使用，所以是无用的代码。


### CONSIDER declaring multiple classes in the same library.

### **考虑** 声明多个类在一个库中。

Some languages, such as Java, tie the organization of files to the organization of
classes&mdash;each file may only define a single top level class. Dart does not
have that limitation. Libraries are distinct entities separate from classes.
It's perfectly fine for a single library to contain multiple classes, top level
variables, and functions if they all logically belong together.

一些其他语言，比如 Java。将文件结构和类结构进行捆绑&mdash：每个文件仅能定义一个顶级类。
Dart 没有这样的限制。库与类是相互独立的。如果多个类，顶级变量，以及函数，他们再逻辑上
归为同一类，那么将他们包含到单一的库中，这样做是非常棒的。

Placing multiple classes together in one library can enable some useful
patterns. Since privacy in Dart works at the library level, not the class level,
this is a way to define "friend" classes like you might in C++. Every class
declared in the same library can access each other's private members, but code
outside of that library cannot.

将多个类组织到一个库中，就可以使用一些有用的模式。因为在 Dart 中私有特性是在库级别上有效，
而不是在类级别，基于这个模式你可以定义类似于 C++ 中的 "friend" 类。所有定义在同一个库中
的类可以互相访问彼此的私有成员，但库以外的代码无法发访问。

Of course, this guideline doesn't mean you *should* put all of your classes into
a huge monolithic library, just that you are allowed to place more than one
class in a single library.

将多个类组织到一个库中，就可以使用一些有用的模式。因为在 Dart 中私有特性是在库级别上有效，
而不是在类级别，基于这个模式你可以定义类似于 C++ 中的 "friend" 类。所有定义在同一个库中
的类可以互相访问彼此的私有成员，但库以外的代码无法发访问。


## Classes and mixins

## 类

Dart is a "pure" object-oriented language in that all objects are instances of
classes. But Dart does not require all code to be defined inside a
class&mdash;you can define top-level variables, constants, and functions like
you can in a procedural or functional language.

Dart是一种 “纯粹的” 面向对象语言，因为所有对象都是类的实例。但是 Dart 并没有要求所有代码都
定义到类中&mdash; 类似在面向过程或函数的语言，你可以在 Dart 中定义顶级变量，常量，以及函数。

### AVOID defining a one-member abstract class when a simple function will do.

### **避免** 避免为了使用一个简单的函数而去定义一个单一成员的抽象类

{% include linter-rule.html rule="one_member_abstracts" %}

Unlike Java, Dart has first-class functions, closures, and a nice light syntax
for using them. If all you need is something like a callback, just use a
function. If you're defining a class and it only has a single abstract member
with a meaningless name like `call` or `invoke`, there is a good chance you
just want a function.

和 Java 不同，Dart 拥有一等公民的函数，闭包，以及它们简洁的使用语法。如果你仅仅是需要一个
类似于回调的功能，那么使用函数即可。 例如如果你正在定义一个类，并且它仅拥有一个毫无意义名称的
抽象成员，如 `call` 或 `invoke` ，那么这时你很可能只是需要一个函数。

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (one-member-abstract-class)"?>
{% prettify dart tag=pre+code %}
typedef Predicate<E> = bool Function(E element);
{% endprettify %}

{:.bad}
<?code-excerpt "misc/lib/effective_dart/design_bad.dart (one-member-abstract-class)"?>
{% prettify dart tag=pre+code %}
abstract class Predicate<E> {
  bool test(E element);
}
{% endprettify %}


### AVOID defining a class that contains only static members.

### **避免** 定义仅包含静态成员的类。

{% include linter-rule.html rule="avoid_classes_with_only_static_members" %}

In Java and C#, every definition *must* be inside a class, so it's common to see
"classes" that exist only as a place to stuff static members. Other classes are
used as namespaces&mdash;a way to give a shared prefix to a bunch of members to
relate them to each other or avoid a name collision.

在 Java 和 C# 中，所有的定义*必须*要在类中。所有常常会看到一些这样的类，这些
类中仅仅放置了些静态成员。其他类仅用于命名空间&mdash;一种为一堆成员提供共享
前缀将它们相互关联或避免名称冲突的方法。

Dart has top-level functions, variables, and constants, so you don't *need* a
class just to define something. If what you want is a namespace, a library is a
better fit. Libraries support import prefixes and show/hide combinators. Those
are powerful tools that let the consumer of your code handle name collisions in
the way that works best for *them*.

在 Java 和 C# 中，所有的定义*必须*要在类中。所有常常会看到一些这样的类，这些
类中仅仅放置了些静态成员。其他类仅用于命名空间&mdash;一种为一堆成员提供共享
前缀将它们相互关联或避免名称冲突的方法。

If a function or variable isn't logically tied to a class, put it at the top
level. If you're worried about name collisions, give it a more precise name or
move it to a separate library that can be imported with a prefix.

如果函数或变量在逻辑上与类无关，那么应该将其置于顶层。如果担心名称冲突，
那么请为其指定更精确的名称，或将其移动到可以使用前缀导入的单独库中。

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (class-only-static)"?>
{% prettify dart tag=pre+code %}
DateTime mostRecent(List<DateTime> dates) {
  return dates.reduce((a, b) => a.isAfter(b) ? a : b);
}

const _favoriteMammal = 'weasel';
{% endprettify %}

{:.bad}
<?code-excerpt "misc/lib/effective_dart/design_bad.dart (class-only-static)"?>
{% prettify dart tag=pre+code %}
class DateUtils {
  static DateTime mostRecent(List<DateTime> dates) {
    return dates.reduce((a, b) => a.isAfter(b) ? a : b);
  }
}

class _Favorites {
  static const mammal = 'weasel';
}
{% endprettify %}

In idiomatic Dart, classes define *kinds of objects*. A type that is never
instantiated is a code smell.

通常在 Dart 中，类定义了*一类对象*。一个类型，如果类型从来没有被初始化，
那么这是另一种的代码气息。

However, this isn't a hard rule. With constants and enum-like types, it may be
natural to group them in a class.

当然，这并不是一条硬性规则。对于常量和类似枚举的类型，将它们组合在一个类
中看起来也是很自然。

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_bad.dart (class-only-static-exception)"?>
{% prettify dart tag=pre+code %}
class Color {
  static const red = '#f00';
  static const green = '#0f0';
  static const blue = '#00f';
  static const black = '#000';
  static const white = '#fff';
}
{% endprettify %}


### AVOID extending a class that isn't intended to be subclassed.

### **避免** 集成一个不期望被集成的类。

If a constructor is changed from a generative constructor to a factory
constructor, any subclass constructor calling that constructor will break.
Also, if a class changes which of its own methods it invokes on `this`, that
may break subclasses that override those methods and expect them to be called
at certain points.

如果一个类的构造函数从生成构造函数被更改为工厂构造函数，则调用该构造函数的任何子类构造函数都
将失败。 此外，如果一个类改变了它在 `this` 上调用的自己的方法，那么覆盖这些方法并期望他们在
某些点被调用的子类再调用时会失败。

Both of these mean that a class needs to be deliberate about whether or not it
wants to allow subclassing. This can be communicated in a doc comment, or by
giving the class an obvious name like `IterableBase`. If the author of the class
doesn't do that, it's best to assume you should *not* extend the class.
Otherwise, later changes to it may break your code.

以上两种情况都意味着一个类需要考虑是否要允许被子类化。这种情况可以通过文档注释来沟通，或者为类
提供一个显示命名，如 `IterableBase`。如果该类的作者不这样做，最好假设你*不*能够继承这个类。
否则，后续对它的修改可能会破坏你的代码。


### DO document if your class supports being extended.

### **要** 把能够继承的说明添加到文档中，如果这个类可以继承。

This is the corollary to the above rule. If you want to allow subclasses of your
class, state that. Suffix the class name with `Base`, or mention it in the
class's doc comment.

该规则是上条规则的结果。如果允许你的类被子类化，请在文档中说明情况。使用 `Base` 作为类名的后缀，
或者在类的注释文档中注明。


### AVOID implementing a class that isn't intended to be an interface.

### **避免** 去实现一个不期望成为接口的类（该类不想作为接口被实现）。

Implicit interfaces are a powerful tool in Dart to avoid having to repeat the
contract of a class when it can be trivially inferred from the signatures of an
implementation of that contract.

隐式接口是Dart中的一个强大工具，当一个类中可以很容易的推断出一些已经约定的有特征的实现时，
隐式接口可以避免重复定义这个类的约定。

But implementing a class's interface is a very tight coupling to that class. It
means virtually *any* change to the class whose interface you are implementing
will break your implementation. For example, adding a new member to a class is
usually a safe, non-breaking change. But if you are implementing that class's
interface, now your class has a static error because it lacks an implementation
of that new method.

但是通过类的隐式接口实现的新类，新类会与这个类产生非常紧密的耦合。也就是说，对于接口类的
*任何*修改，你实现的新类都会被破坏。例如，向类中添加新成员通常是安全，不会产生破坏性的改变。
但是如果你实现了这个类的接口，那么现在你的类会产生一个静态错误，因为它缺少了新方法的实现。

Library maintainers need the ability to evolve existing classes without breaking
users. If you treat every class like it exposes an interface that users are free
to implement, then changing those classes becomes very difficult. That
difficulty in turn means the libraries you rely on are slower to grow and adapt
to new needs.

库的维护人员需要能够在不破坏用户代码的情况下迭代现有的累。如果把每个类都看待成是暴露给用户
的接口，用户可以自由的实现，这时修改这些类将变得非常困难。反过来，这个困难将导致你的库
迭代缓慢，从而无法适应新的需求。

To give the authors of the classes you use more leeway, avoid implementing
implicit interfaces except for classes that are clearly intended to be
implemented. Otherwise, you may introduce a coupling that the author doesn't
intend, and they may break your code without realizing it.

为了给你的类的开发人员提供更多的余地，避免实现隐式接口，除非那些类明确需要实现。否则，
你可能会引入开发者没有预料到的耦合情况，这样可能会在没有意识到的情况下破坏你的代码。

### DO document if your class supports being used as an interface.

### **要** 对支持接口的类在文档注明

If your class can be used as an interface, mention that in the class's doc
comment.

如果你的类可以被用作接口，那么将这个情况注明到类的文档中。


### DO use `mixin` to define a mixin type.

### **要** 对支持 mixin 的类在文档注明

{% include linter-rule.html rule="prefer_mixin" %}

Dart originally didn't have a separate syntax for declaring a class intended to
be mixed in to other classes. Instead, any class that met certain restrictions
(no non-default constructor, no superclass, etc.) could be used as a mixin. This
was confusing because the author of the class might not have intended it to be
mixed in.

Dart 2.1.0 added a `mixin` keyword for explicitly declaring a mixin. Types
created using that can *only* be used as mixins, and the language also ensures
that your mixin stays within the restrictions. When defining a new type that you
intend to be used as a mixin, use this syntax.

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (mixin)"?>
{% prettify dart tag=pre+code %}
mixin ClickableMixin implements Control {
  bool _isDown = false;

  void click();

  void mouseDown() {
    _isDown = true;
  }

  void mouseUp() {
    if (_isDown) click();
    _isDown = false;
  }
}
{% endprettify %}

You might still encounter older code using `class` to define mixins, but the new
syntax is preferred.


### AVOID mixing in a type that isn't intended to be a mixin. {#avoid-mixing-in-a-class-that-isnt-intended-to-be-a-mixin}

### **避免** 去 mixin 一个不期望被 mixin 的类 {#avoid-mixing-in-a-class-that-isnt-intended-to-be-a-mixin}

{% include linter-rule.html rule="prefer_mixin" %}

For compatibility, Dart still allows you to mix in classes that aren't defined
using `mixin`. However, that's risky. If the author of the class doesn't intend
the class to be used as a mixin, they might change the class in a way that
breaks the mixin restrictions. For example, if they add a constructor, your
class will break.

If the class doesn't have a doc comment or an obvious name like `IterableMixin`,
assume you cannot mix in the class if it isn't declared using `mixin`.

## Constructors

## 构造函数

Dart constructors are created by declaring a function with the same name as the
class and, optionally, an additional identifier. The latter are called *named
constructors*.

通过声明与类具有相同名称的函数以及附加可选的标识符来创建 Dart 构造函数。 后者附加标示符的
构造函数被称为*命名构造函数*。

### CONSIDER making your constructor `const` if the class supports it.

### **考虑** 在类支持的情况下，指定构造函数为  `const`。

If you have a class where all the fields are final, and the constructor does
nothing but initialize them, you can make that constructor `const`. That lets
users create instances of your class in places where constants are
required&mdash;inside other larger constants, switch cases, default parameter
values, etc.

如果一个类，它所有的字段都是 final ，并且构造函数出了初始化他们之外没有任
何其他操作，那么可以将其作为 `const` 构造函数。这样就能够允许用户在需要
常量的位置创建类的实例&mdash;一些大型的常量，switch case 语句，默认参数中，
以及其他的情况。

If you don't explicitly make it `const`, they aren't able to do that.

如果没有显示的指定为 `const` 构造函数，那么就无法实现上述目的。

Note, however, that a `const` constructor is a commitment in your public API. If
you later change the constructor to non-`const`, it will break users that are
calling it in constant expressions. If you don't want to commit to that, don't
make it `const`. In practice, `const` constructors are most useful for simple,
immutable data record sorts of classes.

但需要注意的是，构造函数被指定为 `const` ，那它就是公共 API 的一中承诺。
如果后面将构造函数更改为非 `const` ，那么在常量表达式中调用它的代码就会被破坏。
如果不想做出这样的承诺，那么就不要指定它为 `const` 构造函数。在实际运用中，
`const` 构造函数对于简单的，不可变的数据记录类是非常有用的。

## Members

## 成员

A member belongs to an object and can be either methods or instance variables.

成员属于对象，成员可以是方法或实例变量。

### PREFER making fields and top-level variables `final`.

### **推荐** 指定字段或顶级变量为 `final` 。

{% include linter-rule.html rule="prefer_final_fields" %}

State that is not *mutable*&mdash;that does not change over time&mdash;is
easier for programmers to reason about. Classes and libraries that minimize the
amount of mutable state they work with tend to be easier to maintain.

状态不可变&mdash;随着时间推移状态不发生变化&mdash;有益于程序员推理。类和库中可变状态量越少，类和库
越容易维护。

Of course, it is often useful to have mutable data. But, if you don't need it,
your default should be to make fields and top-level variables `final` when you
can.

当然，可变数据是非常有用的。但是，如果并不需要可变数据，应该尽可能默认指定字段和顶级变量为 `final` 。


### DO use getters for operations that conceptually access properties.

### **要** 对概念上是访问的属性使用 getter 方法。

Deciding when a member should be a getter versus a method is a challenging,
subtle, but important part of good API design, hence this very long guideline.
Some other language's cultures shy away from getters. They only use them when
the operation is almost exactly like a field&mdash;it does a miniscule amount of
calculation on state that lives entirely on the object. Anything more complex or
heavyweight than that gets `()` after the name to signal "computation goin' on
here!" because a bare name after a `.` means "field".

判定一个成员应该是一个 getter 而不是一个方法是一件具有挑战性的事情。它虽然微妙，但对于好的
API 设计是非常重要的，也导致本规则会很长。其他的一些语言文化中回避了getter。他们只有在几乎
类似于字段访问的时候才会使用&mdash;它仅仅是根据对象的状态进行微小的计算。任何比这更复杂或
重量级的东西得到带有 `()` 的名字后面，给出一种"计算的操作在这！"信号。因为 `.` 后面只跟名称
意味着是"字段"。

Dart is *not* like that. In Dart, *all* dotted names are member invocations that
may do computation. Fields are special&mdash;they're getters whose
implementation is provided by the language. In other words, getters are not
"particularly slow fields" in Dart; fields are "particularly fast getters".

Dart 与他们 *不* 同。在 Dart 中，所有点名称都可以是进行计算的成员调用。字段是特殊的&mdash;
字段的 getter 的实现是有语言提供的。换句话说，在 Dart 中，getter 不是"访问特别慢的字段"；
字段是"访问特别快的 getter "。

Even so, choosing a getter over a method sends an important signal to the
caller. The signal, roughly, is that the operation is "field-like". The
operation, at least in principle, *could* be implemented using a field, as far
as the caller knows. That implies:

即便如此，选择 getter 而不是方法对于调用者来说是一个重要信号。信号大致的意思成员的操作
"类似于字段"。至少原则上可以这么认为，只要调用者清楚，这个操作*可以*使用字段来实现。这意味着：

*   **The operation does not take any arguments and returns a result.**

    **操作返回一个结果但不接受任何参数。**

*   **The caller cares mostly about the result.** If you want the caller to
    worry about *how* the operation produces its result more than they do the
    result being produced, then give the operation a verb name that describes
    the work and make it a method.

    **调用者主要关系结果。** 如果希望调用者关系操作产生结果的方式多于产生的结果，那么为操作提供一个方法，使用描述工作的动词作为方法的名称。

    This does *not* mean the operation has to be particularly fast in order to
    be a getter. `IterableBase.length` is `O(n)`, and that's OK. It's fine for a
    getter to do significant calculation. But if it does a *surprising* amount
    of work, you may want to draw their attention to that by making it a method
    whose name is a verb describing what it does.

    这并*不*意味着操作必须特别快才能成为 getter 方法。`IterableBase.length` 复杂度是
     `O(n)`，是可以的。使用 getter 方法进行重要计算是没问题的。但是如果它做了*超*大量的工作，你可能需要通过一个描述其功能的动词的方法来引起使用者的注意。

    {:.bad}
    {% prettify dart tag=pre+code %}
    connection.nextIncomingMessage; // Does network I/O.
    expression.normalForm; // Could be exponential to calculate.
    {% endprettify %}

*   **The operation does not have user-visible side effects.** Accessing a real
    field does not alter the object or any other state in the program. It
    doesn't produce output, write files, etc. A getter shouldn't do those things
    either.

    **操作不会产生使用者可见的副作用。** 在程序中访问一个实际的字段不会改变对象或者其他的状态。
    操作不会产生输出，写入文件等。同样 getter 方法也一样。

    The "user-visible" part is important. It's fine for getters to modify hidden
    state or produce out of band side effects. Getters can lazily calculate and
    store their result, write to a cache, log stuff, etc. As long as the caller
    doesn't *care* about the side effect, it's probably fine.

    注意关键字"使用者可见"。只要调用者不*关心*这些副作用。getter 方法可以修改隐藏状态或产生
    带外副作用。 getter 方法可以惰性计算和存储他们的结果，写入缓存， log 等。这样是没有问题的。

    {:.bad}
    {% prettify dart tag=pre+code %}
    stdout.newline; // Produces output.
    list.clear; // Modifies object.
    {% endprettify %}

*   **The operation is *idempotent*.** "Idempotent" is an odd word that, in this
    context, basically means that calling the operation multiple times produces
    the same result each time, unless some state is explicitly modified between
    those calls. (Obviously, `list.length` produces different results if you add
    an element to the list between calls.)

    注意关键字"使用者可见"。只要调用者不*关心*这些副作用。getter 方法可以修改隐藏状态或产生
    带外副作用。 getter 方法可以惰性计算和存储他们的结果，写入缓存， log 等。这样是没有问题的。

    "Same result" here does not mean a getter must literally produce an
    identical object on successive calls. Requiring that would force many
    getters to have brittle caching, which negates the whole point of using a
    getter. It's common, and perfectly fine, for a getter to return a new future
    or list each time you call it. The important part is that the future
    completes to the same value, and the list contains the same elements.

    这里"相同的结果"并不意味着 getter 方法必须一定要在每次调用成功后都返回相同的对象。如果
    按这样的要求会迫使很过 getter 方法需要进行脆弱的缓存（brittle caching），这样就否定了
    使用 getter 的全部意义。常见的非常好的示例是，每次调用一个 getter 方法返回一个新的 
    future 或 list。重点在于， future 完成后返回相同的值，list 包含了相同的元素。

    In other words, the result value should be the same *in the aspects that the
    caller cares about.*

    换句话说，*调用者关系的*是结果值应该相等。

    {:.bad}
    {% prettify dart tag=pre+code %}
    DateTime.now; // New result each time.
    {% endprettify %}

*   **The resulting object doesn't expose all of the original object's state.**
    A field exposes only a piece of an object. If your operation returns a
    result that exposes the original object's entire state, it's likely better
    off as a [`to___()`][to] or [`as___()`][as] method.

    **结果对象不用公开所有原始对象的状态。** 一个字段仅公开对象的一部分。如果操作返回的结果
    公开了原始对象的整个状态，那么把该操作作为 [`to___()`][to] 或 [`as___()`][as] 方法
    可能会更好。

[to]: #prefer-naming-a-method-to___-if-it-copies-the-objects-state-to-a-new-object
[as]: #prefer-naming-a-method-as___-if-it-returns-a-different-representation-backed-by-the-original-object

If all of the above describe your operation, it should be a getter. It seems
like few members would survive that gauntlet, but surprisingly many do. Many
operations just do some computation on some state and most of those can and
should be getters.

如果操作符合上述描述，那么它应该是一个 getter 方法。看似满足这一系列要求的成员并不多，但实际上
会超出你的想象。许多操作只是对某些状态进行一些计算，其中大多数能够，并且也应该作为 getter 方法。


{:.good}
{% prettify dart tag=pre+code %}
rectangle.area;
collection.isEmpty;
button.canShow;
dataSet.minimumValue;
{% endprettify %}


### DO use setters for operations that conceptually change properties.

### **要** 对概念上是修改的属性使用 setter 方法。

{% include linter-rule.html rule="use_setters_to_change_properties" %}

Deciding between a setter versus a method is similar to deciding between a
getter versus a method. In both cases, the operation should be "field-like".

判定一个成员应该是一个 setter 而不是一个方法与 getter 的判定一样。两者的操作都应该是
"类似于字段"的操作。

For a setter, "field-like" means:

对于 setter 方法，"类似于字段"意味着：

*   **The operation takes a single argument and does not produce a result
    value.**

    **操作只有一个参数，不会返回结果。**

*   **The operation changes some state in the object.**

    **操作会更改对象中的某些状态。**

*   **The operation is idempotent.** Calling the same setter twice with the same
    value should do nothing the second time as far as the caller is concerned.
    Internally, maybe you've got some cache invalidation or logging going on.
    That's fine. But from the caller's perspective, it appears that the second
    call does nothing.

    **操作是*幂等*的。** 使用相同的值调用相同的 setter 两次，就调用者而言，第二次不应该执
    行任何操作。在内部，也许你会得到一些无效的缓存或者多次的日志记录。没关系，从调用者的角度
    来看，第二次调用似乎没做任何事情。

{:.good}
{% prettify dart tag=pre+code %}
rectangle.width = 3;
button.visible = false;
{% endprettify %}


### DON'T define a setter without a corresponding getter.

### **不要** 在没有对应的 getter 的情况下定义 setter。

{% include linter-rule.html rule="avoid_setters_without_getters" %}

Users think of getters and setters as visible properties of an object. A
"dropbox" property that can be written to but not seen is confusing and
confounds their intuition about how properties work. For example, a setter
without a getter means you can use `=` to modify it, but not `+=`.

用户将 getter 和 setter 视为一个对象的可见属性。一个 "dropbox" 属性可以被写入但无法读
取，会令人感到困惑。并且也混淆了他们对属性如何工作的直观理解。 例如，没有 getter 的 setter 
意味着你可以使用 `=` 来修改它，但却不能使用 `+=` 。

This guideline does *not* mean you should add a getter just to permit the setter
you want to add. Objects shouldn't generally expose more state than they need
to. If you have some piece of an object's state that can be modified but not
exposed in the same way, use a method instead.

本规则意义并*不*是说，你需要先添加一个 getter 才被允许添加 setter ，对象通常不应该暴露出
多余的状态。如果某个对象的某个状态可以修改但不能以相同的方式访问，请改用方法实现。

**Exception:** An [Angular][] component class may expose setters that are
invoked from a template to initialize the component. Often, these setters are
not intended to be invoked from Dart code and don't need a corresponding getter.
(If they are used from Dart code, they *should* have a getter.)

**例外：** 在 [Angular][] 组件类上，从模板调用的初始化组件 setter 可以公开。
通常，这些 setter 是不打算在 Dart 中调用的，也就不���要相应的 getter。（如果在 Dart 代码
中使用它们，那么它们*应该*有一个对应的 getter 。）

[angular]: {{site.angulardart}}


### AVOID returning `null` from members whose return type is `bool`, `double`, `int`, or `num`.

### **避免** 从返回类型为 `bool` ， `double` ， `int` 或 `num` 的成员返回 `null` 。

{% include linter-rule.html rule="avoid_returning_null" %}

Even though all types are nullable in Dart, users assume those types almost
never contain `null`, and the lowercase names encourage a "Java primitive"
mindset.

尽管在 Dart 中所有类型都可以为空，但用户几乎都不会考虑它们是 `null` 的情况。而小写命名是
源于 "Java primitive" 的提倡。

It can be occasionally useful to have a "nullable primitive" type in your API,
for example to indicate the absence of a value for some key in a map, but these
should be rare.

在 API 中有一个 "nullable primitive" 类型可能会偶尔被用到。例如，指出 map 中不存在的 
key 值，但这样的应用并不多见。

If you do have a member of this type that may return `null`, document it very
clearly, including the conditions under which `null` will be returned.

如果确实有成员可能返回 `null` 的类型，请在文档中注明，以及在什么情况下回返回 `null`。 

### AVOID returning `this` from methods just to enable a fluent interface.

### **避免** 为了书写流畅，而从方法中返回 `this` 。

{% include linter-rule.html rule="avoid_returning_this" %}

Method cascades are a better solution for chaining method calls.

方法级联是链接方法调用的更好的解决方式。

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (cascades)"?>
{% prettify dart tag=pre+code %}
var buffer = StringBuffer()
  ..write('one')
  ..write('two')
  ..write('three');
{% endprettify %}

{:.bad}
<?code-excerpt "misc/lib/effective_dart/design_bad.dart (cascades)"?>
{% prettify dart tag=pre+code %}
var buffer = StringBuffer()
    .write('one')
    .write('two')
    .write('three');
{% endprettify %}


## Types

## 类型

When you write down a type in your program, you constrain the kinds of values
that flow into different parts of your code. Types can appear in two kinds of
places: *type annotations* on declarations and type arguments to *generic
invocations*.

程序中的类型用于约束流入代码各位置的*值*的不同类型。类型会出现在两种位置：声明中的*类型注解（type 
annotations）*和*泛型调用（generic invocations）*的类型参数。

Type annotations are what you normally think of when you think of "static
types". You can type annotate a variable, parameter, field, or return type. In
the following example, `bool` and `String` are type annotations. They hang off
the static declarative structure of the code and aren't "executed" at runtime.

当你想到*静态类型*时，通常会联想到类型注解。类型注解可以用于为变量，参数，字段，或者返回值
声明类型。在下面的示例中，`bool` 和 `String` 是类型注解。他们位于代码静态声明结构的前面，
并且他们不会在运行时"执行"。

<?code-excerpt "misc/lib/effective_dart/design_good.dart (annotate-declaration)"?>
{% prettify dart tag=pre+code %}
bool isEmpty(String parameter) {
  bool result = parameter.isEmpty;
  return result;
}
{% endprettify %}

A generic invocation is a collection literal, a call to a generic class's
constructor, or an invocation of a generic method. In the next example, `num`
and `int` are type arguments on generic invocations. Even though they are types,
they are first-class entities that get reified and passed to the invocation at
runtime.

泛型调用可以是一个字面量集合的定义，一个泛型类构造函数的调用，或者一个泛型方法的调用。在下面
的示例中，`num` 和 `int` 都是泛型调用的类型参数。虽然它们是类型，但是它们也是第一类实体，
在运行时会被提升并传递给调用。

<?code-excerpt "misc/lib/effective_dart/design_good.dart (annotate-invocation)"?>
{% prettify dart tag=pre+code %}
var lists = <num>[1, 2];
lists.addAll(List<num>.filled(3, 4));
lists.cast<int>();
{% endprettify %}

We stress the "generic invocation" part here, because type arguments can *also*
appear in type annotations:

这里再强调一下"泛型调用"，因为类型参数*也*可以出现在类型注解中：

<?code-excerpt "misc/lib/effective_dart/design_good.dart (annotate-type-arg)"?>
{% prettify dart tag=pre+code %}
List<int> ints = [1, 2];
{% endprettify %}

Here, `int` is a type argument, but it appears inside a type annotation, not a
generic invocation. You usually don't need to worry about this distinction, but
in a couple of places, we have different guidance for when a type is used in a
generic invocation as opposed to a type annotation.

这里，`int` 是一个类型参数，但它出现在了类型注解中，而不是泛型调用。通常来说不需要担心这种情况，
但在几个地方，对于类型的运用是泛型调用而不是类型注解有不同的指导。

In most places, Dart allows you to omit a type annotation and infers a type for
you based on the nearby context, or defaults to the `dynamic` type. The fact
that Dart has both type inference and a `dynamic` type leads to some confusion
about what it means to say code is "untyped". Does that mean the code is
dynamically typed, or that you didn't *write* the type? To avoid that confusion,
we avoid saying "untyped" and instead use the following terminology:

在大多数地方，Dart 允许省略类型注解并根据附近的上下文提供推断类型，或默认指定为 `dynamic` 
类型。Dart 同时具有类型推断和 `dynamic` 类型的情况，导致对代码中 "untyped" 的含义产生一些
混淆。意思就是不*写*类型就是动态类型吗？为避免这种混淆，应该避免说 "untyped" ，而是使用以下术语：

*   If the code is *type annotated*, the type was explicitly written in the
    code.

    如果代码是*类型注解*，则在代码中显式写入类型。

*   If the code is *inferred*, no type annotation was written, and Dart
    successfully figured out the type on its own. Inference can fail, in which
    case the guidelines don't consider that inferred. In some places, inference
    failure is a static error. In others, Dart uses `dynamic` as the fallback
    type.

    如果代码的类型是*推断*的，则不必写类型注解，Dart 会自己会找出它的类型。规则不考虑推断可能
    会失败的情况，在一些地方，推理失败会产生一个静态错误。在其他情况下，Dart 使用 `dynamic`
    作为备选类型。

*   If the code is *dynamic*, then its static type is the special `dynamic`
    type. Code can be explicitly annotated `dynamic` or it can be inferred.

    如果代码是*动态类型*，那么它的静态类型就是特殊的 `dynamic` 类型。代码可以明确地注解为 
    `dynamic` 类型，也可以由 Dart 进行推断。

In other words, whether some code is annotated or inferred is orthogonal to
whether it is `dynamic` or some other type.

换句话说，对于代码的类型是 `dynamic` 类型还是其他类型，在类型注解或类型推断中是正交的。

Inference is a powerful tool to spare you the effort of writing and reading
types that are obvious or uninteresting. Omitting types in obvious cases also
draws the reader's attention to explicit types when those types are important,
for things like casts.

类型推断是一种强大的工具，可以免于编写和阅读那些明显或无趣的类型。在明显的情况下省略类型也会
引起读者注意那些被显式注解的重要类型，例如强制类型转换。

Explicit types are also a key part of robust, maintainable code. They define the
static shape of an API. They document and enforce what kinds of values are
allowed to reach different parts of the program.

显示类型也是代码健壮和高可维护的关键。它们定义了API的静态形状。注明并约束流入代码各位置的值
的不同类型值。

The guidelines here strike the best balance we've found between brevity and
explicitness, flexibility and safety. When deciding which types to write, you
need to answer two questions:

这些准则促使我们在简洁性和明确性，灵活性和安全性之间找到了最佳平衡。在决定要编写类型钱前
您需要回答这两问题：

* Which types should I write because I think it's best for them to be visible in
  the code?

  我应该书写哪种类型那？因为我期望这些类型在代码中最好是被看到！

* Which types should I write because inference can't provide them for me?

  我应该书写哪种类型那？因为推理无法为我提供这些类型！

These guidelines help you answer the first question:

这些规则可以帮助你回答第一个问题：

* [PREFER type annotating public fields and top-level variables if the type isn't obvious.](#prefer-type-annotating-public-fields-and-top-level-variables-if-the-type-isnt-obvious)

  [**推荐** 为类型不明显的公共字段和顶级变量指定类型注解。](#prefer-type-annotating-public-fields-and-top-level-variables-if-the-type-isnt-obvious)

* [CONSIDER type annotating private fields and top-level variables if the type isn't obvious.](#consider-type-annotating-private-fields-and-top-level-variables-if-the-type-isnt-obvious)

  [**考虑** 为类型不明显的私有字段和私有顶级变量指定类型注解。](#consider-type-annotating-private-fields-and-top-level-variables-if-the-type-isnt-obvious)

* [AVOID type annotating initialized local variables.](#avoid-type-annotating-initialized-local-variables)

  [**避免** 为初始化的局部变量添加类型注解。](#avoid-type-annotating-initialized-local-variables)

* [AVOID annotating inferred parameter types on function expressions.](#avoid-annotating-inferred-parameter-types-on-function-expressions)

  [**避免** 在函数表达式上注解推断的参数类型。](#avoid-annotating-inferred-parameter-types-on-function-expressions)

* [AVOID redundant type arguments on generic invocations.](#avoid-redundant-type-arguments-on-generic-invocations)

  [**避免** 在泛型调用中参数类型的冗余使用。](#avoid-redundant-type-arguments-on-generic-invocations)

These cover the second:

这些规则涵盖了第二个问题：

* [DO annotate when Dart infers the wrong type.](#do-annotate-when-dart-infers-the-wrong-type)

  [**要** 在 Dart 推断类型错误的时候进行类型注解。](#do-annotate-when-dart-infers-the-wrong-type)

* [PREFER annotating with `dynamic` instead of letting inference fail.](#prefer-annotating-with-dynamic-instead-of-letting-inference-fail)

  [**推荐** 使用 `dynamic` 注解替换推断失败的情况。](#prefer-annotating-with-dynamic-instead-of-letting-inference-fail)

The remaining guidelines cover other more specific questions around types.

其余指南涵盖了和类型有关的其他具体问题。


### PREFER type annotating public fields and top-level variables if the type isn't obvious.

### **推荐** 为类型不明显的公共字段和公共顶级变量指定类型注解。

{% include linter-rule.html rule="type_annotate_public_apis" %}

Type annotations are important documentation for how a library should be used.
They form boundaries between regions of a program to isolate the source of a
type error. Consider:

类型注解是关于如何使用库的重要文档。它们在程序的区域之间形成边界以隔离类型错误来源。思考下面代码：

{:.bad}
<?code-excerpt "misc/lib/effective_dart/design_bad.dart (type_annotate_public_apis)"?>
{% prettify dart tag=pre+code %}
install(id, destination) => ...
{% endprettify %}

Here, it's unclear what `id` is. A string? And what is `destination`? A string
or a `File` object? Is this method synchronous or asynchronous? This is clearer:

在这里，无法判断：这个 `id` 是什么，一个字符串？`destination` 又是什么，一个字符串还是一个 
`File` 对象？方法是同步的还是异步的？下面的实例会清晰很多：

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (type_annotate_public_apis)"?>
{% prettify dart tag=pre+code %}
Future<bool> install(PackageId id, String destination) => ...
{% endprettify %}

In some cases, though, the type is so obvious that writing it is pointless:

但在一些情况下，类型非常明显，根本没有指明类型的必要：

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (inferred)"?>
{% prettify dart tag=pre+code %}
const screenWidth = 640; // Inferred as int.
{% endprettify %}

"Obvious" isn't precisely defined, but these are all good candidates:

这里的"明显"并没有精确的定义，下面这些可以作为很好的参考：

* Literals.
  
  字面量。

* Constructor invocations.
 
  构造函数调用。

* References to other constants that are explicitly typed.

  引用的其他类型明确的常量。

* Simple expressions on numbers and strings.

  数字和字符串的简单表达式。

* Factory methods like `int.parse()`, `Future.wait()`, etc. that readers are
  expected to be familiar with.

  读者熟悉的工厂方法，如 `int.parse()`， `Future.wait()` 等。

When in doubt, add a type annotation. Even when a type is obvious, you may still
wish to explicitly annotate. If the inferred type relies on values or
declarations from other libraries, you may want to type annotate *your*
declaration so that a change to that other library doesn't silently change the
type of your own API without you realizing.

如有疑问，请添加类型注解。即使类型很明显，但可能任然希望明确的注解。如果推断类型依赖于其他库中的值
或声明，可能需要添加注解的声明。这样自己的API就不会因为其他库的修改而被悄无声息的改变了类型。


### CONSIDER type annotating private fields and top-level variables if the type isn't obvious.

### **考虑** 为类型不明显的私有字段和私有顶级变量指定类型注解。

{% include linter-rule.html rule="prefer_typing_uninitialized_variables" %}

Type annotations on your public declarations help *users* of your code. Types on
private members help *maintainers*. The scope of a private declaration is
smaller and those who need to know the type of that declaration are also more
likely to be familiar with the surrounding code. That makes it reasonable to
lean more heavily on inference and omit types for private declarations, which is
why this guideline is softer than the previous one.

为公共声明进行类型注解有助于使用代码的*用户*，为私有成员进行类型注解有助于代码的*维护人员*。
私有声明的范围较小，熟悉与它相关代码的人才需要知道它们的声明类型。在这里就更倾向于省略注解，
通过推理得到私有声明的类型。这也是为什么该规则相对于上一条更为柔和。

If you think the initializer expression&mdash;whatever it is&mdash;is
sufficiently clear, then you may omit the annotation. But if you think
annotating helps make the code clearer, then add one.

如果你认为初始化表达式&mdash;无论是什么表达式&mdash;足够清晰，那么可以省略它的注解。但是
如果你认为注解有助于使代码更清晰，那么你应该加上这个注解。


### AVOID type annotating initialized local variables.

### **避免** 为初始化的局部变量添加类型注解。

{% include linter-rule.html rule="omit_local_variable_types" %}

Local variables, especially in modern code where functions tend to be small,
have very little scope. Omitting the type focuses the reader's attention on the
more important *name* of the variable and its initialized value.

局部变量，特别是现代的函数往往很少，范围也很小。省略局部变量类型会将读者的注意力集中在变量的
*名称*及初始化值上。

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (omit-types-on-locals)"?>
{% prettify dart tag=pre+code %}
List<List<Ingredient>> possibleDesserts(Set<Ingredient> pantry) {
  var desserts = <List<Ingredient>>[];
  for (var recipe in cookbook) {
    if (pantry.containsAll(recipe)) {
      desserts.add(recipe);
    }
  }

  return desserts;
}
{% endprettify %}

{:.bad}
<?code-excerpt "misc/lib/effective_dart/design_bad.dart (omit-types-on-locals)"?>
{% prettify dart tag=pre+code %}
List<List<Ingredient>> possibleDesserts(Set<Ingredient> pantry) {
  List<List<Ingredient>> desserts = <List<Ingredient>>[];
  for (List<Ingredient> recipe in cookbook) {
    if (pantry.containsAll(recipe)) {
      desserts.add(recipe);
    }
  }

  return desserts;
}
{% endprettify %}

If the local variable doesn't have an initializer, then its type can't be
inferred. In that case, it *is* a good idea to annotate. Otherwise, you get
`dynamic` and lose the benefits of static type checking.

如果局部变量没有初始值设定项，那么就无法判断它的类型了。这种情况下，最好是为变量加上类型注解。
否则，你的到的会是一个 `dynamic` 类型，并失去静态类型的好处。


{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (uninitialized-local)"?>
{% prettify dart tag=pre+code %}
List<AstNode> parameters;
if (node is Constructor) {
  parameters = node.signature;
} else if (node is Method) {
  parameters = node.parameters;
}
{% endprettify %}


### AVOID annotating inferred parameter types on function expressions.

### **避免** 在函数表达式上注解推断的参数类型。

{% include linter-rule.html rule="avoid_types_on_closure_parameters" %}

Anonymous functions are almost always immediately passed to a method taking a
callback of some type. (If the function isn't used immediately, it's usually
worth making it a named declaration.) When a function expression is created in a
typed context, Dart tries to infer the function's parameter types based on the
expected type.

匿名函数几乎都是作为一个回调参数类型立即传递给一个方法。（如果一个匿名函数没有立即使用，那么
有必要为它进行命名声明。）当在类型化上下文中创建函数表达式时，Dart 会尝试根据预期类型来推断
函数的参数类型。

For example, when you pass a function expression to `Iterable.map()`, your
function's parameter type is inferred based on the type of callback that `map()`
expects:

例如，当为 `Iterable.map()` 传递一个函数表达式时，函数的参数类型会根据 `map()` 回调中所
期望的类型进行推断。

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (func-expr-no-param-type)"?>
{% prettify dart tag=pre+code %}
var names = people.map((person) => person.name);
{% endprettify %}

{:.bad}
<?code-excerpt "misc/lib/effective_dart/design_bad.dart (func-expr-no-param-type)"?>
{% prettify dart tag=pre+code %}
var names = people.map((Person person) => person.name);
{% endprettify %}

In rare cases, the surrounding context is not precise enough to provide a type
for one or more of the function's parameters. In those cases, you may need to
annotate.

在极少数周围环境不明确的情况下，当无法为一个或多个函数提供参数类型时，需要为它们进行类型注解。

### AVOID redundant type arguments on generic invocations.

### **避免** 在泛型调用中参数类型的冗余使用。

A type argument is redundant if inference would fill in the same type. If the
invocation is the initializer for a type-annotated variable, or is an argument
to a function, then inference usually fills in the type for you:

如果推断的类型结果与指定相同，那么参数指定就是多余的。如果泛型调用是初始化变量，或者是函数参数，
那么推断会自动为其填充类型：

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (redundant)"?>
{% prettify dart tag=pre+code %}
Set<String> things = Set();
{% endprettify %}

{:.bad}
<?code-excerpt "misc/lib/effective_dart/design_bad.dart (redundant)"?>
{% prettify dart tag=pre+code %}
Set<String> things = Set<String>();
{% endprettify %}

Here, the type annotation on the variable is used to infer the type argument of
constructor call in the initializer.

在这里，初始化过程中，构造函数参数的类型是通过变量的类型注解推断得到的。

In other contexts, there isn't enough information to infer the type and then you
should write the type argument:

在其他情况下，如果没有足够的信息来推断类型时，应该为参数添加类型注解：

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (explicit)"?>
{% prettify dart tag=pre+code %}
var things = Set<String>();
{% endprettify %}

{:.bad}
<?code-excerpt "misc/lib/effective_dart/design_bad.dart (explicit)"?>
{% prettify dart tag=pre+code %}
var things = Set();
{% endprettify %}

Here, since the variable has no type annotation, there isn't enough context to
determine what kind of `Set` to create, so the type argument should be provided
explicitly.

在这里，由于变量没有类型注解，因此没有足够的上下文来确定创建的 `Set` 是什么类型，因此应该显式
的提供参数类型。

### DO annotate when Dart infers the wrong type.

### **要** 在 Dart 推断类型错误的时候进行类型注解。

Sometimes, Dart infers a type, but not the type you want. For example, you may
want a variable's type to be a supertype of the initializer's type so that you
can later assign some other sibling type to the variable:

有时候，Dart 推断的并不是你期望的类型。例如，你可能希望初始化变量的类型是超类型（父类的类型），
以便后续可以为变量赋值一些同级别的其它变量：

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (inferred-wrong)"?>
{% prettify dart tag=pre+code %}
num highScore(List<num> scores) {
  num highest = 0;
  for (var score in scores) {
    if (score > highest) highest = score;
  }
  return highest;
}
{% endprettify %}

{:.bad}
<?code-excerpt "misc/lib/effective_dart/design_bad.dart (inferred-wrong)" replace="/ +\/\/ ignore: .*?\n//g"?>
{% prettify dart tag=pre+code %}
num highScore(List<num> scores) {
  var highest = 0;
  for (var score in scores) {
    if (score > highest) highest = score;
  }
  return highest;
}
{% endprettify %}

Here, if `scores` contains doubles, like `[1.2]`, then the assignment to
`highest` will fail since its inferred type is `int`, not `num`. In these cases,
explicit annotations make sense.

在这里，如果 `scores` 中包含双精度数字，如 `[1.2]` ，那么 `highest` 的赋值会失败，因为 
`highest` 的推断类型是 `int` ，而不是 `num` 。在这些情况下，就需要显式注解了。


### PREFER annotating with `dynamic` instead of letting inference fail.

### **推荐** 使用 `dynamic` 注解替换推断失败的情况。

Dart allows you to omit type annotations in many places and will try to infer a
type for you. In some cases, if inference fails, it silently gives you
`dynamic`. If `dynamic` is the type you want, this is technically the most terse
way to get it.

Dart 允许在许多地方省略类型注解，并尝试推断类型。在某些情况下，如果推断失败了，会默认指定为 
`dynamic` 类型。如果 `dynamic` 类型与期望相同，那么从技术的角度来讲，这是获取类型最简洁
的方式。

However, it's not the most *clear* way. A casual reader of your code who sees an
annotation is missing has no way of knowing if you intended it to be `dynamic`,
expected inference to fill in some other type, or simply forgot to write the
annotation.

但是，这种方式是最不*清晰*的。任何一个阅读代码的人，当看到一个类型确实的成员时，是没有办法
知道，编写的人是希望它是 `dynamic` 类型，还是期望它是其他的什么类型，或者阅读的人就简单的
认为是编写的人忘记了指定类型。

When `dynamic` is the type you want, writing it explicitly makes your intent
clear.

当 `dynamic` 是你期望的类型，就应该指明它，这样能让你的意图更清晰。

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (prefer-dynamic)"?>
{% prettify dart tag=pre+code %}
dynamic mergeJson(dynamic original, dynamic changes) => ...
{% endprettify %}

{:.bad}
<?code-excerpt "misc/lib/effective_dart/design_bad.dart (prefer-dynamic)"?>
{% prettify dart tag=pre+code %}
mergeJson(original, changes) => ...
{% endprettify %}


<aside class="alert alert-info" markdown="1">

Before Dart 2, this guideline stated the exact opposite: *don't* annotate with
`dynamic` when it is implicit. With the new stronger type system and type
inference, users now expect Dart to behave like an inferred statically-typed
language. With that mental model, it is an unpleasant surprise to discover that
a region of code has silently lost all of the safety and performance of static
types.

在 Dart 2 之前，本规则恰恰是相反的：*不要* 为隐性类型的成员指定 `dynamic` 注解。基于强类型系统
和类型推断，现在的开发者更希望 Dart 的行为类似于推断的静态类型语言。基于这种心理模型，我们发现
代码区域慢慢地失去了静态类型所具有的安全及性能。

</aside>


### PREFER signatures in function type annotations.

### **推荐** 使 function 类型注解的特征更明显

The identifier `Function` by itself without any return type or parameter
signature refers to the special [Function][] type. This type is only
marginally more useful than using `dynamic`. If you're going to annotate, prefer
a full function type that includes the parameters and return type of the
function.

成员类型注解标识符只有 `Function` ，注解标识符不包括任何返回值类型或参数类型，请参考
专门的 [Function][] 类型说明。使用 `Function` 类型要稍微比使用 `dynamic` 更好些。
如果要使用 `Function` 来进行类型注解，注解类型应该包含函数的所有参数及返回值类型。

[Function]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}/dart-core/Function-class.html

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (avoid-Function)" replace="/bool Function(\(.*?\))?/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
bool isValid(String value, [!bool Function(String)!] test) => ...
{% endprettify %}

{:.bad}
<?code-excerpt "misc/lib/effective_dart/design_bad.dart (avoid-Function)" replace="/Function/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
bool isValid(String value, [!Function!] test) => ...
{% endprettify %}

[fn syntax]: #prefer-inline-function-types-over-typedefs

**Exception:** Sometimes, you want a type that represents the union of multiple
different function types. For example, you may accept a function that takes one
parameter or a function that takes two. Since we don't have union types, there's
no way to precisely type that and you'd normally have to use `dynamic`.
`Function` is at least a little more helpful than that:

此条规则有个例外，如果期望一个类型能够表示多种函数类型的集合。例如，我们希望接受的可能是一个参数
的函数，也可能是两个参数的函数。由于 Dart 没有集合类型，所以没有办法为类似成员精确的指定类型，
这个时候通常只能使用 `dynamic`。但这里使用 `Function` 要稍微比使用 `dynamic` 更有帮助些：

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (function-arity)" replace="/(void )?Function(\(.*?\))?/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
void handleError([!void Function()!] operation, [!Function!] errorHandler) {
  try {
    operation();
  } catch (err, stack) {
    if (errorHandler is [!Function(Object)!]) {
      errorHandler(err);
    } else if (errorHandler is [!Function(Object, StackTrace)!]) {
      errorHandler(err, stack);
    } else {
      throw ArgumentError("errorHandler has wrong signature.");
    }
  }
}
{% endprettify %}


### DON'T specify a return type for a setter.

### **不要** 为 setter 方法指定返回类型。

{% include linter-rule.html rule="avoid_return_types_on_setters" %}

Setters always return `void` in Dart. Writing the word is pointless.

在 Dart 中，setter 永远返回 `void` 。为 setter 指定类型没有意义。

{:.bad}
<?code-excerpt "misc/lib/effective_dart/design_bad.dart (avoid_return_types_on_setters)"?>
{% prettify dart tag=pre+code %}
void set foo(Foo value) { ... }
{% endprettify %}

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (avoid_return_types_on_setters)"?>
{% prettify dart tag=pre+code %}
set foo(Foo value) { ... }
{% endprettify %}


### DON'T use the legacy typedef syntax.

### **不要** 使用弃用的 typedef 语法。

{% include linter-rule.html rule="prefer_generic_function_type_aliases" %}

Dart has two notations for defining a named typedef for a function type. The
original syntax looks like:

Dart 有两种为函数类型定义命名 typedef 注解语法。 原始语法如下：

{:.bad}
<?code-excerpt "misc/lib/effective_dart/design_bad.dart (old-typedef)"?>
{% prettify dart tag=pre+code %}
typedef int Comparison<T>(T a, T b);
{% endprettify %}

That syntax has a couple of problems:

该语法有几个问题：

*   There is no way to assign a name to a *generic* function type. In the above
    example, the typedef itself is generic. If you reference `Comparison` in
    your code, without a type argument, you implicitly get the function type
    `int Function(dynamic, dynamic)`, *not* `int Function<T>(T, T)`. This
    doesn't come up in practice often, but it matters in certain corner cases.

    无法为一个*泛型*函数类型指定名称。在上面的例子中，typedef 自己就是泛型。如果在代码中去
    引用 `Comparison` 却不指定参数类型，那么你会隐式的得到一个 `int Function(dynamic, dynamic)`
    类型的函数，*而不是* `int Function<T>(T, T)` 。在实际应用中虽然不常用，但是在极少数
    情况下是很重要的。

*   A single identifier in a parameter is interpreted as the parameter's *name*,
    not its *type*. Given:

    参数中的单个标识符会被认为是参数名称，而不是参数类型。参考下面代码：

    {:.bad}
    <?code-excerpt "misc/lib/effective_dart/design_bad.dart (typedef-param)"?>
    {% prettify dart tag=pre+code %}
    typedef bool TestNumber(num);
    {% endprettify %}

    Most users expect this to be a function type that takes a `num` and returns
    `bool`. It is actually a function type that takes *any* object (`dynamic`)
    and returns `bool`. The parameter's *name* (which isn't used for anything
    except documentation in the typedef) is "num". This has been a
    long-standing source of errors in Dart.

    大多数用户希望这是一个接受 `num` 返回 `bool` 的函数类型。但它实际上是一个接受*任何*
    对象（`dynamic`）返回 `bool` 的类型。 "num" 是参数*名称*（ 它除了被用在 typedef 的
    声明代码中，再也没有其他作用）。这个错误在 Dart 中存在了很长时间。

The new syntax looks like this:

新语法如下所示：

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (new-typedef)"?>
{% prettify dart tag=pre+code %}
typedef Comparison<T> = int Function(T, T);
{% endprettify %}

If you want to include a parameter's name, you can do that too:

如果想在方法中包含参数名称，可以这样做：

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (new-typedef-param-name)"?>
{% prettify dart tag=pre+code %}
typedef Comparison<T> = int Function(T a, T b);
{% endprettify %}

The new syntax can express anything the old syntax could express and more, and
lacks the error-prone misfeature where a single identifier is treated as the
parameter's name instead of its type. The same function type syntax after the
`=` in the typedef is also allowed anywhere a type annotation may appear, giving
us a single consistent way to write function types anywhere in a program.

新语法可以表达旧语法所表达的任何内容，并且避免了单个标识符会被认为是参数类型的常见错误。同一个函数
类型语法（typedef 中 `=` 之后的部分）允许出现在任何类型注解可以能出现的地方。这样在程序的任何位置，
我们都可以以一致的方式来书写函数类型。

The old typedef syntax is still supported to avoid breaking existing code, but
it's deprecated.

为了避免对已有代码产生破坏， typedef 的旧语法依旧支持。但已被弃用。


### PREFER inline function types over typedefs.

### **推荐** 优先使用内联函数类型，而后是 typedef 。

{% include linter-rule.html rule="avoid_private_typedef_functions" %}

In Dart 1, if you wanted to use a function type for a field, variable, or
generic type argument, you had to first define a typedef for it. Dart 2 supports
a function type syntax that can be used anywhere a type annotation is allowed:

在 Dart 1 中，如果要在字段，变量或泛型参数中使用函数类型，首选需要使用 typedef 定义这个类型。
Dart 2 中任何使用类型注解的地方都可以使用函数类型声明语法：

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (function-type)"  replace="/(bool|void) Function\(Event\)/[!$&!]/g"?>
{% prettify dart tag=pre+code %}
class FilteredObservable {
  final [!bool Function(Event)!] _predicate;
  final List<[!void Function(Event)!]> _observers;

  FilteredObservable(this._predicate, this._observers);

  [!void Function(Event)!] notify(Event event) {
    if (!_predicate(event)) return null;

    [!void Function(Event)!] last;
    for (var observer in _observers) {
      observer(event);
      last = observer;
    }

    return last;
  }
}
{% endprettify %}

It may still be worth defining a typedef if the function type is particularly
long or frequently used. But in most cases, users want to see what the function
type actually is right where it's used, and the function type syntax gives them
that clarity.

如果函数类型特别长或经常使用，那么还是有必要使用 typedef 进行定义。但在大多数情况下，使用者
更希望知道函数使用时的真实类型，这样函数类型语法使它们清晰。


### CONSIDER using function type syntax for parameters.

### **考虑** 在参数上使用函数类型语法。

{% include linter-rule.html rule="use_function_type_syntax_for_parameters" %}

Dart has a special syntax when defining a parameter whose type is a function.
Sort of like in C, you surround the parameter's name with the function's return
type and parameter signature:

在定义参数为函数类型时， Dart 具有特殊的语法。与 C 类似，使用参数名称作为函数参数的函数名：

<?code-excerpt "misc/lib/effective_dart/design_bad.dart (function-type-param)"?>
{% prettify dart tag=pre+code %}
Iterable<T> where(bool predicate(T element)) => ...
{% endprettify %}

Before Dart 2 added function type syntax, this was the only way to give a
parameter a function type without defining a typedef. Now that Dart has a
general notation for function types, you can use it for function-typed
parameters as well:

在 Dart 2 添加函数类型语法之前，如果希望不通过 typedef 使用函数参数类型，上例是唯一的方法。
如今 Dart 已经可以为函数提供泛型注解，那么也可以将泛型注解用于函数类型参数中：

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (function-type-param)"?>
{% prettify dart tag=pre+code %}
Iterable<T> where(bool Function(T) predicate) => ...
{% endprettify %}

The new syntax is a little more verbose, but is consistent with other locations
where you must use the new syntax.

虽然新语法稍微冗长一点，但是你必须使用新语法才能与其他位置的类型注解的语法保持一致。

### AVOID using `dynamic` unless you want to disable static checking.

### **要** 为类型是任何对象的参数使用 `Object` 注解，而不是 `dynamic` 。

Some operations work with any possible object. For example, a `log()` method
could take any object and call `toString()` on it. Two types in Dart permit all
values: `Object` and `dynamic`. However, they convey different things. If you
simply want to state that you allow all objects, use `Object`, as you would in
Java or C#.

某些操作适用于任何对象。例如，`log()` 方法可以接受任何对象，并调用对象上的 `toString()` 方法。
在 Dart 中两种类型可以表示所有类型：`Object` 和 `dynamic` 。但是，他们传达的意义并不相同。
和 Java 或 C# 类似，要表示成员类型为所有对象，使用 `Object` 进行注解。

The type `dynamic` not only accepts all objects, but it also permits all
*operations*. Any member access on a value of type `dynamic` is allowed at
compile time, but may fail and throw an exception at runtime. If you want
exactly that risky but flexible dynamic dispatch, then `dynamic` is the right
type to use.

`dynamic` 这个类型不仅接受所有对象，也允许所有 *operations*。
在编译时任何成员对 `dynamic` 类型值访问是允许的，但在运行时可能会引发异常。
如果你可以承担风险来达到灵活性，`dynamic` 类型是你不错的选择。

Otherwise, prefer using `Object`. Rely on `is` checks and type promotion to
ensure that the value's runtime type supports the member you want to access
before you access it.

除此之外，我们建议你使用 `Object`，并使用 `is` 来检查和进行类型升级，
以确保在运行时访问判断这个值支持您要访问的成员。

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (Object-vs-dynamic)"?>
{% prettify dart tag=pre+code %}
/// Returns a Boolean representation for [arg], which must
/// be a String or bool.
bool convertToBool(Object arg) {
  if (arg is bool) return arg;
  if (arg is String) return arg.toLowerCase() == 'true';
  throw ArgumentError('Cannot convert $arg to a bool.');
}
{% endprettify %}

The main exception to this rule is when working with existing APIs that use
`dynamic`, especially inside a generic type. For example, JSON objects have type
`Map<String, dynamic>` and your code will need to accept that same type. Even
so, when using a value from one of these APIs, it's often a good idea to cast it
to a more precise type before accessing members.

这个规则的主要例外是，与已经使用 `dynamic` 的类型，特别是通用类进行操作的时候。
比如，JSON 对象有 `Map<String, dynamic>` 类型，而且代码需要接受相同的类型。
即便如此，在调用和使用这些 API 的时候，将类型转换成一个更精确的类型之后
再去调用成员会更好。

### DO use `Future<void>` as the return type of asynchronous members that do not produce values.

### **要** 使用 `Future<void>` 作为无法回值异步成员的返回类型。

When you have a synchronous function that doesn't return a value, you use `void`
as the return type. The asynchronous equivalent for a method that doesn't
produce a value, but that the caller might need to await, is `Future<void>`.

对于不返回值得同步函数，要使用 `void` 作为返回类型。对于需要等待的，但无返回值的异步方法方法，
使用 `Future<void>` 作为返回值类型。

You may see code that uses `Future` or `Future<Null>` instead because older
versions of Dart didn't allow `void` as a type argument. Now that it does, you
should use it. Doing so more directly matches how you'd type a similar
synchronous function, and gives you better error-checking for callers and in the
body of the function.

你可能会见到使用 `Future` 或 `Future<Null>` 作为返回值类型，这是因为旧版本的 Dart 不允许
`void` 作为类型参数。既然现在允许了，那么就应该使用新的方式。使用新的方式能够更直接地匹配那些
已经指定了类型的同步函数，并在函数体中为调用者提供更好的错误检查。

For asynchronous functions that do not return a useful value and where no
callers need to await the asynchronous work or handle an asynchronous failure,
use a return type of `void`.

对于一些异步函数，这些异步函数不会返回有用的值，而且不需要等待异步执行结束或不需要处理错误结果。
那么使用 `void` 作为这些异步函数的返回类型。


### AVOID using `FutureOr<T>` as a return type.

### **避免** 使用 `FutureOr<T>` 作为返回类型。

If a method accepts a `FutureOr<int>`, it is [generous in what it
accepts][postel]. Users can call the method with either an `int` or a
`Future<int>`, so they don't need to wrap an `int` in `Future` that you are
going to unwrap anyway.

如果一个方法接受了一个 `FutureOr<int>` 参数，那么 [参数接受的类型范围就会变大][postel] 。使用者
可以使用 `int` 或者 `Future<int>` 来调用这个方法，所以调用这个方法时就不用把 `int` 包装到一个
`Future` 中再传到方法中。而在方法中这个参数一定会进行被解包处理。

[postel]: https://en.wikipedia.org/wiki/Robustness_principle

If you *return* a `FutureOr<int>`, users need to check whether get back an `int`
or a `Future<int>` before they can do anything useful. (Or they'll just `await`
the value, effectively always treating it as a `Future`.) Just return a
`Future<int>`, it's cleaner. It's easier for users to understand that a function
is either always asynchronous or always synchronous, but a function that can be
either is hard to use correctly.

如果是*返回*一个 `FutureOr<int>` 类型的值，那么方法调用者在做任何有意义的操作之前，需要检查
返回值是一个 `int` 还是 `Future<int>` （或者调用者仅 `await` 得到一个值，却把它当做了 
`Future` ）。返回值使用 `Future<int>` ，类型就清晰了。一个函数要么一直异步，要么一直是同步，
这样才能够让调用者更容易理解，否则这个函数很难被正确的使用。

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (future-or)"?>
{% prettify dart tag=pre+code %}
Future<int> triple(FutureOr<int> value) async => (await value) * 3;
{% endprettify %}

{:.bad}
<?code-excerpt "misc/lib/effective_dart/design_bad.dart (future-or)"?>
{% prettify dart tag=pre+code %}
FutureOr<int> triple(FutureOr<int> value) {
  if (value is int) return value * 3;
  return (value as Future<int>).then((v) => v * 3);
}
{% endprettify %}

The more precise formulation of this guideline is to *only use `FutureOr<T>` in
[contravariant][] positions.* Parameters are contravariant and return types are
covariant. In nested function types, this gets flipped&mdash;if you have a
parameter whose type is itself a function, then the callback's return type is
now in contravariant position and the callback's parameters are covariant. This
means it's OK for a *callback's* type to return `FutureOr<T>`:

对这条规则更准确的描述是，*仅在 [逆变][contravariant] 位置使用 `FutureOr<T>` *。参数是逆变（contravariant），
返回类型是协变（covariant）。在嵌套函数类型中，描述是相反的&mdash;如果一个参数自身就是函数参数类型，那么此时
回调函数的返回类型处于逆变位置，回调函数的参数是协变。这意味着回调中的函数类型可以返回 `FutureOr<T>` ：

[contravariant]: https://en.wikipedia.org/wiki/Covariance_and_contravariance_(computer_science)

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (future-or-contra)" replace="/FutureOr.S./[!$&!]/g"?>
{% prettify dart tag=pre+code %}
Stream<S> asyncMap<T, S>(
    Iterable<T> iterable, [!FutureOr<S>!] Function(T) callback) async* {
  for (var element in iterable) {
    yield await callback(element);
  }
}
{% endprettify %}


## Parameters

## 参数

In Dart, optional parameters can be either positional or named, but not both.

在 Dart 中，可选参数可以是位置参数，也可以是命名参数，但不能两者都是。

### AVOID positional boolean parameters.

### **避免** 布尔类型的位置参数。

{% include linter-rule.html rule="avoid_positional_boolean_parameters" %}

Unlike other types, booleans are usually used in literal form. Things like
numbers are usually wrapped in named constants, but we usually just pass around
`true` and `false` directly. That can make callsites unreadable if it isn't
clear what the boolean represents:

与其他类型不同，布尔值通常以字面量方式使用。数字值的通常可以包含在命名的常量里，但对于布尔值通常
喜欢直接传 `true` 和 `false` 。如果不清楚布尔值的含义，这样会造成调用者的代码不可读：

{:.bad}
{% prettify dart tag=pre+code %}
new Task(true);
new Task(false);
new ListBox(false, true, true);
new Button(false);
{% endprettify %}

Instead, consider using named arguments, named constructors, or named constants
to clarify what the call is doing.

这里，应该考虑使用命名参数，命名构造函数或命名常量来阐明调用所执行的操作。

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (avoid-positional-bool-param)"?>
{% prettify dart tag=pre+code %}
Task.oneShot();
Task.repeating();
ListBox(scroll: true, showScrollbars: true);
Button(ButtonState.enabled);
{% endprettify %}

Note that this doesn't apply to setters, where the name makes it clear what the
value represents:

请注意，这并不适用于 setter ，因为 setter 的名称能够清楚的阐明值得含义：

{:.good}
{% prettify dart tag=pre+code %}
listBox.canScroll = true;
button.isEnabled = false;
{% endprettify %}


### AVOID optional positional parameters if the user may want to omit earlier parameters.

### **避免** 在调用者需要省略前面参数的方法中，使用位置可选参数。

Optional positional parameters should have a logical progression such that
earlier parameters are passed more often than later ones. Users should almost
never need to explicitly pass a "hole" to omit an earlier positional argument to
pass later one. You're better off using named arguments for that.

可选的位置参数应该具有逻辑性，前面参数应该比后面的参数使用更频繁。调用者不需要刻意的跳过或省略前面
的一个参数而为后面的参数赋值。如果需要省略前面参数，这种情况最好使用命名可选参数。

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (omit-optional-positional)"?>
{% prettify dart tag=pre+code %}
String.fromCharCodes(Iterable<int> charCodes, [int start = 0, int end]);

DateTime(int year,
    [int month = 1,
    int day = 1,
    int hour = 0,
    int minute = 0,
    int second = 0,
    int millisecond = 0,
    int microsecond = 0]);

Duration(
    {int days = 0,
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
    int milliseconds = 0,
    int microseconds = 0});
{% endprettify %}


### AVOID mandatory parameters that accept a special "no argument" value.

### **避免** 强制参数去接受一个特定表示"空参数"的值。

If the user is logically omitting a parameter, prefer letting them actually omit
it by making the parameter optional instead of forcing them to pass `null`, an
empty string, or some other special value that means "did not pass".

如果调用者在逻辑上省略了参数，那么建议使用可选参数的方式让这些参数能够实际性的被省略，而不是
强制让调用者去为他们传入 `null`，或者空字符串，或者是一些其他特殊的值来表示该参数"不需要传值"。

Omitting the parameter is more terse and helps prevent bugs where a sentinel
value like `null` is accidentally passed when the user thought they were
providing a real value.

省略参数更加简洁，也有助于防止在调用者偶然地将 `null` 作为实际值传递到方法中而引起 bug。

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (avoid-mandatory-param)"?>
{% prettify dart tag=pre+code %}
var rest = string.substring(start);
{% endprettify %}

{:.bad}
<?code-excerpt "misc/lib/effective_dart/design_bad.dart (avoid-mandatory-param)"?>
{% prettify dart tag=pre+code %}
var rest = string.substring(start, null);
{% endprettify %}


### DO use inclusive start and exclusive end parameters to accept a range.

### **要** 使用开始为闭区间，结束为开区间的半开半闭区间作为接受范围。

If you are defining a method or function that lets a user select a range of
elements or items from some integer-indexed sequence, take a start index, which
refers to the first item and a (likely optional) end index which is one greater
than the index of the last item.

如果定义一个方法或函数来让调用者能够从某个整数索引序列中选择一系列元素或项，开始索引指向的元素
为选取的第一个元素，结束索引（可以为可选参数）指向元素的上一个元素为获取的最后一个元素。

This is consistent with core libraries that do the same thing.

这种方式与核心库一致。

{:.good}
<?code-excerpt "misc/test/effective_dart_test.dart (param-range)" replace="/expect\(//g; /, \/\*\*\// \/\//g; /\);//g"?>
{% prettify dart tag=pre+code %}
[0, 1, 2, 3].sublist(1, 3) // [1, 2]
'abcd'.substring(1, 3) // 'bc'
{% endprettify %}

It's particularly important to be consistent here because these parameters are
usually unnamed. If your API takes a length instead of an end point, the
difference won't be visible at all at the callsite.

在这里保持一致尤为重要，因为这些参数通常是未命名参数。如果你的 API 中第二个参数使用了长度值，
而不是结束索引，那么在调用端是无法区分两者之间的差异的。

## Equality

## 相等

Implementing custom equality behavior for a class can be tricky. Users have deep
intuition about how equality works that your objects need to match, and
collection types like hash tables have subtle contracts that they expect
elements to follow.

可能为类实现自定义相等的判定是比较棘手事情。用户对于对象的判等情况有着很深的直觉，同时像哈希表这样
的集合类型拥有一些细微的规则，包含在这些集合中的元素需要遵循这些规则。

### DO override `hashCode` if you override `==`.

### **要** 对重写 `==` 操作符的类，重写 `hashCode` 方法。

{% include linter-rule.html rule="hash_and_equals" %}

The default hash code implementation provides an *identity* hash&mdash;two
objects generally only have the same hash code if they are the exact same
object. Likewise, the default behavior for `==` is identity.

默认的哈希实现为对象提供了一个*身份*哈希&mdash;如果两个对象是完全相同的，那么它们通常具有
相同的哈希值。同样，`==` 的默认行为是比较两个对象的身份哈希。

If you are overriding `==`, it implies you may have different objects that are
considered "equal" by your class. **Any two objects that are equal must have the
same hash code.** Otherwise, maps and other hash-based collections will fail to
recognize that the two objects are equivalent.

如果你重写 `==` ，就意味着你可能有不同的对象要让你的类认为是"相等的"。**任何两个对象要相等就
必须必须具有相同的哈希值。** 否则，这两个对象就无法被 map 和其他基于哈希的集合识别为等效对象。

### DO make your `==` operator obey the mathematical rules of equality.

### **要** 让 `==` 操作符的相等遵守数学规则。

An equivalence relation should be:

等价关系应该是：

* **Reflexive**: `a == a` should always return `true`.

  **自反性**: `a == a` 应该始终返回 `true`。

* **Symmetric**: `a == b` should return the same thing as `b == a`.

  **对称性**: `a == b` 应该与 `b == a` 的返回值相同。

* **Transitive**: If `a == b` and `b == c` both return `true`, then `a == c`
  should too.

  **传递性**: If `a == b` 和 `b == c` 都返回 `true`，那么 `a == c`
  也应该返回 `true` 。

Users and code that uses `==` expect all of these laws to be followed. If your
class can't obey these rules, then `==` isn't the right name for the operation
you're trying to express.

### AVOID defining custom equality for mutable classes.

### **避免** 为可变类自定义相等。

{% include linter-rule.html rule="avoid_equals_and_hash_code_on_mutable_classes" %}

When you define `==`, you also have to define `hashCode`. Both of those should
take into account the object's fields. If those fields *change* then that
implies the object's hash code can change.

定义 `==` 时，必须要定义 `hashCode` 。两者都需要考虑对象的字段。如果这些字段发生了变化，
则意味着对象的哈希值可能会改变。

Most hash-based collections don't anticipate that&mdash;they assume an object's
hash code will be the same forever and may behave unpredictably if that isn't
true.

大多数基于哈希的集合是无法预料元素哈希值的改变&mdash;他们假设元素对象的哈希值是永远不变的，
如果元素哈希值发生了改变，可能会出现不可预测的结果

### DON'T check for `null` in custom `==` operators.

### **不要** 在自定义 `==` 操作符中检查 `null` 。

{% include linter-rule.html rule="avoid_null_checks_in_equality_operators" %}

The language specifies that this check is done automatically and your `==`
method is called only if the right-hand side is not `null`.

Dart 指定此检查是自动完成的，只有当右侧不是 `null` 时才调用 `==` 方法。

{:.good}
<?code-excerpt "misc/lib/effective_dart/design_good.dart (eq-dont-check-for-null)" replace="/operator ==/[!$&!]/g" plaster?>
{% prettify dart tag=pre+code %}
class Person {
  final String name;
  // ···
  bool [!operator ==!](other) => other is Person && name == other.name;

  int get hashCode => name.hashCode;
}
{% endprettify %}

{:.bad}
<?code-excerpt "misc/lib/effective_dart/design_bad.dart (eq-dont-check-for-null)" replace="/\w+ != null/[!$&!]/g" plaster?>
{% prettify dart tag=pre+code %}
class Person {
  final String name;
  // ···
  bool operator ==(other) => [!other != null!] && ...
}
{% endprettify %}

