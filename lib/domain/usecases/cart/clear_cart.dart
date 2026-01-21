import 'package:dartz/dartz.dart';
import 'package:diary/domain/repositories/cart/cart_repository.dart';

import '../../../core/errors/errors.dart';
import '../../entities/cart_entity.dart';

class ClearCartUseCase {
  final CartRepository repository;

  ClearCartUseCase(this.repository);

  Future<Either<Failure, CartEntity>> call() {
    return repository.clearCart();
  }
}
