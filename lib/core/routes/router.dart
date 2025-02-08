import 'package:diary/core/DI/locator.dart';
import 'package:diary/core/helpers/shared_prefrences_helper.dart';
import 'package:diary/core/routes/routes_names.dart';
import 'package:diary/presentation/languages/views/languages_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/home/views/home_screen.dart';
import '../DI/storage_provider.dart';
import '../exports.dart';

final GlobalKey<NavigatorState> _navKey = GlobalKey(debugLabel: "root");
//final GlobalKey<NavigatorState> _shelKey = GlobalKey(debugLabel: "shell");

class GoRouterProvider {
  static final GoRouter _router = GoRouter(
      navigatorKey: _navKey,
      initialLocation: "/",
      routes: [
        GoRoute(
          path: "/",
          name: RoutesNames.introPage,
          builder: (context, state) {
            return Consumer(builder: (context, ref, child) {
              final sharedPreferencesAsync = ref.watch(sharedPreferencesHelperProvider);
              return sharedPreferencesAsync.getString(AppStrings.kLocale) == null
                  ? const LanguagesScreen()
                  : const HomeScreen();
            });
          },
        ),
      ],
      errorBuilder: (context, e) {
        return Scaffold(
          body: Center(
            child: Text("Error${e.error!.message}"),
          ),
        );
      });

  GoRouter get router => _router;
}
