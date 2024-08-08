// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_property.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProjectPropertyAdapter extends TypeAdapter<ProjectProperty> {
  @override
  final int typeId = 10;

  @override
  ProjectProperty read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProjectProperty(
      id: fields[0] as String,
      accessKeys: (fields[2] as List).cast<String>(),
      taskKeys: (fields[1] as List).cast<String>(),
      noteKeys: (fields[3] as List).cast<String>(),
      onVisible: fields[4] as bool,
      projectsettingKey: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProjectProperty obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.taskKeys)
      ..writeByte(2)
      ..write(obj.accessKeys)
      ..writeByte(3)
      ..write(obj.noteKeys)
      ..writeByte(4)
      ..write(obj.onVisible)
      ..writeByte(5)
      ..write(obj.projectsettingKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectPropertyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
