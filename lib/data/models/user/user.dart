import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImg,
    required this.projectsKey,
    required this.tagsKey,
    required this.historiesKey,
    required this.clientsKey,
    required this.kiosksKey,
    required this.notificationSettingKey,
    required this.notificationsKey,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String email;

  @HiveField(3)
  String? profileImg;

  @HiveField(4)
  List<String> tagsKey;

  @HiveField(5)
  List<String> projectsKey;

  @HiveField(6)
  List<String> historiesKey;

  @HiveField(7)
  List<String> clientsKey;

  @HiveField(8)
  List<String> kiosksKey;

  @HiveField(9)
  List<String> notificationSettingKey;

  @HiveField(10)
  List<String> notificationsKey;

  // Factory constructor to create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profileImg: json['profileImg'] as String?,
      tagsKey: List<String>.from(json['tagsKey'] as List),
      projectsKey: List<String>.from(json['projectsKey'] as List),
      historiesKey: List<String>.from(json['historiesKey'] as List),
      clientsKey: List<String>.from(json['clientsKey'] as List),
      kiosksKey: List<String>.from(json['kiosksKey'] as List),
      notificationSettingKey:
          List<String>.from(json['notificationSettingKey'] as List),
      notificationsKey: List<String>.from(json['notificationsKey'] as List),
    );
  }

  // Method to convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImg': profileImg,
      'tagsKey': tagsKey,
      'projectsKey': projectsKey,
      'historiesKey': historiesKey,
      'clientsKey': clientsKey,
      'kiosksKey': kiosksKey,
      'notificationSettingKey': notificationSettingKey,
      'notificationsKey': notificationsKey,
    };
  }

  // Factory constructor to create a new User with default values
  factory User.create({
    required String name,
    required String? email,
    required String? profileImg,
    required List<String>? tagsKey,
    required List<String>? projectsKey,
    required List<String>? historiesKey,
    required List<String>? clientsKey,
    required List<String>? kiosksKey,
    required List<String>? notificationSettingKey,
    required List<String>? notificationsKey,
  }) {
    return User(
      id: const Uuid().v1(),
      name: name,
      email: email ?? "",
      profileImg: profileImg ?? "",
      tagsKey: tagsKey ?? <String>[],
      projectsKey: projectsKey ?? <String>[],
      historiesKey: historiesKey ?? <String>[],
      clientsKey: clientsKey ?? <String>[],
      kiosksKey: kiosksKey ?? <String>[],
      notificationSettingKey: notificationSettingKey ?? <String>[],
      notificationsKey: notificationsKey ?? <String>[],
    );
  }
}
