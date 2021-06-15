---
title: "Effective Dart: Documentation"
title: 高效 Dart 语言指南：文档
description: Clear, helpful comments and documentation.
description: 简洁实用的注释以及文档。
nextpage:
  url: /guides/language/effective-dart/usage
  title: Usage
  title: 用法示例
prevpage:
  url: /guides/language/effective-dart/style
  title: Style
  title: 代码风格
---

<?code-excerpt path-base="../null_safety_examples/misc/lib/effective_dart"?>

It's easy to think your code is obvious today without realizing how much you
rely on context already in your head. People new to your code, and
even your forgetful future self won't have that context. A concise, accurate
comment only takes a few seconds to write but can save one of those people
hours of time.

你可能没有意识到，今天你很容易想出来的代码，有多么依赖你当时思路。
人们不熟悉你的代码，甚至你也忘记了当时代码功能中有这样的思路。
简明，扼要的注释只需花费几秒钟的时间去写，但可以让每个这样的人节约几个小时。

We all know code should be self-documenting and not all comments are helpful.
But the reality is that most of us don't write as many comments as we should.
It's like exercise: you technically *can* do too much, but it's a lot more
likely that you're doing too little. Try to step it up.

我们知道代码应该自文档（self-documenting），并不是所有的注释都是有用的。
但实际情况是，我们大多数人都没有写出尽可能多的注释。
和练习一样：从技术上你*可以*做很多，但是实际上你
只做了一点点。尝试着逐步提高。

## Comments

## 注释

The following tips apply to comments that you don't want included in the
generated documentation.

下面的提示适用于不被生成在文档中的注释。

### DO format comments like sentences.

### **要** 像句子一样来格式化注释。

{:.good}
<?code-excerpt "docs_good.dart (comments-like-sentences)"?>
{% prettify dart tag=pre+code %}
// Not if there is nothing before it.
if (_chunks.isEmpty) return false;
{% endprettify %}

Capitalize the first word unless it's a case-sensitive identifier. End it with a
period (or "!" or "?", I suppose). This is true for all comments: doc comments,
inline stuff, even TODOs. Even if it's a sentence fragment.

如果第一个单词不是大小写相关的标识符，则首字母要大写。
使用句号，叹号或者问号结尾。所有的注释都应该这样：
文档注释，单行注释，甚至 TODO。即使它是一个句子的片段。

### DON'T use block comments for documentation.

### **不要** 使用块注释作用作解释说明。

{:.good}
<?code-excerpt "docs_good.dart (block-comments)"?>
{% prettify dart tag=pre+code %}
void greet(String name) {
  // Assume we have a valid name.
  print('Hi, $name!');
}
{% endprettify %}

{:.bad}
<?code-excerpt "docs_bad.dart (block-comments)"?>
{% prettify dart tag=pre+code %}
void greet(String name) {
  /* Assume we have a valid name. */
  print('Hi, $name!');
}
{% endprettify %}

You can use a block comment (`/* ... */`) to temporarily comment out a section
of code, but all other comments should use `//`.

可以使用块注释 (`/* ... */`) 来临时的注释掉一段代码，
但是其他的所有注释都应该使用 `//`。

## Doc comments

## 文档注释

Doc comments are especially handy because [dartdoc][] parses them and generates
[beautiful doc pages][docs] from them. A doc comment is any comment that appears
before a declaration and uses the special `///` syntax that dartdoc looks for.

文档注释特别有用，应为通过 [dartdoc][] 解析这些注释可以生成 [漂亮的文档网页][docs]。
文档注释包括所有出现在声明之前并使用 `///` 语法的注释，这些注释使用使用 dartdoc 检索。

[dartdoc]: https://github.com/dart-lang/dartdoc
[docs]: {{site.dart_api}}/{{site.data.pkg-vers.SDK.channel}}

### DO use `///` doc comments to document members and types.

### **要** 使用 `///` 文档注释来注释成员和类型。

{% include linter-rule.html rule="slash_for_doc_comments" %}

Using a doc comment instead of a regular comment enables [dartdoc][] to find it
and generate documentation for it.

