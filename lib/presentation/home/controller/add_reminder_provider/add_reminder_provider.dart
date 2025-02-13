import 'dart:io';

import 'package:diary/widgets/cupertino_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add_reminder_state.dart';

/// StateNotifier to manage medicine reminders
class MedicineReminderNotifier extends StateNotifier<MedicineReminderState> {
  MedicineReminderNotifier()
      : super(MedicineReminderState(
          intakeCount: 0,
          intakeTimes: [], medicineName: '', // Default time
        ));

  /// Update the intake count & adjust times dynamically
  void setIntakeCount(int count) {
    List<TimeOfDay> newTimes = List.generate(
        count, (index) => index < state.intakeTimes.length ? state.intakeTimes[index] : TimeOfDay(hour: 8, minute: 0));

    state = state.copyWith(intakeCount: count, intakeTimes: newTimes);
  }

  /// Update a specific intake time
  void updateIntakeTime(int index, BuildContext context) async {
    if (!context.mounted) return;
    TimeOfDay? picked = !Platform.isIOS
        ? await AppCupertinoTimePicker.showCupertinoTimePicker(context)
        : await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
    if (picked == null) return;
    List<TimeOfDay> updatedTimes = List.from(state.intakeTimes);
    updatedTimes[index] = picked;
    state = state.copyWith(intakeTimes: updatedTimes);
  }
}

/// Provider instance
final medicineReminderProvider = StateNotifierProvider<MedicineReminderNotifier, MedicineReminderState>(
  (ref) => MedicineReminderNotifier(),
);
