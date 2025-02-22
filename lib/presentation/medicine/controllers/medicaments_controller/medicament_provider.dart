import 'package:diary/core/DI/use_cases_provider.dart';
import 'package:diary/presentation/medicine/controllers/medicaments_controller/medicaments_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final medicamentProvider = StateNotifierProvider<HomeNotifier, MedicamentState>(
  (ref) => HomeNotifier(ref),
);

class HomeNotifier extends StateNotifier<MedicamentState> {
  Ref ref;
  HomeNotifier(this.ref) : super(const MedicamentLaoding()) {
    loadMedicament();
  }

  Future<void> loadMedicament() async {
    final res = await ref.read(getMedicamentUsecasesProvider)();
    state = res.fold((l) => MedicamentError(l.errorMessage), (r) => MedicamentLoaded(r));
  }
}
