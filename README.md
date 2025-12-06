# PDF Viewer for Developers (vfd)

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

### 備考
- **WASM に関する警告**: デバッグビルド時に "Bundling PDFium WASM" という警告が表示されることがありますが、デスクトップ開発においては無視して問題ありません。
