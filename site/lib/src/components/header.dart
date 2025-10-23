// Copyright (c) 2025, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../util.dart';
import 'header/menu_toggle.dart';
import 'header/site_switcher.dart';
import 'header/theme_switcher.dart';
import 'material_icon.dart';

/// The site-wide top navigation bar.
class DashHeader extends StatelessComponent {
  const DashHeader({super.key});

  @override
  Component build(BuildContext context) {
    final pageUrlPath = context.page.url;
    final layout = context.page.data.page['layout'];
    final activeEntry = _activeNavEntry(pageUrlPath);

    return header(id: 'site-header', classes: 'always-dark-mode', [
      nav(classes: 'navbar', [
        a(
          id: 'site-primary-logo',
          classes: 'site-wordmark',
          href: '/',
          attributes: {
            'aria-label': '前往 Dart 首页',
            'title': '前往 Dart 首页',
          },
          [
            img(
              src: '/assets/img/logo/dart-192.svg',
              alt: 'Dart logo',
              attributes: {'width': '192'},
            ),
            span(
              classes: 'name',
              attributes: {'translate': 'no'},
              [text('Dart')],
            ),
          ],
        ),

        ul(classes: 'nav-items', [
          li([
            a(
              href: '/overview',
              classes: [
                'nav-link',
                if (activeEntry == _ActiveNavEntry.overview) 'active',
              ].toClasses,
              [text('概览')],
            ),
          ]),
          li([
            a(
              href: '/docs',
              classes: [
                'nav-link',
                if (activeEntry == _ActiveNavEntry.docs) 'active',
              ].toClasses,
              [
                span([text('文档')]),
              ],
            ),
          ]),
          li([
            a(
              href: 'https://blog.dart.dev',
              classes: [
                'nav-link',
                if (activeEntry == _ActiveNavEntry.blog) 'active',
              ].toClasses,
              [text('博客')],
            ),
          ]),
          li([
            a(
              href: '/community',
              classes: [
                'nav-link',
                if (activeEntry == _ActiveNavEntry.community) 'active',
              ].toClasses,
              [text('社区')],
            ),
          ]),
          li([
            if (activeEntry == _ActiveNavEntry.learn)
              a(href: '/get-started', classes: 'nav-link active', [
                text('学习'),
              ])
            else
              a(href: '/#try-dart', classes: 'nav-link', [
                text('尝试 Dart'),
              ]),
          ]),
          li([
            a(
              href: '/get-dart',
              classes: [
                'nav-link',
                if (activeEntry == _ActiveNavEntry.getDart) 'active',
              ].toClasses,
              [text('获取 Dart SDK')],
            ),
          ]),
        ]),

        div(
          classes: 'navbar-contents',
          [
            form(
              action: '/search/',
              id: 'header-search',
              [
                input(
                  classes: 'search-field',
                  type: InputType.search,
                  name: 'q',
                  id: 'q',
                  attributes: {
                    'autocomplete': 'off',
                    'placeholder': '搜索',
                    'aria-label': '搜索',
                  },
                ),
              ],
            ),
            a(
              id: 'fallback-search-button',
              classes: 'icon-button',
              href: '/search',
              attributes: {
                'aria-label': '导航至 dart.cn 的搜索页面。',
                'title': '导航至 dart.cn 的搜索页面。',
              },
              const [
                MaterialIcon('search'),
              ],
            ),
            if (layout != 'homepage') const ThemeSwitcher(),
            const SiteSwitcher(),
            const MenuToggle(),
          ],
        ),
      ]),
    ]);
  }
}

_ActiveNavEntry? _activeNavEntry(String pageUrlPath) {
  final firstFragment = pageUrlPath
      .split('/')
      .where((fragment) => fragment.isNotEmpty)
      .firstOrNull
      ?.trim()
      .toLowerCase();

  return switch (firstFragment) {
    'overview' => _ActiveNavEntry.overview,
    'blog' => _ActiveNavEntry.blog,
    'community' => _ActiveNavEntry.community,
    'get-started' => _ActiveNavEntry.learn,
    'get-dart' => _ActiveNavEntry.getDart,
    'deprecated' ||
    'docs' ||
    'effective-dart' ||
    'get-started' ||
    'interop' ||
    'language' ||
    'libraries' ||
    'null-safety' ||
    'resources' ||
    'server' ||
    'tools' ||
    'tutorials' ||
    'web' ||
    'multiplatform-apps' => _ActiveNavEntry.docs,
    _ => null,
  };
}

enum _ActiveNavEntry {
  overview,
  blog,
  community,
  getDart,
  docs,
  learn,
}
