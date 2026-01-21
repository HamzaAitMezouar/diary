import 'package:diary/domain/entities/payment_method_entity.dart';

class PaymenthMethodsState {
  List<PaymentMethodEntity> paymentMethods;
  bool addCreditCardLoading = false;
  bool? isPaymentSuccesfull = false;
  bool? wasSuccessfullyAdded = false;

  PaymenthMethodsState(this.paymentMethods, this.addCreditCardLoading,
      {this.isPaymentSuccesfull, this.wasSuccessfullyAdded});
  PaymenthMethodsState copyWith({
    List<PaymentMethodEntity>? paymentMethods,
    bool? addCreditCardLoading,
    bool? isPaymentSuccesfull,
    bool? wasSuccessfullyAdded,
  }) =>
      PaymenthMethodsState(
        paymentMethods ?? this.paymentMethods,
        addCreditCardLoading ?? this.addCreditCardLoading,
        isPaymentSuccesfull: isPaymentSuccesfull ?? this.isPaymentSuccesfull,
        wasSuccessfullyAdded: wasSuccessfullyAdded ?? this.wasSuccessfullyAdded,
      );
}
