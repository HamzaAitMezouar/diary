import 'package:diary/core/helpers/secure_storage_helper.dart';
import 'package:diary/core/helpers/shared_prefrences_helper.dart';
import 'package:diary/data/models/cart_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/reminder_model.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final secureStorageHelperProvider = Provider<SecureStorageHelper>((ref) {
  return SecureStorageHelper(ref.watch(secureStorageProvider));
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final sharedPreferencesHelperProvider =
    Provider<SharedPreferencesHelper>((ref) => SharedPreferencesHelper(ref.watch(sharedPreferencesProvider)));

final hivereminderBoxProvider = Provider<Box<ReminderModel>>((ref) {
  return Hive.box<ReminderModel>('remindersBox');
});

final hiveCartBoxProvider = Provider<Box<CartModel>>((ref) {
  return Hive.box<CartModel>('cart');
});
