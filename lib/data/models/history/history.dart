import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'history.g.dart';

@HiveType(typeId: 2)
class History extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String date;

  @HiveField(2)
  final String? detail;

  @HiveField(3)
  List<String> timetracksKey;

  History({
    required this.id,
    required this.date,
    this.detail,
    required this.timetracksKey,
  });

  // Factory constructor to create a History from JSON
  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      id: json['id'] as String,
      date: json['date'] as String,
      detail: json['detail'] as String?,
      timetracksKey: List<String>.from(json['timetracksKey'] as List),
    );
  }

  // Method to convert History to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'detail': detail,
      'timetracksKey': timetracksKey,
    };
  }

  // Factory constructor to create a new History with default values
  factory History.create({
    required String date,
    List<String>? timetracksKey,
  }) {
    return History(
      id: const Uuid().v1(),
      date: date,
      detail: null,
      timetracksKey: timetracksKey ?? [],
    );
  }
}
