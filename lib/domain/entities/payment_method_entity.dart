import 'package:diary/data/models/payment_method.dart';

import 'transaction_entity.dart';

class PaymentMethodEntity {
  final String id;
  final String userId;
  final String stripePaymentMethodId;
  final List<TransactionEntity> transactions;

  PaymentMethodEntity({
    required this.id,
    required this.userId,
    required this.stripePaymentMethodId,
    required this.transactions,
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
    );
  }

  // Convert JSON to entity
  static PaymentMethodEntity fromJson(Map<String, dynamic> json) {
    return PaymentMethodEntity(
      id: json['id'],
      userId: json['userId'],
      stripePaymentMethodId: json['stripePaymentMethodId'],
      transactions:
          (json['transactions'] as List).map((transactionJson) => TransactionEntity.fromJson(transactionJson)).toList(),
    );
  }
}
