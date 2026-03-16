// Copyright (c) 2025, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

// import '../components/common/client/cookie_notice.dart';
import '../components/layout/banner.dart';
import '../components/layout/footer.dart';
import '../components/layout/header.dart';
import '../components/layout/sidenav.dart';
import '../models/sidenav_model.dart';
import '../style_hash.dart';
import '../util.dart';

/// The base Jaspr Content layout for wrapping site content.
abstract class DashLayout extends PageLayoutBase {
  const DashLayout();

  @override
  String get name;

  List<String> get defaultBodyClasses => [];

  String get defaultSidenav => 'default';

  /// Returns page-specific URLs to eagerly speculate on, in addition to
  /// the document-level rules that match all internal links.
  ///
  /// Override in subclasses to provide page-specific URLs for
  /// eager prerendering and prefetching.
  ({Set<String> prerender, Set<String> prefetch}) speculationUrls(Page page) =>
      const (prerender: {}, prefetch: {});

  @override
  @mustCallSuper
  Iterable<Component> buildHead(Page page) {
    final pageData = page.data.page;
    final siteData = page.data.site;
    final pageTitle = (pageData['title'] ?? siteData['title']) as String;

    return [
      ...super.buildHead(page),
      // dart.cn
      meta(httpEquiv: 'Content-Language', content: 'zh-cmn-Hans'),
      if (pageData['noindex'] case final noIndex?
          when noIndex == true || noIndex == 'true')
        const meta(name: 'robots', content: 'noindex'),
      if (pageData['canonical'] case final String canonicalUrl
          when canonicalUrl.isNotEmpty)
        link(rel: 'canonical', href: canonicalUrl),
      if (pageData['redirectTo'] case final String redirectTo
          when redirectTo.isNotEmpty)
        RawText('<script>window.location.replace("$redirectTo");</script>'),
      const link(
        rel: 'icon',
        href: '/assets/img/logo/dart-64.png',
        attributes: {'sizes': '64x64'},
      ),
      const link(
        rel: 'apple-touch-icon',
        href: '/assets/img/touch-icon-iphone.png',
      ),
      const link(
        rel: 'apple-touch-icon',
        href: '/assets/img/touch-icon-ipad.png',
        attributes: {'sizes': '152x152'},
      ),
      const link(
        rel: 'apple-touch-icon',
        href: '/assets/img/touch-icon-iphone-retina.png',
        attributes: {'sizes': '180x180'},
      ),
      const link(
        rel: 'apple-touch-icon',
        href: '/assets/img/touch-icon-ipad-retina.png',
        attributes: {'sizes': '167x167'},
      ),
      const meta(name: 'twitter:card', content: 'summary'),
      const meta(name: 'twitter:site', content: '@dart_lang'),
      meta(name: 'twitter:title', content: pageTitle),
      meta(
        name: 'twitter:description',
        content: '${pageData['description']}',
      ),

      meta(attributes: {'property': 'og:title', 'content': pageTitle}),
      meta(
        attributes: {
          'property': 'og:description',
          'content': '${pageData['description']}',
        },
      ),
      meta(attributes: {'property': 'og:url', 'content': page.path}),
      const meta(
        attributes: {
          'property': 'og:image',
          'content': '/assets/img/logo/dart-logo-for-shares.png',
        },
      ),

      const link(rel: 'preconnect', href: 'https://fonts.googleapis.cn'),
      const link(
        rel: 'preconnect',
        href: 'https://fonts.gstatic.cn',
        attributes: {'crossorigin': ''},
      ),
      const link(
        rel: 'stylesheet',
        href:
            'https://fonts.googleapis.cn/css2?family=Google+Sans:wght@400;500;700&display=swap',
      ),
      const link(
        rel: 'stylesheet',
        href:
            'https://fonts.googleapis.cn/css2?family=Google+Sans+Mono:wght@400;500;700&display=swap',
      ),
      const link(
        rel: 'stylesheet',
        href:
            'https://fonts.googleapis.cn/css2?family=Google+Sans+Text:wght@400;500;700&display=swap',
      ),
      const link(
        rel: 'stylesheet',
        href:
            'https://fonts.googleapis.cn/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0..1,0',
      ),
      link(
        rel: 'stylesheet',
        href:
            '/assets/css/main.css?'
            'hash=${htmlEscape.convert(generatedStylesHash)}',
      ),

      if (pageData['js'] case final List<Object?> jsList)
        for (final js in jsList)
          if (js case {'url': final String jsUrl, 'defer': final Object? defer})
            script(
              src: jsUrl,
              attributes: {if (defer == 'true' || defer == true) 'defer': ''},
            ),
      const script(
        src:
            'https://files.flutter-io.cn/static/deps/lite-youtube/1.8.1/lite-youtube.js',
        attributes: {
          'type': 'module',
          'integrity': 'sha256-dSKwIYLvKdlkLGLp9ZRLJilBuGFSM5beizYOSvK1LeQ=',
          'crossorigin': 'anonymous',
          'referrerpolicy': 'no-referrer',
        },
      ),

      // Set up tag manager and analytics.
      // ...

      // dart.cn - Global site tag (gtag.js) - Google Analytics
      const RawText('''
<script async src="https://www.googletagmanager.com/gtag/js?id=G-28P0PYCRZ9"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-28P0PYCRZ9');
</script>
'''),
      const RawText('''
<script>
  var _hmt = _hmt || [];
  (function() {
    var hm = document.createElement("script");
    hm.src = "https://hm.baidu.com/hm.js?fa71f2474b82505e00203cf9956cf0bc";
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(hm, s);
  })();
</script>
'''),
      // Add speculation rules and prefetch fallback links for
      // URLs provided by subclass overrides of speculationUrls.
      ..._buildSpeculationRulesHead(page),
    ];
  }

