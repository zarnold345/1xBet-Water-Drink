// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'year_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class YearDataAdapter extends TypeAdapter<YearData> {
  @override
  final int typeId = 88;

  @override
  YearData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return YearData(
      data: (fields[0] as List?)?.cast<MonthData>(),
    );
  }

  @override
  void write(BinaryWriter writer, YearData obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YearDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
