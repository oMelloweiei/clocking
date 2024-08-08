import 'package:hive/hive.dart';

part 'general_setting.g.dart';

@HiveType(typeId: 9)
class UserGeneralSetting extends HiveObject {
  UserGeneralSetting({
    required this.id,
    required this.isDarkTheme,
    required this.language,
    required this.timeZone,
    required this.dateFormat,
    required this.weekStart,
    required this.timeFormat,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  bool isDarkTheme;

  @HiveField(2)
  String language;

  @HiveField(3)
  String timeZone;

  @HiveField(4)
  String dateFormat;

  @HiveField(5)
  String weekStart;

  @HiveField(6)
  String timeFormat;

  // Factory constructor to create a UserGeneralSetting from JSON
  factory UserGeneralSetting.fromJson(Map<String, dynamic> json) {
    return UserGeneralSetting(
      id: json['id'] as String,
      isDarkTheme: json['isDarkTheme'] as bool,
      language: json['language'] as String,
      timeZone: json['timeZone'] as String,
      dateFormat: json['dateFormat'] as String,
      weekStart: json['weekStart'] as String,
      timeFormat: json['timeFormat'] as String,
    );
  }

  // Method to convert UserGeneralSetting to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isDarkTheme': isDarkTheme,
      'language': language,
      'timeZone': timeZone,
      'dateFormat': dateFormat,
      'weekStart': weekStart,
      'timeFormat': timeFormat,
    };
  }

  // Factory constructor to create a new UserGeneralSetting with default values
  factory UserGeneralSetting.create({
    required String id,
    required bool? isDarkTheme,
    required String? language,
    required String? timeZone,
    required String? dateFormat,
    required String? weekStart,
    required String? timeFormat,
  }) {
    return UserGeneralSetting(
      id: id,
      isDarkTheme: isDarkTheme ?? false,
      language: language ?? "English",
      timeZone: timeZone ?? "(UTC +07:00) Asia/Bangkok",
      dateFormat: dateFormat ?? "dd MMMM yyyy",
      weekStart: weekStart ?? "Sunday",
      timeFormat: timeFormat ?? "hh:mm:ss a",
    );
  }
}
