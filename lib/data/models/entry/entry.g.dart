// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KioskAdapter extends TypeAdapter<Kiosk> {
  @override
  final int typeId = 6;

  @override
  Kiosk read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Kiosk(
      id: fields[0] as String,
      name: fields[1] as String,
      assign: fields[2] as String,
      projectKey: fields[3] as String,
      url: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Kiosk obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.assign)
      ..writeByte(3)
      ..write(obj.projectKey)
      ..writeByte(4)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KioskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
