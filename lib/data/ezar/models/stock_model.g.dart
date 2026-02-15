// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StockModel _$StockModelFromJson(Map<String, dynamic> json) => _StockModel(
  code: json['stockCode'] as String? ?? '',
  name: json['name'] as String? ?? '',
  currentPrice: (json['currentPrice'] as num?)?.toInt() ?? 0,
  changeRate: (json['changeRate'] as num?)?.toDouble() ?? 0.0,
  updatedAt: json['timestamp'] == null
      ? const ConstDateTime(0)
      : DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$StockModelToJson(_StockModel instance) =>
    <String, dynamic>{
      'stockCode': instance.code,
      'name': instance.name,
      'currentPrice': instance.currentPrice,
      'changeRate': instance.changeRate,
      'timestamp': instance.updatedAt.toIso8601String(),
    };
