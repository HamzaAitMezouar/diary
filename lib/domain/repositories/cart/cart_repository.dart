import 'package:dartz/dartz.dart';
import 'package:diary/core/errors/errors.dart';
import 'package:diary/data/datasource/cart/cart_local_datasource/cart_local_datasource.dart';
import 'package:diary/domain/entities/medicament_entity.dart';

import '../../../core/errors/exceptions.dart';
import '../../../data/models/medicament_model.dart';

abstract class CartRepository {
  Future<Either<Failure, MedicamentEntity>> addMedicament(MedicamentEntity medicament);
  Future<Either<Failure, bool>> removeMedicament(int id);
  Future<Either<Failure, MedicamentEntity>> updateMedicamentQuantity(int id, int quantity);
  Future<Either<Failure, bool>> clearCart();
  Future<Either<Failure, List<MedicamentEntity>>> getCartItems();
}

class CartRepositoryImpl extends CartRepository {
  CartLocalDatasource _cartLocalDatasource;
  CartRepositoryImpl(this._cartLocalDatasource);
  @override
  Future<Either<Failure, MedicamentEntity>> addMedicament(MedicamentEntity medicament) async {
    try {
      await _cartLocalDatasource.addMedicament(medicament.toModel());

      return Right(medicament);
    } on CustomException catch (e) {
      return Left(CostumeFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> clearCart() async {
    try {
      await _cartLocalDatasource.clearCart();

      return const Right(true);
    } on CustomException catch (e) {
      return Left(CostumeFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, List<MedicamentEntity>>> getCartItems() async {
    try {
      final medicaments = await _cartLocalDatasource.getCartItems();

      return Right(medicaments.map((e) => e.toEntity()).toList());
    } on CustomException catch (e) {
      return Left(CostumeFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> removeMedicament(int id) async {
    try {
      await _cartLocalDatasource.removeMedicament(id);

      return const Right(true);
    } on CustomException catch (e) {
      return Left(CostumeFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, MedicamentEntity>> updateMedicamentQuantity(int id, int quantity) async {
    try {
      final medicament = await _cartLocalDatasource.updateMedicamentQuantity(id, quantity);

      return Right(medicament.toEntity());
    } on CustomException catch (e) {
      return Left(CostumeFailure(errorMessage: e.message));
    }
  }
}
