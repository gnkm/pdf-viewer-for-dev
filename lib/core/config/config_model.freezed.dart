// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'config_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConfigModel {

// ignore: invalid_annotation_target
@JsonKey(name: 'default_mode', fromJson: _modeFromStr) AppMode get defaultMode; String get theme; LastSession? get lastSession;
/// Create a copy of ConfigModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConfigModelCopyWith<ConfigModel> get copyWith => _$ConfigModelCopyWithImpl<ConfigModel>(this as ConfigModel, _$identity);

  /// Serializes this ConfigModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfigModel&&(identical(other.defaultMode, defaultMode) || other.defaultMode == defaultMode)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.lastSession, lastSession) || other.lastSession == lastSession));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,defaultMode,theme,lastSession);

@override
String toString() {
  return 'ConfigModel(defaultMode: $defaultMode, theme: $theme, lastSession: $lastSession)';
}


}

/// @nodoc
abstract mixin class $ConfigModelCopyWith<$Res>  {
  factory $ConfigModelCopyWith(ConfigModel value, $Res Function(ConfigModel) _then) = _$ConfigModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'default_mode', fromJson: _modeFromStr) AppMode defaultMode, String theme, LastSession? lastSession
});


$LastSessionCopyWith<$Res>? get lastSession;

}
/// @nodoc
class _$ConfigModelCopyWithImpl<$Res>
    implements $ConfigModelCopyWith<$Res> {
  _$ConfigModelCopyWithImpl(this._self, this._then);

  final ConfigModel _self;
  final $Res Function(ConfigModel) _then;

/// Create a copy of ConfigModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? defaultMode = null,Object? theme = null,Object? lastSession = freezed,}) {
  return _then(_self.copyWith(
defaultMode: null == defaultMode ? _self.defaultMode : defaultMode // ignore: cast_nullable_to_non_nullable
as AppMode,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String,lastSession: freezed == lastSession ? _self.lastSession : lastSession // ignore: cast_nullable_to_non_nullable
as LastSession?,
  ));
}
/// Create a copy of ConfigModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LastSessionCopyWith<$Res>? get lastSession {
    if (_self.lastSession == null) {
    return null;
  }

  return $LastSessionCopyWith<$Res>(_self.lastSession!, (value) {
    return _then(_self.copyWith(lastSession: value));
  });
}
}


/// Adds pattern-matching-related methods to [ConfigModel].
extension ConfigModelPatterns on ConfigModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConfigModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConfigModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConfigModel value)  $default,){
final _that = this;
switch (_that) {
case _ConfigModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConfigModel value)?  $default,){
final _that = this;
switch (_that) {
case _ConfigModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'default_mode', fromJson: _modeFromStr)  AppMode defaultMode,  String theme,  LastSession? lastSession)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConfigModel() when $default != null:
return $default(_that.defaultMode,_that.theme,_that.lastSession);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'default_mode', fromJson: _modeFromStr)  AppMode defaultMode,  String theme,  LastSession? lastSession)  $default,) {final _that = this;
switch (_that) {
case _ConfigModel():
return $default(_that.defaultMode,_that.theme,_that.lastSession);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'default_mode', fromJson: _modeFromStr)  AppMode defaultMode,  String theme,  LastSession? lastSession)?  $default,) {final _that = this;
switch (_that) {
case _ConfigModel() when $default != null:
return $default(_that.defaultMode,_that.theme,_that.lastSession);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConfigModel implements ConfigModel {
  const _ConfigModel({@JsonKey(name: 'default_mode', fromJson: _modeFromStr) this.defaultMode = AppMode.vim, this.theme = 'system', this.lastSession});
  factory _ConfigModel.fromJson(Map<String, dynamic> json) => _$ConfigModelFromJson(json);

// ignore: invalid_annotation_target
@override@JsonKey(name: 'default_mode', fromJson: _modeFromStr) final  AppMode defaultMode;
@override@JsonKey() final  String theme;
@override final  LastSession? lastSession;

/// Create a copy of ConfigModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConfigModelCopyWith<_ConfigModel> get copyWith => __$ConfigModelCopyWithImpl<_ConfigModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConfigModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfigModel&&(identical(other.defaultMode, defaultMode) || other.defaultMode == defaultMode)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.lastSession, lastSession) || other.lastSession == lastSession));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,defaultMode,theme,lastSession);

@override
String toString() {
  return 'ConfigModel(defaultMode: $defaultMode, theme: $theme, lastSession: $lastSession)';
}


}

/// @nodoc
abstract mixin class _$ConfigModelCopyWith<$Res> implements $ConfigModelCopyWith<$Res> {
  factory _$ConfigModelCopyWith(_ConfigModel value, $Res Function(_ConfigModel) _then) = __$ConfigModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'default_mode', fromJson: _modeFromStr) AppMode defaultMode, String theme, LastSession? lastSession
});


