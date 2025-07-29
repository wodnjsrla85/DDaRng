// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StationAdapter extends TypeAdapter<Station> {
  @override
  final int typeId = 1;

  @override
  Station read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Station(
      st_name: fields[0] as String,
      st_adress: fields[1] as String,
      st_lat: fields[2] as double,
      st_long: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Station obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.st_name)
      ..writeByte(1)
      ..write(obj.st_adress)
      ..writeByte(2)
      ..write(obj.st_lat)
      ..writeByte(3)
      ..write(obj.st_long);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
