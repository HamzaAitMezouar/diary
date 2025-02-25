import 'dart:developer';

import 'package:diary/domain/entities/checkout_entity.dart';
import 'package:diary/domain/entities/location_entity.dart';
import 'package:diary/presentation/medicine/controllers/position_provider/position_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedMedicineNotifier extends StateNotifier<CheckoutEntity?> {
  SelectedMedicineNotifier(this.ref) : super(null);
  final Ref ref;
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
      return;
    }
  }

  changeDeliveryScheduleType(Deliveryschedule deliveryschedule) {
    CheckoutEntity ch = state!.copyWith(deliveryschedule: deliveryschedule);
    state = ch;
  }

  changeDeliveryTime(DateTime time) {
    CheckoutEntity ch = state!.copyWith(deliveryTime: time);
    state = ch;
  }

  changePaymentType(PaymentType type) {
    CheckoutEntity ch = state!.copyWith(paymentType: type);
    state = ch;
  }

  changeLangLatAndAdress(LocationEntity locationEntity) {
    CheckoutEntity ch = state!.copyWith(address: locationEntity);
    state = ch;
  }

  changeDeliveryAdress(LocationEntity entity) {
    if (state == null) return;
    CheckoutEntity ch = state!.copyWith(address: entity, deliveryType: DeliveryType.home);
    state = ch;
    ref.read(positionProvider.notifier).manuallyEnterUserLocation(entity);
  }
}

final checkoutProvider = StateNotifierProvider<SelectedMedicineNotifier, CheckoutEntity?>(
  (ref) => SelectedMedicineNotifier(ref),
);
