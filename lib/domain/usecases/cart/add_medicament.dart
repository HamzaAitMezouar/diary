import 'package:dartz/dartz.dart';
import 'package:diary/domain/entities/cart_entity.dart';
import 'package:diary/domain/repositories/cart/cart_repository.dart';
import 'package:diary/domain/repositories/medicament/medicament_repository.dart';

import '../../../core/errors/errors.dart';
import '../../entities/medicament_entity.dart';

class AddMedicamentToCartUseCase {
  final CartRepository repository;

  AddMedicamentToCartUseCase(this.repository);

  Future<Either<Failure, CartEntity>> call(MedicamentEntity medicament) {
    return repository.addMedicament(medicament);
  }
}
