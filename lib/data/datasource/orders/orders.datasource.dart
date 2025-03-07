import 'package:diary/core/params/orders_params.dart';
import 'package:diary/data/models/order_model.dart';
import 'package:dio/dio.dart';

import '../../../core/constants/urls.dart';
import '../../../core/helpers/either_error_handler.dart';

abstract class OrdersDatasource {
  Future<List<OrderModel>> addOrder(OrdersParams params);
  Future<List<OrderModel>> getOrder();
  Future<List<OrderModel>> updateOrder(int orderId, OrderStatus status);
  Future<OrderModel> acceptPharmacyOrder(int orderId, int pharmacyId);
}

class OrdersDatasourceImpl implements OrdersDatasource {
  final Dio _dio;
  final ExceptionsHandler _exceptionsHandler;
  OrdersDatasourceImpl(this._dio, this._exceptionsHandler);
  @override
  Future<List<OrderModel>> addOrder(OrdersParams params) {
    return _exceptionsHandler.dioExceptionsHandler(() async {
      var response = await _dio.post(
        Urls.orders,
        data: params.toJson(),
      );
      final List<dynamic> data = response.data;
      return data.map((e) => OrderModel.fromJson(e)).toList();
    });
  }

  @override
  Future<List<OrderModel>> getOrder() {
    return _exceptionsHandler.dioExceptionsHandler(() async {
      var response = await _dio.get(
        Urls.orders,
      );
      final List<dynamic> data = response.data;
      return data.map((e) => OrderModel.fromJson(e)).toList();
    });
  }

  @override
  Future<List<OrderModel>> updateOrder(int orderId, OrderStatus status) {
    return _exceptionsHandler.dioExceptionsHandler(() async {
      var response = await _dio.put(
        Urls.orders,
        data: {
          {"orderId": orderId, "status": status}
        },
      );
      final List<dynamic> data = response.data;
      return data.map((e) => OrderModel.fromJson(e)).toList();
    });
  }

  @override
  Future<OrderModel> acceptPharmacyOrder(int orderId, int pharmacyId) {
    return _exceptionsHandler.dioExceptionsHandler(() async {
      var response = await _dio.post(Urls.acceptPharmacyOrder, data: {"orderId": orderId, "pharmacyId": pharmacyId});

      return OrderModel.fromJson(response.data);
    });
  }
}
