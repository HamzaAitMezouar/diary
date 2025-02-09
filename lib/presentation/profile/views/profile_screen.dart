import 'dart:developer';

import 'package:diary/core/constants/dimensions.dart';
import 'package:diary/core/exports.dart';
import 'package:diary/core/routes/routes_names.dart';
import 'package:diary/data/models/user_model.dart';
import 'package:diary/presentation/authentication/controllers/auth_state.dart';
import 'package:diary/widgets/theme_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../widgets/custom_long_button.dart';
import '../../authentication/controllers/auth_notifier.dart';
import '../../authentication/controllers/phone_number_provider.dart';
import '../../authentication/views/authentication.dart';
import '../../authentication/widgets/phone_number_field.dart';
import '../../otp_verification/controller/otp_coldown_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final authState = ref.watch(authNotifierProvider);
    if (authState is AuthInitial) return CircularProgressIndicator();
    if (authState is Authenticated)
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
    return AuthenticationScreen();
  }
}
