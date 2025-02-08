import 'package:diary/core/helpers/secure_storage_helper.dart';
import 'package:diary/core/helpers/shared_prefrences_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final secureStorageHelperProvider = Provider<SecureStorageHelper>((ref) {
  return SecureStorageHelper(ref.watch(secureStorageProvider));
});

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

class SharedPreferencesHelperNotifier extends AsyncNotifier<SharedPreferencesHelper> {
  @override
  Future<SharedPreferencesHelper> build() async {
    final sharedPreferences = await ref.watch(sharedPreferencesProvider.future);
    return SharedPreferencesHelper(sharedPreferences);
  }
}

final sharedPreferencesHelperProvider = AsyncNotifierProvider<SharedPreferencesHelperNotifier, SharedPreferencesHelper>(
  SharedPreferencesHelperNotifier.new,
);
