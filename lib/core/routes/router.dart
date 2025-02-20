import 'package:diary/core/routes/routes_names.dart';
import 'package:diary/presentation/checkout/views/checkout_page.dart';
import 'package:diary/presentation/checkout/widgets/choose_lcation_from_map.dart';
import 'package:diary/presentation/home/views/add_reminder.dart';
import 'package:diary/presentation/order_medicine/views/order_medicine_page.dart';
import 'package:diary/presentation/otp_verification/views/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/nav_bar/views/nav_bar.dart';
import '../DI/storage_provider.dart';

final GlobalKey<NavigatorState> _navKey = GlobalKey(debugLabel: "root");
//final GlobalKey<NavigatorState> _shelKey = GlobalKey(debugLabel: "shell");

class GoRouterProvider {
  static final GoRouter _router = GoRouter(
      navigatorKey: _navKey,
      initialLocation: "/",
      routes: [
        GoRoute(
            path: Routes.introPage,
            name: RoutesNames.introPage,
            builder: (context, state) {
              return Consumer(builder: (context, ref, child) {
                final sharedPreferencesAsync = ref.watch(sharedPreferencesHelperProvider);

                return const NavBarScreen();
              });
            },
            routes: [
              GoRoute(
                  path: Routes.otpPage,
                  name: RoutesNames.otpPage,
                  builder: (context, state) {
                    final String? navigateTo = state.pathParameters['navigateTo'];
                    return OtpScreen(
                      navigateTo: navigateTo,
                    );
                  }),
              GoRoute(
                  path: Routes.addReminderPage,
                  name: RoutesNames.addReminderPage,
                  builder: (context, state) {
                    return const AddReminderPage();
                  }),
              GoRoute(
                  path: Routes.orderMedicine,
                  name: RoutesNames.orderMedicine,
                  builder: (context, state) {
                    return const OrderMedicinePage();
                  },
                  routes: [
                    GoRoute(
                        path: Routes.checkoutPgae,
                        name: RoutesNames.checkoutPgae,
                        builder: (context, state) {
                          return const CheckoutPage();
                        },
                        routes: [
                          GoRoute(
                              path: Routes.mapSearchPage,
                              name: RoutesNames.mapSearchPage,
                              builder: (context, state) {
                                return MapLocationPicker();
                              }),
                        ]),
                  ]),
            ]),
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
