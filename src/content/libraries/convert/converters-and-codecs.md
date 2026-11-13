---
# title: Converters and codecs
title: 转换器与编解码器
# description: Learn how to write efficient conversions.
description: 了解如何编写高效的转换。
showBreadcrumbs: false
original-date: 2014-02-06
date: 2015-03-17
obsolete: true
ai-translated: true
---

_Written by Florian Loitsch <br>
February 2014 (updated March 2015)_

**作者：Florian Loitsch <br>
2014 年 2 月（2015 年 3 月更新）**

Converting data between different representations is a common task in computer
engineering. Dart is no exception and comes with
[dart:convert]({{site.dart-api}}/dart-convert/dart-convert-library.html), a
core library that provides a set of converters
and useful tools to build new converters.
Examples of converters provided by the library include those
for commonly used encodings such as JSON and UTF-8.
In this document, we show how Dart's
converters work and how you can create your own efficient converters
that fit into the Dart world.

在不同表示之间转换数据是计算机工程中的常见任务。
Dart 也不例外，它自带
[dart:convert]({{site.dart-api}}/dart-convert/dart-convert-library.html)，
这是一个核心库，提供一组转换器以及用来构建新转换器的实用工具。
该库提供的转换器包括 JSON 和 UTF-8 等常用编码的转换器。
本文说明 Dart 的转换器如何工作，
以及如何创建适合 Dart 体系、并且高效的转换器。

## Big picture

## 整体图景

Dart's conversion architecture is
based on _converters_, which translate from one representation to another.
When conversions are reversible, two converters are grouped together into a
_codec_ (coder-decoder). The term codec is frequently used for audio and
video processing but also applies to string encodings such as UTF-8 or JSON.

Dart 的转换架构基于 **转换器**，
它们把一种表示转换成另一种表示。
当转换可逆时，两个转换器会组合为一个 **编解码器**（编码器-解码器）。
编解码器这个词常用于音视频处理，
也适用于 UTF-8 或 JSON 这类字符串编码。


By convention, all converters in Dart use the abstractions provided in the
dart:convert library. This provides a consistent API for developers and ensures
that converters can work together.
For instance, converters (or codecs) can be fused together if their
type matches, and the resulting converter can then be used as a single unit.
Furthermore, these fused converters frequently work more efficiently than if
they had been used separately.

按照约定，Dart 中的所有转换器都使用 dart:convert 库提供的抽象。
这样开发者会有一致的 API，也能保证转换器可以协同工作。
例如，类型匹配时可以把转换器（或编解码器）融合在一起，
得到的转换器就能当作一个单元使用。
而且，这些融合后的转换器往往比分开使用更高效。

## Codec

## Codec 类

A codec is a combination of two converters where one encodes
and the other one decodes:

编解码器由两个转换器组成，一个负责编码，另一个负责解码：

```dart
abstract class Codec<S, T> {
  const Codec();

  T encode(S input) => encoder.convert(input);
  S decode(T encoded) => decoder.convert(encoded);

  Converter<S, T> get encoder;
  Converter<T, S> get decoder;

  Codec<S, dynamic> fuse(Codec<T, dynamic> other) { .. }
  Codec<T, S> get inverted => ...;
}
```

As can be seen, codecs provide convenience methods such as `encode()` and
`decode()` that are expressed in terms of the encoder and decoder. The `fuse()`
method and `inverted` getter allow you to fuse converters and
change the direction of a codec, respectively.
The base implementation of
[Codec]({{site.dart-api}}/dart-convert/Codec-class.html)
for these two members
provides a solid default implementation
and implementers usually don't need to worry about them.

可以看出，编解码器提供 `encode()` 和 `decode()` 这类便捷方法，
它们借助编码器和解码器来表达。
`fuse()` 方法和 `inverted` getter 分别用来融合转换器，
以及改变编解码器的方向。
[Codec]({{site.dart-api}}/dart-convert/Codec-class.html)
对这两个成员的基础实现提供了可靠的默认行为，
实现者通常不必操心它们。

