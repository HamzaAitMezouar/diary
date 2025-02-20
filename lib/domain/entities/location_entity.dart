import 'package:diary/domain/entities/pharmacy_entiy.dart';

class LocationEntity {
  final double latitude;
  final double longitude;
  final String? address;
  final PharmacyEntity? pharmacy;
  LocationEntity({required this.latitude, required this.longitude, this.address, this.pharmacy});

  LocationEntity copyWith({String? address, PharmacyEntity? pharmacy}) {
    return LocationEntity(
        latitude: latitude,
        longitude: longitude,
        address: address ?? this.address,
        pharmacy: pharmacy ?? this.pharmacy);
  }
}
