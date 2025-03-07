import 'dart:convert';
import 'dart:developer';

import 'package:diary/data/models/cart_model.dart';
import 'package:diary/domain/entities/order_entity.dart';
import 'package:equatable/equatable.dart';

import '../../core/extensions/enums_extensions.dart';
import '../../domain/entities/checkout_entity.dart';
import 'pharmacy_model.dart';

enum OrderStatus { pending, confirmed, shipped, delivered, cancelled }

OrderModel orderFromJsonString(String str) => OrderModel.fromJson(json.decode(str));

class OrderModel extends Equatable {
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
  final PharmacyModel? pharmacy;
  final List<CartItemModel> cartItems;

  const OrderModel({
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
    this.pharmacy,
    required this.cartItems,
  });

  /// ✅ Convert JSON to OrderModel
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    try {
      return OrderModel(
          id: int.tryParse(json['id'].toString()) ?? 0, // Ensures int conversion
          userId: json['userId'] as String,
          status: OrderStatusExtension.fromString(json['status'].toString()),
          subtotal: double.tryParse(json['subtotal'].toString()) ?? 0.0,
          tax: double.tryParse(json['tax'].toString()) ?? 0.0,
          discount: double.tryParse(json['discount'].toString()) ?? 0.0,
          totalAmount: double.tryParse(json['totalAmount'].toString()) ?? 0.0,
          paymentType: PaymentTypeExtension.fromString(json['paymentType'].toString()),
          transactionId: json['transactionId'] as String?,
          deliveryAddress: json['deliveryAddress'] as String,
          deliveryLat: double.tryParse(json['deliveryLat'].toString()) ?? 0.0,
          deliveryLng: double.tryParse(json['deliveryLng'].toString()) ?? 0.0,
          deliveryType: DeliveryTypeExtension.fromString(json['deliveryType'].toString()),
          deliveryDate: json['deliveryDate'] != null ? DateTime.tryParse(json['deliveryDate'].toString()) : null,
          deliveryFee: double.tryParse(json['deliveryFee'].toString()) ?? 0.0,
          estimatedDeliveryTime: json['estimatedDeliveryTime'] != null
              ? DateTime.tryParse(json['estimatedDeliveryTime'].toString())
              : null,
          prescriptionRequired: json['prescriptionRequired'] == true || json['prescriptionRequired'] == "true",
          prescriptionUrl: json['prescriptionUrl'] as String?,
          pharmacyId: json['pharmacyId'] != null ? int.tryParse(json['pharmacyId'].toString()) : null,
          cartItems: _getCartItems(json['cartItems']));
    } catch (e) {
      log("ERRORRR " + e.toString());
      rethrow;
    }
  }
  static List<CartItemModel> _getCartItems(dynamic cartItemsJson) {
    log(cartItemsJson.toString());
    if (cartItemsJson is String) {
      // If it's a string, try to parse it as a JSON string into a list
      try {
        // If the string is a valid JSON array, parse it
        final List<dynamic> parsedList = jsonDecode(cartItemsJson);
        return parsedList.map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)).toList();
      } catch (e) {
        // If it's not a valid JSON array, handle it gracefully (e.g., return an empty list or log an error)
        return [];
      }
    } else if (cartItemsJson is List<dynamic>) {
      // If it's already a list, map it directly
      return cartItemsJson.map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)).toList();
    } else {
      // Handle unexpected cases, like null or other types
      return [];
    }
  }

  /// ✅ Convert OrderModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.name,
      'subtotal': subtotal,
      'tax': tax,
      'discount': discount,
      'totalAmount': totalAmount,
      'paymentType': paymentType.name,
      'transactionId': transactionId,
      'deliveryAddress': deliveryAddress,
      'deliveryLat': deliveryLat,
      'deliveryLng': deliveryLng,
      'deliveryType': deliveryType.name,
      'deliveryDate': deliveryDate?.toIso8601String(),
      'deliveryFee': deliveryFee,
      'estimatedDeliveryTime': estimatedDeliveryTime?.toIso8601String(),
      'prescriptionRequired': prescriptionRequired,
      'prescriptionUrl': prescriptionUrl,
      'pharmacyId': pharmacyId,
      'pharmacy': pharmacy?.toJson(),
      'cartItems': cartItems.map((item) => item.toJson()).toList(),
    };
  }

  /// ✅ Convert OrderModel to Entity
  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      userId: userId,
      status: status,
      subtotal: subtotal,
      tax: tax,
      discount: discount,
      totalAmount: totalAmount,
      paymentType: paymentType,
      transactionId: transactionId,
      deliveryAddress: deliveryAddress,
      deliveryLat: deliveryLat,
      deliveryLng: deliveryLng,
      deliveryType: deliveryType,
      deliveryDate: deliveryDate,
      deliveryFee: deliveryFee,
      estimatedDeliveryTime: estimatedDeliveryTime,
      prescriptionRequired: prescriptionRequired,
      prescriptionUrl: prescriptionUrl,
      pharmacyId: pharmacyId,
      cartItems: cartItems.map((item) => item.toEntity()).toList(),
    );
  }

  /// ✅ Copy with method
  OrderModel copyWith({
    int? id,
    String? userId,
    OrderStatus? status,
    double? subtotal,
    double? tax,
    double? discount,
    double? totalAmount,
    PaymentType? paymentType,
    String? transactionId,
    String? deliveryAddress,
    double? deliveryLat,
    double? deliveryLng,
    DeliveryType? deliveryType,
    DateTime? deliveryDate,
    double? deliveryFee,
    DateTime? estimatedDeliveryTime,
    bool? prescriptionRequired,
    String? prescriptionUrl,
    int? pharmacyId,
    PharmacyModel? pharmacy,
    List<CartItemModel>? cartItems,
  }) {
    return OrderModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      subtotal: subtotal ?? this.subtotal,
      tax: tax ?? this.tax,
      discount: discount ?? this.discount,
      totalAmount: totalAmount ?? this.totalAmount,
      paymentType: paymentType ?? this.paymentType,
      transactionId: transactionId ?? this.transactionId,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      deliveryLat: deliveryLat ?? this.deliveryLat,
      deliveryLng: deliveryLng ?? this.deliveryLng,
      deliveryType: deliveryType ?? this.deliveryType,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      estimatedDeliveryTime: estimatedDeliveryTime ?? this.estimatedDeliveryTime,
      prescriptionRequired: prescriptionRequired ?? this.prescriptionRequired,
      prescriptionUrl: prescriptionUrl ?? this.prescriptionUrl,
      pharmacyId: pharmacyId ?? this.pharmacyId,
      pharmacy: pharmacy ?? this.pharmacy,
      cartItems: cartItems ?? this.cartItems,
    );
  }

  @override
  List<Object?> get props => [id, userId, status, totalAmount, pharmacyId, cartItems];
}
