// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationListAdapter extends TypeAdapter<NotificationList> {
  @override
  final int typeId = 8;

  @override
  NotificationList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationList(
      id: fields[0] as String,
      title: fields[1] as String,
      message: fields[2] as String,
      timestamp: fields[3] as DateTime,
      isRead: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationList obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.message)
      ..writeByte(3)
      ..write(obj.timestamp)
      ..writeByte(4)
      ..write(obj.isRead);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
