import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:diary/data/datasource/orders/orders.datasource.dart';
import 'package:diary/domain/entities/order_entity.dart';

import '../../../core/errors/errors.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/params/orders_params.dart';
import '../../../data/models/order_model.dart';

abstract class OrdersRepository {
  Future<Either<Failure, List<OrderEntity>>> addOrder(OrdersParams params);
  Future<Either<Failure, List<OrderEntity>>> getOrder();
  Future<Either<Failure, List<OrderEntity>>> updateOrder(int orderId, OrderStatus status);
  Future<Either<Failure, OrderEntity>> acceptPharmacyOrder(int orderId, int pharmacyId);
}

class OrdersRepositoryImpl extends OrdersRepository {
  final OrdersDatasource _datasource;
  OrdersRepositoryImpl(this._datasource);
  @override
  Future<Either<Failure, List<OrderEntity>>> addOrder(OrdersParams params) async {
    try {
      final result = await _datasource.addOrder(params);
      return Right(result.map((e) => e.toEntity()).toList());
    } on CustomException catch (e) {
      log(e.message);

      return Left(CostumeFailure(errorMessage: e.message));
    } on UnexpectedException catch (e) {
      log(e.message);

      return Left(UnexpectedFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrder() async {
    try {
      final result = await _datasource.getOrder();
      return Right(result.map((e) => e.toEntity()).toList());
    } on CustomException catch (e) {
      log(e.message);

      return Left(CostumeFailure(errorMessage: e.message));
    } on UnexpectedException catch (e) {
      log(e.message);

      return Left(UnexpectedFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> updateOrder(int orderId, OrderStatus status) async {
    try {
      final result = await _datasource.updateOrder(orderId, status);
      return Right(result.map((e) => e.toEntity()).toList());
    } on CustomException catch (e) {
      log(e.message);

      return Left(CostumeFailure(errorMessage: e.message));
    } on UnexpectedException catch (e) {
      log(e.message);

      return Left(UnexpectedFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, OrderEntity>> acceptPharmacyOrder(int orderId, int pharmacyId) async {
    try {
      final result = await _datasource.acceptPharmacyOrder(orderId, pharmacyId);
      return Right(result.toEntity());
    } on CustomException catch (e) {
      log(e.message);

      return Left(CostumeFailure(errorMessage: e.message));
    } on UnexpectedException catch (e) {
      log(e.message);

      return Left(UnexpectedFailure(errorMessage: e.message));
    }
  }
}
