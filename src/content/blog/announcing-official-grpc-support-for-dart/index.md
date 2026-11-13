---
# title: "Announcing official gRPC support for Dart"
title: "宣布 Dart 官方 gRPC 支持"
# description: "gRPC is a high performance, open source RPC framework. It offers simple service definitions, is built on http/2, and has support for…"
description: "gRPC 是一个高性能的开源 RPC 框架。它提供简单的服务定义，构建于 http/2 之上，并支持……"
ai-translated: true
publishDate: 2018-03-23
author: mit-mit
category: announcements
layout: blog
---


<DashImage src="images/1tWFciSm58uLmvp8i_t3WaQ.webp" alt="The gRPC logo." />


gRPC is a high performance, open source RPC framework. It offers simple service definitions, is built on http/2, and has support for bi-directional streaming and fully integrated pluggable authentication. The gRPC framework supports a [wide range of languages](https://grpc.io/docs/), and we are happy to announce that support for the Dart language is now available in beta!Dart gRPC support works with the Dart SDK, version 1.24.3 or higher, and currently supports the [Flutter](https://flutter.io/) and [VM/Server](https://www.dartlang.org/dart-vm) platforms.

gRPC 是一个高性能的开源 RPC 框架。它提供简单的服务定义，构建于 http/2 之上，支持双向流式传输和完全集成的可插拔认证。gRPC 框架支持[多种语言](https://grpc.io/docs/)，我们很高兴地宣布，Dart 语言的支持现已进入 beta！Dart gRPC 支持适用于 Dart SDK 1.24.3 或更高版本，目前支持 [Flutter](https://flutter.io/) 和 [VM/服务器](https://www.dartlang.org/dart-vm)平台。

## Creating a server and writing gRPC service definitions

## 创建服务器并编写 gRPC 服务定义

gRPC services typically describe their endpoints and data serialization using [Protocol Buffers](https://github.com/dart-lang/protobuf) v3. Here is a small example service definition which defines a service ‘Greeter’ with a single rpc message ‘SayHello’ (the number ‘1’ in the two messages specifies the unique ID of the [message field](https://developers.google.com/protocol-buffers/docs/overview)):

gRPC 服务通常使用 [Protocol Buffers](https://github.com/dart-lang/protobuf) v3 描述其端点和数据序列化。下面是一个小的服务定义示例，定义了带单个 rpc 消息 ‘SayHello’ 的服务 ‘Greeter’（两条消息中的数字 ‘1’ 指定了[消息字段](https://developers.google.com/protocol-buffers/docs/overview)的唯一 ID）：


Once you have defined the service, you can automatically generate the skeleton of the server:

定义好服务后，就可以自动生成服务器骨架：

```
protoc --dart_out=grpc:generated -Iprotos protos/greeter.proto
```


This will produce a GreeterServiceBase class in the `generated` directory, which you then subclass to add the actual service implementation:

这会在 `generated` 目录中生成一个 GreeterServiceBase 类，你再继承它来添加实际的服务实现：


## Calling the server with a gRPC client

## 用 gRPC 客户端调用服务器

When we generated the service stub above, the `protoc` compiler also generated a client library:

在上面生成服务桩代码时，`protoc` 编译器还生成了一个客户端库：


With that, calling into the service from the client tier is simple:

有了它，从客户端调用服务就很简单了：


When run, this will print the following output:

运行后会打印以下输出：

```
Greeter client received: Hello, Michael!
```


## Next steps

## 下一步

To get started with gRPC in Dart, please take a look at our new [Dart gRPC QuickStart](https://grpc.io/docs/quickstart/dart.html), which walks you through running and extending the Greeter example. Next, check out the [Dart gRPC tutorial](https://grpc.io/docs/tutorials/basic/dart.html).

要开始在 Dart 中使用 gRPC，请阅读我们新的 [Dart gRPC 快速入门](https://grpc.io/docs/quickstart/dart.html)，它会带你运行并扩展 Greeter 示例。接着可以看看 [Dart gRPC 教程](https://grpc.io/docs/tutorials/basic/dart.html)。

Should you encounter any problems, please [file an issue](https://github.com/grpc/grpc-dart/issues/new). We would also gladly hear your feedback on any changes or additions you like to see; for example, we have heard several requests for supporting the [gRPC-Web protocol](https://github.com/grpc/grpc-dart/issues/43). One concrete way of offering quick feedback is to ‘cast a vote’ on an issue by pressing the GitHub thumbs-up 👍 button on the top-most comment of an issue.

如果遇到任何问题，请[提交 issue](https://github.com/grpc/grpc-dart/issues/new)。我们也很乐意听取你对任何改动或新增功能的反馈；例如，我们已经听到多个支持 [gRPC-Web 协议](https://github.com/grpc/grpc-dart/issues/43)的请求。快速反馈的一个具体方式是在 issue 最上面的评论上点 GitHub 的 👍 按钮，为该 issue“投一票”。

We look forward to seeing what you might build with gRPC for Dart!

期待看到你用 Dart 版 gRPC 构建的作品！