使用文档注释可以让 [dartdoc][] 来为你生成代码 API 文档。

{:.good}
<?code-excerpt "docs_good.dart (use-doc-comments)"?>
{% prettify dart tag=pre+code %}
/// The number of characters in this chunk when unsplit.
int get length => ...
{% endprettify %}

{:.bad}
<?code-excerpt "docs_good.dart (use-doc-comments)" replace="/^\///g"?>
{% prettify dart tag=pre+code %}
// The number of characters in this chunk when unsplit.
int get length => ...
{% endprettify %}

For historical reasons, dartdoc supports two syntaxes of doc comments: `///`
("C# style") and `/** ... */` ("JavaDoc style"). We prefer `///` because it's
more compact. `/**` and `*/` add two content-free lines to a multiline doc
comment. The `///` syntax is also easier to read in some situations, such as
when a doc comment contains a bulleted list that uses `*` to mark list items.

由于历史原因，dartdoc 支持两种格式的文档注释：`///` ("C# 格式") 和 `/** ... */` ("JavaDoc 格式")。
我们推荐使用 `///` 是因为其更加简洁。
`/**` 和 `*/` 在多行注释中间添加了开头和结尾的两行多余内容。
`///` 在一些情况下也更加易于阅读，例如，当文档注释中包含有使用 `*` 标记的列表内容的时候。

If you stumble onto code that still uses the JavaDoc style, consider cleaning it
up.

如果你现在还在使用 JavaDoc 风格格式，请考虑使用新的格式。

### PREFER writing doc comments for public APIs.

### **推荐** 为公开发布的 API 编写文档注释。

{% include linter-rule.html rule1="package_api_docs" rule2="public_member_api_docs"%}

You don't have to document every single library, top-level variable, type, and
member, but you should document most of them.

不必为所有独立的库，顶级变量，类型以及成员编写文档注释。
但是它们大多数应该有文档注释。

### CONSIDER writing a library-level doc comment.

### **考虑** 编写库级别（library-level）的文档注释。

Unlike languages like Java where the class is the only unit of program
organization, in Dart, a library is itself an entity that users work with
directly, import, and think about. That makes the `library` directive a great
place for documentation that introduces the reader to the main concepts and
functionality provided within. Consider including:

与Java等类似的语言不同，Java 中类是程序组织的唯一单元。
在 Dart 中，库本身就是一个实体，用户可以直接使用，导入及构思它。
这使得`库`成为一个展示文档的好地方。
这样可以向读者介绍其中提供的主要概念和功能。
其中可以考虑包括下列内容：

* A single-sentence summary of what the library is for.

  关于库用途的单句摘要。

* Explanations of terminology used throughout the library.
  
  解释库中用到的术语。

* A couple of complete code samples that walk through using the API.

  一些配合 API 的示例代码。

* Links to the most important or most commonly used classes and functions.

  最重要和最常用的类和函数的链接。

* Links to external references on the domain the library is concerned with.

  和库相关领域的外部链接。

You document a library by placing a doc comment right above the `library`
directive at the start of the file. If the library doesn't have a `library`
directive, you can add one just to hang the doc comment off of it.

你可以通过在文件开头的 `library` 的上方放置 doc 注释来文档注释一个库。
如果库没有 `library` 指令，您可以添加一个，只是挂起 doc 注释。

### CONSIDER writing doc comments for private APIs.

### **推荐** 为私有API 编写文档注释。

Doc comments aren't just for external consumers of your library's public API.
They can also be helpful for understanding private members that are called from
other parts of the library.

文档注释不仅仅适用于外部用户使用你库的公开 API.
它也同样有助于理解那些私有成员，这些私有成员会被库的其他部分调用。

### DO start doc comments with a single-sentence summary.

### **要** 要在文档注释开头有一个单句总结。

Start your doc comment with a brief, user-centric description ending with a
period. A sentence fragment is often sufficient. Provide just enough context for
the reader to orient themselves and decide if they should keep reading or look
elsewhere for the solution to their problem.

