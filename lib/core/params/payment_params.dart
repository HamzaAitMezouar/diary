class SaveCardParams {
  String cardNumber;
  String expMonth;
  String expYear;
  String cvc;
  SaveCardParams({
    required this.cardNumber,
    required this.cvc,
    required this.expMonth,
    required this.expYear,
  });
  Map<String, dynamic> toJson() {
    return {
      'cardNumber': cardNumber,
      'expMonth': expMonth,
      'expYear': expYear,
      'cvc': cvc,
    };
  }
}

class PayParams {
  String paymentMethodId;
  String amount;
  String currency;
  PayParams({
    required this.amount,
    required this.paymentMethodId,
    this.currency = "MAD",
  });
  Map<String, dynamic> toJson() {
    return {
      'paymentMethodId': paymentMethodId,
      'amount': amount,
      'currency': currency,
    };
  }
}
