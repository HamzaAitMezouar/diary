import 'package:diary/domain/entities/location_entity.dart';
import 'package:diary/domain/entities/medicament_entity.dart';
import 'package:diary/domain/entities/pharmacy_entiy.dart';

enum DeliveryType { home, pharmacy }

class CheckoutEntity {
  final MedicamentEntity medicament;
  final DeliveryType? deliveryType;
  final PharmacyEntity? pharmacy;
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
    PharmacyEntity? pharmacy,
    LocationEntity? address,
  }) {
    return CheckoutEntity(
        medicament: medicament ?? this.medicament,
        deliveryType: deliveryType ?? this.deliveryType,
        pharmacy: pharmacy ?? this.pharmacy,
        address: address ?? this.address);
  }
}
