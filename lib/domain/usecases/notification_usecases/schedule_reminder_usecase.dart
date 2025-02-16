import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/errors/errors.dart';
import '../../repositories/notifications_repository/notifications_repository.dart';

class ScheduleNotificationUseCase {
  final NotificationRepository repository;

  ScheduleNotificationUseCase(this.repository);

  Future<Either<Failure, bool>> call(TimeOfDay time, DateTime reminderTime) {
    return repository.scheduleNotification(time, reminderTime);
  }
}
// 