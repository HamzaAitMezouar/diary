import 'package:diary/domain/usecases/notification_usecases/cancel_notification_usecase.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/notifications_service.dart';
import '../../../../domain/repositories/notifications_repository/notifications_repository.dart';
import '../../../../domain/usecases/notification_usecases/schedule_reminder_usecase.dart';

final flutterLocalNotificationsPluginProvider = Provider<FlutterLocalNotificationsPlugin>((ref) {
  final plugin = FlutterLocalNotificationsPlugin();

  // Initialize the plugin
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

  plugin.initialize(initializationSettings);

  return plugin;
});

// Service Provider
final notificationServiceProvider = Provider<LocalNotificationService>((ref) {
  return LocalNotificationService();
});

// Repository Provider
final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  final service = ref.read(notificationServiceProvider);
  return NotificationRepositoryImpl(service);
});

// Use Case Provider
final scheduleNotificationUseCaseProvider = Provider<ScheduleNotificationUseCase>((ref) {
  final repository = ref.read(notificationRepositoryProvider);
  return ScheduleNotificationUseCase(repository);
});

final cancelNotificationUseCaseProvider = Provider<CancelNotificationUseCase>((ref) {
  final repository = ref.read(notificationRepositoryProvider);
  return CancelNotificationUseCase(repository);
});
