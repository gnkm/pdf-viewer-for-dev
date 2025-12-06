// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'input_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$KeyInput {

 PhysicalKeyboardKey get key; bool get isControl; bool get isMeta; bool get isShift; bool get isAlt;
/// Create a copy of KeyInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KeyInputCopyWith<KeyInput> get copyWith => _$KeyInputCopyWithImpl<KeyInput>(this as KeyInput, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KeyInput&&(identical(other.key, key) || other.key == key)&&(identical(other.isControl, isControl) || other.isControl == isControl)&&(identical(other.isMeta, isMeta) || other.isMeta == isMeta)&&(identical(other.isShift, isShift) || other.isShift == isShift)&&(identical(other.isAlt, isAlt) || other.isAlt == isAlt));
}


@override
int get hashCode => Object.hash(runtimeType,key,isControl,isMeta,isShift,isAlt);

@override
String toString() {
  return 'KeyInput(key: $key, isControl: $isControl, isMeta: $isMeta, isShift: $isShift, isAlt: $isAlt)';
}


}

/// @nodoc
abstract mixin class $KeyInputCopyWith<$Res>  {
  factory $KeyInputCopyWith(KeyInput value, $Res Function(KeyInput) _then) = _$KeyInputCopyWithImpl;
@useResult
$Res call({
 PhysicalKeyboardKey key, bool isControl, bool isMeta, bool isShift, bool isAlt
});




}
/// @nodoc
class _$KeyInputCopyWithImpl<$Res>
    implements $KeyInputCopyWith<$Res> {
  _$KeyInputCopyWithImpl(this._self, this._then);

  final KeyInput _self;
  final $Res Function(KeyInput) _then;

/// Create a copy of KeyInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? isControl = null,Object? isMeta = null,Object? isShift = null,Object? isAlt = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as PhysicalKeyboardKey,isControl: null == isControl ? _self.isControl : isControl // ignore: cast_nullable_to_non_nullable
as bool,isMeta: null == isMeta ? _self.isMeta : isMeta // ignore: cast_nullable_to_non_nullable
as bool,isShift: null == isShift ? _self.isShift : isShift // ignore: cast_nullable_to_non_nullable
as bool,isAlt: null == isAlt ? _self.isAlt : isAlt // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [KeyInput].
extension KeyInputPatterns on KeyInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KeyInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KeyInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KeyInput value)  $default,){
final _that = this;
switch (_that) {
case _KeyInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KeyInput value)?  $default,){
final _that = this;
switch (_that) {
case _KeyInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PhysicalKeyboardKey key,  bool isControl,  bool isMeta,  bool isShift,  bool isAlt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KeyInput() when $default != null:
return $default(_that.key,_that.isControl,_that.isMeta,_that.isShift,_that.isAlt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PhysicalKeyboardKey key,  bool isControl,  bool isMeta,  bool isShift,  bool isAlt)  $default,) {final _that = this;
switch (_that) {
case _KeyInput():
return $default(_that.key,_that.isControl,_that.isMeta,_that.isShift,_that.isAlt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PhysicalKeyboardKey key,  bool isControl,  bool isMeta,  bool isShift,  bool isAlt)?  $default,) {final _that = this;
switch (_that) {
case _KeyInput() when $default != null:
return $default(_that.key,_that.isControl,_that.isMeta,_that.isShift,_that.isAlt);case _:
  return null;

}
}

}

/// @nodoc


class _KeyInput implements KeyInput {
  const _KeyInput(this.key, {this.isControl = false, this.isMeta = false, this.isShift = false, this.isAlt = false});
  

@override final  PhysicalKeyboardKey key;
@override@JsonKey() final  bool isControl;
@override@JsonKey() final  bool isMeta;
@override@JsonKey() final  bool isShift;
@override@JsonKey() final  bool isAlt;

/// Create a copy of KeyInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KeyInputCopyWith<_KeyInput> get copyWith => __$KeyInputCopyWithImpl<_KeyInput>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KeyInput&&(identical(other.key, key) || other.key == key)&&(identical(other.isControl, isControl) || other.isControl == isControl)&&(identical(other.isMeta, isMeta) || other.isMeta == isMeta)&&(identical(other.isShift, isShift) || other.isShift == isShift)&&(identical(other.isAlt, isAlt) || other.isAlt == isAlt));
}


@override
int get hashCode => Object.hash(runtimeType,key,isControl,isMeta,isShift,isAlt);

@override
String toString() {
  return 'KeyInput(key: $key, isControl: $isControl, isMeta: $isMeta, isShift: $isShift, isAlt: $isAlt)';
}


}

/// @nodoc
abstract mixin class _$KeyInputCopyWith<$Res> implements $KeyInputCopyWith<$Res> {
  factory _$KeyInputCopyWith(_KeyInput value, $Res Function(_KeyInput) _then) = __$KeyInputCopyWithImpl;
@override @useResult
$Res call({
 PhysicalKeyboardKey key, bool isControl, bool isMeta, bool isShift, bool isAlt
});




}
/// @nodoc
class __$KeyInputCopyWithImpl<$Res>
    implements _$KeyInputCopyWith<$Res> {
  __$KeyInputCopyWithImpl(this._self, this._then);

  final _KeyInput _self;
  final $Res Function(_KeyInput) _then;

/// Create a copy of KeyInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? isControl = null,Object? isMeta = null,Object? isShift = null,Object? isAlt = null,}) {
  return _then(_KeyInput(
null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as PhysicalKeyboardKey,isControl: null == isControl ? _self.isControl : isControl // ignore: cast_nullable_to_non_nullable
as bool,isMeta: null == isMeta ? _self.isMeta : isMeta // ignore: cast_nullable_to_non_nullable
as bool,isShift: null == isShift ? _self.isShift : isShift // ignore: cast_nullable_to_non_nullable
as bool,isAlt: null == isAlt ? _self.isAlt : isAlt // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
