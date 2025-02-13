import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add_reminder_state.dart';

/// StateNotifier to manage medicine reminders
class MedicineReminderNotifier extends StateNotifier<MedicineReminderState> {
  MedicineReminderNotifier()
      : super(MedicineReminderState(
          intakeCount: 1, // Default: 1 intake per day
          intakeTimes: [TimeOfDay(hour: 8, minute: 0)], medicineName: '', // Default time
        ));

  /// Update the intake count & adjust times dynamically
  void setIntakeCount(int count) {
    List<TimeOfDay> newTimes = List.generate(
        count, (index) => index < state.intakeTimes.length ? state.intakeTimes[index] : TimeOfDay(hour: 8, minute: 0));

    state = state.copyWith(intakeCount: count, intakeTimes: newTimes);
  }

  /// Update a specific intake time
  void updateIntakeTime(int index, TimeOfDay newTime) {
    List<TimeOfDay> updatedTimes = List.from(state.intakeTimes);
    updatedTimes[index] = newTime;
    state = state.copyWith(intakeTimes: updatedTimes);
  }
}

/// Provider instance
final medicineReminderProvider = StateNotifierProvider<MedicineReminderNotifier, MedicineReminderState>(
  (ref) => MedicineReminderNotifier(),
);
