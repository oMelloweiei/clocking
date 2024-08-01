import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'tag.g.dart';

@HiveType(typeId: 3)
class Tag extends HiveObject {
  Tag({
    required this.id,
    required this.name,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  // Factory constructor to create a Tag from JSON
  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  // Method to convert Tag to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  // Factory constructor to create a new Tag with default values
  factory Tag.create({
    required String name,
  }) {
    return Tag(
      id: const Uuid().v1(),
      name: name,
    );
  }
}
