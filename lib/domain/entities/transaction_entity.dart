import 'package:diary/data/models/transcation_model.dart';

class TransactionEntity {
  final String id;
  final String paymentMethodId;
  final double amount;
  final String currency;
  final String status;
  final String stripePaymentIntentId;
  final DateTime createdAt;

  TransactionEntity({
    required this.id,
    required this.paymentMethodId,
    required this.amount,
    required this.currency,
    required this.status,
    required this.stripePaymentIntentId,
    required this.createdAt,
  });

  // Convert entity to model
  TransactionModel toModel() {
    return TransactionModel(
      id: id,
      paymentMethodId: paymentMethodId,
      amount: amount,
      currency: currency,
      status: status,
      stripePaymentIntentId: stripePaymentIntentId,
      createdAt: createdAt,
    );
  }

  // Convert entity to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'paymentMethodId': paymentMethodId,
      'amount': amount,
      'currency': currency,
      'status': status,
      'stripePaymentIntentId': stripePaymentIntentId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Convert JSON to entity
  static TransactionEntity fromJson(Map<String, dynamic> json) {
    return TransactionEntity(
      id: json['id'],
      paymentMethodId: json['paymentMethodId'],
      amount: json['amount']?.toDouble() ?? 0.0,
      currency: json['currency'],
      status: json['status'],
      stripePaymentIntentId: json['stripePaymentIntentId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
