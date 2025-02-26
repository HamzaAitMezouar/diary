import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:diary/core/errors/errors.dart';
import 'package:diary/data/datasource/cart/cart_local_datasource/cart_local_datasource.dart';
import 'package:diary/data/models/cart_model.dart';
import 'package:diary/domain/entities/cart_entity.dart';
import 'package:diary/domain/entities/medicament_entity.dart';

import '../../../core/errors/exceptions.dart';
import '../../../data/models/medicament_model.dart';

abstract class CartRepository {
  Future<Either<Failure, CartEntity>> addMedicament(CartItemEntity cartItem);
  Future<Either<Failure, CartEntity>> removeMedicament(int id);
  Future<Either<Failure, CartEntity>> updateMedicamentQuantity(int id, int quantity);
  Future<Either<Failure, CartEntity>> clearCart();
  Future<Either<Failure, CartEntity>> getCartItems();
}

class CartRepositoryImpl extends CartRepository {
  final CartLocalDatasource _cartLocalDatasource;
  CartRepositoryImpl(this._cartLocalDatasource);
  @override
  Future<Either<Failure, CartEntity>> addMedicament(CartItemEntity cartItem) async {
    try {
      final cart = await _cartLocalDatasource.addMedicament(cartItem.toModel());

      return Right(cart.toEntity());
    } on CustomException catch (e) {
      return Left(CostumeFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> clearCart() async {
    try {
      final cart = await _cartLocalDatasource.clearCart();

      return Right(cart.toEntity());
    } on CustomException catch (e) {
      return Left(CostumeFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> getCartItems() async {
    try {
      final cart = await _cartLocalDatasource.getCartItems();

      return Right(cart.toEntity());
    } on CustomException catch (e) {
      return Left(CostumeFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> removeMedicament(int id) async {
    try {
      final cart = await _cartLocalDatasource.removeMedicament(id);

      return Right(cart.toEntity());
    } on CustomException catch (e) {
      return Left(CostumeFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> updateMedicamentQuantity(int id, int quantity) async {
    try {
      final cart = await _cartLocalDatasource.updateMedicamentQuantity(id, quantity);

      return Right(cart.toEntity());
    } on CustomException catch (e) {
      return Left(CostumeFailure(errorMessage: e.message));
    }
  }
}
