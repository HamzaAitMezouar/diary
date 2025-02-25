import 'package:hive/hive.dart';
import '../../domain/entities/cart_entity.dart';
import 'medicament_model.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 1, adapterName: 'CartModelAdapter')
class CartModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String? userId;
  @HiveField(2)
  final List<CartItemModel> cartItems;

  CartModel({
    required this.id,
    this.userId,
    this.cartItems = const [],
  });

  double get totalPrice => cartItems.fold(0, (sum, item) => sum + (item.medicament.ppv * item.quantity));

  CartModel copyWith({
    int? id,
    String? userId,
    List<CartItemModel>? cartItems,
  }) {
    return CartModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      cartItems: cartItems ?? this.cartItems,
    );
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      userId: json['userId'],
      cartItems: (json['cartItems'] as List<dynamic>).map((item) => CartItemModel.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'cartItems': cartItems.map((item) => item.toJson()).toList(),
    };
  }

  CartEntity toEntity() {
    return CartEntity(
      id: id,
      userId: userId,
      cartItems: cartItems.map((item) => item.toEntity()).toList(),
    );
  }
}

@HiveType(typeId: 2, adapterName: 'CarItemModelAdapter')
class CartItemModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int? cartId;
  @HiveField(2)
  final MedicamentModel medicament;
  @HiveField(3)
  final int quantity;

  CartItemModel({
    required this.id,
    this.cartId,
    required this.medicament,
    this.quantity = 1,
  });

  CartItemModel copyWith({
    int? id,
    int? cartId,
    MedicamentModel? medicament,
    int? quantity,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      cartId: cartId ?? this.cartId,
      medicament: medicament ?? this.medicament,
      quantity: quantity ?? this.quantity,
    );
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      cartId: json['cartId'],
      medicament: MedicamentModel.fromJson(json['medicament']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cartId': cartId,
      'medicament': medicament.toJson(),
      'quantity': quantity,
    };
  }

  CartItemEntity toEntity() {
    return CartItemEntity(
      id: id,
      cartId: cartId,
      medicament: medicament.toEntity(),
      quantity: quantity,
    );
  }
}
