import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/errors/errors.dart';
import '../../entities/reminder_entity.dart';
import '../../repositories/notifications_repository/notifications_repository.dart';

class ScheduleNotificationUseCase {
  final NotificationRepository repository;

  ScheduleNotificationUseCase(this.repository);

  Future<Either<Failure, bool>> call(TimeOfDay time, DateTime reminderTime, ReminderEntity reminderEntity) {
    return repository.scheduleNotification(time, reminderTime, reminderEntity);
  }
}
// 