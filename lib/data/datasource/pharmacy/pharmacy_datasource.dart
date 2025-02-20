import 'dart:convert';

import 'package:diary/data/models/pharmacy_model.dart';
import 'package:dio/dio.dart';

import '../../../core/constants/urls.dart';
import '../../../core/helpers/either_error_handler.dart';

abstract class PharmacyDatasource {
  Future<List<PharmacyModel>> getNearestPharmacy(double lang, double lat);
}

class PharmacyDatasourceImpl implements PharmacyDatasource {
  final Dio _dio;
  final ExceptionsHandler _exceptionsHandler;
  PharmacyDatasourceImpl(this._dio, this._exceptionsHandler);
  @override
  Future<List<PharmacyModel>> getNearestPharmacy(double lang, double lat) {
    return _exceptionsHandler.dioExceptionsHandler(() async {
      var response = await _dio.get(
        data: json.encode({"latitude": lang, "longitude": lat}),
        Urls.pharmacy,
      );
      final List<dynamic> data = response.data;
      return data.map((e) => PharmacyModel.fromJson(e)).toList();
    });
  }
}
