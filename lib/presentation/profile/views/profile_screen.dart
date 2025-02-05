import 'dart:developer';

import 'package:diary/core/constants/dimensions.dart';
import 'package:diary/core/exports.dart';
import 'package:diary/widgets/theme_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../widgets/custom_long_button.dart';
import '../../authentication/controllers/phone_number_provider.dart';
import '../../authentication/views/authentication.dart';
import '../../authentication/widgets/phone_number_field.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    PhoneNumber phoneNumber = ref.watch(phoneNumberProvider);
    String pattern = r'^(?:[+0]212)?[0-9]{9}$';
    RegExp regex = RegExp(pattern);
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
            PhoneNumberTextField(),
            xxsSpacer(),
            CustomButton(
              border: Borders.b20,
              icon: SizedBox(height: D.md, child: Icon(CupertinoIcons.phone)),
              backgorundColor: phoneNumber.phoneNumber == null || !regex.hasMatch(phoneNumber.phoneNumber!)
                  ? AppColors.grauVollfarbe
                  : AppColors.error,
              height: D.xxl,
              onTap: () {},
              style: TextStyles.montserrat13,
              title: 'Continue with Phone Number',
            ),
            xmdSpacer(),
            CustomButton(
              border: Borders.b20,
              icon: SizedBox(height: D.md, child: Image.asset(Assets.google)),
              backgorundColor: AppColors.grauVollfarbe,
              height: D.xxl,
              onTap: () {},
              style: TextStyles.montserrat13,
              title: 'Continue with Google',
            ),
            xsSpacer(),
            CustomButton(
              border: Borders.b20,
              icon: SizedBox(height: D.md, child: Image.asset(Assets.facebook)),
              backgorundColor: AppColors.grauVollfarbe,
              height: D.xxl,
              onTap: () {},
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
