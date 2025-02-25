import 'package:diary/data/models/order_model.dart';
import 'package:diary/domain/entities/cart_entity.dart';

class OrderEntity {
  final String? id;
  final String userId;
  final OrderStatus status;
  final List<CartItemEntity> cartItems;
  final double totalAmount;

  OrderEntity({
    this.id,
    required this.userId,
    required this.status,
    required this.cartItems,
    required this.totalAmount,
  });
  OrderModel toModel() => OrderModel(
      userId: userId, status: status, cartItems: cartItems.map((e) => e.toModel()).toList(), totalAmount: totalAmount);
}
