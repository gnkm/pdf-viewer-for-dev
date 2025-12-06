// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConfigModel _$ConfigModelFromJson(Map<String, dynamic> json) => _ConfigModel(
  defaultMode: json['default_mode'] == null
      ? AppMode.vim
      : _modeFromStr(json['default_mode']),
  theme: json['theme'] as String? ?? 'system',
  lastSession: json['lastSession'] == null
      ? null
      : LastSession.fromJson(json['lastSession'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ConfigModelToJson(_ConfigModel instance) =>
    <String, dynamic>{
      'default_mode': _$AppModeEnumMap[instance.defaultMode]!,
      'theme': instance.theme,
      'lastSession': instance.lastSession,
    };

const _$AppModeEnumMap = {AppMode.emacs: 'emacs', AppMode.vim: 'vim'};

_LastSession _$LastSessionFromJson(Map<String, dynamic> json) => _LastSession(
  filePath: json['filePath'] as String?,
  pageNumber: (json['pageNumber'] as num?)?.toInt(),
  zoom: (json['zoom'] as num?)?.toDouble(),
);

Map<String, dynamic> _$LastSessionToJson(_LastSession instance) =>
    <String, dynamic>{
      'filePath': instance.filePath,
      'pageNumber': instance.pageNumber,
      'zoom': instance.zoom,
    };
