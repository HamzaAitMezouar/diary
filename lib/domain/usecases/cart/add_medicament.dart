import 'package:dartz/dartz.dart';
import 'package:diary/domain/repositories/cart/cart_repository.dart';
import 'package:diary/domain/repositories/medicament/medicament_repository.dart';

import '../../../core/errors/errors.dart';
import '../../entities/medicament_entity.dart';

class AddMedicamentToCartUseCase {
  final CartRepository repository;

  AddMedicamentToCartUseCase(this.repository);

  Future<Either<Failure, MedicamentEntity>> call(MedicamentEntity medicament) {
    return repository.addMedicament(medicament);
  }
}
