import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'user_notification_setting.g.dart';

@HiveType(typeId: 7)
class UserNotification extends HiveObject {
  UserNotification({
    required this.id,
    required this.newsletter,
    required this.onboarding,
    required this.weeklyReport,
    required this.longRunningTimer,
    required this.alerts,
    required this.reminder,
    required this.schedule,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  bool newsletter;

  @HiveField(2)
  bool onboarding;

  @HiveField(3)
  bool weeklyReport;

  @HiveField(4)
  bool longRunningTimer;

  @HiveField(5)
  bool alerts;

  @HiveField(6)
  bool reminder;

  @HiveField(7)
  bool schedule;

  // Factory constructor to create a UserNotification from JSON
  factory UserNotification.fromJson(Map<String, dynamic> json) {
    return UserNotification(
      id: json['id'] as String,
      newsletter: json['newsletter'] as bool,
      onboarding: json['onboarding'] as bool,
      weeklyReport: json['weekly_report'] as bool,
      longRunningTimer: json['long_running_timer'] as bool,
      alerts: json['alerts'] as bool,
      reminder: json['reminder'] as bool,
      schedule: json['schedule'] as bool,
    );
  }

  // Method to convert UserNotification to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'newsletter': newsletter,
      'onboarding': onboarding,
      'weekly_report': weeklyReport,
      'long_running_timer': longRunningTimer,
      'alerts': alerts,
      'reminder': reminder,
      'schedule': schedule,
    };
  }

  // Factory constructor to create a new UserNotification with default values
  factory UserNotification.create({
    required bool newsletter,
    required bool onboarding,
    required bool weeklyReport,
    required bool longRunningTimer,
    required bool alerts,
    required bool reminder,
    required bool schedule,
  }) {
    return UserNotification(
      id: const Uuid().v1(),
      newsletter: newsletter,
      onboarding: onboarding,
      weeklyReport: weeklyReport,
      longRunningTimer: longRunningTimer,
      alerts: alerts,
      reminder: reminder,
      schedule: schedule,
    );
  }
}
