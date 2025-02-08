import 'package:diary/core/helpers/shared_prefrences_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;
Future<void> setupLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton(sharedPreferences);
  locator.registerSingleton(SharedPreferencesHelper(locator()));
}
