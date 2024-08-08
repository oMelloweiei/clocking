import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'access.g.dart';

@HiveType(typeId: 12)
class Access extends HiveObject {
  Access({
    required this.id,
    required this.userKey,
    required this.billrate,
    required this.role,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String userKey;

  @HiveField(2)
  double billrate;

  @HiveField(3)
  String role;

  // Factory constructor to create a Access from JSON
  factory Access.fromJson(Map<String, dynamic> json) {
    return Access(
      id: json['id'] as String,
      userKey: json['userKey'] as String,
      billrate: json['billrate'] as double,
      role: json['role'] as String,
    );
  }

  // Method to convert Access to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userKey': userKey,
      'billrate': billrate,
      'role': role,
    };
  }

  // Factory constructor to create a new Access with default values
  factory Access.create(
      {required String userKey,
      required double? billrate,
      required String? role}) {
    return Access(
      id: const Uuid().v1(),
      userKey: userKey,
      billrate: billrate ?? 0.0,
      role: role ?? "",
    );
  }
}
