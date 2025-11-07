// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/jaspr.dart';
import 'package:dart_dev_site/src/archive/archive_table.dart' as prefix0;
import 'package:dart_dev_site/src/client/global_scripts.dart' as prefix1;
import 'package:dart_dev_site/src/components/common/client/copy_button.dart'
    as prefix2;
import 'package:dart_dev_site/src/components/common/client/feedback.dart'
    as prefix3;
import 'package:dart_dev_site/src/components/common/client/on_this_page_button.dart'
    as prefix4;
import 'package:dart_dev_site/src/components/dartpad/dartpad_injector.dart'
    as prefix5;
import 'package:dart_dev_site/src/components/layout/menu_toggle.dart'
    as prefix6;
import 'package:dart_dev_site/src/components/layout/site_switcher.dart'
    as prefix7;
import 'package:dart_dev_site/src/components/layout/theme_switcher.dart'
    as prefix8;
import 'package:dart_dev_site/src/components/pages/glossary_search_section.dart'
    as prefix9;
import 'package:dart_dev_site/src/components/pages/lint_filter_search_section.dart'
    as prefix10;

/// Default [JasprOptions] for use with your jaspr project.
///
/// Use this to initialize jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'jaspr_options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultJasprOptions,
///   );
///
///   runApp(...);
/// }
/// ```
JasprOptions get defaultJasprOptions => JasprOptions(
  clients: {
    prefix0.ArchiveTable: ClientTarget<prefix0.ArchiveTable>(
      'src/archive/archive_table',
      params: _prefix0ArchiveTable,
    ),

    prefix1.GlobalScripts: ClientTarget<prefix1.GlobalScripts>(
      'src/client/global_scripts',
    ),

    prefix2.CopyButton: ClientTarget<prefix2.CopyButton>(
      'src/components/common/client/copy_button',
      params: _prefix2CopyButton,
    ),

    prefix3.FeedbackComponent: ClientTarget<prefix3.FeedbackComponent>(
      'src/components/common/client/feedback',
      params: _prefix3FeedbackComponent,
    ),

    prefix4.OnThisPageButton: ClientTarget<prefix4.OnThisPageButton>(
      'src/components/common/client/on_this_page_button',
    ),

    prefix5.DartPadInjector: ClientTarget<prefix5.DartPadInjector>(
      'src/components/dartpad/dartpad_injector',
      params: _prefix5DartPadInjector,
    ),

    prefix6.MenuToggle: ClientTarget<prefix6.MenuToggle>(
      'src/components/layout/menu_toggle',
    ),

    prefix7.SiteSwitcher: ClientTarget<prefix7.SiteSwitcher>(
      'src/components/layout/site_switcher',
    ),

    prefix8.ThemeSwitcher: ClientTarget<prefix8.ThemeSwitcher>(
      'src/components/layout/theme_switcher',
    ),

    prefix9.GlossarySearchSection: ClientTarget<prefix9.GlossarySearchSection>(
      'src/components/pages/glossary_search_section',
    ),

    prefix10.LintFilterSearchSection:
        ClientTarget<prefix10.LintFilterSearchSection>(
          'src/components/pages/lint_filter_search_section',
        ),
  },
  styles: () => [],
);

Map<String, dynamic> _prefix0ArchiveTable(prefix0.ArchiveTable c) => {
  'channel': c.channel,
};
Map<String, dynamic> _prefix2CopyButton(prefix2.CopyButton c) => {
  'toCopy': c.toCopy,
  'buttonText': c.buttonText,
  'classes': c.classes,
  'title': c.title,
};
Map<String, dynamic> _prefix3FeedbackComponent(prefix3.FeedbackComponent c) => {
  'issueUrl': c.issueUrl,
};
Map<String, dynamic> _prefix5DartPadInjector(prefix5.DartPadInjector c) => {
  'title': c.title,
  'theme': c.theme,
  'height': c.height,
  'runAutomatically': c.runAutomatically,
};
