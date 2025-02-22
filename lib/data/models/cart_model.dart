import 'package:diary/data/models/medicament_model.dart';
import 'package:diary/domain/entities/medicament_entity.dart';
import 'package:diary/domain/repositories/medicament_category/medicament_category_repository.dart';

import '../../domain/entities/cart_entity.dart';

class CartModel {
  final List<MedicamentModel> medicaments;

  CartModel({this.medicaments = const []});

  double get totalPrice => medicaments.fold(0, (sum, item) => sum + (item.ppv * item.selectedQuantiy));

  CartModel addMedicament(MedicamentModel medicament) {
    List<MedicamentModel> updatedList = List.from(medicaments);
    updatedList.add(medicament);
    return CartModel(medicaments: updatedList);
  }

  CartModel removeMedicament(String id) {
    List<MedicamentModel> updatedList = medicaments.where((med) => med.id != id).toList();
    return CartModel(medicaments: updatedList);
  }

  CartEntity toEntity() {
    return CartEntity(medicaments: medicaments.map((e) => e.toEntity()).toList());
  }

  factory CartModel.fromEntity(CartEntity entity) {
    return CartModel(medicaments: entity.medicaments.map((e) => e.toModel()).toList());
  }
}
