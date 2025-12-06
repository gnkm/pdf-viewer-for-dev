import 'package:freezed_annotation/freezed_annotation.dart';
import 'app_mode.dart';

part 'config_model.freezed.dart';
part 'config_model.g.dart';

@freezed
abstract class ConfigModel with _$ConfigModel {
  const factory ConfigModel({
    // ignore: invalid_annotation_target
    @Default(AppMode.vim)
    @JsonKey(name: 'default_mode', fromJson: _modeFromStr)
    AppMode defaultMode,

    @Default('system') String theme,
    LastSession? lastSession,
  }) = _ConfigModel;

  factory ConfigModel.fromJson(Map<String, dynamic> json) =>
      _$ConfigModelFromJson(json);
}

@freezed
abstract class LastSession with _$LastSession {
  const factory LastSession({
    String? filePath,
    int? pageNumber,
    double? zoom,
    // Add other state if needed
  }) = _LastSession;

  factory LastSession.fromJson(Map<String, dynamic> json) =>
      _$LastSessionFromJson(json);
}

AppMode _modeFromStr(dynamic value) {
  if (value is String) {
    return AppMode.fromString(value);
  }
  return AppMode.vim;
}
