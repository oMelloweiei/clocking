// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_notification_setting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserNotificationSettingAdapter
    extends TypeAdapter<UserNotificationSetting> {
  @override
  final int typeId = 7;

  @override
  UserNotificationSetting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserNotificationSetting(
      id: fields[0] as String,
      newsletter: fields[1] as bool,
      onboarding: fields[2] as bool,
      weeklyReport: fields[3] as bool,
      longRunningTimer: fields[4] as bool,
      alerts: fields[5] as bool,
      reminder: fields[6] as bool,
      schedule: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserNotificationSetting obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.newsletter)
      ..writeByte(2)
      ..write(obj.onboarding)
      ..writeByte(3)
      ..write(obj.weeklyReport)
      ..writeByte(4)
      ..write(obj.longRunningTimer)
      ..writeByte(5)
      ..write(obj.alerts)
      ..writeByte(6)
      ..write(obj.reminder)
      ..writeByte(7)
      ..write(obj.schedule);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserNotificationSettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
