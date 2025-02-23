import 'package:diary/core/errors/exceptions.dart';
import 'package:diary/data/models/medicament_model.dart';
import 'package:hive/hive.dart';

abstract class CartLocalDatasource {
  Future<MedicamentModel> addMedicament(MedicamentModel medicament);
  Future<bool> removeMedicament(int id);
  Future<MedicamentModel> updateMedicamentQuantity(int id, int quantity);
  Future<bool> clearCart();
  Future<List<MedicamentModel>> getCartItems();
}

class CartLocalDatasourceImpl extends CartLocalDatasource {
  static const String cartBoxName = "cartBox";

  @override
  Future<MedicamentModel> addMedicament(MedicamentModel medicament) async {
    try {
      final box = await Hive.openBox<MedicamentModel>(cartBoxName);
      await box.put(medicament.id, medicament);
      return medicament;
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<bool> removeMedicament(int id) async {
    try {
      final box = await Hive.openBox<MedicamentModel>(cartBoxName);
      await box.delete(id);

      return true;
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<MedicamentModel> updateMedicamentQuantity(int id, int quantity) async {
    try {
      final box = await Hive.openBox<MedicamentModel>(cartBoxName);
      final medicament = box.get(id);
      if (medicament != null) {
        await box.put(id, medicament.copyWith(quantity: quantity));
        return medicament;
      }
      throw CustomException(message: "No Medicament with this id");
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<bool> clearCart() async {
    try {
      final box = await Hive.openBox<MedicamentModel>(cartBoxName);
      await box.clear();
      return true;
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<List<MedicamentModel>> getCartItems() async {
    try {
      final box = await Hive.openBox<MedicamentModel>(cartBoxName);
      return box.values.toList();
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }
}
