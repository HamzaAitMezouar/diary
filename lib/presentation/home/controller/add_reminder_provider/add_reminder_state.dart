import 'package:diary/core/constants/assets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

/// State Model
class MedicineReminderState {
  final int intakeCount;
  final List<TimeOfDay> intakeTimes;
  final String medicineName;
  final String? note;
  final String icon;
  MedicineReminderState({
    required this.intakeCount,
    required this.intakeTimes,
    required this.medicineName,
    required this.icon,
    this.note,
  });

  MedicineReminderState copyWith(
      {int? intakeCount, List<TimeOfDay>? intakeTimes, String? medicineName, String? note, String? icon}) {
    return MedicineReminderState(
        intakeCount: intakeCount ?? this.intakeCount,
        intakeTimes: intakeTimes ?? this.intakeTimes,
        medicineName: medicineName ?? this.medicineName,
        note: note ?? this.note,
        icon: icon ?? this.icon);
  }
}

class MedicineReminderLoading extends MedicineReminderState {
  MedicineReminderLoading(
      {required super.intakeCount,
      required super.intakeTimes,
      required super.medicineName,
      super.note,
      required super.icon});
}

class MedicineReminderDone extends MedicineReminderState {
  MedicineReminderDone() : super(intakeCount: 0, intakeTimes: [], medicineName: '', note: null, icon: Assets.pill);
}

class MedicineReminderError extends MedicineReminderState {
  final String errorMessage;

  MedicineReminderError({
    required super.intakeCount,
    required super.intakeTimes,
    required super.medicineName,
    super.note,
    required this.errorMessage,
    required super.icon,
  });
}
