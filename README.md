# PDF Viewer for Developers (vfd)

[![CI](https://github.com/gnkm/pdf-viewer-for-dev/actions/workflows/ci.yml/badge.svg)](https://github.com/gnkm/pdf-viewer-for-dev/actions/workflows/ci.yml)
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-macOS%20|%20Linux%20|%20Windows-blue)
![License](https://img.shields.io/github/license/gnkm/pdf-viewer-for-dev)

開発者のための、キーボード操作に特化した高パフォーマンスな PDF ビューアーです。Emacs および Vim のキーバインドをサポートしています。

## 特徴
- **キーボードナビゲーション**: Emacs (`C-n`, `C-p`) または Vim (`j`, `k`) のキーバインドで完全に操作可能。
- **高速なレンダリング**: `pdfrx` を採用し、高速な描画を実現。
- **開発者フレンドリー**:
  - TOML による設定 (`~/.config/pdf-viewer-for-dev/config.toml`)。
  - セッションの永続化 (終了時のファイル、ページ、ズーム状態を復元)。
  - CLI からの利用 (`vfd <file>`)。

## インストール

### 前提条件
- Flutter SDK がインストールされていること。

### ビルドと実行
```bash
# MacOS
flutter run -d macos
```

## 設定 (Configuration)
設定ファイルは `~/.config/pdf-viewer-for-dev/config.toml` に配置されます。
ファイルが存在しない場合、初回終了時に自動的に作成されます。

**`config.toml` の例:**
```toml
default_mode = "vim" # または "emacs"
theme = "dark" # "light", "dark", または "system"
```

## キーバインド

| 操作 | Emacs | Vim |
|--------|-------|-----|
| 次のページ | `C-n` | `j` |
| 前のページ | `C-p` | `k` |
| 最初のページ | `M-<` | `0` |
| 最後のページ | `M->` | `G` |
| 検索 | `C-s` | `/` |
| モード切替 | (UI ボタン) | (UI ボタン) |

## 開発

### プロジェクト構成
- `lib/core`: 設定、入力ハンドリングなどのコアロジック。
- `lib/features`: 機能ごとのコード (ビューアー機能など)。
- `test`: ユニットテストおよびウィジェットテスト。

### テストの実行
```bash
flutter test
```

### Pre-commitフックのセットアップ

コミット前に自動的にlint、テスト、セキュリティチェックを実行するには、以下の手順を実行してください。

```bash
# Git hooksをインストール
./scripts/install_hooks.sh

# 手動でチェックを実行
dart run scripts/pre_commit.dart
```

実行されるチェック:
- **Lintチェック**: `flutter analyze` でコードの静的解析
- **フォーマットチェック**: `dart format` でコードフォーマットの確認
- **テスト実行**: `flutter test` でユニットテストの実行
- **セキュリティチェック**: 
  - 依存関係の更新確認 (`dart pub outdated`)
  - 脆弱性スキャン (OSVデータベースを使用)
  - パッケージの信頼性確認 (pub.dev APIを使用)

### GitHub Actions CI

プッシュやプルリクエスト時に自動的に以下のチェックが実行されます：

- **コード品質チェック**:
  - Lintチェック (`flutter analyze`)
  - フォーマットチェック (`dart format`)
  - テスト実行 (`flutter test`)

- **ビルド確認**:
  - macOS ビルド
  - Windows ビルド
  - Linux ビルド

- **セキュリティチェック**（警告のみ）:
  - 依存関係の更新確認
  - 脆弱性スキャン

### リリース

リリースはGitHub Actionsで自動的にビルドされます。タグを作成すると、各プラットフォームのビルド成果物がGitHub Releasesに自動アップロードされます。

```bash
# リリースタグを作成
git tag v1.0.0
git push origin v1.0.0
```

タグがプッシュされると、以下のワークフローが自動実行されます：
- macOS、Windows、Linuxの各プラットフォームでリリースビルド
- ビルド成果物をGitHub Releasesに自動アップロード
- リリースノートを自動生成

### 備考
- **WASM に関する警告**: デバッグビルド時に "Bundling PDFium WASM" という警告が表示されることがありますが、デスクトップ開発においては無視して問題ありません。
