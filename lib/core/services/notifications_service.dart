import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin;
  NotificationService(this._notificationsPlugin);

  /// Initialize notifications
  Future<void> initNotifications() async {
    try {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const InitializationSettings initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid);

      await _notificationsPlugin.initialize(initializationSettings);

      // Request notification permissions
      await Permission.notification.request();
      log("INIT SUCCESS");
    } catch (e) {
      log(e.toString());
    }
  }

  /// Schedule a daily notification
  Future<void> scheduleDailyNotification(int id, int hour, int minute) async {
    await _notificationsPlugin.show(
      id,
      'Medicine Reminder',
      'It\'s time to take your medicine!',
      // _nextInstanceOfTime(hour, minute),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder', // Channel ID
          'Daily Reminder', // Channel Name
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      //  androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      //  uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      //  matchDateTimeComponents: DateTimeComponents.time, // Triggers daily
    );
  }

  /// Helper function to get the next scheduled time
  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(Duration(days: 1));
    }
    return scheduledDate;
  }

  /// Cancel a notification
  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }

  /// Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }
}
