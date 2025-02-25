import 'package:diary/data/models/cart_model.dart';
import 'package:diary/domain/entities/order_entity.dart';

import '../../core/extensions/enums_extensions.dart';

enum OrderStatus { pending, confirmed, shipped, delivered, cancelled }

class OrderModel {
  final int? id;
  final String userId;
  final OrderStatus status;
  final List<CartItemModel> cartItems;
  final double totalAmount;

  OrderModel({
    this.id,
    required this.userId,
    required this.status,
    required this.cartItems,
    required this.totalAmount,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['userId'],
      status: OrderStatusExtension.fromString(json['status']),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      cartItems: (json['cartItems'] as List).map((item) => CartItemModel.fromJson(item)).toList(),
    );
  }
  OrderEntity toEntity() => OrderEntity(
      userId: userId, status: status, cartItems: cartItems.map((e) => e.toEntity()).toList(), totalAmount: totalAmount);
}
