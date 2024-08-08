import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'note.g.dart';

@HiveType(typeId: 14)
class Note extends HiveObject {
  Note({
    required this.id,
    required this.detail,
    required this.userKey,
    required this.date,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String detail;

  @HiveField(2)
  String userKey;

  @HiveField(3)
  DateTime date;

  // Factory constructor to create a Note from JSON
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] as String,
      detail: json['detail'] as String,
      userKey: json['userKey'] as String,
      date: json['date'] as DateTime,
    );
  }

  // Method to convert Note to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'detail': detail,
      'userKey': userKey,
      'date': date,
    };
  }

  // Factory constructor to create a new Note with default values
  factory Note.create({
    required String detail,
    required String userKey,
    required DateTime date,
  }) {
    return Note(
      id: const Uuid().v1(),
      detail: detail,
      userKey: userKey,
      date: date,
    );
  }
}
