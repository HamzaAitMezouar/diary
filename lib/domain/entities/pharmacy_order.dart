import 'package:diary/data/models/order_model.dart';
import 'package:diary/data/models/pharmacy_model.dart';
import 'package:diary/domain/entities/order_entity.dart';
import 'package:diary/domain/entities/pharmacy_entiy.dart';

class PharmacyOrderEntity {
  PharmacyEntity pharmcay;
  OrderEntity order;
  PharmacyOrderEntity({required this.order, required this.pharmcay});
  factory PharmacyOrderEntity.fromJson(Map<String, dynamic> json) {
    return PharmacyOrderEntity(
      order: OrderModel.fromJson(json["order"]).toEntity(),
      pharmcay: PharmacyModel.fromJson(json["pharmacy"]).toEntity(),
    );
  }
}