注释文档要以一个以用户为中心，简要的描述作为开始。
通常句子片段就足够了。为读者提供足够的上下文来定位自己，
并决定是否应该继续阅读，或寻找其他解决问题的方法。

{:.good}
<?code-excerpt "docs_good.dart (first-sentence)"?>
{% prettify dart tag=pre+code %}
/// Deletes the file at [path] from the file system.
void delete(String path) {
  ...
}
{% endprettify %}

{:.bad}
<?code-excerpt "docs_bad.dart (first-sentence)"?>
{% prettify dart tag=pre+code %}
/// Depending on the state of the file system and the user's permissions,
/// certain operations may or may not be possible. If there is no file at
/// [path] or it can't be accessed, this function throws either [IOError]
/// or [PermissionError], respectively. Otherwise, this deletes the file.
void delete(String path) {
  ...
}
{% endprettify %}

### DO separate the first sentence of a doc comment into its own paragraph.

### **要** 让文档注释的第一句从段落中分开。 

Add a blank line after the first sentence to split it out into its own
paragraph. If more than a single sentence of explanation is useful, put the
rest in later paragraphs.

在第一句之后添加一个空行，将其拆分为自己的段落。 
如果不止一个解释句子有用，请将其余部分放在后面的段落中。

This helps you write a tight first sentence that summarizes the documentation.
Also, tools like dartdoc use the first paragraph as a short summary in places
like lists of classes and members.

这有助于您编写一个紧凑的第一句话来总结文档。 
此外，像Dartdoc这样的工具使用第一段作为类和类成员列表等地方的简短摘要。

{:.good}
<?code-excerpt "docs_good.dart (first-sentence-a-paragraph)"?>
{% prettify dart tag=pre+code %}
/// Deletes the file at [path].
///
/// Throws an [IOError] if the file could not be found. Throws a
/// [PermissionError] if the file is present but could not be deleted.
void delete(String path) {
  ...
}
{% endprettify %}

{:.bad}
<?code-excerpt "docs_bad.dart (first-sentence-a-paragraph)"?>
{% prettify dart tag=pre+code %}
/// Deletes the file at [path]. Throws an [IOError] if the file could not
/// be found. Throws a [PermissionError] if the file is present but could
/// not be deleted.
void delete(String path) {
  ...
}
{% endprettify %}

### AVOID redundancy with the surrounding context.

### **避免** 与周围上下文冗余。

The reader of a class's doc comment can clearly see the name of the class, what
interfaces it implements, etc. When reading docs for a member, the signature is
right there, and the enclosing class is obvious. None of that needs to be
spelled out in the doc comment. Instead, focus on explaining what the reader
*doesn't* already know.

阅读类的文档注释的可以清楚地看到类的名称，它实现的接口等等。
当读取成员的文档时，命名和封装它的类是显而易见的。 
这些都不需要写在文档注释中。 
相反，应该专注于解释读者所*不知道*的内容。

{:.good}
<?code-excerpt "docs_good.dart (redundant)"?>
{% prettify dart tag=pre+code %}
class RadioButtonWidget extends Widget {
  /// Sets the tooltip to [lines], which should have been word wrapped using
  /// the current font.
  void tooltip(List<String> lines) {
    ...
  }
}
{% endprettify %}

{:.bad}
<?code-excerpt "docs_bad.dart (redundant)"?>
{% prettify dart tag=pre+code %}
class RadioButtonWidget extends Widget {
  /// Sets the tooltip for this radio button widget to the list of strings in
  /// [lines].
  void tooltip(List<String> lines) {
    ...
  }
}
{% endprettify %}

If you really don't have anything interesting to say
that can't be inferred from the declaration itself,
then omit the doc comment.
It's better to say nothing
than waste a reader's time telling them something they already know.


### PREFER starting function or method comments with third-person verbs.

### **推荐** 用第三人称来开始函数或者方法的文档注释。

The doc comment should focus on what the code *does*.

注释应该关注于代码 *所实现的* 功能。

