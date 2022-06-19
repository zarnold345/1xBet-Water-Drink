// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'days_month.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MonthDataAdapter extends TypeAdapter<MonthData> {
  @override
  final int typeId = 8;

  @override
  MonthData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MonthData(
      data: (fields[0] as List?)?.cast<DayData>(),
    );
  }

  @override
  void write(BinaryWriter writer, MonthData obj) {
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
      other is MonthDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
