---
# title: Dart documentation
title: Dart 语言开发文档
# description: Learn to use the Dart language and libraries.
description: 学习 Dart 语言。
toc: false
---

Welcome to the Dart documentation!
For a list of changes to this site—new pages, new guidelines, and more—see
the [What's new][] page.

欢迎来到 Dart 语言开发文档页面！
关于网站的变更内容，新页面、新指南等等，
请查阅 [What's new][]

[What's new]: /resources/whats-new

Here are some of this site's most visited pages:

如下是大家最经常访问的页面：

{% comment %}
To update these cards, edit src/_data/docs_cards.yml.
{% endcomment %}

<div class="card-grid">
{% for card in docs_cards -%}
  {% card card.name, card.url %}
    {{card.description}}
  {% endcard %}
{% endfor -%}
</div>

