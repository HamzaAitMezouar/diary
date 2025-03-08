import 'dart:convert';

import 'package:diary/core/params/payment_params.dart';
import 'package:diary/data/models/payment_method.dart';
import 'package:dio/dio.dart';

import '../../../core/constants/urls.dart';
import '../../../core/helpers/either_error_handler.dart';
import '../../models/transcation_model.dart';

abstract class PaymentDataSource {
  Future<PaymentMethodModel> saveCard(SaveCardParams params);
  Future<TransactionModel> pay(PayParams params);
  Future<List<PaymentMethodModel>> getUserPamentMethods();
}

class PaymentDataSourceImpl extends PaymentDataSource {
  final Dio _dio;
  final ExceptionsHandler _exceptionsHandler;
  PaymentDataSourceImpl(this._dio, this._exceptionsHandler);
  @override
  Future<TransactionModel> pay(PayParams params) {
    return _exceptionsHandler.dioExceptionsHandler(() async {
      var response = await _dio.post(
        data: json.encode(params.toJson()),
        Urls.pay,
      );

      return TransactionModel.fromJson(response.data);
    });
  }

  @override
  Future<PaymentMethodModel> saveCard(SaveCardParams params) {
    return _exceptionsHandler.dioExceptionsHandler(() async {
      var response = await _dio.post(
        data: json.encode(params.toJson()),
        Urls.savecard,
      );

      return PaymentMethodModel.fromJson(response.data);
    });
  }

  @override
  Future<List<PaymentMethodModel>> getUserPamentMethods() {
    return _exceptionsHandler.dioExceptionsHandler(() async {
      var response = await _dio.get(
        Urls.payment,
      );
      final List<dynamic> data = response.data;
      return data.map((e) => PaymentMethodModel.fromJson(e)).toList();
    });
  }
}
