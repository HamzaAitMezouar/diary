import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../firebase_options.dart';
import 'notifications_service.dart';

class FirebaseMessagingServie {
  static Future<void> initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("Foreground message received: ${message.notification?.title}");

      LocalNotificationService().showNotifications(
        code: 1,
        title: message.notification?.title ?? "",
        body: message.notification?.body ?? "",
        payload: jsonEncode(message.data),
      );
    });

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      String orderId = message.data.toString();
      log("User tapped notification from background with orderId: $orderId");
      // Navigate to order details
    });
  }

  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();

    if (message.notification != null) {
      LocalNotificationService().showNotifications(
        code: message.hashCode,
        title: message.notification?.title ?? "",
        body: message.notification?.body ?? "",
        payload: jsonEncode(message.data),
      );
    }
  }
}
