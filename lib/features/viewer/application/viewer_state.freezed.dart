// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'viewer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchMatch {

 int get pageNumber; int get matchIndex;
/// Create a copy of SearchMatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchMatchCopyWith<SearchMatch> get copyWith => _$SearchMatchCopyWithImpl<SearchMatch>(this as SearchMatch, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchMatch&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.matchIndex, matchIndex) || other.matchIndex == matchIndex));
}


@override
int get hashCode => Object.hash(runtimeType,pageNumber,matchIndex);

@override
String toString() {
  return 'SearchMatch(pageNumber: $pageNumber, matchIndex: $matchIndex)';
}


}

/// @nodoc
abstract mixin class $SearchMatchCopyWith<$Res>  {
  factory $SearchMatchCopyWith(SearchMatch value, $Res Function(SearchMatch) _then) = _$SearchMatchCopyWithImpl;
@useResult
$Res call({
 int pageNumber, int matchIndex
});




}
/// @nodoc
class _$SearchMatchCopyWithImpl<$Res>
    implements $SearchMatchCopyWith<$Res> {
  _$SearchMatchCopyWithImpl(this._self, this._then);

  final SearchMatch _self;
  final $Res Function(SearchMatch) _then;

/// Create a copy of SearchMatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pageNumber = null,Object? matchIndex = null,}) {
  return _then(_self.copyWith(
pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,matchIndex: null == matchIndex ? _self.matchIndex : matchIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchMatch].
extension SearchMatchPatterns on SearchMatch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchMatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchMatch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchMatch value)  $default,){
final _that = this;
switch (_that) {
case _SearchMatch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchMatch value)?  $default,){
final _that = this;
switch (_that) {
case _SearchMatch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int pageNumber,  int matchIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchMatch() when $default != null:
return $default(_that.pageNumber,_that.matchIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int pageNumber,  int matchIndex)  $default,) {final _that = this;
switch (_that) {
case _SearchMatch():
return $default(_that.pageNumber,_that.matchIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int pageNumber,  int matchIndex)?  $default,) {final _that = this;
switch (_that) {
case _SearchMatch() when $default != null:
return $default(_that.pageNumber,_that.matchIndex);case _:
  return null;

}
}

}

/// @nodoc


class _SearchMatch implements SearchMatch {
  const _SearchMatch({required this.pageNumber, required this.matchIndex});
  

@override final  int pageNumber;
@override final  int matchIndex;

/// Create a copy of SearchMatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchMatchCopyWith<_SearchMatch> get copyWith => __$SearchMatchCopyWithImpl<_SearchMatch>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchMatch&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.matchIndex, matchIndex) || other.matchIndex == matchIndex));
}


@override
int get hashCode => Object.hash(runtimeType,pageNumber,matchIndex);

@override
String toString() {
  return 'SearchMatch(pageNumber: $pageNumber, matchIndex: $matchIndex)';
}


}