@override $LastSessionCopyWith<$Res>? get lastSession;

}
/// @nodoc
class __$ConfigModelCopyWithImpl<$Res>
    implements _$ConfigModelCopyWith<$Res> {
  __$ConfigModelCopyWithImpl(this._self, this._then);

  final _ConfigModel _self;
  final $Res Function(_ConfigModel) _then;

/// Create a copy of ConfigModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? defaultMode = null,Object? theme = null,Object? lastSession = freezed,}) {
  return _then(_ConfigModel(
defaultMode: null == defaultMode ? _self.defaultMode : defaultMode // ignore: cast_nullable_to_non_nullable
as AppMode,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String,lastSession: freezed == lastSession ? _self.lastSession : lastSession // ignore: cast_nullable_to_non_nullable
as LastSession?,
  ));
}

/// Create a copy of ConfigModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LastSessionCopyWith<$Res>? get lastSession {
    if (_self.lastSession == null) {
    return null;
  }

  return $LastSessionCopyWith<$Res>(_self.lastSession!, (value) {
    return _then(_self.copyWith(lastSession: value));
  });
}
}


/// @nodoc
mixin _$LastSession {

 String? get filePath; int? get pageNumber; double? get zoom;
/// Create a copy of LastSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LastSessionCopyWith<LastSession> get copyWith => _$LastSessionCopyWithImpl<LastSession>(this as LastSession, _$identity);

  /// Serializes this LastSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LastSession&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.zoom, zoom) || other.zoom == zoom));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,filePath,pageNumber,zoom);

@override
String toString() {
  return 'LastSession(filePath: $filePath, pageNumber: $pageNumber, zoom: $zoom)';
}


}

/// @nodoc
abstract mixin class $LastSessionCopyWith<$Res>  {
  factory $LastSessionCopyWith(LastSession value, $Res Function(LastSession) _then) = _$LastSessionCopyWithImpl;
@useResult
$Res call({
 String? filePath, int? pageNumber, double? zoom
});




}
/// @nodoc
class _$LastSessionCopyWithImpl<$Res>
    implements $LastSessionCopyWith<$Res> {
  _$LastSessionCopyWithImpl(this._self, this._then);

  final LastSession _self;
  final $Res Function(LastSession) _then;

/// Create a copy of LastSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? filePath = freezed,Object? pageNumber = freezed,Object? zoom = freezed,}) {
  return _then(_self.copyWith(
filePath: freezed == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String?,pageNumber: freezed == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int?,zoom: freezed == zoom ? _self.zoom : zoom // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [LastSession].
extension LastSessionPatterns on LastSession {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LastSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LastSession() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LastSession value)  $default,){
final _that = this;
switch (_that) {
case _LastSession():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LastSession value)?  $default,){
final _that = this;
switch (_that) {
case _LastSession() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? filePath,  int? pageNumber,  double? zoom)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LastSession() when $default != null:
return $default(_that.filePath,_that.pageNumber,_that.zoom);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? filePath,  int? pageNumber,  double? zoom)  $default,) {final _that = this;
switch (_that) {
case _LastSession():
return $default(_that.filePath,_that.pageNumber,_that.zoom);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? filePath,  int? pageNumber,  double? zoom)?  $default,) {final _that = this;
switch (_that) {
case _LastSession() when $default != null:
return $default(_that.filePath,_that.pageNumber,_that.zoom);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LastSession implements LastSession {
  const _LastSession({this.filePath, this.pageNumber, this.zoom});
  factory _LastSession.fromJson(Map<String, dynamic> json) => _$LastSessionFromJson(json);

@override final  String? filePath;
@override final  int? pageNumber;
@override final  double? zoom;

/// Create a copy of LastSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LastSessionCopyWith<_LastSession> get copyWith => __$LastSessionCopyWithImpl<_LastSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LastSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LastSession&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.zoom, zoom) || other.zoom == zoom));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,filePath,pageNumber,zoom);

@override
String toString() {
  return 'LastSession(filePath: $filePath, pageNumber: $pageNumber, zoom: $zoom)';
}


}

/// @nodoc
abstract mixin class _$LastSessionCopyWith<$Res> implements $LastSessionCopyWith<$Res> {
  factory _$LastSessionCopyWith(_LastSession value, $Res Function(_LastSession) _then) = __$LastSessionCopyWithImpl;
@override @useResult
$Res call({
 String? filePath, int? pageNumber, double? zoom
});




}
/// @nodoc
class __$LastSessionCopyWithImpl<$Res>
    implements _$LastSessionCopyWith<$Res> {
  __$LastSessionCopyWithImpl(this._self, this._then);

  final _LastSession _self;
  final $Res Function(_LastSession) _then;

/// Create a copy of LastSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? filePath = freezed,Object? pageNumber = freezed,Object? zoom = freezed,}) {
  return _then(_LastSession(
filePath: freezed == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String?,pageNumber: freezed == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int?,zoom: freezed == zoom ? _self.zoom : zoom // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
