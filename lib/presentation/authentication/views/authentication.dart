import 'package:diary/core/exports.dart';
import 'package:diary/presentation/authentication/widgets/phone_number_field.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.superDark,
        body: Column(
          children: [xlSpacer(), PhoneNumberTextField()],
        ),
      ),
    );
  }
}
