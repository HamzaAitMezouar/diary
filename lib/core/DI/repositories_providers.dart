import 'package:diary/domain/repositories/cart/cart_repository.dart';
import 'package:diary/domain/repositories/location/location_repository.dart';
import 'package:diary/domain/repositories/medicament/medicament_repository.dart';
import 'package:diary/domain/repositories/medicament_category/medicament_category_repository.dart';
import 'package:diary/domain/repositories/pharmacy/pharmacy_repositoy.dart';
import 'package:diary/domain/repositories/reminder_repository/reminder_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data_source_providers.dart';

final reminderRepositoryProvider = Provider<ReminderRepository>((ref) {
  return ReminderRepositoryImpl(ref.watch(reminderLocalDataSource));
});

final medicamentRepositoryProvider = Provider<MedicamentRepository>((ref) {
  return MedicamentRepositoryImpl(ref.watch(medicamentRemoteDataSourceProvider));
});

final medicamentsCategoriesRepositoryProvider = Provider<MedicamentCategoryRepository>((ref) {
  final medicamentCategoryDataSource = ref.watch(medicamentsCategoriesDataSourceProvider);
  return MedicamentCategoryRepositoryImpl(medicamentCategoryDataSource);
});

final locationRepositoryProvider = Provider<LocationRepository>((ref) {
  final datasource = ref.watch(locationDatasourceProvider);
  return LocationRepositoryImpl(dataSource: datasource);
});

// pharma
final pharmacyRepositoryProvider = Provider<PharmacyRepository>((ref) {
  final pharmacyprovider = ref.watch(pharmacyDataSourceProvider);
  return PharmacyRepositoryImpl(pharmacyprovider);
});

//cart

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  final cartLocalDataSource = ref.watch(cartLocalDataSourceProvider);
  return CartRepositoryImpl(cartLocalDataSource);
});
