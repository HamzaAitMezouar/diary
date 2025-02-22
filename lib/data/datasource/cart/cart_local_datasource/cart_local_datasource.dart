import 'package:diary/data/models/medicament_model.dart';
import 'package:hive/hive.dart';

abstract class CartLocalDatasource {
  Future<void> addMedicament(MedicamentModel medicament);
  Future<void> removeMedicament(int id);
  Future<void> updateMedicamentQuantity(int id, int quantity);
  Future<void> clearCart();
  Future<List<MedicamentModel>> getCartItems();
}

class CartLocalDatasourceImpl extends CartLocalDatasource {
  static const String cartBoxName = "cartBox";

  @override
  Future<void> addMedicament(MedicamentModel medicament) async {
    final box = await Hive.openBox<MedicamentModel>(cartBoxName);
    await box.put(medicament.id, medicament);
  }

  @override
  Future<void> removeMedicament(int id) async {
    final box = await Hive.openBox<MedicamentModel>(cartBoxName);
    await box.delete(id);
  }

  @override
  Future<void> updateMedicamentQuantity(int id, int quantity) async {
    final box = await Hive.openBox<MedicamentModel>(cartBoxName);
    final medicament = box.get(id);
    if (medicament != null) {
      await box.put(id, medicament.copyWith(quantity: quantity));
    }
  }

  @override
  Future<void> clearCart() async {
    final box = await Hive.openBox<MedicamentModel>(cartBoxName);
    await box.clear();
  }

  @override
  Future<List<MedicamentModel>> getCartItems() async {
    final box = await Hive.openBox<MedicamentModel>(cartBoxName);
    return box.values.toList();
  }
}
