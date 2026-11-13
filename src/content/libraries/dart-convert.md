---
# title: dart:convert
title: dart:convert
# description: Learn about the major features in Dart's dart:convert library.
description: 了解 Dart dart:convert 库的主要功能。
prevpage:
  url: /libraries/dart-math
# title: dart:math
  title: dart:math
nextpage:
  url: /libraries/dart-io
# title: dart:io
  title: dart:io
ai-translated: true
---

<?code-excerpt replace="/ *\/\/\s+ignore_for_file:[^\n]+\n//g; /(^|\n) *\/\/\s+ignore:[^\n]+\n/$1/g; /(\n[^\n]+) *\/\/\s+ignore:[^\n]+\n/$1\n/g"?>
<?code-excerpt plaster="none"?>

The dart:convert library ([API reference][dart:convert])
has converters for JSON and UTF-8, as well as support for creating
additional converters. [JSON][] is a simple text format for representing
structured objects and collections. [UTF-8][] is a common variable-width
encoding that can represent every character in the Unicode character
set.

dart:convert 库（[API 参考][dart:convert]）
提供 JSON 和 UTF-8 的转换器，并支持创建更多转换器。
[JSON][JSON] 是一种表示结构化对象和集合的简单文本格式。
[UTF-8][UTF-8] 是一种常用的变宽编码，
可以表示 Unicode 字符集中的每个字符。

To use this library, import dart:convert.

要使用这个库，请导入 dart:convert。

<?code-excerpt "misc/test/library_tour/convert_test.dart (import)"?>
```dart
import 'dart:convert';
```


## Decoding and encoding JSON

## 解码和编码 JSON

Decode a JSON-encoded string into a Dart object with `jsonDecode()`:

使用 `jsonDecode()` 把 JSON 编码的字符串解码为 Dart 对象：

<?code-excerpt "misc/test/library_tour/convert_test.dart (json-decode)"?>
```dart
// NOTE: Be sure to use double quotes ("),
// not single quotes ('), inside the JSON string.
// This string is JSON, not Dart.
var jsonString = '''
  [
    {"score": 40},
    {"score": 80}
  ]
''';

var scores = jsonDecode(jsonString);
assert(scores is List);

var firstScore = scores[0];
assert(firstScore is Map);
assert(firstScore['score'] == 40);
```

Encode a supported Dart object into a JSON-formatted string with
`jsonEncode()`:

使用 `jsonEncode()` 把支持的 Dart 对象编码为 JSON 格式的字符串：

<?code-excerpt "misc/test/library_tour/convert_test.dart (json-encode)"?>
```dart
var scores = [
  {'score': 40},
  {'score': 80},
  {'score': 100, 'overtime': true, 'special_guest': null},
];

var jsonText = jsonEncode(scores);
assert(
  jsonText ==
      '[{"score":40},{"score":80},'
          '{"score":100,"overtime":true,'
          '"special_guest":null}]',
);
```

Only objects of type int, double, String, bool, null, List, or Map (with
string keys) are directly encodable into JSON. List and Map objects are
encoded recursively.

只有 int、double、String、bool、null、List，
或键为字符串的 Map，可以直接编码为 JSON。
List 和 Map 会递归编码。

You have two options for encoding objects that aren't directly
encodable. The first is to invoke `jsonEncode()` with a second argument: a
function that returns an object that is directly encodable. Your second
option is to omit the second argument, in which case the encoder calls
the object's `toJson()` method.

不能直接编码的对象有两种处理方式。
第一种是调用 `jsonEncode()` 时传入第二个参数：
一个返回可直接编码对象的函数。
第二种是省略第二个参数，
此时编码器会调用对象的 `toJson()` 方法。

For more examples and links to JSON-related packages, see
[Using JSON](/libraries/serialization/json).

更多示例以及与 JSON 相关的 package 链接，
请参阅 [使用 JSON](/libraries/serialization/json)。


## Decoding and encoding UTF-8 characters

## 解码和编码 UTF-8 字符

Use `utf8.decode()` to decode UTF8-encoded bytes to a Dart string:

使用 `utf8.decode()` 把 UTF-8 编码的字节解码为 Dart 字符串：

<?code-excerpt "misc/test/library_tour/convert_test.dart (utf8-decode)" replace="/ \/\/line-br.*//g"?>
```dart
List<int> utf8Bytes = [
  0xc3, 0x8e, 0xc3, 0xb1, 0xc5, 0xa3, 0xc3, 0xa9,
  0x72, 0xc3, 0xb1, 0xc3, 0xa5, 0xc5, 0xa3, 0xc3,
  0xae, 0xc3, 0xb6, 0xc3, 0xb1, 0xc3, 0xa5, 0xc4,
  0xbc, 0xc3, 0xae, 0xc5, 0xbe, 0xc3, 0xa5, 0xc5,
  0xa3, 0xc3, 0xae, 0xe1, 0xbb, 0x9d, 0xc3, 0xb1,
];

var funnyWord = utf8.decode(utf8Bytes);

assert(funnyWord == 'Îñţérñåţîöñåļîžåţîờñ');
```

To convert a stream of UTF-8 characters into a Dart string, specify
`utf8.decoder` to the Stream `transform()` method:

要把 UTF-8 字符的 Stream 转换成 Dart 字符串，
请把 `utf8.decoder` 传给 Stream 的 `transform()` 方法：

<?code-excerpt "misc/test/library_tour/io_test.dart (utf8-decoder)" replace="/utf8.decoder/[!$&!]/g"?>
```dart
var lines = [!utf8.decoder!].bind(inputStream).transform(const LineSplitter());
try {
  await for (final line in lines) {
    print('Got ${line.length} characters from stream');
  }
  print('file is now closed');
} catch (e) {
  print(e);
}
```

Use `utf8.encode()` to encode a Dart string as a list of UTF8-encoded
bytes:

使用 `utf8.encode()` 把 Dart 字符串编码为 UTF-8 字节列表：

<?code-excerpt "misc/test/library_tour/convert_test.dart (utf8-encode)" replace="/ \/\/line-br.*//g"?>
```dart
Uint8List encoded = utf8.encode('Îñţérñåţîöñåļîžåţîờñ');

assert(encoded.length == utf8Bytes.length);
for (int i = 0; i < encoded.length; i++) {
  assert(encoded[i] == utf8Bytes[i]);
}
```


## Other functionality

## 其他功能

The dart:convert library also has converters for ASCII and ISO-8859-1
(Latin1). For details, see the [API reference for the dart:convert library.][dart:convert]

dart:convert 库还有 ASCII 和 ISO-8859-1（Latin1）的转换器。
详情请参阅 [dart:convert 库的 API 参考][dart:convert]。

[JSON]: https://www.json.org/
[UTF-8]: https://en.wikipedia.org/wiki/UTF-8
[dart:convert]: {{site.dart-api}}/dart-convert/dart-convert-library.html
