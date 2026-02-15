// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchlist_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WatchlistItemModelAdapter extends TypeAdapter<WatchlistItemModel> {
  @override
  final typeId = 0;

  @override
  WatchlistItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WatchlistItemModel(
      stockCode: fields[0] == null ? '' : fields[0] as String,
      targetPrice: (fields[1] as num?)?.toInt(),
      alertTypeName: fields[2] == null ? 'both' : fields[2] as String,
      createdAt: fields[3] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, WatchlistItemModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.stockCode)
      ..writeByte(1)
      ..write(obj.targetPrice)
      ..writeByte(2)
      ..write(obj.alertTypeName)
      ..writeByte(3)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WatchlistItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
