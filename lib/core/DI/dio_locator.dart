import 'package:diary/core/constants/urls.dart';
import 'package:dio/dio.dart';

import '../interceptors/dio_interceptor.dart';

class DioLocator {
  DioLocator();

  Dio _createDio() {
    return Dio(BaseOptions(
      baseUrl: Urls.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));
  }

  Dio createPublicDio() {
    final dio = _createDio();
    dio.interceptors.add(RetryInterceptorCustom(dio: dio));

    return dio;
  }

  Dio createAuthDio() {
    final dio = _createDio();

    dio.interceptors.add(AuthInterceptor());

    dio.interceptors.add(RetryInterceptorCustom(dio: dio));

    return dio;
  }
}
