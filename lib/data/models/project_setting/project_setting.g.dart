// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_setting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProjectSettingAdapter extends TypeAdapter<ProjectSetting> {
  @override
  final int typeId = 13;

  @override
  ProjectSetting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProjectSetting(
      id: fields[0] as String,
      clientKey: fields[1] as String,
      color: fields[2] as Color,
      onBillable: fields[3] as bool,
      billablerate: fields[4] as double,
      estimate: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProjectSetting obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.clientKey)
      ..writeByte(2)
      ..write(obj.color)
      ..writeByte(3)
      ..write(obj.onBillable)
      ..writeByte(4)
      ..write(obj.billablerate)
      ..writeByte(5)
      ..write(obj.estimate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectSettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
