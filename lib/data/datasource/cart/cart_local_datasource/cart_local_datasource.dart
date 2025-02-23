import 'package:diary/core/errors/exceptions.dart';
import 'package:diary/data/models/cart_model.dart';
import 'package:diary/data/models/medicament_model.dart';
import 'package:hive/hive.dart';

abstract class CartLocalDatasource {
  Future<CartModel> addMedicament(MedicamentModel medicament);
  Future<CartModel> removeMedicament(int id);
  Future<CartModel> updateMedicamentQuantity(int id, int quantity);
  Future<CartModel> clearCart();
  Future<CartModel> getCartItems();
}

class CartLocalDatasourceImpl extends CartLocalDatasource {
  final Box<CartModel> _cartBox;
  CartLocalDatasourceImpl(this._cartBox);

  CartModel _getCart() {
    return _cartBox.get('cart') ?? CartModel();
  }

  @override
  Future<CartModel> addMedicament(MedicamentModel medicament) async {
    try {
      final cart = _getCart();
      final updatedCart = cart.addMedicament(medicament);
      await _cartBox.put('cart', updatedCart);
      return updatedCart;
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<CartModel> removeMedicament(int id) async {
    try {
      final cart = _getCart();
      final updatedCart = cart.removeMedicament(id);
      await _cartBox.put('cart', updatedCart);
      return updatedCart;
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<CartModel> updateMedicamentQuantity(int id, int quantity) async {
    try {
      final cart = _getCart();
      final medicamentIndex = cart.medicaments.indexWhere((med) => med.id == id);
      if (medicamentIndex == -1) {
        throw CustomException(message: "No Medicament with this id");
      }

      final updatedMedicaments = List<MedicamentModel>.from(cart.medicaments);
      updatedMedicaments[medicamentIndex] = updatedMedicaments[medicamentIndex].copyWith(quantity: quantity);

      final updatedCart = CartModel(medicaments: updatedMedicaments);
      await _cartBox.put('cart', updatedCart);
      return updatedCart;
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<CartModel> clearCart() async {
    try {
      final emptyCart = CartModel();
      await _cartBox.put('cart', emptyCart);
      return emptyCart;
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<CartModel> getCartItems() async {
    try {
      return _getCart();
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }
}
