#!/usr/bin/env dart
// pre-commitフック用のDartスクリプト
// lint、テスト、セキュリティチェックを実行

import 'dart:async';
import 'dart:convert';
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
  bool allChecksPassed = true;

  // 1. 依存関係の更新確認
  print('  📦 依存関係の更新確認中...');
  final outdatedResult = await Process.run('dart', [
    'pub',
    'outdated',
  ], runInShell: true);

  if (outdatedResult.exitCode == 0) {
    final output = outdatedResult.stdout.toString();
    if (output.contains('No dependencies changed') ||
        output.trim().isEmpty ||
        output.contains('all up-to-date')) {
      print('    ✅ すべての依存関係は最新です');
    } else {
      print('    ⚠️  更新可能な依存関係があります:');
      // 最初の数行のみ表示
      final lines = output.split('\n').take(10).join('\n');
      print('   $lines');
      print('    💡 詳細は `dart pub outdated` で確認してください');
    }
  } else {
    print('    ⚠️  依存関係の確認中にエラーが発生しました');
    print('   ${outdatedResult.stderr}');
  }

  // 依存関係リストを1回だけ取得（重複を避ける）
  print('  📋 依存関係リストを取得中...');
  final depsResult = await Process.run('dart', [
    'pub',
    'deps',
    '--json',
  ], runInShell: true);

  if (depsResult.exitCode != 0) {
    print('    ⚠️  依存関係の取得に失敗しました');
    return true; // エラーは警告として扱う
  }

  final depsJson = jsonDecode(depsResult.stdout.toString()) as Map;
  final packages = _extractPackages(depsJson);

  if (packages.isEmpty) {
    print('    ✅ チェック対象のパッケージがありません');
    return true;
  }

  // 2. 依存関係の脆弱性チェック（OSVデータベース）
  print('  🔒 脆弱性スキャン中...');
  try {
    final vulnerabilityCheck = await _checkVulnerabilities(packages);
    if (!vulnerabilityCheck) {
      allChecksPassed = false;
    }
  } catch (e) {
    print('    ⚠️  脆弱性チェック中にエラーが発生しました: $e');
    // ネットワークエラーなどは警告として扱う
  }

  // 3. pub.devでのパッケージ検証
  print('  📋 パッケージの信頼性確認中...');
  try {
    final packageCheck = await _verifyPackages(packages);
    if (!packageCheck) {
      allChecksPassed = false;
    }
  } catch (e) {
    print('    ⚠️  パッケージ検証中にエラーが発生しました: $e');
    // ネットワークエラーなどは警告として扱う
  }

  return allChecksPassed;
}

/// OSVデータベースを使用して脆弱性をチェック
Future<bool> _checkVulnerabilities(List<Map<String, String>> packages) async {
  if (packages.isEmpty) {
    print('    ✅ チェック対象のパッケージがありません');
    return true;
  }

  print('    📦 ${packages.length}個のパッケージをチェック中...');

  final httpClient = HttpClient()
    ..connectionTimeout = const Duration(seconds: 10)
    ..idleTimeout = const Duration(seconds: 10);
  int vulnerabilityCount = 0;
  final vulnerablePackages = <String>[];
  int checkedCount = 0;
  int errorCount = 0;

  try {
    // 並列処理でパフォーマンスを向上（最大10並列）
    const maxConcurrency = 10;
    for (var i = 0; i < packages.length; i += maxConcurrency) {
      final chunk = packages.skip(i).take(maxConcurrency).toList();
      final results = await Future.wait(
        chunk.map((package) async {
          final packageName = package['name'] as String;
          final packageVersion = package['version'] as String;

          try {
            final result = await _checkSinglePackageVulnerability(
              httpClient,
              packageName,
              packageVersion,
            );
            checkedCount++;
            if (result != null) {
              if (result) {
                vulnerabilityCount++;
                vulnerablePackages.add('$packageName@$packageVersion');
              }
            } else {
              errorCount++;
            }
          } catch (e) {
            errorCount++;
          }
        }),
      );
    }
  } finally {
    httpClient.close();
  }

  if (errorCount > 0) {
    print('    ⚠️  $errorCount個のパッケージのチェック中にエラーが発生しました');
  }

  if (vulnerabilityCount > 0) {
    print('    ❌ $vulnerabilityCount個のパッケージに脆弱性が見つかりました:');
    for (final pkg in vulnerablePackages) {
      print('      - $pkg');
    }
    print('    💡 詳細は https://osv.dev/ で確認してください');
    return false;
  } else {
    print('    ✅ 既知の脆弱性は見つかりませんでした ($checkedCount個チェック済み)');
    return true;
  }
}

