import 'dart:developer';

import 'package:diary/core/DI/use_cases_provider.dart';
import 'package:diary/core/params/payment_params.dart';
import 'package:diary/presentation/credit_cards/controller/credit_cards_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final paymentMethodsProvider = StateNotifierProvider<PaymenthMethodsNotifier, PaymenthMethodsState>(
  (ref) => PaymenthMethodsNotifier(ref),
);

class PaymenthMethodsNotifier extends StateNotifier<PaymenthMethodsState> {
  Ref ref;
  PaymenthMethodsNotifier(this.ref) : super(PaymenthMethodsState([], false)) {
    loeadPaymentMethods();
  }

  /// 📌 Load Reminders from Hive
  Future<void> loeadPaymentMethods() async {
    final res = await ref.read(getPaymenthMethodsUseCase)();
    res.fold((l) => log(l.errorMessage), (r) {
      state = PaymenthMethodsState(r, false);
    });
  }

  Future<void> addPaymentMethod(SaveCardParams params) async {
    state = state.copyWith(addCreditCardLoading: true);
    final res = await ref.read(addPaymenthMethodsUseCase)(params);
    res.fold((l) => log(l.errorMessage), (r) {
      loeadPaymentMethods();
    });
  }

  Future<void> pay(PayParams params) async {
    state = state.copyWith(addCreditCardLoading: true);
    final res = await ref.read(payUseCase)(params);
    res.fold((l) => log(l.errorMessage), (r) {
      //    loeadPaymentMethods();
      state = state.copyWith(isPaymentSuccesfull: true);
    });
  }
}
