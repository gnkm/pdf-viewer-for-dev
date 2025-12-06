import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:toml/toml.dart';
import 'config_model.dart';

class ConfigService {
  static ConfigModel parseConfig(String tomlContent) {
    if (tomlContent.trim().isEmpty) {
      return const ConfigModel();
    }
    try {
      final document = TomlDocument.parse(tomlContent).toMap();
      // Handle type mismatch if necessary, but json_serializable should handle basic types
      // fromJson expects Map<String, dynamic>
      return ConfigModel.fromJson(document);
    } catch (e) {
      // In a real app, log this error
      return const ConfigModel();
    }
  }

  static String toToml(ConfigModel config) {
    try {
      final map = config.toJson();
      final cleanMap = _removeNulls(map);
      return TomlDocument.fromMap(cleanMap).toString();
    } catch (e) {
      return '';
    }
  }

  static Map<String, dynamic> _removeNulls(Map<String, dynamic> map) {
    final newMap = <String, dynamic>{};
    map.forEach((key, value) {
      if (value != null) {
        if (value is Map<String, dynamic>) {
          newMap[key] = _removeNulls(value);
        } else {
          newMap[key] = value;
        }
      }
    });
    return newMap;
  }

  static Future<ConfigModel> load() async {
    try {
      final file = await _getConfigFile();
      if (await file.exists()) {
        final content = await file.readAsString();
        return parseConfig(content);
      }
    } catch (e) {
      // ignore
    }
    return const ConfigModel();
  }

  static Future<void> save(ConfigModel config) async {
    try {
      final file = await _getConfigFile();
      if (!await file.parent.exists()) {
        await file.parent.create(recursive: true);
      }
      await file.writeAsString(toToml(config));
    } catch (e) {
      // ignore
    }
  }

  static Future<File> _getConfigFile() async {
    String? home;
    if (Platform.isMacOS || Platform.isLinux) {
      home = Platform.environment['HOME'];
    } else if (Platform.isWindows) {
      home = Platform.environment['UserProfile'];
    }

    if (home != null) {
       return File('$home/.config/pdf-viewer-for-dev/config.toml');
    }
    // Fallback to app support if home not found (unlikely)
    final dir = await getApplicationSupportDirectory();
    return File('${dir.path}/config.toml');
  }
}
