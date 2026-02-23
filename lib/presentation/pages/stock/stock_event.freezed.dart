// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StockEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StockEvent()';
}


}

/// @nodoc
class $StockEventCopyWith<$Res>  {
$StockEventCopyWith(StockEvent _, $Res Function(StockEvent) __);
}


/// Adds pattern-matching-related methods to [StockEvent].
extension StockEventPatterns on StockEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( StockInitialized value)?  initialized,TResult Function( StockFavoriteToggled value)?  favoriteToggled,TResult Function( StockWatchlistAdded value)?  watchlistAdded,TResult Function( StockTickReceived value)?  tickReceived,required TResult orElse(),}){
final _that = this;
switch (_that) {
case StockInitialized() when initialized != null:
return initialized(_that);case StockFavoriteToggled() when favoriteToggled != null:
return favoriteToggled(_that);case StockWatchlistAdded() when watchlistAdded != null:
return watchlistAdded(_that);case StockTickReceived() when tickReceived != null:
return tickReceived(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( StockInitialized value)  initialized,required TResult Function( StockFavoriteToggled value)  favoriteToggled,required TResult Function( StockWatchlistAdded value)  watchlistAdded,required TResult Function( StockTickReceived value)  tickReceived,}){
final _that = this;
switch (_that) {
case StockInitialized():
return initialized(_that);case StockFavoriteToggled():
return favoriteToggled(_that);case StockWatchlistAdded():
return watchlistAdded(_that);case StockTickReceived():
return tickReceived(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( StockInitialized value)?  initialized,TResult? Function( StockFavoriteToggled value)?  favoriteToggled,TResult? Function( StockWatchlistAdded value)?  watchlistAdded,TResult? Function( StockTickReceived value)?  tickReceived,}){
final _that = this;
switch (_that) {
case StockInitialized() when initialized != null:
return initialized(_that);case StockFavoriteToggled() when favoriteToggled != null:
return favoriteToggled(_that);case StockWatchlistAdded() when watchlistAdded != null:
return watchlistAdded(_that);case StockTickReceived() when tickReceived != null:
return tickReceived(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String stockCode)?  initialized,TResult Function( String stockCode)?  favoriteToggled,TResult Function( String stockCode,  int targetPrice,  AlertType alertType)?  watchlistAdded,TResult Function( Stock tick)?  tickReceived,required TResult orElse(),}) {final _that = this;
switch (_that) {
case StockInitialized() when initialized != null:
return initialized(_that.stockCode);case StockFavoriteToggled() when favoriteToggled != null:
return favoriteToggled(_that.stockCode);case StockWatchlistAdded() when watchlistAdded != null:
return watchlistAdded(_that.stockCode,_that.targetPrice,_that.alertType);case StockTickReceived() when tickReceived != null:
return tickReceived(_that.tick);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String stockCode)  initialized,required TResult Function( String stockCode)  favoriteToggled,required TResult Function( String stockCode,  int targetPrice,  AlertType alertType)  watchlistAdded,required TResult Function( Stock tick)  tickReceived,}) {final _that = this;
switch (_that) {
case StockInitialized():
return initialized(_that.stockCode);case StockFavoriteToggled():
return favoriteToggled(_that.stockCode);case StockWatchlistAdded():
return watchlistAdded(_that.stockCode,_that.targetPrice,_that.alertType);case StockTickReceived():
return tickReceived(_that.tick);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String stockCode)?  initialized,TResult? Function( String stockCode)?  favoriteToggled,TResult? Function( String stockCode,  int targetPrice,  AlertType alertType)?  watchlistAdded,TResult? Function( Stock tick)?  tickReceived,}) {final _that = this;
switch (_that) {
case StockInitialized() when initialized != null:
return initialized(_that.stockCode);case StockFavoriteToggled() when favoriteToggled != null:
return favoriteToggled(_that.stockCode);case StockWatchlistAdded() when watchlistAdded != null:
return watchlistAdded(_that.stockCode,_that.targetPrice,_that.alertType);case StockTickReceived() when tickReceived != null:
return tickReceived(_that.tick);case _:
  return null;

}
}

}

/// @nodoc


class StockInitialized implements StockEvent {
  const StockInitialized({required this.stockCode});
  

 final  String stockCode;

/// Create a copy of StockEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockInitializedCopyWith<StockInitialized> get copyWith => _$StockInitializedCopyWithImpl<StockInitialized>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockInitialized&&(identical(other.stockCode, stockCode) || other.stockCode == stockCode));
}


@override
int get hashCode => Object.hash(runtimeType,stockCode);

@override
String toString() {
  return 'StockEvent.initialized(stockCode: $stockCode)';
}


}