{:.good}
<?code-excerpt "docs_good.dart (third-person)"?>
{% prettify dart tag=pre+code %}
/// Returns `true` if every element satisfies the [predicate].
bool all(bool predicate(T element)) => ...

/// Starts the stopwatch if not already running.
void start() {
  ...
}
{% endprettify %}

### PREFER starting variable, getter, or setter comments with noun phrases.

### **推荐** 使用名词短语来开始变量、getter、setter 的注释。

The doc comment should stress what the property *is*. This is true even for
getters which may do calculation or other work. What the caller cares about is
the *result* of that work, not the work itself.

注释文档应该表述这个属性*是*什么。虽然 getter 函数会做些计算，
但是也要求这样，调用者关心的是其*结果*而不是如何计算的。

{:.good}
<?code-excerpt "docs_good.dart (noun-phrases-for-var-etc)"?>
{% prettify dart tag=pre+code %}
/// The current day of the week, where `0` is Sunday.
int weekday;

/// The number of checked buttons on the page.
int get checkedCount => ...
{% endprettify %}

If a property has both a getter and a setter, then create a doc comment for
only one of them. Dartdoc treats the getter and setter like a single field,
and if both the getter and the setter have doc comments, then
dartdoc discards the setter's doc comment.

如果一个属性同时包含 getter 和 setter，请只为其中一个添加文档。
Dartdoc 会将 getter 和 setter 作为同一个属性进行处理，而如果它们
都包含文档注释，setter 的文档将被忽略。

### PREFER starting library or type comments with noun phrases.

### **推荐** 使用名词短语来开始库和类型注释。

Doc comments for classes are often the most important documentation in your
program. They describe the type's invariants, establish the terminology it uses,
and provide context to the other doc comments for the class's members. A little
extra effort here can make all of the other members simpler to document.

在程序中，类的注释通常是最重要的文档。
类的注释描述了类型的不变性、介绍其使用的术语、
提供类成员使用的上下文信息。为类提供一些注释可以让
其他类成员的注释更易于理解和编写。

{:.good}
<?code-excerpt "docs_good.dart (noun-phrases-for-type-or-lib)"?>
{% prettify dart tag=pre+code %}
/// A chunk of non-breaking output text terminated by a hard or soft newline.
///
/// ...
class Chunk { ... }
{% endprettify %}

### CONSIDER including code samples in doc comments.

### **考虑** 在文档注释中添加示例代码。

{:.good}
<?code-excerpt "docs_good.dart (code-sample)"?>
{% prettify dart tag=pre+code %}
/// Returns the lesser of two numbers.
///
/// ```dart
/// min(5, 3) == 3
/// ```
num min(num a, num b) => ...
{% endprettify %}

Humans are great at generalizing from examples, so even a single code sample
makes an API easier to learn.

人类非常擅长从示例中抽象出实质内容，所以即使提供
一行最简单的示例代码都可以让 API 更易于理解。

### DO use square brackets in doc comments to refer to in-scope identifiers.

### **要** 使用方括号在文档注释中引用作用域内的标识符。

{% include linter-rule.html rule="comment_references" %}

If you surround things like variable, method, or type names in square brackets,
then dartdoc looks up the name and links to the relevant API docs. Parentheses
are optional, but can make it clearer when you're referring to a method or
constructor.

如果给变量，方法，或类型等名称加上方括号，则 dartdoc 会查找名称并链接到相关的 API 文档。
括号是可选的，但是当你在引用一个方法或者构造函数时，可以让注释更清晰。

{:.good}
<?code-excerpt "docs_good.dart (identifiers)"?>
{% prettify dart tag=pre+code %}
/// Throws a [StateError] if ...
/// similar to [anotherMethod()], but ...
{% endprettify %}

To link to a member of a specific class, use the class name and member name,
separated by a dot:

要链接到特定类的成员，请使用以点号分割的类名和成员名：

{:.good}
<?code-excerpt "docs_good.dart (member)"?>
{% prettify dart tag=pre+code %}
/// Similar to [Duration.inDays], but handles fractional days.
{% endprettify %}

