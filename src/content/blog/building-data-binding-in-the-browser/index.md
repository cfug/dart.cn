---
# title: "Building data binding in the browser"
title: "在浏览器中构建数据绑定"
# description: "Data binding, or updating the view (usually UI) from your application’s code is probably the holy grail of browser-based web frameworks —…"
description: "数据绑定，即从应用代码更新视图（通常是 UI），大概是浏览器 Web 框架的圣杯——……"
ai-translated: true
publishDate: 2017-07-04
author: matanlurey
image: images/1QUn_zBM0SBDRG4TtMBiM2A.webp
category: deep-dive
layout: blog
---


<DashImage src="images/1QUn_zBM0SBDRG4TtMBiM2A.webp" alt="A diagram showing the MVC-style data binding popularized by Angular." caption="Data binding as popularized by the Angular (MVC-style). Lots of arrows and pictures. That’s always a good sign." />


*Data binding*, or updating the view (usually UI) from your application’s code is probably the *holy grail* of browser-based web frameworks — the reason they exist, and the reason [web standards have tried to shift](https://developers.google.com/web/fundamentals/getting-started/primers/customelements) in order to make it easier to “use the platform”.

*数据绑定*（data binding），也就是从应用代码更新视图（通常是 UI），
大概称得上是基于浏览器的 Web 框架的*圣杯*——
它们是为此而存在的，[Web 标准也在努力演进](https://developers.google.com/web/fundamentals/getting-started/primers/customelements)，
就是为了让“直接使用平台”变得更容易。

In this blog post I’ll be reviewing four forms of data binding, and writing a simple library/throw-away framework for each — mostly as a learning experience. I’ll be using [*Dart*](https://www.dartlang.org/), which is a high-level programming language I work on at Google (where I work on the AngularDart team), but *most* of the concepts below apply to JavaScript, TypeScript, or *Other*Script flavors.

在这篇博文中，我会回顾四种形式的数据绑定，
并为每一种写一个简单的库/一次性框架——主要是作为一种学习体验。
我会使用 [*Dart*](https://www.dartlang.org/)，
这是我在 Google 参与开发的一门高级编程语言
（我在 AngularDart 团队工作），
但下面的*大多数*概念同样适用于 JavaScript、TypeScript，
或者其他各种 *Other*Script。

Behold, the four horsemen of the data-binding apocalypse:

请看，数据绑定末日四骑士：

* Static templating

  静态模板（static templating）

* Manual data-binding (i.e. just using the DOM)

  手动数据绑定（也就是直接使用 DOM）

* MVC-style data-binding (as popularized by Angular)

  MVC 风格的数据绑定（由 Angular 发扬光大）

* Reactive data-binding (as popularized by React)

  响应式（reactive）数据绑定（由 React 发扬光大）

If you’re just interested in the code, it’s all available on GitHub:

如果你只对代码感兴趣，它们都在 GitHub 上：

***One quick note** — nothing here is optimized, and I’ve taken some shortcuts to make this tutorial achievable in about an hour, which means I didn’t write any pre-processors or code generators — and instead I’ve hand-written what generated code would look like; those files end in “.g.dart”.*

***快速说明一下**——这里的代码都没有做过优化，
为了让这篇教程能在大约一小时内完成，我走了一些捷径：
我没有编写任何预处理器或代码生成器，
而是手写了生成代码应有的样子；这些文件以 “.g.dart” 结尾。*

<GitHubEmbed repo="matanlurey/building-data-binding" title="building-data-binding - Accompanying code for &quot;Building Data Binding in the Browser&quot;" image="images/0QVBz3DSv-QKuugcc.webp" />


### Static templating

### 静态模板

As popularized mostly by *server-side* frameworks, such as those in PHP, Python, Ruby, and such — they emit *static* HTML that is transferred and displayed (usually) directly in the browser. Most non-JavaScript sites with any sort of backend use this strategy.

这种方式主要由*服务器端*框架发扬光大，
例如 PHP、Python、Ruby 等生态中的框架——
它们输出*静态* HTML，传输后（通常）直接在浏览器中显示。
大多数带有某种后端、且不以 JavaScript 为主的网站都采用这种策略。

So, at it’s core, you are just returning plain-HTML. Some newer web frameworks also allow *server-side rendering* (i.e. using your same client-side code to render all or part of the HTML on the server), but that is beyond the scope of this article.

所以，从本质上说，你只是在返回纯 HTML。
一些较新的 Web 框架还支持*服务器端渲染*（server-side rendering，
即用同一份客户端代码在服务器上渲染全部或部分 HTML），
但那超出了本文的范围。

Because Dart (and most *OtherScripts*, at this point) have [*interpolation*](https://www.dartlang.org/guides/language/language-tour#strings), or the ability to evaluate and create strings at runtime, doing a very basic form of static templating is extremely easy:

因为 Dart（如今大多数 *OtherScript* 也一样）
支持[插值](https://www.dartlang.org/guides/language/language-tour#strings)
（interpolation），也就是在运行时求值并创建字符串的能力，
所以实现一种非常基础的静态模板极其容易：

```dart
void main() {
  var name = 'Matan';
  print('Hello $name!');  
}

```

Or, we can get a little fancier, and *actually* output some HTML. In this example, I’ll return a bulleted list of all the things I like to do on mondays:

或者，我们可以稍微花哨一点，*真正*输出一些 HTML。
在这个例子中，我会返回一个无序列表，
列出我喜欢在周一做的所有事情：

```dart
void main() {
  var sundays = [
    'sleep in',
    'eat brunch',
    'wash car',
  ];
  print(
    'On Sunday: \n'
    '<ul>\n'
    '${sundays.map((i) => '  <li>$i</li>\n').join('')}'
    '</ul>\n'
  );
}

```

This outputs:

这会输出：
> On Sunday: 
&lt;ul&gt;
 &lt;li&gt;sleep in&lt;/li&gt;
 &lt;li&gt;eat brunch&lt;/li&gt;
 &lt;li&gt;wash car&lt;/li&gt;
&lt;/ul&gt;

Not exactly the *best* templating solution, but something like this can often work for lots of sites, and I’ve increasingly become a fan of using the *simplest* tool you can for a job, and only scaling up when you really really need it. If you really need a micro-library though —OK let’s write one.

这算不上*最好*的模板方案，但类似的做法对很多网站来说往往够用。
我越来越推崇用*最简单*的工具来完成工作，
只有在你真的真的需要时才升级方案。
不过，如果你确实需要一个微型库——好吧，那我们就写一个。

What would you want a basic static templating library to do? Probably in this case handle creating HTML syntax for you so it’s less error prone, and give you some helper functions for creating common tags and such. First let’s design a class called *Tag*, which encapsulates a single HTML element, and a class called *Node* and *Text*:

你希望一个基础的静态模板库做什么？
在这种情况下，大概是替你生成 HTML 语法以减少出错，
并提供一些创建常用标签之类的辅助函数。
首先我们来设计一个叫 *Tag* 的类，它封装单个 HTML 元素，
再加上 *Node* 和 *Text* 两个类：

```dart
abstract class Node {}

class Tag implements Node {
  final String name;
  final List<Node> children;

  const Tag(this.name, {this.children: const []});

  @override
  String toString() => '<$name>${children.join('')}</$name>';
}

class Text implements Node {
  final String text;

  const Text(this.text);

  @override
  String toString() => text;
}

void main() {
  var sundays = [
    'sleep in',
    'eat brunch',
    'wash car',
  ];
  var output = new Tag(
    'ul',
    children: sundays.map(
      (i) => new Tag('li', children: [new Text(i)]),
    ).toList(),
  );
  print(output);
}

```

This roughly does the same as our above code, but we’ve implemented some abstractions — a *Tag* is an HTML element, and has any number of children, and *Text* is well — text. We’ve written more code than before, but perhaps this is nicer to have for some. It’s trivial to include things like HTML attributes, so I’ll skip that for now.

这大致和上面的代码做了同样的事，但我们实现了一些抽象——
*Tag* 是一个 HTML 元素，可以拥有任意数量的子节点，
而 *Text* 嘛——就是文本。
我们写的代码比之前多了，但对某些人来说这样也许更好。
加入 HTML 属性之类的东西也很简单，这里暂且跳过。

Personally though, one thing bothers me, which is using *toString* in order to output production code. I’m also a fan of the [visitor pattern](https://en.wikipedia.org/wiki/Visitor_pattern), which neatly separates this logic from our DSL:

不过就我个人而言，有一件事让我不舒服：
用 *toString* 来输出生产代码。
我也是[访问者模式](https://en.wikipedia.org/wiki/Visitor_pattern)
（visitor pattern）的爱好者，
它能把这部分逻辑与我们的 DSL（领域特定语言）干净地分离开：

```dart
abstract class Visitor<T> {
  T visitNode(Node node);
  T visitTag(Tag node);
  T visitText(Text node);
}

class HtmlEmitter implements Visitor<String> {
  @override
  String visitNode(Node node) => node.accept(this);

  @override
  String visitTag(Tag node) {
    final buffer = new StringBuffer('<${node.name}>');
    buffer
      ..writeAll(node.children.map(visitNode))
      ..write('</${node.name}>');
    return buffer.toString();
  }

  @override
  String visitText(Text node) => node.text;
}

abstract class Node {
  R accept<R>(Visitor<R> visitor);
}

class Tag implements Node {
  final String name;
  final List<Node> children;

  const Tag(this.name, {this.children: const []});

  @override
  R accept<R>(Visitor<R> visitor) => visitor.visitTag(this);
}

class Text implements Node {
  final String text;

  const Text(this.text);

  @override
  R accept<R>(Visitor<R> visitor) => visitor.visitText(this);
}

void main() {
  var sundays = [
    'sleep in',
    'eat brunch',
    'wash car',
  ];
  var output = new Tag(
    'ul',
    children: sundays.map(
      (i) => new Tag('li', children: [new Text(i)]),
    ).toList(),
  );
  print(new HtmlEmitter().visitNode(output));
}

```

Again, *more code*. But now if I want indented/formatted HTML syntax, or to add validation logic, or anything else, I can implement a new *Visitor* and I don’t have to change any of my other classes. Cool!

同样，*代码更多了*。但现在如果我想要带缩进/格式化的 HTML 语法，
或者想添加校验逻辑，或者其他任何东西，
我只需实现一个新的 *Visitor*，而不必改动其他任何类。酷！

Finally, let’s wire up a very basic HTTP server using my new “library”. In this case, I’ll have it automatically listen on port 8080, and have it emit my TODO list for me:

最后，让我们用我的新“库”搭一个非常基础的 HTTP 服务器。
这里我会让它自动监听 8080 端口，并输出我的 TODO 清单：

```dart
import 'dart:io';

import 'package:static_templating/static_templating.dart';

main() async {
  final sundays = const [
    'sleep in',
    'eat brunch',
    'wash car',
  ];
  final server = await HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, 8080);
  print('Listening to localhost:8080.');
  await for (final request in server) {
    print('Connection received. Writing TODO list...');
    final list = _createTodoList(sundays);
    final output = list.accept(new HtmlEmitter());
    request.response
      ..headers.contentType = ContentType.HTML
      ..write(output)
      ..close();
    print('Done!');
  }
}

Node _createTodoList(Iterable<String> tasks) {
  return new Tag(
    'ul',
    children: tasks.map((i) => new Tag('li', children: [new Text(i)])).toList(),
  );
}

```

*(One thing I especially like about Dart is I didn’t have to import any 3rd party library to do this, setup any special tools, and I got static analysis to help me figure out how to set the ContentType header without Googling anything).*

*（我特别喜欢 Dart 的一点是：做这件事我不需要导入任何第三方库，
也不用配置任何特殊工具，而且静态分析帮我弄清楚了
如何设置 ContentType 头，完全不用去 Google 搜索。）*

Pretty boring, but it works! If you want to write your own server like this, I’d first check out the, in the order provided (again, I’m a huge fan of using the least libraries, as possible, for a given task):

挺无聊的，但它能跑！如果你想自己写一个这样的服务器，
我建议按下面给出的顺序依次考虑
（再强调一次，我非常推崇针对一项任务尽可能少用库）：

* [dart:io](https://www.dartlang.org/articles/dart-vm/io), the standard VM library (not available in the browser)

  [dart:io](https://www.dartlang.org/articles/dart-vm/io)，
  标准 VM 库（在浏览器中不可用）

* [shelf](https://pub.dartlang.org/packages/shelf), a middleware-based server technology like Express for NodeJS

  [shelf](https://pub.dartlang.org/packages/shelf)，
  基于中间件的服务器技术，类似 NodeJS 的 Express

* more full-featured frameworks like [aqueduct](http://aqueduct.io/) or [angel](https://angel-dart.github.io/)

  功能更完整的框架，
  比如 [aqueduct](http://aqueduct.io/) 或 [angel](https://angel-dart.github.io/)

And that’s it. You can use similar techniques to render HTML in the browser, of course, but that’s rather boring, and you probably want the HTML to change when the user interacts with the page.

就这些了。当然，你也可以用类似的技术在浏览器中渲染 HTML，
但那相当无聊，你多半希望当用户与页面交互时 HTML 能随之变化。

### Manual data-binding

### 手动数据绑定

*Before* the era of JavaScript web frameworks (when everything was more of a library), it was common to either write code directly against the DOM (in “vanilla” JavaScript) or to use a library like [jQuery](https://jquery.com/) to remove browser differences and make common tasks easier.

在 JavaScript Web 框架时代*之前*（那时一切都更像库），
常见的做法要么是直接针对 DOM 写代码（用“原生”JavaScript），
要么是使用 [jQuery](https://jquery.com/) 这样的库
来抹平浏览器差异，让常见任务更简单。

Luckily [dart:html](https://webdev.dartlang.org/tutorials/low-level-html/connect-dart-html) is a high-level library provided by the Dart SDK, and even in JavaScript modern-day browsers are full featured enough not to need a library for simple data-binding. What if I want to bring my new “Sunday TODO list” — and be able to check-off (delete) items as I finish them?

幸运的是，[dart:html](https://webdev.dartlang.org/tutorials/low-level-html/connect-dart-html)
是 Dart SDK 提供的一个高级库；
即便在 JavaScript 中，现代浏览器的功能也已足够完善，
简单的数据绑定不再需要库。
如果我想搬出我新的“周日 TODO 清单”，
并且能在完成事项后把它们勾掉（删除），该怎么做？

<DashImage src="images/1ggiMuy98lvPyUWVcf-HOFA.webp" alt="TODO list application built in the tutorial." caption="The world’s greatest UI" />


Enter *manual* data binding. Instead of relying on any framework or specific library, I will just create HTML elements, and listen to events in order to know when to update the DOM, all myself.

这就轮到*手动*数据绑定登场了。
不依赖任何框架或特定的库，我自己创建 HTML 元素，
并监听事件来得知何时更新 DOM，一切亲力亲为。

```html
<html>
  <body>
    <div id="todo-list"></div>
  </body>
  <script type="application/dart" src="main.dart"></script>
  <script src="packages/browser/dart.js"></script>
</html>

```

```dart
import 'dart:html';

main() {
  final sundays = const [
    'sleep in',
    'eat brunch',
    'wash car',
  ];
  document.querySelector('#todo-list')
    ..append(new UListElement()
      ..children.addAll(
        sundays.map(_createListItem),
      ));
}

Element _createListItem(String item) {
  final li = new LIElement();
  final button = new ButtonElement()
    ..text = 'Done'
    ..onClick.listen((_) => li.remove());
  li
    ..appendText(item)
    ..append(button);
  return li;
}

```

Again, pretty boring. But if I was really making a simple TODO app just like this, not too bad. Dart’s `..` or [method cascades](http://news.dartlang.org/2012/02/method-cascades-in-dart-posted-by-gilad.html) make this *relatively* terse, and I could add other basic behavior pretty easily.

同样挺无聊。但如果我真的只是在做一个这样的简单 TODO 应用，
那也还不错。Dart 的 `..`，
也就是[方法级联](http://news.dartlang.org/2012/02/method-cascades-in-dart-posted-by-gilad.html)
（method cascade），让代码*相对*简洁，
我也能相当容易地添加其他基本行为。

More or less, every other form of data/template-binding is trying to do the *above —* build some DOM, and update the DOM when something happens — but either in a (a) more performant, (b) more elegant, (c) more ergonomic, and/or (d) more modular way.

或多或少，其他每一种数据/模板绑定形式都在尝试做*上面这件事——*
构建一些 DOM，并在事情发生时更新 DOM——
只不过想以 (a) 更高性能、(b) 更优雅、(c) 更顺手，
和/或 (d) 更模块化的方式来做。

## Automatic data-binding

## 自动数据绑定

As of the current browser specifications, nothing exists to make this *easier*. Some might argue that’s the reason WebComponents V1 hasn’t taken off compared to existing frameworks — frameworks have made it so easy and/or ergonomic to build and update DOM that nobody wants to go backwards.

就目前的浏览器规范而言，还没有任何东西能让这件事*更容易*。
有人可能会说，这正是 WebComponents V1 相比现有框架没能流行起来的原因——
框架已经把构建和更新 DOM 变得如此简单和/或顺手，
没人愿意走回头路。

I work on the AngularDart team, so I’ll be showing an example next of MVC-style data binding (as popularized by Angular, but I’m told Ember is another excellent example — and I’m sure there are many many others).

我在 AngularDart 团队工作，
所以接下来我会展示一个 MVC 风格数据绑定的例子
（由 Angular 发扬光大，不过有人告诉我 Ember 也是一个极好的例子——
我相信还有非常非常多其他的例子）。

### MVC-style data-binding

### MVC 风格的数据绑定

The crux of MVC is separation of logic between the *view (*in the browser this is usually the DOM) and the controller (in the browser this is usually your JavaScript). I’ll skip the *m* or model, for now.

MVC 的关键在于把逻辑分离到*视图*（view，在浏览器中通常是 DOM）
和控制器（controller，在浏览器中通常是你的 JavaScript）之间。
至于 *m*，也就是模型（model），这里暂且跳过。

Angular popularized (or at least attempted) the idea that you should be able to write plain-old dumb-objects (PODOs), include any logic you want, and it “just bind” to an HTML template. Consider the following MVC-style encapsulation of our Sunday TODO list:

Angular 推广了（或至少尝试推广）这样一个理念：
你应该可以编写朴素的哑对象（plain-old dumb-objects，PODO），
在里面放入你想要的任何逻辑，然后让它“直接绑定”到 HTML 模板。
看看下面这个对周日 TODO 清单的 MVC 风格封装：

```html
<ul>
  <!--
    Invented syntax. *bind="<TYPE> <TO>".

    In this case, a for-loop bound to "items", with every individual "item".
  -->
  <li *bind="for items:item">
    <!-- Pretty much the gold-standard for string interpolation. -->
    {{item}}
    <!--
      Invented syntax. *event="<NAME>:<TO>".

      In this case, a "click" event that invokes the "onClick" method.
    -->
    <button *event="click:onClick">Done</button>
  </li>
</ul>

```

So what do you think? There are some advantages and disadvantages here:

你觉得怎么样？这里有一些优点和缺点：

**PROs**:

**优点**：

* You’re able to encapsulate much/all of your view logic in a single file.

  你可以把大部分乃至全部视图逻辑封装在一个文件里。

* While non-standard, this is *fairly* readable to even non-coders with as little as some sort of “cheat-sheet” that explains additions to the HTML specification for your templating language.

  虽然不标准，但即便对不写代码的人来说，这也*相当*易读——
  只需一份解释你的模板语言对 HTML 规范做了哪些扩展的“速查表”。

* You didn’t write any actual code — so a framework with a good ahead-of-time preprocessor can “compile” this, potentially efficiently, to JavaScript/DOM invocations.

  你没有写任何实际代码——因此拥有优秀预编译
  （ahead-of-time）预处理器的框架可以把这些“编译”成
  JavaScript/DOM 调用，而且可能相当高效。

**CONs**:

**缺点**：

* If you don’t buy into the MVC religion, you might not like this file.

  如果你不信奉 MVC 这套“宗教”，你可能不会喜欢这个文件。

* Even though you might have mastered HTML/CSS and Dart or JavaScript, you and your developers have to learn yet-another-thing that is neither of those.

  即便你已经精通 HTML/CSS 和 Dart 或 JavaScript，
  你和你的开发者还得再学一样两者都不是的新东西。

* You didn’t write any actual code — so you are more or less hoping the framework authors are going to preprocess/compile this efficiently and the output is going to be nearly as good as if you would have wrote the data binding manually (*hint:* it almost never is).

  你没有写任何实际代码——所以你多少是在指望框架作者
  能高效地预处理/编译这些内容，并且产出几乎能媲美
  你手写数据绑定的效果（*提示：*几乎从来做不到）。

I didn’t show any “controller” code yet, so let’s write a simple class:

我还没展示任何“控制器”代码，那我们来写一个简单的类：

```dart
class ListController {
  final List<String> items;

  ListController(this.items);

  void onClick(String item) {
    items.remove(item);
  }
}

```

Getting this to “just work” is going to require… writing a framework. This is a blog post, so instead of actually writing a parser for our template language, a pre-processor/compiler, we’ll simply hand-write the code a generator would otherwise create.

要让这些“直接跑起来”，就需要……写一个框架。
这是一篇博文，所以我们不真的去为模板语言编写解析器、
预处理器/编译器，而是直接手写生成器本来会生成的代码。

First lets establish our “framework”. I’m going to make it simple:

首先来搭建我们的“框架”。我会把它做得很简单：

```dart
import 'dart:html';

abstract class Controller {
  View get view;

  /// Invoke when something in the DOM should be changed.
  ///
  /// In a "real framework" this would collate and be more intelligent.
  void markDirty() => view.detectChanges(this);
}

abstract class View<C extends Controller> {
  /// Create the initial representation of the DOM.
  Element build();

  /// Applies data-binding for a given [controller].
  void detectChanges(C controller);
}

```

I’ve created two abstractions, a *Controller*, or a class I’ll extend to create my business logic (in Angular this is commonly a *component*), and a *View*, or the representation of my HTML file as plain Dart (or later, JavaScript).

我创建了两个抽象：一个是 *Controller*，
也就是我会继承它来编写业务逻辑的类
（在 Angular 中这通常是一个*组件*）；
另一个是 *View*，也就是用纯 Dart（之后是 JavaScript）
表示的 HTML 文件。

Let’s create the generated code, or “view”, first:

我们先来创建生成的代码，也就是“视图”：

```dart
// A dart "partial library", that is, in the namespace of another library.
part of list;

class _ViewListController extends View<ListController> {
  UListElement _ul;
  List<String> _itemsLastCheck = const [];

  @override
  Element build() {
    return _ul = new UListElement();
  }

  @override
  void detectChanges(ListController controller) {
    // Not an exhaustive check. In a real framework you'd need to verify that
    // the contents of the list are the same, not just the lists are of
    // different lengths.
    if (_itemsLastCheck.length != controller.items.length) {
      _updateItems(controller);
    }
  }

  void _updateItems(ListController controller) {
    // Intentionally not efficient. In a real framework you'd want to track
    // every <li> individually to avoid blowing away big parts of the DOM and
    // rebuilding.
    _ul.children
      ..clear()
      ..addAll(controller.items.map((i) => _createLi(controller, i)));
    _itemsLastCheck = controller.items.toList();
  }

  Element _createLi(ListController controller, String item) {
    final li = new LIElement()..appendText(item);
    li.append(new ButtonElement()
      ..text = 'Done'
      ..onClick.listen((_) => controller.onClick(item)));
    return li;
  }
}

```

I took some shortcuts above, for example, *items* only updates when the list’s length changes, and I’m not maintaining state at all, so if the list updates I blow away the existing DOM and create new DOM. A typical framework (including Angular) would be much smarter about this — but part of this article is showing exactly how much work behind-the-scenes is happening for even the simplest data-binding.

上面我走了一些捷径，例如 *items* 只在列表长度变化时才更新，
而且我完全没有维护状态，所以列表一更新，
我就摧毁现有 DOM 并创建新的 DOM。
典型的框架（包括 Angular）在这方面会聪明得多——
但本文的一部分目的，正是展示即便是最简单的数据绑定，
背后到底发生了多少工作。

Finally, let’s update our controller to use our framework:

最后，我们来更新控制器，让它使用我们的框架：

```dart
library list;

import 'dart:html';

import 'package:mvc_data_binding/framework.dart';

// Would be generated in a typical framework.
part 'list.g.dart';

class ListController extends Controller {
  final List<String> items;

  ListController(this.items);

  void onClick(String item) {
    items.remove(item);
    markDirty();
  }

  @override
  final view = new _ViewListController();
}

```

And put it all together in *main.dart*:

然后在 *main.dart* 中把它们组装起来：

```html
<html>
  <body>
    <div id="todo-list"></div>
  </body>
  <script type="application/dart" src="main.dart"></script>
  <script src="packages/browser/dart.js"></script>
</html>

```

```dart
import 'dart:html';

import 'package:mvc_data_binding/list.dart';

main() {
  final sundays = [
    'sleep in',
    'eat brunch',
    'wash car',
  ];
  final container = document.querySelector('#todo-list');
  final component = new ListController(sundays);
  container.append(component.view.build());

  // Start change detection. This should be automatic in most frameworks.
  component.view.detectChanges(component);
}


```

Now we have an *Angular-style* MVC framework, and I imagine it would take anywhere between a few hours and a few days (or weeks, or months) to create a code generator for automatically emitting the .g.dart file for you, depending on how simple or complex you want to go. That’s out of scope of this article though.

现在我们有了一个 *Angular 风格*的 MVC 框架。
我估计，要写一个能自动为你生成 .g.dart 文件的代码生成器，
需要几个小时到几天（甚至几周、几个月）不等，
取决于你想做得多简单或多复杂。不过那超出了本文的范围。

### Reactive-style data-binding

### 响应式风格的数据绑定

The FP or reactive approach to data-binding is different — instead of separating your view and controller logic, you instead model your application as functions (or classes) that take as inputs values (data) and emit as output “view” (html in this case).

函数式编程（FP）或响应式的数据绑定方法则不同——
它不分离视图和控制器逻辑，
而是把应用建模为一些函数（或类）：
以值（数据）作为输入，输出“视图”（这里就是 HTML）。

This is the approach taken by React, Vue, and even [Flutter](https://flutter.io).

React、Vue，甚至 [Flutter](https://flutter.io) 采用的都是这种方法。

Consider the following:

看看下面这个例子：

```dart
Node todoList(List<String> todos) => new Tag(
  'ul',
  children: todos.map(
    (i) => new Tag('li', children: [
      new Text(i),
      new Tag('button', children: [
        'Done',
      ], events: {
        'click': () => throw new UnimplementedError(),
      }),
    ]),
  ).toList(),
);

```

This is actually not too different from what we did above in *static template binding*, except that modern day libraries and frameworks use a series of algorithms in order to minimize impact on the DOM. For example, if you remove a single `&lt;li&gt;` a typical framework like *React* won’t rebuild anything.

这其实和我们在上面的*静态模板绑定*中做的没有太大不同，
只是现代的库和框架会使用一系列算法，
把对 DOM 的影响降到最低。
例如，如果你只移除一个 `&lt;li&gt;`，
像 *React* 这样的典型框架不会重建任何东西。

**PROs**:

**优点**：

* You’re able to encapsulate all your “component's” logic in a single place.

  你可以把“组件”的全部逻辑封装在一个地方。

* Doesn’t require any special pre-processing or compilers.

  不需要任何特殊的预处理或编译器。

* For programs written with say, the Flutter SDK, [your IDE becomes your god](https://flutter.io/intellij-ide/). Auto-complete all-the-things, and you never even need to learn how to type (sort of).

  对于用 Flutter SDK 之类编写的程序，
  [你的 IDE 就是你的神](https://flutter.io/intellij-ide/)。
  万物皆可自动补全，你甚至都不需要学会打字（差不多吧）。

* Easy to use but [optional tools like JSX](https://facebook.github.io/react/docs/introducing-jsx.html) can make this quite a bit terser.

  简单易用，而 [JSX 之类的可选工具](https://facebook.github.io/react/docs/introducing-jsx.html)
  还能让代码简洁不少。

**CONs**:

**缺点**：

* Like before, the MVC purists (and parts of various companies’ web platform DevRel teams) might scream a bit — you are now putting HTML, JavaScript, and potentially CSS in a JavaScript function (or class).

  和之前一样，MVC 纯粹主义者
  （以及各家公司 Web 平台 DevRel 团队的部分成员）可能会有点抓狂——
  你现在把 HTML、JavaScript，甚至可能还有 CSS，
  都放进了一个 JavaScript 函数（或类）里。

* Unlike something like Angular (though it has its own problems), you can’t really “inspect” the code outputted by this function, that is, you have to be very familiar with idiosyncrasies of the framework when optimizing lists of thousands of items, lazy scrolling, so on and so forth.

  不像 Angular 之类（尽管它也有自己的问题），
  你无法真正“检查”这个函数输出的代码。
  也就是说，在优化上千项的列表、惰性滚动等场景时，
  你必须非常熟悉框架的各种怪癖。

I promised I’d write a simple library for a reactive-style data-binding framework, but I decided by the end of this article it had already been done better by my colleague Yegor with his framework “Butterfly”:

我承诺过要为响应式风格的数据绑定框架写一个简单的库，
但写到本文结尾时我认定，我的同事 Yegor
已经用他的框架 “Butterfly” 把这件事做得更好了：

<GitHubEmbed repo="yjbanov/butterfly" title="butterfly - A web framework for Dart based on Flutter's widget model" image="images/0mC9GWhN0QE2u20u0.webp" />


```dart
// Copyright 2016 Google Inc. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:butterfly/butterfly.dart';

class App extends StatelessWidget {
  Node build() {
    return div(attrs: {'id': 'greeting'})([
      text('Hello, World!'),
      button(eventListeners: {
        EventType.click: (_) {
          print('Woohoo!');
        }
      })([
        text('Update'),
      ]),
    ]);
  }
}
```

## So what is the conclusion?

## 那么结论是什么？

There is none, so sorry to disappoint if you made down this far looking for a benchmark table or something to use to justify the 200 hours you spent migrating a project to the latest-and-greatest framework. Arguably each approach has strengths and weaknesses, and I’ve seen more frameworks start to use hybrid models in places as well.

没有结论。如果你一路读到这里，是想找一张基准测试表格之类的东西，
好为你花 200 个小时把项目迁移到最新最炫框架的决定正名，
那很抱歉让你失望了。可以说每种方法都有长处和短处，
而且我也看到越来越多的框架开始在某些地方采用混合模型。

Some general rules of thumb to take home:

一些值得带走的通用经验法则：

* **Data-binding is hard**. Remember that the next time you ask why there isn’t a “simple lightweight data-binding library that just does X and Y”.

  **数据绑定很难**。下次你再问为什么没有一个
  “只做 X 和 Y 的简单轻量数据绑定库”时，请记住这一点。

* **Template systems are built around tradeoffs**. You either trade-off ergonomics, speed, or complexity. I’ve yet to use a single framework that completely succeeds at everything — and my guess is nobody else has ever given the number of frameworks and models that exist.

  **模板系统是围绕取舍构建的**。你总要在顺手程度、速度
  或复杂度之间做权衡。我还没用过一个在各方面都完全成功的框架——
  考虑到现存框架和模型的数量，我猜也没有其他人用过。

* If you are building your own site, and are tempted to write a “micro” framework, **start simple**. Do just the smallest amount of things possible, and only add complexity when it solves a *big* problem. **Boiler-plate itself isn’t evil** — just boiler-plate that is error prone and hard to write *correctly*.

  如果你在构建自己的网站，并且忍不住想写一个“微型”框架，
  **从简单开始**。只做尽可能少的事情，
  只有当复杂性能解决一个*大*问题时才引入它。
  **样板代码（boilerplate）本身并不是恶**——
  容易出错、难以*正确*编写的样板代码才是。

I’d be interested to hear from readers what they thought, and if they’d like me to go into any more detail on any given subject. Have a wonderful July 4th!

我很想听听读者们的想法，以及是否希望我就某个话题展开更多细节。
祝大家度过一个美好的 7 月 4 日（美国独立日）！
