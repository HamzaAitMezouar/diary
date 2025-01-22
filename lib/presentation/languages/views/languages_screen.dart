import 'dart:developer';

import 'package:diary/core/constants/app_colors.dart';
import 'package:diary/core/constants/assets.dart';
import 'package:diary/core/exports.dart';
import 'package:diary/core/extensions/conntext_extension.dart';
import 'package:diary/presentation/languages/languages_provider/localization_provider.dart';
import 'package:diary/widgets/custom_listile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/language.dart';
import '../../../widgets/custom_long_button.dart';

class LanguagesScreen extends ConsumerWidget {
  const LanguagesScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    List<Language> languages = [
      Language(code: "ar"),
      Language(code: "fr"),
      Language(code: "en"),
    ];
    final localeNotifier = ref.watch(localizationProvider.notifier);
    final locale = ref.watch(localizationProvider);
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            CustomListileWidget(
              backgroundColor: locale.locale.languageCode == languages[0].code ? AppColors.beQuick : null,
              hasTrailing: false,
              hasUnderline: false,
              radius: Borders.b20,
              onTap: () {
                localeNotifier.changeLanguage(languages[0].code);
              },
              icon: Image.asset(Assets.ar),
              label: context.translate.ar,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomListileWidget(
              backgroundColor: locale.locale.languageCode == languages[1].code ? AppColors.beQuick : null,
              hasTrailing: false,
              hasUnderline: false,
              radius: Borders.b20,
              onTap: () {
                localeNotifier.changeLanguage(languages[1].code);
              },
              icon: Image.asset(Assets.fr),
              label: context.translate.fr,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomListileWidget(
              backgroundColor: locale.locale.languageCode == languages[2].code ? AppColors.beQuick : null,
              hasTrailing: false,
              hasUnderline: false,
              radius: Borders.b20,
              onTap: () {
                localeNotifier.changeLanguage(languages[2].code);
              },
              icon: Image.asset(Assets.en),
              label: context.translate.en,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: context.width,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                CustomButton(
                  border: Borders.b20,
                  backgorundColor: AppColors.beQuick,
                  height: 50,
                  onTap: () {},
                  title: 'Continue',
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
