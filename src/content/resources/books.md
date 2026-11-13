---
# title: Books about Dart
title: 与 Dart 相关的书籍
# shortTitle: Books
shortTitle: 书籍
# description: Read all about it! Here's a collection of books about Dart.
description: 这里列举与 Dart 相关的书籍。
showToc: false
ai-translated: true
---

This page covers a collection of books about the Dart language.
Many [Flutter books]({{site.flutter-docs}}/resources/books)
also cover Dart.
If you find another Dart book that might be helpful,
[let us know.]({{site.repo.this}}/issues)

本页收录与 Dart 语言相关的书籍。
许多 [Flutter 相关书籍]({{site.flutter-docs}}/resources/books)
也会讲到 Dart。
如果你还发现了其他可能有帮助的 Dart 书籍，
请 [告诉我们]({{site.repo.this}}/issues)。

:::warning
If you find a Dart book not listed on this page,
check for publication dates after June 2021.
Older books lack coverage of Dart 2 and 3 topics such as
strong typing, null safety, FFI, the `dart` command-line utility,
and new developer tools.

如果某本 Dart 书籍没有列在本页，
请确认出版日期是否在 2021 年 6 月之后。
更早的书没有涵盖 Dart 2 和 Dart 3 的内容，
例如强类型、空安全、FFI、`dart` 命令行工具，
以及新的开发者工具。
:::


{% for book in books-dart %}

<div class="book-img-with-details">
<a href="{{book.link}}" title="{{book.title}}">
  <img src="/assets/img/cover/{{book.cover}}" alt="{{book.title}}" />
</a>
<div class="details">

<h3 class="title" id="{{book.title | slugify}}">
<a href="{{book.link}}">{{book.title}}</a>
</h3>

by {{book.authors | arrayToSentenceString}}
{:.authors}

作者：{{book.authors | arrayToSentenceString}}

{{book.desc}}

</div>
</div>
{% endfor %}
