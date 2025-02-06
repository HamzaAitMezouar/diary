import 'package:diary/core/helpers/shared_prefrences_helper.dart';
import 'package:diary/core/routes/router.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/localization_service.dart';
import 'dio_locator.dart';

final locator = GetIt.instance;
Future<void> setupLocator() async {
  locator.registerSingleton(GoRouterProvider());
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton(sharedPreferences);
  locator.registerSingleton(SharedPreferencesHelper(locator()));
  locator.registerLazySingleton(() => LocalizationService(locator()));
  locator.registerSingleton(DioLocator().createAuthDio(), instanceName: "AuthDio");
  locator.registerSingleton(DioLocator().createPublicDio(), instanceName: "PublicDio");
}
