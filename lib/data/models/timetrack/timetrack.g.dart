// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetrack.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimetrackAdapter extends TypeAdapter<Timetrack> {
  @override
  final int typeId = 4;

  @override
  Timetrack read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Timetrack(
      id: fields[0] as String,
      time: fields[1] == null ? '00:00:00' : fields[1] as String,
      projectKey: fields[2] as String,
      tagKey: fields[3] as String,
      timeStart: fields[4] == null ? '00:00' : fields[4] as String,
      timeEnd: fields[5] == null ? '00:00' : fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Timetrack obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.projectKey)
      ..writeByte(3)
      ..write(obj.tagKey)
      ..writeByte(4)
      ..write(obj.timeStart)
      ..writeByte(5)
      ..write(obj.timeEnd);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimetrackAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
