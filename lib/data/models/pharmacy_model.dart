import '../../domain/entities/pharmacy_entiy.dart';

class PharmacyModel {
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
  final OpeningHoursModel? openingHours;

  PharmacyModel({
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

  // Convert JSON to Model
  factory PharmacyModel.fromJson(Map<String, dynamic> json) {
    return PharmacyModel(
      id: json['id'] as int,
      name: json['name'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      postalCode: json['postalCode'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String?,
      website: json['website'] as String?,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      openingHours: json['openingHours'] != null ? OpeningHoursModel.fromJson(json['openingHours']) : null,
    );
  }

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'latitude': latitude,
      'longitude': longitude,
      'phoneNumber': phoneNumber,
      'email': email,
      'website': website,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'openingHours': openingHours?.toJson(),
    };
  }

  // Convert to Entity
  PharmacyEntity toEntity() {
    return PharmacyEntity(
      id: id,
      name: name,
      address: address,
      city: city,
      state: state,
      postalCode: postalCode,
      latitude: latitude,
      longitude: longitude,
      phoneNumber: phoneNumber,
      email: email,
      website: website,
      createdAt: createdAt,
      updatedAt: updatedAt,
      openingHours: openingHours?.toEntity(),
    );
  }
}

class OpeningHoursModel {
  final String weekday;
  final String openTime;
  final String closeTime;

  OpeningHoursModel({
    required this.weekday,
    required this.openTime,
    required this.closeTime,
  });

  factory OpeningHoursModel.fromJson(Map<String, dynamic> json) {
    return OpeningHoursModel(
      weekday: json['weekday'] as String,
      openTime: json['openTime'] as String,
      closeTime: json['closeTime'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'weekday': weekday,
      'openTime': openTime,
      'closeTime': closeTime,
    };
  }

  OpeningHoursEntity toEntity() {
    return OpeningHoursEntity(
      weekday: weekday,
      openTime: openTime,
      closeTime: closeTime,
    );
  }
}
