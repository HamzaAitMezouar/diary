import 'dart:developer';

import 'package:diary/core/DI/use_cases_provider.dart';
import 'package:diary/presentation/medicine/controllers/location_provider/position_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';

import '../../../../domain/entities/location_entity.dart';

final positionProvider = StateNotifierProvider<LocatioNotifier, LocationState>(
  (ref) => LocatioNotifier(ref),
);

class LocatioNotifier extends StateNotifier<LocationState> {
  Ref ref;
  LocatioNotifier(this.ref) : super(InitLocationState()) {
    getUserLocation().then(
      (value) => getNearestPharmacy(),
    );
  }

  Future<void> getUserLocation() async {
    final res = await ref.read(getUserLocationUsecasesProvider)();
    state = await res.fold((l) => LocationErrorState(l.errorMessage), (r) async {
      String? address = await _getAddressFromLatLng(r.latitude, r.longitude);
      log(address.toString());

      return UserLocationState(r.copyWith(address: address));
    });

    log(state.toString());
  }

  Future<void> manuallyEnterUserLocation(LocationEntity entiy) async {
    state = UserLocationState(entiy);

    log(state.toString());
  }

  Future getNearestPharmacy() async {
    if (state is UserLocationState) {
      UserLocationState currentState = state as UserLocationState;
      LocationEntity locationEntity = currentState.locationEntity;
      final res = await ref.read(getNearestPharmacyUsecasesProvider)(locationEntity.latitude, locationEntity.longitude);
      res.fold((l) => log(l.toString()), (r) {
        log(r.toString());
        if (r.isEmpty) return;

        state = UserLocationState(currentState.locationEntity.copyWith(pharmacy: r.first));
      });
    }
  }

  Future<String?> _getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;

        return "${place.street}, ${place.locality}, ${place.country}";
      }
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }
}
