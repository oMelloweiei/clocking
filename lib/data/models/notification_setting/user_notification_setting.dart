import 'package:hive/hive.dart';

part 'user_notification_setting.g.dart';

@HiveType(typeId: 7)
class UserNotificationSetting extends HiveObject {
  UserNotificationSetting({
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

  // Factory constructor to create a UserNotificationSetting from JSON
  factory UserNotificationSetting.fromJson(Map<String, dynamic> json) {
    return UserNotificationSetting(
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

  // Method to convert UserNotificationSetting to JSON
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

  // Factory constructor to create a new UserNotificationSetting with default values
  factory UserNotificationSetting.create({
    required String id,
    required bool? newsletter,
    required bool? onboarding,
    required bool? weeklyReport,
    required bool? longRunningTimer,
    required bool? alerts,
    required bool? reminder,
    required bool? schedule,
  }) {
    return UserNotificationSetting(
      id: id,
      newsletter: newsletter ?? false,
      onboarding: onboarding ?? false,
      weeklyReport: weeklyReport ?? false,
      longRunningTimer: longRunningTimer ?? false,
      alerts: alerts ?? false,
      reminder: reminder ?? false,
      schedule: schedule ?? false,
    );
  }
}