/// @nodoc
abstract mixin class _$SearchMatchCopyWith<$Res> implements $SearchMatchCopyWith<$Res> {
  factory _$SearchMatchCopyWith(_SearchMatch value, $Res Function(_SearchMatch) _then) = __$SearchMatchCopyWithImpl;
@override @useResult
$Res call({
 int pageNumber, int matchIndex
});




}
/// @nodoc
class __$SearchMatchCopyWithImpl<$Res>
    implements _$SearchMatchCopyWith<$Res> {
  __$SearchMatchCopyWithImpl(this._self, this._then);

  final _SearchMatch _self;
  final $Res Function(_SearchMatch) _then;

/// Create a copy of SearchMatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pageNumber = null,Object? matchIndex = null,}) {
  return _then(_SearchMatch(
pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,matchIndex: null == matchIndex ? _self.matchIndex : matchIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ViewerState {

 int get pageNumber; double get zoom; String? get filePath; AppMode get mode; bool get isSearchActive; String? get searchQuery; List<SearchMatch> get searchMatches; int? get currentSearchMatchIndex;
/// Create a copy of ViewerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ViewerStateCopyWith<ViewerState> get copyWith => _$ViewerStateCopyWithImpl<ViewerState>(this as ViewerState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ViewerState&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.zoom, zoom) || other.zoom == zoom)&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.isSearchActive, isSearchActive) || other.isSearchActive == isSearchActive)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&const DeepCollectionEquality().equals(other.searchMatches, searchMatches)&&(identical(other.currentSearchMatchIndex, currentSearchMatchIndex) || other.currentSearchMatchIndex == currentSearchMatchIndex));
}


@override
int get hashCode => Object.hash(runtimeType,pageNumber,zoom,filePath,mode,isSearchActive,searchQuery,const DeepCollectionEquality().hash(searchMatches),currentSearchMatchIndex);

@override
String toString() {
  return 'ViewerState(pageNumber: $pageNumber, zoom: $zoom, filePath: $filePath, mode: $mode, isSearchActive: $isSearchActive, searchQuery: $searchQuery, searchMatches: $searchMatches, currentSearchMatchIndex: $currentSearchMatchIndex)';
}


}

/// @nodoc
abstract mixin class $ViewerStateCopyWith<$Res>  {
  factory $ViewerStateCopyWith(ViewerState value, $Res Function(ViewerState) _then) = _$ViewerStateCopyWithImpl;
@useResult
$Res call({
 int pageNumber, double zoom, String? filePath, AppMode mode, bool isSearchActive, String? searchQuery, List<SearchMatch> searchMatches, int? currentSearchMatchIndex
});




}
/// @nodoc
class _$ViewerStateCopyWithImpl<$Res>
    implements $ViewerStateCopyWith<$Res> {
  _$ViewerStateCopyWithImpl(this._self, this._then);

  final ViewerState _self;
  final $Res Function(ViewerState) _then;

/// Create a copy of ViewerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pageNumber = null,Object? zoom = null,Object? filePath = freezed,Object? mode = null,Object? isSearchActive = null,Object? searchQuery = freezed,Object? searchMatches = null,Object? currentSearchMatchIndex = freezed,}) {
  return _then(_self.copyWith(
pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,zoom: null == zoom ? _self.zoom : zoom // ignore: cast_nullable_to_non_nullable
as double,filePath: freezed == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String?,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as AppMode,isSearchActive: null == isSearchActive ? _self.isSearchActive : isSearchActive // ignore: cast_nullable_to_non_nullable
as bool,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,searchMatches: null == searchMatches ? _self.searchMatches : searchMatches // ignore: cast_nullable_to_non_nullable
as List<SearchMatch>,currentSearchMatchIndex: freezed == currentSearchMatchIndex ? _self.currentSearchMatchIndex : currentSearchMatchIndex // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ViewerState].
extension ViewerStatePatterns on ViewerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ViewerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ViewerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ViewerState value)  $default,){
final _that = this;
switch (_that) {
case _ViewerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ViewerState value)?  $default,){
final _that = this;
switch (_that) {
case _ViewerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int pageNumber,  double zoom,  String? filePath,  AppMode mode,  bool isSearchActive,  String? searchQuery,  List<SearchMatch> searchMatches,  int? currentSearchMatchIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ViewerState() when $default != null:
return $default(_that.pageNumber,_that.zoom,_that.filePath,_that.mode,_that.isSearchActive,_that.searchQuery,_that.searchMatches,_that.currentSearchMatchIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int pageNumber,  double zoom,  String? filePath,  AppMode mode,  bool isSearchActive,  String? searchQuery,  List<SearchMatch> searchMatches,  int? currentSearchMatchIndex)  $default,) {final _that = this;
switch (_that) {
case _ViewerState():
return $default(_that.pageNumber,_that.zoom,_that.filePath,_that.mode,_that.isSearchActive,_that.searchQuery,_that.searchMatches,_that.currentSearchMatchIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int pageNumber,  double zoom,  String? filePath,  AppMode mode,  bool isSearchActive,  String? searchQuery,  List<SearchMatch> searchMatches,  int? currentSearchMatchIndex)?  $default,) {final _that = this;
switch (_that) {
case _ViewerState() when $default != null:
return $default(_that.pageNumber,_that.zoom,_that.filePath,_that.mode,_that.isSearchActive,_that.searchQuery,_that.searchMatches,_that.currentSearchMatchIndex);case _:
  return null;

}
}

}

/// @nodoc


class _ViewerState implements ViewerState {
  const _ViewerState({this.pageNumber = 1, this.zoom = 1.0, this.filePath, this.mode = AppMode.vim, this.isSearchActive = false, this.searchQuery, final  List<SearchMatch> searchMatches = const [], this.currentSearchMatchIndex}): _searchMatches = searchMatches;
  

@override@JsonKey() final  int pageNumber;
@override@JsonKey() final  double zoom;
@override final  String? filePath;
@override@JsonKey() final  AppMode mode;
@override@JsonKey() final  bool isSearchActive;
@override final  String? searchQuery;
 final  List<SearchMatch> _searchMatches;
@override@JsonKey() List<SearchMatch> get searchMatches {
  if (_searchMatches is EqualUnmodifiableListView) return _searchMatches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_searchMatches);
}

@override final  int? currentSearchMatchIndex;

/// Create a copy of ViewerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ViewerStateCopyWith<_ViewerState> get copyWith => __$ViewerStateCopyWithImpl<_ViewerState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ViewerState&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.zoom, zoom) || other.zoom == zoom)&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.isSearchActive, isSearchActive) || other.isSearchActive == isSearchActive)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&const DeepCollectionEquality().equals(other._searchMatches, _searchMatches)&&(identical(other.currentSearchMatchIndex, currentSearchMatchIndex) || other.currentSearchMatchIndex == currentSearchMatchIndex));
}


@override
int get hashCode => Object.hash(runtimeType,pageNumber,zoom,filePath,mode,isSearchActive,searchQuery,const DeepCollectionEquality().hash(_searchMatches),currentSearchMatchIndex);

@override
String toString() {
  return 'ViewerState(pageNumber: $pageNumber, zoom: $zoom, filePath: $filePath, mode: $mode, isSearchActive: $isSearchActive, searchQuery: $searchQuery, searchMatches: $searchMatches, currentSearchMatchIndex: $currentSearchMatchIndex)';
}


}

/// @nodoc
abstract mixin class _$ViewerStateCopyWith<$Res> implements $ViewerStateCopyWith<$Res> {
  factory _$ViewerStateCopyWith(_ViewerState value, $Res Function(_ViewerState) _then) = __$ViewerStateCopyWithImpl;
@override @useResult
$Res call({
 int pageNumber, double zoom, String? filePath, AppMode mode, bool isSearchActive, String? searchQuery, List<SearchMatch> searchMatches, int? currentSearchMatchIndex
});




}
/// @nodoc
class __$ViewerStateCopyWithImpl<$Res>
    implements _$ViewerStateCopyWith<$Res> {
  __$ViewerStateCopyWithImpl(this._self, this._then);

  final _ViewerState _self;
  final $Res Function(_ViewerState) _then;

/// Create a copy of ViewerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pageNumber = null,Object? zoom = null,Object? filePath = freezed,Object? mode = null,Object? isSearchActive = null,Object? searchQuery = freezed,Object? searchMatches = null,Object? currentSearchMatchIndex = freezed,}) {
  return _then(_ViewerState(
pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,zoom: null == zoom ? _self.zoom : zoom // ignore: cast_nullable_to_non_nullable
as double,filePath: freezed == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String?,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as AppMode,isSearchActive: null == isSearchActive ? _self.isSearchActive : isSearchActive // ignore: cast_nullable_to_non_nullable
as bool,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,searchMatches: null == searchMatches ? _self._searchMatches : searchMatches // ignore: cast_nullable_to_non_nullable
as List<SearchMatch>,currentSearchMatchIndex: freezed == currentSearchMatchIndex ? _self.currentSearchMatchIndex : currentSearchMatchIndex // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
