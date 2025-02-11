import 'package:diary/core/constants/urls.dart';
import 'package:diary/domain/repositories/token/token_repository.dart';
import 'package:diary/presentation/authentication/controllers/session_notifier.dart';
import 'package:dio/dio.dart';

import '../interceptors/dio_interceptor.dart';

class PublicDio {
  Dio call() {
    Dio dio = Dio(BaseOptions(
      baseUrl: Urls.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));
    dio.interceptors.add(RetryInterceptorCustom(dio: dio));

    return dio;
  }
}

class AuthDio {
  final TokenRepository _tokenRepository;
  final SessionNotifier _sessionNotifier;
  AuthDio(this._tokenRepository, this._sessionNotifier);
  Dio call() {
    Dio dio = Dio(BaseOptions(
      baseUrl: Urls.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));
    dio.interceptors.add(AuthInterceptor(dio, _tokenRepository, _sessionNotifier));

    dio.interceptors.add(RetryInterceptorCustom(dio: dio));

    return dio;
  }
}
