import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'project.g.dart';

@HiveType(typeId: 1)
class Project extends HiveObject {
  Project({
    required this.id,
    required this.name,
    required this.clientKey,
    required this.trackedKey,
    required this.access,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String clientKey;

  @HiveField(3)
  String trackedKey;

  @HiveField(4)
  String access;

  // Factory constructor to create a Project from JSON
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as String,
      name: json['name'] as String,
      clientKey: json['clientKey'] as String,
      trackedKey: json['trackedKey'] as String,
      access: json['access'] as String,
    );
  }

  // Method to convert Project to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'clientKey': clientKey,
      'trackedKey': trackedKey,
      'access': access,
    };
  }

  // Factory constructor to create a new Project with default values
  factory Project.create({
    required String name,
    required String clientKey,
    required String trackedKey,
    required String access,
  }) {
    return Project(
      id: const Uuid().v1(),
      name: name,
      clientKey: clientKey,
      trackedKey: trackedKey,
      access: access.isNotEmpty ? access : 'public',
    );
  }
}