The `encode()` and `decode()`
methods, too, may be left untouched, but they can be extended for additional
arguments. For example, the
[JsonCodec]({{site.dart-api}}/dart-convert/JsonCodec-class.html)
adds named arguments to `encode()` and `decode()`
to make these methods more useful:

`encode()` 和 `decode()` 方法也可以保持不动，
但可以为它们扩展额外参数。
例如，[JsonCodec]({{site.dart-api}}/dart-convert/JsonCodec-class.html)
给 `encode()` 和 `decode()` 增加了命名参数，
让这些方法更有用：

```dart
dynamic decode(String source, {reviver(var key, var value)}) { … }
String encode(Object value, {toEncodable(var object)}) { … }
```

The codec can be instantiated with arguments that are used as default
values, unless they are overridden by the named arguments during the
`encode()`/`decode()` call.

实例化编解码器时可以传入参数作为默认值，
除非在 `encode()`/`decode()` 调用时被命名参数覆盖。

```dart
const JsonCodec({reviver(var key, var value), toEncodable(var object)})
  ...
```

As a general rule: if a codec can be configured, it should add named arguments
to the `encode()`/`decode()` methods and allow their defaults to be
set in constructors.
When possible, codec constructors should be `const` constructors.

一般规则是：如果编解码器可以配置，
就应该给 `encode()`/`decode()` 方法加上命名参数，
并让它们的默认值能在构造函数中设定。
可能的话，编解码器的构造函数应该是 `const` 构造函数。

## Converter

## Converter 类

Converters, and in particular their `convert()` methods, are
where the real conversions happen:

真正的转换发生在转换器里，尤其是它们的 `convert()` 方法：

```dart
T convert(S input);  // where T is the target and S the source type.
```

A minimal converter implementation only needs to extend the
[Converter]({{site.dart-api}}/dart-convert/Converter-class.html) class and
implement the `convert()` method. Similar to the Codec class, converters can be
made configurable by extending the constructors and adding named arguments to
the `convert()` method.

最小的转换器实现只需扩展
[Converter]({{site.dart-api}}/dart-convert/Converter-class.html) 类
并实现 `convert()` 方法。
和 Codec 类类似，可以通过扩展构造函数、
给 `convert()` 方法增加命名参数，让转换器可配置。

Such a minimal converter works in synchronous settings, but
does not work when used with chunks (either synchronously or asynchronously). In
particular, such a simple converter doesn't work as a transformer (one of the
nicer features of Converters). A fully implemented converter implements the
[StreamTransformer]({{site.dart-api}}/dart-async/StreamTransformer-class.html)
interface and can thus be given to the `Stream.transform()` method.

这样的最小转换器在同步场景下可用，
但用于分块时（无论同步还是异步）就不起作用。
尤其是，这样简单的转换器不能当作转换器（transformer）使用，
而这是 Converter 比较好用的特性之一。
完整实现的转换器会实现
[StreamTransformer]({{site.dart-api}}/dart-async/StreamTransformer-class.html)
接口，因此可以传给 `Stream.transform()` 方法。

Probably the most common use case is the decoding of UTF-8 with
[utf8.decoder]({{site.dart-api}}/dart-convert/Utf8Codec-class.html):

最常见的用途大概是用
[utf8.decoder]({{site.dart-api}}/dart-convert/Utf8Codec-class.html)
解码 UTF-8：

```dart
File.openRead().transform(utf8.decoder).
```

## Chunked conversion

## 分块转换

The concept of chunked conversions can be confusing, but at its core, it is
relatively simple. When a chunked conversion (including a stream
transformation) is started, the converter's
[startChunkedConversion]({{site.dart-api}}/dart-convert/Converter/startChunkedConversion.html)
method is invoked with an output-
sink as argument. The method then returns an input sink into which the caller
puts data.

分块转换这个概念可能让人困惑，但核心相对简单。
开始分块转换（包括 Stream 转换）时，
会以输出 Sink 为参数调用转换器的
[startChunkedConversion]({{site.dart-api}}/dart-convert/Converter/startChunkedConversion.html)
方法。
该方法返回一个输入 Sink，调用方把数据放进去。

