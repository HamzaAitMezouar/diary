import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  SharedPreferences sharedPreferences;
  SharedPreferencesHelper(this.sharedPreferences);

  setString(String key, String value) async {
    await sharedPreferences.setString(key, value);
  }

  String? getString(
    String key,
  ) =>
      sharedPreferences.getString(key);
}
