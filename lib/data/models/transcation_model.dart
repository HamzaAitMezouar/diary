import '../../domain/entities/transaction_entity.dart';

class TransactionModel {
  final String id;
  final String paymentMethodId;
  final double amount;
  final String currency;
  final String status;
  final String stripePaymentIntentId;
  final DateTime createdAt;

  TransactionModel({
    required this.id,
    required this.paymentMethodId,
    required this.amount,
    required this.currency,
    required this.status,
    required this.stripePaymentIntentId,
    required this.createdAt,
  });

  // Convert a JSON map to a Transaction object
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      paymentMethodId: json['paymentMethodId'],
      amount: json['amount']?.toDouble() ?? 0.0,
      currency: json['currency'],
      status: json['status'],
      stripePaymentIntentId: json['stripePaymentIntentId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // Convert a Transaction object to a JSON map
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

  // Convert to entity if needed (useful for other parts of the application)
  TransactionEntity toEntity() {
    return TransactionEntity(
      id: id,
      paymentMethodId: paymentMethodId,
      amount: amount,
      currency: currency,
      status: status,
      stripePaymentIntentId: stripePaymentIntentId,
      createdAt: createdAt,
    );
  }
}
