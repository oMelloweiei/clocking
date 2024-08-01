import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'timetrack.g.dart';

@HiveType(typeId: 4)
class Timetrack extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1, defaultValue: '00:00:00')
  final String time;

  @HiveField(2)
  final String projectKey;

  @HiveField(3)
  final String tagKey;

  @HiveField(4, defaultValue: '00:00')
  final String timeStart;

  @HiveField(5, defaultValue: '00:00')
  final String timeEnd;

  Timetrack({
    required this.id,
    required this.time,
    required this.projectKey,
    required this.tagKey,
    required this.timeStart,
    required this.timeEnd,
  });

  // Factory constructor to create a Timetrack from JSON
  factory Timetrack.fromJson(Map<String, dynamic> json) {
    return Timetrack(
      id: json['id'] as String,
      time: json['time'] as String? ?? '00:00:00',
      projectKey: json['projectKey'] as String,
      tagKey: json['tagKey'] as String,
      timeStart: json['timeStart'] as String? ?? '00:00',
      timeEnd: json['timeEnd'] as String? ?? '00:00',
    );
  }

  // Method to convert Timetrack to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'time': time,
      'projectKey': projectKey,
      'tagKey': tagKey,
      'timeStart': timeStart,
      'timeEnd': timeEnd,
    };
  }

  // Factory constructor to create a new Timetrack with default values
  factory Timetrack.create({
    required String tagKey,
    required String projectKey,
    required String time,
    required String timeStart,
    required String timeEnd,
  }) {
    return Timetrack(
      id: const Uuid().v1(),
      tagKey: tagKey,
      projectKey: projectKey,
      time: time,
      timeStart: timeStart,
      timeEnd: timeEnd,
    );
  }
}
