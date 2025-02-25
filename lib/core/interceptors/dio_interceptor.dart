import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import '../../domain/repositories/token/token_repository.dart';
import '../../presentation/authentication/controllers/session_notifier.dart';
import '../helpers/secure_storage_helper.dart';

class AuthInterceptor extends Interceptor {
  final TokenRepository _tokenRepository;
  final Dio _dio;
  final SessionNotifier _sessionNotifier;
  final SecureStorageHelper secureStorageHelper;
  bool isRefreshing = false;
  Completer<void>? refreshCompleter; // Ensures only one refresh request runs at a time

  AuthInterceptor(this._dio, this._tokenRepository, this._sessionNotifier, this.secureStorageHelper);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await secureStorageHelper.getAccessToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      if (isRefreshing) {
        await refreshCompleter?.future;
      } else {
        isRefreshing = true;
        refreshCompleter = Completer<void>();

        final refreshResponse = await _tokenRepository.refreshToken();
        refreshResponse.fold((l) {
          _sessionNotifier.sessionExpired();
          refreshCompleter?.complete();
          isRefreshing = false;
          return handler.next(err);
        }, (r) async {
          log("----------------------------------------------" + r.accessToken.toString());
          if (r.accessToken == null || r.refreshToken == null) {
            refreshCompleter?.complete();
            isRefreshing = false;
            return handler.next(err);
          }

          // Save new token & retry the failed request
          await secureStorageHelper.saveAccessToken(r.accessToken!);
          await secureStorageHelper.saveRefreshToken(r.refreshToken!);
          err.requestOptions.headers['Authorization'] = 'Bearer ${r.accessToken}';

          try {
            final retryResponse = await _dio.fetch(err.requestOptions);
            handler.resolve(retryResponse);
          } on DioException catch (e) {
            handler.next(e);
          }

          refreshCompleter?.complete();
          isRefreshing = false;
        });
      }
    } else {
      handler.next(err);
    }
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
