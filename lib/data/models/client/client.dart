import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'client.g.dart';

@HiveType(typeId: 5)
class Client extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String address;

  @HiveField(3)
  final String currency;

  @HiveField(4)
  final String note;

  Client({
    required this.id,
    required this.name,
    required this.address,
    required this.currency,
    required this.note,
  });

  // Factory constructor to create a Client from JSON
  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      currency: json['currency'] as String,
      note: json['note'] as String,
    );
  }

  // Method to convert Client to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'currency': currency,
      'note': note,
    };
  }

  // Factory constructor to create a new Client with default values
  factory Client.create({
    required String? name,
    required String? address,
    required String? currency,
    required String? note,
  }) {
    return Client(
      id: const Uuid().v1(),
      name: name ?? '',
      address: address ?? '',
      currency: currency ?? 'USD',
      note: currency ?? '',
    );
  }
}
