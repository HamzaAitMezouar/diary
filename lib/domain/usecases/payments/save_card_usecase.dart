import 'package:dartz/dartz.dart';
import 'package:diary/domain/entities/payment_method_entity.dart';
import 'package:diary/domain/repositories/payments/payments_repository.dart';

import '../../../core/errors/errors.dart';
import '../../../core/params/payment_params.dart';

class AddPaymentMethodUseCase {
  final PaymentRepository repository;

  AddPaymentMethodUseCase(this.repository);

  Future<Either<Failure, PaymentMethodEntity>> call(SaveCardParams params) {
    return repository.saveCard(params);
  }
}
