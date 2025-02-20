class LocationEntity {
  final double latitude;
  final double longitude;
  final String? address;
  LocationEntity({required this.latitude, required this.longitude, this.address});

  LocationEntity copyWith(String? address) {
    return LocationEntity(latitude: latitude, longitude: longitude, address: address ?? this.address);
  }
}
