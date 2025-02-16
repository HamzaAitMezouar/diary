import 'package:diary/domain/entities/reminder_entity.dart';
import 'package:diary/domain/repositories/notifications_repository/notifications_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReminderNotifier extends StateNotifier<List<ReminderEntity>> {
  final NotificationRepository _notificationRepository;

  ReminderNotifier(this._notificationRepository) : super([]);

  void addReminder(ReminderEntity reminder) {
    for (TimeOfDay timeOfDay in reminder.dosage) {
      _notificationRepository.scheduleNotification(timeOfDay, reminder.time);
    }
    state = [...state, reminder];
  }

  void cancelReminders(ReminderEntity reminder) async {
    _notificationRepository.cancelNotification(reminder.time.millisecondsSinceEpoch);
  }
}