![Chunked conversion](/assets/img/articles/converters-and-codecs/chunked-conversion.png)

**Note**: An asterisk (`*`) in the diagram represents optional multiple calls.

**说明**：图中的星号（`*`）表示可选的多次调用。

In the diagram, the first step consists of creating an `outputSink` that should
be filled with the converted data. Then, the user invokes the
`startChunkedConversion()` method of the converter with the output sink.
The result is an input sink with methods `add()` and `close()`.

图中的第一步是创建一个 `outputSink`，用来装入转换后的数据。
然后，使用者把输出 Sink 传给转换器的 `startChunkedConversion()` 方法。
得到的是一个带有 `add()` 和 `close()` 方法的输入 Sink。

At a later point, the code that started the chunked conversion invokes,
possibly multiple times, the `add()` method with
some data. The data is converted by the input sink. If the converted data is
ready the input sink sends it to the output sink, possibly with multiple
`add()` calls. Eventually the user finishes the conversion by invoking
`close()`. At this point any remaining converted data is sent from the input
sink to the output sink and the output sink is closed.

之后，启动分块转换的代码会调用 `add()` 方法并传入一些数据，
可能会调用多次。输入 Sink 转换这些数据。
如果转换后的数据已经就绪，输入 Sink 会把它发给输出 Sink，
也可能多次调用 `add()`。
最终，使用者调用 `close()` 结束转换。
此时，剩余的已转换数据会从输入 Sink 发到输出 Sink，然后关闭输出 Sink。

Depending on the converter the input sink may need to buffer parts of the
incoming data. For example, a line-splitter that receives `ab\ncd` as the first
chunk can safely invoke its output sink with `ab`, but needs to wait for the
next data (or the `close()` call) before it can handle `cd`. If the next data is
`e\nf`, the input sink must concatenate `cd` and `e` and invoke the output sink
with the string `cde`, while buffering `f` for the next data event (or the
`close()` call).

取决于具体的转换器，输入 Sink 可能需要缓冲一部分传入数据。
例如，行分割器收到的第一块是 `ab\ncd` 时，
可以安全地用 `ab` 调用输出 Sink，
但必须等到下一段数据（或 `close()` 调用）才能处理 `cd`。
如果下一段数据是 `e\nf`，输入 Sink 必须把 `cd` 和 `e` 拼起来，
用字符串 `cde` 调用输出 Sink，
同时把 `f` 缓冲到下一次数据事件（或 `close()` 调用）。

The complexity of the input sink (in combination with the converter) varies.
Some chunked conversions are trivially mapped to the non-chunked versions (like
a String→String converter that removes the character `a`), while others are
more complicated. A safe, although inefficient (and usually unrecommended)
way to implement the chunked conversion is to buffer and concatenate all the
incoming data and to do the conversion in one go. This is, how the JSON decoder
is currently (January 2014) implemented.

输入 Sink（连同转换器）的复杂程度各不相同。
有些分块转换可以平凡地对应到非分块版本
（例如去掉字符 `a` 的 String→String 转换器），
另一些则更复杂。
一种安全但不高效（通常不推荐）的分块转换实现方式是：
缓冲并拼接全部传入数据，然后一次完成转换。
目前（2014 年 1 月）JSON 解码器就是这样实现的。

Interestingly, the type of chunked conversion cannot be extrapolated from its
synchronous conversion. For example, the
[HtmlEscape]({{site.dart-api}}/dart-convert/HtmlEscape-class.html)
converter synchronously
converts Strings to Strings, and asynchronously converts chunks of Strings to
chunks of Strings (String→String). The
[LineSplitter]({{site.dart-api}}/dart-convert/LineSplitter-class.html)
converter synchronously
converts Strings to List<String> (the individual lines). Despite the difference
in the synchronous signature, the chunked version of the LineSplitter converter
has the same signature as
HtmlEscape: String→String. In this case each individual output chunk
represents one line.

