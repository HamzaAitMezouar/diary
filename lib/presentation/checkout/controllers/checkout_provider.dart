import 'dart:developer';

import 'package:diary/domain/entities/checkout_entity.dart';
import 'package:diary/domain/entities/medicament_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedMedicineNotifier extends StateNotifier<CheckoutEntity?> {
  SelectedMedicineNotifier() : super(null);

  void selectCheckout(checkout) {
    state = checkout;
  }

  changeDeliveryType(DeliveryType type) {
    if (state == null) return;
    CheckoutEntity ch = state!.copyWith(deliveryType: type);
    state = ch;
    if (type == DeliveryType.home) {
      log("Get Adress");
    }
    if (type == DeliveryType.pharmacy) {
      log("Get Nearest Pharmacy");
      return;
    }
  }
}

final checkoutProvider = StateNotifierProvider<SelectedMedicineNotifier, CheckoutEntity?>(
  (ref) => SelectedMedicineNotifier(),
);
