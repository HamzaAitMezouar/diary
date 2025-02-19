import 'package:diary/core/DI/use_cases_provider.dart';
import 'package:diary/presentation/medicine/controllers/location_provider/location_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final positionProvider = StateNotifierProvider<LocatioNotifier, LocationState>(
  (ref) => LocatioNotifier(ref),
);

class LocatioNotifier extends StateNotifier<LocationState> {
  Ref ref;
  LocatioNotifier(this.ref) : super(InitLocationState()) {
    getUserLocation();
  }

  Future<void> getUserLocation() async {
    final res = await ref.read(getUserLocationUsecasesProvider)();
    state = res.fold((l) => LocationErrorState(l.errorMessage), (r) => UserLocationState(r));
  }
}
