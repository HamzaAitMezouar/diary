import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:diary/core/errors/errors.dart';
import 'package:diary/data/datasource/medicament_category/medicament_category_datasourca.dart';
import 'package:diary/domain/entities/category_entity.dart';

import '../../../core/errors/exceptions.dart';

abstract class MedicamentCategoryRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
}

class MedicamentCategoryRepositoryImpl implements MedicamentCategoryRepository {
  final MedicamentsCategoryDatasource _dataSource;
  MedicamentCategoryRepositoryImpl(this._dataSource);
  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final result = await _dataSource.getCategories();
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
