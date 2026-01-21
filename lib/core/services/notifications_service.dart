import 'dart:async';
import 'dart:developer';

import 'package:diary/core/routes/router.dart';
import 'package:diary/data/models/order_model.dart';
import 'package:diary/data/models/reminder_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../widgets/accept_or_refuse_order_bottomsheet.dart';

class LocalNotificationService {
  LocalNotificationService._internal();

  factory LocalNotificationService() {
    return _notificationService;
  }
  //Singleton pattern
  static final LocalNotificationService _notificationService = LocalNotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const channelId = '123';
  static const channelName = 'FlutterParse';
  static const channelDescription = 'FlutterParseNotification';
  final StreamController<Map<String, dynamic>> controllerPayload = StreamController<Map<String, dynamic>>();
  Stream<Map<String, dynamic>> get streamPayload => controllerPayload.stream;

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/quick_notification');

    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    try {
      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
        onDidReceiveBackgroundNotificationResponse: onDidReceiveNotificationResponse,
      );
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
    }
  }

  final AndroidNotificationDetails _androidNotificationDetails = const AndroidNotificationDetails(
    channelId,
    channelName,
    channelDescription: channelDescription,
    //playSound: true,
    priority: Priority.high,
    importance: Importance.high,
    icon: '@mipmap/ic_launcher',
    largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
  );

  Future<void> showNotifications({
    required int code,
    required String title,
    required String body,
    String? payload,
  }) async {
    await flutterLocalNotificationsPlugin
        .show(code, title, body, NotificationDetails(android: _androidNotificationDetails), payload: payload);
  }

  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    log("🔔 Notification Clicked!");
    if (notificationResponse.actionId == 'YES_ACTION') {
      log("YESSSS");
    }
    if (notificationResponse.actionId == 'NO_ACTION') {
      log("Noo");
    }
    if (notificationResponse.payload != null && notificationResponse.payload!.isNotEmpty) {
      try {
        // Decode JSON payload

        // Log the entire payload

        // Accessing specific fields (ensure they exist before using)
        if (notificationResponse.payload!.contains("estimatedDeliveryTime")) {
          //   log("Order Data: ${payload['order'][0]["id"]}");

          // Convert order back to your model
          final order = orderFromJsonString(notificationResponse.payload!);

          AcceptOrRefuseOrderBottomSheet()(navKey.currentContext, order);
        }
      } catch (e) {
        log("Error parsing notification payload: $e");
      }
    } else {
      log("❌ Notification payload is null or empty!");
    }
  }

  void handleNotificationPayloadWhenAppIsTerminated(String payload) {
    log("🔔 App Launched from Notification!");

    // Convert payload JSON to your model
    final order = orderFromJsonString(payload);

    // Ensure app is fully built before navigating
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AcceptOrRefuseOrderBottomSheet()(navKey.currentContext!, order);
    });
  }

  initWhenAppIsTerminated() async {
    await init();

    // Check if the app was launched from a notification
    final details = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    log("DETAILS WHEN APP IS TERM${details!.didNotificationLaunchApp}");
    if (details.didNotificationLaunchApp ?? false) {
      // The app was launched from a notification
      final String? payload = details.notificationResponse?.payload;
      if (payload != null && payload.isNotEmpty) {
        handleNotificationPayloadWhenAppIsTerminated(payload); // Handle it when app starts
      }
    }
  }

  Future<void> cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> scheduleDailyNotification(TimeOfDay time, ReminderModel reminder) async {
    final now = tz.TZDateTime.now(tz.local);
    log("Current Local Time: ${DateTime.now()}");
    // Schedule notification for the next occurrence of the given time
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    log("Scheduled for: ${scheduledDate.toIso8601String()}");

    const androidDetails = AndroidNotificationDetails(
      'daily_notification_channel',
      'Daily Reminders',
      importance: Importance.high,
      priority: Priority.high,
      fullScreenIntent: true,
      playSound: true,
      actions: [
        AndroidNotificationAction('YES_ACTION', 'Yes', showsUserInterface: true),
        AndroidNotificationAction('NO_ACTION', 'No'),
      ],
    );

    const platformDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      time.hashCode,
      'Medicine Reminder',
      'It\'s time to take your medicine!',
      scheduledDate,
      platformDetails,
      payload: reminderModelToJson(reminder),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, // Repeat daily
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }

  /// Cancel a notification
  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  void close() {
    controllerPayload.close();
  }
}
