---
# title: "Building a Chat App in Dart"
title: "用 Dart 构建聊天应用"
# description: "Having thoroughly covered the basics of the “built” packages I’m now ready to up the ante by showing them in action."
description: "在全面介绍完 “built” 系列 package 的基础知识之后，我现在准备更进一步，展示它们的实际用法。"
ai-translated: true
publishDate: 2016-12-14
author: davidmorgan
image: images/1pRJK2IRC697oavw5OBXkQA.webp
category: deep-dive
layout: blog
---


I wrote this code in a day and a half to use as an example in my [talk at the Dart summit (video)](https://www.youtube.com/watch?v=TMeJxWltoVo). It was designed to show off built_value and source_gen, but it also shows something about Dart: that you can do a *lot* with just the SDK and the core packages from [dart-lang](http://github.com/dart-lang).

我花了一天半写出这些代码，用作我在 [Dart 峰会演讲（视频）](https://www.youtube.com/watch?v=TMeJxWltoVo)中的示例。
它的设计初衷是展示 built_value 和 source_gen，
但它也说明了 Dart 的一个特点：只靠 SDK 和
[dart-lang](http://github.com/dart-lang) 的核心 package，
你就能做*非常多*的事情。

<DashImage src="images/1pRJK2IRC697oavw5OBXkQA.webp" alt="Example chat app built with the built_value package running in a browser." caption="The built_value chat example in action." />


## Getting the Code

## 获取代码

You could read the code [here](https://github.com/google/built_value.dart/tree/8697b3e858c3af18246a1ac01ba7f582eab5428a/chat_example) but it’ll be more fun if you download and run it. To do that you’ll need [dart](https://www.dartlang.org/install) and [git](https://git-scm.com/downloads) installed. Then:

你可以在[这里](https://github.com/google/built_value.dart/tree/8697b3e858c3af18246a1ac01ba7f582eab5428a/chat_example)阅读代码，
但把它下载下来跑起来会更有意思。
为此你需要先安装 [dart](https://www.dartlang.org/install)
和 [git](https://git-scm.com/downloads)。然后：

```
git clone [https://github.com/google/built_value.dart.git](https://github.com/google/built_value.dart.git)
cd built_value.dart
git checkout tags/v0.4.3-article
cd chat_example
pub get

# Run these three in separate terminal windows.
pub serve
dart bin/main.dart
dart tool/watch.dart
```


You can now go to localhost:26199 in Dartium, Chrome or any modern browser. You’ll see something like this:

现在你可以在 Dartium、Chrome 或任何现代浏览器中打开
localhost:26199。你会看到类似这样的内容：
> Welcome to the built_value chat example. For help, type /help.
> You are connected as anon9531.

> 欢迎来到 built_value 聊天示例。输入 /help 获取帮助。
> 你已以 anon9531 的身份连接。

It’s not particularly beautiful — but if you connect in a few more tabs, you’ll find it’s a fully functional chat application. It has login, away/status messages, and public and private messages.

它算不上漂亮——但如果你再多开几个标签页连接进来，
就会发现它是一个功能完整的聊天应用。
它有登录、离开/状态消息，以及公开和私密消息。

If you change the code you’ll find that client changes are picked up immediately on refresh. For server changes, kill then relaunch “dart bin/main.dart”.

如果你修改代码，会发现客户端的改动在刷新后立即生效。
服务端的改动则需要先终止再重新启动 “dart bin/main.dart”。

## What’s in a Chat App

## 聊天应用里有什么

Our server code is going to need to:

我们的服务端代码需要：

* serve HTML and CSS;

* track user state;

* send and receive messages.

  提供 HTML 和 CSS；

  跟踪用户状态；

  发送和接收消息。

The client is going to need to:

客户端需要：

* provide a UI that displays text and accepts input;

* send and receive messages.

  提供显示文本、接受输入的 UI；

  发送和接收消息。

Let’s take this piece by piece.

我们一块一块来看。

## Serving HTML and CSS

## 提供 HTML 和 CSS

I’m using [package:shelf](https://github.com/dart-lang/shelf#web-server-middleware-for-dart) from dart-lang. For a production service I’d want to pre-build resources to serve, but for now I’ll focus on developing, so HTML and CSS can just go straight to pub serve. Here’s a [Cascade](https://www.dartdocs.org/documentation/shelf/0.6.7%2B2/shelf/Cascade-class.html) that does that:

我用的是 dart-lang 的 [package:shelf](https://github.com/dart-lang/shelf#web-server-middleware-for-dart)。
对于生产环境的服务，我会想预先构建好要提供的资源，
但现在先专注于开发，所以 HTML 和 CSS 直接交给 pub serve 就行。
下面这个 [Cascade](https://www.dartdocs.org/documentation/shelf/0.6.7%2B2/shelf/Cascade-class.html) 就能做到：

```
var cascade = new Cascade()
  // Try sending requests to pub serve.
  .add(proxyHandler(Uri.parse(‘[http://localhost:8080’](http://localhost:8080'))))
  // If that didn't work, must be a problem with pub serve.
  .add((_) {
    print(‘Request failed. Check pub serve output for errors.’);
    return new Response.notFound(‘’);
  });
```


And a server:

再加一个服务器：

```
await io.serve(cascade.handler, 'localhost', 26199);
```


We’ll tweak this a bit later on to add message handling.

稍后我们会对它稍作调整，加上消息处理。

## Client UI

## 客户端 UI

A chat client doesn’t need much UI, and the SDK is more than up to the job. First, the text field. We need [querySelector](https://api.dartlang.org/stable/1.21.0/dart-html/querySelector.html), [HtmlEscape](https://api.dartlang.org/stable/1.21.0/dart-convert/HtmlEscape-class.html) and [Window](https://api.dartlang.org/stable/1.21.0/dart-html/Window-class.html):

聊天客户端不需要太多 UI，SDK 完全足以胜任。
首先是文本区域。我们需要 [querySelector](https://api.dartlang.org/stable/1.21.0/dart-html/querySelector.html)、
[HtmlEscape](https://api.dartlang.org/stable/1.21.0/dart-convert/HtmlEscape-class.html)
和 [Window](https://api.dartlang.org/stable/1.21.0/dart-html/Window-class.html)：

```
void addLocal(String text) {
  querySelector('#text').innerHtml +=
    '<div class="local">${_htmlEscape.convert(text)}</div>';
  window.scrollTo(0, document.body.scrollHeight);
}
```


And second, the input field. Here’s a class which turns text input in a [Stream&lt;String&gt;](https://api.dartlang.org/stable/1.21.0/dart-async/Stream-class.html) for anyone to consume:

其次是输入框。下面这个类把文本输入转换成
[Stream&lt;String&gt;](https://api.dartlang.org/stable/1.21.0/dart-async/Stream-class.html)，
供任何需要的地方消费：

```
class Input {
  final StreamController<String> _streamController =
      new StreamController<String>();

  Input() {
    final input = querySelector('#input') as InputElement;

    input.onKeyPress.listen((keyEvent) {
      if (keyEvent.keyCode == KeyCode.ENTER) {
        _streamController.add(input.value);
        input.value = '';
       }
    });
  }

  Stream<String> get keyboardInput => _streamController.stream;
}
```


These sit on top of some minimal [HTML](https://github.com/google/built_value.dart/blob/8697b3e858c3af18246a1ac01ba7f582eab5428a/chat_example/web/index.html) and [CSS](https://github.com/google/built_value.dart/blob/8697b3e858c3af18246a1ac01ba7f582eab5428a/chat_example/web/main.css). Then we need a little bit of code to make sure the input element starts with focus and keeps it:

这些代码建立在极简的 [HTML](https://github.com/google/built_value.dart/blob/8697b3e858c3af18246a1ac01ba7f582eab5428a/chat_example/web/index.html) 和 [CSS](https://github.com/google/built_value.dart/blob/8697b3e858c3af18246a1ac01ba7f582eab5428a/chat_example/web/main.css) 之上。
然后还需要一小段代码，确保输入元素一开始就获得焦点并保持焦点：

```
var screen = querySelector('#screen');
var text = querySelector('#text');
var input = querySelector('#input');

input.focus();

for (var element in [screen, text]) {
  element.onClick.listen((e) {
    input.focus();
  });
}
```


And that’s *it*. No need for any kind of framework. Obviously, the UI is very minimal — if I wanted to do more I’d switch to [Angular](http://angulardart.org).

这就*够了*。完全不需要任何框架。
当然，这个 UI 非常简陋——如果想做更多，我会改用 [Angular](http://angulardart.org)。

## Client-Server Communication

## 客户端与服务端通信

Chat applications need to be able to send messages from the server to the client, so simple POSTs aren’t enough. I opted to use [WebSocket](https://api.dartlang.org/stable/1.21.0/dart-html/WebSocket-class.html)s, which provide persistent two-way communication channels.

聊天应用需要能从服务端向客户端发送消息，
所以简单的 POST 请求不够用。我选择使用 [WebSocket](https://api.dartlang.org/stable/1.21.0/dart-html/WebSocket-class.html)，
它提供持久的双向通信通道。

With shelf we can just add this to the start of our Cascade:

用 shelf 的话，只需在 Cascade 的开头加上这段：

```
var cascade = new Cascade()
 .add(webSocketHandler(socketReceiver))
```


Where “socketReceiver” is a function that accepts the newly created [WebSocketChannel](https://www.dartdocs.org/documentation/web_socket_channel/1.0.4/web_socket_channel/WebSocketChannel-class.html)s. “webSocketHandler” will reject plain HTTP requests, so those will continue down the cascade.

其中 “socketReceiver” 是一个接收新创建的 [WebSocketChannel](https://www.dartdocs.org/documentation/web_socket_channel/1.0.4/web_socket_channel/WebSocketChannel-class.html) 的函数。
“webSocketHandler” 会拒绝普通 HTTP 请求，
这些请求会继续沿着 cascade 向下传递。

Connecting from the client is likewise simple:

从客户端发起连接同样简单：

```
var socket = new WebSocket('ws://${window.location.host}/ws');
socket.onMessage.listen((message) => <handle message>);
socket.send('Hello server!');
```


Of course we need a wire format; since I wrote this code to show off built_value I’m of course using its [serialization](https://medium.com/@davidmorgan_14314/darts-built-value-for-serialization-f5db9d0f4159#.3nh1y6q6h). Just plain JSON with hand-written conversion would be straightforward — but the whole point of built_value is that you get that for free.

当然我们还需要一种传输格式；既然写这份代码就是为了展示 built_value，
我自然用了它的[序列化](https://medium.com/@davidmorgan_14314/darts-built-value-for-serialization-f5db9d0f4159#.3nh1y6q6h)。
手写转换逻辑来处理纯 JSON 也不难——
但 built_value 的意义就在于这些你都能免费获得。

## Web Sockets and SSL

## WebSocket 与 SSL

One side note: currently, the example uses non-encrypted connections. Unfortunately non-encrypted web socket connections can sometimes be blocked by badly-behaved proxies. The way to fix this is to switch to encrypting your entire site, i.e. making it “https” instead of “http”. This is a pain to do, but it’s arguably a good idea for [other reasons](https://letsencrypt.org/).

顺带一提：目前这个示例用的是未加密连接。
不幸的是，未加密的 WebSocket 连接有时会被行为不端的代理拦截。
解决办法是给整个站点启用加密，也就是把 “http” 换成 “https”。
这件事做起来挺麻烦，但出于[其他原因](https://letsencrypt.org/)，这也可以说是个好主意。

## Object Model

## 对象模型

At the heart of the chat example is an object model that’s shared between the server and the client. Because we’re using built_value we can send these classes over the wire. For example, this class is used to send a chat:

聊天示例的核心是一套在服务端和客户端之间共享的对象模型。
因为用了 built_value，我们可以把这些类直接通过网络发送。
例如，下面这个类用来发送一条聊天消息：

```
abstract class Chat implements Command {
  String get text;
  BuiltSet<String> get targets;
}
```


The server login, client logic and client rendering are all built around these object model classes.

服务端登录、客户端逻辑和客户端渲染都围绕这些对象模型类构建。

## Client Logic

## 客户端逻辑

When you type something the client code needs to match and handle possible commands. This is a simple matter of string matching followed by building and sending object model classes as appropriate. [Full code](https://github.com/google/built_value.dart/blob/8697b3e858c3af18246a1ac01ba7f582eab5428a/chat_example/lib/client/client.dart).

当你输入内容时，客户端代码需要匹配并处理可能的命令。
这不过是先做字符串匹配，再按需构建并发送对象模型类。
[完整代码](https://github.com/google/built_value.dart/blob/8697b3e858c3af18246a1ac01ba7f582eab5428a/chat_example/lib/client/client.dart)。

For example, if you type something starting with “/away”, it’s converted into a status update:

例如，如果你输入以 “/away” 开头的内容，它会被转换成一条状态更新：

```
_send(new Status((b) => b
  ..message = command.substring(‘/away ‘.length)
  ..type = StatusType.away));
```


## Client Rendering

## 客户端渲染

All the messages that the server can send implement this interface:

服务端能发送的所有消息都实现了这个接口：

```
abstract class Response {
  String render();
}
```


And so on receiving a message the client simply calls “render” and displays the result. For example, the ShowChat class, which can hold public or private messages:

于是客户端收到消息后只需调用 “render” 并显示结果。
例如 ShowChat 类，它可以承载公开或私密消息：

```
class ShowChat implements Response {
  String get username;
  bool get private;
  String get text;

  @override
  String render() =>
    '$username${private ? "(private)" : ""}: $text';
}
```


Incidentally, this pattern of encapsulating simple rendering logic inside data classes also works well for internationalization.

顺带一提，这种把简单渲染逻辑封装在数据类里的模式，
用在国际化上也很合适。

## Server Logic

## 服务端逻辑

In the server we keep the state: the chat log, usernames and passwords, and user statuses. When a message is received, we update the state and send out messages as needed. [Full code](https://github.com/google/built_value.dart/blob/8697b3e858c3af18246a1ac01ba7f582eab5428a/chat_example/lib/server/server.dart).

服务端保存着状态：聊天记录、用户名和密码，以及用户状态。
收到消息时，我们更新状态并按需发出消息。
[完整代码](https://github.com/google/built_value.dart/blob/8697b3e858c3af18246a1ac01ba7f582eab5428a/chat_example/lib/server/server.dart)。

For example, here “command” is a message received from a client. If it’s a “chat” message, we check whether it’s intended to be private — if it specifies targets — and either send it to everyone or to just the targets, as appropriate.

例如，这里的 “command” 是从客户端收到的消息。
如果它是 “chat” 消息，我们就检查它是否打算私发——
也就是是否指定了目标——然后按需发给所有人或只发给目标用户。

```
if (command is Chat) {
  _chat(connection, command);
}

...

void _chat(ServerConnection connection, Chat chat) {
  if (chat.targets.isEmpty) {
    _sendToAll(new ShowChat((b) => b
      ..username = connection.username
      ..private = false
      ..text = chat.text));
  } else {
    _sendTo(
      chat.targets,
      new ShowChat((b) => b
        ..username = connection.username
        ..private = true
        ..text = chat.text));
  }
}
```


## That’s All, Folks

## 就到这里了，各位

And there we have it — a chat server and client in 820 lines of code. For those keeping count, an additional 1120 lines is generated by built_value, and end to end testing took 155 lines.

大功告成——820 行代码写就的聊天服务端和客户端。
如果你在数的话：built_value 另外生成了 1120 行代码，
端到端测试用了 155 行。

Wait — end to end testing?

等等——端到端测试？

I said it took a day and a half to write; half-way through I got annoyed that every time I added a feature I had to manually test to make sure I hadn’t broken anything else. So I took a step back, refactored for testability, and added test coverage for the major features.

我说过写它花了一天半；写到一半时我很恼火：
每次加新功能都得手动测试，确保没弄坏别的东西。
于是我退后一步，为可测试性做了重构，
并给主要功能补上了测试覆盖。

Next week I’ll walk through exactly how the chat example is tested, and just how great it is to test with Dart on both the server and client.

下周我会详细介绍这个聊天示例是如何测试的，
以及在服务端和客户端都用 Dart 做测试有多棒。

Edit: [next article](https://medium.com/@davidmorgan_14314/end-to-end-testing-in-one-short-second-with-dart-e699c8146fd6#.c7xfxohg4).

编辑补充：[下一篇文章](https://medium.com/@davidmorgan_14314/end-to-end-testing-in-one-short-second-with-dart-e699c8146fd6#.c7xfxohg4)。
