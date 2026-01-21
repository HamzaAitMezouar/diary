import 'package:diary/core/params/orders_params.dart';
import 'package:diary/domain/entities/cart_entity.dart';
import 'package:diary/domain/entities/location_entity.dart';
import 'package:diary/domain/entities/pharmacy_entiy.dart';

enum DeliveryType { home, pharmacy }

enum Deliveryschedule { now, later }

enum PaymentType { cash, card }

class CheckoutEntity {
  final List<CartItemEntity> items;
  final DeliveryType? deliveryType;
  final PharmacyEntity? pharmacy;
  final LocationEntity? address;
  final Deliveryschedule deliveryschedule;
  DateTime? deliveryTime;
  final PaymentType paymentType;
  CheckoutEntity(
      {required this.items,
      this.deliveryType,
      this.pharmacy,
      this.address,
      this.deliveryschedule = Deliveryschedule.now,
      this.deliveryTime,
      this.paymentType = PaymentType.cash});

  CheckoutEntity copyWith(
      {List<CartItemEntity>? items,
      DeliveryType? deliveryType,
      PharmacyEntity? pharmacy,
      LocationEntity? address,
      DateTime? deliveryTime,
      Deliveryschedule? deliveryschedule,
      PaymentType? paymentType}) {
    return CheckoutEntity(
      items: items ?? this.items,
      deliveryType: deliveryType ?? this.deliveryType,
      pharmacy: pharmacy ?? this.pharmacy,
      address: address ?? this.address,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      deliveryschedule: deliveryschedule ?? this.deliveryschedule,
      paymentType: paymentType ?? this.paymentType,
    );
  }

  OrdersParams toOrderParams() {
    return OrdersParams(
      items: items.map((e) => e.toModel()).toList(),
      paymentMethod: paymentType.name,
      deliveryDetails: DeliveryDetails(
          address: address?.address ?? "",
          lat: address?.latitude ?? 0,
          lang: address?.longitude ?? 0,
          type: deliveryType ?? DeliveryType.home,
          schedule: deliveryschedule,
          date: deliveryTime,
          deliveryFee: 10),
    );
  }
}
