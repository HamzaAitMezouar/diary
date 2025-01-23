import 'package:diary/presentation/authentication/controllers/auth_state.dart';
import 'package:diary/widgets/loading_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/custom_long_button.dart';
import '../../authentication/controllers/auth_notifier.dart';
import '../../authentication/views/authentication.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final authState = ref.watch(authNotifierProvider);
    if (authState is AuthInitial) return const SettingsLoading();
    if (authState is Authenticated) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
              isLoading: authState is LogoutLoadingLoading,
              onTap: () {
                ref.watch(authNotifierProvider.notifier).logout();
              },
              title: "Logout"),
          Center(child: Text(authState.user.email ?? "${authState.user.phone}")),
        ],
      );
    }
    return const AuthenticationScreen();
  }
}