有趣的是，分块转换的类型不能从同步转换外推出来。
例如，[HtmlEscape]({{site.dart-api}}/dart-convert/HtmlEscape-class.html)
转换器同步地把 String 转成 String，
异步地把一块块 String 转成一块块 String（String→String）。
[LineSplitter]({{site.dart-api}}/dart-convert/LineSplitter-class.html)
转换器同步地把 String 转成 List&lt;String&gt;（每一行）。
尽管同步签名不同，LineSplitter 转换器的分块版本
与 HtmlEscape 的签名相同：String→String。
此时每一块输出代表一行。

```dart
import 'dart:convert';
import 'dart:async';

void main() async {
  // HtmlEscape synchronously converts Strings to Strings.
  print(const HtmlEscape().convert("foo")); // "foo".
  // When used in a chunked way it converts from Strings
  // to Strings.
  var stream = new Stream.fromIterable(["f", "o", "o"]);
  print(await (stream.transform(const HtmlEscape())
                     .toList()));    // ["f", "o", "o"].

  // LineSplitter synchronously converts Strings to Lists of String.
  print(const LineSplitter().convert("foo\nbar")); // ["foo", "bar"]
  // However, asynchronously it converts from Strings to Strings (and
  // not Lists of Strings).
  var stream2 = new Stream.fromIterable(["fo", "o\nb", "ar"]);
  print("${await (stream2.transform(const LineSplitter())
                          .toList())}");
}
```

In general, the type of the chunked conversion is determined by the most
useful case when used as a StreamTransformer.

一般来说，分块转换的类型由它作为 StreamTransformer 时最有用的情形决定。

### ChunkedConversionSink

### ChunkedConversionSink 类

[ChunkedConversionSinks]({{site.dart-api}}/dart-convert/ChunkedConversionSink-class.html)
are used to add new data to a
converter or as output from converters. The basic ChunkedConversionSink comes
with two methods: `add()` and `close()`. These have the same functionality as in
all other sinks of the system such as
[StringSinks]({{site.dart-api}}/dart-core/StringSink-class.html)
or
[StreamSinks]({{site.dart-api}}/dart-async/StreamSink-class.html).

[ChunkedConversionSink]({{site.dart-api}}/dart-convert/ChunkedConversionSink-class.html)
用来向转换器添加新数据，或作为转换器的输出。
基本的 ChunkedConversionSink 有两个方法：`add()` 和 `close()`。
它们的功能与系统中的其他 Sink 相同，例如
[StringSink]({{site.dart-api}}/dart-core/StringSink-class.html)
或
[StreamSink]({{site.dart-api}}/dart-async/StreamSink-class.html)。

The ChunkedConversionSinks semantics are similar to that of
[IOSinks]({{site.dart-api}}/dart-io/IOSink-class.html):
data added to the
sink must not be modified unless it can be guaranteed that the data has been
handled. For Strings this is not a problem (since they are immutable), but for
lists of bytes it frequently means allocating a fresh copy of the list. This
can be inefficient and the dart:convert library thus comes with subclasses of
ChunkedConversionSink that support more efficient ways of passing data.

ChunkedConversionSink 的语义与
[IOSink]({{site.dart-api}}/dart-io/IOSink-class.html) 类似：
加到 Sink 里的数据不得修改，除非能保证数据已经被处理。
对 String 来说这不是问题（因为它们不可变），
但对字节列表来说，这常常意味着要分配一份新的列表副本。
这样做可能很低效，因此 dart:convert 库提供了 ChunkedConversionSink 的子类，
支持更高效的数据传递方式。

For instance, the
[ByteConversionSink]({{site.dart-api}}/dart-convert/ByteConversionSink-class.html),
has the additional method:

例如，[ByteConversionSink]({{site.dart-api}}/dart-convert/ByteConversionSink-class.html)
还有一个额外方法：

```dart
void addSlice(List<int> chunk, int start, int end, bool isLast);
```

Semantically, it
accepts a list (which may not be held onto), the sub-range that the converter
operates on, and a boolean `isLast`, which can be set instead of calling
`close()`.

从语义上说，它接受一个列表（可以不长期持有）、
转换器要处理的子区间，以及布尔值 `isLast`，
设置它可以代替调用 `close()`。

