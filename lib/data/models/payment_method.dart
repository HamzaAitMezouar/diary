import 'package:diary/data/models/transcation_model.dart';

import '../../domain/entities/payment_method_entity.dart';

class PaymentMethodModel {
  final String id;
  final String userId;
  final String stripePaymentMethodId;
  final List<TransactionModel> transactions;
  final String date;
  final String codeFirstDigits;
  PaymentMethodModel({
    required this.id,
    required this.userId,
    required this.stripePaymentMethodId,
    required this.transactions,
    required this.date,
    required this.codeFirstDigits,
  });

  // Convert a JSON map to a PaymentMethod object
  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'],
      userId: json['userId'],
      date: json['date'],
      codeFirstDigits: json['codeFirstDigits'],
      stripePaymentMethodId: json['stripePaymentMethodId'],
      transactions:
          (json['transactions'] as List).map((transactionJson) => TransactionModel.fromJson(transactionJson)).toList(),
    );
  }

  // Convert to entity if needed (useful for other parts of the application)
  PaymentMethodEntity toEntity() {
    return PaymentMethodEntity(
      id: id,
      userId: userId,
      stripePaymentMethodId: stripePaymentMethodId,
      transactions: transactions.map((transaction) => transaction.toEntity()).toList(),
      date: date,
      codeFirstDigits: codeFirstDigits,
    );
  }
}
