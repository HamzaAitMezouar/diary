import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:diary/data/datasource/pharmacy/pharmacy_datasource.dart';
import 'package:diary/domain/entities/pharmacy_entiy.dart';

import '../../../core/errors/errors.dart';
import '../../../core/errors/exceptions.dart';

abstract class PharmacyRepository {
  Future<Either<Failure, List<PharmacyEntity>>> getNearestPharmacy(double lang, double lat);
}

class PharmacyRepositoryImpl implements PharmacyRepository {
  final PharmacyDatasource _dataSource;
  PharmacyRepositoryImpl(this._dataSource);
  @override
  Future<Either<Failure, List<PharmacyEntity>>> getNearestPharmacy(double lang, double lat) async {
    try {
      final result = await _dataSource.getNearestPharmacy(lang, lat);
      return Right(result.map((e) => e.toEntity()).toList());
    } on CustomException catch (e) {
      log(e.message);

      return Left(CostumeFailure(errorMessage: e.message));
    } on UnexpectedException catch (e) {
      log(e.message);

      return Left(UnexpectedFailure(errorMessage: e.message));
    }
  }
}
