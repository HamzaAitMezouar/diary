import 'package:diary/domain/entities/medicament_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedMedicineNotifier extends StateNotifier<MedicamentEntity?> {
  SelectedMedicineNotifier() : super(null);

  void selectMedicine(medicine) {
    state = medicine;
  }

  void clearSelection() {
    state = null;
  }
}

final selectedMedicineProvider = StateNotifierProvider<SelectedMedicineNotifier, MedicamentEntity?>(
  (ref) => SelectedMedicineNotifier(),
);
