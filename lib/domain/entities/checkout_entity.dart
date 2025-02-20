import 'package:diary/domain/entities/location_entity.dart';
import 'package:diary/domain/entities/medicament_entity.dart';

enum DeliveryType { home, pharmacy }

class CheckoutEntity {
  final MedicamentEntity medicament;
  final DeliveryType? deliveryType;
  final String? pharmacy;
  final LocationEntity? address;
  CheckoutEntity({
    required this.medicament,
    this.deliveryType,
    this.pharmacy,
    this.address,
  });

  CheckoutEntity copyWith({
    MedicamentEntity? medicament,
    DeliveryType? deliveryType,
    String? pharmacy,
    LocationEntity? address,
  }) {
    return CheckoutEntity(
        medicament: medicament ?? this.medicament,
        deliveryType: deliveryType ?? this.deliveryType,
        pharmacy: pharmacy ?? this.pharmacy,
        address: address ?? this.address);
  }
}
