import 'package:diary/data/models/payment_method.dart';

import 'transaction_entity.dart';

class PaymentMethodEntity {
  final String id;
  final String userId;
  final String stripePaymentMethodId;
  final List<TransactionEntity> transactions;
  final String date;
  final String codeFirstDigits;
  PaymentMethodEntity({
    required this.id,
    required this.userId,
    required this.stripePaymentMethodId,
    required this.transactions,
    required this.date,
    required this.codeFirstDigits,
  });

  // Convert entity to model

  // Convert entity to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'stripePaymentMethodId': stripePaymentMethodId,
      'transactions': transactions.map((transaction) => transaction.toJson()).toList(),
    };
  }

  // Convert model to entity
  PaymentMethodModel toModel() {
    return PaymentMethodModel(
      id: id,
      userId: userId,
      stripePaymentMethodId: stripePaymentMethodId,
      transactions: transactions.map((transaction) => transaction.toModel()).toList(),
      date: date,
      codeFirstDigits: codeFirstDigits,
    );
  }
}
