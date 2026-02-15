import 'package:const_date_time/const_date_time.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_model.freezed.dart';
part 'stock_model.g.dart';

@freezed
abstract class StockModel with _$StockModel {
  const factory StockModel({
    @Default('') @JsonKey(name: 'stockCode') String code,
    @Default('') String name,
    @Default(0) int currentPrice,
    @Default(0.0) double changeRate,
    @Default(ConstDateTime(0)) @JsonKey(name: 'timestamp') DateTime updatedAt,
  }) = _StockModel;

  factory StockModel.fromJson(Map<String, dynamic> json) =>
      _$StockModelFromJson(json);
}
