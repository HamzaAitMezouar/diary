import 'dart:developer';

import 'package:diary/core/errors/exceptions.dart';
import 'package:diary/data/models/cart_model.dart';
import 'package:hive/hive.dart';

abstract class CartLocalDatasource {
  Future<CartModel> addMedicament(CartItemModel cartItem);
  Future<CartModel> removeMedicament(int id);
  Future<CartModel> updateMedicamentQuantity(int id, int quantity);
  Future<CartModel> clearCart();
  Future<CartModel> getCartItems();
}

class CartLocalDatasourceImpl extends CartLocalDatasource {
  final Box<CartModel> _cartBox;
  CartLocalDatasourceImpl(this._cartBox);

  CartModel _getCart() {
    return _cartBox.get('cart') ?? CartModel(id: 0, userId: '', cartItems: []);
  }

  @override
  Future<CartModel> addMedicament(CartItemModel cartItem) async {
    try {
      log("message-----------${cartItem.quantity}");
      final cart = _getCart();

      final index = cart.cartItems.indexWhere((item) => item.medicament.id == cartItem.medicament.id);

      if (index != -1) {
        final updatedItems = List<CartItemModel>.from(cart.cartItems);
        final existingItem = updatedItems[index];
        updatedItems[index] = existingItem.copyWith(quantity: cartItem.quantity);

        final updatedCart = cart.copyWith(cartItems: updatedItems);
        await _cartBox.put('cart', updatedCart);
        return updatedCart;
      }

      final updatedCart = cart.copyWith(cartItems: [...cart.cartItems, cartItem]);

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
      final updatedCart = cart.copyWith(
        cartItems: cart.cartItems.where((item) => item.id != id).toList(),
      );
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
      final updatedCartItems = cart.cartItems.map((item) {
        if (item.id == id) {
          return item.copyWith(quantity: quantity);
        }
        return item;
      }).toList();

      final updatedCart = cart.copyWith(cartItems: updatedCartItems);
      await _cartBox.put('cart', updatedCart);
      return updatedCart;
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<CartModel> clearCart() async {
    try {
      final emptyCart = CartModel(id: 0, userId: '', cartItems: []);
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
