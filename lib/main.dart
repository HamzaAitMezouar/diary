import 'package:diary/core/DI/socket_provider.dart';
import 'package:diary/core/DI/storage_provider.dart';
import 'package:diary/core/services/firebase_messaging_service.dart';
import 'package:diary/core/services/notifications_service.dart';
import 'package:diary/core/theme/app_theme.dart';
import 'package:diary/data/models/cart_model.dart';
import 'package:diary/data/models/reminder_model.dart';
import 'package:diary/presentation/authentication/controllers/auth_notifier.dart';
import 'package:diary/presentation/languages/languages_provider/localization_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/DI/router_provider.dart';
import 'data/models/category_model.dart';
import 'data/models/medicament_model.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessagingServie.initFirebase();
  LocalNotificationService().initWhenAppIsTerminated();
  final sharedPreferences = await SharedPreferences.getInstance();
  await Hive.initFlutter();

  Hive.registerAdapter(ReminderModelAdapter());
  Hive.registerAdapter(CartModelAdapter());
  Hive.registerAdapter(CarItemModelAdapter());
  Hive.registerAdapter(MedicamentModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());

  await Hive.openBox<ReminderModel>('remindersBox');
  await Hive.openBox<CartModel>('cart');
  runApp(ProviderScope(overrides: [
    sharedPreferencesProvider.overrideWithValue(sharedPreferences),
  ], child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final provider = ref.watch(localizationProvider);
    ref.watch(authNotifierProvider);

    return MaterialApp.router(
      theme: AppThemes.getLightTheme(),
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(goRouterProviderProvider).router,
      title: 'Language Selector App',
      locale: provider.locale,
      supportedLocales: provider.supportedLocales,
    );
  }
}