```dart
import 'dart:convert';

void main() {
  var outSink = new ChunkedConversionSink.withCallback((chunks) {
    print(chunks.single); // 𝅘𝅥𝅯
  });

  var inSink = utf8.decoder.startChunkedConversion(outSink);
  var list = [0xF0, 0x9D];
  inSink.addSlice(list, 0, 2, false);
  // Since we used `addSlice` we are allowed to reuse the list.
  list[0] = 0x85;
  list[1] = 0xA1;
  inSink.addSlice(list, 0, 2, true);
}
```

As a user of the chunked conversion sink (which is used both as input and output
of converters), this simply provides more choice. The fact that the list is not
held onto, means that you can use a cache and reuse that one for every call.
Combining `add()` with `close()` may help the receiver in that it can avoid
buffering data. Accepting sub-lists avoids expensive calls to `subList()`
(to copy the data).

作为分块转换 Sink 的使用者（它既用作转换器的输入，也用作输出），
这只是提供了更多选择。
列表不会被长期持有，意味着你可以用一块缓存，每次调用都复用它。
把 `add()` 和 `close()` 结合起来，可以帮助接收方避免缓冲数据。
接受子列表可以避开昂贵的 `subList()` 调用（那会复制数据）。

The drawback of this interface is that it is more complicated to implement. To
ease the pain for developers, every improved chunked conversion sink of
dart:convert also comes with a base class that implements all methods except one
(which is abstract). The implementor of the conversion sink can then decide
whether to take advantage of the additional methods.

这个接口的缺点是实现起来更复杂。
为了减轻开发者的负担，dart:convert 中每个增强的分块转换 Sink
都配有一个基类，它实现了除一个抽象方法以外的全部方法。
转换 Sink 的实现者可以自行决定要不要利用这些额外方法。

**Note**: _Chunked conversion sinks *must* extend the corresponding base class.
This assures that adding functionality to the existing sink interfaces does
not break the extended sinks._

**说明**：**分块转换 Sink 必须扩展对应的基类。这样在现有 Sink 接口上增加功能时，就不会破坏已扩展的 Sink。**

## Example

## 示例

This section shows all the steps needed to create a simple encryption
converter and how a custom ChunkedConversionSink can improve performance.

本节展示创建简单加密转换器所需的全部步骤，
以及自定义 ChunkedConversionSink 如何提升性能。

Let's start with the simple synchronous converter,
whose encryption routine simply rotates bytes by the given key:

先从简单的同步转换器开始，
它的加密过程只是按给定的密钥旋转字节：

```dart
import 'dart:convert';

/// A simple extension of Rot13 to bytes and a key.
class RotConverter extends Converter<List<int>, List<int>> {
  final _key;
  const RotConverter(this._key);

  List<int> convert(List<int> data, { int key }) {
    if (key == null) key = this._key;
    var result = new List<int>(data.length);
    for (int i = 0; i < data.length; i++) {
      result[i] = (data[i] + key) % 256;
    }
    return result;
  }
}
```

The corresponding Codec class is also simple:

对应的 Codec 类也很简单：

```dart
class Rot extends Codec<List<int>, List<int>> {
  final _key;
  const Rot(this._key);

  List<int> encode(List<int> data, { int key }) {
    if (key == null) key = this._key;
    return new RotConverter(key).convert(data);
  }

  List<int> decode(List<int> data, { int key }) {
    if (key == null) key = this._key;
    return new RotConverter(-key).convert(data);
  }

  RotConverter get encoder => new RotConverter(_key);
  RotConverter get decoder => new RotConverter(-_key);
}
```

We can (and should) avoid some of the `new` allocations, but for simplicity we
allocate a new instance of RotConverter every time one is needed.

有些 `new` 分配可以（也应该）避免，
但为了简单，这里每次需要时都分配一个新的 RotConverter 实例。

This is how we use the Rot codec:

Rot 编解码器可以这样使用：

