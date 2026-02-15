// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StockState {

 Stock? get stock; List<WatchlistItem> get watchlist; ({WatchlistItem item, bool isUpper})? get triggeredAlert; bool get hasError;
/// Create a copy of StockState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockStateCopyWith<StockState> get copyWith => _$StockStateCopyWithImpl<StockState>(this as StockState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockState&&(identical(other.stock, stock) || other.stock == stock)&&const DeepCollectionEquality().equals(other.watchlist, watchlist)&&(identical(other.triggeredAlert, triggeredAlert) || other.triggeredAlert == triggeredAlert)&&(identical(other.hasError, hasError) || other.hasError == hasError));
}


@override
int get hashCode => Object.hash(runtimeType,stock,const DeepCollectionEquality().hash(watchlist),triggeredAlert,hasError);

@override
String toString() {
  return 'StockState(stock: $stock, watchlist: $watchlist, triggeredAlert: $triggeredAlert, hasError: $hasError)';
}


}

/// @nodoc
abstract mixin class $StockStateCopyWith<$Res>  {
  factory $StockStateCopyWith(StockState value, $Res Function(StockState) _then) = _$StockStateCopyWithImpl;
@useResult
$Res call({
 Stock? stock, List<WatchlistItem> watchlist, ({WatchlistItem item, bool isUpper})? triggeredAlert, bool hasError
});


$StockCopyWith<$Res>? get stock;

}
/// @nodoc
class _$StockStateCopyWithImpl<$Res>
    implements $StockStateCopyWith<$Res> {
  _$StockStateCopyWithImpl(this._self, this._then);

  final StockState _self;
  final $Res Function(StockState) _then;

/// Create a copy of StockState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stock = freezed,Object? watchlist = null,Object? triggeredAlert = freezed,Object? hasError = null,}) {
  return _then(_self.copyWith(
stock: freezed == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as Stock?,watchlist: null == watchlist ? _self.watchlist : watchlist // ignore: cast_nullable_to_non_nullable
as List<WatchlistItem>,triggeredAlert: freezed == triggeredAlert ? _self.triggeredAlert : triggeredAlert // ignore: cast_nullable_to_non_nullable
as ({WatchlistItem item, bool isUpper})?,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of StockState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StockCopyWith<$Res>? get stock {
    if (_self.stock == null) {
    return null;
  }

  return $StockCopyWith<$Res>(_self.stock!, (value) {
    return _then(_self.copyWith(stock: value));
  });
}
}


/// Adds pattern-matching-related methods to [StockState].
extension StockStatePatterns on StockState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockState value)  $default,){
final _that = this;
switch (_that) {
case _StockState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockState value)?  $default,){
final _that = this;
switch (_that) {
case _StockState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Stock? stock,  List<WatchlistItem> watchlist,  ({WatchlistItem item, bool isUpper})? triggeredAlert,  bool hasError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockState() when $default != null:
return $default(_that.stock,_that.watchlist,_that.triggeredAlert,_that.hasError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Stock? stock,  List<WatchlistItem> watchlist,  ({WatchlistItem item, bool isUpper})? triggeredAlert,  bool hasError)  $default,) {final _that = this;
switch (_that) {
case _StockState():
return $default(_that.stock,_that.watchlist,_that.triggeredAlert,_that.hasError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Stock? stock,  List<WatchlistItem> watchlist,  ({WatchlistItem item, bool isUpper})? triggeredAlert,  bool hasError)?  $default,) {final _that = this;
switch (_that) {
case _StockState() when $default != null:
return $default(_that.stock,_that.watchlist,_that.triggeredAlert,_that.hasError);case _:
  return null;

}
}

}

/// @nodoc


class _StockState extends StockState {
  const _StockState({this.stock, final  List<WatchlistItem> watchlist = const [], this.triggeredAlert, this.hasError = false}): _watchlist = watchlist,super._();
  

@override final  Stock? stock;
 final  List<WatchlistItem> _watchlist;
@override@JsonKey() List<WatchlistItem> get watchlist {
  if (_watchlist is EqualUnmodifiableListView) return _watchlist;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_watchlist);
}

@override final  ({WatchlistItem item, bool isUpper})? triggeredAlert;
@override@JsonKey() final  bool hasError;

/// Create a copy of StockState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockStateCopyWith<_StockState> get copyWith => __$StockStateCopyWithImpl<_StockState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockState&&(identical(other.stock, stock) || other.stock == stock)&&const DeepCollectionEquality().equals(other._watchlist, _watchlist)&&(identical(other.triggeredAlert, triggeredAlert) || other.triggeredAlert == triggeredAlert)&&(identical(other.hasError, hasError) || other.hasError == hasError));
}


@override
int get hashCode => Object.hash(runtimeType,stock,const DeepCollectionEquality().hash(_watchlist),triggeredAlert,hasError);

@override
String toString() {
  return 'StockState(stock: $stock, watchlist: $watchlist, triggeredAlert: $triggeredAlert, hasError: $hasError)';
}


}

/// @nodoc
abstract mixin class _$StockStateCopyWith<$Res> implements $StockStateCopyWith<$Res> {
  factory _$StockStateCopyWith(_StockState value, $Res Function(_StockState) _then) = __$StockStateCopyWithImpl;
@override @useResult
$Res call({
 Stock? stock, List<WatchlistItem> watchlist, ({WatchlistItem item, bool isUpper})? triggeredAlert, bool hasError
});


@override $StockCopyWith<$Res>? get stock;

}
/// @nodoc
class __$StockStateCopyWithImpl<$Res>
    implements _$StockStateCopyWith<$Res> {
  __$StockStateCopyWithImpl(this._self, this._then);

  final _StockState _self;
  final $Res Function(_StockState) _then;

/// Create a copy of StockState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stock = freezed,Object? watchlist = null,Object? triggeredAlert = freezed,Object? hasError = null,}) {
  return _then(_StockState(
stock: freezed == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as Stock?,watchlist: null == watchlist ? _self._watchlist : watchlist // ignore: cast_nullable_to_non_nullable
as List<WatchlistItem>,triggeredAlert: freezed == triggeredAlert ? _self.triggeredAlert : triggeredAlert // ignore: cast_nullable_to_non_nullable
as ({WatchlistItem item, bool isUpper})?,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of StockState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StockCopyWith<$Res>? get stock {
    if (_self.stock == null) {
    return null;
  }

  return $StockCopyWith<$Res>(_self.stock!, (value) {
    return _then(_self.copyWith(stock: value));
  });
}
}

// dart format on