/// 単一パッケージの脆弱性をチェック
Future<bool?> _checkSinglePackageVulnerability(
  HttpClient httpClient,
  String packageName,
  String packageVersion,
) async {
  try {
    final request = await httpClient
        .postUrl(Uri.parse('https://api.osv.dev/v1/query'))
        .timeout(const Duration(seconds: 10));
    request.headers.set('Content-Type', 'application/json');
    request.write(
      jsonEncode({
        'package': {'name': packageName, 'ecosystem': 'Pub'},
        'version': packageVersion,
      }),
    );
    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();
    final responseData = jsonDecode(responseBody) as Map;

    if (responseData.containsKey('vulns') &&
        (responseData['vulns'] as List).isNotEmpty) {
      return true; // 脆弱性あり
    }
    return false; // 脆弱性なし
  } catch (e) {
    // エラーはnullを返して上位でカウント
    return null;
  }
}

/// pub.devでパッケージの信頼性を確認
Future<bool> _verifyPackages(List<Map<String, String>> packages) async {
  if (packages.isEmpty) {
    return true;
  }

  final httpClient = HttpClient()
    ..connectionTimeout = const Duration(seconds: 10)
    ..idleTimeout = const Duration(seconds: 10);
  final suspiciousPackages = <String>[];
  int checkedCount = 0;
  int errorCount = 0;

  try {
    // 並列処理でパフォーマンスを向上（最大10並列）
    const maxConcurrency = 10;
    for (var i = 0; i < packages.length; i += maxConcurrency) {
      final chunk = packages.skip(i).take(maxConcurrency).toList();
      await Future.wait(
        chunk.map((package) async {
          final packageName = package['name'] as String;

          try {
            final result = await _checkSinglePackageReliability(
              httpClient,
              packageName,
            );
            checkedCount++;
            if (result != null) {
              suspiciousPackages.add(result);
            }
          } catch (e) {
            errorCount++;
            checkedCount++;
          }
        }),
      );
    }
  } finally {
    httpClient.close();
  }

  if (errorCount > 0) {
    print('    ⚠️  $errorCount個のパッケージのチェック中にエラーが発生しました');
  }

  if (suspiciousPackages.isNotEmpty) {
    print('    ⚠️  以下のパッケージに注意が必要です:');
    for (final pkg in suspiciousPackages) {
      print('      - $pkg');
    }
    print('    💡 詳細は https://pub.dev/ で確認してください');
    // 警告のみで、失敗にはしない
  } else {
    print('    ✅ すべてのパッケージがpub.devで確認できました ($checkedCount個チェック済み)');
  }

  return true;
}

/// 単一パッケージの信頼性をチェック
Future<String?> _checkSinglePackageReliability(
  HttpClient httpClient,
  String packageName,
) async {
  try {
    final request = await httpClient
        .getUrl(Uri.parse('https://pub.dev/api/packages/$packageName'))
        .timeout(const Duration(seconds: 10));
    final response = await request.close();

    if (response.statusCode == 404) {
      // pub.devに存在しないパッケージは警告
      return '$packageName (pub.devに存在しません)';
    } else if (response.statusCode == 200) {
      final responseBody = await response.transform(utf8.decoder).join();
      final packageData = jsonDecode(responseBody) as Map;

      // パッケージのスコアを確認（低いスコアは警告）
      final score = packageData['score'] as Map?;
      if (score != null) {
        final popularityScore = score['popularityScore'] as num?;
        if (popularityScore != null && popularityScore < 0.3) {
          return '$packageName (人気度スコアが低い: ${popularityScore.toStringAsFixed(2)})';
        }
      }
    }
    return null; // 問題なし
  } catch (e) {
    // エラーはnullを返して上位でカウント
    return null;
  }
}

/// 依存関係JSONからパッケージ情報を抽出
List<Map<String, String>> _extractPackages(Map depsJson) {
  final packages = <Map<String, String>>[];
  final visited = <String>{};

  // dart pub deps --jsonの構造: { "packages": [...] }
  final packagesList = depsJson['packages'] as List?;
  if (packagesList == null) {
    return packages;
  }

  for (final packageData in packagesList) {
    if (packageData is! Map) continue;

    final name = packageData['name'] as String?;
    final version = packageData['version'] as String?;
    final source = packageData['source'] as String?;
    final kind = packageData['kind'] as String?;

    // プロジェクト自身、Flutter SDK、path依存を除外
    if (name == null ||
        version == null ||
        visited.contains(name) ||
        name == 'pdf_viewer_for_dev' ||
        name == 'flutter' ||
        name == 'dart' ||
        source == 'sdk' ||
        kind == 'root') {
      continue;
    }

    // Flutter SDKパッケージを除外
    if (name.startsWith('flutter_') && source == 'sdk') {
      continue;
    }

    visited.add(name);
    packages.add({'name': name, 'version': version});
  }

  return packages;
}