```dart
const Rot ROT128 = const Rot(128);
const Rot ROT1 = const Rot(1);

void main() {
  print(const RotConverter(128).convert([0, 128, 255, 1]));   // [128, 0, 127, 129]
  print(const RotConverter(128).convert([128, 0, 127, 129])); // [0, 128, 255, 1]
  print(const RotConverter(-128).convert([128, 0, 127, 129]));// [0, 128, 255, 1]

  print(ROT1.decode(ROT1.encode([0, 128, 255, 1])));          // [0, 128, 255, 1]
  print(ROT128.decode(ROT128.encode([0, 128, 255, 1])));      // [0, 128, 255, 1]
}
```

We are on the right track. The codec works, but it is still missing the chunked
encoding part. Because each byte is encoded separately we can fall back to
the synchronous conversion method:

方向是对的。编解码器能工作，但还缺少分块编码部分。
因为每个字节是单独编码的，可以退回到同步转换方法：

```dart
class RotConverter {
  ...
  RotSink startChunkedConversion(sink) {
    return new RotSink(_key, sink);
  }
}

class RotSink extends ChunkedConversionSink<List<int>> {
  final _converter;
  final ChunkedConversionSink<List<int>> _outSink;
  RotSink(key, this._outSink) : _converter = new RotConverter(key);

  void add(List<int> data) {
    _outSink.add(_converter.convert(data));
  }

  void close() {
    _outSink.close();
  }
}
```

Now, we can use the converter with chunked conversions or even for stream
transformations:

现在，这个转换器可以用于分块转换，甚至用于 Stream 转换：

```dart
import 'dart:io';

void main(List<String> args) {
  String inFile = args[0];
  String outFile = args[1];
  int key = int.parse(args[2]);
  new File(inFile)
    .openRead()
    .transform(new RotConverter(key))
    .pipe(new File(outFile).openWrite());
}
```

### Specialized ChunkedConversionSinks

### 专用的 ChunkedConversionSink

