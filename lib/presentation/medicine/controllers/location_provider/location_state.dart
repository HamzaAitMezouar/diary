import 'package:diary/domain/entities/location_entity.dart';

abstract class LocationState {}

class InitLocationState extends LocationState {}

class UserLocationState extends LocationState {
  final LocationEntity locationEntity;
  UserLocationState(this.locationEntity);
}

class LocationErrorState extends LocationState {
  final String message;
  LocationErrorState(this.message);
}
