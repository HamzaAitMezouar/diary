import 'package:diary/data/models/category_model.dart';
import 'package:diary/data/models/medicament_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/urls.dart';
import '../../../../core/helpers/either_error_handler.dart';

abstract class MedicamentsCategoryDatasource {
  Future<List<CategoryModel>> getCategories();
}

class MedicamentsCategoryDatasourceImpl implements MedicamentsCategoryDatasource {
  final Dio _dio;
  final ExceptionsHandler _exceptionsHandler;
  MedicamentsCategoryDatasourceImpl(this._dio, this._exceptionsHandler);
  @override
  Future<List<CategoryModel>> getCategories() {
    return _exceptionsHandler.dioExceptionsHandler(() async {
      var response = await _dio.get(
        Urls.category,
      );
      final List<dynamic> data = response.data;
      return data.map((e) => CategoryModel.fromJson(e)).toList();
    });
  }
}
