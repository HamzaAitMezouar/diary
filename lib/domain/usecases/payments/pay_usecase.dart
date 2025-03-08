import 'package:dartz/dartz.dart';
import 'package:diary/domain/entities/payment_method_entity.dart';
import 'package:diary/domain/entities/transaction_entity.dart';
import 'package:diary/domain/repositories/payments/payments_repository.dart';

import '../../../core/errors/errors.dart';
import '../../../core/params/payment_params.dart';

class PayUseCase {
  final PaymentRepository repository;

  PayUseCase(this.repository);

  Future<Either<Failure, TransactionEntity>> call(PayParams params) {
    return repository.pay(params);
  }
}
