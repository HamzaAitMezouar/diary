
import 'package:diary/data/models/medicament_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/urls.dart';
import '../../../../core/helpers/either_error_handler.dart';

abstract class MedicamentRemoteDatasource {
  Future<List<MedicamentModel>> getMedicaments();
}

class MedicamentRemoteDatasourceImpl implements MedicamentRemoteDatasource {
  final Dio _dio;
  final ExceptionsHandler _exceptionsHandler;
  MedicamentRemoteDatasourceImpl(this._dio, this._exceptionsHandler);
  @override
  Future<List<MedicamentModel>> getMedicaments() {
    return _exceptionsHandler.dioExceptionsHandler(() async {
      var response = await _dio.get(
        Urls.medicament,
      );
      final List<dynamic> data = response.data;
      return data.map((e) => MedicamentModel.fromJson(e)).toList();
    });
  }
}
