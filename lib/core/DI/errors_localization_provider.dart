import 'package:diary/core/DI/locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helpers/shared_prefrences_helper.dart';
import '../services/localization_service.dart';

final errosLocalizationServiceProvider = Provider<LocalizationService>((ref) {
  return LocalizationService(locator<SharedPreferencesHelper>());
});
