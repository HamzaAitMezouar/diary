import 'package:diary/core/DI/storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/localization_service.dart';

final errosLocalizationServiceProvider = Provider<LocalizationService>((ref) {
  return LocalizationService(ref.watch(sharedPreferencesHelperProvider));
});