The dot syntax can also be used to refer to named constructors:

点语法也可用于引用命名构造函数。 对于未命名的构造函数，在类名后面加上括号：

{:.good}
<?code-excerpt "docs_good.dart (ctor)"?>
{% prettify dart tag=pre+code %}
/// To create a point from polar coordinates, use [Point.polar()].
{% endprettify %}

### DO use prose to explain parameters, return values, and exceptions.

### **要** 使用散文的方式来描述参数、返回值以及异常信息。

Other languages use verbose tags and sections to describe what the parameters
and returns of a method are.

其他语言使用各种标签和额外的注释来描述参数和返回值。

{:.bad}
<?code-excerpt "docs_bad.dart (no-annotations)"?>
{% prettify dart tag=pre+code %}
/// Defines a flag with the given name and abbreviation.
///
/// @param name The name of the flag.
/// @param abbr The abbreviation for the flag.
/// @returns The new flag.
/// @throws ArgumentError If there is already an option with
///     the given name or abbreviation.
Flag addFlag(String name, String abbr) => ...
{% endprettify %}

The convention in Dart is to integrate that into the description of the method
and highlight parameters using square brackets.

{:.good}
<?code-excerpt "docs_good.dart (no-annotations)"?>
{% prettify dart tag=pre+code %}
/// Defines a flag.
///
/// Throws an [ArgumentError] if there is already an option named [name] or
/// there is already an option using abbreviation [abbr]. Returns the new flag.
Flag addFlag(String name, String abbr) => ...
{% endprettify %}

### DO put doc comments before metadata annotations.

### **要** 把注释文档放到注解之前。

{:.good}
<?code-excerpt "docs_good.dart (doc-before-meta)"?>
{% prettify dart tag=pre+code %}
/// A button that can be flipped on and off.
@Component(selector: 'toggle')
class ToggleComponent {}
{% endprettify %}

{:.bad}
<?code-excerpt "docs_bad.dart (doc-before-meta)" replace="/\n\n/\n/g"?>
{% prettify dart tag=pre+code %}
@Component(selector: 'toggle')
/// A button that can be flipped on and off.
class ToggleComponent {}
{% endprettify %}


## Markdown

You are allowed to use most [markdown][] formatting in your doc comments and
dartdoc will process it accordingly using the [markdown package.][]

文档注释中允许使用大多数 [markdown][] 格式，
并且 dartdoc 会根据 [markdown package.][] 进行解析。

[markdown]: https://daringfireball.net/projects/markdown/
[markdown package.]: {{site.pub-pkg}}/markdown

There are tons of guides out there already to introduce you to Markdown. Its
universal popularity is why we chose it. Here's just a quick example to give you
a flavor of what's supported:

有很多指南已经向您介绍Markdown。 它普遍受欢迎是我们选择它的原因。 这里只是一个简单的例子，让您了解所支持的内容：

<?code-excerpt "docs_good.dart (markdown)"?>
{% prettify dart tag=pre+code %}
/// This is a paragraph of regular text.
///
/// This sentence has *two* _emphasized_ words (italics) and **two**
/// __strong__ ones (bold).
///
/// A blank line creates a separate paragraph. It has some `inline code`
/// delimited using backticks.
///
/// * Unordered lists.
/// * Look like ASCII bullet lists.
/// * You can also use `-` or `+`.
///
/// 1. Numbered lists.
/// 2. Are, well, numbered.
/// 1. But the values don't matter.
///
///     * You can nest lists too.
///     * They must be indented at least 4 spaces.
///     * (Well, 5 including the space after `///`.)
///
/// Code blocks are fenced in triple backticks:
///
/// ```dart
/// this.code
///     .will
///     .retain(its, formatting);
/// ```
///
/// The code language (for syntax highlighting) defaults to Dart. You can
/// specify it by putting the name of the language after the opening backticks:
///
/// ```html
/// <h1>HTML is magical!</h1>
/// ```
///
/// Links can be:
///
/// * https://www.just-a-bare-url.com
/// * [with the URL inline](https://google.com)
/// * [or separated out][ref link]
///
/// [ref link]: https://google.com
///
/// # A Header
///
/// ## A subheader
///
/// ### A subsubheader
///
/// #### If you need this many levels of headers, you're doing it wrong
{% endprettify %}

