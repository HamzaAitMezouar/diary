import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:diary/core/errors/errors.dart';
import 'package:diary/data/datasource/payments/payment_datasource.dart';
import 'package:diary/domain/entities/payment_method_entity.dart';
import 'package:diary/domain/entities/transaction_entity.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/params/payment_params.dart';

abstract class PaymentRepository {
  Future<Either<Failure, PaymentMethodEntity>> saveCard(SaveCardParams params);
  Future<Either<Failure, TransactionEntity>> pay(PayParams params);
  Future<Either<Failure, List<PaymentMethodEntity>>> getUserPamentMethods();
}

class PaymentRepositoryImpl extends PaymentRepository {
  final PaymentDataSource _dataSource;
  PaymentRepositoryImpl(this._dataSource);
  @override
  Future<Either<Failure, List<PaymentMethodEntity>>> getUserPamentMethods() async {
    try {
      final result = await _dataSource.getUserPamentMethods();
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
  Future<Either<Failure, TransactionEntity>> pay(PayParams params) async {
    try {
      final result = await _dataSource.pay(params);
      return Right(result.toEntity());
    } on CustomException catch (e) {
      log(e.message);

      return Left(CostumeFailure(errorMessage: e.message));
    } on UnexpectedException catch (e) {
      log(e.message);

      return Left(UnexpectedFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, PaymentMethodEntity>> saveCard(SaveCardParams params) async {
    try {
      final result = await _dataSource.saveCard(params);
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
