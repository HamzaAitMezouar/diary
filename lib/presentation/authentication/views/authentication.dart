import 'package:diary/core/exports.dart';
import 'package:diary/data/models/user_model.dart';
import 'package:diary/presentation/authentication/widgets/phone_number_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../core/routes/routes_names.dart';
import '../../../widgets/custom_long_button.dart';
import '../../otp_verification/controller/otp_coldown_provider.dart';
import '../controllers/auth_notifier.dart';
import '../controllers/auth_state.dart';
import '../controllers/phone_number_provider.dart';

class AuthenticationScreen extends ConsumerWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final authState = ref.watch(authNotifierProvider);
    PhoneNumber phoneNumber = ref.watch(phoneNumberProvider);
    String pattern = r'^(?:[+0]212)?[0-9]{9}$';
    RegExp regex = RegExp(pattern);
    ref.listen(authNotifierProvider, (previous, next) {
      if (next is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              behavior: SnackBarBehavior.floating, // Makes it float
              margin: const EdgeInsets.all(16), // Adjusts position
              shape: RoundedRectangleBorder(
                borderRadius: Borders.b12, // Rounded corners
              ),
              content: Text(next.message)),
        );
      }
      if (next is SendOtpSuccess) {
        ref.read(otpCooldownProvider.notifier).startCooldown();
        context.goNamed(RoutesNames.otpPage);
      }
    });
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            xxlSpacer(),
            Padding(
              padding: Paddings.horizontalXs,
              child: Text(
                "Welcome back! Let’s get you started.",
                textAlign: TextAlign.center,
                style: TextStyles.montserrat40,
              ),
            ),
            Padding(
              padding: Paddings.horizontalXs,
              child: Text(
                textAlign: TextAlign.center,
                "Create an account to enjoy the full experience.",
                style: TextStyles.montserrat18.copyWith(fontSize: 15),
              ),
            ),
            xlSpacer(),
            const PhoneNumberTextField(),
            xxsSpacer(),
            CustomButton(
              isDisabled: phoneNumber.phoneNumber == null || !regex.hasMatch(phoneNumber.phoneNumber!),
              border: Borders.b20,
              icon: const SizedBox(height: D.md, child: Icon(CupertinoIcons.phone)),
              height: D.xxl,
              isLoading: authState is PhoneAuthLoading,
              onTap: () {
                if (phoneNumber.phoneNumber == null || !regex.hasMatch(phoneNumber.phoneNumber!)) return;
                FocusManager.instance.primaryFocus?.unfocus();
                ref.read(authNotifierProvider.notifier).requestOtp(phoneNumber.phoneNumber!);
              },
              backgorundColor: AppColors.turquoise.withOpacity(0.7),
              style: TextStyles.montserrat13,
              title: 'Continue with Phone Number',
            ),
            xmdSpacer(),
            CustomButton(
              border: Borders.b20,
              icon: SizedBox(height: D.md, child: Image.asset(Assets.google)),
              height: D.xxl,
              isLoading: authState is SocialMediaLoading && authState.provider == SocialMediaProvider.google,
              onTap: () {
                ref.read(authNotifierProvider.notifier).socialMediaLogin(SocialMediaProvider.google);
              },
              style: TextStyles.montserrat13,
              title: 'Continue with Google',
            ),
            xsSpacer(),
            CustomButton(
              border: Borders.b20,
              icon: SizedBox(height: D.md, child: Image.asset(Assets.facebook)),
              height: D.xxl,
              isLoading: authState is SocialMediaLoading && authState.provider == SocialMediaProvider.facebook,
              onTap: () {
                ref.read(authNotifierProvider.notifier).socialMediaLogin(SocialMediaProvider.facebook);
              },
              style: TextStyles.montserrat13,
              title: 'Continue with Facebook',
            ),
            xsSpacer(),
          ],
        ),
      ),
    );
  }
}
