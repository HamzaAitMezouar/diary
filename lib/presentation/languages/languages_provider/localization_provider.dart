import 'package:diary/core/DI/locator.dart';
import 'package:diary/core/constants/string.dart';
import 'package:diary/core/helpers/shared_prefrences_helper.dart';
import 'package:diary/presentation/languages/languages_provider/localization_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/DI/storage_provider.dart';

class LocalizationNotifier extends StateNotifier<LocalizationState> {
  final SharedPreferencesHelper _sharedPreferencesHelper;

  LocalizationNotifier(this._sharedPreferencesHelper) : super(LocalizationState(locale: const Locale("en"))) {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    String code = _sharedPreferencesHelper.getString(AppStrings.kLocale) ?? "en";

    state = state.copyWith(locale: Locale(code));
  }

  changeLanguage(String code) {
    state = state.copyWith(locale: Locale(code));
    _sharedPreferencesHelper.setString(AppStrings.kLocale, code);
  }
}

final localizationProvider = StateNotifierProvider<LocalizationNotifier, LocalizationState>(
    (ref) => LocalizationNotifier(locator<SharedPreferencesHelper>()));
