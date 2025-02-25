import 'package:diary/data/models/cart_model.dart';

import 'medicament_entity.dart';

class CartEntity {
  final int id;

  final String? userId;

  final List<CartItemEntity> cartItems;

  CartEntity({
    required this.id,
    required this.userId,
    this.cartItems = const [],
  });

  CartModel toModel() => CartModel(id: id, userId: userId, cartItems: cartItems.map((e) => e.toModel()).toList());
}

class CartItemEntity {
  final int? id;

  final int? cartId;

  final MedicamentEntity medicament;

  final int quantity;

  CartItemEntity({
    this.id,
    this.cartId,
    required this.medicament,
    this.quantity = 1,
  });

  CartItemModel toModel() => CartItemModel(id: id, cartId: cartId, medicament: medicament.toModel());
}
