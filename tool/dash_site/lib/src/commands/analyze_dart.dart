// Copyright (c) 2024, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as path;

import '../utils.dart';

final class AnalyzeDartCommand extends Command<int> {
  static const String _verboseFlag = 'verbose';

  AnalyzeDartCommand() {
    argParser.addFlag(
      _verboseFlag,
      defaultsTo: false,
      help: 'Show verbose logging.',
    );
  }

  @override
  String get description => 'Run analysis on the site infra and examples.';

  @override
  String get name => 'analyze-dart';

  @override
  Future<int> run() async =>
      analyzeDart(verboseLogging: argResults.get<bool>(_verboseFlag, false));
}

int analyzeDart({bool verboseLogging = false}) {
  if (!verboseLogging) {
    print('Analyzing code...');
  }

  final directoriesToAnalyze = [
    /// dart.cn 只检查 tool/dash_site
    'tool/dash_site',
    'site',
    ...Directory('examples')
        .listSync()
        .whereType<Directory>()
        .map((e) => e.path)
        .where((e) => !path.basename(e).startsWith('.')),
  ];

  final dartAnalyzeOutput = Process.runSync(Platform.executable, [
    'analyze',
    ...directoriesToAnalyze,
  ]);

  if (dartAnalyzeOutput.exitCode != 0) {
    final normalOutput = dartAnalyzeOutput.stdout.toString();
    final errorOutput = dartAnalyzeOutput.stderr.toString();

    stderr.write(normalOutput);
    stderr.write(errorOutput);
    stderr.writeln('Error: Analysis failed.');
    return 1;
  } else {
    if (verboseLogging) {
      print('Successfully analyzed Dart code!');
    }
  }

  print('No issues found while analyzing!');

  return 0;
}
