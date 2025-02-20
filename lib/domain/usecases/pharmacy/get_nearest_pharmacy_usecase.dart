import 'package:dartz/dartz.dart';
import 'package:diary/domain/entities/pharmacy_entiy.dart';
import 'package:diary/domain/repositories/pharmacy/pharmacy_repositoy.dart';

import '../../../core/errors/errors.dart';

class GetNearestPharmacyUseCase {
  final PharmacyRepository repository;

  GetNearestPharmacyUseCase(this.repository);

  Future<Either<Failure, List<PharmacyEntity>>> call(double lat, double lang) {
    return repository.getNearestPharmacy(lat, lang);
  }
}
