import '../../data/models/order_model.dart';
import '../../domain/entities/checkout_entity.dart';

extension OrderStatusExtension on OrderStatus {
  static OrderStatus fromString(String status) {
    return OrderStatus.values.firstWhere(
      (e) => e.name == status,
      orElse: () => OrderStatus.pending, // Default value
    );
  }

  String toJson() => name; // Convert enum to string
}

extension DeliveryTypeExtension on DeliveryType {
  static DeliveryType fromString(String status) {
    return DeliveryType.values.firstWhere(
      (e) => e.name == status,
      orElse: () => DeliveryType.home, // Default value
    );
  }

  String toJson() => name; // Convert enum to string
}

extension DeliveryscheduleExtension on Deliveryschedule {
  static Deliveryschedule fromString(String status) {
    return Deliveryschedule.values.firstWhere(
      (e) => e.name == status,
      orElse: () => Deliveryschedule.now, // Default value
    );
  }

  String toJson() => name; // Convert enum to string
}

extension PaymentTypeExtension on PaymentType {
  static PaymentType fromString(String status) {
    return PaymentType.values.firstWhere(
      (e) => e.name == status,
      orElse: () => PaymentType.cash, // Default value
    );
  }

  String toJson() => name; // Convert enum to string
}
