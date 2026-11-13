---
# title: dart:io
title: dart:io
# description: Learn about the major features in Dart's dart:io library.
description: 了解 Dart dart:io 库的主要功能。
prevpage:
  url: /libraries/dart-convert
# title: dart:convert
  title: dart:convert
nextpage:
  url: /interop/js-interop/
# title: dart:js_interop
  title: dart:js_interop
ai-translated: true
---

<?code-excerpt plaster="none"?>

The [dart:io][] library provides APIs to deal with
files, directories, processes, sockets, WebSockets, and HTTP
clients and servers.

[dart:io][dart:io] 库提供用于处理文件、目录、进程、套接字、
WebSocket，以及 HTTP 客户端和服务器的 API。

:::important
Only non-web [Flutter apps,]({{site.flutter}}) command-line scripts, 
and servers can import and use `dart:io`, not web apps.

只有非 Web 的 [Flutter 应用]({{site.flutter}})、命令行脚本和服务器
可以导入并使用 `dart:io`，Web 应用不行。
:::

In general, the dart:io library implements and promotes an asynchronous
API. Synchronous methods can easily block an application, making it
difficult to scale. Therefore, most operations return results via Future
or Stream objects, a pattern common with modern server platforms such as
Node.js.

总体而言，dart:io 库实现并提倡异步 API。
同步方法很容易阻塞应用，使其难以扩展。
因此，大多数操作通过 Future 或 Stream 对象返回结果，
这是 Node.js 等现代服务端平台的常见模式。

The few synchronous methods in the dart:io library are clearly marked
with a Sync suffix on the method name. Synchronous methods aren't covered here.

dart:io 库中为数不多的同步方法会在方法名上明确标出 Sync 后缀。
本文不介绍同步方法。

To use the dart:io library you must import it:

要使用 dart:io 库，必须导入它：

<?code-excerpt "misc/test/library_tour/io_test.dart (import)"?>
```dart
import 'dart:io';
```

## Files and directories

## 文件和目录

