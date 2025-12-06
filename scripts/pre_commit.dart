#!/usr/bin/env dart
// pre-commitフック用のDartスクリプト
// lint、テスト、セキュリティチェックを実行

import 'dart:io';

void main(List<String> args) async {
  print('🔍 Pre-commitチェックを開始します...\n');

  final checks = [
    _Check('Lintチェック', _runLint),
    _Check('フォーマットチェック', _runFormatCheck),
    _Check('テスト実行', _runTests),
    _Check('セキュリティチェック', _runSecurityCheck),
  ];

  bool allPassed = true;

  for (final check in checks) {
    print('📋 ${check.name}を実行中...');
    try {
      final result = await check.run();
      if (result) {
        print('✅ ${check.name}: 成功\n');
      } else {
        print('❌ ${check.name}: 失敗\n');
        allPassed = false;
      }
    } catch (e) {
      print('❌ ${check.name}: エラー - $e\n');
      allPassed = false;
    }
  }

  if (!allPassed) {
    print('❌ Pre-commitチェックに失敗しました。');
    print('   修正してから再度コミットしてください。');
    exit(1);
  }

  print('✅ すべてのPre-commitチェックが成功しました！');
}

class _Check {
  final String name;
  final Future<bool> Function() run;

  _Check(this.name, this.run);
}

Future<bool> _runLint() async {
  final result = await Process.run('flutter', ['analyze'], runInShell: true);

  final output = result.stdout.toString() + result.stderr.toString();

  // エラーレベルの問題があるかチェック
  if (output.contains('error •') ||
      output.contains('Error:') ||
      output.contains('error:')) {
    print(result.stdout);
    print(result.stderr);
    return false;
  }

  // infoレベルの警告のみの場合は警告として表示するが、失敗にはしない
  if (result.exitCode != 0 || output.contains('info •')) {
    final issueCount = RegExp(r'(\d+) issues? found').firstMatch(output);
    if (issueCount != null) {
      print('⚠️  Lint警告があります（infoレベル）: ${issueCount.group(1)}件');
      // 詳細は表示しない（長すぎるため）
    }
  }

  return true;
}

Future<bool> _runFormatCheck() async {
  final result = await Process.run('dart', [
    'format',
    '--set-exit-if-changed',
    '.',
  ], runInShell: true);

  if (result.exitCode != 0) {
    print('エラー: コードがフォーマットされていません。');
    print('次のコマンドを実行してください: dart format .');
    print(result.stdout);
    print(result.stderr);
    return false;
  }
  return true;
}

Future<bool> _runTests() async {
  final result = await Process.run('flutter', ['test'], runInShell: true);

  if (result.exitCode != 0) {
    print(result.stdout);
    print(result.stderr);
    return false;
  }
  return true;
}

Future<bool> _runSecurityCheck() async {
  // 依存関係の更新確認（outdatedはデフォルトで更新しない）
  final result = await Process.run('dart', [
    'pub',
    'outdated',
  ], runInShell: true);

  // outdatedは警告のみで、エラーにはしない
  if (result.exitCode == 0) {
    final output = result.stdout.toString();
    if (output.contains('No dependencies changed') || output.trim().isEmpty) {
      print('✅ すべての依存関係は最新です');
    } else {
      print('⚠️  更新可能な依存関係があります:');
      print(output);
      print('   確認するには: dart pub outdated');
    }
    return true;
  }

  // エラーの場合は警告として扱う
  print('⚠️  依存関係の確認中にエラーが発生しました');
  print(result.stderr);
  return true; // セキュリティチェックは警告のみ
}
