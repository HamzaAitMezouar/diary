import 'package:diary/domain/entities/cart_entity.dart';

import '../../data/models/order_model.dart';
import 'checkout_entity.dart';

class OrderEntity {
  final int? id;
  final String userId;
  final OrderStatus status;
  final double subtotal;
  final double tax;
  final double discount;
  final double totalAmount;
  final PaymentType paymentType;
  final String? transactionId;
  final String deliveryAddress;
  final double deliveryLat;
  final double deliveryLng;
  final DeliveryType deliveryType;
  final DateTime? deliveryDate;
  final double deliveryFee;
  final DateTime? estimatedDeliveryTime;
  final bool prescriptionRequired;
  final String? prescriptionUrl;
  final int? pharmacyId;
  final List<CartItemEntity> cartItems;

  const OrderEntity({
    required this.id,
    required this.userId,
    required this.status,
    required this.subtotal,
    required this.tax,
    required this.discount,
    required this.totalAmount,
    required this.paymentType,
    this.transactionId,
    required this.deliveryAddress,
    required this.deliveryLat,
    required this.deliveryLng,
    required this.deliveryType,
    this.deliveryDate,
    required this.deliveryFee,
    this.estimatedDeliveryTime,
    required this.prescriptionRequired,
    this.prescriptionUrl,
    this.pharmacyId,
    required this.cartItems,
  });
  OrderModel toEntity() => OrderModel(
      id: id,
      userId: userId,
      status: status,
      subtotal: subtotal,
      tax: tax,
      discount: discount,
      totalAmount: totalAmount,
      paymentType: paymentType,
      deliveryAddress: deliveryAddress,
      deliveryLat: deliveryLat,
      deliveryLng: deliveryLng,
      deliveryType: deliveryType,
      deliveryFee: deliveryFee,
      prescriptionRequired: prescriptionRequired,
      cartItems: cartItems.map((e) => e.toModel()).toList());
}