/// @nodoc
abstract mixin class $StockInitializedCopyWith<$Res> implements $StockEventCopyWith<$Res> {
  factory $StockInitializedCopyWith(StockInitialized value, $Res Function(StockInitialized) _then) = _$StockInitializedCopyWithImpl;
@useResult
$Res call({
 String stockCode
});




}
/// @nodoc
class _$StockInitializedCopyWithImpl<$Res>
    implements $StockInitializedCopyWith<$Res> {
  _$StockInitializedCopyWithImpl(this._self, this._then);

  final StockInitialized _self;
  final $Res Function(StockInitialized) _then;

/// Create a copy of StockEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? stockCode = null,}) {
  return _then(StockInitialized(
stockCode: null == stockCode ? _self.stockCode : stockCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class StockFavoriteToggled implements StockEvent {
  const StockFavoriteToggled({required this.stockCode});
  

 final  String stockCode;

/// Create a copy of StockEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockFavoriteToggledCopyWith<StockFavoriteToggled> get copyWith => _$StockFavoriteToggledCopyWithImpl<StockFavoriteToggled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockFavoriteToggled&&(identical(other.stockCode, stockCode) || other.stockCode == stockCode));
}


@override
int get hashCode => Object.hash(runtimeType,stockCode);

@override
String toString() {
  return 'StockEvent.favoriteToggled(stockCode: $stockCode)';
}


}

/// @nodoc
abstract mixin class $StockFavoriteToggledCopyWith<$Res> implements $StockEventCopyWith<$Res> {
  factory $StockFavoriteToggledCopyWith(StockFavoriteToggled value, $Res Function(StockFavoriteToggled) _then) = _$StockFavoriteToggledCopyWithImpl;
@useResult
$Res call({
 String stockCode
});




}
/// @nodoc
class _$StockFavoriteToggledCopyWithImpl<$Res>
    implements $StockFavoriteToggledCopyWith<$Res> {
  _$StockFavoriteToggledCopyWithImpl(this._self, this._then);

  final StockFavoriteToggled _self;
  final $Res Function(StockFavoriteToggled) _then;

/// Create a copy of StockEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? stockCode = null,}) {
  return _then(StockFavoriteToggled(
stockCode: null == stockCode ? _self.stockCode : stockCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class StockWatchlistAdded implements StockEvent {
  const StockWatchlistAdded({required this.stockCode, required this.targetPrice, required this.alertType});
  

 final  String stockCode;
 final  int targetPrice;
 final  AlertType alertType;

/// Create a copy of StockEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockWatchlistAddedCopyWith<StockWatchlistAdded> get copyWith => _$StockWatchlistAddedCopyWithImpl<StockWatchlistAdded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockWatchlistAdded&&(identical(other.stockCode, stockCode) || other.stockCode == stockCode)&&(identical(other.targetPrice, targetPrice) || other.targetPrice == targetPrice)&&(identical(other.alertType, alertType) || other.alertType == alertType));
}


@override
int get hashCode => Object.hash(runtimeType,stockCode,targetPrice,alertType);

@override
String toString() {
  return 'StockEvent.watchlistAdded(stockCode: $stockCode, targetPrice: $targetPrice, alertType: $alertType)';
}


}

/// @nodoc
abstract mixin class $StockWatchlistAddedCopyWith<$Res> implements $StockEventCopyWith<$Res> {
  factory $StockWatchlistAddedCopyWith(StockWatchlistAdded value, $Res Function(StockWatchlistAdded) _then) = _$StockWatchlistAddedCopyWithImpl;
@useResult
$Res call({
 String stockCode, int targetPrice, AlertType alertType
});




}
/// @nodoc
class _$StockWatchlistAddedCopyWithImpl<$Res>
    implements $StockWatchlistAddedCopyWith<$Res> {
  _$StockWatchlistAddedCopyWithImpl(this._self, this._then);

  final StockWatchlistAdded _self;
  final $Res Function(StockWatchlistAdded) _then;

/// Create a copy of StockEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? stockCode = null,Object? targetPrice = null,Object? alertType = null,}) {
  return _then(StockWatchlistAdded(
stockCode: null == stockCode ? _self.stockCode : stockCode // ignore: cast_nullable_to_non_nullable
as String,targetPrice: null == targetPrice ? _self.targetPrice : targetPrice // ignore: cast_nullable_to_non_nullable
as int,alertType: null == alertType ? _self.alertType : alertType // ignore: cast_nullable_to_non_nullable
as AlertType,
  ));
}


}

/// @nodoc


class StockTickReceived implements StockEvent {
  const StockTickReceived({required this.tick});
  

 final  Stock tick;

/// Create a copy of StockEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockTickReceivedCopyWith<StockTickReceived> get copyWith => _$StockTickReceivedCopyWithImpl<StockTickReceived>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockTickReceived&&(identical(other.tick, tick) || other.tick == tick));
}


@override
int get hashCode => Object.hash(runtimeType,tick);

@override
String toString() {
  return 'StockEvent.tickReceived(tick: $tick)';
}


}

/// @nodoc
abstract mixin class $StockTickReceivedCopyWith<$Res> implements $StockEventCopyWith<$Res> {
  factory $StockTickReceivedCopyWith(StockTickReceived value, $Res Function(StockTickReceived) _then) = _$StockTickReceivedCopyWithImpl;
@useResult
$Res call({
 Stock tick
});


$StockCopyWith<$Res> get tick;

}
/// @nodoc
class _$StockTickReceivedCopyWithImpl<$Res>
    implements $StockTickReceivedCopyWith<$Res> {
  _$StockTickReceivedCopyWithImpl(this._self, this._then);

  final StockTickReceived _self;
  final $Res Function(StockTickReceived) _then;

/// Create a copy of StockEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tick = null,}) {
  return _then(StockTickReceived(
tick: null == tick ? _self.tick : tick // ignore: cast_nullable_to_non_nullable
as Stock,
  ));
}

/// Create a copy of StockEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StockCopyWith<$Res> get tick {
  
  return $StockCopyWith<$Res>(_self.tick, (value) {
    return _then(_self.copyWith(tick: value));
  });
}
}

// dart format on