The I/O library enables command-line apps to read and write files and
browse directories. You have two choices for reading the contents of a
file: all at once, or streaming. Reading a file all at once requires
enough memory to store all the contents of the file. If the file is very
large or you want to process it while reading it, you should use a
Stream, as described in
[Streaming file contents](#streaming-file-contents).

I/O 库让命令行应用可以读写文件并浏览目录。
读取文件内容有两种方式：一次读完，或流式读取。
一次读完需要足够的内存来存放文件的全部内容。
如果文件很大，或者希望边读边处理，
应使用 Stream，见
[以流的方式读取文件内容](#streaming-file-contents)。

### Reading a file as text

### 按文本读取文件

When reading a text file encoded using UTF-8, you can read the entire
file contents with `readAsString()`. When the individual lines are
important, you can use `readAsLines()`. In both cases, a Future object
is returned that provides the contents of the file as one or more
strings.

读取 UTF-8 编码的文本文件时，
可以用 `readAsString()` 读取全部内容。
如果关心每一行，可以使用 `readAsLines()`。
两种方式都会返回一个 Future，
以一个或多个字符串提供文件内容。

<?code-excerpt "misc/test/library_tour/io_test.dart (read-as-string)" replace="/\btest_data\///g"?>
```dart
void main() async {
  var config = File('config.txt');

  // Put the whole file in a single string.
  var stringContents = await config.readAsString();
  print('The file is ${stringContents.length} characters long.');

  // Put each line of the file into its own string.
  var lines = await config.readAsLines();
  print('The file is ${lines.length} lines long.');
}
```


### Reading a file as binary

### 按二进制读取文件

The following code reads an entire file as bytes into a list of ints.
The call to `readAsBytes()` returns a Future, which provides the result
when it's available.

下面的代码把整个文件按字节读入一个 int 列表。
`readAsBytes()` 返回一个 Future，结果就绪后即可取得。

<?code-excerpt "misc/test/library_tour/io_test.dart (read-as-bytes)" replace="/\btest_data\///g"?>
```dart
void main() async {
  var config = File('config.txt');

  var contents = await config.readAsBytes();
  print('The file is ${contents.length} bytes long.');
}
```

### Handling errors

### 处理错误

To capture errors so they don't result in uncaught exceptions, you can
register a `catchError` handler on the Future,
or (in an `async` function) use try-catch:

为了捕获错误，避免它们变成未捕获的异常，
可以在 Future 上注册 `catchError` 处理器，
或者（在 `async` 函数中）使用 try-catch：

<?code-excerpt "misc/test/library_tour/io_test.dart (try-catch)" replace="/does-not-exist/config/g"?>
```dart
void main() async {
  var config = File('config.txt');
  try {
    var contents = await config.readAsString();
    print(contents);
  } catch (e) {
    print(e);
  }
}
```

### Streaming file contents

### 以流的方式读取文件内容

Use a Stream to read a file, a little at a time.
You can use either the [Stream API](/libraries/dart-async#stream)
or `await for`, part of Dart's
[asynchrony support.](/language/async)

用 Stream 可以每次读取文件的一小部分。
可以使用 [Stream API](/libraries/dart-async#stream)，
也可以使用 `await for`，它是 Dart
[异步支持](/language/async) 的一部分。

<?code-excerpt "misc/test/library_tour/io_test.dart (read-from-stream)" replace="/_?test_\w*\/?//g"?>
```dart
import 'dart:io';
import 'dart:convert';

void main() async {
  var config = File('config.txt');
  Stream<List<int>> inputStream = config.openRead();

  var lines = utf8.decoder.bind(inputStream).transform(const LineSplitter());
  try {
    await for (final line in lines) {
      print('Got ${line.length} characters from stream');
    }
    print('file is now closed');
  } catch (e) {
    print(e);
  }
}
```

### Writing file contents

### 写入文件内容

You can use an [IOSink][] to
write data to a file. Use the File `openWrite()` method to get an IOSink
that you can write to. The default mode, `FileMode.write`, completely
overwrites existing data in the file.

可以用 [IOSink][IOSink] 把数据写入文件。
调用 File 的 `openWrite()` 方法得到可写入的 IOSink。
默认模式 `FileMode.write` 会完全覆盖文件中已有的数据。

<?code-excerpt "misc/test/library_tour/io_test.dart (write-file)" replace="/\btest_data\///g"?>
```dart
var logFile = File('log.txt');
var sink = logFile.openWrite();
sink.write('FILE ACCESSED ${DateTime.now()}\n');
await sink.flush();
await sink.close();
```

To add to the end of the file, use the optional `mode` parameter to
specify `FileMode.append`:

要追加到文件末尾，请用可选的 `mode` 参数指定 `FileMode.append`：

<?code-excerpt "misc/test/library_tour/io_test.dart (append)" replace="/_?test_\w*\/?//g"?>
```dart
var sink = logFile.openWrite(mode: FileMode.append);
```

To write binary data, use `add(List<int> data)`.

要写入二进制数据，请使用 `add(List<int> data)`。


### Listing files in a directory

### 列出目录中的文件

Finding all files and subdirectories for a directory is an asynchronous
operation. The `list()` method returns a Stream that emits an object
when a file or directory is encountered.

查找目录下的所有文件和子目录是异步操作。
`list()` 方法返回一个 Stream，
每遇到一个文件或目录就发出一个对象。

<?code-excerpt "misc/test/library_tour/io_test.dart (list-dir)" replace="/\btest_data\b/tmp/g"?>
```dart
void main() async {
  var dir = Directory('tmp');

  try {
    var dirList = dir.list();
    await for (final FileSystemEntity f in dirList) {
      if (f is File) {
        print('Found file ${f.path}');
      } else if (f is Directory) {
        print('Found dir ${f.path}');
      }
    }
  } catch (e) {
    print(e.toString());
  }
}
```


### Other common functionality

### 其他常用功能

The File and Directory classes contain other functionality, including
but not limited to:

File 和 Directory 类还包含其他功能，包括但不限于：

- Creating a file or directory: `create()` in File and Directory

  创建文件或目录：File 和 Directory 中的 `create()`

- Deleting a file or directory: `delete()` in File and Directory

  删除文件或目录：File 和 Directory 中的 `delete()`

- Getting the length of a file: `length()` in File

  获取文件长度：File 中的 `length()`

- Getting random access to a file: `open()` in File

  随机访问文件：File 中的 `open()`

Refer to the API docs for [File][] and [Directory][] for a full
list of methods.

方法的完整列表请参阅 [File][File] 和 [Directory][Directory] 的 API 文档。


## HTTP clients and servers

## HTTP 客户端和服务器

The dart:io library provides classes that command-line apps can use for
accessing HTTP resources, as well as running HTTP servers.

dart:io 库提供的类可以让命令行应用访问 HTTP 资源，
也可以运行 HTTP 服务器。

### HTTP server

### HTTP 服务器

The [HttpServer][] class
provides the low-level functionality for building web servers. You can
match request handlers, set headers, stream data, and more.

[HttpServer][HttpServer] 类提供构建 Web 服务器的底层功能。
你可以匹配请求处理器、设置标头、流式传输数据等。

The following sample web server returns simple text information.
This server listens on port 8888 and address 127.0.0.1 (localhost),
responding to requests for the path `/dart`. For any other path,
the response is status code 404 (page not found).

下面的示例 Web 服务器返回简单的文本信息。
服务器监听端口 8888 和地址 127.0.0.1（localhost），
对路径 `/dart` 的请求作出响应。
其他路径的响应状态码为 404（页面未找到）。

<?code-excerpt "misc/lib/library_tour/io/http_server.dart (process-requests)" replace="/Future<\w+\W/void/g; /\b_//g"?>
```dart
void main() async {
  final requests = await HttpServer.bind('localhost', 8888);
  await for (final request in requests) {
    processRequest(request);
  }
}

void processRequest(HttpRequest request) {
  print('Got request for ${request.uri.path}');
  final response = request.response;
  if (request.uri.path == '/dart') {
    response
      ..headers.contentType = ContentType('text', 'plain')
      ..write('Hello from the server');
  } else {
    response.statusCode = HttpStatus.notFound;
  }
  response.close();
}
```

### HTTP client

### HTTP 客户端

You should avoid directly using `dart:io` to make HTTP requests.
The [HttpClient][] class in `dart:io` is platform-dependent
and tied to a single implementation.
Instead, use a higher-level library like
[`package:http`]({{site.pub-pkg}}/http).

应当避免直接使用 `dart:io` 发起 HTTP 请求。
`dart:io` 中的 [HttpClient][HttpClient] 类依赖具体平台，
并且绑定到单一实现。
请改用更高层的库，例如
[`package:http`]({{site.pub-pkg}}/http)。

The [Fetch data from the internet][] tutorial
explains how to make HTTP requests
using `package:http`.

[从互联网获取数据][Fetch data from the internet] 教程
说明如何使用 `package:http` 发起 HTTP 请求。

## More information

## 更多信息

This page showed how to use the major features of the [dart:io][] library.
Besides the APIs discussed in this section, the dart:io library also
provides APIs for [processes,][Process] [sockets,][Socket] and
[web sockets.][WebSocket]
For more information about server-side and command-line app development, see the
[server-side Dart overview.](/server)

本页介绍了如何使用 [dart:io][dart:io] 库的主要功能。
除本节讨论的 API 外，dart:io 库还提供
[进程][Process]、[套接字][Socket] 和
[WebSocket][WebSocket] 的 API。
关于服务端和命令行应用开发的更多信息，
请参阅 [服务端 Dart 概览](/server)。


[dart:io]: {{site.dart-api}}/dart-io/dart-io-library.html
[Directory]: {{site.dart-api}}/dart-io/Directory-class.html
[Fetch data from the internet]: /server/fetch-data
[File]: {{site.dart-api}}/dart-io/File-class.html
[HttpClient]: {{site.dart-api}}/dart-io/HttpClient-class.html
[HttpRequest]: {{site.dart-api}}/dart-html/HttpRequest-class.html
[HttpServer]: {{site.dart-api}}/dart-io/HttpServer-class.html
[IOSink]: {{site.dart-api}}/dart-io/IOSink-class.html
[Process]: {{site.dart-api}}/dart-io/Process-class.html
[Socket]: {{site.dart-api}}/dart-io/Socket-class.html
[WebSocket]: {{site.dart-api}}/dart-io/WebSocket-class.html
