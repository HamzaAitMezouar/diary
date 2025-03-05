import 'dart:developer';
import 'dart:io';

import 'package:diary/core/DI/storage_provider.dart';
import 'package:diary/core/constants/string.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MapStyleNotifier extends StateNotifier<String?> {
  final Ref _ref;
  MapStyleNotifier(this._ref) : super(null) {
    _initMapStyle();
  }
  final String whiteAndroidStyle = "assets/styles/map_style.txt";
  final String whiteIosStyle = "assets/styles/map_style.json";
  final String darkAndroidStyle = "assets/styles/dark_map_style.txt";
  final String darkIosStyle = "assets/styles/dark_map_style.json";
  _initMapStyle() {
    String? theme = _ref.read(sharedPreferencesHelperProvider).getString(AppStrings.ktheme) ?? "light";
    if (Platform.isAndroid) {
      rootBundle.loadString(theme == "white" ? whiteAndroidStyle : darkAndroidStyle).then((string) {
        state = string;
        log(state.toString());
      });
    } else {
      rootBundle.loadString(theme == "white" ? whiteIosStyle : darkIosStyle).then((string) {
        state = string;
        log(state.toString());
      });
    }
  }

  changeDeliveryType(String changedtheme) {
    if (Platform.isAndroid) {
      rootBundle.loadString(changedtheme == "white" ? whiteAndroidStyle : darkAndroidStyle).then((string) {
        state = string;
      });
    } else {
      rootBundle.loadString(changedtheme == "white" ? whiteIosStyle : darkIosStyle).then((string) {
        state = string;
      });
    }
  }
}

final mapStyleProvider = StateNotifierProvider<MapStyleNotifier, String?>(
  (ref) => MapStyleNotifier(ref),
);
