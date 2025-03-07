import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:diary/core/errors/errors.dart';
import 'package:diary/core/services/notifications_service.dart';
import 'package:diary/domain/entities/reminder_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

abstract class NotificationRepository {
  Future<Either<Failure, bool>> scheduleNotification(
      TimeOfDay time, DateTime reminderTime, ReminderEntity reminderEntity);
  Future<Either<Failure, bool>> cancelNotification(int notificationId);
  Future<Either<Failure, bool>> cancelAllNotifications();
}

class NotificationRepositoryImpl implements NotificationRepository {
  final LocalNotificationService _notificationSerive;

  NotificationRepositoryImpl(this._notificationSerive);

  @override
  Future<Either<Failure, bool>> scheduleNotification(
      TimeOfDay time, DateTime reminderTime, ReminderEntity reminderEntity) async {
    try {
      await _notificationSerive.scheduleDailyNotification(time, reminderEntity.toModel());
      log("DONE");
      return right(true);
    } catch (e) {
      log(e.toString());
      return Left(CostumeFailure(errorMessage: e.toString()));
    }
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  @override
  Future<Either<Failure, bool>> cancelNotification(int notificationId) async {
    try {
      await _notificationSerive.cancelNotification(notificationId);
      return right(true);
    } catch (e) {
      return Left(CostumeFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> cancelAllNotifications() async {
    try {
      await _notificationSerive.cancelAllNotifications();
      return right(true);
    } catch (e) {
      return Left(CostumeFailure(errorMessage: e.toString()));
    }
  }
}
