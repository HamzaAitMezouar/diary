import 'package:dartz/dartz.dart';
import 'package:diary/domain/entities/payment_method_entity.dart';
import 'package:diary/domain/repositories/payments/payments_repository.dart';

import '../../../core/errors/errors.dart';

class GetPaymentMethodsUseCase {
  final PaymentRepository repository;

  GetPaymentMethodsUseCase(this.repository);

  Future<Either<Failure, List<PaymentMethodEntity>>> call() {
    return repository.getUserPamentMethods();
  }
}
