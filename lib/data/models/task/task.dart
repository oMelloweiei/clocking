import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@HiveType(typeId: 11)
class Task extends HiveObject {
  Task({
    required this.id,
    required this.name,
    required this.assign,
    required this.track,
    required this.amount,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String assign;

  @HiveField(3)
  int track;

  @HiveField(4)
  int amount;

  // Factory constructor to create a Task from JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      name: json['name'] as String,
      assign: json['assign'] as String,
      track: json['track'] as int,
      amount: json['amount'] as int,
    );
  }

  // Method to convert Task to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'assign': assign,
      'track': track,
      'amount': amount,
    };
  }

  // Factory constructor to create a new Task with default values
  factory Task.create({
    required String name,
    required String? assign,
    required int? track,
    required int? amount,
  }) {
    return Task(
      id: const Uuid().v1(),
      name: name,
      assign: assign ?? "",
      track: track ?? 0,
      amount: amount ?? 0,
    );
  }
}
