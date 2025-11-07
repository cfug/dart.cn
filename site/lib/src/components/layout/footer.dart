// Copyright (c) 2025, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:jaspr/jaspr.dart';

/// The site-wide footer.
final class DashFooter extends StatelessComponent {
  const DashFooter({super.key});

  @override
  Component build(BuildContext context) {
    return footer(
      id: 'page-footer',
      attributes: {'data-nosnippet': 'true'},
      [
        div(classes: 'footer-section footer-main', [
          a(
            href: '/',
            classes: 'brand',
            attributes: {'title': 'Dart'},
            [
              img(
                src: '/assets/img/logo/logo-white-text.svg',
                alt: 'Dart',
                width: 164,
              ),
            ],
          ),
          div(classes: 'footer-social-links', [
            a(
              href: 'https://blog.dart.dev',
              target: Target.blank,
              attributes: {
                'rel': 'noopener',
                'title': 'Dart\'s Medium publication',
              },
              [
                svg([
                  const Component.element(
                    tag: 'use',
                    attributes: {
                      'href': '/assets/img/social/medium.svg#medium',
                    },
                  ),
                ]),
              ],
            ),
            a(
              href: 'https://github.com/dart-lang',
              target: Target.blank,
              attributes: {
                'rel': 'noopener',
                'title': 'Dart\'s GitHub organization',
              },
              [
                svg([
                  const Component.element(
                    tag: 'use',
                    attributes: {
                      'href': '/assets/img/social/github.svg#github',
                    },
                  ),
                ]),
              ],
            ),
            a(
              href: 'https://bsky.app/profile/dart.dev',
              target: Target.blank,
              attributes: {
                'rel': 'noopener',
                'title': 'Dart\'s Bluesky (Twitter) profile',
              },
              [
                svg([
                  const Component.element(
                    tag: 'use',
                    attributes: {
                      'href': '/assets/img/social/bluesky.svg#bluesky',
                    },
                  ),
                ]),
              ],
            ),
            a(
              href: 'https://twitter.com/dart_lang',
              target: Target.blank,
              attributes: {
                'rel': 'noopener',
                'title': 'Dart\'s X (Twitter) profile',
              },
              [
                svg([
                  const Component.element(
                    tag: 'use',
                    attributes: {'href': '/assets/img/social/x.svg#x'},
                  ),
                ]),
              ],
            ),
          ]),
        ]),
        div(classes: 'footer-section footer-tray', [
          div(classes: 'footer-licenses', [
            text('引用中文内容需注明本站及链接作为出处，英文内容和示例代码均遵从源站授权协议。'),
            // text('Except as otherwise noted, this site is licensed under a '),
            // a(href: 'https://creativecommons.org/licenses/by/4.0/', [
            //   text('Creative Commons Attribution 4.0 International License,'),
            // ]),
            // text(' and code samples are licensed under the '),
            // a(href: 'https://opensource.org/licenses/BSD-3-Clause', [
            //   text('3-Clause BSD License.'),
            // ]),
          ]),
          div(classes: 'footer-utility-links', [
            ul([
              li([
                a(
                  href: '/terms',
                  attributes: {'title': '使用条款'},
                  [text('使用条款')],
                ),
              ]),
              li([
                a(
                  href: 'https://policies.google.cn/privacy',
                  target: Target.blank,
                  attributes: {'rel': 'noopener', 'title': '隐私政策'},
                  [text('隐私政策')],
                ),
              ]),
              li([
                a(
                  href: '/security',
                  attributes: {'title': 'Dart 代码安全说明'},
                  [text('Dart 代码安全说明')],
                ),
              ]),
            ]),
            div([
              a(
                href: 'http://beian.miit.gov.cn/',
                target: Target.blank,
                [text('京ICP备13029451号-6')],
              ),
              text(' | '),
              a(
                href:
                    'http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=11010802029624',
                target: Target.blank,
                [text('京公网安备11010802029624号')],
              ),
            ]),
            div(classes: 'footer-technology', [
              a(
                classes: 'jaspr-badge-link',
                href: 'https://jaspr.site',
                target: Target.blank,
                attributes: {
                  'rel': 'noopener',
                  'title': '本网站使用 Dart 语言开发的 Jaspr web 框架构建。',
                },
                [
                  span([const JasprBadge.light()]),
                  span([const JasprBadge.lightTwoTone()]),
                ],
              ),
            ]),
          ]),
        ]),
      ],
    );
  }
}
