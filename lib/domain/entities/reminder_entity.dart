import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/reminder_model.dart';

class ReminderEntity {
  final String? id;
  final String medicineName;
  final DateTime time;
  final List<TimeOfDay> dosage;
  final String? notes;
  final bool isCompleted;
  final String icon;
  final List<DateTime> consumationDates;
  ReminderEntity(
      {this.id,
      required this.medicineName,
      required this.time,
      required this.dosage,
      this.notes,
      this.isCompleted = false,
      required this.consumationDates,
      required this.icon});
  ReminderModel toModel() {
    return ReminderModel(
      id: id,
      medicineName: medicineName,
      time: time,
      dosage: convertTimeOfDayListToStringList(dosage),
      notes: notes,
      isCompleted: isCompleted,
      consumationDates: consumationDates,
      icon: icon,
    );
  }

  List<String> convertTimeOfDayListToStringList(List<TimeOfDay> times) {
    return times
        .map((time) => '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}')
        .toList();
  }
}
