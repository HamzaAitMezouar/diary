import 'dart:developer';
import 'dart:io';

import 'package:diary/core/constants/assets.dart';
import 'package:diary/presentation/home/controller/notification_provider/reminder_notifications_provider.dart';
import 'package:diary/widgets/cupertino_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/DI/use_cases_provider.dart';
import '../../../../domain/entities/reminder_entity.dart';
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
      intakeTimes: [],
      medicineName: '',
    );
  }

  void setIntakeCount(int count) {
    List<TimeOfDay> newTimes = List.generate(count,
        (index) => index < state.intakeTimes.length ? state.intakeTimes[index] : const TimeOfDay(hour: 8, minute: 0));

    state = state.copyWith(intakeCount: count, intakeTimes: newTimes);
  }

  changeIcon(String icon) {
    state = state.copyWith(icon: icon);
  }

  /// Update a specific intake time
  void updateIntakeTime(int index, BuildContext context) async {
    if (!context.mounted) return;
    TimeOfDay? picked = Platform.isIOS
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
    DateTime now = DateTime.now();

    state = MedicineReminderLoading(
        intakeCount: state.intakeCount,
        intakeTimes: state.intakeTimes,
        medicineName: state.medicineName,
        icon: state.icon,
        note: state.note);
    final addReminderUseCase = ref.read(addReminderUseCaseProvider);
    final reminder = ReminderEntity(
      id: const Uuid().v4(),
      dosage: state.intakeTimes,
      medicineName: state.medicineName,
      notes: state.note,
      time: now,
      consumationDates: [],
      icon: state.icon,
    );
    final response = await addReminderUseCase(reminder);
    state = response.fold((l) {
      return MedicineReminderError(
          errorMessage: l.errorMessage,
          intakeCount: state.intakeCount,
          intakeTimes: state.intakeTimes,
          medicineName: state.medicineName,
          icon: state.icon,
          note: state.note);
    }, (r) {
      for (TimeOfDay timeOfDay in state.intakeTimes) {
        log(state.intakeTimes.length.toString() + timeOfDay.toString());
        ref.read(scheduleNotificationUseCaseProvider)(timeOfDay, now, reminder);
      }
      return MedicineReminderDone();
    });
  }

  alterReminder() {}
}

/// Provider instance
final medicineReminderProvider = StateNotifierProvider<MedicineReminderNotifier, MedicineReminderState>(
  (ref) => MedicineReminderNotifier(ref),
);
