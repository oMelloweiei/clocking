import 'package:hive/hive.dart';

part 'project_property.g.dart';

@HiveType(typeId: 10)
class ProjectProperty extends HiveObject {
  ProjectProperty({
    required this.id,
    required this.accessKeys,
    required this.taskKeys,
    required this.noteKeys,
    required this.onVisible,
    required this.projectsettingKey,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  List<String> taskKeys;

  @HiveField(2)
  List<String> accessKeys;

  @HiveField(3)
  List<String> noteKeys;

  @HiveField(4)
  bool onVisible;

  @HiveField(5)
  String projectsettingKey;

  // Factory constructor to create a ProjectProperty from JSON
  factory ProjectProperty.fromJson(Map<String, dynamic> json) {
    return ProjectProperty(
      id: json['id'] as String,
      taskKeys: List<String>.from(json['taskKeys'] as List),
      accessKeys: List<String>.from(json['accessKeys'] as List),
      noteKeys: List<String>.from(json['noteKeys'] as List),
      onVisible: json['onVisible'] as bool,
      projectsettingKey: json['projectsettingKey'] as String,
    );
  }

  // Method to convert ProjectProperty to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taskKeys': taskKeys,
      'accessKeys': accessKeys,
      'noteKeys': noteKeys,
      'onVisible': onVisible,
      'projectsettingKey': projectsettingKey,
    };
  }

  // Factory constructor to create a new ProjectProperty with default values
  factory ProjectProperty.create({
    required String id,
    required List<String>? taskKeys,
    required List<String>? accessKeys,
    required List<String>? noteKeys,
    required bool? onVisible,
    required String? projectsettingKey,
  }) {
    return ProjectProperty(
      id: id,
      taskKeys: taskKeys ?? [],
      accessKeys: accessKeys ?? [],
      noteKeys: noteKeys ?? [],
      onVisible: onVisible ?? false,
      projectsettingKey: projectsettingKey ?? '',
    );
  }
}
