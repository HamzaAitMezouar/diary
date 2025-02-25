import 'package:diary/data/models/cart_model.dart';
import 'package:diary/domain/entities/order_entity.dart';

enum OrderStatus { pending, confirmed, shipped, delivered, cancelled }

class OrderModel {
  final String? id;
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
      status: json['status'],
      totalAmount: (json['totalAmount'] as num).toDouble(),
      cartItems: (json['cartItems'] as List).map((item) => CartItemModel.fromJson(item)).toList(),
    );
  }
  OrderEntiy toModel() => OrderEntiy(
      userId: userId, status: status, cartItems: cartItems.map((e) => e.toEntity()).toList(), totalAmount: totalAmount);
}
