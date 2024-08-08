// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccessAdapter extends TypeAdapter<Access> {
  @override
  final int typeId = 12;

  @override
  Access read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Access(
      id: fields[0] as String,
      userKey: fields[1] as String,
      billrate: fields[2] as double,
      role: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Access obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userKey)
      ..writeByte(2)
      ..write(obj.billrate)
      ..writeByte(3)
      ..write(obj.role);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccessAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