### AVOID using markdown excessively.

### **避免** 过度使用 markdown。

When in doubt, format less. Formatting exists to illuminate your content, not
replace it. Words are what matter.

如果有格式缺少的问题，格式化已有的内容来阐明你的想法，而不是替换它，
内容才是最重要的。

### AVOID using HTML for formatting.

### **避免** 使用 HTML 来格式化文字。

It *may* be useful to use it in rare cases for things like tables, but in almost
all cases, if it's too complex to express in Markdown, you're better off not
expressing it.

例如表格，在极少数情况下它*可能*很有用。
但几乎所有的情况下，在 Markdown 中表格的表示都非常复杂。
这种情况下最好不要使用表格。

### PREFER backtick fences for code blocks.

### **推荐** 使用反引号标注代码。

Markdown has two ways to indicate a block of code: indenting the code four
spaces on each line, or surrounding it in a pair of triple-backtick "fence"
lines. The former syntax is brittle when used inside things like Markdown lists
where indentation is already meaningful or when the code block itself contains
indented code.

Markdown 有两种方式来标注一块代码：
每行代码缩进4个空格，或者在代码上下各标注三个反引号。
当缩进已经包含其他意义，或者代码段自身就包含缩进时，
在 Markdown 中使用前一种语法就显得很脆弱。

The backtick syntax avoids those indentation woes, lets you indicate the code's
language, and is consistent with using backticks for inline code.

反引号语法避免了那些缩进的问题，
而且能够指出代码的语言类型，
内联代码同样可以使用反引号标注。

{:.good}
{% prettify dart tag=pre+code %}
/// You can use [CodeBlockExample] like this:
///
/// ```dart
/// var example = CodeBlockExample();
/// print(example.isItGreat); // "Yes."
/// ```
{% endprettify %}

{:.bad}
{% prettify dart tag=pre+code %}
/// You can use [CodeBlockExample] like this:
///
///     var example = CodeBlockExample();
///     print(example.isItGreat); // "Yes."
{% endprettify %}

## Writing

## 如何写注释

We think of ourselves as programmers, but most of the characters in a source
file are intended primarily for humans to read. English is the language we code
in to modify the brains of our coworkers. As for any programming language, it's
worth putting effort into improving your proficiency.

虽然我们认为我们是程序员，但是大部分情况下源代码中的内容都是为了让人类更易于阅读和理解代码。
对于任何编程语言，都值得努力练习来提高熟练程度。

This section lists a few guidelines for our docs. You can learn more about
best practices for technical writing, in general, from articles such as
[Technical writing style](https://en.wikiversity.org/wiki/Technical_writing_style).

### PREFER brevity.

### **推荐** 简洁.

Be clear and precise, but also terse.

要清晰和准确，并且简洁。

### AVOID abbreviations and acronyms unless they are obvious.

### **避免** 缩写和首字母缩写词，除非很常见。

Many people don't know what "i.e.", "e.g." and "et al." mean. That acronym
that you're sure everyone in your field knows may not be as widely known as you
think.

很多人都不知道 "i.e."、 "e.g." 和 "et. al." 的意思。
你所在领域的首字母缩略词对于其他人可能并不了解。

### PREFER using "this" instead of "the" to refer to a member's instance.

### **推荐** 使用 "this" 而不是 "the" 来引用实例成员。

When documenting a member for a class, you often need to refer back to the
object the member is being called on. Using "the" can be ambiguous.

注释中提及到类的成员，通常是指被调用的对象实例的成员。
使用 "the" 可能会导致混淆。

{:.good}
<?code-excerpt "docs_good.dart (this)"?>
{% prettify dart tag=pre+code %}
class Box {
  /// The value this wraps.
  Object? _value;

  /// True if this box contains a value.
  bool get hasValue => _value != null;
}
{% endprettify %}
