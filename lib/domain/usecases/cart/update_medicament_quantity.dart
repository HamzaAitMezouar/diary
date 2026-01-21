import 'package:dartz/dartz.dart';
import 'package:diary/domain/repositories/cart/cart_repository.dart';

import '../../../core/errors/errors.dart';
import '../../entities/cart_entity.dart';

class UpdateMedicamentQuanityFromCartUseCase {
  final CartRepository repository;

  UpdateMedicamentQuanityFromCartUseCase(this.repository);

  Future<Either<Failure, CartEntity>> call(int id, quantity) {
    return repository.updateMedicamentQuantity(id, quantity);
  }
}
