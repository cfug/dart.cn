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

[What's new]: /guides/whats-new

Here are some of this site's most visited pages:

欢迎来到 Dart 语言开发文档页面！
如下是大家最经常访问的页面：

{% comment %}
To update these cards, edit src/_data/docs_cards.yml.
{% endcomment %}

<div class="card-grid">
{% for card in docs_cards -%}
  {% capture index0Modulo3 %}{{ forloop.index0 | modulo:3 }}{% endcapture %}
  {% capture indexModulo3 %}{{ forloop.index | modulo:3 }}{% endcapture %}
  <div class="card">
    <h3><a href="{{card.url}}">{{card.name}}</a></h3>
    <p>{{card.description}}</p>
  </div>
{% endfor -%}
</div>

