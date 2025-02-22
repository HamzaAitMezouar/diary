import 'package:diary/domain/entities/location_entity.dart';
import 'package:diary/domain/entities/medicament_entity.dart';
import 'package:diary/domain/entities/pharmacy_entiy.dart';

enum DeliveryType { home, pharmacy }

enum Deliveryschedule { now, later }

enum PaymentType { cash, card }

class CheckoutEntity {
  final MedicamentEntity medicament;
  final DeliveryType? deliveryType;
  final PharmacyEntity? pharmacy;
  final LocationEntity? address;
  final Deliveryschedule deliveryschedule;
  DateTime? deliveryTime;
  final PaymentType paymentType;
  CheckoutEntity(
      {required this.medicament,
      this.deliveryType,
      this.pharmacy,
      this.address,
      this.deliveryschedule = Deliveryschedule.now,
      this.deliveryTime,
      this.paymentType = PaymentType.cash});

  CheckoutEntity copyWith(
      {MedicamentEntity? medicament,
      DeliveryType? deliveryType,
      PharmacyEntity? pharmacy,
      LocationEntity? address,
      DateTime? deliveryTime,
      Deliveryschedule? deliveryschedule,
      PaymentType? paymentType}) {
    return CheckoutEntity(
      medicament: medicament ?? this.medicament,
      deliveryType: deliveryType ?? this.deliveryType,
      pharmacy: pharmacy ?? this.pharmacy,
      address: address ?? this.address,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      deliveryschedule: deliveryschedule ?? this.deliveryschedule,
      paymentType: paymentType ?? this.paymentType,
    );
  }
}
