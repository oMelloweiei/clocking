// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_setting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserGeneralSettingAdapter extends TypeAdapter<UserGeneralSetting> {
  @override
  final int typeId = 9;

  @override
  UserGeneralSetting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserGeneralSetting(
      id: fields[0] as String,
      isDarkTheme: fields[1] as bool,
      language: fields[2] as String,
      timeZone: fields[3] as String,
      dateFormat: fields[4] as String,
      weekStart: fields[5] as String,
      timeFormat: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserGeneralSetting obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.isDarkTheme)
      ..writeByte(2)
      ..write(obj.language)
      ..writeByte(3)
      ..write(obj.timeZone)
      ..writeByte(4)
      ..write(obj.dateFormat)
      ..writeByte(5)
      ..write(obj.weekStart)
      ..writeByte(6)
      ..write(obj.timeFormat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserGeneralSettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
