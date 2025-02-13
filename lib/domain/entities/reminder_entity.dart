import 'package:flutter/material.dart';

import '../../data/models/reminder_model.dart';

class ReminderEntity {
  final String id;
  final String medicineName;
  final DateTime time;
  final List<TimeOfDay> dosage;
  final String? notes;
  final bool isCompleted;

  ReminderEntity({
    required this.id,
    required this.medicineName,
    required this.time,
    required this.dosage,
    this.notes,
    this.isCompleted = false,
  });
  ReminderModel toModel() {
    return ReminderModel(
      id: id,
      medicineName: medicineName,
      time: time,
      dosage: dosage,
      notes: notes,
      isCompleted: isCompleted,
    );
  }
}
