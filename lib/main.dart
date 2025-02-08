import 'package:diary/presentation/languages/languages_provider/localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/DI/router_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final provider = ref.watch(localizationProvider);

    return MaterialApp.router(
        routerConfig: ref.watch(goRouterProviderProvider).router,
        title: 'Language Selector App',
        locale: provider.locale,
        supportedLocales: provider.supportedLocales,
        localizationsDelegates: provider.localizationsDelegates);
  }
}
