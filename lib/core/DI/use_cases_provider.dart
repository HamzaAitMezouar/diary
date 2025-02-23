import 'package:diary/core/DI/repositories_providers.dart';
import 'package:diary/domain/usecases/cart/add_medicament.dart';
import 'package:diary/domain/usecases/cart/clear_cart.dart';
import 'package:diary/domain/usecases/cart/get_cart.dart';
import 'package:diary/domain/usecases/cart/remove_medicament.dart';
import 'package:diary/domain/usecases/cart/update_medicament_quantity.dart';
import 'package:diary/domain/usecases/location/get_user_location_usecase.dart';
import 'package:diary/domain/usecases/medicament/get_medicament_usecase.dart';
import 'package:diary/domain/usecases/medicament_category/get_medicament_category_usecase.dart';
import 'package:diary/domain/usecases/pharmacy/get_nearest_pharmacy_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/reminder_usecases/add_reminder.dart';
import '../../domain/usecases/reminder_usecases/alter_reminder.dart';
import '../../domain/usecases/reminder_usecases/get_reminder.dart';

final addReminderUseCaseProvider = Provider<AddReminderUseCase>((ref) {
  final repo = ref.watch(reminderRepositoryProvider);
  return AddReminderUseCase(repo);
});

final getRemindersUseCaseProvider = Provider<GetRemindersUseCase>((ref) {
  final repo = ref.watch(reminderRepositoryProvider);
  return GetRemindersUseCase(repo);
});

final markReminderAsCompletedUseCaseProvider = Provider<MarkReminderAsCompletedUseCase>((ref) {
  final repo = ref.watch(reminderRepositoryProvider);
  return MarkReminderAsCompletedUseCase(repo);
});

final getMedicamentUsecasesProvider = Provider<GetMedicamentsUseCase>((ref) {
  final repo = ref.watch(medicamentRepositoryProvider);
  return GetMedicamentsUseCase(repo);
});

final getMedicamentsCategoriesUsecasesProvider = Provider<GetMedicamentsCaregoryUsecase>((ref) {
  final repo = ref.watch(medicamentsCategoriesRepositoryProvider);
  return GetMedicamentsCaregoryUsecase(repo);
});

// location
final getUserLocationUsecasesProvider = Provider<GetUserLocation>((ref) {
  final repo = ref.watch(locationRepositoryProvider);
  return GetUserLocation(repository: repo);
});

// pharma

final getNearestPharmacyUsecasesProvider = Provider<GetNearestPharmacyUseCase>((ref) {
  final repo = ref.watch(pharmacyRepositoryProvider);
  return GetNearestPharmacyUseCase(repo);
});
//cart
final addMedicamentToCartUsecasesProvider = Provider<AddMedicamentToCartUseCase>((ref) {
  final repo = ref.watch(cartRepositoryProvider);
  return AddMedicamentToCartUseCase(repo);
});

final clearCartUsecasesProvider = Provider<ClearCartUseCase>((ref) {
  final repo = ref.watch(cartRepositoryProvider);
  return ClearCartUseCase(repo);
});

final getCartUsecasesProvider = Provider<GetCartUseCase>((ref) {
  final repo = ref.watch(cartRepositoryProvider);
  return GetCartUseCase(repo);
});

final removemredicamentFromCartUsecasesProvider = Provider<RemoveMedicamentFromCartUseCase>((ref) {
  final repo = ref.watch(cartRepositoryProvider);
  return RemoveMedicamentFromCartUseCase(repo);
});

final updateCartMedicamentQuantityUsecasesProvider = Provider<UpdateMedicamentQuanityFromCartUseCase>((ref) {
  final repo = ref.watch(cartRepositoryProvider);
  return UpdateMedicamentQuanityFromCartUseCase(repo);
});
