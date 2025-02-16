import 'package:dartz/dartz.dart';
import 'package:diary/domain/repositories/medicament_category/medicament_category_repository.dart';

import '../../../core/errors/errors.dart';
import '../../entities/category_entity.dart';

class GetMedicamentsCaregoryUsecase {
  final MedicamentCategoryRepository repository;

  GetMedicamentsCaregoryUsecase(this.repository);

  Future<Either<Failure, List<CategoryEntity>>> call() {
    return repository.getCategories();
  }
}
