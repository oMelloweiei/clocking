import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'notifications.g.dart';

@HiveType(typeId: 8)
class NotificationList extends HiveObject {
  NotificationList({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.isRead,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String message;

  @HiveField(3)
  final DateTime timestamp;

  @HiveField(4)
  bool isRead;

  // Factory constructor to create a Notification from JSON
  factory NotificationList.fromJson(Map<String, dynamic> json) {
    return NotificationList(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isRead: json['isRead'] as bool,
    );
  }

  // Method to convert Notification to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
    };
  }

  // Factory constructor to create a new Notification with default values
  factory NotificationList.create({
    required String title,
    required String message,
    required DateTime timestamp,
    bool isRead = false,
  }) {
    return NotificationList(
      id: const Uuid().v1(),
      title: title,
      message: message,
      timestamp: timestamp,
      isRead: isRead,
    );
  }
}
