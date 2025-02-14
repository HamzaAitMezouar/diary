import 'package:diary/core/DI/storage_provider.dart';
import 'package:diary/data/models/reminder_model.dart';
import 'package:diary/presentation/languages/languages_provider/localization_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/DI/router_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final sharedPreferences = await SharedPreferences.getInstance();
  await Hive.initFlutter();

  Hive.registerAdapter(ReminderModelAdapter());

  await Hive.openBox<ReminderModel>('remindersBox');
  runApp(ProviderScope(overrides: [
    sharedPreferencesProvider.overrideWithValue(sharedPreferences),
  ], child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final provider = ref.watch(localizationProvider);

    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: ref.watch(goRouterProviderProvider).router,
        title: 'Language Selector App',
        locale: provider.locale,
        supportedLocales: provider.supportedLocales,
        localizationsDelegates: provider.localizationsDelegates);
  }
}
