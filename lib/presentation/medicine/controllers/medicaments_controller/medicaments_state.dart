import 'package:diary/domain/entities/medicament_entity.dart';

abstract class MedicamentState {
  const MedicamentState();
}

class MedicamentLaoding extends MedicamentState {
  const MedicamentLaoding();
}

class MedicamentError extends MedicamentState {
  final String errorMessage;
  const MedicamentError(this.errorMessage);
}

class MedicamentLoaded extends MedicamentState {
  final List<MedicamentEntity> medicaments;
  const MedicamentLoaded(this.medicaments);
}
