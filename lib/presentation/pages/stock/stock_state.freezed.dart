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

 Stock get stock; bool get isLoading; List<WatchlistItem> get watchlist; ({WatchlistItem item, bool isUpper})? get triggeredAlert;
/// Create a copy of StockState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockStateCopyWith<StockState> get copyWith => _$StockStateCopyWithImpl<StockState>(this as StockState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockState&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.watchlist, watchlist)&&(identical(other.triggeredAlert, triggeredAlert) || other.triggeredAlert == triggeredAlert));
}


@override
int get hashCode => Object.hash(runtimeType,stock,isLoading,const DeepCollectionEquality().hash(watchlist),triggeredAlert);

@override
String toString() {
  return 'StockState(stock: $stock, isLoading: $isLoading, watchlist: $watchlist, triggeredAlert: $triggeredAlert)';
}


}

/// @nodoc
abstract mixin class $StockStateCopyWith<$Res>  {
  factory $StockStateCopyWith(StockState value, $Res Function(StockState) _then) = _$StockStateCopyWithImpl;
@useResult
$Res call({
 Stock stock, bool isLoading, List<WatchlistItem> watchlist, ({WatchlistItem item, bool isUpper})? triggeredAlert
});


$StockCopyWith<$Res> get stock;

}
/// @nodoc
class _$StockStateCopyWithImpl<$Res>
    implements $StockStateCopyWith<$Res> {
  _$StockStateCopyWithImpl(this._self, this._then);

  final StockState _self;
  final $Res Function(StockState) _then;

/// Create a copy of StockState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stock = null,Object? isLoading = null,Object? watchlist = null,Object? triggeredAlert = freezed,}) {
  return _then(_self.copyWith(
stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as Stock,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,watchlist: null == watchlist ? _self.watchlist : watchlist // ignore: cast_nullable_to_non_nullable
as List<WatchlistItem>,triggeredAlert: freezed == triggeredAlert ? _self.triggeredAlert : triggeredAlert // ignore: cast_nullable_to_non_nullable
as ({WatchlistItem item, bool isUpper})?,
  ));
}
/// Create a copy of StockState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StockCopyWith<$Res> get stock {
  
  return $StockCopyWith<$Res>(_self.stock, (value) {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Stock stock,  bool isLoading,  List<WatchlistItem> watchlist,  ({WatchlistItem item, bool isUpper})? triggeredAlert)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockState() when $default != null:
return $default(_that.stock,_that.isLoading,_that.watchlist,_that.triggeredAlert);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Stock stock,  bool isLoading,  List<WatchlistItem> watchlist,  ({WatchlistItem item, bool isUpper})? triggeredAlert)  $default,) {final _that = this;
switch (_that) {
case _StockState():
return $default(_that.stock,_that.isLoading,_that.watchlist,_that.triggeredAlert);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Stock stock,  bool isLoading,  List<WatchlistItem> watchlist,  ({WatchlistItem item, bool isUpper})? triggeredAlert)?  $default,) {final _that = this;
switch (_that) {
case _StockState() when $default != null:
return $default(_that.stock,_that.isLoading,_that.watchlist,_that.triggeredAlert);case _:
  return null;

}
}

}

/// @nodoc


class _StockState extends StockState {
  const _StockState({this.stock = const Stock(), this.isLoading = true, final  List<WatchlistItem> watchlist = const [], this.triggeredAlert}): _watchlist = watchlist,super._();
  

@override@JsonKey() final  Stock stock;
@override@JsonKey() final  bool isLoading;
 final  List<WatchlistItem> _watchlist;
@override@JsonKey() List<WatchlistItem> get watchlist {
  if (_watchlist is EqualUnmodifiableListView) return _watchlist;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_watchlist);
}

@override final  ({WatchlistItem item, bool isUpper})? triggeredAlert;

/// Create a copy of StockState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockStateCopyWith<_StockState> get copyWith => __$StockStateCopyWithImpl<_StockState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockState&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._watchlist, _watchlist)&&(identical(other.triggeredAlert, triggeredAlert) || other.triggeredAlert == triggeredAlert));
}


@override
int get hashCode => Object.hash(runtimeType,stock,isLoading,const DeepCollectionEquality().hash(_watchlist),triggeredAlert);

@override
String toString() {
  return 'StockState(stock: $stock, isLoading: $isLoading, watchlist: $watchlist, triggeredAlert: $triggeredAlert)';
}


}

/// @nodoc
abstract mixin class _$StockStateCopyWith<$Res> implements $StockStateCopyWith<$Res> {
  factory _$StockStateCopyWith(_StockState value, $Res Function(_StockState) _then) = __$StockStateCopyWithImpl;
@override @useResult
$Res call({
 Stock stock, bool isLoading, List<WatchlistItem> watchlist, ({WatchlistItem item, bool isUpper})? triggeredAlert
});


@override $StockCopyWith<$Res> get stock;

}
/// @nodoc
class __$StockStateCopyWithImpl<$Res>
    implements _$StockStateCopyWith<$Res> {
  __$StockStateCopyWithImpl(this._self, this._then);

  final _StockState _self;
  final $Res Function(_StockState) _then;

/// Create a copy of StockState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stock = null,Object? isLoading = null,Object? watchlist = null,Object? triggeredAlert = freezed,}) {
  return _then(_StockState(
stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as Stock,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,watchlist: null == watchlist ? _self._watchlist : watchlist // ignore: cast_nullable_to_non_nullable
as List<WatchlistItem>,triggeredAlert: freezed == triggeredAlert ? _self.triggeredAlert : triggeredAlert // ignore: cast_nullable_to_non_nullable
as ({WatchlistItem item, bool isUpper})?,
  ));
}

/// Create a copy of StockState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StockCopyWith<$Res> get stock {
  
  return $StockCopyWith<$Res>(_self.stock, (value) {
    return _then(_self.copyWith(stock: value));
  });
}
}

// dart format on
