---
# title: Keywords
title: 关键字
# description: Keywords in Dart.
description: Dart 中的关键字。
showToc: false
---

{% assign ckw = '&nbsp;<sup>1</sup>' %}
{% assign bii = '&nbsp;<sup>2</sup>' %}
{% assign unr = '&nbsp;<sup>3</sup>' %}

The following table lists the words
that the Dart language reserves for its own use.
These words can't be used as identifiers unless otherwise noted.
Even when allowed, using keywords as identifiers can confuse other
developers reading your code and should be avoided.
To learn more about identifier usage, click on the term.

下表列出了 Dart 语言保留的单词。
这些单词不能用作标识符，除非另有说明。
即使在允许的情况下，使用关键字作为标识符也会让其他
阅读你代码的开发者感到困惑，应该避免这样做。
要了解更多关于标识符用法的信息，请点击术语。

<table class="table table-striped">

{% tablerow keyword in keywords cols: 4 %}
<a href="{{keyword.link}}">{{keyword.term}}</a>
{%- case keyword.type %}
{% when 'bit' %}{{bii}}
{% when 'context' %}{{ckw}}
{% when 'unrestricted' %}{{unr}}
{% endcase %}
{% endtablerow %}
</table>

{{ckw}} This keyword can be used as an identifier
        depending on **context**.

{{ckw}} 此关键字可以根据**上下文**用作标识符。

{{bii}} This keyword can't be used as the name of a type
        (a class, a mixin, an enum, an extension type, or a type alias),
        the name of an extension, or as an import prefix.
        It can be used as an identifier in all other circumstances.

{{bii}} 此关键字不能用作类型的名称
        （类、mixin、枚举、扩展类型或类型别名），
        扩展的名称，或作为导入前缀。
        在其他所有情况下，它可以用作标识符。

{{unr}} This keyword can be used as an identifier without restriction.

{{unr}} 此关键字可以无限制地用作标识符。
