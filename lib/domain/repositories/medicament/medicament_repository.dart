import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:diary/core/errors/errors.dart';
import 'package:diary/data/datasource/medicaments/medicament_remote_datasource/medicament_remote_datasource.dart';
import 'package:diary/domain/entities/medicament_entity.dart';

import '../../../core/errors/exceptions.dart';

abstract class MedicamentRepository {
  Future<Either<Failure, List<MedicamentEntity>>> getMedicaments();
}

class MedicamentRepositoryImpl implements MedicamentRepository {
  final MedicamentRemoteDatasource _dataSource;
  MedicamentRepositoryImpl(this._dataSource);
  @override
  Future<Either<Failure, List<MedicamentEntity>>> getMedicaments() async {
    try {
      final result = await _dataSource.getMedicaments();
      log("----------------------------$result");
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
