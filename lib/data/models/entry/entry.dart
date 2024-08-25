import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'entry.g.dart';

@HiveType(typeId: 6)
class Kiosk extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String assign;

  @HiveField(3)
  final String projectKey;

  @HiveField(4)
  final String url;

  Kiosk({
    required this.id,
    required this.name,
    required this.assign,
    required this.projectKey,
    required this.url,
  });

  // Factory constructor to create a Kiosk from JSON
  factory Kiosk.fromJson(Map<String, dynamic> json) {
    return Kiosk(
      id: json['id'] as String,
      name: json['name'] as String,
      assign: json['assign'] as String,
      projectKey: json['projectKey'] as String,
      url: json['url'] as String,
    );
  }

  // Method to convert Kiosk to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'assign': assign,
      'projectKey': projectKey,
      'url': url,
    };
  }

  // Factory constructor to create a new Kiosk with default values
  factory Kiosk.create({
    required String? name,
    required String? assign,
    required String? url,
    required String? projectKey,
  }) {
    return Kiosk(
      id: const Uuid().v1(),
      name: name ?? '',
      assign: assign ?? '',
      url: url ?? 'USD',
      projectKey: projectKey ?? '',
    );
  }
}
