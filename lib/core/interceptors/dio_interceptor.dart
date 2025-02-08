import 'package:diary/core/DI/locator.dart';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import '../../domain/repositories/token/token_repository.dart';

class AuthInterceptor extends Interceptor {
  final TokenRepository _tokenRepository;
  final Dio _dio;
  AuthInterceptor(this._dio, this._tokenRepository);
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final response = await _tokenRepository.refreshToken();
      response.fold((l) => handler.next(err), (r) async {
        try {
          if (r.accessToken == null && r.refreshToken == null) return handler.next(err);

          err.requestOptions.headers['Authorization'] = 'Bearer ${r.accessToken}';
          final response = await _dio.fetch(err.requestOptions);
          return handler.resolve(response);
        } on DioException catch (e) {
          return handler.next(e);
        }
      });
    }
    handler.next(err);
  }
}

class RetryInterceptorCustom extends RetryInterceptor {
  RetryInterceptorCustom({required super.dio})
      : super(
          retries: 2,
          retryDelays: [
            const Duration(seconds: 2),
            const Duration(seconds: 5),
          ],
          retryableExtraStatuses: {500, 502, 503},
        );
}
