import 'package:flutter_test/flutter_test.dart';
import 'package:pdf_viewer_for_dev/core/config/app_mode.dart';
import 'package:pdf_viewer_for_dev/core/config/config_model.dart';
import 'package:pdf_viewer_for_dev/core/config/config_service.dart';

void main() {
  group('ConfigService', () {
    test('parseConfig returns default values for empty string', () {
      final config = ConfigService.parseConfig('');
      expect(config.defaultMode, AppMode.vim);
      expect(config.theme, 'system');
    });

    test('parseConfig parses valid TOML', () {
      const toml = '''
default_mode = "vim"
theme = "dark"
''';
      final config = ConfigService.parseConfig(toml);
      expect(config.defaultMode, AppMode.vim);
      expect(config.theme, 'dark');
    });

    test('parseConfig handles invalid values gracefully', () {
      const toml = '''
default_mode = "unknown"
theme = 123
''';
      final config = ConfigService.parseConfig(toml);
      expect(config.defaultMode, AppMode.vim); // Fallback
      expect(config.theme, 'system'); // Fallback
    });

    test('toToml generates valid TOML string', () {
      const config = ConfigModel(defaultMode: AppMode.vim, theme: 'light');
      final toml = ConfigService.toToml(config);

      expect(toml, contains("default_mode = 'vim'"));
      expect(toml, contains("theme = 'light'"));
    });
  });
}
