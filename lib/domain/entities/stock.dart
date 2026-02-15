import 'package:const_date_time/const_date_time.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock.freezed.dart';

@freezed
abstract class Stock with _$Stock {
  const factory Stock({
    @Default('') String code,
    @Default('') String name,
    @Default(0) int currentPrice,
    @Default(0.0) double changeRate,
    @Default(ConstDateTime(0)) DateTime updatedAt,
  }) = _Stock;
}
