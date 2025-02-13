import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

/// State Model
class MedicineReminderState {
  final int intakeCount;
  final List<TimeOfDay> intakeTimes;
  final String medicineName;
  final String? note;

  MedicineReminderState({
    required this.intakeCount,
    required this.intakeTimes,
    required this.medicineName,
    this.note,
  });

  MedicineReminderState copyWith({
    int? intakeCount,
    List<TimeOfDay>? intakeTimes,
    String? medicineName,
    String? note,
  }) {
    return MedicineReminderState(
        intakeCount: intakeCount ?? this.intakeCount,
        intakeTimes: intakeTimes ?? this.intakeTimes,
        medicineName: medicineName ?? this.medicineName,
        note: note ?? this.note);
  }
}
