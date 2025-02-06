import 'package:diary/core/helpers/shared_prefrences_helper.dart';

import '../constants/string.dart';

class LocalizationService {
  final SharedPreferencesHelper _preferencesHelper;

  LocalizationService(this._preferencesHelper);

  String translate(String key) {
    final translations = {
      'timeout_error': {
        'en': 'Connection timed out. Please try again.',
        'fr': 'La connexion a expiré. Veuillez réessayer.',
      },
      'network_error': {
        'en': 'No internet connection. Check your settings.',
        'fr': 'Aucune connexion Internet. Vérifiez vos paramètres.',
      },
      'cancelled_error': {
        'en': 'Request was cancelled by the user.',
        'fr': 'La demande a été annulée par l\'utilisateur.',
      },
      'unknown_error': {
        'en': 'An unexpected error occurred. Please try again later.',
        'fr': 'Une erreur inattendue s\'est produite. Veuillez réessayer plus tard.',
      },
    };

    return translations[key]?[_preferencesHelper.getString(AppStrings.kLocale) ?? "en"] ?? 'An error occurred';
  }
}
