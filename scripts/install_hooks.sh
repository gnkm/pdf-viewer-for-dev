#!/bin/bash
# Git hooksをインストールするスクリプト

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
HOOKS_DIR="$PROJECT_ROOT/.git/hooks"

echo "🔧 Git hooksをインストールしています..."

# pre-commitフックを作成
cat > "$HOOKS_DIR/pre-commit" << 'EOF'
#!/bin/bash
# Pre-commitフック: lint、テスト、セキュリティチェックを実行

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$SCRIPT_DIR"

# Dartスクリプトを実行
dart run scripts/pre_commit.dart

# スクリプトが成功した場合のみコミットを許可
exit $?
EOF

chmod +x "$HOOKS_DIR/pre-commit"

echo "✅ Git hooksのインストールが完了しました！"
echo ""
echo "次回のコミットから、以下のチェックが自動的に実行されます:"
echo "  - Lintチェック (flutter analyze)"
echo "  - フォーマットチェック (dart format)"
echo "  - テスト実行 (flutter test)"
echo "  - セキュリティチェック (dart pub outdated)"

