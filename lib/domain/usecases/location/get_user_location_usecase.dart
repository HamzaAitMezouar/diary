import 'package:dartz/dartz.dart';
import 'package:diary/domain/entities/location_entity.dart';

import '../../../core/errors/errors.dart';
import '../../repositories/location/location_repository.dart';

class GetUserLocation {
  final LocationRepository repository;

  GetUserLocation({required this.repository});

  Future<Either<Failure, LocationEntity>> call() async {
    return await repository.getUserLocation();
  }
}
