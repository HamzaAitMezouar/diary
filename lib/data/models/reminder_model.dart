import 'package:flutter/material.dart';

import '../../domain/entities/reminder_entity.dart';
import 'package:hive/hive.dart';

part 'reminder_model.g.dart';

@HiveType(typeId: 0, adapterName: 'ReminderAdapter')
class ReminderModel {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String medicineName;
  @HiveField(2)
  final DateTime time;
  @HiveField(3)
  final List<TimeOfDay> dosage;
  @HiveField(4)
  final String? notes;
  @HiveField(5)
  final bool isCompleted;

  ReminderModel({
    this.id,
    required this.medicineName,
    required this.time,
    required this.dosage,
    this.notes,
    this.isCompleted = false,
  });

  ReminderModel copyWith({bool? isCompleted}) {
    return ReminderModel(
      id: id,
      medicineName: medicineName,
      isCompleted: isCompleted ?? this.isCompleted,
      time: time,
      dosage: dosage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'medicineName': medicineName,
      'time': time.toIso8601String(),
      'dosage': dosage,
      'notes': notes,
      'isCompleted': isCompleted,
    };
  }

  // Convert Map to ReminderModel
  factory ReminderModel.fromJson(Map<String, dynamic> json) {
    return ReminderModel(
      id: json['id'],
      medicineName: json['medicineName'],
      time: DateTime.parse(json['time']),
      dosage: json['dosage'],
      notes: json['notes'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  // Convert Model to Entity
  ReminderEntity toEntity() {
    return ReminderEntity(
      id: id,
      medicineName: medicineName,
      time: time,
      dosage: dosage,
      notes: notes,
      isCompleted: isCompleted,
    );
  }
}
