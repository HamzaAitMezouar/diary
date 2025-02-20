import '../../data/models/pharmacy_model.dart';

class PharmacyEntity {
  final int id;
  final String name;
  final String address;
  final String city;
  final String state;
  final String postalCode;
  final double latitude;
  final double longitude;
  final String phoneNumber;
  final String? email;
  final String? website;
  final DateTime createdAt;
  final DateTime updatedAt;
  final OpeningHoursEntity? openingHours;

  PharmacyEntity({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.latitude,
    required this.longitude,
    required this.phoneNumber,
    this.email,
    this.website,
    required this.createdAt,
    required this.updatedAt,
    this.openingHours,
  });
  // Convert Entity to Model
  static PharmacyModel toModel(PharmacyEntity entity) {
    return PharmacyModel(
      id: entity.id,
      name: entity.name,
      address: entity.address,
      city: entity.city,
      state: entity.state,
      postalCode: entity.postalCode,
      latitude: entity.latitude,
      longitude: entity.longitude,
      phoneNumber: entity.phoneNumber,
      email: entity.email,
      website: entity.website,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      openingHours: entity.openingHours != null ? OpeningHoursEntity.toModel(entity.openingHours!) : null,
    );
  }
}

class OpeningHoursEntity {
  final String weekday;
  final String openTime;
  final String closeTime;

  OpeningHoursEntity({
    required this.weekday,
    required this.openTime,
    required this.closeTime,
  });
  static OpeningHoursModel toModel(OpeningHoursEntity entity) {
    return OpeningHoursModel(
      weekday: entity.weekday,
      openTime: entity.openTime,
      closeTime: entity.closeTime,
    );
  }
}
