---
# title: dart:html
title: dart:html
# description: Learn about the major features in Dart's dart:html library.
description: 了解 Dart dart:html 库的主要功能。
prevpage:
  url: /libraries/dart-io
# title: dart:io
  title: dart:io
ai-translated: true
---

:::warning
The `dart:html` library is deprecated.
Instead, use [`dart:js_interop`][] and [`package:web`][].

`dart:html` 库已弃用。
请改用 [`dart:js_interop`][] 和 [`package:web`][]。
:::

Use the [dart:html][] library to program the browser, manipulate objects and
elements in the DOM, and access HTML5 APIs. DOM stands for *Document Object
Model*, which describes the hierarchy of an HTML page.

使用 [dart:html][dart:html] 库可以对浏览器编程、
操作 DOM 中的对象和元素，以及访问 HTML5 API。
DOM 即 **文档对象模型** (Document Object Model)，
描述 HTML 页面的层级结构。

Other common uses of dart:html are manipulating styles (*CSS*), getting
data using HTTP requests, and exchanging data using
[WebSockets](#sending-and-receiving-real-time-data-with-websockets).
HTML5 (and dart:html) has many
additional APIs that this section doesn't cover. Only web apps can use
dart:html, not command-line apps.

dart:html 的其他常见用途包括操作样式（**CSS**）、
通过 HTTP 请求获取数据，以及使用
[WebSocket](#sending-and-receiving-real-time-data-with-websockets)
交换数据。
HTML5（以及 dart:html）还有许多本节未涉及的 API。
只有 Web 应用可以使用 dart:html，命令行应用不行。

:::note
For larger applications or if you already have a Flutter application,
consider using [Flutter for web.]({{site.flutter}}/web)

对于较大的应用，或者你已经有 Flutter 应用，
可以考虑使用 [Flutter for web]({{site.flutter}}/web)。
:::

To use the HTML library in your web app, import dart:html:

要在 Web 应用中使用 HTML 库，请导入 dart:html：

<?code-excerpt "html/lib/html.dart (import)"?>
```dart
import 'dart:html';
```

[`dart:js_interop`]: /interop/js-interop
[`package:web`]: {{site.pub-pkg}}/web
[Migrate to package:web]: /interop/js-interop/package-web

## Manipulating the DOM

## 操作 DOM

To use the DOM, you need to know about *windows*, *documents*,
*elements*, and *nodes*.

使用 DOM 时，需要了解 **窗口**、**文档**、**元素** 和 **节点**。

A [Window][] object represents
the actual window of the web browser. Each Window has a Document object,
which points to the document that's currently loaded. The Window object
also has accessors to various APIs such as IndexedDB (for storing data),
requestAnimationFrame (for animations), and more. In tabbed browsers,
each tab has its own Window object.

[Window][Window] 对象表示 Web 浏览器的实际窗口。
每个 Window 都有一个 Document 对象，指向当前加载的文档。
Window 对象还可以访问多种 API，
例如 IndexedDB（用于存储数据）、requestAnimationFrame（用于动画）等。
在多标签浏览器中，每个标签页都有自己的 Window 对象。

With the [Document][] object, you can create and manipulate [Element][] objects
within the document. Note that the document itself is an element and can be
manipulated.

通过 [Document][Document] 对象，可以在文档中创建并操作 [Element][Element] 对象。
注意，文档本身也是元素，同样可以操作。

The DOM models a tree of
[Nodes.][Nodes] These nodes are often
elements, but they can also be attributes, text, comments, and other DOM
types. Except for the root node, which has no parent, each node in the
DOM has one parent and might have many children.

DOM 把页面建模为一棵 [节点][Nodes] 树。
这些节点通常是元素，也可以是属性、文本、注释和其他 DOM 类型。
除了没有父节点的根节点，DOM 中的每个节点都有一个父节点，
并且可能有许多子节点。

### Finding elements

### 查找元素

To manipulate an element, you first need an object that represents it.
You can get this object using a query.

要操作一个元素，首先需要代表它的对象。
可以通过查询得到这个对象。

Find one or more elements using the top-level functions
`querySelector()` and `querySelectorAll()`. 
You can query by ID, class, tag, name, or any combination of these. 
The [CSS Selector Specification guide](https://www.w3.org/TR/css3-selectors/) 
defines the formats of the selectors such as using a \# prefix to specify IDs 
and a period (.) for classes.

使用顶层函数 `querySelector()` 和 `querySelectorAll()`
查找一个或多个元素。
可以按 ID、class、标签、name 或它们的任意组合查询。
[CSS 选择器规范指南](https://www.w3.org/TR/css3-selectors/)
定义了选择器的格式，例如用 \# 前缀指定 ID，用句点（.）指定 class。

The `querySelector()` function returns the first element that matches
the selector, while `querySelectorAll()`returns a collection of elements
that match the selector.

`querySelector()` 返回第一个匹配选择器的元素，
`querySelectorAll()` 返回所有匹配选择器的元素集合。

<?code-excerpt "html/lib/html.dart (query-selector)"?>
```dart
// Find an element by id (an-id).
Element idElement = querySelector('#an-id')!;

// Find an element by class (a-class).
Element classElement = querySelector('.a-class')!;

// Find all elements by tag (<div>).
List<Element> divElements = querySelectorAll('div');

// Find all text inputs.
List<Element> textInputElements = querySelectorAll('input[type="text"]');

// Find all elements with the CSS class 'class'
// inside of a <p> that is inside an element with
// the ID 'id'.
List<Element> specialParagraphElements = querySelectorAll('#id p.class');
```

### Manipulating elements

### 操作元素

You can use properties to change the state of an element. Node and its
subtype Element define the properties that all elements have. For
example, all elements have `classes`, `hidden`, `id`, `style`, and
`title` properties that you can use to set state. Subclasses of Element
define additional properties, such as the `href` property of
[AnchorElement.][AnchorElement]

可以用属性改变元素的状态。
Node 及其子类型 Element 定义了所有元素都有的属性。
例如，所有元素都有 `classes`、`hidden`、`id`、`style` 和 `title` 属性，
可以用来设置状态。
Element 的子类还定义了更多属性，
例如 [AnchorElement][AnchorElement] 的 `href` 属性。

Consider this example of specifying an anchor element in HTML:

看下面这个在 HTML 中指定锚点元素的例子：

<?code-excerpt "html/test/html_test.dart (anchor-html)" replace="/.*'(.*?)'.*/$1/g"?>
```html
<a id="example" href="/another/example">link text</a>
```

This `<a>` tag specifies an element with an `href` attribute and a text
node (accessible via a `text` property) that contains the string
"link text". To change the URL that the link goes to, you can use
AnchorElement's `href` property:

这个 `<a>` 标签指定了一个带 `href` 属性的元素，
以及一个文本节点（可通过 `text` 属性访问），
其内容为字符串 "link text"。
要更改链接指向的 URL，可以使用 AnchorElement 的 `href` 属性：

<?code-excerpt "html/test/html_test.dart (href)" plaster="none"?>
```dart
var anchor = querySelector('#example') as AnchorElement;
anchor.href = 'https://dart.dev';
```

Often you need to set properties on multiple elements. For example, the
following code sets the `hidden` property of all elements that have a
class of "mac", "win", or "linux". Setting the `hidden` property to true
has the same effect as adding `display: none` to the CSS.

经常需要同时设置多个元素的属性。
例如，下面的代码设置 class 为 "mac"、"win" 或 "linux" 的所有元素的 `hidden` 属性。
把 `hidden` 设为 true，效果等同于在 CSS 中加上 `display: none`。

<?code-excerpt "html/test/html_test.dart (os-html)" replace="/.*? = '''|''';$//g"?>
```html
<!-- In HTML: -->
<p>
  <span class="linux">Words for Linux</span>
  <span class="macos">Words for Mac</span>
  <span class="windows">Words for Windows</span>
</p>
```

<?code-excerpt "html/test/html_test.dart (os)"?>
```dart
// In Dart:
const osList = ['macos', 'windows', 'linux'];
final userOs = determineUserOs();

// For each possible OS...
for (final os in osList) {
  // Matches user OS?
  bool shouldShow = (os == userOs);

  // Find all elements with class=os. For example, if
  // os == 'windows', call querySelectorAll('.windows')
  // to find all elements with the class "windows".
  // Note that '.$os' uses string interpolation.
  for (final elem in querySelectorAll('.$os')) {
    elem.hidden = !shouldShow; // Show or hide.
  }
}
```

When the right property isn't available or convenient, you can use
Element's `attributes` property. This property is a
`Map<String, String>`, where the keys are attribute names. For a list of
attribute names and their meanings, see the [MDN Attributes
page.](https://developer.mozilla.org/docs/Web/HTML/Attributes) Here's an
example of setting an attribute's value:

没有合适或方便的属性时，可以使用 Element 的 `attributes` 属性。
该属性是 `Map<String, String>`，键为属性名。
属性名及其含义见 [MDN 属性页面](https://developer.mozilla.org/docs/Web/HTML/Attributes)。
下面是设置属性值的例子：

<?code-excerpt "html/lib/html.dart (attributes)"?>
```dart
elem.attributes['someAttribute'] = 'someValue';
```

### Creating elements

### 创建元素

You can add to existing HTML pages by creating new elements and
attaching them to the DOM. Here's an example of creating a paragraph
(\<p\>) element:

可以通过创建新元素并挂到 DOM 上，来扩充已有的 HTML 页面。
下面是创建段落（\<p\>）元素的例子：

<?code-excerpt "html/lib/html.dart (creating-elements)"?>
```dart
var elem = ParagraphElement();
elem.text = 'Creating is easy!';
```

You can also create an element by parsing HTML text. Any child elements
are also parsed and created.

也可以通过解析 HTML 文本来创建元素。
其中的子元素也会一并解析并创建。

<?code-excerpt "html/lib/html.dart (creating-from-html)"?>
```dart
var elem2 = Element.html('<p>Creating <em>is</em> easy!</p>');
```

Note that `elem2` is a `ParagraphElement` in the preceding example.

注意，上例中的 `elem2` 是 `ParagraphElement`。

Attach the newly created element to the document by assigning a parent
to the element. You can add an element to any existing element's
children. In the following example, `body` is an element, and its child
elements are accessible (as a `List<Element>`) from the `children` property.

给新创建的元素指定父节点，即可把它挂到文档上。
可以把元素加到任何已有元素的子节点中。
下面的例子里，`body` 是一个元素，
它的子元素可以通过 `children` 属性以 `List<Element>` 的形式访问。

<?code-excerpt "html/lib/html.dart (body-children-add)"?>
```dart
document.body!.children.add(elem2);
```

### Adding, replacing, and removing nodes

### 添加、替换和移除节点

Recall that elements are just a kind of node. You can find all the
children of a node using the `nodes` property of Node, which returns a
`List<Node>` (as opposed to `children`, which omits non-Element nodes).
Once you have this list, you can use the usual List methods and
operators to manipulate the children of the node.

元素只是节点的一种。
可以通过 Node 的 `nodes` 属性找到节点的全部子节点，
它返回 `List<Node>`（与之相对，`children` 会略去非 Element 节点）。
拿到这个列表后，可以用常见的 List 方法和运算符来操作该节点的子节点。

To add a node as the last child of its parent, use the List `add()`
method:

要把节点加为父节点的最后一个子节点，请使用 List 的 `add()` 方法：

<?code-excerpt "html/lib/html.dart (nodes-add)"?>
```dart
querySelector('#inputs')!.nodes.add(elem);
```

To replace a node, use the Node `replaceWith()` method:

要替换节点，请使用 Node 的 `replaceWith()` 方法：

<?code-excerpt "html/lib/html.dart (replace-with)"?>
```dart
querySelector('#status')!.replaceWith(elem);
```

To remove a node, use the Node `remove()` method:

要移除节点，请使用 Node 的 `remove()` 方法：

<?code-excerpt "html/lib/html.dart (remove)"?>
```dart
// Find a node by ID, and remove it from the DOM if it is found.
querySelector('#expendable')?.remove();
```

### Manipulating CSS styles

### 操作 CSS 样式

CSS, or *cascading style sheets*, defines the presentation styles of DOM
elements. You can change the appearance of an element by attaching ID
and class attributes to it.

CSS，即 **层叠样式表**，定义 DOM 元素的表现样式。
可以通过给元素加上 ID 和 class 属性来改变它的外观。

Each element has a `classes` field, which is a list. Add and remove CSS
classes simply by adding and removing strings from this collection. For
example, the following sample adds the `warning` class to an element:

每个元素都有 `classes` 字段，它是一个列表。
向这个集合添加或移除字符串，即可添加或移除 CSS class。
例如，下面的示例给元素加上 `warning` class：

<?code-excerpt "html/lib/html.dart (classes-add)"?>
```dart
var elem = querySelector('#message')!;
elem.classes.add('warning');
```

It's often very efficient to find an element by ID. You can dynamically
set an element ID with the `id` property:

按 ID 查找元素通常很高效。
可以用 `id` 属性动态设置元素 ID：

<?code-excerpt "html/lib/html.dart (set-id)"?>
```dart
var message = DivElement();
message.id = 'message2';
message.text = 'Please subscribe to the Dart mailing list.';
```

You can reduce the redundant text in this example by using method
cascades:

可以用方法级联减少这个例子里的重复文本：

<?code-excerpt "html/lib/html.dart (elem-set-cascade)"?>
```dart
var message = DivElement()
  ..id = 'message2'
  ..text = 'Please subscribe to the Dart mailing list.';
```

While using IDs and classes to associate an element with a set of styles
is best practice, sometimes you want to attach a specific style directly
to the element:

用 ID 和 class 把元素关联到一组样式是推荐做法，
但有时也需要把某个具体样式直接加到元素上：

<?code-excerpt "html/lib/html.dart (set-style)"?>
```dart
message.style
  ..fontWeight = 'bold'
  ..fontSize = '3em';
```

### Handling events

### 处理事件

To respond to external events such as clicks, changes of focus, and
selections, add an event listener. You can add an event listener to any
element on the page. Event dispatch and propagation is a complicated
subject; [research the
details](https://www.w3.org/TR/DOM-Level-3-Events/#dom-event-architecture)
if you're new to web programming.

要响应点击、焦点变化、选择等外部事件，请添加事件监听器。
页面上的任何元素都可以添加事件监听器。
事件分发和传播是一个复杂的主题；
如果你刚接触 Web 编程，请 [查阅细节](https://www.w3.org/TR/DOM-Level-3-Events/#dom-event-architecture)。

Add an event handler using
<code><em>element</em>.on<em>Event</em>.listen(<em>function</em>)</code>,
where <code><em>Event</em></code> is the event
name and <code><em>function</em></code> is the event handler.

使用
<code><em>element</em>.on<em>Event</em>.listen(<em>function</em>)</code>
添加事件处理器，
其中 <code><em>Event</em></code> 是事件名，
<code><em>function</em></code> 是事件处理器。

For example, here's how you can handle clicks on a button:

例如，可以这样处理按钮点击：

<?code-excerpt "html/lib/html.dart (on-click)"?>
```dart
// Find a button by ID and add an event handler.
querySelector('#submitInfo')!.onClick.listen((e) {
  // When the button is clicked, it runs this code.
  submitData();
});
```

Events can propagate up and down through the DOM tree. To discover which
element originally fired the event, use `e.target`:

事件可以沿着 DOM 树向上或向下传播。
要找出最初触发事件的元素，请使用 `e.target`：

<?code-excerpt "html/lib/html.dart (target)"?>
```dart
document.body!.onClick.listen((e) {
  final clickedElem = e.target;
  // ...
});
```

To see all the events for which you can register an event listener, look
for "onEventType" properties in the API docs for [Element][] and its
subclasses. Some common events include:

要查看可以注册监听器的全部事件，
请在 [Element][Element] 及其子类的 API 文档中查找 "onEventType" 属性。
一些常见事件包括：

-   change

    change（内容变更）

-   blur

    blur（失去焦点）

-   keyDown

    keyDown（按下按键）

-   keyUp

    keyUp（松开按键）

-   mouseDown

    mouseDown（按下鼠标）

-   mouseUp

    mouseUp（松开鼠标）


## Using HTTP resources with HttpRequest

## 使用 HttpRequest 访问 HTTP 资源

You should avoid directly using `dart:html` to make HTTP requests.
The [`HttpRequest`][] class in `dart:html` is platform-dependent
and tied to a single implementation.
Instead, use a higher-level library like
[`package:http`]({{site.pub-pkg}}/http).

应当避免直接使用 `dart:html` 发起 HTTP 请求。
`dart:html` 中的 [`HttpRequest`][] 类依赖具体平台，
并且绑定到单一实现。
请改用更高层的库，例如
[`package:http`]({{site.pub-pkg}}/http)。

The [Fetch data from the internet][] tutorial
explains how to make HTTP requests
using `package:http`.

[从互联网获取数据][Fetch data from the internet] 教程
说明如何使用 `package:http` 发起 HTTP 请求。

## Sending and receiving real-time data with WebSockets

## 使用 WebSocket 收发实时数据

A WebSocket allows your web app to exchange data with a server
interactively—no polling necessary. A server creates the WebSocket and
listens for requests on a URL that starts with **ws://**—for example,
ws://127.0.0.1:1337/ws. The data transmitted over a WebSocket can be a
string or a blob.  Often, the data is a JSON-formatted string.

WebSocket 让 Web 应用与服务器交互式地交换数据，无需轮询。
服务器创建 WebSocket，并在以 **ws://** 开头的 URL 上监听请求，
例如 ws://127.0.0.1:1337/ws。
通过 WebSocket 传输的数据可以是字符串或 blob。
数据常常是 JSON 格式的字符串。

To use a WebSocket in your web app, first create a [WebSocket][] object, passing
the WebSocket URL as an argument:

要在 Web 应用中使用 WebSocket，
首先创建 [WebSocket][WebSocket] 对象，并把 WebSocket URL 作为参数传入：

{% comment %}
Code inspired by:
https://github.com/dart-lang/dart-samples/blob/master/html5/web/websockets/basics/websocket_sample.dart

Once tests are written for the samples, consider getting code excerpts from
the websocket sample app.
{% endcomment %}

<?code-excerpt "html/test/html_test.dart (WebSocket)"?>
```dart
var ws = WebSocket('ws://echo.websocket.org');
```

### Sending data

### 发送数据

To send string data on the WebSocket, use the `send()` method:

要用 WebSocket 发送字符串数据，请使用 `send()` 方法：

<?code-excerpt "html/test/html_test.dart (send)"?>
```dart
ws.send('Hello from Dart!');
```

### Receiving data

### 接收数据

To receive data on the WebSocket, register a listener for message
events:

要在 WebSocket 上接收数据，请为 message 事件注册监听器：

<?code-excerpt "html/test/html_test.dart (onMessage)" plaster="none"?>
```dart
ws.onMessage.listen((MessageEvent e) {
  print('Received message: ${e.data}');
});
```

The message event handler receives a [MessageEvent][] object.
This object's `data` field has the data from the server.

message 事件处理器收到一个 [MessageEvent][MessageEvent] 对象。
该对象的 `data` 字段包含来自服务器的数据。

### Handling WebSocket events

### 处理 WebSocket 事件

Your app can handle the following WebSocket events: open, close, error,
and (as shown earlier) message. Here's an example of a method that
creates a WebSocket object and registers handlers for open, close,
error, and message events:

应用可以处理以下 WebSocket 事件：open、close、error，
以及（如前所示）message。
下面的方法会创建 WebSocket 对象，
并为 open、close、error 和 message 事件注册处理器：

<?code-excerpt "html/test/html_test.dart (initWebSocket)" plaster="none"?>
```dart
void initWebSocket([int retrySeconds = 1]) {
  var reconnectScheduled = false;

  print('Connecting to websocket');

  void scheduleReconnect() {
    if (!reconnectScheduled) {
      Timer(
        Duration(seconds: retrySeconds),
        () => initWebSocket(retrySeconds * 2),
      );
    }
    reconnectScheduled = true;
  }

  ws.onOpen.listen((e) {
    print('Connected');
    ws.send('Hello from Dart!');
  });

  ws.onClose.listen((e) {
    print('Websocket closed, retrying in $retrySeconds seconds');
    scheduleReconnect();
  });

  ws.onError.listen((e) {
    print('Error connecting to ws');
    scheduleReconnect();
  });

  ws.onMessage.listen((MessageEvent e) {
    print('Received message: ${e.data}');
  });
}
```


## More information

## 更多信息

This section barely scratched the surface of using the dart:html
library. For more information, see the documentation for
[dart:html.][dart:html]
Dart has additional libraries for more specialized web APIs, such as
[web audio,][web audio] [IndexedDB,][IndexedDB] and [WebGL.][WebGL]

本节只是浅谈 dart:html 库的用法。
更多信息请参阅 [dart:html][dart:html] 的文档。
Dart 还有面向更专门的 Web API 的库，例如
[Web Audio][web audio]、[IndexedDB][IndexedDB] 和 [WebGL][WebGL]。

For more information about Dart web libraries, see the
[web library overview.][web library overview]

关于 Dart Web 库的更多信息，
请参阅 [Web 库概览][web library overview]。

[AnchorElement]: {{site.dart-api}}/dart-html/AnchorElement-class.html
[dart:html]: {{site.dart-api}}/dart-html/dart-html-library.html
[Fetch data from the internet]: /server/fetch-data
[Document]: {{site.dart-api}}/dart-html/Document-class.html
[Element]: {{site.dart-api}}/dart-html/Element-class.html
[`HttpRequest`]: {{site.dart-api}}/dart-html/HttpRequest-class.html
[IndexedDB]: {{site.dart-api}}/dart-indexed_db/dart-indexed_db-library.html
[MessageEvent]: {{site.dart-api}}/dart-html/MessageEvent-class.html
[Nodes]: {{site.dart-api}}/dart-html/Node-class.html
[web audio]: {{site.dart-api}}/dart-web_audio/dart-web_audio-library.html
[WebGL]: {{site.dart-api}}/dart-web_gl/dart-web_gl-library.html
[WebSocket]: {{site.dart-api}}/dart-html/WebSocket-class.html
[web library overview]: /web/libraries
[Window]: {{site.dart-api}}/dart-html/Window-class.html