  @override
  Component buildBody(Page page, Component child) {
    final pageData = page.data.page;
    final bodyClass = pageData['bodyClass'] as String?;
    final pageUrl = page.url.startsWith('/') ? page.url : '/${page.url}';

    final pageSidenav = pageData['sidenav'] as String? ?? defaultSidenav;
    final sideNavEntries = switch (page.data['sidenav']) {
      final Map<String, Object?> sidenavs => switch (sidenavs[pageSidenav]) {
        final List<Object?> sidenavData => navEntriesFromData(sidenavData),
        _ => null,
      },
      _ => null,
    };

    final obsolete = pageData['obsolete'] == true;

    return Component.fragment(
      [
        const Document.html(
          attributes: {
            'lang': 'zh-cmn-Hans',
            'dir': 'ltr',
          },
        ),
        Document.body(
          attributes: {
            'class': [?bodyClass, ...defaultBodyClasses].toClasses,
          },
        ),
        // The theme setting logic should remain before other scripts to
        // avoid a flash of the initial theme on load.
        const RawText('''
<script>
const prefersDarkMode = window.matchMedia('(prefers-color-scheme: dark)');

const storedTheme = window.localStorage.getItem('theme') ?? 'light-mode';
if (storedTheme === 'auto-mode') {
  document.body.classList.add(
      'auto-mode',
      prefersDarkMode.matches ? 'dark-mode' : 'light-mode',
  );
} else {
  document.body.classList.add(storedTheme);
}
</script>
      '''),
        //         const RawText('''
        // <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-5VSZM5J" height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
        // '''),
        const a(
          id: 'skip-to-main',
          classes: 'filled-button',
          href: '#site-content-title',
          attributes: {'tabindex': '1'},
          [.text('跳转至正文')],
        ),
        // CookieNotice(alwaysDarkMode: name == 'homepage'),
        const DashHeader(),
        div(id: 'site-below-header', [
          div(id: 'site-main-row', [
            if (sideNavEntries != null)
              DashSideNav(
                navEntries: sideNavEntries,
                currentPageUrl: pageUrl,
              ),
            main_(
              id: 'page-content',
              classes: [
                if (pageData['focusedLayout'] == true) 'focused',
              ].toClasses,
              [child],
            ),
            if (obsolete)
              const div(id: 'obsolete-banner', [
                div(classes: 'text-center', [
                  .text('本页面的部分内容可能已经过时。'),
                ]),
              ]),
          ]),
          const DashFooter(),
        ]),
      ],
    );
  }

  Component? buildBanner(Page page) {
    final showBanner =
        (page.data.page['showBanner'] as bool?) ??
        (page.data.site['showBanner'] as bool?) ??
        false;
    if (showBanner) {
      if (page.data['banner'] case final Map<String, Object?> bannerData) {
        return DashBanner(BannerContent.fromMap(bannerData));
      }
    }

    return null;
  }

  /// Builds the speculation rules `<script>` and `<link rel="prefetch">`
  /// fallback tags for the given [page].
  ///
  /// Includes page-specific list rules from [speculationUrls] and
  /// document rules that prefetch internal links on hover (`moderate`)
  /// and prerender them on click (`conservative`).
  ///
  /// Add the `no-prerender` class to a link to
  /// exclude it from document-level prerendering.
  List<Component> _buildSpeculationRulesHead(Page page) {
    final (:prerender, :prefetch) = speculationUrls(page);

    // Exclude prerendered URLs from the prefetch list since
    // prerendering is a superset of prefetching.
    final prefetchOnly = prefetch.difference(prerender);

    // Document rules to match same-origin links across the page.
    const internalLink = {'href_matches': '/*'};
    const notNoPrerender = {
      'not': {'selector_matches': '.no-prerender'},
    };

    final rules = jsonEncode({
      'prefetch': [
        // Prefetch internal links on hover.
        {
          'where': internalLink,
          'eagerness': 'moderate',
        },
        // Prefetch specific URLs from the page eagerly.
        if (prefetchOnly.isNotEmpty)
          {
            'urls': [...prefetchOnly],
          },
      ],
      'prerender': [
        // Prerender internal links on click,
        // unless the link has the 'no-prerender' class.
        {
          'where': {
            'and': [internalLink, notNoPrerender],
          },
          'eagerness': 'conservative',
        },
        // Prerender specific URLs from the page eagerly.
        if (prerender.isNotEmpty)
          {
            'urls': [...prerender],
            'eagerness': 'eager',
          },
      ],
    });

    return [
      RawText('<script type="speculationrules">$rules</script>'),
      // Fall back to prefetch link tags for browsers without
      // Speculation Rules API support.
      for (final url in {...prerender, ...prefetch})
        link(rel: 'prefetch', href: url),
    ];
  }
}
