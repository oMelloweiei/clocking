import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'project_setting.g.dart';

@HiveType(typeId: 13)
class ProjectSetting extends HiveObject {
  ProjectSetting({
    required this.id,
    required this.clientKey,
    required this.color,
    required this.onBillable,
    required this.billablerate,
    required this.estimate,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String clientKey;

  @HiveField(2)
  Color color;

  @HiveField(3)
  bool onBillable;

  @HiveField(4)
  double billablerate;

  @HiveField(5)
  String estimate;

  // Factory constructor to create a ProjectSetting from JSON
  factory ProjectSetting.fromJson(Map<String, dynamic> json) {
    return ProjectSetting(
      id: json['id'] as String,
      clientKey: json['clientKey'] as String,
      color: json['color'] as Color,
      onBillable: json['onBillable'] as bool,
      billablerate: json['billablerate'] as double,
      estimate: json['estimate'] as String,
    );
  }

  // Method to convert ProjectSetting to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientKey': clientKey,
      'color': color,
      'onBillable': onBillable,
      'billablerate': billablerate,
      'estimate': estimate
    };
  }

  // Factory constructor to create a new ProjectSetting with default values
  factory ProjectSetting.create(
      {required String id,
      required String? clientKey,
      required Color? color,
      required bool? onBillable,
      required double? billablerate,
      required String? estimate}) {
    return ProjectSetting(
        id: id,
        clientKey: clientKey ?? "-",
        color: color ?? Colors.white,
        onBillable: onBillable ?? false,
        billablerate: billablerate ?? 0.0,
        estimate: estimate ?? "");
  }
}
