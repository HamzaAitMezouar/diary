import 'package:dartz/dartz.dart';
import 'package:diary/domain/repositories/medicament/medicament_repository.dart';

import '../../../core/errors/errors.dart';
import '../../entities/medicament_entity.dart';

class GetMedicamentsUseCase {
  final MedicamentRepository repository;

  GetMedicamentsUseCase(this.repository);

  Future<Either<Failure, List<MedicamentEntity>>> call() {
    return repository.getMedicaments();
  }
}
