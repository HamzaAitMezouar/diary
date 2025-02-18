import 'package:dartz/dartz.dart';
import 'package:diary/core/errors/errors.dart';
import 'package:diary/core/errors/exceptions.dart';
import 'package:diary/domain/entities/location_entity.dart';
import 'package:timezone/tzdata.dart';

import '../../../data/datasource/location/location_datasource.dart';

abstract class LocationRepository {
  Future<Either<Failure, LocationEntity>> getUserLocation();
}

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSource dataSource;

  LocationRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, LocationEntity>> getUserLocation() async {
    try {
      final position = await dataSource.getCurrentLocation();
      return Right(LocationEntity(latitude: position.latitude, longitude: position.longitude));
    } on PermissionException catch (e) {
      return Left(PermissionFailure(errorMessage: e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(errorMessage: e.message));
    }
  }
}
