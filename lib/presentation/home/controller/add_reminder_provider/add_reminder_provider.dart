import 'dart:io';

import 'package:diary/core/constants/assets.dart';
import 'package:diary/domain/entities/reminder_entity.dart';
import 'package:diary/domain/usecases/reminder_usecases/add_reminder.dart';
import 'package:diary/widgets/cupertino_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/DI/use_cases_provider.dart';
import 'add_reminder_state.dart';

/// StateNotifier to manage medicine reminders
class MedicineReminderNotifier extends StateNotifier<MedicineReminderState> {
  Ref ref;
  MedicineReminderNotifier(this.ref)
      : super(MedicineReminderState(
          icon: Assets.pill,
          intakeCount: 0,
          intakeTimes: [], medicineName: '', // Default time
        ));
  onChange(String value) {
    state = state.copyWith(medicineName: value);
  }

  onNoteChange(String value) {
    state = state.copyWith(note: value);
  }

  initalize() {
    state = MedicineReminderState(
      icon: Assets.pill,
      intakeCount: 0,
      intakeTimes: [], medicineName: '', // Default time
    );
  }

  /// Update the intake count & adjust times dynamically
  void setIntakeCount(int count) {
    List<TimeOfDay> newTimes = List.generate(
        count, (index) => index < state.intakeTimes.length ? state.intakeTimes[index] : TimeOfDay(hour: 8, minute: 0));

    state = state.copyWith(intakeCount: count, intakeTimes: newTimes);
  }

  changeIcon(String icon) {
    state = state.copyWith(icon: icon);
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

  addReminder() async {
    state = MedicineReminderLoading(
        intakeCount: state.intakeCount,
        intakeTimes: state.intakeTimes,
        medicineName: state.medicineName,
        icon: state.icon,
        note: state.note);
    final addReminderUseCase = ref.read(addReminderUseCaseProvider);
    final response = await addReminderUseCase(ReminderEntity(
      dosage: state.intakeTimes,
      medicineName: state.medicineName,
      notes: state.note,
      time: DateTime.now(),
      consumationDates: [],
      icon: state.icon,
    ));
    state = response.fold((l) {
      return MedicineReminderError(
          errorMessage: l.errorMessage,
          intakeCount: state.intakeCount,
          intakeTimes: state.intakeTimes,
          medicineName: state.medicineName,
          icon: state.icon,
          note: state.note);
    }, (r) {
      return MedicineReminderDone();
    });
  }

  alterReminder() {}
}

/// Provider instance
final medicineReminderProvider = StateNotifierProvider<MedicineReminderNotifier, MedicineReminderState>(
  (ref) => MedicineReminderNotifier(ref),
);
