import 'dart:developer';

import 'package:diary/core/DI/use_cases_provider.dart';
import 'package:diary/presentation/medicine/controllers/location_provider/location_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';

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
    state = await res.fold((l) => LocationErrorState(l.errorMessage), (r) async {
      String? address = await _getAddressFromLatLng(r.latitude, r.longitude);
      r.copyWith(address);
      return UserLocationState(r);
    });

    log(state.toString());
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
