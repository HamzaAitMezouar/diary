import 'package:diary/core/routes/routes_names.dart';
import 'package:diary/widgets/custom_long_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pinput/pinput.dart';

import '../../../core/exports.dart';
import '../../authentication/controllers/auth_notifier.dart';
import '../../authentication/controllers/auth_state.dart';
import '../../authentication/controllers/phone_number_provider.dart';
import '../controller/otp_coldown_provider.dart';

class OtpScreen extends ConsumerWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final authState = ref.watch(authNotifierProvider);
    final cooldown = ref.watch(otpCooldownProvider);

    PhoneNumber phoneNumber = ref.watch(phoneNumberProvider);
    ref.listen(authNotifierProvider, (previous, next) {
      if (next is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: AppColors.error,
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
      }
      if (next is Authenticated) {
        context.replaceNamed(RoutesNames.introPage);
      }
    });
    return Scaffold(
      body: Column(
        children: [
          xxxxlSpacer(),
          Text("Enter your code", textAlign: TextAlign.center, style: TextStyles.montserrat40),
          xxlSpacer(),
          Pinput(
              length: 6,
              autofocus: true,
              defaultPinTheme: PinTheme(
                width: D.xxl,
                height: D.xxxl,
                textStyle: TextStyles.montserrat13,
                decoration: BoxDecoration(color: AppColors.tibbleGrauBg, borderRadius: Borders.b12),
              ),
              onCompleted: (String verificationCode) {
                FocusManager.instance.primaryFocus?.unfocus();
                ref.read(authNotifierProvider.notifier).verifyOtp(phoneNumber.phoneNumber!, verificationCode);
              }),
          Expanded(child: mdSpacer()),
          Padding(
            padding: Paddings.commonSpacing,
            child: CustomButton(
              isDisabled: cooldown != null,
              backgorundColor: AppColors.error,
              disableColor: AppColors.grauVollfarbe,
              title: 'Resend code ${cooldown ?? ""}',
              onTap: () {
                ref.read(authNotifierProvider.notifier).resendOtp(
                      phoneNumber.phoneNumber!,
                    );
              },
            ),
          ),
          mdSpacer(),
        ],
      ),
    );
  }
}
