import 'package:dartz/dartz.dart';
import 'package:diary/domain/repositories/cart/cart_repository.dart';

import '../../../core/errors/errors.dart';
import '../../entities/cart_entity.dart';

class GetCartUseCase {
  final CartRepository repository;

  GetCartUseCase(this.repository);

  Future<Either<Failure, CartEntity>> call() {
    return repository.getCartItems();
  }
}
