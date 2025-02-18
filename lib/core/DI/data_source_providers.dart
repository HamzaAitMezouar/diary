import 'package:diary/core/DI/dio_provider.dart';
import 'package:diary/core/DI/exception_handler_provider.dart';
import 'package:diary/core/DI/storage_provider.dart';
import 'package:diary/data/datasource/location/location_datasource.dart';
import 'package:diary/data/datasource/medicament_category/medicament_category_datasourca.dart';
import 'package:diary/data/datasource/medicaments/medicament_remote_datasource/medicament_remote_datasource.dart';
import 'package:diary/data/datasource/reminder_datasource/reminder_local_datasource.dart';
import 'package:diary/domain/repositories/medicament_category/medicament_category_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reminderLocalDataSource = Provider<ReminderLocalDataSource>((ref) {
  final hivebox = ref.watch(hivereminderBoxProvider);
  return ReminderLocalDataSourceImpl(hivebox);
});

final medicamentRemoteDataSourceProvider = Provider<MedicamentRemoteDatasource>((ref) {
  final authDio = ref.watch(authDioProvider);
  final exceptionHandler = ref.watch(exceptionsHandlerProvider);
  return MedicamentRemoteDatasourceImpl(authDio, exceptionHandler);
});

final medicamentsCategoriesDataSourceProvider = Provider<MedicamentsCategoryDatasource>((ref) {
  final authDio = ref.watch(authDioProvider);
  final exceptionHandler = ref.watch(exceptionsHandlerProvider);
  return MedicamentsCategoryDatasourceImpl(authDio, exceptionHandler);
});

// Location

final locationDatasourceProvider = Provider<LocationDataSource>((ref) {
  return LocationDataSourceImpl();
});
