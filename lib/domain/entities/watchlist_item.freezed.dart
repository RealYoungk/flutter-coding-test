// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'watchlist_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WatchlistItem {

 String get stockCode; int? get targetPrice; AlertType get alertType; DateTime get createdAt;
/// Create a copy of WatchlistItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WatchlistItemCopyWith<WatchlistItem> get copyWith => _$WatchlistItemCopyWithImpl<WatchlistItem>(this as WatchlistItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchlistItem&&(identical(other.stockCode, stockCode) || other.stockCode == stockCode)&&(identical(other.targetPrice, targetPrice) || other.targetPrice == targetPrice)&&(identical(other.alertType, alertType) || other.alertType == alertType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,stockCode,targetPrice,alertType,createdAt);

@override
String toString() {
  return 'WatchlistItem(stockCode: $stockCode, targetPrice: $targetPrice, alertType: $alertType, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $WatchlistItemCopyWith<$Res>  {
  factory $WatchlistItemCopyWith(WatchlistItem value, $Res Function(WatchlistItem) _then) = _$WatchlistItemCopyWithImpl;
@useResult
$Res call({
 String stockCode, int? targetPrice, AlertType alertType, DateTime createdAt
});




}
/// @nodoc
class _$WatchlistItemCopyWithImpl<$Res>
    implements $WatchlistItemCopyWith<$Res> {
  _$WatchlistItemCopyWithImpl(this._self, this._then);

  final WatchlistItem _self;
  final $Res Function(WatchlistItem) _then;

/// Create a copy of WatchlistItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stockCode = null,Object? targetPrice = freezed,Object? alertType = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
stockCode: null == stockCode ? _self.stockCode : stockCode // ignore: cast_nullable_to_non_nullable
as String,targetPrice: freezed == targetPrice ? _self.targetPrice : targetPrice // ignore: cast_nullable_to_non_nullable
as int?,alertType: null == alertType ? _self.alertType : alertType // ignore: cast_nullable_to_non_nullable
as AlertType,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [WatchlistItem].
extension WatchlistItemPatterns on WatchlistItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WatchlistItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WatchlistItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WatchlistItem value)  $default,){
final _that = this;
switch (_that) {
case _WatchlistItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WatchlistItem value)?  $default,){
final _that = this;
switch (_that) {
case _WatchlistItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String stockCode,  int? targetPrice,  AlertType alertType,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WatchlistItem() when $default != null:
return $default(_that.stockCode,_that.targetPrice,_that.alertType,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String stockCode,  int? targetPrice,  AlertType alertType,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _WatchlistItem():
return $default(_that.stockCode,_that.targetPrice,_that.alertType,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String stockCode,  int? targetPrice,  AlertType alertType,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _WatchlistItem() when $default != null:
return $default(_that.stockCode,_that.targetPrice,_that.alertType,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _WatchlistItem implements WatchlistItem {
  const _WatchlistItem({required this.stockCode, this.targetPrice, required this.alertType, required this.createdAt});
  

@override final  String stockCode;
@override final  int? targetPrice;
@override final  AlertType alertType;
@override final  DateTime createdAt;

/// Create a copy of WatchlistItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchlistItemCopyWith<_WatchlistItem> get copyWith => __$WatchlistItemCopyWithImpl<_WatchlistItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchlistItem&&(identical(other.stockCode, stockCode) || other.stockCode == stockCode)&&(identical(other.targetPrice, targetPrice) || other.targetPrice == targetPrice)&&(identical(other.alertType, alertType) || other.alertType == alertType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,stockCode,targetPrice,alertType,createdAt);

@override
String toString() {
  return 'WatchlistItem(stockCode: $stockCode, targetPrice: $targetPrice, alertType: $alertType, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$WatchlistItemCopyWith<$Res> implements $WatchlistItemCopyWith<$Res> {
  factory _$WatchlistItemCopyWith(_WatchlistItem value, $Res Function(_WatchlistItem) _then) = __$WatchlistItemCopyWithImpl;
@override @useResult
$Res call({
 String stockCode, int? targetPrice, AlertType alertType, DateTime createdAt
});




}
/// @nodoc
class __$WatchlistItemCopyWithImpl<$Res>
    implements _$WatchlistItemCopyWith<$Res> {
  __$WatchlistItemCopyWithImpl(this._self, this._then);

  final _WatchlistItem _self;
  final $Res Function(_WatchlistItem) _then;

/// Create a copy of WatchlistItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stockCode = null,Object? targetPrice = freezed,Object? alertType = null,Object? createdAt = null,}) {
  return _then(_WatchlistItem(
stockCode: null == stockCode ? _self.stockCode : stockCode // ignore: cast_nullable_to_non_nullable
as String,targetPrice: freezed == targetPrice ? _self.targetPrice : targetPrice // ignore: cast_nullable_to_non_nullable
as int?,alertType: null == alertType ? _self.alertType : alertType // ignore: cast_nullable_to_non_nullable
as AlertType,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
