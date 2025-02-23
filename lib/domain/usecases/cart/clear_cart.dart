import 'package:dartz/dartz.dart';
import 'package:diary/domain/repositories/cart/cart_repository.dart';
import 'package:diary/domain/repositories/medicament/medicament_repository.dart';

import '../../../core/errors/errors.dart';
import '../../entities/medicament_entity.dart';

class ClearCartUseCase {
  final CartRepository repository;

  ClearCartUseCase(this.repository);

  Future<Either<Failure, bool>> call() {
    return repository.clearCart();
  }
}
