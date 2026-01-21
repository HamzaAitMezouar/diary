import 'package:dartz/dartz.dart';
import 'package:diary/domain/entities/cart_entity.dart';
import 'package:diary/domain/repositories/cart/cart_repository.dart';

import '../../../core/errors/errors.dart';

class AddMedicamentToCartUseCase {
  final CartRepository repository;

  AddMedicamentToCartUseCase(this.repository);

  Future<Either<Failure, CartEntity>> call(CartItemEntity cartItemEntity) {
    return repository.addMedicament(cartItemEntity);
  }
}
