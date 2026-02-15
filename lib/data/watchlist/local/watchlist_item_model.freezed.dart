// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'watchlist_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WatchlistItemModel {

 String get stockCode; int? get targetPrice; AlertType get alertType; DateTime get createdAt;
/// Create a copy of WatchlistItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WatchlistItemModelCopyWith<WatchlistItemModel> get copyWith => _$WatchlistItemModelCopyWithImpl<WatchlistItemModel>(this as WatchlistItemModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchlistItemModel&&(identical(other.stockCode, stockCode) || other.stockCode == stockCode)&&(identical(other.targetPrice, targetPrice) || other.targetPrice == targetPrice)&&(identical(other.alertType, alertType) || other.alertType == alertType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,stockCode,targetPrice,alertType,createdAt);

@override
String toString() {
  return 'WatchlistItemModel(stockCode: $stockCode, targetPrice: $targetPrice, alertType: $alertType, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $WatchlistItemModelCopyWith<$Res>  {
  factory $WatchlistItemModelCopyWith(WatchlistItemModel value, $Res Function(WatchlistItemModel) _then) = _$WatchlistItemModelCopyWithImpl;
@useResult
$Res call({
 String stockCode, int? targetPrice, AlertType alertType, DateTime createdAt
});




}
/// @nodoc
class _$WatchlistItemModelCopyWithImpl<$Res>
    implements $WatchlistItemModelCopyWith<$Res> {
  _$WatchlistItemModelCopyWithImpl(this._self, this._then);

  final WatchlistItemModel _self;
  final $Res Function(WatchlistItemModel) _then;

/// Create a copy of WatchlistItemModel
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


/// Adds pattern-matching-related methods to [WatchlistItemModel].
extension WatchlistItemModelPatterns on WatchlistItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WatchlistItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WatchlistItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WatchlistItemModel value)  $default,){
final _that = this;
switch (_that) {
case _WatchlistItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WatchlistItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _WatchlistItemModel() when $default != null:
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
case _WatchlistItemModel() when $default != null:
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
case _WatchlistItemModel():
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
case _WatchlistItemModel() when $default != null:
return $default(_that.stockCode,_that.targetPrice,_that.alertType,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _WatchlistItemModel implements WatchlistItemModel {
  const _WatchlistItemModel({this.stockCode = '', this.targetPrice, this.alertType = AlertType.both, this.createdAt = const ConstDateTime(0)});
  

@override@JsonKey() final  String stockCode;
@override final  int? targetPrice;
@override@JsonKey() final  AlertType alertType;
@override@JsonKey() final  DateTime createdAt;

/// Create a copy of WatchlistItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchlistItemModelCopyWith<_WatchlistItemModel> get copyWith => __$WatchlistItemModelCopyWithImpl<_WatchlistItemModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchlistItemModel&&(identical(other.stockCode, stockCode) || other.stockCode == stockCode)&&(identical(other.targetPrice, targetPrice) || other.targetPrice == targetPrice)&&(identical(other.alertType, alertType) || other.alertType == alertType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,stockCode,targetPrice,alertType,createdAt);

@override
String toString() {
  return 'WatchlistItemModel(stockCode: $stockCode, targetPrice: $targetPrice, alertType: $alertType, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$WatchlistItemModelCopyWith<$Res> implements $WatchlistItemModelCopyWith<$Res> {
  factory _$WatchlistItemModelCopyWith(_WatchlistItemModel value, $Res Function(_WatchlistItemModel) _then) = __$WatchlistItemModelCopyWithImpl;
@override @useResult
$Res call({
 String stockCode, int? targetPrice, AlertType alertType, DateTime createdAt
});




}
/// @nodoc
class __$WatchlistItemModelCopyWithImpl<$Res>
    implements _$WatchlistItemModelCopyWith<$Res> {
  __$WatchlistItemModelCopyWithImpl(this._self, this._then);

  final _WatchlistItemModel _self;
  final $Res Function(_WatchlistItemModel) _then;

/// Create a copy of WatchlistItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stockCode = null,Object? targetPrice = freezed,Object? alertType = null,Object? createdAt = null,}) {
  return _then(_WatchlistItemModel(
stockCode: null == stockCode ? _self.stockCode : stockCode // ignore: cast_nullable_to_non_nullable
as String,targetPrice: freezed == targetPrice ? _self.targetPrice : targetPrice // ignore: cast_nullable_to_non_nullable
as int?,alertType: null == alertType ? _self.alertType : alertType // ignore: cast_nullable_to_non_nullable
as AlertType,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