For many purposes, the current version of Rot is sufficient. That is, the
benefit of improvements would be outweighed by the cost of more complex code
and test requirements. Let's assume, however,
that the performance of the converter is critical
(it's on the hot path and up on the profile).
We furthermore assume that
the cost of allocating a new list for every chunk is killing performance
(a reasonable assumption).

对许多用途来说，当前版本的 Rot 已经够用。
也就是说，改进带来的收益抵不上更复杂的代码和测试成本。
不过，假设这个转换器的性能至关重要
（它位于热路径上，并且在性能分析里很靠前）。
再假设为每个分块分配新列表的开销正在拖垮性能
（这个假设是合理的）。

We start by making the allocation cost cheaper: by using a
[typed byte-list]({{site.dart-api}}/dart-typed_data/Uint8List-class.html)
we can reduce the size of the allocated list by a factor of 8 (on 64-bit
machines). This one line change doesn't remove the allocation, but makes it much
cheaper.

先让分配成本更低：使用
[类型化字节列表]({{site.dart-api}}/dart-typed_data/Uint8List-class.html)，
可以把分配列表的大小缩小到原来的 1/8（在 64 位机器上）。
这一行改动并没有去掉分配，但让它便宜得多。

We can also avoid the allocation altogether if we overwrite the input. In
the following version of RotSink, we add a new method `addModifiable()` that
does exactly that:

如果覆盖输入，也可以完全避免分配。
在下面这个版本的 RotSink 中，我们新增 `addModifiable()` 方法来做这件事：

```dart
class RotSink extends ChunkedConversionSink<List<int>> {
  final _key;
  final ChunkedConversionSink<List<int>> _outSink;
  RotSink(this._key, this._outSink);

  void add(List<int> data) {
    addModifiable(new Uint8List.fromList(data));
  }

  void addModifiable(List<int> data) {
    for (int i = 0; i < data.length; i++) {
      data[i] = (data[i] + _key) % 256;
    }
    _outSink.add(data);
  }

  void close() {
    _outSink.close();
  }
}
```

For simplicity we propose a new method that consumes a complete list. A more
advanced method (for example `addModifiableSlice()`) would take range arguments
(`from`, `to`) and an `isLast` boolean as arguments.

为了简单，这里提出的新方法消费完整的列表。
更进一步的方法（例如 `addModifiableSlice()`）
会接受范围参数（`from`、`to`）和布尔值 `isLast`。

This new method is not yet used by transformers, but we can already use it when
invoking `startChunkedConversion()` explicitly.

transformer 还不会使用这个新方法，
但在显式调用 `startChunkedConversion()` 时已经可以用它。

```dart
void main() {
  var outSink = new ChunkedConversionSink.withCallback((chunks) {
    print(chunks); // [[31, 32, 33], [24, 25, 26]]
  });
  var inSink = new RotConverter(30).startChunkedConversion(outSink);
  inSink.addModifiable([1, 2, 3]);
  inSink.addModifiable([250, 251, 252]);
  inSink.close();
}
```

In this small example, performance isn't visibly different,
but internally the
chunked conversion avoids allocating new lists for the individual chunks.
For two small chunks, it doesn't make a difference, but
if we implement this for the stream transformer,
encrypting a bigger file can be noticeably faster.

在这个小例子里，性能看不出差别，
但内部的分块转换避免了为各个分块分配新列表。
两个小分块不会有差别，
如果在 Stream transformer 上实现这一点，
加密更大的文件会明显更快。

To do this,
we can make use of the undocumented feature that IOStreams provide modifiable lists.
We could now simply rewrite `add()` and
point it directly to `addModifiable()`. In general, this is not safe,
and
such a converter would be the potential source of hard-to-track bugs. Instead,
we write a converter that does the unmodifiable-to-modifiable conversion
explicitly, and then fuse the two converters.

为此，可以利用一个未公开的特性：IOStream 提供的是可修改列表。
现在可以简单改写 `add()`，让它直接指向 `addModifiable()`。
一般来说这并不安全，
这样的转换器可能成为难以追踪的 bug 的来源。
因此，我们写一个显式做「不可修改到可修改」转换的转换器，
再把两个转换器融合起来。

```dart
class ToModifiableConverter extends Converter<List<int>, List<int>> {
  List<int> convert(List<int> data) => data;
  ToModifiableSink startChunkedConversion(RotSink sink) {
    return new ToModifiableSink(sink);
  }
}

class ToModifiableSink
    extends ChunkedConversionSink<List<int>, List<int>> {
  final RotSink sink;
  ToModifiableSink(this.sink);

  void add(List<int> data) { sink.addModifiable(data); }
  void close() { sink.close(); }
}
```

ToModifiableSink just signals the next sink that the incoming chunk
is modifiable. We can use this to make our pipeline more efficient:

ToModifiableSink 只是向下一个 Sink 表明传入的分块是可修改的。
可以用它让流水线更高效：

```dart
void main(List<String> args) {
  String inFile = args[0];
  String outFile = args[1];
  int key = int.parse(args[2]);
  new File(inFile)
      .openRead()
      .transform(
          new ToModifiableConverter().fuse(new RotConverter(key)))
      .pipe(new File(outFile).openWrite());
}
```

On my machine, this small modification brought the encryption time of an 11MB
file from 450ms down to 260ms. We achieved this speed up without losing
compatibility with existing codecs (with regard to the `fuse()` method)
and the converter still functions as a stream transformer.

在我的机器上，这一小改动把一个 11 MB 文件的加密时间
从 450 ms 降到了 260 ms。
这次加速没有失去与现有编解码器的兼容性（就 `fuse()` 方法而言），
转换器仍然可以作为 Stream transformer 使用。

Reusing the input works nicely with other
converters and not just with our Rot cipher. We should therefore make an
interface that generalizes the concept. For simplicity, we named it
`CipherSink`, although it has, of course, uses outside the encryption world.

复用输入不仅适用于我们的 Rot 密码，也适用于其他转换器。
因此应该做一个接口来概括这个概念。
为了简单，我们把它命名为 `CipherSink`，
当然它在加密之外也有用途。

```dart
abstract class CipherSink
    extends ChunkedConversionSink<List<int>, List<int>> {
  void addModifiable(List<int> data) { add(data); }
}
```

We can then make our RotSink private and expose the CipherSink instead.
Other developers can now reuse our work (CipherSink and ToModifiableConverter)
and benefit from it.

然后可以把 RotSink 做成私有的，改为对外暴露 CipherSink。
其他开发者就可以复用这些成果（CipherSink 和 ToModifiableConverter）并从中受益。

But we are not done yet.

但还没有结束。

Although we won't make the cipher faster anymore,
we can improve the output side of our Rot converter.
Take, for instance, the fusion of two encryptions:

虽然密码本身不会再更快，
但可以改进 Rot 转换器的输出一侧。
例如，把两次加密融合起来：

```dart
void main(List<String> args) {
  String inFile = args[0];
  String outFile = args[1];
  int key = int.parse(args[2]);
  // Double-strength cipher running the Rot-cipher twice.
  var transformer = new ToModifiableConverter()
       .fuse(new RotConverter(key))  // <= fused RotConverters.
       .fuse(new RotConverter(key));
  new File(inFile)
      .openRead()
      .transform(transformer)
      .pipe(new File(outFile).openWrite());
}
```

Since the first RotConverter invokes `outSink.add()`, the second RotConverter
assumes that input cannot be modified and allocates a copy. We can work around
this by sandwiching a ToModifiableConverter in between the two ciphers:

因为第一个 RotConverter 调用的是 `outSink.add()`，
第二个 RotConverter 会假定输入不能修改，从而分配一份副本。
可以在两个密码之间夹一个 ToModifiableConverter 来绕过这一点：

```dart
  var transformer = new ToModifiableConverter()
       .fuse(new RotConverter(key))
       .fuse(new ToModifiableConverter())
       .fuse(new RotConverter(key));
```

This works, but is hackish. We want the RotConverters to work without
intermediate converters. The first cipher should look at the outSink and
determines if it is a CipherSink or not. We can do this either,
whenever we want to add a new chunk,
or at the beginning when we start a chunked
conversion. We prefer the latter approach:

这样能工作，但比较取巧。
我们希望 RotConverter 不借助中间转换器也能工作。
第一个密码应该查看 outSink，判断它是不是 CipherSink。
可以在每次要添加新分块时做这件事，
也可以在开始分块转换时做。我们更倾向后一种：

```dart
  /// Works more efficiently if given a CipherSink as argument.
  CipherSink startChunkedConversion(
      ChunkedConversionSink<List<int>> sink) {
    if (sink is! CipherSink) sink = new _CipherSinkAdapter(sink);
    return new _RotSink(_key, sink);
  }
```

_CipherSinkAdapter is simply:

**CipherSinkAdapter 很简单：**

```dart
class _CipherSinkAdapter implements CipherSink {
  ChunkedConversionSink<List<int>, List<int>> sink;
  _CipherSinkAdapter(this.sink);

  void add(data) { sink.add(data); }
  void addModifiable(data) { sink.add(data); }
  void close() { sink.close(); }
}
```

We now only need to change the _RotSink to take advantage of the fact that it
always receives a CipherSink as an argument to its constructor:

现在只需要修改 _RotSink，利用它的构造函数始终收到 CipherSink 这一点：

```dart
class _RotSink extends CipherSink {
  final _key;
  final CipherSink _outSink;  // <= always a CipherSink.
  _RotSink(this._key, this._outSink);

  void add(List<int> data) {
    addModifiable(data.toList());
  }

  void addModifiable(List<int> data) {
    for (int i = 0; i < data.length; i++) {
      data[i] = (data[i] + _key) % 256;
    }
    _outSink.addModifiable(data);  // <= safe to call addModifiable.
  }

  void close() {
    _outSink.close();
  }
}
```

With these changes our super secure, double cipher won't allocate any new lists
and our work is done.

有了这些改动，这个「超级安全」的双重密码就不会再分配新列表，工作也就完成了。

Thanks to Lasse Reichstein Holst Nielsen, Anders Johnsen, and Matias Meno who
were a great help in writing this article.

感谢 Lasse Reichstein Holst Nielsen、Anders Johnsen 和 Matias Meno，
他们为撰写本文提供了很大帮助。
